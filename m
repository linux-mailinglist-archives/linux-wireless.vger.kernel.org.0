Return-Path: <linux-wireless+bounces-38967-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NDOROh6xVGpQpgMAu9opvQ
	(envelope-from <linux-wireless+bounces-38967-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 11:34:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAC67495BA
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 11:34:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mediatek.com header.s=dk header.b=eNbiMJYp;
	dkim=pass header.d=mediateko365.onmicrosoft.com header.s=selector2-mediateko365-onmicrosoft-com header.b=sKi0MbD1;
	dmarc=pass (policy=quarantine) header.from=mediatek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38967-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38967-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E4A6300CE6E
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96AB299943;
	Mon, 13 Jul 2026 09:34:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8003E0C59
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 09:34:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783935259; cv=fail; b=Q8BVWNRHvU+6QhYOotlI7OyiOI5r/QVJvlfPsA9uWcNRPiUFsHQpqNQAspzPjs991Bh0i7ZMXHUr6CRCg3wymttDSoO7w5bOs8ox+KxsVb65Me0zcBYvQLd18fC2h0lB6LMsHapBv/RPJFMh8tbqncd9az1mtLjmCZ1fzil5C9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783935259; c=relaxed/simple;
	bh=Y/F4Fd8NR3s6ZTmVVoSHuaUdBnp12aw8RCn8sUnFuRA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lNO4lsMu28uPUhNWeTDGVVxPcPIAdmqH4ntk5W6ZYyq4FbDRbUgGJIc/fB2+42cF3BnDlAPDQadGArszNUTz4J1VQuxQqCgK/2/j7HVettghx4ndU/sjhIlrP3klHJp0Nuu988N8bPuIfbEHRWm2s7FH+zaMfkYLgxTi0tj1B6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=eNbiMJYp; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=sKi0MbD1; arc=fail smtp.client-ip=60.244.123.138
X-UUID: ff391bec7e9d11f1b1788b6acf885367-20260713
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Y/F4Fd8NR3s6ZTmVVoSHuaUdBnp12aw8RCn8sUnFuRA=;
	b=eNbiMJYpK3ZeRo2CfzypuOHucLEmorX6nxN5ksVJsPCrm71ehGvqfmFEI3NnvgDiN7txbGOeJDqaHtyFYDQDFTE/Uzm5l/CWrH5rsJTxbS/zpBhI0+/zNvyrxPI9242+dodnJKSmAVCG+adEXLENSnfLXkATao7ED+pLne6D7vo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:cbfdd1cb-4488-45b5-bdc7-e707d8c72a6e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:d497b38,CLOUDID:26a346f9-4b72-4a52-91ca-f4585405c3b0,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|51|99,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ff391bec7e9d11f1b1788b6acf885367-20260713
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <eason.lai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1139106008; Mon, 13 Jul 2026 17:34:08 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 13 Jul 2026 17:34:07 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 13 Jul 2026 17:34:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=baYyws9e4+uo+s/3KHRgwVBwwzwmCLMb0sAb7brVjOrTAhLHn186BrsGUt4kyeg5jQZLsLVgOr9MOh5eosn9Gnj00fSNvKCwVgWHLs92rInXgESoIdZOroVDkRzfde2db3qFephkFqDPyFJTUvPLlOt7CEqmfjPr0uXacM5Y+ufTSGIV8Ypq7m6cU6spiQyAncVbn/BdGuC3vuuAuMjetIB7KIVGsjBMAKZxRcs7ByODXA2+Z20FmVptCQAfbV2ZAdKh03OKKG7iKVXOXjbdlPAalMaMIVdH4olMZEeABSfH2d4lS11Gqz+zvRJFtnKQEMGudTpBpY/TshJ6oAXIbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/F4Fd8NR3s6ZTmVVoSHuaUdBnp12aw8RCn8sUnFuRA=;
 b=x7zHjBEV86VpC17nmhxy2Nlll3pu0oZ7Uz+HudzDozaPs5siyXIAS4Fwy4bQals1DSTVlZO8/U3z7Brw4bMbNwkxAsLsK5uC+/FEkfKXYnJjDpPSO5R6SMlamNkdXl7vkVDNpnJGEYiMfjjKVftk7bjmZb4W1c8XHTCzSrudMPOjtZ3bFyDu5GFdXB0HBTW5wLD1JdRFNXA8sqXuayeukDzrMNGqLn8ZRte7Y7CuJYPE9ZBrH6R+ghG4eDUgBel9jR3HHlU9qoR3WZWq4Go+8S09xv0gxt64av2KNamZWi1VuidnRBSeVYhTr8meR9Uk4dWfWfvsmZURn4dN1Htyyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/F4Fd8NR3s6ZTmVVoSHuaUdBnp12aw8RCn8sUnFuRA=;
 b=sKi0MbD1JkuAuKih3IXCEtkVk+P/ufOAwRdPR5Z7tPGqQ4XLsNLfFU+SjzdKllKpEGykI1vmDwQ8BAnX2NrzTAXq89ZypW5W2q9X3Euw0jPgvLaIhZLeKGPpEwbZZVa7AR7140Fett7StXMP5aztrpDqBibIlcpttMwP5TLSIgM=
Received: from KL1PR03MB7079.apcprd03.prod.outlook.com (2603:1096:820:d5::5)
 by SEYPR03MB7269.apcprd03.prod.outlook.com (2603:1096:101:8b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Mon, 13 Jul
 2026 09:34:03 +0000
Received: from KL1PR03MB7079.apcprd03.prod.outlook.com
 ([fe80::9bd3:f66a:efd4:f6af]) by KL1PR03MB7079.apcprd03.prod.outlook.com
 ([fe80::9bd3:f66a:efd4:f6af%4]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 09:34:03 +0000
From: =?utf-8?B?RWFzb24gTGFpICjos7TmmJPogZYp?= <Eason.Lai@mediatek.com>
To: =?utf-8?B?SkIgVHNhaSAo6JSh5b+X5b2sKQ==?= <Jb.Tsai@mediatek.com>,
	"nbd@nbd.name" <nbd@nbd.name>, "lorenzo@kernel.org" <lorenzo@kernel.org>
CC: =?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>, "Ryder
 Lee" <Ryder.Lee@mediatek.com>, =?utf-8?B?UXVhbiBaaG91ICjlkajlhagp?=
	<Quan.Zhou@mediatek.com>, =?utf-8?B?TGl0aWVuIENoYW5nICjlvLXnq4vlhbgp?=
	<Litien.Chang@mediatek.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, Sean Wang <Sean.Wang@mediatek.com>,
	=?utf-8?B?TGVvbiBZZW4gKOmhj+iJr+WEkik=?= <Leon.Yen@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v3] wifi: mt76: mt792x: fix use-after-free in
 mt76_rx_poll_complete
Thread-Topic: [PATCH v3] wifi: mt76: mt792x: fix use-after-free in
 mt76_rx_poll_complete
Thread-Index: AQHc8be4PVmABwIGy02LX+dhg/7XZ7Y+9LcAgCx9VAA=
Date: Mon, 13 Jul 2026 09:34:03 +0000
Message-ID: <633ca22ae9b555102f8791289b1719313b82e43e.camel@mediatek.com>
References: <20260506084315.3143553-1-jb.tsai@mediatek.com>
	 <8430bab4-a064-4f58-81d8-c8801d17f89a@nbd.name>
	 <KL1PR03MB7079CDD6006DA83B2E0DD32D97E62@KL1PR03MB7079.apcprd03.prod.outlook.com>
In-Reply-To: <KL1PR03MB7079CDD6006DA83B2E0DD32D97E62@KL1PR03MB7079.apcprd03.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB7079:EE_|SEYPR03MB7269:EE_
x-ms-office365-filtering-correlation-id: d23ad11b-c0fb-464e-3ee9-08dee0c1e0a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|38070700021|18002099003|22082099003|56012099006|11063799006|5023799004|6133799003|4143699003;
x-microsoft-antispam-message-info: x4RlxRQHmhLzC+4M/DHE3y0EbBDRtIyvXw16Xt17WKuP5ZbMc2kTH2My5JgaLM1xtkghp/WIOJG1doldkCah+EA9ZvmpIbhMPUPBuNlreX3T88/LDAE8pwagGS1K8xVnfADgx4cIZbkPfcgc+Yv09lgekazg6hXcmQvdj3mO3WcaSi7vQ4ckPhMwRZ5ES+rs0CFJFB6vsssIRwundjLZL8Z0hMXnBJngVpe88vs/yloJ9LSGWbXJ2dzIz7G5kbJsNzzwIWfUq8LiI1jR7PLxI1PqOQOieZQV/VzFk2LboNjylDmu3SqIZoz0q2wuSTiRYZaaThi35rHxSr0MKBPodqFC5FZ0E3FPUKx/2PaCrJMy3JiO05x629tbFK5B+GoSQ8ATZRYE1I4kvpddHh3u/eTxFeanCuxDJETQb0orYtHasRDXgSlwVjKb6T3PFLY5OVLvF4RPdfKrwmE32va/5svO8jYrx7yiz8F8rdXs6uG9RWZqZXuqzx5DkhB9CsdVdgqzCmrOXety0UjXOkKEOw17n54N45XEyacGdGdErc/Ut412uKFSrw9tbF7yYIi3D7sLlDECnM0eGgVOQpnojEwD1qCgyP7e4/H8x6lgfBhuCrh2ql19YitppHjHf9fEBVCW0DB/dnuWOFtTy/LKRfI5WjrYLsIUeNnyw2FpM87bR0uugGOH9Ocac9TcawJje5MnQiS6r+E0zBKUTTBsUnxLJnNWImqu6k5GdC+r96w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7079.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004)(6133799003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGNJK08xU2NlWndta0h4NEFEOHI2Q1JBQkJ2S0Rpc0RsazBaWjRQR1VUTStY?=
 =?utf-8?B?WHhBdFVZSm5KNFFLTkYrdVFJdjJrWXhERStJQ3A5a2Fva3RlTXFYNDdGYVJQ?=
 =?utf-8?B?QUhRVWFrQUM5emhRZVVUa2lLc21xNFZlak5vclVSWEkyMzBUbWFBdDRBWVB5?=
 =?utf-8?B?VkFzQlBsY3p3N0RFSThxNFQyeGR1aGV5L3RmRkdTUEpUOUY2UWRQcUVwakZH?=
 =?utf-8?B?VEh6TzlBbVVrYllZcXlYQmRCOXl4b2hBeFhnUm41TTVSK2NIQlZrZlF3NzNU?=
 =?utf-8?B?K3hPZnY5a2gyT1VMdmhpT3hVWDZFYWU1WkUrK0JVUGhTMC9tMjdqWUFHZGhC?=
 =?utf-8?B?bUJHU2l2RmdEU0tsamtod3RVeTZMckZ2YUszdEg4eVpuRUkxYmQwM3J2cFdh?=
 =?utf-8?B?YWRlemxEdWs3NWh0UDZPcHlaeVdJa21QQ0tMVHlXemhGOEtEcEU2QnQ1YmpY?=
 =?utf-8?B?MWgvNzZWcWE0WmdSKzBrc3hjd3ZhMmN0d2hDMzZOV3FJRUVSOWVWRG5kc0pq?=
 =?utf-8?B?MzlkUU9uTFVsem5lNTZZRUxsbUVMSUJ0L1hMbFhyTTJpbDMwb0VySzcweXBS?=
 =?utf-8?B?VjdZU0FQWEZqb0VKckpDNjBlQWZTZXFLLzhZS1hKMy9jelFEa0FPZWV3cnNn?=
 =?utf-8?B?UTRmaS83NnNJQlRsb3BBaUZwaENBUFJTdHZ5TitCb240NC9NWDFwcnIvaGc0?=
 =?utf-8?B?WFdJbHhPVDEycWlRb3JKSVU5a20rUkMvV0R3YnZtQ1M4UHpvQXRnMnFOOEVP?=
 =?utf-8?B?MUZsbWxJVkN5YVVqWEI5amhmRGZOL20rQmtwdElwN0VkZlUvYkVkUjVhVGZz?=
 =?utf-8?B?UTBuSkZKZ09YNGZjOEI1eVBLbmprUGJycXdaSzVwUEtUZ0p3RnJjaDgxOCtN?=
 =?utf-8?B?K0M0enNVMlE1Nnk1MmtWNUYvMmlIeUVocVROVFZQOFJZbU9xM2QwNWswbW01?=
 =?utf-8?B?TVg1bFNneEYzZFVTY2Q0NnBlbkdpem5SL3hOV083enlwV1Ixd2oxVUhhcDU1?=
 =?utf-8?B?UjBORlcveHFjKytLb3RRTHpCS0VvOXkxRFFSN2xPQTVjMlR4eGtnTkRWc3do?=
 =?utf-8?B?eWJuRFFEVlJpbHQveSt3VHp6ZEwxQ1B0cHFzK2hpQUtKbmxmWGZ1aTBYWllu?=
 =?utf-8?B?Qi9naGFPVWVKWU9xZTBSejRkazEySDNOSFhranVNMzdSbjhBUGRkMk1SbkpL?=
 =?utf-8?B?cjg5eVlSMnIzelhWa2lpUHdDajU5alo5N2RJQmdiYWxUSG9PeGo2UktTelpN?=
 =?utf-8?B?cnEzbmFVRWRJcXVrZ0xvRUhMVTZ2bUJ3VTZJYWxVTURIanJyVC9IMjV4UGlX?=
 =?utf-8?B?eEE1bU9XNk9JMkErTXYvOWhMS0kvdWZqcFR0VFNJUjJ2Y3NWMUtYMmNFVFho?=
 =?utf-8?B?NTZKWERKYzBSYk40endKWXE5aWhYOFUvK1NVNC8yUlQwazFobFlMd3RTUmM0?=
 =?utf-8?B?YWZDdVNBZ3BGODBLRVR4eVhNR3pZTXgxdTFaVlNsenJ4MGRnNHp1MGlXME9X?=
 =?utf-8?B?aFMvVWtwZEtNYWJkVjc0Umo4dVVSWnk4VnJva3RBK2F6T0ZJNmFVYUR2R1RV?=
 =?utf-8?B?T2tIRE5nK012UG5nWHpFUXRwMHZaQmcvZjRyNnR2YTd3OEEzMEkrc2lFS0x3?=
 =?utf-8?B?d0VyVlk0cldxTEFmblVLaHU1VW1GTUlYK2pYVWRXVGI4UmUrenZXdEhvU3BY?=
 =?utf-8?B?TUJueEx3RmxDVE5jZGVXUi9Hckw3TElGazlWUjNqS2JWMHFMaDdEa3plT1pG?=
 =?utf-8?B?RDg1OHlMYUFJMGVhQXhyZjduTUtvREpSYWozZUZKYTl6bStNMkFjRzR4SXh5?=
 =?utf-8?B?TVB4d2tDR2NpbmRPT3dKWXBuaXVrYXo2enJ4bnJGV3lHNzl4bTlPTEhPYytK?=
 =?utf-8?B?NjJyTDh1RVp1MUtVZnBIcktEUHZqSzVBZ1ZsZzdPcDcyOWR0RHlRWHk2alZl?=
 =?utf-8?B?ait6QnROeHdhd084cXFsdzFNTnBMbUhpdG1ZdnRFcitIL1Q2SW1Ld09OUENz?=
 =?utf-8?B?OE1jeklnZkx6a1NZMFNqZDRLUUkyMDY4Uy9PZlpJcDc1VkpzZENmMk14V1p4?=
 =?utf-8?B?amJGNnA2V05TQkpZakprcWdyMFBjSWorZWlPUFprMEoyeTB1dFZmR3JYN1Zj?=
 =?utf-8?B?V0c3ZEpSU3UvL3NkenVxWDNNUUN5eG1iUGxRMHhNN3RqazVrWTYrU3pCMFI2?=
 =?utf-8?B?RTVtRnIrdDBYVmw5d3d1NTlBVldRRVMvVTZyZnI4NHhWYVpOSGJ3cHFyanNu?=
 =?utf-8?B?NmtSSEJtSnNMcENOZTc1VHJSbGcvQmw3L3dubERUZEsrMnhpZ09NbzRmWlNi?=
 =?utf-8?B?UGRKNnh2a3ExUFkzc3RIQ2I2WkhXM1NaTU9lQ3NSN1JQQy9GaXFJVXJPdGJ4?=
 =?utf-8?Q?1T3TRj92Xc8rhNHo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <638232634E0D5C448D2F2D5BD4416D60@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nNZFFzZPF/HJHeHyIEr9FiCSCuyi6MUwmLuCfV+z0f17PIHmBewaUhAlqM6ztffJ7ELrSvvwkJVn/05lMuEKtqeC/fgy3M+GoVrwWK5C/ZX3irX+G8SWh6BH3ABSl08DBVPjdnBqnNBiaT9gRNNFMjqPkwstuqDa1YHrLuGvnR/weevxrnccexcSaVGKjPWTSyO1HwcUIGen81GitJ0EbB7FnEtaFKkBnagPbo8zxn4WhRtj4IZ3EenKXC0rT1lsiGCdGak3cNPbQRV5lp/+GBqCxl4rBNZULcZgNjPlKL3DEPDSO1q96M9p116XH26476BXOJJ8wH7lT1w1FNXIHA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7079.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d23ad11b-c0fb-464e-3ee9-08dee0c1e0a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 09:34:03.5112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /DvvAzKQla65nyvwO2FnLCWraPjr9I0SH8+U7OwB3TAVwd6JPBtt71ojB3Mi7M0sdyS7hiNYFjzeCDdJFTUMSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7269
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk,mediateko365.onmicrosoft.com:s=selector2-mediateko365-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38967-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Jb.Tsai@mediatek.com,m:nbd@nbd.name,m:lorenzo@kernel.org,m:Deren.Wu@mediatek.com,m:Ryder.Lee@mediatek.com,m:Quan.Zhou@mediatek.com,m:Litien.Chang@mediatek.com,m:linux-wireless@vger.kernel.org,m:Sean.Wang@mediatek.com,m:Leon.Yen@mediatek.com,m:linux-mediatek@lists.infradead.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER(0.00)[Eason.Lai@mediatek.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[mediatek.com:+,mediateko365.onmicrosoft.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Eason.Lai@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BFAC67495BA

T24gTW9uLCAyMDI2LTA2LTE1IGF0IDAyOjE3ICswMDAwLCBFYXNvbiBMYWkgKOiztOaYk+iBlikg
d3JvdGU6DQo+IEFmdGVyIGxvb2tpbmcgaW50byB0aGUgbWFjODAyMTEgU1RBIHJlbW92YWwgZmxv
dywgSSBkaWRuJ3Qgbm90aWNlDQo+IHRoYXQgc3luY2hyb25pemVfbmV0KCkgaXMgaW52b2tlZCBh
ZnRlciBtdDc2X3N0YV9wcmVfcmN1X3JlbW92ZSgpLg0KPiBZb3UgYXJlIHJpZ2h0LiBJIHdpbGwg
Y2hlY2sgbXQ3OTI1X2NoYW5nZV92aWZfbGlua3MoKS4gVGhhbmtzIGZvciB0aGUNCj4gc3VnZ2Vz
dGlvbi4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gRWFzb24NCj4gDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEZlbGl4IEZpZXRrYXUgPG5iZEBuYmQubmFtZT4gDQo+IFNl
bnQ6IE1vbmRheSwgSnVuZSAxLCAyMDI2IDc6MTMgUE0NCj4gVG86IEpCIFRzYWkgKOiUoeW/l+W9
rCkgPEpiLlRzYWlAbWVkaWF0ZWsuY29tPjsgbG9yZW56b0BrZXJuZWwub3JnDQo+IENjOiBsaW51
eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LW1lZGlhdGVrQGxpc3RzLmluZnJh
ZGVhZC5vcmc7IERlcmVuIFd1ICjmrablvrfku4EpDQo+IDxEZXJlbi5XdUBtZWRpYXRlay5jb20+
OyBTZWFuIFdhbmcgPFNlYW4uV2FuZ0BtZWRpYXRlay5jb20+OyBRdWFuDQo+IFpob3UgKOWRqOWF
qCkgPFF1YW4uWmhvdUBtZWRpYXRlay5jb20+OyBSeWRlciBMZWUNCj4gPFJ5ZGVyLkxlZUBtZWRp
YXRlay5jb20+OyBMZW9uIFllbiAo6aGP6Imv5YSSKSA8TGVvbi5ZZW5AbWVkaWF0ZWsuY29tPjsN
Cj4gTGl0aWVuIENoYW5nICjlvLXnq4vlhbgpIDxMaXRpZW4uQ2hhbmdAbWVkaWF0ZWsuY29tPjsg
RWFzb24gTGFpICjos7TmmJPogZYpDQo+IDxFYXNvbi5MYWlAbWVkaWF0ZWsuY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYzXSB3aWZpOiBtdDc2OiBtdDc5Mng6IGZpeCB1c2UtYWZ0ZXItZnJl
ZSBpbg0KPiBtdDc2X3J4X3BvbGxfY29tcGxldGUNCj4gDQo+IE9uIDA2LjA1LjI2IDEwOjQzLCBK
QiBUc2FpIHdyb3RlOg0KPiA+IEZyb206IEVhc29uIExhaSA8RWFzb24uTGFpQG1lZGlhdGVrLmNv
bT4NCj4gPiANCj4gPiBBIHVzZS1hZnRlci1mcmVlIGlzc3VlIG9jY3VycyBpbiBtdDc2X3J4X3Bv
bGxfY29tcGxldGUgZHVlIHRvIGENCj4gPiByYWNlIA0KPiA+IGNvbmRpdGlvbi4gVGhlIFNUQSBo
YXMgYWxyZWFkeSBiZWVuIHJlbW92ZWQsIGJ1dCB0aGUgcnhfc3RhdHVzDQo+ID4gc3RpbGwgDQo+
ID4gaGFkIGEgcG9pbnRlciB0byB0aGUgd2NpZCBpbiB0aGUgU1RBLg0KPiA+IA0KPiA+IFVzZSB3
Y2lkX2lkeCBpbnN0ZWFkIG9mIHN0b3JpbmcgdGhlIHdjaWQgcG9pbnRlciwgYW5kIGxvb2sgdXAg
dGhlDQo+ID4gd2NpZCANCj4gPiB2aWEgcmN1X2RlcmVmZXJlbmNlKCkgYnkgd2NpZF9pZHguDQo+
IFVubGVzcyBJJ20gbWlzcmVhZGluZyBzb21ldGhpbmcsIGl0IHNlZW1zIHRvIG1lIHRoYXQgdGhp
cyBwYXRjaA0KPiBwYXBlcnMgb3ZlciBhIGRpZmZlcmVudCBidWcgaW5zdGVhZCBvZiBmaXhpbmcg
dGhlIHJvb3QgY2F1c2UuDQo+IFJpZ2h0IG5vdyB0aGUgcnggcHJvY2Vzc2luZyBjb2RlIHJlbGll
cyBvbiBSQ1UgdG8gcHJvdGVjdCB0aGUgd2NpZA0KPiBhbmQgc3RhIGRhdGEgc3RydWN0dXJlcy4N
Cj4gVGhlIHJjdSBsb2NrL3VubG9jayBhcm91bmQgcG9sbGluZyBhbHNvIHNlZW1zIGNvcnJlY3Qg
dG8gbWUuDQo+IA0KPiBBcmUgdGhlIGZyZWVkIHdjaWQgcG9pbnRlcnMgbWF5YmUgcmVsYXRlZCB0
byBhIHZpZiBzdGEgaW5zdGVhZCBvZiBhbg0KPiBhY3R1YWwgc3RhdGlvbj8gVGhlIHVzZSBvZiBk
ZXZtX2tmcmVlIGluIG10NzkyNV9jaGFuZ2VfdmlmX2xpbmtzDQo+IGxvb2tzIHN1c3BpY2lvdXMg
dG8gbWUuDQo+IA0KPiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgSSdtIG1pc3Npbmcgc29tZXRoaW5n
IGhlcmUuDQo+IA0KPiAtIEZlbGl4DQoNClRoZSBuZXcgcGF0Y2ggaXMgcG9zdGVkIGhlcmU6DQpo
dHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA3MDEwMTA2NTQuOTU2ODYzLTEtZWFzb24u
bGFpQG1lZGlhdGVrLmNvbS8NCg0KQmVzdCByZWdhcmRzLA0KRWFzb24NCg0K

