Return-Path: <linux-wireless+bounces-8145-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 442088D09E1
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 20:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6182B21B45
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 18:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9BD15FCFE;
	Mon, 27 May 2024 18:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ts958yWY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB0BD518;
	Mon, 27 May 2024 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716834543; cv=none; b=c1k1oRLOpbeOD2892sPS9ZEoBWlmgua4fQDh9R8+YQ6BObu13+i45cB++wPhE0yy5EIWWp4NZ5+xzZTFIMtimjLlMXK1nLtDzy6StOgDXifBliCQeMzDoEDybipdQ+Fh3Z8ziCu+Pdp+V6yd9CImFs0OFUwbQmhmuvJxskVfScY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716834543; c=relaxed/simple;
	bh=WCEO9fUe+0GQf8DDEogefQXVqjO2ehsYlYrxbZijXSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/Q4/5mHLg+dKR0pU0bWk9XPtdAyHlK7q1w0SRpWJN/JPr1JAVjxb0EijIsbCqjn1i8CrZrP2XDQE8wU6T7OtiDRE3TL2NJr9KYyvpX/JXDLerGx85C1EUByAvaDmQYkDSX5BKIRCZyyxadULhWOhoBbq2gZp5EX24SY/hG11w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ts958yWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06725C2BBFC;
	Mon, 27 May 2024 18:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716834543;
	bh=WCEO9fUe+0GQf8DDEogefQXVqjO2ehsYlYrxbZijXSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ts958yWY3Uvgact64hd/8yz4QyfDipMqtBbY/9pVuFx+VF1ewGl8LXX5oEJyebBNf
	 j+b3dC4Dbh0v1012gogIXFfxbjJCf/QDEnnSW4dVov7qH0Mp1bcckdjelsWFugx+s0
	 4MRV+cu3sey7bBVubpney7vFb8erx5y5Uch8dW4o=
Date: Mon, 27 May 2024 20:29:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Oleksandr Natalenko <oleksandr@natalenko.name>,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Peter Chiu <chui-hao.chiu@mediatek.com>,
	StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] MT7915E doesn't work any more with v6.9
Message-ID: <2024052750-rippling-catty-1cb5@gregkh>
References: <6061263.lOV4Wx5bFT@natalenko.name>
 <2341660.ElGaqSPkdT@natalenko.name>
 <60fe8df750a74331b8a54a76d55d5e8349ac46b4.camel@sipsolutions.net>
 <878qzy9zly.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878qzy9zly.fsf@kernel.org>

On Sat, May 25, 2024 at 09:26:01AM +0300, Kalle Valo wrote:
> Johannes Berg <johannes@sipsolutions.net> writes:
> 
> > On Wed, 2024-05-15 at 00:51 +0200, Oleksandr Natalenko wrote:
> >> Also /cc Johannes because of this commit:
> >> 
> >> 6092077ad09ce wifi: mac80211: introduce 'channel request'
> >> 
> >> On středa 15. května 2024 0:43:40, SELČ Oleksandr Natalenko wrote:
> >> > Hello Felix, Lorenzo et al.
> >> > 
> >> > With v6.9 kernel the following card:
> >> > 
> >> > 01:00.0 Unclassified device [0002]: MEDIATEK Corp. MT7915E
> >> > 802.11ax PCI Express Wireless Network Adapter [14c3:7915]
> >> > 
> >> > doesn't work any more. Upon mt7915e module insertion the following splat happens:
> >> > 
> >
> > 6.9 didn't get commit 2f7cf3b61d85 ("wifi: mt76: mt7915: add missing
> > chanctx ops")? Huh?
> 
> Yeah, commit 2f7cf3b61d85 should have been taken to wireless tree but it
> fell through the cracks. I didn't realise that it's an important bugfix
> and the commit message didn't give any indication of that either.
> 
> But commit 2f7cf3b61d85 is now in Linus' tree so it would be good if
> someone could submit it to stable releases.

It's already in 6.9.1, does it need to go anywhere else?

thanks,

greg k-h

