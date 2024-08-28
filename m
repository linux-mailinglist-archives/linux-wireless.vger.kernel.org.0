Return-Path: <linux-wireless+bounces-12127-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 748FB9621D7
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 09:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A748A1C22313
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 07:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B515A157A67;
	Wed, 28 Aug 2024 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="GN2T5Qgi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C6B14D6EB
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 07:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724831715; cv=none; b=XII0rSkZnwiKRl9w7YK8DPOGNDsZMMbtli4ABQYuDS/I6HQtM0ZdbOs9g5h89Y/Wuw0Dx++dxVShDah3H7XXFuU0WXU67s3wGA2sKSG1q6rhIpwRvcw+rKESgW6qn1jPnXIrm2Yhza0zMPtK6UfF6FUIzQpv1+lO7qSOBHFkYvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724831715; c=relaxed/simple;
	bh=aa0u6ZgIzNcYGaUfXluLI4+Bk0MX7EKAtwXb7Hh2HZc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P11N0ZU7UJKVn16uucpzZNvkuN+AJKUfcpvbNm3Lj6BC8ZYX77NWqmyNjfYaoDC0YgiH5lLK5BxD0wU9g9Jw5m7yPmd+yQqWQEk+D4HL9JmCcy+dABSkgMTxlfsGakoKEdmHQrxm/Lo1AVDtq5Vj2LxfB906ibNfs9/oRPTaHJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=GN2T5Qgi; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=v2tfz6MlM3n1VDfF5b7ZS7VEZ7qaR9IYCgyWHLVm2nA=;
	t=1724831714; x=1726041314; b=GN2T5QgihQ59wYf9sjjRZuBTR0sKylzYeAZNkSbS0F7JpUx
	Cm2gE3QEQGZSKGXORYrjdpNtIOBQeSQbQqBn7+fmqWoUeYfzVwbW1zxMh7Fj35HZiBaWAesI0iW52
	Ds/+Cz+EI6d3rFyzWQKGA7AME+GkibeN01EZ+GeriuEjLEbutVMuqCdF2TJPfysu2ET3LbEYQhkvA
	pCCkPNk37YC3Oi/xsG5CvOqvLOywWwPzQf15jkgEAPgdvFtMZTWlqoUxYOW6vbyuLcJB3/iJb/Bvf
	vUys3f1pIKpuKDKMUwJE7qpgy9Ms2SuhcaQ/AgoXYJTbUZCz67YN3OqqWDFwbsnQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sjDWI-00000006ihs-3bCk;
	Wed, 28 Aug 2024 09:55:11 +0200
Message-ID: <f6ea69035f7ff32edc2575765641689e469f764a.camel@sipsolutions.net>
Subject: Re: WiFi constantly changes association
From: Johannes Berg <johannes@sipsolutions.net>
To: Jouni Malinen <j@w1.fi>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-wireless@vger.kernel.org, 
	hostap@lists.infradead.org
Date: Wed, 28 Aug 2024 09:55:09 +0200
In-Reply-To: <Zs7WegloyrfZdRu9@w1.fi>
References: <eb86cf20-2b1b-4871-82a4-441ba81752dc@rowland.harvard.edu>
	 <9f32e4ff8b59f137208d99c40fd166f81e8de4bc.camel@sipsolutions.net>
	 <52752800050fdd10e3d883cb4870624455d1b34e.camel@sipsolutions.net>
	 <9cd7bc93-090a-4fcd-9af1-af6ff108064b@rowland.harvard.edu>
	 <25391c67947d47c4cb75e89664a882905e125863.camel@sipsolutions.net>
	 <Zs7WegloyrfZdRu9@w1.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-08-28 at 10:49 +0300, Jouni Malinen wrote:
> On Wed, Aug 28, 2024 at 09:19:05AM +0200, Johannes Berg wrote:
> > On Tue, 2024-08-27 at 15:09 -0400, Alan Stern wrote:
> > > Well, I'd prefer to avoid unnecessary roaming because of the short=
=20
> > > interruptions in service that it causes.
> >=20
> > Right, but the interruptions for you are much longer because it _fails_=
.
> > Perhaps wpa_supplicant should remember that, and not attempt to use FT
> > when it keeps failing.
>=20
> That depends on what exactly is failing..

Agree.

>  I did not bother going through
> all the details of the debug log since it seemed to be missing
> something.

Also seems that way, yes, though not sure why.

But for example:

> wpa_supplicant[5906]: wlan0: FT: RSNE mismatch between Beacon/ProbeResp a=
nd FT protocol Reassociation Response frame

is something that perhaps could result in an FT-blocklist or something
for the BSSID in question, or perhaps even the whole network since it's
likely to be a single controller/unified installation or so.

> I did notice one of the APs using comeback mechanism which is
> a sign of the STA having an older entry on it and PMF being used. That
> is actually not a failure but part of the expected behavior for
> protecting against disconnection attacks. One would need to have a full
> log from the first initial connection to the point of a failed
> reassociation.=C2=A0

True.

> Ideally, I'd like to see that from wpa_supplicant stdout
> with -ddt on the command line instead of syslog.

Right ... That needs more arguments to integrate with NetworkManager (or
configuration to have at least dbus), but I'm not sure how exactly
that'd work and how you'd stop the system one.

Actually if it's with systemd then that/journal will log everything from
the stdout/stderr, just not necessarily in the syslog - so perhaps
adding -t in addition to -dd and then using

	journalctl -u wpa_supplicant

would work.

johannes

