Return-Path: <linux-wireless+bounces-38673-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RevfARmkS2pwXgEAu9opvQ
	(envelope-from <linux-wireless+bounces-38673-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 14:48:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38634710C3A
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 14:48:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=qOqq4odu;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38673-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38673-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5B72322D8AD
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 10:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD203A5E93;
	Mon,  6 Jul 2026 10:54:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE33D303C9C
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 10:54:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783335250; cv=none; b=nBjxOpPySr1exlwMfd/pdVPrunlU2vjcSIDj0p1t5IeqNXp9Msq7mvb4U7MEaAHYXwXIXDOo6g4E2nhFC1gLXNP9WNivFg3nE0zGiBat2lTlKrbOI6S1amb2mqJNYvUlhw44FglblA8moqGlVVOgUNBaVU8Jj2V97xwqi8K03+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783335250; c=relaxed/simple;
	bh=1VfGwQyqm85kRlTDkyURvifgwc43LbuOrgXR/ZdODdM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a4HR6gWU+nCTIAWrGWRTIalgj2BmrU345SO3vP0yiBFrP1vVST5p5SF1WIkaiuN8WPSRx8QmxpJcQMpkpJ0q6wMNylZDSHgXJbbPBSfBx7KmAplqoa/ZZoGsN5v+/OIUqpoDCf8c/nndQUqEgprFqu1E6uFNzVdo8lqExXd7AWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qOqq4odu; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=fjyw2jFaTKSFHNWY2CKEBOo8aO2mOl6RpigxW+MdlmA=;
	t=1783335248; x=1784544848; b=qOqq4odufQcHpzdCdCpEXl+SmPyLecS6+q1p94yvIkyQ2+o
	8QIkOCF6SVEabl+HxUye/8u5DtFvQyZGioVE+jHROy5eaPTKqvl3F5EiEe+VCH/jS/RVbKWVaXDuw
	UdIIjVHOWgKdvujIYNqsyYKh3EhcGUFHB+IN1vk2PP/NYtJEt7oRIns4dmT1foMnsbdvYd6Yn2Yy4
	Z1l5vsbFdTYLvOor9tKjGz27rZONsT49nTD3dpf6QX0tq4+4QfM1tdkxSYOeUwZxNZku6O2bFBFJt
	mk8GaVMadMVs+vzd+PG5XlK85CONn7bJf8BDcYYt1kBdu7/sbZWM8wbhBVjF/PzA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wggxb-0000000DE4m-3hDD;
	Mon, 06 Jul 2026 12:54:03 +0200
Message-ID: <b1d6bff2709e5368b635b956b435cccf4606cb66.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v5 3/4] wifi: mac80211: implement STA-mode
 peer probing
From: Johannes Berg <johannes@sipsolutions.net>
To: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
Cc: veerendranath.jakkam@oss.qualcomm.com, linux-wireless@vger.kernel.org, 
	quic_drohan@quicinc.com
Date: Mon, 06 Jul 2026 12:53:58 +0200
In-Reply-To: <20260611062225.2144241-4-pritiwa@qti.qualcomm.com>
References: <20260611062225.2144241-1-pritiwa@qti.qualcomm.com>
	 <20260611062225.2144241-4-pritiwa@qti.qualcomm.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:priyansha.tiwari@oss.qualcomm.com,m:veerendranath.jakkam@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:quic_drohan@quicinc.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38673-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:from_mime,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38634710C3A

On Thu, 2026-06-11 at 11:52 +0530, Priyansha Tiwari wrote:
>=20
> @@ -1396,7 +1396,7 @@ struct ieee80211_tx_info {
>  			u8 pad;
>  			u16 tx_time;
>  			u8 flags;
> -			u8 pad2;
> +			u8 link_valid:1, link_id:4;

[...]

>  	info->control.flags |=3D u32_encode_bits(link_id,
>  					       IEEE80211_TX_CTRL_MLO_LINK);
> +	if (link_id !=3D IEEE80211_LINK_UNSPECIFIED) {
> +		info->status.link_valid =3D 1;
> +		info->status.link_id =3D link_id;
> +	}

These changes seem so *obviously* wrong that I can't believe you're
actually trying to achieve what it looks like.

I guess I'll apply patches 1 and 2.

johannes

