Return-Path: <linux-wireless+bounces-16467-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA3C9F492A
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 11:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E6937A5E57
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 10:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761841E47BD;
	Tue, 17 Dec 2024 10:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xzO8HQai"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA602E628;
	Tue, 17 Dec 2024 10:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734432403; cv=none; b=BjfqJgS/DRp4hoixoQ2eYABiyMZL5K+XPPE3Wpyv8bUG6qe2LCu9foIzPSQSLKAkqrBYmrvTyUsScc2t1XXlwfP3qgJMqiDdthXC3iCGNZ0mJLKzfoDrhsy0343TrjFQhsY4S9ayKZNOUdEH9F9HmpTsuK6BV69MrRCgspQyzMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734432403; c=relaxed/simple;
	bh=sOmYwxhcs0Ck10oCwijJVOfj8Bp+RcsUy1ph6N0Pb0M=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CEDqwj3jJZUN5wIfxU7/DYSt+KRknfQsPnakl1idQYXPDAHMFRVqOEWscSxSgpul6U1bi9ykl6t4pfcV2A8i3dikZt9YeivWTcqQJIWTZzmgyt3eRgMQmzM2kkr2oKtB9CukrVB/0dObdRrT75q3QRy+jPhCIUkddEHHC/Gd9BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xzO8HQai; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=sOmYwxhcs0Ck10oCwijJVOfj8Bp+RcsUy1ph6N0Pb0M=;
	t=1734432401; x=1735642001; b=xzO8HQai+5VwFRs9vZk0gR4ZQLq17V4qY6x65kYivGp8uWZ
	r0fhRkwwocpxgCdX4jsZwyUfUHFVssEOZR3C+68G5LMJZWO34Mmau9DSemacjQRNv4BwmphiOpYUa
	SzSZekl2WRNPGIeR8rMMWr87nswG7rIns4IoPzeutS2jUgZWobqLgJQH+XIgygg3KEsjGgvRY9RvR
	PA3kvoWebVmqG5YArGLRooqMz/1amKszGF4PlB8i+G2ojVC93UskLQYpe48tXFfC6Cu1yQXiddF9K
	TNbTxIZXQ6Ztm5M23cHV+J90q8Tv36OA7HoO3OPBh/8dpO9sVtqwLm+n7OHZyJsQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tNV65-000000024ou-3dEz;
	Tue, 17 Dec 2024 11:46:38 +0100
Message-ID: <b27dc4d0c3456c6796437b26b887b931d9871977.camel@sipsolutions.net>
Subject: Re: [Bug] Deadlock between rfkill_fop_write() and
 nfc_unregister_device()
From: Johannes Berg <johannes@sipsolutions.net>
To: Sam Sun <samsun1006219@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, Simon Horman
	 <horms@kernel.org>, pabeni@redhat.com, kuba@kernel.org, Eric Dumazet
	 <edumazet@google.com>, davem@davemloft.net, krzk@kernel.org
Date: Tue, 17 Dec 2024 11:46:36 +0100
In-Reply-To: <CAEkJfYOyWgJW-WAd+GhT07zd2Y3vUWz81+pjbZT9nUAsCc7FGQ@mail.gmail.com>
References: 
	<CAEkJfYOyWgJW-WAd+GhT07zd2Y3vUWz81+pjbZT9nUAsCc7FGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-12-17 at 17:33 +0800, Sam Sun wrote:
> Dear developers and maintainers,
>=20
> We originally encountered a task hung while using our modified
> syzkaller. It was tested against the latest upstream kernel. We
> analyzed the root cause and pinpoint the kernel crash log to the
> following two tasks.
>=20

This issue has been known a very long time and should be fixed in NFC,
but I guess nobody is around to do it.

https://syzkaller.appspot.com/bug?extid=3Dbb540a4bbfb4ae3b425d

johannes

