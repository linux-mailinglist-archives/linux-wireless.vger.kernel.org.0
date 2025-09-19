Return-Path: <linux-wireless+bounces-27511-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC52B88427
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 09:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFC5BB64E16
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 07:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F362C0F7C;
	Fri, 19 Sep 2025 07:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="sU4pEa9h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48231917ED;
	Fri, 19 Sep 2025 07:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267996; cv=none; b=G53P2oOGRiIOCOGulYvPsxTzdur2puLD8tWbT55x9ZsuorApSlSP4B7vQAyIH7D2L5x/4ky/FAsLN0iuO1/U7Z3u89ptLwspPq8wJvPOkebYB0BZELtjJ4pDwXLcy7kGeO4ztvstRgp9vcz55KTLsisPE7ljIEpeKeN9sWf6LNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267996; c=relaxed/simple;
	bh=rvrmYUZgL7bQQ6IjrPjE5dSTAS903szh3gdAerd2LU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opfxsjek97yEGeDZgG+U+emCo56F7HDoGzqEy846xPYTaJFxHuSBigdEc+GbAT5CrWDOFwKFGPRKJQBHY8MSqqvX5lYYp5tkaVBFZjykRezN4FIJBVJL3WDdLPJ+dz50BexMPuGbb8Ddhs4/J3+kK1HnF/KqxKghgr1bFTWhm50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=sU4pEa9h; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.9])
	by mail.ispras.ru (Postfix) with UTF8SMTPSA id 40B084076723;
	Fri, 19 Sep 2025 07:46:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 40B084076723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1758267989;
	bh=vvxr3H1WS7K4t51ln89FsOhtImEKJfiVxLgiE628QEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sU4pEa9h+D76ZLjUJK/7/NZd35pUymq/yu3TJ4+z5lIR6nZ4RTeTTvqK4Yd+vOIhQ
	 VhNziBWwwh/8iK5Oe2zaH+mdWxmxXV2ES6KGlB9oPWQH8wDjGiF3aohrDPeeN1URrS
	 T4e0aKdWfrJngbKnxel9i5i0j2+nuAPK12FJjYGE=
Date: Fri, 19 Sep 2025 10:46:29 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Zong-Zhe Yang <kevin_yang@realtek.com>, 
	Bitterblue Smith <rtl8821cerfe2@gmail.com>, Bernie Huang <phhuang@realtek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH rtw v4 2/4] wifi: rtw89: fix tx_wait initialization race
Message-ID: <20250919102546-7f8366ac69aae3e6d47c65a5-pchelkin@ispras>
References: <20250917095302.2908617-1-pchelkin@ispras.ru>
 <20250917095302.2908617-3-pchelkin@ispras.ru>
 <08b25263c6874a089e4a271cb95a9cb7@realtek.com>
 <20250918173522-07abe99566c12fa46a096fc5-pchelkin@ispras>
 <7a53522bc0004a979fd78b1d6f440457@realtek.com>
 <97aed12182074193b362472d32f0c9a9@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <97aed12182074193b362472d32f0c9a9@realtek.com>

On Fri, 19. Sep 00:50, Ping-Ke Shih wrote:
> Ping-Ke Shih <pkshih@realtek.com> wrote:
> > Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> > > That's a good question and it made me rethink the cause of the race
> > > scenario.  I didn't initially take TX kick off into consideration when
> > > it actually matters.
> > 
> > Do it mean that you pictured the racing scenario in commit message by
> > code review instead of a real case you met?

Yes, the underlying issue for this patch was found by code review only.
Somehow the negative consequences of the potential race became an "obvious"
thing after preparing the first commit, and ignorance of TX kick off
influence made the changelog confusing..

> > 
> > >
> > > The thing is: there might have been another thread initiating TX kick off
> > > for the same queue in parallel.  But no such thread exists because a taken
> > > wiphy lock generally protects from such situations. rtw89_core_txq_schedule()
> > > worker looks like a good candidate but it doesn't operate on the needed
> > > management queues.
> > 
> > Last night I also thought if another thread works in parallel.
> > Maybe rtw89_ops_tx() could be?

Well, probably it could.  I thought rtw89_ops_tx() is wiphy locked, too,
but apparently it's not always the case.

Not that it's a relatively easy-to-hit race I'm going to try to reproduce
though :)

> > 
> > >
> > > So I may conclude this patch doesn't fix any real bug though I'd prefer to
> > > keep it (with description rewritten of course) because it helps to avoid
> > > potential issues in future.
> > 
> > Agree.
> > 
> 
> Forgot to say. Could you mention this racing scenario was found by core
> review and your perspective in commit message? 

Sure.

