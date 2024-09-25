Return-Path: <linux-wireless+bounces-13178-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7BD985C6D
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 14:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10D3B1C23B7A
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 12:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF071CF7B4;
	Wed, 25 Sep 2024 11:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M29vguN5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89CA1CF7B0;
	Wed, 25 Sep 2024 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265575; cv=none; b=ldC+sWmk0vau5tCbcEm6EoyhPpVY9dV2/ZEFQXhPAm4/PzAw5zJ5xTpREBRoGIWd0ZWYdVf2uL/66gVAy1+UI6A9By4vuFr+XAi3qci045Ot33PRgQ6frzJJe9Z6/dJ0Ei/00bNAwfh7/3MzeFilMmWinHam7ah8PGZs2VXdOEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265575; c=relaxed/simple;
	bh=lheoXjTr90K/jmtpvSoEgbeXRetvCKbhdHAMSUQmdkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmxpyOyKF51U0LZwiPggSiWAxdqhnWRX4ZKL4I3zR+VDLdvcGjawImsFQuBjXKTzk2am66ov6xEyoYPrj6GWULsg3PmJ1ponftIb/HNN2SNwgQs1eOANzL7ZY6wSND+yRv1em/Z4YhSigkhUQ1eJdqOALIGTIsb1nnv608hd2iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M29vguN5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D430C4CEC3;
	Wed, 25 Sep 2024 11:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265574;
	bh=lheoXjTr90K/jmtpvSoEgbeXRetvCKbhdHAMSUQmdkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M29vguN5YFchPdjWw4g3rQ1fIT4LKhjyGuJPc25v3CzdQaXsRo2ixsLmCtYt64n4Q
	 N6ZWCkRulD9AM5vD+xsX8bEyJrCkEX+dFqZfqQE7m/qYWMUg6cInQarBoZL+vYv45p
	 zcNeFwt6kdjEXgf9rGq/iKaLWSlYYbqhD1BI5wC2Jbg3lNON+ZLldEsOcVFy2TuAPd
	 CvVeuTlFsKpsUbhf0sEwDmLdsMwpYroonmbeEDzifg84A7QyHsH6kFzSigbdevjOJl
	 Z/K+1UKVQbcztZCAeZT4LKG+1TSsy2lCUNdG+3Vs4FNRujAuS68fzSRcfYw+nmN1Qv
	 KSlJh8ownLtQw==
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
Subject: [PATCH AUTOSEL 6.10 030/197] wifi: ath11k: fix array out-of-bound access in SoC stats
Date: Wed, 25 Sep 2024 07:50:49 -0400
Message-ID: <20240925115823.1303019-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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
index aabde24d87632..88c7a7289d06e 100644
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


