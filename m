Return-Path: <linux-wireless+bounces-31730-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPqIBWxNjGmukgAAu9opvQ
	(envelope-from <linux-wireless+bounces-31730-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 10:35:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5FF122C8D
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 10:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 517D4300AEC5
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 09:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD843563ED;
	Wed, 11 Feb 2026 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WxmjleSf";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="QktMdR8j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED27354AE2;
	Wed, 11 Feb 2026 09:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770802536; cv=fail; b=NPi+87Qg+mQbGOL0GQKoW051BGlrKl4bfTXiL/KMvAVG/jRYhcFqQoNK/pyb/vFrjvTpd3E0BQxazTlwF5GVxqP6NdIdvyseGkgsfYgJInXtH9gvae/k5qsplKGI56hZTUTDnACZzBtAC/EwLOgdj7LpjTLg77sJt6pyG10PfiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770802536; c=relaxed/simple;
	bh=PJwZow5SZ9j6vekVDOYTNlOYtuuaVHBpUP5n5WbCkTs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ipUuDIvDCjzUAgCdEOctT87S80xH0xi1eUkjxVtC67D/L8K/oIbvJUbPexzB4RTrjahCewhwlkzlN2IN8MnF5Aerqj/PQKlvp+Q579RVsq+J13yqT0gxXGGPK8uF1QXlsez6s1p+0e3ZwfTSpoxJmMEyVFgrbzw8aB1uiDCtJSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=WxmjleSf; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=QktMdR8j; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 00b8a598072d11f185319dbc3099e8fb-20260211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=PJwZow5SZ9j6vekVDOYTNlOYtuuaVHBpUP5n5WbCkTs=;
	b=WxmjleSf8cGe/cBRw5xEI0KpYdpF9usW9jF5tbxmo4SfZFhS25SP+OacIoR6GzZyo+zpmv7HuBPvbuxgSJOeY+mwh8vp0l8NMnKMarWAb9sHskwBMS4Wn1f8KstFd4mjj00uwOmNu7IIjaHoN+d8QqPIuTvpxg/HwK86tyRVY+Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:ecedc389-f18e-40f6-9aae-0f97ca8050a8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:089394f0-16bd-4243-b4ca-b08ca08ab1d8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 00b8a598072d11f185319dbc3099e8fb-20260211
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 840522989; Wed, 11 Feb 2026 17:35:29 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 11 Feb 2026 17:35:27 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 11 Feb 2026 17:35:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObUbhwRG8sEWnC2ZUUAtuHk9fml3WxBrqPhRqf4pAtjPM0IGsTQ6V8ZVuROlRFfeTWy0X/TlhcfpmQ28s8q2zwi/8T6EPGCJyMOSpKx65189CKruL2kfOPesAjjlC99W8xIjxPkQQP4qaTWbPLHfCt/u+Ng0Zo6kW3Ku+2KvSSUGnHhvkd21GvNcBHzv0ixNBrcrEskBrtJYDwyNvYWYS9+hREk+PSmq/LIyGhKbIlt9/sCXVHLDlM/iz/wmHxGKYLgT/4Y1qTaqo7g5glu5ROL/hWsEKbMq042JyY6QNHWYupFNmX9QdQjGLNKo/DmfCip5LNQuwByPNiUR6+X6JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJwZow5SZ9j6vekVDOYTNlOYtuuaVHBpUP5n5WbCkTs=;
 b=P04eG39MCIxzirqVpaVA8bmZxS77hx0Lccq5qH0cGGAXkASkEA9zjaMtqGjBnZQ86INz5qtbXYkhudhM3WnTZLAS8F6iXKW4obgXgEF2hPpv8E6gqUnR4vBtyqSbl4KtxeLMzf1F/jhZAzk5fWBcZfDr2hFpG5SIQm0b6+0SjnH9owWnPx4kMS/ye4FaXygL771bibxx/xe5HJH5PbEYvkVx9N6ocwcn7H1xv1jyMe1JIc8o6XautKeUaH9KrOj7mrp6sbo1SnUou8SvJyCzlmQfEuDZhSDLbL7PdCpxyPCGiYTi/4rrORzcHnJD75UWqwLkYXoksSQSruNEYlRGaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJwZow5SZ9j6vekVDOYTNlOYtuuaVHBpUP5n5WbCkTs=;
 b=QktMdR8jCFecw/8hfg8TjR30YLCP6XQtvXsk9Y7ZfSyhZXA/9xauNBF+EoXfy5Rf3NRwKnz6kXBVLfux7U/YTlB626luB7OYh+D38da0dpAjMnIecnFsiHuPjVckH6eHUgvhW3fKtMi9Z2UETocLhBJht2T/1zgjcOD1aTNjzmo=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by TYUPR03MB7140.apcprd03.prod.outlook.com (2603:1096:400:347::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 09:35:25 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059%3]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 09:35:24 +0000
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
Thread-Index: AQHcmrhfdLixNmzm402cr6hZjqmOB7V9Cq4AgAAcbICAAAELgIAABKcAgAACKQCAAAUHAIAAAmwAgAADGgCAAASKgA==
Date: Wed, 11 Feb 2026 09:35:24 +0000
Message-ID: <8572882240ba94be8184ce93ee0eec7ffe3615db.camel@mediatek.com>
References: <8fa8ec500b3d4de7b1966c6887f1dfbe5c46a54c.1770746444.git.ryder.lee@mediatek.com>
	 <69521aebefef405bad5117d4d5d5fef4a5dfb7e8.1770746444.git.ryder.lee@mediatek.com>
	 <20260211-miniature-chital-of-plenty-1a71df@quoll>
	 <bd4da0a8522db2991ec0844233efe068323c2578.camel@mediatek.com>
	 <b00c8c18-930b-4cb9-975d-b15118bfc854@kernel.org>
	 <0dceffe2e1344830c12bc1f6516d13c7bb488b99.camel@mediatek.com>
	 <23561f00-9f3f-4d4d-81ae-aab9958bd797@kernel.org>
	 <0572bd6e56ca872e285729ccd4c2201517b66e18.camel@mediatek.com>
	 <388e874d-d9ff-43f2-b010-ca7ac29aa065@kernel.org>
	 <0c7b854e342e2047fbc9fc8e8fd80b67a6ec2bec.camel@mediatek.com>
In-Reply-To: <0c7b854e342e2047fbc9fc8e8fd80b67a6ec2bec.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|TYUPR03MB7140:EE_
x-ms-office365-filtering-correlation-id: 057b8461-0e77-4c9b-93bd-08de6950e258
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?aHBGUUxzV0Y5b2p1NFVwcHBwYUZaUFpROHhpekFMR2NKTmVlY2JQUWpLYjJ5?=
 =?utf-8?B?V3I0Wm5NcmZFdzRXejg3WnQ3LzhxcE02SERXSFVrRkg4Y2VzdkN4RGZhb2FE?=
 =?utf-8?B?V2Q2clBuaC94ZGxnRTZNSmdYVXMzdE1FVnc0a0pydzlvUmxyclkwRlo3cHRz?=
 =?utf-8?B?ZitUYzZ4aXdodU41U0FURWdQSDJVT0VETnBlVEg0cDdFdXBHZjM5Z3dDbGhS?=
 =?utf-8?B?bUFiUjBieVVQMW9ibnorcHE4ZU1WSldpa2Y5VHowNWRiemYvSEFUZWJLYXJy?=
 =?utf-8?B?VVNHZkNBVXVPNjZCekNJeThnK1pRUGpScGdVeDZRZ0VZdEt2ZmVSRnFybCtV?=
 =?utf-8?B?UmY4WXgwV3hwSml4VnFvcVU0cjNnekZTdUc4VExrU1hDaDNaN0F0QXU3cVB5?=
 =?utf-8?B?bk5hL0hrRWxDVTBwTmhCMHdmSUZkV09JeVpveWtZVmVoM0JwNjE4clhyLzlS?=
 =?utf-8?B?SFU5SUc0cVZsN0tNeDVHUTNsT1hjN28xaHlWbCtmcjBpK3N1VVVqTC96dGpl?=
 =?utf-8?B?UWJudFAxdXBiSVkwVnIxc2tQM3NCSUFRWm5ic3UvbTE2UHBIVVJJMnZlSC93?=
 =?utf-8?B?SzQ4SkIrUXV3ZXpoZUxUb2s3K1ZBWFpjQ3ZPKzhWUWlmSk5jZG5WM0dmeUdM?=
 =?utf-8?B?bUxabFhDS29LaWsxTllieHZ4ZU5aNTJ1b0NsMVpKK3hoUnl2K081K3dQL1h6?=
 =?utf-8?B?NlRMMC9mMlJNVWQ4UGZKeHFDcVB1bEZaaTdpY05PVUZYemNWenVwa0hXbTJD?=
 =?utf-8?B?R3A3SVJtVGpFV3hsSW82WFpaTC95RTJLRi9XeG82TnFlMjg2M3pST3VlL1Z0?=
 =?utf-8?B?RW9nR05LWS9wbDk5T2tnZXlEK0Mvb1phVTlORWZjUlJBRXdxbU5QWjNWdkFF?=
 =?utf-8?B?SkpXWlV0T01uSHJkTkxhSlRndTc2OGdDbHk0VTllNWVsZVVnQkY2RHE5K2ZU?=
 =?utf-8?B?NnB2aERJNjhwLytaN2ZYLzRFa0UwUDhiVlJmTmZtSFhVWGhnTDBsTmVScUtK?=
 =?utf-8?B?Qm05Vkl2aStaaFpMSC92aFFoYW9kcGNsdnU2ZmhmbVRDUzRvTmVHTCtaZ09G?=
 =?utf-8?B?M3ZjU0xNeUQ1WjAxQWt2NkdSUE8wK1dUQkZSc0k4VGs1dHZ4dTc0YzhtbTVw?=
 =?utf-8?B?WjJoVGFCU0U2bUEzcDVmVGE2Mnc0NXRJeGl5ZjFxQ0pIWGtzbWRPazlvYytw?=
 =?utf-8?B?SXJublFVZDBYTmRsdVg5Y2tYOXpIZVZvUE9oYjNTTjJMa1NoRmFnL0dENDBp?=
 =?utf-8?B?VnVzUDJxNlVpNVNIcE9uQ2xHZ0E3Y0NxYWZ6TUJnK2g0cUsyY3E1ZHpwUFJW?=
 =?utf-8?B?UFV6Rk5VUUtad0JDZnNjdC9hQmxsNVNqL3RlMS9hMngvMEFaR09xQlJLT0w4?=
 =?utf-8?B?OW82Yk9YUE1La0RHdmZ6aTRTZ2RxU1F2ak93Mm9yNVdJVTVLNDdEM1BMWlMz?=
 =?utf-8?B?aFpoaWI0ME4wNkJhanlPMnErY1g5SUdadEdmM0d1TFRFZXo5elhoUEcxTjZY?=
 =?utf-8?B?cGJwaFFyZEZqdDRsdXRFUjk5Njk3WHVUWDVldmd0d3ZNMVBhNE1PNi9YWWIw?=
 =?utf-8?B?VDVDakNMS3hWRzlKUU5YeXJDZzBQK043YXBNUUhZdThqa09Ob1RObGxQRzZS?=
 =?utf-8?B?L0x5UGxXNDdyMjYzQmN3UE5xdU9LcXlZMjRCeXpZb1NpRWRSWHJ2RzlSSGlQ?=
 =?utf-8?B?R1VJWGszRGRUQitFTWtMMDRka29zSTNUY0FtV2FCanp6WExlWnc1OVdpZzN1?=
 =?utf-8?B?SjFQNlNLOWQrWXdvMTN4dTdrZGlTWGw2dzRScE9MRUxuTmRQTEJ4RW9UNG9X?=
 =?utf-8?B?dEM1UnR4K0hWaGdrVXVyanE2YlI5T2lwcXdob05Zc3hMWUZpTnFSckRYTklj?=
 =?utf-8?B?cTl1TnY4SjBwK3BwL3JOOFNpTE1KOWV4b0VqSnAweDJtWC96SkNkamhKMkhG?=
 =?utf-8?B?MWRpVGNOd0dseUp1ejNKaGUyNFc1cDVpVTFJQkxNakRSM1FWTDhhbjdjT1Qr?=
 =?utf-8?B?Kytad2RaLzN2bUE1c1RHaytIV0hEeGZuTzdmelZsc1dSWHZUeEg1UWZ5TEdt?=
 =?utf-8?B?WG9Kd3BkcVpRRlFwRk5rWEVuMkcvVjZSV05NVm5XRS9mVEwraEg1M091eVRG?=
 =?utf-8?B?b0xXRnRVV2k5NTliL1MrWW9kSk1JU0NQSlFaWFlYQUtjYXlSR3FPMm52UzM3?=
 =?utf-8?Q?ZYeib7tQJoKmHG0YfmCOS4A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWp4cy9UVVljbkNEYzBmRGZvbjFxZFlEL1NFQVF2QzZPL0QzZVRXYmRzTEFH?=
 =?utf-8?B?d0RvQnpXZkxyeVlabDN3N2RmOTQ4b1VvaTB6RU56MHJBUVdaa1VJclBGRElC?=
 =?utf-8?B?UzFPa0VZUGdRMS85azIzMzNNaEI4VDExcnUzQ3JoenIzdHJBNHZGa1ZVYS9V?=
 =?utf-8?B?SGpkNmJoc0svYTBJbWhEb3pJZUNzaXlXVGZiaG5VNjQ5bVRGK0VjOEYzWGU3?=
 =?utf-8?B?ZENHaVZVblNTeFhDa3VFMll1VnE1bGU1WEhtK0l6VGR0bllwVGh3QWtyRVh3?=
 =?utf-8?B?VjhCUytiUnBCOXFodjNvUVlMS1ZPMU9GODgwSTU2SFltWnVINDUxV0VPT2Ir?=
 =?utf-8?B?M1hJZDhycTBIQlg2aFdBVzQzbXNNQTQyei9UTi9GN3RCNmZHWVc0bW9lMCtI?=
 =?utf-8?B?SzkyZUNDTkJISlJSRXF0Zk42MmhxdGRiY05mMWlYWU9FRkszdTlQT2xaaDBj?=
 =?utf-8?B?ZnZ2M3pzR2duYVd3RGgzNGlHUUZuc0c3OUNnWmtSaU44cXVOTDYwTEJ6QXBm?=
 =?utf-8?B?amxZcDg5aTZyN3pCaldMSUxJWWJsaFlwdVJ0QTlNbWZneTUzTi9ndFFhdmh0?=
 =?utf-8?B?U0dvYXcxdTJtOUNFeFpFQUU0UDJjT3VMMVFzSHFMcjY1QjBCZTY0TzFNUDlM?=
 =?utf-8?B?bDhqN2dsa3VacTlCdFR1NEJ4QS8wZGkvMkkyOXFKa2k4Q3liVERCc0QwZ2kr?=
 =?utf-8?B?S0JKSzNZeW9jOWFaY1dCamcrYm9wd3FxWjdXNnhGL3lnaWNYWlYwdUNZandM?=
 =?utf-8?B?ZGZYbGc1ZzBBMkc5Q1pLWHhPWjdqRUhrUjFRZ0NPRVRZaTFaK1RIWVdPNTlv?=
 =?utf-8?B?WEdWc1NSZnE2OEhydEVESFFSQnhkV1I0U2NpRVNab3hlWDZxL0MyVng1OUU1?=
 =?utf-8?B?bUd5Y3VFTGRzeDRKdUFnc2ptTlBFZzVob3U4Y1cycFFIZUlTd1hLMVR3b3lv?=
 =?utf-8?B?YjZqQWdMVE4xQ3ZQbFVtNU1NVnltNUJpbTljdURPQWtCZngyY3Z5VHUxZlZH?=
 =?utf-8?B?S2psUjgvZjN1aXU5bGh2Nm9MbkduK0FFNUp0Y1pveDNBRjE2N2IzZWgyZnl4?=
 =?utf-8?B?M3F0bG03TURXa0hUNWsvdHRQalRrQU9QNEk4QW5Wb3dza1V0K1lUNC82dFd0?=
 =?utf-8?B?Y2ptNFFQRmV5WmNvOXZHTU9wT09iWk1ncVIzSE9Pb3AwMlErd2pYSk8xTXo4?=
 =?utf-8?B?SkdMZkZFNnNGUERNMlJkYWtVbTZqMzduN3oyazVrMXVSa2xBV0JkekZnSHgx?=
 =?utf-8?B?WVNoU0o5Mi9uL1Nock5EL2NraDBzaTh4ZGphbCswUFRJcG1PcXpRcXYyc0Q2?=
 =?utf-8?B?eTZXd1J5eHRZYXdzU0RldzBBaWhLeXk2QXZhVFhhbUhjemZValFwS1hEUmM1?=
 =?utf-8?B?NFlVUnh4RjA3QVNzY0RwM2tqN2lQUFA3anlmbmsrMENWMVVzeVZabXdRL21E?=
 =?utf-8?B?bTc5MTBRWkRmMnZnU1JaT0ZwYWxPc2VOYThaUi9pRFVScFVwOE56QWhDWDdy?=
 =?utf-8?B?R01WRitaaTMwcHBWNmVyaHBqZDZBRzVFNG82M2VDdFhIN3FyQmY0RFVNWWd4?=
 =?utf-8?B?VzBhM2Z5UGJxRm9aKzU3eDNhWTE0YWxYb2g1V1hMVExiU1Q0WEZVWjlxMXMw?=
 =?utf-8?B?SGhlWDhvNjlGNk54dkNpYS81ODBOVGw4OWxvS2p5NEQ4TkxQSktMWlYvOE9y?=
 =?utf-8?B?OXRobG1vbHl6OFI5VUVDYmJTbEl5ajZGcUc0T2llOGRsZHF1bGRqVC9nMkpr?=
 =?utf-8?B?TWZGVzlBOVhINEUrVzVpM1B0MmxjRUNYdld5SFBRQXpuWFVtU002RlpUejR2?=
 =?utf-8?B?c2t2NUtQdTloNnJpNGg5YXBQYVd6SzdFWlppZkwvTXBhVFFwQkVwWHJrb2Zo?=
 =?utf-8?B?OG1vYlR1ZHBIcmdUem1nSG13N2hVUVkzK3RpZDZ5dnVBbDV6ZkMyM3lXZ1Y5?=
 =?utf-8?B?MGtRRVo0M1hjaTVHK0NpbVpTeVhnK1JGOC9qbW8rUnJ3U2gwMlRGSFVpdUow?=
 =?utf-8?B?eFg3alJNUENCaUJIWGNIS1JCdjBxYkNhcVJKTlAxNEZObVYxUGtPMDFmOXk3?=
 =?utf-8?B?b0F6SUlFZldackc4dkNUbmtFYVB4RW12Yi9DRWhqcHpHZHFnWTlFMmpvVHBu?=
 =?utf-8?B?Q2Z1dEVsQmZPN1JZSnl3a3dyUnhFYnBiblRmZlJUZ3dWd1hBUlQ5RHI1aWs2?=
 =?utf-8?B?c2NrOHYzSFVUd1pFSHhDOStlUUkrYjlDVERvWkZlSHpPZlVRMFJ2dlVubmxZ?=
 =?utf-8?B?aWxhNCt2NDF1bWxaMXQzUzFjUWlHODlFQUtkbDlkcUVKczZ1L1U4aHN3dDNa?=
 =?utf-8?B?Sm13SUcyZUNYZGoxQ0JnYnBaNjRWaDgvT2FLUVhSVHBBU1hTaTAreGkyY2J4?=
 =?utf-8?Q?bXdbWydns8Gr8QtQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B794C1403E39548B5126CE0858EC1EA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 057b8461-0e77-4c9b-93bd-08de6950e258
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 09:35:24.8556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DBK/zkF/Rz2qfGZ5NDb7KSCLxFq3nzS5kncMhMF8yw3j2WOUwrp3X7On8AS4JIBfwsugOs2YcZ9PkDWcOKrDeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7140
X-MTK: N
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk,mediateko365.onmicrosoft.com:s=selector2-mediateko365-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31730-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Ryder.Lee@mediatek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[mediatek.com:+,mediateko365.onmicrosoft.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 0B5FF122C8D
X-Rspamd-Action: no action

T24gV2VkLCAyMDI2LTAyLTExIGF0IDA5OjE5ICswMDAwLCBSeWRlciBMZWUgd3JvdGU6DQo+IE9u
IFdlZCwgMjAyNi0wMi0xMSBhdCAxMDowOCArMDEwMCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90
ZToNCj4gPiBPbiAxMS8wMi8yMDI2IDA5OjU5LCBSeWRlciBMZWUgd3JvdGU6DQo+ID4gPiBPbiBX
ZWQsIDIwMjYtMDItMTEgYXQgMDk6NDEgKzAxMDAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6
DQo+ID4gPiA+IE9uIDExLzAyLzIwMjYgMDk6MzMsIFJ5ZGVyIExlZSB3cm90ZToNCj4gPiA+ID4g
PiA+ID4gPiBXaHkgdGhpcyBjYW5ub3QgYmUgYSBzY2hlbWE/DQo+ID4gPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IFdlbGwsIGFjdHVhbGx5LCBpdCdzIGFscmVh
ZHkgYSBzY2hlbWEuIFRoaXMgaXMganVzdCBhbg0KPiA+ID4gPiA+ID4gPiBleHBhbmRlZA0KPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBXaGVyZSBleGFjdGx5Pw0KPiA+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gSG93IDFUMXNzIGlzIHVzZWQgYWNyb3NzIGRpZmZlcmVudCBnZW5l
cmF0aW9ucyBpcyB3aGF0IG15DQo+ID4gPiA+ID4gZXhhbXBsZQ0KPiA+ID4gPiA+IGFib3ZlDQo+
ID4gPiA+ID4gd2FzIHRhbGtpbmcgYWJvdXQuDQo+ID4gPiA+IA0KPiA+ID4gPiBXaGVyZSBleGFj
dGx5IGl0IGlzIGFscmVhZHkgYSBzY2hlbWE/IFBsZWFzZSBwb2ludCBtZSBsaW5lDQo+ID4gPiA+
IGVuY29kaW5nDQo+ID4gPiA+IHRoaXMuDQo+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+IGxpbmUg
MjQzIHBhdGhzLXJ1DQo+ID4gPiBsaW5lIDI2MSBwYXRocy1ydS1iZg0KPiA+IA0KPiA+IEkgZG8g
bm90IHNlZSB0aGVyZSBhbnl0aGluZyBsaWtlIHlvdSB3cm90ZSBoZXJlLiBZb3UganVzdCBsaXN0
IGFsbA0KPiA+IG9mDQo+ID4gdGhlbSwgbm8gZGV2aWNlIGNvbnN0cmFpbnRzLg0KPiA+IA0KPiA+
IEJlc3QgcmVnYXJkcywNCj4gPiBLcnp5c3p0b2YNCj4gPiANCj4gDQo+IFRoZSBvcmlnaW5hbCBz
Y2hlbWEgaXMgYSBicm9hZCBkZXNjcmlwdGlvbi4gTm93IGEgcmV2aWV3ZXIgd2FudCBtZSB0bw0K
PiBkZXNjcmliZSB0aGUgZGlmZmVyZW5jZXMgZm9yIHZhcmlvdXMgY29ubmVjdGVkIGRldmljZXMs
IGJ1dCBJIGRvbuKAmXQNCj4ga25vdyBob3cgdG8gYWRkIGEgY29tcGF0aWJsZSBzdHJpbmcgZm9y
IFBDSWUsIFVTQiwgb3IgZXZlbiBTRElPDQo+IGRldmljZXMNCj4gZm9yIHRoZWlyIGNvbnN0cmFp
bnRzLiBTbyBJIHVzZWQgdGhlIGRyaXZlcuKAmXMgZ2VuZXJhdGlvbiBuYW1lLi4uIGNhbg0KPiBJ
DQo+IGp1c3Qgd3JpdGUg4oCcbXQ3OTk24oCdPyBPciBkbyBJIG5lZWQgYSBjb21wbGV0ZSBhbmQg
bWVhbmluZ2Z1bA0KPiBjb21wYXRpYmxlDQo+IHN0cmluZz8NCj4gDQo+IE9yIG1heWJlIHRoZXJl
4oCZcyBubyBuZWVkIHRvIGNoYW5nZSB0aGUgZG9jdW1lbnRhdGlvbiBhdCBhbGwgYW5kIGp1c3QN
Cj4gbGV0IHRoZSBkcml2ZXIgaGFuZGxlIGl0LCBzbyB3ZSBkb27igJl0IGhhdmUgdG8gZGlzY3Vz
cyB0aGVzZSBkZXRhaWxzLg0KPiANCj4gUnlkZXINCg0KSSB0aGluayB3ZSBzaG91bGQganVzdCBk
cm9wIHRoaXMgRFRTIGNoYW5nZSBmb3Igbm93LiBJ4oCZbGwgZm9jdXMgb24gdGhlDQpbMS8yXSBk
cml2ZXIgY2hhbmdlLiBSaWdodCBub3csIHdl4oCZcmUganVzdCBtb3Zpbmcgd2hhdCB0aGUgZHJp
dmVyDQphbHJlYWR5IGRvZXMgaW50byB0aGUgZG9jdW1lbnRhdGlvbiwgd2hpY2ggZmVlbHMgYSBi
aXQgZXhjZXNzaXZlIHRvIG1lLg0KDQpUaGlzIG1ha2VzIHRoaW5ncyBzaW1wbGVyLg0KDQpSeWRl
cg0KDQo=

