Return-Path: <linux-wireless+bounces-180-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE117FCB62
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 01:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597F42832AE
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 00:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EEC1874;
	Wed, 29 Nov 2023 00:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD13519B7
	for <linux-wireless@vger.kernel.org>; Tue, 28 Nov 2023 16:33:57 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AT0XnbN62386589, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AT0XnbN62386589
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Nov 2023 08:33:49 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 29 Nov 2023 08:33:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 29 Nov 2023 08:33:49 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Wed, 29 Nov 2023 08:33:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Jay Sweat <jjsweat@outlook.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Realtek 8822ce p2p support
Thread-Topic: Realtek 8822ce p2p support
Thread-Index: AQHaHJ6/35nL8BzLVE+iP+/w63/TCrCFjBhAgAEOZs2AAHCucIAJI5tagABKzWA=
Date: Wed, 29 Nov 2023 00:33:48 +0000
Message-ID: <1f6b255e8c8a4d9c9d2af80c93b7acf0@realtek.com>
References: <IA1PR20MB5049CDB1D4CBA0FD5B68F15DA8BBA@IA1PR20MB5049.namprd20.prod.outlook.com>
 <16c31bac7aaf4c20917f500d6d2a52c2@realtek.com>
 <IA1PR20MB50490BFFD9F797722C9688BAA8BAA@IA1PR20MB5049.namprd20.prod.outlook.com>
 <5ffd01e6c8a1464795d612de1c6fa8a4@realtek.com>
 <IA1PR20MB50496D7A5578AC9DC1AE7370A8BCA@IA1PR20MB5049.namprd20.prod.outlook.com>
In-Reply-To: <IA1PR20MB50496D7A5578AC9DC1AE7370A8BCA@IA1PR20MB5049.namprd20.prod.outlook.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback



> -----Original Message-----
> From: Jay Sweat <jjsweat@outlook.com>
> Sent: Wednesday, November 29, 2023 3:50 AM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: linux-wireless@vger.kernel.org
> Subject: Re: Realtek 8822ce p2p support
>=20
> That seems to have worked. P2P is now listed under supported interface mo=
des and gnome-network-displays
> works without issue. Havent noticed any other changes or any issues with =
P2P, but I only have the one app
> to test with.

Good to hear the news. More tests you can do are to make connection with
various devices, and try to play as GO and GC respectively. This can set
p2p_go_intent (0~15) in wpa_supplicant.conf to decide how a device
intents to be a GO. Then, use 'iw info' to check the role.

An advance test is to configure peer as concurrency that connects to an
AP, and the make another interface as P2P. A simple way is to take an
Android phone, and enter P2P connection setting page to make P2P connection
first, and then connect to an AP. The order of connection is important,
because different connected channels of P2P and AP make thing complicated,
and I suppose current code can't handle this case properly. Also, try
to be GO and GC in this scenario.=20

Ping-Ke


