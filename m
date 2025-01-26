Return-Path: <linux-wireless+bounces-17941-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E3DA1C674
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 07:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9B383A682C
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 06:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F5678F2F;
	Sun, 26 Jan 2025 06:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eY75GriE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655DA28382;
	Sun, 26 Jan 2025 06:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737873348; cv=fail; b=ufnildJWNTt+3o4Zz2vGi01CNqqVJH1keICCw6T2VDSfTJAhSl1kxMYmcuioEY2qD2hDcpZ/BVv6QSQUjCah03fwU6kXKO1xjDr/m6O+4kICVGGe4dDGNbLfLb+IjQXft9B7iAl4TrG9VXLExJ9GsfP6vOJQaTwwgJRYQVFOXy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737873348; c=relaxed/simple;
	bh=ltgsNKCfB8UWG1OX8CkDNfIXyGpCOObRtQdHvJpdHZY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Bcs+BvmvLE6zHDKqobOgsvWXNKf7hh3eS/sTpesy5WEXJQ8itTfTm3PjW4TMmBhtHuWA1+ycORys2bnLc0iRI9chISj/eunRWxzyrLMDtc0go8dkjmhnqq+Zhi1F36sJu1di7Zkx6QxAEX/O9kSS1kfsY8k+2OBHZIhXpV48VNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eY75GriE; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737873346; x=1769409346;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ltgsNKCfB8UWG1OX8CkDNfIXyGpCOObRtQdHvJpdHZY=;
  b=eY75GriEw9zZE8S+a5BzLtO0P9lD6fFFVb17cD8ceOSKy9uZkcngNpBC
   bqPRZIZIt1Gc+ElH7TxXHlJ57fKJqL7V52xtzdZ60l0XalxelxenHFkl0
   vvEsrTH9vLj1+6hZv7Nu1qVT7No4LcqASwtmtZIT9IpMYfEo7qhRYZNjg
   6fBR0Pk2s6aOC/wBUWvUh8KYq/EsJBZGLtXymubqqZDf9CVWw9v1KfXGw
   eDDS5W2bA0F/uBgohmTTgVbKnvQDPWh5gsbRwn3CWIdMnbtocAj9dgy8t
   lu5kifvc3oMCPFNg5Zp5cReTceaNFhuJf+m0TE4g3/AD5iFovh70unUll
   A==;
X-CSE-ConnectionGUID: BwaEQSpiQyWccUnFwHayAQ==
X-CSE-MsgGUID: lrs4Trg5R4y/ooF4jN5zhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11326"; a="38528105"
X-IronPort-AV: E=Sophos;i="6.13,235,1732608000"; 
   d="scan'208";a="38528105"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2025 22:35:45 -0800
X-CSE-ConnectionGUID: MBr4TxlxRuCFJQf5uIlFMQ==
X-CSE-MsgGUID: 4977w5SXRou2ObQOTOZbYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,235,1732608000"; 
   d="scan'208";a="108026811"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jan 2025 22:35:46 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sat, 25 Jan 2025 22:35:45 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sat, 25 Jan 2025 22:35:45 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sat, 25 Jan 2025 22:35:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wbuI9R7aDhqj9O/c1Sj+zgUdmQ862fSn85COeRNphc7U9XDuwaKN6Tzob929uhAF1DuuQmNhh1Erdod0zXZTFDs7ffBIaU//a39dGvZhdk1qXcjZTboiZRTNYCaZ9nGXdKj8WsinVul6VelfDngq5iDQsDpPGHSxIc+Hq6GPlYNkB8h+f0HCw+VmkmgUc9u2orytJBzC5DmuZn6FanO15+Tqtdx1Xg9R9dbbBlwunI1gHVI2H8XJ8Si/jEraHhqVMBglaiJkoAfzfWGBVxYe6nKR1FX7VI60G3YJVz4L3ReWRWZ0wamu9GQ9xWJLVOGEgKiT/5hdqSL8R2s8h2uwRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/T+x4ILxgAv+b5ZnL3LddIG77Q58QtNhk3G5iPXxRo=;
 b=UM2uYSREHBiTNgpMtQyv06T/sC3BPGC1jSmyoM82W2bRXK7+ziPd8utPAFikBKkzVJB0Jz1bVo+IYXg64h5zgEd8vHoEuLYIZy/JDxNIGE/P2qY8UTIoMqdgAvG4vYrYGj7z9W+VcYY21rPXl4UCEa1xrsl9AC/Oe3hLJgk6H2LShjnm6lXmtFDZ1xFvZTOb52VOGtQRi7G40p0YUMWkS2xjGBDaOIDZ/UfjV5fH+uj0ONgIw8Sq0tWnvpWeafLpsL0eeYPLWCueEM/jKJ2KCvPNJShUG7zT6EEX2eT0vOCqki/c2JpidKcB6oQORY0e1ZKnAOqPeSegV7M9hkYIUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB7947.namprd11.prod.outlook.com (2603:10b6:930:7a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.21; Sun, 26 Jan
 2025 06:35:42 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8377.009; Sun, 26 Jan 2025
 06:35:42 +0000
Date: Sun, 26 Jan 2025 14:35:32 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Benjamin Berg <benjamin.berg@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Johannes Berg <johannes.berg@intel.com>, Miri Korenblit
	<miriam.rachel.korenblit@intel.com>, <linux-wireless@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [wifi]  708d06b33b:
 hwsim.connect_cmd_reject_assoc.fail
Message-ID: <202501261419.50a46ece-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::7) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB7947:EE_
X-MS-Office365-Filtering-Correlation-Id: ad07e3dd-1851-43b8-a416-08dd3dd3a7d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gYBvp+PDeOZ/AU2pzd8GTJSSxceZjcrqVydwjUfujRia56VODvPWQCTxOqbz?=
 =?us-ascii?Q?p+wzD3Ca7PW6vuSr9lOxK9U9nRF8TsQ1lbFT1AAf6f6Gg1WB6WduH8L8J30e?=
 =?us-ascii?Q?nq1SKtG7FsbwG0+hWAlVMLc1afVYREdRBabpTdQ02dAgYcMMFW9NZ+BVPFjg?=
 =?us-ascii?Q?KRwktC8fdxJppb44qoe98P/uOXW08su4QgZQ9TNq3cRxip8RzhbeLqdoBdsj?=
 =?us-ascii?Q?66KvvdwfyvXYAR9ytU8zW68+CR6DPzIZHFsE0RgmlLH/tfltALaIUX4yxq0I?=
 =?us-ascii?Q?IKOe/YItdXn4Ohfl4QL4Msd0lFCNNcsMeX7FrA9xLZ61UYFWTD1IIu02Km/G?=
 =?us-ascii?Q?6aDzOgjW1ZqxNgQZnSRuNczKNb8jx3R4e/XtaSoV9s2URdCc7yQSM8uE+xcp?=
 =?us-ascii?Q?Pw9m/l2rbjcEcw4h/F/rUBDFRhYkTHSY4SMWJTKaNfC6KIsR/MPicBad5NRG?=
 =?us-ascii?Q?Ocb9kZdSm04X30XLPktL1IbosXMifEbM6RBT/8OsFzEjEtHElllvaQP55bs5?=
 =?us-ascii?Q?FT9Mv5h/2kKnFIXWtFja4E+1GWVTkvftGEYlhPTi9r2TbQgEoU0UgpryvBn2?=
 =?us-ascii?Q?hdI0Lr91qyKp7ZRDlW1A/KlwJJPn0A96BWrvsy5zHmeX69j2i7osv63ID1Fo?=
 =?us-ascii?Q?WQL1LqojHO1IQtGpWyip4LIQluMp1aeNK6+1yej9xM7h4ubpPBIBv9MxmPLX?=
 =?us-ascii?Q?e5O8HbZezf3NDUkBiTZywtlXZVgmfRkzsa+fwV/eA3jwSoLnqjZe2ZWG5A1R?=
 =?us-ascii?Q?TgObAhNvocSrFkCAl68JakiWQsjGpu6tFrRPdg/2KLpTu4Ac6HUBpGwozGi5?=
 =?us-ascii?Q?QZS3quxMPJeXlZ6caRq1AT1PpXz17hbjFr8NplMLuJeLJ5CVymaOGJMZPEUD?=
 =?us-ascii?Q?JTYA4vDqIXcMopsWHYJku9QJ22LJ5j+bnLpzOnl4mmu/ApzpTIl+SVK9DirU?=
 =?us-ascii?Q?QSIE9QxM4wcP+OYFm5SiDYICNkCW+JnFfgLyI9NPBKPRmLgFiqvAm84h59+Y?=
 =?us-ascii?Q?tGrWQCAyP4rGhBrsYYOjq5JToW+l0u/YK6oZ7Wo2uIbbDP+WmHo5fIvP5fnB?=
 =?us-ascii?Q?/TmtVXX62xQ5PuXIO7l7AStzAY2rD/s1ewp87Np4q7AXjwHKK/EDE3iJQoUJ?=
 =?us-ascii?Q?nd9MWxvmCyXxtLStbskWcOClT8PhQb9XtlR4+YwtvEjdG2WF73y8WZ3GNb1f?=
 =?us-ascii?Q?U0SSldEqMHnlIBEA/pWaCRQRcl/p6TfE5E5inhdFsmQS/rOoOoNHQyCdWVV5?=
 =?us-ascii?Q?4FTfGaD7sLuu46ycewxbvk9Bw9j3REd++ywIZjjvPN/R/sH9GV/8hlpnI6Kd?=
 =?us-ascii?Q?fPFkucfqE8fHhzN5Yw7kRHDgs9QiTRzgB5sxsMKjL3g9bQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?izL2IQnwE1RSdBp79qwaccE47V1jG0ZmEuEIQJBzUZvgshJJz2xj0BPp6Usf?=
 =?us-ascii?Q?7qKpOC2lZ7jeNSFjeKRnvOzXty6XwpwGfQkqwNEa5T+qlsdwpXHgjI2BJn7t?=
 =?us-ascii?Q?oMywZ9FhiCOLz+kXbu18mSEgiwdjt73JiSV0cTBPtg8KlJcWq9AV83VphAPi?=
 =?us-ascii?Q?eB+4DK47ZOQjq02nL/4Lbbm63gU2OlZenZVo69FqnXNAm0l137vm2X6cnPiG?=
 =?us-ascii?Q?XOd7jh9N6e5cWx8WSUri8PgejRlI5tBYpIbtti03aVhPOZ9Q7jDTrB6FZswi?=
 =?us-ascii?Q?VtERjFkHd4Y4BJ6cyYBE9aC/2B/a0v6oiSRBzQoG8NaySKE19T/bd4v2OMSw?=
 =?us-ascii?Q?dmwHyeC9yMYquQil+NXJxHEuHtJKQLoXrxy6HNnEPWRAPSnqd/SbA4ws5xLi?=
 =?us-ascii?Q?OxYKHvsFjzadSYvDYGA7JO6QK0BUX9dnW6VZTMKb6gxOpkIf4paCxenjMtyE?=
 =?us-ascii?Q?yMnZe2qajfeTnnyvgeBczkuypRd67jAW2HmbES64bCNzhkBPBoCaivYlXoR8?=
 =?us-ascii?Q?ltXsKRLfR8Kg9U/9+VxTEFBWhQiUfMtoOK6U7vDwJlyeR/HDSKTniMwhcyPU?=
 =?us-ascii?Q?4uhsJ4zlc4mRzaCxTlLIghHdNItYuctQbQx7xQbYn+9muJiiu86rbJI3ssw0?=
 =?us-ascii?Q?JZxyxHexy4tzc9I3SWdgd9n4ak/upkJM2KQHM6LzZgEN3/NQoUBnlwC68hmX?=
 =?us-ascii?Q?47tjsm0gNOP0sdwQRjMRQBHvZ4Ux/v38OEpWjs8UNCdvwKV4YIxxeJGNgbct?=
 =?us-ascii?Q?kzPZeMYly02iXULoX1SnLudarcVh4ktwquGcNuyYPBpzOMUkTIHFGSjdQF4F?=
 =?us-ascii?Q?YDbUzc9SyjcLDDBBfnQntoCg3b7t45pKxxMIzlZGoGgxhvxT3LF/PXgY9VUr?=
 =?us-ascii?Q?jE7Z786jNnaU+o8iRmHmmytFh9iH6waw2XAW1zs++ZkMovGRO1WTEtGnnAE9?=
 =?us-ascii?Q?DzcK374fHWD3b2O4bTYqCMp1OITbWQS6VPAENRmg/v8Fu1t7HJ3ivKIhVgJ2?=
 =?us-ascii?Q?x69g+htNR55CtnpaKzpPbu4WbmpbWlz3AtFVP90K7hcIN+7BQbHcdlwPCs2z?=
 =?us-ascii?Q?JCHOHo24opIflUtfruDlgBDikpq68tCU8JhCoknUiZ8g2rbMEa9PNiszJWrI?=
 =?us-ascii?Q?U9LzD+zLosFQOjq5zlH7F/EouZeURJzi3sVNOdl1DKYbvBYHB9s8cR3qlwRp?=
 =?us-ascii?Q?o5GHf0BQqh6ifmqS4GT9PY87VAEhPD19NUFrLu9SabO8YrkbLdJZcxPj2K3C?=
 =?us-ascii?Q?0yN0eq74CjqnZMxesOiIzyP6gBZVFlvsVt9e2C6CtjoJ4vwWMh8EJQT1y3iv?=
 =?us-ascii?Q?dbyWCMKugvlgGsw/Jjw9QHFYz1gnTekmLzz65dEjLw87ulrGm8H5pHNq86dG?=
 =?us-ascii?Q?K2Cy8SEJbk8vaxxavzDKjB4XQzJYQCNIzOntSjeywd2W/joHBQjDhVDZwpJx?=
 =?us-ascii?Q?zdhIb2v0Jp0Zy5CBgroTBDcnTbMZAcLWncEpNVm0JHdWMbFYKNHC/x8Nj7Oj?=
 =?us-ascii?Q?0SmGfnHjDEWX9gOGYtfG1BPO5d/8m5Xq++oK2WNvyfKnE0QTknT9mF+vgwzu?=
 =?us-ascii?Q?W+lRvoGtliEWD5T8z0BG52W8d/1S2vrN8f/NUG5gvZf9D40mmAnXAshenSuW?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad07e3dd-1851-43b8-a416-08dd3dd3a7d7
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 06:35:42.0631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: APHOjEG6Bjg43ph2vGeNcDYo5iHcQvAVOMHypKOL4r1NrJtxV6ZkQDPJOk/5o5Og1zZgwEPUb0B8rUZdNREnrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7947
X-OriginatorOrg: intel.com



Hello,


we reported
"[linux-next:master] [wifi]  708d06b33b: hwsim.owe_assoc_reject.fail"
in
https://lore.kernel.org/all/202501201310.71e65f29-lkp@intel.com/

now we noticed the commit is in mainline and we found it caused failure in
another hwsim test. below full report FYI.


kernel test robot noticed "hwsim.connect_cmd_reject_assoc.fail" on:

commit: 708d06b33b97329bd499ff92908c96670a94a510 ("wifi: mac80211: also verify requirements in EXT_SUPP_RATES")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/mater       b46c89c08f4146e7987fc355941a93b12e2c03ef]
[test failed on linux-next/master 5ffa57f6eecefababb8cbe327222ef171943b183]

in testcase: hwsim
version: hwsim-x86_64-4ea2c336d-1_20241103
with following parameters:

	test: connect_cmd_reject_assoc



config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4790 v3 @ 3.60GHz (Haswell) with 6G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202501261419.50a46ece-lkp@intel.com

group: group-36, test: connect_cmd_reject_assoc
2025-01-25 12:21:41 export USER=root
2025-01-25 12:21:41 ./build.sh
Building TNC testing tools
Building wlantest
Building hs20-osu-client
Building hostapd
Building wpa_supplicant
2025-01-25 12:22:32 ./start.sh
2025-01-25 12:22:33 ./run-tests.py connect_cmd_reject_assoc
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START connect_cmd_reject_assoc 1/1
Test: Connection using cfg80211 connect command getting rejected
Starting AP wlan3
Connect STA wlan5 to AP
Unexpected rejection status code
Traceback (most recent call last):
  File "/lkp/benchmarks/hwsim/tests/hwsim/./run-tests.py", line 591, in main
    t(dev, apdev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_connect_cmd.py", line 143, in test_connect_cmd_reject_assoc
    raise Exception("Unexpected rejection status code")
Exception: Unexpected rejection status code
FAIL connect_cmd_reject_assoc 1.05021 2025-01-25 12:22:35.518496
passed 0 test case(s)
skipped 0 test case(s)
failed tests: connect_cmd_reject_assoc
2025-01-25 12:22:35 ./stop.sh



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250126/202501261419.50a46ece-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


