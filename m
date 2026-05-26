Return-Path: <linux-wireless+bounces-36933-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFAKKukWFmrOhQcAu9opvQ
	(envelope-from <linux-wireless+bounces-36933-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 23:55:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C95C5DCFD6
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 23:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CF4730765E9
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 21:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145533C8C68;
	Tue, 26 May 2026 21:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QpqaCeut"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0C12609E3;
	Tue, 26 May 2026 21:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832369; cv=fail; b=ASgfv+P+eZcC9wnteVIA3XsJ5cR8n+ostNeCzyWNIU2ecEP61LZLXFWG3v1YzcZTmboC6Vx8FCcKNSiKRsECyacIdJGNPmacCwFKzDYZzY3KvVD6GZLpz6Iy/TTajIB3FBVWa0niGKlQOkqbT8k2DJLi7QjWulc+aoOVuClaZzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832369; c=relaxed/simple;
	bh=RLHFYuQomkE/FL/BJqVi6pWq6kernahDptqIvS2+CJM=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JWLqD/DJd9NQBMZta8ETFCO5w67CmBagC9jp+UorQyVwRAMT8SwS6HeZh9Hxe4FWpewksdd60/8sY4hgj0mkzkhy4LVRXZly2dXm8CG4Xns5yYyQloGhryDUa3tv6XbQWFHOYmF/0QVvczXl6B8VwxCs+gqKd+vrkuXgxwFvYio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QpqaCeut; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779832368; x=1811368368;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RLHFYuQomkE/FL/BJqVi6pWq6kernahDptqIvS2+CJM=;
  b=QpqaCeutWxbvNQjOFW10yOiZF2vFoz/feIsVDRducOaQ4184KSnDa2zC
   dO9pyCe1zXwfVxPKzG1XqnM/KngOOoos+QUmw8HkBboYmDI/NPRp1CLr3
   067QCtKTTIPmCMumIZ6zC0R3xVyJJwTe/v/tKv+9u1UNS+uM0ho9qAwaZ
   1PBPTvrGvrEWzf+Msa5X9Nb65Eb2Qn8295aWZfJnXqasYE38s5SihN8X5
   ehbUYER/pNNm3HnD0xohlGZ5uIzg3W9T4uAiU1gIK93CV7TwTw1yN5ho4
   3SyTxt0Nxd1M/OlXDKUIIZatrYhawaJzoGeuq119B/5q9c1UK5ruKn4uV
   A==;
X-CSE-ConnectionGUID: 3GFiduB8S8+rAS/KFSbfqQ==
X-CSE-MsgGUID: 0RBaJIUFTqe/SiviipMZ0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="98083861"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="98083861"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 14:52:46 -0700
X-CSE-ConnectionGUID: 9ZYCPn2vS5yNAGjsaY8J1w==
X-CSE-MsgGUID: XnPHaSwST/WEsRCEhOgHOw==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 14:52:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 14:52:43 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 14:52:43 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.47) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 14:52:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7VSruFLd/ul9EtPpQzZOKs48ValMSxAhzEKMJx4+XkA59qpmNnaeXcTi/3UYmcOWhV2zYX2w48cUgBWb18XX1bHy+fD1iG9bYRXVmyqlKHPn20V6lJ8yTrwXxRG7BR/IgysW85xzf2IGcV/MZUAMjvquHScGB80YYkdjMewX2fIMkxO+mY7EUG9IIhKn5b3jkC3Cz+tSdXPdbw55nZeKiUiuzOzuPYzps5UZ5iRAIw3IECzBISm+usocX1fpXQRFa3YbBRdvJzoBzsdm2VT4lZB2TkWlTL8HNXdVkXgWKx4m5IiN7I28L8vrusNL6NcLxN0esgbrpjCcs9o6wSXjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clHd+kmbDfHNAw+xb9D8jsgqKzpNCoVD6oS+S8pwL3E=;
 b=kwey+Qwd/IWWrG5SWSlEGprrlFsrkonVbIA4nJq7X62GJmPT+AIA0P1aOIajkh70msYmuSI+zB08hh1gfE4J+KHN4bU1KmynT/JyAob9ohf6uZAihyQ3pTJPzw4742UQZcAJqMQiVgAd7Uf/R1joaHoEAVXCuJcm/sI4HrHF/oXwYbUR8Fn5b0K/TnZwnXNkbAlaIaOhLZPZFmj9ah3PjwULqhnzVn8c18omJAwRaaH5soA9NEksjSxBK9UhondHHGg2/Koz770rgw/pG0rMWDGqxxoMCzSanbq45l5LbO6gC+u4vigYUEX6+BPKfgLQnspLoTJa0x7SYPmspw7Lgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by PH0PR11MB4888.namprd11.prod.outlook.com (2603:10b6:510:32::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 21:52:41 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 21:52:41 +0000
Message-ID: <91ab0907-017f-4d18-9090-dd5ae7cd7a23@intel.com>
Date: Tue, 26 May 2026 14:52:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 08/24] timekeeping: Remove system_time_snapshot::real/boot
From: Jacob Keller <jacob.e.keller@intel.com>
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
CC: David Woodhouse <dwmw2@infradead.org>, Miroslav Lichvar
	<mlichvar@redhat.com>, John Stultz <jstultz@google.com>, Stephen Boyd
	<sboyd@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, "Frederic
 Weisbecker" <frederic@kernel.org>, <thomas.weissschuh@linutronix.de>, "Arthur
 Kiyanovski" <akiyano@amazon.com>, Rodolfo Giometti <giometti@enneenne.com>,
	Vincent Donnefort <vdonnefort@google.com>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>, <kvmarm@lists.linux.dev>, Oliver Upton
	<oupton@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
	<netdev@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Miri Korenblit
	<miriam.rachel.korenblit@intel.com>, Johannes Berg <johannes.berg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Peter Hilber <peter.hilber@oss.qualcomm.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, <virtualization@lists.linux.dev>,
	<linux-wireless@vger.kernel.org>, <linux-sound@vger.kernel.org>
References: <20260526165826.392227559@kernel.org>
 <20260526171223.300914258@kernel.org>
 <9819b5ee-1f03-4687-9a36-9284741e19a4@intel.com>
Content-Language: en-US
In-Reply-To: <9819b5ee-1f03-4687-9a36-9284741e19a4@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:303:b9::7) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|PH0PR11MB4888:EE_
X-MS-Office365-Filtering-Correlation-Id: 2185a8b5-ba93-46d3-22a5-08debb711c3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: qBUZdIn1FDE/l2S9hWfCCf9NdA9MHbOWsyp+X9qHw5hn5yEIkvx7kExR6y3VfSdqptt6pG/z7o8IiMapRshBSwXIRi5V+mWPcro4X5Q1k7n4C2meT2lhAAxdyRo/cH3P7exZD0JWRdNyrIA5QTZRpliy5ccroFE1uPcSOc/zXzVYlzqgeiK0R4xXr6uhX1W4HofSTuf1MPn+6lONdBl8QDZMNYeMfVwBMnxYoZhMLNznLiW4MckGRIvX3RqdZbiLU5HACl6RSjQOrKNUoh/znpbeHtz3waanfRE9ES7uDpb9qvv0WBC+LfQPTwlgcQV8E8ViKiH3jsxUioGokK7+hmr5MxwJtFLxy2rkmpOQYDQV+9Bsf55cEHsBzHSHBKMRc+lNb2ynne5cfcRbsMDtjjtjBHbP4ld9e8xgvifDmLbiQK9Vnh7i4J/PV18hyMM4d/3lWzuJHegsE5Ep8BFGw4c0I8GpOfqXudca7y8nTjFJvJs3kdM5gZvlkikLZTu0of1ciqwSwigAeHmrQkYUM46gL5f25h9Vc10SPncgalM78hc8TjztcmpXtDXVnhKS98XvVeQCUbrmzDnoC5vlduxKYK7P9wtfso7xgV3ngEclCcT58OHq0dBHqRhNL4YC+Pex4ARFOIe526QGrEZwriRYFvkLgT/ek1c1Im6i7v65jUxhgBnUA+bzzzu1yMNZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWFZR2prd05KcUpweEpIeXFnVEtjRElUYU9hYW5lSlNIM1h5anpvT2VpNUZN?=
 =?utf-8?B?QXhZZ3FtTDRlQVlKSjVrQVJ6VFNRdkRYaVZ1WnpXTlZ3Y3UvdndHL3JKZC9S?=
 =?utf-8?B?bkw4ZFIvMldaczZLaGFuT0RRYTh6U0ZKS3RqV0hITkRqMHFieFJTR3JCZDQx?=
 =?utf-8?B?Y3pXbGttRkZtQUg4U2JwQVRXVXNaSnk0Y2RlZnFIb0ZIVWNQQWlwSWZkTGVo?=
 =?utf-8?B?QmFKYklnT2hLZ2s4Yy94WkpWcmMzN0o5Rnh2dG5MVmJxTnI5THRYWDZodmF0?=
 =?utf-8?B?ZjE0bXJIeDNUUThFTDJ1T0dKZVZrcWdncFRtSDlZZGkveTQ1NHJML0hGbG1R?=
 =?utf-8?B?cE5tMXhMQ01XR1d0a2ZBRWRKZ01KUHpzTEdoTGNkU2RQQzVUQTFJTTM0emU5?=
 =?utf-8?B?RzNZM1NicThWNDY4N2U3elI5REFFcmY5WDU2RC9EaVZOR2Q5dUl2blhhTllJ?=
 =?utf-8?B?VHNSZ0dYMVczbm9vSGVESFFqTUZRai80Tll5RitBaVVGN2tGRzUrRUhCMzZq?=
 =?utf-8?B?a3lBQjJkZ1U2VUg4bXFDZnFYZjkxMHFQeXlTcVlDV1U0RmQrbmh5RHRRZk5p?=
 =?utf-8?B?WmxKcGNYak40Nmh1T3ZRdDJyd2JiWEFWa3Z6VEQwdVRUbXpWWE9MUnZhMmtj?=
 =?utf-8?B?Y3I2MTRacXdNQk1ZSE1obVJFVVR1dXFuOTh3RG5oYk5Mc1FoNDRiNHk1ZVRK?=
 =?utf-8?B?WEJkeG5RY241ZWw4cXNnRnBreklLVGIzWXYyeU9HL2pYMkpZME5CaUNPOWli?=
 =?utf-8?B?UmkvTEtTK1VVMk5jcUR6aGd6RS8zUnc5SU1yb3VNTG91RUpBM2plQTRYSlNR?=
 =?utf-8?B?WkVGVXFhbkpXZWZlSzV1KzBVaVUxbE9CSml2MmVWOEVqbU1tSlE3VElMRWd4?=
 =?utf-8?B?UG04b1h1WEx3K1hWSVdwTHZiT2hpWkljeGtuM3AwbVZ0S3hlNVdMaXQwL2V0?=
 =?utf-8?B?K2NJVjQ1enBuQjJnSWxxU1pUbWZZeWNqRmJGYXZuM0ZBa2RmT0cxNjlmYllS?=
 =?utf-8?B?RW5NbkRWVXNlb3BEc1BTcTB1cVIyS0RHelB2bk1PRzU5THBkNTFmQmFPbnJt?=
 =?utf-8?B?TzdPZ0FsRCtldXE3a0JRMW1qVWZJTWVmdFUrNTFRL3QxZTFoa3NMdEVHTU95?=
 =?utf-8?B?M2MyRCtTa2VGWDJIWmxMN2FJbEp2MzhQYm56b1NNdGFWZXV6aFZKdEluTDlG?=
 =?utf-8?B?Z2YrYmpCczlKdnBvQnI3V0svSXJjUEdWZVBER0U2TUZwaVpnUnNwRlptQ1RS?=
 =?utf-8?B?V2dJOXF0SFNvdU00TmwrNCtveVd1cUx0em1WOUFEbVZPU2JibEpDMnFpdS9L?=
 =?utf-8?B?eVIvU0FFTWRhUmRYbmxSR2R4ZWRNckpwZWszeXRFWDJXT2pTcDNHdmFJZm9i?=
 =?utf-8?B?VXlUa0N4QzJYSXp2RUlPL01JbDlGL1pSemQ4TTlWQkw3dDI3RHY5eS9iUnV0?=
 =?utf-8?B?MlN6cnJVOEpOQ2d5aEVwaUh1aksyNldjT3Zud2g4NysrQS9IU25yR0RUSVBa?=
 =?utf-8?B?ZzFCSmVVTWpOcjhKOU85N25RK0RwNkN3aVcxck9mUjhjT3lTMmQ1SG9YNzN3?=
 =?utf-8?B?MXB0bFZsTHppWWYzYkpyK3RpMWs4VmsxNzQvclhFUlVnMWNnVXk5MTFQcmdH?=
 =?utf-8?B?dVZ1eDd6RmNjaEh4ZUk3MlhURHU4NmRrVlBmUHJreEtNRlIrN0d2T2J6RmEv?=
 =?utf-8?B?ejZKcXBpMG9ZQ3pEUHpBNFpBM0kzUENxb0ZxT3BLUndKOGV3bzg4NmRNUzB1?=
 =?utf-8?B?cktobWc3RVVBdVgyUWhwV2UvYUdsaHEvY0RNTzRKWEVQd2F3NzdEdVRXc21Z?=
 =?utf-8?B?emRPeUV0THpCOUhFWmxoZDUvaDNPbzBYeC9SbGRsTVpxVEMzZzhxcFhDZjFi?=
 =?utf-8?B?N29RaExoNW1kZDZPN0VUNlZwYWwxdnJJc05CYmN2WHNRaWd6UFNFdmp4Y2hp?=
 =?utf-8?B?RDhzUmFvditJZnUyZWw3TTZ5YVh3TnVnbElkSXltaVZzaGttbVBxQ2pGLzBp?=
 =?utf-8?B?R1ZTMFE4NmFDamhwdUNhUWt6aFQyQ1NaSkJRVkd4c3VsTDAyR0djN3VwU0Jw?=
 =?utf-8?B?a055RGpQd0lFRUNGTktxL003QkJpL05IWmJZUTBIOWJTME9VanNvd2piOTZE?=
 =?utf-8?B?b1RQODk3UmlGVUhGVENFMkNrT3BBd1NVZnFVbEF6Y3BFMFlmUjB5OTRGeUg0?=
 =?utf-8?B?NWpNN3VrUThtOVROQXFJdWVLOGNxZ2dieUNNL0pkbWxKT3Q5bWZRaDF1dVJu?=
 =?utf-8?B?WVVnZElKZjRVNHI2Q1llWUVNKzV2MjhDYWJja3Fvc0tRMU80ekhZUmU0VnBv?=
 =?utf-8?B?MHVUY29VS0xEU1RDR3pmNXQrcWVWUWpTZzFKRVRLZzFFTk1OOHZwUT09?=
X-Exchange-RoutingPolicyChecked: deRclGY9vYli/wgBTQAYYhjE9eBRsvsIeU7GFABe99C07NcdVUDM2wtHD0AOAuOB70NV+8OVg/AGdcxHLtSc8deqlvD4KRQGQuwAQuz+b2kspRU2Ee9vpxHuYtAtJIGyRYkXB/5A5DepeDMz3XOsNR9q8G3a/0DpDyHpb7Z8e7D7uRz17JrabPpvVl0kj61WFWGUXCr6+yVGMm2dAn6cIUSCZIY9OUY/eumOzCU0Vogc89Vc3KbAMW+vKRJZdMoneE+o2NcnaCuIAll+8PqvZpnAR/8NMoxaGjgfrWaatNdwZUwYnTEJIFhCnpDs+c4Lj10x3O4DEVRu6VHBzHq9Bw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2185a8b5-ba93-46d3-22a5-08debb711c3c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 21:52:41.3518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2jLpYw1N9oMPdHTzg7G3PpZDA1viTvFT6V7hd1Jut0Hwve8dOLtm42ObDvbt15ecqGycRtr0C/zyI5fBXFRZwgMYZSOp2rJnjUxp8DlHAB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4888
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	TAGGED_FROM(0.00)[bounces-36933-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,enneenne.com,linux.dev,lists.linux.dev,gmail.com,vger.kernel.org,suse.com,intel.com,nvidia.com,oss.qualcomm.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:mid,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 6C95C5DCFD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/2026 2:49 PM, Jacob Keller wrote:
> On 5/26/2026 10:14 AM, Thomas Gleixner wrote:
>> All users are converted over to ktime_get_snapshot_id() and
>> system_time_snapshot::sys.
>>
> 
> I would have expected this to also remove ktime_get_snapshot() since the
> description claims all users are converted to ktime_get_snapshot_id().
> 

Ah. All the users of the real/boot paramaters have been updated, but
drivers still use ktime_get_snapshot() until later in the series. Ok,
that makes sense.

