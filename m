Return-Path: <linux-wireless+bounces-24944-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3815AFCB65
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 15:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BC2D7A2ED6
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 13:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02972DC35E;
	Tue,  8 Jul 2025 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ic7N5zsn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4D926B08F
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 13:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980036; cv=fail; b=eGPm4zuJ0QaiAv4tYCNo2Kao8ynJSvZ9jPEm2k7rA3ZIGDV3g3oScRLbvHGVyOBjulEpqFA9+0GHC8F+caKNNP5DhQwPhRRTLRqv/WqQ6VmrwLuWYcozux0brVfJ1/sS78LXHXY4gtzAidILYNLYXDZpOUwCz+ngJvqRPvIUzCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980036; c=relaxed/simple;
	bh=UJpliqHHD9dG7y06kXf9sn6jsHQz20pfligXpI5DTl0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lghKDN6Pr+gbUFB+Tb1Nv1Q9J9v+cz2so+IqILwAJeOdBHG+Hdv50d/xasPCHorP9x82T89i7bmRjCy29WTgz6XjOSh6hpoiEzGdQQ7kB3L9m6F1ZHJwhJleRCkKplJgf8FC3ji6OkzwIWOiBIulPUcb5yywEhruXAIbyFO4HFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ic7N5zsn; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751980035; x=1783516035;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UJpliqHHD9dG7y06kXf9sn6jsHQz20pfligXpI5DTl0=;
  b=ic7N5zsnm9BAIbGfj8lgWvdxTX2b4GXZ+rer7Gl6U1N3R4EYhUI8LuSo
   g/DZKnuP4/bWphpxg/eGaSlWVuM7oGV/KCNIJc5jtBpw6xsUiUmCFM/4T
   TqKHz76G6zSvxLAJH9Vfk8K+S4nA967PaTHvCyMIaz/5Oet7xo2XlyO47
   aLpWKl2BfB6FYCj1NCNgsPx1+l785UHlbrm0P8M50KYtzsZmHgCXzmNRd
   df+rVD4HblUkWsaOu6RH6wcDBTA/VAMNyVLORIEI4OXs2ctsWA9AlmCmz
   QyIqTY8TCxiuZZP5bbc8X8UkmN1VxYH2Fdfrv5i1y72ZJWLZPI2eclbWx
   w==;
X-CSE-ConnectionGUID: 3xHcFvcQRQOIop/2Wwx4vA==
X-CSE-MsgGUID: cNFV/tKLT2OKsV0wezeEAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="56828956"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="56828956"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 06:07:14 -0700
X-CSE-ConnectionGUID: ruNBcaLSQh206vqDttJDiw==
X-CSE-MsgGUID: jYpSUeyMQQiALtMQ52xyZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="155112717"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 06:07:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 06:07:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 06:07:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.52)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 06:07:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5+y/N09A5Y9Wq2vMR8Nsl3cIxStmKS2j+xwJ+GG6CvzghHrPmrIdc/4FwgRvDxaMsV7I0OE+YqsciDu/mj/FJ5sECPz6Xd+l3nsIWTtRVRYOOIYUHcwMv3wFPxF/TekZvsp/NgCQkQAOefh+fKkiB2T4Q2IRfn/MJMXnXJHxon41X6XokgKjkWJOJEabvDVn0HLsSzpO/SxKBHfrh/blNUDsNe/LQpxo6ICiPoPSU4UYsXfSEn/NxuN7yAqbrKEIlSXp4bUWiu9GRyH1ajg41fQz2G4YnFFd8iCPE1KU6E+fDh6VX0P0IfoeLPXLr08xtZl9YoVxpWrfkw4BSA/jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJpliqHHD9dG7y06kXf9sn6jsHQz20pfligXpI5DTl0=;
 b=KCMgZzbveWp7Dld13mHfO/dtzYuwi5K8PInDukw+jWoamvcV0VEqrbK4CQ150AD9Z4ZIvR9K8ZlSrxXGNdMyvbEVU0bzJ70WS4VoKTdvOzwLq0xxH19zKFZ9yxvq61zahUIlMEe1xou5m+FfLQ9UTjZiFAXweWVqsRaf18skJFgYWOJ8ZaXfzf2J4+3t/FVgggBo1Ir6VN+344WH+6b48NysL0XBrandKzqgBYesvYZcWAxAFWy35wG4swKze0OgVR1unDD+zjTsKQIm1g94ayN6yshDjNl0CP+1gtNHNiuzVcMKegBVlX4d0mEv9E8Ay+txgWoH7jXUeUACNRm13g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6252.namprd11.prod.outlook.com (2603:10b6:a03:457::21)
 by IA4PR11MB9418.namprd11.prod.outlook.com (2603:10b6:208:56f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 13:06:41 +0000
Received: from SJ1PR11MB6252.namprd11.prod.outlook.com
 ([fe80::9dc9:52bf:6024:cd95]) by SJ1PR11MB6252.namprd11.prod.outlook.com
 ([fe80::9dc9:52bf:6024:cd95%6]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 13:06:40 +0000
From: "Otcheretianski, Andrei" <andrei.otcheretianski@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [RFC 2/5] wifi: nl80211: Add more NAN capabilities
Thread-Topic: [RFC 2/5] wifi: nl80211: Add more NAN capabilities
Thread-Index: AQHb48SerkPaO9aaN0CO9YgNtFbTgLQVan+ggBLe70A=
Date: Tue, 8 Jul 2025 13:06:40 +0000
Message-ID: <SJ1PR11MB625258081C247C11CE24E517F54EA@SJ1PR11MB6252.namprd11.prod.outlook.com>
References: <20250622222444.356435-1-andrei.otcheretianski@intel.com>
	 <20250622222444.356435-3-andrei.otcheretianski@intel.com>
	 (sfid-20250623_002842_027258_89DFA3E1)
 <7e465c62d96c872e1f75a35d4f3d1f058d237cfc.camel@sipsolutions.net>
In-Reply-To: <7e465c62d96c872e1f75a35d4f3d1f058d237cfc.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6252:EE_|IA4PR11MB9418:EE_
x-ms-office365-filtering-correlation-id: a6a92817-35a7-4c61-0854-08ddbe2047c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cHorQjJaY0k0WmIvMXFxMSs2RmNEZFgzWDhuUGNUVnZHcTQ0SWFycko2dzZq?=
 =?utf-8?B?ZlJTaTVDNHp2RVhhTGZEVVpjMEx2OG4xZ2RLeUtBWkovOHJuZDVDaUE0aTNz?=
 =?utf-8?B?cWcvMFB2c0t5TW9ZRUd0ZG81Z1NlWjU2SFNyejdVVk44ZzZDR3lUbWl6cVBh?=
 =?utf-8?B?VEtFN2IwUHRSUjFyaTB3SkVIY3U4OXkyc2ZVRDNKenVyRVcvbjNFaUdGVWxK?=
 =?utf-8?B?bWpVemxtZ3NoMHkwTGFMS2lFWUQ2UVB5YUhGeU5OTXdzNnQyMStSMGZtVFBG?=
 =?utf-8?B?cmRsMGFBYmFEdXJoTG1hODlPY0ZNNWFmTjltbkZOeDRQR01LNzFZNXdLVnZs?=
 =?utf-8?B?TGVqblB6SlFQUzZMc0lSNFY2NVBKeURrUUE3eGxCcEx3ODV1ZHJqblNLcE1G?=
 =?utf-8?B?b2VGaDhSbFhRb3NRbEw5RllsOVJZeVRZTkFiR1RVdFBOYms3OFVoTUxWeGlW?=
 =?utf-8?B?bDdGZk1WdW14M21PdkcyZDZDQUhidmNtV24zUWJiL2xjbTZpSWtoNFFvMFpt?=
 =?utf-8?B?MEJYdDJzNHRObWtYSnBic2NGTmRMMWtjQnBYK0I5TkZLbDFvbmQrWlBTRWc1?=
 =?utf-8?B?UzFrTncxQ0puTU11bnhjTlZ4eXVaZTNkYjY4Nm5wV0hqb2gySFFLVFZoSC9Z?=
 =?utf-8?B?ZjZOZVlFcGdOUENuV01DT01seFRpMVV6N0tpRzFzNVgwWHlFS04zbXMxYklv?=
 =?utf-8?B?U3VVUUFrbmxKVVlWVXEvdTUvZTJwMlZCQnc1YlpqQW9odzdDR1pHZWh2emdT?=
 =?utf-8?B?MzJZWm5NYWl2NHhiZnBGNTZ5WmFrU3paSmNQRHc4aXVMaUlCQ0xWSDFqeHNB?=
 =?utf-8?B?a0E3VUdDVGhERjBBREJIQm05QnpzcHNqREpYMWdCcHdjMUVUQ2ZleUtoa2J5?=
 =?utf-8?B?ZzBtdkNKMHAycG5RYTBDdnFVNVVzWGJ0TElobGk4VUNuQ2UzdkZubDR2aHIz?=
 =?utf-8?B?cmxZbkNWaURQVnIyNXhYRm1WaXdmdm1PK1BGYUQzNFM0R3VOMERDemJJakFx?=
 =?utf-8?B?Qk44RmVaamtUOGRNZmFjUWFmN3hVQkliYWM4L3lySTIzNDdLbU5KUmVmRU5G?=
 =?utf-8?B?M2NpMWZJT3E4b0JTNW1QK3REMy9wcFgzSDRGRld4cE4yTTJ0TlNHcVI1ZHhh?=
 =?utf-8?B?d2R2b00zMFV5RjVjalFBVlhzdGxhSkhZb0RSNTk3aXRuclRHaitCUm90eXdB?=
 =?utf-8?B?SThHRVk5T1BoWFY3cUpsdG5KTTR5UDhNVXd3LzZUVjBCVjB3amdoQmdjQ0Jl?=
 =?utf-8?B?Zi8ySUdHV3FaNHBOL2cyMlQwQ2RLRm54bWtEZXRoZVdrWWFIVGZYZ0JUT0lP?=
 =?utf-8?B?NHdyWFdTNXQ0TWtPODczY25UT2o5NUtPUVdHUlpoYWpKSmEvMGRSMFRnNHZw?=
 =?utf-8?B?ZzAxUlFHcFFYNmowRE5VSE4yT2pzVUsrSGUrelVhcHRQRUM2RGxkcVppS04z?=
 =?utf-8?B?dVFySnM3SlZud2NKdzZkUGdSRGtrNG0xU3VZNzFPWWxuTlR3dVNDcklDNmJz?=
 =?utf-8?B?VFNOQlBrSzZJVnA5c0xvdDd0N043WGVJOG85a2tOSFM5WFB1MzlSZ2c2SWJy?=
 =?utf-8?B?Y0FBb2NSZExjcnZES3dQRE5Eank5cU9QdElTNjk4TlNFSlgrQ0V2VWdTeVNo?=
 =?utf-8?B?R1BHM2I4OVdYTjl4RDhxamtoc3p4L2pwTjVtd3R1MWFxbDB5N21OSDRpSldF?=
 =?utf-8?B?NEd6QXI2eUlJd3pVV01udEo3VDUrZXovdmtLdkR1QmhMdk9GVVgzT2pqQlky?=
 =?utf-8?B?dUdHMk1LZzBaQTFoYXEwdlBrallvczhOdkpUNEhoUGhwY3lZa094S1B1d1M2?=
 =?utf-8?B?WHdsZzhwbU40M3dnYlFEdVRyekFkTHRFclRCamVSZk1oc3hsd0NmODdqY0E1?=
 =?utf-8?B?dE00K1NzMDZDL1R0TlNadnhWaFlYbU9JVGRUalhIbkpibnAzMzJpT3hJSFo2?=
 =?utf-8?B?NmdleitLRkJFSWpvNGEzN2NhTDVNZmt0d2tzaUozK05EdzlBbjBBb1JjUlhK?=
 =?utf-8?B?dzBmbEQ5eEd3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6252.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjNteUtNalZhdUphdVU4MjlMKzVmRW5DVC9CakNvRWEyVEh3UUk2eW5mVmhZ?=
 =?utf-8?B?M1RyMkdYMkhlVFc0SVBRSjhDamVpUEFNaml5cXRNNGVvN1k4bVhCOEd2U2M2?=
 =?utf-8?B?SWxKaXFKMDVsUlZ0VlpuZVMzUEw1SEpwYU50UDZiRHRhOGlmQ2haaUM3MDRJ?=
 =?utf-8?B?Q1UwRC9jcGF1KzVKTXJKd3VCK0JXYmV0UUQ1cVBYaEJWTDJZb3BHcGlKSDJ0?=
 =?utf-8?B?bFQ2U3R5SW9NUU5VRWV1NkxHb2YwTzNzSmZyQmNLbGh5U1czcjBOYVZZNmZt?=
 =?utf-8?B?Mi9Tb0gxeDExY3I1K1c1M3A0V1ZmR05IWlpxeWtKbHR1SE1RMzlVRGlmK0JZ?=
 =?utf-8?B?QklEL1BaNnBud2duL2UzbmtSYTY1bm1PdG9zdWNnUFdmdGZLNzlDc1NqT2l5?=
 =?utf-8?B?T2pxTHA5WERZcmV4V2VCanJGNWJwR3NGb1hkZDRsZUhzK1FhVEMrUUhtMjhh?=
 =?utf-8?B?OVBGSDRCWWdRRDhZLysxU2EwVEJtdTVNSHgzQkhPWnVQZWxnSVRwaUF2ZGRS?=
 =?utf-8?B?UkI2aEZFR0t5eGFadHNUcTcwa3pkQ3FtWTB2L1BsRDZnMTlCUjQvcHhOSDlV?=
 =?utf-8?B?Qm5hWjVKVHV4alB5SlVJdER4cnA5S3ViOERCT2ozbGhnQjI1WFZSQVVFM2d6?=
 =?utf-8?B?NGVVczFDamhsNUh6enJxemFzK2ZXZ3ZQcmtNWlJPaUdpY21SL1ZkV0Q5Mmlq?=
 =?utf-8?B?STg0UEw3VWxuRTZOMnpDVTJrdGtVNW1wRTIybHhrSmdXOCtxNnNJK2hlcXRX?=
 =?utf-8?B?N0J2UHhaS1ZSRjJXY0JvK2VIZEtnQUhHMEVaK0VQQVA3ekdCcjZkL0RhVVJa?=
 =?utf-8?B?SHoxR2c2VWFvc1pVcGg2b0I4S0hrR2RUZGpKTE9hZ2VYczd6MUZndmZZNHFO?=
 =?utf-8?B?dDZ3aWdIcU42bUhTcllTSU90QysvWGhGYXdsY3hlRjJIamZHWVJHSGlsN3du?=
 =?utf-8?B?VjZBcFhmcnc5U1htd0ZaaFdqTnNQUEhJWXBpNVM2QitaakFhMXgvaHB5V0Vo?=
 =?utf-8?B?YXdEQkNvMURvMHVFVllVemErMDZLcWZ0emZ2NURoY2xMVndKczVSNDY4emJW?=
 =?utf-8?B?TERUa2hoUm1kR0xEbUU2R0JZb3p3ZExJcUZKTUU5NWxVbU5TWU5qcXlUTHFn?=
 =?utf-8?B?ekNYV2gxYjA2czkvTVpQNjNMWE1KbWlKT3VMVkY1OWdPWnVtTXl0d2dRcVpq?=
 =?utf-8?B?cDYxcGkwV3pVaTA3a2o4cW54K3VyOXpCenJlS2d0U282WndxSjBIK0RzMmZ5?=
 =?utf-8?B?SEZmclJla0k3N1dYdVYrUGY2bEVZekp1MS9hU3NOc2s3OVZsT0ZVWVF1RlVG?=
 =?utf-8?B?ZUJOaDhLYnJ5THpCUElKUkRWTlplQkdDMjNnSFZOKzBxWXpncUhHM2xBbWlR?=
 =?utf-8?B?MUxJVTg2d2RHTnNBNGdZVUtYTjlvTlg1SHNFSnZJR2VuMCszYmYvbTh0bDVM?=
 =?utf-8?B?SmN5a3NySXZUQi9qbHhpWndMa1RoSFFURTVzcjRiRk93OGI4TnFuR2hxWU5K?=
 =?utf-8?B?SmU4aEwvc3IzUnhJMksyeDhCSFA5OWhqWWVFb3YwMXZpMHZ3bllDV0xWWlQ4?=
 =?utf-8?B?cnBMeTdUWDZ4OTdkd3BQWHltc1U3M0d6RDNJRUIxU0tnbEdrdmk4MHd1THpr?=
 =?utf-8?B?TVlFOXE3bkkrb0FKbSs5WEJhWW9iKy9vZjNkMTFpQ21aTWdyUkczdWhlYnI5?=
 =?utf-8?B?QUE0N1B4MVJPMFFCOUEwcFE0OXpUeFVsRU9ncVg1L2x5VGR5eEZLdm9PZW8v?=
 =?utf-8?B?MkZrQzJwaGd4MnNwcHlFTm1oWjJSdmVSOGZCelVYcWEzVzJtazZZbitxdi9H?=
 =?utf-8?B?TW1SRXh0Yis2MTIzZDN4bEZ5SWxKWnNDUml1SjdtNUdhcHRpVEpkTXRCQ0hv?=
 =?utf-8?B?MjhseWREM3Z5OGJMMWl0RGZyZmJRMVBmQk15eGU3UHh6ZVdmbHpQMXJXc1hK?=
 =?utf-8?B?MWxjT0taekJjUFBMTUk5dFZHZ216aWQvRWZHa1VRaDcycGxIc0c0Kzk4UTk0?=
 =?utf-8?B?VUlMOGtwNS81WjN2NmFBUVA3MmNid3loZFpISVp2SjJSQmlrbWZhY213OUpw?=
 =?utf-8?B?N1VLcVZ3UHNFZ3hRZVN3NzVFOGpOc0owNDBHektFUHFiTENwMnBTY3VFK3hX?=
 =?utf-8?B?N29LUVBEc2hjNlFTU00yTTBOMHNpSHhMclV3ajZDUThueDk3S2JqZGwvS0hN?=
 =?utf-8?B?UHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6252.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a92817-35a7-4c61-0854-08ddbe2047c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 13:06:40.8002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ocup3IJ1925ENWE9IGGgvew4C0bCdhzhWBPbG4DBA7fBcfN9Xnn1XvYWU7jTzzYvU+i69h9FU8RoJMoX0yJrfV9+CrcWC6+Zef+2wpXoEsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9418
X-OriginatorOrg: intel.com

DQo+ID4gK2VudW0gbmw4MDIxMV9uYW5fY2FwYWJpbGl0aWVzIHsNCj4gPiArCV9fTkw4MDIxMV9O
QU5fQ0FQQUJJTElUSUVTX0lOVkFMSUQsDQo+ID4gKw0KPiA+ICsJTkw4MDIxMV9OQU5fQ0FQQV9T
WU5DX09GRkxPQUQsDQo+ID4gKwlOTDgwMjExX05BTl9DQVBBX0RFX09GRkxPQUQsDQo+ID4gKwlO
TDgwMjExX05BTl9DQVBBX0RXX05PVElGX1NVUFBPUlQsDQo+IA0KPiBUaGlzIHNlZW1zIGNvbXBs
ZXgsIHdoeSBub3QganVzdCBhZGQgdGhyZWUgbmV3IGV4dGVuZGVkIGZsYWdzPw0KPiANCg0KSXQg
d2lsbCBiZSBmdXJ0aGVyIGV4dGVuZGVkIHdpdGggbW9yZSBjb21wbGV4IGNhcGFiaWxpdGllcyB0
aGF0IGNhbid0IGJlIHJlcHJlc2VudGVkIGFzIGZsYWdzLg0KVGhpcyBpcyBlc3BlY2lhbGx5IHRy
dWUgZm9yIGRhdGEgcGF0aCByZWxhdGVkIGNhcGFiaWxpdGllcy4gTGlrZSBudW1iZXIgb2YgTkRQ
cy9ORExzLiBTY2hlZHVsZSBjb25zdHJhaW50cyBldGMuLg0KDQo+IGpvaGFubmVzDQo=

