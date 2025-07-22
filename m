Return-Path: <linux-wireless+bounces-25797-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96729B0D15A
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 07:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17AA17F60E
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 05:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3602AE8B;
	Tue, 22 Jul 2025 05:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OwTIDR1P";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="kqQcpKMK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8E5F4FA
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 05:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753163146; cv=fail; b=dusbTcJRb8hSKj9r6VbFaYz93I7OObgUkFMEAPfXguaeu5MTPxs7RIkQaGWxLiJJe8eIZ5UXODFYZNxXq8+E3x0VFvpf0Vg1ZxPB1mY3/Hwk8XnxdDYS4PWGxfbi46VU9jx7tBorzDIKJTkGzB4ZqyO2unCBc0HTn/GH+NP7XdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753163146; c=relaxed/simple;
	bh=WObABuFudCItLGu5BMAhT0K/79E6+1PO/9thJeen6fI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FgD1Xds8BKfEgjvp1eur+tTga98cifu29B5eWlfzZJ0/TlSQeKDiHvIOR+fZqujc/SuhC+XH78H+UpJ4wjCb2GY7VQVr/4Xa9984SCJtrncC1REfJABMxYRcEkzHKDJE9UzhmLcAj6IL1mCo3LfZ7bd3wXpEf8z1eel4ljVaJ4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OwTIDR1P; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=kqQcpKMK; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 184691b666bf11f0b33aeb1e7f16c2b6-20250722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=WObABuFudCItLGu5BMAhT0K/79E6+1PO/9thJeen6fI=;
	b=OwTIDR1PIPJRsV/9xwpe3uawa79usqJ/huP3XRMjaus5QAHJR5rrQVwSwxiakiH9jH/a+zFiPGODyhxhkuEJm36rmzc5qs+Vk8JzlUiabZBrYJhmJ5Op1W/xpgrqiADmtQP+6U8ceIXtYa2jBghxpi1zW3a8wlTjeegcuWN6l9E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:7cde7421-c2be-4dc1-b231-65eb7edfe6b1,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:af81229a-32fc-44a3-90ac-aa371853f23f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:99|80|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 184691b666bf11f0b33aeb1e7f16c2b6-20250722
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1152951114; Tue, 22 Jul 2025 13:45:38 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 22 Jul 2025 13:45:36 +0800
Received: from TYDPR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 22 Jul 2025 13:45:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+CtccBkl2lA/KCphHsibYv9inh33A9k4833MP9wQEJ6bdZXRB5QHoKoqoxxyNGkj9y6a6vvwcyYYaD40OUlWI6xbsIt/indlzuAhdVjQpPI7/XyE3V7Pc2gAbVSXFtCb1cHQiM73YWVTFKErkDAJb/2Dg6WXwQyp+1rw5iIdTOY5m+DLIxWbgP9cPmVReBDkK2hWIH583AqfBac/htntYChN/bgpWvdGR8t/5AOMMmxtrWrpEi3IfwYvlYn9PEiPVYNTkytGnJMyFYa1hTattM83lZBPe9wLvWoYB1SUu3kz6foP7ju9kvO9408if2uVsDkeez3p3g54Df0IELVAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WObABuFudCItLGu5BMAhT0K/79E6+1PO/9thJeen6fI=;
 b=C73oENr5AGsSUt7b88eiidRoGxf4yzkdgQaXfY4dBf4t09qkHVo8zc22x/QNnaNmVpcF0ya4O3bGA5gS2SwdKzsIiiClK2Vg4MZLnzbEigXAGKUhGa2uQhq/9ZMw1BFN9yo9+oZzOkboKd9cCif7FndbEl9ItQwr8zHr07l/uBtGGGew5BEYn/bhEKgTROWeV+6io2X8pdvV2V88ig2i19a2rzWEdHULhp4/7F26z3FSR57Hubr3jpslqwUEq5DRqKmlm8xre99W+wlBQhso/6kzmIpHTLd57F14daKeACLQBQmBciMWtVvD9hDjaplcqikyvd+z+xhL8Dk4UNXzBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WObABuFudCItLGu5BMAhT0K/79E6+1PO/9thJeen6fI=;
 b=kqQcpKMKfjCa7hYhhcCpjjCCFqivr2vD0nZjprCRRCjNw2Nx1Q+B4qZXn0k0uakTTcV7hC+Yg6TASDdx9Sz6+7oRXfhild1m+huti94VJshT25gfzMr+QYOG/B/3FP4SPS7ZdBoY9knJDoeuG2NU7CRI1/pbUnUqnH/sxkCQSTo=
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com (2603:1096:4:ef::8) by
 SE2PPF26711AE1D.apcprd03.prod.outlook.com (2603:1096:108:1::48e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Tue, 22 Jul
 2025 05:45:34 +0000
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741]) by SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741%6]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 05:45:34 +0000
From: =?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
	<Mingyen.Hsieh@mediatek.com>
To: Mike Lothian <mike@fireburn.co.uk>
CC: =?utf-8?B?RXJpYy1TWSBDaGFuZyAo5by15pu45rqQKQ==?=
	<Eric-SY.Chang@mediatek.com>, =?utf-8?B?TGVvbiBZZW4gKOmhj+iJr+WEkik=?=
	<Leon.Yen@mediatek.com>, =?utf-8?B?TWljaGFlbCBMbyAo576F55Kn56ugKQ==?=
	<Michael.Lo@mediatek.com>, =?utf-8?B?UXVhbiBaaG91ICjlkajlhagp?=
	<Quan.Zhou@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>, Sean Wang
	<Sean.Wang@mediatek.com>, =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?=
	<Shayne.Chen@mediatek.com>, =?utf-8?B?QWxsYW4gV2FuZyAo546L5a625YGJKQ==?=
	<Allan.Wang@mediatek.com>, =?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?=
	<Deren.Wu@mediatek.com>, =?utf-8?B?S00gTGluICjmnpfmmIbmsJEp?=
	<km.lin@mediatek.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "lorenzo@kernel.org" <lorenzo@kernel.org>,
	"nbd@nbd.name" <nbd@nbd.name>
Subject: RE: [SPAM]Re: [PATCH 3/3] wifi: mt76: mt7925: ensure all MCU commands
 wait for response
Thread-Topic: [SPAM]Re: [PATCH 3/3] wifi: mt76: mt7925: ensure all MCU
 commands wait for response
Thread-Index: AQHb+iMC357l4aRs0E6Y7XJTnDcbjrQ9oxJA
Date: Tue, 22 Jul 2025 05:45:34 +0000
Message-ID: <SI2PR03MB5322A21886CC9BF601BBE306855CA@SI2PR03MB5322.apcprd03.prod.outlook.com>
References: <CAHbf0-Gae=dYa=Zkx3ZJkL1SQOgHQWAMMvm68T9PPu8_=5oT+Q@mail.gmail.com>
In-Reply-To: <CAHbf0-Gae=dYa=Zkx3ZJkL1SQOgHQWAMMvm68T9PPu8_=5oT+Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref: PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXG10azI1NjQ3XGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMTNjNDg0NmEtNjZiZi0xMWYwLTkxZjUtMzQyOThmNzM5YmU2XGFtZS10ZXN0XDEzYzQ4NDZjLTY2YmYtMTFmMC05MWY1LTM0Mjk4ZjczOWJlNmJvZHkudHh0IiBzej0iMjk2MCIgdD0iMTMzOTc2MzY3MzE1MzkzNDg4IiBoPSJidjYwcFBQc0JGZVdFMERibS9Ya05lZ0wyeDA9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5322:EE_|SE2PPF26711AE1D:EE_
x-ms-office365-filtering-correlation-id: dcde2c94-3b97-4080-b009-08ddc8e2fa39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|217643003;
x-microsoft-antispam-message-info: =?utf-8?B?TldEVWpKTit2NVB3NEVXTlhBaDlHUVRLWHJTajBxWmFxV2wvb3dsVFRQYno2?=
 =?utf-8?B?VW1ubDZWMmxtQzJ2cnplQkEwbXhlcTdKUGN5Y3B3a0VoRTJGZnp6NmRpQ2Rk?=
 =?utf-8?B?MXNla3lIT3RlWS9sSUJyamVkczdXenpHVk44T2RBbmhmc1N2MTRhMkhhUFVF?=
 =?utf-8?B?eXkxRWZkZ29iR1hQd0lNWXgvdUNzdzZNNjRnTzZ3cHFOWlRMaE1CUzBlV3p4?=
 =?utf-8?B?QjNDeVdFUmZLVlFpdGp5bzR1cDc1RGVLYjUrdHNtRjRWTU1YRk15dlZZNWk1?=
 =?utf-8?B?YkkrL0ZQVFFIWSs1WjNpNWZMNllmWkRXV3JpbkZzbzI3dk1pcmxnRVFlZElh?=
 =?utf-8?B?ZWJsOVNFOTdxZlYzZUQ3T01QQUZueS9LOU1TN1FpZUJJa005NlpMRmZpMXk2?=
 =?utf-8?B?U0ZKMHdYWFVTT2hRYjdsemFKV3VGZHlqUVRFS05oWUtCTTU3KytYZEE0SmVN?=
 =?utf-8?B?UmJ6M0s2ck5CWDRVYUgyOFF2SEZKQUxCZ0tBRjc0a3dZQzdibTNPQW9pbHVH?=
 =?utf-8?B?QVF5WmFkTkFDWWlmNldSeC96eUVLMEJTMmRuaDVDY0ZVWXJTSnZsaDQ1Mi96?=
 =?utf-8?B?YllWcDZ2VkplUEFFWVV4aE1Jd3h4Q0dnQUZVRkVENE1sTXVrYy9XeGRrMVhp?=
 =?utf-8?B?L2VpdjMwU3R6V25Pc2pCNy9QZmJEKzFGTStaQWR3d25DblB2YmtHZXpEYzlu?=
 =?utf-8?B?LzRpUkF0U25zUHl1WFdIWk4wNU5ndWZjaGdqVEQyenhWUW5DbzVPUm16YVFK?=
 =?utf-8?B?STBQZm80dGlnZHFvVkVMY3gvNFBRb3JyV0p6ZHFjb3VGWW4wKzFlK3lialBr?=
 =?utf-8?B?LzliRlZsaDhCU29YQlg3clZSb3NPaklrVFBWMVZXZXVRdFV0bFVvbFpqcVJY?=
 =?utf-8?B?YjNDc3lHQ2srcWNYU2lTYkN4TFZNUGJyV1J0b0ZMS08xQnErMktBUUlRMElQ?=
 =?utf-8?B?Y0toV1J6S2RwNmdydWRhRThhTks1ODM4QjIxWHpHeEdKNHVzcTZzbzNSZzlU?=
 =?utf-8?B?MEtoeEVNSmtleXlOcTR5akVWV3FJZ2VDNXZzMEREUW5qUzdqY2R6cFRzTFlx?=
 =?utf-8?B?bmJnUWp0S2g2emtXZ1VZbWZKUHRWbzlPUmhka2NSRW0ralRhalVJam5sOFRa?=
 =?utf-8?B?T1R5UEtJNndiWEhCbUV0amhmV3hDQm5BeWpTL1BZZHNqdUpWRmphcElkdlJl?=
 =?utf-8?B?WGtzMWN6NWZLdldPRGFvTzZZUm1xUTlWY2tJa2doWmdMUU1pM3V6NjU1cW94?=
 =?utf-8?B?Y3pJQlBKMlEwZzBqc0hRTXJhbUNUcW9ETDk1N2Zub2ZTcngxSnBKL0wwY0s4?=
 =?utf-8?B?bDZCOXZUUHhZcStvQVpLNXgzTXk5T2EwSUJzTVZYb2tmUUpObzFnTHU1eGwx?=
 =?utf-8?B?cGJER244U0RmdkdGY2ZOZytzM0cxV0ZERlJxL0N6V09mMkV5NnRLVjRHRkxV?=
 =?utf-8?B?elY5OTREMitnM0ZPRTBnSnltTlR2N2hsNnlvTTBybmFMYXdpZUQ4dFpjdlJZ?=
 =?utf-8?B?akJ0NXBiYk5PWVYrRytkSTZYYWdxNVlSMndIVWExb2hCRmg5SCt4N2xKc0xO?=
 =?utf-8?B?ZVhxV0FCdHdRU3NPZXZTR3poVGw0aUE1U2s2TzFseHc5VkhmMDBBMUVPcFIw?=
 =?utf-8?B?eEdYbTdteHpwVUFRTnNlMytVSmVDenRZM1JISXVUQzR6TVJNOWtvTitCRUNt?=
 =?utf-8?B?VDNsUUFJYyt1dmQxbklia2owNFd5NkdmRGlWNE8yNEliSEhKL3YyM2ZBVDNB?=
 =?utf-8?B?OFNoZTFtdFZraU5ldzFvZHNLa1dHTkJ6L2IvVmJod1owamR1bmMrWGlSeWpZ?=
 =?utf-8?B?d1Z4aFVRK3Z2dlRkZVp2YlE4aU55TkR2MGppT3JOcnYvUG4yOGZXM0g4eTN3?=
 =?utf-8?B?eitsSkljYjg2bndhTkVwWCtWeCtiMmN2SnZ0K1JyNnhnc1Z0QWZIRFNJSEp0?=
 =?utf-8?B?c2xzd2RpcE1JaTBpQTZpa3luOE1lY2YwU0cyeSsxUm9ia3oxM0tRd1EzREFO?=
 =?utf-8?B?c2FaYmZHVGsySkVTRU9XaTZaUmlEMy9MVE4rK0k0dkd0NGRUcEFIL0RyWHhB?=
 =?utf-8?Q?L35s5/?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5322.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(217643003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OG4yaUlXVmtBVHhsV3dDSk1mTUlIb0MzcjBKU29NTWVpbEw1NHBKamVoeWxF?=
 =?utf-8?B?Z2tNYmpYTEd0NkdYT2hWOHNld3M3TEVyWktmaEZqMWtyaDFyRzQ2OHUvRWla?=
 =?utf-8?B?QkZmbVVsa1FCMUxDUUYwanlXd2wrbVlNa0dNUWNiSk5KWTN2bTNXSUJ1T09z?=
 =?utf-8?B?YzRLbjB0dlM0VlFvTHFNWjZNcmt5bkpUMk9hRHRpSkFGWk12MGd2d3JZUGJV?=
 =?utf-8?B?ZXJHOFpZNHZCeHVSaExrK0I2WEt2T1JHVTVHYUZPOXV0U3dtcmtuQndzVDhy?=
 =?utf-8?B?TkY4WjhEZHRIMFJ3Mmw1ZDZjVTRONWRSWXk4Zk84WkFjRDl3dzRYYWF6bFNZ?=
 =?utf-8?B?ZjZmbHBkeUdSMHdtMFpOSjBwbm5pR2hrOVlRM3g2bVgyVFgweWt6YTgyenVY?=
 =?utf-8?B?WWswdnJGeGpVRDNJcGk1bXlhQ3NXK0FhQWMxM29Obncya3hWQmZGLyt3ZVJV?=
 =?utf-8?B?L2MwdkdJREh2dUlmY3BpeXFKUjl5VElsaUp1NEhkbGk1TmJicnMwcG05dlcr?=
 =?utf-8?B?ekdnQVlHUzdkY2QwOG9HM0pzbW5mbndkZHcxT3Jua3l1U1p0eDFOd1pZRm44?=
 =?utf-8?B?V1o0SUhZa1krNWJJZHp4cjFZTzgvQ0Q2NVpBMzhyUnpENkVtSjRaSkZJbDBv?=
 =?utf-8?B?T295b21zbEZ0a2RFTFlLWEl5TXp1K01UR0JTaUtOSVd3WHZwOHVBSFhjckV3?=
 =?utf-8?B?WVE2NjNValhndms5UGlldHNsQjdZYXdTRlNFQU9GNThIQU1OT1NKVnlka3JV?=
 =?utf-8?B?WnBGZjBWdVRqUGhNZ0daRE5mWTBaQnFlNWdYSFpZSzcrbEJqUmFhdlBna3N1?=
 =?utf-8?B?Q1hWRDBJRW0rY0xFdUFDQWRxUXYwOVdEamlINjdmZ0dpOGNDaXA4cEovU2xN?=
 =?utf-8?B?ZlFlc3BwMjM1MHljUlE0aThoR0EreDNwa0xTMWpOZEY2MkF3UzRJVXRQbTZR?=
 =?utf-8?B?VGlBOVRuaXRHWWplMGtpZ3JQbWJXMEh0cDFnWkNJMXp3OGQ1YlVzMkFpZ0hR?=
 =?utf-8?B?MEZtNHB4eE5hMzllL3IwcWU2UXFUeHFad2NRblplUVgyYUo4eFZpNmJSMDlS?=
 =?utf-8?B?QUIxMmNqQlhvUEFkVy96MHlhaHFqbWttSEZhNDhTK3Z5T1p4R3k1NStLZjM4?=
 =?utf-8?B?VXVjS3NKbXBLSS9ZRGpWWHdzRWlsQUdyeDZPV1liOUZqcFIrd00wMnZNU3hQ?=
 =?utf-8?B?OVZxa0MvYndYQWU2SlRXR0oySEJBZ0h2Y2RzdnpaUDJiYWtTZ0tGcFdQaW0x?=
 =?utf-8?B?ZGxvZVRHckg0bkIvQnpUNjZsVVh6TndHTGJXZ2NrZTNBTUorcEZzdTRvN0t3?=
 =?utf-8?B?aXRRTFc2TmZITW53RStEOS91TGdja1VPYUVGTDJ5U1R3azhhcE4xdWFzc0Z3?=
 =?utf-8?B?MUs3SVN2K2NZcmZMRmlFWE1RK0NjZVRvLzQ1QndZdThjd01sZ0VHdkt2Qm9C?=
 =?utf-8?B?THowcGlrS0JrTy9BRkExU1JaRTBiSE9EWFRIYWdmOVZVVWRteWZFUlhabGNC?=
 =?utf-8?B?czk0TzZjcmpaQWJQRmF4L080Q1RtWlVVMU82R09QZUgrZ2pwd0Y0Q1JQQ09S?=
 =?utf-8?B?dDFDNEZURFFiVFlRZFA0M0h1OUhsWkJiZDNZUjJtdzZQT0o4NjZrLzdLUjNL?=
 =?utf-8?B?Q2xGcVI0YitNZXJjUlZnNTBnbFJCSXV4T0d0SDhkT3BCZXo5a0VpWVd3QnBU?=
 =?utf-8?B?K0grUm9ZTXRsS2owdjVLaGt1dkVuWDBoaGxqSU9ycG91dDVQSDRLbGlQMjZo?=
 =?utf-8?B?UEtYTVh4MzhyT0h2dnJMcUN0M3ZSYjBMbGMxQlpoenJVR3hYZjAzNXJWS3Ry?=
 =?utf-8?B?aEpOTGp5RWVwcmF6VXprcVA2TGNxQkpzSUNaclpqSVZRVUw3RjNJd0NWTU1s?=
 =?utf-8?B?Mnp3RitudVVRRHc1am43cFRkUlk3UGs1WjFoUHhCUis0c3VxYTlDcGYyVVZM?=
 =?utf-8?B?aTNRc25MZWJSK3FUcVd1Rjl0am5HMlZNdkF3REt1ZUtySnY2NEV5clBlcXQ2?=
 =?utf-8?B?V2M2ZklsQnUzTkdMWmlaaHRyZnRQK2haeEFXbWhzT01EdmVqTVRmcm9reHAr?=
 =?utf-8?B?Y1VBZEF0cjRzdWcyeDJ1RlBIRTIrc29TZnVQTWxyUWhpVTRZZEJqV2NNQVZw?=
 =?utf-8?Q?OPYeFmPeTG1ElWVbBh8AkE47a?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5322.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcde2c94-3b97-4080-b009-08ddc8e2fa39
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 05:45:34.2538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uJ+SDYp4iPxLQHgIj9TxGdz7CzcElSuxs9R1ndKwPUyuyBNlC1teborewQvdWMfnDH8MFRszV4Pbe+f6rjhMHkAzb1YLXhOVxhaBOmntQK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF26711AE1D

SGkNCg0KQ291bGQgeW91IHBsZWFzZSB0ZXN0IHRoaXMgcGF0Y2ggd2l0aCB0aGUgY2hhbmdlcyB0
byAnc2NhbicgcmV2ZXJ0ZWQ/DQoNClRoYW5rc34NCg0KQmVzdCBSZWdhcmRzLA0KWWVuLg0KDQot
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTWlrZSBMb3RoaWFuIDxtaWtlQGZpcmVi
dXJuLmNvLnVrPiANClNlbnQ6IE1vbmRheSwgSnVseSAyMSwgMjAyNSA1OjM2IFBNDQpUbzogTWlu
Z3llbiBIc2llaCAo6Kyd5piO6Ku6KSA8TWluZ3llbi5Ic2llaEBtZWRpYXRlay5jb20+DQpDYzog
RXJpYy1TWSBDaGFuZyAo5by15pu45rqQKSA8RXJpYy1TWS5DaGFuZ0BtZWRpYXRlay5jb20+OyBM
ZW9uIFllbiAo6aGP6Imv5YSSKSA8TGVvbi5ZZW5AbWVkaWF0ZWsuY29tPjsgTWljaGFlbCBMbyAo
576F55Kn56ugKSA8TWljaGFlbC5Mb0BtZWRpYXRlay5jb20+OyBRdWFuIFpob3UgKOWRqOWFqCkg
PFF1YW4uWmhvdUBtZWRpYXRlay5jb20+OyBSeWRlciBMZWUgPFJ5ZGVyLkxlZUBtZWRpYXRlay5j
b20+OyBTZWFuIFdhbmcgPFNlYW4uV2FuZ0BtZWRpYXRlay5jb20+OyBTaGF5bmUgQ2hlbiAo6Zmz
6LuS5LieKSA8U2hheW5lLkNoZW5AbWVkaWF0ZWsuY29tPjsgQWxsYW4gV2FuZyAo546L5a625YGJ
KSA8QWxsYW4uV2FuZ0BtZWRpYXRlay5jb20+OyBEZXJlbiBXdSAo5q2m5b635LuBKSA8RGVyZW4u
V3VAbWVkaWF0ZWsuY29tPjsgS00gTGluICjmnpfmmIbmsJEpIDxrbS5saW5AbWVkaWF0ZWsuY29t
PjsgbGludXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtd2lyZWxlc3NAdmdl
ci5rZXJuZWwub3JnOyBsb3JlbnpvQGtlcm5lbC5vcmc7IG5iZEBuYmQubmFtZQ0KU3ViamVjdDog
W1NQQU1dUmU6IFtQQVRDSCAzLzNdIHdpZmk6IG10NzY6IG10NzkyNTogZW5zdXJlIGFsbCBNQ1Ug
Y29tbWFuZHMgd2FpdCBmb3IgcmVzcG9uc2UNCg0KDQpFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBk
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbCB5b3UgaGF2ZSB2ZXJp
ZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KDQoNCkhpDQoNCkkndmUganVzdCByYWlz
ZWQgaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vYnVnemlsbGEua2VybmVsLm9y
Zy9zaG93X2J1Zy5jZ2k/aWQ9MjIwMzUzX187ISFDVFJOS0E5d01nMEFSYnchbTgyNXVtOUZYT0ts
SVEtQzBxYm14SHZmZDFqTTN3Nl9LSk9RUFo2UVZnYlhmOU5wUjg2WjhJb3ZTaUF3QXd4UG1mWjA1
bUFIdEk3ZS1KWGFHUDJiJA0KYW5kIEkgd2FzIHdvbmRlcmluZyBpZiBpdCBtaWdodCBiZSByZWxh
dGVkIHRvIHRoaXMgY29tbWl0LCBpcyB0aGVyZSBleHRyYSBkZWJ1Z2dpbmcgSSBjYW4gZG8gdG8g
aGVscCBwaW5wb2ludCB0aGUgaXNzdWU/DQoNClRoYW5rcw0KDQpNaWtlDQo=

