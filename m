Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178B6733104
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 14:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245325AbjFPMTg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 08:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245256AbjFPMTf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 08:19:35 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5286E30DD
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jun 2023 05:19:31 -0700 (PDT)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6E5703F15F
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jun 2023 12:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686917968;
        bh=HbcVOb9efJYkmDhGqloOhMxTQvtdvJNNFO77juvfdww=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=KGkPNJGTePXS4xExPuFo7ryl4VdsiT8NDSCLpD3qtQDMbXP8QkWTBH0lrGQYWdtdU
         Q5bVgIH1DaKqF57s8rZOnnKTSxR8MV4kQcOuCer03HVsfPB0j5AIIPtmCwzL5D/uIw
         cYIEd6+e0c09D44JQp+1iAoWQ0fgzcsVwTKlTpeqPCUfN5xHoWzetXYLooSu1k/Pgw
         5Pk6/Vg5hRj29sSziCcIDzjvVL8lm4xsolbmELgCLcZzbf1F5lvvFv7C3QDL0njttA
         rPMPU5Yxh3FmkYPPfvrRPWv2QAk618jPmKoCcsuvuvvzfCxjpvR7nB8LciEBIlyJal
         ky7ld4IqMdCvg==
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f739a73ba4so2470065e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jun 2023 05:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686917968; x=1689509968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HbcVOb9efJYkmDhGqloOhMxTQvtdvJNNFO77juvfdww=;
        b=GKa1VK8jnmxuM10wEXHUhkAFNq7tBafLePEUtyFwx9idxNO4ueNpMRErFGKBHYBB64
         ZfVgjIYdYWBUo3xoDtU5vRgllx2orbjNgGJht/1OjQiPrFecwf1JS5BTrErRQYTxAFiV
         4yeyW7SIvEbaY9VWgn//7diQu/QCrQOAQhdFlAcn6T7j7orAMHqvl3aTRkrUnLtE0aPb
         w7fdDSIECFOsSBfrrHU+C6mtcsbtcdHzJ4af0HdPMF+QyFSYkKf/QeTX0ODY92Jw2ZYI
         dxp55SCItedzQ2ZQJKaHsFQOG1yHuk3419+kOKsWYMwuFcFt6gTUVRQy6n6RZDWmX2pY
         pEPA==
X-Gm-Message-State: AC+VfDx5W2GhidjrTfKMmGFSfOfEshcxXrgSPxd5vbxjLlwSfjVKI+pa
        NXv6LBYA9QmGzq/nZcISyF40M9kA3nU6u1FO7BnSdNHJ1vLdo3YLxjC01DOExF4eM0bBOiP4T+H
        SZ3snEDYYYK5drISgxik6ZjU+voBTuHlQVB3SyREsdW0V
X-Received: by 2002:a05:600c:2909:b0:3f1:bb10:c865 with SMTP id i9-20020a05600c290900b003f1bb10c865mr1638903wmd.38.1686917968183;
        Fri, 16 Jun 2023 05:19:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4LkTRN+lXP5TPRN5U/LZrINkJySpHEGjs2adWFiI6ByNCqvMTGtn3cXgsmPahIPjYjoPA2Hw==
X-Received: by 2002:a05:600c:2909:b0:3f1:bb10:c865 with SMTP id i9-20020a05600c290900b003f1bb10c865mr1638888wmd.38.1686917967904;
        Fri, 16 Jun 2023 05:19:27 -0700 (PDT)
Received: from localhost ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id k24-20020a7bc318000000b003f733c1129fsm2017151wmj.33.2023.06.16.05.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 05:19:27 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     chunkeey@googlemail.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH] wifi: p54: Add missing MODULE_FIRMWARE macro
Date:   Fri, 16 Jun 2023 14:19:17 +0200
Message-Id: <20230616121917.1034761-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add the missing MODULE_FIRMWARE macro for "3826.eeprom".

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 drivers/net/wireless/intersil/p54/p54spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intersil/p54/p54spi.c b/drivers/net/wireless/intersil/p54/p54spi.c
index 19152fd449ba..ce0179b8ab36 100644
--- a/drivers/net/wireless/intersil/p54/p54spi.c
+++ b/drivers/net/wireless/intersil/p54/p54spi.c
@@ -28,6 +28,7 @@
 #endif /* CONFIG_P54_SPI_DEFAULT_EEPROM */
 
 MODULE_FIRMWARE("3826.arm");
+MODULE_FIRMWARE("3826.eeprom");
 
 /* gpios should be handled in board files and provided via platform data,
  * but because it's currently impossible for p54spi to have a header file
-- 
2.37.2

