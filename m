Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A280642CAA
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Dec 2022 17:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiLEQTC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Dec 2022 11:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbiLEQSz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Dec 2022 11:18:55 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C2B1D32E
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 08:18:53 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so15304144pje.5
        for <linux-wireless@vger.kernel.org>; Mon, 05 Dec 2022 08:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ytU64R1G/iMmVuMBEsmSCZI0O1tcdDULe4aARBScRq4=;
        b=D++8Lklr5KRz/aYuujJ0eIGqvt1JAlTZaAQE+eEj7W5JzQ8YNezlcnL9CcWHQc7mDU
         UHMldWGhshNDNIwdGb0UC8wLoIuzetV9hlVJ0F7aMyrJIFGofyx9IYFv8kcfn6bEh5XV
         1fREcr9y0f+bghItuas0XEQmGKiWaVOaC5dMYt19+iWa4W/xGAYsUIbID7NEC692hV/s
         h8iV+3LqfvOf1e/9R2Jt4Zzuxuva6mFpCuUpo+aDhQ25iDG22/ljSrkygFsYpg2+0000
         G6VzlW8tdUjEVkvXGJY8ZdCAhVgdlv8DLrmnV9MxALUId8mWaChaFOEFtvzs72STWGTk
         w4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ytU64R1G/iMmVuMBEsmSCZI0O1tcdDULe4aARBScRq4=;
        b=jtNqMrM3oimcS09P6FKbT/vlO/T7roTrFpgIrN+WDR2pSqqgH0MxetZVaPJCOfhF+z
         AXxO+hBRJBR4Zr+wMSlX1TC9z9YUXkp1Pj+ov4WL0vAmt0JwBpluqxydLWcZ+U9b7ios
         XlZBn6SbS/zS3PHmXcZgrBI25PF3tNwuN5zHN76Y8nDsLNWX8forjnt5rq5i1+Ulyh10
         HzbvFwj+aNrg6yNU5WNwSU3ODuWgdD1myCcmmhtQsHe7lNSjYciTxIJ53To23JFn4n+C
         Mv9yik8oi8YOcDvFaLKD2CzvMBYFZKf2naLY2F0WIkz1V4+EvKRDUfSwhZquv7fct42C
         22LQ==
X-Gm-Message-State: ANoB5pndGcvGrZIDQE1YvgKvl/1wa6pZaG2/RASgCIwlZ7sl67GY665F
        wm+crbqWENR8fxHYKPa0dUnt/WllocbvRg==
X-Google-Smtp-Source: AA0mqf4ko+6gABQyRhmb2CvqNKJcE4zmhk0IEi/ZO91inzPA6jlrXxlxJgxHEnK/VrHTpAujGs2Llg==
X-Received: by 2002:a17:902:f641:b0:181:b25e:e7bc with SMTP id m1-20020a170902f64100b00181b25ee7bcmr66569522plg.46.1670257132170;
        Mon, 05 Dec 2022 08:18:52 -0800 (PST)
Received: from localhost.localdomain ([115.165.217.97])
        by smtp.googlemail.com with ESMTPSA id u11-20020a170902e80b00b0018996404dd5sm10835379plg.109.2022.12.05.08.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 08:18:51 -0800 (PST)
From:   Zhi-Jun You <hujy652@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     ath10k@lists.infradead.org, Zhi-Jun You <hujy652@gmail.com>
Subject: [RFC] wifi: ath10k: Implement duplicate detection for non-offloaded PCIe
Date:   Tue,  6 Dec 2022 00:18:51 +0800
Message-Id: <20221205161851.780-1-hujy652@gmail.com>
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

Chips like QCA9984, IPQ4019 doesn't do duplicate detection in firmware.
Implement it in driver so it can skip a check in mac80211.

Check only the first skb since all the skbs in amsdu share the same
header.

Tested-on: QCA9984 10.4-3.9.0.2-00159
Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
---

I am not sure what's the formal name for chips like QCA9984 so I will
call it non-offloaded PCIe for now.
---
 drivers/net/wireless/ath/ath10k/core.h   |  1 +
 drivers/net/wireless/ath/ath10k/htt_rx.c | 51 ++++++++++++++++++++++++
 drivers/net/wireless/ath/ath10k/txrx.c   |  3 ++
 3 files changed, 55 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index f5de8ce8fb45..6b4f5208f32f 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -436,6 +436,7 @@ struct ath10k_peer {
 		enum htt_security_types sec_type;
 		int pn_len;
 	} rx_pn[ATH10K_HTT_TXRX_PEER_SECURITY_MAX];
+	u16 last_rx_seq_ctrl[IEEE80211_NUM_TIDS + 1];
 };
 
 struct ath10k_txq {
diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index 438b0caaceb7..e241eab4cce1 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -1344,6 +1344,56 @@ static char *ath10k_get_tid(struct ieee80211_hdr *hdr, char *out, size_t size)
 	return out;
 }
 
+static void ath10k_htt_rx_h_check_dup(struct ath10k *ar,
+				      struct sk_buff_head *amsdu,
+				      struct ieee80211_rx_status *status)
+{
+	struct ath10k_hw_params *hw = &ar->hw_params;
+	struct sk_buff *first;
+	struct ath10k_peer *peer;
+	struct ieee80211_hdr *hdr;
+	struct htt_rx_desc *rxd;
+	struct rx_mpdu_start *rxd_mpdu_start;
+	u16 peer_id;
+	u8 tid;
+
+	if (skb_queue_empty(amsdu))
+		return;
+
+	first = skb_peek(amsdu);
+	rxd = HTT_RX_BUF_TO_RX_DESC(hw,
+				    (void *)first->data - hw->rx_desc_ops->rx_desc_size);
+
+	rxd_mpdu_start = ath10k_htt_rx_desc_get_mpdu_start(hw, rxd);
+	peer_id = MS(__le32_to_cpu(rxd_mpdu_start->info0),
+		     RX_MPDU_START_INFO0_PEER_IDX);
+
+	spin_lock_bh(&ar->data_lock);
+
+	peer = ath10k_peer_find_by_id(ar, peer_id);
+	if (!peer)
+		goto out;
+
+	hdr = (void *)ath10k_htt_rx_desc_get_rx_hdr_status(hw, rxd);
+	if (ieee80211_is_data_qos(hdr->frame_control))
+		tid = ieee80211_get_tid(hdr);
+	else
+		tid = ATH10K_TXRX_NON_QOS_TID;
+
+	if (ieee80211_has_retry(hdr->frame_control) &&
+	    peer->last_rx_seq_ctrl[tid] == __le16_to_cpu(hdr->seq_ctrl)) {
+		__skb_queue_purge(amsdu);
+		goto out;
+	}
+
+	peer->last_rx_seq_ctrl[tid] = __le16_to_cpu(hdr->seq_ctrl);
+
+	status->flag |= RX_FLAG_DUP_VALIDATED;
+
+out:
+	spin_unlock_bh(&ar->data_lock);
+}
+
 static void ath10k_htt_rx_h_queue_msdu(struct ath10k *ar,
 				       struct ieee80211_rx_status *rx_status,
 				       struct sk_buff *skb)
@@ -2356,6 +2406,7 @@ static int ath10k_htt_rx_handle_amsdu(struct ath10k_htt *htt)
 		ath10k_htt_rx_h_unchain(ar, &amsdu, &drop_cnt, &unchain_cnt);
 
 	ath10k_htt_rx_h_filter(ar, &amsdu, rx_status, &drop_cnt_filter);
+	ath10k_htt_rx_h_check_dup(ar, &amsdu, rx_status);
 	ath10k_htt_rx_h_mpdu(ar, &amsdu, rx_status, true, first_hdr, &err, 0,
 			     false);
 	msdus_to_queue = skb_queue_len(&amsdu);
diff --git a/drivers/net/wireless/ath/ath10k/txrx.c b/drivers/net/wireless/ath/ath10k/txrx.c
index da3bc35e41aa..a8b8186537f4 100644
--- a/drivers/net/wireless/ath/ath10k/txrx.c
+++ b/drivers/net/wireless/ath/ath10k/txrx.c
@@ -219,6 +219,7 @@ void ath10k_peer_map_event(struct ath10k_htt *htt,
 {
 	struct ath10k *ar = htt->ar;
 	struct ath10k_peer *peer;
+	int i;
 
 	if (ev->peer_id >= ATH10K_MAX_NUM_PEER_IDS) {
 		ath10k_warn(ar,
@@ -237,6 +238,8 @@ void ath10k_peer_map_event(struct ath10k_htt *htt,
 		peer->vdev_id = ev->vdev_id;
 		ether_addr_copy(peer->addr, ev->addr);
 		list_add(&peer->list, &ar->peers);
+		for (i = 0; i <= IEEE80211_NUM_TIDS; i++)
+			peer->last_rx_sec_ctrl[i] = USHRT_MAX;
 		wake_up(&ar->peer_mapping_wq);
 	}
 
-- 
2.34.1

