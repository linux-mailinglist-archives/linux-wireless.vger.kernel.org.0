Return-Path: <linux-wireless+bounces-32464-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFUxDdgcqGmYoAAAu9opvQ
	(envelope-from <linux-wireless+bounces-32464-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 12:51:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D16E61FF522
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 12:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 149653063823
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 11:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5672D39FCC2;
	Wed,  4 Mar 2026 11:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="PfiOFsh9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2155938E5E1
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772625034; cv=none; b=tdTqrGN6JWkEYR671M92ZmWRUH1rkT4kAkObZYXJm8+4RIx2UFdVd14kgPAQToXWYNnWKANXVvognRXs+Aiwb2+VGx3QSIvyggypUyEvuuylOVb78K4HMdFVaOJlVq8zCd1yK1hduNGoNebfPY+pGu3Xa8Ae7cXTOVVnVy+wQAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772625034; c=relaxed/simple;
	bh=q3DE9vOaigtLlKcc8sXzmDpVlqEHispVyAKDPoS9y6M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NkwcGe5MVUpIO+Up6JD1X1wsHDWalbpWu66dcZgpyOo8xs1TPjDwHI8KD2JUa32Th51xb8gD9Mq85lGTnV5gOsWHLwL6Csf9JUwUuCr9FzwqfJlW0vEpblVCiGVGZo7GhUAkplUbwTOEiVb7ZEd4f3c9L6P8Jj6H5GvWVJma+9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=PfiOFsh9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=K+zssNMV9q796HtRGvKwy0H4kjtVUKNsqnthZZzxWg8=;
	t=1772625033; x=1773834633; b=PfiOFsh93Tl8pK7Dw9GTBNw268wH/jFxMqAQLF8UvyUBsR4
	d0XBhleoo06CwdzvYhdjnGmCYMqdpeWuIeEa/JnfhUBZZVGggeuBlv1ieIZUovR82eI23AiT6ymlV
	pTW6SfjaH2EzDrkj1vovt9ctafRApdz+e7DaxrcdwP8fvev4zQsTf7Enq2PwgSBloAoDmi8qqQK/L
	Gbjsah/GVmQfNkwBkXuk7MP0Hh39OOlsyStuTHyzJVblg9Pie4YHBcAsnWLX9Pb/+36w3t1CUXrqt
	+ARgikvwu9JxXixC5/fddvnrzl70aqremeGz4i0qgE9rkCxGajMt8MgNb8qpzxXA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vxkkH-000000083V1-1lA0;
	Wed, 04 Mar 2026 12:50:29 +0100
Message-ID: <f30b49f1dca7c9529bbcf6fdad72bf8ca2c0b0c3.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 06/16] wifi: cfg80211: add proximity
 detection capabilities to PMSR
From: Johannes Berg <johannes@sipsolutions.net>
To: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Date: Wed, 04 Mar 2026 12:50:27 +0100
In-Reply-To: <20260304071538.3833062-7-peddolla.reddy@oss.qualcomm.com>
References: <20260304071538.3833062-1-peddolla.reddy@oss.qualcomm.com>
	 <20260304071538.3833062-7-peddolla.reddy@oss.qualcomm.com>
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
X-Rspamd-Queue-Id: D16E61FF522
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32464-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.232.135.74:from];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[168.119.38.16:received,100.90.174.1:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,sipsolutions.net:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, 2026-03-04 at 12:45 +0530, Peddolla Harshavardhan Reddy wrote:
>=20
> +++ b/net/wireless/nl80211.c
> @@ -404,6 +404,10 @@ nl80211_pmsr_attr_policy[NL80211_PMSR_ATTR_MAX + 1] =
=3D {
>  	[NL80211_PMSR_ATTR_TYPE_CAPA] =3D { .type =3D NLA_REJECT },
>  	[NL80211_PMSR_ATTR_PEERS] =3D
>  		NLA_POLICY_NESTED_ARRAY(nl80211_pmsr_peer_attr_policy),
> +	[NL80211_PMSR_ATTR_PD_SUPPORT] =3D { .type =3D NLA_REJECT },
> +	[NL80211_PMSR_ATTR_PD_CONCURRENT_ISTA_RSTA_SUPPORT] =3D {
> +		.type =3D NLA_REJECT
> +	},


Probably should use something like the global policy, with
         [0] =3D { .strict_start_type =3D NL80211_PMSR_ATTR_PD_SUPPORT },

instead of listing them? That way, unlisted ones become reject
automatically, I think. It's been a while ...

johannes

