Return-Path: <linux-wireless+bounces-23514-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CCFAC9C54
	for <lists+linux-wireless@lfdr.de>; Sat, 31 May 2025 20:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C463BB7F1
	for <lists+linux-wireless@lfdr.de>; Sat, 31 May 2025 18:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2873B194094;
	Sat, 31 May 2025 18:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eyVlB3K3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D03185955
	for <linux-wireless@vger.kernel.org>; Sat, 31 May 2025 18:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748716539; cv=fail; b=RsbiH7HkhrhGWUyyi1L6r7WiYA5YVCAXiz2qTZ6C1Fvs1nIWMwGaZDwZicZI6ESxHr/abFPa3QzRY0GJV9t70bQEfy2TFttwOzSWowa6DWK/MuUlleuyyMyb3f0I706rKyBO1eiCEDCeehhlfohqEaTbvR3vO1yKw+CuLQk++O8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748716539; c=relaxed/simple;
	bh=DajjYtEkAhsI7nyG/vZB3sl0KukWGOQFrn/X6jCvyZA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oxPIIC9tV+fQnJg5gerHsP2Al2BLnHxfdba/3xJkY5KnCjVqN+o2kY+HfzivvfJzz/Eb62Vo/yT9qRCRWS/0nJ8oMBar3heoTBuHuRsrcm1nCVXZYyRPcvW4bTP6Zj1jtW1Do2+hraj7pjlKRJLNwf1xJHm3tf657qDDcDA1nGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eyVlB3K3; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748716537; x=1780252537;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=DajjYtEkAhsI7nyG/vZB3sl0KukWGOQFrn/X6jCvyZA=;
  b=eyVlB3K3Fire3DPskrxrx8GtN9RsxLaTUB+ZOLReaHwrCrpRq8e3eCh9
   8WDZg3BwGQfT/duNmupOOgji+FP3vL9EuPM/yXeUeKzgpd05k0hp6GK+w
   vFvFQ3k8FySiSdu9AOLKLMXBboogmQITygjDcPR845fhcSqFirMyKZJi2
   Ff3dHzqW2j6FNvVq7FG9NqRl2DWVT2zlyzV5SKW5q1jQKJg4xqWDWignd
   gpAgg9hAS/PnQpKl3RSmSx7bub5YrrdwF8DZysY6WY72GWcTOj3zjVNdQ
   x/+LN2yWC3vuqIkuQ9nyDMmCh3GU4sq9qh3i6jrx7I0c9uX3abYUXWIqw
   g==;
X-CSE-ConnectionGUID: dYtLpda8RyqTmOznEj8DQw==
X-CSE-MsgGUID: bKuPGBvUTVaCi0bv/D+8zQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11450"; a="61837153"
X-IronPort-AV: E=Sophos;i="6.16,199,1744095600"; 
   d="scan'208,223";a="61837153"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2025 11:35:36 -0700
X-CSE-ConnectionGUID: /4Tvl+mvRbOBENF3o/LZtw==
X-CSE-MsgGUID: ZLzQiVEqTLemZ726qjcXVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,199,1744095600"; 
   d="scan'208,223";a="145140741"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2025 11:35:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 31 May 2025 11:35:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sat, 31 May 2025 11:35:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.87)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Sat, 31 May 2025 11:35:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3PE+ZcZYF4an61LweFls4VS6+8EAy/IQMjBYt+f0NNXjQ2r6FZJhXhspZLLjCyDB4P9OO11d6V7v3rtK9HCX5M5ZqjQAmOBYJQ3mh6v9zJkDC/nXCp/56XatjmhBr4K7YuT9+rtPRmyfeu3vqi5Y4wM2Co/gLqSpmuwki/1bHkpKdaWM95iIYVr1zYhZSs+GIHVozSMdDYQuPVMkT8+jR12rpLLZLVbjZeWvMhWUdC+t+cKspWPM1BnXXK3oGvC99Ji5eXGjfzl7MdKFR8WwnZ9Tj+z9FA0lsCN/LH1T1NjVB0KPjXEp5IC5j+jSnFGTGt+/Qb/OMDsuoqzPf4pSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MutasY89YcASgZmp4AMK9YxA4WUjqs8/M4AWYKNAZm0=;
 b=gyrVEfnEnpNVwDN9p3nEdTwgkdGflnezr2Upk2HfgiUR482ZjfTzWmEdtb40LGGoxlV1/t1KOJlobCPj6q5WPkaw1VDKg5QuSpB/J9Mxv6haJ2tBlkcmgfE0b3wUVRPNaM9D0q9Fyqi8pZj/36l3qdA/OSB0qHeHTkMzVkGyUb9Hxs97st1g+bLh1M0Gm4repPLmqexHh+Qk9EqRlXIFl5rUryHU1Niktua8mP3oaIjkBpuv3ZgmzOAQTS1qwkfC/kvA/Y1a2e35X2im4Yd1oIfBwuZchzSo6BE/fh0/AKK+OCN8UiQzIEZYTipEpaCtD9KYPu8KvXkfP0c/ZrO41g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by SJ5PPF8A49C4DF4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::83f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Sat, 31 May
 2025 18:35:34 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::9ce0:77f1:dff6:ada1]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::9ce0:77f1:dff6:ada1%4]) with mapi id 15.20.8769.025; Sat, 31 May 2025
 18:35:34 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Chris Bainbridge <chris.bainbridge@gmail.com>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "Berg, Johannes"
	<johannes.berg@intel.com>, "benjamin@sipsolutions.net"
	<benjamin@sipsolutions.net>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>
Subject: RE: [REGRESSION] iwlwifi: suspend failure, bisected
Thread-Topic: [REGRESSION] iwlwifi: suspend failure, bisected
Thread-Index: AQHb0jWtZlonm2bevkK4NgXOOQj2aLPtEEIA
Date: Sat, 31 May 2025 18:35:33 +0000
Message-ID: <DM3PPF63A6024A9CDCDCB068431DD5249FBA360A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <aDsNn70jcX6sDLLT@debian.local>
In-Reply-To: <aDsNn70jcX6sDLLT@debian.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|SJ5PPF8A49C4DF4:EE_
x-ms-office365-filtering-correlation-id: 9eb1ef98-9f37-46be-0f66-08dda071eded
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|4053099003;
x-microsoft-antispam-message-info: =?utf-8?B?WnEwSlAyVFI1RG11Tzk5TU1lR1hUZnJ3YUEyL056Ym80cFg2c3pkbW9FaXRO?=
 =?utf-8?B?MkhMclJJQjFoUzVPZm9GdUpwbUdvbjM0MG9FRjBtMzFGRVEweFJ4TnU5dldx?=
 =?utf-8?B?eGpBUkhQTVJROVJ3Yjg4dVE5ZUF1MmVyK0Vzanl5V0kySk4ya0pWUDlYaG0v?=
 =?utf-8?B?Q0hjYTc5d0RiTHhUYmxNMStDa0RNWkl6RzExWFEzeVFzaFZtanRoSjRPUm0y?=
 =?utf-8?B?M2VVdlRGcW1ZVjZzOUpXUTdaSllBOW10NmlnN0g0NS9HQ0dpNkZMMnFTcmgy?=
 =?utf-8?B?dzdjekhWQUVCdTNWNEZmbzg2M3hPTlNOc0N4d2ppSDNPalgyMzcrOEFVU2cw?=
 =?utf-8?B?eTZ4VHQwbWZ2c1Y1dzViUWl2b3lQbk0rMHUxbVQ0MjZkY0JZU0RENFNoS2RO?=
 =?utf-8?B?aldMTnBzbVVCRXBTYjk3UVpFWDUvUE9yQUdlWksxWThHMTIzWEhXNjBteG1s?=
 =?utf-8?B?VHpERWwwZFcrbmNsM0JLa3NxOFJwTnBMc3lZVHR4TlZNZzRyc2NZc0FuTVRE?=
 =?utf-8?B?L0djS2YreDN5QndZM1Jvb2JKSE9wTTZNZTBrcVE1WUJMMVk1ZTNSbzdRWWYx?=
 =?utf-8?B?bnBJM2JkcUlJRVNXYnVjTnRZanoxMFZGQnpFQlZlajh0Vko2cHphMXljRDVk?=
 =?utf-8?B?dFkrR1p5MUQ0cXExcGZpZHZoRUZMVWRiTmtTTnZUUDcwMDBKUHcvZFdaMXMx?=
 =?utf-8?B?dndDYllUaEVVTmJjay9rVXJMQXpUUmx0a3Y3RS9BZnJZQ3RKMXBqZy9GVWoy?=
 =?utf-8?B?Q0ZwWS9CbjllZXhPZ1lVSGl5SURxL21PcGVDR012STZMKzUvMnR0UWpzb09a?=
 =?utf-8?B?MjFCazFNUDJlVndiNU1sUlBtMS8vVGEzQWlVaE1vS1JDNW9QcVlnazFhTGNS?=
 =?utf-8?B?NUhtMTRvRUpNelZLS1N3OUVnbjZQemFkL2Z4U05nZ0hmYzFBSDR2YU51bHI5?=
 =?utf-8?B?U2c3MnRhc2pCYzhtUkZMOXJCSjN1dGJzOFBaLzNicTNhNHkzTXF1K1FvOWpr?=
 =?utf-8?B?SlpHZ3h3TzBoZzNVL2NZNkI5YVRhK0NoSXQvenJpL1FISGcxeUc3Q1EzQ2dv?=
 =?utf-8?B?WUdhRHhsVFkvZWR1THoxVFg5bFB0QW9SRkNiY1FkVjZxa1hDdUVmZzQ1L1FV?=
 =?utf-8?B?a1BxZGpCNU9TVERRdXQ4M1cxbnRkWVNWMGRmTmZKckhVRUl6ZERObmhIYzNO?=
 =?utf-8?B?ZzRFL2Nsc1VJRHZJamVCTHBrdXorSUpHNURpaVpkd29ndjZtSzJjMWlIVlF6?=
 =?utf-8?B?QzRkUk9Kd1FzSzYyQzV0Z1ltYjRjUUI2bmxUT241a0dPdGwvUC82QkhlSmM1?=
 =?utf-8?B?bkhwcllnVmhUbXZaTzJqTDJZa1FLcXdoMVRvVXI4Y3ZpMmlrUkxBejBzYVVM?=
 =?utf-8?B?SXA1UHd2Q1Fsa2VxSkFuVWZmQkNBZGdwVCtUeCtvRks0ZGtVU0RGaXFzSk5V?=
 =?utf-8?B?cElNRExvWEVBandGbTAyQWx4T0Z0M0tNY3prYjFQV0cvRU1HODBHRGF6RG9V?=
 =?utf-8?B?aXRObEVRTllMVitEazk2amdsbHlVa1A2K0NtU0FKTENSeHpQTGcwemw0d3lo?=
 =?utf-8?B?bGtQU0Ryb1owbnZwSEcxR1dudG84NE9tbTFTcGs1cEtOZjdLSUZlMEpkUUJD?=
 =?utf-8?B?cVlSd1JlQU95Q213aU04QWhkRkpzeVVnRUdyMVlHRnZPQUFyckhITk5GYTFr?=
 =?utf-8?B?NXc2ZVRtYmRwNlV3cURIV24rQnBVd0Q3bzNWR1E3djlTZkQyeHpjdFVLRkQ1?=
 =?utf-8?B?L3k2YnB6SElhOHU2NlNFVmxJQy82NWpmSU8wNVN5MXo1U2VoSHJGVVZ4OUg5?=
 =?utf-8?B?WnN6QVZmSzc0cG9YSmgrY0RCLzkrLzVaY1Yxc3gzQldiVVYrNUdIM3VYemxw?=
 =?utf-8?B?NVhXOU9MTUY2bm8wUjExUUgrN1VFaWRtNmU5NHNSd2lvTzFuYThMYlJ0UTZo?=
 =?utf-8?B?OXFPNTJVZ1RIM2FZVVdKcVBlWEJCWXlrVDF4TThnVHQ5V2VIOEllQ3paL2xz?=
 =?utf-8?Q?Je7akI4WavJJ1/oCdPwcIywjtyON2w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVdzdmYwL1NyVTFGbE1rTmdoV2hMQWtRNmZhRVZOc1pQZUF3ZEZxUm1meG1n?=
 =?utf-8?B?OFpMSWJOdC9OdzdGVFV3NTU1NWI4RkdFaURTVGw4SGpQTzJkdFJnT3l5QU1D?=
 =?utf-8?B?OVdpTk1NN3YyQjllcEs1TU5YcGVEYms3ck90KzFGQ1NSRGFQaGV0aUZxMjRF?=
 =?utf-8?B?T01ER2F0NitINDlSdUhVMHI4ZkhESjB2YUhaUFY0d0lkeVBYMVVFQVBIRmxi?=
 =?utf-8?B?TkhIUldueU0ycmVqNExSMXpVejJnWlJlVnFwWC9kTzVDQjlmaWZ0UmhkNUls?=
 =?utf-8?B?RkdmMEpmbWo2VU8rM3dJNVdQVTFFVVpiSjJGbXhPZ21HMmF6dGJybTlxNlRL?=
 =?utf-8?B?YlAwUzAvQ1I2Q01MZ1poVmJnbW1sRFZHUnMwNmFFeUl5T3M4WmI4VHhVT0c3?=
 =?utf-8?B?NE8vbFc0VWJZWFFUNWhoaldHTW5VK1BFU05PU2Y3eE9XeDhTbFZCRFBxVHpB?=
 =?utf-8?B?S3I2eC9IL3lFOXB0Z053alNZUkl4bksvQStRVldiRGQ3OVNBaW50emgvMU5u?=
 =?utf-8?B?Qm9tM1dSK0pmUmM1RWRaa2NGcVNyQmtnVEJyeHlRM2xoL2s5U1BVV2ZKbEZs?=
 =?utf-8?B?V0MwVUFRcjRPM0hRaXNQcnpYZVY0eUc4UmtHWDZxVUo5OWxLNDlZejVnZFhj?=
 =?utf-8?B?eTFZZFR6ekJwcjd0bm8wenpGeDNBNnF0WTdJSktjRFo2cndnMlV2bVBWVWR1?=
 =?utf-8?B?cGl5T0FER2EzbmVQUm1hL1JJa28ydGg2TlBxNFdvVUZRa0JzTEFjN3I3N0g0?=
 =?utf-8?B?b2pHUzJzZHJsQWdZejVaTE1wMkRERVdFa1JvUlZWSU5QWERqL01NNmswaTla?=
 =?utf-8?B?NnFsRitWMjI4aXpFZEVKSElQMkp0clZOSFZIRVgzQmd0Vi9MR2l4bU1aRjBm?=
 =?utf-8?B?cGM1azB1Q01ERjVka2YxTGdiTmpNeTlMRXhVTXdwSnE3MmVHVVJCN2xobkZq?=
 =?utf-8?B?RjhLOUtRSnpLdjU4Nlg1ZjJNR1Z0WE1OdE5HS1JxRU9ERkhCZDdYclQvaUNG?=
 =?utf-8?B?RGVxa2F5aVZsL1VkZUE5eXNNelZiNkRlMmdlUytKYi9McktHTERQbW96b2V5?=
 =?utf-8?B?VE5TczZxc2J2d25IdHVlUFE4ZkUxVG5MdmpkcFRtUWRWeDh4ZlRKb1g2THJI?=
 =?utf-8?B?dmtBMHlYN0RKMW9rMDFsRDBLbUdId2FESUZNUkJDajV5VmRiTXNQNXJoTWEv?=
 =?utf-8?B?TERXKzBaZEppRllNZEJUQng5TFlaVFVXWFpPenBxTlFVcTd0YWJPT0RXN0pO?=
 =?utf-8?B?NGlVRlF6MllvdE0yY0N4Y0NKU0lIc005S1NzLzZFdE94Wm52bVBWY2dlclhr?=
 =?utf-8?B?c0NtMDZVdWhRbjBoYnlUS1RBSXFGalh5c3JVcEhXbHh0c0ZyUVkvMVhVa09x?=
 =?utf-8?B?QWNad05CdkF1a2Zpak0wL2o1WVNlcmlkV3ByL2ZIWG1EWHl1UWVaWFNpU0kx?=
 =?utf-8?B?WTJEQXpLYS81cGpNQ3ZvK0pmYXd4WkNSSVBsOXZOR01EK1VxOG9aNkJ0SWZL?=
 =?utf-8?B?SS9Wbk4zc3QvQTA5QjVrSnBlOHJJb281c3oxYkJYUTdyU3BKY2Z1ZGsvR2hs?=
 =?utf-8?B?RmxzZXowUnVCTHIveWRSSFdac0s4OXpOL0loSGV0N082a0lTTzBZYU5EbmhT?=
 =?utf-8?B?d3VhZXNERUlIYm9OQktOSFJrWXdaa21qSzJUVkFxWkZDNVFXMnB0TW9LcUxN?=
 =?utf-8?B?bGUzOWtmL3lJOWdVUHgzRDZVc0ExNHNWVk9ZeG9XU0cxLzVRMUpySHBjaGpo?=
 =?utf-8?B?QzVHRjhGNWw3ZjhCNkhhMDRuZmhCcnB1QTJ3SmVTVUtnMjNRV0l3VHVlRmtw?=
 =?utf-8?B?anRrUVk0VWh1MjlSK2xPbVdBS0h2endVV1h4WjRFUnBxTmgya3NxV1ZNVWY1?=
 =?utf-8?B?WGZoRktsZnU1Y2kvb2ZWbkVHclZSd0dMeUt4U0JENTRSSmdkbldLZEkvSDNa?=
 =?utf-8?B?ZVNkNEErVTVDbFMzSmpaRHplNmRWY2pNVHA0a29MZ0U2NXhPWlFvbi9Ed25p?=
 =?utf-8?B?eUdTTE9QMlBteXMyK3JQYkVibWxoZHJmRHppN2xTRTFOMDU4YkZOQ1RXUnpJ?=
 =?utf-8?B?eC9nVXgwaENjV1ErUHRzYjBBVEJJLzJNUWFjN20vcC8xTW5GQnhHVGlPTjFk?=
 =?utf-8?B?eUdTczRIcHNQOFc5YU5iZUQzdzRTRjZoU3JXSHFVUE0zNVRlK0JUU0UwU1U3?=
 =?utf-8?B?Mnc9PQ==?=
Content-Type: multipart/mixed;
	boundary="_002_DM3PPF63A6024A9CDCDCB068431DD5249FBA360ADM3PPF63A6024A9_"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb1ef98-9f37-46be-0f66-08dda071eded
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2025 18:35:33.9347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sPStbIoRREYhxUX/ZFKngX92WQdPioMj6nL0qb2Hq4Hkca5VG/7koBAfvyWchKJCAIJRNjoEFZ9EseY6oAQkizzA8i39Hkg7K2hxPmOrogh17YqU/+AGC7dU9ICfu/rY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8A49C4DF4
X-OriginatorOrg: intel.com

--_002_DM3PPF63A6024A9CDCDCB068431DD5249FBA360ADM3PPF63A6024A9_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hyaXMgQmFpbmJyaWRn
ZSA8Y2hyaXMuYmFpbmJyaWRnZUBnbWFpbC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCAzMSBNYXkg
MjAyNSAxNzoxMA0KPiBUbzogR3VzdGF2byBBLiBSLiBTaWx2YSA8Z3VzdGF2b2Fyc0BrZXJuZWwu
b3JnPg0KPiBDYzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOyBrdmFsb0BrZXJuZWwu
b3JnOyBLb3JlbmJsaXQsIE1pcmlhbQ0KPiBSYWNoZWwgPG1pcmlhbS5yYWNoZWwua29yZW5ibGl0
QGludGVsLmNvbT47IEJlcmcsIEpvaGFubmVzDQo+IDxqb2hhbm5lcy5iZXJnQGludGVsLmNvbT47
IGJlbmphbWluQHNpcHNvbHV0aW9ucy5uZXQ7DQo+IHJlZ3Jlc3Npb25zQGxpc3RzLmxpbnV4LmRl
dg0KPiBTdWJqZWN0OiBbUkVHUkVTU0lPTl0gaXdsd2lmaTogc3VzcGVuZCBmYWlsdXJlLCBiaXNl
Y3RlZA0KPiANCj4gSGksDQo+IA0KPiBUaGVyZSBpcyBhIHJlY2VudGx5IGludHJvZHVjZWQgaXds
d2lmaSByZWdyZXNzaW9uIG9uIHN1c3BlbmQuIEl0IGFwcGVhcnMgdGhlDQo+IGJpc2VjdGVkIGNv
bW1pdCB3YXMgb25seSBzdXBwb3NlZCB0byBmaXggYSB3YXJuaW5nLCBidXQgcmV2ZXJ0aW5nIHRo
ZQ0KPiBjb21taXQgKHdpdGggYSBzbWFsbCBjaGFuZ2UgZm9yIHJldmVydCBjb25mbGljdCkgZG9l
cyBmaXggdGhlIGVycm9yLg0KPiANCj4gNzQzODg0M2RmOGNmN2E0ODQzMDNjYWVlNzU0MGEwMGYw
ZWY5NzJiMiBpcyB0aGUgZmlyc3QgYmFkIGNvbW1pdA0KPiBHdXN0YXZvIEEuIFIuIFNpbHZhIDxn
dXN0YXZvYXJzQGtlcm5lbC5vcmc+Y29tbWl0DQoNCkhpIENocmlzLCB0aGFua3MgZm9yIHRoZSBy
ZXBvcnQuDQpDb3VsZCB5b3UgcGxlYXNlIHRyeSB0aGUgYXR0YWNoZWQgcGF0Y2ggYW5kIHNlZSBp
ZiB0aGF0IHNvbHZlcyB0aGUgaXNzdWU/DQoNClRoYW5rcywNCk1pcmkNCg==

--_002_DM3PPF63A6024A9CDCDCB068431DD5249FBA360ADM3PPF63A6024A9_
Content-Type: application/octet-stream;
	name="0001-wifi-iwlwifi-mvm-fix-assert-on-suspend.patch"
Content-Description: 0001-wifi-iwlwifi-mvm-fix-assert-on-suspend.patch
Content-Disposition: attachment;
	filename="0001-wifi-iwlwifi-mvm-fix-assert-on-suspend.patch"; size=1261;
	creation-date="Sat, 31 May 2025 18:32:12 GMT";
	modification-date="Sat, 31 May 2025 18:35:33 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5YmI5MzY3NTJjMTMzOGY0NjVlZjVlYTNlNzY5OGFmYmRjNjIxOGRmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNaXJpIEtvcmVuYmxpdCA8bWlyaWFtLnJhY2hlbC5rb3JlbmJs
aXRAaW50ZWwuY29tPgpEYXRlOiBTYXQsIDMxIE1heSAyMDI1IDIxOjI3OjM5ICswMzAwClN1Ympl
Y3Q6IFtQQVRDSF0gd2lmaTogaXdsd2lmaTogbXZtOiBmaXggYXNzZXJ0IG9uIHN1c3BlbmQKT3Jn
YW5pemF0aW9uOiBJbnRlbCBJc3JhZWwgKDc0KSBMaW1pdGVkCgpBZnRlciB1c2luZyBERUZJTkVf
UkFXX0ZMRVgsIGNtZCBpcyBhIHBvaW50ZXIgdG8gaXdsX3J4cV9zeW5jX2NtZCwgd2hlcmUKdGhl
IHNpemUgc2hvdWxkIGJlIHNpemVvZihzdHJ1Y3QgaXdsX3J4cV9zeW5jX2NtZCkgKyBzaXpvZihz
dHJ1Y3QKaXdsX212bV9pbnRlcm5hbF9yeHFfbm90aWYpLiBGaXggdGhpcy4KClNpZ25lZC1vZmYt
Ynk6IE1pcmkgS29yZW5ibGl0IDxtaXJpYW0ucmFjaGVsLmtvcmVuYmxpdEBpbnRlbC5jb20+Ci0t
LQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vbWFjODAyMTEuYyB8IDIg
Ky0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL21hYzgwMjExLmMg
Yi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tYWM4MDIxMS5jCmluZGV4
IGY5OWRjODYyNGJkMS4uZjY5NWZhOTE3N2JiIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9pbnRlbC9pd2x3aWZpL212bS9tYWM4MDIxMS5jCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL2ludGVsL2l3bHdpZmkvbXZtL21hYzgwMjExLmMKQEAgLTYzNjIsNyArNjM2Miw3IEBAIHZv
aWQgaXdsX212bV9zeW5jX3J4X3F1ZXVlc19pbnRlcm5hbChzdHJ1Y3QgaXdsX212bSAqbXZtLAog
CXN0cnVjdCBpd2xfaG9zdF9jbWQgaGNtZCA9IHsKIAkJLmlkID0gV0lERV9JRChEQVRBX1BBVEhf
R1JPVVAsIFRSSUdHRVJfUlhfUVVFVUVTX05PVElGX0NNRCksCiAJCS5kYXRhWzBdID0gJmNtZCwK
LQkJLmxlblswXSA9IHNpemVvZihjbWQpLAorCQkubGVuWzBdID0gc2l6ZW9mKCpjbWQpICsgc2l6
ZW9mKCpub3RpZiksCiAJCS5kYXRhWzFdID0gZGF0YSwKIAkJLmxlblsxXSA9IHNpemUsCiAJCS5m
bGFncyA9IENNRF9TRU5EX0lOX1JGS0lMTCB8IChzeW5jID8gMCA6IENNRF9BU1lOQyksCi0tIAoy
LjM0LjEKCg==

--_002_DM3PPF63A6024A9CDCDCB068431DD5249FBA360ADM3PPF63A6024A9_--

