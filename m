Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60D2D713FB
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2019 10:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbfGWI3b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jul 2019 04:29:31 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36018 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729876AbfGWI3b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jul 2019 04:29:31 -0400
Received: by mail-pl1-f193.google.com with SMTP id k8so20335482plt.3;
        Tue, 23 Jul 2019 01:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NkHeryh8Q6udxLnwGCUxosovoTR0t2OegISzrOJ2fJw=;
        b=k9rkvZAa3tiAN9OUpA7epDhPsVJZozyv43Hed58z7XwkMY5/CcK+yMkcg22bWEK/dE
         797kygwwCD9ciCpb0axpuESaOlHJCe6LWayIPW353fA0X6puP5dG38hq3hdrzeh/G/NY
         3+xrU6B+Mm4ZUIXN3tj1BkDDtgE5qucSLvry0lF2F7Mmxq3Pmhrum+N537HhbcYV/HjG
         siexKN9J2L8Z/3P87M0Fl7kG/Rn6NkGCh5B4L9xxZfTCBkd4MjO+02ccPifuyuEZH6gx
         QkRj+Deyh7Melht1w8k+3438yEE1u0Me8HAU9JkDAPJmeODEfxFUmXSHqENItsJG1KUv
         9PsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NkHeryh8Q6udxLnwGCUxosovoTR0t2OegISzrOJ2fJw=;
        b=QLeKdlfDUCHn/CLggIfVL45J7xcUhXk/CIW304ayRera71Tqxmg04XG58bDjew8cE1
         r+d++eDZoipMDkHoqyis+hQuAkqjyH7qgdUhMmns2M3Op7ChTAT5HIf+0A5raI8/qLuJ
         xJAE2piUFX1tIO6u7NR01QOChEylO7kGnfLQsJ9kmXBZ6sEcJqrb73qUrs4LZ/BuCkuj
         S/VRhGPnWFVoJdNZhlxwsKTTPSRQvtkqmJ6g/GzFRG2XL3GVs7lJwGDpf/M7S4zLWqxk
         e+0Jc10G/uficcHHhguoE1AsNDM9kAyA60sZezGC/cnFiJSdJ3cG4osZpEUa3DCLRnlC
         1IKA==
X-Gm-Message-State: APjAAAVwklc7K1/P33HrFEaqMtAvu3tAcDVhdjiRO1Pmr4Nhqa9VhDBK
        +Lj+wenJMUKkRaoi3Fq6RKI=
X-Google-Smtp-Source: APXvYqy0m8L99EtkRgnLLWoRMoCOw5XBTLGvCvJOHeH94aCz/w433Nyyt7Utx9rb6JUG2pz3UeKz+w==
X-Received: by 2002:a17:902:bf09:: with SMTP id bi9mr74501305plb.143.1563870570562;
        Tue, 23 Jul 2019 01:29:30 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id h11sm42601377pfn.120.2019.07.23.01.29.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 01:29:29 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] bcma: Use dev_get_drvdata
Date:   Tue, 23 Jul 2019 16:29:19 +0800
Message-Id: <20190723082918.21077-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/bcma/host_pci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bcma/host_pci.c b/drivers/bcma/host_pci.c
index f52239feb4cb..69c10a7b7c61 100644
--- a/drivers/bcma/host_pci.c
+++ b/drivers/bcma/host_pci.c
@@ -260,8 +260,7 @@ static void bcma_host_pci_remove(struct pci_dev *dev)
 #ifdef CONFIG_PM_SLEEP
 static int bcma_host_pci_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct bcma_bus *bus = pci_get_drvdata(pdev);
+	struct bcma_bus *bus = dev_get_drvdata(dev);
 
 	bus->mapped_core = NULL;
 
@@ -270,8 +269,7 @@ static int bcma_host_pci_suspend(struct device *dev)
 
 static int bcma_host_pci_resume(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct bcma_bus *bus = pci_get_drvdata(pdev);
+	struct bcma_bus *bus = dev_get_drvdata(dev);
 
 	return bcma_bus_resume(bus);
 }
-- 
2.20.1

