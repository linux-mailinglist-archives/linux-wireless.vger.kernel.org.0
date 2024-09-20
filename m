Return-Path: <linux-wireless+bounces-13052-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8749297D541
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 14:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C38D281FA0
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 12:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5151014A4D2;
	Fri, 20 Sep 2024 12:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="TqGvt7ny";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="jH/moPTr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e3i110.smtp2go.com (e3i110.smtp2go.com [158.120.84.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D408913B2B0
	for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 12:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726834158; cv=none; b=G+sUr9DLnvsnkAFmQ7cfbnY7nz+YLnTfL9+c2YmkITcj6u4WuzpMOtq68DR60HTDFdhzH3iZLv3HP3n41A4ayJ85I5m8eR9sKt/DV8+tn+lRZmJdIOu/Nk/YmN/rfPiQ1is/LtlLnPlPY/LKTh3TqDrTRI6S7WcB+x7vZPNLdsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726834158; c=relaxed/simple;
	bh=MfbB+uZwhdisNqMLW9eVpW+rxKT2OhXbFiJI6S3ilmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyXCW6NgSBNjnjGlPdEYnYelmcFNMjM3PqqJEYAIPrNcOFuf3oXgt6v3J0jrm6dlV5pidPuK2mCrvGAwWVdbKqh35I3VpEVyt48r2C5LwNK6Pf7oa8p51MGaV/zQs4gm82qOqaFlZT8aSz1200Nqy+TdoWkq00j6Bk6hCKsQYoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=TqGvt7ny; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=jH/moPTr; arc=none smtp.client-ip=158.120.84.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1726834154; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=vxPSmUTmRPh0Lu335KkiJPE3ZtbQsEITeaCchiJDroU=;
 b=TqGvt7nyzkWDf/S5QKjo1FB95JV+3rd89Jg7D6162M4FwYlMUzoouUX5Sc2kBaxNbpRo1
 UCnXodLy2hAhoy21XCGyXymowOkB0jAIi2sIWU0xWjR/kn44L6T7ObmwMiVEU0PQUZPPLqJ
 DWBVoePaTMsmWtiqnl3N/TMDzqc9LjVwhUQm62Yq0njII1tjvmkw+a8i1k5hDIw3K0Ad3Y9
 r7v/WYJz6LaSf9+25cmOfRkfukcgsLlZz4+c+tc+MZUH7dyDeBlWfhz7IlyB8Jcmypkma/g
 Lq2u6ZnoMVGbAb/HOlMFLBKjVJ/yDLP+krxnwy6hpuSviWbht748R4kiTSgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1726834154; h=from : subject
 : to : message-id : date;
 bh=vxPSmUTmRPh0Lu335KkiJPE3ZtbQsEITeaCchiJDroU=;
 b=jH/moPTrA/QiXhkJwC460LrFa+9ZsKJsax7S7QMeAusBhL22B8vA4PDZ+fa3rzneMgiH5
 RfMvOxwWXews53Eewjok6i3oDfg6Xa75mkZiYN7Ai+jQsB51RLgSVIVEG9AKCE515P1YA++
 iS+xyUte4AFW7731HrtiE7ykGicLpbOVkiKntUwUTbG5KmDkXXI6RW+sIETUKDUBUI9PFTt
 coeryWF7kVzEPD09L6qsTM9W+wohA0SwkP5oO2sdbeFknO1VWVI5kP75D3on0VJ/4c1XDK/
 FAGrf+a1cc7RvuvgoGViXnFtf1sv3b8lip++o/0eqprvjuCK4uMZBwNnLCHg==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1srcRh-FnQW0hPnnIw-kKeN;
	Fri, 20 Sep 2024 12:09:09 +0000
Date: Fri, 20 Sep 2024 14:10:25 +0200
From: Remi Pommarel <repk@triplefau.lt>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>,
	Nicolas Escande <nescande@freebox.fr>,
	linux-wireless@vger.kernel.org
Subject: Re: Missing wiphy lock in ieee80211_color_collision_detection_work
Message-ID: <Zu1mMZNxTIsYNH20@pilgrim>
References: <D4A40Q44OAY2.W3SIF6UEPBUN@freebox.fr>
 <b9d5550c-8ac1-41d7-9abb-caa11f484064@green-communications.fr>
 <c48876507ec971c9195e468e6037cc251dcf2218.camel@sipsolutions.net>
 <Zu0yRl4iyfspa8AV@pilgrim>
 <Zu01VbjzUFYYjGJi@pilgrim>
 <f00e76b9425b10dbfe347f8d107bf6a044e81069.camel@sipsolutions.net>
 <Zu1ldqE5zneiHOeK@pilgrim>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zu1ldqE5zneiHOeK@pilgrim>
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sAf72yfO-O
X-smtpcorp-track: KK0mf3HV8_Av.dUWiA8VBXHmM.ey2m2wlWVe9

On Fri, Sep 20, 2024 at 02:07:19PM +0200, Remi Pommarel wrote:
> On Fri, Sep 20, 2024 at 12:00:08PM +0200, Johannes Berg wrote:
> > On Fri, 2024-09-20 at 10:41 +0200, Remi Pommarel wrote:
> > > > I think using timer_pending(&link->color_collision_detect_work->timer)
> > > > to replace delayed_work_pending(), even if the semantic is a bit
> > > > different, would be ok to fulfill the rate limiting purpose.
> > 
> > I think you're right. We could as well check list_empty() or so, but it
> > wouldn't make a big difference. As you say:
> > 
> > > > Having the
> > > > same delayed_work_pending() semantics on wiphy work queue would require
> > > > to take wiphy lock
> > 
> > To really have it known _precisely_, that's true.
> > 
> > > >  which seem a bit superfluous here.
> > 
> > It's actually simply also not possible - if we could sleep in
> > ieee80211_obss_color_collision_notify() and take the wiphy mutex, we'd
> > probably have done this completely differently :)
> > 
> > And a hypothetical wiphy_delayed_work_pending() API should therefore not
> > be required to be called with the wiphy mutex held.
> > 
> > I think that perhaps we should add such a trivial inline instead of
> > open-coding the timer_pending() check, but I'm not sure whether or not
> > it should also check the list (i.e. check if timer has expired, but work
> > hasn't started yet): on the one hand it seems more appropriate, and if
> > actually holding the wiphy mutex it would in fact be completely correct,
> > on the other hand maybe it encourages being sloppily thinking the return
> > value is always perfect?
> > 
> > Right now I'd tend to have the check and document that it's only
> > guaranteed when under the wiphy mutex.
> 
> I had this exact train of thought and was replying that I did agree on
> that, and then I checked the other *_pending semantics for which I tend
> to forget the details. IIUC timer_pending() and work_pending() can both
> return false if callback is still running (or even not yet started).
> Thus the hypothetical wiphy_work_pending() semantics could allow to
> implement it using timer_pending().
> 
> Adding a list_empty() check while making it more "precise" does not make
> it "perfect" (even if there is no clear notion of what perfection should
> be here) even with wiphy lock held. Indeed if wiphy_work_pending() is
> called precisely after delayed work timer has cleared its pending state
> but before the callback (i.e wiphy_delayed_work_timer()) has added the
> work in the list both !timer_pending() and list_empty(work->entry) would
> be true. So there is a small window where wiphy_work_pending() wouldn't
> be more precise than just checking timer_pending() as show below:
> 
>       CPU0                               CPU1
>  expire_timers
>    detach_timer
>                                     wiphy_work_pending() -> return false
>    timer->function
>      wiphy_work_queue
>        list_add_tail()
>                                     wiphy_work_pending() -> return false

I meant wiphy_work_pending() -> return true here ^.

-- 
Remi

