Return-Path: <linux-wireless+bounces-4112-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CABE386A02F
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 20:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805D01F21DA2
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 19:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D10E51C50;
	Tue, 27 Feb 2024 19:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="GKdYn0b8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE2C52F70;
	Tue, 27 Feb 2024 19:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709062070; cv=none; b=KvAmxOUsaqANd3Cy+riQwcVu/SvVN/5rE9Y/hwz6XTsrS4Y3YXbMpqtzv5As/DdGhLnBx4Ol4nVUcKIMHt0sGA5XO7LmPD+5g96HiWP70PFG1ZpaZdCGAKtdwrSej3EulUIGLFCqv4PKTNcyJkM07TuPtcIGcWMXEf9JEe6OhIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709062070; c=relaxed/simple;
	bh=5oEm1RChv3GL4arXwxEkGvioNYmhvDkfvFKj6EpBLz8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=htsDmEtG0kpWea9jP1o04Sshu1zyOTz45zzybapDqv9lRAvO4OzDDusPsf9u+NM49EGz1jLqhB30nWwjAhdSh8fsBgXrvufB91yKei5tMtCo6WzC45A/kX5Stfz+T5ccW21gKxOrz4Ibr7e/pp4dneSRFth/OEQ8tNX/Nq0JxHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=GKdYn0b8; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=5oEm1RChv3GL4arXwxEkGvioNYmhvDkfvFKj6EpBLz8=;
	t=1709062066; x=1710271666; b=GKdYn0b8DoL8SZwBHXpwpsTgyAoAwYK4M00sIeO0dQy8Gp+
	GWDauXoQx3RDFmXhdP511AqE7nc/ji05pm7B0v9KMfzejewjD9G8ppCXgkmlxSRZChMbqapHc0ZF9
	TXjcobIh2W/uJGtFnqPf+H6bqC5FFb2mgaGfx36Xch/PR8kOYActAl6hfH+6bHbeViZjevw9YQD0b
	EIbARL8TeGR8zTrfwbz2bpCzNnl9UAuLPzLi4QiChWw7mUGKFCT+duagmbPGbYv8VEQhxIjgrcYx6
	sSFKv3/XdtYjiGVGmU4VGfJzgwkgSzXCK4jFDEzTQNQZKSYZ+u7b6nP3Sdy+xf5Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rf378-0000000Auqj-49jd;
	Tue, 27 Feb 2024 20:27:43 +0100
Message-ID: <c5cb0ce3a940fa65eee4b5f9d5000da91cf35829.camel@sipsolutions.net>
Subject: Re: [PATCH 1/1] wifi: nl80211: Add support for plumbing SAE groups
 to driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Jakub Kicinski
 <kuba@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>, Vinayak Yadawad
	 <vinayak.yadawad@broadcom.com>, linux-wireless@vger.kernel.org, 
	jithu.jance@broadcom.com, Arend van Spriel <arend.vanspriel@broadcom.com>, 
	netdev@vger.kernel.org
Date: Tue, 27 Feb 2024 20:27:41 +0100
In-Reply-To: <0da40ae1-c033-4089-a64e-27d16bce7ab6@quicinc.com>
References: 
	<309965e8ef4d220053ca7e6bd34393f892ea1bb8.1707486287.git.vinayak.yadawad@broadcom.com>
	 <87mss6f8jh.fsf@kernel.org>
	 <2c38eaed47808a076b6986412f92bb955b0599c3.camel@sipsolutions.net>
	 <20240213174314.26982cd8@kernel.org>
	 <6641f3f90bdc1d24f3a7fd795be672ce02685630.camel@sipsolutions.net>
	 <0da40ae1-c033-4089-a64e-27d16bce7ab6@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

Sorry, I buried this thread because I thought I needed more time to
respond than I had two weeks ago, and then forgot about it. My bad.

On Wed, 2024-02-14 at 08:57 -0800, Jeff Johnson wrote:
> There are good reasons these out-of-tree drivers exist, but there is
> also a movement, at least for the Qualcomm infrastructure products, to
> transition to an upstream driver, in part due to customer requests. So
> it is disconcerting that you are talking about inserting barriers to
> converting to an upstream driver.

FWIW, I don't think of what I wrote as advocating for *inserting*
barriers that didn't already exist today.

> But we need our userspace interfaces to survive since both
> Qualcomm and our customers have years of work invested in the existing
> userspace interfaces and applications. The customers who want an
> upstream driver do not want to be forced to rewrite their applications
> to support it.

Then maybe they don't _really_ want an upstream driver? What's their
reasoning for wanting an upstream driver anyway - usually it ends up
being something around upstream's checks & balances, etc. But not
inventing gratuitous API differences is part of those?

> In the kernel we have a clear mantra to not break userspace. That should
> hopefully hold true when converting from an out-of-tree driver to an
> upstream one.

No, not at all? The kernel's policy of not breaking userspace
unsurprisingly only extends to ... the kernel. Whatever happened out of
tree isn't covered, and really shouldn't be. It doesn't even really
quite extend to staging. And this policy is actually often a reason
_not_ to include something in the kernel, until userspace interfaces
stabilize.

And since this was prompted by my mention of vendor APIs: Our upstream
stance on vendor APIs has been debated and consequently documented here:
https://wireless.wiki.kernel.org/en/developers/documentation/nl80211#vendor=
-specific_api

As far as I'm concerned, there's no intention of deviating from that
policy for the purpose of getting a currently non-upstream driver into
the tree.

johannes

