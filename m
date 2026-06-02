Return-Path: <linux-wireless+bounces-37287-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLalBKh7HmrejQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37287-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 08:43:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B8F629213
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 08:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C96633013A76
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jun 2026 06:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB912F5321;
	Tue,  2 Jun 2026 06:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="GW9YLL4m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABADD2D839C
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jun 2026 06:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780382280; cv=none; b=GI1HZZNqqDJdxRLDu8wbJz6IyWCnupty9lTF3z8aFGuWS5Pn5ufeTqT0VlpLWkkhBt3qBoE5NrRUI7cOhpJJ3NX+BFp4dcFgCvkWS27KsawLiGczRIeCD7zdM4+8j5xziD59E/5SwzSKmYx6UZvDyBAb+CepZwI2qkV++IFEfu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780382280; c=relaxed/simple;
	bh=oXHB2PTM91X25SYgcPuCNSLkybx3081I2THo4oUmCX8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VC0+IOX8Dhz1k9DSOjecBDs8St3Zb0QWBWuHRiXBzOQgNCH2BlugOHKZIKlikaIez+43xt8ys/lL2YtFn27Y3BTL8sdlhHuj7vUfvI/9gMeMQwDldYtM1+DbmEpZomyvesYijrurTZ4aXfxYmAMKFEZbTOjtg5xS0US0uhtpBRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=GW9YLL4m; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=oXHB2PTM91X25SYgcPuCNSLkybx3081I2THo4oUmCX8=;
	t=1780382277; x=1781591877; b=GW9YLL4mf3hj7GYVHgeq9FFTZ6v17ISnDKDW/YvhoiIJ9wu
	ZtvenHsVmbKBxBWsPYYWjZpud9+XGLIpLZnzwv74CD4of2rFq1Gs/vq8ijS6hWTAnrG07YfFsZbs/
	qKLwq8UXbT54GySWxZnR2hC7LwX4c2jLMznkiwGpcpvyMuGYsF1rQSH9RX7AYVf83pmKPT19MnDA6
	k2pMfTJNnJ+cj5V653lPS4kJG1sw8ZX6coIWRbwdyKANZ8lHat3CDGmzUUpMpfxGJNpnl6TdrIpII
	LXOOUuhGhJMvmv+EacoDfYxDVOgLg7sfo77G0PnTFobACeFRgmfqVKmHAw4ooqzQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wUIl3-0000000F6TT-29oB;
	Tue, 02 Jun 2026 08:37:49 +0200
Message-ID: <d6e543046d8b2ba7e681c137a23a55a21f4d19e0.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: mac80211: basic S1G rx rate
 reporting support
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Tue, 02 Jun 2026 08:37:48 +0200
In-Reply-To: <2enlvwdxco5ezmpfosvvp3frreharqiiuspf67veztsmjwfcbd@rk3ej7yh4wow> (sfid-20260602_083218_948804_6C255FB9)
References: <20260602062224.1792985-1-lachlan.hodges@morsemicro.com>
	 <2enlvwdxco5ezmpfosvvp3frreharqiiuspf67veztsmjwfcbd@rk3ej7yh4wow>
	 (sfid-20260602_083218_948804_6C255FB9)
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37287-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 73B8F629213
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-06-02 at 16:32 +1000, Lachlan Hodges wrote:
> On Tue, Jun 02, 2026 at 04:22:24PM +1000, Lachlan Hodges wrote:
> > Introduce basic rate encoding/decoding for S1G stas such that the
> > usermode rx reporting is relevant as it currently uses VHT calculations
> > which are obviously wildy different to S1G. Sample iw output (with the
> > associated iw patches applied):
>=20
> Johannes, there are obviously some driver changes associated with
> this - I'm not sure if you prefer these to be included in the v3
> since I have to fix some things anyway or scope v3 just to review/bot
> fixes and then send a subsequent pull request once it is in tree. I do
> not really mind.

Unfortunately, given demands on my time, I don't think I'll be able to
merge the driver for 7.2 since that'd have to happen in the next week or
so. I think it's fair to just include them in v3, ideally once this
patch lands, maybe I'll get a chance to restore the build bot too.

johannes

