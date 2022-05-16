Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D26528005
	for <lists+linux-wireless@lfdr.de>; Mon, 16 May 2022 10:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241911AbiEPIqv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 May 2022 04:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241910AbiEPIqm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 May 2022 04:46:42 -0400
X-Greylist: delayed 441 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 May 2022 01:46:38 PDT
Received: from ns.iliad.fr (ns.iliad.fr [212.27.33.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A16FFB
        for <linux-wireless@vger.kernel.org>; Mon, 16 May 2022 01:46:36 -0700 (PDT)
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 2924220425;
        Mon, 16 May 2022 10:39:13 +0200 (CEST)
Received: from sakura (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 25D7220264;
        Mon, 16 May 2022 10:39:13 +0200 (CEST)
Message-ID: <19cbe5dd1d7f0e194ed40c8db2cf2beffa3ae167.camel@freebox.fr>
Subject: [RFC][PATCH] mac80211: fix VHT 160Mhz bandwidth when using extended
 NSS on PHY with NSS ratio
From:   Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Mon, 16 May 2022 10:39:13 +0200
Organization: Freebox
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon May 16 10:39:13 2022 +0200 (CEST)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


A PHY supporting 160Mhz with a reduced number of NSS may not have any
of the IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK bits set.

For exemple, the QCA9984 is 4x4, but can only do 2x2 VHT160 or
80+80. The corresponding VHT capabilities should be:
 - IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK == 0
 - Extended NSS BW == 2

If we use that hardware in AP mode, and a 160Mhz 2x2 STA without NSS
restriction connects to it, then that STA will set
IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK to 1.

The usual logic of using bitwise-and with our own capabilities does
not work here, the current code clears the SUPP_CHAN_WIDTH bits and
resolve STA bandwidth to 80Mhz instead of 160Mhz, fix this.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 net/mac80211/vht.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index e856f9092137..7ef93adc4f24 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -230,9 +230,11 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 	       sizeof(struct ieee80211_vht_mcs_info));
 
 	/* copy EXT_NSS_BW Support value or remove the capability */
-	if (ieee80211_hw_check(&sdata->local->hw, SUPPORTS_VHT_EXT_NSS_BW))
+	if (ieee80211_hw_check(&sdata->local->hw, SUPPORTS_VHT_EXT_NSS_BW)) {
+		vht_cap->cap |= cap_info &
+			IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK;
 		vht_cap->cap |= (cap_info & IEEE80211_VHT_CAP_EXT_NSS_BW_MASK);
-	else
+	} else
 		vht_cap->vht_mcs.tx_highest &=
 			~cpu_to_le16(IEEE80211_VHT_EXT_NSS_BW_CAPABLE);
 
-- 
2.17.1


