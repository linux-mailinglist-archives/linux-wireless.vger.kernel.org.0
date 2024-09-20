Return-Path: <linux-wireless+bounces-13058-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD3897D637
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 15:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94A88B225C3
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 13:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424175464B;
	Fri, 20 Sep 2024 13:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="wBM87z7K";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="DPCoDpoX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e3i110.smtp2go.com (e3i110.smtp2go.com [158.120.84.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F50917A596
	for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 13:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726839402; cv=none; b=RKXUSsqlP6sAdmIx2g8qAZWQqdnyxphiTWdyQMCcMvh4LiJTvxVztOgkrluaeM2C3x3OKx2aFAlsV4Xi3lyMWgIASKpHYsMtGtqWSesxvl+nOM1CD1SlY2aJtAme8ftEhfNYb8FSH2MGplX3iUgKbKybneGfjohrMQTnqn9Vw90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726839402; c=relaxed/simple;
	bh=zKapn1MEfXbLZKb+MKlyiE5vYu6r7GU7S+egIN23VgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfB74N3fU0gG+3FJ6lSLRSayZIDm5K9DacICZqBZqohLodEL6lY0UmPOtbIWPd+Jtq7a5k6Zt48JD+sLn6TuNVJhszDaPrvN9F363V767FYC/iVVa/T+Yx1Jr6ekSt3Y0YjiWHBTfJvmS8t8XPDh49UExOB/zVnKk4MMS/nZXSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=wBM87z7K; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=DPCoDpoX; arc=none smtp.client-ip=158.120.84.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1726839396; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=a0ozz8G1NbhVZuHy++9/DjMcRDPVnTTdtS6BEE4V8Lw=;
 b=wBM87z7KsnKq/jbC9qQLjNEcpUu8PFmiUhJHjx5nSJyMEbieJSCquQ4vrCzVn9eHlblHC
 gQxNqulSLI9sJrx4MIOwyz8qevjet+nP5hrG1bfMLA13aTN1uG9qCyJEvsO/gJpeMPSNfNS
 esaODoHIGaL0C/vKQeIXbFpifivXSz3s+VdejvIZGh12BE/u7ASC8SYjnB07ENflAhyl3ZY
 aopx99R9yJegLhALqZ7op1SmUZWbSB8oAE3faOwIMTlqPOhMdJg5MSCJ5Yg2a0pJwlvQWm0
 9dVdiugOUGW/ZMxWzBl/15tf9cJXu1CQ1Zzq+b0MoDyNIxVatB2StN+2ddqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1726839396; h=from : subject
 : to : message-id : date;
 bh=a0ozz8G1NbhVZuHy++9/DjMcRDPVnTTdtS6BEE4V8Lw=;
 b=DPCoDpoX0AVC3CI0icNJ6A5LpqEKMqtS1pMFrsu/VoOdwbaqFHLIJESNJ5eplk30lvNsd
 WEaSO97z3XHVZalHtzr6MQjCjqdG/mRfjkgZqaIO+bPduLqa4wizjqnHBkPXpNxTcwTt1Fd
 6TFXysMO8ka5xYHsP07iMRkBYVxLUVcfpYrmJbV88IXoPsNcc8xl6kHu8+3o1ya4T5/MU59
 RfLGp39GHCXmiBFgpEha0ZYiROoqffF7aiXKyqomNC+KtvEViLETBsD9p3YiKDWrVtcBSkd
 NEyzX5OsRVwQhAkDqwpKd4nWhgMZwXzH4rDP9AVSkuN7r0PmarzMtelml6yQ==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1srdoE-FnQW0hPpZY5-l0Kh;
	Fri, 20 Sep 2024 13:36:30 +0000
Date: Fri, 20 Sep 2024 15:37:46 +0200
From: Remi Pommarel <repk@triplefau.lt>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>,
	Nicolas Escande <nescande@freebox.fr>,
	linux-wireless@vger.kernel.org
Subject: Re: Missing wiphy lock in ieee80211_color_collision_detection_work
Message-ID: <Zu16qrtsLCfZT9Li@pilgrim>
References: <D4A40Q44OAY2.W3SIF6UEPBUN@freebox.fr>
 <b9d5550c-8ac1-41d7-9abb-caa11f484064@green-communications.fr>
 <c48876507ec971c9195e468e6037cc251dcf2218.camel@sipsolutions.net>
 <Zu0yRl4iyfspa8AV@pilgrim>
 <Zu01VbjzUFYYjGJi@pilgrim>
 <f00e76b9425b10dbfe347f8d107bf6a044e81069.camel@sipsolutions.net>
 <Zu1ldqE5zneiHOeK@pilgrim>
 <Zu1mMZNxTIsYNH20@pilgrim>
 <13e473715fa721e0055464c1b5c78d47f969d74e.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13e473715fa721e0055464c1b5c78d47f969d74e.camel@sipsolutions.net>
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sAf72yfO-O
X-smtpcorp-track: HhRlOpGn_HI1.7eo_1Y5fbsIU.zUtwTQ-FJVd

On Fri, Sep 20, 2024 at 02:12:23PM +0200, Johannes Berg wrote:
> On Fri, 2024-09-20 at 14:10 +0200, Remi Pommarel wrote:
> > On Fri, Sep 20, 2024 at 02:07:19PM +0200, Remi Pommarel wrote:
> > > On Fri, Sep 20, 2024 at 12:00:08PM +0200, Johannes Berg wrote:
> > > > On Fri, 2024-09-20 at 10:41 +0200, Remi Pommarel wrote:
> > > > > > I think using timer_pending(&link->color_collision_detect_work->timer)
> > > > > > to replace delayed_work_pending(), even if the semantic is a bit
> > > > > > different, would be ok to fulfill the rate limiting purpose.
> > > > 
> > > > I think you're right. We could as well check list_empty() or so, but it
> > > > wouldn't make a big difference. As you say:
> > > > 
> > > > > > Having the
> > > > > > same delayed_work_pending() semantics on wiphy work queue would require
> > > > > > to take wiphy lock
> > > > 
> > > > To really have it known _precisely_, that's true.
> > > > 
> > > > > >  which seem a bit superfluous here.
> > > > 
> > > > It's actually simply also not possible - if we could sleep in
> > > > ieee80211_obss_color_collision_notify() and take the wiphy mutex, we'd
> > > > probably have done this completely differently :)
> > > > 
> > > > And a hypothetical wiphy_delayed_work_pending() API should therefore not
> > > > be required to be called with the wiphy mutex held.
> > > > 
> > > > I think that perhaps we should add such a trivial inline instead of
> > > > open-coding the timer_pending() check, but I'm not sure whether or not
> > > > it should also check the list (i.e. check if timer has expired, but work
> > > > hasn't started yet): on the one hand it seems more appropriate, and if
> > > > actually holding the wiphy mutex it would in fact be completely correct,
> > > > on the other hand maybe it encourages being sloppily thinking the return
> > > > value is always perfect?
> > > > 
> > > > Right now I'd tend to have the check and document that it's only
> > > > guaranteed when under the wiphy mutex.
> > > 
> > > I had this exact train of thought and was replying that I did agree on
> > > that, and then I checked the other *_pending semantics for which I tend
> > > to forget the details.
> 
> Haha, yes, no kidding.
> 
> > > IIUC timer_pending() and work_pending() can both
> > > return false if callback is still running (or even not yet started).
> > > Thus the hypothetical wiphy_work_pending() semantics could allow to
> > > implement it using timer_pending().
> > > 
> > > Adding a list_empty() check while making it more "precise" does not make
> > > it "perfect" (even if there is no clear notion of what perfection should
> > > be here) even with wiphy lock held. Indeed if wiphy_work_pending() is
> > > called precisely after delayed work timer has cleared its pending state
> > > but before the callback (i.e wiphy_delayed_work_timer()) has added the
> > > work in the list both !timer_pending() and list_empty(work->entry) would
> > > be true. So there is a small window where wiphy_work_pending() wouldn't
> > > be more precise than just checking timer_pending() as show below:
> > > 
> > >       CPU0                               CPU1
> > >  expire_timers
> > >    detach_timer
> > >                                     wiphy_work_pending() -> return false
> > >    timer->function
> > >      wiphy_work_queue
> > >        list_add_tail()
> > >                                     wiphy_work_pending() -> return false
> > 
> > I meant wiphy_work_pending() -> return true here ^.
> > 
> Good point! The second call could even be before the list_add_tail and
> still return false, so yeah, wiphy lock doesn't do anything.
> 
> But I guess we can live with both of these too, given sufficient
> documentation :)

Also, sorry for being bothersome, wiphy_delayed_work_queue() is not a
genuine equivalent of queue_delayed_work() as the latter does not
requeue work if already scheduled while the former does so effectively
changing the delayed work deadline (very mod_delayed_work() alike).

If we wanted to fix that, ieee80211_obss_color_collision_notify() would
simply use wiphy_delayed_work_queue() directly. But other calls would
have to be rechecked and switched to use wiphy_delayed_work_mod() if
needed be.

> 
> Agree also with Nicolas though that we could just ratelimit this
> differently too, this was just a convenient way of achieving it with the
> existing infrastructure.

Yes that would work also but still need to convert into wiphy work the
color collision work to avoid deadlock.

-- 
Remi

