Return-Path: <linux-wireless+bounces-16179-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B229D9EBAAE
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 21:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3DC166934
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 20:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252A88633A;
	Tue, 10 Dec 2024 20:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OK3ZoHEs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEB4227588
	for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 20:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733861578; cv=fail; b=dKErhHoPlPMlIB9J/8dQjX576WtEUVn1Yxn26eOL52c5bJlu51Tblr0Gb6NCxcHnGPO22hxt2uBCmDWMLWgzSpqi2asgaChLwS8sFFZ91ouhcMx/CaCG0xVAUbkfvPEBp6IBF4zFoCwnR9z4hmxcx0CrnCSu03kOKTneodlTg/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733861578; c=relaxed/simple;
	bh=+t/CE9Gxggq2XLblF4bYCWoD0YiYLLRaXLkU+013A24=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IhFn5uKJtRGLaoOYWIlB7J49Qw3T0RnIMninT0foVmzB1dEVuLoWTCySKjVAgwVW2KugP0kVpNVzkI2mGzx1edSWeJ47fSpr/pNTxkYGiUECIDbK7joWdorlHfy/7qCa/wkyiE2e67BbX+hjA25iw/vhPF+kAr4OuO0uisv8TvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OK3ZoHEs; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733861576; x=1765397576;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=+t/CE9Gxggq2XLblF4bYCWoD0YiYLLRaXLkU+013A24=;
  b=OK3ZoHEsvi/cn1Cb39g7qZiTtkqJ6bjCrQIoY1e+9yLtU5n1SlP+knee
   ComFhUfTOwHoXMtVv9ZWa39DYdl5Pa8i/jXfbSyWnxuIYbZ9+BaEe7Q6n
   voT4NzdlW1AFpEvyBgeKufXaC1wjdamHb6R8SCECpibPGV9h2DcSpjt3a
   pJwYAD6P/Im97ZIJt2Qezt4IAA4LGWRXqx3W5QfGGGtQ2L/R8yaO+g5s3
   tffQKgwo1qejcGYUsWS3lBrVaAnbN4ZiGGkkvW4UeRr1Y/MAeV7FWE12G
   oOuB5l1ij3WqFSezyRhqCarmim+NvEA0IbWcpinDhvrAs7fyLtv9lwAE7
   Q==;
X-CSE-ConnectionGUID: 4G3X5YXdT565vPh4UKXfxQ==
X-CSE-MsgGUID: 1CRbDxvkTOmwcHR7xZEoJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45625282"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="45625282"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 12:12:55 -0800
X-CSE-ConnectionGUID: LY3wP1p/Sa+gkDrV4AjfkA==
X-CSE-MsgGUID: z98BrjqSQKmPnTNraRESgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="95968200"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2024 12:12:55 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 12:12:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Dec 2024 12:12:55 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Dec 2024 12:12:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f2Vr+uyAonaP0GhHOygW3xjxafS1u0d/coMe93DH7yggQSfws2QHN3ug4c1tn4YnhqvXvuys9xONZUYCvO4ClI5lyIirgsA4fNrOJDB8VYMqpNhkKONJw3aZV5NJvlLmHfDLgXSvxEU1LLdikqPhNghOgkKiEpYo67E3CfD09q3GnJSGVPjaZ62vrIyzrTy15BUKbH48v6iP271JL0FxoKoU2NqBI8pwEtOBTMmNXbr/mm5joxd2Rb7aCiPyYkcUtQaIRYX96fX7xD+Ueb17VFQUJMmka6IrJrFKBW8ND8qp+eRvh5uYQDWRoyxj3XXUErvXOLiEObPjlptyEf6ZZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+t/CE9Gxggq2XLblF4bYCWoD0YiYLLRaXLkU+013A24=;
 b=SxK47P6GI78vRd1BYCd6XYvcFmhaq5daHqXizQiq07t3ehYbiR3SdMIxcYjcp45dGHSQjalXadgLw9MMM/Thrjsji6mF43qbP8HzRXPFblU0Hfr8USgDC8Op/It5Sxo8Igxv16Zd86kuIA2ghE/4exV7coLhF1EclyHWbW5m1Ycwa+TKPiXKinGw0QhTnGzO48lkwzXHW/6SolR15fgk5CifFlWgWLapA312cISylUYbY98qs8n1SY84tF50Lp+c4IgVyRh6KFHPBkMwUFShJkY5CYpp+Kc+2AGCIwrvWymx6txdMt5bKwfRgq97ix5EfqjO3c4agSlCtpKc1jXz2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Tue, 10 Dec
 2024 20:12:11 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%5]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 20:12:11 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Ben Greear <greearb@candelatech.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 1/2] wifi: iwlwifi: Fix eMLSR band comparison.
Thread-Topic: [PATCH 1/2] wifi: iwlwifi: Fix eMLSR band comparison.
Thread-Index: AQHbPFN15nBFel1ElUatMs2gQiIghrLgAhwAgAAEKxA=
Date: Tue, 10 Dec 2024 20:12:11 +0000
Message-ID: <MW5PR11MB5810FE6570308A2674ECB376A33D2@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <20240828202630.2151365-1-greearb@candelatech.com>
 <MW5PR11MB5810BAD7A2731D2DDACF5F7BA3222@MW5PR11MB5810.namprd11.prod.outlook.com>
 <2eb6cc22-4148-42c4-8cea-b1db0846a63b@candelatech.com>
 <a4d7f22d-d441-5380-f4bc-782ffb5b58ad@candelatech.com>
In-Reply-To: <a4d7f22d-d441-5380-f4bc-782ffb5b58ad@candelatech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|PH0PR11MB7522:EE_
x-ms-office365-filtering-correlation-id: ba47970e-56e8-47a4-ca73-08dd1956ee56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Yll3S0ZZTUxCWXI2d3hvT3dKaTZaYXV2dzRsT0F3QmFTSm0xY2pVSTU4Sm1v?=
 =?utf-8?B?WHFRaWFackFlb3RNRThyeURWOEtLa28vaFZVQWxwc25sT01hcUU1N2ZlaUVa?=
 =?utf-8?B?LzJvSnBZbnY5aUN1WVM1RVpURG1Ec1MvN0JiTzhJQTM2bkR4emZqRjFnWnZl?=
 =?utf-8?B?UFpocnNuRzVlNlNXNnZKSmt5eU9HUFN3RXo5NGw1UlVqTnlnTnVrNVZjZzJv?=
 =?utf-8?B?NGxIalB6UDliaTExY3JHOW1UQXVQTk4vUURsVHg4Nm9aenJtOEI2dmZuQXFl?=
 =?utf-8?B?V0RGTHh2bUlkMElrd3NTYk1yS3hiVU5SZ0dJZVFZMDFOQjlXMmkwSmlVdEhW?=
 =?utf-8?B?Um42UUpUY0g5WG1aSG9QdnU2d2tTM1NPK3FKQUtNYnRTaEZXcVh2VlJLaS9C?=
 =?utf-8?B?ZzFPUTF0YmVjdXU0QTcwa0NMUFBSYWxwd3B1VG0rbEpnQURZRUdjTXhVT21C?=
 =?utf-8?B?R1J2bkpQQUR2YUF6c0drOXdIT2NXUjcwVi9XVWNYdFk5a3lCL3BIczFGMGhw?=
 =?utf-8?B?V1VMTHFIRy9CdzIrR0RKM3Y4UCsyZFZXMmpnQ1YwajhRZ0I0Q2FPanZKclYy?=
 =?utf-8?B?V0x2R1pSSEVGeXlLSThOTGVTSGtJb3FXN2lrdjZlZitYNnY4TW9kZTFCWUY0?=
 =?utf-8?B?a01zaUFCcVhwQnkxUHdXckszWThhK1lVMnpmNG8rcUhTczZlVFRhcGNQQzJv?=
 =?utf-8?B?aGFmQjB2N3ltM29yMk5QclZBOVJkVGR1UTJyeTdxSU9tamRoYlpCY1NrRktB?=
 =?utf-8?B?NUVkTjdRWXpxd25pN29ieno0NHoxdlZ1bm9rTmtucHVzR1BvVTgwVlJMdWRs?=
 =?utf-8?B?ck9HTVBjWUtBVlducGFIRk1oRmtuVjVsMlRNMkl2aTAxYTYydmpLSmRtZHJS?=
 =?utf-8?B?Z2R4NmxrWmN6L3RhVGorR1JLcWZZRFhqVnZSdzJJRVByZEJnN2RCdG83akJn?=
 =?utf-8?B?WGZBcFVpSVZkdkFGOEdmM1pNMjk4MU1pMEJzb2tMc2x5VFBvdjU5ZDF0KzFi?=
 =?utf-8?B?OWZ3aEErbU5CZ1J4OEk0V05jNFVMa21YRVpja05Xa0FVYnRMZXFnc0psWDND?=
 =?utf-8?B?WTMxMHUzRHJuVnRIZ2cwNVAxZ3JnbWFSM3ByRWt3SzJSWFlNdXZOa1ZROXVG?=
 =?utf-8?B?dk1tQUlVaE1sREY1YnFsRUZOc0F0T2pxRTI0L2xBSUhPK3VyMzJ5dHNOQkZS?=
 =?utf-8?B?QVF2dFo2VTB1Sk1KSEpEcGRraTF2NWlMOHFKNkN0cDZscUt6eHVRRnRTNU5l?=
 =?utf-8?B?bVpENVRQWWt6R3lEcE9pVWhIVnlUU2FUWUxDY1JyazRRZVlxaUdoTmdyZE9l?=
 =?utf-8?B?Y3plVjFJS0NWSmFkc3ZML2ZYNnN4a0VJOUlwbUExZ3RZbUNtcTRYOFdXcjBa?=
 =?utf-8?B?Vm5tRGRBNjZqTEJLcVZaY0dYMVNqNVJKMUxPZVVrdjhEZGJEYTBvMWRqSG5i?=
 =?utf-8?B?U0tRbnE3OXlkazRBTi9LMmZ5WUFhOFBBa0xrTkFKdGQ3eUVQbG11dklhRkNL?=
 =?utf-8?B?M3FtdGhSY1dRUCtNK3R5YXhhTG0zaXFlZkd0bHkxdTFaVWdIRmh3SURJbW12?=
 =?utf-8?B?MThyL1c4UnV6YzhHejBDRDdzZHVyR0w4Q3B6UDFCUDA3QTV0NmRNT2xjR0Yw?=
 =?utf-8?B?aWh6SHc0eDNSV0w3eTdNMzJjZ2c3cEtSTFRtWTN3MldBcWNaR0FTVWFPcDE1?=
 =?utf-8?B?SWpKdnNvM05tZFhiTXI0NU5JVXNtVHF0V1YxTlVFejVRR1BnVXlEd1JYM1I2?=
 =?utf-8?B?THkwU0d5SklDOUhOSk5XV0QzWk9IRGVJUlM4enhuM1ZYbGpxeW94OUg3UkxE?=
 =?utf-8?B?YXoySUx3c1BZRFJyd0tqeU9ra2oydWhZaG05dU9vemdGSEhkYStjNjZvOFVX?=
 =?utf-8?B?bi9oS3JLWTlBeU92R2I1Sis3a1o1L0Nqdm5QeUVJZGRaSkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjJxU1Q4dWtxcXBIaWZxbTJVWmRNWFFqNEZUU2ZibE5CaXVzblNKWUZKR3ZC?=
 =?utf-8?B?L2M5Y3BkOTV1ODJtY3kxTUIvMWVqLzNJMDZ3L3dxZjdERWs2bGRJNHYxaWgr?=
 =?utf-8?B?ZEQyS2w5OWlwaDdqZHY0SDVkZ090YUpndnkxTEIxSEcyZlIvdE9oditMVWpX?=
 =?utf-8?B?Z0xpQlVwQlVLdWlZeE5USFNHWFdHdVlWNVB2cm90cjF0Ujc0SEwyTFdFR20x?=
 =?utf-8?B?ZTZKeEcxRDk4TmlXczlVRysvR3RwLzJPVitTMFc5WVBjeTRlVkFPdFA3c2VB?=
 =?utf-8?B?LzdQaStiNnRBWG02c3pRMlBickZWdGtQbTlnQVBMRkRSWmU2WTFvOTVZejNL?=
 =?utf-8?B?MmUzdndMUUpjL2xQWXVOdlQ5SnowcEk4dGNZSXhpNXBtMkJYUytVWjcyeS9X?=
 =?utf-8?B?UzBrdW9DbitEUlI3L3k0VFc3MTNxcW10RTFQOGNiT09VcUZzM1ZsZkE5ZkMw?=
 =?utf-8?B?N1p6cUlTMTN3UXM4QnpLMlRuUjZzV1pleTNSSmtjUzRQQ1A5Z3pVajlQUGtQ?=
 =?utf-8?B?eHB4S2VBOFNmUXJGVVRVbmNPeXRSUEpDTkZFdUpuNkFxdDBhMFV3TzZhSTA5?=
 =?utf-8?B?eHE3NHhZS0p1YVRZZkpFL3RWbUZ6MWhOOWVUVE5mcFFYcTJ1c05PWThjbEJj?=
 =?utf-8?B?bVRNWEZkR1RsSGMxM1pzZkdGSC8wa0ExRjljUWMvaG5IVE5iTUJhQXZHWmwz?=
 =?utf-8?B?RElFNjQyb1Ayc3g4ekx5bnArRDRKSkdJSStTV2Fzd0VwMk5CVGxrVHFqU0E2?=
 =?utf-8?B?TmJ1WnNUdGsyK0wyUDN3cGRBeTY1T0laOUtTbVEvZ0pCbkVHaVJvMnV2SVNu?=
 =?utf-8?B?eVlsSkJvM0VwTmt2OUVxbXAyNXd1NEJQU0ZrWVgxRXY1bXdQVHlvRDBHNjJU?=
 =?utf-8?B?V1pDSU9QS3VTb28ydlM1SjhpWnUzZ2oyWnVQNmRma0J0QnFyOVpzbHo1Vjly?=
 =?utf-8?B?aUxXWlhHUndYTllOeTRjUnNiTDN3ZEtvaTJCK05WMkh3R3M2RndjTjlJKzZZ?=
 =?utf-8?B?eHRPYkNtcmxsN21EYTd4elExNUt2UXptOW9idEs0bGtRbURZWjhFL0ZWMEt2?=
 =?utf-8?B?OGdMT21jWGYyZE96NDkySi9mVm9qV1BVNUxSTVVTTXc3STFXQ20yT2lDK3RS?=
 =?utf-8?B?RGZuZHFtbGxaS1M3akNnTW1HMXpWOEJSOUFuZ01WcW1GVTRIWTJuUVU0WDhQ?=
 =?utf-8?B?ZTZncW9WRDBYZHFvYytnQ3lzaFhZbEdSVXA0VGVVR0g5ZUlyV3hyK1NqaEta?=
 =?utf-8?B?dG0weUtCSzAxakl4RzJxdXlKNE9scFhLblVSWW9hSzRGTk8xVk11NDFBcDFQ?=
 =?utf-8?B?VHlUQ0J6L2Fqd1Y4NnJacjBIVm9YRVBsRkowZUNxei9pMm1XNG5jRWpTTXBO?=
 =?utf-8?B?N2tEWTZxKy91SnA4NWI3M0RMVklFdVREY1ArZGllak9qU1MxTU9uWTBSSkZH?=
 =?utf-8?B?MGlsUUxpMGJ1YjVuU2VDVnkxZlRjR1FId0I4TkpxeTdqUWlLM3lNTlVIYWZh?=
 =?utf-8?B?YUJzcXNRbVpSY0dkYjlGQ2N2WjFFSDNBdXpaRk43blpXSWF1dzBzZHE2ZFRv?=
 =?utf-8?B?eDF4MDJuSzdwa3ZiejZFMFd0Vm9LZVNTVkQrQS9NYi9zWG5NeTR1QmZPV2Zy?=
 =?utf-8?B?dGwyK1VzMU84c1pkVVQ3cUdHZzlweVBTZHVVeGlHUGt6aEtQMWFjVlhZdVpI?=
 =?utf-8?B?SkpsSFJ4V1pIaVhoMlJ2em12QnNOdStzcXYvK0Y3K3dsejdWT2JRWUZyU3l4?=
 =?utf-8?B?ejB5Y21jYlhOMnArMGhjRnhYZzRhSzFIMm9pRlhhSUhIdGVaUVBXdjlkbnM5?=
 =?utf-8?B?MG5NeEZOcTZMa3kvUlUrcm1SMzFUWVE0WXFOSlR4VFJBd2RoeWhpdTQyVFgr?=
 =?utf-8?B?NGQ2UkJLU1h1VzIrWmwvS3h6dkxCVjU4bW5SaEd5c3hoeEU3cmszMGRYQUFn?=
 =?utf-8?B?SUJTUEd2bHl6RWNSVjRxL3d1WE96YWtTcHVSdmtjRC9ibzlmQmRlSmhmVDdr?=
 =?utf-8?B?MlB6eGxrSmFVR1FtaUlJU2tRUmFOY1RSbG84WmRjRTlIZW1Gb2p4NUYzMnlC?=
 =?utf-8?B?eEEvcHpnMmVXcU01dG1YdTVDWitpYVl1U1dvblhtYWxmMXF5M1QvaHhNb1dB?=
 =?utf-8?B?clIzRVZPa3BwbnpBSGZ0L3JnWkxpTWVzOTRjWDNnaDBDSVJrYy9FeitZN1Er?=
 =?utf-8?Q?uSpfL6Az1DDzolLGmL6Vhfc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ba47970e-56e8-47a4-ca73-08dd1956ee56
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 20:12:11.2632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SUbNfDL69fMKJiuKySeTrS0fBCiD+m1x+YIbNOwyIBulbvRfqb92gZDeIGU7QpNVeJCcra2bOyfqsNycf035YHx6SkinxVz6JTU/7XRhDtaSjgZe+VWM5ZH/45VyH4Fu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7522
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmVuIEdyZWVhciA8Z3Jl
ZWFyYkBjYW5kZWxhdGVjaC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIDEwIERlY2VtYmVyIDIwMjQg
MjE6NTUNCj4gVG86IEtvcmVuYmxpdCwgTWlyaWFtIFJhY2hlbCA8bWlyaWFtLnJhY2hlbC5rb3Jl
bmJsaXRAaW50ZWwuY29tPjsgbGludXgtDQo+IHdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIDEvMl0gd2lmaTogaXdsd2lmaTogRml4IGVNTFNSIGJhbmQgY29t
cGFyaXNvbi4NCj4gDQo+IE9uIDExLzIxLzI0IDEyOjI0LCBCZW4gR3JlZWFyIHdyb3RlOg0KPiA+
IE9uIDExLzIxLzI0IDEyOjExIFBNLCBLb3JlbmJsaXQsIE1pcmlhbSBSYWNoZWwgd3JvdGU6DQo+
ID4+DQo+ID4+DQo+ID4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4gRnJvbTog
Z3JlZWFyYkBjYW5kZWxhdGVjaC5jb20gPGdyZWVhcmJAY2FuZGVsYXRlY2guY29tPg0KPiA+Pj4g
U2VudDogV2VkbmVzZGF5LCAyOCBBdWd1c3QgMjAyNCAyMzoyNg0KPiA+Pj4gVG86IGxpbnV4LXdp
cmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiA+Pj4gQ2M6IEJlbiBHcmVlYXIgPGdyZWVhcmJAY2Fu
ZGVsYXRlY2guY29tPg0KPiA+Pj4gU3ViamVjdDogW1BBVENIIDEvMl0gd2lmaTogaXdsd2lmaTog
Rml4IGVNTFNSIGJhbmQgY29tcGFyaXNvbi4NCj4gPj4+DQo+ID4+PiBGcm9tOiBCZW4gR3JlZWFy
IDxncmVlYXJiQGNhbmRlbGF0ZWNoLmNvbT4NCj4gPj4+DQo+ID4+PiBEbyBub3QgbWFrZSBhc3N1
bXB0aW9ucyBhYm91dCB3aGF0IGJhbmQgJ2EnIG9yICdiJyBhcmUgb24uDQo+ID4+PiBBbmQgYWRk
IG5ldyByZWFzb24gY29kZSBmb3Igd2hlbiBlTUxTUiBpcyBkaXNhYmxlZCBkdWUgdG8gYmFuZC4N
Cj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBCZW4gR3JlZWFyIDxncmVlYXJiQGNhbmRlbGF0
ZWNoLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gwqAgZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwv
aXdsd2lmaS9tdm0vbGluay5jIHwgMTMgKysrKysrKysrKy0tLQ0KPiA+Pj4gZHJpdmVycy9uZXQv
d2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vbXZtLmjCoCB8wqAgMiArKw0KPiA+Pj4gwqAgMiBm
aWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+Pj4NCj4g
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9s
aW5rLmMNCj4gPj4+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vbGlu
ay5jDQo+ID4+PiBpbmRleCBiYjNkZTA3YmM2YmUuLmYzZmIzN2ZlYzhhOCAxMDA2NDQNCj4gPj4+
IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL2xpbmsuYw0KPiA+
Pj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vbGluay5jDQo+
ID4+PiBAQCAtMTYsNiArMTYsNyBAQA0KPiA+Pj4gwqDCoMKgwqDCoCBIT1coRVhJVF9MT1dfUlNT
SSnCoMKgwqDCoMKgwqDCoCBcDQo+ID4+PiDCoMKgwqDCoMKgIEhPVyhFWElUX0NPRVgpwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBcDQo+ID4+PiDCoMKgwqDCoMKgIEhPVyhFWElUX0JBTkRXSURUSCnC
oMKgwqDCoMKgwqDCoCBcDQo+ID4+PiArwqDCoMKgIEhPVyhFWElUX0JBTkQpwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBcDQo+ID4+PiDCoMKgwqDCoMKgIEhPVyhFWElUX0NTQSnCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIFwNCj4gPj4+IMKgwqDCoMKgwqAgSE9XKEVYSVRfTElOS19VU0FHRSkNCj4gPj4+
DQo+ID4+PiBAQCAtNzUwLDExICs3NTEsMTcgQEAgYm9vbCBpd2xfbXZtX21sZF92YWxpZF9saW5r
X3BhaXIoc3RydWN0DQo+ID4+PiBpZWVlODAyMTFfdmlmICp2aWYsDQo+ID4+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgaXdsX212bV9lc3JfZGlzYWxsb3dlZF93aXRoX2xpbmsobXZtLCB2aWYsIGIsIGZh
bHNlKSkNCj4gPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7DQo+ID4+Pg0KPiA+
Pj4gLcKgwqDCoCBpZiAoYS0+Y2hhbmRlZi0+d2lkdGggIT0gYi0+Y2hhbmRlZi0+d2lkdGggfHwN
Cj4gPj4+IC3CoMKgwqDCoMKgwqDCoCAhKGEtPmNoYW5kZWYtPmNoYW4tPmJhbmQgPT0gTkw4MDIx
MV9CQU5EXzZHSFogJiYNCj4gPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqAgYi0+Y2hhbmRlZi0+Y2hh
bi0+YmFuZCA9PSBOTDgwMjExX0JBTkRfNUdIWikpDQo+ID4+PiArwqDCoMKgIGlmIChhLT5jaGFu
ZGVmLT53aWR0aCAhPSBiLT5jaGFuZGVmLT53aWR0aCkNCj4gPj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCByZXQgfD0gSVdMX01WTV9FU1JfRVhJVF9CQU5EV0lEVEg7DQo+ID4+Pg0KPiA+Pj4gK8KgwqDC
oCAvKiBPbmx5IHN1cHBvcnRzIDVnIGFuZCA2ZyBiYW5kcyBhdCB0aGUgbW9tZW50ICovDQo+ID4+
PiArwqDCoMKgIGlmICgoKGEtPmNoYW5kZWYtPmNoYW4tPmJhbmQgIT0gTkw4MDIxMV9CQU5EXzZH
SFopICYmDQo+ID4+PiArwqDCoMKgwqDCoMKgwqDCoCAoYS0+Y2hhbmRlZi0+Y2hhbi0+YmFuZCAh
PSBOTDgwMjExX0JBTkRfNUdIWikpIHx8DQo+ID4+PiArwqDCoMKgwqDCoMKgwqAgKChiLT5jaGFu
ZGVmLT5jaGFuLT5iYW5kICE9IE5MODAyMTFfQkFORF82R0haKSAmJg0KPiA+Pj4gK8KgwqDCoMKg
wqDCoMKgwqAgKGItPmNoYW5kZWYtPmNoYW4tPmJhbmQgIT0gTkw4MDIxMV9CQU5EXzVHSFopKSB8
fA0KPiA+Pj4gK8KgwqDCoMKgwqDCoMKgIChhLT5jaGFuZGVmLT5jaGFuLT5iYW5kID09IGItPmNo
YW5kZWYtPmNoYW4tPmJhbmQpKQ0KPiA+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldCB8PSBJV0xfTVZN
X0VTUl9FWElUX0JBTkQ7DQo+ID4+PiArDQo+ID4+PiDCoMKgwqDCoMKgIGlmIChyZXQpIHsNCj4g
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBJV0xfREVCVUdfSU5GTyhtdm0sDQo+ID4+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJMaW5rcyAlZCBhbmQgJWQgYXJlIG5v
dCBhIHZhbGlkIHBhaXIgZm9yDQo+ID4+PiBFTUxTUiwgYS0NCj4gPj4+PiBjaHdpZHRoOiAlZMKg
IGI6ICVkIGJhbmQtYTogJWTCoCBiYW5kLWI6ICVkXG4iLCBkaWZmIC0tZ2l0DQo+ID4+PiBhL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL212bS5oDQo+ID4+PiBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL212bS5oDQo+ID4+PiBpbmRleCBhYzRl
MTM1ZWQ5MWIuLjIyYmVjOWNhNDZiYiAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL212bS5oDQo+ID4+PiArKysgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tdm0uaA0KPiA+Pj4gQEAgLTM2OCw2ICszNjgsNyBA
QCBzdHJ1Y3QgaXdsX212bV92aWZfbGlua19pbmZvIHsNCj4gPj4+IMKgwqAgKsKgwqDCoCBwcmV2
ZW50aW5nIHRoZSBlbmFibGVtZW50IG9mIEVNTFNSDQo+ID4+PiDCoMKgICogQElXTF9NVk1fRVNS
X0VYSVRfQ1NBOiBDU0EgaGFwcGVuZWQsIHNvIGV4aXQgRU1MU1INCj4gPj4+IMKgwqAgKiBASVdM
X01WTV9FU1JfRVhJVF9MSU5LX1VTQUdFOiBFeGl0IEVNTFNSIGR1ZSB0byBsb3cgdHB0IG9uDQo+
ID4+PiBzZWNvbmRhcnkgbGluaw0KPiA+Pj4gKyAqIEBJV0xfTVZNX0VTUl9FWElUX0JBTkQ6IEV4
aXQgRU1MU1IgZHVlIHRvIGluY29tcGF0aWJsZSBCYW5kcw0KPiA+Pj4gwqDCoCAqLw0KPiA+Pj4g
wqAgZW51bSBpd2xfbXZtX2Vzcl9zdGF0ZSB7DQo+ID4+PiDCoMKgwqDCoMKgIElXTF9NVk1fRVNS
X0JMT0NLRURfUFJFVkVOVElPTsKgwqDCoCA9IDB4MSwgQEAgLTM4Miw2ICszODMsNw0KPiBAQA0K
PiA+Pj4gZW51bSBpd2xfbXZtX2Vzcl9zdGF0ZSB7DQo+ID4+PiDCoMKgwqDCoMKgIElXTF9NVk1f
RVNSX0VYSVRfQkFORFdJRFRIwqDCoMKgID0gMHg4MDAwMCwNCj4gPj4+IMKgwqDCoMKgwqAgSVdM
X01WTV9FU1JfRVhJVF9DU0HCoMKgwqDCoMKgwqDCoCA9IDB4MTAwMDAwLA0KPiA+Pj4gwqDCoMKg
wqDCoCBJV0xfTVZNX0VTUl9FWElUX0xJTktfVVNBR0XCoMKgwqAgPSAweDIwMDAwMCwNCj4gPj4+
ICvCoMKgwqAgSVdMX01WTV9FU1JfRVhJVF9CQU5EwqDCoMKgwqDCoMKgwqAgPSAweDQwMDAwMCwN
Cj4gPj4+IMKgIH07DQo+ID4+Pg0KPiA+Pj4gwqAgI2RlZmluZSBJV0xfTVZNX0JMT0NLX0VTUl9S
RUFTT05TIDB4ZmZmZg0KPiA+Pj4gLS0NCj4gPj4+IDIuNDIuMA0KPiA+Pj4NCj4gPj4gSGkgQmVu
Lg0KPiA+Pg0KPiA+PiBJdCBpcyBhY3R1YWxseSByZXF1aXJlZCB0aGF0IGEgKHRoZSBiZXR0ZXIg
bGluaykgd2lsbCBiZSBvbiA2IEdIeiBhbmQNCj4gPj4gYiBvbiA1IEdIeiBSZWdhcmRpbmcgdGhl
IG5ldyBleGl0IHJlYXNvbiwgaXQgaXMgbm90IHJlYWxseSBuZWVkZWQgYXMNCj4gPj4gd2UgY2Fu
IGVhc2lseSBkaWZmZXJlbnRpYXRlIGJldHdlZW4gdGhlIGNhc2VzIChmcm9tIG90aGVyIGxvZ3Mp
DQo+ID4NCj4gPiBIZWxsbyBNaXJpLA0KPiA+DQo+ID4gSSB0ZXN0ZWQgdGhpcyBwYXRjaCwgYW5k
IGl0IGZpeGVkIHByb2JsZW1zIGZvciBtZSB3aGVuIEkgcmFuIGEgdGVzdA0KPiA+IHRoYXQgY3Jl
YXRlZCBpbnRlcmZlcmluZyB0cmFmZmljIG9uIDVnaHogYW5kIHRoZW4gbGF0ZXIgb24gNkdoei7C
oCBJDQo+ID4gZXhwZWN0ZWQgZU1MU1IgbW9kZSB0byBzdGF5IGFjdGl2ZSBubyBtYXR0ZXIgd2hl
cmUgdGhlIGludGVyZmVyaW5nDQo+ID4gdHJhZmZpYyBleGlzdGVkLsKgIFdpdGggdGhpcyBwYXRj
aCwgYW5kIGEgZmV3IG90aGVycyBJIHBvc3RlZCwgdGhlIGJlMjAwIHRoZW4NCj4gd29ya3MgZmFp
cmx5IHdlbGwuDQo+ID4NCj4gPiA2R2h6IGlzIG5vdCBhbHdheXMgYmV0dGVyLCBmb3IgaW5zdGFu
Y2UgaW4gY2FzZSB3aGVyZSBpdCBpcyBjb25nZXN0ZWQNCj4gPiB3aXRoIGV4dGVybmFsIHRyYWZm
aWMuDQo+ID4NCj4gPiBDYW4geW91IHBsZWFzZSBsZXQgbWUga25vdyAqd2h5KiB5b3UgdGhpbmsg
dGhlIGJldHRlciBsaW5rIG11c3QgYWx3YXlzIGJlDQo+IDZnaHogaW4gdGhpcyBjYXNlPw0KPiAN
Cj4gSGVsbG8gTWlyaWFtLA0KPiANCj4gSSB3YW50ZWQgdG8gY2hlY2sgdG8gc2VlIGlmIHlvdSBz
dGlsbCBjb25zaWRlciB0aGlzIHBhdGNoIGludmFsaWQ/ICBJZiBzbywgSSdsbCBhZGp1c3QNCj4g
aXQgdG8gd29yayBiZXR0ZXIgYXMgb3V0LW9mLXRyZWUgcGF0Y2ggYW5kIGFkZCBpdCB0byBteSBw
aWxlLg0KPiANCj4gSWYgeW91IHRoaW5rIGNvcmUgbG9naWMgaXMgZmluZSBidXQgdGhlIHBhdGNo
IG5lZWRzIHNvbWUgdHdlYWtzLCBwbGVhc2UgbGV0IG1lDQo+IGtub3cgeW91ciBzdWdnZXN0aW9u
cy4NCg0KV2UgYXJlIGp1c3QgY2hhbmdpbmcgdGhpcyBsb2dpYyBpbnRlcm5hbGx5DQooYW5kIGFs
bG93IGFsc28gMi40IEdIeikNCg0KU28gSSBhbSBub3QgZ29pbmcgdG8gdGFrZSBpdC4NCj4gDQo+
IFRoYW5rcywNCj4gQmVuDQo+IA0KDQo=

