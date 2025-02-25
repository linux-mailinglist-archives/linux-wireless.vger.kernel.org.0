Return-Path: <linux-wireless+bounces-19388-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF23A4327A
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 02:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5A9176468
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 01:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5021C11712;
	Tue, 25 Feb 2025 01:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iFRspsXE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736202571C0
	for <linux-wireless@vger.kernel.org>; Tue, 25 Feb 2025 01:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740447174; cv=fail; b=geNgg08o3mbaCeUb4hlhGgef11+qBkc57erQpPWxQHotkbYNCc16MqXFLX5O5vQ0GAVPlt6PuTV5ayP7I2xO5XXWhKdnJk4QOTOxczCUjOIAajLIwo+sk3txBsUUyLvqwb4VX4coPHBrG1cpWTfBg877XZAHB9jiGL5I2b8MJjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740447174; c=relaxed/simple;
	bh=qcDj3Qy1mggHkTo1Jkifu6ekcG6rDa2kRgDr2yVlLS4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=d8q/8To+eoKKHov17zkCMJ6Ql5tQngn/FPSoB77NkZbYM44rgbc3SO94JLa3j+dmv67yywZ9XxVtLxn8zMLOKDoL6MT1avABQ+qgRVsWjEscNa6UFbrz4K7MhRNcXw8o28wbfo8hd6/fNJ9df2tv88WUMgygWD3nlx6PuEK3Z4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iFRspsXE; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740447172; x=1771983172;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qcDj3Qy1mggHkTo1Jkifu6ekcG6rDa2kRgDr2yVlLS4=;
  b=iFRspsXEQO81abW+byBpkfJEuqvTryXQop8fZDEcmQH0Q5ydKP46BwBV
   I+kGPwih3iOssa07dOagMBXe9NtFc3wJuXDEw7jZH5glRf07sA/13Ibjj
   aHK8y75syNWGQAXORBku9QrSJMogGvxsMuG7d3Se3pg1pI1Dt3Vnql9h7
   g12nXq3G/Nnmu+nImxRB7VUrJzjK4PJudKGe43bsm540f0GNI4tmUmda4
   ccb6t+5niDk6iIXV9ub1g9Jvg9Pr2VsoeMsas7/4An+1Ox3aTK5P3b8k7
   LMn2nNImr2HGHCtBQs1QwlY6v8ci7eb77ZJrF6QIPrlNujqfIQRfT7YCj
   g==;
X-CSE-ConnectionGUID: BL0/ZjAxSqGQ9894Sr8ylw==
X-CSE-MsgGUID: e+uCDUicS1uEk3x0J3W0ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="51450358"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="51450358"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 17:32:52 -0800
X-CSE-ConnectionGUID: jC0k3tjKSSivyWHfFCNNCA==
X-CSE-MsgGUID: q9rXqHH3QVyZ1DeTjKNzxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="116734070"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Feb 2025 17:32:50 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 24 Feb 2025 17:32:49 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 24 Feb 2025 17:32:49 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Feb 2025 17:32:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HpqBX+1cQ8KVKLkwamyEFuny1NvSX1PCL+76d/B6fJNqJ77Dbaigrv6SXwIWVNeZSAZGFb5LCmntprzejj3x5UwQ9MOCSwezhQMlrbMU5pE0vVNhj9iA9MSzJab7mODIosAryzq/bKTz0vRetO0WyPV02jb0PlGD4pqbgOKTG0k+z9icduyi888BbKK58q2RB9LTNp5BkhsQ9K7V465WujgctWLk6SfqdHSOnT7kSOuOGRWWA8TclS5q2J9oO8v0pGiojvoOv1z/IH4Xcs3/ousliRij98chFBg0Gysu9pJhDfgptpNwfJtUMq4V+QoNR/d11YcNV7/bHG4c9JhMVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+H+eeopYYJ5Mm5JnL7q8n4VB7ln2mO64i66+jNraI6Y=;
 b=YBtqb+hutA0bcu+HT4PF5FS/U/3lI30d56qgI68mvUoQfBfNnzybAKe8g0jLS2HgY4JsuizfV+AcyfbwkLnRXF2gGgCXI/STv/WtzRxiXyRXjrJvcMdMeM7i/12EZc4We79jBhs0JLzqZt29JHy44hLEYrX1RC7d03HTh4sxrql4atkb5jlR+WHgVokGqarnz5CSiXJ5AwbM0eSvzBJdzoGkRvdbn7019R/Bfvt+Q9vUhKM/bxN8+j+TYzU5c+9FsX7pB5aFLnC3WaKsqz98zMNc4lNUND1eP2eUeV2oe1cjeMKSO5e+lcy6Bub9Bs6e0vjAti9OcuusaaA3JGUTVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6833.namprd11.prod.outlook.com (2603:10b6:510:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 01:32:42 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 01:32:40 +0000
Date: Tue, 25 Feb 2025 09:32:32 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Miri Korenblit
	<miriam.rachel.korenblit@intel.com>, <linux-wireless@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [wifi]  7364a4688b:
 hwsim.owe_invalid_assoc_resp.fail
Message-ID: <202502241647.f9f101e2-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2P153CA0024.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::11)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 43bcccb9-116e-435c-b753-08dd553c4b2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wXdRLqP9E2UmaJYjavH2aKx03IiCK9OCs3m3mByRxWXH7eb7Iyf/+xk6ImGW?=
 =?us-ascii?Q?Gaf38DfyLNm02ln652y+E4o9PgKEq62qCKuKFKUU/BYZZvUFxfQiMgVtFYxE?=
 =?us-ascii?Q?H62VhKAfarejL8RIcxnlfM64LNVvhMzhPgoFsIj6L9MJx8JcjJU3xW+6VMsR?=
 =?us-ascii?Q?uvp1k9QmY6AiZsOadqzBcK/VpwEGGfkCGU10hP93FBHUCcszfAiVAH/jtC9B?=
 =?us-ascii?Q?SBYurr54WFTSclGVatcowZ1+yp4f9tDVvfksinF/RU/E9Wv4uDQyVpn4IkOf?=
 =?us-ascii?Q?pzoNooshi8EKY4a2fiOUG2qtG1PsRJhQEZscpcb1JcYuLYWQDRNOWZDOv8Bi?=
 =?us-ascii?Q?+SE6797boCWqgamZX6cwylD1faDd8QbiCAy9f8ZWIV3h5G53Qi+tIKqCB+Pc?=
 =?us-ascii?Q?vs1Gsu8iRVi9OY/12VE9ZF1/WRoi6STxXU65/+MQxvSXitKCvu8mu5ZwQYNm?=
 =?us-ascii?Q?SE9KKQaTNzo2ww5Al9kY0LcBmR1jq3a7W+VBpUELxTQ5M/lO2vKpYIGoU20I?=
 =?us-ascii?Q?UfknhNIoiATQSCkiOO22erP4FwmkoYlay0EuzxAESNngz8kHEpvPqxyJACa+?=
 =?us-ascii?Q?r2w999TsqgAwRoWx37tmJhjOLn6+QovojVnXR/xVLJCDtEcdGET17QforKD2?=
 =?us-ascii?Q?IdwlHNokp7DGX3f3PhLcH/KhW5EyfJmiY76uxRwPTqUSvMsXwGq69iZI0HIW?=
 =?us-ascii?Q?S/bfmQ8AzFFfXGQ56sZiXrvvJw7YlWhCoaOPrU1M5o+hvHmq07g1gBE/FjGo?=
 =?us-ascii?Q?bhcdgOpn3HaJqQ7PkvB3KjsJsCdkCEk4NNFibnBWWahYXfqZVE3Z9B0V3B3W?=
 =?us-ascii?Q?x6QvM+vviWhygT0NSC43GaJBtQ8s0NKmu5J04r+g8nJJQux4FA5GUtaSWG23?=
 =?us-ascii?Q?TvTpG4l7kQtIMcG2MgBYn6uTUB8BsA0aGPhnc2qtP7LERr6o3EXNCN0z8Fcm?=
 =?us-ascii?Q?/JQr2aOotIxTOixOJA8NQijAsbwyfjiiTlMLLw71+MmKkHcSvJ2GzF/2ZLUX?=
 =?us-ascii?Q?29zVSIQkvJqQes3LnyKR5bWOg2rYs2wddeySQln5Y1XF8lJH0c7S6jmX0IMi?=
 =?us-ascii?Q?iF3zLmnTwn7v7OUbjCGZSRvo1yzEK1ex8pMSsQTjIt/01OTF5Io6b2+gzz55?=
 =?us-ascii?Q?+VuZnvyZXJ/sCPwRgwjT0+dbbKm/WKqPNOIz0IcLzR2zdaKknNUh2dNe5loD?=
 =?us-ascii?Q?xB+Ja3wV7NSjYCVfLb26gsOub3H7HRNrzLxU8tiUdhUFWlPgvJbVxT6DHOtp?=
 =?us-ascii?Q?3gxsgPk3aImhMJLSMlGCXIHlq0u2KHHUbyl1iZsY1OZdRRitfiYa+WrhvPpH?=
 =?us-ascii?Q?4Fv5Kscx2noOc2zEXh151Rk5LhkWpzYKQ2y27sAbReM+Zw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i7FvwHS1Qs8LoEJs7gcbzas4ZYIpTmuaOBbGo4dZPXz/EhyrDtr6muVg2WXp?=
 =?us-ascii?Q?ByxIRcDw2V4kKkYQZYaI/FQgpal3lI/1cb6UQfseEBbqAAKOmgUenP/t5nn5?=
 =?us-ascii?Q?oiP7luhWo+EMsoJGfqXWLz5LqJjurHvTWxGrySth9JsuOkENFTn3lr2FEW/M?=
 =?us-ascii?Q?fYD9gpfewmHApsR0DSNmKhGReAWO/f6SKLktjxd/u43CvhzU3GdOcyoZtx/q?=
 =?us-ascii?Q?NJm9C2N0kKsmpvTWGj8zCPQbCpv0kuiTsKxbrhV4BHRGFaoUrLQe0jFFiwUm?=
 =?us-ascii?Q?2obgLZoXN+s5DKAB47I/ZnTsOwRkE5wzOmOM4aprk+H26KcqREOMjeLV7/BP?=
 =?us-ascii?Q?ELqlwXLUQM2HxeYDigvWo7AlgxtSwyorwqcTHn4334SNFHePjsh74dW83qq4?=
 =?us-ascii?Q?yYnTCKAelPqEsyHp1G/iD8sNuknPaGU3Q+9uNK3PGOQcoNydxfxmYho188KL?=
 =?us-ascii?Q?ITFCtDXHQ84hVvRvED0sCw+8oG2A0czHUL/hLxHvewXinnVn5RTXJqo6xi+8?=
 =?us-ascii?Q?/MDbR6XhOCh4De3q0eomylLYXwIh2XXAd/zu+7eakBvLM9sXT3q2+mLYPWgq?=
 =?us-ascii?Q?2QdsQD+gtjL1pCYcbKyLJJ2h3gCTeauXFTX8gIkA6KF5JRPjQGwWc/uDoKLz?=
 =?us-ascii?Q?bz4XK46VrUtKxzTo7AmhnQUKB6cka2bzNiQOFxRfWEkNbMUgwUFoWfdTTxHN?=
 =?us-ascii?Q?2ou212kn9nuV0UgcsOyNfkpJPuLoc8atRCNgbCJ9g7TjNLndvFeeF4D4sXgK?=
 =?us-ascii?Q?HN5zAf4WoBW50KW9/2cFHHRKg+n4ZEy+SEa4QQ/OTVCkU9r5oBcUTK8Gw1/c?=
 =?us-ascii?Q?5WT2eAfhFlFJqdTA7uZaunX7o1S4ZMqbt6mn3tjv3JpUYACHWK1n1J8sITpa?=
 =?us-ascii?Q?WPeMjHd2oD7Dxqnl2uQXqVuQheWHoQgb9da/3N9lWLkc1aixSfR9q1SYJUc1?=
 =?us-ascii?Q?GfnR5PSSvjPpYGnUedkZLL+z2qSVlRdC5TTb2JSIq1xjsz+H7wcEqvi2UVaV?=
 =?us-ascii?Q?Cipyw0D6esSM211Vj0hVYDTE+Zn3PnAR80hKpJfQ+GozcFzXNbPNNsGYQ62d?=
 =?us-ascii?Q?dQMxr/Ka8FnEV++fA07hxyqiUTCdrrenYU2FPxK9wk8SWDEE9osJeOKb1SRO?=
 =?us-ascii?Q?8dInKCCXf0RL/C9rPxjY4o+9oK6xaf2XiVGY1KdG21pRToJbnyBwGq6xDsj7?=
 =?us-ascii?Q?gcwCYWCYbwMro7xpkF8Sra4BlQ5VSp4y3TzN4Aa2RxJ5zbcbAMml1AAFXxSY?=
 =?us-ascii?Q?I1FxWLmWhOjbuBLZQ7BJlgqW5bk6v9R0VHUuENgaiIqOMq09VeaQN+bkytb2?=
 =?us-ascii?Q?mPJkRptIIadrQRauHa2UfIXnNML7bkcMDWV6T4wQSdHWg4gz4IdZ3ztbUAzn?=
 =?us-ascii?Q?sNDEkC0IFF4sebiZ0AuR4tLI1UgCAvKbpE4JhVSJmjyXOTJemtwpxTAD+MWf?=
 =?us-ascii?Q?PQ9QCXVo104PQeuIwuA2rkgl2rqKFAPRJEr5UBo4TaSC3V27yReAzmzhSWmp?=
 =?us-ascii?Q?W+rdrbzhBFdsMTm7MI5BAvwYgZpmo/BuYAqpeGMbi9PG5b5NHphGxma2v8iN?=
 =?us-ascii?Q?cxMNsYOi7M9YHZmi3BLi8hADi7mmMBZz3AHvj60vjSeuBC7lZJwRJXlhLOAt?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43bcccb9-116e-435c-b753-08dd553c4b2e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 01:32:40.8207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: migpwdN4wMiI3dMyEJxZuRMQZpcBBT6AF4Klbfc/g0e90pLBg1hfDQhDg8wp/a4qv6RHse8clkq7FZpPJ3pjgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6833
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "hwsim.owe_invalid_assoc_resp.fail" on:

commit: 7364a4688ba4ab4f90d9da0ebbb4e4250bae0a27 ("wifi: mac80211_hwsim: enable strict mode")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master d4b0fd87ff0d4338b259dc79b2b3c6f7e70e8afa]

in testcase: hwsim
version: hwsim-x86_64-c8c7d56a3-1_20250209
with following parameters:

	test: owe_invalid_assoc_resp



config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 384 threads 2 sockets Intel(R) Xeon(R) 6972P (Granite Rapids) with 128G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202502241647.f9f101e2-lkp@intel.com

group: group-06, test: owe_invalid_assoc_resp
2025-02-21 18:21:25 export USER=root
2025-02-21 18:21:25 ./build.sh
Building TNC testing tools
Building wlantest
Building hs20-osu-client
Building hostapd
Building wpa_supplicant
2025-02-21 18:21:48 ./start.sh
2025-02-21 18:21:53 ./run-tests.py owe_invalid_assoc_resp
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START owe_invalid_assoc_resp 1/1
Test: Opportunistic Wireless Encryption - invalid Association Response frame
Starting AP wlan3
Connect STA wlan0 to AP
Disconnection timed out
Traceback (most recent call last):
  File "/lkp/benchmarks/hwsim/tests/hwsim/./run-tests.py", line 591, in main
    t(dev, apdev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_owe.py", line 918, in test_owe_invalid_assoc_resp
    dev[0].wait_disconnected()
  File "/lkp/benchmarks/hwsim/tests/hwsim/wpasupplicant.py", line 1473, in wait_disconnected
    raise Exception(error)
Exception: Disconnection timed out
FAIL owe_invalid_assoc_resp 11.178189 2025-02-21 18:22:05.856151
passed 0 test case(s)
skipped 0 test case(s)
failed tests: owe_invalid_assoc_resp
2025-02-21 18:22:05 ./stop.sh



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250224/202502241647.f9f101e2-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


