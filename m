Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8861E22E4AE
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jul 2020 06:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgG0ER5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jul 2020 00:17:57 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:25740 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgG0ER4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jul 2020 00:17:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595823475; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=zh2nQjBxqCSOZ1rYXfVbtMckbmrDCi1vOVN8FfVH2ZY=; b=WRAV1uFhs4FVvY+KgdOX1kt9VRH4cqdDEMTNDb4F9yeAtmcnBp/yXqojqhXz884AX2qWkr+V
 7dpfA2fGWx0ig62wlXCNP4JsNkCwdK73tONFU28AfG+CT4LicioHAlgxUoc81pUk+7+85fiF
 RspZ7Dxmcqrth5GHxTgTn2AuPBA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-east-1.postgun.com with SMTP id
 5f1e555f8db7256a95d83cc7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 27 Jul 2020 04:17:35
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2C6D6C43395; Mon, 27 Jul 2020 04:17:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from gongwen-ThinkPad-T420.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ADD07C433CB;
        Mon, 27 Jul 2020 04:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ADD07C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v2 1/2] nl80211: vendor-cmd: qca: add dynamic SAR power limits
Date:   Mon, 27 Jul 2020 12:17:37 +0800
Message-Id: <1595823458-3926-2-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595823458-3926-1-git-send-email-wgong@codeaurora.org>
References: <1595823458-3926-1-git-send-email-wgong@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The vendor commands is to add API for user to configure dynamic SAR
power limits, it will not replace the existing power control
functionality, it is to make more convenient to configure power.

For different chips and drivers, they has different configuration, such
as dBm units, 5G Hz subbands, valid range, etc. so user space can not
know what configuration should be used. If use a common API for all
chips and drivers, then it need a reporting API too, so drivers can
tell what configuration it support. Recently it is better to use this
vendor-cmd for different chips and drivers.

An example of usage(wlan0 is the wireless interface dev name):
iw dev wlan0 vendor send 0x1374 0x92 0x2C 0x00 0x03 0x00 0x14 0x00 0x01
0x00 0x08 0x00 0x07 0x00 0x22 0x00 0x00 0x00 0x08 0x00 0x04 0x00 0x00
0x00 0x00 0x00 0x14 0x00 0x02 0x00 0x08 0x00 0x07 0x00 0x11 0x00 0x00
0x00 0x08 0x00 0x04 0x00 0x01 0x00 0x00 0x00

means of bytes:
0x1374: vendor id
0x92: vendor subcmd id
0x22: 2.4G power limit
0x11: 5G power limit

Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00029.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 include/uapi/nl80211-vnd-qca.h | 68 ++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 include/uapi/nl80211-vnd-qca.h

diff --git a/include/uapi/nl80211-vnd-qca.h b/include/uapi/nl80211-vnd-qca.h
new file mode 100644
index 000000000000..482c9409a2c0
--- /dev/null
+++ b/include/uapi/nl80211-vnd-qca.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2019 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _UAPI_NL80211_VND_QCA_H
+#define _UAPI_NL80211_VND_QCA_H
+
+/* Vendor id to be used in vendor specific command and events to user space
+ * NOTE: The authoritative place for definition of QCA_NL80211_VENDOR_ID,
+ * vendor subcmd definitions prefixed with QCA_NL80211_VENDOR_SUBCMD, and
+ * qca_wlan_vendor_attr is open source file src/common/qca-vendor.h in
+ * git://w1.fi/srv/git/hostap.git; the values here are just a copy of that
+ */
+#define QCA_NL80211_VENDOR_ID 0x001374
+
+/**
+ * enum qca_nl80211_vendor_subcmds - QCA nl80211 vendor command identifiers
+ *
+ *@QCA_NL80211_VENDOR_SUBCMD_SET_SAR_LIMITS and is used to retrieve the
+ *	settings currently in use. The attributes returned by this command are
+ *	defined by enum qca_vendor_attr_sar_limits.
+ */
+enum qca_nl80211_vendor_subcmds {
+	QCA_NL80211_VENDOR_SUBCMD_SET_SAR_LIMITS = 146,
+	};
+
+/**
+ * enum qca_vendor_attr_sar_limits - Attributes for SAR power limits
+ *
+ * @QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_SPEC: Nested array of SAR power
+ *	limit specifications. The number of specifications is
+ *	specified by @QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_NUM_SPECS. Each
+ *	specification contains a set of
+ *	QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_SPEC_* attributes. A
+ *	specification is uniquely identified by the attributes
+ *	%QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_SPEC_BAND and always
+ *	contains as a payload the attribute
+ *	%QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_SPEC_POWER_LIMIT.
+ *
+ * @QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_SPEC_BAND: Optional (u32) value to
+ *	indicate for which band this specification applies. Valid
+ *	values are enumerated in enum %nl80211_band (although not all
+ *	bands may be supported by a given device). If the attribute is
+ *	not supplied then the specification will be applied to all
+ *	supported bands.
+ *
+ * @QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_SPEC_POWER_LIMIT: Required (u32)
+ *	value to specify the actual power limit value in units of 0.5
+ *	dBm (i.e., a value of 11 represents 5.5 dBm).
+ *	This is required, when %QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_SELECT is
+ *	%QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_SELECT_USER.
+ *
+ * These attributes are used with %QCA_NL80211_VENDOR_SUBCMD_SET_SAR_LIMITS
+ * and %QCA_NL80211_VENDOR_SUBCMD_GET_SAR_LIMITS.
+ */
+enum qca_vendor_attr_sar_limits {
+	QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_INVALID = 0,
+	QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_SPEC = 3,
+	QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_SPEC_BAND = 4,
+	QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_SPEC_POWER_LIMIT = 7,
+
+	QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_AFTER_LAST,
+	QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_MAX =
+		QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_AFTER_LAST - 1
+};
+
+#endif /* _UAPI_NL80211_VND_QCA_H_ */
-- 
2.23.0

