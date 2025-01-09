Return-Path: <linux-wireless+bounces-17210-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2787A06AF4
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 03:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7328162587
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 02:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DC081732;
	Thu,  9 Jan 2025 02:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C4vvZQj6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6AC1F95E
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jan 2025 02:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736389711; cv=fail; b=ehTIsc8dkbgAfR7D5yEeZg7SphbG2TyYo1A9neHN4f1QGYKy2fWgkpbiKN4QxB2DoEpNJUgQAuAEeswmnkjzFQ81GaYpEdSKayQECSZXFJsCKrQuc2E49WFhYRvarht0BRbztL3qwOsmzuxx2Yv/reUW09U099scr5mV2PKNKCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736389711; c=relaxed/simple;
	bh=zo8E6pQXXS0MiSeB9EobMP37WviSpVzCiWwYv+FgZug=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MhhMfYA4oYDshAN2agjWrkkUXdK+5NM0i2+KUtx6tYYu3MqEMxlEhzt46s900hLnjmUC62MFtutTC6mlH9TQVDbxppObG73Z07Ib/HG6B9Vysrm1eMlHpDg6Oqw1y8eRTTl1+2ARsDrV22wdnvY0l7qCrals08R+9aJ2812Pmm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C4vvZQj6; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736389710; x=1767925710;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=zo8E6pQXXS0MiSeB9EobMP37WviSpVzCiWwYv+FgZug=;
  b=C4vvZQj681hP9uRFxZpHQH+yAdtGAXNQJGgFi5lsXdnKGIIWmpwyC8aw
   XfaZzEek9IU1FRvYS4Az5phF5iWXwlmA3Q1fVjHIaKmGcKMY4TvFrJ7JB
   N8z9D5Zjhr0KtbScBkunXhTsJiVw37pjqczFrVLWhPTjfjAQgv089wBN1
   iEGzB6tQLINZi7Cm2jsklP3KUdzhvKGJ2A9v38zdXTCIO5f00+eGgzp7b
   STNZlrO/h7zf9htb/Ode8t8hVD2LvycYz614uXY+WRIOdVo6psTvUCtpy
   AuQhm4EK38SZDQTzJ817u/iv988W1P4Cba5J3yn4NyaEc+hHBBHAQuil6
   A==;
X-CSE-ConnectionGUID: Z/mdOnLmRlaGSWsBS9zXYQ==
X-CSE-MsgGUID: tBrvE/oMS8+DJqJEFOyVug==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="39454206"
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; 
   d="scan'208";a="39454206"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 18:28:29 -0800
X-CSE-ConnectionGUID: 3KCaCW85Q+66ucufc5f3Dg==
X-CSE-MsgGUID: szdj8yTBRU6jVqrRXmepEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; 
   d="scan'208";a="103773072"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2025 18:28:29 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 8 Jan 2025 18:28:28 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 8 Jan 2025 18:28:28 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 8 Jan 2025 18:28:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+blMwGNqWW+BrJfbUB2BNKhlTKBaMjQJNSp+W171eAUjtVHbg6hcJ2cipV4kjQ/x7PVhmXwWgyuBHzh4458IBQxM1NRb25mCsNraGKR596KYRadsbOBbW13lRruZ5I5CzG5wbE/mtQBOx45TOHWrSE00dxtJEGVwyZKZyGzqf15uyNowklThf8xUAx6sfsptmMviPDqPOdaYcC9l1h0F0Ichs3Ujv1kzWP1v0LIoZTntT2x8EfJKklRmOknGyv5Tdljn6LA0BSx6haBujF6tZqTWleq/CsRsE6fcJzfuOu5r8yezRCgq4DX2BdzSuQ36B3XpS7sqAKDpxs5BckKeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ewyuOdd6j9T1ndhX2Bkx/ZHeg9fcBoHOyJLsvs2ox0=;
 b=udhhFssNyT5FU9iaM8E17RDu1/wiKOga051i4u0jARWq0EgPhfRzZD35su4ieTZQlDKWT1gHbywjPi8osyzSmzSHzzU3ynPny3WrUpc4L8nogIcJmzQ7Z1EMK+19Wb+Rs51QFuiCQzk2fuPTeWPG5QyvuGPmFGKlyai4V8CjrLSAkEDKq2H0M2LQ9MAnJwePwNdN5ZCqzmxfXHJI1W4dBDCDwQVjoksAWlFxlc4uvbf8HP4im5p7TNGQd83vvO2VT/6n6P9ZkOlknmAyDdJS9XtV0GOCw209YrADKcg5JS5IN0Rwc79px56lYDw71qjJbk/DO2l5O7nWN6iQ9lC0Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA3PR11MB7436.namprd11.prod.outlook.com (2603:10b6:806:307::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Thu, 9 Jan
 2025 02:28:20 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8335.010; Thu, 9 Jan 2025
 02:28:20 +0000
Date: Thu, 9 Jan 2025 10:28:11 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Benjamin Berg <benjamin@sipsolutions.net>
CC: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	<oe-lkp@lists.linux.dev>, <lkp@intel.com>, Johannes Berg
	<johannes.berg@intel.com>, <linux-wireless@vger.kernel.org>,
	<johannes@sipsolutions.net>, <oliver.sang@intel.com>
Subject: Re: [PATCH 17/19] wifi: mac80211: also verify requirements in
 EXT_SUPP_RATES
Message-ID: <Z380O8r1fja4NVdQ@xsang-OptiPlex-9020>
References: <202501081559.1c188f65-lkp@intel.com>
 <7d4cd2e755c830803ee8040aafabd7c0632ae335.camel@sipsolutions.net>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d4cd2e755c830803ee8040aafabd7c0632ae335.camel@sipsolutions.net>
X-ClientProxiedBy: SI2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:4:186::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA3PR11MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd14e13-9507-413a-1500-08dd3055483c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?cWutD8TJcnKsA2LRFH3lSGlwCRkj32HnbCedhaVqxa1ZS1km9fzx9tF2do?=
 =?iso-8859-1?Q?y+kJGS7W9+DrpJJDKXKbGGFa7XHaLhlLhkuC1KpW4rcdxFVGIdLWrAoBdg?=
 =?iso-8859-1?Q?PFJD4seV08v9Xj0fPAiixJFAwJ4GMtp9y2kQTdvIg4wWTtw0fLo9h5KqT5?=
 =?iso-8859-1?Q?yu2aAd2qGZHjEpvIHFOdnbBc2Z/wUbrJPVenSb34cRnRrQjVj3Oy3401c5?=
 =?iso-8859-1?Q?X0cQ7DWHhPEyKBid+H83GbCokkukKbgEcJIHctcrSTLpuH/5xUQVA2FkB4?=
 =?iso-8859-1?Q?R1tF0/w2Cho1lhxaQnLc5zHm03NQw15ulrmtLcQUXhBfHGFv2YsUZIaRtP?=
 =?iso-8859-1?Q?wyr7BwH8A0FRVIG8bpVbmZ3XthUDPKMNL0gHPukXXTNreI5aFcjdBRDGPr?=
 =?iso-8859-1?Q?5S2dI381MwS+K69B9MqnPH/s7QBOuXWA9yhRlmonjcGuh0jAR0KC21Wwa7?=
 =?iso-8859-1?Q?dJn4SFXEYhTd/ix3dYCnXIHZqYbjiCrJQ/JU+dw20u/Eb0cfoqnQCsIc30?=
 =?iso-8859-1?Q?naAlcpcYGy9Y2DNVRYCBcnXerXM+/y+hgy42IHeGSXaYHttp3gPc5zYUJx?=
 =?iso-8859-1?Q?204nVQBFUEwt2AbWcRqQ8YjxsfmDLOpsP/PRS6xeRrfDZV5cQ3hcpfVh/c?=
 =?iso-8859-1?Q?eusPCQ+2lWjGAled9ewQdqdkGcuMKb5hqMT6sUj2APRsA7RlAPa8g1nyrE?=
 =?iso-8859-1?Q?AX5H3M+6vMRAc7bRM4ssrcr41F1Z3mwnycKIXogq/Tx9bYX+apYMi4hKG6?=
 =?iso-8859-1?Q?+/noNZqClyMhQya1sy5/NEilyyZXv3KODoLkJ16lbLS2fwjfFG9E/b0U9g?=
 =?iso-8859-1?Q?KadFmiRGi5rRTHc11joXVNWwtf6s+li3kIdkya8pSJ5Zp55rTL2DqHefqp?=
 =?iso-8859-1?Q?eeQFMNJxJ7E2h7Zg8idNEoIpf9Wx5LpZBotEH4EPWkU6dkwFGcTiXWkZ84?=
 =?iso-8859-1?Q?yE5jP2kuOVuGLrLExbWGrr8mc4bx/m6fpZdFfq0uzr+o43SbeyHtPJiMJM?=
 =?iso-8859-1?Q?EMqehsymIpK12UTRGykXTg9GvapO32G4IxooqtD3PeBTmajB4IEx4nj2k3?=
 =?iso-8859-1?Q?+uuGvVQHBX8cSKSgILnztihFBvhjG+G9c5NZOUFQD6+xP2ZpPLmRjozUoY?=
 =?iso-8859-1?Q?cqJqji+QMqOwc6AE6g/7BoJitUQ38EOe7OpvcDagUvzSYp26wpRrXVOg+1?=
 =?iso-8859-1?Q?Hvd+ESOx7j1HG26sQKQiJtfB143c6ON+Vlgx3MMODu+YQU+xIiZEPHY9bO?=
 =?iso-8859-1?Q?wAfxauWrYmlVeE5TYXXw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?amO0DXneZrJh4ExdybDhuNFTi6E7coGTsBbrbsx7MuLTgTQIbJiXEaYiVk?=
 =?iso-8859-1?Q?qtqnZhGEcgKF1mZGDQ8ECIHUFUVLIcETd2QYLamGGE9hh9yEI1GCCDbEpm?=
 =?iso-8859-1?Q?uIYJ6Uu1qiWDiofObdSEuhx7ds4ZV3afDqYDuYyvaky/b9s6UX5DCd+4j6?=
 =?iso-8859-1?Q?PN0X9nyhsfw1pvs710xKdLJThKqvqi7V1jju3udKahur8ASIHqvRJHgrxM?=
 =?iso-8859-1?Q?XSaZmH4LL39hOoMM8g/ybWyAUV2kh90tp1OmxTfMMgDPvvjajCbbRmiohr?=
 =?iso-8859-1?Q?l8OXGy6+Sy9Zl7xLNOedskBzKe6S1wck4kwOJBwyyXGFHv/Bms8GucqKI4?=
 =?iso-8859-1?Q?tx4yCq6DWo55XXgJmLXU8SsWRdrvb0ZMfPGfYMLnCNXn8EHhyBTDZiUeCc?=
 =?iso-8859-1?Q?HuqFieDcvgvemdx8/Ha2u8gQr5pznhGky5y//T7RVupsaofT8slSZKOLZU?=
 =?iso-8859-1?Q?xp6ma9r1ULGTzHaF053p1vhtd4u2XwD5mGp6cvQdj1wCpRh6bcO+U159DS?=
 =?iso-8859-1?Q?1Fh4DKfssy5qCg9TXSrxOFWWDm62NE2OQV/JQa9+6aeb00CxesCZXK/hpd?=
 =?iso-8859-1?Q?SuwGFq1bzKPBiScGvfA9P7n+rYY+Q1GefJIFShEujzNq3vON3apsZUzYGC?=
 =?iso-8859-1?Q?FLvV1eHoaHc4/12mQVuQnzQMIRr+oTyTG7L7fsgr7Psmya7aresKiem3CL?=
 =?iso-8859-1?Q?HK4zdVERuqibQoT6fixdHD56pAhSFIeJp/6mcurfUtOeKd4MebNdBh9whK?=
 =?iso-8859-1?Q?iNHTNnoQzPfrSAXL6dPAwt8W7OTjEhU1AoF9pt8WsAL5MDeSc4gnsw7Dfe?=
 =?iso-8859-1?Q?vOfUbmkqCrBGLUP120EUSxdZZojvNgaOfRUguOoYhtmWeIxRU1f0UalUup?=
 =?iso-8859-1?Q?3k9IcPQvduEz3kCyXxibalUlVOZmkj+1AmPPiXNqeADniLAyq25w8o8/Rk?=
 =?iso-8859-1?Q?Q5cEywL4dJUkN+qvr6nVgFwTAwfI4DejctzOqJuddvhATRJmBn0pJeiLNg?=
 =?iso-8859-1?Q?YwAhYgvbEOFQ++pwOnEF0FYcVxCcxhsAxpB3TLh39nnkSVPCNPsCBObQRx?=
 =?iso-8859-1?Q?juN1atnzKKK7ffQOu5jLkGsrcJGzWnj7tMhbefCoHQBBZMVhI9q1+LsICk?=
 =?iso-8859-1?Q?CHTBTY0WIPfq3ruR+5LLbtToauaGRxgC2WN6uiXs+M8+gDAR9xrrkwfrmt?=
 =?iso-8859-1?Q?JlvLb4vllNSGExyJw1wWyE45qBJ4OCO07YEgUY2rEZXkURYxaWOZdOfana?=
 =?iso-8859-1?Q?9ayRwxRPQvSCAcpJQqCuO29XdZm31UagwIyUd5zuP8xAxwtm4HGnMUK26G?=
 =?iso-8859-1?Q?KEB2xeHJcbbahTgHrUBQFAAZU/Y89wPCY/tWtgxpX4tZ8PC4NYKZEJJV+S?=
 =?iso-8859-1?Q?+FR4A7N33B6N3KOcyW6XgDC0dbcgoizoisJbx6Beip1IsF0MGYSnhLF3JQ?=
 =?iso-8859-1?Q?hi45Qfp21pZTt0d8tZzbxfnBc12JR/C3wde5AF9FVAho/nQFQw4cq6sgGU?=
 =?iso-8859-1?Q?/GLhFePBHsNTbwZOG9DG85AxzPz/Dc8HXdFpI/miKH4P524TBVmJ6QJu0g?=
 =?iso-8859-1?Q?tOAIMRqAclix0ExT3TdLwDdPsEsfxbYJR581rI5JFOJdX77iTWZgN+M7v7?=
 =?iso-8859-1?Q?aVTboYoS7WtG9sQEmKwaVzUDo70/itOO04z1qd4wdma+x+g7656ezJzw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd14e13-9507-413a-1500-08dd3055483c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 02:28:19.9695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IHjX58vmhFLJyiu+CdCkX7m/jg/IGWs1ImfTwLbEL8KAR3YBEuRS/cuLShBKYoP1Y3rBrRNRviRSk3z6ik6/IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7436
X-OriginatorOrg: intel.com

hi, Benjamin,

On Wed, Jan 08, 2025 at 10:17:55AM +0100, Benjamin Berg wrote:
> Hi,
> 
> On Wed, 2025-01-08 at 15:55 +0800, kernel test robot wrote:
> > Kernel test robot noticed "hwsim.owe_assoc_reject.fail" on:
> > 
> > commit: 1539283361bfb9c62eb3486ded2c4d38e5858510 ("[PATCH 17/19]
> > wifi: mac80211: also verify requirements in EXT_SUPP_RATES")
> > url:
> > https://github.com/intel-lab-lkp/linux/commits/Miri-Korenblit/wifi-mac80211-add-some-support-for-RX-OMI-power-saving/20250101-131018
> > base:
> > https://git.kernel.org/cgit/linux/kernel/git/wireless/wireless-next.git
> >  main
> > patch link:
> > https://lore.kernel.org/all/20250101070249.f1840f19afa7.I12e3a0e634ce7014f5067256d9a6215fec6bf165@changeid/
> > patch subject: [PATCH 17/19] wifi: mac80211: also verify requirements
> > in EXT_SUPP_RATES
> > 
> > in testcase: hwsim
> > version: hwsim-x86_64-4ea2c336d-1_20241103
> > with following parameters:
> > 
> > 	test: owe_assoc_reject
> 
> These failures happen because mac80211 has become more strict and the
> hostap, including the hwsim tests, needs to be updated. The patchset to
> update hostap is:
>   https://patchwork.ozlabs.org/project/hostap/list/?series=439300

thanks a lot for information!

> 
> Benjamin

