Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40FF6F1B20
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 17:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346297AbjD1PIz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 11:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346269AbjD1PIv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 11:08:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83A04681
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 08:08:49 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682694519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZolI7+wIR4zVDJGQkK2Xs6BUWnrWlm1/ZM8fadm5LMQ=;
        b=eILEFb3ozjOf7B3VS7xqG/Ertat/6fuOQzemDUBUxaDyH5s6usls7Q0ZGbuqThAJIvvs4Y
        QqsvzYlSPM+AGsj8Im2GJP4r23JQ35KD3nE8g92rlDB0R7AL8u3nASsCFiaWf0PQWe2som
        osBr9dG0LV7urpSf6oeULNzboE8uHNO8xYFpfMyDyDWa5JcLY35ouSjZxaNtvbuC51vs0v
        YBF2qDvvP4sjYj2GSpY67SKdLdlLfbIK4GNcQ8pIlZ1EPSFJlM2T3ypHYhvCtjPcWAGF2q
        F3BwSrLZMDLLEdGUGiuYcqS0ZYnt6pjzQvTWPbsb/PGlRKXZhMx86jNp9Ltbeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682694519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZolI7+wIR4zVDJGQkK2Xs6BUWnrWlm1/ZM8fadm5LMQ=;
        b=HzP8oF4xXoyZDKGfqgpjfRxTH5Ml8OqRAnL5nwqbIqOeA4n2/miMbCKoDqcnYQvbWt4k/N
        eqYwRMalIJb8UADw==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v4 07/18] wifi: rtl8xxxu: Actually use macid in rtl8xxxu_gen2_report_connect
Date:   Fri, 28 Apr 2023 17:08:22 +0200
Message-Id: <20230428150833.218605-8-martin.kaistra@linutronix.de>
In-Reply-To: <20230428150833.218605-1-martin.kaistra@linutronix.de>
References: <20230428150833.218605-1-martin.kaistra@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The report_connect function has had a macid parameter from the
beginning, but it has not been used, because in STA mode, the value was
always zero.
As it can now have different values in AP mode, actually wire it up to
the H2C command.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index ab4a1f83c760c..66e196f7416ec 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4619,6 +4619,8 @@ void rtl8xxxu_gen2_report_connect(struct rtl8xxxu_priv *priv,
 	else
 		h2c.media_status_rpt.parm &= ~BIT(0);
 
+	h2c.media_status_rpt.macid = macid;
+
 	rtl8xxxu_gen2_h2c_cmd(priv, &h2c, sizeof(h2c.media_status_rpt));
 }
 
-- 
2.30.2

