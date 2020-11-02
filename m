Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A5B2A291A
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Nov 2020 12:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgKBLZ3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Nov 2020 06:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728908AbgKBLZN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Nov 2020 06:25:13 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E969AC061A04
        for <linux-wireless@vger.kernel.org>; Mon,  2 Nov 2020 03:25:12 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id k18so9124276wmj.5
        for <linux-wireless@vger.kernel.org>; Mon, 02 Nov 2020 03:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H6cdhCKSV+e73IF059XTYbnS4xki9YceyWLt1d9tAnQ=;
        b=kjIRWtT2G1NDh+U38Rv7FfAtYfkysDEGZtHw5TH2vid5+NKIXzmhRCBeUQBm0i6rmD
         DvEtQF9SB1RCFYbfjkYC6GzPyb5orD2t7povv+ioDwtbaEk6XUMibMktPjJOXDJo6wGf
         lNJ/KAF89yLrKtfQnIz71cLLcwypx5jB7zAYx3A8P23YT3saMLL7GQLV75BHtiGuoqph
         xPLBdJVmD+nkUYCDMjRh/sVCz5aTAxm+wpko30RyclSwVR7wwbRRGZ/Il2GF05RE2NaG
         T45PwQcc9oe0/ekJ26MluU5sESU6motRpIsCfo4vWBNFYlMzWiBPSnverdYvQpbBt1uI
         bDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H6cdhCKSV+e73IF059XTYbnS4xki9YceyWLt1d9tAnQ=;
        b=TGbCiPq5gwed6DXLFtYLnc++vabCwFY6M945z0y9AgdPvpwqVVkS0mT1f9h7lEf/g7
         nhQIaqieokbCwuaInfti1OzQeuB82XalB937BkbeS7Nx20PN7sVl5GDlpDMI7zwwx66f
         P1lqZPjWVDnN9NH29pkEaWKNpQIGg29j/B1YAhKIknyl0hoQY+jV76SDndSI05WSb+x1
         I9eqYFn/I3Y4qtq1W/9PH4pt6Kup4ttM8J2dU24qf3cSUXxYfhjFfEw2rgn0lJ0EcmPA
         tglW/fAdeYBx/CkV5AR0jAIqfCnAr5h6sycrek/e07YLEA92RYxscopaDWgfDv49CZv/
         mDJA==
X-Gm-Message-State: AOAM53122FCI1azmMTQhrUBGLQe0Cru4EqjzDkL2NaZGXtekQWJDdGfl
        Gi8zz9MnKAts8mdZlkw1a212lA==
X-Google-Smtp-Source: ABdhPJyIwYcuEegu2lamPvWHAIqF6Vi2NTmBnd9CkNt4PE4Bls9W2ZyKizwMFz2Xed+Kelo4AnAbJg==
X-Received: by 2002:a1c:103:: with SMTP id 3mr16983122wmb.81.1604316311669;
        Mon, 02 Nov 2020 03:25:11 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m14sm21867354wro.43.2020.11.02.03.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:25:11 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 41/41] realtek: rtw88: pci: Add prototypes for .probe, .remove and .shutdown
Date:   Mon,  2 Nov 2020 11:24:10 +0000
Message-Id: <20201102112410.1049272-42-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102112410.1049272-1-lee.jones@linaro.org>
References: <20201102112410.1049272-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/realtek/rtw88/pci.c:1488:5: warning: no previous prototype for ‘rtw_pci_probe’ [-Wmissing-prototypes]
 1488 | int rtw_pci_probe(struct pci_dev *pdev,
 | ^~~~~~~~~~~~~
 drivers/net/wireless/realtek/rtw88/pci.c:1568:6: warning: no previous prototype for ‘rtw_pci_remove’ [-Wmissing-prototypes]
 1568 | void rtw_pci_remove(struct pci_dev *pdev)
 | ^~~~~~~~~~~~~~
 drivers/net/wireless/realtek/rtw88/pci.c:1590:6: warning: no previous prototype for ‘rtw_pci_shutdown’ [-Wmissing-prototypes]
 1590 | void rtw_pci_shutdown(struct pci_dev *pdev)
 | ^~~~~~~~~~~~~~~~

Cc: Yan-Hsuan Chuang <yhchuang@realtek.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/realtek/rtw88/pci.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.h b/drivers/net/wireless/realtek/rtw88/pci.h
index ca17aa9cf7dc7..7cdbb9533a09a 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.h
+++ b/drivers/net/wireless/realtek/rtw88/pci.h
@@ -212,6 +212,10 @@ struct rtw_pci {
 	void __iomem *mmap;
 };
 
+int rtw_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id);
+void rtw_pci_remove(struct pci_dev *pdev);
+void rtw_pci_shutdown(struct pci_dev *pdev);
+
 static inline u32 max_num_of_tx_queue(u8 queue)
 {
 	u32 max_num;
-- 
2.25.1

