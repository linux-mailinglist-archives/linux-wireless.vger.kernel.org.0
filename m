Return-Path: <linux-wireless+bounces-511-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68447807A45
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 22:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E05FFB21032
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 21:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72066F626;
	Wed,  6 Dec 2023 21:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="uUv8xPkf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8307D5B
	for <linux-wireless@vger.kernel.org>; Wed,  6 Dec 2023 13:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hQDt/mCiqHwxmsk920LwKsAfseHmxHfQq29gSIXxa7M=;
	t=1701897735; x=1703107335; b=uUv8xPkfYUYLcP2vX5ucJMbxd1navNYdF9/IsAM7RsaJKHN
	T69f3pP/yjIunzsfIy+BWPMH++f0viBwBUZXnACHcPzlNfnwAZpmn2o3fzj3QKWk7fmraZG5Hc1ui
	9pUam5xnvDB3CDnJndA0ENNoRt2TltXh+R875g2Rn7Hg9BoOhJ/zcl3OF7VDqmftutYs2cN5hwm0K
	xIlFPIEhnU2rbbQzj+EFRXWAAFECIkjya/V7AP87XX//pJOHmnU8uqVxyaGeXe6FdvocI58vtOYz3
	T1xPR6elR5HIiIBOeWProZXyuqW8bGdGdprWw0HOKDCY7WyONc8+yFFrnDDhjdKQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rAzLQ-00000000IhK-43iT;
	Wed, 06 Dec 2023 22:22:13 +0100
Message-ID: <33245ce2d2842d115003f183b0441822733a5447.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: don't drop all unprotected public
 action frames
From: Johannes Berg <johannes@sipsolutions.net>
To: Jouni Malinen <j@w1.fi>, gregory.greenman@intel.com
Cc: linux-wireless@vger.kernel.org, Avraham Stern <avraham.stern@intel.com>
Date: Wed, 06 Dec 2023 22:22:12 +0100
In-Reply-To: <ZWsU8T2c9GHQUsE9@w1.fi>
References: 
	<20231016145213.2973e3c8d3bb.I6198b8d3b04cf4a97b06660d346caec3032f232a@changeid>
	 <ZWsU8T2c9GHQUsE9@w1.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sat, 2023-12-02 at 13:28 +0200, Jouni Malinen wrote:
>=20
> But this comment and the function name feel quite misleading. This does
> not return true if the skb contains a Protected Dual of Public Action
> frame; this returns true if the skb contains a Public Action frame for
> which a Protected Dual of Public Action frame is defined. Or well, that
> is what this function should do for the mac80211 change to work
> correctly, but it does not really do that..
>=20
> > +static inline bool
> > +ieee80211_is_protected_dual_of_public_action(struct sk_buff *skb)
> > +{
> > +	u8 action;
> > +
> > +	if (!ieee80211_is_public_action((void *)skb->data, skb->len) ||
> > +	    skb->len < IEEE80211_MIN_ACTION_SIZE + 1)
> > +		return false;
> > +
> > +	action =3D *(u8 *)(skb->data + IEEE80211_MIN_ACTION_SIZE);
> > +
> > +	return action !=3D WLAN_PUB_ACTION_20_40_BSS_COEX &&
> > +		action !=3D WLAN_PUB_ACTION_DSE_REG_LOC_ANN &&
> > +		action !=3D WLAN_PUB_ACTION_MSMT_PILOT &&
> > +		action !=3D WLAN_PUB_ACTION_TDLS_DISCOVER_RES &&
> > +		action !=3D WLAN_PUB_ACTION_LOC_TRACK_NOTI &&
> > +		action !=3D WLAN_PUB_ACTION_FTM_REQUEST &&
> > +		action !=3D WLAN_PUB_ACTION_FTM_RESPONSE &&
> > +		action !=3D WLAN_PUB_ACTION_FILS_DISCOVERY;
> > +}
>=20
> What is this list of Public Action frames based on? The "Reserved" rows
> of the Protected Dual of Public Action frames from some snapshot of the
> IEEE 802.11 standard?

I guess?

We actually went back and forth on this a bit, Avi wrote it to be
similar to _ieee80211_is_robust_mgmt_frame() which has a list of "known
not to be robust".

> That is neither robust nor correct way of doing this.
> It would be more robust (in a sense of not breaking things in
> future) to make this match against cases for which there is a known
> protected variant instead of assuming that there is a protected variant
> for everything that is known to not have one yet defined.

Right, it would work both ways. But then the argument was that we've
basically done the same for _ieee80211_is_robust_mgmt_frame() and
decided that we'd rather treat them as robust if we don't know? Maybe
this case is more likely to define something new that's not, since it's
about public action frames? OTOH, it's OK anyway if they're not
exchanged within an existing connection.

> Furthermore, this is completely wrong for Vendor Specific Public Action
> frames. There is a Protected Vendor Specific value for Protected Dual of
> Public Action frame, but that value is used on case by case basis for
> each different type of vendor specific frame. In other words, this part
> would need to look at the OUI:subtype combination to search which vendor
> specific cases have a protected variant. I'd expect there to be a very
> limited, if any, such cases, i.e., more or less all vendor specific
> Public Action frames should be allowed to be processed in mac80211 even
> when MFP has been negotiated for an association.

Agree, that'd be up to the implementation to figure out whether it wants
that or not. The kernel doesn't process them anyway, and should
hopefully give you enough information out to userspace to see if they
were protected or not.

So certainly adding WLAN_PUB_ACTION_VENDOR_SPECIFIC here makes sense.


> In practice, this patch (well, a commit in wireless-next.git now) leaves
> Vendor Specific Public Action frame cases broken. For example, DPP does
> not work correctly with this. hostap.git test case
> dpp_conn_status_success_hostapd_configurator can demonstrate that issue.

Which would fix that.

> In addition, this would break more recently added Public Action frames
> with Action field values larger than 34 broken. There are quite a few
> such frames defined and none of them seem to have a matching protected
> dual.

DCS is for (E?)DMG which ... we don't support well, let's say? The next
ones also don't seem like we'd support them (don't even know where 1.08
GHz channels are used.) Agree that On-channel Tunnel request should be
included here.

But this similarly applies to _ieee80211_is_robust_mgmt_frame(), and we
haven't even added HE to that list yet.

So it's always going to be a case where the list is necessarily wrong in
the face of future enhancements. Perhaps the kernel should not care
about it for frames that it doesn't know about (and will therefore not
process), but then arguably both of the functions should list out the
frames that *are* robust and have protected dual respectively, rather
than that are not robust and don't have protected dual, I'd think?

johannes

