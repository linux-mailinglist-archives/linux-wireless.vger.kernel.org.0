Return-Path: <linux-wireless+bounces-32467-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLqXK5kfqGlQoQAAu9opvQ
	(envelope-from <linux-wireless+bounces-32467-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 13:03:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 173EC1FF747
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 13:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35A673024CA3
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 12:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093B4370D50;
	Wed,  4 Mar 2026 12:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="DEAKkHc+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352E835F179
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 12:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772625789; cv=none; b=Fz4BkwVTHhqBBbf6PpaTK5gKC348XOPpx5TJTO3zVDrQ9BlPFX2MMCbVWg5Lke9xy7x5qU2wKzZCjNqpdjSH+Bpe4Am+ksB/0OSsGHza4Zvsmmt7AENg8K5OKtyqcge0V+Mj2dRY2j4ypzl+Xkx6KlHxfkuPNClsjXB1atpZNpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772625789; c=relaxed/simple;
	bh=u8PqfmR912/aSCMaXJ1peQadPLO7ylLnBxBGXJUEKzI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PXeTXO2qf8CXgKhMNdPBiiZJebJ/ymwVCVsu0cilm6NvmNjHImmPk2uqdNwqhVbnMXK/TNcL/zna4xwu6eVqpxQaf52tv2Y7LlmfNEX68ABirl1GiOSP46sT7Yl/mdMnEqRIlkAgHOPZ8KUJoPNrn8VVnuc+NzII/svZ1EqFEHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=DEAKkHc+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=C3GqBEt6MfPv8AMu2pT6WowVEpEgO2fEjab1Vz3Dkow=;
	t=1772625785; x=1773835385; b=DEAKkHc+gIV9pfAOst4/xLTPGnmNHql/TVPDciYjHtS9x/t
	H5Sj2Dexp8vpqM6tXsmyDLRLZwx9D/NnZ0XN2kJYX8E6jRXyrffZoz7ZOK9Z8isV6FkWnZk2xs2DU
	gG7QqVF8pvf8BxlBBE5JSEcveduMFnLapv6rNrkwMW5HDXb0Qjf3jaNMPdF8YCg0a75fZpNtyuCTH
	9jV7SrN12V6QhfDNxOjprSZrnSfz0+Jc09lh2aBMrzzAk7/F0L9pVvCAiCo8mmimZ56ouvXtNxCDU
	ReIUYiXSnDm0RsMx6S1D+5Xm7zb5atNpUViMAUWidzBefI8NhHvrxVT0PIgT7CSQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vxkwP-000000083nN-3DkK;
	Wed, 04 Mar 2026 13:03:01 +0100
Message-ID: <8669fc9bcc8250ec71ddb293da5022881ba714a8.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 15/16] wifi: cfg80211: add LTF keyseed
 support for secure ranging
From: Johannes Berg <johannes@sipsolutions.net>
To: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Date: Wed, 04 Mar 2026 13:03:01 +0100
In-Reply-To: <20260304071538.3833062-16-peddolla.reddy@oss.qualcomm.com>
References: <20260304071538.3833062-1-peddolla.reddy@oss.qualcomm.com>
	 <20260304071538.3833062-16-peddolla.reddy@oss.qualcomm.com>
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
X-Rspamd-Queue-Id: 173EC1FF747
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32467-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Action: no action

On Wed, 2026-03-04 at 12:45 +0530, Peddolla Harshavardhan Reddy wrote:
>=20
>   * @NL80211_CMD_NEW_KEY: add a key with given %NL80211_ATTR_KEY_DATA,
>   *	%NL80211_ATTR_KEY_IDX, %NL80211_ATTR_MAC, %NL80211_ATTR_KEY_CIPHER,
> - *	and %NL80211_ATTR_KEY_SEQ attributes. %NL80211_ATTR_MAC represents
> - *	peer's MLD address for MLO pairwise key. The link to add MLO
> - *	group key is identified by %NL80211_ATTR_MLO_LINK_ID.
> + *	%NL80211_ATTR_KEY_SEQ and %NL80211_KEY_LTF_SEED attributes.
> + *	%NL80211_ATTR_MAC represents peer's MLD address for MLO pairwise key.
> + *	The link to add MLO group key is identified by
> + *	%NL80211_ATTR_MLO_LINK_ID.

I think this is a bit misleading=C2=A0since it mixes up the key attributes
now. I think at this level it should refer to %NL80211_ATTR_KEY instead
of the specific nested %NL80211_KEY_LTF_SEED.

>   * @NL80211_CMD_DEL_KEY: delete a key identified by %NL80211_ATTR_KEY_ID=
X
>   *	or %NL80211_ATTR_MAC. %NL80211_ATTR_MAC represents peer's MLD address
>   *	for MLO pairwise key. The link to delete group key is identified by
> @@ -5602,6 +5603,14 @@ enum nl80211_key_default_types {
>   * @NL80211_KEY_MODE: the mode from enum nl80211_key_mode.
>   *	Defaults to @NL80211_KEY_RX_TX.
>   * @NL80211_KEY_DEFAULT_BEACON: flag indicating default Beacon frame key
> + * @NL80211_KEY_LTF_SEED: LTF key seed is used by the driver to generate
> + *	secure LTF keys used in case of peer measurement request with FTM
> + *	request type as either %NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED
> + *	or %NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED, secure LTF key seeds wil=
l
> + *	help enable PHY security in peer measurement session. The correspondi=
ng
> + *	keys need to be configured before hand to ensure peer measurement

"beforehand"

> + *	session is secure. Only valid if %NL80211_EXT_FEATURE_SECURE_LTF
> + *	is set.

NL80211_EXT_FEATURE_SECURE_LTF already exists today, and is set by
iwlwifi/mvm, so I'm not convinced you can just redefine it to mean also
LTF key seed is supported?

> +++ b/net/wireless/nl80211.c
> @@ -983,6 +983,7 @@ static const struct nla_policy nl80211_key_policy[NL8=
0211_KEY_MAX + 1] =3D {
>  	[NL80211_KEY_TYPE] =3D NLA_POLICY_MAX(NLA_U32, NUM_NL80211_KEYTYPES - 1=
),
>  	[NL80211_KEY_DEFAULT_TYPES] =3D { .type =3D NLA_NESTED },
>  	[NL80211_KEY_MODE] =3D NLA_POLICY_RANGE(NLA_U8, 0, NL80211_KEY_SET_TX),
> +	[NL80211_KEY_LTF_SEED] =3D { .type =3D NLA_BINARY, .len =3D 48 },

This probably doesn't do what you think it does, unless you really
wanted that it's *at most* 48 bytes. And please add a define in
ieee80211.h for that.

johannes

