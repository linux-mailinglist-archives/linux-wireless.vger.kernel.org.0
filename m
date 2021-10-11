Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797F8428E46
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 15:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237080AbhJKNla (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 09:41:30 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:42362
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237135AbhJKNl1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 09:41:27 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 102A04001A
        for <linux-wireless@vger.kernel.org>; Mon, 11 Oct 2021 13:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633959567;
        bh=Puh8mRYPY/DpKQ/I9uyYNXcSBWp/u+3lkb87itcd3n8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=VlIZJ4zJ/4yWy8zt3LFot0lww1jlqbDcBEUvwblYixb0WeL8g282gJyDiEfbPVn4y
         okZCp1aJ30b/4ZUwC1FOu8eYBxpmYL/n1M6k5xtq7J1tCAhNhHIdNu6/7q58IJNnSN
         3ymuJ9IA9+Jv1UZeimBkejBG1qJEgzbEG1GVJ0GrzYy6O2uQzYGrx47cFEir0xHyID
         QyQ8gytVuLsuwPcKWUbiMbPz8g5sxZynyiLQeba54pTCrGsUYkGMYlYPkfFFVZur5w
         EPEcGDjNDk8HkEgmTd43Hiun2o2l/Waa6MZOC/Air9xZhjG2iABxoogUSCQDc+YgoN
         RPPH9E/Tp5caA==
Received: by mail-lf1-f71.google.com with SMTP id z18-20020a0565120c1200b003fd76d7ca21so5747550lfu.13
        for <linux-wireless@vger.kernel.org>; Mon, 11 Oct 2021 06:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Puh8mRYPY/DpKQ/I9uyYNXcSBWp/u+3lkb87itcd3n8=;
        b=hCaNECjXuaY1UrFyn9yDiep3q02VGJZqK9UcBFiZuvQ3fNcLSq/2szWGiXNVJR8cT3
         A3gTxL8ziZ6pHAAvRjkOl8sKj7rtE1/IxaA6MelvOaL0jIkIFkjJjLxagrY/MtChSuvu
         M2TLZVYSLim/NeKQNNgKgjOSzMFrpTLSH2DchGwvwQwkRKuRUq6sATeJ2/mQwe4RA0YZ
         QuZ1akLOurIfs29Z+bM6zY0dT3mLSWykvLIQCCyuPK4xMisJ0w0ikyoeoD43LgdYf7HY
         ol9xfwzPsnL7VmlxZP254wiZhRbBCE2SatNzqSNw9VTirmI9X798Bo9ZwkVmRS4mpiXQ
         RH9Q==
X-Gm-Message-State: AOAM531mq62jnaNJcIUmBPwwMHftMCZHdAuhORNwMdkTvGvJiDHRCM2s
        n8l6/3Aj5nKFeT8c5iYGfalXiq72LLyaiVSwLSLlpz7oP20bdgk3GUbmafln3ZcWLTVPI9aZ7N5
        M8ILA2eFmxH0CrvC5zGIHIe6At+N13MFrAGczeZW1I58Q
X-Received: by 2002:a2e:2f02:: with SMTP id v2mr22210434ljv.46.1633959564971;
        Mon, 11 Oct 2021 06:39:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsHtSdzR2RKXsyeIm4Ju2gl2Vpl3fdAIGqOrTAjyiVzZQlzK6SqwIND9M51s0GItDHKqvpwQ==
X-Received: by 2002:a2e:2f02:: with SMTP id v2mr22210288ljv.46.1633959563302;
        Mon, 11 Oct 2021 06:39:23 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a21sm738971lff.37.2021.10.11.06.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 06:39:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Cc:     joe@perches.com
Subject: [PATCH v3 5/7] nfc: st21nfca: drop unneeded debug prints
Date:   Mon, 11 Oct 2021 15:38:33 +0200
Message-Id: <20211011133835.236347-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211011133835.236347-1-krzysztof.kozlowski@canonical.com>
References: <20211011133835.236347-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ftrace is a preferred and standard way to debug entering and exiting
functions so drop useless debug prints.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/st21nfca/i2c.c | 4 ----
 drivers/nfc/st21nfca/se.c  | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/drivers/nfc/st21nfca/i2c.c b/drivers/nfc/st21nfca/i2c.c
index 279d88128b2e..f126ce96a7df 100644
--- a/drivers/nfc/st21nfca/i2c.c
+++ b/drivers/nfc/st21nfca/i2c.c
@@ -421,7 +421,6 @@ static int st21nfca_hci_i2c_read(struct st21nfca_i2c_phy *phy,
 static irqreturn_t st21nfca_hci_irq_thread_fn(int irq, void *phy_id)
 {
 	struct st21nfca_i2c_phy *phy = phy_id;
-	struct i2c_client *client;
 
 	int r;
 
@@ -430,9 +429,6 @@ static irqreturn_t st21nfca_hci_irq_thread_fn(int irq, void *phy_id)
 		return IRQ_NONE;
 	}
 
-	client = phy->i2c_dev;
-	dev_dbg(&client->dev, "IRQ\n");
-
 	if (phy->hard_fault != 0)
 		return IRQ_HANDLED;
 
diff --git a/drivers/nfc/st21nfca/se.c b/drivers/nfc/st21nfca/se.c
index c8bdf078d111..a43fc4117fa5 100644
--- a/drivers/nfc/st21nfca/se.c
+++ b/drivers/nfc/st21nfca/se.c
@@ -257,8 +257,6 @@ static void st21nfca_se_wt_timeout(struct timer_list *t)
 	struct st21nfca_hci_info *info = from_timer(info, t,
 						    se_info.bwi_timer);
 
-	pr_debug("\n");
-
 	info->se_info.bwi_active = false;
 
 	if (!info->se_info.xch_error) {
@@ -278,8 +276,6 @@ static void st21nfca_se_activation_timeout(struct timer_list *t)
 	struct st21nfca_hci_info *info = from_timer(info, t,
 						    se_info.se_active_timer);
 
-	pr_debug("\n");
-
 	info->se_info.se_active = false;
 
 	complete(&info->se_info.req_completion);
-- 
2.30.2

