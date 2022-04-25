Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FA250D6E5
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Apr 2022 04:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240342AbiDYCTh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Apr 2022 22:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240334AbiDYCTf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Apr 2022 22:19:35 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67B620F41
        for <linux-wireless@vger.kernel.org>; Sun, 24 Apr 2022 19:16:32 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id a15so13498350pfv.11
        for <linux-wireless@vger.kernel.org>; Sun, 24 Apr 2022 19:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BCvRbfY9AY8AC9ZZ4kIqd8KxfaWph2WE28jsNloDkNo=;
        b=bvEQjxzyL4c2fT2DnGXRluO3JlDakD1pr4ct/Oj1rhEKU0h0xK4vp2/hKdgirqasfi
         YrxMolOUmz0/ry+zwaLGvOyGDsGrcpsxlqv31Yvtw0AadrQFmU+CrSInRYcZGS7t1MCA
         pUjZc532hjTq8RuyEL2V0hZTEtQ2QsFhwkJ8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BCvRbfY9AY8AC9ZZ4kIqd8KxfaWph2WE28jsNloDkNo=;
        b=g51+Ztt6mMRCJQb0001+XOACAhvv/5RvohF6lcSqvOj96/eJ3EnJ0vBrpLNuuvWhF6
         V2Rv3PYo1zOarMky5XZOSglEalL0lFINoJYk9HsXyJDnIWKZHSeehe5Zu0D5dKNP6dXM
         LDlbyrxOtHO0podnw45EEIQgY3Lf47Ij0BAQMPtR+BH2Wc3BiwPQ3uLvBozIKRDQ+0t/
         /4I3cw1PEQkV2YRJoleyRhVYvSLeJsP9OJYO39ZgHcm1yfe2yprg2JDLweDmM/gu3q7j
         L7sKeiHLQgwVvh3bdEBof33vqwcWjV2KedlkPXT5e1eLrC37bR19rO0Xluho3jUDVXKL
         K+AA==
X-Gm-Message-State: AOAM531N8+T1y8sqS5TS9smaNFsCJoVtf7DRcwYfGMDnlnOvtC/lf44h
        cMwui6jijlXtmrRzo3FtAjqN2f6rSeC3tw==
X-Google-Smtp-Source: ABdhPJz+Lqt/5YHu1T8zZ7aSkhCOKNwOQpNhJB13OiOixsB8dYE1h/KUbUhhMbHmd62v9xmy5wYPHw==
X-Received: by 2002:a05:6a00:188c:b0:50d:167f:1b62 with SMTP id x12-20020a056a00188c00b0050d167f1b62mr10288126pfh.49.1650852992140;
        Sun, 24 Apr 2022 19:16:32 -0700 (PDT)
Received: from kuabhs-cdev.c.googlers.com.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090ade0100b001cb3feaddfcsm10918299pjv.2.2022.04.24.19.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 19:16:31 -0700 (PDT)
From:   Abhishek Kumar <kuabhs@chromium.org>
To:     kvalo@kernel.org
Cc:     kuabhs@chromium.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, briannorris@chromium.org,
        ath10k@lists.infradead.org, netdev@vger.kernel.org,
        Wen Gong <quic_wgong@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] ath10k: skip ath10k_halt during suspend for driver state RESTARTING
Date:   Mon, 25 Apr 2022 02:15:20 +0000
Message-Id: <20220425021442.1.I650b809482e1af8d0156ed88b5dc2677a0711d46@changeid>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Double free crash is observed when FW recovery(caused by wmi
timeout/crash) is followed by immediate suspend event. The FW recovery
is triggered by ath10k_core_restart() which calls driver clean up via
ath10k_halt(). When the suspend event occurs between the FW recovery,
the restart worker thread is put into frozen state until suspend completes.
The suspend event triggers ath10k_stop() which again triggers ath10k_halt()
The double invocation of ath10k_halt() causes ath10k_htt_rx_free() to be
called twice(Note: ath10k_htt_rx_alloc was not called by restart worker
thread because of its frozen state), causing the crash.

To fix this, during the suspend flow, skip call to ath10k_halt() in
ath10k_stop() when the current driver state is ATH10K_STATE_RESTARTING.
Also, for driver state ATH10K_STATE_RESTARTING, call
ath10k_wait_for_suspend() in ath10k_stop(). This is because call to
ath10k_wait_for_suspend() is skipped later in
[ath10k_halt() > ath10k_core_stop()] for the driver state
ATH10K_STATE_RESTARTING.

The frozen restart worker thread will be cancelled during resume when the
device comes out of suspend.

Below is the crash stack for reference:

[  428.469167] ------------[ cut here ]------------
[  428.469180] kernel BUG at mm/slub.c:4150!
[  428.469193] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[  428.469219] Workqueue: events_unbound async_run_entry_fn
[  428.469230] RIP: 0010:kfree+0x319/0x31b
[  428.469241] RSP: 0018:ffffa1fac015fc30 EFLAGS: 00010246
[  428.469247] RAX: ffffedb10419d108 RBX: ffff8c05262b0000
[  428.469252] RDX: ffff8c04a8c07000 RSI: 0000000000000000
[  428.469256] RBP: ffffa1fac015fc78 R08: 0000000000000000
[  428.469276] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  428.469285] Call Trace:
[  428.469295]  ? dma_free_attrs+0x5f/0x7d
[  428.469320]  ath10k_core_stop+0x5b/0x6f
[  428.469336]  ath10k_halt+0x126/0x177
[  428.469352]  ath10k_stop+0x41/0x7e
[  428.469387]  drv_stop+0x88/0x10e
[  428.469410]  __ieee80211_suspend+0x297/0x411
[  428.469441]  rdev_suspend+0x6e/0xd0
[  428.469462]  wiphy_suspend+0xb1/0x105
[  428.469483]  ? name_show+0x2d/0x2d
[  428.469490]  dpm_run_callback+0x8c/0x126
[  428.469511]  ? name_show+0x2d/0x2d
[  428.469517]  __device_suspend+0x2e7/0x41b
[  428.469523]  async_suspend+0x1f/0x93
[  428.469529]  async_run_entry_fn+0x3d/0xd1
[  428.469535]  process_one_work+0x1b1/0x329
[  428.469541]  worker_thread+0x213/0x372
[  428.469547]  kthread+0x150/0x15f
[  428.469552]  ? pr_cont_work+0x58/0x58
[  428.469558]  ? kthread_blkcg+0x31/0x31

Signed-off-by: Abhishek Kumar <kuabhs@chromium.org>
Co-developed-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---

 drivers/net/wireless/ath/ath10k/mac.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index d804e19a742a..57ba27c46371 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -5345,8 +5345,22 @@ static void ath10k_stop(struct ieee80211_hw *hw)
 
 	mutex_lock(&ar->conf_mutex);
 	if (ar->state != ATH10K_STATE_OFF) {
-		if (!ar->hw_rfkill_on)
-			ath10k_halt(ar);
+		if (!ar->hw_rfkill_on) {
+			/* If the current driver state is RESTARTING but not yet
+			 * fully RESTARTED because of incoming suspend event,
+			 * then ath11k_halt is already called via
+			 * ath10k_core_restart and should not be called here.
+			 */
+			if (ar->state != ATH10K_STATE_RESTARTING)
+				ath10k_halt(ar);
+			else
+				/* Suspending here, because when in RESTARTING
+				 * state, ath11k_core_stop skips
+				 * ath10k_wait_for_suspend.
+				 */
+				ath10k_wait_for_suspend(ar,
+							WMI_PDEV_SUSPEND_AND_DISABLE_INTR);
+		}
 		ar->state = ATH10K_STATE_OFF;
 	}
 	mutex_unlock(&ar->conf_mutex);
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

