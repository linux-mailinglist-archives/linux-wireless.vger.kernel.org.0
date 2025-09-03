Return-Path: <linux-wireless+bounces-26964-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF276B417F9
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 10:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 466161BA42FD
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 08:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463AE2D8DBD;
	Wed,  3 Sep 2025 08:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zq7N0Ap5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456B82E62B3
	for <linux-wireless@vger.kernel.org>; Wed,  3 Sep 2025 08:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886819; cv=fail; b=s1tFgJot6JDkNwUE09bNuTNOsbPJe4fVrPWvVKhOCb7VcNjNk7WjTlo3ZGUUK+uQBzbsn/ormqPpr/IPRkTudxHAAd7FQO4DlGMGvqpQSvKSWDBGRQ1SlSmWdyas0uiYgRyl/W1eYEpDwMjHWt9Px8+THvRS/qd/IlBIDLTHWGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886819; c=relaxed/simple;
	bh=m4kSN8CZ2t1dnuQ5YNRt2BJOD3huV7q4YmKN/Gp46hg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VV6GEMzIPDXhpoMa2bFJ8Tk4YvuY04Lx0QiE7rzLWm3bQD+mr1jnm6qA+Mn7dLqROI/meWAjdAGqol2zofuWmxLGlJMrLKIxu8ebT0r5fUk1ypj4Rn+74RdNJz7yEcGA7jISwmF2NuxEt7dzBMr3UZTTz76089A+maaaaQkhLXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zq7N0Ap5; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756886817; x=1788422817;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=m4kSN8CZ2t1dnuQ5YNRt2BJOD3huV7q4YmKN/Gp46hg=;
  b=Zq7N0Ap5I0KQ7TO4GvVj7ZPUXxSkSh/x/J1SRTAdTjwACTmn7C303GdJ
   XWt9MiKcBLWbnpXyZCtQ8mE+63D6aeXLtp473rnCQ5v+9Cd45Gl7CP1f1
   3s3qyx7mROs1shQWxI5AOdn7Ge4RCgErnWDcKSj36/8Wsl5fci1ebiLJC
   8fbgyvCydIQuDw7cYJrBNBNLDl1028gdKMcp4lyUAZD2NdyfDFTtB7UTo
   FRIklELDCDcGIuJ0o3PWVSvsiHRDsyqlGABIRgcFBBw/uZHVSkSfDtrla
   nkGhkYFN4FXuk/EIXah24F3hGg/9U8DNOrfARvbQHSXZvkhb86ZBN6oNw
   Q==;
X-CSE-ConnectionGUID: mxCKl/TmQ8GYjPW0j/h8rw==
X-CSE-MsgGUID: MZfXz3rnTXWQE8hQDeposg==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="58221809"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="58221809"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 01:06:56 -0700
X-CSE-ConnectionGUID: cK4tsvXQQsiDxOywOhSu2w==
X-CSE-MsgGUID: IYhj4LJEQIuTp21jxCva0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="171078885"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 01:06:56 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 01:06:55 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 01:06:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.89) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 01:06:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5nh9VjrCI3i8QNsH3ZZHH7uISDaI3JBIkNQjMMa/zFzvlF3aNKK4x1R2y/YEm9beaLDZOSrVIZZS3WcjEDkiFv67mlhMLOuJ/lYjSUTjUT+L7ivUiJvZsD4gOo4ehjliDDwfho6UuGH8acj7N2cNwtH5XQRBoo5FWROSRJhawQh4Ze5429GahHfmlSajwVzityD8UKFXm3RFRWeA/Mu/Af8Dxrgamvq6nNLRX5H75I+19SAfRRNBPPboGd6imi2JJoOqK9IZ/H+QsB4PrdPoaxuMcikeGLVxEIjBNI3acvcYdwXty7h72pqFqTnJisI8ZtaAHNRQJcrKcLutuWc4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4kSN8CZ2t1dnuQ5YNRt2BJOD3huV7q4YmKN/Gp46hg=;
 b=G16Bj2mVLI3JPL/iRnSFZj0Q6h/WbBGv1ufslR7yFc/TqhqupORyFuVMutYZYr9wMFbYqE+iqhpeQLCCMZZiFGRUBYZlT1n2OJ77iy4sg/XlMxki0vHQPRvAilocXWwROZEq2kFtyuO9+b1/V4W8kuqGsIUdZ0CSKDrFjstnQV5CdDD0+o4zUgh0yaR1tyv3ZY2RWL5hCmQsO9LkjZlYaToAttakXYv3hZKDyfHacH6Zc/3DkDf5D/SrZajKL4l7YV/4Dw55Zz7V8YJrarD3TH5hZyVni+FZjLMkEiUIvGQ4zwL4mkMjRPF6nn0jru8rbUkULAf1mMrN/w29JHekQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by SA1PR11MB5802.namprd11.prod.outlook.com
 (2603:10b6:806:235::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 08:06:52 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f55e:9ab0:c331:f987]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f55e:9ab0:c331:f987%5]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 08:06:52 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: "Berg, Johannes" <johannes.berg@intel.com>, Linux Wireless
	<linux-wireless@vger.kernel.org>
Subject: pull-request: iwlwifi-next-2025-09-03
Thread-Topic: pull-request: iwlwifi-next-2025-09-03
Thread-Index: AdwcqbO1jZvWqiAZRVeAQcyF2cYJhg==
Date: Wed, 3 Sep 2025 08:06:52 +0000
Message-ID: <DM3PPF63A6024A9E0A27274950DE880B95BA301A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|SA1PR11MB5802:EE_
x-ms-office365-filtering-correlation-id: 34be1637-310a-49dd-2d33-08ddeac0d75d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UE5SWHNsc21lTGVDZEU1UWlmc3dwVitncHByT3R5ck95L2hYN1lsRTBLNW5w?=
 =?utf-8?B?NTZCS0QzTVFjWjFxbXd4aUZ2Tk9rRThxQWRkN1NQMGNSK2dHaGlqYzdJamhq?=
 =?utf-8?B?QzNoaTl0anNNc2Z0UWtDekUxYlhUWnFmQzk0cG9HZk05eFVqQk1vSklQeE9D?=
 =?utf-8?B?TVd4alRoS2pFeHNUR2c5UnV1QXN6MUpweFlHUnhVeW1IWVNrejZ5SjhzYzU3?=
 =?utf-8?B?OE5RbEloZDV5QUJ3UDcyTEVDUzdKVGtSODdQc1YwKzgxbUY5b2crMllnaStU?=
 =?utf-8?B?bVBUemo0MUdmcU04VmhtUVREUE5DcDVDckRUV2Faa1MxS0c4aDlIUDFvc3Ux?=
 =?utf-8?B?YVovUm00c3k1RFVkbUEvQ1E4WjJ0MHU3T1VMNWJyZE4wWnh4d1prTGVaNXNa?=
 =?utf-8?B?TUJVc2t1YVZrbGZPcXg0M2VSRnNSN3d1ZTFZL1JtME5GQWw2RWIwT0ZBbGdP?=
 =?utf-8?B?Vi91ZVo0d2xpSUtwT0F0V3FKcUY1eE9MVGVheGs5SkVIVk5LUGxJRFJJSkUz?=
 =?utf-8?B?ZncvNG14c01XdlVhV0JFdTIwZ1JCV01VbTF1Z2hSS2NvcmJZdTcvb1NyeS9L?=
 =?utf-8?B?WnAwa3pKdHAxWGxxR3ZtUTJvL2NpS3VMSjUxaEY5MitHVEZjUnhaQ2tkS2hh?=
 =?utf-8?B?S00zWURPUnc3N295cjZrSGhHN0QyKzF6aGR0RFlVeS9sdjRhRzB5VXRCbW82?=
 =?utf-8?B?eFNET2NtNkU4ZGdJWk5lY1hLVzZXKyszYmhCWU5rT1J0NEZTTVQvOTBtaVBB?=
 =?utf-8?B?dDR1QW9KUVFRTzZXajlIZnZtWTdWT2FHdVFsQkRyYnZSZFowdGJoNjIvdmRG?=
 =?utf-8?B?emUwUklJSlpTNU43eVlzODQyVHNSdkh2RWRoZUJqSXR1eGVLR2wrdnJySEJZ?=
 =?utf-8?B?Z3A2YjVXdnRuRG5oQUk1TXRoYUI4b0xUNStZQUNRd1lrL1R4eE43YkRYV1hy?=
 =?utf-8?B?b0JWeUg4OXh0bi9VT1pEdzNudGdKcFZaT0VTRno0NlFJbU9xY2dRbW5LdGZl?=
 =?utf-8?B?NTFKRk5vNlk1Q0t6OU96ODhOaTk5Y0dRcjkxd2IwS25zQm5DNnlKUGhYRndv?=
 =?utf-8?B?WWFMVXRSdHh5WWJYalVraitnaVlQSVVmc2xaVWQxdWFBMGdBaHpHN2FaeS9l?=
 =?utf-8?B?Z0ZOWVc4S3dLMms2ODJvQVg2Qm8yalZjTTRDV0grLzh3R2U3SjA4bjFDcTI0?=
 =?utf-8?B?aXI5c3BrLzRJbnBUbEVZcXFLUUIyZi85OXZvWjVEbnhFVFBVYlBwRUFTRnky?=
 =?utf-8?B?UFA1Rm5WUkJWc3hOR2ZNUUpjZDJYQlQvTkcxdWJXSmszQUxpNW44TVRvR2tE?=
 =?utf-8?B?V1ovdEhaL0YweFhxdnRIR0hKYmYyakpJL1NEN29uanVJL0hpUjE0YkxieXB3?=
 =?utf-8?B?R3JzTGtBNzgvYVkrOGFHeHI5OEFVL1RrbDZ5UjlNWUw1R3EyY24vTGNpZm52?=
 =?utf-8?B?MUVXRGhtbE5hTndaTUlIaWx5M2FqaDd1NStNUVhaT0RmZzlSN0tWQ0VnYU82?=
 =?utf-8?B?TXNtSXJHa2g0b0toNFRGUnZDSzkrZWxDR0FEcUhLNDJuam9mS2piWDlvdWRE?=
 =?utf-8?B?OWVqSy9sWDl3U253RzZRdDcrTDBWZEJuR3UxNXdldm1FOTd2YXdiL1p0cG8v?=
 =?utf-8?B?R0FURXE5OHROMmo3TzZHZ2wrRTdyNlRld2dDdXNabzM4RzVremt5VWoveVVi?=
 =?utf-8?B?YlRrdUZuMEpRMmJudTBxQWlXVXRUS2R1UnNycWlvRWUvbXgzKzBoS204Q29n?=
 =?utf-8?B?d3hRcGg3TjZVODdSVGdsWWk5cjdOWVlQYnJ2RUJlUDV2SFhjYWxIOTNweUkw?=
 =?utf-8?B?ZmxVai9iYkl3a0RzVVFCZ2pITGNHWUVXakYrampyMUhmemZSZWpyR2tubXpm?=
 =?utf-8?B?d1NzYUFEQXRwWXhCTkw2ZGJTZUpJaDYvZXhhNjlvRk5GeGRaZFB4cWRHb2VZ?=
 =?utf-8?B?cTZjaDJOWmY0d213b0xnbUx1TmVBOERETUZtd2o5d1VRMnRxeitVNWdDU0xL?=
 =?utf-8?Q?CYT4qZRy7ZiYPQ7lds0Qw0qCuc2rr0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXB0eE00TUJhZHFDNml3K1Jsbmx0b21ScTRpOUxQbDNtc214RDZBbFNrUzRy?=
 =?utf-8?B?RHdsdTg5c016OTMwUWpDWUkrSjZzOUR6dEVVWGZzUUQ1TWFPWWNVVE42TWwv?=
 =?utf-8?B?c0Z0T3c1UHd5cjAxdUFScnZpK0kxWXBkTFNzdlhYdTNkN01sK2ZNUGpiS0Fz?=
 =?utf-8?B?bzF5bUFwaU13WDBrVVdnOEN6MnltSGptSHJJMk1tckRTOHB1cVJSUDRITHNu?=
 =?utf-8?B?TzZOUWMxNk84NXBZenM3aHRMTmV2T2lMOU9VakUrc09XR20zcVVuSGVsV09X?=
 =?utf-8?B?NlEvL0RFcll6eU1ZUGpqQmFwd3hSNWZSb2hZWnpsdmJvd1JXUTVWcFNCdkp4?=
 =?utf-8?B?SDR6S25yVHBKN0NLclVsbG9zeXFJK2ZmK243emdWVEFyc3FKMlVxQVd3ci9V?=
 =?utf-8?B?aDJzbzM1c0tZNkJVR1VsbjNxbDg4SEU1YXZGMTRPNXZ5c1lKeGtZRkJjS3RX?=
 =?utf-8?B?WWp5T25RcXA1NytoeE5zSlNkUUsrbFptZDdXUDd6Z3dkR1FLcGFXWS9LYlV0?=
 =?utf-8?B?dmd4ZzNVbjhBZzIvTkJxeTZsV3ZPeldENysvZXlVNlZLYzJFenZ4ZHR6V3BJ?=
 =?utf-8?B?alhhWnhzc2NOVllSMmp5a1pJc3dYYkltbHZSa2N2VmhBZmxqRGNMVmdTZis4?=
 =?utf-8?B?b09mLzhJWjY3dm5Yc2R5RVVQY3FTWlpSeW1CanpvVzlrQ25HV3FHMnF4cTZL?=
 =?utf-8?B?cjcvNVluZTdib3lsWFprQ2ZqR0VZVWlaQnpPN05hZWQrbjdqN0VDOWRyci9h?=
 =?utf-8?B?WnV2YUluSzhoMnBhVzhrSy9rcWVXN3VUY2ZUY0JnQ1FvdjJpZCtnNzNUVDB2?=
 =?utf-8?B?d2FmSHNveEJ3UXNoYnM0amlySyt6TCthZUFYUmZtUlhHb3o5UDF1TGM2UkVs?=
 =?utf-8?B?ZjZZR1pMYTVWeFJZL1BXVUc1SGZ4YjQxNkIycTNOcDM0VWt3T2VJYWdBWGNX?=
 =?utf-8?B?MVQ5ME9oV2JKRXJEM2FyeVJXSWYwTzRyTkVYOW4wM29tVFBBWTBEYzQ3ZXoy?=
 =?utf-8?B?NTFQcitLS2preVZWSXh0TVBiSFdTcXpCK1lOendUbktmYStJcU5PQ2d6V25Y?=
 =?utf-8?B?QytyTkl1WTNZMHhSam9TaVB0cU04SU5nQUpuRUIvQnZFR2V5cjNVZVdzUUF5?=
 =?utf-8?B?eDBXdFhpaTRSRTlGUkt1aFBBSGd6aEZFMG9xZEV1UnRIVTMyUWdQYXRaSjEy?=
 =?utf-8?B?R1lUVXEyZlIrQ1dwYUpRRGRBWHMwRzN6UGY5QkI0QW5IcGJZam9xVE1LNmlS?=
 =?utf-8?B?NkwrY2dRZkNONGM2b1F2a0V4b1poSm4wZHcrNWtmYjdHcnRhMS9iTmxnZ1U4?=
 =?utf-8?B?c2xjWTNXOWJzYW1pVnVNMHNwQ1pFZ1plNVR5YnNTVGpsbkVoNHZXQklGaVM3?=
 =?utf-8?B?amNseVg1RmFrVmxFVFA5Y0RpaTRJZ3pYcGZLeEtkZjFubTJiYmJLK3pQQWZq?=
 =?utf-8?B?TFRLcllSdVYvaEdrVXdnRk50RXJiVlM4elVHeldYTFViMVg1NTlnQzc2MkNI?=
 =?utf-8?B?UHJxRURYWTFibW1sczZ6N2hCS2I4OGVXU2svLy8rSjNldlhuMnhWMnRtUkVz?=
 =?utf-8?B?TFhCNG9NQUJSSlIveHpleFNTVWNCUDVtYmFhZHdsUDR6TzVYUndXRUF1SEV0?=
 =?utf-8?B?MFYyTkFCTXRBZUNmcy8reU45WnRWSHd0MmtQYzVjQlhNWEt2MXRXK2tULzhZ?=
 =?utf-8?B?dVY4Z1ZVNGlYdXo5T2FRd25YTmdNWkxldzg1L0pzQTRoUDI4c2YxSW1zUEI0?=
 =?utf-8?B?SkRNZXc3bllTOFYzekIvUG5qNmtKbnNvT21LdkFIVm1JYkFZYXdPZkRrQ29T?=
 =?utf-8?B?b3lraE81RGVManpyK0Jla2JRSzlQdnRFMzRtUjJ3NCsrb1lQeXlFL3FxdUla?=
 =?utf-8?B?d01XR2FxTEJBdXhOQTRCOTd6OTBrcDdrdkwrQ0FxYjc5SGFVNHdBQVVXU1I1?=
 =?utf-8?B?UGt0QmVydmJRUmtDdnIrdXNTb0FyMHlSNHFYTGhtaldzaHRpWTFYd0huODNm?=
 =?utf-8?B?VnJVbkFYbXQ5ek9ycDFLMkpydjhKL0YrTVU1YVdLcmUvVlVPUmFNU1JySVp5?=
 =?utf-8?B?bnczL0dvTHdNWExscDB5Qm8veHQxR1VUeFlqdUZtV1hmUVkrS2Q2S0o2UEtQ?=
 =?utf-8?B?N1hQMlhsZkVGelpDVnFNaExGZlhmVlNzUVN3Z2RxV3JkNXFjZmE5YkE3Z3Bt?=
 =?utf-8?Q?O6ZNErgEcmA2q21IlLmT/6U=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 34be1637-310a-49dd-2d33-08ddeac0d75d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 08:06:52.4175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /gC2EHQftvG/oQH2IRJ2xUVm5a3m4Io24voaZeda76O5EJ8qKR77yz1WA++JNnO1wW8JQiSUmj8axVoBRscHoG8zFTH/yANRTHin3wxaAT3+ONITrFQU6wjubOaNXXzU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5802
X-OriginatorOrg: intel.com

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBkOTEwNGNlYzNlOGZlNGI0NThiNzQ3
MDk4NTMyMzEzODU3NzkwMDFmOg0KDQogIE1lcmdlIHRhZyAnYnBmLW5leHQtNi4xNycgb2YgZ2l0
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2JwZi9icGYtbmV4dCAo
MjAyNS0wNy0zMCAwOTo1ODo1MCAtMDcwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJl
cG9zaXRvcnkgYXQ6DQoNCiAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvaXdsd2lmaS9pd2x3aWZpLW5leHQuZ2l0LyB0YWdzL2l3bHdpZmktbmV4dC0yMDI1
LTA5LTAzDQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byA5YjI3M2VlOWMwODRhN2Ri
Mjk3OGUyMTAxYmJiNmZjMTYzNzAxYzg1Og0KDQogIHdpZmk6IGl3bHdpZmk6IGRvbid0IHN1cHBv
cnQgV0ggYSBzdGVwICgyMDI1LTA4LTMxIDE0OjM5OjI2ICswMzAwKQ0KDQotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQppd2x3
aWZpIGZlYXR1cmVzLCBub3RhYmx5Og0KDQotIG1vcmUgY2xlYW51cHMgb2YgZDMgY29kZQ0KLSBj
bGVhbnVwcyBvZiB0aGUgdHJhbnNwb3J0IGxheWVyDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkRhbmllbCBHYWJheSAo
MSk6DQogICAgICB3aWZpOiBpd2x3aWZpOiBtbGQ6IGFkZCBmZXcgbWlzc2luZyBoY21kL25vdGlm
IG5hbWVzDQoNCkl0YW1hciBTaGFsZXYgKDIpOg0KICAgICAgd2lmaTogaXdsd2lmaTogcGNpZTog
cmVsb2NhdGUgZmluaXNoX25pY19pbml0IGxvZ2ljIHRvIGdlbjFfMg0KICAgICAgd2lmaTogaXds
d2lmaTogc2ltcGxpZnkgaXdsX3BvbGxfcHJwaF9iaXQgcmV0dXJuIHZhbHVlDQoNCkpvaGFubmVz
IEJlcmcgKDQpOg0KICAgICAgd2lmaTogaXdsd2lmaTogYWRkIGEgbmV3IEZXIGZpbGUgbnVtYmVy
aW5nIHNjaGVtZQ0KICAgICAgd2lmaTogaXdsd2lmaTogaXdsLWNvbmZpZzogaW5jbHVkZSBtb2R1
bGUuaA0KICAgICAgd2lmaTogaXdsd2lmaTogdWVmaTogcmVtb3ZlIHJ1bnRpbWUgY2hlY2sgb2Yg
Y29uc3RhbnQgdmFsdWVzDQogICAgICB3aWZpOiBpd2x3aWZpOiBhY3BpOiBtYWtlIGl3bF9ndWlk
IHN0YXRpYw0KDQpNaXJpIEtvcmVuYmxpdCAoMzUpOg0KICAgICAgd2lmaTogaXdsd2lmaTogbWxk
OiBjbGVhbnVwIGNpcGhlciBsb29rdXAgaW4gcmVzdW1lDQogICAgICB3aWZpOiBpd2x3aWZpOiBt
dm06IGNsZWFudXAgY2lwaGVyIGxvb2t1cCBpbiByZXN1bWUNCiAgICAgIHdpZmk6IGl3bHdpZmk6
IG1sZDogc3VwcG9ydCBNTE8gcmVrZXkgb24gcmVzdW1lDQogICAgICB3aWZpOiBpd2x3aWZpOiBt
bGQ6IHRyYWNrIEJJR1RLIHBlciBsaW5rDQogICAgICB3aWZpOiBpd2x3aWZpOiBtdm0vbWxkOiBj
b3JyZWN0bHkgcmV0cmlldmUgdGhlIGtleWlkeCBmcm9tIHRoZSBiZWFjb24NCiAgICAgIHdpZmk6
IGl3bHdpZmk6IG1sZC9tdm06IHNldCBiZWFjb24gcHJvdGVjdGlvbiBjYXBhYmlsaXR5IGluIHdv
d2xhbiBjb25maWcNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG12bTogcmVtb3ZlIGEgZnVuY3Rpb24g
ZGVjbGFyYXRpb24NCiAgICAgIHdpZmk6IGl3bHdpZmk6IGJ1bXAgTUlOIEFQSSBpbiBIUi9HRi9C
Wi9TQy9EUg0KICAgICAgUmVhcHBseSAid2lmaTogaXdsd2lmaTogcmVtb3ZlIHN1cHBvcnQgb2Yg
c2V2ZXJhbCBpd2xfcHBhZ190YWJsZV9jbWQgdmVyc2lvbnMiDQogICAgICB3aWZpOiBpd2x3aWZp
OiBtYWtlIHBwYWcgdmVyc2lvbmluZyBjbGVhcg0KICAgICAgd2lmaTogaXdsd2lmaTogbWxkOiBk
b24ndCBjb25zaWRlciBvbGQgdmVyc2lvbnMgb2YgUFBBRw0KICAgICAgd2lmaTogaXdsd2lmaTog
bWxkOiByZWZhY3RvciBpd2xfbWxkX2FkZF9hbGxfcmVrZXlzDQogICAgICB3aWZpOiBpd2x3aWZp
OiBtbGQ6IHJlbmFtZSBpd2xfbWxkX3NldF9rZXlfcnhfc2VxDQogICAgICB3aWZpOiBpd2x3aWZp
OiBtbGQ6IGRvbid0IHZhbGlkYXRlIGtleXMgc3RhdGUgb24gcmVzdW1lDQogICAgICB3aWZpOiBp
d2x3aWZpOiBtbGQ6IGRvbid0IGNoZWNrIHRoZSBjaXBoZXIgb24gcmVzdW1lDQogICAgICB3aWZp
OiBpd2x3aWZpOiBtdm06IHJlbW92ZSBkMyB0ZXN0IGNvZGUNCiAgICAgIHdpZmk6IGl3bHdpZmk6
IHJlbW92ZSBkdW1wIGZpbGUgbmFtZSBleHRlbnNpb24gc3VwcG9ydA0KICAgICAgd2lmaTogaXds
d2lmaTogdHJhbnM6IHJlbW92ZSBkMyB0ZXN0IGNvZGUNCiAgICAgIHdpZmk6IGl3bHdpZmk6IHRy
YW5zOiByZW1vdmUgU1RBVFVTX1NVU1BFTkRFRA0KICAgICAgd2lmaTogaXdsd2lmaTogc2ltcGxp
ZnkgaXdsX3RyYW5zX3BjaWVfZDNfcmVzdW1lDQogICAgICB3aWZpOiBpd2x3aWZpOiBtbGQ6IGRv
bid0IG1vZGlmeSB0cmFucyBzdGF0ZSB3aGVyZSBub3QgbmVlZGVkDQogICAgICB3aWZpOiBpd2x3
aWZpOiByZWZhY3RvciBpd2xfcG52bV9nZXRfZnJvbV9mcw0KICAgICAgd2lmaTogaXdsd2lmaTog
cmVtb3ZlIC5wbnZtIGZpbGVzIGZyb20gbW9kdWxlIGluZm8NCiAgICAgIHdpZmk6IGl3bHdpZmk6
IHRyYW5zOiBtb3ZlIGRldl9jbWRfcG9vbCB0byB0cmFucyBzcGVjaWZpYw0KICAgICAgd2lmaTog
aXdsd2lmaTogZG9uJ3QgcHVibGlzaCBUV1QgY2FwYWJpbGl0aWVzDQogICAgICB3aWZpOiBpd2x3
aWZpOiByZW1vdmUgdW5uZWVkZWQgamFja2V0IGluZGljYXRpb24NCiAgICAgIHdpZmk6IGl3bHdp
Zmk6IHJlYWxseSByZW1vdmUgaHdfd2ZwbV9pZA0KICAgICAgd2lmaTogaXdsd2lmaTogZ2VuMV8y
OiByZW5hbWUgaXdsX3RyYW5zX3BjaWVfb3BfbW9kZV9lbnRlcg0KICAgICAgd2lmaTogaXdsd2lm
aTogZ2VuMV8yOiBtb3ZlIGdlbiBzcGVjaWZpYyBjb2RlIHRvIGEgZnVuY3Rpb24NCiAgICAgIHdp
Zmk6IGl3bHdpZmk6IG1sZDogc3VwcG9ydCBUTEMgY29tbWFuZCB2ZXJzaW9uIDUNCiAgICAgIHdp
Zmk6IGl3bHdpZmk6IHBjaWU6IHJlbWVtYmVyIHdoZW4gaW50ZXJydXB0cyBhcmUgZGlzYWJsZWQN
CiAgICAgIHdpZmk6IGl3bHdpZmk6IG1sZDogbWFrZSBpd2xfbWxkX3JtX3ZpZiB2b2lkDQogICAg
ICB3aWZpOiBpd2x3aWZpOiBjYXJlZnVsbHkgc2VsZWN0IHRoZSBQTlZNIHNvdXJjZQ0KICAgICAg
d2lmaTogaXdsd2lmaTogbWxkOiByZW1vdmUgYSBUT0RPDQogICAgICB3aWZpOiBpd2x3aWZpOiBk
b24ndCBzdXBwb3J0IFdIIGEgc3RlcA0KDQpQYWdhZGFsYSBZZXN1IEFuamFuZXl1bHUgKDEpOg0K
ICAgICAgd2lmaTogaXdsd2lmaTogbXZtOiByZW1vdmUgTUxPIGNvZGUNCg0KU29tYXNoZWtoYXIg
UHV0dGFnYW5nYWlhaCAoMik6DQogICAgICB3aWZpOiBpd2x3aWZpOiBtbGQ6IHRyaWdnZXIgbWxv
IHNjYW4gb25seSB3aGVuIG5vdCBpbiBFTUxTUg0KICAgICAgd2lmaTogaXdsd2lmaTogbWxkOiBB
ZGQgZGVidWcgbG9nIGZvciBzZWNvbmQgbGluaw0KDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50
ZWwvaXdsd2lmaS9jZmcvYnouYyAgICAgICAgfCAgMTggKy0NCiBkcml2ZXJzL25ldC93aXJlbGVz
cy9pbnRlbC9pd2x3aWZpL2NmZy9kci5jICAgICAgICB8ICAxMyArLQ0KIGRyaXZlcnMvbmV0L3dp
cmVsZXNzL2ludGVsL2l3bHdpZmkvY2ZnL3JmLWdmLmMgICAgIHwgIDIyICstDQogZHJpdmVycy9u
ZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9jZmcvcmYtaHIuYyAgICAgfCAgIDIgKy0NCiBkcml2
ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2NmZy9zYy5jICAgICAgICB8ICAxOCArLQ0K
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZHZtL21hYzgwMjExLmMgIHwgIDEw
ICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9mdy9hY3BpLmMgICAgICAg
fCAgIDYgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3L2FjcGkuaCAg
ICAgICB8ICAgMiAtDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9mdy9hcGkv
ZDMuaCAgICAgfCAgIDEgKw0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncv
YXBpL3Bvd2VyLmggIHwgIDM0ICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lm
aS9mdy9hcGkvcnMuaCAgICAgfCAgMzUgKw0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3
bHdpZmkvZncvZGJnLmMgICAgICAgIHwgIDM5ICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50
ZWwvaXdsd2lmaS9mdy9kdW1wLmMgICAgICAgfCAgNTIgLS0NCiBkcml2ZXJzL25ldC93aXJlbGVz
cy9pbnRlbC9pd2x3aWZpL2Z3L2Vycm9yLWR1bXAuaCB8ICAgMyArLQ0KIGRyaXZlcnMvbmV0L3dp
cmVsZXNzL2ludGVsL2l3bHdpZmkvZncvcG52bS5jICAgICAgIHwgIDgxICsrLQ0KIGRyaXZlcnMv
bmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvcmVndWxhdG9yeS5jIHwgIDM5ICstDQogZHJp
dmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9mdy9ydW50aW1lLmggICAgfCAgIDIgLQ0K
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvdWVmaS5jICAgICAgIHwgICA3
ICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9pd2wtY29uZmlnLmggICAg
fCAgNDAgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2l3bC1kcnYuYyAg
ICAgICB8ICA0NyArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvaXdsLWlv
LmMgICAgICAgIHwgIDkxICstLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkv
aXdsLW52bS1wYXJzZS5jIHwgICA0IC0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3
aWZpL2l3bC10cmFucy5jICAgICB8ICA1NiArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVs
L2l3bHdpZmkvaXdsLXRyYW5zLmggICAgIHwgIDQ4ICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3Mv
aW50ZWwvaXdsd2lmaS9tbGQvZDMuYyAgICAgICAgfCAzNTAgKysrKystLS0tDQogZHJpdmVycy9u
ZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvaWZhY2UuYyAgICAgfCAgIDkgKy0NCiBkcml2
ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9pZmFjZS5oICAgICB8ICAgNSArLQ0K
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL2tleS5jICAgICAgIHwgIDM4
ICsNCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9rZXkuaCAgICAgICB8
ICAgNyArDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvbGluay5jICAg
ICAgfCAgMjYgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9saW5r
LmggICAgICB8ICAgMiArDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQv
bWFjODAyMTEuYyAgfCAgMTcgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZp
L21sZC9tbGQuYyAgICAgICB8ICAgNCArDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXds
d2lmaS9tbGQvbWxvLmMgICAgICAgfCAgIDYgLQ0KIC4uLi9uZXQvd2lyZWxlc3MvaW50ZWwvaXds
d2lmaS9tbGQvcmVndWxhdG9yeS5jICAgIHwgIDI4ICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3Mv
aW50ZWwvaXdsd2lmaS9tbGQvcnguYyAgICAgICAgfCAgMjYgKy0NCiBkcml2ZXJzL25ldC93aXJl
bGVzcy9pbnRlbC9pd2x3aWZpL21sZC9zdGF0cy5jICAgICB8ICAxMSArLQ0KIGRyaXZlcnMvbmV0
L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL3RsYy5jICAgICAgIHwgIDc1ICstDQogZHJpdmVy
cy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vY29leC5jICAgICAgfCAxMzEgLS0tLQ0K
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL2NvbnN0YW50cy5oIHwgIDIw
ICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vZDMuYyAgICAgICAg
fCAzNzEgKy0tLS0tLS0tLQ0KIC4uLi9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vZGVi
dWdmcy12aWYuYyAgIHwgIDk0IC0tLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdp
ZmkvbXZtL2RlYnVnZnMuYyAgIHwgICAxIC0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9p
d2x3aWZpL212bS9saW5rLmMgICAgICB8IDgwOSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiBkcml2
ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tYWMtY3R4dC5jICB8ICAzOCAtDQog
ZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vbWFjODAyMTEuYyAgfCAxMjQg
Ky0tLQ0KIC4uLi9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vbWxkLW1hYzgwMjExLmMg
IHwgMTM4ICstLS0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tbGQt
c3RhLmMgICB8ICAgMiAtDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0v
bXZtLmggICAgICAgfCAxMzYgKy0tLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdp
ZmkvbXZtL29wcy5jICAgICAgIHwgIDUzIC0tDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwv
aXdsd2lmaS9tdm0vcnguYyAgICAgICAgfCAxMzMgLS0tLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNz
L2ludGVsL2l3bHdpZmkvbXZtL3J4bXEuYyAgICAgIHwgIDIzICstDQogZHJpdmVycy9uZXQvd2ly
ZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vc2Nhbi5jICAgICAgfCAxMDEgLS0tDQogZHJpdmVycy9u
ZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vc3RhLmMgICAgICAgfCAgODkgLS0tDQogZHJp
dmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vc3RhLmggICAgICAgfCAgMjQgLQ0K
IC4uLi9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vdGVzdHMvTWFrZWZpbGUgIHwgICAy
ICstDQogLi4uL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS90ZXN0cy9saW5rcy5jICAg
fCA0MzMgLS0tLS0tLS0tLS0NCiAuLi4vbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL3Rp
bWUtZXZlbnQuYyAgICB8ICAgMyAtDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lm
aS9tdm0vdHguYyAgICAgICAgfCAgIDggKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9p
d2x3aWZpL212bS91dGlscy5jICAgICB8ICAxMCAtDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50
ZWwvaXdsd2lmaS9wY2llL2Rydi5jICAgICAgfCAgIDcgKy0NCiAuLi4vd2lyZWxlc3MvaW50ZWwv
aXdsd2lmaS9wY2llL2dlbjFfMi9pbnRlcm5hbC5oICB8ICAzNSArLQ0KIC4uLi9uZXQvd2lyZWxl
c3MvaW50ZWwvaXdsd2lmaS9wY2llL2dlbjFfMi90cmFucy5jIHwgMjE4ICsrKystLQ0KIDYzIGZp
bGVzIGNoYW5nZWQsIDg4NCBpbnNlcnRpb25zKCspLCAzMzkzIGRlbGV0aW9ucygtKQ0KIGRlbGV0
ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS90ZXN0
cy9saW5rcy5jDQo=

