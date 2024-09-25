Return-Path: <linux-wireless+bounces-13156-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFAE9858A6
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 13:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D3F1F214E3
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 11:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CDB19005B;
	Wed, 25 Sep 2024 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcokz9g4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691C2190052;
	Wed, 25 Sep 2024 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264274; cv=none; b=KeLKFZ0n9RCuKmAmCNnROsJTj8fRcaIM5zt3cZR2lbgQcO97pc1UrdYiGy2T2Rpyr71mGw5khSBt9ZEwia8ZHsAm0BiSlw/RpTX2bO4yeKU71CntXXHCwuiG0cd6d7oA8HSZ1e+GGowrOkl4Rh0tQlbuFAJr/HYFHO8EQqJHE2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264274; c=relaxed/simple;
	bh=M11uQTPBU5ZL24Jv+F5OqrjNly3Hfh2tgF3zc2gCn3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L7DDSkFn41vbWl9DvU/swOrNrNqmh170vDBRWBJUiPDdYkLZVHOVmxlmymVyxDqZmIRXQgojLUWay+yUzeb5Db/46l16BVtzdWFTGHgV1v2jzEbcKpmEsAMhB8HtRnnUqICQIvv12hsCoSf+EpL1Ob+j9cIqhWBcnjZPW223lWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcokz9g4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D50CC4CEC7;
	Wed, 25 Sep 2024 11:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264274;
	bh=M11uQTPBU5ZL24Jv+F5OqrjNly3Hfh2tgF3zc2gCn3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mcokz9g4gHee/J6FOO4ltGc6WvrbMPqXVZ8tpePilzY0GBi0q+rro5BL1i/+SbyJJ
	 0CJWtD4aUn+CE1DfVe33ONuAarDGjXq+su3KetuIUXa9yIUPKX3dinLY3L+/pkOSoM
	 botzcdvXCoiuxa1ViA4qx5QMBBx6flTVHv+Lz9YwcoqiMQXKNQRfCQ1NEGvnIj7VUF
	 hxaUDQMnYcXEQUT8iXh4u+2k64rPYDhUsD5/KOz6rB308TFRpxF9sYUiWE8kVREeJo
	 +xc9BL3HTEdGhoOIgzLgwePZZKpBBgtLgoQZA+r0H6vd62vFfS2K8X6jc61a6SrovA
	 MEahTXH2N299A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.11 034/244] wifi: ath11k: fix array out-of-bound access in SoC stats
Date: Wed, 25 Sep 2024 07:24:15 -0400
Message-ID: <20240925113641.1297102-34-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

[ Upstream commit 69f253e46af98af17e3efa3e5dfa72fcb7d1983d ]

Currently, the ath11k_soc_dp_stats::hal_reo_error array is defined with a
maximum size of DP_REO_DST_RING_MAX. However, the ath11k_dp_process_rx()
function access ath11k_soc_dp_stats::hal_reo_error using the REO
destination SRNG ring ID, which is incorrect. SRNG ring ID differ from
normal ring ID, and this usage leads to out-of-bounds array access. To fix
this issue, modify ath11k_dp_process_rx() to use the normal ring ID
directly instead of the SRNG ring ID to avoid out-of-bounds array access.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://patch.msgid.link/20240704070811.4186543-3-quic_periyasa@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 86485580dd895..c087d8a0f5b25 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2697,7 +2697,7 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 		if (unlikely(push_reason !=
 			     HAL_REO_DEST_RING_PUSH_REASON_ROUTING_INSTRUCTION)) {
 			dev_kfree_skb_any(msdu);
-			ab->soc_stats.hal_reo_error[dp->reo_dst_ring[ring_id].ring_id]++;
+			ab->soc_stats.hal_reo_error[ring_id]++;
 			continue;
 		}
 
-- 
2.43.0


