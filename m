Return-Path: <linux-wireless+bounces-20325-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F2EA5F5BF
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 14:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB6A47AFE38
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 13:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BC1267737;
	Thu, 13 Mar 2025 13:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QRP05isH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011030.outbound.protection.outlook.com [52.103.43.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D47267B0F;
	Thu, 13 Mar 2025 13:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741871530; cv=fail; b=up2sPDZbWHtNLa6PPPHYx0aCw3fi6um8Yolwd7zoR9ZvxznI5frR3nBGozz0p2P3Ablgii8fgLgCIe/hc1E7444O/HsirpD6oSgyiku5KfALKvEa8xtHX1BJjyzPKJjmsJ7sDQOd5sMDZyayj7MQ7SiDiaOUo8zrmASBpfJI/dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741871530; c=relaxed/simple;
	bh=jqfZ6fx5MzBwVqtPR4t3d4TblKZS4aAPgxsBQFB2b5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lOkNmKnp5+iJMs7omsfxVTeFusPocb8PSbLtf9UohHq5UuDC/8tOi13WVGm6G3L/YhNGb9vujhnbVD5CxaFs9npO6W6gxl0b+iHjjHY7Hx03QFJJW97IfqBNFBZTO7od7GWa88Lu1SdkDqOavX1k9telcgaobYQJkgkbkH8ogZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QRP05isH; arc=fail smtp.client-ip=52.103.43.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVUlpxOxv7w5dDypCtJtfS7zG0Zg1Kk9LNekVNRzoOeI9upr/LbJLIFpx83D3Zped9KcKoapcrEmll3qk2s0VZ/of0wfUCE88lDWgPUJiyAa9O9xNmnP54HtOXHJl2X0Efq4UmfEiKUDFYc8vAzf8rA7ITDaUXw9RtD0++NkCmw62Wa/xAZ4RTjshynhlbwiZnGYket63C10pLm0qaimgQa3VQdQ4f0jvtK/OeGaIJf++x2UDoIgmXQbJEjRDsq8NJ0eClElpuuo1W8Hb+pSoqITgvF0x/qWLGsjukobg+czV6PRRhK+xGJcAwSRNwC7dASmg6RlLy006pVeK9pNsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=coUtwsGeOyeiVNBV1R58PGVsckk+fK/0iBXL0lL/O/M=;
 b=RTuddb6EWO61xj3AO1ECxksLWme5eyaTd+5eiVpWL/jwiwGFIloE5T319esE9JO+BqcPgqNQTPmmdpqoV9SkI9KWi3IAeLV+gYdAlamWE5N16SWgWdyr1Q51p5A3CwgnGeDH5BXR60WofGkiSOlJtf/d0Sf1sbEaWSnpOIfYZ/QxuaQq9h/lJUpQm2CmG2qnpONR7N6PGUlHg79KAk9JmVgVmpztYRJAvQuPb6TzME+YeD7+7Fk5BsqRUaRatf/CNRNfRy5CANvfhUsejSSqkv+34PAbTe5Z8qG9lH3royr1zK+eUSk43RXcG3Jr3jhdlraGFb7KwseZRryEKog8Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coUtwsGeOyeiVNBV1R58PGVsckk+fK/0iBXL0lL/O/M=;
 b=QRP05isHIBe/JP0A931lxgfK3wAJHn1hXOri0asDQeGN/UQzwRGzG52Xppc+QKKzk2UU8HKCt2bXA427aXczncxJpeVwl7fe7JaptwSFJQEy/zQZynmI9DehmmcJ9mh8tyu2Ie725EzSt1LXV/APfajpMy+SPqCettoGHLy9rKY+y6oJY3jXkjK3Izw4GJ3YPUPjXSAJUCkqNCvjdrC/1jPYLgDC+gBHE2MNSHI+/1melXfQt6YcYS+/hSrQ6fxeTb9oTAiTTdb0HlvX7oQVWj44iAnTNTWxMvEnMcVLpYXdecx5t/zVIidPt9VnSZc6wsNmOSpDvb4afcLNV3wSzQ==
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
 by OS3PR01MB9802.jpnprd01.prod.outlook.com (2603:1096:604:1ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 13:12:04 +0000
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f]) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 13:12:04 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: nbd@nbd.name,
	pkshih@realtek.com,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	johannes@sipsolutions.net,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Shengyu Qu <wiagn233@outlook.com>,
	Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: [PATCH v2] mt76: mt7915: wed: find rx token by physical address
Date: Thu, 13 Mar 2025 21:11:54 +0800
Message-ID:
 <TYCPR01MB843753CE1DBAF4FAEF76B17698D32@TYCPR01MB8437.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PSBPR02CA0001.apcprd02.prod.outlook.com (2603:1096:301::11)
 To TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
X-Microsoft-Original-Message-ID:
 <20250313131154.109012-1-wiagn233@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8437:EE_|OS3PR01MB9802:EE_
X-MS-Office365-Filtering-Correlation-Id: e4743880-1240-4528-d266-08dd6230a5f7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|15080799006|19110799003|5062599005|7092599003|8060799006|461199028|41001999003|19111999003|14041999003|1602099012|10035399004|13041999003|440099028|4302099013|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WjIi0VFgEcXl7VF48G5at67SixuakCZXaTTKdy9M3zbgKhyWY+29tjj2mYNh?=
 =?us-ascii?Q?3GW86bPmenJGojyPiRMVce54/euaKYGzrJUHORbHeFbjHg17HJNOXU4vmZ5E?=
 =?us-ascii?Q?Z38q7l7tsmrBCQvtp1/Tjtu2EhCdzrn6X8Qp8J+uX33n4bVjvTcPW7QPhXV/?=
 =?us-ascii?Q?xvpAYJzftb6oRni0g4ZGSx4Tn4x1FCIO459somjHWvmCPS+2mgkFwt4NxfXy?=
 =?us-ascii?Q?aSiaBqMvf71dfPenhXsC6P3P6DRJsOi79jk8tHkbUzadVHM2SU58LKXN8la0?=
 =?us-ascii?Q?FulciyhNicp9TLwZkm04QwAl8nxFL4qpSZ+jhFgeOFWA5ezav2/V2rMZjwP7?=
 =?us-ascii?Q?ZePczjnQZzfoMsrE1bM6Rl7K3UK7Sw+tIwmwO37KtJP1/jmByRtx10H7NniO?=
 =?us-ascii?Q?eEAMCq2gwCpcSnCzAFUCRUrn9zSOVm6ssKAYN7AiD+M/SGYrUBGuIKQsLeuP?=
 =?us-ascii?Q?cBQr7ZH3pLmNGOFnXnxFiPjrTM4QW984YX7RzGVAYSEqIg1TLDY71fUq9M/8?=
 =?us-ascii?Q?sUKhE7K7pRLnKe1g2/kKsIYzMfgp7hjdBCKW3BYSrX0dzrmAIybGctV/acyI?=
 =?us-ascii?Q?tfUDbwyBjJP+k7xmcTkZbo/XtJtWC6hn/ToVGEjt7+SMXUV7MtF/Ujfk3v4l?=
 =?us-ascii?Q?P/q9JERomDTF326fSlE4sGzG2+gChueAqKfSDGfJtpPX/QSFb16MELMhyWsK?=
 =?us-ascii?Q?C42dqYWw4HP988ZpPJQBNLnriePc1i1+VpPLpEWyClMJsiv/WUWeyqFnQJ7c?=
 =?us-ascii?Q?npMuBo/fpvstdJzm93igx3+JsaQxqmzehaID0BsZTmgKYTRJBYJ7D5AGBEDk?=
 =?us-ascii?Q?gjCauGAWz1mY0oRrLrK4lhUsB3qZANmqiSfsD6gUfoLN2qMPwGF7tperzVQy?=
 =?us-ascii?Q?I2hbIyN7ocRrGIdM5Q2mvifprrk9W2+fuhjQQwYjVTK8iQ5jzEXU8v5ofZAw?=
 =?us-ascii?Q?AVZdj5UzijbTGgYhr2x0iFfNbVgxAefjGPYcxscwn2nd3nwqtem6mrO6VpW6?=
 =?us-ascii?Q?0lB/9cl7OjVS7shK6OelGLw3HddQho8/GpC/kbGcqQhNR3y6rL7sTc0PhtJZ?=
 =?us-ascii?Q?h7N+WTXlFVYThMm/FOsxVoUrkNMdrr2vLKOUgXs/u10f4a6FGtaf4qvLPV+H?=
 =?us-ascii?Q?d3n09Tvwcf+U6/3x7dX6ELNS44wn3whR+XTJR8mIBN0PM+kmiX2sin3YfmMW?=
 =?us-ascii?Q?1NP0emYxXfpH6PDqPpkoev+kldfrYxbwUDaKYq+HKg5SGyogb9shRGcQ7ooo?=
 =?us-ascii?Q?Wt5gG2pOOgAyE7C2zuqxWPJbzJk/SGC6udTvxKf4iioxLBV52OIaGwv06P2D?=
 =?us-ascii?Q?kMXlUJzaQ0Kd27YaPPgxFCTPacz5915zPOusJR57JyQOYnVxgCvlplWadQXR?=
 =?us-ascii?Q?F6kmq2wYKcgHTIYgm8qpsy9XsJNv?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TyQYh82RCkCr7BRUaXOQc22Ls2EYi9bs9XnEo1/2t2lZbcp/UI7snsOwX5/E?=
 =?us-ascii?Q?zcCA8bu//Sl27cg3OfKNVuH0rBOIyV0Ze99EQooPTsuhQnOmjmWRVfQ5CKg+?=
 =?us-ascii?Q?9ZTRgbhSE9UYumxb2IDaYHm1t2SSICCPh92qyn/8SYPGw02GHn4MZ7uQmnpI?=
 =?us-ascii?Q?U7f7BAPLe7Kpc2T8py/gXBKe3GNbDly7g9Cub6TrcWUEzltEcsAxDH9IrvkA?=
 =?us-ascii?Q?OaidVShCHv0wkWnynlDudjE3slHwX1SNZ8e6SKkPIcKoNNQPtiHkw8ahXGg6?=
 =?us-ascii?Q?BRTFw7yH1k820GHX4kX6Gx1dN1pn1leFxOsLRaBPsuT9DbSpsY8NvrgTD/Ai?=
 =?us-ascii?Q?LuDndM+hVC55ZbYb7ahL7L3a2rdYQUM5TRqBh+LwW/NuPYMifEBoaDj0mOQ3?=
 =?us-ascii?Q?vopc69MzVqz3Dht8cfSxMwD/9tsyX0zbhzMfRtlgy/PQpIt+1hyQ7/xtbZjR?=
 =?us-ascii?Q?o28Ar1D7TJ88JMF41Wd4TrEBOrM500CrPC/2jBspY+obpGz8mY/HZxHu2+Bl?=
 =?us-ascii?Q?mHgk3ZNRNmNmBdaSNQDLkUtGHINCMkZoq1f/uqopBu23BXZmsqkW9123Tp6a?=
 =?us-ascii?Q?eFsUxMnA6GzBwHxTM9EygELC8bkKdx3pPfcx63H+uaj3/3nXlrKvT0OLNz+v?=
 =?us-ascii?Q?xTXGUdZ5wX5OI0x1XuiGgUmeTd0GUm3MDUoYfEENJkCwLurTh15TZele1Nj/?=
 =?us-ascii?Q?D8YRcYK/yEkwx2y+m1jPDO88vEeQ26Zgi1l8v1wXq1HMjit4mNKXvF4lS0ZV?=
 =?us-ascii?Q?4uGpAl6T3ThaKSXb/L74TjN4OA6g9GsqkGayaAinHCCAHZmXvvkZghj96ZKP?=
 =?us-ascii?Q?ed7KOCwwlDieDUd9ZQechJWzW4ahAuCW68/wwIdClpdXDM3BBQVajRrvdpqm?=
 =?us-ascii?Q?L0tugkJ+Qq719Ekbp088LQbjk7O6BAcUEachYL0XGf5atguSgzIwN3ZCOMAk?=
 =?us-ascii?Q?TF121eGTMwd++ll8/5AvWLxxDavHCVwWZXJmwlBHjIt6T+zH4ncwB8rg8kI3?=
 =?us-ascii?Q?/KzJfNISFtZ5+jTLu0GxZWtZ/2wf2gYU1CjvN8OHew6TBu42yyRLI7SuETVu?=
 =?us-ascii?Q?//YNJxEXHn1rfvqXFZEoDu0bXDiVf8S5pdsIRtFDoQmEFx0aRUsw1qcGg9Fa?=
 =?us-ascii?Q?zCu0T2vQq+nG1JBlmaz69dxxsP6Sdw8iIP9hROomAuVkjk7lvAiaCjx5KojD?=
 =?us-ascii?Q?RQCxlnrq0zQgYbM1KeNKA0mR8NrfslCsimzHM0WYHtceMi/9lh4BgO+FLpxv?=
 =?us-ascii?Q?KAhauc1qRQuRxXEhO64hku7ZeIcaFzCMH1XQLIPK1VjmhzezF/mn4V8R+4N0?=
 =?us-ascii?Q?1y4=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4743880-1240-4528-d266-08dd6230a5f7
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8437.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 13:12:04.2102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9802

The token id in RxDMAD may be incorrect when it is not the last frame
due to WED HW bug. Lookup correct token id by physical address in sdp0.

Downstream patch link: https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/737340322ab22b138fd200e020d61ffdbe3e36a9/autobuild/autobuild_5.4_mac80211_release/mt7988_wifi7_mac80211_mlo/package/kernel/mt76/patches/0062-mtk-wifi-mt76-mt7915-wed-find-rx-token-by-physical-a.patch

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
Changes since v1:
 - Reordered code sequence to reversed Xmas tree order
 - Renamed some variables
---
 drivers/net/wireless/mediatek/mt76/dma.c | 26 +++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 844af16ee5513..25893686cbe85 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -445,8 +445,32 @@ mt76_dma_get_buf(struct mt76_dev *dev, struct mt76_queue *q, int idx,
 
 	if (mt76_queue_is_wed_rx(q)) {
 		u32 token = FIELD_GET(MT_DMA_CTL_TOKEN, buf1);
-		struct mt76_txwi_cache *t = mt76_rx_token_release(dev, token);
+		struct mt76_txwi_cache *t;
+		bool found = false;
+		u32 id;
+
+		if (*more) {
+			spin_lock_bh(&dev->rx_token_lock);
+
+			idr_for_each_entry(&dev->rx_token, t, id) {
+				if (t->dma_addr == le32_to_cpu(desc->buf0)) {
+					token = id;
+					found = 1;
+
+					/* Write correct id back to DMA*/
+					u32p_replace_bits(&buf1, id,
+							  MT_DMA_CTL_TOKEN);
+					WRITE_ONCE(desc->buf1, cpu_to_le32(buf1));
+					break;
+				}
+			}
+
+			spin_unlock_bh(&dev->rx_token_lock);
+			if (!found)
+				return NULL;
+		}
 
+		t = mt76_rx_token_release(dev, token);
 		if (!t)
 			return NULL;
 
-- 
2.48.1


