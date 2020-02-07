Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBBD515549E
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2020 10:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgBGJ24 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Feb 2020 04:28:56 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:44685 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgBGJ2z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Feb 2020 04:28:55 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 0179SnTE018560, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 0179SnTE018560
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Feb 2020 17:28:49 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 7 Feb 2020 17:28:49 +0800
Received: from RTEXMB06.realtek.com.tw (172.21.6.99) by
 RTEXMB01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 7 Feb 2020 17:28:49 +0800
Received: from RTITCASV01.realtek.com.tw (172.21.6.18) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1779.2
 via Frontend Transport; Fri, 7 Feb 2020 17:28:49 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Fri, 7 Feb 2020 17:28:48 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <pkshih@realtek.com>
Subject: [PATCH 3/8] rtw88: vndcmd: sar: Apply SAR power limit via vendor command
Date:   Fri, 7 Feb 2020 17:28:39 +0800
Message-ID: <20200207092844.29175-4-yhchuang@realtek.com>
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

Use 'iw' vendor command to send SAR power limit table to driver that
converts power limit unit from dBm to rtw88's power_index. When channel is
changed, SAR power limit plays as a constraint to calculate TX power.

When a vendor command is recevied, kernel log shows like
  rtw_pci 0000:03:00.0: set SAR power limit 16.500 on band 0
  rtw_pci 0000:03:00.0: set SAR power limit 13.125 on band 1
  rtw_pci 0000:03:00.0: set SAR power limit 18.000 on band 3
  rtw_pci 0000:03:00.0: set SAR power limit 19.000 on band 4

Then, apply SAR power limit to all regions if no other SAR source is in use.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/Makefile |   1 +
 drivers/net/wireless/realtek/rtw88/main.c   |   2 +
 drivers/net/wireless/realtek/rtw88/vndcmd.c | 131 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/vndcmd.h |  10 ++
 4 files changed, 144 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw88/vndcmd.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/vndcmd.h

diff --git a/drivers/net/wireless/realtek/rtw88/Makefile b/drivers/net/wireless/realtek/rtw88/Makefile
index cac148d13cf1..935333f734a9 100644
--- a/drivers/net/wireless/realtek/rtw88/Makefile
+++ b/drivers/net/wireless/realtek/rtw88/Makefile
@@ -16,6 +16,7 @@ rtw88-y += main.o \
 	   sec.o \
 	   bf.o \
 	   wow.o \
+	   vndcmd.o \
 	   regd.o
 
 rtw88-$(CONFIG_RTW88_8822BE)	+= rtw8822b.o rtw8822b_table.o
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 2845d2838f7b..7156a06eea74 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -15,6 +15,7 @@
 #include "tx.h"
 #include "debug.h"
 #include "bf.h"
+#include "vndcmd.h"
 
 unsigned int rtw_fw_lps_deep_mode;
 EXPORT_SYMBOL(rtw_fw_lps_deep_mode);
@@ -1498,6 +1499,7 @@ int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 	SET_IEEE80211_PERM_ADDR(hw, rtwdev->efuse.addr);
 
 	rtw_regd_init(rtwdev, rtw_regd_notifier);
+	rtw_register_vndcmd(hw);
 
 	ret = ieee80211_register_hw(hw);
 	if (ret) {
diff --git a/drivers/net/wireless/realtek/rtw88/vndcmd.c b/drivers/net/wireless/realtek/rtw88/vndcmd.c
new file mode 100644
index 000000000000..64c68239d28d
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/vndcmd.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2018-2019  Realtek Corporation
+ */
+
+#include <uapi/nl80211-vnd-realtek.h>
+
+#include "main.h"
+#include "phy.h"
+#include "debug.h"
+
+static const struct nla_policy
+rtw_sar_rule_policy[REALTEK_VNDCMD_SAR_RULE_ATTR_MAX + 1] = {
+	[REALTEK_VNDCMD_ATTR_SAR_RULES] = { .type = NLA_NESTED_ARRAY },
+	[REALTEK_VNDCMD_ATTR_SAR_BAND]	= { .type = NLA_U32 },
+	[REALTEK_VNDCMD_ATTR_SAR_POWER]	= { .type = NLA_U8 },
+};
+
+static const struct sar_band2ch {
+	u8 ch_start;
+	u8 ch_end;
+} sar_band2chs[REALTEK_VNDCMD_SAR_BAND_NR] = {
+	[REALTEK_VNDCMD_SAR_BAND_2G]	   = { .ch_start = 1,   .ch_end = 14 },
+	[REALTEK_VNDCMD_SAR_BAND_5G_BAND1] = { .ch_start = 36,  .ch_end = 64 },
+	/* REALTEK_VNDCMD_SAR_BAND_5G_BAND2 isn't used by now. */
+	[REALTEK_VNDCMD_SAR_BAND_5G_BAND3] = { .ch_start = 100, .ch_end = 144 },
+	[REALTEK_VNDCMD_SAR_BAND_5G_BAND4] = { .ch_start = 149, .ch_end = 165 },
+};
+
+static int rtw_apply_vndcmd_sar(struct rtw_dev *rtwdev, u32 band, u8 power)
+{
+	const struct sar_band2ch *sar_band2ch;
+	u8 path, rd;
+
+	if (band >= REALTEK_VNDCMD_SAR_BAND_NR)
+		return -EINVAL;
+
+	sar_band2ch = &sar_band2chs[band];
+	if (!sar_band2ch->ch_start || !sar_band2ch->ch_end)
+		return 0;
+
+	/* SAR values from vendor command apply to all regulatory domains,
+	 * and we can still ensure TX power under power limit because of
+	 * "tx_power = base + min(by_rate, limit, sar)".
+	 */
+	for (path = 0; path < rtwdev->hal.rf_path_num; path++)
+		for (rd = 0; rd < RTW_REGD_MAX; rd++)
+			rtw_phy_set_tx_power_sar(rtwdev, rd, path,
+						 sar_band2ch->ch_start,
+						 sar_band2ch->ch_end, power);
+
+	rtw_info(rtwdev, "set SAR power limit %u.%03u on band %u\n",
+		 power >> 3, (power & 7) * 125, band);
+
+	rtwdev->sar.source = RTW_SAR_SOURCE_VNDCMD;
+
+	return 0;
+}
+
+static int rtw_vndcmd_set_sar(struct wiphy *wiphy, struct wireless_dev *wdev,
+			      const void *data, int data_len)
+{
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+	struct rtw_dev *rtwdev = hw->priv;
+	struct rtw_hal *hal = &rtwdev->hal;
+	struct nlattr *tb_root[REALTEK_VNDCMD_SAR_RULE_ATTR_MAX + 1];
+	struct nlattr *tb[REALTEK_VNDCMD_SAR_RULE_ATTR_MAX + 1];
+	struct nlattr *nl_sar_rule;
+	int rem_sar_rules, r;
+	u32 band;
+	u8 power;
+
+	if (rtwdev->sar.source != RTW_SAR_SOURCE_NONE &&
+	    rtwdev->sar.source != RTW_SAR_SOURCE_VNDCMD) {
+		rtw_info(rtwdev, "SAR source 0x%x is in use", rtwdev->sar.source);
+		return -EBUSY;
+	}
+
+	r = nla_parse(tb_root, REALTEK_VNDCMD_SAR_RULE_ATTR_MAX, data, data_len,
+		      rtw_sar_rule_policy, NULL);
+	if (r) {
+		rtw_warn(rtwdev, "invalid SAR attr\n");
+		return r;
+	}
+
+	if (!tb_root[REALTEK_VNDCMD_ATTR_SAR_RULES]) {
+		rtw_warn(rtwdev, "no SAR rule attr\n");
+		return -EINVAL;
+	}
+
+	nla_for_each_nested(nl_sar_rule, tb_root[REALTEK_VNDCMD_ATTR_SAR_RULES],
+			    rem_sar_rules) {
+		r = nla_parse_nested(tb, REALTEK_VNDCMD_SAR_RULE_ATTR_MAX,
+				     nl_sar_rule, rtw_sar_rule_policy, NULL);
+		if (r)
+			return r;
+		if (!tb[REALTEK_VNDCMD_ATTR_SAR_BAND])
+			return -EINVAL;
+		if (!tb[REALTEK_VNDCMD_ATTR_SAR_POWER])
+			return -EINVAL;
+
+		band = nla_get_u32(tb[REALTEK_VNDCMD_ATTR_SAR_BAND]);
+		power = nla_get_u8(tb[REALTEK_VNDCMD_ATTR_SAR_POWER]);
+
+		r = rtw_apply_vndcmd_sar(rtwdev, band, power);
+		if (r)
+			return r;
+	}
+
+	rtw_phy_set_tx_power_level(rtwdev, hal->current_channel);
+
+	return 0;
+}
+
+static const struct wiphy_vendor_command rtw88_vendor_commands[] = {
+	{
+		.info = {
+			.vendor_id = REALTEK_NL80211_VENDOR_ID,
+			.subcmd = REALTEK_NL80211_VNDCMD_SET_SAR,
+		},
+		.flags = WIPHY_VENDOR_CMD_NEED_WDEV,
+		.doit = rtw_vndcmd_set_sar,
+		.policy = rtw_sar_rule_policy,
+		.maxattr = REALTEK_VNDCMD_SAR_RULE_ATTR_MAX,
+	}
+};
+
+void rtw_register_vndcmd(struct ieee80211_hw *hw)
+{
+	hw->wiphy->vendor_commands = rtw88_vendor_commands;
+	hw->wiphy->n_vendor_commands = ARRAY_SIZE(rtw88_vendor_commands);
+}
diff --git a/drivers/net/wireless/realtek/rtw88/vndcmd.h b/drivers/net/wireless/realtek/rtw88/vndcmd.h
new file mode 100644
index 000000000000..c56f69f9bf36
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/vndcmd.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2018-2019  Realtek Corporation
+ */
+
+#ifndef __RTW_VNDCMD_H__
+#define __RTW_VNDCMD_H__
+
+void rtw_register_vndcmd(struct ieee80211_hw *hw);
+
+#endif /* __RTW_VNDCMD_H__ */
-- 
2.17.1

