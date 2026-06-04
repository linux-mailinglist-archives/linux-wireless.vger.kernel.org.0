Return-Path: <linux-wireless+bounces-37381-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zqyZKkZeIWrEFAEAu9opvQ
	(envelope-from <linux-wireless+bounces-37381-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 13:15:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AACE763F560
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 13:15:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=juoCsuBv;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37381-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37381-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B45D7300E906
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2026 11:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6947C3C4177;
	Thu,  4 Jun 2026 11:02:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BA0305696
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jun 2026 11:02:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570951; cv=none; b=j6qHSoOkwUbVLnAKu7f32fR2MhdcKBXa+40uFuZZQs2Ry5/DrOL3oyU9B9y/YkPffsaKcOJojhhO9WLgdJI4bej70B+HqxmKYAgdccx8hdhaDrMkjTIU2NclYLoNdx9OR5JAEGgP4YO2lKjW/9Tp7eXDyNBhjc9vW3redMmgZlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570951; c=relaxed/simple;
	bh=C+RfC3kcC5jGSP2ehVJ/y1oBokVSArcpGVZD6oI1LIg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eXKd9mI5oXBRpKPi9Qokrdp/NFY+qlCYvlruPioM0gokJg34rLFVm4d+qqNCvtJ+9ZYTRfbvMkoO32ZCegtuEGm3AREEk7qRz5cjB82HhWcHmmuxNyoJUcp85St2d0W25OBnlN9Z0fzRBkcXRUZ6cgzpBxVgBj+RMIy7V4Xkucs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=juoCsuBv; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QoUl+iy4Q0l0d3iPZTSd3uGPnK7pDKJYC3R3dIC27+w=;
	t=1780570949; x=1781780549; b=juoCsuBvoLZQQvS+q/FbpKC2/A6w3UVbIJVALcjXr3QEHwM
	kjVdinIjib4OJLhlFXGGkdSL3WKkVbfQTk+ysrxH+gzebkM87a4o0uUGM4Jm8tNwlntAgyRUVp3+d
	Crs0c25h7b9KfQmqRhzViVZBktww8Iki/i1whwgWKu76LzSJoirIxdeb3rleJQ9zV3tNOGUwoAiz1
	qIB6+ZwRC6lXjlZH0Qt9tohPM9Ms23HHqim1eV+XMjvXJHutc8XRQRN5MEUj090os9FYwgQ+rhITu
	tsMtZGjIqKgw0LIq7VhwGSbgo6/AGFojEwXVqX18YgyPnWOHe+7cTv0PkzVd7c8g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wV5qD-00000000Rhy-3iHH;
	Thu, 04 Jun 2026 13:02:26 +0200
Message-ID: <09e2bd29cf9f8ad3fe64776343fd1e06426ea362.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 1/2] wifi: nl80211: Add
 NL80211_ATTR_MAX_CH_SWITCH_TIME attribute
From: Johannes Berg <johannes@sipsolutions.net>
To: Shashikala Prabhu <shashikala.prabhu@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, vikram@qti.qualcomm.com, 
	kiranv@qti.qualcomm.com, pshashik@qti.qualcomm.com, cgopi@qti.qualcomm.com,
 	ybasamma@qti.qualcomm.com, vthiagar@qti.qualcomm.com,
 sivad@qti.qualcomm.com, 	uvignesh@qti.qualcomm.com,
 mohathan@qti.qualcomm.com, abishekg@qti.qualcomm.com
Date: Thu, 04 Jun 2026 13:02:25 +0200
In-Reply-To: <20260518103106.1462604-2-shashikala.prabhu@oss.qualcomm.com>
References: <20260518103106.1462604-1-shashikala.prabhu@oss.qualcomm.com>
	 <20260518103106.1462604-2-shashikala.prabhu@oss.qualcomm.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:shashikala.prabhu@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:vikram@qti.qualcomm.com,m:kiranv@qti.qualcomm.com,m:pshashik@qti.qualcomm.com,m:cgopi@qti.qualcomm.com,m:ybasamma@qti.qualcomm.com,m:vthiagar@qti.qualcomm.com,m:sivad@qti.qualcomm.com,m:uvignesh@qti.qualcomm.com,m:mohathan@qti.qualcomm.com,m:abishekg@qti.qualcomm.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37381-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
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
X-Rspamd-Queue-Id: AACE763F560

On Mon, 2026-05-18 at 16:01 +0530, Shashikala Prabhu wrote:
> From: Chandru Gopi <cgopi@qti.qualcomm.com>
>=20
> IEEE Std 802.11-2024 subclause 9.4.2.216 (Max Channel Switch Time element=
)
> defines a Switch Time field in the Channel Switch Announcement (CSA)
> element that indicates the time delta between the time the last beacon
> is transmitted by the AP in the current channel and the expected time
> of the first beacon transmitted by the AP in the new channel.
>=20
> Add a new u32 nl80211 attribute, NL80211_ATTR_MAX_CH_SWITCH_TIME,
> to carry this value in the NL80211_CMD_CH_SWITCH_STARTED_NOTIFY
> event. Userspace can use this information to decide whether to
> remain connected or disconnect before the AP moves to the new
> channel.

This really confused me a lot because that event is used on both sides
... don't include the new netlink attribute when it's on the AP side.

Also bad split with the patches - make one cfg/nl80211 API patch, and
one mac80211 patch.

>  	NL80211_ATTR_NPCA_PUNCT_BITMAP,
> =20
> +	NL80211_ATTR_MAX_CH_SWITCH_TIME,
>  	/* add attributes here, update the policy in nl80211.c */

nit: looks odd without the blank line

> +++ b/net/wireless/nl80211.c
> @@ -1093,6 +1093,7 @@ static const struct nla_policy nl80211_policy[NUM_N=
L80211_ATTR] =3D {
>  	[NL80211_ATTR_NPCA_PRIMARY_FREQ] =3D { .type =3D NLA_U32 },
>  	[NL80211_ATTR_NPCA_PUNCT_BITMAP] =3D
>  		NLA_POLICY_FULL_RANGE(NLA_U32, &nl80211_punct_bitmap_range),
> +	[NL80211_ATTR_MAX_CH_SWITCH_TIME] =3D { .type =3D NLA_U32 },

That seems wrong since it's output only, it shouldn't even be accepted
on input.

johannes

