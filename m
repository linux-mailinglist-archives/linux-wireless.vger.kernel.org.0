Return-Path: <linux-wireless+bounces-37379-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id flrsMAlYIWqlEQEAu9opvQ
	(envelope-from <linux-wireless+bounces-37379-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 12:48:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3592263F2F5
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 12:48:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=HhdnbLq+;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37379-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37379-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD22F302978A
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2026 10:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0ED255E43;
	Thu,  4 Jun 2026 10:47:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FBD1F78E6
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jun 2026 10:47:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570034; cv=none; b=LzhfpA4iP0eJnR7T0DRW8uUcgR6zZ6igHwg5nZWezdhQj2HL03PJWHWlmcZTnj0/doB+Pmms7sjl9xhdGOd3dnnOpGt4avD3ll772kXGnPBTSDFTSKW3pVWU/+cnG7+PoMudQybssPa42IqxNy48/8S/Pn2y/TFEouQzB38vV2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570034; c=relaxed/simple;
	bh=/seEleDKkGYuk/MHOv59UN+KdlFDtEMSc7Tuct/V6VU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OuEAG9OLS1uDflojNXTztnHDa6fFy2Vkk/qMpAD9dxUIH4Efx8qxpjRW2x7Y0IJGMpAtYOWy6KRPfOJbV+inbN0LJWAz13gGK8MzxA+/yVkDgDZlck3xkyMCYbHr1f+nNavs/7P/v+AadBMkoIZF4zUM9QdfcP8Tew1T6e5rG6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HhdnbLq+; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=VL6LHGS19HKlJdFRzuXGzK/Ky3Ss798f6pUQbi/YoEY=;
	t=1780570033; x=1781779633; b=HhdnbLq+dF4FKtCimjjztMjrz+ssKix/IfXgFEKYKS7+6GO
	s9juj5SZW9PUgZwaH4DAU79P8qrlym+a2bkcL+nql6NOrn2syL/Z1MZqD42Caw10KsAjAl2jNeY+P
	QGlVMH+uWlUiUTnWAzAm5U5C6Qkg+fDHICBXs5R7FdYuR8XvbAUHciX86HAzzGHJV09UHf/NxzT1v
	e3R03UGGbUH3Xi4AB2HF7Xce1UigZe6pJrveX3sFYHnxodlwaglAYScTovl/qN77EyZEgnE9VNmld
	HkEAfSyH9W6l74CFzabHTpuBkvsX69yoL+URsvuFjNihYG7oqMXEx71TeC2qvPdA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wV5bR-00000000RNH-1CKx;
	Thu, 04 Jun 2026 12:47:09 +0200
Message-ID: <6307cf0a5cb768d1f34da4dd4ea8ef5751b0ba68.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v3 3/4] wifi: mac80211: implement STA-mode
 peer probing
From: Johannes Berg <johannes@sipsolutions.net>
To: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, quic_drohan@quicinc.com
Date: Thu, 04 Jun 2026 12:47:08 +0200
In-Reply-To: <20260507171603.1007812-4-pritiwa@qti.qualcomm.com>
References: <20260507171603.1007812-1-pritiwa@qti.qualcomm.com>
	 <20260507171603.1007812-4-pritiwa@qti.qualcomm.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-37379-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:priyansha.tiwari@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:quic_drohan@quicinc.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3592263F2F5

On Thu, 2026-05-07 at 22:46 +0530, Priyansha Tiwari wrote:


> +	guard(rcu)();

You're rewriting the whole thing anyway - we have wiphy lock here, so we
don't really need RCU at all. Can just use wiphy_dereference() or
similar below, no?


> +	case NL80211_IFTYPE_STATION:
> +	case NL80211_IFTYPE_P2P_CLIENT:
> +		if (ieee80211_vif_is_mld(&sdata->vif)) {
> +			link_id =3D IEEE80211_LINK_UNSPECIFIED;
> +			peer_addr =3D sdata->vif.cfg.ap_addr;
> +			src_addr =3D sdata->vif.addr;
> +			band =3D 0;
> +			sta =3D sta_info_get(sdata, sdata->vif.cfg.ap_addr);
> +		} else {
> +			link_id =3D 0;
> +			conf =3D rcu_dereference(sdata->vif.link_conf[0]);
> +			if (!conf)
> +				return -ENOLINK;
> +			band =3D conf->chanreq.oper.chan->band;
> +			peer_addr =3D conf->bssid;
> +			src_addr =3D conf->addr;
> +			sta =3D sta_info_get_bss(sdata, peer_addr);
>  		}

This whole logic seems too much - the non-MLO case really should be a
subset of the MLO case anyway, because e.g. conf->bssid will definitely
be the same as sdata->vif.cfg.ap_addr, so you shouldn't really need
(most of?) this distinction.

Equally I don't think we need link_id=3D0 in the non-MLO case, fully non-
MLO drivers won't be looking at it anyway, and MLO drivers should be
able to deal with the UNSPECIFIED.

That leaves only really the band to be potentially set differently.
Ideally some unification with the AP side is possible there.

> -		band =3D chanctx_conf->def.chan->band;
> -		link_id =3D 0;
> +		qos =3D sta ? sta->sta.wme : false;
> +		fromds =3D false;
> +		break;

I see the check in cfg80211, but it just feels completely wrong to have
to do "sta ? ..." here when it should be connected.

Better to just refuse the operation when there's no 'sta' for the AP
found.

johannes

