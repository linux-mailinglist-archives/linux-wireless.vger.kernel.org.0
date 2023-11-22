Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF03D7F3DEA
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Nov 2023 07:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbjKVGGP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Nov 2023 01:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjKVGGL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Nov 2023 01:06:11 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4783D10C
        for <linux-wireless@vger.kernel.org>; Tue, 21 Nov 2023 22:06:07 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AM660gL42079019, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AM660gL42079019
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Nov 2023 14:06:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 22 Nov 2023 14:06:01 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 22 Nov
 2023 14:06:00 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <jamie_chen@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/4] wifi: rtw89: debug: add debugfs entry to disable dynamic mechanism
Date:   Wed, 22 Nov 2023 14:04:57 +0800
Message-ID: <20231122060458.30878-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122060458.30878-1-pkshih@realtek.com>
References: <20231122060458.30878-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.94]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A dynamic mechanism is usually an algorithm to adjust registers to adapt
to different environment every two seconds. In field, it could get
unexpected result, so we need to stop it and adjust registers manually, and
then fine tune the algorithm.

To stop mechanisms to assist debugging, add a debugfs entry shown as

  Disabled DM: 0x1
  [0] DYNAMIC_EDCCA: X

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h  |  5 ++
 drivers/net/wireless/realtek/rtw89/debug.c | 58 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.c   |  5 ++
 3 files changed, 68 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 429904987d2e..36f6a807d350 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4008,6 +4008,10 @@ struct rtw89_edcca_bak {
 	u8 th_old;
 };
 
+enum rtw89_dm_type {
+	RTW89_DM_DYNAMIC_EDCCA,
+};
+
 struct rtw89_hal {
 	u32 rx_fltr;
 	u8 cv;
@@ -4033,6 +4037,7 @@ struct rtw89_hal {
 	enum rtw89_entity_mode entity_mode;
 
 	struct rtw89_edcca_bak edcca_bak;
+	u32 disabled_dm_bitmap; /* bitmap of enum rtw89_dm_type */
 };
 
 #define RTW89_MAX_MAC_ID_NUM 128
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index a3f795d240ea..f914c0750576 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -3770,6 +3770,58 @@ static int rtw89_debug_priv_stations_get(struct seq_file *m, void *v)
 	return 0;
 }
 
+#define DM_INFO(type) {RTW89_DM_ ## type, #type}
+
+static const struct rtw89_disabled_dm_info {
+	enum rtw89_dm_type type;
+	const char *name;
+} rtw89_disabled_dm_infos[] = {
+	DM_INFO(DYNAMIC_EDCCA),
+};
+
+static int
+rtw89_debug_priv_disable_dm_get(struct seq_file *m, void *v)
+{
+	struct rtw89_debugfs_priv *debugfs_priv = m->private;
+	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+	const struct rtw89_disabled_dm_info *info;
+	struct rtw89_hal *hal = &rtwdev->hal;
+	u32 disabled;
+	int i;
+
+	seq_printf(m, "Disabled DM: 0x%x\n", hal->disabled_dm_bitmap);
+
+	for (i = 0; i < ARRAY_SIZE(rtw89_disabled_dm_infos); i++) {
+		info = &rtw89_disabled_dm_infos[i];
+		disabled = BIT(info->type) & hal->disabled_dm_bitmap;
+
+		seq_printf(m, "[%d] %s: %c\n", info->type, info->name,
+			   disabled ? 'X' : 'O');
+	}
+
+	return 0;
+}
+
+static ssize_t
+rtw89_debug_priv_disable_dm_set(struct file *filp, const char __user *user_buf,
+				size_t count, loff_t *loff)
+{
+	struct seq_file *m = (struct seq_file *)filp->private_data;
+	struct rtw89_debugfs_priv *debugfs_priv = m->private;
+	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+	struct rtw89_hal *hal = &rtwdev->hal;
+	u32 conf;
+	int ret;
+
+	ret = kstrtou32_from_user(user_buf, count, 0, &conf);
+	if (ret)
+		return -EINVAL;
+
+	hal->disabled_dm_bitmap = conf;
+
+	return count;
+}
+
 static struct rtw89_debugfs_priv rtw89_debug_priv_read_reg = {
 	.cb_read = rtw89_debug_priv_read_reg_get,
 	.cb_write = rtw89_debug_priv_read_reg_select,
@@ -3845,6 +3897,11 @@ static struct rtw89_debugfs_priv rtw89_debug_priv_stations = {
 	.cb_read = rtw89_debug_priv_stations_get,
 };
 
+static struct rtw89_debugfs_priv rtw89_debug_priv_disable_dm = {
+	.cb_read = rtw89_debug_priv_disable_dm_get,
+	.cb_write = rtw89_debug_priv_disable_dm_set,
+};
+
 #define rtw89_debugfs_add(name, mode, fopname, parent)				\
 	do {									\
 		rtw89_debug_priv_ ##name.rtwdev = rtwdev;			\
@@ -3885,6 +3942,7 @@ void rtw89_debugfs_init(struct rtw89_dev *rtwdev)
 	rtw89_debugfs_add_w(fw_log_manual);
 	rtw89_debugfs_add_r(phy_info);
 	rtw89_debugfs_add_r(stations);
+	rtw89_debugfs_add_rw(disable_dm);
 }
 #endif
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 3d5bd888218e..bfb1d8cfc531 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -5091,6 +5091,11 @@ void rtw89_phy_edcca_thre_calc(struct rtw89_dev *rtwdev)
 
 void rtw89_phy_edcca_track(struct rtw89_dev *rtwdev)
 {
+	struct rtw89_hal *hal = &rtwdev->hal;
+
+	if (hal->disabled_dm_bitmap & BIT(RTW89_DM_DYNAMIC_EDCCA))
+		return;
+
 	rtw89_phy_edcca_thre_calc(rtwdev);
 	rtw89_phy_edcca_log(rtwdev);
 }
-- 
2.25.1

