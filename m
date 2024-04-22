Return-Path: <linux-wireless+bounces-6638-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8108AC43C
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 08:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C712D2815E8
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 06:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7331E1F61C;
	Mon, 22 Apr 2024 06:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mOzRkqAv";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="g029AfOX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949061391
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 06:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713767545; cv=fail; b=m5xAp9GQgv3iiNE/m3StSS0QHFCse+vRDvgXOoCoCQ4V0IKfPs5Nng1vhZ/lakUzJzQ5cnQeNTY9qGKm+IOoIbdpgi8gjyFOVwUnNbjV4dFwjXlTAShCx3SaLoBrqK7/zlFPoRpz3XRA9sDf6CslZk8nu3qMxsMaOkEG2Dd0UVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713767545; c=relaxed/simple;
	bh=tvIluYkFaNjDIK4gc3zmFZvuqpn3I0SR0MxRh5d1U74=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X7D/kFja29ncodn/ty8bAj6eFrM0WNFYAQY9oaTp57/6+20r+CLtax38r8EMYetlNbdwzZkvrdVUwitGRKYxy6gYDN3I+rWWxzA/kV3HZd5UtIWbGSwq/M1QGOoghIBP1vdPmHKzeqSlnh2JyTNLVqaOQsZoBHg6p7qLYBHZrzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=mOzRkqAv; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=g029AfOX; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0f37d1e8007211ef935d6952f98a51a9-20240422
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=tvIluYkFaNjDIK4gc3zmFZvuqpn3I0SR0MxRh5d1U74=;
	b=mOzRkqAv07bkQvbh0sWyUWj+XxwYoKojTSmVAtYfWQ/0MeqBwgwMr4VFu6RH6qjLIxfKA7tNcly3/eMyASiVprlL1aSOziLw3OGq1nLXnvkwp72Y8r3agMIs1wnizGSatPsw6sqba5eemIOBI0ej0OqK8sQTEgYYP5uDZ2RoO6U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:6ab5929e-7c75-44eb-8210-96895dc86e6a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:ca4d31fb-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0f37d1e8007211ef935d6952f98a51a9-20240422
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1708572553; Mon, 22 Apr 2024 14:32:15 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 21 Apr 2024 23:32:14 -0700
Received: from SINPR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 22 Apr 2024 14:32:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPH+mEjimbGb396B3STMODMzyEtuSsjA6ZjxreyJyyy96YqDbfVrzSNCjZ1F9mltqqdtE0Hic4f4Bh5jL1mNcUzEgeoQAnSYBH2PoALFCRoGFle3BOQhSc3BKg+vI3+pHjNr4ZFK+HlkmL0IJe1I4cLrnA7W6LU2HLJ5rs2OucIJJ8zCZWB4OeER/XQbMj/T1Dn9m+jQ3WhV39Pf2EO9OjvwbYbCR/Vp5m7Hycb5SQo3PdraOra+R2K4IDiKROodAUzo9h55EW04xAkkBhPzq3cfpvP+F8jkPNntXq0ezOMrZ5WqHm0T59k+lL3zOuwTjGvgokKb+lUz29Dz94tUbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvIluYkFaNjDIK4gc3zmFZvuqpn3I0SR0MxRh5d1U74=;
 b=Fa0+biwx0/1QUGYPV7qu5luaX1ETgxsWTE40+ZqtYOZWqb7YDOfUQezOW6Oj7hWI3Dk7E1hU1YwwUwv8rA5F1o35yjhACGHZWqL/Al53k5/eFNstPqGVKMsZXlAMVs9z26OfXaNoEAiRtMq44syPc3YOoL3+qPUoqgBe1IoS3l2URZzur1QkwRcdsZTntna30n4ZkXsZrrj3Jw0LxkthYF6rhOJs7vEnUkXyDt+cZ0mDRKyfPp8ooZryTWautz/WIdte93A0n9WAIlaYzupz66h8vAp36Tq0KuBQ1ZE5f3nmRf47VfYkwmktFdWjENugwjBErHi2M/hA36U0PX4GQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvIluYkFaNjDIK4gc3zmFZvuqpn3I0SR0MxRh5d1U74=;
 b=g029AfOXcOpqHJirnO/eCZ37+3NV6gpIzl9E4hsZFu/Frl8TI+4MJBhCA4/0PRQ2EfpBd0SGgZ8bCZ63hrh9tOaSuw0JbnFN7jlN3jT1MTDqiJaYI0whdM8PPk7zPMwz7Ow22qRpHMc07QkJaFVmAjnJ2D1om3cl+vP1XYuNMrk=
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com (2603:1096:4:ef::8) by
 TYSPR03MB7739.apcprd03.prod.outlook.com (2603:1096:400:42e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Mon, 22 Apr 2024 06:32:11 +0000
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::cea4:9fee:cc06:34f4]) by SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::cea4:9fee:cc06:34f4%4]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 06:32:11 +0000
From: =?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
	<Mingyen.Hsieh@mediatek.com>
To: "nbd@nbd.name" <nbd@nbd.name>, "nico.escande@gmail.com"
	<nico.escande@gmail.com>, "lorenzo@kernel.org" <lorenzo@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?TGVvbiBZZW4gKOmhj+iJr+WEkik=?= <Leon.Yen@mediatek.com>,
	=?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>,
	=?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>,
	=?utf-8?B?UXVhbiBaaG91ICjlkajlhagp?= <Quan.Zhou@mediatek.com>,
	=?utf-8?B?S00gTGluICjmnpfmmIbmsJEp?= <km.lin@mediatek.com>, Sean Wang
	<Sean.Wang@mediatek.com>, =?utf-8?B?U291bCBIdWFuZyAo6buD6Iez5pi2KQ==?=
	<Soul.Huang@mediatek.com>, =?utf-8?B?UG9zaCBTdW4gKOWtq+eRnuW7tyk=?=
	<posh.sun@mediatek.com>, =?utf-8?B?RXJpYy1TWSBDaGFuZyAo5by15pu45rqQKQ==?=
	<Eric-SY.Chang@mediatek.com>, =?utf-8?B?Q0ggWWVoICjokYnlv5fosaop?=
	<ch.yeh@mediatek.com>, =?utf-8?B?Um9iaW4gQ2hpdSAo6YKx5ZyL5r+xKQ==?=
	<robin.chiu@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: mt76: mt7921: avoid undesired changes of the preset
 regulatory domain
Thread-Topic: [PATCH] wifi: mt76: mt7921: avoid undesired changes of the
 preset regulatory domain
Thread-Index: AQHajLb8HqlgPkc/cUSZ/xmt6p185LFkXfYAgAR7JgCAAExJAIAKvsgA
Date: Mon, 22 Apr 2024 06:32:11 +0000
Message-ID: <98f3d7bcbf235c70190f28ec6371244c047b6df3.camel@mediatek.com>
References: <20240412085357.13756-1-mingyen.hsieh@mediatek.com>
	 <D0I1D2J8EB1L.2DPV9W79YKN2C@gmail.com>
	 <3e2eb7ab155cbc4819096e32b914d220166a9adb.camel@mediatek.com>
	 <D0KMHQSFOY0B.3P66MD08H96FZ@gmail.com>
In-Reply-To: <D0KMHQSFOY0B.3P66MD08H96FZ@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5322:EE_|TYSPR03MB7739:EE_
x-ms-office365-filtering-correlation-id: 58d632af-c6a5-4add-abd8-08dc6295f0f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?MlNGbEh1ZVlVVkk4d2RUUWJjTFppalB6bDg2YkVZOHNWTDhyM1BWdWkvNXc1?=
 =?utf-8?B?NmdmOThjMUI3QmVDa1NnaVJ6U05hbldjdjk2aWlqamRIdmZ5Y2oybEpuRDBL?=
 =?utf-8?B?M3l5cEZDay9Yejc0bFhHVE5OK0dRQUx4Z2hzV0JNTHByQkRaTHZ2UWZ1MllN?=
 =?utf-8?B?SEhPZWVCUzQ1QUpTZ0dKWDJLYUdIK0tBVmNicmJqV1g5R1d0bFM3bGorRUw2?=
 =?utf-8?B?MW1rZ0VRQ3M5OEd4QjhUMElmcTdoZ29ORFdNdHF4SkJaMHVYS0p2VTdocEFC?=
 =?utf-8?B?eTBncW9EeFdxTUNpTWIwYXlaYTVJQjczVE1ZNE5FSElHWlg3RVNqVnN5UU04?=
 =?utf-8?B?U3MwaHI3SkVIT2MwKzl3cHdHNUNpS3psdnRrQlRYY1NhNDlEN2UyQ0RjbG0x?=
 =?utf-8?B?TU1TNCtRV0ROWWVET3hzZnMvQzZFWlltd0NreUlodE1KM0V6QnBIV1p5bnVU?=
 =?utf-8?B?V3pJKzlrdVhCZGZrR0F1VVFRbGYvczJPT0tsTGpFZE92RWRHMHNiYVgza2I1?=
 =?utf-8?B?YXYyckFlc0lRR1Y2RWNYeEhpakpxTFdhM1JUQ0FhTWpYNnVvN2NoM2FHL0po?=
 =?utf-8?B?dklSZUlkcHpqSDhidUNlWm5JSjFGM3h6V0IwSm1lSGdSYzI1aVlSYkhiMG1r?=
 =?utf-8?B?T2diRXNIZElYV0NWOWFyRThqZnE2ZUZxWERIM0Rhc2RaTjdHMWdaRHVMTUxm?=
 =?utf-8?B?bmM2dG1pVitUS0dKd2w0SFJxZmxwdlQ1RVZIeVJwVVY0ODQ1Y3BmL2tpWTUz?=
 =?utf-8?B?NVVCa0dTb05qSVpSOGswZ3RZRDh1RG51WTVpTmxrcUEyWWFPcURmRHJaeFBy?=
 =?utf-8?B?elpISjBydXVJRlVzT3A2aUtSaFZYYS9XQ1loci94ZWdMYmdReTB0NE1EZFFJ?=
 =?utf-8?B?VENxajN0V05USENhS0pmRnhURmRKa2lXT0hqSzIwb3BGZXpqREhYVXUxVzZm?=
 =?utf-8?B?U2k2b3U5dUlRRUFUUUlTM0ZVVkdmV3ZLY08wKzkvMHMxb3JRbjYwU3J2bjR0?=
 =?utf-8?B?NU1OSXVQN1I2eGt2RE93aENWY2k3UU1vVHRZNlIzSnJDanNWaXZ2NzVudzlI?=
 =?utf-8?B?cklLK2Qva2NSWnVRTGEvWnJ2WFFvWUZIMjFmQVZCVUxzUmZYYmNGeXUvVS9s?=
 =?utf-8?B?cVVGRHhqRTBSMEtyT2dnZDhpaUEwSDRzbXhTTVFzSW5uL1R0a3RlcC9aMnNL?=
 =?utf-8?B?Lzh6Ujk1cXFEbklPRC9Ma0xMZG5zYjR3eWNmb0xrSUdCSWpzUFMwY1dBVVRM?=
 =?utf-8?B?YVdvbGFoZ29oT0E3dXFSdjZHcS9FbmNGOFlndHEwdUxWZWRQYVg3cmk0OVB0?=
 =?utf-8?B?OTY3OUlHK1RWSkhqWWYwRElKK3NhS2tuaytFRzJUaWs1ZURReWtxWEJPZURv?=
 =?utf-8?B?ZzFuc2FtenZCQ211QnQrQnNESFI4QlpsSDhHejdIZkF0ZTFlcUE0dzQ0TUll?=
 =?utf-8?B?bmdXVVFPUnlkeTE1MFRqcWx5eGMrMWxrQ3VkOUhyNVBJcjFjRitrVnZvTk1x?=
 =?utf-8?B?NW10dVoyS3M2c2JpTnhaWGNyLzRtL1p3MSt6a1luV2cwNXpwT3RLdnZnUVNZ?=
 =?utf-8?B?c1Vrdkl5cm1GTlRjVzZWU3pmNzhDalRTanhuRE5qOTVDajBSOVNCVnhGZFRj?=
 =?utf-8?B?UWkxL2NNUWI1THBzNDRka1kzdUdZTjNHQzNlNnFsbHYxRUlJZzdiaDFJbWwv?=
 =?utf-8?B?aVFFT29jWEdFSkRWNi80ZlJSVFBDK3UzNG14SEp4N1ZWSGhqRHduNjE5M0Mw?=
 =?utf-8?B?RG5CbUZzRllYdGtON2k4V0NRS0J1TFFyV21SVUdwS041dmxsdUtRcjlGL3U2?=
 =?utf-8?B?WUkrU29xb1F0U1J3b1B0QT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5322.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1JuV1E1RlpodmxqenJWZXNyb3k0a0F5WmxFTElxUWg1MGRUN2V4akZtTmFx?=
 =?utf-8?B?RDJtclV4Ylo4cGhXYmduV3dhVDhKQ2xqQTlyQWtBT3JCL3JYR2F6b215Q2xo?=
 =?utf-8?B?MStNaHFIUlpNSk43ai9kZXlSaDdVVGNzZUEyb0dXWFZQVjcwZmpodHFTUnkx?=
 =?utf-8?B?ZENIeWxuMDdhMG12TisxWlpHVkYya2tPVjQrY3FqNk16UFZwVUpGR2I5bGNh?=
 =?utf-8?B?M3QzUWFjL1h6V0l3VkhxUWtveHh6S2s3WUIyVEJwYTlsbHhncVNFSHAwdmt0?=
 =?utf-8?B?S2dlWkNFOXJvTW96MDJIRGdYMnd5ajYxL3RsbTVvUElrQ0V4ZTZCWUlUbC9I?=
 =?utf-8?B?Z0V1cjVHYkZnbXFDdEh2U0gxQURSSCtzMGVSb21DRXJJUERNNUZxMm5NZTVF?=
 =?utf-8?B?bHRkSm9vcWlPZll5WHBPV1U4TWVyTS9iRVQvakcxQUtRai9TOUxpdktQTXY3?=
 =?utf-8?B?ZGpTS3ovblA2WGM4dTNLZExqODhPR3llQWx3Q2dLUlhXeDVmVTR3bUNIeTFj?=
 =?utf-8?B?SmZqYm1EeEVyOTliaHIrc3UyU0tLbmlQbGNyendKMWdKendyQkwyYi85Tmtk?=
 =?utf-8?B?Y2UrSnMrTDNZWTc0eVpKbU1pZ3RhZHhNNjFmY3JJT2ZKMENwZUFxQ2FCaTIv?=
 =?utf-8?B?allWTXo1WGs4Tm1yZ0VqRDB0cHdtMnFNd1I0WFJXY2xvL0ZuWFBQN2ZDOTZn?=
 =?utf-8?B?RXhvSExmeW5CZXg0TTJjb29BSExycElmLzh4RS9CQjREL3pLMm9CajdZTjVy?=
 =?utf-8?B?bW5XMzhZUldvTDhJaXZKcjd0QTE1ZStPQzcrdXdUcTZzR1FvRjdMVFpiKzlK?=
 =?utf-8?B?V01IbnYxNE0wK2ltREpRNWs0QkZqd2tsMmp5aThiTVBDNkRyTmhGTWo4UXJ1?=
 =?utf-8?B?WHA4SCtVKzFmV0lUVFJJaENwT3FzTVB2bjYxaUYvR1dJUGdBdVp3T1BmaHNX?=
 =?utf-8?B?R29SME5KQndmUEhrbEVNUjhTdTBWbklKck02RjNIOGw1N0NUcG5CNi9RUGY2?=
 =?utf-8?B?RHFDZGFGd1RXOGI2c0lBTUZnRUlQM3FpWS9nb0h6ckxrVlR2YXVrMHhxOUlL?=
 =?utf-8?B?ays3TU43NjY0Q2o4UERrT0RFMlczaFVpTFpkaXoyQXRBWC96SXlxQlFCUnFh?=
 =?utf-8?B?ODRMMWtsTGM5SUdmd2YrM3pUUkt4bjJ5UkxzRWk0bkIrMTJUWG00SW1hRkRs?=
 =?utf-8?B?bDQzTHQ1SnFIaTN3ZmMrWDhPU1d5cWVaRDVxL3NSWlpaZjhyalh6Wi84THZB?=
 =?utf-8?B?Uzd0OFNMYStVV1hzVk9VVDBRVEtVaTA3bXhxc2dOUGE2UWsrNkJBWURUVjFF?=
 =?utf-8?B?WUV2RHkyTDNWSnJnQnVRV0Z3MEQzWXk4ekxNMVpDTU9Dcy9UVkpvRGtPbXBJ?=
 =?utf-8?B?OTYvT3BNdVVWREdkK1lwNDVJRWNpTTZPT0ZHbDZNUFdVYkRXRlRLa2hNdzl0?=
 =?utf-8?B?ak5sc09OWERUTmkySlFwMjVXUXYrZmxQblU1d3p5TUFBRVRMcitMWVI5WUJp?=
 =?utf-8?B?bzM0ZHgzUXZMbnlWQmorTFp0NFBTOVZmWUNNUGpZMVkySDhRWGxNbWdDdVdN?=
 =?utf-8?B?a3RiR0NYU3hkdzRiU2FmUitNd2JOb1VBa052S1pIVURRMDJ1K0FsOXQ1anZm?=
 =?utf-8?B?dWpxN1czZFR1VVEyRWhLakNjaHcxeFJ5bUlOUDZwQlYyL2d0dEQvY3hlaUVP?=
 =?utf-8?B?a3Q3S3I3dHJaRGErK2hqV0VML1p3S09aZm41Q3hMSnM2N1FqQWhNUGNhd3Ni?=
 =?utf-8?B?anJQNFU3OXpsUXNOMTkvNS9LTFpYb1crZzRRRU8xSmtYVTRhWDlqeUNQSEY2?=
 =?utf-8?B?eFJJNkhGL0pVL3F0Y1VQT2tyYW1waGtGRFVoVnZlRUU1NmpPZzFEbFgxbXR5?=
 =?utf-8?B?Zm5Lc0JSUmpaQ29FbGdOdGJVQlVxUm5iNGpDUDZJb0tGNDZwVGVmb0VFTG1W?=
 =?utf-8?B?aDdjamlJQjNGM01qT0hWelJPYUV3dVRLbktKV05rUklCVllxdWJjMU50Zm42?=
 =?utf-8?B?TVZ2bjZaQ0xHb1daTkx4cUI2TDIreElOeTlHOGNWQmJpY0Y5Y3dpSmthS2xN?=
 =?utf-8?B?emovWDE0Tmh6dERYMW9wQ3NIdXN3TDdHNlZXZHhFbGhMNkF2WW1TZ0hIallk?=
 =?utf-8?B?YVc5WFUvZVVSWExkTGRzRlg1cFUra1pva0M0SjBRYVlGSVNyTVArRGVyVUVy?=
 =?utf-8?B?UkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C18D24450F656749BE04880BC5A900E9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5322.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d632af-c6a5-4add-abd8-08dc6295f0f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 06:32:11.1604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k7rb0gQPUuNP3ibEVFgz0fosO6mFuK9SE/s/juJuyEcYYhCvfsQPxl6XcuuNb52BAFve1J/Cgj3uyd/0QHb1Q5vSd7gNK4k1g2lOpFO2oMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7739

T24gTW9uLCAyMDI0LTA0LTE1IGF0IDEyOjI2ICswMjAwLCBOaWNvbGFzIEVzY2FuZGUgd3JvdGU6
DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Ig
b3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9y
IHRoZSBjb250ZW50Lg0KPiAgT24gTW9uIEFwciAxNSwgMjAyNCBhdCA3OjUzIEFNIENFU1QsIE1p
bmd5ZW4gSHNpZWggKOisneaYjuiruikgd3JvdGU6DQo+ID4gT24gRnJpLCAyMDI0LTA0LTEyIGF0
IDExOjI3ICswMjAwLCBOaWNvbGFzIEVzY2FuZGUgd3JvdGU6DQo+ID4gPiAgIA0KPiA+ID4gRXh0
ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVu
dHMNCj4gdW50aWwNCj4gPiA+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNv
bnRlbnQuDQo+ID4gPiAgT24gRnJpIEFwciAxMiwgMjAyNCBhdCAxMDo1MyBBTSBDRVNULCBNaW5n
eWVuIEhzaWVoIHdyb3RlOg0KPiA+ID4gPiBGcm9tOiBMZW9uIFllbiA8bGVvbi55ZW5AbWVkaWF0
ZWsuY29tPg0KPiA+ID4gPg0KPiA+ID4gPiBTb21lIGNvdW50cmllcyBoYXZlIHN0cmljdCBSRiBy
ZXN0cmljdGlvbnMgd2hlcmUgY2hhbmdpbmcgdGhlDQo+ID4gPiByZWd1bGF0b3J5DQo+ID4gPiA+
IGRvbWFpbiBkeW5hbWljYWxseSBiYXNlZCBvbiB0aGUgY29ubmVjdGVkIEFQIGlzIG5vdCBhY2Nl
cHRhYmxlLg0KPiA+ID4gPiBUaGlzIHBhdGNoIGRpc2FibGVzIEJlYWNvbiBjb3VudHJ5IElFIGhp
bnRpbmcgd2hlbiBhIHZhbGlkDQo+IGNvdW50cnkNCj4gPiA+IGNvZGUNCj4gPiA+ID4gaXMgc2V0
IGZyb20gdXNlcnNsYW5kIChlLmcuLCBieSBzeXN0ZW0gdXNpbmcgaXcgb3IgQ1JEQSkuDQo+ID4g
PiANCj4gPiA+IEkgYWx3YXlzIGhhZCB0cm91YmxlIGZ1bGx5IHVuZGVyc3RhbmRpbmcgdGhlIHJl
Z3VsYXRpb24gYnV0IGlzbid0DQo+IHRoZQ0KPiA+ID4gY291bnRyeQ0KPiA+ID4gY29kZSBJRSBz
b2xlIHB1cnBvc2UgdG8gYWRhcHQgdGhlIHJlZ3VsYXRvcnkgb2YgdGhlIGNsaWVudCA/IA0KPiA+
ID4gDQo+ID4gSGkgTmljb2xhcywNCj4gPg0KPiA+IFllcywgaXQgaXMuIEhvd2V2ZXIsIGlmIHRo
ZSB1c2VycyBoYXZlIHNldCB0aGUgc3BlY2lmaWMgY291bnRyeQ0KPiBjb2RlDQo+ID4gYmFzZWQg
b24gdGhlaXIgcmVnaW9uIHRvIHRoZSBkcml2ZXIsIHRoZXkgZG8gbm90IGV4cGVjdCB0aGUgY291
bnRyeQ0KPiA+IHNldHRpbmcgdG8gYmUgY2hhbmdlZCBieSB0aGUgY291bnRyeSBjb2RlIElFIGFz
IHRoZSBBUCBjYW5ub3QgYmUNCj4gPiBlbnRpcmVseSB0cnVzdGVkLg0KPiANCj4gSGksDQo+IA0K
PiBJbiBBUCBtb2RlLCBJIHVuZGVyc3RhbmQgdGhhdCB0aGUgaGFyZHdhcmUvZmlybXdhcmUgKGFu
ZCBzbyB1c2VyIG1vZGUNCj4gdG8gc29tZQ0KPiBleHRlbmQpIGlzIHRoZSBzb3VyY2Ugb2YgdHJ1
dGggYWJvdXQgd2hpY2ggY291bnRyeS9tYXJrZXQgdGhlIHByb2R1Y3QNCj4gaGFzIHBhc3NlZA0K
PiBjZXJ0aWZpY2F0aW9uIGFuZCB3aGF0IG5vdC4gVGh1cyB0aGUgY291bnRyeSBjb2RlIG9mIGFu
IEFQIHNob3VsZCBiZQ0KPiB0cnVzdGVkLg0KPiBJZiB5b3UgcHV0IGFuIEFQIGZyb20gYW5vdGhl
ciBtYXJrZXQgYXQgc29tZSBwbGFjZSwgeW91IGFyZQ0KPiByZXNwb25zaWJsZSBmb3IgdGhhdA0K
PiANCj4gQnV0IGluIFNUQSBtb2RlIHRoZSBlbmQgdXNlciBzaG91bGQgbm90IG5lZWQgdG8ga25v
dyB3aGljaCByZWd1bGF0aW9uDQo+IGZvbGxvdywNCj4gcmlnaHQgPyBUaGUgQVAncyBDb3VudHJ5
IGNvZGUgSUUgaXMgd2hlcmUgdGhlIHN0YSBnZXRzIHRoZSBmaW5hbA0KPiBpbmZvLiBTbyBubywN
Cj4gdGhlIEFQIHNob3VsZCBiZSB0cnVzdGVkLCBhbmQgdGhlIHVzZXIgc2hvdWxkIG5vdCAoYW5k
IG5vdCB0aGUgb3RoZXINCj4gd2F5IGFyb3VuZCkNCj4gDQo+IE9mIGNvdXJzZSwgSSBhbSBubyBh
biBleHBlcnQgb24gdGhpcy4gSSBqdXN0IHdhbnQgdG8gY2hlY2sgaWYgdGhlcmUNCj4gd2FzIHNv
bWUNCj4gdGhvdWdoIGJlaGluZCB0aGlzIGNoYW5nZS4gWW91IGd1eXMgbWFrZSBXaWZpIGNoaXBz
LCB5b3Uga25vdyB3aGF0DQo+IHlvdSBhcmUgZG9pbmcNCj4gDQo+IFRoYW5rcw0KDQpIaSwNCg0K
U29ycnkgZm9yIGxhdGUgcmVzcG9uc2UuIEZpcnN0bHksIHRoZSAidXNlcnMiIGZvciBkcml2ZXIg
ZG9lc24ndCBtZWFuDQplbmQgdXNlcnMgaGVyZTsgaW5zdGVhZCwgaXQgbWVhbnMgdGhlIGZyZWFt
ZXdvcmsgb2YgYSBMaW51eCBiYXNlZA0Kb3BlcmF0aW9uIHN5c3RlbSB0aGF0IHNldCB0aGUgY291
bnRyeSBjb2RlIHZpYSBubDgwMjExLiBTb21lIGRldmljZXMNCnNoaXBwZWQgd2l0aCBhIHByZXNl
dCBjb3VudHJ5IGNvZGUgc2V0dGluZyBhbmQgc2V0IGl0IHRvIHRoZSBkcml2ZXINCmR1cmluZyBi
b290IGJ5IHVzaW5nIGl3IG9yIENSREEsIGFzIG1lbnRpb25lZCBpbiB0aGUgY29tbWl0IG1lc3Nh
Z2UuDQpUaGVzZSBkZXZpY2VzIG1heSBnZXQgbG9jYWwgUkYgY2VydGlmaWNhdGVkIG9ubHkgd2l0
aCB0aGVpciBwcmVzZXQNCmNvdW50cnkgc2V0dGluZywgc28gbWFudWZhY3R1cmVycyBkbyBub3Qg
YW50aWNpcGF0ZSBhbnkgY2hhbmdlcyB0byB0aGUNCmNvdW50cnkgc2V0dGluZy4NCg0KU2Vjb25k
bHksIHNvbWUgQVBzIHdpdGggaW5jb3JyZWN0IGNvdW50cnkgc2V0dGluZ3MgbWF5IGJlIHBsYWNl
ZCBpbiBhDQpwdWJsaWMgYXJlYSBlaXRoZXIgYWNjaWRlbnRhbGx5IG9yIGludGVudGlvbmFsbHku
IFRoZSBkZXZpY2VzIGNvbm5lY3RlZA0KdG8gdGhvc2UgQVBzIGNvdWxkIHBvdGVudGlhbGx5IHZp
b2xhdGUgdGhlIGxvY2FsIFJGIHJ1bGVzIGlmIGJlYWNvbg0KY291bnRyeSBJRSBoaW50aW5nIGlz
IG5vdCBkaXNhYmxlZCBpbiB0aGlzIHNpdHVhdGlvbi4NCg0KVGhpcyBwYXRjaCB0cmllcyB0byBz
b2x2ZSB0aGUgaXNzdWUgZGVzY3JpYmVkIGFib3ZlIGJ5IGRpc2FibGluZyBiZWFjb24NCmNvdW50
cnkgSUUgaGludGluZyBvbiBkZXZpY2VzIGNvbWluZyB3aXRoIHByZXNldCBjb3VudHJ5IHNldHRp
bmdzLiBPZg0KY291cnNlLCB0aGUgY291bnRyeSBJRSBoaW50aW5nIHJlbWFpbnMgZW5hYmxlZCBv
biBkZXZpY2VzIGxhY2tpbmcNCnByZXNldCBjb3VudHJ5IGNvZGUgc2V0dGluZ3MgdG8gYWRhcHQg
dGhlIHJlZ3VsYXRvcnkgZG9tYWluIGluZm9ybWF0aW9uDQpiYXNlZCBvbiB0aGUgY29ubmVjdGVk
IEFQLg0KDQpUaGFua3MNCg0KPiA+DQo+ID4gQmVzdCBSZWdhcmRzLA0KPiA+IFllbi4NCj4gPg0K
PiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMZW9uIFllbiA8bGVvbi55ZW5AbWVkaWF0
ZWsuY29tPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNaW5nIFllbiBIc2llaCA8bWluZ3llbi5o
c2llaEBtZWRpYXRlay5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MjEvaW5pdC5jIHwgNyArKysrKysrDQo+ID4gPiA+ICAx
IGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkyMS9pbml0LmMNCj4g
PiA+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MjEvaW5pdC5jDQo+
ID4gPiA+IGluZGV4IGVmMGM3MjFkMjZlMy4uM2M5YTVmY2Q2OTI0IDEwMDY0NA0KPiA+ID4gPiAt
LS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkyMS9pbml0LmMNCj4g
PiA+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MjEvaW5p
dC5jDQo+ID4gPiA+IEBAIC0xMzUsNiArMTM1LDEzIEBAIG10NzkyMV9yZWdkX25vdGlmaWVyKHN0
cnVjdCB3aXBoeSAqd2lwaHksDQo+ID4gPiA+ICBkZXYtPm10NzYucmVnaW9uID0gcmVxdWVzdC0+
ZGZzX3JlZ2lvbjsNCj4gPiA+ID4gIGRldi0+Y291bnRyeV9pZV9lbnYgPSByZXF1ZXN0LT5jb3Vu
dHJ5X2llX2VudjsNCj4gPiA+ID4gIA0KPiA+ID4gPiAraWYgKHJlcXVlc3QtPmluaXRpYXRvciA9
PSBOTDgwMjExX1JFR0RPTV9TRVRfQllfVVNFUikgew0KPiA+ID4gPiAraWYgKGRldi0+bXQ3Ni5h
bHBoYTJbMF0gPT0gJzAnICYmIGRldi0+bXQ3Ni5hbHBoYTJbMV0gPT0gJzAnKQ0KPiA+ID4gPiAr
d2lwaHktPnJlZ3VsYXRvcnlfZmxhZ3MgJj0gflJFR1VMQVRPUllfQ09VTlRSWV9JRV9JR05PUkU7
DQo+ID4gPiA+ICtlbHNlDQo+ID4gPiA+ICt3aXBoeS0+cmVndWxhdG9yeV9mbGFncyB8PSBSRUdV
TEFUT1JZX0NPVU5UUllfSUVfSUdOT1JFOw0KPiA+ID4gPiArfQ0KPiA+ID4gPiArDQo+ID4gPiA+
ICBpZiAocG0tPnN1c3BlbmRlZCkNCj4gPiA+ID4gIHJldHVybjsNCj4gPiA+ID4gIA0KPiA+ID4g
DQo+IA0KDQo=

