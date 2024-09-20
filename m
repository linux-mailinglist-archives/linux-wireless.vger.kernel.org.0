Return-Path: <linux-wireless+bounces-13046-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 797A997D2BA
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 10:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0C51F25B8C
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 08:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71917DA6E;
	Fri, 20 Sep 2024 08:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="hSwly0XL";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="KaFPBRAW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e3i110.smtp2go.com (e3i110.smtp2go.com [158.120.84.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6C247A66
	for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 08:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820868; cv=none; b=ihaykhZW3uX9sDvWDm/5zfGuhSL0m9MWcGEPCsbod/HMOLEQD6zJPFVkBfV6qyANclWTziViE8UgqEPSljRXejH90tXME+alv4oww1abDwv2/B/llfUFHnlAtyIGVsFwGeP/MBPlB52jSb/nzOB9tnfU6rLpHt2ZjQ0V8wEOZJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820868; c=relaxed/simple;
	bh=LKWPBkRhG+UVQOCCLSukXCCC0T1MnQT9t+hnLe5XQT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eW9yLxsCzBsJsgo7wc+eaUppssWsgL9Mqran/aGARqTV2SS3OqXAJ27GLkoYumCElLK9UfjrVMbIPS0+gdi34QWGORRF611811kK62L42RvOWTS79DobGWsQB5VgBjbs/cK1wi3wXXzY3u+feU7Zs/gYfRIc8SULpMDjEpxV7Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=hSwly0XL; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=KaFPBRAW; arc=none smtp.client-ip=158.120.84.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1726820863; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=vLzoR+ad8pUascl5ocy9dG69AnOw4zQipokRXgx18VI=;
 b=hSwly0XL3tnwRANLA0DxjjgDKyUI+P/59zVlKPE5UE7Vs1Hg/0vYOhJTNzjb+78gogbYa
 EB3B4o4lQJjVt2LkF2xZDrM/xHC423mjACJdSrv0RoEu+GX7LpsK03+kl6OZ5MbhRpN5Y+B
 MWXJMQw6GLZ6CHF0vhGMyDAH/SxKSeMXz/gamA4SVN4GsiQ6vpLF5AEh2uyBYi7aQc7p8K+
 c7ONTGXRyw/KHoy35SnOtl06oyxfAKSslIysYY3wXcyBfHu46X6k4Cd05qXgtqHv9G/w2a+
 GN7eiiE/2cp9YcjXr6S6y8ac/nRQnNfMTiqSIAwoCgBXKkKs6S9YfayumEZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1726820863; h=from : subject
 : to : message-id : date;
 bh=vLzoR+ad8pUascl5ocy9dG69AnOw4zQipokRXgx18VI=;
 b=KaFPBRAWwzg0z+ezlEK5976tN1Ki90CsmsL5sinGrxKPX+hJ41+5i1sHBONwqCwpv/uZf
 JAnbu6RrBYni7miGsSd/i93Z8QAj7k5GCrTPCapsM/etTJUHEKim6zABGTmohj6kXxPprxa
 aRw0pqu1MlknavICQ7X0HcqDrI0he087LCfRvkWTi7sfMtMb8LWW3GO/c0fxt8lzl5M/fbO
 L2+Djy6htJ9REouTIX7y0HWDd5hOi4oT/cwDXF67qF4SH6baBsoVf5cbO/C2sFPI0b6wu+h
 OI+g4GNgWZxQuDGbAOfgGCTtUw8iuM97NGdu9fDfQbdas1PoeLy5Q3V27RMA==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1srYzJ-FnQW0hQ0VTF-n1ga;
	Fri, 20 Sep 2024 08:27:37 +0000
Date: Fri, 20 Sep 2024 10:28:54 +0200
From: Remi Pommarel <repk@triplefau.lt>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>,
	Nicolas Escande <nescande@freebox.fr>,
	linux-wireless@vger.kernel.org
Subject: Re: Missing wiphy lock in ieee80211_color_collision_detection_work
Message-ID: <Zu0yRl4iyfspa8AV@pilgrim>
References: <D4A40Q44OAY2.W3SIF6UEPBUN@freebox.fr>
 <b9d5550c-8ac1-41d7-9abb-caa11f484064@green-communications.fr>
 <c48876507ec971c9195e468e6037cc251dcf2218.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c48876507ec971c9195e468e6037cc251dcf2218.camel@sipsolutions.net>
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sAf72yfO-O
X-smtpcorp-track: ZdepqOcGHWQN._XTUrerTUP9v.UB15sAKSid8

On Thu, Sep 19, 2024 at 12:22:10PM +0200, Johannes Berg wrote:
> On Thu, 2024-09-19 at 12:02 +0200, Nicolas Cavallari wrote:
> > 
> > > Did I miss something ? Which one should we do ? I'm not sure of all the
> > > implications of switching to the wiphy work queue and why it did not get
> > > converted like the color_change_finalize_work stuff ?
> > 
> > ieee80211_color_collision_detection_work() used to lock the wdev mutex, now it 
> > does not hold anything since 076fc8775da("wifi: cfg80211: remove wdev mutex")
> > 
> > Also the rate limiting uses delayed_work_pending(), There is no wiphy work queue 
> > equivalent AFAIK, so the explicit lock is probably the way to go.
> 
> That won't work, it's cancel_delayed_work_sync() under the wiphy mutex,
> so that'll cause deadlocks (and should cause lockdep complaints about
> them.)

Yes you are right, and AFAIU that is this kind of issue using wiphy work
queue would prevent. With wiphy work queue if wiphy_delayed_work_cancel
is called with wiphy lock held, work cannot be running after it returns;
making it handy to replace cancel_delayed_work_sync() with.

So, in my opinion, switching to wiphy work queue seems to be the
prefered solution here.

While there is no wiphy work queue equivalent of delayed_work_pending(),
I think using timer_pending(&link->color_collision_detect_work->timer)
to replace delayed_work_pending(), even if the semantic is a bit
different, would be ok to fulfill the rate limiting purpose. Having the
same delayed_work_pending() semantics on wiphy work queue would require
to take wiphy lock which seem a bit superfluous here.

Does that make sense ?

Thanks

-- 
Remi

