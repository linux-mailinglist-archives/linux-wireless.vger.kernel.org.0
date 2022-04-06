Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D344F62D0
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Apr 2022 17:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbiDFPL7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Apr 2022 11:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbiDFPL1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Apr 2022 11:11:27 -0400
Received: from farmhouse.coelho.fi (paleale.coelho.fi [176.9.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA892AF248
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 05:11:25 -0700 (PDT)
Received: from 91-156-4-241.elisa-laajakaista.fi ([91.156.4.241] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nc4Ta-000pov-57;
        Wed, 06 Apr 2022 15:09:31 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net, kvalo@kernel.org
Cc:     luca@coelho.fi, gregory.greenman@intel.com,
        linux-wireless@vger.kernel.org
Date:   Wed,  6 Apr 2022 15:09:19 +0300
Message-Id: <iwlwifi.20220406145756.721e5cd5a682.I411bb8c79a26ffb33898bea2075f6779c7da0cb4@changeid>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406120924.979792-1-luca@coelho.fi>
References: <20220406120924.979792-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Subject: [PATCH 2/7] cfg80211: add a function for reporting TX status with hardware timestamps
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

Add a function for reporting TX status with hardware timestamps. This
function shall be used for reporting the TX status of Timing
measurement and Fine timing measurement action frames by devices that
support reporting hardware timestamps.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/net/cfg80211.h | 47 ++++++++++++++++++++++++++++++++++++++++--
 net/wireless/nl80211.c | 42 ++++++++++++++++++++++++-------------
 2 files changed, 73 insertions(+), 16 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 68713388b617..13c2ad88adb1 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7574,6 +7574,38 @@ static inline bool cfg80211_rx_mgmt(struct wireless_dev *wdev, int freq,
 				    flags);
 }
 
+/**
+ * struct cfg80211_tx_status - TX status for management frame information
+ *
+ * @cookie: Cookie returned by cfg80211_ops::mgmt_tx()
+ * @tx_tstamp: hardware TX timestamp in nanoseconds
+ * @ack_tstamp: hardware ack RX timestamp in nanoseconds
+ * @buf: Management frame (header + body)
+ * @len: length of the frame data
+ * @ack: Whether frame was acknowledged
+ */
+struct cfg80211_tx_status {
+	u64 cookie;
+	u64 tx_tstamp;
+	u64 ack_tstamp;
+	const u8 *buf;
+	size_t len;
+	bool ack;
+};
+
+/**
+ * cfg80211_mgmt_tx_status_ext - TX status notification with extended info
+ * @wdev: wireless device receiving the frame
+ * @status: TX status data
+ * @gfp: context flags
+ *
+ * This function is called whenever a management frame was requested to be
+ * transmitted with cfg80211_ops::mgmt_tx() to report the TX status of the
+ * transmission attempt with extended info.
+ */
+void cfg80211_mgmt_tx_status_ext(struct wireless_dev *wdev,
+				 struct cfg80211_tx_status *status, gfp_t gfp);
+
 /**
  * cfg80211_mgmt_tx_status - notification of TX status for management frame
  * @wdev: wireless device receiving the frame
@@ -7587,8 +7619,19 @@ static inline bool cfg80211_rx_mgmt(struct wireless_dev *wdev, int freq,
  * transmitted with cfg80211_ops::mgmt_tx() to report the TX status of the
  * transmission attempt.
  */
-void cfg80211_mgmt_tx_status(struct wireless_dev *wdev, u64 cookie,
-			     const u8 *buf, size_t len, bool ack, gfp_t gfp);
+static inline void cfg80211_mgmt_tx_status(struct wireless_dev *wdev,
+					   u64 cookie, const u8 *buf,
+					   size_t len, bool ack, gfp_t gfp)
+{
+	struct cfg80211_tx_status status = {
+		.cookie = cookie,
+		.buf = buf,
+		.len = len,
+		.ack = ack
+	};
+
+	cfg80211_mgmt_tx_status_ext(wdev, &status, gfp);
+}
 
 /**
  * cfg80211_control_port_tx_status - notification of TX status for control
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index ee1c2b6b6971..bc9818dd2f9a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -17460,8 +17460,8 @@ int nl80211_send_mgmt(struct cfg80211_registered_device *rdev,
 	return -ENOBUFS;
 }
 
-static void nl80211_frame_tx_status(struct wireless_dev *wdev, u64 cookie,
-				    const u8 *buf, size_t len, bool ack,
+static void nl80211_frame_tx_status(struct wireless_dev *wdev,
+				    struct cfg80211_tx_status *status,
 				    gfp_t gfp, enum nl80211_commands command)
 {
 	struct wiphy *wiphy = wdev->wiphy;
@@ -17471,11 +17471,13 @@ static void nl80211_frame_tx_status(struct wireless_dev *wdev, u64 cookie,
 	void *hdr;
 
 	if (command == NL80211_CMD_FRAME_TX_STATUS)
-		trace_cfg80211_mgmt_tx_status(wdev, cookie, ack);
+		trace_cfg80211_mgmt_tx_status(wdev, status->cookie,
+					      status->ack);
 	else
-		trace_cfg80211_control_port_tx_status(wdev, cookie, ack);
+		trace_cfg80211_control_port_tx_status(wdev, status->cookie,
+						      status->ack);
 
-	msg = nlmsg_new(100 + len, gfp);
+	msg = nlmsg_new(100 + status->len, gfp);
 	if (!msg)
 		return;
 
@@ -17490,10 +17492,16 @@ static void nl80211_frame_tx_status(struct wireless_dev *wdev, u64 cookie,
 				   netdev->ifindex)) ||
 	    nla_put_u64_64bit(msg, NL80211_ATTR_WDEV, wdev_id(wdev),
 			      NL80211_ATTR_PAD) ||
-	    nla_put(msg, NL80211_ATTR_FRAME, len, buf) ||
-	    nla_put_u64_64bit(msg, NL80211_ATTR_COOKIE, cookie,
+	    nla_put(msg, NL80211_ATTR_FRAME, status->len, status->buf) ||
+	    nla_put_u64_64bit(msg, NL80211_ATTR_COOKIE, status->cookie,
 			      NL80211_ATTR_PAD) ||
-	    (ack && nla_put_flag(msg, NL80211_ATTR_ACK)))
+	    (status->ack && nla_put_flag(msg, NL80211_ATTR_ACK)) ||
+	    (status->tx_tstamp &&
+	     nla_put_u64_64bit(msg, NL80211_ATTR_TX_HW_TIMESTAMP,
+			       status->tx_tstamp, NL80211_ATTR_PAD)) ||
+	    (status->ack_tstamp &&
+	     nla_put_u64_64bit(msg, NL80211_ATTR_RX_HW_TIMESTAMP,
+			       status->ack_tstamp, NL80211_ATTR_PAD)))
 		goto nla_put_failure;
 
 	genlmsg_end(msg, hdr);
@@ -17510,18 +17518,24 @@ void cfg80211_control_port_tx_status(struct wireless_dev *wdev, u64 cookie,
 				     const u8 *buf, size_t len, bool ack,
 				     gfp_t gfp)
 {
-	nl80211_frame_tx_status(wdev, cookie, buf, len, ack, gfp,
+	struct cfg80211_tx_status status = {
+		.cookie = cookie,
+		.buf = buf,
+		.len = len,
+		.ack = ack
+	};
+
+	nl80211_frame_tx_status(wdev, &status, gfp,
 				NL80211_CMD_CONTROL_PORT_FRAME_TX_STATUS);
 }
 EXPORT_SYMBOL(cfg80211_control_port_tx_status);
 
-void cfg80211_mgmt_tx_status(struct wireless_dev *wdev, u64 cookie,
-			     const u8 *buf, size_t len, bool ack, gfp_t gfp)
+void cfg80211_mgmt_tx_status_ext(struct wireless_dev *wdev,
+				 struct cfg80211_tx_status *status, gfp_t gfp)
 {
-	nl80211_frame_tx_status(wdev, cookie, buf, len, ack, gfp,
-				NL80211_CMD_FRAME_TX_STATUS);
+	nl80211_frame_tx_status(wdev, status, gfp, NL80211_CMD_FRAME_TX_STATUS);
 }
-EXPORT_SYMBOL(cfg80211_mgmt_tx_status);
+EXPORT_SYMBOL(cfg80211_mgmt_tx_status_ext);
 
 static int __nl80211_rx_control_port(struct net_device *dev,
 				     struct sk_buff *skb,
-- 
2.35.1

