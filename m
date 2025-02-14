Return-Path: <linux-wireless+bounces-18954-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71926A35849
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2025 08:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2691316D525
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2025 07:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B577521518D;
	Fri, 14 Feb 2025 07:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sc5mPxUe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C98C21B1A3
	for <linux-wireless@vger.kernel.org>; Fri, 14 Feb 2025 07:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739519842; cv=fail; b=Zgb6K0aaBh74cShpwT0nis7mtCo9O/82i4OTG5sb2/hZoOypa627juc8IQIvRxxBHJV4owLDXeDkAHKEk2x0cIU3K5d5UVi/4QHPxOTqviRr3Ypth4s9wH2q8uH2OgUMaweSrWEbWOVCnOMgBcQU13GYRPVGrHGFpLEz3UwIaLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739519842; c=relaxed/simple;
	bh=u5D/U5dWOoRha9APTncdtw8liT0UXZjFrR381IZ/Ji0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=GNJp0h6jgliiSnWaalm+3lkmDsHR5GXgYgwMXFJ73hb55Xj/jj7nyQ12djNKWw8z77wH9JOmFeecfH/CDLJjt2z85T5AY9J9DmNEi7ot9RmLi4anvyoJIkLfCWUnWaN8YgHYpKjyU/z6nqvColuk8UxyDmq6ry9HDvxHd/aSKyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sc5mPxUe; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739519841; x=1771055841;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=u5D/U5dWOoRha9APTncdtw8liT0UXZjFrR381IZ/Ji0=;
  b=Sc5mPxUerQ5V696pgyTiEbak27Yif8sZFwAC/dl+tDKPnlXcnjQrNJuX
   /v5Vu85zYbdoYOeIDA6Gv8rtQO7HydaUDOFECGyicQ46h8ZwYTsMM08y8
   sq14ibvn6zduMDGi3XbGSmyYufZUZmQoUCrr8Qan8vVcQ2NueAiRPh9Nd
   KW7BccmypzQ0nbZALTjLFvjDYnXXgRQq7jvOCaQD8borbNNni0bcM1vHx
   lNy99x6hLOpcpjWd8prLhPg5/dl5PdNLVJPh8eeqxjwKSoIU71Uyqmn5v
   KXzkl9k26JrR3OBjXZ9qXdx6WreppmJvZ3SP2zRGlwyUfkZSj4a3HDTVF
   Q==;
X-CSE-ConnectionGUID: 8JzCRWS2RLmUs2S/CsgJ/w==
X-CSE-MsgGUID: 9jwiy3JWSrW1s+CQT23lBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="62723682"
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="62723682"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 23:57:17 -0800
X-CSE-ConnectionGUID: 8xcv2p9gTEqZZeZ+JdMbtg==
X-CSE-MsgGUID: 5EKAHc2vQN6Z6czSJ2YoLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117522438"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2025 23:57:16 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Feb 2025 23:57:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Feb 2025 23:57:15 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 23:57:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwOx8Au7wl37FlTt+scI/4mxTKY0G9hXy8cwQnTtXKu4ss0XgdXSfeZcJ7uENf/PqrSxta/bZ7u3Lg8bERy6GTSkJRaLws5OqDwnJ4IDTAdTHrnyhHTSlXgEDCoPEHSTS7e2KpMY2cj/ey+aCp56bJoOq9N0yNB1o9n3VO2P+HOLqtE6eKvXXQ1vzdJi9jVBOgIO8Awt9J9ePxphqx29Su9G3g1AffaqrzYIJFxSaPxeb82A8pxvjuLQFoI9feMhPswkVkvuc0+XKAMJsHEmWWEvRopjqMGN2HOWDBbQORkIUpv2Ko9UHK/SI8qzAbWyRDTFmW1fEDbDXna93rBwaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6a2uhCJS5xczu319TXy0fT44vGkWPI3KCm+1xJJdFW8=;
 b=kpbHYBOBCbAga6bpSfBmeFSqOdkVeUFYxRTug3k1yPHUS9fmyugPVfXzYqeKEXTyEEkFKEb/H2equvZTLZjBGznrFGxOYMb+HFuL4PPeGHAxE3iHQAmDOZIHd7Gzu23MNK7G95rsPpvIByjBnT48gdZQA7C8nXm7AvCr4tzrTbQGj3exLNQyWeP847qeA6aCI6QMJlNvulcTwQAGG/9rVJFkXtoMm/DtvOnoz6tWEuvvU+x49Os131eopZzKk2nLxmrvvy72cyEned0BhrIR0W6eNaUl6XqBW/Qmsueso+v1wrWYGK6MOhXNGzgeugT61ecO6hEkyCZ8JH3bqv3z8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CO1PR11MB5076.namprd11.prod.outlook.com (2603:10b6:303:90::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 07:56:58 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 07:56:57 +0000
Date: Fri, 14 Feb 2025 15:56:48 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Alexander Wetzel <Alexander@wetzel-home.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Johannes Berg
	<johannes.berg@intel.com>, <linux-wireless@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [wifi]  be22179cfb:
 hwsim.monitor_iface_multi_bss.fail
Message-ID: <202502141548.e1f3f465-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR01CA0149.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::29) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CO1PR11MB5076:EE_
X-MS-Office365-Filtering-Correlation-Id: 7402a26e-7ff0-43e3-30ab-08dd4ccd2797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zpwLVsyK71wxDt1RLRzvsojXnecxcLjNBgldTAAk17f6M86j4vSDs8b6UrlP?=
 =?us-ascii?Q?HXVFqV4BlnejIybf/ABwHEDFlI9BOLhNAFc1wgrj5EZf/o00yYaZ6ulTsPrW?=
 =?us-ascii?Q?4tAJP9Oa1DsmnpRCCyMuUG6Gb/5PN8pV5kcsLDkQBAe1QlJh/scaMn3qYJyw?=
 =?us-ascii?Q?sfEpiqkUfisiRTT0EbZQnCnLnRYtNtTgyOwjz6tGQwMYlF763DMcvV2OyaNS?=
 =?us-ascii?Q?+2Lgub9sFidSkYYX+fZSa5W+/+H1Km4/e/V1/PgDfJM7LlFvDlUCf/79R4RM?=
 =?us-ascii?Q?J4OttEh2/kcBgx2+P4Vrv2HqvEPi+XyAXEuJiCLvefD6TUnfjAwX8eXYH/+q?=
 =?us-ascii?Q?4/Ta6rYZCmtsD4WCXlumWuLc3r0fLqyup3li112DqIFIO6LC2vvmDWZAtPgw?=
 =?us-ascii?Q?x44uSPa3Au3OTFrdcqpwMqt8D1q8Y1AVKRwmXi6ZHvtkJnaBSh25Dl4m1iwM?=
 =?us-ascii?Q?cpPFazVut4UrYQDr8cC6CMHMc9/hDXjstuIWYlZD/teHuZMsOtdIMCp1xN5M?=
 =?us-ascii?Q?9XavzVMo3IAIAe6eVjSNZK7wvSgRCHNG6w39PNdrshCubXOxOmdDNSc5uXqm?=
 =?us-ascii?Q?iMo/fGCHy2D8j1jtcNWBmKy8xpiv9cCBvQ4qsrTiH5FTApaVrcrCs8OqmoSO?=
 =?us-ascii?Q?zB8EjPzScIPtAdnbvIcRPpJ0dpCCFUaUr9GvprND9nv9EPjgxJbPo046F4jX?=
 =?us-ascii?Q?dVWk3vCFvFVya93qvdKVHjabCxsmEOGT572A40Uk3b9lNoOzTfbji2WnEAHK?=
 =?us-ascii?Q?rjLksq+n0KrKQqUaiBFUJwQDu8LZo2Z0U5i0RYVwXYRDGvN5d2Au2H3qW4ES?=
 =?us-ascii?Q?/Z+dgLY/eu73Uf1OTOqCtaELKFPylfHUTpRCY3kPXNZm+r0Qqu4a8MyLW0Pc?=
 =?us-ascii?Q?709jpVfWAwINOzwcB/9mCA8DlVXjbfXnJIujydXVdxbUzHoyMbOF3yJxs41m?=
 =?us-ascii?Q?TDk4N/1avGnPDEW1t1+JL1z/63rYJrfORPY6vxhVUpfBgHG8BLfOpyYuE1vR?=
 =?us-ascii?Q?AMK0jcTdj3Pk5q65S4QwIzlEklhSP5g8AUEfbSINp22RwMXyVzoG5R4qsZ3b?=
 =?us-ascii?Q?+n6HXPNOxITToyiRvFHqmBz0i45eIEdJCuzfQemIBCJXmZoRDsRqnSm6r+gU?=
 =?us-ascii?Q?71TGffI+ymZksPG0zANIfAiPIfTfSnx1y20wt1UVaIZXKwkWwhxXZbl+EMMI?=
 =?us-ascii?Q?7yxO9GLBFsH37bzSYkXoxRT/eqmnr6E7sIyKm4t5Ggv6+MBBiE7Oc/yF7K3G?=
 =?us-ascii?Q?gV556g2+cTrXp3SSBLSpKRDds18Qn4/lBitnq8M2YRQiuyEQPOQA9UUXmwuF?=
 =?us-ascii?Q?IgXeG90F1FY9VG5WRfR/BbafANnQmIOF8Vr7Z1FFvnabig=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2gDshlrEgvZDKSWeMmaUeU22S1dO07dG7V8/D6mrbxhNZbakVD0rXggleaJv?=
 =?us-ascii?Q?PGocgP6bl+U2J6nUa7WbkgTiJ1o2N0xrY0rCswK/Ult5P/F53eb2Pay84eJE?=
 =?us-ascii?Q?QzrLHTCOh2DFqYjETph4Cn+clc582e6xbWbnr52i9oXRNrKtg1tDyvpbrpk4?=
 =?us-ascii?Q?9jqUyz5DG39e2f2pUcBsj1VN+1nwMtV0YCoXzEAX544gGx/4EH3qfK62ymHS?=
 =?us-ascii?Q?6cySc998bEAuiq+nqMTiM1SCvD9ej22BLqjxChWvU5Vhhmm9LLcidTdwzhTb?=
 =?us-ascii?Q?ykgij9XXSmnnk5yuclmAK9L/ibbYAFG1sJKVwim9A6SvEW6AdU2ndAc57KMe?=
 =?us-ascii?Q?Vpkhw/1pIrEE/YkhXpEp4Nt26RtF4cn0kSL0tf5cUfyLG0chudfIsI4IDiDo?=
 =?us-ascii?Q?qF5MKO82Mq5y/CG6sW0KBVT7i2+BoxKFWIU9szaSAOFLPDPVkFzqH5OcO6g4?=
 =?us-ascii?Q?KNAhrZa/juPRBaHo6FPisBG/IUv0m1J7hf4VCKs2kq4G8yxVLuxGIJISLA0o?=
 =?us-ascii?Q?0RC3BNmpli579V/6gmW5TpVwDT0lmuYYWgq0UCLpLnPc3kixm/pcXF1XEFzM?=
 =?us-ascii?Q?AuRGj494xFgKYjsh0E4zV1zDK6jXdHRraaYMs9ZaMwncK0Q5JUNU0YzdsuBV?=
 =?us-ascii?Q?6MSrxf14cmJ0wxV9d9wQPJMf+23kpQt5d3ET5/TACJZpwwp8dtSecjfgcj/d?=
 =?us-ascii?Q?60a1oLoXPJxmSB/8lA4iMeBP7lF3UOuIqm022qFRJLc3BvDUR/Uvn5N6gvVi?=
 =?us-ascii?Q?nH7b9QC47qOkwxzVuBzaXKYlNx5BeLafhWDXQExrslsonN9OLyE66QGj4ISC?=
 =?us-ascii?Q?6GyjKbpRV/8MBZW6Wl7YiGrcqdDeUGoPWGJec1eK356wAkIi7A6JShaIz+pS?=
 =?us-ascii?Q?y9mnI0PSxD958r0275bNKBJO4LrBvFHpJVo9O2/4Bk74wVpltSBP3qby5GK6?=
 =?us-ascii?Q?OIcgcXibPtZeCSnRRiqg7UXQOo8Ra+IkpZ3KwU7P1YyY8/WBm/kfzwiqcVhd?=
 =?us-ascii?Q?69B0xqNKk2OCpg2fKkMjzM1bCu7Mxwpj7wuG/PaaG3W5wO1FnuODP4xncbVE?=
 =?us-ascii?Q?PcPwRc9qMXf75CcIeOF69UdOPH3PYfNfk52qMmy9SDvXPjrnLrP7J6vuW+4P?=
 =?us-ascii?Q?9yMIsp+9jNS1pBxG1ug4F+WmO8hf2jgkiUz2y3jZ7iN2fCMtJU/UtZ5tJiaM?=
 =?us-ascii?Q?8xwcl3LAgO3bphn+nkg1jzPLvmpmlmEUbiZmELfoIelPtPYOQDhLBwYNneHn?=
 =?us-ascii?Q?DNLq+rNRrU/pxEcxaq1kRPZz35VmuFBxSYNukREb5IoMSIv6bqN0Hn1IwVCD?=
 =?us-ascii?Q?iKaER9Z+cXgE+AAa0sJ32dnZ6kJg1VCOgaMWXauMICRoaGZayJQlj6WOypKa?=
 =?us-ascii?Q?BuDT8Uk7oEhNZU7Y4uThuYady12MG09K4I98IVvsqEDzdxIJSaDHEWFCcEPr?=
 =?us-ascii?Q?FahnBbOjjw0W0BOCzyTZ7D7QD5sI+xz3ErnBjM0RlaZeBCHnM0Beol1WDxGx?=
 =?us-ascii?Q?k0zjT9Pcvm46mhYo1W9znKLJnLeHeNaqixdkYD2W/rT1sLxlxSYwSSI7zVtq?=
 =?us-ascii?Q?Dfiq7cJPPUgdR9VsUXgbA37bIXLNFYWK4Pu0+fFJG117r3HNgqQcZh1SoFXh?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7402a26e-7ff0-43e3-30ab-08dd4ccd2797
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 07:56:57.3689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7POxzBI2Dndk6+6+dcDe5Hgr1ULoW5NqSIXN8GHYjxEOq3Ghcq50gQMXUOlhRdvWGaPb6iMIyPmLw6OsfQiTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5076
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "hwsim.monitor_iface_multi_bss.fail" on:

commit: be22179cfb2fb1164004b70b33a4bdf67e6dd349 ("wifi: nl80211/cfg80211: Stop supporting cooked monitor")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 7b7a883c7f4de1ee5040bd1c32aabaafde54d209]

in testcase: hwsim
version: hwsim-x86_64-c8c7d56a3-1_20250209
with following parameters:

	test: monitor_iface_multi_bss



config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202502141548.e1f3f465-lkp@intel.com

group: group-31, test: monitor_iface_multi_bss
2025-02-13 19:03:55 export USER=root
2025-02-13 19:03:55 ./build.sh
Building TNC testing tools
Building wlantest
Building hs20-osu-client
Building hostapd
Building wpa_supplicant
2025-02-13 19:04:19 ./start.sh
2025-02-13 19:04:21 ./run-tests.py monitor_iface_multi_bss
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START monitor_iface_multi_bss 1/1
Test: AP mode mmonitor interface with hostapd multi-BSS setup
Starting AP wlan3
Starting BSS phy=phy3 ifname=wlan3-2
Connect STA wlan0 to AP
Connection timed out
Traceback (most recent call last):
  File "/lkp/benchmarks/hwsim/tests/hwsim/./run-tests.py", line 591, in main
    t(dev, apdev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_monitor_interface.py", line 53, in test_monitor_iface_multi_bss
    dev[0].connect("monitor-iface", key_mgmt="NONE", scan_freq="2412")
  File "/lkp/benchmarks/hwsim/tests/hwsim/wpasupplicant.py", line 1181, in connect
    self.connect_network(id, timeout=timeout)
  File "/lkp/benchmarks/hwsim/tests/hwsim/wpasupplicant.py", line 524, in connect_network
    self.wait_connected(timeout=timeout)
  File "/lkp/benchmarks/hwsim/tests/hwsim/wpasupplicant.py", line 1465, in wait_connected
    raise Exception(error)
Exception: Connection timed out
FAIL monitor_iface_multi_bss 16.01182 2025-02-13 19:04:38.106277
passed 0 test case(s)
skipped 0 test case(s)
failed tests: monitor_iface_multi_bss
2025-02-13 19:04:38 ./stop.sh



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250214/202502141548.e1f3f465-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


