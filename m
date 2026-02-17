Return-Path: <linux-wireless+bounces-31923-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sA/rDp49lGmTAwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31923-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 11:06:22 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEC214AAD9
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 11:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1105030166CF
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 10:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950FE2DAFBB;
	Tue, 17 Feb 2026 10:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ov5Cgs4+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114772E6CCD
	for <linux-wireless@vger.kernel.org>; Tue, 17 Feb 2026 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771322743; cv=none; b=Zf+oEdhT8dyaJawTp2/V6oOfeHpq7SWJozMEyWFP9tM3KyOG254O9QYBcpYZ4IRF8iV8K6QpWViHCM8BtoSs26Me70LXz4CZeIiujO3Lzsp0dboRLR33HMHBGgds1WhR6AI9EtX9FMQsSKDvNa9Qxk/Ntp0Ogq7UYdjwQH4gKLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771322743; c=relaxed/simple;
	bh=gkRSfsM0whc7lKJ5JqMcE1q46JWCEz/MWOkJW6XJTwM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hse6R2Mp0PzN2zwC2bbDwSMu3qbxT066sji41WDdZZyd2kt6YLMir6S8QFIPy3uFf7gkRtjq7/1wsPPGjrJuhv8WzDrdUaW1p7+Ko1IpG3C/evSXFmD0z986KiQXEK5F8rH1uFLPf3tay/EuMVVu0z7bTjXTXJa3FKuFkW1Cycg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ov5Cgs4+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=IxTlxrlVqxNJfOH2NwUf+neTFHlV4g3ByZDBv0JUBx0=;
	t=1771322742; x=1772532342; b=ov5Cgs4+fIBAy4T0mmdkgLb/HwzncV+Rd+Nij+qzb1BNAoO
	Y8wP2fpGD4C29xNOhxbz7D2cMQawMGs3u+rUGjNoOm9x5N2+bluvdLTaSveJzlaAT+srBikCWwqS7
	gmvnIhC8ej1qRCGQOAD4Ihsr9n2DvbJZECQjgWLmbK9Qs7rVvniXMEv7ddd2ggo6pJSizHUhqquY4
	dPZu3vxxdiYjhP0iXmtEq8faYQZarpYh/BNH39/JSP05sxjRyRzAnMY58pLA3s0H7xBAormvlJdfT
	knSFhb5sm7b7FHTH/JOzj+qifc+RKC74CH3sSNhvSGdPPqmlCyNc1bdd/ho0DBOg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vsHxP-0000000BKWE-2mTs;
	Tue, 17 Feb 2026 11:05:29 +0100
Message-ID: <0f4b34f0b529fd93fc608d8bbac0e98516b7a3d2.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v8 2/3] wifi: cfg80211: add initial UHR
 support
From: Johannes Berg <johannes@sipsolutions.net>
To: Harshitha Prem <harshitha.prem@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org
Cc: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>, 
	vasanthakumar.thiagarajan@oss.qualcomm.com, Lorenzo Bianconi
 <lorenzo@kernel.org>, 	ath12k@lists.infradead.org, Jeff Johnson
 <jeff.johnson@oss.qualcomm.com>,  Ping-Ke Shih <pkshih@realtek.com>
Date: Tue, 17 Feb 2026 11:05:25 +0100
In-Reply-To: <156d6d48-d135-4acf-a5d7-c9ae80523864@oss.qualcomm.com>
References: <20260130154259.265130-5-johannes@sipsolutions.net>
	 <20260130164259.54cc12fbb307.I26126bebd83c7ab17e99827489f946ceabb3521f@changeid>
	 <f96125eeda23451c19067359eb9d10b4047bcdd3.camel@sipsolutions.net>
	 <5d54feea-d0cd-4bd7-b0d2-02e42f0fe5e1@oss.qualcomm.com>
	 <be9ab3c7f05b0f56f19aee0ffc7c2f96138b9a05.camel@sipsolutions.net>
	 <156d6d48-d135-4acf-a5d7-c9ae80523864@oss.qualcomm.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31923-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AEEC214AAD9
X-Rspamd-Action: no action

Hi,

> This approach looks well suited to handling overlapping update scenarios.
>=20
> To make sure I understand it correctly, I=E2=80=99d like to walk through =
a
> concise example where a UHR critical update and a CSA overlap on link 0
> of a 3=E2=80=91link AP MLD.

Well, so honestly, you should probably treat what I write as equivalent
to a paper napkin sketch during a night of drinking ;-)

I surely didn't think it totally through. I was just trying to
illustrate that I feel like we need to have some kind of new design for
all these overlapping updates (CSA, BSS color change, EHT and UHR
critical updates?) than the piecemeal design we have now.

And, importantly, that perhaps I think that this means we need to have
"post-update UHR operation" more than the individual UHR operation
updates broken out - which after all is where we started from.


> t1: A UHR critical update is triggered. hostapd sends
> NL80211_CMD_START_MLD_BSS_UPDATE with an advanced notification (5
> TBTTs), post=E2=80=91interval (5 TBTTs), and the beacon template with UHR
> parameters update element for link 0. Timers start in mac80211, and
> hostapd receives cookie X.

Don't know if timers would be really in mac80211 - I guess if the driver
pulls each individual beacon then mac80211 could handle the countdown,
but otherwise this might just be given to firmware.

Also I guess the counter would have offset(s) from the start, i.e. the
beacon template would be in this operation already. Or maybe even beacon
updates for multiple links? Don't know if that really matters much
either way.

> t2: hostapd sends NL80211_CMD_UPDATE_AP with cookie X and offset where
> the counter is updated for link 1 (and then link 2).
>=20
> the countdown values would be handled in mac80211 with the offset
> mentioned similar to ieee80211_set_beacon_cntdwn().

Sort of, yeah. I imagined that the CMD_UPDATE_AP would come with a list
of "cookie X: { offset X_1, offset X_2 }, cookie Y: { offset Y_1 }" or
something like that.

> t3: Before the UHR advanced interval completes, a CSA is triggered (due
> to radar or user=E2=80=91initiated). Another NL80211_CMD_START_MLD_BSS_UP=
DATE is
> issued with CSA countdown 5, including CSA and after beacon templates.
> The after template carries cookie X and the offset. Since UHR CU is
> already in progress, hostapd could also include an updated parameters
> update element.=C2=A0

Would have to, I think? I think in your example it's unlikely the _after
CSA_ template still has cookie X / offset(s) X_n, since you only had 10
beacon intervals overall for the UHR critical update and CSA might be
longer, but we could also imagine the UHR critical update was advertised
for a longer time.

> Also, an updated UHR operation element which can be
> modified in after beacon template if CSA finishes after the UHR CU
> advance interval. (why to provide the UHR operation element separately
> is because the advance notification can be before or after the CSA
> finalize).
> hostapd then receives cookie Y for the CSA.

This could get trickier than I imagined - you now have three periods of
time:

 - now
 - after CSA but before UHR update
 - after UHR update

and actually all three might need different UHR operation, since the CSA
can change the bandwidth and therefore e.g. DBE/NPCA. The intermediate
period ("after CSA but before UHR update") can be captured by the CSA
operation (given a template/UHR operation for after) easily.

But I was imagining we capture all this in the operations already, so I
guess to do that we would need a "NL80211_CMD_MODIFY_MLD_BSS_UPDATE"
command that takes the cookie and updates the post-operation values, so
that the changes due to the CSA could be taken into account in the
previously started UHR update.

FWIW, I was also kind of imagining that we'd design this combined update
command in a way that it replaces the CSA and color change commands,
handles the proposed link removal thing from Lorenzo, and then we don't
need to handle overlapping operations of all kinds, just of this new
kind that can do many different things. Not a huge difference though
since CSA/CCA would map to a subset of the new "thing".


> t4: hostapd issues NL80211_CMD_UPDATE_AP for link 1 with cookie X (UHR
> offset) and cookie Y (CSA offset), followed by link 2.

Not sure really about this. You also need new beacon templates for the
two periods I mentioned above ("after CSA but before UHR update" and
"after UHR update").


I think in my head the beacon templates for post-operations for all
links would've been handle by NL80211_CMD_START_MLD_BSS_UPDATE and, as I
discovered above, NL80211_CMD_MODIFY_MLD_BSS_UPDATE, rather than by
NL80211_CMD_UPDATE_AP.

I was, however, imagining that updates to the *current* template could
still happen via NL80211_CMD_UPDATE_AP, so - let's build a side branch
here first, e.g.:

      - we start UHR update to happen in 10 beacon intervals
        - this comes with a post-update template and post-update UHR operat=
ion
      - something else happens, e.g. HT mixed mode needs updating
        in this case, NL80211_CMD_UPDATE_AP could happen with the cookie(s)
        and offset(s) for the _current_ beacon
     =20
      Although I think perhaps this ends up being racy, and in fact hostapd
      would need to use a hypothetical NL80211_CMD_MODIFY_MLD_BSS_UPDATE ag=
ain
      to update the link's beacon for HT mixed mode for all of the ongoing =
BSS
      updates and their post beacon(s)?

Anyway, back to your scenario:

> t5: When the UHR advanced notification interval expires, the CSA after
> beacon template is updated to reflect the new operation element by
> mac80211 or getting it from hostapd.

Yeah so that's also an option, if we think it'd work / not be too racy?
As I wrote, I was thinking CSA becomes another MLD BSS update and then
the post-CSA template is already given there.

> t6: Once the CSA completes, the driver updates the after beacon template
> along with updated counter for UHR parameter update element. (since it
> will be in the post notification interval)
>=20
>=20
> t7: When the UHR post=E2=80=91interval completes, the UHR parameter updat=
e
> element is removed. Since offsets are known, the driver can remove it
> from the latest beacon template.

I wasn't really imagining the driver would remove it I guess, but rather
a post-update template would be provided already.

Ah! I think you were maybe thinking "this is the offset where to
insert/remove the UHR Parameter Update element", and I was thinking
"this is the offset of the counter" so that we could also put it into
the RNR etc.?

> Please let me know if this sequence aligns with the intended behavior,
> or if I=E2=80=99m missing any edge cases.
>=20
> Also, CSA during NPCA parameter update seems very tricky as the channel
> information advertised in NPCA may not be relevant when there is a CSA,
> perhaps stop the NPCA CU (still spec has not mentioned any details on
> the abort scenario though)

Right, it's a bit tricky all over for concurrency scenarios. I hear that
two UHR critical updates concurrently are not going to be allowed
though.

> Even, in case of link removal during UHR CU update, we need to stop the
> UHR CU.

Well if the link is removed then it probably isn't relevant to update it
any more anyway?

> Furthermore, the UHR capabilities carries the advance notification
> interval, post notification  (i guess yet to be added in element as I
> see it in "37-8=E2=80=94Enhanced Critical Updates Mechanism") and update
> indication in TIM interval, these intervals can be sent in the START_AP.
> I assume, these intervals cannot be modified dynamically as these are
> exchanged in assoc response (Will reconfirm again).

Yeah, I agree, I would tend to think these are fixed.

> For beacon offloaded drivers, NL80211_CMD_START_MLD_BSS_UPDATE can be as
> a trigger. May be we can add the updated UHR operation element in case
> of UHR. So, that firmware/driver handle the timers as well as
> constructing the elements since "the encoding of fields in Mode specific
> parameters for any feature say DPS/NPCA/DBE etc.. is same as the
> corresponding field in operation parameters field for that feature" (but
> i see bit variations for NPCA between both)

The bit variants are going to get fixed, it's just not entirely clear
yet which way around.


> I guess, this means the proposal of having a separate netlink attribute
> for the UHR operation with _full_ data like is much useful.

OK. We can always also just parse it out anyway, just that element
(contents) isn't really too difficult to get at.

> Still, we are thinking through on all the other cases of wifi-7/CCA etc..

Of course.

Thanks,
johannes

