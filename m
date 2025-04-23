Return-Path: <linux-wireless+bounces-21856-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54523A97C2D
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 03:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7E427A1E56
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 01:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE771261573;
	Wed, 23 Apr 2025 01:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nxcZahVl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549FD1A5BA4
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 01:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745372303; cv=fail; b=pBZE/RBFjJEc6URGPch1Emj02nxntbo8jz/slw6e8D+msMSpydBnHc0YD+R1iT/v9jgItMxcxPcK/5RUnxxDZd0G/jBpcmb9379l4+XuaCHFcibpGwjV3duuKg7QD4DMCfdV2pfqVocILSt35dD7Bt0DU88SLwWrjLvo/moNO8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745372303; c=relaxed/simple;
	bh=7VxOr0wy118I566ekMq1H0iMDTiS/PjLBPmIjDCfHI4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qKXvKwVuDAxfk9TqqwvJ4qLvaaMWexOTGJrrozE9kMPMhNiKZ5ZS/NVA3WSBFXE8vn+7NqyXhOkKlZBqI0jM9oe7Rt05OvdT1/L0+iLHZ6a7WJGL8Iu/VGJ+uqe+zh4NnGLLr++flQbNgw0dCJ0mLrXoyyb26RZvUoUg8jCWvx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nxcZahVl; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745372303; x=1776908303;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7VxOr0wy118I566ekMq1H0iMDTiS/PjLBPmIjDCfHI4=;
  b=nxcZahVlKPH/b4UmLebd8f2uoVFuRthK7L7NX85fJFhjl5zvyFJ2jvFx
   25vfECAV60ehRQtnsS7i4oPOmMOkEHaUSj5Z7MX9Hs3Btc27RaY2JRpwb
   JYt8WmOsD+7h/ksTi5eRvP5jM8rzDidmVXCbQUZqwWL4Wkmk6VpadEiln
   bEyar8ZIUr67sbYbeCZnUSZy1KMAa8LM2fRnxVYoKuOmyk8JqCbJpGHe/
   R3cuo/vuCn9JBO3v0p3t2dXScgbznYb6SF7iM2/s3PIQbd6Hx/6a3Y9NV
   OQBqS/ID3sQvt7gEfp1eW9x/Tr21E2bxl9Vj2ZNBMTihpyA5YBaFkHwu2
   Q==;
X-CSE-ConnectionGUID: XEQXyVF3QsyJ631VhZNLJw==
X-CSE-MsgGUID: KTJaxcX8So+1TjDZQ5ekrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="64361023"
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="64361023"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 18:38:22 -0700
X-CSE-ConnectionGUID: RXCXTy27STyI0z6W/xIVdw==
X-CSE-MsgGUID: 2hX+BnMLStSzgrzAzjsa2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="132024635"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 18:38:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 22 Apr 2025 18:38:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 22 Apr 2025 18:38:20 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 22 Apr 2025 18:38:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=quPLI9dDkyvBw3/v8mAZnNu0eNT5gC+EayPdBUUCWaPqHNb1z0bk6VfrbsmOC8n/OxF7zVd6Mq1kS+4X9vcOnuPunZ63Z0U37UXLHZn2QJHee1Kt2CGSB9d+Uc+Jd9aVQ4WARjP4nLKtWtiyjnZ2oLenMjMz5s29h7p973yWUB/Bfn9eXKSUk97oU45lHtV3/EKX7co9AgKsKDzdpTq5VtvQaisTq7LP11QGGD/auyZeDz34I+R3Vw+dPDtHoSu5JEt1YAL4bjJxX/cCIClKQQi0ZfyNdV82SqbxQmwNWiPGlv+/e+VcSY0FeMotY/BAz4rtPcS6EmcI29ecDBWa5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buxVHD/bYwbnF6lyNSXlkVlYiQjaKR6/HjNiB5/ilNc=;
 b=Pi7RTLyh3eC7iQP3pwFcERsSQrppe23lAzHQufZidVmgfVBdGz1wIQ7Qkqry8Y4FepcZfCqY0u4rUCapNtu5rGVCLcqldXT3vR86tOyjiai9elq6C+bHH6FLg0prgKZ59MJEfRhDgJ70lMXDedfZddnNYIM4qscds9/K5sgzWXXx/pXOvVmK1ahwNE+pcsQzkHUppLqUHFQ0Fs0WTY+e3FV+pmgKGBogYlpx7C44j0LhrLyETT+k4CWO0JjrnhJZq9FsnQ0Q+qFtML2PmdZY3GMikdTu73x55YXApJWqe77B/MlyUUe0d1Od7Dj1hbPCQ+pPy8NmeLThAVBo9d+ojA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
 by DM3PR11MB8681.namprd11.prod.outlook.com (2603:10b6:0:49::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.22; Wed, 23 Apr 2025 01:38:04 +0000
Received: from PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a]) by PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a%5]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 01:38:04 +0000
Date: Wed, 23 Apr 2025 09:37:55 +0800
From: Philip Li <philip.li@intel.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
CC: kernel test robot <lkp@intel.com>, Karthikeyan Kathirvel
	<karthikeyan.kathirvel@oss.qualcomm.com>, <ath12k@lists.infradead.org>,
	<llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
	<linux-wireless@vger.kernel.org>
Subject: Re: [PATCH ath-next] wifi: ath12k: allow beacon protection keys to
 be installed in hardware
Message-ID: <aAhEc8yrW4vcrE7J@rli9-mobl>
References: <20250421114711.3660911-1-karthikeyan.kathirvel@oss.qualcomm.com>
 <202504220128.2KvxCzaG-lkp@intel.com>
 <47ea4e64-cd87-4c42-a20d-f663f197e44c@oss.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <47ea4e64-cd87-4c42-a20d-f663f197e44c@oss.qualcomm.com>
X-ClientProxiedBy: SG2PR04CA0164.apcprd04.prod.outlook.com (2603:1096:4::26)
 To PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5674:EE_|DM3PR11MB8681:EE_
X-MS-Office365-Filtering-Correlation-Id: cb5ee578-c59e-4654-a483-08dd82077d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gDuTLDyajT5ziW4g0pHY62LdplkFpddNt6EP6WP8wxC+1UwaDE2YAtjzpb+7?=
 =?us-ascii?Q?znVbNISnzCp9h+PcrmcfQcj/VcVykbvnKTf9fZbtjE69plXTqbFsiVkOcLv4?=
 =?us-ascii?Q?9eQbiFoe1BJoje7b9kHEkJL6qTb0hyTCSBRJ+I0mDJqVPBPf9pazc96EiiDl?=
 =?us-ascii?Q?XBbKuvl2q1UkwQRcjWrynDrXC3hPCuXkT7UCCv+WZFSc1dXoOLqjkom335jH?=
 =?us-ascii?Q?BtrHMDgKasgfruS4n50gv5UduOcc8INtHaHwf0HKdyVBTngQh4nKYlf0UYJe?=
 =?us-ascii?Q?1u4Pa28YvaiLAntpn73Q+Du6X0urEhXIjMMK+W0XRXqjN4KxMeW/UF7K7naY?=
 =?us-ascii?Q?YPdbpuMDHuDQGARerU5FI0sBC0/DENyqhwXnnDnf0V0o1uvPX2gpitvFVb+v?=
 =?us-ascii?Q?gGg+weVv38tw6dJLiu0tr19xlMQH6tpZBEtcOmZgVwQDBV7YztdJ2d/qPecu?=
 =?us-ascii?Q?RvmNWrEv2/E53mvUHrAxuzW0iZ2MLWsoNFmLSZz5wsQZfdQdNaBT4XJGHq6h?=
 =?us-ascii?Q?Vw0s/BM0W6crpH1ocqRBvCKVJZgoBlA2PH/0wKnETg7Vo5Mkoe2rixUkTAoV?=
 =?us-ascii?Q?kPPF5+/POF5SdsmSnJCwsmXmJf/BZ3yR1Rh3laGT516nqmpEKN9cWlhG11mt?=
 =?us-ascii?Q?abyzK7yAinTL3b8b7WhGO3LHCCKpdAqGviQjmYatHAJnOqWs8JExU5MsGzNs?=
 =?us-ascii?Q?pqLBweua3msC/k82navkn6JHmBmXHf2kb0H8fawrg0Qa5P1cmE/QmP9KpEq3?=
 =?us-ascii?Q?cKpfO3tvcgZ0hwSxFmdUh9g2I1ZWnj16urNoqN1TsrmxdyhtgxjiZvb3i57f?=
 =?us-ascii?Q?XwMJtGljsBCqtG5iEVqvBW4GipbaWi3JYQ4lyY9vNbTD2VSl5ZX2ghI1YNcb?=
 =?us-ascii?Q?mAY8LwVWY4atkQBu/XfqBvhWBO9jOmTraWKbvctHcNi8HMOJfX79Jxx/rrpy?=
 =?us-ascii?Q?xO12T4nNRwqoe6Q7frHNKvjSMVICx03lQjLephtwjnV0lf9LVLkEoDpakKbY?=
 =?us-ascii?Q?A4xhnos4fHp+jTDPxFjInSOTP/bvEG/dn0CeEFAlGrqQAL8PoB4g4tdeHLJB?=
 =?us-ascii?Q?UWtuXkxFq5JoK2y0Je5jXmYohq2RK5igmNNJewqR5ujUVUUOO7kqC6l9PWHn?=
 =?us-ascii?Q?ZN7GgsUyHKQZq2g+sWwfIC5TWUc/eMOGbJ2VpZ8rM38hGxBpiGSLegW8rsn2?=
 =?us-ascii?Q?AlZJCCLviw67r4H3qN391FDoVC2/SOuC4p1pX7BQ9JNd8T3ZrbFbRFIYjV0L?=
 =?us-ascii?Q?ylfPn4LmseQvQorNa4//YvDYSLkTs+l93n6loQ+JmD+alX0VOE3DWifc25YM?=
 =?us-ascii?Q?i7aCd6XGffnSjks7HGW1b0+JC6KjhlHa9uqP5bWOekY+EjCVpZ+YU3jbZE4Q?=
 =?us-ascii?Q?Gbc5FrWcSNzsHeD4tJiwUOWiqcNcpbYdyrwCxTAmygh4PqudozM92tJ8/sIg?=
 =?us-ascii?Q?GFBlQS3AOAY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5674.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?URaAHpyOSlPetyzXbdc5I3zLh1oiarsuNfKkriig6CAEcnq9XluyyfozYh53?=
 =?us-ascii?Q?Xcirbc6pWvFhhPfRcETDyfApnqBMt6Sfl/FQJnrh3Np7TGbPCxB4cBNsDLRS?=
 =?us-ascii?Q?f65nf6ZYKdiRT6Uuld2GOFuaCDDUWkl9fezNle7dr5GKkRdL4Ls+jtsjcUK7?=
 =?us-ascii?Q?faHTp5clTtRGB9jk4Rqq31n+Ksymn9WD/1sXp7btrTv3RUZ/Cla6KQDnX7IC?=
 =?us-ascii?Q?oO1/CBaEVt7rUOCGwYj+VcTRF11YpxnPXcmWXH4qT75Va9D6WI7eHw6byrVH?=
 =?us-ascii?Q?0dYEY4/LwGo9W1Rgq///orq11QoHbHoXdOlqBmmjPBR5HOryfdn2innzzC8P?=
 =?us-ascii?Q?+6C0nrJhV3xkVsM2T2DvVos5fkTJEKfHw0bbk8qocw2LAZHEvs2+j5s7W2ll?=
 =?us-ascii?Q?d/uvnp02wqrLdRrYPLdSkDsdwiEoHSa91vQ8dINiF2Ju1iiv+GGlSN6Qtf+I?=
 =?us-ascii?Q?eyATsisfYChG/mLTM7Nm6cKcTeo7AcPRs6BxFbOjc8k+Pr5TblN2HqqhEVdV?=
 =?us-ascii?Q?8xIzMf8pqjLfyc/fouk0WNdOd+r/uIdTuMxLegZ4HrMVlXdIs2izi8wVvIkX?=
 =?us-ascii?Q?0VKwbec0SvxylAQCyKyJUyw3sRrGtzyFEtXpz+uvNrkfVntYl7g4Pyc5pVZc?=
 =?us-ascii?Q?z2lDFfpeULsVRw2rwN8eouswg+tuDsS6DtzYeh/98dwn6lBrjZ8c+ObvV/gW?=
 =?us-ascii?Q?rt46GGeZ4DDoDTeiiaKZgbqGLscFmiOqFydsTYWOEcvokx/u/RW8VaXc1hGa?=
 =?us-ascii?Q?msrU+ikDWfWU/NVyxwROuL7a+yOiW7RpAzUEZHh5P0EZ9+C8/q1hSWsfbrEV?=
 =?us-ascii?Q?DwxPjk1pYs4ONfphCS8SZ9ptTMNl9naY4Baf6jXSUvZb5es+RmGNkpMNfeCa?=
 =?us-ascii?Q?4b0XuQLkacJP0sJ+n9xoUaaTdSkXPJJmM33Wq0n3aVPFm1xd0vOlQI/mNeCo?=
 =?us-ascii?Q?rK+AUeDai/3m0Og5z5ToHIaPXCg+ktyTBc9HZm2JRK070jSXD7mO98YalY5D?=
 =?us-ascii?Q?HLqDyYXkjdXVHVUdt++WMa519cjvMIFKqs+EfexbcjY3J1SLxQBOoOZdKb4+?=
 =?us-ascii?Q?CQqcHK9Rdsbby/pGOxIJx0KGFVm2dMF1/l1W5ai9Qqvd/Whnhlf6L5kRsR4H?=
 =?us-ascii?Q?ziE3H+DU7MF7hLdhxKpysHBTu2R0fiHDjNQo++/mUs8E/GLHYJ8amemJJrS6?=
 =?us-ascii?Q?cK1IjmNr70J7r2lBwLRZdZBEaBuxezu07D5cEKlQCP14lOPdR3Npk9/JNzV+?=
 =?us-ascii?Q?Y+isIXTlj+CeBGo/xYj7sYGS9qXG3ao9c854lB2+/lwX0L9Q+Mk/1q8CVjOy?=
 =?us-ascii?Q?DOSPILqLY+gIPqCdK2qdStr/xzNrh/jtKxWcruOF+lPW/nOBMDfW9U4h67Qy?=
 =?us-ascii?Q?sQopInDPxiOpQl3bOEQ7C6jbj4vGr5+Wfr8MWCXDaNJq9cHKEiS8FnmDyxbv?=
 =?us-ascii?Q?S/aD6AapZUF+8xt6cbrH+OiSezfmOzIpZjp5j4Y2BxcyrmWyJq6gymA1BDmx?=
 =?us-ascii?Q?XYv/VCgA66DhSGh7XnMuOwI/ptZZ+bLAjaK/s8eCkQPNw41MwJGUHmi5rt1P?=
 =?us-ascii?Q?UImlx3AbiYIwniAuwcy0VamRkUSQaYM0eJbPtliy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5ee578-c59e-4654-a483-08dd82077d96
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5674.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 01:38:04.2902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1MVxtb9/njhZa1mug5sJqdAiXqG3MdXz2PmANRHkKPlVF0nFws963xzzKBaXJ9DlUbZ+g9qga3BT/Jp0f4/zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8681
X-OriginatorOrg: intel.com

On Mon, Apr 21, 2025 at 11:44:46AM -0700, Jeff Johnson wrote:
> On 4/21/2025 10:16 AM, kernel test robot wrote:
> > Hi Karthikeyan,
> > 
> > kernel test robot noticed the following build errors:
> > 
> > [auto build test ERROR on d33705bb41ff786b537f8ed50a187a474db111c1]
> 
> lkp@intel.com folks:
> This patch contains the following footer:
> 
> base-commit: d33705bb41ff786b537f8ed50a187a474db111c1
> Depends-on: <20250421111505.3633992-1-karthikeyan.kathirvel@oss.qualcomm.com>
> 
> Is there a different mechanism needed to tell the robot about the dependency?

Sorry for confusion, for now if there's base-commit specified, the bot would
only consider it as the base and apply the patch. And actually, if there's
a dependency specified by link, the bot so far can't recognize it well.

BTW: for this case, does it mean the patch need be applied on this "Depends-on"
patch, and this "Depends-on" patch is on top of the base-commit?

> 
> 

