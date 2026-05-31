Return-Path: <linux-wireless+bounces-37194-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJpiBCEMHGq5JAkAu9opvQ
	(envelope-from <linux-wireless+bounces-37194-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 12:23:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 82041615908
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 12:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 899BA3004432
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 10:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34409367B96;
	Sun, 31 May 2026 10:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DMz7u8kA";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="PUfdypvL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EEA2F8EB3;
	Sun, 31 May 2026 10:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780223001; cv=fail; b=J2N8BE0AL5O+tX9BD3NlM5AhUM3H/zvTWL4223J160Vn52GoniGY/dxvGkv7cGooYvIx14TDwMn6ZU8BiIlK/tfpXOkrMLnhw++RLleZZhJjvXmGsXvR23ckNYMnjTSUKAD9iruDdE8RXtrGHGtoi5mlwpXlBgtP/TMQK+oMry0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780223001; c=relaxed/simple;
	bh=klMoX7yIHJts3TU8lzyexVdk6MGjwcEaUXvfGdaeAlw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OuuPUHZ+1r9Nnjq6S7ldrQJuEx0mXosnG/iqvep+zLg4ul7iIaMm4PKH+ncfZsAUzvHcsj+FFzUC0vRWv84TeQzZPMEqNoUMSuMRg3I+nha98Q0mPigIYTtLzGUwB8Yr+LWYMFvgbw1HKYXIXzXsMT0P+Pp0RPy8tb051VfEwhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=DMz7u8kA; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=PUfdypvL; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b780102e5cda11f1b1788b6acf885367-20260531
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=klMoX7yIHJts3TU8lzyexVdk6MGjwcEaUXvfGdaeAlw=;
	b=DMz7u8kAlIKXtjEgcL8AenhC/ogAnPKyv3nd3S4Q0I6Neq9ajI4KE87YaKnkDK+0hwKYGd9Z8f8hPnZVz9vBjqdjZFVBTFzH7DC1tpkPz/Ab+4GZRFIRPI5zTsLHzMtOaoIaw52hU7B5NRs2HqOYgZHETZyayVnKc+mI1CerW2s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:dcaa7b16-b33e-4246-aa54-164896a24329,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:d695a3c9-9273-4096-a0ce-fc7a6a4f85f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|136|836|865|
	888|898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:ni
	l,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b780102e5cda11f1b1788b6acf885367-20260531
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 527663180; Sun, 31 May 2026 18:23:07 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 31 May 2026 18:23:06 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Sun, 31 May 2026 18:23:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VxsImn+y+Vx4SmStS0tgVd5qsc2aOij1H3mhg64vCERTQzxG/+QSKQ/vflh9SYjBdc6gb4rEsRTg/Ct1HcZ9a6i7VtG0ioD5GlatIgmE5jHCufyUmFg4a1PXSzFm7ctY2e+sEIcSW9cGNxzl0EBxEIObCasmZMaottbYmWn4agsAooTVDmKFaGmuU2E733L70XSIBhbFMkRr34Vxe5ZQ82Y0A5M9rCpW00VkiggeELuAqMQ0wB5i8WgGmIpVjwk7bQPC1XpycdUBVsjRS8+uhx1ft0J27D5Vi0sh05NcDycivfr7XHWMvJl8RQsHtLeWal9VORYkxFSt/Kg7j3XwVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klMoX7yIHJts3TU8lzyexVdk6MGjwcEaUXvfGdaeAlw=;
 b=wIb7ZXdCIXmykDwHzgumJy6L7zDHJo9LtWNGo3leiPj3j5Tw1YZy0/tSSIa/Ik7TKgkH7G/AIxAD3ARlobmZkhtpt6iUtfX2CeO7hidTZi9o3Np3RVGLqPT7Y7iKm91ZIY9WxxIxp/ew/H4Owvi0lF+g1Vu/ls+sBV4k2XVEObEo5TPR5Z0R6QZsl6PYdKYnaCMVE8SvNHp1Lgik0iTF1/bPTxdUA48R75ET0QX41w686aR0BFjzcirba8N7Ju2iC4Vz31fTb0zp59vWtvcWj8pQROgeqH5csypneQ8OYDj4Bb3FmwUyYiYW9W0/zSEhWKtdwuIWnkklc7AFzBCUQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klMoX7yIHJts3TU8lzyexVdk6MGjwcEaUXvfGdaeAlw=;
 b=PUfdypvLSv9PW5AP8HGOCHa00FzB8kkF3jeamxQf35xxamNS5RtWo3lYlqBJF8A/sJ7vFHa8QbLlzSaJ/MhhvpouR49OYbSTRbFzh1eA2fpsNyfooe/qqSTjEeTYzKawU9pHWMd7iV9In9gRH1H6safB1SuRzZva0PurKrBeOHI=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by KL1PR03MB8403.apcprd03.prod.outlook.com (2603:1096:820:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.6; Sun, 31 May 2026
 10:23:02 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059%6]) with mapi id 15.21.0092.005; Sun, 31 May 2026
 10:23:02 +0000
From: Ryder Lee <Ryder.Lee@mediatek.com>
To: =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>,
	"lorenzo@kernel.org" <lorenzo@kernel.org>, "nbd@nbd.name" <nbd@nbd.name>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?utf-8?B?Q2h1aS1oYW8gQ2hpdSAo6YKx5Z6C5rWpKQ==?=
	<Chui-hao.Chiu@mediatek.com>, Sean Wang <Sean.Wang@mediatek.com>,
	=?utf-8?B?Qm8gSmlhbyAo54Sm5rOiKQ==?= <Bo.Jiao@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Roy-CH Luo <Roy-CH.Luo@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: mt76: mt7996: fix reading zeroed
 info->control.flags after mt76_tx_status_skb_add()
Thread-Topic: [PATCH v2] wifi: mt76: mt7996: fix reading zeroed
 info->control.flags after mt76_tx_status_skb_add()
Thread-Index: AQHc8NtWBQF4NsneqEql9Op9RanVZrYn7TOA
Date: Sun, 31 May 2026 10:23:01 +0000
Message-ID: <ee0e584cb2ad1b536d327eb89342d1646fa96570.camel@mediatek.com>
References: <20260531-mt76_tx_status_skb_add-overwrite-fix-v2-1-b73c4b4a9798@kernel.org>
In-Reply-To: <20260531-mt76_tx_status_skb_add-overwrite-fix-v2-1-b73c4b4a9798@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|KL1PR03MB8403:EE_
x-ms-office365-filtering-correlation-id: a809ca86-2925-47c7-0fbe-08debefe9864
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099006|11063799006|3023799007|6133799003;
x-microsoft-antispam-message-info: UBZW0t2fGV75htc1fJ8TztFcambhp10wDhMn6Vpr3+/B/fFP4K5QARvZSodIvMSTrCbYDkacKB/feYYSRAtlVoR3fgyVLFJOaHvAXTUex0hG5d40TXBTvtZEuHbKL+Vx1N0uJNAAIXW32A/sd1NQSMOTaWoTQVP4QAUCvxyuEizM22RvwcccPFchNVOeD/IRcPYDknspvra3uBf/sXUA8FLcC33vXO8FDO8SPxs+pWt7SZiuyDem97+w51gWenBZOfOHvL/RD26FTdu+Uz/EW6pZBWXqEIlTQvGEfQDkTnpZdnkYt/cJRJ34Oyif4ENm2ij+fD81B7zcd+NgfKL62Os9BwH6eP+vNRcOc550tPhCaSUGc1498lCJiVMPfnbH3LP1BTDXlmNLCaEj9Pnd7XTyFr9QrB4OuVyYSWsPWcJxalSDHumqeAgAOJX4AzHSQlndO8h0jc1MHn7KEf7mk6tHX2Ui2aAx6q7bYi8bdeViCt9Mj+b6/88PnNElacB/XJSzEG7DYJ5K+M6eHDh819wNuCB2DWbl+5+cvcOHNvGNptY4I2xVpFo7laOmEE8TEZ6wZz8UY2fITtxmV2CumSs1l+9ioe2u0gZN+v6DiUhAu5KB/bcy49g6Q6Q5oAJRAG5XvCsQnudkZruYiWkN1PFXRDv7q537H5FIavIP3VrmPZNe4QicjvInkiai/68Nvnqbbibv3Svhpn+bF+iBjlzrmau217knJlHGAMEMZtGuuRSr1hAma3GKV8pHFN3P
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006)(3023799007)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHBQaVpydFlLaVdDWHVkRjJVTVpwSlVyQW5Tb1NFN3IrMmZZN3o3T0pwc3B3?=
 =?utf-8?B?V2dQdk1vdm1KNkQ3Y0hXcTY0V0N3WERtWFE5UXhqblJoWEN3aCs3dmVrVzhB?=
 =?utf-8?B?WmxXNTJOdXdaN1Y2ZDJoMW8rV2JzbmdRYXVTVnpjbHVMc3VDVnZVSXVQRWJP?=
 =?utf-8?B?YVAxLzVZSmU5a01VNXZXSTgyK1dHRWNZVUFzeXF1S3JGZXVZVDliRFJHQUJG?=
 =?utf-8?B?RHlPelFDMHRqRDhReUJHdzF4bC9KMi8zcnhDem5yTFkzV0t1YlJiaUxoT2JE?=
 =?utf-8?B?SG9rNHg3c01LclJhQ2xIaDdkS2p0UXlaZzYwbVZiZEpyZkNIcStick1xaFJS?=
 =?utf-8?B?SGQ0YkhUTGhNNnI3MW54dmh3RlYxYnRxOTBiOGZWV2hzd1JjSHBZTHRWQzM1?=
 =?utf-8?B?TkNCa0JEeGJQNzBRM2NvWXg3WGR2bFZDU2pSOG5DMjlYS3gwMXVrUy9MYVpU?=
 =?utf-8?B?cFY1TEtDZ1JGa2xGb2JhWGk5K1lNZXdBMWFMZDNLL3JrYVptR21sQUZZZ3Y4?=
 =?utf-8?B?SCtZcWR3UGNoR2R3WllYKzBOQWYwNGlUUDhYUXl0cStob1pRZ0hOMGMwZU9u?=
 =?utf-8?B?WjdMSWJkbzJ4R0ZJZW5SM2FpMGhmKzlJZGMwUURnaDlIUzBsT2RETXQ3RFZM?=
 =?utf-8?B?Q1k0dzlQQkRPbEl2SEVIM01aWlYwVU1abjRZR3hMbFp1MTQ2a2xuVTYybUJ5?=
 =?utf-8?B?VFV4cy9HbXlpRCtybXJDcHc3K2NDSVBocVp5KzRVdXgrQXBqNVExWW1RTENW?=
 =?utf-8?B?amdMTVZPZmJ3cTBESEErN0N6b2hiYzA0bDlGR3lHdStsUU0zb1JIQVZzM2xh?=
 =?utf-8?B?STdvK0RGN2wwQkw4dytzYzAyRlpLQmVvb0lES2NYVFZGdzI3WWNtdG5ua0NV?=
 =?utf-8?B?bDZmYlRVekhvYmRsTGgwSWlKNk5SeUhCVHc0MUFGc0Y4OGlXTnlmY1BJQ2Fn?=
 =?utf-8?B?bHA2cS9aUjNBa01sZHVZT0RjZWR2VUFyRzJ4ekxTWVZjcDg1cnVwUzJkSVRB?=
 =?utf-8?B?R0pybHFxcmpHdUJ4T0JWU2JTOGpyTmwyb0dSdEJ3c1FkaFBEekxuMUUySDFL?=
 =?utf-8?B?OUJrdlhmS25JWDE4R1VDWDA2V21yV1NQWlZnS2lOTld3bVhmQ056TFpSRDk3?=
 =?utf-8?B?eGhPaVE1Y25tQUhHRHVQWC9nSmlBQ096ZmJycE5XVHZ4SWNqa1puQzAzdnF1?=
 =?utf-8?B?MDZ5OE5waFZvbGtNSStFTFVKakY4REVhbUpvL0JSVjgxN0tCTXFZQUZmeXRs?=
 =?utf-8?B?YUNqSzc2QkpQTlJ6Q2ZDdTFzd25kc0JCUllIRk95akkxYTZTbHZXaUd2L2t0?=
 =?utf-8?B?cUpHbk9NQkpwRFNHRUMrUm1xZFg0d1IwQmd0ejhYK3k5QytLN1ZDU2ZaV0hq?=
 =?utf-8?B?S1daUmhjSFpzaVRDdnR2TVpVY0JZa2RueEw4dzN5TGJEYnJDa1VYaEF1eHZ4?=
 =?utf-8?B?S3k4MHFRSkJ2N05XUzFIMjB0ejhEMGhFRWU2MzRFa0pvaElwcFR1NzkzTG13?=
 =?utf-8?B?eGFiYkU1T0drY20wODBjNllIOWZZbGNmT1JSeEZsaTk1L3IzZFdQUmJ0UnNY?=
 =?utf-8?B?dUprZGJhVkVaUFR5T0pVTTFHVUJoNDlJN21XeXhYVk1nTHhHU3o2bkVPK0Nz?=
 =?utf-8?B?Z09DRDhOc09ta1NPbWV0bC9zd1Z1ektzdVVmNU4yNU13TEwxaU0xcE4wc3FM?=
 =?utf-8?B?a3gyK2puTmFWeGJiLzh2ZXR0MXZoSTlwQ2kxT3VOZHlDWFBIMHNreGNoZ0hR?=
 =?utf-8?B?MmZqemZBWitOc1NGVkxGd005aXVBOUtiTmhVaTcvZGFsWThsYVEyZHVxRmhI?=
 =?utf-8?B?WWZOR2VJYnFLTmo2cDZzVmRnbTd5QjF3RGFqWThTc1pJMkhaUXdtM3plNkVO?=
 =?utf-8?B?VU1JRVl0LzYyZi9ZZEZLcnN5S0FGTmpmZFh5U1F6WklWZ3JFdmdSTE9rM2VO?=
 =?utf-8?B?K1lKWUpDQzlqUGFtV0pmaFdtSDZpd2t2NVJJS1RDZW9MUVBqTlB3amJreUhq?=
 =?utf-8?B?cXMrTC81OHcwejExTG1lVUJveHZGcmN0RVRpY2pkczZrYlNOTEJoQWVjMFNV?=
 =?utf-8?B?ZHpXb3h2b2hLVmZacVArSDFFQ0FWMXNxTkpkSUhueFpJU1RxQzdmRHhkM1Iy?=
 =?utf-8?B?R2haOUg5ajFPRlAxUzZqZDVXVG9odVNUakhZLzh2bkxOUmIzUHJjQ1cwSzBE?=
 =?utf-8?B?L0w5aUd0WWdrTnBPQ3o4ZG9MWGZZQnNiY3IrZm9VMThBcUV1TmRBTDdqVEh4?=
 =?utf-8?B?WHdZRkx6T0xMRElPR2N3M3owZnNJanY2VnJXUUt4U21KcjY0cm85WXNSQTcv?=
 =?utf-8?B?TUI3SFNPVWxLM0hQNUpYdVd3Q2RtTEV5VWR4a0xnYXQrYVI1V1ErZ0I3bi8z?=
 =?utf-8?Q?d30DYc+wCGOhLGiI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8F128315071B4459CB2E2A1CBB37DBE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eQKMoCUfPOUe6lLWR4aLNIVDkvHkHCJvabcvmybPQgpjCW3rng4DJPUAkS9sT18zmZA5gYqcgeZxCeDFS/8ul/JWkbLixfjb2hrcE/VZvwxKMfUaIazP5Q5MuZZSFGhrP24yrsZbLF/9AKEyz/dZIv7ofjlEslOWBoj8CUvrDibCP8RjUmgBg5qBXS1yjH2wXTIs9GP1G8Uyjp29BPEh/wd5xoGy0KaFLkeWeT3cjcYtOh4WxG2FvKiP1GsPQH0pkovV0fm0TNKCDJ/wgBbhi8hvQhj/aXUORwncWq8F9CFRluRJfY7TDtB27+3Q/S77RY6SJZD/x1QvZc3hmUaH+Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a809ca86-2925-47c7-0fbe-08debefe9864
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2026 10:23:02.0242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0aG35XnPRAzUASI90K/xOLJU7Zt3Dt37ZXLHlD+uD8DLBrbggf1KVMDtQ2Po1IGvBqQ0mhIkqzwDXt7VMitVxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8403
X-MTK: N
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk,mediateko365.onmicrosoft.com:s=selector2-mediateko365-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-37194-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[mediatek.com,kernel.org,nbd.name,collabora.com,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Ryder.Lee@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+,mediateko365.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 82041615908
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gU3VuLCAyMDI2LTA1LTMxIGF0IDEwOjU1ICswMjAwLCBMb3JlbnpvIEJpYW5jb25pIHdyb3Rl
Og0KPiBtdDc2X3R4X3N0YXR1c19za2JfYWRkKCkgemVyb2VzIHRoZSBtdDc2X3R4X2NiIHN0cnVj
dCBzdG9yZWQgYXQNCj4gaW5mby0+c3RhdHVzLnN0YXR1c19kcml2ZXJfZGF0YSB2aWEgbWVtc2V0
KCkuIFNpbmNlIGluZm8tPmNvbnRyb2wgYW5kDQo+IGluZm8tPnN0YXR1cyBhcmUgbWVtYmVycyBv
ZiB0aGUgc2FtZSB1bmlvbiBpbiBpZWVlODAyMTFfdHhfaW5mbywNCj4gdGhpcyBvdmVyd3JpdGVz
IGluZm8tPmNvbnRyb2wuZmxhZ3MuDQo+IEluIG10Nzk5Nl90eF9wcmVwYXJlX3NrYigpLCBtdDc2
X3R4X3N0YXR1c19za2JfYWRkKCkgaXMgY2FsbGVkIGJlZm9yZQ0KPiBtdDc5OTZfbWFjX3dyaXRl
X3R4d2koKSwgd2hpY2ggcmUtcmVhZHMgaW5mby0+Y29udHJvbC5mbGFncyB0bw0KPiBleHRyYWN0
DQo+IElFRUU4MDIxMV9UWF9DVFJMX01MT19MSU5LLiBCZWNhdXNlIHRoZSBmaWVsZCBoYXMgYmVl
biB6ZXJvZWQsIHRoZQ0KPiBsaW5rX2lkIGFsd2F5cyByZXNvbHZlcyB0byAwIGZvciBmcmFtZXMg
dXNpbmcgZ2xvYmFsX3djaWQsIGxlYWRpbmcgdG8NCj4gaW5jb3JyZWN0IFRYV0kgY29uZmlndXJh
dGlvbi4NCj4gRml4IHRoaXMgYnkgcGFzc2luZyBsaW5rX2lkIGFzIGFuIGV4cGxpY2l0IHBhcmFt
ZXRlciB0bw0KPiBtdDc5OTZfbWFjX3dyaXRlX3R4d2koKS4gSW4gbXQ3OTk2X3R4X3ByZXBhcmVf
c2tiKCksIHRoZSBsaW5rX2lkIGlzDQo+IGFscmVhZHkgZXh0cmFjdGVkIGZyb20gaW5mby0+Y29u
dHJvbC5mbGFncyBiZWZvcmUgdGhlIGRlc3RydWN0aXZlDQo+IG10NzZfdHhfc3RhdHVzX3NrYl9h
ZGQoKSBjYWxsLiBGb3IgdGhlIGJlYWNvbiBhbmQgaW5iYW5kIGRpc2NvdmVyeQ0KPiBjYWxsZXJz
IGluIG1jdS5jLCB1c2UgbGlua19jb25mLT5saW5rX2lkIGRpcmVjdGx5Lg0KPiANCj4gRml4ZXM6
IGYwYjBiMjM5YjhmMzYgKCJ3aWZpOiBtdDc2OiBtdDc5OTY6IHJld29yaw0KPiBtdDc5OTZfbWFj
X3dyaXRlX3R4d2koKSBmb3IgTUxPIHN1cHBvcnQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBMb3Jlbnpv
IEJpYW5jb25pIDxsb3JlbnpvQGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYyOg0K
PiAtIERvIG5vdCB1c2UgbGlua19pZCBpbiBtdDc5OTZfbWFjX3dyaXRlX3R4d2kgaWYgaXQgaXMN
Cj4gSUVFRTgwMjExX0xJTktfVU5TUEVDSUZJRUQNCj4gLSBJbiBtdDc5OTZfbWFjX3dyaXRlX3R4
d2koKSByZWx5IG9uIGxpbmtfaWQgY2FsY3VsYXRlZCBpbg0KPiDCoCBtdDc5OTZfdHhfcHJlcGFy
ZV9za2IoKS4NCj4gLSBMaW5rIHRvIHYxOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIw
MjYwNTMwLW10NzZfdHhfc3RhdHVzX3NrYl9hZGQtb3ZlcndyaXRlLWZpeC12MS0xLWUyYzMxNTFj
MzkxYUBrZXJuZWwub3JnDQo+IMKgDQo+IC0tLQ0KPiDCoGRyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3OTk2L21hYy5jwqDCoMKgIHwgMTQgKysrKy0tLS0tLS0tDQo+IC0tDQo+
IMKgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYvbWN1LmPCoMKgwqAg
fMKgIDUgKysrLS0NCj4gwqBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5
Ni9tdDc5OTYuaCB8wqAgMyArKy0NCj4gwqAzIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygr
KSwgMTMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxl
c3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYvbWFjLmMNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9t
ZWRpYXRlay9tdDc2L210Nzk5Ni9tYWMuYw0KPiBpbmRleCBjOTg0NDYwNTcyODIuLjk1YjMwNzhk
OTY2NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9t
dDc5OTYvbWFjLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9t
dDc5OTYvbWFjLmMNCj4gQEAgLTg1Niw3ICs4NTYsOCBAQCBtdDc5OTZfbWFjX3dyaXRlX3R4d2lf
ODAyMTEoc3RydWN0IG10Nzk5Nl9kZXYNCj4gKmRldiwgX19sZTMyICp0eHdpLA0KPiDCoHZvaWQg
bXQ3OTk2X21hY193cml0ZV90eHdpKHN0cnVjdCBtdDc5OTZfZGV2ICpkZXYsIF9fbGUzMiAqdHh3
aSwNCj4gwqAJCQnCoMKgIHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBtdDc2X3djaWQNCj4g
KndjaWQsDQo+IMKgCQkJwqDCoCBzdHJ1Y3QgaWVlZTgwMjExX2tleV9jb25mICprZXksIGludCBw
aWQsDQo+IC0JCQnCoMKgIGVudW0gbXQ3Nl90eHFfaWQgcWlkLCB1MzIgY2hhbmdlZCkNCj4gKwkJ
CcKgwqAgZW51bSBtdDc2X3R4cV9pZCBxaWQsIHUzMiBjaGFuZ2VkLA0KPiArCQkJwqDCoCB1bnNp
Z25lZCBpbnQgbGlua19pZCkNCj4gwqB7DQo+IMKgCXN0cnVjdCBpZWVlODAyMTFfaGRyICpoZHIg
PSAoc3RydWN0IGllZWU4MDIxMV9oZHIgKilza2ItDQo+ID5kYXRhOw0KPiDCoAlzdHJ1Y3QgaWVl
ZTgwMjExX3R4X2luZm8gKmluZm8gPSBJRUVFODAyMTFfU0tCX0NCKHNrYik7DQo+IEBAIC04NjYs
NyArODY3LDYgQEAgdm9pZCBtdDc5OTZfbWFjX3dyaXRlX3R4d2koc3RydWN0IG10Nzk5Nl9kZXYN
Cj4gKmRldiwgX19sZTMyICp0eHdpLA0KPiDCoAlib29sIGlzXzgwMjMgPSBpbmZvLT5mbGFncyAm
DQo+IElFRUU4MDIxMV9UWF9DVExfSFdfODAyMTFfRU5DQVA7DQo+IMKgCXN0cnVjdCBtdDc2X3Zp
Zl9saW5rICptbGluayA9IE5VTEw7DQo+IMKgCXN0cnVjdCBtdDc5OTZfdmlmICptdmlmOw0KPiAt
CXVuc2lnbmVkIGludCBsaW5rX2lkOw0KPiDCoAl1MTYgdHhfY291bnQgPSAxNTsNCj4gwqAJdTMy
IHZhbDsNCj4gwqAJYm9vbCBpbmJhbmRfZGlzYyA9ICEhKGNoYW5nZWQgJg0KPiAoQlNTX0NIQU5H
RURfVU5TT0xfQkNBU1RfUFJPQkVfUkVTUCB8DQo+IEBAIC04NzQsMTcgKzg3NCwxMSBAQCB2b2lk
IG10Nzk5Nl9tYWNfd3JpdGVfdHh3aShzdHJ1Y3QgbXQ3OTk2X2Rldg0KPiAqZGV2LCBfX2xlMzIg
KnR4d2ksDQo+IMKgCWJvb2wgYmVhY29uID0gISEoY2hhbmdlZCAmIChCU1NfQ0hBTkdFRF9CRUFD
T04gfA0KPiDCoAkJCQnCoMKgwqAgQlNTX0NIQU5HRURfQkVBQ09OX0VOQUJMRUQpKSAmJg0KPiAo
IWluYmFuZF9kaXNjKTsNCj4gwqANCj4gLQlpZiAod2NpZCAhPSAmZGV2LT5tdDc2Lmdsb2JhbF93
Y2lkKQ0KPiAtCQlsaW5rX2lkID0gd2NpZC0+bGlua19pZDsNCj4gLQllbHNlDQo+IC0JCWxpbmtf
aWQgPSB1MzJfZ2V0X2JpdHMoaW5mby0+Y29udHJvbC5mbGFncywNCj4gLQkJCQnCoMKgwqDCoMKg
wqAgSUVFRTgwMjExX1RYX0NUUkxfTUxPX0xJTkspOw0KPiAtDQo+IMKgCW12aWYgPSB2aWYgPyAo
c3RydWN0IG10Nzk5Nl92aWYgKil2aWYtPmRydl9wcml2IDogTlVMTDsNCj4gwqAJaWYgKG12aWYp
IHsNCj4gwqAJCWlmICh3Y2lkLT5vZmZjaGFubmVsKQ0KPiDCoAkJCW1saW5rID0gcmN1X2RlcmVm
ZXJlbmNlKG12aWYtDQo+ID5tdDc2Lm9mZmNoYW5uZWxfbGluayk7DQo+IC0JCWlmICghbWxpbmsp
DQo+ICsJCWlmICghbWxpbmsgJiYgbGlua19pZCAhPSBJRUVFODAyMTFfTElOS19VTlNQRUNJRklF
RCkNCj4gwqAJCQltbGluayA9IHJjdV9kZXJlZmVyZW5jZShtdmlmLQ0KPiA+bXQ3Ni5saW5rW2xp
bmtfaWRdKTsNCj4gwqAJfQ0KPiDCoA0KPiBAQCAtMTA5Niw3ICsxMDkwLDcgQEAgaW50IG10Nzk5
Nl90eF9wcmVwYXJlX3NrYihzdHJ1Y3QgbXQ3Nl9kZXYNCj4gKm1kZXYsIHZvaWQgKnR4d2lfcHRy
LA0KPiDCoAkvKiBUcmFuc21pdCBub24gcW9zIGRhdGEgYnkgODAyLjExIGhlYWRlciBhbmQgbmVl
ZCB0byBmaWxsDQo+IHR4ZCBieSBob3N0Ki8NCj4gwqAJaWYgKCFpc184MDIzIHx8IHBpZCA+PSBN
VF9QQUNLRVRfSURfRklSU1QpDQo+IMKgCQltdDc5OTZfbWFjX3dyaXRlX3R4d2koZGV2LCB0eHdp
X3B0ciwgdHhfaW5mby0+c2tiLA0KPiB3Y2lkLCBrZXksDQo+IC0JCQkJwqDCoMKgwqDCoCBwaWQs
IHFpZCwgMCk7DQo+ICsJCQkJwqDCoMKgwqDCoCBwaWQsIHFpZCwgMCwgbGlua19pZCk7DQo+IMKg
DQo+IMKgCS8qIE1UNzk5NiBhbmQgTVQ3OTkyIHJlcXVpcmUgZHJpdmVyIHRvIHByb3ZpZGUgdGhl
IE1BQyBUWFANCj4gZm9yIEFkZEJBDQo+IMKgCSAqIHJlcQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYvbWN1LmMNCj4gYi9kcml2ZXJzL25l
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tY3UuYw0KPiBpbmRleCA4YmU0MGQ2MGFk
MjkuLmExNGM2MzQzODkyMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVk
aWF0ZWsvbXQ3Ni9tdDc5OTYvbWN1LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVk
aWF0ZWsvbXQ3Ni9tdDc5OTYvbWN1LmMNCj4gQEAgLTMxMDMsNyArMzEwMyw3IEBAIG10Nzk5Nl9t
Y3VfYmVhY29uX2NvbnQoc3RydWN0IG10Nzk5Nl9kZXYgKmRldiwNCj4gwqANCj4gwqAJYnVmID0g
KHU4ICopYmNuICsgc2l6ZW9mKCpiY24pOw0KPiDCoAltdDc5OTZfbWFjX3dyaXRlX3R4d2koZGV2
LCAoX19sZTMyICopYnVmLCBza2IsIHdjaWQsIE5VTEwsDQo+IDAsIDAsDQo+IC0JCQnCoMKgwqDC
oMKgIEJTU19DSEFOR0VEX0JFQUNPTik7DQo+ICsJCQnCoMKgwqDCoMKgIEJTU19DSEFOR0VEX0JF
QUNPTiwgbGlua19jb25mLQ0KPiA+bGlua19pZCk7DQo+IMKgDQo+IMKgCW1lbWNweShidWYgKyBN
VF9UWERfU0laRSwgc2tiLT5kYXRhLCBza2ItPmxlbik7DQo+IMKgfQ0KPiBAQCAtMzI0OSw3ICsz
MjQ5LDggQEAgaW50IG10Nzk5Nl9tY3VfYmVhY29uX2luYmFuZF9kaXNjb3Yoc3RydWN0DQo+IG10
Nzk5Nl9kZXYgKmRldiwNCj4gwqANCj4gwqAJYnVmID0gKHU4ICopdGx2ICsgc2l6ZW9mKCpkaXNj
b3YpOw0KPiDCoA0KPiAtCW10Nzk5Nl9tYWNfd3JpdGVfdHh3aShkZXYsIChfX2xlMzIgKilidWYs
IHNrYiwgd2NpZCwgTlVMTCwNCj4gMCwgMCwgY2hhbmdlZCk7DQo+ICsJbXQ3OTk2X21hY193cml0
ZV90eHdpKGRldiwgKF9fbGUzMiAqKWJ1Ziwgc2tiLCB3Y2lkLCBOVUxMLA0KPiAwLCAwLA0KPiAr
CQkJwqDCoMKgwqDCoCBjaGFuZ2VkLCBsaW5rX2NvbmYtPmxpbmtfaWQpOw0KPiDCoA0KPiDCoAlt
ZW1jcHkoYnVmICsgTVRfVFhEX1NJWkUsIHNrYi0+ZGF0YSwgc2tiLT5sZW4pOw0KPiDCoA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYvbXQ3
OTk2LmgNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tdDc5
OTYuaA0KPiBpbmRleCAwZGM0MTk4ZmNmOGIuLjBkNjQ4ODUyMmJhNyAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYvbXQ3OTk2LmgNCj4gKysr
IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYvbXQ3OTk2LmgNCj4g
QEAgLTg3NCw3ICs4NzQsOCBAQCB2b2lkIG10Nzk5Nl9tYWNfZW5hYmxlX25mKHN0cnVjdCBtdDc5
OTZfZGV2ICpkZXYsDQo+IHU4IGJhbmQpOw0KPiDCoHZvaWQgbXQ3OTk2X21hY193cml0ZV90eHdp
KHN0cnVjdCBtdDc5OTZfZGV2ICpkZXYsIF9fbGUzMiAqdHh3aSwNCj4gwqAJCQnCoMKgIHN0cnVj
dCBza19idWZmICpza2IsIHN0cnVjdCBtdDc2X3djaWQNCj4gKndjaWQsDQo+IMKgCQkJwqDCoCBz
dHJ1Y3QgaWVlZTgwMjExX2tleV9jb25mICprZXksIGludCBwaWQsDQo+IC0JCQnCoMKgIGVudW0g
bXQ3Nl90eHFfaWQgcWlkLCB1MzIgY2hhbmdlZCk7DQo+ICsJCQnCoMKgIGVudW0gbXQ3Nl90eHFf
aWQgcWlkLCB1MzIgY2hhbmdlZCwNCj4gKwkJCcKgwqAgdW5zaWduZWQgaW50IGxpbmtfaWQpOw0K
PiDCoHZvaWQgbXQ3OTk2X21hY191cGRhdGVfYmVhY29ucyhzdHJ1Y3QgbXQ3OTk2X3BoeSAqcGh5
KTsNCj4gwqB2b2lkIG10Nzk5Nl9tYWNfc2V0X2NvdmVyYWdlX2NsYXNzKHN0cnVjdCBtdDc5OTZf
cGh5ICpwaHkpOw0KPiDCoHZvaWQgbXQ3OTk2X21hY193b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAq
d29yayk7DQo+IA0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IDQ5MTNmNDQxNjdjZjM1YTk1MzZlOWVl
YzczNTJlMTViMmRlMGM1NzMNCj4gY2hhbmdlLWlkOiAyMDI2MDUzMC1tdDc2X3R4X3N0YXR1c19z
a2JfYWRkLW92ZXJ3cml0ZS1maXgtODU4MThhOWJiMzFmDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+
IA0KPiANCldlIG1pZ2h0IGV4cGFuZCBmbGFncyBmdXJ0aGVyIHNvIHRoaXMgc3RpbGwgZG9lc24n
dCBzb2x2ZSB0aGUgaXNzdWUgb2YNCmZsYWdzIGJlaW5nIGNsZWFyZWQgLSBpdCBvbmx5IHdvcmtz
IGZvciBNTE8gZmxhZy4gQW5kIHRoZSBkZXZlbG9wZXJzDQpzdGlsbCB3b24ndCBlYXNpbHkgbm90
aWNlIHRoYXQgdGhlIGZsYWdzIGFyZSBiZWluZyBjbGVhcmVkLg0KIA0KT3VyIGN1cnJlbnQgYXBw
cm9hY2ggaXMgdG8gbW92ZSBtZW1zZXQgYWZ0ZXIgbXQ3OTk2X21hY193cml0ZV90eHdpKCkuDQpJ
dCdzIG1vcmUgZmxleGlibGUgYW5kIHdlIGRvbid0IGhhdmUgdG8gY29uc3RhbnRseSBjaGFuZ2Ug
dGhlIGZ1bmN0aW9uDQpwYXJhbWV0ZXJzIGp1c3QgZm9yIHRoZSBmbGFncy4NCg0KUnlkZXINCg0K

