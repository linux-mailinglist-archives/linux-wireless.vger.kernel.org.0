Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBEF752E29
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jul 2023 02:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjGNALg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jul 2023 20:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjGNALg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jul 2023 20:11:36 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6018526AF
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jul 2023 17:11:34 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b895a06484so8196235ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jul 2023 17:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689293494; x=1691885494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5vqUOvUXa8K5Wx+m88RxVlwrv8R/El1ZGP9GFTtwjCI=;
        b=W5MkhmHGhYTWevAnklGe1SJrBEc4X86lBc5Bt+8KOBXcZkq7R6Cx+JcbVv9i/q48n4
         WD/oisoaO0vnhgPjsp2DFBOfj+qrTSqSkBCX1am4CqVzeIk/eEM1+60lInYo8I55uQDO
         TBVZ8TEgF1B+ulcfQTP8Eiqf3zonk3AAXhyuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689293494; x=1691885494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5vqUOvUXa8K5Wx+m88RxVlwrv8R/El1ZGP9GFTtwjCI=;
        b=V+H2l1nLQWTbOMsuGMfF3BViELlZGGu6U6trznnnnWtwrdDxMPnzCmq/o2XyvjKrU0
         7A16OviD0O962hg8qZLwvG8N+9QjgycHgOhED74olIzGTccM1l/DDtwyD2DKjQjSZ1+N
         EHzzOOdTi4Eadrw5R5lc8eh40zOpzFS/sg193IxB9Ag39qoW2Ylrx5UMP41K+m+sBpMM
         A265K2VVEVpMPBLljNGn3Q6fiiK04PWR7VRIADHbW5rn3wfEMpHRt7Ag6ZJFUWmcTjdR
         Gjfu/KM1uHc33MzujdRknBXDW9rW1ETLEpbMGr2dHctYVdUcnzYFFbewbYU99xVo+1cs
         7qzw==
X-Gm-Message-State: ABy/qLYt928CAFta0/wt2cVuy4s1hiJl2LEZppBaKpRFrWiQZA/gPOdV
        glfJZf38QMXqlmiROupm31HjOg==
X-Google-Smtp-Source: APBJJlENggqfPIe1kAkA+PQdxXbJ5uO5HJuxYrC+uu2Rnd73CEg/zX2p1g9IRDhdCcV6yQj8/SaiFw==
X-Received: by 2002:a17:902:c40f:b0:1ac:63ac:10a7 with SMTP id k15-20020a170902c40f00b001ac63ac10a7mr2825431plk.68.1689293493801;
        Thu, 13 Jul 2023 17:11:33 -0700 (PDT)
Received: from arowa.mtv.corp.google.com ([2620:15c:9d:4:752b:86eb:10d6:65b4])
        by smtp.gmail.com with ESMTPSA id 20-20020a170902ee5400b001b81a97860asm6444207plo.27.2023.07.13.17.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 17:11:33 -0700 (PDT)
From:   Arowa Suliman <arowa@chromium.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Arowa Suliman <arowa@chromium.org>
Subject: [v4] wifi: ath11k: Add crash logging
Date:   Thu, 13 Jul 2023 17:10:54 -0700
Message-ID: <20230714001126.463127-1-arowa@chromium.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, the ath11k driver does not print a crash signature when a
crash happens. Checked by triggering a simulated crash using the command
[1] and checking dmesg for logs.

[1] echo assert > /sys/kernel/debug/ath11k/../simulate_fw_crash

Change the crash logging from debug to informational and add a warning
when firmware crash MHI_CB_EE_RDDM happens.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Arowa Suliman <arowa@chromium.org>
---
v4:
Shift line 329 one space to the right to fix code alignment.
---
 drivers/net/wireless/ath/ath11k/mhi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index 3ac689f1def4..025fa58b1503 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -325,14 +325,15 @@ static void ath11k_mhi_op_status_cb(struct mhi_controller *mhi_cntrl,
 {
 	struct ath11k_base *ab = dev_get_drvdata(mhi_cntrl->cntrl_dev);
 
-	ath11k_dbg(ab, ATH11K_DBG_BOOT, "notify status reason %s\n",
-		   ath11k_mhi_op_callback_to_str(cb));
+	ath11k_info(ab, "notify status reason %s\n",
+		    ath11k_mhi_op_callback_to_str(cb));
 
 	switch (cb) {
 	case MHI_CB_SYS_ERROR:
 		ath11k_warn(ab, "firmware crashed: MHI_CB_SYS_ERROR\n");
 		break;
 	case MHI_CB_EE_RDDM:
+		ath11k_warn(ab, "firmware crashed: MHI_CB_EE_RDDM\n");
 		if (!(test_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags)))
 			queue_work(ab->workqueue_aux, &ab->reset_work);
 		break;
-- 
2.41.0.255.g8b1d071c50-goog

