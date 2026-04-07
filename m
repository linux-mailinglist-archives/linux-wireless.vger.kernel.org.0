Return-Path: <linux-wireless+bounces-34461-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIyeKy7i1GnvyQcAu9opvQ
	(envelope-from <linux-wireless+bounces-34461-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 12:53:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2103AD499
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 12:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D7813004D1C
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 10:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D0D39DBC6;
	Tue,  7 Apr 2026 10:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="IHbzPRca"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB64839A078
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 10:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775559210; cv=none; b=cFb14ZUjJbFNWh3sa5OQc6CBxNQeS5PILPk2Vam/7XrwzU0SwwY0XFkMkOxQSOSfW0MUFvwvabNGrEOr8ARExyvBNpP70VH5zxRyKfKHcQaDi9uCNMYzehjoZwt9yBqqNAk/MNmpcRxFhBjeg/zHGtj0Vr3FSaITPJHJKg/C9p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775559210; c=relaxed/simple;
	bh=XDq8IUBOMZ/I3s6fWDk5nV81cndoYuPsVNso8VMvhFo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J8eX/oameBUH5LiqJcEsNsbbIdp5eweSm0M1H4oRCCjN18p+BY9XN22dwwODNUjliUKBsgYLW6OA7KpRu7BwhUT7jhMeBAml+UDd1FV4Dl8q5kpjhd4J2U4Zx4ryIjcMOSlPpETBzTF7YIdQ5OPUuNNAiowrmyePoGVVuNZGvWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=IHbzPRca; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XDq8IUBOMZ/I3s6fWDk5nV81cndoYuPsVNso8VMvhFo=;
	t=1775559209; x=1776768809; b=IHbzPRcawnwX6STV8khpdzzFrGC7kc3yXnlb5jecnevsLrn
	yeGyciJrvCaxkJobjKG79AMPi8hU84j3zts4LWMO/0WQLEqP5xs9KH/IL7QcUGXvSe+pTI4yaUnyz
	Ad23yUezI1vXTyS8x92fJuJ2yN6L6pNMG1+YotqoLK+bNJdy/we7NYmiDUEt/otr95WBsRu2eU/ug
	olDQR58H1dGWJ7crhY2JyF+B+ec/tgdya2wzAN2D0aqdKLxUqUZ13qqKJvsRz1pO+YsPKs1j6eH+5
	QHaPSbM1WVZvIzHe6L6DtG1IKHoDPZJMgVDVCvLUT8igwipM9z6dAQDPelh6yN/Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wA43j-0000000CGjM-2NN4;
	Tue, 07 Apr 2026 12:53:27 +0200
Message-ID: <70f3e0d6f3467244e33ecd343fcfe3b22745f1f1.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: stop hardware before clearing driver state on
 reconfig failure
From: Johannes Berg <johannes@sipsolutions.net>
To: Masi Osmani <mas-i@hotmail.de>
Cc: linux-wireless@vger.kernel.org, Christian Lamparter
	 <chunkeey@googlemail.com>
Date: Tue, 07 Apr 2026 12:53:26 +0200
In-Reply-To: <GVYP280MB151883A5BB2910EE6439DE2F9453A@GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM>
References: 
	<GVYP280MB151883A5BB2910EE6439DE2F9453A@GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34461-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[hotmail.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,googlemail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: 6A2103AD499
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-03-31 at 12:00 +0200, Masi Osmani wrote:
> This patch fixes a hard system freeze (requires power cycle) observed
> when unplugging an AR9170 USB WiFi adapter while under traffic, or when
> any driver that uses ieee80211_reconfig() encounters a firmware deadlock.
>=20
> The race: ieee80211_handle_reconfig_failure() tears down station tables
> while USB RX tasklets can still deliver frames that reference them
> (use-after-free). Calling drv_stop() before clearing IN_DRIVER state
> closes the race at the root cause.

You can really stop resending this patch, I'm not taking it.

https://lore.kernel.org/linux-wireless/e7f3ba3acca1308bc0871a3892da9e15525d=
5038.camel@sipsolutions.net/

johannes

