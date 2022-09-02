Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA2E5AB41F
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237185AbiIBOvZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235804AbiIBOvE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:51:04 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51BF60511
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 07:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=pFlH9QJ0Tu9QUkv6XtEFOcTLQO9K51Og7QklmrQ2Q5A=;
        t=1662127986; x=1663337586; b=jTLBe4UK9rtmgpErTI/5LTrgEk8Q5/X2lNRQJViNHQK5SZ/
        mailEFfGwz5D8DPfB24gYIJ7bjnCitd2fVgB7i4L8v0VgDYbLH2F7L0bHRbZDQM36tEf0nzKtkNkC
        kGdNFDFkAcEKl7h89fooJbLYg83jPa05lJ/gKez3bHgyA2YzYrZD5m2QpBfmr1Ve1olawo8wAxn38
        RBPRbdWQsn+KrRjIlEP87fCS69/9PrBrfdzeHwFEfMEcnP+PuV8b9xClCc2QQrqdTaP1RrfjYQl8m
        /z03qjKOHOusTSNvThdBgDvjjtCXEH+ZbbTnUGV5+P9BxJkkOH84V3Oed/4lfYOg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oU7Pr-006Ch3-2Q;
        Fri, 02 Sep 2022 16:13:03 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 04/27] wifi: mac80211_hwsim: refactor RX a bit
Date:   Fri,  2 Sep 2022 16:12:36 +0200
Message-Id: <20220902161143.e729665195b5.I20f6e373f1f172014fdf3dcb5ad6709db45d9eb8@changeid>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220902141259.377789-1-johannes@sipsolutions.net>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
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

From: Johannes Berg <johannes.berg@intel.com>

Refactor some common RX functionality between the netlink
and non-netlink paths, adding the special hwsim TLV (if
compiled) also in the netlink path.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 48b1c39c1c05..70a72a03398a 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -1561,6 +1561,19 @@ static void mac80211_hwsim_add_vendor_rtap(struct sk_buff *skb)
 #endif
 }
 
+static void mac80211_hwsim_rx(struct mac80211_hwsim_data *data,
+			      struct ieee80211_rx_status *rx_status,
+			      struct sk_buff *skb)
+{
+	memcpy(IEEE80211_SKB_RXCB(skb), rx_status, sizeof(*rx_status));
+
+	mac80211_hwsim_add_vendor_rtap(skb);
+
+	data->rx_pkts++;
+	data->rx_bytes += skb->len;
+	ieee80211_rx_irqsafe(data->hw, skb);
+}
+
 static bool mac80211_hwsim_tx_frame_no_nl(struct ieee80211_hw *hw,
 					  struct sk_buff *skb,
 					  struct ieee80211_channel *chan)
@@ -1688,13 +1701,7 @@ static bool mac80211_hwsim_tx_frame_no_nl(struct ieee80211_hw *hw,
 
 		rx_status.mactime = now + data2->tsf_offset;
 
-		memcpy(IEEE80211_SKB_RXCB(nskb), &rx_status, sizeof(rx_status));
-
-		mac80211_hwsim_add_vendor_rtap(nskb);
-
-		data2->rx_pkts++;
-		data2->rx_bytes += nskb->len;
-		ieee80211_rx_irqsafe(data2->hw, nskb);
+		mac80211_hwsim_rx(data2, &rx_status, nskb);
 	}
 	spin_unlock(&hwsim_radio_lock);
 
@@ -4907,10 +4914,7 @@ static int hwsim_cloned_frame_received_nl(struct sk_buff *skb_2,
 	    ieee80211_is_probe_resp(hdr->frame_control))
 		rx_status.boottime_ns = ktime_get_boottime_ns();
 
-	memcpy(IEEE80211_SKB_RXCB(skb), &rx_status, sizeof(rx_status));
-	data2->rx_pkts++;
-	data2->rx_bytes += skb->len;
-	ieee80211_rx_irqsafe(data2->hw, skb);
+	mac80211_hwsim_rx(data2, &rx_status, skb);
 
 	return 0;
 err:
-- 
2.37.2

