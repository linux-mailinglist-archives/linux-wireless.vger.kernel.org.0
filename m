Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8BD5FB273
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Oct 2022 14:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiJKMb6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Oct 2022 08:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJKMbt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Oct 2022 08:31:49 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47E873C1A
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 05:31:47 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id h8so4618270lja.11
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 05:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DiULCP5IK6g6yDAZXxPPFtT8V5DH34gq3DXIhUtgRsc=;
        b=vmzXWTX+BgRtJRuJTAjwNZUh6ku4MwbsM7Z9B+vynAk6LVmZHO+Ot8/6ym3p7cPB4M
         F8plgugbMBSyIN9aNip9G7GEM18bXJvAfaozeOx+oNl75Nu5WYHAhzo0td3MoULyCvpC
         vXcbUVSEa8afY1LQ5/HDqvdWoe7ORt2fWvyGV9z3cYQexwnmhZDr+eSv6bSOF6djEzfB
         YgXLebPS+CvubF2GO+ntqlcUwMZHZqhXDhfkQyjxgNwkhR7Ti+CEBXSRREkUiZrZzUm4
         rkHMNfbBBjy+4n0xmcyx0rLB6XpI7nLZSj/bJ7kF8EyqGrQVr7eBvyCRoDZz3tHNvwgC
         GKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DiULCP5IK6g6yDAZXxPPFtT8V5DH34gq3DXIhUtgRsc=;
        b=zZ5xzyZF1i/Z1tDb9csWqZhMf/o7jb0guAYWzzVjf4L93cm7Eo9f52BjXBHly9OSQ6
         cwPZp98/FS5I9hfzdOqVjN3wBoA/Rberk5C0ply/R4ffICA7cDLUhIPJOani9ETsExgU
         QiL7ZaS39yb0AmwRwijMndwhVA+lPrW47xeZmF0e452zIfiXwGCyNXKzCjymS7/p7Lhi
         0WwiYCltUYDQB87fi4efIbI/L/U75tLklbsjk8y3au30khAHbucT5JX2J9MlWgQU1rbz
         kA8LAA+Em+gBFR+EQYBZ7eDN6sqsQ4OA4S0czfHrLS/huFtBhDYU+HI2M5iDB5MiZDoC
         5emw==
X-Gm-Message-State: ACrzQf1YxhKbZLA+vfhFBSZwh+TZet40KJ0FC7dHTlGLNvNm4++tX718
        zIuc0r7S6ZZqfndZWCLMlXtMNA==
X-Google-Smtp-Source: AMsMyM5n9T7hr6zrio8ZBnyjdQEUJAhcdiCTmTxOmpEZC1uj/3+QFTA0NpMW6CtM+lg67UrKoADojg==
X-Received: by 2002:a2e:2c0e:0:b0:26e:9219:fb0b with SMTP id s14-20020a2e2c0e000000b0026e9219fb0bmr5844810ljs.432.1665491506220;
        Tue, 11 Oct 2022 05:31:46 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id d22-20020a056512369600b00494942bec60sm1854998lfs.17.2022.10.11.05.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 05:31:45 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] bcma: support SPROM rev 11
Date:   Tue, 11 Oct 2022 14:29:41 +0200
Message-Id: <20221011122941.2053705-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rev 11 works fine for me to set the MAC address of gmac0 and
gmac1 in the D-Link DWL-8610AP.

Cc: Rafał Miłecki <zajec5@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/bcma/sprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bcma/sprom.c b/drivers/bcma/sprom.c
index 3da01f173c63..e668ad7963fc 100644
--- a/drivers/bcma/sprom.c
+++ b/drivers/bcma/sprom.c
@@ -165,7 +165,7 @@ static int bcma_sprom_valid(struct bcma_bus *bus, const u16 *sprom,
 		return err;
 
 	revision = sprom[words - 1] & SSB_SPROM_REVISION_REV;
-	if (revision != 8 && revision != 9 && revision != 10) {
+	if (revision < 8 || revision > 11) {
 		pr_err("Unsupported SPROM revision: %d\n", revision);
 		return -ENOENT;
 	}
-- 
2.34.1

