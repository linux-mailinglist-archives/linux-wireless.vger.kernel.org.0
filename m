Return-Path: <linux-wireless+bounces-37098-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OC+PHTAwGWq9sQgAu9opvQ
	(envelope-from <linux-wireless+bounces-37098-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 08:20:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E60C35FDDE5
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 08:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E44E93009F2A
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 06:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160FD30567B;
	Fri, 29 May 2026 06:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NRDUI+Zr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417B52C15A5;
	Fri, 29 May 2026 06:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780035622; cv=none; b=muCJ3qT6b92yfFojPo3ITcwnLZvT3GgeIFx0EuI+7j8ctoaGnclLy57knVsgbiYH8L3VNxNBIGFGHTzYDSDE8ysOu1B3MBODrqu0uEA1Nsm0uDSYt9Nzw5sU6zZ66L3AsdHEB/HqgINXG5GD2K5PuaQGL4qxZRk/tFVK5xeBwzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780035622; c=relaxed/simple;
	bh=qCaNf6MHD7X8HMRsT1uomZar47lbzVSpDYtfi0wZHX0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Oy4z5DiFudRAW4JCUyuNka5R9ifYAMicEphl2Xgi3gMsLagvInFouLwYMOa07CxNka+xwNSWJQ+tkBgxSO/F0H+lqD/1/+ssNntRUmaBqAZ5iMBUOLxZPlDtMd4S3RyLnpb4Gia7dHO7CnqmSBSJXZKjTBb9rOfrQCYKAkYwZ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NRDUI+Zr; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=qCaNf6MHD7X8HMRsT1uomZar47lbzVSpDYtfi0wZHX0=;
	t=1780035619; x=1781245219; b=NRDUI+Zr67ZPvJuByjaC9QiC3n4FZi6ut5gGy18sA0qL87v
	280/1jKXJOkSrtqMFJFDDAVm5pXd8uUeVNzTaZjm25vlxwOtdaOT0vhqqMyw5getwwtDF5DFtSg3L
	9/tIOCEe/1b0hPDisQMCwoDMU2tQxwtMSFX/8+3wXOpB/JIfvvkHmWXfRKWClQ5WzYJZjl8aIRKmd
	cra/XgDC7DGfR4uXVlw9NRVR3yNxTkE7Oh/4JFlxP5c3fg/nZ23ukBaueVH05fmKKGRy9E8h0D0DD
	YHqCNQdUZxhSZzURHP/0N0AzYUGShcfhd/BKHkt2lCN1VsWY5hg2Q5YDY/I9H7Lw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wSqZr-00000009WRV-1H0w;
	Fri, 29 May 2026 08:20:15 +0200
Message-ID: <fc34f52ed88ee22b776828f06489a043316456a8.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211_hwsim: handle 5/10 MHz chanctx in rc
 update
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>, meihaipeng
	 <meihaipeng@uniontech.com>
Cc: Andrei Otcheretianski <andrei.otcheretianski@intel.com>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+c0472dd80bb8f668625f@syzkaller.appspotmail.com
Date: Fri, 29 May 2026 08:20:13 +0200
In-Reply-To: <qrtsnjplvmg2pbq2cym5s3c5zxm5lrxw5dui26ks4jbbmmqhem@uwzblpmgdi5h> (sfid-20260529_071103_051144_2118964C)
References: <20260529040923.9816-1-meihaipeng@uniontech.com>
	 <qrtsnjplvmg2pbq2cym5s3c5zxm5lrxw5dui26ks4jbbmmqhem@uwzblpmgdi5h>
	 (sfid-20260529_071103_051144_2118964C)
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37098-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,c0472dd80bb8f668625f];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,uniontech.com:email,contexts.so:url,appspotmail.com:email]
X-Rspamd-Queue-Id: E60C35FDDE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-05-29 at 15:10 +1000, Lachlan Hodges wrote:
> Hi,
>=20
> > The STA bandwidth enum has no sub-20 MHz states, so a normal 20 MHz lin=
k=20
> > STA falsely trips the warning on 5/10 MHz OCB channel contexts.so=20
> > a normal 20 MHz link STA falsely trips the warning on 5/10 MHz OCB=20
> > channel contexts.
>=20
> There is also S1G widths :) but that doesn't really matter.
>=20
> > Treat sub-20 MHz channel contexts as 20 MHz for this validation and use=
=20
> > the actual channel-context width in the warning message.
> >=20
> > Fixes: aea9a6088ae46 ("wifi: mac80211_hwsim: do rc update per link")
> > Reported-by: syzbot+c0472dd80bb8f668625f@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Dc0472dd80bb8f668625f
> > Signed-off-by: meihaipeng <meihaipeng@uniontech.com>
>=20
> Looking at the stack trace of this report and a few of the others,
> it comes from mac80211_hwsim_sta_add() which calls the rc_update on
> the new STA, so it would probably be better to do something similar
> to what we did for S1G [1] since I'm pretty sure the rc_update()
> path isn't reachable on 5/10MHz (just like S1G).

I don't know if it is or isn't, but a simpler change like that would
indeed seem preferable.

> Though there are also quite a few 5/10MHz syzbot reports for various
> things similar so maybe it's not worth it.. but that is up to
> Johannes :).

Yeah, I'm still going to rip it out entirely soon.

johannes

