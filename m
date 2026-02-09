Return-Path: <linux-wireless+bounces-31653-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJ15KXKRiWlz+wQAu9opvQ
	(envelope-from <linux-wireless+bounces-31653-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 08:49:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD9810C98C
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 08:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E573630053F7
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Feb 2026 07:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460AA1EA7DB;
	Mon,  9 Feb 2026 07:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PMwVKgFp";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="T5ozaMfo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3131C2AA
	for <linux-wireless@vger.kernel.org>; Mon,  9 Feb 2026 07:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770623343; cv=fail; b=EbB9ERBVLbsqDNdWWwLu/9+9yoV5vav9y9sDh/HCuCAq/fCu8SJfbyDVfFUIe2nJRvDr2YQPb/lqQLPGOMiPytXLlU2Hw9/oJcF1eh7h+Q1XzMqlgkKXLWkRwUeIfMTRwaG98dinyWPFLujVRwdXGSywctTpmjw0vQOt+du36xA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770623343; c=relaxed/simple;
	bh=31x8GVaz6Xt/qKhxUSf/UvyFNMkPhyGArhrti5OCNnM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D3bO8mr7a/LACROWKB8/kZhbPYkGWr5jrVDE/IOu4B+lqSbKD1GFtXyby6wP4b6Zv/LLKcTqKMnnBScO2zJPCwsPb2BkSwozD5EqdMhJQPUiRrguwHgW2oxEMWfiEQ6zG/sg7MShUSq93iRLqeo2oaaarkYNvBrbRQKlKwYsZXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=PMwVKgFp; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=T5ozaMfo; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ca34553c058b11f1b7fc4fdb8733b2bc-20260209
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=31x8GVaz6Xt/qKhxUSf/UvyFNMkPhyGArhrti5OCNnM=;
	b=PMwVKgFpv5LKMzJJfC6bipGMbAOKL2WT91NDTnHBBLJFuBtZCGMT9IBKhiUIIjK71sghK2kMv+DvSfOV22ji/jhwBqCUr6Xxfz1v3u78Vz8VWRvSwxTu7TviFe9jC6w1FRbXNyQ82wzHGsdkrHYqDgKB1rkqiqbZZ9BpD3hrYCI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:5717e905-c6b8-4301-9410-16d2c7c2887c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:485c78e9-ef90-4382-9c6f-55f2a0689a6b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ca34553c058b11f1b7fc4fdb8733b2bc-20260209
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 301356805; Mon, 09 Feb 2026 15:48:57 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 9 Feb 2026 15:48:56 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 9 Feb 2026 15:48:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bbmh9eBpCeQ365ztfzwHAtu4Z4e/aNrqXCwt0ochkRXFKWWbWyAfcCNkxUPaxEYNYX211L0gZOObid6a1SSalQRLZmEq9a0LhFHrp28i7q8a57nwenqm9YkElv3TkzM5XNvsvhXUUB7/tvUEz+nD94cTMibN1wUWMQUYc11SyVsLBp7uJpzbdIDR3cfft2JidtmNr941659Y4DTW/DOB9rQp+VMt/pK1hAehjXjqToLMkmm0dp/Cof2IwjmNH4XiUEOdwjlpJoFK0CDLV4BSU/0NRP6M3eOL4v26E0AmsvWO45Sw/68/UJPEfjPpLN1pGu/R2YJfHGpYZqR+t8LEAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31x8GVaz6Xt/qKhxUSf/UvyFNMkPhyGArhrti5OCNnM=;
 b=wNDzdcX1e2g8AbA/aJYsTFEcnFjjKVDgagt1J6NdyK/KgHDeDGG0G0QnhzbyyUnNhQBhj+nw4pPTEfUa+UyLE0hXtN6rY3Yz1tQkpc5z152xrRw4pd7L4bSFLRr4o0TJQgkNXJy3iceaAOaiA5B0Uld0YNYy+o4KY/mMnM9rm5VR2KZIQ+hPhhSnEJYBd6BEBCzND0I2gZiLjQxA7xwOPuVrcCrfj2xcKYjjXj2I9DASt53soaHpmYUq++DBtkio/kg9GbNFJ/QGlYrgSauZfMCMiSTVlsYwkoOhuK5iFbxT2/kYj4D4EceB5gRG9MG+/TXVRSnIHk40zxRsncl2nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31x8GVaz6Xt/qKhxUSf/UvyFNMkPhyGArhrti5OCNnM=;
 b=T5ozaMfoHFEBSrCUINYGg616GdC8Op6vy+Fg9ojAvc1p2I+EGwe0RDBN72pnZQbL3sKZc8jiFKIAEmhMPkd6fc+RCQ92zxAufmIlfiuchdWUF8RjGVk7KPVcbLhyW4lrA1CAdBKTlhmr/FcpMx1aIC4lQLP9VJWblCSu/4ka4Jg=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by SEZPR03MB8677.apcprd03.prod.outlook.com (2603:1096:101:22a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 07:48:51 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059%3]) with mapi id 15.20.9587.013; Mon, 9 Feb 2026
 07:48:50 +0000
From: Ryder Lee <Ryder.Lee@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "sven@narfation.org"
	<sven@narfation.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"nbd@nbd.name" <nbd@nbd.name>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>,
	=?utf-8?B?QWxsZW4gWWUgKOiRieiKt+WLsyk=?= <Allen.Ye@mediatek.com>,
	"saravanak@kernel.org" <saravanak@kernel.org>
Subject: Re: [PATCH v2] wifi: mt76: fix backoff fields and max_power
 calculation
Thread-Topic: [PATCH v2] wifi: mt76: fix backoff fields and max_power
 calculation
Thread-Index: AQHcj+iACaXAJ4Cwl0+SoSzYpus5ObVvGDQAgAr5CIA=
Date: Mon, 9 Feb 2026 07:48:50 +0000
Message-ID: <278546e3f3e526288d245111d8e022b2d68d012e.camel@mediatek.com>
References: <54627282cfb8e5a89fe753da66552c0a084f6387.1769557863.git.ryder.lee@mediatek.com>
	 <7906220.EvYhyI6sBW@ripper>
In-Reply-To: <7906220.EvYhyI6sBW@ripper>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|SEZPR03MB8677:EE_
x-ms-office365-filtering-correlation-id: d656e5c8-be88-4aa2-ebc4-08de67afaa1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bWVFWWgrb1RIT1pLUC9TbXg0UEhIQ1JHUzZEek1DL3BGSnRJU3BWTWxndERw?=
 =?utf-8?B?QUEzQm1OaElTclVNd2NhdUtaYk4vQTFhV3piU2xmMGNMVERPaFA5YmowSTZh?=
 =?utf-8?B?a3RQdENLRUIrK3ZJT0tlRG9JNE5hMElIeGxmd0dZdlNxNmZ4OXlKQ0Y3d1ZV?=
 =?utf-8?B?VHVKZDZkSjkra1ZIYW9RUTdEY0k4TEJrajBhTHhVV0ZJd05RUzJOTnBmYTJU?=
 =?utf-8?B?YWJMaHB0L1JJK0xWSW5rcXlUL2R4TmtSN2hzQWM2dllFaDRoa1VwRHhQTnow?=
 =?utf-8?B?eGl0SFRoT1hjMExnbUdKb0RxUVJxZzJpa1hRTEsrNkpmN0loSWE4cmNocCtr?=
 =?utf-8?B?OXFBTG9EcStWRFpqK25VaWVXUHF3aUM0WWJKQVZEV1kycHF0M1JwZTVDMytP?=
 =?utf-8?B?YjROdUREcWgwclZjckxzZ3B6RVNYMDlyQWJKRUlKMUl5cVJWNGhRWUVEcDlN?=
 =?utf-8?B?cjFFR3p2VFFnREFPZzF5bGE2L3N3d2h5RENOL1VqbzZENWdtWmU2dGVVQkFk?=
 =?utf-8?B?SzN3SDFrV2U2dVJrcmx6ZDgwRkpKd2ttS3A1NUM0VjBIR1lzdFVpRi9DRmdu?=
 =?utf-8?B?YTBCVDRpUDZOeDUybWxva3hINGxlUXVSMjFPL3dPWmw3N1FXN2wvTVVVUldz?=
 =?utf-8?B?Y3dqT2JycktXa0Mrc3I4UnhJb2JCN0RCZndxRDJkU0pMUHRWU3RLYTlnZ3Zm?=
 =?utf-8?B?ckJrVGFNUGxZeUNGRVVtYmhrdnVrTFczME5GUllTai9sUVdxU0FPekFNcjRL?=
 =?utf-8?B?eVJJQ0pTVE16N3BJbkUyeHZlRTIxMEFCRkFhQi8yYWN2Y253Q1YvSExMRHVz?=
 =?utf-8?B?MXVaVTlrVmVTWkJ0RlRMTmh1VC9TMTVJNFcxQllNdmJEaE05cUF0bzJCWnd4?=
 =?utf-8?B?dHNqblh5MVZkRjhHUXRnSTBzU2ppMjBOK2IwSjAvWDR1RFZTd21YVFE5L01s?=
 =?utf-8?B?NlQzS3VsTnlKVTRqWXZodlJCWFVpYm56RXdQU0gzbklBNFVTUEREOEdEUUxp?=
 =?utf-8?B?MzN4bnhINEIwY3oxNmE3Q1RGSGQ1N0NaYisxaXR2SUU1YkxrNUhacXFVR3VW?=
 =?utf-8?B?SFg4SkVJR1hyY3l2SEVnaGIyQWhCZ0dMUzBLcTNoenlzc3B0eUg1YnMvTWtE?=
 =?utf-8?B?bUVFbTFKS3RQU3FvRWdkdDcvc2hneHJoVUZhQUlZSS9JM0wrdkF5TnBuNmtq?=
 =?utf-8?B?aDczeTlmdXBSMWMyaFVrREp3V0ltQnJmWG1UU3JuUEZyNnhWNzVnMFBXVU9k?=
 =?utf-8?B?Q2E4K2YycTVPcHgvUkJTc2gyM2psMmM1M1RUWFpqR0pzc3BjSXNxMFpLcUdi?=
 =?utf-8?B?b2NBQTVQSnJzb0c3TStuLzllc3h4R1lyUUFBanN6WHV6US94eVpNNlVjLzBJ?=
 =?utf-8?B?Qlcvc2drTnlJU0tXVmhzOFZ5bEwwT3BvVXZaTnhCNVFOeDJOeU9PUFh4eXlV?=
 =?utf-8?B?c1l2VU0yYjZza0lRWXBGVzJyVmxEaWxqSFFCSDY0MzYxOVgrTnQ5dlZxRVV6?=
 =?utf-8?B?Z0RsemlQK3pYTDJ1cXB6Q2lsYXNnRWFab0lOZkhrbys0VFFaWVFqRkljUExl?=
 =?utf-8?B?WVZZT1JoUEVKMHBONXFzcXowR01NckZkUVE4VlRUS3pycmthUEhJQUwyNUo1?=
 =?utf-8?B?S3U0MDRVRUZPL2xMZnZYczQyRVZPcUVKRkpOdXZrU0UrUHpCQ0hPRnZReTNu?=
 =?utf-8?B?eUUyUVp3VW8ycElRM2hnOHZtL3l5UGswcEs4MHowUEliSzVBTzQ4TGo3Z0hx?=
 =?utf-8?B?bGRZaVFFYnlaRDdFOEFtcU9kZHFzSFMwMHoveS9FQXlXRlp3TXNrUDZwYTR2?=
 =?utf-8?B?Nkg3bXl3YnplZHhqWnBSRncyTzZ5SDRqeWZrTHcwcHo3RXhvVzBFbTZQZXBF?=
 =?utf-8?B?TS9XVGYvSUVtZ2hUWGdQZytSUzFXb1YwbDFHRmY1VWpXSE1aUk9hTmM4dmIv?=
 =?utf-8?B?Wjd3MW9yWUkzWWNoUk1UWGJVT1hOSVpKUkJOQVpFT1pncGpveFZJZkQwSXlS?=
 =?utf-8?B?WDBuVU92cGlRem9LWEpEWHpzZENBWkd4bmMxaUlpQmM0OEpUOEJKTi9VV2NY?=
 =?utf-8?B?VU5MbUxWR3gxcTJyTTN1NjRST2tDa2MzK1FobE1tYWI1dEkzdnhtL2tLb3oy?=
 =?utf-8?B?aVM0czRUT3NYS2l2Z1FmUlN1WkdMR1pibUg0Z1NRUEhxL1VyR2tPQzAzc3l0?=
 =?utf-8?Q?C3djb1nfSP9VKyUc/kYnwHU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2lWOGJoSEFrcytHWURVWDlFZlVIZ3BNR3g1c0hWVlR1b3JQcTI3aEUyeXZF?=
 =?utf-8?B?U3J2NlVIaE02dmRoYkJCb0VhdUNvNkpmQXdlUWlIWTJNKzFpaWdlNFQ2RDhN?=
 =?utf-8?B?N24zUXp5K1hRNnR3WkdXeVlQT0IvU21kRmZxUUpuanppQmVWT0lPeHNMb0Nx?=
 =?utf-8?B?WHFiaU16eGU4YkRvaGVmUS9WWmN0NnQwQVZQaXRFdDRtNjg5V1dyRmlZZUhC?=
 =?utf-8?B?Y25FRzJMNVIwZmVpeUdnUld1M2xzc1EwVkJTSi9MY1NoenBTQUFNQWhVRHpm?=
 =?utf-8?B?dHJkMjVwZ2VoWXpJZFk0NUp1WWlsVlFCcm52Uy9NcDdrbk1Vekxwa0tGa2x5?=
 =?utf-8?B?ZG5sKytKczhOM0ljUFhrNXdpVWdoYXdZNFkybEhGVjlmNzlMWFpaVWRieVJn?=
 =?utf-8?B?VDZCMjNrWlUvOGh1ZnpLUHpueFlMVzRXaTBWRWVTZVJDWnB0a0grUytBMUhS?=
 =?utf-8?B?WGNldmt1NEtXNHBBUVJUVm93QmlpSTZRVldaZXlOc1gvMVRHbVlxVVIxMTN2?=
 =?utf-8?B?U3BxZ0lUWTdoVUo2YkdCODJOa0U0bFJLR0VBeXdreGtVbUZJQWwvZXRSM2pj?=
 =?utf-8?B?WG1RZVBlZGh2ZEp4a1FzK2dNT3FZdFdUcVh0d3BFL1RJWWZMMjV2TjBManNi?=
 =?utf-8?B?YXQ0ZStWM0NiMnlPWFFLeTVmVndGQzNNN1FEZzBhM0VSUDllY053b3FnOEtX?=
 =?utf-8?B?L3lQYnAwVGhVRzZHSlBjMU5MNlJCN0Foa3BwQTJkVUpmaVBEMlV0RDc5MVd1?=
 =?utf-8?B?U1ZWTUgweUNlL3B4bTdqMjhFdnBlWm41YWpDZ1FITytGV1d1U3MvUklLVkRi?=
 =?utf-8?B?WSt1Z2Q5azdJZC9uenZmMUNCeDkzRXZiRE13RGFkRU1NUW9GeGdPRkovYXp4?=
 =?utf-8?B?RHlPRXhSeWtsZ1ZQbXJqeURydXVoNmhla0F6ZUVjSWdIRE1mSEltS3hGMm5s?=
 =?utf-8?B?aG4zeVFNdWFJMXhhU2lFd2lJZlRxc1V6aE9OMmFLakhZMDgwQnlXYU5ndkk2?=
 =?utf-8?B?MGlKZUtObVRDYjVXWTM2MDJhVWRFRnVnVFA5dUx1V1JNdERRYnJzS3VYNVhm?=
 =?utf-8?B?c09ZREFySlpSeWtzTC9MbklMclB6Y05jWU9pMEpGcFBIWERNd0VaYzN2TkdM?=
 =?utf-8?B?MFpFcjlxZE5JMnJkVnN4dlN4Q2FldGEwNldiRjVzV1BKRDFrK1dOUjJObVRr?=
 =?utf-8?B?SXptY2xLWGRpa0IxR0VsVDFvdlJLdnZIMFBrdmplOUhlWk1ZbExzTlhPVnph?=
 =?utf-8?B?RW9oeVE3RTNjU1d1cWxSWk1pK0t2Ry9OTVgwZmFOQmdRWWdCc29udFgzS0sr?=
 =?utf-8?B?YkpiUnRyS3ZmTkd4ajB2UUEzTUJXZ014Y3hlMnhhYTBNbVBkTVpXTzVZSDUz?=
 =?utf-8?B?N0RGYUhxNW1TekhUVG1jbkhuM25HaUJaMWtTcFVacXRObTlRNWNETnpyYUp1?=
 =?utf-8?B?QUQ5ampHUTM3dDExNjZUcis4aFJONW02TXhsM2tuSEdzMTVudG5EdDdrMERj?=
 =?utf-8?B?aFpzUEwxQTNCSVFqMlNKSXcvTk01N1JReTljYmR6NmpSWDl5YzUyUlJEUzBu?=
 =?utf-8?B?TUFVY0o1U2piY3dOeEdwTXJBMk1uTTg0d3RHMWxGZnRRZ0Jkb2ZGa1k0Mnhk?=
 =?utf-8?B?WURUSEMxVEMwd1lTQzZqRlU2Yms5MDdZOExUcnpGa0tiaEN2WWxLb2xuZ084?=
 =?utf-8?B?d0d2eDB6eFpqdUFPbUpBRVJoeFY2MWIwb1phaFRLeWFrQXhGMGpaclh4cGJZ?=
 =?utf-8?B?cWU0bWFOcXNmcitsRWFuSndXUm5MenU3UHFJL3g1NEt3Y0lwRm9xRkJmMVBo?=
 =?utf-8?B?b1hKV3lmdXpTZnJ5RmNzUmU4OTljT3dVNzlVKzVEMmJ1Q3J5aDlmZDUvejVn?=
 =?utf-8?B?OUFpaE9YU3JNUE5sTDlZVjdPdTZML0RnMmZDcnA0RjVOWmx4eFFzWldUUlFH?=
 =?utf-8?B?VDRoMy9Ua0F4Q3p6QnA5ZlJMUXhSVE5pdDhRdUtuOUZ4QWpIS3JMOWpOODRG?=
 =?utf-8?B?aXZUTlZqOWRXMjU3ZDRJeDFNOWlYdjY5OHVwSU91VjhOSDVWSGpDWVZTYlpZ?=
 =?utf-8?B?bExGMkdXZkh5eVcrb2tPaXlDZU9XSGZySzZEaEtrcXUvd1A1UFlkQWltTDRr?=
 =?utf-8?B?OS9CNHE1eVlDRjJtRnljWmZyYkdGOVNLZ3FnVzZpZW41b0tYN0hQR0NraTM4?=
 =?utf-8?B?NnlReFNnVktibDQ5SFVOZFdjdGNGTmE1M2FRd2hvaEo1QkhDYWx3cXZZWTA4?=
 =?utf-8?B?NEJwUjJQZWdxTVBlQ01pcjVabTk1RnRXTS9KYi9ra000d2c4V05IZUNPTkla?=
 =?utf-8?B?VEFwbnA3VnYwbnkrUnhidkh1TWlUNGl5TzFUMFR2UWtZSFBDb0thY3FzQldo?=
 =?utf-8?Q?6fGixogz6ElUHuAc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A7EE178A5930240A5B7764A6434D500@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d656e5c8-be88-4aa2-ebc4-08de67afaa1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 07:48:50.3830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pzy17RUBcJ2XwhfwkmH9vBfJW054yhe03THyeJ/JV5f4ppwMZmutzSi4+cp5t+ckck2WQaIESlxq+Rmc8Kregw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8677
X-MTK: N
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk,mediateko365.onmicrosoft.com:s=selector2-mediateko365-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31653-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mediateko365.onmicrosoft.com:dkim,mediatek.com:mid,mediatek.com:dkim];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+,mediateko365.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Ryder.Lee@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 7CD9810C98C
X-Rspamd-Action: no action

T24gTW9uLCAyMDI2LTAyLTAyIGF0IDA5OjE0ICswMTAwLCBTdmVuIEVja2VsbWFubiB3cm90ZToN
Cj4gT24gV2VkbmVzZGF5LCAyOCBKYW51YXJ5IDIwMjYgMDA6NTU6NTcgQ0VUIFJ5ZGVyIExlZSB3
cm90ZToNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIE1UNzZfU0tVX0JB
Q0tPRkY6DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGJhY2tvZmZfY2hhaW5faWR4ICs9IDE7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGZhbGx0aHJvdWdoOw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGNhc2UgTVQ3Nl9TS1VfQkFDS09GRl9CRl9PRkZTRVQ6DQo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRlbHRhID0gbXQ3Nl90eF9wb3dl
cl9wYXRoX2RlbHRhKG5fY2hhaW5zKTsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgYmFja29mZl9uX2NoYWlucyA9DQo+ID4gbXQ3Nl9iYWNrb2ZmX25f
Y2hhaW5zKGRldiwgYmFja29mZl9jaGFpbl9pZHgpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBiYWNrb2ZmX2RlbHRhID0NCj4gPiBtdDc2X3R4X3Bv
d2VyX3BhdGhfZGVsdGEoYmFja29mZl9uX2NoYWlucyk7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGRlZmF1bHQ6DQo+IA0KPiBQbGVhc2UgZG91YmxlIGNoZWNrIHdoZXRoZXIg
dGhlICJjYXNlInMgZm9yDQo+IE1UNzZfU0tVX0JBQ0tPRkZfQkZfT0ZGU0VUIGFuZCANCj4gTVQ3
Nl9TS1VfQkFDS09GRiBzaG91bGQgYWN0dWFsbHkgYmUgc3dhcHBlZC4gSSB0aGluayBJJ3ZlIG9y
aWdpbmFsbHkgDQo+IGludHJvZHVjZWQgdGhpcyBtaXN0YWtlIHdoZW4gdHJ5aW5nIHRvIGRlbW9u
c3RyYXRlIGRpZmZlcmVudCB3YXlzIHRvDQo+IHdyaXRlIHRoZQ0KPiBzd2l0Y2ggYmxvY2suDQo+
IA0KPiANCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBGb3IgY29ubmFjMiBk
ZXZpY2VzLA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiAtIHBhdGhzLXJ1
ID0gUlUyNiwgUlU1MiwgUlUxMDYsIEJXMjAsIEJXNDAsDQo+ID4gQlc4MCwgQlcxNjANCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogLSBwYXRocy1ydS1iZiA9IFJVMjYsIFJV
NTIsIFJVMTA2LCBCVzIwLCBCVzQwLA0KPiA+IEJXODAsIEJXMTYwDQo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAqIE9ubHkgdGhlIGZpcnN0IHRocmVlIGVudHJpZXMgdXNlIDFU
MXNzIGFuZCBkbw0KPiA+IG5vdCBuZWVkIGluZGV4DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAqIGFkanVzdG1lbnQ7IHRoZSByZW1haW5pbmcgZm91ciByZXF1aXJlIGluZGV4
DQo+ID4gb2Zmc2V0Lg0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8NCj4g
DQo+IA0KPiBIbSwgSSBkb3VidCB0aGF0IGFueW9uZSBjYW4gdW5kZXJzdGFuZCB0aGlzIChzYW1l
IGZvciB0aGUgY29tbWl0DQo+IG1lc3NhZ2UpLg0KPiBZb3UgYmFzaWNhbGx5IGp1c3Qgc2hvd2Vk
IGEgbGlzdCBvZiB0d28gZXF1YWwgImFycmF5InMuDQo+IA0KPiBBY3R1YWxseSBpbXBvcnRhbnQg
aGVyZSBpcyB0aGF0LCBSVTI2LCBSVTUyLCBSVTEwNiwgLi4uIHN0YW5kIGhlcmUNCj4gZm9yIDEw
DQo+IGRpZmZlcmVudCB2YWx1ZXM6DQo+IA0KPiAxVDFzcywgMlQxc3MsIDNUMXNzLCA0VDFzcywg
MlQyc3MsIDNUMnNzLCA0VDJzcywgM1Qzc3MsIDRUM3NzLCA0VDRzcw0KPiANCj4gRm9yIHBhdGhz
LXJ1LWJmLCBhbHNvIDEwIHZhbHVlcyBhcmUgc3RvcmVkIGluIHRoZSBEVCBmb3IgZWFjaCBvZg0K
PiB0aGVzZQ0KPiAoUlUyNiwgLi4uLCBCVzE2MCkgLSBidXQgb25seSB0aGUgbm9uLTFUMXNzIGFy
ZSByZWxldmFudCBmb3IgdGhpcw0KPiBjYWxjdWxhdGlvbiBmb3IgQlcyMCwgLi4uLCBCVzE2MC4N
Cj4gDQo+IFRoZXNlIDFUMXNzIGJlYW1mb3JtaW5nIHZhbHVlcyBmb3IgQlcyMCwgLi4uLCBCVzE2
MCB3ZXJlIChpZiBJDQo+IHVuZGVyc3RhbmQgaXQgDQo+IGNvcnJlY3RseSkgcmVtb3ZlZCBmb3Ig
Y29ubmFjMy4gDQo+IA0KPiBJZiB5b3UgaW50cm9kdWNlIHNvbWUgY2hhbmdlIGluIHRoZSBEVCBp
bnRlcnByZXRhdGlvbiwgdGhlbiB5b3UgbXVzdA0KPiBhbHNvIA0KPiBpbmZvcm0gdGhlIERUIG1h
aW50YWluZXJzIChSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPiwgDQo+IFNhcmF2YW5hIEth
bm5hbiA8c2FyYXZhbmFrQGtlcm5lbC5vcmc+LCBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZykN
Cj4gd2hpbGUgDQo+IHVwZGF0aW5nRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25l
dC93aXJlbGVzcy9tZWRpYXRlayUyQ210Nw0KPiA2LnlhbWwuIA0KPiBUaGUgbGF0dGVyIGlzIGN1
cnJlbnRseSBzdGlsbCBleHBlY3RpbmcgMSAoInJhdGVzIG11bHRpcGxpZXIiKSArIDEwDQo+IHZh
bHVlcw0KPiAobGltaXRzKS4gQW5kIERUcyB3aXRoIG9ubHkgMSArIDkgdmFsdWVzIHBlciByYXRl
IHdvdWxkIHRoZXJlZm9yZQ0KPiBmYWlsIHRvIGJlDQo+IHZhbGlkYXRlZC4NCj4gDQo+IEF0IHRo
ZSBtb21lbnQsIHlvdXIgY29ubmFjMyBjb2RlIGlzIGJhc2ljYWxseSBjb25mbGljdGluZyB3aXRo
IHRoZQ0KPiBkZXZpY2V0cmVlDQo+IGRvY3VtZW50YXRpb24uIEkgd2lsbCBsZWF2ZSBpdCB0byB0
aGUgZXhwZXJ0cyB0byBmaWd1cmUgb3V0IGlmIHRoZQ0KPiBkZXZpY2V0cmVlDQo+IHNob3VsZCBo
YXZlIHR3byBkaWZmZXJlbnQgaW50ZXJwcmV0YXRpb25zIGZvciB0aGUgc2FtZSBwcm9wZXJ0eSBv
cg0KPiB3aGV0aGVyDQo+IHRoZSBwcm9wZXJ0eSBzaG91bGQgYmUgdGhlIHNhbWUgYW5kIHRoZSBj
b2RlIG11c3QgaGFuZGxlIHRoZQ0KPiBkaWZmZXJlbmNlcw0KPiBiZWZvcmUgc2VuZGluZyB0aGVz
ZSB2YWx1ZXMgdG8gdGhlIEhXLg0KPiANCj4gUmVnYXJkcywNCj4gCVN2ZW4NCj4gDQpJIHRoaW5r
IHRoZSBEVFMgZm9ybWF0IGZvciBjb25uYWMzIGlzIGFsc28gMSBtdWx0aXBsaWVyIHBsdXMgMTAg
dmFsdWVzLA0Kbm90IDErOS4gVGhlIGtleSBzaG91bGQgYmU6DQoNCkZvciBiZWFtZm9ybWluZyB0
YWJsZXM6DQoNCi0gSW4gY29ubmFjMiwgYmVhbWZvcm1pbmcgZW50cmllcyBmb3IgQlcyMH5CVzE2
MCBhbmQgT0ZETSBkbyBub3QNCmluY2x1ZGUgMVQxc3MuDQotIEluIGNvbm5hYzMsIGJlYW1mb3Jt
aW5nIGVudHJpZXMgZm9yIEJXMjB+QlcxNjAgYW5kIFJVIGluY2x1ZGUgMVQxc3MsDQpidXQgT0ZE
TSBiZWFtZm9ybWluZyBkb2VzIG5vdCBpbmNsdWRlIDFUMXNzLg0KDQpOb24tYmVhbWZvcm1pbmcg
YW5kIFJVIGVudHJpZXMgZm9yIGJvdGggY29ubmFjMiBhbmQgY29ubmFjMyBpbmNsdWRlDQoxVDFz
cy4NCg0KSSB3aWxsIGFkZCB0aGlzIGV4cGxhbmF0aW9uIHRvIHBhdGNoIHYzLCBhbmQgSSBoYXZl
IGFscmVhZHkgZml4ZWQgdGhlDQpjb3B5LXBhc3RlIGVycm9yIGFib3ZlLg0KDQpSeWRlcg0KDQo=

