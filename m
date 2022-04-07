Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929234F782F
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Apr 2022 09:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242298AbiDGHyE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Apr 2022 03:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiDGHyB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Apr 2022 03:54:01 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE69123BEB
        for <linux-wireless@vger.kernel.org>; Thu,  7 Apr 2022 00:52:03 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id w127so4835798oig.10
        for <linux-wireless@vger.kernel.org>; Thu, 07 Apr 2022 00:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t96OkOU3FEohAgs5/29zf4S1G5FFjYOOGwf94z7wQOo=;
        b=QkGVPH/QdkkoQwehITwTQHlCJOCdMCNUpsm5nxJz8W7L6ToKskxqlZtvW+srY8LE/S
         Jsoq/rOGJNg7WaHbQuiJjLOhoVQJOHr6MD2m3fji9rpPz3p9bFbncTKzvq/FA65yd6id
         3cfvbLbv7OFH5Fgz8hSNiivPSJfZOsEMW5YrNQMplcBADjwtDW0Pyx1G6Vv9nSZ3JYIl
         Aml+hJY7hSJb/wo7QdRaBzys0EYtRfwEc2WfDHpm4W0fgmhmkfYkrgywdY9Jon/9u4d1
         sNkC7jWSSuYzAotcfnNMsOdv8wPU1T0bgY2OZ5wDGiM3hJp7233X1SrXr+Hdhqt5waUy
         rWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t96OkOU3FEohAgs5/29zf4S1G5FFjYOOGwf94z7wQOo=;
        b=dfS48sVnjppV6+i0e0UUUztLpo6YCKI0CnIz0L3PtRidIgEz+FHmMkjp1GxNTyUP5s
         nI/HRQBMz2c0+PbG+xqbLfROMrzeGRYwYVAEqV+XnKW8WHpFAfFf6nMSHxdNx+bwXQ9+
         hodMqChVOkFvBICnQu3Gfr6PIZ+FXClhB6etylCQyKopya/zn7dlxuD5E7LCHLw0tePR
         K7K11IeNecx90HlV4tl1J41nWxlSCdpLMu+wxEuHU+L2EhIWd1IvVsr1QsUEEn7KWcDA
         yANUPPiVQAXgqcs86atUVC3+ni3HIylDfwQOApjSmP/w3+3+R7BhSpqA11XTi8vIW4uA
         dlFg==
X-Gm-Message-State: AOAM5323wJ2kbn0AtEJ8MlJtlpMxAfLLnFko8r8pl/tJ9scppWXJw1J3
        O9zg+6XhOB+xFVJkZpPAbkSg036IJ38=
X-Google-Smtp-Source: ABdhPJzwMAdQS5845Ahd6XfwXIbgNMnrqDUrv83Fg57KjDJTf4Axl8O+I6fBjg7UTFTuGB1Y6+1+6A==
X-Received: by 2002:a05:6808:1798:b0:2ef:97d1:c7e4 with SMTP id bg24-20020a056808179800b002ef97d1c7e4mr5308340oib.215.1649317922456;
        Thu, 07 Apr 2022 00:52:02 -0700 (PDT)
Received: from tower.austin.rr.com (cpe-68-203-212-228.rgv.res.rr.com. [68.203.212.228])
        by smtp.gmail.com with ESMTPSA id v13-20020a4ae6cd000000b00328882a2388sm6906245oot.14.2022.04.07.00.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 00:52:01 -0700 (PDT)
From:   Jimmy Hon <honyuenkwun@gmail.com>
To:     tony0620emma@gmail.com
Cc:     linux-wireless@vger.kernel.org, Jimmy Hon <honyuenkwun@gmail.com>
Subject: [PATCH 2/2] rtw88: 8821ce: Disable PCIe ASPM L1 for 8821CE using chip ID
Date:   Thu,  7 Apr 2022 02:51:23 -0500
Message-Id: <20220407075123.420696-3-honyuenkwun@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407075123.420696-1-honyuenkwun@gmail.com>
References: <20220407075123.420696-1-honyuenkwun@gmail.com>
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

Make workaround work for other 8821CE devices with different PCI ID

Signed-off-by: Jimmy Hon <honyuenkwun@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index a0991d3f15c0..0edb5711b546 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1770,7 +1770,7 @@ int rtw_pci_probe(struct pci_dev *pdev,
 	}
 
 	/* Disable PCIe ASPM L1 while doing NAPI poll for 8821CE */
-	if (pdev->device == 0xc821 && bridge->vendor == PCI_VENDOR_ID_INTEL)
+	if (rtwdev->chip->id == RTW_CHIP_TYPE_8821C && bridge->vendor == PCI_VENDOR_ID_INTEL)
 		rtwpci->rx_no_aspm = true;
 
 	rtw_pci_phy_cfg(rtwdev);
-- 
2.35.1

