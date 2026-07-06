Return-Path: <linux-wireless+bounces-38677-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GpT3CGyXS2qUWAEAu9opvQ
	(envelope-from <linux-wireless+bounces-38677-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 13:54:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E627101FD
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 13:54:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=eO5FLdZ9;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38677-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38677-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 390B7307860C
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 11:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEEB420E6F;
	Mon,  6 Jul 2026 11:44:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F5C41F7FE;
	Mon,  6 Jul 2026 11:44:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783338242; cv=none; b=CsRhmprrx5UZp3I6LUfVwMg3IKc08E4nPEM7kBozrOxCERceOU6GmtLaAZrn/cEF4hhRDkQQppfy5cHc1BDW3jtA8B+kvcfExDcrR+prQz8Ld5uUcY8GV0DaC4wRsZAORJKs6u6aTQZrYTeUpH/U7qEOQs6TWJfqOY7ZyIEaM/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783338242; c=relaxed/simple;
	bh=plBVaffl2mIwjuxdTuECBJbzvJ28TQ3UZxRX27b5Ylk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KhzAGeHC5YzLfrWehrGimvWeJ5aNeeE7jxmSCYrSwiignrN4tbTDJDIdCVuQR694gVZvJ2QlqbPLGWeOs4kG1BIEm3UWZBpvKBgIEXtmbyPS38XL+mMCGa11BWybuY8alRw8XGQPjVEISC00o5a9nBlNDpf1NeJTwqyZJpwhlFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=eO5FLdZ9; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=plBVaffl2mIwjuxdTuECBJbzvJ28TQ3UZxRX27b5Ylk=;
	t=1783338241; x=1784547841; b=eO5FLdZ9jsLKFe7WtrJIp+z27F8KHVfxRgEbZe3cXs+E4Up
	4eX4OEyPT9FzmIm/ufDk8Wat20Cba473T3CnAIPuoyVt7rKSMphCRT0otZtfMBL/roT9roRddMCH2
	xKTbJS1U7OVA4DcXJl58mTSgIqvzdHs0kTJ9fK6WV6ffASYZ7BF75yK2VsMJXlDc1QTo+6dAn0OXK
	AtjPNL0vBnnkfX0dzn6ufV9VWEqOZrPQ2J3M9PSpPYnPgdYIowAvaM/AZ4E3x5E3NY8wtU8Y3u5L+
	xHN3K07KzIZgmN3S9piDAG4JahU/2Y41XVx2XnHYZaPnE0Dqx+qTYBX+GHUn4WPA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wghjy-0000000DMl0-1DXf;
	Mon, 06 Jul 2026 13:43:59 +0200
Message-ID: <b4129a5d4d11080726c460955579851198c879f5.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: bound element ID read when checking
 non-inheritance
From: Johannes Berg <johannes@sipsolutions.net>
To: HE WEI =?UTF-8?Q?=28=E3=82=AE=E3=82=AB=E3=82=AF=29?= <skyexpoc@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 06 Jul 2026 13:43:57 +0200
In-Reply-To: <20260626144543.5034-1-skyexpoc@gmail.com> (sfid-20260626_164554_761438_F676B9B9)
References: <20260626144543.5034-1-skyexpoc@gmail.com>
	 (sfid-20260626_164554_761438_F676B9B9)
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:skyexpoc@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-38677-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:from_mime,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75E627101FD

On Fri, 2026-06-26 at 23:45 +0900, HE WEI (=E3=82=AE=E3=82=AB=E3=82=AF) wro=
te:

>=20
> Fixes: dfd9aa3e7a45 ("wifi: cfg80211: rewrite merging of inherited elemen=
ts")

This doesn't seem right at all?

johannes

