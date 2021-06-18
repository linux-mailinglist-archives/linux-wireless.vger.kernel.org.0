Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC2B3AC443
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 08:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbhFRGur (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 02:50:47 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:39037 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhFRGuq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 02:50:46 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 15I6mX6H1011508, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 15I6mX6H1011508
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Jun 2021 14:48:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 18 Jun 2021 14:48:33 +0800
Received: from localhost (172.16.16.17) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 18 Jun
 2021 14:48:32 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 23/24] rtw89: add SAR files
Date:   Fri, 18 Jun 2021 14:46:24 +0800
Message-ID: <20210618064625.14131-24-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210618064625.14131-1-pkshih@realtek.com>
References: <20210618064625.14131-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.17]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/18/2021 06:27:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzYvMTggpFekyCAwNjowMTowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/18/2021 06:23:56
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 164465 [Jun 18 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 448 448 71fb1b37213ce9a885768d4012c46ac449c77b17
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/18/2021 06:27:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SAR stands for specific absorption rate. Driver controls TX power to follow
the regulation of SAR.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/sar.c | 190 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/sar.h |  26 ++++
 2 files changed, 216 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/sar.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/sar.h

diff --git a/drivers/net/wireless/realtek/rtw89/sar.c b/drivers/net/wireless/realtek/rtw89/sar.c
new file mode 100644
index 000000000000..097c87899cea
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/sar.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2019-2020  Realtek Corporation
+ */
+
+#include "debug.h"
+#include "sar.h"
+
+static int rtw89_query_sar_config_common(struct rtw89_dev *rtwdev, s32 *cfg)
+{
+	struct rtw89_sar_cfg_common *rtwsar = &rtwdev->sar.cfg_common;
+	enum rtw89_subband subband = rtwdev->hal.current_subband;
+
+	if (!rtwsar->set[subband])
+		return -ENODATA;
+
+	*cfg = rtwsar->cfg[subband];
+	return 0;
+}
+
+static const
+struct rtw89_sar_handler rtw89_sar_handlers[RTW89_SAR_SOURCE_NR] = {
+	[RTW89_SAR_SOURCE_COMMON] = {
+		.descr_sar_source = "RTW89_SAR_SOURCE_COMMON",
+		.txpwr_factor_sar = 2,
+		.query_sar_config = rtw89_query_sar_config_common,
+	},
+};
+
+#define rtw89_sar_set_src(_dev, _src, _cfg_name, _cfg_data)		\
+	do {								\
+		typeof(_src) _s = (_src);				\
+		typeof(_dev) _d = (_dev);				\
+		BUILD_BUG_ON(!rtw89_sar_handlers[_s].descr_sar_source);	\
+		BUILD_BUG_ON(!rtw89_sar_handlers[_s].query_sar_config);	\
+		lockdep_assert_held(&_d->mutex);			\
+		_d->sar._cfg_name = *(_cfg_data);			\
+		_d->sar.src = _s;					\
+	} while (0)
+
+static s8 rtw89_txpwr_sar_to_mac(struct rtw89_dev *rtwdev, u8 fct, s32 cfg)
+{
+	const u8 fct_mac = rtwdev->chip->txpwr_factor_mac;
+	s32 cfg_mac;
+
+	cfg_mac = fct > fct_mac ?
+		  cfg >> (fct - fct_mac) : cfg << (fct_mac - fct);
+
+	return (s8)clamp_t(s32, cfg_mac,
+			   RTW89_SAR_TXPWR_MAC_MIN,
+			   RTW89_SAR_TXPWR_MAC_MAX);
+}
+
+s8 rtw89_query_sar(struct rtw89_dev *rtwdev)
+{
+	const enum rtw89_sar_sources src = rtwdev->sar.src;
+	/* its members are protected by rtw89_sar_set_src() */
+	const struct rtw89_sar_handler *sar_hdl = &rtw89_sar_handlers[src];
+	int ret;
+	s32 cfg;
+	u8 fct;
+
+	lockdep_assert_held(&rtwdev->mutex);
+
+	if (src == RTW89_SAR_SOURCE_NONE)
+		return RTW89_SAR_TXPWR_MAC_MAX;
+
+	ret = sar_hdl->query_sar_config(rtwdev, &cfg);
+	if (ret)
+		return RTW89_SAR_TXPWR_MAC_MAX;
+
+	fct = sar_hdl->txpwr_factor_sar;
+
+	return rtw89_txpwr_sar_to_mac(rtwdev, fct, cfg);
+}
+
+void rtw89_print_sar(struct seq_file *m, struct rtw89_dev *rtwdev)
+{
+	const enum rtw89_sar_sources src = rtwdev->sar.src;
+	/* its members are protected by rtw89_sar_set_src() */
+	const struct rtw89_sar_handler *sar_hdl = &rtw89_sar_handlers[src];
+	const u8 fct_mac = rtwdev->chip->txpwr_factor_mac;
+	int ret;
+	s32 cfg;
+	u8 fct;
+
+	lockdep_assert_held(&rtwdev->mutex);
+
+	if (src == RTW89_SAR_SOURCE_NONE) {
+		seq_puts(m, "no SAR is applied\n");
+		return;
+	}
+
+	seq_printf(m, "source: %d (%s)\n", src, sar_hdl->descr_sar_source);
+
+	ret = sar_hdl->query_sar_config(rtwdev, &cfg);
+	if (ret) {
+		seq_printf(m, "config: return code: %d\n", ret);
+		seq_printf(m, "assign: max setting: %d (unit: 1/%lu dBm)\n",
+			   RTW89_SAR_TXPWR_MAC_MAX, BIT(fct_mac));
+		return;
+	}
+
+	fct = sar_hdl->txpwr_factor_sar;
+
+	seq_printf(m, "config: %d (unit: 1/%lu dBm)\n", cfg, BIT(fct));
+}
+
+static int rtw89_apply_sar_common(struct rtw89_dev *rtwdev,
+				  const struct rtw89_sar_cfg_common *sar)
+{
+	enum rtw89_sar_sources src;
+	int ret = 0;
+
+	mutex_lock(&rtwdev->mutex);
+
+	src = rtwdev->sar.src;
+	if (src != RTW89_SAR_SOURCE_NONE && src != RTW89_SAR_SOURCE_COMMON) {
+		rtw89_warn(rtwdev, "SAR source: %d is in use", src);
+		ret = -EBUSY;
+		goto exit;
+	}
+
+	rtw89_sar_set_src(rtwdev, RTW89_SAR_SOURCE_COMMON, cfg_common, sar);
+	rtw89_chip_set_txpwr(rtwdev);
+
+exit:
+	mutex_unlock(&rtwdev->mutex);
+	return ret;
+}
+
+static const u8 rtw89_common_sar_subband_map[] = {
+	RTW89_CH_2G,
+	RTW89_CH_5G_BAND_1,
+	RTW89_CH_5G_BAND_3,
+	RTW89_CH_5G_BAND_4,
+};
+
+static const struct cfg80211_sar_freq_ranges rtw89_common_sar_freq_ranges[] = {
+	{ .start_freq = 2412, .end_freq = 2484, },
+	{ .start_freq = 5180, .end_freq = 5320, },
+	{ .start_freq = 5500, .end_freq = 5720, },
+	{ .start_freq = 5745, .end_freq = 5825, },
+};
+
+static_assert(ARRAY_SIZE(rtw89_common_sar_subband_map) ==
+	      ARRAY_SIZE(rtw89_common_sar_freq_ranges));
+
+const struct cfg80211_sar_capa rtw89_sar_capa = {
+	.type = NL80211_SAR_TYPE_POWER,
+	.num_freq_ranges = ARRAY_SIZE(rtw89_common_sar_freq_ranges),
+	.freq_ranges = rtw89_common_sar_freq_ranges,
+};
+
+int rtw89_ops_set_sar_specs(struct ieee80211_hw *hw,
+			    const struct cfg80211_sar_specs *sar)
+{
+	struct rtw89_dev *rtwdev = hw->priv;
+	struct rtw89_sar_cfg_common sar_common = {0};
+	u8 fct;
+	u32 freq_start;
+	u32 freq_end;
+	u32 band;
+	s32 power;
+	u32 i, idx;
+
+	if (sar->type != NL80211_SAR_TYPE_POWER)
+		return -EINVAL;
+
+	fct = rtw89_sar_handlers[RTW89_SAR_SOURCE_COMMON].txpwr_factor_sar;
+
+	for (i = 0; i < sar->num_sub_specs; i++) {
+		idx = sar->sub_specs[i].freq_range_index;
+		if (idx >= ARRAY_SIZE(rtw89_common_sar_freq_ranges))
+			return -EINVAL;
+
+		freq_start = rtw89_common_sar_freq_ranges[idx].start_freq;
+		freq_end = rtw89_common_sar_freq_ranges[idx].end_freq;
+		band = rtw89_common_sar_subband_map[idx];
+		power = sar->sub_specs[i].power;
+
+		rtw89_info(rtwdev, "On freq %u to %u, ", freq_start, freq_end);
+		rtw89_info(rtwdev, "set SAR power limit %d (unit: 1/%lu dBm)\n",
+			   power, BIT(fct));
+
+		sar_common.set[band] = true;
+		sar_common.cfg[band] = power;
+	}
+
+	return rtw89_apply_sar_common(rtwdev, &sar_common);
+}
diff --git a/drivers/net/wireless/realtek/rtw89/sar.h b/drivers/net/wireless/realtek/rtw89/sar.h
new file mode 100644
index 000000000000..7b5484c84eb1
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/sar.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2019-2020  Realtek Corporation
+ */
+
+#ifndef __RTW89_SAR_H__
+#define __RTW89_SAR_H__
+
+#include "core.h"
+
+#define RTW89_SAR_TXPWR_MAC_MAX S8_MAX
+#define RTW89_SAR_TXPWR_MAC_MIN S8_MIN
+
+struct rtw89_sar_handler {
+	const char *descr_sar_source;
+	u8 txpwr_factor_sar;
+	int (*query_sar_config)(struct rtw89_dev *rtwdev, s32 *cfg);
+};
+
+extern const struct cfg80211_sar_capa rtw89_sar_capa;
+
+s8 rtw89_query_sar(struct rtw89_dev *rtwdev);
+void rtw89_print_sar(struct seq_file *m, struct rtw89_dev *rtwdev);
+int rtw89_ops_set_sar_specs(struct ieee80211_hw *hw,
+			    const struct cfg80211_sar_specs *sar);
+
+#endif
-- 
2.25.1

