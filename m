Return-Path: <linux-wireless+bounces-15728-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBC49D9C27
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 18:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA166165255
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 17:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E375D1DD87C;
	Tue, 26 Nov 2024 17:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvbutyJ6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF86D1DD867
	for <linux-wireless@vger.kernel.org>; Tue, 26 Nov 2024 17:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732641110; cv=none; b=L5fex03LQ3Z6AHZgDdcjoYnvNKHGcvNNjSRKDDomLrKHrdZkuhpNrtAOWuO5uOjjC74Ckl10Tv5DUT/PSnn23k76gckNoAS+sljkUgigtluzxpx9Zh7QMSe5KZsc2N7UkegODObzr6rmyoADXOsfuX45xuQWmwM7XXZd0rqWRnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732641110; c=relaxed/simple;
	bh=QXKNn6DEEbGV9PpSiHhKXFby5Khi/rrcLUVwoxW4ylw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tigTIJKds4tpirM2oxVtQshvPk3vVZ3N7MPrCor82xiVTVffSIDMExbd2x3wSk/94WjNtzrMZQWOoBSfwt3dyjaEOqbOGlAiQnGXtfkkAj6TpMvWGgjpCXZvtPt7PwV86PKSdZdNssjNwY952EHWI6P7VdvchzO5ZWJCj20+v6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvbutyJ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208A3C4CECF;
	Tue, 26 Nov 2024 17:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732641110;
	bh=QXKNn6DEEbGV9PpSiHhKXFby5Khi/rrcLUVwoxW4ylw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hvbutyJ6elbTPxLkxB9r/r0S1We5A4TKYQsL/p95Pg02A/dz9H9gjZ180S0hMXh1o
	 14cg7SyBxvWQcNYpFeOk2LRPnFZpYDL2feXzCrfVmOZfx6HhLuqyQz0lrq/exco0n5
	 dVLMVCgX+qpE7mod7vaQ0Vte1CQJ0r5Qlo6gkKwDAcZf4pSE42xDtvyMbvqCoGdC7v
	 byggfvcHj9FJ0XA4fLR9VEo3CMl/OgPN6jTfm3BjvM57lY0Uceyc/4EBQHTtU39/Z4
	 iKpntKfAP1Wk7diJ2+ClDahQDID1uqvbiZGSjianlrR4NNI1Abs/QMNOvHIcHe9q/h
	 wLjoRoe4wYL5g==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 08/10] wifi: ath12k: defer vdev creation for MLO
Date: Tue, 26 Nov 2024 19:11:37 +0200
Message-Id: <20241126171139.2350704-9-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241126171139.2350704-1-kvalo@kernel.org>
References: <20241126171139.2350704-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rameshkumar Sundaram <quic_ramess@quicinc.com>

Currently for single radio devices (ah->num_radio == 1)
ath12k_mac_op_add_interface() creates vdev and later hw scan and
assign_vif_chanctx uses the same. For MLO, vdev create request should carry ML
address which will not be known during ath12k_mac_op_add_interface() as vif
will be marked as ML only after links are added to it.

If hw scan is requested, the vdev will be deleted post hw scan and subsequent
assign_vif_chanctx call will create new vdev with ML address. But in certain
cases assign_vif_chanctx could be called without any prior hw scan request and
reusing the previously created vdev causes a non-ML vdev to be used for an ML
vif and firmware operates the vdev in non-ML mode.

Fix this by deferring vdev creation for interface until hw scan or
assign_vif_chanctx request is received from mac80211.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 364e9c6adc73..f85661534d9e 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -8131,14 +8131,9 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 		vif->hw_queue[i] = ATH12K_HW_DEFAULT_QUEUE;
 
 	vif->driver_flags |= IEEE80211_VIF_SUPPORTS_UAPSD;
-	/* For non-ml vifs, vif->addr is the actual vdev address but for
-	 * ML vif link(link BSSID) address is the vdev address and it can be a
-	 * different one from vif->addr (i.e ML address).
-	 * Defer vdev creation until assign_chanctx or hw_scan is initiated as driver
+	/* Defer vdev creation until assign_chanctx or hw_scan is initiated as driver
 	 * will not know if this interface is an ML vif at this point.
 	 */
-	ath12k_mac_assign_vif_to_vdev(hw, arvif, NULL);
-
 	return 0;
 }
 
-- 
2.39.5


