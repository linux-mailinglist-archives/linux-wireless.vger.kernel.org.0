Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B4E1DAA58
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2020 08:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgETGGA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 May 2020 02:06:00 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:37781 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725998AbgETGF7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 May 2020 02:05:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589954759; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=+bNZiCgn+kIot6UbRmEJ28emF9HD/eUzgj8mWyuR3CQ=; b=RT/gzKasGwSwKl6DjSayo5UVf1jyiDT+soSL8JKzFu/skSnMX8uZchxqOI51A6oj70r/03wj
 BOXuy1VuAhdUGFZ1xUAkqe2jfzsFj1beuPmVyqr1OkaHRdCQ9eV/hO+3fzk321tYZ8nB8ocu
 I7pNOfUr9DRiq0wMxrYwObGFO78=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5ec4c8c6fab7128bf3b153f2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 20 May 2020 06:05:58
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AFA75C433CA; Wed, 20 May 2020 06:05:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vnaralas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C480FC433C6;
        Wed, 20 May 2020 06:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C480FC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vnaralas@codeaurora.org
From:   Venkateswara Naralasetty <vnaralas@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Venkateswara Naralasetty <vnaralas@codeaurora.org>
Subject: [PATCH 1/2] nl80211: vendor-cmd: qca: add command for ap power save
Date:   Wed, 20 May 2020 11:35:44 +0530
Message-Id: <1589954745-12870-1-git-send-email-vnaralas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch is to add vendor command support to enable/disable
ap power save.

An example of usage: iw dev wlanx vendor send 0x1374 0x4a ap-ps <val>

0x1374: vendor id
0x4a: vendor subcmd id
val: 0 - disable power save
     1 - enable power save

Signed-off-by: Venkateswara Naralasetty <vnaralas@codeaurora.org>
---
 include/uapi/nl80211-vnd-qca.h | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 include/uapi/nl80211-vnd-qca.h

diff --git a/include/uapi/nl80211-vnd-qca.h b/include/uapi/nl80211-vnd-qca.h
new file mode 100644
index 0000000..357040a
--- /dev/null
+++ b/include/uapi/nl80211-vnd-qca.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2019-2020 The Linux Foundation. All rights reserved.
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
+ * @QCA_NL80211_VENDOR_SUBCMD_SET_WIFI_CONFIGURATION: This vendor subcommand is
+ * used to set wifi configurations by the attributes defined in
+ * enum qca_wlan_vendor_attr_config.
+ */
+enum qca_nl80211_vendor_subcmds {
+	QCA_NL80211_VENDOR_SUBCMD_SET_WIFI_CONFIGURATION = 74,
+};
+
+/**
+ * enum qca_wlan_vendor_attr_config: Attributes for data used by
+ * QCA_NL80211_VENDOR_SUBCMD_SET_WIFI_CONFIGURATION.
+ *
+ * @QCA_WLAN_VENDOR_ATTR_CONFIG_GTX: 8-bit unsigned value to trigger
+ * green Tx power saving 1-Enable, 0-Disable.
+ */
+enum qca_wlan_vendor_attr_config {
+	QCA_WLAN_VENDOR_ATTR_CONFIG_GTX = 57,
+
+	QCA_WLAN_VENDOR_ATTR_CONFIG_AFTER_LAST,
+	QCA_WLAN_VENDOR_ATTR_CONFIG_MAX =
+		QCA_WLAN_VENDOR_ATTR_CONFIG_AFTER_LAST - 1,
+};
+#endif /* _UAPI_NL80211_VND_QCA_H_ */
-- 
2.7.4

