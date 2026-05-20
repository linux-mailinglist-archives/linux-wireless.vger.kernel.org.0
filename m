Return-Path: <linux-wireless+bounces-36695-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH2uNi+WDWoMzwUAu9opvQ
	(envelope-from <linux-wireless+bounces-36695-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 13:08:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B92C58C1EC
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 13:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AE5D3004C58
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 11:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8333DA5B4;
	Wed, 20 May 2026 11:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="uI7zNSIz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B323B6363;
	Wed, 20 May 2026 11:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779275173; cv=none; b=BI68LnLcu8t3xILK/gkG41Kf7MCZOLmc4BICAo9Td3kQfweQ4oA4phBCpj+S2pHVe98IFZ4cFXnncitu71vzxVmHHgfn6B+RZRtowjDSjt8INy4oJyrN5laMNX8ggAjQyyelMXOltI4eH2WdVxRiTvAN+hPDzBmTAlfP8DgJU6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779275173; c=relaxed/simple;
	bh=JxAq/A2Eo0vh6lMXCPSjLH099dYwa6FSS5E+bY08TSo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iDo49H/Vnt29UD131ueQEdlKGzFu2sLPdUKdgNjjWo0mrLuUkoir2F8/4Y5hc2Uge+gpiWBNQt7eL7YzwGzFs1ta97cJBN28BymfhLZ7xH4zGOBggnpzEtnTZ/HWDkEtntEafdixEXECiq2JLKHN1nK7xj42XMCXiKR5DJKE2is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=uI7zNSIz; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JxAq/A2Eo0vh6lMXCPSjLH099dYwa6FSS5E+bY08TSo=;
	t=1779275171; x=1780484771; b=uI7zNSIzFKddvYxVL+rMOwSJKxrhBV9D3yutMI5OF2xgxf1
	dykpphzZV8S3YcMf6YQLtbj2zt3rPJnrad5IrFEz+W03LYDZyA8pslEDaKq7Mv/20pHv1CiA+p4Qf
	fL3X9uaTCgIdEFNeIup4p82c3dmIbVkYpfztFUJS5sizX93FCIv9cBuO6YLTOHT3/BM5pzHHMn6Uk
	omhpiWDIGUI9T3ft0yrLRSWeJAWc/xd6PTtiRFxG63tgdhmGlRot/keI/lPPRu4Ra1TCr8nmFiUN5
	nTInmwPBdbxdvGFA0uZeI07z0eici0iktZGY4NFAiaQYIdF6/jmIWuTKnS/BKL/Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wPekY-0000000AJCb-05xA;
	Wed, 20 May 2026 13:06:06 +0200
Message-ID: <a052e02c8039b06348119a1ec0b18bf1986a999e.camel@sipsolutions.net>
Subject: Re: [PATCH 0/6] b43: complete N-PHY rev 8 + radio 2057 rev 8 support
From: Johannes Berg <johannes@sipsolutions.net>
To: Alessio Ferri <alessio.ferri@mythread.it>, Michael
 =?ISO-8859-1?Q?B=FCsch?=
	 <m@bues.ch>
Cc: linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org, 
	kvalo@kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 20 May 2026 13:06:05 +0200
In-Reply-To: <20260519230241.49489a8f@DELL-MOBILE03.ad.smart.it>
References: <8c0a07d2-9ec9-43d6-bdf7-f625bbb4a38a@mythread.it>
		<20260519175812.7ce97ba1@barney>
	 <20260519230241.49489a8f@DELL-MOBILE03.ad.smart.it>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36695-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 3B92C58C1EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-05-19 at 23:02 +0200, Alessio Ferri wrote:
>=20
> The patchset is tested on my own DLink DSL 3580L router and generated by
> claude from our shared notes, i then reviewed it for sanity and
> verified it by navigating from the router with modified b43 driver with
> my phone.

I would ask you to disclose this in the commits per

https://docs.kernel.org/process/coding-assistants.html

johannes

