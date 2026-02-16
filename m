Return-Path: <linux-wireless+bounces-31884-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAojLDvpkmkQ0AEAu9opvQ
	(envelope-from <linux-wireless+bounces-31884-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 10:54:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 557621421ED
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 10:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B43023005AB5
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 09:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D705B2EB5BA;
	Mon, 16 Feb 2026 09:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="LzE1oWpu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A462D284B25;
	Mon, 16 Feb 2026 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771235638; cv=none; b=gBbuaiV/qNyv4xcsUXAB1avPf3FzO2DzCdty8yb5JvzYXopL3jpDH9Aih1vY6CJkwPZHj8NcoM/GRmpveW9cZDXKNzJITDhrfhENrYORHwCDyYtHCFgpXYILZUc4oALroXJegBxam5SzHAmc1wMQQuUpsMZs9n4CguE6PvIvQTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771235638; c=relaxed/simple;
	bh=1Qs/r72JEK38J2jotB/JeJfTtaKKfAe3r5+leUabgng=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XdQNKmPHqLeRjWKYa3PXkw73xBN5R43qDEm1cBUvEAbacXGyEkzsE7tAF5pzFhM+qiOo4mmx9fPpy6XlcILidEDeOd1WEzpZ7D/CSIhCL3T5lzZiS/eg6MwotgzkSYtWMlXUe+RZMiqEi8wa40xBY8fynWhH086SWM9rSI1jaD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=LzE1oWpu; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1Qs/r72JEK38J2jotB/JeJfTtaKKfAe3r5+leUabgng=;
	t=1771235637; x=1772445237; b=LzE1oWpuDYxwQ4Id0NCHL8rTAJRWQbd1SZHA9YHwTplhcwF
	WOUQZP/fPwHG3UpdTHB007mkTtvTZV3NsabCtDk+UrQDl6lY8hLABrgqsLxJ/PbrMgDzcXkbCSG/4
	85AzQEvVZukf336+po6cMcYerOYe9DVB2mhiw08Xufe5ovFlGDa3E+EZVu828yhzZVI771Q3ygxZq
	JLaoAo/7nSdMMBHfGAlbcer+F610/YCrhWk7wxdGzVFTsOy74l1EJl6lsXL/Y6r2x6WZ2rdNz0s6/
	upgbVSbBLFkhWGHfPr45S+HIx8oKwT7BBaz5SfdCbZnPcSbTuGWbY4a2fB9wryNg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vrvIW-0000000AOv4-08qH;
	Mon, 16 Feb 2026 10:53:44 +0100
Message-ID: <e7365fadbb7c30690b8be0e6c1fed5ab00eaa9b6.camel@sipsolutions.net>
Subject: Re: [BUG] Potential Null Pointer Dereference in
 ieee80211_process_neg_ttlm_req Function
From: Johannes Berg <johannes@sipsolutions.net>
To: =?UTF-8?Q?=E5=86=AF=E5=98=89=E4=BB=AA?= <23210240148@m.fudan.edu.cn>
Cc: davem <davem@davemloft.net>, edumazet <edumazet@google.com>, kuba	
 <kuba@kernel.org>, pabeni <pabeni@redhat.com>, linux-wireless	
 <linux-wireless@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
 linux-kernel	 <linux-kernel@vger.kernel.org>
Date: Mon, 16 Feb 2026 10:53:43 +0100
In-Reply-To: <tencent_50235033396E84610251D7C1@qq.com>
References: <tencent_50235033396E84610251D7C1@qq.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31884-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 557621421ED
X-Rspamd-Action: no action

Hi,

> Our team recently developed a null-pointer-dereference (NPD) vulnerabilit=
y detection tool

OK, so you decided to write a new tool. Good for you, but keep in mind
that you need to compete with very well-known tools already.

> After manual review,

(and you have:)

> BUILD_BUG_ON(ARRAY_SIZE(direction) !=3D ARRAY_SIZE(elems->ttlm));

So you're either lying, or decided to task someone with this who doesn't
understand C; even state-of-the art LLMs would do better. State of the
art tools (LLMs and not LLMs like coverity) will also give you a
scenario of how the purported bug can actually happen.

I get that you need human feedback to improve your system, but you've
also apparently decided that it's too expensive / too much work / too
hard to really do this review, and you want the Linux community to do it
for you instead. That's cheaper, yay!

But it doesn't work that way. You're not entitled to free feedback for
your under development tool.

Please stop doing this.

johannes

