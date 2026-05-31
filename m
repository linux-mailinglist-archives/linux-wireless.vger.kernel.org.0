Return-Path: <linux-wireless+bounces-37209-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CT/OMJwpHGrpKgkAu9opvQ
	(envelope-from <linux-wireless+bounces-37209-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 14:29:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8216160F1
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 14:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17E19300BD87
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 12:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE2437BE71;
	Sun, 31 May 2026 12:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="puW1gHjh";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="iyeImyE0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E04364EA5;
	Sun, 31 May 2026 12:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780230552; cv=fail; b=epqs1CXmUivMEs26zeM8Jn7kHmdtDd9Ef1z0xjiNSHrOXckuLvijb9Dvonff9+0N3nxBP8rUfp6j6hIwc017u7MSdGUHIUO2MqhSGE4c15teJPhNyv/S7E4vktgLEaZYGio8Im+2XKeo6eCGxQEp3FaefyJFzoc3AFDsQuex2co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780230552; c=relaxed/simple;
	bh=uzYzE0G9W4XQmFyubOmaSfwbSngOWwwelec7g1wMbQo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mz4vwclQd3j56kgi1T9NBP8C6FoMGGzdUmgegiEfVnAlWxA8wsEYlVBc/gBDPJKwo+DAs8Vzm6PQJ8Ur9B8pk14iSDX8elx97NGCPKFKso03NZVFkfdD+HHeqSJGk56uobFd9jd9fEnM4lEyGOS/pQ76fZlXy603eP50XVxsWzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=puW1gHjh; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=iyeImyE0; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4e658d645cec11f18dc8c9802ae25ab1-20260531
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=uzYzE0G9W4XQmFyubOmaSfwbSngOWwwelec7g1wMbQo=;
	b=puW1gHjh2uhx229o+q0omeOYOKIWuDAoKB1sX3rDa62KXIHpmZ8qMH0oo7Cym0JXdtn681cTkr0gZBZzSdeGOqWVhbQALUmHhNsLtBL//X0LwQWgyLPAXvR8/rr3moTaibvL+e9PyFuF0zt/cnjhSjyqI3Ld+zKbotnnVNSuido=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:18e558b9-2f61-44b6-8c43-174bc8ef0142,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:de837f30-3aec-4081-ae32-d2e919a47e1d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|136|836|865|
	888|898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:ni
	l,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4e658d645cec11f18dc8c9802ae25ab1-20260531
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1683539538; Sun, 31 May 2026 20:29:02 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 31 May 2026 20:29:01 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Sun, 31 May 2026 20:29:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XvUGCEieAV9OsFQwMvuKgtdmiQgr7ZMBoO5a920vkOj66HoNP+cqY8T2en8WIqJ7hCV/HksiTO1WnmcEet/8qBGag6OUTd+lU3weeoyyzp3wj+H+zIsnmqQnoznCxNcW7je2jWT1/oGkXOj7ggcGJrUh6XXUE/8EbLzgqNM/56ieTwrcUix1ffK2LS1B+79GBXNP7b0SdX2pcdZuNB9dplTY+Gx14CViD35XFBbvAVKA70vEI+OE6+R+W4Ig66XiieieFbFB4XAYJio77IRXGNayRlulPEWfsguXLmsqwWOOPYivPobp2ZkQEYLI9ipLjW4P2ZN6l+scnG4A/CHqBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzYzE0G9W4XQmFyubOmaSfwbSngOWwwelec7g1wMbQo=;
 b=RTAU1GM/4sSTQ84wzRvxYniVTjiMg/0/Bj4t/ux/cj8T8zCTuJEexg1KLmPhMsML/J5/W8mPttWw9rldDpiPU4D5A+MSXA/FTjN5GQeigFrdlIzfOkst9rUrYAxOjp5X5XDKE2Ma9DH0rN1P8qm+IqZlLN25dtwrImwmBds16eQyL6wMpO4Cd4w6wf822J7gagos++R+Ry0EF0Uax0vg024HUDzD27QQeRjnkzGkhTmZ7dEEzFBAkJFFK28chMEm9Pq0D6em3eRzpFG9jljnnSuZYiQ8F67e41Cgq36fCJ8xV3ylgT3TZYdnZRgMgvF4VV2bIDib8WAAx9OxPfctEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzYzE0G9W4XQmFyubOmaSfwbSngOWwwelec7g1wMbQo=;
 b=iyeImyE0TIPXOzJ58mBR3GCMYwxgB6wRFD0RYZpa9mPSITDM0mNMiGHhqgAx1uUIjxOjMjA2ZdLedyJCgPX/eJUKEo19/uTtuqtFyDinOog2DHM00qDcU+P1nxFDLlWjPgVC2wTe2l4V4amGMXEis/a7oOMmyJ37WpFPcrCJNNw=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by SEYPR03MB9705.apcprd03.prod.outlook.com (2603:1096:101:300::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.5; Sun, 31 May 2026
 12:28:56 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059%6]) with mapi id 15.21.0092.005; Sun, 31 May 2026
 12:28:56 +0000
From: Ryder Lee <Ryder.Lee@mediatek.com>
To: "lorenzo@kernel.org" <lorenzo@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>,
	"nbd@nbd.name" <nbd@nbd.name>, Roy-CH Luo <Roy-CH.Luo@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?Q2h1aS1oYW8gQ2hpdSAo6YKx5Z6C5rWpKQ==?=
	<Chui-hao.Chiu@mediatek.com>, Sean Wang <Sean.Wang@mediatek.com>,
	=?utf-8?B?Qm8gSmlhbyAo54Sm5rOiKQ==?= <Bo.Jiao@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: mt76: mt7996: fix reading zeroed
 info->control.flags after mt76_tx_status_skb_add()
Thread-Topic: [PATCH v2] wifi: mt76: mt7996: fix reading zeroed
 info->control.flags after mt76_tx_status_skb_add()
Thread-Index: AQHc8NtWBQF4NsneqEql9Op9RanVZrYn7TOAgAAeR4CAAATmgA==
Date: Sun, 31 May 2026 12:28:56 +0000
Message-ID: <44c54ed4da0d294c567b3b0ad750f082a6f1be9f.camel@mediatek.com>
References: <20260531-mt76_tx_status_skb_add-overwrite-fix-v2-1-b73c4b4a9798@kernel.org>
	 <ee0e584cb2ad1b536d327eb89342d1646fa96570.camel@mediatek.com>
	 <ahwla_obwnwr2cZo@lore-desk>
In-Reply-To: <ahwla_obwnwr2cZo@lore-desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|SEYPR03MB9705:EE_
x-ms-office365-filtering-correlation-id: 54c23d4e-fa04-4f54-bf27-08debf102f58
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099006|6133799003|11063799006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: Q679kt3A+tv7kEoVjv/dHK8uTl8xgLoRg8lLAUiFarLYuVJ8ar11JHK2YKjk+kKSmXMmhLAVKOv9jUM4Rg8Hrv0AjYK7bPcbMayQ2S8Tz3TnAHDodqJ3w1yXacPHVpR55F0G+SzhRAgHXV9JM3fWcdCEHE21zp4jSwO5fD5/O6lnXKl8PpBo5bUq/nSfstF74uiQi8vaKfOXEJzIiHhxnbukxwiiXO9dLkLijiqkvFSGAeGn/TPUf8mLl6XoIQ3pThMuyRmMZ+yoZuThizPDxDWdfi3TdIfVyBej+Mfi9QbpyOk5VdY5D59X9kw8IjE2F1bFTaUcatUqm/z9iXC21gKuNS6SmrxW66nzXRGJZfz/Pc3sjGSlBG3D4pFgHca1+kXVZ1D/FBrWg8h6ZHdJnQrtBm34Re1k+hTF7zbJTJg8yRs2DJVSaSoAW14bEOhm6CT2W+vCeRC0R5FieKWsBGj1s6NK1BZlXeBh9if1/LBSTGCYcaEDJg14wC7kC1TsJJkV0AXpoP/7Ab1Gew20QTd3juLDhDS8K6ThGufAdY84ZaDjxpHnPM3uSMM1P3ecgC8oAqJuf2Rd4mv+Fc6HzDbHNIIq/AdxNtlzAmwCgfRDeouqRNII+JLkTKNXQfcLmOpGNJ1k1nkhcRIaKqJ4Pv9Y8jBBl0iPDFekpar679bqgMoRa0ElN2t/mnufREh1jco0tkCKtAyzSsxS7MdNltRXfpEOXD9PV/v9RjOm3+fYX7oNh03FLI0Z3w/ju6C8oZBdsFKheaoorIofo9xdBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099006)(6133799003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M05QdGdGYmlFRHY3bnA4THRqdmJLa2NiL3I4MWR5bityeXBxOTFFYkRkQzR3?=
 =?utf-8?B?TGw1VXV1MStUdHBwZ2lER0U1QysyQTgvWnVTOGYzWGkrSmVrSXJYUlFqamFa?=
 =?utf-8?B?WExabzRVQXU4dmcrdEN1V0NLMmQ3SHRGU2MvS2lPcUovTm9MN3VPMVNaeGhC?=
 =?utf-8?B?QldJMnVhaU41Mno0cGp6UUpvellRUnFnS2NFY01Sd210SHlPT2NSbFA4QTRQ?=
 =?utf-8?B?L2FaVDNqOXk3U1NZcFRZbEdFSDlhZkhLSVU5R203NXR1RTMzUDNpNjhHeDF1?=
 =?utf-8?B?dzh2QkxHd1lJMWhPUmlRQjNBbFVyT0s0WnhEKzdpV0dZaERvRGhWTWU1VWdX?=
 =?utf-8?B?aXZkbm12K09sYkk3K0crTFRTR2pSaldrZzFLNk1vK3hsdUxTMVpaYW5BTDQ3?=
 =?utf-8?B?V1dEV2ZLM1N5WFZoWWx0Nm40SzFEQkxLYVZ2STQ3aUhXUUJWeFFSenFPMVZr?=
 =?utf-8?B?N3BudlJweU9tM2dUcXkzallMRjVOQ2g1Tk1qMHZFK3ZydEtBTlFjOE4vY2R1?=
 =?utf-8?B?U0xpRFBaek9kNlZuYTcvNGprMTN3OG9PajcrS1Z6MUpDR1l0QlBMUlp2MW5J?=
 =?utf-8?B?bisvNEpMS080TkxPazhtV0ZoelV3NjhkMlBVbWFMcXlOQURmb1ZEZURTR3Zk?=
 =?utf-8?B?dTBmQ1h5N1BuNkU5azg5K0dKZ3pZdlZxdnFCWjZYdGNVZFlpS29JamsxWTFy?=
 =?utf-8?B?NnpDMmRIUC9hZFFxblA1Q25wVlBzTVh6MWt5LytmdlBqcUlZdDNueGVWdWNE?=
 =?utf-8?B?aHN0S1lZYzJHQWxVbzZIYVRQUFRsOXlCblBwZWRoR09sUENxNng4eFpqVkl2?=
 =?utf-8?B?U2trSjFmbGtpY0FTVjVHT3NtQUQ5d25KZ21oSnhudFB3NmZvVExtbGJ2OWZv?=
 =?utf-8?B?bEh0K3RaY1pZMFlwZjdTYzcvVTh2UGZscmF1bUorZzVLOFJiYzE3WEYwYnBv?=
 =?utf-8?B?aU1LNlhuL1IvMkF5a1pjdnI4MjE2TzJqNE4wUE9mWnl3NVY3cEE5RmpQSWJv?=
 =?utf-8?B?NXZYK05iTzY4YmFuTXFzK3RUMHEvVXdiWFVYcG02YmFsUitRamNVaXg5Wkps?=
 =?utf-8?B?MG04eTB6TDZSV1hXaHdJYVB4TnhlQUIveW9lMWY2MXNMcDMxVEl3SmJqZUd4?=
 =?utf-8?B?a0RkNzQ1OE5nV0ZZNWVWZzB1WVROVXpmdTVkRnRWZ3BtdWY0L1JXUytQeWZ2?=
 =?utf-8?B?VnExWWJneFNORWc5YUhSTUpZN3N2REJRYXpYenZGVjZ5c0xKK280S2JZV3JE?=
 =?utf-8?B?RnVXOXhyNzBabndLL0ppRWpoZy9Melhjd3ZQWnhkOWVpaWhld04yVGdidmN5?=
 =?utf-8?B?QUVFMWhmNTNhZkR4dXdDSzFFeGhUSGRzcjNxSzNLbFFoeHJTdXBuRU1tV2lw?=
 =?utf-8?B?ekZhcGdLeUFzY2RQaG5oNUdUS00zUkgzdEQwL3Z0VXNhZjVPRTBkYnZJVmRQ?=
 =?utf-8?B?YU9rWnp3endCTEFIajV3amFFVGRTRHhDS3RrVkFCMU1NWFRDNWVkbnRLSVZL?=
 =?utf-8?B?elFLVTFFc241NDJGWjlCSlZJNGYrUW9MeXFzQjZYTGxHdWVvQWNQRVc0NFhC?=
 =?utf-8?B?NXdwLzlVUUxGOW50OGFSOTY2UktnL0ZDaDY3UWtPSXZ2N3laK3ExaFBWSzZP?=
 =?utf-8?B?ZU1wYW5yMFdJUXVYMHNsN2VSdnhSWjZlWEIxRy92MEhIdks0enhxL2dYWUZv?=
 =?utf-8?B?UjZhWEkrbk1iU2xzeWloR09aZjlwWHdXYjlDR3ZmU2tvT2NtbUF3NjhMQnYr?=
 =?utf-8?B?SUJOcmtiV0EzMHRhenVqS3B6YVoyN2tlZjltV29EZmp6N0RZQStIYUpqMksr?=
 =?utf-8?B?OHowTlBheDRvbmRMdThEYm4vMDRISVJTUURkaWRZQVoxMzMzOHJaUVp4WFBE?=
 =?utf-8?B?NnVpcDdHVk03SGRSZStxcDZVZWhnNTl0VHZzQmtDZ1dLcnRoVWlPODJQUWQ0?=
 =?utf-8?B?QVVnNUttV1ZvemlyajVxdVB0c3lYSjNiRklNSCtoWnNhVjBrR05BRk15ajZE?=
 =?utf-8?B?RkxvZWNwU0x5MDhBR2FsNzFnT2dBYzVPckVxRGRWNFhNVndHazBMK3NHWTFn?=
 =?utf-8?B?a3Q4bGRIK2IwUHhZSHphYmRPNFUxRHR1a01nYzFILzFNYktRSGc2NWE4dUV5?=
 =?utf-8?B?TTJyS1ZZei9ob2VNOHl4NG1sZlBycldFZStKMUVvUC81RWJlOTZuaXArYlNh?=
 =?utf-8?B?cVk1T3ZpU05QOGpCRFRjamJGT1FXQlJsd1JxK0pOZzlEUi91ZVQ4cll2SHNM?=
 =?utf-8?B?WWJaOGFvMHp2VWdFTnJETWVHZkg1Umt0MFo4ME5yZDluRmI3R3ltRnZiSXlG?=
 =?utf-8?B?cnlsR0QrS3RtekJHemVWUnV5ejNYdjk0bGQyRTl3K2RaVk9NZ3R6ZzU1UW8x?=
 =?utf-8?Q?FdTZ/v1MtTcYHfk4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03207D1D72AA74438351D2192B21CC3E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DBcDpAvSFERY4KDye9AP4vSU3Z28kaVO67WOlLKaZoucGWtLkiXm3ChWMVbUC6UGzrmiO1cstApcbQbwZJpOZHho2K7CpbQdgsgkhvADVKNm7HTVRvH7D7TZfqVHvUtOr4lylm9H+5Cld3iDYI23UlXIIurhrskg9SnBZu0rAVlW0KCXFeB0k/tXMmqPLbWpvBfCfANkQ2TxgCBjCq7ylUIXJU2pQL9sK9ERRgsTB5aNMCc6mbEL5tCiXAydc8P1RTx0xAafZVUiES+Fu6SS2VzHafwjeKoW28KsDxfSarDkjYo6+kGEjCMD4VArkleNIcfHsuGZcN6XG7uVHOhOPQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c23d4e-fa04-4f54-bf27-08debf102f58
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2026 12:28:56.7422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rgJf/EHPIxnNLjBhWyaiQUYpDHb9oFVgCzIW516PLe0vgzHBbhhPUlMYO/WV3VDfDRnJ86t+EvPxgH9i3dHeIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB9705
X-MTK: N
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk,mediateko365.onmicrosoft.com:s=selector2-mediateko365-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37209-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[lists.infradead.org,mediatek.com,nbd.name,collabora.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mediateko365.onmicrosoft.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Ryder.Lee@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+,mediateko365.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.948];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 2D8216160F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gU3VuLCAyMDI2LTA1LTMxIGF0IDE0OjExICswMjAwLCBsb3JlbnpvQGtlcm5lbC5vcmcgd3Jv
dGU6DQo+ID4gT24gU3VuLCAyMDI2LTA1LTMxIGF0IDEwOjU1ICswMjAwLCBMb3JlbnpvIEJpYW5j
b25pIHdyb3RlOg0KPiA+ID4gbXQ3Nl90eF9zdGF0dXNfc2tiX2FkZCgpIHplcm9lcyB0aGUgbXQ3
Nl90eF9jYiBzdHJ1Y3Qgc3RvcmVkIGF0DQo+ID4gPiBpbmZvLT5zdGF0dXMuc3RhdHVzX2RyaXZl
cl9kYXRhIHZpYSBtZW1zZXQoKS4gU2luY2UgaW5mby0+Y29udHJvbA0KPiA+ID4gYW5kDQo+ID4g
PiBpbmZvLT5zdGF0dXMgYXJlIG1lbWJlcnMgb2YgdGhlIHNhbWUgdW5pb24gaW4gaWVlZTgwMjEx
X3R4X2luZm8sDQo+ID4gPiB0aGlzIG92ZXJ3cml0ZXMgaW5mby0+Y29udHJvbC5mbGFncy4NCj4g
PiA+IEluIG10Nzk5Nl90eF9wcmVwYXJlX3NrYigpLCBtdDc2X3R4X3N0YXR1c19za2JfYWRkKCkg
aXMgY2FsbGVkDQo+ID4gPiBiZWZvcmUNCj4gPiA+IG10Nzk5Nl9tYWNfd3JpdGVfdHh3aSgpLCB3
aGljaCByZS1yZWFkcyBpbmZvLT5jb250cm9sLmZsYWdzIHRvDQo+ID4gPiBleHRyYWN0DQo+ID4g
PiBJRUVFODAyMTFfVFhfQ1RSTF9NTE9fTElOSy4gQmVjYXVzZSB0aGUgZmllbGQgaGFzIGJlZW4g
emVyb2VkLA0KPiA+ID4gdGhlDQo+ID4gPiBsaW5rX2lkIGFsd2F5cyByZXNvbHZlcyB0byAwIGZv
ciBmcmFtZXMgdXNpbmcgZ2xvYmFsX3djaWQsDQo+ID4gPiBsZWFkaW5nIHRvDQo+ID4gPiBpbmNv
cnJlY3QgVFhXSSBjb25maWd1cmF0aW9uLg0KPiA+ID4gRml4IHRoaXMgYnkgcGFzc2luZyBsaW5r
X2lkIGFzIGFuIGV4cGxpY2l0IHBhcmFtZXRlciB0bw0KPiA+ID4gbXQ3OTk2X21hY193cml0ZV90
eHdpKCkuIEluIG10Nzk5Nl90eF9wcmVwYXJlX3NrYigpLCB0aGUgbGlua19pZA0KPiA+ID4gaXMN
Cj4gPiA+IGFscmVhZHkgZXh0cmFjdGVkIGZyb20gaW5mby0+Y29udHJvbC5mbGFncyBiZWZvcmUg
dGhlIGRlc3RydWN0aXZlDQo+ID4gPiBtdDc2X3R4X3N0YXR1c19za2JfYWRkKCkgY2FsbC4gRm9y
IHRoZSBiZWFjb24gYW5kIGluYmFuZA0KPiA+ID4gZGlzY292ZXJ5DQo+ID4gPiBjYWxsZXJzIGlu
IG1jdS5jLCB1c2UgbGlua19jb25mLT5saW5rX2lkIGRpcmVjdGx5Lg0KPiA+ID4gDQo+ID4gPiBG
aXhlczogZjBiMGIyMzliOGYzNiAoIndpZmk6IG10NzY6IG10Nzk5NjogcmV3b3JrDQo+ID4gPiBt
dDc5OTZfbWFjX3dyaXRlX3R4d2koKSBmb3IgTUxPIHN1cHBvcnQiKQ0KPiA+ID4gU2lnbmVkLW9m
Zi1ieTogTG9yZW56byBCaWFuY29uaSA8bG9yZW56b0BrZXJuZWwub3JnPg0KPiA+ID4gLS0tDQo+
ID4gPiBDaGFuZ2VzIGluIHYyOg0KPiA+ID4gLSBEbyBub3QgdXNlIGxpbmtfaWQgaW4gbXQ3OTk2
X21hY193cml0ZV90eHdpIGlmIGl0IGlzDQo+ID4gPiBJRUVFODAyMTFfTElOS19VTlNQRUNJRklF
RA0KPiA+ID4gLSBJbiBtdDc5OTZfbWFjX3dyaXRlX3R4d2koKSByZWx5IG9uIGxpbmtfaWQgY2Fs
Y3VsYXRlZCBpbg0KPiA+ID4gwqAgbXQ3OTk2X3R4X3ByZXBhcmVfc2tiKCkuDQo+ID4gPiAtIExp
bmsgdG8gdjE6DQo+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjYwNTMwLW10NzZf
dHhfc3RhdHVzX3NrYl9hZGQtb3ZlcndyaXRlLWZpeC12MS0xLWUyYzMxNTFjMzkxYUBrZXJuZWwu
b3JnDQo+ID4gPiDCoA0KPiA+ID4gLS0tDQo+ID4gPiDCoGRyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3OTk2L21hYy5jwqDCoMKgIHwgMTQgKysrKy0tLS0NCj4gPiA+IC0tLS0N
Cj4gPiA+IC0tDQo+ID4gPiDCoGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3
OTk2L21jdS5jwqDCoMKgIHzCoCA1ICsrKy0tDQo+ID4gPiDCoGRyaXZlcnMvbmV0L3dpcmVsZXNz
L21lZGlhdGVrL210NzYvbXQ3OTk2L210Nzk5Ni5oIHzCoCAzICsrLQ0KPiA+ID4gwqAzIGZpbGVz
IGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQo+ID4gPiANCj4gPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9t
YWMuYw0KPiA+ID4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9t
YWMuYw0KPiA+ID4gaW5kZXggYzk4NDQ2MDU3MjgyLi45NWIzMDc4ZDk2NjcgMTAwNjQ0DQo+ID4g
PiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tYWMuYw0K
PiA+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYvbWFj
LmMNCj4gPiA+IEBAIC04NTYsNyArODU2LDggQEAgbXQ3OTk2X21hY193cml0ZV90eHdpXzgwMjEx
KHN0cnVjdCBtdDc5OTZfZGV2DQo+ID4gPiAqZGV2LCBfX2xlMzIgKnR4d2ksDQo+ID4gPiDCoHZv
aWQgbXQ3OTk2X21hY193cml0ZV90eHdpKHN0cnVjdCBtdDc5OTZfZGV2ICpkZXYsIF9fbGUzMiAq
dHh3aSwNCj4gPiA+IMKgCQkJwqDCoCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgbXQ3Nl93
Y2lkDQo+ID4gPiAqd2NpZCwNCj4gPiA+IMKgCQkJwqDCoCBzdHJ1Y3QgaWVlZTgwMjExX2tleV9j
b25mICprZXksIGludA0KPiA+ID4gcGlkLA0KPiA+ID4gLQkJCcKgwqAgZW51bSBtdDc2X3R4cV9p
ZCBxaWQsIHUzMiBjaGFuZ2VkKQ0KPiA+ID4gKwkJCcKgwqAgZW51bSBtdDc2X3R4cV9pZCBxaWQs
IHUzMiBjaGFuZ2VkLA0KPiA+ID4gKwkJCcKgwqAgdW5zaWduZWQgaW50IGxpbmtfaWQpDQo+ID4g
PiDCoHsNCj4gPiA+IMKgCXN0cnVjdCBpZWVlODAyMTFfaGRyICpoZHIgPSAoc3RydWN0IGllZWU4
MDIxMV9oZHIgKilza2ItDQo+ID4gPiA+IGRhdGE7DQo+ID4gPiDCoAlzdHJ1Y3QgaWVlZTgwMjEx
X3R4X2luZm8gKmluZm8gPSBJRUVFODAyMTFfU0tCX0NCKHNrYik7DQo+ID4gPiBAQCAtODY2LDcg
Kzg2Nyw2IEBAIHZvaWQgbXQ3OTk2X21hY193cml0ZV90eHdpKHN0cnVjdCBtdDc5OTZfZGV2DQo+
ID4gPiAqZGV2LCBfX2xlMzIgKnR4d2ksDQo+ID4gPiDCoAlib29sIGlzXzgwMjMgPSBpbmZvLT5m
bGFncyAmDQo+ID4gPiBJRUVFODAyMTFfVFhfQ1RMX0hXXzgwMjExX0VOQ0FQOw0KPiA+ID4gwqAJ
c3RydWN0IG10NzZfdmlmX2xpbmsgKm1saW5rID0gTlVMTDsNCj4gPiA+IMKgCXN0cnVjdCBtdDc5
OTZfdmlmICptdmlmOw0KPiA+ID4gLQl1bnNpZ25lZCBpbnQgbGlua19pZDsNCj4gPiA+IMKgCXUx
NiB0eF9jb3VudCA9IDE1Ow0KPiA+ID4gwqAJdTMyIHZhbDsNCj4gPiA+IMKgCWJvb2wgaW5iYW5k
X2Rpc2MgPSAhIShjaGFuZ2VkICYNCj4gPiA+IChCU1NfQ0hBTkdFRF9VTlNPTF9CQ0FTVF9QUk9C
RV9SRVNQIHwNCj4gPiA+IEBAIC04NzQsMTcgKzg3NCwxMSBAQCB2b2lkIG10Nzk5Nl9tYWNfd3Jp
dGVfdHh3aShzdHJ1Y3QNCj4gPiA+IG10Nzk5Nl9kZXYNCj4gPiA+ICpkZXYsIF9fbGUzMiAqdHh3
aSwNCj4gPiA+IMKgCWJvb2wgYmVhY29uID0gISEoY2hhbmdlZCAmIChCU1NfQ0hBTkdFRF9CRUFD
T04gfA0KPiA+ID4gwqAJCQkJwqDCoMKgIEJTU19DSEFOR0VEX0JFQUNPTl9FTkFCTEVEKSkNCj4g
PiA+ICYmDQo+ID4gPiAoIWluYmFuZF9kaXNjKTsNCj4gPiA+IMKgDQo+ID4gPiAtCWlmICh3Y2lk
ICE9ICZkZXYtPm10NzYuZ2xvYmFsX3djaWQpDQo+ID4gPiAtCQlsaW5rX2lkID0gd2NpZC0+bGlu
a19pZDsNCj4gPiA+IC0JZWxzZQ0KPiA+ID4gLQkJbGlua19pZCA9IHUzMl9nZXRfYml0cyhpbmZv
LT5jb250cm9sLmZsYWdzLA0KPiA+ID4gLQkJCQnCoMKgwqDCoMKgwqANCj4gPiA+IElFRUU4MDIx
MV9UWF9DVFJMX01MT19MSU5LKTsNCj4gPiA+IC0NCj4gPiA+IMKgCW12aWYgPSB2aWYgPyAoc3Ry
dWN0IG10Nzk5Nl92aWYgKil2aWYtPmRydl9wcml2IDogTlVMTDsNCj4gPiA+IMKgCWlmIChtdmlm
KSB7DQo+ID4gPiDCoAkJaWYgKHdjaWQtPm9mZmNoYW5uZWwpDQo+ID4gPiDCoAkJCW1saW5rID0g
cmN1X2RlcmVmZXJlbmNlKG12aWYtDQo+ID4gPiA+IG10NzYub2ZmY2hhbm5lbF9saW5rKTsNCj4g
PiA+IC0JCWlmICghbWxpbmspDQo+ID4gPiArCQlpZiAoIW1saW5rICYmIGxpbmtfaWQgIT0NCj4g
PiA+IElFRUU4MDIxMV9MSU5LX1VOU1BFQ0lGSUVEKQ0KPiA+ID4gwqAJCQltbGluayA9IHJjdV9k
ZXJlZmVyZW5jZShtdmlmLQ0KPiA+ID4gPiBtdDc2LmxpbmtbbGlua19pZF0pOw0KPiA+ID4gwqAJ
fQ0KPiA+ID4gwqANCj4gPiA+IEBAIC0xMDk2LDcgKzEwOTAsNyBAQCBpbnQgbXQ3OTk2X3R4X3By
ZXBhcmVfc2tiKHN0cnVjdCBtdDc2X2Rldg0KPiA+ID4gKm1kZXYsIHZvaWQgKnR4d2lfcHRyLA0K
PiA+ID4gwqAJLyogVHJhbnNtaXQgbm9uIHFvcyBkYXRhIGJ5IDgwMi4xMSBoZWFkZXIgYW5kIG5l
ZWQgdG8NCj4gPiA+IGZpbGwNCj4gPiA+IHR4ZCBieSBob3N0Ki8NCj4gPiA+IMKgCWlmICghaXNf
ODAyMyB8fCBwaWQgPj0gTVRfUEFDS0VUX0lEX0ZJUlNUKQ0KPiA+ID4gwqAJCW10Nzk5Nl9tYWNf
d3JpdGVfdHh3aShkZXYsIHR4d2lfcHRyLCB0eF9pbmZvLQ0KPiA+ID4gPnNrYiwNCj4gPiA+IHdj
aWQsIGtleSwNCj4gPiA+IC0JCQkJwqDCoMKgwqDCoCBwaWQsIHFpZCwgMCk7DQo+ID4gPiArCQkJ
CcKgwqDCoMKgwqAgcGlkLCBxaWQsIDAsIGxpbmtfaWQpOw0KPiA+ID4gwqANCj4gPiA+IMKgCS8q
IE1UNzk5NiBhbmQgTVQ3OTkyIHJlcXVpcmUgZHJpdmVyIHRvIHByb3ZpZGUgdGhlIE1BQw0KPiA+
ID4gVFhQDQo+ID4gPiBmb3IgQWRkQkENCj4gPiA+IMKgCSAqIHJlcQ0KPiA+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTk2L21jdS5jDQo+ID4g
PiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTk2L21jdS5jDQo+ID4g
PiBpbmRleCA4YmU0MGQ2MGFkMjkuLmExNGM2MzQzODkyMyAxMDA2NDQNCj4gPiA+IC0tLSBhL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTk2L21jdS5jDQo+ID4gPiArKysg
Yi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tY3UuYw0KPiA+ID4g
QEAgLTMxMDMsNyArMzEwMyw3IEBAIG10Nzk5Nl9tY3VfYmVhY29uX2NvbnQoc3RydWN0IG10Nzk5
Nl9kZXYNCj4gPiA+ICpkZXYsDQo+ID4gPiDCoA0KPiA+ID4gwqAJYnVmID0gKHU4ICopYmNuICsg
c2l6ZW9mKCpiY24pOw0KPiA+ID4gwqAJbXQ3OTk2X21hY193cml0ZV90eHdpKGRldiwgKF9fbGUz
MiAqKWJ1Ziwgc2tiLCB3Y2lkLA0KPiA+ID4gTlVMTCwNCj4gPiA+IDAsIDAsDQo+ID4gPiAtCQkJ
wqDCoMKgwqDCoCBCU1NfQ0hBTkdFRF9CRUFDT04pOw0KPiA+ID4gKwkJCcKgwqDCoMKgwqAgQlNT
X0NIQU5HRURfQkVBQ09OLCBsaW5rX2NvbmYtDQo+ID4gPiA+IGxpbmtfaWQpOw0KPiA+ID4gwqAN
Cj4gPiA+IMKgCW1lbWNweShidWYgKyBNVF9UWERfU0laRSwgc2tiLT5kYXRhLCBza2ItPmxlbik7
DQo+ID4gPiDCoH0NCj4gPiA+IEBAIC0zMjQ5LDcgKzMyNDksOCBAQCBpbnQgbXQ3OTk2X21jdV9i
ZWFjb25faW5iYW5kX2Rpc2NvdihzdHJ1Y3QNCj4gPiA+IG10Nzk5Nl9kZXYgKmRldiwNCj4gPiA+
IMKgDQo+ID4gPiDCoAlidWYgPSAodTggKil0bHYgKyBzaXplb2YoKmRpc2Nvdik7DQo+ID4gPiDC
oA0KPiA+ID4gLQltdDc5OTZfbWFjX3dyaXRlX3R4d2koZGV2LCAoX19sZTMyICopYnVmLCBza2Is
IHdjaWQsDQo+ID4gPiBOVUxMLA0KPiA+ID4gMCwgMCwgY2hhbmdlZCk7DQo+ID4gPiArCW10Nzk5
Nl9tYWNfd3JpdGVfdHh3aShkZXYsIChfX2xlMzIgKilidWYsIHNrYiwgd2NpZCwNCj4gPiA+IE5V
TEwsDQo+ID4gPiAwLCAwLA0KPiA+ID4gKwkJCcKgwqDCoMKgwqAgY2hhbmdlZCwgbGlua19jb25m
LT5saW5rX2lkKTsNCj4gPiA+IMKgDQo+ID4gPiDCoAltZW1jcHkoYnVmICsgTVRfVFhEX1NJWkUs
IHNrYi0+ZGF0YSwgc2tiLT5sZW4pOw0KPiA+ID4gwqANCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tdDc5OTYuaA0KPiA+ID4gYi9k
cml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tdDc5OTYuaA0KPiA+ID4g
aW5kZXggMGRjNDE5OGZjZjhiLi4wZDY0ODg1MjJiYTcgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2
ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tdDc5OTYuaA0KPiA+ID4gKysr
IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYvbXQ3OTk2LmgNCj4g
PiA+IEBAIC04NzQsNyArODc0LDggQEAgdm9pZCBtdDc5OTZfbWFjX2VuYWJsZV9uZihzdHJ1Y3Qg
bXQ3OTk2X2Rldg0KPiA+ID4gKmRldiwNCj4gPiA+IHU4IGJhbmQpOw0KPiA+ID4gwqB2b2lkIG10
Nzk5Nl9tYWNfd3JpdGVfdHh3aShzdHJ1Y3QgbXQ3OTk2X2RldiAqZGV2LCBfX2xlMzIgKnR4d2ks
DQo+ID4gPiDCoAkJCcKgwqAgc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IG10NzZfd2NpZA0K
PiA+ID4gKndjaWQsDQo+ID4gPiDCoAkJCcKgwqAgc3RydWN0IGllZWU4MDIxMV9rZXlfY29uZiAq
a2V5LCBpbnQNCj4gPiA+IHBpZCwNCj4gPiA+IC0JCQnCoMKgIGVudW0gbXQ3Nl90eHFfaWQgcWlk
LCB1MzIgY2hhbmdlZCk7DQo+ID4gPiArCQkJwqDCoCBlbnVtIG10NzZfdHhxX2lkIHFpZCwgdTMy
IGNoYW5nZWQsDQo+ID4gPiArCQkJwqDCoCB1bnNpZ25lZCBpbnQgbGlua19pZCk7DQo+ID4gPiDC
oHZvaWQgbXQ3OTk2X21hY191cGRhdGVfYmVhY29ucyhzdHJ1Y3QgbXQ3OTk2X3BoeSAqcGh5KTsN
Cj4gPiA+IMKgdm9pZCBtdDc5OTZfbWFjX3NldF9jb3ZlcmFnZV9jbGFzcyhzdHJ1Y3QgbXQ3OTk2
X3BoeSAqcGh5KTsNCj4gPiA+IMKgdm9pZCBtdDc5OTZfbWFjX3dvcmsoc3RydWN0IHdvcmtfc3Ry
dWN0ICp3b3JrKTsNCj4gPiA+IA0KPiA+ID4gLS0tDQo+ID4gPiBiYXNlLWNvbW1pdDogNDkxM2Y0
NDE2N2NmMzVhOTUzNmU5ZWVjNzM1MmUxNWIyZGUwYzU3Mw0KPiA+ID4gY2hhbmdlLWlkOiAyMDI2
MDUzMC1tdDc2X3R4X3N0YXR1c19za2JfYWRkLW92ZXJ3cml0ZS1maXgtDQo+ID4gPiA4NTgxOGE5
YmIzMWYNCj4gPiA+IA0KPiA+ID4gQmVzdCByZWdhcmRzLA0KPiA+ID4gDQo+ID4gPiANCj4gPiBX
ZSBtaWdodCBleHBhbmQgZmxhZ3MgZnVydGhlciBzbyB0aGlzIHN0aWxsIGRvZXNuJ3Qgc29sdmUg
dGhlIGlzc3VlDQo+ID4gb2YNCj4gPiBmbGFncyBiZWluZyBjbGVhcmVkIC0gaXQgb25seSB3b3Jr
cyBmb3IgTUxPIGZsYWcuIEFuZCB0aGUNCj4gPiBkZXZlbG9wZXJzDQo+ID4gc3RpbGwgd29uJ3Qg
ZWFzaWx5IG5vdGljZSB0aGF0IHRoZSBmbGFncyBhcmUgYmVpbmcgY2xlYXJlZC4NCj4gDQo+IE15
IG9waW5pb24gaXMgd2Ugc2hvdWxkIGNvbnNpZGVyIGp1c3QgdXBzdHJlYW0gY29kZSBhbmQgdGhl
biBjaGFuZ2UNCj4gaXQgYXMgc29vbg0KPiBhcyB5b3UgcG9zdCB0aGlzIG5ldyBmZWF0dXJlIHVw
c3RyZWFtLCBidXQgSSB3aWxsIGxldCBGZWxpeCBjb21tZW50cw0KPiBvbiBpdC4NCj4gTW9yZW92
ZXIsIHRoZSBwcm9wb3NlZCBhcHByb2FjaCBhbGlnbnMgbGlua19pZCB1c2VkIGluDQo+IG10Nzk5
Nl90eF9wcmVwYXJlX3NrYigpDQo+IHRvIHRoZSBvbmUgdXNlZCBpbiBtdDc5OTZfbWFjX3dyaXRl
X3R4d2koKSBhbmQgZml4IGEgcG9zc2libGUgT09CIGJ1Zw0KPiBpbg0KPiBtdDc5OTZfbWFjX3dy
aXRlX3R4d2koKS4NCj4gDQo+IFJlZ2FyZHMsDQo+IExvcmVuem8NCj4gDQo+ID4gDQoNCkp1c3Qg
dG8gdGllIGluIHdpdGggdGhpcyBwYXRjaCBzdWJqZWN0IC0gSSdtIGp1c3QgdGhpbmtpbmcgb2Yg
YSB3YXkgdG8NCnNvbHZlIHRoaXMgb25jZSBhbmQgZm9yIGFsbC4gSWYgdGhlIHByb2JsZW0gaXMg
cmVhZGluZyB6ZXJvZWQgaW5mby0NCj5jb250cm9sLmZsYWdzLCB3b3VsZG4ndCBpdCBiZSBiZXR0
ZXIgdG8ganVzdCBwYXNzIGEgdTMyIGZsYWdzLA0Kc29tZXRoaW5nIGxpa2UgdGhpczoNCg0KdTMy
IGZsYWdzID0gaW5mby0+Y29udHJvbC5mbGFncw0KDQptdDc5OTZfbWFjX3dyaXRlX3R4d2koZGV2
LCAoX19sZTMyICopYnVmLCBza2IsIHdjaWQsIE5VTEwsIDAsIDAsDQoJCQkgICAgICBjaGFuZ2Vk
LCBmbGFncyk7DQoNCldlIGNhbiB1c2UgYWxsIGZsYWdzIHRoZW4uDQoNClJ5ZGVyDQo=

