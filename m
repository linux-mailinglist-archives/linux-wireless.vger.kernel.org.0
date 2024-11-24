Return-Path: <linux-wireless+bounces-15655-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F7C9D74F4
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 16:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 393BC28656B
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 15:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFE11E8828;
	Sun, 24 Nov 2024 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJLCSd1T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9171E24A95C;
	Sun, 24 Nov 2024 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456601; cv=none; b=akvCSdkj4qa4pqjKZG75wGQ79xS3o9516cIeYbBnn949MYUuMuwoDJOUCH2Ves1TzW8AJKESu+epkDVn/8epWZqGOVwamu+Cy9nr/kT29ItHRifzNajptWAGssVsDFMU+Rpa6GhsDijwci4S6hZYypv6+2X0LpLwAcx/JYfyZAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456601; c=relaxed/simple;
	bh=I/6qRk4lus8uf3NjtujTkW6UtnT8+ezW2o0ITP9QQZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WudYkxEVXkPL2jhIA0dH1LJ+Xw3dJOgMS/hXYuVgG9RXlRqkBf+iT4furTu8gEgT8C0m7igJnzEbcXJ/Nve4cPK7GDnFqa+AHyiRjR8BB1X1RhVw//ijzAAeOHC3HEbxx0uBtSF+89Ei/kcB3WeGo3a3HjOOxR9W6GKpihwgIig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJLCSd1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D6BC4CED1;
	Sun, 24 Nov 2024 13:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456601;
	bh=I/6qRk4lus8uf3NjtujTkW6UtnT8+ezW2o0ITP9QQZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jJLCSd1TlV2Z2sAv/hinliLevPo35Y/ZOOaQRk6ET2iiHL/t2h+SoVqm8OVRF4ltT
	 SwwnaAZZ4ikHpQyV1EQmQAMKo9dzTkGYv/sb8DO9S1/zcekvAaM2wrgkcplwMcTUAY
	 hOI0XorDHXHVSfVoGiF88CqfnNR6TaXoyHgzpWBya2knHzAJBarYn0ORPPUPE/rSiA
	 kIDaTdlHcG45XVxeDyWvES9A747rT9Rq0f9zb46SD3ANXz4F76vf7Z+L6vaCc03CQi
	 SCwS5Q0n21y/e9CNafioNI0CGvq/R03w6zpDVe/VzGZCY5+luEQN7EB+VbV0z6cOPy
	 RnVsGcVIz3MAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Norbert van Bolhuis <nvbolhuis@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	arend.vanspriel@broadcom.com,
	megi@xff.cz,
	saikrishnag@marvell.com,
	erick.archer@outlook.com,
	jacobe.zang@wesion.com,
	krzysztof.kozlowski@linaro.org,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com
Subject: [PATCH AUTOSEL 5.4 23/28] wifi: brcmfmac: Fix oops due to NULL pointer dereference in brcmf_sdiod_sglist_rw()
Date: Sun, 24 Nov 2024 08:55:23 -0500
Message-ID: <20241124135549.3350700-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135549.3350700-1-sashal@kernel.org>
References: <20241124135549.3350700-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
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
index c492d2d2db1df..32ac1fa5bdecf 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -770,7 +770,7 @@ void brcmf_sdiod_sgtable_alloc(struct brcmf_sdio_dev *sdiodev)
 
 	nents = max_t(uint, BRCMF_DEFAULT_RXGLOM_SIZE,
 		      sdiodev->settings->bus.sdio.txglomsz);
-	nents += (nents >> 4) + 1;
+	nents *= 2;
 
 	WARN_ON(nents > sdiodev->max_segment_count);
 
-- 
2.43.0


