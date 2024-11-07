Return-Path: <linux-wireless+bounces-15039-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DDE9BFFB3
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 09:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A46B1C21365
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 08:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93C01D7989;
	Thu,  7 Nov 2024 08:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYFPGQmw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956011D6DD8
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 08:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730966851; cv=none; b=cyNqSIbP2toZUWNLJsg4j1iWgrrd5MEpa7PmOPkKJck80fPj/NCTVVWh9R9xqHsLLJIpMhutKHfrSGL7FWuraaUukGe66yXR8PSZBa+mMaovV4b9bru/Tyn5YVOYAt7L7vW205gKN+QtDnxQrX29oVPQRhxSNN57dEYEcWlh1/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730966851; c=relaxed/simple;
	bh=AxiV/TY0t91WH7qOcqW/ubqMbsSE4f18YxXFXMyVCeQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Xvox7702+H25HOhlxf7XnlddPA3A4dKbwKZEqTlS8M/va6+svsGx/cz1uLM1eaCxd29WAGC9A1qa+Ly5hXswCYzoCpwB411PdVYuaI2ZF19lPmIkqwWhO/eIz9Q78zgcoCJfq6Z7jnFV2JyqXBvDfA/8oid8+aVuxjDojNC2VVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYFPGQmw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97028C4CED4;
	Thu,  7 Nov 2024 08:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730966851;
	bh=AxiV/TY0t91WH7qOcqW/ubqMbsSE4f18YxXFXMyVCeQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=HYFPGQmw+kQ/4zhZXWSXaabobvwcKgfWwE7U42CqmqVFUGiqGyCnJNaBnhApP12hH
	 h5qV/7SxgIAAVJgAZW6aq6cu5I+5GaSAHe72539dVo4a+HLg/4h9lfABkFBkPdC9i5
	 1YXl9gPnMlp4E+YGQYuOJ86B1xS1lTHosmg3fGLroS1JGFbiO0oelMJilE7WtAA4G1
	 /CnCzX5diJsURzmkVlchgFwyTAAFXhb4e9sgBjyZwoFY9cdboQ25vE0ebP0lBK3jIe
	 zTugP0WZW5c5nLhEF8ZJ6CQeYsVErzOPeRontDEYHgyKgkK8KZ4La1jder6WZPx0PJ
	 tNaUQuICzx/YA==
From: Kalle Valo <kvalo@kernel.org>
To: Norbert van Bolhuis <nvbolhuis@gmail.com>
Cc: linux-wireless@vger.kernel.org,  Norbert van Bolhuis
 <norbert.vanbolhuis@ev-box.com>
Subject: Re: [PATCH] wifi: brcmfmac: Fix oops due to NULL pointer
 dereference in 'brcmf_sdiod_sglist_rw'
References: <20241105204011.1603148-1-norbert.vanbolhuis@ev-box.com>
Date: Thu, 07 Nov 2024 10:07:28 +0200
In-Reply-To: <20241105204011.1603148-1-norbert.vanbolhuis@ev-box.com> (Norbert
	van Bolhuis's message of "Tue, 5 Nov 2024 21:40:11 +0100")
Message-ID: <87bjyrxy9r.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Norbert van Bolhuis <nvbolhuis@gmail.com> writes:

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

BTW it would be good to fix (in a separate patch) the sg handling so
that the kernel won't oops when sg entries rung. That's not really
robust behaviour.

> The patch sets nents to max(rxglom_size, txglom_size) * 2 to be able handle
> the worst-case.
> Btw. this requires only 64-35=29 * 16 (or 20 if CONFIG_NEED_SG_DMA_LENGTH) = 464
> additional bytes of memory.

s-o-b missing, please read our documentation from the link below.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

