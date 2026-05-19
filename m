Return-Path: <linux-wireless+bounces-36645-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPVrG3MMDGqFUwUAu9opvQ
	(envelope-from <linux-wireless+bounces-36645-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 09:08:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CBB578AA8
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 09:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07BC83044235
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 07:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525BB38A738;
	Tue, 19 May 2026 07:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="SAvInOgf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BA52F83A0;
	Tue, 19 May 2026 07:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779174157; cv=none; b=WIAIYKCKkFqaiB1vgCW8XIRiE7C9JrRH759Sx0SbdcXDf3A1e0gaGzBR0hOI7XcDOjHeoKWk+dJPakcPh9NTjJ8/gHyWeGT6fREiuwBjaliy8nvGasmwQdOswpf/Re5x0kmNJ2Bi4re2lzyjpwxIBZ5FyUiKn8wdy3zQaWHVsqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779174157; c=relaxed/simple;
	bh=6PoyY0m7W6XKHBGJZRQ61x55K0oEosn/NInIgnJN9FM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mDOFNTB8dPEUPSt8NzSApyOyqrIPsuJ5EygUH8HfjAS0t/P9oPhRwZViDrp+Rk+K4Xwocb13rbDH4OR7/4vo0S5HDuYyz6EbOBJHOC5G47Bjvx4so4dADvN5BZ8UhI6GkrsJwfIROidwWbFRoI2i3MsltYhx3dqBkA+FbBVl6lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=SAvInOgf; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=w9roBW/hrwP1cQbCmYo3jAZ+BV7bIoSQT26LbPLuzVE=;
	t=1779174155; x=1780383755; b=SAvInOgfDIsNcw4Y0HJKUllcU/q+sEB2AHE9CuqyTGtV8+T
	88Gl7ylmRt1Tha7ogzewFwpn7gNYckHbwGqVAUWENrLaHfnIx1z+3v+prW/klQLxqMM3uZ8xt3mJO
	X7uP5Uve+Nu/99s+a3JRWqZkoo+BVVDaSprbN5u0twzut6HO3LDFD0WciTgPASliQHOwyy3EPvtPd
	oJWhQzcsNAk5Ku6EVsDGU9mlfXzSfbnjtI0tJ4gz3YBc9d5XIC3+m5mazidu373OzAh83DhrNxBvB
	BXTbGeJY4v2/ETquiEjf/JszeTXumqFVzOkgmZaWeILUjl/I8BGy+PjFX1Ps6Kdw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wPET9-00000005kRd-2TEx;
	Tue, 19 May 2026 09:02:24 +0200
Message-ID: <58d6ee4054473af391eb5ae8b4382e6964dc3ab6.camel@sipsolutions.net>
Subject: Re: [PATCH v3] wifi: mac80211: fix monitor mode frame capture for
 real chanctx drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: Devin Wittmayer <lucid_duck@justthetip.ca>, 
	linux-wireless@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Oscar Alfonso Diaz
	 <oscar.alfonso.diaz@gmail.com>, fjhhz1997@gmail.com
Date: Tue, 19 May 2026 09:02:22 +0200
In-Reply-To: <20260518170147.13885-2-lucid_duck@justthetip.ca>
References: <20260308164510.5927-1-fjhhz1997@gmail.com>
	 <20260518170147.13885-1-lucid_duck@justthetip.ca>
	 <20260518170147.13885-2-lucid_duck@justthetip.ca>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36645-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,vger.kernel.org,gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:mid,sipsolutions.net:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E8CBB578AA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Devin,

Please don't nest the threads - it gets confusing quickly.


> +	} else if (local->emulate_chanctx) {
>  		chandef =3D &local->hw.conf.chandef;
> -	else
> -		goto fail_rcu;
> +	} else {
> +		struct ieee80211_chanctx *ctx;
> +
> +		ctx =3D list_first_or_null_rcu(&local->chanctx_list,
> +					     struct ieee80211_chanctx, list);
> +		if (!ctx ||
> +		    rcu_access_pointer(ctx->list.next) !=3D &local->chanctx_list)
> +			goto fail_rcu;
> +		chandef =3D &ctx->conf.def;
> +	}

I'm sure we can basically get rid of the "emulate" check now, because
emulation will always lead to exactly (zero or) one channel context(s)
being present.

And then it's equivalent to my original v2 patch:
https://lore.kernel.org/linux-wireless/20251216111909.25076-2-johannes@sips=
olutions.net/

(even if that expressed the logic somewhat differently)


And that version was _definitely_ reported to crash. So what changed?
Could you do some investigation if mt76 got bugfixes in this area
perhaps? Or are you just using slightly different devices than Oscar?

johannes

