Return-Path: <linux-wireless+bounces-15106-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D7D9C0CD7
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 18:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A1151F22873
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 17:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CA8215F72;
	Thu,  7 Nov 2024 17:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPuEi8ki"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0E7DDBE;
	Thu,  7 Nov 2024 17:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731000286; cv=none; b=kyrQfoVM4KoV9MYRoIFhzyFBeG7Ejag0qkt4Bd82tmaSuu4gohEJzRSYNMP5uaKUH92W3DK4N1So3YAbg3PcujwDpqFsZuOOlO18ZGRVdcA6JCWJa2g8nr9E/X/0YgxZMuK+vRnTLJyyZVqxjC8NGkyFQNONOS4Njt7+MQWaEPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731000286; c=relaxed/simple;
	bh=sg2Dc3F6xQkzhFA7IWW2guSDvBgmwZwByl6ILrJ9EIA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=QfxejUWRxtievDJbB0eVV8+YKncmjFGYOzS1gBQLLUXz5tB3LuXgIPCJ2O5nu16/VxdbSHmZ0b5hKNV0h3BjxZt2lNnzCORjkPAOWW46KiBGuyhYxJFySpbr+fruAMp6kidcEXd4++ms4tTJomrxNWP50+ep6XgKCPAB2L6xlYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPuEi8ki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB0EC4CECC;
	Thu,  7 Nov 2024 17:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731000286;
	bh=sg2Dc3F6xQkzhFA7IWW2guSDvBgmwZwByl6ILrJ9EIA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=bPuEi8kiWS44lOnll1Q/XLOMk/lcyjmhgKQbSGeTenMDfSJBp0eHXTbsoknYLst1B
	 9a2Vvnx8mRGNMBp6mA421mcjI9UkdRcGJ/BaD8ndSKNVQBWJNra3KmJMyWng1UP1Gg
	 POG+cX8YpVsC6hgn+r1W7z1p7M9T86cYVLPuTwFKzRkE1yx1IpqPMGF20neVE8KPPK
	 tYvw8OOPZ+uIAYakDV29TDow2CI6BpDo3azWV+OMdZODWR9Ij+US3ntNePmf/Y1SOQ
	 DHZck/gS/x1ecVsbDqUb5i8W65h9n4iykdOUm6O5d0UoiELmfWIYGNKDr09tT3eVe+
	 NuD5xZjpadh3A==
From: Kalle Valo <kvalo@kernel.org>
To: N van Bolhuis <nvbolhuis@gmail.com>
Cc: brcm80211@lists.linux.dev,  linux-wireless@vger.kernel.org,
  arend.vanspriel@broadcom.com
Subject: Re: [PATCH v2] wifi: brcmfmac: Fix oops due to NULL pointer
 dereference in 'brcmf_sdiod_sglist_rw'
References: <20241107132903.13513-1-nvbolhuis@gmail.com>
	<87ed3n5dxu.fsf@kernel.org>
	<CAP6rjy=gjbQg6hF4xzKZjabdtGVYijrPhn7zUHiw3ZHFJbQfWA@mail.gmail.com>
Date: Thu, 07 Nov 2024 19:24:43 +0200
In-Reply-To: <CAP6rjy=gjbQg6hF4xzKZjabdtGVYijrPhn7zUHiw3ZHFJbQfWA@mail.gmail.com>
	(N. van Bolhuis's message of "Thu, 7 Nov 2024 17:09:36 +0100")
Message-ID: <875xoz5544.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

N van Bolhuis <nvbolhuis@gmail.com> writes:

> Op do 7 nov 2024 om 15:14 schreef Kalle Valo <kvalo@kernel.org>:
>
>>
>> nvbolhuis@gmail.com writes:
>>
>> > From: Norbert van Bolhuis <nvbolhuis@gmail.com>
>> >
>> > This patch fixes a NULL pointer dereference bug in brcmfmac that occurs
>> > when a high 'sd_sgentry_align' value applies (e.g. 512) and a lot of queued SKBs
>> > are sent from the pkt queue.
>> >
>> > The problem is the number of entries in the pre-allocated sgtable, it is
>> > nents = max(rxglom_size, txglom_size) + max(rxglom_size, txglom_size) >> 4 + 1.
>> > Given the default [rt]xglom_size=32 it's actually 35 which is too small.
>> > Worst case, the pkt queue can end up with 64 SKBs. This occurs when a new SKB
>> > is added for each original SKB if tailroom isn't enough to hold tail_pad.
>> > At least one sg entry is needed for each SKB. So, eventually the "skb_queue_walk loop"
>> > in brcmf_sdiod_sglist_rw may run out of sg entries. This makes sg_next return
>> > NULL and this causes the oops.
>> >
>> > The patch sets nents to max(rxglom_size, txglom_size) * 2 to be able handle
>> > the worst-case.
>> > Btw. this requires only 64-35=29 * 16 (or 20 if CONFIG_NEED_SG_DMA_LENGTH) = 464
>> > additional bytes of memory.
>> >
>> > Signed-off-by: Norbert van Bolhuis <nvbolhuis@gmail.com>
>>
>> What changed from v1? Please include a list of changes after '--' line,
>> but no need to resend because of this.
>>
>
> Nothing changed, I just added the s-o-b.

That's still something you should mention in the changelog, but this
mail is good enough this time.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

