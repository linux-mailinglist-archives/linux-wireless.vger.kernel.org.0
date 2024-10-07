Return-Path: <linux-wireless+bounces-13604-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0D8992E89
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 16:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283241C2349F
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 14:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3151D6194;
	Mon,  7 Oct 2024 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dr58iKIJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5C31D5CFE;
	Mon,  7 Oct 2024 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310390; cv=none; b=OQAMQgoE9rCjSAuY+/suogMbI3aME6VBICxyjO/p/Pht1c/d0mgwsi+b7FTOAgu+7Fux2QxUV4D/mySGrOEvjCAUWzVWXaxZCd5/w1yhiGK2XRclTZyuWvIRqeAz1Y56KMX3N1v40YCPS7E83cz3E7uSk1GlZNvmFc0HCNTZxZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310390; c=relaxed/simple;
	bh=Q1jjSFnn8BCegChgaeiVjnWd1Z9orDVcRfxjZA2FmVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAj+e+hRuGEUakntepclVonWBFe5plTdL3dPevYnGX2jYgxRMDS27E/1adfO2KrGBbbexVILouWdIOT7kLxaKB8qLfcKqBlr4yE+SDtpdopiOT9ASGofcOi5CE7d540t7Q0DMfeuAsgDCzVZy24BKihKBc5UNnevYWw7CkVd2bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dr58iKIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9161DC4CECF;
	Mon,  7 Oct 2024 14:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728310389;
	bh=Q1jjSFnn8BCegChgaeiVjnWd1Z9orDVcRfxjZA2FmVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dr58iKIJOji9L3nPvAnoTGWd5+cR0xrosBE3KBJInZn/RSeP5FwyvF7o/FtJr8sJ1
	 +nljj5eyyIwr9WvbNTyJSNPF22vRU7jhh3xZwxkruvTOWL2Nj/w8Fb0tCydRFgKwaX
	 PIu97p5uc6X1L/T6Z8FXcVDdRDC799eMzYDZH48tXqhKz5Z4+PmN6kLkfdtSdMu7jC
	 5+QXNigYIwjBDUFgGzzkEZUmRBFQZzmNG5k7lu5Q/hIZKQCaT8GeshzlenEjcoWUUo
	 UjVcEuOjD4KkCH/rfxAE3VPXLqaq+GdDkRqo+NN8Azoppg7TJC4Ee0CN4ZpJBb3HJk
	 dThMRMqMQ/ygw==
Date: Mon, 7 Oct 2024 15:13:05 +0100
From: Simon Horman <horms@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC net 1/2] MAINTAINERS: consistently exclude wireless
 files from NETWORKING [GENERAL]
Message-ID: <20241007141305.GD32733@kernel.org>
References: <20241004-maint-net-hdrs-v1-0-41fd555aacc5@kernel.org>
 <20241004-maint-net-hdrs-v1-1-41fd555aacc5@kernel.org>
 <87setb7us5.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87setb7us5.fsf@kernel.org>

On Fri, Oct 04, 2024 at 06:27:38PM +0300, Kalle Valo wrote:
> Simon Horman <horms@kernel.org> writes:
> 
> > We already exclude wireless drivers from the netdev@ traffic, to
> > delegate it to linux-wireless@, and avoid overwhelming netdev@.
> >
> > Many of the following wireless-related sections MAINTAINERS
> > are already not included in the NETWORKING [GENERAL] section.
> > For consistency, exclude those that are.
> >
> > * 802.11 (including CFG80211/NL80211)
> > * MAC80211
> > * RFKILL
> >
> > Signed-off-by: Simon Horman <horms@kernel.org>
> > ---
> >  MAINTAINERS | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c27f3190737f..ea3ea2c0d3fa 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16197,8 +16197,19 @@ F:	lib/random32.c
> >  F:	net/
> >  F:	tools/net/
> >  F:	tools/testing/selftests/net/
> > +X:	Documentation/networking/mac80211-injection.rst
> > +X:	Documentation/networking/mac80211_hwsim/
> > +X:	Documentation/networking/regulatory.rst
> > +X:	include/net/cfg80211.h
> > +X:	include/net/ieee80211_radiotap.h
> > +X:	include/net/iw_handler.h
> > +X:	include/net/mac80211.h
> > +X:	include/net/wext.h
> 
> Should we add also lib80211.h?

Thanks, I missed that one. Perhaps it should have:

* An F: entry in the MAC80211
* An X: entry in the NETWORKING [GENERAL]

If so, perhaps I can just add that to a v2 of this patch.
Let me know what you think.

