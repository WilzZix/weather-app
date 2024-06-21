import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        leading: const Icon(Icons.menu),
        actions: const [
          Text('San Diego, USA'),
          Icon(Icons.keyboard_arrow_down)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '17',
                            style: TextStyle(fontSize: 46, color: Colors.blue),
                          ),
                          Icon(Icons.cloud_done)
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Clear'),
                              Text('Feels like 15'),
                            ],
                          ),
                          Text('Max 20, Min 10')
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        height: 2,
                        decoration: const BoxDecoration(color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 90,
                        child: ListView.builder(
                          itemCount: 20,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return const Padding(
                              padding: EdgeInsets.only(right: 16.0),
                              child: Column(
                                children: [
                                  Text('+15'),
                                  SizedBox(height: 8),
                                  Icon(Icons.cloud_done),
                                  SizedBox(height: 8),
                                  Text('Now'),
                                  SizedBox(height: 8),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '10 days forecast',
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    'View details',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ListView.builder(
                  itemCount: 15,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: const Row(
                              children: [
                                Column(
                                  children: [Text('Today'), Text('Clear')],
                                ),
                                Spacer(),
                                Icon(Icons.cloud_done),
                                SizedBox(width: 8),
                                Text('+20/+10'),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                      ],
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
