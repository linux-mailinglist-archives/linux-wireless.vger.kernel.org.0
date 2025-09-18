Return-Path: <linux-wireless+bounces-27481-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3445B84DC6
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 15:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A722A3A83AF
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 13:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87571306D58;
	Thu, 18 Sep 2025 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="qftKroqJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5AF27B50F;
	Thu, 18 Sep 2025 13:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202492; cv=none; b=kolVlpaV/fywF+bC6orjGDPfOYtcir8R9bHCaQaR7IW1sVPrIcCr0TckZBJc4EnvV7UT1tWJTKBjQlggIQvllRZ9J3hEdMQeaNJIsz62eNjeNIiAtw3xxsdmBFCqrjFrHo/nRJAOThgsOysaZs2vw8qUSk9rawtfRnk3mqN/Sz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202492; c=relaxed/simple;
	bh=rpW181wMRqA5xXxmymujUQqBYeDMid78JkqEPlXMZos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoWq+jFzCylkuE/T7AYKtjQw3w7qmI9LglAsQ+28GESeWoMZafourmJYly32aLL4icC9NShA3KrM3OKBP735f8Wcr7PiJQw2uZwxsLwwmIvj9qmA8KedUReeQDS67YJUSWPnoz3Mw+CCQsJ48KUSiG/RGQ+5yIGi3kYSPyaDLKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=qftKroqJ; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.2])
	by mail.ispras.ru (Postfix) with UTF8SMTPSA id 41D5D4076196;
	Thu, 18 Sep 2025 13:34:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 41D5D4076196
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1758202480;
	bh=RsEnDelXhwexWPRMPI1SOUhAveMwp5CkDUq3pIyl9uI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qftKroqJ13FflO+D5gOlDa2jps8HfLsIFo/wSPQDa9QH7oeujl5kan6arGfloa1mR
	 B6ZyYpP9gwisr+PbU07JUIS3153Fsze6KQozZr6+aF36SsTgTZDREyJKTPFqNCX6K7
	 FXBU3/NcXYm3YmmcEFVzAwhczbfKkSOXh09k0Tpg=
Date: Thu, 18 Sep 2025 16:34:40 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Zong-Zhe Yang <kevin_yang@realtek.com>, 
	Bitterblue Smith <rtl8821cerfe2@gmail.com>, Bernie Huang <phhuang@realtek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH rtw v4 1/4] wifi: rtw89: fix use-after-free in
 rtw89_core_tx_kick_off_and_wait()
Message-ID: <20250918160829-9fbf03ca95d5c4a93143afef-pchelkin@ispras>
References: <20250917095302.2908617-1-pchelkin@ispras.ru>
 <20250917095302.2908617-2-pchelkin@ispras.ru>
 <391e7cc762a549b7826e72090b61ebb2@realtek.com>
 <5d1be8c759c243f9a331c672cc301bbc@realtek.com>
 <8aa1fe0b49dd49408dc26ad48ba9a605@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8aa1fe0b49dd49408dc26ad48ba9a605@realtek.com>

On Thu, 18. Sep 05:23, Ping-Ke Shih wrote:
> Zong-Zhe Yang <kevin_yang@realtek.com> wrote:
> > Ping-Ke Shih <pkshih@realtek.com> wrote:
> > >
> > > Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> > >
> > > [...]
> > >
> > > > @@ -6181,6 +6187,27 @@ rtw89_assoc_link_rcu_dereference(struct rtw89_dev *rtwdev,
> > > u8 macid)
> > > >         list_first_entry_or_null(&p->dlink_pool,
> > > > typeof(*p->links_inst), dlink_schd); \
> > > >  })
> > > >
> > > > +static inline void rtw89_tx_wait_release(struct rtw89_tx_wait_info
> > > > +*wait) {
> > > > +       dev_kfree_skb_any(wait->skb);
> > > > +       kfree_rcu(wait, rcu_head);
> > > > +}
> > > > +
> > > > +static inline void rtw89_tx_wait_list_clear(struct rtw89_dev *rtwdev)
> > > > +{
> > > > +       struct rtw89_tx_wait_info *wait, *tmp;
> > > > +
> > > > +       lockdep_assert_wiphy(rtwdev->hw->wiphy);
> > > > +
> > > > +       list_for_each_entry_safe(wait, tmp, &rtwdev->tx_waits, list) {
> > > > +               if (!wait_for_completion_timeout(&wait->completion,
> > > > +
> > > RTW89_TX_WAIT_DEFAULT_TIMEOUT))
> > > > +                       continue;
> > >
> > >
> > > Why should we wait 10ms? Just try_wait_for_completion()?
> > >
> > > Since TX completion might be missing (rtw89_core_stop(), for example), shouldn't we
> > > unconditionally free all in wait list for that case?
> > >
> > 
> > In hci reset (when we release pending skb), the condition will become true.
> > So, all left will be freed at that time. Before that, there is no logic to ensure no
> > more completing side, so it cannot be unconditionally freed unless we don't
> > want to double check if those, which timed out, are done at some moment.
> > 
> > (e.g. core stop will do hci reset)
> 
> Thanks for the explanation. 
> 
> Just consider try_wait_for_completion() then.

OK.  completion_done() looks appropriate here as well.

> 
> By the way, if want a delay for timeout case, use delayed work for tx_wait_work
> instead.

That makes sense, thanks.  So the next time I'll go with delayed
tx_wait_work performing completion_done(): work delay 500 ms, looks
neither too small nor too big for freeing potentially timed out items.

