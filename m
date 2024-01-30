Return-Path: <linux-wireless+bounces-2824-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678D4842738
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 15:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8992874D0
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 14:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387FC7CF35;
	Tue, 30 Jan 2024 14:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mItYBJKM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7E77CF3C
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 14:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706626403; cv=none; b=F5MCfqtn+11pNDOAAuTav7u3fthLDraiV2EqkNdQEHkAckObZilSVQGfIv3fFHQNctsZSjas5MncGT0PHOaTRZdB+Nk6zOMFgE9WH8n7Ldrar03gCqIo/qU/j3YoKo/IOygh0Fmf2QHUsVgxVOWR5MMtbeiONk8wygUHj7li/dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706626403; c=relaxed/simple;
	bh=uP0FSXlIJxBq/QMS86PWcDLYYFjOEQaYt5me3se8YGI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OkjP/OKkGdcfi6jqyURBAOGhNVenBx1JPeBT7Y0MEGmL3sd+w+z3YgFy8giW1kCG3Uok/x8z9xIrcnDsetG5ruGk3GRAouFozG+VrWgXglFFLVeNpDfSwOQtFI9awYh9H64aeC8H7l9j5h2LcTu475aZIoZX+OmUX0jUJgZQsRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mItYBJKM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0idZGBrT3HF/DBP2MgyE1pB5hmO3uh8NTuXoURb9APE=;
	t=1706626395; x=1707835995; b=mItYBJKMlxMvAwUf5p26/oByc2NapsTRxxHSVLw6mXAM6cO
	Oz0jja/XZksq3QzmSHL5qdQ5vRaZJqCzCvgUxiY61/MyAj4iCMIKarUN6vWEd95G0UvlSLc/MwLmK
	UoML2iuRiNXVphPeZTl0QTEunt8MO1WMjHPa5dEmshTqyI7XGy6+x5pKicrTr9L9ZQf0h0UneGYLU
	Uupp9sQIqXQ8i9WHVEXb5FkxWDmQvc9aDBg2vBLZUyBcSq+iUcfpNXSDDBPgtinC2vPKbY49CrGPW
	ZpUsZtJXmBYi+vrv+G2U/mitt5VYNKUemT4AHiM0DHaSzkghhm1KEI7HXz+6BKWA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUpU7-000000066ia-2drN;
	Tue, 30 Jan 2024 15:53:12 +0100
Message-ID: <fa1b179cd0d4de0c23e967d623f71314efc90235.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: allow CSA to same channel
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>, 
	linux-wireless@vger.kernel.org
Date: Tue, 30 Jan 2024 15:53:10 +0100
In-Reply-To: <f4501322-c9e4-449b-9c81-f64a6d2172fc@quicinc.com>
References: 
	<20240129203544.ef7258d5790d.Idafe22e41621757458d4960659b9621853f7104d@changeid>
	 <f4501322-c9e4-449b-9c81-f64a6d2172fc@quicinc.com>
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

On Tue, 2024-01-30 at 20:14 +0530, Aditya Kumar Singh wrote:
> On 1/30/24 01:05, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> >=20
> > This could be used e.g. for temporarily sending quiet
> > (mode=3D1 in CSA/ECSA), or updating bandwidth. This is
>=20
> I know the intent here (from the other thread), but using the phrase _or=
=20
> updating bandwidth_ is probably not correct since currently without this=
=20
> change also, just changing the bandwidth is possible, isn't it?

Err, yes, indeed... bad commit message.

> Also, bringing a part of the discussion we had in the other thread -
>=20
>  >>> I'm thinking about removing that identical() check entirely - you
>  >>> might want to switch to the same channel with quiet=3D1. At least fo=
r
>  >>> testing that'd be really useful, and I don't think it really serves
>  >>> any purpose to forbid it.
>  >
>  >> Yeah, we can do. But is there any actual use case? Also, what if some
>  >> notorious user space application simply sends NL command without even
>  >> quiet=3D1? There should be some check I guess?
>  >
>  > I'm not sure we care much about a broken userspace application running
>  > with root privileges breaking something here? :-)
>  >
>  > And at least for testing it's very useful to be able to do that. Agree
>  > that identical channel and quiet=3D=3D0 doesn't make _sense_, but even
>  > then I'm not sure there's a lot of value in not permitting it. With
>  > quiet=3D=3D1 at least it does make some sense still though, and we're
>  > currently not allowing it, hence my patch (to be able to test
>  > scenarios like that we saw elsewhere.)
>=20
> Agreed to your point. So in that case, should we skip the identical=20
> check only when quiet=3D1?

We could, though I even now have a test (not posted yet) that's using
this, but I could rewrite it to actually switch bandwidth.

I'm just not sure it's worth the extra complexity? What are we actually
saving ourselves from by doing it? Clearly we have to handle this case,
and whether or not it's quiet shouldn't really matter to the underlying
code?

IOW, yeah, do have that information so we could just add

	!params->block_tx &&

to the condition, but I'm not really sure what the value in that would
be, other than some kind of accurate reflecting of how we think today
CSA should be used?

But now that I think about it, Jouni mentioned yesterday that REVme D5.0
is getting language to allow capability changes during CSA, so that'd be
another thing to check for, you might (eventually) want to actually do a
CSA to the same channel to change capabilities, without quiet?


Anyway, even without that, I think the check doesn't really help for
anything. I'm not convinced the kernel needs to enforce a rule that
"userspace doesn't do something useless"? From a kernel POV it doesn't
matter if you can do it or not.

johannes


