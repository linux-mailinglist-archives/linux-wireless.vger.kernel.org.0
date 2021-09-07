Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6C640287C
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Sep 2021 14:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344582AbhIGMUR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Sep 2021 08:20:17 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:33682
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344303AbhIGMTu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Sep 2021 08:19:50 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1373140793
        for <linux-wireless@vger.kernel.org>; Tue,  7 Sep 2021 12:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631017112;
        bh=alAZCnXDBZFqFGCWdjT1NtYwVcFPW4mHC6+AQVNQmag=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ahWsmlix5qZu4PCN4E6up4Tnegthwc6b8exu+qOav9qLBEGmq/y6C1KlZHjcKvJqX
         DopLZU0qot2emyWiCT9XcfTfJcwkXBfXAPPIp7v7r64FcdCoUQ2ueZJ6Jxc0qs3EcS
         dyXMEIGI1Dhmnu4R/s6hqZXj7VUaRxlmu5Kon7JQmLOECXLzUivA1SlCafatGZpw/R
         4ak4+stoe4VGLhZFP+4BSWPdmmRT80VjJqUm7b9s4yylVxM/19RNpXJJLZXbsBo6bO
         QOqUEFfiyaS53aahakom2krSGYSqy8m80TUxJO6Isab2q4OlcrUVY48cFFFrPPu0bB
         EBzGgcvXeebxA==
Received: by mail-wm1-f70.google.com with SMTP id y188-20020a1c7dc5000000b002e80e0b2f87so1120044wmc.1
        for <linux-wireless@vger.kernel.org>; Tue, 07 Sep 2021 05:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=alAZCnXDBZFqFGCWdjT1NtYwVcFPW4mHC6+AQVNQmag=;
        b=X8Dipx8tY17wg+AkK/D5M42zdliVefa+mJvfqUYlCnrS2srs5jai2t5uhuTJHPkWl2
         ZIrJhqDBRnR3la1G88fYB1juEgEfhLjBIXHcZjbG3yFAFh6U0Hf8PcMQWLa3XRd0unpF
         eNmLlauB7T7KLarS/HGWBYREO3BDFdBAMIdr+msEA0OuGn/LDJUrueu+suC0Bt2kX4qy
         s7yCKFLWOTktry4DbSYqAf7SFFqWkYv4BEMwgr3tn84KLI4GVM3aTffwLgb3X4iMwd6q
         Hb0nw7TeQhHwax6y2HzmYFcbgYrJbMuZqUpl9HwcQnfQF7E+YkemsG/TorH44bGvNr8x
         4jcA==
X-Gm-Message-State: AOAM531STmMgxnoSF92pXm88CMEBEqqYW2XetqyVEImHPE1HaVFKnnzW
        HUtJlK34QjoFa7/lzRBvaWFv9HzZmjJ1AU1Mhv0BZ4F4Mu90V1JRCrKF3UoLwOGDLhkY8IVcdjh
        AJx4Q72j+WqmilUDCmo0AcS8wlx6BQTQJNlDLIeQEtRTJ
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr3717613wmk.135.1631017111458;
        Tue, 07 Sep 2021 05:18:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSzLNNlEK8DFo/MnzQggQYeVU3xGdFUyuK/8MdNZjNchdqevSP20XoztHRWZaK3JDeEdaRWA==
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr3717597wmk.135.1631017111286;
        Tue, 07 Sep 2021 05:18:31 -0700 (PDT)
Received: from kozik-lap.lan ([79.98.113.47])
        by smtp.gmail.com with ESMTPSA id m3sm13525216wrg.45.2021.09.07.05.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 05:18:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 08/15] nfc: pn544: drop unneeded memory allocation fail messages
Date:   Tue,  7 Sep 2021 14:18:09 +0200
Message-Id: <20210907121816.37750-9-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210907121816.37750-1-krzysztof.kozlowski@canonical.com>
References: <20210907121816.37750-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

nfc_mei_phy_alloc() already prints an error message on memory allocation
failure.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/pn544/mei.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nfc/pn544/mei.c b/drivers/nfc/pn544/mei.c
index a519fa0a53e2..c493f2dbd0e2 100644
--- a/drivers/nfc/pn544/mei.c
+++ b/drivers/nfc/pn544/mei.c
@@ -23,10 +23,8 @@ static int pn544_mei_probe(struct mei_cl_device *cldev,
 	int r;
 
 	phy = nfc_mei_phy_alloc(cldev);
-	if (!phy) {
-		pr_err("Cannot allocate memory for pn544 mei phy.\n");
+	if (!phy)
 		return -ENOMEM;
-	}
 
 	r = pn544_hci_probe(phy, &mei_phy_ops, LLC_NOP_NAME,
 			    MEI_NFC_HEADER_SIZE, 0, MEI_NFC_MAX_HCI_PAYLOAD,
-- 
2.30.2

