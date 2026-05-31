Return-Path: <linux-wireless+bounces-37193-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Wvm1JJcIHGqFIwkAu9opvQ
	(envelope-from <linux-wireless+bounces-37193-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 12:08:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05500615822
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 12:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3F4C301BA70
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 10:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC9D3655C2;
	Sun, 31 May 2026 10:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LmBiyoTi";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="jZLCxlLQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C841C364EB2
	for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 10:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780222097; cv=fail; b=tD6IO0C5RkBTSrRUI6oLs3uZdrW8El1GJsyWVe+xGdl/hLzAknejSbXCodk9KEPnltn/l/ecm5xOxUL1TzvhFTqmZ6a/yQvyOCIdKKj4cuYZvgDV0pKJvMEDZGG2piTeXAsR5SzRlgfDlPcgIf/torkhN72yGFly5kGwJm4e14Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780222097; c=relaxed/simple;
	bh=NzCdCTF7guBws5rvlLkitkiflaHCKWum/DNpQBloItQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cRnJur87+iIRyyFvBPXM0RAXZWLmr1M52G+YCg3QeCNCd9ukn73yRMhxCpCI0w5xLeOLjvpESSKWDqBKdcut3YJGfOabwOV/siJeW0d0VOStNiYnQLibsCpsL3BWB+95oaQrI1jutCAGpj3c6EGJOmK3DuAr3oZsECMUqCOMMCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=LmBiyoTi; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=jZLCxlLQ; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9b9426045cd811f18dc8c9802ae25ab1-20260531
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=NzCdCTF7guBws5rvlLkitkiflaHCKWum/DNpQBloItQ=;
	b=LmBiyoTi+tI2lwAi68g+CvYdKxYov0ZZdmlq5Inp0LDOgQta2kcbNtq3+6nJe2qVpPW3GL6RzF46nFvczIcEXJwkZqGTuPxkhx7o5McTUPxcjZSRRSOZdtgs6mBJZHZ/5WzJ77bgR8KCxx6tU2gc9t6G64kKL8M+1HzoXF6Mg04=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:e7e6dcf7-c853-4997-9252-4f75dd958b0b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:6bc47e30-3aec-4081-ae32-d2e919a47e1d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|136|836|865|
	888|898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,Q
	S:nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9b9426045cd811f18dc8c9802ae25ab1-20260531
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1011718746; Sun, 31 May 2026 18:08:01 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 31 May 2026 18:08:00 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Sun, 31 May 2026 18:08:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYBNxjgxWCg9p5Upe8pa3sgGHDTadfSZvF5PMpGXz6uqDNdmz/o3phXoqeimxYBiEguzBBYw1X3oDVIT3YMWQEp1ZcXVCqmfXzZFg623Q7HyCpb0mF7jbgmBrL3Sj80iDzAWJ5XQO1eaOx6O3lzNZ95AbOFlofQUXYn3kAUTr8lTfGrnp6+5eOWU/XjHnl+ZOMlLl9GmB+9JhyCZiE5s9RgNeqTV16qX1muRH3hgQOI6APd+A6sHLU0C4TnCkttd2fSqzGWafX73KOmCLVbfL6rKNNpDAwVw7cjT0cRTu3OCvRzo7wQ/ylIcZ3H+k3haj8zDetxWQSwLlQqm/uDkvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzCdCTF7guBws5rvlLkitkiflaHCKWum/DNpQBloItQ=;
 b=nX7Wq1vWdpNP0reIO7lFznatb6x5E4fXOJTlbvjZnhR8406y1upvjmV4FziRaosBIFWPN2LELn0km+jEe+94ZEraGgTgUoz7wTJ3Nqfke16j077fS37/wWjrqiTWLwmnnW2/ZWxdwUVBjFs6Yg4h1MO54WhOa6OXU4XFatR1SjBmT6eWWMM3UWUddZVBjqR1DQyut6StJ4l0t4/Rx++i9Hp8ogWa7zofi2lBO5ahmUImC/63FhWRtSS7fjbXzrO4pBeOzBBRWsCcZj6hkq5IYqm8dsSt5anJL43euCwjbR5NFsPSICrll4XaBZdVvi3HCr8UJeO4HP2gyHSs9lfxwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzCdCTF7guBws5rvlLkitkiflaHCKWum/DNpQBloItQ=;
 b=jZLCxlLQX12OwBxbDhWBkQr3pelo7TPuDH8XIuBI5UL8jcpqQipZAuQXSryUILYhcMC+suCV+tRcdAAHqu6BY+4TQf6nC8xe0kR1EqRItW4SzMS0hd2CZ6d0bvH5ny7hO4gLK+56s8R2cE+v8pJjjv65KAV/c/ZA1MaN+tsAq4s=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by KUXPR03MB10526.apcprd03.prod.outlook.com (2603:1096:d10:68::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.6; Sun, 31 May 2026
 10:07:56 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059%6]) with mapi id 15.21.0092.005; Sun, 31 May 2026
 10:07:56 +0000
From: Ryder Lee <Ryder.Lee@mediatek.com>
To: "lorenzo@kernel.org" <lorenzo@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>,
	"nbd@nbd.name" <nbd@nbd.name>, Roy-CH Luo <Roy-CH.Luo@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?utf-8?B?Q2h1aS1oYW8gQ2hpdSAo6YKx5Z6C5rWpKQ==?=
	<Chui-hao.Chiu@mediatek.com>, Sean Wang <Sean.Wang@mediatek.com>,
	=?utf-8?B?Qm8gSmlhbyAo54Sm5rOiKQ==?= <Bo.Jiao@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: mt76: mt7996: fix reading zeroed
 info->control.flags after mt76_tx_status_skb_add()
Thread-Topic: [PATCH] wifi: mt76: mt7996: fix reading zeroed
 info->control.flags after mt76_tx_status_skb_add()
Thread-Index: AQHc8EibITbtuDCi7Ue2BeD1yvMve7YnYuMAgABVfwCAADHAAA==
Date: Sun, 31 May 2026 10:07:56 +0000
Message-ID: <d756865286a14cf8402510817bd702228013fe8a.camel@mediatek.com>
References: <20260530-mt76_tx_status_skb_add-overwrite-fix-v1-1-e2c3151c391a@kernel.org>
	 <6be1d6e67bcb5500c9d1e92449ce7757f6166d22.camel@mediatek.com>
	 <ahvewFh2NuB5MO8t@lore-desk>
In-Reply-To: <ahvewFh2NuB5MO8t@lore-desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|KUXPR03MB10526:EE_
x-ms-office365-filtering-correlation-id: bce423f2-381e-4fa2-be84-08debefc7cb9
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|22082099003|18002099003|6133799003|3023799007|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: 6rTWt35ao7L5ID9MelDYmsqo7vf6nKFJI+R9a2152zR1wmRhR/VPFV27TruRc19DT3ZQ9/OrDSpXHGBGEx9uYUHd1yztY30r3hQmPjKeRXaBQW/GgbkEbyP+S39kA3CWYqLVYdNV43q6EtyH/FnPmKWwolMQRFmsxlVUoDflCHxJosHATYoIwpj/VNPGJUzIW/GzBwqYOTDMxP405aZ6bBEIYyVU+NMhOUlinlgAP/k23+yX2sSdoDS5S4X9rTcaUsJfDEbxKrPv3+FpklYrKz1xDsRZr4j3/38l5oE0gaQBZ2jmK2you+jvdWKaYBm8tkW6DcgEebI5QSqy3kk9OcAtvHLvnre1eD9h5nFV2skRHGZopWg0mUmz+Dapo8CIsE9jbbN2O+pjW6p4Uh3SJAxcN6KJAg1IEgwyMENQAbHfmvGxLRBlKJWRVLjPTqwHoCjwlOSHvJSiSqa6uZnK+PNmCEi2QBkrfe2qi9OTfvsAI9bIUUNHkcOVU++j1q6bd97maS5hb+H2rALALnCCPfbRkHPYb6PtPkRQDis+FM09d2I6cXCPwAED3SToQp9b6QMM9+5c8Wd3wsnMMujZ9PzW8VNQX0cptlLGYZTWYULUmJipLbNK7D1ib3dmv47te8K66oOJ8oB+5J0rp19ZUoSmDkZ2XkqennbOWSVm7GA10aV5ppke6q+gwIN/a77dgjzu/4djcw3HqmMS1m0chaqGGU2F4sICfcoBVlFTFsW/dGLq2iBhIQhaJIGfXFKR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(18002099003)(6133799003)(3023799007)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGZsYUJlUEtkS0RyalBZbFEvMG01cUtvTWVMZnE5OVBiTkQ0LytoYkVwQ2ho?=
 =?utf-8?B?VnYwU2xyNlJabHVjeDk3UmlXMUh4U28zTERKYlIyZ2pSOVlqbUdXaWVjRHRS?=
 =?utf-8?B?THF0RHJZNVZXSDF4aGxvTjVBS0ZrMkRHS1cvUzhNeWRTTnVyamw2TkU4L09H?=
 =?utf-8?B?WmNKbi9vRTU4Q2NxRTlBY2pzU3E1OFNXTSthVGZ6QzhwRXhmVmtycW1HRG9t?=
 =?utf-8?B?aU96TkpvT3RrK3RCQ2ZzQUtFV3N0cFZndVZuV0x6VE84dzUrZzROd3ZubTNC?=
 =?utf-8?B?Nnd2MU4wWXByU3NEcm5QMnBLVXhFdHRGbXBmVEhTT3lqZW10eWk5Z1M1N2x3?=
 =?utf-8?B?VmdyckwrVTJCeGFUSWsrSnJhTE1LYlcwQytrSXFQSmxpazRLRDNzMUJZOFVF?=
 =?utf-8?B?VzcvZTYwNEQ4SElHWmt6LzFYOVhFK0lxSHRRZENOcDRiRGNtWTAzQXNuaFpk?=
 =?utf-8?B?QWNtUU15bjJMNmRKbU05QUc4U2xlYzJ4ZVFhSXc0clRUaERXcWljd3JSRzdu?=
 =?utf-8?B?Ym92SHFkeUp5enRoT1VNRlhqNFBoYmFHOGlkUm9qVFgwcDN5NkFVTGtRbGFX?=
 =?utf-8?B?RC9pR0tzcDFFSllHbzg0bHZMZnh1SUN6cDdLYnNJeGJXcHcyWk9NWTE3Slly?=
 =?utf-8?B?aThsQ3lmYUVmVGQrak5ZZmN5U2JJNkg0cUc5K1lOR1VDMUZ4R0lvZHhRcThi?=
 =?utf-8?B?YmdZRGRDUmJRcmplS0RoY1NXRDEzRGczbnU1ajNhb3dkZ2d2K2dTRjVROGt5?=
 =?utf-8?B?T3pabmt5Vkp3TjVSeVFPKysrZjVtd0FNTVJ0T0hSVkR6bUk2eXZpRGtEbklw?=
 =?utf-8?B?NFkrZmRPRFVnMk40MnByN0g4MDFsTVhOYlgyRjJncHpCYXMxUjNQOG4xaS9z?=
 =?utf-8?B?ZmtISGZjTk03RGZ6dUc3MXNnMFNKSStOamEzV2NDb0RGQktPWGZodkdFVXJl?=
 =?utf-8?B?emZkdWc5Mkx3YlFPUkl6Q2VkVmtuOHhIM25US3dMN0V0Vm1HcXVxZkpPWitJ?=
 =?utf-8?B?MzBTeFNwdmF0QnpUMWpXK0h0K0JQcnRHWUY0SElHbURmYWIyQlhjYjZBbFBh?=
 =?utf-8?B?Y1FCS0dzdUlPcWVPOGYxQUpCRmpsQUJMZkoyYzRhZm80dU9jcmhxcTZsU0Zh?=
 =?utf-8?B?RTlkbk9HSisyU21nMFFYOGVWSFVyWis5UndTQnBUL1luZXRxMjh3Vy9DMlNy?=
 =?utf-8?B?WjhJc2NpR0lWeWg2b083ZEVnc3ovWk5qYVc0NmJIMHNudkZxS0k0QzF2N1Qx?=
 =?utf-8?B?eWkzV3V0Vk9VS1AxaS9QWDEyTk9VNjhMdW5hOUtBbGZaUDFDbXQrN0o1OHEx?=
 =?utf-8?B?cXViSVN1R3MzOEU1Qi90anYrQkRyZlJCcGowZFp4T1JGOXpKZkVEUkhMMXFq?=
 =?utf-8?B?K1JVcmFmOXl3Zk0zN05kd2VHVmZoQVRoNXZZRXRRMThic1FVSmFDeExpbUMz?=
 =?utf-8?B?T1pJODNEUUJ1YkN3ZHFPRHNUSGlGZHZCWTJhZ1o2U1NLOWowSWZ6QVZsdnp3?=
 =?utf-8?B?N25LN2JOcTZTSXIyaHFpQk9FWkpXdzFmMVFjSktRaVQ1MTlhWWVKK3BwYXln?=
 =?utf-8?B?NmhyUUhldVljem55WjA0OVhiUzFSTkFCQkYvNG8rWHhVR245bFdPdDdEbUpu?=
 =?utf-8?B?VzVUWUppTlovcmpHMEJQdDhWQzdGQW8wTk9JQWJsNmlpakdTc3o1N1BXdUd5?=
 =?utf-8?B?S2c4VWROdWxiYTIzYXJTL1lDYkRjRGV2REUrZm1xc3JvaXpWRmNlWVhJbU1O?=
 =?utf-8?B?dmtuOUFkZzhMd0N5OGNCUzhZblhNb0Q2bGRtUGplS0h0VTgrd2FlQUFkUXdI?=
 =?utf-8?B?aVk0bVU2cUpWdTFZZnlyazkxT3VsVVdTRkY4S2k1SFFnZHk4UjVUbEswSFJE?=
 =?utf-8?B?THp3NTBXeXk3V0dkTS9XaXNlSGRrTGJsYUZmUUNFclNoQ09yeGluRHFJTzRS?=
 =?utf-8?B?aGZIK2hvNlZrNFIzSDhiT1JpOVlPRVlrNXM5U2FxNFFmM0loQUlrSGVXSmZH?=
 =?utf-8?B?M1FFR3ZHUjFDdUFPSHBxT1F0aElIOVlQUkkrN3dBWjh5eThvTFJJSTdTZGVr?=
 =?utf-8?B?NWF3NkRJU1JGbjhydE5YN2oxaG1wYSt6b3JsTmh5dXlmdkdlZ25UYTBIL2Ry?=
 =?utf-8?B?NFFmcHVoT2o0YnE2QWVNWGdydVRVNjdzdUcvandaeEhHNkR5cWFmaHpCZU0z?=
 =?utf-8?B?ak1BV05ycW1LSXBkaGtBZkFFSmMzM2xEZnBMWTRlSWVlZ1h1RGlTVENuUkVx?=
 =?utf-8?B?amNKUVhUTXdOc3dXRW5YT01YWS9nVkN6em1uL2psWEVseWgxWWtXM2JkdmVO?=
 =?utf-8?B?TW40Z2ZJNmtFNkpJeE9iQTNvRE5pMFlsaXhiVFREQ2xlYmdLNlNEdjVDU29z?=
 =?utf-8?Q?nKmMMOE7zcGw/cVg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C78A6233EBD7CD4CA47BABEFBD4CA50E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Al/+KETRsgPz6ELV/T6VZaihqvjGbrTq1TYYfw9v+Qco4SeezTUoyVJOjnFe0juTekLJP/jlHItHcRG1vB7cI1xR4A4/ECvx2Xjf4bfLyj6RM1iLOEKNipYB/52yoU6QTpbknjUTsOD/LaJtMtWzrQTm8YxUPbhgpYZjI0eHWth0yjAFXQkuvXuBT5f8PdF1KlEJA3vT2d5qLfjHnmfuHK5U2Go+xprbQAEXD5VFBbHK2oFbdJoGUVCBYoIGaTWIDVEHGTziSjJIrUhT6cheTw6qXZ5IsIjcpO93sJ23y6G/OYKXa+aQOoo6I0zQyKjcE3a9DUpqXRwDMCcwiWBdHQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce423f2-381e-4fa2-be84-08debefc7cb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2026 10:07:56.6558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: daAXmUndWyu//QYPw4PsXOK+uCHWtNqX05HbcrFjgRuxni6lUNj458GYJ1mcuDuCK/UsgnhT2HAhCKpZDzlN0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR03MB10526
X-MTK: N
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk,mediateko365.onmicrosoft.com:s=selector2-mediateko365-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37193-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[lists.infradead.org,mediatek.com,nbd.name,collabora.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Ryder.Lee@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+,mediateko365.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 05500615822
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gU3VuLCAyMDI2LTA1LTMxIGF0IDA5OjA5ICswMjAwLCBsb3JlbnpvQGtlcm5lbC5vcmcgd3Jv
dGU6DQo+ID4gT24gU2F0LCAyMDI2LTA1LTMwIGF0IDE3OjI1ICswMjAwLCBMb3JlbnpvIEJpYW5j
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
ID4gPiDCoGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTk2L21hYy5jwqDC
oMKgIHwgOSArKystLS0tLS0NCj4gPiA+IMKgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsv
bXQ3Ni9tdDc5OTYvbWN1LmPCoMKgwqAgfCA1ICsrKy0tDQo+ID4gPiDCoGRyaXZlcnMvbmV0L3dp
cmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTk2L210Nzk5Ni5oIHwgMyArKy0NCj4gPiA+IMKgMyBm
aWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+ID4gPiANCj4g
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5
Ni9tYWMuYw0KPiA+ID4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5
Ni9tYWMuYw0KPiA+ID4gaW5kZXggYzk4NDQ2MDU3MjgyLi4yZDNmODBiM2U0MWEgMTAwNjQ0DQo+
ID4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tYWMu
Yw0KPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYv
bWFjLmMNCj4gPiA+IEBAIC04NTYsNyArODU2LDggQEAgbXQ3OTk2X21hY193cml0ZV90eHdpXzgw
MjExKHN0cnVjdCBtdDc5OTZfZGV2DQo+ID4gPiAqZGV2LCBfX2xlMzIgKnR4d2ksDQo+ID4gPiDC
oHZvaWQgbXQ3OTk2X21hY193cml0ZV90eHdpKHN0cnVjdCBtdDc5OTZfZGV2ICpkZXYsIF9fbGUz
MiAqdHh3aSwNCj4gPiA+IMKgCQkJwqDCoCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgbXQ3
Nl93Y2lkDQo+ID4gPiAqd2NpZCwNCj4gPiA+IMKgCQkJwqDCoCBzdHJ1Y3QgaWVlZTgwMjExX2tl
eV9jb25mICprZXksIGludA0KPiA+ID4gcGlkLA0KPiA+ID4gLQkJCcKgwqAgZW51bSBtdDc2X3R4
cV9pZCBxaWQsIHUzMiBjaGFuZ2VkKQ0KPiA+ID4gKwkJCcKgwqAgZW51bSBtdDc2X3R4cV9pZCBx
aWQsIHUzMiBjaGFuZ2VkLA0KPiA+ID4gKwkJCcKgwqAgdW5zaWduZWQgaW50IGxpbmtfaWQpDQo+
ID4gPiDCoHsNCj4gPiA+IMKgCXN0cnVjdCBpZWVlODAyMTFfaGRyICpoZHIgPSAoc3RydWN0IGll
ZWU4MDIxMV9oZHIgKilza2ItDQo+ID4gPiA+IGRhdGE7DQo+ID4gPiDCoAlzdHJ1Y3QgaWVlZTgw
MjExX3R4X2luZm8gKmluZm8gPSBJRUVFODAyMTFfU0tCX0NCKHNrYik7DQo+ID4gPiBAQCAtODY2
LDcgKzg2Nyw2IEBAIHZvaWQgbXQ3OTk2X21hY193cml0ZV90eHdpKHN0cnVjdCBtdDc5OTZfZGV2
DQo+ID4gPiAqZGV2LCBfX2xlMzIgKnR4d2ksDQo+ID4gPiDCoAlib29sIGlzXzgwMjMgPSBpbmZv
LT5mbGFncyAmDQo+ID4gPiBJRUVFODAyMTFfVFhfQ1RMX0hXXzgwMjExX0VOQ0FQOw0KPiA+ID4g
wqAJc3RydWN0IG10NzZfdmlmX2xpbmsgKm1saW5rID0gTlVMTDsNCj4gPiA+IMKgCXN0cnVjdCBt
dDc5OTZfdmlmICptdmlmOw0KPiA+ID4gLQl1bnNpZ25lZCBpbnQgbGlua19pZDsNCj4gPiA+IMKg
CXUxNiB0eF9jb3VudCA9IDE1Ow0KPiA+ID4gwqAJdTMyIHZhbDsNCj4gPiA+IMKgCWJvb2wgaW5i
YW5kX2Rpc2MgPSAhIShjaGFuZ2VkICYNCj4gPiA+IChCU1NfQ0hBTkdFRF9VTlNPTF9CQ0FTVF9Q
Uk9CRV9SRVNQIHwNCj4gPiA+IEBAIC04NzYsOSArODc2LDYgQEAgdm9pZCBtdDc5OTZfbWFjX3dy
aXRlX3R4d2koc3RydWN0IG10Nzk5Nl9kZXYNCj4gPiA+ICpkZXYsIF9fbGUzMiAqdHh3aSwNCj4g
PiA+IMKgDQo+ID4gPiDCoAlpZiAod2NpZCAhPSAmZGV2LT5tdDc2Lmdsb2JhbF93Y2lkKQ0KPiA+
ID4gwqAJCWxpbmtfaWQgPSB3Y2lkLT5saW5rX2lkOw0KPiA+ID4gLQllbHNlDQo+ID4gPiAtCQls
aW5rX2lkID0gdTMyX2dldF9iaXRzKGluZm8tPmNvbnRyb2wuZmxhZ3MsDQo+ID4gPiAtCQkJCcKg
wqDCoMKgwqDCoA0KPiA+ID4gSUVFRTgwMjExX1RYX0NUUkxfTUxPX0xJTkspOw0KPiA+ID4gwqAN
Cj4gPiA+IMKgCW12aWYgPSB2aWYgPyAoc3RydWN0IG10Nzk5Nl92aWYgKil2aWYtPmRydl9wcml2
IDogTlVMTDsNCj4gPiA+IMKgCWlmIChtdmlmKSB7DQo+ID4gPiBAQCAtMTA5Niw3ICsxMDkzLDcg
QEAgaW50IG10Nzk5Nl90eF9wcmVwYXJlX3NrYihzdHJ1Y3QgbXQ3Nl9kZXYNCj4gPiA+ICptZGV2
LCB2b2lkICp0eHdpX3B0ciwNCj4gPiA+IMKgCS8qIFRyYW5zbWl0IG5vbiBxb3MgZGF0YSBieSA4
MDIuMTEgaGVhZGVyIGFuZCBuZWVkIHRvDQo+ID4gPiBmaWxsDQo+ID4gPiB0eGQgYnkgaG9zdCov
DQo+ID4gPiDCoAlpZiAoIWlzXzgwMjMgfHwgcGlkID49IE1UX1BBQ0tFVF9JRF9GSVJTVCkNCj4g
PiA+IMKgCQltdDc5OTZfbWFjX3dyaXRlX3R4d2koZGV2LCB0eHdpX3B0ciwgdHhfaW5mby0NCj4g
PiA+ID5za2IsDQo+ID4gPiB3Y2lkLCBrZXksDQo+ID4gPiAtCQkJCcKgwqDCoMKgwqAgcGlkLCBx
aWQsIDApOw0KPiA+ID4gKwkJCQnCoMKgwqDCoMKgIHBpZCwgcWlkLCAwLCBsaW5rX2lkKTsNCj4g
PiA+IMKgDQo+ID4gPiDCoAkvKiBNVDc5OTYgYW5kIE1UNzk5MiByZXF1aXJlIGRyaXZlciB0byBw
cm92aWRlIHRoZSBNQUMNCj4gPiA+IFRYUA0KPiA+ID4gZm9yIEFkZEJBDQo+ID4gPiDCoAkgKiBy
ZXENCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2
L210Nzk5Ni9tY3UuYw0KPiA+ID4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2
L210Nzk5Ni9tY3UuYw0KPiA+ID4gaW5kZXggOGJlNDBkNjBhZDI5Li5hMTRjNjM0Mzg5MjMgMTAw
NjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5
Ni9tY3UuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9t
dDc5OTYvbWN1LmMNCj4gPiA+IEBAIC0zMTAzLDcgKzMxMDMsNyBAQCBtdDc5OTZfbWN1X2JlYWNv
bl9jb250KHN0cnVjdCBtdDc5OTZfZGV2DQo+ID4gPiAqZGV2LA0KPiA+ID4gwqANCj4gPiA+IMKg
CWJ1ZiA9ICh1OCAqKWJjbiArIHNpemVvZigqYmNuKTsNCj4gPiA+IMKgCW10Nzk5Nl9tYWNfd3Jp
dGVfdHh3aShkZXYsIChfX2xlMzIgKilidWYsIHNrYiwgd2NpZCwNCj4gPiA+IE5VTEwsDQo+ID4g
PiAwLCAwLA0KPiA+ID4gLQkJCcKgwqDCoMKgwqAgQlNTX0NIQU5HRURfQkVBQ09OKTsNCj4gPiA+
ICsJCQnCoMKgwqDCoMKgIEJTU19DSEFOR0VEX0JFQUNPTiwgbGlua19jb25mLQ0KPiA+ID4gPiBs
aW5rX2lkKTsNCj4gPiA+IMKgDQo+ID4gPiDCoAltZW1jcHkoYnVmICsgTVRfVFhEX1NJWkUsIHNr
Yi0+ZGF0YSwgc2tiLT5sZW4pOw0KPiA+ID4gwqB9DQo+ID4gPiBAQCAtMzI0OSw3ICszMjQ5LDgg
QEAgaW50IG10Nzk5Nl9tY3VfYmVhY29uX2luYmFuZF9kaXNjb3Yoc3RydWN0DQo+ID4gPiBtdDc5
OTZfZGV2ICpkZXYsDQo+ID4gPiDCoA0KPiA+ID4gwqAJYnVmID0gKHU4ICopdGx2ICsgc2l6ZW9m
KCpkaXNjb3YpOw0KPiA+ID4gwqANCj4gPiA+IC0JbXQ3OTk2X21hY193cml0ZV90eHdpKGRldiwg
KF9fbGUzMiAqKWJ1Ziwgc2tiLCB3Y2lkLA0KPiA+ID4gTlVMTCwNCj4gPiA+IDAsIDAsIGNoYW5n
ZWQpOw0KPiA+ID4gKwltdDc5OTZfbWFjX3dyaXRlX3R4d2koZGV2LCAoX19sZTMyICopYnVmLCBz
a2IsIHdjaWQsDQo+ID4gPiBOVUxMLA0KPiA+ID4gMCwgMCwNCj4gPiA+ICsJCQnCoMKgwqDCoMKg
IGNoYW5nZWQsIGxpbmtfY29uZi0+bGlua19pZCk7DQo+ID4gPiDCoA0KPiA+ID4gwqAJbWVtY3B5
KGJ1ZiArIE1UX1RYRF9TSVpFLCBza2ItPmRhdGEsIHNrYi0+bGVuKTsNCj4gPiA+IMKgDQo+ID4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYv
bXQ3OTk2LmgNCj4gPiA+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5
OTYvbXQ3OTk2LmgNCj4gPiA+IGluZGV4IDBkYzQxOThmY2Y4Yi4uMGQ2NDg4NTIyYmE3IDEwMDY0
NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYv
bXQ3OTk2LmgNCj4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYv
bXQ3OTk2L210Nzk5Ni5oDQo+ID4gPiBAQCAtODc0LDcgKzg3NCw4IEBAIHZvaWQgbXQ3OTk2X21h
Y19lbmFibGVfbmYoc3RydWN0IG10Nzk5Nl9kZXYNCj4gPiA+ICpkZXYsDQo+ID4gPiB1OCBiYW5k
KTsNCj4gPiA+IMKgdm9pZCBtdDc5OTZfbWFjX3dyaXRlX3R4d2koc3RydWN0IG10Nzk5Nl9kZXYg
KmRldiwgX19sZTMyICp0eHdpLA0KPiA+ID4gwqAJCQnCoMKgIHN0cnVjdCBza19idWZmICpza2Is
IHN0cnVjdCBtdDc2X3djaWQNCj4gPiA+ICp3Y2lkLA0KPiA+ID4gwqAJCQnCoMKgIHN0cnVjdCBp
ZWVlODAyMTFfa2V5X2NvbmYgKmtleSwgaW50DQo+ID4gPiBwaWQsDQo+ID4gPiAtCQkJwqDCoCBl
bnVtIG10NzZfdHhxX2lkIHFpZCwgdTMyIGNoYW5nZWQpOw0KPiA+ID4gKwkJCcKgwqAgZW51bSBt
dDc2X3R4cV9pZCBxaWQsIHUzMiBjaGFuZ2VkLA0KPiA+ID4gKwkJCcKgwqAgdW5zaWduZWQgaW50
IGxpbmtfaWQpOw0KPiA+ID4gwqB2b2lkIG10Nzk5Nl9tYWNfdXBkYXRlX2JlYWNvbnMoc3RydWN0
IG10Nzk5Nl9waHkgKnBoeSk7DQo+ID4gPiDCoHZvaWQgbXQ3OTk2X21hY19zZXRfY292ZXJhZ2Vf
Y2xhc3Moc3RydWN0IG10Nzk5Nl9waHkgKnBoeSk7DQo+ID4gPiDCoHZvaWQgbXQ3OTk2X21hY193
b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yayk7DQo+ID4gDQo+ID4gVGhlIHJlYXNvbiB3ZSBk
aWRuJ3QgbWFrZSB0aGUgc2FtZSBjaGFuZ2UgaXMgYmVjYXVzZSB3ZSB1c2Ugb3RoZXINCj4gPiBj
b250cm9sIGZsYWdzIChJRUVFODAyMTFfVFhfQ1RSTCopIG9mIGluZm8tPmNvbnRyb2wuZmxhZ3Mg
bm90IGp1c3QNCj4gPiBNTE8NCj4gPiBvbmUuIFNvIHdpdGggdGhpcyBjaGFuZ2Ugd2Ugc3RpbGwg
bmVlZCB0byBjb3B5IG92ZXIgdGhlIG90aGVyIGZsYWdzDQo+ID4gYW5kDQo+ID4gcGFzcyB0aGVt
IGluIGFzIHdlbGwuDQo+IA0KPiBEbyB5b3UgbWVhbiB5b3UgYXJlIHVzaW5nIGluZm8tPmNvbnRy
b2wuZmxhZ3MgaW4NCj4gbXQ3OTk2X21hY193cml0ZV90eHdpKCkgaW4NCj4gc29tZSBkb3duc3Ry
ZWFtIGNvZGU/IElmIHNvLCBJIGd1ZXNzIHlvdSBjYW4gdXNlIGEgc2ltaWxhciBhcHByb2FjaA0K
PiBhbmQNCj4ganVzdCBwYXNzIHRoZSByZXF1aXJlZCBmaWVsZC4gQ29weSB0aGUgZnVsbCBpZWVl
ODAyMTFfdHhfaW5mbyBzdHJ1Y3QNCj4gb24NCj4gcGVyLXBhY2tldCBiYXNpcyBzZWVtcyB1bm5l
Y2Vzc2FyeS4NCj4gDQo+IFJlZ2FyZHMsDQo+IExvcmVuem8NCj4gPiANCj4gPiANCg0KV2Ugd2ls
bCB1c2UgMyBtYWM4MDIxMV90eF9jb250cm9sX2ZsYWdzIChpLmUuDQpJRUVFODAyMTFfVFhfQ1RS
TF9SQVRFX0lOSkVDVCksIHNvIGl0J3MgYmV0dGVyIHRvIGF0IGxlYXN0IGNvcHkgaW5mby0NCj5j
b250cm9sLmZsYWdzIGRpcmVjdGx5IGFuZCBwYXNzIHRoZW0gaW4uIElmIHlvdSBwYXNzIGVhY2gN
CmluZGl2aWR1YWxseSwgdGhlIGZ1bmN0aW9uIHdpbGwgZW5kIHVwIHdpdGggMTIgcGFyYW1ldGVy
cywgYW5kIGlmIG1vcmUNCmZsYWdzIGFyZSBuZWVkZWQgaW4gdGhlIGZ1dHVyZSwgeW91IHdpbGwg
aGF2ZSB0byBhZGQgZXZlbiBtb3JlLg0KDQpSeWRlcg0K

