Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B714B5640
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Feb 2022 17:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356400AbiBNQaZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 11:30:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356373AbiBNQaU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 11:30:20 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB05460ABF
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 08:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=qlk2XamAFeVEpiTxUhieQ3SzKtPaDs37WpH1035IzgQ=;
        t=1644856212; x=1646065812; b=xk/yBcPRVRnYG14Et/5C+tLM7L92AHUN8bs3tOScUUXgudH
        eBSM/KRpe6xjB5kxeTpfzc54xbBD/mrCgzwVcoJh9y2fGjG3A6TqcP/bK5htkZfBDKPwRSBycqPh2
        d0J1ixLX+ykUtzRQxX9Fkua85TMluq1rxtJCcnpJ0oWgbL6v9PLowEjhCs7dFv+B3l8ZhEEvf662l
        EK1nD5EDdBO8Vt0Bd2t0s5YxT9q2wateyaIFpn7Oa28J8JAKUsJXmy7lozpxZq9+YE2klg7noHoH/
        gsx1RRtpU+8+UbLJyIFJLaKbNZX9objBiFsfcS+lUgWaGHU6ufbGagR3mey+9uEw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nJeEs-0011mw-TS;
        Mon, 14 Feb 2022 17:30:10 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH v3 10/19] cfg80211: add NO-EHT flag to regulatory
Date:   Mon, 14 Feb 2022 17:29:57 +0100
Message-Id: <20220214173004.dbb85a7b86bb.Ifc1e2daac51c1cc5f895ccfb79faf5eaec3950ec@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220214173004.9fd154d2c3c2.Ia0cd152357a373149bab017d479ab7d5ded289c0@changeid>
References: <20220214173004.9fd154d2c3c2.Ia0cd152357a373149bab017d479ab7d5ded289c0@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

This may be necessary in some cases, add a flag and propagate
it, just like the NO-HE that already exists.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
[split off from a combined 320/no-EHT patch]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h       | 2 ++
 include/uapi/linux/nl80211.h | 3 +++
 net/wireless/nl80211.c       | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index f35ffd81d213..5cfc483dece1 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -114,6 +114,7 @@ struct wiphy;
  *	channel as the control or any of the secondary channels.
  *	This may be due to the driver or due to regulatory bandwidth
  *	restrictions.
+ * @IEEE80211_CHAN_NO_EHT: EHT operation is not permitted on this channel.
  */
 enum ieee80211_channel_flags {
 	IEEE80211_CHAN_DISABLED		= 1<<0,
@@ -136,6 +137,7 @@ enum ieee80211_channel_flags {
 	IEEE80211_CHAN_8MHZ		= 1<<17,
 	IEEE80211_CHAN_16MHZ		= 1<<18,
 	IEEE80211_CHAN_NO_320MHZ	= 1<<19,
+	IEEE80211_CHAN_NO_EHT		= 1<<20,
 };
 
 #define IEEE80211_CHAN_NO_HT40 \
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 6a338dafcd07..baf6433c0119 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3999,6 +3999,8 @@ enum nl80211_wmm_rule {
  *	on this channel in current regulatory domain.
  * @NL80211_FREQUENCY_ATTR_NO_320MHZ: any 320 MHz channel using this channel
  *	as the primary or any of the secondary channels isn't possible
+ * @NL80211_FREQUENCY_ATTR_NO_EHT: EHT operation is not allowed on this channel
+ *	in current regulatory domain.
  * @NL80211_FREQUENCY_ATTR_MAX: highest frequency attribute number
  *	currently defined
  * @__NL80211_FREQUENCY_ATTR_AFTER_LAST: internal use
@@ -4036,6 +4038,7 @@ enum nl80211_frequency_attr {
 	NL80211_FREQUENCY_ATTR_8MHZ,
 	NL80211_FREQUENCY_ATTR_16MHZ,
 	NL80211_FREQUENCY_ATTR_NO_320MHZ,
+	NL80211_FREQUENCY_ATTR_NO_EHT,
 
 	/* keep last */
 	__NL80211_FREQUENCY_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 3a36ac3c4ad6..4067e41ca288 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1162,6 +1162,9 @@ static int nl80211_msg_put_channel(struct sk_buff *msg, struct wiphy *wiphy,
 		if ((chan->flags & IEEE80211_CHAN_NO_320MHZ) &&
 		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_NO_320MHZ))
 			goto nla_put_failure;
+		if ((chan->flags & IEEE80211_CHAN_NO_EHT) &&
+		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_NO_EHT))
+			goto nla_put_failure;
 	}
 
 	if (nla_put_u32(msg, NL80211_FREQUENCY_ATTR_MAX_TX_POWER,
-- 
2.34.1

