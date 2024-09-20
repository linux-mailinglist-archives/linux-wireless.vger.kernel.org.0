Return-Path: <linux-wireless+bounces-13051-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ECB97D532
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 14:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6047C1F22D39
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 12:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5531428E3;
	Fri, 20 Sep 2024 12:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="sV0MUCC/";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="UlehRnhh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e3i110.smtp2go.com (e3i110.smtp2go.com [158.120.84.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDAA13B2B0
	for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 12:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726833970; cv=none; b=uuF1QYdc7IWD5tbzqYclMHQNENAKaybFbNTKSpDOixNx+aYPXiLtrYYaQ1qogg1RPwSwk5/yXZTbRa+kuM8HwqRpgs4R5yEhKKGiqeenl6UvtAmLKZlLNSNmjaO5BjB2ptkSUNAXSSDioLotlieh7r/rCwwfvJhC2XThKPOe2S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726833970; c=relaxed/simple;
	bh=9oQVbOZfy4ywJiSCB122penNXGjVc2oK7Z2W74YLoqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APnpkkcgwfrJBU84HTNqlVLZ+rSopniH5cgZU4hAr+v9Fgc2KPbtVFNseLkIdh14+cYYanfMpcMNIk0knkOGF7cIubaPLrByULuuWWdBveuQrNKMIm+SS19sN5LPGVNdggQN2Z2GjtDrXZGe5sZq3V8KnXy+DKV9CKjkLVePg5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=sV0MUCC/; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=UlehRnhh; arc=none smtp.client-ip=158.120.84.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1726833965; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=zRHbS6hySdCeRQCuxBaRaLqz+Iv/kdfemx9/3n23Bs0=;
 b=sV0MUCC/QrbnWNjXMslOtviGMdIVfElUxdPrG9cZusmQaVg1+dsX8Ue4tm97Bi+eYvaFD
 94mXKUao9hhugunto8di2aWT9Rp/H78yU4RcWHh7ScpExJWtEMCHy0p55VhBsIKDlWP6Mx5
 /lKBEazP7hkenGvfRE5R7pCxQIonrfw7bEpeAOMqUjxlFAiLbpilY62L0SIcJ4zVfYTAuOj
 26Lq1vvrqDwA9bhDau3ghUI+l+jkQpDSFQS0hSBaMxHQw4Ej8YZ3KDl8VNDlYA0E8TjuFz6
 5m3d0ov8yySHfYPIRwa91Yjfvzi/I9WG0edyo43EyFQtdvCwxEdYLNklc9xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1726833965; h=from : subject
 : to : message-id : date;
 bh=zRHbS6hySdCeRQCuxBaRaLqz+Iv/kdfemx9/3n23Bs0=;
 b=UlehRnhhQiZnUDI/pntKULZw3Ysy7HHFG7dSgPK1uOHE0OA33BDiKQxPbLI/iTdyFDsq+
 QQZAZvYLtvPBp6KqsdkCRkTPh/ZQob8nSwMEZ1CQc5kFGNThUBziqWg9parPgYMJqVEYEbN
 bcihSBNOwbJFlZgsEhnujKPh8fO262mpcfmhVkcDvKooNeUxSOUh474sWsYcJY8RWO9CEE9
 QtleJrZdDyHYnzQ300nxeHApbxidMJppONjECXWezdq7qq7qDjkqTEKk9ZU5rCoNccTwymY
 avbszF/YGqlp4m42kftBgjkD/Vmdu6GDNW53PNAAjvna4Bg0YeIHjIUhhZvA==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1srcOf-4o5NDgru9bD-o1Hw;
	Fri, 20 Sep 2024 12:06:01 +0000
Date: Fri, 20 Sep 2024 14:07:18 +0200
From: Remi Pommarel <repk@triplefau.lt>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>,
	Nicolas Escande <nescande@freebox.fr>,
	linux-wireless@vger.kernel.org
Subject: Re: Missing wiphy lock in ieee80211_color_collision_detection_work
Message-ID: <Zu1ldqE5zneiHOeK@pilgrim>
References: <D4A40Q44OAY2.W3SIF6UEPBUN@freebox.fr>
 <b9d5550c-8ac1-41d7-9abb-caa11f484064@green-communications.fr>
 <c48876507ec971c9195e468e6037cc251dcf2218.camel@sipsolutions.net>
 <Zu0yRl4iyfspa8AV@pilgrim>
 <Zu01VbjzUFYYjGJi@pilgrim>
 <f00e76b9425b10dbfe347f8d107bf6a044e81069.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f00e76b9425b10dbfe347f8d107bf6a044e81069.camel@sipsolutions.net>
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sAf72yfO-O
X-smtpcorp-track: Nxj_3M77KIUe.TUZSSD1u1bw0.0itdZgfF4RD

On Fri, Sep 20, 2024 at 12:00:08PM +0200, Johannes Berg wrote:
> On Fri, 2024-09-20 at 10:41 +0200, Remi Pommarel wrote:
> > > I think using timer_pending(&link->color_collision_detect_work->timer)
> > > to replace delayed_work_pending(), even if the semantic is a bit
> > > different, would be ok to fulfill the rate limiting purpose.
> 
> I think you're right. We could as well check list_empty() or so, but it
> wouldn't make a big difference. As you say:
> 
> > > Having the
> > > same delayed_work_pending() semantics on wiphy work queue would require
> > > to take wiphy lock
> 
> To really have it known _precisely_, that's true.
> 
> > >  which seem a bit superfluous here.
> 
> It's actually simply also not possible - if we could sleep in
> ieee80211_obss_color_collision_notify() and take the wiphy mutex, we'd
> probably have done this completely differently :)
> 
> And a hypothetical wiphy_delayed_work_pending() API should therefore not
> be required to be called with the wiphy mutex held.
> 
> I think that perhaps we should add such a trivial inline instead of
> open-coding the timer_pending() check, but I'm not sure whether or not
> it should also check the list (i.e. check if timer has expired, but work
> hasn't started yet): on the one hand it seems more appropriate, and if
> actually holding the wiphy mutex it would in fact be completely correct,
> on the other hand maybe it encourages being sloppily thinking the return
> value is always perfect?
> 
> Right now I'd tend to have the check and document that it's only
> guaranteed when under the wiphy mutex.

I had this exact train of thought and was replying that I did agree on
that, and then I checked the other *_pending semantics for which I tend
to forget the details. IIUC timer_pending() and work_pending() can both
return false if callback is still running (or even not yet started).
Thus the hypothetical wiphy_work_pending() semantics could allow to
implement it using timer_pending().

Adding a list_empty() check while making it more "precise" does not make
it "perfect" (even if there is no clear notion of what perfection should
be here) even with wiphy lock held. Indeed if wiphy_work_pending() is
called precisely after delayed work timer has cleared its pending state
but before the callback (i.e wiphy_delayed_work_timer()) has added the
work in the list both !timer_pending() and list_empty(work->entry) would
be true. So there is a small window where wiphy_work_pending() wouldn't
be more precise than just checking timer_pending() as show below:

      CPU0                               CPU1
 expire_timers
   detach_timer
                                    wiphy_work_pending() -> return false
   timer->function
     wiphy_work_queue
       list_add_tail()
                                    wiphy_work_pending() -> return false

-- 
Remi

