Return-Path: <linux-wireless+bounces-14969-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 527DE9BE296
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 10:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8881C22F13
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 09:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D45C1D63D2;
	Wed,  6 Nov 2024 09:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triops.cz header.i=@triops.cz header.b="EO+Ock9r";
	dkim=pass (2048-bit key) header.d=triops.cz header.i=@triops.cz header.b="EO+Ock9r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from h2.cmg1.smtp.forpsi.com (h2.cmg1.smtp.forpsi.com [81.2.195.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEB61D27BA
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.2.195.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730885608; cv=none; b=hIKr6OhWfJq6iUSxdg6liKI7Mbb5fDNp/6JExFSGvsu4dHAFZ1rfYRkJ5qFPgqOPWSKhLhma36BEsWfXT2jgt7nvfoyJOf0xOnzQXlhx0RIrknh6diRvicpp8mhYj80iwUV+lA0eQDj3V6i26Z5jGCNUfhonz3pm/IST+zTTKBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730885608; c=relaxed/simple;
	bh=QoM+h/SJqunyxFIHMSCKeCiGRrgFrKJQwDAkDeE3WVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQF7heWMmjs7OOm1WYJCdflsPOIrBuwatKkpCAybwUQPDXHDYNWtekJ8tYOTL08l0Xrq+9bBT/QIE/sdDcNgjlczppsSSpcKi/G/LEgRdd4VkXNJODfp/C61dEmNnS7W0pDSSW3KrtledekFnWlvy/oVpp9uYfrwaReYVYUyudA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=triops.cz; spf=none smtp.mailfrom=triops.cz; dkim=pass (2048-bit key) header.d=triops.cz header.i=@triops.cz header.b=EO+Ock9r; dkim=pass (2048-bit key) header.d=triops.cz header.i=@triops.cz header.b=EO+Ock9r; arc=none smtp.client-ip=81.2.195.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=triops.cz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=triops.cz
Received: from lenoch ([91.218.190.200])
	by cmgsmtp with ESMTPSA
	id 8cPdtXwVl5hDk8cPftLp1N; Wed, 06 Nov 2024 10:33:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triops.cz; s=f2019;
	t=1730885600; bh=xgJVRprWyuIcR7GkPyifgdRw5iEmLOSkKat5zo0MhJ0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	b=EO+Ock9rbCDvRPPLDaZP9NDUgVTq3WfA7Gyb26ng9AD2irDIDnyvjnUMHMOoQWUls
	 xMauqll7ZLe6FHUSmNRfBnl7kopKmHCqK0gODfoKtwtsDEGU6DVXV5i6/u7mOMZxOC
	 I2Krj5EIL7HUK+CwDSEX5/+/obhii/PUxveFW936ye2nJ8DfZ7TIbKDb9Q/+r8cRHR
	 +AxqEtzyDuFY2ywqgfQZAhi2NGOmCIAQPGTDcYvnXqdhzrpqNLcT285yuEQ2E1W2JX
	 ldrW2Wr4efT5UsiVxCuD4maLmjJluUmPrZW7da2NMphUguF/4C3oWyFigxVzh/b977
	 usG3+HLKHculw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triops.cz; s=f2019;
	t=1730885600; bh=xgJVRprWyuIcR7GkPyifgdRw5iEmLOSkKat5zo0MhJ0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	b=EO+Ock9rbCDvRPPLDaZP9NDUgVTq3WfA7Gyb26ng9AD2irDIDnyvjnUMHMOoQWUls
	 xMauqll7ZLe6FHUSmNRfBnl7kopKmHCqK0gODfoKtwtsDEGU6DVXV5i6/u7mOMZxOC
	 I2Krj5EIL7HUK+CwDSEX5/+/obhii/PUxveFW936ye2nJ8DfZ7TIbKDb9Q/+r8cRHR
	 +AxqEtzyDuFY2ywqgfQZAhi2NGOmCIAQPGTDcYvnXqdhzrpqNLcT285yuEQ2E1W2JX
	 ldrW2Wr4efT5UsiVxCuD4maLmjJluUmPrZW7da2NMphUguF/4C3oWyFigxVzh/b977
	 usG3+HLKHculw==
Date: Wed, 6 Nov 2024 10:33:17 +0100
From: Ladislav Michl <oss-lists@triops.cz>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"pbrobinson@gmail.com" <pbrobinson@gmail.com>
Subject: Re: [PATCH v2 2/2] wifi: rtw88: use ieee80211_purge_tx_queue() to
 purge TX skb
Message-ID: <Zys33cLsOuMGaRek@lenoch>
References: <20240822014255.10211-1-pkshih@realtek.com>
 <20240822014255.10211-2-pkshih@realtek.com>
 <Zyn5WcUGoibH7-s8@lenoch>
 <d78848f7768a4bdabf92e053525d232d@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d78848f7768a4bdabf92e053525d232d@realtek.com>
X-CMAE-Envelope: MS4xfL9L4F9mQsWYG8ownxCtAOD0HiuxFAI77PQLqgzeHMci+GPmYUjdcvL3ysir+A3s0/8qShpZZio8ltwroPbUsu/KRKGzxvJY7Iycn7SK6cTyKEuPNpsQ
 Zh2Zpwh2OOtgrGmnVWGWX25niUOSWH9baRLSnuynNI3VKRBNzRkE6gF1GhKj5ViGEvyYpeOcl5gi1KLkwngACg0nzZ7u7XtCmpNegJ5G2ujcA0dUzaVpEOcS
 InMjRi3J2R44OYaE5uKa+6eWmHyciwfUlbgamUvwUYCL6YmaCiji7xNErOPp3k0C

On Wed, Nov 06, 2024 at 03:43:24AM +0000, Ping-Ke Shih wrote:
> Ladislav Michl <oss-lists@triops.cz> wrote:
> > On Thu, Aug 22, 2024 at 09:42:55AM +0800, Ping-Ke Shih wrote:
> > > When removing kernel modules by:
> > >    rmmod rtw88_8723cs rtw88_8703b rtw88_8723x rtw88_sdio rtw88_core
> > >
> > > Driver uses skb_queue_purge() to purge TX skb, but not report tx status
> > > causing "Have pending ack frames!" warning. Use ieee80211_purge_tx_queue()
> > > to correct this.
> > >
> > > Since ieee80211_purge_tx_queue() doesn't take locks, to prevent racing
> > > between TX work and purge TX queue, flush and destroy TX work in advance.
> > 
> > A the very same problem exists in 6.1 kernel series, where this patch
> > becomes oneliner:
> 
> linux-6.1.y branch doesn't have patch that exports ieee80211_purge_tx_queue().

Sure, but that one applies with a little fuzz.

> > ---
> >  drivers/net/wireless/realtek/rtw88/main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
> > index 81f3112923f1..d7d4b0f05da9 100644
> > --- a/drivers/net/wireless/realtek/rtw88/main.c
> > +++ b/drivers/net/wireless/realtek/rtw88/main.c
> > @@ -2145,7 +2145,7 @@ void rtw_core_deinit(struct rtw_dev *rtwdev)
> > 
> >         destroy_workqueue(rtwdev->tx_wq);
> >         spin_lock_irqsave(&rtwdev->tx_report.q_lock, flags);
> > -       skb_queue_purge(&rtwdev->tx_report.queue);
> > +       ieee80211_purge_tx_queue(rtwdev->hw, &rtwdev->tx_report.queue);
> >         skb_queue_purge(&rtwdev->coex.queue);
> >         spin_unlock_irqrestore(&rtwdev->tx_report.q_lock, flags);
> > 
> 
> Seemingly, we need below also? 

Perhaps I was lucky enough I never hit it here, but for a sake of completeness
it should be there as well.

> diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
> index 6ed470dd6f22..224678b9c38b 100644
> --- a/drivers/net/wireless/realtek/rtw88/tx.c
> +++ b/drivers/net/wireless/realtek/rtw88/tx.c
> @@ -188,7 +188,7 @@ void rtw_tx_report_purge_timer(struct timer_list *t)
>         rtw_warn(rtwdev, "failed to get tx report from firmware\n");
> 
>         spin_lock_irqsave(&tx_report->q_lock, flags);
> -       skb_queue_purge(&tx_report->queue);
> +       ieee80211_purge_tx_queue(&tx_report->queue);
>         spin_unlock_irqrestore(&tx_report->q_lock, flags);
>  }
> 
> Have you seen "Have pending ack frames!" in your side?

Yes.

> If so, use above changes to verify again on the latest kernel, and send a patch?

Do you mean to send a patch against linux-6.1.y stable tree? I can see your
patch in wireless-next only, so I do not think sending it to stable now would
work. But in general, having this fix in the stable trees is a good idea.

	ladis

