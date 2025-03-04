Return-Path: <linux-wireless+bounces-19748-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4651A4D8C8
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 10:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8058F7A86EC
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 09:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D241FCD1A;
	Tue,  4 Mar 2025 09:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="U+GaAnB2";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="CBMreTHY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A475A481C4
	for <linux-wireless@vger.kernel.org>; Tue,  4 Mar 2025 09:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081094; cv=fail; b=X7ilpEfXcpJBkezuqgraoFKe2g3x71iBu2Stv5J1AX5T0vrjuE5WaOxDnbR/C8ptiA+DPeX90KtAyXljUHoh+X1wOhyTXjmShSAM7xtLFizHHArXHdgAAS0YpFuBG2LkOLYLb9FagzFQpDOqiz65iZWhTMxOHeC6ZodS52TQIN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081094; c=relaxed/simple;
	bh=nsV9zs+cxu46hWXBLCdI9zELlgj9zs+wpGnv1dZkeAM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qM9uk1S5lQaMNwlNFcDbt/k9wtLRhzpu28QEQ1z7rZn3xllE+swVDHs/H3J3fInbMlsNnc+Mj8ERDx3JBLCBGH0Q/1iPmVqmCccco++NR8ybse562A73jJYnVzbU+dQ1qETkFVRM9hPU+KGDqDiFj6F7CiRd4DVYr4FnaoTtEqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=U+GaAnB2; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=CBMreTHY; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5d6c633ef8dc11ef8eb9c36241bbb6fb-20250304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=nsV9zs+cxu46hWXBLCdI9zELlgj9zs+wpGnv1dZkeAM=;
	b=U+GaAnB22vw3ijPHO28ph/hN22RjplIPTQhxo77v3erAQMJ0c6PA9/eDXPtutSVmv5fNH+r1UodjB9V/TmuUtIdZGdA7Ev7XkxqlBX9y10n81gprMZGM/WFOPyTamQ4QxfhfapIECY7CuLYHgbR7zHonvDdoPyfz68jyh5S9lhI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:5b7659ad-ac91-4445-8d44-1d165758056e,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:23242103-a373-400e-87fc-32443f153737,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5d6c633ef8dc11ef8eb9c36241bbb6fb-20250304
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 924599339; Tue, 04 Mar 2025 17:38:01 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 4 Mar 2025 17:38:00 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Tue, 4 Mar 2025 17:38:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKS3vQCDguKuNS7cEmR6MyYAzZRos0F1qqdNxvszsdqlE6lOlOt4yb4yDO6klYc/p10iJJ4KOnxfSooSFkHqAHLrCMvm1MDo+eSrcA+iWx08+AJEptkjegDTkq2QnUZruy1ZIv4Y1JHKRhgIcZnLC+5lxefr1si7NwMDBa2VG3e+1jAeeVtNA1UVtFC9FIMug9XCwV4nNnmnwm9OL0TL+jYFu6Z9G2P7xYgTDXTqqXv7jqMytSFksPx/+8N0iWDdDkPDVS/uG80vUyuQ4yuELZWkcly3E7tVUpfi3iZlbENjr+2Z8ltRg29GDE8VRftNlHgiR5U18cZ9oXGj6pLqyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsV9zs+cxu46hWXBLCdI9zELlgj9zs+wpGnv1dZkeAM=;
 b=pJGKh2OC/Nidp35XJI4o7mEL0QU7BQ5sOnf32TUcZmCnxuB2oSZk6sVXqxY2SWUjI0txSVMMi8/4iJhAovst0LKwYaV3jfT0gk25Me76tW4Zma9sqE0V8iIEMtrL9oMdoL5XHb3B6/A2Vv1oHj4KzeHE4QkzjCiSyw5Si1rzP+jCZ7dxbK6mtuE/7squTHkAcfvTPzC3klF5gtW/iA4MkZ3BeoY4kb1P+1bH5hdGmldsANNtpwYOJ9nwvrtR/2huZPnbVISch/I397yguTdxIlhSg+QUuanitmxYSzsGvOky5Ivg5fVlY5aKGd0rqZ0qDeCWRyFDtlfjisaoWpfHgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsV9zs+cxu46hWXBLCdI9zELlgj9zs+wpGnv1dZkeAM=;
 b=CBMreTHYjLUyi8Hd9DIOQLyVNcuXR0YCJVRNEee5tiNkwmLXGT/N2Nh0CdAS4iBFrLHOVzylyFq0CeSEHsjz338F+DqadyUFOd1CbEcg44g4xazY0qR4FyiYf6lkLRuX96eHaas4k2PLewE11xbp+v5FQW4X89d2hGTZxeQ5PcE=
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com (2603:1096:4:ef::8) by
 KL1PR03MB8161.apcprd03.prod.outlook.com (2603:1096:820:ff::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.28; Tue, 4 Mar 2025 09:37:57 +0000
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741]) by SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741%6]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 09:37:57 +0000
From: =?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
	<Mingyen.Hsieh@mediatek.com>
To: "nbd@nbd.name" <nbd@nbd.name>, "pkshih@realtek.com" <pkshih@realtek.com>,
	"lorenzo@kernel.org" <lorenzo@kernel.org>
CC: =?utf-8?B?QWxsYW4gV2FuZyAo546L5a625YGJKQ==?= <Allan.Wang@mediatek.com>,
	=?utf-8?B?RXJpYy1TWSBDaGFuZyAo5by15pu45rqQKQ==?=
	<Eric-SY.Chang@mediatek.com>, =?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?=
	<Deren.Wu@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
	=?utf-8?B?UXVhbiBaaG91ICjlkajlhagp?= <Quan.Zhou@mediatek.com>,
	=?utf-8?B?TWljaGFlbCBMbyAo576F55Kn56ugKQ==?= <Michael.Lo@mediatek.com>,
	=?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>,
	"Sean Wang" <Sean.Wang@mediatek.com>,
	=?utf-8?B?TGVvbiBZZW4gKOmhj+iJr+WEkik=?= <Leon.Yen@mediatek.com>,
	=?utf-8?B?S00gTGluICjmnpfmmIbmsJEp?= <km.lin@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] wifi: mt76: mt7925: load the appropriate CLC data
 based on hardware type
Thread-Topic: [PATCH v2 1/6] wifi: mt76: mt7925: load the appropriate CLC data
 based on hardware type
Thread-Index: AQHbjM7GSDhFqZm8ekqB/J/y2RqMNrNir9YAgAAIxAA=
Date: Tue, 4 Mar 2025 09:37:57 +0000
Message-ID: <c3fcef13b2c626be49cf160e53fc93fcfe8af9b8.camel@mediatek.com>
References: <20250304062854.829194-1-mingyen.hsieh@mediatek.com>
	 <4d4e50e6b76e46d5b949701316889ee6@realtek.com>
In-Reply-To: <4d4e50e6b76e46d5b949701316889ee6@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5322:EE_|KL1PR03MB8161:EE_
x-ms-office365-filtering-correlation-id: 7bf15a47-0789-42ca-99ad-08dd5b003f5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aG9meFNuaDhLZ1V0bVM1SmtiYzZZZWJDa3RqNm02Ly9JUzNYMUthMExZeGdP?=
 =?utf-8?B?U3czRUN0NkZuOXRUdnBsb3ZLWWlkTkNldXlWRHcrMjI4UDNRdkZhUllFS1pH?=
 =?utf-8?B?RkNkQWFMUGt2V2tlSjVlSm4rMVRia25Ua3hOR3BpelhMVGlUYktTY0NRejRS?=
 =?utf-8?B?WU5tbkdoem5KV2k1cUxIc1dQeU1Kc3FLTnJMVDhISWVoVEhIZUdtaWp1VlZ5?=
 =?utf-8?B?MVpsb09WQ09neEdsOENGMDZUZCtWMXRlZ0lqSHhIcGxNOUhBYUNWQ2xKWUxV?=
 =?utf-8?B?bVA5NmRxMjJhbmhMY2VTc1Fha21vOERCNk5seEM1WnRPem4wZCtmOWMxcEJ4?=
 =?utf-8?B?TGE3czFDUUJtc0w4enRwMEh6RlZSWmh5Zkp2VXNCZlJwVFFxZGt0MXlwVnNl?=
 =?utf-8?B?eW4zSFRRanpPRS9ieWt0cXVLM0dzSUFhMHU2Q3FtcklIRjhsSWxmTXlkMG9J?=
 =?utf-8?B?YXlpazMxVWlUbkV0UmU1Szd4MlVxM2dydG5qZGJaSTZqWEIxUE9pbmdLdEhw?=
 =?utf-8?B?VGhvVytzamVIWUNWcGFEYzczU1hWa1NLVVVneEpsUThQVDZCMjBhUGdsMjE1?=
 =?utf-8?B?R3laNFRjMU9QOVFXTUZHd3p3MGRCcHF1ZU5Ibkk2cjR6Y3JPejRXaXVsbGJM?=
 =?utf-8?B?bEQvVnliMnNXSnVOaHNXNHA2S3BzcEFENVY3ODBXaWNNQzZRRkk1aXpCR3Fk?=
 =?utf-8?B?TGhLazhXVjdWaHFlcUxqWktXN2QzQVZmVjhkTUo3V2JtNm9XbitLNnpjdjl0?=
 =?utf-8?B?RHluM3lYWTBSUlE0UGtiem54ZFZ3UW5hZHJmUVdlMDMxZ2xnRXpJdnpnTXBF?=
 =?utf-8?B?aitTaGpIZ0xxVFA5aEF1UW53bG1UQjRTZmF1TE9ETWczcUx6RmN6TkE4N3BW?=
 =?utf-8?B?ZVNZZ0JmcjgyTGdKNUU0WW83SUU2cDFTdlRLZmlXZHJJQytITERtWlRCaTM2?=
 =?utf-8?B?R3gwaTBCWEJKZEVyOC9vQXZWWG9WaU9aR2wxOHBscnJ4ZUpsNzkvYWYyczlx?=
 =?utf-8?B?eUpLenNqM3N1M0Zlck5jdUFzUjIxMlVrK1JZMHhqTTh3US9TZHF3QmRxN2l6?=
 =?utf-8?B?ZWpPVlZVZE1JUmRVbzNBSDBSbzBNRWwxVmUwUFV0TTI5cjkxZGF5Q0dmMUR4?=
 =?utf-8?B?MVk1YkJrTE5peHRSVHVzOVp0Z2pNb0dTYzkyKzJWWXF1SGRSWUpOcTBVcmJv?=
 =?utf-8?B?bHFIcHFKUFpxSVM5WGI4ZlN1NmdVTWhsalluUWdOZ2NIWTBzQWVxT285akM5?=
 =?utf-8?B?em85U0dkWTN5c0xNcE03U3FUZUhmVXF2VjhvNUxtMDBRN0JGRkp2aXNJZXFo?=
 =?utf-8?B?WU1hVHpScTBva1FVZUp0VFNrcVhXb296cEVjNVhsUTdMaVRXVmlyRVk2Ymp5?=
 =?utf-8?B?L21JOHZQQ2hiRXlhYmhNM3F0cEE5WWsyS2lucHA1RkhhU2ZxRXVYeTRVSDZL?=
 =?utf-8?B?S1EyOUFPSDNLamJEdXBWcUNpT3I1Zy92WmxOaXJhZlRySUVxc25VZE9qMHUy?=
 =?utf-8?B?ZnJaOWtoTHQwRW9iOG9kbmMvaGQyS0hhdnQ1Zk14c0JDc2UvR3F2a0J3MjRn?=
 =?utf-8?B?M2J1NVVpVFdQU3BYUGZraWhHMTI5WjN1akVPVVdpZnJBK0hVVW9xK0RBQlZP?=
 =?utf-8?B?RHkrdnMzR3NuTlBUWFArL0VZQWhlOTdnQW9MWXpyZjdhak1VYVlSdllMY1VG?=
 =?utf-8?B?T2E3Tnh5YVRDaHNwbGNkM0Z0c2MvbGpod1NnZG96OUZmSWFaVVJUZXFmeGc4?=
 =?utf-8?B?Ymk1c1RUVnY3MmtiOE9xbEJqbGg5ZnRiem0xSDFSNG5NL0x6QmQvV2UxYkFm?=
 =?utf-8?B?TVFzSXBzYjlmVkV6SFlPMURTZUEyZWZUaW1XMWlCcW10U28ySkhHM1BxdStH?=
 =?utf-8?B?RnRYNGRsaytUMFMwRW1ETmNDWCs2SGVWSUxzWS90RWEwTTRpbC9xZTZKWDZj?=
 =?utf-8?Q?sBhK91MQOzR3aSdFxl9m009nJFMf+fz8?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5322.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVN4cVFUK2FxTUhJWHZIQWFXN0JGcGJ1Ynd2MDQxTHZzWEplNjY0R2JhQjl2?=
 =?utf-8?B?T3p6d0IwVStWVjdJU1lYbm1SYWJOaDlLRUpjQnlKZmJWZ1JsK1lhYlNyWENi?=
 =?utf-8?B?V0RmRW9pWVdOeExnMkk4RGpSVk5iazBLLzMwUHF0ZWNXODk0YjZ1aVcwTnFZ?=
 =?utf-8?B?WHRFRDFOaHdqQmVOakJNNzIzYWxybXRoVVNlU3p4RndlYnFyUkhmaVk2TEFa?=
 =?utf-8?B?Q0tuRHdJbzRLK043aXJJTWJ1QVVMNmh6WE4zZ3VmRkhlWjVteHBSRVlFUnA0?=
 =?utf-8?B?OHR5dmNMNDV6cEVUM1RFZkpQbHk2dncvZHAxeW5MY093WkRTMkRHM3E0a2lJ?=
 =?utf-8?B?SDA0RWI2M2hva0dtdVZ0TW9qeWVRZXZ0STdIYVk5emw1Q3dnSS9qRXllQlo2?=
 =?utf-8?B?TzZFUEtUVDN3RDRGME5rOWJZU28razl3N3B6b0ZpRDA4c0FZcGUrYjJZTVNp?=
 =?utf-8?B?YzJ6dnM5MWVBL2Q2U2dxcHpKZzY3Nm1tQzJqZ1BGLzYwZ3ZFT2hWYW00c0Fu?=
 =?utf-8?B?T1pCeGFvb1Z3RDJFVllvRmxBVEo0YzlONzFjTWk2TzAxemljOXQ5bW1jc09z?=
 =?utf-8?B?L2djZ09ad2k3V25qNnNFNzRUYW1OTHpnQVYxcjU1c2pJM0NWUVFNQXhQZDc4?=
 =?utf-8?B?c1BTTVNZeVErSk1QOUUzTUFkL1luNjdVdGxLWWRacXlWb1U1WVZUNSsrZTdq?=
 =?utf-8?B?ZDJlaHBCUlllcG9GMUF3Vk5VclI3T3BSM0w4M0VqaFc0aVpjVnhoUkZ2Ynlm?=
 =?utf-8?B?S296eFR3YW02R2piOTJWd1JDRE5DVU5CUlZnMjloSXNYVXVsNVVzS1ZXMlJ1?=
 =?utf-8?B?WlhUOWdNNWpWY2NXcWdzSHc3dlZoTHhISCtvdWZzamRvRXBXeFVRY09xNE9x?=
 =?utf-8?B?NGhvclRDdFVUcTd5ZTlPZlp3Q3F1VzIxWGk0bktjOTJKWjE2dHg4TmdtVjNh?=
 =?utf-8?B?L1RtMnZMd2kzTFdTTUZ0ZGhrekY5OW9Kd1JydjQ4UDE3dUFlMnVJQi8zWTZU?=
 =?utf-8?B?K0NIYXRpd21vbkswTlF4RitSMnZRSkxxN3dIYWxuaE1QeUpRM1pIUFljKzdt?=
 =?utf-8?B?T3lrQ2tPUEtaWGFtbzZQZkVJaTFyWlF5ME9ZNFlHZVB0cDRtY0ZOaklQYlJ3?=
 =?utf-8?B?c1VuMWg4SzAyQTBnM0hFeURHQ2taOGEyTWUyT1k2UFdkeU41ZDlpakZjOFpn?=
 =?utf-8?B?YUxjdEo0eTdici9rcTFNZkZoQXhGamM0VHlmWXZNLzMyL0twbGczQ0ZDUTBY?=
 =?utf-8?B?WmRBbFJybGJYVDRtYXFSVFR3eTM1bHRvWERaWkRoZk1LaTRCbjVaMVNIb29X?=
 =?utf-8?B?eC9xWjNiNUxwOG0xb1lEcmFUQ2VlVm44WVR6WFhPZTg1NitWcFlJcTRFaTVx?=
 =?utf-8?B?S204R0x2VE5qSDFVNkx1TTJZekhPa09mYml2MUw5OWliTW9sQzRHek11SG45?=
 =?utf-8?B?WnJIRUtqNExqNFhsTHhqTkI4MExyQk9vTmFvL3liNi8rUTJTOUNSWEwxMEto?=
 =?utf-8?B?OFBsSVZKRXRuRXM0MUFBWWdIdFpxVmlJK3k1cGVEVXVBbTFxblVCSEs1eHpa?=
 =?utf-8?B?ekhla2NnSHVQT3M5WmVNNzJsMzRlSDE2SVFDM0hvT2p5U3BjTkZjb3YwMVd5?=
 =?utf-8?B?U1pyU1FJWnRQalM5REZNQmlhQmYwRzIvNDI5azlBSk02WW04WHlQVVJMeDRp?=
 =?utf-8?B?SGUvU1FQRWRpMDJKQms3S2N3U2hWQTlDRFB0NHRKZUhZUkpLSXFTRURZalln?=
 =?utf-8?B?RWliWXNWLytDbE9EUXJmNlAxa09LcDg0alRSYzNNbFJyQTJQZDhiVy9BbHh3?=
 =?utf-8?B?U0lIVEZuQmlJMmwwY2lUOGxsUWl5OFhnbXlCNmNhUjFVRk5Fc1Y3aDVQQ2xX?=
 =?utf-8?B?V3hTbUJQMytzSWZnOFptKzRVZ3JLUmJLQjJscDJNa1ZRZUJwamUzRUpmMXpH?=
 =?utf-8?B?eEYzVEl2TlM5a0ZZL25BMnJhRnpTN09CQUtqaThXUXdWNnNUZEJDd2tqMFJN?=
 =?utf-8?B?Q1BVRk9VU3RqZ3JlK2Q4YktWUzU2T2lpZUNlRjJxcFlxRTVDYjVvYStiNUsy?=
 =?utf-8?B?SCtjbVpVd3pBTngzWUVZR21OWDRQZVlCM1lpb3ptUkVoUE1sYzlNVWF6ZXV1?=
 =?utf-8?B?U2ViSnFycXJyczJtZTFlYnYzYzcxOXBzaEZTaS9LRHZSL1FsVkZTaTJHbjJ5?=
 =?utf-8?B?MlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68828BD69AAEF54FA7C8A843A5EAE4CC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5322.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf15a47-0789-42ca-99ad-08dd5b003f5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 09:37:57.7535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DHv3E1hGQZN9wrOXpHDhZp9FtpgFGrpf+9lH6Appl7SU+HyR4NzJiAlJKyjXJYN/52Hoy8BoAmmyg6yrMez/na/ESBBQMoXX3fOqGHkaMmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8161

T24gVHVlLCAyMDI1LTAzLTA0IGF0IDA5OjA2ICswMDAwLCBQaW5nLUtlIFNoaWggd3JvdGU6Cj4g
Cj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW50aWwKPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250
ZW50Lgo+IAo+IAo+IE1pbmd5ZW4gSHNpZWggPG1pbmd5ZW4uaHNpZWhAbWVkaWF0ZWsuY29tPiB3
cm90ZToKPiAKPiBbLi4uXQo+IAo+ID4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3QgZXZ0IHsKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHU4IHJzdls0XTsKPiA+ICsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fbGUxNiB0YWc7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBfX2xlMTYgbGVuOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgX19sZTMyIHZlcjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fbGUz
MiBhZGRyOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19sZTMyIHZhbGlkOwo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19sZTMyIHNpemU7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX2xlMzIgbWFnaWNfbnVtOwo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgX19sZTMyIHR5cGU7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBfX2xlMzIgcnN2MVs0XTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHU4IGRhdGFbMzJdOwo+ID4gK8KgwqDCoMKgwqDCoCB9IF9fcGFja2VkICogcmVzOwo+IAo+IG5p
dDogbm8gbmVlZCBzcGFjZSBiZXR3ZWVuICogYW5kIHJlcywgaS5lLiAiX19wYWNrZWQgKnJlcyIu
Cj4gCkhpIFBpbmctS2UsCgpJIGFsc28gdGhpbmsgdGhpcyBpcyBiZXR0ZXIsIGJ1dCB0aGlzIHdh
cyBzdWdnZXN0ZWQgdG8gbWUgYnkKc2NyaXB0L2NoZWNrcGF0Y2gucGwuCgpJIHdpbGwgc2VuZCB2
NCBmb3IgdGhpcy4KCj4gPiArwqDCoMKgwqDCoMKgIHN0cnVjdCBza19idWZmICpza2I7Cj4gPiAr
wqDCoMKgwqDCoMKgIGludCByZXQ7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgIHJldCA9IG10NzZf
bWN1X3NlbmRfYW5kX2dldF9tc2coJmRldi0+bXQ3NiwKPiA+IE1DVV9XTV9VTklfQ01EX1FVRVJZ
KEVGVVNFX0NUUkwpLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJnJlcSwgc2l6ZW9mKHJlcSks
IHRydWUsCj4gPiAmc2tiKTsKPiA+ICvCoMKgwqDCoMKgwqAgaWYgKHJldCkKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKg
IHJlcyA9IChzdHJ1Y3QgZXZ0ICopc2tiLT5kYXRhOwo+ID4gK8KgwqDCoMKgwqDCoCAqdmFsID0g
cmVzLT5kYXRhW29mZnNldCAlIE1UNzkyNV9FRVBST01fQkxPQ0tfU0laRV07Cj4gPiArCj4gPiAr
wqDCoMKgwqDCoMKgIGRldl9rZnJlZV9za2Ioc2tiKTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqAg
cmV0dXJuIDA7Cj4gPiArfQo+ID4gKwo+ID4gwqBzdGF0aWMgaW50IG10NzkyNV9sb2FkX2NsYyhz
dHJ1Y3QgbXQ3OTJ4X2RldiAqZGV2LCBjb25zdCBjaGFyCj4gPiAqZndfbmFtZSkKPiA+IMKgewo+
ID4gwqDCoMKgwqDCoMKgwqAgY29uc3Qgc3RydWN0IG10NzZfY29ubmFjMl9md190cmFpbGVyICpo
ZHI7Cj4gPiBAQCAtODA5LDEyICs4NTcsMTkgQEAgc3RhdGljIGludCBtdDc5MjVfbG9hZF9jbGMo
c3RydWN0IG10NzkyeF9kZXYKPiA+ICpkZXYsIGNvbnN0IGNoYXIgKmZ3X25hbWUpCj4gPiDCoMKg
wqDCoMKgwqDCoCBzdHJ1Y3QgbXQ3OTJ4X3BoeSAqcGh5ID0gJmRldi0+cGh5Owo+ID4gwqDCoMKg
wqDCoMKgwqAgY29uc3Qgc3RydWN0IGZpcm13YXJlICpmdzsKPiA+IMKgwqDCoMKgwqDCoMKgIGlu
dCByZXQsIGksIGxlbiwgb2Zmc2V0ID0gMDsKPiA+IC3CoMKgwqDCoMKgwqAgdTggKmNsY19iYXNl
ID0gTlVMTDsKPiA+ICvCoMKgwqDCoMKgwqAgdTggKmNsY19iYXNlID0gTlVMTCwgaHdfZW5jYXAg
PSAwOwo+IAo+IG5vdCBzdXJlIGlmIG10NzYgZGVjbGFyZSBsb2NhbCB2YXJpYWJsZXMgaW4gcmV2
ZXJzZSBYJ21hcyB0cmVlIG9yZGVyPwo+IAo+IAoK

