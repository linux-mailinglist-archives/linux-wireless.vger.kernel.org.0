Return-Path: <linux-wireless+bounces-10773-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A72AF943B23
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 02:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60C77283364
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 00:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F3A1586CD;
	Thu,  1 Aug 2024 00:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYlun+Ex"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCD01586C8;
	Thu,  1 Aug 2024 00:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471169; cv=none; b=StS1/wTCQ97kfrNQuR7czx9LmMhcH/6N+ic1JiW8kW7vtXPVuUjCRAIFg+MyycxtAzJZHJdO4SsL25BWJ8MqV96SNg8ikRNX/gM12UNlxqOx/D3WNtqWT8XC1xY+K/XkHAwmAomk5aGDR7bhhHsnbhGcmorQ0YIn/xEpTrFobHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471169; c=relaxed/simple;
	bh=rsZOGd03V2Zh4wv7dhQc6P52afmJhEBWFzpPHt0Dohc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NOxW3bI+hV6jrk7QNntG1SN5oR+g/qiw6VWGoPIrqPHeJugQyAWXqqsrrD0s7XJYchKEB1i8peOPnXS/MJiZy0JbvfOYClCAdxadPmnlNP4UGs6a3QXjFTAg5xv31poapveOQc+5iWWbo5eXDgMj02aDyTt39GniBL49EFOb6FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYlun+Ex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F33C4AF13;
	Thu,  1 Aug 2024 00:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471169;
	bh=rsZOGd03V2Zh4wv7dhQc6P52afmJhEBWFzpPHt0Dohc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KYlun+ExRcaQrFS7GH05kbhcNUmWadSKwXMZphJfkQmQRIEdddWRRvs5ucDhwU0l2
	 1pf11BgFmWibidh+46KXBz2uJNd3rpCVoZ75oFDDy/6Bc/L006netLCSWyllJNIMZe
	 wv6JqMtSxpYpmbQ9yjTEPjvYbfDtPsgZS9a2G+RU//asjoYZbwlTKazGTvWGc8vSFC
	 fpEUF7Ae0ZVFxrHzIKPgaAOjtX4S2wQ1Mjl7owCduFM1cyigqKPblBtMz2Muf5EJFp
	 JwbzzzfjZPPd49r05ZZWngU0gLrTt79dvhmDiosAXxlPmc6Z17D2FCzEP+IM6TXHCx
	 EHMuPkrp25vVA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.10 040/121] wifi: ath12k: initialize 'ret' in ath12k_dp_rxdma_ring_sel_config_wcn7850()
Date: Wed, 31 Jul 2024 19:59:38 -0400
Message-ID: <20240801000834.3930818-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Jeff Johnson <quic_jjohnson@quicinc.com>

[ Upstream commit 3b9344740843d965e9e37fba30620b3b1c0afa4f ]

smatch flagged the following issue:

drivers/net/wireless/ath/ath12k/dp_rx.c:4065 ath12k_dp_rxdma_ring_sel_config_wcn7850() error: uninitialized symbol 'ret'.

In ath12k_dp_rxdma_ring_sel_config_wcn7850() if it were ever the case
that ab->hw_params->num_rxdma_per_pdev was 0 then 'ret' would be
uninitialized when it is returned. This should never be the case, but
to be safe and to quiet smatch, add an initializer to the declaration
of 'ret'.

No functional changes, compile tested only.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://msgid.link/20240504-ath12k_dp_rxdma_ring_sel_config_wcn7850-ret-v1-2-44d2843a2857@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 75df622f25d85..0f439d9b84fbf 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -4028,7 +4028,7 @@ int ath12k_dp_rxdma_ring_sel_config_wcn7850(struct ath12k_base *ab)
 	struct ath12k_dp *dp = &ab->dp;
 	struct htt_rx_ring_tlv_filter tlv_filter = {0};
 	u32 ring_id;
-	int ret;
+	int ret = 0;
 	u32 hal_rx_desc_sz = ab->hal.hal_desc_sz;
 	int i;
 
-- 
2.43.0


