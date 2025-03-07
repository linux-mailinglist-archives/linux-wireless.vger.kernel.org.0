Return-Path: <linux-wireless+bounces-19984-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E4EA5620B
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 08:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE0B41895CD4
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 07:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D53D1957E2;
	Fri,  7 Mar 2025 07:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FtG43PmD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011029.outbound.protection.outlook.com [52.103.43.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218151632C8
	for <linux-wireless@vger.kernel.org>; Fri,  7 Mar 2025 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741333965; cv=fail; b=NEQtbI2g9kvPN/xpIWCv+dSOb2cGNrwU2vzLenIZ0qq70xpCLQ6Yx8zjtW0oyoNhWfIrv6WCKaxUqjl1eBGyvpjCox4Xu0xlN9GXycRHGj4QK1VFriEREf2kmC0jYstYUygcWriZqP9tpQSetgBsZTHUc3P4/hmmSuXxqsxVygY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741333965; c=relaxed/simple;
	bh=kxTgdwg4XnkN7hgjQpPD8KGX0uWBGkMdclk9EpJdCcg=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X7YIFrUA9siuwndlQl74a5y7dsKLP4sHdkVvxNty4PkVRtYuEwrno3/59d5h7C7rqoo8zYsfc2I2IDcI4pme21bPnWmFEHa7bzx/b764nqV6qE41xUCs70yWvUKvB7m3jGn9Ait00Rn9FKf8mEydP10nqE4zpgWMPLG/fNZtSrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FtG43PmD; arc=fail smtp.client-ip=52.103.43.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGTXGAql1BBbdpySCdrGVh3UpyWRRISc2IY8bdRraF2LLA0xeLHOGwGsVmevTC4748ShrXV4y6lRCX9zlXXjUHmL68GR3mywzreg0yrRhSrtOv9nKRfb+QJVWtu7x9Z2ySkfcEdGRlrXiTkmh5jP+OR5hpO5brx4TLL57GP4W9jhoXTO9Gydk3S3z3w51WZrS1hRvPYQkkPW9yfz25DTpQaogmXaHHpPnj7G10KY9a2JdCTLhFfGgfZJ3UZ565MEpP9zbvsGHybzLurnPNlvInrUxpR/PtHCfcaTJ/rz4D4S27FcZ0GTAog1+pafbeVl9LYYiv2KLHlqDQ0xDUa5xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxTgdwg4XnkN7hgjQpPD8KGX0uWBGkMdclk9EpJdCcg=;
 b=FOzV+vGcLXz/cmiR9vCMnji5/xCOCeDGv17aO0qQKbcMpW0iIa8psYQjax5pgHk0m2vr59SSfLvFC9Gc9WXx2edId4ClyFoc1BWsD8NwvAkA7wH6XK7CA1BJBbIhhGqQvoq1XZXbnawXdVLQZofBKJmJkCzimfP4FmGV1ZwF5Xrw8nJv7Zw8q8MEmh+nCmCm52/3xLtzg13DeY3tatMCHbJeG+4gxfYmBbx9akr/vc4JohtZrH0nT3w7wNhhuwCZJb+tKj1/Na43HA6Nfn9LUfs6nHsSV4znlt5si423+wgeKpM3naPm9ubNOSxy1vxZLo6+x/p+6FqYa41z19Waqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxTgdwg4XnkN7hgjQpPD8KGX0uWBGkMdclk9EpJdCcg=;
 b=FtG43PmDuEta0p0U3/mtYaNm++6vIW9STP+j9sBbZJ83D8Peiv1pBW2GnjqoDBFqGgn6OWAfYiSdS12qd2cAp/szGFZxvvoI2nDwCBNN2QhD2INBE3BwBXcgGP7b24y9NjbDn9xpToJacQfggLmmpiF8vCo4YHIbRtVbanLVuYZYsHQbQlWsNqPKGSW23ELgVaUrF4vzy6rG7sEO43ttM0YEcgoVMW2T8iMhcpYRr/eV44lm/mAHscygv7wjLH9Q2cFN9SHOgq95ubNfFdlIv6TfZDXWeakfZZwrIJxlRex9wF6mWV3f80Moz2PmNq2JHKOe3NPRcv0R32btHBT/gA==
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
 by OSZPR01MB8188.jpnprd01.prod.outlook.com (2603:1096:604:1a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 07:52:40 +0000
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f]) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f%6]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 07:52:40 +0000
Message-ID:
 <TYCPR01MB84379C89FB9BED4A70028F3298D52@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Date: Fri, 7 Mar 2025 15:52:37 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH v2 0/5] wifi: mt76: fix returned txpower for mt7921 and
 mt7925
To: Razvan Grigore <razvan.grigore@vampirebyte.ro>,
 linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
References: <20250211081247.5892-1-razvan.grigore@vampirebyte.ro>
From: Shengyu Qu <wiagn233@outlook.com>
Content-Language: en-US
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <20250211081247.5892-1-razvan.grigore@vampirebyte.ro>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0vekagTu6DzlSB34mGySygUj"
X-ClientProxiedBy: TY2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:404:42::13) To TYCPR01MB8437.jpnprd01.prod.outlook.com
 (2603:1096:400:156::5)
X-Microsoft-Original-Message-ID:
 <995ac96a-8cf7-4e50-94a5-b843911e7a23@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8437:EE_|OSZPR01MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: 08e3f902-2d8a-4165-7233-08dd5d4d08f1
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|15080799006|5072599009|19110799003|7092599003|12121999004|461199028|6092099012|26115399003|20055399003|440099028|13041999003|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWxuY0NIOWNkRzBmNDV6VHRzdFRPSFF0VURYZzN4MDZVbUthbGZsc2d0Nks1?=
 =?utf-8?B?MXQvK0M4MitCMmVEV0RFQ3dWUEd6WFNIT0lQRmNTUzZFS2hQajNLSVNLOXM3?=
 =?utf-8?B?QlRsK2Fid1M2OGpzb1ZNdXFNRS92RHp6aWYzbGNqK2JhRVZGS2gvb2Q4bzdv?=
 =?utf-8?B?Z0UrblMraE5xZVRqZW5hNjBJdE5HWnBpNzNzWERyMHhYNjgwUUYwUmcybzZN?=
 =?utf-8?B?ZHZoTW5QMXh0WU9zbXpLWnRCT3Z0RDU2YTlLNW5ObTMvSEVESzNuNEJLdlBM?=
 =?utf-8?B?ZkJPZHlwU0FsMWRzcFVUazdnaXlCd2sxalZ5cFIwdW1oOXkrSzNpSFp0R2NN?=
 =?utf-8?B?TE9VZU1FVC9TUzBITnllb3NYdytJSC9xME1xdUo4NEk2c1ZvdkVXdDB3UjNN?=
 =?utf-8?B?UlNDNjZhV1F6M2pORFRxSFV4dTdHb253Y1p4Qzdienp6WXFVaXlZcUJTRHNK?=
 =?utf-8?B?RlIzM0QzSnZrL3VidGw4dktKL1haYk5OR01LekM4bXBadVBWaUZMM0lzaFBu?=
 =?utf-8?B?Rnd0dEd3VEY5Y1o4WkdzYmF1QWM1blRIZUsraGNpYjZZQ0FjeUR5enZjUVg2?=
 =?utf-8?B?TTBkeUFTS0hLOVBEekJXN3RsNFNINDFrUlpiZk9CekZIWHdydFVFcVJsbDRP?=
 =?utf-8?B?djUvRTJCSDFxUGsvSHRPOTMzNGZJRzNvTjY4elRPVnlvYTV4ckRqcitQbWtG?=
 =?utf-8?B?TjFKOW5OWHJGWFVXV0VtcjI3OHFwdFRTeERqWFlHUm9ONXkrOS91MlpLT1pS?=
 =?utf-8?B?M0NVVGNpZytQZnpINitIUkdJSVFaNEo3d3NvclZkVm1YNEI0UHU4eldJa2tY?=
 =?utf-8?B?MHhoakFSVzJQc3hvNVNkV3lINk1QQlhwNzA2Vi9kaHdBVVN2eGJ2S0laWlNE?=
 =?utf-8?B?dVhGd2hzTHYzTHA0Q0hUSFFQRktXUmZaNzhQRHRBd0U1Q1NZaGZLY1FmempB?=
 =?utf-8?B?S1pNcURaU2FzRnBXeDZMOFcxWFFPYkZhVzQ4TkZ6ak1XZ29sU3p6NFdLRzZT?=
 =?utf-8?B?ZnBoK2JFa1VUWU4wQVFleTFyNDd4dzNEcDRIc0VEM2tvWEVXUUx1SHBIdTRD?=
 =?utf-8?B?VjRITmpiYlZUY1MrZG9NMDFzaEx2RlNvQTFnVng3aVBkUG13TlBvbHJ6OUdQ?=
 =?utf-8?B?dXpKZWUvZng2NnFKTmxUbXlob0x1aSsySXg2bUpBQnJRV3FabFJQTmczcU9R?=
 =?utf-8?B?bkZmUGp5UVgwVnZZU2lMSFM0Sk54K3pVTElzdU8yZy81TGUyUGJudjltRHhP?=
 =?utf-8?B?MS9TMUE1MnpLbXNJRUorT2FkRjZpZEYyWDB1VW9RcmJ5cFpUeWVoZGtvM0I2?=
 =?utf-8?B?cXZ4ZTNwcEFsang5QTVCcjlLS1ZINWEzRSt5Um5tZ2ZRUXM0S1ovNS9Kbk1Y?=
 =?utf-8?B?UXB0L3dGL2h4dkdaelEybjRtMnlXR1Q2a0NGUEVnQzcvZEUrQzNnbHdEcU1J?=
 =?utf-8?B?T2F6SjFZMk5Mc2gvbGtXVW5ablhCajkybUJYbzBrbWxTOE5rMHpZOVE0b1Q3?=
 =?utf-8?B?TktIQll5SjdTVzgwSEtLNnRqWE1kZkoyUWtGUTBvMHRyODh3SGZRTWJIMVNo?=
 =?utf-8?B?ZHNrWE1DcTJLazZKS2pDRGZQZXZsbmdTZEJ1am1CdnJBWW1FYWphTkRyRmxp?=
 =?utf-8?B?KytTbmFRZzNkRTNnOWpOYndHSStrY1l3R0cvUjFiWmNJOEJKdXVOeVNlZlNE?=
 =?utf-8?B?dnc2ZUdEUS9wYVIyZnhDZ0pScnpSb2ZxVUxOL0d1bzZwVjVVTldpbk1sY1Y0?=
 =?utf-8?Q?Mnbh+Z/olmChLAqcsM=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjhDRlJwaHBjTysyR0plYXB6UCtXSzBBamJ3M1ZSN3VzZDkyOW9TZ3A3NENp?=
 =?utf-8?B?OXBGTmFZSWpSSVIreG9QTVc3VUhSNXRneXdpejEwU1EyNjJmZWhIQm9lY2lm?=
 =?utf-8?B?Z0VjdCtJQ3g1bEZPNjkwWFdMR2J0YlFUWkZ4L1E1cFR1NkZpc1JCZDByS21t?=
 =?utf-8?B?Q2YreXMxcEtMb3RVQUlnaGdvazJWQmtOUnVaMXExaTZIU2tSWUtwUmpzWVdH?=
 =?utf-8?B?VkNjb0xHQnNZek0wOGowVDV0Mllpc2VONUc0YnhVL0MzcEhPZElTRGNONUxi?=
 =?utf-8?B?L3FmZjhQclI0Z0FOVTF0Y25BR3dUOWFKaUlUMWdiTzAvRldIYklQWHdyVmg3?=
 =?utf-8?B?WXF2SmU0NU5qbUNWb0pxcGtRVnB6NGlWSUhUcUYvMmI0eTV4OHNDZEF6Vmgx?=
 =?utf-8?B?L0tIUGlMNUl0YW5acHZyL1luRXZBNWNYTTh1OVZTOXlQTGJwTFczUXBtTFNv?=
 =?utf-8?B?cnNLbmJaenowQVU0L2RJT0MrVFFHZ3I4aEVUYzB0VXM5Unk4L0o3eVkrREpK?=
 =?utf-8?B?enF2V1pvN1Znc0hKdHlXWEpUc3c5TjNTU0RLOVBTSk82ZnFzWnpTYlBMWHNT?=
 =?utf-8?B?MFc0YUNRTWMyc3VzUEdXUE52N0YwTElwWnAzS0VleFEzM1BEamJkb2VITlEw?=
 =?utf-8?B?c2RBb1FGdm0yc3NNcVpjQWc2OTJha0V6ZGIxeVROYUdQZWxoZy9uUVRlb0FH?=
 =?utf-8?B?TzJIallmOWwveStaRGYwaGtHYWlxN2o1Rm52M21UUFdyaEtnek9QTlpEaUx4?=
 =?utf-8?B?TDJyYjkveGMxQStwM2hDVHVkcDRSdkVWM3NEM0x1eXA2cFFRK2dxaWhmOVlR?=
 =?utf-8?B?VkpMbTBIQTlPcnRaWCtVdGdMOXYrNGxPbGZpYWZWNkZ1MmJsTkRCbjdILy9J?=
 =?utf-8?B?eVhFbU5SbGcxQ2dUejdJVk5UL2ZFSTdpNmhoc2ZBSm4rMGpBckdKSDFwQmV5?=
 =?utf-8?B?TkdmSmpTenpqbFhsWVZVR2txdVF0d2hRaU16ektnbDVMWU9yTlRzZnpNQVY4?=
 =?utf-8?B?c1FHVDlGdE1RUUExSXRGeWdmQk8yZ3BVTC95bC9DbFlYUHdNV2YvK0puVE9h?=
 =?utf-8?B?L3hLSW9pdlZWUWl2aEVBdlY2eHFXTVVHRy9Ob3VEMzZYMjJ2aGE4WUp3WUJL?=
 =?utf-8?B?Z1ZEaW1RblM4VURhVS8yOXBTa0NOYnhOcWs0VDRTM2NzWWIzQjI2b0Z2Tng4?=
 =?utf-8?B?bHMwQ2EzeHZlR24zTjRpczRFSFRZa1F5NWhZVHpQRjdUbGx0T1lMUU1lSXZB?=
 =?utf-8?B?YVE2SEhDa3F6WjJHcFhvUlRwaGROMFRyNjZleHJnL0dLRnk3ZkxPRkUvQVk0?=
 =?utf-8?B?WlRyNTdDZU1RWGZ5TEZsakFId1RLeUlyNk82eTRpZlhUQ1dyR0U5a01aQkFQ?=
 =?utf-8?B?OXk0bXZuZHdoRTNQclk5QWgwMXVuOHU2QVJicCs5b2dENkNzd0haeG55NWx4?=
 =?utf-8?B?N09tazJGVEZMSmNTMGJQejJHLzZHbDN4b201YWx4M3Z6S2NmT0s4YVRIOGpX?=
 =?utf-8?B?TnZRSmtVTDFaeEtjSDF4ZTVFUXV1dWJURkRjanQ0bm5qbm10bGZEVDU0N1Fp?=
 =?utf-8?B?TUg0NnBOejl5OXhXZEZsQnQwVHpKTGVsYnY3K0E2UlVJejBPVGo0TWttZ0p1?=
 =?utf-8?B?YnZyN2U5TWMxOWpqdVBxUFBhNDdVb1RyUVJualMzdG11ZUUvb2FmWUo2cWxC?=
 =?utf-8?B?MVFtbWZ6WFlMN0JsSnJHV0YwU0crcDE1dmhBRE5GOUVhNXo2cjV1T0c1ZXhm?=
 =?utf-8?Q?PU5Tm+tE+eQJiJ/nXM=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e3f902-2d8a-4165-7233-08dd5d4d08f1
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8437.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 07:52:40.3927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8188

--------------0vekagTu6DzlSB34mGySygUj
Content-Type: multipart/mixed; boundary="------------oCuDxt4hMrzJQpSpsPOtKT2e";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Razvan Grigore <razvan.grigore@vampirebyte.ro>,
 linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
Cc: wiagn233@outlook.com, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>
Message-ID: <995ac96a-8cf7-4e50-94a5-b843911e7a23@outlook.com>
Subject: Re: [PATCH v2 0/5] wifi: mt76: fix returned txpower for mt7921 and
 mt7925
References: <20250211081247.5892-1-razvan.grigore@vampirebyte.ro>
In-Reply-To: <20250211081247.5892-1-razvan.grigore@vampirebyte.ro>

--------------oCuDxt4hMrzJQpSpsPOtKT2e
Content-Type: multipart/mixed; boundary="------------ogbNxNuMjnBoejmJCzTzkAld"

--------------ogbNxNuMjnBoejmJCzTzkAld
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGVsbG8sDQoNClNlZW1zIHRoaXMgcGF0Y2ggc2VyaWVzIG5vdCBhY3R1YWxseSB3b3JraW5n
IG9uIE1UNzkyNS4gQW55b25lIGNvdWxkDQpoZWxwPw0KDQpodHRwczovL2dpdGh1Yi5jb20v
b3BlbndydC9tdDc2L2lzc3Vlcy83ODMjaXNzdWVjb21tZW50LTI3MDQzNDk3OTgNCg0KQmVz
dCByZWdhcmRzLA0KU2hlbmd5dQ0KDQrlnKggMjAyNS8yLzExIDE2OjEyLCBSYXp2YW4gR3Jp
Z29yZSDlhpnpgZM6DQo+IFdoZW4gcmVhZGluZyB0aGUgdHhwb3dlciB3aXRoIGBpdyBkZXYg
d2xhbjFgIHRoZSByZXR1cm5lZCB2YWx1ZSBpcw0KPiBhbHdheXMgMy4wMCBkQm0sIG5vIG1h
dHRlciB3aGF0IHJlZyBkb21haW4gaXMgc2V0IG9yIGlmIG9uZSBjaGFuZ2VzIHRoZQ0KPiB0
eHBvd2VyIG1hbnVhbGx5Lg0KPiANCj4gVGhpcyBidWcgd2FzIGRpc2NvdmVyZWQgYnkgbWUg
YW5kIGNvbmZpcm1lZCBieSBtYW55IHBlb3BsZSB1c2luZyB0aGlzDQo+IGNoaXBzZXQgb24g
b3BlbndydDogaHR0cHM6Ly9naXRodWIuY29tL29wZW53cnQvbXQ3Ni9pc3N1ZXMvNzgzDQo+
IA0KPiBJIHRyYWNrZWQgdGhlIGNvZGUgZm9yIHRoaXMgYW5kIGl0IHNlZW1zIHRoYXQgZm9y
IHRob3NlIDIgY2hpcHNldHMNCj4gcGFydGljdWxhcmx5LCB0aGUgbXQ3Nl9waHktPnR4cG93
ZXJfY3VyIGlzIG5ldmVyIHNldCwgaW4gY29udHJhc3QgdG8NCj4gb3RoZXIgY2hpcHNldHMg
bGlrZSBtdDc2MDMsIG10NzYxNSwgbXQ3NngwLCBtdDc5MTUsIGV0Yy4NCj4gDQo+IEFkZGVk
IHNvbWUgZGVidWcgbG9ncyBpbiB0aGUgbXQ3Nl9nZXRfdHhwb3dlciBmdW5jdGlvbiBhbmQg
SSBnb3Q6DQo+IA0KPiBbICAgMjYuODE2MjI3XSBtdDc5MjF1IDItMToxLjM6IG10NzZfZ2V0
X3R4cG93ZXI6IHBoeS0+dHhwb3dlcl9jdXIgPSAwDQo+IFsgICAyNi44MTYyMzRdIG10Nzky
MXUgMi0xOjEuMzogbXQ3Nl9nZXRfdHhwb3dlcjogbl9jaGFpbnMgPSAyDQo+IFsgICAyNi44
MTYyMzZdIG10NzkyMXUgMi0xOjEuMzogbXQ3Nl9nZXRfdHhwb3dlcjogZGVsdGEgPSA2DQo+
IFsgICAyNi44MTYyMzddIG10NzkyMXUgMi0xOjEuMzogbXQ3Nl9nZXRfdHhwb3dlcjogKmRi
bSA9IDMNCj4gDQo+IFNvIHRoZSBkcml2ZXIgaXMgY29ycmVjdGx5IGNhbGN1bGF0aW5nIHRo
ZSBUWCBwb3dlciBhZGp1c3RtZW50IGJhc2VkIG9uDQo+IHRoZSBudW1iZXIgb2YgYW50ZW5u
YXMuIEhvd2V2ZXIsIHRoZSBiYXNlIFRYIHBvd2VyIChwaHktPnR4cG93ZXJfY3VyKQ0KPiBp
cyBub3QgYmVpbmcgcHJvcGVybHkgaW5pdGlhbGl6ZWQgb3Igc2V0IHRvIGEgbWVhbmluZ2Z1
bCB2YWx1ZS4NCj4gSXQncyBzdGFydGluZyBhdCAwLCBzbyB0aGUgZmluYWwgcmVzdWx0IGlz
IGp1c3QgdGhlIGFudGVubmENCj4gZ2FpbiBjb21wZW5zYXRpb24gZGl2aWRlZCBieSAyLg0K
PiANCj4gV2hpbGUgaW52ZXN0aWdhdGluZyB0aGlzIEkgZm91bmQgY29tbWl0IGZmOTQ2MDQg
dGhhdCBhZGRzIGEgc2VwYXJhdGUNCj4gZnVuY3Rpb24gZm9yIF9nZXRfcG93ZXJfYm91bmQg
c28gZGVjaWRlZCB0byByZXVzZSBpdCBmb3IgYWxsIDMgY2hpcHNldHMsDQo+IG1pZ2h0IGJl
IG5lZWRlZCBpbiB0aGUgZnV0dXJlIGFzIHdlbGwuDQo+IA0KPiBUZXN0ZWQtb246IEFsZmEg
TmV0d29yayBBV1VTMDM2QVhNTA0KPiAuLi4gYW5kIGl0IGFsc28gcmVhY3RzIHRvIG1hbnVh
bCB0eHBvd2VyIGNoYW5nZXMgbm93Lg0KPiANCj4gVGhhbmsgeW91IGluIGFkdmFuY2UgZm9y
IGxvb2tpbmcgaW50byB0aGlzIQ0KPiBSDQo+IA0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIEZp
eCBsaW5lIHdyYXBwaW5nIGZvciBjb21taXRzIGJvZHkNCj4gLSBBZGRlZCBhIG5ldyBwYXRj
aCB0byBhcHBseSB0aGUgc2FtZSBjbGVhbnVwIGZpeCB0byBNVDc5OTYNCj4gDQo+IFJhenZh
biBHcmlnb3JlICg1KToNCj4gICAgd2lmaTogbXQ3NjogYWRkIG10NzZfZ2V0X3Bvd2VyX2Jv
dW5kIGhlbHBlciBmdW5jdGlvbg0KPiAgICB3aWZpOiBtdDc2OiBtdDc5MjE6IGZpeCByZXR1
cm5lZCB0eHBvd2VyDQo+ICAgIHdpZmk6IG10NzY6IG10NzkyNTogZml4IHJldHVybmVkIHR4
cG93ZXINCj4gICAgd2lmaTogbXQ3NjogbXQ3OTE1OiBjbGVhbnVwIG10NzkxNV9nZXRfcG93
ZXJfYm91bmQNCj4gICAgd2lmaTogbXQ3NjogbXQ3OTk2OiBjbGVhbnVwIG10Nzk5Nl9nZXRf
cG93ZXJfYm91bmQNCj4gDQo+ICAgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni9tYWM4MDIxMS5jICAgICAgIHwgMTEgKysrKysrKysrKysNCj4gICBkcml2ZXJzL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYuaCAgICAgICAgICAgfCAgMiArKw0KPiAgIGRy
aXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L2RlYnVnZnMuYyB8ICA4
ICsrKystLS0tDQo+ICAgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5
MTUvbWN1LmMgICAgIHwgIDQgKystLQ0KPiAgIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlh
dGVrL210NzYvbXQ3OTE1L21jdS5oICAgICB8IDEyIC0tLS0tLS0tLS0tLQ0KPiAgIGRyaXZl
cnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTIxL21haW4uYyAgICB8ICA3ICsr
KysrKysNCj4gICBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkyNS9t
YWluLmMgICAgfCAgNyArKysrKysrDQo+ICAgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0
ZWsvbXQ3Ni9tdDc5OTYvbWN1LmMgICAgIHwgIDIgKy0NCj4gICBkcml2ZXJzL25ldC93aXJl
bGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tY3UuaCAgICAgfCAxMiAtLS0tLS0tLS0tLS0N
Cj4gICA5IGZpbGVzIGNoYW5nZWQsIDM0IGluc2VydGlvbnMoKyksIDMxIGRlbGV0aW9ucygt
KQ0KPiANCg0K
--------------ogbNxNuMjnBoejmJCzTzkAld
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------ogbNxNuMjnBoejmJCzTzkAld--

--------------oCuDxt4hMrzJQpSpsPOtKT2e--

--------------0vekagTu6DzlSB34mGySygUj
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmfKpcUFAwAAAAAACgkQX75KBAfJsRl0
SQ/+NiY2QPqMSGyE+k/RTvU9DWkDqZpdwUyEesghjW5mMILGPqrpNlE2dtYcshdZDbVr9RXqJT7u
1q7Kez87V0gbNfx3L2RBoMvOZSNN7THhAaPLgT/UctShrKkX/IETVgSoxUWT8bsP+t6B9ugHHc77
G9dz0NsBjV0cGbcbXE6RB7IX1IvunHi7b2IOCIDvSH1lAF4ITtyEekc/y2sJB0ejV4Bpbgj2N8RC
Yt2HcpSQawzfX8jDOBNdzdA2wG9SrNEqXX5Hy9iMkVVcV14u1gsELnksEmqmM9Lx0LVQPUJT1CtF
h2KNqqX6pywEn4O7imMX+z3PVmc54S83MrmMIdVUs+eSctWRV0nUXr3mxMSK/7cOKEZLDLpXscTl
oniLGLJQVCSSJiIuB3RySe+/t/wa/IsGCx/SNdnR7KsS6mO97wIPkz6qL6D224EZe7/7XY9dmmT8
tLaW0xy68NqCp97ndhOWFyMFszOsbN4wJkznbQQ3cq2ORR8XTVdsf03sY+RYGu7GpRpHK5F9SXEh
m2SS75N0eu3U23KYBQ4lCxOHcj41gAStjhMC/hLJ8Bujdgxpi5juymGFR535DhUZg6xf2r3BpLug
w2viv+WYwm+ERgmfpT6V/tX86OpV7WkBZLef9Pghi//mAVNcp+zb8bBn3GUjB/KEu0VgZMhf7is2
3CI=
=hpIT
-----END PGP SIGNATURE-----

--------------0vekagTu6DzlSB34mGySygUj--

