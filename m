Return-Path: <linux-wireless+bounces-4238-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B807D86C342
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 09:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD331C227E9
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 08:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24B74F1FE;
	Thu, 29 Feb 2024 08:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mUFgVb1H";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="HVgJ6as4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4E0481AC
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 08:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709194509; cv=fail; b=HEBa7jwwmB2wN2nTy1c50PWSdvdst8YCLIaBdCk7itG68xN1NjAWrXICDrzICzddG5In7oDX2K+iROku9J4vb9u3empEXmSEe0mWKTK26tQRhdrsNhrmioAm49Y/sJTr3qIuR7v5t3GC1p3vQ/bCpP03NZJ76eg83Rjv/4/8UOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709194509; c=relaxed/simple;
	bh=PEweijjbKPV2ZM43qgdsBet4EbCRKoZ0wuANW6NgtGM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IDsRjiXh+edieh9nA5Nor2tjzbuxpTK00kMwsDjVTAjyU1J0TFbivxBx6lLC7SjOGt9+J60UfKmMIzS4mfOO7IXBfubHb8r0I3jB8QKbWIr7xVIne/N/gmIBFbjbx9uBnurcfFLr4uXetZKcKtXfEWEP1Wo0vjAwydSMQ+D2bhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=mUFgVb1H; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=HVgJ6as4; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a248deeed6da11eeb8927bc1f75efef4-20240229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=PEweijjbKPV2ZM43qgdsBet4EbCRKoZ0wuANW6NgtGM=;
	b=mUFgVb1HEzhPJDvFQh3aJrWERNvWtySe+s1QpMkV6sR9P3+8dw3KBpb/Ohou/5G6afUspRWnlF7VcR5/++hBnJ6m3Wp+q+72FrTMImvielhUJnfuVKrS5GFchFAlqm0lghvt+Yc9oke7aTQtnNp3LyiBF6WiNB0xz52XH1KvV70=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:9b27bea2-19f9-4cc5-9686-4e9eab38e705,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:5ec756ff-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: a248deeed6da11eeb8927bc1f75efef4-20240229
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <michael-cy.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1456237753; Thu, 29 Feb 2024 16:15:00 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 29 Feb 2024 16:15:00 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 29 Feb 2024 16:15:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l02tXJfrP11hYpu787ju/2+sg2wSbw+uMM9ttsiFGT5JxpBt4OwdoCsMxSvFq3SqsYb9SPmEI6Xdmzsotr3PU5CYUBA+aa/OBV+dT2vVfQ+vXJWnfHFs37/YFEYBvu3ey934HogcyT0ypjAQ23qhjNGPFrdjbCVYc+awEWIV3IVkV1dsX4y5OApgzojKS+I8u1VsMlkASf333teGSot6QJ2/gIeRk2G8vjtSbmpuDYckgsjOxZgpc0UPWGgkQ+gkbyHCnMpDekUZmS2Hwwyt2kbT/ZNUKehvr7xkHjgWHgVvBJJyD/gLO6bxAZOWYsqb6XXI27ANRfo76koTgB0eXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEweijjbKPV2ZM43qgdsBet4EbCRKoZ0wuANW6NgtGM=;
 b=Uyf49M6YEww62U36/AdYLhUpi6KszhpwbkuQICnWCw6SOGNW/VtbnQxeTbcfjYJSNDgat5oeircraMRDcuwb5Ot3GknMvnpTTvmKk8tQbiKIjvU8YxwvD0SNU0MlvWW9P64d1VkvApx5M4UNI9BS5rSy7SGl5Z2vDqr9fgtUSpmGhhO83sgRHAQTFX3qekiH4VoLi/OJvI5LDKGbQoqorsPrwIkEx4RQ5i/97PrxZOr93WvmAciFUkz4DCwYBpPiGpYLGLiDy+5aRTfM1wVmW2fbQilhGPGO1HRS5Gl/ULt4sr1s0Qam6ip1vSBhJpIPpHM6rtCzOUF/YgQ+fjcUUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEweijjbKPV2ZM43qgdsBet4EbCRKoZ0wuANW6NgtGM=;
 b=HVgJ6as4+FfFQ+hFS3wTRVrWMSkOuKTiT2yet9fFFew4lXElNjXVxZFLdKb0AjZ+HIb0N8U/KJgi7tYtQhKSROIuJAaMocjKqJMGK4aw4A9PGZRp6aO5RGJPa2G3ZE/RvqLkqhox7DdAMuIwnjmfXYakJwD1WRQQElWa2+Euqc4=
Received: from KL1PR03MB5507.apcprd03.prod.outlook.com (2603:1096:820:50::6)
 by JH0PR03MB8211.apcprd03.prod.outlook.com (2603:1096:990:4f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 08:14:59 +0000
Received: from KL1PR03MB5507.apcprd03.prod.outlook.com
 ([fe80::c388:680f:ffea:12cc]) by KL1PR03MB5507.apcprd03.prod.outlook.com
 ([fe80::c388:680f:ffea:12cc%6]) with mapi id 15.20.7316.034; Thu, 29 Feb 2024
 08:14:59 +0000
From: =?utf-8?B?TWljaGFlbC1jeSBMZWUgKOadjuWzu+Wuhyk=?=
	<Michael-cy.Lee@mediatek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"nbd@nbd.name" <nbd@nbd.name>, =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?=
	<Evelyn.Tsai@mediatek.com>, "lorenzo@kernel.org" <lorenzo@kernel.org>,
	=?utf-8?B?TW9uZXkgV2FuZyAo546L5L+h5a6JKQ==?= <Money.Wang@mediatek.com>
Subject: Re: [v4,2/2] wifi: mac80211: refactor STA CSA parsing flows
Thread-Topic: [v4,2/2] wifi: mac80211: refactor STA CSA parsing flows
Thread-Index: AQHaNHOIabKmvUadb0SHw+79jt7SV7EAvocAgBDgcwCAC3RjgIAEUoAA
Date: Thu, 29 Feb 2024 08:14:58 +0000
Message-ID: <4e08126a3bed3e2108e76f2a30d9bf470b5fe4db.camel@mediatek.com>
References: <20231222010914.6521-1-michael-cy.lee@mediatek.com>
	 <20231222010914.6521-3-michael-cy.lee@mediatek.com>
	 <b74f21d22a41b2ca635e64f04c06d5db6d38d920.camel@sipsolutions.net>
	 <765fb43a372825f6063894809f204150d87d4d18.camel@mediatek.com>
	 <51cad25c273b27885f5387f995db48ef97df2996.camel@sipsolutions.net>
In-Reply-To: <51cad25c273b27885f5387f995db48ef97df2996.camel@sipsolutions.net>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5507:EE_|JH0PR03MB8211:EE_
x-ms-office365-filtering-correlation-id: 53137f8d-b00c-4229-6ff3-08dc38fe8556
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5YIMAoD1YzAoLVrDD3eDdjSPo601ARUyTjBf1QQGtUGYIgVYIkIkmlh+mOhT8vM0yxrPwf1/Ngp1lfmsM5MKpm8QS86IL1lF4nqvcVdlZsXW1s5HgKPrzb8H6R1RpPYmTazKmJpIDT/BSSYf4cImMrN4hXKS7veVjz1F2u15s92k32g8NzzBxdfR2T8WoAlB15OgzLli7qXHK49LrQIiOCm8ulgsepHJIyGwdQb4xiqwt+/7JfBBEyfB7+Y60S+oKWKZnv+AaI7R4rq3+ezLxDq99XwjYV86HaROMUpr8A9/0z+LfiIbSZWcY0p8pbEloN6dmSuaK1v1lA5bTHng1H29nqdymiLyYrhY9dpGXeZJoGsyIL7Sc7Ja+4beMWRT6uVEEUp4d3HbJLA4ELSHk0A4GVsB9yfg5rgCJzo1pdfZJTiBiwJCFSuVbXPv0M5QNixVH2ed+7icGI4SAwB0gn+G/Wl/J6bHkdhv6huTaJT37X/6DM+PY+bugzHcq8QOhFXWT8D2v3q/31x/QID8CDI2qnB7tB/IHegSIkmmgRnNxaIKM7QBShKJZHYEp7PaD6TZEwD6QfwkOKW5NCZBvSJw/m4yI6dMuwi6H5VS2u8ijHWCtPbb043z20NtP7FAHLMEpTHSMUSfvLCN8Xm6apDT5eh7UFfO7oQWHvEQ/Fg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5507.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTAwQk9qVytXR3hrZjk0eUlOM0h0TTk5RGZ6M1hwRnJHMWc2bXNUK2k4SnNC?=
 =?utf-8?B?ZkRiL0RGNkZueUlhN1hTMXo5YXZUUVJNNFBqN1cydVQybDY3cWZEbnhyNktx?=
 =?utf-8?B?Zm8xMjUrMXNqRW9YU3ExQlYzLzNaZG9WbHFJR0VRaVg2V3gvSzIwdUhXdjJj?=
 =?utf-8?B?aVZyMGxzUHVUeHR4bGFsZXlRR3FlWk1zcjBXNjJocHNwQ3N3QjVRQXFHZldQ?=
 =?utf-8?B?L3IrSS9wcVQ5UzlRQVdBOEV2Q2hlRGhCZVRuYzNQNmNUbVpNNWQ0d0J5c2pJ?=
 =?utf-8?B?clVUUTkzd3ZmYWFIdWN6Slo1aG56SWVHUTNYbDI4UlN1eGErQTNQanRBMWEw?=
 =?utf-8?B?ekRvTE5vK0FnSDh5WEZvdEltQ3lETk1mcHFsYlplOWp2b0hkRzRhNk1rWnBO?=
 =?utf-8?B?VVdObmw2NEJnemt6Z2oyTkNQeGFxdTgzajZJYk16WUNCZTZYNUViWnpQNUlY?=
 =?utf-8?B?TmZvcnYxZnpvbFNEeE9aYkxXL01NbGIxMkY2UGtCVEdJN2prd0V0UEkyb0ww?=
 =?utf-8?B?VVFTM3hOZkd0V2tVTTFtWTg1NnZ3WWVDV1htT0RUdDJ4ZFpZbGRPemxwbk5W?=
 =?utf-8?B?ME82M1Rya0ppN1VvdTZsM3dRVkR1aFFLcjExc1krM3NTUHZWaEMwaWdjZENj?=
 =?utf-8?B?MXRza1kzRUZWRzQyYlJtZ2Y2a3A3TlNTRmgrL3YyWFU1ZXA5Ly9QdzVlQW9y?=
 =?utf-8?B?RDJCaE0rU3ZneVFWcTJjWHVIVUlndW1mNXNSRXNNVHBuelErUVhhSzQ4aE9W?=
 =?utf-8?B?MDdvR0l5b2dYVDVRNkhuMHE0elhYMTNZZXYrTTVNU0NVSjRkZndaUXlQWkNI?=
 =?utf-8?B?TjdKd0NmVGxpZ3ltK2dCbStnOGNNVlJDT2hxdzRRbWxKQlRLWGZYQURuWENs?=
 =?utf-8?B?M1YxdHlJTVhnUWcwelYxYzlDcmJ3Ylo0QmhyYVdVOTI1VGVDRFROY0RGTGxN?=
 =?utf-8?B?TlBaV1d6T1RDQ1FKbDA0QjFxZ1FBVXE3TDZUS3JvYjQvMmY4VE9uMlZWTWwy?=
 =?utf-8?B?c2drdldFTmRxLzA4L0FtbXZDTlp4bXJDajk0YWtPdlhTMUxiZmJpenR1NUIr?=
 =?utf-8?B?bGVuNEFvdW1PaTBqOXRENmJSMmIzbHR6c0VTN2Y1NnFLQVFmMlUwMkRxSlkx?=
 =?utf-8?B?bFV4NThCSDFuK3E1N0NuZDVFSGVHYmVLY1ZYbzZkREhydHF0c0l0OXh1OXdV?=
 =?utf-8?B?TTU4WjNvWXRBZm5PbG9EWWVMSWl6R0xLWW1lREpndy83bnhDSk1pVCtCUEtP?=
 =?utf-8?B?WTRQb2M2aFlSWms0dG9LakJRUUFVTWU0bXo0WjdmbWhZVkgwTDZaaGkvNFNj?=
 =?utf-8?B?VlRTbVdXc1pxRkkvSDYyNDB1QUp0TTkyUHZqM1NnNE9rS2hiNlg0b0lCSTdl?=
 =?utf-8?B?ZDdPdWJPTkFZelYwS1hYVFI4aFdpdjR6aVBtclJOVHBOV2FKVGsvaHhIcGNq?=
 =?utf-8?B?VWpEdmlBRWNZNkNPVS95d25TOG1jakN4dm84QUluRUlZaW55V3lKU2hjajJW?=
 =?utf-8?B?azNmY2V5QjZFQUZNRGF4WmVDZWtmZXVnVFRncGU3RjlQZkgrZHlnZ0p6YXZh?=
 =?utf-8?B?dytDQ21SWUNzUmFtY0JZbjF4djh3ZE5IVWZhNUdVWGtvQzZ4NG9GYTZETWh1?=
 =?utf-8?B?WDV4ajRuSWE4WFB0TUJieXpTVEU4QVIvZzEreWZnQ09OazlHTnVrSmdsMjAr?=
 =?utf-8?B?Zy80NHJvQnhOWTVtejlSbzVyUG1rZFRIU2YwL3hiTERDcXBJTmxTZ212TnJW?=
 =?utf-8?B?SHFMd2NocEgzYnhHbk12NThVeEtobEphWWJjQlI1dlhERlNJRDNaaU5HMW1s?=
 =?utf-8?B?OUhPaStLZTE1Z3VzUkU1K3I3L1NCMzF3ZzZvV2FiNFdlem5mYW5BY3JzN01j?=
 =?utf-8?B?VlkvQU00bXdWWG5LOW5qTmlwWFZEeXVVb2p4MzFhQlFxOHBoK05EbGtrSlhP?=
 =?utf-8?B?dEk5MGxUR2ZWc2lxVHBjdFI5RGxzbUZGcWdELzJnSm45T1poajlLVTQvTTJz?=
 =?utf-8?B?NE5ielJCWStpZldPT1pIZ0NIZm9nVkdKV0t5amFYczFPTlhsbm9pd0hKb2hk?=
 =?utf-8?B?L3dZc1NUcHhXNjFBWTY2d0Zrd2VPWGFLMUVUNG5KZnJ4TGpjSllZdVhaK0RX?=
 =?utf-8?B?azVRWFFlc2c3bGFYV2RVVlUvQjlsc3lvaC84TDVHT3JReEVJcnZYdVJBbGFY?=
 =?utf-8?B?N3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8A33883EDF7C2448CB1B201D5BC0971@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5507.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53137f8d-b00c-4229-6ff3-08dc38fe8556
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 08:14:58.9195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JUp06PpVN0yK+12RJBKdLR4kKGXHOeOVJU1B7v9UhmxsH9rMVzEx7vEs87fEGbv7aBjBNSO6dvt9iJjjY0MT4aMAZqZ+wTKReSl8zCx5l2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8211
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--27.512800-8.000000
X-TMASE-MatchedRID: byfwvk+IcRljDV//SvkH3t7SWiiWSV/1jLOy13Cgb4/n0eNPmPPe5JHb
	921VhO8EwpcJm2NYlPAF6GY0Fb6yCifZYRtbOr2tICsP4rpeGcfSde/CNbaZJft592eq2xoT0TY
	N4q6hXjD77kbJEQUQyu7yd6tyBEMbRG8VGwrx1stjoaO27r+3fdZKsq3DGpals4OzwzqsfrwASh
	pFvc55+TWYCrl4C4KT/QKDlEDrWvyhzaM0+ttmeDPDkSOzeDWWQrO4XR6BRQP1gF7PCEF9bhnH3
	2sG9jpsWVT8b0UI5lSntPlSDgaUDR2P280ZiGmR8CORMyRE01Rzd7C7BtJobmHtZs6e3ZMHHd4F
	xb+OrJxtv4PpsEqNgwXzpbhxrY+w/FCPU2bFxsSeAiCmPx4NwMFrpUbb72MU1B0Hk1Q1KyJHtBs
	f5/UXJbVQu1GNZ+sikGUtrowrXLg=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--27.512800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	DBCDABC5E23F67776925655EE2944C504E8945ED5F64625882D19F2A930AD5152000:8

SGkgSm9oYW5uZXMsDQogDQpQbGVhc2Ugc2VlIHRoZSBpbmxpbmVzLg0KDQpPbiBNb24sIDIwMjQt
MDItMjYgYXQgMTU6MTQgKzAxMDAsIEpvaGFubmVzIEJlcmcgd3JvdGU6DQo+ICAJIA0KPiBFeHRl
cm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0K
PiAgSGkgYWdhaW4sDQo+IA0KPiA+IA0KPiA+IEluIGZhY3QsIHdlIGhhdmUgcGxhbnMgdG8gc3R1
ZHkgYW5kIGltcGxlbWVudCBwdW5jdHVyaW5nIG9uIG91cg0KPiBNVDc2DQo+ID4gZHJpdmVyLiBX
ZSdyZSBjdXJyZW50bHkgd29ya2luZyBvbiB0aGUgQVAgc2lkZSwgYW5kIHdlIGV4cGVjdCB0bw0K
PiBzdGFydA0KPiA+IHRoZSBTVEEgc2lkZSBtYXliZSB0aHJlZSBtb250aHMgbGF0ZXIuDQo+IA0K
PiBVbnJlbGF0ZWQgdG8gcHVuY3R1cmluZywgYnV0IGlmIHlvdSdyZSB3b3JraW5nIG9uIHRoZSBB
UCBzaWRlIG5vdyAtDQo+IGFsc28NCj4gcGVyaGFwcyBvbiB0aGUgQVAgc2lkZSB3cnQuIHBhcnRu
ZXIvb3RoZXIgbGluayBvbiBNTEQsIGkuZS4gb25lIGxpbmsNCj4gZG9pbmcgQ1NBIGFub3RoZXIg
YWR2ZXJ0aXNpbmcgaXQgaW4gdGhlIE1MRSBwZXItU1RBIHByb2ZpbGU/DQo+IA0KPiBJJ2QgcmVh
bGx5IGxvdmUgdG8gaGF2ZSB5b3VyIGlucHV0IG9uIHRoYXQgaW4gdGhpcyB0aHJlYWQ6DQo+IA0K
PiANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXdpcmVsZXNzLzNjNTUwYWUzMzVhOTc2
MmE5Y2JkMGM4MTA5YjZkZDk5ZmFlYjhmNmYuY2FtZWxAc2lwc29sdXRpb25zLm5ldC8NCg0KV2Xi
gJlyZSByZWFkaW5nIHRoaXMgZGlzY3Vzc2lvbiBhbmQgd2lsbCBnaXZlIG91ciByZWx5IGFzIHNv
b24gYXMNCnBvc3NpYmxlLg0KDQo+IA0KPiBCdXQgYWxzbyAtIGlmIHlvdSdyZSB3b3JraW5nIG9u
IEFQIHNpZGUgZm9yIHRoaXMsIEkgaGF2ZSBzb21lIGNoYW5nZXMNCj4gSSdtIHdvcmtpbmcgb24g
Zm9yIG1hYzgwMjExIHRvIHBhcnNlIHRoZSBwZXItU1RBIHByb2ZpbGUgZm9yIENTQSBvbg0KPiB0
aGUNCj4gb3RoZXIgbGlua3MsIHRvIGUuZy4gdHJhY2sgQ1NBIG9uIGN1cnJlbnRseSBkaXNhYmxl
ZCBsaW5rcywgb3IgaWYgb25lDQo+IGxpbmsganVzdCBkaWRuJ3QgaGF2ZSBiZWFjb25zIHJlY2Vp
dmVkIGZvciBhIGZldyBiZWFjb25zLCBvciBzby4uLg0KPiANCj4gV291bGQgeW91IGJlIHdpbGxp
bmcvaW50ZXJlc3RlZCBpbiB0ZXN0aW5nIGFueSBvZiB0aGlzIGNvZGU/IEknbQ0KPiBjdXJyZW50
bHkgbm90IHJlYWxseSBhYmxlIHRvIHRlc3QgaXQsIHNvIG5vdCBzdXJlIGlmIEkgc2hvdWxkIHB1
c2ggaXQNCj4gb3V0Lg0KDQpPZiBjb3Vyc2Ugd2XigJlyZSB3aWxsaW5nIHRvIGRvIHRoZSB0ZXN0
Lg0KQnV0IHdl4oCZcmUgc3RpbGwgd29ya2luZyBvbiBNTEQgQVAgcmlnaHQgbm93LCBhbmQgdGhl
IGNyaXRpY2FsIHVwZGF0ZQ0Kd2lsbCBiZSB0aGUgbmV4dC4NCkluIG90aGVyIHdvcmQsIHRvIHRl
c3QgTUxEIFNUQeKAmXMgYmVoYXZpb3Igd2UgbmVlZCB0byBmaXJzdCBnZXQgdGhlIE1MRA0KQVAg
cmVhZHkuDQpJZiBpdOKAmXMgT0ssIGNvdWxkIHlvdSBnaXZlIHVzIHlvdXIgY2hhbmdlcz8gTWF5
YmUgd2UgY2FuIHRlc3QgaXQgZHVyaW5nDQp0aGUgZGV2ZWxvcG1lbnQuDQoNCkJlc3QsDQpNaWNo
YWVsDQo=

