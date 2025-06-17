Return-Path: <linux-wireless+bounces-24198-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC57ADC6D6
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 11:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9934618970B0
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 09:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14055295536;
	Tue, 17 Jun 2025 09:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="MXJs5BB2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743D02951A0;
	Tue, 17 Jun 2025 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750153393; cv=none; b=rYUcVCp3uQAGVWG4Pno534djKrJnN4ryuQf4nv/2qqIDgh+wvRYy9+1AWylFbJYx+SaCp+Nqz1YRdeUyWvdScIwGi++y+CUs7ZSedt9BSs5KbqM5NnAd4o0XoMdiNLK1kYW3AX1u/4hzkvBPrAFR66iU4F9VpLy1W6qloxd59lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750153393; c=relaxed/simple;
	bh=kcvZFwsF99rOOvZgcJdZkqPbTwReEqUbni/VeT0l+/I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GW3vmVdu2nrKjbA0nL13OGeaYMNvqcK9RONMfIj+GwXYROP26w2F3Am0sTH9Klu44+Jo52z9uYGVTiRC4gcVv2VEz3ZE74jmbA2zlPxGWRjJz8j0m4SvvH4ftwUciCQD0WJ0UZrJeIeXdpKH/naxJFQb7DD6TWBvfzLZcfrta74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=MXJs5BB2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kcvZFwsF99rOOvZgcJdZkqPbTwReEqUbni/VeT0l+/I=;
	t=1750153392; x=1751362992; b=MXJs5BB2unBAfLCMeebaImqQQR1pMR/qaPHwmzIUspEWYbG
	O3IPrwWi2dmOt7T7rR/JlaV4pOWHtyveORAPBrfZZiaN6RrN7aPgUjj1LihoB7z3KmUIY3v1n2JM6
	7+4tT284NqNqX15ld0Izc/CqxNiqB7L3riDI/Ijv7opfcGTkOWNWRVaYO5iBE2oL+R9lDLWZD4So0
	Sy2Pjv0WAJ+V1UnkJNsnliv6ci46iaXNIqiPD74JEJTKcPGiGZTvudf3ghQtZHVsIQLKdGVLA5yb7
	YPxX7T8Zv0ooS/x3LShRZ/1hjF5fV+P/jC+vZxTOH1fhAQo2yIRmirJBLI7qiHPA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uRSqN-0000000EF7u-1NsC;
	Tue, 17 Jun 2025 11:43:03 +0200
Message-ID: <97d6493279ab5c63e8844e8b0f349b2528d2832b.camel@sipsolutions.net>
Subject: Re: [syzbot] [wireless?] WARNING: net/mac80211/tx.c:LINE at
 __ieee80211_beacon_get, CPU: syz.NUM.NUM/NUM
From: Johannes Berg <johannes@sipsolutions.net>
To: Aleksandr Nogikh <nogikh@google.com>, syzbot
	 <syzbot+468656785707b0e995df@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Date: Tue, 17 Jun 2025 11:43:02 +0200
In-Reply-To: <CANp29Y68ZaQnb0R2fZSLjcCxiOE3uZyW4b7wLEYMAycF0WHNUg@mail.gmail.com> (sfid-20250617_113441_883833_551E3C7C)
References: <6850d3bd.a70a0220.395abc.01fa.GAE@google.com>
	 <CANp29Y68ZaQnb0R2fZSLjcCxiOE3uZyW4b7wLEYMAycF0WHNUg@mail.gmail.com>
	 (sfid-20250617_113441_883833_551E3C7C)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-06-17 at 11:34 +0200, Aleksandr Nogikh wrote:
> #syz dup: WARNING in __ieee80211_beacon_get
>=20

Not just this one :)

https://lore.kernel.org/linux-wireless/20250617104902.146e10919be1.I85f352c=
a4a2dce6f556e5ff45ceaa5f3769cb5ce@changeid/

johannes

