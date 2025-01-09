Return-Path: <linux-wireless+bounces-17234-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B47A07423
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 12:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D8C18897D8
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 11:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4A3216E03;
	Thu,  9 Jan 2025 11:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="UG8Miv3S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011036.outbound.protection.outlook.com [52.103.66.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FD22165F2;
	Thu,  9 Jan 2025 11:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736420691; cv=fail; b=TulQZx5E/T49Au6e9d2pI6HMb2hhMeWec8l1LZ2EA+nTDY7bhMnUKNuoq8A99+nA3jR1kyKduUrKkDhOseFFt7KmmUh9Woegvi3ElQ5M/FVlftMlLtzJ3BZOITf+smvCylnUSGn9ylUTeDRfhoZofSthiCpj7G6w4uS+88K5ryA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736420691; c=relaxed/simple;
	bh=i6D5XNRgYjEV1Kg64R6nqR4ykNp35f9JgS4SX+Cwj/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=idaLXrzuixzG9osnbJ6uOT2u4bVkBpWvnBKcefGm8pLmDevMQUgnf+M51v3VX4eAaNtUE7OsUeYeW/zj+hrlRBypP8uU5jkvdTcOWHb2BuF7HtKcOB3L9o9gPyTFx0J3OyfvMrqRbWHotP8oA4qVqfgd9dG+29HtbvblyJwLlHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=UG8Miv3S; arc=fail smtp.client-ip=52.103.66.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F95rCVb6XPshDu+1WRx4lk/l0Y/9dMVMDmpNtaxKIOpTlfUkdKS9USK7DExRtXoQnCvwAOwijm8RtyVO7yFIYjaC8LThVd+wF/g03UngNXI5mMF/G9BknuqC1RBmw/SnMuONcBy0npAgZ8tis4Qa+iZaMDk85lJVHG7MZn/hr3Io9irRt3kgfIHK/PE92Uf8ZXV6Sm0AK6Y8UpgD6MscSunC8Xowsr72vUzCjAcxjDNqWw30Wo/9Bh3F80aOiQSQPokcaWMJw7dZww/PqWfyIvDmw4dzbYci/yp7ZiuJSuiTeN2YjlScbP+kmWSVrnYHOIvjruFskJgP10c+ePM2bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eK9hg4I0h628hGYWHRSx2/3ECfYchg+ZvO5rkcx+PMo=;
 b=H1HFgvtB2QVIDYXvcFoUmZRHgMOjQwEX1CLh/8Omt5aFZVLlw2aW2hz+F4cCDTw5IIU48y2RhvTE4EVVKe/hVBnKhWdmxiTx4KC/52ZLnijhqud8Yvmp8NW+ZCHCVKdC4y1ZzkdNpifNfBalCgyFNp2oS/GlBzZoXAogm4w5dORtQI8qZW19Pn/S2sm0jIhofM2J9k+CAYWi/vEcxAk+AmPtzZCtbSZm2N8CcaNA4RWaQD9az65d1wceL0syfLxOD7dqlKZexHHPcJoXPA6iMqhxU8kAHbTBF79d7/io4WxycQH+8E9BgG1fSSpAej/7C+5KZn+wRqwCGuoKpyvang==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eK9hg4I0h628hGYWHRSx2/3ECfYchg+ZvO5rkcx+PMo=;
 b=UG8Miv3Stg8EDes2D1R4oQz+M63YZOKcmmzQSH09wER4YZLhJ3JEq/2S9fkfBktgoy04VO0B/eZws6URyI/nH7FTAGP3TaTYxX5cc97kNYaflBDf5/sMkEkIhulfD4PfH8nwynuasX7+3/aSxkxwmaIBcWOCT1vW2eKE6eBi6sr8RMf3oGiqcEEoTWptI8aQF+S20rI82VOWuB3doruvBtDqeyMzxwNdew8AW8ZBcCV7kkY0fKpj+WOYAASVD0pL9WbfjW1JYzwscpaK9RS9Wm5kYuilKuoqEB1y/T58LO6cvQkqUDkyeIOp1oy86x/Zc9rYl9qNHHaWLzJtIWcjYw==
Received: from OSZPR01MB8434.jpnprd01.prod.outlook.com (2603:1096:604:183::12)
 by TYAPR01MB5532.jpnprd01.prod.outlook.com (2603:1096:404:8040::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 11:04:46 +0000
Received: from OSZPR01MB8434.jpnprd01.prod.outlook.com
 ([fe80::7c3f:73bc:3c62:fe7]) by OSZPR01MB8434.jpnprd01.prod.outlook.com
 ([fe80::7c3f:73bc:3c62:fe7%5]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 11:04:46 +0000
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
Subject: [PATCH v1 2/2] wifi: mt76: mt7996: fix register mapping
Date: Thu,  9 Jan 2025 19:04:36 +0800
Message-ID:
 <OSZPR01MB84344FEFF53004B5CF40BCC198132@OSZPR01MB8434.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250109110436.25870-1-wiagn233@outlook.com>
References: <20250109110436.25870-1-wiagn233@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0029.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::15) To OSZPR01MB8434.jpnprd01.prod.outlook.com
 (2603:1096:604:183::12)
X-Microsoft-Original-Message-ID: <20250109110436.25870-3-wiagn233@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZPR01MB8434:EE_|TYAPR01MB5532:EE_
X-MS-Office365-Filtering-Correlation-Id: 82b8bbc0-a0a0-4070-38cf-08dd309d6d4d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|15080799006|5072599009|19110799003|7092599003|1602099012|440099028|3412199025|4302099013|10035399004|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HLIb7qnuIFMiQB5FOK9sV9ghxBzpp0LhXqlmxNSDEruyVKul6mZhm9zGm7NA?=
 =?us-ascii?Q?qFCL8ZYTKiRtrnH/ZPSt6e4Oz5jY2jATTHMTIk1V5LclqPwBJIQKU+7dIse0?=
 =?us-ascii?Q?D/DYiw4I52Q6p0UxaBDXqQ7iC4HdxpP2AqWbJwIn11q2XY/xlgK0A21Q8e/G?=
 =?us-ascii?Q?Qnqraf6Hlr/7cwnGgjaMALvvJvLlX23GgeLM9f8X5TvRziu+PD7a5/kW8hTz?=
 =?us-ascii?Q?yyalNspMi8uXR0YKxII8kiRTLBTaSli69sU7aajfzATuDdWFFZsqhttpCLfh?=
 =?us-ascii?Q?Mo8uJTsqYF0SagkmPJ+xdW+A6bXJ7mGl6C49KOCOeGW7LimixGqb8oikmIcI?=
 =?us-ascii?Q?WMZoHpp2qCCkqy85EsjpMiSeYrqP6RqbNpqk+jEJREA1J28zs/MpodJzRLJq?=
 =?us-ascii?Q?H4Ahsg8jPdLbUmWNgGDHF1SwWQQ2kn4Y/mcYmI2QwZHPFfiGRKSuRWRA5qau?=
 =?us-ascii?Q?HdUiJdMwnobhCvO5RcWgCAW5Xw/dOUb6q+ZaUcrTgI2LOjajWuNuvpAabeFK?=
 =?us-ascii?Q?c2xZajq7eFDJjM617H5mzcUd/Qrd3whJH9OZAe2Jrn2x/ntI02xXlfPon+nE?=
 =?us-ascii?Q?+QqCcuj8u052nCazRjroUmwjtWwLDQ9MuFiYiSPiPykbPzAbHQM7zLajJlZS?=
 =?us-ascii?Q?95WtmBcvq8M/AlHM+4jYmNbDRd/42ukdecRTZ3k8glRCuXjFYE0thFi3NsOE?=
 =?us-ascii?Q?mf4lxb2fSbk2tIBVOrednJEoXl068y6DiNRaAxUZBaiACjM+0OCMpOdU1r7s?=
 =?us-ascii?Q?9Y4uVkTeJ/POVmh+cW8fJHI7FPsytAUgeth8S1wbY7rVkQ8DgrCK0ldUEEY1?=
 =?us-ascii?Q?CFXkBCvonSSlS4ukUuOij9ixhkYIIvffIa63mVyQNqZsU0MHDG4uTY4QP+Z4?=
 =?us-ascii?Q?NA2pdOadHGLc0pqoGKOV4Z9bgkQFqzfePYPfU09hNHkdmT1hAY6jgKvayo/J?=
 =?us-ascii?Q?VHkGUUybEakrIyYTizig1xUXQ7jHkK9VcWE4aHDnekXMRhPtjjLn1MAVexqf?=
 =?us-ascii?Q?7lhg8byCw9ZVzsTH0W4bQtqZ0kOnl2niL4rFEyGE2B8omfJDdH2ee+4yUP2g?=
 =?us-ascii?Q?nLBsAvot4ehCj1JY/2yfZ+sZJP4LE8Xu2fEQ6rWSwMYW1fQa5wE++G04AbJ3?=
 =?us-ascii?Q?OkcNMV4ETmq1NF8Wp+eF9iXhgQ32J/42gPLm/GXpDT4AWmeM4mvihOTC/bXO?=
 =?us-ascii?Q?jjW323W3ap+y4WUHAsqplvMih5Izx2yZX3npxw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VLVlQmvrPrL6rMVkGXS8l1rGKQxk3qSeHUVy39LLv9SflguLaWGcw3qiWRDl?=
 =?us-ascii?Q?YNADtuzmI/ZfbLxiGXMjsWHZKvSD2pZdlMX7bJmTFHok3yE1sQFunkO52fKT?=
 =?us-ascii?Q?xWtyE1z/fvXmy0LspMi8q2ffUmPLPvqgQfgbR5BSBAdUbnwNQgtXNYQ0qh3T?=
 =?us-ascii?Q?ZzHNLRczfsE43sotXxYxUOXnB2M3lJ1R6TXU7qOImX3clnkNAI1lNJ9SYCa3?=
 =?us-ascii?Q?KsRn3EPpFOamX9N/5Gwd65E/jef1Zv2Il4WDceHz74JhcPGCAlNp73ubLn4t?=
 =?us-ascii?Q?avTyYBMABa/838JoZm1PUxk0vBGJRkX6vqpQ7VXV3ZqtbENC+jHyniQ7HrnA?=
 =?us-ascii?Q?QndtHjXZAFFO9YgeUj08KMDL7b3bujtkAVlfr4+SCGoZkXiM7tZGcyVrxPpY?=
 =?us-ascii?Q?Z8s2XLrn6dirnWo8B2dAt7/We1e+6JWU7hutXng5qD3vkktNZUciyFH+kZxa?=
 =?us-ascii?Q?XikChHvxBDWvvee9o4hPX7rq2rDnW4GhvQAqLk3oehfMCh87LBI2FCySSOgH?=
 =?us-ascii?Q?5ojSqo6O5B1d7pU4inuZDsLVrWoH7iOBSQnEPgbwE0Rp6btu1N48htO/xjeL?=
 =?us-ascii?Q?eLI8AUkcsIMn/MjBiOIQTIrxaua6Zw9OninjUp6/Ncu8JVxyvtGSYkPihRq7?=
 =?us-ascii?Q?8k3pz/4G66rV5/4n3RO5MlrltXjI6JXdw7BTmHGXj+tEHYutlCtFopN8Rh4o?=
 =?us-ascii?Q?17u2elS6M7pDqOhfQbuecDbjuLz4LER65/M4nFAp9Boa9pQjIw+opI12i85R?=
 =?us-ascii?Q?1FXgfp7q4ZETc8H+TgO6QZFC3cV5sS+YfXdEOuh1Kdas0cKKT8SkLreOK4mK?=
 =?us-ascii?Q?uw9MiCLBPwuJjaQTkVLq4Oi92e5mMl/kOKVso81AuiBaddCPoZOGPzjfP2xM?=
 =?us-ascii?Q?hYuCm1lWQimVPlO436l+gK3I9MhcLDWVBffkEPTu6FuzTkNPe9reTwmxYjz/?=
 =?us-ascii?Q?9OMK1DcJw+l8wc/gpsdT3eDbwKXK4GN75z/Ds8vtrgVg0teXMHzAHQReS4G1?=
 =?us-ascii?Q?0hJglnT/xL3svtbWQyVMxy8roUTcpyFmveQlcC7m82NgVwM5CPtcyYEZCkI4?=
 =?us-ascii?Q?OXbviHJPPz53a5SlDiyJBOSCOUOu/RpD0JwDcFPZHAyM+PdfV813p+0Ngrwh?=
 =?us-ascii?Q?/H1zSG733QwcGBbTprrWR/psuaqRhPxkKVTJhrxOKzlyQnUFfOz9H5Jv1oIp?=
 =?us-ascii?Q?rYqEEcuyoWJ1KhHpG6j3bI/LKPsVa4vu98JEwEW4Lp11/H6jSx9v6kZH2QO0?=
 =?us-ascii?Q?YGHdGu03OWKfi3JXQMkFn1d89Itk9U0jU4BU0CQhi1ov6VD3BESfXSk3V2R4?=
 =?us-ascii?Q?SjA=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b8bbc0-a0a0-4070-38cf-08dd309d6d4d
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8434.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 11:04:46.0012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5532

Bypass the entry when ofs is equal to dev->reg.map[i].size.
Without this patch, it would get incorrect register mapping when the CR
address is located at the boundary of an entry.

SDK patch: https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/1a559ba2935fcf54eb1867e6ecd1ef7a2d2d0af8/autobuild/unified/filogic/mac80211/24.10/files/package/kernel/mt76/patches/0008-mtk-mt76-mt7996-fix-register-mapping.patch

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index f9aa12866a2e..9a65ddf8236a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -177,7 +177,7 @@ static u32 __mt7996_reg_addr(struct mt7996_dev *dev, u32 addr)
 			continue;
 
 		ofs = addr - dev->reg.map[i].phys;
-		if (ofs > dev->reg.map[i].size)
+		if (ofs >= dev->reg.map[i].size)
 			continue;
 
 		return dev->reg.map[i].mapped + ofs;
-- 
2.43.0


