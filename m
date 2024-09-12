Return-Path: <linux-wireless+bounces-12809-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967A097618C
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2024 08:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D47028433B
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2024 06:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B4B188903;
	Thu, 12 Sep 2024 06:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="jlcHykzf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F50B2F41;
	Thu, 12 Sep 2024 06:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726122839; cv=none; b=mhag5CtWUPu2HmR8VCbE9e7EC7lDkw2tOADiMOtsuaEK452GMSqzuVdEvdmrsOS0EZakNeM/il8PGMm32usadKQ7oYzKJkjguIy7qGmwiMxAc5X4kYmDzozSWc7ZaTkUVH6QjXgEpamACs4BO8jw+C/1cVlZLRyS41ucAWKZHK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726122839; c=relaxed/simple;
	bh=S2ljrYz8x0Oq8bzXGTOBhVhR3r93ya3AWJm+BlmBubY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WZCl/7FTrpUl/Mqc5+u4OZzEeWLU2A1vWzgZvQx/OHxWhUotIU5JjZhY5DzEZZL2stDTc+RksDBGQscuepjbh3HNREgmvMvpAGP66tQCJYrw8LyKLTrdWlHIYqG7A0FM6oIbFTTYrqGDVC3Gpg6cukMDQMk8E0SD75TEIgjbdwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=jlcHykzf; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48C6XmM72824855, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726122828; bh=S2ljrYz8x0Oq8bzXGTOBhVhR3r93ya3AWJm+BlmBubY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=jlcHykzf0aRnSvuE3JjjDBiNAynj+em+jCxg0qRIA3G+1ne0zyyGTjP31r28xuVIY
	 xRwMZ9K5572uiLinLHNfdNS8cdV5UrFeMoNZFMnuoUJTN1E89nMOqh9rA492gRv74e
	 VRx1GJpg3BTHRWmg4CTnhgPTcO4q8F+RUwE8kK+/Pg+Rh7UlWj3Ukuprvt7zlUBOki
	 2kaRg30AwYwTVCAuHb259tHDPAxPseY/XDKi2WbENNBCEjEhghaA+vmbIkzsfRgW0Q
	 gCS4sCkmUh8/rUMoL8AYxhqVvw+odQST45nsxl8pqZGdfvc96eqQGJY8gU0Eg5BGLR
	 F7/kiEH695CYw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48C6XmM72824855
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 14:33:48 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 14:33:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 12 Sep 2024 14:33:48 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 12 Sep 2024 14:33:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kalle Valo <kvalo@kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: pull-request: wireless-next-2024-09-11
Thread-Topic: pull-request: wireless-next-2024-09-11
Thread-Index: AQHbBCaF/9K30GyQfUOAvskhRTD9drJSiJ+AgACjYo7//3uwgIAAAHyAgADGoYCAAELMpIAAAVrg
Date: Thu, 12 Sep 2024 06:33:48 +0000
Message-ID: <5824a23efe5c43298f3200636a2e3ceb@realtek.com>
References: <20240911084147.A205DC4AF0F@smtp.kernel.org>
	<20240911134521.7f510329@kernel.org> <87ikv1bz8e.fsf@kernel.org>
	<20240911153633.7a01a6c7@kernel.org>	<20240911153817.0c150bc6@kernel.org>
	<0b6a69a39d6b463da41c5a83b747e4cd@realtek.com> <878qvxfkso.fsf@kernel.org>
In-Reply-To: <878qvxfkso.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> > I'm not sure [1] should go wireless or rtw tree. Please guide me. Thank=
s.
>=20
> Let's queue the rtw89 fix for wireless so that the quick goes to net
> tree soon. So please assign it to me on patchwork.

Assigned. Thanks!



