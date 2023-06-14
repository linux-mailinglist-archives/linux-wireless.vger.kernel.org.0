Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F90B72F296
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 04:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjFNCbj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 22:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjFNCbi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 22:31:38 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56D5183
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 19:31:35 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-66577752f05so2349291b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 19:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686709895; x=1689301895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mu/bzW4YDRTXm6cR+TpzVhop9QR2G5AavGdzqjOazgY=;
        b=CIBXFlsyyvLzoDaN7H6E/wd+00XfAF0g9EX9xwNGyTqg6+QxcnIImu7jienSY96tvh
         cHZUIKNO7UactgKINOgq5yLRLr5QbwvRzqF0dD5EaS+lXasnRMshYVDNN71XJjH7cODB
         BSZzuQUB8M/GJRzYV0zhvF4aqQKsHteycngSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686709895; x=1689301895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mu/bzW4YDRTXm6cR+TpzVhop9QR2G5AavGdzqjOazgY=;
        b=iGN+C6AplTX9a2UWngMWqBq4nsOZX8S0gbmvH7JSCraVuIvhsDjBV1+8OM7enCGDQE
         CLnv1rtiOhxDhJY2+BuWbqQeBJyaeLPr1p+5oDqQ8rcx6CSj5AgTjrNme5cpFmrr3PUS
         ChwEygPeeT6aAqCHeQo35LT8VgRLVFOrT/OK5KW6pjA2zHCeuxpxDoEbDBMIK0HBRg4c
         Y7CCMg479hm7H9/KsrqLqViS2qbPtICIC7K4EUzusn48GVcR+UyZ6tAw/WHQUBTXMsWx
         +k8gXZFBI6wsOUYW7v19/m3s+ADsR5CHcKB+63XQPKKX57Li7qFiqVE4Qncvgw3GmS6o
         kMqQ==
X-Gm-Message-State: AC+VfDzi5cCKFM+IUwyDSVa5ek3J7keio8diH6CVAXRYKmZpCHtNhWia
        H9a0poiDmI4DZ/Rcw/xZ9vdXD6L/fVzYIsKZkWc=
X-Google-Smtp-Source: ACHHUZ5Na9d99FoDjfvef6vmvvuaT/Z/e+4nMGfzYxgfLHB3qyMNZ1tx0r0QKI9Sr/Oi2gRpMEI1aw==
X-Received: by 2002:a05:6a20:a10d:b0:111:97f:6db1 with SMTP id q13-20020a056a20a10d00b00111097f6db1mr904632pzk.19.1686709895330;
        Tue, 13 Jun 2023 19:31:35 -0700 (PDT)
Received: from arowa.mtv.corp.google.com ([2620:15c:9d:4:7237:6c0:a6ba:d618])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902968300b001b0266579ebsm10850714plp.194.2023.06.13.19.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 19:31:35 -0700 (PDT)
From:   Arowa Suliman <arowa@chromium.org>
X-Google-Original-From: Arowa Suliman <arowa@google.com>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Arowa Suliman <arowa@google.com>
Subject: [PATCH] wifi: ath11k: Add crash logging
Date:   Tue, 13 Jun 2023 19:29:41 -0700
Message-ID: <20230614023125.284218-1-arowa@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Change crash logging from debug to informational and add warning when
firmware crash MHI_CB_EE_RDDM happens.

Tested-on: Qualcomm WCN6855

Signed-off-by: Arowa Suliman <arowa@google.com>
---
 drivers/net/wireless/ath/ath11k/mhi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index 3ac689f1def4..fb203e7c962b 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -325,7 +325,7 @@ static void ath11k_mhi_op_status_cb(struct mhi_controller *mhi_cntrl,
 {
 	struct ath11k_base *ab = dev_get_drvdata(mhi_cntrl->cntrl_dev);
 
-	ath11k_dbg(ab, ATH11K_DBG_BOOT, "notify status reason %s\n",
+        ath11k_info(ab, ATH11K_DBG_BOOT, "notify status reason %s\n",
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
2.41.0.162.gfafddb0af9-goog

