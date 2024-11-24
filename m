Return-Path: <linux-wireless+bounces-15639-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF339D739D
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 15:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6140628355B
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 14:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305601E0B84;
	Sun, 24 Nov 2024 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osXcdr0I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F248B22D8AC;
	Sun, 24 Nov 2024 13:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456127; cv=none; b=hD2qMUZ49GEWUBJZCRdgum5MALqenhb4u/47yUZ5gEJFW47bgN+82NIx4XuNtjypo1ekB247k3mt/Ybs0UVMBNslLosBzslNT15xTFO2Je4mPoKDWeZ8VMdI/xzd3BkoyYnk36L64WiMHIXLrpPXIWJrKt2ejQyMYvOZGPa8www=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456127; c=relaxed/simple;
	bh=bH8rF4pvqhkLX9MmqDxbmk8XE1OmQ3C9OYOXM8n5uiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5v+SWoKKIm53edPi5Z8+BWv7g7Ie0hI9ZHt49MrOKOSEvR44sW3yZKgPBZTq758ATvbK+XFWHuOZxFkRnF33my00sY0oP7ML5Nzn/f/qkeBoYvYbm5QG4ZoQj8F6yCKVlU4MI8HniPSet6COCfQ5ux9FYXyC5K0vIiLG0haLB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osXcdr0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1195DC4CED3;
	Sun, 24 Nov 2024 13:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456126;
	bh=bH8rF4pvqhkLX9MmqDxbmk8XE1OmQ3C9OYOXM8n5uiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=osXcdr0IiLwap4GDLhfTeQQlPpnVx7F7JqxhIIGXLC6sZwCxTWi6n9fLtbZXoteAc
	 0R33labsaVRxjFvH7U1/QaWC9eeFB7Iiyo7BB8HwKna5/7J5skqERHxabcz7W/XHVm
	 Rt1d9LTEwAEXnC5iocSRKar8neaQAJoso/kKFW4g+EfuS40Bpw2jc0e8ZNtQvFdp7v
	 qWJE4ROaa/LqDUOruSLmQaLRRBAnLcOjxODKcEQaG4wh/pERsR6xoXoinVYS5YioEq
	 RVsvpDZ2RtfCillzdycLyRdbJSsjyciKu6I9Zeqc66BbDP79l8XvK3x3r7YyzIYRXB
	 wJeWd4uKgV+4g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Norbert van Bolhuis <nvbolhuis@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	arend.vanspriel@broadcom.com,
	ulf.hansson@linaro.org,
	sebastian.reichel@collabora.com,
	jacobe.zang@wesion.com,
	erick.archer@outlook.com,
	krzysztof.kozlowski@linaro.org,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com
Subject: [PATCH AUTOSEL 6.6 50/61] wifi: brcmfmac: Fix oops due to NULL pointer dereference in brcmf_sdiod_sglist_rw()
Date: Sun, 24 Nov 2024 08:45:25 -0500
Message-ID: <20241124134637.3346391-50-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134637.3346391-1-sashal@kernel.org>
References: <20241124134637.3346391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
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
index 00679a990e3da..7710367c319ec 100644
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


