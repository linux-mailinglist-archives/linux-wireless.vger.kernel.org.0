Return-Path: <linux-wireless+bounces-8790-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D7A903C0A
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 14:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62FB1C21CC6
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 12:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7D94CDE0;
	Tue, 11 Jun 2024 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b="Y8e+neJ2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2090.outbound.protection.outlook.com [40.107.127.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511CA176223
	for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 12:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.127.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718109410; cv=fail; b=iUL4CZ5IdJXGuQfQopoiJn5V1xwgpdCkmVOVpC65iHzb6jSragMIA2ryjOOKs+mWRqVPeQdvscMijXEb0hpQQv1r31DctxlNZNEdpq460+2yvIzoMDMlv4t19bFS4hEomvBHXhy5IKLc3kwYYTDsyvbX7FQfYPWFyDeEAOl/Wc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718109410; c=relaxed/simple;
	bh=G3RsgzV2hoRymCb5VyOwKedoULwsoKV0PvOeMjXwSGY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bLADa/jQdaqNnF1m3O886Peguz6d5B0U+MVWg5iMoLgBHJN83zOSrVLrk1st3nTNeKSM4x7l8oANDoEQuxzmh0gRtaASd+EcGLk+a0kRshgLqI9Qbrror/c6TOlZggDsfpzUa6GNKTlVX42WcEnR8lm1DsJxd7NI5crOjzy36iA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Softing.com; spf=pass smtp.mailfrom=Softing.com; dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b=Y8e+neJ2; arc=fail smtp.client-ip=40.107.127.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Softing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Softing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UsPnDrIzeH3CTYR+DuD7NxEXO4AEShY2AC7LKLjkjBqF81Ca5yaT8nrS3VWacYc/IFRvzRDm9o4EnqzBNGhaspDfRMbGmk4lI+aA4VSU3JzBUkop2JLyLk44AKxAYo73pkU8eIbqPrSn5c3BPDeMrY17SI7/83uC20eTHuZKiBNKiAZZmEM5E3ufFPX6u+Q2aaZJV8pvEd6gj/A6ug0ZKOgIF0xYa8Am5uTHaKV9WtC+Y14/9tH8yU5PRRfkB7CNCfeZcJcOXBkMZ3iNwtVrNADaDWmz7ojTuU9AVle+aYt8YQcedxggZObBZW0WI4cmf0fmqB9oiEQDVqaYAFVumw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3RsgzV2hoRymCb5VyOwKedoULwsoKV0PvOeMjXwSGY=;
 b=EIHsc2uUPkKhrxy+0K8FN03gjBSsRiXXcKi/ZAkZjYhomkAdzuY4l2Ha7ln14IJtGIDhAObmhJHDS5NX/+x0f4oVPz85LsxdKo/C3jR0KL63PoImhcFlUt3T7ncy66DGiuMssrq9JZLrD5zIjS7k1i50Bvxz58TB+9WMbh3m9QXi8tsyI7V6C3xgkxp8Bl/Ansg0WvLMhTBc+XryPPB7Wphuf/6alL9+KgKjM7Ic9X6r6pImpKnLExxph1Bi3/pwoVISUHTieeLBgSW2unHB83qPYPjWOG+bZihKkvhHnFndLp0/HXZ7NEJjjhW0ptNhuaSWZBvuRtHBH3z/97/9mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softing.com; dmarc=pass action=none header.from=softing.com;
 dkim=pass header.d=softing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=softing.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3RsgzV2hoRymCb5VyOwKedoULwsoKV0PvOeMjXwSGY=;
 b=Y8e+neJ2kb9I1EILL5xqvmzIaC4PdIEPJayYOMP43AorA+0fpniYTXT6gXItjctVsfzuWMDdT2B4lQf152yA+AK47QX/rqC5Gehoaae9LLT4VThAGdm8RMvPqggjSomsk+DmlAcs9KHexf8AkclaZz9XNGgs+A+0PNwDUyoMVYfWS2y8NrmPGUxRj/VhyJonTEHAF5mZJUJBtnFecv6pqYKmmlugyY3mZvhdvdWmI+cgCcHQYe5Z2fcY1TnmqisbjtlIWnaAAg5bvyoTHjRnGqj/njWh6K1Oei6Q3hFOVXSTc+tU160+IynWWjrwy4OiKCWJUK2rHLIaRAwubc9ruA==
Received: from BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::7) by
 BE1P281MB2631.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:4d::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.17; Tue, 11 Jun 2024 12:36:42 +0000
Received: from BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8de2:b2ba:4092:939a]) by BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8de2:b2ba:4092:939a%4]) with mapi id 15.20.7677.018; Tue, 11 Jun 2024
 12:36:42 +0000
From: "Sperling, Tobias" <Tobias.Sperling@Softing.com>
To: Johannes Berg <johannes@sipsolutions.net>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "Le Suire, Michael" <Michael.Suire@Softing.com>, "pkshih@realtek.com"
	<pkshih@realtek.com>
Subject: Re: wifi: mac80211: unencrypted message in 4-way handshake
Thread-Topic: wifi: mac80211: unencrypted message in 4-way handshake
Thread-Index: Adq7OqrIXwNmhc6ZT92PlJydhITGNgAAMsqAAC1j+AAAAr9O0A==
Date: Tue, 11 Jun 2024 12:36:42 +0000
Message-ID:
 <BE1P281MB242075CF50BF71257D14F955EFC72@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
References:
 <BE1P281MB24208AB02DAEACAE9AF4B5C5EFC62@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
	 <BE1P281MB2420DA2C6AFF94E525306302EFC62@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
 <6bdbcae5cfedccc507426bde60fe86e72212ca5a.camel@sipsolutions.net>
In-Reply-To: <6bdbcae5cfedccc507426bde60fe86e72212ca5a.camel@sipsolutions.net>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Softing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB2420:EE_|BE1P281MB2631:EE_
x-ms-office365-filtering-correlation-id: e84c3cb6-3b0a-4c98-5a88-08dc8a132614
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?UTZxakRWZlBWZUoyQkI0dWVEQmNWTXJZR01ZeVRJMG13aFhibEs3ZmNhRFor?=
 =?utf-8?B?d1VIVzJjdTBLM0xBYW5WSVdhYmgrVnZjcHAzZ3Z4b0hBeGw0a3dNcXRQdVov?=
 =?utf-8?B?SDNscEJXdTRoa2xWeGVqZTM1UXk3RVZ1a3ROR1J4SGs2TllvNEt4ZVIxQ0k5?=
 =?utf-8?B?VlEzUzM2VDF3NVgxdk1pbGlYd2p0UlFzZFd1VkxIU2VaL0daR2VpYTRBbHhi?=
 =?utf-8?B?UGJqUDgrTjcvZmxIZVlVaXdRWnB6T1JiV3Zxc011eWJTTEdNZzdGYUdmZlI0?=
 =?utf-8?B?eFZUdnpMcHJDb3VMbU1mdEpZSXh2dDhuRGp0TTJkUzZURk5WeVNLTGJhZWpo?=
 =?utf-8?B?ME5USzU3U2hITmVmbHM5N0wzclRkdkNudCtJQ0lQVEpqK1FIVXhidXh5M3Fl?=
 =?utf-8?B?QW5Ka3hJcHpFbGU1NldXbWFIVlNYVEFhN3BFQXFXQjRCN3lFYSs2VTRrTHVa?=
 =?utf-8?B?K1ZlUmVYVTlTVnIzdnEzT0IzUTlvNU5iTlNMYkhIOWlwUWRSZ2Fzd3QyMC9C?=
 =?utf-8?B?Z1EvbDc5MVpWdS9nZGRrRkRmN2tvcjJSYXI3aVkyS002K3MrQzd6aUZyZkJG?=
 =?utf-8?B?TXMybkRNQi9FZnUvdkFEbzNGRXdhYmxPdlFuOU1HWmxrVURqVlBSMzduK21s?=
 =?utf-8?B?WTNRekRhWEZQU2NJSTVpU2tZTHVLanFKSG9LdXZMUFRtMEZnc3ZzUHJQZENi?=
 =?utf-8?B?ZjM0MUQ4VDdoZFpwUUxqMmRZUmtZWDZma1o5QU5NcjVWNjlUelNwOHdFZWhW?=
 =?utf-8?B?cTFiQW5Lb2I4RGVodHRkY1BBY0ZwZlpoQU1pUDcvZ00vTzMxcXdUeWhlQnha?=
 =?utf-8?B?V0VZR1hjZERONG53bVJlcUpwQ1RZZEY1bHVGMzhiM2ZaelIyWmxUaGxYRThs?=
 =?utf-8?B?M2hGL1dBa1BldXVZRkNXOElrUzFFeWlPMHdPcUxPRUgxOVJyemdBOUZGOUlq?=
 =?utf-8?B?eVNhZExNd0toNmt4YUJLRVoxbkNPRU9tSzVsdjRWWDgrTXZTQnVLbDFXanJE?=
 =?utf-8?B?a0RuMVo0OXFCOHBWdUtncjBaZzNIejlJc2JKUkxyVVpaZTk2WGdqWi9ROGlw?=
 =?utf-8?B?a0JYNkdidllHd3RaMHQrQkVZamtWRUJFdWp2bVU3blh3ZlYyd3I4MzFSWFhK?=
 =?utf-8?B?c3NKcmtYeHpmR0pCTXJCTTUwdWwza29CckJaT042NktreHk3aDBKempDNmZD?=
 =?utf-8?B?dHhmYTBSNFVQSXZXZlgwN0tSTWd3ZCsrUDJ1UGNCNWo1dkE1Z0duRkYyRkFZ?=
 =?utf-8?B?VGF5M25ONmlWY1Nuakh5REthMmF2c0Zsb2JGTVBSVThRejlXZHpLdWJ5aDBV?=
 =?utf-8?B?Rk11REl6ZFQzQzI2ZjNyaG83S1BMTEVJa2NKSEU5T1IxSGZUbGMxNEZmbTNh?=
 =?utf-8?B?c0tUaE1McjEwS3M2NEtITHN3VmJsM3J2MHhTK2lDVElSdUFYRXZpQzV6QzRR?=
 =?utf-8?B?VVJKY2lHU2NEUDdwYmxkVHl6U2Raa3l2SUZ1MlJXTzV6STNRWm5nU1IwL0tN?=
 =?utf-8?B?bm9XZXVuaklQb3VELy9qcDVVdVArUUJpcXFNUU9hSXhqNE9EbEtncU5zQVps?=
 =?utf-8?B?VXlpZTF0R3pld3BoYXdUcGp2bldISE55RDFOcTFqMEtjMDMxbmgycy9DNG9Y?=
 =?utf-8?B?UUZKNnNPQkUzT2wzQXorNDFtNk1QZ0tsbk1PcllmTmQrbGdkU3RoS05odncx?=
 =?utf-8?B?TXVEdnpjaHJpRENnYzgvMkw2Y2RuR3p3K2ZUa1RRQUg0UllTVGNHZllnUERy?=
 =?utf-8?B?ZUFSa3Y0WjZLeDAzMjZNV3B1TUN1Tk1iMHY0Q014eDJ0RXEzY25UeDJEYjdS?=
 =?utf-8?Q?E3afNY7IRQzLDbYhIZcssK2HVU6kZlaClWMqY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y3hJMzExM3EwRDNwVVRwMkZmVnVQd3dGd2Y4L1BZSXM1cE4yaTRjcUJ5cUg0?=
 =?utf-8?B?NXJPaVFodHRxV1VkUW9jeXZlVjFsMkZaTHdMYTNsQjdwNW1zb1hHMS9oQUlQ?=
 =?utf-8?B?VGptdldOSDNqeUQ4QlhLREdVNC9BaVlxaWczekVBVHBxeGFPUUZZMXBQS0lV?=
 =?utf-8?B?T0Vaa1ovVVpTS0hlUmdYckorMlBmc3JpZHdhK1d4WmpZaGg1REhHMEZrS2tW?=
 =?utf-8?B?RGlzbHZZK0M5SWdpblA3aGZncjduRHY2WENsWWhpcTBpbDVLUTUvdWNqVlRw?=
 =?utf-8?B?bWd1NUI2YWIvRUxWSEUzQURIZHBvbHcwY3dXUjd1UktzZXRyZWhPVkNXMjBN?=
 =?utf-8?B?cFg2MC9FUFJFS29QWkVnK0FzV1JqcmxUaDVXRS84bG1ySnNETnJFcjBYN3J6?=
 =?utf-8?B?UkFUMGtoTXlYaVZBdVFxYlBCOHpYWEJWT0RETkxGSnNRcVNWN3FXZVR6eld2?=
 =?utf-8?B?U0YzdkhQM0l4WTRmQ2hWMEd3eW1VcVpEcHVIUVIyN1JaSnZYaDM4VGZLem9P?=
 =?utf-8?B?T0tGa0JrWjNrUmN4Z09xNENSMVhtT0dzL1Nuc21zcjlXbnpJOVBsT2FPa3Zx?=
 =?utf-8?B?MTZNQkk0REtwUFF0bDdHdjcyN3FHaURxaEtqOFZ1SG1PSEN3WWg0NnFnL0Nh?=
 =?utf-8?B?SXYwOFlNN0c5M2pRVVA0cExxNnhqWGVSelU3U1B5aS9EcjUwNTFjZmpGdVVT?=
 =?utf-8?B?QWp4RjFQdERnSmdickhjRTZWUzZrVG9FSk1tWldtTUdVWVZFVWFxa2c0ckZP?=
 =?utf-8?B?akNXQkNhT1p4NXc5alJWMWxZU1hUY0xGbmxrR3J3ZUd2QjVveGNSa3BQVEtH?=
 =?utf-8?B?VnluTlFEcDNQQjUvbnRqQVlrZHhocVhCZnNyTlpSV25PVUdGQWNkRWNiMmow?=
 =?utf-8?B?RzRxNWNtb1dnVUExUDNsOUJlV1ZWRjh2VU5LNXUvTVpmb2FobmRmZFQzYXFK?=
 =?utf-8?B?K0piYWxVSXBlcFA2c0RBd1dFTEN1U2E4dWZZbUxpaENRZFB6VGtrY1BPeTVC?=
 =?utf-8?B?SHVHZ21oS2k2YTF4WGVJR1lqR2w3NDJKT0pCL21VRDg3NEF1L3BFL0MyeUcw?=
 =?utf-8?B?eXBQWjQyalQ2emJ6L05Cd015Q0dvekJZbXRsTEV5RGFBU0xEa2NVODV3ZzJ0?=
 =?utf-8?B?V3RBUitpWGx4RVlWL0pMdlZMUitMSHF0eElycVpNKzVETmhNVENFQWc4cjFm?=
 =?utf-8?B?TUVvNG5KV0lyL2FBUXp0YWk4MXJIa2phUFFIQndDMEhVVStpcnNSWTNGZGd3?=
 =?utf-8?B?V3ljYW95Z2VlQzJGeVdvd3JDR1ZzMDVGMXFDYXpBbVVCKzZSZlEvQTFiS2ZS?=
 =?utf-8?B?R2tWemZ4UU5rajNlYUxralN0NUNOZjZwZm9MVTdtZmxQQXFVSTdia3hvOUF2?=
 =?utf-8?B?cS9FNEw5V2VLQzZycWlPRW03M254bmNqUXYxSFIvVW5zczRSY3RVTFFrYlky?=
 =?utf-8?B?NDdlalMyYXpHajJIR1ZsUTJJdCtpd2h2SE53M0EybFhzRm1QeWVuMkdEQ09v?=
 =?utf-8?B?NEozUDFwYmJXVUIwaFJBU1NUSjBZYU1aVVYvSUJVV0l1WURDc2Iva3lXTlRr?=
 =?utf-8?B?aHV0SFZqbmloVXl3ckI0eTFoNXlBNnZNVzJQS2ZHc0NBOEVqREZTNGsvU3RS?=
 =?utf-8?B?djBIVzF6OEpIM3ZoZWY4Q3JnOXFwbHJFeHVpK3JOVm02M0JBTkVNaUQxeDBC?=
 =?utf-8?B?bjJmV0NnOTB1bjNTU3lINEk0TW90eEUrZ21qRk5rTnZKdGVPcFdZOXJ3ek5H?=
 =?utf-8?B?am1PUXA3RERJODJYUTVSUUFCbm1iYUJ0SDhLZndyNWJoSkxPSFo4Vnp4WVZq?=
 =?utf-8?B?U3E3blg0cDJmblQxQlpoRzFnZHBGK01NWDk2eUVvZDlad3NodC9qcFpsYTd0?=
 =?utf-8?B?dXd3ZVRwaE1xWWdUbVpsVU16d3ZNV3dyN2F5ZDljWDh4UUVUQ2c5NVVVNlFD?=
 =?utf-8?B?ejhic3NVcmZCM0VLTURtYm5jb21EWmZkNURUcjFlNmgySGJERFkwRDBsUmhI?=
 =?utf-8?B?TnlEWTM1S0xBWkhiUFVod25UeUE2MkFSNlhhYjhCdlp5dGFNWVVGRjNIakZ3?=
 =?utf-8?B?NlVrdHpRT1kyZDF1OTltdTd4ZysyZW1YbVNlZmY1N3JYK0NyZlJjVU9BeDJv?=
 =?utf-8?B?REJNTHFLTmYvSTBaMktnV2lGc1hpSll2eHpjTm9kUGpoTENUd2dHbmJUMURE?=
 =?utf-8?B?Rnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: softing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e84c3cb6-3b0a-4c98-5a88-08dc8a132614
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 12:36:42.7035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe3606fa-d397-4238-9997-68dcd7851f64
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I7snNeoe8NthMmkXLVy/hayl9t3NjvI5KtpYWRcU/fuAI/7YWz4v2Sj0jlq7/+qI9aoN0Tjpym7gxBbKySFpOyOS6uqjg2BN/kJqaWNEoDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2631

PiA+IHJlY2VudGx5IHdlIG1vdmVkIGZyb20gYSA0Ljkga2VybmVsIHRvIDUuNCBrZXJuZWwNCj4g
DQo+IPCfpK/vuI8NCg0KOkQNCj4gDQo+ID4gRG8geW91IGhhdmUgc29tZSBoaW50cyB3aGVyZSB0
byBsb29rIGF0IHRvIHNvbHZlIHRoZSBpc3N1ZT8NCj4gDQo+IE5vLCB3YXkgdG9vIG9sZC4NCg0K
VGhhdCdzIHdoeSB3ZSBhbHNvIHRyaWVkIGl0IHdpdGgga2VybmVsIDYuNiwgd2hlcmUgd2UgZmFj
ZWQgdGhlIHNhbWUgaXNzdWUuIFNvIEknZA0KYXBwcmVjaWF0ZSBoaW50cyBmb3Iga2VybmVsIDYu
NiAob3IgcHJvYmFibHkgbGF0ZXIpLCB0b28uIDopDQo+IA0KPiBUYWtlIGEgbG9vayBhdCBzdXBw
bGljYW50IGxvZ3MgaW4gaG93IGl0IGJlaGF2ZXMgZGlmZmVyZW50bHksIEkgZ3Vlc3MuDQo+IA0K
PiBUaGUgb25seSB0aGluZyB0aGF0IGNvbWVzIHRvIG1pbmQgaXMgdGhhdCAqbWF5YmUqIHRoZSBl
YXBvbC1vdmVyLW5sODAyMTENCj4gcGF0aCBnZXRzIHVzZWQgKGRpZmZlcmVudCBrZXJuZWxzKSBh
bmQgdGhhdCBoYXMgZGlmZmVyZW50IGJlaGF2aW91ciBpbg0KPiB3cGFfcywgYnV0IGhvbmVzdGx5
LCBubyBpZGVhLg0KDQpUaGFua3MsIHdpbGwgaGF2ZSBhIGxvb2sgdGhlcmUuDQo+DQo+IGpvaGFu
bmVzDQo=

