Return-Path: <linux-wireless+bounces-38194-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mL45BL/xPmp7NQkAu9opvQ
	(envelope-from <linux-wireless+bounces-38194-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 23:40:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECA46D050C
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 23:40:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=vPXuG2ni;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38194-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38194-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 300B73079957
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 21:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A253C060E;
	Fri, 26 Jun 2026 21:36:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C282DC792;
	Fri, 26 Jun 2026 21:36:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782509805; cv=none; b=L0Np/H+QzO1ocvjej/mZXHtDuGs6D3IsoNBVUBi+gpn0YjdnIpPejbNafL2KphsnDy4IK0GvaxgUAqCJXG6CNNDqx6HVf9T4TjGyc5oGdzDdUtQ2++rO0V1R7v86V1303Sx7dWv9rKEM8/9uY6VUAZSF3BeIpFK+VBO7Vk4GaxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782509805; c=relaxed/simple;
	bh=zckgT7PpISHzXUahsmEIGOhJiYtmj8pDLtMjbiYTLt0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b75NdD6dkgBWTZOwnSqQH245M9rc0Zr267FOFG73ob5RIN8dj45Y+jqBiZZiFfee9CUJTEMhCyIJjfOckkkv2KVvRN/kNuemeFP+y3BesxdAC+GI8S6/m82y2XQZQnKON1Q09WDrFqzr5h+kT7FnDDDkP3j3GEPdH2kn6ZM0g/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vPXuG2ni; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zckgT7PpISHzXUahsmEIGOhJiYtmj8pDLtMjbiYTLt0=;
	t=1782509803; x=1783719403; b=vPXuG2niNK3mWFCH05ewAzqIVwSLUq1Klcs2iU2o2YHD7wK
	4NPa+P6tejpUweoj3GlLuiGea1tQJ+yEjUyzcXREGpBVrvU0K48WD+W3tMkyn51DNbJpZVhnfTuxN
	SL9nkrW6t4/bcGL+YsGJa2yy6kXPPRiTVuqzda6L6mqK7lTiNF3N6UjAK0hqQYu0reZppHMgpXFcr
	dm2m93a+YAF9OL5/7g9+pDHxfCHqlYHtPUyaTFER2+OlazBsmhKQ/hks4n3+iLmLJ3M5PsHcokfAi
	tvsL2jGrCKlOprLOmQwFzVfSWzLTEwdFusCKemRDXYXmvFGshftNHWZHKHUTLspQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wdEDO-00000007yYc-41o5;
	Fri, 26 Jun 2026 23:35:59 +0200
Message-ID: <2bc48524a11ab0065b33c8a02b4c442665852d93.camel@sipsolutions.net>
Subject: Re: WARNING: at rate_control_rate_init, CPU: syz.NUM.NUM/NUM
From: Johannes Berg <johannes@sipsolutions.net>
To: sanan.hasanou@gmail.com, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com, contact@pgazz.com
Date: Fri, 26 Jun 2026 23:35:57 +0200
In-Reply-To: <6a3eedeb.87857ece.10923b.5b31@mx.google.com> (sfid-20260626_232358_999373_6E38D4CE)
References: <6a3eedeb.87857ece.10923b.5b31@mx.google.com>
	 (sfid-20260626_232358_999373_6E38D4CE)
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:sanan.hasanou@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzkaller@googlegroups.com,m:contact@pgazz.com,m:sananhasanou@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-38194-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,syzkaller.appspot.com:url,sipsolutions.net:dkim,sipsolutions.net:mid,sipsolutions.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8ECA46D050C

Dear people who run modified versions of syzkaller,

> Kernel Branch: 7.0-rc1

It might be a good idea not to use an old version.

> ------------[ cut here ]------------
> WARNING: at rate_control_rate_init+0x3a4/0x420 net/mac80211/rate.c:53, CP=
U#0: syz.7.23087/97240

and it might also be a good idea to check if syzbot already reported it:
https://syzkaller.appspot.com/bug?extid=3D9bdc0c5998ab45b05030

(FWIW, I'm not really entirely sure of the bisect)

Thanks for reducing (future) noise,
johannes

