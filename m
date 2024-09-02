Return-Path: <linux-wireless+bounces-12352-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36796969075
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 01:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E065D2828AB
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 23:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FB417D377;
	Mon,  2 Sep 2024 23:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="dYy2XF1l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11022101.outbound.protection.outlook.com [52.101.66.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A2736D;
	Mon,  2 Sep 2024 23:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725320289; cv=fail; b=ST+cLepG2O3DS2LGoIXuFr4rHLclfv25jDBsv3n5BHr7etYrJbd6ribS1lSnyH8D7UrR2NXWICvtmeI+odpIt4Xp90rlId2zFctnbQaL53CwfY5s0g72lzoUpmm6hnMi0EFF6dnuS9AlPiivwSdbkdQtXIR7+a8FSvIlNrIsgU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725320289; c=relaxed/simple;
	bh=Ha+Saand3x3mwOb/H2y7C2xRFGfltdueDJKa7XT30Ec=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DhfN91vPcW2SgRFdQPeZ/PyIG2v3DcW4RuehmMeUowtNnfMQhiLlVBGPOYff0XK0mZjdjTgC0GbQDVy5Uj0WthPMsHVx9SQo3jBmHtNY3pYceOnSo5zBJP+OkYVCTT7nv0cx6UZquUN9wN4T3+lvkaVikPEpsOtsG8KngqEuIl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk; spf=pass smtp.mailfrom=bang-olufsen.dk; dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b=dYy2XF1l; arc=fail smtp.client-ip=52.101.66.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bSdtC/tV/43U83VHeFUBtDpLY6JCj809eSXzHEHyCoZwCu7YHkagenPLfh8uYfzET9fw1VXCoRjYd8uzlRm5SBnhDvCCqKpE1r00/nbH0qB/VAB5ZHgXFEkjogTG8dE+FMXRZeLRf9zrq6aB22e04hXqqz0lRzLW/UWJhzNnL/D0M49Yac6SkKtRRQnTB82MhiblVxppAU5XfqQQ43z9d5w4gPxt4hWvW1ItwkQu8OdeYnJ83lAM7SR9SCynSQok1hotslEFTpewGdybJL+3JdH4dAzw/LUgog0nuIOzaqIgFKRkxHtXubav/QJWIhChSlRJuAN+fqp/+VBh22AQ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ha+Saand3x3mwOb/H2y7C2xRFGfltdueDJKa7XT30Ec=;
 b=Vern2wlbE3ykEJrjXyGGMKc4WQ4wM4wopwQLZg53A/l9t7x+hSUyhC9xB42du+mgYhKu1P+byZzcmrcfEFc69qpxKqbmAPx+wU1rEURX/YIfdpr9U9oKosNW8MoCSWG234ffDmxio/ALV5zUz1JgJyADKdW3biYHV/qHqO6JEGqmRqglrAEl+flD2A7ZKGZGIzw/w2rZpYeacZSkqF7yaFYwWsLRENrwSW2k4I11Yi/TCwIYmAUkpSUhialn1v1K+CEh7ZJd8a7EZtc2B0Qs1bV8H0CW7R6tF5WyxbCtUhst0clnKG3Q5muIIdvGmQRJ6igRA9Umfu2eVhEf40tdhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ha+Saand3x3mwOb/H2y7C2xRFGfltdueDJKa7XT30Ec=;
 b=dYy2XF1ly/+ArGusMHEF93jod8T15t0HYXYyAgAAEyWOZdy1aWHm0tFjrVB+u9NrP7LEh8fA+jyc827ZEveyzRqigaryVHDry4BxNGACWsQuvFjtFCx3pMnv0xVzvW/fC/9Zfbt/TXYBFhwJ4aJ26zIWuWMOonEoWIV+A/p4+a8=
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com (2603:10a6:20b:53e::20)
 by AS4PR03MB8700.eurprd03.prod.outlook.com (2603:10a6:20b:58f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 2 Sep
 2024 23:38:04 +0000
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::6ac3:b09a:9885:d014]) by AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::6ac3:b09a:9885:d014%6]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 23:38:03 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
CC: "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "linus.walleij@linaro.org"
	<linus.walleij@linaro.org>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"nico@fluxnic.net" <nico@fluxnic.net>, "arend.vanspriel@broadcom.com"
	<arend.vanspriel@broadcom.com>, "kvalo@kernel.org" <kvalo@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "saravanak@google.com"
	<saravanak@google.com>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "brcm80211@lists.linux.dev"
	<brcm80211@lists.linux.dev>, "brcm80211-dev-list.pdl@broadcom.com"
	<brcm80211-dev-list.pdl@broadcom.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 2/7] net: dsa: realtek: rtl8365mb: Make use of
 irq_get_trigger_type()
Thread-Topic: [PATCH v1 2/7] net: dsa: realtek: rtl8365mb: Make use of
 irq_get_trigger_type()
Thread-Index: AQHa/YtAPn4svpPvbkmmcCgkItl7ebJFJzeA
Date: Mon, 2 Sep 2024 23:38:03 +0000
Message-ID: <7q2t5qolpvdsyqxpygpfk2gnoe2qqi3a2t6oapo5oydapqml7q@touxbad2royc>
References: <20240902225534.130383-1-vassilisamir@gmail.com>
 <20240902225534.130383-3-vassilisamir@gmail.com>
In-Reply-To: <20240902225534.130383-3-vassilisamir@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB8805:EE_|AS4PR03MB8700:EE_
x-ms-office365-filtering-correlation-id: 66965d04-b0d9-4a99-f714-08dccba84a2a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QmJob0pSV1dPTDZtNlJaQU5RRHM2N0ZHWi9pNExqOFNVVjJEZ0NUWmFKRXdQ?=
 =?utf-8?B?OGQ3dXZUNmR4UFFObSt1VkVCeVN5ZzFQNHUwUmFlUkliaW9qVmtmK2VOeWNM?=
 =?utf-8?B?R2xaZ2hTWFFRYlZJSVlYQWluQmFZdnhXc2FyTTJUSXNmSUo2TGU1ZWtRZjZS?=
 =?utf-8?B?NE1BTHZ0Z0ZpZDM1QWsydXJsRlBDd2R0WG1aS2wySnloRHRhbnRvdWsxOGlq?=
 =?utf-8?B?Vm0zWG9UUU5abmJkUXl6OFFJK0tkYTc3Skt2Yit4NS94blZ2ZExucXhCMTlV?=
 =?utf-8?B?NFpNYjM5SVZYdysyeXZYd09Kc1N3TDN5QUlkMTU1NWw0VGxmcEplc2lISm54?=
 =?utf-8?B?SFB5VWpBVGxST1pvSUdQNCtXdGNNaXBhRnZNRlE0cWo2M2N2NVdEa0Vkck4x?=
 =?utf-8?B?NGtQUVZkM09kdVNlRGZjSHVUYWJRanlmWDFQb3NRRHM5d3VGWHJWdUs2dXda?=
 =?utf-8?B?U3UxTEprOU1sbC9ITmQvSytZejZQcncvYzNoejN1RU9uN0thTHJzZDRWVmFs?=
 =?utf-8?B?dEgxN1VNazlSTEd5dVJJOFJ2S0liVWZzOHBtVEt3UGtrUThZSGIzTDN4RU4z?=
 =?utf-8?B?MmxsbEJpV3VNUHJKckxnVVlGY1haU3MvSUNBeE9wREFpTS9VUE1nUDRtcWFo?=
 =?utf-8?B?YnV6RXkvMUVkTTNxR1NGa1d3amFoaDdoM000NVRnaDhrbTFpVjJPNFhadWpM?=
 =?utf-8?B?WTJJdVFudXpVdkh0Rzl6M3VTWncxOFZ3TUJHSnNrM0gxZTY1KzFjeTVsQmpa?=
 =?utf-8?B?aVJaRWpVMkgraWJFa2tTdkJOUVBHNHUrN0g3VzAxTStDelpaMmpoeDRKZ21h?=
 =?utf-8?B?NGNjZHpUVmw1bzRzRmhJd0NaZkZHL0xVRUpwWGxrNnQ1cjhtK1BtaGVVRjJQ?=
 =?utf-8?B?ZjBYZTVMTnZONGJ1dTdVa2NZalBpb0NONnNaNVdZekRpSHpJaXdKVmYwbEZ6?=
 =?utf-8?B?amcxdk5kb2FkNVgyZlFRejI4d1BjY040WGVLYU9YNUg1K2tzcmdwckVXWE5z?=
 =?utf-8?B?cjBWTENrNWVrcnpVK1VrYWRwT3J4enVqZHdBVEgrMHpmUThqd3hxTHNBM3Zk?=
 =?utf-8?B?VmZhZUtTZkY4dE9qQ0c3ZXR3QjlwcGZ3c2hMaXc5aEgwQk4zWXpTYktiT3hU?=
 =?utf-8?B?WE0zUVIyVmJuVzl1N2t3VHExMkM2Y01jYzI0UmhCdEdjTDVQTzZ1b3dlajhK?=
 =?utf-8?B?eHltTzRsVXFxWk9aeTB2T0YwRmwvRUdQd2JPMzVIR29MeUdVbVhRai93T0Zy?=
 =?utf-8?B?b0lJRTR2aXo5Y0tDUW1rS3J5WEk4VGdnNDFPejluY2pMamg2WVdHNVoxb0tB?=
 =?utf-8?B?ZkhUNHVSUFpiNkNudllpUHE5UHZTUWpTZEZ0RnJVOW5HcWFFQmNJNThGb2Ev?=
 =?utf-8?B?WG1XUGFIdXpJK0pua0dPb3c5QzVsam1aS2loUDJERVN5YkEySEZ5TlRmK29N?=
 =?utf-8?B?MEY3OUZNcGkvVEkrWURBRGlrVXkyTkwzM05ZeTF4em1aV3UxRWdIMVhReUs2?=
 =?utf-8?B?OGhqWVNKeStHcVUvRzM2WXU4UHFaNDFwcG9GaW40bFJoUEJPa0g0MHdaVzQ3?=
 =?utf-8?B?WVhTVlNrNGRsN1VDVktYRTYvbFdOMUIwMGlrdy80b1VRMTRXYlB3ZTRwU3Z0?=
 =?utf-8?B?eGZUbnZqVDlablhKczZaR2pkQ0Y5VS9oZkhySzZqa1JzbWUwbm12VlpBTFhB?=
 =?utf-8?B?TGFVOTNTN2gzQzYvTVFFcHJUd1ZVeGdKYkdrbnY0eFJNaktQYlQ2aUJDQ2tG?=
 =?utf-8?B?aU5yZWRZTXNLaUx2SFh0MityOGJ1Uzh2dHRKUjU3anVkTWdFcWJqSXJ5b1BS?=
 =?utf-8?B?RkpFMzljZi9GTkNmL3pXZnR0VU9KRmUxem1pbmYxV1REeXV0WENHSUM5ZU92?=
 =?utf-8?B?d1R6UWNjTkNVZVNId2ZaUktxcUVXdzJERXg3Nm05OXpQUUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB8805.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZFp5TFVCQUdlRWpnYlJlWE1WQW84SVBNYmVGLzlzMVZPZVpWSEQyRlMzdFRu?=
 =?utf-8?B?MjROQmxTRVhTZ29QZUxjMExYZllYaURpY0ZKUVdkemNGYUJBS21Kb3dRV1Mv?=
 =?utf-8?B?cDN4MWJYWmEyZ2Z2eWI3SDVXUUF2dkdHb3orUGVxS3dMSk5yaW03Y3F0Mjd1?=
 =?utf-8?B?MXZXMnhYUENyeXpaSGN4UVVpNlV1bHU2TFJCNE1BYjluNUY4R011K2s0VTNu?=
 =?utf-8?B?MG9MMlI5eGpqZm5CY2NaY1NDODdFNTNBcEY3ZlhGcGpJRGE1alk3cWIwbGxF?=
 =?utf-8?B?NkJ5UFpybDVJdDVOL2NDTDZMOVcxeWRTSnk2QUs2SUQvQWZQRnlvUmRvUHVY?=
 =?utf-8?B?TXIzUmlIWDdWSm42V0FMcFRENkxPdW90U0gvc1dUVGxtMytuOFBlVmRNUzVC?=
 =?utf-8?B?WEIzdmxqa3ZDU21lRWJ2YzY3U1FvdmM5K1JtL3ROZjl1QTl0WVAyTFNSNUxv?=
 =?utf-8?B?OEp3UExXYlB5M0pNWEZIenNPZmx2dnA3UlAyakRYYm5xSHBIcmdwWDF2enEv?=
 =?utf-8?B?WjVGL054UEFRTU13YnFBNE1oVERBck5mQWg0Y0NDZHlDMXN1SWNuaWhpQ0Ir?=
 =?utf-8?B?UW1WMXlHVldBNXR0R2lxNCthY2xjYld3cnJlWEV6S2ljTUZobGthdjNpUmtV?=
 =?utf-8?B?aUhXdHBZSGJZVjUzcUhWc0ZXWTNSYnkwb0hpTW9uOVVOMzNpeFB0VHk0TUNZ?=
 =?utf-8?B?T3d4VFRZZmNyWERFU04rRDNSU3llZjZNTjJGcGQzbUJTMlJKVnRLQTBhZWtx?=
 =?utf-8?B?RDdkQ3VNMThsaWREb1RpeXZrS1cxTEU2UWh5dEFIdmxjcXVmMExGSVBsWVA5?=
 =?utf-8?B?amlvMkV0YWozdDEvR3A4M2E2VWVpZlp2TjBrMlhHdUFVK1FJTGp3blJObXVa?=
 =?utf-8?B?S2VteHNDS3IrR0JuekNTaDd2TDArVWtMN0IzTTZZN0k1VENMdXJjNktoMnk1?=
 =?utf-8?B?bzlvVDFQSTZGd0VJTU9JMjY1azBadTFDUG1IY3RwbWFnUVZ2Z2cwbVY0am5H?=
 =?utf-8?B?bUdHNU1mcE5obUh6aE1FR1NUSU42b2E0eGI2Zy9Hb1VTUUJCMm96eU5BVXY5?=
 =?utf-8?B?Sm5PR2tqSmVhclVraExrbUF5NXdwUzBqdDI0SmdweGZFVUJOOVFKSkRsdC9i?=
 =?utf-8?B?bDBBVWZNa01lRk8wRjA0S3BJZGVydm5rb1h2OXdjeXo4SUZsOGpTcWxTU01l?=
 =?utf-8?B?dFdoMVp2YVJITzNxRElxYWxkL1RSaytNS2psbDBZN0lIajh0b3VkUFovNmEy?=
 =?utf-8?B?UVN0S0lpSWJnUHVrUHJzZFlid0RmSGxYS1JNZkVlaGJGbEVJMUdTL3lwK3Bv?=
 =?utf-8?B?VFd2S3hVS0NPQm1hVTZYTDcvQjlTREFxQXFpSm4vT2M3cTJhbmVQN1l3Vmpp?=
 =?utf-8?B?NVk3OVY0UTNhK2h0TnJJYjRSYlEzTXVXSHBwRzVQYXJrVXBsajNFWXRRY0dV?=
 =?utf-8?B?cGIrVnRoWTAramVlUGpYUWs3ejF6NnVJZ0RKdjR3dmRsY0FLZnRRS3pKbGZn?=
 =?utf-8?B?bWpJS0s4Y3craFphNEdNM2pmWCtZNGh6K20vRFhsMjNiNXdGQUhReG9ZVmZl?=
 =?utf-8?B?azhLMzNpekpDUWhtcnlNdGwrN2lRT0R1azhHVXJFb0V6bDdsc1pmc1VPcUVU?=
 =?utf-8?B?V09tUkovbEFZVXp4MUdOV3NXa1Q4WlEzQlgxRE84elhTZHlNZlExaUxGaldz?=
 =?utf-8?B?SzhQME40c2Jab2tlTUdTNTU4dmIzOHVzanhUc0dIVDROWFNyVjlWN1lVRkVW?=
 =?utf-8?B?a2tmSTA3dGxxdWloWEF0MUsyUFNRVERBSDZwaHJ5eWhpNGNZVlAvcXhEOHpn?=
 =?utf-8?B?SmlXSXZ0bkdPL0QvN1d3Q2VwZkF5Qjd6L3NJdXIvSHFISlBEV1lKZGhnL3c4?=
 =?utf-8?B?ZEcyU2tTTXZ6bnpWS1F2TnVTUERUMTNhaHozSEtDRExPQU0vRHJ4ODR2RDNB?=
 =?utf-8?B?azhsZm1vVThlN2RmcXdlZy9WRWpMYlUwTWQzUFZkc1JUd0VJbHNoTnhPYmNq?=
 =?utf-8?B?elJtZUJ2cGUxUkxieitSZEE4ZUhwYlhhQmUyUGRwNjh2QzZybWs2R3lKbENr?=
 =?utf-8?B?eGpBdlUzV0Jwd01vRzdYUEEyT3llck1IVUNibThONTFZbHZaakQrUVp4TS9O?=
 =?utf-8?Q?BCi65IHbGLUimBsirLsW5XYaO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B616BC1FCA985142BE93B7FCAD86FF72@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB8805.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66965d04-b0d9-4a99-f714-08dccba84a2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 23:38:03.8906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lG15yWAFUzy1lQrTEhJ+0ueLcxJmydsU2+LrqnruvUadOzUNk7Oh0v6BvpN4bHyAx/X/QCbNb5j2gwudJpOGDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR03MB8700

T24gVHVlLCBTZXAgMDMsIDIwMjQgYXQgMTI6NTU6MjlBTSBHTVQsIFZhc2lsZWlvcyBBbW9pcmlk
aXMgd3JvdGU6DQo+IENvbnZlcnQgaXJxZF9nZXRfdHJpZ2dlcl90eXBlKGlycV9nZXRfaXJxX2Rh
dGEoaXJxKSkgY2FzZXMgdG8gdGhlIG1vcmUNCj4gc2ltcGxlIGlycV9nZXRfdHJpZ2dlcl90eXBl
KGlycSkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBWYXNpbGVpb3MgQW1vaXJpZGlzIDx2YXNzaWxp
c2FtaXJAZ21haWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2RzYS9yZWFsdGVrL3J0bDgz
NjVtYi5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQoNClJldmlld2VkLWJ5OiBBbHZpbiDFoGlwcmFnYSA8YWxzaUBiYW5nLW9sdWZzZW4u
ZGs+DQoNCkJ0dywgSSB0aGluayB0aGlzIGlzIHNvbWV0aGluZyBmb3IgbmV0LW5leHQgKG5vdCBh
IGJ1Z2ZpeD8pLCBzbyB5b3UNCndvdWxkIG5vcm1hbGx5IGFkZCB0aGUgYXBwcm9wcmlhdGUgcHJl
Zml4LCBpLmUuIFtQQVRDSCBuZXQtbmV4dCAuLi5dLA0Kd2hlbiBzZW5kaW5nIHRvIG5ldGRldi4N
Cg0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2RzYS9yZWFsdGVrL3J0bDgzNjVtYi5j
IGIvZHJpdmVycy9uZXQvZHNhL3JlYWx0ZWsvcnRsODM2NW1iLmMNCj4gaW5kZXggYjk2NzRmNjhi
NzU2Li5hZDcwNDRiMjk1ZWMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2RzYS9yZWFsdGVr
L3J0bDgzNjVtYi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2RzYS9yZWFsdGVrL3J0bDgzNjVtYi5j
DQo+IEBAIC0xNzQwLDcgKzE3NDAsNyBAQCBzdGF0aWMgaW50IHJ0bDgzNjVtYl9pcnFfc2V0dXAo
c3RydWN0IHJlYWx0ZWtfcHJpdiAqcHJpdikNCj4gIAl9DQo+ICANCj4gIAkvKiBDb25maWd1cmUg
Y2hpcCBpbnRlcnJ1cHQgc2lnbmFsIHBvbGFyaXR5ICovDQo+IC0JaXJxX3RyaWcgPSBpcnFkX2dl
dF90cmlnZ2VyX3R5cGUoaXJxX2dldF9pcnFfZGF0YShpcnEpKTsNCj4gKwlpcnFfdHJpZyA9IGly
cV9nZXRfdHJpZ2dlcl90eXBlKGlycSk7DQo+ICAJc3dpdGNoIChpcnFfdHJpZykgew0KPiAgCWNh
c2UgSVJRRl9UUklHR0VSX1JJU0lORzoNCj4gIAljYXNlIElSUUZfVFJJR0dFUl9ISUdIOg0KPiAt
LSANCj4gMi4yNS4xDQo+

