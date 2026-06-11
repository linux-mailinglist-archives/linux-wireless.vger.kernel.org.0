Return-Path: <linux-wireless+bounces-37670-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6I6cFNmmKmqwuQMAu9opvQ
	(envelope-from <linux-wireless+bounces-37670-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 14:15:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEC7671BBE
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 14:15:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b="h/ysCyGJ";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37670-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37670-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96CFE3007672
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 12:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87993F1ADC;
	Thu, 11 Jun 2026 12:14:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71435374A1B;
	Thu, 11 Jun 2026 12:14:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781180079; cv=none; b=G0U10NTbe3nUusHDPWKoBw9qy0/cfimZL5GrPiKwETRmOh/oZoo9kMlG0LVHqcV2wqnDu49H8Xwrc0nqrA9mrEErSP/Nc94+ix5EFidP5YKlzHf67tvknI9HHUtEKj2hk8p/YQ1A0cIIhn26CoG2ZV/KH1w7vMNtkJX3I7pwlMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781180079; c=relaxed/simple;
	bh=pZBwQN/SvU5hzocJ4ERPh0p5USb9OMY5oE+FNcAeqgU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OYg7nN0cVBPsgyzkAgZ0QEEGfMtVzbL8WWZKPsw/Cl/0w+kKTddfsFhrmG/gzLLS119zn/PX1Iky+iHJQ77p0ZB+48yd7vo4CSmY4G8dfF+iTK5v4JN71lGtPVqLHCEPPPgfRXfk4BMfbze7eGAepqNzi1cRFyYtmolexk6nG3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=h/ysCyGJ; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=WXxj1mkeB6TWeJTqqo+Z4AllTELSelgmZsAG2liQDH8=;
	t=1781180077; x=1782389677; b=h/ysCyGJgxtIUNEOryO/jkwCnHmzUzjepqzxd/B5HXPGsLh
	99dZlltXiRp4JyQTEdAM/6spEVbWaIChXWPGf29u2Bq/9sbeQGuDDlSQ6133lsqd0wYPQnYaDlOoH
	eLc3DFzrGizE8v3I8u43JCKaQSRuybyHfpGRETzZnlmZDgewYt+V4eWJrpzsDklbd1gnUALwQbPvv
	CL24zbpFIlNr6NVBTkNbzvHyfRnpcZIBkCMcWdLaU05YAHP/fTgIIdWGZRHNo/JypYecuQM55tymX
	2u0R+hZVrdDh67LloYPGypEpHoboF0npBSchif3wdUKsRvVJemHmyUhorAiKoIXw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wXeIt-00000008zcj-0fJF;
	Thu, 11 Jun 2026 14:14:35 +0200
Message-ID: <caf46af4de722bd220fc934dd0b94e5090c5fe10.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: ieee80211: validate MLE common info length
From: Johannes Berg <johannes@sipsolutions.net>
To: Zhao Li <enderaoelyther@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Thu, 11 Jun 2026 14:14:34 +0200
In-Reply-To: <20260610154303.37079-1-enderaoelyther@gmail.com>
References: <20260610154303.37079-1-enderaoelyther@gmail.com>
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
	FORGED_RECIPIENTS(0.00)[m:enderaoelyther@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37670-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CEEC7671BBE

On Wed, 2026-06-10 at 23:43 +0800, Zhao Li wrote:
> ieee80211_mle_size_ok() verifies that the advertised common information
> length is large enough for the fixed fields that are present, but it does
> not verify that the length also fits in the containing element.
>=20
> Reconfiguration and Priority Access MLEs also carry a common information
> length octet, but currently skip the common-length check. Reconfiguration
> additionally fails to include the length octet in the minimum common size=
.
>=20
> Validate the common information length for Reconfiguration and Priority
> Access MLEs, account for the Reconfiguration length octet, and reject
> common lengths that exceed the element body.
>=20
> Fixes: 0f48b8b88aa9 ("wifi: ieee80211: add definitions for multi-link ele=
ment")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
> ---
>  include/linux/ieee80211-eht.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/ieee80211-eht.h b/include/linux/ieee80211-eht.=
h
> index a97b1d01f3acf..d875045abf6cc 100644
> --- a/include/linux/ieee80211-eht.h
> +++ b/include/linux/ieee80211-eht.h
> @@ -878,6 +878,8 @@ static inline bool ieee80211_mle_size_ok(const u8 *da=
ta, size_t len)
>  		check_common_len =3D true;
>  		break;
>  	case IEEE80211_ML_CONTROL_TYPE_RECONF:
> +		common +=3D 1;
> +		check_common_len =3D true;
>  		if (control & IEEE80211_MLC_RECONF_PRES_MLD_MAC_ADDR)
>  			common +=3D ETH_ALEN;
>  		if (control & IEEE80211_MLC_RECONF_PRES_EML_CAPA)
> @@ -893,6 +895,7 @@ static inline bool ieee80211_mle_size_ok(const u8 *da=
ta, size_t len)
>  		break;
>  	case IEEE80211_ML_CONTROL_TYPE_PRIO_ACCESS:
>  		common =3D ETH_ALEN + 1;
> +		check_common_len =3D true;
>  		break;

You just made check_common_len redundant, it's now always true.

I originally introduced it because variable[0] wasn't always common_len,
but that actually got fixed in later drafts, and we should've adjusted
that when we added +1 to all of these, e.g. commit 19aa842dcbb58.

We should probably more comprehensively change the whole thing so that
common_info_len is a separate u8 rather than variable[0], but that's
going to be much harder to do.

A smaller but probably better change would be to use the sub-structs
here that are defined, e.g. struct ieee80211_mle_preq_common_info,
struct ieee80211_mle_tdls_common_info and struct
ieee80211_mle_basic_common_info. But the layout is a bit stupid even
that way, dunno.

johannes

