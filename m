Return-Path: <linux-wireless+bounces-2467-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE5E83BCE5
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 10:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7C151F2FAF2
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 09:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789211C69C;
	Thu, 25 Jan 2024 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="tLg120tP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [178.154.239.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8A41C696
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jan 2024 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173670; cv=none; b=QM9Bne/IqTCk+mFZQnLsCOZCRT9CHvd66cmpvI+bljfTCnT5PN+OKGiqwjmyq/d+BHz9umkFl4Jlbe6Gu804PUj8R7z/Uo3IzkdhX8n87QCWpnSG8K2Awey8hZFgr4mQk5Gi6lwvpklCtDaKEkTEbM98WOzhLfuZekBEBt2OVRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173670; c=relaxed/simple;
	bh=BThvc5xSu32X/VDOii6cEUag6BbVgdRUPoTRDsazIQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDEUzuWxQl/HCpbZ3vXI9aa7aWBK8uYxEXx9dq9yD+5a0BEwvCOjB2Vur5NjjIybM9qQodSKmHsT4rfRIkcPbJeTH8GnsaVF3AUsyzqTl6mRFHfFbkVKz0rpegHbFmjrA1eF+fT89wTKktWFh1RDJrmaQSpMwaxG4jcxkeASiUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=tLg120tP; arc=none smtp.client-ip=178.154.239.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0d:230c:0:640:f8e:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id 0733B60A6A;
	Thu, 25 Jan 2024 12:07:44 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id h7QI3JPOhCg0-5p6804Fy;
	Thu, 25 Jan 2024 12:07:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1706173663; bh=FHtQcuqL71TX53rbsLykIZ/SkDjty+djBuKKiyVtmWk=;
	h=In-Reply-To:Cc:References:To:Message-ID:Date:Subject:From;
	b=tLg120tP0r0DFyG9HFx2d45MJv7Qk4SCcBUzn2E+pI6RV97KwF7QTOeqE71lwKlN/
	 vvRHQFDP4pS4n8mTHygt93mX47JE39YPxR3gq6XvHz/tX/5dprayW5DjW9Rdaw+ryW
	 pF7ArnUgXwnx6t5AvqBAHP8QpO52peHJWG9jjx34=
Authentication-Results: mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 0/1] Re: wifi: mac80211: don't ask rate control with zero rate mask if scanning
Date: Thu, 25 Jan 2024 12:07:34 +0300
Message-ID: <20240125090737.49673-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <58970b94a314414402a932576ec54188c0675016.camel@sipsolutions.net>
References: <58970b94a314414402a932576ec54188c0675016.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Well, the literal approach to "not even use the bitrate mask for scanning"
may look like the following. It fixes an original WARN_ONCE() as reported
by syzkaller, but I'm definitely interesting on how to check whether it
doesn't break something else.

Dmitry Antipov (1):
  wifi: mac80211: ignore the bitrate mask when scanning

 include/net/mac80211.h | 3 +++
 net/mac80211/rate.c    | 4 +++-
 net/mac80211/scan.c    | 2 ++
 3 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.43.0

