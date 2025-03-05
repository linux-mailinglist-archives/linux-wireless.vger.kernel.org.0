Return-Path: <linux-wireless+bounces-19796-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362DAA4FA24
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 10:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ACB4170C48
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 09:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E718D1FDA7A;
	Wed,  5 Mar 2025 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Qj0LI3f8";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="WwcViBiE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE182054E3
	for <linux-wireless@vger.kernel.org>; Wed,  5 Mar 2025 09:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741167146; cv=fail; b=S5InmUHw+Tq73O//SJ/BsKe3ByaEEQ/ceWlAB0eAUZPncxUsMB3AYMMlallZlNP592qn4WgnG6NaBbwhDhPCvHKWK9w6kuq06I2VhLhMbWLGL3AaHKdAmZwUNOsyoy5dgaU39JbBSRP0bvAxW7N0AoGlfEFv9+34jp+0Jyu26Kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741167146; c=relaxed/simple;
	bh=WxlF7iHxfRT6uaGHnMEzyo9DxkX0PBvDp7GU6hoXme4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=smAahmu2OX/DnsV1ADsIjcSPEZHOVVse5zjcuYIaC7cXDhaOuF/ULOfwsXPP/v93+MQ7U/yjeF9zMGl1PjANfujpqh3jhewgIhgigZQYsvt7dRRnWf9ZGhfj+BwXTHeOyZd6crA6l56Ebz8qoeUmHIpJIGA5mnF+Mb3k7ASEFqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Qj0LI3f8; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=WwcViBiE; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: bb6ab92cf9a411ef8eb9c36241bbb6fb-20250305
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=WxlF7iHxfRT6uaGHnMEzyo9DxkX0PBvDp7GU6hoXme4=;
	b=Qj0LI3f8b90O9mMQKD0+SDhIetxNcpg4w6TDOFyvc8w3rYr2o4VCl8F2GWWyHmnQ52nOpzDCzAcWI++Be0A6Ufa7oxsxKey5kI3yCv6kJhNr81EVjI6Lm1YjUsRu7WBX30Uiyn14aoh21cUd2JuoOKL9lyxuz7HUBk3UYTH/lRc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:30094de6-9a6c-42a3-9d2a-a885e6228503,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:edb8f2c5-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: bb6ab92cf9a411ef8eb9c36241bbb6fb-20250305
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 165750811; Wed, 05 Mar 2025 17:32:18 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 5 Mar 2025 17:32:17 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 5 Mar 2025 17:32:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o80+tT1SA4rdu/nosLDq65ja/r8ub7dpb/IfG/FaMAhrf588uN8WzOxlRCx3Lr1deIE27oNd2k1m9pR3qHIGg8zpJ3byDg8Z54h3gj8ytCf6DhNrCQ4WFz58302SKUFSOMjdEiJa18Vg95+IMSzVVXgaRw0CcfQNf1Tzq/gBBoW42/fuhK9YICM3xNsgn3bQXISmjxI3fYHoI8sUOq8rtOclgxyVhahx+iKSlAezp3Pue8ZZCHQbTCGCUhNfJNFHWxYGwgWcMAKtynwAlSqbapE+5+AiCKQ8Y5dSkM4MCuLGTPLV3DIpSYddt+3/H4gz8de8c6bMbSXdPVJ9IPKgFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxlF7iHxfRT6uaGHnMEzyo9DxkX0PBvDp7GU6hoXme4=;
 b=tq1picFQ1bsbtaXME5nAVAmMvalbwtD0trFgsJ51gkxpu9sZccdzHH+YZy3RNTXfeYAf3aK3Ztdt1B6hR3h2A++NGYPGc8u7RJVTWRIjrxJgUpFsxdluJ/WS6+soPkDmD1Y/Ws7poBJ3lK9e7vhMXbP86jQcVhwaFMtH/xLdboXaPPi7SY0cYUDnItOaoB0mRMxZLgbeSc8Bh7NPLUUFHfPfBeieafuUE/IbfuQD7uv4SfaxM/y2mOunyevOIJKNGR343lwAJVofBpW2RLvz66MNjX7BOGyMFvvl9mAUcjquN82SZt9rQaufmfC4Mucj8EA7zEh+m0rqays58tLoeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxlF7iHxfRT6uaGHnMEzyo9DxkX0PBvDp7GU6hoXme4=;
 b=WwcViBiEFTk541Lh6a82kpzn1qijqPQpmZQe5KsOGtzZlH+0Y5rxesKSadhDEzZcz4j68y2O7Vn/bP3hLEHruPFZ5Cb1z7LXl7SjkxUtivfsCuT6Z0t8kKy868N7oA7ywEab5dfqA4RRHkz8VxFbfSnODzqnpvkn/uvmMsdjgOY=
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com (2603:1096:4:ef::8) by
 KL1PR03MB8320.apcprd03.prod.outlook.com (2603:1096:820:10e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Wed, 5 Mar
 2025 09:32:15 +0000
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741]) by SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741%7]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 09:32:15 +0000
From: =?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
	<Mingyen.Hsieh@mediatek.com>
To: "nbd@nbd.name" <nbd@nbd.name>, "pkshih@realtek.com" <pkshih@realtek.com>,
	"lorenzo@kernel.org" <lorenzo@kernel.org>
CC: =?utf-8?B?QWxsYW4gV2FuZyAo546L5a625YGJKQ==?= <Allan.Wang@mediatek.com>,
	=?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>,
	=?utf-8?B?RXJpYy1TWSBDaGFuZyAo5by15pu45rqQKQ==?=
	<Eric-SY.Chang@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
	=?utf-8?B?UXVhbiBaaG91ICjlkajlhagp?= <Quan.Zhou@mediatek.com>,
	=?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>,
	=?utf-8?B?TWljaGFlbCBMbyAo576F55Kn56ugKQ==?= <Michael.Lo@mediatek.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Sean Wang
	<Sean.Wang@mediatek.com>, =?utf-8?B?TGVvbiBZZW4gKOmhj+iJr+WEkik=?=
	<Leon.Yen@mediatek.com>, =?utf-8?B?S00gTGluICjmnpfmmIbmsJEp?=
	<km.lin@mediatek.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2 2/6] wifi: mt76: mt7925: add EHT control support based
 on the CLC data
Thread-Topic: [PATCH v2 2/6] wifi: mt76: mt7925: add EHT control support based
 on the CLC data
Thread-Index: AQHbjM7E94N64h1gpEuJXTEW7XLswLNisMwAgAAGuwCAAQihAIAAiS6A
Date: Wed, 5 Mar 2025 09:32:15 +0000
Message-ID: <2afd81616aed2ae71404d5b4e9b82991a4ebe283.camel@mediatek.com>
References: <20250304062854.829194-1-mingyen.hsieh@mediatek.com>
	 <20250304062854.829194-2-mingyen.hsieh@mediatek.com>
	 <3c240deaec6e4a4887a8e144f558158d@realtek.com>
	 <b519659950744937075e823ed1a29ff345fa61e6.camel@mediatek.com>
	 <d9cb9f51be984407b2f684b64400faed@realtek.com>
In-Reply-To: <d9cb9f51be984407b2f684b64400faed@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5322:EE_|KL1PR03MB8320:EE_
x-ms-office365-filtering-correlation-id: 187d6062-135b-4df0-aae4-08dd5bc89d9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MjIyVkpBbVpzWHdEM3BjdEdKUlM5ZzlndTlVcFdSWDl4MVN4T05NcEw4L0dZ?=
 =?utf-8?B?cnJEamVvRnNHSjlYWnZQcUo0SHBCK09USG1HOTRPalJkSGs0TXAwTC91bER2?=
 =?utf-8?B?WVVQKyswRVQvOVZtdEVPWE9ZREhJazJoekMvanpsTjc3WGpWNnUwa0JnQjFo?=
 =?utf-8?B?WnRNaDRIT3VGM3FYL3ZsUEliTXZJOWVFTE5uVU5QRzNHd0FRZEpaVm5iOG1T?=
 =?utf-8?B?dlN5R3ducmdvbE1RZzYyblo1K2VsRUY4UVN5NVFzNlBLaDdJUHROOE1QTmIr?=
 =?utf-8?B?aDlNSzRxWisrU3VicDN1YkF2OC9zbHlkVXd6VG11SW1YaEVZYW51anB4MnBa?=
 =?utf-8?B?dTlsaUlhYS8yYTNQckk4NjErOXMrazlueVVRblF1ZHlRdzJyY014OTdEa1VM?=
 =?utf-8?B?cE9nd0haWnlZVHFxdWYxT1IvZVVoakxTRmhla1lrc0t3ajQ3STg0VVZRUXBl?=
 =?utf-8?B?c0NpdkhJSDMwcmJqeWhCQkVjQzljZ2ZLOWhFYi8wS0FkRmxsM3QrL2UvR1dm?=
 =?utf-8?B?YTg4WmxmcHJ2Ync0bHNYaWR2SDFaQ0QvbHI3alNKU1hwVXhNQXM3Y3BpNEd3?=
 =?utf-8?B?aTJaUWIwWENSQVh3cDVHMTNGeFVpWm0yQlVNWWdBUk5YS0NaZjc3aVdVUHNH?=
 =?utf-8?B?MGlZR1NHeHdTQzFab1pIZXpWUG5MREpXQk9XMDFKaGpjUEcyNUR0QlZmM1VV?=
 =?utf-8?B?SzFiU2EzbzVMc1pZcVl1bVBYajFkTlFQN3R6UUFlWGxCRGs2TlZNN0FhWTlZ?=
 =?utf-8?B?cXM1MHdKWTB5UHQyWWVULzllTmdJcGdMZHg4Smo0NFpqbGhLdExSaW1icXdP?=
 =?utf-8?B?V1QzUFpuRWVpQ1Vscm53MjBlYm82c25xTGdTSWQ4SDI2MUoyNThGZzBSSXE3?=
 =?utf-8?B?RnpyWkE4WWViWDVXbnp6cnNWK3B2MWQ3RC9hdDJSZmlnTXoxZGVDbWxsUjEx?=
 =?utf-8?B?Um9VWU84RFFFZEZzS2VPdWdRU2ZLRjB4U3hUTVo3emx5YTFab1EzRFl1allZ?=
 =?utf-8?B?cnQrMFczNFVFa0FjSmRkdUFRb3M2RzhiMmFuSDBQc1AxV25ucGVlbURBRFM3?=
 =?utf-8?B?Y0JKK2UrdUJ1cTdGRDJoa25MN0xCRG91VlgvQ0tlKzE2WkEwc3JFY3F6TmlB?=
 =?utf-8?B?REd3Mm1USUZVMnF4b1poUENrRkpwYUY4dHFreENGSEIwRHdxVmhGZ05NRWY4?=
 =?utf-8?B?KzNFNGRVanlEZ3Nkd29HazdESjdWYUhraFM1QVBlbWpydDA0TmIwaVpKU05W?=
 =?utf-8?B?L1VSUmREYzNKWXJQaUhBeWE5WVZvNmNWUnp3c0RRMzVhNVNJdVN6dzJrTWZv?=
 =?utf-8?B?Wm5QL0g5UndpS0lVYjZvdCtOV3hBaXhMY3k4SlZtOGcrSS8rbS94MjBJVXc3?=
 =?utf-8?B?WTdJKzR3clFUZ3l4aUxqcldPRGVmVmt4ODFyUzRWSVpobWVEdDNMUFhBZzNv?=
 =?utf-8?B?WkMyQmtEU0pRRDd6ZytIb05GdG1meWovYWUzcC9hK05RRVJNUGEvZUR3azNQ?=
 =?utf-8?B?T1FldkJldm5adTh6c3VaRmszT3kyTklWRTNmSGZoaURweUpFaHJ1YTBCM2V3?=
 =?utf-8?B?NloxTllHeDFWYStwQzlzSkFRakpmd3dNQU9pMnNvQjZ2UE95WFIrRFJPUFJx?=
 =?utf-8?B?ckxMS2U1aXVBZzZMelpTNUlBVTNuZkhJdEk5R0dzOWwwTFd1N2M5Vk1FTXEw?=
 =?utf-8?B?RXVCR1UzejBrYUpJL09JaERGWFVScHlsNmN3STlwS255N1Y1R1hPTWxuNEdq?=
 =?utf-8?B?WlpOblhkbE9zR1A5Q3ZDUWhVdmpub2x3ekpNN0tVRmRMdjJSeUNnQmpTYkI2?=
 =?utf-8?B?eXZNa1JYNXVkWVlGU0VuYzhYbVA0SzFSQ05pckw2U1RtV0VPRG55TVo3MFFY?=
 =?utf-8?B?ZEkrSkhpM3FuenVGR0xkeWZUM1pBQWlYTkU3THZMbTU0c0Joa0xPcUNRbW9S?=
 =?utf-8?Q?f1QumTLRDea0z7VHao7FwaEsC+6YaDvb?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5322.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2pMSkp4VmRxL2VJNDVuT0ZzZ0xyVWp5MHROWnBuSGNsSnAydFFsQjdWdFVR?=
 =?utf-8?B?dHkzT0tXK240bFJEU081QXFiOUtBVDl3eExXd1ZuczlqdTNtN1J2RUFwakpQ?=
 =?utf-8?B?c0tsNXJselNvWlNFOGIvZGE5YXc0SEUra2NMaUpHZDMvOEltWEMvSTNIbm1u?=
 =?utf-8?B?LzIzTk8vdGJIdldjSXFtQklFaDhLR3lwWEVoUThYTG1wQ1JvcVdYbVB3bkUw?=
 =?utf-8?B?azlJY204czRTbmlVTGgycmNwbmhBb3pFK1p5ZVBLeDVPVXNVZTNMNngvWURM?=
 =?utf-8?B?R0FJSnhMUjVmUi9tdnhzdHRQRzNHVms4dHU1Y0gyNmZNRHRlZHJYUEJvQ2FP?=
 =?utf-8?B?NmVmSlFYb1ZnMWFoL2liV2taSWlWS1ZuWFRpVVByc1czdmh1ZFFadklvY1NF?=
 =?utf-8?B?bEZNN0xsWERocFRFeXFONmo3M3FadjF1bHdJeEZJT0o3cDZaS2dHRTAvVGVp?=
 =?utf-8?B?N3hWQWZsVVBrWnZqSFhIMEc4YnM2NUMwQUFVWENRSlJOaGpOcGRrVzZsNzBW?=
 =?utf-8?B?akUwNWxkcmxSc3F5ZG9KREdyazdvM0hDM2J3NDZEaFNsRjFBVTNqV2pjUE5h?=
 =?utf-8?B?MnpILytUeTJJYlBicjQ5Y0QvbS93ei9DRjFqRjNxK28wSVRLRzFOaE0zbFhQ?=
 =?utf-8?B?WFd0Mk9ibU5yUmY4RmJuTlFJenVvTlQvZ3UxNmwrVUVaQ1M3YWdTVjBYU2Nh?=
 =?utf-8?B?OFJWOVRjci92YXNXUjNiM3lsOHNDWlVFbE83ZENlZ3RJelF5Tzc0SXBUTnlm?=
 =?utf-8?B?aU5ORlFyK2toRXVwRy9uVjRrZTNFaUY4YmVDRmJydWdmM3ZrdytFUjhMcGlM?=
 =?utf-8?B?eW5HUTE1cFpLczJycDFRZjhQZml3V1BzTDVtSU5jNVBPWDJ5MThwOGNDaTYr?=
 =?utf-8?B?OWhzYWVrUGpTSUxIdDFNM2E1WHA0TlNOYTk2TXpHWDZhU2crZGI2MEFNcUsr?=
 =?utf-8?B?c251dlBLNkNKenJwaC9wWTY2UG4rSHpmcXYvMW9mcWFqUHZGSG9MK0lrZWJ4?=
 =?utf-8?B?M1ZKV2VRZE56YVh0Z3hxQktqOFdidW5YTmIxdFBoMTdSY1RWWHFPbmF1QVNK?=
 =?utf-8?B?VXYyRitQNlZsVyttcWdPVTBDUllDeXpVUGIzS1NLckV6NXJLV2hkNDdlWW1i?=
 =?utf-8?B?d3M3VUs2OThrSnBsczNOejZZNU92UUtNUmJTUUJMS2hCYTZJUnNqb3hubGFL?=
 =?utf-8?B?cnBhY3hnazcveGF4d0FwMFRLYldrNFBoNzN4U1ZzVHNtREE4SnQ4eDRhNHJ5?=
 =?utf-8?B?VHZNK3BwRzh4WWhNYzY0cU1QaUptWHBpN3k2a2JNNVc4STducUlNMnpxMllF?=
 =?utf-8?B?ZGZ2UEJ4cnRYQjFvOWQ3ZHJHc0hXWDVucTh5cjRHNER0eUUrTkE2TjJ3WFVL?=
 =?utf-8?B?ZXRadVAva1FhTW9FNHphRmpwNy93d1g0VXdOTlI4L1l3R09hUXd3d2I2Rko0?=
 =?utf-8?B?VjY5QVc4RlNFd3psU3VzOVFtZnVuUjJsd29PRi9FWWlkcm1zZ1NsWnVRelJm?=
 =?utf-8?B?d0hER3ZTMm5XM2ptWHFrT3djV0tTNTJnTHh2ZHo3LzdzMTlzMkhpbmRBSktR?=
 =?utf-8?B?R3AzdU5YQkxWdjVrNWd1K0dGdERQbmIxTzVVVUdHcEFuRGZQMURiUFc1dDVz?=
 =?utf-8?B?QU50UXFCUW9WVE0xTFF2NGlUdU1OakM1c1pyc0txeTA2MklsUHVUYS9Gakda?=
 =?utf-8?B?NTFKWnVvUGhWREpIV2xVK2hUVmJqeHZIUzNSMXE2K05hZFdiM0tzRWhVUHcx?=
 =?utf-8?B?SGN6MWJycEFtUVhIVDFET3NYMm1aSXgzTTRTR1RSNiszaEhuZEwreG9jSzhH?=
 =?utf-8?B?ZFhFa3MzUjhMZW1aQ0Urajc3T0kybjhOTXFTUktiT054YmE1bzIzYzFaV25m?=
 =?utf-8?B?TThRYzhXSHM0OWExMUFZOGg5R3M3SUdGZksyQTZGZWYzTzFlUUdWczc4NjhY?=
 =?utf-8?B?ZHEwbTgyUXFDU3JsUGpObEIzY1ZiN3k2cUdtaE9iVnFFUFljVkNyQ0dKdUw4?=
 =?utf-8?B?NTBSVUI5ZXk5SzZnM0oybXBPTWRzSENqUXdBSmNpT3Z1Q2RyajI1T1dseXdw?=
 =?utf-8?B?d2VsdzVTTUFlSyt5ek9VM3U2QUlhUFdTQTVlMUYxWlNSbTB5VUU3QldZV2g3?=
 =?utf-8?B?QnlSN3lMQzdRVC9MOGtBZW4rOGRkUHZMdmlMNEUwRjV6Z3hDNEg0bXg2Qm4r?=
 =?utf-8?B?MkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF70C41A88AEC042BC49DAC98B3C02B7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5322.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 187d6062-135b-4df0-aae4-08dd5bc89d9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 09:32:15.2165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i1w6zXWKIONMQdoWfjuFHGduF/kjzqgZ2fGdTFaYADl18zuvwR78e2i9cFffHRlHjBEpKw4fViwE0SabriJ3LMzO3JE+cCs0S5JfTMw0CFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8320

T24gV2VkLCAyMDI1LTAzLTA1IGF0IDAxOjIxICswMDAwLCBQaW5nLUtlIFNoaWggd3JvdGU6Cj4g
Cj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW50aWwKPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250
ZW50Lgo+IAo+IAo+IE1pbmd5ZW4gSHNpZWggKOisneaYjuiruikgPE1pbmd5ZW4uSHNpZWhAbWVk
aWF0ZWsuY29tPsKgIHdyb3RlOgo+ID4gT24gVHVlLCAyMDI1LTAzLTA0IGF0IDA5OjEwICswMDAw
LCBQaW5nLUtlIFNoaWggd3JvdGU6Cj4gPiA+IE1pbmd5ZW4gSHNpZWggPG1haWx0bzptaW5neWVu
LmhzaWVoQG1lZGlhdGVrLmNvbT4gd3JvdGU6Cj4gPiA+IAo+ID4gPiBbLi4uXQo+ID4gPiAKPiA+
ID4gPiAKPiA+ID4gPiArdm9pZCBtdDc5MjVfcmVnZF9iZV9jdHJsKHN0cnVjdCBtdDc5MnhfZGV2
ICpkZXYsIHU4ICphbHBoYTIpCj4gPiA+ID4gK3sKPiA+ID4gPiArwqDCoMKgwqDCoMKgIHN0cnVj
dCBtdDc5MnhfcGh5ICpwaHkgPSAmZGV2LT5waHk7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoCBzdHJ1
Y3QgbXQ3OTI1X2NsY19ydWxlX3YyICpydWxlOwo+ID4gPiA+ICvCoMKgwqDCoMKgwqAgc3RydWN0
IG10NzkyNV9jbGMgKmNsYzsKPiA+ID4gPiArwqDCoMKgwqDCoMKgIGJvb2wgb2xkID0gZGV2LT5o
YXNfZWh0LCBuZXcgPSB0cnVlOwo+ID4gPiA+ICvCoMKgwqDCoMKgwqAgdTggKnBvczsKPiA+ID4g
PiArCj4gPiA+ID4gK8KgwqDCoMKgwqDCoCBpZiAoIXBoeS0+Y2xjW01UNzkyeF9DTENfQkVfQ1RS
TF0pCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBvdXQ7Cj4gPiA+
ID4gKwo+ID4gPiA+ICvCoMKgwqDCoMKgwqAgY2xjID0gKHN0cnVjdCBtdDc5MjVfY2xjICopcGh5
LQo+ID4gPiA+ID5jbGNbTVQ3OTJ4X0NMQ19CRV9DVFJMXTsKPiA+ID4gPiArwqDCoMKgwqDCoMKg
IHBvcyA9IGNsYy0+ZGF0YTsKPiA+ID4gPiArCj4gPiA+ID4gK8KgwqDCoMKgwqDCoCB3aGlsZSAo
MSkgewo+ID4gPiAKPiA+ID4gd2hpbGUgKDEpIGNvdWxkIGxlYWQgaW5maW5pdGUgbG9vcCB1bmV4
cGVjdGVkbHkuCj4gPiA+IEFkZGluZyBhIGNoZWNraW5nIG9mIGNsYy0+bGVuIHdvdWxkIGJlIHNh
ZmVyLgo+ID4gPiAKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBydWxlID0g
KHN0cnVjdCBtdDc5MjVfY2xjX3J1bGVfdjIgKilwb3M7Cj4gPiA+ID4gKwo+ID4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChydWxlLT5hbHBoYTJbMF0gPT0gYWxwaGEyWzBd
ICYmCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBydWxlLT5h
bHBoYTJbMV0gPT0gYWxwaGEyWzFdKSB7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5ldyA9IGZhbHNlOwo+ID4gPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiA+ID4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gPiA+ID4gKwo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIC8qIENoZWNrIHRoZSBsYXN0IG9uZSAqLwo+ID4gPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGlmIChydWxlLT5mbGFnICYmIEJJVCgwKSkKPiA+ID4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gPiA+ID4g
Kwo+ID4gCj4gPiBIaSBQaW5nLUtlLAo+ID4gCj4gPiBJIGRlc2lnbmVkIGEgZmxhZyB0byBwcmV2
ZW50IHRoZSBpbmZpbml0ZSBsb29wLgo+IAo+IEkga25ldy4KPiAKPiBQZW9wbGUgYmVsaWV2ZSB0
aGVpciBjb2RlIGlzIHNhZmUsIGJ1dCBzb21laG93IGB3aGlsZSAoMSlgIGdldAo+IHVuZXhwZWN0
ZWQKPiByZXN1bHQuIEFuIGFsdGVybmF0aXZlIHdheSBpcyB0byB1c2UgZm9yLWxvb3Agd2l0aCBs
aW1pdCByYW5nZSwgbGlrZQo+IAo+IGNsY19lbmQgPSAmY2xjLT5kYXRhW2NsYy0+bGVuXTsKPiAK
PiBmb3IgKHBvcyA9IGNsYy0+ZGF0YTsgcG9zIDwgY2xjX2VuZDsgcG9zICs9IHNpemVvZigqcnVs
ZSkpCj4gCj4gSnVzdCBGWVIuCj4gCgpPay4gSSBnb3QgaXQuIFRoYW5rcyBmb3IgdGhlIHN1Z2dl
c3Rpb25zLgpQZXJoYXBzIGkgd2lsbCBtb2RpZnkgaXQgaW4gdGhlIG5leHQgdmVyc2lvbi4KCj4g
PiAKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwb3MgKz0gc2l6ZW9mKCpy
dWxlKTsKPiA+ID4gPiArwqDCoMKgwqDCoMKgIH0KPiA+ID4gPiArCj4gPiA+ID4gK291dDoKPiA+
ID4gPiArwqDCoMKgwqDCoMKgIGlmIChvbGQgPT0gbmV3KQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHJldHVybjsKPiA+ID4gPiArCj4gPiA+ID4gK8KgwqDCoMKgwqDCoCBk
ZXYtPmhhc19laHQgPSBuZXc7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoCBtdDc5MjVfc2V0X3N0cmVh
bV9oZV9laHRfY2FwcyhwaHkpOwo+ID4gPiA+ICt9Cj4gPiA+ID4gKwo+ID4gPiAKPiA+ID4gWy4u
Ll0KPiA+ID4gCj4gPiAKCg==

