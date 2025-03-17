Return-Path: <linux-wireless+bounces-20414-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C088EA63B33
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 03:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034BB16B9E0
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 02:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31430149E17;
	Mon, 17 Mar 2025 02:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Vq8jDGY7";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="BtGpoDyc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC49949620;
	Mon, 17 Mar 2025 02:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742177552; cv=fail; b=eyeFbAZZ7Nz1imMLmsoa6Y3LrnSJ9z5Bvm53xaDE0XTctbBrkdX8yaWtRpCppeJf2Dg92PjxP6qI3BSyDUW+3rBCoYVxhXZGJa9feuyhoipFC3D+va8MeN97xTHglo4faBfpW1IKTAZ3fdnFDS+upvetHeKqXjQdsbb8zzQYBJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742177552; c=relaxed/simple;
	bh=YoknerF1pZfJoyVNcwFxM0UUr8AUMxXpv42STHcsgdo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Io46olDb1cIEfG0Ga5t5nHjrPvFNCGh3RPmhbAbexdYIP9x9inX2TmqHu7urmZ8/miVx86XPrqAb3mOAtKYTXQ8O+JEvE3d/nA1U1A6NOPHRyRx6hsNQYF/8YSLOOKcS6zSckb6VURa4q8/ZUNmDHQIgkNAnpMDiMX5UWvjzddE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Vq8jDGY7; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=BtGpoDyc; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4121a42002d511f0aae1fd9735fae912-20250317
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=YoknerF1pZfJoyVNcwFxM0UUr8AUMxXpv42STHcsgdo=;
	b=Vq8jDGY7Z7/Hsp6PnBnU2gUvNA+d+7XJr10DHTZz4fpmAoQXTBPiQv8i3hbMfhWnuCmo/5RGCqj1nHHMAJqFhyp+T6wvbn9Qhiu09M1yTL1sjx5QvF7scbunCb2gUDLihH1RH8EU/U5qZuGS0J6qJYZXKtVZbEPKcgxoGFNV8c8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:3e24f42d-9e6f-4765-a16f-17f5d5d0a7d6,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:0ef645f,CLOUDID:07fd2e4a-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102,TC:nil,Content:0|50,EDM
	:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: 4121a42002d511f0aae1fd9735fae912-20250317
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 762831368; Mon, 17 Mar 2025 10:12:19 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 17 Mar 2025 10:12:18 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 17 Mar 2025 10:12:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqnXsLCMQMxSjWcFqskcBTFTJeQSzQU07nfWJENql7WQRBfrLaVnXmAA5psgLB/YUPpL8xtkjFvPJnBgQhdkKihuxQHQ4nUBFwGw9p1FoP61QnCutGJd4qTDcoxKWKAgZ4RFZuleRGmiVsMuDxwdv1yBv5VUDDnmEpo0wdIQKXvOs1ajWE4e0HzoN+/a4jCQSoXhX3fAX+jncWODwl2kOJ/xCkYlwswCBQwNzZ6Gsa77qC8qzuxRwD0NuaxY2ISycuP++GarcRCOUnm4F/e6GJQheUWSA+sHGWteM1RhCluxsBKedA26IEw1y1RqcQ/I/O295e/hNf9cmTJFk1XfrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoknerF1pZfJoyVNcwFxM0UUr8AUMxXpv42STHcsgdo=;
 b=BhgEGz/GCOL33o8QgNv/tRiEoVVtXRtFJdT9t/2W+HAOh2Sf+/kFEiFYU2i7w5DKGvHuVjt6wi6T9Q5uq1A53j8QjnqZZxrADjL44CB4l2lO6dn9ja2P5Nf+Fie8+XJd84a/gG7fTrad0nKA3pwhRzux3fMo9v+rWUq0r7rLC7CT888r2qDlElOlrRli+tkwKs2w+hlxT5VQVHlZ+EP4fCirbvA9NaIPWaKr3b95CFjeFZVg03pdc8ChpqJLn6SF3O00auxJmn3o70nss6KzT77RxrFOr9jkM/0cMN4rZbdYhBIQc7PCwqbnxddZK6xoEuWyfFHxdDN30UxB1I2hGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoknerF1pZfJoyVNcwFxM0UUr8AUMxXpv42STHcsgdo=;
 b=BtGpoDyc3TAjdZscezgrv7Qu/MbBmNC3+O0dATTmgwF8dshGDDYFfWWwQmvmnr6Iive+neKEKjlw6xuuuECF8TGeZAqZYFenTm8M0lNPJ/yRU1hEgz3kdVHoaUZ2mLyieN2nsO4zpAUPGyCvxFWje3EABlBcS1quooyaxphzN5Y=
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com (2603:1096:4:ef::8) by
 SEYPR03MB7413.apcprd03.prod.outlook.com (2603:1096:101:140::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Mon, 17 Mar 2025 02:12:15 +0000
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741]) by SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741%7]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 02:12:15 +0000
From: =?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
	<Mingyen.Hsieh@mediatek.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"MasterPrenium@gmail.com" <MasterPrenium@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>,
	=?utf-8?B?QWxsYW4gV2FuZyAo546L5a625YGJKQ==?= <Allan.Wang@mediatek.com>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: FW: Wireless speed regression issue with >6.12.12/6.13.x +
 firmware update for mediatek MT7925
Thread-Topic: FW: Wireless speed regression issue with >6.12.12/6.13.x +
 firmware update for mediatek MT7925
Thread-Index: AQHblqQadGui0SAXfUel1Gkp/pMv6rN2hWjwgAARTwA=
Date: Mon, 17 Mar 2025 02:12:15 +0000
Message-ID: <5a07aea2090532682c8cd4df3ab1b9026f2e1cd5.camel@mediatek.com>
References: <CACr2tqu10_mXiXw-Q3VSqYBJhQU1s_m77_uhvjpe0j3H3jhbgA@mail.gmail.com>
	 <TYZPR03MB61644B8F34946A73E2C16E27F4DF2@TYZPR03MB6164.apcprd03.prod.outlook.com>
In-Reply-To: <TYZPR03MB61644B8F34946A73E2C16E27F4DF2@TYZPR03MB6164.apcprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5322:EE_|SEYPR03MB7413:EE_
x-ms-office365-filtering-correlation-id: df8d3c0e-a053-49e0-5663-08dd64f922e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MDNuSXNaZUROdGdPbUNsR1VmNEsrd2czSGNwWnppTXU1YVg3K21TNnFXdURv?=
 =?utf-8?B?NkFrZStNRVl6S21KQTB3eGk4QlBTZGVaRGEvdklLRlVEKzdWazV4SDlwK0hS?=
 =?utf-8?B?STNKcFFPR1R4TlhRY3krVFVINExmdlF6Y1dpZnA4R29ENm5ORHNDd2lpakd6?=
 =?utf-8?B?SzJtN3BqTTAwbWhxcUxkZ3JYY2dtRXQ2dWM2ZTZEN2FXczRQc2V6MVNYTDBu?=
 =?utf-8?B?TGo4TXh0eGswNFpSRURZU3VPSm1aLzNBZTBKK1Z3WXdBcnlSZFZJWlBVNlhT?=
 =?utf-8?B?c2lMc0E0ZEtyUGNKeXRnUjI4NHJSNHlzRVdZLzBrQnFLLzdVTkNBN2QwSUx5?=
 =?utf-8?B?VFprOSsyS3p2Q3lrZk1IQjllVE5pQ3NTZXpmZDVNbURjYVlvRHdlNGRoc01V?=
 =?utf-8?B?TitxaStVdDNNa1lFazY3aVVrZ1JRVm9idHc0VVErbXBUVGdkU2o5NHVZUnNP?=
 =?utf-8?B?eDlodHRhK29Ua0JTN3pucGZjRmdUbG0zWWNOVm5pSDNxclU5S09SeVVFYVFD?=
 =?utf-8?B?dDBQV2tNNGRGV2JTZHVnMWgwQXl0enNRK3NpVmVjeUl6anpkYVNDM0Y2RDht?=
 =?utf-8?B?eEdVbUJhZk5wN0FPbkNTT2ZTaEViclRrSzRvblczN3BJeERxL0VtWlhWYytm?=
 =?utf-8?B?MzBrTjNQUFA1TjZUTStQOHVkTlk1M2lZeUZHWkZ1WjFYUnljR1R6eWVBayth?=
 =?utf-8?B?RVRSK3VOSmV5RWU1UW9pay9FOEVHYk9tN1RTVVRzSEM0YzRPeWFBL1UyL0U2?=
 =?utf-8?B?aTYybWhnSFpwc0RIa1hkbTArMG95Y3F0UlNxMU0xeDMvU3daN3VIYm9iOUxL?=
 =?utf-8?B?bnRLWVBwN2J5cm96SzZHaC9xd3Q2eEhkaHpuVHQzbys5NVh5MzZmbkZSWkYx?=
 =?utf-8?B?Z3l1eENHZGNPcHBKZ1VtK2ZsMGZLb2FIVFc3L3VmQk5CSktIb2NQWS9Xdjlt?=
 =?utf-8?B?bGZka1ZOMmo4MUNnN1d0YkJuZGptVEhUZ2JqZFd3ZHptTjFuTTIycVl3Y1Rv?=
 =?utf-8?B?Rm5DZ1QzWi9PdjNrMUZoTHhtUFk3R1JldTFCcXFyd2V4VVMxVzFTTGV2L09r?=
 =?utf-8?B?eVhkZFM2Q0E5bERaOGFIZTdFWllHQzIxR21sYmU5YjU0WXNaYlRCT2F4VXhy?=
 =?utf-8?B?TVpOazEvcVBXZnh3a2Ixd3RZMHhUbDcvZDdZVzlyemJhSDJ3c0xMZUxweUxC?=
 =?utf-8?B?SnhGYU5qZTBFNUlaOFFlakY3U1JwUmxHd09ncUttbGlWUmdoLzZvUHdjMEQ2?=
 =?utf-8?B?NXFpdHZVK3RTeVh1OC8zSFk4bFRmcDZUT2NTOGJnemdQb3B4cG1yS2NFNFNu?=
 =?utf-8?B?YVVmSmk3U0k4R0w3QUo4cjFDdEExeEl4WUFqaXR4SXA1ZUdpWDhYaWFEd2J5?=
 =?utf-8?B?dklCQVpmQllkTFUxRmhCS2czZnlFQjhlZ0RVWll0eGxhUUJha1dzaFlza1c4?=
 =?utf-8?B?T3VocHFENEZpVUdDQ0k2UVpaTnEwbDBVUytPZG5BdnVpZnNKVHFDSTF1czMv?=
 =?utf-8?B?RGxYUC96QlVnM01UcURFME1KTWFLMFpPcHRzdXNYK2hRc1pjS1RSNWZ2QXlp?=
 =?utf-8?B?YmxIekc4QzNERVJPcW93QjJRc2NLRlN3alZjQ0M5TGVhRkwzeXZhUjVYU3Vy?=
 =?utf-8?B?YWUxbjViaThkbnRaUENZL0ZoSDh3d0lVRktDN1NvYWd3d01ZWG12Uk45Sk54?=
 =?utf-8?B?cFhEWG9CNWpJRjJPa28rWDhWRWhLc05SRFhURjU1bVBldDNRR0thWHNzREd1?=
 =?utf-8?B?NTRlbWQ5TFBNQXJNSnNxcnIrZXNjSVE5NTlzbEE2a2tsTm1iUGF4VUtydnlR?=
 =?utf-8?B?djllTVlvakVrUTRjakRPVzdneDdCQzJLNHdtd0JDeENsSkNYSkZFam5YN1lx?=
 =?utf-8?B?d1ZFZmRmVmx3TXRvV2xodVVwZEV3dFEwckV0MnJ3TDVTS2JNYktvckErZEs1?=
 =?utf-8?Q?QWJpSLDuVq+n+LMlm+FcEoEcShflDznV?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5322.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WU5mK2VyMUc4M2ZsTy9UM05yS2xCU1VudDk3MENJSDJMSFlrK2NTVmpMb3Jr?=
 =?utf-8?B?WmIxdit6ZVhRb3ZRbmRiZWpVQ09MQlRjR0YySU9VK25wMkVSc3lySEFSS0JV?=
 =?utf-8?B?dEtOTlJPbUgwc2pkUEdjZFczVXgrQVpQdWJ0VnZoeW8wSEdyczYxYXVPQUxu?=
 =?utf-8?B?akRqMGZyQUxrYVc1YW5qcDg1Z2NIZ0Y1OUphZzcrWVVoMWpjRk1vaEhTeXQr?=
 =?utf-8?B?NkZiOStWZlZFVkl1cmdpZC9LY1MvejRwUTl3OGlqd1VUVkg2VmpDZTB5NkhG?=
 =?utf-8?B?SEltamVEZGRhSWpzcmFxSkQ4WjZMSklvTHNLUG9CdUQ3ZExTR0x3NkxhVmNv?=
 =?utf-8?B?SVo0djc3aXV1YkFjVUFLdGs2WEVqSXIrWTJqZHg0UXdZdGRJYXNJVGRaYlA4?=
 =?utf-8?B?MHM3V2NndXJ2S3hHR0tSSTRYTEN2WS9LNjY0cm1QUXBaeDFQNEJHeW1rZWdX?=
 =?utf-8?B?YlJZWEJZRHpmbUhUREdNKzZkTElqNU5iMVJOK0hUaTN6VnBlcU1pUWh2MEVl?=
 =?utf-8?B?dFg2QzZDallFWTNsQUhjeXpPMHpZd2g4STU4MFBRRVNFVEtUbjVEaFRyczVS?=
 =?utf-8?B?K3hXMUJscTFLTnZrZi9iVUZkcjJaNUJ1ZDJKbEc2SGpwL2lQajVXbE02K3NT?=
 =?utf-8?B?SmtLYlI4WXF4bEcrL01NMmF6Qkc1QVNubW84K1FjKzR4RXJBQVZDSXNxaWJM?=
 =?utf-8?B?UncxOU9xalRvaFFrZTIyUndmSysydWc0czI0aHZLOVpNK0hhQWpxejlPSXZC?=
 =?utf-8?B?a0s2aTg5N3VKbFhCd1pQQjZXY0krbGpyaXBFYlk4WkVzNU5DakF4OHlyY2J6?=
 =?utf-8?B?THN0VlhoTkhaZFl6YkYraTI0anJmVVA2ZkR5WnpXZjBDZ1FsS1lTMkhPUzZR?=
 =?utf-8?B?NzJGNmpYSGNtSkJkNVZGTTl0NXZRWlVsNnh1QW1uK0g1M3l4eXdlWjlVSDZs?=
 =?utf-8?B?WnhRdUkxUzNJM3VpTmFlKzdBYUEza2pzeU04Y1EycXJYb2JDTnV0NzdoUFg5?=
 =?utf-8?B?TDBhcDFJR01IWFd5UXVnakZYdDMwMHVZZERzbmxaNU1VbkdsaEljVGR3U2Iz?=
 =?utf-8?B?TEdCME40TUlHelYvdEZGNWNZTGpKVXRoV1E1TzdDNzlvYTNNNXBWRE8zdTFP?=
 =?utf-8?B?ZlNjTERSVThFRWJPeDBoVEVyYnhudlV4ampJUVJJeWM3VGtKcGhIdmswQ1dZ?=
 =?utf-8?B?TS9ZenBGSWhsU0FPdHhpNUVsRXhsUk04QVIwZlkybFpmbm9nZG9DY0RqTnow?=
 =?utf-8?B?UmZiRTExNkRRcUFHbFJyalRmNktmdUNwdGdhd2xQS2gwaTl3LzFoY1FxRkpM?=
 =?utf-8?B?ZFMvYUZVTFNCU0lLa0p0T01DTW8wVXhXTFJyTk4wK3dxTzdGZUluWjYrTCtE?=
 =?utf-8?B?WDllWk1WWmFUMG03NjUzSjRQaU1VKzVVWjJyOXIrS0Q1K1ZHQVFCdWNGZzVh?=
 =?utf-8?B?M1ljbGlYTVNTYmdRWDdLVE1Kd1RWbHFNeDlUamFEejlDa043MC9YSnpkZmNs?=
 =?utf-8?B?d3ZMWDkxbVBROG5IcHY1dS82RjU5ZklWWHRzcDgrU2ZZL3FTWFBURW5uUVht?=
 =?utf-8?B?K1ZpalNXUlNzNFdlM09MR0RyRGM4akhyOExsWTRQYzdZWUtycW5mdVJEYkZ3?=
 =?utf-8?B?UGJ1MlRBMjE3MXh4STA3ZmltbXlyUGF3cWxNcXI5Qkl5UjR1Q2FwRHZnajl3?=
 =?utf-8?B?L2VMQzFZZXJxL3NBaTN3eTh0NUtLNHpFbGgycFB6VWhqMElTUktrUis5eFlS?=
 =?utf-8?B?MWxieDlacnhoOWlXZzBoTFJCcDRVcGhjTjlHYk0rNlMvT2lWandGK21VbCtG?=
 =?utf-8?B?YWFiTHpLb0VKeHc1cjhmcEtyczBna0RIeDFGNkpxVHRwbVJhR0QzRlRoUmNy?=
 =?utf-8?B?U3VhcXFHNUNYTG82M1JWZWZQU2lZWEplbFJWYVEycXRocEpyM3JISWJTRDFw?=
 =?utf-8?B?a09qbTRQNDIxY2ZhMEV0bUszWGxEbzFTSThKTjFjOHExY0xpbFdKVW9pazR6?=
 =?utf-8?B?eU1YL3YvdlVmR1EzR1FrbFBXQW1hbU00d0tDdndDMFdTRUJQZVpVZVVoaFVP?=
 =?utf-8?B?MVd3cm1vVzladm91b3NXNTFNaGY2dGZONklPQW1sZFlXVTdMTkZHa0kxTlhK?=
 =?utf-8?B?MXRBSVpydThEZFNsMW96bC96MVFablJscGpYanVORitESkJRZUQ4dGVnSVFR?=
 =?utf-8?B?TUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16E1A84AECC38F4CB1A0AD52F7FCB609@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5322.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df8d3c0e-a053-49e0-5663-08dd64f922e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 02:12:15.0761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ga0Z8KCS0K659JF9v6wRKctfmApmvTqiXD2gtLVDkcfeQZXZ/RxbUAUA2DO5trgHmuJvSkqh4aQK50ef+EAUIe7K4DQr9WYvs8wbt+g6BEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7413

SGksDQoNClRoYW5rcyBmb3IgcmVwb3J0aW5nIHRoaXMgaXNzdWUuIFdlIHdpbGwgY29uZHVjdCB0
ZXN0aW5nIGFnYWluLg0KDQpBbmQgaXQgaXMgYWxyZWFkeSBrbm93biB0aGF0IHRoZSBwYXRjaCBh
ZGRlZCBpbiA2LjEyLjEzIGRvZXMgaGF2ZSBzb21lDQppc3N1ZXMsIGJ1dCB3ZSBoYXZlIGFsc28g
c3VibWl0dGVkIG5ldyBwYXRjaGVzIHRvIGZpeC4NCg0KQ3VycmVudGx5LCB0aGVzZSBwYXRjaGVz
IGFyZSBpbiB0aGUgbWFpbnRhaW5lcuKAmXMgdHJlZS4gSXQgc2hvdWxkIHNvb24NCmJlIGluY2x1
ZGVkIGluIDYuMTQgYW5kIHRoZW4gcG9ydGVkIEJhY2sgdG8gNi4xMi54IGFuZCA2LjEzLnguDQoN
ClBlcmhhcHMgeW91IGNhbiB0ZXN0IHRoZSBkcml2ZXIgZnJvbSBoZXJlOg0KaHR0cHM6Ly9naXRo
dWIuY29tL25iZDE2OC93aXJlbGVzcyBhbmQgYXBwbHkgdGhpcyBwYXRjaDoNCmh0dHBzOi8vcGF0
Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC13aXJlbGVzcy9wYXRjaC8yMDI1MDMxNzAx
MTcyNC4zMzI2OTc5LTEtbWluZ3llbi5oc2llaEBtZWRpYXRlay5jb20vDQoNClRoYW5rcw0KDQpC
ZXN0IFJlZ2FyZHMsDQpZZW4uDQoNCg==

