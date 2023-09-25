Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AD57AD285
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 09:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjIYH7d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 03:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbjIYH7b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 03:59:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D486EE
        for <linux-wireless@vger.kernel.org>; Mon, 25 Sep 2023 00:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695628764; x=1727164764;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AneeSbmy4MmpBWu4g9Gca8bIV/hoyReEvp11TFYBx/Y=;
  b=imBY3GYWiIVAYbqlQDk9kBKeHZnyyqb1HGZF5HIoLQZkSjg9YuKeoBra
   eXE+vY+AG4iuu1pmB+HOvgqsj98vTxqMHqFf4lQecl/F3M6yLE0kvGal9
   c++Us6br2KdWA1CPGutRCIb6gyH5RqdnZR7K0GxZC9ZgJzi5o9CTBgz0w
   cAXPXauilKGgS4558sJRd5aaTbBgVp1APYezYo5Pr+7wEQGHbxKbik+wb
   fvqPGXCHALuFEKao4mqBex0JC60upTvfb7QcLy2/sAhprS3lZ0ctnmeVW
   H+r4xOFr2y0wUoUvWFJYP+RBh4S29SX+26hfDCr3C6SFImYcIKcxNetgL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="380067735"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="380067735"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 00:59:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="863774224"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="863774224"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 00:59:23 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 00:59:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 00:59:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 00:59:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 00:59:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMFWPDdrKomMch1ydGugbYPyMsnDIknYG+IPgN/pZl1E5SQJPK0AVmJOhKrvf6fMhytOl9tkhkcJZNgticFhZ0d9nxOYWCxZ6gooH+gfsHoKfTt13j0g21yeD4ToZ7UTxhqRwUq9v9dI+4G/7UOKoGrt/SVzkRWYQ6ABV5i7wLPgY4Okvym+FEs+uHtZ9WxKBdTXnAA51v7tsoVldP8Lj+Zd+0iXnD2nGaqQh2FMglRu1nK73/JpfuEPSV2OLf/81nP5x6e+dZju0KcHQj9UwejgId09oFqvPsD3bOQCaquyN50Yu3G5CtWaxThGFZnTnViaLKAqwDtz00yUtGS4Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8D2n8EGrSaJ6xV74P53nmwL+ikFHQuusEup4ZFxdes=;
 b=UZ10H502fiuz6jBLxpxXQIMJMVXGolCZF+zj5NLqmS4ZHlpIK5aTf72XFre5PAfZ4s1OY0BR30IAglkl+WZu1MM5o/Y12YuURc7opbEASpZTXT9K1zR30RUOMTCardch6Vs5tlMkj2kGzhSdvaaSaKfsyEFZd9WNCiC82+1gNLQtR7r9t77s8kba0PH9+nRe0TW5uqCXIQ32rjvKVvyj9mveVP6EQebVERUqUARB8lzez36PM5WgEtfT+3caqW8mjjW8VH++TC6V06hnBLqwkWs/nhfOu5NK5R6T90WPuPSeCrqDBFu4dXlmzUrZEzT0rYb1t/b81kxSy9yXRjRA8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH7PR11MB8569.namprd11.prod.outlook.com (2603:10b6:510:304::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 25 Sep
 2023 07:59:17 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6813.017; Mon, 25 Sep 2023
 07:59:17 +0000
Date:   Mon, 25 Sep 2023 15:59:10 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        <linux-wireless@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [wifi]  97c19e42b2:
 hwsim.dpp_test_vector_p_256_b.fail
Message-ID: <202309251502.aa08a357-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2P153CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::6)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH7PR11MB8569:EE_
X-MS-Office365-Filtering-Correlation-Id: c73f5a02-efe4-41fd-ce5c-08dbbd9d5114
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s2hfHJgZ/IIUtP6WAUHvvWwX4cupddzMsD+j4tGP+FPB90eS6ol7hwPL1vZ33qSKzHA7JqXTf3AueZYlsB3LCYJGfvwpWE/mSP1ZJMlPSCQls0eou80Yi5n6gs167h8cZQ/w1AYbNA7KvXukeiKBw9pw8cmLfsqLbY00Wf4ZxqgRVQ/TTifE5IsuZt4PiPBQp5+klf6FPGulq4Sqepv2jbe9Fl0SZIUbS9KV93UhwDXeBoqN07pE6OK8Rbt1UxNFxgO03jmc48noQBfpv78Z1EEEysa56o4yhQqwyLhwisSBmw6Xnwm6843ox34bbOxIEq/qTRcGbfUZP5Sbn1dAQFkYgWms3VpxoH4FDWgAMo7MQ9gZ30F4KPdFijb5leScuzwYwtA4Oh4+ZZgRVcpCgYUEZSj1jYlw7EdPsxL7Wf4yZ/AepjGyqSKygcEUuHZGlInMfuUJ7OBOS02Osi+WvRFu2ZZW5VVJVET3c2xvQy9I8nkhFBJYHPwXR136c3FYdovt4UEABiPmsSgXt2sWo8G9Xy7XRvmZYMFvYFoODk2INn+wu0ASVMSOrh+BZEqVy7OXsPZqYMYZ0Re+c4ID7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(376002)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(83380400001)(26005)(1076003)(38100700002)(82960400001)(2906002)(966005)(4326008)(478600001)(8936002)(41300700001)(6666004)(8676002)(6486002)(6862004)(6506007)(5660300002)(37006003)(66946007)(6636002)(66476007)(2616005)(66556008)(107886003)(86362001)(36756003)(316002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q+h0uBfY8qsrV6A9+8OO5yCif8YkhfpdGNRnCn/Dlc77KfNTBFodgcT96wLd?=
 =?us-ascii?Q?ARbjLHfCKyvctROwbdaFHkVh5+V9xlYKK4rWFt1xhDZCeoABTNCPGHtAg0sf?=
 =?us-ascii?Q?mFQP1vb9K6OuFnbLyob277gO6GScL5zQRFQ3e+xmSrbiwGH4aLsbdrwDoxVu?=
 =?us-ascii?Q?um/DOuBfr+ElC/4FRoU9pys3H7rzCPm8rB5y5SnpqQfGiJaxS1wYPaHK167X?=
 =?us-ascii?Q?g09mcBPzbjdgWLR5mh4DFh4dBnDP8/2q3ghmcwR3zuWhf3AwBMRDan8mrLjW?=
 =?us-ascii?Q?yhkCyBWcR8KPqtek1lE9ih2yza9ZSu8Qt8VWFE1gWLJP5XfTjgV030neDt2f?=
 =?us-ascii?Q?r5oFnXxE0d5ieCyJzyOnBgPZlQaqOiTbFOsFWpewiSPhkP6gSE2ZZzuGIUd4?=
 =?us-ascii?Q?JrzYtmvkqHjIltmGUu5qH9C4+WlEJjCNboHCPQ+DgbAamkmY46+X+fumHaR/?=
 =?us-ascii?Q?f2iScQN1j4XqmUmk9s4Hk0mU0v2Rh73/1sKERuakop+Tb9/6c5yvSvpGG7qa?=
 =?us-ascii?Q?aLtI6oDtVlKuSy8lVSNicDhZxRMC9fJLfo2aL3kWltyo9zB/4+KJaPz0P3H9?=
 =?us-ascii?Q?mMvxtW4/sLTwhIrkzCB/UbrrAKWBUFqg9f5oroLC44q/+zdZ+35e9s1QInBw?=
 =?us-ascii?Q?b8M1aK6303qdPZ+ZcZNOErbYEfFfJuNR0Y1Rr2aFYpZhyNcqZppEtSdVI7I0?=
 =?us-ascii?Q?o9q5DLiLOTwaLd/1AAZGjPkKo0DCB04qaK+77w+OrD/OZ8QtCSwkXGFkVvLI?=
 =?us-ascii?Q?jnkRGCQLDEcIlinjaCZf7SfL6Z21Z6wfwf+/xhNeJ1yIa10jjOveVsr7SCWT?=
 =?us-ascii?Q?8PF9wutCahI/kCAG1OTZb1X4+QYza6FQr/xTL7bGCdqCY3hmZr9wgezeVCJt?=
 =?us-ascii?Q?fmT2a2JXQYqzIeGi1or6SQqclO3og/cXojbn0jfmP05mDqhmlTaJ/ENXH3DK?=
 =?us-ascii?Q?u2faMdYcMGm8lxZje2vxXzHJe4Rj54bqC1FkBexQrU5tCYA1FKX+d8wZdjJC?=
 =?us-ascii?Q?i/wTkKb0NzkM7krphfI39zrORp2ZND9SDrijTPx4+4mQiX2CfH28Y8wYBazx?=
 =?us-ascii?Q?WEwbDcwOaYj17m35/Crk/xvVGoRoLoO3Jceqjwi3/PRLwru6erIGUb5i2LCi?=
 =?us-ascii?Q?1B8oksJF+SoK+vb9vItPOcsv0nPWYKuof3ZwNlKtwrMFEv7DELBy76aM7BFV?=
 =?us-ascii?Q?TzZ2+2GsPHChlA/HYVSIV0FKTLw1ZBMMyL0wPxqMvnO+K6AI4kmz1OOZyIPa?=
 =?us-ascii?Q?w/t8mOwf60poD1Beehe5H72vhuLKo7q+XWGsfIIXeduddMJs/lVlrlU11Aum?=
 =?us-ascii?Q?yH+GTCkdpX9xvWKXsipSwcgbI5XbTN5v2fTR12tra6p8KJK787jgLfLwHm3a?=
 =?us-ascii?Q?nA3ZotdFZXYXnSfW4ykKmTLBZtVAPeihqFOg/JWg5eKsUUGuez7H3lHhTfZf?=
 =?us-ascii?Q?6KCaTk2vjw380Wn8gSNXYBthCZa/XIkiWne8QBhWpI9vo9xRLqNar1kCWKrs?=
 =?us-ascii?Q?xkoBaABRLptHUrcIbhOkKfkgSZ3QV+KFCYlu91hBicx3XoALN9TaZBycEubx?=
 =?us-ascii?Q?jiF7D7dBS2Z3/RB2wj2Fqwz8HcBcnWbOkva+oPUmbrEkwbQVwCipClSNCesM?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c73f5a02-efe4-41fd-ce5c-08dbbd9d5114
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 07:59:17.3691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XO6QIT3uqkMzpPKgNFL2OC6I+/068QXR4pkrXpH0jFGlN966tusrXY37rPzE/BYmoPcELbrNjnanC95LIqXeEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8569
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



Hello,

kernel test robot noticed "hwsim.dpp_test_vector_p_256_b.fail" on:

commit: 97c19e42b264e6b71a9ff9deea04c19f621805b9 ("wifi: mac80211: move offchannel works to wiphy work")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 926f75c8a5ab70567eb4c2d82fbc96963313e564]

in testcase: hwsim
version: hwsim-x86_64-717e5d7-1_20230720
with following parameters:

	test: dpp_test_vector_p_256_b



compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4790 v3 @ 3.60GHz (Haswell) with 6G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


we found the failure does not always happen, around ~50%. but keep clean on
parent.

730538edc8e0eb14 97c19e42b264e6b71a9ff9deea0
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :20          50%          10:20    hwsim.dpp_test_vector_p_256_b.fail



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309251502.aa08a357-oliver.sang@intel.com

group: group-34, test: dpp_test_vector_p_256_b
2023-09-22 11:50:05 export USER=root
2023-09-22 11:50:05 ./build.sh
Building TNC testing tools
Building wlantest
Building hs20-osu-client
Building hostapd
Building wpa_supplicant
2023-09-22 11:51:03 ./start.sh
2023-09-22 11:51:04 ./run-tests.py dpp_test_vector_p_256_b
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_test_vector_p_256_b 1/1
Test: DPP P-256 test vector (Responder-only auth)
DPP authentication did not succeed (Responder)
Traceback (most recent call last):
  File "/lkp/benchmarks/hwsim/tests/hwsim/./run-tests.py", line 531, in main
    t(dev, apdev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_dpp.py", line 2583, in test_dpp_test_vector_p_256_b
    wait_auth_success(dev[0], dev[1])
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_dpp.py", line 4878, in wait_auth_success
    raise Exception("DPP authentication did not succeed (Responder)")
Exception: DPP authentication did not succeed (Responder)
FAIL dpp_test_vector_p_256_b 5.350665 2023-09-22 11:51:11.790041
passed 0 test case(s)
skipped 0 test case(s)
failed tests: dpp_test_vector_p_256_b
2023-09-22 11:51:11 ./stop.sh



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230925/202309251502.aa08a357-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

