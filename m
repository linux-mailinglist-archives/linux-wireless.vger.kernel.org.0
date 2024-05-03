Return-Path: <linux-wireless+bounces-7134-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F81A8BA98A
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 11:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255432819DF
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 09:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AAE14E2CB;
	Fri,  3 May 2024 09:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Nd6aclZd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B9814F105
	for <linux-wireless@vger.kernel.org>; Fri,  3 May 2024 09:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727543; cv=none; b=GhiOvWp9q+AYwJBvVlkV0vica8B5RcpciAaSL9iRmNz1ZbORssd1x43lPgyvQaGNHQ26QHPwaOmL3Fzs/gvo7kQTjlWMONPkdYNQFtEI2Ux+q4WRfMkZP+S8vLdeJLnVZNh3Ir6mIv8hrLA+8qutes2HDQY+hzjKmrkLLhevQS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727543; c=relaxed/simple;
	bh=Z8CDLf0TYyrfyC6zPFzA311/iGV/zg3sDtFpbnD6h8E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OCEg4+edFw+3KNqFjlj1c43lDJHWjQWyDPmUGC6EPqmvZ8WfVjjt5g+qkozXSycuMiXTwDwQbXeO78vm1TQu3XQLx2k7Tt4tdyTHUvA58ii6x7f5+sWxf+DW5cVO+NgavMW3VL2CNdfNilCUziYijw6Hrz6DMe0uDf71QDzFFyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Nd6aclZd; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=IHkw1hW/pGSvVXjOIHBOZjZxJvvzS3Q0VXfvBtEJzic=;
	t=1714727540; x=1715937140; b=Nd6aclZd8h5B78TKii6/KkR4FHWjUugnPOdYMQRMVEgUg/O
	TOOMW+LHYDra52cx5Et0C+rp7ZrQ2j3d3U/K2LPZNAUK9YEao2r7Tthp9i4MRp7kv5I8+vfCq+Nl5
	uzg393QyEjvvSVSXHL1ycoFrT+IRpwczTDPJb2tOFjRsdRM2s9KiDpsaRo4GvDgfyQwtR3LI/SQNM
	6tLeL1HQAJtPTk2XJabiG7C/05xunzi0DRJf7I4PzG0/AmIkSKvCDBSR798LFgEdyyjoM5GLpjo9q
	r+iFb4+3L9M8mg4HGVrhBbIZNR1xiDfvBVuwu9xRsm2H5myLjdU9YswL5ejzPBGw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s2oxl-00000001ics-0cbu;
	Fri, 03 May 2024 11:12:17 +0200
Message-ID: <292247f4b838356b0c4e3ded2ff9fdbabd682040.camel@sipsolutions.net>
Subject: Re: [RFC v2 1/2] wifi: nl80211: Add attribute to send critical
 update parameters
From: Johannes Berg <johannes@sipsolutions.net>
To: Rathees Kumar R Chinannan <quic_rrchinan@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 03 May 2024 11:12:16 +0200
In-Reply-To: <20240403162225.3096228-2-quic_rrchinan@quicinc.com>
References: <20240403162225.3096228-1-quic_rrchinan@quicinc.com>
	 <20240403162225.3096228-2-quic_rrchinan@quicinc.com>
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

On Wed, 2024-04-03 at 21:52 +0530, Rathees Kumar R Chinannan wrote:
> Add NL80211_ATTR_RXMGMT_CRITICAL_UPDATE attribute to send critical
> update parameters to hostapd on NL80211_CMD_FRAME.
>=20
> User space application requires these CU params to update fields on probe
> and assoc response frame. So, during probe or assoc request frame receive=
,
> send these params as a new attribute on existing NL80211_CMD_FRAME for
> AP MLD.
>=20
> Change in CU parameters should be sent to user space either before or
> along with probe or assoc request frame receive to ensure that user space
> uses latest CU values and BPCC while generating response to the received
> frames. So, add the critical update parameters as a new attribute to
> existing NL80211_CMD_FRAME command instead of sending this on a separate
> NL80211 event.
>=20
> Based on the suggestion received on below link, add extended feature
> NL80211_EXT_FEATURE_CRITICAL_UPDATE_OFFLOAD flag if driver handles
> synchronization among all the links and update critical information on
> partner link beacon for AP MLD and user space can update critical
> information only on impacted link beacon template. Add this critical
> update attribute on NL80211_CMD_FRAME only when this flag is set
> by driver.
>=20
> Link: https://lore.kernel.org/all/df711a5978b84856a54953a32e4b05923b48870=
a.camel@sipsolutions.net/

I'm not sure we're interpreting this the same way ;-)

At least now that I'm reading it again, I was thinking in that thread
about how beacons on partner links are updated. That whole thread was
about handling that?

> Suggested-by: Johannes Berg <johannes@sipsolutions.net>
> Signed-off-by: Rathees Kumar R Chinannan <quic_rrchinan@quicinc.com>
> ---
>  include/net/cfg80211.h       |  10 +++
>  include/uapi/linux/nl80211.h | 104 +++++++++++++++++++++++++++++
>  net/wireless/nl80211.c       | 123 ++++++++++++++++++++++++++++++++++-
>  3 files changed, 236 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 2e2be4fd2bb6..496a9d4956de 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -6142,7 +6142,11 @@ void wiphy_delayed_work_flush(struct wiphy *wiphy,
>   *	unprotected beacon report
>   * @links: array of %IEEE80211_MLD_MAX_NUM_LINKS elements containing @ad=
dr
>   *	@ap and @client for each link
> + * @links.ap.bpcc: Bss param change count value for each link

BSS

> + * @links.ap.switch_count: CSA/BCCA count for each link

Had to think about BCCA a bit too much ... maybe explain it? :)

Also can someone actually be trying to do channel switch and color
change at the same time?

> + * @links.ap.critical_flag: Critical update flag for each link
>   * @valid_links: bitmap describing what elements of @links are valid
> + * @critical_update: critical params updated on any wdev link

Why have two critical indications? And they're even named differently?
I'd probably rename the inner to 'critical_update' and remove the outer,
it's easy to loop over (valid) links?

>  static inline const u8 *wdev_address(struct wireless_dev *wdev)
> @@ -8340,6 +8348,7 @@ void cfg80211_conn_failed(struct net_device *dev, c=
onst u8 *mac_addr,
>   * @flags: flags, as defined in &enum nl80211_rxmgmt_flags
>   * @rx_tstamp: Hardware timestamp of frame RX in nanoseconds
>   * @ack_tstamp: Hardware timestamp of ack TX in nanoseconds
> + * @critical_update: critical params updated for the received frame
>   */
>  struct cfg80211_rx_info {
>  	int freq;
> @@ -8351,6 +8360,7 @@ struct cfg80211_rx_info {
>  	u32 flags;
>  	u64 rx_tstamp;
>  	u64 ack_tstamp;
> +	bool critical_update;

Not sure what this means?

> + * @NL80211_ATTR_RXMGMT_CRITICAL_UPDATE: This is a nested attribute for =
driver
> + *	supporting critical update feature for AP MLD. When used with
> + *	%NL80211_CMD_FRAME it contains attribute defined in &enum nl80211_cu_=
attrs
> + *	to send critical update params for list of MLDs. Driver adds this att=
ribute
> + *	only for probe, assoc and reassoc request frame. User-space can use t=
hese
> + *	params to update CU fields on corresponding response frame. This attr=
ibute
> + *	is needed only on beacon offload case and it is not needed on beacon
> + *	non-offload case since user space itself has these data.

The wording of "beacon offload" vs. "beacon non-offload" seems, at best,
imprecise? This should be about offloading partner link updates, or
something like that?

Also I find this API a bit confusing, why is this sent in an RX frame
notification, which is stateless today, but you only send it once on the
first RX notification after it was set. Is that some kind of
optimisation?

I'd think it would make more sense to send a separate notification of
the data, and then you don't even need to store the data in the wdev.

Maybe then if we find out that it updates too frequently, we can defer
that separate notification (e.g. create the SKB for it, store a pointer
to that, and send it only on the first frame RX).

> @@ -3401,6 +3410,7 @@ enum nl80211_attrs {
> =20
>  	NL80211_ATTR_ASSOC_SPP_AMSDU,
> =20
> +	NL80211_ATTR_RXMGMT_CRITICAL_UPDATE,
>  	/* add attributes here, update the policy in nl80211.c */

nit: blank line

> + * @NL80211_EXT_FEATURE_CRITICAL_UPDATE_OFFLOAD: User space sets critica=
l
> + *	information only on impacted link through @NL80211_CMD_SET_BEACON.
> + *	Driver/Device handles synchronization among all the links and update
> + *	critical information on partner link beacon in case of MLD.

That's not really _quite_ what this implies today.

I mean, yeah, that's the idea, but you're actually using it for
something else. I don't even mind, but maybe it'd make sense to put this
into a separate patch, that starts building out the infrastructure for
handling all of this, simply with this for starters to say "not needed
in this case"?

(I think maybe I'm missing the broader picture a bit in these patches)

> +/*
> + * Critical update attribute length for a MLD list with two nested
> + * attributes. Each nla_nest_start() reserves four bytes.
> + */
> +#define NL80211_CU_ATTR_MLDS_LEN	8
...
> +#define NL80211_CU_ATTR_MLD_LEN		16
...
> +#define NL80211_CU_ATTR_LINK_LEN	32

Please don't do that, use nla_attr_size() or something?

But maybe anyway we can find a better representation.

> +/**
> + * nl80211_cu_attrs - critical update attributes
> + *
> + *

nit: double blank line

> + * @__NL80211_CU_ATTR_INVALID: invalid
> + * @NL80211_CU_ATTR_MLDS: nested attribute specifying list of MLDs,
> + * see &enum nl80211_cu_mld_attrs
> + * @__NL80211_CU_ATTR_LAST: internal use
> + * @NL80211_CU_ATTR_MAX: maximum critical update attribute
> + */
> +enum nl80211_cu_attrs {
> +	__NL80211_CU_ATTR_INVALID,
> +
> +	NL80211_CU_ATTR_MLDS,
> +
> +	/* keep last */
> +	__NL80211_CU_ATTR_LAST,
> +	NL80211_CU_ATTR_MAX =3D __NL80211_CU_ATTR_LAST - 1
> +};

But I'm not sure why you need this level anyway?

Why would you need to represent multiple MLDs for a single interface?
You've tagged it to RX (see above for comments on that) but that's per
interface anyway, so certainly per MLD?

> +++ b/net/wireless/nl80211.c
> @@ -468,6 +468,25 @@ static const struct netlink_range_validation nl80211=
_punct_bitmap_range =3D {
>  	.max =3D 0xffff,
>  };
> =20
> +static const struct nla_policy
> +link_policy[NL80211_CU_MLD_LINK_ATTR_MAX + 1] =3D {
> +	[NL80211_CU_MLD_LINK_ATTR_ID] =3D { .type =3D NLA_U8 },
> +	[NL80211_CU_MLD_LINK_ATTR_CRITICAL_FLAG] =3D { .type =3D NLA_FLAG },
> +	[NL80211_CU_MLD_LINK_ATTR_BPCC] =3D { .type =3D NLA_U8 },
> +	[NL80211_CU_MLD_LINK_ATTR_SWITCH_COUNT] =3D { .type =3D NLA_U8 },
> +};
> +
> +static const struct nla_policy
> +mld_policy[NL80211_CU_MLD_ATTR_MAX + 1] =3D {
> +	[NL80211_CU_MLD_ATTR_IFINDEX] =3D { .type =3D NLA_U32 },
> +	[NL80211_CU_MLD_ATTR_LINKS] =3D NLA_POLICY_NESTED(link_policy),
> +};
> +
> +static const struct nla_policy
> +cu_policy[NL80211_CU_ATTR_MAX + 1] =3D {
> +	[NL80211_CU_ATTR_MLDS] =3D NLA_POLICY_NESTED(mld_policy),
> +};
> +
>  static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] =3D {
>  	[0] =3D { .strict_start_type =3D NL80211_ATTR_HE_OBSS_PD },
>  	[NL80211_ATTR_WIPHY] =3D { .type =3D NLA_U32 },
> @@ -826,6 +845,7 @@ static const struct nla_policy nl80211_policy[NUM_NL8=
0211_ATTR] =3D {
>  	[NL80211_ATTR_MLO_TTLM_DLINK] =3D NLA_POLICY_EXACT_LEN(sizeof(u16) * 8)=
,
>  	[NL80211_ATTR_MLO_TTLM_ULINK] =3D NLA_POLICY_EXACT_LEN(sizeof(u16) * 8)=
,
>  	[NL80211_ATTR_ASSOC_SPP_AMSDU] =3D { .type =3D NLA_FLAG },
> +	[NL80211_ATTR_RXMGMT_CRITICAL_UPDATE] =3D NLA_POLICY_NESTED(cu_policy),

All of these are outgoing though, so probably shouldn't even have a
policy (which implies NLA_REJECT, i.e. not used incoming)?

> -	msg =3D nlmsg_new(100 + info->len, gfp);
> +	if (wiphy_ext_feature_isset(
> +		    wdev->wiphy,
> +		    NL80211_EXT_FEATURE_CRITICAL_UPDATE_OFFLOAD) &&
> +	    info->critical_update)

I don't even see how the flag check is needed here, since it relies on
the driver setting info->critical_update?

johannes

