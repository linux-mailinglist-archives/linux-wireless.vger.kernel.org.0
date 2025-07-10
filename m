Return-Path: <linux-wireless+bounces-25178-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1625B0035F
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 15:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB87B3B4CC4
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 13:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEC782899;
	Thu, 10 Jul 2025 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="y7zv1h9O";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="Uh6/0juL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47192586C8
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 13:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154283; cv=none; b=fYix/u28wqdblwXMzJTtH5ZaCcBYOem/0g4xXQoHOLuOb4ZNW6+NkVi6bT8dO4byiLKPtsLz5X3U5hEpUQVsnxm9Ky7qlp7HWBvGC29Z4QnG7CVZROqDFmba0N3FL97KYFjLzEGxPpvsEoyuicuq8wbky5i0YVPEIPdd9xRxKfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154283; c=relaxed/simple;
	bh=aGkY5FkpXlRasmX7IkSFUC1z895PdUw3R9nsi4qUscU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYMZfQuvUfMUVGO4p/AWxsPwTG2YpGZ2KSql+gNqjo/2rJk3dwlpkot5MErq0rRpHMhYgAc+hFGzmygZg9tdgKQZrZat1+SzvIdnC7k8RtdcNVB0uVlrQ7lfvV2DjETtbvGG0dGWxL7ISJLGFBUJtOF0AizaJ40RmP67SZHPF38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=y7zv1h9O reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=Uh6/0juL; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1752155180; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=BsR5rXUF8TnVSQ9rfmGhuw/H5eoO2vMI7vkzhS8PYSI=; b=y7zv1h9OvEWUGoXELkM0ySi4JV
	DJ6GQ08bAtSWYVsZYpde5Z7V3xqGPAjTUPL2Ky7Z8fB8hcfAAoUrU7v2urhljwAMSGAYVaIC9cRis
	gu6YTNZH5NuBK0zfPqSide6igl/MgJKyVGkZAW6YT1sAeNni1pbMo1k5sRDPJMZLgjEV5ogNtk09g
	v6YHPJ90wf+E74Jo7cXLNcnes1H1tOnRSsoxU+P7NYO8fu6as35SDfAeVzYFa2OKt2wO9s/GLiZvA
	s2/mI8Fz5c0V/RMNMl4G5bmk+pPjnd3na1hr4h4+bvPQVz/CbqGi+5emtziF/ztLoFcmgCvqNKnMN
	haVRAblQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1752154279; h=from : subject
 : to : message-id : date;
 bh=BsR5rXUF8TnVSQ9rfmGhuw/H5eoO2vMI7vkzhS8PYSI=;
 b=Uh6/0juL/KFLw9ZatzKT0GltdqshNQUWgMhmrSC7Ebkok96JULRz9oLo532bh2bT44sqK
 d9PKFUUXBwiuKHLoJIsv5MaQlUo3s+y4xr0KRuesrs3Kape4UxDxQbpvK6px5ShbS3RDwDk
 uQ5FsdHh6woWqR8HaWV5OsngRlOQlpxUTXxBylpftB9amh7bEavka2gLQWFqXOshNSnqbaY
 rcfaCPSHS8g2TOIumdxhojX/MLhqK0Y3Of2c2nq8rd08JyDvixpbeJEr2evA40qoqBxLhcy
 0Eh3AfXoMWbd4Mu7CTAsw7DC/gBesjmaHmyMRzTPZPQOlPb4RZaqPRXYcfVQ==
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uZrMh-TRk6GJ-S4; Thu, 10 Jul 2025 13:31:07 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uZrMh-AIkwcC8oc00-JHJu; Thu, 10 Jul 2025 13:31:07 +0000
Date: Thu, 10 Jul 2025 15:21:08 +0200
From: Remi Pommarel <repk@triplefau.lt>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless-next 0/3] Allow non-MLD sta to roam between MLD
 AP links
Message-ID: <aG--RKqY7RBfkvLR@pilgrim>
References: <cover.1751057146.git.repk@triplefau.lt>
 <4d50e8de5750cd6b915f209b9d3ab26f34efda99.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d50e8de5750cd6b915f209b9d3ab26f34efda99.camel@sipsolutions.net>
X-Smtpcorp-Track: UBpTE96Z6G7C.BIWBSzlvnuVd.YHANVwOvTHL
Feedback-ID: 510616m:510616apGKSTK:510616sQxsm_LMAk
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

On Tue, Jul 08, 2025 at 11:00:26AM +0200, Johannes Berg wrote:
> On Fri, 2025-06-27 at 22:46 +0200, Remi Pommarel wrote:
> > 
> > To fix that, the first patch of this serie does not report management
> > frames with a link id (link id == -1) and let hostapd do the freq to
> > link conversion to respond. This relies on the fact that hostapd knows
> > how to do this freq to link conversion which is needed anyway for the
> > first pre-association scan. We can also do this conversion in mac80211
> > instead if it is deem preferrable.
> 
> You should probably send patches as RFC if you have things like that.

Sure. Some subsystems have a tendency to ignore those RFCs patches but
that does not seem to be the case for linux-wireless.

> 
> > This serie along with the mentionned hostapd patch allowes a non-MLD
> > STA to successfully roam between several MLD AP links with hwsim.
> 
> Maybe so, but does anything _else_ MLO related still work? Surely it
> cannot, given you just unconditionally made it no longer have a link ID
> ... And indeed most of the EHT hwsim tests no longer pass, and even
> crash the kernel.
> 
> Since you clearly were running hwsim tests, please run the existing ones
> too :)

Agh, sorry about that. I was not running the hostapd's hwsim tests
because I just discovered they exist. With the mentionned hostapd
patch most of them pass, but yes of course, let's not break old
wpa_supplicant/hostapd with kernel changes.

Doing freq to link id conversion instead makes all eht test to pass (I
will of course also add a hwsim test for this specific issue).

> 
> Also, I suspect that https://lore.kernel.org/linux-
> wireless/20250630084119.3583593-1-quic_sarishar@quicinc.com/ might go
> some way towards fixing this as well?

No I am afraid this one won't help.

The issue here is receiving off channel management frames and using the
link id the sta is currently associated with to report them to userland.
For example if sta is associated with link 0 and send a probe request on
link 1 (off channel scan), this frame should be reported to hostapd with
either no link id or a link id of 1.

Thanks

-- 
Remi

