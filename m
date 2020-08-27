Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1DE255117
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Aug 2020 00:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgH0WdL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 18:33:11 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:50318 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726953AbgH0WdL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 18:33:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 392F74F8142;
        Thu, 27 Aug 2020 22:33:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id k_6pDosdaF5D; Thu, 27 Aug 2020 22:33:06 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 2ED884F8094;
        Thu, 27 Aug 2020 22:33:06 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH 01/22] nl80211: advertise supported channel width in S1G
Date:   Thu, 27 Aug 2020 15:32:43 -0700
Message-Id: <20200827223304.16155-2-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827223304.16155-1-thomas@adapt-ip.com>
References: <20200827223304.16155-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

S1G supports 5 channel widths: 1, 2, 4, 8, and 16. One
channel width is allowed per frequency in each operating
class, so it makes more sense to advertise the specific
channel width allowed.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 include/net/cfg80211.h       | 15 +++++++++++++++
 include/uapi/linux/nl80211.h | 15 +++++++++++++++
 net/wireless/nl80211.c       | 15 +++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d9e6b9fbd95b..3db0444086e2 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -96,6 +96,16 @@ struct wiphy;
  * @IEEE80211_CHAN_NO_10MHZ: 10 MHz bandwidth is not permitted
  *	on this channel.
  * @IEEE80211_CHAN_NO_HE: HE operation is not permitted on this channel.
+ * @IEEE80211_CHAN_1MHZ: 1 MHz bandwidth is permitted
+ *	on this channel.
+ * @IEEE80211_CHAN_2MHZ: 2 MHz bandwidth is permitted
+ *	on this channel.
+ * @IEEE80211_CHAN_4MHZ: 4 MHz bandwidth is permitted
+ *	on this channel.
+ * @IEEE80211_CHAN_8MHZ: 8 MHz bandwidth is permitted
+ *	on this channel.
+ * @IEEE80211_CHAN_16MHZ: 16 MHz bandwidth is permitted
+ *	on this channel.
  *
  */
 enum ieee80211_channel_flags {
@@ -113,6 +123,11 @@ enum ieee80211_channel_flags {
 	IEEE80211_CHAN_NO_20MHZ		= 1<<11,
 	IEEE80211_CHAN_NO_10MHZ		= 1<<12,
 	IEEE80211_CHAN_NO_HE		= 1<<13,
+	IEEE80211_CHAN_1MHZ		= 1<<14,
+	IEEE80211_CHAN_2MHZ		= 1<<15,
+	IEEE80211_CHAN_4MHZ		= 1<<16,
+	IEEE80211_CHAN_8MHZ		= 1<<17,
+	IEEE80211_CHAN_16MHZ		= 1<<18,
 };
 
 #define IEEE80211_CHAN_NO_HT40 \
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 631f3a997b3c..00ac24f2e293 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3725,6 +3725,16 @@ enum nl80211_wmm_rule {
  * @NL80211_FREQUENCY_ATTR_NO_HE: HE operation is not allowed on this channel
  *	in current regulatory domain.
  * @NL80211_FREQUENCY_ATTR_OFFSET: frequency offset in KHz
+ * @NL80211_FREQUENCY_ATTR_1MHZ: 1 MHz operation is allowed
+ *	on this channel in current regulatory domain.
+ * @NL80211_FREQUENCY_ATTR_2MHZ: 2 MHz operation is allowed
+ *	on this channel in current regulatory domain.
+ * @NL80211_FREQUENCY_ATTR_4MHZ: 4 MHz operation is allowed
+ *	on this channel in current regulatory domain.
+ * @NL80211_FREQUENCY_ATTR_8MHZ: 8 MHz operation is allowed
+ *	on this channel in current regulatory domain.
+ * @NL80211_FREQUENCY_ATTR_16MHZ: 16 MHz operation is allowed
+ *	on this channel in current regulatory domain.
  * @NL80211_FREQUENCY_ATTR_MAX: highest frequency attribute number
  *	currently defined
  * @__NL80211_FREQUENCY_ATTR_AFTER_LAST: internal use
@@ -3756,6 +3766,11 @@ enum nl80211_frequency_attr {
 	NL80211_FREQUENCY_ATTR_WMM,
 	NL80211_FREQUENCY_ATTR_NO_HE,
 	NL80211_FREQUENCY_ATTR_OFFSET,
+	NL80211_FREQUENCY_ATTR_1MHZ,
+	NL80211_FREQUENCY_ATTR_2MHZ,
+	NL80211_FREQUENCY_ATTR_4MHZ,
+	NL80211_FREQUENCY_ATTR_8MHZ,
+	NL80211_FREQUENCY_ATTR_16MHZ,
 
 	/* keep last */
 	__NL80211_FREQUENCY_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0ce6237c9de1..5aded5de35cd 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -990,6 +990,21 @@ static int nl80211_msg_put_channel(struct sk_buff *msg, struct wiphy *wiphy,
 		if ((chan->flags & IEEE80211_CHAN_NO_HE) &&
 		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_NO_HE))
 			goto nla_put_failure;
+		if ((chan->flags & IEEE80211_CHAN_1MHZ) &&
+		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_1MHZ))
+			goto nla_put_failure;
+		if ((chan->flags & IEEE80211_CHAN_2MHZ) &&
+		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_2MHZ))
+			goto nla_put_failure;
+		if ((chan->flags & IEEE80211_CHAN_4MHZ) &&
+		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_4MHZ))
+			goto nla_put_failure;
+		if ((chan->flags & IEEE80211_CHAN_8MHZ) &&
+		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_8MHZ))
+			goto nla_put_failure;
+		if ((chan->flags & IEEE80211_CHAN_16MHZ) &&
+		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_16MHZ))
+			goto nla_put_failure;
 	}
 
 	if (nla_put_u32(msg, NL80211_FREQUENCY_ATTR_MAX_TX_POWER,
-- 
2.20.1

