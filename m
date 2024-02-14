Return-Path: <linux-wireless+bounces-3582-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 286558547CB
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 12:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0AAB1F2375B
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 11:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77FF18E28;
	Wed, 14 Feb 2024 11:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OvRbOOSI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CA31AAD7;
	Wed, 14 Feb 2024 11:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707909046; cv=none; b=kF8KVfFAQXCMattsGi2E/vf6hAinJ6RkR769JtgwHdH1dEjwQTooKAUW8mgh1WTm9ppYIeYF2rgn/RZ/ovofbZT0Au2USR+xJM8/tTm7albKLRu6QF+vJA1IcGtdzqXw3CbBN/PsThu7sPRcK4NU6wzHGwK1OYhPyaUsbzfhILI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707909046; c=relaxed/simple;
	bh=9O5DIDFBAqx03xsK73U6jOiGef+NZ2P6kKYuXVsb18E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZcyFFSLX5Y7QjsS+8WKa/kYgIA3k3CSUYORFRZcOgw5VAKj9DUJY3opdViuIXfUezVUM5WDiga3bKzL8Vg2Lu7EXG9a8ElFuBWMlmYZwvQrmf3XkP6ZoYGvEA/4bHcGtbU1V8sA9AkP39sK/uqmlIbm2Adus05wvMkbDko2u+oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=OvRbOOSI; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QC2dNpeJICxTa3mVBoBS5p5m+HVNapWbR+e8emGMp/U=;
	t=1707909044; x=1709118644; b=OvRbOOSI46axrMp3CIfDeJBctW/ffm8Fc4hZeiPJGtir95n
	jsAc4Lw70T2KjHkTXdNux6eKrH9DCbtV+748ua1ZFSN/3eREeZAuQxAJiXf69Wp6En8OpzlWD+FkA
	1P1CBA3MayWfSsSrSMlaJ5r3waQ7V9GYYfrTQNOGMleGbGqQaPmbieblySEtFHQ+yVC01bCZ9Ndg6
	r/+F2UYb7HI0apWnl1aoZRMja2ed6CMQKUMpzC9aJTFobgajlKAB/jWSiOaDd9oCBt95zvITw/QzB
	dUtt41MT9sIUWpzGp93Wk2TZKqFkkCN4yAdQKM5UJ7GTQ3E365MkXvtLwd7grFlA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1raCUR-0000000922G-31tB;
	Wed, 14 Feb 2024 11:27:43 +0100
Message-ID: <6641f3f90bdc1d24f3a7fd795be672ce02685630.camel@sipsolutions.net>
Subject: Re: [PATCH 1/1] wifi: nl80211: Add support for plumbing SAE groups
 to driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>, Vinayak Yadawad
	 <vinayak.yadawad@broadcom.com>, linux-wireless@vger.kernel.org, 
	jithu.jance@broadcom.com, Arend van Spriel <arend.vanspriel@broadcom.com>, 
	netdev@vger.kernel.org
Date: Wed, 14 Feb 2024 11:27:42 +0100
In-Reply-To: <20240213174314.26982cd8@kernel.org>
References: 
	<309965e8ef4d220053ca7e6bd34393f892ea1bb8.1707486287.git.vinayak.yadawad@broadcom.com>
	 <87mss6f8jh.fsf@kernel.org>
	 <2c38eaed47808a076b6986412f92bb955b0599c3.camel@sipsolutions.net>
	 <20240213174314.26982cd8@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-02-13 at 17:43 -0800, Jakub Kicinski wrote:
> I may be missing the point but is there any official way we can
> designate level of vendor involvement? MAINTAINERS seems like=20
> the most basic, and we have
>=20
> BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS
> M:	Arend van Spriel <arend.vanspriel@broadcom.com>
> L:	linux-wireless@vger.kernel.org
> L:	brcm80211@lists.linux.dev
> L:	brcm80211-dev-list.pdl@broadcom.com
> S:	Supported
> F:	drivers/net/wireless/broadcom/brcm80211/
> F:	include/linux/platform_data/brcmfmac.h
>=20
> where (for the uninitiated):
>=20
>    Supported:	Someone is actually paid to look after this.
>=20
> It doesn't seem like Arend is afforded much paid time "to look after
> this".

I don't know if that's even the core of my complaint. I don't know if
it's true, but let's assume Arend _does_ get sufficient time to take
care of the driver.

The core of the complaint here is that regardless of that, Broadcom is
treating the driver as a dead end, a fork in the road they're no longer
travelling. So "supporting" that driver may all be well, in the sense
that it's there for the existing hardware/firmware that it supports.

But! It's not getting new features nor support for new devices, I don't
even know if it still supports newer firmware images for the devices it
already supports. Some new driver support is coming in by way of the
Apple-support folks, but you saw how that's going ...

Yet at the same time Broadcom _are_ sending patches to the core wifi
stack, in order to support new features/offloads for their new firmware
builds etc. on some/other/new devices. New features for the stack where
we cannot actually see the driver implementation, maintain it, etc. Not
that in many cases the driver implementation would be all that
interesting, but it's still pushing code and work into upstream that it
will never benefit from.

So this disconnect really is the complaint: Broadcom want us to maintain
the stack for them, do things for them like in this patch in support of
their latest firmware builds, but they definitely do _not_ want to do
anything upstream that would actually support these new things they
have.

At which point, yeah, I'm putting my foot down and saying this has to
stop. I really don't (**) care about Broadcom doing their own vendor-
specific APIs if there's zero chance the things they're needed for will
ever land upstream anyway.

(**) No longer. I used to think that being more open about this would
encourage folks to start a journey of contributing more upstream, but
clearly that hasn't worked out.

Now this is why I used to be more open: I will also most definitely not
accept all the vendor APIs upstream if someone later decides they do
want an upstream driver, and then push all the vendor stuff on grounds
that "it's used now and we have to support it" ... We don't, at least
not upstream, what you sell to your customers really isn't our problem.

(And to be honest, if customers cared, we'd not be in this position)

> On the Ethernet side I have a nebulous hope to require vendors who want
> the "Supported" status to run our in-tree tests against their HW daily.
> As a way to trigger the loss of status. Otherwise it's hard to catch
> people drifting away.

Every day seems a bit excessive? OTOH, every day is a good way of saying
"you really have to automate this", but then once you do that, maybe you
don't need to pay anyone to really maintain it, beyond trying to keep
the tests running?

Also not sure what that status really implies, I think Broadcom would be
quite happy to just mark the driver as orphaned...

johannes

