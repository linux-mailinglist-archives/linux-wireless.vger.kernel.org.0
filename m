Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D9243178C
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 13:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhJRLjX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 07:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhJRLjX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 07:39:23 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB91C06161C
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 04:37:11 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l38-20020a05600c1d2600b0030d80c3667aso8209385wms.5
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 04:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=UAK4f4hejO/RUV7REAm7E11Qpe5FUY3MVwwYtDhcDDg=;
        b=GUwiiueJaGkc5eJRIwvqobtZsH/E1g9HL5p0p89Lm8ikOOk/w9aSP46wWly1s8LoAz
         ziKhcyq/mv9YNNv4nFSIQMSnMppaNtJZj+km8fsXodm/UHsvrMFtSy9rs6ptfUw2vwyT
         SdLXwLeU9VnhXDDkKRVUnxgcp2BeiLPlg9PvqWXW9L/7i39SCGrswtn+3gdXKcds6uj/
         MnCw439QJstU1NUlQCB0733iGsbDzCQ67Uh9wMlmb6AYF8yxDpKFa/t0Eeh85uUH4/Xr
         lFAofJtw009k43Cg3ErhglehpMB1jUHXa9YowSBvldpu8nS43lO/Ab+ERbSCJy4rkZCO
         DlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UAK4f4hejO/RUV7REAm7E11Qpe5FUY3MVwwYtDhcDDg=;
        b=IDKSaTvFq9cneimZVxW+6mHFvCfDex/j5KDk0t68w5iIIlMqcwph6O46xIS9bd4/Zh
         pMKIrLnlfSjPDcOCI+EqG8moBfPSmHXyPiWY2j5xH2DfVV+wvphHN2yUR60q39Z7bQ+W
         VYW4HKQ67+6fXZlJxhMr8NZa4PSsDZh7W3vtrx5dV+2ojUkoHJzCfIrktPaHQvkuMgL5
         7oWuBEOxSxQIi2T5yDc1twV44qVZSQpb4/ts5ulilp6k77Z38EAuOGQHOtpsXL4L+ixe
         EvA5qCxUrcT1sqprgBQSy0RY11MGkfGbE0cLKc0e3wpGQN5SvrC9r5Vnekb61VvQLm9P
         6WnA==
X-Gm-Message-State: AOAM533ZClFiR48pb+pRrYzwOlujWQQDLV+VJS2DZ191oMau1EKL/myF
        JwT2hpFY/6kk8EbpwSnjiF+ulA==
X-Google-Smtp-Source: ABdhPJxs4QBhrAkEJnRQNe0HuTyBfXwc1KQ5nXYTqiQwnXOUOqnbhrYM9Juys8Nd+2u5DoB2b2VPpg==
X-Received: by 2002:a1c:a558:: with SMTP id o85mr30218959wme.110.1634557030310;
        Mon, 18 Oct 2021 04:37:10 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:82c:5f0:9df5:c752:530b:345b])
        by smtp.gmail.com with ESMTPSA id r9sm11957609wrn.95.2021.10.18.04.37.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Oct 2021 04:37:09 -0700 (PDT)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH] wcn36xx: Add chained transfer support for AMSDU
Date:   Mon, 18 Oct 2021 13:48:25 +0200
Message-Id: <1634557705-11120-1-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

WCNSS RX DMA transfer support is limited to 3872 bytes, which is
enough for simple MPDUs (single MSDU), but not enough for cases
with A-MSDU (depending on max AMSDU size or max MPDU size).

In that case the MPDU is spread ove multiple transfers, with the
first transfer containing the MPDU header and (at least) the first
A-MSDU subframe and additional transfer(s) containing the following
A-MSDUs. This can be handled with a series of flags to tagging the
first and last A-MSDU transfers.

In that case we have to bufferize and re-linearize the A-MSDU buffers
into a proper MPDU skb before forwarding to mac80211 (in the same way
as it is done in ath10k).

This change also includes sanity check of the buffer descriptor to
prevent skb overflow.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c    |  3 ++
 drivers/net/wireless/ath/wcn36xx/smd.c     |  3 +-
 drivers/net/wireless/ath/wcn36xx/txrx.c    | 83 ++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h |  4 +-
 4 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index b5aa20e..96bd99a 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1501,6 +1501,7 @@ static int wcn36xx_probe(struct platform_device *pdev)
 	mutex_init(&wcn->conf_mutex);
 	mutex_init(&wcn->hal_mutex);
 	mutex_init(&wcn->scan_lock);
+	__skb_queue_head_init(&wcn->amsdu);
 
 	wcn->hal_buf = devm_kmalloc(wcn->dev, WCN36XX_HAL_BUF_SIZE, GFP_KERNEL);
 	if (!wcn->hal_buf) {
@@ -1578,6 +1579,8 @@ static int wcn36xx_remove(struct platform_device *pdev)
 	iounmap(wcn->dxe_base);
 	iounmap(wcn->ccu_base);
 
+	__skb_queue_purge(&wcn->amsdu);
+
 	mutex_destroy(&wcn->hal_mutex);
 	ieee80211_free_hw(hw);
 
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 3979171..3cecc8f 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -266,7 +266,8 @@ static void wcn36xx_smd_set_sta_ht_params(struct ieee80211_sta *sta,
 
 		sta_params->max_ampdu_size = sta->ht_cap.ampdu_factor;
 		sta_params->max_ampdu_density = sta->ht_cap.ampdu_density;
-		sta_params->max_amsdu_size = is_cap_supported(caps,
+		/* max_amsdu_size: 1 : 3839 bytes, 0 : 7935 bytes (max) */
+		sta_params->max_amsdu_size = !is_cap_supported(caps,
 			IEEE80211_HT_CAP_MAX_AMSDU);
 		sta_params->sgi_20Mhz = is_cap_supported(caps,
 			IEEE80211_HT_CAP_SGI_20);
diff --git a/drivers/net/wireless/ath/wcn36xx/txrx.c b/drivers/net/wireless/ath/wcn36xx/txrx.c
index a3ef497..1edc703 100644
--- a/drivers/net/wireless/ath/wcn36xx/txrx.c
+++ b/drivers/net/wireless/ath/wcn36xx/txrx.c
@@ -231,6 +231,41 @@ static const struct wcn36xx_rate wcn36xx_rate_table[] = {
 	{ 4333, 9, RX_ENC_VHT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_80 },
 };
 
+static struct sk_buff *wcn36xx_unchain_msdu(struct sk_buff_head *amsdu)
+{
+	struct sk_buff *skb, *first;
+	int total_len = 0;
+	int space;
+
+	first = __skb_dequeue(amsdu);
+
+	skb_queue_walk(amsdu, skb)
+		total_len += skb->len;
+
+	space = total_len - skb_tailroom(first);
+	if (space > 0 && pskb_expand_head(first, 0, space, GFP_ATOMIC) < 0) {
+		__skb_queue_head(amsdu, first);
+		return NULL;
+	}
+
+	/* Walk list again, copying contents into msdu_head */
+	while ((skb = __skb_dequeue(amsdu))) {
+		skb_copy_from_linear_data(skb, skb_put(first, skb->len),
+					  skb->len);
+		dev_kfree_skb_irq(skb);
+	}
+
+	return first;
+}
+
+static void __skb_queue_purge_irq(struct sk_buff_head *list)
+{
+	struct sk_buff *skb;
+
+	while ((skb = __skb_dequeue(list)) != NULL)
+		dev_kfree_skb_irq(skb);
+}
+
 int wcn36xx_rx_skb(struct wcn36xx *wcn, struct sk_buff *skb)
 {
 	struct ieee80211_rx_status status;
@@ -252,6 +287,26 @@ int wcn36xx_rx_skb(struct wcn36xx *wcn, struct sk_buff *skb)
 			 "BD   <<< ", (char *)bd,
 			 sizeof(struct wcn36xx_rx_bd));
 
+	if (bd->pdu.mpdu_data_off <= bd->pdu.mpdu_header_off ||
+	    bd->pdu.mpdu_len < bd->pdu.mpdu_header_len)
+		goto drop;
+
+	if (bd->asf && !bd->esf) { /* chained A-MSDU chunks */
+		/* Sanity check */
+		if (bd->pdu.mpdu_data_off + bd->pdu.mpdu_len > WCN36XX_PKT_SIZE)
+			goto drop;
+
+		skb_put(skb, bd->pdu.mpdu_data_off + bd->pdu.mpdu_len);
+		skb_pull(skb, bd->pdu.mpdu_data_off);
+
+		/* Only set status for first chained BD (with mac header) */
+		goto done;
+	}
+
+	if (bd->pdu.mpdu_header_off < sizeof(*bd) ||
+	    bd->pdu.mpdu_header_off + bd->pdu.mpdu_len > WCN36XX_PKT_SIZE)
+		goto drop;
+
 	skb_put(skb, bd->pdu.mpdu_header_off + bd->pdu.mpdu_len);
 	skb_pull(skb, bd->pdu.mpdu_header_off);
 
@@ -328,9 +383,37 @@ int wcn36xx_rx_skb(struct wcn36xx *wcn, struct sk_buff *skb)
 				 (char *)skb->data, skb->len);
 	}
 
+done:
+	/*  Chained AMSDU ? slow path */
+	if (unlikely(bd->asf && !(bd->lsf && bd->esf))) {
+		if (bd->esf && !skb_queue_empty(&wcn->amsdu)) {
+			wcn36xx_err("Discarding non complete chain");
+			__skb_queue_purge_irq(&wcn->amsdu);
+		}
+
+		__skb_queue_tail(&wcn->amsdu, skb);
+
+		if (!bd->lsf)
+			return 0; /* Not the last AMSDU, wait for more */
+
+		skb = wcn36xx_unchain_msdu(&wcn->amsdu);
+		if (!skb)
+			goto drop;
+	}
+
 	ieee80211_rx_irqsafe(wcn->hw, skb);
 
 	return 0;
+
+drop: /* drop everything */
+	wcn36xx_err("Drop frame! skb:%p len:%u hoff:%u doff:%u asf=%u esf=%u lsf=%u\n",
+		    skb, bd->pdu.mpdu_len, bd->pdu.mpdu_header_off,
+		    bd->pdu.mpdu_data_off, bd->asf, bd->esf, bd->lsf);
+
+	dev_kfree_skb_irq(skb);
+	__skb_queue_purge_irq(&wcn->amsdu);
+
+	return -EINVAL;
 }
 
 static void wcn36xx_set_tx_pdu(struct wcn36xx_tx_bd *bd,
diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
index add6e52..ae63bc6 100644
--- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
+++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
@@ -269,6 +269,9 @@ struct wcn36xx {
 	struct sk_buff		*tx_ack_skb;
 	struct timer_list	tx_ack_timer;
 
+	/* For A-MSDU re-aggregation */
+	struct sk_buff_head amsdu;
+
 	/* RF module */
 	unsigned		rf_id;
 
@@ -276,7 +279,6 @@ struct wcn36xx {
 	/* Debug file system entry */
 	struct wcn36xx_dfs_entry    dfs;
 #endif /* CONFIG_WCN36XX_DEBUGFS */
-
 };
 
 static inline bool wcn36xx_is_fw_version(struct wcn36xx *wcn,
-- 
2.7.4

