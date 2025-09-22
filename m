Return-Path: <linux-wireless+bounces-27575-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C83B8F550
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 09:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 164D13A8379
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 07:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2825182B4;
	Mon, 22 Sep 2025 07:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kmQvA7xn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D67A26AEC;
	Mon, 22 Sep 2025 07:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758527193; cv=none; b=mhdFjig+Hj0EN8TsrzYvtSYAQhtdGT/lgn8wbi9iAef9nNCwu7C+jKIh0IZO3x1dUqHf6A3Gl9F7kv48ZphDgo/OS1WAwgDWe74fRhP2vkG9EiQRdKTyDkIdaxJ5GVlDgZDueT9YpaQCiFDxpx62+oEeKf+PuhbAl6BM4DoLbiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758527193; c=relaxed/simple;
	bh=6QguGgUscyhX+PZDpZGRfmKl7TipQc194DgDO9RCr2k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pRcI6i8+60M6gKAjfrfgdqM/TagSzlcQ0d8ODDc/0SOV8H7SG+dBJYs1PUIlDp0bAFbEDgicUeUyLstsprrFDRXhuCMr/30u6gX1wZLgNaMXfjdulEDJLnhjUddEHMdZH6JgLL++GBAIF4a1GMgRdrmBVJl/ansR+dYEvN0zjHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=kmQvA7xn; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SpAb1wV4IgMqOTcQjeMjnBKkLPJPBaH4P/jl0CKPYyA=;
	t=1758527192; x=1759736792; b=kmQvA7xnSFYoVbqJ3KXAN3JedyQz1MxGvvhaMPMA/Z8e3zz
	5nMZ96Y5TGZbQ7RyW6BBIvxD8eG2h3vikJaPBJCvZktC5ZG1pxsPumefkMLogSmmp6QuK0oOczw4s
	rBO1gt/Ef6fHjX9uyev+GlCIdwGbTMOzUyA8ub6PLu8lmZkSEGnEiNJ9DZzZ4B0FOBpWUMl4v0Evg
	goq/Nxf2PXz2Ex92Dx99Pk+HSDC72Rq2ygukL0ft3gr5F5GRsh1W3DyyB3E1YmJejTkFTslA2DVsA
	o0uUCdYTAN8ZjES8pIlqNAO3TO8W68cr2ocrwfKwy4YKKu/icgONHxrwYXouTAEA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v0bFl-00000004E54-3uOI;
	Mon, 22 Sep 2025 09:46:30 +0200
Message-ID: <2ea0ad29b6956b7d5b812d688b9676e1824dad30.camel@sipsolutions.net>
Subject: Re: [syzbot ci] Re: wifi: cfg80211: remove
 IEEE80211_CHAN_{1,2,4,8,16}MHZ flags
From: Johannes Berg <johannes@sipsolutions.net>
To: syzbot ci <syzbot+cib69b4e10bd070489@syzkaller.appspotmail.com>, 
	lachlan.hodges@morsemicro.com, linux-wireless@vger.kernel.org
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Date: Mon, 22 Sep 2025 09:46:29 +0200
In-Reply-To: <68ce3c87.a00a0220.37dadf.0025.GAE@google.com> (sfid-20250920_073258_661213_373D07CB)
References: <68ce3c87.a00a0220.37dadf.0025.GAE@google.com>
	 (sfid-20250920_073258_661213_373D07CB)
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

On Fri, 2025-09-19 at 22:32 -0700, syzbot ci wrote:
> syzbot ci has tested the following series
>=20
> [v1] wifi: cfg80211: remove IEEE80211_CHAN_{1,2,4,8,16}MHZ flags
> https://lore.kernel.org/all/20250919122325.f0abcf092b9b.I04478fde87a79c79=
09f1cc4249430deaf71e8bd0@changeid
> * [PATCH wireless-next] wifi: cfg80211: remove IEEE80211_CHAN_{1,2,4,8,16=
}MHZ flags
>=20
> and found the following issue:
> kernel build error

Hmm. I don't know if this is really useful? The 0-day bot does similar
build tests, probably more comprehensively, and

> tree:      torvalds
> URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torva=
lds/linux
> base:      f83ec76bf285bea5727f478a68b894f5543ca76e

unlike syzbot, I'm pretty sure it would've known not to attempt applying
the patches to Linus's tree when they were destined to wireless-next.


IMHO there's enough noise already, this only adds to the noise, not to
the signal.

johannes

