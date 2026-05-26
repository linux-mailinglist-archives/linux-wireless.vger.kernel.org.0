Return-Path: <linux-wireless+bounces-36931-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOzdIW4VFmojhQcAu9opvQ
	(envelope-from <linux-wireless+bounces-36931-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 23:49:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6432E5DCE03
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 23:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7353C3012E84
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 21:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AC03C2768;
	Tue, 26 May 2026 21:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LOe0iXwI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EA1351C3B;
	Tue, 26 May 2026 21:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832162; cv=fail; b=P+ja3Rx6HFWtVpsR7pK8OoMHKRBOe0F2O09IvAO/Qrj1pEHUqpzddwYWgWp7UE+N6S0luOAD0flcVsyNzzSr/oiQqXWi6LqODVqdy0ga1BjJJ8Qga+Wnm8q3ZGtuKie3beH+DDbG9RD7PyrfdJ20bvP+qop4S4T76lLLusJ/MbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832162; c=relaxed/simple;
	bh=wrsIPDijdN+ZuhlDKpNFtLInU3bTOY5FIJCr7+SCsF0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UShpiro+O0xk3aScK3wR2NBTDfQzrD84cC1eegU0tVBllkFhj6CVeCvuhLzzN06mqk7ZsmkHqAcxIIT+Etpu2rFBZW9VYv9Ap3LPld6UQc9zjsllghDvpKEKrVsNW4vhJ1WY46wVDbpbRa0+0GoBbulREYIKh63CUUZYhEc2fNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LOe0iXwI; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779832161; x=1811368161;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wrsIPDijdN+ZuhlDKpNFtLInU3bTOY5FIJCr7+SCsF0=;
  b=LOe0iXwIvn9wEbeifDo9/qv1+YdT9NwJB49n6Pk8R8C3kKMuSgI22M69
   gyGO51uGyFePoLsAuutb6qeXx33/DXTJv0JgeZkXVuPTRONE4yOl2ETuA
   MOD3lmrD7HiS5ruYWpUYVDXBSSq37Ps+Hi3DOb8i9Ik+ommHeGt6pQCoc
   d6SOIKf7v2LIWv98VDurWpJiTMSTcF64EQXbuCOxPi30B9BvvGC3XvXby
   rD30gNOAmhxJVFlZcasQF6LKXrUtnSq3C3Z6sRYyQKcxtHkOqmgBNVJI3
   2IJ7w7+E0368Lel2RstpagqWdATPmfNq/foUVxTlPnxFXXwOS+dbwoOoi
   Q==;
X-CSE-ConnectionGUID: be/vl6BDR6i1ha/9Y43WMw==
X-CSE-MsgGUID: 482lGBwbT3OZ2xrlbBgO8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="80507360"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="80507360"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 14:49:20 -0700
X-CSE-ConnectionGUID: oOivFXj0QjSFD0ErEoto9g==
X-CSE-MsgGUID: uMMjHfYtQC62Xuq4dWjLPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="265907806"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 14:49:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 14:49:19 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 14:49:19 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.68) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 14:49:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6Xqs+7T4wzW6hHeLn5iig+DebbxBf3IGSYeMk+AMoTb0kaxZCddhVUt7QFIinbz4nVHhAnV4+UtdyhcNmeavr+1JYmIbhgTyl/s/kAd1GaQvG7IAiuBoFzuJaKmXaFh/ehX1o97P9fiZ1V3D0Euvq5Udkf0tjyxrRz3OVIJpKNfujBRCe/XNYsNiNr3JBzHJlq1ZQzoS3xt/PnLjj5EpgEr0rDwatWXhMExnUfZwlJzEFtSZgnHgiqf2eF/1Y9Ej9TsT1cjAMcQyTouVpXUzZrYWBbI7FOc2KfuA8SP+X8qchkhCQl4ZU5411ukvkHi2rS0WnfFlP4SoznbJZzBKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgnIh6/obKyVceiIaSYRUhcEJXwnAAASzeCIn/OP3u8=;
 b=wwelXcXWKlsARb4xUGf6UnjlN1gZ1j2mYQYrIWxFifn3zIDPhmwro0Gc5Mh+R3xKrStO9l8ixBfJaPNxKbeHYndkIqcDARECQI0HxNIQ/NIq70YZ1VjN03n6IVDB71iq+PfD2ykLEywBKOl3Yhd06MRwGQ5Jlol0tI1+VqNFYVzmP+cuaMD1kkjYrdImiGkseGXcl5NVqmrfyTzrUhadAytDLiEDi5KmmOYPBbkOAxZHL6UK76azETw9CN9cCo5OQUFVG2Wso10o04HmqbyFdEnJkcK/nTJErSy3wo5qsZ+xtrl7rLuOgW1ZJhUA+SmmO16TuAMrLS2TXk62sgJUHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by PH0PR11MB4888.namprd11.prod.outlook.com (2603:10b6:510:32::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 21:49:16 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 21:49:16 +0000
Message-ID: <9819b5ee-1f03-4687-9a36-9284741e19a4@intel.com>
Date: Tue, 26 May 2026 14:49:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 08/24] timekeeping: Remove system_time_snapshot::real/boot
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
 <20260526171223.300914258@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260526171223.300914258@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0243.namprd03.prod.outlook.com
 (2603:10b6:303:b4::8) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|PH0PR11MB4888:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a252b61-f52a-4cdb-d296-08debb70a1f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 0LAnseN6mHLIDRQ9j2T30Y130UPQ2vwiNXEu9vqzzQr5dL6jgKoH/wMluvhq3HQOejmQ4PM4b5qJgXAdFPEXI1qBuCWS5QANj2OGt/BQLprVNfJgRh3aKRQxLuvUjh4n7zx8rcQWVI2vx3UNZuQnxNeGJWchm3c5pMwPOV42Dp8qT/BAERIji5SVXhLmA4A/4/pH8l2mD73Lu4g3fXh+hd+AVcNnH8WuUu7m5AA/avz2YGjh72xqY2jy/ANLviNEa7w5MB0119AGhGH2TmGrnnoGD4pWsM85lH+Bo1efXBRhZOKDElJPAeGfUUwgHS9fUvhEKFQLAtB0xNRv4aFunvro3HU1JJzYZZBB5yOPPvR84KqPwR1uD1LoIDRj2zBwP8xSACbZs3nsgcdLzhErW5X2qtEGnB1Bmj4xAIcDdCUX+ZZqALObPUwOThQ2EzLzdzZy/gEIwJuTo0hS5WJ3MzaUBr9Cgv1dIqVjoilwoJMStlmJV7bFm1z3MYkdQabODYvX5Re3SulmeHB7z4jiZUk0vdeFM/Ee90TtaSxd3YJcSCzWyFo/fl8tHyIxr+vfVsqaWZf+aWr+NOEQPK6sAmw8ogfJKbpO+Pv7bn9Kj6RwMimhu2SHX1SuAkquNWagE2Uwq5k7BlICd6R+c9jnWlg5fMUnDrfOoMBSgiuLIwRmaxb4Qbw69Vn/gsI1vx++
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1VZV1BpV0Irc2JCWGJUOUZZNmhOQ3ZxZHpzOSt3RldlUnhQNitsc2VGdmY5?=
 =?utf-8?B?MjRIdzZEaW9CLzlPOGliNS9ib1F1blE4eldNcmVjdll1MkhmaW5iUHl3ZEhU?=
 =?utf-8?B?R2t2VVdrNmVlWkVpVjQ1ZHg3NWdwYkJSKzhmY1RpcklYODVpemd6aU11NXda?=
 =?utf-8?B?cnpxOExSb3FFZ0tENnJSR2l2a3k4MnVDRGJrVTRFNmY1Ym1sb0JSSWlNT1NR?=
 =?utf-8?B?ajdLM0Naa2xkcEVsMVN3Y3lRZnl5UDQ4aDBDRVY0OVpCVGYzbDhwT0xlWCtj?=
 =?utf-8?B?TnVqRERHN3V4MUthbjQ0YVgzQ0tNcGFFYjBMbnBDa2d1UGFGbHZCYTZ1a1Q3?=
 =?utf-8?B?UXBXQW90ZlBHL0dVa0xWb3BaVlloTU45OWM0Sk1VSXpqWEVqQmp6SzAyMWVN?=
 =?utf-8?B?SElEV2hSZGJrdWpGOVZOeC80eUdvRUROYmpuZkE5NWhwRG9aeWlqZ1R4WjAz?=
 =?utf-8?B?R1ZlVkkyZXNFOTc5Ynd6RU0yKy85c21PUFAxbUJUTVkvNU1jcFBtbjRPbUNk?=
 =?utf-8?B?S2l1QWlNOS9icmNSTWo4VERFaHhLT1pMWWlLUkhMMkhIeUszSDl6MkwzWSth?=
 =?utf-8?B?bUM1bjJYU2Evd3pSRUhPc1p4QXNUOFIzaWU4YVdMcjFVNVpVTUJDMWRVL1VX?=
 =?utf-8?B?WmgweDB5aE9EUzV4MTU1cU04c0lQOXlxdUJCbWEyMldyUXVKbGhRanpMemlQ?=
 =?utf-8?B?bjdQWDladU9LeVhJcnJzSVJKOXgvZE9NZnhkNzMyS1RVN3NZUFd2dkRnRmhz?=
 =?utf-8?B?VGZoNW9Kamk0M1ZiYUxVWXdGUkFEdWkwTkFFdk45TkVOdEkvMm5sNXVpQmhD?=
 =?utf-8?B?bUtlTHVHeHpvd044RTl3VDlGem0xMnNZS3NETXNkSGliY1FNZ0hNQVdMQ0JW?=
 =?utf-8?B?ZVlET1AzSjV1L2xhQW9xQ2xOTmdEMjhMN0hwQjlEM2VrNjJDNHFCMkt2SkFP?=
 =?utf-8?B?MU5UbVM4VTVCNDVmdVo5Tnd5Vk9ublZ0clNHWVZsSG9KU244T3dERWJuaHVt?=
 =?utf-8?B?YVN4UHR0dnlab1JZMjcvemt2cjZOUDFiQUdUemQ3TCtLY283bW1aWlVmQU1C?=
 =?utf-8?B?bzNwUDE4WFF2RTh2MDBWZzRMOEs3RldHQ0drYk5pM1RYUTJEbXYzYlBUMHNX?=
 =?utf-8?B?Rnd1ek9meXdnR0hwME5iYU1ROVNGVDBlNmVxOTVqbE5rSWJPcFBBRVdZWTFO?=
 =?utf-8?B?QWU1TloyRUg4OGk3TkFieGpvVmdlaFRGaXZVeXU4NGc2VU5GajZ4d1VWRnpk?=
 =?utf-8?B?ekxHdm1Qc1o4eUxFd3Y1ais4U0pSaldYOFZKNGtoTFRNbTQ4OVdmZ1A5M250?=
 =?utf-8?B?QzZPYVJINU9CQml1YVZLbnFyL2xkQnd0a1ZVVVBxa3JYSFhMMCtyTlRHTlpX?=
 =?utf-8?B?WXY4SDFuTUVmVVlsaUM0N1Vwa2FJQlQxbkFTeXkyOE1wNmg2eDhuMTk1dDRK?=
 =?utf-8?B?SUxGbUVpUmxOQ1p1V0xCUUxMemxGSFd0aVlPNVBESTlpcVBzdys3dW5JQzc4?=
 =?utf-8?B?eHYvVytXdUtkR0VMblg4Sm81aUlRY3pFRGprK1VVWmFnS1VnSXBZQ3VKUmYz?=
 =?utf-8?B?cWZFanl3TllOSWw2ZTFTaFU4UGptMzhOY093bDZjREZtNkVlUXFtWTFTWVMv?=
 =?utf-8?B?bGxDMTJ1OUQxVWExRktZZkJ1N0dRUnRlZ2FvK3o4d0YwdVh1RFBjQjg1Uzla?=
 =?utf-8?B?WGgrSkRCVjBkRHNMdGdoR0EzcFdPZ1JKK1Bjd3d0R1V3a3JaZzErYzVYUU5r?=
 =?utf-8?B?N2d5TzJFcS9BZlBtZVlDY3hvWWZ3WkdySlhYQnEzMmVwM0RGWktrSEh0Wk0x?=
 =?utf-8?B?UXE5L2VxSFZFUkZ4SUdwV09USWd1Q1Z1V1VVZlhWVVhyNDhONW5weEJheHZ6?=
 =?utf-8?B?R09SRTVJWmNVZW1IU1VYaUtrV0tIaGxsS0k3QWRSbHVQTkg3TFA4MGd4NDBN?=
 =?utf-8?B?cS9UcFg5dkQwb3MvdnFBNTJ0Q0NJU0pRZmNpVE93dURqOGJudUgzdW5WU3k3?=
 =?utf-8?B?dTlkM2hqY1lBZ0ZDODByZnJXcUQ1dnNCZ0hzazVyWUxaN3hSQVg0OGNQdkxC?=
 =?utf-8?B?NXFiMWRVcXFlOFIxUzkwbE44SWE5M0RNOThPczQ5SitiOHhiTjQ0VW1XM2FO?=
 =?utf-8?B?VzlaOEhiUCtmcG5FTGpXV2R6ZzRSVnBlOUlMZnpmZlJJV2FTNzVGcDVFTmV6?=
 =?utf-8?B?NkxraUxHVkZKN1doamk1WDZqeWFSTkQ4ZGtqS280QjZwSjNhY2hOVi9iRHZQ?=
 =?utf-8?B?aVZlNFhQRUgreWhFbFRCSkhVK0QveWxRT1I4NnZBRW5VZWVQL0dKU3E4T3hC?=
 =?utf-8?B?VWk3QzRrUG81NzBNdUtCNXFxWDE4R2k0dGpOTWFGM0tKZXlVNWY3dz09?=
X-Exchange-RoutingPolicyChecked: SQ/ooREL2fSjt8/Xv4E+1+n6Ir4Iai5QLNL9OQRR9yJybee6jrUcksYb1w+BIQ2XEi5ojZql3LtNVCn95lMoRMQPtX//0wynhGAcvblDl0rXWX/M4qDXVLeKbrPx6U606q1AkjmnQhTZ3crje0B4LyRbcL8H+b5I3CsmJLajkriLPlwR7ls4Nd69qlSQNFE3mmaP9ejYcFE0BmY88P8cE3D+tNQp4+z1FTTBKczk7lxboCmd41Nc4uB8XMhlbu/ASqO4I83akqJb8BShRAmmC+ofxmxE/Wes2bHty0kmhbUq5lmb8Yn2JEzyjDIdSgWL+S8QCRL+UYa65uby8ldmEQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a252b61-f52a-4cdb-d296-08debb70a1f0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 21:49:16.2200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4RXVgazcFpK5EM2GflSIAJsTaH7R08RORxqKzTEu+UlSBw7SQXp5PCiDWw9TGXTIiXhs8bGDUB3lHe674JKJK5DHPYzJP62h8+gZh7lkzwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4888
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
	TAGGED_FROM(0.00)[bounces-36931-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,enneenne.com,linux.dev,lists.linux.dev,gmail.com,vger.kernel.org,suse.com,intel.com,nvidia.com,oss.qualcomm.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:mid,intel.com:dkim];
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
X-Rspamd-Queue-Id: 6432E5DCE03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/2026 10:14 AM, Thomas Gleixner wrote:
> All users are converted over to ktime_get_snapshot_id() and
> system_time_snapshot::sys.
> 

I would have expected this to also remove ktime_get_snapshot() since the
description claims all users are converted to ktime_get_snapshot_id().

> Remove the leftovers.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
>  include/linux/timekeeping.h |    4 ----
>  kernel/time/timekeeping.c   |    8 --------
>  2 files changed, 12 deletions(-)
> 
> --- a/include/linux/timekeeping.h
> +++ b/include/linux/timekeeping.h
> @@ -280,8 +280,6 @@ static inline bool ktime_get_aux_ts64(cl
>   *				 a selected CLOCK_* and the clocksource counter value
>   * @cycles:		Clocksource counter value to produce the system times
>   * @sys:		The system time of the selected CLOCK ID
> - * @real:		Realtime system time
> - * @boot:		Boot time
>   * @raw:		Monotonic raw system time
>   * @cs_id:		Clocksource ID
>   * @clock_was_set_seq:	The sequence number of clock-was-set events
> @@ -291,8 +289,6 @@ static inline bool ktime_get_aux_ts64(cl
>  struct system_time_snapshot {
>  	u64			cycles;
>  	ktime_t			sys;
> -	ktime_t			real;
> -	ktime_t			boot;
>  	ktime_t			raw;
>  	enum clocksource_ids	cs_id;
>  	unsigned int		clock_was_set_seq;
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1196,8 +1196,6 @@ bool ktime_get_snapshot_id(struct system
>  	struct timekeeper *tk;
>  	struct tk_data *tkd;
>  	unsigned int seq;
> -	ktime_t base_real;
> -	ktime_t base_boot;
>  
>  	/* Invalidate the snapshot for all failure cases */
>  	systime_snapshot->valid = false;
> @@ -1239,18 +1237,12 @@ bool ktime_get_snapshot_id(struct system
>  		offs_sys = *offs;
>  		base_raw = tk->tkr_raw.base;
>  
> -		/* Kept around until the callers are fixed up */
> -		base_real = ktime_add(base_sys, tk_core.timekeeper.offs_real);
> -		base_boot = ktime_add(base_sys, tk_core.timekeeper.offs_boot);
> -
>  		nsec_sys = timekeeping_cycles_to_ns(&tk->tkr_mono, now);
>  		nsec_raw = timekeeping_cycles_to_ns(&tk->tkr_raw, now);
>  	} while (read_seqcount_retry(&tkd->seq, seq));
>  
>  	systime_snapshot->cycles = now;
>  	systime_snapshot->sys = ktime_add_ns(base_sys, offs_sys + nsec_sys);
> -	systime_snapshot->real = ktime_add_ns(base_real, nsec_sys);
> -	systime_snapshot->boot = ktime_add_ns(base_boot, nsec_sys);
>  	systime_snapshot->raw = ktime_add_ns(base_raw, nsec_raw);
>  
>  	/*
> 


