Return-Path: <linux-wireless+bounces-22697-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FC9AAD2CD
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 03:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 109FB1767F4
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 01:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8BF142E67;
	Wed,  7 May 2025 01:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Oz/XyT9y";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="gRTpn2sa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22F913AD38;
	Wed,  7 May 2025 01:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746581325; cv=fail; b=crH+eZczm/vbamHC+Cw6UISe68gFIQP4HmTrmVEt3r9ur2TJz8Ci6GqcfG4fkfW7LgwjC7CcN0bO5yCzDkN02h2inRtLkXoqaHEOYUiI00qAdvGaK+ZIvoalprbDDGjAT2lLsrnemfJPf3aO6UI6o6n/SXsy/WxEDk15/tUUlsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746581325; c=relaxed/simple;
	bh=Mhm/CIPqgwfnIQNWOOedv/HpDAiGRmW692D55TauEFE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rHskyiJfhn8NdiBTTf3/4cfTlSLhyA+imEERlqmkOYsBmbOs6iZvOFOQIjFQLyaQUL9xAukzhvq6qLxZoIsskyopESa8XzOtLPWfjAt/8kj65UedaQoPbYphoG6O6LdhX63ZUG3h4GMyvKetiNOQ4bxaeq6W7EbFQIXGLcH8EZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Oz/XyT9y; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=gRTpn2sa; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9971dd7c2ae211f0813e4fe1310efc19-20250507
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Mhm/CIPqgwfnIQNWOOedv/HpDAiGRmW692D55TauEFE=;
	b=Oz/XyT9yxvm2XZ1aeCk9KoLM+rpAlXMPTasPXQmAPWLYnRfobctIn+UZBdiMp297+c8bSToBNkyOj2N/p/WeILNIxV8AtA13PfRHFGkIPMhyQIQ9oiNYA0SapTT3sfGzlMXkJ0I661s2dyDZzVNxCmXXhC9VyqpgG5liJKcMzUA=;
X-CID-CACHE: Type:Local,Time:202505070927+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:21ecba01-ff32-4b90-a82e-7c269ee408b5,IP:0,UR
	L:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:2
X-CID-META: VersionHash:0ef645f,CLOUDID:8f490196-efc9-47bf-92a2-b4a9ca59362d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:4|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9971dd7c2ae211f0813e4fe1310efc19-20250507
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 917877008; Wed, 07 May 2025 09:28:37 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 7 May 2025 09:28:35 +0800
Received: from TYDPR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 7 May 2025 09:28:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HvRMY8PH1MCi2ZD4/7//quKdV5MKfyLrSmui7ZXOIhU76bmtAsod4oKeKr9dt3tYfTEHrfNvG848rz1OqOC3OG1HnnkgOOWz4yEhWVGWl7LjKSDb5/TxNmgucX1VNr+wVgRnd4yB4PNo3tW/HW0Vq3lJir8WTLWcXQ3kNzuuXcPzfr2rPEQE87rO7pk6QBTlyTRv85EkDMws4pj6q1g+hIxqBlXzYud0uMkmRGO2kPiO/7Y2ftY3bR5jeuQx1BtyZOSQ9BY/iuq1wuYCxlqOqltxg7pKDDvnebxqcsBn8tltwTZTH7qOJdqLxe0KkLjcpc4PIAbPUvECKfDqtkpN5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mhm/CIPqgwfnIQNWOOedv/HpDAiGRmW692D55TauEFE=;
 b=ubuYURfdPP7dYCYjfhbOLicH4lkZMZ+BWCd08sEXchW44cCNsiStJkw7PsQVlfb/PziVJBWA+z0Ar214nEunjeoVbSlRUGRKySCGqenPf9z6kjnIvslQFmTbMqAAD06kCQGLCZmoQfkZJYXOVR55r5kdEBGJr8FqXgeAWOAc48OClUj8iBHxJFaFSiX6Rd15TCEVCE/okcoM/jSC5JKW/EpJL+x3Ej9Yk3J83SAUQP14MtfMA0ejYa4qq6IT5YoFz2l5YpHYxi5MJkwAanaAkBilA6I3hu57gD5Usk7eecwDwDkJXKC0gsLcU71SP9Tzy+RZ1FbfPsfiVRQJs1/Q6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mhm/CIPqgwfnIQNWOOedv/HpDAiGRmW692D55TauEFE=;
 b=gRTpn2sabnzbu4aPoAgik/GrpgSCFsh6LWFmJi6KNVIfV1FSUJYlR89sz01wXU/97G7NWHzntVs+Zk2qbkh1jJvDZMOtiCFKcaLZTlu4+UUAEeYMfGvGyU/x8YCQ8HzYdGMtS3KN985PkxnCF3pKxsy5TpAqaR/hWYu8YZSa3N4=
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com (2603:1096:4:ef::8) by
 JH0PR03MB8186.apcprd03.prod.outlook.com (2603:1096:990:49::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20; Wed, 7 May 2025 01:28:33 +0000
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741]) by SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741%6]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 01:28:33 +0000
From: =?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
	<Mingyen.Hsieh@mediatek.com>
To: "fossben@pm.me" <fossben@pm.me>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "niks@kernel.org"
	<niks@kernel.org>, =?utf-8?B?QWxsYW4gV2FuZyAo546L5a625YGJKQ==?=
	<Allan.Wang@mediatek.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>
Subject: Re: [REGRESSION][BISECTED][STABLE] MT7925: mDNS and IPv6 broken in
 kernel 6.14.3 and above
Thread-Topic: [REGRESSION][BISECTED][STABLE] MT7925: mDNS and IPv6 broken in
 kernel 6.14.3 and above
Thread-Index: AQHbuW1RnEt/GbhWjUulnPHycX5tgbO7xLGAgAXBBQCAAgoWgIAAKmkAgAD6HICAAbeFgA==
Date: Wed, 7 May 2025 01:28:33 +0000
Message-ID: <13d1421c6ec96b19b22dc379222600a905334f87.camel@mediatek.com>
References: <EmWnO5b-acRH1TXbGnkx41eJw654vmCR-8_xMBaPMwexCnfkvKCdlU5u19CGbaapJ3KRu-l3B-tSUhf8CCQwL0odjo6Cd5YG5lvNeB-vfdg=@pm.me>
	 <f73dec60b60dd7bb3be40c1feefbe223c7afe19b.camel@mediatek.com>
	 <5ae1ef34c9844d6d0f5fb167dd596a4c43321367.camel@kernel.org>
	 <28ef2cc608d071d1530902d7b5df045555ab5651.camel@mediatek.com>
	 <Q8fBN4506NOX9rrFspv9q0xuQRlE1YcHDbwfRUlXy7if-Lv-kGyIXPrNN2kOMoWENMYCfTmOhAhnSCs4gtUvpzEf0O_JZ_BV__V3B_A7iU8=@pm.me>
	 <vCzHyPICbb61hk8jzrTcmvU7H9PJGenEtIAZaKQH9ofNUZPD4aOeD1i-oDl2G2CtieHoTnUWBWYy-uQhNwRo7sT5gj_uyFQs-zIkbCY-qZU=@pm.me>
In-Reply-To: <vCzHyPICbb61hk8jzrTcmvU7H9PJGenEtIAZaKQH9ofNUZPD4aOeD1i-oDl2G2CtieHoTnUWBWYy-uQhNwRo7sT5gj_uyFQs-zIkbCY-qZU=@pm.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5322:EE_|JH0PR03MB8186:EE_
x-ms-office365-filtering-correlation-id: 87539cd8-ba95-43e2-09cc-08dd8d067b73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?utf-8?B?STlrZlVwVTRVQ3FXcDlxZ0xYUTgvUlpHcGJqK0lEdDZHUXFKSzBvNmVSQXRO?=
 =?utf-8?B?UzZ2ZGlabUJnQ0VUVHJRdWc5RWxqU3g0SkxnbkpuUzlNdFA3NjBQQkQyNlJp?=
 =?utf-8?B?UUYxMGhLaUd0SDJibTVPbExHcUlEQWpDTUdGZmxCNXRrMkMvUDRkNXVER3l0?=
 =?utf-8?B?aTZEeEgzTldRVHRrSlluNU83WDk3S0owQnFzZFpXV3BZSkdVbVdXd0RUem1k?=
 =?utf-8?B?bE5UZTlmSHFxdE5EMHpSZGUxK2N3Nk14SDdUNXV1ZkhCZDkxcmtDNUpISnIr?=
 =?utf-8?B?SnBQQlo0TkdGcFVlUkV0eUl3RktjVEF4SnlFY1cwZjZuNmdvOVlTNDM4bzAv?=
 =?utf-8?B?QVlyR09KQWxzMGJRQUMzN0owSURtRzNaclZrTllJc3FDRTBWYXJHMG5oWWNl?=
 =?utf-8?B?N05ZaGExV24rdVo1d3dNZ3lmMVdUY2p3NVg3QTFwQUlqZFlLKzZkdUw2MzI3?=
 =?utf-8?B?eVlaL3B0TFVZREh4bG5BS0FHMjl3RmxORjd6WTZmQTR0dVZ4U0hrRjhRRWJh?=
 =?utf-8?B?M2VjWnBrT3BJYXliZCtDOWV5cS94NUM5eHkwMzVnRS9xUVgwNzMzSUI2SjNM?=
 =?utf-8?B?VVFKQ1NhUFJGYU9sVHJHUXJHSExlcE5ZV0RSTWduTS80c2wvNm1ZSzdGMG1a?=
 =?utf-8?B?M1FiMzFIaW9rc2hRUmhnUTAvcTdHcnozZ0xmQSswc0VsVVV0YUdMVjlDTEFE?=
 =?utf-8?B?blpFaWNDak00TWxCQXdKcWlpTHV5ZHpiMDZCdzVhOGdKdURxTTFoYVVqMVFZ?=
 =?utf-8?B?emx6U0x3bGppdGhMOWlsNWxqYnlHSnFUcjI0RFRXQ1djUE1WN1p1aEw3TDRL?=
 =?utf-8?B?TnVsVUtJMTIrVEhkbzhFWkVTS0lMSWY2T251bWh2aEk2N2grQzBKQ2N5Yyt0?=
 =?utf-8?B?bmFuc1ZQQW4yVVNFSW9OVlQ5V29VRHh3anhFUGhicWhzOHY1a1F1SHdnTnNS?=
 =?utf-8?B?WmFDM2NEQ1l4QlB1OU5LTWIxY0JMVDdGNUczYzBoQ3l1Z1V3ZUxEdzRIdXdz?=
 =?utf-8?B?NVNRM0hLWDQyNUZmSDIyQ0IwbjZZZlZzUXJlMlJCMDlycUdaOG5CSzNvSFJ0?=
 =?utf-8?B?Z0NaRndXMS9aV0xCaExtMjAraEtSK1duS2M3ZEp5RjQ5ZEJaT2Nqc1BDR1I5?=
 =?utf-8?B?VnhrTFFuSnpWTUpmRzRNVVdTa2wwTTZOcXBzSmhWbmdaa3FMWXJCNytHdzJR?=
 =?utf-8?B?MkN3eDc1bUNpazdhdlBUc3U2QnMxV0tlQnFmNDh0MG5GeTVYd2F6MExzelkz?=
 =?utf-8?B?SWQwNHlaTHVUSVZKQWVoQyt2K0FLcldFVk9ydjBvTHdpRmNEU1dQQ2dyNFl2?=
 =?utf-8?B?M2xhdlNxVjN4WjhXMmw3YjhBMnV1bXVFd1AwZUN2L25LTEl1QXo3Tlk5eDR0?=
 =?utf-8?B?VDZ5ZG9YNnU4czV4MyszcVFleUszVXcwNVo3ZWZaU3ZXV044RU8vcGNtNlpP?=
 =?utf-8?B?bnVTOEdmMEo2Yk8zZEFpU0I2dFVGb0hzZWFQbHViMTcrck40bDJKRTR4c1pO?=
 =?utf-8?B?clJnZkVaY0dUWlR1NGFwRlpBMGViR0ZPYlg1VjFzRXN4TU1BbmhqS2xLZTAy?=
 =?utf-8?B?cXRUSkViUXN6Rk5DR3Q2K3NwOXpHUndzS3VNcE1iME1GSUZtWWlUN3U3cnB3?=
 =?utf-8?B?azlIdWdqZDAyMVpGNEs2aElJSlp5aEE1NzJQZkVCcHRDT0RZUWtOK0lLY0kz?=
 =?utf-8?B?b0lUYk10a1k1K1IrZ2wrWHY2THRPbXp0QVRxY2VrdklxZmRLaGtXQTZlZG9G?=
 =?utf-8?B?bUgzKzFlai9DLzFxeWFLcXVuejlMM251SVo5bUNLOGxhN05ybmgwY3NrOUZP?=
 =?utf-8?B?S3NXUzRpWVN4YjZ4R0EwbzczUWpCVjBaOXRJNi80cStyUTYwYk96elFNcy8z?=
 =?utf-8?B?RU5ZQmdsOTUxWHpNbllMazV2aVBSeSt2cUxlODRHbXNUWERyMW53NFc0L3JD?=
 =?utf-8?B?VXprZWN1YXpQSk5GUnRLRUNmMG1wY3Q1NWVTQWhHdFFqaUJuOE5LUDdIUEpY?=
 =?utf-8?Q?DS3DCftrexOcYs8G2/7/V0DbtbC9Sw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5322.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2oyRTd2VnB6UTlvdm4rRTkxdlRSZFZYWFlOM3NpSVZieERWV1I4aW0ySGcw?=
 =?utf-8?B?ZjJBYXprOGpTdWtIcStuRnp2WVd4TWdrU1dFSmVsbHBLc0k4MklOQytOV2xm?=
 =?utf-8?B?QStkV2R2ZExtZmV4UmUrUmZubkEvSmduM2IyMUVIRTdIdkZlOFIya0NtWFA0?=
 =?utf-8?B?NXBSZmdUL3grRFlma1F1NVdKd0Z6blhQTXAva2xFcXZEZTZRdldKVjNaREVx?=
 =?utf-8?B?VzRRS2ZuV1FMQTV6RC9QR2ZuaTJqblRUL2thckNEeXRFb2pTandjZ3dYNkQ3?=
 =?utf-8?B?cVVBbklrV05zOGtRdzhJWFRTSkljdWFUcDdNWXNHRlZpNkdXeGZ5b3BiQUNH?=
 =?utf-8?B?bElpSVd0ME5oaEVYV3Q3STRrYXZEaVpxLzBDV0tjQ1hUYWpNWlRhSXIwL2Ir?=
 =?utf-8?B?OVpKdDZMelZ3Y21VdUdzTEVhVGFPRms2MWh1cFpyb3R4b3BJSHExcmpPUWhz?=
 =?utf-8?B?K3ZPOTYrYjNoaTB0cjVML1lsNEZUMnBRL1lKUmlHMUhWSzZkWTVGZE8xeHdJ?=
 =?utf-8?B?MmNTVEpXYlpCcjFqdVFFOU9uVzcwRHYwbXcreTFvRjFWSjl5d2VIbE1GbTZo?=
 =?utf-8?B?VDhEMllxd3NMMFZPSDlrNHR3TEJLY1ExbUszQUM1Y3I0a21HQnVPZFdRR0Rw?=
 =?utf-8?B?MnU2MVNpYVoxWE5rdEFVTFR5ZFRRbGdFc3dSSk04L2RyUTMvYXlZQzUyT0xG?=
 =?utf-8?B?WUtVN2RHODh4YmFRRzM0VEZ1eElxeit1YkdJQ2Uzd1ozTWwyQ3FYREtKbHhZ?=
 =?utf-8?B?TmtpL3FmUGNxYnVQTDBIUVBxTzh6QXdsd0xtV0kxR0szTHRMVWo1NFR5MFdi?=
 =?utf-8?B?bnhLMm1WRE40TXVHTnp4QmJSWXVzS2s3LzV6RDAxbnBhMzd4SWh2OU1RNmRa?=
 =?utf-8?B?YmhiK3RLOFhKVERMNFNFVnM5djFGc0RBQ1J1dUFzZ3FQZ2orV1IzSEdrS2p6?=
 =?utf-8?B?WUhnVG9CelkwMFh0RnhjZ1FjLzlXd0lwYndkb3BuMU4zWERtSDdPdVBjMnFh?=
 =?utf-8?B?VWtQVThBTldpWSs3U1JjU3ZEOUd2eWFtNjZyU1Zxdjl4WHpiSkFaaExydkdt?=
 =?utf-8?B?K2lRM0tSWGdpMHhlR2ZZMTBFd1Z0RURUYkc0dU1hekQydXhZSHZoTWJzZGZ3?=
 =?utf-8?B?OGNFaDhxRDc3OThyenNod2pMbmwyTSt1VUZTTXZvZkdBMlZrN2FlcWRjWWM0?=
 =?utf-8?B?V0JHTHRtb3lPei9OdmJBSTBMdS9MNUUvblUwWGhzZ25XWklXY3J2c1cwcUc1?=
 =?utf-8?B?ZUFyV2YyZFh6U1R5ZHMyYmJPQTNrQWhyYU1xRXBRbVNpS05zSnpGT0c2dGFG?=
 =?utf-8?B?VkF5M1ZBR1dJVjhUb3A1SExrekd2Rm1waGQ2TmhaM2R0TkdHaGVIQjQyK2RN?=
 =?utf-8?B?YVBheDkwK1VkNG5lb0JsRW9NNDF3eTRHakl6cFRheGhpNWs0OW1rNUdnQTRH?=
 =?utf-8?B?eWFOcVFKSHp3T3JKS05KbUE2c0JlaE9lQ3ErZkZSdXl3ZUp5c0g2dzBIT1l2?=
 =?utf-8?B?akFjNGJEWlZVNEVDUDRwQ1YxZUtnTWhJSXF1WE0yd3JXRzVmeGV2WG9VNkty?=
 =?utf-8?B?NVlBMXMya3piNks2dHpTNnBXczY5SnlJd0JtU1dLcUpXYTNkNG1Nbis3RTdQ?=
 =?utf-8?B?bzl5MnRMZGFBbDBXTG8vdWtzWVhtUXIrMmdIUHBFY2dVTUNZYnZQN2liMmhp?=
 =?utf-8?B?eHI5cGZJaTQ1b0hzbHQyZEVjQTZZa2J6NUVJTkQwQkdqMURZbDlPNVVxYS9G?=
 =?utf-8?B?SVhULy9FaG0vbVJpeWJJMXAvZ1FCS0JndkRxWTYwUVEzNXJXTS9nRWZZREFv?=
 =?utf-8?B?UGxOYmFCTmFFTCtuSmVGV2oyeVFuNDRIUzhOdW8xbHRnZDNRSFRvTFA2WlRY?=
 =?utf-8?B?Q1hPOGVoSWFxNEFFZTN3bE4vcUJ3RUp4SVp4dVVJcFBaVkxyaG5ENEFGUmxK?=
 =?utf-8?B?cEdRMmIwa0hrMzJmN1ZrSFRweDk4M3lWSms5QkhOeXFGT3o4NmUyOXEwNWtx?=
 =?utf-8?B?KzVicFZ1eHFWLytMaHU4c2dneUgzWmFvcVJkWmJ3YTlXSXh0NTFqTXVEMU9L?=
 =?utf-8?B?L2tZam1JWENqTHdTSW1wY1RTV2RPcmwrcmY2UkdhUTc3MGdyakVKMW1KcjBx?=
 =?utf-8?B?YVNaQUowdGxKMktINHNFbGp2Ykpsd21UamFBOU9vSXZpdmpPaWI2eDFPTnJB?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEB7C43FA950B443B9067BB4E2BE4D49@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5322.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87539cd8-ba95-43e2-09cc-08dd8d067b73
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 01:28:33.6587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oTeU642cRADFrk3iXoddLpu6nSvQrCqmucrIAkwdgh41xd4881f2FIF1XV1ea297WuCIh0gqpE9H0ZN+RFeImHSkGheMTWiMlKxTfiurAA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8186

T24gTW9uLCAyMDI1LTA1LTA1IGF0IDIzOjE1ICswMDAwLCBmb3NzYmVuQHBtLm1lIHdyb3RlOg0K
PiANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUg
Y29udGVudC4NCj4gDQo+IA0KPiBPbiBNb25kYXksIE1heSA1dGgsIDIwMjUgYXQgMzoyMCBBTSwg
Zm9zc2JlbkBwbS5tZcKgPGZvc3NiZW5AcG0ubWU+DQo+IHdyb3RlOg0KPiANCj4gPiANCj4gPiAN
Cj4gPiBPbiBNb25kYXksIE1heSA1dGgsIDIwMjUgYXQgMTI6NDggQU0sIE1pbmd5ZW4gSHNpZWgN
Cj4gPiBNaW5neWVuLkhzaWVoQG1lZGlhdGVrLmNvbcKgd3JvdGU6DQo+ID4gDQo+ID4gPiBPbiBT
dW4sIDIwMjUtMDUtMDQgYXQgMDA6MzkgKzAyMDAsIE5pa2xhcyBTY2huZWxsZSB3cm90ZToNCj4g
PiA+IA0KPiA+ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mg
b3Igb3BlbiBhdHRhY2htZW50cw0KPiA+ID4gPiB1bnRpbA0KPiA+ID4gPiB5b3UgaGF2ZSB2ZXJp
ZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+ID4gPiANCj4gPiA+ID4gT24gV2Vk
LCAyMDI1LTA0LTMwIGF0IDA2OjQ3ICswMDAwLCBNaW5neWVuIEhzaWVoICjorJ3mmI7oq7opIHdy
b3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gPiBPbiBXZWQsIDIwMjUtMDQtMzAgYXQgMDE6MTQgKzAw
MDAsIGZvc3NiZW5AcG0ubWXCoHdyb3RlOg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gRXh0ZXJu
YWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4NCj4gPiA+ID4gPiA+
IGF0dGFjaG1lbnRzDQo+ID4gPiA+ID4gPiB1bnRpbA0KPiA+ID4gPiA+ID4geW91IGhhdmUgdmVy
aWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gSGVsbG8gYWxsLA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBBZnRlciB1cGdyYWRpbmcg
dG8gNi4xNC4zIG9uIG15IFBDIHdpdGggYSBNVDc5MjUgY2hpcCwgSQ0KPiA+ID4gPiA+ID4gbm90
aWNlZA0KPiA+ID4gPiA+ID4gdGhhdA0KPiA+ID4gPiA+ID4gSSBjb3VsZCBubyBsb25nZXIgcGlu
ZyAqLmxvY2FsIGFkZHJlc3NlcyBwcm92aWRlZCBieSBBdmFoaS4NCj4gPiA+ID4gPiA+IEluDQo+
ID4gPiA+ID4gPiBhZGRpdGlvbiwgSSBhbHNvIG5vdGljZWQgdGhhdCBJIHdhcyBub3QgYWJsZSB0
byBnZXQgYSBESENQDQo+ID4gPiA+ID4gPiBJUHY2DQo+ID4gPiA+ID4gPiBhZGRyZXNzIGZyb20g
bXkgcm91dGVyLCBubyBtYXR0ZXIgaG93IG1hbnkgdGltZXMgSSByZWJvb3RlZA0KPiA+ID4gPiA+
ID4gdGhlDQo+ID4gPiA+ID4gPiByb3V0ZXIgb3IgcmVjb25uZWN0ZWQgd2l0aCBOZXR3b3JrTWFu
YWdlci4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gUmV2ZXJ0aW5nIHRvIDYuMTQuMiBmaXhl
cyBib3RoIG1ETlMgYW5kIElQdjYgYWRkcmVzc2VzDQo+ID4gPiA+ID4gPiBpbW1lZGlhdGVseS4N
Cj4gPiA+ID4gPiA+IEdvaW5nIGJhY2sgdG8gNi4xNC4zIGltbWVkaWF0ZWx5IGJyZWFrcyBtRE5T
IGFnYWluLCBidXQgdGhlDQo+ID4gPiA+ID4gPiBJUHY2DQo+ID4gPiA+ID4gPiBhZGRyZXNzIHdp
bGwgc3RheSB0aGVyZSBmb3IgYSB3aGlsZSBiZWZvcmUgZGlzYXBwZWFyaW5nDQo+ID4gPiA+ID4g
PiBsYXRlciwNCj4gPiA+ID4gPiA+IHBvc3NpYmx5IGJlY2F1c2UgdGhlIERIQ1AgbGVhc2UgZXhw
aXJlZD8gSSBhbSBub3Qgc3VyZQ0KPiA+ID4gPiA+ID4gZXhhY3RseQ0KPiA+ID4gPiA+ID4gd2hl
bg0KPiA+ID4gPiA+ID4gaXQgc3RvcHMgd29ya2luZy4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gSSd2ZSBkb25lIGEga2VybmVsIGJpc2VjdCBiZXR3ZWVuIDYuMTQuMiBhbmQgNi4xNC4zIGFu
ZA0KPiA+ID4gPiA+ID4gZm91bmQgdGhlDQo+ID4gPiA+ID4gPiBvZmZlbmRpbmcgY29tbWl0IHRo
YXQgY2F1c2VzIG1ETlMgdG8gZmFpbDoNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gY29tbWl0
IDgwMDA3ZDNmOTJmZDAxOGQwYTA1MmE3MDY0MDBlOTc2YjM2ZTNjODcNCj4gPiA+ID4gPiA+IEF1
dGhvcjogTWluZyBZZW4gSHNpZWggbWluZ3llbi5oc2llaEBtZWRpYXRlay5jb20NCj4gPiA+ID4g
PiA+IERhdGU6IFR1ZSBNYXIgNCAxNjowODo1MCAyMDI1IC0wODAwDQo+ID4gPiA+ID4gPiANCj4g
PiA+ID4gPiA+IHdpZmk6IG10NzY6IG10NzkyNTogaW50ZWdyYXRlICptbG9fc3RhX2NtZCBhbmQg
KnN0YV9jbWQNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gY29tbWl0IGNiMTM1M2VmMzQ3MzVl
YzFlNWQ5ZWZhMWZlOTY2ZjA1ZmYxZGMxZTEgdXBzdHJlYW0uDQo+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+IEludGVncmF0ZSAqbWxvX3N0YV9jbWQgYW5kICpzdGFfY21kIGZvciB0aGUgTUxPIGZp
cm13YXJlLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBGaXhlczogODZjMDUxZjJjNDE4ICgi
d2lmaTogbXQ3NjogbXQ3OTI1OiBlbmFibGluZyBNTE8gd2hlbg0KPiA+ID4gPiA+ID4gdGhlDQo+
ID4gPiA+ID4gPiBmaXJtd2FyZSBzdXBwb3J0cyBpdCIpDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+IGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTI1L21jdS5jIHwgNTkg
KysrKy0tDQo+ID4gPiA+ID4gPiAtLS0tLQ0KPiA+ID4gPiA+ID4gLS0tLQ0KPiA+ID4gPiA+ID4g
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+ID4gPiA+
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDU1IGRlbGV0aW9ucygtKQ0KPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiBJIGRvIG5vdCBrbm93IGlmIHRoaXMgc2FtZSBjb21taXQgaXMg
YWxzbyBjYXVzaW5nIHRoZSBJUHY2DQo+ID4gPiA+ID4gPiBpc3N1ZXMNCj4gPiA+ID4gPiA+IGFz
DQo+ID4gPiA+ID4gPiB0ZXN0aW5nIHRoYXQgcmVxdWlyZXMgcXVpdGUgYSBiaXQgb2YgdGltZSB0
byByZXByb2R1Y2UuDQo+ID4gPiA+ID4gPiBXaGF0IEkgZG8NCj4gPiA+ID4gPiA+IGtub3cgd2l0
aCBjZXJ0YWludHkgYXMgb2YgdGhpcyBtb21lbnQgaXMgdGhhdCBpdCBkZWZpbml0ZWx5DQo+ID4g
PiA+ID4gPiBicmVha3MgaW4NCj4gPiA+ID4gPiA+IGtlcm5lbCA2LjE0LjMuDQo+ID4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+IEkndmUgYXR0YWNoZWQgbXkgaGFyZHdhcmUgaW5mbyBhcyB3ZWxsIGFz
IGRtZXNnIGxvZ3MgZnJvbQ0KPiA+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gPiBsYXN0DQo+ID4g
PiA+ID4gPiB3b3JraW5nIGtlcm5lbCBmcm9tIHRoZSBiaXNlY3QgYW5kIDYuMTQuNCB3aGljaCBl
eGhpYml0cw0KPiA+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gPiBpc3N1ZS4NCj4gPiA+ID4gPiA+
IFBsZWFzZSBsZXQgbWUga25vdyBpZiB0aGVyZSdzIGFueSBvdGhlciBpbmZvIHlvdSBuZWVkLg0K
PiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBUaGFua3MhDQo+ID4gPiA+ID4gPiBCZW5qYW1pbiBY
aWFvDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSGksDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhh
bmtzIGZvciByZXBvcnRpbmcgdGhpcyBpc3N1ZSwgd2Ugd2lsbCBhaW0gaW50byB0aGlzLg0KPiA+
ID4gPiA+IA0KPiA+ID4gPiA+IENhbiB5b3UgcHJvdmlkZSBtZSB3aXRoIHlvdXIgdGVzdGluZyBz
dGVwcz8NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBCZXN0IFJlZ2FyZHMsDQo+ID4gPiA+ID4gWWVu
Lg0KPiA+ID4gPiANCj4gPiA+ID4gSGkgWWFuLA0KPiA+ID4gPiANCj4gPiA+ID4gSSBzZWUgdGhl
IHNhbWUgSVB2NiBpc3N1ZSBvbiBteSBGcmFtZXdvcmsgMTMgKFJ5emVuIDUgQUkgMzQwKQ0KPiA+
ID4gPiB3aXRoIGFuDQo+ID4gPiA+IG10NzkyNWUgV2lGSSBtb2R1bGUuIE15IHNldHVwIGlzIGp1
c3QgYSBob21lIHJvdXRlciB3aXRoIG5hdGl2ZQ0KPiA+ID4gPiBJUHY2DQo+ID4gPiA+IGJvdGgg
Zm9yIG15IHVwbGluayBhbmQgaW4gdGhlIExBTi4gVGhlIHByb2JsZW1zIHdpdGggSVB2NiBjYW4N
Cj4gPiA+ID4gYWxyZWFkeQ0KPiA+ID4gPiBiZSBzZWVuIGp1c3QgaW4gdGhlIExBTiBmb3IgZXhh
bXBsZSBieSBjaGVja2luZyB3aGljaCBJUCB3YXMNCj4gPiA+ID4gdXNlZCBmb3INCj4gPiA+ID4g
U1NILCBpbiBteSBzZXR1cCBpdCBzaG91bGQgYWx3YXlzIGJlIElQdjYgYnV0IGZhbGxzIGJhY2sg
dG8NCj4gPiA+ID4gSVB2NCBpbg0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gYnJva2VuIHN0YXRlLg0K
PiA+ID4gPiANCj4gPiA+ID4gQXMgYW5vdGhlciBkYXRhIHBvaW50LCBJIHRyaWVkIHJldmVydGlu
ZyBjYjEzNTNlZjM0NzMgKCJ3aWZpOg0KPiA+ID4gPiBtdDc2Og0KPiA+ID4gPiBtdDc5MjU6IGlu
dGVncmF0ZSAqbWxvX3N0YV9jbWQgYW5kICpzdGFfY21kIikgb24gdG9wIG9mIDYuMTUuLQ0KPiA+
ID4gPiByYzQuDQo+ID4gPiA+IFRoaXMNCj4gPiA+ID4gZnVsbHkgcmVzdG9yZXMgSVB2NiBmb3Ig
bWUuIEFsc28gbm90ZSBJJ20gcnVubmluZyB0aGlzIHdpdGggdGhlDQo+ID4gPiA+IG10NzkyNQ0K
PiA+ID4gPiBmaXJtd2FyZSB2ZXJzaW9uIDIwMjUwNDI1MDczMzMwIGZyb20gbGludXgtZmlybXdh
cmUncyBtYXN0ZXINCj4gPiA+ID4gYnJhbmNoDQo+ID4gPiA+IGFzDQo+ID4gPiA+IEkgaGFkIHNv
bWUgZHJvcHBlZCBjb25uZWN0aW9ucyB3aXRoIGVhcmxpZXIgZmlybXdhcmUuDQo+ID4gPiA+IA0K
PiA+ID4gPiBTbyBpdCBkZWZpbml0ZWx5IGxvb2tzIGxpa2UgdGhhdCBjb21taXQgYWxzbyBicm9r
ZSBJUHY2IGFuZCBub3QNCj4gPiA+ID4ganVzdA0KPiA+ID4gPiBtRE5TLiBOb3RlIHRoYXQgaWYg
aWYgSSB1c2UgREhDUHY2IGluc3RlYWQgb2Ygcm91dGVyDQo+ID4gPiA+IGFkdmVydGlzZW1lbnRz
LA0KPiA+ID4gPiBvbg0KPiA+ID4gPiB0aGUgbGF0ZXN0IGZpcm13YXJlLCBidXQgd2l0aG91dCB0
aGUgcmV2ZXJ0LCBJIGdldCBhIGdsb2JhbA0KPiA+ID4gPiBJUHY2DQo+ID4gPiA+IGFkZHJlc3Mg
YWRkZWQgdG8gdGhlIGludGVyZmFjZSBidXQgdGhlbiBuYXRpdmUgSVB2NiBhZGRyZXNzZXMNCj4g
PiA+ID4gYXJlDQo+ID4gPiA+IHN0aWxsDQo+ID4gPiA+IHVuY3JlYWNoYWJsZS4gV2l0aCB0aGUg
b2ZmZW5kaW5nIHBhdGNoIHJldmVydGVkIG15IFNTSCBzZXNzaW9uDQo+ID4gPiA+IHRvIGFuDQo+
ID4gPiA+IElQdjYgb25seSBob3N0IHdvcmtzIGZpbmUgYW5kIGlzIHN0YWJsZS4gQWxzbyBJJ2Qg
YmUgd2lsbGluZyB0bw0KPiA+ID4gPiB0ZXN0DQo+ID4gPiA+IGENCj4gPiA+ID4gcHJvcGVyIGZp
eCBhcyBJIHJlbHkgb24gSVB2NiBoZWF2aWx5IGR1ZSB0byBoYXZpbmcgdG8gdXNlIENHTkFUDQo+
ID4gPiA+IGZvcg0KPiA+ID4gPiBJUHY0IGJ1dCBub3QgZm9yIElQdjYuDQo+ID4gPiA+IA0KPiA+
ID4gPiBUaGFua3MsDQo+ID4gPiA+IE5pa2xhcw0KPiA+ID4gDQo+ID4gPiBIaSBCZW5qYW1pbiAm
IE5pa2xhcywNCj4gPiA+IA0KPiA+ID4gQ2FuIHlvdSBoZWxwIHRvIHRyeSB0aGlzIHBhdGNoPyBJ
IGNhbiBnZXQgSVB2NiBhZGRyZXNzIHRocm91Z2gNCj4gPiA+IHRoaXMNCj4gPiA+IHBhdGNoLg0K
PiA+ID4gDQo+ID4gPiBJZiBpdCBjYW4gd29yayBhdCB5b3VyIGVudmlyb25tZW50IGFzIHdlbGws
IGkgd2lsbCB1cHN0cmVhbSBpdA0KPiA+ID4gYW5kIGFkZA0KPiA+ID4gdGVzdCB0YWcgd2l0aCB5
b3UuDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzkyNS9tY3UuYw0KPiA+ID4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzkyNS9tY3UuYw0KPiA+ID4gaW5kZXggYTQyYjU4NDYzNGFiLi5mZDc1NmYw
ZDE4ZjggMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9t
dDc2L210NzkyNS9tY3UuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0
ZWsvbXQ3Ni9tdDc5MjUvbWN1LmMNCj4gPiA+IEBAIC0yMTgzLDE0ICsyMTgzLDE0IEBAIG10Nzky
NV9tY3Vfc3RhX2NtZChzdHJ1Y3QgbXQ3Nl9waHkgKnBoeSwNCj4gPiA+IG10NzkyNV9tY3Vfc3Rh
X21sZF90bHYoc2tiLCBpbmZvLT52aWYsIGluZm8tDQo+ID4gPiANCj4gPiA+ID4gbGlua19zdGEt
PnN0YSk7DQo+ID4gPiA+IG10NzkyNV9tY3Vfc3RhX2VodF9tbGRfdGx2KHNrYiwgaW5mby0+dmlm
LA0KPiA+ID4gPiBpbmZvLT5saW5rX3N0YS0+c3RhKTsNCj4gPiA+ID4gfQ0KPiA+ID4gPiAtDQo+
ID4gPiA+IC0gbXQ3OTI1X21jdV9zdGFfaGRyX3RyYW5zX3Rsdihza2IsIGluZm8tPnZpZiwgaW5m
by0NCj4gPiA+ID4gbGlua19zdGEpOw0KPiA+ID4gPiB9DQo+ID4gPiANCj4gPiA+IGlmICghaW5m
by0+ZW5hYmxlKSB7DQo+ID4gPiBtdDc5MjVfbWN1X3N0YV9yZW1vdmVfdGx2KHNrYik7DQo+ID4g
PiBtdDc2X2Nvbm5hY19tY3VfYWRkX3Rsdihza2IsIFNUQV9SRUNfTUxEX09GRiwNCj4gPiA+IHNp
emVvZihzdHJ1Y3QgdGx2KSk7DQo+ID4gPiArIH0gZWxzZSB7DQo+ID4gPiArIG10NzkyNV9tY3Vf
c3RhX2hkcl90cmFuc190bHYoc2tiLCBpbmZvLT52aWYsIGluZm8tDQo+ID4gPiANCj4gPiA+ID4g
bGlua19zdGEpOw0KPiA+ID4gPiB9DQo+ID4gPiANCj4gPiA+IHJldHVybiBtdDc2X21jdV9za2Jf
c2VuZF9tc2coZGV2LCBza2IsIGluZm8tPmNtZCwgdHJ1ZSk7DQo+ID4gPiANCj4gPiA+IFRoYW5r
c34NCj4gPiA+IFllbi4NCj4gPiANCj4gPiANCj4gPiBIaSBZZW4sDQo+ID4gDQo+ID4gSSBtYW51
YWxseSBhcHBsaWVkIHRoZSBjaGFuZ2VzIG9uIHRvcCBvZiA2LjE0LjUgYW5kIG1ETlMgc2VlbXMg
dG8NCj4gPiB3b3JrIGFsb25nIHdpdGggSVB2NiEgSSB3aWxsIGRvIG1vcmUgdGVzdGluZyBmb3Ig
dGhlIHJlc3Qgb2YgdGhlDQo+ID4gZGF5IHRvIHNlZSBpZiB0aGUgaXNzdWUgaXMgY29tcGxldGVs
eSBmaXhlZCBidXQgc28gZmFyIGxvb2tzIGdvb2QNCj4gPiBhdCBsZWFzdCBmb3IgdGhlIDUgbWlu
dXRlcyBJJ3ZlIGJlZW4gdGVzdGluZyBpdC4NCj4gPiANCj4gPiBUaGFua3MgZm9yIHRoZSBmaXgs
DQo+ID4gQmVuDQo+IA0KPiBJJ3ZlIG5vdyB1c2VkIDYuMTQuNSB3aXRoIHRoZSBwYXRjaCBhcHBs
aWVkIGZvciBtb3N0IG9mIHRoZSBkYXkgYW5kDQo+IGl0J3MgYmVlbiB3b3JraW5nIGdyZWF0ISBt
RE5TIGhhcyBiZWVuIHJvY2sgc29saWQgYW5kIHNvIGhhcyBJUHY2Lg0KPiANCj4gV291bGQgYXBw
cmVjaWF0ZSBpdCBpZiB0aGlzIGZpeCBnb3QgYmFja3BvcnRlZCB0byB0aGUgNi4xNCBzZXJpZXMh
DQo+IA0KPiBCZW4NCg0KSGkgQmVuLA0KDQpUaGFua3MgZm9yIHRlc3RpbmcgaXQuIEFuZCBpdCB3
aWxsIGJlIGJhY2twb3J0aW5nIHRvIDYuMTQgc2VyaWVzIGFmdGVyDQp0aGUgbWFpbmxpbmUgbWVy
Z2VkIGl0Lg0KDQpZZW4uDQoNCg0KDQoNCg==

