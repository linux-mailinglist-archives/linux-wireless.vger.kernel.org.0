Return-Path: <linux-wireless+bounces-27776-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EACFBB35CC
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Oct 2025 10:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CF567A7682
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Oct 2025 08:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD4C2FB617;
	Thu,  2 Oct 2025 08:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="R79rFOvy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C012E173E
	for <linux-wireless@vger.kernel.org>; Thu,  2 Oct 2025 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759395262; cv=none; b=Dx2OBF+qcQUdlEEybU/fm22AB6GxNloswDbDI5dSHJM41jmFIkZvM/SYyCd/12ppSP2t8+ZVn6tbzGK4FT9zPUY79nb1uxjQIcZeC6x4YPxFf53soWtnyn9kCtMQVU2SCBQvK1q1q7lC8PGzqFL2JmFXGTT1dPMHdTT4nxjxk7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759395262; c=relaxed/simple;
	bh=3WQPR6k08IQ+eJtm2HgXNQTNsuv9v03UUqbWYD7zaKs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=INDq5dxG+pGnQnIFs5A+1NqkMVSdssjjNQixANNdfqbKykjOMLLqZYPoS0JFto12XUwpflTeS5zs6cJkukg/mkIyJ+9jIiSI3IQI+3M98u6gZ9YXDFrZnrYc/FvBOdpNqectLywHh5CtWYG64Z6sxm3HoKvijG9+0YixuiOQuZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=R79rFOvy; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3WQPR6k08IQ+eJtm2HgXNQTNsuv9v03UUqbWYD7zaKs=;
	t=1759395260; x=1760604860; b=R79rFOvyFWL51d8XDx+/nZXIckP+wf4eyluT5CuJRP4RBnH
	27vcdv4o25iCb5I6ovajbFxtkVzOjOHEKXz+3I1UaB20+Jx9C1LlWT5kB9+WaytwhgZFfdRMVex6i
	pAwlkB2NSYM2SJn2nak5h8nh49jL73WTxMHtw/qOkXAUpxpsUvn/Q5zuc/nAOpqJQlUqGVNSu0N6F
	o7mc0UBQ71e1XrkqfppK7SIJGyUzni6zQ8kAKJ10uoS6udCV6KRyoLWoJ0Ax9mflRz+doWRlLRGZ+
	zf0QLEdHdHBZtyTYNaHsIsybnVga8fspxoPVE7eEipsOdoFSqx5nbYulAhGhj7+Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v4F4s-00000007OKM-13SM;
	Thu, 02 Oct 2025 10:54:18 +0200
Message-ID: <07c9465b6c80253975a7a4a70454fa5e6a536ad1.camel@sipsolutions.net>
Subject: Re: [Bug Report] Intel AX1775 / AX1790 / BE20 / BE401 / BE1750 2x2
 (Wi-Fi 7) fails to resume after suspend (s2idle)
From: Johannes Berg <johannes@sipsolutions.net>
To: Francesco Bergesio <francescobergesio1@gmail.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 02 Oct 2025 10:54:17 +0200
In-Reply-To: <CAFXXzTYQxq9cAob__q2G+AT0PNYp72=cPTR+gRAF2ouAZguzrQ@mail.gmail.com> (sfid-20251002_104427_624110_594BCE00)
References: 
	<CAFXXzTbHabF2hZKWM=RquQXB_tFq-24SPifnyL9ZA5-HL30X1A@mail.gmail.com>
	 <76fa4cd8d3598c771f5e1c8bb305c241907edc77.camel@sipsolutions.net>
	 <CAFXXzTZD3Wfywo2Mug8=3TrV2b0hsFSMERyd8YpzUgnBzP4uDA@mail.gmail.com>
	 <64ac5b780b412f9a663e86d2745e580a7db6b8e3.camel@sipsolutions.net>
	 <CAFXXzTYQxq9cAob__q2G+AT0PNYp72=cPTR+gRAF2ouAZguzrQ@mail.gmail.com>
	 (sfid-20251002_104427_624110_594BCE00)
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

On Thu, 2025-10-02 at 10:44 +0200, Francesco Bergesio wrote:
> Hi,
> I took wpa_supplicant log with sudo wpa_supplicant -i wlp44s0f0 -c
> /dev/null -ddd

Thanks. But does that actually make NetworkManager talk to it? I think
you'd need to have the dbus option (-u) at least?

There was some documentation somewhere on how to enable it ... hmm. If
you're normally using systemd then "systemctl edit wpa_supplicant"
should do it?

And then you copy everything, add "-ddd -t" to the ExecStart line (the
"-t" for timing info) and restart it, then suspend/resume and I guess
grab the output with journcalctl.

If you're not using that infrastructure .. I don't know.

> wpa_supplicant v2.10
> random: getrandom() support available
> Successfully initialized wpa_supplicant

This looks pretty normal, but as you notice

> EAPOL: disable timer tick
>=20
> stuck there and when pressing ctrl-c

it never actually does anything, since it's not being controlled by NM
etc.

johannes

