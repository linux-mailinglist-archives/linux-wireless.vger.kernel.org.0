Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B263F3C7C
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Aug 2021 23:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhHUVFx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Aug 2021 17:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbhHUVFx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Aug 2021 17:05:53 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687FDC061575
        for <linux-wireless@vger.kernel.org>; Sat, 21 Aug 2021 14:05:13 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id r17-20020a0568302371b0290504f3f418fbso23959409oth.12
        for <linux-wireless@vger.kernel.org>; Sat, 21 Aug 2021 14:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=46fy5xAeWWEt4Q7fLDKMyeqCSDu/ixAPmiNoshobWVA=;
        b=E8gfnE9qZjDLZrWh9NtnHBq7W9u7jogkApMIOOuRDCtx8RvhfzepWkBxohkgPOK5m8
         6Cq/8MT/FbtCWuCsw9CVIas+EFTG7aLj3e08AnBPrWflr1Y9FbRTsM9BNjB6TsltdhwD
         bl3e0ZkfiV7CUMAMphtYQYABrBPvebjRd/YjxA90zKwqj5mhVw10R7mC/lypaDuZz2ZG
         FuW5SPQlBZFaTr+uLUASORkDrHALD3bK09RA82UAp5uYmM3ISTGnmQieDQYiKLYuR/bz
         SXsMZOvESQE0rOkin5cRDSaI3lqtj/FkTZdj0hpkDKXskNb23N+8DRkugfPAUPk205Jw
         PiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=46fy5xAeWWEt4Q7fLDKMyeqCSDu/ixAPmiNoshobWVA=;
        b=eR8Zh7daRna8aBiTS5oMNwRaQZnHXsOVPxQEdNIaqpfDzyuyWDP4MgnjQW96bbpXaJ
         RD9dbINVT+QZuz5GGMV2UnkiSsjvTvUVoU0/RBe481aPICQI9xhiOVbB7gxxB84Wk1aL
         tN4lmnx8/s9bsk8qlZFf6b1Zx5qmRjs09HH4DRgtfNdsn35kU3/Usie6jjfLQH9Av2Pk
         U/xfXfeUwp+9WpasNRn/gYhChH0Sl4JcIPtau2EHWSCyG6hkUC2JsZaoERrRJvy3PCPk
         bgtS1WFwjtdnxlsMfYZP40QL42wuhYSfoPjOskYB3YYlxmcsePyHGmvzVX/9+zdOu2qI
         6FNw==
X-Gm-Message-State: AOAM533hD5zzkc7zdlmKy85Kx6OCmX5CvQK0hdMwUaXp3uJy2nksj+TW
        s2dVPUHyUjBti/pOL2di5p4=
X-Google-Smtp-Source: ABdhPJzNDtv0VIkSZjukiZ5v6UmT0TeknxnVYM88FogwpjJA3JOeAT/10xY7WIossm62k0tAJL4H0A==
X-Received: by 2002:aca:a996:: with SMTP id s144mr7268666oie.175.1629579912636;
        Sat, 21 Aug 2021 14:05:12 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-1023.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-1023.res6.spectrum.com. [2603:8090:2005:39b3::1023])
        by smtp.gmail.com with ESMTPSA id t1sm2533598otp.9.2021.08.21.14.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 14:05:12 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        =?UTF-8?q?Ugo=20R=C3=A9mery?= <ugo.remery@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2] rtw88: add quirk to disable pci caps on HP Pavilion 14-ce0xxx
Date:   Sat, 21 Aug 2021 16:05:05 -0500
Message-Id: <20210821210505.20257-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ugo Rémery <ugo.remery@gmail.com>

    8821CE causes random freezes on HP Pavilion 14-ce0019nf. Add a quirk
    to disable pci ASPM capability.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - add s-o-b line
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

