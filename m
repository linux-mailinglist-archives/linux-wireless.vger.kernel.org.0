Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6FB68C595
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Feb 2023 19:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjBFSTE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Feb 2023 13:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjBFSTC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Feb 2023 13:19:02 -0500
X-Greylist: delayed 404 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Feb 2023 10:19:01 PST
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4251AF
        for <linux-wireless@vger.kernel.org>; Mon,  6 Feb 2023 10:19:01 -0800 (PST)
Received: from dispatch1-us1.ppe-hosted.com (localhost.localdomain [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 2607F23078A
        for <linux-wireless@vger.kernel.org>; Mon,  6 Feb 2023 18:12:17 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5A059940087;
        Mon,  6 Feb 2023 18:12:15 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id CE76413C2B0;
        Mon,  6 Feb 2023 10:12:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com CE76413C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1675707134;
        bh=Pc82vDA2UuclTIllc0A73dHYWTlIy/zYDbg8TOVJOD0=;
        h=From:To:Cc:Subject:Date:From;
        b=pvL+P2CJrieiNxHyceOoC4U0CzmhntYilcmGqGsaVBfzelxoVprnkhQgXMUvnBqD0
         zbKSJvp82ekC/u9yflyvswBdC/yUEt37sKdC/J5/JFcF2oM/LulDP6ZUk3wSVT7Zac
         /FpBK8CklWauTwEFwVs802L4HAOXp+umhkdQXLxY=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Deren.Wu@mediatek.com, Ben Greear <greearb@candelatech.com>
Subject: [PATCH] wifi: mt76: mt7921:  Allow disabling deep-sleep and beacon filtering.
Date:   Mon,  6 Feb 2023 10:12:10 -0800
Message-Id: <20230206181210.1307902-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1675707136-otzBtr_JiE5i
X-MDID-O: us5-at1-1675707136-otzBtr_JiE5i
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Semi permanently by use of module parameters.  This is helpful to me because
I want to see beacon RSSI reported without having to poke debugfs every
time a station re-associates.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../wireless/mediatek/mt76/mt7921/debugfs.c   | 16 +++++++++---
 .../net/wireless/mediatek/mt76/mt7921/init.c  | 10 +++++---
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 25 +++++++++++++------
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  2 ++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  1 +
 5 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index e72d66e704af..a7eb80730d91 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -4,6 +4,9 @@
 #include "mt7921.h"
 #include "eeprom.h"
 
+extern bool mt7921_disable_pm;
+extern bool mt7921_disable_deep_sleep;
+
 static int
 mt7921_reg_set(void *data, u64 val)
 {
@@ -272,7 +275,7 @@ mt7921_pm_set(void *data, u64 val)
 
 	mutex_lock(&dev->mt76.mutex);
 
-	if (val == pm->enable_user)
+	if (val == pm->enable_user && val == pm->enable)
 		goto out;
 
 	if (!pm->enable_user) {
@@ -318,11 +321,11 @@ mt7921_deep_sleep_set(void *data, u64 val)
 		return -EOPNOTSUPP;
 
 	mt7921_mutex_acquire(dev);
-	if (pm->ds_enable_user == enable)
+	if (pm->ds_enable_user == enable && pm->ds_enable == enable)
 		goto out;
 
 	pm->ds_enable_user = enable;
-	pm->ds_enable = enable && !monitor;
+	pm->ds_enable = enable && !monitor && !mt7921_disable_deep_sleep;
 	mt76_connac_mcu_set_deep_sleep(&dev->mt76, pm->ds_enable);
 out:
 	mt7921_mutex_release(dev);
@@ -362,6 +365,13 @@ mt7921_pm_stats(struct seq_file *s, void *data)
 		   jiffies_to_msecs(doze_time));
 
 	seq_printf(s, "low power wakes: %9d\n", pm->stats.lp_wake);
+	seq_printf(s, "\nlast-beacon-filter-setting: %d\n", dev->beacon_filter_setting);
+	seq_printf(s, "pm.enable: %d\n", pm->enable);
+	seq_printf(s, "pm.user_enable: %d\n", pm->enable_user);
+	seq_printf(s, "pm.deep_sleep_enable: %d\n", pm->ds_enable);
+	seq_printf(s, "pm.user_deep_sleep_enable: %d\n", pm->ds_enable_user);
+	seq_printf(s, "modparm-disable-pm: %d\n", mt7921_disable_pm);
+	seq_printf(s, "modparm-disable-deep-sleep-pm: %d\n", mt7921_disable_deep_sleep);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index aadb229003c9..cdefab4e7546 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -7,6 +7,9 @@
 #include "mcu.h"
 #include "eeprom.h"
 
+extern bool mt7921_disable_pm;
+extern bool mt7921_disable_deep_sleep;
+
 static const struct ieee80211_iface_limit if_limits[] = {
 	{
 		.max = MT7921_MAX_INTERFACES,
@@ -98,7 +101,6 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, SUPPORTS_PS);
 	ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
 	ieee80211_hw_set(hw, SUPPORTS_VHT_EXT_NSS_BW);
-	ieee80211_hw_set(hw, CONNECTION_MONITOR);
 
 	if (dev->pm.enable)
 		ieee80211_hw_set(hw, CONNECTION_MONITOR);
@@ -158,6 +160,8 @@ static int __mt7921_init_hardware(struct mt7921_dev *dev)
 {
 	int ret;
 
+	dev->beacon_filter_setting = -1; /* initialize to un-set */
+
 	/* force firmware operation mode into normal state,
 	 * which should be set before firmware download stage.
 	 */
@@ -286,9 +290,9 @@ int mt7921_register_device(struct mt7921_dev *dev)
 	dev->pm.stats.last_doze_event = jiffies;
 	if (!mt76_is_usb(&dev->mt76)) {
 		dev->pm.enable_user = true;
-		dev->pm.enable = true;
+		dev->pm.enable = !mt7921_disable_pm;
 		dev->pm.ds_enable_user = true;
-		dev->pm.ds_enable = true;
+		dev->pm.ds_enable = !mt7921_disable_deep_sleep;
 	}
 
 	if (!mt76_is_mmio(&dev->mt76))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index be3bd1a78435..f95b54deee9e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -9,6 +9,15 @@
 #include "mt7921.h"
 #include "mcu.h"
 
+bool mt7921_disable_pm;
+module_param_named(disable_pm, mt7921_disable_pm, bool, 0644);
+MODULE_PARM_DESC(disable_pm, "disable runtime-pm");
+
+bool mt7921_disable_deep_sleep;
+module_param_named(disable_deep_sleep, mt7921_disable_deep_sleep, bool, 0644);
+MODULE_PARM_DESC(disable_deep_sleep, "disable runtime deep-sleep");
+
+
 static void
 mt7921_gen_ppe_thresh(u8 *he_ppet, int nss)
 {
@@ -352,7 +361,8 @@ static int mt7921_add_interface(struct ieee80211_hw *hw,
 		mtxq->wcid = idx;
 	}
 
-	vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
+	if (dev->pm.enable)
+		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
 out:
 	mt7921_mutex_release(dev);
 
@@ -522,13 +532,12 @@ mt7921_sniffer_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	bool monitor = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
 
 	mt7921_mcu_set_sniffer(dev, vif, monitor);
-	pm->enable = pm->enable_user && !monitor;
-	pm->ds_enable = pm->ds_enable_user && !monitor;
+	pm->enable = pm->enable_user && !monitor && !mt7921_disable_pm;
+	pm->ds_enable = pm->ds_enable_user && !monitor && !mt7921_disable_deep_sleep;
 
 	mt76_connac_mcu_set_deep_sleep(&dev->mt76, pm->ds_enable);
 
-	if (monitor)
-		mt7921_mcu_set_beacon_filter(dev, vif, false);
+	mt7921_mcu_set_beacon_filter(dev, vif, pm->enable);
 }
 
 void mt7921_set_runtime_pm(struct mt7921_dev *dev)
@@ -537,11 +546,11 @@ void mt7921_set_runtime_pm(struct mt7921_dev *dev)
 	struct mt76_connac_pm *pm = &dev->pm;
 	bool monitor = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
 
-	pm->enable = pm->enable_user && !monitor;
+	pm->enable = pm->enable_user && !monitor && !mt7921_disable_pm;
 	ieee80211_iterate_active_interfaces(hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7921_pm_interface_iter, dev);
-	pm->ds_enable = pm->ds_enable_user && !monitor;
+	pm->ds_enable = pm->ds_enable_user && !monitor && !mt7921_disable_deep_sleep;
 	mt76_connac_mcu_set_deep_sleep(&dev->mt76, pm->ds_enable);
 }
 
@@ -682,7 +691,7 @@ static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_ASSOC) {
 		mt7921_mcu_sta_update(dev, NULL, vif, true,
 				      MT76_STA_INFO_STATE_ASSOC);
-		mt7921_mcu_set_beacon_filter(dev, vif, info->assoc);
+		mt7921_mcu_set_beacon_filter(dev, vif, info->assoc && dev->pm.enable);
 	}
 
 	if (changed & BSS_CHANGED_ARP_FILTER) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index c6224908b494..322f396d90be 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -812,6 +812,8 @@ int mt7921_mcu_set_beacon_filter(struct mt7921_dev *dev,
 {
 	int err;
 
+	dev->beacon_filter_setting = enable;
+
 	if (enable) {
 		err = mt7921_mcu_uni_bss_bcnft(dev, vif, true);
 		if (err)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index ab92537dabd6..bcb4da214688 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -232,6 +232,7 @@ struct mt7921_dev {
 	struct work_struct init_work;
 
 	u8 fw_debug;
+	s8 beacon_filter_setting; /* -1 not set, 0 disabled, 1 enabled */
 
 	struct mt76_connac_pm pm;
 	struct mt76_connac_coredump coredump;
-- 
2.39.0

