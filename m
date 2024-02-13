Return-Path: <linux-wireless+bounces-3525-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 435A3852E77
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 11:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6E428A58E
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 10:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC20286A6;
	Tue, 13 Feb 2024 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="SxWdSU6Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470072572
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821762; cv=none; b=uLWUaByxAOAGnHOokOE+M3a8ovzNyFqt5ukrUaqL6BSpzXNENL57fo4F1NQXyjzAQfsKIdcGaH6tjZ/p90Z62kf/k2cUOlH66vOy+bsqyrxdy071ojdX+T3XDs9I+IXoJXNRMx4EjJz+AgnHgiUNDJvhcnrq3IyKAfNPbkInaLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821762; c=relaxed/simple;
	bh=g76vAzkWaJW9nBI3EhCNUsRFNC6heTiMEpNUdTUigmc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VhYTkurqumfcCAPPo089e4F1dmZuNLeupIQASJglnkJdjFwC3EqlbOuHJAgrU2Fz/wB5Pc9Xwh7nGoOq4F3yN5O/I7SQ7minxCQFEVyJeQWirXxFmNjfZsLZq4PEfDLm1f5vySxCkuACSwY9LB4rFeDI/NV4osoYPFHM2VXbteM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=SxWdSU6Z; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ktp+4m/u4FkuGhn8aHabmoXd8118SbZ7ID3n/FrVxFo=;
	t=1707821760; x=1709031360; b=SxWdSU6Z4IGA/5nKAxfdk8ylXSQPrUa0K3Jx6ap3i86qGGo
	dmMQEI+l3hpTywQdeNs3NGOvyU0Z0eSNaUHcG1l7kgJrGvUWCBuX1QVNluH+9dAt0TcIVkdzG9ir9
	W5TF9uvZAXzKQTDCZ/i1FwpjV8Xcw607tQ4y8zsYYqhiy9yu4nBSaqazzmqR8bPQMhfLNG0ocUswH
	VLtmp4BeoE0MqPWA68hQFcwUunYd0LhZQqWRnnHmBSv/tYKVN6EwN58FV78P181VDd6b87UrgV3XT
	wFiNbBIZFbLPpz2NuRYlxt54g4QAQF7ejrqhIHVnu1RUpCIJlfb7JZA4SwycETKA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rZqSA-00000007d9F-46zN;
	Tue, 13 Feb 2024 11:55:55 +0100
Message-ID: <bc81466177afd0014ccdd9030c5807339bb288db.camel@sipsolutions.net>
Subject: Re: [PATCH v8 4/5] wifi: mac80211: start and finalize channel
 switch on link basis
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Jeff Johnson
 <quic_jjohnson@quicinc.com>,  Ilan Peer <ilan.peer@intel.com>, Jouni
 Malinen <j@w1.fi>, Ping-Ke Shih <pkshih@realtek.com>, Ryder Lee
 <ryder.lee@mediatek.com>
Date: Tue, 13 Feb 2024 11:55:54 +0100
In-Reply-To: <5c0fd2eb-eb19-4b69-a325-ad9eef633336@quicinc.com>
References: <20240130140918.1172387-1-quic_adisi@quicinc.com>
	 <20240130140918.1172387-5-quic_adisi@quicinc.com>
	 <b73dd1f9c23c164179c38e2109aa1550d87e87ed.camel@sipsolutions.net>
	 <646d1e3e404a437f4c99c80996eb4f194ac242b8.camel@sipsolutions.net>
	 <26df9aa6-e497-4040-ad5c-c647454acca6@quicinc.com>
	 <b2cf5c1d-7842-4e59-b25a-904a6879fa9c@quicinc.com>
	 <f7174207668cac149246cafa0e4b4749ee3289f0.camel@sipsolutions.net>
	 <ac5825e8-0cb1-476e-be5c-ad0170122f77@quicinc.com>
	 <fe2100dcfe9ae9b4517f239faf25374c27f473a5.camel@sipsolutions.net>
	 <5c0fd2eb-eb19-4b69-a325-ad9eef633336@quicinc.com>
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

On Tue, 2024-02-13 at 15:48 +0530, Aditya Kumar Singh wrote:
> On 2/13/24 14:12, Johannes Berg wrote:
> > On Tue, 2024-02-13 at 10:46 +0530, Aditya Kumar Singh wrote:
> > > On 2/12/24 20:16, Johannes Berg wrote:
> > > > So ... I'm looking at the client side, and thinking about that.
> > > > According to the spec, multi-link element should be present in beac=
ons
> > > > of APs affiliated with the same MLD if one of the (other) links is =
doing
> > > > CSA, and then have also the CSA counters of course, relative to the
> > > > target link's TBTT (of course.)
> > >=20
> > > Yes correct, you are referring to critical update(s) right?
> >=20
> > I was actually thinking the critical update flag is rather not all that
> > interesting, but the inclusion of the CSA-related elements in a
> > (partial) per-STA profile in the Multi-Link Element is. Those contain
> > the countdown fields, so need to be updated - according to the TBTT of
> > the link doing the CSA, not the link sending it.
> >=20
>=20
> Yes correct, this CSA thing is interesting but there is one more thing -=
=20
> handling of the BSS param change count (BPCC). Let's say the affected=20
> link undergoes CSA, then in its Basic Multi Link IE, BPCC should be=20
> incremented. But at the same time, in RNR of its partner links, where=20
> this affected link is there, the BPCC should also be incremented.
> All though here it is not incremented with every beacon Tx, but still=20
> change in one affects beacon of other partner link(s) at least once.

Yes, I know, but IMHO that's not all that interesting, I'd think hostapd
could handle that.

> > Note that I'm basically asking you, Mediatek and Realtek how this shoul=
d
> > work. We're almost certainly not going to support multi-link AP in our
> > device any time soon, and we could adjust the firmware to it anyway if
> > needed.
> >=20
> > So while I agree that punting it to firmware would be somewhat nice, we
> > still have to agree on (a) or (b), because (b) requires more informatio=
n
> > from hostapd etc., but (a) requires _substantially_ more (and very
> > complex) parsing in firmware... If you wanted to support multi-BSSID,
> > then it's even more complex, which would argue for (b)?
> >=20
>=20
> Correct. Both has got its own advantages and disadvantages. Need to=20
> agree on any one so that all can be benefited. Let's hear from other folk=
s.

Do you _have_ firmware for this already, perhaps?

I mean, I'm happy to be designing this "greenfield", but ... it seems
unlikely at this point?

Also what about ath12k with the multi-device changes, would the driver
have to handle it? Or I guess you have to sync the TSF somehow anyway,
so you could handle it based on TSF/TBTT?


> > I was trying to keep opinions out of this, but personally, I really
> > don't like (a), it puts too much complexity in the hands of firmware
> > engineers ;-)
> >=20
> > > Firmware could maintain the counter (for the affected link) and (I
> > > assume it will be aware of the partner links) so whenever partner lin=
k
> > > transmits a beacon it could add the CSA (or such IEs) in per STA prof=
ile
> > > of the reporting link. It could get the contents from the affected li=
nk
> > > but actual value of the counter could be filled from the global count=
er
> > > being maintained. But not sure whether we can force every driver's
> > > firmware to do so?
> >=20
> > I'm not sure I understand that description - how would firmware even
> > know which elements to take from what partner link etc.? I think hostap=
d
> > still has to add the elements, and firmware would just populate the
> > counter field(s)? But yeah that requires knowing from which partner lin=
k
> > to populate.
> >=20
>=20
> Yeah so underlying assumption/thought was -
> 1. Firmware is aware of partner links

Sure.

> 2. Host driver just needs to update the beacon template of the affected=
=20
> link and some how indicate to firmware that this is critical update.

Sure.

> 3. As per spec, there are around 21-22 changes classified as critical=20
> update and among those only handful of those which has adding the IE in=
=20
> per STA profile. So firmware could possibly maintain a table to see if=
=20
> the affected link's beacon template has such IEs which if present needs=
=20
> to be added in partner links, it could add it as and when partner link=
=20
> transmits a beacon.

That seems messy for all the reasons I mentioned, since it involves
parsing/defragmenting/merging/fragmenting per-STA profiles etc.

Do you really want to go there?

> 4. Once CSA is finished, the host would update the beacon template which=
=20
> will not have CSA/ECSA IE... such IEs. Then firmware can stop adding to=
=20
> per STA profile as well of the reporting links.

Yeah I guess that's just a corollary of 3 :)

> But yeah adding to per STA profile when already elements are there and=
=20
> then first de-fragment and then add and then later fragment would be a=
=20
> tedious job :)

Yeah...

> > If you really wanted the firmware to handle the partner link informatio=
n
> > completely it'd not only have to parse the Multi-Link Element on other
> > links but also _modify_, and know what to do, etc. - I don't think
> > that'll really work so well.
> >=20
> > Think about it some more: On the link doing the CSA you'd have to parse
> > the beacon template and understand where the CSA-related elements are
> > (CSA, ECSA, Channel Switch Wrapper, possibly more?), and copy them
> > aside. Then on the partner link(s) parse the Multi-Link Element, see if
> > there's a partial STA profile already for some reason, merge the CSA-
> > related elements into that, update the counters; all while first
> > removing the 2 levels of fragmentation, and then re-doing them ...
> >=20
>=20
> Yeah complex on firmware level. But even if we solve this on kernel=20
> level, existing drivers who have offloaded beacon to firmware from 11ax=
=20
> or before itself, still need to handle it? It would looks ugly that till=
=20
> 11ax it is offloaded and from 11be it is again put back to kernel?

Not sure what you mean here - we can still offload beaconing with a=20
template, just have to fill in the template a bit more (with partner
link CSA counters rather than just own CSA counters)?

I'm basically thinking this:

1. Firmware is aware of partner link CSA counters/TSF offset/TBTT

2. Host driver (hostapd) sets beacon template of affected link to
include CSA elements, and already today we include in the setting the
offset to the countdown fields, so it doesn't matter where those are.

3. Host driver (hostapd) *also* updates beacon templates of partner
links, but instead of saying "here's the CSA counter to update" it says
"here's the CSA counter for your partner link M to set" (OK, so there
potentially are multiple of those, but that's OK)

4. Firmware doesn't need to parse anything, it just needs to go through
the beacon when transmitting it (for any link) and set the CSA counter
fields for the link itself and/or for the partner links according to
what the correct counter is per TBTT rules, TSF offset, beacon interval
etc.


Note that this could easily be implemented even in software for hwsim or
drivers that don't offload beacon template to the device (like ath9k
though obviously that has no multi-link), *iff* you know the TSF offset
and TBTT of the beacon being created.
Currently the CSA counters are just decremented every time you request a
beacon, but the partner link counters would have to be calculated - but
if you know
 - the intended TBTT of the beacon to transmit
 - the TSF offset to the link undergoing CSA
 - the beacon interval of the link undergoing CSA
you can calculate
 - the TSF of the link undergoing CSA at the TBTT of the beacon we're
   creating,
 - the previous TBTT of the link undergoing CSA by the TSF (some
   calculation involving TSF modulo the beacon interval)
 - therefore the CSA counter of the link undergoing CSA to fill in

In hwsim it's even easier because we only request the beacon at the
TBTT, and the TSF offset is 0 ...

johannes

