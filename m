Return-Path: <linux-wireless+bounces-10977-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C00709484E6
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 23:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8E761C2208B
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 21:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDB916DED9;
	Mon,  5 Aug 2024 21:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="e9FbeDpt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB3E16C6AB
	for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2024 21:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722893641; cv=none; b=d+kh07PDUgFUYO/e28LlT0cpmyaHbd4eFA2L/gkSIibNTfVCKzFTlUqmrSm2jm9tfycxNXVzXWNVTuBbwCVHaWa8hh9jjfyAuCUlt2t6gS4lNmpxwwnqWKHTM6t0BYwQyG2qaxAyQkLbuMvmbijDmKbo4YhiunXORBqdhvVGOhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722893641; c=relaxed/simple;
	bh=+OihDy2QMh9owS7QvFjKcmh9vJtkO7Nd5o90hj1oHxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgmewDtSNcAWsPKXWZULksxPF33v5qQOWT8j0lX3A+DT8+PYIEgV0vfi/8DkyGPzDVcQ5rQ99aWnLk3D+aOLh8W/FxymOC376qrZTt2eQ7WvifrIqv4EZNv2cBtckwcit+P1tN0bJUDDzU7+sYA3+sos7TgUzVkB5e2mg1oLj2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=e9FbeDpt; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2cd46049d2bso57271a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 05 Aug 2024 14:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1722893639; x=1723498439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ip6TO0IhAcQmNoYEQtR7Rnuy+pRKC2MihtReYP0wVTE=;
        b=e9FbeDptYoar834wp3jdgLySoFFxbGZoFnz9m+4MwHzsLqF9w+OnGFc/n1v4y4P3vw
         WUW/2jaB8FqjWg62D0BVGvCdhHPp9D5GBypnpFCqPGOjLUKcTS3qpGIYkGdxQwOCQ4yh
         OO9jIhlU9CLd0rk7DyUFdiRAePunPAM+aRJp3KrgIeS68Yx8UlIUJVE8R/nNnS7etpr2
         Jk5oUvYEfH0zxVvvOLFhGjZ4kpa668gvXkHtdX4MfuBGO7gBGh+HOylpG+BYdmsfTB/L
         Puo6J+UnJx0ewH01DRvfMjCbRSQYFYJ7tB88p7Sgi3FZTTPS6A2shapX3d04REbE7Z8l
         51iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722893639; x=1723498439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ip6TO0IhAcQmNoYEQtR7Rnuy+pRKC2MihtReYP0wVTE=;
        b=WA1LA88TfVRVeGPkfmij7/tYLkoaVHDg+GJwiRJc/HTTCDTqEcvLnWiSpq5LIvMku7
         M8kwqpppXW/UaLGQUIO3M/iDg3Qo32BtY9F+DLkKauNBacKhwyD6d4Sg5NM+dqR4TFzE
         zxWgM2qsQoJbW1mxvcGKQRpY94kNqmEoos5gMN2etsmumatj+7TckisswdCSv+lqU8qn
         VAyR6wNRsoRoZONZNT4DioZC0+e/OQnBpTYVlKhgjtBM2GptDMuTB8iBBWxpGEMhB13I
         a/02ysctg2HT1HYpGbc54rzHxs03S6MVmoIyf1WHFO/qaB/OZMgGiCb2t4apcq9k0LWx
         pBPw==
X-Forwarded-Encrypted: i=1; AJvYcCVimcAI3s8qz2t3FQX8qS5L1M5VyO1TfxqheAg0NCuuwuUgbEPRzyKm4Op19N2VNbaalNJaiPLHHt9tHKkVBg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3WH0tKjC+EmanN2UyKj5NY6q+bdtg6jD9iIL8rly2wTtjYC35
	cC9r8F8g7UYLsRQ+3PbRHrsP47korOZkWft0GtSEUqKBg0kTV656hrpnndkIQJM=
X-Google-Smtp-Source: AGHT+IHcQ1qaQjhwAyTjvY4/wiu+fGdi0PeJaAkST4Q8rbXHKOIO0itktmif+/lamlf2mZsiFQDVZQ==
X-Received: by 2002:a17:903:2352:b0:200:69e9:5c87 with SMTP id d9443c01a7336-20069e96549mr28197185ad.1.1722893638899;
        Mon, 05 Aug 2024 14:33:58 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:4687:7900:2bc9:7663:1e71:adfe])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5905b52bsm73633755ad.176.2024.08.05.14.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 14:33:58 -0700 (PDT)
Date: Mon, 5 Aug 2024 14:33:55 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Brian Norris <briannorris@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	David Lin <yu-hao.lin@nxp.com>
Subject: Re: [PATCH] wifi: mwifiex: Fix two buggy list traversals
Message-ID: <ZrFFQ-dOmgL99CfF@mozart.vkv.me>
References: <ff796ca4b4f5610bc2d4a479b8cafbb595c7b3a1.1722362534.git.calvin@wbinvd.org>
 <ZqqaFR4lssIfyQwV@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZqqaFR4lssIfyQwV@google.com>

On Wednesday 07/31 at 13:09 -0700, Brian Norris wrote:
> On Tue, Jul 30, 2024 at 11:05:30AM -0700, Calvin Owens wrote:
> > Both of these list traversals use list_for_each_entry_safe(), yet drop
> > the lock protecting the list during the traversal.
> > 
> > Because the _safe() iterator stores a pointer to the next list node
> > locally so the current node can be deleted, dropping the lock this way
> > means the next "cached" list_head might be freed by another caller,
> > leading the iterator to dereference pointers in freed memory after
> > reacquiring the lock.
> 
> There are lots of unclear and/or unsound locking patterns in this
> driver. You've probably identified one, although I don't think you've
> solved 100% of it.
> 
> Here's another: is it valid for mwifiex_11n_rx_reorder_pkt() ->
> mwifiex_11n_get_rx_reorder_tbl() to retrieve a 'tbl' pointer (without
> removing it from the list), and then continue to operate on that without
> holding any locks? (I think the answer is "no".)
> 
> Side note: you might also refer to this old thread:
> https://lore.kernel.org/all/CAD=FV=VuxFtDdcMndLNzVYDoid8N3jP46j0sOFXG1D4CzX0=Zw@mail.gmail.com/
> I don't think Marvell ever fully resolved all the issues there.

That's all helpful, thank you.

> > Fix by moving to-be-deleted objects to an on-stack list before actually
> > deleting them, so the lock can be held for the entire traversal.
> > 
> > This is a bit ugly, because mwifiex_del_rx_reorder_entry() will still
> > take the rx_reorder_tbl_lock to delete the item from the two on-stack
> > lists introduced in this patch. But that is just ugly, not wrong, and
> > the function has other callers... making the locking conditional seems
> > strictly uglier.
> 
> I noticed this "ugliness", but I agree with your reasoning -- it's as
> good as we can do here for now.
> 
> > I discovered this bug while studying the new "nxpwifi" driver, which was
> > sent to the mailing list about a month ago:
> > 
> > https://lore.kernel.org/lkml/20240621075208.513497-1-yu-hao.lin@nxp.com/
> > 
> > ...but it turns out the new 11n_rxreorder.c in nxpwifi is essentially
> > exactly identical to mwifiex, save for s/mwifiex/nxpwifi/, so I wanted
> > to pass along a bugfix for the original driver as well.
> 
> That's another can of worms. mwifiex is horrible, and so if you were
> asking me, I'd reject any attempt at copy/paste/modify that doesn't make
> significant efforts to refactor and improve -- for instance, better
> documentation about what all the locks mean, and clarity such that
> readers can be confident that the code is doing the right thing. For
> example, I think this mwifiex comment is a lie:
> 
> 	/* spin lock for rx_reorder_tbl_ptr queue */
> 	spinlock_t rx_reorder_tbl_lock;
> 
> I believe it's supposed to protect the elements within the list too --
> but it doesn't do a good job of that.
> 
> But that's a side track...
> 
> > I only have an IW612, so this patch was only tested on "nxpwifi".
> 
> I don't think we can accept an untested patch here. If you're lucky,
> maybe I or someone else on CC can test for you though.
>
> > Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> > ---
> >  .../wireless/marvell/mwifiex/11n_rxreorder.c  | 26 +++++++++----------
> >  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> I think the patch looks good enough, but I won't ack it without testing.
> And while you're at it, I'd recommend some further auditing, per the
> above.

Understood. I was honestly a bit hesitant to send this in the first
place without some sort of reproducer, I'll sit on the patch until I'm
able to find one.

Thanks,
Calvin

> Brian

