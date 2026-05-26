Return-Path: <linux-wireless+bounces-36936-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMfkJHYYFmr2hQcAu9opvQ
	(envelope-from <linux-wireless+bounces-36936-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 00:02:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEB25DD0E9
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 00:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D692C305FB3B
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 21:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C08F3C3455;
	Tue, 26 May 2026 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GRGsSsR/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C02233C50D;
	Tue, 26 May 2026 21:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832586; cv=fail; b=pZgdUyhgq9f9AjKrNLujBjSUNg6v2AzV/sIIc5s+olwn9CHrv1WDztx3MzjKgzLl+qQ2H8wjt+Dib/tXewtoeuMGKe4oHaR/Ug8jkCs16XwLKDuZ7Ag8xaJGPjbN13DO+eZQ0dFPNdoAXnb0eZsqKVDOM6laRUQTyA9p+akLdNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832586; c=relaxed/simple;
	bh=0eHtwHpW0R+FRZZLwJ8VicX/Gf6MhbYiwcxt3BUerrg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VRDK/BgEoGxk20L018deYRuF0iqIKcKL/q2hggVSJOOpwrY3MLfrdV5+8Pm+gOrIDcMFr1eDiqUB0QrlZCuEFAHEsmtTLC9j70/svVxJkozcxIY9rh3FXHfUyLBy7mpCFUDYMjEys9wL4qyzJMysYj2sLXSfDSSpX4aXb8uK5DM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GRGsSsR/; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779832585; x=1811368585;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0eHtwHpW0R+FRZZLwJ8VicX/Gf6MhbYiwcxt3BUerrg=;
  b=GRGsSsR/A4hWsKBEM7/j0ImZrMEqwtoDfJG7BxaTgfrONBfyVk2+YPNY
   IbcFCTeaC7NnmRWVV9PCtyL0fyqMV7ZJG/oDbLWO9VIp5qSPc9Q06OQg6
   GnSaJwjzttXTcjmgQp8IiLYxThHWgVMjJ1YRqWco0dpoDbGQDgLu9eDNx
   KCM8C0MWxDa+r56y0JGzkndX3Ck5K15OiC+SXZRzh8dzbhLXrnY+oJKv1
   97thf5/1ohHKUH3/INgwcrDT8oWFkeCPJ4Y/73QAfEKPT1cmvVg0Xacvy
   VaMKQ2k0I4Uebxoawvks+rsSkjia6cm4G+Q4vlDvLrWvt3PtE+a183kwV
   g==;
X-CSE-ConnectionGUID: lYJ/rWG2SWqMK5ucYRXWYg==
X-CSE-MsgGUID: s4SNCJEtSRi4wV1dxCeO3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="84514983"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="84514983"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 14:56:24 -0700
X-CSE-ConnectionGUID: fN7+z58hS9KrTY53hCqlEg==
X-CSE-MsgGUID: a/MygxXlQBC2zuKImKJIGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="235686379"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 14:56:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 14:56:23 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 14:56:23 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.63)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 14:56:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmOXwqKFuesLFeS9gqjImmMYRocgxVyE5CbF7OGVxMkmBUx9ISU6w01uKmp3TIcLZloT74jRmQm6mHwuUi4ai/3kZIZ7vWUiPKdeXVefXeGVT3WRyg85tGwoDMdlVy0tqOEmVfp4LBStR0M5p8sS0vCbwA5kn7V8K23PSjg1bOKLDb0XSuaPfuUqv+7Fs900yFNOgRhRGUjGuupE3hew6eZ35w6SOBJaSBVCPRelVA1nauNmudQ/K5Cdujhhq0gqHc5VUcq4/5yde9X2lc0Pdxkr2UhGcwU7kZTj/NwNjGq2fEDD0y7CdHjVapMzoKGi1Bnji3HVCCDesEZ55bep8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oW3s8pdjxwFs/9uE6Qt0JkpBlzAjYiV0azUeqKY58SY=;
 b=XYroyA7/GtzAzuiQUlX48i8XbJR6PEQDV2So83Ml4R21xIziyrgvfHjBwvEpfrKRjKhpMEfj4OryptlfzMON3xvqv6VJSGc+D90yMDbG2JVKFUHfkBBfLU5EXTwRew3LT2510oFCFwCsmXIDXN0hdXQgzmDMdTKIXVo+ju3n57K2ZIwm1IsQ/UwBDI9Ir2IJWpu2ZtmYuRXvK3lg7ubiICdgOMFncXiaeA5IJI2N92fegp8wFdyOYti08LQ5LtzlUFUa+UFDuvssnFYtEEX+1aVUuaYPxy/3a4lIOsdyZtYorrHk0I9+x6FgeVJM1Mz6QnoP3wFpzplRsRZko7VFNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 21:56:18 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 21:56:17 +0000
Message-ID: <94b85874-ee30-4efe-a6ae-f8e40a260a02@intel.com>
Date: Tue, 26 May 2026 14:56:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 00/24] timekeeping/ptp: Expand snapshot functionality
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
CC: David Woodhouse <dwmw2@infradead.org>, Miroslav Lichvar
	<mlichvar@redhat.com>, John Stultz <jstultz@google.com>, Stephen Boyd
	<sboyd@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, "Frederic
 Weisbecker" <frederic@kernel.org>, <thomas.weissschuh@linutronix.de>, "Arthur
 Kiyanovski" <akiyano@amazon.com>, Rodolfo Giometti <giometti@enneenne.com>,
	Vincent Donnefort <vdonnefort@google.com>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>, <kvmarm@lists.linux.dev>, Oliver Upton
	<oupton@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
	<netdev@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Miri Korenblit
	<miriam.rachel.korenblit@intel.com>, Johannes Berg <johannes.berg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Peter Hilber <peter.hilber@oss.qualcomm.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, <virtualization@lists.linux.dev>,
	<linux-wireless@vger.kernel.org>, <linux-sound@vger.kernel.org>
References: <20260526165826.392227559@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260526165826.392227559@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0364.namprd04.prod.outlook.com
 (2603:10b6:303:81::9) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SN7PR11MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ddd610b-12e1-4661-0e49-08debb719cbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|22082099003|18002099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: zKJzGdn/dZln+cmcPxZhZ8g/Ckq/RRkN1o9HgoyYmThM/W6O+TsfrS6EUC6L9WdGHdWG7PENfTYVwCwuTUdO9Vz0v6l3QMvd+V/n0yTkikH/GrI722qaA94gRToS06sDeSeusVKWSbft7ElFpdb3D9csOXApcvPAcFj8zn7njXVZnOOn1n1vj5+rbzFS0057IdyC0svyXGLAYavit90cNgL3VZkvTyc0lmo4APLnEQRRypcocViMouo7orrluo+VHnYbywSKRt/1EU+V2b8rZWedCNwFGMw5pU7E+Qd86FMUkYLlEvMe4IVhY5PyzpkwXnZeqzYR+NfbCshMBRjvIrycDD0g/0qLlxot4Q83aBoOVKNmRu9oeorO6jnemJVr+86lCyT0cNsvFlj11KxVUM7MKu17Nt8Ubov59Gec2SVch6VEi7h3phmSWCljQvn7JgZQLAT4147V5ivaY1RLO/u36JQc/6vy55hkPO+7CDljvupY431QaDP2DddjI2+F4C574AkeomrvYQBFE62L1fLIX3YOHDksPpkdcJ8CLwK4xVHf3y/UINUUUUaxpDM71ZSjVqrqrbyUxSoDAt1uYw4/xFBl8wGtV7vHc7HW55B1GErH3VlEiV/xoAZa/il4hfzwte/YNxHJbujggFkrGOZ0K0EPldSuX842fQvuZn+sMsuxt3bBiv7QHna0KYFM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEJFcjFkS3hGZjY4WXIwMitmSTlBUUxnYUJ6VGFqVXo4dEhmMUEwakFWdzVD?=
 =?utf-8?B?aVM5L0FqNXFqUjNlQXJtVDRQK3lseDBSajkyVzZtNkxiZy9jVXpXbzhJeVFQ?=
 =?utf-8?B?eHNZcjh2M24rUFlVZGNTczhNLyszbTJUSjcyZUphQ2hJU29WdEM1SXBnamFH?=
 =?utf-8?B?VmRoU0ZEVlhPNXhEQ3llN0J6eXlkMHZvb0srUEhiakZnekdWNTlJL0daY0Rn?=
 =?utf-8?B?UHB4Sm1tMjFid1BPOUgraExMMmRXd2JGSWlOa2lQeENoMGtVbzJPZGdvcmpW?=
 =?utf-8?B?MEZjT2lNRkJ6bEZmVnpqZUE0cnQ4Wm9DMWMzRURxMnpYTW1nSlB2Z3JZUHZD?=
 =?utf-8?B?WkhFNUpWMHpYM3NRSlkyc0p6Y3ExU3lEbWU2RHd4VnlGRFlvN0JHUzc0OVlT?=
 =?utf-8?B?Sk1uVFhQL05BZXJTMUlWVHV0RWRrZ3hxZnJMZzhJYU5wN050dFB5L1FZQ0p5?=
 =?utf-8?B?aElsOURoR294NXdxaCsvVEdWakxkUzR5Ny9SR2wyeFdwWkxDcytHQWZ6dFJY?=
 =?utf-8?B?Y093WTRHU1R6WFFsY1FaL2FoYlpBR2Fyb0luRVE2Q0NsRGJ2ZmkxWUZqTzUx?=
 =?utf-8?B?QklYR1g5dStyUTVTNGcxbFNkdUxOdytqK3J5VkM2SENEaStuWDlmR2RlV0pG?=
 =?utf-8?B?U0gxYjY3WHM0djByenkrNGJLa0xnSFhVQVYwVi9Rb2JaY3lZbDUxbTJsbEI4?=
 =?utf-8?B?SStMa0pUN3puWVlNVFVUdlZCY1l5WWFVOTU0cVZKRER6QS9Lb3ZkeHA4UnB2?=
 =?utf-8?B?U25JcU5kSzRGeWtuc0RaWUJ2Q2x5cHVDWnhLRWYwTmtSZEdEU2ljNzVmUk92?=
 =?utf-8?B?OXdTV3dSd2E2QUExMnNvWlpDdlR6dTBNQmIrMmhBaTRvSEJGdU1wM2d2aG5X?=
 =?utf-8?B?L0l6OEg5YU52QXk0MWV0b0J6bXlydS82eFcyVmVUZ1prQW5kaUNkcTBXc2Fl?=
 =?utf-8?B?ZktXdXB1Vnp1TXRTS2k5TEVyeE12eTZ5NnFQV1RpdXl0U1JjRWhXM3lFMnZU?=
 =?utf-8?B?S3JYNy80aXQ1dUxEeXMwN3UzeDJoeUIvRkg3bnhYVFNmWGtGeThkd0l4VUtm?=
 =?utf-8?B?RkNhRUtxV0NwaUd6S3NnL3pRQWdrdk9OUG50M3libFNmWGZITFd1V0hBVHhY?=
 =?utf-8?B?Q2ZORkFkdFpJSlc2d29NbGZlOFo2Ris5NWZtMi8rbnJ0Umt5T3lqSEdmcHo3?=
 =?utf-8?B?dWFwZXVNTVNSdk5JdkdyOGJLdjBHbDA2TUVuS2FtZFl1QU1BN2tIdnhjSXBa?=
 =?utf-8?B?NDluSFQ2K3BiMHovcTZlejVZQUdjYlhZQnU1S3FOMXhhZGFiTGgxNy9SWXJ4?=
 =?utf-8?B?cDJKMUxxZDRIbm9Wck1LbDNFd1A2SmtpTThXbkxKOEpRNk9LOWtNb1R1NUJo?=
 =?utf-8?B?ZmtZVFFZR09KdEVCVGNBclUrb2p1dG1ySThWcWtuVjdTbHZGclNvYlhDYnRV?=
 =?utf-8?B?aGM0Vk04dG5ZTGFCN3NDUXkyaDlUenRKdldnL2VxSk1tNG9IR1FzaGtkNUt1?=
 =?utf-8?B?NG9HUGx0T2RLOGN5MVBvTXgxRDFVcXIrMjVJWUlCd0ZDMVBDNXcxNHlMUDd2?=
 =?utf-8?B?UkRnQ0tSUUNGY3l0WTlSMjUzbXllVm8yZWQ2VUFEY0gyQnpYVGppRnJZSDVP?=
 =?utf-8?B?ZXpORXp0ZWZXZGFTSmYzeHF1SzVNQ0ozMlRLQjVoSEFISm0xaVErK0F5aTRP?=
 =?utf-8?B?WkNpOEdqY0Rrc1I2ekdRSC9mZitQWlRsSHVYT0wyQXV4ZXRCQWpKTEczK0RI?=
 =?utf-8?B?UU13OTRaellpOWZPeFZLUm92Z1FWVTVCNTB2bTcvdVFrQ1hNekExZGtGQnVr?=
 =?utf-8?B?OUVIdjNoVmt6NzZPYm5XR1BvN0VYcWhhMDVON2pFVzNrZlVnanNqMmRuREs1?=
 =?utf-8?B?MnI0a0EyZzFNbFFuNVVWVGhJSGxDVC9FSVZLMjVQZHZYdnE1WTcxYlBzOXB0?=
 =?utf-8?B?MTdlQ1hjckYxbzd0MDVkbTZzd3BPazY4bUpDWlJQT2srMzVTM1dwV2N2a3dP?=
 =?utf-8?B?WWNPSk11L0FZaFVKRzdDMnFjbjBXa29KZDVibCtsci94cEU5ZklxSUxMVzRx?=
 =?utf-8?B?azR1Y0VUbUdHMi9SMForVWJ6a0ZIWGRXbE8ySkNnR2FGOFR6L3dndXNHKzRj?=
 =?utf-8?B?a09wY25sMmxPRllTd2NlNzk2WnV1YTdqdU5wVTI2NjhlTXlFaTYxUU96M2dL?=
 =?utf-8?B?ZmZERTRiNWxaYUtUWFRMNmZVUERzNjZHa3FNNWtDK1NaamZadGRjUFFJQU9L?=
 =?utf-8?B?a0FYTFMwUGMwU0Y2b1VTVi82aFI1UTBvUGl6K2tadlZYVS9GcDF3eUhuNk9j?=
 =?utf-8?B?TitNdk4xdVpJT3kvZVplSHBDQ3hnT2ZHNUVYMlVpNUNiRGVGSWZQQT09?=
X-Exchange-RoutingPolicyChecked: HPmdUfOCUuJ3F48rvA1fuMO8SzxUr9Zr8evOeSys6PVZAzGbi5+J538fZYgOBXi61ek2Vb0TGEzLKCSNuv65ApW8CazIuemM8qtAevBOdYyzyIBr1x1C/WLMImrCO1etFyH+L+ZxewJ9pzF3W97nSNKsiWgIE4vKkxC9Cy3d08bOhRSnSY4lhNicWXsco7sCHvTPxBhcWxo3hJml7Y8ZNnL/gpNxKpbbeN6tJZEXj3zTasC2q3Z3IjmXtMawr/x939c4UZPNP33cSLL+XLoE7dKDJEmZDaMAQd4bEgaphJwU4YG7eXR1JpHEMjm2Yh3cT3RmSdL6rTMkitjxea7SBw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ddd610b-12e1-4661-0e49-08debb719cbd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 21:56:16.9867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3HbP0Aese92zPlYCeBMZyCteLeIgMSYGO2q9MMhJN2sy8B85RSxQ9ALXqQdVwNmn3vB1DkPZxOc9+6QkeLjNZuRU8dDKwCglyI2ri/EZXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7540
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	TAGGED_FROM(0.00)[bounces-36936-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,enneenne.com,linux.dev,lists.linux.dev,gmail.com,vger.kernel.org,suse.com,intel.com,nvidia.com,oss.qualcomm.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: ECEB25DD0E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/2026 10:13 AM, Thomas Gleixner wrote:
> Sorry for the large CC list, but changing the inner workings touches
> unfortunately a lot of places in one go.
> 
> PTP wants to grow new snapshot functionality, which provides not only the
> captured CLOCK* values, but also the underlying clocksource counter value.
> 
>    https://lore.kernel.org/20260515164033.6403-1-akiyano@amazon.com
> 
> There was quite some discussion in seemingly related threads how to capture
> these values and how to provide core infrastructure so that driver writers
> have something to work with
> 
>    https://lore.kernel.org/20260514225842.110706-1-hramamurthy@google.com
>    https://lore.kernel.org/20260520135207.37826-1-dwmw2@infradead.org
> 
> This series implements the timekeeping related mechanisms to:
> 
>      1) Capture CLOCK values along with the clocksource counter value for
>      	non-hardware based sampling
> 
>      2) Expanding the hardware cross time stamp mechanism to hand back the
>      	clocksource counter value, which was captured by the device, along
>      	with the related CLOCK values
> 
>      3) Adding AUX clock support to the hardware cross timestamping core
> 

Overall the series looks good to me. I made some comments while
reviewing but nothing major and I think mostly it was on interim code
that is removed by the end of the series.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> It's based on v7.1-rc2 and also available from git:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git timekeeping-ptp-extend-v1
> 
> Thanks to David for rebasing his PTP/timekeeping work on top and providing
> feedback, fixes and testing.
> 
> Thanks,
> 
> 	tglx
> ---
>  arch/arm64/kvm/hyp_trace.c                          |    8 
>  arch/arm64/kvm/hypercalls.c                         |    6 
>  drivers/net/dsa/sja1105/sja1105_main.c              |    8 
>  drivers/net/ethernet/intel/ice/ice_ptp.c            |    5 
>  drivers/net/ethernet/intel/igc/igc.h                |    1 
>  drivers/net/ethernet/intel/igc/igc_ptp.c            |    4 
>  drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c |    4 
>  drivers/net/wireless/intel/iwlwifi/mld/ptp.c        |    5 
>  drivers/net/wireless/intel/iwlwifi/mvm/ptp.c        |    7 
>  drivers/pps/generators/pps_gen-dummy.c              |    6 
>  drivers/pps/generators/pps_gen_tio.c                |    6 
>  drivers/ptp/ptp_chardev.c                           |   18 +
>  drivers/ptp/ptp_ocp.c                               |   11 -
>  drivers/ptp/ptp_vmclock.c                           |   25 --
>  drivers/virtio/virtio_rtc_ptp.c                     |    2 
>  include/linux/pps_kernel.h                          |    8 
>  include/linux/ptp_clock_kernel.h                    |   15 -
>  include/linux/timekeeping.h                         |   54 ++---
>  kernel/time/timekeeping.c                           |  211 ++++++++++++--------
>  sound/hda/common/controller.c                       |    4 
>  20 files changed, 236 insertions(+), 172 deletions(-)


