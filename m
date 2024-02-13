Return-Path: <linux-wireless+bounces-3535-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A36B8530E4
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 13:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5A442817CA
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 12:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A51942077;
	Tue, 13 Feb 2024 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Gbhoccq1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE5242074
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 12:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828557; cv=none; b=Dj9WLpiMxxfjysGj8FHyU4B2Ul0+mK544nPtUbdo2SBKKDFDKzxIDU9UFOUZ3Got8xJVkNIU5mK4VswlkpqzDs7Pjf6baybn6JRYogdK1cdJt2A8Hf2uTlULYA6qTbbOx+0pK8lZtFELDsmpsJUh6f5b8N3oCfTY9upfZ/xQ10U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828557; c=relaxed/simple;
	bh=hLESQfhHwAM4s4wfE++U4Fdw+QtULCoMNXHfstSl32k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DCKy48Ryn4AN16g2gFTt/kYoTaOmi8mERIef987/lWh1nCq7e0UCE6ghp/Onsn8DyCKW0N6YTMlKM2JBVSl1sOhzs+uYB2bpz//IxijjDBPCcO89jhc9OBZMqIGw+JWK1Wsoqlg0FQgauwBzmpSX4HfrZGQbjfSobm0YCSC0ZSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Gbhoccq1; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=uH9g39RSf3UVkpnvhLSqgSvABeynsaDRlP7IqQN8Xrk=;
	t=1707828555; x=1709038155; b=Gbhoccq1S5vbtab22t3lYhU6A9xYexfdXE6yVLazidWvmo6
	twKwRAtGuTLF9s8R43iguscAfqjJLpW8slmVNsrGs8JFtVQDiO8Z0DUEC7w4OSZY17s/60q8+WdgK
	fAdJTDDwdQ1W3fi8jC48G7yRlQVmEaMuioDS8piQKX/9UtH25x1WV8iYvp7HkVYRLcHDRLXk/glP+
	0O9rwFnVMyaKKT7PDqX1T2qFduRGSZ8uvk4IB3ivj7curcrl5hFih9bgipQExYFqrC53HqpGLGPLX
	PMHxr3IRrWiMMAPW9DSdTWuefKpE6idKwykNSHnErDUbl6GcgB0HhXy65lOKPxNw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rZsDm-00000007h7A-2zJW;
	Tue, 13 Feb 2024 13:49:10 +0100
Message-ID: <3c550ae335a9762a9cbd0c8109b6dd99faeb8f6f.camel@sipsolutions.net>
Subject: Re: [PATCH v8 4/5] wifi: mac80211: start and finalize channel
 switch on link basis
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Jeff Johnson
 <quic_jjohnson@quicinc.com>,  Ilan Peer <ilan.peer@intel.com>, Jouni
 Malinen <j@w1.fi>, Ping-Ke Shih <pkshih@realtek.com>, Ryder Lee
 <ryder.lee@mediatek.com>
Date: Tue, 13 Feb 2024 13:49:09 +0100
In-Reply-To: <18c0d4de-392a-420c-8a05-466a83cd2eb8@quicinc.com>
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
	 <bc81466177afd0014ccdd9030c5807339bb288db.camel@sipsolutions.net>
	 <18c0d4de-392a-420c-8a05-466a83cd2eb8@quicinc.com>
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

On Tue, 2024-02-13 at 18:11 +0530, Aditya Kumar Singh wrote:
> > > Correct. Both has got its own advantages and disadvantages. Need to
> > > agree on any one so that all can be benefited. Let's hear from other =
folks.
> >=20
> > Do you _have_ firmware for this already, perhaps?
> >=20
>=20
> Yes, private firmware is there. Not yet upstreamed since the=20
> infrastructure in mac80211 and driver is not there. AFAIK it is in=20
> pipeline. Internal testing have so far been good and did not see any=20
> issues. So at least from Qualcomm perspective, we are fine with=20
> offloading (the above we discussed) to firmware.

Ah, OK.

Note that if we have all the offsets I guess you could still do all the
parsing? Though adding the per-STA profile in cross-link scenarios would
be a difference if hostapd has to do it in the template vs. firmware
copying the elements ...

For the record, I really don't like copying the elements and not sure
I'd want to implement that in mac80211/hwsim...

> > I mean, I'm happy to be designing this "greenfield", but ... it seems
> > unlikely at this point?
> >=20
> > Also what about ath12k with the multi-device changes, would the driver
> > have to handle it? Or I guess you have to sync the TSF somehow anyway,
> > so you could handle it based on TSF/TBTT?
> >=20
>=20
> Ath12k firmware also supports beacon offload and hence firmware is=20
> taking care to add the respective IEs in per-STA profile of the=20
> reporting links while host just sends the template for the affected link=
=20
> via beacon template update and indicating that critical update has happen=
ed.

OK. So I guess we have to support that? Or are there any chances we
could agree on something here overall and then the firmware can be
changed to support another mode?

> > That seems messy for all the reasons I mentioned, since it involves
> > parsing/defragmenting/merging/fragmenting per-STA profiles etc.
> >=20
> > Do you really want to go there?
> >=20
>=20
> I understand things looks to be messy. But at least internally we have=
=20
> done in that way and things look simpler (on kernel level). Not sure=20
> whether all firmwares would agree to that.

And hwsim, but yeah :)

> > Not sure what you mean here - we can still offload beaconing with a
> > template, just have to fill in the template a bit more (with partner
> > link CSA counters rather than just own CSA counters)?
> > > I'm basically thinking this:
> >=20
> > 1. Firmware is aware of partner link CSA counters/TSF offset/TBTT
> >=20
> > 2. Host driver (hostapd) sets beacon template of affected link to
> > include CSA elements, and already today we include in the setting the
> > offset to the countdown fields, so it doesn't matter where those are.
> >=20
> > 3. Host driver (hostapd) *also* updates beacon templates of partner
> > links, but instead of saying "here's the CSA counter to update" it says
> > "here's the CSA counter for your partner link M to set" (OK, so there
> > potentially are multiple of those, but that's OK)
> >=20
> > 4. Firmware doesn't need to parse anything, it just needs to go through
> > the beacon when transmitting it (for any link) and set the CSA counter
> > fields for the link itself and/or for the partner links according to
> > what the correct counter is per TBTT rules, TSF offset, beacon interval
> > etc.
> >=20
>=20
> Hmm.. I see your point. So basically there is tradeoff - complexity of=
=20
> handling the parsing and all in firmware or complexity of handling those=
=20
> many offsets in kernel. I believe when hostapd updates the templates for=
=20
> the partner links, it would have to send offsets so we may need to=20
> extend our NL infrastructure for MLO in order to accommodate all those=
=20
> list of offsets during beacon template update.

Yes, of course. But that doesn't seem _too_ complicated? Even supporting
max # of links (14) and ~3 counters each isn't a huge list... netlink
doesn't care, and drivers have lower link limits anyway.

Maybe I'll do a prototype later? But for now

 a) I need to test the client-side code I'm writing in some other way
    (element injection or something)

 b) let's wait for Realtek to comment also after the Lunar New Year :)

Thanks!

johannes

