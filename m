Return-Path: <linux-wireless+bounces-36220-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKdsGJmsAWoMhwEAu9opvQ
	(envelope-from <linux-wireless+bounces-36220-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 12:16:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0DF50BC01
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 12:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C303D306413B
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 10:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EFA3B6363;
	Mon, 11 May 2026 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="EOk4ylQs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEAB3BFE33
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778494314; cv=none; b=SxmIMuSlJahtgbtYCxSdLJB1/E9QTQ4H1Qg8cA7Avxq2eDWp7lZ4RenM+bcEbtfXNC3k+8Zbmnw7S+6nOmBHD4Md2wkcIX5PPo3lTkIBT707/1/nnCc4D6Gh3AuTo01pUXxpwWV7F0thY5O2UCuZzxDWDGYtnHfSi3sTY2thHKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778494314; c=relaxed/simple;
	bh=bxhrwC97Ysavxli17qNjhBbp8xXMJ93GllhGTrawqEw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iHxQ4lmxlhhRHHRhaTnp7ZgbXS4oMUdG2u9okTI8mXpCGaHMdVVRagOBQ9E1fr406T2EfgGlUo+usCnnuDQxQRmbN+gMoQPhlxMwzdbnlUufopiiVLC2tRLOQlQt9TxtKAgPqROAByUGV33pBThi48/u7WbyRpNEXs1/lhh+ljY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=EOk4ylQs; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bxhrwC97Ysavxli17qNjhBbp8xXMJ93GllhGTrawqEw=;
	t=1778494312; x=1779703912; b=EOk4ylQsPO6mDOYAmdoMud8WOFMBygGC9axVYSxLqwiRNNo
	KbtdM6eYrB2Q9P56XPPCrm24xrRt336ItL6nOAIr95VXPsAPEuY3gaiGL6Aq2SwJvNQ61BPKZw/9M
	8G0TriwxcsWLoUQv16f0567zcAF8FZpqpaMtKh9DgTyVbZ6Whm9WMauAGkPV7OIEwWMwNZ6SOBJOg
	Obt3yzmN/bQTKpM12vHt7K8g+470mZ9BvhHmbkM0mUtzuHzE1N84WqdWX4QuFEaGcMO1xph00FjYS
	TGSCXvM3LuoWEhxS5lI7YDjbjsZL4ZiS0UpsDJOIpurcA6rZeU0rSPVgEdXPKWdQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wMNc4-0000000ElqJ-38Si;
	Mon, 11 May 2026 12:11:48 +0200
Message-ID: <cf877993914f9cee95fd5da1d9e57c838319a085.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: mac80211: Fix ADDBA request
 rejection after MLD link removal
From: Johannes Berg <johannes@sipsolutions.net>
To: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, Hari Naraayana Desikan Kannan
	 <hnaraaya@qti.qualcomm.com>
Date: Mon, 11 May 2026 12:11:47 +0200
In-Reply-To: <ffb9e313-fa81-4da7-8415-6713cfca3230@oss.qualcomm.com>
References: <20260415-addba-req-v1-1-6eb9a33d8ca6@oss.qualcomm.com>
	 <1f57207139c3fb955459425deda4d06c374ae212.camel@sipsolutions.net>
	 <1d06b2a3-66d8-4c27-b965-6c21f80b7539@oss.qualcomm.com>
	 <a5b6798819178dd2995c34ec817457e90985708e.camel@sipsolutions.net>
	 <dbb28e3e-5022-4915-93e3-dd428ea59507@oss.qualcomm.com>
	 <72b480830dee1489bc28246d13102048635de5db.camel@sipsolutions.net>
	 <ffb9e313-fa81-4da7-8415-6713cfca3230@oss.qualcomm.com>
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
X-Rspamd-Queue-Id: CC0DF50BC01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36220-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, 2026-05-11 at 15:40 +0530, Manish Dharanenthiran wrote:
>=20
> Even-then, if there is a actual change, it goes to invoke the UPDATE.=20
> For the driver(s) which didn't implement the UPDATE yet, should we use=
=20
> additional flags to notify the UPDATE support or returning a failure=20
> from driver should be suffice?

I hope drivers would refuse unknown operations, so I think returning a
failure is fine. We can quickly review the drivers that handle this to
make sure, but I'd prefer not to have a feature flag.

johannes

