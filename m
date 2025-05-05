Return-Path: <linux-wireless+bounces-22429-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4988BAA8BD4
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 07:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA07A171C6E
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 05:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9C61459F7;
	Mon,  5 May 2025 05:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UZQuuYSD";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="YZdQbBj4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFF414AA9;
	Mon,  5 May 2025 05:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746424126; cv=fail; b=F8/OeIPVFF++nU9hvawHqC/E4+9y83tQAU2betICBs6QTpdVri/X7rG4s5MMgBkjRnCHUI01yjzV2PkEKkEaOyiJ/up/v9l9fg86teP1+KkuTbGjmk0/6tzQFYbSSntI99evq4PGfCVZByR1kdZb7JZlc9UV8b4dHMvJ7YsgPBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746424126; c=relaxed/simple;
	bh=A4mfbaThm9rVLB4BTDYy00u8EdrXe05b47nkcduYt2Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TTHaG4syy61jHt0ZI2OLfRTeCShxlSQQB9G7ZN+p+1+rqEvN7DIZSoMBRD5pHGEkly91/+gl/G5lQ3FCvp/wmwP2yXglxhDkA6gE3bVLSeXAhM0X/6FIGEGYybhEuAMZ7ufL9a4w05eWGG6yyXQeDvb5Jjij5rECha+kcHVpoDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=UZQuuYSD; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=YZdQbBj4; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 943b4998297411f082f7f7ac98dee637-20250505
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=A4mfbaThm9rVLB4BTDYy00u8EdrXe05b47nkcduYt2Y=;
	b=UZQuuYSDiSodegGXctPuoT5pIGD+ZOZcsyO33jjaotyoJ/iVK11SKUqUX7KW34AeXyPTVEjSOKpdX4phaJR73Jw5MYwHu345nrVDzarW0zxAfdnhzS8y9QkHhwoSqj21gMP7Vwf/vviQ6HW5Xa07c+VD9DOMExJNIyPClZBhIF4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:2f6f1634-9a25-4e5c-885b-4e3f314fd420,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:aaa9c22b-be47-4281-8f30-e6479b5e1210,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 943b4998297411f082f7f7ac98dee637-20250505
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 127083147; Mon, 05 May 2025 13:48:32 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 5 May 2025 13:48:32 +0800
Received: from OS8PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 5 May 2025 13:48:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8Wup/QRp+eyRIbMOwN8yHRWaOmtsBhDY13+XC9yze6X6S8atXPlOzFdxX/TkS7NgfLb/s5y+XKGxLmJphTtEmmxtsNmO6ZXvslqYcOi870XQisn82hd8eEhV65dOhO1eHtYA8RQi9Z8ECmNGx1hDByc/69jTD83JjmKYRccf6s1NKT6e9WwOGDeHqLwQQfW3v+2s0JZfi41JdK3ByWMPiQHXhW3eKIa4AECEAdXH1AOEAmDXwEYwhlWOtoSRmUULSHCqWHRoWic7Zr+e2eAXKBF40LV2IhpYtgcyZJ8cv2Rk8Bfe2Y5DAMCnhuGU0CZoXx3c6KTx0Ch//cKXCf2eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4mfbaThm9rVLB4BTDYy00u8EdrXe05b47nkcduYt2Y=;
 b=MOl+vTjZXdGOXz4NhFHC5dGmB8CS8fhN8JTRKdH6PuDKzJSwQiXXoPDgR3sM1SXR69mt1baL+WYzWVIdm7yepfrxjZFOTc1J1MCwZjhV67JGYno1oYkAetjl3NnN6FMLk4muOb7Blxe1R1cxbiXyN46oClPlT68YEBVpkUuWWshD31ikhqhq78UTN0RXVNwtagTF/rFB1qzEo4LFsSZiahRC0QxoQqkfP2+haPzSHIXKqKdBWYAOgS7PdecgdTso/1toqYVUxiBoFtUSDEsgX1B3IVrWWzw/iWo49mutCNZ/HgJ9YaKKn3ljdomPWnsLd7H/Ux7jg92xNB2iaWqaGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4mfbaThm9rVLB4BTDYy00u8EdrXe05b47nkcduYt2Y=;
 b=YZdQbBj4ie/kOy7mC7iwtoLVIycZbYIcZzFH+yHG++9FLnu4Duk9SBS/I4pFRAtLS83R7rGIwDauWCluRBhaHbyxMqca2ezeonygSh9jl/DxNRX7VUp0FndLSl2nQIB3wnsOwBu+9PPxrGSoX0ZsMjA7JyZwtuphiQUO6D2v9iU=
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com (2603:1096:4:ef::8) by
 KL1PR03MB7392.apcprd03.prod.outlook.com (2603:1096:820:e8::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.26; Mon, 5 May 2025 05:48:30 +0000
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741]) by SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741%6]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 05:48:30 +0000
From: =?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
	<Mingyen.Hsieh@mediatek.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>, "niks@kernel.org"
	<niks@kernel.org>, "fossben@pm.me" <fossben@pm.me>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?QWxsYW4gV2FuZyAo546L5a625YGJKQ==?= <Allan.Wang@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION][BISECTED][STABLE] MT7925: mDNS and IPv6 broken in
 kernel 6.14.3 and above
Thread-Topic: [REGRESSION][BISECTED][STABLE] MT7925: mDNS and IPv6 broken in
 kernel 6.14.3 and above
Thread-Index: AQHbuW1RnEt/GbhWjUulnPHycX5tgbO7xLGAgAXBBQCAAgoWgA==
Date: Mon, 5 May 2025 05:48:30 +0000
Message-ID: <28ef2cc608d071d1530902d7b5df045555ab5651.camel@mediatek.com>
References: <EmWnO5b-acRH1TXbGnkx41eJw654vmCR-8_xMBaPMwexCnfkvKCdlU5u19CGbaapJ3KRu-l3B-tSUhf8CCQwL0odjo6Cd5YG5lvNeB-vfdg=@pm.me>
	 <f73dec60b60dd7bb3be40c1feefbe223c7afe19b.camel@mediatek.com>
	 <5ae1ef34c9844d6d0f5fb167dd596a4c43321367.camel@kernel.org>
In-Reply-To: <5ae1ef34c9844d6d0f5fb167dd596a4c43321367.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5322:EE_|KL1PR03MB7392:EE_
x-ms-office365-filtering-correlation-id: d80a79ea-e2ea-4545-f29d-08dd8b9876df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?c3E1R3RZb3dlNFRqSVBWNUkzTEEyNDVMWmFIK1Q2ZTVwWFNEWGtxcEUyWXFC?=
 =?utf-8?B?K2tSa2EyQjh5WWk3TWlhNkpWajlHWjVKWFhJMVREWDh3VEVpdlk1aHlxSFNN?=
 =?utf-8?B?OU84Y0UybDhnTmJQTzVGdXVGUzlzdW1JSDRNcEh3WUJlR0MrTGRqL1JYNHNZ?=
 =?utf-8?B?THlLeWlSNzhGbnJTcXZ0YVR4VjZkQ1djejNIeWRCUUFvN3VUUDJCYXoxL2Nu?=
 =?utf-8?B?SlVWT0dadjNDdlpDUXplcFJiUXJFQ2xZTkE3ZHA5UlU1MS9ZcVo5L1E2MnF5?=
 =?utf-8?B?a2NMaUdlM3kyWFFGWVFqTkMrLzhnQ3FqcjROelBZWS80cUNXMEdOaEJPL2Z0?=
 =?utf-8?B?SkFUejhJQ01MRGNLNzNWN3pRd09FS1R3RnF4RU8yQXpQdWFHWWpxQXM2VnR0?=
 =?utf-8?B?Q3Ixa3lpaUhPSHV6dnQ2eVRvMEYwYnVXMkZWWkJvTVBmUWlmc0o4RTBySzNV?=
 =?utf-8?B?WVJEV2ZFUjlwUSthUS9WdWNCNW1qb3J0aGhOK1FPWEcvaS95SXRoUzlHNHFq?=
 =?utf-8?B?dzBZRVVQWDR2VXNuSk9TR2NRTk9udm02VXVDSXV1SlJkUVUranFUUGhjZGRs?=
 =?utf-8?B?Um9PTkdPNVoveWNEa0ttMCtVbUNydjRyT3VrTTVGSERDVlhLTGJTcXpQczhT?=
 =?utf-8?B?eURvNEVza2laQ1Y4ei9MbGdhNERyMi9XeEorM255Nkd0cU5ESEMrZWNtTnJB?=
 =?utf-8?B?akRZVUE0Z0hseUpCY2paLzJuTlgxWnRnSzJmTUFOQ1hLR2x5bTM5bXBoT1Ry?=
 =?utf-8?B?Y1k4UjFwOU9SalErNkMrc09SalYvem1oblo2TlZ1WnlwRFdFVU04Ymp4WVFo?=
 =?utf-8?B?TjBnMm95SHZ1Y1hSQm9xTVNLUHVQalNGOWI3ZU1zbW5Qc1RGL3JJR2ZrUFpJ?=
 =?utf-8?B?czB6ZE1BVzlEQ1RyQXUxM0VSNUJERFhuVUdwa3pLdWtmVlRZM29OaG52UWZx?=
 =?utf-8?B?QnBYZXc0SVQrQnVIWTV6ZFQraWZ1RkVpdi8zcldQOCtFMTU5UzBuaVpqWHpH?=
 =?utf-8?B?L0prdTBMZUhyZnZWWlVHTk5aNEZBSzMzdkZQTUk5TXZsNTN4Z2E0ZUliMzFs?=
 =?utf-8?B?OHJSVEZBUzlpY3lFVXJFZkw2K1lPSWM3b1BBdHY2OHpkNVVUUjFsMjNBYVc4?=
 =?utf-8?B?b2tkaDZQb1Yrc055NTNxS1lDQUUrSEJkcjJmY1MrakdyaVRHRURVRjNhckp0?=
 =?utf-8?B?Tk5ZNW9kZURqTkY0OXF3dE1kOFBEeTREd2RmeFdCQjJmd2c0V1U5ODZpMEhV?=
 =?utf-8?B?ZHpzWTNtaEJxRFJuVWFsSmFoUndjYjVoVzlIRnpVdkNNV3dia2RGYlZPajRj?=
 =?utf-8?B?RXNFVVU4aVJSMHpGRk5tc2p4MEtCNXY4Q21pKzlsZDdjNjRJQmpxekVBQ05D?=
 =?utf-8?B?ZFlDcWRyYmhPbER4bFMwdmRNdHROa29TenI2VlQyZzh4ZzZTWjFqbWNHejFu?=
 =?utf-8?B?OTFWc3VQNmVXcTVCeTFkQWJRVjN5S1BQMUlTL21XdVllczN2STdHaXNFOWRQ?=
 =?utf-8?B?ZWVFVEkwbDYxMGcwRVJRNExUeXFXU2JaYlY2QnJILzdiZ05lTEltTS9kZE9J?=
 =?utf-8?B?UVd6N3JyOTBrL0kzYytDaFBRUzYySmxGbkZGSWcvK3p1ZFFTaXZDTTRNOGl4?=
 =?utf-8?B?Nmx2SG5MdGhEVUJYZ1J3cXJzVWV1ZitDejNJaUZjVlV0enc2VlJpeUpiMUpF?=
 =?utf-8?B?enY3bEI3YUh3aWx3R1hYdk9zUHVBbjFzTEdlZE41bnNqRWtVTjBSMkhHdDJX?=
 =?utf-8?B?elM3cHd2LzFkN1dKTDNUaXozbEZ6a2F1Q01GODVFWnlkWExtNGZiZ1pIaUE1?=
 =?utf-8?B?RGF0UjBrYm9pSmNtZDhmVHNxVUFkUmhUWlJuN3V0aWY3aDlrcXZlc0cvYTRY?=
 =?utf-8?B?MWJybE5CcE1STTBFUU4wSklFckloRmp3Y0hUU2I5N3RpQkw1Y3Nma3JTQ0Nw?=
 =?utf-8?B?S2ZGWEhBc3dmc2lEK0VBQ1ZQbkZwQzdtU1MwVy9MempBVDhoUUV1c1hQZ1BG?=
 =?utf-8?Q?3GpoqoZb9sKzFHwzPxBVSDDy6XYopk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5322.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHJTZUNyWjltUmpMZUdWM2RaRkIrZWs5QmYwZlExZXpJcmFuVGlhNjFnblhM?=
 =?utf-8?B?ajFMMWdNK0NyTDZCK0xXdUhnSHo2U2IrT01GTUxDbW9WcWVZM1pBMFlHdGhm?=
 =?utf-8?B?Vm9ubm92ZFFQRkV0Slg4VjVxWUY3SldjaEtKSzk3QndMUHdTU0JCMzdBM1Z0?=
 =?utf-8?B?R3ZnZXVmcjVZb0J2Y0xuZXVvTmpoaVNBTm9pNEJCLzA4NGZ4elNLcW9yTldG?=
 =?utf-8?B?dWRIemtuOUNwYTFnMDFLZjM0S1NhemdkRWVVMUNUOWM4V3hyMFY4NmNWTm81?=
 =?utf-8?B?dEFwNFRjOXZGOXQwY21CTnRIRVVLYUxJampnM1BMZVR4Y04vNytmUGxFZnFz?=
 =?utf-8?B?RkpvVEgyRlhEaWFwaENrVjkyc2JvZnNZclJtTk4rQm5JYVR1dDFTb1ArREN1?=
 =?utf-8?B?Zm03VTJZczJiZWVKMWFBV0hLYkJJa0MybGpKNkZNa1pEcmxqRkJDUzE2T3By?=
 =?utf-8?B?OEgxYlMySmJJYzR1UVBmVUZTYm1FTWhZZ2RrS0NIbU14a2M5L3c4d1BPMkMw?=
 =?utf-8?B?cHZsUTJtRUxCWTdXVDRkTngvSUsyVXhmcWVZdEFHbllxclNOU0FNbUpqS3hU?=
 =?utf-8?B?bkhLS0NGU3hlS3E0SUR4bElRYkQ5QnVHMmp1M2ZweFZDMlZNcEh5OTRaVjJk?=
 =?utf-8?B?TnBndmJhdjJQS2duRmhkKzdLV3hxZVBxeVBkY1FWL1pZR01UUnNjOHZ5b2E1?=
 =?utf-8?B?eHVsS1BCSzhCVG9lUG8zU2F2L3FXRTdiZEFyelF1U0tRYVArKzVIbWFRK1ZO?=
 =?utf-8?B?MHRSOHRMZnl4UjRlN1czWWxxV09ZRWhCa0lOWk4ydEx2WXZMck51VlozMEZU?=
 =?utf-8?B?MngwTEsraEJEWmQvRlZqRk9wRENVQklOaGdwY0pCTTBQRmRDN1VNUXgrVGU1?=
 =?utf-8?B?a1FoM1JHb0pFSFgvMnhNZjJUcS91SEhDZ3lmaTA1Vk00RDlkNnVrbmdQZHEy?=
 =?utf-8?B?QzQvd0c4Qm4wNmE3Y1J1OXl1d3NXMXF2YWl2bnQ2MGNERXVwanlURk94K3Zv?=
 =?utf-8?B?QlhoRTIyYk5SRUpCbHQrYjVLbFdNdWoyYllrNmUyd3hPVkFndmZkVXpLRHRk?=
 =?utf-8?B?SDRmUDRFbHZCYnc2VXF5dkMxRUdsM2RmaklXZkxKdHNHNHpqc00ycG9SSDZ6?=
 =?utf-8?B?WUdCMzNmb2RSWWNvZDFLNTRUbGVUZVVzMXNmZUg2QW9WVG1sVDN0OGxNR1Ra?=
 =?utf-8?B?Wjk3dUtuZ1MrUWsranphajBsamlkNGh5akI2UXNFMEZNbCtzZWhpeTZwVklJ?=
 =?utf-8?B?c1ZhcEoweUtkZmc0ckFJS0xkcTk3eUdTMGdKL09ENlZBQUVKKytWSXI3N3pD?=
 =?utf-8?B?QmFHQjdxNWhlSGxmdmRXcit5TDI0UXArbkNSaDJPZzZzZXlnc25jZGVxS29a?=
 =?utf-8?B?MEVBdG9saC9LL1ZJSzdCYTlWOVBTbWtMQW16VUZmUHpSaHIwT0hGVncva0ps?=
 =?utf-8?B?SFRTbmNvdVdCZU16MENnK1lhMXVkRmR0a0dTV3dPUC9UKzFUQjNjOEgvUi9L?=
 =?utf-8?B?TWxUWmJFWU45dWJnYVRvcThpcUZKVGhGNmw2TzI2a3p2NG1QcUg3cjhYUDRo?=
 =?utf-8?B?VUgxdFpwNyt3Nm9oQnROQ2lBQlZsQi9rYjhER2Q3WXl3YlNFdnFmNTdveTVL?=
 =?utf-8?B?eVBYRGQ1eThqQWJZMk10a0J2SUV2M3RFdkVaSVNoYkd4aUlmRWk1TEZYWDFu?=
 =?utf-8?B?dHYrbUY0cUlOTFhQNGIwZndQQ2l5Wm4raVlDYkxqMHYvZWtKa2gyc0xRYzNt?=
 =?utf-8?B?NFZhVzgwcVIyMGQ5elZUeW1hYTZmb3hiVUUxNmVMcmEyMnBjOWIrQ0tnZnA4?=
 =?utf-8?B?NytFK01DNi9hMWgyYytZbkJPMU9nemgvenZjS0x6RkM3TFFrRXpQMWJ0N3pS?=
 =?utf-8?B?aVZzYVV5TXNyTjkyaTloRHJVUTNTdWltZ0NDRUR2VjFXeDRXTTRXUHhLd2kr?=
 =?utf-8?B?NTJ4QmpxbVRZdW5ybEZ4WThwYmlFNHlaREowZjZlZlRSaFMyMHRLQkJ2Zjk3?=
 =?utf-8?B?Tzk2cnp1SzJGai9jSnMrWWJVcXZHZFBzOFlCYlFFcmxmSnBUa3FJdC9aQmtE?=
 =?utf-8?B?TkRzdUxHR3BzMkFlVVRHaTNFTUhURFlMaTlFR1BiV05KaSthcFhVUVI3UnJF?=
 =?utf-8?B?ZTVUeCtRSGRUZXJxajlRT2ZiblhFaDhWZUZEcXhmQ3grNkEwdmlhWEx3OXVL?=
 =?utf-8?B?eUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2575CCB3EE9934A8FD7C00A70CB464F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5322.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d80a79ea-e2ea-4545-f29d-08dd8b9876df
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 05:48:30.1920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sov7pk5ErH3jMuf8xQsI8j2ouUGvzrn6bX2rlzxfE1Bk2ZEPFSW4hQX0t/h4aexlPKw0V7LyeVAzqKFwmZQzVyW+9FjS2LlyWZ1GtCqWVZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7392

T24gU3VuLCAyMDI1LTA1LTA0IGF0IDAwOjM5ICswMjAwLCBOaWtsYXMgU2NobmVsbGUgd3JvdGU6
DQo+IA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIFdlZCwgMjAyNS0wNC0zMCBhdCAwNjo0NyArMDAwMCwg
TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KSB3cm90ZToNCj4gPiBPbiBXZWQsIDIwMjUtMDQtMzAg
YXQgMDE6MTQgKzAwMDAsIGZvc3NiZW5AcG0ubWXCoHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBFeHRl
cm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cw0KPiA+ID4gdW50aWwNCj4gPiA+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gSGVsbG8gYWxsLA0KPiA+ID4gDQo+ID4g
PiBBZnRlciB1cGdyYWRpbmcgdG8gNi4xNC4zIG9uIG15IFBDIHdpdGggYSBNVDc5MjUgY2hpcCwg
SSBub3RpY2VkDQo+ID4gPiB0aGF0DQo+ID4gPiBJIGNvdWxkIG5vIGxvbmdlciBwaW5nICoubG9j
YWwgYWRkcmVzc2VzIHByb3ZpZGVkIGJ5IEF2YWhpLiBJbg0KPiA+ID4gYWRkaXRpb24sIEkgYWxz
byBub3RpY2VkIHRoYXQgSSB3YXMgbm90IGFibGUgdG8gZ2V0IGEgREhDUCBJUHY2DQo+ID4gPiBh
ZGRyZXNzIGZyb20gbXkgcm91dGVyLCBubyBtYXR0ZXIgaG93IG1hbnkgdGltZXMgSSByZWJvb3Rl
ZCB0aGUNCj4gPiA+IHJvdXRlciBvciByZWNvbm5lY3RlZCB3aXRoIE5ldHdvcmtNYW5hZ2VyLg0K
PiA+ID4gDQo+ID4gPiBSZXZlcnRpbmcgdG8gNi4xNC4yIGZpeGVzIGJvdGggbUROUyBhbmQgSVB2
NiBhZGRyZXNzZXMNCj4gPiA+IGltbWVkaWF0ZWx5Lg0KPiA+ID4gR29pbmcgYmFjayB0byA2LjE0
LjMgaW1tZWRpYXRlbHkgYnJlYWtzIG1ETlMgYWdhaW4sIGJ1dCB0aGUgSVB2Ng0KPiA+ID4gYWRk
cmVzcyB3aWxsIHN0YXkgdGhlcmUgZm9yIGEgd2hpbGUgYmVmb3JlIGRpc2FwcGVhcmluZyBsYXRl
ciwNCj4gPiA+IHBvc3NpYmx5IGJlY2F1c2UgdGhlIERIQ1AgbGVhc2UgZXhwaXJlZD8gSSBhbSBu
b3Qgc3VyZSBleGFjdGx5DQo+ID4gPiB3aGVuDQo+ID4gPiBpdCBzdG9wcyB3b3JraW5nLg0KPiA+
ID4gDQo+ID4gPiBJJ3ZlIGRvbmUgYSBrZXJuZWwgYmlzZWN0IGJldHdlZW4gNi4xNC4yIGFuZCA2
LjE0LjMgYW5kIGZvdW5kIHRoZQ0KPiA+ID4gb2ZmZW5kaW5nIGNvbW1pdCB0aGF0IGNhdXNlcyBt
RE5TIHRvIGZhaWw6DQo+ID4gPiANCj4gPiA+IGNvbW1pdCA4MDAwN2QzZjkyZmQwMThkMGEwNTJh
NzA2NDAwZTk3NmIzNmUzYzg3DQo+ID4gPiBBdXRob3I6IE1pbmcgWWVuIEhzaWVoIDxtaW5neWVu
LmhzaWVoQG1lZGlhdGVrLmNvbT4NCj4gPiA+IERhdGU6wqDCoCBUdWUgTWFyIDQgMTY6MDg6NTAg
MjAyNSAtMDgwMA0KPiA+ID4gDQo+ID4gPiDCoMKgwqAgd2lmaTogbXQ3NjogbXQ3OTI1OiBpbnRl
Z3JhdGUgKm1sb19zdGFfY21kIGFuZCAqc3RhX2NtZA0KPiA+ID4gDQo+ID4gPiDCoMKgwqAgY29t
bWl0IGNiMTM1M2VmMzQ3MzVlYzFlNWQ5ZWZhMWZlOTY2ZjA1ZmYxZGMxZTEgdXBzdHJlYW0uDQo+
ID4gPiANCj4gPiA+IMKgwqDCoCBJbnRlZ3JhdGUgKm1sb19zdGFfY21kIGFuZCAqc3RhX2NtZCBm
b3IgdGhlIE1MTyBmaXJtd2FyZS4NCj4gPiA+IA0KPiA+ID4gwqDCoMKgIEZpeGVzOiA4NmMwNTFm
MmM0MTggKCJ3aWZpOiBtdDc2OiBtdDc5MjU6IGVuYWJsaW5nIE1MTyB3aGVuDQo+ID4gPiB0aGUN
Cj4gPiA+IGZpcm13YXJlIHN1cHBvcnRzIGl0IikNCj4gPiA+IA0KPiA+ID4gwqBkcml2ZXJzL25l
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkyNS9tY3UuYyB8IDU5ICsrKystLS0tLS0tDQo+
ID4gPiAtLS0tDQo+ID4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KPiA+ID4gwqAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA1NSBkZWxldGlv
bnMoLSkNCj4gPiA+IA0KPiA+ID4gSSBkbyBub3Qga25vdyBpZiB0aGlzIHNhbWUgY29tbWl0IGlz
IGFsc28gY2F1c2luZyB0aGUgSVB2NiBpc3N1ZXMNCj4gPiA+IGFzDQo+ID4gPiB0ZXN0aW5nIHRo
YXQgcmVxdWlyZXMgcXVpdGUgYSBiaXQgb2YgdGltZSB0byByZXByb2R1Y2UuIFdoYXQgSSBkbw0K
PiA+ID4ga25vdyB3aXRoIGNlcnRhaW50eSBhcyBvZiB0aGlzIG1vbWVudCBpcyB0aGF0IGl0IGRl
ZmluaXRlbHkNCj4gPiA+IGJyZWFrcyBpbg0KPiA+ID4ga2VybmVsIDYuMTQuMy4NCj4gPiA+IA0K
PiA+ID4gSSd2ZSBhdHRhY2hlZCBteSBoYXJkd2FyZSBpbmZvIGFzIHdlbGwgYXMgZG1lc2cgbG9n
cyBmcm9tIHRoZQ0KPiA+ID4gbGFzdA0KPiA+ID4gd29ya2luZyBrZXJuZWwgZnJvbSB0aGUgYmlz
ZWN0IGFuZCA2LjE0LjQgd2hpY2ggZXhoaWJpdHMgdGhlDQo+ID4gPiBpc3N1ZS4NCj4gPiA+IFBs
ZWFzZSBsZXQgbWUga25vdyBpZiB0aGVyZSdzIGFueSBvdGhlciBpbmZvIHlvdSBuZWVkLg0KPiA+
ID4gDQo+ID4gPiBUaGFua3MhDQo+ID4gPiBCZW5qYW1pbiBYaWFvDQo+ID4gDQo+ID4gSGksDQo+
ID4gDQo+ID4gVGhhbmtzIGZvciByZXBvcnRpbmcgdGhpcyBpc3N1ZSwgd2Ugd2lsbCBhaW0gaW50
byB0aGlzLg0KPiA+IA0KPiA+IENhbiB5b3UgcHJvdmlkZSBtZSB3aXRoIHlvdXIgdGVzdGluZyBz
dGVwcz8NCj4gPiANCj4gPiBCZXN0IFJlZ2FyZHMsDQo+ID4gWWVuLg0KPiA+IA0KPiANCj4gSGkg
WWFuLA0KPiANCj4gSSBzZWUgdGhlIHNhbWUgSVB2NiBpc3N1ZSBvbiBteSBGcmFtZXdvcmsgMTMg
KFJ5emVuIDUgQUkgMzQwKSB3aXRoIGFuDQo+IG10NzkyNWUgV2lGSSBtb2R1bGUuIE15IHNldHVw
IGlzIGp1c3QgYSBob21lIHJvdXRlciB3aXRoIG5hdGl2ZSBJUHY2DQo+IGJvdGggZm9yIG15IHVw
bGluayBhbmQgaW4gdGhlIExBTi4gVGhlIHByb2JsZW1zIHdpdGggSVB2NiBjYW4gYWxyZWFkeQ0K
PiBiZSBzZWVuIGp1c3QgaW4gdGhlIExBTiBmb3IgZXhhbXBsZSBieSBjaGVja2luZyB3aGljaCBJ
UCB3YXMgdXNlZCBmb3INCj4gU1NILCBpbiBteSBzZXR1cCBpdCBzaG91bGQgYWx3YXlzIGJlIElQ
djYgYnV0IGZhbGxzIGJhY2sgdG8gSVB2NCBpbg0KPiB0aGUNCj4gYnJva2VuIHN0YXRlLg0KPiAN
Cj4gQXMgYW5vdGhlciBkYXRhIHBvaW50LCBJIHRyaWVkIHJldmVydGluZyBjYjEzNTNlZjM0NzMg
KCJ3aWZpOiBtdDc2Og0KPiBtdDc5MjU6IGludGVncmF0ZSAqbWxvX3N0YV9jbWQgYW5kICpzdGFf
Y21kIikgb24gdG9wIG9mIDYuMTUuLXJjNC4NCj4gVGhpcw0KPiBmdWxseSByZXN0b3JlcyBJUHY2
IGZvciBtZS4gQWxzbyBub3RlIEknbSBydW5uaW5nIHRoaXMgd2l0aCB0aGUNCj4gbXQ3OTI1DQo+
IGZpcm13YXJlIHZlcnNpb24gMjAyNTA0MjUwNzMzMzAgZnJvbSBsaW51eC1maXJtd2FyZSdzIG1h
c3RlciBicmFuY2gNCj4gYXMNCj4gSSBoYWQgc29tZSBkcm9wcGVkIGNvbm5lY3Rpb25zIHdpdGgg
ZWFybGllciBmaXJtd2FyZS4NCj4gDQo+IFNvIGl0IGRlZmluaXRlbHkgbG9va3MgbGlrZSB0aGF0
IGNvbW1pdCBhbHNvIGJyb2tlIElQdjYgYW5kIG5vdCBqdXN0DQo+IG1ETlMuIE5vdGUgdGhhdCBp
ZiBpZiBJIHVzZSBESENQdjYgaW5zdGVhZCBvZiByb3V0ZXIgYWR2ZXJ0aXNlbWVudHMsDQo+IG9u
DQo+IHRoZSBsYXRlc3QgZmlybXdhcmUsIGJ1dCB3aXRob3V0IHRoZSByZXZlcnQsIEkgZ2V0IGEg
Z2xvYmFsIElQdjYNCj4gYWRkcmVzcyBhZGRlZCB0byB0aGUgaW50ZXJmYWNlIGJ1dCB0aGVuIG5h
dGl2ZSBJUHY2IGFkZHJlc3NlcyBhcmUNCj4gc3RpbGwNCj4gdW5jcmVhY2hhYmxlLiBXaXRoIHRo
ZSBvZmZlbmRpbmcgcGF0Y2ggcmV2ZXJ0ZWQgbXkgU1NIIHNlc3Npb24gdG8gYW4NCj4gSVB2NiBv
bmx5IGhvc3Qgd29ya3MgZmluZSBhbmQgaXMgc3RhYmxlLiBBbHNvIEknZCBiZSB3aWxsaW5nIHRv
IHRlc3QNCj4gYQ0KPiBwcm9wZXIgZml4IGFzIEkgcmVseSBvbiBJUHY2IGhlYXZpbHkgZHVlIHRv
IGhhdmluZyB0byB1c2UgQ0dOQVQgZm9yDQo+IElQdjQgYnV0IG5vdCBmb3IgSVB2Ni4NCj4gDQo+
IA0KPiBUaGFua3MsDQo+IE5pa2xhcw0KDQpIaSBCZW5qYW1pbiAmIE5pa2xhcywNCg0KQ2FuIHlv
dSBoZWxwIHRvIHRyeSB0aGlzIHBhdGNoPyBJIGNhbiBnZXQgSVB2NiBhZGRyZXNzIHRocm91Z2gg
dGhpcw0KcGF0Y2guDQoNCklmIGl0IGNhbiB3b3JrIGF0IHlvdXIgZW52aXJvbm1lbnQgYXMgd2Vs
bCwgaSB3aWxsIHVwc3RyZWFtIGl0IGFuZCBhZGQNCnRlc3QgdGFnIHdpdGggeW91Lg0KDQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MjUvbWN1LmMN
CmIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MjUvbWN1LmMNCmluZGV4
IGE0MmI1ODQ2MzRhYi4uZmQ3NTZmMGQxOGY4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MjUvbWN1LmMNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL21lZGlhdGVrL210NzYvbXQ3OTI1L21jdS5jDQpAQCAtMjE4MywxNCArMjE4MywxNCBAQCBt
dDc5MjVfbWN1X3N0YV9jbWQoc3RydWN0IG10NzZfcGh5ICpwaHksDQogICAgICAgICAgICAgICAg
ICAgICAgICBtdDc5MjVfbWN1X3N0YV9tbGRfdGx2KHNrYiwgaW5mby0+dmlmLCBpbmZvLQ0KPmxp
bmtfc3RhLT5zdGEpOw0KICAgICAgICAgICAgICAgICAgICAgICAgbXQ3OTI1X21jdV9zdGFfZWh0
X21sZF90bHYoc2tiLCBpbmZvLT52aWYsDQppbmZvLT5saW5rX3N0YS0+c3RhKTsNCiAgICAgICAg
ICAgICAgICB9DQotDQotICAgICAgICAgICAgICAgbXQ3OTI1X21jdV9zdGFfaGRyX3RyYW5zX3Rs
dihza2IsIGluZm8tPnZpZiwgaW5mby0NCj5saW5rX3N0YSk7DQogICAgICAgIH0NCg0KICAgICAg
ICBpZiAoIWluZm8tPmVuYWJsZSkgew0KICAgICAgICAgICAgICAgIG10NzkyNV9tY3Vfc3RhX3Jl
bW92ZV90bHYoc2tiKTsNCiAgICAgICAgICAgICAgICBtdDc2X2Nvbm5hY19tY3VfYWRkX3Rsdihz
a2IsIFNUQV9SRUNfTUxEX09GRiwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBzaXplb2Yoc3RydWN0IHRsdikpOw0KKyAgICAgICB9IGVsc2Ugew0KKyAgICAgICAgICAg
ICAgIG10NzkyNV9tY3Vfc3RhX2hkcl90cmFuc190bHYoc2tiLCBpbmZvLT52aWYsIGluZm8tDQo+
bGlua19zdGEpOw0KICAgICAgICB9DQoNCiAgICAgICAgcmV0dXJuIG10NzZfbWN1X3NrYl9zZW5k
X21zZyhkZXYsIHNrYiwgaW5mby0+Y21kLCB0cnVlKTsNCg0KDQpUaGFua3N+DQpZZW4uDQoNCg0K

