Return-Path: <linux-wireless+bounces-31741-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIjTEu2tjGl/sAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31741-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 17:27:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DAB126186
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 17:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AD71302E421
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 16:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5740433F8BB;
	Wed, 11 Feb 2026 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="R6zajtOW";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="cj7hN21D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B942D948A;
	Wed, 11 Feb 2026 16:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770827189; cv=fail; b=NuuqaiY403WehbqkMs4wpwozacldh15CJjCU4bIgJgyqo4F91pnm8mr3MM61uxvoHrfUrB9a1ZveQYQvIkzHDhwrlOfHklcy8qB3KO188Y3kgRKVZSpJ3xbjqKfQLVwf7hzgvxBAl+bWCyusVoSpHtYKTCTxl1vsgfq6HNQh8Ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770827189; c=relaxed/simple;
	bh=aGNcLo3wlmUFMWmuSJo1ykwtTRarA1XK2Su4w+7uraQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rXTQfpVC2R7vhjIqSYYHgeZxBSvoMFojOOJwkr8KtX0h1w5DyVqHGMxD81cMfR/4iHukVBwm3JzkCoib6oIflYUoR0lqun8MFZLQhyvuI0Fyi2HVUJxsF/dHFzpbWpBJj2ScKtLhJu2r4EkSD6uI8dV3znjZpU2TFbkF76fo19A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=R6zajtOW; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=cj7hN21D; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 666d513e076611f185319dbc3099e8fb-20260212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=aGNcLo3wlmUFMWmuSJo1ykwtTRarA1XK2Su4w+7uraQ=;
	b=R6zajtOWlJlzjZ6AMWAYhzVAHrCobqVjuLDwrqBdGkLDwXXdXp7Cp5DxMIV2qryWXrwrXGc0Q2L9asfcbQ5jVgeSi+oY9XXp/53VSPjwnr9U7FxiuirSfEM7TDbJ+dIzGQteRIIiJk4F8GebEz2ZzSDj4G/uQ5p88gDwnIW/Tg4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:dcd1e175-56fc-45f5-a449-720a9df0201a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:310f97f0-16bd-4243-b4ca-b08ca08ab1d8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 666d513e076611f185319dbc3099e8fb-20260212
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 452862116; Thu, 12 Feb 2026 00:26:21 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 12 Feb 2026 00:26:19 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 12 Feb 2026 00:26:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDPXE1dl5ysN8EFHzLFww7Ui8PR24cPSu+P924eAsLKgYy2GLvFlSMN0DK4zrYAsYr9c/oSn6FkZKDQYU1ZRlEdbu4DPXLB/YbjM8aKj6bw/E59ugs/BFRI4SnsIW5Npb4ryO4Bv1m902vruRYneLOb8aNgHZMtWg417mpdKmxotQQQLOzQ8IMSfCBmcY3PRXF3u67cQ04OfTYSs0+O53Htce7bp+AixsexSEUvRxpHobSA1tAs06MaCA3Z345lSd2QZdV1LjTJCD5If7NGCdh4gZt5tpV24ynSxOvsonyfJ5KNKiTQvhRUiWcbNstNotPfAOIEZQ3eTtN++dQMRpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGNcLo3wlmUFMWmuSJo1ykwtTRarA1XK2Su4w+7uraQ=;
 b=BCuHufslbqTAKzxxwd9KnY1JtMkQVi51AOthWi6JCnX06/E5DR0Kl8kjIbSZY/0uGmNQzS6PTZjEclUeaWSFns62nURlmmMjzcKlzB7IK5lL/CnH5WWvfIPNxT4b7mp5XeIKn3IULgHr35iffL/jz+n96BIROB6lGdSOHqCVuE4P3T0Cr3amAvh4A2SMA0nh09n97YMr0wrmO720IUK84vrpteUDAk+Y0d4F8EZRedryGuU6cvxndK+qe+2GgdRvikt7DaCgwmDOTg92Liy9GC3xtIgp49QA+BB97fV067D9QN0VbSygSfqmunW2GJGpczp5uCD/Yx+VUOEc1R4/uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGNcLo3wlmUFMWmuSJo1ykwtTRarA1XK2Su4w+7uraQ=;
 b=cj7hN21DlDTKyoixRPlvi9NUzc4VVzxxUVqlMgACW6tdtfyiE8ZE0an5zt3d1QT4IWJ5ZAGlOc+/5gXT3YPRdN2hC4sb1nNoJZ6JaM0Hre9eCwnfcF/mrkfP6MqLBdL2w+xovt8nBI3Bq0EjI/jSNl6gtnWxR87x5XeuZmtHmUY=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by KU2PPF1444EDE0A.apcprd03.prod.outlook.com (2603:1096:d18::408) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 16:26:17 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059%3]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 16:26:17 +0000
From: Ryder Lee <Ryder.Lee@mediatek.com>
To: "wenst@chromium.org" <wenst@chromium.org>
CC: "robh@kernel.org" <robh@kernel.org>, "nbd@nbd.name" <nbd@nbd.name>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?QWxsZW4gWWUgKOiRieiKt+WLsyk=?= <Allen.Ye@mediatek.com>,
	"krzk@kernel.org" <krzk@kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: net: wireless: mt76: clarify backoff
 limit format
Thread-Topic: [PATCH v3 2/2] dt-bindings: net: wireless: mt76: clarify backoff
 limit format
Thread-Index: AQHcmrhfdLixNmzm402cr6hZjqmOB7V9Cq4AgAAcbICAAAELgIAABKcAgAACKQCAAAUHAIAAAmwAgAADGgCAAAlEAIAAbhKA
Date: Wed, 11 Feb 2026 16:26:17 +0000
Message-ID: <7aa845557fe7aa67fe6c80c0673aee21ce030675.camel@mediatek.com>
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
	 <CAGXv+5E=REdz0g8rfi7+KvyC7jLXO0q=yjan3mMTGtxe0NgCDQ@mail.gmail.com>
In-Reply-To: <CAGXv+5E=REdz0g8rfi7+KvyC7jLXO0q=yjan3mMTGtxe0NgCDQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|KU2PPF1444EDE0A:EE_
x-ms-office365-filtering-correlation-id: b0aca5d8-55b8-4ae9-8758-08de698a485c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?eEFjUlliazdBK2R6eGprWlR2NlMyVDkyOGhxTFNLQ0FtcHhWMXRzMmhUMnYy?=
 =?utf-8?B?cjFOa0xMOTg1NU5ISFArWFJmWFVQQlBBS1NPbEFIMnFsNUl1alo0SUdMeWhT?=
 =?utf-8?B?dHJ4ZlVqTWw0MHNaQlRmUTJhV0VMK1hoVmdyMEVCNGZNTkdlU0g3WHpML294?=
 =?utf-8?B?U0pKRzRUakxxZmxXUjR3c3hRSXhGV1NkRzZIZ0dxdEdQeHlITVZxUUJnb2xk?=
 =?utf-8?B?WXJsd0ZYWDZhc0gyanZlYWdOMTJ2Y0hadTQ0QjBhazk1NVVKWTdRWE1jY1JM?=
 =?utf-8?B?cndraFdiTWlwZlFSbzVBS1RTYTZTN1lOSXZYa2UrWi9GN1RHOG8xVnJMcC9G?=
 =?utf-8?B?djFVdDFBMnAvZnpHb0hBNkJFWHlSNXVRK1VraUVHYk11WWxwSzdHMmZrUm1m?=
 =?utf-8?B?ZFFmZk0yeHlxQnVBMW9iMEFVelZMdTNOMTh1THBRVW40ZXhSUDNiRU5hUm55?=
 =?utf-8?B?aW1QZUtzVGZ4SGdiN292QVVZYUFqamFKN2k1OUlzQ1ZpL3k5bFFzK1FSdHNO?=
 =?utf-8?B?anhYbFBMS2ZTRFYwZHI0WG43bTRndHlwT3R5dnN6cHk2Qko0VHBZZW5JREhT?=
 =?utf-8?B?ZVZ3OGdhTEdPbzRiRWZyMG52eUU3WEZXTFRWc01ocStLdjUvaFAxNlUydHhY?=
 =?utf-8?B?RDdYLzluRVp4VHo4TTFMUlRvemZyQytuZVg3TkhUR1dydkYvdm1iOEdFVmNT?=
 =?utf-8?B?bW5CMDFPR3FEdWJLcVJIVG5ZdkZMM3dzTTVFQlR2UjE2b1BSWTdwT0tuRFBm?=
 =?utf-8?B?K0twZnFBRVcvT3VpZjU3QzljK2I5V0RLQzIvYXN1b2pmcWh2bDVLRHNrSUMy?=
 =?utf-8?B?Y1ZpK2Nhc3ZEbEhaejBBaGdBMU1Cc0ZwMVlOR2lNUXZrQW5aSUlObFlzQWxQ?=
 =?utf-8?B?V3hhelV3T2pNc2w2NXlFR3N6ZWJsTUJKcUN1TmJPRTcwK1FsNTRkaVNaUlFs?=
 =?utf-8?B?TXJRTkdkVk02Vy9yNFMrK2ZWbkduQVpoT1JKNzdQdWFWbHRremlvaHRLVHBh?=
 =?utf-8?B?MFYydHJ3eFFSazVWTU8yM09VU1lkODRsMDBTZ1R2aGo1aDNmRTlqbko5MG9S?=
 =?utf-8?B?NWV2a3lnZEpqcjY3MEI5OU8wT3dzMGQyVk1XaFVQR2g0ZTRTTUhnVDVqY1ZW?=
 =?utf-8?B?NHAyMXRKek8ybXZIS0lsQWJPMEl5NHhCc3U0L1JBNU5abFJHUnV4UHhTalRN?=
 =?utf-8?B?d3NXQVBWd1RYSE9FeG1VZnZZVWw2dkk2UkdJYnlITmZLUWRlU3diaWtnQkhq?=
 =?utf-8?B?eDJ5Q2NEcDZhZjJsbzFsNTNkVEhzZnFjck10djNOYldPbFA3dTdRaHd2bFZw?=
 =?utf-8?B?S1lkVFdQb0Y5ek1IYUFjaWlhU0wraFp2SW1GTkdEd1pkTHd4czFQWW43ZXdR?=
 =?utf-8?B?eUs2Y1Z4MHNUU2dobnhsNDFKa3A3UFROdU1ubDJFb0RITnJEZE00VE5FQVJn?=
 =?utf-8?B?dmtyNnhKY0RWS3hRd0FOTXFHcWJJc1RXT0NGRi9qazhua1FraWtYTUZ2SG1K?=
 =?utf-8?B?YUhKd2U1N3ZkekdkNERhUzVXTUk0UnV3Vm5NdWh1TGNjZDhxYW44VzFveW1I?=
 =?utf-8?B?NFVSbVkwaFNDVHBKQmI4K3YxVk5HbTB0aDJ3K3R5aVBJYWNyekNTRzFEVi9j?=
 =?utf-8?B?YXhZbVRSNHFMMmxtVmd0YjBMTm5MVzRrZnFySGpubEdFempnMkgvVkd6L1BM?=
 =?utf-8?B?M3UzMVlBMnVhU0ZCRWI2cmRmRThtWlNwa1FXU1BMdTVhMlplWmUwTzNyLyt2?=
 =?utf-8?B?RmozSkNaL0J2WC9aQ0x2SVU0S3hlUWYwSmhDTE1zazUzajhsTjZDZEw3YnRh?=
 =?utf-8?B?QUJibHkzNDcxVGEyN2hmZUFxd2lOa1d1UEt3MkFwV3paR292UGVTYUhQVjBi?=
 =?utf-8?B?M1NaY05WOFV6cWRJSFZ3VnpsM2lQL0xNdjZzendYblpQd3A1NWYwVk50N0dy?=
 =?utf-8?B?T3RXNU9zcGtROFlMWDQrZWE0OEliRDlBZG8wR0xNUEs5WEdoQmpnNktBQVZy?=
 =?utf-8?B?dmlOYzVUV3lNb0RsMFVmZjZHRldaZ3ZsVVVFdlFNdlh6blBUNGxnL1VyUHVM?=
 =?utf-8?B?UnpJN0pnTW8zbWJuM3FUYnd5aUN4YU1rclNMNCt4RTZxaFJBdFlhVTV4TStn?=
 =?utf-8?B?bU90RHcwT1hMMGxOMDZPVGRGTkozQmxqcnV0VjlFTGxzcG9CZGIxY1pycEVY?=
 =?utf-8?Q?AHLH36g0Oql3iIfKn8Ay7pw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ek43RUMyODhwTDRndXFJaWpjWUdEUzJlWmpnNHAwaUxab3oyRDQ5dTY2T05n?=
 =?utf-8?B?UVlOenJlMEtZQ1hYaEZUcVB0enRUbklSTWpHakxjTFB1R1FhZS93ZFBWSUg3?=
 =?utf-8?B?ZHlNS2Fsa3pLZXR4UkdzYnNBZng0c3oyUzgyZ29maWhjTWpxNzI2Q21UQ3J0?=
 =?utf-8?B?S2E2b1o5S2VzdUJQb0JOQlZieEpDai9qVG1ST01VY1BYS05XcFpmRkVxeC8y?=
 =?utf-8?B?Um5IZ2RIMFY4TlZuOXY0ekFoYkRMZG1VOEU4N3YzcmRPeVRqTWZzRGpld3RM?=
 =?utf-8?B?YmZ6bzNmVWY3aFVOdGY2Rk1idlVZSmRXSjR4NjFZOEsybUhTbVFQeTRseU5o?=
 =?utf-8?B?c3hPaE52Ly9hZ09mNWhubFNocUt1VDVOODAvQ1Iyb3ZxNEJNQUs1Ym5ETVFV?=
 =?utf-8?B?Mlk2NnI3QlFneWxsckNESkVQUUc2VGlvS3NCaTlwYmt4MlB4WG9UbHNGbXRn?=
 =?utf-8?B?OWw3cFJHWWY5bGVRRUppN0JaT3MvK3BlcERqWDJOOUs2TzBSbGZKRExTRU56?=
 =?utf-8?B?OUZGeVBxaEwySDRTU2MvRnBia1BuVFMwSDlXRzE2b3NtTW9tbmp1Z0ZlSkdo?=
 =?utf-8?B?M0RNMGJLd2hwU0x2VVNtTG5zL010NFVBK1hxWXUwNEEyNU5BY0UvOERsSjgr?=
 =?utf-8?B?ZXNMS3A3OEN1UmlhU1ZScklvZDZ6blZKd0NyMEIxK3R1V3N6ck4rUDNkamhs?=
 =?utf-8?B?UkxKTlozV1BlTGF2TlFPMUNIenJ4MHhhZ0h0ODZMd2hJd29wa0toMjVEK3dk?=
 =?utf-8?B?UVZSdkczOCt3S2RvdlB3NlBtYzdlMDNZUXhNQ1ZwOS9MU2JaZkhCRDB0YTBT?=
 =?utf-8?B?djBWRExnaHhKNjJkS0hVZlhsdHRoSzF4bFVsRHV5NTcwdDVvWDJkRVQ0czNh?=
 =?utf-8?B?ajhrWStNdDNPTkduOGlVNjFEUjJQenZBQjFTSlFOcldRdWsvUlUyeFQvOG9a?=
 =?utf-8?B?TzkyTjNaWHF0cEgxVXNvZ2w3SUVORzZYUEVCaVgyS0dKNXEyUXIxNmZlcFJ4?=
 =?utf-8?B?NEZrck05OWkvdmRjMWFCRnpBZlFXb2pRWStzZDkzUFBQejhPemdZeUVsM0E3?=
 =?utf-8?B?WTJvWm12bEJFUjhZV1JEb3ZzOHZwTlB2UmVHcndHTkQzT2xCZGJka1V3SVVT?=
 =?utf-8?B?dnRJVjcwaDdWZlI2MFdDZkNaTDEwUmgwcndsTUFJbTEzT0NUSFNoUHhrSjFY?=
 =?utf-8?B?SFZiTWRvekRySzhFVXo4UExhc2ZwcG5MTi9NTW8wWnYvN2lJb2FTYWlKVk9u?=
 =?utf-8?B?Yy9kQ2VhYTJqNVRTelJCZ0tnMmRpN1BQTGJ6aXBYTW9jTk4xazFrU1Y5WFVX?=
 =?utf-8?B?VDNkWFJYcDlraHhReVBKclFJalFRTXFYNWhHck43RTd2cys5NGZWOXVpUURo?=
 =?utf-8?B?aWp6alRpUDNzWW9wUmZMNXhyVVlJeU5JNjlocXEwdFdER1RKc2sydURoTjcw?=
 =?utf-8?B?YTNrTnh0eEJhbUY5eCtHZ0tXUnZsQllwQ1NEYmNaOE9tcDYzZHo5THA4ZEp5?=
 =?utf-8?B?WGQ2alg2bVVzeE9zOXFoYWh4OFZwV0ZlV0VGM3NiZENBcEFLdzVJQUs3Y3U1?=
 =?utf-8?B?QUQ3YzdyeXJnL1FMNW00S1h0bGU3K2E2NmtEbmQ3VkRhNGVCcFc2RWJyblNT?=
 =?utf-8?B?ZjBvNVFVRnZUcjUzWUd1VUxrYjhwRjBhQVJzakZ3d080NExEczJwTldQcG03?=
 =?utf-8?B?ZkRPV1NGelZ4SjJaVndhZndqUGNBZDg5c0Q0TFFqU1VvVVdRQ1c0dmVxUThh?=
 =?utf-8?B?NGZLNTE2V056YlUvQ0RVbDZEc3dudmxXVGRJVm5Wa1paTUF6T3RqakhhNk5v?=
 =?utf-8?B?cURxWXpQbU1UenRvcXhOZ3dUUm91OE1aMGdUVzltV3FHR2huWWxrUHhlbFN5?=
 =?utf-8?B?NG9kS2dHUkxqMSt4amhLdjdjZTNJRk4wK3J6Mk42NWtZSGNnZXduQjVZcGgr?=
 =?utf-8?B?M3cxaVl1SzhINy8rRVBLTGRFaTlFQXBkSXVTMHFLUjlNWVNIUHV4dkw1VlFu?=
 =?utf-8?B?MUs1eTBDSzZVckRvbzBkVVZyNFBlN3dzQWV6cXQreGozdVFwSmc4alRnendZ?=
 =?utf-8?B?MXFNWnZ2cTdOc2xYWDlsNWNPZkp5TE5Ta0t3NFlONkMwK0tFSWlSRXVJVERW?=
 =?utf-8?B?cHBzUnpVMFJlZHNlbWhWbWhtYjJDNUt5cUFWdHdKZDZESXFXdUhOQzJBclhm?=
 =?utf-8?B?OUl5VmxnaktMSzRuVkFFNGQyd2dPQ3JucUN1QWZrU2J3UWtLT0tMbDd3dEFy?=
 =?utf-8?B?OXNLZTQzNzIwWkt6L0JoemtCcGM4cjlhdWNXb01QS3ptdUpZWnNnSTdqVEJ0?=
 =?utf-8?B?V2JBcTdNT0ZkajU4Qk12YkUwcmY1aVNaNGhTRFB3L3NkZTFzSUx1OXdWMW1k?=
 =?utf-8?Q?y+CvXVSi43jBYNM8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75A6DAD569178144A525F1D0787EBB5D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0aca5d8-55b8-4ae9-8758-08de698a485c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 16:26:17.3495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: deqjN0xXAOdZlQ90h10CZrPpdqzx2NPgOUSTsl9dARo9jOdVA1OVeMWAtb+4bK0Wggyy+yRU0YHZhzSxKk1Pfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPF1444EDE0A
X-MTK: N
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk,mediateko365.onmicrosoft.com:s=selector2-mediateko365-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31741-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: A1DAB126186
X-Rspamd-Action: no action

T24gV2VkLCAyMDI2LTAyLTExIGF0IDE3OjUyICswODAwLCBDaGVuLVl1IFRzYWkgd3JvdGU6DQo+
IE9uIFdlZCwgRmViIDExLCAyMDI2IGF0IDU6MTnigK9QTSBSeWRlciBMZWUgPFJ5ZGVyLkxlZUBt
ZWRpYXRlay5jb20+DQo+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIFdlZCwgMjAyNi0wMi0xMSBhdCAx
MDowOCArMDEwMCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gPiA+IE9uIDExLzAyLzIw
MjYgMDk6NTksIFJ5ZGVyIExlZSB3cm90ZToNCj4gPiA+ID4gT24gV2VkLCAyMDI2LTAyLTExIGF0
IDA5OjQxICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiA+ID4gPiA+IE9uIDEx
LzAyLzIwMjYgMDk6MzMsIFJ5ZGVyIExlZSB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiA+IFdoeSB0
aGlzIGNhbm5vdCBiZSBhIHNjaGVtYT8NCj4gPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gV2VsbCwgYWN0dWFsbHksIGl0J3MgYWxyZWFkeSBhIHNj
aGVtYS4gVGhpcyBpcyBqdXN0IGFuDQo+ID4gPiA+ID4gPiA+ID4gZXhwYW5kZWQNCj4gPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiA+IFdoZXJlIGV4YWN0bHk/DQo+ID4gPiA+ID4gPiA+IA0KPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBIb3cgMVQxc3MgaXMgdXNlZCBhY3Jvc3MgZGlmZmVyZW50
IGdlbmVyYXRpb25zIGlzIHdoYXQgbXkNCj4gPiA+ID4gPiA+IGV4YW1wbGUNCj4gPiA+ID4gPiA+
IGFib3ZlDQo+ID4gPiA+ID4gPiB3YXMgdGFsa2luZyBhYm91dC4NCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiBXaGVyZSBleGFjdGx5IGl0IGlzIGFscmVhZHkgYSBzY2hlbWE/IFBsZWFzZSBwb2ludCBt
ZSBsaW5lDQo+ID4gPiA+ID4gZW5jb2RpbmcNCj4gPiA+ID4gPiB0aGlzLg0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IA0KPiA+ID4gPiBsaW5lIDI0MyBwYXRocy1ydQ0KPiA+ID4gPiBsaW5lIDI2MSBw
YXRocy1ydS1iZg0KPiA+ID4gDQo+ID4gPiBJIGRvIG5vdCBzZWUgdGhlcmUgYW55dGhpbmcgbGlr
ZSB5b3Ugd3JvdGUgaGVyZS4gWW91IGp1c3QgbGlzdA0KPiA+ID4gYWxsIG9mDQo+ID4gPiB0aGVt
LCBubyBkZXZpY2UgY29uc3RyYWludHMuDQo+ID4gPiANCj4gPiA+IEJlc3QgcmVnYXJkcywNCj4g
PiA+IEtyenlzenRvZg0KPiA+ID4gDQo+ID4gDQo+ID4gVGhlIG9yaWdpbmFsIHNjaGVtYSBpcyBh
IGJyb2FkIGRlc2NyaXB0aW9uLiBOb3cgYSByZXZpZXdlciB3YW50IG1lDQo+ID4gdG8NCj4gPiBk
ZXNjcmliZSB0aGUgZGlmZmVyZW5jZXMgZm9yIHZhcmlvdXMgY29ubmVjdGVkIGRldmljZXMsIGJ1
dCBJIGRvbuKAmXQNCj4gPiBrbm93IGhvdyB0byBhZGQgYSBjb21wYXRpYmxlIHN0cmluZyBmb3Ig
UENJZSwgVVNCLCBvciBldmVuIFNESU8NCj4gPiBkZXZpY2VzDQo+ID4gZm9yIHRoZWlyIGNvbnN0
cmFpbnRzLiBTbyBJIHVzZWQgdGhlIGRyaXZlcuKAmXMgZ2VuZXJhdGlvbiBuYW1lLi4uDQo+ID4g
Y2FuIEkNCj4gPiBqdXN0IHdyaXRlIOKAnG10Nzk5NuKAnT8gT3IgZG8gSSBuZWVkIGEgY29tcGxl
dGUgYW5kIG1lYW5pbmdmdWwNCj4gPiBjb21wYXRpYmxlDQo+ID4gc3RyaW5nPw0KPiANCj4gWW91
IGNhbiBmaWxsIGluIHRoZSBQQ0kgb3IgVVNCIElEcyBhcyB0aGUgY29tcGF0aWJsZSBzdHJpbmcu
DQo+IA0KPiBTZWUgZm9yIGV4YW1wbGUNCj4gLSBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbmV0L3dpcmVsZXNzL2JyY20sYmNtNDMyOS0NCj4gZm1hYy55YW1sDQo+IC0gRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC93aXJlbGVzcy9icmNtLGJjbTQzMjktDQo+
IGZtYWMueWFtbA0KPiAtIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvd2ly
ZWxlc3MvcWNhLGF0aDlrLnlhbWwNCg0KT2gsIEkgc2VlLiBUaGVzZSBleGFtcGxlcyBhcmUgcmVh
bGx5IGhlbHBmdWwuIEnigJlsbCBhZGQgdGhlIFBDSSBJRHMgYW5kDQpyZXBsYWNlIHRoZSBvcmln
aW5hbCBjb25uYWMyLzMgcGF0Y2ggd2l0aCB0aGVzZSBQQ0kgSURzLg0KDQo+IA0KPiBUaGVyZSdz
IG5vIGVxdWl2YWxlbnQgZm9yIFNESU8sIHNvIHRoZXkganVzdCBoYXZlIHNlcGFyYXRlDQo+IGNv
bXBhdGlibGVzLg0KPiBUaGUgYmNtNDMyOS1mbWFjIGJpbmRpbmcgYWxzbyBoYXMgZXhhbXBsZXMg
b2YgdGhlc2UuDQo+IA0KPiBJZiB0aGUgaGFyZHdhcmUgaGFzIHNvbWV0aGluZyBsaWtlIGEgY2hp
cCBJRCByZWdpc3RlciwgdGhlbiB5b3UgY2FuDQo+IGhhdmUgYSBjb21tb24gZmFsbGJhY2sgc3Ry
aW5nLiBBdCB0aGUgZXh0cmVtZSBlbmQgb2YgdGhpcyBpcyB0aGUgQVJNDQo+IE1hbGkgYmluZGlu
Z3MsIHdoaWNoIGp1c3QgaGF2ZSBvbmUgY29tcGF0aWJsZSBzdHJpbmcgZm9yIHRoZSBjb3JlIEdQ
VQ0KPiBhcyB0aGUgZmFsbGJhY2ssIGFuZCBwZXIgcGxhdGZvcm0vU29DIGNvbXBhdGlibGVzIHRv
IGNvdmVyIHRoZSBnbHVlDQo+IGxheWVyOg0KPiANCj4gLSBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvZ3B1L2FybSxtYWxpLWJpZnJvc3QueWFtbA0KPiANCj4gDQo+IENoZW5ZdQ0K
PiANCg0KUnlkZXINCg==

