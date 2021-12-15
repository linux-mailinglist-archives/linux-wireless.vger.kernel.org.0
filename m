Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F75347548F
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Dec 2021 09:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240907AbhLOIqY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Dec 2021 03:46:24 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:49578 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240899AbhLOIqX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Dec 2021 03:46:23 -0500
X-UUID: fd41415a60b64303aa4e35c79c7a046d-20211215
X-UUID: fd41415a60b64303aa4e35c79c7a046d-20211215
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <meichia.chiu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 105346643; Wed, 15 Dec 2021 16:46:20 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 15 Dec 2021 16:46:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Dec 2021 16:46:19 +0800
From:   MeiChia Chiu <MeiChia.Chiu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Money Wang <Money.Wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        MeiChia Chiu <meichia.chiu@mediatek.com>
Subject: [PATCH v4] mt76: mt7915: add mu-mimo and ofdma debugfs knobs
Date:   Wed, 15 Dec 2021 16:45:30 +0800
Message-ID: <20211215084530.5427-1-MeiChia.Chiu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: MeiChia Chiu <meichia.chiu@mediatek.com>

Add mu-mimo and ofdma packet counters statistics.
The statistics are clear on read.

Reviewed-by: Money Wang <Money.Wang@mediatek.com>
Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: MeiChia Chiu <meichia.chiu@mediatek.com>
---
v2:
-use u64 total_ppdu_cnt to avoid overflow
-update commit message
v3:
update printf format
v4:
-remove the ratio
-add new total count
---
 .../net/wireless/mediatek/mt76/mt7915/debugfs.c | 223 ++++++++++++++++++++++++++++++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c     |  41 +++++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.h     |  45 ++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mt7915.h  |   3 +
 4 files changed, 311 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index a15aa256..8c7c15a3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -81,6 +81,225 @@ mt7915_radar_trigger(void *data, u64 val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_radar_trigger, NULL,
 			 mt7915_radar_trigger, "%lld\n");
 
+static int
+mt7915_muru_debug_set(void *data, u64 val)
+{
+	struct mt7915_dev *dev = data;
+
+	dev->muru_debug = val;
+	mt7915_mcu_muru_debug_set(dev, data);
+
+	return 0;
+}
+
+static int
+mt7915_muru_debug_get(void *data, u64 *val)
+{
+	struct mt7915_dev *dev = data;
+
+	*val = dev->muru_debug;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_muru_debug, mt7915_muru_debug_get,
+			 mt7915_muru_debug_set, "%lld\n");
+
+static int mt7915_muru_stats_show(struct seq_file *file, void *data)
+{
+	struct mt7915_phy *phy = file->private;
+	struct mt7915_dev *dev = phy->dev;
+	struct mt7915_mcu_muru_stats mu_stats = {};
+	static const char * const dl_non_he_type[] = {
+		"CCK", "OFDM", "HT MIX", "HT GF",
+		"VHT SU", "VHT 2MU", "VHT 3MU", "VHT 4MU"
+	};
+	static const char * const dl_he_type[] = {
+		"HE SU", "HE EXT", "HE 2MU", "HE 3MU", "HE 4MU",
+		"HE 2RU", "HE 3RU", "HE 4RU", "HE 5-8RU", "HE 9-16RU",
+		"HE >16RU"
+	};
+	static const char * const ul_he_type[] = {
+		"HE 2MU", "HE 3MU", "HE 4MU", "HE SU", "HE 2RU",
+		"HE 3RU", "HE 4RU", "HE 5-8RU", "HE 9-16RU", "HE >16RU"
+	};
+	int ret, i;
+	u64 total_ppdu_cnt, sub_total_cnt;
+
+	if (!dev->muru_debug) {
+		seq_puts(file, "Please enable muru_debug first.\n");
+		return 0;
+	}
+
+	mutex_lock(&dev->mt76.mutex);
+
+	ret = mt7915_mcu_muru_debug_get(phy, &mu_stats);
+	if (ret)
+		goto exit;
+
+	/* Non-HE Downlink*/
+	seq_puts(file, "[Non-HE]\nDownlink\nData Type:  ");
+
+	for (i = 0; i < 5; i++)
+		seq_printf(file, "%8s | ", dl_non_he_type[i]);
+
+#define __dl_u32(s)     le32_to_cpu(mu_stats.dl.s)
+	seq_puts(file, "\nTotal Count:");
+	seq_printf(file, "%8u | %8u | %8u | %8u | %8u | ",
+		   __dl_u32(cck_cnt),
+		   __dl_u32(ofdm_cnt),
+		   __dl_u32(htmix_cnt),
+		   __dl_u32(htgf_cnt),
+		   __dl_u32(vht_su_cnt));
+
+	seq_puts(file, "\nDownlink MU-MIMO\nData Type:  ");
+
+	for (i = 5; i < 8; i++)
+		seq_printf(file, "%8s | ", dl_non_he_type[i]);
+
+	seq_puts(file, "\nTotal Count:");
+	seq_printf(file, "%8u | %8u | %8u | ",
+		   __dl_u32(vht_2mu_cnt),
+		   __dl_u32(vht_3mu_cnt),
+		   __dl_u32(vht_4mu_cnt));
+
+	sub_total_cnt = __dl_u32(vht_2mu_cnt) +
+		__dl_u32(vht_3mu_cnt) +
+		__dl_u32(vht_4mu_cnt);
+
+	seq_printf(file, "\nTotal non-HE MU-MIMO DL PPDU count: %lld",
+		   sub_total_cnt);
+
+	total_ppdu_cnt = sub_total_cnt +
+		__dl_u32(cck_cnt) +
+		__dl_u32(ofdm_cnt) +
+		__dl_u32(htmix_cnt) +
+		__dl_u32(htgf_cnt) +
+		__dl_u32(vht_su_cnt);
+
+	seq_printf(file, "\nAll non-HE DL PPDU count: %lld", total_ppdu_cnt);
+
+	/* HE Downlink */
+	seq_puts(file, "\n\n[HE]\nDownlink\nData Type:  ");
+
+	for (i = 0; i < 2; i++)
+		seq_printf(file, "%8s | ", dl_he_type[i]);
+
+	seq_puts(file, "\nTotal Count:");
+	seq_printf(file, "%8u | %8u | ",
+		   __dl_u32(he_su_cnt),
+		   __dl_u32(he_ext_su_cnt));
+
+	seq_puts(file, "\nDownlink MU-MIMO\nData Type:  ");
+
+	for (i = 2; i < 5; i++)
+		seq_printf(file, "%8s | ", dl_he_type[i]);
+
+	seq_puts(file, "\nTotal Count:");
+	seq_printf(file, "%8u | %8u | %8u | ",
+		   __dl_u32(he_2mu_cnt),
+		   __dl_u32(he_3mu_cnt),
+		   __dl_u32(he_4mu_cnt));
+
+	seq_puts(file, "\nDownlink OFDMA\nData Type:  ");
+
+	for (i = 5; i < 11; i++)
+		seq_printf(file, "%8s | ", dl_he_type[i]);
+
+	seq_puts(file, "\nTotal Count:");
+	seq_printf(file, "%8u | %8u | %8u | %8u | %9u | %8u | ",
+		   __dl_u32(he_2ru_cnt),
+		   __dl_u32(he_3ru_cnt),
+		   __dl_u32(he_4ru_cnt),
+		   __dl_u32(he_5to8ru_cnt),
+		   __dl_u32(he_9to16ru_cnt),
+		   __dl_u32(he_gtr16ru_cnt));
+
+	sub_total_cnt = __dl_u32(he_2mu_cnt) +
+		__dl_u32(he_3mu_cnt) +
+		__dl_u32(he_4mu_cnt);
+	total_ppdu_cnt = sub_total_cnt;
+
+	seq_printf(file, "\nTotal HE MU-MIMO DL PPDU count: %lld",
+		   sub_total_cnt);
+
+	sub_total_cnt = __dl_u32(he_2ru_cnt) +
+		__dl_u32(he_3ru_cnt) +
+		__dl_u32(he_4ru_cnt) +
+		__dl_u32(he_5to8ru_cnt) +
+		__dl_u32(he_9to16ru_cnt) +
+		__dl_u32(he_gtr16ru_cnt);
+	total_ppdu_cnt += sub_total_cnt;
+
+	seq_printf(file, "\nTotal HE OFDMA DL PPDU count: %lld",
+		   sub_total_cnt);
+
+	total_ppdu_cnt += __dl_u32(he_su_cnt) +
+		__dl_u32(he_ext_su_cnt);
+
+	seq_printf(file, "\nAll HE DL PPDU count: %lld", total_ppdu_cnt);
+#undef __dl_u32
+
+	/* HE Uplink */
+	seq_puts(file, "\n\nUplink");
+	seq_puts(file, "\nTrigger-based Uplink MU-MIMO\nData Type:  ");
+
+	for (i = 0; i < 3; i++)
+		seq_printf(file, "%8s | ", ul_he_type[i]);
+
+#define __ul_u32(s)     le32_to_cpu(mu_stats.ul.s)
+	seq_puts(file, "\nTotal Count:");
+	seq_printf(file, "%8u | %8u | %8u | ",
+		   __ul_u32(hetrig_2mu_cnt),
+		   __ul_u32(hetrig_3mu_cnt),
+		   __ul_u32(hetrig_4mu_cnt));
+
+	seq_puts(file, "\nTrigger-based Uplink OFDMA\nData Type:  ");
+
+	for (i = 3; i < 10; i++)
+		seq_printf(file, "%8s | ", ul_he_type[i]);
+
+	seq_puts(file, "\nTotal Count:");
+	seq_printf(file, "%8u | %8u | %8u | %8u | %8u | %9u |  %7u | ",
+		   __ul_u32(hetrig_su_cnt),
+		   __ul_u32(hetrig_2ru_cnt),
+		   __ul_u32(hetrig_3ru_cnt),
+		   __ul_u32(hetrig_4ru_cnt),
+		   __ul_u32(hetrig_5to8ru_cnt),
+		   __ul_u32(hetrig_9to16ru_cnt),
+		   __ul_u32(hetrig_gtr16ru_cnt));
+
+	sub_total_cnt = __ul_u32(hetrig_2mu_cnt) +
+		__ul_u32(hetrig_3mu_cnt) +
+		__ul_u32(hetrig_4mu_cnt);
+	total_ppdu_cnt = sub_total_cnt;
+
+	seq_printf(file, "\nTotal HE MU-MIMO UL TB PPDU count: %lld",
+		   sub_total_cnt);
+
+	sub_total_cnt = __ul_u32(hetrig_2ru_cnt) +
+		__ul_u32(hetrig_3ru_cnt) +
+		__ul_u32(hetrig_4ru_cnt) +
+		__ul_u32(hetrig_5to8ru_cnt) +
+		__ul_u32(hetrig_9to16ru_cnt) +
+		__ul_u32(hetrig_gtr16ru_cnt);
+	total_ppdu_cnt += sub_total_cnt;
+
+	seq_printf(file, "\nTotal HE OFDMA UL TB PPDU count: %lld",
+		   sub_total_cnt);
+
+	total_ppdu_cnt += __ul_u32(hetrig_su_cnt);
+
+	seq_printf(file, "\nAll HE UL TB PPDU count: %lld\n", total_ppdu_cnt);
+#undef __ul_u32
+
+exit:
+	mutex_unlock(&dev->mt76.mutex);
+
+	return ret;
+}
+DEFINE_SHOW_ATTRIBUTE(mt7915_muru_stats);
+
 static int
 mt7915_fw_debug_wm_set(void *data, u64 val)
 {
@@ -528,7 +747,9 @@ int mt7915_init_debugfs(struct mt7915_phy *phy)
 	dir = mt76_register_debugfs_fops(phy->mt76, NULL);
 	if (!dir)
 		return -ENOMEM;
-
+	debugfs_create_file("muru_debug", 0600, dir, dev, &fops_muru_debug);
+	debugfs_create_file("muru_stats", 0400, dir, phy,
+			    &mt7915_muru_stats_fops);
 	debugfs_create_file("hw-queues", 0400, dir, phy,
 			    &mt7915_hw_queues_fops);
 	debugfs_create_file("xmit-queues", 0400, dir, phy,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 73a11448..a32d2199 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2993,6 +2993,47 @@ int mt7915_mcu_fw_dbg_ctrl(struct mt7915_dev *dev, u32 module, u8 level)
 				 sizeof(data), false);
 }
 
+int mt7915_mcu_muru_debug_set(struct mt7915_dev *dev, bool enabled)
+{
+	struct {
+		__le32 cmd;
+		u8 enable;
+	} data = {
+		.cmd = cpu_to_le32(MURU_SET_TXC_TX_STATS_EN),
+		.enable = enabled,
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(MURU_CTRL), &data,
+				sizeof(data), false);
+}
+
+int mt7915_mcu_muru_debug_get(struct mt7915_phy *phy, void *ms)
+{
+	struct mt7915_dev *dev = phy->dev;
+	struct sk_buff *skb;
+	struct mt7915_mcu_muru_stats *mu_stats =
+				(struct mt7915_mcu_muru_stats *)ms;
+	int ret;
+
+	struct {
+		__le32 cmd;
+		u8 band_idx;
+	} req = {
+		.cmd = cpu_to_le32(MURU_GET_TXC_TX_STATS),
+		.band_idx = phy != &dev->phy,
+	};
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_EXT_CMD(MURU_CTRL),
+					&req, sizeof(req), true, &skb);
+	if (ret)
+		return ret;
+
+	memcpy(mu_stats, skb->data, sizeof(struct mt7915_mcu_muru_stats));
+	dev_kfree_skb(skb);
+
+	return 0;
+}
+
 static int mt7915_mcu_set_mwds(struct mt7915_dev *dev, bool enabled)
 {
 	struct {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 4636b7dc..60b18457 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -44,6 +44,13 @@ enum {
 	MCU_EXT_EVENT_RDD_REPORT = 0x3a,
 	MCU_EXT_EVENT_CSA_NOTIFY = 0x4f,
 	MCU_EXT_EVENT_BCC_NOTIFY = 0x75,
+	MCU_EXT_EVENT_MURU_CTRL = 0x9f,
+};
+
+/* tx cmd tx statistics */
+enum {
+	MURU_SET_TXC_TX_STATS_EN = 150,
+	MURU_GET_TXC_TX_STATS = 151,
 };
 
 enum {
@@ -206,6 +213,44 @@ struct mt7915_mcu_tx {
 	struct edca edca[IEEE80211_NUM_ACS];
 } __packed;
 
+struct mt7915_mcu_muru_stats {
+	__le32 event_id;
+	struct {
+		__le32 cck_cnt;
+		__le32 ofdm_cnt;
+		__le32 htmix_cnt;
+		__le32 htgf_cnt;
+		__le32 vht_su_cnt;
+		__le32 vht_2mu_cnt;
+		__le32 vht_3mu_cnt;
+		__le32 vht_4mu_cnt;
+		__le32 he_su_cnt;
+		__le32 he_ext_su_cnt;
+		__le32 he_2ru_cnt;
+		__le32 he_2mu_cnt;
+		__le32 he_3ru_cnt;
+		__le32 he_3mu_cnt;
+		__le32 he_4ru_cnt;
+		__le32 he_4mu_cnt;
+		__le32 he_5to8ru_cnt;
+		__le32 he_9to16ru_cnt;
+		__le32 he_gtr16ru_cnt;
+	} dl;
+
+	struct {
+		__le32 hetrig_su_cnt;
+		__le32 hetrig_2ru_cnt;
+		__le32 hetrig_3ru_cnt;
+		__le32 hetrig_4ru_cnt;
+		__le32 hetrig_5to8ru_cnt;
+		__le32 hetrig_9to16ru_cnt;
+		__le32 hetrig_gtr16ru_cnt;
+		__le32 hetrig_2mu_cnt;
+		__le32 hetrig_3mu_cnt;
+		__le32 hetrig_4mu_cnt;
+	} ul;
+};
+
 #define WMM_AIFS_SET		BIT(0)
 #define WMM_CW_MIN_SET		BIT(1)
 #define WMM_CW_MAX_SET		BIT(2)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 10e43307..ec62c299 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -273,6 +273,7 @@ struct mt7915_dev {
 
 	bool dbdc_support;
 	bool flash_mode;
+	bool muru_debug;
 	bool ibf;
 	u8 fw_debug_wm;
 	u8 fw_debug_wa;
@@ -527,6 +528,8 @@ int mt7915_dfs_init_radar_detector(struct mt7915_phy *phy);
 void mt7915_set_stream_he_caps(struct mt7915_phy *phy);
 void mt7915_set_stream_vht_txbf_caps(struct mt7915_phy *phy);
 void mt7915_update_channel(struct mt76_phy *mphy);
+int mt7915_mcu_muru_debug_set(struct mt7915_dev *dev, bool enable);
+int mt7915_mcu_muru_debug_get(struct mt7915_phy *phy, void *ms);
 int mt7915_init_debugfs(struct mt7915_phy *phy);
 #ifdef CONFIG_MAC80211_DEBUGFS
 void mt7915_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-- 
2.29.2

