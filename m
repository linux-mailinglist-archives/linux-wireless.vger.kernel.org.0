Return-Path: <linux-wireless+bounces-23480-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8883AC723E
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 22:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9575E4A32C3
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 20:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB611FF1D1;
	Wed, 28 May 2025 20:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uvh+OE2h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505311C5485
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 20:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748464340; cv=fail; b=rIpp1ozwmVhlg1Ns/WzLFX6LgnTX+ohBhcDgA2SFtDRiO92WdBC4Kg3KQWTxApsI2A8udBkD92MruGm6s8TJWL4COccrHf3Sq8VCpq/p3VXJpKPH1j+uhD1dmK3j4JYHWEVl+fos1DTnbtk2DTWGL+gyq/dmcIhXVumOrnYHWM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748464340; c=relaxed/simple;
	bh=Yk3w5z40GEbsWi125bClUk/TiLXAHrcE18J29u3fKTo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nr6LzQ0GJ+OL54ol6mJ9VkKJgA+xJ9sgRtzBXvBvqFtE86yBBfg9ATIw7a4oWDp5IRmZr4EzAeq5/++jJAfvglXDpn1tKmdgI5qrklg+6/qpLmKtKXcNAmqxyC658ZLhZr5lbTz09aLac1OdD1jGERyeNb10omzhZY8LeLcjc1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uvh+OE2h; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748464338; x=1780000338;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=Yk3w5z40GEbsWi125bClUk/TiLXAHrcE18J29u3fKTo=;
  b=Uvh+OE2hlkSnm0Ywvo/pb3F8KSG8CWRjDie07KIpZoQIFQ+8qS8wl58D
   IFueF8aH/febxDo9LNAAzENwaN2wzc92o2mFTdBG5SCcHwbDQmJc6Lg8V
   1rODSN/JeHNfVEGm8WAdPTyZmHgtbdwQegqhymT02kgm1+NgdqwAoNgeB
   +fgDsazFhziSAJcihlq+oV4iTnlt/o/DPXC9Akmf9rwCtruHxvYJGcLqq
   4WHn7Cu0iBtTdRmCzAy/E8A79K3n//oIrUvwcy/turTZB/yYr0YCqn6Ow
   kPB3LlqXpMURcqpRGTTL23kn8ArAvVhog6PG+cijquM2w9G/vA0qTqXvp
   A==;
X-CSE-ConnectionGUID: 6QMKO4iZQQGN154o17smgQ==
X-CSE-MsgGUID: HfBb4ZzOSTKAZcxO1G78TA==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="61911649"
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; 
   d="scan'208";a="61911649"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 13:32:15 -0700
X-CSE-ConnectionGUID: PlkocNe8RMSli1L+9gjxvA==
X-CSE-MsgGUID: xJB/SsNNTt+27q11NZ73NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; 
   d="scan'208";a="148119765"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 13:32:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 13:32:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 13:32:15 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.79)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 13:32:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vbam+w5EKIVMIQV67EpfBXxFWn5LbbTJQAaYqsjr3HkhiqVCgatHKemw12rCnOZmSPgzTSx4HqWSG3ifVeQ2Y4Cdk8ZWcL76eAEgonOSqy8TqVfV1Xr6t5YtSpyEcwcRb4d7x2wf/Gkl3OjhCjXTs6rQUEv9hclPePVymYPjsUeU/w+1LlZvveykicwfhyu0fxr0D7pxTo2Q/QRJdTYoXH+ZnmxAH8LZ8houSmdNRyPzlDCo+5PJwjMh7HpTufTMnautzRcukWpYFfCbslcW4x+GnnJxbWJ87L3isYFKQDEmAqqKktmzuNqAeIWWTDy61G7JTJNToe16fj7MagsWsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yk3w5z40GEbsWi125bClUk/TiLXAHrcE18J29u3fKTo=;
 b=HBL9vXK6HhdakxFoy7L9WgEaLD/Ot2rO1GCD99qR+7nFSGsTOg48e8j9pkgM6inx+7Zx7E8QYuR56bbAwzu+TOLpy41QQLQmcBV9Hd/Je3HKTEooASstZO908MTJWStNFIWvXIMTmPZd/M9ORHJvaxFUrBJLGWQNeQ7r+vS9gp9HywTBvAqUD7r1lHycmPfJz0QuzmbCLHdh9OOk8qCDsUB15/ct452mVhQeWOjiJvXtMv7qqhEqY5io10uBTqYpomyWpNYko6SCyXMVe6zFanNjWZnkZR9uHdPTjg0jpO1d98ek1TQGqzkMbq/Czs3gIfs6QP3tUF9R9Roa0qoy2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by SN7PR11MB7067.namprd11.prod.outlook.com (2603:10b6:806:29a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 20:31:57 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%7]) with mapi id 15.20.8722.031; Wed, 28 May 2025
 20:31:57 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC: "kyle@infradead.org" <kyle@infradead.org>, Josh Boyer
	<jwboyer@kernel.org>, "Hutchings, Ben" <ben@decadent.org.uk>, "Yang,
 You-Sheng" <vicamo.yang@canonical.com>, "Dreyfuss, Haim"
	<haim.dreyfuss@intel.com>, linux-wireless <linux-wireless@vger.kernel.org>
Subject: pull request: iwlwifi firmware updates 2025-05-28
Thread-Topic: pull request: iwlwifi firmware updates 2025-05-28
Thread-Index: AdvQDzir3AzogLiMTo2Wl9etDiPIIg==
Date: Wed, 28 May 2025 20:31:57 +0000
Message-ID: <MW5PR11MB5810FBCE212AEC8D5315F20CA367A@MW5PR11MB5810.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|SN7PR11MB7067:EE_
x-ms-office365-filtering-correlation-id: 9d187506-bcba-4af8-af05-08dd9e26b108
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cWowU0ZSNTh6WXJPM0NwVE44L2pzYW5qQ0FlQ05qOW5QcnhPL2dFeXloUkxn?=
 =?utf-8?B?WnFkOG5Ub3JiUU1SbzhtN3A2VVFyekswcVFBYzEwVlMrV1p4MkdXS0EyTmlS?=
 =?utf-8?B?QU5JNWw5cVQyVHF1ZkxIcUZwZXp5bEk4VTlndnpxVnQzbk5tWUpXZlBhY0N1?=
 =?utf-8?B?VThuWEdzRGtrNG1OczZzSHB5MCtDb0tSZGFVbmhVVytZaW1VMmVZeVk0RzJl?=
 =?utf-8?B?V2d5U0RYVXZ2cGVCTWF6RktqU1I3REJ1dUx6OWFxOTdKWVZTNHBtYlRaMUE3?=
 =?utf-8?B?V28yNnJMYjFpekYvUm5jeHBsZ1FJdFc4Q0lkbEJ1SEtGeHpxU00veEZDc3hp?=
 =?utf-8?B?WmZwYXVmelo4aFg4YjFoRnNOWUczTG0wc0habm52c2w2R2FzQTN5RU9uZWNU?=
 =?utf-8?B?bmZyWW1rTENCcmRtZytya3ZLSU5jdHdlT0gzQkFNb0N5bnNOamJHVWZ5U3lu?=
 =?utf-8?B?bVl3dTJpaVN5SHBNNjNrajFHcXhMNFZwSXNZV010Nmx1R2ljTjNwNkhMWkg3?=
 =?utf-8?B?M2NtTERjcW96N2dpYnVrcHV1YXpZOTYyR2QwVWxnZWptc0ZrRzhKeFBkUUxL?=
 =?utf-8?B?RlVhSkVUYkY0R2RnWlJyVFI2b2ZSejlMc2lFY2JHdE1kaTdmRUdPdEt2UDMy?=
 =?utf-8?B?TVNtbjJJVnlXTUx6N2F0TWtWTEdYMG1BUHBSQ3NFeGxwYnVoQVB1YWk3RGZY?=
 =?utf-8?B?SDNSOGRyNm5aZ2pvcnNZaWJXNzVuZ21iVzZzcGI3ejF0M2RVV2dPYWFJU2FR?=
 =?utf-8?B?NDRtZ001MVRoa0gyckZjRENNVG9lYlRyeDVIcU12aTN1anpBTTVZdXBCZXp2?=
 =?utf-8?B?QjRYMktFZG1lTlN6VmduTldxbWN6N3JsY2k3YU9pc3cycW1xMU5Oa3lSTFVL?=
 =?utf-8?B?Yms3dGxJNVZVL09WV1g3ODRkSFBoS3VTS2o2MzVZcmQ0cGo2VGo2RExWclhH?=
 =?utf-8?B?TzBjVW1yUUk2TFM3amU5Y1BRVTI3RkRNNjg1TDZqMkFkWmtIMk9CY05wNHp5?=
 =?utf-8?B?U1IvZGRQWDhyU1Y2WThoMHdCL29kd0tjOTdCNTdtd1pGa0M5NWxQYmhpUFpk?=
 =?utf-8?B?cWcvUjNHMUphdWxiVmdQb0N2WW1mNHNaR0dXelAvZDZZbDNLUGlNR1hWRGpY?=
 =?utf-8?B?dnQxRW1oT3YyeHVUT2Z1Tk9SbVV1a1Q5Ym9nK3VES2RSaFpZQUF4SFZKd2Vu?=
 =?utf-8?B?d09SSDVZdkpEeUxsaHJLemNsejNoZ005RFJzdTVoTlplT2VhcS9aendSb1pr?=
 =?utf-8?B?Vk9ZblJHY2dmNkppTnkwb2ZBK1NYeVZabGxEKzJRdnBTQVRHVE0rVDhZMzg0?=
 =?utf-8?B?OGpIdlo0THErK0kyK2pHNHM5bng0Y2VrN1FRMUdjV1pEdnJ2bGVldU9TV3p5?=
 =?utf-8?B?Rjl0VXYzcWt1bVpSVEJ0Q2plaXVGSWlOTzhNN0RCdTJEcksyZ3pOSWJxUE9F?=
 =?utf-8?B?V2VxRlhiRnpqTTFJQ1Q3dzU1ZFVFaGxuVjZ2aGVoVW1YdlFycHFmbzdRaHBO?=
 =?utf-8?B?MDk1K3RPM3pNWVNNTkk2N2ZZRVNjZFdBSTRkQmszcFdDZUtSMit2eTBOUExL?=
 =?utf-8?B?WjIzUU9uRHk2KzlwK2M1d0pmZnI3WFJocWZJL1BFTDgzaW00eTNOMjF6Q1hl?=
 =?utf-8?B?elkxUmdRS2FsWDhBREdsZkRzSFNvckZLRFRNR2dxbkVjM2pFZGhjZ2pEclpG?=
 =?utf-8?B?NE1DbkswL21EY0gzdy9hc05yWFBLUGNjQ0VRYm80UzhZWDRjZHJMV2ozVWxO?=
 =?utf-8?B?NFZ0R2s3eVh2bnQzYjRLdnpMVis5bXMrekRWWnNGNjdjeDRjWWxTZitFdFQv?=
 =?utf-8?B?Y2dPRmlUVG9HZG9CY01UYzFKdzVWbnh1WUlYN0lxOEhLVERjcHRjb1FQMkdt?=
 =?utf-8?B?Zy9CNVpIY00xc2szeDNLMnBjM1dKWlpHeTdnQ2o3aWJLUVVPSlFZakMwaEps?=
 =?utf-8?B?UmdMdkRHQ21SZlNGQUlHekdFa1hFU0VsQVVWaDlNNnNabVFray80Mk9jTm9W?=
 =?utf-8?Q?mmdsGpJHzH0BjQfRrukwHPTZHvMUmY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjZIL1ZMdllPRHFCc3VkNEpSSlFEN2Vabnc2VW9lUmdHM0Rmd3NtQmEwYmZW?=
 =?utf-8?B?cG4yaEt1QXV4SXJYWWY0engzaHpIc0IrU2FtOVd0ZWFLWGlGN0x5UW5CWEU1?=
 =?utf-8?B?aXBCVG9GNkUvOUIxU1UrWXAzdlU5MWhVaElBV2R3enM2WGVCQSt6RWFXS003?=
 =?utf-8?B?Tks0Q2lUTjFYZkFWYTJuRHRReU1LMjd4bEEyL0xlMlZJckcySEM0YWJwNmRX?=
 =?utf-8?B?UGgxUy9OcmRCNENYbWZId2NnVzY1MWlrK21tSkhGY3FkMlZuM040bllNVGdH?=
 =?utf-8?B?MnhqTzcyRVBhTmdDb2pDRUZDUS9ZTG9WcDhjNWZyY2RmOVo2YzArQklrYnVX?=
 =?utf-8?B?bFY4Z09lNHVWUlBqKzUySDh1Y05zenFkNFdEbXNlZGZDSU5IeGJ1MDlPR0Nq?=
 =?utf-8?B?VHBmMy9XN1A5UFJWVTQ2U3oxR3A4TmNsYkJjN2RFTHVMa0FCeDZ1SW9DSGRM?=
 =?utf-8?B?YXZwbkRWRk04ei9RaEFHalgvSEd5d1I4VlhoaVU4R1haa0pyY0o5Yk5tWHY3?=
 =?utf-8?B?V0xqS0ZTSGJQN1plalVmSjN6SDFCRURwRFk4aGtWQmM2bEJKbm13N05Mc05Z?=
 =?utf-8?B?d0hsVThwWXZiQWdUUmhqaWo5YjVEOUp4aUVBUkpxZzdIRi90aHJpOFNLNWh5?=
 =?utf-8?B?MGVzOGhjdWxEdkxIa0FBQkd1VzNrN0RxaFRDNnJ3L2FPRm5YcDhzYVlja2NM?=
 =?utf-8?B?YlZ5TGFkdlVyZFByL21GQmJDcWV3MG5ZalhPUzV2dm51c2pLNDhKcTJzTTVa?=
 =?utf-8?B?RWVOK0ViUldjV0FMdnAxeHdBWXdOR3RPYUZoQTl3UzF3SDVxM3NzQzdpa3lJ?=
 =?utf-8?B?TFBvdlJMOUVxNkxMQXpmUEFBcTNLc0wrczR4TEFSSGpMd1ZmTVJuZTlLZFkv?=
 =?utf-8?B?WnJjelh3V1ZqMjkvTFlSWVRnZlI3VXV5UlVacHRPOWU2WlBacXVqU28zZHlh?=
 =?utf-8?B?YzVjVTA3cHpwYUV5NWpWSkIrYWlhMFhVcXhiUlAxQUYwWW9FaDRucWRUZFJw?=
 =?utf-8?B?VWIyOURqTFJ3OFd5U0Rodk5UMzI4dDBCelp0QmxjMkhudXdXLzNDZHg0VUFo?=
 =?utf-8?B?eCs0aVE3MDhvUCtIVG1lbzEwMDRsR001QzNJYnhudkE1L1gvZSs3VG9QZFZn?=
 =?utf-8?B?MzdHOUpLc2NJNXB5aSs0V2NXeVI4eFpYUjcya0NlbGtvYkVIYTFYc1RjdWhi?=
 =?utf-8?B?Mk1WaWRMTWhZOFFQckxSM2NHWk95QTJCRm5yTWg0SjBVaTh0QTBBcndOODFQ?=
 =?utf-8?B?Y1lCTldvUFhwSjVlZ3ZHdEVyQzlOTFpTbnFuV3ROU3NMUFlEbDRlRzBmVlF0?=
 =?utf-8?B?YmVPTXBZSzZDcUdkNVdDbGRodTRWdVdYOElBS1JKaFpyYzExOEhLTXhqaCtX?=
 =?utf-8?B?RU9EUkVISzV6RVpZZXkvZUVPS1AzWU42VzBpZUh5WHNhbXZnS0QyY2lTT3p4?=
 =?utf-8?B?UEdIOEMzblFLaU1Od2laUVhjN2tqemxvbFRJZkRvL3FCejdwczhoZlB2THh0?=
 =?utf-8?B?Y0FTS01hTXpRdVFKblNJZHRUWmU2Yy9ucTJ5eGF3YjlyakVTUHc5MGJ3ZUl5?=
 =?utf-8?B?WTA4QVRXMFRoUDQ4SWJQNWYzZ3J2STNKMWMyRjFDQ211dG4yQXhTWGFqcmFO?=
 =?utf-8?B?Q0Nic3ZTT1Z0TkVsR1ZlZnBVQWV4aktvZEIyVC9vTTkxbXI1aDRGVXNQdFJF?=
 =?utf-8?B?MUlZc3Noa2dvbkRjS0JDUFQ3YzVabjVZcFdTK1I1MkRUNjJ6R2x2NlQwZkFN?=
 =?utf-8?B?YnJMVFhzb0tDNUwrSEVFVDIrM3ZKenpCbDlsOUFZblc4Q0lseXBIa0s3c0ps?=
 =?utf-8?B?VjBDY05Rc0R4eUlUdUx1ZE1oc0h3bGFUSXd6ZGlCS0pMK0tJQTduTWNXQVN3?=
 =?utf-8?B?RHVUdzdvaytSTXdTMTJwdHlFcTVHYkpNVW00OG1pM20wcDdKTStFK1h2ZEtR?=
 =?utf-8?B?UUlnL3dLV2RSWStpZXhXNFJxUUNDNVZCcURBd0NFNFBJbkRmaktwWHk1VDdR?=
 =?utf-8?B?WEhOR0dvNFNiQ3hJQjJYYjlwT3ZmVzhNc24vSzNpWUZNRnc5V2RwUEpHOENQ?=
 =?utf-8?B?Z2lBbVdMamNNT0FPMmoySG9FVmhmVDlkcXdvc05rdVdIa29yTHV2L0pZaTVI?=
 =?utf-8?B?MHBzRHBzMk0rRTE3YUlUNFRuNFIvU0xSTTBGMElDMXRYYkE0dG5ZSjNyUTdM?=
 =?utf-8?B?Q0E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d187506-bcba-4af8-af05-08dd9e26b108
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 20:31:57.2068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cCvAG2OiegA/HFv9UU2gNjrpscLRoY1wz1Be6L4UC4E3CIGkS7kG72auoc5E7mv/ck1ARnu90Rm4Wpp0HRmA2SLuzHxeTo3Px+Jr741Jz89HJbQuhG1cDNekkWU+OmOO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7067
X-OriginatorOrg: intel.com

SGksDQoNClRoaXMgY29udGFpbnMgc29tZSBuZXcgYW5kIHVwZGF0ZWQgZmlybXdhcmVzIGZvciBh
bGwgb3VyIGN1cnJlbnRseQ0KbWFpbnRhaW5lZCBGVyBiaW5hcmllcy4NCg0KUGxlYXNlIHB1bGwg
b3IgbGV0IG1lIGtub3cgaWYgdGhlcmUgYXJlIGFueSBpc3N1ZXMuDQoNCi0tDQpUaGFua3MsDQpN
aXJpDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgMzFhZmFlNmIyNzRhNGRm
OWExMTBmY2Y4NmI5NGIzMGY2M2NhMTgwMToNCg0KICBNZXJnZSBicmFuY2ggJ210NzkyNWJ0JyBp
bnRvICdtYWluJyAoMjAyNS0wNS0yOCAxMjo0MzowMSArMDAwMCkNCg0KYXJlIGF2YWlsYWJsZSBp
biB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6DQoNCiAgaHR0cDovL2dpdC5rZXJuZWwub3JnL3B1Yi9z
Y20vbGludXgva2VybmVsL2dpdC9pd2x3aWZpL2xpbnV4LWZpcm13YXJlLmdpdCB0YWdzL2l3bHdp
ZmktZnctMjAyNS0wNS0yOA0KDQpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gNmUxNWU3
NDhjMWE3MDI0NzA5YjI5ZjAzMWNjNjQ3OWQxMTUyMjQ1OToNCg0KICBpd2x3aWZpOiBhZGQgQnov
Z2wgRlcgZm9yIGNvcmU5Ni03NiByZWxlYXNlICgyMDI1LTA1LTI4IDIzOjIzOjA4ICswMzAwKQ0K
DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQpyZWxlYXNlIGNvcmU5NiBGV3MNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KTWlyaSBLb3JlbmJsaXQg
KDUpOg0KICAgICAgaXdsd2lmaTogdXBkYXRlIDcyNjVEIGZpcm13YXJlDQogICAgICBpd2x3aWZp
OiB1cGRhdGUgZmlybXdhcmVzIGZvciA4MDAwIHNlcmllcw0KICAgICAgaXdsd2lmaTogdXBkYXRl
IGNjL1F1L1F1WiBmaXJtd2FyZXMgZm9yIGNvcmU5Ni03NiByZWxlYXNlDQogICAgICBpd2x3aWZp
OiB1cGRhdGUgdHkvU28vTWEgZmlybXdhcmVzIGZvciBjb3JlOTYtNzYgcmVsZWFzZQ0KICAgICAg
aXdsd2lmaTogYWRkIEJ6L2dsIEZXIGZvciBjb3JlOTYtNzYgcmVsZWFzZQ0KDQogV0hFTkNFICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgNDYgKysrKysrKysrKysrKysrKysrKysrKysrKystLS0t
LS0tLS0tLS0tLS0tDQogaXdsd2lmaS03MjY1RC0yOS51Y29kZSAgICAgICAgfCBCaW4gMTAzNjc3
MiAtPiAxMDM2MzEyIGJ5dGVzDQogaXdsd2lmaS04MDAwQy0zNi51Y29kZSAgICAgICAgfCBCaW4g
MjQyODAwNCAtPiAyNDI1MDg0IGJ5dGVzDQogaXdsd2lmaS04MjY1LTM2LnVjb2RlICAgICAgICAg
fCBCaW4gMjQzNjYzMiAtPiAyNDMyNTI4IGJ5dGVzDQogaXdsd2lmaS1RdS1iMC1oci1iMC03Ny51
Y29kZSAgfCBCaW4gMTQwNjE4NCAtPiAxNDA2MTg0IGJ5dGVzDQogaXdsd2lmaS1RdS1iMC1qZi1i
MC03Ny51Y29kZSAgfCBCaW4gMTMyMjg5NiAtPiAxMzIyODk2IGJ5dGVzDQogaXdsd2lmaS1RdS1j
MC1oci1iMC03Ny51Y29kZSAgfCBCaW4gMTQwNjIwMCAtPiAxNDA2MjAwIGJ5dGVzDQogaXdsd2lm
aS1RdS1jMC1qZi1iMC03Ny51Y29kZSAgfCBCaW4gMTMyMjkxMiAtPiAxMzIyOTEyIGJ5dGVzDQog
aXdsd2lmaS1RdVotYTAtaHItYjAtNzcudWNvZGUgfCBCaW4gMTQwNjMyMCAtPiAxNDA2MzIwIGJ5
dGVzDQogaXdsd2lmaS1RdVotYTAtamYtYjAtNzcudWNvZGUgfCBCaW4gMTMyMjk4OCAtPiAxMzIy
OTg4IGJ5dGVzDQogaXdsd2lmaS1iei1iMC1mbS1jMC05OS51Y29kZSAgfCBCaW4gMCAtPiAxOTI3
MTk2IGJ5dGVzDQogaXdsd2lmaS1iei1iMC1mbS1jMC5wbnZtICAgICAgfCBCaW4gMjk1MzU2IC0+
IDI5NjA2MCBieXRlcw0KIGl3bHdpZmktYnotYjAtZ2YtYTAtOTkudWNvZGUgIHwgQmluIDAgLT4g
MTc3NzQ2NCBieXRlcw0KIGl3bHdpZmktYnotYjAtZ2YtYTAucG52bSAgICAgIHwgQmluIDU1MjA4
IC0+IDU1MjA4IGJ5dGVzDQogaXdsd2lmaS1iei1iMC1oci1iMC05OS51Y29kZSAgfCBCaW4gMCAt
PiAxNTc4ODQwIGJ5dGVzDQogaXdsd2lmaS1iei1iMC1oci1iMC5wbnZtICAgICAgfCBCaW4gMTc4
OCAtPiAxNzg4IGJ5dGVzDQogaXdsd2lmaS1jYy1hMC03Ny51Y29kZSAgICAgICAgfCBCaW4gMTM2
NzcwMCAtPiAxMzY3NzAwIGJ5dGVzDQogaXdsd2lmaS1nbC1jMC1mbS1jMC05OS51Y29kZSAgfCBC
aW4gMCAtPiAxOTEyNTM2IGJ5dGVzDQogaXdsd2lmaS1nbC1jMC1mbS1jMC5wbnZtICAgICAgfCBC
aW4gMjk1MDM2IC0+IDI5NTc0MCBieXRlcw0KIGl3bHdpZmktbWEtYjAtZ2YtYTAtODkudWNvZGUg
IHwgQmluIDE3NDc1MjAgLT4gMTc1MTcwMCBieXRlcw0KIGl3bHdpZmktbWEtYjAtZ2YtYTAucG52
bSAgICAgIHwgQmluIDU1MTI4IC0+IDU1MTI4IGJ5dGVzDQogaXdsd2lmaS1tYS1iMC1nZjQtYTAt
ODkudWNvZGUgfCBCaW4gMTU5OTg2NCAtPiAxNTk5OTQ4IGJ5dGVzDQogaXdsd2lmaS1tYS1iMC1n
ZjQtYTAucG52bSAgICAgfCBCaW4gMjc4MzYgLT4gMjc4MzYgYnl0ZXMNCiBpd2x3aWZpLW1hLWIw
LWhyLWIwLTg5LnVjb2RlICB8IEJpbiAxNTM5NTcyIC0+IDE1Mzk2NTYgYnl0ZXMNCiBpd2x3aWZp
LXNvLWEwLWdmLWEwLTg5LnVjb2RlICB8IEJpbiAxNzM1OTQ0IC0+IDE3MzYwMjggYnl0ZXMNCiBp
d2x3aWZpLXNvLWEwLWdmLWEwLnBudm0gICAgICB8IEJpbiA1NTIwOCAtPiA1NTIwOCBieXRlcw0K
IGl3bHdpZmktc28tYTAtZ2Y0LWEwLTg5LnVjb2RlIHwgQmluIDE1OTA0NTYgLT4gMTU5MDU0MCBi
eXRlcw0KIGl3bHdpZmktc28tYTAtZ2Y0LWEwLnBudm0gICAgIHwgQmluIDI3ODc2IC0+IDI3ODc2
IGJ5dGVzDQogaXdsd2lmaS1zby1hMC1oci1iMC04OS51Y29kZSAgfCBCaW4gMTUyNjc0MCAtPiAx
NTI2ODI0IGJ5dGVzDQogaXdsd2lmaS10eS1hMC1nZi1hMC04OS51Y29kZSAgfCBCaW4gMTY3Nzgx
MiAtPiAxNjc3ODk2IGJ5dGVzDQogaXdsd2lmaS10eS1hMC1nZi1hMC5wbnZtICAgICAgfCBCaW4g
NTUwNTIgLT4gNTUwNTIgYnl0ZXMNCiAzMSBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCsp
LCAxNyBkZWxldGlvbnMoLSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaXdsd2lmaS1iei1iMC1mbS1j
MC05OS51Y29kZQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpd2x3aWZpLWJ6LWIwLWdmLWEwLTk5LnVj
b2RlDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGl3bHdpZmktYnotYjAtaHItYjAtOTkudWNvZGUNCiBj
cmVhdGUgbW9kZSAxMDA2NDQgaXdsd2lmaS1nbC1jMC1mbS1jMC05OS51Y29kZQ0K

