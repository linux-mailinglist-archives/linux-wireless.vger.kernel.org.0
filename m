Return-Path: <linux-wireless+bounces-25866-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4C9B0DF74
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 16:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DDA617320F
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 14:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383012E92C7;
	Tue, 22 Jul 2025 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Y+TjzFOo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C08D2E9EB9
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 14:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195332; cv=none; b=XZKzoEMApJgsqy74agY7bTE0Skb4kPr867K84Y+MPhZ5dRisb2J9opirtWBEYuI/+esgFcX44HoJ7o5ReFH3RZRY5ltQ3ju8Njvd4xVsKOVtwrZ/hP+7ylaINKnA6piWxmR9LUaQsfQuv5WLmAFspg4I+KuGLqs2da4SgR1c5Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195332; c=relaxed/simple;
	bh=7Sn9Pr3k/UEQFs7uynHgq6K/b2KVT3isEhjRF0VAZpc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FevfEzWtiOiX0Sgl8LApotT0Av0klh9BoAWFfIJGxpZLa/fDzPXrotQXrwjRcE98vdRkESRH3N+xuydg5pmEFbc+a6WzeJ1vEacSXPFDzbpvNqOILiue4H59R1W4LFgtP3c52h79gM3XlvA6kEvd2iWuwOXw36qXV8hdGgDO2oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Y+TjzFOo; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=fGtSDPWra64/S1y8jWx0tHa677joIW08bFQN0B46iqI=;
	t=1753195330; x=1754404930; b=Y+TjzFOo8FlXh0cYxIzfkeL+q5kSFO/XOHY/4J2Aim0qNcf
	POfslKbk8viaNH3h8lHG72F2PfbzNxo7eb4hjIF/wFJNX3mopQWDG9tCcZB5gybuydT7igcdlYEcA
	6c5kObpVZASHfHPgUN4+v7XDhs83WBnT6dLYMWr/BJqIzEAUA8nyaOnu3SqGUmthQQQCxgUBoCTDt
	Ng9ZLTjX8NU5dc8LfCzUESiHFrwXRa9u+RXG/ajAa238CzClWHVHP7GP6KGwuUec5agyi5EqYiaow
	NzIrxs7Xxt16ZGxYK0S858ta5Ynbpy2Cdz7AE5rJMmBha3UtQSU7psrhpm/norfA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ueEBw-00000002F6Z-24UV;
	Tue, 22 Jul 2025 16:42:04 +0200
Message-ID: <1a77ca6a35ad03f839b7c997de3977b521d88edc.camel@sipsolutions.net>
Subject: Re: [DESIGN RFC] Critical Update handling in the kernel
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, Ping-Ke Shih
	 <pkshih@realtek.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee
	 <ryder.lee@mediatek.com>
Date: Tue, 22 Jul 2025 16:42:03 +0200
In-Reply-To: <20250717045540.27208-1-aditya.kumar.singh@oss.qualcomm.com>
References: <20250717045540.27208-1-aditya.kumar.singh@oss.qualcomm.com>
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

Hi,

Thanks for writing this up! I really think Realtek and Mediatek should
comment - CC'ing some folks.

> "What about vendors whose firmware does not support this functionality?"
> "What about mac80211_hwsim? How this is supposed to work with
>  mac80211_hwsim?"

I really like the hwsim part because we really can't even test the
client side right now ...

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>                             OPEN QUESTIONS
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> Before we move forward with implementation, we'd like to confirm whether
> the proposed design looks sound. Are there any concerns or potential issu=
es
> we should be aware of?
>=20
> Out of curiosity, we're also interested in understanding how other vendor=
s
> are currently handling this feature in their downstream drivers. Is it
> typically offloaded to firmware, or is the logic implemented in the kerne=
l?
> Just want to confirm whether all this will be used only by mac80211_hwsim
> or will there be any actual users?

I think Ping-Ke previously indicated that they were planning to do
things host side? I'm not super familiar with the timing constraints
though, so I'm not sure what that might imply.

> Critical Update is a mechanism where, if a BSS parameter changes on one o=
f
> the links within a Multi-Link Device (MLD), that change is also signaled =
in
> the beacons/probe response of its partner links. This allows the multi-li=
nk
> client to be proactively informed of the update through any of the partne=
r
> links, rather than waiting to receive the updated beacon/probe responses
> from the affected link itself.

FWIW we also have some client side code for it already. It's probably
broken ;-)

> This ensures that multi-link clients monitoring Link B can be promptly
> informed of the change on Link A, without needing to wait for Link A=E2=
=80=99s next
> beacon.

Btw, you make this a lot about "without needing to wait" and the whole
timing, but another, I'd maybe even argue more important, aspect of this
is that they don't have to be receiving the beacon at all. For example
for EMLSR clients, or clients that aren't even active at all on a given
link, they might not/cannot see the beacons for all links at all, even
if they're nominally connected on those links.

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>                             DESIGN PROPOSAL
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>=20
> Assumptions:
> ------------
> The critical update procedure is highly timing-sensitive.=C2=A0

There are two aspects here that I feel maybe you're conflating a bit. On
the one hand, yes, some of it needs to have the precise information for
the counters. OTOH, some of it is really not _that_ timing critical,
e.g. whether or not you actually get the information live at exactly the
right time. Though of course a frame that's transmitted after a beacon
that advertised CSA should not suddenly _not_ advertise it even cross-
link.

> This design introduces additional computational overhead, which could
> potentially delay beacon processing. Since not all mac80211 drivers may
> prefer this behavior, introduce a new extended feature flag -
> CRITICAL_UPDATE_SELF_MANAGED. mac80211 will NOT perform these extra
> computations if the driver advertises this feature support.

Fair.

> Parsing the beacon update:
> --------------------------
> During the ieee80211_assign_beacon() call (where link->u.ap.beacon is
> updated whenever the beacon content is initially set using
> ieee80211_start_ap(), modified through ieee80211_change_beacon(), or
> changed as a result of channel or color switch events) -
>=20
> 1. Store the new beacon data in a new pointer, following the usual flow.
> 2. Parse the beacon (using the head and tail pointers) and record the
>    starting offsets of each required Element (earlier referred to as IE i=
.e
>    Information element) in an array, indexed by element id or extended
>    element id. This is done per link object.
> 3. If a previous beacon exists:
>     3.1 For each element related to the critical update, perform a memcmp=
()
>         to detect changes compared to the previous contents.
>     3.2 If any such element has changed, set the critical update flag in
>         some link-level object (e.g., link_conf). (this is for the affect=
ed
>         link)
>         3.2.1 At the same time, set the critical update flag for all
>               partner links as well in the same object.
>     3.3 Increment the BPCC[2] value (modulo 256 excluding 255) for the

(as an aside, I think this is really funny - it's obviously the same as
"modulo 255", but I guess I can also see why they worded it that way...)


>         current link.

Wouldn't it be far simpler to have hostapd indicate the critical update,
and even the BPCC value? It also has to include BPCC in RNR and other
fields, do we really want to _parse_ all of that and update all those
values?! Seems iffy at best.

> 4. If critical update flag got set in previous step for partner links, ca=
ll
>    link_info_changed() with CHANGED_BEACON to notify lower layer that
>    beacon has changed. This applies only in case when beacon is offloaded
>    to firmware. In case beacon is given to driver at every TBTT, there is
>    no need to notify since at next TBTT, driver will fetch the latest
>    beacon anyways.

Sure.


> Forming the new beacon:
> -----------------------
> In the __ieee80211_beacon_get() function, where the beacon SKBs are
> constructed:
>=20
> 1. Allow the existing logic to generate all beacon SKBs (including multip=
le
>    SKBs in the case of MBSSID-EMA).
> 2. For each beacon SKB:
>     2.1 Parse the RNR (Reduced Neighbor Report) element.
>         2.1.1 For each TBTT Info entry:
>             2.1.1.1 Extract the BSSID
>             2.1.1.2 Retrieve the corresponding link sdata from BSSID
>             2.1.1.3 fetch the latest BPCC value.
>             2.1.1.4 Update the frame with this latest BPCC value.

Yeah, I really don't like that... Do you really do that in firmware
today? That sounds all really painful.

>     2.2 Parse the MBSSID profile element.
>         2.2.1 For each non-Tx profile:
>             2.2.1.1 Extract the BSSID
>             2.2.1.2 Retrieve the corresponding link sdata from BSSID
>             2.2.1.3 If the critical update flag is set in link object, se=
t
>                     the CU (Critical Update) bit in the capability elemen=
t.
>             2.2.1.4 Set non_tx_update =3D true.
>     2.3 Parse the multi-link element.
>         2.3.1 For the self link (already known), fetch the latest BPCC
>               value.
>         2.3.2 Update the frame with this BPCC value.
>     2.4 Update the capability element in the SKB:
>         2.4.1 If the critical update flag is set, set the CU bit.
>         2.4.2 If non_tx_update =3D=3D true, also set the non-Tx CU bit.

How much of that can we let hostapd do?

> This mechanism sufficiently handles critical updates due to modifications
> of existing elements (elements related to the critical update which are
> already present in the beacon and just one or more field is/are changing
> its value). However, in the case of new element inclusion (elements relat=
ed
> to the critical update which are not alread present in the beacon, but is
> getting added from next beacon), additional handling is required.
> Specifically, the newly included elements related to the critical update
> must be added to the per-STA profile within the Basic Multi-Link Element
> (BMLE) [3].

That seems almost like an over-optimisation? If I'm reading this
correctly, this is basically describing a situation like this

(x indicates a beacon TX)
=20
link 1    x        x        x        x        x        x        x
link 2         x        x        x        x        x        x        x

                     ^ link 1 starts channel switching
                       (after its own bcn, before the next link 2 bcn)

and saying that really the next link 2 beacon will already indicate the
link 1 beacon will be switching channel.

But is that really actually a case worth worrying about? You can always
consider it as if this had happened:

link 1    x        x        x        x        x        x        x
link 2         x        x        x        x        x        x        x

                         ^ link 1 starts channel switching

i.e. as if link 1 had decided to do channel switch just _after_ link 2's
beacon instead.

Does that really significantly change anything? I'm not so sure?

> To achieve this:
>=20
> 3. Allow the existing logic to form the beacon SKB as previously defined
>    (this already handles modification updates).
> 4. Maintain an extra_len variable to track any additional space required
>    for including additional elements.
> 5. While parsing:
>     5.1 If critical update is going on in partner link due to inclusion o=
f
>         elements, increment extra_len accordingly.
>     5.2 The required length is determined using the eid/ext eid based
>         offset  maintained in each beacon data structure.
>     5.3 Since the element offset is known, and the next byte is the tag
>         length, the total length is tag_len + 2 (for EID and length
>         fields).
>     5.4 Account for any additional fields that may be needed (e.g.,
>         sub-element ID and length in the Multi-Link IE).
> 6. Compute the new beacon size:
>      new_size =3D current_size + extra_len
> 7. Allocate a new SKB with the updated size.
> 8. Copy the existing contents and insert the new or updated elements at t=
he
>    appropriate offsets.
> 9. Since IE offsets are cached in the beacon data structure, the entire I=
E
>    can be copied directly without re-parsing the full beacon from other
>    links.
> 10. Free the original beacon SKB.
> 11. Return the newly constructed beacon SKB.

That kind of also seems like hostapd could just update the beacons?

> DTIM beacon handling:
> ---------------------
> As per requirement [4], the Critical Update (CU) bit in the capability
> field must be cleared in the DTIM beacon.
>=20
> For Non-Offloaded Beacon Handling:
>     1. The function __ieee80211_beacon_add_tim() is responsible for
>        updating the DTIM count.
>     2. When the DTIM count reaches 1 (indicating that the next beacon wil=
l
>        be a DTIM beacon), the critical update flag in the corresponding
>        link object should be reset.
>=20
> For Offloaded Beacon Handling:
>     1. If precise control is required:
>          1.1 Since DTIM updates are managed by the lower layer (typically
>              the firmware or driver), an API will be provided to explicit=
ly
>              reset the critical update flag.
>          1.2 The driver, upon detecting that a DTIM beacon is about to be
>              transmitted, can invoke this API to perform the reset.
>     2. If some timing inaccuracy is acceptable:
>          2.1 mac80211 can maintain a timer to reset the critical update
>              flag after a DTIM interval.
>          2.2 However, this approach may lead to synchronization issues, a=
s
>              mac80211 cannot guarantee the exact timing of beacon
>              transmission handled by the hardware.

I guess I can see where this is needed, yeah. I think I'd probably go
for 1, it's simpler for mac80211 and worst case drivers can have a
counter or something themselves and do that after pulling the DTIM
beacon from mac80211.

> Update BPCC back to NL:
> -----------------------
> After the kernel increments the BPCC value, it can emit a netlink event
> containing the updated BPCC value. This allows hostapd to receive the
> latest BPCC and include it in probe/association response frames, as
> required by the specification.
>=20
> This coordination ensures that all - beacon, probe response, and
> association response frames reflect consistent BPCC values, maintaining
> compliance with spec-defined behavior for multi-link and critical update
> handling.

Yeah not liking this too much I guess... Why can't hostapd maintain
BPCC?

> Counter offset handling of partner links:
> -----------------------------------------
> Note: This applies only in case of offloaded beacon case.
>=20
> Since not all links operate with the same beacon interval, the firmware
> cannot simply decrement the counter on every self-beacon transmission.
>=20
> To handle this correctly:
> Each BPCC counter will be associated with:
>     * An offset (location in the frame where the counter resides), and
>     * A periodicity value, indicating how often the counter should be
>       decremented.
>=20
> The firmware is expected to:
>    * Track the number of self-beacon transmissions per link.
>    * Decrement the counter only after the specified number of
>      transmissions, as defined by the periodicity value.
>    * This ensures that counter updates are aligned with each link=E2=80=
=99s
>      individual beacon schedule, maintaining spec compliance in multi-lin=
k
>      scenarios.

True. Although I expect some devices might simply prevent different
beacon intervals.

> Complexities:
> -------------
> When adding elements in per STA profile, the element length might exceed
> hence fragmentation needs to be handled properly.

We have fragmentation but all this parsing means also we need
_defragmentation_ first, which is awkward?

> memcmp vs hashing
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> In the section where memcmp() is used to detect changes in beacon element=
s
> (to determine if a critical update is needed), this logic could
> alternatively be handled at the hostapd level.

Yeah sounds better to me :P

> Since hostapd does not retain the previous beacon frame, it cannot perfor=
m
> a direct memory comparison. However, it can compute and store hashes of t=
he
> required elements during beacon formation. On subsequent updates, it can
> compare the new hashes with the previously stored ones to detect changes.

It doesn't necessarily even have to do that - it could also track
internally when it made changes. Like when something actually starts a
channel switch. Or color switch maybe, or something.

johannes

