Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09B57E82DE
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Nov 2023 20:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjKJTkX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Nov 2023 14:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbjKJTjp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Nov 2023 14:39:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2AF28136
        for <linux-wireless@vger.kernel.org>; Fri, 10 Nov 2023 02:22:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F02C433C7;
        Fri, 10 Nov 2023 10:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699611731;
        bh=m1Qw8/vtVY4p1/3aRSjL1MDaqIJS0lXW4t1xxd50gVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h5OioymDllpakzBKbYnzBWdc/VgmmcFiXEAZZSrR818B67Td+0rPM38wF/zFfIqn+
         PCh33PyArwPEa9NHGo0Mk12GlIWKgz9tQCTiLMLiIBMAJHGPK9bHg6GXj0Nq+8tSgj
         EvrJzFJaV8lnA9b+GCMuMFas5Aq6n9cBXFbZ93X7bgtxSdGm4mdp4ND/S7mz8CRcYq
         l4uu6yTvEpg3uzIhflT8s/uLv3cxsK9vQ1JrJtN+ljGYvkUEvUxSUBiuT9p3NGsSgY
         Qi6wdO6Fntdl3D4dXi2FRsP+T8js3F15Q4/sUVXr55/JjY0rD2T1rVGk/K7njEQBji
         JRnYZdP4jQAsA==
From:   Kalle Valo <kvalo@kernel.org>
To:     mhi@lists.linux.dev
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH RFC 5/8] wifi: ath11k: do not dump SRNG statistics during resume
Date:   Fri, 10 Nov 2023 12:21:59 +0200
Message-Id: <20231110102202.3168243-6-kvalo@kernel.org>
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

From: Baochen Qiang <quic_bqiang@quicinc.com>

Both the firmware reset feature and the power management
suspend/resume feature share common power-down and power-up
functionality. One aspect of the power-up functionality is
the handling of the ATH11K_QMI_EVENT_FW_INIT_DONE event.
When this event is received, a call is made to
ath11k_hal_dump_srng_stats(), with the purpose to collect
information that may be useful in debugging the cause of a
firmware reset.

Unfortunately, since this functionality is shared between
both the firmware reset path and the power management
resume path, the kernel log is flooded with messages during
resume. Since these messages are not useful during resume,
and in fact can be confusing and can increase the time it
takes to resume, update the logic to only call
ath11k_hal_dump_srng_stats() during firmware reset.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index c270dc46d506..97a74563d4a6 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -3249,7 +3249,8 @@ static void ath11k_qmi_driver_event_work(struct work_struct *work)
 		case ATH11K_QMI_EVENT_FW_INIT_DONE:
 			clear_bit(ATH11K_FLAG_QMI_FAIL, &ab->dev_flags);
 			if (test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags)) {
-				ath11k_hal_dump_srng_stats(ab);
+				if (ab->is_reset)
+					ath11k_hal_dump_srng_stats(ab);
 				queue_work(ab->workqueue, &ab->restart_work);
 				break;
 			}
-- 
2.39.2

