Return-Path: <linux-wireless+bounces-36698-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHx5K5eZDWoMzwUAu9opvQ
	(envelope-from <linux-wireless+bounces-36698-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 13:23:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0D058C546
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 13:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A61093105193
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 11:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39A63976B2;
	Wed, 20 May 2026 11:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="PL1VzSK9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240FA376A1B
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 11:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779275811; cv=none; b=kPLOzluv5onZ97wKn3XmLGJsJFi/odJKAyTqJxk6etfAYBCxyP6NSRNvwMssHQqO6rS2n06Oz690EaEvurYeV0M0KeVsqv2GVaYDHIOpNNd35079SoxebWJstyvS50p4FsQVE2CZ9nxbmYDLwbYi1BMY9e+PURr1LBdj+wdPqRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779275811; c=relaxed/simple;
	bh=5tQ8US/2JzhejxCco8wv9+nnrdPOpOe9BqV98X6GCnM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KcAyYCap3U2kDPIx1/8l3NKyrDFik26kCZrfFYmDTHpeZQ+xMN/f9/JNbhh/Lh2vRauGOfk2BIqvN4Skdi6r0nRnwsaUlONLWrp3zrNhxyhLE9FAPOH35E5/3UwDfVCAU62NyUDHIt7GPwKcMSEz6W65uySWkgMgH0htMSW824w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=PL1VzSK9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=numl/wx2ZK0mhjaGaR5++utJaiL7J+0PzZIcSyr8Fdo=;
	t=1779275808; x=1780485408; b=PL1VzSK9T+j5ERYNlqau1mWSmnUCJX16ox3hWLET5wm96j4
	+px0jK1ldW4WZL7oqsC+RLdTYO5+muLVCJMHQi9uVZvZ94Y74zvDu4pQWYQB76+7FLQED27dS445M
	mn5izYjBoCHItEjOh5WoUtnKfU38t4fyKFJODwAKXtlfcR1ljPJkcqpenP88nzkARxu69wqSuuFfg
	5KKCMiP71mW3BSYsZJz5cSsK07RAxfSxxRp7vYc6sRMQkQdksxKwBy+l5uEuREOInPaoA2gv5kIVZ
	gsXEpisF+ggRdIuDdbYfh6TrPRYCqIw0dacWrs/MOC5fIuwZuMs78oVhUMjOab4g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wPeup-0000000AKcm-3bsW;
	Wed, 20 May 2026 13:16:44 +0200
Message-ID: <46554aec366d99839894bbcca066daa3450df9d2.camel@sipsolutions.net>
Subject: Re: [PATCH v6 5/6] wifi: mac80211: Fix overread in PREP frame
 processing
From: Johannes Berg <johannes@sipsolutions.net>
To: Masashi Honma <masashi.honma@gmail.com>, linux-wireless@vger.kernel.org
Date: Wed, 20 May 2026 13:16:42 +0200
In-Reply-To: <20260515233839.86829-5-masashi.honma@gmail.com>
References: <20260515233839.86829-1-masashi.honma@gmail.com>
	 <20260515233839.86829-5-masashi.honma@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36698-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 2F0D058C546
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 2026-05-16 at 08:38 +0900, Masashi Honma wrote:
>=20
> +/* IEEE Std 802.11-2016 9.4.2.114 PREP element */
> +static inline bool ieee80211_mesh_prep_size_ok(const u8 *pos, u8 elen)
> +{
...

> +	if (elen !=3D needed)
> +		return false;
> +
> +	return true;

nit: maybe just "return elen =3D=3D needed;"

johannes

