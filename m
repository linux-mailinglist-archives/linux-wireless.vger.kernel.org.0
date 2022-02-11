Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D88E4B28BD
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Feb 2022 16:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351214AbiBKPIN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Feb 2022 10:08:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239481AbiBKPIM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Feb 2022 10:08:12 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB59A9
        for <linux-wireless@vger.kernel.org>; Fri, 11 Feb 2022 07:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644592090; x=1676128090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=mti1vG6w+K4lCasilkLEwqCBOg+fp+dKorwiFQkDPeE=;
  b=KZG/wtlyh0zkE/JZblEIxdVH6HrMuag43rtUhflpMzlJ2y20tuqvpKAy
   LAGdUdQWRIDjGKUlr9dWY5LN7Is/a0GjYLDNtnOatWYO5lk6iQNp1t3kG
   ATvyzx+Cue31l5EFYCRV1EBhUIEO/4KbVVIRFrqYw3Jlk7u5ys+nrXVKY
   Y=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 11 Feb 2022 07:08:10 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 07:08:10 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 11 Feb 2022 07:08:09 -0800
Received: from vnaralas-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 11 Feb 2022 07:08:07 -0800
From:   Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Subject: [PATCH 1/6] nl80211: vendor-cmd: qca: add command for CFR configuration
Date:   Fri, 11 Feb 2022 20:37:50 +0530
Message-ID: <1644592075-27082-2-git-send-email-quic_vnaralas@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644592075-27082-1-git-send-email-quic_vnaralas@quicinc.com>
References: <1644592075-27082-1-git-send-email-quic_vnaralas@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch is to add vendor command support to configure per
peer CFR parameters.

An example of usage:
iw dev wlanx vendor send 0x1374 0xad cfr-en <val> bw <bw> method <method>
periodicity <period> addr <mac_addr>

0x1374: vendor id
0xad: : vendor subcmd id
val: 0 to disable CFR capture
     1 to enable CFR capture

bw: CFR capture bandwidth(use the values in enum nl80211_chan_width)
	1 - 20MHZ
	2 - 40MHZ
	3 - 80MHZ

method: Method used by hardware to collect the CFR dump
	0 - from the ACKs of QOS NULL packets
	1 - from the ACKs of QOS NULL packets with phase
	2 - from the ACK of probe response packet

periodicity: Periodicity in ms at which CFR dump need to be collect
	0 - single shot capture
	non zero - for Periodic captures

mac_addr: mac address of the peer for which CFR capture is requested.

Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
---
 include/uapi/linux/nl80211-vnd-qca.h | 104 +++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 include/uapi/linux/nl80211-vnd-qca.h

diff --git a/include/uapi/linux/nl80211-vnd-qca.h b/include/uapi/linux/nl80211-vnd-qca.h
new file mode 100644
index 0000000..3c1158d
--- /dev/null
+++ b/include/uapi/linux/nl80211-vnd-qca.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Qualcomm Atheros OUI and vendor specific assignments
+ * Copyright (c) 2014-2017, Qualcomm Atheros, Inc.
+ * Copyright (c) 2018-2020, The Linux Foundation
+ * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights
+ */
+
+#ifndef _UAPI_NL80211_VND_QCA_H
+#define _UAPI_NL80211_VND_QCA_H
+
+
+/* Vendor id to be used in vendor specific command and events to user space
+ * NOTE: The authoritative place for definition of QCA_NL80211_VENDOR_ID,
+ * vendor subcmd definitions prefixed with QCA_NL80211_VENDOR_SUBCMD, and
+ * qca_wlan_vendor_attr is open source file src/common/qca-vendor.h in
+ * git://w1.fi/srv/git/hostap.git; the values here are just a copy of that
+ */
+#define OUI_QCA 0x001374
+
+/**
+ * enum qca_nl80211_vendor_subcmds - QCA nl80211 vendor command identifiers
+ * @QCA_NL80211_VENDOR_SUBCMD_PEER_CFR_CAPTURE_CFG: This command is used to
+ * configure parameters per peer to capture Channel Frequency Response
+ * (CFR) and enable Periodic CFR capture. The attributes for this command
+ * are defined in enum qca_wlan_vendor_peer_cfr_capture_attr. This command
+ * can also be used to send CFR data from the driver to userspace when
+ * netlink events are used to send CFR data.
+ *
+ */
+enum qca_nl80211_vendor_subcmds {
+	QCA_NL80211_VENDOR_SUBCMD_PEER_CFR_CAPTURE_CFG = 173,
+};
+
+/**
+ * enum qca_wlan_vendor_cfr_method - QCA vendor CFR methods used by
+ * attribute QCA_WLAN_VENDOR_ATTR_PEER_CFR_METHOD as part of vendor
+ * command QCA_NL80211_VENDOR_SUBCMD_PEER_CFR_CAPTURE_CFG.
+ * @QCA_WLAN_VENDOR_CFR_METHOD_QOS_NULL: CFR method using QoS Null frame
+ * @QCA_WLAN_VENDOR_CFR_QOS_NULL_WITH_PHASE: CFR method using QoS Null frame
+ * with phase
+ * @QCA_WLAN_VENDOR_CFR_PROBE_RESPONSE: CFR method using Probe Response frame
+ */
+enum qca_wlan_vendor_cfr_method {
+	QCA_WLAN_VENDOR_CFR_METHOD_QOS_NULL = 0,
+	QCA_WLAN_VENDOR_CFR_QOS_NULL_WITH_PHASE = 1,
+	QCA_WLAN_VENDOR_CFR_PROBE_RESPONSE = 2,
+};
+
+/**
+ * enum qca_wlan_vendor_peer_cfr_capture_attr - Used by the vendor command
+ * QCA_NL80211_VENDOR_SUBCMD_PEER_CFR_CAPTURE_CFG to configure peer
+ * Channel Frequency Response capture parameters and enable periodic CFR
+ * capture.
+ *
+ * @QCA_WLAN_VENDOR_ATTR_CFR_PEER_MAC_ADDR: Optional (6-byte MAC address)
+ * MAC address of peer. This is for CFR version 1 only.
+ *
+ * @QCA_WLAN_VENDOR_ATTR_PEER_CFR_ENABLE: Required (flag)
+ * Enable peer CFR capture. This attribute is mandatory to enable peer CFR
+ * capture. If this attribute is not present, peer CFR capture is disabled.
+ *
+ * @QCA_WLAN_VENDOR_ATTR_PEER_CFR_BANDWIDTH: Optional (u8)
+ * BW of measurement, attribute uses the values in enum nl80211_chan_width
+ * Supported values: 20, 40, 80, 80+80, 160.
+ * Note that all targets may not support all bandwidths.
+ * This attribute is mandatory for version 1 if attribute
+ * QCA_WLAN_VENDOR_ATTR_PEER_CFR_ENABLE is used.
+ *
+ * @QCA_WLAN_VENDOR_ATTR_PEER_CFR_PERIODICITY: Optional (u32)
+ * Periodicity of CFR measurement in milliseconds.
+ * Periodicity should be a multiple of Base timer.
+ * Current Base timer value supported is 10 milliseconds (default).
+ * 0 for one shot capture.
+ * This attribute is mandatory for version 1 if attribute
+ * QCA_WLAN_VENDOR_ATTR_PEER_CFR_ENABLE is used.
+ *
+ * @QCA_WLAN_VENDOR_ATTR_PEER_CFR_METHOD: Optional (u8)
+ * Method used to capture Channel Frequency Response.
+ * Attribute uses the values defined in enum qca_wlan_vendor_cfr_method.
+ * This attribute is mandatory for version 1 if attribute
+ * QCA_WLAN_VENDOR_ATTR_PEER_CFR_ENABLE is used.
+ *
+ * @QCA_WLAN_VENDOR_ATTR_PERIODIC_CFR_CAPTURE_ENABLE: Optional (flag)
+ * Enable periodic CFR capture.
+ * This attribute is mandatory for version 1 to enable Periodic CFR capture.
+ * If this attribute is not present, periodic CFR capture is disabled.
+ */
+enum qca_wlan_vendor_peer_cfr_capture_attr {
+	QCA_WLAN_VENDOR_ATTR_PEER_CFR_CAPTURE_INVALID = 0,
+	QCA_WLAN_VENDOR_ATTR_CFR_PEER_MAC_ADDR = 1,
+	QCA_WLAN_VENDOR_ATTR_PEER_CFR_ENABLE = 2,
+	QCA_WLAN_VENDOR_ATTR_PEER_CFR_BANDWIDTH = 3,
+	QCA_WLAN_VENDOR_ATTR_PEER_CFR_PERIODICITY = 4,
+	QCA_WLAN_VENDOR_ATTR_PEER_CFR_METHOD = 5,
+	QCA_WLAN_VENDOR_ATTR_PERIODIC_CFR_CAPTURE_ENABLE = 6,
+
+	/* Keep last */
+	QCA_WLAN_VENDOR_ATTR_PEER_CFR_AFTER_LAST,
+	QCA_WLAN_VENDOR_ATTR_PEER_CFR_MAX =
+		QCA_WLAN_VENDOR_ATTR_PEER_CFR_AFTER_LAST - 1,
+};
+
+#endif /* QCA_VENDOR_H */
-- 
2.7.4

