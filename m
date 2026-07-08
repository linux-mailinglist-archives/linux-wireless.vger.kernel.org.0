Return-Path: <linux-wireless+bounces-38783-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 02GlFC0cTmrEDQIAu9opvQ
	(envelope-from <linux-wireless+bounces-38783-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 11:45:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5FD723DB1
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 11:45:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b="p/JDTa+p";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38783-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38783-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 890AA30117AD
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jul 2026 09:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A563403EB;
	Wed,  8 Jul 2026 09:45:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1F6332917;
	Wed,  8 Jul 2026 09:45:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783503912; cv=none; b=IxzrfJjB7C5qQ66jaUGJLehlSzSIF7exQ5WY0D2w2kMRySJr1F3f9oenvvRnQ5CaHBb+T3PJyexAsLJC0ZSUlozY1MEYFodAAMsiKN7Eul4xGuJjUDmCUya4pQtmw/KOM+gxbZv2hVB4qqpNUuzSjQHJpiwa0dsdPPNt2OnF9Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783503912; c=relaxed/simple;
	bh=fWsg+VRZP+IygMe6ufylZ2Cx4gOG+ZDTVRFd55uzSho=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qo3gRMu+E9fHb6p4tPVTAqXYuYglLfcjbP5+wU/pJ5QMtVsrcWkvKlfd31JEy6sHR9laNzPjkWnNLSw0bTcJzmqA45ppNk1J3GgQ5aPVVQpuZFVHJhgLJr4JUp9ytDW4DXuW95FlXv+qYt1w4oH7DXz8y74K9ydjb3V2h5JLJHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=p/JDTa+p; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=fWsg+VRZP+IygMe6ufylZ2Cx4gOG+ZDTVRFd55uzSho=;
	t=1783503910; x=1784713510; b=p/JDTa+pQJl10MciO6lRfdHEwYB0/Zhlm7xSqhnAhM9wfhF
	phfN7FR/rBxo6BD66rGTlxrQtEqioZcOu0/kzEGoP7u4XlIDm63XS7GrzWr9660010Rr1M5NZxT7B
	U6nVAal2E31vTogphA9s7GO6tgiaLJzjyrhYY6Wg4nxWTXv+bOGUnJcDMco68PKicSvOPGTO3JECA
	toLizaaUnym6neqvuOnYwBEli55Q706TUAKEhbnAQamRKukB22sh4OQ8DLbwip4ymIxkY6n+gFJyb
	ntz7OyAbTATF7Aw9BnvtGCoe4owVt9AVM6rNgpnVg4PINXuKWG1roXo2Yd0Xc4EQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1whOHC-00000004WiW-0pqx;
	Wed, 08 Jul 2026 11:09:06 +0200
Message-ID: <867a09c9bc173902bf2deb9094a008c5cd33bc92.camel@sipsolutions.net>
Subject: Re: [PATCH 0/4] drivers/net: replace __get_free_pages() with
 kmalloc()
From: Johannes Berg <johannes@sipsolutions.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Brian Norris <briannorris@chromium.org>, Francesco Dolcini	
 <francesco@dolcini.it>, Jakub Kicinski <kuba@kernel.org>, 
	b43-dev@lists.infradead.org, libertas-dev@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-wireless@vger.kernel.org, 	netdev@vger.kernel.org, "Mike Rapoport
 (Microsoft)" <rppt@kernel.org>
Date: Wed, 08 Jul 2026 11:09:05 +0200
In-Reply-To: <3832c190-b5b7-49a2-902d-7f75598b0789@redhat.com>
References: <20260701-b4-drivers-wireless-v1-0-60264cdf2efe@kernel.org>
	 <3832c190-b5b7-49a2-902d-7f75598b0789@redhat.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:briannorris@chromium.org,m:francesco@dolcini.it,m:kuba@kernel.org,m:b43-dev@lists.infradead.org,m:libertas-dev@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:rppt@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38783-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA5FD723DB1

On Wed, 2026-07-08 at 10:55 +0200, Paolo Abeni wrote:
>=20
> @Johannes: just an head-up, I assume this series will go via your tree
> (despite the slightly misleading subj)

I assumed the same and already have it in wireless-next (with fixed up
subjects to add wifi: prefixes).

johannes

