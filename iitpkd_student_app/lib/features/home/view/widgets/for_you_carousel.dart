import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class ForYouCarousel extends StatelessWidget {
  const ForYouCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final items = [
      ForYouItem(
        title: 'IIT Palakkad Portal',
        description: 'Access academic resources and information',
        icon: Icons.school,
        color: Colors.blue,
        url: 'https://iitpkd.ac.in',
      ),
      ForYouItem(
        title: 'Student Portal',
        description: 'View grades, courses, and academic records',
        icon: Icons.assignment,
        color: Colors.orange,
        url: 'https://records.iitpkd.ac.in',
      ),
      ForYouItem(
        title: 'Library',
        description: 'Access digital library and resources',
        icon: Icons.local_library,
        color: Colors.purple,
        url: 'https://iitpkd.ac.in/library',
      ),
      ForYouItem(
        title: 'Campus Life',
        description: 'Explore clubs, events, and activities',
        icon: Icons.event,
        color: Colors.green,
        url: 'https://iitpkd.ac.in/campus-life',
      ),
      ForYouItem(
        title: 'Placements',
        description: 'Career development and placement resources',
        icon: Icons.work,
        color: Colors.red,
        url: 'https://iitpkd.ac.in/placements',
      ),
    ];

    return CarouselSlider.builder(
      itemCount: items.length,
      itemBuilder: (context, index, realIndex) {
        final item = items[index];
        return _ForYouCard(item: item);
      },
      options: CarouselOptions(
        height: 180,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        viewportFraction: 0.85,
      ),
    );
  }
}

class _ForYouCard extends StatelessWidget {
  final ForYouItem item;

  const _ForYouCard({required this.item});

  Future<void> _launchUrl(String urlString) async {
    final url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => _launchUrl(item.url),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                item.color.withOpacity(0.8),
                item.color,
              ],
            ),
          ),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  item.icon,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'Know more',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ForYouItem {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String url;

  ForYouItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.url,
  });
}
