Return-Path: <linux-wireless+bounces-35232-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMRjFnIo6WljVAIAu9opvQ
	(envelope-from <linux-wireless+bounces-35232-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 21:58:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB8844A574
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 21:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59E5B3093252
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 19:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D214F3F2114;
	Wed, 22 Apr 2026 19:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="GY/ILvhq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347E22D592C;
	Wed, 22 Apr 2026 19:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776887878; cv=none; b=quJ+7qnySOmNkdsY63SMevSf11pMpJg88m4wzYtxazAcKhV8Mfd1O+kv0j2KJzUT3YhnY6M7Fb084H/cS0HrTQIcdGYNAq5Tz9iUV873rs/zFdR/r2mYguKIY+Y/cCZlni7WCYVkDixXG0blr8rk0MbLZIm2RRwY6jnZLzn83CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776887878; c=relaxed/simple;
	bh=6UAA4fcf16A0rgBIGMrBM6c5x8FsXnXfuwBOJ/qpMMY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e46MSPdturjUwrC1pEiW2jp55SSkqtT67Dk4KxyPO1Z4dCm83VcJ5xks5aDqvaAWLUcno/8ed3gkfeQpaxPpJXXJxhrG76mMK6ua6Q93xeZJP3rAJgqX1Vl6d91Vi/wEjgr4TmpCje2cI0WwGOVtPBgDzQiah7JDXKzEzKisHP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=GY/ILvhq; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=6UAA4fcf16A0rgBIGMrBM6c5x8FsXnXfuwBOJ/qpMMY=;
	t=1776887877; x=1778097477; b=GY/ILvhqONV7+0D5n9E2SETfiF5ZluqKcXh/SOOcACNVgka
	tQ6SbzC1AvwTu7fPUGTauE6n+Dm8TYQgZTBeZszWFMGpq2gWm7EfK/5j2B/zzvwWkz5bWdfOGhG1K
	5Hsb0uzXdhhCImwEkPlvqQahYEjmKhVLibwTpQDTuu4dHuFTPZdGUTe33gjH9S13KHnblhTXBiIPk
	tjZ6ouTk1rHxpf+wFjwhb6PTmUWpSP5px2vH8vHOOFSyp6uMlno+e09MrtLqX+d7M3UJmqbBQxZ72
	3nwFzOiobncGmq5mEudoYxtDy1F7DaaUp3x96nfJsGJvcB57ztrhiLpClYnZ7pJA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wFdhq-00000006U5o-1pEs;
	Wed, 22 Apr 2026 21:57:54 +0200
Message-ID: <30b51a051a7ddec5fc5ec72a685789594c7440df.camel@sipsolutions.net>
Subject: Re: [PATCH v3 3/6] wifi: mwifiex: fix OOB read from firmware
 sta_count in station list response
From: Johannes Berg <johannes@sipsolutions.net>
To: Brian Norris <briannorris@chromium.org>
Cc: Tristan Madani <tristmd@gmail.com>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
Date: Wed, 22 Apr 2026 21:57:53 +0200
In-Reply-To: <aeknaNDFrmtuTQP1@google.com> (sfid-20260422_215422_757833_CC97E4F5)
References: <20260421134938.331334-1-tristmd@gmail.com>
	 <20260421134938.331334-4-tristmd@gmail.com> <aekS72ESOUlnqGIo@google.com>
	 <2e20cb23d2d156963c2b687c4c51635e5eec2c7c.camel@sipsolutions.net>
	 <aeknaNDFrmtuTQP1@google.com> (sfid-20260422_215422_757833_CC97E4F5)
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
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35232-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,talencesecurity.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1AB8844A574
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-22 at 12:54 -0700, Brian Norris wrote:
> > But regardless, I question the sanity of checking the size against the
> > size the firmware said the whole thing was going to be, rather than
> > checking against the actual buffer size ...
>=20
> Admittedly, I get lost in this driver sometimes...
> ...but I think you have a very good point. AFAICT, we never do anything
> to check the size of adapter->curr_cmd->resp_skb. We generally assume
> it's big enough to fit 'struct host_cmd_ds_command' (since we allocate
> it ourselves). But we don't ever go back to check these
> dynamically-sized fields don't overflow it.
>=20

There are some (response) buffers where the size is checked before
copying, but I didn't trace this back further than the SKB coming from
pcie/sdio/usb, but I don't see any check of the firmware-advertised size
vs. the actual skb->len.

johannes

