Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE599331EF0
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Mar 2021 07:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhCIGB6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Mar 2021 01:01:58 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:43331 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhCIGBo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Mar 2021 01:01:44 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 12961bfG6029919, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 12961bfG6029919
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 9 Mar 2021 14:01:37 +0800
Received: from localhost (172.21.69.146) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 9 Mar 2021
 14:01:37 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH] rtw88: 8822c: support FW crash dump when FW crash
Date:   Tue, 9 Mar 2021 14:01:21 +0800
Message-ID: <20210309060121.9099-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.146]
X-ClientProxiedBy: RTEXMBS03.realtek.com.tw (172.21.6.96) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Although FW crash logs are already supported for dumping in driver, the
logs may not be sufficient to analyze field issues. To improve this part,
we add a support to dump FW memory.

When driver receives FW crash notifications, driver uses DDMA, which is a
HW ability, to copy specified FW memory to FW fifo. Driver can then dump
these information from FW fifo. With this support, not only FW crash log
but also specified FW memory will be dumped while FW crash. Besides,
specified registers are also dumped.

This feature is implemeted on 8822C first due to difference of FW layouts
between ICs. In addition, we add a debugfs to trigger FW crash. It can
simulate the process of crash, dump and reset. Through it, we can also
check if a reset is ongoing.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/debug.c    |  41 +++++++
 drivers/net/wireless/realtek/rtw88/mac.c      |  19 ++++
 drivers/net/wireless/realtek/rtw88/mac.h      |   4 +
 drivers/net/wireless/realtek/rtw88/main.c     | 100 +++++++++++++++---
 drivers/net/wireless/realtek/rtw88/main.h     |  11 ++
 drivers/net/wireless/realtek/rtw88/reg.h      |   1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  10 ++
 7 files changed, 172 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index 948cb79050ea..4539b673f6fd 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -10,6 +10,7 @@
 #include "fw.h"
 #include "debug.h"
 #include "phy.h"
+#include "reg.h"
 
 #ifdef CONFIG_RTW88_DEBUGFS
 
@@ -818,6 +819,40 @@ static int rtw_debugfs_get_coex_enable(struct seq_file *m, void *v)
 	return 0;
 }
 
+static ssize_t rtw_debugfs_set_fw_crash(struct file *filp,
+					const char __user *buffer,
+					size_t count, loff_t *loff)
+{
+	struct seq_file *seqpriv = (struct seq_file *)filp->private_data;
+	struct rtw_debugfs_priv *debugfs_priv = seqpriv->private;
+	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
+	char tmp[32 + 1];
+	bool input;
+	int ret;
+
+	rtw_debugfs_copy_from_user(tmp, sizeof(tmp), buffer, count, 1);
+
+	ret = kstrtobool(tmp, &input);
+	if (ret)
+		return -EINVAL;
+
+	if (!input)
+		return -EINVAL;
+
+	rtw_write8(rtwdev, REG_HRCV_MSG, 1);
+
+	return count;
+}
+
+static int rtw_debugfs_get_fw_crash(struct seq_file *m, void *v)
+{
+	struct rtw_debugfs_priv *debugfs_priv = m->private;
+	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
+
+	seq_printf(m, "%d\n", test_bit(RTW_FLAG_RESTARTING, rtwdev->flags));
+	return 0;
+}
+
 #define rtw_debug_impl_mac(page, addr)				\
 static struct rtw_debugfs_priv rtw_debug_priv_mac_ ##page = {	\
 	.cb_read = rtw_debug_get_mac_page,			\
@@ -921,6 +956,11 @@ static struct rtw_debugfs_priv rtw_debug_priv_coex_info = {
 	.cb_read = rtw_debugfs_get_coex_info,
 };
 
+static struct rtw_debugfs_priv rtw_debug_priv_fw_crash = {
+	.cb_write = rtw_debugfs_set_fw_crash,
+	.cb_read = rtw_debugfs_get_fw_crash,
+};
+
 #define rtw_debugfs_add_core(name, mode, fopname, parent)		\
 	do {								\
 		rtw_debug_priv_ ##name.rtwdev = rtwdev;			\
@@ -994,6 +1034,7 @@ void rtw_debugfs_init(struct rtw_dev *rtwdev)
 	}
 	rtw_debugfs_add_r(rf_dump);
 	rtw_debugfs_add_r(tx_pwr_tbl);
+	rtw_debugfs_add_rw(fw_crash);
 }
 
 #endif /* CONFIG_RTW88_DEBUGFS */
diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index 59028b121b00..d1678aed9d9c 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -530,6 +530,25 @@ static int iddma_download_firmware(struct rtw_dev *rtwdev, u32 src, u32 dst,
 	return 0;
 }
 
+int rtw_ddma_to_fw_fifo(struct rtw_dev *rtwdev, u32 ocp_src, u32 size)
+{
+	u32 ch0_ctrl = BIT_DDMACH0_OWN | BIT_DDMACH0_DDMA_MODE;
+
+	if (!check_hw_ready(rtwdev, REG_DDMA_CH0CTRL, BIT_DDMACH0_OWN, 0)) {
+		rtw_dbg(rtwdev, RTW_DBG_FW, "busy to start ddma\n");
+		return -EBUSY;
+	}
+
+	ch0_ctrl |= size & BIT_MASK_DDMACH0_DLEN;
+
+	if (iddma_enable(rtwdev, ocp_src, OCPBASE_RXBUF_FW_88XX, ch0_ctrl)) {
+		rtw_dbg(rtwdev, RTW_DBG_FW, "busy to complete ddma\n");
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 static bool
 check_fw_checksum(struct rtw_dev *rtwdev, u32 addr)
 {
diff --git a/drivers/net/wireless/realtek/rtw88/mac.h b/drivers/net/wireless/realtek/rtw88/mac.h
index ce64cdf7a565..3172aa5ac4de 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.h
+++ b/drivers/net/wireless/realtek/rtw88/mac.h
@@ -15,7 +15,10 @@
 #define ILLEGAL_KEY_GROUP	0xFAAAAA00
 
 /* HW memory address */
+#define OCPBASE_RXBUF_FW_88XX		0x18680000
 #define OCPBASE_TXBUF_88XX		0x18780000
+#define OCPBASE_ROM_88XX		0x00000000
+#define OCPBASE_IMEM_88XX		0x00030000
 #define OCPBASE_DMEM_88XX		0x00200000
 #define OCPBASE_EMEM_88XX		0x00100000
 
@@ -33,6 +36,7 @@ void rtw_mac_power_off(struct rtw_dev *rtwdev);
 int rtw_download_firmware(struct rtw_dev *rtwdev, struct rtw_fw_state *fw);
 int rtw_mac_init(struct rtw_dev *rtwdev);
 void rtw_mac_flush_queues(struct rtw_dev *rtwdev, u32 queues, bool drop);
+int rtw_ddma_to_fw_fifo(struct rtw_dev *rtwdev, u32 ocp_src, u32 size);
 
 static inline void rtw_mac_flush_all_queues(struct rtw_dev *rtwdev, bool drop)
 {
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index e6989c0525cc..35a90b8323b8 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -345,15 +345,9 @@ static bool rtw_fw_dump_crash_log(struct rtw_dev *rtwdev)
 			"fw crash dump's seq is wrong: %d\n", seq);
 		goto free_buf;
 	}
-	if (seq == 0 &&
-	    (GET_FW_DUMP_TLV_TYPE(buf) != FW_CD_TYPE ||
-	     GET_FW_DUMP_TLV_LEN(buf) != FW_CD_LEN ||
-	     GET_FW_DUMP_TLV_VAL(buf) != FW_CD_VAL)) {
-		rtw_dbg(rtwdev, RTW_DBG_FW, "fw crash dump's tlv is wrong\n");
-		goto free_buf;
-	}
 
-	print_hex_dump_bytes("rtw88 fw dump: ", DUMP_PREFIX_OFFSET, buf, size);
+	print_hex_dump(KERN_ERR, "rtw88 fw dump: ", DUMP_PREFIX_OFFSET, 16, 1,
+		       buf, size, true);
 
 	if (GET_FW_DUMP_MORE(buf) == 1) {
 		rtwdev->fw.prev_dump_seq = seq;
@@ -368,6 +362,78 @@ static bool rtw_fw_dump_crash_log(struct rtw_dev *rtwdev)
 	return ret;
 }
 
+int rtw_dump_fw(struct rtw_dev *rtwdev, const u32 ocp_src, u32 size,
+		const char *prefix_str)
+{
+	u32 rxff = rtwdev->chip->fw_rxff_size;
+	u32 dump_size, done_size = 0;
+	u8 *buf;
+	int ret;
+
+	buf = vzalloc(size);
+	if (!buf)
+		return -ENOMEM;
+
+	while (size) {
+		dump_size = size > rxff ? rxff : size;
+
+		ret = rtw_ddma_to_fw_fifo(rtwdev, ocp_src + done_size,
+					  dump_size);
+		if (ret) {
+			rtw_err(rtwdev,
+				"ddma fw 0x%x [+0x%x] to fw fifo fail\n",
+				ocp_src, done_size);
+			goto exit;
+		}
+
+		ret = rtw_fw_dump_fifo(rtwdev, RTW_FW_FIFO_SEL_RXBUF_FW, 0,
+				       dump_size, (u32 *)(buf + done_size));
+		if (ret) {
+			rtw_err(rtwdev,
+				"dump fw 0x%x [+0x%x] from fw fifo fail\n",
+				ocp_src, done_size);
+			goto exit;
+		}
+
+		size -= dump_size;
+		done_size += dump_size;
+	}
+
+	print_hex_dump(KERN_ERR, prefix_str, DUMP_PREFIX_OFFSET, 16, 1,
+		       buf, done_size, true);
+
+exit:
+	vfree(buf);
+	return ret;
+}
+EXPORT_SYMBOL(rtw_dump_fw);
+
+int rtw_dump_reg(struct rtw_dev *rtwdev, const u32 addr, const u32 size,
+		 const char *prefix_str)
+{
+	u8 *buf;
+	u32 i;
+
+	if (addr & 0x3) {
+		WARN(1, "should be 4-byte aligned, addr = 0x%08x\n", addr);
+		return -EINVAL;
+	}
+
+	buf = vzalloc(size);
+	if (!buf)
+		return -ENOMEM;
+
+	for (i = 0; i < size; i += 4)
+		*(u32 *)(buf + i) = rtw_read32(rtwdev, addr + i);
+
+	print_hex_dump(KERN_ERR, prefix_str, DUMP_PREFIX_OFFSET, 16, 4, buf,
+		       size, true);
+
+	vfree(buf);
+	return 0;
+}
+EXPORT_SYMBOL(rtw_dump_reg);
+
 void rtw_vif_assoc_changed(struct rtw_vif *rtwvif,
 			   struct ieee80211_bss_conf *conf)
 {
@@ -419,10 +485,8 @@ void rtw_fw_recovery(struct rtw_dev *rtwdev)
 		ieee80211_queue_work(rtwdev->hw, &rtwdev->fw_recovery_work);
 }
 
-static void rtw_fw_recovery_work(struct work_struct *work)
+static void __fw_recovery_work(struct rtw_dev *rtwdev)
 {
-	struct rtw_dev *rtwdev = container_of(work, struct rtw_dev,
-					      fw_recovery_work);
 
 	/* rtw_fw_dump_crash_log() returns false indicates that there are
 	 * still more log to dump. Driver set 0x1cf[7:0] = 0x1 to tell firmware
@@ -435,18 +499,26 @@ static void rtw_fw_recovery_work(struct work_struct *work)
 	}
 	rtwdev->fw.prev_dump_seq = 0;
 
-	WARN(1, "firmware crash, start reset and recover\n");
+	set_bit(RTW_FLAG_RESTARTING, rtwdev->flags);
+	rtw_chip_dump_fw_crash(rtwdev);
 
-	mutex_lock(&rtwdev->mutex);
+	WARN(1, "firmware crash, start reset and recover\n");
 
-	set_bit(RTW_FLAG_RESTARTING, rtwdev->flags);
 	rcu_read_lock();
 	rtw_iterate_keys_rcu(rtwdev, NULL, rtw_reset_key_iter, rtwdev);
 	rcu_read_unlock();
 	rtw_iterate_stas_atomic(rtwdev, rtw_reset_sta_iter, rtwdev);
 	rtw_iterate_vifs_atomic(rtwdev, rtw_reset_vif_iter, rtwdev);
 	rtw_enter_ips(rtwdev);
+}
 
+static void rtw_fw_recovery_work(struct work_struct *work)
+{
+	struct rtw_dev *rtwdev = container_of(work, struct rtw_dev,
+					      fw_recovery_work);
+
+	mutex_lock(&rtwdev->mutex);
+	__fw_recovery_work(rtwdev);
 	mutex_unlock(&rtwdev->mutex);
 
 	ieee80211_restart_hw(rtwdev->hw);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 35afea91fd29..d185209ee3cc 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -805,6 +805,7 @@ struct rtw_regulatory {
 
 struct rtw_chip_ops {
 	int (*mac_init)(struct rtw_dev *rtwdev);
+	void (*dump_fw_crash)(struct rtw_dev *rtwdev);
 	void (*shutdown)(struct rtw_dev *rtwdev);
 	int (*read_efuse)(struct rtw_dev *rtwdev, u8 *map);
 	void (*phy_set_param)(struct rtw_dev *rtwdev);
@@ -1876,6 +1877,12 @@ static inline void rtw_release_macid(struct rtw_dev *rtwdev, u8 mac_id)
 	clear_bit(mac_id, rtwdev->mac_id_map);
 }
 
+static inline void rtw_chip_dump_fw_crash(struct rtw_dev *rtwdev)
+{
+	if (rtwdev->chip->ops->dump_fw_crash)
+		rtwdev->chip->ops->dump_fw_crash(rtwdev);
+}
+
 void rtw_get_channel_params(struct cfg80211_chan_def *chandef,
 			    struct rtw_channel_params *ch_param);
 bool check_hw_ready(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 target);
@@ -1905,5 +1912,9 @@ int rtw_sta_add(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 void rtw_sta_remove(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 		    bool fw_exist);
 void rtw_fw_recovery(struct rtw_dev *rtwdev);
+int rtw_dump_fw(struct rtw_dev *rtwdev, const u32 ocp_src, u32 size,
+		const char *prefix_str);
+int rtw_dump_reg(struct rtw_dev *rtwdev, const u32 addr, const u32 size,
+		 const char *prefix_str);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index ea518aa78552..e3a981ad01a6 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -534,6 +534,7 @@
 #define BIT_DDMACH0_OWN		BIT(31)
 #define BIT_DDMACH0_CHKSUM_EN	BIT(29)
 #define BIT_DDMACH0_CHKSUM_STS	BIT(27)
+#define BIT_DDMACH0_DDMA_MODE	BIT(26)
 #define BIT_DDMACH0_RESET_CHKSUM_STS BIT(25)
 #define BIT_DDMACH0_CHKSUM_CONT	BIT(24)
 #define BIT_MASK_DDMACH0_DLEN	0x3ffff
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index dd560c28abb2..a1f1da3db029 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -1396,6 +1396,15 @@ static int rtw8822c_mac_init(struct rtw_dev *rtwdev)
 	return 0;
 }
 
+static void rtw8822c_dump_fw_crash(struct rtw_dev *rtwdev)
+{
+	rtw_dump_reg(rtwdev, 0x0, 0x2000, "rtw8822c reg_");
+	rtw_dump_fw(rtwdev, OCPBASE_DMEM_88XX, 0x10000, "rtw8822c DMEM_");
+	rtw_dump_fw(rtwdev, OCPBASE_IMEM_88XX, 0x10000, "rtw8822c IMEM_");
+	rtw_dump_fw(rtwdev, OCPBASE_EMEM_88XX, 0x20000, "rtw8822c EMEM_");
+	rtw_dump_fw(rtwdev, OCPBASE_ROM_88XX, 0x10000, "rtw8822c ROM_");
+}
+
 static void rtw8822c_rstb_3wire(struct rtw_dev *rtwdev, bool enable)
 {
 	if (enable) {
@@ -3971,6 +3980,7 @@ static struct rtw_chip_ops rtw8822c_ops = {
 	.query_rx_desc		= rtw8822c_query_rx_desc,
 	.set_channel		= rtw8822c_set_channel,
 	.mac_init		= rtw8822c_mac_init,
+	.dump_fw_crash		= rtw8822c_dump_fw_crash,
 	.read_rf		= rtw_phy_read_rf,
 	.write_rf		= rtw_phy_write_rf_reg_mix,
 	.set_tx_power_index	= rtw8822c_set_tx_power_index,
-- 
2.21.0

