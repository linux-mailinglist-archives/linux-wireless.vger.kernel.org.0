Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4470F402881
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Sep 2021 14:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344620AbhIGMUV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Sep 2021 08:20:21 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:33694
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344330AbhIGMTv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Sep 2021 08:19:51 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D23DB4079C
        for <linux-wireless@vger.kernel.org>; Tue,  7 Sep 2021 12:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631017114;
        bh=dm7SJ/bHwjEDyQ2RFr3SYt5wwlTFgyi3tJxfnWGO4aU=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=P8NE7jktgFoRLcAw9YKtpxd9cyE05iHpHlXZKxAUKWliYfHfNx+dRXd5HrDcc+eN1
         7hdkaH7Q1qRKVmOT9IyEaWQ+0p74/V9ICAYjpS+I11GDYZOI7IYYKZYLe2nDK+0qqE
         Lxler81NbAzvSk7rcIFlf//Xxa+TcYFHWh81Dv1WzUTUWxR0BlgZdcrM0qGtEqkZyp
         n00Wm9C5NZaKciupQNoBaRqeqCT8VYM57UD04Lh7oZ2W5S8fv3N+Q08FwOBgNAEm8U
         /JGztzo5iSGrp06CAcqRGril2z+xNHQM2JmGvw8zSoY100B6Pfd73lHEggtbTBM9Uu
         sJehb81J6fnjA==
Received: by mail-wr1-f70.google.com with SMTP id h1-20020adffd41000000b0015931e17ccfso2040092wrs.18
        for <linux-wireless@vger.kernel.org>; Tue, 07 Sep 2021 05:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dm7SJ/bHwjEDyQ2RFr3SYt5wwlTFgyi3tJxfnWGO4aU=;
        b=JRsXI2GI7Nmli+EjZd5CDZk3Ph99Q4f1X/Hd3aUnRBr5sjGgMY4qcNonMnaZEwCv6B
         omndlNiCEGypPPMNHkP/LmL9ERatygBNGMlPvBsuUbWqLvgLmayVbgNtB1QCi5xztwv0
         SmKLV+ab7yzaUfCJc4Aw19J8o8mcyqLkkt3eiraA8F9StuxIFHVFMUDES7li/TiJLKYy
         3qa41OgjITT2kiIDzgGx+7GIQhaqPt2ZBWaEPq/YL7lAynngEVcJJ+BGHN1IgwkSb0CK
         HbfCWUBqnKOgclzCFvWCsCu+TSMpPkcwmMsdsJP2ngaZ7pjfXx/cutYM5rBgaixFp4tW
         Sx2A==
X-Gm-Message-State: AOAM533EfIq3fRW7NIoWa9J1iIo1zvRZaLmC1JBN/izFYbMkfGsuL02V
        SapZyHm+8svkS5j0H3sGJScuwRJKl00NtHvswnfnoks0794dSpgFGcHJUM0jmnuUk/q1MC7aYOB
        iGotufSxNdGZWhMeZ5Li8SiyfRrK+/+gx+lMrC6d0/a7J
X-Received: by 2002:a05:600c:22d2:: with SMTP id 18mr3809631wmg.57.1631017114368;
        Tue, 07 Sep 2021 05:18:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5jtNrITmHBDgLaBbxdrMwDPzRPd9HWI65g33beGxYwDoKNU0TPfWLbynhjY+3UZBxDrACFA==
X-Received: by 2002:a05:600c:22d2:: with SMTP id 18mr3809616wmg.57.1631017114195;
        Tue, 07 Sep 2021 05:18:34 -0700 (PDT)
Received: from kozik-lap.lan ([79.98.113.47])
        by smtp.gmail.com with ESMTPSA id m3sm13525216wrg.45.2021.09.07.05.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 05:18:33 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 10/15] nfc: st-nci: drop unneeded debug prints
Date:   Tue,  7 Sep 2021 14:18:11 +0200
Message-Id: <20210907121816.37750-11-krzysztof.kozlowski@canonical.com>
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
index a620c34790e6..af1f04c306cc 100644
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

