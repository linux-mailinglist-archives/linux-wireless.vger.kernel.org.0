Return-Path: <linux-wireless+bounces-23516-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7950CAC9CA6
	for <lists+linux-wireless@lfdr.de>; Sat, 31 May 2025 22:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF21189A56E
	for <lists+linux-wireless@lfdr.de>; Sat, 31 May 2025 20:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A96119E98C;
	Sat, 31 May 2025 20:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GQSDWM2U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EB119DF4C
	for <linux-wireless@vger.kernel.org>; Sat, 31 May 2025 20:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748722071; cv=fail; b=dasvfMfn/WBbfgalT+p/dOdCrSlo/fRhh/+G9TCl01UE/0q8/Dn4lOWO3xOUIwvTSLCAZY1PekKxeHZ2dAo8D2iyRhPShppGSJVJRQo0euVyESfR/uGue3b2oe6CKX42QAQBJSXuUnjkWV3JRplpsy/yMzla8OxKqdy3IIL7s0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748722071; c=relaxed/simple;
	bh=aSFHsZ9eOzmvTrOHhrprYk6nBriYk4M4biL5nW0rdzI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JYZ45cpkhVP2mOUI/hzmxyUjMKArBIHbUY4X/QgDbrZb/hIk2GbDU7e+dOJZYQ2FDVPXbTJoTnXn+g5ehU24PTE2VJI/pW/9t309MmgFFUhR+8DeMFpccws12QiBYiM4xADl3eSkzzQUmZv3IJAhYp/iTwMCkFdYV2bGakuv570=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GQSDWM2U; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748722070; x=1780258070;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=aSFHsZ9eOzmvTrOHhrprYk6nBriYk4M4biL5nW0rdzI=;
  b=GQSDWM2Usla0FhdhHfzJGFb94JmY0bJO09g6RSAs94zCqnLdLRQB1duF
   es0rAXxqkHIaBDNM5pSjQHof1kcNV5vTBf5VFMN58GUeucDxEQwuhzxAL
   lW/a5N30jom2gCmzhi92/mJR7jxztvBG98TU2UfUI7hJnVvBuPF5wxpD3
   aaIkF8QvGuymoR2NG77oNaw0Dy6pZP1bhsqda71wY7H4LZCdKVZ6ThZQD
   YdVB6lRkBPFtsG7m9V4zpohCRJCTBx8liGkv+daJbgf+oqgdbhyHBs1ss
   vVyZiCx9H1rHYWJf0nk2CjWuIXZMI+II627hYVxWZ0l/LFHX4hCkapEO+
   A==;
X-CSE-ConnectionGUID: 7/Jsys54Ryyv0jjb7rKTOQ==
X-CSE-MsgGUID: UDdSjikvQfmhx0gKheLoJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11450"; a="54585080"
X-IronPort-AV: E=Sophos;i="6.16,199,1744095600"; 
   d="scan'208,223";a="54585080"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2025 13:07:50 -0700
X-CSE-ConnectionGUID: cggtNrcjRfy+gpj/ZWGsVw==
X-CSE-MsgGUID: UcoHnR3rQb6IShT3E38Rjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,199,1744095600"; 
   d="scan'208,223";a="144819417"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2025 13:07:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 31 May 2025 13:07:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sat, 31 May 2025 13:07:49 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.71)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Sat, 31 May 2025 13:07:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eEUICCxpcbbx1BuaDDanUZkymikePF+fadnPfJv0NIky7FDhaCyluAInxiHKW0gGs++HED5BikaymRKVNLevwdkMIHaW0EMcnDAX2Ypg8IcKBrwweZZwfnqV54KteFqyhC3F3gnFhY1hFxhmak5n7YG+Nh6IWtVYs2IICcYnhiTpTjNfiklgt2oSzGloir4otn9zGr0shZITBkH94tAJnARmfPxI96O3b8t286bi2GMZZfDgAjSo9tSlpOQtfpVP+4JM9nFMqo7Bab7weoqyZlmDkILqeGOLaU0Qv6FuUM596hkLm4hNUTpCuZTBdQVRQtc7I4FKl7B9GeOX67MtDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySeki3ZFEmlZks+CH3FQnHIKqF1MctsCi6C+J9lNdvE=;
 b=IgZUFUN7Lgt6VIwd3G72ktiG4+FGRs+6MqSt6pzQ2Mz4Yj2LTElrPyTH2Y7xxnAcKyzwo+wPvWNxwVPYvKvb2PNZgFdWIgDX1WlDR96pfu1Hutq3zrYD4BeHBOiSpRMvVc+uoKE1pWvVE0kdx3bjbXFqwt8D1qreaPeNx/KWWqCqxVCBg/q+KvzjZVwDavWw5kGSn7u6IyQt5LsS39aoLE4V4BGcOTAAkmUUC6TXlGiBiTZ69y0c5758o9Y8HFpoMs5wBh9nflxNWLSXOHGcwTNTB7Igs74MRuRgldghPiz/fHW0zVIoyYSPSMYqeomEoroDN1TR2kl/EUhxpVTaGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by SA0PR11MB7160.namprd11.prod.outlook.com
 (2603:10b6:806:24b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Sat, 31 May
 2025 20:07:32 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::9ce0:77f1:dff6:ada1]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::9ce0:77f1:dff6:ada1%4]) with mapi id 15.20.8769.025; Sat, 31 May 2025
 20:07:32 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Chris Bainbridge <chris.bainbridge@gmail.com>
CC: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "Berg, Johannes"
	<johannes.berg@intel.com>, "benjamin@sipsolutions.net"
	<benjamin@sipsolutions.net>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>
Subject: RE: [REGRESSION] iwlwifi: suspend failure, bisected
Thread-Topic: [REGRESSION] iwlwifi: suspend failure, bisected
Thread-Index: AQHb0jWtZlonm2bevkK4NgXOOQj2aLPtEEIAgAAVOICAAASocA==
Date: Sat, 31 May 2025 20:07:31 +0000
Message-ID: <DM3PPF63A6024A9ECC64ACBA27CCABBAB0FA360A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <aDsNn70jcX6sDLLT@debian.local>
 <DM3PPF63A6024A9CDCDCB068431DD5249FBA360A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <aDtc_1OIwh0DH4Kw@debian.local>
In-Reply-To: <aDtc_1OIwh0DH4Kw@debian.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|SA0PR11MB7160:EE_
x-ms-office365-filtering-correlation-id: 5678e0a8-2cad-4d4d-c355-08dda07ec6ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|4053099003;
x-microsoft-antispam-message-info: =?utf-8?B?K04vWUR4NDNoV3BYSjFSK1g3a2Nid2hkZ1dsUjNnbFpHQUlFN3FoKzFzMkZJ?=
 =?utf-8?B?R1V1QnJHTHFldkN6Mjk3TlA4d2hycGxXNk1tWlRPN0x3dGpkUCszWXhYUUU2?=
 =?utf-8?B?bVFFVldXbWNQMm9yNTJObWtFdlJoc2JDMm9LNDc3cDdQYVVmUDJpeXVtZ1NW?=
 =?utf-8?B?ZUQ3YmxvV055MEFNOFBwZUY1WFpZaTBhSzgyVS8zNFc3MitTVEZtZWcrVEpn?=
 =?utf-8?B?WXBVeU9xNVVJZ2M5R1AyZU0vK3Y0dnZjaFN2MFA0OEhyWGxvNGhNYjN5azRC?=
 =?utf-8?B?aFkrcnFoU0h0d3hOdkFHN1liZTVvNnZublJodk8wR1lDSzZvZlRtbStJaS96?=
 =?utf-8?B?RFpEREt1aDJ5ekVxNysyczRTWDVKemJ3bkt1cHZrRk0xYzE1UWdteS84WU1h?=
 =?utf-8?B?NWF4emhzKzVsWjNqaEJ3Y005VDNCaEhRdDVNNklrZUdEMk16RW5VenR5STZC?=
 =?utf-8?B?YnZ6ZXlpRFdDUnNaNGJ0NVhGdGdWVzZtcXBGV2xaZ09ZTFlrbEdaMzA2ZzhO?=
 =?utf-8?B?WHNrcmFqOTh6ZUE1L0hOUEQwYVk3NjlIRldaejYxNTZQQTRPRzZOcFZ0ZXBw?=
 =?utf-8?B?cVVvMk8xeFJlV29SSDdDN29ITG9RVEZHUTZvdDFMOEVHYTFFNWFRTlZBSmlY?=
 =?utf-8?B?OG00Y3ZaRCtjN2w3UGZOOXJjRXlyZXNCU1lHUXJsZEZDYnJvd2U5cGFMaUh4?=
 =?utf-8?B?TFdjM05RdjBkZmRtMFlUb3BJanB4THpzbC9pWkt6Mm1Lb24rZzJkUE42ZU44?=
 =?utf-8?B?MVdhQzU4blR1UDlUcUxzN0FySFlXZmIrV1BrSmZPMGVYZTdkRG5WbStmKytG?=
 =?utf-8?B?d0ZWbVpKdG4veGswZG4raDVEcUdhVnZFN0RCdUNpaGZyU0FCZFFuVGpsMzZX?=
 =?utf-8?B?ekZpbEd4TzZBL01naHVvZzFYVU41WDlob0doM2xaMWtMc1NoVGZtNTlGVmt0?=
 =?utf-8?B?UEFZZW5jVHUvSittZ20wd1lvL2xEdHFoNStmRkhISGZCMmNqR3JBN0FXSVU4?=
 =?utf-8?B?R3k5bklsaGU3NWgvSnVpa1BIU1lqSE5HbGp6QzZPYUNyZmNWWk9MZ2tEU2Yv?=
 =?utf-8?B?QXBHTTFzUm8vTE5hU3VMb3lDbmF1MGJnbXBHZ2gxU3p6R0xsVDU0Q1V0RGVn?=
 =?utf-8?B?RzVxNUppK0wrU0dpSG1oVjh1YVpBZWdma0xUcndWYW1zRmhzUEJnN0lmK0xY?=
 =?utf-8?B?ZXdNeU9RS1VXSWdQRnprbVkyOXV2MGM2cWxrSERWSHdLbmpRck1Cdk5rMitS?=
 =?utf-8?B?RE92bVZvM3pBaWNYREQ3N3dRbm5RK0tWSUo0bW1ONk1oaTk3UFNSV05ZRlhp?=
 =?utf-8?B?YlNaZDNERXVpaDFmV3hQOUprTktOYkRVYnQ5TnJPTEtXSVlndnBlMVZXamF5?=
 =?utf-8?B?RG01Y0E1M0YzQmRnN3lzaHhVSERmT0RvRXBIVDkyOG81T28zRE9remU2SHI0?=
 =?utf-8?B?RnExNWVCaThibTA4TTlydkh3NlR3azF3SGRGM3dvUEVoZWlVZDBQYnFsVWVy?=
 =?utf-8?B?NDhqYnJEQ0YwZXNTZE5vSGdXck15Y1pqMkpoTzFvdkJ5SEFZbExXeU9qb29j?=
 =?utf-8?B?MFFUQ3RwRkVjcG0xOHZEai9NeG0wTWllYnRTOTh0V0xCS2wyZnBaME43aGJq?=
 =?utf-8?B?MkMyVHg5blF0ZGsvR3NqY3RVVDAxZDh3eUFMOWxuam5ydmtiSVhtRTkxRmlD?=
 =?utf-8?B?SFpQWUZGamlROHZHc2svajAzNnV0aytNV1hGbjdNeXJBZUVIMnplaG8xaDdm?=
 =?utf-8?B?OENidDRvQ1N3MFRyM0JJUXMyU1VQa3RHUXh2WktYSVJRMWFUZ2NDMjFHZGlE?=
 =?utf-8?B?aWwrd0VtLzVaQnMzZHk3NDI3OWVLRjg4bWFGdkNMRlR0SGxMWjhKazFyNUtt?=
 =?utf-8?B?bGFCbUVUSHAva2xRblFmL0x2aUxMN3hxemRzK2ZvN3FHUzFLRk1ZNkNabXg5?=
 =?utf-8?B?bm5udklqSnkrMk0wN2Z3cjlTc0FldVhsa2NMb01WemQzcXRUNU1YVXRCemZk?=
 =?utf-8?Q?fdtVf2UZsIIAGKU/XAaHRLi4nNwgXw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1ptdkV4a2NSSWlPeHQ4aENvY1cvNHpEWW95VVNFS3lkcVhFbVRQWWR4aGd4?=
 =?utf-8?B?dk5FV1R3bklFdjNLYkxXbzJ4ak1ObzFzYlNKWWpnRVp0MHkyOGRTSEhZSkNK?=
 =?utf-8?B?cVdHUnlNd1RHRE05OGZVVXVDSGdLNDZqSzVpemlDNS9EZWVldjZtbFg3Zkp6?=
 =?utf-8?B?SVVMSU9JdXZxZ1pRWUN2amxHdTBIVkwvVlZOejBmRjFkZnVHTnlWcU5FT0t6?=
 =?utf-8?B?OEhSUmRzUnFFejR0OEFnRVVqTjMxdkZ0bEI0cVUrSGlIWGhudkcyS1cyYmRy?=
 =?utf-8?B?NXpSN0k5S21reThNQkpiWDdnU0Y3N29leWw5SGcyUEh6WitTUHo5R3dTOUJF?=
 =?utf-8?B?aCtpbHRic3p3SlZBV0p0Zmp4cWlsT3J6Mk0xZ1RNTTltUEV4cW5GMnViekI4?=
 =?utf-8?B?KzB2ZWJIY3NmQ29oRUtMNWZLSWFpeEt3d00zSTdzOGVSaEU0K0dtL25uREhk?=
 =?utf-8?B?aXRBdnpFUUdKd0drNWVna0xsckJXOVdJcXZ3RGtaUFdpQzJNbHpISE50VzE0?=
 =?utf-8?B?RHgvamNmOTFiTGVrSFFiNnVZdWJTd3E3clViOE0xcGdjUXM3RVRld2IxTWNS?=
 =?utf-8?B?Z05zbnB2RVZJMHpscTFxNkE5Y1ZKWGFLem9nR1hEd0FNU1Rsdk1TVlhvalc2?=
 =?utf-8?B?dllQMzZ0YWhBbjh4clVKUEI4M1JCdlhWaUpWV2hMM0tUeFFCQjRYYkI3SWhn?=
 =?utf-8?B?THJuZCt6Znd5a0JCU3FzcWdnSXFydCtSUDJjZEF2RXFacGRQaDIza2Y4VmNZ?=
 =?utf-8?B?dXIwODhqUjNRSGpSeHBoZjFoaEpzbFdtWXBic1RTN1JlN0lGZDF2NVdNMUNv?=
 =?utf-8?B?dUpRMk5CcDBZL2dxNUIreFMxcGdiWnZSeGRyUzh4R3U0SGhFREFqU1RPaEND?=
 =?utf-8?B?QnJwc1orb3BOajQyU3NCS0VZclZsNWJ3QS9IM3RWRjFHT0V1OGdJTTFodHQx?=
 =?utf-8?B?Y09hbXVGcEtTdTQvZVZ3RVZaN0pBVkppVGZyQ3gxL0RkcEl6LzZpa3d3Vm1B?=
 =?utf-8?B?ekYwWHd0eE9YOFhHRWNhMEJQQXFEUS9IYU0wNlk4VFZVQXRnK1lvT1VsK3hI?=
 =?utf-8?B?T0loOWl3TVBxR05HVW0vK3dPOVFqUndPZ3Nnd0todjZnU1hqVlBXWklmT2xP?=
 =?utf-8?B?cU4vNGtBMGxuUUUwb0x2NTc5RzZXdlcycnZsWGVrWjVHZzdjQ2JDQ1JZODZR?=
 =?utf-8?B?OHhERmdrb25Bd1h1YXZVVXpBc2lsSzFXbFFweHFkeTd0NWRORU5vTVM2MWFD?=
 =?utf-8?B?dFVENEduVmNQT2tFRXEva1VLYmwvb3N6enE3MHArTVJUcEJsbEdsZ084ZVBT?=
 =?utf-8?B?MFcrT24yOENtZW1DREw2T1J3L0w3STUyOGdIMUlqbmdEaXpnOXFhdUkxaDlu?=
 =?utf-8?B?enNWUzdoVENaTGJKS2NCWFFhOEdZRWp5RWs0d25YZkZIN1FaNVE5YXdNRjA4?=
 =?utf-8?B?RUtBRmF6MFlGNnJjSGFUdkxFSUhLT0ZqK0tuSFFjci9LdlFRTk1oTTVtbE1y?=
 =?utf-8?B?M080anh4VFhBUFE4QWIrcUFKMjJhbml0R3NiMlBOQ2R0ZVhEcHFoZUtDSzh3?=
 =?utf-8?B?eHB0bTBGOTA0QXU1OGsyWTFPZWZUV201YndxU01IT28wNXIyUmJRZ3pybXBZ?=
 =?utf-8?B?Tm9hdUhzczVJK01hdzFNSWhyOCtGZmVzdTJzVExPenA2RUgxQUJmS2dtS0J2?=
 =?utf-8?B?bzRpVnlRYkVWRVhOcjdMZDNMbnlVVmd2M3ZaNXRNd05iTUM5dGh4RUE5R1p2?=
 =?utf-8?B?RjN4M0hCNFlBWjBXZFhMeFIyWUozdFBjaDZlK2ttWTJkY2pyVUJJQWdnYmhO?=
 =?utf-8?B?dVZsT0pxQ2RpbUgxbTZXajlwSEVjMzA0V2tsaUJsNXFlMmFVUTlNbzJWSzEr?=
 =?utf-8?B?MU9QS0JKdkFwMFlZMExtM1hQeXFac2V3clFFa3M3bU9hbXJDQVBNVXMrK3NF?=
 =?utf-8?B?U05xNG92a2UxTWNnREFscHc0R1NNYXJnSUhGTm1QN3hSVm1PT0xLbzVtdUVC?=
 =?utf-8?B?R2w4anVvRnRsNWxHR0dGL2c1MEE2UXNPcC90VGlTdlUwM0JkSmRsamNacTdG?=
 =?utf-8?B?NmZqMU5FMEFBbSsyU1hHMTRvNW1HVGc0VXBVbHRUYnVraElPWnUvM04vbGlB?=
 =?utf-8?B?NnFob0RBbTF6OUdaWVgxS1lnOG5ta2s2bUpQVFJWTHF1Ukw4ZmRvbFVOMCtM?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: multipart/mixed;
	boundary="_002_DM3PPF63A6024A9ECC64ACBA27CCABBAB0FA360ADM3PPF63A6024A9_"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5678e0a8-2cad-4d4d-c355-08dda07ec6ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2025 20:07:32.0038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C15GZLW2sRGGboxvqmQqRrq8KoxEVczHWRinEnUoEVpboT2M1TQSBEACL3RJ5Fy/lCZfLitGuEqHZ+pZNiOJddAj3Jw1gz8EVXM81wWy4GcCNiXpSQpcTPF4eGK8rK/b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7160
X-OriginatorOrg: intel.com

--_002_DM3PPF63A6024A9ECC64ACBA27CCABBAB0FA360ADM3PPF63A6024A9_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiANCj4gSXQgZG9lc24ndCBsb29rIGxpa2UgaXQgbWFkZSBhIGRpZmZlcmVuY2U6DQpJdCBhY3R1
YWxseSBkaWQsIHRoYXQncyBhIGRpZmZlcmVudCBhc3NlcnQg8J+Yig0KDQpQbGVhc2UgdHJ5IHRo
ZSBuZXcgdmVyc2lvbiBvZiB0aGUgcGF0Y2guDQoNCg==

--_002_DM3PPF63A6024A9ECC64ACBA27CCABBAB0FA360ADM3PPF63A6024A9_
Content-Type: application/octet-stream;
	name="0001-wifi-iwlwifi-mvm-fix-assert-on-suspend.patch"
Content-Description: 0001-wifi-iwlwifi-mvm-fix-assert-on-suspend.patch
Content-Disposition: attachment;
	filename="0001-wifi-iwlwifi-mvm-fix-assert-on-suspend.patch"; size=1339;
	creation-date="Sat, 31 May 2025 20:06:11 GMT";
	modification-date="Sat, 31 May 2025 20:07:31 GMT"
Content-Transfer-Encoding: base64

RnJvbSA3MDg3ZTNkYjNiZjRkMmY3MzQ3NmU5ZDBiZmQ0MjVkYjUyZTAwOGFlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNaXJpIEtvcmVuYmxpdCA8bWlyaWFtLnJhY2hlbC5rb3JlbmJs
aXRAaW50ZWwuY29tPgpEYXRlOiBTYXQsIDMxIE1heSAyMDI1IDIxOjI3OjM5ICswMzAwClN1Ympl
Y3Q6IFtQQVRDSF0gd2lmaTogaXdsd2lmaTogbXZtOiBmaXggYXNzZXJ0IG9uIHN1c3BlbmQKT3Jn
YW5pemF0aW9uOiBJbnRlbCBJc3JhZWwgKDc0KSBMaW1pdGVkCgpBZnRlciB1c2luZyBERUZJTkVf
UkFXX0ZMRVgsIGNtZCBpcyBhIHBvaW50ZXIgdG8gaXdsX3J4cV9zeW5jX2NtZCwgd2hlcmUKdGhl
IHNpemUgc2hvdWxkIGJlIHNpemVvZihzdHJ1Y3QgaXdsX3J4cV9zeW5jX2NtZCkgKyBzaXpvZihz
dHJ1Y3QKaXdsX212bV9pbnRlcm5hbF9yeHFfbm90aWYpLiBGaXggdGhpcy4KClNpZ25lZC1vZmYt
Ynk6IE1pcmkgS29yZW5ibGl0IDxtaXJpYW0ucmFjaGVsLmtvcmVuYmxpdEBpbnRlbC5jb20+Ci0t
LQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vbWFjODAyMTEuYyB8IDQg
KystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tYWM4MDIx
MS5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vbWFjODAyMTEuYwpp
bmRleCBmOTlkYzg2MjRiZDEuLmU4NjBlZWE3N2NiNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQv
d2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vbWFjODAyMTEuYworKysgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tYWM4MDIxMS5jCkBAIC02MzYxLDggKzYzNjEsOCBA
QCB2b2lkIGl3bF9tdm1fc3luY19yeF9xdWV1ZXNfaW50ZXJuYWwoc3RydWN0IGl3bF9tdm0gKm12
bSwKIAkJCShzdHJ1Y3QgaXdsX212bV9pbnRlcm5hbF9yeHFfbm90aWYgKiljbWQtPnBheWxvYWQ7
CiAJc3RydWN0IGl3bF9ob3N0X2NtZCBoY21kID0gewogCQkuaWQgPSBXSURFX0lEKERBVEFfUEFU
SF9HUk9VUCwgVFJJR0dFUl9SWF9RVUVVRVNfTk9USUZfQ01EKSwKLQkJLmRhdGFbMF0gPSAmY21k
LAotCQkubGVuWzBdID0gc2l6ZW9mKGNtZCksCisJCS5kYXRhWzBdID0gY21kLAorCQkubGVuWzBd
ID0gc2l6ZW9mKCpjbWQpICsgc2l6ZW9mKCpub3RpZiksCiAJCS5kYXRhWzFdID0gZGF0YSwKIAkJ
LmxlblsxXSA9IHNpemUsCiAJCS5mbGFncyA9IENNRF9TRU5EX0lOX1JGS0lMTCB8IChzeW5jID8g
MCA6IENNRF9BU1lOQyksCi0tIAoyLjM0LjEKCg==

--_002_DM3PPF63A6024A9ECC64ACBA27CCABBAB0FA360ADM3PPF63A6024A9_--

