Return-Path: <linux-wireless+bounces-29558-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8828CAA8BE
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Dec 2025 15:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AA26E300F00F
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Dec 2025 14:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5E32566DD;
	Sat,  6 Dec 2025 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fMVTo4hr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CB04C9D;
	Sat,  6 Dec 2025 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765033010; cv=none; b=CtiHGy2wE1Z4QoSQGNLLcUdwS/68YQCT9Aob7NOc2XIyKLVBDEry8FLdkO02wnpsncI3ev/jmWrje2SY9CIPbr6LwDvcQr+L520ClYAVpnoxSICuK/iCfgoHsAX1Lg8N3KYEIUl89rsh6M2wzBICF0B2kjHqao5hRzlZMwDm8dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765033010; c=relaxed/simple;
	bh=fKjHQw0tSALZOGFQMhZDC50I/ycMDuwNnakL0ZIIqWw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ki/jg3v97g3qPtrKszrueIPP9Mlz/NPA0LM8Pht0uwHaSs5Sz7DlCarSb9SpnFZvqV997hvSZvJaq2jkskp6juflJ+A80OqeQBatMBxhJLR+0iAGhr3icaaqFWG3UNCdUzkotke4c5S6QbbGk5u5ab/KhCGd3TSG/ZKBfjfNBjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fMVTo4hr; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=fKjHQw0tSALZOGFQMhZDC50I/ycMDuwNnakL0ZIIqWw=;
	t=1765033008; x=1766242608; b=fMVTo4hrq7OpV3worKhAmCz6L+8QIZbNt+y/bF57R4XdhUm
	jewP9ezKZIF2mc6Ul71m30QX7q9Xd6ch5WGLuqhhH6tFmBu8Ek06WwezefFrdZ4AJq3ApJyJlvqVR
	5ytpksQssH/2SQbzlEbpAPOix+P+KytRj9luhMWzFLBAXeWn+TwNJBiJlkgQOoQSGr5+m0PtrAOhl
	izRwQfgtlIUHZ6lqiB+Wfy11SgA07aueQ41jBI6exRvhYZb4dX1A/NsB3XrerYNPzPk8D5korkT5n
	WbYUOupZfF6eiLtSd+VtiZabbcpY5aEfBtqXjOPHUJtCUdSb+V/XFtr78pZQh+BQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vRtiG-0000000B0gA-236z;
	Sat, 06 Dec 2025 15:56:44 +0100
Message-ID: <6cc422bb9525be529c6b0d2d25f9869ca41ec77d.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211_hwsim: fix divide error in
 mac80211_hwsim_link_info_changed
From: Johannes Berg <johannes@sipsolutions.net>
To: Deepakkumar Karn <dkarn@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	shaul.triebitz@intel.com, 
	syzbot+5bb5f06f99924ea0cf86@syzkaller.appspotmail.com
Date: Sat, 06 Dec 2025 15:56:43 +0100
In-Reply-To: <20251205230344.326220-1-dkarn@redhat.com>
References: 
	<717b98574a9037a5e81c929f97cc1258e00ee2f7.camel@sipsolutions.net>
	 <20251205230344.326220-1-dkarn@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sat, 2025-12-06 at 04:33 +0530, Deepakkumar Karn wrote:
> On Fri, 05 Dec 2025 18:39:49 +0100, Johannes Berg wrote:
> > Seems like we should not let userspace do that, to protect all other
> > drivers too, not just hwsim.
> =20
> As suggested, we should provide a zero-value division check for other=20
> drivers as well. I will investigate other places where divide errors can=
=20
> occur due to edge cases.

What, no no.

> Please let me know if you meant something different. In the meantime,
> I will analyze other drivers for similar cases.

I did. My point is we shouldn't _have_ to check any drivers for this at
all, it's nonsense and higher layers (here cfg80211) should reject it.

johannes

