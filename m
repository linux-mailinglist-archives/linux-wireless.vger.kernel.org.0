Return-Path: <linux-wireless+bounces-38672-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xcYANgCGS2rmSwEAu9opvQ
	(envelope-from <linux-wireless+bounces-38672-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 12:40:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFF370F506
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 12:40:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b="A+jsS6/h";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38672-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38672-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 89BF73017452
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 10:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC81A3BBA09;
	Mon,  6 Jul 2026 10:39:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818933148BF;
	Mon,  6 Jul 2026 10:39:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783334397; cv=none; b=CjgLb85CYJGq0MGrGNwUG9OKEWLIIbA8HBBs/TTOuvb3/8nwmyrKqQbdL1+FODv0gbXbQaUWQQym+PHopciEKrY1xhjvzrsuS2VhVnQB+sUjauqjid8FVNrhG3iDC2Cao1PffXR4NfCcx4uMdYllq/goeg2TEO/3IhcGBM1hWvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783334397; c=relaxed/simple;
	bh=Z61jGkp5iFcPQET9lNUJyKDn6inWB8ly1nt4Sljy5WQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GxSEZZR+K4MG4TkUOhQioBHzNvm0Tscqn2R/181Z9/eFA2sRaiGbx2RUYYtIP7tNMKyz6qemaF/H2qdeM1enZznOHaFXFAtGY42/GLixK9T/vguuOPSJRWqA0/4v4eXYccF0gsD8Agkw6uJL2zYlF7su9Ra9kACqtRLn1NUFwXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=A+jsS6/h; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Z61jGkp5iFcPQET9lNUJyKDn6inWB8ly1nt4Sljy5WQ=;
	t=1783334396; x=1784543996; b=A+jsS6/h3JqwK6+ZV9DXmxoxaEcwN/qM6hlxmri7m+4LvPR
	ey3iE4exlQOQzcS0I08bqA2qEplZfiaMi1CRK3v3UKX8x4Zg8BNg49JQU0tSfZmjB4ayFAxTcMZQX
	Cj6T2qCXSx9cMlHfWcwNK21mCBmrmPBEdiGYZPVr7HwZRqhjn8dgKVhkeUDcd90B6Ivb/tLlp7XCV
	pfZAd17v/SCZszeNympfQuh7yuYXa3vjZRSreiiGzr4FukZo+sqEyV8OEtNbfBm0owlU7/IZ6DJGZ
	rLVFIuSgi/YyPXzVKCcGkh3jozSCr1i8xKJvCgeInqbopoJgxUZm6+V4A38g1Ywg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wggjx-0000000D66y-1Qic;
	Mon, 06 Jul 2026 12:39:53 +0200
Message-ID: <c967e7897f421fde56ca4367c9e10d0c6d9f7ec4.camel@sipsolutions.net>
Subject: Re: [PATCH 2/3] wifi: cfg80211: validate assoc response length
 before status and IE access
From: Johannes Berg <johannes@sipsolutions.net>
To: Zhao Li <enderaoelyther@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 06 Jul 2026 12:39:52 +0200
In-Reply-To: <20260612185042.66260-5-enderaoelyther@gmail.com>
References: <20260612185042.66260-4-enderaoelyther@gmail.com>
	 <20260612185042.66260-5-enderaoelyther@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:enderaoelyther@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-38672-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:from_mime,sipsolutions.net:dkim,sipsolutions.net:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1BFF370F506

On Sat, 2026-06-13 at 02:50 +0800, Zhao Li wrote:
> cfg80211_rx_assoc_resp() initialises the status and response-IE fields
> of cfg80211_connect_resp_params from the management frame before
> proving that the frame is long enough for those offsets. S1G and
> regular association responses also have different IE offsets, but the
> S1G path only patched resp_ie after the unsafe initialiser had already
> run.

What makes you claim "unsafe"?

johannes

