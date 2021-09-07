Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE97402884
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Sep 2021 14:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344658AbhIGMUX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Sep 2021 08:20:23 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:33686
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344307AbhIGMTu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Sep 2021 08:19:50 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 96D4240784
        for <linux-wireless@vger.kernel.org>; Tue,  7 Sep 2021 12:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631017110;
        bh=NBr1U4LAwKajfkWi8d66f/F7DJmWNcP01ndf/w7qpqs=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=PN/OgM3lunGwgycn8et2C4vNacltmKKfNlmUUFbrGWpS3C4ybrYeybVbCB/ociM15
         VLBswpaUVEvRR0gwRmEj3dCotqrvlEyrfcj14XqtadaRbGxwS3qUFo7aICSgeBuCoX
         gFcwDXEiX1EV0u/N5vHhjtIUiBUK57RfB9T/EpYdAKw7Wv23EtsUp3+hM0Z1Sw6gnv
         WlWNQh3kTXj/28whJnw4wecELya0uzowKAHYiScEd67ter83Xv5duSVX1p5ba6qgJp
         g6bXfmpT+fIXZ1toEkaAnobqxkzbD/SFzMvTcVFPTUYNd7kxLZOGBEroQPovrASCbF
         BlAgAQV2cX9dQ==
Received: by mail-wr1-f69.google.com with SMTP id h1-20020adffd41000000b0015931e17ccfso2040047wrs.18
        for <linux-wireless@vger.kernel.org>; Tue, 07 Sep 2021 05:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NBr1U4LAwKajfkWi8d66f/F7DJmWNcP01ndf/w7qpqs=;
        b=Ds8fbtjpRzriJFGB8kS7OKNuQ53iY+BcbuWp4qKpyMHulH4twskmQXCCs4lH05NSDh
         hc6rTxa+HKGHjhMwQ6aeqAfYUKzeLXZvRqM1SdZtkRp4yLdykqrXtSEGks/xKAFQS0n8
         r53bQIJrje3JICYLGVyInBzQFaoK938NOMzDCtGB7hVRbR8J7JhoBtSJG5RGP+AiQetk
         uAuDy0vVdLQu/O+WCI7yV/+bpcDY7euWVnAHbQVXDisL2/5NZr1A4hsLn90OJG9PwTCB
         NE9keVUVOpCzXso+rlsDvqa1L8mTtoxXTiJFaILCrPt16lgTT5iYCeyRDJ5z7rAaCQZj
         z5oQ==
X-Gm-Message-State: AOAM532wwmBEe4v86YMxNI7BATVyOsYXqI0QQn3UaLCqOfJb7zmKBJeL
        jWXJtEr/pcJDtvfKh9DME1oNQtaAOQCS0TJux6/1XhuB5D0wluQPpMUYfrSPbacll39MtRwgOkH
        4xkJ8KKzBZVqXjiXh+CnL57CNsiNCbCBVRhk8lVW6KR9g
X-Received: by 2002:a05:600c:210a:: with SMTP id u10mr3577101wml.127.1631017110345;
        Tue, 07 Sep 2021 05:18:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpmN+J+nVSHJybMfzx2E98USXqdlKN6XTJk2Iwf0j0Co7NOrQuorgTzMhtPjYxrxKxWVDRvA==
X-Received: by 2002:a05:600c:210a:: with SMTP id u10mr3577088wml.127.1631017110234;
        Tue, 07 Sep 2021 05:18:30 -0700 (PDT)
Received: from kozik-lap.lan ([79.98.113.47])
        by smtp.gmail.com with ESMTPSA id m3sm13525216wrg.45.2021.09.07.05.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 05:18:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 07/15] nfc: pn544: drop unneeded debug prints
Date:   Tue,  7 Sep 2021 14:18:08 +0200
Message-Id: <20210907121816.37750-8-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210907121816.37750-1-krzysztof.kozlowski@canonical.com>
References: <20210907121816.37750-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ftrace is a preferred and standard way to debug entering and exiting
functions so drop useless debug prints.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/pn544/mei.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nfc/pn544/mei.c b/drivers/nfc/pn544/mei.c
index 5c10aac085a4..a519fa0a53e2 100644
--- a/drivers/nfc/pn544/mei.c
+++ b/drivers/nfc/pn544/mei.c
@@ -22,8 +22,6 @@ static int pn544_mei_probe(struct mei_cl_device *cldev,
 	struct nfc_mei_phy *phy;
 	int r;
 
-	pr_info("Probing NFC pn544\n");
-
 	phy = nfc_mei_phy_alloc(cldev);
 	if (!phy) {
 		pr_err("Cannot allocate memory for pn544 mei phy.\n");
@@ -46,8 +44,6 @@ static void pn544_mei_remove(struct mei_cl_device *cldev)
 {
 	struct nfc_mei_phy *phy = mei_cldev_get_drvdata(cldev);
 
-	pr_info("Removing pn544\n");
-
 	pn544_hci_remove(phy->hdev);
 
 	nfc_mei_phy_free(phy);
-- 
2.30.2

