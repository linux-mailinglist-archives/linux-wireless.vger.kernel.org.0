Return-Path: <linux-wireless+bounces-7774-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADC88C8279
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 10:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02D1E1F227D5
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 08:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC70199C7;
	Fri, 17 May 2024 08:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Y0/6Bnqg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A6710A25;
	Fri, 17 May 2024 08:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933611; cv=none; b=MoSyGvSGgUTZtlAYpZfv+CBp3hRwAh5cQ7iJHbgsBTjGw80TgJZRweirg5rqYpCw/wXXUioYRqdIC7fKegOFXz7JIS2jfNa00gJe9LFldfGKjTZcZpF/tfGuZYLVbNpJ3SA/awR3ZDMsHxwXBDVxTLJdbndiRcCDw6tHcYWIQkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933611; c=relaxed/simple;
	bh=UGCSH19/QQFayopTinwL3UHdf3P2cCPKLv7liUHXfMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pL23Yzsa9/TzzKHHi52aZfOws/KWt8mAE/GniFGieChvzMEKVgINPwLQLfrntrq2u8Bz980Qgwp6MdEMxkLl5FW0CAAe8cB+XqPUv3VbBjf6RGOmqjvpzATRgzKfS/q8aM0dW/Le7HbSf+6kLSQ9ijo6oUBcxTgMbSLANjgJwBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Y0/6Bnqg; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 1BB211F90C;
	Fri, 17 May 2024 10:13:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1715933597;
	bh=NREW6bcFroAQWer3qRmT1I+JmMfW1UsPIUtVyqTOHKk=; h=From:To:Subject;
	b=Y0/6BnqgzDL78DgCwa2SK756a0ho+Irss9R7P0/LE1R5dDKTpFRqEUGh6wH+i3R/j
	 bDX/YXvFVtxKicgbryJ6m4msKsUBd581wdblcPZo9rXq446tFvJRHAusn05sMizco2
	 YcsEIebvKjSR2aa6IcRV+tvMa1d8zC03w9IkB4jh4BilfvdyxLOBH87wzFN65ODXIn
	 DPxBZ9Kp43vp/g5tpObisdYv3oYNjpCVBUg6saS/j6h7DqotpGo1vNHkKxyj1c5EMs
	 des8iChfVN4LRweOXprfwOObvCkCDpuodaBmN+uWt/rZeuW6povD4sYYjCogm2Wgi3
	 qm9Qqj7UBt8Kg==
Date: Fri, 17 May 2024 10:13:12 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Kalle Valo <kvalo@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Brian Norris <briannorris@chromium.org>,
	Rafael Beims <rafael.beims@toradex.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	tsung-hsien.hsieh@nxp.com, David Lin <yu-hao.lin@nxp.com>,
	stable@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [v1] wifi: mwifiex: Fix interface type change
Message-ID: <20240517081312.GA7974@francesco-nb>
References: <20240510110458.15475-1-francesco@dolcini.it>
 <171593306296.3274748.4179889716794962474.kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171593306296.3274748.4179889716794962474.kvalo@kernel.org>

On Fri, May 17, 2024 at 08:04:24AM +0000, Kalle Valo wrote:
> Francesco Dolcini <francesco@dolcini.it> wrote:
> 
> > From: Rafael Beims <rafael.beims@toradex.com>
> > 
> > When changing the interface type we also need to update the bss_num, the
> > driver private data is searched based on a unique (bss_type, bss_num)
> > tuple, therefore every time bss_type changes, bss_num must also change.
> > 
> > This fixes for example an issue in which, after the mode changed, a
> > wireless scan on the changed interface would not finish, leading to
> > repeated -EBUSY messages to userspace when other scan requests were
> > sent.
> > 
> > Fixes: c606008b7062 ("mwifiex: Properly initialize private structure on interface type changes")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Rafael Beims <rafael.beims@toradex.com>
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> BTW I removed the Reviewed-by from the commit message, I don't see the need to
> have both Reviewed-by and s-o-b.

Sure, I was in doubt about this, in the end I added it because I have seen
this done in other subsystems, e.g. commit 6a4020b4c639 ("drm/bridge:
tc358768: fix PLL parameters computation").

Thanks
Francesco



