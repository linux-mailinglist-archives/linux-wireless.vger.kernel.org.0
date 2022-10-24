Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB10F60BB1F
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Oct 2022 22:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbiJXUrJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Oct 2022 16:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbiJXUqf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Oct 2022 16:46:35 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DDBAA3E3
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 11:54:20 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id bn35so5248314ljb.5
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 11:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=or3xRrS/INQDHm4S2zfA+0UvMFona79sQpSwL68Z0rc=;
        b=USVTtrhqQZuzQsVZ5mLE6SMOvrua3JPub/J3hyAgi9HqkkpwSZSNNQBS+CKNoiLtzQ
         8ozworIpMysY54gJ5pA7K241EYa5iqcMrZ8L/z2BpdoLHEhnjmdnSGClpumGhouXg0I2
         uPE10Yftztjmk7B/zhkX+79H4sYD2GGTbeDc+i24UeOapsvghmxjcpualMiNaE3o76Yo
         PudUlBcqPeTPS7G9pHIxvHEso3pGTtHw20YJsqymoxCVvGaIKjI40Y/JXxXqqUcuARak
         RKxRLChO1OY820/BSNiRIoL0FXdrmo7sn71QBAWPKAU07QWeiQ8+qEVJ/wC5F+wVlu0l
         IJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=or3xRrS/INQDHm4S2zfA+0UvMFona79sQpSwL68Z0rc=;
        b=y4mry0OIluGROljy87HLWYJONF2HHZL9DkiGdHN7HPWPLav1UQEY6FmaolUpAf/b9A
         5Kg7OcfdWlmw+dzkqIrPH1Ki8gDgpIBth0MjvQTQPHS+Bs/3/ghm5HkftpF7HryH8TQ2
         z91XHAVKblj6iJ5ClHLaUv7DxPu/y0qlSWuWij9Xw6VEzvQk7belU2VifNtyjhysbIBC
         2VGQLOh4mMU2HTu9utQdo9uSSYvk7Lnton6aKFm8v4EHfEOocNqH3gSdTyI2or43MXS8
         6aTcKzcCMa6wkrhTQo2In5GOsG/i+1MMRKCHHm4pbAFgoHeFskTYE2OCyZbGuABbscyz
         irSA==
X-Gm-Message-State: ACrzQf3E6i9rK9GPDRAdYxgA21BNjJ+HRAV+WItcatphPgcgBgu7layu
        8RYX3VY3ETaxPD3N18/xiDc/ECjoZr9cag==
X-Google-Smtp-Source: AMsMyM78vZ/hqXj9mE115d8nESz6DHO56RCkfNSPTDwMgQrsqjagHJX5ZR6BYMnNB2BwTg7iLMW5sw==
X-Received: by 2002:a19:dc48:0:b0:4a8:d24b:d78 with SMTP id f8-20020a19dc48000000b004a8d24b0d78mr4738500lfj.351.1666615207646;
        Mon, 24 Oct 2022 05:40:07 -0700 (PDT)
Received: from fedora.. ([85.235.10.72])
        by smtp.gmail.com with ESMTPSA id a19-20020ac25e73000000b00492ce573726sm4515158lfr.47.2022.10.24.05.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 05:40:06 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] brcm80211: brcmsmac: Drop BMCMA consistency check
Date:   Mon, 24 Oct 2022 14:40:02 +0200
Message-Id: <20221024124002.10120-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The driver looks up the BCMA parent GPIO driver and checks that
this succeeds, but then it goes on to use the deprecated GPIO
call gpio_is_valid() to check the consistency of the .base
member of the BCMA GPIO struct. Surely this belongs in the
BCMA driver: we cannot have all drivers performing cosistency
checks on the internals of things they are passed.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
index c1b9ac692d26..1cce92c5780f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
@@ -63,7 +63,7 @@ int brcms_led_register(struct brcms_info *wl)
 	int hwnum = -1;
 	enum gpio_lookup_flags lflags = GPIO_ACTIVE_HIGH;
 
-	if (!bcma_gpio || !gpio_is_valid(bcma_gpio->base))
+	if (!bcma_gpio)
 		return -ENODEV;
 
 	/* find radio enabled LED */
-- 
2.34.1

