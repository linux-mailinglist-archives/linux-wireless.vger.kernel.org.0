Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB9F74E1CD
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jul 2023 01:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjGJXGD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Jul 2023 19:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjGJXGA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Jul 2023 19:06:00 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2545F10D
        for <linux-wireless@vger.kernel.org>; Mon, 10 Jul 2023 16:05:59 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1b3f281c4e1so4720470fac.3
        for <linux-wireless@vger.kernel.org>; Mon, 10 Jul 2023 16:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689030358; x=1691622358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3kdB0Zjv6MHxg1jrCOxa5nOK7H6uTbKe8bxREOoXZ/8=;
        b=KD7av0sNv+y/rnfGiRqoMlQj57lQXBoY7teeOYOH9jC4tLFy7ZNa09c8VdwrwZwGxK
         Yaw+BPsT5QOaMdw3APWhed+lAsBHPdJe8XP6D0ofn4Gtpgar32OZtgNVL6c5w7961h7v
         dBC0DTfESJabyowoDk8ib4+fJR3xG5WPA6lNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689030358; x=1691622358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3kdB0Zjv6MHxg1jrCOxa5nOK7H6uTbKe8bxREOoXZ/8=;
        b=DQKWhfs9i2HuxZg69qfcUtwxyDSFotU62ZrJHdQMlpxlFliraolX7mXCWPkKDmcm9d
         9OiCQVAAPV/fP+Q2WgiDVjddkw9T4UXiYH78WFOQ0gOWgFt4/XGlZIHaQbsMCSWWdiZ4
         3zsC1OJr3LtklSK7MmZYebaN8QH8llph108EpT2nyriDNN95SqePBB7pE/UdNGuAulPy
         06PNQV0ezGhpYN8PE3NxXqmHfTzb5bAk7tmIJH+3hqqXK7F4PsMj4vKsE1dVBJxLumCq
         D/CM8UGX0ZsoW2c66mQNdrWp43acV1EDmuip73sGx89t32UHe0ZvolvkIgc5zmPzt/nC
         SWJA==
X-Gm-Message-State: ABy/qLZJ9lsYyifmXz1/y1eD6vhEYx6A+4yevFNaOsUjz87mezVpZvul
        vqOfovhc3/kJ39441uQbokQmeg==
X-Google-Smtp-Source: APBJJlFsyIeItqeqTbyIX7LVYMFdu4mDKSTHQBbMvpo3712AvbnzfW0w5FdFkj5sXvtKxzvfbKv+kQ==
X-Received: by 2002:a05:6871:60c:b0:1b7:15ac:ab9c with SMTP id w12-20020a056871060c00b001b715acab9cmr7269757oan.36.1689030358074;
        Mon, 10 Jul 2023 16:05:58 -0700 (PDT)
Received: from arowa.mtv.corp.google.com ([2620:15c:9d:4:816b:4512:ab1f:a663])
        by smtp.gmail.com with ESMTPSA id z20-20020a17090ab11400b00263e1db8460sm6768947pjq.9.2023.07.10.16.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 16:05:57 -0700 (PDT)
From:   Arowa Suliman <arowa@chromium.org>
X-Google-Original-From: Arowa Suliman <arowa@google.com>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Arowa Suliman <arowa@google.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] wifi: ath11k: Add crash logging
Date:   Mon, 10 Jul 2023 16:04:53 -0700
Message-ID: <20230710230546.3544912-1-arowa@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Change crash logging from debug to informational and add warning when
firmware crash MHI_CB_EE_RDDM happens.

Tested-on: Qualcomm WCN6855
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306141105.c1e82Q0y-lkp@intel.com/
Signed-off-by: Arowa Suliman <arowa@google.com>
---
 drivers/net/wireless/ath/ath11k/mhi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index 3ac689f1def4..5db4b61c1cba 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -325,7 +325,7 @@ static void ath11k_mhi_op_status_cb(struct mhi_controller *mhi_cntrl,
 {
 	struct ath11k_base *ab = dev_get_drvdata(mhi_cntrl->cntrl_dev);
 
-	ath11k_dbg(ab, ATH11K_DBG_BOOT, "notify status reason %s\n",
+        ath11k_info(ab, "notify status reason %s\n",
 		   ath11k_mhi_op_callback_to_str(cb));
 
 	switch (cb) {
@@ -333,7 +333,8 @@ static void ath11k_mhi_op_status_cb(struct mhi_controller *mhi_cntrl,
 		ath11k_warn(ab, "firmware crashed: MHI_CB_SYS_ERROR\n");
 		break;
 	case MHI_CB_EE_RDDM:
-		if (!(test_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags)))
+		ath11k_warn(ab, "firmware crashed: MHI_CB_EE_RDDM\n");
+                if (!(test_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags)))
 			queue_work(ab->workqueue_aux, &ab->reset_work);
 		break;
 	default:
-- 
2.41.0.255.g8b1d071c50-goog

