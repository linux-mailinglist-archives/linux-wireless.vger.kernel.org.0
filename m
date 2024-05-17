Return-Path: <linux-wireless+bounces-7779-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFFB8C84A9
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 12:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6C1D1F2418B
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 10:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD76135280;
	Fri, 17 May 2024 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EYs7ghOa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AA62C848;
	Fri, 17 May 2024 10:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715941260; cv=fail; b=ivIfWcZp+CIr7ty1MvxZrPZQ1bbAQDOyVIRbt2GvG0+TyVW87uiy5r1H9R9ubzU8tiqYlt5xOpDmgLvcw2z5ybF3Kd/tM5fFtiWBrhA8/w4uZh7b9DLU3rIgeJXNWJL795+/GrvXqvpm80IwEAQWasdE+TdWb1YI3ADCK5T7k0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715941260; c=relaxed/simple;
	bh=uqbiEZb2r4DJDfDzyXdNV1FpSnfv2V9eYoaAaSYu12g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F3LiW/b6ua3SH2JNKAz1tXHtSmEK/DoS2qY9+WAJ0PvP/vfQb3vE0vmHWmG7hI7WzSKVT8N36PtmCJrYrq8RsYbT/z2Bf/gp+u0OwUkZGVn0LNLZBnwBRuXMqxJxCQdppc1GzVOTU6HfYJwBowsb7aqkfDXvG6NnQ/vpK52ZVmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EYs7ghOa; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715941257; x=1747477257;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uqbiEZb2r4DJDfDzyXdNV1FpSnfv2V9eYoaAaSYu12g=;
  b=EYs7ghOaa6pjNd5MNFgEMDv+22wkkIRd4VbPa60Ir8yA3XlslA4E/02/
   c3B3xA/EkDB54HM+twIQlP7Xh6qenNCsWTnKbP3WednR6I/nkPA3KCJEv
   e0yD3khz91dlb6LzqYiSfhasybu73XV7JkGSr+kMcKA7bOi7HoN6Gmiad
   c/fzWnrWSd1GRLMS+8jlnG5u7zEeF5lVJ1iRL8rJDjDyK76kkFH6Hxtco
   J/FsWC2tuqwBCJ6JGNcYRoKiiCqJib8WU9SgFbmv9Byeu3n7dcijTk93U
   62qe3VzzO8NqacFaH3e/76nBLiOSLUgzF84AAkA7FS0k+80bJVCqnmcT6
   Q==;
X-CSE-ConnectionGUID: SyTkVbt4Rx6YEMEeoxN7QQ==
X-CSE-MsgGUID: 9duc5oyQQW+7WRhSDNz+1g==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="12052686"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="12052686"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 03:20:57 -0700
X-CSE-ConnectionGUID: bn/MnUMCSoCHgNWnAfTIfQ==
X-CSE-MsgGUID: xOYKOfL0SeqidqHdls2TUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="36174265"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 May 2024 03:20:57 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 May 2024 03:20:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 17 May 2024 03:20:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 17 May 2024 03:20:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGUP8sBorqpIIozTlsuKiZ+2jDXm1ozhGY3lx/1fj8cxIXFgQmmYocfq5BXaX3ZdDIDiqqTzCk/zBkHUXBkD+W3pZ1QHW5y8aWWHT+j5V5Je4ZePKZKfC76t5C4FO7I3odAgcAuHSjoDDJvuHcE3XF/s8PAIBLXrMK81fM2pOShEVkoHXhHW77IUnasWLGffR4XCxsisgy0WFaUiWXm2sFbSY3F4r8clpuWBUVQaPB4KC8I1SbGqTy/NC8kXHTrLSQv6WcIJLzTghjoWaRdjf3OqYNMFHP0o092Cwpc8pd0QIHJXVTp6U7N6RnLk5W0cuWA9gxVDyl6C91Ucm6PDbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAcH3gf/RJgKQcdzbmUHf84MTFHWVMU5m+dyZt+F6Pc=;
 b=NnQs2v6/MU8uykQSkH5gS5coVmzZTRp6kMHTu2nZGlZn7SeHXerINxKi7h5RZowdsPIQFwjVu2zEFjpgRgiFh+sX/5M0h4naxw+HbKRllMI77Wk5+IFNfRbFwzyxvEESSgSxY0cZKPIMEDV8bJArOv/HofP5ew8fWXCV64hl1swdMiZmfdQidBqN0KeKo3EJ9j0E5tAl/9eZap6847PhgUzDuUw5lUhgxmgaxYfp0p2fD2OyXKC7iO7sn8mT3vqQggYWBA2DgRtZ4+k8gytgoVHz0qTgTIxAbkg7NaZzITza5HRoMwFwwuixeIwmzI3PnIMk9nSe8FOzKSRuiHlJqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by CO1PR11MB4866.namprd11.prod.outlook.com (2603:10b6:303:91::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.29; Fri, 17 May
 2024 10:20:54 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%4]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 10:20:54 +0000
Message-ID: <8b50e09b-560a-4a16-b9e7-7535ba5eedf8@intel.com>
Date: Fri, 17 May 2024 12:20:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [thermal] adding check if the thermal firmware is running
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>,
	<miriam.rachel.korenblit@intel.com>, <kvalo@kernel.org>,
	<daniel.lezcano@linaro.org>, <johannes.berg@intel.com>, <dmantipov@yandex.ru>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240516200555.33982-1-trintaeoitogc@gmail.com>
Content-Language: en-US
From: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <20240516200555.33982-1-trintaeoitogc@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0001.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::12) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|CO1PR11MB4866:EE_
X-MS-Office365-Filtering-Correlation-Id: 5033740f-3775-4e4d-c4b2-08dc765b08ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Um5zdzhYa0xwYjcxNU5UUkxSVWdYY1FjZlRwY0lHTUY5TWN5SG04Y2RiYUox?=
 =?utf-8?B?TXZCYmhpcU5iTlVJMFRkTVZDSHh0TFZoOE1nLzVYMkVUVFRwL0NHMThtSE0y?=
 =?utf-8?B?UlJBb3Z6Yi9rQldjU1JWcTU4NGMwUlN0L25leXJ0M3F6Wm5TUjRGYkpKQnNF?=
 =?utf-8?B?UFl1ZDZtTkVSVkt3MTM4VVA3aTd5OE9LbnM4TG90cUtQN0hhTVN6MEdXU1F2?=
 =?utf-8?B?STZPQjZiVW1BbHpNUzYzeG9hVFFmdW1CMmZyWllWRGxJY3FQd1RsUTFzRmQ4?=
 =?utf-8?B?cDNweVRja3o0NVVrbldnelcrajREQnR3SUlOMGYzRWJDYUNaS2xMclVWOTIz?=
 =?utf-8?B?RTl0dVJrYzNERmVnRndzczFoVkJmVjFXOW9aQXRJK3l5UktYUWp5VFFSZVpE?=
 =?utf-8?B?NHVKZmk0Q2pqalVUekZhNGFHVDJTZndYdXpVNGZTRDVpNVhBTkdLWXdlZ1Vp?=
 =?utf-8?B?VDltQWNPRmlJVkJISUtsSGFIYTV4MDkvSnhjcmxUei94RklZNG5kZVF5b25h?=
 =?utf-8?B?ZTh4OEpRUmh3SEJNT1RNQjNGOXgyQmxPdlZVQVhBbWpFZFhSN2wxR1FMSVFB?=
 =?utf-8?B?cVA2dVBBZnFXa0lzdVRoeGhPMTFQYS95VVVYeE00Rzl5SFRRbU5JMXQ2SGRS?=
 =?utf-8?B?bm90RUJ4YjVXZktRa0pWZ3N4OFM5MjJzaFdBSDJ5eVVUWnRyTStWWmhJL2VE?=
 =?utf-8?B?V2NNVG1talVkQzdXSWlvSHpZT21QWXc3YWxDd3B0U3hSQ21ReCt1RCtibjF1?=
 =?utf-8?B?SCtSR1p0dWFOVFVLRnZmWHRBY0hIWnJlT0ZTbjBXc2VCR01aazRIMXllRjlO?=
 =?utf-8?B?c0NyK3RDem9lOTlmVEt6TkNSYnRwVElqUy9wOTJUbDlSSDlXUW1FdHRYcUVl?=
 =?utf-8?B?QmNra0xTeUpLc0tWUm5uRXNXTFF4cllKY2x3QUpaMmdka2IrcUFtcWs4Zy9O?=
 =?utf-8?B?RmNMNnc0aU4wM21vQ0VRS1N6UTdIQXdJd0dzUHRQb3RoQWxBcnczWGZ1VkM0?=
 =?utf-8?B?cVFPazY5VmpVQlpmQ2lLUkZlbGRMcGxmZS9WL2t3dW5NT28zMWl0U2lUMTYx?=
 =?utf-8?B?cURUbmJzNzhkSm53V05XRUJxbEVhQlFidWRHM0dLWjA1R2lkdjRpeU5KTUM4?=
 =?utf-8?B?MGh5TU1oWEdhU2ZGVU9mSUpBdGJPT3FxSXV5YUlaRU0wN0FTOHlnZ0JEdUh5?=
 =?utf-8?B?Ym96NU5tdUpLUVJyNllpeW0yYVlUWWRYZXpxUzVTb0dHMHUxTlp6aURVUDRu?=
 =?utf-8?B?aFhvYXI0VGhTdm5JeFh6enhjVElpSTcxN1Y0d1NxeWFLeS9QdkV0NWs2TjIv?=
 =?utf-8?B?d2w0T1RsTWsvTlFVSnd1TmIzOHkrNWN1RzZhcWs1YzkrN3VYOURxWUlCR2h1?=
 =?utf-8?B?b0QwSmxqUjhJeDR6Q3ZJdWtSblpMWXdlcVVuNnFXaEQ1eitqckNwZWNwQmxq?=
 =?utf-8?B?SWZ4UWdRTS9TZlJLT20wSzVmeEFUKzIrWHhEdGlsVkt3anprQUxhUzZINXdl?=
 =?utf-8?B?cytsYXFjZmZXTklMVjBERmJYQkM2Z0l3NGJRSnVackNoRldvdmFoaGJjZnBT?=
 =?utf-8?B?UlFKeVQ0TE80VjFSYk9ia2RrTll2dEszRkJZTWhNbGFqOW4rZk5YNHNhV2N4?=
 =?utf-8?B?RjFUSzZCSDEzL2RnczNpRmhPZGhTbVRhNzE2UWRTS3FuT2lCeTNEWnpVZ3lz?=
 =?utf-8?Q?ENygqjThSOCYCyZ6PLcj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzZ5MUExRjBBS2lNaHVKSHpHQ0dlRFZoK21abDc3cEdZakRtL3hNMkxzeEcv?=
 =?utf-8?B?OVVlNW1zQTNPTHdkZ2phellOZEJGVFlGQlBMbGVTN2tidTBlRythb2hMRnd0?=
 =?utf-8?B?b1pHVWtCc3kvczRDTnB6YXNBcVhkVEhNM0tZVXNSdXcySjhWbGJoNldGcVpU?=
 =?utf-8?B?WUtiQ2NOR2ZGa2d0Q29nc2ZpdTdsS2VGMmJpN1pwUHNpNnFGR0VxRHc5MG1S?=
 =?utf-8?B?Z0wzcWZFcjNqckNrVFNTQ0VpNnlOMlFoN080SGJGVklqalBnMG5PNE85ZFg1?=
 =?utf-8?B?L3hDZ29FbTIrUExSdDFXNlFKbzJkbEFBUVdHeUYwa3VvaVVuS05QK0ZkSnVO?=
 =?utf-8?B?UVVSc1k5OEJ4Q3FnTk5PbVpyTWJ1KzJ4Z21ueUk0c016dDEyMWNVNGp2ZWNz?=
 =?utf-8?B?bnZZek5CaFh1WlgvNmd3UkREQUlKYUZKdWUyR3Q0VEZlTjU0cUlYdVNUTFBi?=
 =?utf-8?B?Q0ZpOWNOTUtxNkdXai9kd3N5aitSK2dPNnhESzBxZjluMktJU2VkeDdHMmwz?=
 =?utf-8?B?YnB4MW5uNzFqYnlxV2dZalBwd0gzQ1dlVDVTOU04emFaaGJWTjdpcmJzUUdl?=
 =?utf-8?B?dHZWUGFRcno4b2dpZEpzNlltTE5sckxoNjMxeFdhdk00YlNMZkxobG9TUnNh?=
 =?utf-8?B?VlpjSEFHQXppV2ovMFdVNDRuUzQrcWlXWWt2cGJDd0MydGhscUdYMmttQ1RW?=
 =?utf-8?B?UWVoSHBoTktERXNHdGFrdGw2bFlIS0xxSk1rQlYzZTBIc01NaWthR3l6d3pF?=
 =?utf-8?B?MUFSVzl0UVJBWHRyZDlsTEJzam80U0g4OWFka0s0aERNbjRiNGp1T2gxdkxQ?=
 =?utf-8?B?UU8wNjE0cEtkVmFKSWVoOUlrUzAvTE51SGtsbUVpWjk2anBrT0xrT01TeTRJ?=
 =?utf-8?B?RWMxQ3BaaFJMbzJwRjFVRHJYVVFhMDMzTmVZRmdHa1FxRFRzTDRtYUhWeHRk?=
 =?utf-8?B?R0gydFRKRUVjcnJvdGMybG1yVDd6dC9ZNW9MY25obW9kUm4xYTF6SkZOOHFp?=
 =?utf-8?B?ajVuMmQ5bE0zeHN3MXV0ZzdWU1FZWXExTlNTaGtNTS8xN0dGUzliNFRjZkNT?=
 =?utf-8?B?SmhFS0FpakViUEV1dzFwbFFleGpJZ0ZHcXpPSXdmNFBGbVRJTjVRdDdacVli?=
 =?utf-8?B?M1hKNWZORjByVndtdVV4ZTdGemNNd01NYXk4ZXVNRUxQbzdZYWFyZ0RBSHl4?=
 =?utf-8?B?cmRiY0dJZlhxc09hMnQ2dGp4aUlTc2t5RGo4NVVEMGRlQ0RDVlFHdFUzcmph?=
 =?utf-8?B?N0FMenBLb1ZNWWdIMWY1V1FmMHQrRTdpMkJNSWpXY0wvWFVBUnErM3VIUG1O?=
 =?utf-8?B?YWlTb0RkdG9pbWFuVHVQVVhzNnVmSHlOY01FcVVQMmozN0hTZmROZXhYeWpy?=
 =?utf-8?B?OWkrNjNXWGNUUVVjY3R1VmR2RkJRVWVMK0JpcHo5bWJ1NDdHWVAyaTMzaDVj?=
 =?utf-8?B?S3BjeEcrT0h1OUFGWFZtdDVaV1ZzOSt5Tm82WFBiMkxaTlFnUGxHUU5oQ3R4?=
 =?utf-8?B?L1ZGVWxQdEU5d3ZucFpIOUVlb1Q2ZjJzamJKSkkzcDVtOGZXYnVrN0dTWDdz?=
 =?utf-8?B?b0JabDN5UEQrVkc2Uit5NE9PVnRpNVBvSmVTM0VOdHVINSttTmNhT0hJd3dw?=
 =?utf-8?B?SEttaStQc1BnLysxYnY1Mi9lVHlLRmJQNHo4YnJkL1V4V1dKYW8yT044VUZB?=
 =?utf-8?B?VTJVb3hoOEVWTU0vdTl3NVN4T2NTSWxRQ0poRGdNMXZzYTFoN3dWTU91aW94?=
 =?utf-8?B?eUdNajJUVEdQYW0rcE9XdHNZU2NHQlVoYTd4ZE1Bams4R2pDcmViQS9jZm16?=
 =?utf-8?B?RW1aL2hYRjJEMkFrMzJtRTdpNW92L2p6dnBGbWZxbVhGQS9yVVNJYmpIUWVN?=
 =?utf-8?B?UGR4RVhvM1VMS1hZc0JRZDZQeitnQ2pHeFVxakNON0M4MGpHS0REQ1lZUkhh?=
 =?utf-8?B?UGVVeUdudEpOazMxMy9WUWpFOWszVGJNR2VzK0ptQXg2MzdCMm5sZWpuZUEw?=
 =?utf-8?B?OXdoL2FrSnhSVUNHbnVPZ0lUZTkxL3lGNXNCNldtcGl3b2c0R3VBelZNUTlS?=
 =?utf-8?B?MGFWaUszcTUyK1draEcyY25qdUNZUHZTakQ4YzhJRzJENFBNOWU4V3JpYjVn?=
 =?utf-8?B?RUJwSkFQNGtTYnZHNGx0WWNsT0hxSVkvUVY1L2JQM0xzRDhLQkZaakZrWURn?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5033740f-3775-4e4d-c4b2-08dc765b08ea
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 10:20:54.6692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QaFuYBWOwmiUEdRBbwsTAV7P8OUTrrZyI1Zr+3dHi4ReU/kl4IEeAtWdhDGXkhf2BzMwfESBV/bR8ALYeZTmcDSFHBDGs8GZaFOv5JXkCQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4866
X-OriginatorOrg: intel.com


On 5/16/2024 10:05 PM, Guilherme Giacomo Simoes wrote:
> in the dmesg is showing the message "failed to read out thermal zone"
> as if the temperature read is failed by don't find the thermal zone.
>
> After researching and debugging, I see that this specific error is
> occurrence because the thermal try read the temperature when is started,
> but the firmware is not running yet.
>
> For more legibiliti i create the NOTLOAD error code in the errno-base.h,
> and in the iwl_mvm_tzone_get_temp() on tt.c i check if firmware is
> running and I set the NOTLOAD code for ret variable and goto out.
>
> After this, in the update_temperature() in the thermal_code.c i received
> the return of thermal_zone_get_temp() and check if return is NOTLOAD,
> because if it is, I print the warning message "firmware yet not load"
> and return for caller
>
> The thermal_core.c i think that is generic for any thermal drivers and
> not only used for tt.c of course.
> But if this ipotetic driver not check if firmware is running before read
> the temperature, the thermal_code.c is work as a before this change.
>
> After this change, in my computer I compile and install kernel in /boot
> and in my dmesg the message "failed to read out thermal zone" is not
> show any more. In your place the warning messafe "Firmware yet not
> load" is showing.
>
> I would like to thank you in advance for any contribution, suggestion
> or criticism of my patch suggestion.
> ---
>   drivers/net/wireless/intel/iwlwifi/mvm/tt.c | 10 ++++++++--
>   drivers/thermal/thermal_core.c              | 10 +++++++---
>   include/uapi/asm-generic/errno-base.h       |  1 +
>   3 files changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> index 8083c4b2ab6b..dd5725db06d2 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> @@ -620,8 +620,14 @@ static int iwl_mvm_tzone_get_temp(struct thermal_zone_device *device,
>   
>   	mutex_lock(&mvm->mutex);
>   
> -	if (!iwl_mvm_firmware_running(mvm) ||
> -	    mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR) {
> +	const int res = iwl_mvm_firmware_running(mvm);
> +
> +	if (!res) {
> +		ret = -NOTLOAD;
> +		goto out;
> +	}
> +
> +	if (mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR) {
>   		ret = -ENODATA;
>   		goto out;
>   	}
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 34a31bc72023..4116d312d4a1 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -414,10 +414,14 @@ static void handle_thermal_trip(struct thermal_zone_device *tz,
>   
>   static void update_temperature(struct thermal_zone_device *tz)
>   {
> -	int temp, ret;
> -
> -	ret = __thermal_zone_get_temp(tz, &temp);
> +	int temp;
> +	int ret = __thermal_zone_get_temp(tz, &temp);
>   	if (ret) {
> +		if (ret == -NOTLOAD) {
> +			pr_warn("Firmware yet not load");
> +			return;
> +		}
> +

The thermal core doesn't need to be modified for this.

Please print the new message from the driver and you may as well return 
-EAGAIN from it in all cases when the issue is expected to be 
intermittent to prevent the core from printing the (existing) warning 
message.

Thanks!


>   		if (ret != -EAGAIN)
>   			dev_warn(&tz->device,
>   				 "failed to read out thermal zone (%d)\n",
> diff --git a/include/uapi/asm-generic/errno-base.h b/include/uapi/asm-generic/errno-base.h
> index 9653140bff92..8b92c41f7993 100644
> --- a/include/uapi/asm-generic/errno-base.h
> +++ b/include/uapi/asm-generic/errno-base.h
> @@ -36,5 +36,6 @@
>   #define	EPIPE		32	/* Broken pipe */
>   #define	EDOM		33	/* Math argument out of domain of func */
>   #define	ERANGE		34	/* Math result not representable */
> +#define	NOTLOAD		35	/* Firmware yet not load */
>   
>   #endif

