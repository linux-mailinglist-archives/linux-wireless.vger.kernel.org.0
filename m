Return-Path: <linux-wireless+bounces-15093-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C99219C08A8
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 15:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0754F1C2343D
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 14:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D91021265F;
	Thu,  7 Nov 2024 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXezYgZ7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4276A18FDAF;
	Thu,  7 Nov 2024 14:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730988849; cv=none; b=cDwbRIhT5bkWuW2KMHNb1R/NTfZGkcscgbvxruR9KOsyi1B9ZARL91TI3kythft1wJYUY/IddTI/dJ8+27BwBq6ArNXZdLjFYkU6mV3ijUaybzxFZZQl25ngv9M0gNidatrkAS/2u5sddAcm93dprlNzMzfr0xKqMahr1hTFL+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730988849; c=relaxed/simple;
	bh=cIS71sUh+FXHRudnOBVoewZ7qIlAZ24IeOQvYY7sPfE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=AYhlknpNVQS/VsVhzyyjpleROQre9K0G999CQV8B1a5TC4E7Xh1wuAFg2p64DwpKI2ann0Umo1Xaqrjyrps40otVdvhRWbMQTGMtWiv8D/aikidfS7MUGUR/RIAQkRTwBpnjdHVxXNJ1nM7M8o5L0NC8ht9XaDU20GI5Q0xCDLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXezYgZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947D3C4CECC;
	Thu,  7 Nov 2024 14:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730988848;
	bh=cIS71sUh+FXHRudnOBVoewZ7qIlAZ24IeOQvYY7sPfE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=sXezYgZ7Q/VrooSwIyo0O4VmqPD20fOdNIGWD02y+ik338p9djoGhwFhD/HoawVLw
	 VAWAapSJqfCqRM7nmMDA5qV/oF5lboHhgOW9yMW/fpTtmCqqfL1JjXR5rN67xnClyy
	 aF15WlWqLkTzjitx6g4LrLGMXSRoCisbRSFr5nGJJgLEUn8TUzNzQf2/Klx2NP6hGw
	 eBWirnlnbxAZdPPAkU7HAPiyKmgnFBOjPK7wvbUTnEX5+AzVVdIQ5xuFoW9rq9So/Y
	 7vZG0JXKDb5WFzVaEfebs0zDYWgx50ksPDnAsd1pOo8o60KSt4SP8nrjlr8e5Q4QzU
	 wLt6DDH24j4Vg==
From: Kalle Valo <kvalo@kernel.org>
To: nvbolhuis@gmail.com
Cc: brcm80211@lists.linux.dev,  linux-wireless@vger.kernel.org,
  arend.vanspriel@broadcom.com
Subject: Re: [PATCH v2] wifi: brcmfmac: Fix oops due to NULL pointer
 dereference in 'brcmf_sdiod_sglist_rw'
References: <20241107132903.13513-1-nvbolhuis@gmail.com>
Date: Thu, 07 Nov 2024 16:14:05 +0200
In-Reply-To: <20241107132903.13513-1-nvbolhuis@gmail.com>
	(nvbolhuis@gmail.com's message of "Thu, 7 Nov 2024 14:28:13 +0100")
Message-ID: <87ed3n5dxu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

nvbolhuis@gmail.com writes:

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

What changed from v1? Please include a list of changes after '--' line,
but no need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

