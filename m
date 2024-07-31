Return-Path: <linux-wireless+bounces-10768-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED4A9436DE
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 22:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F21651C2183C
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 20:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F7F60DCF;
	Wed, 31 Jul 2024 20:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P8HkVGsr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E039049627
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 20:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722456602; cv=none; b=j/FMvACzrIvU4pek/vGLdojQeAlHbpVMDGDevGqYuNTHflbHuftwpbdcB0Tg2YI1PRZcrTHbzCyP9MEn3VA3a89dhI0NToim1vapiP+qU/G2v2Uh5sg5GcWL1pT0LP/cp38/aXPhTIcXIpO1Yx04qPSnpEKTwdVlvpY3PWHHPDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722456602; c=relaxed/simple;
	bh=1ubGlpcYE/2DWT4Agz1UcP0YxH8o7VCvJEoQhmvGlsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuHRAEVxrxprG87cL05yO05Bf+q1MtDbsfrrrdRsaGT8hNxVtWW7tuaHnZhpesFZ17s199BbhP2fzGUcrQ5+9Kg7cAlMOGXp3ASUqk/OkLy2gnF1ri6JeXBts02jKv/in8aXUbJldi4d4uPeKUHtFCFuZERLBN+wOjAEjoMfjKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P8HkVGsr; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc5296e214so47092905ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 13:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722456600; x=1723061400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JaLHbNxSR3Nh47oQh+cgLSzO5efw0TLyo01tfcI50XY=;
        b=P8HkVGsr8zYuir1P9UdCkTD1nOjPmfHR0Ohuuq5Qu3a4IdnTH318Ww7LYQPO0zr8+t
         IBscM69cd2hMXDe2UdvFZvungNO+CfBN1ntsgcu5PzHrxw/xYqyFX6leupbGzqst/2rL
         rjhAVStc21bibNoi6AaHekE/EbP1w/Fz3V/XI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722456600; x=1723061400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JaLHbNxSR3Nh47oQh+cgLSzO5efw0TLyo01tfcI50XY=;
        b=IbC2BvLCq2q+fwza7AkPWPU0zCRrk0mMw4tt/1/WPk9mEb+a0aC4saWlmsZyR0ppdD
         iyKSwP7HwNjlRfKC18tWG1nG6Kr65h3WWSU6r+oyaO5EWkXdAcxBhIrt3vkPkxwXGDb5
         97ngeLEeMX6mu5NYN+21lFG4LOtPq3nyNNZSsb+QIj75humGZ3lGMxvhK6tUnsriGooX
         kHzaFz3BkSmuuacE5Z2/Cz57svegPCw8fNeUOR/mY6l4M9Cout66oH5MA/QFbqroOgVR
         600yBznTp3sptbc2xjPvjkjwFDj1pt3xw8Qz7gYZCEQt/zuo/S5QzoUPPrsBDVbp8QH4
         m9XA==
X-Forwarded-Encrypted: i=1; AJvYcCWWi2/1A4fQctDV2r2uknkobAM2vKM6ZtR2wHf9UOKzNl1RFeSrPqeQ8V3T/gg99e9zp8T6O4yCN4nO6/8wrGQLJbPs7bJmSc525rXM928=
X-Gm-Message-State: AOJu0Ywa0znNDD1GmXuPjW3x5RuvKEP/IM4lcxNUvtWTQwfPzjhERVBP
	IQwncVIymDNFwuobcdP/rx+MPWPs2wR5t8T/rDba3pmujU7n7946LdeE8QiYGA==
X-Google-Smtp-Source: AGHT+IG9N7PZALW1ux0Lltq/ntaasOFIA1CM2bkfbNOnutR5t0gPCMJip/XA9Dui3tVLEDr+sL+DdA==
X-Received: by 2002:a17:903:1106:b0:1fd:9fd8:1b2f with SMTP id d9443c01a7336-1ff4ce3545amr5935325ad.8.1722456600097;
        Wed, 31 Jul 2024 13:10:00 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:4fdc:fc44:a6a7:e9b0])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1ff1cf2d07esm69741185ad.294.2024.07.31.13.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 13:09:59 -0700 (PDT)
Date: Wed, 31 Jul 2024 13:09:57 -0700
From: Brian Norris <briannorris@chromium.org>
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	David Lin <yu-hao.lin@nxp.com>
Subject: Re: [PATCH] wifi: mwifiex: Fix two buggy list traversals
Message-ID: <ZqqaFR4lssIfyQwV@google.com>
References: <ff796ca4b4f5610bc2d4a479b8cafbb595c7b3a1.1722362534.git.calvin@wbinvd.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff796ca4b4f5610bc2d4a479b8cafbb595c7b3a1.1722362534.git.calvin@wbinvd.org>

On Tue, Jul 30, 2024 at 11:05:30AM -0700, Calvin Owens wrote:
> Both of these list traversals use list_for_each_entry_safe(), yet drop
> the lock protecting the list during the traversal.
> 
> Because the _safe() iterator stores a pointer to the next list node
> locally so the current node can be deleted, dropping the lock this way
> means the next "cached" list_head might be freed by another caller,
> leading the iterator to dereference pointers in freed memory after
> reacquiring the lock.

There are lots of unclear and/or unsound locking patterns in this
driver. You've probably identified one, although I don't think you've
solved 100% of it.

Here's another: is it valid for mwifiex_11n_rx_reorder_pkt() ->
mwifiex_11n_get_rx_reorder_tbl() to retrieve a 'tbl' pointer (without
removing it from the list), and then continue to operate on that without
holding any locks? (I think the answer is "no".)

Side note: you might also refer to this old thread:
https://lore.kernel.org/all/CAD=FV=VuxFtDdcMndLNzVYDoid8N3jP46j0sOFXG1D4CzX0=Zw@mail.gmail.com/
I don't think Marvell ever fully resolved all the issues there.

> Fix by moving to-be-deleted objects to an on-stack list before actually
> deleting them, so the lock can be held for the entire traversal.
> 
> This is a bit ugly, because mwifiex_del_rx_reorder_entry() will still
> take the rx_reorder_tbl_lock to delete the item from the two on-stack
> lists introduced in this patch. But that is just ugly, not wrong, and
> the function has other callers... making the locking conditional seems
> strictly uglier.

I noticed this "ugliness", but I agree with your reasoning -- it's as
good as we can do here for now.

> I discovered this bug while studying the new "nxpwifi" driver, which was
> sent to the mailing list about a month ago:
> 
> https://lore.kernel.org/lkml/20240621075208.513497-1-yu-hao.lin@nxp.com/
> 
> ...but it turns out the new 11n_rxreorder.c in nxpwifi is essentially
> exactly identical to mwifiex, save for s/mwifiex/nxpwifi/, so I wanted
> to pass along a bugfix for the original driver as well.

That's another can of worms. mwifiex is horrible, and so if you were
asking me, I'd reject any attempt at copy/paste/modify that doesn't make
significant efforts to refactor and improve -- for instance, better
documentation about what all the locks mean, and clarity such that
readers can be confident that the code is doing the right thing. For
example, I think this mwifiex comment is a lie:

	/* spin lock for rx_reorder_tbl_ptr queue */
	spinlock_t rx_reorder_tbl_lock;

I believe it's supposed to protect the elements within the list too --
but it doesn't do a good job of that.

But that's a side track...

> I only have an IW612, so this patch was only tested on "nxpwifi".

I don't think we can accept an untested patch here. If you're lucky,
maybe I or someone else on CC can test for you though.

> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> ---
>  .../wireless/marvell/mwifiex/11n_rxreorder.c  | 26 +++++++++----------
>  1 file changed, 12 insertions(+), 14 deletions(-)

I think the patch looks good enough, but I won't ack it without testing.
And while you're at it, I'd recommend some further auditing, per the
above.

Brian

