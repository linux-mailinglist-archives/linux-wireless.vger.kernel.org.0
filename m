Return-Path: <linux-wireless+bounces-11834-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBC195C93F
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 11:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 565B428585B
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 09:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB235156C63;
	Fri, 23 Aug 2024 09:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kkUKu0ij"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F2F14F9D0;
	Fri, 23 Aug 2024 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724405360; cv=fail; b=o7rNuLOHiwqCF8h2lv/qVUJ4bvhjRpRU75qkOWdvHfxHQsbVMTFWXPFEC6Pm0dxFS10hEr4tzJ3WDl8S6yukhnAUyT40m+/b99IBIEVnIAHxQPfzKE8rx4moCKzCwRKGUCxpwmlSnYeTSkvyl0aj+w8mhhsDudPvkceHg2UGKRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724405360; c=relaxed/simple;
	bh=PsDqhLgpHMMQ5GJj/dLBB05BQxsk1uqV7T0TX0GDv1A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f4ldV1NYVrKDkdKQvxC+7RVL/XeaEz/I9X+XlsG4vhXW7Vzy8E+L1fy5ax3o3sh/gzyLw68/4q8EZfgzCepUDVlz/FYxdMBr8aLSVxrypxX1aIal64xiKjsxfS88KLgdcAhxN+pa+jPM7q7gTvaP47TrUF6UkVgh9T3rH31j+A0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kkUKu0ij; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724405358; x=1755941358;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=PsDqhLgpHMMQ5GJj/dLBB05BQxsk1uqV7T0TX0GDv1A=;
  b=kkUKu0ijZZ26+eZYHzSK5WQbq4tm5DHlhjOjIXqGbuYXMIyqN5GDyj00
   99G0krl+qgTC6Qj0OIirvPIOsAz8WVpITZbwBiy0x1jAJUDdyZvyz1fpS
   5Aya7bFwRXAMIaIklFu8PeZCO2o5N0bM1kK8I/Hfx16t4V1CCr4ULO7df
   K241ROc6tSnvZ5jDK3xUl5Zc5CltbT3OSpU9tjTb1wzEMkfR63tWOxBvM
   vL993qXnh8izaqPaCdMa5lX/Y7wuKI6CN6frvVfWjRS8rJFEtA1ObmIYX
   h4pfPe9eed4XNcJ6IfXG/VN+twJ82J0r86WQJXPlV1T6cCSuBQpB3hAvm
   A==;
X-CSE-ConnectionGUID: 8l+2LHYbR0qAeMapuooSHA==
X-CSE-MsgGUID: +Jw/rOsNRDWZ1K0eI3tqJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="26664299"
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="26664299"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 02:29:18 -0700
X-CSE-ConnectionGUID: lEqSHhV4T860mpEtQZPjgw==
X-CSE-MsgGUID: 1oYyat2/SoWLX9Qzg51XoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="61446328"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Aug 2024 02:29:17 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 02:29:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 23 Aug 2024 02:29:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 02:29:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mB9/Y0yvGej9kGc3uDiVI1Ujo5LTpW1kVdbsIea7EX6E/vjRVnsRwsgMOuXLlHu1T9aSPIRilP1n9tFSq4PRHM6hqza04q4ZPSd16e79IWvnRUj1bhcaZ5MxijRSnTRk538Ph6f0Ih9dVbo9A/517uk5A/M2WV9Cu4m/IZ0p89DlmHAvge7WJMVDaRulz50SpfZQy0havXDiTLMyoOf9Esp1hNjEGZq7vVyaxdjDBwnxCY05P2oXpSwqP/Vmd9kl92vsOvENj+Aa19OU73xkNraVGOJ3BojTzniPDEL5SR29n22NuUJCizu5tKz1rh7YZCgZvQ1/gER2v8jYTNr7rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBj0S5sKF7qlamWg8ZxC4OReGNMUSWXFrpsOUYGZXNU=;
 b=N1IiiazbcxBjC5C2F4CJVQyMwWP6xmQyz9QG3iR5kxq/KoVIPcsTs7ZAY6fSVrWq8Yt3s/DRl1FdEtb1kOCTtzmcyuW+XlHNV6kIrkxrjEYYGjywUf5q/yzYItPAoIhsFhYNd+lfbBKFC4vp0iD08taCLegcipMt8I+9SYHyOiYjmpQncoST9E0P1p5hQp2NsNTtn6wCiTnqIqxMIwf/KZ1pRi0nihB7ge5sp3G962lVJ9BCgKfSTUVBCPO7UvZUEcF4SlpD/77O13bkpxOroKQ9W48fGsGAW1nP2kjVSF3xK4gQkyWk84ed4FgJ7oBX+YMvELfT+naSRD8KvdzZSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7964.namprd11.prod.outlook.com (2603:10b6:510:247::9)
 by SA1PR11MB6567.namprd11.prod.outlook.com (2603:10b6:806:252::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 09:29:13 +0000
Received: from PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::1b60:d7c9:1b2a:2a7f]) by PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::1b60:d7c9:1b2a:2a7f%5]) with mapi id 15.20.7875.019; Fri, 23 Aug 2024
 09:29:12 +0000
From: "Berg, Benjamin" <benjamin.berg@intel.com>
To: "make24@iscas.ac.cn" <make24@iscas.ac.cn>, "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>
CC: "Gabay, Daniel" <daniel.gabay@intel.com>, "kvalo@kernel.org"
	<kvalo@kernel.org>, "gregory.greenman@intel.com"
	<gregory.greenman@intel.com>, "Berg, Johannes" <johannes.berg@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Korenblit,
 Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH RESEND] wifi: iwlwifi: mvm: fix an error code in
 iwl_mvm_alloc_sta_after_restart()
Thread-Topic: [PATCH RESEND] wifi: iwlwifi: mvm: fix an error code in
 iwl_mvm_alloc_sta_after_restart()
Thread-Index: AQHa5JRjWdjDNMciAku1Sec4rKw+PrITayyAgCDd+oCAAGRcgIAAByWA
Date: Fri, 23 Aug 2024 09:29:12 +0000
Message-ID: <5f452f3d0763dea96cec446996e62128dffe09bb.camel@intel.com>
References: <575625da-60bc-4444-a5f3-a7acf925f1e5@suswa.mountain>
	 <20240823030423.1781977-1-make24@iscas.ac.cn>
	 <3a9fc675-9c39-47e1-8735-a9d107b4d0be@stanley.mountain>
In-Reply-To: <3a9fc675-9c39-47e1-8735-a9d107b4d0be@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7964:EE_|SA1PR11MB6567:EE_
x-ms-office365-filtering-correlation-id: c0eaee3a-c97d-4da3-fd63-08dcc3560cc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OWUxQ0xMU2xxMzNDMWcwNnEwTlBRUEJxbmptdEc1TU9zVFZwMU5yRWl3QzRV?=
 =?utf-8?B?RHRGOFhlYzA5Yzk1YW1RK3UyYXZPN1lrK3pzQXJ3S2NXMUlaY0Z0YlBwck5C?=
 =?utf-8?B?L0ljaFRndnhDd1pMeDFxbDdEYWJVcGtWZ1FNN0hKY2FHYllOdHFRMjVWOVds?=
 =?utf-8?B?c0FoTG9RczJVRG9QNUJNOTFpUDZDOXY0eE9PNFRvcVBLYldwWTBZOEtDWGRN?=
 =?utf-8?B?d3h0NTVENGkxZDNkdWFoV0ZERmF0dnM2dTNYM2FJQXhGc29FOVJja01BY2JB?=
 =?utf-8?B?U0pDaUV6Zm5CT0ZRaFZML3FBUnBWcmJ5M0xUT2F5a1g4Y1BVc0RGR1NiaXJ1?=
 =?utf-8?B?cHFrUldvRkNGZ2hCUjFkbk9SRk94T3NIWERyTDlIQ05zcVpGNm41QmVqZ082?=
 =?utf-8?B?VzBTT0ptdXdNS1ZnTFZWUzdtdzFxZU94MTEwQ0pZcXJJZUpHa1I2dHE5bmhP?=
 =?utf-8?B?LzlmTVk4M2Z5U0sxNm52R0FYbWEvNVNycW1XZGYyZG1YejJyUTJYZmRuVjQy?=
 =?utf-8?B?U0pHaXJ3TU1RcUhqWG5pbXpWVWpyWHhmVHFTViticVEwbnNxMkVrd2FjZEh5?=
 =?utf-8?B?NGNGOFFhSmxJK1BqK0plNVpWTDVFN1RKNGp4QjJ4cURnNWJWT25UcGdSa1JY?=
 =?utf-8?B?bFhOeXV3V2pJQURxaU85cURCTmlJRmN6QWQxQjJhMnVBWGdhbG4rSHBSSk96?=
 =?utf-8?B?UDh5K1dqRDMvTEQrT3FLczh5VGk2Z2NUa2tPM2hjanFSUE56Sk9ORGUxOC9I?=
 =?utf-8?B?OXM2ejZuMkZuRWlFVzNlTkRkK2duaFhMWUVzQVlFUTFLdGpMbFhtbXJIMWd0?=
 =?utf-8?B?SGRnMEhzSDhvdmN3bnlURVZwYjBvSndEZGFSNlgzRUtMUWlMd2VpS055RmFz?=
 =?utf-8?B?UDNobWpPdWpWRVhaSVlSMDQ1Y29XR09GTzlLeXFJZG1yNUJCL3hNcVF1RUhz?=
 =?utf-8?B?TVBSdmVIQ2hyVDg1OStZczQzMFVyQS9IS3VLVFVlc2l4bzh4SngyT1U4RFNH?=
 =?utf-8?B?VW00c3FmaXNpUkFscVdtZitpcE94ZUljcXZXYnpJSHFUeFN6anFHc0Z0Q0Fx?=
 =?utf-8?B?MlVkUm50Uzk1ci9yT2NMcVF0N2I4QTgrTFN5aEgyL200SFpjZE16NVJ4L1dx?=
 =?utf-8?B?L0lEeHN2R1pOQmdYNzJ0dDUxRDlNN29wWDRIYjV0aWw2QjA2ZHMyakd4NWYz?=
 =?utf-8?B?ZTZxYzFtUDM2dW5zcU1lZS9wcTNrTUltQ1pwaFh3czZvcGloRmFtZElKd3Jh?=
 =?utf-8?B?SnFVdis5TDdNR0Rqdmd1NGc1eGVaOE43WEUrZzJCQjNoa3JZUnZZdTczOFpk?=
 =?utf-8?B?aTBSM1poNFRQaVZrckRMNG53SFJMOEh3allzTWo1QWk5UFZoK3poanZ3d2RX?=
 =?utf-8?B?N1BMM1kwM2NHQWwzcGh2b3oxSkN0Ym52aXJ5dUhObGZ6L1d5RHBoMzgxNUs3?=
 =?utf-8?B?V3RTWGt5cUUzazhNNVBqNmltMlRYclZzdzhWYUF1cTNYUVVxcTF0eWRnOHc4?=
 =?utf-8?B?TlFEdHJKRW5aTE85bWc1cDlrc2YybEJUZmFBUWxOT0RNM21hWWtjRmtBMTFm?=
 =?utf-8?B?djA0Wk9xR2UzcjRWMEV3YzA3VnNBZlR5eTEraXhUVnlBMVZxblVVSzhHQWpj?=
 =?utf-8?B?K0puUE1rYWk4a3pVcTJSM0VDVk42NTVpQ0szMXR5SENTTXVzSDIycVdvVGlT?=
 =?utf-8?B?OE9YK0RFRTE0eDliR3dpNC83clZka0IxTi8vNjhRbDlOakJhM3RlOGVxaGhj?=
 =?utf-8?B?MnNXVWJmVE5WS0FXVWU5cGF3Y1VkNDhNQ1dvbzJuNTY2S1orZWlwa084RE5B?=
 =?utf-8?Q?l2dLLSNxdYvBWo06X1medDcU58ciNpqeOXGaE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7964.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3hOaXlXV0VubDZuWUhvZWxNZ1JQYllFdHB4eG5iWEdmTThmZFBKVzZsaE45?=
 =?utf-8?B?NXd1Y2VzZ2FiRm5EanhibWN5Z1VYdGRBY1IvZTEwa09FZllERkpoTVQwMTQx?=
 =?utf-8?B?c2h0YVErNzY2RmV2emYveDdUN0p5NEtwRGREYlE4Q25YN0NOMTZkYUpYRTUx?=
 =?utf-8?B?c0lnUEpTZEc1emdNTnJiUHlQWHZWMFlleVdEaWtybXRHUDA3cmhmdGxzbkxq?=
 =?utf-8?B?Yks3bFVYT3lMcjBpREhSYlhFek9jdHFjUWxSYllaQWdBTE5zQ2ZKRWNRb29M?=
 =?utf-8?B?bGRoU2tDcGRoMUYvN0FWeVN1ZlNPR2VBL3FzdnR3YmdrSGVrTzF2SE1PQnFP?=
 =?utf-8?B?eTZ6RVlBWi9iYmh3UnZMNTdTU1RhVzArNnZHQ0VDMUl4NkxRazZNNzVxcG42?=
 =?utf-8?B?ZlkrblllYVNpWEpZSWVONCsyMHhoWFJBNWVwUUlrcnU2eEtWZmxRc1FKeU9i?=
 =?utf-8?B?cE5NWUFPUjFEMlB3emJxTk9kNmsrblZQYnJ5YTVvSWpzZGtJWmp5TDg3TWFq?=
 =?utf-8?B?TGNLdEJuL3NyRnlmSkdGV3pvN2NIMVhiZFl5aEN3dWRPZjVLQWpJaGhSSTBy?=
 =?utf-8?B?OUdtQWFrMk1Hdk9XWHN5SFNxR0crVTZjWEk3dnlFRmM2SWVlTW1zU3k4R1Uy?=
 =?utf-8?B?UWt2UGljNGpPbS8vVURLcU52aGltWGJ4OGErQWRnYWNuSVNvUDJFTThueFN0?=
 =?utf-8?B?MzBCVmIrdytwQU5EVnArR2hNN25LRng1OENvYUFqTHBPWEJUOE4xT2YvelpV?=
 =?utf-8?B?MU9MUlM3WmYzYWlNQ0t0SnZPUzVxZVZrZHd2eEVwUFUxT1d3eHd3bFF3RmtU?=
 =?utf-8?B?eDNrcmVHeE1yZ2JOOS9lNHJjWmVDNmVJV0dUQ0U0cml5MlNNRmR4WUlPK1NI?=
 =?utf-8?B?eTdFZnpxOHcvMjQrSkpzcERta2xLclBIeDRsY0VZSUtoN2FVOFg4dTZ3Qjg0?=
 =?utf-8?B?T2VDQU41aUVVMVdYTXl3Ykw2NWtWOTdvaHVXdzd2L1JUZUgxMUJYdldwMHQ4?=
 =?utf-8?B?NGQwMytHdUxyWlAwa1JMbjc0VHR1c2pTWlY5cGJ2RFpUb3lUZzZpR0cxOEs0?=
 =?utf-8?B?YnRSY2NyU3hPL1lYd1N0bS9nY0JLazlJK1JGOVVmYVVlVU5vdXNpa2Y1R01X?=
 =?utf-8?B?UVNsK2ZrS0lKLzE5ZHEyNmpSb01JNysvRFh4aXlpaUF0ei9GSVM5a0o5c3li?=
 =?utf-8?B?RHV2QUt2V0dxQ1BRVXdXaTJPb2JlSldlZll5OVdEMC9abWdEWk9MbFZZTTU0?=
 =?utf-8?B?SjRtK0hRM2I3bk5TUFY2K2ZKQjJxam05Q2Zpdlg5WWU3TSsrOEhuSkcwWUM0?=
 =?utf-8?B?eTA2bU93bTJCaEcyVDk4Rnp1cWJsVkJKZlBzdlV3SURXSUU5UWVFckZxSVlI?=
 =?utf-8?B?bEVxZEd5eW5MM0wyaXVXeTJmR0RZMXRzZCsyRVVCMFlkcENSZGxuWi9ZYVB6?=
 =?utf-8?B?bnpaMHp5c0dKUWhlYUhQY3p6Ry95Q20wN2dLcFc3QXQ4RW9QR3JGdmk4SmU5?=
 =?utf-8?B?czE4MVY3clZMd0JVeVRSaCtybWNuYmJKNmNBSEZqOEpNOGQwNDhpQmo1SHRn?=
 =?utf-8?B?VHlSTXRJOGRtVHZYa2lkOGpsTSt3Uy9HNUhlUHlLZ3dDYVVHdkhlSUxlbDNo?=
 =?utf-8?B?WEJUU21IcHpFNCtaUTNldVhnakVyVDVpQjRPbi9NcFAwYWExOXJxQ3kxVHp2?=
 =?utf-8?B?Q2twYlErRnpNYzcyU2VJc2xQTmdRdUVpUnlOdEN5Ukh5OHpmYm9tdEdQamtq?=
 =?utf-8?B?RkFXdHp0ODJJVml1bWU1Z2NlbHhGck01QkhCSkRMWWd3UEk1MG8rR3VHQklM?=
 =?utf-8?B?VTR4N0hBbEE1Wm9kRjJlOGNNTUJtVk16SnI0VEFPYkJkNUxSZmpVVWlIRG04?=
 =?utf-8?B?Tlk2cml4VkVaKy9RZ3FyWG56T1VkNDAzZlFWV3F3UkVycm5nTm5FOVAzWCti?=
 =?utf-8?B?ajBtU2NyNkJoQUFFaktvSmxBbEt2MVV5RmswNHdnYTZKckN3bzJBeEhuK1ZJ?=
 =?utf-8?B?N1lPL3ZPWmZjOWliQmJSKzJKczI5R3JXVXlDVUp5ZDlsUytLWkJPL3E2ckwv?=
 =?utf-8?B?TVpXbW1FcVBTdjVtb1NsczZ1Z0xGYmovM24xdkVBZG13MWV5ZGt3S2dmR3JV?=
 =?utf-8?B?aUZWbTkwUHdXeS9vRWFpUG5Ec2lRdzdMcWFqMVcvZ0V6MC82NGtOZjlBSnJp?=
 =?utf-8?B?a3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B163C461C0F350428F39C620BA754650@namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7964.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0eaee3a-c97d-4da3-fd63-08dcc3560cc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 09:29:12.8159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vd5yDkQsoaEjwqU1vWVwdIYg9+EUYWekg6jBUKi+ftZYpRx9fMUNy/QAkNdzQ4lS25+/oj/omP0/vktzcjApjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6567
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64

T24gRnJpLCAyMDI0LTA4LTIzIGF0IDEyOjAzICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0K
PiBPbiBGcmksIEF1ZyAyMywgMjAyNCBhdCAxMTowNDoyM0FNICswODAwLCBNYSBLZSB3cm90ZToN
Cj4gPiBEYW4gQ2FycGVudGVyPGRhbi5jYXJwZW50ZXJAbGluYXJvLm9yZz4gd3JvdGU6DQo+ID4g
PiBUaGUgU3ViamVjdCBzYXlzIFJFU0VORCBidXQgZG9lc24ndCBleHBsYWluIHdoeSB5b3UgYXJl
IHJlc2VuZGluZy4NCj4gPiA+IFlvdSBwcm9iYWJseSBtZWFudCB2MiwgYnV0IGFnYWluIGl0IG5l
ZWRzIGFuIGV4cGxhbmF0aW9uLg0KPiA+ID4gDQo+ID4gPiBPbiBGcmksIEF1ZyAwMiwgMjAyNCBh
dCAxMjoyNzo0MFBNICswODAwLCBNYSBLZSB3cm90ZToNCj4gPiA+ID4gVGhpcyBlcnJvciBwYXRo
IHNob3VsZCByZXR1cm4gLUVJTlZBTCBpbnN0ZWFkIG9mIHN1Y2Nlc3MuDQo+ID4gPiANCj4gPiA+
IFdoeSBkbyB5b3UgZmVlbCB0aGF0IHdheT/CoCBIYXZlIHlvdSB0ZXN0ZWQgaXQ/wqAgV2hhdCBp
cyB0aGUgdXNlciB2aXNpYmxlDQo+ID4gPiBlZmZlY3Qgb2YgdGhpcyBidWc/DQo+ID4gPiANCj4g
PiA+IEkgc2xpZ2h0bHkgZmVlbCBoeXBvY3JpdGljYWwgYmVjYXVzZSBJIGhhdmUgc2VuZCBsb3Rz
IG9mIGNvbW1pdCBtZXNzYWdlcw0KPiA+ID4gd2l0aCBleGFjdGx5IHRoaXMgY29tbWl0IG1lc3Nh
Z2UuwqAgVGhlIGRpZmZlcmVuY2UgaXMgdGhhdCBJIG9ubHkgc2VuZA0KPiA+ID4gcmVhbGx5IGVh
c3kgcGF0Y2hlcyB3aGVyZSBpdCdzIG9idmlvdXMgd2hhdCB0aGUgaW50ZW50IHdhcy7CoCBBIG5v
cm1hbA0KPiA+ID4ga2VybmVsIGRldmVsb3BlciB3b3VsZG4ndCBuZWVkIHRvIGxlYXZlIHRoZWly
IGVtYWlsIGNsaWVudCBvciB2aWV3IGFueQ0KPiA+ID4gb3V0c2lkZSBpbmZvcm1hdGlvbiB0byBz
ZWUgdGhhdCBteSBwYXRjaCBpcyBjb3JyZWN0LsKgIElmIGEgcGF0Y2ggaXMgbm90DQo+ID4gPiBk
ZWFkIGVhc3ksIEkgbm9ybWFsbHkganVzdCByZXBvcnQgaXQuwqAgKFNvbWV0aW1lcyBJIHJlcG9y
dCBkZWFkIGVhc3kNCj4gPiA+IGJ1Z3MgYXMgd2VsbCBiZWNhdXNlIEkgYW0gbGF6eSBhbmQgbWF5
YmUgaXQncyB0aGUgZW5kIG9mIG15IHdvcmsgZGF5DQo+ID4gPiBvciB3aGF0ZXZlcikuDQo+ID4g
PiANCj4gPiA+IFRoaXMgcGF0Y2ggb24gdGhlIG90aGVyIGhhbmQgaXMgbW9yZSBzdWJ0bGUgYW5k
IGl0J3Mgbm90IGNsZWFyIHdoeSB0aGUNCj4gPiA+IGNvbnRpbnVlIHN0YXRlbWVudHMgY2hhbmdl
ZCBpbnRvIHJldHVybnMuDQo+ID4gPiANCj4gPiA+IHJlZ2FyZHMsDQo+ID4gPiBkYW4gY2FycGVu
dGVyDQo+ID4gVGhhbmsgeW91IGZvciB5b3VyIHJlc3BvbnNlIHRvIHRoZSB2dWxuZXJhYmlsaXR5
IEkgc3VibWl0dGVkLiBZZXMsIHdlIA0KPiA+IGJlbGlldmUgdGhlcmUgaXMgYSBzaW1pbGFyIGlz
c3VlLiBBcyBkZXNjcmliZWQgaW4gWzFdLCBpdCBnZXRzIHBvaW50ZXJzIA0KPiA+IHdoaWNoIGFy
ZSBoYW5kbGVkIHVuZGVyIHRoZSBwcm90ZWN0aW9uIG1lY2hhbmlzbS4gSWYgdGhlIHBhdGggaXMg
ZXJyb3IsIGl0IA0KPiA+IHNob3VsZCByZXR1cm4gLUVJTlZBTCBkaXJlY3RseSBpbnN0ZWFkIG9m
IHN1Y2Nlc3MuIFRoZSBkaXNjb3Zlcnkgb2YgdGhpcyANCj4gPiBwcm9ibGVtIHdhcyBjb25maXJt
ZWQgdGhyb3VnaCBtYW51YWwgcmV2aWV3IG9mIHRoZSBjb2RlIGFuZCBjb21waWxhdGlvbiANCj4g
PiB0ZXN0aW5nLiBBbmQgYnkgdGhlIHdheSwgSSByZXNlbnQgdGhlIHBhdGNoIGJlY2F1c2UgSSBo
YWRu4oCZdCByZWNlaXZlZCBhIA0KPiA+IHJlcGx5IGZvciBhIGxvbmcgdGltZSwgc28gSSByZXNl
bnQgaXQuDQo+ID4gDQo+ID4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9NVzVQUjEx
TUI1ODEwMkUxODk3RDc0MzdDRDhFMURGMjdBM0REQUBNVzVQUjExTUI1ODEwLm5hbXByZDExLnBy
b2Qub3V0bG9vay5jb20vDQo+ID4gDQo+IA0KPiBPaCwgaHVoLsKgIElmIEkgdW5kZXJzdGFuZCBp
dCBjb3JyZWN0bHksIHlvdSdyZSBjb3B5aW5nIHRoZSBsb2dpYyBmcm9tIG15IHBhdGNoLg0KPiAN
Cj4gNzFiNWU0MDY1MWQ4ICgid2lmaTogaXdsd2lmaTogbXZtOiBmaXggYW4gZXJyb3IgY29kZSBp
biBpd2xfbXZtX21sZF9hZGRfc3RhKCkiKQ0KPiANCj4gVGhhdCB3YXMgYSBkaWZmZXJlbnQgc2l0
dWF0aW9uOg0KPiAxKSBUaGUgY29kZSB3YXMgYWxyZWFkeSBkb2luZyBhIHJldHVybiBpbnN0ZWFk
IG9mIGEgY29udGludWUsIGl0J3MganVzdCB0aGF0DQo+IMKgwqAgdGhlIGVycm9yIGNvZGUgd2Fz
bid0IHNldC4NCj4gMikgSSBtZW50aW9uZWQgaW4gbXkgZW1haWwgdGhhdCBJIHdhc24ndCBzdXJl
IG9mIHRoZSBsb2dpYywgYnV0IGp1c3QgY29weSBhbmQNCj4gwqDCoCBwYXN0aW5nIGZyb20gc2lt
aWxhciBjb2RlLg0KPiAzKSBQbHVzIG15IGNvZGUgaXMgb24gYSBXQVJOX09OKCkgcGF0aCBzbyBp
dCdzIGFsbW9zdCBjZXJ0YWlubHkgZGVhZCBjb2RlLsKgIFRoYXQNCj4gwqDCoCBtZWFucyBteSBw
YXRjaCB3YXMgdmVyeSBzYWZlLg0KPiANCj4gTWVhbndoaWxlIEdyZWdvcnkncyBjb2RlIGxvb2tz
IGRlbGliZXJhdGUuwqAgSWYgaXQncyBjYXVzaW5nIGFuIGlzc3VlIGF0IHJ1bnRpbWUNCj4gZGVm
aW5pdGVseSB3ZSBuZWVkIHRvIGZpeCB0aGF0LsKgIE9yIGlmIHdlIGNhbiBmaW5kIGEgYnVnIGlu
IGl0IHRoZW4gc3VyZS7CoCBCdXQNCj4gZG9uJ3QgYXNzdW1lIG15IGNvZGUgaXMgYmV0dGVyIHRo
YW4gaGlzLCBiZWNhdXNlIGl0J3MgbGlrZWx5IG5vdCB0aGUgY2FzZS4NCg0KSSB0aGluayB0aGUg
Y29kZSBpcyBjb3JyZWN0IGFzLWlzLiBFc3BlY2lhbGx5IGFzIHRoaXMgZnVuY3Rpb24gaXMgaW4N
CnRoZSByZWNvdmVyeSBmbG93IGFmdGVyIGFuIGVycm9yLCBhbmQsIGlmIEkgcmVtZW1iZXIgY29y
cmVjdGx5LCB0aGUNCmRyaXZlciBzdGF0ZSBtYXkgYmUgc29tZXdoYXQgaW5jb25zaXN0ZW50IHdp
dGggbWFjODAyMTEgaGVyZS4NCg0KQW4gYXJndW1lbnQgYWJvdXQgdGhlIChpbiljb3JyZWN0bmVz
cyBvZiB0aGlzIGNvZGUgc2hvdWxkIGNvbnNpZGVyIGJvdGgNCmhvdyBtYWM4MDIxMSBoYW5kbGVz
IHJlc3RhcnRzIGFuZCB3aGF0IHN0YXRlIHRoZSBkcml2ZXIgbWlnaHQgYmUgaW4NCmFmdGVyIGEg
ZmlybXdhcmUgYXNzZXJ0IGF0IGFuIGlub3Bwb3J0dW5lIG1vbWVudC4NCg0KQmVuamFtaW4NCklu
dGVsIERldXRzY2hsYW5kIEdtYkgNClJlZ2lzdGVyZWQgQWRkcmVzczogQW0gQ2FtcGVvbiAxMCwg
ODU1NzkgTmV1YmliZXJnLCBHZXJtYW55DQpUZWw6ICs0OSA4OSA5OSA4ODUzLTAsIHd3dy5pbnRl
bC5kZQ0KTWFuYWdpbmcgRGlyZWN0b3JzOiBTZWFuIEZlbm5lbGx5LCBKZWZmcmV5IFNjaG5laWRl
cm1hbiwgVGlmZmFueSBEb29uIFNpbHZhDQpDaGFpcnBlcnNvbiBvZiB0aGUgU3VwZXJ2aXNvcnkg
Qm9hcmQ6IE5pY29sZSBMYXUNClJlZ2lzdGVyZWQgT2ZmaWNlOiBNdW5pY2gNCkNvbW1lcmNpYWwg
UmVnaXN0ZXI6IEFtdHNnZXJpY2h0IE11ZW5jaGVuIEhSQiAxODY5MjgK


