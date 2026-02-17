Return-Path: <linux-wireless+bounces-31948-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SINgLspmlGkpDgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31948-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 14:02:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E7214C468
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 14:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EACFF301075B
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 13:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A7F3570BA;
	Tue, 17 Feb 2026 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="c6VUsssP";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="C006bWWK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A383596F9;
	Tue, 17 Feb 2026 13:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771333209; cv=fail; b=YdmMMcRuBd8jV/g8jbPCpmmTOb5klDPVLkd7joJQ1OqgASCICWXgp/SMUw8RvB7HG8U6Qac+VTWW9VQfN2v9x+tqke/IoYo2k4nRVI8XQxm979HYAsmzsJyzib00+JwKaOW5V8rhwDmyytWVRGe1eIhvKz7BCLNMDHdrjAT32FY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771333209; c=relaxed/simple;
	bh=hs511tjrMnnqrdialnawStA45e3Hx1TON66B+z70Luw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gNlQcuGHT/0VUxRCKLAzxPbPhTpB8jOk4hAPBXqdr3QlezhqyIMtDOAA0J36fvq1Ru8ORJnJnMZQgCa9Akyxt8FHPYOwNGAnCR+Rkc7hoBb/bM7JJlOAg7xYYKPY+bfIoWnsKB50sOxSaxh41sbKgbz7zaQhKR3hk9ESFvrQw7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=c6VUsssP; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=C006bWWK; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8e19280e0c0011f185319dbc3099e8fb-20260217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=hs511tjrMnnqrdialnawStA45e3Hx1TON66B+z70Luw=;
	b=c6VUsssP1BOsLgdqJj8w0CI5wQ5InGy1Fl0gB6Oa9aYKddA/RM33KQyE1Kz1EcyD+DDSbE2Ens1pzdvZk74nuY5+7ddJIdYdmUNsZCIrI3i9XFM/TW7WpmppJiVOwLBB0nFQJFg6aPJ9wnADen/+PCGg7ThIRoGewKsbBKkSehk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:cdfed77f-6095-44f5-b0bb-7170d1534347,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:f0975b5b-a957-4259-bcca-d3af718d7034,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8e19280e0c0011f185319dbc3099e8fb-20260217
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1275934960; Tue, 17 Feb 2026 20:59:54 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 17 Feb 2026 20:59:53 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 17 Feb 2026 20:59:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0TDNf9rujquUCG+vVhfHEwvbGoWgoAzlTQrBTUqIXwdMviOx8ryudiWGFy+bAsJKpTZc0LM7D0eMoPT+gQ5uiwaIBxDaZaDIShZ73PUuKa12MfKY/JqGZppFMVmTJeSYGlB39+ouPf8fNolMUZLkrkhuwTCfMID2vXN0oTU8JpJ1GKLX4KWkJdXIMo7UHUHvePRbu3Z/3EZqBKSD1+EwZ236QeE+sfesgc0Q3A/b6d23341unac5PmPXdz7RhB8oLffJy6ncXQcF0K669Mq7X7QJfRyyNB59TtLmZDyPYsC/K2UR85I+OEHT9WcSRNpnxsBhd2JyAivguUxiOC8Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hs511tjrMnnqrdialnawStA45e3Hx1TON66B+z70Luw=;
 b=kjsWQPzi+p5jM7xZKyri9Bb/LUyrb+BSmqarxd0Ln07X3xe9m6dTrex7AF5NjdTLj2gpT1szoceIvBJb00BkbOv9HFliKVn0GlUNIlghmTASYvNhbelY8A96DtCYAxTcNnxi9vhXfNf5BJkflaslgvxJq0BEApdYOUgTaFDeUiHkx8Vm/8PhHPdTsgFv9uOCpV6gcU4NWAK53dDRRnCWStE5MpEhw4Msy+H9nLxEPHG2Jji2P/Xz0KIsCkD3cFh0seCAUBlnRlE+Fh/9Ryx6nRGB45i6BABGuJ/RqTzmDSzk0HbSE2/WupcSueJXITNRwMzd29/AbkHJlh9Lm5hYYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hs511tjrMnnqrdialnawStA45e3Hx1TON66B+z70Luw=;
 b=C006bWWK0+rTT9LC0DMtFjFB942bVGN9m8FdOOwJt5od2CqBBsdjzzXGbJQesOjuYFESRmdS4wcFYkQ88AddRrTDYhClNffmPK9L2Er66EVbJ3RVhy98Ltqg8QYSi4FQxDVykq/9Or+o8QRKgKYJLuqyiQHys210MDZVvLw4Eog=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by KL1PR03MB7577.apcprd03.prod.outlook.com (2603:1096:820:e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 12:59:51 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059%3]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 12:59:50 +0000
From: Ryder Lee <Ryder.Lee@mediatek.com>
To: "krzk@kernel.org" <krzk@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "nbd@nbd.name" <nbd@nbd.name>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v7 2/3] dt-bindings: net: wireless: mt76: add more PCI
 devices
Thread-Topic: [PATCH v7 2/3] dt-bindings: net: wireless: mt76: add more PCI
 devices
Thread-Index: AQHcn12I01YO6hJ3A0+IUnDLc+LCmrWGhPoAgABW5AA=
Date: Tue, 17 Feb 2026 12:59:50 +0000
Message-ID: <23f43fb875ca41a945caceba5c9fcf05331afd58.camel@mediatek.com>
References: <8fa8ec500b3d4de7b1966c6887f1dfbe5c46a54c.1771205424.git.ryder.lee@mediatek.com>
	 <5022737c82052132702004ab0fdc073f5cf6df69.1771205424.git.ryder.lee@mediatek.com>
	 <20260217-lavender-dove-from-tartarus-fca40c@quoll>
In-Reply-To: <20260217-lavender-dove-from-tartarus-fca40c@quoll>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|KL1PR03MB7577:EE_
x-ms-office365-filtering-correlation-id: 6b578a75-93fb-46b6-584d-08de6e246fd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?N1owM0ZCMnYrWE5kc2ovSEw3bG8yZ0FUbWExWGJYb29CK2pUZndzSVZrdWZq?=
 =?utf-8?B?aXlTR2RPRVlNQzI0TDNiYkxaUklOZWZXMUlQYTNXa0FQL01Ed1JCMkY0YWta?=
 =?utf-8?B?dGdZdTUvZEl5bzVGUC9Zbk9BYlo4Y2U1VXp6S2MyTnJ5L0FXRHBRS0psU1lI?=
 =?utf-8?B?eHh3V21sWlNEK0hwSTYySGVVN1prT3hERnVQOUZ4bFcvV3Q5OGFtaU1MdEdO?=
 =?utf-8?B?eHdFaXBpbjVhYS85aVFEVUt0cHJpQjYzZEs4MGxNWnZmcjR3dGRlTno2Kzlh?=
 =?utf-8?B?V3U4Sk9ZYnJFQVlLUzBSaldVNi9vTVJDUUd1MEF3M2hCemh3eURpT1Vva0Rx?=
 =?utf-8?B?K3l6U1ZwemxWSTdPY2J2WHpqUWNPaGlmSTNaSVdFMjVQaVlqRVBSQk55MnpI?=
 =?utf-8?B?emhMU1VFN3BFNmpVSmc0aGZmcVlOcmJWQnREME1oN2dnRnNSYzluWWJ1aEFH?=
 =?utf-8?B?WHRIZWJHV0FuTmJyQ1d1YUR4YmNrdFA1ZEF4dVN3Ym51VWlaUWc1QWRWWkRn?=
 =?utf-8?B?ZmtGNWJNOTFGMCtMMUo3NkovdlVlclcrQkhyWU5KRTlTak5MelQwZ0IrZExS?=
 =?utf-8?B?dnlCVlJZbi95VFhUSWdJVFlKOE5NWlZXMytRVWtBNEY0NEFzQi9kaFVhYUp0?=
 =?utf-8?B?aG13YktTcXdOK203T3pQZEJKVTRXVGRITVk4SDhRcUlFU1JxOEFBVWd3Zmlp?=
 =?utf-8?B?THhzSElhckxocVRQdzIrbUEvU0xBRHI1WlhrY1hWZXFVWDR3ZU5sdW5uMHdC?=
 =?utf-8?B?U1dRTjM0RXpuR2FQbUJZOGVwTDZpWW8wRFFyM1ljOWxXclRPdEJyNC9XTGho?=
 =?utf-8?B?SzdFUmxKRUZtR2ZHa3dnbVk4TGZzeHNiYUNFdWFRdFpQZE80ckt3OXY1aFJr?=
 =?utf-8?B?N0ROM1UwUTUyK3hRRmdKZ0o3dGY1OFRRbjV5bU1sL2JPS0JZa212RlZISU4w?=
 =?utf-8?B?ZDh5T05lU281N0dZQXJvbFQxQWhiNU9pdU5OMG9kOTB1dHF3WVJMWVM2WjhZ?=
 =?utf-8?B?RldvSkR4MGdCbFhqV0hEaHcyUXRFak1DR3A2QldoNERMU3pCV3JUMEN3NU9N?=
 =?utf-8?B?QzBoMjVwWkNzbEJJNEVSd0hacERhZm5taWUvaStQclozMGRtWEQybmdMYkho?=
 =?utf-8?B?SkcwWnBwUm1TbGJTMHRRYSs3WDhZQjlXbXU4Sm5mZjdKNlVVOVZLT2p0WWFq?=
 =?utf-8?B?Z2laSDR3emVodHMrdlAxaGN3a2xzRVBLM09IWkErZTFkL2VZb0U5bmVmWVha?=
 =?utf-8?B?ZkZ0cVZTWFJFcFBCckRtUmR0UHdOU0tQSzBjTmxxbnBuYnpzY3kvVWhnbjF0?=
 =?utf-8?B?RHlQa3VVL3cwZXBQdXdBZkRPN3J0Rks2RjI1cHZSRmJNeENzbnV3a2plUTE4?=
 =?utf-8?B?Q0FhTWtMRytjTUpLellKZkR1RmdCQWJSb1gxNWlVZm8yVTczZkh6TzVrUkRZ?=
 =?utf-8?B?MUlybzFVN3J1MHBHcGNyeW53aTc3RFFQbklYeGNWZGFLUU40a3gzOVRzdmVv?=
 =?utf-8?B?YllzUXZ0cXdDV3dUdTgyOU9Na3pVaEN0Sk9aQytZdmxRb2xtR3I2V05yb0Ni?=
 =?utf-8?B?amkwMEFyN0tVZjFqK2hMcDRuc1NGa0hJb0YyMktUc2gvMnRNVUFpSjYvSHR2?=
 =?utf-8?B?cFRFRUZBL2FBTDBiK3FpMlZ3WWVmekpBQ203WDFDU2dZN0FvTnVBaE8vbmVl?=
 =?utf-8?B?STdEVnRmcnBucHRQQ3RnSHVDNmlzWWxDeHpEelVSdjJFWXRVUkUrTmxCQ1Rp?=
 =?utf-8?B?K1hEVW5oaWcvVUJCbkdjUUIxb2t2VHkzU01QTlUzZkN5L0NBMnBUYzR6aWl5?=
 =?utf-8?B?eDlmNlFjZ0JwQlI3dVE5YzZxekluN1FsampjMk9TZktFRXZXRW01c0FOdk05?=
 =?utf-8?B?UUhId2o2WUlXL0tZeHJ0TkhuVVZXaDZBR0c1TDBMUnZUWGk3NENad3AvTzRE?=
 =?utf-8?B?NG93bGdVcGlVaGxsNTNkb29Ha2VHNHBiTWJtaUZEZ1RLMHBZVHljQTJSbzhX?=
 =?utf-8?B?SUZuOElpZmF4OGM1VU45Z2dKM0gyUTlBZG91S1h2NTJiZzlsZDBXVUE5dkdB?=
 =?utf-8?B?d1pPcnhxeEg2U1hhWDU0OXczRmF0ZnFVRTNqaXRDcWdsQm8yVm5hOUZyb0Rx?=
 =?utf-8?B?ZXJTNklHYzZwYjU3bFdnSXhodURiRUtZZXl1S2VYMTZYYlNDV1JuZFd3OWpz?=
 =?utf-8?Q?6su+op5wzbmUFM6arjDv9aQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnhIVDdJWGNtdEZMSU03R2ZXZnBla0NTT3hlRldTSUlRTGJtcW1xSGhjZ1J0?=
 =?utf-8?B?WGVmQzMwbEJybS94bUtwVzdWUGh3MjUvS0lTaFh4TnBUcVNrYytrejcxUXUx?=
 =?utf-8?B?Z0o3dUJwQk9yblM2aGxDWGtlMVRiUnhCbXhoWUdGUWNFVzBXelphbEg0WXBP?=
 =?utf-8?B?bHFjTEtTV2QreDNIaXZYa2JlU01KSzhmR0xZajd1dU1pMVJxa3hlUEhZb2Y0?=
 =?utf-8?B?WTIyWWJnWlRGaWM1bC9nb2Nlem9DRVNzSjVPd1VWSkRPb3NDQWFFdU54N1Az?=
 =?utf-8?B?RUdhTGdmdlZ1TG4yZ0VNTkIweVdjanRRNzl3em8zWkhGR0Mwa3FqQVA5OWV5?=
 =?utf-8?B?TzcwSEN1Y0xKZFU4RjRuR2hmWVpUcmhOTjFhZVQ4WDhnOXFKRGptd0RENkg5?=
 =?utf-8?B?OW5NeGU3TWthdEFPU2EvcjFUK1V2QlZaVnU5ai9lKzNxQzYzNmx1N0pPdzVL?=
 =?utf-8?B?OFkwMWozU1pMc3A3T1kyVVNuTVdxR3FFZE1XRUIzUXBFL1E4RmUzbWRnandT?=
 =?utf-8?B?eHlTZkR3blZ6S1E4dmxBNnJ5b3h1K0xZOTd5Mm5SUHA4Nng2QkpPMU1yd2s2?=
 =?utf-8?B?MnFiMVVJMjZjRXptQ3YrZjh0N0dyNWVZUXd4Qjc0VTJ4SmhRZlhsc1Fac0pM?=
 =?utf-8?B?NTU2bG96U3pvQ0VJM1ZKbmp6aS9aK1FrZm1qM3VzRmN0eHgwSDJwSnVpMDVX?=
 =?utf-8?B?WFRaejhNQitMTWE1QU52Uno0bFpjN2pQd1doOHdGZEtteERPZmo3NWlYcmxz?=
 =?utf-8?B?YlhGQmoxM0xkb2J2MnBET3ppSnNYbTRIb2tZZmx5TFVqNEVKQmdFNGw2SjI3?=
 =?utf-8?B?SGFaOGZldjRiSDdwNFlkV0ZqTVRRSW92SkVnNjBOVFpzNjVMc3YyZjhFSzZh?=
 =?utf-8?B?aW1GZ2cwQzA0bUUwbklxc3BsWEozd3kxa1ljS0grWkxjOGdHZ0FLVXhraDZT?=
 =?utf-8?B?UGxKSHBDWEw0YkVHRWNPNEErMzFCTjZ5cE9hU2E0aUM4anJOQkVHbGFiZUs1?=
 =?utf-8?B?MlhLa2tsbWM1dnpHN29IZy95MUZHMzNYanBmcHlkeDdscEJkOXpnaTBobS9S?=
 =?utf-8?B?ZHVITWN3SHAzak1VRFJzTURxZTJOcWRSYmpVL0E0TUI4bkhTaFZrdXJBMklu?=
 =?utf-8?B?eThQOGpjMm9QcC9rZ0pmRUkzVzY1alc5TUxMN3ZBVGhzQXA0OVV4eHFSakhZ?=
 =?utf-8?B?Y1VTV29XZW9oRUtFTWRxeHROYW95RmthazRha21vUWx5Q2FlMVdpdGZQUlNY?=
 =?utf-8?B?TG1DdCtOQjFNc2wvb2NGRGNUTUdIQVEwWmNEWWVYcDRZbFpKQ2s2Vnc3TXB5?=
 =?utf-8?B?N2p6WnlUQ0ZSN1pKbDVUdWJybytvejJ4Zml0YTB3UTFzM2hGbEpyL25TN0Z0?=
 =?utf-8?B?ZnF0R0oxdmhPTHBZLzJ6Z1JLemVzU3BwVUxZQlJKOEtnemM5N3R6NDFUdTRp?=
 =?utf-8?B?NUl0QTY4QXJIaEZkUDZpNmJzL0Ztd2ZPZWoxOGhXSGUzL0FrdGhTRFN4V0hm?=
 =?utf-8?B?TWdLZjVNUEJHNHNsWmoyS1JPdUV3UjJ2OTRnVVFtYmxTV3ZJMnBRRHc5cEJQ?=
 =?utf-8?B?eHBDZm9ZelRSTjdJT29JMkNjME40andBZndIRGVxcmpYQzlha3EzNGxDdkhx?=
 =?utf-8?B?cm9NWE9abXdlMWl1TklscTNkdzlSVUEwditQZHJ2ZEwyUE50ZHltYXZvZW1m?=
 =?utf-8?B?MFBnaWdDR0pUUGlIWmN6WDg5SGJOcTdZUkJrNytjNitBTkt6a3ZkRXlyeHFo?=
 =?utf-8?B?R0Z1Z0dKSVhydXVGcFhSNmZjVXJ1cU5lWFZHQWp0MXR2NER4c2NZK1hIZlZz?=
 =?utf-8?B?K3BXVC9WcDg0QWkwMnI4eCszTHZYMkJaNHpNM0U0dDVxWkhteFc4eldQcHVj?=
 =?utf-8?B?T2p5YUVncEhlb1NmYUt1WVJnb1VJcGxEWHVXdVBXM2k0bkkwbUxUdEN2L3hi?=
 =?utf-8?B?dGM4clpSZGVpM0NBcU95c3BDeldLMlRZSkVqclZKeCsxd0JzQ0dhK1V5YVRW?=
 =?utf-8?B?NXJOclN5TUhGSHo4aTh3K1RweWRuU0o4RDV0Sy9qZStqSW01VTB1eStNdjdG?=
 =?utf-8?B?MUVzS2tpblBNQXFocUJLOW00NVBzUXVCQzBydFZzc29UWXBQbmhXUXVtaCtX?=
 =?utf-8?B?MUNha1M0cXE3QzgyNFcwNW40Y1RnZGUzZGFsR3VrOGdtMXRNMFcvTkQwS21v?=
 =?utf-8?B?V0lMR2h6WWVHdHRDR205aXoxZERqLy8xbGtxMGUrdkVuWGIxUEJyT2xobkRh?=
 =?utf-8?B?cENMMG1lTnVnendBZ2owQUtNWEZSd3RJd3RZUWhQUDZSTDBOR2pRYzhXV3dt?=
 =?utf-8?B?TXpoVVJTZG9wUjA3RFVDMUpLK1I1UGtYWEJsZlNaSHJhMVhFclYrSHJhSWNO?=
 =?utf-8?Q?bhbXLLnk5pEndP8Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6D1C27ED8F76A4681E67B1830B1488D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b578a75-93fb-46b6-584d-08de6e246fd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2026 12:59:50.6958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zOt/o8WhWGnm5nBYHgzWrloMCAASB1nZ8ISk90dX7ErkDCKuk8GpVJ18wXig1uL80zX4QSQvCu+lKo6nkS2Ypg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7577
X-MTK: N
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk,mediateko365.onmicrosoft.com:s=selector2-mediateko365-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31948-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[mediatek.com:server fail,mediateko365.onmicrosoft.com:server fail];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mediatek.com:mid,mediatek.com:dkim,mediatek.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Ryder.Lee@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+,mediateko365.onmicrosoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RSPAMD_EMAILBL_FAIL(0.00)[ryder.lee.mediatek.com:query timed out];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 39E7214C468
X-Rspamd-Action: no action

T24gVHVlLCAyMDI2LTAyLTE3IGF0IDA4OjQ4ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiBNb24sIEZlYiAxNiwgMjAyNiBhdCAwODowMToxNUFNIC0wODAwLCBSeWRlciBM
ZWUgd3JvdGU6DQo+ID4gVGhpcyBhZGRzIHN1cHBvcnQgZm9yIG10NzkxNS9tdDc5MTYvbXQ3OTkw
L210Nzk5Mi9tdDc5OTYgUENJDQo+ID4gZGV2aWNlcy4NCj4gDQo+IE5vLCBpdCBkb2VzIG5vdCBh
ZGQgYW55IHN1cHBvcnQuIEkgYXNrZWQgeW91IHRvIHByb3ZpZGUgcmF0aW9uYWxlIHdoeQ0KPiB0
aGlzIGlzIG5lZWRlZC4NCj4gDQo+IEFsc28sIHJlYWQgc3VibWl0dGluZyBwYXRjaGVzIGZpbmFs
bHkgLSBpdCBpcyBub3QgIlRoaXMgYWRkcy4uLiIuDQoNCkFyZSB5b3UgcmVmZXJyaW5nIHRvIHRo
aXMgLSBEZXNjcmliZSB5b3VyIGNoYW5nZXMgaW4gaW1wZXJhdGl2ZSBtb29kLi4uDQpTbywgd2hh
dCB3b3VsZCB5b3UgbGlrZSBtZSB0byBkZXNjcmliZSB0aGlzIGNoYW5nZT8gd2hhdCBhYm91dCB0
aGlzDQoiQWRkIHBsYXRmb3JtIElEcyBmb3Iga25vd24gZGV2aWNlcyI/DQoNCj4gDQo+ID4gDQo+
ID4gU2lnbmVkLW9mZi1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPg0KPiA+
IC0tLQ0KPiA+IHY3OiBhZGQgbWlzc2luZyBkdHMgbWFpbGluZyBsaXN0IGFuZCBtYWludGFpbmVy
cw0KPiANCj4gTm8sIHlvdSBzdGlsbCBkaWQgbm90IGJvdGhlciB0byBDYyBtYWludGFpbmVycy4g
SSBnYXZlIHlvdSBkZXRhaWxlZA0KPiBpbnN0cnVjdGlvbiB3aGljaCB5b3UganVzdCBpZ25vcmVk
Lg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQoNCk9oLCBJIHVzZWQgdG8g
ZG8gaXQgdGhpcyB3YXkuIEJ1dCBhcmVu4oCZdCB5b3UgYWxsIG9uIHRoZSBkZXZpY2V0cmVlDQpt
YWlsaW5nIGxpc3Q/DQpJIGRpZCBub3RpY2UgdGhhdCBydW5uaW5nIGdldF9tYWludGFpbmVyIGFk
ZGVkIHNvbWUgbW9yZSBwZW9wbGUuDQpJ4oCZbGwgaW5jbHVkZSBhbGwgZHRzIG1haW50YWluZXJz
IGFzIHdlbGwuDQoNClJ5ZGVyDQo=

