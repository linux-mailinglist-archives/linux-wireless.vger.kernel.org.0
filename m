Return-Path: <linux-wireless+bounces-37487-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DmQfLK1sJmovWQIAu9opvQ
	(envelope-from <linux-wireless+bounces-37487-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 09:18:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A43C765373B
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 09:18:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=djij09nw;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37487-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37487-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9ED2630013B6
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 07:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E702318EFF;
	Mon,  8 Jun 2026 07:17:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A234B2E718F
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 07:17:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780903079; cv=none; b=NcafYCqIwwMRgKYoizz56OTA8ciZ0nim+KiNwuO3L1nNMbw7hAkw8MSxkO81INWKOoaXgid4E4m2/FNFnADKGgReu+alYL1EwK0Gk3GAr6TiM+THzHJZYH0jVgAbSDwKJvR9ULx3j2Xx6rtOvcOR00J4859Ezti5j+zF7qiHa+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780903079; c=relaxed/simple;
	bh=bVcJmU1JBkw3rIybkfSLygLog0OUJUdrtxxJXjX3vGk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SDVooYijxu7m5k8TRtr3G7ZmdvcJ52tnw9K6yk4uPt1utpB4wp4at/rg9ih//qI3b4INI1xZvCTVfmqt4pKG5GijoI2QADwAaZ3bMvX/Kt0kC76e9VWDeQl1YULUEhUykPR0cn/8nt4wwedT0fYjfHS0UUQ2zEHhY5ZzLC87Qfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=djij09nw; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=UeDU4ktLEM8lXtFt9kqcyMtBd1d+P7EPRUiZl8WNCvw=;
	t=1780903077; x=1782112677; b=djij09nwwZnZ3UichOl4h08f2mpM2ET/pEDIYidqPnJrsm8
	mqHx053xGj6BsVD4Z6jWDhuqnub8TZPHxPYBdRBGMQjJkJrNBKaOBQzuY7DKxW/K/d2rSxIEzV/ec
	SkJ2Aar5sI4QlTbf/UuIVBQc5papuTrLlZnz7s/rKOgTHO+ZBB2I4xLaLH2xjTyoQnRuJVDChsqHp
	T5pxEY4Q+9HXDMwW2BWJ+JPNK58VUpEYuLfFnRTHVn2UyUJf5S3XC4CSSKFjAjAYMdcpw+kIxDHPk
	oUOp5LC++ZCc1dzwwYU2J01Sdn1mGOwO2bVaFfQ1To95CiHS7ZUv/JxeyoV9XrBA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wWUF8-00000005Yzc-0ju0;
	Mon, 08 Jun 2026 09:17:54 +0200
Message-ID: <ba13edbcfa590fe2bd764719b843e6ee8c675310.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 1/5] wifi: cfg80211: Drop unused link
 stats handling in nl80211_send_station()
From: Johannes Berg <johannes@sipsolutions.net>
To: P Praneesh <praneesh.p@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
Date: Mon, 08 Jun 2026 09:17:53 +0200
In-Reply-To: <20260607175912.2266215-2-praneesh.p@oss.qualcomm.com>
References: <20260607175912.2266215-1-praneesh.p@oss.qualcomm.com>
	 <20260607175912.2266215-2-praneesh.p@oss.qualcomm.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:praneesh.p@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37487-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:from_mime,sipsolutions.net:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A43C765373B

On Sun, 2026-06-07 at 23:29 +0530, P Praneesh wrote:
>=20
> -static int nl80211_fill_link_station(struct sk_buff *msg,
> -				     struct cfg80211_registered_device *rdev,
> -				     struct link_station_info *link_sinfo)

It's a bit odd that you're dropping this only to reintroduce it in patch
4, but I guess it served at least to notice that:

> -	link_sinfoattr =3D nla_nest_start_noflag(msg, NL80211_ATTR_STA_INFO);

all of the nla_nest_start() calls in it really shouldn't have been
_noflag in the new code at all.

johannes

