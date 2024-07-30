Return-Path: <linux-wireless+bounces-10699-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 864D594239B
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 01:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7011F24082
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 23:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365A0193063;
	Tue, 30 Jul 2024 23:57:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2098.outbound.protection.outlook.com [40.107.215.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB95191F7A;
	Tue, 30 Jul 2024 23:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722383856; cv=fail; b=U1/1o6d9yMG4j/tegjarqn4TT8GqgcnCIeRYRrV1FNfdn73sU6L8Fy7JAUJ/y0AP36NtZm+fRERhzOxHXQdC6pwkqs68fmwxBOLrwE9blwry4SQnVM2i3aX2J72qfsCqdxhdBmgvIvU9OLR1fmLpMZNvRjOFLOhz0z+2XZ++WUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722383856; c=relaxed/simple;
	bh=cgnwg/Y3HfgxiTuwmubb/gTc1D2UXBQ7FfupFCnV4a8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VPm5+9Va+M8amCzSGiBYP0Cuurd1geaTlhROG2eduOOf69/w6ZXEkzS4VYj8d3HUFKu4bl+IQsk+HatMtTA5MHJhQ9xD9wevUlAcpfwg2/lINEbAnvkcIUUOclqaEH9agucpd1o9CRQqVB5vI6P8VDi7fhordQ0R2zg4l1m2egA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFGwP53jk/yskMBLzxAe8FIlIvxVm1FyPmBwDhoNcP81zOKA/FSkT8eed7ch+vFXLZFHjjfCGRKQ61tnpzLyCwHKUKF2F8iqItzZFrrGBb0AvPlAhbTfDvGYEWu1EZKMhdgov2vTzNColCbft6ER0fa4LFjVGany1hJHT2oubi7efPdAD3q1bKvhP5uUd1AQWw+Lc9ANca3OTRCKk5ZYt5knl2iny14cW84d/58djhNzwIKOMogOluql3T097CqlJfyKzxoSAcHtzINEWaaGVJLwcyijrWEN/Vtee3/JB2NppPu0M76j3Ogtu9CJ0L53n6CnAA9QOuRlQEIrfUk33Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgnwg/Y3HfgxiTuwmubb/gTc1D2UXBQ7FfupFCnV4a8=;
 b=FcbEgyKjNf3nTdxA0VPFx0GxIv3iqzEgGPm9jS05FKayPzS1UD92wfuZlr26a1zv5zTP9PMe6ntHka892LYtq8BAU2SrMnFSnmNSt6Dk9pF+ORw+NhyFL/wOczzJ77SRjQry9K5pqk0oi7R6CremZ00dZfGekZIozwUESD6Q5iyqYYwLjy9VDHa5Bo7WXlml2MSayndsF/9BnWp9rX1m9/juldgP0NjRsZoRrSbZsAme5hTutNlOZ5zoP0dPB/qimJQ4b7s6p3Kv5pkXnOc6tBf8NCYvCTMZP4gikQTX9O7BSIRtnBgsBwjCExHwjkxPaS8bLoHeOjPECX/BP4wrOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEZPR03MB7218.apcprd03.prod.outlook.com (2603:1096:101:e7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 23:57:28 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7828.016; Tue, 30 Jul 2024
 23:57:28 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>, "robh@kernel.org"
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
Subject: Re: [PATCH v5 4/5] wifi: brcmfmac: Add optional lpo clock enable
 support
Thread-Topic: [PATCH v5 4/5] wifi: brcmfmac: Add optional lpo clock enable
 support
Thread-Index: AQHa4jDyTCD7Ll9DxE6Duj0gEEYIJrIPnTUAgABWfT4=
Date: Tue, 30 Jul 2024 23:57:28 +0000
Message-ID:
 <TYZPR03MB70010073A25C8C3D67ED47DF80B02@TYZPR03MB7001.apcprd03.prod.outlook.com>
References: <20240730033053.4092132-1-jacobe.zang@wesion.com>
 <20240730033053.4092132-5-jacobe.zang@wesion.com>
 <35321e96-2cbf-47fa-bf0a-fe658f3751bb@broadcom.com>
In-Reply-To: <35321e96-2cbf-47fa-bf0a-fe658f3751bb@broadcom.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7001:EE_|SEZPR03MB7218:EE_
x-ms-office365-filtering-correlation-id: f9e3a6c8-700c-4df0-d09b-08dcb0f35e02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?cnFq3PmMeNjKhjwPApNnFPcjDm3aVfUXj9Q9ce2qISKMcv4TJwEFbGC6Lp?=
 =?iso-8859-1?Q?XxXHLAr4IAxs+AjCKlwfgJ09KMqniM+47uxgcqxCfp2BAdVwibrjA8eXw+?=
 =?iso-8859-1?Q?b1b4sgQ8erc8wtpFqfaSH9zbMISAyB1JJakMfFKK3eK9wZHjGwI1noeGtu?=
 =?iso-8859-1?Q?+fOXjj6lbw8IwKzQVp5syk9LtN7EqJoNoIcumslpgjnAuAJJE2OrMnPZwQ?=
 =?iso-8859-1?Q?+UnqCTtTQhxceVhz1lEynOdnFbWPxF0c+LEgwVSgdh9Cblrdw7uB21P/Eb?=
 =?iso-8859-1?Q?akdeNLMupgdqdRtNp1PIMalqHbjvlPkXRi5b2yfuoBESOmp11KkOeBrRhp?=
 =?iso-8859-1?Q?vepcA+HtF+MQsABhrfExCBA3kzYBSv8hDgpYswqtC50TIb2xYkejT78kTC?=
 =?iso-8859-1?Q?rP/uzhE5C6OJHTiAwk+Si9tNGw5aXwhB/AuxhreQmhLLZoJM49B7BHM/8D?=
 =?iso-8859-1?Q?Bf6Q9YeDqjVsVxB9mXvq/Pm8vI6vMb++qK0x9CtPOvL6t/HmYOW9edVE97?=
 =?iso-8859-1?Q?hmcyIEVNrrTgtdGSm2J8pof9vc5bDtOYLt7OabF3nPT2ouPgu5Q9Dqg6ki?=
 =?iso-8859-1?Q?Yum/LbtY5qdcLjVRIck5zaadLx7dcz9jlzMwbhgL2MKrmGl/VjkD8892XP?=
 =?iso-8859-1?Q?tEx5MyWpgMUtcvpbi/Dj2sLfVSKuWWY267xyKHGYiavwlo5TtjZH7JTVnd?=
 =?iso-8859-1?Q?0vVWknqwnBPtLMqkcwQxkXvH0uguPmUBqhLgTn1GZ11LeDXbyQa91oSe7q?=
 =?iso-8859-1?Q?1plwq/GHoshJK6X/ONuRCJKVD8vTS+UpXgsap45lN0UZ8X5va2ofKtqZE1?=
 =?iso-8859-1?Q?X3rSDnBhlhcXsg55PX5+hONQ07BMqxbL5dMjQMlZXTKWyXa0j41VaQlHi/?=
 =?iso-8859-1?Q?8awo5nzSLGAf/11KOLyEVz83284yAHmxYfrqakMxFMpcr/43Gs+J5y9jpx?=
 =?iso-8859-1?Q?c+uZVlciL+5xsw6pqL+0865zWCteaCAavAeIMeFHFsPjIae3MRqzwFo04t?=
 =?iso-8859-1?Q?wLacnyJ7MReVCfqfIbR+C4KJfF2mgzNB5WAdeUXO6JSWABMYsoheFoQIQm?=
 =?iso-8859-1?Q?U53MfijjyAVLWEtk/nORkWCA0rf7TJ/Cznc154NKilTdL7hdHG3hO0PyPP?=
 =?iso-8859-1?Q?CJmhCyRADbITvFQSSgf6LfJTxa+6YhGS3xPPyvNyp8xyXgkVNgBOYJRrEr?=
 =?iso-8859-1?Q?1z3C7Nofw8UOm2jJHZGjq4HlRkDAaPRwmMVM9+MMNai2W4XdgWNwP2iS91?=
 =?iso-8859-1?Q?lycffPJGHV/hWZbjaKs5Hj0VFL/5v0eZN+UIuQbT8PTt8fpVjpKgxqpPbm?=
 =?iso-8859-1?Q?lU4zp5lfUzRGMXUkbS+ik4menJ8rIbsgYI5j54meE896NR4tNgYSlALDHH?=
 =?iso-8859-1?Q?KC9LNhoD0UZp5H/ioVmD1r0LrW+GLlL95oXY41eVnTVZzn9wK/rpXlNCIT?=
 =?iso-8859-1?Q?gWP7twD2fw+vb/o+Js9woYjPyW9g55lHaJ/Iaxwn5Gbb1DC5TU6/8xiO1I?=
 =?iso-8859-1?Q?I=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?qxgYLLlTWm7T/h6V8Lnp/Ja6O8LaCeyrcyMwT7sXHm8HVe0yUbA60+oaY8?=
 =?iso-8859-1?Q?hGc51YRiVHM0qTV0ChTpOhDaqG/NJ7kHQ0U6/wZa0md8JTmHg8t1WDbib/?=
 =?iso-8859-1?Q?2BG59QXLuke5rHioD4qD0WzUQVuGXYtaqK6Dpdnpy74HKUT+ciDm8ja9sH?=
 =?iso-8859-1?Q?9adisS8zyYKxYkRTD+dtEwzLTZVJvvAhY7yzRPu3ECLDeuO8WnRpVwNw46?=
 =?iso-8859-1?Q?AN+q7mZdSWqkbkrRY4hhHjMu8cOYf/GiUN/jsQNf1KGIxLUXAfQykJwGuK?=
 =?iso-8859-1?Q?wiigVEDkSK1GVnWT3F9Siif1OfwPF2zcyqN7tCcyTs6Bxa4XhnIPcLtp5A?=
 =?iso-8859-1?Q?b5kdLftBjPgp8aMKKbARhZjp3fHZYyRmB3dWVZOR6mhiuy/Ax9cDZ3nZFg?=
 =?iso-8859-1?Q?2CgN2IiBAkJySewYga/KdBdEd2eyTvJMCg6U8mZtAS6OeXLYzr9fbdZq3E?=
 =?iso-8859-1?Q?ya10l5degEKFDx35teA3OstAm2hMLyMR6qPBAj7DzhrGSEv0OAaadDVUg8?=
 =?iso-8859-1?Q?wA3bwzg5dK3FH/RndwyANZd/3vxZmyxeBFUtiUPJIfFeZYbLLAaDxsUqmq?=
 =?iso-8859-1?Q?g04bxnE3YCGWnq+EkTPxwh8o4yA+4LNm5k0DpY306TmBJ9BiZkHa9GSqGc?=
 =?iso-8859-1?Q?/Ya+oanBHurlENg49Ui+9FFeODTj/8Nu68KTjtywtyMYQvU523kpwgoKxE?=
 =?iso-8859-1?Q?fi2aBv3qFRJKfzDrULcbjcyzQ9NA6gO8fqNl8Zci+92DPYD124lWrqIZvy?=
 =?iso-8859-1?Q?J1iTDA9XBBAy+EgMUPr9IeqHXuGcMT1JzUAT/bFg5IEETIXbB8sMCeg3c1?=
 =?iso-8859-1?Q?jhHj/8D4qnLU1DAOZiEHeebxY+2g/PtWkI8cG+BalnpoaR3D0hn6/8YVdf?=
 =?iso-8859-1?Q?u9A0V84u58oCSp8SSIO6BfxueKQoCLMFY8wYF+A4nccjCkT1otLnu1asmQ?=
 =?iso-8859-1?Q?T6O2wC6Q+98+IwS/6s9Gy5d2jlJd4BOoe/m37IGOLYzpfl7u5kjp1HL5JY?=
 =?iso-8859-1?Q?7UcuGnoEFCRu8psIRv0cMyX3acWciPe5KoY1kDXGn4X36hQE47vfENgBAX?=
 =?iso-8859-1?Q?8ca4x9MZ7f6CPsTBtYCSeg7Jg8HOyMaHeyeDlAAFhYc7soNxUnPK1FHQHW?=
 =?iso-8859-1?Q?fDqkVUJtthTQS/rEy7uBY8WWpCOEHJ2AhOdDGYs9wZUPWsulV+sesqfT9J?=
 =?iso-8859-1?Q?K38d+WJv68Dg/ydTK7m9W9aHvigGrjB0v1+8zD72UWIMEg/jpkByaCr9hV?=
 =?iso-8859-1?Q?ws5cqAfGXZOGg3QwMza5QBjLRon+p8O/tMVw1vOEw/vOPoSTL8onP9/eAd?=
 =?iso-8859-1?Q?F57Zwue8HhZhWkFNBYro+Hk7Lk21NdQ1CAO7ROD0mbhhsB0YvohoQ6NW4Z?=
 =?iso-8859-1?Q?rPbfjC210WW7vAZJ1NuCn5OikWTM6bhyWEX9Ga6uZeWPaS87b6jAWc5f/E?=
 =?iso-8859-1?Q?/6knQ5JiU3UHthunCLwgc97iEHL0D1AMT2OHIw6noZgkfR2MoLvjMAusaF?=
 =?iso-8859-1?Q?bUjkC2Mm7f6USANTO6lQAC5Wb32w2pICE3rq9qzQDzdrYZwuFLIo1T5BRW?=
 =?iso-8859-1?Q?PumjkM5m0RUGF6eJjSmEoaflZQ8/C0vbXvhBU54410zR6H2e6eV2nqF02K?=
 =?iso-8859-1?Q?WxzaUb2qBbt5670zGfHEHyxdHxscGAz8Af?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e3a6c8-700c-4df0-d09b-08dcb0f35e02
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 23:57:28.0312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2r/xpLIGpR2wcNR47UlMYAhQVqXELfRYvWkx43/wSC5qKfTlHY72IScLeO+odG3h8vj+2sAs1De95gtanC4Icg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7218

>> WiFi modules often require 32kHz clock to function. Add support to=0A=
>> enable the clock to PCIe driver.=0A=
>>=0A=
>> Co-developed-by: Ondrej Jirman <megi@xff.cz>=0A=
>> Signed-off-by: Ondrej Jirman <megi@xff.cz>=0A=
>> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>=0A=
>> ---=0A=
>>=A0=A0 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c | 8 ++++++++=
=0A=
>>=A0=A0 1 file changed, 8 insertions(+)=0A=
>>=0A=
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/dri=
vers/net/wireless/broadcom/brcm80211/brcmfmac/of.c=0A=
>> index e406e11481a62..6246e3fd7399f 100644=0A=
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c=0A=
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c=0A=
>> @@ -6,6 +6,7 @@=0A=
>>=A0=A0 #include <linux/of.h>=0A=
>>=A0=A0 #include <linux/of_irq.h>=0A=
>>=A0=A0 #include <linux/of_net.h>=0A=
>> +#include <linux/clk.h>=0A=
>>=A0=A0=0A=
>>=A0=A0 #include <defs.h>=0A=
>>=A0=A0 #include "debug.h"=0A=
>> @@ -70,6 +71,7 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus=
_type bus_type,=0A=
>>=A0=A0 {=0A=
>>=A0=A0=A0=A0=A0=A0=A0 struct brcmfmac_sdio_pd *sdio =3D &settings->bus.sd=
io;=0A=
>>=A0=A0=A0=A0=A0=A0=A0 struct device_node *root, *np =3D dev->of_node;=0A=
>> +=A0=A0=A0=A0 struct clk *clk;=0A=
>>=A0=A0=A0=A0=A0=A0=A0 const char *prop;=0A=
>>=A0=A0=A0=A0=A0=A0=A0 int irq;=0A=
>>=A0=A0=A0=A0=A0=A0=A0 int err;=0A=
>> @@ -113,6 +115,12 @@ void brcmf_of_probe(struct device *dev, enum brcmf_=
bus_type bus_type,=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 of_node_put(root);=0A=
>>=A0=A0=A0=A0=A0=A0=A0 }=0A=
>>=A0=A0=0A=
>> +=A0=A0=A0=A0 clk =3D devm_clk_get_optional_enabled(dev, "lpo");=0A=
>> +=A0=A0=A0=A0 if (!IS_ERR_OR_NULL(clk)) {=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 brcmf_dbg(INFO, "enabling 32kHz cl=
ock\n");=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 clk_set_rate(clk, 32768);=0A=
>> +=A0=A0=A0=A0 }=0A=
>> +=0A=
>>=A0=A0=A0=A0=A0=A0=A0 if (!np || !of_device_is_compatible(np, "brcm,bcm43=
29-fmac"))=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;=0A=
>=0A=
> This if-statement should be the first check in brcmf_of_probe(). Can you=
=0A=
> include that change in your patch.=0A=
=0A=
Sure. I will change it ;-)=0A=
=0A=
=0A=
---=0A=
Best Regards=0A=
Jacobe=

