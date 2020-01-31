Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3259414EB84
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2020 12:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgAaLNO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jan 2020 06:13:14 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:55800 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728401AbgAaLNO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jan 2020 06:13:14 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ixUEZ-0002GC-J6; Fri, 31 Jan 2020 13:13:12 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 31 Jan 2020 13:12:43 +0200
Message-Id: <20200131111300.891737-7-luca@coelho.fi>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131111300.891737-1-luca@coelho.fi>
References: <20200131111300.891737-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 06/23] cfg80211: add no HE indication to the channel flag
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Haim Dreyfuss <haim.dreyfuss@intel.com>

The regulatory domain might forbid HE operation.
Certain regulatory domain might restrict it for specific channels
whereas other can do it  for the whole regulatory domain

Add an option to indicate it in the channel flag.

Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/net/cfg80211.h       | 2 ++
 include/uapi/linux/nl80211.h | 5 +++++
 net/wireless/nl80211.c       | 3 +++
 net/wireless/reg.c           | 2 ++
 4 files changed, 12 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 51a9f5dc237e..56f4e4965f56 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -95,6 +95,7 @@ struct wiphy;
  *	on this channel.
  * @IEEE80211_CHAN_NO_10MHZ: 10 MHz bandwidth is not permitted
  *	on this channel.
+ * @IEEE80211_CHAN_NO_HE: HE operation is not permitted on this channel.
  *
  */
 enum ieee80211_channel_flags {
@@ -111,6 +112,7 @@ enum ieee80211_channel_flags {
 	IEEE80211_CHAN_IR_CONCURRENT	= 1<<10,
 	IEEE80211_CHAN_NO_20MHZ		= 1<<11,
 	IEEE80211_CHAN_NO_10MHZ		= 1<<12,
+	IEEE80211_CHAN_NO_HE		= 1<<13,
 };
 
 #define IEEE80211_CHAN_NO_HT40 \
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index a3ecb713cf72..ef87b8afb6e0 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3587,6 +3587,8 @@ enum nl80211_wmm_rule {
  * @NL80211_FREQUENCY_ATTR_WMM: this channel has wmm limitations.
  *	This is a nested attribute that contains the wmm limitation per AC.
  *	(see &enum nl80211_wmm_rule)
+ * @NL80211_FREQUENCY_ATTR_NO_HE: HE operation is not allowed on this channel
+ *	in current regulatory domain.
  * @NL80211_FREQUENCY_ATTR_MAX: highest frequency attribute number
  *	currently defined
  * @__NL80211_FREQUENCY_ATTR_AFTER_LAST: internal use
@@ -3616,6 +3618,7 @@ enum nl80211_frequency_attr {
 	NL80211_FREQUENCY_ATTR_NO_20MHZ,
 	NL80211_FREQUENCY_ATTR_NO_10MHZ,
 	NL80211_FREQUENCY_ATTR_WMM,
+	NL80211_FREQUENCY_ATTR_NO_HE,
 
 	/* keep last */
 	__NL80211_FREQUENCY_ATTR_AFTER_LAST,
@@ -3813,6 +3816,7 @@ enum nl80211_sched_scan_match_attr {
  * @NL80211_RRF_NO_HT40PLUS: channels can't be used in HT40+ operation
  * @NL80211_RRF_NO_80MHZ: 80MHz operation not allowed
  * @NL80211_RRF_NO_160MHZ: 160MHz operation not allowed
+ * @NL80211_RRF_NO_HE: HE operation not allowed
  */
 enum nl80211_reg_rule_flags {
 	NL80211_RRF_NO_OFDM		= 1<<0,
@@ -3830,6 +3834,7 @@ enum nl80211_reg_rule_flags {
 	NL80211_RRF_NO_HT40PLUS		= 1<<14,
 	NL80211_RRF_NO_80MHZ		= 1<<15,
 	NL80211_RRF_NO_160MHZ		= 1<<16,
+	NL80211_RRF_NO_HE		= 1<<17,
 };
 
 #define NL80211_RRF_PASSIVE_SCAN	NL80211_RRF_NO_IR
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 5c2a7569c229..4ac21cf5ffc1 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -974,6 +974,9 @@ static int nl80211_msg_put_channel(struct sk_buff *msg, struct wiphy *wiphy,
 		if ((chan->flags & IEEE80211_CHAN_NO_10MHZ) &&
 		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_NO_10MHZ))
 			goto nla_put_failure;
+		if ((chan->flags & IEEE80211_CHAN_NO_HE) &&
+		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_NO_HE))
+			goto nla_put_failure;
 	}
 
 	if (nla_put_u32(msg, NL80211_FREQUENCY_ATTR_MAX_TX_POWER,
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 446c76d44e65..ea7bc5652a41 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1569,6 +1569,8 @@ static u32 map_regdom_flags(u32 rd_flags)
 		channel_flags |= IEEE80211_CHAN_NO_80MHZ;
 	if (rd_flags & NL80211_RRF_NO_160MHZ)
 		channel_flags |= IEEE80211_CHAN_NO_160MHZ;
+	if (rd_flags & NL80211_RRF_NO_HE)
+		channel_flags |= IEEE80211_CHAN_NO_HE;
 	return channel_flags;
 }
 
-- 
2.24.1

