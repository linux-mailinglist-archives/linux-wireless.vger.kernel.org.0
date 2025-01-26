Return-Path: <linux-wireless+bounces-17944-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A93A1CA52
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 16:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6062418840AB
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 15:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A9213B797;
	Sun, 26 Jan 2025 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErmQaUOp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77DD70810;
	Sun, 26 Jan 2025 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903632; cv=none; b=iQbPB9WwulRWbYzzqqchsnVMPrSN3vhGDDAyNTf2u3H0X5/lbTqiLL9eMOcigCdHpsappxx+KaP2K4KzPaEEMKwOZo2mceIu0cT7EKCtiEgs586NPhBDd2PxHkS7JrTmiLcvWvBjQAVOHUxyHTc/qpZpmbpTDTu+hY2hggsOHsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903632; c=relaxed/simple;
	bh=t7P4ntRV5agOZOjYh4DrQCUYqk7wEUB/mA7lieVWKFE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cGsC5SIrIAjyTYJCIHhlC04s6MswkzfNGLVUpPK/w+NYeinLN9t5Y4jpqHS8djUd6A9bUUODSCGIi9T0bYxbK6egVEBPruI7IgzLOm2z1iHRIy39LfKcUiN0UNigUbZmACm8fkLXzhFe3we1XIVRmAb0q/Dtw2PK7r+6qTk7fz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErmQaUOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0722FC4CED3;
	Sun, 26 Jan 2025 15:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903632;
	bh=t7P4ntRV5agOZOjYh4DrQCUYqk7wEUB/mA7lieVWKFE=;
	h=From:To:Cc:Subject:Date:From;
	b=ErmQaUOpIK0RlY9EmMhOvK4dEfAE0gjmNOgVukwGez8Qd2owDq3zu5IRjEUYUPHle
	 qcrfvU+zuKr0sM9TOUfIxxV/A0C7QkU3XEvpui535VO+4mSilhL5u0wYGKn7E5+EwD
	 GhfPuEr5JRkBujSw6/JL1C0VovruAKobwo/wPsU/q7TE+xWtMOmiiCmG4Tqqqj4SOk
	 kdyI6tAhbhkFSkf8wflj6zuUBtjDDtla+bGj08w/+YnU12pKGpzfNp1Rri5yBv/tPc
	 vZVjhCGNYbko6UblJZY9LPRc7L4wbLnCnOciLReyJxwUoKg2jkx/rH6wjgy2z9uvPl
	 hbjmwbatQfR3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Karol Przybylski <karprzy7@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.13 01/35] wifi: ath12k: Fix for out-of bound access error
Date: Sun, 26 Jan 2025 09:59:55 -0500
Message-Id: <20250126150029.953021-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Karol Przybylski <karprzy7@gmail.com>

[ Upstream commit eb8c0534713865d190856f10bfc97cf0b88475b1 ]

Selfgen stats are placed in a buffer using print_array_to_buf_index() function.
Array length parameter passed to the function is too big, resulting in possible
out-of bound memory error.
Decreasing buffer size by one fixes faulty upper bound of passed array.

Discovered in coverity scan, CID 1600742 and CID 1600758

Signed-off-by: Karol Przybylski <karprzy7@gmail.com>
Acked-by: Kalle Valo <kvalo@kernel.org>
Link: https://patch.msgid.link/20241105101132.374372-1-karprzy7@gmail.com
Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index c9980c0193d1d..43ea87e981f42 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -1562,7 +1562,8 @@ ath12k_htt_print_tx_selfgen_ac_stats_tlv(const void *tag_buf, u16 tag_len,
 			 le32_to_cpu(htt_stats_buf->ac_mu_mimo_ndp));
 	len += print_array_to_buf_index(buf, len, "ac_mu_mimo_brpollX_tried = ", 1,
 					htt_stats_buf->ac_mu_mimo_brpoll,
-					ATH12K_HTT_TX_NUM_AC_MUMIMO_USER_STATS, "\n\n");
+					ATH12K_HTT_TX_NUM_AC_MUMIMO_USER_STATS - 1,
+					"\n\n");
 
 	stats_req->buf_len = len;
 }
@@ -1590,7 +1591,7 @@ ath12k_htt_print_tx_selfgen_ax_stats_tlv(const void *tag_buf, u16 tag_len,
 			 le32_to_cpu(htt_stats_buf->ax_mu_mimo_ndp));
 	len += print_array_to_buf_index(buf, len, "ax_mu_mimo_brpollX_tried = ", 1,
 					htt_stats_buf->ax_mu_mimo_brpoll,
-					ATH12K_HTT_TX_NUM_AX_MUMIMO_USER_STATS, "\n");
+					ATH12K_HTT_TX_NUM_AX_MUMIMO_USER_STATS - 1, "\n");
 	len += scnprintf(buf + len, buf_len - len, "ax_basic_trigger = %u\n",
 			 le32_to_cpu(htt_stats_buf->ax_basic_trigger));
 	len += scnprintf(buf + len, buf_len - len, "ax_ulmumimo_total_trigger = %u\n",
-- 
2.39.5


