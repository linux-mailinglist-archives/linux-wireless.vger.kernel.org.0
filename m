Return-Path: <linux-wireless+bounces-36643-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHO1LOEIDGo5UQUAu9opvQ
	(envelope-from <linux-wireless+bounces-36643-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 08:53:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B295786AC
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 08:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C4D4300517C
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 06:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD8039DBF4;
	Tue, 19 May 2026 06:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="eumPqLD5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5922F5328;
	Tue, 19 May 2026 06:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779173234; cv=none; b=ZNuUtBoodXXDryzgq5UPERdDBIrZxJ7+qg8xQfXs+hww1JoIDgksI18oED4A3HYlY8jR92r1y2k3/UM7wqeS5/antau1ehNC1TT2nodhEJwjOw898nV7nrs7OZCPmDTz9UaNrPLhooaXsU4Ys9wyLzFykh4+ARjBR5Mqu/FHYKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779173234; c=relaxed/simple;
	bh=vrj6Fko18jAQ9mc/+I4m/8uPi8+EZnj0viMa3oqdY6k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bg97qZM0fF25fekMCr1VWiyBm5x2mk2oMEdisNgxM8prUBB94+SChfo/5wPPc0hX0bE/5ZtiiUECKTuDrnilXPzkG7H/ZeDiQRCI1Ikbtb7akbpWlNkJifwg7+SBDvcqna+i5sicUqCXZl6mgG8kfpJ7YKve9FQ8xcMIr0JD/bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=eumPqLD5; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vrj6Fko18jAQ9mc/+I4m/8uPi8+EZnj0viMa3oqdY6k=;
	t=1779173232; x=1780382832; b=eumPqLD5Jy/0T1IufBtzjsUunIE3dA7C5QGvd0w0NCsk/pJ
	qNSC/L+MRlrb/SLByTg8HE0PAUAIz1j/Y7TDJWWv1yTqSNYkXmmycKIDkaKjeFe32Nyxdd1MG9DNr
	hMz3H2tTT9fU7ysxn63R14cspxDL3BMvipcIBIA07V5iCif7uqQ+daa6pNPDNDsNLdVF5m8/gLVd9
	EYWwc+IMQzqZCMUE9fWLGOz7IkF9yj4PKYrXYR/9dnf9T9qeM6lwWD8jYBQ9jTwRTN7Th9q20zxHt
	ZC/rx2lGdHlfDBlgDLgLDB1wypkSFxLXPK/9K2+J73LxRQT73HmTFeU5MuZ3qfyQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wPEEH-00000005hvB-2kEw;
	Tue, 19 May 2026 08:47:02 +0200
Message-ID: <1e77da9180ee82bf1b0d122f0ddf137949d4278e.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: mwifiex: Use flexible array for RX
 reorder table
From: Johannes Berg <johannes@sipsolutions.net>
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: Brian Norris <briannorris@chromium.org>, Francesco Dolcini
	 <francesco@dolcini.it>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
	 <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, "open
 list:KERNEL HARDENING (not covered by other 
 ""areas):Keyword:\\b__counted_by(_le|_be|_ptr)?\\b"
	 <linux-hardening@vger.kernel.org>
Date: Tue, 19 May 2026 08:47:00 +0200
In-Reply-To: <20260518211826.11245-1-rosenp@gmail.com>
References: <20260518211826.11245-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-36643-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 32B295786AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Rosen,

On Mon, 2026-05-18 at 14:18 -0700, Rosen Penev wrote:
> Embed the RX reorder pointer array in struct mwifiex_rx_reorder_tbl
> instead of allocating it separately.

Others might disagree, but personally, I think you should stop doing
this. Sure, it *might* (I've been bitten too much by __counted_by) be a
border-line improvement, but it's not _really_ all that useful,
especially on these older drivers.

Did you even test it at all?

And then especially

> Assisted-by: Codex:GPT-5.5

if you do it this way, you're going to be able to produce such changes
with way less effort than anyone can possibly review. And since for all
of the fringe drivers the review falls on me personally, well, I'm just
not going to keep up.

If you _really_ want to help, please help review changes rather than
producing more noise. Maybe even take over maintenance of some specific
driver that you can test.

johannes

