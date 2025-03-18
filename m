Return-Path: <linux-wireless+bounces-20490-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5018AA66F09
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 09:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D7463B3F2B
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 08:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A374482EF;
	Tue, 18 Mar 2025 08:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Bz8IbtID";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="MWCK5yas"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720AF1581EE
	for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287897; cv=fail; b=ZZj7RchS/DRdyS0eIHS37JCmpJ5MeJ93rvTu765BbKL90naNXKfIH64e2RVwxpOY7wo0SKjjJa3uaE6KJnnV9aCztaPXb6tp7hZOfb3DpIHm0cIbDIFr4xVNKHe9kt6e8lOqLY6nCEbHrhn+WNHHGnLxdRvevBqMnCVsMjSMKic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287897; c=relaxed/simple;
	bh=eQptk4gsYcTTVh+gI+AWZStc3nTIpMmVqGvO8cHUVDs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qGSvMD48j8rp5/OZYaj+5db5f+jDirJt7J2bhmcWkN0Sbx34caKYWHnvc3/4DrV1DKBX7O2MaHvahAi8aWUfZ11+lf1QpGSLxjNe7PjoG9qVFOqGDUBx57nrRzCZ3hKH3WdnbVr5nRHj7yYSjqM8u3h7pufGqqt4sbsuWaIjTbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Bz8IbtID; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=MWCK5yas; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2ee4224003d611f0aae1fd9735fae912-20250318
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=eQptk4gsYcTTVh+gI+AWZStc3nTIpMmVqGvO8cHUVDs=;
	b=Bz8IbtIDpLuWtAzw08jRSu7nO9detwQbnLsgt+X13+s8zd2z3xVAKwJxxKLWIG6plvysFIjPN0WDx1roq1wOcVdlH/RdDzn4PalTmcBuZyGTV8SkOxxfldEejiiSw3OgfD0VnSIsgw9evhlXjEaBFoXgmN62/Kwh9JuNSXpiN48=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:0b0c908c-75df-468a-a22d-87ae69e1707e,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:59694de1-3561-4519-9a12-e2c881788b70,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2ee4224003d611f0aae1fd9735fae912-20250318
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 850370326; Tue, 18 Mar 2025 16:51:29 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 18 Mar 2025 16:51:28 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 18 Mar 2025 16:51:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNO7EuPsnK/X1apgXFuSYZN+xo3q35HnqRe9fG0OEInJxiJJ1qvz1iKehQvveAQjlgJE+CQWsNIAZrYufS+hQXEaSmDHrv7WC2lot9PrjmWvRkfaYimAXa3cBW9FVmXY+QM8Gn0zOTT9bHrGibIXNdAlUycoCJbxIThn9NvVdCi57yWojEZupKK8THrnEQu//v/LwWISaSKhZ5CHD+0iwyfzWKl/OAgNJC4cBkgWQ5H386tDGqNBnaLmgvE0rhXnm/vYkdZzpXNI6JM0YzL0fphKf9uSyPKfEqo+tj5EUH2w0ugfcLq9ML2EH0WtDK57JzXo8KtX6O6WVLHPJAbgXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQptk4gsYcTTVh+gI+AWZStc3nTIpMmVqGvO8cHUVDs=;
 b=VpapPWXQjmmqMQeW7bUkNo8YvcO1beWX5mxSruDlRjLfN0wiNrc+MMuasU0L/ecpGvr2nzmgN1Jf7FyrRKHz6WDLIhzvdEQxCfoYgp7L9CK1kPkNockiGotKcLy/FIpwan7iOXVPrmKD+ctqlKg6ShLqjLIcijlxsdyJZWlPoO+yGOU3brmXvolVBAbjm2atYMW4wHf5M2hhjaQCC+kvbVgQ7z+JQzhZv+MWzQnv4PH323Ksx9ui7jbJenh+Gi8O1fAAa7+8EcV4GoY8w2zQIah5cwvzen0qfeoh212/sKLU6qC5kWJh76hipe+N9xY7uzGoDK/AnZel7tCeGGwkYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQptk4gsYcTTVh+gI+AWZStc3nTIpMmVqGvO8cHUVDs=;
 b=MWCK5yasvz4v9ywwPosIMsXmHIlvKyIh+Q7ewwbHvoWYxMZdb+3qhdakF5GtvAKOaaY/S7OlQdYfnYYQGIgvM88O+i1MKWVmRPLhpMjpZ6Z4o61RoqAQQMXSwxX3JyOViyxIGS2JAlTiYJR2xnT3FKun3i8gKnCAKOJUmTUY3u0=
Received: from SEZPR03MB6468.apcprd03.prod.outlook.com (2603:1096:101:47::9)
 by SEYPR03MB6579.apcprd03.prod.outlook.com (2603:1096:101:86::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 08:51:25 +0000
Received: from SEZPR03MB6468.apcprd03.prod.outlook.com
 ([fe80::8dd9:7dc2:9bac:818a]) by SEZPR03MB6468.apcprd03.prod.outlook.com
 ([fe80::8dd9:7dc2:9bac:818a%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 08:51:24 +0000
From: =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>
To: Sean Wang <Sean.Wang@mediatek.com>, "nbd@nbd.name" <nbd@nbd.name>,
	"lorenzo@kernel.org" <lorenzo@kernel.org>, Ryder Lee
	<Ryder.Lee@mediatek.com>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, =?utf-8?B?Qm8gSmlhbyAo54Sm5rOiKQ==?=
	<Bo.Jiao@mediatek.com>, =?utf-8?B?Q2h1aS1oYW8gQ2hpdSAo6YKx5Z6C5rWpKQ==?=
	<Chui-hao.Chiu@mediatek.com>
Subject: Re: [PATCH 02/21] wifi: mt76: mt7996: Add
 mt7996_mcu_sta_mld_setup_tlv() and mt7996_mcu_sta_eht_mld_tlv()
Thread-Topic: [PATCH 02/21] wifi: mt76: mt7996: Add
 mt7996_mcu_sta_mld_setup_tlv() and mt7996_mcu_sta_eht_mld_tlv()
Thread-Index: AQHbk0AMhig4cwZ1J0GxE9dDM8/XR7N4n1gA
Date: Tue, 18 Mar 2025 08:51:23 +0000
Message-ID: <9efb42f0948b23cc127dc5c5d9e31791f80219ef.camel@mediatek.com>
References: <20250312-b4-mt7996-mlo-p2-v1-0-015b3d6fd928@kernel.org>
	 <20250312-b4-mt7996-mlo-p2-v1-2-015b3d6fd928@kernel.org>
In-Reply-To: <20250312-b4-mt7996-mlo-p2-v1-2-015b3d6fd928@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6468:EE_|SEYPR03MB6579:EE_
x-ms-office365-filtering-correlation-id: e774cbc8-381c-44df-6bc6-08dd65fa0fed
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?U2w4K0k0a3ZBV0VJOTZSV0ptNGZhNVhONkw1SFVCdjhpampPelQ4QlhEbllO?=
 =?utf-8?B?Q0Jtd2RZY2ZvMitwVmlzelU1S2IzcFZVZ0ZYOVJ1UThTUHRqOW8vbWtRbTFw?=
 =?utf-8?B?NHpJRE4yNGdWZFJuMTVlTERRZjVxaHVEM3g3dEhvazd5Zk1raE9LWEtvY2xi?=
 =?utf-8?B?M1Z5bGVPZGVEMi8xM3l2T1RQWGZVYm1XendaaVNwRXZsRHYrYjgrQ2EzZnly?=
 =?utf-8?B?cmZCUVhQb2xQdWxzOEZaK0NYU2RsRVRmNXNUdzVUdnl6anlUcUNORVNXb0hD?=
 =?utf-8?B?QlhsQmpwZFB6M2tocHdhL256MXJlZnJXZDMxamw1ZjBIL2dRdG8reVZhNUly?=
 =?utf-8?B?RGRDSHkvanRvc1Z0YXJVN0dQZzdteFpHUmNxckdwRktYVlFreXJFV01NV0E5?=
 =?utf-8?B?eFN2cVNQRWNXTEVvZ2RrRFJvTWFKU2YxYjBUWm45OEQ4MXRDZzJiNndZcWhZ?=
 =?utf-8?B?YjNGZlcxV2hyNmVtS1NGKzRobGQwampUeW5EZUl0QXFpLzdEVkxSQnNGVTRl?=
 =?utf-8?B?UzVtanB5UENiaVBXR0QvZEhqV2hGUDRNUjUzZzlDSnpVSEN3eUtyVDVGNE41?=
 =?utf-8?B?eWdkQzJFN1htR1U0UnlzNnRPeXU5TStVT3hPMDJpYkgvNHJQNE9CSWh0Q2xX?=
 =?utf-8?B?WGlXVVRTcGRCWkt0S2o0Sm5uREx1clhpcFViY1QzMWw3aTVPRlRDdkw4QzhF?=
 =?utf-8?B?UE56R0hKYXNmR010b1orM3V6YmtVaWNLZmxNNHZYTitaSlFPRXlIZWtaN2Uv?=
 =?utf-8?B?Zk9SbUJSaEVvQ0RxNFhBaHVqVDViNWlZYm9YMWZMR05iUXcwVTR0WHI3TE1U?=
 =?utf-8?B?aHZ0RllJT0FleFE5ODlMOXQ4V0JvWXA3VlVQVFBLakUxbVArWXJqMUZteUJ2?=
 =?utf-8?B?YkFsRGhsUndKUlNIclNSZG9EeDU2cG5XNTk0a3lndzU3alM1YitNb2l0c0RV?=
 =?utf-8?B?RFM5aGVkVk4vOG5aVmdaNTF5c3IxMURkK2hjd29PRWxMVzZuSEJTZWhMV1E2?=
 =?utf-8?B?WEFtcnozUDhXZlpCMnZxa3lsUmthc3VpNXZiSk51bXpVYllIb0NycVNJQnht?=
 =?utf-8?B?NTFWaWNPYUNjOHZaSE4zOGxPajR2cHB2TWNnSm9SZ01FSUQ0ZkZqWXpzdDhQ?=
 =?utf-8?B?eE1CeDJJdFRoUjBkRmk4UXVjd3UvSWNKcUhiR3ZjVnBtWC91L2hKSVkxaXg4?=
 =?utf-8?B?NkZsdE1VdFZuaEhOSEEweGhjSkRZaGR2RVZTNzNqZ3ErdFRDRzZnSWxGSUhw?=
 =?utf-8?B?WHJEZEh0OTN4bFpkWkxqelQyTVI0WlcreW1YdDRaaDBZcTdhNFNQWkthcVNw?=
 =?utf-8?B?V0ZUcGpZVWVHQWJFckdFTm9UTHc4Y3hzVlRXODVSdU9OZXFyc3B2bUxoV1pH?=
 =?utf-8?B?UU9oK3dreTlhNmNrMjRkaFUwbzVrTlZ6dDZSTkpROUVkbzEwRFpjNnlQQWMw?=
 =?utf-8?B?YWtEcTlzMnRmbnJkL3VkZ0FxT0l3TzZDWXJ2OVFQYzJnSUN5OWlzUjROTFV5?=
 =?utf-8?B?MHVySEZjSDJ5K3pCbVZobUYzbjYwOHFzWERWcHZpR3BrTEMyUjA3TWsrZFZo?=
 =?utf-8?B?TFBBZUoycjZmR0NlajBmaWxwL3BHLzhDdmZXRTlkbG10RUZVT0J0SG9QZmtL?=
 =?utf-8?B?aDBaNkVXWWoyY2NjRzVtOFBQT0oxQ1pWSEJBYXVJc2ZzRGFYcHozRXUvaVpV?=
 =?utf-8?B?b2duem1WYnJpa1JaVkhSdVViemhqem55N0NmUjNubXZha0ZGZHhrMVdMTnlF?=
 =?utf-8?B?Rk9CaU0wakRiVHphZUNnTnMrM0d3RDdzMHQxUW84N0pvL2VnTm84YWtKdXNl?=
 =?utf-8?B?bDVkTjNqOWFBWE5ZaGcrRkNjcFFmVUl5WmVUSlo5eVowdWcwZnRvbDhNL1Mv?=
 =?utf-8?B?RzJINTB4L29hUmllcTFvVDZWUkNnTWFYbU0zZ05WT3pQZk9Yam8vR3kyd0Q1?=
 =?utf-8?Q?qUsyejXinDeKl4V2vkCzL3GoI2jvvQ2p?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFBZR0VjUXVJYUR3ejY2a29ya3dUSTl0OCtrdGo3M1pXVDU5cjRsY3EwVnBU?=
 =?utf-8?B?UjNXVlRteG84elB3RVpBRml4eE41T0JDVS9IdzhNNzluS25oRm9Rd3VleTZx?=
 =?utf-8?B?L1Q1SGtCajFkR3VoN25XdTlvU2tMZE55UVRvMkZhMW5uT0FVeFNWSENHZEVl?=
 =?utf-8?B?ODVMTmozNk4xSWFwUWlmTktURUdwekd3R0MzeFB3RWJ3ZmJoMCtSakJRTEht?=
 =?utf-8?B?KzMycjNsYUIweXRTR0JNVzBTZFQ5SXNPL1ZNU2hSQjFhdGk3Q0hoZXlCU05r?=
 =?utf-8?B?OVF5ZGpod2RQVkMzWE9nTSs4aHU5cmJsVGtiTjFYV1hwUDRkdmMySVRKTnBS?=
 =?utf-8?B?YTFET0ErN0lHTW0rRjZuczg1R3kySkthb25JZ0xCMTJuWUEyNE9EcXMvaUQ1?=
 =?utf-8?B?Ulg0eUVLeE1QU0ROK29IRG5RS1NUa1VHUWtuMkFuOVZydEhpcHo5Ri9YYmlZ?=
 =?utf-8?B?M0hKKzRvR2RYcVVndUpTQ1RuTGgrcE11UGY2THM0TEhCOUY3QWMybmdWYTM5?=
 =?utf-8?B?MTVFNHFuMUw1T2RYbXhqU3hhbXQrNGg4aG15L1VHUC9FQzRRb1NpZEVBRy9P?=
 =?utf-8?B?eWNhQk9iZXRPUEppU1RVaFhUZGRXZ2o2a29EZGh4bmMzaGFEOCtSODVsakJr?=
 =?utf-8?B?RTMzb0FWRHhtSXZ5ckFXVEpMRjV4UkxMZlY2UVJQUy9VMlBseEVid2E2SXhh?=
 =?utf-8?B?U3NYaDdBYTQrdTE0c3FhV25rWlFKa2dmKzJzM0RSL250aVhHQnFXZVZ2SVQ1?=
 =?utf-8?B?YkhQUnV6VldhTG4zWEE0V1FEQ0hsN2ZmaVhFUjNad0U0UjJrMU1RdHhtYjFj?=
 =?utf-8?B?NGttQjBtZWI4T0p5WTdzQXVDWXVaNEdyZS9ZOHJEMlVuWGZoTkkvbVU2dDBP?=
 =?utf-8?B?OU5Oc1dlVm12czVFRFFSZ2s2TnZmVmNvVkdHMGtTZmtlMnFqWG5TLzhpVDZp?=
 =?utf-8?B?VXIvR25TR3lNRENQaFdZRzF5Uzh5SXgvKzA5MzlGWGZWazNYOFQ0M1R0MnF2?=
 =?utf-8?B?dXN2anJnUDIxOVF6dHY5cjcrNCs5SUpML0tVOVN0NVZabVZsYWkwTVlVWlM5?=
 =?utf-8?B?THhOR0hQckZWYmpRSkFjVWw0dHJ1ZTY3RnF2Q0ErY2o1TEJRMnRHdC96YS9h?=
 =?utf-8?B?bzB2UWo0ZEw0eXlwSmJvbUdnMVc3KzBiek02SlMxUkpTVlkzdUtHVnZXQ0g2?=
 =?utf-8?B?dlBFSU5uUVozU3BTdzJuek9BNXdwR1pIcWdyVUl5N05kbmliUHo2TEZ3Mk0x?=
 =?utf-8?B?cnp3UXdER0pJRGZjR2N1Z0JKdnpTdUZzaFVsQTA2ZDBaem9SaXRHOW9jaitV?=
 =?utf-8?B?MFNsRFJ3c3NsYVFTSXpuTzdiNEQ3M2NnUDFudU5UOUJXY2NCa0tqRmw2OWRt?=
 =?utf-8?B?NzRlTzlTczhEUzFsN0RpUnpUR2hKdU5MZDFHbzMzUUIwUDVyNG8vRGRmNnZ5?=
 =?utf-8?B?cUFHZks1WGQzL0Fack83WGdZY0lrYVhEUWZ6R0ZwNEZKSXQ0K2g1YXczLzV2?=
 =?utf-8?B?L3d3Z1EvVEVYSjJuOUo3d2FVdzJpc3lwVGdac243R2wxRGtzVVVlZmFleWM2?=
 =?utf-8?B?cHJST2FDLzhUY0xmR0MxMGh4WlBtaEEyNlZhNU1VQ1p2aHFxeUxNQ3BsemR6?=
 =?utf-8?B?Szdlcy9ZSzJHVDV0YXlJcDdEYWx0S2tob0h2RkwzWmRRRkRhaitLZ2IrNFF2?=
 =?utf-8?B?bm9NTVczSlByZ2lRdG0xTXByVnRwdVdGbW1XNnpoY1RmakR5dmEwQSt0ZGZh?=
 =?utf-8?B?Z0M3dlhDL3B5ellDVEVNQ3BYelp2YXo4MmZteU5Ma3lXWHFUMzFOalB1MWFL?=
 =?utf-8?B?UUNIVDRzUXcvR1pnZFlxV096MXZaSTI5NzFGS1lIY21mOVB6YUdhUnhSUGEr?=
 =?utf-8?B?YzhTajIrNHhGSkgxWVBDWW5PeXhhSlExNVVucDl4SzNUNFJ2Z204MFg3a2Ja?=
 =?utf-8?B?a1VFY1VmZkdremthcXk2WFZFWDJ6VW05OFZLZ2xISFBTMWZmWTliTm9vYVA0?=
 =?utf-8?B?UTQ0czNoUUFtSC9GenZGNDNnb1JpRTJnbXlCRmhBb2JQcVYrUEp3dmJHcTZr?=
 =?utf-8?B?U0hPUjM5Zms5dlBCeitCdHIwdHZSTzBBNzJma2NGZURWZU1PSEt5UkxoRE5Q?=
 =?utf-8?B?WTNOSEJSeHFaQVRJME5zYmd6NTV2Y01tdno4VWhXQU5YMXJMSkx0V3pLRXNX?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F82C1E88619D449A3AF2888CA34F74C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e774cbc8-381c-44df-6bc6-08dd65fa0fed
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 08:51:23.9082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IWZ/RZpWpK6mooEj46+TWSNC75WHgBbQLC7SEHXYcDHkeIMaMOog4vwW59r2sqCh8G099TvxkyHlv+R0XHG6G7VIEqoMXV+RZ0k16/OkADw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6579

T24gV2VkLCAyMDI1LTAzLTEyIGF0IDEyOjEzICswMTAwLCBMb3JlbnpvIEJpYW5jb25pIHdyb3Rl
Ogo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210
Nzk5Ni9tY3UuYwo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYv
bWN1LmMKPiBpbmRleAo+IDBjYzgyMmE4YTY3OTlhNDU1MmZhNTM3Y2FiMmYxM2Q2NTM3YmIxYTgu
LmFjMDFlYjg4MGUyYTZmNmVmM2E4MTU5MWJjYQo+IGNkMmI5MGM0ODk4NmEgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYvbWN1LmMKPiArKysg
Yi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tY3UuYwo+IEBAIC0y
MTk3LDYgKzIxOTcsODAgQEAgbXQ3OTk2X21jdV9hZGRfZ3JvdXAoc3RydWN0IG10Nzk5Nl9kZXYg
KmRldiwKPiBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2l6ZW9mKHJlcSks
IHRydWUpOwo+IMKgfQo+IAo+ICtzdGF0aWMgdm9pZAo+ICttdDc5OTZfbWN1X3N0YV9tbGRfc2V0
dXBfdGx2KHN0cnVjdCBtdDc5OTZfZGV2ICpkZXYsIHN0cnVjdCBza19idWZmCj4gKnNrYiwKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0
cnVjdCBpZWVlODAyMTFfc3RhICpzdGEpCj4gK3sKPiArwqDCoMKgwqDCoMKgIHN0cnVjdCBtdDc5
OTZfc3RhICptc3RhID0gKHN0cnVjdCBtdDc5OTZfc3RhICopc3RhLT5kcnZfcHJpdjsKPiArwqDC
oMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgbGlua3MgPSBzdGEtPnZhbGlkX2xpbmtzOwo+ICvCoMKg
wqDCoMKgwqAgdW5zaWduZWQgaW50IG5saW5rcyA9IGh3ZWlnaHQxNihsaW5rcyk7Cj4gK8KgwqDC
oMKgwqDCoCBzdHJ1Y3QgbWxkX3NldHVwX2xpbmsgKm1sZF9zZXR1cF9saW5rOwo+ICvCoMKgwqDC
oMKgwqAgc3RydWN0IHN0YV9yZWNfbWxkX3NldHVwICptbGRfc2V0dXA7Cj4gK8KgwqDCoMKgwqDC
oCBzdHJ1Y3QgbXQ3OTk2X3N0YV9saW5rICptc3RhX2xpbms7Cj4gK8KgwqDCoMKgwqDCoCBzdHJ1
Y3QgaWVlZTgwMjExX3ZpZiAqdmlmOwo+ICvCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50IGxpbmtf
aWQ7Cj4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3QgdGx2ICp0bHY7Cj4gKwo+ICvCoMKgwqDCoMKgwqAg
bXN0YV9saW5rID0gbXQ3Nl9kZXJlZmVyZW5jZShtc3RhLT5saW5rW21zdGEtPmRlZmxpbmtfaWRd
LAo+ICZkZXYtPm10NzYpOwo+ICvCoMKgwqDCoMKgwqAgaWYgKCFtc3RhX2xpbmspCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+ICsKPiArwqDCoMKgwqDCoMKgIHRsdiA9
IG10NzZfY29ubmFjX21jdV9hZGRfdGx2KHNrYiwgU1RBX1JFQ19NTEQsCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBzaXplb2Yoc3RydWN0Cj4gc3RhX3JlY19tbGRfc2V0dXApICsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHNpemVvZihzdHJ1Y3QgbWxkX3NldHVwX2xpbmspICoKPiBubGlua3MpOwo+ICsKPiArwqDC
oMKgwqDCoMKgIG1sZF9zZXR1cCA9IChzdHJ1Y3Qgc3RhX3JlY19tbGRfc2V0dXAgKil0bHY7Cj4g
K8KgwqDCoMKgwqDCoCBtZW1jcHkobWxkX3NldHVwLT5tbGRfYWRkciwgc3RhLT5hZGRyLCBFVEhf
QUxFTik7Cj4gK8KgwqDCoMKgwqDCoCBtbGRfc2V0dXAtPnNldHVwX3djaWQgPSBjcHVfdG9fbGUx
Nihtc3RhX2xpbmstPndjaWQuaWR4KTsKPiArwqDCoMKgwqDCoMKgIG1sZF9zZXR1cC0+cHJpbWFy
eV9pZCA9IGNwdV90b19sZTE2KG1zdGFfbGluay0+d2NpZC5pZHgpOwo+ICsKPiArwqDCoMKgwqDC
oMKgIGlmIChubGlua3MgPiAxKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbGlu
a19pZCA9IF9fZmZzKGxpbmtzICYgfkJJVChtc3RhLT5kZWZsaW5rX2lkKSk7Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgbXN0YV9saW5rID0gbXQ3Nl9kZXJlZmVyZW5jZShtc3RhLT5s
aW5rW21zdGEtCj4gPmRlZmxpbmtfaWRdLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAmZGV2LT5tdDc2KTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIW1zdGFf
bGluaykKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuOwo+ICvCoMKgwqDCoMKgwqAgfQo+ICvCoMKgwqDCoMKgwqAgbWxkX3NldHVwLT5zZWNvbmVk
X2lkID0gY3B1X3RvX2xlMTYobXN0YV9saW5rLT53Y2lkLmlkeCk7Cj4gK8KgwqDCoMKgwqDCoCBt
bGRfc2V0dXAtPmxpbmtfbnVtID0gbmxpbmtzOwo+ICsKPiArwqDCoMKgwqDCoMKgIHZpZiA9IGNv
bnRhaW5lcl9vZigodm9pZCAqKW1zdGEtPnZpZiwgc3RydWN0IGllZWU4MDIxMV92aWYsCj4gZHJ2
X3ByaXYpOwo+ICvCoMKgwqDCoMKgwqAgbWxkX3NldHVwX2xpbmsgPSAoc3RydWN0IG1sZF9zZXR1
cF9saW5rICopbWxkX3NldHVwLQo+ID5saW5rX2luZm87Cj4gK8KgwqDCoMKgwqDCoCBmb3JfZWFj
aF9zZXRfYml0KGxpbmtfaWQsICZsaW5rcywKPiBJRUVFODAyMTFfTUxEX01BWF9OVU1fTElOS1Mp
IHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgbXQ3OTk2X3ZpZl9saW5r
ICpsaW5rOwo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtc3RhX2xpbmsgPSBt
dDc2X2RlcmVmZXJlbmNlKG1zdGEtPmxpbmtbbGlua19pZF0sCj4gJmRldi0+bXQ3Nik7Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFtc3RhX2xpbmspCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOwo+ICsKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsaW5rID0gbXQ3OTk2X3ZpZl9saW5rKGRldiwgdmlmLCBs
aW5rX2lkKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIWxpbmspCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOwo+ICsK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIW1zdGFfbGluaykKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7Cj4gKwo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1sZF9zZXR1cF9saW5rLT53Y2lkID0gY3B1X3Rv
X2xlMTYobXN0YV9saW5rLQo+ID53Y2lkLmlkeCk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgbWxkX3NldHVwX2xpbmstPmJzc19pZHggPSBsaW5rLT5tdDc2LmlkeDsKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtbGRfc2V0dXBfbGluaysrOwo+ICvCoMKgwqDCoMKgwqAg
fQo+ICt9Cj4gKwo+ICtzdGF0aWMgdm9pZAo+ICttdDc5OTZfbWN1X3N0YV9laHRfbWxkX3Rsdihz
dHJ1Y3QgbXQ3OTk2X2RldiAqZGV2LCBzdHJ1Y3Qgc2tfYnVmZgo+ICpza2IsCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBpZWVlODAy
MTFfc3RhICpzdGEpCj4gK3sKPiArwqDCoMKgwqDCoMKgIHN0cnVjdCBzdGFfcmVjX2VodF9tbGQg
KmVodF9tbGQ7Cj4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3QgdGx2ICp0bHY7Cj4gK8KgwqDCoMKgwqDC
oCBpbnQgaTsKPiArCj4gK8KgwqDCoMKgwqDCoCB0bHYgPSBtdDc2X2Nvbm5hY19tY3VfYWRkX3Rs
dihza2IsIFNUQV9SRUNfRUhUX01MRCwKPiBzaXplb2YoKmVodF9tbGQpKTsKPiArwqDCoMKgwqDC
oMKgIGVodF9tbGQgPSAoc3RydWN0IHN0YV9yZWNfZWh0X21sZCAqKXRsdjsKPiArCj4gK8KgwqDC
oMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShlaHRfbWxkLT5zdHJfY2FwKTsgaSsr
KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVodF9tbGQtPnN0cl9jYXBbaV0gPSAw
eDc7Cj4gK30KPiArCj4gwqBpbnQgbXQ3OTk2X21jdV9hZGRfc3RhKHN0cnVjdCBtdDc5OTZfZGV2
ICpkZXYsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3Ry
dWN0IGllZWU4MDIxMV9ic3NfY29uZiAqbGlua19jb25mLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBpZWVlODAyMTFfbGlua19zdGEgKmxpbmtf
c3RhLAo+IEBAIC0yMjU1LDYgKzIzMjksMTEgQEAgaW50IG10Nzk5Nl9tY3VfYWRkX3N0YShzdHJ1
Y3QgbXQ3OTk2X2RldiAqZGV2LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtdDc5
OTZfbWN1X3N0YV9laHRfdGx2KHNrYiwgbGlua19zdGEpOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAvKiBzdGFyZWMgbXVydSAqLwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBtdDc5OTZfbWN1X3N0YV9tdXJ1X3RsdihkZXYsIHNrYiwgbGlua19jb25mLAo+IGxpbmtf
c3RhKTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHN0YS0+bWxvICYm
IGNvbm5fc3RhdGUgIT0gQ09OTl9TVEFURV9ESVNDT05ORUNUKQoKVGhlIGxhdHRlciBjaGVjayBz
ZWVtcyBhbHJlYWR5IHRvIGJlIGhhbmRsZWQgYnk6CmlmIChjb25uX3N0YXRlID09IENPTk5fU1RB
VEVfRElTQ09OTkVDVCkKICAgIGdvdG8gb3V0OwoKPiB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG10Nzk5Nl9tY3Vfc3RhX21sZF9zZXR1cF90bHYoZGV2
LCBza2IsIHN0YSk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIG10Nzk5Nl9tY3Vfc3RhX2VodF9tbGRfdGx2KGRldiwgc2tiLCBzdGEpOwo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPiDCoMKgwqDCoMKgwqDCoCB9Cj4gCj4gwqDCoMKgwqDC
oMKgwqAgcmV0ID0gbXQ3OTk2X21jdV9hZGRfZ3JvdXAoZGV2LCBsaW5rX2NvbmYtPnZpZiwgc3Rh
KTsKPiAKCg==

