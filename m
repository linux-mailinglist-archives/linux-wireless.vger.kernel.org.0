Return-Path: <linux-wireless+bounces-17301-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3796DA08A33
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 09:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E7F3A8E79
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 08:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE4A207DFF;
	Fri, 10 Jan 2025 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="OIEohcXC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123FC1FF7DA;
	Fri, 10 Jan 2025 08:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736497958; cv=fail; b=FUZKeSBC+bhd/GBx7xA6HYZB/LO7ado0eXBx2cJJX2/K5NnYoBnqhZMZ3os+nL+07pDNRh/dXLWPiUSsk8MP/yiZazLWCLO+wI6+wGBw7Cxj86HjP8T49vuHCDG7qi8xdCQmLvsrg0vYlyYPd0qSBBI1xAHzqj+9nWtEuXGBgSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736497958; c=relaxed/simple;
	bh=sWtm1RMU48wLuVpaEMXW41unr+K5jRJ1LifY11X/wuE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z4a3FtAS6oinw4MwjhlvCblW9Wuk6Q2O0SJgPOf3shHMdof+OuR/dQ1/nIHNNjCrnSo7X+6DwkKB5tDYsyKTL5bqVeXe+G/caEc82nnpl65e87+u3XdqEQi5L7oj/oV4R4FTolvM+L8FxqtEvU2gKKIZCmA0LNKlD4+hUGD7HoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=OIEohcXC; arc=fail smtp.client-ip=40.107.21.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LsI15iz0g3DViz8C/Yz65GWVpVzbGzWyGyKsENnSJVatBhOFVk7cpo4jhA3R+jqozpODwWAewtbSAJ5fhLmSUZlA7FByUtY4ZLuvvfJ9qULsH19P3s6acHAOmu+KwcuUeqGBv4HaRLQjU8JntU7EAqEcpsxFB1rJZ6BecwU7HIfsQVRKnhfzwGYDRwWgALu/jQ+yhNWcKcPp3gwBUBYQsMR+BZh6UmncBTtHdxBjPdoar24iMF+1OPUBUseda12CQ3t9fA7z/iIAi3gKE5b1iv70MwIrFDxTdFE3luMxEfo93GU8OUUcv5aZgOdrQxT1UZ/fPQSx/3/xwjj2YxmAYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWtm1RMU48wLuVpaEMXW41unr+K5jRJ1LifY11X/wuE=;
 b=tL2ZMgGN6TQkCYH7kIkLBNbI5jA3jAHshvniKyMa71Q1KnlFLhzk2YFG/BHCpFtAk8YaCB2qilgj0lhMQ0gDajF6WxKW137/f8dAg8EU2xPZuPrO3nNUoMPMIMOUY2wn/ximZzTOcY6k3YzkS5Dlcma3jWDG1n7v735bJU9qV4FkyMNxnxAmpQQP6oDDga5F63kcWJ7HQOuvhB8uJm62fevFoLXmdFZlsy0a99t9B9xaiujoC3KC+crIgCXXySmdXWTTDJU9Al+Hpu96oEnGJ3ASkXwpCWRgPNa6M1W7/p1DS8RAFe/9wywM+GP8fGo5oCh2sdeq1Q1vlpWfuwd2Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWtm1RMU48wLuVpaEMXW41unr+K5jRJ1LifY11X/wuE=;
 b=OIEohcXCiGVvog44dKM/Iw2pi9lsTP4F1KNcSiY1syxS66p4lLCWmLUCCfWEFO6Tre2vOLjkvHAnQ9rGdZ9PwPE9reeHfJBTAxTYEZHy4LKK7uQoihXu0QUAVwkzRCWOnRXxxyQ9JVkKBS3lKL1G9nGDyVwedTlRRreN1obG0Fk=
Received: from DBAPR06MB6901.eurprd06.prod.outlook.com (2603:10a6:10:1a0::11)
 by DB9PR06MB7642.eurprd06.prod.outlook.com (2603:10a6:10:256::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 08:32:34 +0000
Received: from DBAPR06MB6901.eurprd06.prod.outlook.com
 ([fe80::3988:68ff:8fd1:7ea0]) by DBAPR06MB6901.eurprd06.prod.outlook.com
 ([fe80::3988:68ff:8fd1:7ea0%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 08:32:34 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH net-next 2/2] net: rfkill: gpio: allow booting in blocked
 state
Thread-Topic: [PATCH net-next 2/2] net: rfkill: gpio: allow booting in blocked
 state
Thread-Index: AQHbYzh3a/NgFfvpHEWnKpG042qPYbMPrfKA
Date: Fri, 10 Jan 2025 08:32:34 +0000
Message-ID: <a6f96969-f121-436a-93ae-752a538f1a07@leica-geosystems.com>
References: <20250110081902.1846296-1-catalin.popescu@leica-geosystems.com>
 <20250110081902.1846296-2-catalin.popescu@leica-geosystems.com>
In-Reply-To: <20250110081902.1846296-2-catalin.popescu@leica-geosystems.com>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBAPR06MB6901:EE_|DB9PR06MB7642:EE_
x-ms-office365-filtering-correlation-id: cf56ba09-69b6-4c44-bfe7-08dd315154c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?UTFOWjFvRnN1VkQzQTZzUXhHUjgvUnM4OExwMVVKQWpKSGNvQkg4YnZEKzI3?=
 =?utf-8?B?QXgwMkFRc1F6UTYyUm1XWjRVWXRXdDdPaGJUUmw2c2dMN0FZRDg1aWdOK2E3?=
 =?utf-8?B?d0xob3dIYWprSG51TFBLQ2czazVsZWV1dUlscWVOd0k2S0VXaEUwaHQ3TUpC?=
 =?utf-8?B?cm9KZXVRem1sTjFRVEdPKzRBTGZqYnY0eVNkcnEwbXEwSHFQc0R3Z1ZUVjhP?=
 =?utf-8?B?b0IzNDNYKzQrdkdaOHlTZmRqZGRCZ1FiSW02M0x0eGwxS1FWNUpBbE05UnVy?=
 =?utf-8?B?ZSt6ZG9jYitsekxRVzNZQXd6MjFlSytraCthK29UMktaRElKdEFCam0wdjgx?=
 =?utf-8?B?SzBVKzZDUFlBUSs4K0EzVnhYTStjMUY3VTMyS1RTTzlqbGNpVzB2UE53bytu?=
 =?utf-8?B?TENSTXJZMEFhK3k0STVtc3VpWG5GbjczUllScjZUejNuM2pJL0ptOU1qYWRX?=
 =?utf-8?B?cFRTd3YzN1ZqNnZBMk9wdCtycXhmS09WYWpqQUdlNjFmUmh3eUJuNFFJUWpZ?=
 =?utf-8?B?d0JSQkFqa3pkbzBoSmx0dHdqZFpoa2lVL2dxSm5vaUZ1SVhnKzlHVm5QVVlZ?=
 =?utf-8?B?MzJYRWk4RUZVV2ZvMHZTYzN6NGIyZHNTZ3RwNGZDekNRbVlrSHdVc0ZJRm5S?=
 =?utf-8?B?bG84cURCRmpOSzRxd3R4SjMyUWJvYmtwbFRqR1FjS2R5REJHeFJwMnZqUHdn?=
 =?utf-8?B?cVMyMXl0dlUvVTBiNUVsY2dUa1ZESVFIcjliZ3ZOYWJSemREbkI5ZWswL2hr?=
 =?utf-8?B?clRQSTczS2J0LzFvT0VvUWdXbnhsazFxaXZWTC9WMGFxSnl2TlpjTmZlODJ5?=
 =?utf-8?B?Qm1nNUVzRzlUQ3Y0WkViZk16WWcrTkZjLzZ2cGFETHRqZlcrb0E0R21DQU56?=
 =?utf-8?B?WVl1MjA2aTNNNUgxdlZXZ2RRMHFDLzIyMnhEMDFXM3haUFJES0xFMDhoTWYx?=
 =?utf-8?B?OGc1RkRlMi9zc2syMUo0SlJrOHdEenZONVl0NkplbUhoNlRLdzVmTDhpb0Jt?=
 =?utf-8?B?ZkFhTS8vZ1VwaFNnM3BHWHBSSFZnbkVMMVFKSnlZVEFHVWhOY2VNM0VjSGFP?=
 =?utf-8?B?SGFmY0ZLNEY4b25FUFVFa0JTV001VDVvVGt0V0ZvQUVtNHAvUWV4QVJGOCsv?=
 =?utf-8?B?T2F1S0JUWmczUW5VWTRRZ0xNRUxzb2pVanJFeFVtTXV2SVhLNDU1UjRhQTJt?=
 =?utf-8?B?YWowOXpjWko2UWVKTXFvK3BnV01iaVMwNVlSZU5WSnpCeVFCY2hTbnhiMDh2?=
 =?utf-8?B?YkdpUEdKTlByRFh0MWN6ajRPN01zMlZJSDE4bjV2TWlIK2RaakN6cVpZN1lZ?=
 =?utf-8?B?UWg0RUtuc2duR05wcEtxV3g1S2hPS2xKelFDakMzV0hIbDlEUm9TTDdJNThk?=
 =?utf-8?B?UGp1dW9jMzkxVDhpUnJaazFuRGFIcy9ETEw2bHFyMEEyanhxK0ExdkFsWW9j?=
 =?utf-8?B?VmhZbVhvMVAwR2Jqdk5oYzYrdEtxSzNCVitZVTdkOGx1QXBuMlkzbzVqMVJz?=
 =?utf-8?B?ZWk2a1RtSWRuU08yZXA1WGdvR2NMUXVEdmVtQ1hZTW9RaGgzT0pyOUtXQ3N2?=
 =?utf-8?B?L3hyWjRmdGN1bU1CancvbmpBeW82ckoyTFQ0UmxTL1MxMlFwb3RZWmloRkRu?=
 =?utf-8?B?V2V3M251dVp2Ky9aT3RYOGM3NU4xaFJRejJOb1UzcEtXT0NwaFppVHlrdFZQ?=
 =?utf-8?B?Y1J0b1JYeThxYVFURHhDQjBncWJETzIzeFZxYTNsYTljdGVaZlF4bEJFT1FQ?=
 =?utf-8?B?NXcwbGJpN2kwZk94LzUweVRRSm93SmlBZ0xBakhtcER5M0xmZ3oxSEpqV0to?=
 =?utf-8?B?S0RZUkFmVGRFRWxMWkJUY0hkNXlvWDZzS043RGN1aE5UT0IxTGFjMHM0bEU3?=
 =?utf-8?B?YkFpYythWHVTOWp2dXdVamJjSE9OcGxNSVRvQmwza05EZ2duWW9DMHZwK3R1?=
 =?utf-8?B?OWYwY3BsUm5YS3ZxYzdwM0x6ZTdOS2xodFZ5MThMcVA5aittQXIrTmcyV2lW?=
 =?utf-8?B?Y0lVazhSdVJRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR06MB6901.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V0NPNWY1TjAzN05VZ3JxSndyeHE0ajR2RmhZd2laTXZ3VlJILzdCL1JZRGgz?=
 =?utf-8?B?bVBGM2h4UXFoUjVBZE9JNWJIR1d4cVF1ZG1BR2NYZmNwUUhpTTlSa1dkM0hI?=
 =?utf-8?B?dTl6QVAyaG1sUFREWTZiNWJDR3RPUkRzczlOKzdsQ25lYzJNZldqcXhNL2Vv?=
 =?utf-8?B?RnFqN1hXYnFVK0ZEN2JzbDd4N0d2RUt4MjFvWTVmbVhwbFUrZ0YrN1EzM20x?=
 =?utf-8?B?aGo0UXJldGJCYUI3Zm1wM2NFQjcyNnQ2VHJKc2dTTlZSSXUwMXZhUTlDVzlT?=
 =?utf-8?B?aWZSVCtTMHdLajBuY3Y3amc3Q1NvZk1xandRV1VYbzNxd2xBeWdNUVBDQk56?=
 =?utf-8?B?T3l3a2VZN0srM2RNQWlWQW4ra01XaldIY21GZkZJTUVQVWltZDFGRGlCNytE?=
 =?utf-8?B?cnVIdm04QU8wODNCT0JoNHVielFtVGpuc1phOTNndEVyMmF2b0N3bWJLSHJS?=
 =?utf-8?B?c05LelY5c3lJVDBNNXpabzE4QkdBdDFzQjRCeTBRekp4eXFJNmxsTXcyRUU4?=
 =?utf-8?B?THV4NWxCYng4U2ZiSEd2WmVQZjQxMWR0NlgyZUFhMjd5UTZaRG9zbG1EOGRk?=
 =?utf-8?B?b1pqNEFJL0pKVmUzbTRCVDBIMnFzQlRvMFduVm5DdUdmUVFMTVlYWUdCVFJX?=
 =?utf-8?B?SlhxQk9qOXRwRWo3cHI4YXdaWGpFOUZSa3BJbmFlUmJZY2RLQTNmZ1kvOC9i?=
 =?utf-8?B?TE1JUW9Wamx3WUd5akpMNmZZbDZPVmFiYXBVQWhvYXU0eGl5UWVac3djbEMw?=
 =?utf-8?B?YmhuMmdRSEVGaGc1bEpPSnVkWWd2NW9NVVdydDhmcmRRRHoyY0N2WVNMREhY?=
 =?utf-8?B?TlMrSnBkUnJ0dEJ5V25GVnlQdmpQbDgxT1RmRzBCK3NaODBPbkFhT3owK0Rw?=
 =?utf-8?B?Y0dLK3E4bThjaDY1d3djcE0rLzY3QitmcEFEb2JGNXd6YnBJU3AwNzlqeEFn?=
 =?utf-8?B?b0h4MCtKK0hRQnpmYWJPUi8wRllOVnR6dzlid04xaXNBTENMUUVyeGNJWTk1?=
 =?utf-8?B?K1BiSTA2SXhhRk9rbkJDL3A4SFRCazZvWTdMdkMxYlhNTUpqL2xNUlM5Y0J0?=
 =?utf-8?B?S1hhRzhpZWtoNVVuaGJncnNpbThQYzEwZ0kwWE5YRjdVQ2R1TE84M3d0b0ZP?=
 =?utf-8?B?TlhlS3c0NGJHellQZi9uTW96MXRjc2REQVpLeTBKZ29IN3d5ZHRTc3BMdUxm?=
 =?utf-8?B?ajB6d0tRTkVqRmdVMFhRUGYzVnFIcEsrQll4bGNCdnZJbWw1WEd1RDNRR1NP?=
 =?utf-8?B?eUdZNzBJbERtNmlKOThKc2d6Wm5vNnBKTVo4Y25DKytsSHFoOGRzeVpZNXl0?=
 =?utf-8?B?ZkJreUpPbHd1bWErZzc4UlU5WlRXZ0tZdm1wUDNvcE9CSklhMWtlU05JT1RV?=
 =?utf-8?B?TW0zSjRscFNKYW5ESlpoSkN2VGhDK3U4dE5TTHE4MHYzZUZ6clhDNnZIa0Vj?=
 =?utf-8?B?aEIyekhCR25QQVRicVY3emxOdTZCUHdLY2IxWG9TRXZ1YklMcUwvelljbFVR?=
 =?utf-8?B?N0ZHeXNDQ3owYmxzWmczdXFsMEJidWVvdTYwdEN1bUdqNFdVWG1yc2x5UlMw?=
 =?utf-8?B?WEV2NTVqY2xVaXhtRDFsVmdZUSsyNk1vczA2Z3Y3L1VidG1ML2ozRUR5eDQw?=
 =?utf-8?B?Z1pLNDI3ZUt6amdIaEpHd0pBY3hLYldIa2RMT1luUGY1OUMzazlGeHpwWFJj?=
 =?utf-8?B?MzlwS2p0ZGVGUkNzaWhYMGNpa2xOSzlCSlNUckJCT3FEdEFEdGdMcVZudGVz?=
 =?utf-8?B?Zm44TU9PNHdKRmhiaWZDSUtiYTNRTXp5WVZXMjcvSjhtM292dHF0ajljbStO?=
 =?utf-8?B?QUdSQ2tHcGZsT2tHbG1OOEF6S1FSdDJSWE50VlJOL1B0RkxCL3dPbWZ6REFJ?=
 =?utf-8?B?VVFtWFVQNGNTOGl5UFBjWXZJOW0yUGxWK3RKT2FrOUF3K1VDeGU4TlM0VWI5?=
 =?utf-8?B?SnpTczhheWNhb3NRNS9pd0FndXFqbTRKdVZ4RmVaeFA2Tk9UOW9WUmdYWGx1?=
 =?utf-8?B?cVRodFJlei9reE1VODM1WmppV1ZPOHhocElkS2dSV2xCeEpQZFBSVVBJdXh4?=
 =?utf-8?B?dmRTVGFFRnNDQnJXby94NDdtaWFSS25ZcmxxRTYrVTF0OTZab2tVbHVXRjBF?=
 =?utf-8?B?aVZjbFlUVUNRNW1zbTB1WkFIazc4MVZ0SnhYcW9uSkYxKzl4bzFkdjNNd2g0?=
 =?utf-8?B?MEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A52EAFA1668B2A4AB35F9AC3ACB8B30F@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBAPR06MB6901.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf56ba09-69b6-4c44-bfe7-08dd315154c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 08:32:34.0451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2WT88eFvkbANUIVuuPqtq+A+yRYGsCFXfInQVzlTWYeM8erBVG3WAukWm2skOOFWC9VJYfemY7Mt5NMEqFvP6xHx0PJ7T0H/PCdLN5N1McQ6IDP0SL6W0a8CmAZBgvHJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7642

RHVlIHRvIHR5cG8gaW4gbXkgc2VuZC1lbWFpbCBjb21tYW5kLCBzb21lIHJlY2lwaWVudHMgd2Vy
ZSB0cnVuY2F0ZWQuDQpBZGRpbmcgdGhlbSBoZXJlLg0KDQpCUiwNCkNhdGFsaW4NCg0KT24gMTAv
MDEvMjAyNSAwOToxOSwgQ2F0YWxpbiBQb3Blc2N1IHdyb3RlOg0KPiBCeSBkZWZhdWx0LCByZmtp
bGwgc3RhdGUgaXMgdW5ibG9ja2VkIGFuZCB0aGlzIGJlaGF2aW9yIGlzIG5vdA0KPiBjb25maWd1
cmFibGUuIEFkZCBzdXBwb3J0IGZvciBib290aW5nIGluIGJsb2NrZWQgc3RhdGUgYmFzZWQgb24g
dGhlDQo+IHByZXNlbmNlIG9mIGEgZGV2aWNldHJlZSBwcm9wZXJ0eS4NCj4NCj4gU2lnbmVkLW9m
Zi1ieTogQ2F0YWxpbiBQb3Blc2N1IDxjYXRhbGluLnBvcGVzY3VAbGVpY2EtZ2Vvc3lzdGVtcy5j
b20+DQo+IC0tLQ0KPiAgIG5ldC9yZmtpbGwvcmZraWxsLWdwaW8uYyB8IDMgKysrDQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvbmV0L3Jma2ls
bC9yZmtpbGwtZ3Bpby5jIGIvbmV0L3Jma2lsbC9yZmtpbGwtZ3Bpby5jDQo+IGluZGV4IDlmYTAx
OWUwZGNhZC4uNDFlNjU3ZTk3NzYxIDEwMDY0NA0KPiAtLS0gYS9uZXQvcmZraWxsL3Jma2lsbC1n
cGlvLmMNCj4gKysrIGIvbmV0L3Jma2lsbC9yZmtpbGwtZ3Bpby5jDQo+IEBAIC0xNjIsNiArMTYy
LDkgQEAgc3RhdGljIGludCByZmtpbGxfZ3Bpb19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KPiAgIAlpZiAoIXJma2lsbC0+cmZraWxsX2RldikNCj4gICAJCXJldHVybiAtRU5P
TUVNOw0KPiAgIA0KPiArCWlmIChkZXZpY2VfcHJvcGVydHlfcHJlc2VudCgmcGRldi0+ZGV2LCAi
ZGVmYXVsdC1ibG9ja2VkIikpDQo+ICsJCXJma2lsbF9pbml0X3N3X3N0YXRlKHJma2lsbC0+cmZr
aWxsX2RldiwgdHJ1ZSk7DQo+ICsNCj4gICAJcmV0ID0gcmZraWxsX3JlZ2lzdGVyKHJma2lsbC0+
cmZraWxsX2Rldik7DQo+ICAgCWlmIChyZXQgPCAwKQ0KPiAgIAkJZ290byBlcnJfZGVzdHJveTsN
Cg0KDQo=

