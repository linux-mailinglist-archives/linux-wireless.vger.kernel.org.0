Return-Path: <linux-wireless+bounces-7376-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE638C0C1A
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 09:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 760C6B22E42
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 07:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5122D14830B;
	Thu,  9 May 2024 07:48:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B82613C9A9;
	Thu,  9 May 2024 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715240886; cv=none; b=Ot5TBiaDUCotQtM6gFSE06c8e1avCsNmdjqaizAp5QZVyPTy+g4vAiWZit2i/J7AQDs+RFdus5iXesLqO4cg0cv/Cm90yt0ANK/zG3E4IB8Sf5j2q4mEVNECu0/et5kKoM3YTu3ZE3Yky3mAkWXHd5tC/04FajVFGkxtKLNgPMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715240886; c=relaxed/simple;
	bh=kN+bKRWuS9MvO+76b3+xoXzaruyf/lT+taQHwjLtY14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKCnPT7yJXNSvFpiHPKARhwxK28XsVB9chZdk6NmXd3a4vqdl2D34wdV6MXPIgE70Qiz6sbBFohq2xQvW2h+10QhppgApnYLtHh3XUh8GytBan6H/SpnPb4fcDGHiznTBazIablLB+iUQZSyzEtGam9Mg7jdOB1bSZfYRrkM3aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a599eedc8eeso139755966b.1;
        Thu, 09 May 2024 00:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715240883; x=1715845683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxfOpPMsocBoDaEIN71vPXTKGsCKIeOGUMJaK6ulrpg=;
        b=NP7jrO7BF1cC9oleKfv2/H+LAA0u8jKf8K2H3mtvH899fyZAM37Y5d4FlM9FRI4Cn0
         oXaL9vMWRDTapmol1OEdRwwgOhR9/laEOoVg8Jw2MuqIMbMtngKgqyCqm8MFDQjvjwGW
         XapHXJwEeE1HjanIot6jeLGvubDAhQ8tmMXuUqxI9Z3CL5DhECIIM/FPehwZ8tC51O9m
         Yzr4xmnK9EWqokFMHsszb69PontEMWEqavRnJFo3XtPQg0Zctm27M7/EYNLsXkFWvNZU
         gkufQ3HaNstTyjirJKc3/XaSYfsbcdccWJAGYicJ2hScfg2/uoV3DHb8FrM0q6pMNNN8
         zuig==
X-Forwarded-Encrypted: i=1; AJvYcCWA8evcqQojlj7NPLgTm68n2sF8El/Weh/2f9WMocvHwkqsdGqHtEp5kSfUitt+G88vlkH5FYEWJtsF8Jp4jdC74YEn9Jjc0VbcqKKanitQ9Al4mRJ/apAvonvj4riTlhl33Dtv3xQobT3vteI=
X-Gm-Message-State: AOJu0YxOD9dUVlL701CcLI7ImEOkmIIUNgqg0ApUllquzqGXfoKXQqMo
	jPAOZSiOrjbOB1aoCYuPQx8wYawoNL8L9GZKV3Pki5pF3mqoFAHzCvsf7A==
X-Google-Smtp-Source: AGHT+IEsCEKh9Z9Jdg775iWofQ3lVXXivWgv02ahksqj0qaQJVuDtBqjcMD77dWZbIcqAK5u4pyzKg==
X-Received: by 2002:a50:8e4a:0:b0:572:a731:dd14 with SMTP id 4fb4d7f45d1cf-5731da5b711mr3204050a12.28.1715240882494;
        Thu, 09 May 2024 00:48:02 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bea6592sm422836a12.2.2024.05.09.00.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 00:48:02 -0700 (PDT)
Date: Thu, 9 May 2024 00:48:00 -0700
From: Breno Leitao <leitao@debian.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>, "leit@meta.com" <leit@meta.com>,
	"open list:REALTEK WIRELESS DRIVER (rtw89)" <linux-wireless@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH wireless] wifi: rtw89: Un-embed dummy device
Message-ID: <Zjx/sKB++v8FJMXx@gmail.com>
References: <20240424182351.3936556-1-leitao@debian.org>
 <f46ae94488d1468e9a9a669320e4cfb9@realtek.com>
 <87ttjqgf2r.fsf@kernel.org>
 <87mspigex0.fsf@kernel.org>
 <acda4194c8d44690b05b83adccb3aa22@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acda4194c8d44690b05b83adccb3aa22@realtek.com>

On Thu, Apr 25, 2024 at 06:15:21AM +0000, Ping-Ke Shih wrote:
> Kalle Valo <kvalo@kernel.org> wrote:
> > Kalle Valo <kvalo@kernel.org> writes:
> > 
> > > Ping-Ke Shih <pkshih@realtek.com> writes:
> > >
> > >> Breno Leitao <leitao@debian.org> wrote:
> > >>> Embedding net_device into structures prohibits the usage of flexible
> > >>> arrays in the net_device structure. For more details, see the discussion
> > >>> at [1].
> > >>>
> > >>> Un-embed the net_device from the private struct by converting it
> > >>> into a pointer. Then use the leverage the new alloc_netdev_dummy()
> > >>> helper to allocate and initialize dummy devices.
> > >>>
> > >>> [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
> > >>>
> > >>> Signed-off-by: Breno Leitao <leitao@debian.org>
> > >>
> > >> I think this patch should go via net-next tree, because wireless-next tree
> > >> doesn't have patch of dummy devices yet.
> > >>
> > >> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> > >
> > > FWIW I sent the wireless-next pull request yesterday and once it pulled
> > > we will fast forward wireless-next to latest net-next.
> > 
> > Oh, I just realised that this is not CCed to netdev so their patchwork
> > won't even see the patch. Ping, I recommend that you wait for the
> > dependency commits to trickle down to your tree and then apply the
> > patch. That's the simplest approach and no need to resend anything.
> 
> Okay. If we don't hurry to get this patch merged, I will apply this patch
> to my tree.

There is no hurry to get this patch merged.

Out of curiosity, why don't you rebase your tree to net-next/linux-next
frequently?

