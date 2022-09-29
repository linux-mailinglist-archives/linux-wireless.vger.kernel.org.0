Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A14A5EF878
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Sep 2022 17:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbiI2PQp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Sep 2022 11:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbiI2PQn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Sep 2022 11:16:43 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8BC14D4A1
        for <linux-wireless@vger.kernel.org>; Thu, 29 Sep 2022 08:16:42 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.27])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 217AA2005E
        for <linux-wireless@vger.kernel.org>; Thu, 29 Sep 2022 15:16:41 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id DBB156000A4
        for <linux-wireless@vger.kernel.org>; Thu, 29 Sep 2022 15:16:40 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 5C77213C2B0;
        Thu, 29 Sep 2022 08:16:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 5C77213C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1664464600;
        bh=x94MHH0KixgXP/6uAeqXtWk+ZT9HATZ5HpwhoHQ5Qio=;
        h=From:To:Cc:Subject:Date:From;
        b=hRt65Tdy8owhZZl6AkCKYK3xzAE2cFsfMVrVA50VPAU5zDQlrigzoG3jHJm3oE3XB
         eJuz7T+6D/Lcr57gZ428yDptLr6VOm0m8+w4u5wSJc3wfGc34DojxW3E3qwp6tnEyT
         2Wf67xEXAYLb+CYzxXaDmbVkh3Zras2FTcklQheI=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] wifi: mac80211: fix EHT issue in ieee80211_determine_chantype
Date:   Thu, 29 Sep 2022 08:16:38 -0700
Message-Id: <20220929151638.9823-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1664464601-gMM-s-TitvDb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 net/mac80211/mlme.c | 63 ++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 011827137da7..9ac99f48c63b 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -167,7 +167,8 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct cfg80211_chan_def vht_chandef;
 	struct ieee80211_sta_ht_cap sta_ht_cap;
-	u32 ht_cfreq, ret;
+	u32 ht_cfreq;
+	u32 ret = 0;
 
 	memset(chandef, 0, sizeof(struct cfg80211_chan_def));
 	chandef->chan = channel;
@@ -175,17 +176,18 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 	chandef->center_freq1 = channel->center_freq;
 	chandef->freq1_offset = channel->freq_offset;
 
+	if (!eht_oper)
+		ret |= IEEE80211_STA_DISABLE_EHT;
+
 	if (channel->band == NL80211_BAND_6GHZ) {
 		if (!ieee80211_chandef_he_6ghz_oper(sdata, he_oper, eht_oper,
 						    chandef)) {
 			mlme_dbg(sdata,
 				 "bad 6 GHz operation, disabling HT/VHT/HE/EHT\n");
-			ret = IEEE80211_STA_DISABLE_HT |
-			      IEEE80211_STA_DISABLE_VHT |
-			      IEEE80211_STA_DISABLE_HE |
-			      IEEE80211_STA_DISABLE_EHT;
-		} else {
-			ret = 0;
+			ret |= IEEE80211_STA_DISABLE_HT |
+			       IEEE80211_STA_DISABLE_VHT |
+			       IEEE80211_STA_DISABLE_HE |
+			       IEEE80211_STA_DISABLE_EHT;
 		}
 		vht_chandef = *chandef;
 		goto out;
@@ -196,10 +198,10 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 			chandef->width = ieee80211_s1g_channel_width(channel);
 		}
 
-		ret = IEEE80211_STA_DISABLE_HT | IEEE80211_STA_DISABLE_40MHZ |
-		      IEEE80211_STA_DISABLE_VHT |
-		      IEEE80211_STA_DISABLE_80P80MHZ |
-		      IEEE80211_STA_DISABLE_160MHZ;
+		ret |= IEEE80211_STA_DISABLE_HT | IEEE80211_STA_DISABLE_40MHZ |
+		       IEEE80211_STA_DISABLE_VHT |
+		       IEEE80211_STA_DISABLE_80P80MHZ |
+		       IEEE80211_STA_DISABLE_160MHZ;
 		goto out;
 	}
 
@@ -208,10 +210,10 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 
 	if (!ht_oper || !sta_ht_cap.ht_supported) {
 		mlme_dbg(sdata, "HT operation missing / HT not supported\n");
-		ret = IEEE80211_STA_DISABLE_HT |
-		      IEEE80211_STA_DISABLE_VHT |
-		      IEEE80211_STA_DISABLE_HE |
-		      IEEE80211_STA_DISABLE_EHT;
+		ret |= IEEE80211_STA_DISABLE_HT |
+		       IEEE80211_STA_DISABLE_VHT |
+		       IEEE80211_STA_DISABLE_HE |
+		       IEEE80211_STA_DISABLE_EHT;
 		goto out;
 	}
 
@@ -232,10 +234,10 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 			   "Wrong control channel: center-freq: %d ht-cfreq: %d ht->primary_chan: %d band: %d - Disabling HT\n",
 			   channel->center_freq, ht_cfreq,
 			   ht_oper->primary_chan, channel->band);
-		ret = IEEE80211_STA_DISABLE_HT |
-		      IEEE80211_STA_DISABLE_VHT |
-		      IEEE80211_STA_DISABLE_HE |
-		      IEEE80211_STA_DISABLE_EHT;
+		ret |= IEEE80211_STA_DISABLE_HT |
+		       IEEE80211_STA_DISABLE_VHT |
+		       IEEE80211_STA_DISABLE_HE |
+		       IEEE80211_STA_DISABLE_EHT;
 		goto out;
 	}
 
@@ -245,7 +247,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 	} else {
 		mlme_dbg(sdata, "40 MHz not supported\n");
 		/* 40 MHz (and 80 MHz) must be supported for VHT */
-		ret = IEEE80211_STA_DISABLE_VHT;
+		ret |= IEEE80211_STA_DISABLE_VHT;
 		/* also mark 40 MHz disabled */
 		ret |= IEEE80211_STA_DISABLE_40MHZ;
 		goto out;
@@ -253,7 +255,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 
 	if (!vht_oper || !sband->vht_cap.vht_supported) {
 		mlme_dbg(sdata, "VHT operation missing / VHT not supported\n");
-		ret = IEEE80211_STA_DISABLE_VHT;
+		ret |= IEEE80211_STA_DISABLE_VHT;
 		goto out;
 	}
 
@@ -276,7 +278,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 			if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HE))
 				sdata_info(sdata,
 					   "HE AP VHT information is invalid, disabling HE\n");
-			ret = IEEE80211_STA_DISABLE_HE | IEEE80211_STA_DISABLE_EHT;
+			ret |= IEEE80211_STA_DISABLE_HE | IEEE80211_STA_DISABLE_EHT;
 			goto out;
 		}
 	} else if (!ieee80211_chandef_vht_oper(&sdata->local->hw,
@@ -286,7 +288,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 		if (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT))
 			sdata_info(sdata,
 				   "AP VHT information is invalid, disabling VHT\n");
-		ret = IEEE80211_STA_DISABLE_VHT;
+		ret |= IEEE80211_STA_DISABLE_VHT;
 		goto out;
 	}
 
@@ -294,12 +296,11 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 		if (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT))
 			sdata_info(sdata,
 				   "AP VHT information is invalid, disabling VHT\n");
-		ret = IEEE80211_STA_DISABLE_VHT;
+		ret |= IEEE80211_STA_DISABLE_VHT;
 		goto out;
 	}
 
 	if (cfg80211_chandef_identical(chandef, &vht_chandef)) {
-		ret = 0;
 		goto out;
 	}
 
@@ -307,14 +308,12 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 		if (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT))
 			sdata_info(sdata,
 				   "AP VHT information doesn't match HT, disabling VHT\n");
-		ret = IEEE80211_STA_DISABLE_VHT;
+		ret |= IEEE80211_STA_DISABLE_VHT;
 		goto out;
 	}
 
 	*chandef = vht_chandef;
 
-	ret = 0;
-
 out:
 	/*
 	 * When tracking the current AP, don't do any further checks if the
@@ -354,10 +353,10 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 					tracking ? 0 :
 						   IEEE80211_CHAN_DISABLED)) {
 		if (WARN_ON(chandef->width == NL80211_CHAN_WIDTH_20_NOHT)) {
-			ret = IEEE80211_STA_DISABLE_HT |
-			      IEEE80211_STA_DISABLE_VHT |
-			      IEEE80211_STA_DISABLE_HE |
-			      IEEE80211_STA_DISABLE_EHT;
+			ret |= IEEE80211_STA_DISABLE_HT |
+			       IEEE80211_STA_DISABLE_VHT |
+			       IEEE80211_STA_DISABLE_HE |
+			       IEEE80211_STA_DISABLE_EHT;
 			break;
 		}
 
-- 
2.20.1

