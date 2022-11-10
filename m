Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E9B624736
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Nov 2022 17:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiKJQks (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Nov 2022 11:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbiKJQkr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Nov 2022 11:40:47 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5793740913
        for <linux-wireless@vger.kernel.org>; Thu, 10 Nov 2022 08:40:46 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id b29so2657777pfp.13
        for <linux-wireless@vger.kernel.org>; Thu, 10 Nov 2022 08:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+tS7l+7sPNDJCBK5t8QzEw6hTvxujfl3brJNybjurTQ=;
        b=FxOd5GAR/+gs/lKAflTGX6uadd7Qk34A8tEkZ4oajCUmcMiyRxSZYv6qAUORvZipHZ
         kmyo/IfYLpwNWxLWDWfjHE3v6RDHyHxIPrjIXsMIeFM7L8LsokAwsEDYgTkjtUc+RmM7
         uPIUBON0d+tDv7ZyuvnL8WiDxkZGLccnxprYb8BGaH/4t0gJrsKQBOblY/HI54TLCnh9
         p/aH1qm5dP6kYyeqzAdxrOsxVrWa90oCP0HR6jSO47b8v6vlQ3q6ihmFFOdqctMShzXS
         weqO5hxMs2H+NrVgrsaviKcfrA9dfAGYyrsFVi9KSFQnaU/EJtRhWHsQPSJRZS4fz6hx
         6mcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tS7l+7sPNDJCBK5t8QzEw6hTvxujfl3brJNybjurTQ=;
        b=DMHlGG4DGbEBPVToqgK+2jy6XvBAh1tPzSoufKyqPvbGVaUNVRRPJErKp3HY1gy7ZS
         lvuIq/daHZCwabdMiLJfBwZoiI6/by9IuALqmiVBiPtmv3hgjHItYdVIQgWAhnv+77p6
         7xChI1csHAuEKPkOVt5p4MsDfkD21TtIL/ZjTcgeuLZ1ap/vEUiDgmMZEUY/6wFHe0Os
         p9OdkqEhQ3EC+GFgHUmc48t1Xcr6DPFH7+ikldqC4/8C78A6dVCpnOLtfgnG8PxoBVPz
         Jy/6VNyJD86eaW1Lc6nMvWlCPynyxdZpMHdIcqLWfwWYkQ5VCt3BrhFA8DQpAT+fo9j3
         yaZA==
X-Gm-Message-State: ACrzQf2uT44DBptuN5Z8G7i3+EtxMT/w1/DdoN+fWlMWrHupzMG9VPdu
        ykqPo9wvvf2WBP6a9ImYEnU=
X-Google-Smtp-Source: AMsMyM41ZKRolLBsqIqB0CI0WU0CFRP1V8MoDjNShQiLvrZUUaACk/G/hQQHE4v+gS80fTGyVa/ujA==
X-Received: by 2002:a63:2017:0:b0:460:7078:dd7a with SMTP id g23-20020a632017000000b004607078dd7amr2819124pgg.286.1668098445655;
        Thu, 10 Nov 2022 08:40:45 -0800 (PST)
Received: from Redminer.localdomain ([115.165.217.97])
        by smtp.gmail.com with ESMTPSA id t7-20020a635f07000000b0046a1c832e9fsm9336929pgb.34.2022.11.10.08.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:40:45 -0800 (PST)
From:   Zhi-Jun You <hujy652@gmail.com>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Zhi-Jun You <hujy652@gmail.com>
Subject: [PATCH] wifi: ath10k: Remove redundant argument offset
Date:   Fri, 11 Nov 2022 00:40:25 +0800
Message-Id: <20221110164025.14418-1-hujy652@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This argument of ath10k_htt_rx_h_frag_pn_check() is always set to 0 so
drop this.

Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
---
 drivers/net/wireless/ath/ath10k/htt_rx.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index 3df52906b356..438b0caaceb7 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -1844,15 +1844,14 @@ static void ath10k_htt_rx_h_csum_offload(struct ath10k_hw_params *hw,
 }
 
 static u64 ath10k_htt_rx_h_get_pn(struct ath10k *ar, struct sk_buff *skb,
-				  u16 offset,
 				  enum htt_rx_mpdu_encrypt_type enctype)
 {
 	struct ieee80211_hdr *hdr;
 	u64 pn = 0;
 	u8 *ehdr;
 
-	hdr = (struct ieee80211_hdr *)(skb->data + offset);
-	ehdr = skb->data + offset + ieee80211_hdrlen(hdr->frame_control);
+	hdr = (struct ieee80211_hdr *)skb->data;
+	ehdr = skb->data + ieee80211_hdrlen(hdr->frame_control);
 
 	if (enctype == HTT_RX_MPDU_ENCRYPT_AES_CCM_WPA2) {
 		pn = ehdr[0];
@@ -1866,19 +1865,17 @@ static u64 ath10k_htt_rx_h_get_pn(struct ath10k *ar, struct sk_buff *skb,
 }
 
 static bool ath10k_htt_rx_h_frag_multicast_check(struct ath10k *ar,
-						 struct sk_buff *skb,
-						 u16 offset)
+						 struct sk_buff *skb)
 {
 	struct ieee80211_hdr *hdr;
 
-	hdr = (struct ieee80211_hdr *)(skb->data + offset);
+	hdr = (struct ieee80211_hdr *)skb->data;
 	return !is_multicast_ether_addr(hdr->addr1);
 }
 
 static bool ath10k_htt_rx_h_frag_pn_check(struct ath10k *ar,
 					  struct sk_buff *skb,
 					  u16 peer_id,
-					  u16 offset,
 					  enum htt_rx_mpdu_encrypt_type enctype)
 {
 	struct ath10k_peer *peer;
@@ -1893,14 +1890,14 @@ static bool ath10k_htt_rx_h_frag_pn_check(struct ath10k *ar,
 		return false;
 	}
 
-	hdr = (struct ieee80211_hdr *)(skb->data + offset);
+	hdr = (struct ieee80211_hdr *)skb->data;
 	if (ieee80211_is_data_qos(hdr->frame_control))
 		tid = ieee80211_get_tid(hdr);
 	else
 		tid = ATH10K_TXRX_NON_QOS_TID;
 
 	last_pn = &peer->frag_tids_last_pn[tid];
-	new_pn.pn48 = ath10k_htt_rx_h_get_pn(ar, skb, offset, enctype);
+	new_pn.pn48 = ath10k_htt_rx_h_get_pn(ar, skb, enctype);
 	frag_number = le16_to_cpu(hdr->seq_ctrl) & IEEE80211_SCTL_FRAG;
 	seq = IEEE80211_SEQ_TO_SN(__le16_to_cpu(hdr->seq_ctrl));
 
@@ -2059,13 +2056,11 @@ static void ath10k_htt_rx_h_mpdu(struct ath10k *ar,
 			frag_pn_check = ath10k_htt_rx_h_frag_pn_check(ar,
 								      msdu,
 								      peer_id,
-								      0,
 								      enctype);
 
 		if (frag)
 			multicast_check = ath10k_htt_rx_h_frag_multicast_check(ar,
-									       msdu,
-									       0);
+									       msdu);
 
 		if (!frag_pn_check || !multicast_check) {
 			/* Discard the fragment with invalid PN or multicast DA
-- 
2.34.1

