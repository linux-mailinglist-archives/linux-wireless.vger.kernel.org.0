Return-Path: <linux-wireless+bounces-31780-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMhQG78OjmmS+wAAu9opvQ
	(envelope-from <linux-wireless+bounces-31780-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 18:32:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9040612FF57
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 18:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CD637302C798
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 17:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C2C26562D;
	Thu, 12 Feb 2026 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ncuOi2Qp";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="KCJbrIyw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5377B35972;
	Thu, 12 Feb 2026 17:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770917541; cv=fail; b=Y6m3VxtXs/AfWmf/Mxbu1OIfASHzh91CYLQdJZbVYLOYRy6O5AkznwhG9N5a0CiPUt3rOMCce1DqD/N8c7YWMtqOxHYEzqolQ/QhHvN9D3rFN1Exahx4rlqnG/uaovf50469nH2IRQWdGfOVXeC0ZWOf43zOMe3L8SDdRwfLF4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770917541; c=relaxed/simple;
	bh=MuGHAgBhnpDeM0NN1uvHT6jcuwjYXZGj+0dsxeb18aQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lVqMCcN2MnlyXxG7YjCURKi6HEifLw7OA1uzGNxCJHMAtQTLRNiscWKnE91EfXrjXgyUll5l2CA4gXvudyu/avVBZEeB+3SExHzAEpT7/jlqtluN/t8g7QoEsyJxIPrl2g03rLCG9Kqs78QFOaWDnAIdKgJiP5jPIVe1VAhpHtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ncuOi2Qp; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=KCJbrIyw; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c4a5cd44083811f1b7fc4fdb8733b2bc-20260213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=MuGHAgBhnpDeM0NN1uvHT6jcuwjYXZGj+0dsxeb18aQ=;
	b=ncuOi2QpA4U6QbY+AKhKyjn/UfWR1BXrKRBqHISushKbqXnHhuMiSms0DcXr5tbDymVKksoaSu1U8dfDK9DDq3B82AqQdumms8gyNZAjj8BK1UOcmPSUPYp1qgfM4fadoiwRi6+UkI6DOKnofHk55NUgWtkUulCWdO+gemOk3mY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:7c8ba4b8-876c-4e2b-a42e-cc5d238c90b3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:16b79de9-ef90-4382-9c6f-55f2a0689a6b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c4a5cd44083811f1b7fc4fdb8733b2bc-20260213
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 977651287; Fri, 13 Feb 2026 01:32:13 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 13 Feb 2026 01:32:12 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 13 Feb 2026 01:32:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MfT2XDDTDXj0dtJ+3F24TEs9ANG8pP3l3gxDUhAYQC/RHxixEwT7SmHYpO5pj6xPZ7BPWD/QCUJtNQA6lbfVa1EpxoPaHJ/4qpEwE2qQJlzaZHdc7GDGzEfgTvPkLjTxa6iAEG58uBqh/S0y5DGA6p40fcqXHHjxblZWsqfemRWoKGnGDkWtwf7vQj2/uAUa6u6A7y3MW18ZHjRnIDQigLDzlFZ1Wxqi7q/j6tbTMQpCgwZX7GUvASJQA8JFjNOWAiPONplszdXsC4qNJZEiouSz9mfPDvO/oDo9utDHRi5pxds0pf2i19FXr7QDT32r6L2OVWa/UvOfawRB89M/4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuGHAgBhnpDeM0NN1uvHT6jcuwjYXZGj+0dsxeb18aQ=;
 b=Y1wZ2aC3LsqyS2X1oMwIaNL1c97v+AO+Mt3InANu7I/tJU6Oa7BHdCk/gP2X+Fmc2jlrMpnYts72CFBG1ZQCu27vJuHkkrsiRMUucyhMemRxK8Km7U5eY0y9+hd0RUQl97cDQrJD0LdibrtvD5ji7UU/sekJ4Nwr7ngXRbEcKd9PARLtehsmXKw99qNd4tu12ouH+waYALZAj/v8RDwqzyCDAb0CnkFiZz97v4G+jEiw1k8EIey//P0mirNJWj04ak9sXMMXAVPayzanzKQbZ9SjGqy4fv8DvFY7kWsD3krPGlMvVTk234PY8Khvg3Rz/0aoHPEa5PPXxFMKJGIOwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuGHAgBhnpDeM0NN1uvHT6jcuwjYXZGj+0dsxeb18aQ=;
 b=KCJbrIywTG094pEAcmriJO11Udx5c+jBFJ3ZuT1dJejtXziUdbILyBYq3Mka19leZeoTfYT3mYffDTDpgVKsFpNR56/p+Fy3p19TOAYbS6tQo01+CJJ1kmIEZ7Er5pdQrcVouIhVd5MaFYGxQWtgaWmm5L0z8tUov93UN6kNUfg=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by TYZPR03MB7243.apcprd03.prod.outlook.com (2603:1096:400:28f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Thu, 12 Feb
 2026 17:31:05 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059%3]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 17:31:05 +0000
From: Ryder Lee <Ryder.Lee@mediatek.com>
To: "krzk@kernel.org" <krzk@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "nbd@nbd.name" <nbd@nbd.name>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?QWxsZW4gWWUgKOiRieiKt+WLsyk=?= <Allen.Ye@mediatek.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] dt-bindings: net: wireless: mt76: clarify backoff
 limit usage
Thread-Topic: [PATCH v5 2/2] dt-bindings: net: wireless: mt76: clarify backoff
 limit usage
Thread-Index: AQHcm7eYqvgd8GpaTkeReXu6kWW7S7V+sQqAgACiP4A=
Date: Thu, 12 Feb 2026 17:31:05 +0000
Message-ID: <d7e22b328fda50ebbf96f334fc15d63da9e7c19b.camel@mediatek.com>
References: <8fa8ec500b3d4de7b1966c6887f1dfbe5c46a54c.1770856296.git.ryder.lee@mediatek.com>
	 <e39bff1d56a3f8b5146b881eef3442a4af97078b.1770856296.git.ryder.lee@mediatek.com>
	 <20260212-benevolent-peacock-of-rain-afbb6b@quoll>
In-Reply-To: <20260212-benevolent-peacock-of-rain-afbb6b@quoll>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|TYZPR03MB7243:EE_
x-ms-office365-filtering-correlation-id: f895ce45-a2b6-4619-e653-08de6a5c804b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?K1NXVVZ0T2h6VUpaa2dEVXdaR1ROSFRVMXB6ZTZvaWdLa1I1ejcxS25uY3gw?=
 =?utf-8?B?VkltblZ4OHhvenBaeTJrQ2VUZUpxUG8vZHNwQ0FIMDlORUNEaUg3OFVkSXQw?=
 =?utf-8?B?UUVPa0ZZa0NLRVMrT1Y5dFplazVzVTRJWTdDSHNLN2wzczk5L1YwQXJXTVE5?=
 =?utf-8?B?OWN1dWwreVk5S2haejlDYytXcjNiSkc2cThGZ0NLa2o2bWZwb09ZK2VhN0Zw?=
 =?utf-8?B?K3RodGtOSHIzSDBWSTB0elNicFlGNENTa1VzZGFSUHZ4L0Y1cDFSaXpIdXNX?=
 =?utf-8?B?cjgwdWFka3YyYUI5ZlNGL3RjNmFVN1ZTZTZRRjhEZ0dNd3RhU2tMSXFxc3hN?=
 =?utf-8?B?L0dXSEVzMTRtdWZYN2Q3Nk4vM21ObGtvSHljaWs5eHAxdVNDc3p3bnJ0TG5n?=
 =?utf-8?B?S3puSFd5c09LUkF5UEVWc3IwRnFmcVJOU0w2MlNoTHlybmFnZ2pRMzR4RXkw?=
 =?utf-8?B?L0YyRDJhZ2dlQmpVb2FHczdBSXpVV1hDc1J1d0NBQzhGV1hHVVZwWldTMGlr?=
 =?utf-8?B?S0hWRFNjUUhCRDZwODhnZHpKdHdQZ3JLWHJUOXNucjlNM1FpeC83Lzk2QXlG?=
 =?utf-8?B?T1NMUExSWTFrOEtaMTZNVTBWaENuRi9DQXhmM1ZQZDJHM3RTaExHR0lCMkdm?=
 =?utf-8?B?TGFCNzhrMXRSMVNuWGhsZFFVb1hFSmV1Y0VacTJ3Qm1JVUZmTGpJdmE5eloy?=
 =?utf-8?B?STgwVlEva25zRUcrc1puQVlIT2VLUWZPbklpYXBHZ1ZWQ24zU2owbnh2N3VN?=
 =?utf-8?B?OVhPT0M0Vzc5NTkyTjgxcFBTU2paQmlSV3A2bzNOLzVzT3ZiSnNEYTRENmFQ?=
 =?utf-8?B?Q3hiWFZoNWNrK3dLeCtSRmdvc3NnS3lrL0thenVETlIwcHNOTEN0LzVXMTRF?=
 =?utf-8?B?V3lzM0FGL2prS2NYck9PNEFJM2xJSmMvWmM2Nm44QnU5RW5hbWVidUFXb09N?=
 =?utf-8?B?TzhDZXZxS21CeEZRT3JuTFhqZW1LeXhiZG5CUjFmdDdUWEd0TEpLb3haUE5P?=
 =?utf-8?B?bk5ZZE94SWlCaENEV0QvdXVpUDIzbVpnODN5K2dXWGh3SGxMM3BwWHNWL1Fy?=
 =?utf-8?B?K3BKTXNqdWI3VEZSYURuNThVQllQMmNLL01LNVRyQU0zUDU3cjJlemhvbHVO?=
 =?utf-8?B?TnFFaFl4ZkNkdzY1Mlc3cEpqQWVMRWhVcHZWSVlqWk43VUZZTTh6VG9iRy9P?=
 =?utf-8?B?dVcxQnlZUW9MTEFpalRrbEhkclIxZ3AraDZTb09UTzczTXZKejJ5OTRwUnRM?=
 =?utf-8?B?Y1ZCSUJVRVFKWWFYb1doSy95eHVKZktqYU1GNXNKc1RHWmQ4R2Nmb0lhck9W?=
 =?utf-8?B?S3RtVHNlOWFPc3JTQWRxRU1JZWRiaFVGekpMcUhtdTRQa3NaWGZkNllVMXM0?=
 =?utf-8?B?SGwybXhuTjBWNENJU2lXZkVKL3IvOFBtYnFzZmxGWHVSeWpuRUdQbnI1bzJh?=
 =?utf-8?B?dXh6ZW1RUjJIVStRVmV1NksrZk96Sk5pUm9tSy9nekFxdHFvZFZuYW5qSUsv?=
 =?utf-8?B?VkxxME1jTnhqVFY3U1I1a0RMZ2lTQXNJdktHQldkbXhlMmx4emRlTktnZ0Nk?=
 =?utf-8?B?ZldtQ281dGVrTGpQa2g4Uy9lTG4yR3ZDelF6MUNnbnlHcFpmK2FHT3hZSS9C?=
 =?utf-8?B?TVhiZG5sQTREbjFwdXp6bDAxVWRDVHFWUlNmZjBEM0g4Y01NdHhZNXMyOVhJ?=
 =?utf-8?B?Nk9pQ1RxTi9zQXo0SjU4U3ZLOVpvS0IyYTVzV3Y1Z0RDcC9mbGV6L1FBbXpt?=
 =?utf-8?B?VGVjcWI4cUVRRnRmcjZXa0xHbitQZGx6blRTZXliWnZpc2xYSWVVNVVFVjMx?=
 =?utf-8?B?RkpJT2ZGdDBlWEZJdm54THBOVVRTbUI4KzNQSXJQSnBwQW94MWlZdU5ZaGI3?=
 =?utf-8?B?VFhsdStnWG1YbmVlVmhrMWV1K1IycTFXbGhXdkNsT3I2UHU3L2lTVkZBZzRM?=
 =?utf-8?B?TEpiQzVWc1A2NTBHRkJ0WUNSL2tiQjBsajV0d1pSbjUwZWpvTjNZWkgvcVpm?=
 =?utf-8?B?U2Y1VTNUNE5IbytPMkw5blU2MnR1WTRPTmJtUSs5bG5ZcHU3WUNjbHdvN1dx?=
 =?utf-8?B?Y0tQcnpCOHE1bUZnb3lyMzhhNHlHWEovNzhXQnUwZmlvUCtEZmRETEdCVGZP?=
 =?utf-8?B?OU96eDNoZHN2RXJVVWFHMFdIU3ZTd0VDR1diR0IrcTQ5VUNRV0lpUzFINTU1?=
 =?utf-8?Q?HAEAmBv9syZNLENxb2J78GA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RG9lQ2ZZOTRGeGtOVHRLSWR2bU9NckRhYVBjMzNPQldlL2xzUkF3THpzR0tW?=
 =?utf-8?B?dDlIWU0zZ1JTQkNZUmpmZVJuRFNZS01tVzI0UjNhVERvdWxMNitVR2xHeklN?=
 =?utf-8?B?MWJZdlltSzk1WjVaS1JpbXV2RWhWTm1CNWhRT2N1eWlrUlE2UURTMVlyTjls?=
 =?utf-8?B?UitML1dnMjdaZ1hncmF5RmVlV0R2cW5ySmQ3SFM3R204Y2FCayt6bG1HVmZx?=
 =?utf-8?B?QytrMEF6SDNVY0k5N2NWcnNMY1FzODcrb0Y4c1NpTVYrQTdxZUg4Q2dZZWFC?=
 =?utf-8?B?V2E3T3YxZVRuZ2tXUWJRVldUTThaZWdBVUpvZUVRUWJ0aFphNnJHcHd3Myt1?=
 =?utf-8?B?SkFibTE1MnBybzlKQmU2SURJRTJtbzdPdm8zTG9VRENnLzJNYzdMRXBoQlRp?=
 =?utf-8?B?dGM2ZXhqblZ0UnVHS3FwNUE1OE90b3R5Ylpqc3dSMlcrcnV6elM2Tm5Xdklz?=
 =?utf-8?B?cWVQbDc0RlhMZ1R4bGppbC9xa3F3U1FSVEVPY1FxdW1IUE4wV3hMZEY5OG52?=
 =?utf-8?B?WUJycUI3STBuSG5yRDdFM0lVK1lTZXBIVkx4Q3JvQThzalV3bHp1ZjdzQ3Zr?=
 =?utf-8?B?amNTRUxFZmtvTmJWc0pXcW4zRTJRem5DSjZFWHZOdEpSS1ZicHpleTNJTmlJ?=
 =?utf-8?B?eWlmZFdjVHN6S1pPU3dzYlliTElFSldNbkt3UFNBUmtzSnhFVnpMWGR1a0Jw?=
 =?utf-8?B?NWVCWUtheFExck1Jd2srQ245eUFJWVlxMjdTdi9HQkFBakdMUUhOTC9mWlJB?=
 =?utf-8?B?ZCs0UTgxY1AwMW9JVVE5cGFYci9NYTNuMExSdFRBWjVTSnhKWSs3bGU2eEpW?=
 =?utf-8?B?S2RnajJPa2RGS1h5WFVoT1hHcFZGRmVla1hkSTdjYTByUjB0WlVFSWxuVDBq?=
 =?utf-8?B?dDZZODJUbys1aDVGYmhhVGxSY2VtUXVVTjBjMG94cmN2Nm5QOFU1amFWTHVp?=
 =?utf-8?B?V1J6K2dWODZDcnd5RUI1T1A2RkR6UU01UlhhNHlkQ3hLTFFCVnRmSW5BWFpQ?=
 =?utf-8?B?TWRMbll2SzVCbVZaRmVzT2c4T3hmL2RPTVY5T09LdlgwcHAwVTBNU1A1UkZ5?=
 =?utf-8?B?UXJZRkZoN0JXY2d6Tlo4KzBVTkwvQ3g1TXQ2WjBUL0VZcEl6SzZnMExyVzdu?=
 =?utf-8?B?dFYvVFFHY1E0RnpJUXU0TkVneGQ1bHQzdVBlRXN6K0VhQzlNVkJOSlBtR1lw?=
 =?utf-8?B?RW44aGF6blprcWdTYnVKcjUwbUNKNUdSRDFTQ1dEcGI1R3hNVXRTMVVJdUxI?=
 =?utf-8?B?d3Nid0w5cjhUUmFWN0Jtb2NQOHBCOWpVOW1pNCtUMDEvcHEyYlNKZUlzWXM4?=
 =?utf-8?B?VUw0T09zQWE1ZitOdFRxOEFDWVFDcE5wRE1WQlNZWEs4a0pLbEJGaVFnTlZu?=
 =?utf-8?B?T1ZEeEttWmh0b0NXczQ0ZS8zWlo2QXpqcW44S0YvcGR1UUhEdEtwcjFNRmZr?=
 =?utf-8?B?VmdJTi90eU1rS21uTHZlNDJRWHNVS0VSellmQ3lWZyt0MHEyU0tvbmlDRSts?=
 =?utf-8?B?cnU5OUpOS3hLZFF0eGZBTmRXM2R2bm5LZWNuS0VYajB4WnRjMmFvM09YRmV4?=
 =?utf-8?B?NUpHMnNTeWRvQUQzRlVnMzU3aXY5dm5oRm9QeHRBK3IxSkk1bmdhZkVEUHRm?=
 =?utf-8?B?QXVCVXJmU1M2R0JRRXRyOE9ZdVZFUVE3K0c3TlNrY29VaGF0aVdPSXYwelRE?=
 =?utf-8?B?NFdBK01kd1oreTdjMkV2RGJZbUxUOFJDSm9SOWtxZmcxMTI2VFBwbHN0OEdI?=
 =?utf-8?B?MC9NYTkrMkozM2VwazBhTFQ1MFBmL3BPdTVLdElKbmxyaWZhODdRNks2bzgy?=
 =?utf-8?B?cWFlUHBzSExCUDM4NzlKSnkrRllsWXQvUkRRTEs1T0VqcFVKQnpMOUdHYW1X?=
 =?utf-8?B?VnNZL24zZWh2YWdhdXdqTEhHOXdqdFd5M1J3UGZBOGYyU0ZISElHMkNSbjRz?=
 =?utf-8?B?TEZNeWFqVHYzT1VTWmtUWUhuWWdHT1FIVGl5U2RyZG1WMEF3T0lEVlM5c0dk?=
 =?utf-8?B?cE1EV2dKZG4waXBsWlp2UytoS04xMElicGxjdlVrWEM4T2tIaHZTZ0JkVFJ5?=
 =?utf-8?B?VHYvTWgxam1vbXNnd09FQWMwblVwMG93Sm8zaXRFdEtuYjkxMHFKQjAwcXpi?=
 =?utf-8?B?MUNLQkcvYzR4b3lxSUlJYUJwU1RxVTI3SFA5amtXZEpyenhDVk5EaHEwcnFv?=
 =?utf-8?B?T2pBcDJnRDJVSlhLelo0UDhRekVTOXRWUHNYTm1CVFhyRzcwRjI4S2g0cHFV?=
 =?utf-8?B?SUhDQldJS3k1MEwvbEc4Q0hqcnVOa05NK1FYeDBwYldaSE1Ob00zTU1JM1Vn?=
 =?utf-8?B?TndKRldlT0M1NHROYmppd2ZLMjFUc2tYNnhRQ3Ard2dCWU1GWVNoOU5SdEVC?=
 =?utf-8?Q?yTiP5RFAX7zOTsnE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9120CCE2056AC246B02CE65AAD5C1A41@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f895ce45-a2b6-4619-e653-08de6a5c804b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 17:31:05.4772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YzIhptBXU9Qth83pgcftAAw2TT/o3dZToN+QQQUr9QRXc2EfLBJiI24wQbsK1faEmswjmBECCOSHgAVi+cCZXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7243
X-MTK: N
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk,mediateko365.onmicrosoft.com:s=selector2-mediateko365-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31780-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mediatek.com:mid,mediatek.com:dkim,mediatek.com:email,mediateko365.onmicrosoft.com:dkim];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 9040612FF57
X-Rspamd-Action: no action

T24gVGh1LCAyMDI2LTAyLTEyIGF0IDA4OjUwICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiBXZWQsIEZlYiAxMSwgMjAyNiBhdCAwNDozNjowNlBNIC0wODAwLCBSeWRlciBM
ZWUgd3JvdGU6DQo+ID4gQ2xhcmlmeSB0aGUgdXNhZ2Ugb2YgcGF0aCBiYWNrb2ZmIGxpbWl0IHBy
b3BlcnRpZXMgaW4gbXQ3NiBiaW5kaW5nLg0KPiA+IEFkZCBleHBsaWNpdCBkb2N1bWVudGF0aW9u
IGZvciBvbGQgZ2VuZXJhdGlvbiAobXQ3OTE1LCBtdDc5MTYsDQo+ID4gbXQ3OTgxLA0KPiA+IG10
Nzk4NikgYW5kIG5ldyBnZW5lcmF0aW9uIChtdDc5OTAsIG10Nzk5MiwgbXQ3OTk2KSBkZXZpY2Vz
LA0KPiA+IGluY2x1ZGluZw0KPiA+IHRoZSBkaWZmZXJlbmNlIGluIGJlYW1mb3JtaW5nIGFuZCBu
b24tYmVhbWZvcm1pbmcgZW50cmllcy4NCj4gPiANCj4gPiBSZXBocmFzZSB0aGUgcGF0aHMtcnUv
cGF0aHMtcnUtYmYgZGVzY3JpcHRpb24gdG8gbWFrZSB0aGVtIG1vcmUNCj4gPiBwcmVjaXNlLg0K
PiA+IA0KPiA+IENvLWRldmVsb3BlZC1ieTogQWxsZW4gWWUgPGFsbGVuLnllQG1lZGlhdGVrLmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGxlbiBZZSA8YWxsZW4ueWVAbWVkaWF0ZWsuY29tPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT4NCj4g
PiAtLS0NCj4gPiB2NDoNCj4gPiAtIHJldmlzZSBjb21taXQgbWVzc2FnZQ0KPiA+IC0gdXNlIFBD
SSBpZCBhcyB0aGUgY29tcGF0aWJsZSBzdHJpbmcgdG8gcmVwbGFjZSAiY29ubmFjMi8zIg0KPiA+
IA0KPiA+IHY1OiBmaXggbWlzc2luZyBzdGFydGluZyBzcGFjZSBpbiBjb21tZW50KGNvbW1lbnRz
KQ0KPiA+IC0tLQ0KPiA+IMKgLi4uL2JpbmRpbmdzL25ldC93aXJlbGVzcy9tZWRpYXRlayxtdDc2
LnlhbWzCoCB8IDIxDQo+ID4gKysrKysrKysrKysrKysrKysrKw0KPiA+IMKgMSBmaWxlIGNoYW5n
ZWQsIDIxIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3dpcmVsZXNzL21lZGlhdGVrLG10NzYueWFt
bA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC93aXJlbGVzcy9t
ZWRpYXRlayxtdDc2LnlhbWwNCj4gPiBpbmRleCBhZTZiOTdjZGMuLjIwYjg2OGY3ZCAxMDA2NDQN
Cj4gPiAtLS0NCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvd2ly
ZWxlc3MvbWVkaWF0ZWssbXQ3Ni55YW1sDQo+ID4gKysrDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbmV0L3dpcmVsZXNzL21lZGlhdGVrLG10NzYueWFtbA0KPiA+IEBA
IC0yNyw2ICsyNywxMSBAQCBwcm9wZXJ0aWVzOg0KPiA+IMKgwqDCoMKgwqDCoCAtIG1lZGlhdGVr
LG10NzYyMi13bWFjDQo+ID4gwqDCoMKgwqDCoMKgIC0gbWVkaWF0ZWssbXQ3OTgxLXdtYWMNCj4g
PiDCoMKgwqDCoMKgwqAgLSBtZWRpYXRlayxtdDc5ODYtd21hYw0KPiA+ICvCoMKgwqDCoMKgIC0g
cGNpMTRjMyw3OTE1wqAgIyBtdDc5MTUNCj4gPiArwqDCoMKgwqDCoCAtIHBjaTE0YzMsNzkwNsKg
ICMgbXQ3OTE2DQo+ID4gK8KgwqDCoMKgwqAgLSBwY2kxNGMzLDc5OTDCoCAjIG10Nzk5Ng0KPiA+
ICvCoMKgwqDCoMKgIC0gcGNpMTRjMyw3OTkywqAgIyBtdDc5OTINCj4gPiArwqDCoMKgwqDCoCAt
IHBjaTE0YzMsNzk5M8KgICMgbXQ3OTkwDQo+IA0KPiBUaGVzZSBhcmUgdHdvIHNlcGFyYXRlIGNv
bW1pdHMgd2l0aCB0aGVpciBvd24gc2VwYXJhdGUgcmF0aW9uYWxlLg0KPiANCk9rLg0KDQo+ID4g
wqANCj4gPiDCoMKgIHJlZzoNCj4gPiDCoMKgwqDCoCBtaW5JdGVtczogMQ0KPiA+IEBAIC0yNTIs
NiArMjU3LDE0IEBAIHByb3BlcnRpZXM6DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZm9sbG93ZWQgYnkgMTAgcG93ZXIgbGltaXQgdmFsdWVzLiBUaGUg
b3JkZXINCj4gPiBvZiB0aGUNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBjaGFubmVsIHJlc291cmNlIHVuaXQgc2V0dGluZ3MgaXMgUlUyNiwNCj4gPiBS
VTUyLCBSVTEwNiwNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBSVTI0Mi9TVTIwLCBSVTQ4NC9TVTQwLCBSVTk5Ni9TVTgwIGFuZA0KPiA+IFJVMng5OTYv
U1UxNjAuDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAt
IEZvciBtdDc5ODEvbXQ3OTg2L210NzkxNS9tdDc5MTYNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIEJlYW1mb3JtaW5nIGVudHJpZXMgZm9yIEJX
MjB+QlcxNjAgYW5kDQo+ID4gT0ZETSBkbyBub3QNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW5jbHVkZSAxVDFzcy4NCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIFdoZW4gMVQxc3MgaXMg
bm90IHVzZWQsIGl0IHNob3VsZCBiZQ0KPiA+IGZpbGxlZCB3aXRoIDAuDQo+IA0KPiBTaG91bGRu
J3QgYmUgc2tpcHBlZCBpbiBzdWNoIGNhc2U/IFdoeSBmaWxsaW5nIHdpdGggMCBtYXR0ZXJzPw0K
PiANClRoaXMgbG9naWMgd2FzIGFscmVhZHkgcHJlc2VudCBpbiBkcml2ZXIuIFRoZSBkcml2ZXIg
ZGV0ZXJtaW5lcyB3aGV0aGVyDQp0byBza2lwIDFUMXNzIGJhc2VkIG9uIGl0cyB2YWx1ZSAoMCks
IHNvIG15IHVwZGF0ZSBpcyBmb2N1c2VkIG9uDQppbXByb3ZpbmcgdGhlIGRvY3VtZW50YXRpb24g
dG8gZ3VpZGUgdXNlcnMgb24gdGhlIGNvcnJlY3QgRFRTIGZvcm1hdC4NCg0KRm9yIGV4YW1wbGUs
IGluIHRoZSBwYXRocy1ydS1iZiBlbnRyaWVzOg0KPDEgMjAgMjIgMzggMzYgMjQgMzAgMjMgMjEg
MjggMjk+LA0KPDEgMjAgMzkgMzEgMjUgMjYgMjUgMjggMzAgMzkgMzk+LA0KPDEgMzcgMzQgMjYg
MjYgMjUgMjEgMzQgMjMgMzQgMjQ+LA0KPDEgMCAyMCAyMyAzMSAyMyAzMCAzOSAyOCAyOSAzNj4s
DQo8MSAwIDI3IDM0IDMzIDM0IDI5IDM4IDMzIDMzIDIyPiwNCjwxIDAgMzAgMjMgMzkgMjggMjEg
MjUgMjkgMjggMjE+LA0KPDEgMCAzNCAyMCAzOCAzMiAzNSAzMyAzNyAyNiAzNj47DQooVGhlIG9y
ZGVyIG9mIGFsbCBmaWVsZHMgaXMgcmVxdWlyZWQgYnkgdGhlIGZpcm13YXJlLikNCg0KVGhlIHZh
bHVlIGZvciAxVDFzcyBpcyBzZXQgdG8gMCB3aGVuIGl0IGlzIG5vdCB1c2VkLCBhbmQgdGhlIGRy
aXZlcg0Kd2lsbCBza2lwIGl0IGR1cmluZyBwYXJzaW5nLiBTbywgdXNlcnMgc2hvdWxkIGFsd2F5
cyBmaWxsIHRoZSBEVFMgd2l0aA0KYWxsIDEwIHZhbHVlcywgdXNpbmcgMCBmb3IgdW51c2VkIGVu
dHJpZXMuDQoNClRoaXMgZW5zdXJlcyB0aGF0IHRoZSBwYXJzaW5nIGxvZ2ljIHJlbWFpbnMgc2lt
cGxlIGFuZCB1bmlmb3JtLA0KYXZvaWRpbmcgcG90ZW50aWFsIGVycm9ycyBvciBtaXNhbGlnbm1l
bnQuDQoNCkZvciB0aGUgbmV3IGdlbmVyYXRpb24gbXQ3OTk2L210Nzk5Mi9tdDc5OTAsIHNraXBw
aW5nIGlzIG5vdCBuZWVkZWQNCmJlY2F1c2UgdGhlIDFUMXNzIHZhbHVlIGlzIGFsd2F5cyBub24t
emVyby4NCg0KSW4gc3VtbWFyeSwgdGhpcyBwYXRjaCBpcyBvbmx5IHRvIGRvY3VtZW50IHRoZSBi
ZWhhdmlvciBmcm9tIGVhcmxpZXINCmNvbW1pdHMgZm9yIG10NzkxNS9tdDc5ODYvbXQ3OTE2L210
Nzk4MS4NCg0KVGhlIHByZXZpb3VzIGNvbW1pdHRlciByZXF1ZXN0ZWQgdGhhdCB0aGlzIGJlaGF2
aW9yIGJlIGV4cGxhaW5lZCBpbiB0aGUNCmRvY3VtZW50YXRpb24sIHdoaWNoIGlzIHdoeSB0aGlz
IHBhdGNoIHdhcyBhZGRlZC4NCg0KUnlkZXINCg0K

