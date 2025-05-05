Return-Path: <linux-wireless+bounces-22572-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CAAAAAEFB
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 05:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ABE53AFEA3
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 03:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A30C2F15C4;
	Mon,  5 May 2025 23:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="soYu2KYe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C228F2DCB4C;
	Mon,  5 May 2025 23:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486071; cv=none; b=t3L2iEUqyR6yV8QQKNtOf0bAyLnwTBT5+2qFq+r/MoY+ncoJb/xWFVH0f5daL7O/pkql0RRRFIvacuRqY3zKjMxSfkf2S2/wB0Yb/PpZUdsa7GACNmq1m8Qu3jMfJrUvwjiiYNuQN3We0rhXDeUXzv+6+BwNhRJPRBYYa2Plf5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486071; c=relaxed/simple;
	bh=CIOyiHhIcQe3oubqf8zVbmf/WHGd27a2psRoGPh9+r4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dGxW4U4nI/wY9N/Kr9FtpkGIBCAzT/Oxtavenir5SC/gmG1Z4yFoiiIofzIL0aJGNVMN7mkf7HncFZBlgnyZIcRU0MLOKp12Z6YXz/OgNQs7mTnHEozpR/PI8XvL55t6h4R76InIrJlbNJFvZmzNfSoF0E/WnXbjZKW6UfrGYA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=soYu2KYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288B7C4CEEF;
	Mon,  5 May 2025 23:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486070;
	bh=CIOyiHhIcQe3oubqf8zVbmf/WHGd27a2psRoGPh9+r4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=soYu2KYeWvO8Ydt1WpN+MYlVn0Zzc9ganCObCNo0C0X76xHvWX8S6HxW0hN9aMx8d
	 wgDlTWsbKrR4k/vdluo+AnFgPl3JJvaJEQFb6MPRlm9RnlbnAuAaHbaLDOw8WIDnJ/
	 BsL/xJxsKiU8136pFg+4MOlB9gTDZJhES64zvF3QrHbc9V1+6Fsc7HhiwvThcNMFQM
	 wFf+grX2/ud3C5KWDrGf1tHukssRq+Tb/wCwwJH4G3KhW7TuDIuV8+UHx8oNuG4oEq
	 WAo0yc3UGAvqOJfDwtxUbOWHNssVyZaekfGE8cNOAfCrsHK2tegjhfFExetkNQub6Y
	 8fDLWzNmC8h7g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vinith Kumar R <quic_vinithku@quicinc.com>,
	Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 139/294] wifi: ath12k: Report proper tx completion status to mac80211
Date: Mon,  5 May 2025 18:53:59 -0400
Message-Id: <20250505225634.2688578-139-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Vinith Kumar R <quic_vinithku@quicinc.com>

[ Upstream commit d2d9c9b8de725e1006d3aa3d18678a732f5d3584 ]

Currently Tx completion for few exception packets are received from
firmware and the tx status updated to mac80211. The tx status values of
HAL_WBM_REL_HTT_TX_COMP_STATUS_DROP and HAL_WBM_REL_HTT_TX_COMP_STATUS_TTL
are considered as tx failure and reported as tx failure to mac80211.
But these failure status is due to internal firmware tx drop and these
packets were not tried to transmit in the air.
In case of mesh this invalid tx status report might trigger mpath broken
issue due to increase in mpath fail average.
So do not report these tx status as tx failure instead free the skb
by calling ieee80211_free_txskb(), and that will be accounted as dropped
frame.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Vinith Kumar R <quic_vinithku@quicinc.com>
Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Link: https://patch.msgid.link/20241122173432.2064858-1-quic_tamizhr@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/dp_tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index e025e4d0e7678..25a9d4c4fae76 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -422,13 +422,13 @@ ath12k_dp_tx_process_htt_tx_complete(struct ath12k_base *ab,
 
 	switch (wbm_status) {
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_OK:
-	case HAL_WBM_REL_HTT_TX_COMP_STATUS_DROP:
-	case HAL_WBM_REL_HTT_TX_COMP_STATUS_TTL:
 		ts.acked = (wbm_status == HAL_WBM_REL_HTT_TX_COMP_STATUS_OK);
 		ts.ack_rssi = le32_get_bits(status_desc->info2,
 					    HTT_TX_WBM_COMP_INFO2_ACK_RSSI);
 		ath12k_dp_tx_htt_tx_complete_buf(ab, msdu, tx_ring, &ts);
 		break;
+	case HAL_WBM_REL_HTT_TX_COMP_STATUS_DROP:
+	case HAL_WBM_REL_HTT_TX_COMP_STATUS_TTL:
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_REINJ:
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_INSPECT:
 		ath12k_dp_tx_free_txbuf(ab, msdu, mac_id, tx_ring);
-- 
2.39.5


