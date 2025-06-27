Return-Path: <linux-wireless+bounces-24608-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F89FAEB040
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 09:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 383231C2280C
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 07:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776AF21C9E5;
	Fri, 27 Jun 2025 07:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KvCwpp4f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425FA21C9EA
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 07:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751009977; cv=none; b=eDZY80XmylefvC+tdqL50phBWFMNv2KUjQ5Iqmx2m7eDDbtIfUmzDBWzji3YcVCDpcu2dr2VygDmJr197OgB3mnqiWaX96QWJEfTNnEnzeH+dsPjo7HVhSu5zASh0vwdAUXlrhu6Nm7U/JLvkkZPLzO7kOuKH2BIRUAEssHv69A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751009977; c=relaxed/simple;
	bh=2UNS+t12bOTOBv0KGjF2xoNYFhekMbEAG5UFH+BDJuo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AtmSMUuOIH9NrycCYvbzlf9O5YKRz1r8z6BXQ3Y7D5m2/bZjQF7tQy61Xp6hmR/665+BMocJ96yXefO3Ytp5ADmovr5w3imiGFAMYzPzEP3twdDnW1Ao9VKhotGqYJhHwEPhoXB37KasWzOzLJOVKiP/2mEXRxIY172veFCok5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KvCwpp4f; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=2UNS+t12bOTOBv0KGjF2xoNYFhekMbEAG5UFH+BDJuo=;
	t=1751009976; x=1752219576; b=KvCwpp4fg07bxinALbm5VHZUCu48gqj5ug0aVp0Xv6J4UhJ
	JfwdSFSASoTNfmG+dDDZBwYQfYA+L40DJljnQN3ccri1+iSwLQfTIohmOf2PvucG7YfrgYO7RHZVH
	Zh1E0Jkr3NsyorDnVBEi/jQmgPI9xc5yFjBUecpK1D4nFNJjNS12EGBYAUK3Pj3Ty7B7XCLOoYl1m
	bgn7Ngi5gQz8lfmUWi9JVbobuZhpyg6jYXp1toZRuFg1+1y0g1HJf91i93JagHNUn5XQWkSqAFMog
	7Np7/m0ORHUEShaxsQwmXCyELpmglw7No+QhMMBipfj8atbX49Wt2XjQMuL3TafQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uV3gG-0000000DIdK-0vRC;
	Fri, 27 Jun 2025 09:39:28 +0200
Message-ID: <dd5d7dabccee33e81f77163b5ba640841cfe5ac8.camel@sipsolutions.net>
Subject: Re: Linux Wireless Request for Collaboration (AP-centric features)
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Date: Fri, 27 Jun 2025 09:39:26 +0200
In-Reply-To: <6f4dc13a-b2f9-4f88-a1fb-8c457a6ed057@oss.qualcomm.com>
References: <6f4dc13a-b2f9-4f88-a1fb-8c457a6ed057@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

So I held off for a while since I didn't want anyone to think I have it
covered ;-)

> Specific areas of interest at this time include:
> Robust AV Streaming (IEEE Std 802.11-2020 section 11.25)
> Seamless Roaming (IEEE P802.11bn/D0.2, March 2025 section 37.9)

But of course generally with my maintainer hat on I'm interested, and to
some extend perhaps the seamless roaming overlaps a bit with client?

Now that I learned more about it though, it seems the seamless roaming
isn't even all _that_ seamless, and doesn't require major surgery?

johannes

