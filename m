Return-Path: <linux-wireless+bounces-22520-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A7EAAA695
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 02:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21F11888024
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA904329413;
	Mon,  5 May 2025 22:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExfAynp0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF4732940B;
	Mon,  5 May 2025 22:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484490; cv=none; b=nIbYbhUso4sUsTVAnvi/Hl4CxdiQwJfwoOyr0P0yPrzmBDaAXMGIP0JWNcE5A/BIx6yGhXVDPs5dnQExxGLKB0UDCj2JxZ373MCDc95KyFMvzj30e2ORWHJNBeS67YtUmy68lorivRTzJcxG5tuXMgP7Ymfh8gpykK9h+uQFtqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484490; c=relaxed/simple;
	bh=I3P7F81fwQO4vFcX7jTNe5dzmappe2y4BGmiNPIeY40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E/SQO9AKQTPskpXcr558nWUdSpwJtmoIFB3utb2FbYTQBmd19MRVKdz+As6FFympMG/TIfEKM0SN2HwyZmVcfDYcJ8STB+nLZoUeR8A7fbpSstVIbfNtfFGyCmBeQaywkWDsgPgLJxIvRO2zhptRSFAVNM6VVyFKeqjpLGmxZbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExfAynp0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F253AC4CEEE;
	Mon,  5 May 2025 22:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484490;
	bh=I3P7F81fwQO4vFcX7jTNe5dzmappe2y4BGmiNPIeY40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ExfAynp08L4xR3kM5nROO3pmyiw3SHrThw8d37Oj9coLvdGt7bGOnm3ifvbaAS5aN
	 2SQhjnNQ1QAXkrKRCfECDEDuW0oadgPXjgqqhmmKRCDGT3wMcEfqWuMsTiyqy30BX9
	 ahf/yV1wxYMVa0qkpsQNRlTx6jWlvuiC4K62cnq8srk7X1+5lMNZ3xByB4LVRJbWxW
	 WR3/9Yaq9LkX+ILmArruyr9PST9/i7APJshHYVyH43//Bf72NvSYBzsEk4StLvGPHR
	 Zu8mzGfZNm8KI9S2vu+q32+3rgl6WWxZpj6EI8o7O0NXG9GtH0Ite30hHj1o1vl3XK
	 R9GzJZvoKin1Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
	P Praneesh <quic_ppranees@quicinc.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 497/642] wifi: ath12k: Update the peer id in PPDU end user stats TLV
Date: Mon,  5 May 2025 18:11:53 -0400
Message-Id: <20250505221419.2672473-497-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

[ Upstream commit 0cded0e413468183a3b2dd445ab3bdc4d4375967 ]

Currently, peer id get reported in the PPDU end user TLV tag. But the
monitor status handler is inherited from ath11k, but it was not updated
to incorporate the changes made to ath12k 802.11be hardware architecture.
Therefore, update the peer id from the PPDU end user TLV data to get latest
peer id update, it helps to populate accurate peer information on the
statistics data.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Link: https://patch.msgid.link/20250206013854.174765-6-quic_periyasa@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index f23fee7055abc..8737dc8fea354 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -638,6 +638,9 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k_base *ab,
 		ppdu_info->num_mpdu_fcs_err =
 			u32_get_bits(info[0],
 				     HAL_RX_PPDU_END_USER_STATS_INFO0_MPDU_CNT_FCS_ERR);
+		ppdu_info->peer_id =
+			u32_get_bits(info[0], HAL_RX_PPDU_END_USER_STATS_INFO0_PEER_ID);
+
 		switch (ppdu_info->preamble_type) {
 		case HAL_RX_PREAMBLE_11N:
 			ppdu_info->ht_flags = 1;
-- 
2.39.5


