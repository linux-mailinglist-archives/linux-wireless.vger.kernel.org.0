Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE460686C29
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Feb 2023 17:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjBAQy4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Feb 2023 11:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBAQyz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Feb 2023 11:54:55 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AEB677A9
        for <linux-wireless@vger.kernel.org>; Wed,  1 Feb 2023 08:54:54 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id z14so2514725pgs.10
        for <linux-wireless@vger.kernel.org>; Wed, 01 Feb 2023 08:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v42abFOaxIlmW4awj8kF2Nh0ZkUL+DGZkQ/FsMg5/Lo=;
        b=VrF1mG7zFBzc+C7jPblzg3iCFvvDjx/+tr7aA+HecgsS4iWudNCaPX0qWgYt2dCN0e
         PUmM93Vz92MUceh+zk1SV2VAWdhH8oePYHYIgZI435fyTmnP9z3hGnrOY3I0PyzsNeWs
         tHMMajIgi3fbTPiqhxmZlJiypDtRj4yIt4mXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v42abFOaxIlmW4awj8kF2Nh0ZkUL+DGZkQ/FsMg5/Lo=;
        b=yNy9nMGq8+lZedXoYa22/yyzNfdjxV3ziIcJTgHkSFuBYaCaiLm5Vdh2df6MRZZ6tx
         JBIYgIbBhbQYWbMLpXstCM287nzU3Kh9A2EzP2sO1kdrkPqLqicRdZcEQAztMle54/h9
         2j8AO7npPjOW/7k94ox5lBXV6fM+aA5rZvsn/rC1OgVfda2QQWMONc6+rBncLZMB3kc+
         BLMYhQuVD2i2RB9piHYZJH2XFLUb5NE8wXuoQ6hI/Z4CRSuD3PsFnu4tHF+ApTRGfuqv
         c/gA6F8/19f0QdVO4xsz+uC63hHKWfXcCAGpK7V2pMmtFZ3Cvrn1ySrdKJes1TFWk3tC
         VLHw==
X-Gm-Message-State: AO0yUKXqlTKtKllvKpdV7nQTXLPQ3yhubqJo04jhaLoP1v8/YoyMitGd
        kTwB83Olo8OY1Hq85sMj+s0eKw==
X-Google-Smtp-Source: AK7set/Ngk6EWKR6yWWn0hLrOjHifSFiaIyR4hRkotMraLijRfBa3zbKNX1T18IRweHaOow9z4BwTg==
X-Received: by 2002:a05:6a00:1d9a:b0:592:6313:20fb with SMTP id z26-20020a056a001d9a00b00592631320fbmr2864421pfw.30.1675270494150;
        Wed, 01 Feb 2023 08:54:54 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:ba26:efe8:5132:5fcf])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7870f000000b0058119caa82csm11605090pfo.205.2023.02.01.08.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 08:54:53 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@kernel.org>, junyuu@chromium.org,
        Youghandhar Chintala <quic_youghand@quicinc.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        Marc Zyngier <maz@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v2 1/2] wifi: ath11k: Use platform_get_irq() to get the interrupt
Date:   Wed,  1 Feb 2023 08:54:42 -0800
Message-Id: <20230201084131.v2.1.I69cf3d56c97098287fe3a70084ee515098390b70@changeid>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As of commit a1a2b7125e10 ("of/platform: Drop static setup of IRQ
resource from DT core"), we need to use platform_get_irq() instead of
platform_get_resource() to get our IRQs because
platform_get_resource() simply won't get them anymore.

This was already fixed in several other Atheros WiFi drivers,
apparently in response to Zeal Robot reports. An example of another
fix is commit 9503a1fc123d ("ath9k: Use platform_get_irq() to get the
interrupt"). ath11k seems to have been missed in this effort, though.

Without this change, WiFi wasn't coming up on my Qualcomm sc7280-based
hardware. Specifically, "platform_get_resource(pdev, IORESOURCE_IRQ,
i)" was failing even for i=0.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1

Fixes: a1a2b7125e10 ("of/platform: Drop static setup of IRQ resource from DT core")
Fixes: 00402f49d26f ("ath11k: Add support for WCN6750 device")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Jun Yu <junyuu@chromium.org>
---

Changes in v2:
- Update commit message and point to patch that broke us (Jonas)

 drivers/net/wireless/ath/ath11k/ahb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index d34a4d6325b2..f70a119bb5c8 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -859,11 +859,11 @@ static int ath11k_ahb_setup_msi_resources(struct ath11k_base *ab)
 	ab->pci.msi.ep_base_data = int_prop + 32;
 
 	for (i = 0; i < ab->pci.msi.config->total_vectors; i++) {
-		res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
-		if (!res)
-			return -ENODEV;
+		ret = platform_get_irq(pdev, i);
+		if (ret < 0)
+			return ret;
 
-		ab->pci.msi.irqs[i] = res->start;
+		ab->pci.msi.irqs[i] = ret;
 	}
 
 	set_bit(ATH11K_FLAG_MULTI_MSI_VECTORS, &ab->dev_flags);
-- 
2.39.1.456.gfc5497dd1b-goog

