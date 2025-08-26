Return-Path: <linux-wireless+bounces-26660-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86059B3734E
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 21:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A51E464A50
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 19:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6439A30CD99;
	Tue, 26 Aug 2025 19:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nct6m36+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A011530CD90;
	Tue, 26 Aug 2025 19:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756237151; cv=none; b=U7+Aq1tZJOC8sgb0s/A1t9RQ8TzbyTTNRMW81iW4fMCFPQmwiq7OR4ersiqcgN7+HA+VRZGK0CCv8AsUV4yHKkasUu7kV51CmNAo9fXB+o9ZsGZYmaLWMqaFNERQTfV8OSC/BkQnlodJIKkDyfOJRbayn/KTdCsM2irxtBMezwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756237151; c=relaxed/simple;
	bh=kFlj5Qjut4Y944cYckca8aJj7ctEj3VynLZeHGxNbGg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WvTUBfcDM1at4ZPV43ilId1+HWdxvQwni40eValEM2aPvxCJ5WTamyJrhNGQ03QlBkBBxKRmzx2RK5tX/HswK20Yq1tvqlrJHiAXRImFYqxJQKi1yXCJCuLvb3A+ohPFn8zFPmwa/4DuP0Tu3pLXRQ/eMrB5LRITqIapqlQbES4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nct6m36+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kFlj5Qjut4Y944cYckca8aJj7ctEj3VynLZeHGxNbGg=;
	t=1756237149; x=1757446749; b=nct6m36++YcTPCCjXwi5GnS54vihWLFBOIaSIV3fpP5R7UN
	jlQL7G5rIZamfGCNk0XB/o2shaiFt7yH7C2VArdF2XUwE62pZQRbkP245beFLS0squwBjMlFufEk7
	Dfu59TnTfYu/IjgoZ2WTXh384Z6pEf+bhSfbpLgSwrLBVHmkzEB8bOCKUaKHcXO+9dMqtDC6M6qHs
	JFa271MsNSvDwUGg4QM+6+8BBCmeAuRTyHVcd5EwJj3LO9+sLoJmZZ7wnzlQ4kpUwMx/fINTEnBs/
	npF9qPOF7jIAuASsGYTDDDlQjrndMrGbjg5rKdq59tz67s3mQb8S39rDJCz+ZrMA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uqzVa-000000047Kb-2vpB;
	Tue, 26 Aug 2025 21:39:06 +0200
Message-ID: <a17c63c51c621031e2bfac56e63d562895583c60.camel@sipsolutions.net>
Subject: Re: [PATCH wireless] wifi: mac80211: do not permit 40 MHz EHT
 operation on 5/6 GHz
From: Johannes Berg <johannes@sipsolutions.net>
To: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>, Miri Korenblit
	 <miriam.rachel.korenblit@intel.com>, linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>, stable@vger.kernel.org
Date: Tue, 26 Aug 2025 21:39:05 +0200
In-Reply-To: <29b001dd-92b5-4afd-a871-f9fbe875e91c@freebox.fr>
References: 
	<20250826202553.a6582f3abf57.Ic670429dc7127f68c818b4290d950ebfb5a0b9e1@changeid>
	 <29b001dd-92b5-4afd-a871-f9fbe875e91c@freebox.fr>
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

On Tue, 2025-08-26 at 21:02 +0200, Pablo MARTIN-GOMEZ wrote:
> > The EHT PHY requirements state that 80 MHz must be supported on the 5
> > and 6 GHz bands unless the STA is 20 MHz only. So if the channel width
> > is limited to 40 MHz on a band other than 2.4 GHz, then disable EHT and
> > downgrade to HE.
>=20
> This is wrong one way or another.
>=20
> If we follow the 802.11 standard strictly [I'm going to use annex B's=20
> items so it is easier to follow], we are implementing EHTP3.3, so a non=
=20

I ... don't think that's a good (correct?) way to phrase it. "Implement
EHTP3.3" means you have 80 MHz support, which is required unless it's 20
MHz only STA. Here we're not really implementing 80 MHz support but
saying that this is a requirement ...

> 20 MHz-Only STA has to support 80 MHz channel width, therefore a 40 MHz=
=20
> (max) STA would not be compliant and we have to downgrade it. The issue=
=20
> is that HEP3.3 also requires that a non 20 MHz-Only HE STA has to=20
> support 80 MHz channel width, therefore downgrading to HE is not ok.

Again this is misleading, HEP3.3 states no such thing, it just asks if
you have it. Clause 27 states though that 40 and 80 MHz bandwidths must
be supported (except for 20 MHz-only non-AP HE STA), so yes, you're
still right that our downgrade is wrong, but talking about conforma
items is confusing at best?

(FWIW, I've also never seen an actual statement from anyone, it really
doesn't seem to be relevant in practice at all.)

> We=20
> have the same issue with VHTP3.3 that requires a VHT STA to support 80=
=20
> MHz channel width, therefore downgrading to VHT is not okay either.

Similarly, Clause 21, not VHTP3.3, and in this case there's not even an
allowance for 20-MHz only STA. I guess VHTP3.3 is a mere formality then.

Anyway I know you meant this only as something to talk about, but I
still think it's confusing, you should state the normative text that
actually requires something, not the (normative) text about what the
manufacturer should state for a device that claims compatibility.


> So=20
> that means that the strictly compliant approach would be to disallow a=
=20
> 40 MHz STA in the 6 GHz band and downgrade a 40 MHz STA to HT in the=20
> 5GHz band.

Looks like, yes. We should probably do that. These are corner cases
anyway though, I don't think I've ever actually seen it happen.

> If we follow the 802.11 standard more liberally, we never enforced=20
> VHTP3.3 nor HEP3.3, so why begin now with EHTP3.3?

Nobody found bugs with the other ones? ;-)

Here it comes down to this actually _happening_ due some devices not
allowing puncturing, and then we can't connect in the right way.

And this doesn't matter to HE, if we connect to an AP with puncturing in
the 80 MHz as an 80 MHz HE station, then it _must_ have HE not punctured
so only 40 MHz. Then if the HE actually moves to 80 MHz the puncturing
in EHT must go away, and the HE is 80 MHz unpunctured which is fine for
the HE STA, so there isn't even a bug.

The only bug would be if the downgrade happens for reasons other than
puncturing (e.g. regulatory bands) but this is very unlikely in the
first place.

So practically, the only issue we had with this is that for EHT and
puncturing, and then the downgrade to HE basically fixes that issue and
we can connect with HE even if we pretend we can do 80 MHz because as
long as the puncturing is there, the AP has to use 20 or 40 MHz
operation for HE (and lower of course.)


I agree though that this isn't really completely correct for HE/VHT if
the downgrade were to happen for other reasons.

However, I also don't think this is an argument _against_ fixing this
issue for EHT. Clearly, for EHT there's the additional practical
puncturing issue that matters. Yes, the APs rate scaling might be able
to cope with it eventually, but if we remain connected with EHT and
pretend we're 80 MHz when we're not, then we could get RUs in the
unavailable part etc. and I think rate scaling would probably not deal
with that well. This is true for HE as well, of course, but see above?

johannes

