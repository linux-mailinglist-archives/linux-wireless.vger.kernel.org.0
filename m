Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21CE527C4F
	for <lists+linux-wireless@lfdr.de>; Mon, 16 May 2022 05:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239642AbiEPDZq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 15 May 2022 23:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239630AbiEPDZl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 15 May 2022 23:25:41 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EDA1C925
        for <linux-wireless@vger.kernel.org>; Sun, 15 May 2022 20:25:39 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id l19so16563326ljb.7
        for <linux-wireless@vger.kernel.org>; Sun, 15 May 2022 20:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3xta7mXhm2Fn94nk/9joq4nWctV2Qx65e2rWuESLvCI=;
        b=Hioqv9TGU/FbI35sE3TREY8e3/vmNZPGONyFHjiAwcc9MDOvUNHPD53QhsY149u620
         Vevyl1GrZSRsjOrDS9hggWqA7R/8Hsht1AGFl0kqZhdN43sML7EG0G2kgzFXOhGDp8S1
         ROaX1Nacry7w/o0XmxHtgGPgdVPDCvhxWwfg04FUCJuSA1M6DR91zYq2LrrSJLJpbuKv
         XjKSkDLL32I9GYe25ZdEh8+tUT7zEiRFi6SMcXZ++DBT9aW5c99BJUvFc0Pen4tudogj
         0a4sHa5IcbbnspNdJloR3QO1OJqMmkv0JX3n2+cxZHAVKf4WFXbWNDH0u6sDp116Ljv1
         xr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3xta7mXhm2Fn94nk/9joq4nWctV2Qx65e2rWuESLvCI=;
        b=vns+5LSXF26OVyuHe8koDSjO8DG2Qo5AUmZxW3xEi8tsem7ZnMoHpZNV+jtVkLAnVY
         51bpLz7Db6mJFSyjJEMeUkSP+q8jk8XVHWzkLKNluxGxz+NRduW0lNjTGHbcjvcqU3pG
         WRBajccOuhd/JeVH8g7zLtZtjCxytBOB2bnJvNjUS1sMrG5N77afvA7+dP5Zfs7dFlDE
         5MITtazZxZnN6SH/6tG5OLtiLVvpJm/JaRl26c3Cx0CZzt3cAmNUOOMFAxZ7qNhYRCSL
         VmlV220nOVC04C4897hpRNSruOcAcHCI7sXcCRPYP8L/e0/y/XIkhjux2wCNFOIBym3N
         Bdeg==
X-Gm-Message-State: AOAM533PJtSvtEMXt9+Hz085yZcYU08vIJrbtR7YclB4rT19hqDe+wC2
        XQOTez5Ri3zPkh1u7DS8ovY=
X-Google-Smtp-Source: ABdhPJwG21mD1Uu47jm2MyFyRUP+b0rBLtkvdr0bu9qRGPrQoG4/kzUA6vA7jP5N0Yy80KvBI1zgrg==
X-Received: by 2002:a2e:9e03:0:b0:24f:153c:c479 with SMTP id e3-20020a2e9e03000000b0024f153cc479mr10429362ljk.13.1652671537745;
        Sun, 15 May 2022 20:25:37 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by smtp.gmail.com with ESMTPSA id q18-20020a2e9152000000b0024f3d1daee5sm1337251ljg.109.2022.05.15.20.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 20:25:37 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Edward Matijevic <motolav@gmail.com>,
        John Crispin <john@phrozen.org>,
        =?UTF-8?q?Old=C5=99ich=20Jedli=C4=8Dka?= <oldium.pro@gmail.com>,
        Tom Psyborg <pozega.tomislav@gmail.com>,
        Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>,
        Zhijun You <hujy652@gmail.com>
Subject: [PATCH 1/4] ath10k: improve tx status reporting
Date:   Mon, 16 May 2022 06:25:16 +0300
Message-Id: <20220516032519.29831-2-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516032519.29831-1-ryazanov.s.a@gmail.com>
References: <20220516032519.29831-1-ryazanov.s.a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

We use ieee80211_tx_status() to report each completed tx frame.
Internally, this function calls sta_info_get_by_addrs(), what has a
couple of drawbacks:
1. additional station lookup causes a performance degradation;
2. mac80211 can not properly account Ethernet encapsulated frames due
   to the inability to properly determine the destination (station) MAC
   address since ieee80211_tx_status() assumes the frame has a 802.11
   header.

The latter is especially destructive if we want to use hardware frames
encapsulation.

To fix both of these issues, replace ieee80211_tx_status() with
ieee80211_tx_status_ext() call and feed it station pointer from the tx
queue associated with the transmitted frame.

Tested-on: QCA9888 hw 2.0 10.4-3.9.0.2-00131
Tested-on: QCA6174 hw 3.2 PCI WLAN.RM.4.4.1-00157-QCARMSWPZ-1
Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Tested-by: Oldřich Jedlička <oldium.pro@gmail.com> # TP-Link Archer C7 v4 & v5 (QCA9563 + QCA9880)
Tested-by: Edward Matijevic <motolav@gmail.com> # TP-Link Archer C2600 (IPQ8064 + QCA9980 10.4.1.00030-1)
Tested-by: Edward Matijevic <motolav@gmail.com> # QCA9377 PCI in Sta mode
Tested-by: Zhijun You <hujy652@gmail.com> # NETGEAR R7800 (QCA9984 10.4-3.9.0.2-00159)
---

Changes since RFC:
 * new Tested-on and Tested-by tags

 drivers/net/wireless/ath/ath10k/txrx.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/txrx.c b/drivers/net/wireless/ath/ath10k/txrx.c
index 10123974c3da..72540434c75b 100644
--- a/drivers/net/wireless/ath/ath10k/txrx.c
+++ b/drivers/net/wireless/ath/ath10k/txrx.c
@@ -43,6 +43,7 @@ static void ath10k_report_offchan_tx(struct ath10k *ar, struct sk_buff *skb)
 int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
 			 const struct htt_tx_done *tx_done)
 {
+	struct ieee80211_tx_status status;
 	struct ath10k *ar = htt->ar;
 	struct device *dev = ar->dev;
 	struct ieee80211_tx_info *info;
@@ -128,7 +129,16 @@ int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
 		info->status.flags |= IEEE80211_TX_STATUS_ACK_SIGNAL_VALID;
 	}
 
-	ieee80211_tx_status(htt->ar->hw, msdu);
+	memset(&status, 0, sizeof(status));
+	status.skb = msdu;
+	status.info = info;
+
+	rcu_read_lock();
+	if (txq && txq->sta)
+		status.sta = txq->sta;
+	ieee80211_tx_status_ext(htt->ar->hw, &status);
+	rcu_read_unlock();
+
 	/* we do not own the msdu anymore */
 
 	return 0;
-- 
2.35.1

