Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2552D428E40
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 15:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237170AbhJKNld (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 09:41:33 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:42328
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237124AbhJKNl0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 09:41:26 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A1AE040000
        for <linux-wireless@vger.kernel.org>; Mon, 11 Oct 2021 13:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633959565;
        bh=i5yc8KqEKBR9h1kRXiKNI/2N/o+Yq4m6PQJBbQ1oeXs=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=D3wNnhXeTCTtDv1EZoSu4g2pT+RnWZjPfOxlIm472t6tDgmfkyHaB9igZY28lVBN4
         42qaPquwyjtapm9ULifVcdoL22cbOZ34IcuCO60F4hlsTnYjqdeOHMhQotbn1lFpEN
         L7KAliLnlCJEW8OitH0dgx78kO70UunTIHTmlKxi2KRGqxvUvbFCX1w40oRrxAzz+C
         dkqrCrrCOEtB5BqZ7rLMv2z+xliz8bvKRAxnJz92g5MR7yRkfAbu868p7k5HxIGPox
         Iz3RidAgUXBBhaqBBIyHONQKeiz8izp+RaKxC0XRinmGkKItfrWSr6jS2qULU6qaa7
         Liv1aoSsRudSA==
Received: by mail-lf1-f72.google.com with SMTP id c6-20020a05651200c600b003fc6d39efa4so12798441lfp.12
        for <linux-wireless@vger.kernel.org>; Mon, 11 Oct 2021 06:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i5yc8KqEKBR9h1kRXiKNI/2N/o+Yq4m6PQJBbQ1oeXs=;
        b=0WNU8JbrpQAUPFycozBat+pH2TYK1oNiAzap59l91ebZnMny1MDKXx/+/eRF5wxCD0
         DahXgXqrRAseoVxbr/SBjFAuNRfWamqiq95zhVMCq9D2zCmgABNe+Ijc0GWyD3lR/o6Z
         u4yZuWOz8KebIi+NNpnDpxMcrH14Fxf0S1SDyDg6DTEJwaEhxkUpR0TRtPDYg5AuV+tS
         xXdVLa+RQQJ3O8r0gCXIH6fanCU5cPXV83kM0eIeKvYzRmrZzh6wAlsTasYMox4dWSdw
         7cf8k3WbBSNzd7XAGlyRuF8WHjUj/de5rYSM7ogj+r53+oMLzwr3hydNMzGZOKIJWrBb
         Ym5g==
X-Gm-Message-State: AOAM5304FTp1Z2mw1x74lZGjowDcnKQcmGSCuEGxzNEAH6ZTs3tPlJWE
        QEjmfG5j3W5ENLsxNmEpp9WEPHbJerdTFrEuen3QB3pVWzmjDwaPycB/gt5h1Rl5kmV/Ym1laJ2
        Rz4OkM9jF1Sc34hO3W8IFK7mo1KgbSN/a4BwaxrGamJLF
X-Received: by 2002:a05:651c:306:: with SMTP id a6mr15998812ljp.184.1633959563587;
        Mon, 11 Oct 2021 06:39:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzWPAdasfuvRGxPNUBZNJ6I6fwASrdSHHpim7p1tdUG8oN1RygrOjGMsN9WyX+XmBQSPu7eA==
X-Received: by 2002:a05:651c:306:: with SMTP id a6mr15998666ljp.184.1633959561921;
        Mon, 11 Oct 2021 06:39:21 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a21sm738971lff.37.2021.10.11.06.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 06:39:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Cc:     joe@perches.com
Subject: [PATCH v3 4/7] nfc: st-nci: drop unneeded debug prints
Date:   Mon, 11 Oct 2021 15:38:32 +0200
Message-Id: <20211011133835.236347-5-krzysztof.kozlowski@canonical.com>
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
 drivers/nfc/st-nci/i2c.c  | 4 ----
 drivers/nfc/st-nci/ndlc.c | 4 ----
 drivers/nfc/st-nci/se.c   | 6 ------
 drivers/nfc/st-nci/spi.c  | 4 ----
 4 files changed, 18 deletions(-)

diff --git a/drivers/nfc/st-nci/i2c.c b/drivers/nfc/st-nci/i2c.c
index ccf6152ebb9f..cbd968f013c7 100644
--- a/drivers/nfc/st-nci/i2c.c
+++ b/drivers/nfc/st-nci/i2c.c
@@ -157,7 +157,6 @@ static int st_nci_i2c_read(struct st_nci_i2c_phy *phy,
 static irqreturn_t st_nci_irq_thread_fn(int irq, void *phy_id)
 {
 	struct st_nci_i2c_phy *phy = phy_id;
-	struct i2c_client *client;
 	struct sk_buff *skb = NULL;
 	int r;
 
@@ -166,9 +165,6 @@ static irqreturn_t st_nci_irq_thread_fn(int irq, void *phy_id)
 		return IRQ_NONE;
 	}
 
-	client = phy->i2c_dev;
-	dev_dbg(&client->dev, "IRQ\n");
-
 	if (phy->ndlc->hard_fault)
 		return IRQ_HANDLED;
 
diff --git a/drivers/nfc/st-nci/ndlc.c b/drivers/nfc/st-nci/ndlc.c
index e9dc313b333e..755460a73c0d 100644
--- a/drivers/nfc/st-nci/ndlc.c
+++ b/drivers/nfc/st-nci/ndlc.c
@@ -239,8 +239,6 @@ static void ndlc_t1_timeout(struct timer_list *t)
 {
 	struct llt_ndlc *ndlc = from_timer(ndlc, t, t1_timer);
 
-	pr_debug("\n");
-
 	schedule_work(&ndlc->sm_work);
 }
 
@@ -248,8 +246,6 @@ static void ndlc_t2_timeout(struct timer_list *t)
 {
 	struct llt_ndlc *ndlc = from_timer(ndlc, t, t2_timer);
 
-	pr_debug("\n");
-
 	schedule_work(&ndlc->sm_work);
 }
 
diff --git a/drivers/nfc/st-nci/se.c b/drivers/nfc/st-nci/se.c
index 5fd89f72969d..7764b1a4c3cf 100644
--- a/drivers/nfc/st-nci/se.c
+++ b/drivers/nfc/st-nci/se.c
@@ -638,8 +638,6 @@ int st_nci_se_io(struct nci_dev *ndev, u32 se_idx,
 {
 	struct st_nci_info *info = nci_get_drvdata(ndev);
 
-	pr_debug("\n");
-
 	switch (se_idx) {
 	case ST_NCI_ESE_HOST_ID:
 		info->se_info.cb = cb;
@@ -671,8 +669,6 @@ static void st_nci_se_wt_timeout(struct timer_list *t)
 	u8 param = 0x01;
 	struct st_nci_info *info = from_timer(info, t, se_info.bwi_timer);
 
-	pr_debug("\n");
-
 	info->se_info.bwi_active = false;
 
 	if (!info->se_info.xch_error) {
@@ -692,8 +688,6 @@ static void st_nci_se_activation_timeout(struct timer_list *t)
 	struct st_nci_info *info = from_timer(info, t,
 					      se_info.se_active_timer);
 
-	pr_debug("\n");
-
 	info->se_info.se_active = false;
 
 	complete(&info->se_info.req_completion);
diff --git a/drivers/nfc/st-nci/spi.c b/drivers/nfc/st-nci/spi.c
index 0875b773fb41..4e723992e74c 100644
--- a/drivers/nfc/st-nci/spi.c
+++ b/drivers/nfc/st-nci/spi.c
@@ -169,7 +169,6 @@ static int st_nci_spi_read(struct st_nci_spi_phy *phy,
 static irqreturn_t st_nci_irq_thread_fn(int irq, void *phy_id)
 {
 	struct st_nci_spi_phy *phy = phy_id;
-	struct spi_device *dev;
 	struct sk_buff *skb = NULL;
 	int r;
 
@@ -178,9 +177,6 @@ static irqreturn_t st_nci_irq_thread_fn(int irq, void *phy_id)
 		return IRQ_NONE;
 	}
 
-	dev = phy->spi_dev;
-	dev_dbg(&dev->dev, "IRQ\n");
-
 	if (phy->ndlc->hard_fault)
 		return IRQ_HANDLED;
 
-- 
2.30.2

