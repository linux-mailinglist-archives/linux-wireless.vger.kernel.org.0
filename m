Return-Path: <linux-wireless+bounces-36996-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wC7gF2HAFmrOqgcAu9opvQ
	(envelope-from <linux-wireless+bounces-36996-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 11:58:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C080F5E2453
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 11:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79D77300A8E8
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 09:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2707E3CF689;
	Wed, 27 May 2026 09:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="YPUkpvKb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B958374E63;
	Wed, 27 May 2026 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875814; cv=none; b=JdQITtV1+ud17xQNNF/6sntYvs8SkBYGwv9G+FUI+AYK6/XkvdHQSUzD9NFz/NkgerAmzWmFMsOwTPY4JDwmKqE8Tekm2lt3Xqzua0XwPRDbWGR46i2MnMj9T7u5cqF29QiZKdQtj90sXAB+5JYabMrFqfWN+9gKBFmvpY9484I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875814; c=relaxed/simple;
	bh=B2qDBp5gcRdrhypAUqWX86Ju0guwZqoaYd7e/oacJMc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HiAZftULcpC/WdzDrQDrKmizGS6G4EbIigR+oCc7fuV7sQn1ruM00cQaBPWEU5BBevKcDltgocOGFHofWq9qZcTbwYyL8awvXpd7mORGXjxzUasm3r2o5aQoashVyXe05RdzzYi+pLWYGdZ1jeSSIwqRUrxQhyOvHVo/D8Zivlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=YPUkpvKb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=VyGjd5UX8/LWF/JNQYyX7JYgjBSF40EndSjLA+shEHQ=;
	t=1779875811; x=1781085411; b=YPUkpvKboFReScxjL4YR7kqy1UIN6sV+X33GS4z+zrCfZMo
	+ltpq1wXeP68vtbfquuhKSZ/lzDfFIsJYK678rRGGZC+ya6chyA6BvkLoUylmwYpUnZ4DUEzZF9K/
	vbRvz10+GV6TZ4yAPDR81RKxrYvtcuIIyeLhYAD3XaCbyN1ZjsV2n7kkmbXSY09CPuOfIgg7VGSad
	A9yxOYQuaHc2cW+PgyWQlmifrPsbaoLRexLp7LW3P8nMnIJAlMjJMyVg22XaIK7+ifld/YY2jZ0+5
	myvLsxajc3SPsMsQpTceR/ollGXb0GK8VALP2AiBVrVTTyNgsMmQmrO/2xS/gwxA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wSB0B-00000005zuI-0kNA;
	Wed, 27 May 2026 11:56:39 +0200
Message-ID: <57001abe5cdd0f2a7fc533764f0d9140fe20a3ad.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: ipw2x00: Fix potential NULL crypt->ops
 dereference in libipw_xmit()
From: Johannes Berg <johannes@sipsolutions.net>
To: Nikolay Kuratov <kniv@yandex-team.ru>, linux-kernel@vger.kernel.org
Cc: linux-wireless@vger.kernel.org, Stanislav Yakovlev
 <stas.yakovlev@gmail.com>,  Hong Liu <liu.hong@intel.com>, James Ketrenos
 <jketreno@linux.intel.com>, stable@vger.kernel.org
Date: Wed, 27 May 2026 11:56:38 +0200
In-Reply-To: <20260527090833.521511-1-kniv@yandex-team.ru>
References: <20260527090833.521511-1-kniv@yandex-team.ru>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-36996-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,intel.com,linux.intel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: C080F5E2453
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-05-27 at 12:08 +0300, Nikolay Kuratov wrote:
> crypt and crypt->ops could be null, so we need to checking null
> before dereference
>=20
> Previously the commit
> e8366bbabe1d ("ipw2x00: Fix potential NULL dereference in libipw_xmit()")
> partially fixed that same issue in libipw_xmit().
> This is similar to CVE-2022-49544.
>=20
> Found by Svace static analysis tool.

Might want to fix your tool to look deeper than just pattern-matching
the surrounding code :) The prior commit was also already wrong.

We already have

	host_encrypt =3D ieee->host_encrypt && encrypt && crypt;

so "host_encrypt && crypt" is equivalent to checking just
"host_encrypt".

And the only way to set the crypt[] array where a non-NULL 'crypt' comes
from will always have ops, so "crypt && crypt->ops" is equivalent to
checking just "crypt".

johannes

