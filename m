Return-Path: <linux-wireless+bounces-35687-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFegJGn/8mkvwgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35687-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 09:06:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4B049E61B
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 09:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A5EB3007E3F
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 07:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A3A395259;
	Thu, 30 Apr 2026 07:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="PJbiFc+Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62F9394798;
	Thu, 30 Apr 2026 07:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777532741; cv=none; b=foYD6Ff0zKxjkRuL2nB5ykqUSkWrgtqIuAoOhmb6fChIBdKUy4whz1CxbQ9Hg1uDh/FwN4SAtc0FK5AJf4SBLMAmiCeZT+Z9jTdbQFWW/3taA2m0KvcXDALzJxn+tesu/kV12LHjIRzQBU9MjF34KX6hBvuYKhmZSPVlUOk5kLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777532741; c=relaxed/simple;
	bh=k2pwff6oo7bTuT+zz7RY8JKMX3XRSkhz5wH2RIUnkKI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MKyRBdzJPfInBNXH+d0rvvcU3bgbTPNSI5nsDd3sFkTyMwX1kxNaX74CaFqH/ux+I0FRY09pW+PN5Orn5cIfTa7eM0BKt+qSqi+nvZL2ikS6EAdI2PTO3mMW8ynjtMCxktdj91N3rRWe+kTt8ez/BeBFtyQZBb8s6pKsj2sIQwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=PJbiFc+Q; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=q/9OgC78EWz9WsFacrGBJ1j2N2j6TZfN8SwiNLPcNN8=;
	t=1777532740; x=1778742340; b=PJbiFc+QVfgYisNpus79PWr85YGM2fjMmZkvLEf5n9qH6V2
	Lip0ZtUbURXs9nnPPsPF1OPP6cvf/Qry+Y6Dg0oa47w/4IXEf3z2EJLSnR959g6OaeqgV5Quldum9
	O1ese9/XdD3yaE4UJ2WrB8RToYnrODU9KeaZ2M9+BDnGf1heUH+dUje/9gJju7RQb0ScI+L2fS9Is
	EI98zJrvUD9ahJuNfQgE2hW5iHQFoNhKgPm6+u4mHqMVEF0dIjdUB/N4rHHZ/J4/IGxU3Lhc+n8xp
	8dPTaRrcIXvS0WyRzTwFvnC7IqS0CvnfQVg3XMiNB65roEJ+M6YQiJIKPAyVCFnw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wILSq-00000004etF-2MSO;
	Thu, 30 Apr 2026 09:05:36 +0200
Message-ID: <fd142d26dbc632b26fe39ba8be29d4915a9f92d6.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: don't allow negative key_len values
From: Johannes Berg <johannes@sipsolutions.net>
To: Dan Carpenter <error27@gmail.com>, Kalle Valo <kvalo@qca.qualcomm.com>
Cc: Raja Mani <rmani@qca.qualcomm.com>, Vasanthakumar Thiagarajan
	 <vthiagar@qca.qualcomm.com>, Jouni Malinen <jouni@qca.qualcomm.com>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Date: Thu, 30 Apr 2026 09:05:35 +0200
In-Reply-To: <afLzlDT5VF4D746w@stanley.mountain> (sfid-20260430_081554_647821_E5F802AD)
References: <afLzlDT5VF4D746w@stanley.mountain>
	 (sfid-20260430_081554_647821_E5F802AD)
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
X-Rspamd-Queue-Id: 1D4B049E61B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35687-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FREEMAIL_TO(0.00)[gmail.com,qca.qualcomm.com];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]

On Thu, 2026-04-30 at 09:15 +0300, Dan Carpenter wrote:
> The ath6kl_cfg80211_add_key() function has an upper bounds check on
> params->key_len which ensures that it can't go over WLAN_MAX_KEY_LEN but
> it doesn't check for negatives.  This could potentially lead to memory
> corruption.
>=20
> Put a bounds check on negative values in cfg80211_validate_key_settings()
> to prevent this sort of bug in the future.

Clearly this commit doesn't seem problematic, but I'm not sure I see the
path to it mattering? The key_len should only ever be set by
wext/nl80211, and that can't really end up with a negative length?

We should probably just make it a u8 there, no way it's ever bigger than
that, but I'm not seeing through why this would matter much right now.

johannes

