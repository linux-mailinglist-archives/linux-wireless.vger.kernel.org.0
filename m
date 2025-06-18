Return-Path: <linux-wireless+bounces-24237-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7058AADE522
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 10:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5C1189A2DE
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 08:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11BB201266;
	Wed, 18 Jun 2025 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CTeHUgyz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A9478F36
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 08:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750234037; cv=fail; b=BSsYBP14xFJdO+yTounL+BFIvzR/UVyH2frl52olRILZPgSxtkjQXWR1iLd7KIuQDi9/K7uorZVIThCU0pqZ67dfHXmfVCk1B61t4Czs/VD92nsKAwxE61CxBRWFlofiqk0ePkYfZW6bFACVIv3WRLqF8zjOXM3UHfVZIaTybXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750234037; c=relaxed/simple;
	bh=JCDI6YtbGOFgV5XBFWkcHCa96waATOWIH4Ndu4lUiNg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Au6/9OJ/BFamoK9ViNYhzJCyiUC/fxNTLqfd9/IKgy8uKwFzxGJ1cUTdqxNzjd9A/aJ5o6Vm0rcjZwhnX3/RexwzR2GpjcUoEcD+Bv11DadwLg8kbYkGEp9+1aIs0VU9r7BC2oXgM3P8OAkIcz75c7lkZXWba0r7tVwKILV5Ct4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CTeHUgyz; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750234036; x=1781770036;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=JCDI6YtbGOFgV5XBFWkcHCa96waATOWIH4Ndu4lUiNg=;
  b=CTeHUgyzYHq3qjIKxzyBr004i8MNmYRdBGwDF/rgr5C1jV/0mmk4d5ej
   W6lVoUJ4ISynEe7kwcVHlapTPdpDdTpemNpq1t3NmcEhaflNYWaGLdsjt
   AaBckI/p4/vjBGhFdNiLEBSrdaVKO9S8AWdeOHGjXfI3serYcrpDWawYl
   +dJ50it9Z2/U2CHTke08rCXmKtdlMMdR0ukLx9HCY3m4XQ56dZek2Ho48
   wOYPPmUfnNNhBexXNUxde7SxFOBhl4HdpSMU0DeKNRglHAo7KqvaTzaw1
   cghCtjTYyO/ugj9miq7/IzPzFv8+wN0hgiwKQd8KFE3zXZuCFaf4IByG7
   w==;
X-CSE-ConnectionGUID: vSCDWePkSaelSMONS1W0uA==
X-CSE-MsgGUID: DY3eClxLQGimCPbkh7DWKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="63862752"
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="63862752"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 01:06:09 -0700
X-CSE-ConnectionGUID: qsvLbhWZRnKHzKcQ+MSgmQ==
X-CSE-MsgGUID: l+ZezYpXSA+NAGIGXgVatQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="149164398"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 01:06:08 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 01:06:07 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 01:06:07 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.79)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 01:06:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/xReSTPy8ipuHoJBY33P1gl5zcpEF1YFec/NR20BB6ZAbG1ijqD4s/0sM9b9SUmEAiTRCXqZPoTjV/1i6byL3GAGVd/brqN3WqxdIHgIcZOk/XW8g34kWp9qpVUCR+Gc54eU01K19tLJyCVAw0ZgzEPckhDpUvyS26sfQHmnuhZWLrIIrAwKCA3cBXbC5Dc/pmGmqdhvA0oduaCY/D/a0tEk4kn8oY81y/BY46g/+3bIIvuyKUtx76inGQd68gTHNJnzbVXQINlhwI9YVjTTJ0yuGqWM8pZfe6jeCV0jHdKRu9X0KrwozNpAO7FiXjy5uozqcdxaYyfX50qeDmRTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCDI6YtbGOFgV5XBFWkcHCa96waATOWIH4Ndu4lUiNg=;
 b=KN+AMCbYnbmsZXFhG9v00F73AoJIFq+b7GGf+YQBDyv1jjvEm3shHqFUnxxuXMaSP1za79XU57cW6xMF4COw6U9PAmKVwqPmbhDCiF5VqEvkAd39Y1mfdrhKeohzncxwWSfuKXMJ3I0YzQBVIc0WM4GEvkf2YuXq22XVz3mCCEL5skcPX3m3N6WitcQOwWq03bonsVmd5Dd9DPgsWSKKWaZgmr0aSby+QaXWLry/b8YRDGxzoZ2UmgxsN3m28ortFWuZNVtzFqcVOrKMmZh5K5+UNeHwQuNDNx6Q6C7IoedOBtNNoJdQ7gYzFh+Zqvx1WKsjRutULlkNALd+JK+4Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by PH7PR11MB6931.namprd11.prod.outlook.com
 (2603:10b6:510:206::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 08:06:05 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::9ce0:77f1:dff6:ada1]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::9ce0:77f1:dff6:ada1%5]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 08:06:05 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>, Linux Wireless
	<linux-wireless@vger.kernel.org>
Subject: pull-request: iwlwifi-fixes-2025-06-18
Thread-Topic: pull-request: iwlwifi-fixes-2025-06-18
Thread-Index: AdvgJzqq1laNO6LBRLiDVqTB4bPi0g==
Date: Wed, 18 Jun 2025 08:06:05 +0000
Message-ID: <DM3PPF63A6024A9E77E30C614DE260E5385A372A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|PH7PR11MB6931:EE_
x-ms-office365-filtering-correlation-id: 999108d6-85dc-4d2c-ed58-08ddae3ef9b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ODdGbnVpM3hoemJoWXNERjlnNU0rVzdEZWZGemhkM3o3MWRWd1VVY2FuWGFW?=
 =?utf-8?B?SUZUS0hPbUxNZDN3Um9HZGJjZFNPQkNYb1E3MVJrREo1Tk9scHdFL21aVnd1?=
 =?utf-8?B?MzgwRVFDdm1UMDNya01IdnNXK1VnNHlPNStseEt3cE5jcEpPQktIS3ZIZTUy?=
 =?utf-8?B?NXcvRmpOTlY3aTllR29HN0xYVzVGOU5ySmRSWjM2aDZpZzR4TS94UWQ1dWVy?=
 =?utf-8?B?SGVKcnd1eUFTYzZVSXBLUE84OXJrTTJ5dEFQM3MwRVJZZDUzTEtCUGFIWmRw?=
 =?utf-8?B?ZFBCRzhURklKT1RJQ1hGUncvNFVZV080Tll3bEpodExnemVXa2tKTE9JUFpN?=
 =?utf-8?B?N2gwOXhTdzlzZ3BmaFlMZE5jUERHbDRadThKMzFUUSsxS3JaRG9FN0htNkd4?=
 =?utf-8?B?V3ZGTGc2TDlWVytlV3VGQW5ROVNjQTE3d2ZPM1RHTDNLa2pHQmlDeWQ4aG5B?=
 =?utf-8?B?NkEwOVlCYlcxZ1ROdVZtOThxaHpENnJjT2NVZFBCaVc1K0FYdFJqL3R5OFNw?=
 =?utf-8?B?WTZDWlZTVXNoaXRZeHN6dWltNDl1S2cxcG9pblRnN2I1ZGd5UEozem1YQWxh?=
 =?utf-8?B?cjY4MnJidGx3eU5BQVU0MHhGQzI2RWI2aTRLSHR1RjV4TmQxMjR1ekNkZGVn?=
 =?utf-8?B?RENYNEhvbC9JbTJDRFp5ZVIyOU16UjlKMGJFTHNVbFdETVFlMnI2K25KZ3FC?=
 =?utf-8?B?dzBSZjhCVVRuRENSVEEvQVpJZG90MWsrL2hScTlhM0hvOVlWNm9mMGZDN0w1?=
 =?utf-8?B?cmplOFlvS2RIZ1g4WkR4Tmgxc2FkVkdLeUJuNUxpZlBRdG54V3lwY0NZeXda?=
 =?utf-8?B?YUNzZGlEeCs1cnpvMGw1NGpERHQ3aVZNR2JUQlNUblNwWFpRRzJrRTdHSW1Q?=
 =?utf-8?B?cTcxMHlLV2g2RFE4aDJoY0RoUWhmRFM4R0djdzE1V1U4ZHRBc3M4V25YZ3Q3?=
 =?utf-8?B?ZTMxZjdTeVhxZmE5YUNmYjNVZEF0bndKWUtXcW93dUVJN1lhbHhvU0dQUVFa?=
 =?utf-8?B?TFB2WHc3bU9PbnF0U2doclVzY3k4cFdseWxXY0tkU3Y1Q3gzbFpVRWMxSTVG?=
 =?utf-8?B?eDlFekswWUNBTG5NbWlRV1lXNXZPTHVyRWF3TEdSVHU2U3cvV0FKWWhuWUhp?=
 =?utf-8?B?akxnNGpEd25nU2xZbUlYMDR2OWhDMEJaTUZ4T1N0Ym5zUE9DNUVoOXd1U2lQ?=
 =?utf-8?B?YVUyOFk2WGZHdE9BODFMRms5bk0zdWRRK2ZOdFhKOWZzUjJRWmEzOHRHM240?=
 =?utf-8?B?bUtqZHdkVnlEcUlMaENwN3M4cUtmZm5MUUdyVnFBOTQwMzRZTUNZdFJnZ0F1?=
 =?utf-8?B?NGR1bHVqYWpqelJESHZiL2IyMlBXVWZuZnlUaS9aWmlnSU93K1B4ZWpQdXg0?=
 =?utf-8?B?NDExckU4MktmTG1UeGxOLzVYVkNxcjB0U3RJV0VCY0MveVluY0JNZTYxajFi?=
 =?utf-8?B?R2E1WUhDMDdRQTZaZXByR2tyTnJ0ZjdaL3dNdnRqa1U4QkpBM2hya0JseU1w?=
 =?utf-8?B?RjFzT0xvM3grT2F6STA0QmNEVVBHS0hRZjZNcmNmMW44QXFGUDdmZ0RxNE5R?=
 =?utf-8?B?TnBtdlhLMlpSbjZ0SlhEcndZaDcvNHJkWE1za1pKWEtHNkswQVRXSXlTaDYx?=
 =?utf-8?B?THV3emhHN1R5a3pLN2c1WW1KQ1FjbjJENUdqUzJQUzZ0QVNwRktjZHp6Y1V2?=
 =?utf-8?B?cmNkUGwzR0xGdmhzNWExUXlSZWJ4VzNjbVNleThXWS8rVlBaTW55c3RNYkJz?=
 =?utf-8?B?ZExEMUFMb01rNm1uMElSMzF3bXVIdWNUdWZVd3A0R3BmakE4YnlYU1k0ZDdN?=
 =?utf-8?B?cXVHb3cxTU1wazMwTllPTjdtVzFZazgwMlRLejdjNWEwN3kybHQ2Z2k3V1N3?=
 =?utf-8?B?R1QvTzVEd01ZVlVCdXU1ZER1VnRwY2ZtMDZjNE51MHR4OTRTeEU3OWwwaW9M?=
 =?utf-8?B?ZTNQT1dqOEtpUkZzSkx1OXZGL2hscTZNbFRwalRscU5nNmpEODl6VkRUc0Qw?=
 =?utf-8?B?cVd0K0s4MlRRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1ZPenU5bVg1S0diVkp6NXdhN2tEMDdFS2NGL3VqZ21KR1hjbkdHcUdYTk1N?=
 =?utf-8?B?bDZJN01VaUFOb1RPRG1MM2crbENEbnhTZUVkbUh5cVp1YWtvZGxPQjF0bGNv?=
 =?utf-8?B?Wjl1Y1Y0amNOendyS2FIQldmbkVOOFFpQVR0QkRmT1Rma2Z5V2dNU2hWRnVu?=
 =?utf-8?B?TmtEMU90QmpzaUtuVWdoS2E5cmVQeVloSmlMU1JEWk9UNzFwbUR4MEdjbEM2?=
 =?utf-8?B?T2UyTnNyOGZpQjhDbU9RT05JZGpkRkZiWURyUncwT1VlNlE5TzRtdGhDSW45?=
 =?utf-8?B?enJabmVJaVh0cXJ3YzUwUit3blZicEtHVVBjY0w4MCttcjNSb3JqQTRsMkwy?=
 =?utf-8?B?dWdSM1dhNEoyeVFHZ2RSQm5NQldndyt3U2NSaVV4UzVESlp1RU9XZ3lDSG1q?=
 =?utf-8?B?eHBIODcwWVV5NUdkV2VqaVRERm9iWDB5bGNRYlVBdUpPK0RTcTY0N0JrdDVh?=
 =?utf-8?B?eFE5Zjkwd3U4M1FobkVIZjI3aVRBVjBLeGFtMlFoUURmZ1RYRXJYbUtNUEJa?=
 =?utf-8?B?THJtaTd0U1J0S3lSakNmR000bWpRYVZsVHhSMXA4NmFLT0cvRlFaNnhac1dB?=
 =?utf-8?B?YmZxWjJqUHF3cUtDckxrbE5ITGczUTVBQ3BIdGVEUlk5WjlnNXJsaWk4MVhU?=
 =?utf-8?B?eE1SSHJURWRnV1QzbFUzZTdNUGFHSzFGOGNibHdHQ2FMVmRJbUh6aTBlRFpq?=
 =?utf-8?B?NGRKWGc1SkI3MUFWbisrMUFPb0tqdkgrdk9xcGxjZG5DMThBbmNteGYyUk1k?=
 =?utf-8?B?Mk5yYWwwV2wvb3ovM2I3dTFuU1NHaERxR3piZEpjRW5iMjhWS1Fja3o5NU1W?=
 =?utf-8?B?ZnJrUlhuSGdGbm9rYXFlcE5vN3BoRHcraFBpQklIUUJWR08rSVVYckJmemlK?=
 =?utf-8?B?Y2ZsZnJmZkNrMzFvdVo5dEdRWSs5NGlIM2hBVVlQQ2x4Z1lSMDRwOVgvLzR1?=
 =?utf-8?B?WnczQStqaDlMVXBHam0zQTcvaDVyVUg0M1krM1NpU0EwM0V5N09WUE1lR2w0?=
 =?utf-8?B?L1BKOWdyLytGTXJjWmNsMThMeTVqV05hQ2wwSG93dEc4M05PM3Fiem5ockxP?=
 =?utf-8?B?azNDKzFYdHFKdEVtWURrWTlVVHZuWVhYSFltSk8wS3JYUndUUWsxN0F3Mm4v?=
 =?utf-8?B?dFBlMFRqKzlwUkZxNUpIcytFU0JlOE16b1E1cFBhSlp2ajZBVXhqN0dpdWU0?=
 =?utf-8?B?WkhIVldRb2loTkFYbE1zOXhncUxQa2FodWxjU1pzbEpUL1NlOEFncDFJK1hT?=
 =?utf-8?B?MnZ2QXQyMVM0U3ZZU0wwaVVIWXBBOCs3cHU0Y1lhL3RQZzJKS0FMRWRkTVFa?=
 =?utf-8?B?VXF0T1dINllPMTdFYVdSdjA2dnZmZzRlbUdyU29JK1E0WVF1K011THRrWEdm?=
 =?utf-8?B?cDBEdUdna0drdFh6YjFhOHFkckxkV3ptYVpKMFUrajZ3dWFyUzEvcEU5VDRW?=
 =?utf-8?B?dlZXaENQV2Q2V3RyTUFIZHdPS2J2aGk5UU43R3E1Zzh4Nm1TMk5sdFJaSEVh?=
 =?utf-8?B?b2dVTkhrTzVuSVg5TnJIYkFWdjVTRU9iZllnc29YcHREWjFVdVJ4OFRpZFNu?=
 =?utf-8?B?eWc1S0hrbit4cGl6aWVYV3hmRk8rQ1lsMTcwZHRZWTdoeVlXSnpsVWxEaDZj?=
 =?utf-8?B?d25hWHRmM28zSHduSGRpbGFzdHpuVXNhNzl2eFo3WkpxdHdlS2ZsbHQvS0gv?=
 =?utf-8?B?QVBpTVJxUVY4cml1RlF4VGpoaWdsTVBPbHBiNnRFcFo2OGYrUit3ZmxLaW9U?=
 =?utf-8?B?cDZJK1VmZDBBM1BjZldzQW5qRlNGV2M4YjYrV2Nmbm9zVWVuaklZUVRTbTM3?=
 =?utf-8?B?L1JkeUFMZ0NyZGREQkpmVlFrNi9QOEc0aEdHYlBJc1JXS2orU0F0LytBS0tu?=
 =?utf-8?B?Y3hnZkhXMlh5NDlmTVlNclF2ZWRlc05IaFc1VU53bmRCVzFpN3JTTmFqWGJ5?=
 =?utf-8?B?VUQ2dm5Ya1F4VFJ4UW9xWDBoZGltV1FJK1I2NHlWd0pXT0NpVlBnQjR5a0tK?=
 =?utf-8?B?MGw4aGkySldiWDhEK0IzeDFaV2R1V1ltd053L1VwY3FBUmRqNFJZQSsxOGRE?=
 =?utf-8?B?RjJ6TWs1dFVhSVJpU0wxZ2JNL3NnOVVzNTJwb2toWGhTUmNkSk5HbExHa2VX?=
 =?utf-8?B?N24vNzFtRDJXaUxRc25YTkFRcVMwQjRjSWhCYmdMS080dFRvVWF0ek1Mak4x?=
 =?utf-8?B?QkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 999108d6-85dc-4d2c-ed58-08ddae3ef9b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 08:06:05.6758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YEq3hlhXaaXozkQtRelcdzgZ0E47Hb2zbKHBNYmOK4A5iALXDR3TepkjFvqzlimRHAe96zHZKXX60Pj0oLgqSvuZqIStpfJuQ8C9RtuQpbwghaQEdYWLKP9+WYa25FsS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6931
X-OriginatorOrg: intel.com

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCAyNzYwNWM4YzBmNjllMzE5ZGYxNTZi
NDcxOTc0ZTRlMjIzMDM1Mzc4Og0KDQogIE1lcmdlIHRhZyAnbmV0LTYuMTYtcmMyJyBvZiBnaXQ6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbmV0ZGV2L25ldCAoMjAy
NS0wNi0xMiAwOTo1MDozNiAtMDcwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9z
aXRvcnkgYXQ6DQoNCiAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvaXdsd2lmaS9pd2x3aWZpLW5leHQuZ2l0LyB0YWdzL2l3bHdpZmktZml4ZXMtMjAyNS0w
Ni0xOA0KDQpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gODNmM2FjMjg0OGI0NmUzZTVh
ZjVkMDZiNWYxNzZjMTdlMzU3MzNhMzoNCg0KICB3aWZpOiBpd2x3aWZpOiBGaXggaW5jb3JyZWN0
IGxvZ2ljIG9uIGNtZF92ZXIgcmFuZ2UgY2hlY2tpbmcgKDIwMjUtMDYtMTggMTA6NDk6NDAgKzAz
MDApDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCmZpeGVzIGZvciA2LjE2LXJjMw0KDQotLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpDb2xpbiBJYW4g
S2luZyAoMSk6DQogICAgICB3aWZpOiBpd2x3aWZpOiBGaXggaW5jb3JyZWN0IGxvZ2ljIG9uIGNt
ZF92ZXIgcmFuZ2UgY2hlY2tpbmcNCg0KSm9oYW5uZXMgQmVyZyAoMSk6DQogICAgICB3aWZpOiBp
d2x3aWZpOiBkdm06IHJlc3RvcmUgbl9ub19yZWNsYWltX2NtZHMgc2V0dGluZw0KDQpNaXJpIEtv
cmVuYmxpdCAoMSk6DQogICAgICB3aWZpOiBpd2x3aWZpOiByZXN0b3JlIG1pc3NpbmcgaW5pdGlh
bGl6YXRpb24gb2YgYXN5bmNfaGFuZGxlcnNfbGlzdCAoYWdhaW4pDQoNClBlaSBYaWFvICgxKToN
CiAgICAgIHdpZmk6IGl3bHdpZmk6IGNmZzogTGltaXQgY2Jfc2l6ZSB0byB2YWxpZCByYW5nZQ0K
DQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9kdm0vbWFpbi5jICAgICAgIHwg
IDEgKw0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL21sZC5jICAgICAg
ICB8ICAxICsNCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tbGQtbWFj
LmMgICAgfCAgMiArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvcGNpZS9j
dHh0LWluZm8uYyB8IDExICsrKysrKy0tLS0tDQogNCBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlv
bnMoKyksIDYgZGVsZXRpb25zKC0pDQo=

