Return-Path: <linux-wireless+bounces-36999-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ICuLaXDFmrOqgcAu9opvQ
	(envelope-from <linux-wireless+bounces-36999-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 12:12:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5895E26F1
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 12:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDC98307E018
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 10:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4341990A7;
	Wed, 27 May 2026 10:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="USZZYD1/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9203EB80D
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 10:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779876242; cv=none; b=kSKjXORgLMflGOUJa3RLiqqnVWqdHRUjeIBII8B7kPYPxkwsgmRDy7rmuXxuApc00ndDZVAPg616tfSRJEEpcW+YKavY0VDJrK7WM71MxmyiZQLgFaASJfGjo4vR4XxYITphUxy4nw84OeagAX91Fyr/FmL0m3Y4oWDrOvjd9ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779876242; c=relaxed/simple;
	bh=j6FG7xA2pZwEC5MavDC0QTpuK0b1qj8/5O4R+HZWG/A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mFQCb1LQvDpPfq1PXn4aupple+lbefxQ/sEyEFSwknG115hcTB9IY84kEIMrWUwL/tym1e+fHP+gFZ1Z9SiyVZsy2dpFUVdPSb3OP7bbzdmSyCK40SazS9IorysgOe90itDL8qzRS1UaGf5mnHV0efudnwyBFwFBLj6FW9M6v6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=USZZYD1/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=j6FG7xA2pZwEC5MavDC0QTpuK0b1qj8/5O4R+HZWG/A=;
	t=1779876240; x=1781085840; b=USZZYD1/4EtrkYkZpA6cXA6BpmRbRKqOddFq2H5PEBrvCW+
	8Xj1/xpIgKsHx4Q1h1kyrmCOtAXH6EB72NMUUrPmaqXTxfsfplHSFXa9A/hJR18xQisfn19X89JJa
	5p3ocL2HkCRU73n0lFxGKxdyJU/ZbdSDpSZ/tSkiCKMjCTibBlP2MZDqDra4cmMGK3vOvg5RHRBYu
	8g1bl0k9PMeT05tbhmrIHya2tfH2Unk7NAGrqfKfBuI1F/Kf67q/Ubd3FS30bFpKLTG6YaWV6P0Og
	R4nyl8btzqjaA5glHKZku38jfgXqA0WUkqQlzxOYjGQwAm5yQlRoOEJfHnht0XPQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wSB7A-000000060HR-3mh8;
	Wed, 27 May 2026 12:03:53 +0200
Message-ID: <ef415ae9222bc9ea978469c88cd7b1e7646710e6.camel@sipsolutions.net>
Subject: Re: [PATCH 1/1] wifi: nl80211: reject oversized EMA RNR element
 lists
From: Johannes Berg <johannes@sipsolutions.net>
To: Ren Wei <n05ec@lzu.edu.cn>, linux-wireless@vger.kernel.org
Cc: quic_alokad@quicinc.com, yuantan098@gmail.com, zcliangcn@gmail.com, 
	bird@lzu.edu.cn, xuyq21@lenovo.com
Date: Wed, 27 May 2026 12:03:52 +0200
In-Reply-To: <db614d22c4d3cdae0f5fb94b9d78c8e3142c2ecd.1779632165.git.xuyq21@lenovo.com>
References: <cover.1779632165.git.xuyq21@lenovo.com>
	 <db614d22c4d3cdae0f5fb94b9d78c8e3142c2ecd.1779632165.git.xuyq21@lenovo.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[quicinc.com,gmail.com,lzu.edu.cn,lenovo.com];
	TAGGED_FROM(0.00)[bounces-36999-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lenovo.com:email,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 1A5895E26F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-05-27 at 18:01 +0800, Ren Wei wrote:
> From: Yuqi Xu <xuyq21@lenovo.com>
>=20
> nl80211_parse_rnr_elems() stores the parsed element count in a
> u8-backed cfg80211_rnr_elems::cnt field and uses that count to size
> the flexible array allocation.
>=20
> Reject nested NL80211_ATTR_EMA_RNR_ELEMS input once the count reaches
> 255, before incrementing it again. This keeps the parser aligned with
> the data structure it fills and matches the existing bound check used
> by nl80211_parse_mbssid_elems().
>=20
> Fixes: dbbb27e183b1568d5a907ace1cd144b0709ea52a ("cfg80211: support RNR f=
or EMA AP")

Please fix.

johannes


