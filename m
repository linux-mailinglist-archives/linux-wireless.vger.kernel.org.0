Return-Path: <linux-wireless+bounces-15053-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6A59C0180
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 10:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278B31F23B40
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 09:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4E31E885A;
	Thu,  7 Nov 2024 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oICwKLaA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0381B1E6DC1;
	Thu,  7 Nov 2024 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730973095; cv=none; b=c4vlCIC9obzvxlawj+tIk0jGBdFBnFczvW2JceyO0do/ACGlUwDDOsJfE3SvdAyzkeiIxrc9jS16f83NcUsz7+Kbk8DL6gYdN6pzb2UXT2kxyLAOFPft4wKafrNCWvRDIESl+lrvTOoZcDF85Bubqai9UrkFTLHXkzl2+rgTfrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730973095; c=relaxed/simple;
	bh=/IdXjqlAmCFhFABuq2r8X4m9cv2M7M7fh/5gnWXWKjY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=MoeNhiS4H7yyngLiVp4tYm/nMuug1AHv9WJu1Z2HdYvpYp9iwrMFzWGGP3HgfrUe/zuQQO94sGYAKKfhGLHo2LpcZGY7F98N3c/ZqpSXzuZ0j8OUd8XkxNTfgUr3SusRZMlaywty4j2HLxDPgX73z/L0tq9XvX9jHg7kVG3VkNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oICwKLaA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79056C4CECC;
	Thu,  7 Nov 2024 09:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730973093;
	bh=/IdXjqlAmCFhFABuq2r8X4m9cv2M7M7fh/5gnWXWKjY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=oICwKLaAX+Sv7KWhk5XM25wPgtlhX5oiH7E40PJpLP6QcgBYq1ShlQZeVLrv9DSjr
	 SVjzSBVYDcsIIKuTC7sRDcbCclM0J7TwIctxKK7RjhsmESVp1S2Q3vpb8XDKrvUlrS
	 8rsUWEm65NfSU5q2ECzMtB7Sr6uyRMtysGTCXfbhVHo+/zA+8Kpnel9p0THau0Lu07
	 esTFaS1DWGvndd3xePsn0ueeW2CDrsLWJRbw00xn/tl6JbHXJoeI0KLfpZPDjSwd4j
	 4Ulg7Kxd/zVeV3D1Z0LwXu7RJ8spO2YIgTbY6nswAnorZUZXIl9pwD1Hwp2Vv1lSaT
	 R4yMT+pDBltxw==
From: Kalle Valo <kvalo@kernel.org>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Norbert van Bolhuis <nvbolhuis@gmail.com>,
  linux-wireless@vger.kernel.org,  Norbert van Bolhuis
 <norbert.vanbolhuis@ev-box.com>, brcm80211@lists.linux.dev
Subject: Re: [PATCH] wifi: brcmfmac: Fix oops due to NULL pointer
 dereference in 'brcmf_sdiod_sglist_rw'
References: <20241105204011.1603148-1-norbert.vanbolhuis@ev-box.com>
	<87bjyrxy9r.fsf@kernel.org>
	<a2699327-0f86-4c70-8ca4-1225f3e712d1@broadcom.com>
Date: Thu, 07 Nov 2024 11:51:30 +0200
In-Reply-To: <a2699327-0f86-4c70-8ca4-1225f3e712d1@broadcom.com> (Arend van
	Spriel's message of "Thu, 7 Nov 2024 10:31:53 +0100")
Message-ID: <87iksz5q3h.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arend van Spriel <arend.vanspriel@broadcom.com> writes:

> On 11/7/2024 9:07 AM, Kalle Valo wrote:
>
>> Norbert van Bolhuis <nvbolhuis@gmail.com> writes:
>> 
>>> This patch fixes a NULL pointer dereference bug in brcmfmac that occurs
>>> when a high 'sd_sgentry_align' value applies (e.g. 512) and a lot of queued SKBs
>>> are sent from the pkt queue.
>>>
>>> The problem is the number of entries in the pre-allocated sgtable, it is
>>> nents = max(rxglom_size, txglom_size) + max(rxglom_size, txglom_size) >> 4 + 1.
>>> Given the default [rt]xglom_size=32 it's actually 35 which is too small.
>>> Worst case, the pkt queue can end up with 64 SKBs. This occurs when a new SKB
>>> is added for each original SKB if tailroom isn't enough to hold tail_pad.
>>> At least one sg entry is needed for each SKB. So, eventually the "skb_queue_walk loop"
>>> in brcmf_sdiod_sglist_rw may run out of sg entries. This makes sg_next return
>>> NULL and this causes the oops.
>> BTW it would be good to fix (in a separate patch) the sg handling so
>> that the kernel won't oops when sg entries rung. That's not really
>> robust behaviour.
>> 
>>> The patch sets nents to max(rxglom_size, txglom_size) * 2 to be able handle
>>> the worst-case.
>>> Btw. this requires only 64-35=29 * 16 (or 20 if CONFIG_NEED_SG_DMA_LENGTH) = 464
>>> additional bytes of memory.
>> s-o-b missing, please read our documentation from the link below.
>
> I have not seen the actual patch. Which mailing list was it sent to?

Only to linux-wireless, adding brcm80211 now. But the patch is in
patchwork:

https://patchwork.kernel.org/project/linux-wireless/patch/20241105204011.1603148-1-norbert.vanbolhuis@ev-box.com/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

