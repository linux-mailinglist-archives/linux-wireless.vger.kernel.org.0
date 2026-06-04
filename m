Return-Path: <linux-wireless+bounces-37380-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tv2DHGFcIWpbFAEAu9opvQ
	(envelope-from <linux-wireless+bounces-37380-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 13:07:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1193B63F4BA
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 13:07:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=a1m7VGIM;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37380-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37380-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 004EA300C26D
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2026 10:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED01307AC7;
	Thu,  4 Jun 2026 10:59:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494BD4C97
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jun 2026 10:58:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570740; cv=none; b=h2ezkNszE1vlHbXBUaLJsbI/S/B/H0MRLbUkNScuqnN8GzWjJH98dULz8ehLfco+bSOeU6Cqy8WRn6nz3wwxJLfX6irKi2ISgpoKFtVdjHejPE75khnHNx7vDG/PoABsJQLJNFwPdOutPdv/2gGunJdBHTrouMZzmRu2hq9/dfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570740; c=relaxed/simple;
	bh=crMnSAGpr5/5EtAwev19o4ZDeMUVB5tGnPe8q46DeEo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o3RdhzMAyUerS8UKeZb2NNMxVrJsNV1QCjIgiQXoZXvBDUOEeWY4EnuZ98sTLp0slvcQcaAIPxDV9cp56747TzI56byAWEF2V2BQBza+ILLjXyBAEyA1rHLRu8wJbID+ZFs3hra4nqbnN+WrBwqbIJ8/9GMKnm3C7nzdUFl6Y+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=a1m7VGIM; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=p66z/WdpD+nRpKuR+nmwCjd44ndaQDJnBGQKktoO/Ko=;
	t=1780570739; x=1781780339; b=a1m7VGIM//Dzeo0Hy3PXVziF36Apoft0Ht+Ob2EK7yWnKnU
	XN+E7GJjOcWeS54V//eAlrUn+kTMfMoYS9FbtqOODuJU5ta50UuRJtOXr/KUXEdN2/+9F3/KBOy4M
	WckHgpUL4zVIG9gGiQk3RN8r+sSs88Xb20upxDRespnqrG2tN0NdJyCBuqizTa40bRe+YMfDHzf7T
	ebTTkNfv6e1Gg1q8H72VNu+uZeYVIwMXP+zWrR5G/ody+1gUSJ6N7qiSso2lIBDm5+Q8I5/6our2J
	2rdRmDQlrO4H7o34hQ1n2BeF5fV/BGVoqSl8KnvFhQ9Nepm3ht5gHjRESTDN4LZA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wV5mp-00000000Rbj-2joi;
	Thu, 04 Jun 2026 12:58:55 +0200
Message-ID: <3b3319752ce919b5e767fbc5be8c4b7916efe828.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 3/3] wifi: mac80211: Add 802.3 multicast
 encapsulation offload support
From: Johannes Berg <johannes@sipsolutions.net>
To: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 04 Jun 2026 12:58:54 +0200
In-Reply-To: <20260516162900.1981500-4-tamizh.raja@oss.qualcomm.com>
References: <20260516162900.1981500-1-tamizh.raja@oss.qualcomm.com>
	 <20260516162900.1981500-4-tamizh.raja@oss.qualcomm.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tamizh.raja@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37380-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1193B63F4BA

On Sat, 2026-05-16 at 21:59 +0530, Tamizh Chelvam Raja wrote:
> mac80211 currently converts 802.3 multicast packets to 802.11 format befo=
re


that line got really long

> @@ -4751,6 +4772,25 @@ static void __ieee80211_subif_start_xmit_8023(stru=
ct sk_buff *skb,
>  		goto out;
>  	}
> =20
> +	/*
> +	 * For station mode sta is valid even though dest address
> +	 * is multicast and that will be sent in eth mode only.
> +	 * So, add error check for sta pointer before choosing
> +	 * multicast offload path.
> +	 */
> +	if (IS_ERR_OR_NULL(sta) &&
> +	    unlikely(ieee80211_check_mcast_offload(sdata, skb))) {

That's not really a good way to write a comment ... it's describing the
_change_, not the _state_. Also the code inside the if:

> +		sta =3D NULL;
> +		if (ieee80211_vif_get_num_mcast_if(sdata) <=3D 0) {
> +			/* No associated STAs - no need to send multicast frames. */
> +			kfree_skb(skb);
> +			goto out;
> +		}
> +		link =3D &sdata->deflink;
> +		key =3D rcu_dereference(link->default_multicast_key);
> +		goto tx_offload;
> +	}

is clearly for AP mode, so I'm not really sure what you intended to say
there.

Also don't really like yet another goto in this function, especially
with the ones that are there now, it's really confusing. There are only
a few lines that can be in an else branch?

johannes

