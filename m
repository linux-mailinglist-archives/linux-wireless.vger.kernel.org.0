Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0FA4B1621
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 20:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343919AbiBJTU1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 14:20:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343897AbiBJTUX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 14:20:23 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8108BB4A
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 11:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=CZEPk+T3balUtZnuZGaKjzVgsknbrCPa3wHSwVK0UiI=;
        t=1644520823; x=1645730423; b=iO0RBTWqqPHhEL5TIkxliEzldsDJKpVJoC14qd9aDC8Wx61
        MGhgzUh9msFogSLq9G205e+YC8VYNx0ASkmHNw7gbb+cCdpzR2PVP3Qf4hNV+Jukbmc2D6s9S5fva
        pu76d248P9u+BuhmQqmiqFANdamaBJAlEk/sDrZ+LNxggmVVRdKHSbbNwyraqpM7ZxEhN+HK9Wo13
        MbH+2o6uzgwqo+8KELsMVV7cCUa44MQhr6D9zndmBiR7O7fDjHCqR4XplSy9lbQHYRyBLpWEnHJXs
        jHAVP/oVs8alinBBGuZl5moN0dKPYofMShKkpHlzILHkrNqJEF0WWhSsaNKSW1FQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nIEzN-00HC2X-E4;
        Thu, 10 Feb 2022 20:20:21 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     quic_vikram@quicinc.com, quic_alokad@quicinc.com,
        quic_jiad@quicinc.com, quic_periyasa@quicinc.com,
        quic_msinada@quicinc.com, quic_srirrama@quicinc.com,
        ilan.peer@intel.com,
        Karthikeyan Periyasamy <quic_periyasia@quicinc.com>,
        Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Subject: [PATCH v2 09/19] nl80211: add support for 320MHz channel limitation
Date:   Thu, 10 Feb 2022 20:19:58 +0100
Message-Id: <20220210192008.188166-4-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220210192008.188166-1-johannes@sipsolutions.net>
References: <20220210192008.188166-1-johannes@sipsolutions.net>
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

From: Sriram R <quic_srirrama@quicinc.com>

Add support to advertise drivers or regulatory limitations on 320 MHz
channels to userspace.

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Co-authored-by: Karthikeyan Periyasamy <quic_periyasia@quicinc.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasia@quicinc.com>
Co-authored-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Link: https://lore.kernel.org/r/1640163883-12696-6-git-send-email-quic_vjakkam@quicinc.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/uapi/linux/nl80211.h | 5 +++++
 net/wireless/nl80211.c       | 3 +++
 net/wireless/reg.c           | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index d0ba70ea5d04..6a338dafcd07 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3997,6 +3997,8 @@ enum nl80211_wmm_rule {
  *	on this channel in current regulatory domain.
  * @NL80211_FREQUENCY_ATTR_16MHZ: 16 MHz operation is allowed
  *	on this channel in current regulatory domain.
+ * @NL80211_FREQUENCY_ATTR_NO_320MHZ: any 320 MHz channel using this channel
+ *	as the primary or any of the secondary channels isn't possible
  * @NL80211_FREQUENCY_ATTR_MAX: highest frequency attribute number
  *	currently defined
  * @__NL80211_FREQUENCY_ATTR_AFTER_LAST: internal use
@@ -4033,6 +4035,7 @@ enum nl80211_frequency_attr {
 	NL80211_FREQUENCY_ATTR_4MHZ,
 	NL80211_FREQUENCY_ATTR_8MHZ,
 	NL80211_FREQUENCY_ATTR_16MHZ,
+	NL80211_FREQUENCY_ATTR_NO_320MHZ,
 
 	/* keep last */
 	__NL80211_FREQUENCY_ATTR_AFTER_LAST,
@@ -4231,6 +4234,7 @@ enum nl80211_sched_scan_match_attr {
  * @NL80211_RRF_NO_80MHZ: 80MHz operation not allowed
  * @NL80211_RRF_NO_160MHZ: 160MHz operation not allowed
  * @NL80211_RRF_NO_HE: HE operation not allowed
+ * @NL80211_RRF_NO_320MHZ: 320MHz operation not allowed
  */
 enum nl80211_reg_rule_flags {
 	NL80211_RRF_NO_OFDM		= 1<<0,
@@ -4249,6 +4253,7 @@ enum nl80211_reg_rule_flags {
 	NL80211_RRF_NO_80MHZ		= 1<<15,
 	NL80211_RRF_NO_160MHZ		= 1<<16,
 	NL80211_RRF_NO_HE		= 1<<17,
+	NL80211_RRF_NO_320MHZ		= 1<<18,
 };
 
 #define NL80211_RRF_PASSIVE_SCAN	NL80211_RRF_NO_IR
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 5694866ebfec..e8a7ad25f534 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1148,6 +1148,9 @@ static int nl80211_msg_put_channel(struct sk_buff *msg, struct wiphy *wiphy,
 		if ((chan->flags & IEEE80211_CHAN_16MHZ) &&
 		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_16MHZ))
 			goto nla_put_failure;
+		if ((chan->flags & IEEE80211_CHAN_NO_320MHZ) &&
+		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_NO_320MHZ))
+			goto nla_put_failure;
 	}
 
 	if (nla_put_u32(msg, NL80211_FREQUENCY_ATTR_MAX_TX_POWER,
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index ec25924a1c26..c76cd973f06e 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1238,6 +1238,8 @@ unsigned int reg_get_max_bandwidth(const struct ieee80211_regdomain *rd,
 {
 	unsigned int bw = reg_get_max_bandwidth_from_range(rd, rule);
 
+	if (rule->flags & NL80211_RRF_NO_320MHZ)
+		bw = min_t(unsigned int, bw, MHZ_TO_KHZ(160));
 	if (rule->flags & NL80211_RRF_NO_160MHZ)
 		bw = min_t(unsigned int, bw, MHZ_TO_KHZ(80));
 	if (rule->flags & NL80211_RRF_NO_80MHZ)
@@ -1611,6 +1613,8 @@ static u32 map_regdom_flags(u32 rd_flags)
 		channel_flags |= IEEE80211_CHAN_NO_160MHZ;
 	if (rd_flags & NL80211_RRF_NO_HE)
 		channel_flags |= IEEE80211_CHAN_NO_HE;
+	if (rd_flags & NL80211_RRF_NO_320MHZ)
+		channel_flags |= IEEE80211_CHAN_NO_320MHZ;
 	return channel_flags;
 }
 
@@ -1773,6 +1777,8 @@ static uint32_t reg_rule_to_chan_bw_flags(const struct ieee80211_regdomain *regd
 			bw_flags |= IEEE80211_CHAN_NO_80MHZ;
 		if (max_bandwidth_khz < MHZ_TO_KHZ(160))
 			bw_flags |= IEEE80211_CHAN_NO_160MHZ;
+		if (max_bandwidth_khz < MHZ_TO_KHZ(320))
+			bw_flags |= IEEE80211_CHAN_NO_320MHZ;
 	}
 	return bw_flags;
 }
-- 
2.34.1

