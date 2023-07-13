Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB00751536
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jul 2023 02:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjGMAYC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jul 2023 20:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjGMAXa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jul 2023 20:23:30 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FCC10EC
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jul 2023 17:23:28 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-666eba6f3d6so96632b3a.3
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jul 2023 17:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689207808; x=1691799808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sT4EPf3iKpEGqJ9z73dP6QmwaakqTzng8UdClO0Piew=;
        b=aRIYCxnqUBaRxyMH1DBKp/8X4qC1atHIh1r2/LHdWve6SewdPZoLngvOxRUYaIPykF
         vEvFITAIPdtjiZ9Z8oF90zWyqEle5fM1PhH5EyETF+eyjgqZqBVGBqgOtvzpxzHpM6lQ
         gJmpOcFz+vYnoQlDsXpmzjRTuCgYXk4ZwK+/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689207808; x=1691799808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sT4EPf3iKpEGqJ9z73dP6QmwaakqTzng8UdClO0Piew=;
        b=Zv7Zb90JCfhfz0msozDIAvozCDpp6X5+sysl1MgBMP2fnX+2gUbGSyIhstswswslDV
         RWhguptiB7n47dP3UaTD559wdlzNax7MzI/iBIqbX/Z2F74eX+c0r8pWVAeFMlccaK1D
         QTKUMh2D2HlP+8FeudvU+hmkjFTN26dVxVN+JeMa3ayivME6szp7NHEj3jFDxSer8REA
         kADM3gINCDE5zGVP0QIYCz9ZTXF4S8smoM4ykpeZnoUvzi53joxBgi40VgYMMsv2qBsU
         g1yb9uM/ixBU8aOJHXbr1yYy5PozMStus7aGEnrlQftUUhtIKm9FO3s1DKlg0Nk91zi7
         D4/w==
X-Gm-Message-State: ABy/qLZQi/PMxy1Oh5oPVKuNuLBHcPPXWiLWg+wuiAm3PoOo/3M+sliy
        Fj+DBQwaFfuEdipVqnHO3NqZJQ==
X-Google-Smtp-Source: APBJJlGKjZCgdVN17RxPtjOTfMluNOyGQtpx6cSkveJ3gQkvS7LPdpApIOmQefFMYURTDvN7ZXUL0w==
X-Received: by 2002:a05:6a00:1399:b0:681:ee3c:c5fe with SMTP id t25-20020a056a00139900b00681ee3cc5femr162644pfg.33.1689207808438;
        Wed, 12 Jul 2023 17:23:28 -0700 (PDT)
Received: from arowa.mtv.corp.google.com ([2620:15c:9d:4:7744:239:e1aa:a886])
        by smtp.gmail.com with ESMTPSA id s4-20020aa78284000000b0066883d75932sm4143886pfm.204.2023.07.12.17.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 17:23:28 -0700 (PDT)
From:   Arowa Suliman <arowa@chromium.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Arowa Suliman <arowa@chromium.org>
Subject: [v3] wifi: ath11k: Add crash logging
Date:   Wed, 12 Jul 2023 17:22:18 -0700
Message-ID: <20230713002319.4057612-1-arowa@chromium.org>
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

Currently, the ath11k driver does not print a crash signature when a
crash happens. Checked by triggering a simulated crash using the command
[1] and checking dmesg for logs.

[1] echo assert > /sys/kernel/debug/ath11k/../simulate_fw_crash

Change the crash logging from debug to informational and add a warning
when firmware crash MHI_CB_EE_RDDM happens.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Arowa Suliman <arowa@chromium.org>
---
v3:
1- Fixed the error:
drivers/net/wireless/ath/ath11k/mhi.c:328:25: warning: passing argument 2 of 'ath11k_info' makes pointer from integer without a cast [-Wint-conversion]
2- Removed extra spaces in lines 329 and 338
3- Updated commit message with correct Tested-on flag and the reason of
the change.
---
 drivers/net/wireless/ath/ath11k/mhi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index 3ac689f1def4..d9783c2e0529 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -325,7 +325,7 @@ static void ath11k_mhi_op_status_cb(struct mhi_controller *mhi_cntrl,
 {
 	struct ath11k_base *ab = dev_get_drvdata(mhi_cntrl->cntrl_dev);
 
-	ath11k_dbg(ab, ATH11K_DBG_BOOT, "notify status reason %s\n",
+	ath11k_info(ab, "notify status reason %s\n",
 		   ath11k_mhi_op_callback_to_str(cb));
 
 	switch (cb) {
@@ -333,6 +333,7 @@ static void ath11k_mhi_op_status_cb(struct mhi_controller *mhi_cntrl,
 		ath11k_warn(ab, "firmware crashed: MHI_CB_SYS_ERROR\n");
 		break;
 	case MHI_CB_EE_RDDM:
+		ath11k_warn(ab, "firmware crashed: MHI_CB_EE_RDDM\n");
 		if (!(test_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags)))
 			queue_work(ab->workqueue_aux, &ab->reset_work);
 		break;
-- 
2.41.0.255.g8b1d071c50-goog

