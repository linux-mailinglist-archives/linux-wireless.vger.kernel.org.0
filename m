Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371B97E3F66
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Nov 2023 13:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbjKGM5U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Nov 2023 07:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbjKGM4t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Nov 2023 07:56:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DA44EC7;
        Tue,  7 Nov 2023 04:13:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37763C433CA;
        Tue,  7 Nov 2023 12:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359191;
        bh=auizaxjZWo181eTIjXWSFYxTaHqzBhVli8xUWRJcofo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X45mnEXxxxgx3DZ9EgCxqKnhehn+l9aKJcVLztuZQW3zai+qQfdP/fIvPwIxyRLJP
         DOXtllbE2zAKy1jFEh3D8I5mMAzUPC6fHZRqmkjbLijGiqqEordeaVogja2Lk36SEU
         XI9KLcXpfxqpoJmEIxL0ojNP5wiBs1KDY3LKEqWBS+r9+kLgrHzQYtnkIWvlPozvIe
         1AjkZVgS8brVaYAVuDWUNoWHnRmwIXtCkH7YeHNZxhvB4Pr+VvOFsdrJKxprWUHjfm
         cc7YFa5vVCmSjQcKRisAksPndVXnxQnnvOqAPDXx1Y46Ivw/ky7wLH9O1Jn8mgamnr
         OW7/izF9YOOjw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        quic_jjohnson@quicinc.com, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 7/9] wifi: ath10k: Don't touch the CE interrupt registers after power up
Date:   Tue,  7 Nov 2023 07:12:50 -0500
Message-ID: <20231107121256.3758858-7-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107121256.3758858-1-sashal@kernel.org>
References: <20231107121256.3758858-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.259
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

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 170c75d43a77dc937c58f07ecf847ba1b42ab74e ]

As talked about in commit d66d24ac300c ("ath10k: Keep track of which
interrupts fired, don't poll them"), if we access the copy engine
register at a bad time then ath10k can go boom. However, it's not
necessarily easy to know when it's safe to access them.

The ChromeOS test labs saw a crash that looked like this at
shutdown/reboot time (on a chromeos-5.15 kernel, but likely the
problem could also reproduce upstream):

Internal error: synchronous external abort: 96000010 [#1] PREEMPT SMP
...
CPU: 4 PID: 6168 Comm: reboot Not tainted 5.15.111-lockdep-19350-g1d624fe6758f #1 010b9b233ab055c27c6dc88efb0be2f4e9e86f51
Hardware name: Google Kingoftown (DT)
...
pc : ath10k_snoc_read32+0x50/0x74 [ath10k_snoc]
lr : ath10k_snoc_read32+0x24/0x74 [ath10k_snoc]
...
Call trace:
ath10k_snoc_read32+0x50/0x74 [ath10k_snoc ...]
ath10k_ce_disable_interrupt+0x190/0x65c [ath10k_core ...]
ath10k_ce_disable_interrupts+0x8c/0x120 [ath10k_core ...]
ath10k_snoc_hif_stop+0x78/0x660 [ath10k_snoc ...]
ath10k_core_stop+0x13c/0x1ec [ath10k_core ...]
ath10k_halt+0x398/0x5b0 [ath10k_core ...]
ath10k_stop+0xfc/0x1a8 [ath10k_core ...]
drv_stop+0x148/0x6b4 [mac80211 ...]
ieee80211_stop_device+0x70/0x80 [mac80211 ...]
ieee80211_do_stop+0x10d8/0x15b0 [mac80211 ...]
ieee80211_stop+0x144/0x1a0 [mac80211 ...]
__dev_close_many+0x1e8/0x2c0
dev_close_many+0x198/0x33c
dev_close+0x140/0x210
cfg80211_shutdown_all_interfaces+0xc8/0x1e0 [cfg80211 ...]
ieee80211_remove_interfaces+0x118/0x5c4 [mac80211 ...]
ieee80211_unregister_hw+0x64/0x1f4 [mac80211 ...]
ath10k_mac_unregister+0x4c/0xf0 [ath10k_core ...]
ath10k_core_unregister+0x80/0xb0 [ath10k_core ...]
ath10k_snoc_free_resources+0xb8/0x1ec [ath10k_snoc ...]
ath10k_snoc_shutdown+0x98/0xd0 [ath10k_snoc ...]
platform_shutdown+0x7c/0xa0
device_shutdown+0x3e0/0x58c
kernel_restart_prepare+0x68/0xa0
kernel_restart+0x28/0x7c

Though there's no known way to reproduce the problem, it makes sense
that it would be the same issue where we're trying to access copy
engine registers when it's not allowed.

Let's fix this by changing how we "disable" the interrupts. Instead of
tweaking the copy engine registers we'll just use disable_irq() and
enable_irq(). Then we'll configure the interrupts once at power up
time.

Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230630151842.1.If764ede23c4e09a43a842771c2ddf99608f25f8e@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/snoc.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index b6762fe2efe26..29d52f7b4336d 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -821,12 +821,20 @@ static void ath10k_snoc_hif_get_default_pipe(struct ath10k *ar,
 
 static inline void ath10k_snoc_irq_disable(struct ath10k *ar)
 {
-	ath10k_ce_disable_interrupts(ar);
+	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
+	int id;
+
+	for (id = 0; id < CE_COUNT_MAX; id++)
+		disable_irq(ar_snoc->ce_irqs[id].irq_line);
 }
 
 static inline void ath10k_snoc_irq_enable(struct ath10k *ar)
 {
-	ath10k_ce_enable_interrupts(ar);
+	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
+	int id;
+
+	for (id = 0; id < CE_COUNT_MAX; id++)
+		enable_irq(ar_snoc->ce_irqs[id].irq_line);
 }
 
 static void ath10k_snoc_rx_pipe_cleanup(struct ath10k_snoc_pipe *snoc_pipe)
@@ -1042,6 +1050,8 @@ static int ath10k_snoc_hif_power_up(struct ath10k *ar,
 		goto err_free_rri;
 	}
 
+	ath10k_ce_enable_interrupts(ar);
+
 	return 0;
 
 err_free_rri:
@@ -1196,8 +1206,8 @@ static int ath10k_snoc_request_irq(struct ath10k *ar)
 
 	for (id = 0; id < CE_COUNT_MAX; id++) {
 		ret = request_irq(ar_snoc->ce_irqs[id].irq_line,
-				  ath10k_snoc_per_engine_handler, 0,
-				  ce_name[id], ar);
+				  ath10k_snoc_per_engine_handler,
+				  IRQF_NO_AUTOEN, ce_name[id], ar);
 		if (ret) {
 			ath10k_err(ar,
 				   "failed to register IRQ handler for CE %d: %d",
-- 
2.42.0

