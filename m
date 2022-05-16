Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B780527C50
	for <lists+linux-wireless@lfdr.de>; Mon, 16 May 2022 05:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239630AbiEPDZs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 15 May 2022 23:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239631AbiEPDZn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 15 May 2022 23:25:43 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA4D1098
        for <linux-wireless@vger.kernel.org>; Sun, 15 May 2022 20:25:40 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id i10so23524456lfg.13
        for <linux-wireless@vger.kernel.org>; Sun, 15 May 2022 20:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PbV+baTfSf6u1EDu9ZnZDC1YNNi38GdcisAOvMHD4Bw=;
        b=QjqTZxQwXXCe9KlmtuQOjaJbbV3YEk8MZRY48gyp7x0GHLEwRygQadvXbirjLzk+zj
         Sp8Jc53dQmw18KW02rUNzBVVgbzVRbTPjNWSQ5EzSuDw/S0zcz4PLpbB3gdAAKBcOi2I
         LXB/ynjKURRV6uQf9/q1fXPbEgdD8PF7RrQHhZsFNSW4EMx8vQcC6FPNY99DYQTNqWZv
         HI8R3e3c3Yv1LN/UCTibYdHm79gEmpEK6Xgb7XxvGhB+Kwt741oZDJswLDcKU0n/5dwY
         mr4Qhfu2rgsPJLntQZUB9vDSv508LyqDPSFvqzYJSgT2Kmihbx/1gq7RQB9h2tQZTyy8
         qv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PbV+baTfSf6u1EDu9ZnZDC1YNNi38GdcisAOvMHD4Bw=;
        b=BtdEEMZwj00KlfFDL4o/ugys9aBVsDwpnm0LdzndhhPOKg6eu7qlUUF8lg4lyzAVhW
         KDRsZpHMAros3WR2hepWMfDo73tn2RSXMYTFDmKF4tOkq5iUCpw2ff5Pa9El3FC8jE4k
         +14zyK4r+WLmtRKBW8bv6abL0yhmrEmqS8JZbP1iNp8pk7t6azu8gyBIUFf8GBRfKQCr
         68xqLGzpnR1Re0ltpzIvY/6Q3MdUbfoYqTYuDEWazAwXMhYwlS0WQTtRG1xDZoAmDOqI
         KUqKH/VK4MsjPxGmi7NvGAnInJIwnvYFxsICwcxPH+8sc0EROXOaSvJBaykPxveQoGc+
         YsCA==
X-Gm-Message-State: AOAM533QY1MiMlQFMahZ5ixpxaS3lmyMYHTTr2VxUwm6TJffqxNZ6Emb
        LZMGPbSO5IullT/9lIQPYi0=
X-Google-Smtp-Source: ABdhPJwU9s6rz8F3sSWiajSPUAgQAz/+1eMgZfds0TGo4wJnVLbd99mweI9PRVB8lYbNM+sP4Y8NKg==
X-Received: by 2002:a05:6512:2308:b0:473:da88:ea2b with SMTP id o8-20020a056512230800b00473da88ea2bmr11781591lfu.339.1652671538728;
        Sun, 15 May 2022 20:25:38 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by smtp.gmail.com with ESMTPSA id q18-20020a2e9152000000b0024f3d1daee5sm1337251ljg.109.2022.05.15.20.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 20:25:38 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Edward Matijevic <motolav@gmail.com>,
        John Crispin <john@phrozen.org>,
        =?UTF-8?q?Old=C5=99ich=20Jedli=C4=8Dka?= <oldium.pro@gmail.com>,
        Tom Psyborg <pozega.tomislav@gmail.com>,
        Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>,
        Zhijun You <hujy652@gmail.com>
Subject: [PATCH 2/4] ath10k: htt_tx: do not interpret Eth frames as WiFi
Date:   Mon, 16 May 2022 06:25:17 +0300
Message-Id: <20220516032519.29831-3-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516032519.29831-1-ryazanov.s.a@gmail.com>
References: <20220516032519.29831-1-ryazanov.s.a@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The xmit path for the Ethernet encapsulated frames become more or less
usable since d740d8fd2439 ("ath10k: unify tx mode and dispatch"). This
change reorganize the xmit path in a manageable way to properly support
various tx modes, but misses that the Ethernet encapsulated frame is a
special case. We do not have an IEEE 802.11 header at the begining of
them. But the HTT Tx handler still interprets first bytes of each frame
as an IEEE 802.11 Frame Control field.

Than this code was copied by e62ee5c381c5 ("ath10k: Add support for
htt_data_tx_desc_64 descriptor") and a2097d6444c3 ("ath10k: htt: High
latency TX support") to another handlers. In fact the issue in the high
latency (HL) handler was introduced by 83ac260151e7 ("ath10k: add mic
bytes for pmf management packet").

Ethernet encapsulated frame tx mode stay unused until 75d85fd9993c
("ath10k: introduce basic tdls functionality") started using it for TDLS
frames to avoid key selection issue in some firmwares.

Trying to interpret the begining of an Ethernet encapsulated frame as an
IEEE 802.11 header was not hurt us noticeably since we need to meet two
conditions: (1) xmit should be performed towards a TDLS peer, and (2)
the TDLS peer should have a specific OUI part of its MAC address. Looks
like that the rareness in TDLS communications of OUIs that can be
interpreted as an 802.11 management frame saves users from facing this
issue earlier.

Improve Ethernet tx mode support in the HTT Tx handler by avoiding
interpreting its first bytes as an IEEE 802.11 header. While at it, make
the ieee80211_hdr variable local to the code block that is guarded by
!is_eth check. In this way, we clarify in which cases a frame can be
interpreted as IEEE 802.11, and saves us from similar issues in the
future.

Credits: this change as part of xmit encapsulation offloading support
was originally made by QCA and then submitted for inclusion by John
Crispin [1]. But the whole work was not accepted due to the lack of a
part for 64-bits descriptors [2]. Zhijun You then pointed this out to me
in a reply to my initial RFC patch series. And I made this slightly
reworked version that covered all the HTT Tx handler variants.

1. https://lore.kernel.org/all/20191216092207.31032-1-john@phrozen.org/
2. https://patchwork.kernel.org/project/linux-wireless/patch/20191216092207.31032-1-john@phrozen.org/

Reported-by: Zhijun You <hujy652@gmail.com>
Signed-off-by: Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---

Changes since RFC:
 * new patch

 drivers/net/wireless/ath/ath10k/htt_tx.c | 61 ++++++++++++++----------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
index 9842a4b2f78f..a19b0795c86d 100644
--- a/drivers/net/wireless/ath/ath10k/htt_tx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
@@ -1275,7 +1275,6 @@ static int ath10k_htt_tx_hl(struct ath10k_htt *htt, enum ath10k_hw_txrx_mode txm
 	struct ath10k *ar = htt->ar;
 	int res, data_len;
 	struct htt_cmd_hdr *cmd_hdr;
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)msdu->data;
 	struct htt_data_tx_desc *tx_desc;
 	struct ath10k_skb_cb *skb_cb = ATH10K_SKB_CB(msdu);
 	struct sk_buff *tmp_skb;
@@ -1286,11 +1285,15 @@ static int ath10k_htt_tx_hl(struct ath10k_htt *htt, enum ath10k_hw_txrx_mode txm
 	u16 flags1 = 0;
 	u16 msdu_id = 0;
 
-	if ((ieee80211_is_action(hdr->frame_control) ||
-	     ieee80211_is_deauth(hdr->frame_control) ||
-	     ieee80211_is_disassoc(hdr->frame_control)) &&
-	     ieee80211_has_protected(hdr->frame_control)) {
-		skb_put(msdu, IEEE80211_CCMP_MIC_LEN);
+	if (!is_eth) {
+		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)msdu->data;
+
+		if ((ieee80211_is_action(hdr->frame_control) ||
+		     ieee80211_is_deauth(hdr->frame_control) ||
+		     ieee80211_is_disassoc(hdr->frame_control)) &&
+		     ieee80211_has_protected(hdr->frame_control)) {
+			skb_put(msdu, IEEE80211_CCMP_MIC_LEN);
+		}
 	}
 
 	data_len = msdu->len;
@@ -1387,7 +1390,6 @@ static int ath10k_htt_tx_32(struct ath10k_htt *htt,
 {
 	struct ath10k *ar = htt->ar;
 	struct device *dev = ar->dev;
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)msdu->data;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(msdu);
 	struct ath10k_skb_cb *skb_cb = ATH10K_SKB_CB(msdu);
 	struct ath10k_hif_sg_item sg_items[2];
@@ -1419,15 +1421,19 @@ static int ath10k_htt_tx_32(struct ath10k_htt *htt,
 	txbuf_paddr = htt->txbuf.paddr +
 		      (sizeof(struct ath10k_htt_txbuf_32) * msdu_id);
 
-	if ((ieee80211_is_action(hdr->frame_control) ||
-	     ieee80211_is_deauth(hdr->frame_control) ||
-	     ieee80211_is_disassoc(hdr->frame_control)) &&
-	     ieee80211_has_protected(hdr->frame_control)) {
-		skb_put(msdu, IEEE80211_CCMP_MIC_LEN);
-	} else if (!(skb_cb->flags & ATH10K_SKB_F_NO_HWCRYPT) &&
-		   txmode == ATH10K_HW_TXRX_RAW &&
-		   ieee80211_has_protected(hdr->frame_control)) {
-		skb_put(msdu, IEEE80211_CCMP_MIC_LEN);
+	if (!is_eth) {
+		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)msdu->data;
+
+		if ((ieee80211_is_action(hdr->frame_control) ||
+		     ieee80211_is_deauth(hdr->frame_control) ||
+		     ieee80211_is_disassoc(hdr->frame_control)) &&
+		     ieee80211_has_protected(hdr->frame_control)) {
+			skb_put(msdu, IEEE80211_CCMP_MIC_LEN);
+		} else if (!(skb_cb->flags & ATH10K_SKB_F_NO_HWCRYPT) &&
+			   txmode == ATH10K_HW_TXRX_RAW &&
+			   ieee80211_has_protected(hdr->frame_control)) {
+			skb_put(msdu, IEEE80211_CCMP_MIC_LEN);
+		}
 	}
 
 	skb_cb->paddr = dma_map_single(dev, msdu->data, msdu->len,
@@ -1589,7 +1595,6 @@ static int ath10k_htt_tx_64(struct ath10k_htt *htt,
 {
 	struct ath10k *ar = htt->ar;
 	struct device *dev = ar->dev;
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)msdu->data;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(msdu);
 	struct ath10k_skb_cb *skb_cb = ATH10K_SKB_CB(msdu);
 	struct ath10k_hif_sg_item sg_items[2];
@@ -1621,15 +1626,19 @@ static int ath10k_htt_tx_64(struct ath10k_htt *htt,
 	txbuf_paddr = htt->txbuf.paddr +
 		      (sizeof(struct ath10k_htt_txbuf_64) * msdu_id);
 
-	if ((ieee80211_is_action(hdr->frame_control) ||
-	     ieee80211_is_deauth(hdr->frame_control) ||
-	     ieee80211_is_disassoc(hdr->frame_control)) &&
-	     ieee80211_has_protected(hdr->frame_control)) {
-		skb_put(msdu, IEEE80211_CCMP_MIC_LEN);
-	} else if (!(skb_cb->flags & ATH10K_SKB_F_NO_HWCRYPT) &&
-		   txmode == ATH10K_HW_TXRX_RAW &&
-		   ieee80211_has_protected(hdr->frame_control)) {
-		skb_put(msdu, IEEE80211_CCMP_MIC_LEN);
+	if (!is_eth) {
+		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)msdu->data;
+
+		if ((ieee80211_is_action(hdr->frame_control) ||
+		     ieee80211_is_deauth(hdr->frame_control) ||
+		     ieee80211_is_disassoc(hdr->frame_control)) &&
+		     ieee80211_has_protected(hdr->frame_control)) {
+			skb_put(msdu, IEEE80211_CCMP_MIC_LEN);
+		} else if (!(skb_cb->flags & ATH10K_SKB_F_NO_HWCRYPT) &&
+			   txmode == ATH10K_HW_TXRX_RAW &&
+			   ieee80211_has_protected(hdr->frame_control)) {
+			skb_put(msdu, IEEE80211_CCMP_MIC_LEN);
+		}
 	}
 
 	skb_cb->paddr = dma_map_single(dev, msdu->data, msdu->len,
-- 
2.35.1

