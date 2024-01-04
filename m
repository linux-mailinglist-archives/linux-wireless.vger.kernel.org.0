Return-Path: <linux-wireless+bounces-1477-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F38823E7B
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 10:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB2521F23C31
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 09:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F767208A5;
	Thu,  4 Jan 2024 09:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w1.fi header.i=@w1.fi header.b="bfyETgcT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.w1.fi (mail.w1.fi [212.71.239.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FA820303
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jan 2024 09:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=w1.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w1.fi
Received: from localhost (localhost [127.0.0.1])
	by mail.w1.fi (Postfix) with ESMTP id 768091171D;
	Thu,  4 Jan 2024 09:12:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from mail.w1.fi ([127.0.0.1])
	by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HJxzcAi-JueJ; Thu,  4 Jan 2024 09:11:52 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Thu, 04 Jan 2024 11:11:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=w1.fi; s=default;
	t=1704359512; bh=VBRerHNadamH4INcnbRe+zU6f+McltOCu0zU6j1EeB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bfyETgcTUASYqDC7iyJP3oA+BgoBZmeYvRFdvZuzLjid2m/TFe76epy5Uliw7i/Gl
	 3c4MqNg6//eRfBgvVRaD7hj1JvS+lfqAmFatwHNTN30ot6CJ0WeN6O6c7XSCDjwkfx
	 6vN6J61GjddDirns6FPjUvIdz5XiURZB4Jk3PNJYxIicbby66u+IpA5sbvWfhZaKdI
	 xAvitgI3dKjyDeNSKhPv5qivFxIMJJFz3cNUXvpT3na2lO2J7pEtDxHGgfpMliEVU6
	 jGu83HitreRznyeALwyQejDEjx1yLr8OmTE4FoSdZSyq7Hfp413npuLezNK6+7u6Mv
	 OgMDuJuN2jltw==
Date: Thu, 4 Jan 2024 11:11:50 +0200
From: Jouni Malinen <j@w1.fi>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
	hostap@lists.infradead.org, linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: Re: [PATCH] tests: Modify the QoS mapping tests
Message-ID: <ZZZ2VijIWptjwzMY@w1.fi>
References: <20231213113735.289408-1-andrei.otcheretianski@intel.com>
 <ZYa5CotWy+00CHII@w1.fi>
 <785436c0080a7a7d20175a45ed671ceaf82cd79b.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <785436c0080a7a7d20175a45ed671ceaf82cd79b.camel@sipsolutions.net>

On Sat, Dec 23, 2023 at 06:30:52PM +0100, Johannes Berg wrote:
> On Sat, 2023-12-23 at 12:40 +0200, Jouni Malinen wrote:
> > On Wed, Dec 13, 2023 at 01:37:35PM +0200, Andrei Otcheretianski wrote:
> > > The cfg80211 default QoS mapping was updated to align
> > > with the recommendations in section 4 in RFC8325. Align the QoS
> > > mapping test accordingly.
> > 
> > Thanks, applied. Though, I changed this to accept both the current
> > mac80211 mapping and the one proposed in the patch that has not yet been
> > applied.
> >  
> Should I take that to mean that you think making the kernel change is
> reasonable / makes sense?

Yes

-- 
Jouni Malinen                                            PGP id EFC895FA

