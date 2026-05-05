Return-Path: <linux-wireless+bounces-35897-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMiZGurL+Wn3EAMAu9opvQ
	(envelope-from <linux-wireless+bounces-35897-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 12:52:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3B24CBE22
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 12:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1762D309D8F2
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 10:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C9E33ADA4;
	Tue,  5 May 2026 10:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="gWZugj4x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C616401A23
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 10:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777977322; cv=none; b=iSIqW6HTX5Pu+TAyclVxfgmltiksweKbnGMWGW9WHRBuxLcoKX2jhqe228HDfiWNon2vgqvtqkKQDUVcvHmimPuGbqGPI2YZVw81VlNHL2w+AQQkTEV7dSoVfXElZD9a8IkaptBAA54rTs7PDjQpxppJYkEBClJVH7/1iSHW984=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777977322; c=relaxed/simple;
	bh=0RCyVcgL/CtikPBfNCTl4CUwuc0quYxHdOkQWMvsSNE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gUQoaLcHtJp3ikm3+dWVonURKr/MauuR8YGfJZMKKqe0Ta9QKBTiQfokYs3r3U4eWyszt904+nbdFevvyvuVxhqVVmL75lALXridxCeOY/gOcMnSK5C9kXHNiY56S5g8wDdFz78ndbfNLRbd6CaLSQpnqvlWGu9es4wR/VhwjT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=gWZugj4x; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=E8GR/oZD34d9RvqP06aQOKbnx3lK86ZqG4AstrScy8Y=;
	t=1777977320; x=1779186920; b=gWZugj4xLJbcAtvHQrsNLjwHpfuJDyIwTwex+hNRbsdq/Yg
	dyH2daa2UB+IZxl5KFL4pdTxqRSDh2OUgdRKfQCY3LJ/KZxrQl9U3NwnXPSI4rQcfj4mawAUTLnta
	JJCRAOsQMNvJui1236jY28U0TjyA8PX/JEptMNkV0AvdlMp/12MCzPrALAk8mKczZnz0zUaucTmqp
	3TAgZwFtTqdr9A4g0ABSaxJBktauNot2mQnzmJlOX73qxRURTuKZmBV82lfyCzR8+VwOTVtn2QVVo
	K+TINExkYZPVK7HhP2gYZboSa81isr4vghtJFs7RMz3RY0EWv6IpnBVlk1Xlyi/g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wKD7V-0000000G0ZP-2yLg;
	Tue, 05 May 2026 12:35:17 +0200
Message-ID: <6d1b6079bd0c0318e4311bc41a35fc2169a0b4e8.camel@sipsolutions.net>
Subject: Re: [PATCH v2] iw: Makefile: support out-of-tree builds
From: Johannes Berg <johannes@sipsolutions.net>
To: Maxin John <maxin.john@gmail.com>, linux-wireless@vger.kernel.org
Date: Tue, 05 May 2026 12:35:16 +0200
In-Reply-To: <20260429210808.1497335-1-maxin.john@gmail.com> (sfid-20260429_230814_067623_F99A536D)
References: <20260429210808.1497335-1-maxin.john@gmail.com>
	 (sfid-20260429_230814_067623_F99A536D)
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
X-Rspamd-Queue-Id: BD3B24CBE22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-35897-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]

On Thu, 2026-04-30 at 00:08 +0300, Maxin John wrote:


>   - Add support for kernel-style out-of-tree builds using:
>       make O=3D<builddir>
>   - Make SRCDIR computation whitespace-safe by switching to realpath
>   - Remove ambiguous use of "-I." from CPPFLAGS

Thanks for fixing that.

Right now I don't really see _why_ it doesn't work, but it seems
confusing that if you build in-tree first and then try to build out-of-
tree, it just says

	make[1]: Nothing to be done for 'all'.

Maybe that should abort? Or work?

It seems that removing VPATH and changing the %.o rule

-%.o: %.c iw.h nl80211.h nl80211-commands.inc
+%.o: $(SRCDIR)/%.c $(SRCDIR)/iw.h $(SRCDIR)/nl80211.h nl80211-commands.inc

makes that work?

I'll leave it to you though.

johannes

