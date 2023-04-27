Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313DF6F0313
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Apr 2023 11:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243259AbjD0JKF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Apr 2023 05:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243365AbjD0JJx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Apr 2023 05:09:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564941A6
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 02:09:52 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682586585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eFQefnLON97IOyZiBGFWnt2KC6DF+o5CasS4LfMGqIY=;
        b=JIUskfk25gKfWWLWKsmLdQv/TiBxGRTp0CFR+zxdDjcPHLVFXGmRrnRPKwqyX1p+MsHhFY
        f8ktMUhAlW8lBm5xt5wDrH4pb27QVVrGwnxL8WjQiKgwgOFs/F3OKtr6D4R6BO2fig0Azw
        ypQNtS4w2/Uh/nFdxZ97uZLPbpp4Cd9ue3ZCV4iZE/zm4dhEe+Qp7SHrxOOLGX+9IxYSmB
        +zYKM3C2g+jFTwgH96eor8HUTI6PGCOUFONmk+f6CSAgv4+WjY/2w9+TLSCLddWyZPANZK
        /xAEG5D2Y21pH8pQbesKZpGKZL456burjC7dpTwQacTD4fDpN7VVaO63RH7CpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682586585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eFQefnLON97IOyZiBGFWnt2KC6DF+o5CasS4LfMGqIY=;
        b=biJzQKp5anz3rLJyBjf5fVI4YqUI5z3Ds6NxufbO634NNMjD1Y+lDlLIkoHAaZu1OecdkX
        hGw63KQ5S2AeZaAQ==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 05/18] wifi: rtl8xxxu: Allow setting rts threshold to -1
Date:   Thu, 27 Apr 2023 11:09:09 +0200
Message-Id: <20230427090922.165088-6-martin.kaistra@linutronix.de>
In-Reply-To: <20230427090922.165088-1-martin.kaistra@linutronix.de>
References: <20230427090922.165088-1-martin.kaistra@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The default setting in hostapd.conf for rts threshold is -1, which means
disabled. Allow to set it.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 551ceb2a2b653..a44bd5038ad24 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6654,7 +6654,7 @@ static void rtl8xxxu_configure_filter(struct ieee80211_hw *hw,
 
 static int rtl8xxxu_set_rts_threshold(struct ieee80211_hw *hw, u32 rts)
 {
-	if (rts > 2347)
+	if (rts > 2347 && rts != (u32)-1)
 		return -EINVAL;
 
 	return 0;
-- 
2.30.2

