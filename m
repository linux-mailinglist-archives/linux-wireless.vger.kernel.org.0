Return-Path: <linux-wireless+bounces-17184-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCE8A054D9
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 08:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEE993A4BB1
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 07:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473D31B3957;
	Wed,  8 Jan 2025 07:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eIWVjvhy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF641537C8
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jan 2025 07:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736322973; cv=fail; b=OiMoWAfoNVAVXhS475VBZ7901drlAgokoO+bGipFNbN/nUvfUmF1evL/dy6iqI749ME1oK471uW4eA4pgicPhk9/jcN3KRbzuB62HBoRBsy74LCplir+xMmd4NeE/baL8zZAyCuwj0yGdH45NSnqYBTKvpTEirxGnWtp87eea+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736322973; c=relaxed/simple;
	bh=DZ4I+jTl1E3xHP+yA9ZDH22kIzm6fmjAzZrLxuF6h3U=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OpbjZizyX4jOQvMw3xzyv84ed9+0MbIPPkANZSkhNi7PUcHCaUcTfpT32RK3sBwsdGNEpoqG2mQlAw/cW/8Q9eUBIeoyCPuTShBsSYLe6FWQUyovZByUijgoF7xHeBu1RuK4rw2IDDPY0HQOJQZf4zm2hb2VW4XoQiNGmizdJpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eIWVjvhy; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736322972; x=1767858972;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=DZ4I+jTl1E3xHP+yA9ZDH22kIzm6fmjAzZrLxuF6h3U=;
  b=eIWVjvhylDKvrZLbU7rrpx5KQ5EmPUwl1TLFyXKFjzoEtK/ZF3U4/R3c
   kS0PC1W7mLFsGPCHdRUAbAqjKT7xKNyoi4DR5x0TBPvLlx60hK21tmG8d
   DWk4kWXlZAaWud184wJCc3K1gsW36U/v1CjHKAm+7h0GCYL1cPSBeJn41
   hn5SG9yp9exHR2YvSShPYPddm9hDHuEjGMOT+IBx5If5v+u23HiLr8Dw5
   DtbtWR/7mwMa2s61YjVkLezxQnJYBnTTAPz/LT8071XG+CMA3TA4NEsKD
   2yCmmDEpFAi05s+mDEJXOdt1xFxlazNqdFjH1StYZHztCxxld1w7qhn6u
   A==;
X-CSE-ConnectionGUID: qbog4ew4Q3KgaJRMC2v5aQ==
X-CSE-MsgGUID: vgyp9+9WSK+KYf7nfxjqkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="36697494"
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; 
   d="scan'208";a="36697494"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 23:56:06 -0800
X-CSE-ConnectionGUID: WhW6lvqRTByOgHv7Yuf9Bw==
X-CSE-MsgGUID: NqUrjdAsTAKMfjSep9VbgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107046683"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jan 2025 23:55:56 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 7 Jan 2025 23:55:56 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 7 Jan 2025 23:55:56 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 7 Jan 2025 23:55:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PjkS6BfqkegTTpC2075Ml5Aheu3d48aAArNUCfKy6TPBN9bwPIGZexvLTypQ/uO3p7x1OgxmGPhm1iE+AnAfbdMunyhVsgiE5J8ifPT6D1v4LWNilY4jwnWwPI9k4iod0FJPUv7J/GTA1STljMFkbpHrWj2R6mZ6EixuzXWC1l2O14/KGIXO+gwiVYsb0SwP2Y2QMGWS8eUIjWjKm5+Ro/YMahy0TZnwVLV0ke872Lv2Y/A7iErfDHr8QiBQm6wfCEGl6/3XTGShuXHkeoK7XNaw6tP4nyxGdBUAFIlheuelayF6CFWVVvUC5f71b8y+wOQ9ak7h5J+riNzozig20Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKPA0+lnU7WFVpjXSfsUUMT0zL3jfWwMe09RFxnr37E=;
 b=lSblLIyvICPgAuPIfusX6rc1ScxHKMvj/JwLexS6LJnAEaHzdwaSwDW0ZD98wpS7KuWNoQPQ/6bTAxEKQKl68NTAYqmoyXAveNqvPp3B+uQ9pETzd8cRw9LJb3jd7yrAbXiGfus1F1ubZhqqiV/EQGNsDCcc0xw61AizsR025HY8PMInxhp9vp02jNlEUuOoNUcum2rEV5XYbfTiS1H7khj1f+yZq5eUBXWaC7VSQARobbfAewcfKipcRmqIPodyTTSqlxIMZ/XNOcxbDNtRSfXg96ljpiadA7ko4URqRPQSOAuzkhcMcdkF+2HC95fTB+7p4EaSKz+a6th9Kc3fFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 07:55:53 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 07:55:53 +0000
Date: Wed, 8 Jan 2025 15:55:43 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Johannes Berg
	<johannes.berg@intel.com>, Miri Korenblit
	<miriam.rachel.korenblit@intel.com>, <linux-wireless@vger.kernel.org>,
	<johannes@sipsolutions.net>, Benjamin Berg <benjamin.berg@intel.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH 17/19] wifi: mac80211: also verify requirements in
 EXT_SUPP_RATES
Message-ID: <202501081559.1c188f65-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250101070249.f1840f19afa7.I12e3a0e634ce7014f5067256d9a6215fec6bf165@changeid>
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB5832:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d74b7c2-fbbb-4f72-5b3f-08dd2fb9e00c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xLHX3CaeYsfHUbmj7ClgBe8zbm5woHkSX8OlLlNPpuCD5/Wu9yTRB47Dpxqk?=
 =?us-ascii?Q?TpniBJYRKcKLMc/IkAlEIf2Cy6rr/5LVzI/DVwc5vgB5ddEb7Zb75aPbvdwM?=
 =?us-ascii?Q?juy5xkus7LohJjS5k0jiB0J/10vEn/BU7pQz3OE2oBvYvmKUPGjh+QlmBhD5?=
 =?us-ascii?Q?ILmYwwEDVCxXAvk62HSQVp3MZ7hZv3ML8ntj4/OISeO3VMEUx9vMtqklPZdw?=
 =?us-ascii?Q?MXkO7APOPXT1T633AzUKEyK9v8/+xvEUVjhIDLXbT5waM1P7ilCK8s5IDNh8?=
 =?us-ascii?Q?utnA3u0fX7DiwJcL4KQvGIad5+nDATp2cRXHb8gCFigyUiArYXCDcj8GoCXQ?=
 =?us-ascii?Q?y3J+B5w2b5YqF85EBmjMtpG3RS3zhwtRQG/hIbPtqAiyO9QJ9nWr+ebfSd9g?=
 =?us-ascii?Q?3TxnzFLin3aK/YjhnIEKn0vymt7pmqtHgcI27vZMEah0bwA5AHqiF64eI6ve?=
 =?us-ascii?Q?Mh0b8PS+s4JCfG6Mr7TL+5mKVv7MDTY/CGDAn4wVsm+aagEz1JPXgzJLCo7e?=
 =?us-ascii?Q?hKq08nXfz37CGvPouTNHiuThI1BhA8nnAjFFaRZ+AnCtOZSO7d7F5ErWs84F?=
 =?us-ascii?Q?W4OJhIh0O/4HS5ek+y67oyLCKV5Wc/bhGH+B9NZhzpHNvPQx6JZUG4IquMu+?=
 =?us-ascii?Q?hdS6KhV+EDsgm92xINQ1LPEL+N4xN78lMYi0BWan0ioW1rcl22w/dgRKLLaR?=
 =?us-ascii?Q?BTwFKJfvSccBsbWQZMaZ1BfinQ0jimnQ8z/jRkLcTJltH+YzJfE23jV5JP8I?=
 =?us-ascii?Q?uCGyE/8cZ+xxFHmRo0xb+mn1h4UM2UgtfV242P57dPJXPDC3LFExUcIP0Dn0?=
 =?us-ascii?Q?+3oY1q94FGzsD6DevzOJD4vjiuzxtACYu6zAfORZ8giCapYKz9A/e+X3kRTr?=
 =?us-ascii?Q?vmdbihN64/LFGF9QkAV3PyzIsKFpHFMWqiQxgftbzHx3rG1Wxj8jAx1L3POu?=
 =?us-ascii?Q?y8gMYd22S0rZZBIg8zc+lO6X3M4fcj224dF1DJ4wpXJQ16WCA27g45ZHbUhc?=
 =?us-ascii?Q?l8O5BbHjR1wxUO3YArOUPjljVE7nOkfH6rY/VlgW6MOd1wFT6MxENZx2N/BK?=
 =?us-ascii?Q?BNHpo26OLYtGCuzTqDyHSEEGV2tc58bVFZSIM/hHIAvBSelO1SWslXNDrzvn?=
 =?us-ascii?Q?uSkSDKbOVmFOBfbMoOzQ2HNfpIX/ppNvHxIylPgg7Y53hw6NJSWMDCCNcKfg?=
 =?us-ascii?Q?1Xf2bqAChehghSTTHEGVHNBYa+634EjpPWvawe9MJw2kgQRyfr4AcXSM3xNj?=
 =?us-ascii?Q?+0rwRsJSc7Es9YwQyMSG2WAUKedc8311qcAJAOJIiujvA7X1BjRLQIGIl4gs?=
 =?us-ascii?Q?gGrwXBQ1IChWNsIYzU1IXJP41PzTvQ1iXYoJfDMumOtMFQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?obicLDSgH/tcQSQxjCMzw5ywSxEnVi5tNWmI5NiDSUf6KClt0HOsbki89Ar2?=
 =?us-ascii?Q?ZdkSBmhBAoya1EoVxqntp4PfC+ti363UJktifwe1fAgwqRIa2e9Xz9LMsuq8?=
 =?us-ascii?Q?nkRSxAS+L0b2ZyK1v9j8BP3PsIYj7/n+8XYpHgehaeh9A/SDbW2wjK3kaHDl?=
 =?us-ascii?Q?x1HdfcWpfginkt3DC3m13skYWqgU/l7qUiZv6vlcB6mx4OxRRvxaQKistzYT?=
 =?us-ascii?Q?N9ue81jb9Xb6q3uvq4MbpfKhh/iBIPjwhATTPg485+JEldWbXA/98jpcEn4e?=
 =?us-ascii?Q?BhcdvQgik0v+4s+/dvLj97A+jmdrxsojNZ/Oy75c5kn2HYI/Tz/NI9+ZoM/6?=
 =?us-ascii?Q?ZCrDYw8Nf/0cTwpff1AjmsLqZb3eNcL7UBzrIu4sfGShs8Rgk8D8lHOs6yvJ?=
 =?us-ascii?Q?PR5RiYBXyEBq87XSG2DX8nDF+DwCI43ZTaJc9euyG3s8TCDcYq0/djgf4NaK?=
 =?us-ascii?Q?OyI893Zqs4rmZMA0aP/mm54WPEtLQNoEjzbNMJ7ru+py55C4WtvhKFDQu0nb?=
 =?us-ascii?Q?kTPzCZqFxYkioq+Pae8asYybT5hWzg6GPScQkCsskZDx7QexLagyfZ2tm3BE?=
 =?us-ascii?Q?Ewgy4z5IZtgqsIe2JrYymNwsl+q9CHMuFzAvIIaTWbhkwq02So2Bwk+YRIrH?=
 =?us-ascii?Q?mFIhvhV6L//eaD9K7CU9XJAdzqWCsUq0GkFixHJcdv1yUX22sAVttMAGKAyL?=
 =?us-ascii?Q?Qy+ynYTTa/durcB6xbzrG1vECb2yPem7LCLtUJLmILq0xwKP7Zz83+H+DkrL?=
 =?us-ascii?Q?B60W9QgSP07d9KxJ3b1tfxVsYecXoxexxZ52Gw51dDegtgu+KXypNkwd5jsn?=
 =?us-ascii?Q?wwJzjscNBt+0LNCo2X4HzDv5KMqadlqejrhRwq1XSREZnz+O38h2a38Yfza2?=
 =?us-ascii?Q?vqJhK8GPeB0aZoYpWO4rSRwdgNnKEM1ERLV3RZG7mk+Etg/GHE36iI6tu6Ku?=
 =?us-ascii?Q?39Rrw5tFNWy3nGOwh/eWmxYz5YiOHa5ej8cxsuN0sovpyr5nUTTChG+4lSJY?=
 =?us-ascii?Q?slamWP1Ai4YPkmjqqHC7DZEFxtHyJ6TYJTc/lCST1xH/ODWHj+Cwwxj5oofi?=
 =?us-ascii?Q?kbDC3KnpqEyP+32bpRjxDowBb2V75Yq/i+42uCDyHm44zhswLOXaCWNgW4VE?=
 =?us-ascii?Q?Rnr/GZQoWA6h2varDVnXCX7ewxyIkWWW1D1sSK8dOMvlFMPfLaX8i45ysJmI?=
 =?us-ascii?Q?dHQMlj4YibuVgKwAWp1ksRRIKnUxfCLizgwKq2CseaFqqOWT4KOPs2H3RCuo?=
 =?us-ascii?Q?n2S1F/ugULRSwFYaIJqP2H1HV3yr0OEfeanE63qi19GuwnIiY/HL9LYt4Afd?=
 =?us-ascii?Q?5XDeVjxLIWWI21ZTavYkqZu5nvdGC+n3euJkeam8w2XszeScfnSrrfMrxyds?=
 =?us-ascii?Q?e3h3Ujq5IoE0vVcgAuQa3B5fCuQgm1WmpPwRjU2EZAGKUOZsXgebpVKTJcMo?=
 =?us-ascii?Q?FngnDUsjgYz8nxBPb6dOdEfCAFsbl7sUPjQTz7J6GOyb0Jpmhcw3lcT3Eayc?=
 =?us-ascii?Q?WzG5NxjgV6KkXtC+3lsqNzVg7KqHRWOhvfUntxgEP5N5xF2+0h/B5GcFWAgI?=
 =?us-ascii?Q?YDAr5ZyVjP/EfRz9Db1clf9BA85KE4jI4sJK8bNIHC2JQxNOu8Bmd4qRGsUV?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d74b7c2-fbbb-4f72-5b3f-08dd2fb9e00c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 07:55:53.1706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3f8+cD+bDSG0D11IBiyXBWsPQthqon3rYAymFmxDiG4bkHy8R4jfUqybU1AXj5pTIqodDd6L6IyMAgkQM4Vew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5832
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "hwsim.owe_assoc_reject.fail" on:

commit: 1539283361bfb9c62eb3486ded2c4d38e5858510 ("[PATCH 17/19] wifi: mac80211: also verify requirements in EXT_SUPP_RATES")
url: https://github.com/intel-lab-lkp/linux/commits/Miri-Korenblit/wifi-mac80211-add-some-support-for-RX-OMI-power-saving/20250101-131018
base: https://git.kernel.org/cgit/linux/kernel/git/wireless/wireless-next.git main
patch link: https://lore.kernel.org/all/20250101070249.f1840f19afa7.I12e3a0e634ce7014f5067256d9a6215fec6bf165@changeid/
patch subject: [PATCH 17/19] wifi: mac80211: also verify requirements in EXT_SUPP_RATES

in testcase: hwsim
version: hwsim-x86_64-4ea2c336d-1_20241103
with following parameters:

	test: owe_assoc_reject



config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202501081559.1c188f65-lkp@intel.com

group: group-00, test: owe_assoc_reject
2025-01-04 14:31:54 export USER=root
2025-01-04 14:31:54 ./build.sh
Building TNC testing tools
Building wlantest
Building hs20-osu-client
Building hostapd
Building wpa_supplicant
2025-01-04 14:32:44 ./start.sh
2025-01-04 14:32:45 ./run-tests.py owe_assoc_reject
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START owe_assoc_reject 1/1
Test: Opportunistic Wireless Encryption association rejection handling
Starting AP wlan3
Connect STA wlan0 to AP
Association result not reported
Traceback (most recent call last):
  File "/lkp/benchmarks/hwsim/tests/hwsim/./run-tests.py", line 591, in main
    t(dev, apdev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_owe.py", line 766, in test_owe_assoc_reject
    raise Exception("Association result not reported")
Exception: Association result not reported
FAIL owe_assoc_reject 13.055277 2025-01-04 14:32:59.681039
passed 0 test case(s)
skipped 0 test case(s)
failed tests: owe_assoc_reject
2025-01-04 14:32:59 ./stop.sh



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250108/202501081559.1c188f65-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


