Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59B44F0D19
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Apr 2022 02:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350239AbiDDADK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 3 Apr 2022 20:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348892AbiDDADJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 3 Apr 2022 20:03:09 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D2E33344
        for <linux-wireless@vger.kernel.org>; Sun,  3 Apr 2022 17:01:13 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-deb9295679so8832720fac.6
        for <linux-wireless@vger.kernel.org>; Sun, 03 Apr 2022 17:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3xukvvVybYdZlnxG+Sujoy9Ko6VwTJSavA4isam1d+Y=;
        b=eGJ80zi8RgiNL3MbOUI40VmOcKTviGplPbDGC26EphjB8IHzn/O4sFjFsPAsNc/P3e
         GUzAMxwqgCFjgYRbAZ/Ot5axeKOwnyn8wWPBoYHkiUsZ2Dk/leFfIQ3HpgdWTjsViJLk
         J8mvhT9i5NFMMAws9Hy2XO+69WIDi8A6nT+lCnyEIRpQuvaAFAJN0LqWoEuSZCnJUB8m
         rOdWMXW5TJAMv7MSxla4Ivv4nGMJDZ07MN+RCs8NkiEMdTqnu6KdTTP7UYMWDy7b2YIq
         BOgC7TLdsbTgSIKQzaVNO7PQTq+8dgs16RSvNFg+dnWV4SQPUtlJzfulPdgsIrcNHihR
         pKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3xukvvVybYdZlnxG+Sujoy9Ko6VwTJSavA4isam1d+Y=;
        b=OtajHMA+ZATewHCL62cZV2dh0+bKH1+vXReQ72p/28FIzGZpsYEX/O/mkMaARVq43h
         tcPNKFzsb57+Jgy9A5IqJL8RIJBGLDSFRYTxuv5m5m5jTs827m1P8rKncaXv8WV2T5Li
         2f0bprKnjdzzQb08mjI2K2DFYUqSPO/rqzneTSmUvWRgNPLznVw+GSTA6DTvkpOdNFGj
         Vpfm9lhtoJs9GpCW8NQJiWZg4Rb4006fRLPHY9wC7vcqhdfYvV1kta4zb/iNBgaMKS2N
         4SbSJ+Mk/MhThUKDaxInXe3z3Q6ic+nf2dBMoYIQI5bQSbVgiJfGsYkM+MJmkj5w0uoL
         6DHw==
X-Gm-Message-State: AOAM530/Hq0WSKz15QLiRzBaOmgqcb0uMdyV/KGRkLkD66EbrzzIonpv
        Pk8KYwdLuS+Mu2uIJYBBBTdZBFWX6CE=
X-Google-Smtp-Source: ABdhPJxoNQkRO5rJIlmER8VtQcgal+DjbDe0s6/83hdJBudgE6n43Hri1x/hpBD9x7uTv0GuLZ45nw==
X-Received: by 2002:a05:6870:c6a4:b0:dd:cbcf:49b8 with SMTP id cv36-20020a056870c6a400b000ddcbcf49b8mr9368432oab.158.1649030472560;
        Sun, 03 Apr 2022 17:01:12 -0700 (PDT)
Received: from tower.austin.rr.com (cpe-68-203-212-228.rgv.res.rr.com. [68.203.212.228])
        by smtp.gmail.com with ESMTPSA id z10-20020a0568301daa00b005ce0f36dd81sm3885680oti.12.2022.04.03.17.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 17:01:11 -0700 (PDT)
From:   Jimmy Hon <honyuenkwun@gmail.com>
To:     tony0620emma@gmail.com
Cc:     linux-wireless@vger.kernel.org, Jimmy Hon <honyuenkwun@gmail.com>
Subject: [PATCH] rtw88: 8821ce: add support for device ID 0xb821
Date:   Sun,  3 Apr 2022 19:01:07 -0500
Message-Id: <20220404000107.11327-1-honyuenkwun@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

New device ID 0xb821 found on TP-Link T2E
Tested it with c821 driver. 2.4GHz and 5GHz works.

PCI id:
05:00.0 Network controller: Realtek Semiconductor Co., Ltd. Device b821
        Subsystem: Realtek Semiconductor Co., Ltd. Device b821

Signed-off-by: Jimmy Hon <honyuenkwun@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/pci.c       | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821ce.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index a0991d3f15c0..38ed5c35a2bd 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1770,7 +1770,7 @@ int rtw_pci_probe(struct pci_dev *pdev,
 	}
 
 	/* Disable PCIe ASPM L1 while doing NAPI poll for 8821CE */
-	if (pdev->device == 0xc821 && bridge->vendor == PCI_VENDOR_ID_INTEL)
+	if ((pdev->device == 0xc821 || pdev->device == 0xc821) && bridge->vendor == PCI_VENDOR_ID_INTEL)
 		rtwpci->rx_no_aspm = true;
 
 	rtw_pci_phy_cfg(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821ce.c b/drivers/net/wireless/realtek/rtw88/rtw8821ce.c
index f34de115e4bc..56d22f9de904 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821ce.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821ce.c
@@ -8,6 +8,10 @@
 #include "rtw8821ce.h"
 
 static const struct pci_device_id rtw_8821ce_id_table[] = {
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0xB821),
+		.driver_data = (kernel_ulong_t)&rtw8821c_hw_spec
+	},
 	{
 		PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0xC821),
 		.driver_data = (kernel_ulong_t)&rtw8821c_hw_spec
-- 
2.35.1

