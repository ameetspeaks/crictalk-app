import 'package:flutter/material.dart';
import '../../../shared/widgets/gradient_background.dart';

class CreateTournamentScreen extends StatefulWidget {
  const CreateTournamentScreen({super.key});

  @override
  State<CreateTournamentScreen> createState() => _CreateTournamentScreenState();
}

class _CreateTournamentScreenState extends State<CreateTournamentScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _groundController = TextEditingController();
  final TextEditingController _organizerNameController = TextEditingController();
  final TextEditingController _organizerMobileController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  String _selectedCategory = 'Corporate';
  String _selectedBallType = 'Tennis';
  String _selectedPitchType = 'Road';
  String _selectedMatchType = 'Limited Overs';

  @override
  void dispose() {
    _nameController.dispose();
    _cityController.dispose();
    _groundController.dispose();
    _organizerNameController.dispose();
    _organizerMobileController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Create Tournament/Series', style: TextStyle(color: Colors.white)),
      ),
      body: GradientBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Add logo functionality
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add_photo_alternate,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Logo',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Add banner functionality
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.add_photo_alternate,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Banner',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _nameController,
                    label: 'Tournament/Series Name*',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter tournament name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _cityController,
                    label: 'City*',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter city';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _groundController,
                    label: 'Ground*',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter ground';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _organizerNameController,
                    label: 'Organizer Name*',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter organizer name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _organizerMobileController,
                    label: 'Organizer Mobile No*',
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter organizer mobile number';
                      }
                      if (value.length != 10) {
                        return 'Please enter a valid 10-digit mobile number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tournament Dates*',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildDateField(
                                    controller: _startDateController,
                                    label: 'Start Date',
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _buildDateField(
                                    controller: _endDateController,
                                    label: 'End Date',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Category*',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildCategorySelector(),
                  const SizedBox(height: 16),
                  const Text(
                    'Ball Type*',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildBallTypeSelector(),
                  const SizedBox(height: 16),
                  const Text(
                    'Pitch Type*',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildPitchTypeSelector(),
                  const SizedBox(height: 16),
                  const Text(
                    'Match Type*',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildMatchTypeSelector(),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TournamentDetailsScreen(),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Create Tournament',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (date != null) {
          controller.text = '${date.day}-${date.month}-${date.year}';
        }
      },
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: label,
        hintStyle: const TextStyle(color: Colors.white70),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildCategorySelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildCategoryChip('Corporate'),
        _buildCategoryChip('Community'),
        _buildCategoryChip('Series'),
        _buildCategoryChip('Other'),
      ],
    );
  }

  Widget _buildCategoryChip(String category) {
    final isSelected = _selectedCategory == category;
    return ChoiceChip(
      label: Text(category),
      selected: isSelected,
      selectedColor: Colors.orange,
      backgroundColor: Colors.black.withOpacity(0.3),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.white70,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedCategory = category;
          });
        }
      },
    );
  }

  Widget _buildBallTypeSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildBallTypeChip('Tennis', Icons.sports_tennis),
        _buildBallTypeChip('Leather', Icons.sports_cricket),
      ],
    );
  }

  Widget _buildBallTypeChip(String type, IconData icon) {
    final isSelected = _selectedBallType == type;
    return ChoiceChip(
      avatar: Icon(
        icon,
        color: isSelected ? Colors.white : Colors.white70,
        size: 16,
      ),
      label: Text(type),
      selected: isSelected,
      selectedColor: Colors.orange,
      backgroundColor: Colors.black.withOpacity(0.3),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.white70,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedBallType = type;
          });
        }
      },
    );
  }

  Widget _buildPitchTypeSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildPitchTypeChip('Road'),
        _buildPitchTypeChip('Cement'),
        _buildPitchTypeChip('Matt'),
        _buildPitchTypeChip('Turf'),
      ],
    );
  }

  Widget _buildPitchTypeChip(String type) {
    final isSelected = _selectedPitchType == type;
    return ChoiceChip(
      label: Text(type),
      selected: isSelected,
      selectedColor: Colors.orange,
      backgroundColor: Colors.black.withOpacity(0.3),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.white70,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedPitchType = type;
          });
        }
      },
    );
  }

  Widget _buildMatchTypeSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildMatchTypeChip('Limited Overs'),
        _buildMatchTypeChip('Box/Turf'),
        _buildMatchTypeChip('Test'),
        _buildMatchTypeChip('Other'),
      ],
    );
  }

  Widget _buildMatchTypeChip(String type) {
    final isSelected = _selectedMatchType == type;
    return ChoiceChip(
      label: Text(type),
      selected: isSelected,
      selectedColor: Colors.orange,
      backgroundColor: Colors.black.withOpacity(0.3),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.white70,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedMatchType = type;
          });
        }
      },
    );
  }
}

class TournamentDetailsScreen extends StatefulWidget {
  const TournamentDetailsScreen({super.key});

  @override
  State<TournamentDetailsScreen> createState() => _TournamentDetailsScreenState();
}

class _TournamentDetailsScreenState extends State<TournamentDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _teamsController = TextEditingController();
  final TextEditingController _feeController = TextEditingController();

  String _selectedFeeType = 'Free';
  String _selectedPrize = 'Cash';
  String _selectedMatchDays = 'WEEKENDS';
  List<String> _selectedDays = ['SAT', 'SUN'];
  String _selectedMatchTiming = 'DAY';
  String _selectedFormat = 'LEAGUE';

  @override
  void dispose() {
    _teamsController.dispose();
    _feeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Tournament/Series Details', style: TextStyle(color: Colors.white)),
      ),
      body: GradientBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tournament/Series fees*',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildFeeTypeChip('Free'),
                      const SizedBox(width: 8),
                      _buildFeeTypeChip('Paid'),
                      const SizedBox(width: 16),
                      const Text(
                        '₹',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          controller: _feeController,
                          keyboardType: TextInputType.number,
                          enabled: _selectedFeeType == 'Paid',
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: '____',
                            hintStyle: TextStyle(color: Colors.white70),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '/',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          'Match',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _teamsController,
                    label: 'Total No of Teams*',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter number of teams';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Winning Prize*',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildPrizeSelector(),
                  const SizedBox(height: 16),
                  const Text(
                    'Match on*',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildMatchDaysSelector(),
                  const SizedBox(height: 8),
                  _buildDaysSelector(),
                  const SizedBox(height: 16),
                  const Text(
                    'Match Timings*',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildMatchTimingSelector(),
                  const SizedBox(height: 16),
                  const Text(
                    'Tournament Format*',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildFormatSelector(),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        ),
                        child: const Text('SKIP'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TournamentSuccessScreen(),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        ),
                        child: const Text('CONTINUE'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeeTypeChip(String type) {
    final isSelected = _selectedFeeType == type;
    return ChoiceChip(
      label: Text(type),
      selected: isSelected,
      selectedColor: Colors.black,
      backgroundColor: Colors.black.withOpacity(0.3),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.white70,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedFeeType = type;
          });
        }
      },
    );
  }

  Widget _buildPrizeSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildPrizeChip('Cash'),
        _buildPrizeChip('Trophy'),
        _buildPrizeChip('Both'),
      ],
    );
  }

  Widget _buildPrizeChip(String type) {
    final isSelected = _selectedPrize == type;
    return ChoiceChip(
      label: Text(type),
      selected: isSelected,
      selectedColor: Colors.orange,
      backgroundColor: Colors.black.withOpacity(0.3),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.white70,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedPrize = type;
          });
        }
      },
    );
  }

  Widget _buildMatchDaysSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildMatchDaysChip('WEEKENDS'),
        _buildMatchDaysChip('WEEKDAYS'),
        _buildMatchDaysChip('ALL DAYS'),
      ],
    );
  }

  Widget _buildMatchDaysChip(String type) {
    final isSelected = _selectedMatchDays == type;
    return ChoiceChip(
      label: Text(type),
      selected: isSelected,
      selectedColor: Colors.orange,
      backgroundColor: Colors.black.withOpacity(0.3),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.white70,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedMatchDays = type;
            if (type == 'WEEKENDS') {
              _selectedDays = ['SAT', 'SUN'];
            } else if (type == 'WEEKDAYS') {
              _selectedDays = ['MON', 'TUE', 'WED', 'THU', 'FRI'];
            } else {
              _selectedDays = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
            }
          });
        }
      },
    );
  }

  Widget _buildDaysSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildDayChip('MON'),
        _buildDayChip('TUE'),
        _buildDayChip('WED'),
        _buildDayChip('THU'),
        _buildDayChip('FRI'),
        _buildDayChip('SAT'),
        _buildDayChip('SUN'),
      ],
    );
  }

  Widget _buildDayChip(String day) {
    final isSelected = _selectedDays.contains(day);
    return FilterChip(
      label: Text(day),
      selected: isSelected,
      selectedColor: Colors.orange,
      backgroundColor: Colors.black.withOpacity(0.3),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.white70,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      onSelected: (selected) {
        setState(() {
          if (selected) {
            _selectedDays.add(day);
          } else {
            _selectedDays.remove(day);
          }
        });
      },
    );
  }

  Widget _buildMatchTimingSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildMatchTimingChip('DAY'),
        _buildMatchTimingChip('NIGHT'),
        _buildMatchTimingChip('DAY & NIGHT'),
      ],
    );
  }

  Widget _buildMatchTimingChip(String type) {
    final isSelected = _selectedMatchTiming == type;
    return ChoiceChip(
      label: Text(type),
      selected: isSelected,
      selectedColor: Colors.orange,
      backgroundColor: Colors.black.withOpacity(0.3),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.white70,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedMatchTiming = type;
          });
        }
      },
    );
  }

  Widget _buildFormatSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildFormatChip('LEAGUE'),
        _buildFormatChip('KNOCKOUT'),
      ],
    );
  }

  Widget _buildFormatChip(String type) {
    final isSelected = _selectedFormat == type;
    return ChoiceChip(
      label: Text(type),
      selected: isSelected,
      selectedColor: Colors.orange,
      backgroundColor: Colors.black.withOpacity(0.3),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.white70,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedFormat = type;
          });
        }
      },
    );
  }
}

class TournamentSuccessScreen extends StatelessWidget {
  const TournamentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.celebration,
                  size: 64,
                  color: Colors.orange,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Congratulations!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'You have created Tournament!\nLet\'s Continue...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TournamentDashboardScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Complete Setup',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

