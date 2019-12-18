Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC24124C1D
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 16:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfLRPsj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 10:48:39 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:20215 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727114AbfLRPsj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 10:48:39 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576684118; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=Ts/SoN8mMCn5XP7ft2oCeu5tzE14MHymrYQPG4etVSE=; b=PQ6jfDheJwx1XC9+7bl9v2E3m7TXz8YT+fobJnS3FT2v23cepsvNsEJyHyl6B9nKwL2x/ugJ
 TpkXT2lZ3QTPpPb/rYJd4YSceTT0CKsOo8jcVQSk7pOmza3LxZNcaKsaCzR8akEKk6rxEjqL
 q+G3QFoyQ5rivDhjLI2jndriURc=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfa4a53.7f9289a085a8-smtp-out-n01;
 Wed, 18 Dec 2019 15:48:35 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F386DC447A0; Wed, 18 Dec 2019 15:48:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7214EC433CB;
        Wed, 18 Dec 2019 15:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7214EC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] nl80211: vendor-cmd: qca: add dynamic SAR power limits
Date:   Wed, 18 Dec 2019 17:48:27 +0200
Message-Id: <1576684108-30177-2-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576684108-30177-1-git-send-email-kvalo@codeaurora.org>
References: <1576684108-30177-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wen Gong <wgong@codeaurora.org>

The vendor commands is to add API for user to configure dynamic SAR
power limits, it will not replace the existing power control
functionality, it is to make more convenient to configure power.

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
 include/uapi/nl80211-vnd-qca.h | 68 ++++++++++++++++++++++++++++++++++++++++++
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
2.7.4
