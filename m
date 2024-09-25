Return-Path: <linux-wireless+bounces-13196-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FED0985EB2
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 15:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 086FF1F24EE9
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 13:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B13214D82;
	Wed, 25 Sep 2024 12:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgIUARXj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB60214D7D;
	Wed, 25 Sep 2024 12:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266359; cv=none; b=VomkP1fZ9l6v+mj2TEYgdxkPGdYkE0sdtHu6PCwwB1S6Nk8qjf/ILm4HXLGOtQXtmUCfKayD9TIv9L8YDxJNI8nL0ib5miaDVRrGUphqEUHq9l7U8YZTa9uchQsn1EytRpp7dpySr8sv7q97d8J0KjE2IZeBlDeIRO/0NvqmqjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266359; c=relaxed/simple;
	bh=Pst3oHKYuwPoXWtG7pQXmcYMYpqIYNZ5ilHsvTyYs3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UKif7mb9XDK5wZhFVR2IqVDvoVXkN81GxrkM3bSvocXkqhvBmfJkvx+EXY8GG8oCH7swRb2lQqvvtUqxfbHdix9TbSebHTLWJUjakveBAvbp82BhpaqArjEiAYwWxmwZccskbD6Tvm+YhRKsh4uQEWD8A2fnGh97x7r4Pg6/Ku0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgIUARXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538C7C4CEC3;
	Wed, 25 Sep 2024 12:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266358;
	bh=Pst3oHKYuwPoXWtG7pQXmcYMYpqIYNZ5ilHsvTyYs3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pgIUARXjDjYNAoYZDYJHJbhRX7Ok1PiIlk+44I4oyGccLa7yHuudfUXIPULoz1GIn
	 ydZPt5mBZMxJtxTWehkEYfAmEYgm/sRvDH1DLOfmklxgojn4RR6ZBboPfEsBtELJF8
	 GSDlybtlxvxXe309zCSX3Q9Rjt4aRrkCMk3wgRmQcjq3zQgprNHlYqL0Wx02TjlRHi
	 sBBH77yOpKbf4cSDhqx+KFIfaQN1bslqdXveZyfKKwTaZcjKY4BBSunypnp0UuIPE5
	 pv8SHm0kfB8V0RYt+EA/0WI0IFBU/1NV0jt03F4HmUAXTxTqpuzeIne08+kYlyC7gP
	 prl1gSUJAdgzQ==
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
Subject: [PATCH AUTOSEL 6.6 027/139] wifi: ath12k: fix array out-of-bound access in SoC stats
Date: Wed, 25 Sep 2024 08:07:27 -0400
Message-ID: <20240925121137.1307574-27-sashal@kernel.org>
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
index d9bc07844fb71..70ad035acac75 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2670,7 +2670,7 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
 		if (push_reason !=
 		    HAL_REO_DEST_RING_PUSH_REASON_ROUTING_INSTRUCTION) {
 			dev_kfree_skb_any(msdu);
-			ab->soc_stats.hal_reo_error[dp->reo_dst_ring[ring_id].ring_id]++;
+			ab->soc_stats.hal_reo_error[ring_id]++;
 			continue;
 		}
 
-- 
2.43.0


