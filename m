Return-Path: <linux-wireless+bounces-21674-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C6EA91EE6
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB05446564E
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833BB24EAAE;
	Thu, 17 Apr 2025 13:55:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7B024EA9C
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898111; cv=none; b=QhZ2ly+KBY+dioVTnNVuHuEjDO/pwsp78aYBxXkRXWV1LVIq7ZeHzY8jQt4lr8a9V7f3SRTAaApPk9Y9+L4Sb4Ft37k7q77D59fbPa0L+yHZHweYa9p3LA5Gk88Ae57y823vFKkAsvUmcH5RbiuS+dXutjcnSj/G2UFfuSeMoVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898111; c=relaxed/simple;
	bh=amMD0tJarLEqIXW32riiTY3aTRG7oz5LqE4fSq3LO4k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=lKX+PEgS0S6XKCWeX/Rq9qVwCpei2gGIIKHjtAuhwjwrLgoSjmyVqp0mzpADUXgjaK8+XJlOqL+IdjAt7w8CySsMuxAh/OEX8zNam6h5YKCrXUWYYEM7d5vvlqTfOXAYI+Nb7AT5lbWwKGL7XNEG0Yj+FgMt7WdfJX2mpR5uRMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: Q1SvfPQ2QzmJVAb/2tnSBg==
X-CSE-MsgGUID: Pj1qgTh4QeWhjw0jtIFbVQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 17 Apr 2025 22:55:09 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 34470401009B;
	Thu, 17 Apr 2025 22:55:05 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 34/38] ra6w: add testmode.h
Date: Thu, 17 Apr 2025 16:52:32 +0300
Message-Id: <20250417135236.52410-35-oleksandr.savchenko.dn@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250417135236.52410-1-oleksandr.savchenko.dn@bp.renesas.com>
References: <20250417135236.52410-1-oleksandr.savchenko.dn@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Part of the split. Please, take a look at the cover letter for more details

Reviewed-by: Viktor Barna <viktor.barna.rj@bp.renesas.com>
Reviewed-by: Gal Gur <gal.gur.jx@renesas.com>
Signed-off-by: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
---
 drivers/net/wireless/renesas/ra6w/testmode.h | 150 +++++++++++++++++++
 1 file changed, 150 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/ra6w/testmode.h

diff --git a/drivers/net/wireless/renesas/ra6w/testmode.h b/drivers/net/wireless/renesas/ra6w/testmode.h
new file mode 100644
index 000000000000..eb4907137761
--- /dev/null
+++ b/drivers/net/wireless/renesas/ra6w/testmode.h
@@ -0,0 +1,150 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) [2022-2025] Renesas Electronics Corporation and/or its affiliates.
+ */
+#ifndef RA6W_TESTMODE_H
+#define RA6W_TESTMODE_H
+
+#ifdef CONFIG_NL80211_TESTMODE
+
+enum ra6w_testmode_cmd {
+	RA6W_TESTMODE_CMD_READ_REG = 1,
+	RA6W_TESTMODE_CMD_WRITE_REG,
+	RA6W_TESTMODE_CMD_LOGMODEFILTER_SET,
+	RA6W_TESTMODE_CMD_DBGLEVELFILTER_SET,
+	RA6W_TESTMODE_CMD_TX,
+	RA6W_TESTMODE_CMD_CW,
+	RA6W_TESTMODE_CMD_CONT,
+	RA6W_TESTMODE_CMD_CHANNEL,
+	RA6W_TESTMODE_CMD_PER,
+	RA6W_TESTMODE_CMD_RESET_HW,
+	RA6W_TESTMODE_CMD_HOST_LOG_LEVEL,
+	RA6W_TESTMODE_CMD_DBGOUTDIR_SET,
+	RA6W_TESTMODE_CMD_TX_POWER,
+	RA6W_TESTMODE_CMD_STATS_START,
+	RA6W_TESTMODE_CMD_STATS_STOP,
+	RA6W_TESTMODE_CMD_STATS_TX,
+	RA6W_TESTMODE_CMD_STATS_RX,
+	RA6W_TESTMODE_CMD_STATS_RSSI,
+	RA6W_TESTMODE_CMD_MAX,
+};
+
+enum ra6w_testmode_attr {
+	RA6W_TESTMODE_ATTR_NOT_APPLICABLE = 0,
+	RA6W_TESTMODE_ATTR_CMD,
+	RA6W_TESTMODE_ATTR_REG_OFFSET,
+	RA6W_TESTMODE_ATTR_REG_VALUE32,
+	RA6W_TESTMODE_ATTR_REG_FILTER,
+	RA6W_TESTMODE_ATTR_START,
+	RA6W_TESTMODE_ATTR_CH,
+	RA6W_TESTMODE_ATTR_FRAMES_NUM,
+	RA6W_TESTMODE_ATTR_FRAMES_LEN,
+	RA6W_TESTMODE_ATTR_RATE,
+	RA6W_TESTMODE_ATTR_POWER,
+	RA6W_TESTMODE_ATTR_ADDR_DEST,
+	RA6W_TESTMODE_ATTR_BSSID,
+	RA6W_TESTMODE_ATTR_GI,
+	RA6W_TESTMODE_ATTR_GREEN,
+	RA6W_TESTMODE_ATTR_PREAMBLE,
+	RA6W_TESTMODE_ATTR_QOS,
+	RA6W_TESTMODE_ATTR_ACK,
+	RA6W_TESTMODE_ATTR_AIFSN,
+	RA6W_TESTMODE_ATTR_PER_PASS,
+	RA6W_TESTMODE_ATTR_PER_FCS,
+	RA6W_TESTMODE_ATTR_PER_PHY,
+	RA6W_TESTMODE_ATTR_PER_OVERFLOW,
+	RA6W_TESTMODE_ATTR_HOST_LOG_LEVEL,
+	RA6W_TESTMODE_ATTR_STATS_READY,
+	RA6W_TESTMODE_ATTR_STATS_RSSI,
+	RA6W_TESTMODE_ATTR_STATS_BSSID,
+	RA6W_TESTMODE_ATTR_STATS_STAIDX,
+	RA6W_TESTMODE_ATTR_STATS_OWN_MAC,
+	RA6W_TESTMODE_ATTR_STATS_FLAGS,
+	RA6W_TESTMODE_ATTR_STATS_RX_BW,
+	RA6W_TESTMODE_ATTR_STATS_RX_MCS,
+	RA6W_TESTMODE_ATTR_STATS_RX_GI,
+	RA6W_TESTMODE_ATTR_STATS_RX_NSS,
+	RA6W_TESTMODE_ATTR_STATS_RX_CCK,
+	RA6W_TESTMODE_ATTR_STATS_RX_OFDM,
+	RA6W_TESTMODE_ATTR_STATS_RX_HT,
+	RA6W_TESTMODE_ATTR_STATS_RX_VHT,
+	RA6W_TESTMODE_ATTR_STATS_RX_HE_SU,
+	RA6W_TESTMODE_ATTR_STATS_RX_HE_MU,
+	RA6W_TESTMODE_ATTR_STATS_RX_HE_EXT,
+	RA6W_TESTMODE_ATTR_STATS_RX_HE_TRIG,
+	RA6W_TESTMODE_ATTR_STATS_TX_CCK,
+	RA6W_TESTMODE_ATTR_STATS_TX_CCK_FAIL,
+	RA6W_TESTMODE_ATTR_STATS_TX_OFDM,
+	RA6W_TESTMODE_ATTR_STATS_TX_OFDM_FAIL,
+	RA6W_TESTMODE_ATTR_STATS_TX_HT,
+	RA6W_TESTMODE_ATTR_STATS_TX_HT_FAIL,
+	RA6W_TESTMODE_ATTR_STATS_TX_VHT,
+	RA6W_TESTMODE_ATTR_STATS_TX_VHT_FAIL,
+	RA6W_TESTMODE_ATTR_STATS_TX_HE,
+	RA6W_TESTMODE_ATTR_STATS_TX_HE_FAIL,
+	RA6W_TESTMODE_ATTR_STATS_TX_EPR,
+	RA6W_TESTMODE_ATTR_MAX,
+};
+
+enum {
+	RA6W_TESTMODE_VALUE_STOP = 0,
+	RA6W_TESTMODE_VALUE_START,
+};
+
+enum ra6w_testmode_value_per {
+	RA6W_TESTMODE_VALUE_PER_STOP = 0,
+	RA6W_TESTMODE_VALUE_PER_START,
+	RA6W_TESTMODE_VALUE_PER_GET,
+	RA6W_TESTMODE_VALUE_PER_RESET,
+};
+
+enum ra6w_testmode_rate {
+	RA6W_TESTMODE_RATE_B1 = 0,
+	RA6W_TESTMODE_RATE_B2,
+	RA6W_TESTMODE_RATE_B5_5,
+	RA6W_TESTMODE_RATE_B11,
+	RA6W_TESTMODE_RATE_G6,
+	RA6W_TESTMODE_RATE_G9,
+	RA6W_TESTMODE_RATE_G12,
+	RA6W_TESTMODE_RATE_G18,
+	RA6W_TESTMODE_RATE_G24,
+	RA6W_TESTMODE_RATE_G36,
+	RA6W_TESTMODE_RATE_G48,
+	RA6W_TESTMODE_RATE_G54,
+	RA6W_TESTMODE_RATE_N6_5,
+	RA6W_TESTMODE_RATE_N13,
+	RA6W_TESTMODE_RATE_N19_5,
+	RA6W_TESTMODE_RATE_N26,
+	RA6W_TESTMODE_RATE_N39,
+	RA6W_TESTMODE_RATE_N52,
+	RA6W_TESTMODE_RATE_N58_5,
+	RA6W_TESTMODE_RATE_N65,
+};
+
+enum {
+	RA6W_TESTMODE_VALUE_SHORT = 0,
+	RA6W_TESTMODE_VALUE_LONG,
+};
+
+enum {
+	RA6W_TESTMODE_VALUE_OFF = 0,
+	RA6W_TESTMODE_VALUE_ON,
+};
+
+enum {
+	RA6W_TESTMODE_VALUE_NO = 0,
+	RA6W_TESTMODE_VALUE_NORM,
+	RA6W_TESTMODE_VALUE_BA,
+	RA6W_TESTMODE_VALUE_CBA,
+};
+
+int ra6w_testmode_cmd(struct wiphy *wiphy, struct wireless_dev *wdev, void *data, int len);
+#else
+static inline int ra6w_testmode_cmd(struct wiphy *wiphy, struct wireless_dev *wdev,
+				    void *data, int len)
+{
+	return 0;
+}
+#endif /* CONFIG_NL80211_TESTMODE */
+
+#endif // RA6W_TESTMODE_H
-- 
2.17.1


