Return-Path: <linux-wireless+bounces-35480-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Hq6KTmI8GnuUQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35480-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 12:13:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1104825A7
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 12:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F3F031A3EFF
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017193A6416;
	Tue, 28 Apr 2026 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="g4pR0byo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836853A6B88
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368686; cv=none; b=bg7Hq98mRFfCHw8hQRHK5y1v7WbWjCIXwj9ozlh/tcNSFzwVBzD/S5CZvjzs+j0+GnpzgGfa7CpzJwKX1TaEG5oDViHfbfZJ9vufQhXPHlnWlzzosieIa3UM9iYAZyQGbA+myRt3iCI05zQhLVc5pD0Q7SpSwezzfuh72HYkEzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368686; c=relaxed/simple;
	bh=tJv+yaVEkQrsZKGmAWSF6qmOkRL3lPfpylSA9rWvhck=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aDxce0Mfj7lZd4Xtq6J2gCXfE/50GtGwYzdcYbYsNA2gWEMKwCP1HnoaZQ7z7X8PWqmMm090aZ+DgH8HVr8dSU+7cSKhnWaRb4i4iC34IRN2ea9ydEd265RGm4I28lybOfignI7X1VhGJa+MfscBYPmYch8lN4bFQpAISaE1LlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=g4pR0byo; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=tJv+yaVEkQrsZKGmAWSF6qmOkRL3lPfpylSA9rWvhck=;
	t=1777368685; x=1778578285; b=g4pR0byogaUp17M6oeajlkq/r6jspVbntMYqgF7vxxRsXzl
	ss6vHhutRP6n5lmFxPVNFGnwXggP4xhrvKbcYdyLim9TGi7dpiQYjmfLcSm6tVJ8mJ/fmeqm4nbrL
	Ifcfxle+Xtz/A5U9+rB3Ur1jjmmSoZrgNJZJXoW08AHXue9/RzN2I2pY9Jn8CIlHaRyRYMRdjhzuV
	/6CrUroQ2xu6q+i0RLPznOzc9m29vfjAcwhZbHzDuPBP12413Hd74o5bXZVq1GSLtiRAEuBdqsN+Y
	/vtdg6HiL+vONEBndkq3WyFihIcuhrXV7kRelpqS8j0k03iYZvkndTACSZZkjjfA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wHemo-0000000HMhV-0vdF;
	Tue, 28 Apr 2026 11:31:22 +0200
Message-ID: <59fa69de18211d2f17d346d22f2d07bbe72c157c.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 1/2] wifi: cfg80211/mac80211: change
 memory allocation for link_sinfo structure
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <sarika.sharma@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 28 Apr 2026 11:31:21 +0200
In-Reply-To: <20260428090919.1798601-2-sarika.sharma@oss.qualcomm.com>
References: <20260428090919.1798601-1-sarika.sharma@oss.qualcomm.com>
	 <20260428090919.1798601-2-sarika.sharma@oss.qualcomm.com>
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
X-Rspamd-Queue-Id: 1B1104825A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	TAGGED_FROM(0.00)[bounces-35480-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, 2026-04-28 at 14:39 +0530, Sarika Sharma wrote:
>=20
> +int cfg80211_alloc_link_sinfo_stats(struct link_station_info **link_sinf=
o,

really?

johannes

