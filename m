Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B096D26A5
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Mar 2023 19:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjCaR1v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Mar 2023 13:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjCaR1u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Mar 2023 13:27:50 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0ED1CBA5
        for <linux-wireless@vger.kernel.org>; Fri, 31 Mar 2023 10:27:38 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 84D0F1C007D
        for <linux-wireless@vger.kernel.org>; Fri, 31 Mar 2023 17:27:36 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id F079113C2B0;
        Fri, 31 Mar 2023 10:27:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com F079113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1680283656;
        bh=WVRsz6G0bqS6eUElgNoxFu1EB42KumM3WPEXuBGYbVw=;
        h=From:To:Cc:Subject:Date:From;
        b=NtseZXBOPRTAn+SSBNF6HdeyymCd4mSDJmUvYDCg83VOYk2XDPfwIGLjF9Q6OIyTk
         xksre5Eq/jullv7NU/gpvRINjwOsEKSLkoawkQtaknZmRPorypxxSWp/xMsdQ3ROEw
         Q1HK9wfgrZRFxI3zDOeiEc8LO3NSGaiMyjw8fK9g=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v2] wifi: mac80211: fix EHT issue in ieee80211_determine_chantype
Date:   Fri, 31 Mar 2023 10:27:31 -0700
Message-Id: <20230331172731.3580369-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1680283657-c0Oi0GZsiA7x
X-MDID-O: us5;ut7;1680283657;c0Oi0GZsiA7x;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

The IEEE80211_STA_DISABLE_EHT flag was not enabled when it should
be, so the bandwidth change failed, and STA disconnected.

Use an OR approach instead of just assinging the flags, to
allow easier setting of certain flags such as the EHT
one.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---

v2:  Remove the 'ret = 0' before goto, I missed that when porting this
forward orriginally.

 net/mac80211/mlme.c | 66 ++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 34 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index d5a0416d9c67..ede5862b8cb2 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -168,7 +168,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 {
 	struct cfg80211_chan_def vht_chandef;
 	struct ieee80211_sta_ht_cap sta_ht_cap;
-	ieee80211_conn_flags_t ret;
+	ieee80211_conn_flags_t ret = 0;
 	u32 ht_cfreq;
 
 	memset(chandef, 0, sizeof(struct cfg80211_chan_def));
@@ -177,17 +177,18 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 	chandef->center_freq1 = channel->center_freq;
 	chandef->freq1_offset = channel->freq_offset;
 
+	if (!eht_oper)
+		ret |= IEEE80211_CONN_DISABLE_EHT;
+
 	if (channel->band == NL80211_BAND_6GHZ) {
 		if (!ieee80211_chandef_he_6ghz_oper(sdata, he_oper, eht_oper,
 						    chandef)) {
 			mlme_dbg(sdata,
 				 "bad 6 GHz operation, disabling HT/VHT/HE/EHT\n");
-			ret = IEEE80211_CONN_DISABLE_HT |
-			      IEEE80211_CONN_DISABLE_VHT |
-			      IEEE80211_CONN_DISABLE_HE |
-			      IEEE80211_CONN_DISABLE_EHT;
-		} else {
-			ret = 0;
+			ret |= IEEE80211_CONN_DISABLE_HT |
+			       IEEE80211_CONN_DISABLE_VHT |
+			       IEEE80211_CONN_DISABLE_HE |
+			       IEEE80211_CONN_DISABLE_EHT;
 		}
 		vht_chandef = *chandef;
 		goto out;
@@ -198,10 +199,10 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 			chandef->width = ieee80211_s1g_channel_width(channel);
 		}
 
-		ret = IEEE80211_CONN_DISABLE_HT | IEEE80211_CONN_DISABLE_40MHZ |
-		      IEEE80211_CONN_DISABLE_VHT |
-		      IEEE80211_CONN_DISABLE_80P80MHZ |
-		      IEEE80211_CONN_DISABLE_160MHZ;
+		ret |= IEEE80211_CONN_DISABLE_HT | IEEE80211_CONN_DISABLE_40MHZ |
+		       IEEE80211_CONN_DISABLE_VHT |
+		       IEEE80211_CONN_DISABLE_80P80MHZ |
+		       IEEE80211_CONN_DISABLE_160MHZ;
 		goto out;
 	}
 
@@ -210,10 +211,10 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 
 	if (!ht_oper || !sta_ht_cap.ht_supported) {
 		mlme_dbg(sdata, "HT operation missing / HT not supported\n");
-		ret = IEEE80211_CONN_DISABLE_HT |
-		      IEEE80211_CONN_DISABLE_VHT |
-		      IEEE80211_CONN_DISABLE_HE |
-		      IEEE80211_CONN_DISABLE_EHT;
+		ret |= IEEE80211_CONN_DISABLE_HT |
+		       IEEE80211_CONN_DISABLE_VHT |
+		       IEEE80211_CONN_DISABLE_HE |
+		       IEEE80211_CONN_DISABLE_EHT;
 		goto out;
 	}
 
@@ -234,10 +235,10 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 			   "Wrong control channel: center-freq: %d ht-cfreq: %d ht->primary_chan: %d band: %d - Disabling HT\n",
 			   channel->center_freq, ht_cfreq,
 			   ht_oper->primary_chan, channel->band);
-		ret = IEEE80211_CONN_DISABLE_HT |
-		      IEEE80211_CONN_DISABLE_VHT |
-		      IEEE80211_CONN_DISABLE_HE |
-		      IEEE80211_CONN_DISABLE_EHT;
+		ret |= IEEE80211_CONN_DISABLE_HT |
+		       IEEE80211_CONN_DISABLE_VHT |
+		       IEEE80211_CONN_DISABLE_HE |
+		       IEEE80211_CONN_DISABLE_EHT;
 		goto out;
 	}
 
@@ -247,7 +248,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 	} else {
 		mlme_dbg(sdata, "40 MHz not supported\n");
 		/* 40 MHz (and 80 MHz) must be supported for VHT */
-		ret = IEEE80211_CONN_DISABLE_VHT;
+		ret |= IEEE80211_CONN_DISABLE_VHT;
 		/* also mark 40 MHz disabled */
 		ret |= IEEE80211_CONN_DISABLE_40MHZ;
 		goto out;
@@ -255,7 +256,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 
 	if (!vht_oper || !sband->vht_cap.vht_supported) {
 		mlme_dbg(sdata, "VHT operation missing / VHT not supported\n");
-		ret = IEEE80211_CONN_DISABLE_VHT;
+		ret |= IEEE80211_CONN_DISABLE_VHT;
 		goto out;
 	}
 
@@ -279,7 +280,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 			if (!(conn_flags & IEEE80211_CONN_DISABLE_HE))
 				sdata_info(sdata,
 					   "HE AP VHT information is invalid, disabling HE\n");
-			ret = IEEE80211_CONN_DISABLE_HE | IEEE80211_CONN_DISABLE_EHT;
+			ret |= IEEE80211_CONN_DISABLE_HE | IEEE80211_CONN_DISABLE_EHT;
 			goto out;
 		}
 	} else if (!ieee80211_chandef_vht_oper(&sdata->local->hw,
@@ -289,7 +290,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 		if (!(conn_flags & IEEE80211_CONN_DISABLE_VHT))
 			sdata_info(sdata,
 				   "AP VHT information is invalid, disabling VHT\n");
-		ret = IEEE80211_CONN_DISABLE_VHT;
+		ret |= IEEE80211_CONN_DISABLE_VHT;
 		goto out;
 	}
 
@@ -297,12 +298,11 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 		if (!(conn_flags & IEEE80211_CONN_DISABLE_VHT))
 			sdata_info(sdata,
 				   "AP VHT information is invalid, disabling VHT\n");
-		ret = IEEE80211_CONN_DISABLE_VHT;
+		ret |= IEEE80211_CONN_DISABLE_VHT;
 		goto out;
 	}
 
 	if (cfg80211_chandef_identical(chandef, &vht_chandef)) {
-		ret = 0;
 		goto out;
 	}
 
@@ -310,7 +310,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 		if (!(conn_flags & IEEE80211_CONN_DISABLE_VHT))
 			sdata_info(sdata,
 				   "AP VHT information doesn't match HT, disabling VHT\n");
-		ret = IEEE80211_CONN_DISABLE_VHT;
+		ret |= IEEE80211_CONN_DISABLE_VHT;
 		goto out;
 	}
 
@@ -333,7 +333,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 			if (!(conn_flags & IEEE80211_CONN_DISABLE_EHT))
 				sdata_info(sdata,
 					   "AP EHT information is invalid, disabling EHT\n");
-			ret = IEEE80211_CONN_DISABLE_EHT;
+			ret |= IEEE80211_CONN_DISABLE_EHT;
 			goto out;
 		}
 
@@ -341,15 +341,13 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 			if (!(conn_flags & IEEE80211_CONN_DISABLE_EHT))
 				sdata_info(sdata,
 					   "AP EHT information is incompatible, disabling EHT\n");
-			ret = IEEE80211_CONN_DISABLE_EHT;
+			ret |= IEEE80211_CONN_DISABLE_EHT;
 			goto out;
 		}
 
 		*chandef = eht_chandef;
 	}
 
-	ret = 0;
-
 out:
 	/*
 	 * When tracking the current AP, don't do any further checks if the
@@ -389,10 +387,10 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 					tracking ? 0 :
 						   IEEE80211_CHAN_DISABLED)) {
 		if (WARN_ON(chandef->width == NL80211_CHAN_WIDTH_20_NOHT)) {
-			ret = IEEE80211_CONN_DISABLE_HT |
-			      IEEE80211_CONN_DISABLE_VHT |
-			      IEEE80211_CONN_DISABLE_HE |
-			      IEEE80211_CONN_DISABLE_EHT;
+			ret |= IEEE80211_CONN_DISABLE_HT |
+				IEEE80211_CONN_DISABLE_VHT |
+				IEEE80211_CONN_DISABLE_HE |
+				IEEE80211_CONN_DISABLE_EHT;
 			break;
 		}
 
-- 
2.39.1

