Return-Path: <linux-wireless+bounces-33155-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDZyHNwVs2mDSAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33155-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 20:37:00 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CDB278217
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 20:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E3D13009FA7
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 19:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D342538B7A5;
	Thu, 12 Mar 2026 19:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="k3uJWXgI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521B23AB289
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 19:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773343945; cv=none; b=PFCJtcFtnVpMcU215H8cWXUcN1xJf+N4UcmL/Axpdg0lVhvAA8Mpyz79X6Wt5HjRuiQTDOa8gLj7e/Trcyh6kJ0WrGYC9mDcndRm7nYbRiGS/Do/6VoMSRwWIZDxI0PG2FWDrA2Edr6TYSyFAyrZNH7E41KUZuzPf3kJbaLX428=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773343945; c=relaxed/simple;
	bh=qK1ojqjsiqY/FpNYJ6H/btR8T3wPlybWU1pFOp8Yxl0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J9NYWlKs5w7VPSw3n0WVVMlJrEDnbpI0LlfBqf7NF0JT1Z4zFZt1h8DF8bABhu9XMjaPnFpuZoc5qDCt2XDs9tDg0gjoVR6AfhYcPwXKuhivPsT/8P6bz53G4caMoTwSJSm597nRDx8/FaMRGO2aBoKuvcP5a/ik7RaVxyge+Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=k3uJWXgI; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=y6q4rh5v1FfxDKm6chdHrxsbiY7AY2DsNWJQ9IE1ea4=;
	t=1773343944; x=1774553544; b=k3uJWXgIWtVAv7IOF066j1dvwYMtXtVBAQ3IY5SNm+LB44G
	9FxB0Tp2VEK29iL2L/OUdEnJxWxtE+fLjiZOKRfkwS4TXsU7wphRopWAY2qsbXdtx2bRVfrD3zeC+
	su/JA0kM1oEKjXEEuFpzOci1wDxvKSHaSAMqPHhOC2HP0zWEqLvo1Go4cDnOrNBBNz7Vsmx7oZgxO
	kL4qkuLzOkUvB5sWBbLYvM/35g2sJH1jr70tdtNTdIjEf/2h53USpw5xl3ljrE4e49hjqj1f4RIMr
	w7VfGGnVnqPFUsTCsrmUEW77z8VR9K9cecc9qcmu70pO32iK3nDPw4h6WDSSo21g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w0llZ-0000000G3bN-0qR7;
	Thu, 12 Mar 2026 20:32:17 +0100
Message-ID: <1cf0ae795b0e3e95b38cb7abf84ffad34c187fdf.camel@sipsolutions.net>
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
 <j@w1.fi>, Benjamin Berg <benjamin@sipsolutions.net>
Date: Thu, 12 Mar 2026 20:32:16 +0100
In-Reply-To: <c676b2cd73463fa88f459f0416c60b03f20dd027.camel@sipsolutions.net>
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
	 <c676b2cd73463fa88f459f0416c60b03f20dd027.camel@sipsolutions.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33155-lists,linux-wireless=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: E3CDB278217
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> > Because of this, an event-driven approach was considered.

So - starting this again from scratch. Benjamin and I spent some time
discussing this today too, and hashed out a (mostly?) workable solution
that should address most of the issues. I'll try to summarise that
below.

As will become obvious - and that's why I quoted only the line _you_
wrote before - this means we (including myself :)) need to stop being
afraid of hostapd doing (soft?) real-time [1] tasks...

[1] I'm using that word in the (formal) sense of having a deadline, not
of having to be particularly fast.


Let's assume the following constraints:

- preparing a beacon template as a real-time task can be done by
hostapd, given enough heads-up time
- no periodic events in a steady state when the AP is operating
normally
- TSF drift between links is correctly handled (maintaining <=3D30us
offset at any time)

We evidently already make these assumptions:

- if beacon intervals are not the same, the TBTT offset in RNR is
filled in by firmware (I see no way around this)
- either firmware fills in TSF offset, or it's just zero, and not
really accounting for slight drifts (but that's probably OK since it
never adds up given the <=3D30us requirement)

And also let's introduce some new operations to driver/firmware:

- the firmware can drop a frame that it's not able to transmit before
a given (as frame metadata) TSF value on the link, and indicate to
the driver that this is the reason the frame was dropped
- the firmware can create events at/after beacon TBTT (or beacon
transmission), this can be controlled by the driver; these events
contain the next TBTT's timestamp value
- the TSF offsets between links can be known to the driver, if they can
change (I suspect CSA could do that?) this can somehow be noticed by
or given to the driver

With that, it seems we can redesign this whole thing to be event-driven
and (mostly?) race-free.

In steady state, basically nothing would change from what hostapd is
doing today. It simply configures beacon templates, occasionally updates
them if elements need to change, and sends probe responses,
(re)association responses etc. as usual.

During any sort of update (CSA, color change, EHT updates, UHR updates)
things operate a bit differently:

1) hostapd enables TBTT / beacon transmit events, these events would be
generated by firmware and passed up, for each link, containing also the
TBTT timestamp of the _next_ beacon to be transmitted

2) hostapd waits for the TBTT event for the link that it wants to do the
update on, ignoring events for other links

3) starting from that TBTT event, on each TBTT event hostapd generates a
new beacon template for the link the event was for, and configures it to
the driver/firmware. Since that's a future beacon, it has to predict the
content of that beacon using
- the TBTT of the first beacon carrying the update announcement
- the TSF offsets between the links
- the beacon intervals of all the links
(a bit more on this later)

4) After applying the updates (a bit more on this later) and noticing
that the announcements are finished, hostapd waits for one more TBTT
event for each link and configures the beacons back to steady state,
after which it turns off the events.

If, at any time during this, hostapd needs to send a probe response,
(re)association response, EPP Capa/Operation response (or others?) which
holds information about the updates with the current counter values,
hostapd will create the frame per the current counters that it
maintains, and will transmit this frame with a TSF cut-off value
indicating that it must be transmitted before the next TBTT (over all
links), or dropped.
If this frame ends up being dropped by firmware because it didn't get
out before the indicated TSF, hostapd gets a specific notification for
this and then simply re-generates it and sends it again. This could
possibly repeat if TBTTs are close together on multiple links, but I
think it's not worth optimising for this case, though it could be done
by deferring the response slightly based on timers, or at the expense of
a more complex API ("defer until X and don't send after Y" vs. "don't
send after Y"), neither seems really worthwhile.


I said I'd give more information for (3) and (4) above, so:

For (3), also consider that it already has to effectively be able to do
this for the templates thing we discussed, it has to predict what each
link is going to look like in the future. I think this isn't too much of
an issue, but care must be taken especially if beacon intervals differ.

For (4), I think the way how the updates are done may depend on what the
update is. If, for example, it's DBE increasing the bandwidth, then
could just do the update _before_ the 0 beacon is transmitted, and if
it's decreasing bandwidth could do it _after_ the 0 beacon is
transmitted. Some of these may potentially require management by the
kernel or even driver/firmware (how do you switch NPCA parameters at the
exact right point if not in FW?), and perhaps (especially for CSA?)
there will be some considerations regarding multiple interfaces.
I mostly think this question is orthogonal, since armed with a TBTT
hostapd could also request that this update be done at a given TBTT.


We haven't really been able to poke significant holes into this, but
maybe that doesn't mean much. Couple of thoughts on that:

 * For each link, hostapd has roughly the whole beacon interval to build
   the next beacon's template, which seems reasonable.
 * There's a really weird corner case where an assoc response is
   attempted to transmit just before a beacon, doesn't get an ACK, but a
   retransmission isn't possible until after the beacon and it's dropped
   due to the TSF cut-off. Doesn't seem worth worrying about.
 * If the TBTTs for two links are at the same time, and the events to
   userspace for them are not coming "updated link first", then the
   beacon transmitted at the same time on the unchanged link may not yet
   be announcing the update, depending on the event order, given that
   hostapd waited for the affected link's first TBTT event. This doesn't
   really seem like a problem, but I think could be addressed by
   updating all the links on the first event immediately or so, or
   (Benjamin prefers this I think) adding the first beacon's TBTT to the
   response to the event enable command, I just worry that would cause
   other races that would need to be addressed.

That's it for now :) Let me know what you think.

johannes

