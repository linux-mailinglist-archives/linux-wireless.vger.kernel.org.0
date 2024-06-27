Return-Path: <linux-wireless+bounces-9645-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE736919F54
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 08:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BB9A1F2288F
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 06:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790B928DCC;
	Thu, 27 Jun 2024 06:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KerIsIXp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2082.outbound.protection.outlook.com [40.107.103.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822691CD1B;
	Thu, 27 Jun 2024 06:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719470040; cv=fail; b=dRzEq4ZHGY/FAwixmUQK2y8RzD/AtQz4/BRJ/fgkUqFgpB5w3Up9nBMv29rTfZm5PZCQzM1bX52eEbtaT+U1N7KwZ1JD1gs9QHSPRq0hXat7N7Ue1Mg3ucJvTo3oAyCr/hW+4iNs/ssRlxoaem3+YQSoa77mhOThoiNF7lcSIJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719470040; c=relaxed/simple;
	bh=0JYRX3q18d/m43o3hBCd7RNd895RXkvya+y9wtBwUJ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oid6o4JjNV79+3jaQiAVSONbSpg/5MjcojLGuta6ZMPJgh5yAq8MOQD0ei5A6gZnqoA2++8BnMZpl59GutKppTvvfyDQrHa6S0OiNTW8n4CzVD8gOOtladkKKW9IaFl0LPQHpDnRgKiGqCUIvVK/aH0wZtdP3VcUm4A5mw7U1vU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=KerIsIXp; arc=fail smtp.client-ip=40.107.103.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oq9ftO2IizssR8Mt/wLaMTjLngowBJsDUa2S0dXhmYuDdlg+XqDAlk8SfXj6sHBg8eoIDkovKMlUi99OSJFe+iKH7+MtQKi3u3lDCBxMh1svRl/enC7nMBKFz+w6Iib3gnHH5tfZ/25cSdabyRbfg6NKAdNp4LeT2G3IoldRSZ3b7ZXaKRdc30OMWNcxWiyZB8fu/d2kURNu85it7e/tj5H1Sg2CTuNhbEAmwpSYU6lK2v/qndJVYyXCA1oBMkHd9GJQDBCTGuzQz9KKTJYIEedHiOv+N03DefSJx5BbcedAnmPHpGTZJ/T4S1TWz/wJ9hLEJAEuiVDmEy67ojNbsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JYRX3q18d/m43o3hBCd7RNd895RXkvya+y9wtBwUJ0=;
 b=NDvdJBiAkBA8VmnFBTszczoSKerCLcXtHA3e8XZRnphZjLFtX+Kbsdmoc9sAbitrffsmaGPa/aMPaCZZIv7KMNnLz4ww9IRtpiOlacRarfrSJMqqtDVJJGE6+m2d+4dlodmZu/IQfCRYYRBvC0drQqp9NxOBdB8Psx7SNwuRMTFQzuvSMTXAWCcfNlDOtApf2RAaVxyDwX4QJSXt9lgidS9rdPBgF7Rg2vxs3DxiKBT4ffY9Ito2oZXYQ3mKf/NlHv8xnh5cHbKPacEOumR/dZ1ZyHajtmiFXIyflb75x8gsr2yyhAtVYgVISlCo3jiRMS3sPpfT6nwDOxZ9DV58pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JYRX3q18d/m43o3hBCd7RNd895RXkvya+y9wtBwUJ0=;
 b=KerIsIXp1gyLlskiH+snn5VvEn1XFxz06SMDlJa2m5hAUAkM9p6FJHXJC6prOLXtMuWHWaOQiHgRVGfjccdiuEcSNWhcOcKQXQRXOv5RjMXnruwDL9VFgDM2d3/wsDc8V+xHh66X6aESRWlGD4pDuPzObgjK018XagczTIJRmlc=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PA4PR04MB7583.eurprd04.prod.outlook.com (2603:10a6:102:e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 06:33:55 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 06:33:55 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: "Nemanov, Michael" <michael.nemanov@ti.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "kvalo@kernel.org"
	<kvalo@kernel.org>, "francesco@dolcini.it" <francesco@dolcini.it>, Pete Hsieh
	<tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] [PATCH 26/43] wifi: nxpwifi: add sdio.c
Thread-Topic: [EXT] [PATCH 26/43] wifi: nxpwifi: add sdio.c
Thread-Index: AQHayFsIIFr0yynMMUaB/Cka9KIrSbHbJxVA
Date: Thu, 27 Jun 2024 06:33:55 +0000
Message-ID:
 <PA4PR04MB9638034873901A39E4508757D1D72@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240621075208.513497-1-yu-hao.lin@nxp.com>
 <20240621075208.513497-27-yu-hao.lin@nxp.com>
 <16de364e-bd80-4674-9125-74c33e551961@ti.com>
 <PA4PR04MB963897BF79B6F05700263A7CD1D72@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <df34e044-8c51-4ced-8381-cbf424711e2f@ti.com>
In-Reply-To: <df34e044-8c51-4ced-8381-cbf424711e2f@ti.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PA4PR04MB7583:EE_
x-ms-office365-filtering-correlation-id: 14016008-9e79-488b-97f9-08dc96731e45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Wm9BaEUvTzlUWlRVTkRPenA3enVkT2VUWXRoV0lTcHhmaDhyRURyK2p4Zy9R?=
 =?utf-8?B?SDBiVkFPWG5mN2lBOXBWSW05SVVWbmZqRGd0clozR3dSS3B5QndHdXFPNHE2?=
 =?utf-8?B?cFcwVThVREVaMUZFeVhHdXJNZFJrNVllT0dVZHk1aFY1Z3JGdFluRTJYYjNK?=
 =?utf-8?B?bHlSc2ZVR3NwUnh4UTBKK1NwNllyUmdDaWIrQmpUS3hJbnVjZTRpWWh1S2U4?=
 =?utf-8?B?VHg5WVNJV09ONnZDNkgvZjI2T0NnRmdlNHhQTHRRbFhxOURZYTRndnQrajky?=
 =?utf-8?B?dythSTRRMmgzcXZVeElkWlBlUVYwbGpNUGlaMTBGYWd1dlV5eG5lT3FmcEJP?=
 =?utf-8?B?NHcrSUxwNDllZ0kwdFZlN01BN1prUVlVRTlNTFMyYXF2UUlkbGU0TTZnNHpl?=
 =?utf-8?B?anBROExKQ1ZBRUpVYXN0UTFpMDMyNEllM3hYWkI0MzViU1RCMUdOOVVVaE9Y?=
 =?utf-8?B?VExPZENlN1dKMWw3STEvWEtONE9Ga0ZCb1FlR09oZXlOZWxGeDdTbTV5bHZV?=
 =?utf-8?B?Z1FicEFzc3I3QW5VbG01K0Z3NTJsVTA2V0kwWW05OUczVkpJcktjcXFEREhV?=
 =?utf-8?B?eU9wTTRKbTV2VGVmYW9FczAwd1VBTFpKemc0akIvV014SWZrc0pJSGlEQldm?=
 =?utf-8?B?TFJJQXN2T0tKWE4wNk9aZHJ3NVpIZXJnMmZJWk04R0JaQlcyd1RSdzQ2RWZp?=
 =?utf-8?B?UGlBRExQNWFRRGdKRzlDUS84ajVCWTROMGJDOXRUWkVpWWRnTENDRmFtTmkv?=
 =?utf-8?B?cFZxR2FJT0laanlCUFdBY1ptdVVGRzdTMHdKN1JPa29HdlQ5UnZpTTNCQmla?=
 =?utf-8?B?Uzk0SEt1T0dZeFZ0WU9wNUhJbmtMd3JUak1lN2cxZy9oTi9GeEN5b2pYVHpx?=
 =?utf-8?B?KzhWOWQvMDZROXhoTU40K2J1Rkp1Y0ZCdWxDSWJYSVhhRk5WSHhOSCtGTE5Q?=
 =?utf-8?B?bE5GYUZpbkNVM29abHdCTUJDYjZ4Qk0xYkIvSUFyUmtZMkJobGNpT3BJdjVS?=
 =?utf-8?B?d0lsR2djcFA5SnBtYmdxejJZS0JGVDBkbUI4VEhRWnZJNTZMSm8wTHVVeTZy?=
 =?utf-8?B?TUlFMmVUOGJhc2RvNlNIWVFSRldyTXVwWVI4VXVUakFBeW1yR0IxRmNDdmZV?=
 =?utf-8?B?bFpHVStCSmxFNmZFWHQrTWVWSHhVVWlYWmNrdU9FbHp1S1hUZTVsQWd0K0gx?=
 =?utf-8?B?RnQ5LzVtRmRiMWVUU09iNnlRbGJBekxDbVFZTVIzV2NiWFBUQlh4TmJXWFNW?=
 =?utf-8?B?dDZUeXExZ1l4MURVUDZ0UVJhZVBvVkdySGF3L0w0S29kV2hUejUvbitWSUJv?=
 =?utf-8?B?bEdJUnUvNkJyUCtVb09FTVBvdDVzd0RRU0FobjNsOUxKenZSN2Vub0g0RkQ4?=
 =?utf-8?B?bjY0emo5MFpxeG0rYmQzaFg0MFh6U0FrQko5eVVYdWxFMnAzdjBaWHFiZEVT?=
 =?utf-8?B?blVPaERFRGRwdENOV3lLZzYrUWwrZTFqY25VNEh6cmZxRFU5TnYzY2gxUjAz?=
 =?utf-8?B?bzRHMUJiYzREakhmcmIxOWVQRG44VGkyWHRIKzhNeWRibEFGOVN3QnMrZ0Iy?=
 =?utf-8?B?STZzaXErOFhmU29STE8xSUxVZitGK0dlYkpKOGRjMVlyZHl6b1RiNmgxcVJ1?=
 =?utf-8?B?c3ZxVE94MU5WSWJuNXl4RlNsM1BMWVZsYnVjK215YlRBV01EcFRBL2ZQamhP?=
 =?utf-8?B?MVhtbzBHei9ZN2xXN0F3OWZIN3NMbDhIaS9tSVZma3E2TnpWcVNNdmNKVDJx?=
 =?utf-8?B?dUZxeUJRQlhZQStnRkJsRU5pRVdFOEZjc05TUDhsMHZwMnVBc204UXViZFhM?=
 =?utf-8?B?SkR5Z2hFeHJuY3VvR1lHanZEbzk0eHJkWCtYOER0WndOd25WdkNNTHhoR05G?=
 =?utf-8?B?YUcxZ2YvK3RIako0NHJadHpFNFArMlI3Z1lMczh6WHdqV3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RmpNZklNbXJaTzl5VXB6eThZNkNpa1FBeXkxdUVJQWJOcWUycDhXYUt0M3Bx?=
 =?utf-8?B?UXJpNEJ5WmpLRllmN3B3a3FtQkE1ZTZlQzJWa0pjNXZSTldHbDNMS2duLzha?=
 =?utf-8?B?YWZMY0c2VlFGVHRvMW5WMWtVL3k1Q2prOW10aWllelJDQzl4NXVpRlhKb0JP?=
 =?utf-8?B?WlBJS1ZZeWlLVWxPbUMvYzIrWGhvYTRuWlZ4WnltZVVjMXJzZVlyN1FuUllD?=
 =?utf-8?B?RGhCdk9hc21RclpmTnE2eGp4aVMxTEZiWFhJQTRVQXN3NE1nVGVGQzRzUHdF?=
 =?utf-8?B?YWZKUGVGMGtaMS9CeUgxTXFHcTlVVHBUNHU4aURhemxvUWc4L3VXenNweFpT?=
 =?utf-8?B?dXNJNmU3c2xqQlpqN2lwU3kwaXFBUnRqNUZJVGlRczRLSzBVN2J4ZkNOa3I5?=
 =?utf-8?B?K1hqdzMvTVEzeFplNTBEd3F6NDZVY3FYc00vM0Z4ODlJTCsvbGloRzhqQmhI?=
 =?utf-8?B?UEE0ZU05Tk5kTVhmSWZHSHVjYkd0V0dXOVRSU3JVVFhhUEVDa2gzcEwwTzRx?=
 =?utf-8?B?Ujd1SnlwUmxoMU81Y0JaTzJDNmNvUlJZaWNWc05ZVE14a2hJS3VEWXdQMFZ6?=
 =?utf-8?B?NlFwS2JsbkMvTmpoUDExN2JzbzN3NnRQWGVYSEJLa1RjVVZvUTg3RUE1b0Uy?=
 =?utf-8?B?eDdSZEZxeE9oTXlEYUxYenVOUDdTaUpwM21mYlF0b25JejdJWVlvSnlNNlFt?=
 =?utf-8?B?NWhFZnJqQTNORG1RYWFrZ282dVo0MmV2bnROUWQ1ci94YjdoejlSd29CbjNL?=
 =?utf-8?B?dnUwbGkvUGtKd21tTktsa1pyOG1qN0dPMzVrMm03OFk3V043WWJJRWRUd3Uv?=
 =?utf-8?B?RURMUUt6dG9adTVCd3Z2TWZoVjI3ZXNSaERlbSt3NHB2RVlvSkFndE9PblRL?=
 =?utf-8?B?czBzOW01dnRFaHNBTWZWTERKL0Z3MDlNNFNOM1RKcExQL1RVeW90T3ZjWElo?=
 =?utf-8?B?ZUt2MUwrYnd0L2NNbjdmdll1OVJsOU1jY2luUnNMVjhhdXJqenR4bVQ1VTQw?=
 =?utf-8?B?eHMvTFZ1OVpJNDVBQ3FFZEZ1SnpBTEU3OERqQ1VvUnp4NzcxVEJ0VG1Eckcr?=
 =?utf-8?B?Tm5KNCtjSXlRN25BSTUyREtqTE5aUitORnkraUorSXhiaENEWnBtb2FNOGh0?=
 =?utf-8?B?WkUyUVlUYXlWTlhhZ1doU29BWW9Jd21YQWNyRGxxZjZIR0dkajg5Smk0czZa?=
 =?utf-8?B?bERJOENTM3NTRHE3RVZVK0U1Tllod3FvTVMrMlN4czdyTGFucHBLQStIS3pM?=
 =?utf-8?B?WHBwT2hJZ01jZXc1RkUvc21yMHl2Zk4xYWh3VkhmOEZsWDAvb1NySnhETUJi?=
 =?utf-8?B?RC9DRVpvVTBnN0hKQk9tT2lhS0t3L0RUNE9pY2d6MzFBQmtkT3gzemRpRWxE?=
 =?utf-8?B?WlBhMHlDaXk0eU5GNFZqSHBLanlGWUd4elowOUJZOWpDNllZdW9HWW5nRDR3?=
 =?utf-8?B?L1pOWld1SWhpSDJEUzJQQ1I2QlhwNENOOFN5bmJFVTc4TEROUHB1QzV0aDFZ?=
 =?utf-8?B?aytIczV6TGxJUDZ2MWhmN3hDMUlmV1lHdDZzckV3Rys0ck1kaW55cmVGZUc3?=
 =?utf-8?B?WGtackhYTVBIRkhaNUxwdkRKN01ybC9GL1k1ZDB2V0pheHJCMld3UnUvUEV5?=
 =?utf-8?B?NjFkZ0ZyTEZXYVR2VFpVUm1GbWRjblhZa2o1b1lCTHhOR1NSdCsvUVNlKzhv?=
 =?utf-8?B?Y21LQVR6MmdKQ1ZWYnVTTnF6WFM4Y0VhM29BdDVlaFZqZml2SGR2V2NpTzdK?=
 =?utf-8?B?VEJ3c0hRYXRaNXNBVzVLR0JpMEhURnJiRk1DQ0NzSXVlcGdiZVdvbUpYQ2pZ?=
 =?utf-8?B?UVRSWUxJN1RweHQ3SmxmK2JGVE42a1doNW5HaU1qQnJkVmJUOEtRK2NIUGp6?=
 =?utf-8?B?Qm5OUVQxajkrTnB6eG1wZTlFS3oxY2VlaTYrSkNqaDBnek9Lc0NPZjBwYVZv?=
 =?utf-8?B?TTRHK0R0bzhVTG40bHUxbWgzNkNFV1Vva3hMa2xHZjd6d1Q4enJJd1Z1NFhG?=
 =?utf-8?B?VEUyK2JzZFlhazl1UitZVWhVbjhSeHRoSlNaODZuNWpmT241UjQzMFpWVWE4?=
 =?utf-8?B?Z3VHcGlpUmlGUURuU2FTZXpwdllNbU02QnhieTNsbm55WVZwemFlVVpsaFds?=
 =?utf-8?Q?yCj5VEEltggNED4IsSQHHU0nR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14016008-9e79-488b-97f9-08dc96731e45
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 06:33:55.2625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ltwLUvW4Fth042hqFtLQsbheCncRUozGk/cGvqXSVPUVIoS8a4o4fxAdkLgodmNWr69G7gHxm2bpZ8UvsJYm7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7583

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmVtYW5vdiwgTWljaGFl
bCA8bWljaGFlbC5uZW1hbm92QHRpLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEp1bmUgMjcsIDIw
MjQgMjoyNyBQTQ0KPiBUbzogRGF2aWQgTGluIDx5dS1oYW8ubGluQG54cC5jb20+OyBsaW51eC13
aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IGJyaWFubm9ycmlzQGNocm9taXVtLm9yZzsNCj4ga3ZhbG9Aa2VybmVsLm9yZzsgZnJhbmNl
c2NvQGRvbGNpbmkuaXQ7IFBldGUgSHNpZWgNCj4gPHRzdW5nLWhzaWVuLmhzaWVoQG54cC5jb20+
DQo+IFN1YmplY3Q6IFtFWFRdIFtQQVRDSCAyNi80M10gd2lmaTogbnhwd2lmaTogYWRkIHNkaW8u
Yw0KPiANCj4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRha2Ug
Y2FyZSB3aGVuIGNsaWNraW5nIGxpbmtzIG9yDQo+IG9wZW5pbmcgYXR0YWNobWVudHMuIFdoZW4g
aW4gZG91YnQsIHJlcG9ydCB0aGUgbWVzc2FnZSB1c2luZyB0aGUgJ1JlcG9ydA0KPiB0aGlzIGVt
YWlsJyBidXR0b24NCj4gDQo+IA0KPiBPbiA2LzI3LzIwMjQgNjozNyBBTSwgRGF2aWQgTGluIHdy
b3RlOg0KPiA+Pg0KPiA+PiBPbiA2LzIxLzIwMjQgMTA6NTEgQU0sIERhdmlkIExpbiB3cm90ZToN
Cj4gPj4gLi4uDQo+ID4+PiArDQo+ID4+PiArLyogVGhpcyBmdW5jdGlvbiB1bnJlZ2lzdGVycyB0
aGUgU0RJTyBkZXZpY2UuDQo+ID4+PiArICoNCj4gPj4+ICsgKiBUaGUgU0RJTyBJUlEgaXMgcmVs
ZWFzZWQsIHRoZSBmdW5jdGlvbiBpcyBkaXNhYmxlZCBhbmQgZHJpdmVyDQo+ID4+PiArICogZGF0
YSBpcyBzZXQgdG8gbnVsbC4NCj4gPj4+ICsgKi8NCj4gPj4+ICtzdGF0aWMgdm9pZA0KPiA+Pj4g
K254cHdpZmlfdW5yZWdpc3Rlcl9kZXYoc3RydWN0IG54cHdpZmlfYWRhcHRlciAqYWRhcHRlcikg
ew0KPiA+Pj4gKyAgICAgc3RydWN0IHNkaW9fbW1jX2NhcmQgKmNhcmQgPSBhZGFwdGVyLT5jYXJk
Ow0KPiA+Pj4gKw0KPiA+Pj4gKyAgICAgaWYgKGFkYXB0ZXItPmNhcmQpIHsNCj4gPj4+ICsgICAg
ICAgICAgICAgY2FyZC0+YWRhcHRlciA9IE5VTEw7DQo+ID4+PiArICAgICAgICAgICAgIHNkaW9f
Y2xhaW1faG9zdChjYXJkLT5mdW5jKTsNCj4gPj4+ICsgICAgICAgICAgICAgc2Rpb19kaXNhYmxl
X2Z1bmMoY2FyZC0+ZnVuYyk7DQo+ID4+PiArICAgICAgICAgICAgIHNkaW9fcmVsZWFzZV9ob3N0
KGNhcmQtPmZ1bmMpOw0KPiA+Pj4gKyAgICAgfQ0KPiA+Pj4gK30NCj4gPj4NCj4gPj4gTWlzc2lu
ZyBjYWxsIHRvIHNkaW9fcmVsZWFzZV9pcnEoKSA/DQo+ID4+DQo+ID4+IE1pY2hhZWwuDQo+ID4N
Cj4gPiBzZGlvX3JlbGVhc2VfaXJxKCkgaXMgY2FsbGVkIGJ5IG54cHdpZmlfc2Rpb19kaXNhYmxl
X2hvc3RfaW50KCkuDQo+ID4NCj4gPiBEYXZpZA0KPiANCj4gUmlnaHQsIEkgc2VlIHlvdSBjYWxs
aW5nIGl0IGZyb20gbnhwd2lmaV91bmluaXRfc3coKS4gTWF5YmUganVzdCBhbGlnbiB0aGUNCj4g
Y29tbWVudCB0aGVuLg0KPiANCj4gTWljaGFlbC4NCg0KSSB3aWxsIG1vZGlmeSB0aGUgY29tbWVu
dC4NCg0KVGhhbmtzLA0KRGF2aWQNCg==

