Return-Path: <linux-wireless+bounces-26895-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3D5B3ED75
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 19:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98CEA2071FF
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 17:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E99202997;
	Mon,  1 Sep 2025 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="KPUiTTfW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A5B33E1;
	Mon,  1 Sep 2025 17:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756748727; cv=none; b=dqbt4YalNJoTGlGIqot/GOtvx0WUr+Xlcj+I7oRjCwPTC6U7/xeJR2LRRc851cXkISTm6OJgSezVszzuFR4MziFT1ivp4L+1C4Z9Mt8o4/uwayfi+q3BVJf8GV+thhDFwTeUs+2PFhXbD2hjTEnd5vyJ955OkrVGh7C33u0GlNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756748727; c=relaxed/simple;
	bh=5SxPZzXq38hslc90u0izACa1Htb0IEWp6UUUlHb6Gag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnPJpoq3SBCZqnEQ6A7qecUhA5yf9B7R+8BYETb4YRNc2vXlziLWZk+BZgcK/N6//BwNQqhq3M7s11AuCBZTGkpb/qiBhnkAXPOHU7vTzEYfoUX28OmqOFgUoKqPSm4ukUQTQi6aC70j4sSDh2sZz6FdOVwACwaT+46cIQTEuiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=KPUiTTfW; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.10])
	by mail.ispras.ru (Postfix) with UTF8SMTPSA id 7BA2440A3264;
	Mon,  1 Sep 2025 17:45:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 7BA2440A3264
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1756748714;
	bh=N+mVmPr68qNpJWf3ueP9lF65VCD9/t6GdEFkOIVheGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KPUiTTfWzh2z7OKBEVpRmKUv6HLhvWs6NtUgWXSq0L2q876TBX1NflpAstgL5xvD7
	 LWgd+P7205NcpUEJkzbh0g+/Djnw2V8vvfCuZcsgcYk0qB08n4xGb3V06oCLZV8crv
	 PIuZur5LZpzNDjZWug8SixyDUWGCG4lYROClQ1gg=
Date: Mon, 1 Sep 2025 20:45:14 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, 
	Zong-Zhe Yang <kevin_yang@realtek.com>, Po-Hao Huang <phhuang@realtek.com>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH rtw v3 3/5] wifi: rtw89: perform tx_wait completions for
 USB part
Message-ID: <20250901194743-62fc282f96aeeb9804c34e2f-pchelkin@ispras>
References: <20250828211245.178843-1-pchelkin@ispras.ru>
 <20250828211245.178843-4-pchelkin@ispras.ru>
 <bc1857a0-86d9-40aa-a1ab-f4bc83adf6fa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bc1857a0-86d9-40aa-a1ab-f4bc83adf6fa@gmail.com>

On Fri, 29. Aug 22:57, Bitterblue Smith wrote:
> On 29/08/2025 00:11, Fedor Pchelkin wrote:
> > There is no completion signaling for tx_wait skbs on USB part. This means
> > rtw89_core_tx_kick_off_and_wait() always returns with a timeout.
> > 
> > Moreover, recent rework of tx_wait objects lifecycle handling made the
> > driver be responsible for freeing the associated skbs, not the core
> > ieee80211 stack. Lack of completion signaling would cause those objects
> > being kept in driver internal tx_waits queue until rtw89_hci_reset()
> > occurs, and then a double free would happen.
> > 
> > Extract TX status handling into a separate function, like its
> > rtw89_pci_tx_status() counterpart. Signal completion from there.
> > 
> > Found by Linux Verification Center (linuxtesting.org).
> > 
> > Fixes: 2135c28be6a8 ("wifi: rtw89: Add usb.{c,h}")
> > Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> > ---
> > 
> > New series iteration -> new nuances found.
> > 
> > It seems the two previous patches from the series would not be too great
> > in USB case because there is no completion signaling for tx_wait skbs
> > there.
> > 
> > I don't have this hardware so *the patch is compile tested only*. It'd
> > be nice if someone gave it a run on top of two previous patches of the
> > series, thanks!
> > 
> 
> I tested your first three patches with RTL8851BU for a few hours. It's
> looking good, no explosion yet.

Hello Bitterblue,

thank you!  Just in case, rtw89_core_send_nullfunc() has to be called in
order to trigger all the tx_wait activity touched with the patches, please
make sure it's called during the tests - it should be done after scan
complete, 47a498b84f01 ("wifi: rtw89: TX nulldata 0 after scan complete").

There is one more issue we'd also need to solve: perform tx_wait
completion signaling inside rtw89_usb_ops_reset() (driver shutdown stage
should probably also be handled with the case).  This'd require having an
ability to track TX URBs and kill them.  I'm just throwing these thoughts
now, maybe you have some ideas.  I'm still exploring the USB-part source
code and hopefully will have a chance to get hands on the USB chip soon.

> 
> The USB side doesn't have real TX ACK status reporting yet. I only
> learned recently how to do that. It looks like it will work about the
> same as in rtw88.

Do you mean similar pattern already exists in rtw88?  Could you give a
hint on how USB side TX ACK status reporting works there?  At a quick
glance, I don't see how those TX URB complete callbacks differ from what
rtw89 has.

