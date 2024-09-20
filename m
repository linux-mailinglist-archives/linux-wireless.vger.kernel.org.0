Return-Path: <linux-wireless+bounces-13047-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191F897D2EE
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 10:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3AEE280618
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 08:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17194C62B;
	Fri, 20 Sep 2024 08:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="d1CD02Wo";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="PjzadZ6j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e3i110.smtp2go.com (e3i110.smtp2go.com [158.120.84.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62AB2AE77
	for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726821649; cv=none; b=O8VfeGRKipkIbEYHiGisNOhg4ih+zMNNM4g6vPVko1dLql2m1P9IXInbTGhFnm/YN0JSOBDq2gcuHzyq5EDa71OB4OLOkAc7bjMOyZDDAqzX702rfh55OIEUnIZTn+a10vXTsdPsaleYSFPku8F5+nxOWbtIUTLR7p29vNBfoyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726821649; c=relaxed/simple;
	bh=FpaBNdIJdrLSpfGIglDUBAHMzNbXoLppLhcqk0S8XZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2JPSHGZ6cKSMFqWsfzLBKPuEbtVfp+dYRZ934GRZNdIMhTvPKsId/Qr5LdgiMk522ITJxdoAsY+tjc10mjJKBjuoYk2fWA1IHV0nxEAixchMkO5y8hT3J5Z+IQ+RGB7PazX91kCLRP4sFnB+KZyKWIWW74VfqiUbYglbyEBDVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=d1CD02Wo; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=PjzadZ6j; arc=none smtp.client-ip=158.120.84.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1726821644; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=LWhWWV4+OxgHO/9H0UJuMsnB+/Qs7z2IcL5IB0MHXew=;
 b=d1CD02Wom/RkZXFl21SjcYq8k4kavFp0v820JnqIfbldG/APbYYXxo1NksJwz8XNNVY6A
 RQYFNq+QhrjD3mprR28bYLQa9X3H5snOFul85/bDIrTrf8DErEMfKskbKsmF7kD7NlXB+8W
 Jxy0Ew2gWBHYk9kptl4DAOHCLJRVwFez1vTvFxw9G8Ib6/JD6u7FX9jl/KNoh55NG8/aSbD
 1yfTYJeunmxnhrkkRoiz87YRS5B5rydpRNswGozPO2vz/09t8gUf6WOfggTRSzPz+NYm4lg
 nKfkvgDCXd8urLVubBKhAYXqj/HE0HFMGK6dU7iIB3ojBv2V+2VEfISLEdgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1726821644; h=from : subject
 : to : message-id : date;
 bh=LWhWWV4+OxgHO/9H0UJuMsnB+/Qs7z2IcL5IB0MHXew=;
 b=PjzadZ6jepCnncbxtfXLrFQ6S9RA5F7PuG3/75+TxETzPin6gjFtHluGnWWLcjxrwy/Rm
 4SAUPD8EHPcDPD8nxZ8zy7dWh3f5np511gLCuCNIsvN/yCPsJgwyqYKV7L0mgz6Vpijr/ax
 8UKGFvMW9rIpxUB+zn0fjBQ92JFv5kLfZUO0SOyO9oYGsBbtK2oKd6kwUzCwIllOuauOq88
 G74h2vHayaWRvylBe5Qe5LgOhXmL9NRFdb1rAfX6UT8J1h+t7XPBolfBuAlVIlvKHK00msm
 1o3Fq2nh+ZRf439BtUY1mXXhpV6cAJ6vxd+d/+xznFbVzo/pKId6et4JvcOg==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1srZBw-FnQW0hQ0n7q-kO36;
	Fri, 20 Sep 2024 08:40:40 +0000
Date: Fri, 20 Sep 2024 10:41:57 +0200
From: Remi Pommarel <repk@triplefau.lt>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>,
	Nicolas Escande <nescande@freebox.fr>,
	linux-wireless@vger.kernel.org
Subject: Re: Missing wiphy lock in ieee80211_color_collision_detection_work
Message-ID: <Zu01VbjzUFYYjGJi@pilgrim>
References: <D4A40Q44OAY2.W3SIF6UEPBUN@freebox.fr>
 <b9d5550c-8ac1-41d7-9abb-caa11f484064@green-communications.fr>
 <c48876507ec971c9195e468e6037cc251dcf2218.camel@sipsolutions.net>
 <Zu0yRl4iyfspa8AV@pilgrim>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zu0yRl4iyfspa8AV@pilgrim>
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sAf72yfO-O
X-smtpcorp-track: t6kW2SdguZXN.9Dpclhd-4dFx.bnpK1AzQRSm

On Fri, Sep 20, 2024 at 10:28:55AM +0200, Remi Pommarel wrote:
> On Thu, Sep 19, 2024 at 12:22:10PM +0200, Johannes Berg wrote:
> > On Thu, 2024-09-19 at 12:02 +0200, Nicolas Cavallari wrote:
> > > 
> > > > Did I miss something ? Which one should we do ? I'm not sure of all the
> > > > implications of switching to the wiphy work queue and why it did not get
> > > > converted like the color_change_finalize_work stuff ?
> > > 
> > > ieee80211_color_collision_detection_work() used to lock the wdev mutex, now it 
> > > does not hold anything since 076fc8775da("wifi: cfg80211: remove wdev mutex")
> > > 
> > > Also the rate limiting uses delayed_work_pending(), There is no wiphy work queue 
> > > equivalent AFAIK, so the explicit lock is probably the way to go.
> > 
> > That won't work, it's cancel_delayed_work_sync() under the wiphy mutex,
> > so that'll cause deadlocks (and should cause lockdep complaints about
> > them.)
> 
> Yes you are right, and AFAIU that is this kind of issue using wiphy work
> queue would prevent. With wiphy work queue if wiphy_delayed_work_cancel
> is called with wiphy lock held, work cannot be running after it returns;
> making it handy to replace cancel_delayed_work_sync() with.
> 
> So, in my opinion, switching to wiphy work queue seems to be the
> prefered solution here.
> 
> While there is no wiphy work queue equivalent of delayed_work_pending(),
> I think using timer_pending(&link->color_collision_detect_work->timer)
> to replace delayed_work_pending(), even if the semantic is a bit
> different, would be ok to fulfill the rate limiting purpose. Having the
> same delayed_work_pending() semantics on wiphy work queue would require
> to take wiphy lock which seem a bit superfluous here.

Forgot to mention that I am currently running a wiphy work version of
ieee80211_color_collision_detection_work() using timer_pending() as a
delayed_work_pending() substitute since a couple of hours and lockdep
did not complain so far.

-- 
Remi

