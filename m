Return-Path: <linux-wireless+bounces-33584-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2H+aCC0GvWkO5gIAu9opvQ
	(envelope-from <linux-wireless+bounces-33584-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:32:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EFF2D7417
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B645530DD346
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 08:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0CC318EF6;
	Fri, 20 Mar 2026 08:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="PguadrS3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C2371893;
	Fri, 20 Mar 2026 08:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773995337; cv=none; b=dQNAEdLmBzBFEfm4QRMDzRreV1dXMg5RG5i1DBipEM7LLHMgciGxixSWGXWK3x922tL6O/3xBOdJx8m316lIpKYYD8UaIcSma5qBVj4t/UrWsKDEFPU3So342/sCm6U+DQTBFTeKymQcUMuEKnBKV5OeHzV/ffV6BGMRZrpSSOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773995337; c=relaxed/simple;
	bh=6uDVse/f+UqXumUFSeU6eMXonNr+xu2lqIdDrA6J69I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=azOclOIsx3C4e2hfCHPebJlrsNGCCswkPs0zXksxYHaKcxbPf63Gvk97lZV9RGbmZUSKPcPPhhEWqmDe0coK04BLN0SY0dTEXl7BLxgV8r6XLmfwVWwib9tck5AhFFjO3mSmtufuSK5Cs9cM4tXxPHbI/ZQk4ahqmin0YnXCbAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=PguadrS3; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=6uDVse/f+UqXumUFSeU6eMXonNr+xu2lqIdDrA6J69I=;
	t=1773995336; x=1775204936; b=PguadrS3HACIwgsKg3kiS+Y3RfMtUtI0jZT8PvYrvdrAehI
	XfIca47MyQW7kaHHkZyR7SMR+YvsMXCierDgnGLSeoZeL9Do/va5dsOFZDAKCDc3s0OCFXzYXbS+P
	z3krldAq5CFsXOf+2m+JKohWMKOx3EktbJcyE/qi0vkzsy+EiRQwe+OtIJutt91JQxF4C1CW5FJDP
	nKNNioFYq3BuZK9fkQnM7DEjcjv5G5BnBt6fc3sV9KdX5r3YJYefMys03J9u0nxShSme2aPlbTIEo
	KiEsZJ0N9cYsUTQzNkBVZk4PqnT31BqEg9QUEstk5URHjMoTCCTLdt/TZopVZ6/Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w3VDx-00000006VMm-0MwK;
	Fri, 20 Mar 2026 09:28:53 +0100
Message-ID: <322b0d12d583dfac3f7d79dd1e4e22fcb413a946.camel@sipsolutions.net>
Subject: Re: [PATCH v7 1/3] wifi: iwlwifi: pcie: migrate to modern
 pci_alloc_irq_vectors API
From: Johannes Berg <johannes@sipsolutions.net>
To: =?ISO-8859-1?Q?Adri=E1n_Garc=EDa?= Casado
 <adriangarciacasado42@gmail.com>,  Miri Korenblit
 <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Miguel
 Ojeda	 <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 20 Mar 2026 09:28:52 +0100
In-Reply-To: <20260319182925.19436-1-adriangarciacasado42@gmail.com>
References: <20260319182925.19436-1-adriangarciacasado42@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-33584-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: 78EFF2D7417
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

So given your exchange with Miguel, I was not going to reply, but

On Thu, 2026-03-19 at 19:29 +0100, Adri=C3=A1n Garc=C3=ADa Casado wrote:
> Johannes Berg suggested using pci_alloc_irq_vectors() and delegating
> affinity management to the kernel.

I don't know where this came from, I never suggested that?

I _did_ suggest that if this change is somehow necessary (which you've
not convinced anyone of), the driver should allocate fewer queues rather
than just spreading the same number of queues over fewer cores and
double-booking one of the cores.

Please take a step back, (re-)read all the feedback you've been given,
figure out why you want this change, and come back with a coherent
explanation and changes addressing feedback (or explanations why not.)

johannes

