Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49AC3450593
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Nov 2021 14:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhKONiK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Nov 2021 08:38:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:50192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236264AbhKONgz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Nov 2021 08:36:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C5E761130;
        Mon, 15 Nov 2021 13:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636983240;
        bh=C+WixI5YrFrABUfZutRALMi64eZYp8i4DNKlYKLDQKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QGG0zp6JfcSHd0XJFc8CubxgZokoQgh4hUKLwSVOV9HE6BwM/+RuVH54ngNW/0AnC
         MArOsvf1a0mTzYe6wIPfw8E6yjADNb+Bi3QACKMfyQaezYrsJE6BD169ax3ByOm0Pd
         VPb4G2OVqI8DhPtdy4NIls5BEA9CQIFCCTCufhS8zZL3ZuL73qe0cCa5hm06Szvhqx
         uw5jnYfBfD5FaSUOE6UmkiYJdq09kkcF3S5Dp5Ii8VAOE+Id2qo5RqP+Sh3wzgtPAa
         Lt6cY4nv30msd9yiXlJlcrM9L5sc0K4UKVTmvqx4fATAdUtvVzPHC+RAPcC3vZ4yLL
         uTLNWlPHHOUxA==
Date:   Mon, 15 Nov 2021 14:33:56 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: [PATCH] mac80211: add support for .ndo_fill_forward_path
Message-ID: <YZJhxKm5Yd/5YpqZ@lore-desk>
References: <20211112112223.1209-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z3GEtWHhO0qoKk9L"
Content-Disposition: inline
In-Reply-To: <20211112112223.1209-1-nbd@nbd.name>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--z3GEtWHhO0qoKk9L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This allows drivers to provide a destination device + info for flow offlo=
ad
> Only supported in combination with 802.3 encap offload
>=20
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  include/net/mac80211.h     |  7 +++++
>  net/mac80211/driver-ops.h  | 22 ++++++++++++++
>  net/mac80211/ieee80211_i.h |  2 +-
>  net/mac80211/iface.c       | 61 ++++++++++++++++++++++++++++++++++++++
>  net/mac80211/trace.h       |  7 +++++
>  5 files changed, 98 insertions(+), 1 deletion(-)

Tested-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index 775dbb982654..10e6fe215f0f 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -3952,6 +3952,8 @@ struct ieee80211_prep_tx_info {
>   *	radar channel.
>   *	The caller is expected to set chandef pointer to NULL in order to
>   *	disable offchannel CAC/radar detection.
> + * @net_fill_forward_path: Called from .ndo_fill_forward_path in order to
> + *	resolve a path for hardware flow offloading
>   */
>  struct ieee80211_ops {
>  	void (*tx)(struct ieee80211_hw *hw,
> @@ -4282,6 +4284,11 @@ struct ieee80211_ops {
>  				     struct ieee80211_sta *sta, u8 flowid);
>  	int (*set_radar_offchan)(struct ieee80211_hw *hw,
>  				 struct cfg80211_chan_def *chandef);
> +	int (*net_fill_forward_path)(struct ieee80211_hw *hw,
> +				     struct ieee80211_vif *vif,
> +				     struct ieee80211_sta *sta,
> +				     struct net_device_path_ctx *ctx,
> +				     struct net_device_path *path);
>  };
> =20
>  /**
> diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
> index cd3731cbf6c6..50a0cdadceec 100644
> --- a/net/mac80211/driver-ops.h
> +++ b/net/mac80211/driver-ops.h
> @@ -1483,4 +1483,26 @@ static inline void drv_twt_teardown_request(struct=
 ieee80211_local *local,
>  	trace_drv_return_void(local);
>  }
> =20
> +static inline int drv_net_fill_forward_path(struct ieee80211_local *loca=
l,
> +					    struct ieee80211_sub_if_data *sdata,
> +					    struct ieee80211_sta *sta,
> +					    struct net_device_path_ctx *ctx,
> +					    struct net_device_path *path)
> +{
> +	int ret =3D -EOPNOTSUPP;
> +
> +	sdata =3D get_bss_sdata(sdata);
> +	if (!check_sdata_in_driver(sdata))
> +		return -EIO;
> +
> +	trace_drv_net_fill_forward_path(local, sdata, sta);
> +	if (local->ops->net_fill_forward_path)
> +		ret =3D local->ops->net_fill_forward_path(&local->hw,
> +							&sdata->vif, sta,
> +							ctx, path);
> +	trace_drv_return_int(local, ret);
> +
> +	return ret;
> +}
> +
>  #endif /* __MAC80211_DRIVER_OPS */
> diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
> index 5666bbb8860b..08c0542c93a3 100644
> --- a/net/mac80211/ieee80211_i.h
> +++ b/net/mac80211/ieee80211_i.h
> @@ -1463,7 +1463,7 @@ struct ieee80211_local {
>  };
> =20
>  static inline struct ieee80211_sub_if_data *
> -IEEE80211_DEV_TO_SUB_IF(struct net_device *dev)
> +IEEE80211_DEV_TO_SUB_IF(const struct net_device *dev)
>  {
>  	return netdev_priv(dev);
>  }
> diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
> index 9a2145c8192b..6012442cd0d6 100644
> --- a/net/mac80211/iface.c
> +++ b/net/mac80211/iface.c
> @@ -789,6 +789,66 @@ static const struct net_device_ops ieee80211_monitor=
if_ops =3D {
>  	.ndo_get_stats64	=3D ieee80211_get_stats64,
>  };
> =20
> +
> +static int ieee80211_netdev_fill_forward_path(struct net_device_path_ctx=
 *ctx,
> +					      struct net_device_path *path)
> +{
> +	struct ieee80211_sub_if_data *sdata;
> +	struct ieee80211_local *local;
> +	struct sta_info *sta;
> +	int ret =3D -ENOENT;
> +
> +	sdata =3D IEEE80211_DEV_TO_SUB_IF(ctx->dev);
> +	local =3D sdata->local;
> +
> +	if (!local->ops->net_fill_forward_path)
> +		return -EOPNOTSUPP;
> +
> +	rcu_read_lock();
> +	switch (sdata->vif.type) {
> +	case NL80211_IFTYPE_AP_VLAN:
> +		sta =3D rcu_dereference(sdata->u.vlan.sta);
> +		if (sta)
> +			break;
> +		if (sdata->wdev.use_4addr)
> +			goto out;
> +		if (is_multicast_ether_addr(ctx->daddr))
> +			goto out;
> +		sta =3D sta_info_get_bss(sdata, ctx->daddr);
> +		break;
> +	case NL80211_IFTYPE_AP:
> +		if (is_multicast_ether_addr(ctx->daddr))
> +			goto out;
> +		sta =3D sta_info_get(sdata, ctx->daddr);
> +		break;
> +	case NL80211_IFTYPE_STATION:
> +		if (sdata->wdev.wiphy->flags & WIPHY_FLAG_SUPPORTS_TDLS) {
> +			sta =3D sta_info_get(sdata, ctx->daddr);
> +			if (sta && test_sta_flag(sta, WLAN_STA_TDLS_PEER)) {
> +				if (!test_sta_flag(sta, WLAN_STA_TDLS_PEER_AUTH))
> +					goto out;
> +
> +				break;
> +			}
> +		}
> +
> +		sta =3D sta_info_get(sdata, sdata->u.mgd.bssid);
> +		break;
> +	default:
> +		goto out;
> +	}
> +
> +	if (!sta)
> +		goto out;
> +
> +	ret =3D drv_net_fill_forward_path(local, sdata, &sta->sta, ctx, path);
> +out:
> +	rcu_read_unlock();
> +
> +	return ret;
> +}
> +
> +
>  static const struct net_device_ops ieee80211_dataif_8023_ops =3D {
>  	.ndo_open		=3D ieee80211_open,
>  	.ndo_stop		=3D ieee80211_stop,
> @@ -798,6 +858,7 @@ static const struct net_device_ops ieee80211_dataif_8=
023_ops =3D {
>  	.ndo_set_mac_address	=3D ieee80211_change_mac,
>  	.ndo_select_queue	=3D ieee80211_netdev_select_queue,
>  	.ndo_get_stats64	=3D ieee80211_get_stats64,
> +	.ndo_fill_forward_path	=3D ieee80211_netdev_fill_forward_path,
>  };
> =20
>  static bool ieee80211_iftype_supports_hdr_offload(enum nl80211_iftype if=
type)
> diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
> index 9e8381bef7ed..d91498f77796 100644
> --- a/net/mac80211/trace.h
> +++ b/net/mac80211/trace.h
> @@ -2892,6 +2892,13 @@ TRACE_EVENT(drv_twt_teardown_request,
>  	)
>  );
> =20
> +DEFINE_EVENT(sta_event, drv_net_fill_forward_path,
> +	TP_PROTO(struct ieee80211_local *local,
> +		 struct ieee80211_sub_if_data *sdata,
> +		 struct ieee80211_sta *sta),
> +	TP_ARGS(local, sdata, sta)
> +);
> +
>  #endif /* !__MAC80211_DRIVER_TRACE || TRACE_HEADER_MULTI_READ */
> =20
>  #undef TRACE_INCLUDE_PATH
> --=20
> 2.30.1
>=20

--z3GEtWHhO0qoKk9L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYZJhxAAKCRA6cBh0uS2t
rJkwAP0Vjm+aZOu2A0hweRS9Z/eW0zBMZabGjdMVNORxLmiqkwEA+OJLFWE+QwRO
RNwy5z4KwF97nW9ytjS5kmjVvhMKHAM=
=BBfw
-----END PGP SIGNATURE-----

--z3GEtWHhO0qoKk9L--
