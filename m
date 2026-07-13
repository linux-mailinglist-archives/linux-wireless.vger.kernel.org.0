Return-Path: <linux-wireless+bounces-38923-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E/fXJStGVGpnkAMAu9opvQ
	(envelope-from <linux-wireless+bounces-38923-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 03:58:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 676F974684C
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 03:58:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mediatek.com header.s=dk header.b=CDSbEw8H;
	dkim=pass header.d=mediateko365.onmicrosoft.com header.s=selector2-mediateko365-onmicrosoft-com header.b="FTtnCih/";
	dmarc=pass (policy=quarantine) header.from=mediatek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38923-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38923-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 799983008E2C
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 01:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B66528B4FA;
	Mon, 13 Jul 2026 01:57:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B0618CBE1
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 01:57:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783907879; cv=fail; b=NRYZaJzKH+5iAg17ts/h4iChqFqUxkL2vA0L2DLMTMGqesLt29PcGv/FRYAWfo0i3jigHJRoa4Ak1o+YBTJpSjCDtSeeBq6X0bpJYahZO1IFttE4cBztz+xCP/MKAwJ3iN/8QKtPnWva/yCQrdDshUK5IZZcQU4au9gcsnyXUcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783907879; c=relaxed/simple;
	bh=dAgi9m4TQgOnxCTt+eu8lIszohXb5aoGDRCVOsO9skU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W/hK2m6qLwFbe6hmRx761n1tFMZsxkNAfP31SppdeKUQCwhO5FcqXtjMh02wrSeF2EjMsiYm5DiyynelhkqzdHL7k6Nj1NDLm0iZauTEkjmWwbTVHuUDZM9xndnpoxWyIMDYBfT67gIeTTQe9aGYSri4vrF+N5pfpsX/ZQAIx40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=CDSbEw8H; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=FTtnCih/; arc=fail smtp.client-ip=60.244.123.138
X-UUID: 3c06ab607e5e11f1b1788b6acf885367-20260713
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=dAgi9m4TQgOnxCTt+eu8lIszohXb5aoGDRCVOsO9skU=;
	b=CDSbEw8HLx47vchg9RqxpQiNrdjy87yKSCq9F8xqoqajY5OT5qgEHoAt9/zcrzFEpAB7Ep1RlU+eQmLu7190dEriyRuD14cH4U2iIQNN2aEUiZ3sjSzcWqdNiW/SKHmnMhiSaiuMG65KUnjqtB/eTZei3p8yRxVBjLxF1TvxMEY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:294e7031-01c4-4f82-80bd-ec6d53bb349a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:d497b38,CLOUDID:4cce1015-ea64-44d4-98db-4e1fb89955a3,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
	1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3c06ab607e5e11f1b1788b6acf885367-20260713
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <eason.lai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 257711321; Mon, 13 Jul 2026 09:57:42 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 13 Jul 2026 09:57:41 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 13 Jul 2026 09:57:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMZyvRxiz2dI5PP2fTlS/jNfQ7geo9dSvt+Xin9lkzOYsUpw1GiTpxoVd2GNjp/bqcdwZCVJD8j/RdvEt09e1YQaRmVzJ/qv2ORvioVTn9jTDPVCArylRYdQ9EswhnwFTJOqaB2uvuYtsO+jzug5KBTuZzgwTdjVM/JyMmDZmRZ/vFFq/QpenhqbDUFGlLZhhVZQHsDA07NCP1X36ZvMJohDAfu1EgH1WV7Q7kPL4OPzrtj1xIJoaSt030Qz/Se7i+SFBcoNDN8mJ0GArtwCRlaSjsWVtto9jhdujb1U5Flc6ecuu2y1fOj+NCGjUmpeIin9y0IWw5Va0I4t8iK/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAgi9m4TQgOnxCTt+eu8lIszohXb5aoGDRCVOsO9skU=;
 b=shyckTvfK+cm0GBSbvoSXaLbBSQ/w2Sw1YrV91Lv3129fKTyF0f0Kf8p2OBPeS5lM4jaGoxnpK9qwxZRqVbBzpqAKxTlDlKkInWppPQxbwiS4n375id34mSzVafanCG+GM2o7mDAAhqOj0z3DIHko12Uqd0/KLML6tKXSRq9qRi4x1ZH7wLY4kPb5IcHKpAnC/701qNSDR1Lo6GCtCW0LoOOxaR9Br/HIBN/QORcsXwhjucm+vUhmGshweRMP/Bx6zuArlLZ+r/BnT5Fitm0TIE8z8I1AXwbNxPl2R85ThLvoJOpoAVsjn0Ey6+3QL7YpVNqJm8OTYElbB2zf+SYsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAgi9m4TQgOnxCTt+eu8lIszohXb5aoGDRCVOsO9skU=;
 b=FTtnCih/VwlKjg0tyIiz2DCtWf0p33oIgzdr/hkm8hXCLm2hKVzZCnQUz5vvq9yltQBM81M0EKHSl3ri5nHHdfpm4A8R3P73BOjm9On/BtZtRhDLwpUTx8OSe3Ge4NiZcrj12R7nJAvhClxC3oQ8z8Xqxw8jbszHWqC5f1z5WXc=
Received: from KL1PR03MB7079.apcprd03.prod.outlook.com (2603:1096:820:d5::5)
 by SEYPR03MB8531.apcprd03.prod.outlook.com (2603:1096:101:201::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Mon, 13 Jul
 2026 01:57:16 +0000
Received: from KL1PR03MB7079.apcprd03.prod.outlook.com
 ([fe80::9bd3:f66a:efd4:f6af]) by KL1PR03MB7079.apcprd03.prod.outlook.com
 ([fe80::9bd3:f66a:efd4:f6af%4]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 01:57:16 +0000
From: =?utf-8?B?RWFzb24gTGFpICjos7TmmJPogZYp?= <Eason.Lai@mediatek.com>
To: "lorenzo@kernel.org" <lorenzo@kernel.org>
CC: =?utf-8?B?WWYgTHVvICjnvoXlhYPlr4wp?= <Yf.Luo@mediatek.com>, "nbd@nbd.name"
	<nbd@nbd.name>, =?utf-8?B?S3VuIFd1ICjlkLPorLnoh7Mp?= <kun.wu@mediatek.com>,
	=?utf-8?B?UXVhbiBaaG91ICjlkajlhagp?= <Quan.Zhou@mediatek.com>,
	=?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>, Ryder Lee
	<Ryder.Lee@mediatek.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, Sean Wang <Sean.Wang@mediatek.com>,
	=?utf-8?B?TGVvbiBZZW4gKOmhj+iJr+WEkik=?= <Leon.Yen@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?TGl0aWVuIENoYW5nICjlvLXnq4vlhbgp?= <Litien.Chang@mediatek.com>,
	=?utf-8?B?SkIgVHNhaSAo6JSh5b+X5b2sKQ==?= <Jb.Tsai@mediatek.com>
Subject: Re: [PATCH 1/3] wifi: mt76: Separate skb and page_pool_buf pointers
 in mt76_txwi_cache
Thread-Topic: [PATCH 1/3] wifi: mt76: Separate skb and page_pool_buf pointers
 in mt76_txwi_cache
Thread-Index: AQHdD3hwStRpTp/QdUiTaCOYN2sEibZk2F4AgAXeYgA=
Date: Mon, 13 Jul 2026 01:57:15 +0000
Message-ID: <b2c7f6c74536295cea74dbab8ff815d60b4a747e.camel@mediatek.com>
References: <20260709075558.1654164-1-eason.lai@mediatek.com>
	 <20260709075558.1654164-2-eason.lai@mediatek.com>
	 <ak9Zjm-czxVIjrhX@lore-desk>
In-Reply-To: <ak9Zjm-czxVIjrhX@lore-desk>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB7079:EE_|SEYPR03MB8531:EE_
x-ms-office365-filtering-correlation-id: 51794fc3-5585-4c17-914f-08dee0821073
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|6133799003|56012099006|4143699003|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: PCNCb3PA0u9is7FBw5zYiqZdNS6bFnJKe46O4OdMOUNfmnwSN5sVDQKgX7ZJlglb6j+UNpvK/5EiD7l3yEzTkNd4R3w+KTiyO9QWColYDr51kR/mS2cS7RfLu9j2C7Nv2CmVvJM9NFMQalsKZUjwJxfrAxIb1lFnsoyv3D1FDQANNTzOLNdtpP/SQC0yU2mz6BNrFPlOHDdQ3+4JFkWIKXYOk86UD4otL394Ow6HaIuV5nQ+H1DTJ9TgPVfPuUKiy6ToxrVVmxnPfzwI96Xni6JhxPgd5O9SIt/96hRCKp5LpT++WOs/8nIafwbo5jzYu28nE9HsSm8FqE8AGb7EadCVv7oVmPa1QXjvxBf/mjI3JYiiAxH6/sU8H1zoKGa6R3GfwHkkos/y9uW+nZBDA0Nm0fMEZ7cunpCWe+0AgDrJVjQdO1Acxl07A5Yl1nBwkPGNkqox2B3kQgv6U2AYeBz/9VGYXV8d5VLvECaRQY673y/ZfxoATBwsXkHZWEfBn41wrI1I2fawJNHBFuo3LLdwRY+hZSR9zN1pWKDWyrN2TqnYEgA7BdUQXHUgNILXgNH4oI11HmVKimcskxpOmijDwQ5q9piXSdyQYPyO8mrrefVEAUTxefZdr47W5ZYAhKc9abUOM3cHLjag0qvTJNj0+zTUUhWmYJTXsjQGH7W0qCUQGcJOsoCBist2zznDi09kMYEwp16vLFYaJNDbNVX/f0cleGkAz/+L2rGc0T0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7079.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUFmazZMY0RncDRpUUNoQ0RET1lWNkdGR3RScERYdnV5ejFLMWt2MzVzWFBY?=
 =?utf-8?B?SkhYaStta2tLamtsM1Z6MnViOE8vdnRWRzlBQXpJN0tCRDFFbSttV0NzRzJl?=
 =?utf-8?B?OXRFbGx0VnVORG9hTWlPUTJOTk5lQWlwRDAvQzkxd3NYekFtTUhxMjJoTEkv?=
 =?utf-8?B?UWdvSk9GMkIvVVJBY1NWeWlmcHkva2dUZ1o0RmVMZnJPWmVYRkJobmVlZ0Vu?=
 =?utf-8?B?bTlaNGVCMXFkclF0bzk4cC9iK3d4SFpYUk1uQldtb0xUZW8vWmEyUnB5WWJv?=
 =?utf-8?B?cTNQVm9qbUFVZGlsTnNjTWFWVlZkSkh0emVUdDJYajBpcWdmVDFSdnM0d2E2?=
 =?utf-8?B?bVhrM2V1SGU2M1plUi9BM3Z2VllBS28wVnFveEdBK29uNU0zb09pWG9vemxH?=
 =?utf-8?B?aThsWittQ0lYTExoT0JQVHMrUUlTMjZSUVRJSEs4QnJ2UW1KWjVDeTFzd2Q2?=
 =?utf-8?B?RGl5Zi8zK01xaFNya1VidW9YeWxFQ1htKzNIYUNaRWZoRDVjUUloU1lheHJN?=
 =?utf-8?B?WGhyTkhJTHpWRzQ2RjdSYk83VFkrMmpGbk9LNElOeWVsUVVNMkQ2U2NHbWR4?=
 =?utf-8?B?U0ZtdkpsNkcxbkEzMlY0ZEpGUHQwWlNXTHdkdkhqMGNVT0xtdG42R2tEcVFZ?=
 =?utf-8?B?L1BjVDNnQXBTNng5QjNXNmNaVkprZDk5bGdWQmRjQnBmWDZnVkpwSGYyZXpK?=
 =?utf-8?B?MzJkOFJ1Y2pJZXVhM0xzTDJXdnBMZis1Y3lNSU1OM1BKeVNqK3lzS24vTm1a?=
 =?utf-8?B?b1RoV1JIa2hwVjliSFRSZFZVL2hBR0wyRXliYUkrT0RWN3l2ZFV4RitIVWJj?=
 =?utf-8?B?MWVTVXI3QnZ4TDRkb1o0ZVpXT0NaWlNDRDVsK0pHeFdFVVgxbWhHVjVYTDNl?=
 =?utf-8?B?RDVlcE9jb3JTeEJ4WEQwTDFCL1lYeFFLZWhmdVAvdVB3blhRd0ZxYXhUSjVR?=
 =?utf-8?B?U3lhTzlYaVAyV252VTlWSVd2SXgvU1dIaUZOQTlTa2VJdkIxNDFuTGkvWnhi?=
 =?utf-8?B?Y29NYkVSczhmQVRSeTFPME5uM25OU01memx1NmI0a1JYTk9tTnZTdW1WY0xj?=
 =?utf-8?B?T2pYMG1lSFhDNG1Pb3hnVVRKOS9CR3UzVDZHWEl0bVgydmhOcDNQK2xxUVN4?=
 =?utf-8?B?alBkbjZFbmY4ajZ3ejRRMUsrOTFnUG56WkRPRnlvam5URkJhUGV2Z0JJSXFJ?=
 =?utf-8?B?enFqRzBDajNyZFB0a1gwZWdKSWdqMDc3TC9mWEFUb1B5eWFkWUw1anZ1T0ov?=
 =?utf-8?B?NXoweHg2dGg0M1BZaFhTaHJvcUNSNFRtREhmL0Z0VFZ5WHo2WGpYTmtEVHYw?=
 =?utf-8?B?R3pKS2sxUFFJaXdzcTVFQWNLNktKRWVPa3ZWY2RxYiszbUtuYXVIcG15M1pu?=
 =?utf-8?B?RmVrdGxNME43YXNwWmViaFRWNnNGdTVvcjlObnMxalRPSEtBblJpM1lJKzRM?=
 =?utf-8?B?ZFBWQjVpYW80Y0hNNGhneklpbGFsZFVsYnpXZ3oweElzSUl0R3d4YjRSYzdV?=
 =?utf-8?B?bGFQRDdGbGVnN2tHZnVkMlV3L0JGcmxQd0M4MGc2TTRLbmhKSC9PcmdGc1Rk?=
 =?utf-8?B?WEY2OGlBd2NCWkJnOXY0L2pDTys3bWlhWkRla1Vqd2NLRkJ0VlhuRzBLeVRs?=
 =?utf-8?B?eUF6NFFHYU04dUFodkRBcFcweXhMOEg2RzZFcGlGbWxkRzFLV2kyOFJkWmZS?=
 =?utf-8?B?eFNITnpWSytXQ2xVWGFsWm9mL1ZXbnc1TkZnWmFDSHFCVi9rNW4xMlhpMVY5?=
 =?utf-8?B?bytlZFQ2S0tIYzIvWVcvRWJMZitrV2JJWityVE1URkFkYUcxT3hCL2paQzFj?=
 =?utf-8?B?bHNITUdwTjlmT0dpZlBpL0lyMm1xNTlHZ25WNVJCckk0NnRvaHJGR2FyWXpV?=
 =?utf-8?B?blE3WFF1ZXZFREhhdVVOaW1nN2RiUzA1dXZEL3doQm9vM2pjLzVUdElhVXI0?=
 =?utf-8?B?VVBXdkUxOUUrSHVGdm9uUzR0eDQybGFBQ1RNSTRTL1hwQ0lvZ2RLQWcvbWEz?=
 =?utf-8?B?eG5zREJISisrTnFhcHN3Ri9lWlRXZGNML1Z2WE1RTnpBZFc0VWRiZDdJSjlz?=
 =?utf-8?B?Y1BYcWFkd3BlbmQ3enRkejRBbWQ5NlpMbW1RVnRWcVVBZXo2ME8rUk9zTnNr?=
 =?utf-8?B?TFNKSDF0b2xGYy80V3RobU4vZXc2OENxbDV2bnZ5TDJXWWEwbEV1SXJIQXh2?=
 =?utf-8?B?R1g3RURPTmhMcThWcnpoZ2J1bTdSUUFnd2RLMFE5K0J3UVpUNDNMZEIzR0hY?=
 =?utf-8?B?NGFabE43bnp0c3JCVnQ1Z2lhYmlrTHJOOHQyeUc3REcxdGphaVJNSTZ4TUkv?=
 =?utf-8?B?UnNjN3ovZi9uM2h3eEw1SmRPR0hqcEZRTyt0Nmh0YUdkVjJpdWk0R3NFM0Vj?=
 =?utf-8?Q?Yfh2pIsNcKnZR4HY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1EFA12230C09B4BB70C16CB56B12076@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Jfn97FLbSG65pGH6bygSfRMfnMOt0ES3xM0BKkl1ZmfUC8XQa4KXW1yqzAqeWtzUNbcWjvNEs3gmaXvH6pO0DEZbMxdWcHa10ROabYU5gwQfGI9ef6fFnZQA7CjOFORuPuCfAsFWcoV5wd5toLnAEG8Xw9QgR/pjkgfWpBkquHMUYbyikph5h2VxLl1cFdNTmXn5hvob81W/gC08kjAYwSQZlDXbTYM0O0+O5ZskjRczbVMdGSaBSl9ftZmGjYXkL2n1TIrl7AMruFhzZogpCGM7pM9RcoYuIVp9BGDZv/CoKZUbttro89LfLdpNiZ+D57YooSK9HLI/nJBG36u0hA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7079.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51794fc3-5585-4c17-914f-08dee0821073
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 01:57:15.9533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8UgK1uk1sS3j6mqKk/dm+VfYtdji0Nkrc2MQVBP3leaZwzs6PqBItQMA4OZla+hsok4qOu+xHUuk+7xdyChz/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8531
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk,mediateko365.onmicrosoft.com:s=selector2-mediateko365-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38923-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:Yf.Luo@mediatek.com,m:nbd@nbd.name,m:kun.wu@mediatek.com,m:Quan.Zhou@mediatek.com,m:Deren.Wu@mediatek.com,m:Ryder.Lee@mediatek.com,m:linux-wireless@vger.kernel.org,m:Sean.Wang@mediatek.com,m:Leon.Yen@mediatek.com,m:linux-mediatek@lists.infradead.org,m:Litien.Chang@mediatek.com,m:Jb.Tsai@mediatek.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[Eason.Lai@mediatek.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[mediatek.com:+,mediateko365.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Eason.Lai@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 676F974684C

T24gVGh1LCAyMDI2LTA3LTA5IGF0IDEwOjE5ICswMjAwLCBMb3JlbnpvIEJpYW5jb25pIHdyb3Rl
Og0KPiA+IEZyb206IEVhc29uIExhaSA8RWFzb24uTGFpQG1lZGlhdGVrLmNvbT4NCj4gPiANCj4g
PiBSZWZhY3RvciBtdDc2X3R4d2lfY2FjaGUgc3RydWN0dXJlIHRvIHVzZSBzZXBhcmF0ZSBza2Ig
YW5kDQo+ID4gcGFnZV9wb29sX2J1Zg0KPiA+IGZpZWxkcyBpbnN0ZWFkIG9mIGEgdW5pb24gd2l0
aCBwdHIuIFRoaXMgaW1wcm92ZXMgdHlwZSBzYWZldHkgYW5kDQo+ID4gbWFrZXMNCj4gPiB0aGUg
Y29kZSBtb3JlIGV4cGxpY2l0IGFib3V0IHdoaWNoIHBvaW50ZXIgdHlwZSBpcyBiZWluZyB1c2Vk
IGluDQo+ID4gZGlmZmVyZW50IGNvbnRleHRzLg0KPiA+IA0KPiA+IEFsc28gYWRkIHNraXBfdW5t
YXAgZmxhZyB0byB0eF9pbmZvLmJ1ZiB0byBoYW5kbGUgY2FzZXMgd2hlcmUgRE1BDQo+ID4gdW5t
YXBwaW5nIHNob3VsZCBiZSBza2lwcGVkLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEVhc29u
IExhaSA8RWFzb24uTGFpQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiDCoGRyaXZlcnMvbmV0
L3dpcmVsZXNzL21lZGlhdGVrL210NzYvZG1hLmPCoMKgwqDCoMKgIHwgMjkgKysrKysrKysrKysr
LS0tDQo+ID4gLS0tLQ0KPiA+IMKgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9t
dDc2LmjCoMKgwqDCoCB8wqAgNCArLS0NCj4gPiDCoC4uLi9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsv
bXQ3Ni9tdDc5OTYvbWFjLmPCoMKgIHwgMTAgKysrLS0tLQ0KPiA+IMKgZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWVkaWF0ZWsvbXQ3Ni90eC5jwqDCoMKgwqDCoMKgIHzCoCAyICstDQo+ID4gwqBkcml2
ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L3dlZC5jwqDCoMKgwqDCoCB8wqAgNiArKy0t
DQo+ID4gwqA1IGZpbGVzIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDIzIGRlbGV0aW9ucygt
KQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9t
dDc2L2RtYS5jDQo+ID4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L2RtYS5j
DQo+ID4gaW5kZXggZjhjMmZlNWYyZjU4Li4yNzE2Mjc4Nzg4YmQgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9kbWEuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvZG1hLmMNCj4gPiBAQCAtNDMsNyArNDMsOCBA
QCBtdDc2X2FsbG9jX3J4d2koc3RydWN0IG10NzZfZGV2ICpkZXYpDQo+ID4gwqAJaWYgKCF0KQ0K
PiA+IMKgCQlyZXR1cm4gTlVMTDsNCj4gPiDCoA0KPiA+IC0JdC0+cHRyID0gTlVMTDsNCj4gPiAr
CXQtPnNrYiA9IE5VTEw7DQo+ID4gKwl0LT5wYWdlX3Bvb2xfYnVmID0gTlVMTDsNCj4gPiDCoAly
ZXR1cm4gdDsNCj4gPiDCoH0NCj4gPiDCoA0KPiA+IEBAIC04NCw4ICs4NSwxMSBAQCBtdDc2X2dl
dF90eHdpKHN0cnVjdCBtdDc2X2RldiAqZGV2KQ0KPiA+IMKgew0KPiA+IMKgCXN0cnVjdCBtdDc2
X3R4d2lfY2FjaGUgKnQgPSBfX210NzZfZ2V0X3R4d2koZGV2KTsNCj4gPiDCoA0KPiA+IC0JaWYg
KHQpDQo+ID4gKwlpZiAodCkgew0KPiA+ICsJCXQtPnNrYiA9IE5VTEw7DQo+ID4gKwkJdC0+cGFn
ZV9wb29sX2J1ZiA9IE5VTEw7DQo+ID4gwqAJCXJldHVybiB0Ow0KPiA+ICsJfQ0KPiA+IMKgDQo+
ID4gwqAJcmV0dXJuIG10NzZfYWxsb2NfdHh3aShkZXYpOw0KPiA+IMKgfQ0KPiA+IEBAIC0xNDcs
OCArMTUxLDggQEAgbXQ3Nl9mcmVlX3BlbmRpbmdfcnh3aShzdHJ1Y3QgbXQ3Nl9kZXYgKmRldikN
Cj4gPiDCoA0KPiA+IMKgCWxvY2FsX2JoX2Rpc2FibGUoKTsNCj4gPiDCoAl3aGlsZSAoKHQgPSBf
X210NzZfZ2V0X3J4d2koZGV2KSkgIT0gTlVMTCkgew0KPiA+IC0JCWlmICh0LT5wdHIpDQo+ID4g
LQkJCW10NzZfcHV0X3BhZ2VfcG9vbF9idWYodC0+cHRyLCBmYWxzZSk7DQo+ID4gKwkJaWYgKHQt
PnBhZ2VfcG9vbF9idWYpDQo+ID4gKwkJCW10NzZfcHV0X3BhZ2VfcG9vbF9idWYodC0+cGFnZV9w
b29sX2J1ZiwNCj4gPiBmYWxzZSk7DQo+ID4gwqAJCWtmcmVlKHQpOw0KPiA+IMKgCX0NCj4gPiDC
oAlsb2NhbF9iaF9lbmFibGUoKTsNCj4gPiBAQCAtNDc1LDE0ICs0NzksMTQgQEAgbXQ3Nl9kbWFf
Z2V0X3J4ZG1hZF9jX2J1ZihzdHJ1Y3QgbXQ3Nl9kZXYNCj4gPiAqZGV2LCBzdHJ1Y3QgbXQ3Nl9x
dWV1ZSAqcSwNCj4gPiDCoAlpZiAobW9yZSkNCj4gPiDCoAkJKm1vcmUgPSAhRklFTERfR0VUKFJS
T19SWERNQURfREFUQTFfTFNfTUFTSywNCj4gPiBkYXRhMSk7DQo+ID4gwqANCj4gPiAtCWJ1ZiA9
IHQtPnB0cjsNCj4gPiArCWJ1ZiA9IHQtPnBhZ2VfcG9vbF9idWY7DQo+ID4gwqAJaW5kX3JlYXNv
biA9IEZJRUxEX0dFVChSUk9fUlhETUFEX0RBVEEyX0lORF9SRUFTT05fTUFTSywNCj4gPiBkYXRh
Mik7DQo+ID4gwqAJaWYgKGluZF9yZWFzb24gPT0gTVRfRE1BX1dFRF9JTkRfUkVBU09OX1JFUEVB
VCB8fA0KPiA+IMKgCcKgwqDCoCBpbmRfcmVhc29uID09IE1UX0RNQV9XRURfSU5EX1JFQVNPTl9P
TERQS1QpIHsNCj4gPiDCoAkJbXQ3Nl9wdXRfcGFnZV9wb29sX2J1ZihidWYsIGZhbHNlKTsNCj4g
PiDCoAkJYnVmID0gRVJSX1BUUigtRUFHQUlOKTsNCj4gPiDCoAl9DQo+ID4gLQl0LT5wdHIgPSBO
VUxMOw0KPiA+ICsJdC0+cGFnZV9wb29sX2J1ZiA9IE5VTEw7DQo+ID4gwqAJdC0+ZG1hX2FkZHIg
PSAwOw0KPiA+IMKgDQo+ID4gwqAJbXQ3Nl9wdXRfcnh3aShkZXYsIHQpOw0KPiA+IEBAIC01Mjks
OSArNTMzLDkgQEAgbXQ3Nl9kbWFfZ2V0X2J1ZihzdHJ1Y3QgbXQ3Nl9kZXYgKmRldiwgc3RydWN0
DQo+ID4gbXQ3Nl9xdWV1ZSAqcSwgaW50IGlkeCwNCj4gPiDCoAkJCQlTS0JfV0lUSF9PVkVSSEVB
RChxLT5idWZfc2l6ZSksDQo+ID4gwqAJCQkJcGFnZV9wb29sX2dldF9kbWFfZGlyKHEtDQo+ID4g
PnBhZ2VfcG9vbCkpOw0KPiA+IMKgDQo+ID4gLQkJYnVmID0gdC0+cHRyOw0KPiA+ICsJCWJ1ZiA9
IHQtPnBhZ2VfcG9vbF9idWY7DQo+ID4gwqAJCXQtPmRtYV9hZGRyID0gMDsNCj4gPiAtCQl0LT5w
dHIgPSBOVUxMOw0KPiA+ICsJCXQtPnBhZ2VfcG9vbF9idWYgPSBOVUxMOw0KPiA+IMKgDQo+ID4g
wqAJCW10NzZfcHV0X3J4d2koZGV2LCB0KTsNCj4gPiDCoAkJaWYgKGRyb3ApDQo+ID4gQEAgLTY5
NCw2ICs2OTgsNyBAQCBtdDc2X2RtYV90eF9xdWV1ZV9za2Ioc3RydWN0IG10NzZfcGh5ICpwaHks
DQo+ID4gc3RydWN0IG10NzZfcXVldWUgKnEsDQo+ID4gwqAJCQlnb3RvIHVubWFwOw0KPiA+IMKg
DQo+ID4gwqAJCXR4X2luZm8uYnVmW25dLmFkZHIgPSBhZGRyOw0KPiA+ICsJCXR4X2luZm8uYnVm
W25dLnNraXBfdW5tYXAgPSBmYWxzZTsNCj4gPiDCoAkJdHhfaW5mby5idWZbbisrXS5sZW4gPSBp
dGVyLT5sZW47DQo+ID4gwqAJfQ0KPiA+IMKgCXR4X2luZm8ubmJ1ZiA9IG47DQo+ID4gQEAgLTcx
OCw5ICs3MjMsMTEgQEAgbXQ3Nl9kbWFfdHhfcXVldWVfc2tiKHN0cnVjdCBtdDc2X3BoeSAqcGh5
LA0KPiA+IHN0cnVjdCBtdDc2X3F1ZXVlICpxLA0KPiA+IMKgCQkJCXR4X2luZm8uaW5mbywgdHhf
aW5mby5za2IsIHQpOw0KPiA+IMKgDQo+ID4gwqB1bm1hcDoNCj4gPiAtCWZvciAobi0tOyBuID4g
MDsgbi0tKQ0KPiA+IC0JCWRtYV91bm1hcF9zaW5nbGUoZGV2LT5kbWFfZGV2LA0KPiA+IHR4X2lu
Zm8uYnVmW25dLmFkZHIsDQo+ID4gLQkJCQkgdHhfaW5mby5idWZbbl0ubGVuLA0KPiA+IERNQV9U
T19ERVZJQ0UpOw0KPiA+ICsJZm9yIChuLS07IG4gPiAwOyBuLS0pIHsNCj4gPiArCQlpZiAoIXR4
X2luZm8uYnVmW25dLnNraXBfdW5tYXApDQo+ID4gKwkJCWRtYV91bm1hcF9zaW5nbGUoZGV2LT5k
bWFfZGV2LA0KPiA+IHR4X2luZm8uYnVmW25dLmFkZHIsDQo+ID4gKwkJCQkJIHR4X2luZm8uYnVm
W25dLmxlbiwNCj4gPiBETUFfVE9fREVWSUNFKTsNCj4gPiArCX0NCj4gPiDCoA0KPiA+IMKgZnJl
ZToNCj4gPiDCoCNpZmRlZiBDT05GSUdfTkw4MDIxMV9URVNUTU9ERQ0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYuaA0KPiA+IGIvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2LmgNCj4gPiBpbmRleCA1MjdiZWY5N2Ux
MjIuLjkyN2MyMTUzNmY0ZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9t
ZWRpYXRlay9tdDc2L210NzYuaA0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlh
dGVrL210NzYvbXQ3Ni5oDQo+ID4gQEAgLTQ0NSwxMCArNDQ1LDggQEAgc3RydWN0IG10NzZfdHh3
aV9jYWNoZSB7DQo+ID4gwqAJc3RydWN0IGxpc3RfaGVhZCBsaXN0Ow0KPiA+IMKgCWRtYV9hZGRy
X3QgZG1hX2FkZHI7DQo+ID4gwqANCj4gPiAtCXVuaW9uIHsNCj4gPiDCoAkJc3RydWN0IHNrX2J1
ZmYgKnNrYjsNCj4gPiAtCQl2b2lkICpwdHI7DQo+ID4gLQl9Ow0KPiA+ICsJdm9pZCAqcGFnZV9w
b29sX2J1ZjsNCj4gDQo+IGlmIHlvdSBkbyBub3QgcmVuYW1lIHRoZSBwb2ludGVyIGhlcmUsIHRo
ZSBwYXRjaCB3b3VsZCBiZSBtdWNoIGxlc3MNCj4gaW50cnVzaXZlLg0KPiANCj4gUmVnYXJkcywN
Cj4gTG9yZW56bw0KPiANCg0KT0ssIEkgd2lsbCByZXZlcnQgdGhlIG9yaWdpbmFsIG5hbWluZyBp
biBWMi4NCg0KPiA+IMKgDQo+ID4gwqAJdTggcWlkOw0KPiA+IMKgCXU4IHBoeV9pZHg7DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTk2L21h
Yy5jDQo+ID4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tYWMu
Yw0KPiA+IGluZGV4IGUyYTgzZGEzYTA5Yy4uOTI0YjBkYzBmZjFlIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTk2L21hYy5jDQo+ID4gKysr
IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYvbWFjLmMNCj4gPiBA
QCAtMTc3NSwxMiArMTc3NSwxMiBAQCBzdGF0aWMgdm9pZCBtdDc5OTZfcnhfdG9rZW5fcHV0KHN0
cnVjdA0KPiA+IG10Nzk5Nl9kZXYgKmRldikNCj4gPiDCoAkJc3RydWN0IG10NzZfdHh3aV9jYWNo
ZSAqdDsNCj4gPiDCoA0KPiA+IMKgCQl0ID0gbXQ3Nl9yeF90b2tlbl9yZWxlYXNlKCZkZXYtPm10
NzYsIGkpOw0KPiA+IC0JCWlmICghdCB8fCAhdC0+cHRyKQ0KPiA+ICsJCWlmICghdCB8fCAhdC0+
cGFnZV9wb29sX2J1ZikNCj4gPiDCoAkJCWNvbnRpbnVlOw0KPiA+IMKgDQo+ID4gLQkJbXQ3Nl9w
dXRfcGFnZV9wb29sX2J1Zih0LT5wdHIsIGZhbHNlKTsNCj4gPiArCQltdDc2X3B1dF9wYWdlX3Bv
b2xfYnVmKHQtPnBhZ2VfcG9vbF9idWYsIGZhbHNlKTsNCj4gPiDCoAkJdC0+ZG1hX2FkZHIgPSAw
Ow0KPiA+IC0JCXQtPnB0ciA9IE5VTEw7DQo+ID4gKwkJdC0+cGFnZV9wb29sX2J1ZiA9IE5VTEw7
DQo+ID4gwqANCj4gPiDCoAkJbXQ3Nl9wdXRfcnh3aSgmZGV2LT5tdDc2LCB0KTsNCj4gPiDCoAl9
DQo+ID4gQEAgLTE5MjgsMTQgKzE5MjgsMTQgQEAgdm9pZCBtdDc5OTZfcnJvX3J4X3Byb2Nlc3Mo
c3RydWN0IG10NzZfZGV2DQo+ID4gKm1kZXYsIHZvaWQgKmRhdGEpDQo+ID4gwqAJCQkJZ290byBu
ZXh0X3BhZ2U7DQo+ID4gwqANCj4gPiDCoAkJCXFpZCA9IHQtPnFpZDsNCj4gPiAtCQkJYnVmID0g
dC0+cHRyOw0KPiA+ICsJCQlidWYgPSB0LT5wYWdlX3Bvb2xfYnVmOw0KPiA+IMKgCQkJcSA9ICZt
ZGV2LT5xX3J4W3FpZF07DQo+ID4gwqAJCQlkbWFfc3luY19zaW5nbGVfZm9yX2NwdShtZGV2LT5k
bWFfZGV2LCB0LQ0KPiA+ID5kbWFfYWRkciwNCj4gPiDCoAkJCQkJCVNLQl9XSVRIX09WRVJIRUFE
KA0KPiA+IHEtPmJ1Zl9zaXplKSwNCj4gPiDCoAkJCQkJCXBhZ2VfcG9vbF9nZXRfZG1hXw0KPiA+
IGRpcihxLT5wYWdlX3Bvb2wpKTsNCj4gPiDCoA0KPiA+IMKgCQkJdC0+ZG1hX2FkZHIgPSAwOw0K
PiA+IC0JCQl0LT5wdHIgPSBOVUxMOw0KPiA+ICsJCQl0LT5wYWdlX3Bvb2xfYnVmID0gTlVMTDsN
Cj4gPiDCoAkJCW10NzZfcHV0X3J4d2kobWRldiwgdCk7DQo+ID4gwqAJCQlpZiAoIWJ1ZikNCj4g
PiDCoAkJCQlnb3RvIG5leHRfcGFnZTsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWVkaWF0ZWsvbXQ3Ni90eC5jDQo+ID4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L3R4LmMNCj4gPiBpbmRleCAyMmY5NjkwNjM0YzkuLjY2NTE1NmE3ZWE2NSAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L3R4LmMNCj4g
PiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L3R4LmMNCj4gPiBAQCAt
ODk5LDcgKzg5OSw3IEBAIGludCBtdDc2X3J4X3Rva2VuX2NvbnN1bWUoc3RydWN0IG10NzZfZGV2
ICpkZXYsDQo+ID4gdm9pZCAqcHRyLA0KPiA+IMKgCXRva2VuID0gaWRyX2FsbG9jKCZkZXYtPnJ4
X3Rva2VuLCB0LCAwLCBkZXYtDQo+ID4gPnJ4X3Rva2VuX3NpemUsDQo+ID4gwqAJCQnCoCBHRlBf
QVRPTUlDKTsNCj4gPiDCoAlpZiAodG9rZW4gPj0gMCkgew0KPiA+IC0JCXQtPnB0ciA9IHB0cjsN
Cj4gPiArCQl0LT5wYWdlX3Bvb2xfYnVmID0gcHRyOw0KPiA+IMKgCQl0LT5kbWFfYWRkciA9IHBo
eXM7DQo+ID4gwqAJfQ0KPiA+IMKgCXNwaW5fdW5sb2NrX2JoKCZkZXYtPnJ4X3Rva2VuX2xvY2sp
Ow0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L3dl
ZC5jDQo+ID4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L3dlZC5jDQo+ID4g
aW5kZXggZWQ2NTdkOTUyZGUyLi5lMWNmODFkNzIyYjggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni93ZWQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL21lZGlhdGVrL210NzYvd2VkLmMNCj4gPiBAQCAtMTUsMTEgKzE1LDExIEBAIHZv
aWQgbXQ3Nl93ZWRfcmVsZWFzZV9yeF9idWYoc3RydWN0DQo+ID4gbXRrX3dlZF9kZXZpY2UgKndl
ZCkNCj4gPiDCoAkJc3RydWN0IG10NzZfdHh3aV9jYWNoZSAqdDsNCj4gPiDCoA0KPiA+IMKgCQl0
ID0gbXQ3Nl9yeF90b2tlbl9yZWxlYXNlKGRldiwgaSk7DQo+ID4gLQkJaWYgKCF0IHx8ICF0LT5w
dHIpDQo+ID4gKwkJaWYgKCF0IHx8ICF0LT5wYWdlX3Bvb2xfYnVmKQ0KPiA+IMKgCQkJY29udGlu
dWU7DQo+ID4gwqANCj4gPiAtCQltdDc2X3B1dF9wYWdlX3Bvb2xfYnVmKHQtPnB0ciwgZmFsc2Up
Ow0KPiA+IC0JCXQtPnB0ciA9IE5VTEw7DQo+ID4gKwkJbXQ3Nl9wdXRfcGFnZV9wb29sX2J1Zih0
LT5wYWdlX3Bvb2xfYnVmLCBmYWxzZSk7DQo+ID4gKwkJdC0+cGFnZV9wb29sX2J1ZiA9IE5VTEw7
DQo+ID4gwqANCj4gPiDCoAkJbXQ3Nl9wdXRfcnh3aShkZXYsIHQpOw0KPiA+IMKgCX0NCj4gPiAt
LSANCj4gPiAyLjQ1LjINCj4gPiANCg0K

