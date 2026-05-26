Return-Path: <linux-wireless+bounces-36935-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOXRFIwXFmrOhQcAu9opvQ
	(envelope-from <linux-wireless+bounces-36935-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 23:58:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1397B5DD039
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 23:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 856D730BB82B
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 21:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1584B3C9890;
	Tue, 26 May 2026 21:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e2QlPQcU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A2A3C8C7D;
	Tue, 26 May 2026 21:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832414; cv=fail; b=cmTwhrhQOvs6ZWpkZVBgEYs9/KQ2Co1qLbNMTqOtpG1DAWYsDniUGi8lye5QRdN8XrCWbO1pWvuQVtUAonBJ8zceZQUNpY2vleSu0WZQl6lsIiwtdtmI82HSNOqKJPQAAPDublt3dJ89Dkh7Jfci0lpPx8fPQcsw6EUifRBqMHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832414; c=relaxed/simple;
	bh=wyMhGVvnjuiTna0QT+hZyKmYAc0HmazbMPLb6wny3lc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wx0Nl6GxTxS0Klm+EttTJwPjFE4J5Yjiq72lNcUae2tGng0zAYeucTC/y9vfUT49fGvoDEmyLdGpPvi2+A1lVoBU3whyGuGZRGzmxaxGww+EaOi1G4elXPpFKRu65MPdhpmQypXv6jElW8vcpGUb9MwWwUe/oGqlfodEm6tXlh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e2QlPQcU; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779832413; x=1811368413;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wyMhGVvnjuiTna0QT+hZyKmYAc0HmazbMPLb6wny3lc=;
  b=e2QlPQcUkRbZLFjVQSf7H0ksIqEU+kl0yGTqDjL+YBLFHJ6kE9m93WAf
   q0T1Vqfg1F8CHHb/MHotH7dAF7vAuG3oA3aKb4dlqcM/TrSnAznnerY3o
   6qR1IosQ6TLDrTElHjJfGa1l/WypYUv5AxX+NQz/d0GskSytqA7UFDbPT
   1UGeAGaHv0FBH4QiBEIeYJBhuC3rha0fq++9OMDsz2o7HnrKbnaGbL0I2
   485OFyD92zJoN8NDbvdIKvKzhB0RlCqSgG5n4LAGV4DJ7ruhuDN1MyyPI
   TesdG7eDevN/ipiM0RFkaYBI7kSB1M1qVsPFkmvsO5+jOrJLIYPoHOPMS
   Q==;
X-CSE-ConnectionGUID: aOLSsSpATIm7+qNj9j6lhg==
X-CSE-MsgGUID: XF8U13NORla0RVutMsdiTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="80690985"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="80690985"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 14:51:58 -0700
X-CSE-ConnectionGUID: 9skRG26EQwC5vNv49Oi0fQ==
X-CSE-MsgGUID: jCr3nFoMQmO42iIzc+XKEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="241884672"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 14:51:57 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 14:51:56 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 14:51:56 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.10) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 14:51:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQYFCl13PMhOTaByEOiz4Wum3WGPpUHhvvaHGHloLvLZz0kwQG76wsWe6F3U8i2G0Q0EmLT9Da5BWP25HvSRi9pHtlco4qhOjuNQ0jMa4iWVXasKpldlxIwbz9ZDz+XW1GXY7dRMJLt4UMoboP2qTEWQ20hLwFfaQrhQGxcJe/TALOm7BXrAnCFrIa4yrRGF9thTRuntGR5x5ux4ZJ9pKWhSgy6A9GsFffV4brT3sWVmCB6opFK9CROCe3ErLpTgg+CBo5cq+OBQSZkXsDd0Uj6ACtqzbPHucQZB9STGiy6cyGjyI3ay33urQ4Nm2OClTAD+46deVPiklog0qOgWeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WERpPhaelWKqd2cWcAYwy9nTCDdZNrzSzXJEfoQUpv4=;
 b=jT5VBM90iTg4ML5CLQTowFdY5596xI78QTKXss1zSv8Jk9IrGMcH96p/EQeQHpKnogwUYZfPj0NAOPfXFJBV1M3KGBBtFxPwAzxBrWMuYqCvtvJs6KrKzUUKPIF2Knc0du5tfmZKh2/ZtErtJZy2/vcTuCa18z3mZ4xXcywSuPSS3Z6C/pAx3VWMuLVajvuOwRYd8ioclyaLspSVnZ+g6yzbgQRgsusL9zuyQhEmtAIwk3RCCUIXRRQocpyzRTLB7zENnJ1Mzkj9GRKxVMeD/jQLjaS9CfCjhAwb3KAZgR5wllF6ZfOVYGkVNUuTxhIls3cFyOGdhk/VANQ3Nmd7QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by PH0PR11MB4888.namprd11.prod.outlook.com (2603:10b6:510:32::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 21:51:53 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 21:51:53 +0000
Message-ID: <02ae20d5-95ab-4de6-9776-ec3f2bb7b61b@intel.com>
Date: Tue, 26 May 2026 14:51:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 14/24] igc: Use provided clock ID for history snapshot
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
CC: David Woodhouse <dwmw2@infradead.org>, Miroslav Lichvar
	<mlichvar@redhat.com>, John Stultz <jstultz@google.com>, Stephen Boyd
	<sboyd@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, "Frederic
 Weisbecker" <frederic@kernel.org>, <thomas.weissschuh@linutronix.de>, "Arthur
 Kiyanovski" <akiyano@amazon.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Rodolfo Giometti <giometti@enneenne.com>, Vincent Donnefort
	<vdonnefort@google.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton
	<oliver.upton@linux.dev>, <kvmarm@lists.linux.dev>, Oliver Upton
	<oupton@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
	<netdev@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Miri Korenblit
	<miriam.rachel.korenblit@intel.com>, Johannes Berg <johannes.berg@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Peter Hilber
	<peter.hilber@oss.qualcomm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	<virtualization@lists.linux.dev>, <linux-wireless@vger.kernel.org>,
	<linux-sound@vger.kernel.org>
References: <20260526165826.392227559@kernel.org>
 <20260526171223.745281238@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260526171223.745281238@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0098.namprd04.prod.outlook.com
 (2603:10b6:303:83::13) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|PH0PR11MB4888:EE_
X-MS-Office365-Filtering-Correlation-Id: ce42d2df-6ee8-4fd0-3cfe-08debb70ffa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 6tXRiF6H0aA/Vf8WQCG+1ErVrcSl1Ie/sSAOnMk1YGALXN5DbXzNwF7SBs9L2ukkgXX4Ie4nJZwxzSGsH2hZTnMlGWEaONOMxHKoTRuvK4FF6qJ6A5VEsrWnFGz7drkhRTBf7DB3GoLEINICA3LOaU11Tg0bN1yPuI5Rlnjk14LWsyWoS0oZaFaT26KtpgwVtAoDTmswwPDLghzu8EbYy0v1iI0PkhmhABkU2zqkt7GP7tfQhRy+HHzl/5RNG+lGQjqdrqcfxLJx3eUIF7c/qJB5qvt1KclmoaYj6HyAGDFZCBmbI9HeIP/TQgFGJlYCc4I0nU0OI9m0bvhlAvB6WcLXF+6EKo9KNjB9uHgDUUCsOwZJfJ4Pqo8oXR0/L5a8+Q+r/2BwKUgxsn99Sej+7Cl4rx6hJyqhHzNWRxjjS1jNnqlfAQH4dT7xjiUzV7CRS2GFxgW+ulPWRupvqYxkWF4PebsmqmU9iCguYsL5L8xqaJiq+SpYa4SKAzSSrtNPFot/7jMn83vJUpyiy4SOl0B1LHcMtWFKajOBzefSZYB/XOcBCyopnsSd8c1koJQtyp1AF5qRK+lOaI0Bx0/AgeJ2wq0Yyl5Pao6IMQpvZga34PaoGGtRcpRZAtGgzSgktNU1vyCL/wakcw7kdLk/RgaOp9WXjO8PCHTa3qjEjaY8kZeZH25BZy5CMafLf3n8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEZsVERpeGJmTlJZTi9ScXdkUlpzdVIyMm5NR2xoRGNKY2ZLZ1draWg4L2I5?=
 =?utf-8?B?dzRQbEl5LzVYVFNKM1NlZ1lWQkdMSXFBZVVyK1lnalRva3F2Vm9XYjlVY3F5?=
 =?utf-8?B?VE0wYkNCUlJEZTExSTdOdnRsaDhkdzVrbWJBdDRSU0tJb1Z1Q0xmZkNnRkN6?=
 =?utf-8?B?TlgySFVxTDFiU3ZOeXZLTGltb3VBWkJTN1psd2d0MzJsN1FWOTVKMXFyZHAx?=
 =?utf-8?B?SGpndmJMS0RLTnBTd21yblprYWY1K3l4QlZaQytpNGRtQWdURlhJNWgxQ2p6?=
 =?utf-8?B?TVplRzVlemhZb3BSRjNjSlplY1c2aDlnQkc5STlRTUl0Y1RBanN5dUQwZjQ0?=
 =?utf-8?B?Rk1aTi9JcTNhUGVjMkw4OGI3VUVpQ3h5RGFNalowZVpQaTR1ajBWTXlhVG1Y?=
 =?utf-8?B?RU9UbDlDZjVTZDVEYjBBazlmQnh4VjNHVjRSTlp4ZnZ1OU5QR2srM2tydFg2?=
 =?utf-8?B?SkxQdnpBbSs0dFUwNEpDL3Zwcm4rUldsekdxTDVNZkpNN0Q2QVM3Q2RvUmkx?=
 =?utf-8?B?OHZxNGdsTERuOVkydWpGR1dxZWs2U0JmTG9QNmI5d3BqTWVzaE9INTZIdStG?=
 =?utf-8?B?eEpZV0tPcGd5ZjdnbFphZ2UyYUE4dzVGTTFmTFhtdlpxQ0V4MzVWblg1OWJN?=
 =?utf-8?B?cnVhTENrcXNMemNDbE1PQWhtYTVadDBkUVZTMEdZZDdVRzAzRUFjQ0t3ZWlm?=
 =?utf-8?B?RVE2UTVMRVM4WFV2Sm1rSTZzSWlIUkdWVzlLTy9ROFQ1c09IdXRqMmNXVXdE?=
 =?utf-8?B?YkRNZ20vaU55Z3JmbFZsTGVBOHc4TlhWaGlINVdYbnFNU0NhQWR0Rzhrd0VC?=
 =?utf-8?B?MmR5dkFyVmF4c3JQVS9xUnpYSmFVaTE0RjFiTENISG8rZFhJSkRzcUZObXNo?=
 =?utf-8?B?R1JCeVNLWXVPMmxwNGpWZCtEOVZQa1RFbzUraFhUejk5L0dEdGgyVWd2YTV2?=
 =?utf-8?B?UDk0MjJwSkIraGVZWWR2OFJYZTAzL0NMZmpqbkE5U0hxZk9DcTJxTVRpclVE?=
 =?utf-8?B?VHMwVG5abHBocEJxeVpkSkc0WGhQZGEvdGNMOS9KMlVSc0pPN3V2Z1hVb2Qr?=
 =?utf-8?B?aWE5THlxWTBVWVYwS1Y0Zm85YlFhWkozbDJib0ZGNDZOZWRYay9MazhQSWMx?=
 =?utf-8?B?NDYvYVhMakZ3TnFhRHRFdThUeUVzRHNBOWMyek5LcVZEWEE5aDBoRDI0SGxk?=
 =?utf-8?B?SmpoUlFIOXJWT3dKWVhKRWgrYU0rRGhsZGk2NU5CRDdaK2JUQzAxVTIvekJY?=
 =?utf-8?B?cnV1d2RxUllaYW5sN3VPZUJSOUZQOXNVOVBYSjNPc3Q3a0pSeDNMdzE5SllO?=
 =?utf-8?B?VnhVVnd5K2VhK2NvYzBWSjN1ZUgyMk9oL3ZvQ2hNVjBhRkpyQUlOem5yeExh?=
 =?utf-8?B?cVpUWC9LZHhVbXVQdHlDUHUrc3E4Z0dHaEhMMC9sMmI4QzEvRUMwK2JoMHcr?=
 =?utf-8?B?SEZ0YzdxVExzZ2hqbTBEWlBOUFg1SmtMODhlN3ZjRlQzV1FCMTJwUitVVFI5?=
 =?utf-8?B?SEJ6MkRIZDhNRitBTHRoUjA0blVjU1d1VzR6TnhWY25jRnJ2S0tIcGhacTh5?=
 =?utf-8?B?Vm5CRjJ0SHR2SEdhRHNJdzNNa3pRS2U2c2xsMTJOcW9oMytkYlZYV09sMzBK?=
 =?utf-8?B?aWY0ZmFLbGUzN1NucDl0YktZa0FDQ0kzNVFST3VlK3pCbzZEOTExWll0Uzlz?=
 =?utf-8?B?UHV1WTREOUlhdXVaMXNwNzY5Q3BJMmRpOFhyWVlNQVd0OG1CUjRSZUNZanBt?=
 =?utf-8?B?WVVxcXVRMnZYSXkzbHlKeVFlcEYwRTJ3ak1EWE5xdk5pWmpsM25xblRRQ3Bt?=
 =?utf-8?B?L1Q2eVU0U1pwYTM2czJGUDVWeFVuTC9ZeFhsVFR4S0YzSTZRSWFWSE9ZcHg1?=
 =?utf-8?B?Q0FHbytXVmZRbU4wUktiQUVoZ1MwelRFNXd5UGFUMHp5bTAxN0lZeWpOdnNL?=
 =?utf-8?B?bm12K3NoNlVGdlhmTk1mMnJMZXQyVE1Ya1dxTkFUcllMTVRmUFgvb2txRkQ0?=
 =?utf-8?B?NjRLbU5ablNDRUR3Y2RGNzJ5YlZpeDZpeDFheHh6a3piUXFkQnNvVHJXeUZB?=
 =?utf-8?B?bTlhNjZLYlA0V3ZrcFZaV0dyNkVCVVJBM0ZWeHlOKzIyR3RyYnV0T1BKd2JJ?=
 =?utf-8?B?dEVVNVhEa0dIcVpWclQ4MjZPQk0xZ01DVlNJYTc1K2I3VHZoQUppOXo0bVZs?=
 =?utf-8?B?SkJGaXVYbVBQZjFVNVVFVU4rUEpvbmE3SUM1WFlrd3FPWmNmcTNWUzdTRHZw?=
 =?utf-8?B?bXVKZzROWlZZMWNKMkw5UGdpOFlCWmRNRTl3aFIwQWJiRTUvYkd5N3UzUzRu?=
 =?utf-8?B?aExmR3IvTWluUG1ZbkhLVkhUKzBSbUJEcTh6b29ZWHZSSTRNc3lQdz09?=
X-Exchange-RoutingPolicyChecked: Al140Y3JDv5cD/vg7neAH0rt8gd/NpzpEEclXSuVL1na4qePkzdpnAjxB0ncYhMJhG3HkvUlbEa4JFtPw/kCMOv/9HSuoRzZbexH1nBl2WSFdqOrU721fAPmK8shnrsjalzWcSCo6sbgV1imLNYcwCPZhZwo0re6r/jE1T0jrX1Fc+tcy38TqrzxCRkslUxuI1xwu4vOBEIOobG7GqTZbyCrSL/78kjP9aM8i8qSRclUOl7/ltVA0uC8EDGzuHjYSky9e5K6I4q0mVdzX0fOVrpG4E/63P8ME7Mjnf8NXNaQYT8k3+TqPU8Gr3DsHzIbvNjo6LwaG2QlOyHMtLO4fQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ce42d2df-6ee8-4fd0-3cfe-08debb70ffa3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 21:51:53.3962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/8P7wrz15ommt+lIFbZpG5zfx1s2+9ZsFHc8kM+eUzwJjQKE+iTiCCcJRW2IvNUKU1FaHjxlrODA/MkqOgzP1AevcchP6VsoQgNcl2uq5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4888
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	TAGGED_FROM(0.00)[bounces-36935-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,intel.com,enneenne.com,linux.dev,lists.linux.dev,gmail.com,vger.kernel.org,suse.com,nvidia.com,oss.qualcomm.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 1397B5DD039
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/2026 10:14 AM, Thomas Gleixner wrote:
> The PTP core indicates in system_device_crosststamp::clock_id the clock ID
> for which the system time stamp should be taken. That allows to utilize
> hardware timestamps with e.g. AUX clocks.
> 
> Save the provided clock ID and use it in igc_phc_get_syncdevicetime() for
> taking the history snapshot.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
Acked-by: Jacob Keller <jacob.e.keller@intel.com>

