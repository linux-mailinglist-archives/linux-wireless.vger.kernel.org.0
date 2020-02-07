Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0AA15549D
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2020 10:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgBGJ2z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Feb 2020 04:28:55 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:44680 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgBGJ2y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Feb 2020 04:28:54 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 0179Smsj018556, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 0179Smsj018556
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Feb 2020 17:28:48 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 7 Feb 2020 17:28:48 +0800
Received: from RTEXMB06.realtek.com.tw (172.21.6.99) by
 RTEXMB03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 7 Feb 2020 17:28:48 +0800
Received: from RTITCASV01.realtek.com.tw (172.21.6.18) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1779.2
 via Frontend Transport; Fri, 7 Feb 2020 17:28:48 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Fri, 7 Feb 2020 17:28:47 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <pkshih@realtek.com>
Subject: [PATCH 2/8] nl80211: vendor-cmd: realtek: Add vendor command to set SAR power limit
Date:   Fri, 7 Feb 2020 17:28:38 +0800
Message-ID: <20200207092844.29175-3-yhchuang@realtek.com>
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

This is added to set SAR power limit, but doesn't replace existing
functionality.

Use 'iw' to set SAR power limit with ${p1,p2,p3,p4,p5} for five sub-bands:
sudo iw dev wlan0 vendor send 0x00E04C 0x88
0x68 0x00 0x01 0x80
0x14 0x00 0x01 0x80 0x08 0x00 0x02 0x00 0x00 0x00 0x00 0x00 0x05 0x00 0x03 0x00 $p1 0x00 0x00 0x00
0x14 0x00 0x02 0x80 0x08 0x00 0x02 0x00 0x01 0x00 0x00 0x00 0x05 0x00 0x03 0x00 $p2 0x00 0x00 0x00
0x14 0x00 0x03 0x80 0x08 0x00 0x02 0x00 0x02 0x00 0x00 0x00 0x05 0x00 0x03 0x00 $p3 0x00 0x00 0x00
0x14 0x00 0x04 0x80 0x08 0x00 0x02 0x00 0x03 0x00 0x00 0x00 0x05 0x00 0x03 0x00 $p4 0x00 0x00 0x00
0x14 0x00 0x05 0x80 0x08 0x00 0x02 0x00 0x04 0x00 0x00 0x00 0x05 0x00 0x03 0x00 $p5 0x00 0x00 0x00

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 include/uapi/nl80211-vnd-realtek.h | 72 ++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 include/uapi/nl80211-vnd-realtek.h

diff --git a/include/uapi/nl80211-vnd-realtek.h b/include/uapi/nl80211-vnd-realtek.h
new file mode 100644
index 000000000000..6b71de8d7cdf
--- /dev/null
+++ b/include/uapi/nl80211-vnd-realtek.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2018-2019  Realtek Corporation
+ */
+#ifndef _UAPI_NL80211_VND_REALTEK_H
+#define _UAPI_NL80211_VND_REALTEK_H
+
+/**
+ * This vendor ID is the value of atrribute %NL80211_ATTR_VENDOR_ID used by
+ * %NL80211_CMD_VENDOR to send vendor command.
+ */
+#define REALTEK_NL80211_VENDOR_ID	0x00E04C
+
+/**
+ * enum realtek_nl80211_vndcmd - supported vendor subcmds
+ *
+ * @REALTEK_NL80211_VNDCMD_SET_SAR: set SAR power limit
+ *	%realtek_vndcmd_sar_band within attribute %REALTEK_VNDCMD_ATTR_SAR_BAND
+ *	and corresponding power limit attribute %REALTEK_VNDCMD_ATTR_SAR_POWER.
+ *	The two attributes are in nested attribute %REALTEK_VNDCMD_ATTR_SAR_RULES.
+ */
+enum realtek_nl80211_vndcmd {
+	REALTEK_NL80211_VNDCMD_SET_SAR = 0x88,
+};
+
+/**
+ * enum realtek_vndcmd_sar_band - bands of SAR power limit
+ *
+ * @REALTEK_VNDCMD_SAR_BAND_2G: all channels of 2G band
+ * @REALTEK_VNDCMD_SAR_BAND_5G_BAND1: channels of 5G band1 (5.15~5.35G)
+ * @REALTEK_VNDCMD_SAR_BAND_5G_BAND2: channels of 5G band2 (5.35~5.47G)
+ *	5G band2 isn't used by rtw88 by now, so don't need to set SAR power
+ *	limit for this band. But we still enumerate this band as a placeholder
+ *	for the furture.
+ * @REALTEK_VNDCMD_SAR_BAND_5G_BAND3: channels of 5G band3 (5.47~5.725G)
+ * @REALTEK_VNDCMD_SAR_BAND_5G_BAND4: channels of 5G band4 (5.725~5.95G)
+ */
+enum realtek_vndcmd_sar_band {
+	REALTEK_VNDCMD_SAR_BAND_2G,
+	REALTEK_VNDCMD_SAR_BAND_5G_BAND1,
+	REALTEK_VNDCMD_SAR_BAND_5G_BAND2,
+	REALTEK_VNDCMD_SAR_BAND_5G_BAND3,
+	REALTEK_VNDCMD_SAR_BAND_5G_BAND4,
+
+	REALTEK_VNDCMD_SAR_BAND_NR,
+};
+
+/**
+ * enum realtek_vndcmd_sar_rule_attr - attributes of vendor command
+ *	%REALTEK_NL80211_VNDCMD_SET_SAR
+ *
+ * @REALTEK_VNDCMD_ATTR_SAR_RULES: nested attribute to hold SAR rules containing
+ *	band and corresponding power limit.
+ *
+ * @REALTEK_VNDCMD_ATTR_SAR_BAND: an attribute within %REALTEK_VNDCMD_ATTR_SAR_RULES,
+ *	and its value is %realtek_vndcmd_sar_band (u32 data type).
+ * @REALTEK_VNDCMD_ATTR_SAR_POWER: an attribute within %REALTEK_VNDCMD_ATTR_SAR_RULES.
+ *	SAR power limit is 'u8' type and in unit of 0.125 dBm, so its range is
+ *	0 to 31.875 dBm.
+ */
+enum realtek_vndcmd_sar_rule_attr {
+	__REALTEK_VNDCMD_SAR_RULE_ATTR_INVALID,
+
+	REALTEK_VNDCMD_ATTR_SAR_RULES,
+	REALTEK_VNDCMD_ATTR_SAR_BAND,
+	REALTEK_VNDCMD_ATTR_SAR_POWER,
+
+	/* keep last */
+	__REALTEK_VNDCMD_SAR_RULE_ATTR_AFTER_LAST,
+	REALTEK_VNDCMD_SAR_RULE_ATTR_MAX = __REALTEK_VNDCMD_SAR_RULE_ATTR_AFTER_LAST - 1,
+};
+
+#endif /* _UAPI_NL80211_VND_REALTEK_H */
-- 
2.17.1

