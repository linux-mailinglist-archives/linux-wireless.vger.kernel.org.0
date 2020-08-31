Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73DE2572E1
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Aug 2020 06:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgHaEhN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Aug 2020 00:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgHaEhM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Aug 2020 00:37:12 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3973C061573
        for <linux-wireless@vger.kernel.org>; Sun, 30 Aug 2020 21:37:11 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t11so2441866plr.5
        for <linux-wireless@vger.kernel.org>; Sun, 30 Aug 2020 21:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EUUyZQTfJ6EFFOJHIgPa+9Hxbj46S4CyTSzLu1gr5Xk=;
        b=ET1SHIG8Xa7836ZxjROkjlYd1iTJQeqJTBsg3QowSHqHZlD4idf8epwA1+1hI7mXkR
         5I2eqVcBovMsn20sspJ5+/F/E21z2/CNvbdrqKEr2MpC4+9G3QrtdW3wLLHaisb2dsof
         Mllb8tQsjTij/wSg7dTRXWOXPyjcW5LyV9w6YdgdbEFdmCjZeNF9nHRhOD+Puk+kxNZr
         s9qUp/QClPnyRrTzvq31w1P4JK+gdRBK9a7y5m89teDpSAjOdEAywuZ9RB9+pvJvyH63
         0/k1KBz/lTm6opYBd8eBuW26rNcBG3JOncc56k/l7dqBptM3400OywdyYjgyMW7YgRjO
         Czbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EUUyZQTfJ6EFFOJHIgPa+9Hxbj46S4CyTSzLu1gr5Xk=;
        b=iarDV6dP1qwP3SnrbfalgVptHdzIikHYdMRgqf3wo+lQpgup0QPcmvK4+lsuu4nsWi
         VvB3tmx92ZWJ/dQFtaB/Njcr68QJf/E1HMw6+HUcvii0nfcFftw34+YwdoNJAKh0hdoT
         QsGlL0s7YNH0cVp6EJPJBaKsZLOIm2/xH6wnpz4+1wHo20EO3Fkdnp8KBE3vS23vBml+
         YlRh4JaMfJIlb0uhSj0L6czbn2/RQa7ixkx+aOMDi27fO7IpsPpmysPqVmoxtA4XPLnb
         eaiX4U3ugqA99x/dNzjh8dA2mTdua8GxK8u4990ZOYBA6/1SV16ntVBk+/2tiN87A2EJ
         mf0Q==
X-Gm-Message-State: AOAM530eiS8fJhNd9TzCaUWT3fo5A4LvqAuXvnw2n7hXMtVygDsEBZs3
        +1IOgZ1g2B50mMp1dILrj2g=
X-Google-Smtp-Source: ABdhPJxAIBTrglJ0Ek6akTRWD1vHwNGEqzQQ7/p4qJT7E3H/L7Ze3/za50jL1cqNzErlW4eEwTpCMQ==
X-Received: by 2002:a17:90a:db97:: with SMTP id h23mr6906914pjv.225.1598848631419;
        Sun, 30 Aug 2020 21:37:11 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.143])
        by smtp.gmail.com with ESMTPSA id i1sm6191890pfo.212.2020.08.30.21.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 21:37:10 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     kvalo@codeaurora.org
Cc:     pkshih@realtek.com, davem@davemloft.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] wireless: rtlwifi/rtw88: fix build warning
Date:   Mon, 31 Aug 2020 10:06:59 +0530
Message-Id: <20200831043659.281712-1-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

 Tasklet conversion patch introduced a build
warning in _rtl_usb_init_rx, this patch fixes the warning.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/net/wireless/realtek/rtlwifi/usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index 8740818e8..6aa4bd2f7 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -310,7 +310,8 @@ static int _rtl_usb_init_rx(struct ieee80211_hw *hw)
 	init_usb_anchor(&rtlusb->rx_cleanup_urbs);
 
 	skb_queue_head_init(&rtlusb->rx_queue);
-	rtlusb->rx_work_tasklet.func = (void(*)(unsigned long))_rtl_rx_work;
+	rtlusb->rx_work_tasklet.func = (void(*))_rtl_rx_work;
+	rtlusb->rx_work_tasklet.data = (unsigned long)&rtlusb->rx_work_tasklet;
 
 	return 0;
 }
-- 
2.25.1

