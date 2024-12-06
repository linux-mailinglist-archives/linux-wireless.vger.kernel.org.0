Return-Path: <linux-wireless+bounces-15978-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7229E7274
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 16:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F47B1887AE3
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 15:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DABB1FCD11;
	Fri,  6 Dec 2024 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nQclPDNK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F106207DF9;
	Fri,  6 Dec 2024 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497739; cv=fail; b=BSxO0yhiJObs0wDxnb8Jz6lrHF1fFFPRP0zGKvHv91siXJyOQPyav8iuHbTQTLNgidOdE0X2ggf04cn7WBt0l1zvHn9l2AYHp5/XeC73xVGDxxcwRQSq/Lmjbkv25l/FkzZ9RXqvsNT8Af1HaJC4n7NcthUEKFNADlM7YQHy76o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497739; c=relaxed/simple;
	bh=kJJhp8NSR9Y4HqFXlEEb+/lnqr5TPQNKD7XSdnIFyLg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TDSIILmMk98SQWm/yRQz2+1URRL0kB73Q/6BY5ZLGSgv1a1PpSDM6K49YactsYVGbjlCz4HJrFk83Ro1k8V6AmP1hfuwEuA/z4I6NNrbVieJcyGZwW1Ij5kZNWhyi50fokqF1yQZ864KszuMTOltnczGy1479TSS5QrIWSlV7Q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nQclPDNK; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733497737; x=1765033737;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kJJhp8NSR9Y4HqFXlEEb+/lnqr5TPQNKD7XSdnIFyLg=;
  b=nQclPDNKTuPa8E70nMwIVjBSYABZuIg1sCq3cG5HmPKF2XLn56kgv9uk
   tF7VazOGcuCsQ53qaHKl3intVte88R35JuSn7uCe+kP7WhpIIqfwVf9m+
   mH+W1Gc8r+OWYSRqovWQ8DOg5FM4BuEFzRFyMJxWLmULd3cXBWAehwXC3
   MgiYWwhBCI4G5hpbC916yscrfHxfj1BiSkZUEIahbyY+pqokk28prvHUq
   gP7OV1ptxEUVemVp9UbqwlY9pilEA+yHl+m1uRVF2RznENlulcEafMKko
   dhfpal063/9G526d3sTPaVrWuSqzBhbp/hA+99oia1XOmwXu0tn6twE5u
   A==;
X-CSE-ConnectionGUID: +XjJ/efTQbCaiQYO/HKWhQ==
X-CSE-MsgGUID: uNqhg66tQVGAkaHht3UHDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="37529593"
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="37529593"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 07:08:55 -0800
X-CSE-ConnectionGUID: Qwak7uxtSdi2lO7jN1LOug==
X-CSE-MsgGUID: Swjl1cxjQ6eFgUBOIwxYCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="99380097"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2024 07:08:55 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 6 Dec 2024 07:08:54 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 6 Dec 2024 07:08:53 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Dec 2024 07:08:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJytUTjXxoWr8BqIO+hOczMjTVsxoAt3P6/XpjNNv1vC+RC6zVrWcT2NnbKRaQwHtXULslT2SAE1r+wrysG2JJn5HVft/YxHGot4i8wUVnjTv8OmhmTMUkN1YWr0R49pJ1Y9d5LmhnI2nE1b6JjtXZse73FUvuHx8qVv5GqRmMhn5tVEJKWCpeecIpNIfRvpuvYQasDc2fQcFBhdVfae2ScjgPmIxfxmiqs+6/TXunkCOVfCLRZ8P3mRrHPDlX9kWjimpIoiaagGJqfnpfW0I7WuD1kaNQufsyy9qgLb1UriUwzj93pY09FRuo3xftTBXKoHupCQZ7M3LOrZqCoX3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3Ieuk9ZmOofqk1fytcY5mZvq4ijay2Ff90TZ7SPLzY=;
 b=Mx99pQloD3SMCFAGkmCdw1LFxpO2iB5theHivlzNhdPWWYlS0m60TkaA3pgH7nHzkMxcx3V6R44u5UVG5hd2vjI4TFbnbkn0Fb8pdabD3ErMXP+2OEAkqjC0C8CkiUyc3ZB4XZOXKBqmwh72v4mctjcjPryy6ktQ4tXVsVUaRCXYoZpmk6o4mQxGSfbUM/35S4rYJ729Jb67/CL2yL6MOkWB9RB7tC2u459+F6Yfx0YBLW752wBUyX/jt1XXqik7gPh/ZRAx9tYuvSLWCmJ4ISh0m+NKhgYgIdtDQZlk5ayI9d3OtqBdtVxaYct5reI4Z6ilCjG59b+Og0Fau9wLGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DS0PR11MB7733.namprd11.prod.outlook.com (2603:10b6:8:dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 15:08:50 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 15:08:49 +0000
Message-ID: <a1a7c865-be0a-4071-a50a-7c15d7b8b095@intel.com>
Date: Fri, 6 Dec 2024 16:08:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: reformat kdoc return statements
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>, Richard Cochran
	<richardcochran@gmail.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>, "Edward
 Cree" <ecree.xilinx@gmail.com>, Alexandra Winter <wintera@linux.ibm.com>,
	<pablo@netfilter.org>, <loic.poulain@linaro.org>, <dsahern@kernel.org>,
	<hawk@kernel.org>, <ilias.apalodimas@linaro.org>, <jhs@mojatatu.com>,
	<jiri@resnulli.us>, <netfilter-devel@vger.kernel.org>,
	<linux-wireless@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
References: <20241205165914.1071102-1-kuba@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241205165914.1071102-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::16) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DS0PR11MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: e0e42152-47b4-49e2-6803-08dd1607e3a2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WENqL2FBY0ovamJPYVNXZjlWOU1rdkZGNkphSTR0WktTbEFiZkFtN1J4ZVh3?=
 =?utf-8?B?anZCMXA4UUh4OVkyNm9kbG1UZVVRTCtQYzYrdGRjbFlhVGVpZFJhcXNsbHhi?=
 =?utf-8?B?SlVQMDBOM2hQYzhrbFBWcmNqcVV5VE9XOWptYmR4UDd6WmZ5MjVXUzh4WHFB?=
 =?utf-8?B?S3p2dmoydnlaTk05Tml4UHREN0U0SWFXUUFsTkZwMENPT3pDM3ByZDN6ZDN0?=
 =?utf-8?B?eEkyM0FieWw4M2w4SFJPdXFGVGlJeng3NDYxcFBudkVVRXJOUk5kNFdrdGhK?=
 =?utf-8?B?Ri9KS2hacktxdFJHZzl1d1pMVmZaYUR6TmswTmgveE5qYjI0RHQ1bFZYVTdP?=
 =?utf-8?B?dVZ6Z2lYdjAybjRhRjBhWWlIajZYOU1aRXZRdTMzY3NBWTFKVDhpYjJ1a3RJ?=
 =?utf-8?B?RndjVForUVJrcTBjZGhEaTBMa1F3cjBaV25wUFhtZTN1eUJ4VFhWd29EK2tj?=
 =?utf-8?B?Mm1ZV3NiMEtUYllSTStmTDJWMG5Cc2RZbVp4Z0hCbmF0VTAwRDJjaFNMYVh3?=
 =?utf-8?B?TE1SUndCN1hCY1RVRWpiVHF3QzdWVGRaUkRweW5STFFJd1h0RlFqK2I0Q2F3?=
 =?utf-8?B?bjJ4RFk0ZlFJVnYwYjRtSXptVnhkMk4wL21GUVNDL1U5VTFhNzR2QnExVkdM?=
 =?utf-8?B?UkFmbHQxbTBQS0FFc04xb1lqK3JMRkZXV3VPcUROcDYyZnFDZjQ0SUNEYitx?=
 =?utf-8?B?UG5VaFU1OHB0RjZMdjc5MjFtRUtHSGFZOGQ1RXUxTElNMk4vRHR3RERiTDVT?=
 =?utf-8?B?NVgvd2hXNkdjY1lYc0VuSTBaM0czOTI3UnhGem9iZlhLWEZjMVcxUHhINVNB?=
 =?utf-8?B?d25HRGY3TVJOOThMKzQ5WC9pZUpuS3JOaVFjM2ZTV0s3WThHVnVPTk1VZTE2?=
 =?utf-8?B?TDFlcW9TOWFKelJVaWNxWndmN1AzRlN4TVdFOTkxZnYxQkkwMFFWOHR5anBG?=
 =?utf-8?B?bU1oTWFtYVFFMzNJMEh0UzYyd2M0ckdoaXBXVEtnRGJtbm1aTGJ1czB0bVVs?=
 =?utf-8?B?SmNZTFB3R1pHQ0tKL01XVjZqaVZjYXBTaEhVU0FkMXozTlBLaDB1ZjBVWGo5?=
 =?utf-8?B?U0ZydHJTT0ZwSVUwQU56TFdybjRUblJ1UjgvK1I0dXVoLzhhYVkxeGdwbnJU?=
 =?utf-8?B?NWdBRElQaExDMU9va1ZxWUtpbC9LcDgva1hJYi9LdHVSY3VuQ3hUQWFhUEp4?=
 =?utf-8?B?QUtUSTk3NE02ZGQ1aEFQcXRQbEM4M3RCOXlOaHVVT1Z3YXR6bXpJejFoYk5y?=
 =?utf-8?B?bldYb2N0ZzRZb2hKS04wYms5WUdaaGE0aHh4Um8xR1BpS3oybEFDekVrVG9D?=
 =?utf-8?B?Y3BRY25IcHk4eTZlVW9NOUpxZzNrb3phQUJmakFPUXBxMDMyaU5QTDBaYTJT?=
 =?utf-8?B?bHcxQUgra1lGenZMa05mWDJHOU9jOUF3QitsajEvSGtXb3J1ZVU0U3h2dEdL?=
 =?utf-8?B?VXRGMTJYMGtTZ0ZSNGt0S2tjRjdSM1B0aGtpdnRXWnFQaXdENlFTNmRiU1JT?=
 =?utf-8?B?R0ppSkFwU0NrcXdBT2xxcXNGODE3cjdTSllEaUNOeUlhUkpadTVZZnBJRFJj?=
 =?utf-8?B?bEsxRWFiWkpLQzBJUGpQb3AzTHY3L1JEbC9xTkZSYnBwUzBNSFBGSXNyemJN?=
 =?utf-8?B?TmZFMlgrMDdmaDFpU3l2YmtjekNhK0IraTF3MVI2Y2F0VkRtbHhEcmVnRlVY?=
 =?utf-8?B?ckxVRFE3alU0ditnZldMYVI1Q0sraHloQVRxQ2RsVm9LdDZOZE91UE9YWWsv?=
 =?utf-8?B?ck1MZEVLRllmWWFya0dxNHljQWhzL09YYjJQZzhPcHlyUlRYeXJFRElGNkM2?=
 =?utf-8?B?Ry9ueUhrZUFUL3pGanRVUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzFIT1FqeWpOUGU1cWswdWYyd29sTDdBSGM5ZEgvL2Rxd0hWRldjaTZGSTdy?=
 =?utf-8?B?Q2s4TTdjOVJxUkJzRkJSY21mbGpHNTlobWUzaml1ajBETWNMUjgrSDlpeldC?=
 =?utf-8?B?NW1zN2lnZldsZGNWQTkwYXMxUldLdVhBMWVBc3ZyS2NicVBhbisvcElDU3BJ?=
 =?utf-8?B?Q29NSVIrSkJtRW8wbDkrbEtXV05jLzJPT1ZhWUV2STAyRVp0SElNRWFnajZr?=
 =?utf-8?B?blFGT2lMOUVVc0ZFcSt5K0tQNXM3QkdlSWRUUWpma05DZWNGeGJvZytRS2hS?=
 =?utf-8?B?czZnaDRYSHJlTTJJM1BZM3UrTi9xRkV2NG4yWnRIS1V3YXQ3RVlUK0JnNDVi?=
 =?utf-8?B?RFVKTHJEOXB6ekNYUTVYbUZpb3lwOVVMZUhNTm9PK25HOXl6UzBNaTIxVEJj?=
 =?utf-8?B?emhFeUFZZmlGMWtpRkozY0FGNFZsNlJ0dGZ6UHdHa29uMDJhd1ViZ1hzZ1Jl?=
 =?utf-8?B?UjExNW1oWkJQcU8vYUVhanZNZWhjYXZ3dVFQSHpWNTBtcElGQnBMUjdYaXE1?=
 =?utf-8?B?cTJDeW1LOHF1MlVWSklFby9QTGhpTFpIYnB4bjFoS1ExemN5U3k1SnNKVW9t?=
 =?utf-8?B?cms0a0pJRmNqb0VLSkVmS1BSTklyOW81MVRWNFYxa3VjWiszYWtiaStDLzA1?=
 =?utf-8?B?VEdjZ0NSdHArWFFtcEVocjVPb1BNSlY1WWdSbnZPU1RvLzhTcGR2N2p1OWh5?=
 =?utf-8?B?R1MrTFFDbDFoWGZqd3d4dXdiR0JhbzlBL2htVmtQQUthWi8ra2hKT3JURXFX?=
 =?utf-8?B?TWlCU0xSaXh4TVhkL2E2MjQzVDgwTk9FYlNnaW1raUNXNnM3WGNDRUJwY0ta?=
 =?utf-8?B?dE1ualg4RmdJOG9iRTB1NGJHR1BmUlNzWDBONmQwSXZ0TUhBVDNOa0p6d1pD?=
 =?utf-8?B?T0NNN2tMNHk1U1haTDRGT2ZzVldOWWpFc0dqUnlIQ1NxaDZrZUsyR3JQQXFu?=
 =?utf-8?B?bTh2Yyt1ditHL1NnUmREWjZ4cGNwMXZZcnprMUNLSjVRZ1EvTFlBZmhBTU5u?=
 =?utf-8?B?a1hNWXZXdUkxQTl2a2xmT2MrUEhPb2JSN1NCYmJCNEhqVzRsUlppUmx2Y3di?=
 =?utf-8?B?Rm92Q0xwbURPVmpXSFBGaXJIVngwS2NleTl0QUNFeVBLS2hXcjBONFQxWmts?=
 =?utf-8?B?cGFIaklDNlloYnBnUjlhZHJ6cDZBUzFMQ1dXNnhPQUZ3NXYzTE0xWlRNQTho?=
 =?utf-8?B?Z3dYay9LTU5jeXZnL2NEV2I5MG5DRnNhRVNqdTZETjNVcjRFN0JCbUJlY0JU?=
 =?utf-8?B?L1h6ZFRrR3dwNVFZTlh2dy9Cc254TGtCSEI1WENoUnRveHp1cU5QMDFxSW9Z?=
 =?utf-8?B?ZXNibkVMOXl2WXpOMTYxcXhUS05CZ1IwclJiaVU5WTlYTnFHN0ROZ1g4YU5M?=
 =?utf-8?B?YjI2enJRUmNsbk9Id2IxV2ZJYlpqSm5ZelpZTzF1YjBkS2RWNEtxNmYxSlFi?=
 =?utf-8?B?WlhRQWxLZ1orTjNmVUxCS05YZkpRWWpUaElxSU1VODVNZHdUYkh4WTdqQjJP?=
 =?utf-8?B?Vk9naGRJbnJsNk1FVERkKzFRbTd3azFYR3Z1RFJHcGFVSm5rNzk0R2RQSXFj?=
 =?utf-8?B?K0tSU0kxNTNCSzZkWkw0M2d6cGpLUUdud2pzYWF0bmtmVkw4eDd1dHZXZExV?=
 =?utf-8?B?c0ZuS2NVYUNnZlhVR3luNGM2dHR2SjJFbVkzYytoNHpML09sY2tyN0tRTUVW?=
 =?utf-8?B?ZDB1b3I5Vk1ON01CWkdxeS9WSjdxMklGTUgyWXlNT2pQSVJMWE1pampyOGt3?=
 =?utf-8?B?S0Y0cCs0dytuQUlJM3ZodmFZd2RpUGFPTVYxSTcyL3VkeHVPeHdHZ09uem1v?=
 =?utf-8?B?N1drSENabGZlOERDQWVwSTRtUUh3aGtNTGVWYURyQjFEb2JXdDhFTW1hNjNs?=
 =?utf-8?B?LzhiSU5yZGVLeENKbXlhRU1JUWN4RUtsckY2dEI3ZXViOVdwRDE2aGFPaXZN?=
 =?utf-8?B?bnpNOWdPdERXc1NUWU9adWkrWDNuQzBjVTQwV015S0xvcTZOQUlJVEQ2S1VR?=
 =?utf-8?B?a1dCVG1CRXgwWGFIRmN3ZVNFOUVMN05XRlZUV1hHUktkajM3VHEwZkpFU3Rs?=
 =?utf-8?B?N3BiUEhGVUoxZkRVUXQ3UUdEMFlOeldKd2Y3cGx5VTdyRHd6TXRtbXZhUEVN?=
 =?utf-8?B?ZEJydGM3a1dTaktJZzZ3aVM0T05XeHlldXlsc1JpTjIwVUorZGROOUlJKzhs?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e42152-47b4-49e2-6803-08dd1607e3a2
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 15:08:49.7228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SGUvA6I+c/bdpObY0Du1nU3v0YJHgV8m3gFU8MGVDJzo+bsnUBlG4vI8MwMNhm8/WqSUb8c4DovouenAMJKbzCHdpm8nD07chyRawAW8mzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7733
X-OriginatorOrg: intel.com

On 12/5/24 17:59, Jakub Kicinski wrote:
> kernel-doc -Wall warns about missing Return: statement for non-void
> functions. We have a number of kdocs in our headers which are missing
> the colon, IOW they use
>   * Return some value
> or
>   * Returns some value
> 
> Having the colon makes some sense, it should help kdoc parser avoid
> false positives. So add them. This is mostly done with a sed script,
> and removing the unnecessary cases (mostly the comments which aren't
> kdoc).
> 
> Acked-by: Johannes Berg <johannes@sipsolutions.net>
> Acked-by: Richard Cochran <richardcochran@gmail.com>
> Acked-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
> Acked-by: Alexandra Winter <wintera@linux.ibm.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thank you!
I put some comments, but not about your patch, rather a general
observations

> ---

> - * Return number of phc vclocks
> + * Return: number of phc vclocks

so good that there is no enforcement for the final dot (.)

>    */
>   int ethtool_get_phc_vclocks(struct net_device *dev, int **vclock_index);
>   
> @@ -1253,7 +1253,7 @@ static inline int ethtool_mm_frag_size_min_to_add(u32 val_min, u32 *val_add,
>    * ethtool_get_ts_info_by_layer - Obtains time stamping capabilities from the MAC or PHY layer.
>    * @dev: pointer to net_device structure
>    * @info: buffer to hold the result
> - * Returns zero on success, non-zero otherwise.
> + * Returns: zero on success, non-zero otherwise.

As kdoc-warn-free code becomes fashionable, I tend to see more and more
shortcuts for the obvious cases, like here. To the point of:
  * Return: zero or errno.
or even:
  * Return: errno

I have no problem with that, perhaps only that we loose two lines for
such trivial stuff. I know you could also add a special param:
* @return: errno

Would be good to know if anyone have an opinion (that is going
to enforce at some point) about the boundary on accepted laziness.

>    */
>   int ethtool_get_ts_info_by_layer(struct net_device *dev,
>   				 struct kernel_ethtool_ts_info *info);



