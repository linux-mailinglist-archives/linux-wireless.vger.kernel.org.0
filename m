Return-Path: <linux-wireless+bounces-4480-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 077DD875D6D
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Mar 2024 06:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840C71F22372
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Mar 2024 05:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E1E2C6AD;
	Fri,  8 Mar 2024 05:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bjMGmWnf";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="eqLvaBkc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79B02F26
	for <linux-wireless@vger.kernel.org>; Fri,  8 Mar 2024 05:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709874415; cv=fail; b=k0u3u/Ace2DfveanffDVvED5vn5FlgHGqXU97QrlnN9p9Ty+q14UFVS/A1B9jTgw1aRNjLr8nBFXw19xYOCIBpiWSnyBlnFiAarWXXyc5uzW7nR+Zzqvl+/uh4nLF1Jjm8VRftP1YD523t8OFMA0l0U7mS7QoHi2vD5igyyk884=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709874415; c=relaxed/simple;
	bh=WfkITTRrEQ09P1KwpXHxKAl/Kgp4GvRdYgCGBrwR7QU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ih13Lp1FImqCvFTI6+x3mbgZ55gZ/pYANoEza4Plz8Ph7XKrWcYeAHEyoubsQzww2NxsloyJPOBkuzwUIhwNwfPVB3WHcVg5yxirMck4viFrAJpZs04nNTVNBZIsfTfs9G772APACIUNVnDGJRG3MnKILS5oqmcGIewHRX71TuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bjMGmWnf; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=eqLvaBkc; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a94430cedd0911ee935d6952f98a51a9-20240308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=WfkITTRrEQ09P1KwpXHxKAl/Kgp4GvRdYgCGBrwR7QU=;
	b=bjMGmWnfXtVVYAx4gSZxDqK5mAvhWiWTmqdsmaxMsovaqndWpKl5o8OxY9DfoJ0CtWL8D+A6Fwmf24FN03XRWdG+HL52r6jhN2m1IaKxiYzz6/Ws46y+hUgDqsjMq2ZBbnkBXOW0IrvRN39Tx9A8zC3Rrp+SJoQelQh4CUXnxu4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:2c0ffa20-6bd7-41ae-a4bf-d55dbbcdd4a3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:c4584281-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a94430cedd0911ee935d6952f98a51a9-20240308
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1227475030; Fri, 08 Mar 2024 13:06:45 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 8 Mar 2024 13:06:44 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 8 Mar 2024 13:06:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQUprOl57YT21p0gNUkE4ieio073eUD9PZOlYf9Hf0l/gndAO251fmlak+C4/IE885Hghq18pSk4CYz9o1URPbMNJWUU3kI3lC8umA0IYo0CqK57OxqXsFTSwjINEC89sj5HNVfMTAENqGP8GhDOx6ezikCppl9ry62IuFT/XKdT1fFLxDyNQ4HC77BvdNRL0SRPc9Z0BBC4HRyrP2xOJpPGlt5eu7gDz+5Wo8Drbv7T3cdIPrnMK9ZHZtwh0On0j89rgaKGGkDdaEdfNhwcIR4iZPI2KlRpBuwCOa3U0hADSoPSHDZ0smxq2VlsGQp6wHgj5898FfORGb4IKQ6VTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfkITTRrEQ09P1KwpXHxKAl/Kgp4GvRdYgCGBrwR7QU=;
 b=BesQBYAxJHTUU7Fs6rPbuFYIQghp8RtG9hRkn+MS0yg1UE5+wtbpwgRPJTLV0EtXBl+552EPQDcXx2KihrQUVxScczR4SeRyz67KpFHmGPCHD4fJa1baBoQ/7B2N97N85C/5DnnBMiXgX3al6OtdDQBAPnoQZm+957KSMo+nhXi8RWxnMFTuIXDJurFQETt4mrDEx+xG71Fj3c1vJL6n4rrcK5d6++MN6NqsKkOg1wB9HyJtS6eo7JBbXPhAKiC8LXj+VDGoa6XY5DWNmWzSYfbdC/sqQ+mP1g/q+Yyc6xfchRpIO3uAUs5+40qpyHbJfByIlAiqasqNzc0JpKu0nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfkITTRrEQ09P1KwpXHxKAl/Kgp4GvRdYgCGBrwR7QU=;
 b=eqLvaBkcugj67JDyQbAUxCZ0277ZBbjJHFKRbdDRdMViD0ihz4Wzy+2wV9W8YJt5zM5QrbIxbe8ZX93NU7xpwz7qUY5361lBSpBFN3rqe+zBV4+HQsuMJae3fqCwpVaRqlM/OzExGfDay3hjuVP4zjnp8lZYtxD/6WAyPROm1Nc=
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com (2603:1096:4:ef::8) by
 JH0PR03MB7984.apcprd03.prod.outlook.com (2603:1096:990:2f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.38; Fri, 8 Mar 2024 05:06:42 +0000
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::cea4:9fee:cc06:34f4]) by SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::cea4:9fee:cc06:34f4%4]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 05:06:42 +0000
From: =?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
	<Mingyen.Hsieh@mediatek.com>
To: "lorenzo@kernel.org" <lorenzo@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?TGVvbiBZZW4gKOmhj+iJr+WEkik=?= <Leon.Yen@mediatek.com>,
	=?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>,
	=?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>,
	"nbd@nbd.name" <nbd@nbd.name>, =?utf-8?B?UXVhbiBaaG91ICjlkajlhagp?=
	<Quan.Zhou@mediatek.com>, Sean Wang <Sean.Wang@mediatek.com>,
	=?utf-8?B?S00gTGluICjmnpfmmIbmsJEp?= <km.lin@mediatek.com>,
	=?utf-8?B?U291bCBIdWFuZyAo6buD6Iez5pi2KQ==?= <Soul.Huang@mediatek.com>,
	=?utf-8?B?UG9zaCBTdW4gKOWtq+eRnuW7tyk=?= <posh.sun@mediatek.com>,
	=?utf-8?B?RXJpYy1TWSBDaGFuZyAo5by15pu45rqQKQ==?=
	<Eric-SY.Chang@mediatek.com>, =?utf-8?B?Q0ggWWVoICjokYnlv5fosaop?=
	<ch.yeh@mediatek.com>, =?utf-8?B?Um9iaW4gQ2hpdSAo6YKx5ZyL5r+xKQ==?=
	<robin.chiu@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: mt76: mt7925: ensure 4-byte alignment for suspend &
 wow command
Thread-Topic: [PATCH] wifi: mt76: mt7925: ensure 4-byte alignment for suspend
 & wow command
Thread-Index: AQHacH/G5A2WWyLqE0Ge06HD6iy+NrEsIRCAgAEqwIA=
Date: Fri, 8 Mar 2024 05:06:42 +0000
Message-ID: <54d4783d4aa93ba249c9b672de0356a1dd308794.camel@mediatek.com>
References: <20240307110815.527-1-mingyen.hsieh@mediatek.com>
	 <ZemiRaRNhNTn-XLb@lore-desk>
In-Reply-To: <ZemiRaRNhNTn-XLb@lore-desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5322:EE_|JH0PR03MB7984:EE_
x-ms-office365-filtering-correlation-id: ff216623-c404-46e7-e320-08dc3f2d8b67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BbVB9IiEvmdv8jPQOtIEEFXsIAHsQwGt3LRg0zGpQb2NlNSB8zbRDtm6kKWw+UhBchl7FhX4dCeOhOacJma4YnT5bkWaTsU6ivKKy2oNlZT5TJgD1zGuM2uU6NNAjwdoz4YHA1bJ7m6RvzyfrETrWIqd/0o2NL352iAk5e0OeYVb43S8TsHdpouRrWNnkq4J9mSvaQ4XpHhGrFa6gEZpA/bsItYz/1S7mzjAx97FSWxTlgLMPBjcSIBzveEjbLoXUMK8pONlU5JvSf9dUbj1JNj2NwaOtYRj1/WKAQG66WiAQoCfMd+8gG0HknebfkRxyzs6szoLfPJhs2NS1IUU/q0Zmxb3lmqK2R5xlnMVr1vH1DEbERO64JsdCMOJscCfpINo3N8yc18kCY9iLy3EbjEPqFMfMpWujV/+zT9/29hIJI/tsg4eXZ2a2GYCeNdYnZixbUUez5SqubVtd9NZ3DmmmDjiNwyW1sJRC/kgI1nHjf9SbYSntKtOFw7pv5dY/b3kXx3jFhOzI9K11VQz/6SVevYW/En7B1xdDGLKVwSMY8qPCFo7oHkO3GXOFBjWryYGrle8eubPIj9xtPbWbPJXz54hwP18w6Pit7nA+MUFMirGPT5uMBCvpAbihMGJ1v5KpLJY31UDl+oWPJ3Pnfc5N5pxlB17xW8h4bj1I1pky9j0e2Z60nDMYNOedrxTRxe352aULx2KDd34/iJpUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5322.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmxGK0xJbklSMUc5a0hzaFdWSUovZnJhc0NnWnpCV0haa1p0SmFoR0VhdEd4?=
 =?utf-8?B?cTd4RFJ6Z0JpdCt1UlF4ZWZIKzMyRFJiZU5nanVWWHRsTEFZcVVIRk9zbVdI?=
 =?utf-8?B?blpNbFdwQWZTV1o4ejJJeDdVTXBNWVdSY3lleHJabnNXY1lhNVBXbUZUUmN0?=
 =?utf-8?B?V096M0lBNWZiRDVENXUwZFI5MTFIbU0vU25RcnJCcmY1cTJXOWNjTHd0WWdF?=
 =?utf-8?B?UFgzWm5MZ3Y1UG50V1lrcDhJeE56dzdObXVXektXVGdPWTR0Ry9VdVB3c1Zz?=
 =?utf-8?B?OGh2T0hueENrby9OYXFjS0puc0ZYRHFEc2hSbmxNMHMweUNrK0RWUVNBTHQ1?=
 =?utf-8?B?bmlaUGp0UFBkUWpkdVNidjFESkQ1a1VpeTE0ZGM4WlRwMDUvYjd6YXNxTTJ4?=
 =?utf-8?B?YUpFZjE1Uit4NDJoL3REVmJxZzhoWXRES2xEdHBIQm5DTUZYTjJ5QVpHUkEy?=
 =?utf-8?B?dDNSRTJBdkhNMFRTeE9zbVNSR3lER1ZtVm5PYmlsRElVTXZBWWFoejExaWdV?=
 =?utf-8?B?eHhkQU9OZHJiWkwvZ081amk2eGpURUlkTkJCQUMxalp0ek83bGErOXEyMThG?=
 =?utf-8?B?MlVWZnVzUDJrRUJWd2lDcmdEY1FBU1BuMVBYSUtsSjBSUHJJb2MrVjlkTDRV?=
 =?utf-8?B?UU5LSHV4Q3FLTU13RFhOMCtkdGM3MkpjRVBySnpaUFdhYzRsNG55aGJqb3FB?=
 =?utf-8?B?UzA4dXpIeUl5QjFaU1MwWDdOdG9neERUNFJMNGZPSm1pbGxSUnhtSFNtdERG?=
 =?utf-8?B?SnRQWUVudG5BdEVuSFQxQUp1VVI0Z1FOTHNWNENveHkvb2tybjYxUHBCQ0l4?=
 =?utf-8?B?WGg5RVR5dHM4M09rNnZ6Njg2U0Q1V1BJeERVMFlGbC96NnR5ZDBybjBvcmE2?=
 =?utf-8?B?eUx0Mmh1RDZPL0l3MStEcHhFa2pocUU0QUgwVmZDd1dkZ1ZaWFVpK2gvZDE3?=
 =?utf-8?B?T1hVbnh4VHVLK2RFSjBvYXU3Vms1eld0Snk1Y1ZLejh2c1Raei9jZDQyM0Y4?=
 =?utf-8?B?eTVWaWt6WklCSXZXOTVwOUhtdlB4SnFMSGJaWVRUcE9ZenlzRE9Td0tRQkVz?=
 =?utf-8?B?NkFjclFCTG5qSlpiQXhqU0ozL29hdUZvTHJVQUVYL3hBcmxvSnlsSzhvdzNK?=
 =?utf-8?B?cVJ5QjQ5TG5TZnJJTC8wd01WSmRqNmdoQThkbGVaNW5jdEgvR1JZdVQ0UENa?=
 =?utf-8?B?Qmc4UytrNDJYeFVzUnAxclA0b2dDbmUrR1RpZHNPaThmeGwzZkloVXJQZGtq?=
 =?utf-8?B?ejZuTjRUZXJaWkJwS1YzWVBlNWxjcFpRQkwzWHp1QkJxUk1PTTlzYlNaVEcx?=
 =?utf-8?B?TnBjaHI0bnp3andQY20wZkJSMGVnOWFGS2x0VmtlcXFPZ0lmanZhb0xQWEZk?=
 =?utf-8?B?R3pTdmt1TVBQQVQ5OTExMkUyV25pV3BCeE40ejdscEVlb0x3MjJ3ZHU2a1B0?=
 =?utf-8?B?bmh1R1FvUFZocS9QeUZ2WjhlQ21wYmRVNFhFTE1ZbHBWS3BISllLUnA4UHFi?=
 =?utf-8?B?a2ZXT3pvUzZ1RTJSMjh5U29oM1RkQ1FRb0RJQzUzU2pjQjcxVkxJWlpMd2lo?=
 =?utf-8?B?UVRYb0ZIa3l0bExNbkxYQis2QUwyanBwNFBFU2VML21vTC90VXZid3VVQkRN?=
 =?utf-8?B?YnBBR29HV3RoTU1mUFJINFQrMk1seHYzRjNIV3dxeEt6MEhKNzNDdFFSUDdv?=
 =?utf-8?B?UngxaGZuc1ZTYmpVTWdoakVVMTVkcE03RzBNTHE1dGg1OUpubC83NlpHZ0dm?=
 =?utf-8?B?U2MrSUNHdTlISis1bWw0bGwzSUtJcmF2dmtnelZJZmFUaUpOOUhhdlZSSnE5?=
 =?utf-8?B?ZWRCb0FLckc2ZXltVW1xM1F2NmZRVFBjLzdGdHJCRnplV3d5bmhUQk53aWVE?=
 =?utf-8?B?NFNhTFRqZUZzSEgzbzY0QzltVDNrQ1V2T0JlYWVDY3kwNEJFbzBBTjRkQkZ4?=
 =?utf-8?B?TEhZcUxSYkFqcGdPRnp0QmhvMXBXa1BTbldmSkFFZzFxMVdKeWZzK0VpNnc3?=
 =?utf-8?B?cE1FbTQvSnVKbE4wM0s4eHVEbSs3SXBWbXlFc3l6YjRyQkZqL3lEajVFK0c3?=
 =?utf-8?B?WXEwbzNJeWJwTVdxTEFCamYwRHZzcEtQRE5hMWRTVG5EWjl6TnRMY0NBK0cv?=
 =?utf-8?B?a2NFWjRGUWdzNDA3YUdmWHo1MXpFNGIvOENPRUxRZDdvV2hlQ1dWQVJYZHIy?=
 =?utf-8?B?TUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D41B7DC77FA514EA49F2ADC2B7FD92A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5322.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff216623-c404-46e7-e320-08dc3f2d8b67
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 05:06:42.4222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sps4S79mdjPJilYTmT2noEmF/e3lpG6bRZo4qyMsgjfGrgPRNnGcrww8nkmPB5K4Rq6xGrFuVZ+jX0h8l9eWbbNRDarXbXwqaCqALg5TNyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7984

T24gVGh1LCAyMDI0LTAzLTA3IGF0IDEyOjE3ICswMTAwLCBMb3JlbnpvIEJpYW5jb25pIHdyb3Rl
Og0KPiA+IEZyb206IE1pbmcgWWVuIEhzaWVoIDxtaW5neWVuLmhzaWVoQG1lZGlhdGVrLmNvbT4N
Cj4gPiANCj4gPiBCZWZvcmUgc2VuZGluZyBzdXNwZW5kICYgd293IGNvbW1hbmQgdG8gRlcsIGl0
cyBsZW5ndGggc2hvdWxkIGJlDQo+ID4gNC1ieXRlcyBhbGlnbmQuDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogTWluZyBZZW4gSHNpZWggPG1pbmd5ZW4uaHNpZWhAbWVkaWF0ZWsuY29tPg0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzZfY29ubmFj
X21jdS5jIHwgMSArDQo+ID4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3
OTI1L21jdS5oICAgICAgfCAyICstDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL21lZGlhdGVrL210NzYvbXQ3Nl9jb25uYWNfbWN1LmMNCj4gPiBiL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3Nl9jb25uYWNfbWN1LmMNCj4gPiBpbmRleCBhZjBj
MmIyYWFjYjAuLmVmMjlkMDkzZjljMyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9tZWRpYXRlay9tdDc2L210NzZfY29ubmFjX21jdS5jDQo+ID4gKysrIGIvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2X2Nvbm5hY19tY3UuYw0KPiA+IEBAIC0yNTI3
LDYgKzI1MjcsNyBAQCBpbnQgbXQ3Nl9jb25uYWNfbWN1X3NldF9oaWZfc3VzcGVuZChzdHJ1Y3QN
Cj4gPiBtdDc2X2RldiAqZGV2LCBib29sIHN1c3BlbmQpDQo+ID4gIAkJCV9fbGUxNiB0YWc7DQo+
ID4gIAkJCV9fbGUxNiBsZW47DQo+ID4gIAkJCXU4IHN1c3BlbmQ7DQo+ID4gKwkJCXU4IHBhZFs3
XTsNCj4gDQo+IG10NzZfY29ubmFjX21jdV9zZXRfaGlmX3N1c3BlbmQoKSBpcyB1c2VkIGV2ZW4g
Ynkgb3RoZXIgZHJ2IChlLmcuDQo+IG10NzYxNSkuIElzDQo+IHRoaXMgY2hhbmdlIGJhY2t3YXJk
IGNvbXBhdGlibGU/DQo+IA0KPiBSZWdhcmRzLA0KPiBMb3JlbnpvDQo+IA0KDQpIaSBMb3Jlbnpv
LA0KDQpZZXMsIGl0IGlzIGJhY2t3YXJkIGNvbXBhdGlibGUuDQoNCkJlc3QgUmVnYXJkcywNClll
bi4NCg0KPiA+ICAJCX0gX19wYWNrZWQgaGlmX3N1c3BlbmQ7DQo+ID4gIAl9IHJlcSA9IHsNCj4g
PiAgCQkuaGlmX3N1c3BlbmQgPSB7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL21lZGlhdGVrL210NzYvbXQ3OTI1L21jdS5oDQo+ID4gYi9kcml2ZXJzL25ldC93aXJlbGVz
cy9tZWRpYXRlay9tdDc2L210NzkyNS9tY3UuaA0KPiA+IGluZGV4IDJhMGJiZmU3YmZhNS4uYjgz
MTVhODlmNGE5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVr
L210NzYvbXQ3OTI1L21jdS5oDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0
ZWsvbXQ3Ni9tdDc5MjUvbWN1LmgNCj4gPiBAQCAtNTM1LDcgKzUzNSw3IEBAIHN0cnVjdCBtdDc5
MjVfd293X3BhdHRlcm5fdGx2IHsNCj4gPiAgCXU4IG9mZnNldDsNCj4gPiAgCXU4IG1hc2tbTVQ3
Nl9DT05OQUNfV09XX01BU0tfTUFYX0xFTl07DQo+ID4gIAl1OCBwYXR0ZXJuW01UNzZfQ09OTkFD
X1dPV19QQVRURU5fTUFYX0xFTl07DQo+ID4gLQl1OCByc3ZbNF07DQo+ID4gKwl1OCByc3ZbN107
DQo+ID4gIH0gX19wYWNrZWQ7DQo+ID4gIA0KPiA+ICBzdGF0aWMgaW5saW5lIGVudW0gY29ubmFj
M19tY3VfY2lwaGVyX3R5cGUNCj4gPiAtLSANCj4gPiAyLjE4LjANCj4gPiANCg0K

