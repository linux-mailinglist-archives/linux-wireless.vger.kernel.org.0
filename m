Return-Path: <linux-wireless+bounces-16035-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4372C9E9331
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 13:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F258E283E57
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 12:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762982236EA;
	Mon,  9 Dec 2024 12:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iXuX/6bC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052E31922F6;
	Mon,  9 Dec 2024 12:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745728; cv=fail; b=RTXMeA1aCeMXjHEJZ0dX9nHBPN5GAhekVnQ1ZC5N9rrKIC40cqgDB0sCU5HP4ECmbCtSPnLDuMONf7IY37Zg2OqyICZPADHSA50XD94MsZfxP8yIk9JG9EWXJvB9y5UVKZdlGZ06bWXmL/g5MMEph66d8zR5NWoL8HGuRbf007k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745728; c=relaxed/simple;
	bh=UyA0/Mw9n5WUzPQkDFh1rV7dTtFuvIKnJus0jafUjv8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gn94/xMUpwcftCpY2BWEKdQ9iErMg390LVUz9DoBQ5clmNuX/KvQaH70bejXSUBmfgybnhGxjQC0tlW48YpA8wO1ujkMRzu09iJaTWafeL3KnAAW/o3sY3wxIsRBPBA+UIebnRVtBOROy8Xh6AfyinaGWswbRaeIOSBs9DSpq1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iXuX/6bC; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733745726; x=1765281726;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UyA0/Mw9n5WUzPQkDFh1rV7dTtFuvIKnJus0jafUjv8=;
  b=iXuX/6bCsiV5DbeJVomYufZyDdk8pNSBz46NXZehgJDniG8qAv7ugJfJ
   uTnsEFoTi2FZgl2S7RyRvwxMZOKzF2hh/06zfX/Xq3ceL3nIz+KZ4mCVp
   7BVYiGRY0Q33yByDENC9bbuZJiKfCOOYIKYpAzC0yvW37AxRDo3fyaXuG
   XyS+NxSJKVZrAI3Uzk3wEeuOKxuPDGIfhCQgifK2lgMXYQW1AKyodQ5K0
   qX8TSsIhA452xMNLS3KvxNP43DsusAxlN8M8lty3iWejtXHRM+GW1yv0f
   Lt1LEsKVneKT5hB20FnuAApafxHj+P3yRCHMJB/Pa0oUnU1jUX6E1H9G4
   Q==;
X-CSE-ConnectionGUID: q86tbiUhT2aPrKoqTotoVQ==
X-CSE-MsgGUID: hDRJ8+PoS4iC252FPSPiVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="33376452"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="33376452"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 04:02:04 -0800
X-CSE-ConnectionGUID: RuB61iplQoa4buHZ6hF5iw==
X-CSE-MsgGUID: HmL+y8muTr+ymH9yB2HFNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="118291933"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Dec 2024 04:02:03 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Dec 2024 04:02:01 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 04:02:01 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Dec 2024 04:02:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uS+kjXWsgzoZdqSj/eSL5XfkfVfYq2cuSQRl6UEybBLULwbTmEJspFMDdwMArIfetvy4gYcDsuM4cqohT8R4TeOc8bsA48rDaCvAEqTFWn8nkGeUFJ9fVxLIEDzeFbHXhAR5WDHEBHCkJqbgHrphRZz8iNWQyfucmDPSXTq6bFAY7IP9iHDa+agBJFZ7fh4vfN0V8ruZ1jHj9aPaNXNfHPkAC1yW2/F4yT2ChxPpsBsbwc1799X8+RbJOLF3kcBnJRgN7dbK4tlBVJqg7+3pGAb2guhUk/KskQhz+9X/vLe/RosoqV8BvuwBKD1AC1yL/QitAEENUvcrg/5OuZaGmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWO1vtST2RvN31AcCbA6YitT4GKod8x9EcWhSGYpNW4=;
 b=ANH8q43m/VKi3HisBqbPcLFAbHYlpaCn3rzQRLsHmO3482tc5Rwfwto41iHvFLw68zOiJ7zbZ47XSyoNddedhUlfTnupYAdArYW7cMguiTkY7nP9FfFc3eTKcuI4zYrlp+bVPvzs6G4CGhgvWEZUEgl3FpbBTDGGgMyYa+ItpquHoB/386C37g9Vk9F/pm9y7xBaM2Cr4Y3kfIY4xfaDlpDqYhNnE2FoYS+Bu4wAMeUNjS6Jgpo5K12GldF9o4pesXEwX+9ifVVuKbuGZSP081eJTtc56nD0Hot9bfDCkK/ncyQ/94MbMBgk0yN3e16g1yDNqZp4+Vf348elxgxKJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA3PR11MB7416.namprd11.prod.outlook.com (2603:10b6:806:316::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Mon, 9 Dec
 2024 12:01:50 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 12:01:50 +0000
Message-ID: <72c8eb66-eb67-4f8b-b0c0-13f1aa001698@intel.com>
Date: Mon, 9 Dec 2024 13:01:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/21] Converge on using secs_to_jiffies()
To: Easwar Hariharan <eahariha@linux.microsoft.com>
CC: <netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <cocci@inria.fr>,
	<linux-arm-kernel@lists.infradead.org>, <linux-s390@vger.kernel.org>,
	<dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
	<linux-scsi@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
	<linux-block@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
	<ath11k@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-bluetooth@vger.kernel.org>, <linux-staging@lists.linux.dev>,
	<linux-rpi-kernel@lists.infradead.org>, <ceph-devel@vger.kernel.org>,
	<live-patching@vger.kernel.org>, <linux-sound@vger.kernel.org>,
	<etnaviv@lists.freedesktop.org>, <oss-drivers@corigine.com>,
	<linuxppc-dev@lists.ozlabs.org>, Anna-Maria Behnsen
	<anna-maria@linutronix.de>
References: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
 <b9fcb12a-b7a4-4c33-836e-67109ce07deb@intel.com>
 <dab77729-682f-4182-9fb2-cd522ac29b5f@linux.microsoft.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <dab77729-682f-4182-9fb2-cd522ac29b5f@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0221.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::29) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA3PR11MB7416:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc1c36e-1946-4347-72cf-08dd18494368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWRaWVBuaVhybkhDN05KMFRwYUpmcjVnbStIR2hkVTg4cTI1T0JpWkNla1dM?=
 =?utf-8?B?Z0kzUy9jY0dENGFSWE1nVTVURmpWcjFGMWtvN2hZaGQzNVFCNDI1YTduM05a?=
 =?utf-8?B?b0JNZHZjZmh3S25PdjdiSDkvUWxYbHJtQVJoK1o1cW5Ic2FUVTN3YW1pZmNC?=
 =?utf-8?B?Sjl1UXpZU2N3ZCtEZkFlRjBQT0pZdHFjVWl4R0hRbDZBQmNBQnk4VHkwbXhC?=
 =?utf-8?B?ZzR3TWV6S1paSGpiemlJTDVKTjMyT1dHZ09zR2xFbE1jZkd1YTJuMUl2RGxp?=
 =?utf-8?B?OUxGY3ZaeWRRSnpqMU5jbWlHVGoybjYxd3NQWTVFZXFBa3JEdWpIbHF6ZDVN?=
 =?utf-8?B?K052M2xlNTZUMDJ4QmNvTEEzUURPNGxJR0VJV1dRNmQveGhCKysrVTRHNjcx?=
 =?utf-8?B?ZnVhUXpoNjJYWGdEMml0endxOTUxRTR0bUxZNVErd2NEZUNBZnhpMyttZlph?=
 =?utf-8?B?djd2bEdVVERYZzVpUFNIaVRmTC9wMzYxaGZSd0tvYkJaYXN0a1FOOGllK1BG?=
 =?utf-8?B?WmhRRWE5bTN2Y3RnUXU0ZFIrMStEYm1ONk1TMWhpR2Fwa1FaMzJXTzVHdUlH?=
 =?utf-8?B?OUMwZDZ0QVlxSjdocmVWWlJucUhsVE9uK01sK3VxWG9uRHQvSTRUanEwQ2NH?=
 =?utf-8?B?K3gwZVlHSWtVK2R0Um1wREZVbUkwTG1wWGVmN3ZCTnk3Sk1sMjYxbnZOVDRz?=
 =?utf-8?B?Y0ZYaE1yRFVaSWxaek1XM3hPOWNRbUtkaFM2Mm4wSnJpbjR3cEdlazNFLzVU?=
 =?utf-8?B?NkZGcU5pYkcyclNFYU1sMW1heXRzK0RjNnFyTlZKbGxqVjJhRW1MSlZXYTF2?=
 =?utf-8?B?bFhjSTJ5SG1TSEE5Uk5tVEN4WmxmeGQ3c3YxYloyZHUzODdEZDdqdnlmQk14?=
 =?utf-8?B?MEVPeXdSNmg5RXZTZVNFdjFmWlNobXJWdEQ3T0dzOXBFTklSL3BWakZhVWdm?=
 =?utf-8?B?ZTEyaDVJbVlNN2EzNUkwb0tyUG5WUjllWC92QjlTdVZrbWZUYTdlZnlSYUNh?=
 =?utf-8?B?NWVZOFo0bVRyd1BJK2Z1ZGZEL2cvRGZkV2ovdTFYaDFyeU80VzFjdDJnZkJJ?=
 =?utf-8?B?anpOcmh5SHZUOUhsbDFuTmR0WVJYSU5TUGVHY0YybEVtakdKT2lmMlErSHVs?=
 =?utf-8?B?VjV3MitiUFU3QitJdUtDMUl1YWxzamxMQldTSkVTVkZRcEt1TDdIOVY2Qzlw?=
 =?utf-8?B?Y21HQXBVZlJMMGlURUdxNHJ5L0MxQkFWVHM3Z3NpT1RUR1A3SGoxRVR2RndP?=
 =?utf-8?B?VVNPRkt1alhwd2dtcTJuQXRCZjZkZzljdjltdVIyV2RydjNwK0lxNE4rby9j?=
 =?utf-8?B?NFZZVWZwYW9uRHpGUElRdXdoNjBEV2t5MU1oaElnWVBiUXdBVnovNVViMy9z?=
 =?utf-8?B?aGtKU0VLcG5Gc04xVVFpZVhkZm1GaUJYNW9rd1FSc1pZNmFnVWFhQ0RBS0Vx?=
 =?utf-8?B?REQ4WFMzN0pNZi9HVEtMQVpJYWxtZXF1L3FZZ0tEdHg2Tk1ET1htMGVxQzA5?=
 =?utf-8?B?aExTblJJVTFyd04xT3dIeFJHV08xOHE2WWlSK3pDL2hhZ1Z5Q2hXRTV1NG5p?=
 =?utf-8?B?S3hSOGRIamdTR2t1ZFNvTGxONHhaYXp1MjQzNEZhM29nbkFIN2ovOWdDSmlp?=
 =?utf-8?B?OEhEbmk3YnR2TUNFNWxNUkliRDE3L2lhOGswOG1helkyVkpiS0FJM3pGNGt0?=
 =?utf-8?B?ODJSYXF4Y2p4YmVFaHpxM0RVNVlzelhEczZYS1BSc240b0R5ZnZDWjdUTllN?=
 =?utf-8?B?Rm5ZZUl2OHk3N1ZnTkVIQUZuRmpPUE1ramNyL0ZwOHBIVGpTTGE0c1NTbXp4?=
 =?utf-8?B?SjJxajJYSWNDR3dMODNkdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTl2cUxMSWdXZWwzUWFBcnM3d2J0cTMxWlVDVldrajRnenBxakp0cDJpK2FB?=
 =?utf-8?B?eCtSeG5sdUFCV3BMY1F4Und2YVloKzlEUzBSWmlGSjNRNkw2amlnVjdkZDZ5?=
 =?utf-8?B?eGVWN1lRMUpjdStZUnZYWGNmb3o4QXozTE5ZaUYxd2UxaHFNS1BwenZicGhn?=
 =?utf-8?B?eTZkTkNLdzVSc3pydW1FK3Y4ZUZGSmFXeW5pS3QwZ1A4RmpiSTVMam9oM25Y?=
 =?utf-8?B?dGpkbVBUNTRMWTVRRXNHUFozUnRFUTA4dVpJcWsxOXZTeHhISW9CeE9mZ1Z4?=
 =?utf-8?B?N0FHV0NabUhYNDB2ZjhISGlEQ2pEZXNWdklzdDNPTUtRUnlsRTBEaWx3eHY2?=
 =?utf-8?B?RG5tZDNRR1I0alJITHA2N3VxN0QzOVBGR2NuNXVrNWtKTlIzMUdIYUNMbkVJ?=
 =?utf-8?B?aUhPaTRKdFQwdm1QZzNIT2YyQXpKL0tyU0d6SXh1RGl6dExmOGFFVE4vUCtt?=
 =?utf-8?B?ZUpEZmJwRis4WVF1bjkrUE5PTTNqWU5NdUV0RUdqaEZTQm81TER3UTJNNVl6?=
 =?utf-8?B?WGpHajF6enM2blFkQVFia1hDdnIvamk2S0txdG1Teld4Qk1IVjVpWENSSjR4?=
 =?utf-8?B?UHZVZzk3TWttVTlFTmxOR0t1R1BLMkZyTGNaZjAvVVRkSk9iZUZYMi9VN0Rq?=
 =?utf-8?B?aHdwZzBMcnNkVzFhVzZ0bys0Szc3TC9xZHBzY2NkS2ZLamhhTmM0Ryt5djVU?=
 =?utf-8?B?YWl2OHc3VGpvL1dJamtRSlFkN1dhSHpuNzBTa1ZPUTVlait4NGxoRkhhWFhC?=
 =?utf-8?B?eG9QTEpSZGJtenUxNVpYRUdicElVM1RHYlJJNTIwSWQ1emtiWkJaSVdoU0Zv?=
 =?utf-8?B?L2JoRUU4allJZXhmL1JBa1lyVTRCbDkzUUE3RDhmL2V2aEZYMnRzZmtwWmFz?=
 =?utf-8?B?SFZOSzB0clNVa0dpcmY5c3V3SkhtaG5TYWVYOHNwT3czUFdPSGw5bUpLa2lX?=
 =?utf-8?B?d0g4ODN6blFMNzFoL1VBWUtSVnIyMXloeFN5dlExWEowa1U2MWJnWDMvaFFU?=
 =?utf-8?B?VWluOCtNNi9oWHpWc29TOEFoekJlQjM0SHNETk5XVlFrcTI5TTNGVk5lRDFO?=
 =?utf-8?B?Y2lFMHBQZ2ZhYzdFNmxGTUhuVEE0eUpzUXkzM2c4WjdBSlU0RjhMNW9VeWl5?=
 =?utf-8?B?ZDNhZU9EUzE2VmdRMldRMUpCVmNQb0VuOGdPZDFLVTdJSnUrL0FMRnB1bm0v?=
 =?utf-8?B?L1NEWjl1MkFDdW1WcXdwZVdRLzZxZElvOVEwNnl4NHNFdUdhcFFQSEZWMEtl?=
 =?utf-8?B?NUxGT25ucDdZUllFbkd6OVduaFJLMm5kNlIySjI1djRTWjY4YmpDS056TXlU?=
 =?utf-8?B?SEVrcEwyV0JVeVpUQmFJZ0E2UmVNMkEyVXBrNThtcm9sWTMyT2s4cm9NNHdn?=
 =?utf-8?B?VkJJdkNFNUpBNkVEdmJkWjZnSlNldW10SVhWNHk3VHkwQSt2Nkk2U1Bvajli?=
 =?utf-8?B?SFVzOEg1VHg1QkEzdlhaYW5WZjhWQlFGVnk3czF5OWhRd3hLZC9qbm5uZ2g0?=
 =?utf-8?B?cVdYOGMxVFVzZ3MrUUxSSXZ1b2JucjRzekNzaHBrclVlbHptRTYveEtrN0Nu?=
 =?utf-8?B?VmZnSGlxQmN2b0RpZ0lKZ01qbEVJTWEyR2lYUWFremtaOGJ6TmF6ZHltZVhn?=
 =?utf-8?B?S0tDQXlMKzVPVU00KzNkOHlrbTZFVGNaWkIwNHRyVHA0WW1BVG1wb0o0c1Az?=
 =?utf-8?B?akRITDhPMUswY2hjTzFlcTNTN2cybnF1OE1Mc3pKNUhOMHp6MXV4R2J0Qnp4?=
 =?utf-8?B?Y1VISFRTUFVOZ3JCdms1d2xENkl6NHc4MGoxVjN4YTlRcVRzSjZpcGVjNTlu?=
 =?utf-8?B?NFFKMXIzSmhRQmI0VFB4dVFMNTgxdHQxVHNDQ3BzSlREeXU5Z0xnWm0wdkZK?=
 =?utf-8?B?WlJHSnpZZ1ZyT1hCaFRwZ0VHZHBlcHA3MnIvR0d1V3BTcGc1Rzd4b01rcGZJ?=
 =?utf-8?B?NVQxemhHclF4M2NJeUQwNXpZdDhXRmlOV3V6SzFtMlJ6a0ZCM091bXNFVUdy?=
 =?utf-8?B?R05iblBITWpVMGZ5U29nQlZNSWc4eTlZYm9pUEpsMzBXcUNFSkFvNlVGcmFH?=
 =?utf-8?B?TkFnN0R5ZklyVEoxQm94NTh6dzVYV1AzOStyUVo0SlA2TG1vZCtnMXA5M21K?=
 =?utf-8?B?blMweFNMRHRTbVQ5UGhjYUVWdWpkZ3NjL2ZmN1d4dGV1NnRZTUp1cjI1R1RW?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc1c36e-1946-4347-72cf-08dd18494368
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 12:01:50.0336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 90RppGftVpk3FnymRpMqElEbYRGNrvoy9BAT6DroNtYjNKooFKLbkYJkbD2fkW+MuR4qzs1oYqLeiuNTTK8T1TE04fQVC07aiB1zb/08NYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7416
X-OriginatorOrg: intel.com

On 12/6/24 9:58 PM, Easwar Hariharan wrote:
> On 11/29/2024 4:57 AM, Przemek Kitszel wrote:
>>
>> [removed most non-list recipients, it's just too much]
>>
>> On 11/15/24 10:26 PM, Easwar Hariharan wrote:
> <snip>

>>
>> Regarding code - you could also convert msecs_to_jiffies(const * HZ),
>> there are 10 that are greppable.
>>
> 
> Those seem to be mistakes. const*HZ is a seconds-denominated timeout,
> being passed to msecs_to_jiffies() which will treat it as a
> millisecond-denominated timeout resulting in an excessively long
> timeout. I suppose that's better than a too-short timeout, and
> apparently it's been working fine all along since hardware responds
> before the too-long timeout expires. Half of them are in
> drivers/scsi/arcmsr/arcmsr_hba.c and the pattern has apparently been
> there since 2010.

my point was that, the default value of HZ is 1000, and most of the code
that is just `$value*HZ` was meant as "$value seconds, in ms unit".

Same for HZ/const, HZ/2 being 500ms.

HZ is awful in that it is not 1s but 1/s, but it was easy to abuse the
value in simple context.

If you happen to touch this, please do in a separate series, to get more
attention from drivers owners.

> 
> Thanks,
> Easwar


