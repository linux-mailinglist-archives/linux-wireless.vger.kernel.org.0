Return-Path: <linux-wireless+bounces-24222-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6A2ADDC43
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 21:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 666E340257D
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 19:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E493B25A334;
	Tue, 17 Jun 2025 19:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="N4RKhiGy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD24B2EF9AB
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 19:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750188364; cv=none; b=XBHz34GgwEFsuAIBKyPxmNsh+VB48NUOvKsRtMjKAK0m7oHpBLY7poXLlEZnNhFkA90Pu/CFoy9GpXNWcBEl4+8/GtDiD1quK/8mPULjCSeibq+ZxSDrSTW6ygPcqJUtTWCUe8YHSeRvwMcmmeHvo7iLr1bmakW30WKdlLNVy8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750188364; c=relaxed/simple;
	bh=OMPNaweV0MQUJxs086StZbhw7R41PpdxrM5VqkfI7nA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aGsD/W9EyRFV0SxM0lCt2Thl8TUloAau28dBQeItmA39fM7gOqEEbiK9PUYGEvRTQ16d4K70wjeLjAyfIFSeMM+QtTC8SxbrI3GXBDPDxDxoab5xI23vrC3EzBlh25JBp/qDIUaYoxBCKzTCgh2Im+HFk1aygt3RbwVgLCl7fWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=N4RKhiGy; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=OMPNaweV0MQUJxs086StZbhw7R41PpdxrM5VqkfI7nA=;
	t=1750188362; x=1751397962; b=N4RKhiGydbjWQuQHI+M98bc/Sfsy0E+SmICREGDFzAWtmAy
	BssicAdAauCiEEKgDhkoMPA41Ej1oj6X+EfVbqfSFX4XwMiU1ircde6JKBYLmxaUnWBrMKoxvUhgd
	8AGJLKirVc9JMXwQnB50/4n5n2CsOPT0/qSW13Ta/eZSE706n89k3/18JQMi1d09NWUFGtJmhI/am
	Y0HtCM5fD/4mX+RC8vphY8LUGMFNPrfNLQDxO3GP8Tdk09kO/BqK0L9GVxf/1HmDqEzimcl3+vFJh
	LEK4RhmU+z4kaeh3uWWdvD4ncteMbfMy6JO6FGcBm3+FfbgaHJC2P/I6xXCD6a8Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uRbwU-0000000ErNh-2dfb;
	Tue, 17 Jun 2025 21:25:58 +0200
Message-ID: <c6b6378e726137170fe960742e7b3fbc76834b46.camel@sipsolutions.net>
Subject: Re: [PATCH wireless] wifi: ath6kl: remove WARN on bad firmware input
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org
Cc: syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com
Date: Tue, 17 Jun 2025 21:25:57 +0200
In-Reply-To: <bc04fea3-1a51-4113-8dda-5a3a38000ef0@oss.qualcomm.com>
References: 
	<20250617114529.031a677a348e.I58bf1eb4ac16a82c546725ff010f3f0d2b0cca49@changeid>
	 <bc04fea3-1a51-4113-8dda-5a3a38000ef0@oss.qualcomm.com>
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

On Tue, 2025-06-17 at 12:10 -0700, Jeff Johnson wrote:
> On 6/17/2025 2:45 AM, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> >=20
> > If the firmware gives bad input, that's nothing to do with
> > the driver's stack at this point etc., so the WARN_ON()
> > doesn't add any value. Additionally, this is one of the
> > top syzbot reports now. Just print a message, and as an
> > added bonus, print the sizes too.
> >=20
> > Reported-by: syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>=20
> Since you used the wireless tag I'm guessing you'll take this through you=
r tree..

Oh, did I mix that up? I think get_maintainers said it was orphaned.

So yeah, I was thinking I'd just take it, thanks for taking a look.

johannes

