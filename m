Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68FB1F3F22
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2020 17:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbgFIPVa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jun 2020 11:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730108AbgFIPV2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jun 2020 11:21:28 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CE6C08C5C2
        for <linux-wireless@vger.kernel.org>; Tue,  9 Jun 2020 08:21:28 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e18so411328pgn.7
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2020 08:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uwvFGjyGkvShem51AX2k8l39E+uinZbFtzIiRAp08Pk=;
        b=Tqsz7mN0ZQ/Ebtwuuhlz2Aj5Nxp7ZH2E32VDTotEwsEFHfoCIcICryte8znwPwr/ML
         rJGLk5Don0hvRBsPIb38oIrdDDbG5L4Ob6CtN/+bzblcvgk0eAlGkyw9/JzYg5JF7rpH
         AXZ4YKev82m2zvwOymfK78TMabY5wSKQSzWgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uwvFGjyGkvShem51AX2k8l39E+uinZbFtzIiRAp08Pk=;
        b=dq3Elkq6/GLrSloCM+HMgpPF6o/iNIXcfzqAIFldAnargJb/Bx8HqxAXY6oM6/LdQ8
         NkKITnNjXLf/EWuGBi9wUTz0tS6UnOPRPgv4ESoEbyF/L3irJcCH95l720sbOKMokUFX
         nCnhPNtsGsPOsOKD08GVNItCgZ2ll/bzt+w+eP9Aar4FIr16sYHeRESRwnI2KO/mBh/d
         ScNCYZ9vXhgvXXrEn/zcFnl+UEiq4g/lerLd/aV25i3cmVrLvWM+WC/DTMknjkwCROwD
         kDz82t28nfSK0HFQoOb9DzwM3Ybh6ONNGb2PsR1RZxKMFBM3w1BnZUbUowCiSlErFmDP
         sJhw==
X-Gm-Message-State: AOAM531zNDS2GDQT7XqdkTbQ+TdwVwy88IsAgqGLtgC+mD63YochQWZi
        ZTicvBxGzwiiak2Q6ol0tjCTqQ==
X-Google-Smtp-Source: ABdhPJxfhZlV3Xjw60pqAdeCuYbdjB53klCTzNpy+pv6huQHBaXZLmLMb8qM09KF80pvp6RVg0iY4g==
X-Received: by 2002:a62:b402:: with SMTP id h2mr27157063pfn.221.1591716087205;
        Tue, 09 Jun 2020 08:21:27 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id c2sm10383572pfi.71.2020.06.09.08.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 08:21:26 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     kvalo@codeaurora.org
Cc:     kuabhs@google.com, pillair@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH] ath10k: Wait until copy complete is actually done before completing
Date:   Tue,  9 Jun 2020 08:20:58 -0700
Message-Id: <20200609082015.1.Ife398994e5a0a6830e4d4a16306ef36e0144e7ba@changeid>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On wcn3990 we have "per_ce_irq = true".  That makes the
ath10k_ce_interrupt_summary() function always return 0xfff. The
ath10k_ce_per_engine_service_any() function will see this and think
that _all_ copy engines have an interrupt.  Without checking, the
ath10k_ce_per_engine_service() assumes that if it's called that the
"copy complete" (cc) interrupt fired.  This combination seems bad.

Let's add a check to make sure that the "copy complete" interrupt
actually fired in ath10k_ce_per_engine_service().

This might fix a hard-to-reproduce failure where it appears that the
copy complete handlers run before the copy is really complete.
Specifically a symptom was that we were seeing this on a Qualcomm
sc7180 board:
  arm-smmu 15000000.iommu: Unhandled context fault:
  fsr=0x402, iova=0x7fdd45780, fsynr=0x30003, cbfrsynra=0xc1, cb=10

Even on platforms that don't have wcn3990 this still seems like it
would be a sane thing to do.  Specifically the current IRQ handler
comments indicate that there might be other misc interrupt sources
firing that need to be cleared.  If one of those sources was the one
that caused the IRQ handler to be called it would also be important to
double-check that the interrupt we cared about actually fired.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/net/wireless/ath/ath10k/ce.c | 30 +++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/ce.c b/drivers/net/wireless/ath/ath10k/ce.c
index 294fbc1e89ab..ffdd4b995f33 100644
--- a/drivers/net/wireless/ath/ath10k/ce.c
+++ b/drivers/net/wireless/ath/ath10k/ce.c
@@ -481,6 +481,15 @@ static inline void ath10k_ce_engine_int_status_clear(struct ath10k *ar,
 	ath10k_ce_write32(ar, ce_ctrl_addr + wm_regs->addr, mask);
 }
 
+static inline bool ath10k_ce_engine_int_status_check(struct ath10k *ar,
+						     u32 ce_ctrl_addr,
+						     unsigned int mask)
+{
+	struct ath10k_hw_ce_host_wm_regs *wm_regs = ar->hw_ce_regs->wm_regs;
+
+	return ath10k_ce_read32(ar, ce_ctrl_addr + wm_regs->addr) & mask;
+}
+
 /*
  * Guts of ath10k_ce_send.
  * The caller takes responsibility for any needed locking.
@@ -1301,19 +1310,22 @@ void ath10k_ce_per_engine_service(struct ath10k *ar, unsigned int ce_id)
 
 	spin_lock_bh(&ce->ce_lock);
 
-	/* Clear the copy-complete interrupts that will be handled here. */
-	ath10k_ce_engine_int_status_clear(ar, ctrl_addr,
-					  wm_regs->cc_mask);
+	if (ath10k_ce_engine_int_status_check(ar, ctrl_addr,
+					      wm_regs->cc_mask)) {
+		/* Clear before handling */
+		ath10k_ce_engine_int_status_clear(ar, ctrl_addr,
+						  wm_regs->cc_mask);
 
-	spin_unlock_bh(&ce->ce_lock);
+		spin_unlock_bh(&ce->ce_lock);
 
-	if (ce_state->recv_cb)
-		ce_state->recv_cb(ce_state);
+		if (ce_state->recv_cb)
+			ce_state->recv_cb(ce_state);
 
-	if (ce_state->send_cb)
-		ce_state->send_cb(ce_state);
+		if (ce_state->send_cb)
+			ce_state->send_cb(ce_state);
 
-	spin_lock_bh(&ce->ce_lock);
+		spin_lock_bh(&ce->ce_lock);
+	}
 
 	/*
 	 * Misc CE interrupts are not being handled, but still need
-- 
2.27.0.278.ge193c7cf3a9-goog

