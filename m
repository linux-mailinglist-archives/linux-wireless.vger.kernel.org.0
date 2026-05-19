Return-Path: <linux-wireless+bounces-36660-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAXbNOBzDGqihwUAu9opvQ
	(envelope-from <linux-wireless+bounces-36660-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 16:29:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5D45808AC
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 16:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7896D30942C2
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 14:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA804028EB;
	Tue, 19 May 2026 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lmE/Op9N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3524028FF
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779200621; cv=none; b=rfgzfsg+gEn7ehF2d9UdSJeCqNKBWz7CjTXXj2BLWOVVEy+ieE8bzdtwcW/RH/afAnv6/ZTt6QOjBrlYaEMdLVxAiX73mU9FrQKm973OKzbpPbaL6KEipKQF55fe456vV4dnWO4SCBEEmF/2a5XwPzl0HjNXvyz3M8d9XmLv8QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779200621; c=relaxed/simple;
	bh=5wT6LU1ZS0HYf10rWqJnWAJHv20mqOalKbCcZIDCp4A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MkwZiF8TSfAbBsLr+ar7SUFGcAM4NMuCEnF6102I9M/sweR4yn2uWMSiNqWwgB1RZiuL9dAfcedX1aImkwR5ccRCUGBtK4O1k5tFOyuyCRRJPGYQzhu0ZZkxl1DKgXR52n7GnBT9cuPySRsLitw9kgxV22fz859MCesWzR2bqPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lmE/Op9N; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=STpS87w81sZnuEpga9ltOybAp1UYGjlXwJ5efc3idxE=;
	t=1779200619; x=1780410219; b=lmE/Op9NB4OJF45K2QQkIYMM11kS1D3de0Gd5lIx5/3cZZ3
	ijO3KmmikvJpmAoTBqy0OTnPC0iZZZdjE/TeZQppyU33AHClTyfnnKe5KM+c2Vu9kp6NE7knQKxdu
	a4b53OZQGL9afQNsYREeXh35iyj2BrteEyaDuqGHfPdULzQC6+ebTNPK8JoQ0PGdiVFZ6p7e27VrD
	upoVa1pe4GxQwIKhUOyQQFqa8YR8wquWIGJosmQuy59PDu9bQ1zEgkCbXMgpyRzPNT6RLQjgb9uva
	tAwBgzh4UDwWZdkSlWn+g7BEvSfND+clt4+/WZgwfjpomM/RcAf3DIoYf4IkgSMg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wPLM3-00000006szv-2KCx;
	Tue, 19 May 2026 16:23:34 +0200
Message-ID: <8fbec573f20f11981773007f8b55ff543c462c11.camel@sipsolutions.net>
Subject: Re: pull-request: ath-current-20260512
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org, 
	ath12k@lists.infradead.org, jjohnson@kernel.org
Date: Tue, 19 May 2026 16:23:30 +0200
In-Reply-To: <d88a1d9b-853b-476c-8f01-22fe24590892@oss.qualcomm.com>
References: <8756e3ff-52bc-4003-99ed-cda3170f118c@oss.qualcomm.com>
	 <d88a1d9b-853b-476c-8f01-22fe24590892@oss.qualcomm.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36660-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 4E5D45808AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-05-19 at 07:21 -0700, Jeff Johnson wrote:
> On 5/12/2026 7:28 AM, Jeff Johnson wrote:
> > The following changes since commit 7666dbb1bacc4ba522b96740cba7283d243d=
16e1:
> >=20
> >   wifi: cfg80211: advance loop vars in cfg80211_merge_profile() (2026-0=
5-08 09:20:03 +0200)
> >=20
> > are available in the Git repository at:
> >=20
> >   git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-cu=
rrent-20260512
> >=20
> > for you to fetch changes up to 54a5b38e4396530e5b2f12b54d3844e860ab6784=
:
> >=20
> >   wifi: ath10k: skip WMI and beacon transmission when device is wedged =
(2026-05-12 07:00:00 -0700)
> >=20
> > ----------------------------------------------------------------
> > ath.git update for v7.1-rc5
> >=20
> > In ath10k, avoid sending any commands to firmware when it is wedged.
> > In ath11k, fix WMI buffer leaks on error conditions.
> >=20
> > ----------------------------------------------------------------
> > Kang Yang (1):
> >       wifi: ath10k: skip WMI and beacon transmission when device is wed=
ged
> >=20
> > Nicolas Escande (3):
> >       wifi: ath11k: fix error path leaks in some WMI WOW calls
> >       wifi: ath11k: fix error path leaks in some WMI calls
> >       wifi: ath11k: fix error path leak in ath11k_tm_cmd_wmi_ftm()
> >=20
> >  drivers/net/wireless/ath/ath10k/wmi.c      |  15 ++--
> >  drivers/net/wireless/ath/ath11k/testmode.c |   1 +
> >  drivers/net/wireless/ath/ath11k/wmi.c      | 131 +++++++++++++++++++++=
+++-----
> >  3 files changed, 120 insertions(+), 27 deletions(-)
>=20
> Johannes, since this hasn't been processed, please drop it.

OK, done. Sorry about that, had a holiday last Thursday, kids were off
school Friday, and I haven't really fully caught up.

johannes

