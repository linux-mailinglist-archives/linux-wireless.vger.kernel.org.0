Return-Path: <linux-wireless+bounces-13177-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F966985C6B
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 14:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562CD2882B9
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 12:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6301AD9CF;
	Wed, 25 Sep 2024 11:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuyzjiGV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2423A1CF5EA;
	Wed, 25 Sep 2024 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265573; cv=none; b=DQxDNaWzFLgaS6Fe5jWgBarHbcPsUFYWVnJSRGbjWb72a7oghLia28ouMZR4LCgaWAIxmKr7nGo4s1AHW6jJVfKlRcvgNMLGvkcrE2LiijJTDdgv3/VtPOUQ3NHcFxscjJkmXzLNihVYxW9oRhICfsBo8CmA3EfFlfgGRjfB4HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265573; c=relaxed/simple;
	bh=jFr7uu1TQUwZVhdUqJfZcFkq8Z+1od8tbXbQq+2lMHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvDHXQCLWZ8FAYtGWsXFyy9aaXzTOlibTr5c3oYLtquEUeGWjgDkxYX5tYz0keDea3FBzpZ3aAZBHxkvM3ntEE5YvxYSqthFv5bfFACP4E1h+pTtn9WjHmHGMXI3q8Umm+zm2hSW6G4yWotUlqY+Q2NAZOYWn/le7xAGEvmQxa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuyzjiGV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D55C4CECF;
	Wed, 25 Sep 2024 11:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265572;
	bh=jFr7uu1TQUwZVhdUqJfZcFkq8Z+1od8tbXbQq+2lMHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IuyzjiGVb5cHsiM6AiOn0Ahu4Xbq8shwKM9/rHHPde38kCzuwRGm8r/BNy92o8nT2
	 AivqCrwlAZRkv6aYGcjct9T5TXAXkKsFOfSr2i+EOAKoKofDp0p02SZoAUxJH1okb5
	 sPcKUp0Mns2/NeBia+PDYL6o981zf1x7Z1mg4sdtY8uXwPb9+SNWAd4lSrAxUphJys
	 3nKYllsoR9nWv2hYC8vwdzOo3M+XPks/nRAUOsnPR2okcP+qxzBJJN4Qq5O9Wji+qs
	 Vh5ocamQoVMQt5LtgF6QetDtbuFi/LeWRkOkwh2nb01JLNT2TziuZQpp7nb8qpZD/F
	 ULV2/g8tmJvMA==
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
Subject: [PATCH AUTOSEL 6.10 029/197] wifi: ath12k: fix array out-of-bound access in SoC stats
Date: Wed, 25 Sep 2024 07:50:48 -0400
Message-ID: <20240925115823.1303019-29-sashal@kernel.org>
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
index 3cdc4c51d6dfe..f8767496fa543 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2702,7 +2702,7 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
 		if (push_reason !=
 		    HAL_REO_DEST_RING_PUSH_REASON_ROUTING_INSTRUCTION) {
 			dev_kfree_skb_any(msdu);
-			ab->soc_stats.hal_reo_error[dp->reo_dst_ring[ring_id].ring_id]++;
+			ab->soc_stats.hal_reo_error[ring_id]++;
 			continue;
 		}
 
-- 
2.43.0


