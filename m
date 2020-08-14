Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8642024490F
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Aug 2020 13:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgHNLl5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Aug 2020 07:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728201AbgHNLkS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Aug 2020 07:40:18 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA79C06134B
        for <linux-wireless@vger.kernel.org>; Fri, 14 Aug 2020 04:40:08 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c80so7224353wme.0
        for <linux-wireless@vger.kernel.org>; Fri, 14 Aug 2020 04:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g3Hk1FVT6kYmmAMCjKTyvb55RXFn8kt2+wIwVu87Z28=;
        b=C6uKiSVsGwGfePyqv6a+yrvVdegloexgn47AlqqS0pzGizKSGu4esEbFmRdrC/Vot1
         tvgoaBBaKiK3egGJG7sRAr+idOe7zdZkcLdKgb69rSOXW4y7EiqIBFb5c8W0axEpBt4G
         W6b5ymrIf1U4IP8t6E4EwdCUFXjsSxtaosrqO8EsP7730+uEUoBihhfx6ChBiwTzjwYX
         TtzUqSvgH8r4FZg6NOKiIwCFvfYraRbIvkqxvrT0Jvo04ho9wXzuEzJystgQD9WiK2Mp
         QRI4PSJ2HtEbijUfBEaqHj4KS6pdev+jtOAwkD/jZhXploVVwcwyv3DfQSid/FHic+W5
         xLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g3Hk1FVT6kYmmAMCjKTyvb55RXFn8kt2+wIwVu87Z28=;
        b=mK+wq5NOaSnaUczK3Pif2PWdKdtKywvTkOxDPrnzCMuDfEBExqAX5bZRtzlo3P/cQx
         w+DqSL+/D6lJBTEVrzSS7mTjBisyw3uBOG3eCaH2E1mHaXHvHt1ci/BS/RCOidiogmJf
         Bo3XQhz7sJlEkp9Bi6b4HGx2NhY3t/2AYHsFRUrxaqi6UWTX/rRhqlSmyKXHlwpRuNot
         yUr4L0+xu86QFmSgTtGhcwUPG13u4zlsfUaPhrdrsr7kUOo782Yo1K5SaH9cK8pZs4mG
         Gjv5ga3AThxrTaj9rh0jcaEmKd2U4wdjP2yDU1TYzTAaikUnsl4II+Tc8SoSv9lsJd4d
         r8tg==
X-Gm-Message-State: AOAM532x/wWw91I05Qvi/kiGlzCYoJiNVZanpzAZx4D1q/GBeA53059M
        PuyidrbkJ1kzoH5Cq2FHYTJ0gg==
X-Google-Smtp-Source: ABdhPJzuPL3mMDnyT7Iu2WAhkaaemdHmy7KoEcRd/0NPJrJnPRODCK617+u1nBDJ+9XL5bi4j0GBFQ==
X-Received: by 2002:a7b:cd97:: with SMTP id y23mr2285194wmj.21.1597405207574;
        Fri, 14 Aug 2020 04:40:07 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id 32sm16409129wrh.18.2020.08.14.04.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 04:40:07 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        Martin Langer <martin-langer@gmx.de>,
        Stefano Brivio <stefano.brivio@polimi.it>,
        Michael Buesch <m@bues.ch>, van Dyk <kugelfang@gentoo.org>,
        Andreas Jaggi <andreas.jaggi@waterwave.ch>,
        linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
        netdev@vger.kernel.org
Subject: [PATCH 17/30] net: wireless: broadcom: b43legacy: main: Provide braces around empty 'if' body
Date:   Fri, 14 Aug 2020 12:39:20 +0100
Message-Id: <20200814113933.1903438-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814113933.1903438-1-lee.jones@linaro.org>
References: <20200814113933.1903438-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/broadcom/b43legacy/main.c: In function ‘b43legacy_interrupt_tasklet’:
 drivers/net/wireless/broadcom/b43legacy/main.c:1344:3: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]

Cc: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Martin Langer <martin-langer@gmx.de>
Cc: Stefano Brivio <stefano.brivio@polimi.it>
Cc: Michael Buesch <m@bues.ch>
Cc: van Dyk <kugelfang@gentoo.org>
Cc: Andreas Jaggi <andreas.jaggi@waterwave.ch>
Cc: linux-wireless@vger.kernel.org
Cc: b43-dev@lists.infradead.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/broadcom/b43legacy/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/b43legacy/main.c b/drivers/net/wireless/broadcom/b43legacy/main.c
index 2eaf481f03f1d..044a5fa66ae79 100644
--- a/drivers/net/wireless/broadcom/b43legacy/main.c
+++ b/drivers/net/wireless/broadcom/b43legacy/main.c
@@ -1340,8 +1340,9 @@ static void b43legacy_interrupt_tasklet(unsigned long data)
 		handle_irq_beacon(dev);
 	if (reason & B43legacy_IRQ_PMQ)
 		handle_irq_pmq(dev);
-	if (reason & B43legacy_IRQ_TXFIFO_FLUSH_OK)
+	if (reason & B43legacy_IRQ_TXFIFO_FLUSH_OK) {
 		;/*TODO*/
+	}
 	if (reason & B43legacy_IRQ_NOISESAMPLE_OK)
 		handle_irq_noise(dev);
 
-- 
2.25.1

