Return-Path: <linux-wireless+bounces-15651-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C0C9D74B0
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 16:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18097289F34
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 15:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1CC24573B;
	Sun, 24 Nov 2024 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZetVk/aC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E014B24571F;
	Sun, 24 Nov 2024 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456516; cv=none; b=WcoeTgNnYzIz92tT1KTgOJYmWA2ymCc3VpY4LmZjE4zUL7OehWgsQjXYomC9YINB3UamT9Qdt9FU/Lnic6Wmt7YVo7uVT8ZD+t77pDGLJ8P0zTiW4qaRM6fv/A7jGEvL5pasMP2q4Cl1uB+g970zQ8ajxO5SR9aWdhdE8M6xwEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456516; c=relaxed/simple;
	bh=Gl5dMb5qF+W+jWw8poTEZejspiar37EFpQlLQ2P1IhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRhKCwIRdamJh5D6ahxXuRZCFr8N8PcEVb6VGPVBUe7Tb2slA4Q2Mw1qeBJ6QWVe0A5LcFQWblDPgBK+9v1JEPdup8c1e1ON3ywfTM7aiD+ST9yOK1EIWBdPt/GKcvq8QFfu83ZRZ2eghKuBUcxUipiD3Uv/XaPWcX2wx3IckoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZetVk/aC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41BEC4CED3;
	Sun, 24 Nov 2024 13:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456515;
	bh=Gl5dMb5qF+W+jWw8poTEZejspiar37EFpQlLQ2P1IhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZetVk/aCc/yBlDw+oEAUzsgGh7xG+S7+Ooavz5CkCe3R6TMl27oI2NhYAeGsyaz+z
	 8F4onMye5AhKWx2Z7wZpCgxZxJhGVKZGHQUYxOUgcucJwNVimY4FCybRZoIu9EkN4y
	 RDJuCRRB4Ov+/nY+x1KyuxihVDV43i5K+fa3Zers2leRHoepCKuB5zvoABaRb5hLdU
	 +4JEqZxUfvnFcQ2GGPMSfL++K+0BegHV7PvLMT8PzGQM+cp5aibgmIviINc+imKMS+
	 YqECtN+3aS5WVXZYjU7g5aXWPq6JadFsWGwh9Z9tcbajo83v08hK+CRcs+7Le76mKw
	 yWDHywldZWn/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Norbert van Bolhuis <nvbolhuis@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	arend.vanspriel@broadcom.com,
	saikrishnag@marvell.com,
	sebastian.reichel@collabora.com,
	erick.archer@outlook.com,
	jacobe.zang@wesion.com,
	krzysztof.kozlowski@linaro.org,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com
Subject: [PATCH AUTOSEL 5.10 28/33] wifi: brcmfmac: Fix oops due to NULL pointer dereference in brcmf_sdiod_sglist_rw()
Date: Sun, 24 Nov 2024 08:53:40 -0500
Message-ID: <20241124135410.3349976-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135410.3349976-1-sashal@kernel.org>
References: <20241124135410.3349976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
Content-Transfer-Encoding: 8bit

From: Norbert van Bolhuis <nvbolhuis@gmail.com>

[ Upstream commit 857282b819cbaa0675aaab1e7542e2c0579f52d7 ]

This patch fixes a NULL pointer dereference bug in brcmfmac that occurs
when a high 'sd_sgentry_align' value applies (e.g. 512) and a lot of queued SKBs
are sent from the pkt queue.

The problem is the number of entries in the pre-allocated sgtable, it is
nents = max(rxglom_size, txglom_size) + max(rxglom_size, txglom_size) >> 4 + 1.
Given the default [rt]xglom_size=32 it's actually 35 which is too small.
Worst case, the pkt queue can end up with 64 SKBs. This occurs when a new SKB
is added for each original SKB if tailroom isn't enough to hold tail_pad.
At least one sg entry is needed for each SKB. So, eventually the "skb_queue_walk loop"
in brcmf_sdiod_sglist_rw may run out of sg entries. This makes sg_next return
NULL and this causes the oops.

The patch sets nents to max(rxglom_size, txglom_size) * 2 to be able handle
the worst-case.
Btw. this requires only 64-35=29 * 16 (or 20 if CONFIG_NEED_SG_DMA_LENGTH) = 464
additional bytes of memory.

Signed-off-by: Norbert van Bolhuis <nvbolhuis@gmail.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://patch.msgid.link/20241107132903.13513-1-nvbolhuis@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index b6d0bc73923fc..75dc7904a4bd6 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -769,7 +769,7 @@ void brcmf_sdiod_sgtable_alloc(struct brcmf_sdio_dev *sdiodev)
 
 	nents = max_t(uint, BRCMF_DEFAULT_RXGLOM_SIZE,
 		      sdiodev->settings->bus.sdio.txglomsz);
-	nents += (nents >> 4) + 1;
+	nents *= 2;
 
 	WARN_ON(nents > sdiodev->max_segment_count);
 
-- 
2.43.0


