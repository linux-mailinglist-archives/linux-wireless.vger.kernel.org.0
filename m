Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DD224F3FC
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Aug 2020 10:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgHXI1D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Aug 2020 04:27:03 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:36729 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbgHXI1C (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Aug 2020 04:27:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598257621; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=c/x6JXImN8vWdxQWZdIwU46g75ZKMtLZKGunCqSnPAk=; b=DTWOGwfdFRWwsgtua4U3Iuc0RS2FwgGMTYGNcKVf7vdcW0O322UyABYL7RF2ViiYnrCm41ET
 kfl76TtPoCgZmR56cjspVHXVertdGjX5l0ONTlAoNyUHoGabzujLIIq2ujwbn+mwyR+uRFUe
 IVCplJMPXPUT+jyr6PqirEzRVW8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f4379c1af2691fc9cc9bb24 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 24 Aug 2020 08:26:41
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 61335C433CB; Mon, 24 Aug 2020 08:26:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vnaralas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8E1FCC433C6;
        Mon, 24 Aug 2020 08:26:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8E1FCC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vnaralas@codeaurora.org
From:   Venkateswara Naralasetty <vnaralas@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Venkateswara Naralasetty <vnaralas@codeaurora.org>
Subject: [PATCHv2 1/2] nl80211: vendor-cmd: qca: add command for ap power save
Date:   Mon, 24 Aug 2020 13:56:28 +0530
Message-Id: <1598257589-19091-1-git-send-email-vnaralas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

AP power save feature is to save power in AP mode, where AP goes
to power save mode when no stations associate to it and comes out
of power save when any station associate to AP.

This patch is to add vendor command support to enable/disable
ap power save.

An example of usage: iw dev wlanx vendor send 0x1374 0x4a ap-ps <val>

0x1374: vendor id
0x4a: vendor subcmd id
val: 0 - disable power save
     1 - enable power save

Signed-off-by: Venkateswara Naralasetty <vnaralas@codeaurora.org>
---
v2:
 * added use case in the commit log.

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

