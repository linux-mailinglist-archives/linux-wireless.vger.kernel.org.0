Return-Path: <linux-wireless+bounces-10070-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F28929FE2
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jul 2024 12:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0FA31F2304C
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jul 2024 10:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2AA7581F;
	Mon,  8 Jul 2024 10:09:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2096.outbound.protection.outlook.com [40.107.255.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3558C7346F;
	Mon,  8 Jul 2024 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720433361; cv=fail; b=c/PHVuP1+eCrq/YiF2T2XK/kpbHutn6g4Ve1QzZG7CLNjKax0sLgQ2+FWSvcLab3CGzsNDzqJk4vclK+7UIAJ0q7ZAjgWW/QWSNYoHJQQoGJsQWUr4OAOAIjFKo/+oyy85iYMlyptXlFeyU9PEKl+bEHexilsCxLYFBWvOyB3B8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720433361; c=relaxed/simple;
	bh=ObiJZegeOCKlQX1yLmJKIVnOcZuLp5oRPWi7HDX/km8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zu3wddPVwC7jQCbbOYVmuJfth4f0KSjjan3YVqwAL/yBVNTB/MYNOw+UCb8RZLTNI7umM/G9iRfmh6wOdPC6AOWoVEyWIOEdyIv6WuPtsJHd7QKAb2RDtv6uETL0ss3iQJbbyGzsWy+imP9pZAi0hYjOiw2G6h+Jx0jMlPsOSlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1HFxn7+z3lcFtA2U0dORtkmAiJ27ezIiMxCisAT57b4NNKB3FPZJzaPm19frGdorrdruYzgywyRSuBmNq8tB5cAp2tSpleeLyi4ic+hDYKPsG/bqzaH1DPb2ZXh54NmGUCrAugSmvtuBImo4lyFpbQ/bDGCo2scGYtZhJp9ANj0H3/3pjB2Dil4zphANNA9OddIUH1Z2YiEZ1Aaq1P/XQP479/wfi2P7HLm3Bd68vKEahWctGBID9GLF9nW8fTQ5bnoZ/Bg+wYuCfNqAn251YbBjss+o9NaP7iKwXfXGdcKnSQtc9w+RIj2cyI2CGmVjv9DI2xSx4O7i6VGcTfDvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9QSs234pU25Ip8Aa8TnfzTO7w8UBgLuHadzugprI2w=;
 b=YYY/FnGG1haSbZwznHFSnY7Fuvbn/vlk16QPB+Qa4PQq37hfXLjz8etmCmNbITDw9Cw8zX1p4L8PMfDQBMlsRvo7lftJZ4mbEx23SYiecBxVSQG253aCl56cA6Kdwe1rLj6N1cboCmdLak0r2H8QOotodLyNppuhMrOBkBPOGPHn0rzXCitjaLiqn1LFrrmCEkwO4Fn1N+fWVasbkUlf01pDbBYG0h93mU0DHeILElNvp/AdbtSjVGu29MXoouEIiTQW17irofHYavUaly14msU8RBmS43vfRRROGkmj2uN9sSAyHW3YihBFrznc+fDaY23IhT8Z9EfxSsLr3HT+aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEZPR03MB7297.apcprd03.prod.outlook.com (2603:1096:101:12e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 10:09:12 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 10:09:11 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>, "robh@kernel.org"
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
Subject: Re: [PATCH v3 5/5] wifi: brcmfmac: Add support for AP6275P
Thread-Topic: [PATCH v3 5/5] wifi: brcmfmac: Add support for AP6275P
Thread-Index: AQHaysA+Rq9QbyhEyUKwID0Y3gYvO7HgKL2AgAx52Bw=
Date: Mon, 8 Jul 2024 10:09:11 +0000
Message-ID:
 <TYZPR03MB700128DD9D712A0A0B51516A80DA2@TYZPR03MB7001.apcprd03.prod.outlook.com>
References: <20240630073605.2164346-1-jacobe.zang@wesion.com>
 <20240630073605.2164346-6-jacobe.zang@wesion.com>
 <19068dd7008.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <19068dd7008.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7001:EE_|SEZPR03MB7297:EE_
x-ms-office365-filtering-correlation-id: e76c3dfe-877d-456e-1471-08dc9f3603a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Hg217Ph3sI87P7Hl3IuGv1WTGHUxKZ2ydnJfTcOA9IoLzs6Z30KMK5p7dM?=
 =?iso-8859-1?Q?Ia13sn0ra70gbCkyilQf9GEt5B/qwPRppfGCvnpHWwFKbNsQoYiXnduUsU?=
 =?iso-8859-1?Q?OdCVXx/UFhj1KrUpZFKgq9XS7v8/mfVRa2MUTX+5ZM2uRjbkWO1icEsLuF?=
 =?iso-8859-1?Q?KJDJO3Pt3weYtJnAOZEkFBbEL/HJZCdT65KNIrTtNt9zJGFQNQD7C6Dpjp?=
 =?iso-8859-1?Q?nwdTuARPt32aFLBZF3QNfF6L5XnG6mYwt0Odqf4bLIOnJ22PZGE5O1VVCP?=
 =?iso-8859-1?Q?CsdbFihcN4hkkKH+5ILnRQzXEYFl5c88Cxe0dDD85REYo6VWV3woWdcMpz?=
 =?iso-8859-1?Q?bSsZQdT3+Y1p3rQ1yukFQpDWQ7wMFbU9kSo1KC92ZteTJyAOWDKp3oatf0?=
 =?iso-8859-1?Q?rBweNihsjmheF9AgFhQTDpfU9i3uMu2d9jAvhAZJGuhFdVcBk2WO2ve0HC?=
 =?iso-8859-1?Q?NpKvOLJorflKPMTTYzbyOn7JPFMvUlahq+X0Jp5Hn5DNPV228JyKiS94mC?=
 =?iso-8859-1?Q?kasHPZuWQIH5m3HDN4HTHyp4R4xFw7zMDQtXubKdWm7LF4N0rT1nL5oWNn?=
 =?iso-8859-1?Q?XtwEBa3u5HTWZy+UA+tJC1/8aORxZmQ8DT5cYqYsTwkrXbQsdj86ELnnQI?=
 =?iso-8859-1?Q?sDwqI/fD67O4f4weTtLjvLBbZSRD5/4ddLU5O+OxVsXIG0FwhCq0hkNn3m?=
 =?iso-8859-1?Q?buNy7Xv8uTj1tmYPxo3G56eBeXzCqKoyF9z75FBSwlUuytM1cMAf7lqaKk?=
 =?iso-8859-1?Q?njYQYE+H3xAI8KAzOTsG33kcmqHFybIDwqg/4HDWhp9XnYczS7dPPBlAmE?=
 =?iso-8859-1?Q?1mCxqqVWj7O3uzM2F+Tv2ZhZ40HHsxQ6XjpqG8U3NlycnmkokhZstQqx4I?=
 =?iso-8859-1?Q?63LjgHyxT7pYrFbsyicPu431PjFoyRLLxzMPCHisB6SPuFhYKI5D+2hE3f?=
 =?iso-8859-1?Q?KioPlIqgjSfYwNM6rNkz9tD4kEBhxIiOUfNy+7137y1f9xW0XSXIf2w9Bg?=
 =?iso-8859-1?Q?mKzp9GVmyzj3+JqdUZgd/FSVx7zK68FBojI60W0ylj2R31rUWeIz31wB4d?=
 =?iso-8859-1?Q?RhFa6Ei6IoI+jfk5jtwVU0e+9NFVpSYSE5iWBhqGYlMGcEmfkDEGrgx5P6?=
 =?iso-8859-1?Q?zDz5dAVuPmIpfHU5mlTVoyZtPfdP0bGwIUUZimcIq+5vqTPh6lAMS9qeUc?=
 =?iso-8859-1?Q?oTkGjWIBD9lh9Y/QF+EeOBXJaQON+IrDIq/oeTDteTqtp2sTtOfb8x5fvl?=
 =?iso-8859-1?Q?9b5LmtgimotNgyYqyO8pJjmUSVqX7d6Bbh+Tv+NBIpRyxahbGjvCLoDAZz?=
 =?iso-8859-1?Q?gRc8ZFMJXSTMldnVD2A89i0y55BnFjRPJ9pnJ82opw/o7YUzw31868Gz0R?=
 =?iso-8859-1?Q?il23Wkzxj11THJq3eVP6+ZpiFfR9rrTSVFsUEerl89aKYJsk3D9Cw1PX5V?=
 =?iso-8859-1?Q?wXllciohpExd3XSWPcvo+WOTKLSwJ/ikRSlMH5ntJEBuq4jcgu8ba7iamW?=
 =?iso-8859-1?Q?w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?j3blhDTkMwVYm5dXg6lOvSSiBsHAdRvQUNVpBQ7EFLT1oO1Lh0DT5m8ANA?=
 =?iso-8859-1?Q?04UU/AgxhDBmCEi6fMmYNnGeoy4rXTLyzEK+tJ6d7VjKXYl4vQ5hX/GlWD?=
 =?iso-8859-1?Q?2xZu8xJeRSOmzjdqQySIykZ6zbrzCoY4J2aP/n2URjW2xbI1aL+NdwBIE3?=
 =?iso-8859-1?Q?SMC6YnkF+Wi8AruUG0PS5Sq5kWjlccKMmq11rCMODiV+zoxC6ziTvKMECY?=
 =?iso-8859-1?Q?KH1tFmdxSBEHwIez/+RTS6wurp/VrnonKHyFPKPh9R9fOfXK9dQp1vtUe7?=
 =?iso-8859-1?Q?P+4KLg+go314EtdJi2g4d/w5n5nCz9SEY6TOGr2jfYAn76Qnf82tguPKhJ?=
 =?iso-8859-1?Q?af1szGxNIut7OAEDE/iJLS4ZWy8p0xjK7039ML/1Cs55AS+AE5DjV/N/ND?=
 =?iso-8859-1?Q?AP4yVL9RhH2Gq3jrfmZISFIsKFz+JiEGC2BKrsJujL14MbgLwLiJGzjDrp?=
 =?iso-8859-1?Q?yfJzsPwZ3FlyohyCYo1Plz/1hrTLbbS359cRTCoos/FdFbUty3H1C+RwpY?=
 =?iso-8859-1?Q?gXHww5p0uvW5gMXvtlyXp0JQQOKCOv2cQcyN6Whi6bAQR6pcp5l64rpJVM?=
 =?iso-8859-1?Q?kl0tdEf6suApxAGw5e+rk4swi+Q4HwB+9Z2wR5Jh25qkE4EPLg8vOuLiWK?=
 =?iso-8859-1?Q?ru64bLLoB6amk1DDcoi1jRdGtJ6W1/7S2sBD4tNhEJvdF4Nz3ZZjbZgrRU?=
 =?iso-8859-1?Q?QHgX0NRMUHBXHCtn02Z7UiVyo6FEL7geUiLsF7U5ouj9+aggPgXgYVmkHQ?=
 =?iso-8859-1?Q?zb3GoyjNStPNpkd7LfckWCsWPM3KmQjmBF5XxsBGBtsCjV+OiQLPSuupJj?=
 =?iso-8859-1?Q?QvAi/qtXzQR0324PjmAM40y9x8rzJ4g5ynRjKjabonJILRFCwf8jCuZAOH?=
 =?iso-8859-1?Q?7oCGKVOhWehTN+zb5mNAGme8ZJaKiAFUDLSvdQ0w8vRJLPu58ygm5ouN+B?=
 =?iso-8859-1?Q?Dqn0oedzozeDwA8sPWpXud97P8RAhNv5jBM8ToIozRNwpFHM7AsHzCJuIF?=
 =?iso-8859-1?Q?2Bk0Opg5e9CL7Anb7iRgjWhOYxPWu3dYJbFn02iJfcA1EiseP4yYF/qVhp?=
 =?iso-8859-1?Q?B0jKykrSW6QtXjAE5WfwXOYZvYbO7Jg4To8eiNGBqOZnEqD+1Qu4yXJEGl?=
 =?iso-8859-1?Q?eZQn7Ip9+mcIbdKO9WJI8sH7Osh4Nysdu/Kv9NCbI2mttz1n356gVVjWZ4?=
 =?iso-8859-1?Q?JExOQRUGp5JHSxTZmOjnEWYP0+DUyK7PW0ycsGcq9Amics/T7EaSFibkaG?=
 =?iso-8859-1?Q?Tpu7LjWaG0aA9JDn1xYduzxq9kNaMAZs6c3NfEIExXLClSOV0BWROxtneS?=
 =?iso-8859-1?Q?fFZdQC9zB9dPrn0qxdW4KBvlpL+rHdFxRlP08QhQDpCFAiFXcNEq9bbSVV?=
 =?iso-8859-1?Q?ke6bF3TrqdLAq+Cs0uiKqB9AwcNRCpYtAhSz9N0ZpdLBLhcMDZfSnm+p48?=
 =?iso-8859-1?Q?pWfmnyfGaW3i8hjcbtn7X3MU/vrJZOl4Qr7DYeoELL1+20YwPW7kw9HqNV?=
 =?iso-8859-1?Q?QlRML7R8a/rYsG/1X8L6yl7dV+hsDOz9Be/U5iSTmZkW2ok532IniMUalT?=
 =?iso-8859-1?Q?/xKlQ6/HS8vO/ds3ZGN0tGBicm8j113ApzWBd1+W2Iw9qiadHp6Z9pT8PQ?=
 =?iso-8859-1?Q?GWwF6qUk+wuVjtEJezwLlhV4omBT7HlDcX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e76c3dfe-877d-456e-1471-08dc9f3603a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 10:09:11.7906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T2h51inGWtR9dyq/nmMBQ2pHfzlXvadNump+1VTInkUvAcfWbRxlh5p9oSjfdf6jk8gJZZ2VKSR2+y4vK27Y5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7297

>> @@ -1721,7 +1723,7 @@ static int brcmf_pcie_download_fw_nvram(struct=0A=
>> brcmf_pciedev_info *devinfo,=0A=
>>  memcpy_toio(devinfo->tcm + address, nvram, nvram_len);=0A=
>>  brcmf_fw_nvram_free(nvram);=0A=
>>=0A=
>> - if (devinfo->otp.valid) {=0A=
>> + if (devinfo->otp.valid || devinfo->ci->chip=0A=
>=0A=
> So the problem here is that otp validity is not unambiguous. The seed=0A=
> requirement is mandated by firmware and was introduced for new WCC chips=
=0A=
> moving forward.=0A=
>=0A=
> I would suggest to have a need_seed flag in the driver_data of the device=
=0A=
> table (below). It currently is used only for vendor identification.=0A=
=0A=
Because of brcmf_pcie_setup function also need the driver_data, so I tried =
to define=0A=
a global variable named NEED_SEED_FLAG. But marco define didn't allow to mo=
dify=0A=
value in it, do you think where is the best place to assign the flag? =0A=
=0A=
Or you still think should add a new macro named BRCMF_PCIE_DEVICE_NEED_SEED=
?=0A=
To be honest, I'm not quite sure which way is the best.=0A=
=0A=
> Regards,=0A=
> Arend=0A=
>=0A=
>> =3D=3D BRCM_CC_43752_CHIP_ID) {=0A=
>>  size_t rand_len =3D BRCMF_RANDOM_SEED_LENGTH;=0A=
>>  struct brcmf_random_seed_footer footer =3D {=0A=
>>  .length =3D cpu_to_le32(rand_len),=0A=
>> @@ -2710,6 +2712,7 @@ static const struct pci_device_id=0A=
>> brcmf_pcie_devid_table[] =3D {=0A=
>>  BRCMF_PCIE_DEVICE(BRCM_PCIE_4366_5G_DEVICE_ID, BCA),=0A=
>>  BRCMF_PCIE_DEVICE(BRCM_PCIE_4371_DEVICE_ID, WCC),=0A=
>>  BRCMF_PCIE_DEVICE(BRCM_PCIE_43596_DEVICE_ID, CYW),=0A=
>> + BRCMF_PCIE_DEVICE(BRCM_PCIE_43752_DEVICE_ID, WCC),=0A=
>>  BRCMF_PCIE_DEVICE(BRCM_PCIE_4377_DEVICE_ID, WCC),=0A=
>>  BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID, WCC),=0A=
>>  BRCMF_PCIE_DEVICE(BRCM_PCIE_4387_DEVICE_ID, WCC),=0A=
=0A=
=0A=
---=0A=
Best Regards=0A=
Jacobe=

