Return-Path: <linux-wireless+bounces-14620-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E509B3E99
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 00:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9851C1C21AE2
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 23:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6AB1FB88C;
	Mon, 28 Oct 2024 23:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+NNTwvv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4001F9ED6;
	Mon, 28 Oct 2024 23:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730159101; cv=none; b=JnIeVzi+xmgOeqE8m6EB6UaNcbGGsFfim4cb4/XbdXE0I3Z6PERx/Onqiq3eZ0oLRMKplDmMq6ctN6JLZKiTuS+vtBmB7M5tqgYuUg5tEu475D/apawPppgNO4LSltYTkUBErdT1hXve3YN4EWDbzNP24jnn1MSn0Anj17RT37M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730159101; c=relaxed/simple;
	bh=5COAbv3VoIHsgbAwNn1ky7bzcLv3VohmsdFzVQBHrOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPh+Z6o+f7trTm6sc3WOe3Wlx1Ynn4E4PLxwkYlX4CFPGzB0+SaQ4ty3DbkKndORBSeHrDiqHUNw9hEkMD6ffRXY8V8udNVD+rAGto6Ay1uHFQ4weM4Tl/4Qp+PuLcg1bPxVWwUBNmjaYXEpp0kJ2/ONiRyu90RhIU6U9NRInv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+NNTwvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240FBC4CECD;
	Mon, 28 Oct 2024 23:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730159101;
	bh=5COAbv3VoIHsgbAwNn1ky7bzcLv3VohmsdFzVQBHrOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H+NNTwvvL2PrGedyo8EhCWjLLnF3FekeUL33JewZHd3tJpDIbbCQquhagOvV8AkZu
	 As3rZTXbM+naBTPSx2w+a98a1EBhB/Ormnnf10Sk+6B1T5NsQDfb7qo1nNkEJjzmZJ
	 fHL3wSWM9HCI00zRU+8J/r9ncxZ6I6no3bmETD8JtBmMNqV2QHtwDB4A9jqLZw54K0
	 xp5cMIhp5/d/fQEludaOh5SyJgGV8tK56W6ney2AvNSuqUjpKpiy6jgqVPXPt3wgFs
	 aNtYDeVlEMWVCi0tf5hog5ToIW92Be3nxKiUknZqfY6C2LYP3xQBa113o0x2HgHx+U
	 4XsIgL/KtGHbw==
Date: Mon, 28 Oct 2024 16:44:58 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: vvvvvv@google.com, Johannes Berg <johannes@sipsolutions.net>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] wifi: nl80211: fix bounds checker error in
 nl80211_parse_sched_scan
Message-ID: <202410281644.77B7BEF8E@keescook>
References: <20241028-nl80211_parse_sched_scan-bounds-checker-fix-v1-1-bb640be0ebb7@google.com>
 <bf27a7bf-04ce-4720-a13c-f19e0069541a@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf27a7bf-04ce-4720-a13c-f19e0069541a@embeddedor.com>

On Mon, Oct 28, 2024 at 04:54:43PM -0600, Gustavo A. R. Silva wrote:
> 
> 
> On 28/10/24 16:18, Aleksei Vetrov via B4 Relay wrote:
> > From: Aleksei Vetrov <vvvvvv@google.com>
> > 
> > The channels array in the cfg80211_scan_request has a __counted_by
> > attribute attached to it, which points to the n_channels variable. This
> > attribute is used in bounds checking, and if it is not set before the
> > array is filled, then the bounds sanitizer will issue a warning or a
> > kernel panic if CONFIG_UBSAN_TRAP is set.
> > 
> > This patch sets the size of allocated memory as the initial value for
> > n_channels. It is updated with the actual number of added elements after
> > the array is filled.
> > 
> 
> This should include the following tag (and probably CC stable):
> 
> Fixes: aa4ec06c455d ("wifi: cfg80211: use __counted_by where appropriate")

Agreed.

Reviewed-by: Kees Cook <kees@kernel.org>

-Kees

> 
> Thanks
> --
> Gustavo
> 
> > Signed-off-by: Aleksei Vetrov <vvvvvv@google.com>
> > ---
> >   net/wireless/nl80211.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> > index d7d099f7118ab5d5c745905abdea85d246c2b7b2..9b1b9dc5a7eb2a864da7b0212bc6a156b7757a9d 100644
> > --- a/net/wireless/nl80211.c
> > +++ b/net/wireless/nl80211.c
> > @@ -9776,6 +9776,7 @@ nl80211_parse_sched_scan(struct wiphy *wiphy, struct wireless_dev *wdev,
> >   	request = kzalloc(size, GFP_KERNEL);
> >   	if (!request)
> >   		return ERR_PTR(-ENOMEM);
> > +	request->n_channels = n_channels;
> >   	if (n_ssids)
> >   		request->ssids = (void *)request +
> > 
> > ---
> > base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
> > change-id: 20241028-nl80211_parse_sched_scan-bounds-checker-fix-c5842f41b863
> > 
> > Best regards,
> 

-- 
Kees Cook

