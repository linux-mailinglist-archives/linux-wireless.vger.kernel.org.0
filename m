Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5D1A1554A4
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2020 10:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgBGJ3B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Feb 2020 04:29:01 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:44698 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbgBGJ3B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Feb 2020 04:29:01 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 0179StA4018590, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 0179StA4018590
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Feb 2020 17:28:55 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 7 Feb 2020 17:28:54 +0800
Received: from RTEXMB06.realtek.com.tw (172.21.6.99) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 7 Feb 2020 17:28:54 +0800
Received: from RTITCASV01.realtek.com.tw (172.21.6.18) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1779.2
 via Frontend Transport; Fri, 7 Feb 2020 17:28:54 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Fri, 7 Feb 2020 17:28:53 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <pkshih@realtek.com>
Subject: [PATCH 8/8] rtw88: sar: dump sar information via debugfs
Date:   Fri, 7 Feb 2020 17:28:44 +0800
Message-ID: <20200207092844.29175-9-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200207092844.29175-1-yhchuang@realtek.com>
References: <20200207092844.29175-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

To know detail of SAR information, we add a debugfs entry to dump the raw
content written in ACPI, and also dump the translated data (real number in
decimal). The output looks like

  Customer ID: 0x5048
  WiFiEnable: 0x1
  Total SAR Table Count: 3
  Current SAR Table Index: (02 02 02 02)

  Dump RWRD SAR RAW DATA. (Total Count: 60)
  01: 0e 0c 0c 0c 0c 0e 0c 0c 0c 0c 0e 0c 0c 0c 0c 12 10 10 12 12
  02: 08 03 03 03 03 08 03 03 03 03 08 03 03 03 03 12 10 10 12 12
  03: 04 ff ff ff ff 04 ff ff ff ff 04 ff ff ff ff 12 10 10 12 12

  Show SAR PowerLimit:
  2.4G Antenna 0: [14.0] dBm
  2.4G Antenna 1: [14.0] dBm

  5G Antenna 0: [11.500, 11.500, 11.500, 11.500, ] dBm
  5G Antenna 1: [11.500, 11.500, 11.500, 11.500, ] dBm

  Dump Geo-SAR Table RAW DATA. (Total Count: 30)
  geo-0: 10 04 08 01 01 0f 04 0c 01 01
  geo-1: 0c 02 06 03 03 06 04 08 03 03
  geo-2: 10 03 03 03 03 0f 03 03 03 03

  Show Geo-SAR PowerLimit:
  2G Geo Table Index: 1
  5G Geo Table Index: 1

  2GHz:
  Max Power: [16.0] dBm
  Ant-0 delta value: [1.0] dB
  Ant-1 delta value: [3.0] dB

  5GHz:
  Max Power: [13.0] dBm
  Ant-0 delta value: [2.0] dB
  Ant-1 delta value: [4.0] dB

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/debug.c | 16 ++++
 drivers/net/wireless/realtek/rtw88/sar.c   | 92 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/sar.h   |  1 +
 3 files changed, 109 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index 3ec15a49ecc9..ee73b125ac0e 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -9,6 +9,7 @@
 #include "fw.h"
 #include "debug.h"
 #include "phy.h"
+#include "sar.h"
 
 #ifdef CONFIG_RTW88_DEBUGFS
 
@@ -696,6 +697,16 @@ static int rtw_debugfs_get_phy_info(struct seq_file *m, void *v)
 	return 0;
 }
 
+static int rtw_debugfs_get_sar(struct seq_file *m, void *v)
+{
+	struct rtw_debugfs_priv *debugfs_priv = m->private;
+	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
+
+	rtw_sar_dump_via_debugfs(rtwdev, m);
+
+	return 0;
+}
+
 #define rtw_debug_impl_mac(page, addr)				\
 static struct rtw_debugfs_priv rtw_debug_priv_mac_ ##page = {	\
 	.cb_read = rtw_debug_get_mac_page,			\
@@ -786,6 +797,10 @@ static struct rtw_debugfs_priv rtw_debug_priv_phy_info = {
 	.cb_read = rtw_debugfs_get_phy_info,
 };
 
+static struct rtw_debugfs_priv rtw_debug_priv_sar = {
+	.cb_read = rtw_debugfs_get_sar,
+};
+
 #define rtw_debugfs_add_core(name, mode, fopname, parent)		\
 	do {								\
 		rtw_debug_priv_ ##name.rtwdev = rtwdev;			\
@@ -816,6 +831,7 @@ void rtw_debugfs_init(struct rtw_dev *rtwdev)
 	rtw_debugfs_add_rw(dump_cam);
 	rtw_debugfs_add_rw(rsvd_page);
 	rtw_debugfs_add_r(phy_info);
+	rtw_debugfs_add_r(sar);
 	rtw_debugfs_add_r(mac_0);
 	rtw_debugfs_add_r(mac_1);
 	rtw_debugfs_add_r(mac_2);
diff --git a/drivers/net/wireless/realtek/rtw88/sar.c b/drivers/net/wireless/realtek/rtw88/sar.c
index 2bc6da4e5fcf..62689c002e25 100644
--- a/drivers/net/wireless/realtek/rtw88/sar.c
+++ b/drivers/net/wireless/realtek/rtw88/sar.c
@@ -298,6 +298,7 @@ struct rtw_sar_read {
 	const struct rtw_sar_geo_map *gm, *gm_end;
 	int rwsi_sz;
 	int rwgs_sz;
+	int rwgs_geos;
 };
 
 static int rwsi_mode_hp(struct rtw_dev *rtwdev, int path)
@@ -333,6 +334,7 @@ static const struct rtw_sar_read sar_read_hp = {
 	.gm_end = geo_map_hp + ARRAY_SIZE(geo_map_hp),
 	.rwsi_sz = sizeof(struct rtw_sar_rwsi_hp),
 	.rwgs_sz = sizeof(struct rtw_sar_rwgs_hp),
+	.rwgs_geos = RTW_SAR_RWGS_HP_NR,
 };
 
 static int rwsi_mode_rt(struct rtw_dev *rtwdev, int path)
@@ -364,6 +366,7 @@ static const struct rtw_sar_read sar_read_rt = {
 	.gm_end = geo_map_rt + ARRAY_SIZE(geo_map_rt),
 	.rwsi_sz = sizeof(struct rtw_sar_rwsi_rt),
 	.rwgs_sz = sizeof(struct rtw_sar_rwgs_rt),
+	.rwgs_geos = RTW_SAR_RWGS_RT_NR,
 };
 
 static u8 *rtw_sar_get_raw_package(struct rtw_dev *rtwdev,
@@ -504,6 +507,88 @@ static bool is_valid_rwgs(struct rtw_dev *rtwdev, const struct rtw_sar_rwrd *rwr
 	return false;
 }
 
+#ifdef CONFIG_RTW88_DEBUGFS
+void rtw_sar_dump_via_debugfs(struct rtw_dev *rtwdev, struct seq_file *m)
+{
+#define q3_int(q3)	((q3) >> 3)
+#define q3_fra(q3)	(((q3) & 0x7) * 125)
+
+	const struct rtw_sar_rwrd *rwrd = rtwdev->sar.rwrd;
+	const union rtw_sar_rwsi *rwsi = rtwdev->sar.rwsi;
+	const union rtw_sar_rwgs *rwgs = rtwdev->sar.rwgs;
+	const struct rtw_sar_read *r = rtwdev->sar.read;
+	int q3;
+	int mode;
+	int path;
+	int chidx;
+	int gi;
+	int band;
+
+	if (!rwrd || !rwsi || !rwgs || !r) {
+		seq_puts(m, "(No SAR data)\n");
+		return;
+	}
+
+	seq_printf(m, "Customer ID: 0x%04x\n", rwrd->id);
+	seq_printf(m, "WiFiEnable: 0x%x\n", rwrd->en);
+	seq_printf(m, "Total SAR Table Count: %d\n", rwrd->count);
+	seq_printf(m, "Current SAR Table Index: (%*ph)\n", r->rwsi_sz, rwsi);
+	seq_puts(m, "\n");
+
+	seq_printf(m, "Dump RWRD SAR RAW DATA. (Total Count: %ld)\n",
+		   rwrd->count * sizeof(rwrd->mode[0]));
+	for (mode = 0; mode < rwrd->count; mode++)
+		seq_printf(m, "%02x: %20ph\n", mode + 1, &rwrd->mode[mode]);
+	seq_puts(m, "\n");
+
+	seq_puts(m, "Show SAR PowerLimit:\n");
+	for (path = 0; path < 2; path++) {
+		mode = r->rwsi_mode(rtwdev, path);
+		q3 = r->rwrd_base_q3(rtwdev, mode, path, RTW_SAR_LMT_CH1_14);
+		seq_printf(m, "2.4G Antenna %d: [%d.%d] dBm\n", path,
+			   q3_int(q3), q3_fra(q3));
+	}
+	seq_puts(m, "\n");
+
+	for (path = 0; path < 2; path++) {
+		mode = r->rwsi_mode(rtwdev, path);
+		seq_printf(m, "5G Antenna %d: [", path);
+		for (chidx = RTW_SAR_LMT_CH36_64; chidx <= RTW_SAR_LMT_CH149_165;
+		     chidx++) {
+			q3 = r->rwrd_base_q3(rtwdev, mode, path, chidx);
+			seq_printf(m, "%d.%d, ", q3_int(q3), q3_fra(q3));
+		}
+		seq_puts(m, "] dBm\n");
+	}
+	seq_puts(m, "\n");
+
+	seq_printf(m, "Dump Geo-SAR Table RAW DATA. (Total Count: %d)\n",
+		   r->rwgs_sz);
+	for (gi = 0; gi < r->rwgs_geos; gi++) {
+		seq_printf(m, "geo-%d: %*ph\n", gi, r->rwgs_sz / r->rwgs_geos,
+			   (u8 *)rwgs + gi * (r->rwgs_sz / r->rwgs_geos));
+	}
+	seq_puts(m, "\n");
+
+	gi = 1;	/* take index 1 as an example */
+	seq_puts(m, "Show Geo-SAR PowerLimit:\n");
+	seq_printf(m, "2G Geo Table Index: %d\n", gi);
+	seq_printf(m, "5G Geo Table Index: %d\n", gi);
+	for (band = RTW_SAR_RWGS_2G; band < RTW_SAR_RWGS_BAND_NR; band++) {
+		seq_puts(m, "\n");
+		seq_printf(m, "%dGHz:\n", band == 0 ? 2 : 5);
+		q3 = r->rwgs_max_q3(rtwdev, gi, band);
+		seq_printf(m, "Max Power: [%d.%d] dBm\n", q3_int(q3),
+			   q3_fra(q3));
+		for (path = 0; path < 2; path++) {
+			q3 = r->rwgs_delta_q3(rtwdev, gi, path, band);
+			seq_printf(m, "Ant-%d delta value: [%d.%d] dB\n", path,
+				   q3_int(q3), q3_fra(q3));
+		}
+	}
+}
+#endif
+
 static void rtw_sar_apply_dynamic_tables(struct rtw_dev *rtwdev)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
@@ -653,6 +738,13 @@ static int rtw_sar_load_dynamic_tables(struct rtw_dev *rtwdev)
 {
 	return -ENOENT;
 }
+
+#ifdef CONFIG_RTW88_DEBUGFS
+void rtw_sar_dump_via_debugfs(struct rtw_dev *rtwdev, struct seq_file *m)
+{
+	seq_puts(m, "(No SAR data)\n");
+}
+#endif
 #endif /* CONFIG_ACPI */
 
 void rtw_sar_load_table(struct rtw_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw88/sar.h b/drivers/net/wireless/realtek/rtw88/sar.h
index 154f7bce6759..1f7d877a3797 100644
--- a/drivers/net/wireless/realtek/rtw88/sar.h
+++ b/drivers/net/wireless/realtek/rtw88/sar.h
@@ -8,6 +8,7 @@
 void rtw_sar_load_table(struct rtw_dev *rtwdev);
 void rtw_sar_release_table(struct rtw_dev *rtwdev);
 void rtw_sar_work(struct work_struct *work);
+void rtw_sar_dump_via_debugfs(struct rtw_dev *rtwdev, struct seq_file *m);
 
 #define RTW_SAR_DELAY_TIME	(10 * HZ)
 
-- 
2.17.1

