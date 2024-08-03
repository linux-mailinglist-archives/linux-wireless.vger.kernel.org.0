Return-Path: <linux-wireless+bounces-10878-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 761E0946895
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Aug 2024 09:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF01C1F21525
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Aug 2024 07:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3058614D435;
	Sat,  3 Aug 2024 07:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="grgxsmDE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010006.outbound.protection.outlook.com [52.103.66.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C106A49647;
	Sat,  3 Aug 2024 07:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722671942; cv=fail; b=Y3lOxBYl1pyP36sbfttPSUMMatFI3GvTjy4yxycWC34ZH6CyL81PG1YCWQIBLKTBMpnk6GgXtJP3LF74o/81Ew3mOpEHM8wUXN+mbEYZ8wHwZn3t/9i17bPfHG53xf5RddHT7BZ9cnpfRMQmNHpeFzRanK9MycuxdfltWpxTJ6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722671942; c=relaxed/simple;
	bh=CuK9M9/PUYuBvTRIqTtodNZUOVsMIbOFSZrriK0HIKA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LsVnL/BUi4K3ZqXoe/Ki+yxowMzt6UocER/YB/XKoC4z3lo8N9UNnBrujWY8V21YV0Hmb33Mi8oHFEOarblaOfVjTsriTnbnuc3ifLoP3oqtwxB5xTYMYDFLOQCBAwJTIpNgpRVZCNTRebGtQxMjNnxDkJ2uscqqQH1jq+jtm30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=grgxsmDE; arc=fail smtp.client-ip=52.103.66.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iri7tt+Ifcro90ZU6kFrjgWjDZu3N0IeYvWiqShpcr0cMl+serXaL/rKTa80vn+FhVJbQXpuDO7iGeNR/sz2bDcsiYspH4eu96aeK2B8CXIiEjbnbCS2fd6fMooGZmrDi7NhLQLRSpKWmYm1aQ8vlkGco4N1QiXYPGBDJ7JuNvLWNaOfyohQ4OvRUUBlZ+GFFQN6loPcVIHWWhhNv9tOsB9uCvT9LkHMwPMMBkMmbjpmA+zF+fQtmdlMtusAO5G0QW/Fi610XSlBuzKcgctaaY9W6NhIjsBuLYhTMqSr54ckGmlU32TieSJENMEJc4QQWPA7YaHIyYf3hBtVTLIC7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dDgiw26H7CL8PUNPKTEDkan3UIJI1OgZQQPNVQiHSc=;
 b=jI065XLzHAdQ7fu755AHlVZiOcr1lTfFy/xg5AUT9UkkznWIcCDgD6WHzMO4GaxnZp30xdmYE5G/XACGHBVJpL/Ky/PO5e+NaGbT17/WIoHztkq8q1zn3GcFjFrAw0TMOvAjrn0+7yC08x/dK7zVQ//hJr2BMS3Omz2sAueSAzrNbsLn/bYz7RwxxNfgRJqcZYEuXqseqdNVk5nCE8PMtHJeHM8rYsGwSmw31+fcwuMLJK7MItrXLenDySyhx3RdKSEgV3lFUEMLOPamMC8oJLg+5iFnaB7XzghMyrp7WsV6z69S/yTO5qUZG2elcTGtRKimh4SP1hUb6aJcOWSoow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dDgiw26H7CL8PUNPKTEDkan3UIJI1OgZQQPNVQiHSc=;
 b=grgxsmDEh832FzgTC+8w9lcrsEamIX4zpdklIvlQBb376nv4fd5I855KeOOb0DHJ/AKcevcWevupO9hPfiWiX4UYYNenDzQ5XF6gBQu11UrNx1D7vFyiA7+OxQ9s9e3E/OIKBM31cEhwmz3tHxjusq3JeR0E+Ypg6r4Ap62pg3udlhWr1OZ9QSfP1FQEjXrPngEEE7YarmoG6M8icr+54W28zmpH5oItrHwwhzUgNhuvyb22qkZCXdUeDbNLoX/xblukpEh5SHev7Aecs8y42ip8nwY6S6nKuRJCHperIv/t6viI8D0zvFFkBqcokVWFv+4cA4qz1gFpj+FXjsSt/w==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by OS3P286MB3193.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:20f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Sat, 3 Aug
 2024 07:58:54 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::85b8:3d49:3d3e:2b3]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::85b8:3d49:3d3e:2b3%6]) with mapi id 15.20.7828.023; Sat, 3 Aug 2024
 07:58:54 +0000
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
	emmanuel.grumbach@intel.com,
	StanleyYP.Wang@mediatek.com,
	meichia.chiu@mediatek.com,
	johannes.berg@intel.com,
	quic_adisi@quicinc.com,
	allen.ye@mediatek.com,
	bo.jiao@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Shengyu Qu <wiagn233@outlook.com>,
	Sujuan Chen <sujuan.chen@mediatek.com>
Subject: [PATCH v5] wifi: mt76: mt7915: add wds support when wed is enabled
Date: Sat,  3 Aug 2024 15:58:15 +0800
Message-ID:
 <TY3P286MB2611CB2F4F5FA27D782AA80A98BC2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [c+oOAfQHr8hOBzn6C1UvxpAD1i5lwb6u]
X-ClientProxiedBy: SG2P153CA0051.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::20)
 To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <20240803075815.19128-1-wiagn233@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|OS3P286MB3193:EE_
X-MS-Office365-Filtering-Correlation-Id: e9fb4d5c-3ffa-426c-e171-08dcb3921e0d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|5072599009|8060799006|461199028|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	9QIW7MGR/Odxc3fPlIT7WybcIjscMq4k8Kabo4AjhDxnCOuFjJWOM5yIiy2KIv9XRLm0HOKBcJpUBNHwY/uZtBFHp9906BQk8jhOsxe+sExUaYS3KHH3yT74dWN7cLqLcKzUFzrFllVDQU1+bnMU0ss6HJ7E9hOI3zh4lCjSTkI1p3/0VsnKVHycblLpZfq7pl9rqwaKZ/D8Pu01HcMh1EyONcLu6Rwj2TLNcZdrc4m3kHadBtp3t2dWy8sBexqJKyaV5V0AFtfrZGIyvmmhz9J92CQju3XiobmUb8sccEYwor2xLbLv6YHhxlKkC0yngXVAGISQ+gNDxICw9U9kuc/u6FyDFkV53UkQxRLCSZO+qxsEJCY0KG3NdTilFpAVF8cdCxHaw9hNsFTznH4Kon9FblYTWUszIZvrynW1f1MibsYVe07CRVqzTgM3HzZsG9pzZ9r1lGi8FV8Bu60yUTKYl8gY/oui6EdxVrMDdV6JSrfhGOP0HIY5iYBUyU/SpYO3dHrIfcVPnZgJEi8wn0tu8DxkGE+uFPMQ2u7/5lg7GSdzvBDA5mSd/J9lLtsmv6wyo5+1txiVYcScWiwhToRuU+seFpQoB/9BEQf1Mt8tmD935dqGbXmUBOanP2f0Bp31EYav7D/N3ff+JYmHRsSZ0yqBA8eBMHFhC+KcRLzV8Gg0uTX/et4GTprkRaSsNfFeAI479g/fS/Nla+aBfA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2juLM487vmBeBZi/UT16Iach9OdT2bJyFROGy0IlK+VPKj5dmGcb+zNN1qaF?=
 =?us-ascii?Q?AmX5P2djgDHsBh4onlGG5IyZppaRNnr6eMGqMHv4KlK/cqpntGEU2oC9h0CG?=
 =?us-ascii?Q?GbwWF3e+ptVTf55eCK31sfV7G2NUg8/gsihQjGkYWqV+IR+O4iaJzXiomMD+?=
 =?us-ascii?Q?1CuHLjudYv/8szJCxQ50Ef2l9fuGIK/k5UKA0VnHwbU0Z4/cOtsFQqzWHnSE?=
 =?us-ascii?Q?vz4TuMgqo8h0n05IFQoNVZMQcrfye9OGkaE/oa224m6+6IxaiHOzbBxgTKHe?=
 =?us-ascii?Q?isZIhUp/J7UKHq1+MReQnDJhNypouJvupeQXwcliJuGxlX22VRzAO2LHhRHq?=
 =?us-ascii?Q?1RLa55NL7bFL6+RjfhnYwXB8sViYULCMap2R7qfTR+3YBLPkiIzjQr9wmiwT?=
 =?us-ascii?Q?qldP4Hf2g17BCDB5dSDCsy67xupCj2gooj2oS1IhIJANWTU11o7EhjCSE5k9?=
 =?us-ascii?Q?W3dYC7wDNg9ND8xOZBJRG14ND1iwKh6QTPhA1JPcQN2PkE43cABRUZb9Ktco?=
 =?us-ascii?Q?FEmEO0AswrgTkTYw8hTc8bN18HFVkzOOhqYwNcONWPEtYBSLMLsCbTIWCiT+?=
 =?us-ascii?Q?51Abs9BSbWCpUQyMdYPwM3fa08Ew+NpQ1xqwA7MSU2wWGkBLWChjQim8cvgn?=
 =?us-ascii?Q?NO8TrbZbOXxf7IpWA0NjygiKe/iVOauEoM/JhHRa13DLL17jsqLv3+xjnQt8?=
 =?us-ascii?Q?Hbh3rJZpyrw5ev3MQITpdwtmteq8bioIiaLVICkgyg1zfGH8br6JxB+VxCZJ?=
 =?us-ascii?Q?j757eSbwqPTE708rb5lbOSjailPkowFfLOvs5Qskv4+WwQtJdzdwr1kNFNyQ?=
 =?us-ascii?Q?nlCOHCK9SknImz7Xl/TTfwhk/QQz90jX33BBhSgtQ7MseBsBP/QkLrypch2i?=
 =?us-ascii?Q?434XN1Bd4EIBgeAtARjCeSUYTpNfDfB2imqS32r0tNNgoXOYs3eC8rK7L8Y1?=
 =?us-ascii?Q?49gtsvNlbBzlLzteQCfWlKZ5SUaEfktwzx8RAvMnXu87n2Koyu5EZfMyPcAd?=
 =?us-ascii?Q?k4lKJaBTDzg6ykkcjEAVRbwSuDQtD4irGjPZspYH0EAaFkUNhRgYu5N6Z4SB?=
 =?us-ascii?Q?ODSUKIRD+/boOm1BFKTcuGnWMxCNQNcLU5tfziu4s1nhno+6GhxyfNiUBM8i?=
 =?us-ascii?Q?gX8gBv9P7JCapv5Zl89rtIt8V3dodujs3pC9djtyxwXxf6qGWCwAdryXmdfM?=
 =?us-ascii?Q?O288KRVt/ozjf/tY2tf+RXFqhH/T02ap+VqXpZsHpEpbUeNU3IrZrpVBmy8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9fb4d5c-3ffa-426c-e171-08dcb3921e0d
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2024 07:58:54.5049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB3193

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
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  9 +++++
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 32 ++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 16 ++++++--
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  1 +
 drivers/net/wireless/mediatek/mt76/util.c     | 37 +++++++++++++++++--
 drivers/net/wireless/mediatek/mt76/util.h     |  7 +++-
 6 files changed, 91 insertions(+), 11 deletions(-)

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
index 2185cd24e2e1c..0f715a4c21ada 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2352,10 +2352,18 @@ int mt7915_mcu_init_firmware(struct mt7915_dev *dev)
 	if (ret)
 		return ret;
 
-	if ((mtk_wed_device_active(&dev->mt76.mmio.wed) &&
-	     is_mt7915(&dev->mt76)) ||
-	    !mtk_wed_get_rx_capa(&dev->mt76.mmio.wed))
-		mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(CAPABILITY), 0, 0, 0);
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


