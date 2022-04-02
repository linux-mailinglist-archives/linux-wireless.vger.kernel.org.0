Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF844F0473
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Apr 2022 17:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238031AbiDBPi2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 Apr 2022 11:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237607AbiDBPiV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 Apr 2022 11:38:21 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C06144B45
        for <linux-wireless@vger.kernel.org>; Sat,  2 Apr 2022 08:36:28 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id bx37so3804334ljb.4
        for <linux-wireless@vger.kernel.org>; Sat, 02 Apr 2022 08:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GQBGpHLJBuI7vXHCkIC9Pl1G1Y1Yo8MMpmAHSdbTzag=;
        b=LxjCfQ3A25yPGUozfoldbZqZ6NzGyDPTEt418FEtiO3zSbYSLOxFlke/ZAHSj9XmmY
         54JoxWfnzkqyT84xVG/IK8ogKyboykuSSIXvoaHlU5epvLQTZkoevMr+BfOUq0rqlaJQ
         b1QSSZ8gAoIxO1VIPoaPya5+stOPX1pA+oKIe6DpkdMwPRaFrN9LggwqJa75hcCA0Bsw
         /TAJW80kyDNhnHJwFfa0rDYMb16y5VS30nObXAwikdmO0nIGZQRFv6LAU6iqBpKOpErW
         T/GiTXry+JHfXtMHMPwmqNZXWP2j/oZb4XbuoH1EypkU21aYjRzMriGUjIrtoKnwAqVx
         C/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GQBGpHLJBuI7vXHCkIC9Pl1G1Y1Yo8MMpmAHSdbTzag=;
        b=tyPdrg37BHSi7wwIlCgUJ50OssQcAGFFxgGnTK94sZYzH8V0R+1MlmoWqK8EumPHR9
         5FJDrh1HmzkBsoijNm4zYt3aKrd3+zGpUqRFrCptQw6V40tqZEObBjoAKwHEITpQTvVk
         O3bmNhKxnOqP+/5vfwvBbSptt8Lv8tam2g3ASB6tieTANxtwpBGnzP5H4+8UdhLt4VXH
         /oKelUXh3Kv6kkTuclfCkINhFivXAn2/L409kYTH+FhRX3xBpcXV3+CJAt6Axm3KxGWr
         /hG3yp6FOUntuBaQoxeLqcmhDjJJ0uz/GHze94yhlcU8vv3esIoOs+8tOnfalPgupdNz
         Rkhw==
X-Gm-Message-State: AOAM532YUaMMSQXBxJDf/62TuDL6Mng9V1msfS2bDh8JX3Mn0x1o6k4M
        2rnItSuCLePj6oaC6Ffji29ZZXTQrYA=
X-Google-Smtp-Source: ABdhPJw6DBWvZkIGMlMq2WlL3Q/AntGiLMZ8CRWAG6jBHhMCJnRHWrmQYBSXb59BcwFkxRJ2THe9fQ==
X-Received: by 2002:a2e:a901:0:b0:247:e3e7:7c26 with SMTP id j1-20020a2ea901000000b00247e3e77c26mr16974792ljq.395.1648913785163;
        Sat, 02 Apr 2022 08:36:25 -0700 (PDT)
Received: from rsa-laptop.rossosh.lan ([217.25.229.52])
        by smtp.gmail.com with ESMTPSA id z18-20020a2e3512000000b0024b12b5044csm52884ljz.89.2022.04.02.08.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 08:36:24 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH RFC 1/3] ath10k: improve tx status reporting
Date:   Sat,  2 Apr 2022 18:36:13 +0300
Message-Id: <20220402153615.9593-2-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220402153615.9593-1-ryazanov.s.a@gmail.com>
References: <20220402153615.9593-1-ryazanov.s.a@gmail.com>
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
Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
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
2.34.1

