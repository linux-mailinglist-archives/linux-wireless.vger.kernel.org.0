Return-Path: <linux-wireless+bounces-36672-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kELdLFLLDGrAlwUAu9opvQ
	(envelope-from <linux-wireless+bounces-36672-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 22:42:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC49584CD1
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 22:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85F55300A10A
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 20:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B9233AD9B;
	Tue, 19 May 2026 20:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tG4JAIy4";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Mbv4MwjJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EA823393E
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 20:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779223375; cv=fail; b=lr7yAfB2x3/wIuikmM5WI/Y5Zp04x9aXxgpY7ucs/seRLTtTOQUmAHrbv2Op1gCdB/52kQULNwP4rEXTSoIjd/WBhx9pJyBS8LysH+NxxL3lrCVJyjnOQRqH0hv7e6zPSrlBIR5OiLxo4/fFixabVewRNZFzeOEAe/BcqhPseQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779223375; c=relaxed/simple;
	bh=V4SakIHszxguWS2EL0zvUSKQ/IbqOMHR8yT0wwEiU7U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V+1Z/5CqhKIyB3VvdImuB0YZN0e9Xnv42j8FPu15CPEwAJrXOjbmdER1XyE2G/0q6yBIp8nNQomcKhAUySR0ZFiQ9jvGP4uvIYSA/r9Axzf4X6mpz3VqP1ulaIkijlb2Ro54CseR3SUSQIpEUep2IgUbiObfKV5mtyvQsC3sGyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=tG4JAIy4; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Mbv4MwjJ; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 49410bf653c311f1a3561939bc42ff46-20260520
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=V4SakIHszxguWS2EL0zvUSKQ/IbqOMHR8yT0wwEiU7U=;
	b=tG4JAIy4tIxkHF04sgOoXJxLa1W1J0BBqZfRwvcQMzweq9bUwtWTPX+BA+iJRg3kpfR6XqE9eeyvsmd8pMZoBAOXcTbsuSLAqF0AOfvYkqrDxkAG//8zDhLC3mSOVTIMhVDF+7qHN1LocdrW6TaP4K+zkjMIhj5Ffz7aDDNq1S0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.14,REQID:32e036e6-2406-4c51-b481-7dd0bcce58b5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:9091e75,CLOUDID:da2f2046-e650-4d81-a877-d298d8f44b5d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
	l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 49410bf653c311f1a3561939bc42ff46-20260520
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1721962872; Wed, 20 May 2026 04:42:43 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 20 May 2026 04:42:42 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 20 May 2026 04:42:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbBO5K2bH1yCGuZeDXTuKuF7LPNSYVjptW8LRZLgc1UxoJdvhFmHJ1WGGbZWmYIQbQYhbb0fl/CEuuokm+vTMBBdXDY88EnA6vN0Gdq6kfc9V9+3N5GJ79I6KoqiAgHXc5P9LxLuZT6W3ZN0kA36vsNrnrNGCixWLqCs88c4fAmZfOSdE8rPzCRDNtU0DMZNPeyvRa4qubZa5NnqQ8G87e6CpNZL0q9vbHnKquf5YVswpuG2Jtd3EY4uUgowO8ggYCQ0XtbFxZgUyP4eTI+m1mj7Dqvsm7PudbjE9Ulq2yvWMfXE8XiSnBppwMKtmmakWdl+I2x3AVRuv/tDus0cng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4SakIHszxguWS2EL0zvUSKQ/IbqOMHR8yT0wwEiU7U=;
 b=BvUyfZ70GndOi1AFRwqFhcfKOzwGSgJ6DS2hBEtsNB1zb5cTsKtR2P6y3B8M5lVYJbmOE3pN7iWalRqeZRSqe+sitinNCECBCPzPhvHaUcpQMSFr1fmXztFiNQ+q9WWJ+3pIl/l7RO0uPllU5/t1JXJHIZJj8W/VxCLEWoM40LL0U0zmGEZdHlw6RkJpDYKbGkrLP3HV+DMTI9rVwCH7NOcdgYzdlI7floNA+wwfyVFFH/r6C/SyzCU3eOmoVF10hVLID4pqSS6y4G9Nrn2xkiuIdXBsvXtAE8gyQttCoSkdBToZ7nQQQZAcdc/rDZnuhCHo14OnCu6iNX2VIAcUaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4SakIHszxguWS2EL0zvUSKQ/IbqOMHR8yT0wwEiU7U=;
 b=Mbv4MwjJCbBouKh18WWkCTmO7uSU/k8ZiCoc0x0dnmWINn7TWlZcuZRJPswKHJXlgX1kCvD/qpeKvhfnXSHyGBi21jcF+jDCyf19RYC9vdof7ojcIPsODQOGMj0m5Xn/xN+UbGQQRrMYBWY91h1sq1ckPs/tTgFq+nsQhGAepGg=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by SI4PR03MB9844.apcprd03.prod.outlook.com (2603:1096:4:29b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.13; Tue, 19 May
 2026 20:42:39 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059%6]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 20:42:39 +0000
From: Ryder Lee <Ryder.Lee@mediatek.com>
To: "lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>,
	"roychl666@gmail.com" <roychl666@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"nbd@nbd.name" <nbd@nbd.name>, "lorenzo@kernel.org" <lorenzo@kernel.org>,
	=?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	Roy-CH Luo <Roy-CH.Luo@mediatek.com>
Subject: Re: [PATCH] wifi: mt76: mt7996: avoid memset overwriting
 tx_info->control.flags
Thread-Topic: [PATCH] wifi: mt76: mt7996: avoid memset overwriting
 tx_info->control.flags
Thread-Index: AQHc4XR+QEfP6QRq+0yC92qf0lPo17YPTP8AgAAar4CABFnLAIAAYpGAgAEuCQCAAIsTAA==
Date: Tue, 19 May 2026 20:42:39 +0000
Message-ID: <1e1318a9230533c63c31aecbaddf520b6f68affd.camel@mediatek.com>
References: <5ecac6a9b7d29526e8438dea105b58f5487c93aa.1778521232.git.ryder.lee@mediatek.com>
	 <agdJ1EtZjjWh2R1h@lore-desk>
	 <CAHoxojJX2BRRTLMuM_QcJqMMmshxS4EAwrB1VjU3rsZ+0k2PAg@mail.gmail.com>
	 <agsGiHKH6ly1afaf@lore-desk>
	 <CAHoxojKeXCCnJoO7yBBmTM9euiTf38orujOhOK00X8bb3ctWuA@mail.gmail.com>
	 <CAA2SeNJXv+8QO6zEOF=qB3wVCdEoSqx6fftp1i=aB-DKMFeC=A@mail.gmail.com>
In-Reply-To: <CAA2SeNJXv+8QO6zEOF=qB3wVCdEoSqx6fftp1i=aB-DKMFeC=A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|SI4PR03MB9844:EE_
x-ms-office365-filtering-correlation-id: cb917772-48fc-4569-42c1-08deb5e72ac3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|4143699003|11063799006|22082099003|56012099003|38070700021|18002099003|3023799007;
x-microsoft-antispam-message-info: sU0nW0YwvBYXf1W7PppWENK90Wkt3YEgSzOz9qKLX83MT2ne8e9vTAm3xzMmha7NLACW1zchmo443+9EpGehQjuXlkoEmIW6Ylq3RnFfee6S1bQvdE0062r5wZHDVFRAEyyqEndQI330E0lW3QH8koh0fOKemKIwHTwh81o8mwpJFwuLZIH8XkDq06aZX+xEGkvOyZiHTjtYFGIxiso868yMQyGRflm0Mt1L65M/k/i6lJiTPQi6yLJUp5GgRUZ/bErIwA8/i7C8zAAajE/+ZRQ7rCzda4L2cmBj7xiKFT++jB39l8T4RpdxKjSrjZ8LxGn2mH208nHiyz/gUckqVKgwT/6BgONy+3rQUK7Oaa57Tq6to0CCLPazWqBOUoLrqpae2XsXqhvIDq57HE/EpxJHRokN4lOJgxhA88F0hqK1e5ArCtuN6er45ttxfFbl3f7g3Du+/gA3A9bnSH230A+Qosi93BBFMrhOsETHJvYhvOa+H7ewCTqG5Kyw9YpfAxbeurCuyB7HHMmILNjW6ozrBcDtpgSPKUqMB2/GrziXuSrSxTszWD9gdTzTQPDj/BAeG7STgxvpTMl4IoAZ4wh8F4Z2QwwlO29fcjR2Zbbr9LO5dBq6Ze6RxXwKEQYn7ft9NMKQcN64EFyFvjCP13RhxTVJbR1qrB08F8k5YTwjwOqmJXOTR0teaEgkIJrXKpmbJSuCo0DBaImGbKzWi0Th/CrVPYgy9N8eLj4BVD+oTWWAeSve0E7EsPtpQgNS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(4143699003)(11063799006)(22082099003)(56012099003)(38070700021)(18002099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0NzbUh1VVIvMTF0VDJsYzBTTVFlTVZPcFBqYkcxd00yUEx1WDhTWEFDd29N?=
 =?utf-8?B?bWJxTkViTlI4M1hvbUhGOVoyQUdqT0Y0cDgwQm56Z3NYWGhLUlgxRElmeGd5?=
 =?utf-8?B?T2U1MkZUWVZYNUdibmJZV3dMMlBhbUI4L3dqR2VQZ3oxdmhvbVNBTGYwK2FR?=
 =?utf-8?B?NEdJTit2UVp3MFJxVllwYXIvbkh5TjhDVWUrUWxoc0pmdzlKNU1GZDE0MkJo?=
 =?utf-8?B?bjlmNk5hRmx2VWV3OEpkZWFoTGFqMWxFNkpCMFM0a00wemZ6b0xvTXdMU3VI?=
 =?utf-8?B?YktKZGNFUFBnYWV3K1Z2YWVsS2JZbGoxeGFvUTNZM3U2TlgycHRBL1F0TzBP?=
 =?utf-8?B?Zm9DU1NKUVMxVTZwUS9Wb2VkYkJFWnVLemt0b0VEOEgxU0ErZ1RTUW04UFdM?=
 =?utf-8?B?eUtsNHI1d0ptVytnQXJkSFFVd2pJZkVYOTdsS2JiUG5wejlaNVFIUUtEb0w3?=
 =?utf-8?B?cHhtc0E3Z3dpSUR4OWZjTWo1TE9BS3UxVnlEcHNqTFNiVzc3MElkNVREMEVk?=
 =?utf-8?B?RnZQd1hpUGhOcjJDS1V6NDlsTlFYb3FIb09NVnhyRkl2cGFOeGFuZmFickVu?=
 =?utf-8?B?dkgveHgzVTFwZGZBYnZHR1dRNlhtRXNBTVhqSmI4OWNIRkZQN3JGcytKbnZO?=
 =?utf-8?B?VC9STDQrWXBUTDFzZWN3eWRsUVM3VXpUQWJ0cFVVc1VtYW9VVDlDWVpkOXpj?=
 =?utf-8?B?TVRzMThQU2NJMENxK2NrQUsyZmFqWFBZbzhSOTdYdkJ0UWZmS2s5cUtnV2Vp?=
 =?utf-8?B?VHVWQ1B2b3FnSUk0bUlBdE02bW9zU0pDMFRMTENIUUhVQk1YY3NiZkxwOHYx?=
 =?utf-8?B?b3hNVTlLby95cmg1R0dmMXozb1ZnUllmWkFURVQ0M3d5bHRVVDlEZTNUYzJC?=
 =?utf-8?B?R1F1ekt5TFB3MmplVHVKdEwxRUd3RVhUSTMxdnlqZ2JEMGl2bGtsNEVUOGcv?=
 =?utf-8?B?VGF2TzltdG14NXRlZG01VWtYVXFRT2RmeFNYRmlBaVRkSEo4bTBCWEFOSVlC?=
 =?utf-8?B?RXRyY0crWERpT0NxdTZUSmtWNE5IdEhyRDFPVzBwdndyN1BkbHlvTDRHWlpO?=
 =?utf-8?B?UVd0UnkzY3lWa1dRbkt1eUNSOHdhb3BlTjU5SEVVRVl3SCtGK1p2VWRKNjNw?=
 =?utf-8?B?ajEreUliMTJzVWZXR2FQd0hqYkJ3bUhkZ0xwdTlpR1M0akVZWWRpMmJwTDBN?=
 =?utf-8?B?a1JTUW1jaTlTRW95NVZqdDJKLzJIQVpqSEs2Zm1XM0Z1TkpnaFdCelpUbmtH?=
 =?utf-8?B?UFNTSkFoNzlUZ0VZcGwyNi93ZG1OcVVsNXpEWmJVUGw5T0R3djVJd0dSYy9j?=
 =?utf-8?B?amIyNDJUaFhDeTNxVFJzbWprRzI5RVpHOUFiSDNaQWJHTitJLzdtMHN3eG94?=
 =?utf-8?B?UE9ZUUxSSmpGaUpRMEtQVWlmcDU2UnJEd0V2V2h0V2dWZEpHamxMT3pyZGJr?=
 =?utf-8?B?ZEJxWjRCbFlYZmIxRFMrcmY2bTlSVWkwMFNjVXJwNm52U3g4c0xLZStsdG5K?=
 =?utf-8?B?K3JMVHdGRFJ3NzRpMkVOMWtZVVprWGVSakh4NEtuUGRDejJLbWpTTUlmQ3pw?=
 =?utf-8?B?cWxLNENPZHNXdVlrZ3pDbStEQ2NQNi9GTHhQWUF5L2tHSzBBS1UxK01UaEQy?=
 =?utf-8?B?ZExzQU1hOWs0SzArRS9XYUlvaDlncktjZG9vVUo1bHFpeWFTQ1djaVlFdTJQ?=
 =?utf-8?B?WU5CbjlvdlJCVkVDQ05nWkVkNVYwamRsZjlDK3FXTks5UHQ5aGU0bGxwNVR5?=
 =?utf-8?B?a29KbDhOTjAyL0luVTEyVERUR215SGRscWFSVTRHSm5nc3ZFZm01aUtaZng2?=
 =?utf-8?B?K3RqSzZWKzAzVXpNRFVKaCtJMzBxSzJWMVVmNkpFWHFxczNNUFk1N1FCWno0?=
 =?utf-8?B?dW02ZXlEcmZRRnVXeDRyOHJSWTFRdTFhSlRBay9MVEx4elhYUXZRbTJHZ1U1?=
 =?utf-8?B?QlhwS05jSmJpZTFjWkFqajdINXFzQ2V0ZENRUXJOVDV0TFYwNnB2UDRYbmpm?=
 =?utf-8?B?ejFFUEE3dEZSaGJ3cDMzSHpnQlhndHFDZlZZM01QemdtZFdsU2syOEZGOFJZ?=
 =?utf-8?B?b3p2QitpNzV5N1BRa0c2SE85dHJJZ29OYUtGWk1za0hsRkxvM25YSWdOWGxN?=
 =?utf-8?B?VWpSSm1scFVsdzRnMy9pYmpBRWtBYUVTamdPU2JSY3gwbitISDRJRWEwaytK?=
 =?utf-8?B?czQvc3p5ZDRhSEFhR2RIU1lTeTg0N3NwZ3BtREVqVFAzZitLSldiaHpDd1Ar?=
 =?utf-8?B?WGdnazNIYzVsbEVwZzNJRVVPNXpLRjRCSS82SVZWSGhoSXhZNmtkQ3Q1SnB5?=
 =?utf-8?B?akRCSFN1TTNMTEM3MUtxcjEzWGJBaUlFTmF0QklYczVnRHI5bExac0MrTXN5?=
 =?utf-8?Q?QpBL2AXCUxzS6a8k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D75680FCC48DD044828C10F7CB3C58AD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pmt8mi1Qi05xKZoeD7IHdR8NZSnzNr7tAO2T04O9nlzKMX87nC8BspzrXv21DA5gVmEwqcRrWQ6iJ0LEoFxLWaOBWeYYic7mSdWOx2mzQIE5V1uY99zbPpnHDpiL0cFa07hfnIe03aZ4ZLuWoiMQ/LZdqy/b9RDk6P/vAKnWIYbipNPBNIC+/zhGKOJtOyQBA8majv7DaLAR57n+Ny94b7MMFGMoZTGqRvLUwcriv6ehcXAnJNY2PWMliGnqw3aiogPR4QRNSrJlOoJkDVa0yebUfvRivsAIQlUHmIVrm/cDU0W4dsHbvS2tA15aej8OufxkluZtvLQghiUTk0hoKw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb917772-48fc-4569-42c1-08deb5e72ac3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 20:42:39.2511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ifLF0tLVUjd+r2bHZlW9qCqPhyVth8sic+TLEXdgoOelypQYcr2n5hdAiA8lr4FuEj98XUTeRsbgJjgzDrvAAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4PR03MB9844
X-MTK: N
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk,mediateko365.onmicrosoft.com:s=selector2-mediateko365-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36672-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[Ryder.Lee@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+,mediateko365.onmicrosoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: AFC49584CD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVHVlLCAyMDI2LTA1LTE5IGF0IDE0OjI0ICswMjAwLCBMb3JlbnpvIEJpYW5jb25pIHdyb3Rl
Ogo+IAo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUg
Y29udGVudC4KPiAKPiAKPiA+IAo+ID4gT24gTW9uLCBNYXkgMTgsIDIwMjYgYXQgNTozMeKAr0FN
IExvcmVuem8gQmlhbmNvbmkKPiA+IDxsb3JlbnpvQGtlcm5lbC5vcmc+IHdyb3RlOgo+ID4gPiAK
PiA+ID4gT24gTWF5IDE1LCBDaGVuZyBIYW8gTHVvIHdyb3RlOgo+ID4gPiA+ID4gc3RydWN0IGll
ZWU4MDIxMV90eF9pbmZvIHsKPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIHUzMsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmxhZ3M7wqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgCj4gPiA+ID4gPiAvKsKgwqDCoMKgIDDCoMKgwqDCoCA0ICovCj4gPiA+
ID4gPiDCoMKgwqDCoMKgwqDCoCB1MzLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGJhbmQ6MzvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gPiA+ID4g
PiAvKsKgwqDCoMKgIDQ6IDDCoCA0ICovCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCB1MzLCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YXR1c19kYXRhX2lk
cjoxO8KgwqDCoAo+ID4gPiA+ID4gLyrCoMKgwqDCoCA0OiAzwqAgNCAqLwo+ID4gPiA+ID4gwqDC
oMKgwqDCoMKgwqAgdTMywqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBzdGF0dXNfZGF0YToxMzvCoMKgwqDCoMKgwqAKPiA+ID4gPiA+IC8qwqDCoMKgwqAgNDog
NMKgIDQgKi8KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIHUzMsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaHdfcXVldWU6NDvCoMKgwqDCoMKgwqDCoMKgwqDC
oAo+ID4gPiA+ID4gLyrCoMKgwqDCoCA0OjE3wqAgNCAqLwo+ID4gPiA+ID4gwqDCoMKgwqDCoMKg
wqAgdTMywqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0eF90
aW1lX2VzdDoxMDvCoMKgwqDCoMKgwqAKPiA+ID4gPiA+IC8qwqDCoMKgwqAgNDoyMcKgIDQgKi8K
PiA+ID4gPiA+IAo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgLyogWFhYIDEgYml0IGhvbGUsIHRy
eSB0byBwYWNrICovCj4gPiA+ID4gPiAKPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIHVuaW9uIHsK
PiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3Qgewo+ID4gPiA+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bmlvbiB7
Cj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3Qgewo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHN0cnVjdAo+ID4gPiA+ID4gaWVlZTgwMjExX3R4X3JhdGUgcmF0ZXNbNF07IC8qwqDCoMKgwqAg
OMKgwqDCoCAxMiAqLwo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHM4wqDCoMKgwqAK
PiA+ID4gPiA+IHJ0c19jdHNfcmF0ZV9pZHg7IC8qwqDCoMKgIDIwwqDCoMKgwqAgMSAqLwo+ID4g
PiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHU4wqDCoMKgwqAgdXNlX3J0czoxOwo+ID4gPiA+
ID4gLyrCoMKgwqAgMjE6IDDCoCAxICovCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
dTjCoMKgwqDCoAo+ID4gPiA+ID4gdXNlX2N0c19wcm90OjE7IC8qwqDCoMKgIDIxOiAxwqAgMSAq
Lwo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHU4wqDCoMKgwqAKPiA+ID4gPiA+IHNo
b3J0X3ByZWFtYmxlOjE7IC8qwqDCoMKgIDIxOiAywqAgMSAqLwo+ID4gPiA+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHU4wqDCoMKgwqAgc2tpcF90YWJsZToxOwo+ID4gPiA+ID4gLyrCoMKgwqAg
MjE6IDPCoCAxICovCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdTjCoMKgwqDCoCBh
bnRlbm5hczoyOwo+ID4gPiA+ID4gLyrCoMKgwqAgMjE6IDTCoCAxICovCj4gPiA+ID4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB9O8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gPiA+ID4g
PiAvKsKgwqDCoMKgIDjCoMKgwqAgMTQgKi8KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxvbmcgdW5zaWduZWQg
aW50IGppZmZpZXM7Cj4gPiA+ID4gPiAvKsKgwqDCoMKgIDjCoMKgwqDCoCA4ICovCj4gPiA+ID4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH07wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4g
PiA+ID4gPiAvKsKgwqDCoMKgIDjCoMKgwqAgMTYgKi8KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGllZWU4MDIxMV92aWYgKiB2
aWY7wqDCoMKgwqDCoAo+ID4gPiA+ID4gLyrCoMKgwqAgMjTCoMKgwqDCoCA4ICovCj4gPiA+ID4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBp
ZWVlODAyMTFfa2V5X2NvbmYgKiBod19rZXk7Cj4gPiA+ID4gPiAvKsKgwqDCoCAzMsKgwqDCoMKg
IDggKi8KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdTMywqDCoMKgwqDCoMKgwqAgZmxhZ3M7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgCj4gPiA+ID4gPiAvKsKgwqDCoCA0MMKgwqDCoMKgIDQgKi8KPiA+ID4gPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29kZWxfdGltZV90IGVucXVl
dWVfdGltZTvCoMKgwqDCoMKgwqAKPiA+ID4gPiA+IC8qwqDCoMKgIDQ0wqDCoMKgwqAgNCAqLwo+
ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0gY29udHJvbDvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiA+
ID4gPiA+IC8qwqDCoMKgwqAgOMKgwqDCoCA0MCAqLwo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHN0cnVjdCB7Cj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHU2NMKgwqDCoMKgwqDCoMKgIGNvb2tpZTvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gPiA+ID4gPiAvKsKgwqDCoMKgIDjCoMKgwqDCoCA4ICov
Cj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfSBhY2s7wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAKPiA+ID4gPiA+IC8qwqDCoMKgwqAgOMKgwqDCoMKgIDggKi8KPiA+ID4gPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3Qgewo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgaWVlZTgwMjExX3R4X3JhdGUg
cmF0ZXNbNF07Cj4gPiA+ID4gPiAvKsKgwqDCoMKgIDjCoMKgwqAgMTIgKi8KPiA+ID4gPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgczMywqDCoMKgwqDC
oMKgwqAgYWNrX3NpZ25hbDvCoMKgwqDCoMKgwqDCoMKgwqDCoAo+ID4gPiA+ID4gLyrCoMKgwqAg
MjDCoMKgwqDCoCA0ICovCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHU4wqDCoMKgwqDCoMKgwqDCoCBhbXBkdV9hY2tfbGVuO8KgwqDCoMKg
wqDCoMKgCj4gPiA+ID4gPiAvKsKgwqDCoCAyNMKgwqDCoMKgIDEgKi8KPiA+ID4gPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdTjCoMKgwqDCoMKgwqDC
oMKgIGFtcGR1X2xlbjvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gPiA+ID4gPiAvKsKgwqDCoCAy
NcKgwqDCoMKgIDEgKi8KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgdTjCoMKgwqDCoMKgwqDCoMKgIGFudGVubmE7wqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAKPiA+ID4gPiA+IC8qwqDCoMKgIDI2wqDCoMKgwqAgMSAqLwo+ID4gPiA+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1OMKgwqDCoMKg
wqDCoMKgwqAgcGFkO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiA+ID4gPiA+
IC8qwqDCoMKgIDI3wqDCoMKgwqAgMSAqLwo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1MTbCoMKgwqDCoMKgwqDCoCB0eF90aW1lO8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gPiA+ID4gPiAvKsKgwqDCoCAyOMKgwqDCoMKgIDIgKi8K
PiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
dTjCoMKgwqDCoMKgwqDCoMKgIGZsYWdzO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+
ID4gPiA+ID4gLyrCoMKgwqAgMzDCoMKgwqDCoCAxICovCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHU4wqDCoMKgwqDCoMKgwqDCoCBwYWQy
O8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gPiA+ID4gPiAvKsKgwqDCoCAzMcKg
wqDCoMKgIDEgKi8KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgdm9pZCAqwqDCoMKgwqAgc3RhdHVzX2RyaXZlcl9kYXRhWzJdOwo+ID4gPiA+
ID4gLyrCoMKgwqAgMzLCoMKgwqAgMTYgKi8KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB9IHN0YXR1czvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+ID4gPiA+ID4gLyrCoMKgwqDCoCA4wqDCoMKgIDQw
ICovCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHsKPiA+
ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3Ry
dWN0IGllZWU4MDIxMV90eF9yYXRlCj4gPiA+ID4gPiBkcml2ZXJfcmF0ZXNbNF07IC8qwqDCoMKg
wqAgOMKgwqDCoCAxMiAqLwo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB1OMKgwqDCoMKgwqDCoMKgwqAgcGFkWzRdO8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAKPiA+ID4gPiA+IC8qwqDCoMKgIDIwwqDCoMKgwqAgNCAqLwo+ID4gPiA+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2b2lkICrC
oMKgwqDCoCByYXRlX2RyaXZlcl9kYXRhWzNdO8KgCj4gPiA+ID4gPiAvKsKgwqDCoCAyNMKgwqDC
oCAyNCAqLwo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH07wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoAo+ID4gPiA+ID4gLyrCoMKgwqDCoCA4wqDCoMKgIDQwICovCj4gPiA+ID4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdm9pZCAqwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGRyaXZlcl9kYXRhWzVdO8KgwqDCoMKgwqDCoAo+ID4gPiA+ID4gLyrCoMKgwqDCoCA4
wqDCoMKgIDQwICovCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCB9O8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgCj4gPiA+ID4gPiAvKsKgwqDCoMKgIDjCoMKgwqAgNDAgKi8KPiA+
ID4gPiA+IAo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgLyogc2l6ZTogNDgsIGNhY2hlbGluZXM6
IDEsIG1lbWJlcnM6IDcgKi8KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIC8qIHN1bSBtZW1iZXJz
OiA0NCAqLwo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgLyogc3VtIGJpdGZpZWxkIG1lbWJlcnM6
IDMxIGJpdHMsIGJpdCBob2xlczogMSwgc3VtCj4gPiA+ID4gPiBiaXQgaG9sZXM6IDEgYml0cyAq
Lwo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgLyogbGFzdCBjYWNoZWxpbmU6IDQ4IGJ5dGVzICov
Cj4gPiA+ID4gPiB9Owo+ID4gPiA+ID4gCj4gPiA+ID4gPiBBY2NvcmRpbmcgdG8gcGFob2xlLCB0
aGUgc2l6ZSBvZiB0aGUgY29udHJvbCBpbm5lciB1bmlvbiBpcwo+ID4gPiA+ID4gYWN0dWFsbHkg
MTYgYnl0ZXMKPiA+ID4gPiA+IHNpbmNlIHRoZSBjb21waWxlciBhZGRzIDIgYnl0ZXMgb2YgcGFk
ZGluZy4gU2luY2UKPiA+ID4gPiA+IG10NzZfdHhfc3RhdHVzX3NrYl9hZGQoKQo+ID4gPiA+ID4g
bWVzZXQgdG8gMCBqdXN0IG10NzZfdHhfY2Igc2l6ZSAodGhhdCBpcyAxNiBieXRlcykgSSBjYW4n
dAo+ID4gPiA+ID4gc2VlIGhvdwo+ID4gPiA+ID4gY29udHJvbC5mbGFncyBpcyBvdmVyd3JpdHRl
bi4gQW0gSSBtaXNzaW5nIHNvbWV0aGluZz8KPiA+ID4gPiA+IAo+ID4gPiA+ID4gc3RydWN0IG10
NzZfdHhfY2Igewo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgbG9uZyB1bnNpZ25lZCBpbnTCoMKg
wqDCoMKgwqDCoMKgwqAgamlmZmllczvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+ID4gPiA+
ID4gLyrCoMKgwqDCoCAwwqDCoMKgwqAgOCAqLwo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgdTE2
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB3Y2lkO8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gPiA+ID4gPiAvKsKgwqDCoMKgIDjCoMKgwqDC
oCAyICovCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCB1OMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwa3RpZDvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAKPiA+ID4gPiA+IC8qwqDCoMKgIDEwwqDCoMKgwqAgMSAqLwo+ID4gPiA+ID4gwqDCoMKg
wqDCoMKgwqAgdTjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZmxhZ3M7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gPiA+ID4gPiAvKsKgwqDC
oCAxMcKgwqDCoMKgIDEgKi8KPiA+ID4gPiA+IAo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgLyog
c2l6ZTogMTYsIGNhY2hlbGluZXM6IDEsIG1lbWJlcnM6IDQgKi8KPiA+ID4gPiA+IMKgwqDCoMKg
wqDCoMKgIC8qIHBhZGRpbmc6IDQgKi8KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIC8qIGxhc3Qg
Y2FjaGVsaW5lOiAxNiBieXRlcyAqLwo+ID4gPiA+ID4gfTsKPiA+ID4gPiAKPiA+ID4gPiBIaSBM
b3JlbnpvLAo+ID4gPiA+IAo+ID4gPiA+IFRoZSBtdDc2X3R4X2NiIGlzIHBsYWNlZCBhdCBzdGF0
dXMuc3RhdHVzX2RyaXZlcl9kYXRhIChvZmZzZXQKPiA+ID4gPiAzMikuCj4gPiA+ID4gSXQgb3Zl
cmxhcHMgd2l0aCBod19rZXksIGZsYWdzIGFuZCBlbnF1ZXVlX3RpbWUgaW4gdGhlIGNvbnRyb2wK
PiA+ID4gPiB1bmlvbi4KPiA+ID4gPiAKPiA+ID4gPiBzdGF0aWMgaW5saW5lIHN0cnVjdCBtdDc2
X3R4X2NiICptdDc2X3R4X3NrYl9jYihzdHJ1Y3Qgc2tfYnVmZgo+ID4gPiA+ICpza2IpCj4gPiA+
ID4gewo+ID4gPiA+IEJVSUxEX0JVR19PTihzaXplb2Yoc3RydWN0IG10NzZfdHhfY2IpID4KPiA+
ID4gPiDCoMKgwqAgc2l6ZW9mKElFRUU4MDIxMV9TS0JfQ0Ioc2tiKS0+c3RhdHVzLnN0YXR1c19k
cml2ZXJfZGF0YSkpOwo+ID4gPiA+IHJldHVybiAoKHZvaWQgKilJRUVFODAyMTFfU0tCX0NCKHNr
YiktCj4gPiA+ID4gPnN0YXR1cy5zdGF0dXNfZHJpdmVyX2RhdGEpOwo+ID4gPiA+IH0KPiA+ID4g
Cj4gPiA+IEhpIFJveSwKPiA+ID4gCj4gPiA+IEkgc3RpbGwgZG8gbm90IHVuZGVyc3RhbmQgc2lu
Y2UgbXQ3Nl90eF9zdGF0dXNfc2tiX2FkZCgpIHNldHMgdG8KPiA+ID4gMCBqdXN0IHNpemVvZgo+
ID4gPiBvZiBtdDc2X3R4X2NiLCB0aGF0IGFjY29yZGluZyB0byBwYWhvbGUgaXMgMTYgYnl0ZXMs
IHNvIGl0IGNhbid0Cj4gPiA+IG92ZXJ3cml0ZQo+ID4gPiBod19rZXkgcG9pbnRlciAod2hvc2Ug
b2Zmc2V0IHJlc3BlY3QgdG8gdGhlIGJlZ2lubmluZyBvZiB0aGUKPiA+ID4gY29udHJvbCBzdHJ1
Y3QgaXMKPiA+ID4gMjQsIDMyIC0gOCkuCj4gPiA+IAo+ID4gPiBSZWdhcmRzLAo+ID4gPiBMb3Jl
bnpvCj4gPiA+IAo+ID4gPiA+IAo+ID4gPiA+IFJlZ2FyZHMsCj4gPiA+ID4gUm95IEx1bwo+ID4g
Cj4gPiBIaSBMb3JlbnpvLAo+ID4gCj4gPiBUaGUgbXQ3Nl90eF9zdGF0dXNfc2tiX2FkZCgpIG1l
bXNldCB6ZXJvIHRoZSAxNiBieXRlcyBzdGFydGluZyBmcm9tCj4gPiBzdGF0dXMuc3RhdHVzX2Ry
aXZlcl9kYXRhIChwbGVhc2Ugc2VlIHRoZSBhYm92ZSBpbmxpbmUgZnVuY3Rpb24KPiA+IHNoYXJl
ZAo+ID4gaW4gbXkgbGFzdCByZXNwb25zZSkgd2hvc2Ugb2Zmc2V0IHdpdGggcmVzcGVjdCB0byB0
aGUgYmVnaW5uaW5nIG9mCj4gPiB0aGUgY29udHJvbC9zdGF0dXMgdW5pb24gaXMgZXhhY3RseSAy
NCAoMzIgLSA4KSBpbnN0ZWFkIG9mIDAuCj4gPiAKPiA+IFJlZ2FyZHMsCj4gPiBSb3kgTHVvCj4g
Cj4gSGkgUm95LAo+IAo+IEkgY2FuIHNlZSB0aGUgaXNzdWUgbm93LCBJIHdhcyBjb25mdXNpbmcg
c3RhdHVzLnN0YXR1c19kcml2ZXJfZGF0YQo+IHdpdGgKPiBkcml2ZXJfZGF0YS4gWW91IGFyZSBy
aWdodCwgd2UgaGF2ZSBhbiBpc3N1ZSBoZXJlLiBIb3dldmVyLCBjb3B5aW5nCj4gYWxsIHRoZQo+
IGllZWU4MDIxMV90eF9pbmZvIHN0cnVjdCBzZWVtcyBhIGJpdCBvdmVya2lsbCwgd2hhdCBkbyB5
b3UgdGhpbms/Cj4gTW9yZW92ZXIsIHdlIGhhdmUgdGhlIHNhbWUgaXNzdWUgZm9yIHZhcmlvdXMg
Y2hpcHNldHMgKGUuZy4gbXQ3OTI1Cj4gYW5kCj4gbXQ3OTE1KS7CoCBJIGd1ZXNzIHdlIHNob3Vs
ZCB0cnkgdG8gZmluZCBhIGdsb2JhbCBzb2x1dGlvbiBmb3IgdGhlCj4gcHJvYmxlbS4KPiAKPiBS
ZWdhcmRzLAo+IExvcmVuem8KCldoYXQgYWJvdXQgYWRkaW5nIGFuIGhlbHBlciBmb3IgY2Igb3Bl
cmF0aW9uPwoKK3ZvaWQKK210NzZfdHhfc3RhdHVzX3NrYl9jYl9hZGQoc3RydWN0IG10NzZfZGV2
ICpkZXYsIHN0cnVjdCBza19idWZmICpza2IsCisgICAgICAgICAgICAgICAgICAgICAgICAgc3Ry
dWN0IG10NzZfd2NpZCAqd2NpZCwgaW50IHBpZCkKK3sKKyAgICAgICBzdHJ1Y3QgbXQ3Nl90eF9j
YiAqY2IgPSBtdDc2X3R4X3NrYl9jYihza2IpOworCisgICAgICAgbWVtc2V0KGNiLCAwLCBzaXpl
b2YoKmNiKSk7CisKKyAgICAgICBzcGluX2xvY2tfYmgoJmRldi0+c3RhdHVzX2xvY2spOworICAg
ICAgIGNiLT53Y2lkID0gd2NpZC0+aWR4OworICAgICAgIGNiLT5wa3RpZCA9IHBpZDsKKyAgICAg
ICBzcGluX3VubG9ja19iaCgmZGV2LT5zdGF0dXNfbG9jayk7Cit9CitFWFBPUlRfU1lNQk9MX0dQ
TChtdDc2X3R4X3N0YXR1c19za2JfY2JfYWRkKTsKCkFuZCBhZGQgdGhpcyBmb3IgZWFjaCBjaGlw
c2V0LgoKaW5kZXggMDYxYWI2Ni4uZDBiNjdhMiAxMDA2NDQKLS0tIGEvbXQ3OTk2L21hYy5jCisr
KyBiL210Nzk5Ni9tYWMuYwpAQCAtMTEwOCw2ICsxMTA4LDcgQEAgaW50IG10Nzk5Nl90eF9wcmVw
YXJlX3NrYihzdHJ1Y3QgbXQ3Nl9kZXYgKm1kZXYsCnZvaWQgKnR4d2lfcHRyLAogICAgICAgIGlm
ICghaXNfODAyMyB8fCBwaWQgPj0gTVRfUEFDS0VUX0lEX0ZJUlNUKQogICAgICAgICAgICAgICAg
bXQ3OTk2X21hY193cml0ZV90eHdpKGRldiwgdHh3aV9wdHIsIHR4X2luZm8tPnNrYiwKd2NpZCwg
a2V5LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBpZCwgcWlkLCAwKTsK
KyAgICAgICBtdDc2X3R4X3N0YXR1c19za2JfY2JfYWRkKGRldiwgdHhfaW5mby0+c2tiLCB3Y2lk
LCBwaWQpOwoKCg==

