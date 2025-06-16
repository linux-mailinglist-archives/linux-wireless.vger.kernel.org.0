Return-Path: <linux-wireless+bounces-24151-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AF6ADB054
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 14:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76CF818890E7
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 12:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D42826C3B7;
	Mon, 16 Jun 2025 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aladdin.ru header.i=@aladdin.ru header.b="GnMEsn3R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361582E426D;
	Mon, 16 Jun 2025 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750077410; cv=none; b=DYde2hnoVBeazrfHg6nq5d6kS3QQ3RyHuIQ4nolcxjQrHjhMO8CZ5n8GsN+m1tpImgklWi/tW0Ug4o7zfWn/AyKCcoV0TEwobIwYlflcZMbqL5yniFKhmEoUombRT0kC+7fzajEmBpSroRCI1I825BIDPiD1sw3bSP9INl+TBts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750077410; c=relaxed/simple;
	bh=RQ4PNSd4uDAn/WGwFB8brsOBgHiaDMNm/eRLvym1q/Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jdWrc5kJZ5LoBXore8TaKi9AuLsXsYaDyji3/1nSPfbnQOTX/n0JxVpfvmuTwpwwzn6nC2SnYKatGvWOfkdaoyPeKwsnJ4CQlPCDLweW+/vuz0ARfZk1PHcSmbUD3jlwznlj9bBE3HNn+sZe3ugfBOLFw+gvNYSFJoBiWTs0iS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; dkim=pass (2048-bit key) header.d=aladdin.ru header.i=@aladdin.ru header.b=GnMEsn3R; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
DKIM-Signature: v=1; a=rsa-sha256; d=aladdin.ru; s=mail; c=simple/simple;
	t=1750077388; h=from:subject:to:date:message-id;
	bh=RQ4PNSd4uDAn/WGwFB8brsOBgHiaDMNm/eRLvym1q/Y=;
	b=GnMEsn3RqPf4KGphB5avAZhyFF8+XDeC4qM5+KviNUKTl6zVD6V6QeO9/KyPOajMoQ6qJAP3oNq
	BhBWzdb1H0Ur2fNjC6eMhu54YLCo0RT1mTuxFJ2CSCpO/2btDprJiyGwd3H18i7AuZL0aD4qoJt8g
	f+BHpWsonIvlrzTAdnbKGB26FSn0JHFSfHXmb/yxjbRUk+j2YXDbXobb+BbGnIWkQ+n//STHUXlDA
	SgtLsY5Ydgqqk0mRakGzjDEf7EMx0xyEAabOil9xwWd5Y9riePr5nZIBmlT0URxoYmPZ41tD7gE9I
	x/vE6iYYDlZd0tDNIebyAql5nJPkr4vVoKjQ==
Date: Mon, 16 Jun 2025 15:36:28 +0300
From: Daniil Dulov <d.dulov@aladdin.ru>
To: Johannes Berg <johannes@sipsolutions.net>
CC: Kees Cook <kees@kernel.org>, Emmanuel Grumbach
	<emmanuel.grumbach@intel.com>, Miri Korenblit
	<miriam.rachel.korenblit@intel.com>, "John W. Linville"
	<linville@tuxdriver.com>, Daniel Drake <dsd@gentoo.org>,
	<linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: Re: [PATCH] wifi: zd1211rw: Fix potential data race in
 zd_mac_tx_to_dev()
Message-ID: <20250616153628.4706f048@ubuntu>
In-Reply-To: <13332646e4c8b028504f6a7ec4a2aa9530c519f1.camel@sipsolutions.net>
References: <20250604101356.6292-1-d.dulov@aladdin.ru>
	<13332646e4c8b028504f6a7ec4a2aa9530c519f1.camel@sipsolutions.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EXCH-2016-01.aladdin.ru (192.168.1.101) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)

On Wed, 11 Jun 2025 11:35:18 +0200
Johannes Berg <johannes@sipsolutions.net> wrote:

> Hi,
> 

Hello,

Thank you for the review and sorry for such a late response.

> So ... I have no idea why you're CC'ing all kinds of people who never
> had anything to do with this driver, or haven't worked on WiFi in
> like a decade or so ... Please don't. Even I should've been CC'ed
> with a different address, at most.
>
> I also have no idea who's maintaining this driver now though, if
> anyone. I have hardware if someone wants it ;-)
>

Also, sorry for the mess with the CC list. The driver is marked as
"Orphaned" now and this is the first time I am trying to send a patch
for an orphaned driver. MAINTAINERS file only gives the Wireless
mailing list and the rest of CC list was generated by get_maintainer.pl
script.

I could not find any relevant information on how to send patches for
orphaned drivers in kernel docs. 

Can you, please, give me some advice on a process of submitting patches
to orphaned drivers or, if there is any relevant documentation on the
topic, can you share a link?

> > In order to avoid potential data races and leading dereference of a
> > NULL pointer, acquire the queue lock before any work with the queue
> > is done and replace all skb_* calls with their lockless version.  
> 
> You should explain why the locking changes are OK.
> 

Ok, I'll improve the patch description, thank you!

> johannes

Kind regards,
Daniil Dulov

