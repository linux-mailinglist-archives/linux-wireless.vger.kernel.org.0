Return-Path: <linux-wireless+bounces-10960-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 918D6947B2D
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 14:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 032C3B21019
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 12:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7658F14AD0C;
	Mon,  5 Aug 2024 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="j80xNprK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010010.outbound.protection.outlook.com [52.103.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51132139CE3;
	Mon,  5 Aug 2024 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722861840; cv=fail; b=Nnf96ZuCTJSt/nCxwzRkqEPpyarPY+tNnNKwo6MhJSuOJPdCjSfQnF0tGckNvQT55GbSFT2clYdJV1yYH/1Qi6Lmox569ThxWf4Z1kPZ6VhO3tCy7blx52dCRQthr8UN37Q1bhn7A3zyQbXeJgOgmlv5RlG+I/+cclQyTq08ubI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722861840; c=relaxed/simple;
	bh=hXN275ds+GzvzufxDawHiTgElQcqBK6hGoE9KJIXHH8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uoNKOu+JYQj+8ArGQevQcjXo3iF6/bJeEEoaG6UbkbWgNRu0hllKO/eQhljidT1m8LNgQ6TRisQ5mMlPdbSdIKeBoncJ0++Cb10bUH3dxU+rs657fS/4YKP4Ua2bwdKXKIf+2WEoJoXoBqGcGVSJOsiMcmFR1NZLbPatPQUx0GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=j80xNprK; arc=fail smtp.client-ip=52.103.43.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7Dv2VuVlWjkAECAqdPwlvCFXQAn1kvsgH5mI/IIlzE6965OTWuqDwNGdHjmVOR4qsUIu7O3N4KFmG/M0GDGY0T7oXgqs9DJMUYhSmutPHurG3/wHqljE9TkmPeCOlSPIm5v64k4tmLOhpaueV5QFsnziIKZ5/7eFXw0UOO4ZSI3ui9rtv+pcb6AS3xw073tqGg+lmDrYTz2wlhfYAGBP5n7YmJCdQcVjPh4iatkAWLSbMkgIMRWQfc5OdmeAnTjb1wZct/+c5uPTPeNiA22LWBbzrI717SGuJRUwADLFT5oXa/HtEdNp+G6oG95IbAc4D0lZNYbFu/AuPVhqmjbUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aw/7ECbTJCobELTy7rlnr+q/BVCegcB9U6GRoczAgh0=;
 b=lfspCJDIaNPd16Sx6GSKsIu7Fp/f7xLauravNY0AoHcaGBI6AqW9nzld2XsNWWaCCsS6VSX6NXmPwscwiSIlPbxKbuT0KsXTQ40QCg0IF0+TBGo+Qw0vuBmuGDcr4+Y7Hz3XBCCWj/sZT9qNwv3pd3nFxK3s7C0hfMVPzZzF7ZtTFgIGXwKF+DslDTBH1v46ssKeGl0U2BplkTm3Pv2iV3SjJIQMfTFViKQW6SslqSf62M7C1vaUozz4PqzBEPYzF6GADyJOpb351NGPtuLQMfNSueWCQRs7rMJthdJ0QfXDDELhGPBbhZhqM5RPH/zf1U2zGEfFoP6O2a4wSRATnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aw/7ECbTJCobELTy7rlnr+q/BVCegcB9U6GRoczAgh0=;
 b=j80xNprKc9NquEA+BOEx2kuSEUST+AFJiBPb6cVpq9IqDTuyBGcHVfNZS8g8Z1Kj8qAGU2PQrRNI0KGN7zCTlBqpYqwW2GwoysUVHPVzwiB4VzSPWiuPJSVfHrFwyr1QwMy1qNZQxsVmXAb/TKlXVixxMjKb9s4ispkgIoHux30RyQ/+EO4Qq5DAYOg93OT9QeWe2XDec4pYksGKHfmgY1BeE9D26uF1Pxb6LnCSwpzwQJbFWqB9BagAUcS58z8Sq2zV9gKH8ExjDZdu79Go4ryLS+KX1wHyyhOoWgTMoJzkw0dD0sjmh3CXsmbk+rZVp7GrWp4o8cEulZMd7CoqpQ==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by OSCP286MB4841.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:34a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 12:43:51 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::85b8:3d49:3d3e:2b3]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::85b8:3d49:3d3e:2b3%6]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 12:43:51 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	daniel@makrotopia.org,
	miriam.rachel.korenblit@intel.com,
	money.wang@mediatek.com,
	StanleyYP.Wang@mediatek.com,
	meichia.chiu@mediatek.com,
	chui-hao.chiu@mediatek.com,
	johannes.berg@intel.com,
	quic_adisi@quicinc.com,
	sujuan.chen@mediatek.com,
	allen.ye@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Shengyu Qu <wiagn233@outlook.com>,
	Bo Jiao <bo.jiao@mediatek.com>
Subject: [PATCH v6] wifi: mt76: mt7915: add wds support when wed is enabled
Date: Mon,  5 Aug 2024 20:43:14 +0800
Message-ID:
 <TY3P286MB26111E4DB0841A176DF8E44E98BE2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [7abwjcHGKJXBhzqOoJ61g+TJqxmxtSmq]
X-ClientProxiedBy: SG2P153CA0041.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::10)
 To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <20240805124314.8443-1-wiagn233@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|OSCP286MB4841:EE_
X-MS-Office365-Filtering-Correlation-Id: 431bdf28-0320-4985-2fb6-08dcb54c41ea
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|5072599009|8060799006|461199028|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	rJT6wvQqtuNv6UgpF/B8DYTj9j3WwPDUHCU0FV1ljGM/uQZY5qUE+rHohTvfUKGJvh4va9X0sTSGv+OX3+CPyjGRftYrYI8J+SrmGk2BsMgmvoTc39enDC/Irg4D3HD83BwsJKxCtakvi05cqjqYrziqVGyTh5D6GoSXX5+ha48gghq3fT0f/2JndVlkIUTK0PaF/j0V5MTfFh9Mj1bOYPcB9vMk+5P+JE9L+G2zUe0nNAB8HVIHIjzYMCzVul8kCzPJ/Xh1IdIGLh+TcZN+ZFcJQVOd5laFDHQg28jZOPgSv2/DXyGTnt3ONvI5lgQd62BqdZ5h3m+dhaLDVvJ1TY+FCWwKNBk7ISIa+mrZfRqqfT/SXS5LPYCsGMJdmqAYoIMQHsrTvdAfvtFGvpJ6qOqpayDxPcI8kluLi+ARZbh+v4xiy90Pcn2Q39vOt2WXbPGvaYUwzgZ/nGBxHdZY/6Noeh8gp9YAa0mC7qbOG5c0fGZhKZfiPNBCy2M1Gn8SoIfnNucZYUTy7O0bhJgKvQDwzgqsPOnB81sOp5UVVWxbtITJA+IaoV+ORWn3xj0cdnlEHOxgNKyx/yERLboXJNwK/201llFi96wJ3OgwZJ8eie8Bh/KCxZUCJsiN4jxeLDFjPlpiNeeXMcu9jI6yEw6VxbG2UsRmMSJpxzefbS5oGFpBfUPfmlu0Jh+vf6TagZXAmwfvUvQaW2U1UF9yvQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MmqCykJr2r6yYCFZq0iD8BlRmtfkoAPxr34/5TcmACrHfvM/lAMgK7+n4B3A?=
 =?us-ascii?Q?ged6x75HvTZcWLRZ4NuBMq2Jo3RyPihStvvLI0xafK5CiVr+lYAdTy15cOIt?=
 =?us-ascii?Q?8bTaJrTgxNAj2yBosuLuchlgOvwPnQHr6tKljJZ2c6Jf34fc8VGgDR9ub28e?=
 =?us-ascii?Q?1BGyrCKjcjvabWXt4NtAzd9s4yeSpubnHzrFF7PpXCvp3pA2Hdtd1bJE/bBS?=
 =?us-ascii?Q?v4rrprkbxMHK8t0bU4Wkb0wgv7BrM8S7MnU2LkXEbTL4QYoZx+F2Q/RQ7qAd?=
 =?us-ascii?Q?S6DXicKX0ATiiwMH8pLwYbROgaUQNFWCfQG8bRwkDasKztWd9NpeFc1W6vGR?=
 =?us-ascii?Q?BJTgqK4eEY5X7YDBM0AkJkU5Sa98ebMwfN0s+zvKPSIrC0FLurecQJY81oqw?=
 =?us-ascii?Q?GtvUaEvfUVqcNxQVttfGnurwzty70IAjt3foOnj5Gt/RiIUMcPW6f3W5Q/xK?=
 =?us-ascii?Q?uLevRH5DOMJgODqMQT2Hjsn0T3Tec60Aj3JRB6bqsyJE6Q0hxa25vPcK/WWj?=
 =?us-ascii?Q?wfs50QejLKPitITl47ugSYyALu426TbdZbgRduAPzsIpnGua/i6PCg5ukNT9?=
 =?us-ascii?Q?UkQU/16rdesK4uxu1ZFmWuY6Dj+0HMt7bxoAgY+Om8q8E59FWkWHqWsvtpDP?=
 =?us-ascii?Q?rFb0IYbjY7trTtOIClSxF+So9AakGWwuyDR//kbG+2kLORyYA8VpnvwFg4oi?=
 =?us-ascii?Q?tqDhN4JYUMH2zcgEGP1pkbEXU5BywCb4BC7GLmsoGtjyo6nhlF4jeYSpoxk2?=
 =?us-ascii?Q?gdyqlThFCkxK21CnvoqYN5sTvV67CWMyJBJd9/Y82y27Yd/LonrVYpv4K/xw?=
 =?us-ascii?Q?ypdfGzqpju/VhkknVlVgID6nWAU+0ww3Gk9ak2S9bM8RSsSy4BE90lYJS+Dy?=
 =?us-ascii?Q?Cam+MNeEGymQlX/51WjMA8douWQytLSsAtoL7q28ftIYpFIe3ypHSr7OIwgn?=
 =?us-ascii?Q?qGM+FV9cBoAm2YRU9P9ubMRmSMB0dwyEirdvXns2u/HulRPqInlriueIxwwp?=
 =?us-ascii?Q?sd9feoXyVYZA8hsnqjHqagg+Ynoi/VICnrd1Md5OiILxa9S6Z9Pm6MCxZ0Bn?=
 =?us-ascii?Q?AnvdG5UiSqWzZQvTWkIZ29X11sujxfkMIh0ZAtbo61lVy0QUnbvWiU+PeWn7?=
 =?us-ascii?Q?jHOzhgJneZJ9DQKIfx0NLMaaaeptsVu6mpWguSnzG53g941Z3FBk83//T0mX?=
 =?us-ascii?Q?GMoKKaIFvdXZeiroaBp04xcAbOzW8TaG++sOSpJmyef8OeLwtHVi5gNeFr8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 431bdf28-0320-4985-2fb6-08dcb54c41ea
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 12:43:51.1452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB4841

The current WED only supports 256 wcid, whereas mt7986 can support up to
512 entries, so firmware provides a rule to get sta_info by DA when wcid
is set to 0x3ff by txd. Also, WED provides a register to overwrite txd
wcid, that is, wcid[9:8] can be overwritten by 0x3 and wcid[7:0] is set
to 0xff by host driver.

However, firmware is unable to get sta_info from DA as DA != RA for
4addr cases, so firmware and wifi host driver both use wcid (256 - 271)
and (768 ~ 783) for sync up to get correct sta_info.

Currently WDS+WED config is completely broken on MT7986/7981 devices if
without this patch.

Tested-by: Sujuan Chen <sujuan.chen@mediatek.com>
Co-developed-by: Bo Jiao <bo.jiao@mediatek.com>
Signed-off-by: Bo Jiao <bo.jiao@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
Changes since v1:
 - Drop duplicate setting in mmio
 - Reduce the patch size by redefining mt76_wcid_alloc
Changes since v2:
 - Rework wds wcid getting flow
Changes since v3:
 - Rebase to next-20240703
 - Sync with downstream patch
Changes since v4:
 - Rebase to next-20240802
Changes since v5:
 - Fixed build test error reported by robot
 - Rebase to next-20240805
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  9 +++++
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 32 ++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 18 +++++++--
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  1 +
 drivers/net/wireless/mediatek/mt76/util.c     | 37 +++++++++++++++++--
 drivers/net/wireless/mediatek/mt76/util.h     |  7 +++-
 6 files changed, 93 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 4a58a78d5ed25..1186a4998faff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -28,6 +28,9 @@
 
 #define MT76_TOKEN_FREE_THR	64
 
+#define MT76_WED_WDS_MIN    256
+#define MT76_WED_WDS_MAX    272
+
 #define MT_QFLAG_WED_RING	GENMASK(1, 0)
 #define MT_QFLAG_WED_TYPE	GENMASK(4, 2)
 #define MT_QFLAG_WED		BIT(5)
@@ -71,6 +74,12 @@ enum mt76_wed_type {
 	MT76_WED_RRO_Q_IND,
 };
 
+enum mt76_wed_state {
+	MT76_WED_DEFAULT,
+	MT76_WED_ACTIVE,
+	MT76_WED_WDS_ACTIVE,
+};
+
 struct mt76_bus_ops {
 	u32 (*rr)(struct mt76_dev *dev, u32 offset);
 	void (*wr)(struct mt76_dev *dev, u32 offset, u32 val);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 049223df9beb1..dc4d87e004a0f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -745,8 +745,15 @@ int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	bool ext_phy = mvif->phy != &dev->phy;
 	int ret, idx;
 	u32 addr;
+	u8 flags = MT76_WED_DEFAULT;
 
-	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7915_WTBL_STA);
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
+	    !is_mt7915(&dev->mt76)) {
+		flags = test_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags) ?
+		       MT76_WED_WDS_ACTIVE : MT76_WED_ACTIVE;
+	}
+
+	idx = __mt76_wcid_alloc(mdev->wcid_mask, MT7915_WTBL_STA, flags);
 	if (idx < 0)
 		return -ENOSPC;
 
@@ -1201,12 +1208,27 @@ static void mt7915_sta_set_4addr(struct ieee80211_hw *hw,
 {
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+	int min = MT76_WED_WDS_MIN, max = MT76_WED_WDS_MAX;
 
 	if (enabled)
 		set_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags);
 	else
 		clear_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags);
 
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
+	    !is_mt7915(&dev->mt76) &&
+	    (msta->wcid.idx < min || msta->wcid.idx > max - 1)) {
+		struct ieee80211_sta *pre_sta;
+
+		pre_sta = kzalloc(sizeof(*sta) + sizeof(*msta), GFP_KERNEL);
+		mt76_sta_pre_rcu_remove(hw, vif, sta);
+		memmove(pre_sta, sta, sizeof(*sta) + sizeof(*msta));
+		mt7915_sta_add(hw, vif, sta);
+		synchronize_rcu();
+		mt7915_sta_remove(hw, vif, pre_sta);
+		kfree(pre_sta);
+	}
+
 	mt76_connac_mcu_wtbl_update_hdr_trans(&dev->mt76, vif, sta);
 }
 
@@ -1644,15 +1666,19 @@ mt7915_net_fill_forward_path(struct ieee80211_hw *hw,
 	if (!mtk_wed_device_active(wed))
 		return -ENODEV;
 
-	if (msta->wcid.idx > 0xff)
+	if (msta->wcid.idx > MT7915_WTBL_STA)
 		return -EIO;
 
 	path->type = DEV_PATH_MTK_WDMA;
 	path->dev = ctx->dev;
 	path->mtk_wdma.wdma_idx = wed->wdma_idx;
 	path->mtk_wdma.bss = mvif->mt76.idx;
-	path->mtk_wdma.wcid = is_mt7915(&dev->mt76) ? msta->wcid.idx : 0x3ff;
 	path->mtk_wdma.queue = phy != &dev->phy;
+	if (test_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags) ||
+	    is_mt7915(&dev->mt76))
+		path->mtk_wdma.wcid = msta->wcid.idx;
+	else
+		path->mtk_wdma.wcid = 0x3ff;
 
 	ctx->dev = NULL;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 2185cd24e2e1c..e74709e4f836d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2352,10 +2352,20 @@ int mt7915_mcu_init_firmware(struct mt7915_dev *dev)
 	if (ret)
 		return ret;
 
-	if ((mtk_wed_device_active(&dev->mt76.mmio.wed) &&
-	     is_mt7915(&dev->mt76)) ||
-	    !mtk_wed_get_rx_capa(&dev->mt76.mmio.wed))
-		mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(CAPABILITY), 0, 0, 0);
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed)) {
+		if (is_mt7915(&dev->mt76) ||
+		    !mtk_wed_get_rx_capa(&dev->mt76.mmio.wed))
+			ret = mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(CAPABILITY),
+						0, 0, 0);
+		else
+			ret = mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(SET),
+						MCU_WA_PARAM_WED_VERSION,
+						dev->mt76.mmio.wed.rev_id, 0);
+		if (ret)
+			return ret;
+	}
+#endif
 
 	ret = mt7915_mcu_set_mwds(dev, 1);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index b41ac4aaced7f..b2bf5472b2d70 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -279,6 +279,7 @@ enum {
 	MCU_WA_PARAM_CPU_UTIL = 0x0b,
 	MCU_WA_PARAM_RED = 0x0e,
 	MCU_WA_PARAM_RED_SETTING = 0x40,
+	MCU_WA_PARAM_WED_VERSION = 0x32,
 };
 
 enum mcu_mmps_mode {
diff --git a/drivers/net/wireless/mediatek/mt76/util.c b/drivers/net/wireless/mediatek/mt76/util.c
index d6c01a2dd1988..461b74068fc30 100644
--- a/drivers/net/wireless/mediatek/mt76/util.c
+++ b/drivers/net/wireless/mediatek/mt76/util.c
@@ -42,9 +42,11 @@ bool ____mt76_poll_msec(struct mt76_dev *dev, u32 offset, u32 mask, u32 val,
 }
 EXPORT_SYMBOL_GPL(____mt76_poll_msec);
 
-int mt76_wcid_alloc(u32 *mask, int size)
+int __mt76_wcid_alloc(u32 *mask, int size, u8 flag)
 {
 	int i, idx = 0, cur;
+	int min = MT76_WED_WDS_MIN;
+	int max = MT76_WED_WDS_MAX;
 
 	for (i = 0; i < DIV_ROUND_UP(size, 32); i++) {
 		idx = ffs(~mask[i]);
@@ -53,16 +55,45 @@ int mt76_wcid_alloc(u32 *mask, int size)
 
 		idx--;
 		cur = i * 32 + idx;
-		if (cur >= size)
+
+		switch (flag) {
+		case MT76_WED_ACTIVE:
+			if (cur >= min && cur < max)
+				continue;
+
+			if (cur >= size) {
+				u32 end = max - min - 1;
+
+				i = min / 32;
+				idx = ffs(~mask[i] & GENMASK(end, 0));
+				if (!idx)
+					goto error;
+				idx--;
+				cur = min + idx;
+			}
+
 			break;
+		case MT76_WED_WDS_ACTIVE:
+			if (cur < min)
+				continue;
+			if (cur >= max)
+				goto error;
+
+			break;
+		default:
+			if (cur >= size)
+				goto error;
+			break;
+		}
 
 		mask[i] |= BIT(idx);
 		return cur;
 	}
 
+error:
 	return -1;
 }
-EXPORT_SYMBOL_GPL(mt76_wcid_alloc);
+EXPORT_SYMBOL_GPL(__mt76_wcid_alloc);
 
 int mt76_get_min_avg_rssi(struct mt76_dev *dev, bool ext_phy)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/util.h b/drivers/net/wireless/mediatek/mt76/util.h
index 260965dde94cf..99b7263c0a205 100644
--- a/drivers/net/wireless/mediatek/mt76/util.h
+++ b/drivers/net/wireless/mediatek/mt76/util.h
@@ -27,7 +27,12 @@ enum {
 #define MT76_INCR(_var, _size) \
 	(_var = (((_var) + 1) % (_size)))
 
-int mt76_wcid_alloc(u32 *mask, int size);
+int __mt76_wcid_alloc(u32 *mask, int size, u8 flags);
+
+static inline int mt76_wcid_alloc(u32 *mask, int size)
+{
+	return __mt76_wcid_alloc(mask, size, 0);
+}
 
 static inline void
 mt76_wcid_mask_set(u32 *mask, int idx)
-- 
2.34.1


