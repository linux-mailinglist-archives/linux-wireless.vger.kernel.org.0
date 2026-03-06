Return-Path: <linux-wireless+bounces-32646-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOTTFaXNqmkNXQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32646-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 13:50:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C87C9220FA4
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 13:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52C9C3195185
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 12:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642342765DF;
	Fri,  6 Mar 2026 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="EmkNbbSF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE3526B755
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772801026; cv=none; b=hsh5614ybOgIwkTHu/Ey68WFMbMMfV6RNUqOlUiMFpw5MPO01yYytqKKgOvq/QI30mDkXQwbGyVXRf0EHG8lK++4YqY8gwGvVjpnXOka1Od1sb2Cc53zFKW4ow0aKcKGO0kGjOZTkoFmX2ssjhUirAfaKjgjt8hydyrpc8Y+QHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772801026; c=relaxed/simple;
	bh=+3U0Y2FxPJ1q7/oEWiSVZ80hDKz7ZApCRyYcFzaz1EU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oDwZZVUGqodB0qdaEmgvGT/O+kkxNX0AojyWIPXc7IURzuB3i8Guf6QyR14WYZf/GFpipc3a4boDFvU3/jh4xA3Brf+R7Bi7MrIhGOeTgGDzwQvPrdo5LCmelkZMK3qHbNjNJl9zxQzfnrJPDDVRIQ4e1R1NtG/OX4C2To4DSUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=EmkNbbSF; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=xzCmgyx0haB+usOOlnGcDpFIfMv5UsYDqnPw5s4HEto=;
	t=1772801024; x=1774010624; b=EmkNbbSFAX5fw/rhPOLQ/jefNX5hxD6u/Uj8rhN9/040/zm
	mcqO+K6x3IVO+g65Pnx9RfTElZBqaK7lekiFNSKphFRXxyf44CxLUfvTwajkZcnDPpMVu5uk3zHws
	F08XXWADLeVTMMRRKj3/BCYsAlSJffo28NgbCMtvrJ2oZjRzydLyOjmgWg8Td2orFm7e8/Eo0BKOv
	2knLsD1khkCjwr6zGpL6ofwCyO7+S0oQhTvWTRm1s7q3LUxSga/PQGV7kBDO1i4y0TEA84TQiTH77
	4rgNu5y9JDobDLcCuVlLqbvCMMG45CsS1SCn8qe0zKOtHwfEvSzcEmxAqTwQ1i3Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vyUWp-0000000A7d0-0Vtu;
	Fri, 06 Mar 2026 13:43:39 +0100
Message-ID: <d3ecf6e5580cbe50eee807b1e63109e42e3b956c.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v8 2/3] wifi: cfg80211: add initial UHR
 support
From: Johannes Berg <johannes@sipsolutions.net>
To: Harshitha Prem <harshitha.prem@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org
Cc: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>, 
	vasanthakumar.thiagarajan@oss.qualcomm.com, Lorenzo Bianconi
 <lorenzo@kernel.org>, 	ath12k@lists.infradead.org, Jeff Johnson
 <jeff.johnson@oss.qualcomm.com>,  Ping-Ke Shih <pkshih@realtek.com>, Manish
 Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
Date: Fri, 06 Mar 2026 13:43:37 +0100
In-Reply-To: <f3282007-a11a-4f68-86d8-0945e4979d65@oss.qualcomm.com>
References: <20260130154259.265130-5-johannes@sipsolutions.net>
	 <20260130164259.54cc12fbb307.I26126bebd83c7ab17e99827489f946ceabb3521f@changeid>
	 <f96125eeda23451c19067359eb9d10b4047bcdd3.camel@sipsolutions.net>
	 <5d54feea-d0cd-4bd7-b0d2-02e42f0fe5e1@oss.qualcomm.com>
	 <be9ab3c7f05b0f56f19aee0ffc7c2f96138b9a05.camel@sipsolutions.net>
	 <156d6d48-d135-4acf-a5d7-c9ae80523864@oss.qualcomm.com>
	 <0f4b34f0b529fd93fc608d8bbac0e98516b7a3d2.camel@sipsolutions.net>
	 <f3282007-a11a-4f68-86d8-0945e4979d65@oss.qualcomm.com>
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
X-Rspamd-Queue-Id: C87C9220FA4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32646-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi,

> Thank you very much for your patience, and apologies for the delayed
> response. We spent some time discussing this internally and wanted to
> follow up thoughtfully.

Hey, no worries, I'm clearly also not always able to respond quickly, a
lot of things are going on at any given time ...

> > This could get trickier than I imagined - you now have three periods of
> > time:
> >=20
> >  - now
> >  - after CSA but before UHR update
> >  - after UHR update
> >=20
> > and actually all three might need different UHR operation, since the CS=
A
> > can change the bandwidth and therefore e.g. DBE/NPCA. The intermediate
> > period ("after CSA but before UHR update") can be captured by the CSA
> > operation (given a template/UHR operation for after) easily.
> >=20
> > But I was imagining we capture all this in the operations already, so I
> > guess to do that we would need a "NL80211_CMD_MODIFY_MLD_BSS_UPDATE"
> > command that takes the cookie and updates the post-operation values, so
> > that the changes due to the CSA could be taken into account in the
> > previously started UHR update.
>=20
> The idea of introducing an NL80211_CMD_MODIFY_MLD_BSS_UPDATE command
> makes a lot of sense to us. In cases where
> NL80211_CMD_START_MLD_BSS_UPDATE is already in progress, having a modify
> path to update the current beacon seems easier to reason about and
> manage. From that perspective, a pairing such as
> NL80211_CMD_START_MLD_BSS_UPDATE together with
> NL80211_CMD_MODIFY_MLD_BSS_UPDATE feels quite natural.

Yeah, maybe, then it wouldn't ever really go to a normal SET_BEACON any
more, maybe?

I was thinking more for not having to change all the code in hostapd at
a given time, it might be more plausible to still allow SET_BEACON and
just keep giving the counter offsets etc., in case e.g. something "old"
like short-preamble changes.

But clearly hostapd would have to manage those offsets etc. anyway, so
perhaps there's really not going to be any reason to support SET_BEACON
while updates are in progress. But in that case I'd probably argue it
(SET_BEACON) should be disallowed by the kernel, to catch errors.

> Please find below the envisioned design flow for the UHR CU and CSA
> intersection.
>=20
> Hostapd (User)          mac80211 (Kernel)           Air / Station
>    |                           |                           |
>  1 | CMD_START_AP [Adv Notif,  |                           |
>    |  Post Notif, Upd Int]     |                           |
>    |-------------------------->|                           |
>    |                           |                           |
>  2 | CMD_START_MLD_BSS_UPDATE  |                           |
>    | [Link:0, CurTmpl+Offset   |                           |
>    |  (All), Timer, PostTmpl   |                           |
>    |  (All), Type:UHR_CU,      |                           |
>    |  Post UHR Op element]     |                           |
>    |-------------------------->|                           |
>    |                           |                           |
>  3 |                           | [Set Tmpl, Timer: Adv=3D10, |
>    |                           |  Post=3D10, TIM Update]     |
>    |                           |                           |
>  4 |         Cookie X          |                           |
>    |<--------------------------|                           |
>    |                           |                           |
>  5 | EVENT_UHR_CU (CU_START)   |                           |
>    |<--------------------------|                           |

Not sure what the event does really, at this point? It kind of starts
immediately anyway, no? But it also doesn't matter for this high-level
discussion.

>    |                           |                           |
>  6 |                           | Beacons: 10, 9, 8...      |
>    |                           |-------------------------->|
>    |                           |                           |
>  7 | [CSA Triggered: Link0,    |                           |
>    |  Count 10. Sees Cookie X] |                           |
>    |                           |                           |
>  8 | CMD_START_MLD_BSS_UPDATE  |                           |
>    | [Type:CSA, Link:0, Tmpls, |                           |
>    |  Cookie X + Offset,       |                           |
>    |  Post Tmpl (No UHR ele)]  |                           |
>    |-------------------------->|                           |

Not sure I understand the "No UHR ele" part - surely the post template
still has UHR? Or did you mean "UHR parameter update"?

Not that there's a race here - "Sees Cookie X", but who knows the cookie
X is even still valid?

But I think we can pretty much solve that racy by marking a cookie X
invalid in the kernel (or even FW?) and rejecting the new
CMD_START_MLD_BSS_UPDATE operation that still refers to Cookie X -
hostapd would just have to know about that specific rejection reason (I
guess netlink extended status would point to the wrong cookie attr or
so) and then rebuild the templates without taking the update with cookie
X into account.

But with that race aside, yeah, seems reasonable.

>    |                           |                           |
>  9 |         Cookie Y          |                           |
>    |<--------------------------|                           |
>    |                           |                           |
> 10 | CMD_CH_SWITCH_STARTED_    |                           |
>    | NOTIFY                    |                           |
>    |<--------------------------|                           |

I don't know - this was started by CMD_START_MLD_BSS_UPDATE too, so
probably should be some generic notification about it, or like I said
above, maybe isn't even needed at all?

(I think a good chunk of the channel switch notification is code
unification between client and AP, does the AP even use the start
notification?)

>    |                           |                           |
> 11 |                           | Beacons: X=3D7, Y=3D10        |
>    |                           |-------------------------->|
>    |                           |                           |
> 12 | CMD_MODIFY_MLD_BSS_UPDATE |                           |
>    | (Cookie X Post Tmpl w/    |                           |
>    |  Chan Info, 3 Links)      |                           |
>    |-------------------------->|                           |
>    |                           |                           |
> 13 |                           | Beacons: X=3D1, Y=3D4         |
>    |                           |-------------------------->|
>    |                           |                           |
> 14 |                           | [X=3D0: Modify Cur Tmpl     |
>    |                           |  w/ Post UHR Op element]  |
>    |                           |                           |
> 15 | EVENT_UHR_CU              |                           |
>    | (CU_ADVANCE_COMPLETE)     |                           |
>    |<--------------------------|                           |

That should have Cookie X somehow as an attribute, of course :)

Really all the events should have, but here clearly you meant X since
the other operation isn't done yet.

>    |                           |                           |
> 16 | CMD_MODIFY_MLD_BSS_UPDATE |                           |
>    | (Cookie Y Post Tmpl w/    |                           |
>    |  UHR Op + Param elements) |                           |
>    |-------------------------->|                           |

What's this doing? Didn't we have post-Y templates already in the prior
command? Otherwise isn't this quite a bit racy? Though I guess we have a
whole beacon interval for hostapd to update everything, which really
ought to be sufficient (though hostapd may need to stop being single-
threaded ...)

>    |                           |                           |
> 17 |                           | Beacons: X=3D127, Y=3D3       |
>    |                           |-------------------------->|
>    |                           |                           |
> 18 |                           | Beacons: X=3D128/129,       |
>    |                           |          Y=3D2/1 (CSA done) |
>    |                           |-------------------------->|
>    |                           |                           |
> 19 |                           | [Y=3D0: Set Post Tmpl       |
>    |                           |  cookie Y, UHR Param      |
>    |                           |  Off, X=3D130]              |
>    |                           |                           |
> 20 | CMD_CH_SWITCH_NOTIFY      |                           |
>    |<--------------------------|                           |

(similar comment as above wrt. what notifications are needed)

>    |                           |                           |
> 21 | CMD_MLD_BSS_UPDATE_NOTIFY |                           |
>    | (Complete Cookie Y)       |                           |
>    |<--------------------------|                           |

Right.

>    |                           |                           |
> 22 | CMD_MODIFY_MLD_BSS_UPDATE |                           |
>    | (Cookie X Post Tmpl w/    |                           |
>    |  UpdatedChan Info)        |                           |
>    |-------------------------->|                           |

"X post" is a bit misleading ... it's still ongoing, because it's
changed now but not really _after_ the update X, it's still advertising
the update X has happened. So in some way the flow is still there.

But it does point out that we need basically three (additional)
templates for a UHR update:

 - announcing the upcoming update
 - announcing the update happened
 - back to normal state afterwards

Which, perhaps, is indeed a bit too much to offload all to the kernel
even in terms of the API, because if you mix another operation in (here
in your example the channel switch Y), you end up with even more
templates ...

So I'm coming around to the idea that you have a notification and
hostapd has to update the templates at that point.

>    |                           |                           |
> 23 |                           | Beacons Continue...       |
>    |                           |-------------------------->|
>    |                           |                           |
> 24 |                           | Probe Request             |
>    |                           |<--------------------------|
>    |                           | [Fetch TBTT]              |
>    |     send_mgmt (TBTT)      |                           |
>    |<--------------------------|                           |
>    |                           |                           |
> 25 | send_mgmt (Probe Resp     |                           |
>    |  w/ TBTT in UHR Param)    |                           |
>    |-------------------------->|                           |
>    |                           |                           |

Not sure I follow this part regarding the "TBTT" thing. Are you saying
the RX of the probe request would have a TBTT attached to it? But does
it matter, what matters is the TX? And that's probably impossible to get
right?

> The diagram uses a number of abbreviations, so an explanation is
> provided below for clarity.

Oops, sorry, didn't see that before starting to reply, so maybe I missed
something above. I'd go back and check, but I'll have to pick up my kids
soon.

> Step 14
> 	The driver/firmware can update the current beacon template with
> the post=E2=80=91UHR operation element. Until the advance notification in=
terval
> completes, the UHR operation element would not yet be updated.

Not sure I follow, are you envisioning the driver/firmware changing the
beacon contents? I was envisioning it basically always getting the right
template at the right time, and only filling the counters per their
offsets.

> A few potential concerns to consider:
>=20
> 1. Carrying both the current and post=E2=80=91beacon templates for all
> affiliated links of an MLD might make the NL message fairly large. we
> are not sure how well that fits with existing practice, since multipart
> handling seems to be used mostly for dump commands. As an alternate, can
> we have multiple commands with message id and reassemble it?

It's input into the kernel, so the size doesn't matter, I think? For
notifications that might be an issue, and dumpit is used for data going
_out_ of the kernel so userspace doesn't have to have arbitrarily large
buffers ready before it knows the data, but on input I don't see how it
matters.

> 2. There may be a small sequencing aspect worth thinking through. For
> example, if a UHR_CU operation is close to completion and we are about
> to apply its post=E2=80=91beacon template, but before hostapd processes
> EVENT_UHR_CU with CU_POST_NOTIF_COMPLETE it issues a
> START_MLD_BSS_UPDATE for CSA, we could potentially end up using an
> unexpected version of the current beacon template. This may already be
> handled by the existing flow, but it seemed worth calling out for
> completeness.

Yes, I agree, it's something we need to think about. I mentioned that a
bit above, perhaps one way to solve the race is to have a reject built
in based on the cookie(s) being used, that could technically even be
pushed all the way down to the firmware if you really wanted to.

johannes

