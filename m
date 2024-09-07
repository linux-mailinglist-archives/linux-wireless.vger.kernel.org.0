Return-Path: <linux-wireless+bounces-12626-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD3A970402
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Sep 2024 22:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A9E6B221E8
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Sep 2024 20:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B53166312;
	Sat,  7 Sep 2024 20:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="s/McCRRF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484713AC28;
	Sat,  7 Sep 2024 20:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725739734; cv=none; b=i6H9qmi4WFzo7JxONHT7N1c1+V4cklosyOFqbiB7hj06qNg0Vk/VbJufUWKk4r91OaGBrVkuJM44sO0jkkXpflg+3i2tEQhHafnbEwwhfXxx+9peY4oPTk5hKVx91yY4truJ+xl8XGOZ0WdhkE3ZS96GMSSuCf6wVzNgYTgDBmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725739734; c=relaxed/simple;
	bh=8WS3DP/Q5AggWJPXwlUe5+pEn20X5Npoi+xLJkiXNQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMT3h3G2R0GIsYtrsk/GmtMI5OWtvwjzVTf9KynUumODfoeUkcqtY2K0XhFXBL/Mv1wm/MiAssHXl0RGA/gdAAg0kRJPRWZFez2ZnFpvW67hpmDPghnmIQjKEdYhTKCTaw+K+iX6xetR3548VGn/WWL7To/+Xn1U8O9sJ5d7UZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=s/McCRRF; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rThieTOE2Tr4u1u1Kqt8lk6rUxMUTyzNSCcSJ5PvHYs=; b=s/McCRRFGl1lrxX3+S56q8ZWPc
	sZ5KQCMfH4kyfiRDDud/h/nKLeJwD8mq+YwyGhAfNXZJCqlzIz2k/JFNM+NF2E9xYE5etnp2Qdd1Z
	PUYR0IRdCuKhN/ayJEZYqwc/qvuaG9b7jah6vRwl6KAotr43ncuxU2ebNSd4T42h9JXECKbdihMOC
	0JPg99S5ea2GgJLZtyTE0MIlUYg+JiL5yxkRvwjJV/KZZZRxQMSjIxaanM8JbtlBrodP7tg8drSbz
	0FHZmk4stX46jJJ/XaHMvtJClbDRRoXeOZskUcpxM8/7sQwKhY6TB0Exk7t1fsGCuevzqqGoi9A40
	vjREYvsg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sn1ji-00000009vhJ-1ZIL;
	Sat, 07 Sep 2024 20:08:46 +0000
Date: Sat, 7 Sep 2024 21:08:46 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Rohit Chavan <roheetchavan@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib80211: Use ERR_CAST() to return
Message-ID: <20240907200846.GJ1049718@ZenIV>
References: <20240906114455.730559-1-roheetchavan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906114455.730559-1-roheetchavan@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Sep 06, 2024 at 05:14:55PM +0530, Rohit Chavan wrote:
> Using ERR_CAST() is more reasonable and safer, When it is necessary
> to convert the type of an error pointer and return it.

Why is it safer?

Please, explain the reasoning that had lead you to this conclusion.
This is a serious request, BTW.

From my reading of that code (and its well-hidden callers - AFAICS, those
are
drivers/net/wireless/intel/ipw2x00/libipw_wx.c:382:                     new_crypt->priv = new_crypt->ops->init(key);
drivers/net/wireless/intel/ipw2x00/libipw_wx.c:611:                     new_crypt->priv = new_crypt->ops->init(idx);
drivers/staging/rtl8192e/rtllib_wx.c:347:                       new_crypt->priv = new_crypt->ops->init(key);
drivers/staging/rtl8192e/rtllib_wx.c:570:                       new_crypt->priv = new_crypt->ops->init(idx);
) what we have is unfortunate calling conventions for that ->init() method.

It reports failures by returning NULL; that's not a good idea for
something that is supposed to allocate a crypto-algorithm-specific
object, since anything that does *NOT* need any allocations at all
can't just return NULL.

This "(void *)1" is basically "let me invent some non-NULL pointer,
I won't be using it at all".  Yes, it's a kludge; there are more idiomatic
ways, but that really ought to be discussed with maintainers, especially
since there are only two places using that sucker in the first place,
one of them being in staging...

In any case, that (void *)1 is _not_ something you want to express as
ERR_CAST() (or ERR_PTR(), for that matter); that would only make the damn
thing harder for readers.

Speaking of making things harder for readers, near the 4th of these callers
there's something weird:
        ops = lib80211_get_crypto_ops(alg);
        if (!ops) {
                char tempbuf[100];

                memset(tempbuf, 0x00, 100);
                sprintf(tempbuf, "%s", module);
                request_module("%s", tempbuf);
                ops = lib80211_get_crypto_ops(alg);
        }

What the hell is going on there?  module is one of the "rtllib_crypt_wep",
"rtllib_crypt_tkip" and "rtllib_crypt_ccmp"...  Looks like a very odd
obfuscation; other callers also come with calls of request_module(),
but those don't do that insane dance...

