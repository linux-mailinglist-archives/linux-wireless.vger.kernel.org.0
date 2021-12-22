Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E988347CEBD
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Dec 2021 10:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239625AbhLVJFv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Dec 2021 04:05:51 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:62064 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbhLVJFv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Dec 2021 04:05:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640163951; x=1671699951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=F9C9V9qiB+wdLdPry30fBW0FhzQf2lF8ubMkDvyjxek=;
  b=Hsk7wt4Bk6WE7T9gVlJO0s7y0ZZhru80f8xm2WeHWFAnq/P9gctHlNBn
   QShuVvWDWABkOUBg8jsHkHw90QwiOKFWwuR3+u8mV+DpvOEI2Nlw4dZHc
   gEfuaMZ5lbuIOeJwLMwm4EuxyIDRiqjTJfOzwvRXigW3D7DiO/u578537
   4=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 22 Dec 2021 01:05:51 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 01:05:49 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 22 Dec 2021 01:05:48 -0800
Received: from hu-vjakkam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 22 Dec 2021 01:05:46 -0800
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <quic_vikram@quicinc.com>,
        <quic_alokad@quicinc.com>, <quic_jiad@quicinc.com>,
        <quic_periyasa@quicinc.com>, <quic_msinada@quicinc.com>,
        <quic_srirrama@quicinc.com>
Subject: [PATCH 4/6] cfg80211: Add support for EHT 320 MHz channel width
Date:   Wed, 22 Dec 2021 14:34:41 +0530
Message-ID: <1640163883-12696-5-git-send-email-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1640163883-12696-1-git-send-email-quic_vjakkam@quicinc.com>
References: <1640163883-12696-1-git-send-email-quic_vjakkam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
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
---
 include/net/cfg80211.h       |  6 +++
 include/uapi/linux/nl80211.h |  3 ++
 net/wireless/chan.c          | 91 ++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 93 insertions(+), 7 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index ce34dd7..eeb2854 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -110,6 +110,11 @@ struct wiphy;
  * @IEEE80211_CHAN_16MHZ: 16 MHz bandwidth is permitted
  *	on this channel.
  *
+ * @IEEE80211_CHAN_NO_320MHZ: If the driver supports 320 MHz on the band,
+ *	this flag indicates that a 320 MHz channel cannot use this
+ *	channel as the control or any of the secondary channels.
+ *	This may be due to the driver or due to regulatory bandwidth
+ *	restrictions.
  */
 enum ieee80211_channel_flags {
 	IEEE80211_CHAN_DISABLED		= 1<<0,
@@ -131,6 +136,7 @@ enum ieee80211_channel_flags {
 	IEEE80211_CHAN_4MHZ		= 1<<16,
 	IEEE80211_CHAN_8MHZ		= 1<<17,
 	IEEE80211_CHAN_16MHZ		= 1<<18,
+	IEEE80211_CHAN_NO_320MHZ	= 1<<19,
 };
 
 #define IEEE80211_CHAN_NO_HT40 \
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index c221322..e4ac7ab 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4691,6 +4691,8 @@ enum nl80211_key_mode {
  * @NL80211_CHAN_WIDTH_4: 4 MHz OFDM channel
  * @NL80211_CHAN_WIDTH_8: 8 MHz OFDM channel
  * @NL80211_CHAN_WIDTH_16: 16 MHz OFDM channel
+ * @NL80211_CHAN_WIDTH_320: 320 MHz channel, the %NL80211_ATTR_CENTER_FREQ1
+ *	attribute must be provided as well
  */
 enum nl80211_chan_width {
 	NL80211_CHAN_WIDTH_20_NOHT,
@@ -4706,6 +4708,7 @@ enum nl80211_chan_width {
 	NL80211_CHAN_WIDTH_4,
 	NL80211_CHAN_WIDTH_8,
 	NL80211_CHAN_WIDTH_16,
+	NL80211_CHAN_WIDTH_320,
 };
 
 /**
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index eb82205..8b7fb4a 100644
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
-- 
2.7.4

