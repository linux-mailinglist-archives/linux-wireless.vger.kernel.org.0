Return-Path: <linux-wireless+bounces-36063-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFh2IZJ6/GkwQgAAu9opvQ
	(envelope-from <linux-wireless+bounces-36063-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 13:42:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4754E7A22
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 13:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C280F30154A6
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2026 11:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733923EBF2D;
	Thu,  7 May 2026 11:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Z+Zo3cV1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7626D3EC2E0;
	Thu,  7 May 2026 11:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778153897; cv=none; b=TJPjHGsFPnn0TyUiGaY7tCQkkf7BQqghVRYz5/uAJtICxXQOKij7dMvI7oNzEr2ikighLNJ1eKzm/5EPT/VLMcaBlzrrWSCC8qpI4BqTmr4tzeGhXAhbjN6v3zT5Vvh6EAo7mTzJYc/fEEOe+isbDh6eQWSGRLnYR2RQmzla2qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778153897; c=relaxed/simple;
	bh=JQmsOPqiQvG2uQuddF/SQF9vXsPHXdDJ4NGB35X+Zio=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FJPpWRJvqOGReU1P0t5xWb+drIMKqur6bEgZC9tUdcL9uTKK8hfy0bSfmz9rfWWuMHAUEBC0RXBJ8AhMVYTciGuaig9RDpHoXVvHz8BaLYlN1aUpfXIgI2c6/1h8K0mHvwxBFEkqkwvfaYx0BFJMVxt98BWStYtlj+ZINsZJcXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Z+Zo3cV1; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JQmsOPqiQvG2uQuddF/SQF9vXsPHXdDJ4NGB35X+Zio=;
	t=1778153894; x=1779363494; b=Z+Zo3cV1/23fwv4hXjUTcPb5qp3j7+up7IaXz94dRmoFqkb
	aE1wsf+w8ORkVoq1R3tjcf8LfAulWpV0Qp8eTko3bw4sDDbuosSMExwTh+9zhrcfLmaPvsuTwo4ec
	ErFVSAOTM+2/b4Nx1DhAHm5DM2fMRVY00mFUD9Hs+2CDdZEb6PQqYvEDPhQFFr4ctpcy4Tcju3Xsm
	zMrXftb+pfBA+8CsvxKtRpMeLrFsmk0wf4SlXR/lAJWpp+71XvZR00UsyUrnPg8/oUIA3GEHkvp7r
	5JJ4dmQaj3mnol49tCwzoht5XOZmJ0Adh80DVdDKM9zOXIpD7ldBF82OGiKghmUA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wKwcG-00000003DIr-0Uxu;
	Thu, 07 May 2026 13:10:04 +0200
Message-ID: <fe81137b849e349bd9b0529c7e0e4be6b4099a5b.camel@sipsolutions.net>
Subject: Re: [PATCH v3 0/3] Add str_alloc_free() helper
From: Johannes Berg <johannes@sipsolutions.net>
To: Jiazi Li <jqqlijiazi@gmail.com>, Kees Cook <kees@kernel.org>, Andy
 Shevchenko <andy@kernel.org>, Ping-Ke Shih <pkshih@realtek.com>, Julia
 Lawall <Julia.Lawall@inria.fr>,  Nicolas Palix <nicolas.palix@imag.fr>
Cc: linux-hardening@vger.kernel.org, linux-wireless@vger.kernel.org
Date: Thu, 07 May 2026 13:10:03 +0200
In-Reply-To: <cover.1778051552.git.jqqlijiazi@gmail.com>
References: <cover.1778051552.git.jqqlijiazi@gmail.com>
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
X-Rspamd-Queue-Id: 0C4754E7A22
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36063-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,realtek.com,inria.fr,imag.fr];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, 2026-05-07 at 19:03 +0800, Jiazi Li wrote:
> Currently finds 4 locations:
> ./drivers/net/wireless/realtek/rtw89/fw.c:2557:7-12: opportunity for str_=
alloc_free(valid)
> ./drivers/net/wireless/realtek/rtw89/fw.c:2693:7-12: opportunity for str_=
alloc_free(valid)
> ./drivers/android/tests/binder_alloc_kunit.c:196:6-21: opportunity for st=
r_alloc_free(alloc -> pages [ i ])
> ./mm/slub.c:1634:3-8: opportunity for str_alloc_free(alloc)

It's what, three characters shorter for four users each? Is there really
much point?

Reading just the name also is really confusing - yes it lines up with
str_assert_deassert, but "alloc_free" really doesn't seem very obvious -
why would you alloc and free a string in one function call?

johannes

