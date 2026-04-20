Return-Path: <linux-wireless+bounces-35043-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULk8GYsl5mmOsgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35043-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 15:09:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B57C142B44B
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 15:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86E8E30B1208
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 12:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D254B3921F1;
	Mon, 20 Apr 2026 12:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="TiN2uPPY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CA139BFEF
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689965; cv=none; b=vCPjfXzT+bsYAWJ/usgFsG9fOYne6Xm2q5tHrVD8/s3YlSpqZcEhL8uTTViTqhKNWKPRkFnQQFzh8P3CH+Q65uAGP6mMP62tfQc2Bby6lQ7byqQjF69Y7jthpcMQ1MGYGVjFMt36zSrIsMD1W6uy9c2/Sv+GavbZM7pU/tvUjlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689965; c=relaxed/simple;
	bh=yV3J5T3TgzUJkrib5qYUgbWHkA7alCGam4RgcikDZCI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GR7nqJdScnREOCPuMJTW+qkQPZU5oFq5A6XhVerGdvByCIVO+kTMD8Scuj34DqzcIBFbJVLgMIO931wNGlllpL0Dg+vpw+JIlyYU7BfU2VAhPh9AvggdxhivHFR8UEgoc5vmSn8Zkoi+xLtOLvPLpPIXA6UZkzpyiTYBqF7TFrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=TiN2uPPY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=VfmPheNZSeeyU7wQcECdJjJNb8MdPyVIubJzWOL+oK8=;
	t=1776689963; x=1777899563; b=TiN2uPPYdq3KWc6oxjOEQUzwzspmje/qHqzwHsrQj+XJX68
	Of7g/3Qn+GakvkC9/OhtCbjitkxwRqzSMAhYak6BFuJEdEtrocgtzoHTCDcpdLSW4JFpPeQ/W3cAe
	hRGkZTKG4oIMe6BWOX9qfTJ2IkuhP2ek7t17KQBdH9zVSIjsGkGnht0AOEde8/ks3w7LCh1SW22KT
	jHBUPJS5alwo+tAYG2yTFBi/XkyC3QxSatiyKMEtvLyQqXSDvJ/ZVxV8qDdortBin5JZwcJDUQLaO
	HZVSgZv4DkaCOUJiy/X0bMDjcdKO46yBY6kvQjEffvLJqOb+CtLDwycD6sJWA1Xw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wEoDg-00000002eBQ-0g95;
	Mon, 20 Apr 2026 14:59:20 +0200
Message-ID: <6e78e7a7e629391ff58d53aecf1b033f205ff21e.camel@sipsolutions.net>
Subject: Re: Garfield Peak 4 trouble on TigerLake
From: Johannes Berg <johannes@sipsolutions.net>
To: Ioannis Barkas <jnyb.de@gmail.com>, linux-wireless@vger.kernel.org
Date: Mon, 20 Apr 2026 14:59:19 +0200
In-Reply-To: <CADUzMVb+JNEcpizCBCho+qCMPG1fzNfJ10Nh78=N7-vvao8Ogw@mail.gmail.com>
References: 
	<CADUzMVb+JNEcpizCBCho+qCMPG1fzNfJ10Nh78=N7-vvao8Ogw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35043-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B57C142B44B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 2026-04-19 at 13:28 +0300, Ioannis Barkas wrote:
>=20
> [    4.463035] iwlwifi 0000:00:14.3: iwlwifi-QuZ-a0-gf4-a0-77 is required
>=20
> Not sure if this is a valid file but I could not locate it. Is this
> expected? Also Bluetooth goes nuts.

This isn't (and never was) a supported combination. Whatever the
physical, scheduling or other reasons, your platform there (TigerLake,
released in Q3 2020) is simply not meant to use the CRF (GF4, released
in Q4 2021) you put in, and this won't ever work. Sorry.

johannes

