Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2474F6392
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Apr 2022 17:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbiDFPjI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Apr 2022 11:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237093AbiDFPid (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Apr 2022 11:38:33 -0400
Received: from farmhouse.coelho.fi (paleale.coelho.fi [176.9.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB67DB2F1
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 05:53:15 -0700 (PDT)
Received: from 91-156-4-241.elisa-laajakaista.fi ([91.156.4.241] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nc4Td-000pov-FY;
        Wed, 06 Apr 2022 15:09:36 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net, kvalo@kernel.org
Cc:     luca@coelho.fi, gregory.greenman@intel.com,
        linux-wireless@vger.kernel.org
Date:   Wed,  6 Apr 2022 15:09:21 +0300
Message-Id: <iwlwifi.20220406145756.bfab4b44122d.Ic637e8f44b00acec35d6e0e793e8e3f259ef1fb6@changeid>
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
Subject: [PATCH 4/7] cfg80211: add hardware timestamps to frame RX info
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

Add hardware timestamps to management frame RX info.
This shall be used by drivers that support hardware timestamping for
Timing measurement and Fine timing measurement action frames RX.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/net/cfg80211.h |  4 ++++
 net/wireless/nl80211.c | 10 +++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index ae20256c3243..b113fb86151c 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7537,6 +7537,8 @@ void cfg80211_conn_failed(struct net_device *dev, const u8 *mac_addr,
  * @buf: Management frame (header + body)
  * @len: length of the frame data
  * @flags: flags, as defined in enum nl80211_rxmgmt_flags
+ * @rx_tstamp: Hardware timestamp of frame RX in nanoseconds
+ * @ack_tstamp: Hardware timestamp of ack TX in nanoseconds
  */
 struct cfg80211_rx_info {
 	int freq;
@@ -7544,6 +7546,8 @@ struct cfg80211_rx_info {
 	const u8 *buf;
 	size_t len;
 	u32 flags;
+	u64 rx_tstamp;
+	u64 ack_tstamp;
 };
 
 /**
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index fe4b62b4715f..6b78577aa590 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -17447,7 +17447,15 @@ int nl80211_send_mgmt(struct cfg80211_registered_device *rdev,
 	     nla_put_u32(msg, NL80211_ATTR_RX_SIGNAL_DBM, info->sig_dbm)) ||
 	    nla_put(msg, NL80211_ATTR_FRAME, info->len, info->buf) ||
 	    (info->flags &&
-	     nla_put_u32(msg, NL80211_ATTR_RXMGMT_FLAGS, info->flags)))
+	     nla_put_u32(msg, NL80211_ATTR_RXMGMT_FLAGS, info->flags)) ||
+	    (info->rx_tstamp && nla_put_u64_64bit(msg,
+						  NL80211_ATTR_RX_HW_TIMESTAMP,
+						  info->rx_tstamp,
+						  NL80211_ATTR_PAD)) ||
+	    (info->ack_tstamp && nla_put_u64_64bit(msg,
+						   NL80211_ATTR_TX_HW_TIMESTAMP,
+						   info->ack_tstamp,
+						   NL80211_ATTR_PAD)))
 		goto nla_put_failure;
 
 	genlmsg_end(msg, hdr);
-- 
2.35.1

