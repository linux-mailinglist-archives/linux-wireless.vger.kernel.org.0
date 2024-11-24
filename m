Return-Path: <linux-wireless+bounces-15659-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3712E9D752E
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 16:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DDE287F00
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 15:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAE824F26F;
	Sun, 24 Nov 2024 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+m6b6NV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E2524F25C;
	Sun, 24 Nov 2024 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456670; cv=none; b=gZg7fD4AO0hBElNCVrK3GMJHsijxxydgdvk7C+sM2MqdhdDCW7xbgcqpRboC7tFxurbrFzPJpRsWeY7T6Awm6eETwA2JQvNRkFsZL9wD3dTsu41PBLwS/kKzArXENanzZmtQro6+ArfoJiTEA/SbvnIO9+A5J2toP20gHYDDNb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456670; c=relaxed/simple;
	bh=tzdgRpBlFIm+PD09acrAcKWHIEWDJIX3DFIlN8uYEeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecHaLwS7UgxdJSVtS/8Zc7FuVz1iGHLcEkGz5EaR3NBqPmx0RsiKIK3E1zHQIFfVUTPqxGhTNXd0MnLfFDyhbYJbnRnKGQ71rFhUPXMYwDTNlmWmkh9WiJiUTzRY5Ybd+0mbwG0Tl79n97bnTPh6UXhoVsTYW5tpH0vVQFcIzWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+m6b6NV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CDDC4CECC;
	Sun, 24 Nov 2024 13:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456669;
	bh=tzdgRpBlFIm+PD09acrAcKWHIEWDJIX3DFIlN8uYEeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h+m6b6NVtPmBpGDYdfL1kxUHHtmSVb888UmwYOyqb1L6lPi3hGUhbOv9mYWk/xvch
	 UHM0bNcQKQjq8qNhJ6gEoOnMLVEwSCofbl3n7LdVmBrGKhMK80XSUE8s+96hrLCV5s
	 flIQq8JCxVbRTtSd/fMHHUQM3DJ0dVYuqoOmFk9HDBVDor3oYQbbO3aSF7euvqfGOd
	 +mOn9IotpTmBGe9z1Toyvxl42na1tma5nAPg25zlXYe1/UILE4JWVCtmr8ZLVgyzeo
	 l2irCY5cbVBsF9K2lvEfW8xK76DirD1Mxudf8kSjhnhFjHoddhQVK1OaA6Q2FWtMmk
	 GbFnpQ1STFmlQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Norbert van Bolhuis <nvbolhuis@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	arend.vanspriel@broadcom.com,
	erick.archer@outlook.com,
	sebastian.reichel@collabora.com,
	saikrishnag@marvell.com,
	krzysztof.kozlowski@linaro.org,
	jacobe.zang@wesion.com,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com
Subject: [PATCH AUTOSEL 4.19 18/21] wifi: brcmfmac: Fix oops due to NULL pointer dereference in brcmf_sdiod_sglist_rw()
Date: Sun, 24 Nov 2024 08:56:51 -0500
Message-ID: <20241124135709.3351371-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135709.3351371-1-sashal@kernel.org>
References: <20241124135709.3351371-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.324
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
index 710dc59c5d34d..532733db4de85 100644
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


