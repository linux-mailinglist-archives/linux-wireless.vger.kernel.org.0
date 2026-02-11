Return-Path: <linux-wireless+bounces-31721-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8H1FJBI/jGlyjwAAu9opvQ
	(envelope-from <linux-wireless+bounces-31721-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 09:34:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7A0122479
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 09:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27813303E2FA
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 08:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E9A34FF77;
	Wed, 11 Feb 2026 08:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="irwPx2GA";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="eOwUIpD1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B88232D452;
	Wed, 11 Feb 2026 08:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770798833; cv=fail; b=DpSzZCGXRef6B8dkatEi55oeSNNe9iugUtrbxwwrrDYpcTCCU78N672THXibiqfoU5Q/XS1aiFb/u1Ypls9MCywNHvMPUZpzw3fnWFPSGMNSWTyn0RcsRiiXdg/jUHFvIdYVPMmm6brBrkwD16SW9PekYaSF1MJg8TgEKQ9pYu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770798833; c=relaxed/simple;
	bh=gDQPRkoI61wlOaxzdvjH8czRQBWoKGQwJYDtHFInGNA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WcXb+M/g6nZoXyos0o+Z2sQRrEL6rOdz1bFckm2qAL9CcjR2Fcs2xpH7rswDQUki+N2bBMECm0PzWDIFgbgUo3fhlWtVjyZ6l0ho7ex4EM8q3+quH1C1N6YbmeIlW5Klclo6A77MZXng9fEMl5y5UhTgoR3qJQ3sgGHC08ldfYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=irwPx2GA; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=eOwUIpD1; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 60b2c96e072411f185319dbc3099e8fb-20260211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=gDQPRkoI61wlOaxzdvjH8czRQBWoKGQwJYDtHFInGNA=;
	b=irwPx2GACcM9jnV0tn2iiZ3GdcQTvTk887sOzx8i3zOQAxWZQz2+qwVf8H3HI7tbYUDacMBuLhDR690Ks67FO1KdTMw2k2LGHcsws7UPqQ9r+sSO+MgSP5fQ94P3b+rVTcxBGzsdOgBlADOTb1JEJ9REUcUzdaHbZDLl/1e6+1c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:eae10b03-c6dc-49f5-b6e6-4e1b27b81acb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:fc56d67a-8c8a-4fc4-88c0-3556e7711556,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:80|1,File:130,RT:0,Bulk:nil,QS:nil
	,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 60b2c96e072411f185319dbc3099e8fb-20260211
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1529335065; Wed, 11 Feb 2026 16:33:44 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 11 Feb 2026 16:33:43 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 11 Feb 2026 16:33:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2vvA5q3A/lQiGp1ozczvn0KAGOOxBvego3tjJq7f2YB8fTykSPa3eZcLyi/3IQ9ZxE3OdAWMraW1WMfAaXyiftTvfGNtUkuts9S0gidSijJruemvefmUR9NnMDnYwWZocCBTAv2v897xCI4wNKmckqFWgPAKp5kwHqIeD78SBijO0I0l2R7P9vXI6h8P9MFyntecKI9dVsaDL6wgcWsRYtfcx4SC2yQ1b979EiYO3x2pu3GjvnDaDBziA30bTpMc+UpDHNtBouiY2xOZExLNa0I9tOJ+TAB1j4NPqK0P4rePv7owhnZY1gij7YBKeK+yGfMU39WLo8AXSNtjJuLdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDQPRkoI61wlOaxzdvjH8czRQBWoKGQwJYDtHFInGNA=;
 b=CQmiT3DcML+Vhw3lozVrFJ2q3CYJTiaysjy7bpRJsxSL8F0KRONhRrKfs0MuKeufJew0OgO0OdQK1R/3ybpD03LyvJ8ESwZEnUYnuAa1pulnxsdiGW9Sfcn8QpvBnjD16j6L3zbAQWj5TTpJcVZIBdnzsc6hE4P3DVOBNq7iBhnPmVR1R0e63NxdASRNYppvVpklwh3pJ6Dxj3yMkO1V0PJbrmUvsBVJVANPxuaH/1my4VQS5W5BbVUknFwG6ykKDz0lb9NcYjczQtXkEXg1uQ0BbYQ5vIf73wE8lE/rEbliWpuggBbysjGrpBOtT+00LsaQcCAgALhVP/dfqtDIig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDQPRkoI61wlOaxzdvjH8czRQBWoKGQwJYDtHFInGNA=;
 b=eOwUIpD1K9MDcg3R1zomf1Rwpx7fbTbyMwrh7p69fKJ+c9aAUQ3hvTJb1MjzaQw3y7MoAAdMQgAIT3NNIxSCWK9xyWHVfSJG/FJ6xKu9OlKMy8ZPirzQ+HcYN31iGjnE/oatk0A6psnp6iEsopbPiXQcdts0hF/hld3Faj7Kz1o=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by SEYPR03MB7294.apcprd03.prod.outlook.com (2603:1096:101:13d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 08:33:40 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059%3]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 08:33:39 +0000
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
Thread-Index: AQHcmrhfdLixNmzm402cr6hZjqmOB7V9Cq4AgAAcbICAAAELgIAABKcA
Date: Wed, 11 Feb 2026 08:33:39 +0000
Message-ID: <0dceffe2e1344830c12bc1f6516d13c7bb488b99.camel@mediatek.com>
References: <8fa8ec500b3d4de7b1966c6887f1dfbe5c46a54c.1770746444.git.ryder.lee@mediatek.com>
	 <69521aebefef405bad5117d4d5d5fef4a5dfb7e8.1770746444.git.ryder.lee@mediatek.com>
	 <20260211-miniature-chital-of-plenty-1a71df@quoll>
	 <bd4da0a8522db2991ec0844233efe068323c2578.camel@mediatek.com>
	 <b00c8c18-930b-4cb9-975d-b15118bfc854@kernel.org>
In-Reply-To: <b00c8c18-930b-4cb9-975d-b15118bfc854@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|SEYPR03MB7294:EE_
x-ms-office365-filtering-correlation-id: 6c0663db-136c-4dfd-3606-08de694841fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?WjdacDgxWXpDd2pzQnRuQ05kbkw1TldvRzVDSHM0SGlub0UyVngzdDNxMDdl?=
 =?utf-8?B?WjUwbXpjRzFFUlMvRVdscXRtY2Y4WVdBVVJNd3JGbk1mbFI1NG5VLzRUN0FF?=
 =?utf-8?B?Qy9YR2cvQkNTakVkNHlxVjYyajI0K0ZvbWFzNjVoMGxDRlpLYXQ2L1YydmNa?=
 =?utf-8?B?TE85VFRtZEkzYS9acmsvN2dNby9xOTNsYmNUcThUT2poNjh5eWZaR3JrdDZt?=
 =?utf-8?B?bXpzaE55cGdCSlgxK3Y1U3J5TzQ3ZjU2dnRLUGZiU0doVlNxRFpvS0JCZWRr?=
 =?utf-8?B?VVJUb0RvK3RTRENtT3hHbnBLSUZUOGhTenEwMVFIQ281TElZcjhzWEthMG12?=
 =?utf-8?B?VU9VMGZXUmlPczYxRjhvK1I1RVI3T05PVEdaMmk1QXBxY08zUzd0NGg5RXFG?=
 =?utf-8?B?cnJNZ3BUSmduZldoeG9Zbm1uM0xyQk55Z1pFb05ORUVRTTZyR3VWeC9YWmdz?=
 =?utf-8?B?Y1Mwem81dTVZdG9VSEk3bjVSaHZsb3BOOWRjWExIRG9nY3hHcGFZTFUrQVds?=
 =?utf-8?B?azRtS2hzZitSZ2VNVGdDaE1nbCs4eXcwczV5b29BV0dmV2ozNDArNkRtM3Bt?=
 =?utf-8?B?dlhnNmJVM2Z0QURuRTgza21CQThsaXVOK0ptWUU4NkdtY3lSSFNKMmFwUi9U?=
 =?utf-8?B?eE1QRFlZYjA3K3I1ckVJUFIyVjNiejFzNXZ0UnJJNUdKOGJOM3pWbG1uSXRE?=
 =?utf-8?B?bVo3dEIvZ3h0WGYxbUNDNjNYR3RBWkVOanFUeVFyYm9zaktjcCtLNXNxRnY3?=
 =?utf-8?B?NnBVY0M2dnFxTmIzMkJReHpWWk5DQ21HQjZoTXMwY0ZlVFRPL0Fld1l5Rm1L?=
 =?utf-8?B?K3BFbmw0UzFuRkxSeXFZMDZ0eHlpSURJTDRqMGNHdWdRc1Y0enlNUVFhMDdw?=
 =?utf-8?B?VjQ1a3BML1ArNklLSXRQaWptMlJmR1M3eXc5U052T1EwUnl3R21XcXZicHRx?=
 =?utf-8?B?UUk1OUpQYXlsN1EwL1luV0hLNU8rbldWaTBIR0R4YWJQajgvUWNkNHBSTmNh?=
 =?utf-8?B?ME1zUldDRkpPK05yTFdOZUkwZU14VU1ibzJabjkwb3ZTTE1pWEpoWS9XYlVM?=
 =?utf-8?B?eDN2YWMxWlJWWWZtdC95Njc4Mkt2LzdtVThnajJUWXluaUI4QTRLaUtyK1g3?=
 =?utf-8?B?MnFjeGVjUjVUWHRRSlpYQlVSUUJSZGVPYVJJQ0J3Y1Y5SmkraHBDMkZVaWNh?=
 =?utf-8?B?Uk9PVWJkd3JtU1lXUWpVaUZHcDM0QkdySGNPZ1EzSHJCd3ladHBWVkVRSTUx?=
 =?utf-8?B?QTZiQko0cjJEcndrbi9Oc3ptV2lQVXY0VjlKMVYwWXV1enZDdkdDQm8zb3lP?=
 =?utf-8?B?cFhnNjl6cTdLbnExeXhxWTc2cGtydldqeEY2cVhWL01NYjNib2ZHdDFla1Fy?=
 =?utf-8?B?YjNrMFpmaCtlVEZiZkc3S1pORk9rempWemE3TWlDRjJSYnhrbmRWSGhkN0xK?=
 =?utf-8?B?UE5LdWFjVnBhenhtS21UQlB4L3NSd2lGZlpWOHk3VGo2Mm5iVmFmaTBteHhu?=
 =?utf-8?B?L0ZvVXd6dDkwQlBQMVVUNW9hOTkrM0tXekhzNlNvYk5PZjJpMEtpc0tuSlE4?=
 =?utf-8?B?SEhsd3M5TnYyUkpFVSsxTFhSUE1GeWdsVVlKY0xrQWxnNnFOSFROSEh1V1JO?=
 =?utf-8?B?bCtINytWaEtKNTkwakpucW9vbFp5dUxzZEk3N1F5RFZqUTB3Q3BqMW44YTZx?=
 =?utf-8?B?QlVISDBzM1ljTkx0N0dyNXJjYkF1RXZTR3VhVnM2QXNiQmpSVUJ6UmptYUs0?=
 =?utf-8?B?ZlVrWCtOT25NZWVrZlZtTmY1VnEwREUxd0JBNVVkSHNBZ2xMTEFKdlBFOWg4?=
 =?utf-8?B?Ull1bXVHSkZVU25veEoxTGM3YVFjVm9XOHZUb0tDVlJiK0RCRUVuSGJCWHRQ?=
 =?utf-8?B?amxoOVIvVFJtd09PMUFhbmd3SVdhRTZEbVgyNHc1MmZvOW5JSDZ1Z0txQUlK?=
 =?utf-8?B?dkdVVUtmTjJMeHZnODFveCtJTGlXRmIwR2p4UXhiakwvNEFuOTVCaEdFa3dI?=
 =?utf-8?B?MGdrUXNab2dGVUJIM3k0cm9zVStXQmZJbnM3eCtKaEJucEFGRFdDMWJ6aDBh?=
 =?utf-8?B?bFQrekdXTHZJYTFxSTA2b1hLL2I2N0FDNFNUOFEyenpmTE5aMW1wdkdzZzd2?=
 =?utf-8?B?d25JY3BsMDhnaENwUXRObW4wQ2JZSTl5YWFLd1pCdVd5VUFUZGJyYzUvSmRT?=
 =?utf-8?Q?fiiIGl/6vdZ/hBW1ZqYyoH4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bExoUk55WFNlWUhpVDRTTkhvYUJlaWI5S1l2c05RN0gzY1hPN3RSNjBPZ3B1?=
 =?utf-8?B?TzYvRnppejc4Q3JBbC82L014Nkl1MXQzcUhyMmtmWjRqazVzOXFjTUVabXlT?=
 =?utf-8?B?ZjMvQ01xbEc3NXY0RGd5MExIUm1UblJFNTRFa0RoaUJnT0FxMWo5ajczbXd6?=
 =?utf-8?B?N0JZVTBUVmJoMXZwZGR3SDA3bW9ta2hmelhSSHRob3Z4d2dyOEd6U3NVU2VX?=
 =?utf-8?B?eHFoUmY0MEFLSzBRNUM5K2JkWUlMQUIrRW1YSVRDalFjQ3VPRmdoSFM3V1hF?=
 =?utf-8?B?ajJJR0hpcmUwYUdmTG90QUlyS2g4ZnZaTmNyMWZYTXRPU0UvMG1TNlVTZmlp?=
 =?utf-8?B?cUVoRW9pakx4K3BNeFVWWko0WVFEcmJsV3lZSk96MlNwVzlWSjlwY3dvNXlr?=
 =?utf-8?B?azRDMVhDWWFwRjlRRkxvOXdzN0xwdWtSYzlFMjQ3MGI3dUowR0hqRGlFdWxY?=
 =?utf-8?B?b0dEYTRxa3hYbVJOMmlIZVpiQnlYZXdyZ2ZZa3V2M00vcDl1R3pieFdIU2Fz?=
 =?utf-8?B?cEIwSm1UbGMwdTI4Ukh4NnJqSzM2YVNFWTBjTFRkMnpoS2RzUkEyM05QQmJH?=
 =?utf-8?B?ZC9TblpFK0Q3RncwNWlVTHNVM24wSlpWNnM5L2V2Wms3SWFRUHVoS3NRNWhZ?=
 =?utf-8?B?L3FUWkRCNGxBSjhCcE5FSFFiVm54aWpFMHdCSkF4NS9WaDlBS3htanI0dGd4?=
 =?utf-8?B?K2xNY2JqcjMxM0FTYm5ocXdFTE15cTdGQ1NHVHNDc3gxMW5MWDd0Zm80UmFF?=
 =?utf-8?B?ZEdjSkVISy9ibVpOdk9tY3hFWU5MOWRnWExQVFB1TnZlei93b1c0QTRBbTJV?=
 =?utf-8?B?RU1CM2J3WkVmdmg3L3B3alNabGJYQ1ZnMXFwSTFad1Q1QzZuMG5lS1owOWc0?=
 =?utf-8?B?VG5uY2Z3ZVJiTVBiUzNGMUt4dGdvdEQrSytiaUxTQUlZTW50RFpvTnhEUjJ1?=
 =?utf-8?B?dk5BdWo3YkszSVZmMUtOUXRWRXUvMU1QWUx2dDBHNGphekNhd3c0MnUraU1j?=
 =?utf-8?B?QTV4RFJ5NGdCYldhd3JZQXJ0OWJKQ2ZVUk1CVzVtam1aVUpabU1nRENORFcw?=
 =?utf-8?B?Y1FuZWRVdEVhU2J4UFYrVzMwVmVBMENVM2ZpRUF3SEozUXhaN0RNRkQ3R21J?=
 =?utf-8?B?SFVXV0hLcWh0RVhUam1ZRDFVOUtabmJLSGRGeTN4eWpVWFBqQjJhN09hdy9p?=
 =?utf-8?B?MGpyall6c2t2Z0ZtcVBwMVJSSFZsald5SlRyZVEzVGdKSXRCSXU1U1N2SDJ2?=
 =?utf-8?B?dnIzNnVOZVRiUjBZRlNzc2c0YnBITGhxekFRRnVHRVVvSXRpaC93a3R1UXIx?=
 =?utf-8?B?ZmxtMTFnNUlzd2lDNXBRYnN6NnZDVnZ4RS9SNENLbytFNDlFa3c1VDR4WENJ?=
 =?utf-8?B?bDNHZUUyU1RZVHRwQUMwNnpBb1BMMnpYKzZ0ZFc5dEpybWcwWUpnU1RMS1Z5?=
 =?utf-8?B?WDE0OXkrUDJrUlI0bWV5SkZQcGpaMmtDdlo0Z2EwbVJaMWV4bDhOVm9ibWl5?=
 =?utf-8?B?ZS9BdkNjMmlqRWw0K0s1dS9TY0dQTUs1dDdQQmJlTEZreDl1eW83WUw0aWRn?=
 =?utf-8?B?bFdZQTRsaVloZFJLeDhnMTYvTGVMcXo1bFJJeEtxcUNHV2U4bGdsV28yMG43?=
 =?utf-8?B?MkJnd1ZyakVxa3RyKzVpZTFNSHgwam92UlZmSmpCY1hXQTcwR1ZnVHpzYVJm?=
 =?utf-8?B?WjI3NzdONXZzTWRiN1JtVDUzbnFZNFN1Y0x6ZzQ2b0xMa3duZkZBQTJ2OFNY?=
 =?utf-8?B?NGd2UzlmWDdxSWMvUWFoL1FzRmFac0o2QndqWXVpdFMzYXgrNXBEd3lyL1Jy?=
 =?utf-8?B?bFJNOVNLVVppYTdsVVdLUGZaYkpXaGJ6b1lZMTJjNTlJdzlQKzVMbkFZME1y?=
 =?utf-8?B?eDV0dTNPMXNqdGNzaFI2azBBc3pkeU1wK0NrYTkrTkFBRSt5dVBDWVN2Y2FI?=
 =?utf-8?B?ejdQOTd5aVNUemdtSzUyS1Y0cVlRd0U2R25RWEJQYk81RU11c09SVUhHNnhG?=
 =?utf-8?B?QmxmeXZiQUVoU3cwYnR5b0JaZHhXdzRtc1dPMzhHN1htM1pQODVjMUJvcnNN?=
 =?utf-8?B?NC9JVmhiZi9WckdiSkFWYXd5aTZrb3UzeHZxV2JHRDdyTmVpSXF4ZHkzVlh6?=
 =?utf-8?B?ZXFLb0ZITk9qbGVRQnVUTjM2WmM5WkU0ZXhSRC90UXhpaUdzQUt3VjVMc01B?=
 =?utf-8?B?am1laVI1anZvUkEwR2JPNUlITGk4SjkvUis2bVlFZWdMSWRUS0ZQWE9qdlVZ?=
 =?utf-8?B?QUF5aVRraDBQTVpBQ0xSU1BZSkZHcjcyM2hVcElNZnl4TGQvaTFESEdsQ3dq?=
 =?utf-8?B?MzQzd0w0dWY3Ly80ZTZiN1FlaU1CNlR3c1VRbG5yZnBvZlNMNXE3RUNCOFI4?=
 =?utf-8?Q?SMGCZA0pBYYEdFns=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <755988F68BDE774183772A721369E688@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0663db-136c-4dfd-3606-08de694841fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 08:33:39.8702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /1+fja9sGAleg3ovWWhvDBFK1xp9zmKYf1r5DcrW5AUtYY0rSwfvl5OrpEIRPKk0c9KpRYMhKx+/l2i4+QiTzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7294
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
	TAGGED_FROM(0.00)[bounces-31721-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[urldefense.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mediatek.com:mid,mediatek.com:dkim,mediatek.com:email];
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
	REDIRECTOR_URL(0.00)[urldefense.com];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 0F7A0122479
X-Rspamd-Action: no action

T24gV2VkLCAyMDI2LTAyLTExIGF0IDA5OjE2ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxMS8wMi8yMDI2IDA5OjEzLCBSeWRlciBMZWUgd3JvdGU6DQo+ID4gT24gV2Vk
LCAyMDI2LTAyLTExIGF0IDA3OjMxICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0K
PiA+ID4gT24gVHVlLCBGZWIgMTAsIDIwMjYgYXQgMTA6MDg6NTZBTSAtMDgwMCwgUnlkZXIgTGVl
IHdyb3RlOg0KPiA+ID4gPiBDbGFyaWZ5IHRoZSBmb3JtYXQgb2YgcGF0aCBiYWNrb2ZmIGxpbWl0
IHByb3BlcnRpZXMgaW4gbXQ3Ng0KPiA+ID4gPiBiaW5kaW5nLg0KPiA+ID4gPiBBZGQgZXhwbGlj
aXQgZG9jdW1lbnRhdGlvbiBmb3IgY29ubmFjMiAobXQ3OTE1LCBtdDc5ODEsIG10Nzk4NikNCj4g
PiA+ID4gYW5kDQo+ID4gPiA+IGNvbm5hYzMgKG10Nzk5MCwgbXQ3OTkyLCBtdDc5OTYuLi4pIGRl
dmljZXMsIGluY2x1ZGluZyB0aGUNCj4gPiA+ID4gZGlmZmVyZW5jZQ0KPiA+ID4gPiBpbiBiZWFt
Zm9ybWluZyBhbmQgbm9uLWJlYW1mb3JtaW5nIGVudHJpZXMuDQo+ID4gPiANCj4gPiA+IEkgZG8g
bm90IHNlZSBhbnkgcmVmb3JtYXR0aW5nIGhhcHBlbmluZy4NCj4gPiA+IA0KPiA+IE1heWJlIEkg
c2hvdWxkIHVzZSAicmVwaHJhc2UiIGhlcmUuDQo+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBBbHNv
IHJlZm9ybWF0IHRoZSBkZXNjcmlwdGlvbiB0byBtYWtlIGlzIG1vcmUgcHJlY2lzZS4NCj4gPiA+
ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFsbGVuIFllIDxhbGxlbi55ZUBtZWRpYXRlay5j
b20+DQo+ID4gPiA+IENvLWRldmVsb3BlZC1ieTogQWxsZW4gWWUgPGFsbGVuLnllQG1lZGlhdGVr
LmNvbT4NCj4gPiA+IA0KPiA+ID4gSW5jb3JyZWN0IFNvQiBjaGFpbi4gUmVhZCBzdWJtaXR0aW5n
IHBhdGNoZXMuDQo+ID4gPiANCj4gPiANCj4gPiBXaWxsIGZpeC4NCj4gPiANCj4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiAt
LS0NCj4gPiA+ID4gwqAuLi4vYmluZGluZ3MvbmV0L3dpcmVsZXNzL21lZGlhdGVrLG10NzYueWFt
bMKgIHwgMjANCj4gPiA+ID4gKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gPiDCoDEgZmlsZSBj
aGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspDQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZmIC0tZ2l0DQo+
ID4gPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC93aXJlbGVzcy9t
ZWRpYXRlayxtdDc2Lg0KPiA+ID4gPiB5YW1sDQo+ID4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL25ldC93aXJlbGVzcy9tZWRpYXRlayxtdDc2Lg0KPiA+ID4gPiB5YW1s
DQo+ID4gPiA+IGluZGV4IGFlNmI5N2NkYy4uNDE1NmUxYzk3IDEwMDY0NA0KPiA+ID4gPiAtLS0N
Cj4gPiA+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3dpcmVsZXNz
L21lZGlhdGVrLG10NzYuDQo+ID4gPiA+IHlhbWwNCj4gPiA+ID4gKysrDQo+ID4gPiA+IGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC93aXJlbGVzcy9tZWRpYXRlayxtdDc2
Lg0KPiA+ID4gPiB5YW1sDQo+ID4gPiA+IEBAIC0yNTIsNiArMjUyLDE2IEBAIHByb3BlcnRpZXM6
DQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZv
bGxvd2VkIGJ5IDEwIHBvd2VyIGxpbWl0IHZhbHVlcy4gVGhlDQo+ID4gPiA+IG9yZGVyDQo+ID4g
PiA+IG9mIHRoZQ0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBjaGFubmVsIHJlc291cmNlIHVuaXQgc2V0dGluZ3MgaXMgUlUyNiwNCj4gPiA+ID4g
UlU1MiwgUlUxMDYsDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIFJVMjQyL1NVMjAsIFJVNDg0L1NVNDAsIFJVOTk2L1NVODAgYW5kDQo+ID4gPiA+
IFJVMng5OTYvU1UxNjAuDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgLSBGb3IgY29ubmFjMg0KPiA+ID4gDQo+ID4gPiBUaGVyZSBpcyBubyBzdWNo
IHRlcm0gYXMgY29ubmFjMiBpbiB0aGlzIGJpbmRpbmcgYXQgYWxsLg0KPiA+ID4gDQo+ID4gPiBX
aGF0IGlzIHRoZSBwb2ludCBvZiBhZGRpbmcgbmV3IHRlcm1zPw0KPiA+IA0KPiA+IEkgZGlkbuKA
mXQgdGhpbmsgaXQgd2FzIG5lZWRlZCBhdCBmaXJzdCwgYnV0IG90aGVyIHJldmlld2Vycw0KPiA+
IHN1Z2dlc3RlZA0KPiA+IGFkZGluZyBpdC4NCj4gDQo+IA0KPiBBZGRpbmcgc2VjcmV0IHRlcm1z
IGluIHRoZSBiaW5kaW5nIGlzIG5vdCBoZWxwaW5nLg0KPiANCj4gPiANCj4gPiBUaGUgY29tbWl0
IG1lc3NhZ2UgdGFsa3MgYWJvdXQgbXQ3OTE1LCBtdDc5OTAsIG10Nzk5MiwgYW5kIG10Nzk5NiwN
Cj4gPiB3aGljaCBhcmUgYWxsIFBDSWUgV2lGaSBkZXZpY2VzLCBzbyB0aGVpciBuYW1lcyBhcmVu
4oCZdCBpbmNsdWRlZCBpbg0KPiA+IHRoZQ0KPiA+IHBsYXRmb3JtIGJpbmRpbmcuIE9ubHkgV2lG
aSBpbnRlZ3JhdGVkIFNvQ3MgbGlrZSBtdDc5ODEgYW5kIG10Nzk4Ng0KPiA+IGFyZQ0KPiA+IGxp
c3RlZC4NCj4gPiANCj4gPiBUaGVzZSBkZXNjcmlwdGlvbnMgYXJlIG1lYW50IHRvIGV4cGxhaW4g
aG93IGEgcGxhdGZvcm0gY29uZmlndXJlcw0KPiA+IFRYDQo+ID4gcG93ZXIgZm9yIHRoZSBjb25u
ZWN0ZWQgV2lGaSBkZXZpY2VzLCB3aGV0aGVyIGl04oCZcyBhIFBDSWUgTklDIChsaWtlDQo+ID4g
Q29ubmFjMyBkZXZpY2VzIEkgbGlzdGVkKSBvciBhbiBpbnRlZ3JhdGVkIFNvQyBpdHNlbGYgKGxp
a2UNCj4gPiBtdDc5ODEvbXQ3OTg2KS4NCj4gPiANCj4gPiBXaGF0IGRvIHlvdSBzdWdnZXN0PyBJ
4oCZbSBhY3R1YWxseSBva2F5IHdpdGgga2VlcGluZyBldmVyeXRoaW5nIGFzDQo+ID4gaXMuDQo+
IA0KPiBJIGhhdmUgbm8gY2x1ZSB3aGF0IHlvdSB3YW50IHRvIGFjaGlldmUuDQo+ID4gDQo+ID4g
WW91IGNhbiBhbHNvIGxvb2sgYXQgdGhlIHYyIGRpc2N1c3Npb24uDQo+ID4gW3YyXSB3aWZpOiBt
dDc2OiBmaXggYmFja29mZiBmaWVsZHMgYW5kIG1heF9wb3dlciBjYWxjdWxhdGlvbg0KPiA+IGh0
dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3By
b2plY3QvbGludXgtbWVkaWF0ZWsvcGF0Y2gvNTQ2MjcyODJjZmI4ZTVhODlmZTc1M2RhNjY1NTJj
MGEwODRmNjM4Ny4xNzY5NTU3ODYzLmdpdC5yeWRlci5sZWVAbWVkaWF0ZWsuY29tL19fOyEhQ1RS
TktBOXdNZzBBUmJ3IWtEWG03WWZaWTlmRGlZUEVXeDdGV2V2bVkzQXFZR2QybTlNbHdvTVpMSFp1
cThKQmdmbTJuMDJvRkowYWc2OTJTZ0VUVG10U1NXMUYtUSQNCj4gPiDCoA0KPiANCj4gVGhhdCdz
IGRyaXZlciBjb2RlLg0KPiANCg0KVGhlIGRyaXZlciBjb2RlIHVzZWQgdG8gcGFyc2UgdGhlIERU
Uy4gWW91IGNhbiBsb29rIGF0IHRoZSBmaW5hbA0KZGlzY3Vzc2lvbuKAlHRoYXTigJlzIHdoeSB3
ZSBuZWVkIHRvIGNoYW5nZSB0aGlzIERUUyAoaWYgeW914oCZcmUNCmludGVyZXN0ZWQpLiBUaGlz
IHdob2xlIHNlY3Rpb24gaXMgYSBkaXNjdXNzaW9uIGFib3V0IHRoZSBkaWZmZXJlbmNlcw0KaW4g
aG93IHRoZSBkcml2ZXIgcGFyc2VzIHRoZSBEVFMuIEJ1dCB0aGlzIHBhcnQgaXMgYWxyZWFkeSBn
ZXR0aW5nIGludG8NCldpRmktc3BlY2lmaWMgZGV0YWlscw0KDQoiRWFjaCBmaWVsZCBjb3JyZXNw
b25kcyB0bzogMVQxc3MsIDJUMXNzLCAzVDFzcywgNFQxc3MsIDJUMnNzLCAzVDJzcywNCjRUMnNz
LCAzVDNzcywgNFQzc3MsIGFuZCA0VDRzcywgZm9yIGEgdG90YWwgb2YgMTAgdmFsdWVzLg0KDQpG
b3IgYmVhbWZvcm0gY2FzZSwgbXQ3NiBkb2VzIG5vdCBuZWVkIHRvIGZpbGwgaW4gdGhlIHZhbHVl
IGZvciAxVDFzcywNCnNvIHRoZSBsZW5ndGggaXMgOS4NCg0KRm9yIG5vbi1iZWFtZm9ybSBjYXNl
LCBtdDc2IG5lZWRzIHRvIGZpbGwgaW4gdGhlIHZhbHVlIGZvciAxVDFzcywgc28NCnRoZSBsZW5n
dGggaXMgMTAuDQoNClRoZSBEVFMgc3RpbGwgbmVlZHMgdG8gcHJvdmlkZSAxICsgMTAgYmVjYXVz
ZSBtdDc2IGRvZXMgbm90DQpzcGVjaWZpY2FsbHkgY2hlY2sgZm9yIHRoaXMgd2hlbiBwYXJzaW5n
IERUUy4NCg0KU28gYSBjb25uYWMyIERUUyB3b3VsZCBiZSBmaWxsZWQgbGlrZSB0aGlzOg0KDQpw
YXRocy1ydS1iZiA9DQo8MSAyMCAyMiAzOCAzNiAyNCAzMCAyMyAyMSAyOCAyOT4sDQo8MSAyMCAz
OSAzMSAyNSAyNiAyNSAyOCAzMCAzOSAzOT4sDQo8MSAzNyAzNCAyNiAyNiAyNSAyMSAzNCAyMyAz
NCAyND4sDQo8MSAwIDIwIDIzIDMxIDIzIDMwIDM5IDI4IDI5IDM2PiwNCjwxIDAgMjcgMzQgMzMg
MzQgMjkgMzggMzMgMzMgMjI+LA0KPDEgMCAzMCAyMyAzOSAyOCAyMSAyNSAyOSAyOCAyMT4sDQo8
MSAwIDM0IDIwIDM4IDMyIDM1IDMzIDM3IDI2IDM2PjsNCg0KV2hlbiAxVDFzcyBpcyBub3QgdXNl
ZCwgaXQgc2hvdWxkIGJlIGZpbGxlZCB3aXRoIDAuIEZvciBjb25uYWMzLCBzaW5jZQ0KMVQxc3Mg
aXMgdGFrZW4gaW50byBhY2NvdW50LCB3ZSBkb27igJl0IG5lZWQgdG8gZmlsbCBpdCB3aXRoIDAu
DQoNClRoZSB1bnVzZWQgMVQxc3Mgc3RpbGwgbmVlZHMgdG8gYmUgd3JpdHRlbiBpbiB0aGUgRFRT
LiBUaGlzIGlzIHRvIG1ha2UNCnBhcnNpbmcgZWFzaWVyLg0KDQpTbyB0aGUgbnVtYmVyIGluZGlj
YXRlZCBpbiB0aGUgY3VycmVudCBkb2N1bWVudCBpcyBjb3JyZWN0OyBpdOKAmXMganVzdA0KdGhh
dCB0aGUgZGVzY3JpcHRpb24gaXNu4oCZdCBwcmVjaXNlIGVub3VnaC4iDQoNCj4gPiANCj4gPiA+
IA0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAtIEJlYW1mb3JtaW5nIGVudHJpZXMgZm9yIEJXMjB+QlcxNjANCj4gPiA+ID4gYW5kDQo+ID4g
PiA+IE9GRE0gZG8gbm90DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpbmNsdWRlIDFUMXNzLg0KPiA+ID4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIFdoZW4gMVQxc3MgaXMgbm90IHVz
ZWQsIGl0IHNob3VsZCBiZQ0KPiA+ID4gPiBmaWxsZWQgd2l0aCAwLg0KPiA+ID4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gRm9yIGNvbm5hYzMNCj4gPiA+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBCZWFt
Zm9ybWluZyBlbnRyaWVzIGZvciBCVzIwfkJXMTYwDQo+ID4gPiA+IGFuZA0KPiA+ID4gPiBSVSBp
bmNsdWRlDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAxVDFzcywgYnV0IE9GRE0gZG9lcyBub3QgaW5jbHVkZQ0KPiA+ID4gPiAxVDFz
cy4NCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgLSAxVDFzcyBpcyB0YWtlbiBpbnRvIGFjY291bnQsIHNvIG5vDQo+ID4gPiA+IG5lZWQNCj4g
PiA+ID4gdG8gZmlsbCB3aXRoIDAuDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgTm9uLWJlYW1mb3JtaW5nIGFuZCBSVSBlbnRyaWVzIGZvciBib3Ro
DQo+ID4gPiA+IGNvbm5hYzIgYW5kDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgY29ubmFjMyBpbmNsdWRlIDFUMXNzLg0KPiA+ID4gDQo+ID4gPiBX
aHkgdGhpcyBjYW5ub3QgYmUgYSBzY2hlbWE/DQo+ID4gPiANCj4gPiA+IA0KPiA+IFdlbGwsIGFj
dHVhbGx5LCBpdCdzIGFscmVhZHkgYSBzY2hlbWEuIFRoaXMgaXMganVzdCBhbiBleHBhbmRlZA0K
PiANCj4gV2hlcmUgZXhhY3RseT8NCj4gDQoNCkhvdyAxVDFzcyBpcyB1c2VkIGFjcm9zcyBkaWZm
ZXJlbnQgZ2VuZXJhdGlvbnMgaXMgd2hhdCBteSBleGFtcGxlIGFib3ZlDQp3YXMgdGFsa2luZyBh
Ym91dC4NCg0KPiBCdXQgaWYgaXQgaXMsIHRoZW4gdGhpcyBwYXRjaCBpcyByZWR1bmRhbnQuIERv
bid0IHJlcGVhdCBjb25zdHJhaW50cw0KPiBpbg0KPiBmcmVlIGZvcm0gdGV4dC4NCj4gDQoNCkFs
cmlnaHQgdGhlbiwgbGV04oCZcyBkcm9wIHRoaXMgY2hhbmdlLiBGZWxpeCwgcGxlYXNlIGlnbm9y
ZSB0aGlzIG9uZS4NCg0KUnlkZXINCg==

