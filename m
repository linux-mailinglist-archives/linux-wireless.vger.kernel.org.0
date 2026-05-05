Return-Path: <linux-wireless+bounces-35903-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFaGJUHn+Wl1FAMAu9opvQ
	(envelope-from <linux-wireless+bounces-35903-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 14:49:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 376B54CDE64
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 14:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D60513004DD8
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 12:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73EC382F23;
	Tue,  5 May 2026 12:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="EVQuhrRb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F157D426D2A
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 12:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777985099; cv=none; b=SLhfaai627dNQjb9XC/tNDJZ0XdI3CPkp//8qrDPU/lyVJMLsYI9z8r5SkfWNy/ZmN39V0TVgYAxJfHwoN0Xc3qvxALFOJgEKFisAse/Ij8i44+2uTMU5zQwS/dQlVljZyFvgKNAXtmimSOvLiH+uYa5lSlHA9easaC4X+nq+Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777985099; c=relaxed/simple;
	bh=oIuErZyf4fCkFJiOlnEZP5HZi5Xq0+aBdWTQ0VG2ceg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aVuq5ReAwXaIsaVBns4pZxPbdIbIocq3lt9TQAwhkwsls7quhReSXeeRBppfiQclpcTDPJVrlV0eOZ16LeLt/9hvT3Gy52f0k+XXptVpKHG2HzI+gkM1ZCvGAEJquc1/vGv9eUylKgGImHsuDyarUgik9Oi9msmzaisIz2k0MPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=EVQuhrRb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=sOrFUJHyYkwfl/0PpjiAG60u6iweaCwkxM1h8csdu+8=;
	t=1777985098; x=1779194698; b=EVQuhrRbEgk2I28zGyweYP1EUrdeOixVuJWyYKUuFxmFlWK
	eW5OGZbzKf6ikQdE4Z1x92htLxuIn/sy4rGVwYi41NfFAQjPbRXQjyUk0k8WUyik0T07pC9hd2/sK
	TGWb/weXvvr6m632OBsQD3BxzHb5ewXAKHUWoCFBTY5vI7Ftgiq28prT7aJJkVeLcHQjJEUdclKIy
	Ry6z/vskMfSQx1I9ObxgmphR2AUXZD5GilUfS8oG6Dk5ZxcWwsuMKSDou6tmK8Thharq8giZ8Vwir
	ttzCx2ykwx4JYAjDmAAWHuwiomRndZP54C4QKYEYLiuosgpz9cK7NLaomNlMHkoQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wKF8v-0000000GBrO-2ZJ9;
	Tue, 05 May 2026 14:44:53 +0200
Message-ID: <e62b7868368678b59ce89dddcfc50311ecbf3c2d.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 3/4] wifi: mac80211: add per-link
 PROBE_PEER support
From: Johannes Berg <johannes@sipsolutions.net>
To: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, quic_drohan@quicinc.com
Date: Tue, 05 May 2026 14:44:52 +0200
In-Reply-To: <20260417133124.3412752-4-pritiwa@qti.qualcomm.com>
References: <20260417133124.3412752-1-pritiwa@qti.qualcomm.com>
	 <20260417133124.3412752-4-pritiwa@qti.qualcomm.com>
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
X-Rspamd-Queue-Id: 376B54CDE64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35903-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]

On Fri, 2026-04-17 at 19:01 +0530, Priyansha Tiwari wrote:
>=20
> -			u8 pad2;
> +			u8 link_valid:1, link_id:4, pad2:3;

You don't need to pad bitfields.

> +	if (sdata->vif.type =3D=3D NL80211_IFTYPE_STATION ||
> +	    sdata->vif.type =3D=3D NL80211_IFTYPE_P2P_CLIENT) {

Err ...

> +	/* STA/P2P: userspace must NOT provide peer MAC, AP is implied.	 */

> +		if (peer)
> +			return -EINVAL;

That check belongs into cfg80211, not here?

> +		if (!sdata->u.mgd.associated)
> +			return -ENOTCONN;

maybe be consistent, cfg80211 returns -ENOLINK?

> +	} else if (!peer) {
> +		/* AP/GO: must have a peer MAC. */
> +		return -EINVAL;
>  	}
> =20
> -	qos =3D sta->sta.wme;
> +	guard(rcu)();
> =20
> -	if (ieee80211_vif_is_mld(&sdata->vif)) {
> -		if (sta->sta.mlo) {
> -			link_id =3D IEEE80211_LINK_UNSPECIFIED;
> -		} else {
> -			/*
> -			 * For non-MLO clients connected to an AP MLD, band
> -			 * information is not used; instead, sta->deflink is
> -			 * used to send packets.
> -			 */
> -			link_id =3D sta->deflink.link_id;
> +	if (sdata->vif.type =3D=3D NL80211_IFTYPE_AP ||
> +	    sdata->vif.type =3D=3D NL80211_IFTYPE_P2P_GO) {

Again, what?

And unrelated, maybe this would all be better as a switch statement?

> +		sta =3D sta_info_get_bss(sdata, peer);
> +		if (!sta)
> +			return -ENOLINK;
> =20
> -			conf =3D rcu_dereference(sdata->vif.link_conf[link_id]);
> +		qos =3D sta->sta.wme;
> =20
> -			if (unlikely(!conf)) {
> -				ret =3D -ENOLINK;
> -				goto unlock;
> +		if (ieee80211_vif_is_mld(&sdata->vif)) {
> +			if (sta->sta.mlo) {
> +				link_id =3D IEEE80211_LINK_UNSPECIFIED;
> +			} else {
> +				/*
> +				 * For non-MLO clients connected to an AP MLD,
> +				 * use the link address for the client's link.
> +				 */
> +				link_id =3D sta->deflink.link_id;
> +				conf =3D rcu_dereference(sdata->vif.link_conf[link_id]);
> +				if (unlikely(!conf))
> +					return -ENOLINK;
>  			}
> +			/* MLD transmissions must not rely on the band */
> +			band =3D 0;
> +		} else {
> +			chanctx_conf =3D rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
> +			if (WARN_ON(!chanctx_conf))
> +				return -EINVAL;
> +			band =3D chanctx_conf->def.chan->band;
> +			link_id =3D 0;
> +		}
> +
> +		size =3D sizeof(*nullfunc);
> +		fc =3D cpu_to_le16(IEEE80211_FTYPE_DATA |
> +				 (qos ? IEEE80211_STYPE_QOS_NULLFUNC
> +				      : IEEE80211_STYPE_NULLFUNC) |
> +				 IEEE80211_FCTL_FROMDS);
> +		if (!qos)
> +			size -=3D 2;
> +
> +		skb =3D dev_alloc_skb(local->hw.extra_tx_headroom + size);
> +		if (!skb)
> +			return -ENOMEM;
> +
> +		skb->dev =3D dev;
> +		skb_reserve(skb, local->hw.extra_tx_headroom);
> +
> +		nullfunc =3D skb_put(skb, size);
> +		memset(nullfunc, 0, size);
> +		nullfunc->frame_control =3D fc;
> +
> +		memcpy(nullfunc->addr1, sta->sta.addr, ETH_ALEN);
> +		if (ieee80211_vif_is_mld(&sdata->vif) && !sta->sta.mlo) {
> +			memcpy(nullfunc->addr2, conf->addr, ETH_ALEN);
> +			memcpy(nullfunc->addr3, conf->addr, ETH_ALEN);
> +		} else {
> +			memcpy(nullfunc->addr2, sdata->vif.addr, ETH_ALEN);
> +			memcpy(nullfunc->addr3, sdata->vif.addr, ETH_ALEN);
> +		}
> +
> +		info =3D IEEE80211_SKB_CB(skb);
> +		info->flags |=3D IEEE80211_TX_CTL_REQ_TX_STATUS |
> +			       IEEE80211_TX_INTFL_NL80211_FRAME_TX;
> +		info->band =3D band;
> +		info->control.flags |=3D u32_encode_bits(link_id,
> +						       IEEE80211_TX_CTRL_MLO_LINK);
> +
> +		skb_set_queue_mapping(skb, IEEE80211_AC_VO);
> +		skb->priority =3D 7;
> +		if (qos)
> +			nullfunc->qos_ctrl =3D cpu_to_le16(7);
> +
> +		ret =3D ieee80211_attach_ack_skb(local, skb, cookie, GFP_ATOMIC);
> +		if (ret) {
> +			kfree_skb(skb);
> +			return ret;
>  		}
> -		/* MLD transmissions must not rely on the band */
> +
> +		local_bh_disable();
> +		ieee80211_xmit(sdata, sta, skb);
> +		local_bh_enable();
> +
> +		return 0;
> +	}
> +
> +	/*
> +	 * STA/P2P: send a nullfunc to probe the AP/peer.
> +	 * For MLO, let the driver/firmware decide which link to use.
> +	 */
> +	if (ieee80211_vif_is_mld(&sdata->vif)) {
> +		link_id =3D IEEE80211_LINK_UNSPECIFIED;
> +		peer_addr =3D sdata->vif.cfg.ap_addr;
> +		src_addr =3D sdata->vif.addr;
>  		band =3D 0;
> +		sta =3D sta_info_get(sdata, sdata->vif.cfg.ap_addr);
>  	} else {
> -		chanctx_conf =3D rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
> -		if (WARN_ON(!chanctx_conf)) {
> -			ret =3D -EINVAL;
> -			goto unlock;
> -		}
> -		band =3D chanctx_conf->def.chan->band;
>  		link_id =3D 0;
> +		conf =3D rcu_dereference(sdata->vif.link_conf[0]);
> +		if (!conf)
> +			return -ENOLINK;
> +		band =3D conf->chanreq.oper.chan->band;
> +		peer_addr =3D conf->bssid;
> +		src_addr =3D conf->addr;
> +		sta =3D sta_info_get_bss(sdata, peer_addr);
>  	}

I really don't like the layout and code duplication here. Off-hand I'd
think the duplication isn't needed, but otherwise perhaps it should be
in separate functions or so.

johannes

