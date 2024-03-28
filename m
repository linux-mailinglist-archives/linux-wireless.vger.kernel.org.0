Return-Path: <linux-wireless+bounces-5486-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BF2890827
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 19:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274D91F22FAC
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 18:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D143BBCB;
	Thu, 28 Mar 2024 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="h5waia/+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BAC12F5B1
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 18:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711649939; cv=none; b=EycyTInjVotASTd5n1gdfBlGwU2sa0iKgi2HIBqOAosl2bxAZE0Yw9UFLSRcqIL25gxZYXi0uiOuwmSpo5YzN2j5eZLYUYhdhuTkX7Swhgr+LZtVAbm428LOt70v3DRC6VScrgo5AeAnKsWXiRv/WvCW2cZyElYqgSEri3khzsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711649939; c=relaxed/simple;
	bh=fUSezxDIskhv7oc8w5LyVwz6GvUL4Klb0fBb/kyLzKI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FYVSH2aOF6EJVa1UOgVD1NpHhCWQqHli8qsJaPK2eTp0YIMsMFYDLa+zqL+YiJINFyncQPhJ7gOjrsTHwvYInlpjNsmbVJxYwFbJ5Rm911eJtWG+qpZgLhzPt0Gd9HCD6AD9UndwGxgIXovYsKUO+r+XNL0HkALYuGGyBGVIqrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=h5waia/+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=TKywv8uJ/DaUr0QRXA30FACb0fpE5mFevkESgydMM6Y=;
	t=1711649936; x=1712859536; b=h5waia/+Ox6vY0cOBuiOKTfOXX29WiMr9Rxj5gVgtxZ7EEr
	GMt30FfBf5e3S7YLalD5y4dUUAjdYWPc3V069pY26wkWNGmuAkjtrsaHDJb0TSRU9r0rL6OLRQFJY
	lkKM0eB71zyqynfjQ+2vZs6b5iRkPqYKSBJpdNUOd4Mv5pY7mqXFNAIE1h+4S+/gwf70ndpC8xGwx
	wRO9lx2Kv0LUErWoY4IxGBE74RNiHLE5doCdqEGl1phj8YyiLh1Pp/boczBKMOYn5RNIvxgC2JZ56
	ama9Ntksi85l1C5IMc353y0zZ6C/wAFdfRRcDVwi19qJ47hMC8eb4uTn0XbGWGmw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpuKx-00000001DLm-3y8b;
	Thu, 28 Mar 2024 19:18:53 +0100
Message-ID: <5d723170644d147bebe8a1232fb7a20c3c6d41c7.camel@sipsolutions.net>
Subject: Re: [RFC 1/2] wifi: cfg80211/mac80211: Introduce nl80211 commands
 to support MLD link removal offload
From: Johannes Berg <johannes@sipsolutions.net>
To: Manish Dharanenthiran <quic_mdharane@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Rameshkumar Sundaram
	 <quic_ramess@quicinc.com>
Date: Thu, 28 Mar 2024 19:18:50 +0100
In-Reply-To: <20240328055235.3034174-2-quic_mdharane@quicinc.com>
References: <20240328055235.3034174-1-quic_mdharane@quicinc.com>
	 <20240328055235.3034174-2-quic_mdharane@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-03-28 at 11:22 +0530, Manish Dharanenthiran wrote:
>=20
> + * @ie: ML reconfigure IE to be updated in beacon in the link going to b=
e
> + *	removed and in all affiliated links.
> + * @ie_len: ML reconfigure IE length

Given the spec having moved away from "Information Element" in favour of
just "Element", I'd prefer to do the same in the code. Not that we
really want to rename all the "ie" stuff in the code now, but for new
code.

> + * @link_reconfig_remove: Notifies the driver about the link to be
> + *	scheduled for removal with ML reconfigure IE built for that particula=
r
> + *	link along with the TBTT count until which the beacon with ML
> + *	reconfigure IE should be sent.

Same here.

> +/**
> + * cfg80211_update_link_reconfig_remove_status - Inform userspace about
> + *	the removal status of link which is scheduled for removal
> + * @dev: the device on which the operation is requested
> + * @link_id: Link which is undergoing removal
> + * @tbtt_count: Current tbtt_count to be updated.
> + * @tsf: Beacon's timestamp value
> + * @status: Inform started or completed action to userspace based on the=
 value
> + *	received,
> + *	i) 0 (IEEE80211_LINK_RECONFIG_START) - Send
> + *		NL80211_CMD_LINK_REMOVAL_STARTED
> + *	ii) 1 (IEEE80211_LINK_RECONFIG_COMPLETE) - Send
> + *		NL80211_CMD_LINK_REMOVAL_COMPLETED

I wouldn't list the values "0" and "1"? They're really quite
unimportant.

Also we've sometimes used just the nl80211 cmd value as a parameter,
could do that here too instead of adding IEEE80211_LINK_RECONFIG_START
and IEEE80211_LINK_RECONFIG_COMPLETE?

> + * This function is used to inform userspace about the ongoing link remo=
val
> + * status. 'IEEE80211_LINK_RECONFIG_START' is issued when the first beac=
on with
> + * ML reconfigure IE is sent out. This event can be used by userspace to=
 start
> + * the BTM in case of AP mode. And, IEEE80211_LINK_RECONFIG_COMPLETE is =
issued
> + * when the last beacon is sent with ML reconfigure IE. This is used to
> + * initiate the deletion of that link, also to trigger deauth/disassoc f=
or the
> + * associated peer(s).

I'm not fully sure I understand this - the way I read it, userspace
actually request link removal with NL80211_CMD_REMOVE_LINK (at least
right now, will comment separately), why does it need an event too?

> + * Note: This API is currently used by drivers which supports offloaded
> + * Multi-Link reconfigure link removal. Returns failure if FEATURE FLAG =
is not
> + * set or success if NL message is sent.

What would be "non-offloaded ML reconfiguration link removal"? What does
offloaded even mean here? It's only counting down and then removing the
link, no? Isn't that fundamentally an operation that has to happen in
kernel or device space, since that's sending beacons? I don't see you'd
really want to time the updates to each beacon from userspace?

> +++ b/include/uapi/linux/nl80211.h
> @@ -1304,6 +1304,10 @@
>   * @NL80211_CMD_REMOVE_LINK: Remove a link from an interface. This may c=
ome
>   *	without %NL80211_ATTR_MLO_LINK_ID as an easy way to remove all links
>   *	in preparation for e.g. roaming to a regular (non-MLO) AP.
> + *	To initiate link removal procedure, set below attributes,
> + *	%NL80211_ATTR_AP_REMOVAL_COUNT - AP removal timer count(TBTT)
> + *	%NL80211_ATTR_IE - ML reconfigure Information element
> + *	Can be extended to update multiple TBTT & IE(s).

I'm wondering if this really is the right API? For example, older
kernels would ignore all the other attributes and immediately delete the
link, is that what you want? Seems you might want to at least _know_
about the availability of (graceful) link removal.

Also, if it should piggy-back on an existing API, maybe better would be
STOP_AP? That's the operation that normally stops beaconing, although if
you just delete the link the kernel does have to clean that up ...

Or maybe it should just be a whole new operation? You're already adding
new commands for the events anyway, could use _START (dropping the "ED")
for both a command and an event. Though see above, not sure why you need
the event anyway.

So just not sure about this, any arguments either way? I guess if it
were part of STOP_AP you'd expect the link to stay around and just be
inactive, and then require it to be removed by userspace with
NL80211_CMD_REMOVE_LINK after it stops, so perhaps in some way doing it
via NL80211_CMD_REMOVE_LINK makes more sense so it will actually be
removed entirely.

>   * @NL80211_CMD_ADD_LINK_STA: Add a link to an MLD station
>   * @NL80211_CMD_MODIFY_LINK_STA: Modify a link of an MLD station
> @@ -1329,6 +1333,14 @@
>   *      %NL80211_ATTR_MLO_TTLM_ULINK attributes are used to specify the
>   *      TID to Link mapping for downlink/uplink traffic.
>   *
> + * @NL80211_CMD_LINK_REMOVAL_STARTED: Once first beacon with reconfigura=
tion MLE
> + *	is sent, userspace is notified with the TBTT and TSF value to indicat=
e
> + *	timestamp of that beacon using %NL80211_ATTR_AP_REMOVAL_COUNT and
> + *	%NL80211_ATTR_TSF respectively.
> + *
> + * @NL80211_CMD_LINK_REMOVAL_COMPLETED: Once last beacon with reconfigur=
ation
> + *	MLE is sent, userspace is notified with completion.

We already have NL80211_CMD_LINKS_REMOVED for the station side of this,
maybe we should just reuse that event also here?

> + * @NL80211_ATTR_AP_REMOVAL_COUNT: (u16) TBTT count up-to which reconfig=
uration
> + *	MLE is sent. Also, userspace will be notified with this count once th=
e
> + *	first beacon with reconfiguration MLE is sent.

I'm not sure how that notification thing all makes sense when it's
something requested by userspace in the first place? Are you expecting
the underlying driver to actually _change_ it?

> + * @NL80211_ATTR_TSF: (u64) TSF value when the first beacon with reconfi=
guration
> + *	MLE is sent.

Why is that needed? But also the name is very generic, which I don't
mind, but perhaps then the documentation should reflect that this use is
when it's used with that event etc.

> + * @NL80211_EXT_FEATURE_MLD_LINK_REMOVAL_OFFLOAD: Driver/device which su=
pports
> + *	ML reconfig link removal offload.

Ah, I guess that addresses the whole "can the driver do it" part.

Though like I said above I'm not sure why you call this offloaded, I'm
not convinced you'd ever want to do it in a non-offloaded way?

> +	[NL80211_ATTR_TSF] =3D { .type =3D NLA_U64 },

Not sure that makes sense, it's not used for input?

>  	struct wireless_dev *wdev =3D dev->ieee80211_ptr;
> +	struct cfg80211_link_reconfig_removal_params params =3D {};
> +	bool is_ml_reconfig =3D false;
> +	int ret =3D 0;

You can remove ret, just=C2=A0rewrite the code below a bit better.

> +int
> +cfg80211_update_link_reconfig_remove_status(struct net_device *netdev,
> +					    unsigned int link_id,

I feel like this should check the link_id against valid_links?

> +					    u8 tbtt_count, u64 tsf,
> +					    enum ieee80211_link_reconfig_remove_state action)
> +{
> +	struct wiphy *wiphy =3D netdev->ieee80211_ptr->wiphy;
> +	struct cfg80211_registered_device *rdev =3D wiphy_to_rdev(wiphy);
> +	struct sk_buff *msg;
> +	void *hdr =3D NULL;
> +	int ret =3D 0;

Please read=20
https://staticthinking.wordpress.com/2024/02/28/return-0-is-better-than-ret=
urn-ret/

I really do agree with him a lot here :-)

So please don't init ret =3D 0, and "return 0" on the success path.

> +	/* Only for ML reconfigure link removal offloaded driver, need to
> +	 * update the status about the ongoing link removal to userspace.
> +	 */
> +	if (!wiphy_ext_feature_isset(wiphy,
> +				     NL80211_EXT_FEATURE_MLD_LINK_REMOVAL_OFFLOAD))
> +		return -EOPNOTSUPP;
> +
> +	trace_cfg80211_update_link_reconfig_remove_status(wiphy, netdev,
> +							  link_id, tbtt_count,
> +							  tsf, action);
> +
> +	msg =3D nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	if (action =3D=3D IEEE80211_LINK_RECONFIG_START)
> +		hdr =3D nl80211hdr_put(msg, 0, 0, 0, NL80211_CMD_LINK_REMOVAL_STARTED)=
;
> +	else if (action =3D=3D IEEE80211_LINK_RECONFIG_COMPLETE)
> +		hdr =3D nl80211hdr_put(msg, 0, 0, 0, NL80211_CMD_LINK_REMOVAL_COMPLETE=
D);

You can save this if you actually just have the driver pass the command
ID. However, seems like the function should update valid_links, just
like cfg80211_links_removed() does? Or maybe it should just become valid
to call cfg80211_links_removed() for AP interfaces in this context ...


> +	    nla_put_u8(msg, NL80211_ATTR_AP_REMOVAL_COUNT, tbtt_count) ||
> +	    nla_put_u64_64bit(msg, NL80211_ATTR_TSF, tsf,
> +			      NL80211_ATTR_PAD)) {

Those don't make sense after removal completed, so they shouldn't be
there. But again, perhaps that's just going to become
cfg80211_links_removed() anyway.

> + nla_put_failure:
> +	genlmsg_cancel(msg, hdr);

The cancel is pointless if you just free the message, and then you don't
need to initialize hdr=3DNULL either.

> +	nlmsg_free(msg);
>=20
> +TRACE_EVENT(rdev_link_reconfig_remove,
> +	    TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
> +		     const struct cfg80211_link_reconfig_removal_params *params),
> +
> +	TP_ARGS(wiphy, netdev, params),

That's pretty inconsistent indentation, I'd prefer to do it like the
other events, even if checkpatch complains a bit ...

> +	TP_STRUCT__entry(WIPHY_ENTRY
> +			 NETDEV_ENTRY
> +			 __field(u32, link_id)
> +			 __field(u16, count)
> +			 __dynamic_array(u8, frame, params->ie_len)
> +	),
> +
> +	TP_fast_assign(WIPHY_ASSIGN;
> +		       NETDEV_ASSIGN;
> +		       __entry->link_id =3D params->link_id;
> +		       __entry->count =3D params->link_removal_cntdown;
> +		       memcpy(__get_dynamic_array(frame), params->ie,
> +			      params->ie_len);
> +	),

Same here, this might make checkpatch happier, but honestly, I much
prefer the style that all the other events have ...

> +int cfg80211_link_reconfig_remove(struct wireless_dev *wdev,
> +				  const struct cfg80211_link_reconfig_removal_params *params)
> +{
> +	struct cfg80211_registered_device *rdev =3D wiphy_to_rdev(wdev->wiphy);
> +	int ret =3D -EINVAL;
> +
> +	lockdep_assert_wiphy(wdev->wiphy);
> +
> +	/* Currently, removal of link from MLD is supported for AP BSS only, it
> +	 * can be extended for non-AP/STA MLD as well but that shall use
> +	 * action frame to update about its link reconfiguration.
> +	 */
> +	if (wdev->iftype =3D=3D NL80211_IFTYPE_AP)
> +		ret =3D rdev_link_reconfig_remove(rdev, wdev->netdev, params);
> +
> +	return ret;

Oh come on, you don't even need the 'ret' variable.

johannes

