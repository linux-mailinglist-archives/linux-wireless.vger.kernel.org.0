Return-Path: <linux-wireless+bounces-31686-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGvVK3LSimmaOAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31686-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 07:38:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42345117676
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 07:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A779530098B7
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 06:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FD127AC4D;
	Tue, 10 Feb 2026 06:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eSgnc60M";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="aDviL3yR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E2532E13E
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 06:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770705517; cv=fail; b=Gp1mVzeWzkvsfQNisH8wegSNfWg22f7ce3mHPCFEoLAd26TgCpe9A4dj63otsOk68GBJwCbfeVFk0H75YXA/p3Lg61lEeVZ43Z203PyF3KQXgreJXjvyo/HXGM7nhbPefkvXTXZLEq5K7b+heucMMMn2ks9mWOsNcqEzmoG+kkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770705517; c=relaxed/simple;
	bh=i7beXGAd9Op6k0klD5GssWTLqfdtGr7aoZMrpIE/0n0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c4FU4hH/vQCF96yZyTCbVh5uKMzei5/WKJhhHkYwuUfq+iZ6Sa1bsjANY1JtCwcjrmtbfE+Jw6a77xUhet+O02rOAoTRGqRiawSjWMVq7xQTR9Lx58Up+ut9h99CqTJjzK/e0gBxzspqVa/mubbdgkCb9WXvG5LG3/miukq1yfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=eSgnc60M; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=aDviL3yR; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1d2a4a48064b11f185319dbc3099e8fb-20260210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=i7beXGAd9Op6k0klD5GssWTLqfdtGr7aoZMrpIE/0n0=;
	b=eSgnc60MJLxHfLPMe5yYvG3YTWkj6Ofm/mKH38SzNpH5Bjsc3dnoAH9vLjKqTdaJBiDR7v3Btn0CVJFybE6BZetbaI7MzYUMwoF9cYexUthAjp4Ua2KKKpI2O8ZJaOc1rAZciRYjds4WyDabeiL8Ejy9k8RkbqeyPpDnAMAb4wM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:d8ced05b-e82d-41be-935d-a7e32d5ed318,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:04e9c97a-8c8a-4fc4-88c0-3556e7711556,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil
	,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1d2a4a48064b11f185319dbc3099e8fb-20260210
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1114960135; Tue, 10 Feb 2026 14:38:30 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 10 Feb 2026 14:38:29 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 10 Feb 2026 14:38:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5IEt1LD8m+GowXEu9CulSkdIuWKSg5cBbWmR9K2bKefvC1i4auD1ullIvzi6E+oQFCK75JhNPDM15xdMM6bINAXgK8FwGHQ2xOsna47rklKRsMZDfmWjHYUGZka71JqJXXAPlyODhYIgXwTF7dTZQ4hYNJd3DGyFwQM1YMNmXIzgN1GJo9Ez39y6KnlvjRprRI2SVsVDbooFLocc4DYcE/7ks93JfRy9o0vvQYq7ocmeqAPx7kSPexK2AJQLSa/kGI/sMhpg5rj22CFyDNCIadx1OqO6zHnkPpVyES17xmi9IfO988g32AoXdPgxEmfBn6deNR0yToA6sbXnjzTmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7beXGAd9Op6k0klD5GssWTLqfdtGr7aoZMrpIE/0n0=;
 b=jThrDyAx85q9BIj5IqOjYA8G8C7XbIRduYHT3tSovbnH1TRpoaBIrVP1k+qC0yXWy25KrmeAj9csyCIR4+T8rYKys3jVSfIxGbd0wo0fvg7fOo/Zog2Cjv6KNMVNGbPvxryLfFVlroa8PYDhdhHVyJIJe7YR3+V7ezGNkB9Jl9LTuqEIM0H8Njo6C5Lrlr96+/aInpCHuKwRHhLMUGXL4r2tb5F3LaVB1kQxCDZrZu4PTDHiTvGTe1Epud/l0fZ4PNcZ/06RpDxQDGZMfJzU7Hz4I5b61FI7wtqE7mKMf8zIMycsargzG1rZiJLhG1MukkMExgpuMlXRXtC6SO6KQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7beXGAd9Op6k0klD5GssWTLqfdtGr7aoZMrpIE/0n0=;
 b=aDviL3yRS4GfS7BcWy2Mb5/AEP1uahA/QAEh0P/LTfM85rn2hInbO/30bJqpnmShL+zz9+8Sm3zD5GI1DpcOi30y8Md+ijZhZOfOthiBRQhOKH+Dpx2A5ULEULPjsmY5skYBn79kwhMMVdPzjGykTIuiKN9Hw6YgBe3msE7ux3s=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by SE1PPFE9384ADEA.apcprd03.prod.outlook.com (2603:1096:108:1::86e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 10 Feb
 2026 06:38:24 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059%3]) with mapi id 15.20.9587.016; Tue, 10 Feb 2026
 06:38:24 +0000
From: Ryder Lee <Ryder.Lee@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "sven@narfation.org"
	<sven@narfation.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"nbd@nbd.name" <nbd@nbd.name>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>,
	=?utf-8?B?QWxsZW4gWWUgKOiRieiKt+WLsyk=?= <Allen.Ye@mediatek.com>,
	"saravanak@kernel.org" <saravanak@kernel.org>
Subject: Re: [PATCH v2] wifi: mt76: fix backoff fields and max_power
 calculation
Thread-Topic: [PATCH v2] wifi: mt76: fix backoff fields and max_power
 calculation
Thread-Index: AQHcj+iACaXAJ4Cwl0+SoSzYpus5ObVvGDQAgAr5CICAABingIABZf8A
Date: Tue, 10 Feb 2026 06:38:24 +0000
Message-ID: <1816591a2149629822a1e08fc4c3fe7601b802fa.camel@mediatek.com>
References: <54627282cfb8e5a89fe753da66552c0a084f6387.1769557863.git.ryder.lee@mediatek.com>
	 <7906220.EvYhyI6sBW@ripper>
	 <278546e3f3e526288d245111d8e022b2d68d012e.camel@mediatek.com>
	 <4713788.LvFx2qVVIh@ripper>
In-Reply-To: <4713788.LvFx2qVVIh@ripper>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|SE1PPFE9384ADEA:EE_
x-ms-office365-filtering-correlation-id: e6bf407c-800e-4299-3e3a-08de686efd9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?aGp3NXFBaEZHQVhMYmJKdEt6NW5vOWR3YUdCR2FlcWRGeGhUUjFBU3dNc1Fs?=
 =?utf-8?B?ZklPQUluSzVnMnBhdGs1VFZRcTRRRzB1c1lEdC8zT2VQK1d5S2dPTUpTWTNL?=
 =?utf-8?B?eFVQZ2NDWU1CejY5R1BBcDlvY2FyMHI1Zm9EUXJTZG42bEF6UHFaWURVTzZX?=
 =?utf-8?B?MG5UMG5ZYWpQRDM2NGlSZ205NHdYRGRYWWlmY1lETjZMZHZ1WlFRa3RZbkpF?=
 =?utf-8?B?ekVZTlA3bFdZcm9jTXd3d0Y2ZlJ6NzBhYnRUTFNuUFNIb2hqNmlBcnE5UXBz?=
 =?utf-8?B?UlJkN2JMRS9UTWhXY3V5NFpIV2JNTVB1NkJhb2VIajJTVFVBcjh0SnJhNVNq?=
 =?utf-8?B?QlNNb2pqa29HL3RUcjVXWUEvYnEvVnY1YXJwaXNYNFAvbTFZWEdvK2pkdlRI?=
 =?utf-8?B?eUVsdXpWQ01lekNVT1FUU2NpNFRpNUNlb0VIL1NMbmZodjVZaU1ERUNWMDNP?=
 =?utf-8?B?Zmw1OHBpaVBWMU1NdUdlckRZZ212M3lkeWQ1bSsvaTMxMkdKbW9Ja25Db0t3?=
 =?utf-8?B?aEFKQXVNMUdhZ2J4b2xGSFJOWHNGaUpzR1R3V0pVN1I0S0hFSytkT0dyVFRG?=
 =?utf-8?B?aUhUQXlzdlgxaFg2dERhOFNQRGFaQmI5WkROY0tyaGRlRTJpOEgydWN0TVVU?=
 =?utf-8?B?SGNIM1BxejFqeDNXK1dmR1Noa3NCTXJkUy8vcEdJUTNkdTlBOUdXZThzOTVu?=
 =?utf-8?B?dy9KUlNlU2FobWYrMnpLZXBHaHMxOElYZWxrM0JzYWZ6ZWYzUWRsZ01RMGNB?=
 =?utf-8?B?SDVOYjFpcTNsYlBZblI5MDM3ZFlZK3ZoNS81S1ZFbGNFU0dkSDRSNFJIblJ6?=
 =?utf-8?B?QnlzYzhyNU1JTi9kSElBRGRWMzlvREpZOHhETHVaNmUwTDUwSVJBc1NMRm40?=
 =?utf-8?B?UmNEM2pFbGhzQW1VcE43QlZDT05MSFczL2NyVWd6VHpqY1RaVjIzWWcxNFFq?=
 =?utf-8?B?OWJPMEFQVTNZV2xUUmVZMEJLRlh6UTE0cVRYZEVaUVpRaUJvMG5yQjJ5cGhK?=
 =?utf-8?B?ckJ2ak5MZDNJT2tDUWhmRG5WaG96Z0dOVnJlaXdqb0IwVVBrNlpNTkhJRVUv?=
 =?utf-8?B?c3VQd3pVVWdRcVFvRW02RnhJRFh1NlAxYVYwKzZ0SC9yanY5YjdKVkdBNlB4?=
 =?utf-8?B?YWJwdFJ0Y2hrdWxEbFB5SUpSRkE3a3JsZHRPNk1kVndRYnBGYWUyRXJnMFN0?=
 =?utf-8?B?bS95LzMrbkJGRzJrZit5aWtZQzNJY2k0aHMzREtpVHZRb1Q2T0M0NUFrK3FU?=
 =?utf-8?B?ZCtWYStobkRSK1h1S1llalExYmZUVW9ObUhNRDgraVdtSUMwZTRFbzF5dW9q?=
 =?utf-8?B?QWtVN2tPNmMzcEZHb3ZSMW5CckRXeXNvZ2hLZmExV3ErU3hNeGR6cFhVbWJH?=
 =?utf-8?B?ZnQ1Q3ZrUmY0dndMZ0g5bHh6S2tMUjRZeTVCdDVVWHprcDBNVThzSWNHNzI3?=
 =?utf-8?B?M3RBMHduRGNxaHhpcUVlRTg2NS9CUUpMdzFkMGhGaWZDZ3dieSt2SUhpV1lM?=
 =?utf-8?B?SG9VaFkwN1Y2ck1UdE5MdUw5LzJYOEtxbFlvaTdQM0NJbWRyNDVmb09ZcUhB?=
 =?utf-8?B?ZTB4V3BHSmIyTTZlc0pHTXp4SUtURzRoTmRZVkpaZmsxYmh2Tm5vbVNjakVZ?=
 =?utf-8?B?VU5WUXpiQnBBZng3R3BrWktKN3ZpSnVWQlhnclFUWkRUNjQ5UHlVRFRpYUdP?=
 =?utf-8?B?YWxlZ09vdGpoRWo1b0dDa2hvYzh5ODdNUnBlMjg5QzM2VENxS0QwR254dlVX?=
 =?utf-8?B?Z0tkdTQvWnFBTVRuS0d1ZGduKzhlSkFqWUJ1M1BNVjVuZ05hWWlVQVZNSFNa?=
 =?utf-8?B?N3FSdjRjR05MT25UWmF5bUp3S0VYZjg5WllFV3NiMHJGOHpjdDgvNDZTOUgy?=
 =?utf-8?B?RzQ1SlBpT0tITnpTdENuY2VGanRrSW1kTHZiNVQ2ck9ldURxdERVcTlQSzZK?=
 =?utf-8?B?bG5TaW5iZEhGQ0xXeDRPb0hCZ0RVYmE0RXBsZll6V3dBU2sxNkx1eTU1ekRM?=
 =?utf-8?B?SERVcTRnNTZvbDJMU3l3a1JXOVQ5V2gySWpzVmVGQVozaW9sQ0dCU1dZaW01?=
 =?utf-8?B?K1BhRHBpZStQUzRaTDNENU5xWXFRWk9YbkxON1RYa01CNW1haFczb1FvRlVR?=
 =?utf-8?Q?6DT78W1pptvZysFhvHpcW7IPT?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXpQays5SlZMVy9qN0h4Uno4MHdhV3FKb2pBWXovWHFSZkFnYWIyV2lYaTBT?=
 =?utf-8?B?WUxpQUdqaTh3VTJadlFiaGFTeEk4aEZYZ0xkTFNJS0ttSXhXL3dZWG1zSVFD?=
 =?utf-8?B?VkRWRWxpNXNMT1Bwd3htY2xpZzZoczdKVW9zVmY3K3VzdHVxY2NmS3lwQ2dQ?=
 =?utf-8?B?Yi9WOXVQU2pIUndickhraGdReEQzL1BmYytkcys4T2NyUTlXYy85c1JTSjhl?=
 =?utf-8?B?NGljWHhGYmpveU9aQUtZbldBTnhNaWlyazBETmxQZDkxSEx3Z0phWmNXTHVT?=
 =?utf-8?B?QjBDYXNLSENTZE9jdjYxV3p2Q2FHeTFBai9Bam9Ba283cTJKS3JPVFJIcnFG?=
 =?utf-8?B?N1FJeVZYSXhxRW9CRmUrMGpUR016Y2Y2MXVaK1JrLzRQUnkzRkErMjBGYWIx?=
 =?utf-8?B?SFhUWTFQcmphaGRaeEhRNWw5T0tsYW1rNDZETFUvUCsybVM3b2VvL0VZVFVN?=
 =?utf-8?B?eEt5bUZRdWIxZ0trRWRvSFJSVXhNRGVVbXpQdDJZNW9XNWx4R3dwUmlLNTd5?=
 =?utf-8?B?a2hadTY3V3ptTlJSMFhMcGdxcEhOOG93cmxjMkNmVW1wSDlYSHN1NHV1eVFt?=
 =?utf-8?B?WWR0SjlRNWpIQ2RtY0l0SmduMTFQaklYdCsvRElFMGs0bS9QWHJVRjlpNVRY?=
 =?utf-8?B?a3pwN08vRkN4QnNDMDhqZVF5c0lKZGgvMW1HU01PVFphWUlhOUVBMEFUVlhQ?=
 =?utf-8?B?WEZqalk1RjZvTHpHNllnRWhrVEFDbnU2NGpIM3c5TmF4TzNpUXorZUtKZGgr?=
 =?utf-8?B?d1dFVUZvN0VVNmhMR1A0d2puaW5LSUVFTllINVEydXFwRFZmaC80c1EzRzJW?=
 =?utf-8?B?T0ZKOXdsTWlEUEtkdEo2Z0hoWjdZZ21CbkZtYXBsYVlSU2R4UUhMWFROUXoy?=
 =?utf-8?B?b3FFb0gzcjVZL0NRNEk1YmV1cGJ1SmdWb0RpQU00Nzc0Ti9hVmpibFdtOGxG?=
 =?utf-8?B?L2ZvTExjdGc3cW5uYXp6LzNaUU13Mzdsdm5sTXlJdm5Cd3Y4RnovazJxbzdU?=
 =?utf-8?B?VXdhY0dKT2F3MTR4QTdTdWU3aC9NOHIreTdXd3RDaU51aUNVZEZHTkZDT1lX?=
 =?utf-8?B?NzhCS1o4NmxoN2xqeEZDSllhend5d3liMEN3Y1gyaVlJQ2RiUUw0NkExYVpm?=
 =?utf-8?B?c01VdWpqMDZzcU5aSExOMjF5RlNrOUIzYWp6Nkl2MjBGS2NtdzRSbDN4Y2Z4?=
 =?utf-8?B?R2pXa1VNYjVLZ1ZiNlJQZ29mWHBrTkNYT2hsR1Y5QU1ybFlodS81dE4vN1h4?=
 =?utf-8?B?SEFMTEtqYUJNZ2RPWjRJdWhzOTBCeU4rZGg3U01wV285VUZSMVczWTRYK2hv?=
 =?utf-8?B?Q21TRjZRcWR1UTlmci81aFlnenZNNXBSOHpjN29DbzYybVVxdG51a0dsMHlW?=
 =?utf-8?B?NHFmcEY3ZjArNkhLZ3lvTURwb2JqYnVDRExoWmlsbVRXYnoybDRBVTBnT3NK?=
 =?utf-8?B?SXU1RWsremNRd09pZUJUOUxqNjYxaUFESERnbFBMM0FYS0huQnI0Y2Rja3dE?=
 =?utf-8?B?MWJFQ2dJck9Md1BlMzNiamxUUFZqbXBCNkdJMHpPZit2OXF0V1NRZmxISjRn?=
 =?utf-8?B?YUltUVFmMTJ3QzRuSVRGVWNwVHJPOU0vMTh1OU8yWjU1dFBSbjRxanBQWUJt?=
 =?utf-8?B?akNNbTBZNmVYWHlBUjBHcUEvOHZjaXROemt1WUkrVStKT0E1akdha0Rjd0pz?=
 =?utf-8?B?RHoyR1FGQy9rR1Zld2pzSFFtZGk4Q09aaCtVcVZvY2Vna2s5SjhCZmNIWFJ1?=
 =?utf-8?B?VEtlNFFBYnJZSHVQMlRHZnVpb1JnS2p3RFFwZDlYbU5QdWYxdDhxakZLd256?=
 =?utf-8?B?ekdmbVc0c3pRTEdWRVJKZDhsZ24ySkcwV2l2aWZjR05EUmJWaHIrVS9qK1Yv?=
 =?utf-8?B?TzFBN0RMS1N5VGRjelRpQWxNYmV1cVBySHU0MmkydVMxOWxLcUhqcGRLR0hM?=
 =?utf-8?B?OEliN3J2UGxzQUlkWVpSNS9nNVA1Rk5uRk1OdU02ZmI1NVZmZFQzNCsyK2F3?=
 =?utf-8?B?Yk9rVWY4M1J5bWYyaXQrWHRTOGhueDB2L0s5azN4OVB6YnFIMmhLRmdSLzVI?=
 =?utf-8?B?OERxRkd5Q0ZrVnAySHNPbTU4UUZPNEtVMlZpbFJtQjFCaFFvS0Z4S2hieU16?=
 =?utf-8?B?ODBYZ1ZudDhKVEFZK0hPWllpL1NmY05zNXltOTV6UmFNcUU5bWRvZ0M2UnhY?=
 =?utf-8?B?M2VMU3ZFZExEQ2h3OE9pNkNCcEc2Y2llNGFlT0JBNS9RSUFIRTJJbk50Qmo3?=
 =?utf-8?B?b1VLUnRFV0lRNmN1UDJjTVR1cjFHdzEwSWxrbUc2VlRGT0ZkcFhqNHRCVWJs?=
 =?utf-8?B?dTVjNytiYVh4WFl0TDRHenV2akFneExETGdrejY1RjVJTnA3dS95ZVhlbzAy?=
 =?utf-8?Q?YHbNPTgPJCliuiWQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8209B475B979D42984E2903D590D1B7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6bf407c-800e-4299-3e3a-08de686efd9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 06:38:24.3669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WXwlOM0MCXh/KnRO0JnjSW8bwMMEl14AAgaIQTzC3kym336dj2A2uiiZj1wv/M0tOx4So9sqOAsb6TQpZsjtIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPFE9384ADEA
X-MTK: N
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk,mediateko365.onmicrosoft.com:s=selector2-mediateko365-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31686-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mediatek.com:mid,mediatek.com:dkim,mediateko365.onmicrosoft.com:dkim];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 42345117676
X-Rspamd-Action: no action

T24gTW9uLCAyMDI2LTAyLTA5IGF0IDEwOjE3ICswMTAwLCBTdmVuIEVja2VsbWFubiB3cm90ZToK
PiBPbiBNb25kYXksIDkgRmVicnVhcnkgMjAyNiAwODo0ODo1MCBDRVQgUnlkZXIgTGVlIHdyb3Rl
Ogo+ID4gLSBJbiBjb25uYWMyLCBiZWFtZm9ybWluZyBlbnRyaWVzIGZvciBCVzIwfkJXMTYwIGFu
ZCBPRkRNIGRvIG5vdAo+ID4gaW5jbHVkZSAxVDFzcy4KPiA+IC0gSW4gY29ubmFjMywgYmVhbWZv
cm1pbmcgZW50cmllcyBmb3IgQlcyMH5CVzE2MCBhbmQgUlUgaW5jbHVkZQo+ID4gMVQxc3MsCj4g
PiBidXQgT0ZETSBiZWFtZm9ybWluZyBkb2VzIG5vdCBpbmNsdWRlIDFUMXNzLgo+IAo+IFRoaXMg
ZG9lc24ndCBzZWVtIHRvIG1hdGNoIHRoZSBkb2N1bWVudGF0aW9uIFsxXToKPiAKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBhdGhzLW9mZG0tYmY6Cj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVm
aW5pdGlvbnMvdWludDgtCj4gYXJyYXkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBtaW5JdGVtczogNAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIG1heEl0ZW1zOiA0Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ZGVzY3JpcHRpb246Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IDQgaGFsZi1kQm0gYmFja29mZiB2YWx1ZXMgZm9yIGJlYW1mb3JtaW5nCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgxIC0gNCBhbnRlbm5hcywgc2luZ2xlIHNw
YWNpYWwgc3RyZWFtKQo+IC4uLgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cGF0aHMtcnUtYmY6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJHJl
ZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDgtCj4gbWF0cml4Cj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVzY3JpcHRpb246Cj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFNldHMgb2YgaGFsZi1kQm0gYmFj
a29mZiAoYmVhbWZvcm1pbmcpIHZhbHVlcwo+IGZvciA4MDIuMTFheAo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByYXRlcyBmb3IgMVQxc3MgKGFrYSAxIHRyYW5z
bWl0dGluZyBhbnRlbm5hCj4gd2l0aCAxIHNwYWNpYWwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RyZWFtKSwgMlQxc3MsIDNUMXNzLCA0VDFzcywgMlQyc3Ms
IDNUMnNzLAo+IDRUMnNzLCAzVDNzcywKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgNFQzc3MgYW5kIDRUNHNzLgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBFYWNoIHNldCBzdGFydHMgd2l0aCB0aGUgbnVtYmVyIG9mIGNoYW5u
ZWwKPiBiYW5kd2lkdGggb3IKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmVzb3VyY2UgdW5pdCBzZXR0aW5ncyBmb3Igd2hpY2ggdGhlIHJhdGUgc2V0Cj4gYXBw
bGllcywKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZm9sbG93
ZWQgYnkgMTAgcG93ZXIgbGltaXQgdmFsdWVzLiBUaGUgb3JkZXIgb2YKPiB0aGUKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2hhbm5lbCByZXNvdXJjZSB1bml0
IHNldHRpbmdzIGlzIFJVMjYsIFJVNTIsCj4gUlUxMDYsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJVMjQyL1NVMjAsIFJVNDg0L1NVNDAsIFJVOTk2L1NVODAg
YW5kCj4gUlUyeDk5Ni9TVTE2MC4KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBtaW5JdGVtczogMQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IG1heEl0ZW1zOiA3Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaXRl
bXM6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1pbkl0ZW1z
OiAxMQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtYXhJdGVt
czogMTEKPiAKPiBSZWdhcmRzLAo+IAlTdmVuCj4gCQo+IFsxXQo+IGh0dHBzOi8vd3d3Lmtlcm5l
bC5vcmcvZG9jL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWslMkNtdDc2LnlhbWwKCkhtbS4uLklmIHdlIHJlYWxseSB3YW50IHRvIGRpZyBpdCBv
dXQsIHRoaXMgZG9jdW1lbnQgaXMgaW5kZWVkIG5vdApwcmVjaXNlIGVub3VnaC4KClRoaXMgaXMg
Zm9yIHRoZSA3OTE1IHdoZW4gZmlsbGluZyBpbiB0aGUgQncyMC80MC84MC8xNjAgcG93ZXIgdmFs
dWVzLgoKSW4gbXQ3OTE1X21jdV9zZXRfdHhwb3dlcl9za3UoKQouLi4uCiAgICAgICAgZm9yIChp
ID0gMDsgaSA8IDg7IGkrKykgewogICAgICAgICAgICAgICAgYm9vbCBiZiA9IGkgJSAyOwogICAg
ICAgICAgICAgICAgdTggaWR4ID0gKGkgKyA2KSAvIDI7CiAgICAgICAgICAgICAgICBzOCAqYnVm
ID0gYmYgPyBsYS5wYXRoLnJ1X2JmW2lkeF0gOiBsYS5wYXRoLnJ1W2lkeF07CiAgICAgICAgICAg
ICAgICAvKiBUaGUgbm9uLWJmIGZpZWxkcyBvZiBSVTI2IHRvIFJVMTA2IGFyZSBzcGVjaWFsIGNh
c2VzCiovCiAgICAgICAgICAgICAgICBpZiAoYmYpCiAgICAgICAgICAgICAgICAgICAgICAgIHNr
Yl9wdXRfZGF0YShza2IsIGJ1ZiArIDEsIDkpOwogICAgICAgICAgICAgICAgZWxzZQogICAgICAg
ICAgICAgICAgICAgICAgICBza2JfcHV0X2RhdGEoc2tiLCBidWYsIDEwKTsKICAgICAgICB9CgpU
aGUgc2tiIG9yZGVyIGlzIGZpbGxlZCBhY2NvcmRpbmcgdG8gdGhlIGZpcm13YXJlIHJlcXVpcmVt
ZW50cy4KCkVhY2ggZmllbGQgY29ycmVzcG9uZHMgdG86IDFUMXNzLCAyVDFzcywgM1Qxc3MsIDRU
MXNzLCAyVDJzcywgM1Qyc3MsCjRUMnNzLCAzVDNzcywgNFQzc3MsIGFuZCA0VDRzcywgZm9yIGEg
dG90YWwgb2YgMTAgdmFsdWVzLgoKRm9yIGJlYW1mb3JtIGNhc2UsIG10NzYgZG9lcyBub3QgbmVl
ZCB0byBmaWxsIGluIHRoZSB2YWx1ZSBmb3IgMVQxc3MsCnNvIHRoZSBsZW5ndGggaXMgOS4KCkZv
ciBub24tYmVhbWZvcm0gY2FzZSwgbXQ3NiBuZWVkcyB0byBmaWxsIGluIHRoZSB2YWx1ZSBmb3Ig
MVQxc3MsIHNvCnRoZSBsZW5ndGggaXMgMTAuCgpUaGUgRFRTIHN0aWxsIG5lZWRzIHRvIHByb3Zp
ZGUgMSArIDEwIGJlY2F1c2UgbXQ3NiBkb2VzIG5vdApzcGVjaWZpY2FsbHkgY2hlY2sgZm9yIHRo
aXMgd2hlbiBwYXJzaW5nIERUUy4KClNvIGEgY29ubmFjMiBEVFMgd291bGQgYmUgZmlsbGVkIGxp
a2UgdGhpczoKCnBhdGhzLXJ1LWJmID0KPDEgMjAgMjIgMzggMzYgMjQgMzAgMjMgMjEgMjggMjk+
LAo8MSAyMCAzOSAzMSAyNSAyNiAyNSAyOCAzMCAzOSAzOT4sCjwxIDM3IDM0IDI2IDI2IDI1IDIx
IDM0IDIzIDM0IDI0PiwKPDEgMCAyMCAyMyAzMSAyMyAzMCAzOSAyOCAyOSAzNj4sCjwxIDAgMjcg
MzQgMzMgMzQgMjkgMzggMzMgMzMgMjI+LAo8MSAwIDMwIDIzIDM5IDI4IDIxIDI1IDI5IDI4IDIx
PiwKPDEgMCAzNCAyMCAzOCAzMiAzNSAzMyAzNyAyNiAzNj47CgpXaGVuIDFUMXNzIGlzIG5vdCB1
c2VkLCBpdCBzaG91bGQgYmUgZmlsbGVkIHdpdGggMC4gRm9yIGNvbm5hYzMsIHNpbmNlCjFUMXNz
IGlzIHRha2VuIGludG8gYWNjb3VudCwgd2UgZG9u4oCZdCBuZWVkIHRvIGZpbGwgaXQgd2l0aCAw
LgoKVGhlIHVudXNlZCAxVDFzcyBzdGlsbCBuZWVkcyB0byBiZSB3cml0dGVuIGluIHRoZSBEVFMu
IFRoaXMgaXMgdG8gbWFrZQpwYXJzaW5nIGVhc2llci4KClNvIHRoZSBudW1iZXIgaW5kaWNhdGVk
IGluIHRoZSBjdXJyZW50IGRvY3VtZW50IGlzIGNvcnJlY3Q7IGl04oCZcyBqdXN0CnRoYXQgdGhl
IGRlc2NyaXB0aW9uIGlzbuKAmXQgcHJlY2lzZSBlbm91Z2guCgpPZiBjb3Vyc2UsIEkgY2FuIHJl
dmlzZSB0aGUgZGVzY3JpcHRpb24gZm9yIGNvbm5hYzMuIEkganVzdCB3YW50ZWQgdG8Kc2F5IHRo
YXQgdGhlcmXigJlzIG5vIG5lZWQgdG8gY2hhbmdlIHRoZSBtaW4gYW5kIG1heCB2YWx1ZXMsIHdo
aWNoIHNob3VsZAptYWtlIHRoaW5ncyBtdWNoIHNpbXBsZXIuCgoKUnlkZXIKCg==

