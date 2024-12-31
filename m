Return-Path: <linux-wireless+bounces-16928-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771DA9FECE1
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 05:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD1E1620AF
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 04:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27F3156C7B;
	Tue, 31 Dec 2024 04:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XmBQ6il6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038D43234;
	Tue, 31 Dec 2024 04:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735621169; cv=fail; b=FZ9Jul6OaAaV13zkmVvbuOZmG28dAfR204ZeLa7pxuyPOXkF1hQxCMf2+buBpa+JAu06LZyG+OhdqOifo7LVmor57jcgznCF3LF/q/J/cr96Vjd2uExkAHdSgQ7JzrKO4rSSxWyoJyurkq2lH5G/H69SAuX4VmDAEXLViFc4BBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735621169; c=relaxed/simple;
	bh=8X8kTK4+KRyUyaTikTQNu7al6tlsySZtJl06vlUqtlI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Oy9QgMu9pknI302HXJUkZR4yRQdWf7kfmPzF2c3cv7rSza+9Ho4Gbnj/6xvE5OEVwgTuvfAUg0mzRw3cFXdqRdmb+h956WQ/lX3C1Bx73xrP4rKgXDXWTgeXcW7Mpx+Ln48tIyX1fydSR2gqh8zlfbBn3cxSvNRIwWbJEIzJ2Iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XmBQ6il6; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735621167; x=1767157167;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=8X8kTK4+KRyUyaTikTQNu7al6tlsySZtJl06vlUqtlI=;
  b=XmBQ6il6wrSP1cJAF3fjkh+z+D5F4Wyfx669318r1S+JgOBI2gdMoOjx
   2a2LdgWTP/NCQDPTBM6aF5q7/+5RqzOjw9tGLZ54OOg1Uma6Q9RU1ZFVf
   T+gb22ayvtQL9kHC61eyeHiJ5sZxBoMhS58u1CCJAYeKM1PvelZx3BWj2
   nKraFeg/OQnGqlJPIVfV4Ixl5ZSGf4wqxWx9yDd5ipUNpb4/6a8aRJrCF
   x4/PNRUqjG4wA1QnwaT255JyisQVbFQR2Jl0nI58Y45HfXh4s4wb5b12A
   6D88xYfB4Rw5qA+Hb95FzOIcnngxlqigsa+aaXmQRKY8Ep4CMWEEvrL77
   g==;
X-CSE-ConnectionGUID: djtEzbKfTs6as9PdyRLpUg==
X-CSE-MsgGUID: h9dWqsI/SemmznA/F+4Ung==
X-IronPort-AV: E=McAfee;i="6700,10204,11301"; a="46395946"
X-IronPort-AV: E=Sophos;i="6.12,278,1728975600"; 
   d="scan'208";a="46395946"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2024 20:59:26 -0800
X-CSE-ConnectionGUID: u7zBJ4qITA2yHCN9AjwQJg==
X-CSE-MsgGUID: 0Bav5vfaQt6Txe1v//tnIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,278,1728975600"; 
   d="scan'208";a="101376073"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Dec 2024 20:59:26 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 30 Dec 2024 20:59:25 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 30 Dec 2024 20:59:25 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 30 Dec 2024 20:59:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQjqKbL+MPKFc6kMucmt+SKkaYGRIE7b8OMKyhdXH4RNSxAEcjQGm2o26T/lYdbbLYniSBFETK1Eh3hmtrGArCXswKqs8sWzsR+R7uAhwsa+yEpOk8a1r5kLSmCadG2zdjvtKrJc/VclGD5o3rzKW1kfq6K78KCK5TSbd3gxYDN/AUBdtbz4XYmCSLqkIdBp8n7DulbcXSrMecPo1cOPMQEY8wjU3g7t+Xi5PG1KX0R2aW+/U1tENp1mO4MNP7GHDj1t5moL1mDjWHEPfjs9QQSjPZdidzRyuSXQlhmfQ8bCZTPvfv1eeDDu1Fku/ExdKjNLifIrbobCXuz3Ain50w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHGq8Db+fPJ+ta3jfRC5/+tmvAP7PjsayyPvV2qpsbo=;
 b=yOTnqGFjFTTwWfVFtJz5gGps0gjqlPN5NvIVqzagSpKbwj6+b8Mj56Z2J/KzdCYVT5mmCDD82YpZWjWkfHG/1H/fNmrT8X4SMu6T9VVEXR18hdfLJIq6K4c4K7T2wODyU3FMWPUjp+JtD18ADzOuiwAuKKQHE26sIvK3k1uYzCI5QGEU1ZrTscVx9KATeAf6QBfp2EbKWOfbJFuku8ZP4UT9hGNfFgUEpAyf5hboIWTKN3bzSLFAnCE2oq5CO77UlCIeJMWNII/jdLpnLaJ6AqFB+0zssSlx2rOVCmsEFqzGrfzni9kxJSYdLg4lKxAAXfLnbbljOjSm+ZLn8+a5FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CO1PR11MB5124.namprd11.prod.outlook.com (2603:10b6:303:92::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.16; Tue, 31 Dec
 2024 04:59:18 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8293.000; Tue, 31 Dec 2024
 04:59:18 +0000
Date: Tue, 31 Dec 2024 12:59:08 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-wireless@vger.kernel.org>, Johannes Berg <johannes.berg@intel.com>,
	Kees Cook <kees@kernel.org>, "Gustavo A . R . Silva" <gustavoars@kernel.org>,
	<linux-hardening@vger.kernel.org>, Dmitry Antipov <dmantipov@yandex.ru>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH 2/2] wifi: cfg80211: simplify
 cfg80211_mlme_register_mgmt()
Message-ID: <202412311225.52d0fafe-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241210143951.5685-2-dmantipov@yandex.ru>
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CO1PR11MB5124:EE_
X-MS-Office365-Filtering-Correlation-Id: bb1c6fa8-a5b9-4721-4839-08dd2957e1e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o9y9NAPFESJr0e+RTq0jlDKj2OQVGGB4EeXNY2ZM8eITNK3b9yYqUkIT3NyM?=
 =?us-ascii?Q?rJPwewuasoR9eOAOev6DJyjUtF4HpGKpioL7lm8ey4BzUMrHHQ64XA8Vhamz?=
 =?us-ascii?Q?+FUPrQoWjbUGkdBi86ml+G3NVSak5a24ztAgJX3lN36LY1uwiKRrqPtz/sM8?=
 =?us-ascii?Q?eiEv2M8PVByahSNhro6p0kP9UFtFtYE7vyDuEi9JPn5MFTd3cPhGjgw5Y01r?=
 =?us-ascii?Q?V+F0MhE5xslnSIgN63Ibm0g5sIzhDtLD3FS3gvODcsE5tqcHzcAvEMx3M1zu?=
 =?us-ascii?Q?tMNxwyg+EU0sT5AJhvDqa0z0/9GGHEc2wAGLbrGOUvR3Yq3124NliW+mbDLp?=
 =?us-ascii?Q?o4CK35gp5y7U8A5SmCNZ3KswhSY73RTBZWIHMdtwIyXk+IB/uZkY4CmmlL5y?=
 =?us-ascii?Q?2sJM+vT9jlTGxOPpBT0RA2Ct+BWrfNi2x5siTNqENnq0KyCYo08LNBZzUXRe?=
 =?us-ascii?Q?6dlx68GhNeHpKB7/I99UDIqc66i02HilpOlctMqgSwT7cL27QJb6jtqHDtFw?=
 =?us-ascii?Q?jHe7XS6ccJ9MFkqm3t6MuIJ7EittsrbN2HlkRv02vZ4CgGnx3GWkTMx4Wt/N?=
 =?us-ascii?Q?ZjAohZoLDG71lrmlO3xDvwujZwmwTeon1ByJqhanOTBZX0W2/mUNVC/58o4N?=
 =?us-ascii?Q?ANtZAXS2p/YSxm2VEYKV+LXeksLZ+6XVWh3PqOg1C+vdeVi1ox3Ir+Dj5jqi?=
 =?us-ascii?Q?zNFxFaczMxODH3KZhOKHskX+kONySTTv0BVU8Dm47MfXWoBlIog+BYJaMggm?=
 =?us-ascii?Q?0+mKG5tnsGyUseW2ZMP6P89jNOIzMPY3jt3IgNVyDmYxip6UlO0Qv0+s0UEX?=
 =?us-ascii?Q?D8yO6EL3yhkRYtjlWcyZRYZOZj746tgTNiGz1dqCXa+ZIQ2FpAfdnk6YbSsN?=
 =?us-ascii?Q?5ngGE9VX6qRnSYwbcAqnmtHqcYmAB3bU9RU1oUyTvEJW9WbXQ4rgNsYC4Ka/?=
 =?us-ascii?Q?vBQMQ3Zh6QeZ502BsIZmZidH8FTggNnNRQi6HKrQf5cDYksgCKuPjjRN3tTM?=
 =?us-ascii?Q?iMfrpTI5EBBVyEjjAWLSvZJj9GUuxj4oL/bg1YF8rRlXQvsg/4Q8AjuXd6EP?=
 =?us-ascii?Q?dgRKHbye3oFCXDLGoPC0U8vJTqKPOh9W7fn/AyCCzOfJJw1jtwgxGyxvk6hI?=
 =?us-ascii?Q?vzp1txMBxZP6OwOhKfywMf6tXX6JCa0BVNakHDFcwWRYqX4JJUmkBveLXs8s?=
 =?us-ascii?Q?bGuEAAhamglQRTdzEv6lBx8QruEr3lJ4TMltDyYMpSmvQJ44OytTdSai8Tsk?=
 =?us-ascii?Q?shXkT6b8X8U+i7g/u3uwzIcdH8u/A8npHNArmO5dYAQ59ovLMTMc/R7InQ2L?=
 =?us-ascii?Q?4n2RrKfVv8Mya/MFs7qmA9GWDM3xJOs5jDAPHaUI8XDd2g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LSnt0HsIibzYoWc4+6/R1ry2aEreVBU9nn6TS1r11WHF12N5XJzKwvtM9+qX?=
 =?us-ascii?Q?NNMz4DLcZIINC85X9IWlZi0CyZASl5JPXOf+ZddDkFhFU5rI5RSVeo+SXayM?=
 =?us-ascii?Q?vvq3pyw8mxH+XfzKkfTXVTHssyNyWVK2c0T2y+vX19bKY/6ppWwpFmpgO4t/?=
 =?us-ascii?Q?T3mH5evqNGY8tYj+TTGWS43ZNoRDxRLPmzKkYb/5ayzlh/OBiuI1Vj+jCjOp?=
 =?us-ascii?Q?yqPA/jdqJMtS8DOTsrTN0NDlZDAwOxjyedOv/+TOqC5XoHQ//PCLGDUJwOjv?=
 =?us-ascii?Q?fJu9FXC+NgTXDlLhJ3kG0YuP2AppBns3NxtoloyHlcz2BiNQrh/vqyIZeNmF?=
 =?us-ascii?Q?XjnGYx2kPEmd0LB3i6LczFkGU09ia/OItePEqM7wZ0pnGRAv7NPTE6abHW0H?=
 =?us-ascii?Q?vLx1OzbzNWq9hA8+rIwTmiXSYeR7Wtjj5Fb7WSCyIusJhYuygwl5kgPEA1j2?=
 =?us-ascii?Q?wcDKpnpta2TZvicGDijqJV9TDPygKkoCzaMyUyo6EftZ2SKAJq8Dd4MqLUB6?=
 =?us-ascii?Q?biVJIUJiKLXKZGB8cND6KdrX6qatCr/EgBN+lqk7dn45+GbAOFcix0zrLLHO?=
 =?us-ascii?Q?0ozpMFv/E81dVbylqJgXkR51oxUMMnIveohaVg1QGvpxe3VsNAuThSYO19qp?=
 =?us-ascii?Q?+KrGs5QyWz6/AZm1NEHsA8XZD70tH/K+QKYimmN4UOdN/3ic+VFciJ3HCb5W?=
 =?us-ascii?Q?CW5foZNpxnQejp/pb6ZcwlsKHUxPUuQu/DoWf4RqtRBcA7edsrundCnhjrRT?=
 =?us-ascii?Q?DingjLZ3//KcqGbldgMQy+z9LWMIcqvMZ67JSEw6UYlEnguUjwhVOhJOBDhM?=
 =?us-ascii?Q?QOnimd/8EEHxGb7Mlj9i/rPjbxpTfGoBrNIiUAZWJvrcdmatE+K3DP59mDAR?=
 =?us-ascii?Q?P49AxaO8fBYwD+hBW3ml0l9FTLNMrid2mEqAs1AeERtrvoqaEJN9kNa2WqiA?=
 =?us-ascii?Q?j4kg1fuLhE3mpodFxwHC0/MsYYhzbELPahFwcem/0/Fr/WnJUVs6ta+1XNNs?=
 =?us-ascii?Q?NdskzIOYd953cNWYvCphvKBdy8twbOdrgihMv8P9LdZbECRKD4nI1FFpW8/b?=
 =?us-ascii?Q?FDR9d//EooPBESlgESbwkZ3ipYX/uIpyCknPtK44i71ckOo76HsS9H1otdQm?=
 =?us-ascii?Q?mY/8/ZpKANHnwtCMfak0zIrEAUWYcv3+MRFrJioem7aVS2Cr5324KlIWauso?=
 =?us-ascii?Q?BpdtWyfYjAIChAGpdhC7OG7f7iDnYl/dwnW48HbEgN0DMwEVIxB8bJIhXSE5?=
 =?us-ascii?Q?A9lFftpsyaFJQDEl14uvuLe0EP+xJRyXXVfLZq2xV6+MZuKxHzjLj6AtA6up?=
 =?us-ascii?Q?urhJec10XcqTDC1qQDtVQmfo0qwS+HPQoVIpnAhFefIhxO0SF+35CZbHuL2C?=
 =?us-ascii?Q?G9PuEW4eo9VDRTLNR+j/fBuG/vPmCKH3Yu3qAhepncwTd+2CBv0z3tkP33Sw?=
 =?us-ascii?Q?VcX0KFsrL76HHX+yEu9JU9CBVHWI+rwfQxu4HwJcKY0OXlgKZ+cxCSCBiZ7m?=
 =?us-ascii?Q?lT+o42PPYxI5Np+rDli9gGCe3KdOmDXxAmUyAIm1xlQRQAaeJTf1BLKoBRyY?=
 =?us-ascii?Q?4e9ttl2CWWNg9Ht4N60hvyvyCDTY4z4e+P4e/pDA13tKfCdEj0csu/hLr8dg?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb1c6fa8-a5b9-4721-4839-08dd2957e1e8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2024 04:59:18.8429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AEzCkCeEmHQpaRJiYF38vJ/INnAzxF0lUqD+TSBDWEYaQqyaurrs2AoVs6ysmlSNgKFAqDaZdHJj2ikZm3DF3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5124
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_include/linux/sched/mm.h" on:

commit: f3ec4051049a8cc013993b615303b283770c6482 ("[PATCH 2/2] wifi: cfg80211: simplify cfg80211_mlme_register_mgmt()")
url: https://github.com/intel-lab-lkp/linux/commits/Dmitry-Antipov/wifi-cfg80211-simplify-cfg80211_mlme_register_mgmt/20241210-225049
base: https://git.kernel.org/cgit/linux/kernel/git/wireless/wireless-next.git main
patch link: https://lore.kernel.org/all/20241210143951.5685-2-dmantipov@yandex.ru/
patch subject: [PATCH 2/2] wifi: cfg80211: simplify cfg80211_mlme_register_mgmt()

in testcase: hwsim
version: hwsim-x86_64-4ea2c336d-1_20241103
with following parameters:

	test: group-24



config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4790 v3 @ 3.60GHz (Haswell) with 6G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202412311225.52d0fafe-lkp@intel.com


[   86.645507][ T5533] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:321
[   86.653092][ T5537] ieee80211 phy1: mac80211_hwsim_start
[   86.654820][ T5533] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5533, name: wpa_supplicant
[   86.660121][ T5537] ieee80211 phy1: mac80211_hwsim_add_interface (type=2 mac_addr=02:00:00:00:01:00)
[   86.660169][ T5537] ieee80211 phy1: mac80211_hwsim_link_info_changed(changed=0xe vif->addr=02:00:00:00:01:00, link id 0)
[   86.669338][ T5533] preempt_count: 201, expected: 0
[   86.669350][ T5533] RCU nest depth: 0, expected: 0
[   86.669353][ T5533] CPU: 5 UID: 0 PID: 5533 Comm: wpa_supplicant Tainted: G S                 6.13.0-rc1-00077-gf3ec4051049a #1
[   86.678470][ T5537] ieee80211 phy1:   ERP_CTS_PROT: 0
[   86.689309][ T5533] Tainted: [S]=CPU_OUT_OF_SPEC
[   86.689311][ T5533] Hardware name: Dell Inc. OptiPlex 9020/03CPWF, BIOS A11 04/01/2015
[   86.689312][ T5533] Call Trace:
[   86.689314][ T5533]  <TASK>
[ 86.689326][ T5533] dump_stack_lvl (lib/dump_stack.c:123 (discriminator 1))
[   86.694193][ T5537] ieee80211 phy1:   ERP_PREAMBLE: 0
[ 86.698967][ T5533] __might_resched (kernel/sched/core.c:8759)
[ 86.698984][ T5533] __kmalloc_noprof (include/linux/kernel.h:73 include/linux/sched/mm.h:321 include/linux/sched/mm.h:316 mm/slub.c:4055 mm/slub.c:4133 mm/slub.c:4282 mm/slub.c:4295)
[   86.710436][ T5537] ieee80211 phy1:   ERP_SLOT: 0
[ 86.715468][ T5533] ? __pfx__raw_spin_lock_bh (kernel/locking/spinlock.c:177)
[ 86.715473][ T5533] ? cfg80211_mlme_register_mgmt (include/linux/slab.h:905 net/wireless/mlme.c:708) cfg80211
[   86.720106][ T5537] ieee80211 phy1: mac80211_hwsim_conf_tx (queue=0 txop=0 cw_min=15 cw_max=1023 aifs=2)
[ 86.727993][ T5533] ? cfg80211_mlme_register_mgmt (include/linux/slab.h:905 net/wireless/mlme.c:708) cfg80211
[   86.731138][ T5537] ieee80211 phy1: mac80211_hwsim_conf_tx (queue=1 txop=0 cw_min=15 cw_max=1023 aifs=2)
[ 86.733922][ T5533] cfg80211_mlme_register_mgmt (include/linux/slab.h:905 net/wireless/mlme.c:708) cfg80211
[   86.738276][ T5537] ieee80211 phy1: mac80211_hwsim_conf_tx (queue=2 txop=0 cw_min=15 cw_max=1023 aifs=2)
[ 86.743313][ T5533] nl80211_register_mgmt (net/wireless/nl80211.c:12697) cfg80211
[   86.747938][ T5537] ieee80211 phy1: mac80211_hwsim_conf_tx (queue=3 txop=0 cw_min=15 cw_max=1023 aifs=2)
[ 86.752614][ T5533] ? nl80211_pre_doit (net/wireless/nl80211.c:16626) cfg80211
[   86.757317][ T5537] ieee80211 phy1: mac80211_hwsim_link_info_changed(changed=0x2000 vif->addr=02:00:00:00:01:00, link id 0)
[ 86.762609][ T5533] genl_family_rcv_msg_doit (net/netlink/genetlink.c:1117)
[   86.769392][ T5537] ieee80211 phy1: mac80211_hwsim_config (freq=2412(2412 - 0)/noht idle=1 ps=0 smps=static)
[ 86.778848][ T5533] ? __pfx_genl_family_rcv_msg_doit (net/netlink/genetlink.c:1088)
[   86.785649][   T11] ieee80211 phy1: mac80211_hwsim_configure_filter
[ 86.795082][ T5533] ? security_capable (security/security.c:1142)
[ 86.795090][ T5533] genl_family_rcv_msg (net/netlink/genetlink.c:1195)
[   86.801696][   T11] ieee80211 phy1: mac80211_hwsim_configure_filter
[ 86.811153][ T5533] ? __sys_sendmsg (net/socket.c:2654)
[ 86.811174][ T5533] ? __pfx_genl_family_rcv_msg (net/netlink/genetlink.c:1160)
[ 86.897075][ T5533] ? netlink_sendmsg (net/netlink/af_netlink.c:1866)
[ 86.901865][ T5533] ? ____sys_sendmsg (net/socket.c:711 net/socket.c:726 net/socket.c:2583)
[ 86.906664][ T5533] ? ___sys_sendmsg (net/socket.c:2639)
[ 86.911279][ T5533] ? __pfx_nl80211_pre_doit (net/wireless/nl80211.c:16536) cfg80211
[ 86.917589][ T5533] ? __pfx_nl80211_register_mgmt (net/wireless/nl80211.c:12655) cfg80211
[ 86.924312][ T5533] ? __pfx_nl80211_post_doit (net/wireless/nl80211.c:16638) cfg80211
[ 86.930688][ T5533] ? is_bpf_text_address (kernel/bpf/core.c:769)
[ 86.935653][ T5533] genl_rcv_msg (net/netlink/genetlink.c:65 net/netlink/genetlink.c:1211)
[ 86.939928][ T5533] netlink_rcv_skb (net/netlink/af_netlink.c:2542)
[ 86.944544][ T5533] ? __pfx_genl_rcv_msg (net/netlink/genetlink.c:1201)
[ 86.949418][ T5533] ? __pfx_netlink_rcv_skb (net/netlink/af_netlink.c:2519)
[ 86.954555][ T5533] ? __pfx_down_read (kernel/locking/rwsem.c:1522)
[ 86.959169][ T5533] ? __pfx_netlink_lookup (net/netlink/af_netlink.c:514)
[ 86.964214][ T5533] ? _copy_from_iter (arch/x86/include/asm/uaccess_64.h:126 arch/x86/include/asm/uaccess_64.h:141 lib/iov_iter.c:55 include/linux/iov_iter.h:30 include/linux/iov_iter.h:300 include/linux/iov_iter.h:328 lib/iov_iter.c:249 lib/iov_iter.c:260)
[ 86.969090][ T5533] genl_rcv (net/netlink/genetlink.c:1220)
[ 86.972925][ T5533] netlink_unicast (net/netlink/af_netlink.c:1322 net/netlink/af_netlink.c:1347)
[ 86.977540][ T5533] ? __pfx_netlink_unicast (net/netlink/af_netlink.c:1332)
[   86.982673][ T5533]  ? 0xffffffff81000000
[ 86.986678][ T5533] ? __check_object_size (mm/memremap.c:421)
[ 86.992336][ T5533] netlink_sendmsg (net/netlink/af_netlink.c:1891)
[ 86.996950][ T5533] ? __pfx_netlink_sendmsg (net/netlink/af_netlink.c:1810)
[ 87.002083][ T5533] ? __import_iovec (lib/iov_iter.c:1438 lib/iov_iter.c:1454)
[ 87.006782][ T5533] ? _inline_copy_from_user (arch/x86/include/asm/uaccess_64.h:134 arch/x86/include/asm/uaccess_64.h:134 arch/x86/include/asm/uaccess_64.h:141 include/linux/uaccess.h:178)
[ 87.012003][ T5533] ? __pfx_netlink_sendmsg (net/netlink/af_netlink.c:1810)
[ 87.017135][ T5533] ____sys_sendmsg (net/socket.c:711 net/socket.c:726 net/socket.c:2583)
[ 87.021749][ T5533] ? __pfx_____sys_sendmsg (net/socket.c:2529)
[ 87.026895][ T5533] ? __pfx_copy_msghdr_from_user (net/socket.c:2509)
[ 87.032559][ T5533] ? copy_from_sockptr_offset (include/linux/sockptr.h:51)
[ 87.039082][ T5533] ___sys_sendmsg (net/socket.c:2639)
[ 87.043523][ T5533] ? __pfx____sys_sendmsg (net/socket.c:2626)
[ 87.048571][ T5533] ? do_sock_setsockopt (net/socket.c:2282)
[ 87.053617][ T5533] ? do_sock_setsockopt (net/socket.c:2282)
[ 87.058664][ T5533] ? __pfx_do_sock_setsockopt (net/socket.c:2282)
[ 87.064055][ T5533] ? up_write (arch/x86/include/asm/atomic64_64.h:87 include/linux/atomic/atomic-arch-fallback.h:2852 include/linux/atomic/atomic-long.h:268 include/linux/atomic/atomic-instrumented.h:3391 kernel/locking/rwsem.c:1372 kernel/locking/rwsem.c:1630)
[ 87.068064][ T5533] ? fdget (include/linux/atomic/atomic-arch-fallback.h:479 include/linux/atomic/atomic-instrumented.h:50 fs/file.c:1145 fs/file.c:1159)
[ 87.071898][ T5533] ? fdget (include/linux/atomic/atomic-arch-fallback.h:479 include/linux/atomic/atomic-instrumented.h:50 fs/file.c:1145 fs/file.c:1159)
[ 87.075742][ T5533] __sys_sendmsg (net/socket.c:2669)
[ 87.080182][ T5533] ? __pfx___sys_sendmsg (net/socket.c:2654)
[ 87.085144][ T5533] ? ksys_write (fs/read_write.c:731)
[ 87.089412][ T5533] ? __pfx_ksys_write (fs/read_write.c:721)
[ 87.094112][ T5533] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
[ 87.098466][ T5533] ? syscall_exit_to_user_mode (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:92 include/linux/entry-common.h:232 kernel/entry/common.c:206 kernel/entry/common.c:218)
[ 87.103947][ T5533] ? do_syscall_64 (arch/x86/entry/common.c:102)
[ 87.108474][ T5533] ? __count_memcg_events (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2583 include/linux/atomic/atomic-instrumented.h:1611 mm/memcontrol.c:569 mm/memcontrol.c:594 mm/memcontrol.c:857)
[ 87.113694][ T5533] ? handle_mm_fault (mm/memory.c:5986 mm/memory.c:6138)
[ 87.118482][ T5533] ? do_user_addr_fault (include/linux/rcupdate.h:882 include/linux/mm.h:741 arch/x86/mm/fault.c:1340)
[ 87.123530][ T5533] ? exc_page_fault (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:92 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539)
[ 87.128058][ T5533] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[   87.133802][ T5533] RIP: 0033:0x7fdd421a8af0
[ 87.138067][ T5533] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 80 3d f1 fa 0c 00 00 74 17 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 89 54
All code
========
   0:	00 f7                	add    %dh,%bh
   2:	d8 64 89 02          	fsubs  0x2(%rcx,%rcx,4)
   6:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
   d:	eb b7                	jmp    0xffffffffffffffc6
   f:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  16:	00 00 00 
  19:	90                   	nop
  1a:	80 3d f1 fa 0c 00 00 	cmpb   $0x0,0xcfaf1(%rip)        # 0xcfb12
  21:	74 17                	je     0x3a
  23:	b8 2e 00 00 00       	mov    $0x2e,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 58                	ja     0x8a
  32:	c3                   	ret
  33:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  3a:	48 83 ec 28          	sub    $0x28,%rsp
  3e:	89                   	.byte 0x89
  3f:	54                   	push   %rsp

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 58                	ja     0x60
   8:	c3                   	ret
   9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  10:	48 83 ec 28          	sub    $0x28,%rsp
  14:	89                   	.byte 0x89
  15:	54                   	push   %rsp


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241231/202412311225.52d0fafe-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


