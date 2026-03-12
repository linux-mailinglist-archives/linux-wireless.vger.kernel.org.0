Return-Path: <linux-wireless+bounces-33071-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKq2JEF4sml/MwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33071-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 09:24:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCFB26EDF7
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 09:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3677830457DD
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 08:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3EA279DAD;
	Thu, 12 Mar 2026 08:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xmefmJcN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DE9350D46
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773303744; cv=none; b=odNBUJUmNs+6/8PQb0MlN4bowpMh6wToOgI1dh8M/UGeQN1e6QpgWacIaVs9wr/WnPeqsQxDkgEtJMQ32NPWwGe4W06sreIQnhEScGj+EaZgatji+X9cKOE++7GusLoYJTfza3XMHs/vcbKhqyz4F7EkQ7cU+GHydI+JKT5dLY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773303744; c=relaxed/simple;
	bh=FVp77Lw09FgH1PD5v1uOFcEhB/e49iHLHDpqG5J1JBg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ex3flKFxyv06/JmvHPfqfDCHNsLTThtRmFswwoEacqygVXJeDkB+0UC3LP0cgHuv9mU7JTwhzwYinsASu8LtOFYyOWJ/N7KUZmJeUEEaKPlg8tHjhDxpTDBR8ShES7QwoT4dNo1Yy3QWDYHFutjcWH0xx8EKv48Z88C9BMpJ2FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xmefmJcN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=mInBjNwnmOVstovthVyAp86y9JrXwEc/jfaTJc6nf50=;
	t=1773303739; x=1774513339; b=xmefmJcNqyTYZuX3+kTAQ/xJ+aU9fUsdQRe3hqVQysqnolq
	+JBUXuYpODtt6dpyjXqGqY/aJ1I+m7vFtM6+labf+BI7ljgql3ZI5M2/DWKcoz8ksgrq4BeEO9QOV
	S/BEaNCWZ04YgqZrs7C5PVew8Oriw/sUwUXhN2qgQ01+MJtGyCdsOC3VaYt+2pd4hjd1uQBc+mCoB
	uw/XeENdZk5bmC3bS5KdeYUXYvm9TckXEyGXECuWXX6VeAEkjSmconWLAsk0hs3q1feWrPsAqSuQ6
	m1+NheT5rIA1r35aeHilv+ez8pngl+Oyezf3tEXRqim/E1bHjsYzfMC9iy155zUA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w0bJ2-0000000Fjkr-3E48;
	Thu, 12 Mar 2026 09:22:08 +0100
Message-ID: <c676b2cd73463fa88f459f0416c60b03f20dd027.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v8 2/3] wifi: cfg80211: add initial UHR
 support
From: Johannes Berg <johannes@sipsolutions.net>
To: Harshitha Prem <harshitha.prem@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org
Cc: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>, 
	vasanthakumar.thiagarajan@oss.qualcomm.com, Lorenzo Bianconi
 <lorenzo@kernel.org>, 	ath12k@lists.infradead.org, Jeff Johnson
 <jeff.johnson@oss.qualcomm.com>,  Ping-Ke Shih <pkshih@realtek.com>, Manish
 Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>, Jouni Malinen	
 <j@w1.fi>
Date: Thu, 12 Mar 2026 09:22:07 +0100
In-Reply-To: <416d08f1-6b8d-4bf7-9a63-c3c68497d990@oss.qualcomm.com>
References: <20260130154259.265130-5-johannes@sipsolutions.net>
	 <20260130164259.54cc12fbb307.I26126bebd83c7ab17e99827489f946ceabb3521f@changeid>
	 <f96125eeda23451c19067359eb9d10b4047bcdd3.camel@sipsolutions.net>
	 <5d54feea-d0cd-4bd7-b0d2-02e42f0fe5e1@oss.qualcomm.com>
	 <be9ab3c7f05b0f56f19aee0ffc7c2f96138b9a05.camel@sipsolutions.net>
	 <156d6d48-d135-4acf-a5d7-c9ae80523864@oss.qualcomm.com>
	 <0f4b34f0b529fd93fc608d8bbac0e98516b7a3d2.camel@sipsolutions.net>
	 <f3282007-a11a-4f68-86d8-0945e4979d65@oss.qualcomm.com>
	 <d3ecf6e5580cbe50eee807b1e63109e42e3b956c.camel@sipsolutions.net>
	 <416d08f1-6b8d-4bf7-9a63-c3c68497d990@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33071-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: 0DCFB26EDF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-03-12 at 11:19 +0530, Harshitha Prem wrote:
> > Yeah, maybe, then it wouldn't ever really go to a normal SET_BEACON any
> > more, maybe?
> >=20
> > I was thinking more for not having to change all the code in hostapd at
> > a given time, it might be more plausible to still allow SET_BEACON and
> > just keep giving the counter offsets etc., in case e.g. something "old"
> > like short-preamble changes.
> >=20
> > But clearly hostapd would have to manage those offsets etc. anyway, so
> > perhaps there's really not going to be any reason to support SET_BEACON
> > while updates are in progress. But in that case I'd probably argue it
> > (SET_BEACON) should be disallowed by the kernel, to catch errors.
>=20
> Yes, that's the idea when any MLD_BSS_UPDATE is in progress, instead of
> sending SET_BEACON rather use MODIFY_MLD_BSS_UPDATE.

I was going to say that introduces its own set of races, if it's trying
to modify the BSS update while it _just_ finished, but actually that
race exists anyway and we'd want to just reject updates (regardless of
which command is used) that refer to now-invalid cookies.

> >=20
> > >    |                           |                           |
> > >  6 |                           | Beacons: 10, 9, 8...      |
> > >    |                           |-------------------------->|
> > >    |                           |                           |
> > >  7 | [CSA Triggered: Link0,    |                           |
> > >    |  Count 10. Sees Cookie X] |                           |
> > >    |                           |                           |
> > >  8 | CMD_START_MLD_BSS_UPDATE  |                           |
> > >    | [Type:CSA, Link:0, Tmpls, |                           |
> > >    |  Cookie X + Offset,       |                           |
> > >    |  Post Tmpl (No UHR ele)]  |                           |
> > >    |-------------------------->|                           |
> >=20
> > Not sure I understand the "No UHR ele" part - surely the post template
> > still has UHR? Or did you mean "UHR parameter update"?
> >=20
>=20
> At this point, the CSA post-beacon template would not include the
> updated UHR operation element, since hostapd needs a way to determine
> whether that element should be added. The updated UHR operation element
> is expected to be reflected only after the advance timer expires.
> In a scenario where the CSA completes before the advance timer expires,
> the CSA post-beacon may not actually require the updated UHR operation
> element.

Oh, you were thinking of the _updated_ element only? I read it as "no
UHR operation at all", which seems nonsensical since it's still UHR.

> For example, if the UHR advance timer expires before the CSA completes,=
=C2=A0

(taking this out of the paragraph)

This seems like a bit of a strange "if" though - hostapd set the timers
in beacon countdown for both, so it can trivially predict which one is
going to expire first, there's nothing that can stop that from happening
the way it was predicted.

It obviously has dependencies between them, but I don't see a way to
avoid them.


> Because of this, an event-driven approach was considered.
[...]
> it could
> notify hostapd, which could then update the CSA post-beacon template
> with the updated UHR operation element via MODIFY_MLD_BSS_UPDATE.

So I think all this is an interesting question we should really decide
on first, before we continue with the details of the design.

We have been talking a lot about templates here, and associated latency
issues, and the question of hostapd being single-threaded comes up again
later in your email, etc.

Each UHR update operation will have three pending templates:
 - announcing the update will happen (counting down)
 - announcing the update has happened (counting up)
 - steady state after the operation

Each additional overlapping operation adds another template (another UHR
update operation is [currently] not permitted by the spec, so there's no
second "counting up"):

 time
  |
  v
  |
  x <-- beacon transmission
  |
  | UHR update starts
  |   - template I: announcing update will happen
  |   - template II: announcing update has happened
  |   - template III: steady state after UHR update
  |
  x <-- switch current template to I, two more pending
  |

...

  | CSA starts
  |   - update current beacon I to I': include CSA
  |   - update template II to II': include CSA
  |   - update template III to III': include CSA
  |     (assuming CSA finishes after UHR parameter update)
  |   - add template IV: post UHR update and post CSA
  |
  x <-- current template is I' now
  |
  | (If now something else happens that should be reflected in
  |  the beacon _immediately_, all four I', II', III', IV templates
  |  need to be updated.)
  |
...
  |
  x <-- UHR update takes effect, switch to II'
  |
...
  |
  x <-- UHR update is no longer announced, switch to III'
  |
...
  | channel switch actually happens
  |
  x <-- CSA has happened, is no longer announced, template IV
  |
...

(and you could have more of these overlapping, say link removal happens
at the same time, BSS color change, etc., but each new operation only
updates all the templates and adds at most a single new one, UHR updates
two new ones.)

And if that seems complex already, I haven't drawn this up for multi-
link! That would actually have an effect over all the links of the AP
MLD, since they interact with each other too, and carry some information
with counters from the other APs.

So if only _one_ link is doing updates, the number of templates just
multiplies by the number of links, and if multiple links are doing
overlapping updates you add all of those together; three links doing two
overlapping updates each would have four templates each and thus require
a total of 18 templates! (But that's "only" six overlapping operations.)

Oh and each of those templates would have a whole bunch of counter
offsets, since the counter for each operation may need to be set in
multiple places.

This is clearly a *lot* of complexity, and we haven't even really talked
about sending Probe Response, (Re)Association Response, EPP Capabilities
and Operation Parameter Response (and perhaps other) frames, some of
which may have to carry all of those (six) counters in various places.


My original thought was that yes, indeed we can manage this complexity
in the kernel - each set of these operations gets a set of counter
offsets, and we can either do that in mac80211 or have API to let
firmware fill in the counters, and=C2=A0even extend that so that each
operation's cookie can be given for other frames (mentioned in the
previous paragraph). It does get tedious though ...

(I was going to write something about event-driven updates here, but
another thing came to mind first.)

Considering multi-link, event-driven updates, and all the response
frames that I mentioned above, made me realise that we also need to
think about the design in terms of beacon TBTTs for multiple links. I'd
think that the spec allows having different beacon intervals for
different links, and there are TSF offsets, but there's a question here
if we actually want/need that in the implementation.

If not, and the TBTTs for multiple links are aligned, that could
simplify things quite significantly. If yes, perhaps due to the multi-HW
architecture you (Qualcomm) have, it would require a more complex design
to get it right, especially considering that you could have say 4-5
links max and need to send the response frames.

If beacon intervals are the same and TBTT aligned, then basically you
just have to update all the link beacons once each beacon interval, and
could send (handwaving a bit) the response frames with an indication
that they are expected to go out during a specific period of time, and
if that time is mispredicted by hostapd the frame would get dropped by
the driver/FW, and hostapd could send another response instead with the
updated counters etc.

In this case, you could also make the whole beacon template update
handling event-driven, and just have a single "beacons transmitted"
event to hostapd while any operations are ongoing, and hostapd would
just update all the beacon templates for all the links at that point,
including even writing all the counters itself even, it has plenty of
time (a whole beacon interval) to do that.

However, if they're not aligned, you'd need an event per link, and then
handling it on time is really only plausible if we can require the
beacons to either be at the same time or have a "minimum distance",
because otherwise you could end up with really small time intervals.
It's still maybe possible in that case, because hostapd would know which
link(s) got the beacon TX event, but it'd have to update all links for
each event, and if there are beacons close to each other that could
easily become impossible, because after any beacon TX event it has to
update _all_ links before _any_ link transmits a new beacon, and so it
doesn't work if they're only a short time apart.

I'll stop here, I think there are a couple of system design questions in
this that we need answers on first, particularly the question about
beacon alignment across multiple links. But it also affects how we send
the response frames, and it _would_ be nice to not have to offload the
counter filling in those to the kernel/driver/firmware, since that would
make it far more extensible (e.g. for the EPP frame that doesn't seem to
have been considered so far.)



> It might be possible to rely on a generic notification when this is
> started via CMD_START_MLD_BSS_UPDATE. That said, since CSA has existed
> for a long time, I was wondering whether also sending CH_SWITCH_NOTIFY
> for backward compatibility could be considered, at least initially.

Fair. I think probably easier to _not_ have it, since hostapd would
otherwise have to figure out which one to handle, but I guess TBD.


> That=E2=80=99s a fair point. With multiple operations potentially occurri=
ng in
> parallel, it does seem possible that this could gradually result in an
> increasing number of templates being involved.

Yes. I spelled it out more above :)

> > So I'm coming around to the idea that you have a notification and
> > hostapd has to update the templates at that point.
>=20
> Yes, that does seem to align with the direction here. This approach
> would still partially rely on event=E2=80=91driven updates (for example,
> reacting to a UHR event) to modify the BSS via CMD_MODIFY_MLD_BSS_UPDATE
> for csa. At the same time, since such notifications would likely require
> the beacon templates to be updated fairly promptly, it does raise some
> open questions around prioritization and handling on the hostapd side,
> particularly given its single=E2=80=91threaded nature.

Sure, but I think we're reaching a point where the single-threaded
nature will need to be reconsidered anyway, if only to offload longer-
running operations (such as SAE/EPPKE calculations) to another
thread/CPU.

> > >    |                           |                           |
> > > 23 |                           | Beacons Continue...       |
> > >    |                           |-------------------------->|
> > >    |                           |                           |
> > > 24 |                           | Probe Request             |
> > >    |                           |<--------------------------|
> > >    |                           | [Fetch TBTT]              |
> > >    |     send_mgmt (TBTT)      |                           |
> > >    |<--------------------------|                           |
> > >    |                           |                           |
> > > 25 | send_mgmt (Probe Resp     |                           |
> > >    |  w/ TBTT in UHR Param)    |                           |
> > >    |-------------------------->|                           |
> > >    |                           |                           |
> >=20
> > Not sure I follow this part regarding the "TBTT" thing. Are you saying
> > the RX of the probe request would have a TBTT attached to it? But does
> > it matter, what matters is the TX? And that's probably impossible to ge=
t
> > right?
>=20
> What I was trying to describe is the handling of probe and association
> responses during an ongoing UHR CU / EHT CU.

Ah yes, see some thoughts about that above. I think the "fetch TBTT"
basically inherently leaves a race - if we want to fully solve that we
either have to have some "drop frame if it was wrong" thing like I
described above. Perhaps that could be expressed in "don't send this
frame after this TBTT" or something instead of linking to the
operations.

> In such cases, when a probe request or association request is received,
> the corresponding response may need to reflect the current countdown
> state. For example, in the case of UHR, a probe response might need to
> include an UHR parameters update element with the appropriate countdown
> value.

Right, across all the links.

> The idea was that, at the time the response is being constructed, the
> current countdown could be obtained from the relevant cookie and made
> available to user space. This would allow hostapd to build the probe or
> association response accordingly.

Yeah but it's racy anyway, and if there's anything event driven hostapd
knows the counter already. I described some thoughts above, so not going
to elaborate more here for now.


> > It's input into the kernel, so the size doesn't matter, I think? For
> > notifications that might be an issue, and dumpit is used for data going
> > _out_ of the kernel so userspace doesn't have to have arbitrarily large
> > buffers ready before it knows the data, but on input I don't see how it
> > matters.
>=20
> Based on the earlier discussion in the below thread, I had wondered
> whether there might be a potential bottleneck here.
>=20
> https://lore.kernel.org/all/c7e383a9-c291-426b-a7f1-7845fabbaeeb@oss.qual=
comm.com/
>=20
> We will re=E2=80=91check this internally to confirm whether that concern =
is
> still applicable.

Looks like I never replied to that point there, but I don't think it's
an issue on commands sent to the kernel - the in-kernel socket isn't
limited by the size of any command like a userspace read() or recvmsg()
call is limited to the buffer size it has allocated a priori.

There's no such huge event going to userspace in the design, but I
suppose even if there _was_ we could just mandate that hostapd increase
the recvmsg() buffer size according to the number of links or such that
it expects to handle, or even just use a huge size (a few dozen KiB) for
each call, it's not really a big deal either way IMHO.

We don't want to have such huge events (we really can't have them as
multicast events), and we generally strive to keep dump message size
reasonably small, but I don't think it's going to be a show-stopper.

johannes

