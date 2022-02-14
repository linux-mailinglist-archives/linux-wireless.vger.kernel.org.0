Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7994B5638
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Feb 2022 17:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356385AbiBNQaV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 11:30:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356375AbiBNQaT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 11:30:19 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5ED260AB8
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 08:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=BMzqSZG6sLNLNHuVzc8C4yyU5gndVR5Ix4rGfIxX6d4=;
        t=1644856211; x=1646065811; b=j3tuJfv47YkK567Su028XjIW0OvtYdTcFyEONm6yKXOFi6A
        zi0imZs8D0BQTptW3SAQ4Cf545VtHeRsTwy2ir3tJeqVzNMK4K2xLs3m/MjtbU2pWLPNUJ0ziTYGS
        sLfq6eUcNhF6YSYgQDvNQk3TnEdkD1ztW5A/AIt4ih10mc08qNm4P7PPRwVC+psG9j9yaM/CLtsO0
        t1yYM7rzJ/eMiHUpJLEFs/OnBoMkLRFGUyDHwjj0aP9m82I3K8J7W05kY5Wj5ULFoi0Ek+raL5dk0
        wDgtKoF3JcMn1NsJd503hy8HLGwJEgP29sEw7OP0t3bnCAQhPLk/hWh7RCO8pLEw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nJeEs-0011mw-3e;
        Mon, 14 Feb 2022 17:30:10 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Jia Ding <quic_jiad@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Muna Sinada <quic_msinada@quicinc.com>,
        Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Subject: [PATCH v3 07/19] cfg80211: Add support for EHT 320 MHz channel width
Date:   Mon, 14 Feb 2022 17:29:54 +0100
Message-Id: <20220214163009.175289-1-johannes@sipsolutions.net>
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

From: Jia Ding <quic_jiad@quicinc.com>

Add 320 MHz support in the channel def and center frequency validation
with compatible check.

Signed-off-by: Jia Ding <quic_jiad@quicinc.com>
Co-authored-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Co-authored-by: Muna Sinada <quic_msinada@quicinc.com>
Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
Co-authored-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Link: https://lore.kernel.org/r/1640163883-12696-5-git-send-email-quic_vjakkam@quicinc.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c |  2 +
 include/net/cfg80211.h                |  7 ++-
 include/uapi/linux/nl80211.h          |  3 +
 net/wireless/chan.c                   | 91 ++++++++++++++++++++++++---
 net/wireless/nl80211.c                |  2 +
 5 files changed, 97 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index defb7e36c1f2..0054c234fb9a 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -836,6 +836,8 @@ static int hwsim_get_chanwidth(enum nl80211_chan_width bw)
 	case NL80211_CHAN_WIDTH_80P80:
 	case NL80211_CHAN_WIDTH_160:
 		return 160;
+	case NL80211_CHAN_WIDTH_320:
+		return 320;
 	case NL80211_CHAN_WIDTH_5:
 		return 5;
 	case NL80211_CHAN_WIDTH_10:
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 7bec15f605be..a27f2d699dac 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -109,7 +109,11 @@ struct wiphy;
  *	on this channel.
  * @IEEE80211_CHAN_16MHZ: 16 MHz bandwidth is permitted
  *	on this channel.
- *
+ * @IEEE80211_CHAN_NO_320MHZ: If the driver supports 320 MHz on the band,
+ *	this flag indicates that a 320 MHz channel cannot use this
+ *	channel as the control or any of the secondary channels.
+ *	This may be due to the driver or due to regulatory bandwidth
+ *	restrictions.
  */
 enum ieee80211_channel_flags {
 	IEEE80211_CHAN_DISABLED		= 1<<0,
@@ -131,6 +135,7 @@ enum ieee80211_channel_flags {
 	IEEE80211_CHAN_4MHZ		= 1<<16,
 	IEEE80211_CHAN_8MHZ		= 1<<17,
 	IEEE80211_CHAN_16MHZ		= 1<<18,
+	IEEE80211_CHAN_NO_320MHZ	= 1<<19,
 };
 
 #define IEEE80211_CHAN_NO_HT40 \
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index d305a8b8c536..9e05973f3f56 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4684,6 +4684,8 @@ enum nl80211_key_mode {
  * @NL80211_CHAN_WIDTH_4: 4 MHz OFDM channel
  * @NL80211_CHAN_WIDTH_8: 8 MHz OFDM channel
  * @NL80211_CHAN_WIDTH_16: 16 MHz OFDM channel
+ * @NL80211_CHAN_WIDTH_320: 320 MHz channel, the %NL80211_ATTR_CENTER_FREQ1
+ *	attribute must be provided as well
  */
 enum nl80211_chan_width {
 	NL80211_CHAN_WIDTH_20_NOHT,
@@ -4699,6 +4701,7 @@ enum nl80211_chan_width {
 	NL80211_CHAN_WIDTH_4,
 	NL80211_CHAN_WIDTH_8,
 	NL80211_CHAN_WIDTH_16,
+	NL80211_CHAN_WIDTH_320,
 };
 
 /**
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index eb822052d344..8b7fb4a9e07b 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -181,6 +181,9 @@ static int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width)
 	case NL80211_CHAN_WIDTH_160:
 		mhz = 160;
 		break;
+	case NL80211_CHAN_WIDTH_320:
+		mhz = 320;
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		return -1;
@@ -271,6 +274,17 @@ bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
 	case NL80211_CHAN_WIDTH_16:
 		/* all checked above */
 		break;
+	case NL80211_CHAN_WIDTH_320:
+		if (chandef->center_freq1 == control_freq + 150 ||
+		    chandef->center_freq1 == control_freq + 130 ||
+		    chandef->center_freq1 == control_freq + 110 ||
+		    chandef->center_freq1 == control_freq + 90 ||
+		    chandef->center_freq1 == control_freq - 90 ||
+		    chandef->center_freq1 == control_freq - 110 ||
+		    chandef->center_freq1 == control_freq - 130 ||
+		    chandef->center_freq1 == control_freq - 150)
+			break;
+		fallthrough;
 	case NL80211_CHAN_WIDTH_160:
 		if (chandef->center_freq1 == control_freq + 70 ||
 		    chandef->center_freq1 == control_freq + 50 ||
@@ -307,7 +321,7 @@ bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
 EXPORT_SYMBOL(cfg80211_chandef_valid);
 
 static void chandef_primary_freqs(const struct cfg80211_chan_def *c,
-				  u32 *pri40, u32 *pri80)
+				  u32 *pri40, u32 *pri80, u32 *pri160)
 {
 	int tmp;
 
@@ -315,9 +329,11 @@ static void chandef_primary_freqs(const struct cfg80211_chan_def *c,
 	case NL80211_CHAN_WIDTH_40:
 		*pri40 = c->center_freq1;
 		*pri80 = 0;
+		*pri160 = 0;
 		break;
 	case NL80211_CHAN_WIDTH_80:
 	case NL80211_CHAN_WIDTH_80P80:
+		*pri160 = 0;
 		*pri80 = c->center_freq1;
 		/* n_P20 */
 		tmp = (30 + c->chan->center_freq - c->center_freq1)/20;
@@ -327,6 +343,7 @@ static void chandef_primary_freqs(const struct cfg80211_chan_def *c,
 		*pri40 = c->center_freq1 - 20 + 40 * tmp;
 		break;
 	case NL80211_CHAN_WIDTH_160:
+		*pri160 = c->center_freq1;
 		/* n_P20 */
 		tmp = (70 + c->chan->center_freq - c->center_freq1)/20;
 		/* n_P40 */
@@ -337,6 +354,20 @@ static void chandef_primary_freqs(const struct cfg80211_chan_def *c,
 		tmp /= 2;
 		*pri80 = c->center_freq1 - 40 + 80 * tmp;
 		break;
+	case NL80211_CHAN_WIDTH_320:
+		/* n_P20 */
+		tmp = (150 + c->chan->center_freq - c->center_freq1) / 20;
+		/* n_P40 */
+		tmp /= 2;
+		/* freq_P40 */
+		*pri40 = c->center_freq1 - 140 + 40 * tmp;
+		/* n_P80 */
+		tmp /= 2;
+		*pri80 = c->center_freq1 - 120 + 80 * tmp;
+		/* n_P160 */
+		tmp /= 2;
+		*pri160 = c->center_freq1 - 80 + 160 * tmp;
+		break;
 	default:
 		WARN_ON_ONCE(1);
 	}
@@ -346,7 +377,7 @@ const struct cfg80211_chan_def *
 cfg80211_chandef_compatible(const struct cfg80211_chan_def *c1,
 			    const struct cfg80211_chan_def *c2)
 {
-	u32 c1_pri40, c1_pri80, c2_pri40, c2_pri80;
+	u32 c1_pri40, c1_pri80, c2_pri40, c2_pri80, c1_pri160, c2_pri160;
 
 	/* If they are identical, return */
 	if (cfg80211_chandef_identical(c1, c2))
@@ -381,14 +412,31 @@ cfg80211_chandef_compatible(const struct cfg80211_chan_def *c1,
 	    c2->width == NL80211_CHAN_WIDTH_20)
 		return c1;
 
-	chandef_primary_freqs(c1, &c1_pri40, &c1_pri80);
-	chandef_primary_freqs(c2, &c2_pri40, &c2_pri80);
+	chandef_primary_freqs(c1, &c1_pri40, &c1_pri80, &c1_pri160);
+	chandef_primary_freqs(c2, &c2_pri40, &c2_pri80, &c2_pri160);
 
 	if (c1_pri40 != c2_pri40)
 		return NULL;
 
-	WARN_ON(!c1_pri80 && !c2_pri80);
-	if (c1_pri80 && c2_pri80 && c1_pri80 != c2_pri80)
+	if (c1->width == NL80211_CHAN_WIDTH_40)
+		return c2;
+
+	if (c2->width == NL80211_CHAN_WIDTH_40)
+		return c1;
+
+	if (c1_pri80 != c2_pri80)
+		return NULL;
+
+	if (c1->width == NL80211_CHAN_WIDTH_80 &&
+	    c2->width > NL80211_CHAN_WIDTH_80)
+		return c2;
+
+	if (c2->width == NL80211_CHAN_WIDTH_80 &&
+	    c1->width > NL80211_CHAN_WIDTH_80)
+		return c1;
+
+	WARN_ON(!c1_pri160 && !c2_pri160);
+	if (c1_pri160 && c2_pri160 && c1_pri160 != c2_pri160)
 		return NULL;
 
 	if (c1->width > c2->width)
@@ -960,7 +1008,10 @@ bool cfg80211_chandef_usable(struct wiphy *wiphy,
 	struct ieee80211_sta_vht_cap *vht_cap;
 	struct ieee80211_edmg *edmg_cap;
 	u32 width, control_freq, cap;
-	bool ext_nss_cap, support_80_80 = false;
+	bool ext_nss_cap, support_80_80 = false, support_320 = false;
+	const struct ieee80211_sband_iftype_data *iftd;
+	struct ieee80211_supported_band *sband;
+	int i;
 
 	if (WARN_ON(!cfg80211_chandef_valid(chandef)))
 		return false;
@@ -1062,6 +1113,32 @@ bool cfg80211_chandef_usable(struct wiphy *wiphy,
 		      (vht_cap->cap & IEEE80211_VHT_CAP_EXT_NSS_BW_MASK)))
 			return false;
 		break;
+	case NL80211_CHAN_WIDTH_320:
+		prohibited_flags |= IEEE80211_CHAN_NO_320MHZ;
+		width = 320;
+
+		if (chandef->chan->band != NL80211_BAND_6GHZ)
+			return false;
+
+		sband = wiphy->bands[NL80211_BAND_6GHZ];
+		if (!sband)
+			return false;
+
+		for (i = 0; i < sband->n_iftype_data; i++) {
+			iftd = &sband->iftype_data[i];
+			if (!iftd->eht_cap.has_eht)
+				continue;
+
+			if (iftd->eht_cap.eht_cap_elem.phy_cap_info[0] &
+			    IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ) {
+				support_320 = true;
+				break;
+			}
+		}
+
+		if (!support_320)
+			return false;
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		return false;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2240af5fa695..26b03d497fbc 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10590,6 +10590,8 @@ static int nl80211_join_ibss(struct sk_buff *skb, struct genl_info *info)
 					     NL80211_EXT_FEATURE_VHT_IBSS))
 			return -EINVAL;
 		break;
+	case NL80211_CHAN_WIDTH_320:
+		return -EINVAL;
 	default:
 		return -EINVAL;
 	}
-- 
2.34.1

