Return-Path: <linux-wireless+bounces-36315-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGFICz31AmqfzAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36315-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 11:39:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C68D51DE2E
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 11:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1134C3014770
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 09:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742AE3C3BF6;
	Tue, 12 May 2026 09:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qt1PoSHM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133153B95EC;
	Tue, 12 May 2026 09:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578600; cv=none; b=a/9Zb5EWhg45IsM955QiFBj/3I81M/RkFrajYEuKg4BoKQQx9BId3bcSTprPgQIEt7R2KgdUaXXPCoA5P6LRcRYbscz6IqS0skBYcwBW06BoPbyTVgwsb6FS5Muh1ip8l9CkyuhJjxgYhqUYbuuPnzHHhNZTbvvKUPIUnsdFsmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578600; c=relaxed/simple;
	bh=5imsN2GRDgEnQmP7IgCKhWEjk3S4UBKSkBhZKZxcuhc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZjjPuSSOW7XjD6UOEkOOh9oZ75c1sP/crwOb2FUH0wUCmx2P22OfAj9suqh6Rr9XKYshwZY4jmb4XjA+RJhYHRIcrMj0VtdEG+ufia0K+vwCaXA5JE+cZdoSpfAtZfch1+RrQt/6FA0WOUlW/n88CRvKtCcAd97gqwVbBAfmpSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qt1PoSHM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=5imsN2GRDgEnQmP7IgCKhWEjk3S4UBKSkBhZKZxcuhc=;
	t=1778578597; x=1779788197; b=qt1PoSHMIQrbMiHdMDsu7n+0b0GPztxL9ywEYXpHK0sRWsN
	o+x3PEdXgEuy8OcoUzPjBvqY6wT+seJ+5NrxP5maSztd5fObqY4hcyA6ct1TuJcw9Q8OSRZPEscPI
	+VlJ4HCEhjHMO8CyrEwhGOwAPkFAqyz89J5P8kYs0el5aah2WJp837fBzeho33hEFNmgEWX5JJ0AS
	Gnj6W7vkc8jbUibBK4sT050H3Qrg9P53ADbUh3iSCr7J7iKWDKzVYREXbKyD0W/EUCbGrtaTuPCm7
	QsdfM774aVCEvL5KrVP+sxbsYn6M4oYsEOpB+MTdlcT4HIECPfIhJN4Jp8W2ocag==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wMjXP-00000000KzB-10oU;
	Tue, 12 May 2026 11:36:27 +0200
Message-ID: <522d09d5fad2fdebc89419a7e75b89ff14de162a.camel@sipsolutions.net>
Subject: Re: [PATCH rtw-next v2] wifi: rtl8xxxu: Detect the maximum
 supported channel width
From: Johannes Berg <johannes@sipsolutions.net>
To: Thorsten Leemhuis <regressions@leemhuis.info>, Ping-Ke Shih
	 <pkshih@realtek.com>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Bitterblue Smith	
 <rtl8821cerfe2@gmail.com>, "linux-wireless@vger.kernel.org"	
 <linux-wireless@vger.kernel.org>, "art1310@proton.me" <art1310@proton.me>, 
 Linux kernel regressions list	 <regressions@lists.linux.dev>
Date: Tue, 12 May 2026 11:36:26 +0200
In-Reply-To: <02c073d8-d2c9-4faa-be51-9ba38247b24e@leemhuis.info>
References: <c57de68e-5d57-4c26-898f-8a284bb25381@gmail.com>
	 <ee88b3a2-2cc9-4370-b782-189a603a7fa1@RTKEXHMBS04.realtek.com.tw>
	 <41693ffc-926c-4e67-9a48-b6e1b1d150bd@leemhuis.info>
	 <f26992e669744e6f87084e017f897275@realtek.com>
	 <1cf071e9-5d3c-4d55-ac75-49eb4c461422@leemhuis.info>
	 <29a93dc3d9d24b3a809310694ffc5d34@realtek.com>
	 <02c073d8-d2c9-4faa-be51-9ba38247b24e@leemhuis.info>
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
X-Rspamd-Queue-Id: 9C68D51DE2E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36315-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,proton.me,lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, 2026-05-12 at 10:54 +0200, Thorsten Leemhuis wrote:
> > > You
> > > can cherry-pick or directly apply the fix to a pending branch (or eve=
n
> > > ask Linus to merge it directly from the list, but that is likely not
> > > worth it here) and git will normally later notice this and fully
> > > automatically handle everything when the fix comes in again during th=
e
> > > next merge window.
> >=20
> > I know git can handle that, but is it an acceptable practice for single=
 one
> > commit to appear twice?
>=20
> Depends on whom you ask. I'd say: It's kinda normal. It's best avoided
> if there is no need, but if there is a need (like here) it's fine. And
> some subsystems it even happens regularly iirc.

FWIW, it's generally frowned upon and actually uncommon enough that
linux-next actively warns about it [1] (or at least used to?), so I
wouldn't really say your description here is all that accurate.

[1] https://lore.kernel.org/lkml/?q=3D%22duplicate+patch+in+the%22

What does happen fairly frequently is the same immutable commit getting
merged through different branches, but that's a single commit, not the
same change being committed twice.

johannes

