Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5783E3B87E7
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Jun 2021 19:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhF3Rso (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Jun 2021 13:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhF3Rso (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Jun 2021 13:48:44 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7743BC061756
        for <linux-wireless@vger.kernel.org>; Wed, 30 Jun 2021 10:46:14 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id w127so3946328oig.12
        for <linux-wireless@vger.kernel.org>; Wed, 30 Jun 2021 10:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :signed-off-by:signed-off-by:content-transfer-encoding;
        bh=zgXoZGTXhK8ipzSc30Bk2a0gDD9NP9alubpgikMMT+8=;
        b=B4yExCTOlS5G+/WGjW82eEGGLNLahkm7edLdkFFM6J3+RJgdDiPeiXbe30t/qaPiEu
         bt2YrJZ4InBgwvVQY0hIASLep7KeqItpioZktcyAIrM22Ac+EzGfEK72u9sP4E88Zpyt
         6X4g0cUith55zj+S3gneWZWpVC2PJeWsKDQoXKVhiYnwFaz5jtHhMW1KfBAC7ltQezfT
         X3PKZJyRFUPni4cSmwMf7bD200H+4h+6ssC4vgj4cRuy8w6iA2A9FzyoRTeS8pijyDfy
         UtdMA/aPET++1oF+a9KwoHU7iSMfycQHyeXWPqKnDRDH2ZQGMF5JBmiSrVWSoNYFFjij
         5aiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:signed-off-by:signed-off-by:content-transfer-encoding;
        bh=zgXoZGTXhK8ipzSc30Bk2a0gDD9NP9alubpgikMMT+8=;
        b=lColgtox/xGnMXtnmVMPqqmQWRVHKGw4fyTcnTH3t880Rtml8m6wIOUvJQ1T3MIRsK
         R6w4fovICDSJ0jvgmB9MX5g2ZUEzWz04YP9fMGSN3L79LHod3CTO3bKrJZ9ptoJIYRIV
         i/HcazdRd5/s/Y17czj45X0Z0kLm6vU66qQAu7Lcfvnb18DRdaQT/Iakum2rQtZzaIhy
         CiinudBuDGUegVR3BcJTo3gQEk+IoSwMILlYBtr4dmJhMpDO3yPOjo4hjuC0BiAxrVEY
         6/hTl4Raw2v0owtdpVcR98fcwlC0YTv4Bn7db1og1fFNunWIfI0mToDKbGuv7XTLsdzW
         KTvQ==
X-Gm-Message-State: AOAM5320sMmCQZ2lwyuuo86QjtkgkBXivQ3m+ElyixKaVWxmO26IuRVC
        jiUBa7vQdfoDfW4H0i2cu4k=
X-Google-Smtp-Source: ABdhPJxl6lHZJwXYe8BR6APrNPB+xeChIPnLS1BoRAe/H2b6dV8/rCWNsVKHlrrnyfDCchdEgsH2TA==
X-Received: by 2002:aca:f09:: with SMTP id 9mr5928624oip.51.1625075173926;
        Wed, 30 Jun 2021 10:46:13 -0700 (PDT)
Received: from localhost.localdomain.com (cpe-24-31-245-107.kc.res.rr.com. [24.31.245.107])
        by smtp.gmail.com with ESMTPSA id e2sm1991496ook.45.2021.06.30.10.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 10:46:13 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, Ugo Remery <ugo.remery@gmail.com>
Subject: [PATCH] rtw88: add quirk to disable pci caps on HP Pavilion 14-ce0xxx
Date:   Wed, 30 Jun 2021 12:46:08 -0500
Message-Id: <20210630174608.5329-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Signed-off-by: Ugo Remery <ugo.remery@gmail.com>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ugo Remery <ugo.remery@gmail.com>

    8821CE causes random freezes on HP Pavilion 14-ce0019nf. Add a quirk
    to disable pci ASPM capability.
---
 drivers/net/wireless/realtek/rtw88/pci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index e7d17ab8f113..31ee859d379b 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1701,6 +1701,15 @@ static const struct dmi_system_id rtw88_pci_quirks[] = {
 		},
 		.driver_data = (void *)BIT(QUIRK_DIS_PCI_CAP_ASPM),
 	},
+	{
+		.callback = disable_pci_caps,
+		.ident = "HP HP Pavilion Laptop 14-ce0xxx",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion Laptop 14-ce0xxx"),
+		},
+		.driver_data = (void *)BIT(QUIRK_DIS_PCI_CAP_ASPM),
+	},
 	{}
 };
 
-- 
2.32.0

