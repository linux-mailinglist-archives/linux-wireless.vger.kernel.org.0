Return-Path: <linux-wireless+bounces-1290-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3F381ED02
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Dec 2023 08:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA2F8B22212
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Dec 2023 07:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4E15662;
	Wed, 27 Dec 2023 07:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OyT8NeIi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB515668
	for <linux-wireless@vger.kernel.org>; Wed, 27 Dec 2023 07:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703662893; x=1735198893;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Y6KXf8Xe0BQhkoICw1St7sGpIT0w+QGZrny/EOUWXDs=;
  b=OyT8NeIisE8VuxtCIahXgo0nHidv4idlUjvT5HeiaDBoTPHEOLOO77rt
   4cLm4r13APupcITx7tXTF5wbTT1yiYMbW+PmSM2Nd0r/CDdNpPND/Nir6
   AMlDIFIySRWlkYG6hr4lMdtXqnF97r6OFbGFJzrfX+ALODMUfsOcWwM0o
   Ep28xJ5Fb37Frsq6POVw9J3ZlCRnhbTwdW+6x0yBHac9FGmuqLvO+8p+l
   C9lRlzGoSBnEfBW5gNYrwz1w4XxwfSIP3cJrc7aD5ExNXILqEj5TbkqAo
   yUixnRIjKpoo6GYEDP84qRGUvJ9F8pXbH3j1m4/5wPfzt9M5chuXuHFkX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="3255074"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="3255074"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 23:41:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="1109567791"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="1109567791"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Dec 2023 23:41:31 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Dec 2023 23:41:31 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Dec 2023 23:41:30 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Dec 2023 23:41:30 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Dec 2023 23:41:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDdupHOQ++ENaNKY6vy8OoON7uep8Git3PMOo6Vl/AsmT5XAnkkPvWp2BwNWaQx6lSx+eAQ4y6mwu5p3PzEhoO1arsNvnryC6odUdHhIILde1jkUbyY7CEe1PUsEEVeiaXBBfLEsAaA16R+jMsipgsvBERD57EifNaQygRuTVPZgxVF+qb/JzGkiEne4aKWdtwkpUdOMjWqWHi62rX4eXhO653tRZn2jdOR7/u+ZDmuz7OaicKz4n0C5HpkvgJif/WqsAZ3LbCToqrdUEk59U2NWVS0hn3ZpthIvrT1u/OGeg9SD0rbQbxr58/5UQcwJLqHj1MyWEWXXASlCwEeaEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqE3g3vusqaqnxJwtb1u6GQCN3QpYReZB2oYVfe0Xi4=;
 b=av/PuPB/wuhHOHyQsSM9qt+AAEzj6JIO4cHo7P6rXhk4y6p3QTBe6zaQkLNx/iF7RpTohh/DkA1OR++oLWOUrB+5nQeS1XPcr2hDCOiVI1J8zWu+ie+9+Iy+WIfFyAqtQO4Ij3BRBb3fmqQO1pgcTSRFTD+2ICXSR/PFwsnM852aziwi507NhRP2qVfOsgt4U/+VexEGcsKKa8dgIWahrZNgmufYpyx/ZitshyNtoJwVlK5fb4UBaAWZpxEo2uy4daoG0P+9QXmJoz9rkZ5FwgV8s6SQ4Pi26UiMVZHaTj8dkkdUCR4aEuS1BsdZeIWztJYt0flSYA9x3jTUx6qNWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW6PR11MB8411.namprd11.prod.outlook.com (2603:10b6:303:23c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 07:41:28 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 07:41:27 +0000
Date: Wed, 27 Dec 2023 15:41:18 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Johannes Berg <johannes.berg@intel.com>, "Gregory
 Greenman" <gregory.greenman@intel.com>, <linux-wireless@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [wifi]  ce10e8653f: hwsim.prefer_eht_20.fail
Message-ID: <202312271555.3fbe1cf4-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SGAP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::30)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW6PR11MB8411:EE_
X-MS-Office365-Filtering-Correlation-Id: 21bef382-22dc-4131-f71e-08dc06af3b72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mlqExrvHPx+ofKi95YIPetRzcfWq8UpJXn24yiDME9fCSIelf3TlIfZJb07LLc/rB1UGIO1fteObYKQtllmM9v+R7LtjZbwxDIsxK+wvX4eHkZJlyczY80rlkD9QR6baKLR9NM8iU+JIBCwKQNGXxO/Wsl8h1CVT0T/p0A/Uej9EXN5z86BnYhKbxylR9ZiVnDo01CgzrZ/D7aKEE1qPcNayDQj0yOYJrxG5EgmNy3N7SIG2Ivb+isGLYSagJ4a6sGGl0/mvaDPDAzGleKmq+iefvEWv89LUY003Ng7BELb0+axOjzdZNzdVnf5QRCx9v37G7KCx4rSDoLY2nkqQy9CXob7OuEdAAlPff1KmNQx0ZWhA+qJl4i+kZEoMLhdvKT6Nb6x+OlRoqWk47WWCAObhb1xVxdll1IWjoI+rzblUokPbgVfLnD4KgipRRdN0oMRzN6jzxUiHblQkASmBibYbzEdGtgDHXt0piEoNplbMtvF7qUHW13IEuBvdPseh6My4Mc4n8e3xLJneMoQWa2R3Z8ponmVjaolqWjSYcDbub5EoCyhSfSO4X5ATnUusWjpyEBm69xnKYxf3tV2/DQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(39860400002)(346002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(41300700001)(2616005)(38100700002)(26005)(1076003)(107886003)(82960400001)(54906003)(6862004)(8676002)(316002)(37006003)(4326008)(4001150100001)(5660300002)(2906002)(478600001)(8936002)(6666004)(6512007)(6506007)(6636002)(66476007)(66556008)(66946007)(6486002)(966005)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sYisbOiTQewnRKKgZdtU3PLIW/MAZm5BxCrrgRANd/8g7sX9vbDhpr2BeHv/?=
 =?us-ascii?Q?ecSxUew1n7EuKsiRxmfgvim3iRreZiB4zGZCmfwfyhoupPMOu9/FkA/xH/BH?=
 =?us-ascii?Q?jhi//NphSXZqM7d4Rr2x7XLVEpzK8nXjSyztbsi2wjmklxufqFVnQXuz4539?=
 =?us-ascii?Q?zD64bFGcoiPO1Mm6y3xe04lo3gjg+n4wcsOfkqKA7VqhQCM50dwCGF1Knhez?=
 =?us-ascii?Q?4n4VSj1JhnNq1w6ZC67U2a8tEKECO1E4ZJMthbIxgspv3zKIx6Qr8+eS3avX?=
 =?us-ascii?Q?M+7sMDdneWW0xUBuHLYMjWuwTyUV0TyBDNFHsB8/whcDltA9ZvWvBI3umDJn?=
 =?us-ascii?Q?62fG2xaLzIv97YLpnk1NuyT2Wsg6Kr0BsGFGCxoYw/n/rQTDHXRPbiBY7TsW?=
 =?us-ascii?Q?PvE+8CCn4QN8g6T9QAhXwMLDySE1XWJg9IiUcE+UZ1Ly1JTV1tnnWtsp4tRF?=
 =?us-ascii?Q?FeQxa0KJhzyWEGMztk2AU/cDaQ/Z+mDeQDgSMuZyFsVDVjcHhhziBFcenqtd?=
 =?us-ascii?Q?sxPA+7B7jW8SoAvF67QnnmEmlwZuiCcaCt7Com3Tc7DkVw9nBKTEMEX4OYi3?=
 =?us-ascii?Q?KhhEvp7CLzAejMBtVnWkc4OH/5i2XFMpIi3I4UXbiKi9I1ajfk1aT51RNzZe?=
 =?us-ascii?Q?4gXzQPwGm9fTXjm0e/yDZnJw/vckU7VTPFWr2xLobNzAAwGtxvEKbvSU2eOG?=
 =?us-ascii?Q?vMo4zrMuFSe1fNAyQEON4yMfPZHDA2BNRkuRn2CWw/5K3m4oKa2gI2K/IKyx?=
 =?us-ascii?Q?CY/7vhg8vpdfBAvbYJ3VDQSBR+Uez9GdXmlzvqmzkCk5Rw1kSvbZ81tRcbw5?=
 =?us-ascii?Q?vC2sbs0ewNKisfn7F5mCNurEgkbayN4jZdqRApHy84cdYjyGRDTrdZ+Az8Xq?=
 =?us-ascii?Q?fE8EYiHcA00J+icReBK6nq7pygHZ+GAwMR6JIWuG6035Cqq1HD970zNBEjcX?=
 =?us-ascii?Q?q8QGjkYKi9pxBV19ZU3lPUNJveYJTEoqbKoWnyN/2p0aXRD4rP7yIC70+k6M?=
 =?us-ascii?Q?Skvt5PF2yV2mIZ72vo+RXprGC4ufdTbx76Svqy9brTbLwnayZlAHIG6U54N4?=
 =?us-ascii?Q?X6Mlv73Ub/Oea6YhzzpJ+QxhyE9J7Hw8AHH69YWADfccZlxtma+IU4Jovu9k?=
 =?us-ascii?Q?FjZJbWi4PS2DppR7p7gcL8zpiCa8fnNaz5s14aCmTqQGB2JTtQCmb9A4Uy2H?=
 =?us-ascii?Q?h0Nhg7J64E1bpKmOeNoRACUaMkWheD/m+KAGVhgkLEzgRP3FfUrFC9r2RDXK?=
 =?us-ascii?Q?9tcyCABH8KT1m0MSHJE+81wy+AmrEYbEnfLx3pQREhyDW0PapLlTSfF4axtZ?=
 =?us-ascii?Q?Melu5oXZCEiCgg4C1PkUMWSnpxlcNKHu5BF2acBiTHXuOHpKY0Vm8TAnlqsE?=
 =?us-ascii?Q?ZYyPlV99Te5CdTDZTgBeHLAU17B+GZpdN1M4L/JFVe4UK6KhcbL+DmD0dM+B?=
 =?us-ascii?Q?YAmQcCvuhchz5CrWsIOpACA3dGWTVLf2JMMMzwdXqViQ2ezOAs4kg3ZYUX+5?=
 =?us-ascii?Q?/w1qCfl3MVGRr60S8+DBeXrKyffcs7iAnAULI3AFT24mTlEwqtK8M0gTIrZH?=
 =?us-ascii?Q?D4uJzUYm5cpB5jyajTw7af/8f1Er9v8aNlfMNGKgrOR0b/KGFToD1sQ82PXp?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21bef382-22dc-4131-f71e-08dc06af3b72
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 07:41:26.6933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RHC5v2LP7JoHsK7H3ms2ootonUVmCAmgC5NABIGzs3SU8zrUx1EcttdTWt55HWJSbm14JAqXyDssl7jvCbl9BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8411
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "hwsim.prefer_eht_20.fail" on:

commit: ce10e8653f8b6569ea5d4f96917b5eaee7437072 ("wifi: mac80211_hwsim: support HE 40 MHz in 2.4 GHz band")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 39676dfe52331dba909c617f213fdb21015c8d10]

in testcase: hwsim
version: hwsim-x86_64-717e5d7-1_20230720
with following parameters:

	test: prefer_eht_20



compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4790 v3 @ 3.60GHz (Haswell) with 6G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202312271555.3fbe1cf4-oliver.sang@intel.com

group: group-24, test: prefer_eht_20
2023-12-26 11:11:56 export USER=root
2023-12-26 11:11:56 ./build.sh
Building TNC testing tools
Building wlantest
Building hs20-osu-client
Building hostapd
Building wpa_supplicant
2023-12-26 11:12:49 ./start.sh
2023-12-26 11:12:51 ./run-tests.py prefer_eht_20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START prefer_eht_20 1/1
Starting AP wlan3
Starting AP wlan4
Connect STA wlan0 to AP
Unexpected BSS1 est_throughput: 344103
Traceback (most recent call last):
  File "/lkp/benchmarks/hwsim/tests/hwsim/./run-tests.py", line 531, in main
    t(dev, apdev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_eht.py", line 108, in test_prefer_eht_20
    raise Exception("Unexpected BSS1 est_throughput: " + est)
Exception: Unexpected BSS1 est_throughput: 344103
FAIL prefer_eht_20 10.95756 2023-12-26 11:13:04.037058
passed 0 test case(s)
skipped 0 test case(s)
failed tests: prefer_eht_20
2023-12-26 11:13:04 ./stop.sh



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231227/202312271555.3fbe1cf4-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


