Return-Path: <linux-wireless+bounces-30225-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEFDCEBCC7
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 11:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3514B300E78D
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 10:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF29831BCAE;
	Wed, 31 Dec 2025 10:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="j49yk9EK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E3A313E2A;
	Wed, 31 Dec 2025 10:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767177371; cv=none; b=RGL+IeyjxspPEdlome3NOp1O+4DZRvxSpUPzNLbG4HJRsFwKxc3h0PuKLRz6pVKhTspVdH70vxatTZfZkxP4pbr7sTduoJkZwv96HuiyOO57WB6zgNX0uewg9vicZk0IlRO1dhE/evXj7z5rKKqz6k1GcpySvcNgoaQVSzkXsSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767177371; c=relaxed/simple;
	bh=LDF4ARuzunhfsj6zAMmkog9ma6Ip1TH3chjUte6eewY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPRvAvzxEFiQrhpLwnCJp7BPjSHZZ3rZ+MEbTnzbOZr8IEw4C8Qt5MJpB22vIHKX5yaC6rM7JYWnRFMSnOsU0bK5jz9lNm+VNl80hMmVqE3Mbcwczmw751dKQO42oSR6Rdf1nzDUv1VpfnC9kArSRfJKmI015U/1r6Uodso1ThY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=j49yk9EK; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1767177360;
	bh=LDF4ARuzunhfsj6zAMmkog9ma6Ip1TH3chjUte6eewY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j49yk9EKPJTUpBpb5EDnRRzqNE+RPpfciqoQWEyUYz3KyccoNvTL3C2HmL2p8tT6z
	 ewhpjmJDDe85/47XHYuB9vQKi9VMcFPVaWzmzqQOq0TFfGuqQhecqTgMAJrLlTojnb
	 1v0SbsX/9t9GFVJcH5LRlnuOaLlCWAcFIdS+pI7o=
Date: Wed, 31 Dec 2025 11:36:00 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Matthew Schwartz <matthew.schwartz@linux.dev>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Eric Biggers <ebiggers@kernel.org>, 
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, Mario Limonciello <superm1@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, quan.zhou@mediatek.com, Felix Fietkau <nbd@nbd.name>, 
	lorenzo@kernel.org, ryder.lee@mediatek.com, linux-wireless@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	linux-mediatek@lists.infradead.org, shuah <shuah@kernel.org>
Subject: Re: Linux 6.19-rc1 mediatek mt7921e broke badly
Message-ID: <8c8c8f27-ba44-48eb-96f6-dae6d2d0cbf8@t-8ch.de>
References: <d7f3b00d-beec-41f0-b157-7cfb871f9a46@linuxfoundation.org>
 <756e3f65-b2f2-4da3-985a-17754a7a872d@t-8ch.de>
 <CAHk-=wjO-7uR5HBi-MFnkxAxjhpgfbAQ+HCMKPiXFVwM+AJ7tA@mail.gmail.com>
 <6fc04df5-b753-4b2d-b978-0e59a7f48ff7@linux.dev>
 <c1304430-dd7d-437b-8744-70af9ca85c0d@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1304430-dd7d-437b-8744-70af9ca85c0d@linuxfoundation.org>

On 2025-12-30 16:57:20-0700, Shuah Khan wrote:
> On 12/29/25 21:21, Matthew Schwartz wrote:
> > On 12/29/25 4:41 PM, Linus Torvalds wrote:
> > > On Sat, 27 Dec 2025 at 04:25, Thomas Weißschuh <linux@weissschuh.net> wrote:
> > > > 
> > > > Hi Shuah,
> > > > 
> > > > On 2025-12-27 02:07:24-0700, Shuah Khan wrote:
> > > > > mt7921e doesn't load on my primary laptopn on Linux 6.19-rc1 and problem
> > > > > still there on 6.19-rc2.
> > > > 
> > > > This should be a duplicate of
> > > > https://lore.kernel.org/all/CABXGCsMeAZyNJ-Axt_CUCXgyieWPV3rrcLpWsveMPT8R0YPGnQ@mail.gmail.com/

(...)
 
> Reverting the following fixed my problem.
> f804a5895eba ("wifi: mt76: Strip whitespace from build ddate")
> 
> The above fixes an extra newline in the dmesg by making the
> code more complex it needs to introducing local buffers and
> strscpy() - the proposed fix replaces this with memcpy().
> 
> Is there a simple way to do this than introducing memcpy()
> or strscpy() to remove an extra newline that might or might
> not exist? Why not check if newline exists or not using
> strstr()?

We do have memtostr() which would be a perfect fit to use here.
That is still a memcpy() under the hood, but the code is clear and safe.
It does however require the source to be annotated as __nonstring.
Which also seems to be the right choice here anyways. However for
consistency, all other similar fields should also be annotated in the
same way. So it is a bit of a larger change than a pure bugfix.


Thomas

