Return-Path: <linux-wireless+bounces-31525-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFpUG1gug2kwjAMAu9opvQ
	(envelope-from <linux-wireless+bounces-31525-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 12:32:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3704E52B3
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 12:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F83D3013B57
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 11:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C7A3E9F70;
	Wed,  4 Feb 2026 11:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ugI5KdOJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB0C2405E1;
	Wed,  4 Feb 2026 11:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770204579; cv=none; b=bs+z2liJ28TU+GdqXSgi/laSs930F6bX9tdAnOF75Ivgc1E+gsBKKGAM1YGDOmBriOeXGOq2ntHByqMid1vtlt/FB2Xk7tAErDREvrOG4RsI7I31AL0NGqBkrTxF+BPncHMRScmJJsFdSsxDnZJQ4F5kj/9KzvzogrySVLbVj9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770204579; c=relaxed/simple;
	bh=sC9UQqx5Nl99mzaUVl+GaH0MeyQ/vcUIwndps5y3T2o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TIJS2KGhOVizyOPucxF/ZlfycHT/+ZSJ+x1eX1NCrJVYTB1lxVqQT7gsEqh3CeEPRlXDlWalKFR416QLftLF3CQSu+kdVp0H+1Z7WBQuiWenYEWkHUp7KjUg7e5SThXdsdd8TE5GpyfoHFPVqgPMEYs81kwAYE9Opn3pDnwRnOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ugI5KdOJ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=sC9UQqx5Nl99mzaUVl+GaH0MeyQ/vcUIwndps5y3T2o=;
	t=1770204578; x=1771414178; b=ugI5KdOJjJCSRnMltTV+J4532TSQSjMp6LeYZuoj8aENhgt
	b4BDmISTCsLS91HbItZXcbKt9f3pskU9Bjn2xFU47anbSgDyHvOXRnKyZNJoUW4m20qn6CAzw7mgs
	KTD/UED1aIp/2q9FVJnsNItPEuNnqzCF/+FTgGX6RGzWKWCqNbRau8DGQv3ZrEf6NBxp7nFmGqXw0
	kaQglFz76k3D4hcwQfHP12EmQcnGZDCA61ej6dqbsXImRxO1eD6QgTdbf6zyHthnSzYapbDVyFWpy
	rIbRBgY5FBlrKlgv9q2yhJsIyofMvztH5ycPoGycUz0125keWPd/vLOkx+AaMTfA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vnb4i-0000000EJZF-2Tn3;
	Wed, 04 Feb 2026 12:29:36 +0100
Message-ID: <a1989402f65d0a9a696eb85925db98f6b722fc11.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: nl80211: drop impossible negative band check
From: Johannes Berg <johannes@sipsolutions.net>
To: sun jian <sun.jian.kdev@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 04 Feb 2026 12:29:35 +0100
In-Reply-To: <CABFUUZFxH1noKq-=zSTrqpirJtTQ2AA6anb7Pk=BDGC3aTs+Og@mail.gmail.com> (sfid-20260204_122137_132999_E605D441)
References: <20260204081821.730673-1-sun.jian.kdev@gmail.com>
	 <bc92582d5de175ec325ae53ed3fe18a5e073438b.camel@sipsolutions.net>
	 <CABFUUZEiMFoGg4r+9q1FabbwD1Pfd0oZZeNxFqnM22nA1xn8UQ@mail.gmail.com>
	 <074b66ab3d63e6640ecd6962c074702225fba19e.camel@sipsolutions.net>
	 <CABFUUZFxH1noKq-=zSTrqpirJtTQ2AA6anb7Pk=BDGC3aTs+Og@mail.gmail.com>
	 (sfid-20260204_122137_132999_E605D441)
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31525-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:mid,sipsolutions.net:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3704E52B3
X-Rspamd-Action: no action

On Wed, 2026-02-04 at 19:21 +0800, sun jian wrote:
> >=20
> > applies _only_ to signed short, not to signed char?
> Fair point, thanks. I'll drop this patch.

I've thought the better way to address that warning would be to simply
use 'int' instead of the enum there, but I forgot where the warning even
appears. I don't think it's generally with gcc/clang, is it?

johannes

