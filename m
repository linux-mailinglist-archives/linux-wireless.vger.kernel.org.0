Return-Path: <linux-wireless+bounces-33731-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBAZC4x7wWknTgQAu9opvQ
	(envelope-from <linux-wireless+bounces-33731-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 18:42:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D27A02FA424
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 18:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A0F683053755
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 17:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAAA3C8711;
	Mon, 23 Mar 2026 17:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="llT+5beN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77F739182F;
	Mon, 23 Mar 2026 17:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774287153; cv=none; b=P9xPgAKpG82JF/8NP9g3GhIpHAcUn+AAa4iU0o5LQQURg6be8Sg4m+gIXquzFmJUd50jXLciWPN4j1BpHZGkVbWcT+cHq7xUcAvbr4j+QNg4cxJUKS2GBGWfe60arDMsfi3BTPA1GrAv8VmwD0F/WMv/TV2tySQsomCqa5Q2YnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774287153; c=relaxed/simple;
	bh=YPa7MiRsFFwpeZH158DqO9YLhdCCTsOn2F8zO6aBrTk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VTJbZXnsRJgqNHbEdsvxcoIFqJA+vInuivu3IlZFhmZ751NGOodDM1DMugXk96CDrLEuSD10nXJSoaFdydMLr0dqHyUg7gB92aPuo8AuuacLL3x6VoEXsA3qHcgY4WNPyYAt9XZN1HW4koAeWKvtSyEbgVZxWlCgevuxjMce4sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=llT+5beN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=YPa7MiRsFFwpeZH158DqO9YLhdCCTsOn2F8zO6aBrTk=;
	t=1774287151; x=1775496751; b=llT+5beNuCIJuO3rlgAsI8FED+o8YuIV+20jh0fDmqvDJdk
	AFh2xEZRy4auXMCLc97gumHWnGSTvCYF7C8c8ooIXNfSgvx8v21iiGbzCBj/rtVm6JDkE+ktOgYvt
	pwj39fp7IdHsiIz6oOiQD1yHCPs8gPhcM+4u8W/AQMGNS4zY9/O25bfo7P4ojO5dwEZJPhtU/cMkf
	x7BJSAiOAfolRC9TmDpDgD6mSHueKVrzkplBPGpqSWnBaCPB4Xcx3pGpYAJ5Xn1KbNFwJsi/r8MXX
	GtBBmsrkzYiCp0SEkFMqny0o7FRs7jUpBzF+R31s3u/x6KAkLK0Atz5eoDe9Dijg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w4j8f-00000009ud1-0TbO;
	Mon, 23 Mar 2026 18:32:29 +0100
Message-ID: <2cc7113dfe94622c1e8e482948f26d9268ef2538.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: Replace strncpy() with strscpy_pad() in
 drv_switch_vif_chanctx tracepoint
From: Johannes Berg <johannes@sipsolutions.net>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Date: Mon, 23 Mar 2026 18:32:28 +0100
In-Reply-To: <20260323172015.work.146-kees@kernel.org>
References: <20260323172015.work.146-kees@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33731-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: D27A02FA424
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 2026-03-23 at 10:20 -0700, Kees Cook wrote:
> ring buffer. Since ring buffer entries are not zeroed on allocation,
>=20
> No behavioral change: since interface names are always at most 15
> characters plus a NUL terminator, strscpy_pad() with size IFNAMSIZ (16)
> produces identical output to the original strncpy().

This doesn't add up - if it's not zero-filled on allocation, then it
*is* a (desired) behaviour change?

johannes

