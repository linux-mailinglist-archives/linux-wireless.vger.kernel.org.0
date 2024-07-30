Return-Path: <linux-wireless+bounces-10676-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AF6940E89
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 12:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6DF51F2472A
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 10:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D5E198858;
	Tue, 30 Jul 2024 10:00:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E50818E741;
	Tue, 30 Jul 2024 10:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722333627; cv=fail; b=bgx9D9hztqFgLXYfN76Uowa0QmKTZ1G42yUdrpvIVu7wCaDw69ey2xDldCz+WS1onLcXScOhJpiZjOnIloG0VhZsJ23jaZwE5r6X6z5XtccQCBV/8u/ghzPCt9OWfFJsQZmoaMNLIOnBU7kZb0wLiZDzySfThxf7qNgUNPrweg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722333627; c=relaxed/simple;
	bh=GJFQQjD8b+UhBuUzEAYPcX3wVSIokeTN/daGmxUI4xo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HPnNAU95v6FnAIw7zsI1/bFRjM6i3LwMl1Om77oY9dX+9Ml8gbvaAkuJPnwuvMdYBuN10ubJYv1Eu+iQztkpsSURNoShKEX3kefmWpn4xpKc6J8FJp6a8nzFx/WBMfevScMc+8tQG49JUdrIZOStCSm8sZKk/akwekMu9iZ4UGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rerVmuxQVuKKKgoHR+lvTOZvr/R9bo4athz7mrFUk3szh48O56HB2nyX62p0uRcfthLOMl1hTPKpvNxpk3yYS4inuVg1mydPnurDmCuRbKHrtO4cfOhYjYry7uE5/C1G4Ba7RqI8p/p8O8AhPy25jPli6ndqiOBDAub2ku2NxL0alwpBqjWf/HNpIJX1RC2DETIdR3cR5PVooaAcgZ/o5RQII3Uu8lgA82sVs53W/Mj31YsW9ngLCepcwFe7v0bjIi3ivnCYId5qqXUG3nGBPcLVNCKxOaM7nzQapApq0Aa2kLanIT1sGsQ1+R3O9pT9PDoyVTHuaL/ugKLQwy+VRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJFQQjD8b+UhBuUzEAYPcX3wVSIokeTN/daGmxUI4xo=;
 b=pBMSWAnt+bj5Irw75uO54nDxHb4aWy3dJCq63E8LPNIn2rkskSPBwagAp49CDKQbGq/eDNMb+L87juzw8YMQUKTK1J+guNjUDU3qmQKOQh0uSXKiFnlqiUExDsGJV3Ge4PjZqjAyt6LnvOAy0FOXG8md7g39QXAtFQ+ef+NOQ/Z9OPwdIcKGZKc4RU4sePcGvzSDj2TbWhJs3eiaR0LOxyZhTveDW6HC8WzcwBdm+dObqDk8IAhcIpcwbr+55fNpAgJnFTkN13PIUIqWwrHhLRlQs61xTNWOLhRpn4NO91FQNWGJqc70sn5PyCo0kCc0w9ElK0Ya87V3485DfbQZgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by TYZPR03MB7411.apcprd03.prod.outlook.com (2603:1096:400:429::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 10:00:21 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7784.020; Tue, 30 Jul 2024
 10:00:20 +0000
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
Thread-Index: AQHa4jDtxz/Ha1L1bk2aE8Abf13SIrIO0WeAgAAoWoCAAA5igIAAAC3W
Date: Tue, 30 Jul 2024 10:00:20 +0000
Message-ID:
 <TYZPR03MB7001AA581B8B63AC19A7977C80B02@TYZPR03MB7001.apcprd03.prod.outlook.com>
References: <20240730033053.4092132-1-jacobe.zang@wesion.com>
 <20240730033053.4092132-3-jacobe.zang@wesion.com>
 <191025b5268.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <f45c1fa7-f321-4a1f-b65c-6ed326a18268@kernel.org>
 <191030eac78.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <191030eac78.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7001:EE_|TYZPR03MB7411:EE_
x-ms-office365-filtering-correlation-id: 9e1a9719-85e6-4575-1093-08dcb07e6c3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?2A7fqquAAM9jDZphe9kTFOG8h7HjpGHmWO6jcKnrxAAoB6OOUrChNhQFA+?=
 =?iso-8859-1?Q?3cxmsIYVME5gukTAQCIlHzopduEzLvK2EnxH8hLX26Y6x2ZvmwPdu5lMGI?=
 =?iso-8859-1?Q?OKB0JBpySuj+HERBP3k4loQXu/I3D5h3pg+4OgvRNDNFBCu6srsnIfrKs/?=
 =?iso-8859-1?Q?0/t79Y1JhZH7uyEwJXMnc+lFZRkCff4mDniFCVitp2g/1Ovwxk8cy7+vps?=
 =?iso-8859-1?Q?zyDbbdjn6WGF7MnTS3aMqylJrqve1TraXKlSn1CbGAAo/YH2atPzTYBFkB?=
 =?iso-8859-1?Q?CwrXviSx1EzD+YJBSq/zfwrH4QjZABTSBCBxFH3NwfnAmD/DMX1ghLVzzF?=
 =?iso-8859-1?Q?1qcbwWOo7zAzEOLoL/PgMdqOv5g8lmuJK9HGrGXVlrBVSqypIcVBdwc80j?=
 =?iso-8859-1?Q?UqLCPTLqRK7IwVnWP73CQc1CnAQvT8tvEYBULBepxNVznKQlYWYBLmR/St?=
 =?iso-8859-1?Q?kyYsczUEFKbx0JFMIjc19t3cxfSyFJPt9tMf1m1K/Nj/sZhJDJXZ3dKjqY?=
 =?iso-8859-1?Q?VojcA47xX3uPgjDeU0YmNr2Ohvyd4G9gsAagV6gVe7Y5Qip+Yrms5npV4F?=
 =?iso-8859-1?Q?xxEr1jtvJ5VgRy3/7Rve7D/LuEZztzKzDsSsjeCTxCgXOSyyrC9Ua9/A7O?=
 =?iso-8859-1?Q?yIzav/wGonRcyiJyUZffuO8FbYjMt1SZFV9Y2Nc8mvpqguzfMsm2gsllm+?=
 =?iso-8859-1?Q?p9H17FWRK2zpaiTOdUoVkGnRlprBL0kH997gSvPX6IDNpDMDZy1j1JFYwJ?=
 =?iso-8859-1?Q?WURIro45scAkmQJC4XpBRvSj/Ge/xBYxGHuCJe3OEr2Q3mBPPMz254gYJC?=
 =?iso-8859-1?Q?+DimNtPSIsjJ3kjSHdz/9vfAS0iGdFmRa/drLZ2HAYEYERlcJUT7gIi2IS?=
 =?iso-8859-1?Q?mZe9KbGFVllRbib1+v69vb5amTZFP2Zr9hLFFAUaY3BAxQxwhPovEYiekU?=
 =?iso-8859-1?Q?w0fCQ1hliBJpYVHg3RZIF/zO6KWPZ46OIyBc7CbzHGvvx6ahEYRCJBYA4g?=
 =?iso-8859-1?Q?xhgJxamhwR2MN0IfTzBETVPzIlN92XS4Y6vyb2k351Wy2yUnQXHCVXCl8P?=
 =?iso-8859-1?Q?8b1psIGgOz2bkNoobCcyY93BRn2taE9NJ4boZSihQVL9RgKGHC3kMdZI/u?=
 =?iso-8859-1?Q?CnFzeH3/eZmNkPbjqwwbJAoDF6lkEES5i9qEalXmtm9fBGy64H8sceKPgz?=
 =?iso-8859-1?Q?rt1OFXDvADOs5LQzfhpPrvBHs585PJJ1TS4CFq7k/+hOCmi83NC8UV6i73?=
 =?iso-8859-1?Q?dG/Jgc/zAdcWBkSXPsj2GZYRKrBWd+WkcfaWBCo+5W2pTuGG/6VeEzpndL?=
 =?iso-8859-1?Q?DDdX9piD3R3CGZbd1Fv3rgu3CxZFi66aKldwuKlbAlfwfS5UUiBtaRXohk?=
 =?iso-8859-1?Q?Qb/w7yePJqDf4ETZkuQOXRTM9Dyk8SU29VxGfxFk/LFtwq8CPLAIVachxZ?=
 =?iso-8859-1?Q?Y/zqz8b1vW6sTs/iQLr4JIiFPLj/q8xcp9Ih8KMkOXJw/UqBSnBJOfuL2y?=
 =?iso-8859-1?Q?Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?FYB0lKZviaOXJJr2+9n31PhymF3vK97CrvArD23hzORHn7WecgsBF81Mu4?=
 =?iso-8859-1?Q?oQORLCmfJFn8q4ghILadVBG7jF+V8AgyvT+/kpeInlaiOD/K6gSZZzzjvO?=
 =?iso-8859-1?Q?QmHbDkUMd4yjN+KI5qKakHgtMw3eBEiGNnB7dSq4nF+SsyBIQCvTkfLJZk?=
 =?iso-8859-1?Q?q4oqC8sTKaesYcDIrrhR7ovuEOXN1tAzpMNVhBcT9v2EWKFas1V3eMDFsc?=
 =?iso-8859-1?Q?KDF00LwoboeJo4IS5G+UyvlqDUJFBh7P7dfwr03uE8IDIJZDesLgeZePeD?=
 =?iso-8859-1?Q?o0cmDRkWDGb69IlWwk8P+IuvU2xvrpVhTNjLHsn9HQ5e0dcI8s4c7Qm4NQ?=
 =?iso-8859-1?Q?oggjtt0hjt3BfZ2OfoCB8cG7eIo4wjGHKAkxsJjHlGaZWeqN5AY8Eq5L+a?=
 =?iso-8859-1?Q?mp8EBFD6CPYN4bytgVqNb9RReCppBUQuQrbRtseKoKk/cveQJH6RkyTugk?=
 =?iso-8859-1?Q?SISmG6mex5wcInOJyWTmY0V1TT0l3er3sYwozmmOe2XMD8RTza/w3U2uQ9?=
 =?iso-8859-1?Q?qcqWSPSoi/uz69q0g1h6jqZn7iUR/UtRikfAmPkR/kcgam0Mk9p6jpMe3W?=
 =?iso-8859-1?Q?vvQ6SYDDgcNbv3O0ZYKSzS6EE5q2BcChzh6VFL4mBY8jTdLYjoM7Xg6u+3?=
 =?iso-8859-1?Q?LVanVKsK6wiqnUjjvqokAgx8/s+AKHrPUS9IzE1+xAietz7g+HRArrkKmb?=
 =?iso-8859-1?Q?4cv6V3rVspNgvO0r6oTgJgyaBMOkhfgDHDZ+CJ2THrrTPWickwx+mCNUgN?=
 =?iso-8859-1?Q?dZnoBgZ7c0yBINlANJUZ26AzlPZ8fP8lAc3nNr6gkIVWSsU+1RLt+Oo1UO?=
 =?iso-8859-1?Q?jfFSfsdf42X7LclXBquqtsFKa4ysJ6UFEnbVzquBr5VMVNRwwYxpkwXADM?=
 =?iso-8859-1?Q?iRWuskFfNGSPvYgy0/Ztp4snATbDuqrSi4Y6r98QHPYVXm6jgwJFtuUZr0?=
 =?iso-8859-1?Q?pQI1L5zwvWcrd3bVw+UcoEPrSdFxarDF7wWwCZbGP7qteeq8o0m6Du76m8?=
 =?iso-8859-1?Q?eQSixyEIAQZQOmeuGNFw2+PUIPZtvs9YF0dQg+XV6oM9oqFHIB4QCyn1sy?=
 =?iso-8859-1?Q?p25c6rJ7UXN71sd85eJX+tVQpeltGA1LhyhPv/uG5VvsGDiNdda66W60q7?=
 =?iso-8859-1?Q?caCgkakqM1cGtF7q9jbZT4qVGXyciuspMa1Wgbx/lqKfUQooSiEGepzSwD?=
 =?iso-8859-1?Q?fYAvG1HC4A14QMeNjOcUaeeyUUKehcCo4trzQaXzBbtZiDO/ohurcIpPUd?=
 =?iso-8859-1?Q?IiAvLpC3CYxM6siwi4jaM1Rq+bn5veXFD4HUKbYGcZyXfW+MM5ObKl08ZN?=
 =?iso-8859-1?Q?/w8d5gtj1LciOvKUgu2NF4NsbFFsc/n8VGyOA0ugo68SdPwMQxMSszZy1U?=
 =?iso-8859-1?Q?Q7DOK6JYuQCWDkh9cklci0UZqG+vJO5vtDZ0puXIkW64a3IEWjtO+4TKT4?=
 =?iso-8859-1?Q?E1a3A1+R4HIIOLevTNXCE1GmuVZN9254P8I/mIcRkVzINVlL9pjJwBX9Vb?=
 =?iso-8859-1?Q?JJs1J2E5XKvmN3wi0Rhm8tQfs8lPgSIxlJPPTUEfep8qtk8VL92xhdbwtB?=
 =?iso-8859-1?Q?XYgEcorh/W9uoO5feuhM2DIdBLOWyLxE/qp4+J9OoeWVoofh+pfBzJPKhn?=
 =?iso-8859-1?Q?MVlR5Cnuf2lqTtErUepWO/rMSO1mBY/GPE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1a9719-85e6-4575-1093-08dcb07e6c3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 10:00:20.7489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uv/+WjbkWudzRJQ0fwqCrQT77PdvHOzRYcaBg/1a387DaCONRIuzHuor+KKCCKWjW01JX58aI0NeMVgrFMUISQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7411

>> On 30/07/2024 08:37, Arend Van Spriel wrote:=0A=
>>> + Linus W=0A=
>>>=0A=
>>> On July 30, 2024 5:31:15 AM Jacobe Zang <jacobe.zang@wesion.com> wrote:=
=0A=
>>>=0A=
>>>> Not only AP6275P Wi-Fi device but also all Broadcom wireless devices a=
llow=0A=
>>>> external low power clock input. In DTS the clock as an optional choice=
 in=0A=
>>>> the absence of an internal clock.=0A=
>>>>=0A=
>>>> Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>=0A=
>>>> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>=0A=
>>>> ---=0A=
>>>> .../bindings/net/wireless/brcm,bcm4329-fmac.yaml=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 | 8 ++++++++=0A=
>>>> 1 file changed, 8 insertions(+)=0A=
>>>>=0A=
>>>> diff --git=0A=
>>>> a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yam=
l=0A=
>>>> b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yam=
l=0A=
>>>> index 2c2093c77ec9a..a3607d55ef367 100644=0A=
>>>> --- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac=
.yaml=0A=
>>>> +++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac=
.yaml=0A=
>>>> @@ -122,6 +122,14 @@ properties:=0A=
>>>> NVRAM. This would normally be filled in by the bootloader from platfor=
m=0A=
>>>> configuration data.=0A=
>>>>=0A=
>>>> +=A0 clocks:=0A=
>>>> +=A0=A0=A0 items:=0A=
>>>> +=A0=A0=A0=A0=A0 - description: External Low Power Clock input (32.768=
KHz)=0A=
>>>> +=0A=
>>>> +=A0 clock-names:=0A=
>>>> +=A0=A0=A0 items:=0A=
>>>> +=A0=A0=A0=A0=A0 - const: lpo=0A=
>>>> +=0A=
>>>=0A=
>>> We still have an issue that this clock input is also present in the=0A=
>>> bindings specification broadcom-bluetooth.yaml (not in bluetooth=0A=
>>> subfolder). This clock is actually a chip resource. What happens if bot=
h=0A=
>>> are defined and both wifi and bt drivers try to enable this clock? Can =
this=0A=
>>> be expressed in yaml or can we only put a textual warning in the proper=
ty=0A=
>>> descriptions?=0A=
>>=0A=
>> Just like all clocks, what would happen? It will be enabled.=0A=
>=0A=
> Oh, wow! Cool stuff. But seriously is it not a problem to have two entiti=
es=0A=
> controlling one and the same clock? Is this use-case taken into account b=
y=0A=
> the clock framework?=0A=
=0A=
I have enabled the same clock both in bluetooth and wifi just now, they wor=
ked=0A=
well. Maybe this make sense?=0A=
=0A=
---=0A=
Best Regards=0A=
Jacobe=0A=
=0A=

