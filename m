Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDFE7E801D
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Nov 2023 19:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjKJSHJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Nov 2023 13:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjKJSFE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Nov 2023 13:05:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DF12813A
        for <linux-wireless@vger.kernel.org>; Fri, 10 Nov 2023 02:22:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340EAC433C7;
        Fri, 10 Nov 2023 10:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699611734;
        bh=s8f7ejt6/6A/AIKa6sJs8NlXnpAnYLCNcVR7yofQBJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kWxDiZoqvEUMJIGCjpia9hNLEYYeM7aF+jdw4GLLMl+osG9gI4Q3jz2oHIOJmS/XF
         Xp7enBMvYSeCIHF+uy2nU4QLzycIpA34EJbHV/uPiortko0WsVU64uIza624ZIa7En
         hbcFcvtUbZW17dpg8CAbMytZXk4u/df7Kfr1iyFwSwCtWNSIvOEfp3DzK5EMdyLSvc
         lgz1dSxLCKVDx5NzZ9xIgpG4ExjmdZgY7SYyNo7wSNij3/TK9pYpYONp0iDxZMrlvV
         9bVbceVp6N6ok+5Rj6jv0/6sIi29ZYZxGY1/G7k5s+48qILF9sLa4YiesA3VvIJ3Yd
         Xp5eRN7uKQheg==
From:   Kalle Valo <kvalo@kernel.org>
To:     mhi@lists.linux.dev
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH RFC 7/8] wifi: ath11k: thermal: don't try to register multiple times
Date:   Fri, 10 Nov 2023 12:22:01 +0200
Message-Id: <20231110102202.3168243-8-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231110102202.3168243-1-kvalo@kernel.org>
References: <20231110102202.3168243-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

Every time the firmware boots we call ath11k_core_qmi_firmware_ready() which
ends up calling ath11k_thermal_register(). So we try to register thermal
devices multiple times. And when we power off the firmware during
suspend/hibernation (implemented in the next patch) we get a warning in resume:

hwmon hwmon4: PM: parent phy0 should not be sleeping

Workaround this similarly like ath11k_mac_register() does by testing
ATH11K_FLAG_REGISTERED.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/thermal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/thermal.c b/drivers/net/wireless/ath/ath11k/thermal.c
index c9b012f97ba5..80abf472fb87 100644
--- a/drivers/net/wireless/ath/ath11k/thermal.c
+++ b/drivers/net/wireless/ath/ath11k/thermal.c
@@ -162,6 +162,9 @@ int ath11k_thermal_register(struct ath11k_base *ab)
 	struct ath11k_pdev *pdev;
 	int i, ret;
 
+	if (test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags))
+		return 0;
+
 	for (i = 0; i < ab->num_radios; i++) {
 		pdev = &ab->pdevs[i];
 		ar = pdev->ar;
-- 
2.39.2

