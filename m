Return-Path: <linux-wireless+bounces-35273-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMzYG8J262kQNAAAu9opvQ
	(envelope-from <linux-wireless+bounces-35273-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 15:57:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B60BC45FDF8
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 15:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 799973012C69
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 13:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CC93DA5D6;
	Fri, 24 Apr 2026 13:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ne0MDl6Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D553D6494;
	Fri, 24 Apr 2026 13:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038957; cv=none; b=L9fXET5kEojQWFeT5OIxrUneYEu1+iU0gp5O0q2s6N+ss1XacBeXkDxSj9dkp83tWU0HoGo/RtofYzioX5UigvIyRxhS3reqS8HcM06Q+C//nlD/egqgodOdqn4psH4v9UE63ML3mre15TDa0GSdvY+yRFN+iw3hZix1vzyycEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038957; c=relaxed/simple;
	bh=KIOumPPfyu6yk1E11eobp+/yQImq5ZMrtuLQbYTpbWg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KBmWAWX2V7pB07hB5a5d5+PW0CblEBNvzQmPx58/mTTT47XA8dsRcZd1VQAj+2Mw7tQAq6/I4XFbRE0DavqKm8hLCMdFPdi3cPhb7osE1b4gIJKEU6Dkur19LlE0GYF4wd5H/InjUGhJ6YlcYC1EXi83DnyspmVFbXVeMLgMbcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ne0MDl6Y; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=KIOumPPfyu6yk1E11eobp+/yQImq5ZMrtuLQbYTpbWg=;
	t=1777038953; x=1778248553; b=ne0MDl6YNHkbNTEx18nSiYon5yVqqe17SpU7X8oajDIXzeU
	8BqMqFrfD0D5HFKszOxsbxGsobz1jJ7bdfBtWtWBNx5OmgxA2TUkEQG3dUD5OjVo83lchHou64i3C
	PR8Ph4+J8XinYQcBo77P2Z76ekk5MpzUtoCiTcEG4oN+4n1ep4oCFj1ibscSWFX07OC6ZYgPGe9tm
	zsXZJTy8cAj8+dDpHKzfG1flp7GFgU8LJmB9BWGhZQM7XxRdu2p9YPs11iv2U+u1VHSbD5810NMt7
	scw5u+d4UegM3fbM/+jpAitm5es8uaZ6IqstEyPMf0Ak9Dfjr61SJAorwJkN4GQw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wGH0V-00000009Gi4-3K93;
	Fri, 24 Apr 2026 15:55:47 +0200
Message-ID: <9f7df38831598001ac6cd79ab4fb95b4b6e042fd.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: restore monitor injection when
 coexisting with another VIF
From: Johannes Berg <johannes@sipsolutions.net>
To: Brite <brite.airgeddon@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, fjhhz1997@gmail.com, oscar.alfonso.diaz@gmail.com
Date: Fri, 24 Apr 2026 15:55:46 +0200
In-Reply-To: <20260424120807.25005-1-brite.airgeddon@gmail.com> (sfid-20260424_140854_559281_CA03D57D)
References: 
	<CA+bbHrVWmSpWZ9GBVJ5vffh1qYEye=EWMq9tKA-_uzfW+raC8A@mail.gmail.com>
	 <20260424120807.25005-1-brite.airgeddon@gmail.com>
	 (sfid-20260424_140854_559281_CA03D57D)
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
X-Rspamd-Queue-Id: B60BC45FDF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-35273-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]

On Sat, 2026-04-25 at 00:08 +1200, Brite wrote:
>=20
> Earlier attempts on this thread addressed the same bug but had side
> effects - notably full VM freezes during the airgeddon evil-twin flow,
> reported by =C3=93scar in the thread. This patch takes a different approa=
ch
> and has not exhibited those side effects across the tested configurations=
.
>=20

I don't believe that all this complexity is necessary, and the code
changes have are fairly clearly LLM-created w/o such disclosures.
Dropping.

johannes

