Return-Path: <linux-wireless+bounces-263-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C913800039
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 01:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AF3AB20E31
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 00:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F3B17CD;
	Fri,  1 Dec 2023 00:34:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9183610FF;
	Thu, 30 Nov 2023 16:34:05 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B10Xk2L24052922, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B10Xk2L24052922
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Dec 2023 08:33:46 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 1 Dec 2023 08:33:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 08:33:46 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Fri, 1 Dec 2023 08:33:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "Lukas F. Hartmann" <lukas@mntre.com>, Kalle Valo <kvalo@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "tony0620emma@gmail.com"
	<tony0620emma@gmail.com>,
        Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>
Subject: RE: [PATCH v3] wifi: rtw88: sdio: Honor the host max_req_size in the RX path
Thread-Topic: [PATCH v3] wifi: rtw88: sdio: Honor the host max_req_size in the
 RX path
Thread-Index: AQHaG6jDIcpCLdDdCE6Dt6ztbl+1PLCSxRuAgAAE1oCAANos8A==
Date: Fri, 1 Dec 2023 00:33:46 +0000
Message-ID: <98c69e6e8bb449ffae253840910df07f@realtek.com>
References: <20231120115726.1569323-1-martin.blumenstingl@googlemail.com>
 <170137159397.1963309.4329648460865757143.kvalo@kernel.org>
 <87edg7ujhi.fsf@mntre.com>
In-Reply-To: <87edg7ujhi.fsf@mntre.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

Hi Martin,

> -----Original Message-----
> From: Lukas F. Hartmann <lukas@mntre.com>
> Sent: Friday, December 1, 2023 3:31 AM
> To: Kalle Valo <kvalo@kernel.org>; Martin Blumenstingl <martin.blumenstin=
gl@googlemail.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org; jernej.=
skrabec@gmail.com; Ping-Ke Shih
> <pkshih@realtek.com>; ulf.hansson@linaro.org; tony0620emma@gmail.com; Mar=
tin Blumenstingl
> <martin.blumenstingl@googlemail.com>
> Subject: Re: [PATCH v3] wifi: rtw88: sdio: Honor the host max_req_size in=
 the RX path
>=20
> Hi Ping-Ke, Kalle, Martin,
>=20
> sorry for my late reply. Yes, this patch fixes my original problems and
> I have usable WiFi now. There are still some remaining problems like
> connection dropouts every minute or so, but it's unrelated and a topic
> of further investigation.
>=20
> Tested-by: Lukas F. Hartmann <lukas@mntre.com>
>=20

Would you mind to take my acked-by and Lukas' tested-by and send v4?
That would be easier to Kalle to merge this patch.

Ping-Ke


