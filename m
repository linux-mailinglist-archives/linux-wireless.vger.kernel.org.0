Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2D87E8140
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Nov 2023 19:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbjKJS1G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Nov 2023 13:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345443AbjKJSZm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Nov 2023 13:25:42 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAE07AAD
        for <linux-wireless@vger.kernel.org>; Thu,  9 Nov 2023 22:42:04 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6bcbfecf314so68671b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 09 Nov 2023 22:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yonsei.ac.kr; s=google; t=1699598524; x=1700203324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A6Im3Bkt8oa5qBiKgWo5efLNfcI5scCeadu/xZg0l9g=;
        b=jaZ7wM7NTFaios+2O2puDcxQ0XriyzbGw+iWAO1PPJxGm1rAWjctTXAJ7Cb2M7poNr
         gn3+W5HFws5xWis1rbxZG0k43g0qFUD7fQkbOXqPaip6EuwCql4IRODxTde5DKddjDPn
         D+8Dnu6tFBlL8ioeC8QJmPWMNNfjtU3jnBVM9k75hAI7WI9SmT0NAuB7+3KQSNCm8RRM
         XugmEbjN+K6mPU0IRh614Lzs7iBaQtuSAl2GRhTcuBPUpZUHqTMD/VV5O5ZlY8yDzttk
         Ooh9xzLJfH3/d6psIiKHwdWbn3M1TFxeNFZ2Hfx4fMgwxUnifT8AwY+VTCbpWxwDxQPd
         FAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699598524; x=1700203324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A6Im3Bkt8oa5qBiKgWo5efLNfcI5scCeadu/xZg0l9g=;
        b=r9Co5UixVpr7ejuXOzdqyDY1QG+ktsq/ZUUX5VRQyB6S71uv8A734B7ToZksSpcuOk
         ZL32daGXhX0EhlUU4ZHk78zaz56O96MeDHO1ieHJic4m+lyfVWmX+q1SDoG/WQP0k2GQ
         WkxICWlTrVNFf+WhlnMUUslrbIR58oY7JCsbv0NGmk39pyv8LCsSsE13JsUJ02onaH1w
         lVFYcCyuHoM6C8O4wPYwrgY/vkT91bcPF1SGtsSWUnD+PPZcu1uQne2KLqCMHXP13RLK
         iOeD0fK1orm8qwy1tI7cAhsm90IrRQHu7wqf6EmMPwZs3feOQ12iMop1a6fjGjWV3Ykk
         /eHQ==
X-Gm-Message-State: AOJu0YzfsZcQ9X1JTULvv0drMwxmTJcoz5OIQ3K9NRyWqyKNT/BBNMdM
        2maNV1o550LhAZeFNivYcDLKHVaknpFmN98ZvZ6ib284
X-Google-Smtp-Source: AGHT+IEuthFiTuqOjlN6/dR8pXI6QQXaurPjDAzTSCDRdCfoqLvUXse2RhSDqIv3L7RidmzKx8B+RQ==
X-Received: by 2002:a05:6a00:2b46:b0:68a:6cbe:35a7 with SMTP id du6-20020a056a002b4600b0068a6cbe35a7mr7447105pfb.2.1699598524048;
        Thu, 09 Nov 2023 22:42:04 -0800 (PST)
Received: from localhost.localdomain ([165.132.118.52])
        by smtp.gmail.com with ESMTPSA id s12-20020aa7828c000000b006bd9422b279sm11725429pfm.54.2023.11.09.22.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 22:42:03 -0800 (PST)
From:   Minsuk Kang <linuxlovemin@yonsei.ac.kr>
To:     linux-wireless@vger.kernel.org, toke@toke.dk
Cc:     kvalo@kernel.org, dokyungs@yonsei.ac.kr, jisoo.jang@yonsei.ac.kr,
        Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Subject: [PATCH] wifi: ath9k: Fix potential array-index-out-of-bounds read in ath9k_htc_txstatus()
Date:   Fri, 10 Nov 2023 15:41:43 +0900
Message-Id: <20231110064143.1356077-1-linuxlovemin@yonsei.ac.kr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix an array-index-out-of-bounds read in ath9k_htc_txstatus(). The bug
occurs when txs->cnt, data from a URB provided by a USB device, is
bigger than the size of the array txs->txstatus, which is
HTC_MAX_TX_STATUS. WARN_ON() already checks it, but there is no bug
handling code after the check. Make the function return if that is the
case.

Found by a modified version of syzkaller.

UBSAN: array-index-out-of-bounds in htc_drv_txrx.c
index 13 is out of range for type '__wmi_event_txstatus [12]'
Call Trace:
 ath9k_htc_txstatus
 ath9k_wmi_event_tasklet
 tasklet_action_common
 __do_softirq
 irq_exit_rxu
 sysvec_apic_timer_interrupt

Signed-off-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
---
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
index 800177021baf..c628332f2562 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
@@ -652,9 +652,10 @@ void ath9k_htc_txstatus(struct ath9k_htc_priv *priv, void *wmi_event)
 	struct ath9k_htc_tx_event *tx_pend;
 	int i;
 
-	for (i = 0; i < txs->cnt; i++) {
-		WARN_ON(txs->cnt > HTC_MAX_TX_STATUS);
+	if (WARN_ON(txs->cnt > HTC_MAX_TX_STATUS))
+		return;
 
+	for (i = 0; i < txs->cnt; i++) {
 		__txs = &txs->txstatus[i];
 
 		skb = ath9k_htc_tx_get_packet(priv, __txs);
-- 
2.25.1

