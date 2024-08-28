Return-Path: <linux-wireless+bounces-12183-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B2D96309F
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 21:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 588331C21414
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 19:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB691AB539;
	Wed, 28 Aug 2024 19:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w1.fi header.i=@w1.fi header.b="M0fEu6R5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.w1.fi (mail.w1.fi [212.71.239.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3951F1993AF
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 19:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.71.239.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724871678; cv=none; b=Nl9NN1gNZw5P523ihuYfC5zzPsVJkd1xJym0k/YdgG7tD94aCp0d6cw5wzrzAfvisONvzd54vBx8KEncK7GruUTyhfAhLztg3kkXf7iuZZSwzEXZCw0NvUCvXHmHyHYTcVzDn1AMiC7VbALlNcSgjM7YcNWOOvLLxYMkh3EPLTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724871678; c=relaxed/simple;
	bh=gVEATNtoP8WUy6MqZce3gow6qXdCzC2z7qXHuU4+GW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfH9OD+sNd8oh1djBBFWwMjmHDM6GLYIMSqukH2ZLZ8MytJVR7eW73LhcaY5hkyrELLrIJgVQHU1rVtR1wGMOGCI9UMxfEYQ8YGHALfcq7ueO9HudVPL+5F/vt9ZLtMFFjyxuxWsb1gyfP6qvigeJC3dlFl3nMacbkNkFx4WqNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=w1.fi; spf=pass smtp.mailfrom=w1.fi; dkim=pass (2048-bit key) header.d=w1.fi header.i=@w1.fi header.b=M0fEu6R5; arc=none smtp.client-ip=212.71.239.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=w1.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w1.fi
Received: from localhost (localhost [127.0.0.1])
	by mail.w1.fi (Postfix) with ESMTP id DFC9B11B67;
	Wed, 28 Aug 2024 19:01:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from mail.w1.fi ([127.0.0.1])
	by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N3lz3tFnM8wP; Wed, 28 Aug 2024 19:00:24 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Wed, 28 Aug 2024 22:00:22 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=w1.fi; s=default;
	t=1724871624; bh=gVEATNtoP8WUy6MqZce3gow6qXdCzC2z7qXHuU4+GW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M0fEu6R5IggjmaWh6QRLd47Pmxkiq1PLZP5lD90WuF1V342shRwhJMayibPTMV1Na
	 9ihv3rxvMjCMJM+RJMO8Z7p/8ZDFcfTuvP4ZOGWA4nZHuxKLS8e+h/OWAuCdmsqOM5
	 MlbIghTOtJK63V6i4H+t6irNSLSw2nEwZmoA0Jpb9KsHLeJ0ORe/ZuQhA6HiXzE2wy
	 l2LdEdjTh+Waiii2qC0JJDA8eJjYEnPQj0Da2oEpFLOyLeDW/8qYsnlx+fUmhtfkpt
	 qkSEvldw5owoI/VUcLq9i0H0RtYoUJyoVX8/r+FMmCZXOu6wbRwCNRlRE0OtW3oPud
	 SEvWOWi/JMJ2g==
Date: Wed, 28 Aug 2024 22:00:22 +0300
From: Jouni Malinen <j@w1.fi>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, hostap@lists.infradead.org
Subject: Re: WiFi constantly changes association
Message-ID: <Zs9zxsjJD2jQ/jBc@w1.fi>
References: <eb86cf20-2b1b-4871-82a4-441ba81752dc@rowland.harvard.edu>
 <9f32e4ff8b59f137208d99c40fd166f81e8de4bc.camel@sipsolutions.net>
 <52752800050fdd10e3d883cb4870624455d1b34e.camel@sipsolutions.net>
 <9cd7bc93-090a-4fcd-9af1-af6ff108064b@rowland.harvard.edu>
 <25391c67947d47c4cb75e89664a882905e125863.camel@sipsolutions.net>
 <Zs7WegloyrfZdRu9@w1.fi>
 <f6ea69035f7ff32edc2575765641689e469f764a.camel@sipsolutions.net>
 <fa0c3a9f-7034-41c7-a066-08284d8a069b@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa0c3a9f-7034-41c7-a066-08284d8a069b@rowland.harvard.edu>

On Wed, Aug 28, 2024 at 02:02:32PM -0400, Alan Stern wrote:
> Attached is a compressed file containing a 10-minute section of the 
> journalctl output.  wpa_supplicant was running with -ddt and without -s, 
> so this should contain all of its output.
> 
> Initially both wpa_supplicant and NetworkManager were turned off.  The 
> log starts at the time when I turned on wpa_supplicant, and a few 
> seconds later, turned on NetworkManager.  An INVALID_IE event occurred 
> at timestamp 12:03:59.  The output is so voluminous it's hard to see 
> what's really happening, however.

Thanks. This seems to make it clear that the AP has an issue in its FT
implementation at least in the BSS that operates on the 6 GHz band.
Based on the OUI, that AP is from HPE (Aruba?), so I guess I'll check
with them whether this is a known issue.

The log did not include any other attempt to use the FT protocol, so I
could not check whether it could have worked on other bands. However, I
do note that the RSNE from the 5 GHz band is indeed different and
matches the value that the AP included on the 6 GHz band in the
Reassociation Response frame, so this seems to point towards some
implementation or configuration issues on the AP side and that could
result in an issue that is specific to the 6 GHz band.

PS.

The reason for this particular sequence is in the STA first connecting
on the 5 GHz band and wpa_supplicant being configured to use bgscan
to find a better candidate. Background scan from that ends up finding a
6 GHz AP and that has better estimated throughput and wpa_supplicant
decides to roam based on that. Since FT is enabled here, that roam tries
to use FT from the 5 GHz AP to the 6 GHz one and that fails. This
results in the 6 GHz AP getting temporarily disabled and a 5 GHz AP
being selected as the next option. That succeeds with initial FT
mobility domain association (i.e., not using FT protocol). However, now
we get back to that same state where bgscan will find a better AP on 6
GHz and that will result in the same failure..

As far as I can tell, the main issue here is in AP misbehavior. This
could be worked around by disabling FT or bgscan. A potential
wpa_supplicant change could be considered to disable FT protocol for
that specific AP when this type of behavior is detected. I'll talk to
Aruba first to see if I can get a better understanding on what is behind
this AP behavior.

-- 
Jouni Malinen                                            PGP id EFC895FA

