Return-Path: <linux-wireless+bounces-10059-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A4E929746
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Jul 2024 11:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A7472816F7
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Jul 2024 09:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A277311723;
	Sun,  7 Jul 2024 09:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ark0i0fb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011029.outbound.protection.outlook.com [52.103.43.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CE514277;
	Sun,  7 Jul 2024 09:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720344282; cv=fail; b=LZCt4n58u35P1hmVV73iylwUOf0OiuwT1CgF6qMlUvA5dYwZB2UE/q7ThUxvayUOuZ6Ea2UOEUWL/cHAk0HSNUfvNOQxBJF8HRf8s+4u7kh0PfDhVEX87ocDalImXQYaJ7cPajll3peSEYzIQ4Lypj4xU4ePxHxRNoc4/ikaAdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720344282; c=relaxed/simple;
	bh=uJ7ZIQFnjNRjCsjWnooA0LV3ssF1c+BvPgaueXkio5c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=U8bXykJ6hf6mPt6VR7Cw6TO50qhNB+j8vzh/EscugvhEVsUX0AsxUS3SMNMbbmB5oNv4dRdT5+pSLmp2+9GAYOaVwCoSitCRWR4D9lVHC1cChjFABljCpHcKmBGVT7hnglAvSZ6UX0JRhqGnzwZo39hMdrRaktIhRazKUAi2GiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ark0i0fb; arc=fail smtp.client-ip=52.103.43.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWftMy3+FWEw5o1DsUAR51p8KRmXq1lBxnVFO4UnK3nXhpwHDiV4rx2J1J9pgCXNCbQLFXHu+9CnAC+Z6jKfF5M5duxyV4XzAuas64uKQxjBXuO7bp4le6nd9TmmQztEASRwZL6OQwGrRE6o0v8hWy/o+KXdYz/JI4GyugCNCbudqOy80gd/CveN4kfJwayiYmSigpt2V2o0o7JtpfcOuGRgApFw63Fso/HsPSDlbbliazxE5pgRo2U/Rk5sFq+WDjbw44ubhoQvtJhjDLoivcwvzbwVB4tkiVosunhjYm7ACqDaozX74eMalan40k1N4cvE/BwV8vQWY5ZXa75Pvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jan1ql/L29Rs8eZjF6mvbICM+pY33rdSiq3JuC7mv+8=;
 b=DhH1RyGLP2uX92KTUFoRglyGvctgsXKIV5ObI24l6y5KHEzAjkv9UaTRy6XZ7zL8WtU+YqWH0IysuSbG4xVkWChR0l7ECF73apFQoNR7QUifGRkTKm3Yj4IFAUNoGUeKL0i7YkDv2SiUDMbCsqb41V6fTGutXkQlp/2sl6cUiNTPwqg3lAnNQRy90GFPMg3lr9gwi+ALMzs6swQ5CAXb6gzd9QRyFWKcuu3aIhrnAfffXFb6pWtPzteOPQ43eUhETmb6j0Sxm4qu1KUJaTbw8RvyrBr0gIdevk6s8HAoTni+1M3uz1ta2d5iqg3xOaoSvWMUhqXaOXn5+XafyDPQAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jan1ql/L29Rs8eZjF6mvbICM+pY33rdSiq3JuC7mv+8=;
 b=ark0i0fb/he+Uz48RFDES+B5y2R2Eo4EgjWr03XiNsZC/qLojB5kAsFps54hvnWPjRDTp+L/1w83y/nfR+Z4pNHDheD/hPL1Nv11eMGQ0kz+MXf81NBOi9kgOOw8cwuiR1XczecdERXLug6bXeNdgVWmu8lRlcsWz/pZippI6ySs3frhP4qcjlKhMwB/UAZgQJI9QJKzLgIyNdoGsGoAtUyqK/yZg7+ecdUcLyXIU636ishCxcDypaLhCLFdv/tjmBunNYAfcLustLw1YlM/H3/78+EVaWg8ahxj+bETCdkRvv9oVl2XvHeaK3FxxlxMYwYiAU/Xc+Nry31cpAROkw==
Received: from OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1f3::10)
 by OSZP286MB2346.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Sun, 7 Jul
 2024 09:24:35 +0000
Received: from OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM
 ([fe80::90af:3f0d:73f8:cfeb]) by OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM
 ([fe80::90af:3f0d:73f8:cfeb%6]) with mapi id 15.20.7741.033; Sun, 7 Jul 2024
 09:24:34 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	greearb@candelatech.com,
	chui-hao.chiu@mediatek.com,
	rany_hany@riseup.net,
	meichia.chiu@mediatek.com,
	StanleyYP.Wang@mediatek.com,
	allen.ye@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Shengyu Qu <wiagn233@outlook.com>,
	Sujuan Chen <sujuan.chen@mediatek.com>,
	Bo Jiao <bo.jiao@mediatek.com>
Subject: [PATCH v4] wifi: mt76: mt7915: add wds support when wed is enabled
Date: Sun,  7 Jul 2024 17:22:55 +0800
Message-ID:
 <OS3P286MB259748F6FA6BE628C3295D7498D92@OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [NLeiNRNhpp/5TQTOrK8RLXA1zsCU/w/m]
X-ClientProxiedBy: SG2PR04CA0178.apcprd04.prod.outlook.com
 (2603:1096:4:14::16) To OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f3::10)
X-Microsoft-Original-Message-ID: <20240707092255.14189-1-wiagn233@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB2597:EE_|OSZP286MB2346:EE_
X-MS-Office365-Filtering-Correlation-Id: be804a5d-5583-4d71-347b-08dc9e669d6e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|8060799006|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	1UMAX6O9oXcKtekwUNWTrppbGCs3XJPz4w/fEptHOPwyubXMy7KRCkMFP32geG+40baz+JoegoVDFRHkGxCbZPKfEGYj1TkkgQlb5VUT75Xjc3XEY8MmIZGQ+MV85ooQcez2haNo8JjreJXstTgUxZcrkuBtW/1avnsNeLZAegilJwD8uN/etpUU/7LpLKdjktq0/ATOlygt/5Gx5lSA2nx1gAgT+tn67tuEPkQYD/2Y8V/WqC+V9itk5BciUgN45p5XZ/co0DX6n8xPlgzhWaVgOCfyZFm2my4DhtoWevNkc4dSYaZJs4Di7Q0rSwRBr1cLGX+zWb2r79W72YJE9sUT8BSG1KYiJ+uhOJz4iEuJzI2sohFTxA0pXdkgmVGRqHe3ZvW4VyImgqsAYVLhiKIZG8YQ4ab1dqeAJUNXZIdc1N0L19bCJIk3dp++o49RuLIkDCCdindrMIx9AertYCC4OCKG9k5qNpoPhDoBRoZzr95fOsEzfZw3UlEIMvUDe3LkWNA1U4C7m60eDUCCdheT3RqGhqqwTeOU3bvpBWgEauU49h+qwQ90qXFHyK7dIYVP8sla0JX5L52NkmOchsRFtzP8/2kqjsqs+S5c8KNvrwIyEGqCFrC7DKMJBPuYuvpRrXrqEFjKeMDozga01TlXK5fzOuBrGNrOJL0zCSlmOs8zRA9qCaE7F5pXYalm
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YL6Ah+4/6nH1W8JPrtrs71t7YErUEz971b7LmEr3OJhe5kBOtQxh7bXU0KZC?=
 =?us-ascii?Q?kM73IULUtT2ME9I5S79ZwKqxcI5snALVd+bZ09t4nfHDBu56gf99q1SQ3E6y?=
 =?us-ascii?Q?duTCQbeL1KShEuCmYuKHjuXvKT+p8aX7LgRZ7QTdnydZUScYGP7q84sLWqFz?=
 =?us-ascii?Q?iw2/csH7y9NTQggGAvoUWWao5X0xIx8jLUU6W6GRINWO7vp9bGOhG+49L7aX?=
 =?us-ascii?Q?GeZTD6E8whjwpWLzDQHFTeW8ybKU5EN/puoU6VZ7PO6IzZzHCoLrLK0x8nMw?=
 =?us-ascii?Q?CuKi4urkUYFJ46T04Hn5Hp9YU4hjYkr6f7dA3hH94wt4e5eLQ1pFBs/rYOD5?=
 =?us-ascii?Q?v49a1N9OqKonIYps7LeUIVnDrA8WD7X+fzhmJRLrtu68xoWWjhiugCDaRoh4?=
 =?us-ascii?Q?WFgy10BlIsBljHtHkKcq2TkDLoXED8p4oJfzqtl16hHx6jbkKwVvNzqoPozd?=
 =?us-ascii?Q?raqJy3RNz69u2e+7DPV/Jq2mpoFB7bzG59ol0lEh5vhuspuldpnSuWPg7VX3?=
 =?us-ascii?Q?RbeWttNo3/7zlEyJyez/UKpdlucyEjSGbAM1aelrQ44xg50RQDOXO3BOVThS?=
 =?us-ascii?Q?X2FSP9TFtebdWuS2p9ozo3jLLvw4JM7MKboMU3IPAzaGNgWCdx29n208DX9I?=
 =?us-ascii?Q?A4SIbq3EZgNMy5PmzfFBq0mWjFfg8U5uNaBmBF/sfB5GoF5OxBWQDXi7uGoU?=
 =?us-ascii?Q?j/omEE7aHze5GkWbc9y08KMyQ4qIwFiD6wkW2eERlcOjlhHWwT6tND7fT2Y4?=
 =?us-ascii?Q?nHgUmmjH/Agn7fXdj9nLqHr9FPGuEGYpmKf/w7N+Xh2A8wXhMnaUM68lUu93?=
 =?us-ascii?Q?+EBOCLmkTssxNGqIcGD5vENyzbQS05SSp61coBTJz9qYosv58LnoqkIXB+X/?=
 =?us-ascii?Q?gFMKTYj+vbZAPnjMRoKTASJJiQd6hBHjDllM4GE74sVxyr3ncRpLifcp8LG0?=
 =?us-ascii?Q?tXtfaIwt6hdvliPjqEu5lFJVOZG1XAkGRgOicVg4JLB7shbaQQKVFf4g41/C?=
 =?us-ascii?Q?ik3xtKnJaaNK2czFoJSMYE/C/uYAQOwjagPFLm2V4AYqAhlO7n5lmTp3hqEz?=
 =?us-ascii?Q?EUuQoo/nMH1+PKXepT7FdnHQKRxbyK6BadBDK7fppfMA3lq3h9x7BhMyaWak?=
 =?us-ascii?Q?JzTJlz03C3MzOsJEg0n0+SZOfpUs/y3S4uTmIEVw01Cak7VbL3wmVYgz8WzY?=
 =?us-ascii?Q?hrm1NLnbTP6j+0UFkgLtjEE67J187eS0tNZtvoA8FO/bmxWwxCH6I900tRw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be804a5d-5583-4d71-347b-08dc9e669d6e
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2024 09:24:34.7739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2346

The current WED only supports 256 wcid, whereas mt7986 can support up to
512 entries, so firmware provides a rule to get sta_info by DA when wcid
is set to 0x3ff by txd. Also, WED provides a register to overwrite txd
wcid, that is, wcid[9:8] can be overwritten by 0x3 and wcid[7:0] is set
to 0xff by host driver.

However, firmware is unable to get sta_info from DA as DA != RA for
4addr cases, so firmware and wifi host driver both use wcid (256 - 271)
and (768 ~ 783) for sync up to get correct sta_info.

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
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  9 +++++
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 32 ++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 16 ++++++--
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  1 +
 drivers/net/wireless/mediatek/mt76/util.c     | 37 +++++++++++++++++--
 drivers/net/wireless/mediatek/mt76/util.h     |  7 +++-
 6 files changed, 91 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 15f83b5adac7..fd211f2cf13c 100644
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
index 049223df9beb..dc4d87e004a0 100644
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
index 9599adf104b1..c01d1b40eeef 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2350,10 +2350,18 @@ int mt7915_mcu_init_firmware(struct mt7915_dev *dev)
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
index b41ac4aaced7..b2bf5472b2d7 100644
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
index d6c01a2dd198..461b74068fc3 100644
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
index 260965dde94c..99b7263c0a20 100644
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


