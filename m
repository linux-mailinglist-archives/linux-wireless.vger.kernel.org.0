Return-Path: <linux-wireless+bounces-33732-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCOGDqSFwWn+TgQAu9opvQ
	(envelope-from <linux-wireless+bounces-33732-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 19:25:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE022FB400
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 19:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E6A131EEA0B
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 17:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5BC3C9437;
	Mon, 23 Mar 2026 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KL9VjUyS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD3B3C942B;
	Mon, 23 Mar 2026 17:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774287285; cv=none; b=cmM3G0fo8nCOBXrNCRrL0UCOEsgAjeka3FFHKlEkZhxHb2yhrQwo7JisDHtxxB0gBm7bCg2xTI7NScfN1/ow0cmigArpuH8FWLZqcQ8YkdXBarAptgfM6586fKTOxDnWS5lq/7q4MORruU0NdjmI3IAzwyaoWhRX8g0UQ/a+ylY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774287285; c=relaxed/simple;
	bh=Ve6Vu4L8M5YwWgfg5zLwgagP8Xk8na5cBsOyTuyw63w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iQ3Z9gUaePXTiSdzrbtgOutS8LKD0ICuXJ2XyJBoy4lw7qeDYScuQo1wM5+b2L10dyv9+Cu6qoZf/8KCsteYvGcMx/nUm4S0S/4IDdZn7QoHAdy3PoDeQTubZbw09FiFi8WLubB/Bu2g2HsscAw3hve446Lk4b5as7XxBBZzaks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KL9VjUyS; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Ve6Vu4L8M5YwWgfg5zLwgagP8Xk8na5cBsOyTuyw63w=;
	t=1774287283; x=1775496883; b=KL9VjUySmEqr5tBETvB5pnQCdGWl1/mXDupqNn74E0+X9oC
	UY2PU7YpCPvcz3ZR3JqBht18ilofplbYX2rIyUhvH6eTCdmm211zVW6slE86OmIsSxTtZfg4MKBhR
	1zmWB3kHDm444j0feNSzbh6/S3gSVFLrNxMpC4IuPKuLY03fn6ND4ueKf2LpcxuBuChd8otOxN3R3
	BhldQOG/dfUlpJflFa8uOyN7QmtPSl9jEf5x9YC6mU87rMfCuBFuXrQElkLYArLMUE+sbRoYhjqpE
	Sw2xjMrf3OuS4tKPboVdpV24GDoOi03BWhXDiW1F+qnBv20kNvNsatf7daPG2tXQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w4jAl-00000009uiG-2yEA;
	Mon, 23 Mar 2026 18:34:39 +0100
Message-ID: <cc6ca8d987b69277f084bdca4df56660d04cba6a.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: Replace strncpy() with strscpy_pad() in
 drv_switch_vif_chanctx tracepoint
From: Johannes Berg <johannes@sipsolutions.net>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Date: Mon, 23 Mar 2026 18:34:38 +0100
In-Reply-To: <2cc7113dfe94622c1e8e482948f26d9268ef2538.camel@sipsolutions.net>
References: <20260323172015.work.146-kees@kernel.org>
	 <2cc7113dfe94622c1e8e482948f26d9268ef2538.camel@sipsolutions.net>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33732-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: 1FE022FB400
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 2026-03-23 at 18:32 +0100, Johannes Berg wrote:
> On Mon, 2026-03-23 at 10:20 -0700, Kees Cook wrote:
> > ring buffer. Since ring buffer entries are not zeroed on allocation,
> >=20
> > No behavioral change: since interface names are always at most 15
> > characters plus a NUL terminator, strscpy_pad() with size IFNAMSIZ (16)
> > produces identical output to the original strncpy().
>=20
> This doesn't add up - if it's not zero-filled on allocation, then it
> *is* a (desired) behaviour change?

Err, no, never mind, it's str*n*cpy() now...

johannes

