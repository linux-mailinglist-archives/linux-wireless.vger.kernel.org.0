Return-Path: <linux-wireless+bounces-17232-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04980A0741F
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 12:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740B01889196
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 11:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBA0215182;
	Thu,  9 Jan 2025 11:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aOUxhUL2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011036.outbound.protection.outlook.com [52.103.66.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF30B1714D7;
	Thu,  9 Jan 2025 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736420687; cv=fail; b=Oq1l8vpIV82b5hMSPWeCKaxcvEaNlhXi3jrN6wEBV9U/4yIvSnnuLl3xzEm92WShyKTDTSK+QGmpbUqA11g02hgt3mV3/Y34OpB8sxN6+/TaTBAjPKipfAzQLiqQul82OX0VQ/9UKrGZG6+8haXpuiIXL37VXfsHyWQXg6Q/0N0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736420687; c=relaxed/simple;
	bh=IeYj8l9KprzvUDk1XE5fcbk7xdf+qWSQhbrObf9pvTo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eYrShjZA35mX+qaWkFFH7hU68BvxucT/1bFaZfut2oENvA0i9fp3vfdqhw1m3CjVx4nc3wkICxZf6SfkzLF/GXfom7xZal09QD5tfWgKnvvyHnWnXzHYqFBwnLfrgqdSkAk33Y8VV5QZXbSt6Csm/jSI32HA1wRKhI1c8+RL8GA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=aOUxhUL2; arc=fail smtp.client-ip=52.103.66.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGcztT368QDYaU6v7OHJj2gRC7azbL4MTMnOZEIj7FttopM3JVIedElbRtQr0+bfgEm1ZEcxpulcmaWK2OXsYfiSBOcgYmSFwbTpiQGpDc0U7gcsvAZ7K8wX0EwmYOzlY19w879o09Ow38/YmNvw2VKJwNoaq+fzeLKadRMEJRnmCtNbsC7K8d7sJRJDI3RYblgvC5ROnulQRPh23RqSDJp4Y1f08K/WWw1x8w7CY/KZjVEXO86jrEwv6JFkb5yMq96cGCG1HJs9B4YwWuYlWw7JBxFIYnB8QjGGyvd8e5onO8xJo/KInpYU35VEG6eDVdum8zGZBL/6q9Sqd+mqVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIlSHS+qIJGkjuZPrK7xIjnNc9dOtWy5cV7SGROcTlY=;
 b=T/6sLTHZZjvYjJHt5ylfru33lz6VBuFfRi3p0vwqEWPksUm2XdpvrKpC30HT1LeFweNNQDoHyvUHKNjJmCBTdGdcF23n7WyvJ4hQGUQNzZxi9hN+uTokixAZioWQMmDV6k3meVI1oPXDcC/Xp+pjoMwjlDqKN7PnaZxMnwQOU9qgb+rkU42GzaOIQ/RPRn5W9LP0Cy/7e1CLCmHlj6o3PyeFt6y5zl0ef+NUIxutMZ6A7G54i1l55W1QYstiKCYGHAmDfJSGV+RdC3tYjhZZbSRF0u8BaBeI4Xn0Q8rPm4aHitsVKQgf8uTM0XKR2efBR5/smntKBUqL4Vcn1dAMgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIlSHS+qIJGkjuZPrK7xIjnNc9dOtWy5cV7SGROcTlY=;
 b=aOUxhUL2/UFCbpQfFKuLUMD5zzHB+dL87HXcfpxUe6D54WJ/ZXgrM326Haes/hun9KvTKNIwRtmw9jJCFmp9PDF9gyJsV8SZz0yGow4BB58I6FJ1sVuYVYcsAJegf3sPOTqCJXJDpfaqbpeQ+pAb9IZrXnt/pQBpKRKoiLJtYPDKcnEz1qWN1Phb5L6LRxVY+uKrXFqv5FmoCRHBGl3JfR/ny0y/b3xVFliPexriW0EtCVtwsCEDrws2d+hRYlbM0udQ5Z8uyr19PejbJdOFBuc5vP1Rekx2sNUGs2unA0BXKCDUCcIZF7/4ehtXfdEgFw8y8gxAUyyb1xy/SfMqLA==
Received: from OSZPR01MB8434.jpnprd01.prod.outlook.com (2603:1096:604:183::12)
 by TYAPR01MB5532.jpnprd01.prod.outlook.com (2603:1096:404:8040::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 11:04:41 +0000
Received: from OSZPR01MB8434.jpnprd01.prod.outlook.com
 ([fe80::7c3f:73bc:3c62:fe7]) by OSZPR01MB8434.jpnprd01.prod.outlook.com
 ([fe80::7c3f:73bc:3c62:fe7%5]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 11:04:41 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	chui-hao.chiu@mediatek.com,
	leitao@debian.org,
	chad@monroe.io,
	Bo.Jiao@mediatek.com,
	sujuan.chen@mediatek.com,
	StanleyYP.Wang@mediatek.com,
	evelyn.tsai@mediatek.com,
	meichia.chiu@mediatek.com,
	Money.Wang@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v1 0/2] wifi: mt76: fix register mapping
Date: Thu,  9 Jan 2025 19:04:34 +0800
Message-ID:
 <OSZPR01MB84346C4709BBB767B1D201E198132@OSZPR01MB8434.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0020.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::13) To OSZPR01MB8434.jpnprd01.prod.outlook.com
 (2603:1096:604:183::12)
X-Microsoft-Original-Message-ID: <20250109110436.25870-1-wiagn233@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZPR01MB8434:EE_|TYAPR01MB5532:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b1d1831-4bb1-4e98-80f2-08dd309d6a4a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|15080799006|5072599009|19110799003|7092599003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fBvcZt2yJ8SYySS3OiktnIRRFX/pPS7frVPkyaHpOHnvIgAZ/NXnBWTjcdY2?=
 =?us-ascii?Q?5KJyCV7SPr264xhL9Ov2eNwJkl8SWXHZQ09iVVCX3OKOSq9OtDZUdVerJSQI?=
 =?us-ascii?Q?oHwqkAzSCn2sm7N5EpET0JfC1DYXfFYcpvc2bUseNSEhEiOFrhi+j7ILu2y+?=
 =?us-ascii?Q?yigzCGNTJNUfC1t50hHoRTcppzbTYG4nAY7Aa4Ee2KxBw0gs1lQgyhaG84MP?=
 =?us-ascii?Q?FTMXTfJVCTpHijfVCCC7CnOYP116GYhAuq3isZBVxz0yV1b3xjn97gu/1InW?=
 =?us-ascii?Q?gjXdGl2UfWjDS8ccMGB6PZtUfBFxi7WkqUVz7Gyjtx9MMpQz5VSrzE5P3oNt?=
 =?us-ascii?Q?GiN9aL2pvKhJH3f3Oo5Al67fRuVY9ZpGWNULWL5J2351JrIB/WyRde892bRD?=
 =?us-ascii?Q?Cbtcy2jLRkOV1lzC40PGmwErQom2oKE4rgqL1KYFFhAIKkPvFBCgKu1jBpRm?=
 =?us-ascii?Q?mFhPR23cX9fV8tGo6F9/GGKt/YM2TPyONS4q1zyTQPr1WnVxcxPZhbvalEd8?=
 =?us-ascii?Q?Nff0Lk7E9PdsPj9IwV5yvZbxWm37pGDNPFDGhCrmYet0mstxveQpmgg8Mokp?=
 =?us-ascii?Q?TUuDvaqYYj8aHkkUjGbtj4tujTd7Ww/CzuH557EIKFw9KPRIn/eRaE+6rFZ7?=
 =?us-ascii?Q?Qp4x9rAdsrQZY18j5lwX2Sa8TZkLr0W2lvw5VWMPOUzm3kCT6ooza5ywJNjG?=
 =?us-ascii?Q?XF5YsF5Mkob5wNHEnz9w/rFca7jk1PWK+4/zRMArq/IvlZyGStRtBNxNq4IZ?=
 =?us-ascii?Q?Br2mCE237pZAWrGv9R0ffEideaxUBk/qP8f0nYsaNmApBPRFiCyyUcMlWshh?=
 =?us-ascii?Q?3N0m4rEgr6nP8hb3lQg/L2UkKdLIPanMQ9qQ8J7K2++IIF8m/OBn+vShGf1B?=
 =?us-ascii?Q?mddANMieQbarj8TwqDAbmFbDetbCvcRurBBCur3j3L40Ar3sT9GHsSN8mi3L?=
 =?us-ascii?Q?2Y/OUSxh4U63P/itJ3x8ln7MJ+v+zsNFSpXfzbQhgt0Nlwm8Iwb17ULirE5d?=
 =?us-ascii?Q?nLYzicqeneaQfGtMaw5+nB+V85j9gRf0x4L9Ce/ZLD8JZkyUXAEB8f2bnKEh?=
 =?us-ascii?Q?65efnfO5fI1aCvXCLdwJGl1wdZGh3HeOpnZX9FqHG7O5Ykig0uc=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rCGwxjnFh63dfROmcgQD4D+62xhZS+MPuUwPhJCqCFxEjo+GSWNsTWO7kaxq?=
 =?us-ascii?Q?PpYnmjKLowjmEUYNlU+SmXwFD+KJNOv1rG0879f9g/h9CmGq03PveUTfoi2e?=
 =?us-ascii?Q?9Ia7wOEeZgmiJJiYK3m0rnQJGTcgDts2rMSnkRQ35BfI9jptC1ibud4yywuz?=
 =?us-ascii?Q?VbYkczQ/Vh4CdWkEzIYdfkSYCnNgcA14TnqwZYoUulgWFoGCsrywPvY98uN1?=
 =?us-ascii?Q?OdME7FCw1VUgy1ws/H3Ykl38jeseK3YfX5ZWLYLZKe+Oee6KozdDL3Yjm/3a?=
 =?us-ascii?Q?gbQ77rocWfjmigoaWeoRHmSeu2O2WNJv+zCBWFulxSvGRlI4uQQbtsa+yGY6?=
 =?us-ascii?Q?91bmYnWQdbGMFiOVZCVY+8kgoFrRlhzVrh15DKM11Fp31MrH+azFjA03Vm4g?=
 =?us-ascii?Q?jClKr1Exi2Zc1tDFVNLZMfm+4v2tUF+3aRU6N7bM7CYVJRPn0SXYPpzrmNbt?=
 =?us-ascii?Q?JVEOHsOpTmgsu3umN9A/ACaCQKc9cyne7RUUpQIRF/uxU526Q2rf5p28ZL0p?=
 =?us-ascii?Q?nD8pSLfAoMoHM1lJeOsWdzFjbjd6+b+DPTbPr22fevJjxGma9Cbwqc2kNdmL?=
 =?us-ascii?Q?LDnEBhFBVbBVFw1M5OYxesc9/zqZQKUl/VhcXV9Y/9IdepqZGhlanCXL0rMV?=
 =?us-ascii?Q?obees95quQLuKVJtkKNvy46WQoIRkE2uo/ihvKaAxr8L6WQzZM0d25X0ujo5?=
 =?us-ascii?Q?ZAU2z8r3a8+XIrXSrIyPzN33hogQeL3LfhSZPv9k653YoQppTll2DsjMzOkz?=
 =?us-ascii?Q?sckZVVeIzE3SF+V+UeOgkYmPw7D9PkDm+hZZ78CPo1nwgAI0BleCOc1eNVsL?=
 =?us-ascii?Q?lyZH/wQNm+2CAevUvk0iv6dqUYaO5kl/5yVbPQrNPhPnimrkUK3xbuJC8Ttr?=
 =?us-ascii?Q?CPfIUgVC/wcSbIjnCdtACVDbAbsxO87zmspaKw1QzbLO4dq2CTiL5w4vtK7R?=
 =?us-ascii?Q?2ETKZJpGtZN3o9Yim54R5DmgxDKEm+tux5SsMQPl/K7eRe0p3wOiuv8Px9ZT?=
 =?us-ascii?Q?G4LkRGVFmMwIXKvo0XC/NIl8pO2sw5rr5rjlBnM1nHzrmaF7tkNItCWdhfix?=
 =?us-ascii?Q?JWSxrgWCkHd+93QTL0sUofZFQTGmcaASZrIRvW3NQn9DWMkIU3YRDkq3k1z8?=
 =?us-ascii?Q?z4djQe5bFBsmGuKe9i6C5r2PciwELnUtpDsS7gtpwlLz30XV4Gafh8da3e+d?=
 =?us-ascii?Q?ONsBhoT4PdfsWjAIjGYXZ7QW8TtXoACZof/NucVq6wgR0MbFz7nVq3wCZPqY?=
 =?us-ascii?Q?fdA2VFIfAwibMD51FHWl/jtCOHx3CKMkjNnCttIaDTv7AhnJbKhLL1uLGHNB?=
 =?us-ascii?Q?07I=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1d1831-4bb1-4e98-80f2-08dd309d6a4a
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8434.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 11:04:40.9997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5532

Currently, mt7915/mt7996 driver would try to use the register entry
when ofs is equal to dev->reg.map[i].size.
Without these patches, it would get incorrect register mapping when the
CR address is located at the boundary of an entry.

Shengyu Qu (2):
  wifi: mt76: mt7915: fix register mapping
  wifi: mt76: mt7996: fix register mapping

 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.43.0


