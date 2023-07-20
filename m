Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E49775B229
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jul 2023 17:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjGTPPH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jul 2023 11:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjGTPOz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jul 2023 11:14:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709322726
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jul 2023 08:14:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE05561B3C
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jul 2023 15:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8836BC433C7;
        Thu, 20 Jul 2023 15:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689866087;
        bh=5ELkPJcjYCzpeSg2TRXcApgBHsHAR6BWhJZznl/8NUM=;
        h=From:To:Cc:Subject:Date:From;
        b=jIzQYvav17pLrACw4dSg/i23Im3FxhkxhJPzDZNYu4KWDuCAE2eRTJX2sdTJheuwx
         NtgrQrr7NpoFxCC33rjPvD7Wh/yNmihFdBP3Z5pDdAGvFONJXbOSeUvLW/dLYbU3yt
         Eh9pqVfwefFMgvs2h9ENc85Qk7Xhh7BDF3BHdsHz5kKwv9vds9c1mswH3fakgTt6Vr
         gGel5Ff8keX6uDVmCsUk0Do7V0HC4nIZycUPkxlhIGVwHBEbCuMDwajTeLwqvO3Bqz
         9bN9Edd/rANVS94XCm54CEuuF792mFVVpahtCdPeH89xKCqmaJfyh1v0jmUl8kRmcF
         C3acxzwMutJCQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v6.5] Revert "wifi: ath11k: Enable threaded NAPI"
Date:   Thu, 20 Jul 2023 18:14:44 +0300
Message-Id: <20230720151444.2016637-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
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

From: Kalle Valo <quic_kvalo@quicinc.com>

This reverts commit 13aa2fb692d3717767303817f35b3e650109add3.

This commit broke QCN9074 initialisation:

[  358.960477] ath11k_pci 0000:04:00.0: ce desc not available for wmi command 36866
[  358.960481] ath11k_pci 0000:04:00.0: failed to send WMI_STA_POWERSAVE_PARAM_CMDID
[  358.960484] ath11k_pci 0000:04:00.0: could not set uapsd params -105

As there's no fix available let's just revert it to get QCN9074 working again.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217536
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c  | 1 -
 drivers/net/wireless/ath/ath11k/pcic.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 1cebba7889d7..139da578831a 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -376,7 +376,6 @@ static void ath11k_ahb_ext_irq_enable(struct ath11k_base *ab)
 		struct ath11k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
 
 		if (!irq_grp->napi_enabled) {
-			dev_set_threaded(&irq_grp->napi_ndev, true);
 			napi_enable(&irq_grp->napi);
 			irq_grp->napi_enabled = true;
 		}
diff --git a/drivers/net/wireless/ath/ath11k/pcic.c b/drivers/net/wireless/ath/ath11k/pcic.c
index c899616fbee4..c63083633b37 100644
--- a/drivers/net/wireless/ath/ath11k/pcic.c
+++ b/drivers/net/wireless/ath/ath11k/pcic.c
@@ -466,7 +466,6 @@ void ath11k_pcic_ext_irq_enable(struct ath11k_base *ab)
 		struct ath11k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
 
 		if (!irq_grp->napi_enabled) {
-			dev_set_threaded(&irq_grp->napi_ndev, true);
 			napi_enable(&irq_grp->napi);
 			irq_grp->napi_enabled = true;
 		}

base-commit: ac528649f7c63bc233cc0d33cff11f767cc666e3
-- 
2.39.2

