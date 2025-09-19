Return-Path: <linux-wireless+bounces-27517-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81837B892C1
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 13:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4496D1B232B1
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 11:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FA930BB9E;
	Fri, 19 Sep 2025 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Rn4GAO1I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE1730B52E;
	Fri, 19 Sep 2025 11:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758279613; cv=none; b=XdemOGgboq65lYFFa4Phe9tc1tsssSQDKqB53LHuizbU4ZE5+DsLaEK9ypFg/sAPvmsjEOfwwaxrHcoBAHWYbIrhaOn/qB9Cco3taaIeC20Q9iRMfV+oQkreEeTN2mYgVj0sIgemdqkPXDo+e5TiuYoM0mMkHHHga4XfcFFVi08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758279613; c=relaxed/simple;
	bh=iTara4sSupdozHepYizRgHeOHDqwbp9HFBUwDlsXipA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpXyNUrn868cisu/aFpLrc+g03PyCbO2euZXrZQ1bVxMCPJ5/IVR6xxmrP/M+OSPsIni18ZCYtpQXIJpTBZdxDQE2Y9BQp9d+XL1CAaEoDa49/rzkm0REM02N8J4eLhNq/4jKKSCKsVNd+BAJihNSZyCBuC/QhL5U0QJExM/9v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=Rn4GAO1I; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.9])
	by mail.ispras.ru (Postfix) with UTF8SMTPSA id 8805040762F1;
	Fri, 19 Sep 2025 11:00:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8805040762F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1758279606;
	bh=olnDf6EjI1UvqfPCSzcCme6oOerL4VfaqpGnzGziL7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rn4GAO1ItFgGjRkwKawJxdyqJp+B3jhg+qVmGs8FGyzWGyasdL6YsRjhaWbMpasmD
	 q2wDnVCZyHJr8U77EkxNHflu2DdSVv8zbZtomgTlQy9q3maytCjacmjUY9REBiCGZ8
	 AhoGLeb3aqbj84eW3nYICbolkCrzzQyRivm9bK0I=
Date: Fri, 19 Sep 2025 14:00:06 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Zong-Zhe Yang <kevin_yang@realtek.com>, 
	Bitterblue Smith <rtl8821cerfe2@gmail.com>, Bernie Huang <phhuang@realtek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH rtw v4 4/4] wifi: rtw89: avoid circular locking
 dependency in ser_state_run()
Message-ID: <20250919133124-ffdfc2386e03e9d646af8d93-pchelkin@ispras>
References: <20250917095302.2908617-1-pchelkin@ispras.ru>
 <20250917095302.2908617-5-pchelkin@ispras.ru>
 <0b56e5a8cd7048a19625764bc323ba46@realtek.com>
 <20250918182202-29915c8fb7da60280f86084d-pchelkin@ispras>
 <bb36bb617cef49d7973ba92d4bd094d8@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bb36bb617cef49d7973ba92d4bd094d8@realtek.com>

On Fri, 19. Sep 00:46, Ping-Ke Shih wrote:
> Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> > On Thu, 18. Sep 05:52, Ping-Ke Shih wrote:
> > > Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> > > By the way, you mark this patchset as 'rtw'. Does it mean this patchset is
> > > urgent to you? If not, it will be more smooth (avoid possible merge conflict)
> > > if it goes via 'rtw-next'. Let me know your preference.
> > 
> > The first patch of the series is rather urgent compared to the others
> > because it addresses the issue occasionally banging on a working system.
> > The other ones are less urgent.
> > 
> > TBH I'm not aware of your development process in details.  It's v6.17-rc6
> > at the moment.  If I target all patches at rtw-next, are they to land in
> > upcoming merge window for v6.18 release (a couple of weeks from now)?
> > If yes then no hurries from me, rtw-next is ok.
> 
> It's v6.17-rc6 (-rc eve), so I don't plan to send a pull-request.
> 
> Originally I plan to send the last pull-request to v6.18 today, so I did
> review this patchset yesterday to see if I can merge it before sending. 
> Since only two or three minor changes are needed, I can wait a while and
> send the pull-request next Monday if you can re-spin the patchset this
> weekend. 
> 
> If not, I can still merge this patchset in v6.18-rc cycle to rtw tree.
> However, this might cause merge conflict with -next, so I don't prefer
> this. Upper maintainers need to spend extra time to resolve conflicts.

One thing that I forgot to mention is about rtw89 USB part.

"BUG: KFENCE: use-after-free write in rtw89_core_tx_kick_off_and_wait"
which is fixed by the first patch of the current series is reproduced
reliably with USB HCI because there is no TX completion there yet, i.e.
rtw89_core_tx_kick_off_and_wait() always exits with a timeout and touches
skb parts which are most probably already freed by the call to
ieee80211_tx_status_irqsafe() from URB completion callback.  I've got
a dongle now and confirm the bug.  Turns out it was reported here [1] by
Bitterblue Smith as well.

[1]: https://lore.kernel.org/linux-wireless/1e5e97d4-8267-4f77-a4bf-1fe23ea40f77@gmail.com/

The first patch does avoid use-after-free bug for USB, too.  But, as
there is no TX ACK completion implemented for USB yet, tx_wait_list will
be piled up with wasted items which can't be freed due to the lack of
completion.  It's better than crash but still a problem.

Bitterblue suggested [2] implementing the missing TX completion parts for
USB to fix this entirely.  I've got a bunch of patches for it which will
send as a separate USB-series today or tomorrow.  I expect it'll require
time for review and it probably should have to be improved/reworked in
several places.  Anyway I'll send it soon so you've got a more complete
picture and some time until Monday to decide how to handle it.

[2]: https://lore.kernel.org/linux-wireless/0cb4d19b-94c7-450e-ac56-8b0d4a1d889f@gmail.com/

