Return-Path: <linux-wireless+bounces-35985-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oC97NxTa+mnYTQMAu9opvQ
	(envelope-from <linux-wireless+bounces-35985-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 08:05:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 880944D670E
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 08:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA783300A386
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 06:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CE03016F2;
	Wed,  6 May 2026 06:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UyihYyK8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339E01F94F;
	Wed,  6 May 2026 06:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778047503; cv=fail; b=sgXCt0h095jPrvzyACqXcXCSblAm4xZ/X2KiCPazxNvcekx9qEprsF9p96hUPhOPGH43JirbzgatAT3qDOHlenzOblzuB/5TxceL/SqZH/Y3YachZd8OslnjAEP8oZiOYQgJMk+zajCOntq/sp5hUnIqf+4t7AeRfhNWqAgPyiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778047503; c=relaxed/simple;
	bh=GzAbMlLj/SJ5VJwCyJW0YnHZjWeKgF9tiqeED14RR4Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mmyzOxSilLH/wUxpi9QQ2EYHD6tNLlaB+V6UGuwM5/QA1GWV4QRzHkmLEC1QtgF5IRpntqpxTQEEGRASMKJxoz+HLbw2zAWcjg62sQFBJYWlFNbons1k1pElMgiYjsgPbJQpmL62dA8TuHPif6o6KrJ4wxBiIclzTaYilk03zp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UyihYyK8; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778047501; x=1809583501;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GzAbMlLj/SJ5VJwCyJW0YnHZjWeKgF9tiqeED14RR4Y=;
  b=UyihYyK8GB6nrq6NpIDsXe84bNbscYpcL2fpDDRm0q2ZiQZW2e4uK24E
   ETbQjOtAbQLVVrQXm6JNrfUEA0IowEfMOJ1VGaZ6gp3D/KtTIBXpRMHx/
   I+WDNOH6ZrrUjYedGYEfSdtB6PsWVP61Psddy79FbO727BjKqXG3uR0q7
   NgI5ynVWwE4dsdQkUCcYzXhf2H7j6fHvLhGeyQdL7yaUCkHci+s6FnWFx
   e7dM7kJL8HAxaZ0G23d3QJqr4z+0yu9y+Uu1BpZKMJyRojblxQ802ZxVR
   j9KXF1LnZZtVS2JyVqjSpmHFYXVTBL1Bq+RDZSdnxaFjMgNZgAeeFngXG
   w==;
X-CSE-ConnectionGUID: kbJyDpMITiy5+scQl73SGw==
X-CSE-MsgGUID: kYryDAGeQRmjRd2bM8IJLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="90041138"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="90041138"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 23:05:00 -0700
X-CSE-ConnectionGUID: Dsqkdx8lQ16c+sjMyNlRUw==
X-CSE-MsgGUID: S8XNI74mRbiK/mJ+eh1z6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="235906930"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 23:04:53 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 23:04:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 23:04:50 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.14) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 23:04:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fz6LIVMZ4lavqjr+rVCwkJK5gnvtAeX6zbmBh9g4L1jgrQPUj+7tadPR6UDpkEjxgWs8WxdiAKZMcFGqVmgQukrFIzTEYVG4SheaF+B5gHBfTYRBLgDrMOv7hyV5cUYr7jc50mSDfQEXQKuccza8wY08gEv5ygDPIGpczHTjxmppNg4WGkJ2juctabSiJhSFVuPAy6+492HGbE3nWtxQL0lVFguos1CxioNt6bUY0yRLuDceICQhpfjUIAwgqSbMNnwEi00sqboMeT6Eomq7uh4jTvJlHdrgtAKcvTZHzBzUyY+jCD5Kr83GKf8vypk22QQmnPbaKpY1dNYErWrKzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gz1HZ+EVZeonG3LIhX6FUqqkF2YUXEJS5a5BJlylTPE=;
 b=L125E/pXtEf8AeB4coplUHDDeSruwi7NxcD275agqx3wixcnwIoZCvC7Z9NWd2uM0GxehHapw0XvPdbWY/qhK1UQrwJinP+jUyOtazUdm2LChXHuGS7AP5IwqjeVaUt/n7JH0aMd/ftBzmuLLbz02nclZR7WcJhzCzabXoyEi1C5UiMKsWamB5Cc7aFWOkL4WMYHVuNpg9wSTNi3GHHGrtOOCP9X60wTyX0tNlBufWRuIsPQfW3ji6cI8QN+ppIShUqFbuTOlCezdulVrxOjEZw9Rnd3Dk132mX+VzXuXEJMM0hWWLI2Osq2oN94aniZ8Ah9trly5E4IpEVOHRxGnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by MN0PR11MB6135.namprd11.prod.outlook.com (2603:10b6:208:3c9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 06:04:42 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 06:04:42 +0000
Message-ID: <e9bc0e10-9473-4308-80a8-f7830112cc69@intel.com>
Date: Wed, 6 May 2026 09:04:36 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mmc: sdhci-esdhc-imx: consolidate imx25/35 data
 and add Kingston CID
To: =?UTF-8?Q?Adri=C3=A1n_Garc=C3=ADa_Casado?=
	<adriangarciacasado42@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	Andreas Hindborg <a.hindborg@kernel.org>, Jens Axboe <axboe@kernel.dk>, "Miri
 Korenblit" <miriam.rachel.korenblit@intel.com>
CC: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Haibo Chen
	<haibo.chen@nxp.com>, Frank Li <Frank.Li@nxp.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, Boqun Feng <boqun@kernel.org>,
	<linux-mmc@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-block@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, =?UTF-8?Q?Adri=C3=A1n_Garc=C3=ADa_Casado?=
	<adriangarciacicuelo@gmail.com>
References: <20260315172746.270734-1-adriangarciacasado42@gmail.com>
 <20260315172746.270734-4-adriangarciacasado42@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260315172746.270734-4-adriangarciacasado42@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0159.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::16) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|MN0PR11MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: a524fa9a-cc78-4d1d-744f-08deab355d7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: XQHb0DRXXU78bDteGxTgidAbY3tfWxk1768xpa6/Q99CyVA13LT5OroMqccsjuBV5N9jPC527dLjUSXnq+dcmA9ACS+lbjXypzR31FQMa3e+YQzPkneAySKHot8R0Ip4wie6lMb2r0nej7nsoEQYr7FoquNvDHNysmWEN7B2QvnC5nQK42z83vOhO2gB6T/KJeSGbOBGBk0AnI0XEG6IOPm8lGJ2TzRcZbsBitjciCXOQwv1WzfRSVZM8MV1lAg5W4KIeXf72p0L0QGJ0UHYKZMzniqRS7kgycKCEtlxRHcoyGo0zue9Tehcr8NcSDiPqYRDOZfFGpcP4/a/rbAJvg73N8R+mLYoXksDz1tmk4drTN3wA8yIiFQ9Oh6BuKV1aEzyyccaKaHmvgGeqSLzf9Hj0+zb4+4nctkUvB8S4zfyyuWDQNDJZCzSVPjdGmvQ53fD2ojySk6B07QlVc5b7HHNhWIebKoWbq9M8akGi6gdWf++W6YzZ1GYGsIlbtkLSkFHGPlURt+n8B6xB+TDgJj44zVMZUMCU7tISnxUsDCgfrme2ZPu/rv066amCRhCenFJjewLgvlBRKHWp1zQAr6NfL6sgKuWWNpkmQ4reuUzV9r7AgDD1CkXFy1CaQU3l55bxNKtou0P740bfzQTTSwup+GSrBC7XH1eyZg/zaKZzqSLDSYNGoMnneCmpow1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGhMOGNNTmdzM1R0VElESWRycEwvaTRkL0RXeGhkOTBVY2hDaENxUzN0b09E?=
 =?utf-8?B?eVZJWGdicFFyb05GSnBBR09odzdXeFlOcWgwRWczb1puYmU5Rm9CNU9aSldO?=
 =?utf-8?B?SG43NXNYL3J2RnVNakd3WHhXdEdLVzgyMjFYWUE5ckhNWFNSUlV5U2g4QVBw?=
 =?utf-8?B?MjNld0ZqMUtjWUQ3Sk1CaWFvQWIrYUdRUGZZaXV1cTZBZkMyVTlJcmVOTjdF?=
 =?utf-8?B?eDAxdkx5aTVLNjNEZGt6Ykx4QUtQOERhbnNmTno2UEM2UnN5aEZQVnNTZU8v?=
 =?utf-8?B?US9rQ3lvT21sTFBqdUlFY0VNRWNsUHpYbXhiQ0hZamFiOVVUUW1xZno1RXhX?=
 =?utf-8?B?WmkxMG13WDg5YXpHdnlzRHVNcmhXMWdENUl1TTJOdkc4OUQvUG11dEgxdGIz?=
 =?utf-8?B?Ui9JcWZIUkJMRlVFUDFwbTJ3U1RKVjJsWTlvM1k0Z3lUejNyd2dTYjlrRXgy?=
 =?utf-8?B?MWYrTmRiZ3hqVVJhdGZxVGF3d29tY1JWSTU4akFtaCtFNTNiY1VNd2QyeVdG?=
 =?utf-8?B?aVhpS010V0ZJUDh1R0xGYnBJTHJPTXIwbURGSFM4enFyNmNaRG9wT2hkSlJy?=
 =?utf-8?B?cENXbW40ZjdWYVcxNkhKaTFCZ0Q5QVB4SERyNHF1QVlUM0xpUEUwRDc2bkpK?=
 =?utf-8?B?aXNKdDI1L0xyOVVZYkh1TE9qcDhUR01OR01pdmsvT0lGbG15UE04ZnZDTnlk?=
 =?utf-8?B?RTQ5NVhjWWJ2LzVrZzQrdjZkNGxnLzI3ZU1uMlJIcEJGSjQxenNyTTlTcVV0?=
 =?utf-8?B?N2VZVTN2VHlZTmVpU29Pa3VjT2VkbUtTSC9wTjZBMkNaMCt1eEFCVVBNN3FR?=
 =?utf-8?B?dTRab3NBQTFUek1xeUNFS1R4QlkxVmRSZ0U5alJPb2QrcEpSS3h2UjhPSWE3?=
 =?utf-8?B?aHhrQTRJK3pzUVoyRkRuWUNiRVI0OVRDc3pTUEcyYnkwa1dFd2dsNlF5NGsy?=
 =?utf-8?B?ak1SMVVUTk1GY3Njb3RZTGlOOUkxbVM0aFVzQml1dStZWlQwSFB6WjRsRzdy?=
 =?utf-8?B?eW9KSlMrY3c3S2oxdE9OREZ4aURvQnI1eHhBYmtRTzlESFU0b0xreGRoN1d2?=
 =?utf-8?B?MHZkb0lJUEVhZkxUVEJkNWUrcjJNcHYrbHVHMVF1SmFTZ01ZaW5tNkloN0NC?=
 =?utf-8?B?dmk3Tk1WV1R2dXdmYVFBZ2c4ZW1wdFdHUHpNWVhidXdySHp6ajJjaEp6dEV1?=
 =?utf-8?B?QTV2MzVrd0FLOVpQRkp5ano2dWRMSzlHY29zSFpkTDQvb09pWWpyb05oVUpF?=
 =?utf-8?B?SkFnOHFvU3owWE16YkRlczF6VG16RmZZQnk0SytIUmswTGF5MlNvdndrUys1?=
 =?utf-8?B?RkY0WWlmWFI3NWM1aVpNWjdCaGI5VmdLZEg2MVA1bkRRbWRnak1lK1hsUkZ1?=
 =?utf-8?B?RkFqaUtWcC9lVWhCalV0NWo5dDgyUWZ4d0IzNzJnaEIzdFZHaURBeE8rY2Jy?=
 =?utf-8?B?WS9iUkMzaWRyY09HRVFIaGVZR2ZWNUFJSEw4WGF5OWsvc080YTNPTEdHQk82?=
 =?utf-8?B?RXdiTi9DVW9PM0hZTy91YnF1RDEzcmRvRWkrTGNOT0NJQmhwVkQ4WDJwd2g4?=
 =?utf-8?B?VlFWdk9kK0thaldXRVlROSs5eVFra0ZScG5xSlhlS3RhS21vNk15dlFLNHpx?=
 =?utf-8?B?UENtZ29jNFFOdC9rNW5neUxVRVEwb0pxWStlV25xVlZFdS9BRGNMQTlZNy9B?=
 =?utf-8?B?c3Vxd3NhN2dtMTFjTGo2cFE4MXFoY0hhRHdldjRhdDB2KzlUZUlhUTN1Zmlm?=
 =?utf-8?B?aDdJUE14dy84VnVHbUlicnV2VHJPcW1MMVZoTzV1MUhHWFhpV1ZzdTNMWm1S?=
 =?utf-8?B?WTlSdXg2L1RzWFBSU1BiQTRGWVpUWGE1bEJCMHk2SlhUVFFkVGd0RXl1Y3Ix?=
 =?utf-8?B?U2ZOZkJnc2RLODhQM0s0TDlLOGlGQTV6bHFQRDR0ZUVaUnhGcXhmcExYWGU4?=
 =?utf-8?B?cFJnK1NpcTduUTBNRVhsL1QrUGZuVnFMdmp2YVNVZDg3WEJmaGtEVWx1OG4z?=
 =?utf-8?B?VjlGZlNnQ01VK3diZ0J3Y29YSVRjc2FZUzEyOU5ZYlIvaGU5d2JORkt3Tno3?=
 =?utf-8?B?b1FjdFhicm8wNURSUk9FVHdTdEx4cmlEREJqeEhFMjFIRkFVQTVQQjgxdHlS?=
 =?utf-8?B?NnA1bmNUSXgxS0JPNG8vMXdRSVRQc2tBdDdtVkJyZWp0Q1hrazhuc2JDVTVw?=
 =?utf-8?B?NXZ0NGhzYmNBSENja0cxanhPRlU4eERMVCswUDVldTFYcXJxcnFIbjlvdHJX?=
 =?utf-8?B?U1lJMkdMTTAvK093aS9tT1lZcHdwMy90NlJKVllsNlNWSlB4M1o4UDhIQTVQ?=
 =?utf-8?B?c3BNNEJuNXMyQlZUYXp3SVVMcjVGZ3pZeHVuNVIrd0xWMTlXUHZ6WXlqbUVy?=
 =?utf-8?Q?K7RWMeRV+IwzwFgs=3D?=
X-Exchange-RoutingPolicyChecked: naR18JsY6JmcGKjtoorBXKMFsGWicf5u2hxQK0n8L7nTc6dUsYBwYa2sQDn91mFaSWleypAexZE3YVKjNESRqxJ4nMQrIU5bRz0qr5hXAeJqvcqJhXxFbQ/ESaiLe9bhNmKq/3iDxk8jaWDeLPm28y271YDMDz6Dwv5u32e9l8vGD3tgJbHYjMooZ9ywRxbK0IdjYNsNkpt/ej7DQexDanDJ7X+eGyjDP9+mCdNk15vUZtLAZiosPQFUCSyoHjlWPZr6U37jbePoaIJIfEPpuPDeRIL8iEdte8/Gfjy/u2gJUSQx3dMX38G2ALAydg3lbrPWRb4lOJX8RMAAdP7A0g==
X-MS-Exchange-CrossTenant-Network-Message-Id: a524fa9a-cc78-4d1d-744f-08deab355d7a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 06:04:42.5847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6ppNYUDQjyGMHgpK4EYHleq6BohAVL/uSinn2AajNjuH5qPFygKK3fp7izNgjEY0ABfSiUOSqxx8KVzzyb6IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6135
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 880944D670E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35985-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,linaro.org,kernel.org,kernel.dk,intel.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,nxp.com,pengutronix.de,kernel.org,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adrian.hunter@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[10]

On 15/03/2026 19:26, Adrián García Casado wrote:
> Consolidate esdhc_imx25 and esdhc_imx35 soc data into a single shared
> struct since they share the same flags. This reduces redundancy. Also
> add the CID_MANFID_KINGSTON definition to quirks.h for centralized
> management.
> 
> Signed-off-by: Adrián García Casado <adriangarciacicuelo@gmail.com>

scripts/checkpatch.pl warning:

WARNING: From:/Signed-off-by: email address mismatch: 'From: "Adrián García Casado" <adriangarciacasado42@gmail.com>' != 'Signed-off-by: Adrián García Casado <adriangarciacicuelo@gmail.com>'

> ---
>  drivers/mmc/core/quirks.h          |  4 ++++
>  drivers/mmc/host/sdhci-esdhc-imx.c | 12 ++++--------
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index c417ed34c..d736bb4be 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -15,6 +15,10 @@
>  
>  #include "card.h"
>  
> +#ifndef CID_MANFID_KINGSTON
> +#define CID_MANFID_KINGSTON	0x70
> +#endif

CID_MANFID_KINGSTON is already defined in "card.h"
so the change is not needed.

> +
>  static const struct mmc_fixup __maybe_unused mmc_sd_fixups[] = {
>  	/*
>  	 * Kingston Canvas Go! Plus microSD cards never finish SD cache flush.
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index a7a5df673..9cfa26722 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -256,11 +256,7 @@ struct esdhc_soc_data {
>  	u32 quirks;
>  };
>  
> -static const struct esdhc_soc_data esdhc_imx25_data = {
> -	.flags = ESDHC_FLAG_ERR004536,
> -};
> -
> -static const struct esdhc_soc_data esdhc_imx35_data = {
> +static const struct esdhc_soc_data esdhc_imx25_35_data = {
>  	.flags = ESDHC_FLAG_ERR004536,
>  };
>  
> @@ -391,8 +387,8 @@ struct pltfm_imx_data {
>  };
>  
>  static const struct of_device_id imx_esdhc_dt_ids[] = {
> -	{ .compatible = "fsl,imx25-esdhc", .data = &esdhc_imx25_data, },
> -	{ .compatible = "fsl,imx35-esdhc", .data = &esdhc_imx35_data, },
> +	{ .compatible = "fsl,imx25-esdhc", .data = &esdhc_imx25_35_data, },
> +	{ .compatible = "fsl,imx35-esdhc", .data = &esdhc_imx25_35_data, },
>  	{ .compatible = "fsl,imx51-esdhc", .data = &esdhc_imx51_data, },
>  	{ .compatible = "fsl,imx53-esdhc", .data = &esdhc_imx53_data, },
>  	{ .compatible = "fsl,imx6sx-usdhc", .data = &usdhc_imx6sx_data, },
> @@ -414,7 +410,7 @@ MODULE_DEVICE_TABLE(of, imx_esdhc_dt_ids);
>  
>  static inline int is_imx25_esdhc(struct pltfm_imx_data *data)
>  {
> -	return data->socdata == &esdhc_imx25_data;
> +	return data->socdata == &esdhc_imx25_35_data;
>  }

Doesn't look right.
Previously this matched only "fsl,imx25-esdhc".
Now it also matches "fsl,imx35-esdhc".  So this change
has unintended consequences.

>  
>  static inline int is_imx53_esdhc(struct pltfm_imx_data *data)


