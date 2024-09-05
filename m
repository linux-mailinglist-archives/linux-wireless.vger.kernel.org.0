Return-Path: <linux-wireless+bounces-12540-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4240B96E09B
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 18:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F4089282C95
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 16:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160211A0734;
	Thu,  5 Sep 2024 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClnVUUww"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA5C1A0705;
	Thu,  5 Sep 2024 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555507; cv=none; b=c8pVFIUi6YgtW4GFVMPzFio1fxjh/ul/noY0/JFqdWUbytL7jkB5+vLpcFJ30fL0CXfMNIFba7nrwY7o5L0fk+qX/jHavzIxITW+npW5M7voFfmiJE7pr4/yednSBdnbohmlfK/L/f+YQaRf2iMUPC7qFwKOpzyf/K0IsskGWPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555507; c=relaxed/simple;
	bh=s/RccFZtWPrlWr4dMm8WghMOj8DiuyM1E3+ipiCvMFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFyLqTBpRr7F2bOvPdbreiksjlZPYfebxhz0Gmrbxi3SmhEtPKvqnFpEpxvvArmS5cIVMsT1KTCsyEhPLd2517skklkAy4lbFW8YjSPBlVvms783i+uRSuosDXtmB/A2nJfX4RR509xXbpkhWL2zDtFa+eve0KKgXaBTB+Xms0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClnVUUww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A585DC4CEC3;
	Thu,  5 Sep 2024 16:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725555505;
	bh=s/RccFZtWPrlWr4dMm8WghMOj8DiuyM1E3+ipiCvMFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ClnVUUwwveWTZtV9n/rMtiNDFjBU+fGI0FXIK2HUQGw6FYi1rYoqNa91xEoLx/UY1
	 5Im/Mca1QANX4h6Ur2WEZCobbXhMeisLzmLeRBUJMdrARhg67LR9KOPT4HjyhL4FH5
	 zmOWTMQSGdeRwUGG2V99G9NNANnNAC01PhP/u/N91GV8NzWW+5gyeAg2RgseDhzQAk
	 EYhAUkQRfm5AN/6ZfA2BE+aX413kE9tRSWf83zTB7YfmCYB1E+q+5i93YlIXN+yIKn
	 olS09ehNNlbIcDTv3jtOvF1tnmkasl2wnIRptihqacWKvo4DEr6/4UGNmlehpROZaS
	 DIYNg13VPSsbQ==
Date: Thu, 5 Sep 2024 09:58:25 -0700
From: Kees Cook <kees@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Johannes Berg <johannes.berg@intel.com>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-hardening@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] wifi: cfg80211: fix UBSAN noise in
 cfg80211_wext_siwscan()
Message-ID: <202409050957.7DD6B23EA@keescook>
References: <20240905150400.126386-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905150400.126386-1-dmantipov@yandex.ru>

On Thu, Sep 05, 2024 at 06:04:00PM +0300, Dmitry Antipov wrote:
> Looking at https://syzkaller.appspot.com/bug?extid=1a3986bbd3169c307819
> and running reproducer with CONFIG_UBSAN_BOUNDS, I've noticed the
> following:
> 
> [ T4985] UBSAN: array-index-out-of-bounds in net/wireless/scan.c:3479:25
> [ T4985] index 164 is out of range for type 'struct ieee80211_channel *[]'
> <...skipped...>
> [ T4985] Call Trace:
> [ T4985]  <TASK>
> [ T4985]  dump_stack_lvl+0x1c2/0x2a0
> [ T4985]  ? __pfx_dump_stack_lvl+0x10/0x10
> [ T4985]  ? __pfx__printk+0x10/0x10
> [ T4985]  __ubsan_handle_out_of_bounds+0x127/0x150
> [ T4985]  cfg80211_wext_siwscan+0x11a4/0x1260
> <...the rest is not too useful...>
> 
> Even if we do 'creq->n_channels = n_channels' before 'creq->ssids =
> (void *)&creq->channels[n_channels]', UBSAN treats the latter as
> off-by-one error. Fix this by using pointer arithmetic rather than
> an expression with explicit array indexing and use convenient
> 'struct_size()' to simplify the math here and in 'kzalloc()' above.
> 
> Fixes: 5ba63533bbf6 ("cfg80211: fix alignment problem in scan request")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

This looks correct -- the offset is based on the allocation base, not
the array within the struct, so no array-out-of-bounds warning will
happen.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

