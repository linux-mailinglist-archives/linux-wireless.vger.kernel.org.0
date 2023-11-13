Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800B07E96D0
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 07:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjKMG6p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 01:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjKMG6o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 01:58:44 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15EE10E9
        for <linux-wireless@vger.kernel.org>; Sun, 12 Nov 2023 22:58:36 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6bf20d466cdso718456b3a.1
        for <linux-wireless@vger.kernel.org>; Sun, 12 Nov 2023 22:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yonsei.ac.kr; s=google; t=1699858716; x=1700463516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m4L4gBEOZBTrPJ6JsZXPOv6ZHD41975xrE9mHR4z/i0=;
        b=VA0b8g+M6fOaTIAI0yyHLdgsc7MeHlJ3J+s1tLBHBwmwj/0wPIJV1V8x7bFeaDS2Vb
         R13LSiY5mqTOsB19U4jzGKVpwgcSKeihe1ETFXdgtCJ/OHHIh0o2Ul1/ROsgxJ5PcOrL
         SuqKl9dneDMxPFbeiohUKICS12LHnwKHDvWBvKtxs9N01bqjVuGU1nDTK/xo4IDMysmX
         DTb3dwD13RcNsBekYVcovg+UXPG27u0wv31BbwxzUjUVo7vxF/4Gt9lb6DRX9U6PWUeG
         FCGMLlC1vLWb5JLPqvUAEPMK9ljwRQBo0BJf0SHCyZv0RdBnMjTKAEPz+MhDvaPN+XYS
         zSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699858716; x=1700463516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4L4gBEOZBTrPJ6JsZXPOv6ZHD41975xrE9mHR4z/i0=;
        b=FSQF3rMPuUgOsxm03IEfRUGzIyOXCogiFDbZuuUQyiVQEwZn1IluFblWo6WKU1OM64
         f9PJ1kGpKNDsLL/xdwCJJK5NVkNzdx84k3IDIFiw7Jr6PfmzR4guI4i8fNxNBlVdPq0x
         0xRVGbGwLROaYP3us0RFTMQj69fIQ0/spM+wl9ziJZIND/dk0/4yC7B3ROs0nre237zc
         EFY0XRXCOqwBwSWPbFJCxXRJHe8NUJ1rRl5szZmjIdThR7xv8Vco42WyRvoW0zNdKaLa
         4oXWs9/uJK/WE6t/EBx253qhY76BJs3POCzyQQNFrhXCc+9f9nf8jtQIyaw/KtKy9fCI
         8gbw==
X-Gm-Message-State: AOJu0YyZq4CDPst3vG4njIOpUW3w9MlniO9ZcrhkwN9f0NFlPwyDkkCM
        3a5B/tmgc9hKKf84rOPduom+wlk5dAPWxpP3VhIy/8bl
X-Google-Smtp-Source: AGHT+IFofUJ1j6f5btRhll+WABtoIaUahciZixG8xW8foH/fnOprzBql/EKIhdSQCzU+ZjrmcbdElw==
X-Received: by 2002:a05:6a00:1398:b0:6b2:51a0:e1c9 with SMTP id t24-20020a056a00139800b006b251a0e1c9mr6792015pfg.1.1699858715906;
        Sun, 12 Nov 2023 22:58:35 -0800 (PST)
Received: from localhost.localdomain ([165.132.118.52])
        by smtp.gmail.com with ESMTPSA id d22-20020aa78156000000b006c4db18207csm3315340pfn.58.2023.11.12.22.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 22:58:35 -0800 (PST)
From:   Minsuk Kang <linuxlovemin@yonsei.ac.kr>
To:     linux-wireless@vger.kernel.org, toke@toke.dk
Cc:     kvalo@kernel.org, dokyungs@yonsei.ac.kr, jisoo.jang@yonsei.ac.kr,
        Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Subject: [PATCH v2] wifi: ath9k: Fix potential array-index-out-of-bounds read in ath9k_htc_txstatus()
Date:   Mon, 13 Nov 2023 15:57:56 +0900
Message-Id: <20231113065756.1491991-1-linuxlovemin@yonsei.ac.kr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
v1->v2:
  Use WARN_ON_ONCE() instead of WARN_ON()

 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
index 800177021baf..efcaeccb055a 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
@@ -652,9 +652,10 @@ void ath9k_htc_txstatus(struct ath9k_htc_priv *priv, void *wmi_event)
 	struct ath9k_htc_tx_event *tx_pend;
 	int i;
 
-	for (i = 0; i < txs->cnt; i++) {
-		WARN_ON(txs->cnt > HTC_MAX_TX_STATUS);
+	if (WARN_ON_ONCE(txs->cnt > HTC_MAX_TX_STATUS))
+		return;
 
+	for (i = 0; i < txs->cnt; i++) {
 		__txs = &txs->txstatus[i];
 
 		skb = ath9k_htc_tx_get_packet(priv, __txs);
-- 
2.25.1

