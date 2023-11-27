Return-Path: <linux-wireless+bounces-110-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF28A7FA630
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 17:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A72D2812C8
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 16:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5C937152;
	Mon, 27 Nov 2023 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmNRLMZ5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBAB36B08;
	Mon, 27 Nov 2023 16:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EDDC433C7;
	Mon, 27 Nov 2023 16:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701102029;
	bh=5ou17yiktRU9nagkHXi6c6F9I8XPQs9jzQuZICUzCw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fmNRLMZ5HHgeTI8q/E817rmKIoEht8FTlg3XPowTCpn+Aqp9X6RovHciR3ym0hdkf
	 2kvL6tBOjz1VdFmc9rFzlpjMwou/5x0UH7lQhwF8MqSSRpvUTuxKJzR09EH/GeTOOx
	 86dH+C9ktuAG5mPk3SDFYci7U91ipp2C6NrtnwRLDCzVurQ6DN+v3EJ/Y/MkxGOGzx
	 E1N5SUmDiNF8glr8RoGzWR6wbQi6yTIKX42/xg4nKhCp3Qvqnmr1jh78oAcyaZj4Qe
	 hSZi6AnZRcCIcj5LKNINcjze5Bcoc/qrv2BTpnEnIM+MCltRMyQVNyvpHspXn5ii2B
	 xyWYUZkzAf1xg==
From: Kalle Valo <kvalo@kernel.org>
To: mhi@lists.linux.dev
Cc: ath11k@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH RFC v2 3/8] wifi: ath11k: handle irq enable/disable in several code path
Date: Mon, 27 Nov 2023 18:20:17 +0200
Message-Id: <20231127162022.518834-4-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231127162022.518834-1-kvalo@kernel.org>
References: <20231127162022.518834-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Baochen Qiang <quic_bqiang@quicinc.com>

For non WoW suspend/resume, ath11k host powers down whole hardware
when suspend and power up it when resume, the code path it goes
through is very like the ath11k reset logic.

In order to reuse that logic, do some IRQ management work to make
it work.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 0c6ecbb9a066..fbd6b6a0e12c 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -852,9 +852,6 @@ int ath11k_core_resume(struct ath11k_base *ab)
 		return ret;
 	}
 
-	ath11k_hif_ce_irq_enable(ab);
-	ath11k_hif_irq_enable(ab);
-
 	ret = ath11k_dp_rx_pktlog_start(ab);
 	if (ret) {
 		ath11k_warn(ab, "failed to start rx pktlog during resume: %d\n",
@@ -1775,10 +1772,9 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
 
 	mutex_lock(&ab->core_lock);
 	ath11k_thermal_unregister(ab);
-	ath11k_hif_irq_disable(ab);
 	ath11k_dp_pdev_free(ab);
 	ath11k_spectral_deinit(ab);
-	ath11k_hif_stop(ab);
+	ath11k_ce_cleanup_pipes(ab);
 	ath11k_wmi_detach(ab);
 	ath11k_dp_pdev_reo_cleanup(ab);
 	mutex_unlock(&ab->core_lock);
@@ -2033,8 +2029,8 @@ static void ath11k_core_reset(struct work_struct *work)
 	time_left = wait_for_completion_timeout(&ab->recovery_start,
 						ATH11K_RECOVER_START_TIMEOUT_HZ);
 
-	ath11k_hif_power_down(ab);
-	ath11k_hif_power_up(ab);
+	ath11k_hif_irq_disable(ab);
+	ath11k_hif_ce_irq_disable(ab);
 
 	ath11k_dbg(ab, ATH11K_DBG_BOOT, "reset started\n");
 }
-- 
2.39.2


