Return-Path: <linux-wireless+bounces-12711-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 843BC972445
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 23:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB44FB21EA6
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 21:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7C618C02F;
	Mon,  9 Sep 2024 21:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LjPa9dN5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B94189F2F;
	Mon,  9 Sep 2024 21:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725916318; cv=fail; b=Z53IZ1ZX/RLmv4dYzHEcu/3Gyy7aSmFXtehj8ILn9ORkN2RpEEs0BIWAD2rxgn++kgL9fItb1k4G5huTps9NHF2ZG6UFwIM2TlV6KEiT9jYO67JYt/cNoK/6KMLeQCM+lOeErW8xSD0ahoFrOdHSDk2Rrf8so7zpd+b/uAYZ8gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725916318; c=relaxed/simple;
	bh=8mZuVGp51DjQM2aM9fZzviMP+FHmetj5Ddx0xGcoiMM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q1xgn/w0DNiS057yc8zl7d1nb5bfiEaBQLtOR7b/byZhLzl5MaEZ8QViS565xdU6E1cc/xaeVKHzuJVOTbVrLGg5hjFVA9VOlm8qpCXkHgxs6ZS0ONO1MGnCtNkSqwPabZ/zeHZz8q2LnE8qCRGx2R2Kru8AoYvEApgu70FPHlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LjPa9dN5; arc=fail smtp.client-ip=40.107.243.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2h+YTXbB5LcWoIjdRfLKTHZeF6pPnd50lG0OdDsCFIRmIwinVL3PpfvoyGT4iMsOfwzXcuoyO4Y6BabiYzTMvizYwF287ep5NmrA9MhOPA1c1UvBRVZYheq7E3gEDH0ru31FG1nH6l8qSU0nlRwiWGi2ZexM2HDFMOtkDshcWIP4Qbv27saxtPjlF/tSvnP9kHoABLPDZJWFDkBjFSduG2Di79kWbHRtEfWXpidXFq+8PuLbjHIPgVBiVazOnUtzRsVqXwd1AYPmgNlyjbtZN43BD0Ob2Avi/ct9wxMGqOFRrZDPI6DcutsEEJ7DFfpNR4zIC0Ks2MScsxZFDrBfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mZuVGp51DjQM2aM9fZzviMP+FHmetj5Ddx0xGcoiMM=;
 b=O1IFB+GVYCZUze+Sxl4VX+E+N17UBh7aPZjp6gTIbZin72tQgNtMa40hYJ/Sto5rBdfubrsTnqHATyJ1cw/CqBRIAvkMZV4Lfoao4lmFGALxn3EMvoIh32yB61WvlEzsiep9IVs2i5ROHcIsrEArF4FDgEc+t00tTZdow0wlh58vM4PPuXSw5ZU6WgoPWL3htGymqi7dfxnv9lOCHzoF9n3nsJrbcKrrMn/CNJaTXMKQEFQ9+NT77jay1LQr5Gh/tKTq8e6qpqtChBwtDGGAv2jfxDfpSiEmdE1jCa3NJkcevm+tXdwEf76wdfBZ2SrHkhqcsYikTIgSl8imFowkiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mZuVGp51DjQM2aM9fZzviMP+FHmetj5Ddx0xGcoiMM=;
 b=LjPa9dN594i7Cc4JZrhByc+8aY8G0J5i+oL6DDtWc2TKuI0vIzRDJxlNORDKpUvwpy6okp17vclc93mJcotQoZxhitnjj0lmj9dIkEiTy1MGwv18is/LnufhCNr8gZkGcsqsd8GZdlArtOb/SyljTMnMry4a4oljfxP+0Q0RUaXVTscMJBl+1zl2XIpi3O5f6LkbWQmYFOoG6p53lVORmyfNZ+8bw9CocE9AGCd1N2hDGQ/z7dKlGdsT6dJpevIeHHDuVi1VmPvzwlPPsmMfWNZWqtpczgX+Vd/pRFp8J8BUexI47wqqR/zPrNaQC0HyxdVyXjkhmDpHzDUSGttq9w==
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by DS0PR11MB8206.namprd11.prod.outlook.com (2603:10b6:8:166::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 9 Sep
 2024 21:11:53 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::7625:e894:f3df:9ac9]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::7625:e894:f3df:9ac9%3]) with mapi id 15.20.7939.017; Mon, 9 Sep 2024
 21:11:52 +0000
From: <Ajay.Kathat@microchip.com>
To: <kvalo@kernel.org>
CC: <marex@denx.de>, <linux-wireless@vger.kernel.org>, <davem@davemloft.net>,
	<alexis.lothore@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<conor+dt@kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<krzk+dt@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<devicetree@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v4 5/5] wifi: wilc1000: Add WILC3000 support
Thread-Topic: [PATCH v4 5/5] wifi: wilc1000: Add WILC3000 support
Thread-Index: AQHa+azJa5h7B/I79U613XwevJ3iqLJPQ+i/gAB5zACAAAssyIAAPY4A
Date: Mon, 9 Sep 2024 21:11:52 +0000
Message-ID: <898e5736-9d9f-46ae-ba56-952b0cce9183@microchip.com>
References: <20240829004510.178016-1-marex@denx.de>
 <20240829004510.178016-5-marex@denx.de> <87ed5tgofh.fsf@kernel.org>
 <7205210d-8bf8-41ba-9462-38e619027a45@microchip.com>
 <87le00g2dw.fsf@kernel.org>
In-Reply-To: <87le00g2dw.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|DS0PR11MB8206:EE_
x-ms-office365-filtering-correlation-id: 06940aa8-1eb5-4159-74cf-08dcd114071a
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZCsrVElzZGp1UWFKcGFFRjgrcTB0QmRxYlpoRjh6Y0VsalVDNmk0cWRlQWlO?=
 =?utf-8?B?cTU5Wm1KcHljTjZaTlVMWHFMTkJaYjMvbTJVaXpLa0UrbkVPTGdCdmdLU3lj?=
 =?utf-8?B?T0wvZmxLbUVVUzFTd1kyUnA4aG1hSEgyUUx0NTN4UkRQbDIvWi9FTkVkZmd4?=
 =?utf-8?B?Y25lZENUelZpWFVIanNHcmdYbGphOFRoOVF6T2xUaEd6TlVjSS9nbm1rUzdy?=
 =?utf-8?B?Z2d0RXJ5Q3QvUWwwbFMrRXZuWEVMUEQxVEVobmpPalVKZUtVWjFHUTZvTElS?=
 =?utf-8?B?QnM3ZFFqVFZ6T2tHR01mRmZyUkRFRmRmandjTWlrdlQxZHMwMHdJdFoxZVdK?=
 =?utf-8?B?MktuZm5rK3ZwbGgvbHQvaCtzMDdwdzFjbGl3c0tESVR5L0ZnczBZMkM3bXM1?=
 =?utf-8?B?RU5xZlJ0MUE5ME9JemhPazBFajVJVk9zRW9tVXdxcWJpU3NDaHdVejFNV1FY?=
 =?utf-8?B?bzUvaEgyTUVsVTlNb3g0QUI0L2YxR055YVBxalZJWFdTbk4wQVBqK2Z0eFhM?=
 =?utf-8?B?Z0pVdlYwdDFBUEhSeFhSdmJ5b2RhQkZYdk9mQVlxWXQzd1h0Z2FTVkowbDND?=
 =?utf-8?B?cDk2b2NuY1YvTFRtbEpTa0lYbSszMTlWQjNrLzB5dXJYbzJTa1dCUkkwVVF2?=
 =?utf-8?B?VTVVQTF3dTZpVG5wVUZxZnJpVTFnZVZhdlFPOGQ3V1h4RHoyR1EraUV2S1dK?=
 =?utf-8?B?c2pQbHhDSnZCRFJNNS9wNGlRenFBSE5IeXZ6ZFZuR2RrSE5ERSsvRTdwVUxv?=
 =?utf-8?B?Y2V5dFVkbC9TYVBNWFNyUVcvMWlld205RnV6R09pTWRVWHY0SHU4WU1rSi93?=
 =?utf-8?B?ck5FZmIzcUd6TklpMk1NbkpyZmh1cXE2ek9YZlB5RGtsQzdWRjZVMUNROUxG?=
 =?utf-8?B?NVhuQU43ZmNlODZZejQ2dnRGNXoxRmlNRWtPRElmLzJucE5MK1ViQTdTbm0z?=
 =?utf-8?B?WlpEMEFHbjN0YVE2Q01hb3pmNWduY3B6Q2VqcnpBbmtONlhTS0tkdEErVytz?=
 =?utf-8?B?ZVAyMXYvc0J0QjVNbTFBc3JmVlZrVUNBY0Fna0xLUVFiTWpjNXpvY2pGY3M0?=
 =?utf-8?B?RERLcnBIZFAyUm5rbmI1R3N4dVpMKzUyaktLRlRwb0QzQXk0RWNpcGF6Q1dC?=
 =?utf-8?B?Y3NBdkxCbG9ndjlQU3VvMk1DNmtBam4zYStXanJWME00T1dCcjVTNDRVQVpV?=
 =?utf-8?B?eVJpRDBlYVV1OXBsQy91STREd3ZBVWU2QnQzcDkvUDdiRDRzM2dOZlh3SjFn?=
 =?utf-8?B?Y1FtYWZxeTNhVVlnOWlHd21DVjJqVUtNTmN6Q1l1U1BIVG9wNjRvam9JZ1Zx?=
 =?utf-8?B?dlpDVE52d3lQZERHRVVPMlYzMjU4K0xVU25LcTA2S28wUWJzRERlbWFNRHRn?=
 =?utf-8?B?cE1ZdmVTRk1BVHN0aEtHMzJndlBKYzlrWmVWaTNoV0Yrekh0UEVPQU9iVFYx?=
 =?utf-8?B?NEdNQlFKRkF0c1RsWk5LRDRNVkVVZnVKK1A5d2d4eTZ4czc2MXB1STlWL3gz?=
 =?utf-8?B?K01iVGcwZzM4eWpYSlROaU9TcHFQL1p4ZTIyUWxra2Fzbk5oTTZaczFJYlVs?=
 =?utf-8?B?amZkMm8rNXZCZUY4YlpzZUZtSHd1N2hDY3d3MzhMZjZwN3R0WkZyWmVVbzdQ?=
 =?utf-8?B?WjZMbFlRSGhoV0Jyd3o1aHdpb2NCR2JqeUt5dDVwOUhzMmtBTzJycjZtQlFZ?=
 =?utf-8?B?RzV2UW0yR0lNcTVVTkMrbC9lcjA0LzdlSWQ1cjN3ZllrZFJqRE5PZFZ0S2p6?=
 =?utf-8?B?Z3B3VjFFMkpBNGdJZEJDMHJhVWpnL0FyYzZWbGtRdTlQS2Yra0xub3BFZG1r?=
 =?utf-8?B?Y1Jsa2NOSVhVWmtiZUR2K0tpNVF2ZTJnRWVCdlFoY0ZhNVpqTUVRZTI1c2tH?=
 =?utf-8?B?V1YvYTBsS3NMR3VxTlBXdTdvek5ISDdTUjg4aTlSWjBlQmc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SkltOC9NREhUSTliMkQ4OTBGZnhxdzZiK2c0RjZoWFZ2cWVSNkN3UWFzYm41?=
 =?utf-8?B?UUhKVVpoT3JJOGNpQ1NQQTBUTnpQdVpQT2FqZnlFdXFNUUd2bWtwVWtXREU4?=
 =?utf-8?B?bk9zd2NxQVZZZVNHM0RZYjJXUnNJcmp0S0Vnb0tMQ3h6RVUxKzNOUFJGZXdW?=
 =?utf-8?B?dHdNTHd3eUhQVVJtejE3c2RGQUdLQXRja2ViT1VuSTRVL29EdytFUlRUZk1U?=
 =?utf-8?B?S21BZzZkM09mS0pOK0xkREtJRmN3TTFhbEtERzVVeGdqOTlNMWsvKzlTbnFj?=
 =?utf-8?B?ZE1kQXZaaHIxTnBKdXRGcEw3N3pFRURVSEVONmdXYVhJZFE5RTRqOGx4MkJ5?=
 =?utf-8?B?aDRtZ2JrQVQ5TDJZOGJGdXpyVlN6NWJ6STFtb0F1b2laa3hZVFBaVnNSTVN4?=
 =?utf-8?B?V2JURVVhOCt6cnF0NUtkZEZVRDBaTE5WTGNVVklSNHBOYmJiRnhadDRtR1or?=
 =?utf-8?B?Vklia2txRDV3TXBLV2tIOWNEOWtCYXliYW5Td2NvYlR6cWdURnlHY1d6QTdX?=
 =?utf-8?B?UE4rMzROMm1JSE84V1F3dm1HQXJFeXh4cXZiUFJodmlmaHptaTl2MW9SdE05?=
 =?utf-8?B?OHUrclNjQ3lPMzR0dzdiWWhtSm1USEMyeSs3ZGhrRTlJMXFBZHM4WXFQWk43?=
 =?utf-8?B?dXJHY0dWRDJkamFCL0xTYzFPd0NsUk4rajNsMkU2SWRlWXUxc2ZCbUJ4SmJH?=
 =?utf-8?B?VmtmYStLU01iYlcza3dWU0t3ckQxZGo0NjBlNDU3VTBVbEowdFhpenVLVVFH?=
 =?utf-8?B?a0xtdlJXQW85T2ovRExndkVLTTZITEFjSlNqWnVyUkErZzkyZTdwMTZlQXc0?=
 =?utf-8?B?ZGVBcEpqUUlrNVlzemdRQUpXcTlveGpBaW1oSGpsUStLeStUZ05yZUh1aVNu?=
 =?utf-8?B?OVE4ZzJRM2NpQUlYaGZoRkVYQ1ZsRGIrdkF0ZUQ4ZTdzYWdUa0hjcEo0SU5h?=
 =?utf-8?B?ZkxRMC9pbEcwZnhuUmgrOEhjdWIyVlJ6ZVdnQ0p2d04vTmNid1NpaE41akV4?=
 =?utf-8?B?T0N3aU9EcUZqbWJTditLUU1KZzJiMjA2MG5EZGl3YzVOQ3UwOTdVMCtxRjVW?=
 =?utf-8?B?R0lkK2ZnTlMvOGRvcTdxdDE5bE55dnpUZFJaaXhMeU1PNTBKWUdibWJMM0Zi?=
 =?utf-8?B?dXBhME93YWVxTXIzbzd2ejc5Tk9rUDIyNE1uRW5KbHhyNUZWMXcwUUJPUmVH?=
 =?utf-8?B?L2ovQUhZaHJ0SnVqczk1cWkyMkdBQk8xRFRCQkZBaWdsemQ0UzI5aURXVXFU?=
 =?utf-8?B?M29XT2JzcUZ5djM2UElGT0dNVklWd2hVMmxPOHRJVGlLczAwSXF3ZmFIVGlG?=
 =?utf-8?B?MkZTRXFKU0RVUjV0K1ZoM09iUEVaVE1QNXkxeG1EQTJoZmNMMlE5OUx2R0ln?=
 =?utf-8?B?ODVDcDQvallQb3d4ZlB3NytYRE8xbTNqL0orOGREVTZZKzRvTDBQS0wxaEJr?=
 =?utf-8?B?cWRqZVlEY0gyR21INnpiY21lMzFtdzdKQzdiNlo4MmtLeTFuNWdlVDIwMmRa?=
 =?utf-8?B?UW5Xd0M5dnk5d3N6VTliWUlRYmZlY1U3UlpUdS9jNXlhbDc3ZkZCbS9TYmdu?=
 =?utf-8?B?ZnpBU1JPVm9aL0s5Ukk1WmE5YXh0RGxXRmo0dTJHMEZEY1NkZU9PZTV4RDdR?=
 =?utf-8?B?cnNMdVE4YW9lVnpiSlVHZlVNcmR1UG1JcEdZMXVpQjZ5QU5TdnVFSmdiWHU1?=
 =?utf-8?B?anRMVmVSK01BWFhuV0grSFU0QVlNVi9ZOE9RazNHNzlnL0lvU3B2TWR6Q3dy?=
 =?utf-8?B?VVRCek1GOVFta25Oc095SytpUmMwTmJoLzRDMmlraThyNXR3L3M3VXJqdGlm?=
 =?utf-8?B?NjlxOGVYRFM3WGI1R0xhcjc2Q29ORElWd3FySDlLbTFmcGdDRW0wZXZxM2ZP?=
 =?utf-8?B?bExCb3o2Y1kzbUxoSCtocEpVUHhJNHdTRXcvdUwyeWcxb2Y1TGFITHFRYkNJ?=
 =?utf-8?B?cFNseElweHFXMzlwU2tka2FmL1lCRmROWlpxb2VuaDdWd05FdGxLZW5Tb2tm?=
 =?utf-8?B?THllaTF4L1J0SnlFOHZsUDdvb0U1cXpFNmdMZ2lEL2tsenFvR1Y1Q0I4SDA4?=
 =?utf-8?B?alBralRhaUdmS0hlRmh5d015dUNnK0thTEVvUzRsRklKYm84WXFRRjM3ZFVM?=
 =?utf-8?Q?LpV0/mLCAE0tGgadeF+SH71Pw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <923D0453D35E9D4F88D651AE95B13EFE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06940aa8-1eb5-4159-74cf-08dcd114071a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 21:11:52.8390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MNhgdwF0cclcbFttcnfdXmUbPVdbu7eBcI1gdKkLR/y6MzlipB82l3dRY8OSIXfqlGAqu+VAmpWCDsnJiR+N65xtwSrXGnGnuuUHMbnI0Z4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8206

T24gOS85LzI0IDEwOjMxLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBj
b250ZW50IGlzIHNhZmUNCj4gDQo+IDxBamF5LkthdGhhdEBtaWNyb2NoaXAuY29tPiB3cml0ZXM6
DQo+IA0KPj4gT24gOS85LzI0IDAyOjM1LCBLYWxsZSBWYWxvIHdyb3RlOg0KPj4NCj4+PiBFWFRF
Uk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+Pg0KPj4+IE1hcmVrIFZhc3V0IDxtYXJl
eEBkZW54LmRlPiB3cml0ZXM6DQo+Pj4NCj4+Pj4gRnJvbTogQWpheSBTaW5naCA8YWpheS5rYXRo
YXRAbWljcm9jaGlwLmNvbT4NCj4+Pj4NCj4+Pj4gQWRkIHN1cHBvcnQgZm9yIHRoZSBXSUxDMzAw
MCBjaGlwLiBUaGUgY2hpcCBpcyBzaW1pbGFyIHRvIFdJTEMxMDAwLA0KPj4+PiBleGNlcHQgdGhh
dCB0aGUgcmVnaXN0ZXIgbGF5b3V0IGlzIHNsaWdodGx5IGRpZmZlcmVudCBhbmQgaXQgZG9lcw0K
Pj4+PiBub3Qgc3VwcG9ydCBXUEEzL1NBRS4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogQWph
eSBTaW5naCA8YWpheS5rYXRoYXRAbWljcm9jaGlwLmNvbT4NCj4+Pj4gU2lnbmVkLW9mZi1ieTog
TWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQo+Pj4NCj4+PiBbLi4uXQ0KPj4+DQo+Pj4+IC0t
LSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9jZmc4MDIxMS5jDQo+
Pj4+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9jZmc4MDIx
MS5jDQo+Pj4+IEBAIC0zMTMsNiArMzEzLDEzIEBAIHN0YXRpYyBpbnQgY29ubmVjdChzdHJ1Y3Qg
d2lwaHkgKndpcGh5LCBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LA0KPj4+Pg0KPj4+PiAgICAgICB2
aWYtPmNvbm5lY3RpbmcgPSB0cnVlOw0KPj4+Pg0KPj4+PiArICAgICBpZiAoc21lLT5hdXRoX3R5
cGUgPT0gTkw4MDIxMV9BVVRIVFlQRV9TQUUgJiYNCj4+Pj4gKyAgICAgICAgIGlzX3dpbGMzMDAw
KHZpZi0+d2lsYy0+Y2hpcGlkKSkgew0KPj4+PiArICAgICAgICAgICAgIG5ldGRldl9lcnIoZGV2
LCAiV0lMQzMwMDA6IFdQQTMgbm90IHN1cHBvcnRlZFxuIik7DQo+Pj4+ICsgICAgICAgICAgICAg
cmV0ID0gLUVPUE5PVFNVUFA7DQo+Pj4+ICsgICAgICAgICAgICAgZ290byBvdXRfZXJyb3I7DQo+
Pj4+ICsgICAgIH0NCj4+Pg0KPj4+IFRoaXMgbG9va3Mgd3JvbmcuIElmIHdpbGMzMDAwIGRvZXNu
J3Qgc3VwcG9ydCBTQUUgeW91IHNob3VsZG4ndA0KPj4+IGFkdmVydGlzZSBOTDgwMjExX0ZFQVRV
UkVfU0FFIHRvIHVzZXIgc3BhY2UuIEkgdGhpbmsgdGhlIGNoZWNrIGZvcg0KPj4+IHdpbGMzMDAw
IHNob3VsZCBiZSBpbiB3aWxjX2NyZWF0ZV93aXBoeSgpOg0KPj4+DQo+Pg0KPj4gQWN0dWFsbHks
IHRoZSBjaGlwIElEIGlzIG5vdCBhdmFpbGFibGUgd2hlbiB3aWxjX2NyZWF0ZV93aXBoeSgpIGlz
IGNhbGxlZCBidXQNCj4+IGlzIHNldCBsYXRlciBpbiB0aGUgZGV2aWNlIHByb2JlIGZ1bmN0aW9u
LiBUaGVyZWZvcmUsIGFkZGluZyB0aGUNCj4+ICdpc193aWxjMzAwMCh2aWYtPndpbGMtPmNoaXBp
ZCknIGNvbmRpdGlvbiBtYXkgbm90IHdvcmsgYXMgZXhwZWN0ZWQuDQo+PiBBbHNvLCBJIHRoaW5r
IHRoZXJlIGlzIG5vIEFQSSB0byBjaGFuZ2UgIndpcGh5LT5mZWF0dXJlcyIgYWZ0ZXIgd2lwaHkg
aXMNCj4+IHJlZ2lzdGVyZWQgdG8gc2V0IGl0IGxhdGVyIHdoZW4gY2hpcCBJRCBpbmZvcm1hdGlv
biBpcyBhdmFpbGFibGUuDQo+IA0KPiBTb3VuZHMgbGlrZSB0aGUgZHJpdmVyIGlzIGRvaW5nIHNv
bWV0aGluZyBmdW5reSBpbiB0aGUgcmVnaXN0cmF0aW9uLCB0aGUNCj4gaWRlYSBpcyB0aGF0IHRo
ZSBkZXZpY2UgY2FwYWJpbGl0aWVzIGFyZSBwcm9iZWQgYmVmb3JlIGNhbGxpbmcNCj4gd2lwaHlf
cmVnaXN0ZXIoKS4NCj4gDQoNCkFncmVlLCB0aGlzIGFwcHJvYWNoIHdpbGwgY29uZmlndXJlIHRo
ZSB3aXBoeSBiYXNlZCBvbiBjb25uZWN0ZWQgZGV2aWNlLg0KDQo+PiBEb2VzIGl0IG1ha2Ugc2Vu
c2UgdG8gYWRkIGEgbW9kdWxlIHBhcmFtZXRlciBmb3IgZGV2aWNlIHR5cGUod2lsYzEwMDAgb3IN
Cj4+IHdpbGMzMDAwKSB0byBhZGRyZXNzIGRldmljZS1zcGVjaWZpYyBmZWF0dXJpemF0aW9uLg0K
PiANCj4gV2UgZG9uJ3QgZG8gaGFja3MgbGlrZSB0aGF0IGluIHVwc3RyZWFtLCBpdCdzIGV4cGVj
dGVkIHRoYXQgdGhlIGRyaXZlcg0KPiBkb2VzIHRoaXMgYWxsIGF1dG9tYXRpY2FsbHkuDQoNCk1h
cmVrIGhhcyBhbHJlYWR5IHN1Ym1pdHRlZCB0aGUgcGF0Y2ggdG8gZGVsYXkgY2FsbGluZyB3aXBo
eV9yZWdpc3RlcigpIHNvIGl0DQpzaG91bGQgd29yayBhdCBydW4gdGltZSBmb3IgYm90aCB0aGUg
ZGV2aWNlcy4NCkknbSBqdXN0IGN1cmlvdXMgdG8ga25vdyBmb3Igd2hpY2ggc2NlbmFyaW8gdGhl
IG1vZHVsZSBwYXJhbWV0ZXJzIHNob3VsZCBiZQ0KdXNlZC4gQ2FuIGl0IGJlIHVzZWQgZm9yIGVu
YWJsaW5nIG9yIGRpc2FibGluZyBhbnkgZmVhdHVyZSwgY29uZmlndXJpbmcgYW55DQpwYXJhbWV0
ZXJzLCBpbnN0ZWFkIG9mIGNvbXBsZXRlIGRldmljZS1zcGVjaWZpYyBmZWF0dXJpemF0aW9uLg0K
DQoNClJlZ2FyZHMsDQpBamF5DQo=

