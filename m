Return-Path: <linux-wireless+bounces-5445-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B88888F919
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 08:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC31D1C23242
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 07:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1B339FC6;
	Thu, 28 Mar 2024 07:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="SAiD+2uk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116B212E78
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 07:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612148; cv=none; b=n8RStYiZ+w8h+VU3WASg0PelPmUKMF1URvGt8LPs5fuWFfK9P5NR3HsGO+KrcbrCfOPcpEtxiY6G35WGQB5akGbHF5++L7IFkZFRB5+YUdOshQGhcW7DSoRAKJchMEZzO7Tds/Z2PijObGsqaRCrIeAT5gnfZvyPAb5gFmGCpzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612148; c=relaxed/simple;
	bh=B7kZZSoGsUegBhQ8XtsBDu+XcMhXAvmd+JeB/7XMV6A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jayszmwsT0KgClSpFo08EH83ozZmsnVGLIw5alEIYfMUuP/VIik08P84uk0uqj/dNvuULdNSuvIaPRb2bHnQoprvvJkHy7o+TzVuQjTDunOl+zzHVLASA9t0mCMf5EhY7ms8/Klsy3OBZytFZZi2bN6AKx+BZUlVzQgRt124BI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=SAiD+2uk; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QToXfY/wTkumO5E3egIyolac3Qy+dRyvrj06LGqXpUA=;
	t=1711612147; x=1712821747; b=SAiD+2ukxI62cXAsTQXUaUUYuHPEpPXXzGrlFUyss72GUxl
	Bejthpz9SPG+56oW74uQ4DbLAuggMNdgHqctxVqjlHwnJj5buWER4KAFq4x4d+T6luFX+RK+H/OxH
	YQYaFP5CfeKAyCzrwJfvUrnyCMbCrLK+edr07aF1TTEMnKKBU/SUGDkjOvzU+7HZymduF5foLtq3w
	nUeL4ZSr46o9PsLRNUQ/do9J0MfTsV/xdk9Uwd6fDTxdzQ2K7n3z1rI0W97okk1eXqXOlTG6SGuy5
	1+mHwg5EynfFRRsDHtaoq7/wwaNmUU94jLzHBd30sWnDMi8chYfsl3g7kIpk8fTw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpkVU-00000000kt6-0pOp;
	Thu, 28 Mar 2024 08:49:04 +0100
Message-ID: <6d92d0ba4a8764cd91cc20c4bd35613bcc41dfcd.camel@sipsolutions.net>
Subject: Re: [PATCH 02/13] wifi: nl80211: send underlying multi-hardware
 channel capabilities to user space
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>, 
	ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Vasanthakumar Thiagarajan
	 <quic_vthiagar@quicinc.com>
Date: Thu, 28 Mar 2024 08:49:03 +0100
In-Reply-To: <20240328072916.1164195-3-quic_periyasa@quicinc.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
	 <20240328072916.1164195-3-quic_periyasa@quicinc.com>
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

On Thu, 2024-03-28 at 12:59 +0530, Karthikeyan Periyasamy wrote:
>=20
> +/**
> + * nl80211_multi_hw_attrs - multi-hw attributes
> + *
> + * @NL80211_MULTI_HW_ATTR_INVALID: invalid
> + * @NL80211_MULTI_HW_ATTR_IDX: (u8) multi-HW index to refer the underlyi=
ng HW
> + *	for which the supported channel list is advertised. Internally refer
> + *	the index of the wiphy's @hw_chans array.

Is there a good reason to expose this? Seems pretty internal to me, and
not sure what userspace would do with it?

> +	for (i =3D 0; i < wiphy->num_hw; i++) {
> +		hw_mac =3D nla_nest_start(msg, i + 1);

And you kind of even have it here already ...

> @@ -3001,6 +3042,12 @@ static int nl80211_send_wiphy(struct cfg80211_regi=
stered_device *rdev,
>  				rdev->wiphy.hw_timestamp_max_peers))
>  			goto nla_put_failure;
> =20
> +		state->split_start++;
> +		break;
> +	case 17:
> +		if (nl80211_put_multi_hw_support(&rdev->wiphy, msg))
> +			goto nla_put_failure;
>=20

This could be (or get) pretty big, are you sure it's not needed to push
the splitting down into it?

johannes

