Return-Path: <linux-wireless+bounces-31704-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJQmGktDi2nLTgAAu9opvQ
	(envelope-from <linux-wireless+bounces-31704-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 15:40:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF4811BFC8
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 15:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F0E9300B447
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 14:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D8B36E47D;
	Tue, 10 Feb 2026 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jd/df5SR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB3D31B110;
	Tue, 10 Feb 2026 14:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770734408; cv=fail; b=dtTOcJU2ofWC6Nl9AkwA8DsHRHEDds3w9idp/xQNsb299/xsJL3thw8NRlGF27Hkx3lojMEwgX40i/4qVsGXc2b935fAD4WTgtJ15kH5G/xa5pNxqranyqXxXhKKV6RKg35k6xPzgZvEH7943oos8CUcnwAyHDfXKKZXTterfUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770734408; c=relaxed/simple;
	bh=kMQ6ZitYFtRQbkBxBT0liQ4yqBpmrKYmn5ye1RQH1l8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E5YO8MCKHWmu0e/vj7VxZb2Y+EHPnd45W+YWrY42GgRnJvs/b/Oe0dn/HIijTJ0ynr2Sjb4s6sO6+Ymv+C8F93CDl0/uQhq/LzpBgLJl+zKw9QXXPXWCH9v7ebJwoydUbe57ZeqpIz1gZyQ/JI+K2jQ+VPau1W/bwtxCLmBQjuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jd/df5SR; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770734407; x=1802270407;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kMQ6ZitYFtRQbkBxBT0liQ4yqBpmrKYmn5ye1RQH1l8=;
  b=jd/df5SRn80MPZcU1qrbwub7nT1n5QjhE1svbxlu4cuAY/QF6htP3ZEV
   3pYjt3kp8ocW8RmfQZJtL5fy2l9XZgq9+39P3WL517W+azaUYbz8Q3CiO
   yW+5/w+CYqXbleTJJrfT0X2r27l5CfJ9ge7Z8zGIZIHxqvWmJCU7qdR+7
   IZGbAFVFyfd0QW8G/kC893bbKwAZ7uVq77HuHEH4JlmelLvrLIKZOftXf
   eTALp18RfNUr+v6t3ScGZAK/de6wTjnJ3nQmnqT7G+ogCbl998ewAFOoN
   pptDgCxtH8IGgdhLe+6XLpSnbcCC8nK5Rx5WXx8VkhBfvHp5u0YY/JL95
   g==;
X-CSE-ConnectionGUID: cQxO2GpTR5eCUE0aOnk8lg==
X-CSE-MsgGUID: oSQHshMUShe7EQdJqi2r7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="94505578"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="94505578"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 06:40:07 -0800
X-CSE-ConnectionGUID: RYUyr1odQUGmxDlIo9MTJw==
X-CSE-MsgGUID: jR3GpItuTm6Bh+yYA3zfmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="249580401"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 06:40:07 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 06:40:05 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 06:40:05 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.68)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 06:40:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwvTnI1oB6GWRPvHN+adp4Oei4FGETRPN3cY8Mys/loxiTuYvDSm4g1771irQI9qtNA7mnUaYiPDmonLprr0xZgId12GXZtLj2iaMjs4+d2xTGpH9p2AKbe8U+8OW9fTQK4dLAl8MtiEcSvyjBKff13tG9dnrHX4EkZDX1+ENj4/7X4Tc9vJErPZSP4FH/nJpxpGWlkxNAdmWmcww9mpCicOT6X7VDNXwiOhYd6hPY70czscUOvHh/EgT4ZgLwmeUAVb1wLytf1F+VB8PG+C8LsKygK3TGNj28ABlA0Da080ot6DMaV7bGxBwaYzLbODrFK3utdPG6I6lP4RiTH1OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMQ6ZitYFtRQbkBxBT0liQ4yqBpmrKYmn5ye1RQH1l8=;
 b=I1EaTtra50SzNEC/eWJqgeXEcfAIExE0Y0/FXpDvi5Kg4p16OEKkX0IVfHmOJr11gkHp+OlXe7S+HNLAoSPLEepHXJpq2QrgC7aJ/jXRrmp0Ep+kPDriZs+FmoeY/XbAM/qMbW+OabB3dzBfx1EgyTdPDgIsB9I64NrDtXNk/TEbl9Ec336a6z90Eg7t00EogQGXiIQPVxAUkxm68PG784Y3PL10yW7cCkOMS3aHTCGyI1MndkLnjDERmkva1xZcbVBCSu9GLM7t00LJxfeREWw+AnBA5Tac3mkBmPyEELcOqLYH5Od74nMAQPCQBUGK5/R83Ng0w7iPKJ5nO9IJXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by MN2PR11MB4519.namprd11.prod.outlook.com
 (2603:10b6:208:26c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 14:40:03 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 14:40:03 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Marco Crivellari <marco.crivellari@suse.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, Johannes Berg
	<johannes@sipsolutions.net>
Subject: RE: [PATCH v3 3/3] wifi: iwlwifi: mvm: replace use of system_wq with
 system_percpu_wq
Thread-Topic: [PATCH v3 3/3] wifi: iwlwifi: mvm: replace use of system_wq with
 system_percpu_wq
Thread-Index: AQHcmppYpKZDCb9PnUKISJMdd7UaXbV8AORQ
Date: Tue, 10 Feb 2026 14:40:03 +0000
Message-ID: <DM3PPF63A6024A9D20EDD3132C321B08213A362A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <20260210143332.206146-1-marco.crivellari@suse.com>
 <20260210143332.206146-4-marco.crivellari@suse.com>
In-Reply-To: <20260210143332.206146-4-marco.crivellari@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|MN2PR11MB4519:EE_
x-ms-office365-filtering-correlation-id: 0f63aed5-a2a2-4786-2445-08de68b246d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RDAyV1JwMndYRDJpanNmYTR2YUwvV1UvTVhYMGN2UGQ3dVg5WXpjaFlQVEcz?=
 =?utf-8?B?bkd5QklobjVZcnoyM29oN1VsaUdaOXJwTjVVNVFHMFh6WU00N1o2RmpJQ1ZG?=
 =?utf-8?B?OTJpSVpac1prS0l5amFOM3cvWHJNMEJlUWJLRXkxU0l0dzdaQ2R3cmhWK3VJ?=
 =?utf-8?B?TzdJUkFuOTBuNTdnV1FVN2JtTkxRRnJVUS8rMFVHK05CR3h4Mk5za3dRakV1?=
 =?utf-8?B?MEtMa09TSThQUmovMHpHRHBteXlUd3dqV3NaSGc2WmJ1WS93UGVJbFI0blZE?=
 =?utf-8?B?bUtHU1lZVVkwdS9hQnBscjM0R2p3TTVkUFVFTm11U3lzUStaTTQzRU1ucEVq?=
 =?utf-8?B?ZzZKZWU3N2pidFB1YWRta2Z1U0RQSUxUMUFRWkV4UklzYlA0TUhNSytZU3U2?=
 =?utf-8?B?bWFZcDZZZ3dWQ2ZTaDJDNlVkb3hkM1VyOXBxZFIyWXgzZjBpb0xWM0taR2pu?=
 =?utf-8?B?VXovVStJekJNVVlaWTh1OEtITFlsUlF1eFhYR0lrWEdKaytsN2NFdEo3UXRh?=
 =?utf-8?B?MFFCcXVnYVh3cDBSajhQdzVqajh2aTdIUHE4bzgzb0ZFM0xOQUVMUkRnM1p0?=
 =?utf-8?B?OHJBR2lGanRJL0t3Ky9VYVBQY2tPUWl0YmFJbE9Ib2k1U1ZXRDExcTIyd3M1?=
 =?utf-8?B?NkRNR2V4eHoyQnM1cWhCYVFIZElLZEJkTms1bFFjZGhMTE5qbk5XaUk4cVVM?=
 =?utf-8?B?R1NFRWE4emJ3a0dWU21pLzAxNE1vOG9CNFc5VGh1MDRJSnY1Q2pleUNFWk9l?=
 =?utf-8?B?bFpmWVNmaWlmSkJhZmd0alo3NmgwTWxyUXFjNUpDZXFXNUQ3bkZtS0hCSzZ4?=
 =?utf-8?B?a3U0WnJ1SG9PTzJjNk53UThWWGpCSDIydTM2TEFDd3dSZS8xRVFPRCtyRTZC?=
 =?utf-8?B?cmlCUVlIcXIzOERaMDZza1NxMWdLVUdjRVVWa1orQWdPSUNRd2FlbTdpdnhL?=
 =?utf-8?B?cHFoZzhweW1tZXRjZk5lRjgwTW1IY2diQU5DdkJDanBvRkRYV1kzRE1UK1hQ?=
 =?utf-8?B?WEVuWTBoaFhLMEpEeWhsb2ZOYlRFQ0NhOVl0QmVUdzJyVTRYVmdCQnk5cVBT?=
 =?utf-8?B?RXdpMy9uSktmUEZkSjJUNmtac201dmI2YVlNQmkxZ1c0Z29HdmVFRnhCTUpV?=
 =?utf-8?B?QjRkeGc2M3loT2xvK2hDam1Ha3lkNlBBK2lCTzVJQzA1TmEyZGxUK25zLzl6?=
 =?utf-8?B?Z1hKVUNBRzRZc3crdVBUQmF0Y3drWWhQNFltWDZHT2N2UDlXZUh5cmN1emd5?=
 =?utf-8?B?WG9UYS9tMUVIZmZnaEhoM2R1enhRRnQ3NlA2ZWFoZk5tN1JmZ0dpcndFcTA5?=
 =?utf-8?B?RFJGZW9KZE5tTlpZYVkvUTl5OHNCOExJZU0rNzAreS81Y3poVVpNenF2VmpR?=
 =?utf-8?B?NGRab1FvUmZHSU05emRpZ0ZOSVgwbW9rbXJ4THVWR0xWbUZBUnNjcldWbStW?=
 =?utf-8?B?c0p6eFcrc1BYN25IajhqSTJvV1dtdkJJdVdxZzN5a2R4TEdoOG5PVER6dmdL?=
 =?utf-8?B?aDdnREQ4b3RxQ21JaTNrektMWXFxVzFnVHBYcVlhVFEwTkhmb2J0ak8xTXZ1?=
 =?utf-8?B?ZFJLVzhrSEFGdVB6bVcxdEwrSkpqaGR4UkxndFVWOTQrMTV1RmVqci8rUStK?=
 =?utf-8?B?SC8vbk9nVG0vZWx1M0M1YWNqRGNiZEdXRVF1aFplb0k4a2VqcDNIZnFvNHhE?=
 =?utf-8?B?U3JiWG1YOHpNUGtvd0Rscm9OY2NLVmVya21GOU9ick13cyt6bmtIQmxYTTFI?=
 =?utf-8?B?c1I0S3RENDh5cUsrNW52NmRoc2RadElLQXEyTTRydThyRUh1VjRhblgvamov?=
 =?utf-8?B?dlRQYmdVeE5EOVE5T2RqV1JEeStxaGhPRWpCTHJsajFzNjFGQy85c2RISi9n?=
 =?utf-8?B?RjdhTTQ0ZndFY0ZsYnZrUnBYdW82ZkZ6QSthcVdJd0dyU3lTcWwxRHR5S3RG?=
 =?utf-8?B?NXNTdU44aS9FZCtJTklMOFc3SFcrN3dmRlpLemNPdTFOZXF3M3VkV2d0RzdN?=
 =?utf-8?B?QncvQ29PVnNhNERUR05Jcm1iQW5zTzhUM2E3Tk1aMTNxTldrTm9MNENBeURN?=
 =?utf-8?B?ZFBsRzkwR0JMeUdtTnExYU1GcGMwL2FFYk40Z2NmQkJScEIwQ2FYcEVSbmVn?=
 =?utf-8?B?VzZod3BpYVRXWG04Y3M3NjY1cDNaeTdoSVp2SkpDeXcreFRIZnhtNnM4Yy9m?=
 =?utf-8?Q?G2PE9f35tFWKVojQaFlifZ0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHQvUlcxUDMwMDVmV1B6TVJ5T3ROODRKQ1NtQ3VYTXNRRkVMV0YvRWZkQnJY?=
 =?utf-8?B?Ly9sOGVScEJrc1JSWDZLOU5XM0FBaElzdDRoZHNJUlF3WnREWTFoaDh4d2Y2?=
 =?utf-8?B?MmFNc3liNzFjTTdwR3U0b1c0TUkyYmEraE1XbHI4KzFSVEVJdjVONS9Lemth?=
 =?utf-8?B?Yld4Q2xFSjJjYWYzeXFvcEJnanM5QXFoY3pYOUlxUXg5aWREcE9uK2swT1I1?=
 =?utf-8?B?eEFhcDIrL0RVdENvWmxMOGxvVTlZODlYOXF3YWErUjhMeEFLSTZaS05qdDVW?=
 =?utf-8?B?aWRCT0crZTUxM2tJTU9lSDdYVUtnbExzNk93ZFFnY1J5VDlYMGlzVHNhTHcz?=
 =?utf-8?B?bGV6RUNxNG56Vzl5K1hoeGJPUmd3ZUtaVVBlZnZjYjIzL0lxTk8rcUN6RHV5?=
 =?utf-8?B?ZnplTnQ4dGp3ZS9CK1hlMmRTZ3YzWlgwbmx3Wm1zSFF6TnJSS2dBcm5qajRT?=
 =?utf-8?B?b2V1NjlhOUo1VmRVU2FxZ0xlbGVkRk90cWR6UTZYWWJ1NS9GeHVMV1dzVEdh?=
 =?utf-8?B?TUxQVFBaRVdNZUplbkhoV08xanVVbFhKT0tkcFdpVzlGVXJ5NDY3bEZtKzZG?=
 =?utf-8?B?cWFTSUpMZXJCVGFndnNmZSt4MHFaUlp2SzhOWC9xYUpYUThpWVVlSVR4MnpC?=
 =?utf-8?B?ZERpVktMeERKcU1rUWlyYVlQTkZTaWRPZ2pkcTdvVm45NE92Zm9YNEZIUDFU?=
 =?utf-8?B?OVZ6bllIKzJNeFBFMEVlVFBPeklmc2JadzFab3hqM0lkVGg0V0pTc1h2ZHVX?=
 =?utf-8?B?NDdDTkhPQnpQTk9ETXhaRXZZL0lvMmFDZEx1aE44aU5aRndrOXNNbWZURTVv?=
 =?utf-8?B?L21NRWRoeVQ5STRPZ1c2MUpidTJ3dHZsOVlrb2NneTY4Zk9OUENNVjQ5aXBq?=
 =?utf-8?B?NjBmWTFDM2hEMnAzN0ZRa2xyYm5QdTlOZWl5VTAveXp6eE0wR29VU3BHVkc1?=
 =?utf-8?B?SnhDSDNTNEtDYnNEQ0RHMUJWaWdNaDhOYTZsenhBYU1Da0ZpY3Uwd2NXbkZv?=
 =?utf-8?B?T1ZsVDA0a1JKalR4QnBWdkZxTmVhOWhIMGgvUk9nZW14dnhVaGNrWnlzM25S?=
 =?utf-8?B?dzlSR0JwU2RNb1JjRlhCMElISnVNbkYvT3g0T3FqVWp2a21rZzVCWUFMSldF?=
 =?utf-8?B?SXhtTkFjNnNLWWZiZVdFclNyTGx0MkZyNDRVWmlMeDYvVHVTZ24yZjJyTkNm?=
 =?utf-8?B?Q05mdUpjOFByL0JETHBiRDE3N3BOcHZ4bUFkelNUR1QxaXFJTmJNR0dod0RN?=
 =?utf-8?B?aEFLQ1k1M1Q0NTBoS0NYYTdTdjBZZ0hhaStHdE1PblR6eGRSRm5HcnpvSG80?=
 =?utf-8?B?ZndHQmEwTlZVUmczeFplMnhXbkh0ZHpPLzN2bTl6TUpUSURsY2w4N25WMjB3?=
 =?utf-8?B?TUdTN2MySFkxb1JSTzFoUEE1czZFcVhHcGp3ejhBOHpsOVd0dHFGT0ZiNWRB?=
 =?utf-8?B?bmh3V1RCQm8vVHZvK1N4QjVBbDJZdERSbzJFSy8yZEFUMmdTQkp3Q0lDWURY?=
 =?utf-8?B?M25IeUhhTnUxeitadDVDSXh2djZwbUlHVFZabCtFTGRSM2x5cEN0YW93M2xs?=
 =?utf-8?B?T2I0R3ZTSGR6cjhzNjBMVCszZmZaOU5iV0JtSFRYKzFkUXYvaDNDZkMxVlNW?=
 =?utf-8?B?QkkxY081SFdWSms4MUFWTzdWenBVNFJPRzFWVE5JMm9SRDBhQlhRc012dE0z?=
 =?utf-8?B?ZENYWVlEWXNhTzRBcFFFcnRaVjExaUZsVG4xNStGeWE0T0ZYV1BFZE5rRHpa?=
 =?utf-8?B?UE1wQkhsSGp0aTRjcTRnNW50YWJZSWFWOW9CejIwVkxqbHVDQ0VHUWFVeFNp?=
 =?utf-8?B?TWlqREVCUW8yQUZPZlkyUnF2S3NZdEoxZXVFYVRLWnQzT1lPZ2JLRTVQMis1?=
 =?utf-8?B?SlMybDhiTGl0VkdwdFUzM1Y2bnBoWEw5M3oyMGtnSEhTckxBV3ZocjJ6ZWIr?=
 =?utf-8?B?bWdMdUtsd21zcGNMYlR1VVBvUTZSOHh6RXBMY0huSkt2MUJtZmtjNm02UFRa?=
 =?utf-8?B?VmxnMzZpa0pSdjQ1bkIyUmk0cVlXMDMrNFFFNS9wb29rT3J6djllVHVOQzNr?=
 =?utf-8?B?cVBaUGFVNlZCdzR0UWZ1ZTgyUDB1dnhyTWtFeEVpQnl3MnVrWmxlWmtvVUs5?=
 =?utf-8?B?QzJWZThObXAvenhIVFJHMTdtTW9McTl6dVUyMGp3TXJGRUVMNVpYNVU3cjh0?=
 =?utf-8?B?NUJMZU45SUxGa0ticEZhbGtQeDBZUWtMYm5wb09WRWR2eCtUNEI3bkdub0ov?=
 =?utf-8?B?cGtBTlF2VHdsSVZtckIyWG5SWWRCTitVWGszUktsd1VpZ0M1dmVKR29jTXUv?=
 =?utf-8?B?RXgzQWhQQ0xReXBjQVRaeG5WZnJkbzk0SkxHZVRMaWFwR01ndER6R1NNM08z?=
 =?utf-8?Q?4COwbHZZKnR/qD1I=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f63aed5-a2a2-4786-2445-08de68b246d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 14:40:03.4531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aeb8/0QJFDSJcp2NUDBsWkC1v+Jd9Bt8XZeR751jJXBjXcjA/4gnBq2LvGGW5hl/QX9I9FptxaaTaZv8wO3V7v7HjEv+9lbq0kpVMV1khuqb53vozfMigddR0UXuUuTx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4519
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31704-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,suse.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,DM3PPF63A6024A9.namprd11.prod.outlook.com:mid,intel.com:email,intel.com:dkim,sipsolutions.net:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,sipsolutions.net];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: ECF4811BFC8
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyY28gQ3JpdmVsbGFy
aSA8bWFyY28uY3JpdmVsbGFyaUBzdXNlLmNvbT4NCj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkg
MTAsIDIwMjYgNDozNCBQTQ0KPiBUbzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IENjOiBUZWp1biBIZW8gPHRqQGtlcm5lbC5v
cmc+OyBMYWkgSmlhbmdzaGFuIDxqaWFuZ3NoYW5sYWlAZ21haWwuY29tPjsgRnJlZGVyaWMNCj4g
V2Vpc2JlY2tlciA8ZnJlZGVyaWNAa2VybmVsLm9yZz47IFNlYmFzdGlhbiBBbmRyemVqIFNpZXdp
b3INCj4gPGJpZ2Vhc3lAbGludXRyb25peC5kZT47IE1hcmNvIENyaXZlbGxhcmkgPG1hcmNvLmNy
aXZlbGxhcmlAc3VzZS5jb20+OyBNaWNoYWwNCj4gSG9ja28gPG1ob2Nrb0BzdXNlLmNvbT47IEtv
cmVuYmxpdCwgTWlyaWFtIFJhY2hlbA0KPiA8bWlyaWFtLnJhY2hlbC5rb3JlbmJsaXRAaW50ZWwu
Y29tPjsgSm9oYW5uZXMgQmVyZw0KPiA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4NCj4gU3Vi
amVjdDogW1BBVENIIHYzIDMvM10gd2lmaTogaXdsd2lmaTogbXZtOiByZXBsYWNlIHVzZSBvZiBz
eXN0ZW1fd3Egd2l0aA0KPiBzeXN0ZW1fcGVyY3B1X3dxDQo+IA0KPiBUaGlzIHBhdGNoIGNvbnRp
bnVlcyB0aGUgZWZmb3J0IHRvIHJlZmFjdG9yIHdvcmtxdWV1ZSBBUElzLCB3aGljaCBoYXMgYmVn
dW4gd2l0aA0KPiB0aGUgY2hhbmdlcyBpbnRyb2R1Y2luZyBuZXcgd29ya3F1ZXVlcyBhbmQgYSBu
ZXcgYWxsb2Nfd29ya3F1ZXVlIGZsYWc6DQo+IA0KPiAgICBjb21taXQgMTI4ZWE5ZjZjY2ZiICgi
d29ya3F1ZXVlOiBBZGQgc3lzdGVtX3BlcmNwdV93cSBhbmQNCj4gc3lzdGVtX2RmbF93cSIpDQo+
ICAgIGNvbW1pdCA5MzBjMmVhNTY2YWYgKCJ3b3JrcXVldWU6IEFkZCBuZXcgV1FfUEVSQ1BVIGZs
YWciKQ0KPiANCj4gVGhlIHBvaW50IG9mIHRoZSByZWZhY3RvcmluZyBpcyB0byBldmVudHVhbGx5
IGFsdGVyIHRoZSBkZWZhdWx0IGJlaGF2aW9yIG9mDQo+IHdvcmtxdWV1ZXMgdG8gYmVjb21lIHVu
Ym91bmQgYnkgZGVmYXVsdCBzbyB0aGF0IHRoZWlyIHdvcmtsb2FkIHBsYWNlbWVudCBpcw0KPiBv
cHRpbWl6ZWQgYnkgdGhlIHNjaGVkdWxlci4NCj4gDQo+IEJlZm9yZSB0aGF0IHRvIGhhcHBlbiBh
ZnRlciBhIGNhcmVmdWwgcmV2aWV3IGFuZCBjb252ZXJzaW9uIG9mIGVhY2ggaW5kaXZpZHVhbA0K
PiBjYXNlLCB3b3JrcXVldWUgdXNlcnMgbXVzdCBiZSBjb252ZXJ0ZWQgdG8gdGhlIGJldHRlciBu
YW1lZCBuZXcgd29ya3F1ZXVlcw0KPiB3aXRoIG5vIGludGVuZGVkIGJlaGF2aW91ciBjaGFuZ2Vz
Og0KPiANCj4gICAgc3lzdGVtX3dxIC0+IHN5c3RlbV9wZXJjcHVfd3ENCj4gICAgc3lzdGVtX3Vu
Ym91bmRfd3EgLT4gc3lzdGVtX2RmbF93cQ0KPiANCj4gVGhpcyB3YXkgdGhlIG9sZCBvYnNvbGV0
ZSB3b3JrcXVldWVzIChzeXN0ZW1fd3EsIHN5c3RlbV91bmJvdW5kX3dxKSBjYW4gYmUNCj4gcmVt
b3ZlZCBpbiB0aGUgZnV0dXJlLg0KPiANCj4gU3VnZ2VzdGVkLWJ5OiBUZWp1biBIZW8gPHRqQGtl
cm5lbC5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IE1hcmNvIENyaXZlbGxhcmkgPG1hcmNvLmNyaXZl
bGxhcmlAc3VzZS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXds
d2lmaS9tdm0vdGRscy5jIHwgNiArKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vdGRscy5jDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
aW50ZWwvaXdsd2lmaS9tdm0vdGRscy5jDQo+IGluZGV4IDM2Mzc5YjczOGRlMS4uMGRmMzE2Mzlm
YTVlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212
bS90ZGxzLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0v
dGRscy5jDQo+IEBAIC0yMzQsNyArMjM0LDcgQEAgdm9pZCBpd2xfbXZtX3J4X3RkbHNfbm90aWYo
c3RydWN0IGl3bF9tdm0gKm12bSwNCj4gc3RydWN0IGl3bF9yeF9jbWRfYnVmZmVyICpyeGIpDQo+
ICAJICogQWxzbyBjb252ZXJ0IFRVIHRvIG1zZWMuDQo+ICAJICovDQo+ICAJZGVsYXkgPSBUVV9U
T19NUyh2aWYtPmJzc19jb25mLmR0aW1fcGVyaW9kICogdmlmLQ0KPiA+YnNzX2NvbmYuYmVhY29u
X2ludCk7DQo+IC0JbW9kX2RlbGF5ZWRfd29yayhzeXN0ZW1fd3EsICZtdm0tPnRkbHNfY3MuZHdv
cmssDQo+ICsJbW9kX2RlbGF5ZWRfd29yayhzeXN0ZW1fcGVyY3B1X3dxLCAmbXZtLT50ZGxzX2Nz
LmR3b3JrLA0KPiAgCQkJIG1zZWNzX3RvX2ppZmZpZXMoZGVsYXkpKTsNCj4gDQo+ICAJaXdsX212
bV90ZGxzX3VwZGF0ZV9jc19zdGF0ZShtdm0sIElXTF9NVk1fVERMU19TV19BQ1RJVkUpOw0KPiBA
QCAtNTQ4LDcgKzU0OCw3IEBAIGl3bF9tdm1fdGRsc19jaGFubmVsX3N3aXRjaChzdHJ1Y3QgaWVl
ZTgwMjExX2h3DQo+ICpodywNCj4gIAkgKi8NCj4gIAlkZWxheSA9IDIgKiBUVV9UT19NUyh2aWYt
PmJzc19jb25mLmR0aW1fcGVyaW9kICoNCj4gIAkJCSAgICAgdmlmLT5ic3NfY29uZi5iZWFjb25f
aW50KTsNCj4gLQltb2RfZGVsYXllZF93b3JrKHN5c3RlbV93cSwgJm12bS0+dGRsc19jcy5kd29y
aywNCj4gKwltb2RfZGVsYXllZF93b3JrKHN5c3RlbV9wZXJjcHVfd3EsICZtdm0tPnRkbHNfY3Mu
ZHdvcmssDQo+ICAJCQkgbXNlY3NfdG9famlmZmllcyhkZWxheSkpOw0KPiAgCXJldHVybiAwOw0K
PiAgfQ0KPiBAQCAtNjU5LDYgKzY1OSw2IEBAIGl3bF9tdm1fdGRsc19yZWN2X2NoYW5uZWxfc3dp
dGNoKHN0cnVjdA0KPiBpZWVlODAyMTFfaHcgKmh3LA0KPiAgCS8qIHJlZ2lzdGVyIGEgdGltZW91
dCBpbiBjYXNlIHdlIGRvbid0IHN1Y2NlZWQgaW4gc3dpdGNoaW5nICovDQo+ICAJZGVsYXkgPSB2
aWYtPmJzc19jb25mLmR0aW1fcGVyaW9kICogdmlmLT5ic3NfY29uZi5iZWFjb25faW50ICoNCj4g
IAkJMTAyNCAvIDEwMDA7DQo+IC0JbW9kX2RlbGF5ZWRfd29yayhzeXN0ZW1fd3EsICZtdm0tPnRk
bHNfY3MuZHdvcmssDQo+ICsJbW9kX2RlbGF5ZWRfd29yayhzeXN0ZW1fcGVyY3B1X3dxLCAmbXZt
LT50ZGxzX2NzLmR3b3JrLA0KPiAgCQkJIG1zZWNzX3RvX2ppZmZpZXMoZGVsYXkpKTsNCj4gIH0N
Cj4gLS0NCj4gMi41Mi4wDQpBY2tlZC1ieTogTWlyaSBLb3JlbmJsaXQgPG1pcmlhbS5yYWNoZWwu
a29yZW5ibGl0QGludGVsLmNvbT4NCg==

