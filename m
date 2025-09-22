Return-Path: <linux-wireless+bounces-27558-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF095B8F0A0
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 07:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 730C816101D
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 05:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5484313D2B2;
	Mon, 22 Sep 2025 05:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="IIYghKpC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01DC5464E;
	Mon, 22 Sep 2025 05:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758519987; cv=none; b=jA1KkDrGyNXvBJcfp+5Kxruw5WyTL2VAG5AorijDZfX5s5SHgVbfihCTZhhZTHJMqP4ScEgxXdYeH6YzPenNL2jmr4jiiq1vEGrjq8/ACQy5pfDqjkUyUCqziplQYDhNJfeeMlQvKjca3f1KZ5c0lbnJsJ00D2v/vNHtwlUmntQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758519987; c=relaxed/simple;
	bh=VSdeU3JTLwfoBBoGACOq0P3+muWlQsLuoSxm617i46U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HXMT1xfAmIJsPSUU+0/gvBdhsutPDU2fVcSYY1hUwATOBeACcO4UT4LMHp3PMGTeeLP7CtDOPp+N/iQ6SL5bFBa+/DrOgm70xBjIhCa3kh9Capw//OCDTcjapt7iGnKHaus7hmstxiWu5aFvOX8HHAGP2/I5GbxLoY14uS16Mps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=IIYghKpC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58M5jt8kB3919400, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758519955; bh=PwCcJPMzVls3sCZIAwBAocTssvejx2/i7MSxMy1SclQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=IIYghKpCiyGOJvYD52ih242w57yFm9S9OKcKOexi+jWtx5bw45Z9uMVT8d9chatGs
	 x+1lmWsGVxNgNTCMWPXj/Yc1fiv6hYEeQlHiBffruRv8omT0oIjiUYR93TcrK9ev8S
	 Qk56PyDr9hk0RULRukq9rA6dd4Sc5Hh/Cp74enVAm2WgcP2E6JiAww8yWu6Kcot15n
	 uAi6apBNRnZM/khZmx4qZAcWo2Ls1udUr4usqDglTO0ZcYxZ5eO+tTAiK7XiPaKMv4
	 uM04DtPeSYtfPlhSCPSwtR4TntrJqWCnddVVa3Bd92++UaXw4Dsh1waERRtQsKrqs9
	 hSJ5IRtvhifdA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58M5jt8kB3919400
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 13:45:55 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 22 Sep 2025 13:45:55 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 22 Sep 2025 13:45:55 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Mon, 22 Sep 2025 13:45:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>
CC: Zong-Zhe Yang <kevin_yang@realtek.com>,
        Bernie Huang
	<phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: RE: [PATCH rtw-next 0/6] wifi: rtw89: improvements for USB part
Thread-Topic: [PATCH rtw-next 0/6] wifi: rtw89: improvements for USB part
Thread-Index: AQHcKjJMGqnSk3n/xUaIBqb6wPMlWLSesXZA
Date: Mon, 22 Sep 2025 05:45:55 +0000
Message-ID: <d0b655cb1e7a41a39b52327165b12d76@realtek.com>
References: <20250920132614.277719-1-pchelkin@ispras.ru>
In-Reply-To: <20250920132614.277719-1-pchelkin@ispras.ru>
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

Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> The first two patches concern memory leak issues found during testing.
>=20
> The other ones implement TX completion functionality missing for the USB
> part of rtw89 driver, suggested by Bitterblue Smith [1].  This will allow
> handling TX wait skbs and the ones flagged with IEEE80211_TX_CTL_REQ_TX_S=
TATUS
> correctly.
>=20
> rtw89 has several ways of handling TX status report events.  The first on=
e
> is based on RPP feature which is used by PCIe HCI.  The other one depends
> on firmware sending a corresponding C2H message, quite similar to what
> rtw88 has.  RTL8851BU vendor driver [2] was taken for reference.
>=20
> [1]: https://lore.kernel.org/linux-wireless/0cb4d19b-94c7-450e-ac56-8b0d4=
a1d889f@gmail.com/
> [2]: https://github.com/fofajardo/rtl8851bu.git
>=20
> Series has been tested to work with RTL8851BU (USB) and RTL8852BE (PCIe)
> devices.
>=20
> Sorry for the inconvenience with the timing when the series is sent.  It'=
s
> not extremely urgent, and I'd gladly appreciate if it'd be reviewed for
> any issues I'm not aware of.  Testing with other USB chips would be great=
,
> too.  Thanks!

Thanks for your patches and description that I understand what you are goin=
g
to do. I'd like give people enough time to review this patchset, so I don't
merge this immediately, and also I can review them deeply days later.



