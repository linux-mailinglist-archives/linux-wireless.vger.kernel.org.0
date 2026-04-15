Return-Path: <linux-wireless+bounces-34762-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDmdD0Bg32k0SQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34762-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 11:54:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB17402F1B
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 11:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20D2D300C93F
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 09:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701762FE056;
	Wed, 15 Apr 2026 09:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="DM9h450P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149E732D43C
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 09:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246516; cv=none; b=AWR9x0JzSQ91Gof3wJqYiIFGfUqzG5wMGI7JIBKRk/x7z67QRyjr5vv94HNkIdj5NFJTN01DwDZfNutZBqHgLCA++Y1Yd6cohbiSG5q0yq8wOE995B+MvwJ/iCkr5o06pMu2kEwUOAqxyr35m0GHBV+vjmuGEJjzpvj6XIOvWnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246516; c=relaxed/simple;
	bh=opYeeEBh4eQOEYmGmRwZl6zSoP0AppOkaBk6E28hPb0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cb/D1gzOCDmVwA7lTbeTqfGy6Z82D2jwVJrkDU69hFkywZ9+NrcLEV9WafoINYpO/M20wMbINkQJexWW+VxjYN7sm3ZuebWZN00bFJxAKaLGJxX43uOHiV1vbDDoGT0muIC8hOYxFeGJ1VyT8zbI1NIdjUZjrA1DQDcY1mOaaNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=DM9h450P; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zLwnAEaVGY3oJQSKkTGQDSa77oNKNBBPCpwf4Qce+Zg=;
	t=1776246515; x=1777456115; b=DM9h450P4eNFYAIux8DXM9uO5WTnm8xMDpv7AeW59lrig60
	Z2DE/27Zp3nxoNPOSam2K+unDILPbSvmgPpNOYIqLQKvDqYse/l8o0Opll9v+YYc+7qT4hmMKKCpI
	FUt2KVyXzaBjntX5FPdwgzkz8bML2lODWqclWTPv+Oz3MKBsvbDgyBYIvqE2L88TlNgUQn5166IDM
	W/wDZkbjnKLJ01EfQpAqViVObPUii+omiPg5q/57Hr+ZpDMeCJudMCRk7FMvkd8Hnup4O6YsBKFnM
	l9a3FuFuVpqJ6WZzT0LKOgk0kqvC1Zu3B3na7N3yx1xRG+H7RFI1A1tJSHgDRYgg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wCwrH-00000006Jq5-0LsN;
	Wed, 15 Apr 2026 11:48:31 +0200
Message-ID: <9d74c72450299311f5b00d5fb761e7931de94724.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v1 4/4] wifi: mac80211_hwsim: report TX
 status link_id
From: Johannes Berg <johannes@sipsolutions.net>
To: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, quic_drohan@quicinc.com
Date: Wed, 15 Apr 2026 11:48:30 +0200
In-Reply-To: <20260415094304.1731390-5-pritiwa@qti.qualcomm.com>
References: <20260415094304.1731390-1-pritiwa@qti.qualcomm.com>
	 <20260415094304.1731390-5-pritiwa@qti.qualcomm.com>
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
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34762-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,sipsolutions.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 8EB17402F1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-15 at 15:13 +0530, Priyansha Tiwari wrote:
> From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
>=20
> Populate link_valid/link_id in mac80211_hwsim TX status so the
> transmitted link is reported to mac80211.
>=20
> Set the link information in both the direct TX status path and the
> wmediumd/netlink TX status path.
>=20
> Signed-off-by: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
> ---
>  drivers/net/wireless/virtual/mac80211_hwsim.c | 46 ++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/=
wireless/virtual/mac80211_hwsim.c
> index 1fcf5d0d2e13..2a3df3e81f54 100644
> --- a/drivers/net/wireless/virtual/mac80211_hwsim.c
> +++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
> @@ -2074,6 +2074,27 @@ static int mac80211_hwsim_set_key(struct ieee80211=
_hw *hw, enum set_key_cmd cmd,
>  	return 0;
>  }
> =20
> +static int mac80211_hwsim_get_link_id(struct ieee80211_vif *vif,
> +				      struct ieee80211_hdr *hdr)

nit: maybe move this down closer to where it's needed? I did wonder for
a second why you need this at all, until I realized it's only for the
netlink case.

> +	/* Simulate ACK RSSI in perfect medium (no wmediumd) */
> +	if (!(txi->flags & IEEE80211_TX_CTL_NO_ACK) && ack) {
> +		txi->status.ack_signal =3D data->rx_rssi;
> +		txi->status.flags |=3D IEEE80211_TX_STATUS_ACK_SIGNAL_VALID;
> +	}

No objection to this change itself, but it's unrelated?

> @@ -6009,6 +6046,7 @@ static int mac80211_hwsim_new_radio(struct genl_inf=
o *info,
> =20
>  	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
>  	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_PUNCT);
> +	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_PROBE_AP);

Also not related to reporting TX status link ID?

>  		if (skb->len >=3D 16) {
> -			hdr =3D (struct ieee80211_hdr *) skb->data;
>  			mac80211_hwsim_monitor_ack(data2->channel,
>  						   hdr->addr2);
>  		}

nit: remove braces now.

johannes

