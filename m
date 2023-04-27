Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEAA6F030C
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Apr 2023 11:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243252AbjD0JKA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Apr 2023 05:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243370AbjD0JJx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Apr 2023 05:09:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F6C19AB
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 02:09:52 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682586585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WJGbS7uyH4otkd8lhm/W2v7x2xzZlp1cwtcX1pR5VgY=;
        b=Cxg9vtRGWWA26JBi/3uuktwVhlGbeDiQmmfBmyuueWi4EBvtyBUlaPMkdHR5mu6Xgj2o0V
        AWgUU8VpPDjFoFGaPL3W3DpF9NWUl0PWZZ3bejhNogWmkkJZbt0+lTpOBtKX2Sg0NCUOXf
        rGHa6Gmxoxc7jgp2KJ6T/3eWO2SNX/S6iyjSdniYq0j1wMfK8g2BwyMMw2SAYzYGaEqu0A
        +Z0iVXSqp8p4f4svWw1v0aD3Kg6FabVWXR8YTMSiUFb/opZ6c97W3d/bjUpnMuznPUJ5vp
        Al/rNVxFliCvwmqpWoLHKOJoZWOlZx5Zd0nL4VuzC/fwu7ojqdkCotbF6PbrCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682586585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WJGbS7uyH4otkd8lhm/W2v7x2xzZlp1cwtcX1pR5VgY=;
        b=pCGINjxijBv/dkpG/h7334qYOZYnIKaBPq/KD+MmaHrJterWSl+nuayFpxuOp+iJ23KP22
        nRdEvMVAUlv1abDQ==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 07/18] wifi: rtl8xxxu: Actually use macid in rtl8xxxu_gen2_report_connect
Date:   Thu, 27 Apr 2023 11:09:11 +0200
Message-Id: <20230427090922.165088-8-martin.kaistra@linutronix.de>
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
index b8e5003c55e9e..10f2e18abb49a 100644
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

