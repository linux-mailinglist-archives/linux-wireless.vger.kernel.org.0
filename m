Return-Path: <linux-wireless+bounces-13197-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 355EE985EB5
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 15:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE023287B55
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 13:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9584C18E755;
	Wed, 25 Sep 2024 12:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPVNAEoi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF0318E74A;
	Wed, 25 Sep 2024 12:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266360; cv=none; b=lzOwmuJS9JHQv1SW8omrEW0DGtwNzPTHO+kch9lUYE2QZ/gF2e+bcDF/U0N0SPa+o1rg3PTctKvBckgCZQSCCIpBWhsmoHYoqlVgYNCoT//SXW6RUBTtDWsJ9Xdz6EjtBAGXFIfJtniTg1pHDFsJLWoQgt7F3AGxLH1TvbMuYGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266360; c=relaxed/simple;
	bh=kxAFvAmx1UL4nDsWMpOIrvG3PSMmFTzJWAQUr8lcJrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXCPpaZ3vOgiiTAin/GMtfkAD04mLWgGXaaOEGwKdYzj3GfnXViuWJbktdwWBneWnGVNjZuBdsvIUi8Tpbv+nehNEDQEG/lj2c74RamBht73dDUmPt7nZCKYx56JeaQoyijEHPNQ0gHI3a7CERj/FetDAsrIRWiYhdkhvSLB3+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPVNAEoi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CC3C4CEC7;
	Wed, 25 Sep 2024 12:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266360;
	bh=kxAFvAmx1UL4nDsWMpOIrvG3PSMmFTzJWAQUr8lcJrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YPVNAEoizXx2HoqQMRo3HtSOeYK1uVJtWCJreMrrRYhQ2VXQql0XKXFaDwlU/uMF7
	 0CCWvynaDKJP6CDmUoIaft+8VQqfNQp1g9ph5aHobinuTe811epbqX8Jd5SxwjuFvS
	 27FOdN2TB8euqqL9CrJOxLRjV3r5ndly7JDyw3YoA4HFZmZZn36lZzubdiuK44S+CV
	 8eXJ2NdTQz75n5gYQn5VNkiKxR05SoPhf63pKaE+isi8/EMoaVAwsOM2ciwURISHkt
	 cJLLTm7HZL9vkgLL6m053ssNgcQj1d7/w/Mfh7bZuxmDA6cra0WTaONw/9T5+/vJSI
	 V4VyLSd+/U12g==
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
Subject: [PATCH AUTOSEL 6.6 028/139] wifi: ath11k: fix array out-of-bound access in SoC stats
Date: Wed, 25 Sep 2024 08:07:28 -0400
Message-ID: <20240925121137.1307574-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
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
index b3499f966a9d6..a4d56136f42f7 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2700,7 +2700,7 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 		if (unlikely(push_reason !=
 			     HAL_REO_DEST_RING_PUSH_REASON_ROUTING_INSTRUCTION)) {
 			dev_kfree_skb_any(msdu);
-			ab->soc_stats.hal_reo_error[dp->reo_dst_ring[ring_id].ring_id]++;
+			ab->soc_stats.hal_reo_error[ring_id]++;
 			continue;
 		}
 
-- 
2.43.0


