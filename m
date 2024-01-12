Return-Path: <linux-wireless+bounces-1759-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EA882B89D
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 01:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9332882C1
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 00:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4578DEBD;
	Fri, 12 Jan 2024 00:33:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A6EEA6
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 00:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40C0XEIt81998523, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40C0XEIt81998523
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jan 2024 08:33:14 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 12 Jan 2024 08:33:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 12 Jan 2024 08:33:13 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c]) by
 RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c%5]) with mapi id
 15.01.2507.035; Fri, 12 Jan 2024 08:33:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zenm Chen <zenmchen@gmail.com>,
        "martin.kaistra@linutronix.de"
	<martin.kaistra@linutronix.de>
CC: "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>,
        "bigeasy@linutronix.de"
	<bigeasy@linutronix.de>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
Subject: RE: [PATCH v3 21/21] wifi: rtl8xxxu: declare concurrent mode support for 8188f
Thread-Topic: [PATCH v3 21/21] wifi: rtl8xxxu: declare concurrent mode support
 for 8188f
Thread-Index: AQHaNL/dFjf07HTwcUmTgmwgHOvTDbDUaOsAgAEJKbA=
Date: Fri, 12 Jan 2024 00:33:13 +0000
Message-ID: <208ccd1dc65a42b1a945b57bf0ef7cd7@realtek.com>
References: <20231222101442.626837-22-martin.kaistra@linutronix.de>
 <20240111163603.2325-1-zenmchen@gmail.com>
In-Reply-To: <20240111163603.2325-1-zenmchen@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback



> -----Original Message-----
> From: Zenm Chen <zenmchen@gmail.com>
> Sent: Friday, January 12, 2024 12:36 AM
> To: martin.kaistra@linutronix.de
> Cc: Jes.Sorensen@gmail.com; bigeasy@linutronix.de; kvalo@kernel.org; linu=
x-wireless@vger.kernel.org;
> Ping-Ke Shih <pkshih@realtek.com>; rtl8821cerfe2@gmail.com
> Subject: [PATCH v3 21/21] wifi: rtl8xxxu: declare concurrent mode support=
 for 8188f
>=20
> Hi,
>=20
> The rtl8xxxu driver can't establish the connection after applying this se=
ries
> of the patches. Please help me, thanks!
>=20
> OS: Arch Linux (kernel version: 6.6.10-arch1-1)
> devices tested: MERCUSYS MW300UM (RTL8192EU)
>                 MERCURY MW310UH  (RTL8192FU)
>=20

[...]

> [  186.081741] wlp0s18f2u4: associated
> [  186.218451] wlp0s18f2u4: Limiting TX power to 30 (30 - 0) dBm as adver=
tised by bc:e6:3f:5f:9c:cd
> [  195.553755] warning: `ThreadPoolForeg' uses wireless extensions which =
will stop working for Wi-Fi 7
> hardware; use nl80211
> [  231.035382] wlp0s18f2u4: deauthenticating from bc:e6:3f:5f:9c:cd by lo=
cal choice (Reason:
> 3=3DDEAUTH_LEAVING)

Locally trying to disconnect after 30 seconds. Can you try non-secure
connection and specify static IP to see if it can work?=20

I reviewed the patchset again, no obvious change if you are using a vif wit=
h
station mode only. The only one I'm not very sure is a commit related to
security CAM:
    Fixes: b837f78fbffa ("wifi: rtl8xxxu: add hw crypto support for AP mode=
")

Since each patch can be seen as individual one, could you help to bisect
the cause?=20

Ping-Ke


