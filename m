Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053D867A20C
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jan 2023 20:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjAXTBc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Jan 2023 14:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbjAXTBa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Jan 2023 14:01:30 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561824C6EA
        for <linux-wireless@vger.kernel.org>; Tue, 24 Jan 2023 11:01:27 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id k10-20020a17090a590a00b0022ba875a1a4so12628174pji.3
        for <linux-wireless@vger.kernel.org>; Tue, 24 Jan 2023 11:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50cO/6ZppDTgK/hTEwdsnZtIUmof/i6Am5RFe+y6fDg=;
        b=jfE7I7WvzTda77if8o0AnlZyXeVHxwVIDww/9+S2ljpISGdXCqTC5lnP6jAn25+P3s
         JiEJswbNMHjeomPV9fvhWaP1X+eg4zcs17gt/efjfnNzHMspdGlPF5yq+/Cfg1HOvLg2
         Kp5IWDoo6CYqTnsILJ5HtBvSIVzD/oqlSVKFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50cO/6ZppDTgK/hTEwdsnZtIUmof/i6Am5RFe+y6fDg=;
        b=RMTg2b7b+TMLLE8DnqpVdYA2Rw4F5ubgLpXi29K5rK8Fyp0hrdfLmFQXZCF3qeKUUV
         NOXtfZuvu2ZZUF3FSpTnaQ8EMMJr5cn/ORfxg45jngU1aAlzSdvB153Z59xqdM+6dVSs
         DfF1Etbqbvhg+C7EreGJ3Nf+s6lpLr0w8Z0S7fPTlQ/8KUDF47hIUj1d97ZmwDn8f0/D
         xv1zntdbjiTnIr9qPpHecoh4zIwCw3dgPSdHrsNPLpUwaRg6S8SO5rnn73qmyNPwoM2A
         vaji07flA5oI7VXHq1/OYvcV6K/Uh9Dlz+eMdw6Rmoc5wFXWtj5WLACl2NKtwLYNQUd5
         widw==
X-Gm-Message-State: AO0yUKUa3/sQsX+4dwlg3s5kB9EDU6r7DUGhhhx0G3CCx3txpULonXhI
        jLNOBYBYx2NqlvpEI8N+seJkww==
X-Google-Smtp-Source: AK7set8UGHGugxZPfIDZziY43UqyiSusorvSQsjCeo4te4wOprdvp/KbTUT4tFW/IJ4PPfPd66crVg==
X-Received: by 2002:a17:903:18f:b0:196:cea:487a with SMTP id z15-20020a170903018f00b001960cea487amr6070801plg.53.1674586886656;
        Tue, 24 Jan 2023 11:01:26 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:7b28:de8d:ee0:2cd6])
        by smtp.gmail.com with ESMTPSA id f10-20020a17090274ca00b001948720f6bdsm2010415plt.98.2023.01.24.11.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 11:01:26 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Youghandhar Chintala <quic_youghand@quicinc.com>,
        junyuu@chromium.org, Kalle Valo <kvalo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 2/2] wifi: ath5k: Use platform_get_irq() to get the interrupt
Date:   Tue, 24 Jan 2023 11:01:01 -0800
Message-Id: <20230124110057.2.Ic4f8542b0588d7eb4bc6e322d4af3d2064e84ff0@changeid>
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f-goog
In-Reply-To: <20230124110057.1.I69cf3d56c97098287fe3a70084ee515098390b70@changeid>
References: <20230124110057.1.I69cf3d56c97098287fe3a70084ee515098390b70@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For the same reasons talked about in commit 9503a1fc123d ("ath9k: Use
platform_get_irq() to get the interrupt"), we should be using
platform_get_irq() in ath5k. Let's make the switch.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I'm not setup to actually test this, but I figured that I might as
well go all the way and fix all the instances of the same pattern that
I found in the ath drivers since the old call was actually breaking me
in ath11k. I did at least confirm that the code compiles for me.

If folks would rather not land an untested patch like this, though,
feel free to drop this and just land patch #1 as long as that one
looks OK.

 drivers/net/wireless/ath/ath5k/ahb.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath5k/ahb.c b/drivers/net/wireless/ath/ath5k/ahb.c
index 2c9cec8b53d9..28a1e5eff204 100644
--- a/drivers/net/wireless/ath/ath5k/ahb.c
+++ b/drivers/net/wireless/ath/ath5k/ahb.c
@@ -113,15 +113,13 @@ static int ath_ahb_probe(struct platform_device *pdev)
 		goto err_out;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (res == NULL) {
-		dev_err(&pdev->dev, "no IRQ resource found\n");
-		ret = -ENXIO;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "no IRQ resource found: %d\n", irq);
+		ret = irq;
 		goto err_iounmap;
 	}
 
-	irq = res->start;
-
 	hw = ieee80211_alloc_hw(sizeof(struct ath5k_hw), &ath5k_hw_ops);
 	if (hw == NULL) {
 		dev_err(&pdev->dev, "no memory for ieee80211_hw\n");
-- 
2.39.1.405.gd4c25cc71f-goog

