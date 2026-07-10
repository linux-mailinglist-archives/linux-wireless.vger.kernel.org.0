Return-Path: <linux-wireless+bounces-38843-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dMxzDruTUGqC1wIAu9opvQ
	(envelope-from <linux-wireless+bounces-38843-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 08:39:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EDF737C21
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 08:39:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=RCcNiaGd;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38843-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38843-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D18DC300C03D
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 06:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAF83B19B5;
	Fri, 10 Jul 2026 06:39:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC153A3816;
	Fri, 10 Jul 2026 06:39:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783665588; cv=none; b=bqPQI2njVNVkSYLFOicVvoqIwhwsyMoph76qCpOqpVjnbF8JS5KTo545ufRx2sFRcqwuJWmBwoV0xKIbi8XohqZYk9vh+Es4gCvagkHVzilHuWVbRhmnov571gBKN6LL8VubeL+GMwXe+uDpnv3yOJ/Hrl4b/MZW8sPgbm94azc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783665588; c=relaxed/simple;
	bh=uvwC1xV5faI68gjI1weMPLwe8itefRUthxTz0voFJps=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xaijj2gbTJGyLUUFJwfCqH7EowSBpMoORHeJ8flBnPMXAthYf2PjYMVV9vtuYbC7tFhQVLjcHd4vc2kxCUlKWeNqSYnp4Y/VosyPhW6kFYYF8SCtlMiawDx5lNxLO1/D5g897TZcdBKJSNP4shwJ+Xcv11PYcUkqhRMgTJGrnzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RCcNiaGd; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=299SMD9UDfkbdGNtEVQk7Hr4iqxQ+YQoz1GOFSUth74=;
	t=1783665584; x=1784875184; b=RCcNiaGdf9O21eaVXqqjJ0glz5x/r51wOvNUuXtQ12lBgoA
	94qoDwGNPI2yRGkQN8hA8wLVvvs6d4xlc6S6ttlZpuOk+7ab3anmFTVTUTaQB2icQmQLoqEicRNSX
	23QQmWXTRosO+xSTqx3E+la9y4o1Gs4ZEuWd1DlVZcRNhhjZ3cMdZr4v0CIn/8X8KLI5ztdmHBbFh
	ObTzkYjb56vzlEp8Rw+wceJaomJAJqdE+wV6QJZq+90rPUHMPY1ME9IAGx+k6jvi4pH6H03+4L6bR
	PI0U002ecUAnt/XNz6IdaBpeopHg4yi9D+DoAMs5/gmWC8T5s9ByBO+XOpzMsmDQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wi4th-0000000CFI1-30uo;
	Fri, 10 Jul 2026 08:39:41 +0200
Message-ID: <6be574903752d95ae7125461c38cc30b8a641d24.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: validate IEs in cfg80211_wext_siwgenie()
From: Johannes Berg <johannes@sipsolutions.net>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+cc867e537e4bd36f69bb@syzkaller.appspotmail.com
Date: Fri, 10 Jul 2026 08:39:41 +0200
In-Reply-To: <20260710024637.16729-1-kartikey406@gmail.com> (sfid-20260710_044649_032516_DA33F864)
References: <20260710024637.16729-1-kartikey406@gmail.com>
	 (sfid-20260710_044649_032516_DA33F864)
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kartikey406@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzbot+cc867e537e4bd36f69bb@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-38843-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,cc867e537e4bd36f69bb];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sipsolutions.net:from_mime,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 95EDF737C21

On Fri, 2026-07-10 at 08:16 +0530, Deepanshu Kartikey wrote:
>=20
> +bool cfg80211_validate_ies(const u8 *ies, size_t ies_len)
> +{
> +	size_t pos =3D 0;
> +
> +	while (pos < ies_len) {
> +		if (pos + 2 > ies_len)
> +			return false;
> +		if (pos + 2 + ies[pos + 1] > ies_len)
> +			return false;
> +		pos +=3D 2 + ies[pos + 1];
> +	}
> +
> +	return true;
> +}
> +EXPORT_SYMBOL(cfg80211_validate_ies);

I don't believe you'd need to even export this, and we also already have
validate_ie_attr() in nl80211, written in a better way too...

johannes

