Return-Path: <linux-wireless+bounces-16259-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0F59ED032
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 16:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772441884056
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 15:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8D01DE2CA;
	Wed, 11 Dec 2024 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxAMv7Pf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993801DE2C5
	for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931845; cv=none; b=G6d7WqSfb5BFEcRWi/vOB51BmirWDLdzwwnD1jSgvGZM3J1wONuCSkjEbye9xBfHqZ1975Eit+XlEg7wXCmPeAbZ7mc4TblhhG1c4RAQ23lmi7VQqd703qTWt/xviyXO3xBxId2Hor1/xykKaeW1lF2NdX7RfTwQjZrD+314wSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931845; c=relaxed/simple;
	bh=I4xxAW21GFTuI4CUQmeQKcvHy+yndUU+jz/ZTGh9zCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pO/WF7xZzv/B6gxK0dpq/0BhF7um8M+dI7w5jVLuvS0riBgRs5M7xWytz8Z/Vu947goDQP0izGpQ5xTFhIkse3QD/nhtdNM7TRkpM4mgbbMJgOSPM9BALExHlq3Q7z41llD34igOcTHbuJE+vIYqeSZzUpG30mWzN7kAY+obvJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxAMv7Pf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965A1C4CED7;
	Wed, 11 Dec 2024 15:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931845;
	bh=I4xxAW21GFTuI4CUQmeQKcvHy+yndUU+jz/ZTGh9zCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jxAMv7Pf79YYiBU/4FFjsbBK4YSBwKxzLYBX8GTC3tN3d0ZsIQctk51IL+5jSoD+6
	 7MBhTz+U1KwGGzV53AiC6Pp8oXMG8EsYJj9npc7lApiyVtdDyMNssLaNLIAz/TgXT5
	 MeL646+rvB6biFOvt7t7K5P5xNtuv3WRzURUnVHCPieK1Q37wGc4QtDnbD6Bz6Z4NW
	 HKq3CE20ywpBDpjCd7qj0PDZrX40JRPK5kFsRRht0WhpZBrmQ3BAipUS0OR2eicyxc
	 RfJ2jI9IkS7OSViC5m0CE0Mv/V3nsg5/0cfeXJOTPYNBiMBOzlSxQpNy0fs2bRSBT+
	 EBm3pxEL4TrZA==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 4/7] wifi: ath12k: remove warning print in htt mlo offset event message
Date: Wed, 11 Dec 2024 17:43:55 +0200
Message-Id: <20241211154358.776279-5-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241211154358.776279-1-kvalo@kernel.org>
References: <20241211154358.776279-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aditya Kumar Singh <quic_adisi@quicinc.com>

In the function ath12k_htt_mlo_offset_event_handler(), it is possible that
the ar is not yet active (started). The function
ath12k_mac_get_ar_by_pdev_id() only searches for active pdev, so a NULL
return is possible. Therefore, there is no need to print a warning,
instead, just silently discard the message.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 1cc7f6ce55b9..a05384288b5a 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1697,7 +1697,11 @@ static void ath12k_htt_mlo_offset_event_handler(struct ath12k_base *ab,
 	rcu_read_lock();
 	ar = ath12k_mac_get_ar_by_pdev_id(ab, pdev_id);
 	if (!ar) {
-		ath12k_warn(ab, "invalid pdev id %d on htt mlo offset\n", pdev_id);
+		/* It is possible that the ar is not yet active (started).
+		 * The above function will only look for the active pdev
+		 * and hence %NULL return is possible. Just silently
+		 * discard this message
+		 */
 		goto exit;
 	}
 
-- 
2.39.5


