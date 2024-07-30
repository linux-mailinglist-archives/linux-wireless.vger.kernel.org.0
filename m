Return-Path: <linux-wireless+bounces-10679-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D18940ECF
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 12:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D211B24B0E
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 10:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38821199233;
	Tue, 30 Jul 2024 10:17:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2125.outbound.protection.outlook.com [40.107.117.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D31191F91;
	Tue, 30 Jul 2024 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722334679; cv=fail; b=oSRg2cu5pjXKcqPpmSJx2tuPy94hxgAHA2QHnqfrGiI0m1v9YMLr09FZ7KftyEGAhoxhgjung1GPBs3Xrl08xQFuN60HK0HDcmmR9hiIPHyWe3jvG7qQ7jfbpeO8YKdgvUDD/m618eb5DGPm0Zrg5tJSFbZa+obJq8w3b+s279I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722334679; c=relaxed/simple;
	bh=+qz6GEyzno2mHbveXHKnnTtjopEDvFudLirb4rmyDgc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EsKr2xppNvyZnN17N9AD+d4/xdmoy2AjwTFeQNjHg10M3yv7T/F4yev7s26E86wfn9SO2tOSHlWBjDGv10BH4LB98n2gRmxnkYt95Tukg0Ed/Sjn03E0zqFfzeaLjSLbjGuEgVw5pIRKSxV8fAxKWxbMTlrcZF1xY+EVg5QHs5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdQMhljfWaUQ3TW/kGFzVSc3KWur3JssHi/HeKPPk88EYVPhRqNSSs+d668VcZxc04FrPBf7UbSwFQ+ctYQeZQUjlICCl5/gQlbY8RtaVpsTicXexroCRK6LxNbr3iffya2ld3gVJafkFjxrqHN9/JJJQJscVjXEUKjhSgyhF7dxHDGbILiwqYJ4IE1Pdkn0YLEAuJYoN74B+CLv9TdBtB0yhdW6O7sVa2fH5GzS8VIrgduJ+PrDa9kMCCSvKFIrFx3/yFChcgKynUfLe97kXdpMg/DAAkcX49oyfMWM0Abh7UTKiP01BO2XB8a0+StfLcJS4x6InfTLm6nYXZ9Y3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y751EjFsLQ07IR5+M+TyOt+tXao53kM3NHpw8NBSce8=;
 b=jWxqdBvhyAawjsfuln2h7LDa7Y9gYnIfspXqbGM6jqvAkpf9L+BJEE5LviM4VwasR8azTRqiv5RAgF1kKuxSZnWABp7ZWC9AjSdc5hBTdH19iga6qRnmj6hVAE8LHB6qb1xjflhMAzAAp+UgnUDLgamIgsgcJ6ci5W4DJv4k6hC7bILYIpGckTAHD97TxcLe9Oz/YBAop6Kp7w4Mx3VoeaibrjQWSpooxipIL1qJifBq5iASXTpwwiGuIheiYJ/jjVid8GCoqrrPuRs/WdTe/FWqex5kRN2LXFTywjt8+fi1fut/MoOwqrzdc7nFYxruEC3FG4mRdd557fdJfgdn+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by KL1PR03MB8753.apcprd03.prod.outlook.com (2603:1096:820:13d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 10:17:51 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7784.020; Tue, 30 Jul 2024
 10:17:51 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "heiko@sntech.de" <heiko@sntech.de>, "kvalo@kernel.org"
	<kvalo@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, Linus Walleij
	<linus.walleij@linaro.org>
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
Subject: Re: [PATCH v5 2/5] dt-bindings: net: wireless: brcm4329-fmac: add
 clock description for AP6275P
Thread-Topic: [PATCH v5 2/5] dt-bindings: net: wireless: brcm4329-fmac: add
 clock description for AP6275P
Thread-Index:
 AQHa4jDtxz/Ha1L1bk2aE8Abf13SIrIO0WeAgAAoWoCAAA5igIAAAC3WgAAEG4CAAAGzwg==
Date: Tue, 30 Jul 2024 10:17:50 +0000
Message-ID:
 <TYZPR03MB7001DA7A89E278F73A4D2E6780B02@TYZPR03MB7001.apcprd03.prod.outlook.com>
References: <20240730033053.4092132-1-jacobe.zang@wesion.com>
 <20240730033053.4092132-3-jacobe.zang@wesion.com>
 <191025b5268.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <f45c1fa7-f321-4a1f-b65c-6ed326a18268@kernel.org>
 <191030eac78.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <TYZPR03MB7001AA581B8B63AC19A7977C80B02@TYZPR03MB7001.apcprd03.prod.outlook.com>
 <191031cb638.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <191031cb638.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7001:EE_|KL1PR03MB8753:EE_
x-ms-office365-filtering-correlation-id: ae10f943-7b05-4413-b7a8-08dcb080de33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?tldED6YBXZ87wY60t4zu9aP3gkqBX90ujKNuJ5iJj/pDCI6B9o1Qy39t4t?=
 =?iso-8859-1?Q?cNqyEQtDer4f3QLA8Z93/BdZA5x2tei/71zd50D3KajdsW8fGmtWZIciDH?=
 =?iso-8859-1?Q?qFB4tQVy++B7dUxaysydx+Kk/dTp+I6ZIQX1b2ZwWtgpo2kEv9bPDVED6K?=
 =?iso-8859-1?Q?M2r4enCHqJxGq0Jl4VgJxSHw9kDtiEtVNZOotsrcY8YG+BgTi8TGkGVmlJ?=
 =?iso-8859-1?Q?UL/2i51zGLyb8JlfQGikhdqWzor37tY61CgKnslLJZ3aO8b+Z4IUVyL5AR?=
 =?iso-8859-1?Q?RYRLFeBZvzyjvsTzqC964bmJJ9IRsvE2Tj0ChrS2egYwx1glekGNUPWXsZ?=
 =?iso-8859-1?Q?1E4KDXWUwXlWHoBDRitkwu8u4o1SHAO5nqBKx8hgzoCfVag4RfPK+Q5tWe?=
 =?iso-8859-1?Q?7oUCkExy7STrXqkgsaUHp5MbE9wCFJFRFacLIKm72O8LlCAOxILQiW0EEZ?=
 =?iso-8859-1?Q?MCwcKWbkd4uAlbEA3IVpSbrROqqC0AiuAWMD7+B+Bx8Rx1Fo1LagnZ6Sfd?=
 =?iso-8859-1?Q?sa2axf8eN5zaPPaf2fLd0pFYsEuT642E/5NYKdBXmLm6nU8++mk8tcjNy1?=
 =?iso-8859-1?Q?hLzeoL00tq/EWECiqZ4Ilfm0Zng+C3yn7voi1w6LBRLM8Iyb11H6hZdnsu?=
 =?iso-8859-1?Q?6uh+ztmKyJdw6J44h97ki2VWvxv5BQ0HkRbLchnbi6vBGfoErk+UyqKnMz?=
 =?iso-8859-1?Q?BS+C5wGF5j/NrGdjNmyMeSxq+Prht+mVCDbt74/Uthk9+woG57XkiwhPjM?=
 =?iso-8859-1?Q?cvJnObL8cNgO9zqkswLwbj6Ilz+egv9PfrMXTpws2lTgf683+c/HLOq1j5?=
 =?iso-8859-1?Q?iw6mj3wakLbkJ5TFvSudOlAxsHgmT0PJ7RbWUQSAp6wZu4e7lDfkmaG6Lk?=
 =?iso-8859-1?Q?ifZR4SsNWutZR2MkWJY2l04AS0clianHRLuP3LITqEjXF/cAcEFx016ahx?=
 =?iso-8859-1?Q?7D+AwJp4zANLCojqzz/TsGdGZMdkLM5maJZZZni/K30R4PhGO8NyC/4Tou?=
 =?iso-8859-1?Q?FvPPVRWgNNuseOD+0qgC05Rc1t4g3rYBjsPonaH5od2KKMHpb2qQFIqX2L?=
 =?iso-8859-1?Q?pJtnvK01rwNubmyuvMx7pOoxId+SNulw8QoERvcO7EE8MiFEo6A4feTnWI?=
 =?iso-8859-1?Q?sJlAmr79bWyWAcaRfWdjrHeF8gMW3/dMP+nhN44CQR4I0ZiZsSnoNu5ZnK?=
 =?iso-8859-1?Q?x2nw7d+7YQAIHMcxnd7qZkzes+UUFjr5ngpHzUFIDR+9skVSpNysTV4cRd?=
 =?iso-8859-1?Q?7JTsQh/Vw1Dj2aHCRyMoKLU1Kuw4bYJVSnW50d7EmrOx1xIbcwE7hYN2Qc?=
 =?iso-8859-1?Q?lzgmkCw+LDjcWLI9VNawX7g1Rt26w39Fk8PHZviM/EBn4aIa8AkqlK8Ac6?=
 =?iso-8859-1?Q?xNsKmkOIywFxsU5Awf0UXF56UsSQFTxhz/k7d7PTVUNNRdiYb019fJo6Xb?=
 =?iso-8859-1?Q?ZWJI2HKNKFou7ixsat6mqFCYX4yyuByGFvoK8QkhuWgBFsp6qkmiV8bJQQ?=
 =?iso-8859-1?Q?E=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Sidzx+3jHusY6mGHGPEa+DicjiZMOfLjSX21iacyEBMAyCNrt476K8suvr?=
 =?iso-8859-1?Q?cV1FO6ZcSlcoN/f/7iC68ATQWh/C+Uhk73Ka8qvs2tAriguJ3/3DIzaVsr?=
 =?iso-8859-1?Q?+1pcf8jtPUXuiTdRRZ857CKz+UULuF50YwsU8Vx9j1IaMeivY/cvzJbxAM?=
 =?iso-8859-1?Q?5QEHFdns7btEd5S1IbqV/02620OrZGdPSO7Zc+KzThgwIsbyFuboYRsviT?=
 =?iso-8859-1?Q?wL1spp1ESUkwT+y1UQwroThs4R/Cy3G8lxL81lDdXTextW59Bt7Qk2E7Vv?=
 =?iso-8859-1?Q?NuHzYQVyXn5iWPgLUAi4xDDyUCLliIsTzJOwA8buGh+LuB9Fh8Q75dDBHC?=
 =?iso-8859-1?Q?ggXzfuQc7s15PrsZnqsvf4u6e5iMunQxpD/JbL6/CD0rPQvERaV+LKfiN3?=
 =?iso-8859-1?Q?px5ko9XmzFhtkpIxAQzRZEuFWVoc92mcglvs1TbI6VhWwW2EfpuoaJsAw7?=
 =?iso-8859-1?Q?WzvpWzXYoF1IN9Cg+BMjDCRfu4mx3bTDTj+WaonqzZfduPcgavtEsn84Iz?=
 =?iso-8859-1?Q?fXVUnfNFTDHiEcwCK5bOJzbhK7n9kSwyI+vKkfpR9i4NPLIQrOnOX20Ca3?=
 =?iso-8859-1?Q?kC+R1Pjv7usahU73/fusVCpNM9zcRT7xSW2dRZbijf7vCtZkzOIIJaR6CN?=
 =?iso-8859-1?Q?nLEy7CCFiaxPqmxPbOEL1qdFcCjKJh2bYwQLC8g282ExZwzXwe/0o0WlKf?=
 =?iso-8859-1?Q?NcPTe9fNi4ZSJKfJ3ZZJUAu4yU/RFA+wWFDbhc944P5nhEx0Gmmnp1eE1s?=
 =?iso-8859-1?Q?y5/UW6G609ZTaiBs24M1XwQiytBHFUl3d+FmA/0BNx4ARH89SIpIFOTLM6?=
 =?iso-8859-1?Q?em8WvJMRwetgkXMB6Er+eA3+9wa0Lwg6iataE5nIy5G0fydf7OL6h6vKah?=
 =?iso-8859-1?Q?H/D/bnz14MmLG42KP2MvrWyHmPPYWApoR91RDpodJ6CbT3zpuHBV0Lkpzz?=
 =?iso-8859-1?Q?bppy0tpS7c1cV8TEXJX7kL/OyAQgfr2uFxO1EYVoLy6lPuMMtKAq7psS0r?=
 =?iso-8859-1?Q?ReLqSCBaRuvrT++1eg11OpoV8ZBVIfqLlUG9R70J/V3HxesV8V+NHzT+Kj?=
 =?iso-8859-1?Q?Diu8LjUFDvEz3nPuLcneNGiaFLRxzWPJNuOVjI/Lvo1mZ32bIREHO2/eOK?=
 =?iso-8859-1?Q?tVaD5RIY5TbSkRLaIehyjtw+EdwmNUowzSx8ETv/5fHUdr4hFcLPnkfJZy?=
 =?iso-8859-1?Q?qN7OTQUgogWY+mIdIL0TkkV1Z7HhC1oRGsXvy+REsyBW8/L1/WW/BaEcMg?=
 =?iso-8859-1?Q?s+8wJOkG7I59oABs9fcbUe0alx671K/AOt87gxgdTlHU5lydDdKDwNAVFE?=
 =?iso-8859-1?Q?0f6prBLo2sy3yysJQmtes04SZOuL1S9RZ0H3pjaYLV3yzk00cJs/Q8E7Uq?=
 =?iso-8859-1?Q?/HOKsO4ZkaH2xHFEsSWjsFLt9z/LB4qEU52Mzfuj2MQdW2NWZhhajWgjpT?=
 =?iso-8859-1?Q?syTlRLRvOYcOfp0x8rPMG6+O9RHsSTZmdkeu1mqcpRspqHFb4yGfyUpc/K?=
 =?iso-8859-1?Q?g+nvUfo97nALWBWaN0PLs4RfgygyYY9BX1ijvRG/udCpF9bvybSv0FsVUI?=
 =?iso-8859-1?Q?m7hfu90UJATI+L/lXJfEafb2i22R2zEelk2cxcKdzEvBsmyIOJ5QNjJWJm?=
 =?iso-8859-1?Q?3TpeIjaKwr/dRfLYez0dV+xK4sy2SJe2em?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ae10f943-7b05-4413-b7a8-08dcb080de33
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 10:17:50.9480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZdnuZ1xihxcjEY78MskuoEFLH2eHofe0hG8jBDf4oAoa0jiaXFRC6Njblt/jCVe3mj0y+OBbsVmOJydzn8eYtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8753

>>>> On 30/07/2024 08:37, Arend Van Spriel wrote:=0A=
>>>>> + Linus W=0A=
>>>>>=0A=
>>>>> On July 30, 2024 5:31:15 AM Jacobe Zang <jacobe.zang@wesion.com> wrot=
e:=0A=
>>>>>=0A=
>>>>>> Not only AP6275P Wi-Fi device but also all Broadcom wireless devices=
 allow=0A=
>>>>>> external low power clock input. In DTS the clock as an optional choi=
ce in=0A=
>>>>>> the absence of an internal clock.=0A=
>>>>>>=0A=
>>>>>> Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>=0A=
>>>>>> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>=0A=
>>>>>> ---=0A=
>>>>>> .../bindings/net/wireless/brcm,bcm4329-fmac.yaml          | 8 ++++++=
++=0A=
>>>>>> 1 file changed, 8 insertions(+)=0A=
>>>>>>=0A=
>>>>>> diff --git=0A=
>>>>>> a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.y=
aml=0A=
>>>>>> b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.y=
aml=0A=
>>>>>> index 2c2093c77ec9a..a3607d55ef367 100644=0A=
>>>>>> --- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fm=
ac.yaml=0A=
>>>>>> +++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fm=
ac.yaml=0A=
>>>>>> @@ -122,6 +122,14 @@ properties:=0A=
>>>>>> NVRAM. This would normally be filled in by the bootloader from platf=
orm=0A=
>>>>>> configuration data.=0A=
>>>>>>=0A=
>>>>>> +  clocks:=0A=
>>>>>> +    items:=0A=
>>>>>> +      - description: External Low Power Clock input (32.768KHz)=0A=
>>>>>> +=0A=
>>>>>> +  clock-names:=0A=
>>>>>> +    items:=0A=
>>>>>> +      - const: lpo=0A=
>>>>>> +=0A=
>>>>>=0A=
>>>>> We still have an issue that this clock input is also present in the=
=0A=
>>>>> bindings specification broadcom-bluetooth.yaml (not in bluetooth=0A=
>>>>> subfolder). This clock is actually a chip resource. What happens if b=
oth=0A=
>>>>> are defined and both wifi and bt drivers try to enable this clock? Ca=
n this=0A=
>>>>> be expressed in yaml or can we only put a textual warning in the prop=
erty=0A=
>>>>> descriptions?=0A=
>>>>=0A=
>>>> Just like all clocks, what would happen? It will be enabled.=0A=
>>>=0A=
>>> Oh, wow! Cool stuff. But seriously is it not a problem to have two enti=
ties=0A=
>>> controlling one and the same clock? Is this use-case taken into account=
 by=0A=
>>> the clock framework?=0A=
>>=0A=
>> I have enabled the same clock both in bluetooth and wifi just now, they =
worked=0A=
>> well. Maybe this make sense?=0A=
>=0A=
> What happens if you unload one of the drivers? Also would like to know if=
=0A=
> you are using an nvram file. If so can you share it's content.=0A=
=0A=
After rmmod the wifi relevant driver, bluetooth still works well. The conte=
nt of=0A=
nvram text shows below:=0A=
# AP6275P_NVRAM_V1.1_20200702 =0A=
# AP6271P_V00 board, iPA version.=0A=
# nvram copied and edited from AP6271P_EVB_V01 EVB board //=0A=
# SSID generated using Alberto's boardssid.py script:=0A=
# ********************SUMMARY********************=0A=
# Board Name: AP6271P_V00=0A=
#SSID: 0x086d=0A=
#macmid: 0x02df=0A=
# Successfully made SSID entry in sromdefs.tcl.=0A=
# Successfully made macmid entry in sromdefs.tcl.=0A=
# Successfully made SSID entry in tblssid.py.=0A=
# *************************************************=0A=
# $ Copyright Broadcom $=0A=
#=0A=
#=0A=
# <<Broadcom-WL-IPTag/Proprietary:>>=0A=
NVRAMRev=3D$Rev: 874188 $=0A=
sromrev=3D11=0A=
boardrev=3D0x1213=0A=
boardtype=3D0x08ed=0A=
boardflags=3D0x00400201=0A=
boardflags2=3D0xc0800000=0A=
boardflags3=3D0x40002180=0A=
#boardnum=3D57410=0A=
macaddr=3D00:90:4c:12:d0:01=0A=
jtag_irw=3D38=0A=
=0A=
#Regulatory specific=0A=
ccode=3D0=0A=
regrev=3D0=0A=
=0A=
# Board specific=0A=
vendid=3D0x14e4=0A=
devid=3D0x449d=0A=
manfid=3D0x2d0=0A=
antswitch=3D0=0A=
pdgain5g=3D0=0A=
pdgain2g=3D0=0A=
aa2g=3D3=0A=
aa5g=3D3=0A=
agbg0=3D2=0A=
agbg1=3D2=0A=
aga0=3D2=0A=
aga1=3D2=0A=
extpagain2g=3D2=0A=
extpagain5g=3D2=0A=
rxgains2gelnagaina0=3D0=0A=
rxgains2gtrisoa0=3D0=0A=
rxgains2gtrelnabypa0=3D0=0A=
rxgains5gelnagaina0=3D0=0A=
rxgains5gtrisoa0=3D0=0A=
rxgains5gtrelnabypa0=3D0=0A=
rxgains5gmelnagaina0=3D0=0A=
rxgains5gmtrisoa0=3D0=0A=
rxgains5gmtrelnabypa0=3D0=0A=
rxgains5ghelnagaina0=3D0=0A=
rxgains5ghtrisoa0=3D0=0A=
rxgains5ghtrelnabypa0=3D0=0A=
rxgains2gelnagaina1=3D0=0A=
rxgains2gtrisoa1=3D0=0A=
rxgains2gtrelnabypa1=3D0=0A=
rxgains5gelnagaina1=3D0=0A=
rxgains5gtrisoa1=3D0=0A=
rxgains5gtrelnabypa1=3D0=0A=
rxgains5gmelnagaina1=3D0=0A=
rxgains5gmtrisoa1=3D0=0A=
rxgains5gmtrelnabypa1=3D0=0A=
rxgains5ghelnagaina1=3D0=0A=
rxgains5ghtrisoa1=3D0=0A=
rxgains5ghtrelnabypa1=3D0=0A=
=0A=
#RSSI related=0A=
# 2G=0A=
rssicorrnorm_c0=3D4,4=0A=
rssicorrnorm_c1=3D4,4=0A=
# 5G=0A=
rssicorrnorm5g_c0=3D5,5,5,5,5,5,5,5,5,5,5,5=0A=
rssicorrnorm5g_c1=3D4,4,4,4,4,4,4,4,4,4,4,4=0A=
=0A=
=0A=
#Two range TSSI=0A=
tworangetssi2g=3D0=0A=
tworangetssi5g=3D0=0A=
lowpowerrange2g=3D0=0A=
lowpowerrange5g=3D0=0A=
low_adc_rate_en=3D1=0A=
=0A=
nocrc=3D1=0A=
otpimagesize=3D502=0A=
=0A=
xtalfreq=3D37400=0A=
=0A=
txchain=3D3=0A=
rxchain=3D3=0A=
=0A=
cckdigfilttype=3D2=0A=
=0A=
#bit mask for slice capability bit 0:2G bit 1:5G=0A=
bandcap=3D3=0A=
=0A=
#TXBF Related=0A=
rpcal2g=3D0=0A=
rpcal5gb0=3D0=0A=
rpcal5gb1=3D0=0A=
rpcal5gb2=3D0=0A=
rpcal5gb3=3D0=0A=
=0A=
=0A=
#FDSS Related=0A=
fdss_level_2g=3D4,4=0A=
fdss_interp_en=3D1=0A=
fdss_level_5g=3D3,3=0A=
fdss_level_11ax_2g=3D3,3=0A=
fdss_level_11ax_2g_ch1=3D3,3=0A=
fdss_level_11ax_2g_ch11=3D3,3=0A=
fdss_level_11ax_5g=3D3,3=0A=
=0A=
#Tempsense Related=0A=
tempthresh=3D255=0A=
tempoffset=3D40=0A=
rawtempsense=3D0x1ff=0A=
phycal_tempdelta=3D15=0A=
temps_period=3D15=0A=
temps_hysteresis=3D15=0A=
=0A=
#------------- TSSI Related -------------=0A=
tssipos2g=3D1=0A=
tssipos5g=3D1=0A=
AvVmid_c0=3D2,127,4,92,4,91,4,91,4,94=0A=
AvVmid_c1=3D2,127,4,93,4,93,4,95,3,110=0A=
=0A=
# CCK in case of multi mode 2=0A=
pa2gccka0=3D-137,7810,-928=0A=
pa2gccka1=3D-139,7853,-929=0A=
# OFDM in case of multi_mode 2=0A=
pa2ga0=3D-103,7727,-855=0A=
pa2ga1=3D-126,7258,-826=0A=
pa5ga0=3D-176,5703,-703,-180,5747,-708,-165,5994,-732,-146,6299,-757=0A=
pa5ga1=3D-132,6132,-760,-107,6472,-769,-142,6184,-752,-108,7237,-858=0A=
=0A=
# Max power and offsets=0A=
maxp2ga0=3D86=0A=
maxp2ga1=3D86=0A=
maxp5ga0=3D74,74,74,74=0A=
maxp5ga1=3D68,68,68,70=0A=
subband5gver=3D0x4=0A=
paparambwver=3D3=0A=
cckpwroffset0=3D0=0A=
cckpwroffset1=3D0=0A=
pdoffset40ma0=3D0x4433=0A=
pdoffset80ma0=3D0x3232=0A=
pdoffset40ma1=3D0x2333=0A=
pdoffset80ma1=3D0x1222=0A=
cckbw202gpo=3D0x2222=0A=
cckbw20ul2gpo=3D0=0A=
mcsbw202gpo=3D0x98533221=0A=
mcsbw402gpo=3D0x44000000=0A=
dot11agofdmhrbw202gpo=3D0x4444=0A=
ofdmlrbw202gpo=3D0x0033=0A=
mcsbw205glpo=3D0x49533322=0A=
mcsbw405glpo=3D0xE9443342=0A=
mcsbw805glpo=3D0xEC665542=0A=
mcsbw1605glpo=3D0=0A=
mcsbw205gmpo=3D0x49200000=0A=
mcsbw405gmpo=3D0xE9443342=0A=
mcsbw805gmpo=3D0xEC665542=0A=
mcsbw1605gmpo=3D0=0A=
mcsbw205ghpo=3D0x49312220=0A=
#mcsbw405ghpo=3D0x84-1-1-2-2-2-5=0A=
mcsbw405ghpo=3D0xC8221110=0A=
#mcsbw405ghpo=3D0x88555555=0A=
mcsbw805ghpo=3D0xCC443320=0A=
powoffs2gtna0=3D0,0,0,0,0,0,0,0,0,0,0,0,0,0=0A=
powoffs2gtna1=3D0,0,0,0,0,0,0,0,0,0,0,0,0,0=0A=
mcs1024qam2gpo=3D0xDDDD=0A=
mcs1024qam5glpo=3D0xFFFFCC=0A=
mcs1024qam5gmpo=3D0xFFFFCC=0A=
mcs1024qam5ghpo=3D0xFFFFCC=0A=
mcs1024qam5gx1po=3D0xFFFFCC=0A=
mcs1024qam5gx2po=3D0xFFFFCC=0A=
mcs8poexp=3D0=0A=
mcs9poexp=3D0=0A=
mcs10poexp=3D0=0A=
=0A=
# 5G power offset per channel for band edge channel=0A=
powoffs5g20mtna0=3D0,0,0,0,0,0,0=0A=
powoffs5g20mtna1=3D0,0,0,0,0,0,0=0A=
powoffs5g40mtna0=3D0,0,0,0,0=0A=
powoffs5g40mtna1=3D0,0,0,0,0=0A=
powoffs5g80mtna0=3D0,0,0,0,0=0A=
powoffs5g80mtna1=3D0,0,0,0,0=0A=
mcs11poexp=3D0=0A=
=0A=
#LTE Coex Related=0A=
ltecxmux=3D0=0A=
ltecxpadnum=3D0x0504=0A=
ltecxfnsel=3D0x44=0A=
ltecxgcigpio=3D0x04=0A=
#OOB params=0A=
#device_wake_opt=3D1=0A=
host_wake_opt=3D0=0A=
=0A=
# SWCTRL Related=0A=
=0A=
swctrlmap_2g=3D0x10101010,0x06030401,0x04011010,0x000000,0x3FF=0A=
swctrlmapext_2g=3D0x00000000,0x00000000,0x00000000,0x000000,0x000=0A=
swctrlmap_5g=3D0x80408040,0x21240120,0x01208040,0x000000,0x3FF=0A=
swctrlmapext_5g=3D0x00000000,0x00000000,0x00000000,0x000000,0x000=0A=
clb2gslice0core0=3D0x01b=0A=
clb2gslice1core0=3D0x000=0A=
clb5gslice0core0=3D0x064=0A=
clb5gslice1core0=3D0x000=0A=
clb2gslice0core1=3D0x056=0A=
clb2gslice1core1=3D0x000=0A=
clb5gslice0core1=3D0x0a1=0A=
clb5gslice1core1=3D0x000=0A=
btc_prisel_ant_mask=3D0x2=0A=
clb_swctrl_smask_ant0=3D0x27f=0A=
clb_swctrl_smask_ant1=3D0x2f7=0A=
muxenab=3D1=0A=
=0A=
#BT Coex 1:TDM=0A=
btc_mode=3D1=0A=
=0A=
# --- PAPD Cal related params ----=0A=
txwbpapden=3D0 # 0:NBPAPD 1:WBPAPD=0A=
# NB PAPD Cal params=0A=
nb_eps_offset=3D470,470=0A=
nb_bbmult=3D66,66=0A=
nb_papdcalidx=3D6,6=0A=
nb_txattn=3D2,2=0A=
nb_rxattn=3D1,1=0A=
nb_eps_stopidx=3D63=0A=
epsilonoff_5g20_c0=3D0,0,0,0=0A=
epsilonoff_5g40_c0=3D0,0,0,0=0A=
epsilonoff_5g80_c0=3D0,0,0,0=0A=
epsilonoff_5g20_c1=3D0,0,0,0=0A=
epsilonoff_5g40_c1=3D0,0,0,0=0A=
epsilonoff_5g80_c1=3D0,0,-1,-1=0A=
epsilonoff_2g20_c0=3D0=0A=
epsilonoff_2g20_c1=3D0=0A=
=0A=
# energy detect threshold=0A=
ed_thresh2g=3D-67=0A=
ed_thresh5g=3D-67=0A=
# energy detect threshold for EU=0A=
eu_edthresh2g=3D-67=0A=
eu_edthresh5g=3D-67=0A=
=0A=
#rpcal coef for imptxbf=0A=
rpcal5gb0=3D238=0A=
rpcal5gb1=3D228=0A=
rpcal5gb2=3D222=0A=
rpcal5gb3=3D229=0A=
rpcal2g=3D15=0A=
ocl=3D1=0A=
bt_coex_chdep_div=3D1=0A=
=0A=
# OLPC Related=0A=
disable_olpc=3D0=0A=
olpc_thresh5g=3D32=0A=
olpc_anchor5g=3D40=0A=
olpc_thresh2g=3D32=0A=
olpc_anchor2g=3D40=0A=
=0A=
#PAPR related=0A=
paprdis=3D0=0A=
paprrmcsgamma2g=3D500,550,550,-1,-1,-1,-1,-1,-1,-1,-1,-1=0A=
paprrmcsgain2g=3D128,128,128,0,0,0,0,0,0,0,0,0=0A=
paprrmcsgamma2g_ch13=3D500,550,550,-1,-1,-1,-1,-1,-1,-1,-1,-1=0A=
paprrmcsgain2g_ch13=3D128,128,128,0,0,0,0,0,0,0,0,0=0A=
paprrmcsgamma2g_ch1=3D500,550,550,-1,-1,-1,-1,-1,-1,-1,-1,-1=0A=
paprrmcsgain2g_ch1=3D128,128,128,0,0,0,0,0,0,0,0,0=0A=
paprrmcsgamma5g20=3D500,500,500,-1,-1,-1,-1,-1,-1,-1,-1,-1=0A=
paprrmcsgain5g20=3D128,128,128,0,0,0,0,0,0,0,0,0=0A=
paprrmcsgamma5g40=3D600,600,600,-1,-1,-1,-1,-1,-1,-1,-1,-1=0A=
paprrmcsgain5g40=3D128,128,128,0,0,0,0,0,0,0,0,0=0A=
paprrmcsgamma5g80=3D-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1=0A=
paprrmcsgain5g80=3D0,0,0,0,0,0,0,0,0,0,0,0=0A=
=0A=
# Enable papd for cck when target pwr ge 16dBm=0A=
cckpapd_pwrthresh=3D64=0A=
=0A=
## ULOFDMA Board limit PPRs for 2G20 ##=0A=
ruppr2g20bpska0=3D0x0=0A=
ruppr2g20bpska1=3D0x0=0A=
ruppr2g20qpska0=3D0x0=0A=
ruppr2g20qpska1=3D0x0=0A=
ruppr2g20qam16a0=3D0x0=0A=
ruppr2g20qam16a1=3D0x0=0A=
ruppr2g20qam64a0=3D0x1=0A=
ruppr2g20qam64a1=3D0x1=0A=
ruppr2g20qam256a0=3D0x21084=0A=
ruppr2g20qam256a1=3D0x21084=0A=
ruppr2g20qam1024a0=3D0x0=0A=
ruppr2g20qam1024a1=3D0x0=0A=
## ULOFDMA Board limit PPRs for 5G20 ##=0A=
ruppr5g20bpska0=3D0x20000=0A=
ruppr5g20bpska1=3D0x20000=0A=
ruppr5g20qpska0=3D0x18000=0A=
ruppr5g20qpska1=3D0x18000=0A=
ruppr5g20qam16a0=3D0x28000=0A=
ruppr5g20qam16a1=3D0x28000=0A=
ruppr5g20qam64a0=3D0x29086=0A=
ruppr5g20qam64a1=3D0x29086=0A=
ruppr5g20qam256a0=3D0x62908=0A=
ruppr5g20qam256a1=3D0x62908=0A=
ruppr5g20qam1024a0=3D0x70000=0A=
ruppr5g20qam1024a1=3D0x70000=0A=
## ULOFDMA Board limit PPRs for 5G40 ##=0A=
ruppr5g40bpska0=3D0x638000=0A=
ruppr5g40bpska1=3D0x638000=0A=
ruppr5g40qpska0=3D0x840020=0A=
ruppr5g40qpska1=3D0x840020=0A=
ruppr5g40qam16a0=3D0x638001=0A=
ruppr5g40qam16a1=3D0x638001=0A=
ruppr5g40qam64a0=3D0x739085=0A=
ruppr5g40qam64a1=3D0x739085=0A=
ruppr5g40qam256a0=3D0x106a108=0A=
ruppr5g40qam256a1=3D0x106a108=0A=
ruppr5g40qam1024a0=3D0x1078000=0A=
ruppr5g40qam1024a1=3D0x1078000=0A=
## ULOFDMA Board limit PPRs for 5G80 ##=0A=
ruppr5g80bpska0=3D0x0=0A=
ruppr5g80bpska1=3D0x0=0A=
ruppr5g80qpska0=3D0x0=0A=
ruppr5g80qpska1=3D0x0=0A=
ruppr5g80qam16a0=3D0x0=0A=
ruppr5g80qam16a1=3D0x0=0A=
ruppr5g80qam64a0=3D0x187218e7=0A=
ruppr5g80qam64a1=3D0x187218e7=0A=
ruppr5g80qam256a0=3D0x3904254a=0A=
ruppr5g80qam256a1=3D0x3904254a=0A=
ruppr5g80qam1024a0=3D0x49068000=0A=
ruppr5g80qam1024a1=3D0x49068000=0A=
=0A=
=0A=
---=0A=
Best Regards=0A=
Jacobe=0A=
=0A=
=0A=

