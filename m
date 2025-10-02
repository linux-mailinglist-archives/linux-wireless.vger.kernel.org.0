Return-Path: <linux-wireless+bounces-27780-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA57BB3866
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Oct 2025 11:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60930174A3E
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Oct 2025 09:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7D530594D;
	Thu,  2 Oct 2025 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="bktksaIj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D112EDD74
	for <linux-wireless@vger.kernel.org>; Thu,  2 Oct 2025 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759399011; cv=none; b=XzHKqSsp01AQYPn30EtU9tx0z0dxbpx3ETz1QkjMQ34BlWOV1r6dmD3wQQDJS2pVolz5g8ET/r7h8ZUJuwIZ7c2byP71ufSg8PftyFn8EbQ2V7Of0k7qYz0Z9qhQyC/ycNvHtK0JLdy+Flab7zh3i5ZFpuLwQ0T2mExOvXby0F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759399011; c=relaxed/simple;
	bh=ji09VRNdZAtp1qpoq+Xkrr9H7UnUUNb/7lFhDi5SCxg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B1nC3FLwoD+JjA8nbP5xlTMXsqlK6kc4/8Z2ZtiUkao+WFogHNAdtjiknL8sF8jYdQXiIwQCjks3/UeZBbVAO8HjjiYI2xtFU9NO7j1mqGxHmNNVvoL4/Q62ZDh1iNxXjDFJ6IhnBpsj+OHv4UmGY4XuK5hI8llfea4V1SnqibE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=bktksaIj; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8ut3QFZskKN853gAytDDYttYaeM1IqtopHZH4wcN5qc=;
	t=1759399010; x=1760608610; b=bktksaIjd/yyyTycPdm3jHcznU4S1vuzXiy4K4nXEe/N9xS
	PRHmS+yHpw89gBvrejUy7/4fiyhaWa09Zlh4FbZfRZ7r1ETG5HI1vY3I5HgwEnA8dPQtyx6RTKzIw
	fox7R3f4/BcK1s4AxoFc+54GdSwe0+o+43bFz6iyPhUGebQ5G1/jON+nzS8vxDnhl8qZ4u4NHxRUW
	8QAVsLyZ64ALYPm2mJhRX7e3fCpkNEoNjXryVIwNQt7i9jv7NXFLSMoLAUfZTKAtooT/2kQPcf06d
	RriSlWHA8fqzpSIuIX+tH04FEiQU2nJur6HDLSu5JQX5liu5dATZLk2MpXQD/r+Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v4G3L-00000007Ras-0jNR;
	Thu, 02 Oct 2025 11:56:47 +0200
Message-ID: <be3f9ab94890abbfb565ca97b661d9939e35a6da.camel@sipsolutions.net>
Subject: Re: [Bug Report] Intel AX1775 / AX1790 / BE20 / BE401 / BE1750 2x2
 (Wi-Fi 7) fails to resume after suspend (s2idle)
From: Johannes Berg <johannes@sipsolutions.net>
To: Francesco Bergesio <francescobergesio1@gmail.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 02 Oct 2025 11:56:46 +0200
In-Reply-To: <be05e3f830c26c414742418c5dfb45d13e06e672.camel@sipsolutions.net>
References: 
	<CAFXXzTbHabF2hZKWM=RquQXB_tFq-24SPifnyL9ZA5-HL30X1A@mail.gmail.com>
		 <76fa4cd8d3598c771f5e1c8bb305c241907edc77.camel@sipsolutions.net>
		 <CAFXXzTZD3Wfywo2Mug8=3TrV2b0hsFSMERyd8YpzUgnBzP4uDA@mail.gmail.com>
		 <64ac5b780b412f9a663e86d2745e580a7db6b8e3.camel@sipsolutions.net>
		 <CAFXXzTYQxq9cAob__q2G+AT0PNYp72=cPTR+gRAF2ouAZguzrQ@mail.gmail.com>
		 <07c9465b6c80253975a7a4a70454fa5e6a536ad1.camel@sipsolutions.net>
		 <CAFXXzTYQt=LaUW_EdSPWEv7uQ+CTSXB8jY6GoEMcoVWUF55kTg@mail.gmail.com>
		 (sfid-20251002_112259_429078_FA07ED34) <be05e3f830c26c414742418c5dfb45d13e06e672.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

OK so ...

Do you have a (custom?) script that attempts to reload iwlwifi during
suspend/resume? I don't see why your distro would do that in general.
However, we see that in the kernel log:

> [   67.004869] Intel(R) Wireless WiFi driver for Linux

that's only printed when the driver module is loaded.

(I actually removed it in later kernels though, but also the other
messages should not happen on pure suspend/resume.)

And then we have this:

> > ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> > 1759396597.850020: nl80211: deinit ifname=3Dwlp44s0f0
> > disabled_11b_rates=3D0
> > ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> > 1759396597.850021: nl80211: Remove monitor interface: refcount=3D0
> > ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> > 1759396597.850022: netlink: Operstate: ifindex=3D6 linkmode=3D0
> > (kernel-control), operstate=3D6 (IF_OPER_UP)
> > ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> > 1759396597.850034: wlp44s0f0: Failed to initialize driver interface -
> > try next driver wrapper
>=20
> but it failed for no discernible reason? and, well, tries 'wext' next
> which as we know is going to fail...

Which ... would all make sense if not only the driver module, but also
mac80211 and cfg80211 are loaded again (due to genetlink etc.) and if
you had a script doing "modprobe -r iwlwifi" or so, that would obviously
happen...

So I don't know _why_ you have that module reload, but the problem is
probably not actually a bug anywhere, just doing weird things with the
system.

johannes

