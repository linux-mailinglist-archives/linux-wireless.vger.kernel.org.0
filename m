Return-Path: <linux-wireless+bounces-27031-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6519B44B85
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Sep 2025 04:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B33ED3A534E
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Sep 2025 02:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D7B21576E;
	Fri,  5 Sep 2025 02:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hVup3ZpE";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="gfrddcWg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AFC1F239B
	for <linux-wireless@vger.kernel.org>; Fri,  5 Sep 2025 02:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757038501; cv=fail; b=OkUpb8SmlPXuhVWzp9Ydby2cLhfK3bH8Wh/BJnl+6v7oFxVSHKpkaC7iyo1kIn79rHDO6IDOMHtCLYkCWdkuk5y8nZwAhYx1xYbWMrmQ8YOkGGMdB0uwz49xKUo6cJtA9YS9Py2MqngVkRmg4oYn22MmseN6cZSNEDGPLuxPkts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757038501; c=relaxed/simple;
	bh=7FWWrwI/jH2djVt4hs+/1WoPP9o0dV+QwgwaBVNMFLA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rL5fkofzrlXHEdExN0nJHIBDTy60QJfxKtNXPJGPIWo56YuSPNtm0XqXeRH0ca/2D9Mk1YP3aajqmbxa97xp+npRHknM8mf9hjrAr6xC3eujznaWqwEtYLkjJ4ZVC9yHZdk6HZovCODh6kVe9k+SCDlNWE5WTWcTPwnPP6FfVXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hVup3ZpE; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=gfrddcWg; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1aae2cea89fe11f0b33aeb1e7f16c2b6-20250905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=7FWWrwI/jH2djVt4hs+/1WoPP9o0dV+QwgwaBVNMFLA=;
	b=hVup3ZpEeEwOIXfDGCE+dYeGAdUEfWADQkXetY5Pb6Q+7aPcL4c3t5t546p/pf6gt8SSYcahuJmtLQXANXT7yo6Xcq5p3kmZ8g4f7tkvo3A2roskk3KMj6innHUKo7YYdiUjO+2lM/vmnACO8CtG0gs6QFV1aXeYm4W7wmMpJd4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:0a41da50-38a2-4dfd-90cc-fd2e91ad6ebe,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:72ddf6f7-ebfe-43c9-88c9-80cb93f22ca4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1aae2cea89fe11f0b33aeb1e7f16c2b6-20250905
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 912064855; Fri, 05 Sep 2025 10:14:51 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 5 Sep 2025 10:14:47 +0800
Received: from OS8PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 5 Sep 2025 10:14:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HR8K9i5EPDtFfv3tjstyav6Pl+LhA/6HySclkaetoi8FkhzQP7tSwq+XNeRJQ2uh8I05NZN43SQ7EhVfafJH4A1NkSFL6v+RT3v7pYUGXpV+LsBM/Xb4Lnj1XxkRDElWD61Vqp6E6w93H97GJKXuHeW3s9c6US1m2WKHw7Sq5qCovBLS+NDtLCspWYE0QMa2IEu+81JmEERkF4+w8tx2S9CYecFVbEjrYgNSZhCarxP+Jpzl0NGK65Yq5x5iu4RI6+WDdayA3nelbdRYa77dBPybC3NG8V5+GrZdHbc3909hiBJZHT4PAf7SDxE6OtECQisvg+jf9cTJ91JTBTmc3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FWWrwI/jH2djVt4hs+/1WoPP9o0dV+QwgwaBVNMFLA=;
 b=Hv1pqoattNrKRtmIYOocOY+bq1OaX/Unw0GtZA8aOVlunwB6AAVoaY2TUFmawf1qFJ4GYJdy2txrZ2pjpje24NdJhtTLPE7x/Ht9rtUqt/zlzDgFt/mOqwbyNvockg+FmHg8VFV8QRErb+MLoCUcySXnmevnemcuR0Pwlj7LGzXcQ8BDup815PQmOLoKfmQhmcGVO7qxD9JTULv/ME4lnXDA8cE/tA3y4Kct9nEKpJyo7U523YEZwXXyersEXXTTw1xteIuy/umQK5x29e2gZYdZ2iWUFRwTexenFzhuxs1x0zxiqpV3VglT2ZnTGUF9ZoP8zGYm25B7+BLW5yXvPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FWWrwI/jH2djVt4hs+/1WoPP9o0dV+QwgwaBVNMFLA=;
 b=gfrddcWgDH83AMK4fefx+OByplTDErEbjiuY45v0ls/o/NvrHI15ASqglwE3ipcaW7jwTxobePxza7B0B54SeFi78D5N2PtZGOuB+9pUZsRP98D1JNSidBExzcNd04WTYLlQEkT39LM/kX65Lim+YefrM8pPU7QrISgvLx22vgU=
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com (2603:1096:4:ef::8) by
 SEYPR03MB6903.apcprd03.prod.outlook.com (2603:1096:101:b2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.17; Fri, 5 Sep 2025 02:14:47 +0000
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741]) by SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741%4]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 02:14:46 +0000
From: =?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
	<Mingyen.Hsieh@mediatek.com>
To: "nbd@nbd.name" <nbd@nbd.name>, "lorenzo@kernel.org" <lorenzo@kernel.org>
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
Subject: Re: [PATCH 4/4] wifi: mt76: connac: synchronize token_count access in
 mt76_connac_skip_fw_pmctrl
Thread-Topic: [PATCH 4/4] wifi: mt76: connac: synchronize token_count access
 in mt76_connac_skip_fw_pmctrl
Thread-Index: AQHcHUkwco+xqH1dqkiZ2BW6sYHLk7SC+4qAgADflYA=
Date: Fri, 5 Sep 2025 02:14:46 +0000
Message-ID: <61ad7900d5909359d8c1907b6c80db921c0da612.camel@mediatek.com>
References: <20250904030649.655436-1-mingyen.hsieh@mediatek.com>
	 <20250904030649.655436-5-mingyen.hsieh@mediatek.com>
	 <bafba000-2488-4382-ae0c-df6195b83019@nbd.name>
In-Reply-To: <bafba000-2488-4382-ae0c-df6195b83019@nbd.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5322:EE_|SEYPR03MB6903:EE_
x-ms-office365-filtering-correlation-id: 1d22895b-70fe-4bf9-f22b-08ddec21fc4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WGdzUGFnMkE4QjRkMW5NR0kvWkdNOGxHVDRWanJFK0M1Y3ptaVR2a01jRk8y?=
 =?utf-8?B?YTlsTm5MdTh3NUhKVERuQllnRlh0SVBVUHQvVlhXK1JrM2QwMk00ZE04V3hm?=
 =?utf-8?B?UHpyL0RwL2M2THoyYlo2ZUhaZ0tWNlQ3dnZ5SklJckN6bjNjN3Q1QlF3Z3lh?=
 =?utf-8?B?LzRBYVFqUndBN0d0Q3NKU0thZnRWQ2U4MWxvbjJ2Z3R3K1FERmRyRUlRQnhK?=
 =?utf-8?B?YlM5Z1VjYmw5dHlCYUN6ZmZXTzBibHQrR2M1bHpqRWk4WG9MWHBvbmdWb1RQ?=
 =?utf-8?B?Y04ycjkySWVVVGM0MStBRE02WjFMOVZmVWJxV3A4Wkl5WVdRakNxQlpJQUhu?=
 =?utf-8?B?SGR6Tk1Ja0swOVNMQThUUk9PVHY0S29Hb2pjelFobjhoUUJKOGttY2RrOU4w?=
 =?utf-8?B?bldVOFliVllQRGU4YUVlc05mVDE4VEZycmtKeDZ5T1BMRnhVQnYzSWwrQks5?=
 =?utf-8?B?Q0NiZFUyaStUdERNQ1NyUnYyY0lFVWNSbkJvdUJmOFJUY01TaFJGazZYY1FK?=
 =?utf-8?B?eW40bHpnQmo0RGFYM3VXVlY0T1lHSGZPVUJqQzJFTDdjM1NFdmhJaFhTRDd5?=
 =?utf-8?B?NHVnQ054YktzZ08vV2ovR1ZFMC9wK3BEdEV2ZzFGL0cramk1WGNtZDZoNCt4?=
 =?utf-8?B?V3ZaVVYrQ1NMcDFzazBZRFZZaC9abGNhSGxISzhZdldnL2Urb1BuY1V4cUJX?=
 =?utf-8?B?cWk3MitHVVovVnBLN3ZrNDFDRVQ2SUo2ZC8rNFlnMmsvSlg5S0N3TUwybW4y?=
 =?utf-8?B?L09tTHlPbnJYd0tjV05aQXlmK1gyL3hqMEJXTmF5bm9DMi9FOTU5STRET1JW?=
 =?utf-8?B?bnpydlU5WUdKUWZYdWhvK2VFeUNqdnNWb2hXZmVtbC8xVmhmbUV4RFNJUHRk?=
 =?utf-8?B?Q3h0bVpndVlIZkpTTzJLaldDQ1NmakVGbzR4NUV1L2ZFMlBjY1E3QTFkMVhi?=
 =?utf-8?B?Znl1TWdOOEhMMUN1a1R0ait4WTZ1WU9qTnFwWFpKUzRYUjVtSTdQOGxuTWVE?=
 =?utf-8?B?cGpESFdtd2NzOUp3Y2dsWGNtVTZzMlh1cGFraUIzcUNRQlZ4Vkc2Rm9EMVVU?=
 =?utf-8?B?eG9SS1FUVVEwOTQ3YUFvVzh5ai8xWG5DdkZHM3JpNUhIam1vOWJJNjNtYjZ2?=
 =?utf-8?B?aDhiMUZpMWU5UW0vMDJtdDZjVmRZTngwYnJsRG9yb1VydXFrZVFpNllqZjFq?=
 =?utf-8?B?cUV2QlNlajl5ZWZyZjFCOTc3OWl6L1R0QkEzTDNoYzE5Zjc4QW45bzZMSVdJ?=
 =?utf-8?B?WnR3MjR6MTNuN0tLRER0ZDY0bDhiY1ZTSHUxMFpqTEZONmRTNE5EOGFaVWdp?=
 =?utf-8?B?dlo3aER0a09pM293ZU1sZ2NnaDZiUVptM0llejVNN3ljeXhEcVBneXZ3eW5a?=
 =?utf-8?B?YUJxbXphVWRVTlEwU2tGY001c2NvZ0QzKzZKZnpjUW1JSzQ1eExpVVVRaXFW?=
 =?utf-8?B?a3VnTVZIMVZ0ODNJdzh3TmZKdTNjei8xWmFWVTNGZVhPanNyaGJSQnBKOHBX?=
 =?utf-8?B?SUNVa08rYW54SlB5NFFrc3o5Nk04MUFQY1BjUVkyUVRDYlB2TW9yQUxsV3o2?=
 =?utf-8?B?dnZDWEQvcGtuUWFwOHVBZ2l1L0M4dm9ldkpLRTZsY0xpOGxkN0JxZ2hmRm1a?=
 =?utf-8?B?L2RNdGxFMDRXdS8yYXFLS2k1cDZmdHlNZEhOMkk5NzlIdGlVSUxxOUZFYk5K?=
 =?utf-8?B?Zk5xVDlwMUQvMWZYVHRFWU5FamMwSFdUa1pVczNLMWpMczdWQ3pmUFo0WjUz?=
 =?utf-8?B?V3RGTTlwOFF5c3ZjM2psa0pYeThYVU40d3R6eFp1UFdlUnFRMjEyRjloa0ZH?=
 =?utf-8?B?OEg3OGpTSVZCczVPMG90SUE2TGU3RVc4SjJNOC9CRzVWWDBmOG5ySnZVWjhp?=
 =?utf-8?B?dWpDTFJKc2ZYZU1PU1RDbXJCT3dRR3NJVWNKOE9mMW55SWEvNjVwSmxlekpH?=
 =?utf-8?B?UlVPdmJnQ0g1dnNxblpLcjU1ODNQTnlVL3V4YjBma25ld21TUHVGQ2JzTUNp?=
 =?utf-8?B?M1dWNi9hMGNBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5322.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVk1ejdDdGNqV2J5b0QvQ0swU2pCL2ZNaGd3WTlXclpSZ3F3WXpqa1M3SlM4?=
 =?utf-8?B?UXlFaFFyRUV0d2NUTGRvR0xVcmhwc0xFZWRPTFp6VGRFMkYwUHY0cmJOTldl?=
 =?utf-8?B?L3JOSGk0U2dBNzYyTi9IYkxJdnNNdHF3dEQ1K24zcUFDUXpQWnA0dFAyMFJr?=
 =?utf-8?B?RVhHTnhDeG85QUFZY2JiL1Y4N01JRTJnSEUwNSthamJ1VnNaSjhHRFFnWXlU?=
 =?utf-8?B?S2hMSXlJb0R4MUFISnlVT2xyYlNnaVBGcmhFY2FuUUpWTGlsemtTTVhqNTZ3?=
 =?utf-8?B?aWJPNUN3TTR6eUVIU2JpZ3VZMWVjTytzMlR1M2UrRGJKNkY1VnY4bUdpWWxG?=
 =?utf-8?B?WkQ3cTRXbXRnQ2E2V3JMVVhHK1RDQlhSWE5FUzVTb2dlbVRCT3BuMXZ4Wnp3?=
 =?utf-8?B?anF4OXNMQm9zcEJURjBleGVsV1kvWXBRYktmdm9VY3RLTUYxVzhmcFZVbUVs?=
 =?utf-8?B?b0ljV0p5S28zc3gvdlM4TVptK2orbDFtaW9CUXRkaVRQOUFCZnBDRklUdVhS?=
 =?utf-8?B?RFlMWXAwYmQvUzVYVVBQOWl6em9zK2dKUXlBZWw1ZndFYTl4K2VmeDZaY3Fm?=
 =?utf-8?B?Tkk2ZVROWDk2K2VHNUZjc1VzSHVNY3dRSjM2elVGZU0wWGdUaW5VdmUwR3o5?=
 =?utf-8?B?eVcvbGlTYWdNclVzZlVVa3NhVkVHM0VCTGdlUDY5MUs5UGZqTHlXd2xIQXcy?=
 =?utf-8?B?RE94N3JCMldwLzl0S2NNSmpNN0dqdnd2SWFQWmdlK0NDbmZrdmUrQzU1VFFF?=
 =?utf-8?B?U21TWUZoZ1FTNU5LWXF3dWdBV292aldPSTNPMitHemlIWGxGVWNMRGhZaE83?=
 =?utf-8?B?bWVSekZaTGNHQUlNRWc0RktLVjVBakhYeGJxdUxOeDl4RjNCSU9Nc3BsNFFh?=
 =?utf-8?B?UG1pMmtsa1E4NXRRNEc5cjk4UW5LZnY4SmVKYWNIZ0drVS9zS0FxdDlHZytk?=
 =?utf-8?B?SkNxOG9YOWhnU0RvbFJ4VGFMNExVbkZHRVd3clI4Q0d4a2I1SDdJTjEwQXpq?=
 =?utf-8?B?RW56TFBvZE82VEo4M0JMTzhMUzV3VU1tRDNxZzNFV0REVGErL2FEK3RpLzJZ?=
 =?utf-8?B?ME5ORTI3T2ZhRDRaZytIV1JrV2VCWGpKUVN0L3JxSURnSU1Bb2Z6elB4YlFX?=
 =?utf-8?B?UUNYZjhXK295Ui9ROVdMU1czeGRzSWc5UVNObjAzN0lMTlc5ekVqbllhNjV2?=
 =?utf-8?B?cVhHNTVuS2UvUnozUjEyNDNYdXFXdE1VOFBmS01JRmdYVS9rRVhVUDRNeXVm?=
 =?utf-8?B?Nk9wVGdYb01ibHdid3JxeEZpZG1hbGlSOVJjRWVpaUtQQWZYZUMrbXkzYXE1?=
 =?utf-8?B?UFdxTVV4YjFYV3dtVWhzeWlDL0NnOEp5di9ha3oxdkZNVVdTWjF2MmdIWXZ3?=
 =?utf-8?B?RFV2ZkhWSDZGaXRwTysrZCs4TERRUXRObWFMTHgwNU5raDBFd0lvOG1nSDg2?=
 =?utf-8?B?OTU5cTB4bGZsckdwVi9MTGI3KzI5ajVnSzZHR2plbU5IR0laSEhqd055aEZr?=
 =?utf-8?B?V3U4Vm5ac1hOWWNDME1BWjdnb0tSWmdoblFXNktCbXRiWTJmVUd2VUhMMGtJ?=
 =?utf-8?B?RlE3SDZGWkQ1UE91cldGVG9GNms5R0g3TzIwNW1zVTVEcFN0R2puTkN0dkRk?=
 =?utf-8?B?MmdNckxTZTE1MUR3UFRadkFlUWQ4TVNyVEtGZmRzZjlzeGNWZ0FIS0JESUZh?=
 =?utf-8?B?Ym1Cd1p6MWZ4d1grS0ZPOUhsWndGYkZKaEZQbUYrdkR4eVVWbDBLWDg2ZG84?=
 =?utf-8?B?VGl5MEZJc1B4dk84Y1hBemt5UkRSRHdhcDJ2OHJJTnkwMnhmOS9XbEw1bjJZ?=
 =?utf-8?B?MkIxY3RqREtlcCs5S29lMnJjNWdBMkdhN1NkbkE5THhTVXBFemFsbGx2V29P?=
 =?utf-8?B?Y0VVWnlUSTVrTU45YWN3NGxKRDdjNXNrcnZaUUp6UU5jSFZEdU9KOHpNazc4?=
 =?utf-8?B?MUtpN0trWWJKOXBEeHhOaUN6MzZJSnVhU0E1eHY0OGQzeVNXenNWSnZlMGp3?=
 =?utf-8?B?MDJHaU9qemxzdWt5VnVWZGlUNHFQb2dnQ29wRTdoZTBJckxKS05xbW43ajdJ?=
 =?utf-8?B?eFFJR3ZoVEp2dFhEbHlHSE9mWjluRmc1bzA1S3RuYmZIdUQwSWdEalpHaW1n?=
 =?utf-8?B?VG9CZmdGTkQzdCtuMFNNeWxTM1lBam5ld0ZQUEp5K3hFTnl2azJxQjV1T0FY?=
 =?utf-8?B?R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1245369DDB3FB642BB8C49A59803D471@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5322.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d22895b-70fe-4bf9-f22b-08ddec21fc4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2025 02:14:46.7210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jUyRIbjbisYR7IrOysIQWJF7RLEQuVIBEKPjuKbXAq98RcZ0p5cbYHR2q3DcyaXVrM1GHNeMBzKRgUzHrqah7+3oJKHaHQhVDjkHiipd2Ps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6903

T24gVGh1LCAyMDI1LTA5LTA0IGF0IDE0OjU0ICswMjAwLCBGZWxpeCBGaWV0a2F1IHdyb3RlOg0K
PiANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUg
Y29udGVudC4NCj4gDQo+IA0KPiBPbiAwNC4wOS4yNSAwNTowNiwgTWluZ3llbiBIc2llaCB3cm90
ZToNCj4gPiBGcm9tOiBNaW5nIFllbiBIc2llaCA8bWluZ3llbi5oc2llaEBtZWRpYXRlay5jb20+
DQo+ID4gDQo+ID4gUmVhZCBkZXYtPnRva2VuX2NvdW50IHVuZGVyIHRva2VuX2xvY2sgdG8gcHJl
dmVudCByYWNlIGNvbmRpdGlvbnMNCj4gPiB3aXRoDQo+ID4gY29uY3VycmVudCB0b2tlbiB1cGRh
dGVzLCBlbnN1cmluZyBhY2N1cmF0ZSBwb3dlciBtYW5hZ2VtZW50DQo+ID4gZGVjaXNpb25zLg0K
PiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1pbmcgWWVuIEhzaWVoIDxtaW5neWVuLmhzaWVoQG1l
ZGlhdGVrLmNvbT4NCj4gDQo+IEkgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0IGtpbmQgb2YgcmFjZSB5
b3UncmUgdHJ5aW5nIHRvIHNvbHZlIHdpdGggdGhpcw0KPiBwYXRjaC4gQXJlIHlvdSB0cnlpbmcg
dG8gZml4IGVudGVyaW5nIHBvd2Vyc2F2ZSB3aGlsZSBhIGJhZGx5IHRpbWVkDQo+IHR4DQo+IGlz
IHN0YXJ0ZWQ/IE9yIGFyZSB5b3UgdHJ5aW5nIHRvIG1ha2UgaXQgZ28gdG8gc2xlZXAgbW9yZSBy
ZWxpYWJseQ0KPiBkdXJpbmcgY29uY3VycmVudCBjbGVhbnVwIG9mIHBlbmRpbmcgdHg/DQo+IFdo
YXQgY29udGV4dCBkb2VzIHRoaXMgcmFjZSBhZ2FpbnN0LCBhbmQgaXMgdGFraW5nIHRoZSB0b2tl
biBsb2NrDQo+IHJlYWxseQ0KPiBlbm91Z2ggdG8gZnVsbHkgY2xvc2UgdGhlIHJhY2U/DQo+IA0K
PiBUaGFua3MsDQo+IA0KPiAtIEZlbGl4DQoNCkhpIEZlbGl4LA0KDQpJIGhhdmVuJ3Qgc2VlbiBh
IHJlYWwgcmFjZSBzbyBmYXIsIGJ1dCBkdXJpbmcgbXkgb2JzZXJ2YXRpb24sIEkgbm90aWNlZA0K
dGhhdCBzb21lIGZ1bmN0aW9ucyB1c2luZyB0b2tlbl9jb3VudCBhcmUgcHJvdGVjdGVkIGJ5IGEg
bG9jay4gVGhhdCdzDQp3aHkgaSBhZGRlZCB0aGUgcHJvdGVjdGlvbiBpbiB0aGlzIHBhdGNoLiBU
aGVzZSBhcmUganVzdCBteSB0aG91Z2h0cywNCmFuZCBtYXliZSBpIG1pZ2h0IGhhdmUgbWlzc2Vk
IHNvbWV0aGluZy1wZXJoYXBzIHRoZSBwcm90ZWN0aW9uIGlzbid0DQpuZWVkZWQgaGVyZS4NCg0K
VGhhbmtzLg0KDQpZZW4uDQoNCg0K

