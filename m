Return-Path: <linux-wireless+bounces-19747-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44770A4D8B9
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 10:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C384016DD17
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 09:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC2B1FDE15;
	Tue,  4 Mar 2025 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sA6VUoo0";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="AoERs4q8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11FE1FCF44
	for <linux-wireless@vger.kernel.org>; Tue,  4 Mar 2025 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080862; cv=fail; b=Q6tv7CZmd/VFgdz0J/PS8I5VX0wJ3NHiv/S/dzUhJlz5nKvgtZK5DtNSObvhnQyyztyaZJ2Rgghk/pyGX2HfeyWLEefs6XxU/aNEhGKTNBuzpq9w9pZCgBBNRngmGJ4q3ZiNO+yylwNi1hzyB0nb148+qpjlA1ZjZOMYsO+tGE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080862; c=relaxed/simple;
	bh=IRr+k/sw7vqv2BrCzAJnLuIoozPTttznfCHjhWMghrI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q0PbWOAD36Fh+VKyahmBvxzSHdyVYEkO3l20tfWa9uewY66xIcEJ17U0Sv8tfWrAxFMuM6W1yq6C+CxNp8eq/tWpjVs4bS1/TGQGNfoK1avQiZ4feZfdGmQJP1aMT9TUz5T7a5BksS8MIUxikjiWtuf69NISu5D951rfxpAe6Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=sA6VUoo0; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=AoERs4q8; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d5672f14f8db11efaae1fd9735fae912-20250304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=IRr+k/sw7vqv2BrCzAJnLuIoozPTttznfCHjhWMghrI=;
	b=sA6VUoo0C2tAnn36SKniTandX1vtCeQJygo+rIxDX3r3MkbSYl4UnzaeRr3aDgNcRyuxQ3vE4DZD3n2fe9AKhxSsoJvNKdh4vYOZDAH2tFXM+zz3nXGUjNp7zXezObV9OEP6RI9wi1hr9Urbja/7jZc/Spc4Teha+vxxYeksKbk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:cc56ac47-a4e5-440c-8dfc-c96bf33e0ac3,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:c1e8cea4-5c06-4e72-8298-91cabc9efadf,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d5672f14f8db11efaae1fd9735fae912-20250304
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1095933244; Tue, 04 Mar 2025 17:34:13 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 4 Mar 2025 17:34:12 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Tue, 4 Mar 2025 17:34:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1jCxEFMyKM0Tu43tipygOv49ayoXFn2BzYEs+VsYJ6k/K+QMyfZBdS/k6N6d+QUq3Nj5VzPTA0qv8E1XP9+GjJR6LH/pxrba9c4TQf407/iLomYpnvFh3VlNFueRV9KSoMXE/bmsMfyHHW25lKLnsXq0FtUggqkv9A+tHhRGUlSFKAN06h4+Po0Y+eZ4fzIgdLedKhOaOdYxLdg7D0Xe+idUYn76HIRhASfR5VOup2TYZiBw0CTH1e+a9FSquVUgxMQI9253Ps3XOc1BMey+wTJ+NiRs2ZITYtnlHKYDODDIsWh0JVwfsMpMgCZv1+BF6J/56FpD24gEeu0wG0miA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRr+k/sw7vqv2BrCzAJnLuIoozPTttznfCHjhWMghrI=;
 b=au1Ki3jNUMsWgKpOTh4BkB3WAfN6QDjH37VQ9Ud13avPea6v3PmBgr57G5PHgvAzcugUyGXc48trFywuV4Cb3FmIhvng8ZuEdg/AzKHQPp4m/Z1AiFkBtKkZgOBSa89g5tu87TID7p9YU/ijX/qjwiVXV2PRStSj2FfbGq0Jcq721Kh+sCTp5opfR5VtD0xBY8ZXqJ3/H1/wh0Xlq9CZkWiXS/TdzF5nLIoQG6ksjWOZqf3yoQMm/RXzSNFDbcG+ry2jeQXntsEk9eVueNgUe/1K7Y+yJmVM50jVLVA2CKyVB59ucQ40Z5lYAd33bukXUsoot/8bIBJMs8ma8w9/xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRr+k/sw7vqv2BrCzAJnLuIoozPTttznfCHjhWMghrI=;
 b=AoERs4q8RF6LQh4Yfni3VwnLUdSjizjuIihp0bHFUBtT8Gwqn7WZYCDi2/5+mYacMbrqmFBxBD19dTiDqTYMMtBoHHjkf30/RioLNJG6vKuP9rTfXG/Nm7alYa62Z8j8MntGtxPOlEZBkFcbWCUj2PZxM92c0vgxfG6zF4fZ3WY=
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com (2603:1096:4:ef::8) by
 SG2PR03MB6610.apcprd03.prod.outlook.com (2603:1096:4:1d9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.28; Tue, 4 Mar 2025 09:34:09 +0000
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741]) by SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741%6]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 09:34:09 +0000
From: =?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
	<Mingyen.Hsieh@mediatek.com>
To: "nbd@nbd.name" <nbd@nbd.name>, "pkshih@realtek.com" <pkshih@realtek.com>,
	"lorenzo@kernel.org" <lorenzo@kernel.org>
CC: =?utf-8?B?QWxsYW4gV2FuZyAo546L5a625YGJKQ==?= <Allan.Wang@mediatek.com>,
	=?utf-8?B?RXJpYy1TWSBDaGFuZyAo5by15pu45rqQKQ==?=
	<Eric-SY.Chang@mediatek.com>, =?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?=
	<Deren.Wu@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
	=?utf-8?B?UXVhbiBaaG91ICjlkajlhagp?= <Quan.Zhou@mediatek.com>,
	=?utf-8?B?TWljaGFlbCBMbyAo576F55Kn56ugKQ==?= <Michael.Lo@mediatek.com>,
	=?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>,
	"Sean Wang" <Sean.Wang@mediatek.com>,
	=?utf-8?B?TGVvbiBZZW4gKOmhj+iJr+WEkik=?= <Leon.Yen@mediatek.com>,
	=?utf-8?B?S00gTGluICjmnpfmmIbmsJEp?= <km.lin@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] wifi: mt76: mt7925: add EHT control support based
 on the CLC data
Thread-Topic: [PATCH v2 2/6] wifi: mt76: mt7925: add EHT control support based
 on the CLC data
Thread-Index: AQHbjM7E94N64h1gpEuJXTEW7XLswLNisMwAgAAGuwA=
Date: Tue, 4 Mar 2025 09:34:09 +0000
Message-ID: <b519659950744937075e823ed1a29ff345fa61e6.camel@mediatek.com>
References: <20250304062854.829194-1-mingyen.hsieh@mediatek.com>
	 <20250304062854.829194-2-mingyen.hsieh@mediatek.com>
	 <3c240deaec6e4a4887a8e144f558158d@realtek.com>
In-Reply-To: <3c240deaec6e4a4887a8e144f558158d@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5322:EE_|SG2PR03MB6610:EE_
x-ms-office365-filtering-correlation-id: 477efc34-ce2f-449f-987f-08dd5affb728
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZHZzNkJvQmltWXM2UXJwMmlKQ0dGZWh1eTdVK0F5SVVlY0RTVGkwV3owbmZa?=
 =?utf-8?B?L3ZlSys1UElaUlplcVBKakZmZFdZSGw5M0k4NmNOV3hhNDhVRy81bjYzcUNF?=
 =?utf-8?B?OUlINGJuMGVhUEdzMk9LQkJud2J4dWlIUU5BeDVLRWFyNVFQbUxLUTFEK2V3?=
 =?utf-8?B?aE5wTzQyNjVWUXY5TENYQzBxeFNlWkZ1U3NiMXI3Y1cwTFY4RE5TcjAwNStm?=
 =?utf-8?B?dEYzOXJ2MHR3d01aMng1dzI0aDJLOU1jeHl4WURUS2d3Nk1xa2NqQUc3cUxt?=
 =?utf-8?B?WHlyZjZaaWh3WEpXZUJ6VU9hUjRQb05nSnp6OElMUnFmQUhvMUpRSVpZdlhT?=
 =?utf-8?B?SitiQmE4a1ZoekxWSldwNlBHMDFmbUluY2lBSVh5dERmSm1TS05EbUw3Q1d4?=
 =?utf-8?B?Z3JuaC9vZ3ZUR2hlTTJOU2JRbjhMcFV0SnlQdms3VnNvVCtMQ2RyWVhUNEN6?=
 =?utf-8?B?R1B4ZlhJM2V6L21KRFAzMStwM2V0Qmt1a2lieHA3Y0liWFc4K05ua3l2MFRx?=
 =?utf-8?B?WkhIR21CTm1IeDJZZkgrRi9ITVhsaVFLNjFydHFQRHMyM09LN0tvU095WGV0?=
 =?utf-8?B?RGo2dlA2U1B5ck9Za3RKUjhKSkg0bTRkaEQyTlNGM1VTK0FjbERrOURvVFBS?=
 =?utf-8?B?REV4YUdtcFlXSXg4OStwWTFGREpDSTVPcHVHZjBmdUJzeis5Wm5TUG5NOHl2?=
 =?utf-8?B?R0xXMXFLUUFQcHJRRGlwdlM2SnlvWTlFUmUvY2JId3hJQ2gxNnpUbE9saGRL?=
 =?utf-8?B?TmU5TzM3UU0vMjRMYjVRVU83Vkx6WVJmK1gycXRiSVJZaHNBR1BBcEE2dWMz?=
 =?utf-8?B?UW1sZ2dYUWVDUzZEcUI4eWY4NUZMRnM5YjAyT0NXeE1KZjh0eTlURE52WGZI?=
 =?utf-8?B?d2NSYXYySERDYjRNMUFMc1I1MWQ4ejhEZXFyQWJ0K3dtYnltWjR5akJsYmxk?=
 =?utf-8?B?N3lvOW9aQWJZdGI1QVNmNzhwWjlRYklJcGpMOE83NlNnaHJERWljMXBzdjls?=
 =?utf-8?B?MXZpeE1qNjJhVnkvMjVsUFZPUWI2T3VHVkZJOXV1TVpTaUlBY1lFN1dDL1M2?=
 =?utf-8?B?Zks1Uy9MNkR5WlV3NGhubFRreUxqYWg3Tmp4SCt3T3JBQzZ2VXNiV0hzbVRV?=
 =?utf-8?B?Ry96OTV6Y096dFpmb0VHdVVYUDYyTFA3eHVPVGtndGtpRU9QSSt1OE5COCtr?=
 =?utf-8?B?L1Q0cDJWSm9ETEdwOUJpclJjZDFiaDNSMVlCVWRrMGdIem80RE9GTDkyRWFs?=
 =?utf-8?B?Y3B3QnNuUFpQLzlON1BZc25DQlJmTm9taHlObklXaUpERHV5NDRrdEtmL1Z2?=
 =?utf-8?B?endvVWxTRVI3Z2FZVWxVRU1xZEdoZWlvYUo5dU9nbjVpUWpVRlV3UnpUaWVt?=
 =?utf-8?B?SEJnYnFOMmJDd2VuWE1Id3FGamxGQWQ1dWpFbjdSSVZGVnArRllUZ3UrbzBn?=
 =?utf-8?B?aU1OaGg4SDBtMEVYM1lrUUc5dVBoSEpralJ6U0lIYW43UXNXYVc2T3dWcmI2?=
 =?utf-8?B?d2taQWs5UDYrT3RMQkR5U2NTRzRYazNHc0VqbTlNWlhOL2V1WjUwRkloM0RR?=
 =?utf-8?B?UmExL2NaY05INmtrblhGd3BPRFRGS1hkMm9XZm9SdUdZUVI2WWFTWWR5aUsv?=
 =?utf-8?B?NHQvM3FJTzR4VXJyN0MwOStJTHpzTXh0Qjk2cVdQY3V0QWpQS3ZQQTdxaTlP?=
 =?utf-8?B?R3Q2Y25sc2pCYVJJNmRmYisyYXhielVXRTYxLzQ1T2NETElRQVlwMUpHT3li?=
 =?utf-8?B?Z1QwZS85K2FoM3NzelBiZ2FCei81WnFlNjRvWjJPSFpvaDd2RS8rVHo5SmFy?=
 =?utf-8?B?N0lWaWl5OE41L1IrOHE3NVF2Q0pWUTVuSTR5V3dkMUxNYjNtRUxidHIvTStI?=
 =?utf-8?B?S0toU3hMRVBJazZCNDVvRS9kTVduYmVxOGQ1elVQclZkdzZqTFpzZkFrdjRB?=
 =?utf-8?Q?GLBKv0TKV0EbW2bATDtrjlHUtx2fGSrV?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5322.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nk5ER3NiRTRYaWtkY09EOThtUkg0QmpOMzZuUHBMVFRwTGVkcG13RTdJcENu?=
 =?utf-8?B?NFoyVjNVNllENlF4dWhjelRKcEVHY2daTC9sRVkwbENGZEJWeXNVYmltMWZU?=
 =?utf-8?B?RW5lWkxMaDd5cmdvZmJtSmVxOG1hUDU2WVBmTDFVVU91Smw5N1VUbXRnVnNH?=
 =?utf-8?B?MEYzK1lPL1RoWTd5SHVnRld1d005VFNHVXlGVktPcmtvZXpEaWlCTUdkUzRt?=
 =?utf-8?B?K3VxNmRqazVBdWFBTHYzK3pKS3U5SFVIekYzSE11NDJqUlFSazByeGhyeTFW?=
 =?utf-8?B?OWtVajZsdUJnUFMxaC9Ya1crV0MxekFhNjErNGNQY1lMejVIWEpjdm9Ybnho?=
 =?utf-8?B?c0FhN0ZZMU16Z2ZFbVY0K0RaM05HYmNjMmNjQm9wWU52QkJPdG05L3VlNHhl?=
 =?utf-8?B?aWYxenpHMk9UUHhaTmFndjluQk00VzJ4b013Z2VEMTYxaSt4dXUwS0RwaUU0?=
 =?utf-8?B?NVh2UElTcVpsQUpTbkJucUN1Z0t5UVM4dHFCNXo0NkE5ZzRza0l1SGVnYnRa?=
 =?utf-8?B?ZC94OVVDdSt5bTQwK0JrbnZDY01VY3RoYTFMenBpWC9XM2NaUC9BVFl6Ly90?=
 =?utf-8?B?SVEwNHFzL003ZnVzZFdscGcvMnIzQktiQk5XNWJ0Q3NQN2JYTHltTGdMVTZs?=
 =?utf-8?B?ajFYZzlMVDV3OHVtMWFRMWh2S0JTdS9xSEViTEJnakxnbldNYmNhN0kyVnU2?=
 =?utf-8?B?cWl4T0ordEFDR01WbWdkdDdqVzQ5S3J2MnlOQWRPNjBKZTBRbWwrNm5JSzdq?=
 =?utf-8?B?L09ScW03M0drcEppU1gwZ0RlOVJKNHdvZ3V1RThwL0xFVnBVdzRsQUptbEJj?=
 =?utf-8?B?WjltTkRJbzV6cmdMb29Fc1JtVFdVVUlTeW0yUERFNGhYNzIyaWd5bHdxY0th?=
 =?utf-8?B?R3hZdkVCUjlwZ2FUWG50SUJvbVM5OUYwS0RDQ3RydkJDOGViVEl1bktaemxI?=
 =?utf-8?B?VnVQSThreXpjVWxicTVObVRzNUNaZmd0VEhrYnRqd3lQYzR1NXRFK3dhVDk4?=
 =?utf-8?B?UFZ6dC9IVnZoRGpUanFXTFZrdFUyQ0d1VUszK3J4N0xzR2pPQ240c1VlRGdZ?=
 =?utf-8?B?U2QwVGZWSTZQaU82aVVsaWRmNEFHdHR0Qmpxb0NPQlRrcVFqRHQ2cnNvbFRM?=
 =?utf-8?B?TWVmN3NxemJLUXgwUSttRTJWRHBONW5PNWNlUGkxUHVVVjJvWCt2YVpoaXYw?=
 =?utf-8?B?WHFhZTNvWHNSSTZVeUlwdWN0YVlCNnU5a2JmVzlhRldpalNib29UN01mMTVM?=
 =?utf-8?B?UVlQV0J4YVA1TXQ3WXlkY3Vod3Q0M3o1RytEZ3VjV3pycGo0RXhESE1Ea1lG?=
 =?utf-8?B?UmZUZ0xhMDY1anZraHhrbVFSNnY0UmVuTWRlcHFFZEN4MWV0eFY5NXU1MTc0?=
 =?utf-8?B?cXY2cldTak1KMVM1dXRCT0Y5V2UrMmh1RTVOYVlYRnRXNU8rZThPemd1azNG?=
 =?utf-8?B?QmNrYjV1emdkVEZiRzBGSU54dWtjMy9BdHNobkl4dmxRczNzc1RxV2t4dEQw?=
 =?utf-8?B?RE15QUwyaXhZcEo0UFdLVkRUanhkWWFLU3JyYTNDenEzYkRFZzRwTHhXcE13?=
 =?utf-8?B?N21LcXlIWDlKSjBGdU9mN25jYXllUDMyd00wL1VNejZQYTlTZng5WVk0cS9O?=
 =?utf-8?B?dXhoREtDcG9LM05ZZStVZ3p4Q2tFZTBsZXM3UDhURmxjZTdCWGNadGd1eHRP?=
 =?utf-8?B?Vm0yL3crTy9Gb2tycS9DNk56R1ZvS3hPTkR2OU9peEhnanZCbG1aNGo5R2xw?=
 =?utf-8?B?K1ArVGhqczBwQzQ5TUcrWGlpdkdNbUwySXNIVmdvVnNxbnpWMStmRU94T3pV?=
 =?utf-8?B?eHdNbDRBZ0g3MFRvUkg1VEdyQjlIRVk4L1paQUJDdGJNMlhuNkszb3Fpb1VU?=
 =?utf-8?B?ZHVxZ2E2NTBmSGhUREFRVUxFMlN3Z0Y5ODluRk1qQ241azRFc2g3WDYvUHJh?=
 =?utf-8?B?NVFORG5MTkVlUVNVYjEwbDkzVGlYZFR1ZGYvYkYxMWs2Z0wyVzZ0NnBzYWVr?=
 =?utf-8?B?NTJtUFh4NUVIOFJKZ081V3l2VHI4OUNabHFESFVzWFM5cWQyK0tZVE1mKy9a?=
 =?utf-8?B?UHhXWGtJOUFyMzRYSndWUTNUYWFTbEhQMHlVYkpNR2VqTkxXTHd5WlJ1UUlC?=
 =?utf-8?B?ODM1NkZXc3NnajZYbG5qK1QyY09XQTczZDdpek1NK29xOVhvT0Q5VXo3Nitr?=
 =?utf-8?B?clE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CEAA825A3EF28547A42F8BCFD6B59130@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5322.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 477efc34-ce2f-449f-987f-08dd5affb728
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 09:34:09.2122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KC1ZCdiu4zGSJ8oGoH1+osCntqAXb3edL9TV0XOYx8UPVtj1Da4Na/eW/VRNkwuOclsUZ0eCNfK1jSzNpQiiu9JxhTHXzXjJjiW0jzWq1Eo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6610

T24gVHVlLCAyMDI1LTAzLTA0IGF0IDA5OjEwICswMDAwLCBQaW5nLUtlIFNoaWggd3JvdGU6Cj4g
Cj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW50aWwKPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250
ZW50Lgo+IAo+IAo+IE1pbmd5ZW4gSHNpZWggPG1pbmd5ZW4uaHNpZWhAbWVkaWF0ZWsuY29tPiB3
cm90ZToKPiAKPiBbLi4uXQo+IAo+ID4gCj4gPiArdm9pZCBtdDc5MjVfcmVnZF9iZV9jdHJsKHN0
cnVjdCBtdDc5MnhfZGV2ICpkZXYsIHU4ICphbHBoYTIpCj4gPiArewo+ID4gK8KgwqDCoMKgwqDC
oCBzdHJ1Y3QgbXQ3OTJ4X3BoeSAqcGh5ID0gJmRldi0+cGh5Owo+ID4gK8KgwqDCoMKgwqDCoCBz
dHJ1Y3QgbXQ3OTI1X2NsY19ydWxlX3YyICpydWxlOwo+ID4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3Qg
bXQ3OTI1X2NsYyAqY2xjOwo+ID4gK8KgwqDCoMKgwqDCoCBib29sIG9sZCA9IGRldi0+aGFzX2Vo
dCwgbmV3ID0gdHJ1ZTsKPiA+ICvCoMKgwqDCoMKgwqAgdTggKnBvczsKPiA+ICsKPiA+ICvCoMKg
wqDCoMKgwqAgaWYgKCFwaHktPmNsY1tNVDc5MnhfQ0xDX0JFX0NUUkxdKQo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBvdXQ7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgIGNs
YyA9IChzdHJ1Y3QgbXQ3OTI1X2NsYyAqKXBoeS0+Y2xjW01UNzkyeF9DTENfQkVfQ1RSTF07Cj4g
PiArwqDCoMKgwqDCoMKgIHBvcyA9IGNsYy0+ZGF0YTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqAg
d2hpbGUgKDEpIHsKPiAKPiB3aGlsZSAoMSkgY291bGQgbGVhZCBpbmZpbml0ZSBsb29wIHVuZXhw
ZWN0ZWRseS4KPiBBZGRpbmcgYSBjaGVja2luZyBvZiBjbGMtPmxlbiB3b3VsZCBiZSBzYWZlci4K
PiAKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJ1bGUgPSAoc3RydWN0IG10Nzky
NV9jbGNfcnVsZV92MiAqKXBvczsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGlmIChydWxlLT5hbHBoYTJbMF0gPT0gYWxwaGEyWzBdICYmCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJ1bGUtPmFscGhhMlsxXSA9PSBhbHBoYTJbMV0pIHsK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZXcgPSBm
YWxzZTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBi
cmVhazsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPiA+ICsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIENoZWNrIHRoZSBsYXN0IG9uZSAqLwo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJ1bGUtPmZsYWcgJiYgQklUKDApKQo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+ID4g
KwoKSGkgUGluZy1LZSwKCkkgZGVzaWduZWQgYSBmbGFnIHRvIHByZXZlbnQgdGhlIGluZmluaXRl
IGxvb3AuCgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcG9zICs9IHNpemVvZigq
cnVsZSk7Cj4gPiArwqDCoMKgwqDCoMKgIH0KPiA+ICsKPiA+ICtvdXQ6Cj4gPiArwqDCoMKgwqDC
oMKgIGlmIChvbGQgPT0gbmV3KQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoCBkZXYtPmhhc19laHQgPSBuZXc7Cj4gPiArwqDC
oMKgwqDCoMKgIG10NzkyNV9zZXRfc3RyZWFtX2hlX2VodF9jYXBzKHBoeSk7Cj4gPiArfQo+ID4g
Kwo+IAo+IFsuLi5dCj4gCgo=

