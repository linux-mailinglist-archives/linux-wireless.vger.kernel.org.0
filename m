Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53366584593
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Jul 2022 20:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiG1SQu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Jul 2022 14:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiG1SQt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Jul 2022 14:16:49 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BAD52E61
        for <linux-wireless@vger.kernel.org>; Thu, 28 Jul 2022 11:16:48 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.25])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id D0B3E2006C
        for <linux-wireless@vger.kernel.org>; Thu, 28 Jul 2022 18:16:46 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id EEF28B000F0
        for <linux-wireless@vger.kernel.org>; Thu, 28 Jul 2022 18:16:45 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 504EB13C2B0
        for <linux-wireless@vger.kernel.org>; Thu, 28 Jul 2022 11:16:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 504EB13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1659032205;
        bh=7LLcjKc252ck4p6ZMKyeTHHrDkZdOcXQ1pBYgyEV8l0=;
        h=To:From:Subject:Date:From;
        b=ZlmFytHJd8UAcHuVaQRj4224+RftsJf43Ujt8RN6RCMG7nlw5u9W8FfeV9ZCeDhdk
         CTbm2AEAyoEQdLMHHzSWEgFhLfrPNRWk1nHySkBrtpD90BuZe2llfBc1BNORencG5l
         7M7jKfbsFmSDMluOr6feseRbgHTRjTdhLCG/7Dx0=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: Problem changing bw in 5.19 related to EHT?
Organization: Candela Technologies
Message-ID: <be7f0ca3-5d93-0592-1153-7020a3cf2f2c@candelatech.com>
Date:   Thu, 28 Jul 2022 11:16:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1659032207-dFSjVS-5Jv74
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

 From what I can tell, my 160Mhz STA was not properly connecting to a 160Mhz AP
because ieee80211_determine_chantype was not ORing in the IEEE80211_STA_DISABLE_EHT
flag.  eht_oper is NULL in my case, as this is an AX radio on both sides.

The change below allows the STA to connect for me.  I'm not sure if this
is the best fix or not, however....any opinions?

Thanks,
Ben


diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 6de771313657..d5ee411e6c93 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -167,7 +167,8 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
         struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
         struct cfg80211_chan_def vht_chandef;
         struct ieee80211_sta_ht_cap sta_ht_cap;
-       u32 ht_cfreq, ret;
+       u32 ht_cfreq;
+       u32 ret = 0;

         memset(chandef, 0, sizeof(struct cfg80211_chan_def));
         chandef->chan = channel;
@@ -175,17 +176,18 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
         chandef->center_freq1 = channel->center_freq;
         chandef->freq1_offset = channel->freq_offset;

+       if (!eht_oper)
+               ret |= IEEE80211_STA_DISABLE_EHT;
+
         if (channel->band == NL80211_BAND_6GHZ) {
                 if (!ieee80211_chandef_he_6ghz_oper(sdata, he_oper, eht_oper,
                                                     chandef)) {
                         mlme_dbg(sdata,
                                  "bad 6 GHz operation, disabling HT/VHT/HE/EHT\n");
-                       ret = IEEE80211_STA_DISABLE_HT |
-                             IEEE80211_STA_DISABLE_VHT |
-                             IEEE80211_STA_DISABLE_HE |
-                             IEEE80211_STA_DISABLE_EHT;
-               } else {
-                       ret = 0;
+                       ret |= IEEE80211_STA_DISABLE_HT |
+                              IEEE80211_STA_DISABLE_VHT |
+                              IEEE80211_STA_DISABLE_HE |
+                              IEEE80211_STA_DISABLE_EHT;
                 }
                 vht_chandef = *chandef;
                 goto out;
@@ -196,10 +198,10 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
                         chandef->width = ieee80211_s1g_channel_width(channel);
                 }

-               ret = IEEE80211_STA_DISABLE_HT | IEEE80211_STA_DISABLE_40MHZ |
-                     IEEE80211_STA_DISABLE_VHT |
-                     IEEE80211_STA_DISABLE_80P80MHZ |
-                     IEEE80211_STA_DISABLE_160MHZ;
+               ret |= IEEE80211_STA_DISABLE_HT | IEEE80211_STA_DISABLE_40MHZ |
+                      IEEE80211_STA_DISABLE_VHT |
+                      IEEE80211_STA_DISABLE_80P80MHZ |
+                      IEEE80211_STA_DISABLE_160MHZ;
                 goto out;
         }

@@ -208,10 +210,10 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,

         if (!ht_oper || !sta_ht_cap.ht_supported) {
                 mlme_dbg(sdata, "HT operation missing / HT not supported\n");
-               ret = IEEE80211_STA_DISABLE_HT |
-                     IEEE80211_STA_DISABLE_VHT |
-                     IEEE80211_STA_DISABLE_HE |
-                     IEEE80211_STA_DISABLE_EHT;
+               ret |= IEEE80211_STA_DISABLE_HT |
+                      IEEE80211_STA_DISABLE_VHT |
+                      IEEE80211_STA_DISABLE_HE |
+                      IEEE80211_STA_DISABLE_EHT;
                 goto out;
         }

@@ -232,10 +234,10 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
                            "Wrong control channel: center-freq: %d ht-cfreq: %d ht->primary_chan: %d band: %d - Disabling HT\n",
                            channel->center_freq, ht_cfreq,
                            ht_oper->primary_chan, channel->band);
-               ret = IEEE80211_STA_DISABLE_HT |
-                     IEEE80211_STA_DISABLE_VHT |
-                     IEEE80211_STA_DISABLE_HE |
-                     IEEE80211_STA_DISABLE_EHT;
+               ret |= IEEE80211_STA_DISABLE_HT |
+                      IEEE80211_STA_DISABLE_VHT |
+                      IEEE80211_STA_DISABLE_HE |
+                      IEEE80211_STA_DISABLE_EHT;
                 goto out;
         }

@@ -245,7 +247,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
         } else {
                 mlme_dbg(sdata, "40 MHz not supported\n");
                 /* 40 MHz (and 80 MHz) must be supported for VHT */
-               ret = IEEE80211_STA_DISABLE_VHT;
+               ret |= IEEE80211_STA_DISABLE_VHT;
                 /* also mark 40 MHz disabled */
                 ret |= IEEE80211_STA_DISABLE_40MHZ;
                 goto out;
@@ -253,7 +255,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,

         if (!vht_oper || !sband->vht_cap.vht_supported) {
                 mlme_dbg(sdata, "VHT operation missing / VHT not supported\n");
-               ret = IEEE80211_STA_DISABLE_VHT;
+               ret |= IEEE80211_STA_DISABLE_VHT;
                 goto out;
         }

@@ -276,7 +278,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
                         if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HE))
                                 sdata_info(sdata,
                                            "HE AP VHT information is invalid, disabling HE\n");
-                       ret = IEEE80211_STA_DISABLE_HE | IEEE80211_STA_DISABLE_EHT;
+                       ret |= IEEE80211_STA_DISABLE_HE | IEEE80211_STA_DISABLE_EHT;
                         goto out;
                 }
         } else if (!ieee80211_chandef_vht_oper(&sdata->local->hw,
@@ -286,7 +288,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
                 if (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT))
                         sdata_info(sdata,
                                    "AP VHT information is invalid, disabling VHT\n");
-               ret = IEEE80211_STA_DISABLE_VHT;
+               ret |= IEEE80211_STA_DISABLE_VHT;
                 goto out;
         }

@@ -294,12 +296,11 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
                 if (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT))
                         sdata_info(sdata,
                                    "AP VHT information is invalid, disabling VHT\n");
-               ret = IEEE80211_STA_DISABLE_VHT;
+               ret |= IEEE80211_STA_DISABLE_VHT;
                 goto out;
         }

         if (cfg80211_chandef_identical(chandef, &vht_chandef)) {
-               ret = 0;
                 goto out;
         }

@@ -307,14 +308,12 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
                 if (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT))
                         sdata_info(sdata,
                                    "AP VHT information doesn't match HT, disabling VHT\n");
-               ret = IEEE80211_STA_DISABLE_VHT;
+               ret |= IEEE80211_STA_DISABLE_VHT;
                 goto out;
         }

         *chandef = vht_chandef;

-       ret = 0;
-
  out:
         /*
          * When tracking the current AP, don't do any further checks if the
@@ -354,10 +353,10 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
                                         tracking ? 0 :
                                                    IEEE80211_CHAN_DISABLED)) {
                 if (WARN_ON(chandef->width == NL80211_CHAN_WIDTH_20_NOHT)) {
-                       ret = IEEE80211_STA_DISABLE_HT |
-                             IEEE80211_STA_DISABLE_VHT |
-                             IEEE80211_STA_DISABLE_HE |
-                             IEEE80211_STA_DISABLE_EHT;
+                       ret |= IEEE80211_STA_DISABLE_HT |
+                              IEEE80211_STA_DISABLE_VHT |
+                              IEEE80211_STA_DISABLE_HE |
+                              IEEE80211_STA_DISABLE_EHT;
                         break;
                 }


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

