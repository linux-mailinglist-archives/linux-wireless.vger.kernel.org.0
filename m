Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4F625830B
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Aug 2020 22:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgHaU4L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Aug 2020 16:56:11 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:52174 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729325AbgHaU4L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Aug 2020 16:56:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 828764F8E7E;
        Mon, 31 Aug 2020 20:56:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id d07uZxoOyeAC; Mon, 31 Aug 2020 20:56:07 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id B84AC4F865E;
        Mon, 31 Aug 2020 20:56:04 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v2 02/22] nl80211: advertise supported channel width in S1G
Date:   Mon, 31 Aug 2020 13:55:40 -0700
Message-Id: <20200831205600.21058-3-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200831205600.21058-1-thomas@adapt-ip.com>
References: <20200831205600.21058-1-thomas@adapt-ip.com>
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
index c9bce9bba511..e4d4fbcb2edc 100644
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
index 0584e0d349f0..4e119c6afa31 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3737,6 +3737,16 @@ enum nl80211_wmm_rule {
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
@@ -3768,6 +3778,11 @@ enum nl80211_frequency_attr {
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
index 52a35e788547..7da4d84bcc1a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1010,6 +1010,21 @@ static int nl80211_msg_put_channel(struct sk_buff *msg, struct wiphy *wiphy,
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

