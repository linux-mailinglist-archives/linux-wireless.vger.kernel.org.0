Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E806CB46F
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2019 08:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388316AbfJDGWV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Oct 2019 02:22:21 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:44915 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388313AbfJDGWV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Oct 2019 02:22:21 -0400
Received: by mail-qt1-f202.google.com with SMTP id h10so5473456qtq.11
        for <linux-wireless@vger.kernel.org>; Thu, 03 Oct 2019 23:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0xv2gsEZKMIy9BZwSukLE/PzPmhsWw+mQ+8OOHaVoTo=;
        b=ijT2V7gB1tVcq0VrkvVzswZZ65RfrQN0t4UkkV9RzWajb4hoRa+UCKnpIm7RlrxkWM
         CjFt80iPUcEVdzVZYxt2AoKoq1odPpqe1zfFD3jTZy1OQ+ONp7N/oPKuQFL/gOS5NeCh
         xA5qCwJWxvyBk52KxvxdqkdTfWK/sz7quhI5L9c6qBfYaHwNTD4fvXh5CwLTGujoz2Ii
         yyLUKgomvDP+6PuyhohM8ZbAxHBg8Tx3jb2C1tSu/pMz3rJSEViNFaa1WBT8W2L42g/o
         a8t1x9zZ8u4EFHwvpS7+jLPsplKqf0SACB4yznakK5c6kbYCETkv0RrgNB4Doew339Y/
         cJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0xv2gsEZKMIy9BZwSukLE/PzPmhsWw+mQ+8OOHaVoTo=;
        b=GWrz8ZEqB4dNvb2HTzygoX+Q2dp1cRmuqYr4tN2+4y98WZAMpjCAXeH4U2EhMKM8Iv
         Ic/V6PATABfG26ug+ciCUzqXbmiI7QEFVe35/78G5EOjlo2Idcp/jUgECz7Jxeb4+kAn
         607JtDJceaUQUR4I7PppkNhCmdL6rFx7/uOV2yrc9oZI2BTL9ZZ+Uj7fy906gz7thUVy
         pPXnwAJbShFXPyrqqiNQWt8PlNbc1/kfO3l5qjkkDXZLHw+v8XYw7DwWdKhwUuV9J7I2
         V8y47uWxrVlHDrVvPnP09pYk7VcmiO2y7CQy4l4+LAhhlPwQh2EWCDyI+2N3FDJMBBRE
         C3/w==
X-Gm-Message-State: APjAAAV35EHetpyc638efyy+QwDsLkNy3jB8sJ5T2pKtWPSbQtROqNAU
        9MraO7/42Olibv6o/9xvYrDT0cJW
X-Google-Smtp-Source: APXvYqxQbotguQD+514N6gU3cwt59u3Q1YJw+87iinBS/+Y9U7qjedBWZNLanmJeTAOTatENPodCTAs6
X-Received: by 2002:a05:6214:4c2:: with SMTP id ck2mr12488148qvb.21.1570170139537;
 Thu, 03 Oct 2019 23:22:19 -0700 (PDT)
Date:   Thu,  3 Oct 2019 23:21:51 -0700
In-Reply-To: <20191004062151.131405-1-kyan@google.com>
Message-Id: <20191004062151.131405-3-kyan@google.com>
Mime-Version: 1.0
References: <20191004062151.131405-1-kyan@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH 2/2] ath10k: Enable Airtime-based Queue Limit (AQL)
From:   Kan Yan <kyan@google.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, toke@redhat.com,
        nbd@nbd.name, yiboz@codeaurora.org, Kan Yan <kyan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Calculate the estimated airtime pending in the txqs and apply AQL to
prevent excessive amounts of packets being queued in the firmware queue.

Change-Id: I4047ce0938f7b97440fb040b16b74f2e49aa3433
Signed-off-by: Kan Yan <kyan@google.com>
---
 drivers/net/wireless/ath/ath10k/mac.c  |  7 +++++--
 drivers/net/wireless/ath/ath10k/txrx.c | 12 +++++++++---
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 0606416dc971..37eb56c19f19 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -3983,6 +3983,9 @@ static bool ath10k_mac_tx_can_push(struct ieee80211_hw *hw,
 	struct ath10k_txq *artxq = (void *)txq->drv_priv;
 
 	/* No need to get locks */
+	if (!ieee80211_txq_airtime_check(hw, txq))
+		return false;
+
 	if (ar->htt.tx_q_state.mode == HTT_TX_MODE_SWITCH_PUSH)
 		return true;
 
@@ -4014,8 +4017,6 @@ static u16 ath10k_mac_update_airtime(struct ath10k *ar,
 	if (!txq || !txq->sta)
 		return airtime;
 
-	if (test_bit(WMI_SERVICE_REPORT_AIRTIME, ar->wmi.svc_map))
-		return airtime;
 
 	spin_lock_bh(&ar->data_lock);
 	arsta = (struct ath10k_sta *)txq->sta->drv_priv;
@@ -4038,6 +4039,8 @@ static u16 ath10k_mac_update_airtime(struct ath10k *ar,
 	}
 	spin_unlock_bh(&ar->data_lock);
 
+	ieee80211_sta_register_pending_airtime(txq->sta, txq->tid, airtime,
+					       false);
 	return airtime;
 }
 
diff --git a/drivers/net/wireless/ath/ath10k/txrx.c b/drivers/net/wireless/ath/ath10k/txrx.c
index 4102df016931..9266d3dd6adb 100644
--- a/drivers/net/wireless/ath/ath10k/txrx.c
+++ b/drivers/net/wireless/ath/ath10k/txrx.c
@@ -84,9 +84,15 @@ int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
 		wake_up(&htt->empty_tx_wq);
 	spin_unlock_bh(&htt->tx_lock);
 
-	if (txq && txq->sta && skb_cb->airtime_est)
-		ieee80211_sta_register_airtime(txq->sta, txq->tid,
-					       skb_cb->airtime_est, 0);
+	if (txq && txq->sta && skb_cb->airtime_est) {
+		if (!test_bit(WMI_SERVICE_REPORT_AIRTIME, ar->wmi.svc_map))
+			ieee80211_sta_register_airtime(txq->sta, txq->tid,
+						       skb_cb->airtime_est, 0);
+
+		ieee80211_sta_register_pending_airtime(txq->sta, txq->tid,
+						       skb_cb->airtime_est,
+						       true);
+	}
 
 	if (ar->bus_param.dev_type != ATH10K_DEV_TYPE_HL)
 		dma_unmap_single(dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
-- 
2.23.0.581.g78d2f28ef7-goog

