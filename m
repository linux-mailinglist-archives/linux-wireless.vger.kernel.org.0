Return-Path: <linux-wireless+bounces-26224-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB695B1E235
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Aug 2025 08:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69CA016A2D7
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Aug 2025 06:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EB01FBCB0;
	Fri,  8 Aug 2025 06:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dELTiGU3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67A11DC9B3;
	Fri,  8 Aug 2025 06:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754634092; cv=fail; b=OWpvbykC0JAhvWDLOF9/Tst4+Op9xtVGvZ+wLwp45wr/eCQ6DCux3XQbKJVdkOWUR5i1t6fWYM73Fs82BqRWm1QZbjbDD+IZc5+0Uo/Hrp5vVMWnAtiPt23nB7+lc29voqW+ExJ8nlNjPUqblZYoE0LB6HPqB9upOgIWpTFn5gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754634092; c=relaxed/simple;
	bh=paMKXUsgvfwGzS6QUUrrXhKR9Ikkw5j4g55l5TIZ7HQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HUIpgJDABfoV+OwQdS3kSc3jhlNVj2IGHEtUFa1LmJbjoVsBZ1GNYEiG7My6oMiJv3aJvDlY1ztDxzj/+NJbkQHC5SPwsBc+RaKrvlrfta3FnV6+GYtGVyWSCqws0gEB1ZjHi+c5IJZa9mi82WDFZU/g3KKkyInKaP5KM8B8lfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dELTiGU3; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754634089; x=1786170089;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=paMKXUsgvfwGzS6QUUrrXhKR9Ikkw5j4g55l5TIZ7HQ=;
  b=dELTiGU3AxeX/aCbvFA1b8cWTzRgPLRPW4XSsYEkExy8NSebb5Z3x5uJ
   VfPROy+qLNeSRHNYbcKULZ237Bul9DuhH4RDSeaFH6ORBxW5Zpc/lGg3U
   yLYP1/MGhzDQNKe53z6v6ZUCKrNsOYFxbF9AHEnPPZQzr+MS38kkW/P/k
   mhp2nkTAA0xFveM+Kl8p9wIAlnjbucxNhmMQve1SI/J8kbLK9P2+woKLe
   SIVMzgSXgf8/hIPYomWexqmtejTx8vI3OlcS6LuTAg15k6IcoowF4/6R6
   mu88xkwT369N48RtS0obniIwx1ud6EBua9XpEciKoAYzuyUwjksElTOkm
   g==;
X-CSE-ConnectionGUID: yYdo6CPsQZa8L9GVLPobBA==
X-CSE-MsgGUID: YPVqAQSbSwy51+4of6sDQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="68057683"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="68057683"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 23:21:29 -0700
X-CSE-ConnectionGUID: bFwl/01WQe2ULeS4EyEYAg==
X-CSE-MsgGUID: yPe41WEOSAS6jUHLQtVVTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="165153858"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 23:21:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 23:21:27 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 7 Aug 2025 23:21:27 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.72)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 23:21:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o57TPmTz55m1fayRbBsN6ijd6bi7FK/Ti9JvxtYg5P05RDmLZDhU9VGnTsIZN8hds7adPwUPNq6+8j5Kf9MY3MQm4Xc5bdc19uN8JQnmNPUpmuHMN+eMo+9ymmj6sMjBmjegM/GlNJiBcSa1KRIPqIwyjM41zLVRGekPsF6LFUkn0dY+SxXbAN76JcCBuCck2dloNOo5kMVT3umzNOKQrKKUiyaURVv3XPko8MCdDFif58UBaKyl+t2boUSp9esHmskbmDlERFz/VBwTrraWau5H2gvNDtvSJM1dBAqWTohq0bAIT4RFDvEWxjpZNVB9/wb+cw+/tei5PNgM/9GiBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZVv9nj0gLDGMim2nQ7aA0mg6QIa8W/C8TimwsLhfOg=;
 b=EXpKKFzc19u2ek6Njx9WO5zdH2zk835uekbwY817alsSrzUCfWpakgdEk/uPrYonYZoRydSvG7bBMHEF6Me9jiHzxxDEuliqyfJ88iiI7IIOw2iOSRUEDHL35OlB9JqNqbWmkmJEmyWSvlWVk8HGBjfFSBvuhUoFhfhXd6Wj/+uWxzeRZQTNxMuo4fjxOvXA1xsAKIpWis9BM9Ypl/Z8scyCCh3FBySLNZG8EgNOypznZEcgjt4q6H5zrF/DOkTJxISvYyoAI/i7iZBgpKPV8znB2dbS0px/PdBSIAO7t8B8Y45B81uaQm1YgX1UOxIwNVzryHLmeLP7Lsy6KgGpuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS7PR11MB8807.namprd11.prod.outlook.com (2603:10b6:8:255::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 06:21:23 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 06:21:23 +0000
Date: Fri, 8 Aug 2025 14:21:14 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Mande Imran Ahmed <immu.ahmed1905@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>,
	<linux-kernel@vger.kernel.org>, Mande Imran Ahmed <immu.ahmed1905@gmail.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] net/mac80211: replace scnprintf() with sysfs_emit() for
 sysfs output
Message-ID: <202508080725.79ed349c-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250730095634.3754-1-immu.ahmed1905@gmail.com>
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS7PR11MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: 7323e59c-fef5-460d-6960-08ddd643cbd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tgBEtKNZojZALw0uyrI8Z4dqtb3DJbumuWgfj/2tOKOgH0qLZWA9X7G15l2n?=
 =?us-ascii?Q?3O2lzbfD4JQhCTnvLYkumutXCw1CV/98TMiZCz0syKyUz1u3QMaNBe0KpveY?=
 =?us-ascii?Q?Qo1cgJRulvM2Z0gRj8gC5Xkpsfjn9inyyerC4GbcUj9zGIcu34qGV1PQ9ErO?=
 =?us-ascii?Q?y2jQZ4I9tFzbYN2SvCL2SOk0ajwPU8RiIlNDFdqvaAOHPevUFjQtRcGS00QO?=
 =?us-ascii?Q?DYeID8dhyPk8qP92TYMoY4KPStGf/alH1an0IrBAxZql/x68D1jbRB5BGeVA?=
 =?us-ascii?Q?ExWT2IjVodmU8S+xMzhRkaM0nhNuXevSamZcrj3qjRXZ9lPMw9xDmXNirxNZ?=
 =?us-ascii?Q?pLN0kPKJDQF1fXR5B0FLydbzQO58ec5Q7dsCETAvcoSKukTEITRPFcCCXrOw?=
 =?us-ascii?Q?pyQqVkw/SVJ/60ZU/yHJprfEzGtKQT5052kZL6S0Sku2ZsDf8JavfLfJGPhA?=
 =?us-ascii?Q?BkdY3p5tRFDvAqJfme57CyWmkNErWn8HU5GKKG2xHYKc6VSGAGwlmM1bs9+v?=
 =?us-ascii?Q?gtze/neBZ1Z+67GQ3+62Xiz2EWE6BkzkOCwfuKkHHfdXqyEyLewASemzE3HD?=
 =?us-ascii?Q?UMp3fbJCfNp8G94wUnz5g+ttriI2v7FFXW01CeX3nWGaUTzV7qo2LZBm2N4V?=
 =?us-ascii?Q?qauvoVbMHSq48GRKAj3CCagty2cFRNQnS9HxBpq2IE6wYFbrONFUJhJFi3Tb?=
 =?us-ascii?Q?lJ7gwgn1eT0TGSeCvsoQRUwDXhRfd/WRH7NJGeVM5y6MFsCUpcnT4bl7+EW+?=
 =?us-ascii?Q?Db12ziQBtBeIIXNwIo//SITs26yH8FnVNA8M5HA/Wp5I/XzXn3+KjWCjzKcu?=
 =?us-ascii?Q?AY1u286PrgUc6eGkKWiaqhkfAml8R8eGuM6vx7VwAI57+5mx+8cFiIrietI3?=
 =?us-ascii?Q?tRIAU8hcZjhpkz9oYTArwx9CeTEyMRuzGkYXamXn6MbZ+8KMmaRKNwek01eo?=
 =?us-ascii?Q?nqVciyenZLFpq+jo7Fr9pGdop4C03DrPW4oHjtg6da0a7K+PXXXN8eEgaRnX?=
 =?us-ascii?Q?sWSkvnTQ32YGZV9YoyDA/rSOnrZcdF+vixdSlcPnxcn9Q5bRuCMlHMfz4kKy?=
 =?us-ascii?Q?5YE+VLHqY7YEqgB2w1csQny7HuKxmSyWcIgKp1pHdqBjK/AkgOKA/3wv5RT0?=
 =?us-ascii?Q?6BTnZtKaK4o4ziinw9e6/gIGAr9dMochhX9hYW+P+af+DojOcg5/E4hvFeEv?=
 =?us-ascii?Q?X49D+phvVhpb6SJdgCHFqy4YOLfoPfbJYGVdok18UkwBFjj6q673P/jWDLuG?=
 =?us-ascii?Q?eSshUlMT5VVOXlIceejfl7ya2kO8xFJEfzPjenKK9AZDp6vbgx8Ht3JgEo/i?=
 =?us-ascii?Q?uJv3ID/R2J0lZIKFB0aLn6pp2u/Ymechx0tqkhZTwlPyJa2Feeu2P+ZLYOBL?=
 =?us-ascii?Q?loT5R8tQ9oaqDqY2MWLvlLkGC8q1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zc8skXUaraixT65IJ2fCiXBJwgVkItlvOONCb21b5Reuq6BRocQL/XrheexK?=
 =?us-ascii?Q?WPHelggdW1D6w8wzlAUz2x+cQZ2RQzKuOK6c97MVMyvZdvi15ZmgbY4BBRjl?=
 =?us-ascii?Q?ekdLil/2CWU4CUTYk1E+n595UYP8TgW9zlcK1wd50AXN2gIS8sqUoYE5poms?=
 =?us-ascii?Q?xiBF10EfoEommKdpF0ILm+rZ0VW0j2o+UgIMD1jggTlgqLNx13mjyrbYjZVq?=
 =?us-ascii?Q?zxgnH6aB1F0DpMNmQ9iwYoyIKqZqSJZxn4hajaLwFbJIa/wSQrr5xrOuUjHT?=
 =?us-ascii?Q?eJ07JAO5U+bIuI5UeRd+ghH160F8bG4Zdf2FB9BCf1z9h81eho2IGKk7KHji?=
 =?us-ascii?Q?/9MalvlUOXnfLRrAWXoCzoI+mNCS9r9dOZ0qf0/JAIEMf97/cYgygqc2kHHC?=
 =?us-ascii?Q?zn7jdGETbYHWQbE/oSscdawgPJ9BKr8qeaucPX3DxVJDpf7oinU4PHYNHU+8?=
 =?us-ascii?Q?oAD4NPWB5smleAKN1zrApghESI/o44v6O/FzwsQ/Td9yQNlVy13pp23BjFVA?=
 =?us-ascii?Q?UUXQruHaVILQcRQZpPxMLZTV+zvTrpra/Uv/zoXvy4+KoL1zcLQ5AIIeajIH?=
 =?us-ascii?Q?ednltzGc5ocU1zSxP0wnmf3uRi55XjXVVVjuJpLBCvryqzDpSGRe8eZ5JAJ8?=
 =?us-ascii?Q?FLuwMsfPNQf4X9yxsacxaxU0eCXfqCxWQrna+TWDhHSiVM+mrn4vPs6+gxcC?=
 =?us-ascii?Q?jx2gXTWUsxgP14pvk5oxCx0RO3DETy6NmsKuMdoP8uJxtQNCpfIi76owkrUj?=
 =?us-ascii?Q?cJQC4b1VBxh/pse06br6hFiq23lvbZz1dqANIWg1WAQJrN00dOV87e+Odgnb?=
 =?us-ascii?Q?+gYsw9vrwnkNKiCjqxjOQ3BCBhsjXpNJC7aVBmrt7n4wE6H9OawzJCz651CQ?=
 =?us-ascii?Q?Jn8DCIDfrPdu2eqRguX4WREOKRjauxOCWa6lARzfp8qXI9H4Mkp4WROZ5Aeq?=
 =?us-ascii?Q?4mDFcyp0/iHSCVD1mqbe3tLOPFxpvz15JJnfXNaB9grwSRr8SZ9LxFGhVOfo?=
 =?us-ascii?Q?8RMoGqNeKKKB9NnsLtAMQDWhEwdAgQwDondOVuYi/COVaZ6t+aEYftDEzn8t?=
 =?us-ascii?Q?QnAnbXuvQifcWd1E2ZgxgzOxLUR1xzMSFAN4RYxyN8A13V6m9DhTAq/H7BYZ?=
 =?us-ascii?Q?Vzbqbb24HOGVgAxlF6QdKh9k5oa49Sygz4lwSE+wUmKGEQzgUXIJuhxn4Hdy?=
 =?us-ascii?Q?JNFVo4oWwRmA/x9svtZF3qlXFXVjcgJy1ZSlqCyu99MXLa73zGpRoJAAsjZj?=
 =?us-ascii?Q?qjNadVL/gg+WHEoyBVYz1yqpYPQweuT4MBW9vmdzU7ScAGsvL1iO2yFB+AcG?=
 =?us-ascii?Q?VGIk8gWM1utV2Lm24WFkgTxSPAg1sPfof2ZxifZcA7R3KLy7KjW/XsCgts+a?=
 =?us-ascii?Q?mkfNVeXMRC3cv9kUdcCCZjRLG5etnXm+dnUKm73TyJXpAzl494l5O2PZjAy4?=
 =?us-ascii?Q?LQg8CySmKhUL+bw0lbzaD5NkYkCggsqB0uFpBqb4SsowlYJbts9jAVcMwp/d?=
 =?us-ascii?Q?i3QCrIzgLofQIJ3mzENV3jxi+Rp9LPBH9Iju29VvgAW42Rw70EPd6AJ/P1cn?=
 =?us-ascii?Q?fss4PNDXFWxYKQWhb2EsbGZl8OagRbkFpgR1hK1vUWSkQCRWwtFCQ8u410gV?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7323e59c-fef5-460d-6960-08ddd643cbd5
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 06:21:23.0496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: prMAR1mIXm239hniBQ13SCTcT7wLQfSPdPMeyQZQR11TB+jwJvwG+0Up9tgBgeRNFFx49W7Gup5mG8D1uifEuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8807
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_fs/sysfs/file.c:#sysfs_emit" on:

commit: ec95570844b7a6ec10105691f0c875f0688eeadd ("[PATCH] net/mac80211: replace scnprintf() with sysfs_emit() for sysfs output")
url: https://github.com/intel-lab-lkp/linux/commits/Mande-Imran-Ahmed/net-mac80211-replace-scnprintf-with-sysfs_emit-for-sysfs-output/20250730-180128
base: https://git.kernel.org/cgit/linux/kernel/git/wireless/wireless-next.git main
patch link: https://lore.kernel.org/all/20250730095634.3754-1-immu.ahmed1905@gmail.com/
patch subject: [PATCH] net/mac80211: replace scnprintf() with sysfs_emit() for sysfs output

in testcase: hwsim
version: hwsim-x86_64-4bc754d9c-1_20250727
with following parameters:

	test: group-32



config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4790 v3 @ 3.60GHz (Haswell) with 6G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508080725.79ed349c-lkp@intel.com


kern  :warn  : [   99.491962] ------------[ cut here ]------------
kern  :warn  : [   99.497289] invalid sysfs_emit: buf:000000002422382b
kern :warn : [   99.502971] WARNING: CPU: 3 PID: 5700 at fs/sysfs/file.c:767 sysfs_emit (fs/sysfs/file.c:767) 
kern  :warn  : [   99.511332] Modules linked in: mac80211_hwsim mac80211 libarc4 cfg80211 btrfs blake2b_generic xor zstd_compress ipmi_devintf ipmi_msghandler raid6_pq intel_rapl_msr intel_rapl_common sd_mod x86_pkg_temp_thermal snd_hda_codec_hdmi intel_powerclamp sg coretemp platform_profile kvm_intel snd_hda_codec_realtek i915 snd_hda_codec_generic snd_hda_scodec_component kvm intel_gtt dell_wmi snd_hda_intel cec irqbypass snd_intel_dspcfg dell_smbios snd_intel_sdw_acpi ghash_clmulni_intel dell_wmi_descriptor ahci drm_buddy sparse_keymap snd_hda_codec rfkill libahci rapl ttm mei_wdt intel_cstate dcdbas libata drm_display_helper snd_hda_core intel_uncore i2c_i801 mei_me snd_hwdep lpc_ich drm_client_lib i2c_smbus pcspkr mei drm_kms_helper snd_pcm snd_timer video snd wmi soundcore binfmt_misc drm fuse loop dm_mod ip_tables
kern  :warn  : [   99.583263] CPU: 3 UID: 0 PID: 5700 Comm: python3 Tainted: G S                  6.16.0-rc7-01834-gec95570844b7 #1 PREEMPT(voluntary)
kern  :warn  : [   99.595968] Tainted: [S]=CPU_OUT_OF_SPEC
kern  :warn  : [   99.600582] Hardware name: Dell Inc. OptiPlex 9020/03CPWF, BIOS A11 04/01/2015
kern :warn : [   99.608504] RIP: 0010:sysfs_emit (fs/sysfs/file.c:767) 
kern :warn : [ 99.613493] Code: 00 00 48 8b 54 24 78 65 48 2b 15 e1 45 2b 05 75 1f 48 8b 5d f8 c9 c3 cc cc cc cc 48 89 fe 48 c7 c7 20 a8 45 84 e8 5e 47 33 ff <0f> 0b 31 c0 eb b7 e8 f3 32 f5 01 0f 1f 00 90 90 90 90 90 90 90 90
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	48 8b 54 24 78       	mov    0x78(%rsp),%rdx
   7:	65 48 2b 15 e1 45 2b 	sub    %gs:0x52b45e1(%rip),%rdx        # 0x52b45f0
   e:	05 
   f:	75 1f                	jne    0x30
  11:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  15:	c9                   	leave
  16:	c3                   	ret
  17:	cc                   	int3
  18:	cc                   	int3
  19:	cc                   	int3
  1a:	cc                   	int3
  1b:	48 89 fe             	mov    %rdi,%rsi
  1e:	48 c7 c7 20 a8 45 84 	mov    $0xffffffff8445a820,%rdi
  25:	e8 5e 47 33 ff       	call   0xffffffffff334788
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	31 c0                	xor    %eax,%eax
  2e:	eb b7                	jmp    0xffffffffffffffe7
  30:	e8 f3 32 f5 01       	call   0x1f53328
  35:	0f 1f 00             	nopl   (%rax)
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	31 c0                	xor    %eax,%eax
   4:	eb b7                	jmp    0xffffffffffffffbd
   6:	e8 f3 32 f5 01       	call   0x1f532fe
   b:	0f 1f 00             	nopl   (%rax)
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
kern  :warn  : [   99.632931] RSP: 0018:ffffc9000288f890 EFLAGS: 00010282
kern  :warn  : [   99.638863] RAX: 0000000000000000 RBX: 1ffff92000511f12 RCX: ffffffff8193bda5
kern  :warn  : [   99.646704] RDX: 1ffff11026776180 RSI: 0000000000000008 RDI: ffff888133bb0c00
kern  :warn  : [   99.654540] RBP: ffffc9000288f948 R08: 0000000000000001 R09: fffff52000511ecd
kern  :warn  : [   99.662380] R10: ffffc9000288f66f R11: 0000000000000001 R12: 0000000016c83b60
kern  :warn  : [   99.670215] R13: 0000000000002000 R14: ffffc9000288fbb0 R15: ffffc9000288fbb0
kern  :warn  : [   99.678051] FS:  00007fbdc1fe5040(0000) GS:ffff8881ac7f1000(0000) knlGS:0000000000000000
kern  :warn  : [   99.686844] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kern  :warn  : [   99.693300] CR2: 00000000004ac270 CR3: 0000000123ed2003 CR4: 00000000001726f0
kern  :warn  : [   99.701143] Call Trace:
kern  :warn  : [   99.704281]  <TASK>
kern :warn : [   99.707089] ? __pfx_sysfs_emit (fs/sysfs/file.c:763) 
kern :warn : [   99.711809] ? __pfx_file_ioctl (fs/ioctl.c:324) 
kern :warn : [   99.716531] key_replays_read (net/mac80211/debugfs_key.c:250) mac80211 
kern :warn : [   99.722327] ? __pfx_key_replays_read (net/mac80211/debugfs_key.c:223) mac80211 
kern :warn : [   99.728597] ? __pfx___debugfs_file_get (fs/debugfs/file.c:80) 
kern :warn : [   99.734009] ? do_vfs_ioctl (fs/ioctl.c:886) 
kern :warn : [   99.738639] ? __pfx_do_vfs_ioctl (fs/ioctl.c:804) 
kern :warn : [   99.743531] full_proxy_read (fs/debugfs/file.c:393 (discriminator 6)) 
kern :warn : [   99.748162] vfs_read (fs/read_write.c:570) 
kern :warn : [   99.752185] ? __pfx___debugfs_file_get (fs/debugfs/file.c:80) 
kern :warn : [   99.757594] ? __pfx_make_vfsgid (fs/mnt_idmapping.c:122) 
kern :warn : [   99.762399] ? __pfx_vfs_read (fs/read_write.c:553) 
kern :warn : [   99.766942] ? __pfx_map_id_range_up (kernel/user_namespace.c:382) 
kern :warn : [   99.772091] ? debugfs_file_put (arch/x86/include/asm/atomic.h:93 include/linux/atomic/atomic-arch-fallback.h:949 include/linux/atomic/atomic-instrumented.h:401 include/linux/refcount.h:389 include/linux/refcount.h:432 include/linux/refcount.h:450 fs/debugfs/file.c:196) 
kern :warn : [   99.776812] ? full_proxy_llseek (fs/debugfs/file.c:389) 
kern :warn : [   99.781788] ? fdget_pos (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2583 include/linux/atomic/atomic-long.h:38 include/linux/atomic/atomic-instrumented.h:3189 include/linux/file_ref.h:215 fs/file.c:1189 fs/file.c:1215) 
kern :warn : [   99.786071] ? from_kgid_munged (kernel/user_namespace.c:535) 
kern :warn : [   99.790873] ksys_read (fs/read_write.c:715) 
kern :warn : [   99.794898] ? __pfx_ksys_read (fs/read_write.c:705) 
kern :warn : [   99.799531] ? __pfx_cp_new_stat (fs/stat.c:471) 
kern :warn : [   99.804342] ? __pfx_make_vfsgid (fs/mnt_idmapping.c:122) 
kern :warn : [   99.809147] do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94) 
kern :warn : [   99.813518] ? vfs_getattr_nosec (fs/stat.c:218) 
kern :warn : [   99.818494] ? vfs_fstat (include/linux/file.h:62 include/linux/file.h:84 fs/stat.c:278) 
kern :warn : [   99.822605] ? __do_sys_newfstatat (fs/stat.c:538) 
kern :warn : [   99.827583] ? __pfx___do_sys_newfstatat (fs/stat.c:538) 
kern :warn : [   99.833081] ? __x64_sys_openat (fs/open.c:1463) 
kern :warn : [   99.837973] ? fdget_pos (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2583 include/linux/atomic/atomic-long.h:38 include/linux/atomic/atomic-instrumented.h:3189 include/linux/file_ref.h:215 fs/file.c:1189 fs/file.c:1215) 
kern :warn : [   99.842258] ? do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94) 
kern :warn : [   99.846801] ? ksys_read (fs/read_write.c:715) 
kern :warn : [   99.851000] ? __pfx_ksys_read (fs/read_write.c:705) 
kern :warn : [   99.855631] ? do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94) 
kern :warn : [   99.860174] ? __x64_sys_ioctl (fs/ioctl.c:906 fs/ioctl.c:893 fs/ioctl.c:893) 
kern :warn : [   99.864893] ? do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94) 
kern :warn : [   99.869437] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
kern  :warn  : [   99.875194] RIP: 0033:0x7fbdc20de25d
kern :warn : [ 99.879479] Code: 31 c0 e9 c6 fe ff ff 50 48 8d 3d a6 53 0a 00 e8 59 ff 01 00 66 0f 1f 84 00 00 00 00 00 80 3d 81 23 0e 00 00 74 17 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 5b c3 66 2e 0f 1f 84 00 00 00 00 00 48 83 ec
All code
========
   0:	31 c0                	xor    %eax,%eax
   2:	e9 c6 fe ff ff       	jmp    0xfffffffffffffecd
   7:	50                   	push   %rax
   8:	48 8d 3d a6 53 0a 00 	lea    0xa53a6(%rip),%rdi        # 0xa53b5
   f:	e8 59 ff 01 00       	call   0x1ff6d
  14:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  1b:	00 00 
  1d:	80 3d 81 23 0e 00 00 	cmpb   $0x0,0xe2381(%rip)        # 0xe23a5
  24:	74 17                	je     0x3d
  26:	31 c0                	xor    %eax,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 5b                	ja     0x8d
  32:	c3                   	ret
  33:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  3a:	00 00 00 
  3d:	48                   	rex.W
  3e:	83                   	.byte 0x83
  3f:	ec                   	in     (%dx),%al

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 5b                	ja     0x63
   8:	c3                   	ret
   9:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  10:	00 00 00 
  13:	48                   	rex.W
  14:	83                   	.byte 0x83
  15:	ec                   	in     (%dx),%al


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250808/202508080725.79ed349c-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


