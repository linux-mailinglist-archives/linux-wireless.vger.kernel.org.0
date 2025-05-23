Return-Path: <linux-wireless+bounces-23363-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFC9AC22B3
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 14:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8CB1641BE
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 12:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAF9E56A;
	Fri, 23 May 2025 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OJXch0QA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA8CC8CE
	for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748003646; cv=none; b=AsXZ4SG9ruAQU+LF/BJl+1Yl3z9sYlU1G4Gko/oz07p1wOEsZtqguvxci4yRLO2rFDVteBDMu1CelhvAKrsgR3fvYQz4ZOnYfaJ9FBjCPJ4r/Z0veL/9y1PDjJar1yV0tf7P53C6olyDr5mPfeOUWl88onAbT2CbfvNRBEcuaI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748003646; c=relaxed/simple;
	bh=hgLhq86/61P96EAkFOWPhZjzjey057Xq+ZKsIXOitbQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VTUgV2dcpbV25z++adC8u4msL2O1tcVGMgHn2YNWnbpzbXYLZO6c7FOzGmZu1Gz78I3UZuSufJZ3rVlvTtHks91aAQWHoDPdoNSw7HKPelkFnAVDJd0DkQNcJRByKmlBbP021bdG8yfWmc5MhVOnZ74qTvSDC2BAm2/O0vyTs8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=OJXch0QA; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hgLhq86/61P96EAkFOWPhZjzjey057Xq+ZKsIXOitbQ=;
	t=1748003645; x=1749213245; b=OJXch0QAZFEefRNGhDqYe4L35t/WqxygqzonRJPhIp72uvl
	1N+HsEVKLJqlcqbOmH77w6al/RuyGppSY2B2bP1DUElVyHLxxjveIMDqw60gS5In80+qiHV8IK8KL
	fm94u+3Jf04wvr+krIbPkCft8l7Ad0chhMa6fD6zljixfE1C/owzJ6XqQ593a4FmGpy5zz/ruH2f0
	zA6n9qqb0/X6gzCbCzMGM+qwwUs1fx0C6uVAwe/KQx1hAQqC61OJGH/IDmPVhEk2L2nF+7/pJppdQ
	gHSoqh9O9RIc9TS1XEl5tGTo8u7J9drKfrQcEtKBtjNpz5l9L/nNZiULiUcQ7NJQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uIRb8-00000001bdM-2NiO;
	Fri, 23 May 2025 14:34:02 +0200
Message-ID: <e5241e83e7675a3db309c9bdab378549ee27ee45.camel@sipsolutions.net>
Subject: Re: Association comeback delay behavior
From: Johannes Berg <johannes@sipsolutions.net>
To: James Prestwood <prestwoj@gmail.com>, linux-wireless@vger.kernel.org
Date: Fri, 23 May 2025 14:34:01 +0200
In-Reply-To: <56bcd608-bda2-40a8-9314-d978a39bf90f@gmail.com> (sfid-20250523_142830_627240_DB8B57A9)
References: <ba82ab00-ecf7-44fe-95db-355795c3520e@gmail.com>
	 <2e1fdb77f2ed5f381323f6a493c62ea1bdec19a7.camel@sipsolutions.net>
	 <56bcd608-bda2-40a8-9314-d978a39bf90f@gmail.com>
	 (sfid-20250523_142830_627240_DB8B57A9)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

(uh, please trim quotes)

> > > 1. The kernel takes the delay in the association response frame and
> > > waits, but has no sane bounds for how long the wait is. An AP could s=
end
> > > 0xffffffff and the kernel will just block for that entire duration.
> > For some value of "block", it's not really blocking in the (traditional=
)
> > threading sense of the word :)
> Yes, true, its not blocking the kernel. Just blocks userspace unless=20
> that event is handled, which isn't handled by any userspace supplicants=
=20
> AFAICT.

wpa_supplicant seems to handle it just fine? I guess in an ideal world
we'd have made it some kind of opt-in, or the supplicant would've given
some sort of maximum wait value.

> > Oh, so you're just trying to sell us a missing implementation in iwd as
> > a kernel security bug? :-)
> Depends on how you look at it I guess. Handling the event in userspace=
=20
> almost feels like an escape hatch for the kernel having used untrusted=
=20
> input but that's just how I see it. Waiting 15 minutes for a WiFi=20
> connection that should take 200ms is on the level of absurd and=20
> unreasonable from my view, but that's just my opinion.

But it shouldn't take 200ms. The comeback can be larger and you may
actually want to wait for it if you have no other choice of AP anyway.
Sure it takes less than 200ms to connect in normal cases, but comeback
already isn't an immediate connection. Whether that then is 15 seconds
or 15 minutes - sure, the latter seems excessive, but I'm not sure I'd
want to define a timeout somewhere between there. Given your
argumentation it sounds like you'd say "1 second is excessive", but
that's just under the _default_ setting in hostapd for
assoc_sa_query_max_timeout.

johannes

