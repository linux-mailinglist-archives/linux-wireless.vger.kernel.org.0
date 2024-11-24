Return-Path: <linux-wireless+bounces-15634-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 576DD9D75E7
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 17:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6211EBC71E0
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 14:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F7920DD43;
	Sun, 24 Nov 2024 13:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V25IqutV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DC720DD7A;
	Sun, 24 Nov 2024 13:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455903; cv=none; b=NtiryCPA6j+Q0z1mg3APTuPxefK5HI0CArZKOlghiLmhgJjlMZLNroYbIvdKKMd7QDH6Qh8k4Bn+2pASaSeth7W/BS4LXhaWJGArzIwHSG1zoTPGNY0ifztftVF6ruKeg3MgjhBjk5zuWqP+EPDNh4NU1GwzEGPEBc5ZP4AA104=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455903; c=relaxed/simple;
	bh=EAOHNXTSRR+zbbqHYfgi104IRxBbTR0GP0I6RSdXUFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9XFFtO6Qp6n/p5h2uPD6PBSkCzqQWqU2ivvOedyVxb2xBLr2R1OvMXCO4VYZiHAn6jqG1gnaOm8cgPHPpcgUJIU60rvlI9K+/mbt29xRaZuj8QRPS1P5YRJwNZtJ1Ydx1SdgiK+ycXoPTy1s5B2d/+KuWCHEBCQtIH0mv+Eozs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V25IqutV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85ACBC4CECC;
	Sun, 24 Nov 2024 13:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455903;
	bh=EAOHNXTSRR+zbbqHYfgi104IRxBbTR0GP0I6RSdXUFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V25IqutVF/ju1p+8P9QuSuBCFJRtPEZ3u7sKNo+7SjmLhlNGiweKHlMWkqm3igyrl
	 8M8yDHLURVpw+Hz8238QsEziosW+s9JoOUTyfVild7Q/Kil40P+OU5AtWJRvAF28Og
	 KtG3+WPxeTCTKRXi48l2sNeSEkTKZij1nxCfKvDmju4pWlfyEgDr/upQRFsddhMwmr
	 MZkiSCbRyUF6Kw+1UBDc4rMYCh6ih7IbNDhV8w/zAzbZORrwXeAZGBHqByOJfFZjDa
	 14GDSkrRFErqNOtQ+2VNFUiPXnC2zvGf/4/ZSmGEwcBv9VTL8bU0Xje3tk4oSZiAR7
	 0NMh8B4UVfFJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Norbert van Bolhuis <nvbolhuis@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	arend.vanspriel@broadcom.com,
	megi@xff.cz,
	krzysztof.kozlowski@linaro.org,
	saikrishnag@marvell.com,
	erick.archer@outlook.com,
	jacobe.zang@wesion.com,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com
Subject: [PATCH AUTOSEL 6.11 71/87] wifi: brcmfmac: Fix oops due to NULL pointer dereference in brcmf_sdiod_sglist_rw()
Date: Sun, 24 Nov 2024 08:38:49 -0500
Message-ID: <20241124134102.3344326-71-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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
index d35262335eaf7..8a1e337642448 100644
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


