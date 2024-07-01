Return-Path: <linux-wireless+bounces-9760-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF2091DCDB
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 12:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE93B1C20E31
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 10:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463F75D477;
	Mon,  1 Jul 2024 10:38:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2098.outbound.protection.outlook.com [40.107.117.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6F6347B4;
	Mon,  1 Jul 2024 10:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719830315; cv=fail; b=rFzv2WPpIHfdlmJL3AGjWWXQ/WEgCcmtX5EUQ1YeIZj/Cg/d+7IGOmSXNuPgKeyJKBbT8o02mg18b3crJD3OF+zlm3tu49d5mvyrOU8fvGl7iumApuBWHI5JUZ+U32YfJeYZSUmABAnzKfoClwD4kASkiH+L0y2h324RI7fJ4gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719830315; c=relaxed/simple;
	bh=4BDhsBkRn2fxeCopwNLyT3RBLEYgvAYyccoDsaD5l/c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pZdhpXers0ysDNyJkPc/zBVNlaL58cdhSS/B9vxIrtnCGoEzbBGX0trIfJZKwiP3DxCI3mGg/fd8Gg2az/bPpsjVkHFq9LB8wyAkRi1FBbhzVXq9jttYg5C4n1StwuKBn3wnoO7KyXQg1iY7Sxuca0DqAZ0GZoA4GWC5eE63iBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRUYpG4vp9sQVPkqycls+5p/Yc8zXDweX1lYG0buEsvmVL0hctM5ZsoTctrWzpYWNZjuFjN2dEFwXI0Qx7s8RePH+FQuMjFkP4l9hr5NhOCNbuSbnAjrozVKeztID6+MpKA0jizu+qDxn4Kz9qMXHF6B7ghGSAODc8JZIt9wtrDdJUy3WpwmCifi05zFfOMRKcNuDveN77mPfRCpMvO+wcDHFS/CE25dZ+FjV2TsRoUZe4IUt5YGtLx8ZkzmecAU9HFfc8QXtGgszYYZK8rHqz/LiKt2ZVjrb4dsJT6BXEN8eiivMoWqj1Ekeqvz4Mwzs7oRKJ0irH4bjTZHhGxQOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BDhsBkRn2fxeCopwNLyT3RBLEYgvAYyccoDsaD5l/c=;
 b=aRyBM0oMQVOPzw+jPciNIU/M0JvYoO38+6WDjK571nbd8O9aOE25pNRZW7jzEkKYqrOMzeD8eAe3fSUD0/iCFORz5GV4NHe/zHgdPQdIgcnf0FQM/geMOtx3c/0Ce3VUZZf01d0QBDDgxsK+OIZgLjmnJzr6VDoG3F9MR6RBTogd4lRrDmSXPeyi/mWtADwBsC64r6tTIkt26LFoz4PdElrnTiD6xifaqWO5QozVy+C68N6IjJylxYHbg8sgOhfu7+5TjBCAdGS+S4XER+g1okDoXZXpx94FdVY2XUGG8ocs5WrJeUJsjyZlJQNjRCO6YCbWeF/LUKKlN6Cp198WZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by TYZPR03MB8133.apcprd03.prod.outlook.com (2603:1096:400:45a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 10:38:28 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7719.028; Mon, 1 Jul 2024
 10:38:28 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"heiko@sntech.de" <heiko@sntech.de>, "kvalo@kernel.org" <kvalo@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "efectn@protonmail.com" <efectn@protonmail.com>, "dsimic@manjaro.org"
	<dsimic@manjaro.org>, "jagan@edgeble.ai" <jagan@edgeble.ai>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "arend@broadcom.com" <arend@broadcom.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "megi@xff.cz"
	<megi@xff.cz>, "duoming@zju.edu.cn" <duoming@zju.edu.cn>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "minipli@grsecurity.net"
	<minipli@grsecurity.net>, "brcm80211@lists.linux.dev"
	<brcm80211@lists.linux.dev>, "brcm80211-dev-list.pdl@broadcom.com"
	<brcm80211-dev-list.pdl@broadcom.com>, Nick Xie <nick@khadas.com>
Subject: Re: [PATCH v3 3/5] arm64: dts: rockchip: Add AP6275P wireless support
 to Khadas Edge 2
Thread-Topic: [PATCH v3 3/5] arm64: dts: rockchip: Add AP6275P wireless
 support to Khadas Edge 2
Thread-Index: AQHaysA5gqQ7qqo00E6aPButxU3qdLHhkO8AgAAdHZc=
Date: Mon, 1 Jul 2024 10:38:28 +0000
Message-ID:
 <TYZPR03MB7001FFD5180C6248F14EE48E80D32@TYZPR03MB7001.apcprd03.prod.outlook.com>
References: <20240630073605.2164346-1-jacobe.zang@wesion.com>
 <20240630073605.2164346-4-jacobe.zang@wesion.com>
 <eeeb3f1f-5c77-4ca5-b996-17b968b7c2f0@kernel.org>
In-Reply-To: <eeeb3f1f-5c77-4ca5-b996-17b968b7c2f0@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7001:EE_|TYZPR03MB8133:EE_
x-ms-office365-filtering-correlation-id: d59683a2-9bcf-4592-966d-08dc99b9f192
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?6CLFQQbkcgxeajww+X76HgHVJ5XIzsmu8H09zic4PqK5OHnnn8/ewVvaG6?=
 =?iso-8859-1?Q?PIbjRcUOf3gTyFWCQb2gls8x8UIwtpiogVBfMZl0xqcuRH669Q4tfiPrGp?=
 =?iso-8859-1?Q?XlWtI1o4UgT7EsjJgZH03L0k/OdanAUQnny9VJN186e63qgyGDl1aH5tOc?=
 =?iso-8859-1?Q?BkpML7XTdSKa63/0Hf7n8/36wNzgPUd+mItnzY6cAwJeATfS+Ydvy7w5XO?=
 =?iso-8859-1?Q?SiARamR4WKnDoFTeAUKa3aSQuZk8DCYkpbCtN4XncEs6vhJiuXIbLLmXuB?=
 =?iso-8859-1?Q?fE6ZR63tMwbUB+T9WDJpTNyQbukuytZIx2Kyt1CvdJJRhdAGqep7iSQ9V6?=
 =?iso-8859-1?Q?mVO8J2knfrgbJ3eUfuqkSL4WI+kjriVsAm4XDFC2Ae/HMa45NiZXpAyZj5?=
 =?iso-8859-1?Q?OotVKp+5SV+poQWgX77t5gTFZyP2NBZi2YQXRbZbNFcCFE2j2/k4FpllLR?=
 =?iso-8859-1?Q?TIuyLR60zBaeATsOUs9FEmjwZikpxaqPYRCaAU+uXnDH5KGAV5JxXuSqC/?=
 =?iso-8859-1?Q?7M+npjcNZ0oxFazHAKMdzuYPGE9AClWYukinx6EwNSNgQkZW5LDoGF9Bbi?=
 =?iso-8859-1?Q?yPyr6R6E+DsznuPDFgxmQPnbN4Osq/zjJX4xv5IWcw1FOlk4hlhpyU91+P?=
 =?iso-8859-1?Q?YMTlTwc+jkKjUQhBH2l6LeAm2w4pqhIm8aIdG+NZvgYmmNsHc+ifTx+1nw?=
 =?iso-8859-1?Q?ZPIbtlSKAV4dREpxUU0uOSRPjIp76ERQAngR3uuigas73Wj/bAoUl/crx4?=
 =?iso-8859-1?Q?wg2+5vwH9RhMqkrE9IOXHvbpnzWihDtT2ocKJNzfndLUk9F8mG0GYMgPDB?=
 =?iso-8859-1?Q?W8Fo5ExPywB6QNzTkmVW0a1k54PgSy9mmAz2qkPqfqBPFXkSEBoHLW3EOV?=
 =?iso-8859-1?Q?tZfdSj0uj5kbCRsTQ3XVk7W2vVGC0bPjI2oAHcRRdmyRWTcup4XyRn6Iff?=
 =?iso-8859-1?Q?uIroJUkwQN55zanGZYvVVKyCZyStL5ljKwCJrqi7Wvh2ZDO3nFVOzj+P03?=
 =?iso-8859-1?Q?kvEWs9hNrhF+RYRZ9PV9eqvnDdhQv/W2SeXTK+Zu4Bc2psbOfkpVcBEegk?=
 =?iso-8859-1?Q?OGnua9/2Tc/oxZqDH3zE8Rd97Ve/hcxVtVnC803EkQk+DmaVqyV8WReDhB?=
 =?iso-8859-1?Q?JlJqS/c50JQjwlymFPxFp6WzGcaICzsKYE6EMdZ07J8jQupKVdbU+Ris5v?=
 =?iso-8859-1?Q?SqIlYl+vvQQtlghLA7p+nskQbHmQu6WtHbTWh36Hvp/zOtp7DDtp3WMuK0?=
 =?iso-8859-1?Q?eYpbFlWYJ/VgHH6zvJbloXAQ6jtxd6vRbPT6H6Wuc7WLVdcYAlkNQTROQd?=
 =?iso-8859-1?Q?mH59Ya8G9MWoQUKU/xZXihTHAs1NRtxbjbtI3I09tdNmDxXL5xfJzvLYjQ?=
 =?iso-8859-1?Q?ChvjxZ8HZ9L9cE9GTPC+EVH3s8+H5huYIVz8OjsgKzdCNzOWgGtEcBcc/0?=
 =?iso-8859-1?Q?wLNwf+JktHGmSDEe3kWcgG2eTZ8F7Oof5NG5ZPchrs0900+NrcA0TxJOQS?=
 =?iso-8859-1?Q?4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?mZUrg0Oi63OGISCxcJ2JyDXmOyMilL/XQAnaMq+E+BZ688jOJ1lYKW/T23?=
 =?iso-8859-1?Q?Az5D2bG7HiDqJ4+dFUB6YE3dyrvfX9NML/BFs2Wt55Gp+XIQU2Q5NACQTo?=
 =?iso-8859-1?Q?hEDQYxoU2wJpw+vrGl69vPLJWn/P05kejzdnq3UEQ+cRSwgQJNVhacrVSv?=
 =?iso-8859-1?Q?a9I/NpJZobOIix1DioZOasoiBmi6g8qp8rhvkieffCHDzLGK+ggPZHWjR2?=
 =?iso-8859-1?Q?0K80QF9PysUyM1K6xH1li0nHkyul4VKVoLJqMVb00vyuWyE05tX33ganK2?=
 =?iso-8859-1?Q?ssW2z1+o5kYV5XFDzmZHNChUVBsO/3I7paYW3oT/RxRoHoHVfIl5mGYT+B?=
 =?iso-8859-1?Q?YspSOK3p/fvP6tbDglVlu7HgCmpbyNYjumn+i22ZNAsthH6pXRxscC2eOS?=
 =?iso-8859-1?Q?UvoZpHJRrxtCBGTVimqvzNN6lt4F1sNVcKX9vkeJ5i0nwnytYhEzibaOl/?=
 =?iso-8859-1?Q?18f1v4DRYa+SdeOgqmTKYo0ctBI7VSlKD4NyIuBiq/BoDsHk2cq71pO6Fy?=
 =?iso-8859-1?Q?BfjEDcYUIh3E4u5W2FEBzbuPnL7Z8zOK1hPugftXEpQWCm6uYhYaKp7+Ql?=
 =?iso-8859-1?Q?DDS8k37aEunY4zyxdA/QnRNPAW8R0yJPs3Q9x2WvQLPTXP0dvRnhCDpZo3?=
 =?iso-8859-1?Q?5Oo9mKtwxee2RfIYDUNlBg1jARWD+1n1l913lb0HtXB3k7DYe8XrRfww59?=
 =?iso-8859-1?Q?Eg/mvFrPkxwAYV+6LlkjCseOC6P6uixtgxPxKZ3qTcgKEJs4F10Avup4Si?=
 =?iso-8859-1?Q?q2enMojecoGvjl3sej4+EFHt2Ipy1n2H4Aqp2kqlHdZ4M4G+/feZRn/54z?=
 =?iso-8859-1?Q?HtYlQI/PB1B4isaqMCE3hPq83e4jUf4kOABDfCmrjQmvFzu65zBzFmLVK0?=
 =?iso-8859-1?Q?7On0lpwwUeNQn9/krc653uJa9BKehlFokA8RUAdVSH5PyGCXr3EygndacR?=
 =?iso-8859-1?Q?Ld4OdUmsr78w745B3xlrv+GJxUb44+RSR+o5xKj6owkIIp5EUc4poIKeME?=
 =?iso-8859-1?Q?2tI1VDJOFeYqRe7bRviD2vYSiS15FjEneqTvyWaatr1cr4PDbaldElK8cJ?=
 =?iso-8859-1?Q?NZq3nyaTb7l1ezDrJH07VxjkermVFR7R+TxfP1KZiRnPCKTGnh0vthksOF?=
 =?iso-8859-1?Q?BSz7hIUrv1GhYNNAMVvYuWzkXLXchmKewzGxZbZv9QKLo4yNzo+wqQrJ79?=
 =?iso-8859-1?Q?SjMieNNoKB2glt3ZTgrm5PVqvAzv9JNeSSd+/gLhnImSd/VtvMtyx+dVXQ?=
 =?iso-8859-1?Q?TeK2jjQU6HDJfjMWCDKLK85abD7e5kVzuHDpUuneTx+e5bP+0OsFz9Qb92?=
 =?iso-8859-1?Q?2PzxI5Qxm/28NjMA3yXqSA/3FAebbx0wz9vUeun/a0yV374HArzv576O1R?=
 =?iso-8859-1?Q?nvrUmajq5eyednD0z/DlxvvYSlQBScC0p3l7+jOTaXxMxNzn87NEBKPR1v?=
 =?iso-8859-1?Q?xwdgiX6H3U0M2Er84TIQyk5LEbqFsw6gjHVs7TA96O7Y1qVAyuikAfme8t?=
 =?iso-8859-1?Q?J9TzKxFU7JoYfCWyogctS2pq1SkF/kp9kyJPty5J0K6dIdgqLsYMgSwzDB?=
 =?iso-8859-1?Q?lJqw1FP1PG+magnrKvfqKylEb0/8lvjKakhAgfC27q2RRRhMBCoOMcuEj3?=
 =?iso-8859-1?Q?o5HWBE93PKJ34Lr4WuZETzBOak/VpDBUEX?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d59683a2-9bcf-4592-966d-08dc99b9f192
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 10:38:28.0505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ugiZQWXvhkAg4pnTunaYptMg15KI23SwrfCBPEqjsAdpuOHggtFT9KP51Jm56oI/gd0q4HAa2JYMTAZ+uhOVcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8133

>> +=A0=A0=A0=A0 pcie@0,0 {=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D <0x400000 0 0 0 0>;=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #address-cells =3D <3>;=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #size-cells =3D <2>;=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ranges;=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 device_type =3D "pci";=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bus-range =3D <0x40 0x4f>;=0A=
>> +=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 wifi: wifi@0,0 {=0A=
> Where is the compatible (again!)? Test your code - you will see your=0A=
> binding is a no-op.=0A=
=0A=
I tried to build kernel with CHECK_DTBS=3D1. And didn't get any message=0A=
like 'compatible' is a required property in wifi node. But when I check=0A=
the bindings that do required the compatible... So I will add it next time.=
=0A=
=0A=
---=0A=
Best Regards=0A=
Jacobe=

