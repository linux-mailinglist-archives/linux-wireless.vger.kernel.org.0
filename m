Return-Path: <linux-wireless+bounces-19939-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F9DA5590E
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 22:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28CC93B304B
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 21:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB8C275601;
	Thu,  6 Mar 2025 21:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nf7m0WPw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26FB2045B9
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 21:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297601; cv=fail; b=O+m78RWp3rwaimrShH5x00d4jRkmVsakwKnanJk2k3PQkOKJx+LehJ7uFyvfO77aLupW4ljyaH/L0/wS3EQhhseFaC+UC1dL5QTOZU7Wyp5qHG/CuJUPiN4ojdRon734c5fzLfZMrg6MG96M5plqrCXetlp+ECLpSmIdU7qEgGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297601; c=relaxed/simple;
	bh=PFzV/IPk+jpo/oIpXRocDymhSoKPNjzHhYwoRG6tyV0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bUq3dIJJwtplnuKpAJVJy9gIuctyDG1U/mZ7sc1HQ2Vl1tzubAaa/6YnBbBOcYGWKy6GvIYNiC+mR3YQSoeXznxjHlpuk9iwc8v4iGGx2rrbRoWo+aIjPl+3/WKFzN1QSRfYp3D0OWWm32GRgfZzQCHIaOZ48lzjIX3IT+iXlaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nf7m0WPw; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741297599; x=1772833599;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PFzV/IPk+jpo/oIpXRocDymhSoKPNjzHhYwoRG6tyV0=;
  b=nf7m0WPwNUarEIcll9fBE5YXCaEal03L3tyRp66mTA2CDAQQplGkns+6
   GXTAMEx+e7j703mcEC8DRLeaPQE8vBZyyfpOb5CeyFGVDdU2s6eTy4bRX
   rKSNSGppA3DhZdfT9pdTldw2AkcSZdpvfLAsJ4VOUHxN57PlRFBZkOnwT
   EygMEf6QIcfUmop6nyPFVxwhE1t9PixmtKKQ//thG2JdT7zLcVe31+YQH
   8mphw8AI+BpNLZ9Z/DLmmjFpONgIbtQwfTLPGA7oAT5kM6hNmQvn2zutT
   SrtqFKpfTk07DblrOrW6UnvwfOXcH82gvduClPPE+wZ5vupeSyJDI0i+W
   w==;
X-CSE-ConnectionGUID: p+kdMUAiQhWiwvj5TRM/rg==
X-CSE-MsgGUID: ldP4UDTaQSSO4b2C83/mRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42472544"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="42472544"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 13:46:38 -0800
X-CSE-ConnectionGUID: tT7p2Tp+Sq+1JyopcrQoMw==
X-CSE-MsgGUID: H/UjJHOuRMuKAnc+yfrZTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119060489"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 13:46:38 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 6 Mar 2025 13:46:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 6 Mar 2025 13:46:37 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 13:46:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZJefG3traMlxYEup/YqVxdchqcplAc8fkmUm9lUrNId5Z5Sm8/ZFYVuudeFNfhWp9G7YiTeb19jznIVJ3tXEQmICzSmCMMYAxNU252kOYcCEM/QRO5gWBshSt52YWXL5taLuva7jtDoRSfos9Iru4sz/9QDh4UyRoTcUD0myfa42BijFnO6sJBrdcAG9AzmhtjSW4Q79WodOmFbZhcAO4ul/vIci8fKihhpLmdcXitp4zvMW522Axc2/EmOLz6MzwKHOTCcqMs5X5dzyi/o6xGswswQTlyuExZcWYwgGUTJV18oLfBYOaVAGZpLjf9Dpk18d2RLjAOaNKH+Ovk72Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFzV/IPk+jpo/oIpXRocDymhSoKPNjzHhYwoRG6tyV0=;
 b=VHhS36R3o15FjTmO4++iA308SdSBSF/yrSNfwHiEDRyxDBrxRco/kwncVGa7U/2Ud5aOrtOHwQAgGRaDjX2FQ9av4bKJIPV0IA6g0kzpOKJ0ZfL8o0ANnxsIZ4iCCUTBPNQV3CaAMOQJJa1vbGKlCAsa+LdLJcbfxcxhWh8Tyjopql4bF8AW5aTM40yToyNT/gUibcrcG2EKq1JwmAIjYNJ2+wa/hkweaPsAemIW/gbraZ5yZwtFHPpeSIlbGrgXcoe8+PJiUbQQP8UC+qmsjkoF27y8FcWB6345GOe/Qb6DCEhbv+Ch63jXQfTv3spyX8QZ4T8uuE+SXdBXUij+gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by SN7PR11MB8065.namprd11.prod.outlook.com (2603:10b6:806:2de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Thu, 6 Mar
 2025 21:46:34 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%7]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 21:46:33 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"Anjaneyulu, Pagadala Yesu" <pagadala.yesu.anjaneyulu@intel.com>,
	"Puttagangaiah, Somashekhar" <somashekhar.puttagangaiah@intel.com>
Subject: RE: [PATCH wireless-next 04/15] wifi: cfg80211: allow AP operations
 in 20 MHz configuration
Thread-Topic: [PATCH wireless-next 04/15] wifi: cfg80211: allow AP operations
 in 20 MHz configuration
Thread-Index: AQHbjoS7+rInExsb+0GdU/QofnMya7NmO2gAgABpmhA=
Date: Thu, 6 Mar 2025 21:46:33 +0000
Message-ID: <MW5PR11MB58107AED0D2EEBBE8000027BA3CA2@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <20250306104326.4105722-1-miriam.rachel.korenblit@intel.com>
 <20250306124057.a7b909d23df2.I8a8f79e1c9eb74936929463960ee2a324712fe51@changeid>
 <408de5a4-2948-45e9-a60e-81e2bb837331@oss.qualcomm.com>
In-Reply-To: <408de5a4-2948-45e9-a60e-81e2bb837331@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|SN7PR11MB8065:EE_
x-ms-office365-filtering-correlation-id: d7f39e87-034d-4752-d675-08dd5cf85cf8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZXlMRkMwUUdFR2xaV1d4OXRvaGwrQVg2Tmo2aHNuN0NXOHRJVEI5ei9zZjFQ?=
 =?utf-8?B?WW04YXFXQUVscHJCejJ1RWplVzROSHY0ZDBWSGtJRlJBM0R0amxoa1FxRWIx?=
 =?utf-8?B?L1pMRU5kZTMzVG1ZZ0NyVCt2clF6Y1gwYjU0SG1zU2hPdE5XMnd5d2xQUUtm?=
 =?utf-8?B?Y0w4NEFVK01UYk5HNnhtdVdvYzIzdUpWcS8xUStvMk52dUpaeC9wTFdZMlVZ?=
 =?utf-8?B?M1BTdkp0amY1SG5IZlNxZ3dFYlNoTEJSbVROYWtubzl1K2IvaDdTZGFSMzJV?=
 =?utf-8?B?QVBpNGxGR1ljV2ZrcG5VeGxTbDZvR3ZydkIrNGlPeS9QbnBZbnRvUGQrVjhq?=
 =?utf-8?B?Qi8xZFk4NUoySzZDYjFqUVJRK2Exa1hOWmJESjAxT2ZwM0lrbzR0YnhzZVhX?=
 =?utf-8?B?dGtVeHM4SGVKUXg4RWdZR2k2QlNnZDhHV29meTlQd0tsZ2UwV0RGVmkrUFZ6?=
 =?utf-8?B?b2ZsOHErenFOYnZPYWxVN1JCMU9Yb3AxTmFJcW4vZWJLejN4N3JoaTNFdXdl?=
 =?utf-8?B?NWo5WlJ1R201V3dTQ3ZpajNMOTk3dm1nRFNPWm44MmlkNmdSUE5aSjYwQmc3?=
 =?utf-8?B?OEt6aGlFODVOb0xRQnZ2WXNYd1pEeit5WjY0cXVuOG05MjdwS01pZk5QM3R3?=
 =?utf-8?B?cDBLMDlmVjV3ZUMyVUtTSDNlWWNXSmpFQXhaeWJ5REwzSTVoa1FLUHdNZGo4?=
 =?utf-8?B?Sjd1TzRUK1VHMEpHOCtBdnhtOHR1TDhQbXpTaDNaQ1pJaFQ1dUxuUk1pdVEr?=
 =?utf-8?B?K1JVTkwrK09IRjRjRjNsZ3ArbTF6bWZIQldmS0hDOFFmRWVTaXQ2cEFtc0RZ?=
 =?utf-8?B?QVkwNG1kUGZNajJiMm5obE9aRkZnSFFsOVRvYnBZamJjeHpUTm8rYUhEVVlX?=
 =?utf-8?B?dFZQUXkzV2l0d3RVSDY3U3E4U25pZEhGNFo0MGJYTk9jS2xTb0FpRDZScExU?=
 =?utf-8?B?bFAydUhOc2tmdTlZcW9WR0hhck5qUFNCR2lWd2lWSWhZQk90YWRrRVhXdTZ6?=
 =?utf-8?B?Nko2TmRBVzh1aWFMK0tHbXE0bUkyQW9vMG50YjVRaXVrR2UzZ0RYZEVsZ3Vo?=
 =?utf-8?B?c0VPc1dsOW9TN2UvVFgzN04vRjRPcUEwN1NNcjdEUnAzQ3A3NkRyamxYd0tK?=
 =?utf-8?B?ZDdsRWVGVUNyc0I1YUx5emlUQk9qU0ZVLzhvMDF0K3pZSS94N25adEdHa0tO?=
 =?utf-8?B?Qk95ZHdWcnJQYnpNeVVxVUlLLzhJbHh2ME1vRzJzTUJ0T2lDNmc3ZFdPMDVY?=
 =?utf-8?B?RW5sOFpudzlPNktpQkhnMDZhS3pNRUNLQnRpRGJtb1MzaXhVTWVzTXpvRGRS?=
 =?utf-8?B?QTVPaytGMC9QQ1FoNWpDQXdYSTUrRFNnaUVieHhKVWZUZkdHQTVnZnpQQW1p?=
 =?utf-8?B?MTJHWE1oYVdEcUFaekZlaXp3ZVpHME1nQ2VJYkZVK2VRT0VPa1psQTZSU2lP?=
 =?utf-8?B?UzlneGVwaUM5dmJxZm9YdHBCejIrRkwyQlBtSnpFM2x0ZHJQYm5JdU9Gd0RT?=
 =?utf-8?B?S0k4TXJxcU5lZlVMa05FVUY5YlpKS2duMjFwb3JwRjFqVUxpZ0dUeUxrZkEw?=
 =?utf-8?B?b3FZc1QrbEoyNVEyamtKK08wT21EUFhtMlIrZFdoU09rRWFrWWVFUE9MWWdu?=
 =?utf-8?B?TGdPb2ZVcWxYVjVscUgxM0l5Z0ZucU9DbVhQU2x0SDRaTGNEQmc0ZzIwQ3lr?=
 =?utf-8?B?VXMyTEZxZDJnaVVESG9QN2Vnd25EQ3NsODNSOVpZZ1BTRTc2b2tDaG4wcWVx?=
 =?utf-8?B?Z2l2a2FRdkZPTlFZOEl0bWN4cEZWTGhiM0xSbzkyQ0VRdDdqaEpHV0RLT3hu?=
 =?utf-8?B?K1poOUszSnpaZ3Irbjl0YnppQS9vc280bkZXbW14UkRoc0F2bk9Oa1FGaUVj?=
 =?utf-8?B?RXhvUlJ4Sm85U0VwZ3cvOFlVbjhyZG00ZG5VU3BoOHhyMUNtck5XcWcxNSt1?=
 =?utf-8?Q?m0OoKRBLiLC6GFmfEAYvP5bz16MS7Erl?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXBuVldYdzZEWmE4M2lTLzJqYk1PVEEwQmhNZnEzK3BEUzR1cDdaSXVHNGEy?=
 =?utf-8?B?RjN0Tk9teVJFMTM0RlA1cUtsVXlub0JJNWNzcEpWZDEydjdiZXdwUjNQSTZh?=
 =?utf-8?B?aHFPNUxNMHo5NnQ1a1IwWUhzenZyeUpndDZscGJFeHhlYlBweVdlRWxSYTBB?=
 =?utf-8?B?SW56L3VPWFpWNXFTNTZFMDg5TWphNWlZRWFJVExuaStRZHNpUmw5ZzRJN0g0?=
 =?utf-8?B?YnFFNTloUmtzempQOUhzMndNL21XWkZXMExsNHQ0WlBRclhmd0ZxRWFLUCtX?=
 =?utf-8?B?cnZYbmhEcGd2WElBS2wxMVFJd0hiTXl3K2VWR2RlMUV1T2Y0ZU9MSlpQemJs?=
 =?utf-8?B?dTlrRDdYTFU4VG5TUVlZWm1NbjN2WlBoTm1adVRIZkhUeGQ2Y2hpMlErZkxh?=
 =?utf-8?B?TmprS1lyWUNkb1VVbTRiWWtPQ0tMZ05DK1pOMEhnOWJaREM4MWxyRnUwd3Iy?=
 =?utf-8?B?R2pQVm1ud0FldU4zVW9xWFU2VnF5eEhMckZLaGRBWm9CK2xva0JlQlhPR0FT?=
 =?utf-8?B?YnYrbXFObXZSaU1OeWNrRlZSbEVNZDJLNHJZd2d6OGVqd2tCM2p6K1A0MHg2?=
 =?utf-8?B?ZW11RklOV1h5dElBREdNK2oxYmQ0NU5kZlpQQjVVZ2NidVhzWE9VNTYyS3Vo?=
 =?utf-8?B?WXNLcEtOK0Q2YXlBRUNTYUdpTVl0RzE1K2dKd0dFMUtHczd5cWpxRUNubFRX?=
 =?utf-8?B?YjYvbXhTZWdJc1RjYUV0Tk1rVTNvb2xGcDgvcTQ2RGxNUk1sc0JmajhIK1FO?=
 =?utf-8?B?TEJvU0FPa29HQk1IK3A2M09Sb1p3UkRjd1VIeURMUjFFMm1acFNDQ0o5WnF4?=
 =?utf-8?B?OE1RMU5IMGdFVG5IRkFOOUJsVU94S3hKbVlKeHVWS3UyVHJVZW13Rk5jRnd5?=
 =?utf-8?B?K3dXMGlBQ0dDSTM5ekpYRlRtVUdMNVRLU3BUYVh6emtMTTM1dDNHSnVyeUkw?=
 =?utf-8?B?VFMzWHNIVEVCMEU1NHpzL2pYQm1YUzlSdllFZ2ppQkl3YVVHVStPNk1CQkZ0?=
 =?utf-8?B?SVVmTWxKdUlBT1gyMmlPZkxib3RKdzdrWGMvZDRZZ2VUeUpNSlFYUkZFM0Z5?=
 =?utf-8?B?Ym1VZ041UEIwOWQ0ajNkekgxVmZwdHErVWh4WWNISjVkR0E0SGtqZGxyT3Ju?=
 =?utf-8?B?ODJOQzJWWXFzdGY0MXN1M1JxcXdwMk84VERjTDBicjN0d09NaEI0aG0xWUhk?=
 =?utf-8?B?Q1R3b1F6czBVSFNudmhaeDFXVUM4SzFFNXk2eUVPWE5oYmVYNXIvTEdxZ1Fs?=
 =?utf-8?B?eEJmN2JFR2FrbHkxQmp3SkNjbC9zS2o3Y1ZDRlIxNUVvRUlFUDhlbHI3SkFv?=
 =?utf-8?B?clViWTEwcWJHTGJwZG13NjFiQitaZ0RqUmV0QnJUbGxRRnRINjFvQmFlSkI3?=
 =?utf-8?B?ZkE3R1d5b1QxT05KL1FiclFSb2s1eEI0WEowZ2VnblMzUTJoTURlUWZ1SXRk?=
 =?utf-8?B?T2U4SU0vTnZNamcxU2VreEZqakgrZnRrRWFrRUMwaGE1QVJCaXVpR3hlZ1c2?=
 =?utf-8?B?aGZOZ2dnUmFwUTFkb1NyR2VlV2tubW9NTzdkMWpna1JPeEZaalpzbm93SW9I?=
 =?utf-8?B?d1YvOVBvbmV0Qkt5RGpYcXYzUXRrTXl5MXZWZVNnd1lUOTNBOGZHQzluVExn?=
 =?utf-8?B?L00xTWZlb0F4NmJEV09pN2NOKy9QVk1JaERyMzk2b2djRHVCUnNMR1l0c0Zk?=
 =?utf-8?B?ZGNjc2lIWmYzYnM4aGRxVFNCZzZpbWgvTk9PcEdsQmNLOVYwNHRQaXFPN3Fn?=
 =?utf-8?B?R1REUSsyL0prVW9BME5PRklXYWExMDk0SThITkJzOEo3Wm0rbzBJVlR1VVlR?=
 =?utf-8?B?VUl2aHlwciszN2N4MzhUVDZQWGJTaU9mVUlNUDF4SERJSFQ2RWdDa29URW1W?=
 =?utf-8?B?VmNSWkhXVkhWRlA1amw5SnJIbmxJNk4rQlEwTmZwNkV0cnJETlErT1Fib2Fl?=
 =?utf-8?B?MDJMc0dJUG9ML09STnI5ZVoyNFhCclZlOGpYSmlacGIrU1FVNzNEWUpQV3Fj?=
 =?utf-8?B?VW4rNDdJbmhITW1xL0ZVUk8zeEkxWXZsWkhncjBidVJCY2JxT29wT0NlNmNq?=
 =?utf-8?B?S3A1SGtsZlliQjRYV3N3ckU0akVDVkRubkhpV2ptUFZ3bVpEeHBLc2QvdDdM?=
 =?utf-8?B?SWVzMVFNQWJ5c3ZDRVEwSFZiQmZJRnVhTVBhdlYrdy9FNlRmOGg5a1BZRWtZ?=
 =?utf-8?B?bWc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f39e87-034d-4752-d675-08dd5cf85cf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 21:46:33.7409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gop6fVP0/L6RE3MPf+tUULenr4ivcZ+a72Xm6oaiWRtVGe//sewX+v3e4XOAs5ZpqUueM8YQh8HzoeqrxMqbzw3hhfSIflm9cATyy0fcsQTZdeDCJxfIKaxX/ODnb7lG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8065
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmVmZiBKb2huc29uIDxq
ZWZmLmpvaG5zb25Ab3NzLnF1YWxjb21tLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIDYgTWFyY2gg
MjAyNSAxNzoyNw0KPiBUbzogS29yZW5ibGl0LCBNaXJpYW0gUmFjaGVsIDxtaXJpYW0ucmFjaGVs
LmtvcmVuYmxpdEBpbnRlbC5jb20+Ow0KPiBqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0DQo+IENj
OiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IEFuamFuZXl1bHUsIFBhZ2FkYWxhIFll
c3UNCj4gPHBhZ2FkYWxhLnllc3UuYW5qYW5leXVsdUBpbnRlbC5jb20+OyBQdXR0YWdhbmdhaWFo
LCBTb21hc2hla2hhcg0KPiA8c29tYXNoZWtoYXIucHV0dGFnYW5nYWlhaEBpbnRlbC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggd2lyZWxlc3MtbmV4dCAwNC8xNV0gd2lmaTogY2ZnODAyMTE6
IGFsbG93IEFQIG9wZXJhdGlvbnMgaW4NCj4gMjAgTUh6IGNvbmZpZ3VyYXRpb24NCj4gDQo+ID4g
KwlOTDgwMjExX1JSRl9BTExPV182R0haX1ZMUF9BUCAgICAgICA9IDEgPDwgMjQsDQo+ID4gKwlO
TDgwMjExX1JSRl9BTExPV18yME1IWl9BQ1RJVklUWSAgICA9IDEgPDwgMjUsDQo+IA0KPiBpZiB5
b3UgYXJlIG1vZGlmeWluZywgd2h5IG5vdCB1c2UgQklUKCkNCj4gDQpJdCBpcyBhIGRpZmZlcmVu
dCBjaGFuZ2UuIFRoaXMgb25lIGlzIGp1c3QgZml4aW5nIGNvc21ldGljcy4NCg0K

