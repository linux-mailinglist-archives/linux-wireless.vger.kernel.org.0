Return-Path: <linux-wireless+bounces-18882-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F196CA33619
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 04:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE913A25AA
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 03:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04751FECB4;
	Thu, 13 Feb 2025 03:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VNj1g6DR";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="K6aQ95jH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54779476;
	Thu, 13 Feb 2025 03:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739417649; cv=fail; b=KZC9jRnQSlQ3IVDPNca024Vyv1+AQuY6/MS4xUr06hJvVZ7JZ1phAGELkKOOtIbIH4yav/secKl73sjIyO8SH/xQdMlsSURd6xwSjoauCPCLbfl7BG+vK1r1UH4n4yE6UqAPrGyhWtTBpV5TgNJ5T7Lg2V4baKrbC6sQSzG315I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739417649; c=relaxed/simple;
	bh=2vl5wyIa58jGDjhXuyEyy6FhQjgtJT+LSGu5J02zB3s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DdsO8yPyBLFzkDhjCzARx2I9HOe+ZAGWGQpaffmb6f2/vvnijPYfKkz+WCyIaMQeMLJ32HaKgNLoI2MXdINUWO8bwDzTqIxrqh6+IsiPz+wLtvHqYNp0/4aC4gPDG3rNxMllA+tYP2SaDjcewvw3eFQAlIgX6NYD9fxKQdfIc4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=VNj1g6DR; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=K6aQ95jH; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5bd25158e9bb11efbd192953cf12861f-20250213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=2vl5wyIa58jGDjhXuyEyy6FhQjgtJT+LSGu5J02zB3s=;
	b=VNj1g6DRrd9yW8ny4k3HHO2I1rv9+FMrwOIldChb3e0kn+qV5zPPI2U+rGq9h7k8ctOmPZI/VStwoWcWoDFTDjOrKg5P2smsC/vw9ZUPduo8j+MPjFOBKbmEP0R226wsLoHuOQVpL5UKcS/ggttzAXxiO83TBz1+aC11rrxLtRY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:0a4890a2-252a-4900-b737-b0d6a1362e86,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:60aa074,CLOUDID:700c64a1-97df-4c26-9c83-d31de0c9db26,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102,TC:nil,Content:0|50,EDM
	:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 5bd25158e9bb11efbd192953cf12861f-20250213
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1998435185; Thu, 13 Feb 2025 11:33:58 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 13 Feb 2025 11:33:56 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 13 Feb 2025 11:33:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9LwaNq18SSrOMHrmkyqjRPbF8yMnrXzHBrrUA+LXOMUD+/8K0JBOAVX0ztY0vwUH4PkwbiPsiaJfdcJkZObhwDf8n+fOv3UnS1D8xspfg/daWePLhF4C17vZQSvynlGZc+HMgETMJXF72/ZxkQWIidQJ992mNl1EpYO6xSpkQ7nSVlfnRxGG7DuEotQeF092EYVqCGVeYedxAatrtH2EVnL9mQsh0O8zfmKxd27elkKUiavzARwSAagAf6sWH6fsDBqSH9koPL9/Fp1s730fehcbGEpYLX14xoNB3ybDfLcxBONca5BdyfNTaLKJ7gEsG/Lcng5Hbzvn+mZNJCmIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vl5wyIa58jGDjhXuyEyy6FhQjgtJT+LSGu5J02zB3s=;
 b=d4eZT2TPJ8T/qgPUHJe4GE3Rh6lc7QqfY2qCo7dYL1Z8+q018/cHQVB3/w0lJiDOvkQmZXc+JKWSjuMatHTnK/rREiZNOHNRVY78gTW+ooznJTnm3Uncs23FSjkyIDERd6Zhsh6RX5h8VitnauIFnecxQ/553F3a5uv+A9ogZRp2FMHf01L2oHAeWO+YDgVAIptA48c3JM9ptF0ddOcyW6w7sH7Rgk8IHtk2IoUeK+9rj8/U/1aut2hB6DqVZi3/ZY1NY7358bD98GCPxLZbktaJml2gdqJby40Ep2/gVEPmGb+7/DtRFHK7SWFxIUQSIScNtVuArC+QOPxWyReqfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vl5wyIa58jGDjhXuyEyy6FhQjgtJT+LSGu5J02zB3s=;
 b=K6aQ95jHvvT6/I/q1OJ+ovndQq/nNW/VwTFt3aSNWXx/cyg98pGKbC09WgVk30YkgASw6sM071e8nLgLkUBw+7mnRTUKClWaxK4qZrv0uS3g4EOwYIepLt25Mt4dZ0syoccVYgKcGg6000lT6z8NZuN7zBYquNxkpXuO5rDElJM=
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com (2603:1096:4:ef::8) by
 TYZPR03MB7667.apcprd03.prod.outlook.com (2603:1096:400:428::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 03:33:55 +0000
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741]) by SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741%3]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 03:33:55 +0000
From: =?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
	<Mingyen.Hsieh@mediatek.com>
To: =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>,
	"cjorden@gmail.com" <cjorden@gmail.com>, "lorenzo@kernel.org"
	<lorenzo@kernel.org>, Ryder Lee <Ryder.Lee@mediatek.com>, "nbd@nbd.name"
	<nbd@nbd.name>, "kvalo@kernel.org" <kvalo@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Sean Wang
	<Sean.Wang@mediatek.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?QWxsYW4gV2FuZyAo546L5a625YGJKQ==?= <Allan.Wang@mediatek.com>,
	=?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>
Subject: Re: [Stable Regression Bisected] Linux 6.13.2 breaks mt7925e
Thread-Topic: [Stable Regression Bisected] Linux 6.13.2 breaks mt7925e
Thread-Index: AQHbfcW5sdvJd6O7UEKgP0NQyp344rNElKoA
Date: Thu, 13 Feb 2025 03:33:55 +0000
Message-ID: <7280c6509a9c27b6d7813413b10683f1f6c6e6ca.camel@mediatek.com>
References: <CABD8wQ=pU9Yc45WE07FGO40MUBf+BSZFGcoO1ff7NxC1cXzx-A@mail.gmail.com>
In-Reply-To: <CABD8wQ=pU9Yc45WE07FGO40MUBf+BSZFGcoO1ff7NxC1cXzx-A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5322:EE_|TYZPR03MB7667:EE_
x-ms-office365-filtering-correlation-id: 04c80a4a-9e95-4f92-07da-08dd4bdf3e4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QTRGNHFlWU90dzZJak1nUlAwdWhiOXEzMHZzSGdaMkwxTWFOaHlnKzZzQ0NK?=
 =?utf-8?B?USs3MXlXazBpYlp0bU1EYW9xUFB4L2h5am5KR3FSM1kzN2NxaHBNZjAvR2Jv?=
 =?utf-8?B?UTIrZFlpQ0NCcWlyMXR4ZUt0K1JWcUlrWUJteTNQWjh4RW9Bam81QVprbVRl?=
 =?utf-8?B?NFZ5UUo5cWF6SnhXUGdVWENzZzJIb0tUNVpJbzdKb1d6MXZpRm5tWjVYR1Rx?=
 =?utf-8?B?SkFvSDE1THgxYU1Qb3hYSWs3Rm12dWxMb2w2U0VVemw2a3JLMXhxOWF6eEVs?=
 =?utf-8?B?TnJsbzNLS0hQalpxVlV3WXhCd2NwQnkrUGVIM1lPTnJETVJldnFEOGR0UzRE?=
 =?utf-8?B?QjQyUEVmYjRJZ0dSSTFLWHZhWUFxYWJJV0t0TjV3cnk4S2JqeXYwSTB6Skkx?=
 =?utf-8?B?RE9mUEpNRFloWmI5M0llQ2pWelVKZHZnNForMS8rYWZ1RkVBUFdPbXpWRC9l?=
 =?utf-8?B?ZjJmcCtRekFtNDl6VEVnS2w2cFJXK1MxTUkra2VSU0hDOEw4N2UzbEI0MEFH?=
 =?utf-8?B?ZGphK05nWVc5cDVmMWFibC94WCt6SnFpTnhJL0xSUy9lYjYxeU1abUNrQS9n?=
 =?utf-8?B?VlVZbkovbkhqV2N0VU9kYjB0OTFXODRDZ0UxbVREdGpTZHI2TlQxNVFBSFRa?=
 =?utf-8?B?NVZrUzJSZjFTcXAvbGl0ZTdQaS9HaWJZUkJYelhHTTZxb2dOWnh6bmg2MW45?=
 =?utf-8?B?RHVHM29XZzBMdXRLWmhMVEFld1VuUlMxdWYxZnBLUGtUb3JiNGpvSUVTN3p1?=
 =?utf-8?B?R1ZhU0xlYksxRlNWYkdMYVJjQTdBSkRiYVhJZGJFVkNKZVlGUzV3bFhhOXFj?=
 =?utf-8?B?WjRMZHlWWGVLZnJxVVluQzd6WHo3L2dSUU1vZnJKSUtYdDdwY1FKZW85VGVR?=
 =?utf-8?B?dG1hUFJuUXMrTklxYUNuNEpJTjlOUlJYZEZ3SVhib09tWENJK0pndE9xZjFQ?=
 =?utf-8?B?TFltQU8vOURRTXBrbVFtczdMMFlOUTd4UDlFTDJYYkdCV29teXl5VlA4bjF5?=
 =?utf-8?B?NE1oZDdodmxzck40WnZPeU94dFY4cjJPV1BSOE9reENwM1d1a2hWOGxBOEdo?=
 =?utf-8?B?aUtyS3NjWUNYbE9XV09MM1JKcGI4NVhKQSszSGJzMEo2a1ZFbTlJSzdqVHZH?=
 =?utf-8?B?RFZPUTQrRXl3VDlQYnVmdW55ZkpCNkNVN1FkbGxmTkowU2Q1VHA0dlRpMzRl?=
 =?utf-8?B?cXIyd1F6M3YzUUlUOHN3amVXQ3NwZEZRWnk5WGJjbWNLZVYwWDBoMGw1K2tz?=
 =?utf-8?B?MHhQOUxXaCtkSVNaU2IxS3B5VytTbjlEYllSTlhvR3YrVEV1dXVFdko4UWlj?=
 =?utf-8?B?Zm00TnYzVEVkdEUzT0ptSDBGMmQ5aTVIbnZmTjdQYnFCcmZvSzBTanhIdmVW?=
 =?utf-8?B?b1R5UE9jTHpTc25WT0NqVkdMem1ZV2FkWVN3YWVod21JOWxPVEdrS1VEejM0?=
 =?utf-8?B?T2l1MFpCajArT2NMZTRVUW1DbVYxVHAvYUMrd2hVZU5TL2JuaXhOeG5ZUk5U?=
 =?utf-8?B?L0hCdkJSM3M2MXRpL1NyUHNoa2JmQ21HYmJSR3AwQUp6REtUVlR5UlZaVzBH?=
 =?utf-8?B?WFNWeThpMG8rWVVwUitnZHFZQzVwVFdYdGNIUTV5bVlvaHcvT3JZNkNzdVVp?=
 =?utf-8?B?RlhVVFdaRHllZHJkbFlmR2JLQk1vSHBCUExMOWx2NGxYOUpNMjNEK0V5YU93?=
 =?utf-8?B?M1pQRldOdzBDdjNoSE9uai9kTzhqL3RJcDJ3Z2UyL0lYRjRoWWNDOXFWc0I3?=
 =?utf-8?B?ZlhDWlVaQ1BIdWNHUnk3bWRGM1NyTUwxWlBZK2hzOG9KRVVVK2k1bmpnem1w?=
 =?utf-8?B?b0JPV29XdGVEenJCSzJsdjliMVpCd1pSMTdQcGVkMVgycCtUMlE5VVFqYkJU?=
 =?utf-8?B?Y0FncUlOS29yY0dkY3ptNSs5T1NlVmplMml1bCtFdzUrSHg0RUVZTXRPeUdC?=
 =?utf-8?Q?HTppCcY9lbVkDqHGaKt1s1O816JozrlI?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5322.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUVySm5pRnY1Z1FZSVlWR1VLTG1JNEFRaDVkUkg3dHBxR3pMWDM2RVlkazcz?=
 =?utf-8?B?N3BHMVo4b2NOd2hIZEdNNEI2TDI0eW9Ib0RwaHZnUzdISGpIOGhNNytjWitp?=
 =?utf-8?B?SWRXM0lpZXo3bXRqZ0JCd3pPUnlrUFpJV2pNbmd3R2swTHZqNlJ3cUlyWHpZ?=
 =?utf-8?B?RXFjcU81cWNIRlg5NUkyK2FyOStEQytVZTRrUndJeWs0UTlCdUtBRWVSOS90?=
 =?utf-8?B?NnBmTnAwT2pDc1BxcWpKc0Z3NWRDbThQeHJ1MytDQXZLS001b3g5YkZaTDV1?=
 =?utf-8?B?TDNnVld6cnZpTGlxSG5zRURKSTUzZXBES0NjNmF6a0gwZ0l0cnVlSWVwMkx6?=
 =?utf-8?B?Mm5hS3FSdnVXbHQ0Tmx1MHJwMkxod3RuYk15eU5LK0tXU0wzWENscmdrK25n?=
 =?utf-8?B?YVZzRi8xT1NwcWdhazlqRENNb0R3T2RNa3pobG5qWjZOV2ZHWVRSejhUcTgy?=
 =?utf-8?B?MFVhcE4zS0JKRzFySHJBcTY0b0tDMENpQWpMOTl1Sllhb1p2L1czU2tOVi9B?=
 =?utf-8?B?V1FJNkgyOWRPcE12NldUbFI5MFJkcFNLWXFRTkFPaDJERDhLcFhhQ2ZKQjht?=
 =?utf-8?B?VUhQRG1WZnErakxNekM3SnAvaks3anJ3OFJRdjhRR1gxWklPQ3JFSkFkVE9D?=
 =?utf-8?B?RHZVMTIyNllTSW91ekJ4ZWx0ZEgzdGFDcWY0QzErdXpHWi9hUjJuZkwzRnU1?=
 =?utf-8?B?NE9uMnE3TnllME9BVC8rSWV5OHhnUndHOThIdytqQXhXTlFabDFKV1lJUmd3?=
 =?utf-8?B?d3Q5UEhMNCtCb0t4SllyL2ZYU0E2a1lUY1ovbWZVby8vOVZ3dC9nMVlmeEdy?=
 =?utf-8?B?eUNMZEZ2YW5UaEV4TzNZUGx0eHRPTmlVMVY5MEs5UnNZaC9VTUNITW9WVzF5?=
 =?utf-8?B?SXFhUHpzSmNQKzA5NVRsK29mc3pSYVJMMkZwaS9wMU1XcU5nd0NaaG9jcnl6?=
 =?utf-8?B?dzRHb1ZTYzdmR045ZEExeWJSTlNZQzV1VnJqYUgycHZRQ3NpM0R6ekV2dk1u?=
 =?utf-8?B?alREVWY2QWRzUkZFdnNiOUM3bXlkZnpUTGFsc25pcE5WWFczS0tQRmZmazUw?=
 =?utf-8?B?Rm9FUHRvTkg0blJoblVNMThibVJscW44dS85ek43L3hhaW9DSHJ6TXhwb29o?=
 =?utf-8?B?Z2NVMHQ0N0JwZHQ4dHZzdFdpOVAxcWQ3ZEhrdWJaRVZkUFQ0bjBJVDU0NG4x?=
 =?utf-8?B?OUFuWmdzSVRyVHNsVmVrcnVFR09xRHZTcjlkVUg3ZisyYit5d1drVERTVldV?=
 =?utf-8?B?UkVVKzZxNjF5eUYrT2ROcDR5aDZhS2pEK1YycEgyQ1k0SnpoZkhSNUpBL3U2?=
 =?utf-8?B?YWtINjVnbFJ6UDJSanp4QU1LRk0vZnZsZThLQjJ4QlNBQzdyMXN6MDJ4ZzBP?=
 =?utf-8?B?QzdtM3pFaFppTHp5QkFFUmxlT28vMkhEY1N3WlM4V1BDUVBoTDBXWVJlNkxh?=
 =?utf-8?B?c3UwMHZBWkVHc1F5d3VySWh3NkVLamwrRlhqRDRQUVVPSnFSaWNHcTFXWGRR?=
 =?utf-8?B?ZTVaQldIeGNIdU5vVXdwYSt4UUlkamd5c3ZWNVhLZjRsRGtlbGNaUUpyWHdX?=
 =?utf-8?B?VDViRWVBL2ZWSFNoMmhIMkd3YUtNcDJZakg4YUZJTXllYVBCSk5wWUZhSXM0?=
 =?utf-8?B?cGloQnEzWHBVem5iT2wybnpYWjRCclJ6SWh5ckMwOU1DYTlGZUhLVEdTVWZS?=
 =?utf-8?B?N2tSdjVrd3ZQWUpQdmxmWCtET0U3TlAvN2tOY2ZmQVBLL3lXbGZ3aGlKWFZH?=
 =?utf-8?B?c1F6Qjd3TDVzQlhpN1o5U3BYOTgrM2ZESFl0dnBqMFFOM1FNa2RkSmF1OXZn?=
 =?utf-8?B?dHBEVXhNRG9abVdhOE82WFJFWlUxQndwOWRlYmRDMVNmZDNyMTZ4OW5KTDUv?=
 =?utf-8?B?VkpEMWJLZmZiT0ZTY2twbGxCMVg1c0htTnNOL2JIR2pTRWpTZVJycGtyZkhJ?=
 =?utf-8?B?S0dVQTFGOW9QMkcwRUZpTDlTbUtPNlFBQlJXR1lENjJIT2xNMnYyMFA0c2gw?=
 =?utf-8?B?TnlKZE5KQW00d0tUVC96U0RKRkQrLzlMU0tvUkhUY3IzbHJhSGJHZmxXeUln?=
 =?utf-8?B?UEhHank3U0ltS2dTMnY0TEVmRkpPQ2ZUK0dTRSsvVDk3L0c0dFVjWXhNeE1X?=
 =?utf-8?B?Qm1NSUdNRUhOUFBKZXhWbGFXVHJiTDFPdFZkUnZQR0dGNkN2dWFQZ0JIUUdu?=
 =?utf-8?B?R2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <59424A367D63FF4799F1F54F3EF8A9FC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5322.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c80a4a-9e95-4f92-07da-08dd4bdf3e4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 03:33:55.1353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MF5qbKYHkct34PNWEF8RybaA7XLVXo3qDCF8zb8m5zYkCLGBi0KXJWZa5RwWttq36Bo2peZACxg0FwO8e3GbYrZX/4JfXVhpkuiLknAJ9Lg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7667

SGkgQ2FsZWIsDQoNCkhlcmUgYXJlIHNvbWUgcGF0Y2hlcyBhcmUgY3VycmVudGx5IG9uZ29pbmcu
DQpDb3VsZCB5b3UgcGxlYXNlIGFwcGx5IHRoZXNlIHBhdGNoZXMgYW5kIHRyeSBhZ2Fpbj8NCg0K
aHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LXdpcmVsZXNzL2xpc3Qv
P3Nlcmllcz05MjUxMDYNCg0KVGhhbmtzfg0KDQpCZXN0IFJlZ2FyZHMsDQpZZW4uDQo=

