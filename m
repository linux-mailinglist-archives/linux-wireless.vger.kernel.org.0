Return-Path: <linux-wireless+bounces-13795-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 153BE9963A0
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 10:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDE8428275C
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 08:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4447D18E045;
	Wed,  9 Oct 2024 08:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZgE1VxV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AD918E032;
	Wed,  9 Oct 2024 08:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463446; cv=none; b=X8HHJTNhejQ7F8v3k6bN6bREUTV6BRbsFRaaMSII8QQndA8cOr9ajBffxEvuQiCifnDUlTSHOZjwGcF9lOVwC6yM7/SVrri3Ody4Piw/SAEiYp8+Bk1xqVi55VtFaSLachZzVhOeaqGbAXSJg8xGSrEDugI0nU6HZDsdkyO8Rl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463446; c=relaxed/simple;
	bh=ceMij/yfbKLvJo6J2VHlzeDQMeXfsggIscfz1kWVik4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPJoPcf5IPTthcylSN+zxhuHqL/cAQkT3ENkt2Py9O77o6GZ4pQpHQR6Dk9Ij0Rz6ZbsYgUUZefNBn18eD6+bM7qvxq8rTTFlo9zxL6E51O3wq25kFSVP02HUT+A5Yfs8sxItZuEWnwsU5KnrTmUbzBpH8kUPorN9fUJy1JUCkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZgE1VxV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF4FC4CECF;
	Wed,  9 Oct 2024 08:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728463445;
	bh=ceMij/yfbKLvJo6J2VHlzeDQMeXfsggIscfz1kWVik4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sZgE1VxVx2v/62JJUVZHh+KqF+47rw+KtEoQHosRPAEMQCrgihLVD4FLPln22/PlO
	 Qw5UOCA9BGcPzWm60t8LKGAlwIx5x53bZfNkEQFG6Z/nfwtSDXKy9/wqR2Hax5bkol
	 HC5xNucZL1KdzEYPCFk+xqNit6YLzELIffu6Lh4sCSesoTxJR4Aj3iU1YzAR4bjxh+
	 fveoxVGtGM825lS5LJn7PVrKJ4xOJeZKtrGhhE+vkyEh2uVY9IpG9v6hKTBWXsNurh
	 FVHjaAAgqa6XZ0TfH74v2IrV20Dd8TC8F9aoIMxIqlyvsmgOwd/e8zV5aUfIVm0a5c
	 TGZ8zzAQBNiyw==
Date: Wed, 9 Oct 2024 09:43:56 +0100
From: Simon Horman <horms@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC net 1/2] MAINTAINERS: consistently exclude wireless
 files from NETWORKING [GENERAL]
Message-ID: <20241009084356.GH99782@kernel.org>
References: <20241004-maint-net-hdrs-v1-0-41fd555aacc5@kernel.org>
 <20241004-maint-net-hdrs-v1-1-41fd555aacc5@kernel.org>
 <87setb7us5.fsf@kernel.org>
 <20241007141305.GD32733@kernel.org>
 <87ed4r4xqn.fsf@kernel.org>
 <a36f0fec7c007031f55e220a0ca585b48630f205.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a36f0fec7c007031f55e220a0ca585b48630f205.camel@sipsolutions.net>

On Mon, Oct 07, 2024 at 08:03:22PM +0200, Johannes Berg wrote:
> On Mon, 2024-10-07 at 20:41 +0300, Kalle Valo wrote:
> > Simon Horman <horms@kernel.org> writes:
> > 
> > > On Fri, Oct 04, 2024 at 06:27:38PM +0300, Kalle Valo wrote:
> > > 
> > > > Simon Horman <horms@kernel.org> writes:
> > > > 
> > > > > We already exclude wireless drivers from the netdev@ traffic, to
> > > > > delegate it to linux-wireless@, and avoid overwhelming netdev@.
> > > > > 
> > > > > Many of the following wireless-related sections MAINTAINERS
> > > > > are already not included in the NETWORKING [GENERAL] section.
> > > > > For consistency, exclude those that are.
> > > > > 
> > > > > * 802.11 (including CFG80211/NL80211)
> > > > > * MAC80211
> > > > > * RFKILL
> > > > > 
> > > > > Signed-off-by: Simon Horman <horms@kernel.org>
> > > > > ---
> > > > >  MAINTAINERS | 11 +++++++++++
> > > > >  1 file changed, 11 insertions(+)
> > > > > 
> > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > index c27f3190737f..ea3ea2c0d3fa 100644
> > > > > --- a/MAINTAINERS
> > > > > +++ b/MAINTAINERS
> > > > > @@ -16197,8 +16197,19 @@ F:	lib/random32.c
> > > > >  F:	net/
> > > > >  F:	tools/net/
> > > > >  F:	tools/testing/selftests/net/
> > > > > +X:	Documentation/networking/mac80211-injection.rst
> > > > > +X:	Documentation/networking/mac80211_hwsim/
> > > > > +X:	Documentation/networking/regulatory.rst
> > > > > +X:	include/net/cfg80211.h
> > > > > +X:	include/net/ieee80211_radiotap.h
> > > > > +X:	include/net/iw_handler.h
> > > > > +X:	include/net/mac80211.h
> > > > > +X:	include/net/wext.h
> > > > 
> > > > Should we add also lib80211.h?
> > > 
> > > Thanks, I missed that one. Perhaps it should have:
> > > 
> > > * An F: entry in the MAC80211
> > > * An X: entry in the NETWORKING [GENERAL]
> > > 
> > > If so, perhaps I can just add that to a v2 of this patch.
> > > Let me know what you think.
> > 
> > Like Johannes said, the cfg80211 entry is more approriate but otherwise
> > sounds like a good plan, thanks!
> 
> Actually scratch that, please just ignore it. I'm going to remove that
> header file entirely and move the functionality into libipw in the
> ipw2x00 drivers.

Thanks,

In that case I'll post a v2 without any code changes.
Rather, bumping it to non-RFC and accumulating tags.

