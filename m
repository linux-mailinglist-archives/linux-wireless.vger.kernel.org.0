Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 178E7F3427
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2019 17:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387470AbfKGQI0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Nov 2019 11:08:26 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35088 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730416AbfKGQI0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Nov 2019 11:08:26 -0500
Received: by mail-wr1-f66.google.com with SMTP id p2so3698539wro.2
        for <linux-wireless@vger.kernel.org>; Thu, 07 Nov 2019 08:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oE0/WWfY7OLPoAEouNbHTld+kPDPP1D0YZTxpVrn6jU=;
        b=D1K+gvAMelrcEN4XZn8sSB74OjpRUNRO+FMZVQ8FD8ksk/XLt6zw9E1NHTRH0K5W15
         jWbSaiZaI3O/NPuHf2ee/HJG3L2Aumckv36N5b5mQXYG6JZwDMySuZPCMcX/APTfiaFJ
         v9TdmelyyzTdbc/uq+v4VEj5xMv6ij8BpnCGD8dyvO+waVpLdGsmfgz7JAefrmjlY6ju
         UutwjAldnaWVDRgmQ013SzIM6T2WxtecBUwjDEWKwA4GREvKnuUcbkIMCkqSsvrvBqre
         NlVz7+shcPtW0pQsAtbvQpe8BeWAUX3nBqNIhwdbEIu1HqOnpkY5Vowp97LlbxlaN1df
         FruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oE0/WWfY7OLPoAEouNbHTld+kPDPP1D0YZTxpVrn6jU=;
        b=Ce4ThwklBQkMjSPHtbjHGCrlMuv6e/1+4O7WVAg6wP+Se51yyf4yL9O6uUoZhEjZPY
         t0c6fjGXQbPxbz2qoJllEBwg76vt5sz2cCDTd7Ra8VQ3x10k0PAgsxLvdX0dmicaZYrR
         labp59IKI4PpuoVg4Xww0AXN1yP0jadS7t0I6ia+HkmiqB6b2OmVLlWEsIez7avDBUJw
         xCUYn9rwzXGgTlk8nYn90OLEUHCO7z5wwbHcHvpH1w9JdnS5gRXRwmqUdjG0yCsZghe1
         YB+KRwJSnSo9NNtUzZBVp6anSD/wxUH4USyje2btm5wSXApWXMC/TtiL2w8mtiUwOxEH
         XtUA==
X-Gm-Message-State: APjAAAVLTINmKjaDNrpk7ijDcSxq8gYsPdV3ulxIQ8ENtDi02YlxLkoZ
        29Tv84jbZT9IYK//dAUgpMThKftr3vE=
X-Google-Smtp-Source: APXvYqyUw4t4J8QfMtXMTx1cdiNWKulVWQKdmmOvv/Wurj7GWRywU7rA0BQr16CiyNVgPQAI2s80gg==
X-Received: by 2002:adf:db41:: with SMTP id f1mr3480105wrj.351.1573142903953;
        Thu, 07 Nov 2019 08:08:23 -0800 (PST)
Received: from localhost.localdomain (x4d075f9d.dyn.telefonica.de. [77.7.95.157])
        by smtp.gmail.com with ESMTPSA id w10sm2248890wmd.26.2019.11.07.08.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 08:08:22 -0800 (PST)
From:   Eduardo Abinader <eduardoabinader@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Eduardo Abinader <eduardoabinader@gmail.com>, kvalo@codeaurora.org
Subject: [PATCH] brcmsmac: remove unnecessary return
Date:   Thu,  7 Nov 2019 17:07:46 +0100
Message-Id: <20191107160746.1535-1-eduardoabinader@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Eduardo Abinader <eduardoabinader@gmail.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
index 6bb34a12a94b..b9ff28aede9c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
@@ -7383,9 +7383,7 @@ static void brcms_c_update_beacon_hw(struct brcms_c_info *wlc,
 				     false, true);
 		/* mark beacon0 valid */
 		bcma_set32(core, D11REGOFFS(maccommand), MCMD_BCN1VLD);
-		return;
 	}
-	return;
 }
 
 /*
-- 
2.20.1

