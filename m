Return-Path: <linux-wireless+bounces-29021-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FD9C62D0D
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 08:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77A774E1A12
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 07:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501B221C160;
	Mon, 17 Nov 2025 07:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aZUfhaUo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFE827F015
	for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763366241; cv=fail; b=pQfbJoj193oIE9bWa6mwuMeH3U1iXeUOk1y24N+RGIlY5d0MKZTmQTpD244AakoRvqc2jEabc0qeFbyEo3+wvuKanNxwnPWtb08PEVYQde8AxYmFV9fwLCkJm5P8vC44rP4ILRNlqetnwkkMfVBhIDqD8SlDLjJHpMKeFjeqCvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763366241; c=relaxed/simple;
	bh=LNILWsKsYicg463IfnkivWCiuXjA9ZnpuuVJInsBOOs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=F3NC5T5Y5zr+z1cJveH6r6O3hw/W2//1zNa9kKupY6i6793QFa0Rb6oKKnXBs8aVhSLUJBTUegpqkUcCFELJe7NKosgND8hoEFTgoasEijo8CPa6FwiCWT+XeFYg/8Y2cH3ulI8wOz4k0eXshF5Bc7USky+Jf7C9V/Z9NqgMlxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aZUfhaUo; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763366239; x=1794902239;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LNILWsKsYicg463IfnkivWCiuXjA9ZnpuuVJInsBOOs=;
  b=aZUfhaUoMdAWfKWzvoT6QGuB2LEjxekKuvvomfIpr/ZgRxnHYI9G20Ss
   hva9LhPKvhXF12QrASSTAF6m0wqg2C/38O9/1WYRbmsaC7KJIACuqvbz3
   vH2AVlPDwkcFvYjTNPH/o0RMqqogV6evFXCDYwZn7+6S66/esyyfn2LH/
   /cr6XkYEcT/Bpd4pUCmx9lfffSZcYKeCsafXEgg6f8f1KbWN9C3yOCoJn
   HlBilJoB6102y5tXdTRJiS5CA1o+51K07iUqypaBVAR8e7X+xu6LA4UWJ
   F2GRiHxq5wq9v0IcQoMQqG1Qxa7hUPZEfy4hnHWlqIw+40TyTvExeQUNa
   w==;
X-CSE-ConnectionGUID: qkzVUKjrTUeIMiQH2VNMzw==
X-CSE-MsgGUID: tRtK95p7SOC/SDk590DRdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="76708247"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="76708247"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2025 23:57:18 -0800
X-CSE-ConnectionGUID: s9OBURtbQM+VR4V0R98Dzg==
X-CSE-MsgGUID: M/n70P/gSpudk0jZxDkdfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="221272168"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2025 23:57:18 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 16 Nov 2025 23:57:17 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 16 Nov 2025 23:57:17 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.48) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 16 Nov 2025 23:57:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QcTl/lo1uPQItImQGRDOFSnGFDVOyVR+wAJxaVfqMt76UmjsG+qDaG0DNQE5QLN5jMpdLspmlcr/E97w4wKTse2J8nLhgcXxYWuc1WV8Nd8i2cw47gb+3tUysXsG78Wlf33/hMukB872wfVpEfJoscF1YPXSRISx6+ERwn6+t1wZEmzLXjkvgcLomTrLKVmPKQWVlJhkPHgRsW9P27B4xxs1msZMyRq/SCrVIhc3vGOgd52zRbqJCNpima+sZr7yDhMAXqj8eVPSzFA9iN2E0jnbJZiHBsMLJ/b/Iu9r+fJDfslIh8OtmwJP4F62CGiI4kWuXrBz1Q/tV9l52B1+lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGlKwab+o83Y1ERpmkqq9wXCh+FhVpmxHb8+6wRLiho=;
 b=FFOz7Cw+uf/eIOfVy+b0zLIdUlXotU6rylSObB8wi65ie53s8AXTb+SwGe64d2k/RXWmYWY1HdjzennK9RRLKRSzqdpQobHoB8oPUlfWb//8dy2Qu2cmmM5X2XGd5S9CQ9k1ZzyxqKZ1M+M8JWuafLyE7r89ZC4Iq8cg8HbrfZ13ZsKsTem1FXBcoDmu/K0VvrhtER9O+naW5aWrPqIbhMASanGSEkR93E+xgweVQ+MggczBf1wcT79GSXlYluZOviLH8YS+ooLVl/9iHgzZ0PHsOtuGGf3QK8tl/zpsUZIHgHNfwIgCtQ1nlXfkdxVc3UB4PK3ZrTmMA+qxdM86tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA2PR11MB5003.namprd11.prod.outlook.com (2603:10b6:806:11e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 07:57:09 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 07:57:09 +0000
Date: Mon, 17 Nov 2025 15:57:01 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-wireless@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [wifi]  a1dc648aa7:
 kernel_BUG_at_lib/list_debug.c
Message-ID: <202511171510.c273ee80-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KL1PR01CA0077.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA2PR11MB5003:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b8826a5-1f2c-4d64-80a5-08de25aee8ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NZrSFzanWGIdLAfCLsKt+y4ucMLNdrknga//mx6K5qFvorTNlpHGYVyDHEhb?=
 =?us-ascii?Q?owGLiMQEv2NrADm4dsQ73uP81i8oCFldJtVVeHWZT7prJqhv6RayyTdQHdc3?=
 =?us-ascii?Q?8Z9Fc5YLAThy8/r0KmM4uPvUC6agh1gJ9+t5xDbhWL25IhQIViyb8/lB8zBT?=
 =?us-ascii?Q?MNObEpa4eKvsuua5X4olw93UTOdYRh3WhM5obPDlFBiGRNQuulSRtTdZH4LU?=
 =?us-ascii?Q?cVJfBGr7qBBJ11taZsCjIhzhKZVqikdU43z/7bWFE20LIK6F6J4MJNzkYAmX?=
 =?us-ascii?Q?d/qcJswzyyF+fFYP1yYv3hpyAAAHpATbEjzeRUEjbLBU9o97/Zr13+YhdaDW?=
 =?us-ascii?Q?NwYBllfiGFI/vg9ggfWbDs47eArROCFG/6t9SD0X1MuUmeCxoj5RZpjbdk4o?=
 =?us-ascii?Q?p7YGoBFPPibs8sCj7sEDlrw1SPeO/sdMuKajAQDv+gG0WBzT2tcliIna2mVa?=
 =?us-ascii?Q?s596OrKTs0pGc2+mOIPsNZchvLAXwuPeMSMrrOGki6ZawPEDLFkroOpC3GN8?=
 =?us-ascii?Q?DIxfsmKPY1rJoFkQN4iyqKwINQXEp+ghXMhen5jxNX6sGJ2f9ls0FWPNdNok?=
 =?us-ascii?Q?g1z+6KOhliXIJTjop3sVZ+HLEyMf3NUson1MdObCAK2e2ZjagCaykjfudhlw?=
 =?us-ascii?Q?W14BaScYtDzoXFPG3+e8vFDmNGZq+elJwXOIpGyM7bqP3Y6mJll4b2rKDRfg?=
 =?us-ascii?Q?X3TjOe4fx6mmSmlmYAYnNXSJMJfxTYuG+4uAsr9T3yPlTm9m8Ja29Cj5ASj4?=
 =?us-ascii?Q?+8R512S51AJDhZOJBnyRoT+CoAI/cNJlB/m84Jt16eqBacGbDwc6a7EEX5ai?=
 =?us-ascii?Q?HiSbhZtM7F03IXG3J9mF53DgtRirRNxFNEz0az02f59RiSScRlU2SKAXEpIG?=
 =?us-ascii?Q?FMXaJFhd32U6i6lmFcM/eAplQ4i95reyVSkTkKC1PuvGRhFFRJM6sTaRM9CQ?=
 =?us-ascii?Q?iHr23siewGTcvTmqo2EwKK9VEtVaaZi8NmDPoiHZeWDmPrI2yLrok5AjLAt8?=
 =?us-ascii?Q?/gqrh5LmrHXo71qMl2hkjPtH19oJM3LHAD5Z1HNjednVKw3hC4FA6yjgPORl?=
 =?us-ascii?Q?EU+S315bKACUrnZFkNnLF2tGjnRYq1dG6a5XR3tiSJeochLfW4KHyPPvXAM0?=
 =?us-ascii?Q?wrQho0R1lKAURLp8xzZge8I4iZL8N5jtlGvVd71W+5UXDe6JGyqtBOgv79DB?=
 =?us-ascii?Q?cogXil9/P18y4MpB90ZhZ+S/igkfuOf/nVKgA0nPQnb0CBGr9bxamhIUOxrl?=
 =?us-ascii?Q?krZ9QJwFkkYxHxNk/y5Vms0EJXexe+37DhoOeTNihUE2wGbDqLCpwn+BtO1g?=
 =?us-ascii?Q?SmAOBRjP4s5PfSCI4M4IaMbquTK+P40GD7tD/p5jPX2PxQHCR7oKB9Rz6EPG?=
 =?us-ascii?Q?dqyUsEMmmJlpIqUefP8oUbrnqeqeyuRp+i+d3UrPRxux3jISYLBGeIZ2E2Gk?=
 =?us-ascii?Q?0lrrjQ+PI8NDs9rfWHg1YEeOfuYACVGBU7TZtp0Bn/Sy1/oIOPpb4g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JRsRlr7DvacfZ+05Lc3o1h/53PnMfWFfeg3uUetoFqv+GVjbV4fqSQrcmfa5?=
 =?us-ascii?Q?jF/ocXZQEb3G0gyrOX9HmHT6viHfDdV12tQLU5NO8lmw1EzZbODWoaML7Kcx?=
 =?us-ascii?Q?ZNCrO+YYfRKg8ztFieTW8Qhu7A6G53FH/A17LyZCELjvrfJrgYg/Wu5ML6Bc?=
 =?us-ascii?Q?bLpSwdQpfHfOW9GOHC9q2J3vPiYwaYdnrPZTypmAV2eojFGLlRlprlfRRucL?=
 =?us-ascii?Q?KfpOu9ule083q8GG/od24SZpcEwj2hPw42/defIJO671ipS3JamM/FFsgSrl?=
 =?us-ascii?Q?sCSABzp41oW0VBh5lH15Aw7wkZAVdwO/ZKVrjJV3ZjCSkpN2w2VsJPWQzMC2?=
 =?us-ascii?Q?GBo/GdfWvOME85Vx2ICC9YA9bufrTFf0Q1YIDggMa3Ii8KC/RKYTM+NWzd8d?=
 =?us-ascii?Q?VWo4LV0xfohFDjfN2VxMlrbbbOO6LUnYGHN8norZW4s4KjFCMVlobRzIojGK?=
 =?us-ascii?Q?v3wKjlZ/3uSjktgL1wcFYgh0/PZORvvcxa/+XVhDO8r3PJPUS53kwk6YElNz?=
 =?us-ascii?Q?kwPmlAP7Kgm7wB42fw85bqnpXFolmMTQPRBrsgWR/leAdqv+SPO1SlKm39rC?=
 =?us-ascii?Q?Y/EF8Bh0euY+xRZS3QYm+WyyQ94+Wwi/j4pWd7bn1UELBU2TVINaOirq+Tpr?=
 =?us-ascii?Q?FLZsnkwFZ0H4oZMaUZEOBe3dUa4l/JVl44VBK0tFRfrEok0pbG/+RKyyAhLy?=
 =?us-ascii?Q?DXSLDBoNRqxsMNIIki/9TeJvQXe1FX4L1Qoo2SJjMRjd59i/MgTF+HoXvXwj?=
 =?us-ascii?Q?wpNUqNDcpYtuv4JsPPj6ammhct7GNBYX+JtLVMNs2GWWACo82ziPDBbpQnLO?=
 =?us-ascii?Q?+vCqm06pOkvOTwAh7P80cK2EVimtFLrr7N2EFCu018rJEyyKfXOyfYNSuBsF?=
 =?us-ascii?Q?ZcPjfNiW/lFPJt2ICKqLUmoW5BZVQ3H8gAzEJhdsAkSr3LdoUvF6TzK1eRR6?=
 =?us-ascii?Q?Ti7W0YFLEL2XUjunljtzLcx8aq1oh3FgqstM9+EZw88YJZRCV3zMwQ4rNvsY?=
 =?us-ascii?Q?jlPwnvgrjYQijGqSzrQGNzPduYxjKXVrYBVLNwh9csh60Ft2jznwcp0lLxeq?=
 =?us-ascii?Q?KIbiBcpfUbYH3b42UDonfxn25ssZjqO/2j3jnUtDFI4CzZqW31JzXTBt0Tuu?=
 =?us-ascii?Q?fc/rUTsV0d+ZPs4v3uv5ZwAhyPXSQRGIyzC1csYjDcHjkTuhLKYv8mw6yvXb?=
 =?us-ascii?Q?R0QPc0jPhkAGoTt5nGM6qsuLSkRy4OYyxlauFAZpQYPmfebNu+1Hkqr26F42?=
 =?us-ascii?Q?1GJIc3ZhD7iz4jEDqA2iAQnFcmzi61sSKju279EBvBuw+mcFpM8LH5JGZWCN?=
 =?us-ascii?Q?AN/SCcv6kFqNl77Yk027xYkmVZmJOWN/yfn5mNGwlW/O499Hbaqoazk9f/NP?=
 =?us-ascii?Q?RIRuALsufaa6bRRseDvr6IQF/Hj4D9eLl/Jl3osqeMHbGYT62XSBqWoJjSF0?=
 =?us-ascii?Q?XPoz4DRXnSQu2N1PKpLiXBGm6MPhr2nDy8wsvJi16y0OJ26wvi1tzKPok6Cb?=
 =?us-ascii?Q?ygA1EGE3BB9bqajLOlSEshr7SamAwCkNlbMUv9p57/wy36g/eTCI9kg1D/Bc?=
 =?us-ascii?Q?yIAwc5Wud+f2LerklOsDaJbqJJCJ6nzunZ0I7WnR4kgR2GvfyuGcQP4hCoaz?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8826a5-1f2c-4d64-80a5-08de25aee8ad
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 07:57:09.2608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0BcoYhrh1laT+sckHToHOdF8+Jr/sVfpAoe1pvAoPBmJ7JcStWSnC/ph08oi3Ek3/Avc0eQ1+ZgV5FNLcFmxoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5003
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel_BUG_at_lib/list_debug.c" on:

commit: a1dc648aa76d61d8e75692cecea043b1bfdfeda6 ("wifi: mac80211: remove chanctx to link back-references")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 6d7e7251d03f98f26f2ee0dfd21bb0a0480a2178]

in testcase: hwsim
version: hwsim-x86_64-9c969af8d-1_20251102
with following parameters:

	test: group-21



config: x86_64-rhel-9.4-func
compiler: gcc-14
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4790 v3 @ 3.60GHz (Haswell) with 6G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202511171510.c273ee80-lkp@intel.com


[  491.138911][ T5995] ------------[ cut here ]------------
[  491.144253][ T5995] kernel BUG at lib/list_debug.c:59!
[  491.149445][ T5995] Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
[  491.155553][ T5995] CPU: 4 UID: 0 PID: 5995 Comm: hostapd Tainted: G S                  6.18.0-rc4-00716-ga1dc648aa76d #1 PREEMPT(voluntary)
[  491.168255][ T5995] Tainted: [S]=CPU_OUT_OF_SPEC
[  491.172875][ T5995] Hardware name: Dell Inc. OptiPlex 9020/03CPWF, BIOS A11 04/01/2015
[  491.180796][ T5995] RIP: 0010:__list_del_entry_valid_or_report (lib/list_debug.c:59 (discriminator 1))
[  491.187681][ T5995] Code: 89 de 48 c7 c7 20 5a 55 84 e8 54 c7 92 fe 0f 0b 48 89 ef e8 da 53 3c ff 48 89 ea 48 89 de 48 c7 c7 80 5a 55 84 e8 38 c7 92 fe <0f> 0b 48 89 ef e8 be 53 3c ff 48 89 ea 48 b8 00 00 00 00 00 fc ff
All code
========
   0:	89 de                	mov    %ebx,%esi
   2:	48 c7 c7 20 5a 55 84 	mov    $0xffffffff84555a20,%rdi
   9:	e8 54 c7 92 fe       	call   0xfffffffffe92c762
   e:	0f 0b                	ud2
  10:	48 89 ef             	mov    %rbp,%rdi
  13:	e8 da 53 3c ff       	call   0xffffffffff3c53f2
  18:	48 89 ea             	mov    %rbp,%rdx
  1b:	48 89 de             	mov    %rbx,%rsi
  1e:	48 c7 c7 80 5a 55 84 	mov    $0xffffffff84555a80,%rdi
  25:	e8 38 c7 92 fe       	call   0xfffffffffe92c762
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	48 89 ef             	mov    %rbp,%rdi
  2f:	e8 be 53 3c ff       	call   0xffffffffff3c53f2
  34:	48 89 ea             	mov    %rbp,%rdx
  37:	48                   	rex.W
  38:	b8 00 00 00 00       	mov    $0x0,%eax
  3d:	00 fc                	add    %bh,%ah
  3f:	ff                   	.byte 0xff

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	48 89 ef             	mov    %rbp,%rdi
   5:	e8 be 53 3c ff       	call   0xffffffffff3c53c8
   a:	48 89 ea             	mov    %rbp,%rdx
   d:	48                   	rex.W
   e:	b8 00 00 00 00       	mov    $0x0,%eax
  13:	00 fc                	add    %bh,%ah
  15:	ff                   	.byte 0xff
[  491.207158][ T5995] RSP: 0018:ffffc90000d2f280 EFLAGS: 00010282
[  491.213086][ T5995] RAX: 000000000000004e RBX: ffff88812b278800 RCX: 0000000000000000
[  491.220923][ T5995] RDX: 000000000000004e RSI: 0000000000000008 RDI: fffff520001a5e43
[  491.228758][ T5995] RBP: dead000000000122 R08: 0000000000000001 R09: fffff520001a5e0d
[  491.236597][ T5995] R10: ffffc90000d2f06f R11: 0000000000000001 R12: ffff8881958a1c80
[  491.244453][ T5995] R13: ffff88812b278808 R14: ffffffffc1de74c0 R15: ffff888193de9f80
[  491.252291][ T5995] FS:  00007f20bfd80b80(0000) GS:ffff8881b20bd000(0000) knlGS:0000000000000000
[  491.261080][ T5995] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  491.267524][ T5995] CR2: 000055fb9968c370 CR3: 000000018797c005 CR4: 00000000001726f0
[  491.275361][ T5995] Call Trace:
[  491.278505][ T5995]  <TASK>
[  491.281304][ T5995] ieee80211_free_chanctx (include/linux/list.h:223 (discriminator 1) include/linux/rculist.h:178 (discriminator 1) net/mac80211/chan.c:814 (discriminator 1)) mac80211
[  491.287546][ T5995] __ieee80211_link_release_channel (net/mac80211/chan.c:1901) mac80211
[  491.294684][ T5995] ieee80211_stop_ap (net/mac80211/cfg.c:1919) mac80211
[  491.300599][ T5995]  ? __pfx_validate_nla (lib/nlattr.c:396)
[  491.305482][ T5995]  ? __pfx_ieee80211_stop_ap (net/mac80211/cfg.c:1810) mac80211
[  491.311828][ T5995]  ? __rtnl_unlock (net/core/rtnetlink.c:145)
[  491.316275][ T5995]  ? netdev_run_todo (include/linux/list.h:381 (discriminator 2) net/core/dev.c:11652 (discriminator 2))
[  491.320985][ T5995]  ? __pfx_netdev_run_todo (net/core/dev.c:11629)
[  491.326130][ T5995]  ? mutex_lock (arch/x86/include/asm/atomic64_64.h:101 (discriminator 5) include/linux/atomic/atomic-arch-fallback.h:4296 (discriminator 5) include/linux/atomic/atomic-long.h:1482 (discriminator 5) include/linux/atomic/atomic-instrumented.h:4458 (discriminator 5) kernel/locking/mutex.c:157 (discriminator 5) kernel/locking/mutex.c:273 (discriminator 5))
[  491.330317][ T5995]  ? __pfx_mutex_lock (kernel/locking/mutex.c:270)
[  491.335029][ T5995]  ? __pfx_ieee80211_stop_ap (net/mac80211/cfg.c:1810) mac80211
[  491.341411][ T5995] ___cfg80211_stop_ap (net/wireless/rdev-ops.h:190 net/wireless/ap.c:33) cfg80211
[  491.347451][ T5995]  genl_family_rcv_msg_doit (net/netlink/genetlink.c:1117)
[  491.352856][ T5995]  ? __pfx_genl_family_rcv_msg_doit (net/netlink/genetlink.c:1088)
[  491.358784][ T5995]  ? security_capable (security/security.c:1181 (discriminator 1))
[  491.363495][ T5995]  genl_family_rcv_msg (net/netlink/genetlink.c:1195)
[  491.368467][ T5995]  ? __pfx_genl_family_rcv_msg (net/netlink/genetlink.c:1160)
[  491.373961][ T5995]  ? __sys_sendmsg (include/linux/file.h:62 (discriminator 1) include/linux/file.h:83 (discriminator 1) net/socket.c:2708 (discriminator 1))
[  491.378498][ T5995]  ? do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
[  491.383121][ T5995]  ? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[  491.389049][ T5995]  ? __pfx_nl80211_pre_doit (net/wireless/nl80211.c:17917) cfg80211
[  491.395320][ T5995]  ? __pfx_nl80211_stop_ap (net/wireless/nl80211.c:6972) cfg80211
[  491.401502][ T5995]  ? __pfx_nl80211_post_doit (net/wireless/nl80211.c:18019) cfg80211
[  491.407846][ T5995]  ? unwind_get_return_address (arch/x86/kernel/unwind_orc.c:369 (discriminator 1))
[  491.413340][ T5995]  ? arch_stack_walk (arch/x86/kernel/stacktrace.c:26)
[  491.417960][ T5995]  genl_rcv_msg (net/netlink/genetlink.c:65 net/netlink/genetlink.c:1211)
[  491.422236][ T5995]  netlink_rcv_skb (net/netlink/af_netlink.c:2550)
[  491.426861][ T5995]  ? __pfx_genl_rcv_msg (net/netlink/genetlink.c:1201)
[  491.431744][ T5995]  ? __pfx_netlink_rcv_skb (net/netlink/af_netlink.c:2527)
[  491.436887][ T5995]  ? __pfx___netlink_lookup (net/netlink/af_netlink.c:494)
[  491.442119][ T5995]  genl_rcv (net/netlink/genetlink.c:1220)
[  491.445961][ T5995]  netlink_unicast (net/netlink/af_netlink.c:1319 net/netlink/af_netlink.c:1344)
[  491.450586][ T5995]  ? __pfx_netlink_unicast (net/netlink/af_netlink.c:1329)
[  491.455730][ T5995]  ? check_heap_object (mm/usercopy.c:189 (discriminator 1))
[  491.460612][ T5995]  ? 0xffffffff81000000
[  491.464626][ T5995]  ? __check_object_size (mm/memremap.c:392)
[  491.470292][ T5995]  netlink_sendmsg (net/netlink/af_netlink.c:1894)
[  491.474917][ T5995]  ? __pfx_netlink_sendmsg (net/netlink/af_netlink.c:1813)
[  491.480062][ T5995]  ? __import_iovec (lib/iov_iter.c:1347 (discriminator 1) lib/iov_iter.c:1361 (discriminator 1))
[  491.484774][ T5995]  ____sys_sendmsg (net/socket.c:727 (discriminator 1) net/socket.c:742 (discriminator 1) net/socket.c:2630 (discriminator 1))
[  491.489408][ T5995]  ? import_iovec (lib/iov_iter.c:1428 (discriminator 1))
[  491.493686][ T5995]  ? copy_msghdr_from_user (net/socket.c:2570)
[  491.499003][ T5995]  ? __pfx_____sys_sendmsg (net/socket.c:2576)
[  491.504146][ T5995]  ? __pfx_copy_msghdr_from_user (net/socket.c:2556)
[  491.509812][ T5995]  ? do_syscall_64 (arch/x86/include/asm/jump_label.h:36 include/linux/context_tracking_state.h:108 include/linux/context_tracking.h:41 include/linux/irq-entry-common.h:261 include/linux/entry-common.h:212 arch/x86/entry/syscall_64.c:100)
[  491.514444][ T5995]  ___sys_sendmsg (net/socket.c:2686)
[  491.518901][ T5995]  ? __pfx____sys_sendmsg (net/socket.c:2673)
[  491.523957][ T5995]  ? _inline_copy_from_user (arch/x86/include/asm/uaccess_64.h:134 arch/x86/include/asm/uaccess_64.h:134 arch/x86/include/asm/uaccess_64.h:141 include/linux/uaccess.h:178)
[  491.529189][ T5995]  ? copy_from_sockptr_offset (include/linux/sockptr.h:51)
[  491.535725][ T5995]  ? __pfx_copy_from_sockptr_offset (include/linux/sockptr.h:46)
[  491.542693][ T5995]  ? kmem_cache_free (mm/slub.c:2504 mm/slub.c:6630 mm/slub.c:6740)
[  491.547493][ T5995]  ? __pfx_netlink_setsockopt (net/netlink/af_netlink.c:1644)
[  491.552899][ T5995]  ? file_close_fd_locked (arch/x86/include/asm/bitops.h:222 arch/x86/include/asm/bitops.h:233 include/asm-generic/bitops/instrumented-non-atomic.h:142 fs/file.c:346 fs/file.c:629 fs/file.c:706)
[  491.558131][ T5995]  ? fdget (include/linux/atomic/atomic-arch-fallback.h:479 (discriminator 2) include/linux/atomic/atomic-instrumented.h:50 (discriminator 2) fs/file.c:1167 (discriminator 2) fs/file.c:1181 (discriminator 2))
[  491.561974][ T5995]  ? do_sock_setsockopt (net/socket.c:2329)
[  491.567036][ T5995]  __sys_sendmsg (include/linux/file.h:62 (discriminator 1) include/linux/file.h:83 (discriminator 1) net/socket.c:2708 (discriminator 1))
[  491.571413][ T5995]  ? __pfx___sys_sendmsg (net/socket.c:2701)
[  491.576410][ T5995]  ? __sys_setsockopt (net/socket.c:2385)
[  491.581208][ T5995]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
[  491.585662][ T5995]  ? do_syscall_64 (arch/x86/include/asm/jump_label.h:36 include/linux/context_tracking_state.h:108 include/linux/context_tracking.h:41 include/linux/irq-entry-common.h:261 include/linux/entry-common.h:212 arch/x86/entry/syscall_64.c:100)
[  491.590285][ T5995]  ? do_syscall_64 (arch/x86/include/asm/jump_label.h:36 include/linux/context_tracking_state.h:108 include/linux/context_tracking.h:41 include/linux/irq-entry-common.h:261 include/linux/entry-common.h:212 arch/x86/entry/syscall_64.c:100)
[  491.594910][ T5995]  ? do_syscall_64 (arch/x86/include/asm/jump_label.h:36 include/linux/context_tracking_state.h:108 include/linux/context_tracking.h:41 include/linux/irq-entry-common.h:261 include/linux/entry-common.h:212 arch/x86/entry/syscall_64.c:100)
[  491.599530][ T5995]  ? __irq_exit_rcu (kernel/softirq.c:688 (discriminator 1) kernel/softirq.c:729 (discriminator 1))
[  491.604153][ T5995]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[  491.609906][ T5995] RIP: 0033:0x7f20bff06687
[  491.614184][ T5995] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
All code
========
   0:	48 89 fa             	mov    %rdi,%rdx
   3:	4c 89 df             	mov    %r11,%rdi
   6:	e8 58 b3 00 00       	call   0xb363
   b:	8b 93 08 03 00 00    	mov    0x308(%rbx),%edx
  11:	59                   	pop    %rcx
  12:	5e                   	pop    %rsi
  13:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
  17:	74 1a                	je     0x33
  19:	5b                   	pop    %rbx
  1a:	c3                   	ret
  1b:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  22:	00 
  23:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  28:	0f 05                	syscall
  2a:*	5b                   	pop    %rbx		<-- trapping instruction
  2b:	c3                   	ret
  2c:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  33:	83 e2 39             	and    $0x39,%edx
  36:	83 fa 08             	cmp    $0x8,%edx
  39:	75 de                	jne    0x19
  3b:	e8 23 ff ff ff       	call   0xffffffffffffff63

Code starting with the faulting instruction
===========================================
   0:	5b                   	pop    %rbx
   1:	c3                   	ret
   2:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   9:	83 e2 39             	and    $0x39,%edx
   c:	83 fa 08             	cmp    $0x8,%edx
   f:	75 de                	jne    0xffffffffffffffef
  11:	e8 23 ff ff ff       	call   0xffffffffffffff39


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251117/202511171510.c273ee80-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


