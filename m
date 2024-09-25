Return-Path: <linux-wireless+bounces-13155-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D7A98589D
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 13:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9FD1C217B1
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 11:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5431318FDBC;
	Wed, 25 Sep 2024 11:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwUQ8zDI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2735117DFE3;
	Wed, 25 Sep 2024 11:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264273; cv=none; b=qO7dPJoOVE83FTzAgm0W8CXmUbRUnEhqhoiWD+RCfhf5b44HUH/ANWe6377RK3ieA4FksruygU2VlsmhRor/LjGD/gsOAqsLGA+6kY4qNc8bshr3hGhjt9ZUdr7ZC5vYu524PjroSJWrn/L8NPxCwv+44uD8FhDDh1OBGU4Gouw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264273; c=relaxed/simple;
	bh=ghpmuDuu0eWFdJ+JnPGVfeCo9TbE7aASMOcYeNCzKac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/7aWAh4jW6WENytE7ahzX57Q3n0ilefKTXU7rdC/cNfRSltsAnlwQXkDwpJCtOjN4nU4tqwvVJYguiB2XKtnrqKvv6Qx0Ak7in0gLN9KAb7qf7Fnm82PnDf5fkBxdj8nPnC/0UKt5NzXKw8mfcU1CmuEhnvm+AJSUR5vspsV8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwUQ8zDI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84352C4CECD;
	Wed, 25 Sep 2024 11:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264272;
	bh=ghpmuDuu0eWFdJ+JnPGVfeCo9TbE7aASMOcYeNCzKac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iwUQ8zDIZqm+q6RQrvxTBSBpe3am5Oxf5DBJ0/+NgmDJy3Hk+gGgWWg1MVZmnCiPM
	 INTmDDkP85dQWCMYO+60qFos0U6L71KFJWuwKATLunVHpU4ZcAainRQ7oxLmGNrWLi
	 d9JSTGXn4uTiBikFwhTfw+USyJ0to7YICkQw8UNytsFcwXcCV956lz0mnStS0N3R5W
	 +VIlXFVkL3HiBk06nP3BxDzTDVPD4yCRoIX8xxO18BHI4od3YZw4m0KcaJDqlt2u9P
	 5XHlGApq1+HemrgdszhnnF6LoIVOeyx1sK7UeRLPtQNHZjpwGCaIMGLobrJvWR68v4
	 t0unOWl4QKOEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.11 033/244] wifi: ath12k: fix array out-of-bound access in SoC stats
Date: Wed, 25 Sep 2024 07:24:14 -0400
Message-ID: <20240925113641.1297102-33-sashal@kernel.org>
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

[ Upstream commit e106b7ad13c1d246adaa57df73edb8f8b8acb240 ]

Currently, the ath12k_soc_dp_stats::hal_reo_error array is defined with a
maximum size of DP_REO_DST_RING_MAX. However, the ath12k_dp_rx_process()
function access ath12k_soc_dp_stats::hal_reo_error using the REO
destination SRNG ring ID, which is incorrect. SRNG ring ID differ from
normal ring ID, and this usage leads to out-of-bounds array access. To
fix this issue, modify ath12k_dp_rx_process() to use the normal ring ID
directly instead of the SRNG ring ID to avoid out-of-bounds array access.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://patch.msgid.link/20240704070811.4186543-2-quic_periyasa@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 14236d0a0c89d..91e3393f7b5f4 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2681,7 +2681,7 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
 		if (push_reason !=
 		    HAL_REO_DEST_RING_PUSH_REASON_ROUTING_INSTRUCTION) {
 			dev_kfree_skb_any(msdu);
-			ab->soc_stats.hal_reo_error[dp->reo_dst_ring[ring_id].ring_id]++;
+			ab->soc_stats.hal_reo_error[ring_id]++;
 			continue;
 		}
 
-- 
2.43.0


