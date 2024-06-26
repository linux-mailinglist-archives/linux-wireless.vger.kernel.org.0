Return-Path: <linux-wireless+bounces-9594-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21065917C84
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 11:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D1C1F222E4
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 09:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29CF16A92E;
	Wed, 26 Jun 2024 09:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Avlwm4VS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA82F149C52
	for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2024 09:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719394137; cv=none; b=doSPY5rZ1+p9pwnlHBhPzHhrVee31UWc+KPx7lG+LFDnlOYD+Nowh/hY2UpuDv75pzNA+ImY4vcrG3DSRu4jeZXwEzUWRa6ekkrSycl9to9WMmtgBDcI7Rrim3sHMtuLVfREuBuDapzgoDI6J4fSnm4cb5Xa0Qdce1ppHCCJtDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719394137; c=relaxed/simple;
	bh=LBRvta6TItwzMypX39PNRPobVvc7vVs1NYiHDK9vHn4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C0MPvZgMdBCqim+AkFA/8ghEh4gk4cLn2n72WAR5SiS86yU3/skWP40AAYqEEUgs8uPVOVm8IMJ0M5Hw42nx2fLEec+0RU8nMtwsiLKx/748BRe+EWsYBR4kB/RwiyPD3LUWnmrgzedEe5OduMGkSn15GqYdIQ/ho3rDTE8kZck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Avlwm4VS; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DfH3DxQQqOcGWnkYEk10v9twsJDjb7U1edeOIS+nDsQ=;
	t=1719394134; x=1720603734; b=Avlwm4VSNs6UCfsvgqZRZflr3QFvNKGEcEo48yhYuRf5l1L
	9L3irWpaDciFtT1FtfaU0B0kRzhLzGFJXCadBVkwpjhL1gUiMPwmY88+QNT9x2U1fGS7MygDT7HML
	RqXW4zuynEbwIaWnpP9KTfVVGVpk0TD2Wlg3UU+chg0vSCg2MyGvlWZsPlFY2UnqxoDSZzmuK4fc4
	6Tv77HS9/1b+2A1R4JjBq+jRkCoUKyy/Sa4a2ITDzUzqQ4rnAvXJ2umjY+fq8DTAOULmqLmlNOmta
	xyRitZsXxl2pZg8ABFBeGjLi5gF+GYkb7F0m9lvdVHZsup9ZxUKNoZ/vq+ldGffQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sMOxP-000000033UB-1RuT;
	Wed, 26 Jun 2024 11:28:51 +0200
Message-ID: <84c53b0d02282c1d26a06b1c2946ed82d109bc3e.camel@sipsolutions.net>
Subject: Re: [RFC v2 1/2] wifi: cfg80211/mac80211: Introduce nl80211
 commands to support MLD link removal offload
From: Johannes Berg <johannes@sipsolutions.net>
To: Manish Dharanenthiran <quic_mdharane@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Rameshkumar Sundaram
	 <quic_ramess@quicinc.com>
Date: Wed, 26 Jun 2024 11:28:50 +0200
In-Reply-To: <20240404185950.776062-2-quic_mdharane@quicinc.com>
References: <20240404185950.776062-1-quic_mdharane@quicinc.com>
	 <20240404185950.776062-2-quic_mdharane@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-04-05 at 00:29 +0530, Manish Dharanenthiran wrote:
> This is a preparation for supporting Multi-Link reconfigure link removal
> procedure[IEEE P802.11be/D5.0 - 35.3.6.3 Removing affiliated APs] for
> driver which supports offloaded Multi-Link reconfigure link removal.
>=20
> Multi-Link reconfigure link removal offloaded drivers will take care of
> updating the reconfiguration MLE in self and partner beacons. It also
> updates the AP removal timer automatically and notifies once the counter
> is expired.

How do we distinguish those drivers from others that won't (be able to)
do this as we had discussed also for the CSA flows?

> +/**
> + * struct cfg80211_link_reconfig_removal_params - Contains params needed=
 for
> + * link reconfig removal

nit: maybe indent the second line with a tab? is that possible? it's a
bit confusing to go into the parameters right away without any visual
separation, IMHO.

> + * @link_removal_cntdown: TBTT countdown value until which the beacon wi=
th ML
> + *	reconfigure element will be sent.
> + * @reconfigure_elem: ML reconfigure element to be updated in beacon in =
the link going to be
> + *	removed and in all affiliated links.
> + * @elem_len: ML reconfigure element length
> + * @link_id: Link id of the link to be removed.
> + */
> +struct cfg80211_link_reconfig_removal_params {
> +	u16 link_removal_cntdown;
> +	const u8 *reconfigure_elem;
> +	size_t elem_len;
> +	unsigned int link_id;

nit: I guess the size of this doesn't really matter, but putting a
pointer after a u16 always feels wrong because it adds 6 bytes of
padding on 64-bit :)

> +/**
> + * cfg80211_update_link_reconfig_remove_update - Inform userspace about
> + *	the removal status of link which is scheduled for removal

here you did a tab btw :)

> + * This function is used to inform userspace about the ongoing link remo=
val
> + * status. 'NL80211_CMD_LINK_REMOVAL_STARTED' is issued when the first b=
eacon with

Please use %NL80211_CMD_LINK_REMOVAL_STARTED which would print it as a
constant, instead of '...'.

> + * ML reconfigure element is sent out. This event can be used by userspa=
ce to start
> + * the BTM in case of AP mode. And, NL80211_CMD_LINK_REMOVAL_COMPLETED i=
s issued

same here

> + * when the last beacon is sent with ML reconfigure element. This is use=
d to
> + * initiate the deletion of that link, also to trigger deauth/disassoc f=
or the
> + * associated peer(s).
> + *
> + * Note: This API is currently used by drivers which supports offloaded
> + * Multi-Link reconfigure link removal. Returns failure if FEATURE FLAG =
is not

"FEATURE FLAG" was ... some kind of placeholder?

Should this even return a value? What are you going to do with it?

You should also document the context this can be called in.


> + * @NL80211_ATTR_TSF: (u64) TSF value when the first beacon with reconfi=
guration
> + *	MLE is sent.

What's that needed for, btw?

> +++ b/net/wireless/nl80211.c
> @@ -826,6 +826,8 @@ static const struct nla_policy nl80211_policy[NUM_NL8=
0211_ATTR] =3D {
>  	[NL80211_ATTR_MLO_TTLM_DLINK] =3D NLA_POLICY_EXACT_LEN(sizeof(u16) * 8)=
,
>  	[NL80211_ATTR_MLO_TTLM_ULINK] =3D NLA_POLICY_EXACT_LEN(sizeof(u16) * 8)=
,
>  	[NL80211_ATTR_ASSOC_SPP_AMSDU] =3D { .type =3D NLA_FLAG },
> +	[NL80211_ATTR_AP_REMOVAL_COUNT] =3D { .type =3D NLA_U8 },

No range? I guess 0 might be an issue?

> +	[NL80211_ATTR_TSF] =3D { .type =3D NLA_U64 },

If the TSF is output only maybe it should not have a policy for input?

> @@ -16103,6 +16105,7 @@ static int nl80211_remove_link(struct sk_buff *sk=
b, struct genl_info *info)
>  	unsigned int link_id =3D nl80211_link_id(info->attrs);
>  	struct net_device *dev =3D info->user_ptr[1];
>  	struct wireless_dev *wdev =3D dev->ieee80211_ptr;
> +	struct cfg80211_link_reconfig_removal_params params =3D {};

that can move into the if

> @@ -16115,6 +16118,30 @@ static int nl80211_remove_link(struct sk_buff *s=
kb, struct genl_info *info)
>  		return -EINVAL;
>  	}
> =20
> +	if (info->attrs[NL80211_ATTR_AP_REMOVAL_COUNT]) {
> +		/* Parsing and sending information to driver about ML
> +		 * reconfiguration is supported only when
> +		 * NL80211_EXT_FEATURE_MLD_LINK_REMOVAL_OFFLOAD is set
> +		 */
> +		if (!wiphy_ext_feature_isset(wdev->wiphy,
> +					     NL80211_EXT_FEATURE_MLD_LINK_REMOVAL_OFFLOAD))
> +			return -EOPNOTSUPP;
> +
> +		/* If AP removal count is present, it is mandatory to have IE
> +		 * attribute as well, return error if not present
> +		 */
> +		if (!info->attrs[NL80211_ATTR_IE])
> +			return -EINVAL;
> +
> +		params.reconfigure_elem =3D nla_data(info->attrs[NL80211_ATTR_IE]);
> +		params.elem_len =3D nla_len(info->attrs[NL80211_ATTR_IE]);
> +		params.link_removal_cntdown =3D
> +			nla_get_u16(info->attrs[NL80211_ATTR_AP_REMOVAL_COUNT]);

doesn't match the policy ... but policy also doesn't match
documentation, so I think policy is wrong?

> +int
> +cfg80211_update_link_reconfig_remove_update(struct net_device *netdev,
> +					    unsigned int link_id,
> +					    u8 tbtt_count, u64 tsf,
> +					    enum nl80211_commands cmd)
> +{

[...]

> + nla_put_failure:
> +	genlmsg_cancel(msg, hdr);
> +	nlmsg_free(msg);

nit: no need to cancel before free

> +TRACE_EVENT(rdev_link_reconfig_remove,
> +	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
> +		 const struct cfg80211_link_reconfig_removal_params *params),
> +
> +	TP_ARGS(wiphy, netdev, params),
> +
> +	TP_STRUCT__entry(
> +		WIPHY_ENTRY
> +		NETDEV_ENTRY
> +		__field(u32, link_id)
> +		__field(u16, count)
> +		__dynamic_array(u8, frame, params->elem_len)
> +	),
> +
> +	TP_fast_assign(
> +		WIPHY_ASSIGN;
> +		NETDEV_ASSIGN;
> +		__entry->link_id =3D params->link_id;
> +		__entry->count =3D params->link_removal_cntdown;
> +		memcpy(__get_dynamic_array(frame), params->reconfigure_elem,
> +		       params->elem_len);
> +	),
> +
> +	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", link_id: %u frame:0x%.2x c=
ount:%d",
> +		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->link_id,
> +		  le16_to_cpup((__le16 *)__get_dynamic_array(frame)), __entry->count)

What's that frame argument?! Need to check it's long enough? But ... is
that worth it at all to try to print it here in this way? Maybe with
%*pH but then you don't get all of it either? Or just leave it, and
write a small plugin if needed?

> +int cfg80211_link_reconfig_remove(struct wireless_dev *wdev,
> +				  const struct cfg80211_link_reconfig_removal_params *params)
> +{
> +	struct cfg80211_registered_device *rdev =3D wiphy_to_rdev(wdev->wiphy);
> +
> +	lockdep_assert_wiphy(wdev->wiphy);
> +
> +	/* Currently, removal of link from MLD is supported for AP BSS only, it
> +	 * can be extended for non-AP/STA MLD as well but that shall use
> +	 * action frame to update about its link reconfiguration.
> +	 */
> +	if (wdev->iftype =3D=3D NL80211_IFTYPE_AP)
> +		return rdev_link_reconfig_remove(rdev, wdev->netdev, params);
> +
> +	return -EINVAL;


Would kind of feel to better be

 if (iftype !=3D ...) return -EINVAL;

 ... normal flow

johannes

