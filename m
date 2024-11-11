Return-Path: <linux-wireless+bounces-15182-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54FC9C3E0C
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 13:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75321C21741
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 12:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0486219CC31;
	Mon, 11 Nov 2024 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f47wYn0x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04E919CC29;
	Mon, 11 Nov 2024 12:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731327089; cv=none; b=IZ1tdPwP4iMmNc1AdAuVUQ/wNnSgD4KxtIY9Off9UuA/ohI7zzOROQYR765Bl/bEDpM7AfxD0qIBYKsHtLslMJ0pvjdehWhAjAasbRFBU4Nyf3foxgR7A2AgNOamut1AgGjt/kuKZm7ZPBXTfUlbvOfkoR/hRJbg3UwqDfyBUqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731327089; c=relaxed/simple;
	bh=DetFYAnfOFBjfg4pSj54b1ubIovVT0/G93VdF00jwzo=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=MzJr5hG+BCGFL2jULMec8+7FphJtAnr4Xv0Br/Z02JXGjn0qmExu2loGOxU3J+z47bpQNeTpewSNKItGpVEZHg4Sybi0r/Pyim8JFEY0noQPY0cuArGbpME+prI4k6w3859wq7B5QOkkdR0OkQzhTugYYQJDK2SK3f9YMyQL/9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f47wYn0x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D05C4CED5;
	Mon, 11 Nov 2024 12:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731327089;
	bh=DetFYAnfOFBjfg4pSj54b1ubIovVT0/G93VdF00jwzo=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=f47wYn0xzipkkXnTQmtgEVy2XTMJKKVMCjsoBiaSgYiUEnw88tOxgUbADfGE1a86Y
	 IiUa6F540AdtiS8C/Aw7DXKcf6eKqUulsyLsrKZK/WADVwhNpsVtlySM6PMmAHIAXy
	 ppuVb47MrVqraY1Ys9p7IW4bSS3PkRQsYasSz9QUjNrhUFeuarm+rB7bDyUolVDNi4
	 GxQuJzAtRTjNl/QP+WuCvQGvFLuZf3QoFPsemy2Uxo9NSh1mhWdn15Zfp4SFQJCBTx
	 IjNvWlA45UP7cs6dcRdNooAVXNUCCUBB9hZc4gjmSBOgxHV2noWVgevnyuyUMhx+3R
	 kmJ76KVXkYY5w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v2] wifi: brcmfmac: Fix oops due to NULL pointer dereference in
 brcmf_sdiod_sglist_rw()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20241107132903.13513-1-nvbolhuis@gmail.com>
References: <20241107132903.13513-1-nvbolhuis@gmail.com>
To: nvbolhuis@gmail.com
Cc: brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org,
 arend.vanspriel@broadcom.com, Norbert van Bolhuis <nvbolhuis@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173132708642.852485.9343648144353048729.kvalo@kernel.org>
Date: Mon, 11 Nov 2024 12:11:28 +0000 (UTC)

nvbolhuis@gmail.com wrote:

> From: Norbert van Bolhuis <nvbolhuis@gmail.com>
> 
> This patch fixes a NULL pointer dereference bug in brcmfmac that occurs
> when a high 'sd_sgentry_align' value applies (e.g. 512) and a lot of queued SKBs
> are sent from the pkt queue.
> 
> The problem is the number of entries in the pre-allocated sgtable, it is
> nents = max(rxglom_size, txglom_size) + max(rxglom_size, txglom_size) >> 4 + 1.
> Given the default [rt]xglom_size=32 it's actually 35 which is too small.
> Worst case, the pkt queue can end up with 64 SKBs. This occurs when a new SKB
> is added for each original SKB if tailroom isn't enough to hold tail_pad.
> At least one sg entry is needed for each SKB. So, eventually the "skb_queue_walk loop"
> in brcmf_sdiod_sglist_rw may run out of sg entries. This makes sg_next return
> NULL and this causes the oops.
> 
> The patch sets nents to max(rxglom_size, txglom_size) * 2 to be able handle
> the worst-case.
> Btw. this requires only 64-35=29 * 16 (or 20 if CONFIG_NEED_SG_DMA_LENGTH) = 464
> additional bytes of memory.
> 
> Signed-off-by: Norbert van Bolhuis <nvbolhuis@gmail.com>

Patch applied to wireless-next.git, thanks.

857282b819cb wifi: brcmfmac: Fix oops due to NULL pointer dereference in brcmf_sdiod_sglist_rw()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241107132903.13513-1-nvbolhuis@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


