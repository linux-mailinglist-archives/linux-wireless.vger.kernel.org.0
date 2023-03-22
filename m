Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D972F6C523F
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Mar 2023 18:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjCVRUI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Mar 2023 13:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjCVRTu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Mar 2023 13:19:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9648D64B3E
        for <linux-wireless@vger.kernel.org>; Wed, 22 Mar 2023 10:19:32 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679505552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HvH43liTSFhtoqxAQJqzzltuuGnd03E0R/xvDDhLjFU=;
        b=coEyn6dWgH9cftZJZ3sSE+LxjdXOvixrZeTU853M0TzCqp0fFwu91BLlZg8TgMVCTQUt+i
        JuoIXM5WVQc6z7KBrvzRvA9spyQXy2XbkZXha1a7i0/vExv/ZJ7K4OfecmEJ8FlMO+e7nS
        eolvObLxeO2rxiMQdzeQib3wlfXjGCpX8PfyM4BtsZgDFH5IbcyH2XoLl1UGJgaF639Kss
        2cIUbn6whygr0RmCnQgIDWJGFl97zWc6/LkJOB+n4781fSAM51FdVV3jPUNzh9o/MZ+qkE
        w8zWrvFeggwfLLZKDmh+xQI4tTU76s6eIdBRX7/FtOHwnBipREE3SWiFkobpiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679505552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HvH43liTSFhtoqxAQJqzzltuuGnd03E0R/xvDDhLjFU=;
        b=QocSV4JCu6QtVGb7E82zLZ0YTtOI1dQpTC8R/kIRDL1XdPxV5YdHLaSohNHSKbjehevElU
        RsKu0fO8s8kZH4AQ==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 08/14] wifi: rtl8xxxu: Actually use macid in rtl8xxxu_gen2_report_connect
Date:   Wed, 22 Mar 2023 18:18:59 +0100
Message-Id: <20230322171905.492855-9-martin.kaistra@linutronix.de>
In-Reply-To: <20230322171905.492855-1-martin.kaistra@linutronix.de>
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index b5cb15e472f1c..4209880d724be 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4557,6 +4557,8 @@ void rtl8xxxu_gen2_report_connect(struct rtl8xxxu_priv *priv,
 	else
 		h2c.media_status_rpt.parm &= ~BIT(0);
 
+	h2c.media_status_rpt.macid = macid;
+
 	rtl8xxxu_gen2_h2c_cmd(priv, &h2c, sizeof(h2c.media_status_rpt));
 }
 
-- 
2.30.2

