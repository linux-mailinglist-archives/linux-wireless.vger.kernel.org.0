Return-Path: <linux-wireless+bounces-14581-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5849B221B
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 02:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEACF1F211B5
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 01:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59A813D8B2;
	Mon, 28 Oct 2024 01:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CUPfR8gv";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="NChFLXj5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863E914EC7E
	for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 01:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730080563; cv=fail; b=sWubh5fenvdgR0CxXMW3+LAj47utlr4I1t63sP6VgqVz26Zi2k2Q/YGT6RC0pOUHozIv86oYeqqBa5CJbudbLIUTy17FjCBBLDDCV8wccTTSlOgOs2dogEfEOOneM4930CAGWJ7Hajfs7ADZTKWfWdk8koW3pKgsWnRN79E4M9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730080563; c=relaxed/simple;
	bh=5vI24pKOFITsHFPieXU1Ftec/dR19d0bs2Klptgxywc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xoh+6fC8F1RpGsslCFs0pdCeowgGieGPIebNSU2HsndTa2VrM9qJRc89nJ6dgkIaluyknZ2XM6BPh8R2EdW8uTD9tUBH13+NbmJbk7xMQcfZ+k0Oe+gLy7TDjpthyiv8LJ/mZgZG4YXux0BGqqKL+IhD04jpj5rJp+r2kTCb7SA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=CUPfR8gv; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=NChFLXj5; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c4d8d33494cf11efbd192953cf12861f-20241028
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=5vI24pKOFITsHFPieXU1Ftec/dR19d0bs2Klptgxywc=;
	b=CUPfR8gvIevtA/OXqpM8pj6okxesFft8LmI4KoTy4lbkhVWrvJTc/j0CJVGO5MdH6w+zuk0hG+Z5ygnh4D6kLTeLViKaKsq2RdNIiKgQ44iGbJGs0F5l0SSebxJxaVwGm03TFOSm/x3mTO5Alkhd2e4CBzfqgh/hbkl/vMWszms=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:1b15f9d7-72ec-41c1-8b16-5e03eaf214ec,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:4d71ea41-8751-41b2-98dd-475503d45150,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c4d8d33494cf11efbd192953cf12861f-20241028
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 950791197; Mon, 28 Oct 2024 09:55:55 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 28 Oct 2024 09:55:54 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 28 Oct 2024 09:55:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=md5XIjODWplV9CsBURxy1vAA8C9t1kfI8gX8yiTXtxatudPzXsUQp130LPhViydZg/+r9woeRCVy8Z5CmWkz1eqwsvChvba/XjL4HxjkTv897Ddq0lwXLzDOTuKQkaaoqxRWgW45Yq7z27CdUjh6MsMezFUXXLqBvYG686G2Hjt5Xs2L/sntfVTJpxSNiv0WVEs/p/gk4WY/ABDpCb8ntlxSrQIPKGS/2knvnJf0DwqJzR7yimuCJVstcQpaGpsb5JTBTdjmux4aB75M6HlWVOLeJhK7gtY9zPw26C5mEIZGoQ3VWVYax8vJMLzhXrWb67MX49n6i6rUVLXScJRflQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vI24pKOFITsHFPieXU1Ftec/dR19d0bs2Klptgxywc=;
 b=RxMtdmlJf1wLsiX2BVO45NVyNLKKoLzx/sb/NNDWKQzKWCB/XVtIIbAXepQfVl5vdF36rjsv/UdqciNaB22FwqkmJz37NbBoitT9Elr6q+H4zV8klSlDtbmIPkJzh7JPPtEnFfnztfTACXFfVUQ5af5M5a5+KdgwpjXHu4SxomcIdvLUFPdw0tespEzVF0iHMrw5Ug0iwFG47vKSX6VeaiiNmHClnsQ22B9O2m5r9PS4mQSXCahks/m7mY6f/BgSPbnT0HchejQ2BTJsraNe5kBtfHhTgZ7coxplkU6DBE+69nc3qtD49JJUWm+pbMLhlsyJsd6pAVKC3GzDy83+hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vI24pKOFITsHFPieXU1Ftec/dR19d0bs2Klptgxywc=;
 b=NChFLXj57BXCoGQCFQBx2NEmdmNMRjT/+nllJ77plEG7yldRxYa7CYp+rViIZGnbaLdKa/Jww3J+yPuMwltWuWGFPUeXePynEEFf5xfW6b2CArIjyMyWVwTkAMbVog1CX2dya4NZClR/t9IpxNxiTZxyf3yXntu8fGd9Dpa47lw=
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com (2603:1096:4:ef::8) by
 TYZPR03MB7638.apcprd03.prod.outlook.com (2603:1096:400:423::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 01:55:51 +0000
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741]) by SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741%4]) with mapi id 15.20.8093.023; Mon, 28 Oct 2024
 01:55:51 +0000
From: =?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
	<Mingyen.Hsieh@mediatek.com>
To: "nbd@nbd.name" <nbd@nbd.name>, "nico.escande@gmail.com"
	<nico.escande@gmail.com>, "lorenzo@kernel.org" <lorenzo@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?TGVvbiBZZW4gKOmhj+iJr+WEkik=?= <Leon.Yen@mediatek.com>,
	=?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>,
	=?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>,
	=?utf-8?B?UXVhbiBaaG91ICjlkajlhagp?= <Quan.Zhou@mediatek.com>,
	=?utf-8?B?S00gTGluICjmnpfmmIbmsJEp?= <km.lin@mediatek.com>, Sean Wang
	<Sean.Wang@mediatek.com>, =?utf-8?B?U291bCBIdWFuZyAo6buD6Iez5pi2KQ==?=
	<Soul.Huang@mediatek.com>, =?utf-8?B?UG9zaCBTdW4gKOWtq+eRnuW7tyk=?=
	<posh.sun@mediatek.com>, =?utf-8?B?RXJpYy1TWSBDaGFuZyAo5by15pu45rqQKQ==?=
	<Eric-SY.Chang@mediatek.com>, =?utf-8?B?Q0ggWWVoICjokYnlv5fosaop?=
	<ch.yeh@mediatek.com>, =?utf-8?B?Um9iaW4gQ2hpdSAo6YKx5ZyL5r+xKQ==?=
	<robin.chiu@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: mt76: mt7921: avoid undesired changes of the preset
 regulatory domain
Thread-Topic: [PATCH] wifi: mt76: mt7921: avoid undesired changes of the
 preset regulatory domain
Thread-Index: AQHajLb8HqlgPkc/cUSZ/xmt6p185LFkXfYAgAR7JgCAAExJAIEzejKA
Date: Mon, 28 Oct 2024 01:55:51 +0000
Message-ID: <20bf7ebaac885cf9aa1d8fde90cd524c030aafb4.camel@mediatek.com>
References: <20240412085357.13756-1-mingyen.hsieh@mediatek.com>
	 <D0I1D2J8EB1L.2DPV9W79YKN2C@gmail.com>
	 <3e2eb7ab155cbc4819096e32b914d220166a9adb.camel@mediatek.com>
	 <D0KMHQSFOY0B.3P66MD08H96FZ@gmail.com>
In-Reply-To: <D0KMHQSFOY0B.3P66MD08H96FZ@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5322:EE_|TYZPR03MB7638:EE_
x-ms-office365-filtering-correlation-id: 74f59134-a5d9-4460-b389-08dcf6f3a68a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RnpIcCtSMEphUDFWdDFITzVPSmtBd1BTVms5cTB0dS9EK2taMXNHOHEzZitq?=
 =?utf-8?B?R3k4WTM4OVJDalhFZHkyWk9qYkhraXAxODJ2NldxWDM0bTFkNjVwTzUwbG9F?=
 =?utf-8?B?bnE2V3EyTGtyMkl1Ymx0TVZ0bnlxM3JlT1hWNm1CcnNMZmh3eXBOb3loVFk0?=
 =?utf-8?B?R0RGZFFmWHR2UmU2MlRlUG9ROGtONkh0YytUdGhrd1M3c251TDlvSVFxQzNU?=
 =?utf-8?B?SS9KTENzaGVhMDZEQ2lIUG8vcHJDS08zWFE3dVVtWjRlckxtR0M3b1h3MEJ3?=
 =?utf-8?B?SjA5VWJ3VjJ2QTZaS1dwZm4vL3pIajVyUlg0Y1QvQnVLN3Q5YmJWTEYxbHlw?=
 =?utf-8?B?UVY3eTdTOVprb3EzRFZhTGNXdzFYMFBKZUN2REEveEhoazVzT0o3bk5tWTNk?=
 =?utf-8?B?aUkvR29MTTFHby81ZTRvMDI1bmpzMTYrQzQ4VnJjZjlzaXZxVVU5TUd3TFM0?=
 =?utf-8?B?aFZ5dEQ4ZjB4MkUxcWZOMnJLY2xoMC9kQW5mNlRxdGNyNkZ5TU9uSFB4Z3dI?=
 =?utf-8?B?T3ZZSnJ5QSthRWFqNTFmUzUrd2hsWit4YU1QcnIvREVjdVlFZEhmOXh2M0RK?=
 =?utf-8?B?aFhBZzZ3aVRpTEhQTzFtcDE3czVmWnF0Y09FaVlRTEhBTUhHNzdYVWNiZzJQ?=
 =?utf-8?B?WkQ5bnhsM0lISXoxN1N5OGFlTzI4bWdMOVZ5elVkWXJxbE9PUkVabTdWWXAy?=
 =?utf-8?B?cEhkN1kxZitXai83MnpWNlQ3NWtEek1kNW8zWkQ5cUNyM05OZXp5eklkK0s3?=
 =?utf-8?B?anBvUFB4cEgvWkowQUZ6UmYxUHhrWnlFK25jTWpWREtQVUhaakJ3U2tkSzlO?=
 =?utf-8?B?K0RYUEl4VnhEZXNjVEFldU5aSDdscklXeDJPOXpUaUdFNmhDYTBGazNpQmlI?=
 =?utf-8?B?VkltZ3d6eGp0eWhlU2VjMlAvQmcyc1QxQytHaWFYLzAvblRoZnEyYUtVY1NB?=
 =?utf-8?B?dWgvN21rRmtsQUtURnNjN0t6K1NHd2ZvRVVnRmNIcUNBaXdnWHdhbDcwU2Ra?=
 =?utf-8?B?S012akpMeThPYzlPN0M0OS8rZ21xOHBMUFM1ZTY5cXlhVmltd09WQzAyTSs0?=
 =?utf-8?B?U1FlYzNhWEJIZ2pjdjJhU2tJUXRFZVdYdkhZM1B2OTVBNm85VnBGNGZFRnVt?=
 =?utf-8?B?Q3FIQ1VLRVA5ekhTOVhNcEgyWlFZYW5HK0pqcDJiNnJYVm5meGxhQ0h1RlJk?=
 =?utf-8?B?d1Fsb0JqNmVJdnNaeGs1SnkraHlPdUxET242bXNzSm1sZU1GdnNIQzl3SmUv?=
 =?utf-8?B?d244dmJjblNwQ3d0aytmYTY4N3VDZ0w2TjFwc1JDZEJQTUFVYjI5Q25UTUxm?=
 =?utf-8?B?Q2hReFFJQkxDWVc1WTJKSkh4UUw1ZHh3VjNrcHo1WTJMN3Jlbm1JUkF2ckNv?=
 =?utf-8?B?K2dYd0tmMjFwckZHRkgvdXFwSTFqdnBmeDNVT3h2aFNTUEs2dTdrU3h0SWI1?=
 =?utf-8?B?dHpKTElZbXdGcFkyN0FJRkRseVl0VjRudHVFcW10bjVGaFJzU052OENJYXF3?=
 =?utf-8?B?TkV5Rzc1cGtLT3dzcHdzUWg0N1h6dU85NGhRSG0xL1dCTGpSRW1mU1dMcnNX?=
 =?utf-8?B?eHhUanhvcFpwU3l5bDR2K0VUbEpLbFZLa0F4S0Z1TzNVZnE2REJiL3lzZkV5?=
 =?utf-8?B?ODlDMm9GMk9PaUdCU3NCMjlmT0lCQ0F6ajdQVllLZkI0OHhFM3JWcmRtTUFn?=
 =?utf-8?B?RmxISzFETlNpLzdlV216OVRYRWFFcExycXZHb0dtUHFabjQ3VFg1VUx1K2c4?=
 =?utf-8?B?a3BUNzJGRFNtZk1sazVQTE1FUVpGTFlyNGpheG9EdzhtVU9YU2VVZXNCNUcx?=
 =?utf-8?Q?LBr4mYhrpwSCl3qvWzudStLFXtQTlqFjSLoOc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5322.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWM2WmkyY1VXVjNVc1hsU1RQcmk0emJ5Q3Z5M0t3c0Nzd2wzRXlMUDBBdjdU?=
 =?utf-8?B?bGdwUFlNN25jUExHMDJDczFuL0NwWWVqNDAyYlpNN1Y2WFUyKzdrejVia2lk?=
 =?utf-8?B?WGkrOXdIb1Znc0U1TkZuUStOby92TCtlRENWNWRVamxTNU1xOHdRSUJtcGw0?=
 =?utf-8?B?YUUvWlRsRC91b3hDb1lrQXN5cUIvbHdzSjltY1VRNXZmZ0p4MUFWUjVJNko1?=
 =?utf-8?B?cmF6YlgzWUo4Z2JzRkVpcUNaWVB1d2tsVzRWS1RNZ3BEYjBNaWRvdVV0NnpF?=
 =?utf-8?B?Ymt4MlNoYnc2bDVBakFKQXJhZW9DbkJrcjM2ejFrbU0yTXlsSlg3YnFuYnBs?=
 =?utf-8?B?TjNUTW83NzVVenhZbTFJbFZidUFrUjlIdm1zRmZFeVREWXUxZCs3d0JYbVIx?=
 =?utf-8?B?VzJHWDBLYkVCa3lkWTVvWEFDVnZFKzI2RVY5aW1oM2EwbVpzUUZFVFlkS1JQ?=
 =?utf-8?B?RVE2WlZ6WDRiMHNYNGVEQTBZWEg1RWs5TXljVWx0RVdXM1AvRkpiVW8vbHhz?=
 =?utf-8?B?VmY5NnZ0STNGS1E4SkhnT3JXSUEwYXZKOU90YU11TkgxZko5Tm10dGtEWUxw?=
 =?utf-8?B?NzFzcldoYU41QTV5TE1jQW5OSVV1ZDA4dEJWOXg5eE45SDMveVZwTWdUb3Nr?=
 =?utf-8?B?aVl3SHNTU251bXJoS01jZzRnQ1JuYVpkSFRsWGx4RVpoNnFnZWNpKzRsYTE4?=
 =?utf-8?B?dVlmVTJtVFhYRTFCaWdhTkZWT0NSRjdBc2o4cTl4VGdTQmxGbjU3Tzk1d0pH?=
 =?utf-8?B?N0k1YnFJUmlqWWxaRHlWR0wwL2ZGWUdwRjl3RWNwUTJPZWt6dmJuc2ZPNUR4?=
 =?utf-8?B?eTFQbVZ6V0lTR2VQMzVTSUdBK3NYMW5FZVgyN2JYSFB4bEJCc2ZlbE4zZTRk?=
 =?utf-8?B?Zm5vRDd3UDJsYTQyb2R0d1lNZmZXOHBlaUZVZGlZR2s0ZjEzWjlBblNaRWQx?=
 =?utf-8?B?Q1hlYkpOVTA5T2VZVDVIYTdKdkJvRVNmdjFBRnc2ZGNGclBGQzhXVm4yK2lp?=
 =?utf-8?B?TVo4QzhiWmo1dktncExDTjBhU0JkMjhoNTcwdXk3elhMaDBySTlLMXVYcmR4?=
 =?utf-8?B?ZUROQndCY2xubW5DN2VrWk9TK0RhWFlYb1huNEszektUY2N0bXlNTXdHLzBl?=
 =?utf-8?B?YWUvdVhKdk5wYVNSOFlXZnJ5aCtOcGp3cVYzMGJQRjRpL1NBTXh3b3ZlNlNz?=
 =?utf-8?B?SlE3ZlJlclFmWkhjWjZJMFRmS0hydVFpUE5GVlU1RFFjNmdPOGdmbFlOSGMz?=
 =?utf-8?B?d1JxbjJxRVpzK3NnQ2l4RG1WN1VtWWg5LzVqUndqNXV2VGRGQW5LRjVVTlkr?=
 =?utf-8?B?U0p3WHkvWlIrTllJRG51Wk5uWWl4L0JBTW92M0UvNys3QmN0ZUVEcVA3QXNH?=
 =?utf-8?B?QkpPREtXTWorR0Q2emMzZi93ZjFKZXpmbENIWjJweDZja0cxekp6cGg0Lzd6?=
 =?utf-8?B?a0FEZGVOUzJ0bDZaMUNCV3FxQ2dGQStxYnN3SmwweUZjYWdrL2VIaHhaaVp2?=
 =?utf-8?B?Vmh3Y1p1YUM0Mm5LQ01mZks2djIvWGdmQUJuazBnYzlteXc3VjZMNnFXdFlo?=
 =?utf-8?B?T0pDR2xaWVJ3MDI3cE5KVk11cXdycXlvbnA2OFB5dTEra1RCT0JXbXpjUjhQ?=
 =?utf-8?B?SlA0MCtiemdiaHJ2TFBuQysvbHFicU1kcTBHbGVxY0E3SWthMXBzbzUvTlQ5?=
 =?utf-8?B?VER0TU1XUjA0OG8rTVIxbUhMTFJiSmJIczNiWDMxNCtMblk2S3AzdUtUQm00?=
 =?utf-8?B?VTdmWE9CR3ROWXFaSU8zcW1NcTMwM01VNCtha3VOVEFEZlVzKzB2VEVtM2VW?=
 =?utf-8?B?bkszMVAyc0xJbHpURzltRDA5akM3K1hXblFiYitLWmRWUnl0N2pKUW1aQVFJ?=
 =?utf-8?B?a3FrSjVrN3lhYmIrc1RkWkdXWG44U0Y2OHZJTXFwdGl4aUxwOHczRm53cE5B?=
 =?utf-8?B?WFNqR3lGQlYycnBVbkMxTVNlR0taZENwRUpTWVg0Q3YvV0o0N2FzSzI2WHNr?=
 =?utf-8?B?QjdhZENBTGZSUGxyNWZQN3A4eDN0RWxSQ1J6aTlzb1UvV0pMRUUwZGFENUh0?=
 =?utf-8?B?WEF3N2ttalR6UUw1dHJYVHROL29VOGwrNXVaZXh4a2o3dFlTNEZIdzJCS3RV?=
 =?utf-8?B?SDhjYlJuSzJKSFZ4aTlFdWZBK1U5aVcxdTAxdStXWmtLYmhWcURuTFl5WjVo?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FEBAA5B432C1FC45AB24F5E079579D90@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5322.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f59134-a5d9-4460-b389-08dcf6f3a68a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 01:55:51.0985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VoXf+f7j/JugYhSwwW3D4z7Q+jCKrZV8/JNuS0+Jux5K/Is8NXUZgLb3cMp+TT8b1nybEOWaYsFRQtyekyWhZIQQEO+1LoQV+MEJmTuqkyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7638
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--27.158800-8.000000
X-TMASE-MatchedRID: oMBNC5/fKrXUL3YCMmnG4t7SWiiWSV/1jLOy13Cgb4/n0eNPmPPe5KWz
	WoIRiV9DM/Se/q/gEyf5MiS7M8c1eGmXMi7Ntyo2FS5FC3EzJAF+Mk6ACsw4Jtvpj5+dNlQvP2W
	ClDfp39rw/9MqYUo1SzDDWg3cV0z4uE5BFZz4dVThPOvpPbk2R3idToq2MMwDyPQR7DhM3jZjps
	arMSzRhp8z9zyw0lnOJ37ErtBNPld5BTB1IjcvAhD3+0w1DhqKH5EWj6tpjQJUvqB5o/Lqc2iWB
	UhB/dX7SW1GMAtQX7FtsXEhp1JYjIToZqUCO9J5SHCU59h5KrFAq6/y5AEOOgk1NPNX01GCCh6S
	2kaJWPejtBJIHld7XSNFzxiaTmkR6jfyvLMbTmoo19GoN4WoGF32WNrnPaH2myiLZetSf8n5kvm
	j69FXvKEwgORH8p/AjaPj0W1qn0SQZS2ujCtcuA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--27.158800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	8962196EFAFAD4224197EAD95B20AC3710C4D0CF62CC8B3D8400DDD3EFF828332000:8

T24gTW9uLCAyMDI0LTA0LTE1IGF0IDEyOjI2ICswMjAwLCBOaWNvbGFzIEVzY2FuZGUgd3JvdGU6
DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Ig
b3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9y
IHRoZSBjb250ZW50Lg0KPiAgT24gTW9uIEFwciAxNSwgMjAyNCBhdCA3OjUzIEFNIENFU1QsIE1p
bmd5ZW4gSHNpZWggKOisneaYjuiruikgd3JvdGU6DQo+ID4gT24gRnJpLCAyMDI0LTA0LTEyIGF0
IDExOjI3ICswMjAwLCBOaWNvbGFzIEVzY2FuZGUgd3JvdGU6DQo+ID4gPiAgIA0KPiA+ID4gRXh0
ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVu
dHMNCj4gdW50aWwNCj4gPiA+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNv
bnRlbnQuDQo+ID4gPiAgT24gRnJpIEFwciAxMiwgMjAyNCBhdCAxMDo1MyBBTSBDRVNULCBNaW5n
eWVuIEhzaWVoIHdyb3RlOg0KPiA+ID4gPiBGcm9tOiBMZW9uIFllbiA8bGVvbi55ZW5AbWVkaWF0
ZWsuY29tPg0KPiA+ID4gPg0KPiA+ID4gPiBTb21lIGNvdW50cmllcyBoYXZlIHN0cmljdCBSRiBy
ZXN0cmljdGlvbnMgd2hlcmUgY2hhbmdpbmcgdGhlDQo+ID4gPiByZWd1bGF0b3J5DQo+ID4gPiA+
IGRvbWFpbiBkeW5hbWljYWxseSBiYXNlZCBvbiB0aGUgY29ubmVjdGVkIEFQIGlzIG5vdCBhY2Nl
cHRhYmxlLg0KPiA+ID4gPiBUaGlzIHBhdGNoIGRpc2FibGVzIEJlYWNvbiBjb3VudHJ5IElFIGhp
bnRpbmcgd2hlbiBhIHZhbGlkDQo+IGNvdW50cnkNCj4gPiA+IGNvZGUNCj4gPiA+ID4gaXMgc2V0
IGZyb20gdXNlcnNsYW5kIChlLmcuLCBieSBzeXN0ZW0gdXNpbmcgaXcgb3IgQ1JEQSkuDQo+ID4g
PiANCj4gPiA+IEkgYWx3YXlzIGhhZCB0cm91YmxlIGZ1bGx5IHVuZGVyc3RhbmRpbmcgdGhlIHJl
Z3VsYXRpb24gYnV0IGlzbid0DQo+IHRoZQ0KPiA+ID4gY291bnRyeQ0KPiA+ID4gY29kZSBJRSBz
b2xlIHB1cnBvc2UgdG8gYWRhcHQgdGhlIHJlZ3VsYXRvcnkgb2YgdGhlIGNsaWVudCA/IA0KPiA+
ID4gDQo+ID4gSGkgTmljb2xhcywNCj4gPg0KPiA+IFllcywgaXQgaXMuIEhvd2V2ZXIsIGlmIHRo
ZSB1c2VycyBoYXZlIHNldCB0aGUgc3BlY2lmaWMgY291bnRyeQ0KPiBjb2RlDQo+ID4gYmFzZWQg
b24gdGhlaXIgcmVnaW9uIHRvIHRoZSBkcml2ZXIsIHRoZXkgZG8gbm90IGV4cGVjdCB0aGUgY291
bnRyeQ0KPiA+IHNldHRpbmcgdG8gYmUgY2hhbmdlZCBieSB0aGUgY291bnRyeSBjb2RlIElFIGFz
IHRoZSBBUCBjYW5ub3QgYmUNCj4gPiBlbnRpcmVseSB0cnVzdGVkLg0KPiANCj4gSGksDQo+IA0K
PiBJbiBBUCBtb2RlLCBJIHVuZGVyc3RhbmQgdGhhdCB0aGUgaGFyZHdhcmUvZmlybXdhcmUgKGFu
ZCBzbyB1c2VyIG1vZGUNCj4gdG8gc29tZQ0KPiBleHRlbmQpIGlzIHRoZSBzb3VyY2Ugb2YgdHJ1
dGggYWJvdXQgd2hpY2ggY291bnRyeS9tYXJrZXQgdGhlIHByb2R1Y3QNCj4gaGFzIHBhc3NlZA0K
PiBjZXJ0aWZpY2F0aW9uIGFuZCB3aGF0IG5vdC4gVGh1cyB0aGUgY291bnRyeSBjb2RlIG9mIGFu
IEFQIHNob3VsZCBiZQ0KPiB0cnVzdGVkLg0KPiBJZiB5b3UgcHV0IGFuIEFQIGZyb20gYW5vdGhl
ciBtYXJrZXQgYXQgc29tZSBwbGFjZSwgeW91IGFyZQ0KPiByZXNwb25zaWJsZSBmb3IgdGhhdA0K
PiANCj4gQnV0IGluIFNUQSBtb2RlIHRoZSBlbmQgdXNlciBzaG91bGQgbm90IG5lZWQgdG8ga25v
dyB3aGljaCByZWd1bGF0aW9uDQo+IGZvbGxvdywNCj4gcmlnaHQgPyBUaGUgQVAncyBDb3VudHJ5
IGNvZGUgSUUgaXMgd2hlcmUgdGhlIHN0YSBnZXRzIHRoZSBmaW5hbA0KPiBpbmZvLiBTbyBubywN
Cj4gdGhlIEFQIHNob3VsZCBiZSB0cnVzdGVkLCBhbmQgdGhlIHVzZXIgc2hvdWxkIG5vdCAoYW5k
IG5vdCB0aGUgb3RoZXINCj4gd2F5IGFyb3VuZCkNCj4gDQo+IE9mIGNvdXJzZSwgSSBhbSBubyBh
biBleHBlcnQgb24gdGhpcy4gSSBqdXN0IHdhbnQgdG8gY2hlY2sgaWYgdGhlcmUNCj4gd2FzIHNv
bWUNCj4gdGhvdWdoIGJlaGluZCB0aGlzIGNoYW5nZS4gWW91IGd1eXMgbWFrZSBXaWZpIGNoaXBz
LCB5b3Uga25vdyB3aGF0DQo+IHlvdSBhcmUgZG9pbmcNCj4gDQo+IFRoYW5rcw0KPiA+DQo+ID4g
QmVzdCBSZWdhcmRzLA0KPiA+IFllbi4NCj4gPg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBMZW9uIFllbiA8bGVvbi55ZW5AbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBNaW5nIFllbiBIc2llaCA8bWluZ3llbi5oc2llaEBtZWRpYXRlay5jb20+DQo+ID4gPiA+
IC0tLQ0KPiA+ID4gPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MjEv
aW5pdC5jIHwgNyArKysrKysrDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25z
KCspDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9t
ZWRpYXRlay9tdDc2L210NzkyMS9pbml0LmMNCj4gPiA+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9tdDc5MjEvaW5pdC5jDQo+ID4gPiA+IGluZGV4IGVmMGM3MjFkMjZlMy4u
M2M5YTVmY2Q2OTI0IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9t
ZWRpYXRlay9tdDc2L210NzkyMS9pbml0LmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MjEvaW5pdC5jDQo+ID4gPiA+IEBAIC0xMzUsNiArMTM1
LDEzIEBAIG10NzkyMV9yZWdkX25vdGlmaWVyKHN0cnVjdCB3aXBoeSAqd2lwaHksDQo+ID4gPiA+
ICBkZXYtPm10NzYucmVnaW9uID0gcmVxdWVzdC0+ZGZzX3JlZ2lvbjsNCj4gPiA+ID4gIGRldi0+
Y291bnRyeV9pZV9lbnYgPSByZXF1ZXN0LT5jb3VudHJ5X2llX2VudjsNCj4gPiA+ID4gIA0KPiA+
ID4gPiAraWYgKHJlcXVlc3QtPmluaXRpYXRvciA9PSBOTDgwMjExX1JFR0RPTV9TRVRfQllfVVNF
Uikgew0KPiA+ID4gPiAraWYgKGRldi0+bXQ3Ni5hbHBoYTJbMF0gPT0gJzAnICYmIGRldi0+bXQ3
Ni5hbHBoYTJbMV0gPT0gJzAnKQ0KPiA+ID4gPiArd2lwaHktPnJlZ3VsYXRvcnlfZmxhZ3MgJj0g
flJFR1VMQVRPUllfQ09VTlRSWV9JRV9JR05PUkU7DQo+ID4gPiA+ICtlbHNlDQo+ID4gPiA+ICt3
aXBoeS0+cmVndWxhdG9yeV9mbGFncyB8PSBSRUdVTEFUT1JZX0NPVU5UUllfSUVfSUdOT1JFOw0K
PiA+ID4gPiArfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICBpZiAocG0tPnN1c3BlbmRlZCkNCj4gPiA+
ID4gIHJldHVybjsNCj4gPiA+ID4gIA0KPiA+ID4gDQo+IA0KSGkgbmJkLA0KDQpNYXkgSSBhc2sg
YWJvdXQgdGhlIHN0YXR1cyBvZiB0aGlzIHBhdGNoPw0KDQpUaGFua3MuDQoNCg==

