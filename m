Return-Path: <linux-wireless+bounces-22449-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E26BFAA8F01
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 11:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3535D189785E
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 09:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8473E1F416C;
	Mon,  5 May 2025 09:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="CKRL1TwN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9011A5BAE;
	Mon,  5 May 2025 09:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746436234; cv=none; b=lHo+U/wAQM0bQP03c473Z9KQLISmXLiXlsc+46Z8pPh0Q1zZtEBwIo79iZON2Uh6FGTupTJZM4CSy4iJIF5L/EdYCcv3hA9UpW7nqBYq2jxJz+RhavInKPXk9xMGcy8G/4hqhuJIHQ0E6ZxKfN2mBAwmPcMqZtupkh/NB1XJF8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746436234; c=relaxed/simple;
	bh=BsoJw9Awkc2b9z0Ir3SPQ6bfTit5OupPAahv1L/C5n8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KGFgJl+5DsA6iC0A7bvzW8s7Izin5QwIL+MfUAMP1lZ0tgfowr+0vAEsAI60qTezEXIM0yzDL6dZ8YSnA2AhsH8wF5zSPArKxAYn/8WlbAdkqS9TfXJWWx5E3oB2HaiW7sj1EPk/pJfUGaqzUbqo4M0Bqgsy2kfznmv5xrXhaQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=CKRL1TwN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DSB+wJ+TDPRmWBcqAGxu93uKfUHoTJ506dWsYvX2S+c=;
	t=1746436232; x=1747645832; b=CKRL1TwNfwmtV7wPYtYvEuP5uoxa953jgbv8EqAlsnP8aWh
	4AVFY/wtnzohLiCJRvQLXApMRICgDOjXgTNQ2ny34fq6PsgTNX9ZW5+k3b9Px2fIdO3cNwFgS4HSD
	pt9frtt5oxIE5xv9mt1KW9+K/KMEfMWJOLifrh63uOBVmO73YUkpttr3ynOvUGam7VIdWM7o5qS1v
	/YGC1p4L5ulTqLq5xFsyKOmQFWODr/C+UpoBHpWE3y5LqPPudb9+rmZfaEbYBNXAAuRipXdqO058j
	pb7vdkj1FMOOQ3cW7Tp2r2xVNzcyE0m1HbOWTcaKBDWpwYcSnlVvaR6sJz6IqCbg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uBrqG-000000046Hp-2D0t;
	Mon, 05 May 2025 11:10:28 +0200
Message-ID: <004030652d592b379e730be2f0344bebc4a03475.camel@sipsolutions.net>
Subject: Re: [PATCH net-next v5 10/10] netlink: specs: wireless: add a spec
 for nl80211
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
 linux-wireless@vger.kernel.org, donald.hunter@redhat.com
Date: Mon, 05 May 2025 11:10:27 +0200
In-Reply-To: <20250503130739.1c94d433@kernel.org>
References: <20250211120127.84858-1-donald.hunter@gmail.com>
		<20250211120127.84858-11-donald.hunter@gmail.com>
	 <20250503130739.1c94d433@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sat, 2025-05-03 at 13:07 -0700, Jakub Kicinski wrote:
> Looks like we have 3 structs in the Netlink spec:
>  - ieee80211-ht-cap
>  - ieee80211-mcs-info
>  - ieee80211-vht-mcs-info
> which are defined in include/linux/ieee80211.h rather than the uAPI,
> but we do use them in Netlink attrs. I'm guessing these come from=20
> the IEEE spec so there is no ambiguity?

Yes. In some of these cases userspace has different definitions that
match the same bits, but might have e.g. __le32 vs. u8 for some fields
and then just has a different number of fields. For HT it looks pretty
similar though.

Certainly there are many more in this area that could have a similar
situation. There are also new ones where there's maybe not a good struct
representation at all, unless you care only about special cases (which
may well be appropriate for some tools, but not for the API.)

> I'm trying to figure out what to do with them in the C codegen
> for YNL. Normally we assume all structs used by the spec are defined
> in the headers. We can add an annotation to render the definition
> in user space code, but I wonder if this omission is really intentional?
> Wouldn't it be generally useful to user space to expose the types=20
> in uAPI?

We never even conceptually exposed these in the original nl80211.h, that
just literally said it's the HT capability element, without caring how
you arrived at the bytes representing it. We did define the length for
the policy check, but I guess in some way even that isn't needed.

I'm not really sure it really is all that useful given that different
tools care about different things and restrictions (endian, etc.).

I also don't know if we'd really want the kernel to become the canonical
definition of structures used for elements defined in the spec., but
then is it restricted to those that need to be in the userspace API?
That would also feel a bit odd?

So not sure. I'd almost prefer to just remove the struct annotation from
the spec here.

johannes

