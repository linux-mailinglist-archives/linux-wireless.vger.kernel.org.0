Return-Path: <linux-wireless+bounces-39003-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /4QkCSyPVWpOqAAAu9opvQ
	(envelope-from <linux-wireless+bounces-39003-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 03:21:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A3C7500DB
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 03:21:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mediatek.com header.s=dk header.b=AKCGYNZ8;
	dkim=pass header.d=mediateko365.onmicrosoft.com header.s=selector2-mediateko365-onmicrosoft-com header.b=eOTkMPdp;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39003-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39003-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=mediatek.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F96E3009F52
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 01:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C49191F94;
	Tue, 14 Jul 2026 01:21:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43E01D5174
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 01:21:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783992105; cv=fail; b=D8wsUzDHXGiegOHCaNnxIpX9iuHqs4GGYxVIQFlitvYJa9F7vxL9aqyDGrYJ/nkYzABSy0v7Z1boIYfnU4irhAm+vR/twWkpbAX7aavpQUQ1n23O+/Jgq6gc7BCLtj2b+vUAOhlv+NffWh02cK8aCslQEWr8a47jKHcZtjctWSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783992105; c=relaxed/simple;
	bh=XRQumwOyK0lM6tWA6qr7to22f6Vd8Ql61Ig4Z8VLl8c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rX/6gmI51XGvU+mAHS72VBnciTtImXSgE5e/5wXT5yHCLMm7AIBPbcLRn3KwdC5ndSe9lMcK5iEJlNbAE31X1EIqVOEw49As7kmYyIpLRSxjgJfg42Uzs+8PCqGFP4S0udgJFs/29BEHBQSyCQmmyGMubaN9ngAZ10/E3RKJKDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=AKCGYNZ8; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=eOTkMPdp; arc=fail smtp.client-ip=210.61.82.184
X-UUID: 5c4130de7f2211f18dc8c9802ae25ab1-20260714
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=XRQumwOyK0lM6tWA6qr7to22f6Vd8Ql61Ig4Z8VLl8c=;
	b=AKCGYNZ8u30qSN1T8mNZKNdVZV5mT1y/7RMyJzXHYAbfpSdMAIvFTlFbqkZywCnX3SmSec/q9I90+o8JGlPdOTPB5TfPvgH1QatsYi6x4Ufm79+6zmjgJkKuu6cGX7axBDvcyuOE2rNRntZWw0e4OR+ZOuOKtKhOTHH8Eb0VmEY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:5e8b5cba-49eb-421e-b9a8-9035a8aa800c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:d497b38,CLOUDID:f0e91619-ab14-4403-9336-76696324c5a8,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|136|836|865|888|898,TC
	:-5,Content:0|15|50|99,EDM:-3|-100,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,
	QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
	ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5c4130de7f2211f18dc8c9802ae25ab1-20260714
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <eason.lai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 320039005; Tue, 14 Jul 2026 09:21:37 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 14 Jul 2026 09:21:36 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 14 Jul 2026 09:21:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWGvT1BjWbYIZDP8QGyeiKuOeNw/rFVshf9j9NwgNxBMVBn5XWkrPb2K9TYgI7kjcNrc4vVfMWn/BYzT3OURgfnyvJOa9wRl0YP3p2NDb5L1bJ2jx0lawnGln9QtDj6C1CpB9vU3xsHo3NCFbS+k/o82myBBesKLP1WoLqnYo1LG6fCZVfgs2hxHntPXUzOaNhvq0K/QLv/jaYJcy+NfgOwXtlvQm+r9OT3PQOhhwMWqBIPeBvuWV3biKsC1oOBFx8MLkz97GC3I1RL48kzld7ePqTCGZG80cXEByg80u0YDImw01AmUBN1jo0XjExhfUBiQ+ubRjF53mS81kXA45w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRQumwOyK0lM6tWA6qr7to22f6Vd8Ql61Ig4Z8VLl8c=;
 b=J0RU8o0P3KeetfTc7OJVaIc7/dANm5MGCrQiorF17ptxm1X6vug6X5Z7TicTwy+FrmAgq+DVjEQ0+Aaps1+rE2SOxm8PRAGFnN0NtiAQbC58NmTudPCSei5zpMSNmls2pVh4e18JfmJq1HAKqwnei23TcX2KrU9sV6EZs4uZ1GIBhH0vIBrea/YN7ZihWp6HiJ0TdA7Sgjy5QFxjT2U8kkTJcmd2tBWcX+Tt/Oe13HEDp1trb5ziSMgTZ3jfarxKi/b52CW/2/ztgx4wuRgAsZHTD/PPGd7hyGuL+9595jL2chvJt2Awt085MVzRhwybu+hmjsR0/+veuw/DJ2GaWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRQumwOyK0lM6tWA6qr7to22f6Vd8Ql61Ig4Z8VLl8c=;
 b=eOTkMPdpKZqksKa4xseq98qDLjiE8QoOEcSp3S92oT3yUyGnJejhVGPelYe8d51UU6DEpMV/izYfrAWd5R8amPqe+81lrpy2mlx64MtkRzVyZbpFwAn6loQNfstKE4YOElfzmAFeZg/oMntQBmDfWsS960bTYzoWMuTNlz+A2f0=
Received: from KL1PR03MB7079.apcprd03.prod.outlook.com (2603:1096:820:d5::5)
 by KL1PR03MB8072.apcprd03.prod.outlook.com (2603:1096:820:f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.19; Tue, 14 Jul
 2026 01:21:34 +0000
Received: from KL1PR03MB7079.apcprd03.prod.outlook.com
 ([fe80::9bd3:f66a:efd4:f6af]) by KL1PR03MB7079.apcprd03.prod.outlook.com
 ([fe80::9bd3:f66a:efd4:f6af%4]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 01:21:33 +0000
From: =?utf-8?B?RWFzb24gTGFpICjos7TmmJPogZYp?= <Eason.Lai@mediatek.com>
To: "nbd@nbd.name" <nbd@nbd.name>, "lorenzo@kernel.org" <lorenzo@kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	=?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?= <Mingyen.Hsieh@mediatek.com>
CC: =?utf-8?B?QWxsYW4gV2FuZyAo546L5a625YGJKQ==?= <Allan.Wang@mediatek.com>,
	=?utf-8?B?RXJpYy1TWSBDaGFuZyAo5by15pu45rqQKQ==?=
	<Eric-SY.Chang@mediatek.com>, =?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?=
	<Deren.Wu@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
	=?utf-8?B?UXVhbiBaaG91ICjlkajlhagp?= <Quan.Zhou@mediatek.com>,
	"Michael.Lo@mediatek.com" <Michael.Lo@mediatek.com>,
	=?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>,
	"Sean Wang" <Sean.Wang@mediatek.com>,
	=?utf-8?B?TGVvbiBZZW4gKOmhj+iJr+WEkik=?= <Leon.Yen@mediatek.com>,
	=?utf-8?B?S00gTGluICjmnpfmmIbmsJEp?= <km.lin@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: mt76: mt7921: Add PCIe AER handler support to
 prevent system crash
Thread-Topic: [PATCH v2] wifi: mt76: mt7921: Add PCIe AER handler support to
 prevent system crash
Thread-Index: AQHdEy0mSupRDbp3xE2QhiHUZjOow7ZsN9oA
Date: Tue, 14 Jul 2026 01:21:33 +0000
Message-ID: <14b59de82b480725e920452e941f4ab6efacae21.camel@mediatek.com>
References: <20251008085916.1626952-1-mingyen.hsieh@mediatek.com>
	 <d7eb196b01003a1de70456d5a31d9b4a37d555bd.camel@sipsolutions.net>
In-Reply-To: <d7eb196b01003a1de70456d5a31d9b4a37d555bd.camel@sipsolutions.net>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB7079:EE_|KL1PR03MB8072:EE_
x-ms-office365-filtering-correlation-id: e86b35b5-aa5c-42ed-91d3-08dee1463e0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 9hLCnrHfsIjVcQFJEYGZ0doKSwe8GtwiJM0WvGRwMIJacZ6IWqb0zv9XT0Tmmgdd4lMCv0JLbMCDty+RV0ooQX+uh/4d8J32gNx+ytzyycnpBIJ7SWL2LpHEJWx16Q/6NQVnva1waWKVDJn1YkwIu6eo7THlNPCohj5hIeDjHjpwK1uiekuHpK96/VLKv5o5cHaGUa5qRTRbTwR8mD2CSwxVbv0lNxg+BpK7vIaACBQr0w9TdraObb+FCMQwo4VfX48GWfpVAdiRXSJiZyPElBaWrnc0LCg110Ie19MnvDEEj5B3coLe2Pr+rH0xHdXNEUiPFBEOCXr6R3vDcz0DVCPw2/2jbYZTbLvOf8PCMFeo/0VxD1rdKijr6EAQzmydTAFewRJjc0EEuVyj6TNXT0/cdCPSN56G1R+FmH28OoAp1uGeZvYHmW0AAGnDANfnQP2tEFl+5QZhYcn7apdJyWm1NQVQzukoXw56+U+33SNiS+QLMnT0qaG74eBrvekzITap9HSATQ7a+ifrE9K2eoAA/p0wkpj/AaG9V1LOCA49d4/3kx1h3pITEaNsZcys8AKbVAs8qEmnZ4yPSIokixNNpB5kM7emM2groeD+wSHXlEqNlaf0BbNCOfODeKT8ZcJeAnyt06YrtnavPvlkeP/8PL/QvmSIy1xWKlUjrAZUrNCXXJwd/NZp5gLnpPc0CKSxIlL6qDnoVIZ9sOWgrXJ9dyzOvaiCNxKyBHVorzE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7079.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dm54aXl4VXEveTlwVW1MVHhKd3FpOHcvMXdJRTdsL1UxTE8zM2NKdWo5NFkw?=
 =?utf-8?B?TjV2U2l6aUwrVXkvNm1PRTZVR3I1c0VhVEx4NThiV1p2bW9kSElvM0tyeFpr?=
 =?utf-8?B?c29PeEhwRHR3SkMxOU10RSszTHl4RWp4bWVtZTlaTEszb2RDTXlIMnFKQXF2?=
 =?utf-8?B?RDVpRmd2aGxjeCtJTEpTOENRU211YkhsSTZuMUhTd2pjNUw0anRXNll3ZDZ1?=
 =?utf-8?B?ZnptZXM5cnBjK0tobHJ1ODZ0R29QZmZlbklhSEg1WnU1b1BaaU5uc1pmWCt0?=
 =?utf-8?B?YmFUZ2M1ZDVKblRJZGZtWjZvTG9VSEJxYTh2Q1FKcytXWHhTdCt3RHg1d3pO?=
 =?utf-8?B?dzN4d2dPYmN2RjFlZ1dzMWRTaXFVTFNpU0hMZTZuSkJFUTFwUUpuSHJnam1z?=
 =?utf-8?B?WTl0eHNqZlpwQzNENnp3SmhRcTYwbnZ4YVVrSmluc1ByYWQwTXJuSXRNWkU0?=
 =?utf-8?B?d2s3UnZ0VjlyMXdwWEZsT3ZPUVBscFo2ZzVRTnpHZkRJcWJZVzFqcGs1R09F?=
 =?utf-8?B?TmdDUlNPTnExZ1lGNzdpaEw3d0ltUGtUSFBEd2w3aFdiazNuaFVMelZINGRu?=
 =?utf-8?B?VGIvZU8vTEIwd3Z5eE5jQlA3czhNTDQ2Q2FDbEo3RDkzNS9wcElHSTUwRFlz?=
 =?utf-8?B?eGlZWHhFQlpPWlJJZWZtZGZaeTBjaUJhenF0eUVaMTNONnlZWWpRUWdDdExo?=
 =?utf-8?B?ZFRQMWxDSTl4azhiTzZiL0F3UHlaYm1uNlZmNmNSM3NJa09JRzU4bTY5dEdi?=
 =?utf-8?B?WUhDbS94SXhGeFZxUnFXcTh0bW9QVEhrdVNidEprMHpXZmRkcWliMmRSM0V6?=
 =?utf-8?B?TnhsZXY2VllCTVRhSTBjbTE5NkREa254K250QTdJeDY5SGNvWHJKczgwcU94?=
 =?utf-8?B?S1JSZHpzeW04S2tJUFFHK28wOE50TDZvdmdDWGZjd2grQVpEaFVoRTcyR2Np?=
 =?utf-8?B?QzZUMllBVkFrWStaVHNhN1dZRWZtWGhhYy81QUZSOVMzV2VaSmg3bHhIRmV3?=
 =?utf-8?B?dkw5cVFTTEtUWWRWZmF3ek8zdzYwakE5NXoyNkFZTlRSVlJSdWxPOSswMXB2?=
 =?utf-8?B?Z2F0Q3J4SlFSeDk0YjluREI4VGx1UTBsS2VlYkpiazR2SXkrbE1TMlFBYnAx?=
 =?utf-8?B?YUlsK3VyelhQOFBYczdad0hlN0tyZzZJTmkxQmpraGJ1SVFyNUpEL0V3eVNO?=
 =?utf-8?B?RG83RTBHQ1dRR3VOdHM5UUJKcm1PR2d5Z3FRQlZYWVdSaTI2Y3NZRG04TCtl?=
 =?utf-8?B?bHJqOUNlVEt6dGgwMDNKSkhxY1hxTjVBMnRDdWpnd3pxNEdkK1lxWGcvYVZa?=
 =?utf-8?B?eFlnOWNKeXRnd1FIRlNmYUl1bHk5ejhXQk9raWhVYzhhdlFJZTZDRWc5VG94?=
 =?utf-8?B?WTJQZE1pek12QnlHaTNqKzV5M0lxa25PVkpVS1ArdEVTVnF0OUxDanFjSWV0?=
 =?utf-8?B?S3lNZEFZVE5LVjZjZzl4SzJvU0tMZFpLZm1YbytsYys0TEhlTElBMTBxV1JM?=
 =?utf-8?B?ZFp3eXFDVGVUaDV5YTVoM1oxaS9UVUdYZmJIYWNYMm1qUDBVSDRha292WTFQ?=
 =?utf-8?B?bUMzQSsxcmRQOExqNE8zd0ttSDJ0OFk0QURyOHRkbzY0L1BpYW5wZXNLaEU4?=
 =?utf-8?B?U3NkTlc3ZmVpcGIvT3dCalhoVWE2MTdjNHJ4aS9GMUF4cmUxeFg5TEVuMHJi?=
 =?utf-8?B?QXdad0RKTWQ4Qzl0S09kSWJCTWtob0NpN1dldHhTWUNReUlyYUJPN01WTjV3?=
 =?utf-8?B?cnBxdHp3S0NtbWU5QUxTT28zTlNiT2R1Q0R2RGZmbHl2R1JSN0VoNTByN2Vm?=
 =?utf-8?B?V3JYYjd3N242VlYvR3FRS1AvekFLc0xoQU5lTFlMOFRyclI3YkJVdmNSVDVB?=
 =?utf-8?B?a2JjK2FiWURaZG5hakJQQ3haOGZrejlwbEdHWGwwS2dFTkVJSHpmVytRUXBp?=
 =?utf-8?B?MnFYck53aytRa0NkdDVlWU1lT2UxRlZ0R0hjaVEybkVoSTAwVWNwTDQ0SzMy?=
 =?utf-8?B?SXl0RTdtVnJlWEgxOGwzTWV3QUZKSFhiblUxU2hBYVNPM0RrZzhrN3Q0L2Qv?=
 =?utf-8?B?bTlkcExEMlVoLzZhOCtkOXN0QWxOZ1NjTHM4Yko1VWlDNC9uVWo2NnA0b3hh?=
 =?utf-8?B?b1ZoaWwrNThxWFdTQVFPeXJsZUJTT1FFc090Sk1wR3N1OHMrZ3RBelhEaFJm?=
 =?utf-8?B?Vm5UeWdMb0dWUWZmZ2hkM3doNGdHWGk2WUNzbmExQ3hmeGJHTk1Pak1MRy9Z?=
 =?utf-8?B?TE1rWVZxRG9scGZtTkdXcjdkRmJzOVlNdnV3WldpbFlJUlNCbHZhaHhIdFlQ?=
 =?utf-8?B?WU96QmtacVhXOUpMejM5Q0c1UjF3Q3BDMW1GYjNRa0xHTWhoWS90QlNtTndM?=
 =?utf-8?Q?eMUPSSiKdszHns3k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5DFA3D1639A1244A77E42393614641B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IiT16nCygDiZnrADrQPf8Qkv35pav4UYO/DQljuC1DefXytQm+c7bpxx8Zi04oNS2GlN1iQVF5/VdCtdV1t8j+RYbE4otMRDVs85u6k55dCMvmFFiTR0PHgDtzfMxpYy7OPsvltj0VrdOcRHsmBtdvifC7NBWWgN0idsFRshhUiYFp+MGg8f4f0yGiMWpvd1W10wNBuQwQnmKRgmsJY4aGiVPm/HARM05zKsTSX/pRgVmuj3rmUaB3FIDi/ntHEDb3sqbOHlvMCgpMFdg9lzm7DeDpSNORHhAE5dRyIBU3c/RSuusv1u307QJb4rm7W0/sXK6FOM3CllC1OYmCq7qA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7079.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e86b35b5-aa5c-42ed-91d3-08dee1463e0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 01:21:33.8336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3u2+Ib3vobE53Y2Cr+kuUEkkNQ9gb0ggaJYTYv2gtvtN/oyDaUzEBb1tZ+zERT05008D8EFeKK6ccr3WBAhXiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8072
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk,mediateko365.onmicrosoft.com:s=selector2-mediateko365-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-39003-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:johannes@sipsolutions.net,m:Mingyen.Hsieh@mediatek.com,m:Allan.Wang@mediatek.com,m:Eric-SY.Chang@mediatek.com,m:Deren.Wu@mediatek.com,m:Ryder.Lee@mediatek.com,m:Quan.Zhou@mediatek.com,m:Michael.Lo@mediatek.com,m:Shayne.Chen@mediatek.com,m:Sean.Wang@mediatek.com,m:Leon.Yen@mediatek.com,m:km.lin@mediatek.com,m:linux-mediatek@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mediateko365.onmicrosoft.com:dkim];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER(0.00)[Eason.Lai@mediatek.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[mediatek.com:+,mediateko365.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Eason.Lai@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30A3C7500DB

T24gV2VkLCAyMDI1LTEwLTA4IGF0IDExOjEyICswMjAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0K
PiBIaSwNCj4gDQo+IFNvIC4uLiB5ZWFoIGl0J3MgeW91ciBkcml2ZXIsIGFuZCB5ZXMgaXQncyBh
bHJlYWR5IGF0IHYyLCBidXQgLi4uDQo+IHRoaXMNCj4gc3RpbGwgc2VlbXMgdmVyeSBtdWNoIHBh
cGVyaW5nIG92ZXIgYSBwcm9ibGVtPw0KPiANCj4gT24gV2VkLCAyMDI1LTEwLTA4IGF0IDE2OjU5
ICswODAwLCBNaW5neWVuIEhzaWVoIHdyb3RlOg0KPiA+IA0KPiA+IFVuYWJsZSB0byBoYW5kbGUg
a2VybmVsIHBhZ2luZyByZXF1ZXN0IGF0IHZpcnR1YWwgYWRkcmVzcw0KPiA+IGZmZmZmZmMwMTA5
OWVhYzANCj4gPiBwYyA6IG10NzZfZG1hX2FkZF9idWYrMHgxMjQvMHgxODggW210NzZdDQo+IA0K
PiBXaHkgZG9lcyBpdCBldmVuIGNyYXNoIHRoZXJlPw0KPiANCg0KSXQncyBhbiBvdXQtb2YtcmFu
Z2UgYWNjZXNzOiB0aGUgSFcgcmV0dXJuZWQgYW4gdW5leHBlY3RlZCB2YWx1ZSB0aGF0DQp3YXNu
J3QgdmFsaWRhdGVkIGJlZm9yZSB1c2UuDQoNCnYzIHBvc3RlZCBoZXJlOg0KaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGludXgtd2lyZWxlc3MvMjAyNjA1MDYwNzA0NTguMzA5NjE4MC0xLWpiLnRz
YWlAbWVkaWF0ZWsuY29tLw0KDQpUaGFua3MsDQpFYXNvbg0KDQo+ID4gKysrIGIvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9hZ2ctcnguYw0KPiA+IEBAIC05Niw2ICs5Niw5IEBA
IG10NzZfcnhfYWdncl9yZW9yZGVyX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0DQo+ID4gKndvcmsp
DQo+ID4gwqAJc3RydWN0IHNrX2J1ZmZfaGVhZCBmcmFtZXM7DQo+ID4gwqAJaW50IG5mcmFtZXM7
DQo+ID4gwqANCj4gPiArCWlmIChhdG9taWNfcmVhZCgmZGV2LT5idXNfaHVuZykgPT0gMSkNCj4g
PiArCQlyZXR1cm47DQo+IA0KPiBBbmQgaG93IGRvZXMgc3ByaW5rbGluZyB0aGlzICJtYWdpYyBk
dXN0IiBhbGwgb3ZlciBldmVuIGRvIGFueXRoaW5nPw0KPiANCj4gDQo+IFRoaXMgc291bmRzIGEg
Yml0IGxpa2UgdGhlIGRyaXZlciBpc24ndCBhYmxlIHRvIGRlYWwgd2l0aCBzdXJwcmlzZQ0KPiBy
ZW1vdmFsLCB3aGF0IGhhcHBlbnMgaWYgeW91IGUuZy4gcm1tb2QgaXQgd2hpbGUgcnVubmluZyB0
cmFmZmljPyBJDQo+IGJlbGlldmUgdGhlIGVmZmVjdCBvZiB0aGUgZXJyb3IgcmVjb3Zlcnkgd291
bGQgYmUgc2ltaWxhciwgaWYgeW91DQo+IGRvbid0DQo+IGhhbmRsZSBpdCwgc28gYXJlIHlvdSBz
dXJlIHRoZXJlJ3Mgbm90IGEgY29tcGxldGVseSBkaWZmZXJlbnQNCj4gdW5kZXJseWluZw0KPiBi
dWc/DQo+IA0KPiBqb2hhbm5lcw0KDQoNCg0K

