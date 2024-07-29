Return-Path: <linux-wireless+bounces-10607-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FCE93EFAB
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 10:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6579285B45
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 08:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060CC13AA40;
	Mon, 29 Jul 2024 08:17:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2106.outbound.protection.outlook.com [40.107.117.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC846F2F1;
	Mon, 29 Jul 2024 08:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722241034; cv=fail; b=bHAgCh9Y5RORyUls88NoY6mkqJ/iWgxU80HQ8Rgb1B8/gt+iHpWy4GZ0o3fTo4ARFleaJfzsZJU+zvGgNar9gawTEYdyBYOJ2UUfMMYiziqOW08uTBn4VIzNfLJdmEWbAtsGc6X28Y3bLR4ww/8VbcUHdCCz/qYP3mJ9ZZ0BxZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722241034; c=relaxed/simple;
	bh=hiNTRqJTT3t2Qv1MqTWsjfnhiPzGs2hqbPz1fvdpMaw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J7U3hnGugUN5btwCrXvmNBuXZZvDer5963RB/wIO6Kwf8iJWxUQZZQqH2Lnb0NbqAbnycvLDil+2odIIm8441u4U89JoiBHsTQAqBAiSS0GZcRdM0Es/cnXXt5dlAJp23kojNYXbJMmS34sxveBzUkO6Oh4QTULuxyy7vbWsHYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yiYDgAV5nrjkuFS7fcHsTL+0pIQ+fs23ZNHPn7S75WRKLsMzQwmg9XOPeCjeAilwn/eIMNsIDUPUNrmkKdALhQwV5xtX0FEQ7VaJo002tBdxkh3+jKfMqFZN+5etNJ5KtpWoYjknwGwSir5ljBQLL5BnFwG8MBNPhZ4kZv54lQ3hirntsiTE8ilGTwuqnZOk4R0W7G5eJNUWKRNPdgyf6DmD8ur8IbVpRDweatpmyIIWaPjxxKLybsI6h7zKxxoElROd8aBQfCzT4oMsQBo9LAEXHJ9Z4nagC6mu6oybu61LIg5sQkQoAZ90oh/OVZn1XsE2+fFRR0qBa8Q073LOfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiNTRqJTT3t2Qv1MqTWsjfnhiPzGs2hqbPz1fvdpMaw=;
 b=oEWi3T5SSFwdogZXCc3dptZHJukeWN/BvO30VdA1kd+maALNHhZYMFEalP4aKhoISj0cm/U043IV0vx5eRVULTlCRAzMf48cycaM7wWU1aSO/G1W41xmsGdZg3t5/mJTRs3LBsuCt7jZdjJVCKC8DBh++fFPfHirYofyksuN6lWzRa0wrVRuBYiQo3gOv1oDxRafCZIvKTtG7fzRZWx7nmi+E5vTYEpwW8DiL6ecVAU9ZGkAS00/6UBmsR0uhWt5MRf5BhBGUFV1ZVDi3Abu40Z+3S4dclHD5t36nD6Ys3VTLIJafVETzg3Esnn9fmbPgf+An9ZCqU0XgH5BM2w0Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEZPR03MB6643.apcprd03.prod.outlook.com (2603:1096:101:7b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Mon, 29 Jul
 2024 08:17:06 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7784.020; Mon, 29 Jul 2024
 08:17:06 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"heiko@sntech.de" <heiko@sntech.de>, "kvalo@kernel.org" <kvalo@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "arend.vanspriel@broadcom.com"
	<arend.vanspriel@broadcom.com>
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
Subject: Re: [PATCH v4 2/5] dt-bindings: net: wireless: brcm4329-fmac: add
 clock description for AP6275P Wi-Fi device
Thread-Topic: [PATCH v4 2/5] dt-bindings: net: wireless: brcm4329-fmac: add
 clock description for AP6275P Wi-Fi device
Thread-Index: AQHa4YUmartUX8inGk+UWrzTMZFVbLINUJgAgAAKtvw=
Date: Mon, 29 Jul 2024 08:17:06 +0000
Message-ID:
 <TYZPR03MB7001247E93FB6473128FEB2480B72@TYZPR03MB7001.apcprd03.prod.outlook.com>
References: <20240729070102.3770318-1-jacobe.zang@wesion.com>
 <20240729070102.3770318-3-jacobe.zang@wesion.com>
 <1724f480-369d-4b4a-9384-1c6b33b00433@kernel.org>
In-Reply-To: <1724f480-369d-4b4a-9384-1c6b33b00433@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7001:EE_|SEZPR03MB6643:EE_
x-ms-office365-filtering-correlation-id: e12eb581-5a5c-4716-5c2b-08dcafa6d5c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?a/XRHHUJDSwC6nPD9BJLaT3BmjSn0sZ4ldZtTLkNq0Ux0TZdooXcPE5Mck?=
 =?iso-8859-1?Q?eb2JK881qpc2OzT/jAkQhZlQ10A7n7yV5H3yvg5AbqeHjBzoq0KN+tPISQ?=
 =?iso-8859-1?Q?8S0vnck1P9s+K+4r4pndzNe0C1gOHXm5k2mZ+FLRg1hv9i5K16l3H4iZlz?=
 =?iso-8859-1?Q?R2y+3Vsp4sEOjCw//zM/kxQNCJS46OqlhaARDV0AtHWa/dhrolkwr0kN/o?=
 =?iso-8859-1?Q?p1yoc7EpWEwmxGOucOTQS7stcfW3/RJxAe55lUsG/iuwZKRZjEKwiAno1f?=
 =?iso-8859-1?Q?WpLgjZeKrLPZI6xUlIJ120f8/dALFJ4AWIacb4Ya1UkzsDSlTYsiBS/8/h?=
 =?iso-8859-1?Q?E8LTQym1ApjsmPLVE85AXfXVFLIeR+65LB2YinP6eFU20Drlk5DY+MiGbO?=
 =?iso-8859-1?Q?jUpgfoaWGldKfAohfXkDhWp8eb7xEMdV5PPSOjbnB9/aubFXiOzySYuutQ?=
 =?iso-8859-1?Q?RDv/OsAE42PVmD+ntumA+QjL6xNaMLottXqq66NQAGv30R0dnVi3rey58e?=
 =?iso-8859-1?Q?DfQOFblJOQejJMGJ8oqdmFO0DZ7TjUO2vJToNNT+vU8sEM0xgSn9nU5/sJ?=
 =?iso-8859-1?Q?UOxR0gSLRnOoEXNbk8hT53Xp3l78ij2jJQuT3FSXAS0/WNtNpMnZmBrLRM?=
 =?iso-8859-1?Q?kp5KXTdkqdD49Mc0HO0dUd2qggCvzdoyQNVW+fUQuVN6N9w9RzNSTu96Mh?=
 =?iso-8859-1?Q?JSXxruLcmD4Qm+PP31x4v9XeFyQVmCg+IxnECX/gmPYZ2apw7y9NiBV8Zm?=
 =?iso-8859-1?Q?oe5fC2iGkiwxSWxkEln9guUaLVyVMvq5WS8W/zKx9vEqq/takuBK/uQsWZ?=
 =?iso-8859-1?Q?xvqa3gLQBYiffO3s/2Dk0JSliCl7tYpht4tNR5rh6zBS/JzETB/nw1aT7z?=
 =?iso-8859-1?Q?XY6osn3Wkm91tD+LJlxDxPChsRqfJB3ayT9w9Xsl8g7KLzlfSh3vxcmcME?=
 =?iso-8859-1?Q?1gTGcUl3Ylqma7K/jWQH9zDTNw0P6vSUAV9BXgahkl8dng114eUqjeTXs/?=
 =?iso-8859-1?Q?c5+IQZF5HrtcIqublF1LoFoVAVEWtrKFRDcTl2X7rNq66SoES+JFWe2Fo4?=
 =?iso-8859-1?Q?5ASMetqQXMFXTeQt8e4hPTheeaHS1bOjRLPvYw2dDsBnD6j+sSquxM3Rr1?=
 =?iso-8859-1?Q?Nx2j8lYA5FbV7YLMaoyImm2TL67oVJ9NdcYtD0iXCX4/RfdKFNrpcWFhQg?=
 =?iso-8859-1?Q?URZPVV9pjxiDxJLSkZ3XH96TYotatIPrp/C0febG0beTAeWEieP2g7Ke+P?=
 =?iso-8859-1?Q?Ws6yLLbLlGhz8mnXwdbhB8iczhgnBbRGOChxFB5yOEse2KYQDPoKgrzw8Z?=
 =?iso-8859-1?Q?r8sTbWGEQC5AbsMD9OaXqCjk6ZhKmuhdJkYz2rNEAO9+7lRwh3Dpaw3/GK?=
 =?iso-8859-1?Q?gkrykAYmPMLZKdZUrrJk5V2yxEEFW8XzduBTFf6WbVCLo6/ijg/8eZ/kcy?=
 =?iso-8859-1?Q?JgKEnA/kILI1InGNEzTzIPVLNXm7qCIg4D7BS13xX0QnMsQPuHAhExHQJl?=
 =?iso-8859-1?Q?s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?kPTgX2B0e88rBhUFzdFUMCKoiJDWI48Na9SEWWX977kDA2VlM3dGI9qHFB?=
 =?iso-8859-1?Q?dh+AFiqrj53l61aAy/zUqXSW3SzJbOrDNt1A/MgxtFjrmv9iemddDF728X?=
 =?iso-8859-1?Q?c8pI18GcE9Vx7p+wxtmD3yWW52ylNUX4YeMRp66cMafnT2ZJHBjWWKk8o3?=
 =?iso-8859-1?Q?oZ1+XAlveC6BcVPiUlPhnMC0HaqfcyvbqXLiK/HRFxWKt8oS/6WLH7GYNq?=
 =?iso-8859-1?Q?FRGSP84x+BFGnG9hEQxDjGU+RpEnWnbvsxU06K+NNJCSrW6XgvtZ6rWHTr?=
 =?iso-8859-1?Q?BpDS6pR0vvsvnw+5xeUVQfXeGMGfV5njOwwEoavbwVnyHyHvWTnlRzE2ck?=
 =?iso-8859-1?Q?z1CC+15sLD/NuBH4TrhiQbNjm3Y9SVmnJDm1y/Dz2YpV+cxIV3tlHDX9Y+?=
 =?iso-8859-1?Q?+HBBlbV0OQwlVEZutA1Ka5caKp9mLyk62DT1SWMCIYlzKD3uijbKL4XW1c?=
 =?iso-8859-1?Q?sbXhZDKJqij93IRI8MbW/Z3wfsVkjEy0rXBIM1d2eDSUL611/YKboubp09?=
 =?iso-8859-1?Q?KGVoy2IRSgc1JLFzkMCG8H8Ay7A04BXlB1FBPUmsHFZfS4EXOqog3YRfOu?=
 =?iso-8859-1?Q?qge1pzyKI12FuYL8qpMNOlPviYjiZr5uKzlDoPoldJmwSGQ06RE3QzbpCu?=
 =?iso-8859-1?Q?m4QwrOrQdsNq03LgKmrRjM0UKYbpob3iudYZ+H+/I7Bobla4FNWfDZll1R?=
 =?iso-8859-1?Q?yhXHDgYvTn9rfSl7w3cKHrxKrRsKG9WkJ+1vRXa3MPEQSRu/PlqCsSg/dj?=
 =?iso-8859-1?Q?tyUBjJwx8bNXtSchYG+uHzGwgMnpTaodwTwj3NEQrSr8TPkCDsiKnBKYYO?=
 =?iso-8859-1?Q?X3JZXPMaWZDx+5bLMtz6z3Z/+aICoJ29Qh769VQBtyZJtIdi3YowztDx6x?=
 =?iso-8859-1?Q?ByNEFtItdZxr3YWoC3sdzsn8rAQd+xfXhLRrkUoeqz40cZgnn/5TIrCi7T?=
 =?iso-8859-1?Q?z/+faeW3gvWVdsKgQY62Nb0Y5/rQ6h/W8WtBvDSUQ/rYQrtPoCMsGkag/4?=
 =?iso-8859-1?Q?sCba9lvN2M0DinkftNUgSn3Zxo4VnIxQU9qS05RgbSSSX8ovvRc7VfY/yB?=
 =?iso-8859-1?Q?d/qgVH5v/l/wtFfiXoavAXQxIGXjD7x+Gqx0Ld0hROCDXemTtBGXa8fUDr?=
 =?iso-8859-1?Q?WbhsZdCodh9TtJk1WzSjhZuxTt5i1p31pEjePSwni95GU0PiwuAwCOfLEt?=
 =?iso-8859-1?Q?EeEPaCkJnhyEdCXRNySN0vRdqLpj2an9cOi5UhI9QZFgGmOE5YP7FbXWzU?=
 =?iso-8859-1?Q?ExE1zEc6aJErUToroLbMf67x64Yaniz8buGi5WovzHvHssWbZmXv3B9l7U?=
 =?iso-8859-1?Q?rriiZJslIFOdxUHVqzrmpW4Os0SeiVoubYbZzCEkt4i/w7TiuspL2s6y7S?=
 =?iso-8859-1?Q?CSMBpJ1t3sdL3xpwqMzQ0zOctiBIf4VDKvMYeQyPpzJIEYIiV1TxktaVte?=
 =?iso-8859-1?Q?sgusRz9twpwB1i5uXnLswnNgaXXOWMpk/gXMuj7KrisWJwJjdHY3nO2pJ/?=
 =?iso-8859-1?Q?nMChPu0IdFwpYgYmXWnAOd1/WzvYER6WYgxKy7JZqPOqd1jzZRQZnWPq5A?=
 =?iso-8859-1?Q?6PnKWzsmpo6Q443msM+p9mbdBSu+EhAFdjAExbg5EQODlknNIPm/WVEClS?=
 =?iso-8859-1?Q?XFPkJtAdd/ca4wqrLExIybQSZ9qq9mzZFn?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e12eb581-5a5c-4716-5c2b-08dcafa6d5c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2024 08:17:06.5069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mRXV/ij/yAvclZK0DaqOG9slxJdsKB480syniJ4sJdJFStkER0ZlArCsdQRKnjmk6UGoNJLP++tYgqFE74/9Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6643

>> Add clocks and clock-names for brcm4329-fmac.=0A=
>=0A=
> Why? Which devices have it? If only your newest addon, then squash the=0A=
> patches and add appropriate allOf:if:then disallowing the clocks for=0A=
> others. Or maybe all of them have it? Why commit msg does not explain=0A=
> anything about the hardware?=0A=
=0A=
Alright... Becuase of the datasheet said hardware has one LPO clock input. =
So=0A=
I will add allOf:if:then for this specific hardware=0A=
=0A=
---=0A=
Best Regards=0A=
Jacobe=0A=

