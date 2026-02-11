Return-Path: <linux-wireless+bounces-31724-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WObHMC1FjGlxkQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31724-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 10:00:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4431D1227E0
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 10:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E770301F32B
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 08:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934C9353EE1;
	Wed, 11 Feb 2026 08:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OPZEwVkW";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="WyomEkdi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F19D34F46F;
	Wed, 11 Feb 2026 08:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770800376; cv=fail; b=evwIWya0/fqI8KbZJfGlCEOTPQUEmXBJfiHAX5c7kJiCNh94IXEHM+8FJJu2/3F6WDzhH+pvLn1BSqLkyIElYKGB7xOF4bPqOkEM7kXq0wwxb60uvAhowTTynext5uUMpioDA+kiTiCEeex6homLM59iPzu2ggdwneP16NGB0Mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770800376; c=relaxed/simple;
	bh=JM1ZyarOWsNzkG3KbfL6oenMseIf/doIIxla2dmICik=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wc8sqJWpu+Y/LSSTCjAMYWgJe9uZVxHv3QJ5oXOFfQQJn6QJW4trJEbdm6v6FPK3Bm8UZ/srDsKYbxxnQBVTk9y05dFcxtkNmDpPUdbYfl4wyupQdjgUvjCS+odGfzM1nREJGLaOlaBxaDbffl4FSUylQdsMprZg5mixBE45P1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OPZEwVkW; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=WyomEkdi; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f8413204072711f1b7fc4fdb8733b2bc-20260211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=JM1ZyarOWsNzkG3KbfL6oenMseIf/doIIxla2dmICik=;
	b=OPZEwVkWgZDUaufplZgMp9qonJJSxk4nd03eqO5esB2LUCwlgQDyyDFPzKMTAAP+HMPpkTcmKc/yOCu6Eoy7Sh2n0qhiSks/AnA4olrGT+FaA025Ou8C3eu/0mwN34q7yFBneZUUUtjVpudEWY+9tr+/9Xf/rE/PVnMe09vS8ng=;
X-CID-CACHE: Type:Local,Time:202602111613+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:31bb9735-3652-45bf-9d73-3ded05e72388,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:4c418fe9-ef90-4382-9c6f-55f2a0689a6b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil
	,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f8413204072711f1b7fc4fdb8733b2bc-20260211
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1870539221; Wed, 11 Feb 2026 16:59:27 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 11 Feb 2026 16:59:26 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 11 Feb 2026 16:59:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5sV2F8XPLUu1ho5z53djK7ZraZrKc5VDFs14RpMXyojgVchuKM8H/rYezpc5oW+Ud7/OExhHnU6HaSPnxceyBb0WUm9PWyHvVaLXyx0Y2du8DiIYjarcTwGAr/DgUfUmG23HPdojnD6gQFuDxYesLdRbUufTjp0tpk6DMXrdQWFoQcTltBxLw+J+C5CYD4gMuBchF9sIS6pgZfqpsCa0l45lX7Lcsu5470cD5cqxk8E9pkCEyzCaTroErHXTTWeBKB2QhkcXjQRWX8jni+03E4EYjc0UI03EPzOG5NNZJ9VQ71yCV/GY9yNCICcdtpGVGAYNVo4rKERC/C+Ir/oVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JM1ZyarOWsNzkG3KbfL6oenMseIf/doIIxla2dmICik=;
 b=nx5ekRddyI91sYGFXAe4jEsbnWk7az1ZuOpearkZo5ZkqIj+wuCtUlT3CMRKLtkuBq5ao172bfjK7ivnK6E39pn1p+1TFmYhUlGYCEYi33PNuzPfKzxb5uvCXU/2UiANPZW1AfgQ5OoYdN2uXRM+eTU7ulkekqX6isaxU+yTGxMtIEWPO0UXbDHGMsKTkg4qNWNRvKX1F1OgVc7sY8DM12JqVMpPwX0ECMNYVzeJJMgH++NpXn0FMYCfal4V6Eekp01xywk2u+bEYG5BEqtbNg7zA3xO4KPHCgUwJTRrAX/0UtTOL3ZwQjoUTyXFKGveZWwEOmML0MweTyzRwG5pOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JM1ZyarOWsNzkG3KbfL6oenMseIf/doIIxla2dmICik=;
 b=WyomEkdinbOU060kQ7fpHexFoO6ihXLWn32KbCqHn17wGjf21OO1YX0m10GGfL1tl7H7BwR3IwYI/y2w3lL70kGnmgZNZAP+uHfisFiB3yH97Aw+hcsQgOdAxHjVZhjPWVqi0wZbVDF0Fil0omcWeqQH0N6PEu+gxo17T7UgLyw=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by KUXPR03MB9362.apcprd03.prod.outlook.com (2603:1096:d10:40::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 08:59:24 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059%3]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 08:59:23 +0000
From: Ryder Lee <Ryder.Lee@mediatek.com>
To: "krzk@kernel.org" <krzk@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "nbd@nbd.name" <nbd@nbd.name>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?QWxsZW4gWWUgKOiRieiKt+WLsyk=?= <Allen.Ye@mediatek.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: net: wireless: mt76: clarify backoff
 limit format
Thread-Topic: [PATCH v3 2/2] dt-bindings: net: wireless: mt76: clarify backoff
 limit format
Thread-Index: AQHcmrhfdLixNmzm402cr6hZjqmOB7V9Cq4AgAAcbICAAAELgIAABKcAgAACKQCAAAUHAA==
Date: Wed, 11 Feb 2026 08:59:23 +0000
Message-ID: <0572bd6e56ca872e285729ccd4c2201517b66e18.camel@mediatek.com>
References: <8fa8ec500b3d4de7b1966c6887f1dfbe5c46a54c.1770746444.git.ryder.lee@mediatek.com>
	 <69521aebefef405bad5117d4d5d5fef4a5dfb7e8.1770746444.git.ryder.lee@mediatek.com>
	 <20260211-miniature-chital-of-plenty-1a71df@quoll>
	 <bd4da0a8522db2991ec0844233efe068323c2578.camel@mediatek.com>
	 <b00c8c18-930b-4cb9-975d-b15118bfc854@kernel.org>
	 <0dceffe2e1344830c12bc1f6516d13c7bb488b99.camel@mediatek.com>
	 <23561f00-9f3f-4d4d-81ae-aab9958bd797@kernel.org>
In-Reply-To: <23561f00-9f3f-4d4d-81ae-aab9958bd797@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|KUXPR03MB9362:EE_
x-ms-office365-filtering-correlation-id: e1b5bc18-048b-4700-cbaf-08de694bda3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?S0p6dDgvVjl1cVpmdEtGTjg1WWdoR3NZUndzRS9UUG5TTlZ1bjBUeml2YmdE?=
 =?utf-8?B?VmxkdEtjRTFNaXBXVHZmUnJBN3o3L0ticzMzRXlmQmNua1lHbTlKL2pkMis1?=
 =?utf-8?B?dnU5ZTJ4bXBqN0wzNjVyMWdNRnNCOVl4SHltTW9EMmVUMDNnbkh2RVEvZnY4?=
 =?utf-8?B?WG9DbUV3NFRMTjhjcWhrczNLa0dNcFllK2E0WEJOMG4vSXBQTW9ieUdxV3kv?=
 =?utf-8?B?dW90N1hlbkVhL3NIWnZhdDVzNjQzdU1YOGRjRnRoYndDQVpHV2gxc3ArNUVS?=
 =?utf-8?B?UFBTWXFLQUZTdlI3Y3BjTTBHL1hsRi9jdFlwTCtSYlZUa0NhUzd1cGsvMGZk?=
 =?utf-8?B?Tk5MeDRIUUZQaXRYd25BZUpHaXZGMFBZOTBTenNnSXNwK3JkbHFNZEw4RGRB?=
 =?utf-8?B?UVpRUTZEcEZsYUNpSk1rMjIwUWtaS0NRMmJJMU5JT2tKaE8xM3RoMHZGUGxF?=
 =?utf-8?B?YUJVMWdRMU5wbit5U01tSVRYSFQyTzJRUWZaMWRFL2dyWEFTTjJJeWU2NDY5?=
 =?utf-8?B?akNmWE1PN0xWNFV0bVZGQlpoLy9EbUQ0amcvVFc1bnlNc1R6dVgxTWcyOW9M?=
 =?utf-8?B?R0V1a1JqeFRSYmtiNDBQSis3N2tWVk1KNURGck9mcE45WmV1UHJPamViTHV6?=
 =?utf-8?B?eHVTVUdiWVQ3VmZYNFVjQkJuOU53VmlQc1NXVmVnallkMWY0aS9sdThlbStW?=
 =?utf-8?B?dFZaU1JHRUNOWTlUbDdrWkhUOFVHaWV4Z2dxVzBhbC9jUE4vVDNvbGE1SFBF?=
 =?utf-8?B?WWtPSVdsdUJuZ21sZytrOUVla3Irc2ZaSzVBb3JNMjBFWFcvZEtWUnRFalZ0?=
 =?utf-8?B?eFAvQzhJcnFpTCtlc3B1YzVTRWxCbnNnMEZiOGtzRkFDZXJ2aUJmeTBhdVBk?=
 =?utf-8?B?dWpzM2ZYZVdSZitRVk1Pc3hLSzdOUU0ydlcxVlg4VnE3cnhuamRFc2JSb0Jk?=
 =?utf-8?B?cU1aVG5rNmNTS2twKzJOaDIwYlpKbE11VGJ0aldCRU54SWpYTmRaOG9mN1Bm?=
 =?utf-8?B?M1ZjTkF5OU5tVXRlSFFuc3k0YzUyLzVNQm12MWovUm9VZSsxWEVybTV4MFd4?=
 =?utf-8?B?N3pwRW0zZkpIVGIzK0I0NVFST1ZkN1ZFVVE3b2hlMCtEQ293Q0gzZ0RHSUox?=
 =?utf-8?B?VGEwRm9EMHphL1JTcHFOWmtVOEFkMUxaUVhWRVd0ZklGalM3S2pONVhaMHkv?=
 =?utf-8?B?RHJDVm1oY2M4YStSVE9HZXRJWWI0bUI3azUrc1lRM2ppeFM2UktENGFDUVR0?=
 =?utf-8?B?T1ZhbWFLa3ZMTE5rS2NkSW05TUdleUZjcTRKQ1JRdnZQSW9TU2xIOGRaV3c4?=
 =?utf-8?B?bDdNRTRLM0xEQXI4Q0pFYWRTS2NjcHZMK1NZVk9IcFBCUjNTS2l6NUhnelRH?=
 =?utf-8?B?dUpCWEppc1hoc0JhN2d2SkZScXBrNUxIZUdZVXdTenF5RlpNOUxvNy9VSHps?=
 =?utf-8?B?Y3JIZVl2OGhMM1hjNDZlR2E1bHFRZHpBN0Y3cldWUmExK2pnYzZOd2djVHFQ?=
 =?utf-8?B?K1dxeThUM3dabXloTUxVeWFUNDlyeG4zb1dSYmVxclZ5ODhUaWQvblo0dkx2?=
 =?utf-8?B?U256Z0RZUDVyZzZJZXIrSXpYN3ZMbTBybzhadU1Kdmh0R3h6MmNYVHI0eEE2?=
 =?utf-8?B?amhOUWxMaHhCWUdyelR0c3M4dVgzYnFqQnNjVE9FNjhTTFBCMVR3VGE3by8x?=
 =?utf-8?B?cFREYlY0U1Y1QmlBQVdMcDAvSDlkc0oyM2V2WkFNOFl4RnFTNVdpWGdLZmZP?=
 =?utf-8?B?YTR4TWdpV0FWMUMvMEU1UlpJaWxtR3JZVE1Nbm0yMUxCWko1cXN0UVE5d2tw?=
 =?utf-8?B?VGl2K2Q2c2pZTWtIWHJ2b3k5TUU4NXQwSi81Q2tad3N0ZEp6REJzMzU2YnFT?=
 =?utf-8?B?RXVuak84V1VUc2J3VDZjVlkydnNYdFZtNW96eGJuakx0NmRneE9mMHMxd1R4?=
 =?utf-8?B?Zm5ERjh4R2NRTXFCajgya1h4VDJTQTFVblJLSUdrRHVDWVZOL1llRzBzcXN6?=
 =?utf-8?B?Y1ZMS3U4cXcrNDlkVW9tYU5Bb21PY1A4V28wK05TUGVCaDg2OXFUckpaRjZ2?=
 =?utf-8?B?bTZNMVBLUWUwL3QxMm1adFRJN0lmc1V2WjBiQklCNk1ERUd4NElreUFSRFp3?=
 =?utf-8?B?UHVRdTAxelVYanZHSld3ZS9HNVgydFpJaFcvd2xKMFB0NEZ1V3dOVy9aclVH?=
 =?utf-8?Q?Sdj+KbpwmAruM3xPS2PLbTs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXlSVVJ2dUJZdy9sU3E3em5BdTFXOXM4T0MzTmdkZU9nemdnc3lGN2RxYUxs?=
 =?utf-8?B?aVRaaDdTTGdLZ1NiWGU4dW1hdDRGWjRaZG91L3ZQa1FCSklDUDE3Vk5TTGxM?=
 =?utf-8?B?M0NUYmVOb0NWT2VCZk91YWcyNjNsblJkdDNtZlpjR1hpdGMxeUMyMWhKejhx?=
 =?utf-8?B?M000SDJ2bWNieTJhQ3Z3WFg3a0FtRHExb25QSm9Xa1ZHZHJqSHF0YlBzY0FL?=
 =?utf-8?B?Y094MVRqREd5R2lVTEJjbGF1OE5USzhPM2RiSXI2Q2hoOGVqNzZoL2VUODJ1?=
 =?utf-8?B?QVRlUXRhNmpRWkJwRFVkeVBXWmc0Wm9lNjZLeXVFUDlaVGZEVWxmUTBHaG11?=
 =?utf-8?B?Ui9sdnRvMU5TTVVJYjhNMFY1M250dWV1cjdxVjB1cTIxQXBqajZvRlFTSGNp?=
 =?utf-8?B?b1Btdnd2ZzIzbXh1Wi83UkVsak80bXkzNDl1cE55ZWRYRUVGTUw5Z2pxV2Qr?=
 =?utf-8?B?eGtRMWpmaDZZdEVsOHZoMHV3Tm5SM0kwczFEbVpmMmhmVzdEWnhCcFovMWxX?=
 =?utf-8?B?STBVLzZpZlorbUtJcldnL1FoK1V6aGg2Zm1EVDhpUU02QTd1dHNsUmtrcEp6?=
 =?utf-8?B?eDFGZ29QR25lbWt1UHM3UDg5Sk9NTkZRVzJLaWdtQmxGRjdLQzg4emx2bXZv?=
 =?utf-8?B?TlpTUlRIUjdQU1J3aFowUGx3TXVsZk5DbkNGSTdDOW1WU2RCdkZQOHhmMFM0?=
 =?utf-8?B?dU1Sa3JpZmFUb2luODBtVnl5eTU0WkN2dElpRzlNbUlaZDhkYWZkQUxQMk9G?=
 =?utf-8?B?SWlZeHIxSUlFZ0cyalBJaWpkeEwxSWhRSnZOUDNqRG1LSjd4M0p2cUU5K0FE?=
 =?utf-8?B?SVdGMnhSMzQ0eGVnT0V0R2ZaVnVaUmtXSWJCZUg0dGV3azFxOC9Bd2xZNU1z?=
 =?utf-8?B?a2dvK21VVzY3S3QzR21NNzlrWHp3ckxOYnZqUlJ5cXd2akF4am91NHNPZDlL?=
 =?utf-8?B?UFRhK1dpR0xZUjQ2K1BzdFF2QUF0SENkS0NGM24ybW9TQjJYMVBwU3hKWHlh?=
 =?utf-8?B?SWZJb043bndyU3pWcDRha05VV1dSNjdReFZhSVIyUURtVUp5N2tpMW1sV0lP?=
 =?utf-8?B?eUV5R2MrN1ZUdzhNNDVRcU10b0FBc1FaSGZzVXIyYUlMM0pKa3JJN3laNWFz?=
 =?utf-8?B?bERrdUZjMDVFU3hHcUEvR3lqRGZoN2hEd29qSHQ2eEZNRElsR0JSK3hxb0NJ?=
 =?utf-8?B?WG1zUXgxbHEwYkhGUUZ2YmJPaU11bVNvZWNpOTh6MmlwckNGZlVyQ3FYSXYy?=
 =?utf-8?B?YmplVWU3N2RVSVpzSUVXU09wZUFyd2Rqa0l0OTZYbzZpSmVyWWxaMzFlOE9F?=
 =?utf-8?B?UllON2syMWlwbnlBL3lrN3MzY1NQc3I3ZkN6dlZON2RpczlGRUZvTGdpdHlj?=
 =?utf-8?B?L0w4MXRYODlBa0ZoOE5pLzRIQklrWEdoelFsVHhJdXNZZSt6VStvWEIya2VO?=
 =?utf-8?B?NjFIMlB4dDMwUERMT0xmNkRyZTB2WkJlT2JBOXBIUTMzVlZIU2FlZDJLM2dC?=
 =?utf-8?B?Z215bWhaVUp5aEJhQ1kwZ1dGOWNkaHFRNnZiMys1TzBTQy8zeVVBWmFCaW54?=
 =?utf-8?B?NUk4aDQ3WTVoOExncUtDbmcwUFFNSGR2Um5sVURkZDhnUktwMkRRRHhsUlNL?=
 =?utf-8?B?UnpZOVFsT0pYUFpjdEhQblZMVTcyL3JmMEVTTVpXa1B4elhWY0VMenZ5RFRz?=
 =?utf-8?B?bXFscVUxRHQveWhoS0FxN1pYNUZEYlRDVi9TOXFVQTl5N1gvVHB1T2t2YkVI?=
 =?utf-8?B?ZTd1a2VpRHY2Y0lkL1IzOVRxVnFwSTU2MTk5SXhYQXc0TjIySEdDSFZNTkVQ?=
 =?utf-8?B?aHZIdFFpQ3NzeFNSZ25UZ1AzalIvc0JrTWdMTFF5aFNWYXBKUUFwZGcycXZN?=
 =?utf-8?B?QnNxOFRsaklqdU9PTktVbWp0MXFCOWZCNnRoOUF4K0YzYTVTTU1UNkFTQ1g2?=
 =?utf-8?B?N052Z2pTejkzNHViczlOWU95YTVMWVJFa3NCbmMrV1ZGY1BGSlBsemRDQjc5?=
 =?utf-8?B?OEo0OEYwd1RCUnNPWWMwbHd6ejlNSzltSEVldGhlRmptSGQyaUJGNCtCUmdE?=
 =?utf-8?B?UFo1ZzJwUlhsYm0xamZuYmpzMzVpa1hnSUEvRGhhVkZGdURzSmljN0dzQjd4?=
 =?utf-8?B?OFkrb2h4QkNxMG83NHMybVh6cWJ4M3JvM1duTEZTNndvdjJMVDJwQlBhVFYy?=
 =?utf-8?B?andub3U5akh2dDB5aVhoZG1hQ0F3TnF5YXdSa3VKNHZXUFMyMW9pYzVETU1a?=
 =?utf-8?B?N25LOUZZUXh1YVYzMGdqZzV6ZGU2Q3VEaXhXZGhBK0RWa2Y3Y01sdHBnQjJY?=
 =?utf-8?B?Wkt6S0V1NXNZdjZyZGI0SGRmRUNnMVZRUEd5VlJwK3VEb2M1aXNlTUpaVWFw?=
 =?utf-8?Q?e/Tooo0w4JgEwLso=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57542A89D084D34F9D2A1E1F6272E5F7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b5bc18-048b-4700-cbaf-08de694bda3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 08:59:23.7771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LWu6A9Dpgh8UylCgRQ4okcIi/3nXa8+glbbMoKT9/zcxfQ7KxVvZ5Fm+/88iTbxbsgDWZm5pEu129C6Xxz4fJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR03MB9362
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
	TAGGED_FROM(0.00)[bounces-31724-lists,linux-wireless=lfdr.de];
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
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 4431D1227E0
X-Rspamd-Action: no action

T24gV2VkLCAyMDI2LTAyLTExIGF0IDA5OjQxICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxMS8wMi8yMDI2IDA5OjMzLCBSeWRlciBMZWUgd3JvdGU6DQo+ID4gPiA+ID4g
V2h5IHRoaXMgY2Fubm90IGJlIGEgc2NoZW1hPw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+
ID4gPiBXZWxsLCBhY3R1YWxseSwgaXQncyBhbHJlYWR5IGEgc2NoZW1hLiBUaGlzIGlzIGp1c3Qg
YW4gZXhwYW5kZWQNCj4gPiA+IA0KPiA+ID4gV2hlcmUgZXhhY3RseT8NCj4gPiA+IA0KPiA+IA0K
PiA+IEhvdyAxVDFzcyBpcyB1c2VkIGFjcm9zcyBkaWZmZXJlbnQgZ2VuZXJhdGlvbnMgaXMgd2hh
dCBteSBleGFtcGxlDQo+ID4gYWJvdmUNCj4gPiB3YXMgdGFsa2luZyBhYm91dC4NCj4gDQo+IFdo
ZXJlIGV4YWN0bHkgaXQgaXMgYWxyZWFkeSBhIHNjaGVtYT8gUGxlYXNlIHBvaW50IG1lIGxpbmUg
ZW5jb2RpbmcNCj4gdGhpcy4NCj4gDQo+IA0KbGluZSAyNDMgcGF0aHMtcnUNCmxpbmUgMjYxIHBh
dGhzLXJ1LWJmDQoNCjFUMXNzIHJlZmVycyB0byB0aGUgc2Vjb25kIHJvdyBpbiB0aGUgZXhhbXBs
ZSBiZWxvdw0KDQpQcmV2aW91c2x5LCB3ZSB3ZXJlIG1haW5seSBkaXNjdXNzaW5nIGhvdyB0aGUg
ZHJpdmVyIHNob3VsZCBoYW5kbGUNCnBhcnNpbmcgMCB2ZXJzdXMgbm9uLXplcm8gY2FzZXMsIGJ1
dCB0aGlzIGNhbiBiZSBmdWxseSBtYW5hZ2VkIGJ5IHRoZQ0KZHJpdmVyIGl0c2VsZi4gTXkgWzEv
Ml0gcGF0Y2ggYWxyZWFkeSBleHBsYWlucyB0aGlzIGNsZWFybHkuDQoNCnBhdGhzLXJ1LWJmID0N
CjwxIDIwIDIyIDM4IDM2IDI0IDMwIDIzIDIxIDI4IDI5PiwNCjwxIDIwIDM5IDMxIDI1IDI2IDI1
IDI4IDMwIDM5IDM5PiwNCjwxIDM3IDM0IDI2IDI2IDI1IDIxIDM0IDIzIDM0IDI0PiwNCjwxIDAg
MjAgMjMgMzEgMjMgMzAgMzkgMjggMjkgMzY+LA0KPDEgMCAyNyAzNCAzMyAzNCAyOSAzOCAzMyAz
MyAyMj4sDQo8MSAwIDMwIDIzIDM5IDI4IDIxIDI1IDI5IDI4IDIxPiwNCjwxIDAgMzQgMjAgMzgg
MzIgMzUgMzMgMzcgMjYgMzY+Ow0KDQpXaGV0aGVyIHRoZSBEVFMgbmVlZHMgdG8gaW50ZXJwcmV0
IGl0IGlzIHJlYWxseSB1cCB0byBwZXJzb25hbA0KcHJlZmVyZW5jZS4gUGVyc29uYWxseSwgSSBk
b27igJl0IHRoaW5rIGl04oCZcyBuZWVkZWQgYnV0IEkgcmVzcGVjdA0KZXZlcnlvbmUncyBvcGlu
aW9uLg0KDQpPdXIgbmV3ZXIgSUMgZ2VuZXJhdGlvbnMgYXJlIG9ubHkgZ29pbmcgdG8gZ2V0IG1v
cmUgY29tcGxleC4gSWYgd2UNCmhhcmRjb2RlIHRvbyBtYW55IGRlZmluaXRpb25zIG5vdywgeW91
4oCZbGwgZW5kIHVwIGhhdmluZyB0byBjaGFuZ2UgdGhlbQ0KcmVwZWF0ZWRseS4gSXTigJlzIGJl
dHRlciB0byBsZXQgdGhlIGRyaXZlciBoYW5kbGUgdGhpcyBsb2dpYy4NCg0KUnlkZXINCg==

