Return-Path: <linux-wireless+bounces-34457-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIhJDsXf1GmZyQcAu9opvQ
	(envelope-from <linux-wireless+bounces-34457-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 12:43:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DD43AD128
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 12:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F171D301579A
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 10:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97CC3AC0D6;
	Tue,  7 Apr 2026 10:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="P9cHM8X6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588C53AA195
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 10:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775558557; cv=none; b=Uh451SECb3FRUg1HWHFK1hufmnApauhdPB8KgwHhQsGBRM7jp6PkRjfuq6DW5kcSLs3h09bDwifqXsLkbMNI1IL2rDyaPyccgBE2sEL0LcDVTorCi4AE3fOp65ptzq5ssSUxKgS4CKkzUhzt/zmO4eyJxxMoLoGS7LlCQ3n4Pbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775558557; c=relaxed/simple;
	bh=RGxwfvTuVTvkrjji67l5qI78ht84n6bedP2XtN+AYQI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pAfXEdp1OchNNzG47RTL5IuatVzTGwn99vj92iLvW1Saqo/CwIkGoP49yDMeP+QeCUzD48fCuY/T6BkDhVgK5NTs5MLh0JxFF4k1xHB3ujbNUrJ/HHmMlZ3PI9ImtxmAayNFfnth7b77o1DZdCmrEBwJq7nLec9+/QcxbQDOeXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=P9cHM8X6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=RGxwfvTuVTvkrjji67l5qI78ht84n6bedP2XtN+AYQI=;
	t=1775558556; x=1776768156; b=P9cHM8X6WCFzLH6aqirofxNdZ0zaVE5UUGVVju5Jqd/esrQ
	90MaRkjoU7PsXYJgMhBHypRoSNlFU3ay35Nu7xj4V4oYJP8oCLIuwaMWA2jY9ZTWYaD+qJXmhcBCs
	M1QaP5dTddyqlE0gUqGLRoxifOAQdGC5T+2wHkR5UwNx7RlYi9imcFuSOL5w+zkplTEnZvUvVBu/1
	eDoMtdVrDFJevEkIwrTWjmaPIARdCaKTEIkNNtI2dqFlaxKpGLec5tPXEUpkGQtjW2DDrUmWMsYLK
	ZNZVUOCWs3uQ1qkQLI7UqFspJX6Zv2MGExmQ6Ydiuza+wKO85WMFUAbRlnlkdSKA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wA3tB-0000000CGDk-2XIl;
	Tue, 07 Apr 2026 12:42:33 +0200
Message-ID: <8ab625396cc6f3e3e926298c55b7f56c4ca2423c.camel@sipsolutions.net>
Subject: Re: [PATCH 1/1] wifi: cfg80211: wext: prevent encoding_size
 overflow in giwrange
From: Johannes Berg <johannes@sipsolutions.net>
To: Ren Wei <n05ec@lzu.edu.cn>, linux-wireless@vger.kernel.org
Cc: linville@tuxdriver.com, kilroyd@googlemail.com, yifanwucs@gmail.com, 
	tomapufckgml@gmail.com, yuantan098@gmail.com, bird@lzu.edu.cn, 
	enjou1224z@gmail.com, xuyuqiabc@gmail.com
Date: Tue, 07 Apr 2026 12:42:32 +0200
In-Reply-To: <20260402121007.339835-2-n05ec@lzu.edu.cn>
References: <20260402121007.339835-1-n05ec@lzu.edu.cn>
	 <20260402121007.339835-2-n05ec@lzu.edu.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[tuxdriver.com,googlemail.com,gmail.com,lzu.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-34457-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3DD43AD128
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-04-02 at 20:10 +0800, Ren Wei wrote:
> From: Yuqi Xu <xuyuqiabc@gmail.com>
>=20
> cfg80211_wext_giwrange() appends one encoding_size entry for each
> WLAN_CIPHER_SUITE_WEP40 and WLAN_CIPHER_SUITE_WEP104 value advertised by
> the wiphy. struct iw_range only provides IW_MAX_ENCODING_SIZES slots in
> encoding_size[], so duplicated WEP entries can advance num_encoding_sizes
> past the end of the array and corrupt the iw_range buffer returned by
> SIOCGIWRANGE.
>=20
> This can happen when the wiphy cipher list contains duplicated WEP entrie=
s.

That's pretty ridiculous though, even if it can (right now) be reached
through hwsim.

Probably better to just make cfg80211 reject duplicate entries though
than specifically hacking wext...

johannes

