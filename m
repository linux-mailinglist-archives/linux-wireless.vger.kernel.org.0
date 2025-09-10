Return-Path: <linux-wireless+bounces-27200-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4B1B50EA9
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 09:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08E05484AE2
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 07:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A6D36124;
	Wed, 10 Sep 2025 07:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Tnqx284I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AEE2367B3
	for <linux-wireless@vger.kernel.org>; Wed, 10 Sep 2025 07:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757487687; cv=none; b=r6wteArTvyG0KTZbDSTowfHln6TqNI23v1UUx0trHaLDoxkhm1uiPSJwXNXdZTyII08r9GmPzJMKKnHA460SlaT0e6LHBZHoJsTGxiCpJ0o3v1KG1hJ5YYs3kn+tsAhSduodsMU+3q5ZghHdThi/PsgV5/1UeyVIIzWuldZNumg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757487687; c=relaxed/simple;
	bh=XlM+giqcpswLZJxjbIcpQPVPSCvqBaUrRT5aDO3lS+U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=neTLRbVAxZyR22f6uTjlc1tpL9FMnGwx+geIiaPNB+RYf9MFuOk9vMGSYy4Qsu1eryg79ZW681vrGawrLv5BvQvHp6w9UXxA8zS2R+Q/mFinRW3+S0jGFwHebDnOV+DwFBStxNYW7cyV71XkTT8wqWXBP1Zeg31Z0+ErwIvuBy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Tnqx284I; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XlM+giqcpswLZJxjbIcpQPVPSCvqBaUrRT5aDO3lS+U=;
	t=1757487685; x=1758697285; b=Tnqx284IlFg6vvCBbq+qRMxQoVBpfZQD0WIIy6QvVZ3Mtrl
	9xtptKffVHmbbaS9RipP6j80naGsbzv0H3UpAehiDs4wl55c5IaZI5nxtTHsRfFatDf9vWchxX4GW
	/rMCgckrY/K2FCrkD6aerUamdCfpH8W7DDvg+XxbPbz8+/m+E2Bzp+JBNTjkqfTUUzTOOVqT4kC1C
	2KZMb78mI8r86x2Nj7EBg+I3+Fd4sWg6it8IbI163Hm3bcU/fMcQP7+7FEsrwUkjZa0bbBO7TFjxg
	bEHDK/kNohSYN4aLZ2m7OK3cdmmqVD37JhyWK6bXdeGVBF/0RTo/HBLPs3jSAocw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uwEpW-0000000CKrQ-3kDq;
	Wed, 10 Sep 2025 09:01:23 +0200
Message-ID: <2735aec6379159923299d6cfb916a2bf03aecf18.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: always mark 6 GHz BSS as QoS/EDCA
 capable
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Isaacs <scaasiffej@gmail.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 10 Sep 2025 09:01:22 +0200
In-Reply-To: <CAOYMkPqAt-ETcwL7ZzUUB=0YO-ML+Mh60cB_-8MZj6zcp_-Cxg@mail.gmail.com> (sfid-20250910_012009_776209_02EFD101)
References: <20250909135510.757750-1-scaasiffej@gmail.com>
	 <8d5d8339f1dd568f43d97c4ed60817df1838fc13.camel@sipsolutions.net>
	 <CAOYMkPqAt-ETcwL7ZzUUB=0YO-ML+Mh60cB_-8MZj6zcp_-Cxg@mail.gmail.com>
	 (sfid-20250910_012009_776209_02EFD101)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-09-09 at 19:19 -0400, Jeff Isaacs wrote:
> Ok yeah I should have included a bit more info to begin with. First, I wi=
ll
> defend my assertion, then I will give more details on the motivation behi=
nd
> this patch.

:)

I'll point out first that this area is actually rather complex because
nobody is actually implementing QoS as written in the spec, but rather
WMM as documented by the relevant WFA spec, and then assumes it
satisfies the QoS requirements in the 802.11 spec (e.g. for HT/... STAs)

> [snip]

Sure, a 6G STA is a QoS STA. That doesn't mean a 6G AP STA is exempt
from actually announcing the QoS parameters.

> So the current logic in mac80211 to downgrade to legacy in absence of
> the WMM IE is flawed when the beacon is captured on 6 GHz, because
> any STA operating in 6 GHz must be at least implement HE and all of its
> required features.

It isn't: we internally first downgrade to legacy (because all of HT and
higher require QoS/WMM) and then don't connect because HE is required
and we cannot connect as a non-HE STA on 6 GHz.

> One more supporting item from the spec.
>=20
> 802.11-2020 =C2=A710.2.3.2 -
> "The QoS AP shall announce the EDCA parameters in selected Beacon
> frames and in all Probe Response and (Re)Association Response frames
> by the inclusion of the EDCA Parameter Set element using the information
> from the MIB entries in dot11EDCATable. If no such element has been
> received (e.g., prior to association in an infrastructure BSS), a non-AP
> QoS STA shall use the default values for the parameters."
>=20
> So it is explicitly stated that it is possible that a beacon frame can be
> received from a QoS AP without the EDCA parameters included. And
> since a non-AP STA cannot initiate a probe request with a wildcard for
> the SSID in 6 GHz, it has no choice but to use the default parameter
> values outlined in the spec until the QoS AP instructs otherwise.

Here in some way the difference between WMM and QoS becomes relevant,
but even if we read this as WMM=3D=3DQoS, I'm not sure I agree.

I suppose this is an interpretation matter, but "[t]he QoS AP shall"
already _requires_ the QoS AP to include that element. Any deviation
from that makes it non-compliant, and there's not much of an assumption
on STA behaviour from that point on.

The example in the "If not such element has been received [...]"
sentence to me at least implies that these are not meant to be cases
where the AP misbehaves if it doesn't include it (which is already
established by the first sentence), but is meant for the cases where
there's no QoS AP that controlled the parameters, "e.g., prior to
association in an infrastructure BSS", or also perhaps when associating
to a non-QoS infrastructure BSS, or similar cases.

> Now for my motivation for introducing this patch. I have observed that th=
e
> WMM element is not present in beacon frames in the 6 GHz spectrum on
> the Ruckus R770 when multiple BSSs are packed together using the
> MBSSID feature. The WMM IE is included in the top-level profile, but not
> in the non-Tx profiles defined within the MBSSID element.

This is a pretty common AP bug around element inheritance [1]. They
assume that it's inherited from the transmitting BSS, which is not true.
Actually, this is precisely _because_ of the difference between WMM and
QoS. If it were QoS elements, it _would_ be inherited, because all
elements are inherited unless overwritten in the specific profile. Since
it's WMM carried in a vendor element, any other vendor element overrides
the inheritance. Therefore, either _none_ or _all_ (intended) vendor
elements including WMM must be included in each non-transmitting
profile.

[1] Sometimes in MBSSID non-transmitting profiles, sometimes in multi-
link profiles, sometimes maybe even both.

> I am in contact
> with support, but the initial response I got from Ruckus is that this is
> intentional.

They're wrong, and even the language you quoted above makes that crystal
clear, as does the WMM spec [2]. We've (indirectly) actually discussed
this with Ruckus, and they have in fact acknowledged that this is a bug
in the AP and that they will fix it.

[2] though that never talks about MBSSID (I think) so you have to read a
whole bunch of cross-spec text wrt. inheritance etc.


> And well it makes sense I guess. If the spec defines default values, and
> the whole point behind MBSSID is to save airtime for data transmission,
> then why repeat the same unchanged default QoS values for every BSS.

No, see all the discussion above. The default values (in the BSS case)
are for when you're connecting to a non-QoS AP and pre-association use
cases etc.

> I also figured that they had to go through a lot to get the WiFi 7
> certification. If this is truly an error, I would be surprised if I'm
> the first to notice it, given that the R770 shipped out beginning in 2023=
 :)

They cannot pass certification with this bug, but it's possible that
either they started including more vendor elements since, or changed the
configuration in other ways, or the specific MBSSID configuration isn't
tested in the certification, etc. But this _is_ validated as part of the
certification, if the scenario arises.

> So I dug through the spec, and ended up with this chain of reasoning for
> why the WMM IE is not required in 6 GHz.

... but it's still wrong since it's a clear *shall* requirement. I hope
I've been able to convey that.

Right now, as annoying that may be for you, I'm inclined to not change
anything here since multiple AP vendors confronted with this issue have
agreed that it's their issue and will be fixed. If we work around it
now, they have no incentive to fix their implementation. We have a bit
of market power here to push in the right direction, rather than piling
on workarounds on our side.


However, if in fact it later turns out that there are unfixable APs out
there, then given the reasoning I outlined above for how your
argumentation is wrong, I think the only plausible workaround would be
to (erroneously!) inherit the vendor WMM element from the transmitting
BSS, rather than making assumptions about it. We'd also have to do this
for change tracking which makes it all the more complex, and certainly
wouldn't want to apply it in strict mode.

johannes

