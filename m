Return-Path: <linux-wireless+bounces-22859-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 344C1AB2F10
	for <lists+linux-wireless@lfdr.de>; Mon, 12 May 2025 07:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3BBE1714FA
	for <lists+linux-wireless@lfdr.de>; Mon, 12 May 2025 05:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB3B2550A8;
	Mon, 12 May 2025 05:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gWHbvPiy";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="aYLd81+U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D7F1AAA2F;
	Mon, 12 May 2025 05:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747028436; cv=fail; b=p52A7GCYr5dnCRlQb0vFt1vP+OBPAVY5HB3cdTwvuBKyaDk58m9IR7Euq503uBkhSKxYbPlidJwCBk9FhPZFylfaDwDpRqZQSJpcjXMj6uTmJx51n/iBstaDguv8wRmoNUFlNkoTZm+Sg60tzDK/8iv1iGTg3bfO22HbC6ClxmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747028436; c=relaxed/simple;
	bh=y81oGeOPGoGwYAIqfPwR8+KC8J7Bp2QxssLhgx/zkyo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HBWEU9505mq6N61iTXCfbpfGM60qReVrv1wAtHCkpxjRcRkYcQF38KBPNcMhPc+OvfGNuLvFMa8swq59QoXqDhNP0iE56GLucxwm4Yhb48A6wrxZ2vx73996NMkWMchO+zfHwdWKeUDDYoup8NMi2r6CVISKrPEyfIehUgeOrnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gWHbvPiy; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=aYLd81+U; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9c28db822ef311f0813e4fe1310efc19-20250512
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=y81oGeOPGoGwYAIqfPwR8+KC8J7Bp2QxssLhgx/zkyo=;
	b=gWHbvPiyPoBNygvfE+DxQRfh00GCROhaORxXzHtbIv7r1DY+5cJ0jRsQndSoQqY6EtTWP3C6rumKryhOJFBAhcBj1pt2ictQJCEEkV6Xs8vUqJlQk4SND7ZggTyfmxhIM+bVcaVCDhn6C/TaolO9uwUcaaPbzMDt5dIe2kiqPDY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:db587792-74c6-4119-b05a-70071bf9169a,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:1a32dae0-512b-41ef-ab70-9303a9a81417,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9c28db822ef311f0813e4fe1310efc19-20250512
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 260387345; Mon, 12 May 2025 13:40:28 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 12 May 2025 13:40:26 +0800
Received: from TYDPR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 12 May 2025 13:40:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAdRZsT7ZbbjxOBUTDrMP8aISGhH+LT0LnM7eG5lEgcMPy3QPRB+SYplyLbjT1wzl4tM46mMJnGEj42MwHktwtqj1Aw0vV3uKS6A2/fFhHgZnANQyvTXEio7Z/tZF/WTvEQPaYxz+RT91/INyghirHsOSgQrmGANQxrqliUgGGXnrNY3rz+dgNny+vorCTy3BstIQSBqYgg8AjyaSx3m9FaKSghLNFknkARW5fgTltFwaffcG5amn7LjVLvLuWFKC6usKUlRU9duoibrsZ1boXRRYSjcFJ+Sa4fo//cCJiChpjCIeMgR4YhwkNeEiyV0HbhSeWSa7HrqgYZKYSI/jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y81oGeOPGoGwYAIqfPwR8+KC8J7Bp2QxssLhgx/zkyo=;
 b=Z+jpkdBYJrwgIMOUNFRi+Xniqv0ZS+ULGYZyI3nz0U9mjpGQt6QGsmEwVe30cSkXdEojXZBE3ilMKTCm9ug0jCQttUOyxZLArfNwtoOaRVboRbZDsqFw+yUY0GlPHVqc6Y2kyEJa+y2tsDmljP0PGovzGAV5MrF0IZ+xQKl/Z3b+VEwi797umCmBDhBsVb+LXHkNgWYU7C2sSDFcHBMjBf0Kc7YcLAaMdGSWpoz6qBY7N6gGrCWQ7K6STreczGxSknzj07EuhDjVawRShE72zAEZjWve+tfk/R+2ePm/ihLeLPheaft/34x6AmFhw/IUN4hw7eaw5funx+CpJQW48g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y81oGeOPGoGwYAIqfPwR8+KC8J7Bp2QxssLhgx/zkyo=;
 b=aYLd81+UgaAIeADwLK1daGq9GTOWC73lImgYCH/GE0nzxamOGU/o3J3CqTMjGyY1X2qGfd4bVs7oWdexgx802S9eraOnBitnZyH2D+vy5wCdT4jMmewyELexJOiryJw/uFeTUfUWe69C0XDJNvenAoGVMQtr7z3lzEEExbwwNoU=
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com (2603:1096:4:ef::8) by
 SEZPR03MB8443.apcprd03.prod.outlook.com (2603:1096:101:222::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.29; Mon, 12 May 2025 05:40:24 +0000
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741]) by SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741%6]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 05:40:23 +0000
From: =?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
	<Mingyen.Hsieh@mediatek.com>
To: "nbd@nbd.name" <nbd@nbd.name>, "lorenzo@kernel.org" <lorenzo@kernel.org>,
	"pchelkin@ispras.ru" <pchelkin@ispras.ru>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	=?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>,
	"jdamato@fastly.com" <jdamato@fastly.com>, Ryder Lee
	<Ryder.Lee@mediatek.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, Sean Wang <Sean.Wang@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH] wifi: mt76: disable napi on driver removal
Thread-Topic: [PATCH] wifi: mt76: disable napi on driver removal
Thread-Index: AQHbwv+8u3GtsxI97keUnhMBbzQXVbPOerOA
Date: Mon, 12 May 2025 05:40:23 +0000
Message-ID: <03c357a6054c31bfdca8ce5e87b74a0f0c1da3bd.camel@mediatek.com>
References: <20250506115540.19045-1-pchelkin@ispras.ru>
In-Reply-To: <20250506115540.19045-1-pchelkin@ispras.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5322:EE_|SEZPR03MB8443:EE_
x-ms-office365-filtering-correlation-id: 392f1554-a897-45dd-b203-08dd91177dc3
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UHVHaFNjQW9yNUY5MEpvcE5KVDlxbkM3RVlQamFWenN0RklDTklWMVZNMTYr?=
 =?utf-8?B?bXhKMDZmQXA4RHdLWk02Sm1vSlBITVFzZXZyTjhLSXlldDlNc3dkWEE1MGl5?=
 =?utf-8?B?bVBaa0MwTERhNGhJcVVMbjI1bzBTYTdaTEJ1UmhDV0NJTXpQWGpiSENVWjg4?=
 =?utf-8?B?NC9tZnZKbEJPTTQrb1pXOXVpSEk2VTJyQjZOeEZWM3JQNEJIczJiNERQRzR2?=
 =?utf-8?B?NUpuRjF4dWgyb0Y2R0pGekFBeEJUTFBLMVNSVmFYU0NiOStPMGJ5cDBsaHl3?=
 =?utf-8?B?QzV2dUh2dVhoZlVWY0VhbFJUZ2pmWGlsSnYxRlFOS3RlY1psaWlvdVpnU21C?=
 =?utf-8?B?SzhhOGUxNWMwa3l0bFhmMmFVdE05RFJUQ0EzUERCVnpxZWtFZjBFcVhFYUVO?=
 =?utf-8?B?WldVOWRpcnhiZkltUFhXNE9admFqMkJUNXgzcnFYdTZzQVlCbWp0WnB3YjMy?=
 =?utf-8?B?dmxiWkphNEQ3SzUyV3U5ZGVvcmlOb0dyQlBaSGhqOXBwMElTUEE0VlRmUVRV?=
 =?utf-8?B?L3FNK0h3OWNHWFcxQnBMUG85elc2UVIxcTVGdXN4QmtBY3NYQUE2WmlRT1VX?=
 =?utf-8?B?TUt5dXE2VFNUVGZzYWF4ZHUrRTF3VkZGR2lhVlNVQW5LbFh6Z1pEQjBoZkJB?=
 =?utf-8?B?STlpZFhMRVBML1ZZOW1FTEwxOHdWZUU1ZXd1VStYWXZUQTU3em9MckVPQlVJ?=
 =?utf-8?B?RFNkQ0htM0lHM1pyZjluZitCcllnemJOUWcyVXl6QVZNa2VPMFRQYWtFUnFq?=
 =?utf-8?B?TWlXV0M4aVlkeXRWYU5WWjB1dExGMk1RR0hYWVNmUHhRN3V2N1dBV1dQbW9F?=
 =?utf-8?B?aUVKZmRxbzhSd1YwRjNKWnlUeWhaOEdkQld1R1VDNUNma28rbmhIOVVqblJk?=
 =?utf-8?B?TVFZL2xVNlc3bDkwRy9oeW5BZ042RUxGS2ZVK1JmWmd2cnpDTU9VN01sNzZS?=
 =?utf-8?B?bDUwMmRGaWlUMklrV1krM21tMW4xMHZodHhuVnY4Ym1uMmFzWS9aa0JMR0Ny?=
 =?utf-8?B?a2hLYVRCRy9XbDVzUUFLdlZtK05yeEhrSEhRWStVSUhLemFKNkJqbXgrdkdo?=
 =?utf-8?B?SkQxd1IyWnY0azhzcXRqdmFFd0V4bUtqc01SQm0xbnZEcmhxNldTbnllZEs2?=
 =?utf-8?B?N3NrM21qMjZTTUJyU0dTUVAvb2dMNEZrZGJ3aWE0T1oyR2dPUDR5cmdMNWhK?=
 =?utf-8?B?bXhXZGt2MlVReGxYeituWWRkL0x2VWp1MUdPS2dMN2ZKUTBrQnZsM2gvUHNU?=
 =?utf-8?B?Zyttd01Ud21Ya0tNWHFBMXhyTHd3UFcwVHd4YWVYUXNleWJvSjErL3lFcml6?=
 =?utf-8?B?M0RHZXRGODhiZTFQL21jWHQzYTQyaWNpRWNEdnkyRzVGOG4wdUYwTXY0SzNa?=
 =?utf-8?B?NWM5M0hkMFZDY3k1MzdFaDVSb25CVWs1ZFJLVEF2bXNYUGgzaWl3Z0dtZkZz?=
 =?utf-8?B?b3cycURuTlBZbUt1KzlMQjZudUpxbFczOE9EQjVrdk1CTEFneEtaNkhONzFY?=
 =?utf-8?B?U2dzanQyRnJobGJ2OVVWZ3JhL3hiWkQrdW12eXNaUmNyc3VwZkg3OUVaRTk1?=
 =?utf-8?B?MDJ5VWsyYU9SZTN5NkNhSnJKWng1a3NaV1RQMWZ6UVFRVGhTdGlrTnFNSjE0?=
 =?utf-8?B?ZVdsa3JGQkkweTc1MGRhbFZ4aXk0TnJpMEFncmgzRGlLQWxER282MUphZGw5?=
 =?utf-8?B?cGRYZHVqR2pEWFNOemFWR0pFMzBWSEpFWW5qdTJnVkU4dGQ3c05td2NMTUdo?=
 =?utf-8?B?VWQwOUgyQzFZc3RWQVp3K2IxMnBpVEdhcVBEd3ZRRGsxR3czc2I2OXlPU3RM?=
 =?utf-8?B?TGtNZjdtT3BRcjBWT0U4azNHQTlBbXl3eTNMZ1dUV3Z6Q1pid2Y5L1JIWU81?=
 =?utf-8?B?M1F6YlNGbkJnV000YWtlbzBHMFlGdmlhbEFsNnZnMFJTTy9NN2lKbUl5aEp2?=
 =?utf-8?B?bU5SRUdtUEpwc0hLVFBoYXUvSmNuNUVPcW9CRUN5SnJpR3AvenVsR2ZLcXpy?=
 =?utf-8?B?SmoyMmEvV3JRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5322.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXNGby9hMjJvRjMzZHdyYXlhYysrUTFxSnhXOGpLZXlkSE00UUExdlhQb0Jt?=
 =?utf-8?B?M0tML1B6eHkremlIOWtCR2NtSGNISE1ETHRqRnhSOExFck5rZnlYeUZvd2Vo?=
 =?utf-8?B?QSttcHRreWh1Ky9IZmdrL2FrZDRhVmhXTE5XaytyVkFxbnBObEV1V3J0dHds?=
 =?utf-8?B?cnd0cXYzZ1lGYm0zck9sVDFEUFFDQUZRQkV4MFdEZUViMUhYUCtDb1A0V2p3?=
 =?utf-8?B?Q0Z6RW1wOGI5bHg0Y05WUUEvZzlkR3lxSmc1ZGl6QmRERnh5RmNvTXZVL3RT?=
 =?utf-8?B?OW9TOWxNNEN6RG9naE9GTUN1OFJRcWJVRkpreTZsYWN2eDR2NWxQVitBUk9s?=
 =?utf-8?B?Z1Nub1NEdmhUckxPdFVXZzJTb1hGL0hwenloNEE5WE9FN2NYTktEWHJOZHY0?=
 =?utf-8?B?blU1MGJSdDFpZGIvUTBTMzhOWjZMOUx3TGwwbkp1OGQ4SXA1djdHV2ROWFNG?=
 =?utf-8?B?OE5jR2lCQkRDclpZbW1OcHo3MFNaZGpkcjlwbkhIenJXNXZnYnluYXBnc1Bn?=
 =?utf-8?B?R256VzBmT1VueURpOFpRejFKTSt5NExXb1VrVGE0UThEVFhPVzEyTVMySzVH?=
 =?utf-8?B?RnYvM0xNSmFadjlCdzdXRTZqRVVGd0huNU9VZFpBQitBd21QMVJRdG5Eb1lP?=
 =?utf-8?B?czlDT0IyVlcxNlVtSVVKM0EyTCtpTm1XSE1HUVNMR3V4SkxEZHBqaVZsVFVx?=
 =?utf-8?B?azRWMFNBQnpPVUx5ZFVZMmZSVUkyT1ZwVk90ME9za3ZVSGtrdnFYNmFaK09Y?=
 =?utf-8?B?SW0yeUw4WEJudHZudC9FcVZTdWVNUEhzYm5SWDZlMVVKSEUxbjVyQytqdkRD?=
 =?utf-8?B?cjlrQ3ZMUjh1RTZkSm40Qk1mTFdkeEt0bHJRc0VNbWdYTERGdFk5VTVBQnFL?=
 =?utf-8?B?VHFKMThyY3RaWDF5ZXFkdGJpOW5zUmNuR1AzVTM0TkF4U3RhS1Y4eUppbitq?=
 =?utf-8?B?VGNTU0VXWFJua3QvRUhidy8yYVNDdWJsbFJpNWpQYWJNN3RXNHRNVkF1VHFW?=
 =?utf-8?B?cjltdC9rVFE2MVlPYnpObDY4OWZ6TkhZTXVCRUl4U01OUC85OHNmdmVtdmJh?=
 =?utf-8?B?bXhtbEw5ODdZdUkvMndTL28zYmJJZldHeERuSS9Tcm9zSVYzS2o4TlJ0OXhh?=
 =?utf-8?B?UW1RYnpsWHUzcTF1ZFlsTmo5anFjS3IrMW5rdWFkNUNyY0xPYk50MGFZTHVv?=
 =?utf-8?B?d1Y1RVMzVElRc0lQVkJSRzE5MzA0OUxTQWJQa2RoNTVEcDRWaFF0NTc4Vkhv?=
 =?utf-8?B?MWZXQjBHSEE3UThqdk5nM21jT21TQTIrL0lTYTYybmhJWFQvUVFiTC93R1pC?=
 =?utf-8?B?OWJpeTlMc3V0eklTaGJIbENFY1NzLzhaOFQ2c2ZyaGJ1cFRlTjk1bXk2bmcy?=
 =?utf-8?B?WkpYUVlWZE1Md1JaR2V2azdOSG9SdjRZRFZ2VWNsOGJxMFV2NUNvTkoySVhp?=
 =?utf-8?B?ODJDWkJUQm0zbDNNMmhoOVZmTE1Qb3lzQk9sZU1yTzA2TDZtMGhtLzRWNFFp?=
 =?utf-8?B?VXNMSDF1SVVUemIzaGdqK1pCdFMzV2FjRkVwUzFHVStLbG1yeFQxQUJwN2Rx?=
 =?utf-8?B?VFI2MHJWYXMrT0dzdGZhR2xRTnJBN1hWNU1kQ3U3b2ZNbWpXSUpmN1JUY1Bs?=
 =?utf-8?B?RDhmQjBQMHhpbmxUc2FUMDBXbC91YWdVeng0amY0SWFtdnhzTnViYWppbXAv?=
 =?utf-8?B?ZFUzemRvdDZrcGtnR3U3dEVMeGhrdVNDODI0dTNWQW4vVmpyNWo0dDJJakYy?=
 =?utf-8?B?a0FTZjMxbVdiZUZyR1I1b0lXUklXSEoyU2FOUE5jLzRzK09rZ3UxL01vbEFh?=
 =?utf-8?B?UFVsek1oRjFnT1hTbHNiRkNNYUU0bmY2WGtGL25XeDhpaTlhR050OE8vckQ4?=
 =?utf-8?B?Z1BUMmxuNjI2cW8yazB2YzdWNVl6bUVJMnVDNU9pM3BqVkQ1bUtydkFNa0dy?=
 =?utf-8?B?YTZCZDB3YWJ5UHdra2NlMWUvb2tyM0xkalRER01INHdWU1AwTkJtTHRWREdJ?=
 =?utf-8?B?dGV3Tk5kSlpvRmY0ME5JdjVMVEdqQkl1UXBNVFF5VmlCaEJoQ0Q5K2VxV2tC?=
 =?utf-8?B?Kzk4cG1ZK3loMGhhKzZ4Z1NzRWsyN2hJVWgvdXhtWDBxWUZydnphNmNqcGNx?=
 =?utf-8?B?VlRUUVgvQVhLbVQ5N1oxUGpwa0szbGZ2MDJyUmUvQ1NMaHFkMUFVc0NKcit0?=
 =?utf-8?B?anc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3600B2B19522044AA2C9D33E624D17BC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5322.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 392f1554-a897-45dd-b203-08dd91177dc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 05:40:23.6329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fDZ1qs0wexW3VhS5jU05LJDI0Fxtn1PyrYPIq07jOryCiKCZ3SLW2FH5D8V8xbFOEWET11oLBLbnaL5K3fnotkaL8akBnjmm05/Z7XIy1ms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8443

T24gVHVlLCAyMDI1LTA1LTA2IGF0IDE0OjU1ICswMzAwLCBGZWRvciBQY2hlbGtpbiB3cm90ZToN
Cj4gQSB3YXJuaW5nIG9uIGRyaXZlciByZW1vdmFsIHN0YXJ0ZWQgb2NjdXJyaW5nIGFmdGVyIGNv
bW1pdA0KPiA5ZGQwNWRmODQwM2INCj4gKCJuZXQ6IHdhcm4gaWYgTkFQSSBpbnN0YW5jZSB3YXNu
J3Qgc2h1dCBkb3duIikuIERpc2FibGUgdHggbmFwaQ0KPiBiZWZvcmUNCj4gZGVsZXRpbmcgaXQg
aW4gbXQ3Nl9kbWFfY2xlYW51cCgpLg0KPiANCj4gwqBXQVJOSU5HOiBDUFU6IDQgUElEOiAxODgy
OCBhdCBuZXQvY29yZS9kZXYuYzo3Mjg4DQo+IF9fbmV0aWZfbmFwaV9kZWxfbG9ja2VkKzB4ZjAv
MHgxMDANCj4gwqBDUFU6IDQgVUlEOiAwIFBJRDogMTg4MjggQ29tbTogbW9kcHJvYmUgTm90IHRh
aW50ZWQgNi4xNS4wLXJjNCAjNA0KPiBQUkVFTVBUKGxhenkpDQo+IMKgSGFyZHdhcmUgbmFtZTog
QVNVUyBTeXN0ZW0gUHJvZHVjdCBOYW1lL1BSSU1FIFg2NzBFLVBSTyBXSUZJLCBCSU9TDQo+IDMw
MzUgMDkvMDUvMjAyNA0KPiDCoFJJUDogMDAxMDpfX25ldGlmX25hcGlfZGVsX2xvY2tlZCsweGYw
LzB4MTAwDQo+IMKgQ2FsbCBUcmFjZToNCj4gwqA8VEFTSz4NCj4gwqBtdDc2X2RtYV9jbGVhbnVw
KzB4NTQvMHgyZjAgW210NzZdDQo+IMKgbXQ3OTIxX3BjaV9yZW1vdmUrMHhkNS8weDE5MCBbbXQ3
OTIxZV0NCj4gwqBwY2lfZGV2aWNlX3JlbW92ZSsweDQ3LzB4YzANCj4gwqBkZXZpY2VfcmVsZWFz
ZV9kcml2ZXJfaW50ZXJuYWwrMHgxOWUvMHgyMDANCj4gwqBkcml2ZXJfZGV0YWNoKzB4NDgvMHg5
MA0KPiDCoGJ1c19yZW1vdmVfZHJpdmVyKzB4NmQvMHhmMA0KPiDCoHBjaV91bnJlZ2lzdGVyX2Ry
aXZlcisweDJlLzB4YjANCj4gwqBfX2RvX3N5c19kZWxldGVfbW9kdWxlLmlzcmEuMCsweDE5Ny8w
eDJlMA0KPiDCoGRvX3N5c2NhbGxfNjQrMHg3Yi8weDE2MA0KPiDCoGVudHJ5X1NZU0NBTExfNjRf
YWZ0ZXJfaHdmcmFtZSsweDc2LzB4N2UNCj4gDQo+IFRlc3RlZCB3aXRoIG10NzkyMWUgYnV0IHRo
ZSBzYW1lIHBhdHRlcm4gY2FuIGJlIGFjdHVhbGx5IGFwcGxpZWQgdG8NCj4gb3RoZXINCj4gbXQ3
NiBkcml2ZXJzIGNhbGxpbmcgbXQ3Nl9kbWFfY2xlYW51cCgpIGR1cmluZyByZW1vdmFsLiBUeCBu
YXBpIGlzDQo+IGVuYWJsZWQNCj4gaW4gdGhlaXIgKl9kbWFfaW5pdCgpIGZ1bmN0aW9ucyBhbmQg
b25seSB0b2dnbGVkIG9mZiBhbmQgb24gYWdhaW4NCj4gaW5zaWRlDQo+IHRoZWlyIHN1c3BlbmQv
cmVzdW1lL3Jlc2V0IHBhdGhzLiBTbyBpdCBzaG91bGQgYmUgb2theSB0byBkaXNhYmxlIHR4DQo+
IG5hcGkgaW4gc3VjaCBhIGdlbmVyaWMgd2F5Lg0KPiANCj4gRm91bmQgYnkgTGludXggVmVyaWZp
Y2F0aW9uIENlbnRlciAobGludXh0ZXN0aW5nLm9yZykuDQo+IA0KPiBGaXhlczogMmFjNTE1YTVk
NzRmICgibXQ3NjogbXQ3NngwMjogdXNlIG5hcGkgcG9sbGluZyBmb3IgdHgNCj4gY2xlYW51cCIp
DQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IEZlZG9yIFBj
aGVsa2luIDxwY2hlbGtpbkBpc3ByYXMucnU+DQo+IC0tLQ0KPiDCoGRyaXZlcnMvbmV0L3dpcmVs
ZXNzL21lZGlhdGVrL210NzYvZG1hLmMgfCAxICsNCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRl
ay9tdDc2L2RtYS5jDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9kbWEu
Yw0KPiBpbmRleCA4NDRhZjE2ZWU1NTEuLjM1YjRlYzkxOTc5ZSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9kbWEuYw0KPiArKysgYi9kcml2ZXJzL25l
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L2RtYS5jDQo+IEBAIC0xMDExLDYgKzEwMTEsNyBAQCB2
b2lkIG10NzZfZG1hX2NsZWFudXAoc3RydWN0IG10NzZfZGV2ICpkZXYpDQo+IMKgCWludCBpOw0K
PiDCoA0KPiDCoAltdDc2X3dvcmtlcl9kaXNhYmxlKCZkZXYtPnR4X3dvcmtlcik7DQo+ICsJbmFw
aV9kaXNhYmxlKCZkZXYtPnR4X25hcGkpOw0KPiDCoAluZXRpZl9uYXBpX2RlbCgmZGV2LT50eF9u
YXBpKTsNCj4gwqANCj4gwqAJZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUoZGV2LT5waHlzKTsg
aSsrKSB7DQoNClRlc3RlZC1ieTogTWluZyBZZW4gSHNpZWggPG1pbmd5ZW4uaHNpZWhAbWVkaWF0
ZWsuY29tPg0K

