Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904996F79E6
	for <lists+linux-wireless@lfdr.de>; Fri,  5 May 2023 02:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjEEAFx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 20:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjEEAFv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 20:05:51 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B0A12E81
        for <linux-wireless@vger.kernel.org>; Thu,  4 May 2023 17:05:50 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 536F934006B
        for <linux-wireless@vger.kernel.org>; Fri,  5 May 2023 00:05:48 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id C77DA13C2B0;
        Thu,  4 May 2023 17:05:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com C77DA13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1683245147;
        bh=PXBdSAcppOJAVFnUTb2FGG4kppakc4A+QBgbonxb4Pg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d3iofq1U2rvEJSX7CJEStlis1e0GVrOxBODWTPJeVvQgKzMrjQSeYExzlzBBPnmk4
         siJhn7j2TaiRY9ikWfXjosFhcl804rS/3VqRtDCY4C1Sw8nmKUtXZf274lUk8dTXFW
         G1iXFG+tEYIHJuK3KvWJ7Is27aOp4naopskTUgjU=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v2 3/6] wifi: mt76: mt7915: Support setting aid when in monitor mode.
Date:   Thu,  4 May 2023 17:05:40 -0700
Message-Id: <20230505000543.693532-3-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230505000543.693532-1-greearb@candelatech.com>
References: <20230505000543.693532-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1683245149-detOxv7ME8iJ
X-MDID-O: us5;ut7;1683245149;detOxv7ME8iJ;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

The parser expects values in hex.
Syntax: aid color uldl enables

The enables value is a set of flags to enable any/all of the
aid, color, and/or uldl (in that order).
options.  For uldl, 0x1 means upload.
Example, capture aid 11:
echo "b 0 0 1" > /debug/ieee80211/phy0/mt76/he_sniffer_params

Note that you must also enable the group-5 fields in the rx-status
header for he-trig (and he-mu) to show up properly in a packet
capture.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 60 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 35 +++++++++++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    | 10 ++++
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |  9 +++
 4 files changed, 114 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 879884ead660..f9d539bb9077 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -247,6 +247,64 @@ mt7915_muru_debug_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_muru_debug, mt7915_muru_debug_get,
 			 mt7915_muru_debug_set, "%lld\n");
 
+static ssize_t
+mt7915_he_monitor_set(struct file *file, const char __user *user_buf,
+		      size_t count, loff_t *ppos)
+{
+	struct mt7915_phy *phy = file->private_data;
+	char buf[64] = {0};
+	u32 aid, bss_color, uldl, enables;
+	int ret;
+	struct mt7915_dev *dev = phy->dev;
+
+	if (count >= sizeof(buf))
+		return -EINVAL;
+
+	if (copy_from_user(buf, user_buf, count))
+		return -EFAULT;
+
+	ret = sscanf(buf, "%x %x %x %x",
+		     &aid, &bss_color, &uldl, &enables);
+	if (ret != 4)
+		return -EINVAL;
+
+	phy->monitor.cur_aid = aid;
+	phy->monitor.cur_color = bss_color;
+	phy->monitor.cur_uldl = uldl;
+	phy->monitor.cur_enables = enables;
+
+	mutex_lock(&dev->mt76.mutex);
+	mt7915_check_apply_monitor_config(phy);
+	mutex_unlock(&dev->mt76.mutex);
+
+	return count;
+}
+
+static ssize_t
+mt7915_he_monitor_get(struct file *file, char __user *user_buf,
+		      size_t count, loff_t *ppos)
+{
+	struct mt7915_phy *phy = file->private_data;
+	u8 buf[32];
+	int len;
+
+	len = scnprintf(buf, sizeof(buf),
+			"aid: 0x%x bss-color: 0x%x  uldl: 0x%x  enables: 0x%x\n"
+			"  ULDL:  0 is download, 1 is upload\n"
+			"  Enable-bits: 1: AID  2: Color  4: ULDL\n",
+			phy->monitor.cur_aid, phy->monitor.cur_color,
+			phy->monitor.cur_uldl, phy->monitor.cur_enables);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static const struct file_operations mt7915_he_sniffer_ops = {
+	.write = mt7915_he_monitor_set,
+	.read = mt7915_he_monitor_get,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
 static int mt7915_muru_stats_show(struct seq_file *file, void *data)
 {
 	struct mt7915_phy *phy = file->private;
@@ -1230,6 +1288,8 @@ int mt7915_init_debugfs(struct mt7915_phy *phy)
 	debugfs_create_file("tx_stats", 0400, dir, phy, &mt7915_tx_stats_fops);
 	debugfs_create_file("sys_recovery", 0600, dir, phy,
 			    &mt7915_sys_recovery_ops);
+	debugfs_create_file("he_sniffer_params", 0600, dir, phy,
+			    &mt7915_he_sniffer_ops);
 	debugfs_create_file("fw_debug_wm", 0600, dir, dev, &fops_fw_debug_wm);
 	debugfs_create_file("fw_debug_wa", 0600, dir, dev, &fops_fw_debug_wa);
 	debugfs_create_file("fw_debug_bin", 0600, dir, dev, &fops_fw_debug_bin);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 4264ee117e07..f38e4cb4504c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -516,6 +516,40 @@ mt7915_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	return 0;
 }
 
+void mt7915_check_apply_monitor_config(struct mt7915_phy *phy)
+{
+	/* I first thought that this would not work well when combined
+	 * with STA mode, but now I think it will not matter since it appears
+	 * the HEMU rule 1 is only used after normal HE MU operations
+	 * have happened. --Ben
+	 */
+	struct mt7915_dev *dev = phy->dev;
+	u32 reg = mt76_rr(dev, MT_WF_HEMU_RULE1);
+
+	reg &= ~(MT_WF_HEMU_RULE1_AID |
+		 MT_WF_HEMU_RULE1_COLOR |
+		 MT_WF_HEMU_RULE1_ULDL |
+		 MT_WF_HEMU_RULE1_AID_ENABLE |
+		 MT_WF_HEMU_RULE1_BSS_COLOR_ENABLE |
+		 MT_WF_HEMU_RULE1_ULDL_ENABLE |
+		 MT_WF_HEMU_RULE1_PRIORITY);
+	reg |= phy->monitor.cur_aid;
+	reg |= (phy->monitor.cur_color << 10) & 0x3f;
+	if (phy->monitor.cur_uldl)
+		reg |= MT_WF_HEMU_RULE1_ULDL;
+	if (phy->monitor.cur_enables) {
+		if (phy->monitor.cur_enables & 0x1)
+			reg |= MT_WF_HEMU_RULE1_AID_ENABLE;
+		if (phy->monitor.cur_enables & 0x2)
+			reg |= MT_WF_HEMU_RULE1_BSS_COLOR_ENABLE;
+		if (phy->monitor.cur_enables & 0x4)
+			reg |= MT_WF_HEMU_RULE1_ULDL_ENABLE;
+		reg |= MT_WF_HEMU_RULE1_PRIORITY; /* set priority to 7 */
+	}
+
+	mt76_wr(dev, MT_WF_HEMU_RULE1, reg);
+}
+
 static void __mt7915_configure_filter(struct ieee80211_hw *hw,
 				      unsigned int changed_flags,
 				      unsigned int *total_flags,
@@ -575,6 +609,7 @@ static void __mt7915_configure_filter(struct ieee80211_hw *hw,
 		mt76_clear(dev, MT_WF_RFCR1(band), ctl_flags);
 		mt76_set(dev, MT_WF_RMAC_TOP_TF_PARSER(band),
 			 MT_WF_RMAC_TOP_TF_SNIFFER);
+		mt7915_check_apply_monitor_config(phy);
 	} else {
 		mt76_set(dev, MT_WF_RFCR1(band), ctl_flags);
 		mt76_clear(dev, MT_WF_RMAC_TOP_TF_PARSER(band),
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 06f98e5cd95e..0ed041813d95 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -242,6 +242,15 @@ struct mt7915_phy {
 	struct ieee80211_sband_iftype_data iftype[NUM_NL80211_BANDS][NUM_NL80211_IFTYPES];
 
 	struct ieee80211_vif *monitor_vif;
+	struct {
+		u16 cur_aid; /* aid to be used in monitor mode to capture HE trigger frames */
+		/* bss-color to be used in monitor mode to capture HE trigger frames */
+		u8 cur_color;
+		/* upload/download to be used in monitor mode to capture HE trigger frames */
+		u8 cur_uldl;
+		/* Specifies which of the above are used:  0x1 is AID, 0x2 is color, 0x4 is uldl */
+		u8 cur_enables;
+	} monitor;
 
 	struct thermal_cooling_device *cdev;
 	u32 mac80211_rxfilter_flags;
@@ -628,6 +637,7 @@ int mt7915_mcu_muru_debug_set(struct mt7915_dev *dev, bool enable);
 int mt7915_mcu_muru_debug_get(struct mt7915_phy *phy, void *ms);
 int mt7915_mcu_wed_enable_rx_stats(struct mt7915_dev *dev);
 int mt7915_init_debugfs(struct mt7915_phy *phy);
+void mt7915_check_apply_monitor_config(struct mt7915_phy *phy);
 void mt7915_debugfs_rx_fw_monitor(struct mt7915_dev *dev, const void *data, int len);
 bool mt7915_debugfs_rx_log(struct mt7915_dev *dev, const void *data, int len);
 #ifdef CONFIG_MAC80211_DEBUGFS
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 0118fdaa96b3..252e5f1405cf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -1217,4 +1217,13 @@ enum offs_rev {
 #define MT_MCU_WM_CIRQ_EINT_MASK_CLR_ADDR	MT_MCU_WM_CIRQ(0x108)
 #define MT_MCU_WM_CIRQ_EINT_SOFT_ADDR		MT_MCU_WM_CIRQ(0x118)
 
+#define MT_WF_HEMU_RULE1                       (MT_WF_PHY_BASE + 0x10e0)
+#define MT_WF_HEMU_RULE1_AID                   GENMASK(10, 0)
+#define MT_WF_HEMU_RULE1_COLOR                 GENMASK(21, 16)
+#define MT_WF_HEMU_RULE1_ULDL                  (BIT(22)) /* 0 dl, 1 ul */
+#define MT_WF_HEMU_RULE1_AID_ENABLE            (BIT(24))
+#define MT_WF_HEMU_RULE1_BSS_COLOR_ENABLE      (BIT(25))
+#define MT_WF_HEMU_RULE1_ULDL_ENABLE           (BIT(26))
+#define MT_WF_HEMU_RULE1_PRIORITY              GENMASK(30, 28) /* 0 disable, 7 is highest */
+
 #endif
-- 
2.40.0

