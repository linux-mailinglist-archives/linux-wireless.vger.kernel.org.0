Return-Path: <linux-wireless+bounces-14373-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEA79AC6CE
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 11:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F39282984
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 09:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9321919D081;
	Wed, 23 Oct 2024 09:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0t+W+b8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B1119CC3D;
	Wed, 23 Oct 2024 09:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729676322; cv=none; b=DD70QJubKLoOoW/5S8y9OwmthNXaw8J1MQw0CxWGEqui0b/wY0lcR+cmSXUdmt5mI8SLnQLhQS6qCKEuylX2mSzPlITMyirz5r08g+QvjAAfhOac5ktbGnKrHy8ZF3JmIA7lrtF5+B+WxshO3TwMre40iRnoyCpLCekzhjG7jbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729676322; c=relaxed/simple;
	bh=w4KZcn51zq8TWc923K/kPofkOpDdSfYPdV59SxQYJEQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=io4+JZLfGHBOgldL+TVEPvHBsxOxwGsXwSkp4RhWPXI6xxSLwHh3eFGq7nH0miRg719UDC9h/LIZARgZqKbdwZuGvT9n16+2YPIIKNUF0TH/j/xAEvPtcazRg9kKCkXGQY2hYNWOjb3G6l/gTQ2r8qCBYRpLm3qRNUeVJcbJucU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0t+W+b8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912DCC4CEC6;
	Wed, 23 Oct 2024 09:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729676321;
	bh=w4KZcn51zq8TWc923K/kPofkOpDdSfYPdV59SxQYJEQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=D0t+W+b8N+s9blvEiyQV5TDmLxXZQJWOBKu+TPTyb8e/5/a8d/hSbF/qw3xx58fcu
	 KAP0NVGO0j5N8u9O2nYnp49qaDGdVBppm/pQzIqV5yLpNF5MxaQcccAwBqlXLDny4C
	 vFVYXa0x+LI1IAVIxDAaRd4yU1uNboG/sDeNCdOiJ8OxDM9NlN8dM0bDJr0mjH7HrT
	 n+fbzrAAs6EN9sNMZH+7nolZlw6M8MLF6i/iNHbZHmubErz7xPjtLGL5zTvZUwvoxC
	 vYGqfanir4egnbiUVZQ/a2UZoMju3T+m4tI/KEqOw6QhD7pSpj24Zwd+IsSF7puG35
	 l9gLgTWV/Fj4w==
From: Kalle Valo <kvalo@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,  Zong-Zhe Yang
 <kevin_yang@realtek.com>,  "linux-wireless@vger.kernel.org"
 <linux-wireless@vger.kernel.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,  "kernel-janitors@vger.kernel.org"
 <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH next] wifi: rtw89: unlock on error path in
 rtw89_ops_unassign_vif_chanctx()
References: <8683a712-ffc2-466b-8382-0b264719f8ef@stanley.mountain>
	<6a80d4adc51f4ea884b5e02f16d8aaed@realtek.com>
	<931c79c15bc04be99bb87a9826cf2b04@realtek.com>
	<2e85c84b-31bf-484b-b3e2-9285999bb2e4@stanley.mountain>
Date: Wed, 23 Oct 2024 12:38:38 +0300
In-Reply-To: <2e85c84b-31bf-484b-b3e2-9285999bb2e4@stanley.mountain> (Dan
	Carpenter's message of "Wed, 23 Oct 2024 11:35:09 +0300")
Message-ID: <87v7xjma5d.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Carpenter <dan.carpenter@linaro.org> writes:

> On Tue, Oct 22, 2024 at 03:32:23AM +0000, Ping-Ke Shih wrote:
>
>> Zong-Zhe Yang <kevin_yang@realtek.com> wrote:
>> > Dan Carpenter <dan.carpenter@linaro.org> wrote:
>> > >
>> > > [...]
>> > >
>> > > @@ -1373,6 +1373,7 @@ static void rtw89_ops_unassign_vif_chanctx(struct ieee80211_hw
>> > > *hw,
>> > >
>> > >         rtwvif_link = rtwvif->links[link_conf->link_id];
>> > >         if (unlikely(!rtwvif_link)) {
>> > > +               mutex_unlock(&rtwdev->mutex);
>> > >                 rtw89_err(rtwdev,
>> > >                           "%s: rtwvif link (link_id %u) is not active\n",
>> > >                           __func__, link_conf->link_id);
>> > >
>> > 
>> > Acked-by: Zong-Zhe Yang <kevin_yang@realtek.com>
>> > 
>> 
>> Thanks for the ack. 
>> 
>> Acked-by is often used by the maintainer, so I will change it to Reviewed-by
>> during committing. 
>
> To me Acked by just means you're okay with the patch.  When I use it, it means I
> don't feel qualified or interested enough to do a full review.  For example, if
> I complain about a v1 patch and they fix my issue in v2 then I like to say that
> I'm okay with it.  In that case I'll use Reviewed-by for a full review or Acked
> by if the bits that I care about are okay.  I don't like to complain and then
> just go silent.
>
> In the end, it doesn't make any difference.  You'll get CC'd on bug reports to
> do with the patch and you'll potentially feel bad for not spotting the bug, I
> guess.

I have understood that Acked-by should be only used by the corresponding
maintainers and the documentation seems to say the same:

https://docs.kernel.org/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

The reason I ask non-maintainers avoid using Acked-by is that it messes
our patchwork listings (it counts both Acked-by and Reviewed-by tags).

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

