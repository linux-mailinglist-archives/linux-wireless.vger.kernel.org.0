Return-Path: <linux-wireless+bounces-19846-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA34FA54420
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 09:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A74188BB7B
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 08:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EB318A6B5;
	Thu,  6 Mar 2025 08:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="WY6BTss+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E03BF9F8
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741248153; cv=none; b=iePDTiyDCW6IQndMcw83mMD7Xjd2kDj1gkEeTgx4sdFgSy9Kq3c72Z0Su7HFQKWYqzAoDQgN1d+9Y1UU6XG5ABCkggn8DjYIQg7XiUrRqCUpn3lbGJwfqPxrDHC8fU8UuuX+MwdUBa5Y8JnCtnoGZOGIuemkKTRQOvvug/8yfCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741248153; c=relaxed/simple;
	bh=ezaNaWF76mjg8m933mOoxtaZSKft6FrJBAmiclERHm8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZmzuKOQldxpZwl9uOuObt+EO5D8tQR+tKeR+ZNN2LJYf/y/wUKiqikJSonfxYNcQpNQj6FYF9cyZu9XM5XAhA2Z0lFJdXPpvLl+HgESEbw7yOmUZLjVhT5TADVYkhW4GfKGUZ7BARJ5YtTQU8H3ajW1hpXgMYAbC2A6wHfxs27o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=WY6BTss+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=WudWPbz8e6pksH8ywn8KLJfbwwQHura6TxrAmEwF9a8=;
	t=1741248151; x=1742457751; b=WY6BTss+3AnMg3po5u6Va8QonOUiYRT/JV68M7rYUCjfXs/
	AnKp/th6N8SqSxDc1ELOTolxNTcL85BRXZcY8tM2Sy89MfI/oRno8Wj6k1UJ41bDXpGC9kXDEUUuw
	VJokOhX8Xr3/GLqPZyK0U4Y5TrtXnSTa3MRLhEys/a7BmfvGrMO/hv/ML8vs2S1pdXXpDDnuQVJJv
	2haLRuhGN44KtegvqsHxhhkKjbazyQD6AiG9GVwmto/B3F0qdx0vlebYlBqpbfJi3IVIlAyrt+9h/
	kutUbY1Bh41ptYL7iyatFn1vIKSPBnzDBXcoI9tFEKef3QOJqdjp4ZsuOJhvGuFA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tq6BW-00000002i3t-28Zj;
	Thu, 06 Mar 2025 09:02:26 +0100
Message-ID: <14ab2a58e7603047354a17b2c980c143992a6782.camel@sipsolutions.net>
Subject: Re: wireless-regdb: Allow 6ghz in the US
From: Johannes Berg <johannes@sipsolutions.net>
To: wens@kernel.org, rmandrad@gmail.com
Cc: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>, Dennis
 Bland <dennis@dbperformance.com>, Ping-Ke Shih <pkshih@realtek.com>, 
	linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Date: Thu, 06 Mar 2025 09:02:25 +0100
In-Reply-To: <CAGb2v6689=CmxqOk9rCSXPctg8iCZzOUgcaxdNeB9uHSHzk39Q@mail.gmail.com>
References: <000201db8822$98f28da0$cad7a8e0$@gmail.com>
	 <CAGb2v65490c1m3W_1RkxJ-E7Q=3V_K8xqS2jmd6awcOdzWHXzQ@mail.gmail.com>
	 <ff6ad414457e4b1cb68e834978a553c3@realtek.com>
	 <CAPRryQobXZe5OwR=F-X0KHYyfBwUpFsi=Y5pKnENcUXTN42xAA@mail.gmail.com>
	 <002d01db8da7$daf2ed50$90d8c7f0$@gmail.com>
	 <CAGb2v66Y+rTsuKfQDgv-qwRTOorOucM+qfBOia-gY5sPCJp5qQ@mail.gmail.com>
	 <319c9de5-e26f-45c0-9200-747c86bce303@green-communications.fr>
	 <001a01db8ddc$019e8890$04db99b0$@gmail.com>
	 <CAGb2v6689=CmxqOk9rCSXPctg8iCZzOUgcaxdNeB9uHSHzk39Q@mail.gmail.com>
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

Uh, this is a complex discussion. I do believe that we simply do not
have a way to capture the complexity of the rules in the database today.

Skimming the documentation, it seems that:

 * Paragraph 56: For AP operation, it is allowed to operate an LPI AP
   (indoors, obviously) - we could capture that with NO_OUTDOOR and
   that's what the rule has now.
 * Paragraph 122: For client operation, passive scanning is required,
   presumably because clients are assumed to be mobile and thus also
   present outdoors, where they will also scan.
   This can only be captured with NO_IR today.
 * There are additional spectral density power limits in paragraph 59,
   which cannot be captured by the database today.

However, the combination of these really cannot be captured - NO_IR will
also prevent AP operation, which I think is the issue discussed in this
thread, but removing NO_IR will make clients break Paragraph 122.

I'll note that in general scanning on the 6/7 GHz band, by 802.11 spec,
is only active on the few Preferred Scanning Channels (PSCs), however,
that'd _still_ break Paragraph 122.


Unfortunately, it's also hard to fix - we cannot remove NO_IR because
that's used by older kernels, so I think the only way to fix it would be
to add a flag a la NL80211_RRF_ALLOW_6GHZ_VLP_AP (which translates to
IEEE80211_CHAN_ALLOW_6GHZ_VLP_AP) which overrides NO_IR for this
specific case.

We also have reg_rule->psd internally already, I guess we just never
added a way to convey it from userspace? Not sure what it even does
though.

johannes

