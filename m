Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F47F61E362
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Nov 2022 17:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiKFQWb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Nov 2022 11:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiKFQWa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Nov 2022 11:22:30 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD4D6386
        for <linux-wireless@vger.kernel.org>; Sun,  6 Nov 2022 08:22:29 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id f63so8468416pgc.2
        for <linux-wireless@vger.kernel.org>; Sun, 06 Nov 2022 08:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/wVMRQYq8fkVBXtAwiW4f5YaI2apCsd/u8FPJMnqNok=;
        b=g/3dZ7V6H4TGo6Dx9VFMdPSAakRhYAvypjCvUEz/ORr2IGW9cP/rNct16U9A4LBoQV
         DqrJw6LPZthIM4YQIbD6bX3n8UlmvMmB/B0o7sJvmX9I5NY/pf9k4i3ItWnwX37xuo8D
         AVGNrxztMlS/SWiDtWj1q1oN2QeQzBzkk8JIs/7eJYaBetHCJNq8Sr/PhcOamlMWHBLk
         4QovzyhjlFFrrnfY3a/fySl7jpFGKVAcb/WgtP5YR1f5F5GnqW/dTzYmiHjSc598GSoW
         OHGS4Q+nH+eQuCpRB83XMYHmkL3HjbmXUiti9XLD57gY9S4q+kDKtFgYxtVNN2BJEJPN
         mxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/wVMRQYq8fkVBXtAwiW4f5YaI2apCsd/u8FPJMnqNok=;
        b=GmlXDf+lEC7teusTYs7I42Xq+kPKz0n6pm0OGONhxfByyrdfJglCIsKCU8/oReNOeV
         EiCJDl0efMUQXHV62DOr2V5lpu8LROQqiQlxLxMPYqpgyIDXqNDf48T3VMZgqoZz33la
         iIZRtFBO4M6ywHQ+ATlU2OcZOBcPgfP4f597FWNS76bDaZpmzHNe/1T4dlwDnxhUQnu1
         sVncbEI9+Z//FYdB1VIUe0xHiCbpBoOb4XjNPq0NOWzyyIpyvBReSFdsgoVZzN4SqJ8P
         FXKmjSKfk9NHVA6xXyCUKNNHlvxhV8rHnui4+iNBL9/+pgdNtG6PT5g1EKOgEM5oPHiy
         oNEw==
X-Gm-Message-State: ACrzQf3fe18CTwZWoGFF/ucoGUhCwcVhHck/O8aKZQCowexT6yAsypwt
        C9v/+ACc+SKkcenaSmvTekd2RhshW+5jLQ==
X-Google-Smtp-Source: AMsMyM7pZC81Z40/KXXnKnySA/OU1VrWMbZGP+jcb+vEqEgusRCPwNOcJ7MLaC40KgrjVd0Lz7eK2w==
X-Received: by 2002:a05:6a00:1889:b0:56c:3d4f:ae14 with SMTP id x9-20020a056a00188900b0056c3d4fae14mr45593009pfh.49.1667751748721;
        Sun, 06 Nov 2022 08:22:28 -0800 (PST)
Received: from Redminer.localdomain ([115.165.217.97])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902ce8700b0018691ce1696sm3330267plg.131.2022.11.06.08.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 08:22:28 -0800 (PST)
From:   Zhi-Jun You <hujy652@gmail.com>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Zhi-Jun You <hujy652@gmail.com>
Subject: [PATCH] wifi: ath10k: Use macro for seq_ctrl conversion
Date:   Mon,  7 Nov 2022 00:22:27 +0800
Message-Id: <20221106162227.1119-1-hujy652@gmail.com>
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

Use IEEE80211_SEQ_TO_SN macro to convert seq_ctrl to sn for better
readability.

Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
---
 drivers/net/wireless/ath/ath10k/htt_rx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index e76aab973320..3df52906b356 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -1379,7 +1379,7 @@ static void ath10k_process_rx(struct ath10k *ar, struct sk_buff *skb)
 		   ath10k_get_tid(hdr, tid, sizeof(tid)),
 		   is_multicast_ether_addr(ieee80211_get_DA(hdr)) ?
 							"mcast" : "ucast",
-		   (__le16_to_cpu(hdr->seq_ctrl) & IEEE80211_SCTL_SEQ) >> 4,
+		   IEEE80211_SEQ_TO_SN(__le16_to_cpu(hdr->seq_ctrl)),
 		   (status->encoding == RX_ENC_LEGACY) ? "legacy" : "",
 		   (status->encoding == RX_ENC_HT) ? "ht" : "",
 		   (status->encoding == RX_ENC_VHT) ? "vht" : "",
@@ -1902,7 +1902,7 @@ static bool ath10k_htt_rx_h_frag_pn_check(struct ath10k *ar,
 	last_pn = &peer->frag_tids_last_pn[tid];
 	new_pn.pn48 = ath10k_htt_rx_h_get_pn(ar, skb, offset, enctype);
 	frag_number = le16_to_cpu(hdr->seq_ctrl) & IEEE80211_SCTL_FRAG;
-	seq = (__le16_to_cpu(hdr->seq_ctrl) & IEEE80211_SCTL_SEQ) >> 4;
+	seq = IEEE80211_SEQ_TO_SN(__le16_to_cpu(hdr->seq_ctrl));
 
 	if (frag_number == 0) {
 		last_pn->pn48 = new_pn.pn48;
@@ -2824,7 +2824,7 @@ static bool ath10k_htt_rx_proc_rx_frag_ind_hl(struct ath10k_htt *htt,
 
 	hdr_space = ieee80211_hdrlen(hdr->frame_control);
 	sc = __le16_to_cpu(hdr->seq_ctrl);
-	seq = (sc & IEEE80211_SCTL_SEQ) >> 4;
+	seq = IEEE80211_SEQ_TO_SN(sc);
 	frag = sc & IEEE80211_SCTL_FRAG;
 
 	sec_index = MS(rx_desc_info, HTT_RX_DESC_HL_INFO_MCAST_BCAST) ?
-- 
2.34.1

