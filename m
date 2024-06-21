Return-Path: <linux-wireless+bounces-9343-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F364911825
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 03:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D57D91F21C76
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 01:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F44742052;
	Fri, 21 Jun 2024 01:45:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2134.outbound.protection.outlook.com [40.107.215.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3B11EB21;
	Fri, 21 Jun 2024 01:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718934354; cv=fail; b=fxD6ziiT2cmyjx6PU+OdUKZj3wKHanaqXo8oklj13SK/4w0nhydCF80+MWqD1hxkLD1nLekumxUuz1RwPw2XWSLCLwcoXHOgRA7hzS/h+NVr3+OYqSaLGOhgJi8fZVqyR+LTyvKd1lHThzWVyX55wd0719y1EoHfq/AHtAfxSkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718934354; c=relaxed/simple;
	bh=U0HCpQ5fl/zsxmM2DMVIujQyCGg2fClY1VpRXdtIRMA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sf0sQEVDoaS7l+kBORq44pl7QnPgKdz+VpckSi0+AxR9exlxzS2wSfMLDZJ1bv04xWM1YYxMbZcLaj521Jh8mAvYUm35Ol8kh9Lu0/VPKQfZ7BYHAq9i5jOeq3NQh6drq4643+8Ez7C/wCYkz5xZoQsRWoxLAsUSI4P3yjCTMPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4jn6nfumi/DahEEoOygJuWCyaFB0kYahImWwXlpzw/qz4/6HAV+4+dpknrW+mcYr1G5ryeWk0kcBMH/LrCvwlnpREuzan//Eb1CchqNEmpaDm5UlSP3cmme6bfFqr80WMxvIr4GO4MAgCgSzRmEvMrDnvMIh9TJSpprO7JubzA0AnlE48zuFslDtJ+mfGMRnxtESSSGB91u2a3RmXuWQmgpK49wruiCqeH7P0Jb1w+AyK/QgWZh84Dvc/dv/he485YXhnYFCK2CVEW7ITdZ0KeKEIU/rNvOTXjL0lpnqeYdxgtQMMdcueST4BPkB/vmmR+O89Jvu3q0ufoGIXXAcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTCSRcixkFjUTnK1I6FVaeo3hpyvWFq+T7EltLO1v6Y=;
 b=DYUeFAYNX2Y6/VtzdmBmwqKoBUZqK9rXTfKkBn76J6+L0G0t9LHIHNFPj4c9UsPheRFISUetV3QZtJ0PORPjdXdKl4HksUx7R9JTbBlaVE892jEYXHztikuhRHoPqIk57GSmvXMBcOzmsgGAXXsZ8FFgKrr9apIKJocRbnGslcUQ6jNxhqS6AXp9X2q+BFoLYjccncDYK2JodRGnOevscgKXtbb1q+XkcX9lVv9w1HecbxTrlo552KCdC/oc5fdbY4VnQVKNa7VuR6Gx992m8RG5OLZQ6dRHrDL9G4Ooy6a8MsRVAq+iD1dfbvZ8H1mNGX37rDO6TUOUh47ifAWGqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SI2PR03MB6662.apcprd03.prod.outlook.com (2603:1096:4:1e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Fri, 21 Jun
 2024 01:45:49 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7677.029; Fri, 21 Jun 2024
 01:45:48 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "arend.vanspriel@broadcom.com"
	<arend.vanspriel@broadcom.com>
CC: "kvalo@kernel.org" <kvalo@kernel.org>, "duoming@zju.edu.cn"
	<duoming@zju.edu.cn>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"minipli@grsecurity.net" <minipli@grsecurity.net>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"brcm80211@lists.linux.dev" <brcm80211@lists.linux.dev>,
	"brcm80211-dev-list.pdl@broadcom.com" <brcm80211-dev-list.pdl@broadcom.com>,
	"megi@xff.cz" <megi@xff.cz>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "heiko@sntech.de" <heiko@sntech.de>, Nick Xie
	<nick@khadas.com>, "efectn@protonmail.com" <efectn@protonmail.com>,
	"jagan@edgeble.ai" <jagan@edgeble.ai>, "dsimic@manjaro.org"
	<dsimic@manjaro.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] net: wireless: brcmfmac: Add optional 32k clock
 enable support
Thread-Topic: [PATCH v1 2/3] net: wireless: brcmfmac: Add optional 32k clock
 enable support
Thread-Index: AQHawrWiuAGxh4zirkWecOsl4aArsrHQN+OAgAE7PgY=
Date: Fri, 21 Jun 2024 01:45:48 +0000
Message-ID:
 <TYZPR03MB700143E13635364FF5A316D080C92@TYZPR03MB7001.apcprd03.prod.outlook.com>
References: <20240620020015.4021696-1-jacobe.zang@wesion.com>
 <20240620020015.4021696-3-jacobe.zang@wesion.com>
 <b8b89ef7-2e92-4e1a-9609-6b0fd6d64d7e@kernel.org>
In-Reply-To: <b8b89ef7-2e92-4e1a-9609-6b0fd6d64d7e@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7001:EE_|SI2PR03MB6662:EE_
x-ms-office365-filtering-correlation-id: 11130005-2731-4562-3078-08dc9193e047
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|376011|7416011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?XAuUO6QHPt3ZPzDQRu+34zRTlFifAce1hdVvoRVJnQ3S4hzybtEg8lN0U5?=
 =?iso-8859-1?Q?w9PcKaQYiN7OU6I7V+LnG3tCmzdGqUaZxQzcLBmCSAyYT/GmqqayeZzsRk?=
 =?iso-8859-1?Q?euzkglK4IG4x3NHGkF2QWkg3cf56Urxt41Kg0gc8FJnbjWAA4qYL23tsyZ?=
 =?iso-8859-1?Q?onytZ7RJ6182UnKPQ+EbEVGSzHNMK4BzZFw+ORrW3D6Qn110POyOeiLvPj?=
 =?iso-8859-1?Q?VIUO0r0YVyQsTd5CnPbKinoOoqrFgZpidSKVIObPVAUAHgZvkPo9MWviSP?=
 =?iso-8859-1?Q?MDtjWEXPXppqO9YE6aZH7p55iVDuAuYAW9jwvDHlQ4YDAP6/ga0DVSi03Z?=
 =?iso-8859-1?Q?SdpM4ix9nJpD08Ql6VeRnQ4P0lfb7B5QspyvHjRNyTKDLaSXG4Q/yf6R7G?=
 =?iso-8859-1?Q?Qs5vxr2mNTVzXT0Xr9GZJ6b2l0QTfL3AFCgskKHCyp6FFRyYDaF8TwVpdZ?=
 =?iso-8859-1?Q?Y9kRKf2VaHexexqtjLggrhEP1XzAYrOYRsBkX7h6EIXTt+sj+UsjXa5XvH?=
 =?iso-8859-1?Q?bhbeTTaoijpKGhDvZ5dbytDPI+IpJS/vN5g7Zf6PnFJkvdAvIdYXZdyi7+?=
 =?iso-8859-1?Q?4uRy3eB5qI0RfOwEGQtvQc0Hr1IgXoC2lIQl+RJrVFj3Mb6BOxmYou91pP?=
 =?iso-8859-1?Q?nKm5bOcElwGbgXI4iBJEZUleWX5cNnO8mfBuYYTO3vQD2sHvXsVqwvR1ba?=
 =?iso-8859-1?Q?lgWev+b5KXFC0yuyZZy9Mp0wvqSWcdhWZrexfSlYDDj7XPZIxKt+H9HOmR?=
 =?iso-8859-1?Q?rIwwfXcCKhFOPEefD5vftz8GZoqCk+IYfRhEEQTChmeC5ZcZYYBboI4Cgj?=
 =?iso-8859-1?Q?Lx+dE+xIry2H6e2lbNIMHhPKvE2eBrEikFe54f76oD+4O3gsZ0DVx3FTA3?=
 =?iso-8859-1?Q?V5Z3D9OVu9PtM+4XUzOb+dn3w98ITpQPhcBaA4NirUImGxemKhU5jxDwKF?=
 =?iso-8859-1?Q?0g6k582Wd1ekBhhfdphw7SeCPcs+qw2kCUqQ06Ev+xmJG/yBdL6VYGo03Y?=
 =?iso-8859-1?Q?24HrY6GYlJ20wk80o3fJJfuwPoHn0Pn5R0LXoI5K3sy5oLVhI7j2+uZW0K?=
 =?iso-8859-1?Q?IbiXwF9BajloQoqfYLCEADx7V+NqXjOBLGfu5Hnw4a8aPp6J3LoaU3+MG7?=
 =?iso-8859-1?Q?2QtaWku2NpH93pGlHA1OOIlLdOBk03QNWQstKb+QiGtxSBscsTwAY+OMqQ?=
 =?iso-8859-1?Q?+Ue4HPMHQMH3R9wnDx45sELr/02rECyVHLBBO6WPI4wOZe9J4OKnrYSMjh?=
 =?iso-8859-1?Q?gfiE6mmlnF/RtpqylfazhEkITTB0vA6a4uwEAT11v1VFrOLvjyLLO1mblh?=
 =?iso-8859-1?Q?prP50kMAINH3o48CCRZScfT4E44cRckRO4HificoX3fYZexxEWhytvFJle?=
 =?iso-8859-1?Q?nfLrsaEfS0k2iCpCrrBcUQTqzEDSFOhSPSa0CvaJLLkIYQ/CdKqCQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?eClrKzsif2J8lNTvrd3M5EcDJ8yLTM9scE+Aa6rgL1AZiHD5scILAbiSdV?=
 =?iso-8859-1?Q?0nKGst3v3HJ7NrK8eC78R0YbAyY0+AMAtjHSPjnHxbIPZozbLwEHPoC7sy?=
 =?iso-8859-1?Q?j9+i8bO4BZ3JdJ3d3bai2yKBRDZ07c2Mn641RRHaqc/45PIP8FBA1zGlvh?=
 =?iso-8859-1?Q?D0YDYNbDl5Os3BM3yhmp1dQ64whDk0dqDvfgfXE43Kr9aRxlrqL4fTDT99?=
 =?iso-8859-1?Q?uphW/NgI9GLzLYKCGl1jfXt9VnALDpnm4Qu/3U+imm6Ga4mm/+HLGmVBa/?=
 =?iso-8859-1?Q?Q4Go4nF7LV1WYFM/SPJaorAUUHMSlvUwmDojYyaOGkBjBJUTsNTXLO2EnF?=
 =?iso-8859-1?Q?/TO0/L6dp97U35VZcwwZFDUapp9PZZIt3uwhAg/NhDlhahqwJvb+cqyEz2?=
 =?iso-8859-1?Q?2s61wDcio/BoX6N7zH+6NK2+Gc/JPJjMaNPHF3meAh/CZ/vaa1ZfU6dPbA?=
 =?iso-8859-1?Q?xES2D/91TSgPQpCyRIeTu9KZBa7z82gfk9UbUQEbT5ygPCnNs13EL/+kDJ?=
 =?iso-8859-1?Q?MCOHxcQNreydKXnZ8JvFeKCLqKQ62aAWFrKV24B9QN3yGqhZlEKDK30xj/?=
 =?iso-8859-1?Q?XLb5cGy7HW/a3xWnlcu8kqpmangjtqpkUf0ARNmvyyQaneqbXykTubKMS7?=
 =?iso-8859-1?Q?yCHLrZzIc7fJEpJAalTzWfRzX4ROeKipm11umfRnG1XDwJ0NtuMNuwTmex?=
 =?iso-8859-1?Q?/F/fDxv5eqrODjzQdLaylO1tOmpPs2X43I1eVWvoaUMqXv+0GXyfyQBBVL?=
 =?iso-8859-1?Q?pBZv/EOn9M35Vk4wzJbSue18wtlPxuO//LFLce0dc92sJk9gky2b+I4mNl?=
 =?iso-8859-1?Q?JkDw4vK5KePUN0PYljt2/RXTQGONi+SkGTYisnZ8h2k3dv7GiMSY1x0Obo?=
 =?iso-8859-1?Q?rWUIpCMDmAgm77wBvwLyycCqk1gDXz9IfpyO/B4fQ4a1gBfmDw3ahC/3wj?=
 =?iso-8859-1?Q?WK+RtuLQkIBsq+77K2Bd7YozzyPEraVwjI1w36dMOCg3FWYEQqHwS/Prbx?=
 =?iso-8859-1?Q?Fd9JKuLEMCzlHbmZhhQhEMd5aeFVf+2uqPe+hj1QrntGAeIEi7KyDQ+C2U?=
 =?iso-8859-1?Q?xMLqfTmuUCsQjGjXG4BjMXhmVxRH7GBLOlHsIi8jCJT1Ji/5t/+jTikgfH?=
 =?iso-8859-1?Q?Z9WSalFUWDiAaKAbnr/R46yqI5TxqEFiUnQPM9wHVe/J9Ed8RQQgWU3BNM?=
 =?iso-8859-1?Q?rVbfs5DZ0Dm6e4w9fvRUYZEAoUeUE7M0+Feb8eA3/QyYx5AhNbsBLdXOxO?=
 =?iso-8859-1?Q?22xVHN6nI/+PykS1EnVmvaZtRiH8mhf2Xj3hb+T9BryJxTd2JjNyNVGhuJ?=
 =?iso-8859-1?Q?2QwkPTjrFX69rj7ZiZz4JKdnY6rIIr5L659BMlRKsVQBO42ajGu78W67Fw?=
 =?iso-8859-1?Q?oKVVI8Gskkjz+FgkYoWnBg4Hzaw1ntGWw742tuIptsXQ/ZlSPCyfIeKLqy?=
 =?iso-8859-1?Q?Ie0S2WMdSGIaRiD6Lf1F5OPKSNI7hAjM0tcipN+A3xP3WDxxkweW6OpGgQ?=
 =?iso-8859-1?Q?OhQIAYY8vISI529rib2N19XSDR9CTbqwagj/8GuU4D0XWIW8PXE7i4hcJR?=
 =?iso-8859-1?Q?NSh82nyb83lXbYI9msG/UljjNtGHM0j8H5dTkfSr4znrntrcBsL91Nax5R?=
 =?iso-8859-1?Q?bBnL15gtPLwd/U5Bx4q/h+em8JkPmSdUal?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 11130005-2731-4562-3078-08dc9193e047
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 01:45:48.8339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Dlbd2EE3XQw1BDnVc+sRM7Oht3DUBEajsHGovpRSQH5QWoECTvCT7IWMyITi69wo+GYw2PH2Qf9uWjnwr3XvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6662

Hello,=0A=
=0A=
> Where is the binding for this?=0A=
I seperate the binding in this patch " [PATCH v1 1/3] arm64: dts: rockchip:=
 Add AP6275P wireless support to Khadas Edge 2 ", the specific code is =0A=
+                       clocks =3D <&hym8563>;=0A=
+                       clock-names =3D "32k";=0A=
=0A=
Should I combine these two patch to one?=0A=
=0A=
---=0A=
Best Regards=0A=
Jacobe=0A=

