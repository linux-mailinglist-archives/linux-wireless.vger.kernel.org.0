Return-Path: <linux-wireless+bounces-9304-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 489FA910386
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 13:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC21B281088
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 11:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FA9175579;
	Thu, 20 Jun 2024 11:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="r1qngEQ5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A62170826;
	Thu, 20 Jun 2024 11:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718884753; cv=none; b=UD1D/c/F0fIU1GX+arTwudTrnf3bLecERbmnxnhvoxUtssaJ9kfbtYEWbSu2RsQB7E8u10NAoWZyfjWA//j0TNsKbSeSb+meUAHTDJMf53cavhsx9HmocNofongQDGAyMEsuuNiIqWDBPn2PmRBhTC5WAbnt4wSmQ9n11g1spmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718884753; c=relaxed/simple;
	bh=hg742+mt6Zi5lRHVjabFitH50pLzUlqnvHo+zO8xSvY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V9xKdqJNGJrAkkpc98w41tATCJ6sml1qL8tq95GZyPtMV4WLdy5OZQgbb//A4ZnHh+erd1LgT3axFCPtYjeB2Pt8gNUhHi+oX8/uvoDMEMpU+spT9NayzEAZ7uz9nYPZIKdJaclnc0eORhQvU9d/jLkMst8cmNjXgWMAIq3it1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=r1qngEQ5; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=cxEogzvsAiuPBeqtkh9eO0b3zL2yiJN0U5oh7Tmj944=;
	t=1718884751; x=1720094351; b=r1qngEQ5QAck3Da8YkdwjeCniThKLlRm0kNKTy7Gu9R8qMh
	9NB/g0LWkfRsaC8KWa10T9gfM31Xzkjo34sU6rqq9fdieXKcCzSyjYuoyQ2XAKrb8whc1RP1lEtmx
	Rp8AOAQUc+K2DFMS4ZH1gWXE/CIeo/QcU6Hd0T1LhYO4IRt01fsb7z/fP8DQnNqeXoLUxa7+v2jnu
	zyg8r2zQ4fivOgU1THWyEsx4IMV4e6W5kCaTSnBXgzs3S+gdJYoO5VWTYNMewXz+KVray1JaHKfL2
	YXfXLHrqjI3IICDytWzsj9+zfMkgGOnpFy898tBpW3PN+66lc3CHfuMLvws7G1RQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sKGRQ-00000009Fjq-0Y9N;
	Thu, 20 Jun 2024 13:59:00 +0200
Message-ID: <b008224f6e7691234e52f8fb9400bbca50160235.camel@sipsolutions.net>
Subject: Re: [REGRESSION] Freeze on resume from S3 (bisected)
From: Johannes Berg <johannes@sipsolutions.net>
To: Ping-Ke Shih <pkshih@realtek.com>, "mathewegeorge@gmail.com"
	 <mathewegeorge@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
 "kvalo@kernel.org" <kvalo@kernel.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>,  Bernie Huang <phhuang@realtek.com>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Date: Thu, 20 Jun 2024 13:58:59 +0200
In-Reply-To: <a60692b7a0ec4caa5db64d369bebf18910102656.camel@realtek.com>
References: <87tthpwkqf.fsf@gmail.com>
	 <2ce41d4129234ba9a91d5b4dcd8a40ee@realtek.com> <87sex93s63.fsf@gmail.com>
	 <6970398610c546b1b62e599902c67572@realtek.com>
	 <E3FF7BC1-725B-40E2-AAF0-CA41A44B9DF9@gmail.com>
	 <342b6b95d97a4bf09afee15c09481efc@realtek.com>
	 <CFB0314C-AE45-4563-BF41-F5D635BFCF86@gmail.com>
	 <a60692b7a0ec4caa5db64d369bebf18910102656.camel@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

I don't really know any of this here, but ...

+       ret =3D rtw89_hw_scan_offload(rtwdev, vif, false);
+       if (ret)
+               rtw89_hw_scan_complete(rtwdev, vif, true);

seems strange? You have to say that it was completed here, in the good
case, so maybe that was meant to be !ret?

It _looks_ like the crash is a use-after-free (the wiphy pointer in a
scan request cannot become NULL in normal flows), so maybe try with
KASAN rather than waiting for the crash. According to the logs, it
doesn't happen every time even for the reporter.

There possibly seems to be some issue between cfg80211 and mac80211 in
this code, we see the WARN_ON() in cfg80211_netdev_notifier_call() in
the NETDEV_DOWN case, which calls ___cfg80211_scan_done() which frees
the scan request. But shortly after the HW crashes, and we have
"ieee80211_restart_work called with hardware scan in progress", mac80211
wants to cancel the HW scan but the HW is dead ("wlo1: Failed check-
sdata-in-driver check, flags: 0x0"), and we see again "phy0: resume with
hardware scan still in progress" ... but this time once tasks are
restarted it crashes ...

So I think KASAN, possibly rtw debugs, and perhaps something like
https://p.sipsolutions.net/602684f34abfcf7c.txt will help debug it (yes
it adds a leak)

johannes

