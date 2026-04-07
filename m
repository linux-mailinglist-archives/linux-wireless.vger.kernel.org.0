Return-Path: <linux-wireless+bounces-34452-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNwyCCXJ1Gk0xgcAu9opvQ
	(envelope-from <linux-wireless+bounces-34452-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 11:06:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 663363ABBCB
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 11:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F09C73005771
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 09:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FD138E5D7;
	Tue,  7 Apr 2026 09:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="PVeW5Fux"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D583F229B18;
	Tue,  7 Apr 2026 09:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775552802; cv=none; b=WAd4u4UOOHdWnQTgGlgLVlAEHIeIqWVMGUH+iGlOR8UWNscT9BuLaVxD5Tb6vkfkrq6eSVnS3+ccq/pFgp4IfrSueYqwMTss/TUb6UZM5US0fpM2tjwM3Lcdb4OGt4305sJ0VQ9e0/3W2VfNnr6LAq199eFSnMl4ct5N7ZGj+Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775552802; c=relaxed/simple;
	bh=RxGTLnxZQOpYfHxurph+fCKl1j0l2IYye6XIaHGSCjw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BCxCMe5wgMjy09S1+fdTsPQ0GAbdY3pXW8V2m7zlnEuQ5XDNZUsDF5TuMw7RAG/VnS4TLIWUG7WNng+i6fQ/HOaNp5ZpSKiIH/pN1j+fVMZlxaHM512oLx/ZqjBKJw1VxUsq8WqfDEiwf/Io76rJGHKxVQn1GifLFB2kQRMg7ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=PVeW5Fux; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=RxGTLnxZQOpYfHxurph+fCKl1j0l2IYye6XIaHGSCjw=;
	t=1775552800; x=1776762400; b=PVeW5Fuxja9CNoPLzO6jrue5g79g/02PGhEXAqdfZSeKcH+
	hJtdAdCk58ayOKxgsCJKes8Yvsa1FbdiIv4MBDY8RGd5Z9QAeiBmyJdtP2Tyc8dWlNPEg0NpwKUie
	muZ5h5XJ0ldgBmwvioICn/b+yL+bb61kCyyOIEzd6tQM5BGBsoZOw702a1NX9ZjXHwXUkmYICWzGl
	SgMwntTAJGZz2nW6gi70vDaM0wH4/8HB0MbXn+jG9wx9bFtfV+b3p30kEuchxEa11HVGGKsPjFOHR
	ga6m7rVPHAjpue50J4gwRKwmR18wfaadpiPt9C9eSHw0WEFmkUYAKYQD+pXN6fog==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wA2OL-0000000CBAs-2yku;
	Tue, 07 Apr 2026 11:06:38 +0200
Message-ID: <4ccf21800166b28cc28c72b0b1cf2672b43af8a9.camel@sipsolutions.net>
Subject: Re: [PATCH v10 00/21] wifi: nxpwifi: create nxpwifi to support
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	francesco@dolcini.it, wyatt.hsu@nxp.com, s.hauer@pengutronix.de
Date: Tue, 07 Apr 2026 11:06:36 +0200
In-Reply-To: <acPm666IO+nso5to@nxpwireless-Inspiron-14-Plus-7440>
References: <20260305143939.3724868-1-jeff.chen_1@nxp.com>
	 <9b0144261da2ce7f5ef0a533928732cc43459e40.camel@sipsolutions.net>
	 <abDh2mBYTqbhKz/H@nxpwireless-Inspiron-14-Plus-7440>
	 <8ebc201c976f11cce4802e9e34c1f479ee190ac8.camel@sipsolutions.net>
	 <abJ/qONShVDAuyhI@nxpwireless-Inspiron-14-Plus-7440>
	 <075c9a062664609a81a722883ee17e7c728b08bc.camel@sipsolutions.net>
	 <acPm666IO+nso5to@nxpwireless-Inspiron-14-Plus-7440>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34452-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: 663363ABBCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-03-25 at 21:45 +0800, Jeff Chen wrote:
> Ulf prefers not to rebase or drop the SDIO ID patch from the mmc tree,
> and his suggestion is for me to include an identical copy of that patch
> in the nxpwifi series for wireless-next, so that the driver can build
> independently during review. Since the change is trivial, he expects git
> to resolve the duplication automatically when the wireless and mmc trees
> are merged.
> Would this approach be acceptable for wireless-next?

Yeah I guess we don't have a choice ...

> For reference, please see Ulf=E2=80=99s feedback here:
>=20
> https://patchwork.kernel.org/project/linux-mmc/patch/20260113031517.24471=
4-1-jeff.chen_1@nxp.com/

So I think we said before that for final merge you should send a pull
request anyway instead of all the individual patches.

Can you include it in the pull request, as a precise cherry-pick from
his tree?

johannes

