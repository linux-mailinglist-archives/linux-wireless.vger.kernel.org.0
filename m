Return-Path: <linux-wireless+bounces-31164-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJnGFSUVd2mHbwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31164-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 08:17:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 841EC84C47
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 08:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 22B08300D267
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 07:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285E52BEC27;
	Mon, 26 Jan 2026 07:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W3Iz55AU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0391A2C11C2;
	Mon, 26 Jan 2026 07:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769411767; cv=fail; b=jEzVJC0GqI5afkuOXI7lP+qe/4DECiFYqUU8L+fdQHuixzb4pg1LO77bfXB9GLqVcWflmVpV3JlHcSB4N3z2HN9Z4HoACDLzYAb/nSZnCeYGCz3iB2yi8ir6ONIxKc8M6NX0a/HeQMiGNGXRtsV4GAimzNH7bpOGHZwWD7IOv94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769411767; c=relaxed/simple;
	bh=zfhgFpa4lPWb8Ek4J9fliFa9RKOq06B3y00tcw+1rnQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=av+ATikJke+EH7gPymCSGn3KnMXbO2n1SHN3lRk4pmHVYuHB0gP3A+p5X8INDFH7k1lPrWKY1dgGIVxZU9KEd57WJ9fASYDp6GnsKUc7l8qG1POucPjXhKxgOhVGf9EobKAh1H+rHHD3mJ8IPyme6yBgBF5DzD2xnDgffwsSEpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W3Iz55AU; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769411763; x=1800947763;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zfhgFpa4lPWb8Ek4J9fliFa9RKOq06B3y00tcw+1rnQ=;
  b=W3Iz55AU9uw/s+rvafmz3X1V5E5oNytfS0V63LXw4rbkRaA8QDZ8JJT3
   xz8Z4XsKTWP4B11zmaHbSvFXKkEi4rdB3jq0ohzBHyxdLZWDwVmciJNl4
   OWANO5HaOIAVPlqQlDqyFYGTfdF0/5x7aI6wmK8sS9JWN07twVi1JgP5A
   bs6aIUYGcuy+J20/kIvXh9d34o1ZtYJasQsOMU08nnr6qSwGOuLopocbW
   z2JDct0ky9zTwPlxcFaRlB1enNdrQ0zVpHPr+1lrB7uIX6r8OQINNTz+N
   SF+2/3Gmkl/uLO8mU1xiS55c8T+zS/Ods7F4k673d25O8YwuaSEgE2MCt
   g==;
X-CSE-ConnectionGUID: iU8Q2Cq1RtmCaN/oGu21lw==
X-CSE-MsgGUID: YaxBucGpSP+G1dJ7AJIasw==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="74428353"
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="74428353"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2026 23:16:01 -0800
X-CSE-ConnectionGUID: 45U3EEIEQiGHuW+Op/8r8Q==
X-CSE-MsgGUID: KxM2C1nXSUOeAWmpr8ooag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="245222175"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2026 23:16:01 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 25 Jan 2026 23:16:00 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Sun, 25 Jan 2026 23:16:00 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.39) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 25 Jan 2026 23:15:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3o4cakOFzRYQKZFwgS0GQk5d5rw293KDaxYtvjgGU21JiCUs11r3W2nxzzaqrwPWoNn5tKZw1lb30P6b0UlqJRCTuBpXpTBZlzhIxgzpr121xz2fSp92yZRnd59BiEvJwNLWmrrgvWGh8bVv0IUtr92WpANNJLBfuFRTc4so2ZfaVP3gUct3X8PUBLQtnt+5HVnkmpU4BA4/5z81q6R2pUeUR1d6dqO+KXn6RjRMQqPMZ9g1cxNVMmmZsxTh4js9moRMd2SYU3XHvDCzActDkeR/aZtbYaB6jpAUnh92aHeTFBRm2gXx7UdwlAo98FKdFRYWiWve5xtnr6d/ngNDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfhgFpa4lPWb8Ek4J9fliFa9RKOq06B3y00tcw+1rnQ=;
 b=vxKQwZhdFxgMYbPb2WuK+HsIg0PklTo8JPF+gNgBOe/myfhsMQBflIfyj5FxYQ3YyTBI0nkvP9Yidfup8x4Ff/Rjj9xbwyfjNCq45CZnWNKHwc7j2a7aSX2yfFA516GYpaEA8Islveifr+RQ5YvsehdzJ0qt1sTiJAuuqR2O++4Le8ngYJUL1wrySkMvbJkx23M9S49oI7iYdbqRTaU9i8ER1xNgH+3Gi94V3pNYvpj9MZD/AgAYm81RGXAzGwpJd1DLQ4GxMQ2dUm6gN6Kwgk5Q8uDkrt6dHs/2z165PUZAnjgP++sWg7oy4dRJgM9GP2p3X3I7+t2Cgf0DoLG//Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by MN6PR11MB8217.namprd11.prod.outlook.com
 (2603:10b6:208:47d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 07:15:54 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5%3]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 07:15:54 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Chris Bainbridge <chris.bainbridge@gmail.com>, "kvalo@kernel.org"
	<kvalo@kernel.org>
CC: "Berg, Johannes" <johannes.berg@intel.com>, "benjamin@sipsolutions.net"
	<benjamin@sipsolutions.net>, "gustavoars@kernel.org" <gustavoars@kernel.org>,
	"linux-intel-wifi@intel.com" <linux-intel-wifi@intel.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] Revert "wifi: iwlwifi: trans: remove STATUS_SUSPENDED"
Thread-Topic: [PATCH] Revert "wifi: iwlwifi: trans: remove STATUS_SUSPENDED"
Thread-Index: AQHcjlMSDsDNaO3QzkSRZaUB0ZOqB7VkClEA
Date: Mon, 26 Jan 2026 07:15:54 +0000
Message-ID: <DM3PPF63A6024A93B1437A144E82CC38B7AA393A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <20260125233335.6875-1-chris.bainbridge@gmail.com>
In-Reply-To: <20260125233335.6875-1-chris.bainbridge@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|MN6PR11MB8217:EE_
x-ms-office365-filtering-correlation-id: 7a1907f1-b234-4cfc-12b3-08de5caabebd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Ykk4Unc3bnYzbXAwWUxkSVhhWVROQVdLYVpDOHVzRFA3ZFVYR1JKYWRIc2xM?=
 =?utf-8?B?Wkx5NHorTmJ0OHdtODd5WUd3ZFhheUhXeWdDSDFwQWFTaWJVbno2ajlURFox?=
 =?utf-8?B?WTVxYTBhS2RkUlE5VnVlMnNIUmg5OHZtZy82eXRkRXlzdVpXNXRzWWRMRkJy?=
 =?utf-8?B?Qm1nMkpXdVcvaThVbG1mRUdZcGV6YWJiN1NQUkZEdHQxSWxCMzRJN2F2RnBs?=
 =?utf-8?B?S0wxY2lXczZoZW9EWFVMRGVwdThqQTcydzFQaWtwNTV5QTRXeTFja0tIeUZ1?=
 =?utf-8?B?WDJuL3VkU2FvTGFpREFWcHREWC9CbGdnekhtUzZFcDllS0lFb1ZxYXpoTUUv?=
 =?utf-8?B?RExWRTBvL3Z6S05qR3JVc3RNWmxGWGlBTjBmeXN6VXVGV3JHSUxLeHVQY2Ny?=
 =?utf-8?B?Vm45Y09iazhrZjQzVzM1c1pzRHFYSHE0THZiZ0tqQ01wazZHZTZONGd0Yjkz?=
 =?utf-8?B?b0xjRkR4ckl2NUNFdXpDakxVM285TU42ekdPTzBBRkNrWExMeUcxZ2x1TFIy?=
 =?utf-8?B?RFU1RlpQL04zeG5DVUJaMktjeWhuWk5rWnBrN1AwOXFSL01ISGtrVE9QK1JZ?=
 =?utf-8?B?Mlp3ZFp0RjRIcmdoZE9NK2RHT1RMWDBmRGtrU202RVhWU1pPUWxVckZ3V0Ns?=
 =?utf-8?B?cldxTGNTaVlQUmU1QmdqcDlTY1ViMkFWb2FhL3AySHhrRXppWFo2VGRleFlj?=
 =?utf-8?B?dGxqUmJ6Y0tSWHFlVkxGUWhWSTRLeURXUFg0VGl0Wms3emhvbFV3WUplSWRn?=
 =?utf-8?B?TGVsaGtoZXJXV0Y1T0dlZGdaL3k3ZWJYV2F6ci9GSWQxRldBU2xtcC85S0lu?=
 =?utf-8?B?QTZQczg2cjloeEwycjJ5Z0RUOGIyZStBQ0lScnBBNzFWUG93ZzR5RGFzalZ4?=
 =?utf-8?B?Q2J2ZVJDK2VDT1g4RmdhRGRNaW16eU1LMyttMUVUeTREakNLbHdkakxqZ0dG?=
 =?utf-8?B?K2ZkZVcyOE4vNWZzYVByUEtWRmFVYlhpd2pJbEU2OHlLVGVjVm0rdzZwR0xQ?=
 =?utf-8?B?djJWbXpCbmFZWjk3TlFQKzZ5V0RTRDRXY2FIQlJXeExRMkpLUTdHRENCOEhw?=
 =?utf-8?B?bDc5NXoxM0V2U0V2a3RYL1BlN2tDSUJYTU9WeTZQdUhCZ1Y1dWxIQmNvMDVs?=
 =?utf-8?B?UzhEUlNCeTBDZVg5bWZoZU1jS1gzb0FNcjNvTkJzaEVxcjBGaTQ2Y3NTd283?=
 =?utf-8?B?U2ZhYnVsZzRoYjU5OWQ1SlRERFBEek40VjRkWVpxcUJvV0ZzZU00THJ0bW1E?=
 =?utf-8?B?anlNNWloZjlvVEtxbTBCS0F1ekZPU1pTYjVFQW84U2dFWHZFS1NjZ0xnaFBo?=
 =?utf-8?B?enV0RXI3N3JEdCt0WXAzbTdDRWtFbUxtVlp6N2E4ZmUwR1RLYlRWWlpnVHJ5?=
 =?utf-8?B?dVZTNFVORE9VcWRsbWFOdnVKckhnOVd4b3FXMytRY01ESWhrS0p6eUdXMUxv?=
 =?utf-8?B?T3BFN3VaYy9tbS9pMnhuTVRvM0hMSGZKS0tGaThvVXV4SlFxQlJLUlBGOCtH?=
 =?utf-8?B?MmJqV2x5blNydzRNOStlTVZGSUZ2b2xDTGpEb1VsYzZzLzl2V3VGWExOWjl3?=
 =?utf-8?B?WmlFQWtEem1iRGhoaXd6cHZYc3hubG1xaVVwaFUvbkJLTDREaEpFMkZNbmpR?=
 =?utf-8?B?Ky9yMVRjNTVTemplWWZqUlNXbjNXMWZweUo3anIwNW96VjRtR2prM2U2QllM?=
 =?utf-8?B?TzdocU1EWi9ZU09YVW9zaklhMElyVGdYRlhLYzJRRVl1dUk5L1kwQVBXanNi?=
 =?utf-8?B?amtianJoWE9ZRjZ5QkU1RncxZjVnRVM1QUkrUThzYXAxckZLK28zWFVYbEJk?=
 =?utf-8?B?NlZPcXh1WVpycTZZTTlrLy83Szd5eDA5L0lWUnVBY2JjV21pQ21ZeU9VcGV5?=
 =?utf-8?B?REVYbk9Tb0FkRHRpYXlYKzNaRjFmUk9hU3N5WUhJbU9ScHEva0xQWDhSamFn?=
 =?utf-8?B?NFFuWGpScWQvRDBlVXBEeFBkVEkxb1JkRHgxK0ltYVlRZlNBSXVyd1VsSW1N?=
 =?utf-8?B?eEM0ZFRIeWs3TTRvODVJbnEwRStGTnNnSjdzZVB0enU4NkVYeFgwVitCOEJk?=
 =?utf-8?B?NmNzSlZBMDJKTG1tazdTV2JIb3VwNHprL2FSWlhGUlhsNE1HZXZqUXNkbEJF?=
 =?utf-8?B?dGhXWjNWUE1sS24rQkF5ZUpuWHVBSlcvQURyVmlBNmJjYkRGWHZuSTNhNWVp?=
 =?utf-8?Q?XxoQbZIj3AqyNsQUSR455c4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGdXRFNkRFlYNStWY2xaemJYWHNWenRTR29uRXRxTmRUemNUSlROdlBMS0x4?=
 =?utf-8?B?N1Rnb3U4L1hxdWlyR2NPTTN2Q0ZpSFRDazZBb2tHNlVjOXRyRUIweUViNDdD?=
 =?utf-8?B?MTZ2am5SUGtzM3dkTHlsVXRyRDArUGNtaVBXMmIvdDdYS2FScWRIdCtxcTZi?=
 =?utf-8?B?ZjNEbXgreEZ3VE8vWWpCd3FEMDliVDJlZVNBc2NDME05ZFk5ZklrZzB0c1N3?=
 =?utf-8?B?RjJwZW9VcDNRdlpYclBLTjBwTGl4RUFmOThIRWVqNzdLK05ZRnRNTE1vZUta?=
 =?utf-8?B?bXBrRzYxYVVsZG43bWFCRjNJbmxDL1Fub3YvUElIYW5BWkZWN0p5REpvTzRQ?=
 =?utf-8?B?NGIyT2NhdWJqS2VNRHhUQkJjVmx3cEhENDdhaDhyMFZTNkJWdXAwUVU5R2h6?=
 =?utf-8?B?UzlUSUc4cENMcGtNV2JFWVdOVFFIZk52c0lUeU4vTzhCZTV1MmVBWERxallh?=
 =?utf-8?B?cjRnRDQvd096TWxYdEdjL3VrMUh6RHNIekZSTGt5dHhZRXorZGozSnlmbTZs?=
 =?utf-8?B?RE1abHRlTHlmc3cvWnNyd2g3ZEdUNGhocys0RHVZR0M1THV2OW92YkRhQWRy?=
 =?utf-8?B?OHcyRHdOaldsZzNqclpMb2E4ZWRNRHNZNEFVWXBBOERjWTVQcVcvNG96VDIr?=
 =?utf-8?B?dEdvUXJXd2h2TXRDZDdqeW9wZENNWWpVdGhiSW9nMXg1N2c0cDR5QnN2VGx4?=
 =?utf-8?B?TFNieW4yVTFORXZOS3l2cVJISWE3Z01KKzJZTlZIcEREeENxYStoRmYwRzZP?=
 =?utf-8?B?RjFpMk1MM3BIMEVvaExhWXMveXhCRGhrRXcwTWw3dThvK0cxZkRSZ1FTOUkz?=
 =?utf-8?B?UmsybllZeVV0bW5GYVVFM25YK0lJMTRuY2ttRVFsM0wvczhHVXpKVXN2RkhU?=
 =?utf-8?B?VXpqK3dnbC8vaXJFZmVPRnJieFFzU1c0N3lmaEsvM3I1MEhzSmErcHB4bXh6?=
 =?utf-8?B?NFlTNndLWWpBQ0lwaCtrbkdSMm5uWUZqWEtBQjAySUhwQnBrWlJlRzd3U1Vu?=
 =?utf-8?B?UnJUekhtZkZ3T1JocjVleS9LSlBPTWhhU3BqZ2NxS1BhK0h1Z0hHbUlIWmpE?=
 =?utf-8?B?RlhnMjNhR0tYYTd5ZGZ5VVJmTmZYSnJESW4zTVhmbHhUYXVTYjgxQUZhYkFw?=
 =?utf-8?B?U3lSM01aMHg1Tzl6Yk9NNWlzTFU2ZlNScEo2NGNhT216aElnQ0dpdFpBRlQx?=
 =?utf-8?B?Z3A1QTd1cVlQcUxPRm95VFY2YTFPUUxWN2JXYjI3UnpZblZ2dG9CdGlFUEFG?=
 =?utf-8?B?QjN2elU2ZkxzK0VKY204bUwzWk5KWjdjVUcvRjhyR0pGQWpJUWl1VlRKcDFT?=
 =?utf-8?B?ek1EVkJsK0daSEdjWW9WWHNSbGtoVXlyWVduMDRXdTlsNWJKOUhFU3B4Tk1m?=
 =?utf-8?B?VTdkNEw5bWd3SEpDWWdNWktkZGhMd1hUcXhnWXpjdjQyQ1ZYUmxNWklJMW1x?=
 =?utf-8?B?Z1E3aERJRHRvNjkrNFRpMm4valVGUXV1YmJPLzd4V0JRQnBybVVZcWRDTDFy?=
 =?utf-8?B?OVVGVWpNUGFTRHFMeWNvK2FRenhBTWc1UWp2OHlPeVQvRzduZWwrczVOaSsz?=
 =?utf-8?B?N1ZXSXhzbWNZelZlaUNWUldLTWtqVStSRnpkVThlR1Y4UWdIZ2F0UDBvbU5i?=
 =?utf-8?B?OEVDcmhnQ2w2UEZwUTJreHBYLzQ5bllPWXhaMlB2YzZWaXJxZHZsdHJENnZZ?=
 =?utf-8?B?cnV0My9IWXhQYitzRHBzMTNZbVptU1VTNjZXdVpUYXN0eHduZXVLeUVHKytM?=
 =?utf-8?B?NytEM1VvdEZQcWROdVpIY1RmSU5uc3ZJL3FnNE5zdWdTemlPS2lkSS9qRWFH?=
 =?utf-8?B?MzluMkVaS3FJMitFd3Ezb21nSnZ3dmxWQzBRRDg0VkthUWtkRUNaTElpTWFl?=
 =?utf-8?B?M2dwdXhKajlnSm8vMmN3QitIdStWL0U3cThwRUdkSzhHRWtEbWEzU1E0L0VX?=
 =?utf-8?B?dDh6M0M4Tk5YYzVXUUNkUWQzYzNmWmMvcnU1UWxLeWZXOWpOSnpyVkRTbHMr?=
 =?utf-8?B?MU9QY21ZVlMvbnRKdjE5R09ZRnpkQWJpTXFCMmJaYmNsVEJZNVVXWnd6aE8v?=
 =?utf-8?B?czFKY3VwZDdJSkR5YXRhV0wraDBOa1Q3dGhBdmFPOWRHci9wMllTKytBRkFW?=
 =?utf-8?B?YWlsMUcvaGRZTVpMekQwNEV3bnN3Z1BrWGxWSjd2ZnFsWDYveEdEczUrWldl?=
 =?utf-8?B?bkhMdUlVWWRISkQyYVlZNGF6dkhMb1RpUEpYMTFuYTZtZGZsWXhNenRWOTRX?=
 =?utf-8?B?ZDIzaHNPLzQwOGNlYUlSTitOMXlseVQvUTFUT1I0V2ZlQlRmR1dzMlhXUzVv?=
 =?utf-8?B?WitLNkc2MGphWkcxQjd0U3ZER2FUeXp3cXJpNWZ0UlVTSE5nTko4S1RRWnlM?=
 =?utf-8?Q?PmXnLEJlYtTHaZjItOdav4TLgz8veCQFFjMVCwwewCfHY?=
x-ms-exchange-antispam-messagedata-1: lp/N5Y4w/QEoClEvJOqdhI4gYkoH0Umyd1g=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1907f1-b234-4cfc-12b3-08de5caabebd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 07:15:54.7120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GJUKSe59HR96NKu3fdlurX8/U2FZ01MmIhS7zmucv9i4F7N3B3tozyjd44s5TpyuuzXct5F+FmSjg/vMdThFMjDWDj6l2hkOhrlXJTP5M/QpajlKvkjmzBUgDTpr1CCy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8217
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31164-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:email,yhbt.net:url,DM3PPF63A6024A9.namprd11.prod.outlook.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 841EC84C47
X-Rspamd-Action: no action

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENocmlzIEJhaW5icmlkZ2Ug
PGNocmlzLmJhaW5icmlkZ2VAZ21haWwuY29tPg0KPiBTZW50OiBNb25kYXksIEphbnVhcnkgMjYs
IDIwMjYgMTozNCBBTQ0KPiBUbzogS29yZW5ibGl0LCBNaXJpYW0gUmFjaGVsIDxtaXJpYW0ucmFj
aGVsLmtvcmVuYmxpdEBpbnRlbC5jb20+Ow0KPiBrdmFsb0BrZXJuZWwub3JnDQo+IENjOiBCZXJn
LCBKb2hhbm5lcyA8am9oYW5uZXMuYmVyZ0BpbnRlbC5jb20+OyBiZW5qYW1pbkBzaXBzb2x1dGlv
bnMubmV0Ow0KPiBndXN0YXZvYXJzQGtlcm5lbC5vcmc7IGxpbnV4LWludGVsLXdpZmlAaW50ZWwu
Y29tOyBsaW51eC0NCj4gd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgQ2hyaXMgQmFpbmJyaWRn
ZSA8Y2hyaXMuYmFpbmJyaWRnZUBnbWFpbC5jb20+Ow0KPiBzdGFibGVAdmdlci5rZXJuZWwub3Jn
DQo+IFN1YmplY3Q6IFtQQVRDSF0gUmV2ZXJ0ICJ3aWZpOiBpd2x3aWZpOiB0cmFuczogcmVtb3Zl
IFNUQVRVU19TVVNQRU5ERUQiDQo+IA0KPiBUaGlzIHJldmVydHMgY29tbWl0IGU3NjlmNmYyN2Zm
ZTQxMzMxZTAwYjY5YTMzYWE4YTM0ZGI0ZGQ4MzAuDQo+IA0KPiBUaGUgcmVtb3ZhbCBvZiBTVEFU
VVNfU1VTUEVOREVEICh3aGljaCB0cmFja3Mgc3VzcGVuZC9yZXN1bWUgc3RhdGUpDQo+IHJlc3Vs
dGVkIGluIGFuIGludGVybWl0dGVudCByYWNlIGNvbmRpdGlvbiBvbiByZXN1bWUuIFRoZSBmYXVs
dCBjYW4gYmUNCj4gcmVwcm9kdWNlZCBieSBjYXJyeWluZyBvdXQgcmVwZWF0ZWQgc3VzcGVuZC9y
ZXN1bWUgY3ljbGVzIHdoaWxlIHBhc3NpbmcNCj4gdHJhZmZpYyB0aHJvdWdoIHRoZSBOSUMuIEEg
dHlwaWNhbCBmYWlsdXJlIGxvb2tzIGxpa2U6DQo+IA0KPiBbICAxNDEuMDkzOTg2XSBpd2x3aWZp
IDAwMDA6MDE6MDAuMDogRXJyb3Igc2VuZGluZyBTQ0FOX0NGR19DTUQ6IHRpbWUgb3V0DQo+IGFm
dGVyIDIwMDBtcy4NCj4gWyAgMTQxLjA5NDA1N10gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IEN1cnJl
bnQgQ01EIHF1ZXVlIHJlYWRfcHRyIDQ0MQ0KPiB3cml0ZV9wdHIgNDQyIFsgIDE0MS4wOTQ4NjRd
IGl3bHdpZmkgMDAwMDowMTowMC4wOiBTdGFydCBJV0wgRXJyb3IgTG9nIER1bXA6DQo+IFsgIDE0
MS4wOTQ4NjZdIGl3bHdpZmkgMDAwMDowMTowMC4wOiBUcmFuc3BvcnQgc3RhdHVzOiAweDAwMDAw
MDQyLCB2YWxpZDogNiBbDQo+IDE0MS4wOTQ4NzBdIGl3bHdpZmkgMDAwMDowMTowMC4wOiBMb2Fk
ZWQgZmlybXdhcmUgdmVyc2lvbjogODkuN2Y3MWM3ZjQuMCB0eS0NCj4gYTAtZ2YtYTAtODkudWNv
ZGUgWyAgMTQxLjA5NDg3M10gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDEwMDAwNzEgfA0KPiBB
RFZBTkNFRF9TWVNBU1NFUlQgLi4uDQo+IFsgIDE0MS4wOTg0MDFdIGl3bHdpZmkgMDAwMDowMTow
MC4wOiBpd2xfbXZtX2NoZWNrX3J0X3N0YXR1cyBmYWlsZWQsIGRldmljZSBpcw0KPiBnb25lIGR1
cmluZyBzdXNwZW5kDQo+IA0KPiBUaGUga2VybmVsIHRoZW4gb29wcyBkdWUgdG8gYSBudWxsIHBv
aW50ZXIgZGVyZWZlcmVuY2UgaW4NCj4gaXdsX212bV9yZWFsbG9jX3F1ZXVlc19hZnRlcl9yZXN0
YXJ0KCkuDQo+IA0KPiBGaXhlczogZTc2OWY2ZjI3ZmZlICgid2lmaTogaXdsd2lmaTogdHJhbnM6
IHJlbW92ZSBTVEFUVVNfU1VTUEVOREVEIikNCj4gQ2xvc2VzOiBodHRwczovL3loYnQubmV0L2xv
cmUvbGludXgtDQo+IHdpcmVsZXNzL2FURG9EaUQ1NXFsVVowcG5AZGViaWFuLmxvY2FsLw0KPiBD
YzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IENocmlzIEJhaW5i
cmlkZ2UgPGNocmlzLmJhaW5icmlkZ2VAZ21haWwuY29tPg0KPiAtLS0NCj4gIC4uLi9uZXQvd2ly
ZWxlc3MvaW50ZWwvaXdsd2lmaS9pd2wtdHJhbnMuYyAgICB8IDIyICsrKysrKysrKysrKysrKysr
LS0NCj4gIC4uLi9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9pd2wtdHJhbnMuaCAgICB8ICAz
ICsrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkv
aXdsLXRyYW5zLmMNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2l3bC10
cmFucy5jDQo+IGluZGV4IGNjOGE4NDAxOGY3MC4uZjVjNGFhMTY1YzViIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2l3bC10cmFucy5jDQo+ICsrKyBi
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvaXdsLXRyYW5zLmMNCj4gQEAgLTMw
Niw2ICszMDYsOSBAQCBpbnQgaXdsX3RyYW5zX3NlbmRfY21kKHN0cnVjdCBpd2xfdHJhbnMgKnRy
YW5zLCBzdHJ1Y3QNCj4gaXdsX2hvc3RfY21kICpjbWQpDQo+ICAJCSAgICAgdGVzdF9iaXQoU1RB
VFVTX1JGS0lMTF9PUE1PREUsICZ0cmFucy0+c3RhdHVzKSkpDQo+ICAJCXJldHVybiAtRVJGS0lM
TDsNCj4gDQo+ICsJaWYgKHVubGlrZWx5KHRlc3RfYml0KFNUQVRVU19TVVNQRU5ERUQsICZ0cmFu
cy0+c3RhdHVzKSkpDQo+ICsJCXJldHVybiAtRUhPU1RET1dOOw0KPiArDQo+ICAJaWYgKHVubGlr
ZWx5KHRlc3RfYml0KFNUQVRVU19GV19FUlJPUiwgJnRyYW5zLT5zdGF0dXMpKSkNCj4gIAkJcmV0
dXJuIC1FSU87DQo+IA0KPiBAQCAtNDA2LDYgKzQwOSw4IEBAIGludCBpd2xfdHJhbnNfc3RhcnRf
aHcoc3RydWN0IGl3bF90cmFucyAqdHJhbnMpDQo+ICAJbWlnaHRfc2xlZXAoKTsNCj4gDQo+ICAJ
Y2xlYXJfYml0KFNUQVRVU19UUkFOU19SRVNFVF9JTl9QUk9HUkVTUywgJnRyYW5zLT5zdGF0dXMp
Ow0KPiArCS8qIG9wbW9kZSBtYXkgbm90IHJlc3VtZSBpZiBpdCBkZXRlY3RzIGVycm9ycyAqLw0K
PiArCWNsZWFyX2JpdChTVEFUVVNfU1VTUEVOREVELCAmdHJhbnMtPnN0YXR1cyk7DQo+IA0KPiAg
CXJldHVybiBpd2xfdHJhbnNfcGNpZV9zdGFydF9odyh0cmFucyk7ICB9IEBAIC01MDUsMTcgKzUx
MCwzMCBAQA0KPiBpd2xfdHJhbnNfZHVtcF9kYXRhKHN0cnVjdCBpd2xfdHJhbnMgKnRyYW5zLCB1
MzIgZHVtcF9tYXNrLA0KPiANCj4gIGludCBpd2xfdHJhbnNfZDNfc3VzcGVuZChzdHJ1Y3QgaXds
X3RyYW5zICp0cmFucywgYm9vbCByZXNldCkgIHsNCj4gKwlpbnQgZXJyOw0KPiArDQo+ICAJbWln
aHRfc2xlZXAoKTsNCj4gDQo+IC0JcmV0dXJuIGl3bF90cmFuc19wY2llX2QzX3N1c3BlbmQodHJh
bnMsIHJlc2V0KTsNCj4gKwllcnIgPSBpd2xfdHJhbnNfcGNpZV9kM19zdXNwZW5kKHRyYW5zLCBy
ZXNldCk7DQo+ICsNCj4gKwlpZiAoIWVycikNCj4gKwkJc2V0X2JpdChTVEFUVVNfU1VTUEVOREVE
LCAmdHJhbnMtPnN0YXR1cyk7DQo+ICsNCj4gKwlyZXR1cm4gZXJyOw0KPiAgfQ0KPiAgSVdMX0VY
UE9SVF9TWU1CT0woaXdsX3RyYW5zX2QzX3N1c3BlbmQpOw0KPiANCj4gIGludCBpd2xfdHJhbnNf
ZDNfcmVzdW1lKHN0cnVjdCBpd2xfdHJhbnMgKnRyYW5zLCBib29sIHJlc2V0KSAgew0KPiArCWlu
dCBlcnI7DQo+ICsNCj4gIAltaWdodF9zbGVlcCgpOw0KPiANCj4gLQlyZXR1cm4gaXdsX3RyYW5z
X3BjaWVfZDNfcmVzdW1lKHRyYW5zLCByZXNldCk7DQo+ICsJZXJyID0gaXdsX3RyYW5zX3BjaWVf
ZDNfcmVzdW1lKHRyYW5zLCByZXNldCk7DQo+ICsNCj4gKwljbGVhcl9iaXQoU1RBVFVTX1NVU1BF
TkRFRCwgJnRyYW5zLT5zdGF0dXMpOw0KPiArDQo+ICsJcmV0dXJuIGVycjsNCj4gIH0NCj4gIElX
TF9FWFBPUlRfU1lNQk9MKGl3bF90cmFuc19kM19yZXN1bWUpOw0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvaXdsLXRyYW5zLmgNCj4gYi9kcml2
ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2l3bC10cmFucy5oDQo+IGluZGV4IGE1NTI2
NjlkYjZlMi4uYzRkMDZhMzIzZjliIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVz
cy9pbnRlbC9pd2x3aWZpL2l3bC10cmFucy5oDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L2ludGVsL2l3bHdpZmkvaXdsLXRyYW5zLmgNCj4gQEAgLTI5MCw2ICsyOTAsOCBAQCBzdGF0aWMg
aW5saW5lIHZvaWQgaXdsX2ZyZWVfcnhiKHN0cnVjdA0KPiBpd2xfcnhfY21kX2J1ZmZlciAqcikN
Cj4gICAqCXRoZSBmaXJtd2FyZSBzdGF0ZSB5ZXQNCj4gICAqIEBTVEFUVVNfVFJBTlNfUkVTRVRf
SU5fUFJPR1JFU1M6IHJlc2V0IGlzIHN0aWxsIGluIHByb2dyZXNzLCBkb24ndA0KPiAgICoJYXR0
ZW1wdCBhbm90aGVyIHJlc2V0IHlldA0KPiArICogQFNUQVRVU19TVVNQRU5ERUQ6IGRldmljZSBp
cyBzdXNwZW5kZWQsIGRvbid0IHNlbmQgY29tbWFuZHMgdGhhdA0KPiArICoJYXJlbid0IG1hcmtl
ZCBhY2NvcmRpbmdseQ0KPiAgICovDQo+ICBlbnVtIGl3bF90cmFuc19zdGF0dXMgew0KPiAgCVNU
QVRVU19TWU5DX0hDTURfQUNUSVZFLA0KPiBAQCAtMzAzLDYgKzMwNSw3IEBAIGVudW0gaXdsX3Ry
YW5zX3N0YXR1cyB7DQo+ICAJU1RBVFVTX0lOX1NXX1JFU0VULA0KPiAgCVNUQVRVU19SRVNFVF9Q
RU5ESU5HLA0KPiAgCVNUQVRVU19UUkFOU19SRVNFVF9JTl9QUk9HUkVTUywNCj4gKwlTVEFUVVNf
U1VTUEVOREVELA0KPiAgfTsNCj4gDQo+ICBzdGF0aWMgaW5saW5lIGludA0KPiAtLQ0KPiAyLjQ3
LjMNCg0KSGkgQ2hyaXMsIGNvdWxkIHlvdSBwbGVhc2UgcHJvdmlkZSB0aGUgZnVsbCBsb2c/DQoN
Ck1pcmkNCg==

