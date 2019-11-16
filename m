Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 059FEFEAE4
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2019 07:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbfKPGIn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Nov 2019 01:08:43 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43845 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfKPGIn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Nov 2019 01:08:43 -0500
Received: by mail-qt1-f196.google.com with SMTP id j5so11961534qtn.10
        for <linux-wireless@vger.kernel.org>; Fri, 15 Nov 2019 22:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TyEerrqUTsjwpthty/7roB5RvM/byURHtg9ZSFitcNg=;
        b=s9o+37Wzr8SdzPET2kPeTr6tKk7HBlFTfMyjtSV4ErGS66RS9wx4DfEr8r1dRBxHaO
         nzyWla7JFL8VGeZbRtM9qN2sxLXMQ/YcCu9ENIU/RYadsIrgyRaniAahIpK+20hJVee1
         rjeFW05LdJM6PpLon4W9hVG39eKQPsxlcMUaAZmGZzYG0/IIfB+l4GQUF9ZMqBWlmxx9
         HsT1ADN2NPqW4qEar4TDHhcTy4hwnOHJjRXVs9al+HqvlzOiAEDcxg381gAcRLPinEpR
         AorvQ/HjQ0gQECR30tTEjrgyi1zHBxFQt04912DvaTgB8ZhzMRL573FDgaPJWVaYKIxq
         K3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TyEerrqUTsjwpthty/7roB5RvM/byURHtg9ZSFitcNg=;
        b=L/OqP74uimA+JAGzJM1SdHI7lr01ai5YXW9Aqwp0PUtawX85Vylzk+ZqSshv04C/ci
         Hnymq0ULQzrYgQzkp7Rvjp915D6tZlwmdULj3Y+/BqzckIeBGlrr+fVrjSoejPV5YgHC
         XbFRk9v/5IP/bqS2ME1Zgi5NhcHc7na/1tmeQnKQ8pcwdAmjtsotKrUqyRb1v2bX6mNu
         kYouKRJZS8ZAhCEzqGKdfgHK+eT2eKrc0ZiruhInuhp0ISVz05K+S4bIKgcGkN5Mwfro
         9nOWrlMEcyYJKT1UIUbPbmZ2UZtmnIdLGwe6cuIS7qXrJ7J7KDbVx2ZItgk3eFh2mwuF
         RqTg==
X-Gm-Message-State: APjAAAUr25+2nGCUUOBqugcVYqeEKQAxiDGaBz5xZajgaWt/EsAsC9Qw
        Pf2hLVSMDk68XTujY5F94oGUq/uIjXY=
X-Google-Smtp-Source: APXvYqzVVEaapMmdZMlOd3lqJWJB4jNJROuMB7OenOEQ1lI1JD9tZnddYDX7WFAk4zwIlF3zDFlvVg==
X-Received: by 2002:ac8:2dc9:: with SMTP id q9mr18239840qta.219.1573884522539;
        Fri, 15 Nov 2019 22:08:42 -0800 (PST)
Received: from ubuntu.wgti.net ([64.94.121.131])
        by smtp.gmail.com with ESMTPSA id g7sm5270505qkl.20.2019.11.15.22.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 22:08:41 -0800 (PST)
From:   Ming Chen <ming032217@gmail.com>
X-Google-Original-From: Ming Chen <ming.chen@watchguard.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Ming Chen <ming.chen@watchguard.com>
Subject: [PATCH v4] mac80211: Drop the packets whose source or destination mac address is empty
Date:   Fri, 15 Nov 2019 22:08:33 -0800
Message-Id: <20191116060833.45752-1-ming.chen@watchguard.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We found ath9k could occasionally receive some frames from Linux IP stack with empty source
and destination mac address, especially when the radio mode works as a wireless client and
configure a static IP. If the ADDBA has been negotiated, this kind of error packets will cause
the driver failed to find the opposite node (VAP) while in the function of processing these frame's TX
complete interrupt.

The above failure happens inside the TX complete processing
function ath_tx_process_buffer while calling ieee80211_find_sta_by_ifaddr.
Inside the function ieee80211_find_sta_by_ifaddr,
the condition of ether_addr_equal(sta->sdata->vif.addr, localaddr) will return false
since localaddr(hdr->addr2, 802.3 source mac) is an empty mac address.

Finally, this function will return NULL to ath_tx_process_buffer.
And then ath_tx_process_buffer will call ath_tx_complete_aggr to complete the frame(s),
However, the sta is NULL at this moment, so it could complete this kind
of the frame(s) but doesn't (and cannot) update the BA window.
Please see the below snippet of ath_tx_complete_aggr
if (!sta) {
        INIT_LIST_HEAD(&bf_head);
        while (bf) {
                bf_next = bf->bf_next;

                if (!bf->bf_state.stale || bf_next != NULL)
                        list_move_tail(&bf->list, &bf_head);

                ath_tx_complete_buf(sc, bf, txq, &bf_head, NULL, ts, 0);

                bf = bf_next;
        }
        return;
}

To fix this issue, we could remove the comparison of localaddr of ieee80211_find_sta_by_ifaddr
when works as a wireless client - it won't have more than one sta (VAP) found, but I don't think
it is the best solution. Dropping this kind of error packet before it
goes into the driver, should be the right direction.

Signed-off-by: Ming Chen <ming.chen@watchguard.com>
---
v4:
  -Add more details for the changelog

v3:
  -Fix s-o-b location

v2:
  -According to review feedback, use the is_zero_ether_addr to check if the mac address is empty.
---
 net/mac80211/tx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index db38be1b75fa..b18745a3f6b0 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2489,6 +2489,13 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 	if (IS_ERR(sta))
 		sta = NULL;
 
+	/* drop this skb when source mac or destination mac is empty */
+	if (is_zero_ether_addr(skb->data) ||
+	    is_zero_ether_addr(skb->data + ETH_ALEN)) {
+		ret = -ENOTCONN;
+		goto free;
+	}
+
 #ifdef CONFIG_MAC80211_DEBUGFS
 	if (local->force_tx_status)
 		info_flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
@@ -3435,6 +3442,11 @@ static bool ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
 	if (skb->sk && skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)
 		return false;
 
+	/* drop this skb when source mac or destination mac is empty */
+	if (is_zero_ether_addr(skb->data) ||
+	    is_zero_ether_addr(skb->data + ETH_ALEN))
+		return false;
+
 	if (hdr->frame_control & cpu_to_le16(IEEE80211_STYPE_QOS_DATA)) {
 		tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
 		tid_tx = rcu_dereference(sta->ampdu_mlme.tid_tx[tid]);
-- 
2.17.1

