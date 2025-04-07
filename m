Return-Path: <linux-wireless+bounces-21184-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEE8A7D47B
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 08:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DD6416FC94
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 06:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C562225776;
	Mon,  7 Apr 2025 06:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RkXXO/k6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0689B221561;
	Mon,  7 Apr 2025 06:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008500; cv=fail; b=IYN7VqzYdxOxGOjbgIh/hyyVIhcUg5uUdj4TYxeJAedMe6UZhFgQBStQQeWrEe8rsZyJJA3MBVz+WnSOqMG7q4JT1MycuD38l2F7P/Ikqt2pMeAX30cLK4KShXfLwzIyt7caS3G3KbjAnwp4pn8LUTq2JuPIlOfDQaVUX7nCBK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008500; c=relaxed/simple;
	bh=iah0P5QaG8wf9/68al+a91KrNf7xZ2qSOsyY0adHDKM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kF6s1Y2RLgzJLmzAOvAj7Pzkxs6J+SSGBWgu6J0XUVyEus0O4Jx6u9pmel7+FbYb171nZf3iKcFJRg14BhpwLQyaMQj6sKL6s3h97iWt7n1ZCQYVf2obj5vd1qoucM3VsvMK3Po3imvhBwCOkga+6a9eEi6wus+cqadNYseN4rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RkXXO/k6; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744008499; x=1775544499;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iah0P5QaG8wf9/68al+a91KrNf7xZ2qSOsyY0adHDKM=;
  b=RkXXO/k67NwNPZc5dW509Mu5ztY7xdlnvvHZ2P64mrfgUFi5L2sFK8/l
   3rgcnsif/aZo7PubuPveK9nv3tdHebdKgcYtjNkoSakl2gHPxbbtx25DJ
   X8GBmYEj+83sErQslKqKhY1g4kZl3Gmo4cCBM6bsvIdsKoqrLwzfPcGog
   UWb7pmF65ICTd5+kU8g0KQLlulxZLBqui4KmEOdOuZ1LMkXSxBIVYsY0d
   Blh9NqISaovcJbjEfkRyrfPX+5z1niohsKVZYTGI4NPuiCeVis7coDs58
   2wDokIiXbwtGdS2BUNoEF0oKXscq3kCfbB/I/mQJwxKDHojPFGNLgOaDa
   A==;
X-CSE-ConnectionGUID: rhnvsB0NTzWuWZhLQjglJg==
X-CSE-MsgGUID: tEyrp9CUSSi1Cy2QSjowRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="55563210"
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="55563210"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2025 23:48:18 -0700
X-CSE-ConnectionGUID: D9LgNaxjRXuqcabbcQhUgw==
X-CSE-MsgGUID: IIaOxn+tQ5W2rgy5+37v+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="132702368"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2025 23:48:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 6 Apr 2025 23:48:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 6 Apr 2025 23:48:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 6 Apr 2025 23:48:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I67/MpvtYvAyE3SMs+TXw8cGurTfwNQooN3f4u68tTMUHVYSlw9clwf/MeGFzWGtl65bse/nVq5ejMVw/gUtWhGAe7P0T95kuK/W//Fs9jv6gEkhFGi9KJCOthdAE/pWKBHeeW1H2/FrfMdT+Oa9xn75vvVpkjjgeFrdtzP9e3YJLGkaN6xnbAOvGvdCp+4EkmJqy1sa+hGPIUkDHrvkpsnZpkgIk1TW1Al9a1W1VZQICvRdmaPr5n6lrXP0Ov8awb+ZWtxm3uWZrpYB1dvm4bRfzQ7R4NdqHWbtphGX4m/Tyqu3l9qPRSIYnbej8C0pYee8XQA+P322cC8FRiEoug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iah0P5QaG8wf9/68al+a91KrNf7xZ2qSOsyY0adHDKM=;
 b=faEtiacD2BFwM1wUD28E3eAyN67GlkDVOouBQzXctEBRyXwzocXCOJbyRw1LJYCwhG1ghQrVUq8g90LUbiwhIXdn/37jYY5loIOwX0k7fOTCrd/a/Qn6APWRq9deyq3JctWaRsl41hR2nSsZB7V0WhZgvvf8y3vXBqGtjpQH4GyYmuyHrd6xCUcnlxj1bn/WwSC7ST24ZXP0X+TcEB8luyMfXca/TVyNb098CA2XABA27a/p/pbA6RtmrA5DkF+SqeC2MzbWxpj2PaQnqENFuNfm6dKSlWBJRV1YKUJUSJkN9pleEbGbz7T4sYqK2LEzE2urotACuVzdbbOAaK7zDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by BL1PR11MB5285.namprd11.prod.outlook.com (2603:10b6:208:309::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Mon, 7 Apr
 2025 06:47:59 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%6]) with mapi id 15.20.8606.027; Mon, 7 Apr 2025
 06:47:59 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, "kvalo@kernel.org" <kvalo@kernel.org>
CC: "Berg, Johannes" <johannes.berg@intel.com>, "Grumbach, Emmanuel"
	<emmanuel.grumbach@intel.com>, "Ben Ami, Golan" <golan.ben.ami@intel.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: iwlwifi: mvm: Add error logging for
 iwl_finish_nic_init()
Thread-Topic: [PATCH] wifi: iwlwifi: mvm: Add error logging for
 iwl_finish_nic_init()
Thread-Index: AQHbpxLqKxE3UsaqQEaP18krC5luIrOXwxOg
Date: Mon, 7 Apr 2025 06:47:58 +0000
Message-ID: <MW5PR11MB58104BFF8F49CB7D5A2EA54CA3AA2@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <20250406164206.1120-1-vulab@iscas.ac.cn>
In-Reply-To: <20250406164206.1120-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|BL1PR11MB5285:EE_
x-ms-office365-filtering-correlation-id: 35dafb17-9e91-4ccd-74e3-08dd75a0227c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RTZVaS9RWTdjZldldDNyK3ZzcUx5SHppNVVNU3g3SC9jUm5naEhSSiszVEI3?=
 =?utf-8?B?UjNsOGtGNkJoOUN6QkwxemlHV1hpUmt1amNHTUhLVityb1dUYjRSQ2p3U1V1?=
 =?utf-8?B?TEJ3alJFankvaGpwLzBlN3lYVXlCM29NN21hTmt1QjUzS3oydGxxb0xlaEsr?=
 =?utf-8?B?YWJYU2RteEZzY0dmcFp6OTV0Wm9XSGVHQnVFclRLUnZRelVQd3NyRjFvUVBq?=
 =?utf-8?B?KzE0c2dEMXZLNmNuWkIvYnNvbGRTOUZOM2ExMCtBMXNMYjNqN0JwUUQ2Uk5x?=
 =?utf-8?B?ZmViSFlXMTh3TnVkL20rSWZPL2Q1cFQvQlpWUUVPaDRDa3dHQ0RtdzgzeE8y?=
 =?utf-8?B?N0ZpKy93aDdLaEtiVjA0amt2M3JTWkFXVXhFclYwVmg4UjQ2Q2E0OGd5MitF?=
 =?utf-8?B?NUMxYjlXd1F6Q2kyazBadW1iZG9lNCtOemJ3SmpNVXlVNm1COGUxVU1uMW9i?=
 =?utf-8?B?blhmSnRBalNkOEZiUjNNdmwvWkxIRW1KU3M2L1ZGRDE0TmdYQnQ1MkNjVEdF?=
 =?utf-8?B?QkxPNms3WDlHQzBVUWdacWZZb0Y4d3RGZW5zWXVmc0ZJczQweEJmUktJenRo?=
 =?utf-8?B?cmlOclZBVzB3NGpUMUJZUXJhTjluM0tZUkJhU25YUklrK2xEMmNKVVBDMHBj?=
 =?utf-8?B?Ykg5UHVmMXJTcXkyVTQ0Zk9TaGZJNkE0U005ZXdiUDYyY3BaUUlvM2FNd3Rv?=
 =?utf-8?B?YXg3TVNCZVlsOFhRbC9NMkswN3JJYnYwQnB4dEpMSnRUcFZVK3J0Q1R2dlBm?=
 =?utf-8?B?OUxNcjVPNjF5TG1ySENpYVhPQjByNmxZWTJwN0Q0dEZHSUtnQ0lRY1JnWU9U?=
 =?utf-8?B?ZjBMZzRrUGZRdVd1N2p3TWozbER6Um55MGNZOVZWUjdkZzJYZFVmVXZGTEd1?=
 =?utf-8?B?UTAwankxbU9vWC9DVitYdEltMzBKWDE5cllrQjhQc1MxS2dBQXdHcEQzNng2?=
 =?utf-8?B?MWd1a1h0Szc0R0Ixby9GY1BlOWVJYWxUditOa3ZJcFpoQkIvMWNuWjBuNytR?=
 =?utf-8?B?ZWgva3dnRHBjOTBoRGRoS2t0SUw3SUZJMDl5YUxGVWQrbnFYcXdXWVhVVkVM?=
 =?utf-8?B?dnpvWFoxd05LRnF0ck5YcXdaZzRpYWJuSDdvZlNWQ3JuR2cwUkNNZjdqQnZR?=
 =?utf-8?B?S0xtcDNzNzFkclNQOTVJdVl1QmhZdmtsRTJoRDI2RCtNUktNV3MwU2s1NHNH?=
 =?utf-8?B?cldOdkhuMjBKTkZQbDZNS0pkRWlCTmdTZlQ3M1VVK1daT1paaDF3b0l5ZURQ?=
 =?utf-8?B?dk1JQnl4WVkyVTRYNmttUmZJQzJCMW1QbHJFRlZJRXQyZktXM25WdHZTMFh2?=
 =?utf-8?B?K2dmUjlaQWMvUDFRcnVTM05reDBpc2J1TkxjZG1MdFY1K281VTdueE8xTnc5?=
 =?utf-8?B?enpRdkZUdDNqVnpzQytnU2VVVEoxbXpSOUp1SzEyU0FmSENNeFVHSlAyN21C?=
 =?utf-8?B?eU0rSllnSkJmeVJ3ZUtPQXR4dDdOaFRKZGR5U2tEekJ4Q3JGaUprd3QvamNR?=
 =?utf-8?B?UTZCeXkyMGd2QUhHUGxsakpGTHdtNmEzWUc1dFBGd1FLVXhsQ1JPR1Bldmx1?=
 =?utf-8?B?VGpacVVZZDJyTk85NitsRkJUUTBIQUdTQ09sT2xHYm54S2Vtc09NU1pGNi9h?=
 =?utf-8?B?NWcvZjBER2g4THRuSWUya08vQkxpM0doQmE5bGRhdjZib2M3bEV4UER5MU50?=
 =?utf-8?B?Zytjb1dtYjdDQkZVL3puZk9kTFhzODZSUmJnVTNtZVVkcEhNOG1aUVhpRFdL?=
 =?utf-8?B?YThnenh5NEF0WVUrOXFnaTR1YUMrS3B2dUkrZGFwcEhoMTJmaEZQeXJ1Z005?=
 =?utf-8?B?WU5rdHlwcFI4MnJpOTR5SjZRMDhzRUl2ZURsOVNoWlNoVjl5czJwMHVmTnRB?=
 =?utf-8?B?aFplTjQ5dlpydTVWQ051T2hET3htWGw4V2M4Q2hScUtyQzRkbGEvSlhTdWcx?=
 =?utf-8?Q?NCaQjMMRCecnsm4MxVpWYqyVQgaU5RLe?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWFzNG0xUHdVcjFSV0F5dVM3dTArZ0JzOEllY0QzWjFVcFg3Z0QydmY0bmVW?=
 =?utf-8?B?czJDeWEvRmZ4b2VTajFVaDBSQ3dVckorbGxHNjJCZk03MEJKNUhYUGlyVU44?=
 =?utf-8?B?SUhNUE5kejRTS3AxemdiYWRUVjJudGtoVVRINW5rWVd2MFZBTVVWL05TZE9i?=
 =?utf-8?B?Vlc4Z2phM1ZtTmgvUHZQbFRMU29BamIrVDBVa1VEL2lwdjNhRnhTS2UwbUVv?=
 =?utf-8?B?cHp0S3Z0QmF6TTBrSzc5YTZheVFSNmpRSVBMR2dsWVIvVkxWTW9tcXhrMVJX?=
 =?utf-8?B?SGpPckdGN2hJSzlqSExkMDJWYlBSSCtKSHVYSmhQSm5CODg5UWNGdVhTNmhv?=
 =?utf-8?B?TGZNRm5KUklKcXdRODBNaUxHOFdKOGFVS1hUMVBabTk2OWtEOXRNaWZWbGFz?=
 =?utf-8?B?WkdQNUNaQURqYW5zZXA2TXhYV0dvZ0hnS3pyN05PRFhRWFdVZnBzbERKenB2?=
 =?utf-8?B?cmdlSDlpWDlNOG1OemJnazlqWUtaSHVYODNRM2tjcFRjRnZpWHNlTXdIK2tl?=
 =?utf-8?B?MlRrK3pjVXdOdXg1Z2c2V05mMlVwUnZQZnVGTzdjcUNVYlBOSlNKT3ZQTitE?=
 =?utf-8?B?TDF5Qk0rY0lmWEVqa1VDWVpQMGE5Z1d3ZkhhcnNoWitnTVB6QVVYTExKZE1x?=
 =?utf-8?B?R2IvM2ErUWxDb3lEUlhHNDhUL2txTVpHeXlic3ZIQmtPNTl0WE1GbXhGYTYy?=
 =?utf-8?B?MzlUdExnQ1YvWmROTUN4dFJoellRK0krdENVSHBMTkovS05sWWIxUzE4aS9w?=
 =?utf-8?B?OGNvVU1ZSkxUbXZNWjN2NkVpMEhZNHFFMUdHWW42TTlueXJzM2ZTMEZIY3Ju?=
 =?utf-8?B?MyttcnRYN2RGeUVLMDdKL3BXbVpwT1FIc2tDZFpPS1NpSVgwUDhGQThoYStR?=
 =?utf-8?B?a0hKaGZiR3JxaGU0R2twbmcyUDVQczZzVTRITGtuT3lFTTlnRDR5blE0bm5x?=
 =?utf-8?B?d3dKcVV0UTA4enpiR1Z5SFY1M3lKQUVPajdCajdjcUw0dFAvZkU5QjB4NGk0?=
 =?utf-8?B?ZWdXVVc0MGpBemkrUDZHaVZSdVBvZlpDMVUvWGlUNDNmR25Lak14dGpqSHFI?=
 =?utf-8?B?RlVjY1FvUytTTFRUN3N4L2hOSWpkY2I3VkRZNWowNzRjMUJCak82MCtNVU5Z?=
 =?utf-8?B?WUNCdmErY3l6aW5SYUhRQ1hTZHNDcGorUzF4UWpscHZaSkpXc2Zhc0FUd0lV?=
 =?utf-8?B?Q3d4c3JuTUlud0prczVlVi9ZU3UxY0xoa09SZkRrY3E2TEhPWCtkQmNQSVk4?=
 =?utf-8?B?YmxsQzQ0cXZTLytLUGhDT2ZncHAwYmpqemhIVWZzaGluMkh6QmdQNWlkbkU2?=
 =?utf-8?B?dllzQ1Y3VmZVSDZ0TmtXc2tKdjIzL0VLOHRRdjVNOThPQ3c1Y1NkbHZzMkVL?=
 =?utf-8?B?cUppa2pRVFR5K1NzblZzd3p2RE9TVVNsaFg5aW1seE9CamhnQk1XOEpwSlp4?=
 =?utf-8?B?cXJJNFJoRjNLYTNJc01qUUZma1o1L2orRUhqN0lKL0kwOFV1ZDdWdi8xNk9V?=
 =?utf-8?B?akYwRDlDVHlvQWx1b2Zld2JxUm1ScWR5MFhCRnNXb1YySlBMa0ppcGN6N2xi?=
 =?utf-8?B?ZjBUZ2tkZ0REbTg4dWd3VExwaWlJekZtV3EzZUhsOTdKd3cyTGthNFRoUnlL?=
 =?utf-8?B?d2I2UHFHOTNucEJWeUFVdlk2WWZaeVVkbWR5NUdKb2NmSERZMmRaWk1Sa1k5?=
 =?utf-8?B?dm5pNHVPQXRRZkhuYjBsR09zT2xSSVVWSlJybmhkSGxJRUNoTWE1aFJSNXZV?=
 =?utf-8?B?WUpMclBrZ2hYVURJNk5hRG92aTIvV0g4TTNsNVB2MDRLVEtkYm4wcDFvSHFI?=
 =?utf-8?B?SUJkczBPUmF0R1hGbFdKak1WR0FrRkVuRlhkSFhwbHZpQjdSM3F3WjdXcTR0?=
 =?utf-8?B?cEkwU1NVNUFvNkR0WHlCbWhOZ25ZaWNmLy81dk1NMWsvYnZSQytDdkF3Sk81?=
 =?utf-8?B?ZkJBdGZRdEhmQnhLR2JHRTN0RFRsVUFoK25xZXQ4R0VHR0Z4MHpIdnlDK2d3?=
 =?utf-8?B?a0RXOGFKNDFja1RVeEFocCttVHFHWndrY3BqZFdXcm0rUDJzQ01nR3lEc1RV?=
 =?utf-8?B?N2ltVHk2cHFBcVVlUW9OOEJPQnk3TEUrOXA5QlVYQ2Y5MnF2Y2JjU2ZpQlcx?=
 =?utf-8?B?dnUzNWloVnNRNTBWOWppb0UyclhENzArUTNrZmx2UGdGd1kybkgzQzNlbWQ4?=
 =?utf-8?B?K1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35dafb17-9e91-4ccd-74e3-08dd75a0227c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2025 06:47:58.9901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: unixW0FHZ0gJAYD5PL/3KHDtwqPLBaGleVEMvzVTvXo0koqL6HVbRsH2cCTK9HwtFsHUIcWNZx19zRBSOxTXGKaGpi4h32is0n7F2x/TvZhMaNc8mB0pSXoiRzz21dUR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5285
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV2VudGFvIExpYW5nIDx2
dWxhYkBpc2Nhcy5hYy5jbj4NCj4gU2VudDogU3VuZGF5LCA2IEFwcmlsIDIwMjUgMTk6NDINCj4g
VG86IEtvcmVuYmxpdCwgTWlyaWFtIFJhY2hlbCA8bWlyaWFtLnJhY2hlbC5rb3JlbmJsaXRAaW50
ZWwuY29tPjsNCj4ga3ZhbG9Aa2VybmVsLm9yZw0KPiBDYzogQmVyZywgSm9oYW5uZXMgPGpvaGFu
bmVzLmJlcmdAaW50ZWwuY29tPjsgR3J1bWJhY2gsIEVtbWFudWVsDQo+IDxlbW1hbnVlbC5ncnVt
YmFjaEBpbnRlbC5jb20+OyBCZW4gQW1pLCBHb2xhbiA8Z29sYW4uYmVuLmFtaUBpbnRlbC5jb20+
Ow0KPiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IFdlbnRhbyBMaWFuZw0KPiA8dnVsYWJAaXNjYXMuYWMuY24+DQo+IFN1YmplY3Q6
IFtQQVRDSF0gd2lmaTogaXdsd2lmaTogbXZtOiBBZGQgZXJyb3IgbG9nZ2luZyBmb3IgaXdsX2Zp
bmlzaF9uaWNfaW5pdCgpDQo+IA0KPiBUaGUgZnVuY3Rpb24gaXdsX3BjaV9yZXN1bWUoKSBjYWxs
cyB0aGUgZnVuY3Rpb24gaXdsX2ZpbmlzaF9uaWNfaW5pdCgpLCBidXQgZG9lcyBub3QNCj4gY2hl
Y2sgdGhlaXIgcmV0dXJuIHZhbHVlcy4NCj4gDQo+IExvZyBhIGRldGFpbGVkIGVycm9yIG1lc3Nh
Z2Ugd2l0aCB0aGUgZXJyb3IgY29kZSB0byBhaWQgaW4gZGlhZ25vc2luZyByb290IGNhdXNlcw0K
PiBpZiBlbmNvdW50ZXJpbmcgaXJyZXBhcmFibGUgZXJyb3JzLiBXaGlsZSB0aGlzIGRvZXMgbm90
IGZpeCB0aGUgdW5kZXJseWluZyBwcm9ibGVtLA0KPiBpdCBhdm9pZHMgc2lsZW50IGZhaWx1cmVz
IGJ5IG1ha2luZyB0aGUgZmFpbHVyZSB2aXNpYmxlIGluIGxvZ3MuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBXZW50YW8gTGlhbmcgPHZ1bGFiQGlzY2FzLmFjLmNuPg0KPiAtLS0NCj4gIGRyaXZlcnMv
bmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvcGNpZS9kcnYuYyB8IDUgKysrKy0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL3BjaWUvZHJ2LmMNCj4gYi9k
cml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL3BjaWUvZHJ2LmMNCj4gaW5kZXggOGZi
MmFhMjgyMjQyLi5mNTc3ZjhjMWQ1YjAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL2ludGVsL2l3bHdpZmkvcGNpZS9kcnYuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVz
cy9pbnRlbC9pd2x3aWZpL3BjaWUvZHJ2LmMNCj4gQEAgLTE2MTYsNiArMTYxNiw3IEBAIHN0YXRp
YyBpbnQgX2l3bF9wY2lfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldmljZSwgYm9vbA0KPiByZXN0
b3JlKQ0KPiAgCXN0cnVjdCBpd2xfdHJhbnMgKnRyYW5zID0gcGNpX2dldF9kcnZkYXRhKHBkZXYp
Ow0KPiAgCXN0cnVjdCBpd2xfdHJhbnNfcGNpZSAqdHJhbnNfcGNpZSA9DQo+IElXTF9UUkFOU19H
RVRfUENJRV9UUkFOUyh0cmFucyk7DQo+ICAJYm9vbCBkZXZpY2Vfd2FzX3Bvd2VyZWRfb2ZmID0g
ZmFsc2U7DQo+ICsJaW50IGVycjsNCj4gDQo+ICAJLyogQmVmb3JlIHlvdSBwdXQgY29kZSBoZXJl
LCB0aGluayBhYm91dCBXb1dMQU4uIFlvdSBjYW5ub3QgY2hlY2sNCj4gaGVyZQ0KPiAgCSAqIHdo
ZXRoZXIgV29XTEFOIGlzIGVuYWJsZWQgb3Igbm90LCBhbmQgeW91ciBjb2RlIHdpbGwgcnVuIGV2
ZW4gaWYNCj4gQEAgLTE2NDcsNyArMTY0OCw5IEBAIHN0YXRpYyBpbnQgX2l3bF9wY2lfcmVzdW1l
KHN0cnVjdCBkZXZpY2UgKmRldmljZSwgYm9vbA0KPiByZXN0b3JlKQ0KPiAgCQkgKiB3b24ndCBy
ZWFsbHkga25vdyBob3cgdG8gcmVjb3Zlci4NCj4gIAkJICovDQo+ICAJCWl3bF9wY2llX3ByZXBh
cmVfY2FyZF9odyh0cmFucyk7DQo+IC0JCWl3bF9maW5pc2hfbmljX2luaXQodHJhbnMpOw0KPiAr
CQllcnIgPSBpd2xfZmluaXNoX25pY19pbml0KHRyYW5zKTsNCj4gKwkJaWYgKGVycikNCj4gKwkJ
CXByX2VycigiTklDIGluaXRpYWxpemF0aW9uIGZhaWxlZCBhZnRlciBwb3dlci1vZmYgKGVycm9y
DQo+ICVkKS4iLA0KPiArZXJyKTsNCj4gIAkJaXdsX29wX21vZGVfZGV2aWNlX3Bvd2VyZWRfb2Zm
KHRyYW5zLT5vcF9tb2RlKTsNCj4gIAl9DQo+IA0KPiAtLQ0KPiAyLjQyLjAud2luZG93cy4yDQpp
d2xfZmluaXNoX25pY19pbml0IGhhcyBhIHByaW50IGluc2lkZSB3aGVuIGl0IGZhaWxzLiBZb3Ug
Y2FuIGVuYWJsZSB0aGF0IGRlYnVnIGxldmVsDQp3aGlsZSBpdCBjYW4gYmUgYSBnb29kIGlkZWEg
dG8gaGF2ZSB0aGF0IGxvZyBhcyBhICdJV0xfRVJSJy4NCg==

