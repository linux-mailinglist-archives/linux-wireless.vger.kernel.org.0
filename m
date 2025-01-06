Return-Path: <linux-wireless+bounces-17098-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49153A01F0B
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 06:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF49D3A1F37
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 05:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4307714D456;
	Mon,  6 Jan 2025 05:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="q4KgA/Br";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="CIBnkDhg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881498C1E
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jan 2025 05:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736143111; cv=fail; b=TNzWrQnPWWzHxJo00PYK8OPizY+gnuNOo74i5r13TOdbnsJChrVskPc8yCZ8Vcp0VDqNmsMikZ7JWEZcwdRWMrqI0ImkcQYtF2+UAY+4o/Tl/ofP3kCpgx4OMpvfV8zeDP+gy0iiV0I058+QiMRMu2RHdjNFaykgwdBgisqoY0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736143111; c=relaxed/simple;
	bh=niGdHJPaVJmjXRAEb+Fi/BC7dvX5/HKWpZzdejwH1fg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pl7hpJamhIfLbaVWX70sJmtLCKYsqtSE/6FHgl35bUvnAv6ZeHKzM/lYaVnnRDDPiPQxFoHTnnpEuCDr3XgOeCQlqDIJYfz9DxnJ8fCsX1xRLTQOlS9hqaBm0ldCN9x7B8BX48Z4uIT9BzeB+jdQ4u9WFP1uyNjx4acT4dvoy0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=q4KgA/Br; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=CIBnkDhg; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3877564ecbf311efbd192953cf12861f-20250106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=niGdHJPaVJmjXRAEb+Fi/BC7dvX5/HKWpZzdejwH1fg=;
	b=q4KgA/BrRAEw/XAu0ITaR1J8KMAJ7csb2/4GwzloiBCfd0GMxnTdSZ5makKRtG7p/E7hmLhri7OA0HwHD818SNAQEqlZKCJyXcCYwbrnlY7wl0wVfQrCJ3AATvGcFXmcNLM5QJpuIenEQw6rA67LsJpG4gjcVvITLemQWLmLEFY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:bd758dfe-714b-4536-995a-666259c09922,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:4df96a37-e11c-4c1a-89f7-e7a032832c40,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|51,
	EDM:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 3877564ecbf311efbd192953cf12861f-20250106
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1424941946; Mon, 06 Jan 2025 13:58:15 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 6 Jan 2025 13:58:14 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 6 Jan 2025 13:58:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIH2731SRMO8LBhg1I1poH3zNnpNAFYcDaABNxe5DMiqQ9RqjVNMAuAfvvqtSe8Tpc1pvPgIyHlb3k+WwZsSX7N+gApkwo6KFsVpJW+f34VW4eM876bk4a1zq/TXe+gKyLmFrOtusgPny4acmSS16h74+IV4s32lM5MZyuXgxUPQPEHBKg8lT/KwCBX28xWHviRiCnCKG4oLSV+yZMolVfE28R3+z5lFL1OD0xbw8RYGi4e5eU+jqORbAdYFy18Fy+CvxwSpJSYVGk2wZ0ivGZUpFPGEzET1jTDomrw5ye6Ulgl7mbXAM7Brqus6Bg3T78VGJZMx81jpDVGDs4utgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=niGdHJPaVJmjXRAEb+Fi/BC7dvX5/HKWpZzdejwH1fg=;
 b=qtauKkBPjwDxKEBu/T3yj3mVBeVGsAg7Zb7ckQUPdAqrnoecAPHCrDTeshv/IW7N+asAZiBAAFgI5HfBHrcLZYIN4RIbJumCx73ypcnrCEtE8agN1+hsF0M7z9b0j9uZqil5X1meaipMv+7q6fTGxFuFFyUDL1JtTj13BmuxEGKoFTYmdb8PDOmX+u+bq6Mvj2B2eOkodTDw4ukmQsAtphnl+w5ncFE6+h4enUOQeD8Bmusa/xmn7jSX66BndPwedtQgLKZsgBdATh0TUOONgoOIhpRy/+rKBcJiU9RvYXu/okTG9LW5B2UHmhVCq+m52yvHutKSqPSMq3CDRQWrIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niGdHJPaVJmjXRAEb+Fi/BC7dvX5/HKWpZzdejwH1fg=;
 b=CIBnkDhgjCh/Wdg3gSXqP1Lq4ZlVCbLdZXiaurnul39EtB6nE+mzMSVD1sKQP/HVLbHF4zyJICPTZKS5KRxiMDdfdWbti2xYFFugqZJ7RvPBvFMyJRYw7Knj1E7x/VifY/vbPUJibPJwMLDIxkzv606hddHGb6525BRFlyY8VOs=
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com (2603:1096:4:ef::8) by
 TYSPR03MB7475.apcprd03.prod.outlook.com (2603:1096:400:410::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.13; Mon, 6 Jan 2025 05:58:12 +0000
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741]) by SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741%4]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 05:58:12 +0000
From: =?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
	<Mingyen.Hsieh@mediatek.com>
To: "nbd@nbd.name" <nbd@nbd.name>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?TGVvbiBZZW4gKOmhj+iJr+WEkik=?= <Leon.Yen@mediatek.com>
Subject: Re: [PATCH] wifi: mt76: mt7921: avoid undesired changes of the preset
 regulatory domain
Thread-Topic: [PATCH] wifi: mt76: mt7921: avoid undesired changes of the
 preset regulatory domain
Thread-Index: AQHajLb8HqlgPkc/cUSZ/xmt6p185LMAwhwAgAoiSmCAAAIagA==
Date: Mon, 6 Jan 2025 05:58:12 +0000
Message-ID: <daf72e6b81e4c05f33ef08bd592cd04048a82e4f.camel@mediatek.com>
References: <20240412085357.13756-1-mingyen.hsieh@mediatek.com>
	 <0ec8b1bd-6bd8-49e9-86c1-33ba36709331@nbd.name>
	 <SI2PR03MB5322E7B73B5AB27215A5436585102@SI2PR03MB5322.apcprd03.prod.outlook.com>
In-Reply-To: <SI2PR03MB5322E7B73B5AB27215A5436585102@SI2PR03MB5322.apcprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5322:EE_|TYSPR03MB7475:EE_
x-ms-office365-filtering-correlation-id: 5fa6c3cf-4028-4155-398b-08dd2e171acd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|7055299003;
x-microsoft-antispam-message-info: =?utf-8?B?M1cvS2pyZ2ZCRlR3WVRiaEhDRTYwVU0rRndrR01PNnBLY3RydWFVT1VhRWNY?=
 =?utf-8?B?MGx1bjM2RTFVY2M3Q21IMjVQSTYrUmpRZXpUREZKcUIwUC96RTNGdjhZakxt?=
 =?utf-8?B?cWFNbGlrQ1dIdDhUSXB5UVFhb3ZoK2pNRzZxSG5FNzJkdDE1WDV3OWJzSXhW?=
 =?utf-8?B?S1hrM1orRHAvNlM2SVRiZmhtN3FKTFRBRlJYOE5jT2VnTnJiNjcyeEtGQzUw?=
 =?utf-8?B?WjFQSkFmTW5vNElpU1NCYUxiVVpLbTBmNklzK3hTa2RuWDg5ak54dzh6eDRs?=
 =?utf-8?B?WTI0aURXSkpnZHB3KzhQZkgyNWhheklWZWNsS2I1bDRSN1lualZ5bldGV2pn?=
 =?utf-8?B?dCtaOVk4VWVERys4L3VSR2trNE9Ca0czSHQ1cHd4V3JoSnY5MXRZanFSODlI?=
 =?utf-8?B?dlk2Tnl1V1ZCNlNlS3p3ek5wKzRmV1RtN3BicGdDb3BGU2lBR0Y0Wi9EaUJv?=
 =?utf-8?B?QWE5OU1RczkvVW5wWWRoY2RRa2k0S0tTQURIUERyQ2Y4c1JsbWhJS2tKc2Ew?=
 =?utf-8?B?ZHJBalVxNlhzdnV2Q0FYTEVEZThVZndqRzZnWWpaNzBHMVBFK1NyRXBERHMr?=
 =?utf-8?B?UU54alJ6b281b0RCSWx6aVFZb3hIM2p4RFduY3dHM01HZ01KSXA2dmVSVHNV?=
 =?utf-8?B?cWhXRzU3MEI4WTBKNGhxVFRmSldEQnQvdjZHRTRFREM1T1pvUjZSRHl0MXRl?=
 =?utf-8?B?cDU5QUJIalpXVC9PZjA3cktPT2dlRXlNYzl5RnpMZC9xbzAyUjc0TGlVbFc0?=
 =?utf-8?B?RVNKWTZhQysyR3JQQkZYM3BLTFFGVUJEYVh2YzA2cFBhWS9tK2NaUVNBYXg5?=
 =?utf-8?B?alI1bmpxb1hSQ1IxVWhodlZFa0QyR09uSVlpOHR0MXFPMjV4bmRTT1BWbGFX?=
 =?utf-8?B?MUZ2QVlqVG5xQmpXNjhiSEpnNHQxRTRNVFRMbHFtVEVaanl1N1ZVMVBseHBN?=
 =?utf-8?B?MjhxaXVzM1VzcHh0YmVlYlpZNWo5QktUSno2d0pNNEhHVzl0MjlySlhwQUN6?=
 =?utf-8?B?TEwycGhpY3I2QjJuaXBNbndvUmY3cVNtQjd5dTFxQ2ZWRWk1YjROMDlnMVNl?=
 =?utf-8?B?VXRBL0lxOTEzblRPNXY3bE0ydlAyNG5uSEdOQmZDZUx4RjJnaXgrRHdVREV2?=
 =?utf-8?B?cXpPVFMwWGp6ZEY3ZFd5M0V6b0hoTXkxcCszVWQvdFd3OHloa0daY2tiSDFr?=
 =?utf-8?B?cEo0TXdkWUx2RlZGSVBRRkd6QWJEeUxKeE1pSEpqQzlleFpUaFViVHNYdUVD?=
 =?utf-8?B?UVdYK2FzcnVkWWpkenFuYzR3cng0TGlGVHVPU1J3elpxbFhlUlVEcHh4V2hw?=
 =?utf-8?B?Qk5lQUs2YlFhMHVqcVVaMWNDZjJpSTMxSjVoeTJuTnZKQnNSMmlGT2VSK0ZN?=
 =?utf-8?B?Tkd5VHVOSWpzV3g4N2RucGg4dDBRNUYzajV3N2h1SGhpUHdtMFVLR2lBN3Fp?=
 =?utf-8?B?dlNBS0NiQW55M242M2Q1SFlvakN2NTFnS2YyYSsyZnd0aFhnam5Ec2k4aVVY?=
 =?utf-8?B?SnNUY0tsR0VSSzFMZkNrTnhlbVdydXJaVnltQ1ZHbHdqcis5U1hhS2VXb2xk?=
 =?utf-8?B?b0JsQlhid0xpLytCdVprRHVhbTRLTzJTUTh2aXVpT2NaOC9tOG5CVXFxVFZS?=
 =?utf-8?B?ODVJbzRjUmxTMFFkWjd5SlFoeWEydXgzaFVVOGFjenJudjZjODdZc1ZGMmFx?=
 =?utf-8?B?R3lmRi8rWVg3blhqc2xLRnhCZjRJLzEyQ1ZMODRZYktUelhLVFZpQmN5N1FV?=
 =?utf-8?B?c1dVZUJ0ZS9BWlJRZHR4c0RNdlBQbW1iQVg3OUNUcUZYNUJHUW02N2xFSldw?=
 =?utf-8?B?NlpNUUZrNlNCdU0zOXl0Mmk3STg1ZS9oRkl5UE1CRWQ5eXBDU3I2YlordUs4?=
 =?utf-8?B?L2YwdlFKQU43aGNLVUhNaE4vQkkzOEZEOUtvOGp4eXIvUWtuQjNPcDlHVHlH?=
 =?utf-8?B?b291bEhaMm5qUzRFUWFUR3dCUmJnakN1ODM0K0x1YmhlVjhnUmNLL29NTDBC?=
 =?utf-8?B?QXVzSG1QcWhBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5322.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7055299003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlJFV3hiZFl5TlEzRGFDaE9BdVpXNmpXZFlDUTN6THRSblNBMGgxSDg2dzdC?=
 =?utf-8?B?c1VHbGRJYTZiSFM2aWtueU1lSGtEaXd3MjNDM2lNcWdWQjNKTFhZS3RjMFRV?=
 =?utf-8?B?VWJsZjBYTzY3U3ErUXBUOGdWTU56dy8wTUZCQVpFVHBDemgwazgycDB6TkdG?=
 =?utf-8?B?emE4UHgwck5Yc25jeVdOYlEvK21oVFF1RGJSWjhtSytoUlZlM3Z6WkZRcytk?=
 =?utf-8?B?bm1BRXlpRkRUWnVIcjhPUm5PcFZqRHlQU0NzYllSREhPSjVDUEdORjdqczFR?=
 =?utf-8?B?dW5JSkVsNnE5SlFvdDRSQWRjT3dNbUo1ZTNsYlJmcW9ocXFVZTBWbEVha2Zx?=
 =?utf-8?B?NlJTTldlTHBZazZ1cW9TRjJtWHFIZXl6OUI2N3RPaW5aR0o1SkZzbWJ4TVpl?=
 =?utf-8?B?Z20wL2E0eWVqTWpJR0NwZU5ETVJzMGQvOElnbk4yQ3RwdTZXcHMxbjNsRFVN?=
 =?utf-8?B?eVBBeERPTitsTTRtdVVYbGREd0RwTWFNV3FkbHVQTmRISFhlMTVOWURGbTV2?=
 =?utf-8?B?OTBtcDg3bEFKRzM4V2hMVWVmWkV2L1RVT1diUEhyOHNsVlUwdy92ZjdQRy9C?=
 =?utf-8?B?Wjd4ZEF6MmdhdVJTLzJPSUdOOEozaSt1ZWY5SmZHclJoTXU2RDQ5U2h6OWZn?=
 =?utf-8?B?SFptM3pIYmJGZjVkaW5nL1NMQUlLNUZpb1djbmxCM2QxZFgwSVNnWm5HWHF2?=
 =?utf-8?B?WHprRWRHM1RyNHZnVHA1dGFVN004VkVabXVQQjhITWh4UE16alRUUGIyTE5l?=
 =?utf-8?B?OGdyRWM4L0JJU1NodGdiMklXTDEzbDlSbzVaVmNhYU9HaVFuNlE0KzBUNWJ0?=
 =?utf-8?B?K1FqS3dReWM4RlNLaWhqdTRoYklhVjkrZDAxSXYvWCs2dTJSMXlPd2h6dXFq?=
 =?utf-8?B?SGJTVEkvZ3lVbTlXQzhYbnMvWkxBYVRudWhMa3FwblpGQlFQbVZ0Z0x1S081?=
 =?utf-8?B?aHJsclRYeElpODdCd1A4RHZyT0ZkckNxWEhlNCtkOURaWjM4MnRZQUk3MGIx?=
 =?utf-8?B?Z1JieHEyaml6MmVUNmlaQnJJQkRRd1VRdDRnUVNXNHd5ZW8ySkdpNHpWM0pJ?=
 =?utf-8?B?eC80Rm5oM1Y2VEprWWlYWDNlNjZ3YTgybDhsSkNZWHBSK251cHZWOXpTdWJR?=
 =?utf-8?B?NEx3UXlmRkRKd003ZEpkd2tFdGlrS3NQQkt5UlBWT3RmeDRqWm9mSmdmbU1I?=
 =?utf-8?B?VW5vbHUwZGtEZytqNXJSOG0yV0VsNHpuZkRVOTJoSmZwSnpGcEtDWkdFbEs2?=
 =?utf-8?B?ejE0YW1OaGxEbjQ5OWJpYTQ0UXUydVhBUUthQWhEU1h1VzBYa0dCTUIrOExI?=
 =?utf-8?B?TURxU25KUFFvRFRrRGNKNDFsR2VWN1hXTjlaaUZGSnZoQzVlRlhDUjlIUnMr?=
 =?utf-8?B?b0ttUVNQWDF0SmNLTGtzWnpXaGMrK2pIYzBub3ZsSldEbkNSb3NlMTJiam1O?=
 =?utf-8?B?a2xyRUllQ1lFMFA2dlVpcmhOeCtvZ0NaZUJneDR1b0h2QVBQS0djRHNBVUV2?=
 =?utf-8?B?aHNFTmNEU2lRVHRhRFRoSkIvQTVpRjV3bm1BZFVlbDFQUW0wWHpYU3crd1lK?=
 =?utf-8?B?dXlkMndQY0p0QlQrdVp0aDJOYThZRWsxT1N1enFhOVgvQmdTRHE3K3JQNWVE?=
 =?utf-8?B?cEdGM2d5SzN3UFhyRmRBc0J2eWtvaVNDR0dlYmZrUUFEcHZ3aHYySFM2akky?=
 =?utf-8?B?YTBkS0prTWU5WGhOL29JajBrNllvU2VzQTVaaVkwQjU4VHUvRGlwUWh2bEY1?=
 =?utf-8?B?VFNqUkNuY3JwWVhSUWpsUVo5M083cW53aU9aMXovMGt2L0lGbTZxR3ZlU0NW?=
 =?utf-8?B?V1lUUllWVTU0eDdvMDVLWi8rZExqQ25OeUdXOGN4UVNFYmNGTUw3VUk1dGw2?=
 =?utf-8?B?aThySDcvUkRMZlZMSXJPMTd0dEVmd1R4OFZLL3NlUjFGcHZPR294SEVSYUlZ?=
 =?utf-8?B?NE4zbXYwMzNxUmZzZUg1VTFWNDFxMFdXUDVLVWIzWkQ0MTlvbjhKQktuNWdr?=
 =?utf-8?B?QndPRldQdWJIcWo4SUZ3N1VMWldmeUh1NWN3S0pSMDh4Z1p0VzcwS1NRajdr?=
 =?utf-8?B?VG9Zd3RrL3FiM1VyWUJtWmpYSWlWaXM1YnhIYTJ3L1BvLzN4VnFhZjJKYUk3?=
 =?utf-8?B?RWlJR1FwRkFCOWlRMlR6M3NtSE1JdU56Y01BTE1kRk1STmVGZ3NZZEJXdU1m?=
 =?utf-8?B?b0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB034911A52C41419C62F8E5D7923A61@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5322.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa6c3cf-4028-4155-398b-08dd2e171acd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2025 05:58:12.4811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ug3kLH2KjgZUAsQM63k7XatzJ8/AZZI6w3U7kQOEEanghzP0WKMzaokMgJ9FCe5Mk4x2xWnori8FM4Q8b9iNea6diIEsR+nQrCPDQSuwkOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7475

T24gTW9uLCAyMDI1LTAxLTA2IGF0IDA1OjUwICswMDAwLCBNaW5neWVuIEhzaWVoICjorJ3mmI7o
q7opIHdyb3RlOg0KPiANCj4gDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IEZlbGl4IEZpZXRrYXUgPG5iZEBuYmQubmFtZT4gDQo+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVy
IDMxLCAyMDI0IDM6MDUgQU0NCj4gVG86IE1pbmd5ZW4gSHNpZWggKOisneaYjuiruikgPE1pbmd5
ZW4uSHNpZWhAbWVkaWF0ZWsuY29tPjsNCj4gbG9yZW56b0BrZXJuZWwub3JnDQo+IENjOiBEZXJl
biBXdSAo5q2m5b635LuBKSA8RGVyZW4uV3VAbWVkaWF0ZWsuY29tPjsgU2VhbiBXYW5nDQo+IDxT
ZWFuLldhbmdAbWVkaWF0ZWsuY29tPjsgU291bCBIdWFuZyAo6buD6Iez5pi2KSA8U291bC5IdWFu
Z0BtZWRpYXRlay5jb20+Ow0KPiBMZW9uIFllbiAo6aGP6Imv5YSSKSA8TGVvbi5ZZW5AbWVkaWF0
ZWsuY29tPjsgRXJpYy1TWSBDaGFuZyAo5by15pu45rqQKQ0KPiA8RXJpYy1TWS5DaGFuZ0BtZWRp
YXRlay5jb20+OyBLTSBMaW4gKOael+aYhuawkSkgPGttLmxpbkBtZWRpYXRlay5jb20+Ow0KPiBS
b2JpbiBDaGl1ICjpgrHlnIvmv7EpIDxyb2Jpbi5jaGl1QG1lZGlhdGVrLmNvbT47IENIIFllaCAo
6JGJ5b+X6LGqKQ0KPiA8Y2gueWVoQG1lZGlhdGVrLmNvbT47IFBvc2ggU3VuICjlravnkZ7lu7cp
IDxwb3NoLnN1bkBtZWRpYXRlay5jb20+OyBRdWFuDQo+IFpob3UgKOWRqOWFqCkgPFF1YW4uWmhv
dUBtZWRpYXRlay5jb20+OyBSeWRlciBMZWUNCj4gPFJ5ZGVyLkxlZUBtZWRpYXRlay5jb20+OyBT
aGF5bmUgQ2hlbiAo6Zmz6LuS5LieKQ0KPiA8U2hheW5lLkNoZW5AbWVkaWF0ZWsuY29tPjsgbGlu
dXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1tZWRpYXRla0BsaXN0cy5pbmZy
YWRlYWQub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHdpZmk6IG10NzY6IG10NzkyMTogYXZv
aWQgdW5kZXNpcmVkIGNoYW5nZXMgb2YNCj4gdGhlIHByZXNldCByZWd1bGF0b3J5IGRvbWFpbg0K
PiANCj4gDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3Ig
dGhlIGNvbnRlbnQuDQo+IA0KPiANCj4gT24gMTIuMDQuMjQgMTA6NTMsIE1pbmd5ZW4gSHNpZWgg
d3JvdGU6DQo+ID4gRnJvbTogTGVvbiBZZW4gPGxlb24ueWVuQG1lZGlhdGVrLmNvbT4NCj4gPiAN
Cj4gPiBTb21lIGNvdW50cmllcyBoYXZlIHN0cmljdCBSRiByZXN0cmljdGlvbnMgd2hlcmUgY2hh
bmdpbmcgdGhlIA0KPiA+IHJlZ3VsYXRvcnkgZG9tYWluIGR5bmFtaWNhbGx5IGJhc2VkIG9uIHRo
ZSBjb25uZWN0ZWQgQVAgaXMgbm90DQo+ID4gYWNjZXB0YWJsZS4NCj4gPiBUaGlzIHBhdGNoIGRp
c2FibGVzIEJlYWNvbiBjb3VudHJ5IElFIGhpbnRpbmcgd2hlbiBhIHZhbGlkIGNvdW50cnkgDQo+
ID4gY29kZSBpcyBzZXQgZnJvbSB1c2Vyc2xhbmQgKGUuZy4sIGJ5IHN5c3RlbSB1c2luZyBpdyBv
ciBDUkRBKS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBMZW9uIFllbiA8bGVvbi55ZW5AbWVk
aWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1pbmcgWWVuIEhzaWVoIDxtaW5neWVuLmhz
aWVoQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiDCoCBkcml2ZXJzL25ldC93aXJlbGVzcy9t
ZWRpYXRlay9tdDc2L210NzkyMS9pbml0LmMgfCA3ICsrKysrKysNCj4gPiDCoCAxIGZpbGUgY2hh
bmdlZCwgNyBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTIxL2luaXQuYyANCj4gPiBiL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTIxL2luaXQuYw0KPiA+IGluZGV4IGVmMGM3MjFk
MjZlMy4uM2M5YTVmY2Q2OTI0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L21lZGlhdGVrL210NzYvbXQ3OTIxL2luaXQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL21lZGlhdGVrL210NzYvbXQ3OTIxL2luaXQuYw0KPiA+IEBAIC0xMzUsNiArMTM1LDEzIEBA
IG10NzkyMV9yZWdkX25vdGlmaWVyKHN0cnVjdCB3aXBoeSAqd2lwaHksDQo+ID4gwqDCoMKgwqDC
oCBkZXYtPm10NzYucmVnaW9uID0gcmVxdWVzdC0+ZGZzX3JlZ2lvbjsNCj4gPiDCoMKgwqDCoMKg
IGRldi0+Y291bnRyeV9pZV9lbnYgPSByZXF1ZXN0LT5jb3VudHJ5X2llX2VudjsNCj4gPiANCj4g
PiArwqDCoMKgwqAgaWYgKHJlcXVlc3QtPmluaXRpYXRvciA9PSBOTDgwMjExX1JFR0RPTV9TRVRf
QllfVVNFUikgew0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGRldi0+bXQ3Ni5h
bHBoYTJbMF0gPT0gJzAnICYmIGRldi0+bXQ3Ni5hbHBoYTJbMV0NCj4gPiA9PSAnMCcpDQo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgd2lwaHktPnJlZ3VsYXRv
cnlfZmxhZ3MgJj0NCj4gPiB+UkVHVUxBVE9SWV9DT1VOVFJZX0lFX0lHTk9SRTsNCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVsc2UNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB3aXBoeS0+cmVndWxhdG9yeV9mbGFncyB8PQ0KPiA+IFJFR1VMQVRP
UllfQ09VTlRSWV9JRV9JR05PUkU7DQo+ID4gK8KgwqDCoMKgIH0NCj4gPiArDQo+IA0KPiBTb3Jy
eSBmb3IgdGhlIGxhdGUgcmVzcG9uc2UsIEkganVzdCBub3RpY2VkIHRoYXQgSSBjb21wbGV0ZWx5
IGZvcmdvdA0KPiB0byByZXZpZXcgdGhpcyBvbmUuDQo+IA0KPiBJbiBwcmluY2lwbGUsIGl0IG1h
a2VzIHNlbnNlIHRvIG1lIHRvIGlnbm9yZSB0aGUgY291bnRyeSBJRSBpbiB0aGlzDQo+IGNhc2Us
IGhvd2V2ZXIgSSBkb24ndCB1bmRlcnN0YW5kIHdoeSB0aGUgY2hhbmdlIGlzIGRvbmUgaW4gdGhl
IG10NzkyMQ0KPiBkcml2ZXIuIElzbid0IHRoaXMgYSBnZW5lcmljIGlzc3VlIHRoYXQgc2hvdWxk
IGJlIGNvbnNpc3RlbnQgYWNyb3NzDQo+IGRyaXZlcnMgYW5kIHRodXMgYmV0dGVyIGhhbmRsZWQg
aW4gbWFjODAyMTE/DQo+IA0KPiBUaGFua3MsDQo+IA0KPiAtIEZlbGl4DQoNCkhpLA0KDQpUaGFu
ayB5b3UgZm9yIHRoZSByZXZpZXcuDQoNClRoZSBwdXJwb3NlIG9mIHRoaXMgcGF0Y2ggaXMgbm90
IHRvIGZpeCBhIGJ1ZzsNCmluc3RlYWQsIGl0IGNoYW5nZXMgaG93IHRoZSBkcml2ZXIgdHJlYXRz
IHRoZSBiZWFjb24gY291bnRyeSBJRSBoaW50DQphbmQgaGFzIGJvdGggYWR2YW50YWdlcyBhbmQg
ZGlzYWR2YW50YWdlcy4gV2l0aCB0aGlzIHBhdGNoLCB0aGUgYmVhY29uDQpjb3VudHJ5IElFIGhp
bnRpbmcgd2lsbCBiZSBkaXNhYmxlZCBvbiBhIGNvdW50cnkgY29kZSBwcmVzZXQgc3lzdGVtLA0K
d2hpY2ggbWlnaHQgY2F1c2Ugc29tZSBpc3N1ZXMgZHVyaW5nIG92ZXJzZWFzIHRyYXZlbCBpbiBj
ZXJ0YWluDQpzaXR1YXRpb25zLiBpdCdzIGEgdHJhZGUtb2ZmLCBJIGJlbGlldmUgaXQncyBiZXR0
ZXIgdG8gYWxsb3cgdGhlDQpkZXZlbG9wZXJzIG9mIGVhY2ggd2lmaSBkaXJ2ZXIgdG8gZGVjaWRl
IGhvdyB0byBtYW5hZ2UgaXQgYW5kIGtlZXBpbmcNCm1hYzgwMjExIGZsZXhpYmxlLg0KDQp5ZW4u
DQoNCg0K

