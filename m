Return-Path: <linux-wireless+bounces-23919-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C126FAD30C4
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 10:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74630170F98
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 08:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5281EE033;
	Tue, 10 Jun 2025 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z023808R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AB8281516
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 08:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749545112; cv=fail; b=Tm7JjzCGRhnD9MOHTCYS2V5N52MTeboIwQXC4nKSMf4RfPJjfDxZUq148Iww/A2Uj0SB5rWqFMA6Bgbm1Ej81O8HD2OYdXmZ2gb6CgnSRTLl2KAhGBRxVHY/gsFtCOdpILzqUsfImShqDOj20v4RAq65T3MkAfyDQFF0go1tyGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749545112; c=relaxed/simple;
	bh=EzYvFK0nY70tjKorD2BWSsx13VpZXV5Qxsbut84xDEo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L23NPqlRUapZwk//shcv8SEHMq+zfLU8jz2ecLHwSG90Fu7f5Jnioxx+F2R1sprW/gdvAxtxdWaJsYsW03wrBSnokOiRugaJX4t5odQE4ED6/lmSogVgXptYTHyUci1KvV45o6TV1SihZUQls22ajZfcaIIrrR8jdOKLuDk68rM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z023808R; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749545111; x=1781081111;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=EzYvFK0nY70tjKorD2BWSsx13VpZXV5Qxsbut84xDEo=;
  b=Z023808RYvcohM1TpvhRic03FpNHVVBCu/vODUg4gpR8cJqBfmAqRyBW
   P97552FLcovr0QzdHDWoHRaJBUxN9JYrL4f1KLdsQxQpRQ5veES5KmNGw
   WdKq3cRMgXn+4PWv3vzB5Z3zs7Wgf7pF51GUSRl9kJTy3OQpe1J2XXWHE
   Xy20e3NYlElF/wiqAW9grE0UrI5EyuKOzd3HH1ZCDPIv9JnVrGhVZXI0Y
   xb/6HowZtq2JQWBWZvdAuAbhu5Nqjkg3WiO80LDq6X2UH6xICQb45m4lw
   doq+223WWS+5SXuITTjsMKHG2YzowHq4viE3EHCU37cAY84Vrex0VX7kA
   A==;
X-CSE-ConnectionGUID: A7Lpj/T5SAKnL7uWYI7xIQ==
X-CSE-MsgGUID: 4Z7s5FcvRXi3ilNoMAdxIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="61914301"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="61914301"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 01:45:10 -0700
X-CSE-ConnectionGUID: WcOt63foQqGlCnoZQQCPNQ==
X-CSE-MsgGUID: 9/gpqWMHQ0yh+lmM4jm1HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="150606364"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 01:45:09 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Jun 2025 01:45:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 10 Jun 2025 01:45:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.41)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Jun 2025 01:45:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSkTG0TBqlu7ynERe0RZDIgMZos5J35rfzcTqwFYL0ExwhtzFhS+0qI4zMrX9U2xFtVl2e8p6+G+JSKrMqelbA8cxGRB+cj4xwDK/bUkZ1qzGDTSCWN6ZdAvegQecvRt0Cnif4YDS/UqkWN05bff1/RzaOFNWxnNcIi8i/Lw/cMIO66HHlOTkEJifuV1U78tVuampTfYegckh4sJW8knxdJg82aIqYf14GTWVya6rDHW0uhv+b3UmBY4FQ0M1O+udtryV9ppco5ut7DGVM/04LDT4J4fne5oXayq1ItMlCqYfqcbV0Nc17IMs5WQoZMF2ENpRaNqzPUhwLxUm3t1kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pp9JQYRWdSwriD+YIxY02Qqqcwpk76JYcgvbVzNIDKM=;
 b=Rb8EH32IdnCDysgiGt8dAkkBoGSBJWt92nKO/FjjhvnIFC2JBVWSygBLcXqBJ1yHPcnXuMacnILzd/1E8iL0lpDp+zfsQC8F8vF9OAq61Cz5soKuvXO/eKNccJnIWwWIqf6SYRCyKkZtIzgH91RYyDAbcTqJBesAxPJuPepMpGnoTTamBd+WoLm5OBqTxHiDN2cnM9MYHoFVx3qEwo0PfU/Y4SRRDAWUpo/NcTQjcsdX7HITd0yu3dSstB7gzFM/BcGamU568tMamnHXcuE+Bx7u3x5Y9lxC8Ig8mLNvTTXIzMQijwrySihFT+vH1BtbamZdWq8pZ/zbuDU+excQkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CYYPR11MB8387.namprd11.prod.outlook.com (2603:10b6:930:c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Tue, 10 Jun
 2025 08:44:47 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8792.034; Tue, 10 Jun 2025
 08:44:47 +0000
Date: Tue, 10 Jun 2025 16:44:38 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>, "Roopni
 Devanathan" <quic_rdevanat@quicinc.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH wireless-next v14 2/4] wifi: cfg80211: Add Support to Set
 RTS Threshold for each Radio
Message-ID: <202506101652.625ca3c4-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250605111040.3451328-3-quic_rdevanat@quicinc.com>
X-ClientProxiedBy: SG2PR02CA0073.apcprd02.prod.outlook.com
 (2603:1096:4:90::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CYYPR11MB8387:EE_
X-MS-Office365-Filtering-Correlation-Id: d8e37ef6-0700-4ee4-9dab-08dda7fb0e1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RvOZkteLkSzdYQ3NHAcY3vIRZmlfpglNLUIYzeYL6ESIM6YwuVlptdUheo70?=
 =?us-ascii?Q?s6cCDX82BtOXKi0SnECw/p9Vc9ueutKSggoCg3LqwtuBd1y8CxZc/LlOoRPw?=
 =?us-ascii?Q?0d2Ab5KYQRmNQHSx8b9ff/LPcDfyZWzdpY4KMwz37OgaSVOjzpHsdec3gGd6?=
 =?us-ascii?Q?nzGEa7gCOPpwyweWVmn67IVerscTdlQlTJpptOauSctK7tNlfKonS3L/inXC?=
 =?us-ascii?Q?1CvrTBu8f09CYVlguUgqy7znom72TjPdI68bf/JiiiGGCLdZmRCnbaMowmiT?=
 =?us-ascii?Q?bWsECHRBe3ciJJkWn/tbFb6RgF5RryT3xPTOA2XasEKZSAA3vi4ly0XmtTYH?=
 =?us-ascii?Q?QHNO5WvYp2pgh9RULHd0jxhd3HjelxuIGpxSd0sfWdv9LfqslQVAXCHuOonY?=
 =?us-ascii?Q?Qs2RRFmeEhB/TppUenfgx+9jpbi/rgCbapwg6IFkB6+FDxptJ2f8Ol7QdjF0?=
 =?us-ascii?Q?Bh8zlTqjMKrKtIcpVh/fE4cKxVI7ZnIC5Fn681q1dSstyt4WfEJX3t41Ka3v?=
 =?us-ascii?Q?3K9RJVqRsaksQn50eY9ypW1yzAV6pcBfVBjq7EeyCYRh6jcUZDSLMCZ6zVQ0?=
 =?us-ascii?Q?pX0FhAK8HtRXmn2/hMbnXH8EDO3ZLBhoVi24WynCutDWLAlrWnf1TZiY46Dq?=
 =?us-ascii?Q?D8nVShU29NaSLJ9c0qLbFq3kHJ1qjjefwfpJlkzv6+GyhHXce//hF7zTPHf0?=
 =?us-ascii?Q?kHyyvdphhPnI1QNABQQMfPVvmsFODBcdxoAsXyfDGJ+P21jywwZO1ulCAx1x?=
 =?us-ascii?Q?6j9dtfBzZbB1wsUOM1DFvXPCGNtZ+K+zHSXoJIUl0pXSlXrIybWPyP4dPABj?=
 =?us-ascii?Q?SRSdyxNVqI+PWsJud1dVqeKxWqfMCzc3obdXctIIB3gRgURW90J+v6Cg5Klm?=
 =?us-ascii?Q?B2gNUEUMPsNYUQrLjwtD7UBfmOZNZ8YMTjas+Xgw1RuNyz7AzBabv/G2KImF?=
 =?us-ascii?Q?xB0Fqdb+clt0lmWAkRlWOQCH+6tcia4rLndigsmB4M7OitmFEjG4ZO0uQsYW?=
 =?us-ascii?Q?OxpN9Z3NCCH/i10J7pHwOwHnBh6DJnVCHi/hirjhxejXsSJ8J4vIuMiUrPj7?=
 =?us-ascii?Q?c4RETQVvgeQBsUKfCZEgTizLUv1XDodrsopR7Y0ExdR61c/qziGBvSiHKf5R?=
 =?us-ascii?Q?SuOGvSJMo7HQpJoLEZqOLwZRHkfrlopX9rB0Q8x+VffYEiwx6Oko4XPHucBR?=
 =?us-ascii?Q?SXyuDkq6o9fuabPbGEu7T61K0JXXcDE1LHXl5YfurG7E+xwna5dalPqVomG+?=
 =?us-ascii?Q?QRYAHh6vwbF2Os117PJoPK2+qMdLmemb2iyrrBAE5QhCI8Hnegnpfd8ZzONA?=
 =?us-ascii?Q?6SIxX9P+T3BCqzyuzGMwoAu2IiSWYGO0rkz+87Mbcov/9As8koUskFtFy2NL?=
 =?us-ascii?Q?QAmZIa+VCaMiEzT8vB7tuUdcO4XY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WcwYR0jUqtUbfeeJ5va12J33U7TXT9LM8jos7uB/WMuzWSFBSe/PBe6H21vJ?=
 =?us-ascii?Q?MT30ihU/jzeyCLV61ROK2EYx0KqEVajDip57q8sVZ/JTX1QFDC+VD1+05ZqH?=
 =?us-ascii?Q?Mcuc1LM4XIacEFscdCwz3vVRmTTKkoiQJM0keEPB0Rrab1KJucRTWfzGVMlp?=
 =?us-ascii?Q?O4jx8ITu8m3HZjHseKh8aV+V7BEf3nQ1HrX35zNl49+LaUJANYvdVuwTCsev?=
 =?us-ascii?Q?ROuORMv2gj0rolWXs0P2qUeo6wdwtYoqLhKI6AYgQo7rj6/EOScIHTpOsPrH?=
 =?us-ascii?Q?a3a0mXStAZYwZ/2bRYwyIpi8GEjVtnrYRv2nMOJiYsUugBR9ctlWsFNyDTOL?=
 =?us-ascii?Q?LLx6sXQuwNlqafPED8TSr4+L0IZHKH3x0RDZ9rQHcTtivrCLgodCjBy+9scP?=
 =?us-ascii?Q?fKRsDChbo4FxoJiKFp+jLL/kCsGAF1lrBxXIyocfuO0X1YSunonSuhzyT20u?=
 =?us-ascii?Q?F+hI3WuGQIAaXdgvP0B187H1s8nEFfbH/Oav6axXmx1HEOktvnnN/EEdrWDk?=
 =?us-ascii?Q?RD+k9JShpFJ9XhPTGt7qpIZPWrZyC4AtJKxS7yAEz6eJ9wxVvFpu8u6OOmUM?=
 =?us-ascii?Q?vnh2Yde9FZ+8lTtT1lEbOshxAj1kTuztk4JJ5n2O4ejB0OT5pqvy6siaKR37?=
 =?us-ascii?Q?ZJ4aKbLjhLYKy4MBCPu6aUlp+bSJivUWn1HZ3vz3KTZJSlIngkLIavNQ1aY/?=
 =?us-ascii?Q?dtfVnzlL+hyY3AVAAZy8mwRggT8n9CDGfQrdqGjqWcOzqktf+bbkWYGP1RR7?=
 =?us-ascii?Q?LM6owpmB6tkIrJA/eixJaGTw9cuK+/Lief93vgQq3r0THISbEGDpgDPqpleW?=
 =?us-ascii?Q?0DDxc4S9CZ2uGibedY/iuKdBujHkDOhyMSiNUCEr5jPk6fb2SFEFg03r6sB/?=
 =?us-ascii?Q?/Y4qRKddJPsWoB6kqtQnpIqn0SyYeW+oE9Ly4Kon6v+64iBeRJ+/oZ4DuFCY?=
 =?us-ascii?Q?vOpMjfHhvnu3mIbsuEzg4YnQ7L1d7bwO1B3NNGZNJ/X//8rmShKWVF4hpGt9?=
 =?us-ascii?Q?NA+9I5yTd67Uog0NncSE9g0MtAtVT1cw8Xnqrkf7Afm2iJDABmPajvhch6Cb?=
 =?us-ascii?Q?2CWxL5U+zYTySXTFTZOVqxbVChJIG9glRhtrzVEO79RT/As55lDOVGMkivDh?=
 =?us-ascii?Q?kmsrz9Li4dnbi2GGDnl+l+d/iqwUJjwSJFqIVH/KAfnE5I64x0pPbhGQF5To?=
 =?us-ascii?Q?c5GA4KNGuV+9qZTw/zN1/BZIbK0lhogF0avedVBMjvBRhmEnw8Opmvew+e0R?=
 =?us-ascii?Q?Md/Pyg1RCVv6N+oNe0RiSBEfMOexcJWZ9Tu/dmSQA50L/B8y8NC+iv0yw/V3?=
 =?us-ascii?Q?q5NMKFWQ4fzBrA0B1UQ/OSMlKF1IEHLqsWG3bCDbQ1buijEUtGYRGr8smZUP?=
 =?us-ascii?Q?tm9VwvghleI9dYVwOy1BMa8iqbx+LkVG/C9lg4RmhevSZu0zTpw33M5KJvEh?=
 =?us-ascii?Q?B+ajvmkWiQ0EUcp865ZakkzpQfdP9fK+IQxouyw2kGv8eHhJFjoXRXoUb0VO?=
 =?us-ascii?Q?ADSqsgT2jw7UNz7xHUeeuTCStfiDEGvJxdrP50U9sh2VAiMjLrz6BvcZUznz?=
 =?us-ascii?Q?NIOXNT1dXknLA4hibYowuUzxivuBW7C7P3X7DMmy2NpWUP9M9V9wo68YvzBF?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e37ef6-0700-4ee4-9dab-08dda7fb0e1b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 08:44:47.3486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7W/J51ait55VNt3E4VQ1etsPQW8o4PtBBTQPPTdliy89KZ+QUeHw7zNbdIvLejty/ihWd/kzTEWSdz2q3XX9Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8387
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KASAN:use-after-free_in_wiphy_free" on:

commit: d99fe2735afd3ea67b732b98ab4b2d47408d4f0f ("[PATCH wireless-next v14 2/4] wifi: cfg80211: Add Support to Set RTS Threshold for each Radio")
url: https://github.com/intel-lab-lkp/linux/commits/Roopni-Devanathan/wifi-cfg80211-mac80211-Add-support-to-get-radio-index/20250605-191329
patch link: https://lore.kernel.org/all/20250605111040.3451328-3-quic_rdevanat@quicinc.com/
patch subject: [PATCH wireless-next v14 2/4] wifi: cfg80211: Add Support to Set RTS Threshold for each Radio

in testcase: hwsim
version: hwsim-x86_64-b01c4843b-1_20250601
with following parameters:

	test: group-30



config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4790 v3 @ 3.60GHz (Haswell) with 6G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202506101652.625ca3c4-lkp@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250610/202506101652.625ca3c4-lkp@intel.com


[  277.261476][ T7020] ==================================================================
[  277.263650][  T332] beacon_int=100
[  277.265556][ T7020] BUG: KASAN: use-after-free in wiphy_free+0x45/0x50 [cfg80211]
[  277.273470][  T332] 
[  277.276843][ T7020] Read of size 8 at addr ffff888192fe0530 by task python3/7020
[  277.276847][ T7020] 
[  277.276860][ T7020] CPU: 7 UID: 0 PID: 7020 Comm: python3 Tainted: G S                  6.15.0-rc7-01660-gd99fe2735afd #1 PREEMPT(voluntary) 
[  277.276865][ T7020] Tainted: [S]=CPU_OUT_OF_SPEC
[  277.276866][ T7020] Hardware name: Dell Inc. OptiPlex 9020/03CPWF, BIOS A11 04/01/2015
[  277.276868][ T7020] Call Trace:
[  277.276880][ T7020]  <TASK>
[  277.276882][ T7020]  dump_stack_lvl+0x4f/0x70
[  277.276889][ T7020]  print_address_description+0x2c/0x3b0
[  277.276894][ T7020]  ? wiphy_free+0x45/0x50 [cfg80211]
[  277.276971][ T7020]  print_report+0xb9/0x280
[  277.276974][ T7020]  ? kasan_addr_to_slab+0x9/0x90
[  277.276978][ T7020]  ? wiphy_free+0x45/0x50 [cfg80211]
[  277.277058][ T7020]  kasan_report+0xb4/0xe0
[  277.277061][ T7020]  ? wiphy_free+0x45/0x50 [cfg80211]
[  277.277132][ T7020]  wiphy_free+0x45/0x50 [cfg80211]
[  277.277212][ T7020]  hwsim_del_radio_nl+0x53f/0x820 [mac80211_hwsim]
[  277.277222][ T7020]  genl_family_rcv_msg_doit+0x1d4/0x2b0
[  277.277227][ T7020]  ? __pfx_genl_family_rcv_msg_doit+0x10/0x10
[  277.277232][ T7020]  ? security_capable+0xab/0xc0
[  277.277236][ T7020]  genl_family_rcv_msg+0x337/0x520
[  277.277240][ T7020]  ? __pfx_genl_family_rcv_msg+0x10/0x10
[  277.277243][ T7020]  ? __pfx_hwsim_del_radio_nl+0x10/0x10 [mac80211_hwsim]
[  277.277250][ T7020]  ? __pfx_mutex_lock+0x10/0x10
[  277.277254][ T7020]  ? __pfx_stack_trace_save+0x10/0x10
[  277.277257][ T7020]  ? stack_depot_save_flags+0x3d/0x610
[  277.277262][ T7020]  genl_rcv_msg+0x9f/0x130
[  277.277265][ T7020]  netlink_rcv_skb+0x122/0x380
[  277.277268][ T7020]  ? __pfx_genl_rcv_msg+0x10/0x10
[  277.277271][ T7020]  ? __pfx_netlink_rcv_skb+0x10/0x10
[  277.277274][ T7020]  ? __pfx_netlink_lookup+0x10/0x10
[  277.277277][ T7020]  ? _copy_from_iter+0x271/0x16b0
[  277.277281][ T7020]  genl_rcv+0x24/0x40
[  277.277284][ T7020]  netlink_unicast+0x687/0x9c0
[  277.277287][ T7020]  ? __pfx_netlink_unicast+0x10/0x10
[  277.277290][ T7020]  ? 0xffffffff81000000
[  277.277292][ T7020]  ? __check_object_size+0x75/0x1d0
[  277.277296][ T7020]  netlink_sendmsg+0x745/0xbf0
[  277.277299][ T7020]  ? __pfx_netlink_sendmsg+0x10/0x10
[  277.277302][ T7020]  ? fdget+0x54/0x3b0
[  277.277306][ T7020]  ? file_update_time+0x110/0x160
[  277.277309][ T7020]  __sys_sendto+0x399/0x410
[  277.277312][ T7020]  ? __pfx___sys_sendto+0x10/0x10
[  277.277315][ T7020]  ? __pfx_vfs_write+0x10/0x10
[  277.277318][ T7020]  ? __pfx_current_time+0x10/0x10
[  277.277321][ T7020]  ? fdget_pos+0x1cb/0x4b0
[  277.277324][ T7020]  ? inode_needs_update_time+0x15c/0x1e0
[  277.277327][ T7020]  __x64_sys_sendto+0xdc/0x1b0
[  277.277329][ T7020]  ? vfs_write+0x76d/0xc40
[  277.277331][ T7020]  ? vfs_write+0x76d/0xc40
[  277.277333][ T7020]  do_syscall_64+0x79/0x160
[  277.277347][ T7020]  ? syscall_exit_to_user_mode+0xc/0x1e0
[  277.277350][ T7020]  ? do_syscall_64+0x85/0x160
[  277.277353][ T7020]  ? put_timespec64+0xa8/0x100
[  277.277356][ T7020]  ? fdget_pos+0x54/0x4b0
[  277.277369][ T7020]  ? ksys_write+0x17c/0x1c0
[  277.277371][ T7020]  ? __pfx_ksys_write+0x10/0x10
[  277.277374][ T7020]  ? do_syscall_64+0x85/0x160
[  277.277377][ T7020]  ? syscall_exit_to_user_mode+0xc/0x1e0
[  277.277379][ T7020]  ? do_syscall_64+0x85/0x160
[  277.277382][ T7020]  ? __asan_memset+0x1f/0x40
[  277.277386][ T7020]  ? rseq_ip_fixup+0x2a3/0x410
[  277.277390][ T7020]  ? __pfx_rseq_ip_fixup+0x10/0x10
[  277.277393][ T7020]  ? __pfx_mem_cgroup_handle_over_high+0x10/0x10
[  277.277397][ T7020]  ? __pfx___x64_sys_pselect6+0x10/0x10
[  277.277400][ T7020]  ? fpregs_restore_userregs+0xe3/0x1f0
[  277.277404][ T7020]  ? syscall_exit_to_user_mode+0x1c1/0x1e0
[  277.277406][ T7020]  ? do_syscall_64+0x85/0x160
[  277.277409][ T7020]  ? do_syscall_64+0x85/0x160
[  277.277411][ T7020]  ? syscall_exit_to_user_mode+0xc/0x1e0
[  277.277414][ T7020]  ? do_syscall_64+0x85/0x160
[  277.277416][ T7020]  ? syscall_exit_to_user_mode+0xc/0x1e0
[  277.277419][ T7020]  ? do_syscall_64+0x85/0x160
[  277.277421][ T7020]  ? do_syscall_64+0x85/0x160
[  277.277423][ T7020]  ? exc_page_fault+0x57/0xc0
[  277.277426][ T7020]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  277.277430][ T7020] RIP: 0033:0x7f6527464b09
[  277.277432][ T7020] Code: ff 64 89 02 eb bd 66 2e 0f 1f 84 00 00 00 00 00 90 80 3d e1 fa 0c 00 00 41 89 ca 74 1c 45 31 c9 45 31 c0 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 67 c3 66 0f 1f 44 00 00 55 48 83 ec 20 48 89
[  277.277435][ T7020] RSP: 002b:00007ffd0dd36fa8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[  277.277438][ T7020] RAX: ffffffffffffffda RBX: 00007ffd0dd37050 RCX: 00007f6527464b09
[  277.277440][ T7020] RDX: 000000000000001c RSI: 00007f65241197d0 RDI: 0000000000000013
[  277.277441][ T7020] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  277.277443][ T7020] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  277.277444][ T7020] R13: ffffffffc4653600 R14: 0000000000000000 R15: 0000000000000000
[  277.277447][ T7020]  </TASK>
[  277.277448][ T7020] 
[  277.284535][  T332] dtim_period=2
[  277.286491][ T7020] The buggy address belongs to the physical page:
[  277.286492][ T7020] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888192fe4000 pfn:0x192fe0
[  277.286495][ T7020] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  277.286510][ T7020] raw: 0017ffffc0000000 ffffea0004bcfc08 ffff8881341c6f70 0000000000000000
[  277.293892][  T332] 
[  277.296053][ T7020] raw: ffff888192fe4000 0000000000000000 00000000ffffffff 0000000000000000
[  277.296054][ T7020] page dumped because: kasan: bad access detected
[  277.296055][ T7020] 
[  277.296056][ T7020] Memory state around the buggy address:
[  277.296058][ T7020]  ffff888192fe0400: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  277.309044][  T332] eht_oper_chwidth=0
[  277.313290][ T7020]  ffff888192fe0480: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  277.313292][ T7020] >ffff888192fe0500: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  277.313294][ T7020]                                      ^
[  277.313295][ T7020]  ffff888192fe0580: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  277.313296][ T7020]  ffff888192fe0600: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  277.313308][ T7020] ==================================================================
[  277.321213][  T332] 
[  277.324328][ T7020] Disabling lock debugging due to kernel taint

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


