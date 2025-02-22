Return-Path: <linux-wireless+bounces-19324-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E0FA407F0
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Feb 2025 12:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C479422333
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Feb 2025 11:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84EC209693;
	Sat, 22 Feb 2025 11:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gsqDCwTC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011038.outbound.protection.outlook.com [52.103.66.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02BD207E18;
	Sat, 22 Feb 2025 11:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740224317; cv=fail; b=ItQbHlN5DwqAp5JTviPO4ULExekAQ5Xe9y1P8mXTbLUX9wdDM5iAaZ3IPBqBXISxnTKNl87zBPyoxfVhbCud58KizgrfUszFdc5/bogdpp4YpxT+Mbtm3t08bkE9iQcBGpEIAfKosD+9eOheXsN6b3KVcBr0wpfKxdWrNxKE5nQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740224317; c=relaxed/simple;
	bh=M7RJQRynjQyqzPnchgGJdJSMd6JIKLnppQGHywOc4QM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MxAVZikIVfer/PQKc5rvpkltwceqh8K9wVaoO2IBI3Y1t3TPRUFZ79kUhbqkkGqyOe2zuF+T0LtCmKCeA+jdybeo0gJnMahRXj0Alma912q9lzxQduHustC5OJqZ8m2Lr1WHByYAEHViVSdtCpvEqxnSJAFMG0oOLc3UjgBeYBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gsqDCwTC; arc=fail smtp.client-ip=52.103.66.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0OBmW8EN9maWqv7Se+W+kgEZQVNWxwlrRXx+/hcStkzfyAGq/sgxYD+Z2eyCEXpGtt7UozbZfvc3tcOj5w/SYPJOEwSUwR+Dx+xJpfPUtCbns0gilaEHuTWsHR8lWst0wsEIVqhDn4gLEzf/LwbTbn/HwPC9OrPM5Kt/dP/yvhPSzSDnwdRmHWqh2sPHXtsOqfY3q3LL4d9MT8VESfS9HnV0YpxptkusNL4k1IEMs++CBx0LO1XyR+Vft0dcSIf0JABJQFrvHyDXOoOOqOcjx+oWTXeZkFDtyOXYJ91r3PQKSdbxBsJtMgBs7s6iZjU1mPsZbLrLAe52za4/8LSzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ad21MWO3PVvCVn9RQHDRoECV32T9c2wTWkFN8j79BuY=;
 b=vuk2fX6dbXGDh6ByajDapt+UVj+Sgiqb1bzLDW4EQ9PJ5Uf6erdJioNfuB5eRnm9IOZs1cMUk41S82nL/6VcVm75Pfepg5KBOIlLRbZbek6Hqbh8I7iekx4PfO4sKoXhh+mXDT/cbA4Ei/HirxoLVZKxPVdYrW7Loek9NvNKfEnKtm4WnpHMOJvWi/s0J7z46x7lFkjs9Wdx34etlU0O/aYmObI1AglxM6vM0QJL4sny5/17KyM29hdlPf2lTlrXoO+nR5laeoJqe0HE72GeyLIv5MQLy2hzqmnVeUoL65hO4/h259lyggyiE0LaawVSVxNNSqqkhZkKMvimKwTtsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ad21MWO3PVvCVn9RQHDRoECV32T9c2wTWkFN8j79BuY=;
 b=gsqDCwTCLkxxpRk+SKvAR0MoSwhzaE54ugRFKL54c0f5Uvkfvfcz4UTUx03AR79BuZNRLMHsHGKfULpyKmjIVBQ/N9OuoVvb2dLEkGDcsT96beYRsLKtn7nZ3ho4LMuxIs1UgEaMjazMb1oxzhs2Z4cKEb3PRdBi5jCvbmHx5IVXJgC814O8h0iLwUcEk5vfjAk9B9SthYJq8VSV+v9WIPfDWCeUBezq86w4DljCSFS98OXW7PJw4V7FnodxSG8wqJp61aXjUNU8qrynCpUzJl5nN+ayyZ5P2Q7fUSjWQI2VWMprt21n4g/HQ0TlmnkIGHJonhjZwk4wpeRXkhV1Pw==
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
 by TYYPR01MB14294.jpnprd01.prod.outlook.com (2603:1096:405:210::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Sat, 22 Feb
 2025 11:38:17 +0000
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f]) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f%5]) with mapi id 15.20.8466.016; Sat, 22 Feb 2025
 11:38:17 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: johannes@sipsolutions.net,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	Shengyu Qu <wiagn233@outlook.com>,
	Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: [PATCH v1] mt76: mt7915: wed: find rx token by physical address
Date: Sat, 22 Feb 2025 19:38:13 +0800
Message-ID:
 <TYCPR01MB8437EE1595CD4AB581C006E898C62@TYCPR01MB8437.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0153.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::15) To TYCPR01MB8437.jpnprd01.prod.outlook.com
 (2603:1096:400:156::5)
X-Microsoft-Original-Message-ID: <20250222113813.8265-1-wiagn233@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8437:EE_|TYYPR01MB14294:EE_
X-MS-Office365-Filtering-Correlation-Id: ca774258-fc09-4483-eeca-08dd53356657
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599003|5062599005|5072599009|8060799006|15080799006|461199028|19110799003|1602099012|10035399004|13041999003|3412199025|4302099013|440099028|19111999003|41001999003|14041999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DqnKHhX9R60T8BxhYuHcCi/1pXfm3Lfr+lWspo059xjcrQ3+mUtgwgj9wMiG?=
 =?us-ascii?Q?q7pjE0Iie4SGrxq0ACCf5kwsqnOVbWM/yRFS9XlvOQFWJKMj4fFXtSwFNP1d?=
 =?us-ascii?Q?Q4izGvcl1a/liNIkwbe5W+R8iDY85YfOWeyteo701r7r6O14e/eQM6jGeR0N?=
 =?us-ascii?Q?eKGbMxGD2EXj1lHMwFCKm8nqo0zv46nliOTBxi4XvJaYim8iW03GkDUUZLNu?=
 =?us-ascii?Q?fjN0/np3g5AMfTcSwprmuwNoeAaY9ZER6ZivLfnsqYLlF/O0dYrpOwxH5L6a?=
 =?us-ascii?Q?GVVxybQdf/5pmDEmWCoSRHfNTCxvdVWlAxaW8bRDAgj1B7aBUlv2LdEA0cCL?=
 =?us-ascii?Q?8gifCo/Cw1ZgytTShpwfRN4PNbbBU8oY0eWySeojR60F8K6cB5xzCG5JHmo9?=
 =?us-ascii?Q?03aT+7lMT+ifz3T9EeYhPHQrqW5HvxgPNlkMyq6vu5InWWVjHAL1typ/r5TQ?=
 =?us-ascii?Q?6AVwtuKmdJUgJIaW+GZrh+WSo1DGKb9KrbdQn3y6krRSZE1ceZlVYJnqLaDd?=
 =?us-ascii?Q?UVVoeosZnPcNKrVeDYGjGSIUoAo0qptZDuQJZWkQy79y3kpBJQAn1Lcuq2t6?=
 =?us-ascii?Q?VPkyFIzXpBeOm54cLr1XD3dPJTDz4P1fvLxMJ22jdO67bYLzDEsOD8w8bhXX?=
 =?us-ascii?Q?F+rhhFmFz8noxHpFErSB6c4AewdTZdRHxh0nv+mimeCIZCdb3G2jfndeGcrx?=
 =?us-ascii?Q?nYIPUW7DqnUPAIzn6KQaEsGqGEReJdFBq1NyAJlCHZRUMHSD0Lqj3QPl9eK5?=
 =?us-ascii?Q?MU/8PrFfidYuCewBLQ7vV/WwiLTHlosJb7xpcyC6if2tH9Fxvp53sAFB0oI/?=
 =?us-ascii?Q?N9kaT7KKxoFLNt12SnNbDykYRsk4w55sjdObUNOEFehAAWiUEy5pC3g9BymS?=
 =?us-ascii?Q?xJS3y6NW9N5odh1kyPL8ae4j2CyPBrmN5Evp7ADwQos2V74Ztj9IR3L225q/?=
 =?us-ascii?Q?+yLHHeTtjzZDZQY7tcNrUw+WUyN4NoMkX9x1dQLAb5b4QDwdDY9KkexpRkyb?=
 =?us-ascii?Q?xYdNONRlpeQozVlK8NC85wlFjeCclu5jGOIPy/4IjqDVboWXHT0NbyBZ/bBv?=
 =?us-ascii?Q?5EdSc3x90kNDtXzLghtScSMacwK2LyQuQjYtSfkSFbiFq2rbfcwLzWVkwTU3?=
 =?us-ascii?Q?SN82fX7qVmFkXkHbccdF5h3bKsOi5wSdFiJ9CNZQniKC/is3tEG826h8UipO?=
 =?us-ascii?Q?HKEHUbs9U12SUiXDIMme0Ty74Qq72iHlQ3V+qQRoh3Tk2kSHvU4zQhVDiH+m?=
 =?us-ascii?Q?CfpAti4Qt/XWx/JRqWV3xymLaW/pBmsbpAfHuija4zBRAzZr634YWbEMDoC1?=
 =?us-ascii?Q?DDVJ6QnwGPiyJ6Zd6OyL6VK8rFTaGlG3ae843zQWRmPCjmiRS6/O+UiCii3K?=
 =?us-ascii?Q?9K9uCIDJuQNgfQbu7KuInmzn8vxZ?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?42icxF7SlW9PU8Ir63h9hWV0xs/0aYOR/Xk4OmbKDSE5906ALGfpRkQ9OM/U?=
 =?us-ascii?Q?rN0anVxBxXnEN5eBE1Rq3pKfnW/Fntd4QTYYtDRlbijWjMHyp0wQPn6eR0Rr?=
 =?us-ascii?Q?RZ1oZw9VGqGqIP0Rdy/XfBvFRL9YzLJW0eqqYckP55N4oeYbeqj23FKq9Y2E?=
 =?us-ascii?Q?pW1ZcdeMNBnBZekX3OFBELHAoOUbeoSDZpSGVzy6tTlubbsqrN9KAJ6kenjP?=
 =?us-ascii?Q?MMIv9+eR0i841gYXE7pBVf+7HVZc08gCN/Cwt+nUYQTBBNHWzToDKsmFjEgW?=
 =?us-ascii?Q?/gwIbftzT4jyyZSirMcCOOPlAkQM4qO51rU9nU4HKxDsDwNAZuj+JXMXYDBi?=
 =?us-ascii?Q?SeXaPTe76cXFoQDuYPFxYR9sI0wo9ZKhsfKdxh/+ReGbiNeP2SRfcqLzMnwe?=
 =?us-ascii?Q?+fTR2HEnIEAEk+CEpZZab8WC51qrbG/itlo5p92HIVOduqLNEgV4Cs+8bcRK?=
 =?us-ascii?Q?Jmcc34rHFTkmjT94CMr4WqoaLm9h6W+Lx7oE2g/EBfQVhspCZSK0jdhR+1y/?=
 =?us-ascii?Q?XRW1rN37fUjHoEorDZcvGdFP7dx8tA5IiekSxGdb+5lnLyUmwwpVbEaSFCc7?=
 =?us-ascii?Q?UkEvq+yCUHygBbPs/A/bqJFX7Yy++C5z67PKkxwuq1dDqPFR+i4vkWqM4H19?=
 =?us-ascii?Q?3dv2hAOTs1wlXO+mHjLZOIsvzBvjzwAazWoCwgkZzK9aRZXQC5k1EPbEcYae?=
 =?us-ascii?Q?KZvRXEh0ugALe7t86yNo5yu526xbHOIq8DuqhQD+Gdlftwk7r+Ch2ud+a9xQ?=
 =?us-ascii?Q?lxzL1jxz9JuOIYcTWV5kvfNNj3q3mYLP0AXpg88F9cAKJrYc/9hBaer+W/4V?=
 =?us-ascii?Q?ZEaCf177HZMaTfrWgzST+2bJHnbkwjXoslhqmmTmOLXA0xw9Q5Crh4/FFbmP?=
 =?us-ascii?Q?hMLnBZhn5BKcJP9Uk5szqrEUngL5PWFwesLFOT24Eb7tuZdElecWchtamJct?=
 =?us-ascii?Q?cKNvYY9ngQ9LbsEOCQsw108uV7LfoRVokvBGzxWxXkH1S2VlbvI0TmCr70Xa?=
 =?us-ascii?Q?1c6RlhGR1fPKyRc9iOyeiIbBPNMWM3/zPvrbtkuhR8soLCag5W2CFmg+XrA+?=
 =?us-ascii?Q?lPImPpOcYxi/tOL/31OSJ679Xhzxhz4i7ARq/6oRC1RUAm9UND/aDh57bPyl?=
 =?us-ascii?Q?FO0LlCRrdxX7I4UIp7G5BewI1GilYB0JwTm1SWHHrA0C42frGhJn9TeMnia6?=
 =?us-ascii?Q?LhWOPa0LTi6CAnq7vMpvvFhrN3u6K4StrfvEezJ5G0EE9G3YQogRxNG1Chf3?=
 =?us-ascii?Q?UwMvoSaNIpWnzz/R86ITkU7FwxhoJd/AHXc3TirRd87ZNlh8LMihjvXqXTKq?=
 =?us-ascii?Q?wmc=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca774258-fc09-4483-eeca-08dd53356657
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8437.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 11:38:17.5156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB14294

The token id in RxDMAD may be incorrect when it is not the last frame
due to WED HW bug. Lookup correct token id by physical address in sdp0.

Downstream patch link: https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/737340322ab22b138fd200e020d61ffdbe3e36a9/autobuild/autobuild_5.4_mac80211_release/mt7988_wifi7_mac80211_mlo/package/kernel/mt76/patches/0062-mtk-wifi-mt76-mt7915-wed-find-rx-token-by-physical-a.patch

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 25 +++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 844af16ee551..5bf63014263c 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -444,9 +444,32 @@ mt76_dma_get_buf(struct mt76_dev *dev, struct mt76_queue *q, int idx,
 	mt76_dma_should_drop_buf(drop, ctrl, buf1, desc_info);
 
 	if (mt76_queue_is_wed_rx(q)) {
+		u32 id, find = 0;
 		u32 token = FIELD_GET(MT_DMA_CTL_TOKEN, buf1);
-		struct mt76_txwi_cache *t = mt76_rx_token_release(dev, token);
+		struct mt76_txwi_cache *t;
+
+		if (*more) {
+			spin_lock_bh(&dev->rx_token_lock);
+
+			idr_for_each_entry(&dev->rx_token, t, id) {
+				if (t->dma_addr == le32_to_cpu(desc->buf0)) {
+					find = 1;
+					token = id;
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
+			if (!find)
+				return NULL;
+		}
 
+		t = mt76_rx_token_release(dev, token);
 		if (!t)
 			return NULL;
 
-- 
2.43.0


