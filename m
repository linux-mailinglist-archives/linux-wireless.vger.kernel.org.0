Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098C25BDE13
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 09:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiITHZU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Sep 2022 03:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiITHZS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Sep 2022 03:25:18 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8235C13FA1
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 00:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663658709; x=1695194709;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Q0Cd4n3au2Pn1ds5dFxHa9paIY9TQCG476roZHYn5SM=;
  b=FBV2aqmOz1x+9vUkJZM70IZbLff5apQgVc5DeiYgPNiQoJALI9N2zROu
   oMdkQ4ixZ0teShhkRhlkdJhoYIblSiqesS+H4RkAJKfR3RXu0bIL9I/BG
   eVEYUYrkYOdNpdfmZWZcQz0vGfIiGLR3BAQ+w6ICyRHUJlKN5x3NzrVe1
   0OVxA3iEoV2di6EHZ+Ca5sX5pzXLtH6rydiGaQ1Z85anCsu29NA4ZBlgt
   l9A6o+j48yW9iTFnlOOppmQNtiu9Dn/zt1nUk91D2soH42hiy9fiRXc3b
   6URk490NbumZeTPSeumY1u2Si1/A/R9Em0Fxh2JnHbd/HobhZbOxGlpAz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="286669166"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="xz'?yaml'?scan'208";a="286669166"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 00:25:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="xz'?yaml'?scan'208";a="651990057"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 20 Sep 2022 00:25:08 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 00:25:07 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 00:25:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 20 Sep 2022 00:25:06 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 20 Sep 2022 00:25:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEc5VS6C+I8Ol72TqLa4AWVjj/Ee+rltGI/6OvjnClfJtALAiWO64l7nTKH8UfjbpyYbAGY8MyAG7uMEIQZ85a7Wrjf2oQuWJp4+d05KAvSj1YcY6LxEeVZicmjaZo06CrcJCAHVx/PeawgPK/oeTPz5BlKBBPSK393dKR/fSTKnz1w10j8jDAFDu7rdAfbyMseUi2/ssZKfEkUgXvFFdFgIEeZqGHGNIGByat8/dN8yE4nUyRL0s5862ln1gPYAG5Tu51ZLVFKwP7g+Wx0es8Bu3BSbjpzoZlpGp8IIA3L90zDSO+Vmcen0OirB9IlChpinCnqjfUSVmfQ0zF8xLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDGEIp8yVOeGvHKsJrQT/AW5VrsW6BBB6qxmEEJVpSc=;
 b=IP9ws6R/ecKkLiH75hyT77DSWubVZMjF6bICmvKBUoN/Gxc/0jqQDrb3NjF93kWaKjSZegQ3F7msSs+H3i4P3mBeYBoHHY51jlqO+n3UKZGtS1oXUOVbHoWPRZM4CS7xF5dtr+t/dVeVnvppZZ0OBq4Jt8n038OM8Q0/Z57RqlAmICVngAGpKrBnnUXAk0nv+dAsFSjAwEAOsivemQA1qtU7sIHgwbAQXrXiwJdaKrOOh/Ri0V3Ogd9G+7Rq61jrtzCefMIEXGm6thn6Fv4ie7WpA6x5FSyvvHqnpPeqnbMrP3uLhjlE2+4Fuq6tf9wN3FVJKgFvGOSAlO1hPQsxCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by PH7PR11MB5767.namprd11.prod.outlook.com (2603:10b6:510:13a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Tue, 20 Sep
 2022 07:25:02 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::29b5:b34e:695f:a169]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::29b5:b34e:695f:a169%7]) with mapi id 15.20.5632.015; Tue, 20 Sep 2022
 07:25:02 +0000
Date:   Tue, 20 Sep 2022 15:24:52 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     <venkatch@gmail.com>
CC:     <lkp@lists.01.org>, <lkp@intel.com>,
        <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>,
        Venkat Chimata <venkata@shasta.cloud>
Subject: [wifi]  662cceb50e:
 BUG:sleeping_function_called_from_invalid_context_at_include/linux/sched/mm.h
Message-ID: <202209201552.e4f42742-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="2BOLdwFwC2i4cuCA"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220915043527.737133-1-venkatch@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:3:18::19) To SJ1PR11MB6297.namprd11.prod.outlook.com
 (2603:10b6:a03:458::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6297:EE_|PH7PR11MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: dccad9d4-428e-4602-de70-08da9ad93adc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dreDgsEOH7Oj84Yt4gvnC81eVNnyjW8PzU5Tv5gQmG7RdxKdergHTQmPM0+Wj+/ijBpg/zOrIAlv5gXmUXUKlys8+KEJJqba86w8rufpSmjlZWtRWlbbvKHNdsxLFww2yEweJ44PGqD6RMNNcXJcdIqlBH3ttFEPZE5iJyyh5wn7N39xUjM6GE1V6utPQW7i4RZe1XWDknQMkQ/IWHTf4RoeNZlVqqSeMpDmWTkotFmLeUrtEVcEX5pbPl7u+gYzGo9NUuWQQxveqYA3I/FHkVfXAes0oQ4VWw0PFJwUIObm/dkAtmihZdeJBDENU3s+szkKKSMUQFT5t94oPhDRLpDeZqXyOdhtI0K7NZLGBIvZ6mYp1TVjw5ggH/UelybcXFqcGWYSDSageOyaoKJWqkhWJADLAE7wx84ijiEHW4l6NXhjNYgAYyXyABKVLTBW+CtqSrOU1dzd+RnmjYURSSeP3OaVlIM7DsPwITj+fzysPHmro6J5XLAQL3kDznde9H/UZ6PgF59TD0wSkCXs9agXS+WhwCyNvAlKu+ofHOGJfsTm+4hX3ZQBwK6koOULKEZN2kN3B36Ue57vP3/O0n4YkFmnZ3+ChEnvO0UXRjk3ormd6brXhsWurNejZCgDEpuR0p/TkjUvSSMvB5hsOgb8ppZqsttTqZSZd4IKYEao6g1NYVQBhvduszeOj1knJa/2ToRof+HJUCmbVnBNNzBU+OO5Z3/kyWvGxHMbHTBBj1RdhwRyoriTbDj4o4+qUVaPk0AovMr2PSDzLWwVWhCQ6ffUY4yQHrtXVRtpczFOHyZeNCRmAhGCIZYwNje996O+KmgipmsFPgpzVghDlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199015)(8676002)(30864003)(36756003)(478600001)(66556008)(186003)(6486002)(966005)(66946007)(6916009)(6506007)(33964004)(86362001)(44144004)(26005)(66476007)(4326008)(41300700001)(8936002)(6666004)(83380400001)(38100700002)(82960400001)(5660300002)(235185007)(6512007)(1076003)(316002)(2906002)(21490400003)(2616005)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qqQRO9HAusKHlOY+ud7TkmwPpC++gi4SwbfVkAPQv1H+8ZVhQjtEpIBC4fLX?=
 =?us-ascii?Q?ipKtq8xGzIdFA5l6osa9A9bybrpNl2YCfEz/k5M8mihNuFOlrVB8YCj27xfZ?=
 =?us-ascii?Q?2TsYyDRoRCiZ1EeMBrDyRDg9Gb1eZfFCqofunDCA5mYaNchF570+ul/g+6Lt?=
 =?us-ascii?Q?TEj6QsP86eSLq1q0Zv6H2EXOGMEX4d+B/oUEblD8FeolZEv9DFtL+Idk3ppr?=
 =?us-ascii?Q?81Mx1mESyDFXn56J0PrflRHfiXUJqLxA5n/IQckxUZ8dAHJ7gMdSrXpIHzTt?=
 =?us-ascii?Q?cIqCqwi/jeRsl+8Vvh1Eng5WgLVPMhErMDxwQP8wfdl2aJ6y7iAjUPqiSXGu?=
 =?us-ascii?Q?tciort3Xl7LypAgD+FLcy+p5q/qZdLoXgn7pDrTMur48FIqulipezuyzu5QU?=
 =?us-ascii?Q?APgeAWKJrcp957w7tKixaR6AtH61QrSGGpqN2zrCp3SmZ+S8SEpPvwXXxKq8?=
 =?us-ascii?Q?wcPOikjHwayhYfQJeAFcpDQXl+tXDIoMsKKgwF33yGKh55A22H8QqQ0XTctN?=
 =?us-ascii?Q?cDUsEqaDkJOVmZmZ8VxiZl+J3eG/jw/U8hn6M1njnCq8JDtsKQKv8Ox7arO9?=
 =?us-ascii?Q?nVQbqF0/w8mZXzlDYNBTqGmLQAEFV/ycmLc56L5y3jBotn5YTkW0w375RmOf?=
 =?us-ascii?Q?byG3aWOxed5scKS2km1brY/G8Ua8HVEIbwH1wn5X+DTOTM2CflQuYL4sDiOZ?=
 =?us-ascii?Q?KnX3nQYkVSqjATzWwl+lTFQmaRzqgFBmiiiDkynD01SHiKEGj4t9Lzupr//C?=
 =?us-ascii?Q?GmxuoehCfG+m5lnw+7GutR0UA56aGbQtCFgjcpjVjd6psR+6TX+OkHJCFHSY?=
 =?us-ascii?Q?oVCTS9iAOT9/wA3lv8JAESXLwIY/N02tFv/AlWlzmCDk+ArOVOjGC/C1qHoN?=
 =?us-ascii?Q?k9dJJpyz8yqANyxmo430iduudRJDulLJpp8HTl66bbCvvFi2pyAyqwZ14EQb?=
 =?us-ascii?Q?xv0n9SSTdXwu96H5yUYJcop+e9Rs0s+Sif9S+sU++NN84emou91ivxuidYuT?=
 =?us-ascii?Q?6oOrxdAEswpsnLVN3PNQKWwldur9K1lfGRetHPeAF4MhUtvsukYQ3tjpcfEg?=
 =?us-ascii?Q?BeWrAPczHESWqJ4UKzsG3Eqm+ar0bzj4wT+Dh+8VWLxhsoQmCIhXl2txnMFN?=
 =?us-ascii?Q?LDp7shxnLnVjRyRrR+fzyE19YxoM+TGPWb2iKiEzNBA27CLXnCNcjz7g9Y2S?=
 =?us-ascii?Q?Pt3IgZknaqMb85maqfZ+VAy5BdFupGRvNWt/d2C/3Qop53+HICTo0t4CIoci?=
 =?us-ascii?Q?drQdplXnHCunR7ibD/fCpqY1jo48U2e1yZtOQj2fH56adw3YbXX9WAlOMeDx?=
 =?us-ascii?Q?0Hb9ykvU5o6A+OVLMRxT8Ge1q1yvF/ITlvBuDft4jqbEVEKiZWwCVlC2xs6K?=
 =?us-ascii?Q?v9YrqGSFrOhJiCZ/DBRnJyccawhP+S5ijagXUltUkKQYzd1HLXoby1ZSkv4R?=
 =?us-ascii?Q?4TjoLefAOcuq/FL0J9NzjcMoqjzfMGZrPu3oHRfKw8d2tbhRGN/FejNZlOoR?=
 =?us-ascii?Q?sz5Q0HDw+HdGJ74r7KX7vrpI044GRt/bHsrbQdWXHlvgYhRlTJGVwbPA1LLE?=
 =?us-ascii?Q?6bdROcA/s1bmkDyiQohcAicuIUVr8qYZ6I7oU+nSDr+aHHyFUqc38eQL+uGs?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dccad9d4-428e-4602-de70-08da9ad93adc
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 07:25:02.1853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N1utoPf+IiYRH13SpAs1Yt6adFtlRMh9CfHRxuzu4U5yVULLzK9OanG8XMxQ1czrA0Jv8JMsavQ6cM+BMBokGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5767
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,URIBL_BLACK
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--2BOLdwFwC2i4cuCA
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline


Greeting,

FYI, we noticed the following commit (built with gcc-11):

commit: 662cceb50ea735492ff67b5ecdbc8d9de15212bd ("[PATCH v2] wifi: mac80211: Fix performance issue with mutex_lock")
url: https://github.com/intel-lab-lkp/linux/commits/venkatch-gmail-com/wifi-mac80211-Fix-performance-issue-with-mutex_lock/20220915-123721
base: https://git.kernel.org/cgit/linux/kernel/git/wireless/wireless-next.git main
patch link: https://lore.kernel.org/linux-wireless/20220915043527.737133-1-venkatch@gmail.com

in testcase: hwsim
version: hwsim-x86_64-717e5d7-1_20220525
with following parameters:

	test: group-03



on test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz (Ivy Bridge) with 16G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Link: https://lore.kernel.org/r/202209201552.e4f42742-oliver.sang@intel.com


[  103.595219][ T5052] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
[  103.595404][ T5052] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5052, name: iw
[  103.595601][ T5052] preempt_count: 1, expected: 0
[  103.595740][ T5052] CPU: 3 PID: 5052 Comm: iw Not tainted 6.0.0-rc3-00691-g662cceb50ea7 #1
[  103.595921][ T5052] Hardware name:  /DZ77BH-55K, BIOS BHZ7710H.86A.0097.2012.1228.1346 12/28/2012
[  103.596088][ T5052] Call Trace:
[  103.596151][ T5052]  <TASK>
[ 103.596209][ T5052] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 103.596297][ T5052] __might_resched.cold (kernel/sched/core.c:9893) 
[ 103.596391][ T5052] ? cfg80211_sinfo_alloc_tid_stats (net/wireless/util.c:2255) cfg80211
[ 103.596557][ T5052] kmem_cache_alloc_trace (include/linux/sched/mm.h:274 mm/slab.h:700 mm/slub.c:3157 mm/slub.c:3251 mm/slub.c:3282) 
[ 103.596655][ T5052] cfg80211_sinfo_alloc_tid_stats (net/wireless/util.c:2255) cfg80211
[ 103.596807][ T5052] sta_set_sinfo (net/mac80211/sta_info.c:2651 (discriminator 1)) mac80211
[ 103.596956][ T5052] ? kfree (mm/slub.c:1780 mm/slub.c:3534 mm/slub.c:4562) 
[ 103.597034][ T5052] ieee80211_dump_station (net/mac80211/cfg.c:864) mac80211
[ 103.597183][ T5052] nl80211_dump_station (net/wireless/rdev-ops.h:245 net/wireless/nl80211.c:6565) cfg80211
[ 103.597330][ T5052] ? nl80211_send_station (net/wireless/nl80211.c:6539) cfg80211
[ 103.597482][ T5052] ? __alloc_skb (net/core/skbuff.c:448) 
[ 103.597568][ T5052] ? kmalloc_reserve (net/core/skbuff.c:400) 
[ 103.597656][ T5052] ? __mutex_lock_slowpath (kernel/locking/mutex.c:282) 
[ 103.597750][ T5052] netlink_dump (net/netlink/af_netlink.c:2275) 
[ 103.597832][ T5052] ? netlink_getsockopt (net/netlink/af_netlink.c:2213) 
[ 103.597925][ T5052] ? mutex_unlock (arch/x86/include/asm/atomic64_64.h:190 include/linux/atomic/atomic-long.h:449 include/linux/atomic/atomic-instrumented.h:1790 kernel/locking/mutex.c:181 kernel/locking/mutex.c:540) 
[ 103.598009][ T5052] ? __mutex_unlock_slowpath+0x2c0/0x2c0 
[ 103.598123][ T5052] __netlink_dump_start (include/linux/instrumented.h:101 include/linux/atomic/atomic-instrumented.h:176 include/linux/refcount.h:272 include/linux/refcount.h:315 include/linux/refcount.h:333 include/net/sock.h:1975 net/netlink/af_netlink.c:2382) 
[ 103.598217][ T5052] genl_family_rcv_msg_dumpit (net/netlink/genetlink.c:689) 
[ 103.598318][ T5052] ? genl_rcv (net/netlink/genetlink.c:655) 
[ 103.598395][ T5052] ? __stack_depot_save (lib/stackdepot.c:424) 
[ 103.598490][ T5052] ? genl_family_rcv_msg_doit (net/netlink/genetlink.c:563) 
[ 103.598590][ T5052] ? nl80211_send_station (net/wireless/nl80211.c:6539) cfg80211
[ 103.598739][ T5052] ? genl_family_rcv_msg_dumpit (net/netlink/genetlink.c:637) 
[ 103.598842][ T5052] ? genl_op_from_small (net/netlink/genetlink.c:136) 
[ 103.598933][ T5052] genl_rcv_msg (net/netlink/genetlink.c:775 net/netlink/genetlink.c:795) 
[ 103.599016][ T5052] ? genl_get_cmd (net/netlink/genetlink.c:784) 
[ 103.599100][ T5052] ? nl80211_dump_station (net/wireless/nl80211.c:6592) cfg80211
[ 103.599245][ T5052] ? nl80211_send_station (net/wireless/nl80211.c:6539) cfg80211
[ 103.599394][ T5052] ? kasan_save_stack (mm/kasan/common.c:40) 
[ 103.599511][ T5052] ? kasan_save_stack (mm/kasan/common.c:39) 
[ 103.599613][ T5052] ? __kasan_slab_alloc (mm/kasan/common.c:45 mm/kasan/common.c:437 mm/kasan/common.c:470) 
[ 103.599704][ T5052] ? kmem_cache_alloc_lru (mm/slab.h:727 mm/slub.c:3243 mm/slub.c:3251 mm/slub.c:3258 mm/slub.c:3275) 
[ 103.599798][ T5052] netlink_rcv_skb (net/netlink/af_netlink.c:2538) 
[ 103.599882][ T5052] ? genl_get_cmd (net/netlink/genetlink.c:784) 
[ 103.599967][ T5052] ? netlink_ack (net/netlink/af_netlink.c:2515) 
[ 103.600049][ T5052] ? netlink_recvmsg (net/netlink/af_netlink.c:514) 
[ 103.600136][ T5052] ? _copy_from_iter (lib/iov_iter.c:628 (discriminator 11)) 
[ 103.600226][ T5052] genl_rcv (net/netlink/genetlink.c:807) 
[ 103.600299][ T5052] netlink_unicast (net/netlink/af_netlink.c:1320 net/netlink/af_netlink.c:1345) 
[ 103.600386][ T5052] ? netlink_attachskb (net/netlink/af_netlink.c:1330) 
[ 103.600488][ T5052] ? check_heap_object (arch/x86/include/asm/bitops.h:207 arch/x86/include/asm/bitops.h:239 include/asm-generic/bitops/instrumented-non-atomic.h:142 include/linux/page-flags.h:487 mm/usercopy.c:193) 
[ 103.600588][ T5052] netlink_sendmsg (net/netlink/af_netlink.c:1921) 
[ 103.600675][ T5052] ? netlink_unicast (net/netlink/af_netlink.c:1841) 
[ 103.600764][ T5052] ? __import_iovec (lib/iov_iter.c:1771) 
[ 103.600849][ T5052] ? netlink_unicast (net/netlink/af_netlink.c:1841) 
[ 103.600936][ T5052] sock_sendmsg (net/socket.c:714 net/socket.c:734) 
[ 103.601016][ T5052] ____sys_sendmsg (net/socket.c:2482) 
[ 103.601101][ T5052] ? kernel_sendmsg (net/socket.c:2429) 
[ 103.601184][ T5052] ? __copy_msghdr (net/socket.c:2409) 
[ 103.601269][ T5052] ? __kasan_record_aux_stack (mm/kasan/generic.c:348) 
[ 103.601369][ T5052] ___sys_sendmsg (net/socket.c:2538) 
[ 103.601461][ T5052] ? __ia32_sys_recvmmsg (net/socket.c:2525) 
[ 103.601566][ T5052] ? rcu_gp_kthread (kernel/rcu/tree_nocb.h:371) 
[ 103.601653][ T5052] ? fsnotify_grab_connector (fs/notify/mark.c:601) 
[ 103.601751][ T5052] ? filemap_map_pmd (mm/filemap.c:3324) 
[ 103.601839][ T5052] ? do_read_fault (mm/memory.c:4487 mm/memory.c:4513) 
[ 103.601925][ T5052] ? do_fault (mm/memory.c:4647) 
[ 103.602003][ T5052] ? __handle_mm_fault (mm/memory.c:5053) 
[ 103.602093][ T5052] ? rcu_gp_kthread (kernel/rcu/tree_nocb.h:371) 
[ 103.602180][ T5052] ? copy_page_range (mm/memory.c:4963) 
[ 103.602267][ T5052] ? __fget_light (arch/x86/include/asm/atomic.h:29 include/linux/atomic/atomic-instrumented.h:28 fs/file.c:1005) 
[ 103.602352][ T5052] __sys_sendmsg (include/linux/file.h:31 net/socket.c:2567) 
[ 103.602435][ T5052] ? __sys_sendmsg_sock (net/socket.c:2553) 
[ 103.602545][ T5052] ? do_user_addr_fault (arch/x86/mm/fault.c:1426) 
[ 103.602636][ T5052] ? exit_to_user_mode_loop (include/linux/sched.h:2305 include/linux/resume_user_mode.h:61 kernel/entry/common.c:169) 
[ 103.602731][ T5052] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 103.602812][ T5052] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  103.602915][ T5052] RIP: 0033:0x7fcd499bf2c3
[ 103.602996][ T5052] Code: 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 89 54 24 1c 48
All code
========
   0:	64 89 02             	mov    %eax,%fs:(%rdx)
   3:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
   a:	eb b7                	jmp    0xffffffffffffffc3
   c:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  13:	00 00 00 
  16:	90                   	nop
  17:	64 8b 04 25 18 00 00 	mov    %fs:0x18,%eax
  1e:	00 
  1f:	85 c0                	test   %eax,%eax
  21:	75 14                	jne    0x37
  23:	b8 2e 00 00 00       	mov    $0x2e,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 55                	ja     0x87
  32:	c3                   	retq   
  33:	0f 1f 40 00          	nopl   0x0(%rax)
  37:	48 83 ec 28          	sub    $0x28,%rsp
  3b:	89 54 24 1c          	mov    %edx,0x1c(%rsp)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 55                	ja     0x5d
   8:	c3                   	retq   
   9:	0f 1f 40 00          	nopl   0x0(%rax)
   d:	48 83 ec 28          	sub    $0x28,%rsp
  11:	89 54 24 1c          	mov    %edx,0x1c(%rsp)
  15:	48                   	rex.W
[  103.603312][ T5052] RSP: 002b:00007ffd473a4358 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[  103.603472][ T5052] RAX: ffffffffffffffda RBX: 000055d33f5b4390 RCX: 00007fcd499bf2c3
[  103.603625][ T5052] RDX: 0000000000000000 RSI: 00007ffd473a4390 RDI: 0000000000000003
[  103.603758][ T5052] RBP: 000055d33f5b9780 R08: 000055d33f5b54c0 R09: 000055d33f5b44b0
[  103.603894][ T5052] R10: 000055d33f290940 R11: 0000000000000246 R12: 000055d33f5b98c0
[  103.604030][ T5052] R13: 00007ffd473a4390 R14: 000055d33f5b97d0 R15: 000055d33f5b98c0
[  103.604166][ T5052]  </TASK>
[  103.605988][  T405] Station dump on dev[0]:
[  103.605997][  T405]
[  103.606940][  T405] Station 02:00:00:00:03:00 (on wlan0)
[  103.606947][  T405]
[  103.607595][  T405] 	inactive time:	61 ms
[  103.607602][  T405]
[  103.608090][  T405] 	rx bytes:	150775
[  103.608096][  T405]
[  103.608636][  T405] 	rx packets:	172
[  103.608643][  T405]
[  103.609122][  T405] 	tx bytes:	64715
[  103.609128][  T405]
[  103.609621][  T405] 	tx packets:	54
[  103.609627][  T405]
[  103.610061][  T405] 	tx retries:	0
[  103.610067][  T405]
[  103.610590][  T405] 	tx failed:	0
[  103.610596][  T405]
[  103.611031][  T405] 	beacon loss:	0
[  103.611037][  T405]
[  103.611473][  T405] 	beacon rx:	25
[  103.611480][  T405]
[  103.611979][  T405] 	rx drop misc:	30
[  103.611985][  T405]
[  103.612510][  T405] 	signal:  	-27 dBm
[  103.612521][  T405]
[  103.613094][  T405] 	signal avg:	-27 dBm
[  103.613100][  T405]
[  103.613841][  T405] 	beacon signal avg:	-27 dBm
[  103.613848][  T405]
[  103.614976][  T405] 	tx bitrate:	13.0 MBit/s VHT-MCS 1 VHT-NSS 1
[  103.614983][  T405]
[  103.615774][    T8] wlan0: deauthenticated from 02:00:00:00:03:00 (Reason: 3=DEAUTH_LEAVING)
[  103.615801][   T60] wlan1: deauthenticated from 02:00:00:00:03:00 (Reason: 3=DEAUTH_LEAVING)
[  103.615855][  T405] 	tx duration:	0 us
[  103.615864][  T405]


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        sudo bin/lkp install job.yaml           # job file is attached in this email
        bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
        sudo bin/lkp run generated-yaml-file

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



-- 
0-DAY CI Kernel Test Service
https://01.org/lkp



--2BOLdwFwC2i4cuCA
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.0.0-rc3-00691-g662cceb50ea7"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.0.0-rc3 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-5) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23890
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23890
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_WATCH_QUEUE=y
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING_USER=y
# CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
# CONFIG_BPF_SYSCALL is not set
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_DEFAULT_ON=y
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_TASKS_RCU=y
# CONFIG_FORCE_TASKS_RUDE_RCU is not set
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_NR_GPIO=1024
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
CONFIG_INTEL_TDX_GUEST=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
# CONFIG_X86_MCE_AMD is not set
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_PERF_EVENTS_AMD_UNCORE is not set
# CONFIG_PERF_EVENTS_AMD_BRS is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_LATE_LOADING=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_X86_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
# CONFIG_X86_KERNEL_IBT is not set
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
CONFIG_X86_INTEL_TSX_MODE_AUTO=y
# CONFIG_X86_SGX is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_RETPOLINE=y
CONFIG_RETHUNK=y
CONFIG_CPU_UNRET_ENTRY=y
CONFIG_CPU_IBPB_ENTRY=y
CONFIG_CPU_IBRS_ENTRY=y
# CONFIG_SLS is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
CONFIG_PMIC_OPREGION=y
CONFIG_ACPI_PRMT=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
# CONFIG_KVM_XEN is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_HAS_CC_PLATFORM=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_MQ_RDMA=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_DEFAULT_ON is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_THP_SWAP=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=19
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_HMM_MIRROR=y
CONFIG_GET_FREE_REGION=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
# CONFIG_USERFAULTFD is not set

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_SMC is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_HOOK is not set
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y
CONFIG_NETFILTER_XTABLES_COMPAT=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
# CONFIG_TIPC_MEDIA_IB is not set
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_RDMA is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
# CONFIG_EFI_DISABLE_RUNTIME is not set
# CONFIG_EFI_COCO_SECRET is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=m
CONFIG_ZRAM_DEF_COMP_LZORLE=y
# CONFIG_ZRAM_DEF_COMP_LZO is not set
CONFIG_ZRAM_DEF_COMP="lzo-rle"
CONFIG_ZRAM_WRITEBACK=y
# CONFIG_ZRAM_MEMORY_TRACKING is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_RDMA is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_RDMA is not set
CONFIG_NVME_TARGET_FC=m
# CONFIG_NVME_TARGET_TCP is not set
# CONFIG_NVME_TARGET_AUTH is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_GSC is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_EFCT is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
# CONFIG_DM_ZONED is not set
CONFIG_DM_AUDIT=y
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=m
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_AMT is not set
CONFIG_MACSEC=m
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
# CONFIG_IXGBE_IPSEC is not set
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
# CONFIG_MSE102X is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLINK=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y
# CONFIG_SFP is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_DP83TD510_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_CAN_DEV=m
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_NETLINK=y
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_CAN327 is not set
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_CTUCANFD_PCI is not set
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
# CONFIG_CAN_SJA1000_PLATFORM is not set
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB is not set
# CONFIG_CAN_ETAS_ES58X is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
# CONFIG_IWLMEI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_PURELIFI=y
# CONFIG_PLFXLC is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
# CONFIG_RTW89 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_SILABS=y
# CONFIG_WFX is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_PCSPKR is not set
# CONFIG_INPUT_MMA8450 is not set
# CONFIG_INPUT_APANEL is not set
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_KXTJ9 is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_UINPUT=y
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_DA7280_HAPTICS is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_IQS269A is not set
# CONFIG_INPUT_IQS626A is not set
# CONFIG_INPUT_IQS7222 is not set
# CONFIG_INPUT_CMA3000 is not set
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
CONFIG_RANDOM_TRUST_CPU=y
CONFIG_RANDOM_TRUST_BOOTLOADER=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_METEORLAKE is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_DELL_SMM is not set
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
# CONFIG_SENSORS_FSP_3Y is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_DPS920AB is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
# CONFIG_SENSORS_LT7182S is not set
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2888 is not set
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_MP5023 is not set
# CONFIG_SENSORS_PIM4328 is not set
# CONFIG_SENSORS_PLI1209BC is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_STPDDC60 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE152 is not set
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
# CONFIG_SENSORS_SY7636A is not set
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_WMI_EC is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SIMPLE_MFD_I2C is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_LIRC=y
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_SONY_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
CONFIG_IR_FINTEK=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_ITE_CIR=m
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_TOY is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_RC_LOOPBACK is not set
# CONFIG_RC_XBOX_DVD is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
# end of Media drivers

CONFIG_MEDIA_HIDE_ANCILLARY_SUBDRV=y

#
# Media ancillary drivers
#
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_HELPER=m
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT_KVMGT is not set
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=m
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y
CONFIG_DRM_PRIVACY_SCREEN=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LETSKETCH is not set
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MEGAWORLD_FF is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_XR is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_UCSI_STM32G0 is not set
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_FSA4480 is not set
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
CONFIG_INFINIBAND_VIRT_DMA=y
# CONFIG_INFINIBAND_EFA is not set
# CONFIG_INFINIBAND_ERDMA is not set
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_INFINIBAND_OCRDMA is not set
# CONFIG_INFINIBAND_USNIC is not set
# CONFIG_INFINIBAND_RDMAVT is not set
CONFIG_RDMA_RXE=m
CONFIG_RDMA_SIW=m
CONFIG_INFINIBAND_IPOIB=m
# CONFIG_INFINIBAND_IPOIB_CM is not set
CONFIG_INFINIBAND_IPOIB_DEBUG=y
# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
CONFIG_INFINIBAND_SRP=m
CONFIG_INFINIBAND_SRPT=m
# CONFIG_INFINIBAND_ISER is not set
# CONFIG_INFINIBAND_ISERT is not set
# CONFIG_INFINIBAND_RTRS_CLIENT is not set
# CONFIG_INFINIBAND_RTRS_SERVER is not set
# CONFIG_INFINIBAND_OPA_VNIC is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_GHES=y
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
# CONFIG_INTEL_IDXD_COMPAT is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_VFIO=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_MEM is not set
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
# CONFIG_MLXREG_LC is not set
# CONFIG_NVSW_SN2201 is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMC is not set
# CONFIG_AMD_HSMP is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
# CONFIG_WIRELESS_HOTKEY is not set
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_SAR_INT1092 is not set
CONFIG_INTEL_PMC_CORE=m

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_OAKTRAIL=m
# CONFIG_INTEL_ISHTP_ECLITE is not set
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_VSEC is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_IOMMU_SVA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
CONFIG_INTEL_IOMMU_SVM=y
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
CONFIG_IRQ_REMAP=y
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
# CONFIG_ZONEFS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_ERROR_INJECTION is not set
# CONFIG_CACHEFILES_ONDEMAND is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_SUNRPC_XPRT_RDMA=m
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_SMB_DIRECT is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
# CONFIG_DLM_DEPRECATED_API is not set
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_KEY_NOTIFICATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
# CONFIG_SECURITY_INFINIBAND is not set
CONFIG_SECURITY_NETWORK_XFRM=y
# CONFIG_SECURITY_PATH is not set
CONFIG_INTEL_TXT=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
# CONFIG_IMA is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
# CONFIG_CRYPTO_HCTR2 is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SEED=m
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4_GENERIC is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_LIB_MEMNEQ=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_OBJTOOL=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=y
CONFIG_KASAN_VMALLOC=y
# CONFIG_KASAN_MODULE_TEST is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_REF_SCALE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
# CONFIG_FPROBE is not set
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_RV is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
# CONFIG_FAIL_SUNRPC is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_SIPHASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
CONFIG_TEST_BPF=m
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--2BOLdwFwC2i4cuCA
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='hwsim'
	export testcase='hwsim'
	export category='functional'
	export need_memory='1G'
	export job_origin='hwsim-part1.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis
bm_initrd_keep'
	export queue='validate'
	export testbox='lkp-ivb-d01'
	export tbox_group='lkp-ivb-d01'
	export submit_id='6327ad0c7c30291367b823ac'
	export job_file='/lkp/jobs/scheduled/lkp-ivb-d01/hwsim-group-03-debian-11.1-x86_64-20220510.cgz-662cceb50ea735492ff67b5ecdbc8d9de15212bd-20220919-70503-18mmamf-4.yaml'
	export id='d4c4c87273933dea91f067bc896c1b4bacc30f45'
	export queuer_version='/zday/lkp'
	export model='Ivy Bridge'
	export nr_node=1
	export nr_cpu=8
	export memory='16G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=4
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL42040066800RGN-part2'
	export hdd_partitions='/dev/disk/by-id/ata-WDC_WD10EACS-22D6B0_WD-WCAU45298688-part*'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL42040066800RGN-part1'
	export brand='Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz'
	export need_kconfig=\{\"WLAN\"\=\>\"y\"\}'
'\{\"PACKET\"\=\>\"y\"\}'
'\{\"CFG80211\"\=\>\"m\"\}'
'\{\"CFG80211_WEXT\"\=\>\"y\"\}'
'\{\"MAC80211\"\=\>\"m\"\}'
'\{\"MAC80211_HWSIM\"\=\>\"m\"\}'
'\{\"MAC80211_LEDS\"\=\>\"y\"\}'
'\{\"MAC80211_MESH\"\=\>\"y\"\}'
'\{\"MAC80211_DEBUGFS\"\=\>\"y\"\}'
'\{\"VETH\"\=\>\"m\"\}'
'\{\"BRIDGE\"\=\>\"m\"\}'
'\{\"MACSEC\"\=\>\"m\"\}
	export commit='662cceb50ea735492ff67b5ecdbc8d9de15212bd'
	export netconsole_port=6672
	export ucode='0x21'
	export need_kconfig_hw='{"PTP_1588_CLOCK"=>"y"}
{"IGB"=>"y"}
{"E1000E"=>"y"}
SATA_AHCI
DRM_I915'
	export bisect_dmesg=true
	export kconfig='x86_64-rhel-8.3-func'
	export enqueue_time='2022-09-19 07:43:08 +0800'
	export _id='6327ad227c30291367b823ad'
	export _rt='/result/hwsim/group-03/lkp-ivb-d01/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/662cceb50ea735492ff67b5ecdbc8d9de15212bd'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='3d89333c9e54e4b60aea771ce414b6986433cfb1'
	export base_commit='80e78fcce86de0288793a0ef0f6acf37656ee4cf'
	export branch='linux-review/venkatch-gmail-com/wifi-mac80211-Fix-performance-issue-with-mutex_lock/20220915-123721'
	export rootfs='debian-11.1-x86_64-20220510.cgz'
	export result_root='/result/hwsim/group-03/lkp-ivb-d01/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/662cceb50ea735492ff67b5ecdbc8d9de15212bd/3'
	export scheduler_version='/lkp/lkp/.src-20220915-165923'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-11.1-x86_64-20220510.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/hwsim/group-03/lkp-ivb-d01/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/662cceb50ea735492ff67b5ecdbc8d9de15212bd/3
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/662cceb50ea735492ff67b5ecdbc8d9de15212bd/vmlinuz-6.0.0-rc3-00691-g662cceb50ea7
branch=linux-review/venkatch-gmail-com/wifi-mac80211-Fix-performance-issue-with-mutex_lock/20220915-123721
job=/lkp/jobs/scheduled/lkp-ivb-d01/hwsim-group-03-debian-11.1-x86_64-20220510.cgz-662cceb50ea735492ff67b5ecdbc8d9de15212bd-20220919-70503-18mmamf-4.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-func
commit=662cceb50ea735492ff67b5ecdbc8d9de15212bd
max_uptime=2100
LKP_SERVER=internal-lkp-server
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-func/gcc-11/662cceb50ea735492ff67b5ecdbc8d9de15212bd/modules.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hwsim_20220523.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/hwsim-x86_64-717e5d7-1_20220525.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20220804.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='6.0.0-rc5-06591-gd3fc041f9cec'
	export repeat_to=6
	export stop_repeat_if_found='dmesg.BUG:sleeping_function_called_from_invalid_context_at_include/linux/sched/mm.h'
	export kbuild_queue_analysis=1
	export schedule_notify_address=
	export bm_initrd_keep=true
	export kernel='/pkg/linux/x86_64-rhel-8.3-func/gcc-11/662cceb50ea735492ff67b5ecdbc8d9de15212bd/vmlinuz-6.0.0-rc3-00691-g662cceb50ea7'
	export dequeue_time='2022-09-19 08:05:24 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-ivb-d01/hwsim-group-03-debian-11.1-x86_64-20220510.cgz-662cceb50ea735492ff67b5ecdbc8d9de15212bd-20220919-70503-18mmamf-4.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='group-03' $LKP_SRC/tests/wrapper hwsim
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env test='group-03' $LKP_SRC/stats/wrapper hwsim
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time hwsim.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--2BOLdwFwC2i4cuCA
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--2BOLdwFwC2i4cuCA
Content-Type: text/plain; charset="utf-8"
Content-Disposition: attachment; filename="hwsim"
Content-Transfer-Encoding: 8bit

2022-09-19 00:06:19 export USER=root
2022-09-19 00:06:19 ./build.sh
Building TNC testing tools
Building wlantest
Building hs20-osu-client
osu_client.c: In function ‘cmd_osu_select’:
osu_client.c:2090:44: warning: ‘%s’ directive output may be truncated writing up to 985 bytes into a region of size 4 [-Wformat-truncation=]
 2090 |    snprintf(txt->lang, sizeof(txt->lang), "%s", buf + 14);
      |    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
osu_client.c:2090:4: note: ‘snprintf’ output between 1 and 986 bytes into a destination of size 4
 2090 |    snprintf(txt->lang, sizeof(txt->lang), "%s", buf + 14);
      |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
osu_client.c:2103:44: warning: ‘%s’ directive output may be truncated writing up to 994 bytes into a region of size 4 [-Wformat-truncation=]
 2103 |    snprintf(txt->lang, sizeof(txt->lang), "%s", buf + 5);
      |    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
osu_client.c:2103:4: note: ‘snprintf’ output between 1 and 995 bytes into a destination of size 4
 2103 |    snprintf(txt->lang, sizeof(txt->lang), "%s", buf + 5);
      |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
osu_client.c:2077:10: warning: ‘%s’ directive output may be truncated writing up to 990 bytes into a region of size 256 [-Wformat-truncation=]
 2077 |         "%s", buf + 9);
      |          ^~
In file included from ../../src/utils/common.h:12,
                 from osu_client.c:16:
../../src/utils/os.h:552:21: note: ‘snprintf’ output between 1 and 991 bytes into a destination of size 256
  552 | #define os_snprintf snprintf
osu_client.c:2076:4: note: in expansion of macro ‘os_snprintf’
 2076 |    os_snprintf(last->osu_nai2, sizeof(last->osu_nai2),
      |    ^~~~~~~~~~~
osu_client.c:2071:10: warning: ‘%s’ directive output may be truncated writing up to 991 bytes into a region of size 256 [-Wformat-truncation=]
 2071 |         "%s", buf + 8);
      |          ^~
In file included from ../../src/utils/common.h:12,
                 from osu_client.c:16:
../../src/utils/os.h:552:21: note: ‘snprintf’ output between 1 and 992 bytes into a destination of size 256
  552 | #define os_snprintf snprintf
osu_client.c:2070:4: note: in expansion of macro ‘os_snprintf’
 2070 |    os_snprintf(last->osu_nai, sizeof(last->osu_nai),
      |    ^~~~~~~~~~~
osu_client.c:2065:7: warning: ‘%s’ directive output may be truncated writing up to 989 bytes into a region of size 33 [-Wformat-truncation=]
 2064 |    snprintf(last->osu_ssid2, sizeof(last->osu_ssid2),
      |    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 2065 |      "%s", buf + 10);
      |      ~^~~~~~~~~~~~~~
osu_client.c:2064:4: note: ‘snprintf’ output between 1 and 990 bytes into a destination of size 33
 2064 |    snprintf(last->osu_ssid2, sizeof(last->osu_ssid2),
      |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 2065 |      "%s", buf + 10);
      |      ~~~~~~~~~~~~~~~
osu_client.c:2059:7: warning: ‘%s’ directive output may be truncated writing up to 990 bytes into a region of size 33 [-Wformat-truncation=]
 2058 |    snprintf(last->osu_ssid, sizeof(last->osu_ssid),
      |    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 2059 |      "%s", buf + 9);
      |      ~^~~~~~~~~~~~~
osu_client.c:2058:4: note: ‘snprintf’ output between 1 and 991 bytes into a destination of size 33
 2058 |    snprintf(last->osu_ssid, sizeof(last->osu_ssid),
      |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 2059 |      "%s", buf + 9);
      |      ~~~~~~~~~~~~~~
osu_client.c:2048:44: warning: ‘%s’ directive output may be truncated writing up to 995 bytes into a region of size 256 [-Wformat-truncation=]
 2048 |    snprintf(last->url, sizeof(last->url), "%s", buf + 4);
      |    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
osu_client.c:2048:4: note: ‘snprintf’ output between 1 and 996 bytes into a destination of size 256
 2048 |    snprintf(last->url, sizeof(last->url), "%s", buf + 4);
      |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
osu_client.c:2040:48: warning: ‘%s’ directive output may be truncated writing up to 986 bytes into a region of size 20 [-Wformat-truncation=]
 2040 |    snprintf(last->bssid, sizeof(last->bssid), "%s",
      |    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
 2041 |      buf + 13);
      |      ~~~~~~~~~                                  
osu_client.c:2040:4: note: ‘snprintf’ output between 1 and 987 bytes into a destination of size 20
 2040 |    snprintf(last->bssid, sizeof(last->bssid), "%s",
      |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 2041 |      buf + 13);
      |      ~~~~~~~~~
Building hostapd
Building wpa_supplicant
2022-09-19 00:07:01 ./start.sh
2022-09-19 00:07:01 ./run-tests.py ap_ft_ap_oom3b
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_ft_ap_oom3b 1/1
Test: WPA2-PSK-FT and AP OOM 3b
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan4
PASS ap_ft_ap_oom3b 0.551751 2022-09-19 00:07:03.580399
passed all 1 test case(s)
2022-09-19 00:07:03 ./run-tests.py ap_ft_sae
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_ft_sae 1/1
Test: WPA2-PSK-FT-SAE AP
Starting AP wlan3
Starting AP wlan4
Connect to first AP
Connect STA wlan0 to AP
Roam to the second AP
Roam back to the first AP
PASS ap_ft_sae 0.672833 2022-09-19 00:07:04.662792
passed all 1 test case(s)
2022-09-19 00:07:04 ./run-tests.py ap_ft_sae_over_ds_ptk_rekey0
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_ft_sae_over_ds_ptk_rekey0 1/1
Test: WPA2-PSK-FT-SAE AP over DS and PTK rekey triggered by station
Starting AP wlan3
Starting AP wlan4
Connect to first AP
Connect STA wlan0 to AP
PASS ap_ft_sae_over_ds_ptk_rekey0 1.641628 2022-09-19 00:07:06.703846
passed all 1 test case(s)
2022-09-19 00:07:06 ./run-tests.py ap_ft_vlan_over_ds_many
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_ft_vlan_over_ds_many 1/1
Test: WPA2-PSK-FT AP over DS with VLAN multiple times
Starting AP wlan3 (old add_ap argument type)
Starting AP wlan4 (old add_ap argument type)
Connect to first AP
Connect STA wlan0 to AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
Roam to the second AP
Roam back to the first AP
PASS ap_ft_vlan_over_ds_many 9.447158 2022-09-19 00:07:16.550137
passed all 1 test case(s)
2022-09-19 00:07:16 ./run-tests.py ap_hs20_eap_cert_unknown
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_hs20_eap_cert_unknown 1/1
Test: Hotspot 2.0 connection with certificate, but unknown EAP method
Starting AP wlan3
PASS ap_hs20_eap_cert_unknown 0.212899 2022-09-19 00:07:17.160645
passed all 1 test case(s)
2022-09-19 00:07:17 ./run-tests.py ap_hs20_eap_ttls_chap
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_hs20_eap_ttls_chap 1/1
Test: Hotspot 2.0 connection with TTLS/CHAP
Starting AP wlan3
PASS ap_hs20_eap_ttls_chap 0.449428 2022-09-19 00:07:18.004300
passed all 1 test case(s)
2022-09-19 00:07:18 ./run-tests.py ap_hs20_fetch_osu_single_ssid2
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_hs20_fetch_osu_single_ssid2 1/1
Test: Hotspot 2.0 OSU provider and single SSID (two OSU providers)
Starting AP wlan3
OSU-PROVIDER 02:00:00:00:03:00
uri=https://example.com/osu/
methods=00000002
osu_ssid=HS 2.0 OSU open
osu_ssid2=test-hs20
osu_nai2=osen@example.com
friendly_name=eng:Test OSU
friendly_name=fin:Testi-OSU
desc=eng:Example services
desc=fin:Esimerkkipalveluja

OSU-PROVIDER 02:00:00:00:03:00
uri=https://another.example.com/osu/
methods=00000002
osu_ssid=HS 2.0 OSU open
osu_ssid2=test-hs20
osu_nai2=osen@another.example.com
PASS ap_hs20_fetch_osu_single_ssid2 3.921297 2022-09-19 00:07:22.318651
passed all 1 test case(s)
2022-09-19 00:07:22 ./run-tests.py ap_hs20_interworking_oom
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_hs20_interworking_oom 1/1
Test: Hotspot 2.0 network selection and OOM
Starting AP wlan3
PASS ap_hs20_interworking_oom 0.781957 2022-09-19 00:07:23.491304
passed all 1 test case(s)
2022-09-19 00:07:23 ./run-tests.py ap_hs20_min_bandwidth_home2
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_hs20_min_bandwidth_home2 1/1
Test: Hotspot 2.0 network selection with min bandwidth - special cases
Starting AP wlan3
WAN link at capacity
Downlink/Uplink Load was not measured
Uplink and Downlink max values
PASS ap_hs20_min_bandwidth_home2 0.385015 2022-09-19 00:07:24.265257
passed all 1 test case(s)
2022-09-19 00:07:24 ./run-tests.py ap_hs20_network_preference4
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_hs20_network_preference4 1/1
Test: Hotspot 2.0 network selection with username vs. SIM credential
Starting AP wlan3
Starting AP wlan4
PASS ap_hs20_network_preference4 0.644178 2022-09-19 00:07:25.300073
passed all 1 test case(s)
2022-09-19 00:07:25 ./run-tests.py ap_hs20_sim_imsi_privacy
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_hs20_sim_imsi_privacy 1/1
Test: Hotspot 2.0 with simulated SIM and EAP-SIM with IMSI privacy
Starting AP wlan3
PASS ap_hs20_sim_imsi_privacy 0.349275 2022-09-19 00:07:26.039588
passed all 1 test case(s)
2022-09-19 00:07:26 ./run-tests.py ap_hs20_sim_oom
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_hs20_sim_oom 1/1
Test: Hotspot 2.0 with simulated SIM and EAP-SIM - OOM
Starting AP wlan3
PASS ap_hs20_sim_oom 0.248313 2022-09-19 00:07:26.678388
passed all 1 test case(s)
2022-09-19 00:07:26 ./run-tests.py ap_open_poll_sta_no_ack
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_poll_sta_no_ack 1/1
Test: AP with open mode and STA poll without ACK
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_open_poll_sta_no_ack 1.237387 2022-09-19 00:07:28.303408
passed all 1 test case(s)
2022-09-19 00:07:28 ./run-tests.py ap_open_tdls_vht80
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_tdls_vht80 1/1
Test: Open AP and two stations using TDLS with VHT 80
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Setup TDLS
Station dump on dev[0]:
Station 02:00:00:00:03:00 (on wlan0)
	inactive time:	61 ms
	rx bytes:	150775
	rx packets:	172
	tx bytes:	64715
	tx packets:	54
	tx retries:	0
	tx failed:	0
	beacon loss:	0
	beacon rx:	25
	rx drop misc:	30
	signal:  	-27 dBm
	signal avg:	-27 dBm
	beacon signal avg:	-27 dBm
	tx bitrate:	13.0 MBit/s VHT-MCS 1 VHT-NSS 1
	tx duration:	0 us
	rx bitrate:	486.0 MBit/s VHT-MCS 8 40MHz VHT-NSS 3
	rx duration:	0 us
	expected throughput:	9.704Mbps
	authorized:	yes
	authenticated:	yes
	associated:	yes
	preamble:	long
	WMM/WME:	yes
	MFP:		no
	TDLS peer:	no
	DTIM period:	2
	beacon interval:100
	short slot time:yes
	connected time:	2 seconds
	associated at [boottime]:	101.063s
	associated at:	1663546049202 ms
	current time:	1663546051713 ms
Station 02:00:00:00:01:00 (on wlan0)
	inactive time:	105 ms
	rx bytes:	18306
	rx packets:	16
	tx bytes:	18306
	tx packets:	14
	tx retries:	0
	tx failed:	0
	beacon loss:	0
	beacon rx:	25
	rx drop misc:	0
	signal:  	-27 dBm
	signal avg:	-27 dBm
	beacon signal avg:	-27 dBm
	tx bitrate:	13.0 MBit/s VHT-MCS 1 VHT-NSS 1
	tx duration:	0 us
	rx bitrate:	13.0 MBit/s VHT-MCS 1 VHT-NSS 1
	rx duration:	0 us
	expected throughput:	9.704Mbps
	authorized:	yes
	authenticated:	yes
	associated:	yes
	preamble:	long
	WMM/WME:	yes
	MFP:		no
	TDLS peer:	yes
	DTIM period:	2
	beacon interval:100
	short slot time:yes
	connected time:	2 seconds
	associated at [boottime]:	101.370s
	associated at:	1663546049509 ms
	current time:	1663546051713 ms

Station dump on dev[1]:
Station 02:00:00:00:03:00 (on wlan0)
	inactive time:	80 ms
	rx bytes:	150775
	rx packets:	172
	tx bytes:	64715
	tx packets:	54
	tx retries:	0
	tx failed:	0
	beacon loss:	0
	beacon rx:	25
	rx drop misc:	30
	signal:  	-27 dBm
	signal avg:	-27 dBm
	beacon signal avg:	-27 dBm
	tx bitrate:	13.0 MBit/s VHT-MCS 1 VHT-NSS 1
	tx duration:	0 us
	rx bitrate:	486.0 MBit/s VHT-MCS 8 40MHz VHT-NSS 3
	rx duration:	0 us
	expected throughput:	9.704Mbps
	authorized:	yes
	authenticated:	yes
	associated:	yes
	preamble:	long
	WMM/WME:	yes
	MFP:		no
	TDLS peer:	no
	DTIM period:	2
	beacon interval:100
	short slot time:yes
	connected time:	2 seconds
	associated at [boottime]:	101.063s
	associated at:	1663546049202 ms
	current time:	1663546051723 ms
Station 02:00:00:00:01:00 (on wlan0)
	inactive time:	115 ms
	rx bytes:	18306
	rx packets:	16
	tx bytes:	18306
	tx packets:	14
	tx retries:	0
	tx failed:	0
	beacon loss:	0
	beacon rx:	25
	rx drop misc:	0
	signal:  	-27 dBm
	signal avg:	-27 dBm
	beacon signal avg:	-27 dBm
	tx bitrate:	13.0 MBit/s VHT-MCS 1 VHT-NSS 1
	tx duration:	0 us
	rx bitrate:	13.0 MBit/s VHT-MCS 1 VHT-NSS 1
	rx duration:	0 us
	expected throughput:	9.704Mbps
	authorized:	yes
	authenticated:	yes
	associated:	yes
	preamble:	long
	WMM/WME:	yes
	MFP:		no
	TDLS peer:	yes
	DTIM period:	2
	beacon interval:100
	short slot time:yes
	connected time:	2 seconds
	associated at [boottime]:	101.370s
	associated at:	1663546049509 ms
	current time:	1663546051723 ms

PASS ap_open_tdls_vht80 3.374866 2022-09-19 00:07:32.067497
passed all 1 test case(s)
2022-09-19 00:07:32 ./run-tests.py ap_pmf_assoc_comeback2
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_assoc_comeback2 1/1
Test: WPA2-PSK AP with PMF association comeback (using DROP_SA)
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_pmf_assoc_comeback2 1.461697 2022-09-19 00:07:33.920006
passed all 1 test case(s)
2022-09-19 00:07:33 ./run-tests.py ap_pmf_required_eap
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_required_eap 1/1
Test: WPA2-EAP AP with PMF required
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_pmf_required_eap 0.453892 2022-09-19 00:07:34.764852
passed all 1 test case(s)
2022-09-19 00:07:34 ./run-tests.py ap_tdls_chan_switch_prohibit
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_tdls_chan_switch_prohibit 1/1
Test: Open AP and TDLS channel switch prohibited
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Setup TDLS
PASS ap_tdls_chan_switch_prohibit 1.823794 2022-09-19 00:07:36.982850
passed all 1 test case(s)
2022-09-19 00:07:37 ./run-tests.py ap_vht_csa_vht80p80
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht_csa_vht80p80 1/1
Test: VHT CSA with VHT80+80 getting enabled
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
SIGNAL_POLL(1): ['RSSI=-27', 'LINKSPEED=6', 'NOISE=-92', 'FREQUENCY=5180', 'WIDTH=80+80 MHz', 'CENTER_FRQ1=5210', 'CENTER_FRQ2=5775', 'AVG_RSSI=-27', 'AVG_BEACON_RSSI=-27']
SIGNAL_POLL(0): ['RSSI=-27', 'LINKSPEED=6', 'NOISE=9999', 'FREQUENCY=5180', 'WIDTH=40 MHz', 'CENTER_FRQ1=5190', 'AVG_RSSI=-26', 'AVG_BEACON_RSSI=-26']
PASS ap_vht_csa_vht80p80 1.875392 2022-09-19 00:07:39.249507
passed all 1 test case(s)
2022-09-19 00:07:39 ./run-tests.py ap_wds_sta_wep
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wds_sta_wep 1/1
Test: WEP AP with STA using 4addr mode
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wds_sta_wep 0.70598 2022-09-19 00:07:40.344751
passed all 1 test case(s)
2022-09-19 00:07:40 ./run-tests.py ap_wmm_uapsd
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wmm_uapsd 1/1
Test: AP with U-APSD advertisement
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wmm_uapsd 0.267761 2022-09-19 00:07:41.007159
passed all 1 test case(s)
2022-09-19 00:07:41 ./run-tests.py ap_wpa2_eap_fast_mschapv2_unauth_prov
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_mschapv2_unauth_prov 1/1
Test: WPA2-Enterprise connection using EAP-FAST/MSCHAPv2 and unauthenticated provisioning
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_mschapv2_unauth_prov 0.560061 2022-09-19 00:07:41.962027
passed all 1 test case(s)
2022-09-19 00:07:42 ./run-tests.py ap_wpa2_eap_fast_prov
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_prov 1/1
Test: EAP-FAST and provisioning options
Starting AP wlan3
Provisioning attempt while server has provisioning disabled
Connect STA wlan0 to AP
Authenticated provisioning
Provisioning disabled - using previously provisioned PAC
Drop PAC and verify connection failure
Anonymous provisioning
Provisioning disabled - using previously provisioned PAC
PASS ap_wpa2_eap_fast_prov 1.082516 2022-09-19 00:07:43.437534
passed all 1 test case(s)
2022-09-19 00:07:43 ./run-tests.py ap_wpa2_eap_no_workaround
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_no_workaround 1/1
Test: WPA2-Enterprise connection using EAP-TTLS and eap_workaround=0
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_no_workaround 0.315583 2022-09-19 00:07:44.144598
passed all 1 test case(s)
2022-09-19 00:07:44 ./run-tests.py ap_wpa2_eap_sim
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_sim 1/1
Test: WPA2-Enterprise connection using EAP-SIM
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Negative test with incorrect key
Connect STA wlan0 to AP
Invalid GSM-Milenage key
Connect STA wlan0 to AP
Invalid GSM-Milenage key(2)
Connect STA wlan0 to AP
Invalid GSM-Milenage key(3)
Connect STA wlan0 to AP
Invalid GSM-Milenage key(4)
Connect STA wlan0 to AP
Missing key configuration
Connect STA wlan0 to AP
PASS ap_wpa2_eap_sim 0.86702 2022-09-19 00:07:45.401625
passed all 1 test case(s)
2022-09-19 00:07:45 ./run-tests.py ap_wpa2_eap_sim_config
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_sim_config 1/1
Test: EAP-SIM configuration options
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS ap_wpa2_eap_sim_config 0.468287 2022-09-19 00:07:46.259609
passed all 1 test case(s)
2022-09-19 00:07:46 ./run-tests.py ap_wpa2_eap_tls_ocsp_invalid_data
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_tls_ocsp_invalid_data 1/1
Test: WPA2-Enterprise connection using EAP-TLS and invalid OCSP data
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_tls_ocsp_invalid_data 0.257844 2022-09-19 00:07:46.911381
passed all 1 test case(s)
2022-09-19 00:07:46 ./run-tests.py ap_wpa2_eap_too_many_roundtrips
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_too_many_roundtrips 1/1
Test: WPA2-Enterprise connection resulting in too many EAP roundtrips
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_too_many_roundtrips 0.366221 2022-09-19 00:07:47.670238
passed all 1 test case(s)
2022-09-19 00:07:47 ./run-tests.py ap_wpa2_eap_ttls_eap_gtc
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_ttls_eap_gtc 1/1
Test: WPA2-Enterprise connection using EAP-TTLS/EAP-GTC
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_ttls_eap_gtc 0.368272 2022-09-19 00:07:48.431477
passed all 1 test case(s)
2022-09-19 00:07:48 ./run-tests.py ap_wpa2_eap_ttls_pap_subject_match
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_ttls_pap_subject_match 1/1
Test: WPA2-Enterprise connection using EAP-TTLS/PAP and (alt)subject_match
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_ttls_pap_subject_match 0.328486 2022-09-19 00:07:49.150059
passed all 1 test case(s)
2022-09-19 00:07:49 ./run-tests.py ap_wpa2_psk_supp_proto
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_psk_supp_proto 1/1
Test: WPA2-PSK 4-way handshake protocol testing for supplicant
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_psk_supp_proto 0.246171 2022-09-19 00:07:49.785025
passed all 1 test case(s)
2022-09-19 00:07:49 ./run-tests.py ap_wpa2_ptk_rekey
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_ptk_rekey 1/1
Test: WPA2-PSK AP and PTK rekey enforced by station
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_ptk_rekey 1.393759 2022-09-19 00:07:51.570609
passed all 1 test case(s)
2022-09-19 00:07:51 ./run-tests.py ap_wps_authenticator_mismatch_m4
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wps_authenticator_mismatch_m4 1/1
Test: WPS and Authenticator attribute mismatch in M4
Starting AP wlan3
PASS ap_wps_authenticator_mismatch_m4 0.296745 2022-09-19 00:07:52.256648
passed all 1 test case(s)
2022-09-19 00:07:52 ./run-tests.py ap_wps_auto_setup_with_config_file
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wps_auto_setup_with_config_file 1/1
Test: WPS auto-setup with configuration file
Starting BSS phy=phy3 ifname=wlan3
PASS ap_wps_auto_setup_with_config_file 0.418885 2022-09-19 00:07:53.067861
passed all 1 test case(s)
2022-09-19 00:07:53 ./run-tests.py ap_wps_config_without_wps
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wps_config_without_wps 1/1
Test: AP configuration attempt using wps_config when WPS is disabled
Starting AP wlan3
PASS ap_wps_config_without_wps 0.139932 2022-09-19 00:07:53.599810
passed all 1 test case(s)
2022-09-19 00:07:53 ./run-tests.py ap_wps_er_add_enrollee
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wps_er_add_enrollee 1/1
Test: WPS ER configuring AP and adding a new enrollee using PIN
Starting AP wlan3
WPS configuration step
Start ER
Learn AP configuration through UPnP
Add Enrollee using ER
Add a specific Enrollee using ER
Verify registrar selection behavior
Stop ER
PASS ap_wps_er_add_enrollee 10.793191 2022-09-19 00:08:04.783507
passed all 1 test case(s)
2022-09-19 00:08:04 ./run-tests.py ap_wps_er_http_proto_no_control_url
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wps_er_http_proto_no_control_url 1/1
Test: WPS ER HTTP protocol testing - no controlURL
HTTP server received: GET /foo.xml HTTP/1.1
HTTP header: Cache-Control: no-cache
HTTP header: Pragma: no-cache
HTTP header: Accept: text/xml, application/xml
HTTP header: User-Agent: wpa_supplicant
HTTP header: Host: 127.0.0.1:12345
PASS ap_wps_er_http_proto_no_control_url 2.10843 2022-09-19 00:08:07.283117
passed all 1 test case(s)
2022-09-19 00:08:07 ./run-tests.py ap_wps_er_multi_add_enrollee
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wps_er_multi_add_enrollee 1/1
Test: Multiple WPS ERs adding a new enrollee using PIN
Starting AP wlan3
PASS ap_wps_er_multi_add_enrollee 2.091808 2022-09-19 00:08:09.766827
passed all 1 test case(s)
2022-09-19 00:08:09 ./run-tests.py ap_wps_m2_unknown_opcode
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wps_m2_unknown_opcode 1/1
Test: WPS and M2 but unknown opcode
Starting AP wlan3
PASS ap_wps_m2_unknown_opcode 0.356332 2022-09-19 00:08:10.515538
passed all 1 test case(s)
2022-09-19 00:08:10 ./run-tests.py ap_wps_pk_oom
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wps_pk_oom 1/1
Test: WPS and public key OOM
Starting AP wlan3
PASS ap_wps_pk_oom 0.386973 2022-09-19 00:08:11.293049
passed all 1 test case(s)
2022-09-19 00:08:11 ./run-tests.py ap_wps_upnp_http_proto
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wps_upnp_http_proto 1/1
Test: WPS AP and UPnP/HTTP protocol testing
Starting AP wlan3
PASS ap_wps_upnp_http_proto 1.389807 2022-09-19 00:08:13.073655
passed all 1 test case(s)
2022-09-19 00:08:13 ./run-tests.py authsrv_testing_options
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START authsrv_testing_options 1/1
Test: Authentication server and testing options
Starting AP wlan4
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS authsrv_testing_options 1.08066 2022-09-19 00:08:14.544384
passed all 1 test case(s)
2022-09-19 00:08:14 ./run-tests.py autogo_join_before_found
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START autogo_join_before_found 1/1
Test: P2P client joining a group before having found GO Device Address
Start autonomous GO wlan0
PASS autogo_join_before_found 0.457874 2022-09-19 00:08:15.389247
passed all 1 test case(s)
2022-09-19 00:08:15 ./run-tests.py dbus_autoscan
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dbus_autoscan 1/1
Test: D-Bus Autoscan()
PASS dbus_autoscan 0.107755 2022-09-19 00:08:15.886982
passed all 1 test case(s)
2022-09-19 00:08:15 ./run-tests.py dbus_p2p_config
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dbus_p2p_config 1/1
Test: D-Bus Get/Set P2PDeviceConfig
PASS dbus_p2p_config 0.111919 2022-09-19 00:08:16.393123
passed all 1 test case(s)
2022-09-19 00:08:16 ./run-tests.py dbus_p2p_go_neg_auth
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dbus_p2p_go_neg_auth 1/1
Test: D-Bus P2P GO Negotiation authorized
wlan1: Trying to discover peer 02:00:00:00:00:00
PASS dbus_p2p_go_neg_auth 1.156668 2022-09-19 00:08:17.941999
passed all 1 test case(s)
2022-09-19 00:08:17 ./run-tests.py discovery_dev_type
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START discovery_dev_type 1/1
Test: P2P device discovery with Device Type filter
PASS discovery_dev_type 1.6599 2022-09-19 00:08:19.993931
passed all 1 test case(s)
2022-09-19 00:08:20 ./run-tests.py dpp_auth_req_stop_after_ack
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_auth_req_stop_after_ack 1/1
Test: DPP initiator stopping after ACK, but no response
PASS dpp_auth_req_stop_after_ack 2.117643 2022-09-19 00:08:22.506710
passed all 1 test case(s)
2022-09-19 00:08:22 ./run-tests.py dpp_conf_file_update
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_conf_file_update 1/1
Test: DPP provisioning updating wpa_supplicant configuration file
dev0 displays QR Code
dev1 scans QR Code and initiates DPP Authentication
PASS dpp_conf_file_update 0.233843 2022-09-19 00:08:23.129357
passed all 1 test case(s)
2022-09-19 00:08:23 ./run-tests.py dpp_config_connector_error_net_access_key_mismatch
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_config_connector_error_net_access_key_mismatch 1/1
Test: DPP Config Object connector error - netAccessKey mismatch
r=28624a8ae324fc387dff019307fc95fff60a97d7df1494c8a3b7198e4f338f57
s=e8cf69c26ac2446f15fb186c633e147444fa186696570676d8cbb3c34a4c9876
dev0 displays QR Code
dev1 scans QR Code and initiates DPP Authentication
PASS dpp_config_connector_error_net_access_key_mismatch 0.122168 2022-09-19 00:08:23.642030
passed all 1 test case(s)
2022-09-19 00:08:23 ./run-tests.py dpp_config_dpp_gen_secp521r1_secp521r1
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_config_dpp_gen_secp521r1_secp521r1 1/1
Test: Generate DPP Config Object for DPP network (P-521 + P-521)
dev0 displays QR Code
dev1 scans QR Code and initiates DPP Authentication
PASS dpp_config_dpp_gen_secp521r1_secp521r1 0.126142 2022-09-19 00:08:24.160213
passed all 1 test case(s)
2022-09-19 00:08:24 ./run-tests.py dpp_config_jwk_error_invalid_x
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_config_jwk_error_invalid_x 1/1
Test: DPP Config Object JWK error - invalid x
dev0 displays QR Code
dev1 scans QR Code and initiates DPP Authentication
PASS dpp_config_jwk_error_invalid_x 0.114668 2022-09-19 00:08:24.665642
passed all 1 test case(s)
2022-09-19 00:08:24 ./run-tests.py dpp_config_jwk_error_no_kid
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_config_jwk_error_no_kid 1/1
Test: DPP Config Object JWK error - no kid
dev0 displays QR Code
dev1 scans QR Code and initiates DPP Authentication
PASS dpp_config_jwk_error_no_kid 0.11877 2022-09-19 00:08:25.176634
passed all 1 test case(s)
2022-09-19 00:08:25 ./run-tests.py dpp_config_jws_error_prot_hdr_unexpected_kid
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_config_jws_error_prot_hdr_unexpected_kid 1/1
Test: DPP Config Object JWS error - protected header - unexpected kid
dev0 displays QR Code
dev1 scans QR Code and initiates DPP Authentication
PASS dpp_config_jws_error_prot_hdr_unexpected_kid 0.11697 2022-09-19 00:08:25.684331
passed all 1 test case(s)
2022-09-19 00:08:25 ./run-tests.py dpp_config_save2
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_config_save2 1/1
Test: DPP configuration saving (2)
dev0 displays QR Code
dev1 scans QR Code and initiates DPP Authentication
Saved configuration:
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=adm
update_config=1
dpp_config_processing=1

network={
	ssid=012a
	psk="secret passphrase"
	key_mgmt=WPA-PSK FT-PSK WPA-PSK-SHA256
	mesh_fwding=1
	disabled=1
	ieee80211w=1
}

PASS dpp_config_save2 0.189978 2022-09-19 00:08:26.261341
passed all 1 test case(s)
2022-09-19 00:08:26 ./run-tests.py dpp_config_signed_connector_error_no_dot_1
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_config_signed_connector_error_no_dot_1 1/1
Test: DPP Config Object signedConnector error - no dot(1)
dev0 displays QR Code
dev1 scans QR Code and initiates DPP Authentication
PASS dpp_config_signed_connector_error_no_dot_1 0.117377 2022-09-19 00:08:26.768671
passed all 1 test case(s)
2022-09-19 00:08:26 ./run-tests.py dpp_pkex_identifier_mismatch2
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_pkex_identifier_mismatch2 1/1
Test: DPP and PKEX with initiator using identifier and the responder not
PASS dpp_pkex_identifier_mismatch2 1.209718 2022-09-19 00:08:28.367651
passed all 1 test case(s)
2022-09-19 00:08:28 ./run-tests.py dpp_pkex_v2_hostapd_responder
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_pkex_v2_hostapd_responder 1/1
Test: DPP PKEXv2 with hostapd as responder
Skip test case: DPP version 3 not supported
SKIP dpp_pkex_v2_hostapd_responder 0.102295 2022-09-19 00:08:28.858170
passed all 0 test case(s)
skipped 1 test case(s)
2022-09-19 00:08:28 ./run-tests.py dpp_proto_after_wrapped_data_conf_req
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_proto_after_wrapped_data_conf_req 1/1
Test: DPP protocol testing - attribute after Wrapped Data in Conf Req
PASS dpp_proto_after_wrapped_data_conf_req 0.114131 2022-09-19 00:08:29.362723
passed all 1 test case(s)
2022-09-19 00:08:29 ./run-tests.py dpp_proto_auth_req_no_wrapped_data
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_proto_auth_req_no_wrapped_data 1/1
Test: DPP protocol testing - no Wrapped Data in Auth Req
PASS dpp_proto_auth_req_no_wrapped_data 0.210775 2022-09-19 00:08:29.965072
passed all 1 test case(s)
2022-09-19 00:08:30 ./run-tests.py dpp_proto_conf_resp_e_nonce_mismatch
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_proto_conf_resp_e_nonce_mismatch 1/1
Test: DPP protocol testing - E-nonce mismatch in Conf Resp
PASS dpp_proto_conf_resp_e_nonce_mismatch 0.116737 2022-09-19 00:08:30.475309
passed all 1 test case(s)
2022-09-19 00:08:30 ./run-tests.py dpp_qr_code_curve_brainpoolP512r1
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_qr_code_curve_brainpoolP512r1 1/1
Test: DPP QR Code and curve brainpoolP512r1
dev0 displays QR Code
dev1 scans QR Code and initiates DPP Authentication
PASS dpp_qr_code_curve_brainpoolP512r1 0.130733 2022-09-19 00:08:30.994778
passed all 1 test case(s)
2022-09-19 00:08:31 ./run-tests.py eap_proto_pax
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START eap_proto_pax 1/1
Test: EAP-PAX protocol tests
Starting AP wlan3
Connect STA wlan0 to AP
Waiting for EAP method to start
pax_handler - RX 02f200090175736572
Test: Missing payload
Connect STA wlan0 to AP
Waiting for EAP method to start
pax_handler - RX 02cc00090175736572
Test: Minimum length payload
Connect STA wlan0 to AP
Waiting for EAP method to start
pax_handler - RX 028800090175736572
Test: Unsupported MAC ID
Connect STA wlan0 to AP
Waiting for EAP method to start
pax_handler - RX 021b00090175736572
Test: Unsupported DH Group ID
Connect STA wlan0 to AP
Waiting for EAP method to start
pax_handler - RX 023f00090175736572
Test: Unsupported Public Key ID
Connect STA wlan0 to AP
Waiting for EAP method to start
pax_handler - RX 02f200090175736572
Test: More fragments
Connect STA wlan0 to AP
Waiting for EAP method to start
pax_handler - RX 020400090175736572
Test: Invalid ICV
Connect STA wlan0 to AP
Waiting for EAP method to start
pax_handler - RX 02d600090175736572
Test: Invalid ICV in short frame
Connect STA wlan0 to AP
Waiting for EAP method to start
pax_handler - RX 029500090175736572
Test: Correct ICV - unsupported op_code
Connect STA wlan0 to AP
Waiting for EAP method to start
pax_handler - RX 027c00090175736572
Test: Correct ICV - CE flag in STD-1
Connect STA wlan0 to AP
Waiting for EAP method to start
pax_handler - RX 023500090175736572
Test: Correct ICV - too short STD-1 payload
Connect STA wlan0 to AP
Waiting for EAP method to start
pax_handler - RX 02b000090175736572
Test: Correct ICV - incorrect A length in STD-1
Connect STA wlan0 to AP
Waiting for EAP method to start
pax_handler - RX 02ac00090175736572
Test: Correct ICV - extra data in STD-1
pax_handler - RX 020a00542e020001000000207fdb4338bf62496594420a4d0edbe52de3356cd1473792acb2bbae06838aaa8600047573657200106d5c9f7ebb89758d7d23c8331dc36b33e77a4a256e50fc249d37664c7c39dd22
Test: Unexpected STD-1
Connect STA wlan0 to AP
Waiting for EAP method to start
pax_handler - RX 023b00090175736572
Test: STD-1
pax_handler - RX 020a00542e02000100000020d365a271919b79b14e6acc5e51b6b177a7e50750e9eece28e3062451888980c40004757365720010ad9c168d9d54c998047a0170ade987e1bf2065e536b9701fdc4d2460b94e1b77
Test: MAC ID changed during session
Connect STA wlan0 to AP
Waiting for EAP method to start
pax_handler - RX 024200090175736572
Test: STD-1
pax_handler - RX 020a00542e02000100000020bcaf5064b0725714cf77c40fc2b115c9278e185020f4a741508dd6eb08f06867000475736572001059c13f40d1065312733e210ae0440692636a35707ca9ba651356939ea4a86e4e
Test: DH Group ID changed during session
Connect STA wlan0 to AP
Waiting for EAP method to start
pax_handler - RX 023200090175736572
Test: STD-1
pax_handler - RX 020a00542e02000100000020ae7c6247e48bfad8d9145ccba5abb535e35510801cc8eb9f680777cead81c82f00047573657200108b5fac8c04dd4b2c1763818a596a4b827838becfd3e94ecf17c87892c356c252
Test: Public Key ID changed during session
Connect STA wlan0 to AP
Waiting for EAP method to start
pax_handler - RX 023900090175736572
Test: Unexpected STD-3
Connect STA wlan0 to AP
Waiting for EAP method to start
pax_handler - RX 021700090175736572
Test: STD-1
pax_handler - RX 020a00542e02000100000020d95c1787654351b51e4969aaef964ecf718e47f01f2420cef2eb092af69127710004757365720010e6d7346dfe0296f5a7fec8664ea6e31a87c307377f3ff40d98fe027c07c06650
Test: STD-3 with CE flag
Too short password
Connect STA wlan0 to AP
pax_handler - RX 024e00090175736572
Test: Default request
pax_handler - RX 020c00060300
Test: Default EAP-Failure
No password
Connect STA wlan0 to AP
pax_handler - RX 022b00090175736572
Test: Default request
pax_handler - RX 020e00060300
Test: Default EAP-Failure
PASS eap_proto_pax 2.132364 2022-09-19 00:08:33.525741
passed all 1 test case(s)
2022-09-19 00:08:33 ./run-tests.py eap_proto_pwd_errors
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START eap_proto_pwd_errors 1/1
Test: EAP-pwd local error cases
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Starting AP wlan4
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS eap_proto_pwd_errors 5.974938 2022-09-19 00:08:39.892628
passed all 1 test case(s)
2022-09-19 00:08:39 ./run-tests.py eap_proto_pwd_invalid_element
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START eap_proto_pwd_invalid_element 1/1
Test: EAP-pwd protocol tests - invalid server element
Starting AP wlan3
Connect STA wlan0 to AP
pwd_handler - RX 02a6000d017077642075736572
Test: Valid id exchange
pwd_handler - RX 0202001734010013010100000000007077642075736572
Test: Commit payload with invalid element
Starting AP wlan3
Connect STA wlan0 to AP
pwd_handler - RX 0268000d017077642075736572
Test: Valid id exchange
pwd_handler - RX 0202001734010013010100000000007077642075736572
Test: Commit payload with invalid element
Starting AP wlan3
Connect STA wlan0 to AP
pwd_handler - RX 02df000d017077642075736572
Test: Valid id exchange
pwd_handler - RX 0202001734010013010100000000007077642075736572
Test: Commit payload with invalid element
Starting AP wlan3
Connect STA wlan0 to AP
pwd_handler - RX 02f1000d017077642075736572
Test: Valid id exchange
pwd_handler - RX 0202001734010013010100000000007077642075736572
Test: Commit payload with invalid element
Starting AP wlan3
Connect STA wlan0 to AP
pwd_handler - RX 0296000d017077642075736572
Test: Valid id exchange
pwd_handler - RX 0202001734010013010100000000007077642075736572
Test: Commit payload with invalid element
Starting AP wlan3
Connect STA wlan0 to AP
pwd_handler - RX 02ae000d017077642075736572
Test: Valid id exchange
pwd_handler - RX 0202001734010013010100000000007077642075736572
Test: Commit payload with invalid element
Starting AP wlan3
Connect STA wlan0 to AP
pwd_handler - RX 0241000d017077642075736572
Test: Valid id exchange
pwd_handler - RX 0202001734010013010100000000007077642075736572
Test: Commit payload with invalid element
PASS eap_proto_pwd_invalid_element 2.080241 2022-09-19 00:08:42.368990
passed all 1 test case(s)
2022-09-19 00:08:42 ./run-tests.py eap_ttls_no_session_resumption
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START eap_ttls_no_session_resumption 1/1
Test: EAP-TTLS session resumption disabled on server
Starting AP wlan3
Connect STA wlan0 to AP
PASS eap_ttls_no_session_resumption 0.328719 2022-09-19 00:08:43.092779
passed all 1 test case(s)
2022-09-19 00:08:43 ./run-tests.py fils_sk_pfs_25
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START fils_sk_pfs_25 1/1
Test: FILS SK with PFS (DH group 25)
Starting AP as-erp
Starting AP wlan3 (old add_ap argument type)
Connect STA wlan0 to AP
PASS fils_sk_pfs_25 0.375759 2022-09-19 00:08:43.860308
passed all 1 test case(s)
2022-09-19 00:08:43 ./run-tests.py fils_sk_pfs_pmksa_caching
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START fils_sk_pfs_pmksa_caching 1/1
Test: FILS SK with PFS and PMKSA caching
Starting AP as-erp
Starting AP wlan3 (old add_ap argument type)
Connect STA wlan0 to AP
PASS fils_sk_pfs_pmksa_caching 0.72049 2022-09-19 00:08:44.969684
passed all 1 test case(s)
2022-09-19 00:08:45 ./run-tests.py fils_sk_pmksa_caching_and_cache_id
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START fils_sk_pmksa_caching_and_cache_id 1/1
Test: FILS SK and PMKSA caching with Cache Identifier
Starting AP wlan3 (old add_ap argument type)
Connect STA wlan0 to AP
Starting AP wlan4 (old add_ap argument type)
PASS fils_sk_pmksa_caching_and_cache_id 0.481356 2022-09-19 00:08:45.844203
passed all 1 test case(s)
2022-09-19 00:08:45 ./run-tests.py fst_ap_initiate_session_response_with_reject
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START fst_ap_initiate_session_response_with_reject 1/1
Test: FST AP initiate session - response with reject
Starting AP wlan3 (old add_ap argument type)
Starting AP wlan4 (old add_ap argument type)
Connect STA wlan5 to AP
Connect STA wlan6 to AP
Success. Bad parameter was detected (Response with reject)
PASS fst_ap_initiate_session_response_with_reject 0.580803 2022-09-19 00:08:46.817490
passed all 1 test case(s)
2022-09-19 00:08:46 ./run-tests.py fst_many_setup
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START fst_many_setup 1/1
Test: FST setup multiple times
Starting AP wlan3
Starting AP wlan4
Connect STA wlan5 to AP
Connect STA wlan6 to AP
PASS fst_many_setup 1.085956 2022-09-19 00:08:48.292558
passed all 1 test case(s)
2022-09-19 00:08:48 ./run-tests.py fst_sta_tear_down_session_bad_fsts_id
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START fst_sta_tear_down_session_bad_fsts_id 1/1
Test: FST STA tear down session - bad fsts id
Starting AP wlan3 (old add_ap argument type)
Starting AP wlan4 (old add_ap argument type)
Connect STA wlan5 to AP
Connect STA wlan6 to AP
Success. Bad parameter was detected (Bad fsts_id)
PASS fst_sta_tear_down_session_bad_fsts_id 5.539195 2022-09-19 00:08:54.223222
passed all 1 test case(s)
2022-09-19 00:08:54 ./run-tests.py gas_max_pending
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START gas_max_pending 1/1
Test: GAS and maximum pending query limit
Starting AP wlan3
PASS gas_max_pending 0.232503 2022-09-19 00:08:54.849150
passed all 1 test case(s)
2022-09-19 00:08:54 ./run-tests.py go_neg_peers_force_diff_freq
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START go_neg_peers_force_diff_freq 1/1
Test: P2P channel selection when peers for different frequency
Start GO negotiation wlan0 -> wlan1
wlan0: Trying to discover peer 02:00:00:00:01:00
go_neg_init_pbc thread caught an exception from p2p_go_neg_init: P2P_CONNECT failed
PASS go_neg_peers_force_diff_freq 15.131628 2022-09-19 00:09:10.373068
passed all 1 test case(s)
2022-09-19 00:09:10 ./run-tests.py grpform
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START grpform 1/1
Test: P2P group formation using PIN and authorized connection (init -> GO)
Start GO negotiation wlan0 -> wlan1
wlan1: Trying to discover peer 02:00:00:00:00:00
wlan0: Trying to discover peer 02:00:00:00:01:00
Group formed
PASS grpform 2.904639 2022-09-19 00:09:13.672863
passed all 1 test case(s)
2022-09-19 00:09:13 ./run-tests.py hapd_ctrl_attach_errors
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START hapd_ctrl_attach_errors 1/1
Test: hostapd ATTACH errors
Starting AP wlan3
PASS hapd_ctrl_attach_errors 0.156188 2022-09-19 00:09:14.222863
passed all 1 test case(s)
2022-09-19 00:09:14 ./run-tests.py ieee8021x_eapol_key
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ieee8021x_eapol_key 1/1
Test: IEEE 802.1X connection and EAPOL-Key protocol tests
Starting AP wlan3
Connect STA wlan0 to AP
PASS ieee8021x_eapol_key 0.297919 2022-09-19 00:09:14.913423
passed all 1 test case(s)
2022-09-19 00:09:14 ./run-tests.py ieee8021x_wep40
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ieee8021x_wep40 1/1
Test: IEEE 802.1X connection using dynamic WEP40
Starting AP wlan3
Connect STA wlan0 to AP
PASS ieee8021x_wep40 0.335043 2022-09-19 00:09:15.643762
passed all 1 test case(s)
2022-09-19 00:09:15 ./run-tests.py macsec_hostapd_psk
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START macsec_hostapd_psk 1/1
Test: MACsec PSK with hostapd
ip link:
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <BROADCAST,MULTICAST> mtu 1500 qdisc fq_codel state DOWN mode DEFAULT group default qlen 1000
    link/ether 00:22:4d:81:6e:ce brd ff:ff:ff:ff:ff:ff
    altname eno1
    altname enp0s25
3: eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc mq state DOWN mode DEFAULT group default qlen 1000
    link/ether b4:96:91:2e:ca:0c brd ff:ff:ff:ff:ff:ff
    altname enp1s0f0
4: eth2: <BROADCAST,MULTICAST> mtu 1500 qdisc mq state DOWN mode DEFAULT group default qlen 1000
    link/ether b4:96:91:2e:ca:0d brd ff:ff:ff:ff:ff:ff
    altname enp1s0f1
5: eth3: <BROADCAST,MULTICAST> mtu 1500 qdisc mq state DOWN mode DEFAULT group default qlen 1000
    link/ether b4:96:91:2e:ca:0e brd ff:ff:ff:ff:ff:ff
    altname enp1s0f2
6: eth4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether b4:96:91:2e:ca:0f brd ff:ff:ff:ff:ff:ff
    altname enp1s0f3
7: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN mode DORMANT group default qlen 1000
    link/ether 02:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
8: wlan1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN mode DORMANT group default qlen 1000
    link/ether 02:00:00:00:01:00 brd ff:ff:ff:ff:ff:ff
9: wlan2: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN mode DORMANT group default qlen 1000
    link/ether 02:00:00:00:02:00 brd ff:ff:ff:ff:ff:ff
10: wlan3: <BROADCAST,MULTICAST> mtu 1500 qdisc mq state DOWN mode DEFAULT group default qlen 1000
    link/ether 02:00:00:00:03:00 brd ff:ff:ff:ff:ff:ff
11: wlan4: <BROADCAST,MULTICAST> mtu 1500 qdisc mq state DOWN mode DEFAULT group default qlen 1000
    link/ether 02:00:00:00:04:00 brd ff:ff:ff:ff:ff:ff
12: wlan5: <BROADCAST,MULTICAST> mtu 1500 qdisc mq state DOWN mode DEFAULT group default qlen 1000
    link/ether 02:00:00:00:05:00 brd ff:ff:ff:ff:ff:ff
13: wlan6: <BROADCAST,MULTICAST> mtu 1500 qdisc mq state DOWN mode DEFAULT group default qlen 1000
    link/ether 02:00:00:00:06:00 brd ff:ff:ff:ff:ff:ff
14: hwsim0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/ieee802.11/radiotap 12:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff

Skip test case: macsec supported (wpa_supplicant CONFIG_MACSEC, CONFIG_DRIVER_MACSEC_LINUX; kernel CONFIG_MACSEC)
SKIP macsec_hostapd_psk 0.259075 2022-09-19 00:09:16.319037
passed all 0 test case(s)
skipped 1 test case(s)
2022-09-19 00:09:16 ./run-tests.py mbo_anqp
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START mbo_anqp 1/1
Test: MBO ANQP
Starting AP wlan3
PASS mbo_anqp 0.188278 2022-09-19 00:09:16.916606
passed all 1 test case(s)
2022-09-19 00:09:16 ./run-tests.py mesh_cnf_rcvd_event_cls_acpt
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START mesh_cnf_rcvd_event_cls_acpt 1/1
Test: Mesh peering management protocol testing - CLS_ACPT event in CNF_RCVD
PASS mesh_cnf_rcvd_event_cls_acpt 0.953935 2022-09-19 00:09:18.260715
passed all 1 test case(s)
2022-09-19 00:09:18 ./run-tests.py mesh_secure_ccmp_256
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START mesh_secure_ccmp_256 1/1
Test: Secure mesh with CCMP-256
PASS mesh_secure_ccmp_256 0.702651 2022-09-19 00:09:19.356300
passed all 1 test case(s)
2022-09-19 00:09:19 ./run-tests.py multi_ap_disabled_on_ap
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START multi_ap_disabled_on_ap 1/1
Test: Multi-AP association attempt when disabled on AP
Starting AP wlan3
Connect STA wlan0 to AP
PASS multi_ap_disabled_on_ap 0.229909 2022-09-19 00:09:19.980505
passed all 1 test case(s)
2022-09-19 00:09:20 ./run-tests.py nfc_wps_password_token_ap
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START nfc_wps_password_token_ap 1/1
Test: WPS registrar configuring an AP using AP password token
Starting AP wlan3
WPS configuration step
PASS nfc_wps_password_token_ap 4.091655 2022-09-19 00:09:24.468883
passed all 1 test case(s)
2022-09-19 00:09:24 ./run-tests.py obss_coex_report_handling1
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START obss_coex_report_handling1 1/1
Test: Overlapping BSS scan report handling with obss_interval=1
Starting AP wlan3
Connect STA wlan0 to AP
PASS obss_coex_report_handling1 6.647073 2022-09-19 00:09:31.512046
passed all 1 test case(s)
2022-09-19 00:09:31 ./run-tests.py openssl_ecdh_curves
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START openssl_ecdh_curves 1/1
Test: OpenSSL ECDH curve configuration
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS openssl_ecdh_curves 0.717227 2022-09-19 00:09:32.620452
passed all 1 test case(s)
2022-09-19 00:09:32 ./run-tests.py p2p_channel_vht80p80_autogo
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START p2p_channel_vht80p80_autogo 1/1
Test: P2P autonomous GO and VHT 80+80 MHz channel
PASS p2p_channel_vht80p80_autogo 1.015746 2022-09-19 00:09:34.027323
passed all 1 test case(s)
2022-09-19 00:09:34 ./run-tests.py p2p_device_grpform_timeout_go
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START p2p_device_grpform_timeout_go 1/1
Test: P2P group formation timeout on GO with cfg80211 P2P Device
wlan0: Trying to discover peer 42:00:00:00:07:00
wlan7: Trying to discover peer 02:00:00:00:00:00
Remaining interfaces: p2p-dev-wlan7
wlan7

PASS p2p_device_grpform_timeout_go 11.026589 2022-09-19 00:09:45.447736
passed all 1 test case(s)
2022-09-19 00:09:45 ./run-tests.py p2p_device_incorrect_command_interface2
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START p2p_device_incorrect_command_interface2 1/1
Test: cfg80211 P2P Device and P2P_GROUP_ADD command on incorrect interface
Group results: {'result': 'success', 'ifname': 'p2p-wlan7-0', 'role': 'GO', 'ssid': 'DIRECT-Cw', 'freq': '2412', 'persistent': False, 'passphrase': 'nFgNjYVp', 'go_dev_addr': '42:00:00:00:08:00'}
PASS p2p_device_incorrect_command_interface2 0.348175 2022-09-19 00:09:46.188429
passed all 1 test case(s)
2022-09-19 00:09:46 ./run-tests.py p2p_msg_empty
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START p2p_msg_empty 1/1
Test: P2P protocol test: empty P2P Public Action frame
Starting AP wlan3
PASS p2p_msg_empty 0.335357 2022-09-19 00:09:46.915124
passed all 1 test case(s)
2022-09-19 00:09:46 ./run-tests.py p2p_service_discovery_external
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START p2p_service_discovery_external 1/1
Test: P2P service discovery using external response
wlan1: Trying to discover peer 02:00:00:00:00:00
wlan1: Trying to discover peer 02:00:00:00:00:00
PASS p2p_service_discovery_external 0.616994 2022-09-19 00:09:47.921808
passed all 1 test case(s)
2022-09-19 00:09:47 ./run-tests.py p2p_service_discovery_fragmentation
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START p2p_service_discovery_fragmentation 1/1
Test: P2P service discovery with fragmentation
wlan1: Trying to discover peer 02:00:00:00:00:00
wlan1: Trying to discover peer 02:00:00:00:00:00
PASS p2p_service_discovery_fragmentation 1.651385 2022-09-19 00:09:49.964644
passed all 1 test case(s)
2022-09-19 00:09:50 ./run-tests.py p2ps_connect_p2ps_method_2
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START p2ps_connect_p2ps_method_2 1/1
Test: P2PS connection with P2PS method - group interface on dev0
PASS p2ps_connect_p2ps_method_2 0.950564 2022-09-19 00:09:51.306736
passed all 1 test case(s)
2022-09-19 00:09:51 ./run-tests.py p2ps_go_probe
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START p2ps_go_probe 1/1
Test: P2PS GO discoverability on operating channel
PASS p2ps_go_probe 0.904817 2022-09-19 00:09:52.605140
passed all 1 test case(s)
2022-09-19 00:09:52 ./run-tests.py radius_failover
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START radius_failover 1/1
Test: RADIUS Authentication and Accounting server failover
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS radius_failover 21.397694 2022-09-19 00:10:14.397702
passed all 1 test case(s)
2022-09-19 00:10:14 ./run-tests.py radius_psk_invalid2
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START radius_psk_invalid2 1/1
Test: WPA2 with invalid PSK (hexstring) from RADIUS
Starting AP wlan3
Connect STA wlan0 to AP
Received authentication request
PASS radius_psk_invalid2 1.223159 2022-09-19 00:10:16.011656
passed all 1 test case(s)
2022-09-19 00:10:16 ./run-tests.py rrm_beacon_req_active_no_ir
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START rrm_beacon_req_active_no_ir 1/1
Test: Beacon request - active scan mode and NO_IR channel
Starting AP wlan3
Connect STA wlan0 to AP
Beacon report: opclass=81 channel=1 start=0 duration=100 frame_info=7 rcpi=160 rsni=255 bssid=02:00:00:00:03:00 antenna_id=0 parent_tsf=2303594766 frame_body=0e114e89fce8050064000114000372726d010882848b960c1218240301012a010432043048606c460570000000003b0251002d1a0c001bffff0000000000000000000001000000000000000000003d16010000000000000000000000000000000000000000007f080400400200000040dd180050f2020101010003a4000027a4000042435e0062322f00 fragment_id=0100
PASS rrm_beacon_req_active_no_ir 0.395183 2022-09-19 00:10:16.802243
passed all 1 test case(s)
2022-09-19 00:10:16 ./run-tests.py rrm_beacon_req_active_single_channel
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START rrm_beacon_req_active_single_channel 1/1
Test: Beacon request - active scan mode with single channel
Starting AP wlan3
Starting AP wlan4
Connect STA wlan0 to AP
Received beacon report: opclass=81 channel=11 start=0 duration=100 frame_info=7 rcpi=160 rsni=255 bssid=02:00:00:00:04:00 antenna_id=0 parent_tsf=2304311515 frame_body=ace75989fce80500640001040007616e6f74686572010882848b960c12182403010b2a010432043048606c3b0251002d1a0c001bffff0000000000000000000001000000000000000000003d160b0000000000000000000000000000000000000000007f080400400200000040dd180050f2020101010003a4000027a4000042435e0062322f00 fragment_id=0100
PASS rrm_beacon_req_active_single_channel 0.371041 2022-09-19 00:10:17.582039
passed all 1 test case(s)
2022-09-19 00:10:17 ./run-tests.py rrm_lci_req_ap_oom
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START rrm_lci_req_ap_oom 1/1
Test: LCI report generation AP OOM and failure
Starting AP wlan3 (old add_ap argument type)
Connect STA wlan0 to AP
PASS rrm_lci_req_ap_oom 0.249236 2022-09-19 00:10:18.241328
passed all 1 test case(s)
2022-09-19 00:10:18 ./run-tests.py rrm_lci_req_oom
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START rrm_lci_req_oom 1/1
Test: LCI report generation OOM
Starting AP wlan3 (old add_ap argument type)
Connect STA wlan0 to AP
PASS rrm_lci_req_oom 0.236908 2022-09-19 00:10:18.887575
passed all 1 test case(s)
2022-09-19 00:10:18 ./run-tests.py sae_commit_override
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_commit_override 1/1
Test: SAE commit override (hostapd)
Starting AP wlan3
Connect STA wlan0 to AP
PASS sae_commit_override 1.1788 2022-09-19 00:10:20.459970
passed all 1 test case(s)
2022-09-19 00:10:20 ./run-tests.py sae_confirm_immediate2
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_confirm_immediate2 1/1
Test: SAE and AP sending Confirm message without waiting STA (2)
Starting AP wlan3
Connect STA wlan0 to AP
PASS sae_confirm_immediate2 0.282411 2022-09-19 00:10:21.134563
passed all 1 test case(s)
2022-09-19 00:10:21 ./run-tests.py sae_h2e_rsnxe_mismatch_ap
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_h2e_rsnxe_mismatch_ap 1/1
Test: SAE H2E and RSNXE mismatch in EAPOL-Key msg 3/4
Starting AP wlan3
Connect STA wlan0 to AP
PASS sae_h2e_rsnxe_mismatch_ap 0.25031 2022-09-19 00:10:21.774819
passed all 1 test case(s)
2022-09-19 00:10:21 ./run-tests.py sae_pk_group_20_sae_group_21
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_pk_group_20_sae_group_21 1/1
Test: SAE-PK with group 20 with SAE group 21
Starting AP wlan3
Connect STA wlan0 to AP
PASS sae_pk_group_20_sae_group_21 0.377547 2022-09-19 00:10:22.545227
passed all 1 test case(s)
2022-09-19 00:10:22 ./run-tests.py sigma_dut_ap_eap_osen
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_eap_osen 1/1
Test: sigma_dut controlled AP with EAP+OSEN
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_eap_osen 0.145263 2022-09-19 00:10:23.084478
passed all 0 test case(s)
skipped 1 test case(s)
2022-09-19 00:10:23 ./run-tests.py sigma_dut_ap_owe_transition_mode_2
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_owe_transition_mode_2 1/1
Test: sigma_dut controlled AP with OWE and transition mode (2)
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_owe_transition_mode_2 0.145263 2022-09-19 00:10:23.622484
passed all 0 test case(s)
skipped 1 test case(s)
2022-09-19 00:10:23 ./run-tests.py sigma_dut_dpp_self_config
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_self_config 1/1
Test: sigma_dut DPP Configurator enrolling an AP and using self-configuration
Starting AP wlan3
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_self_config 0.153047 2022-09-19 00:10:24.170003
passed all 0 test case(s)
skipped 1 test case(s)
2022-09-19 00:10:24 ./run-tests.py sigma_dut_dpp_tcp_conf_resp
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_tcp_conf_resp 1/1
Test: sigma_dut DPP TCP Configurator (Controller) as responder
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_tcp_conf_resp 0.10583 2022-09-19 00:10:24.667335
passed all 0 test case(s)
skipped 1 test case(s)
2022-09-19 00:10:24 ./run-tests.py sigma_dut_ocv
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ocv 1/1
Test: sigma_dut controlled STA using OCV
Skip test case: sigma_dut not available
SKIP sigma_dut_ocv 0.105053 2022-09-19 00:10:25.166934
passed all 0 test case(s)
skipped 1 test case(s)
2022-09-19 00:10:25 ./run-tests.py wep_he
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wep_he 1/1
Test: WEP and HE
Starting AP wlan3
Connect STA wlan0 to AP
hostapd STATUS: {'state': 'ENABLED', 'phy': 'phy3', 'freq': '2412', 'num_sta_non_erp': '0', 'num_sta_no_short_slot_time': '0', 'num_sta_no_short_preamble': '0', 'olbc': '0', 'num_sta_ht_no_gf': '0', 'num_sta_no_ht': '1', 'num_sta_ht_20_mhz': '0', 'num_sta_ht40_intolerant': '0', 'olbc_ht': '0', 'ht_op_mode': '0x13', 'cac_time_seconds': '0', 'cac_time_left_seconds': 'N/A', 'channel': '1', 'edmg_enable': '0', 'edmg_channel': '0', 'secondary_channel': '0', 'ieee80211n': '0', 'ieee80211ac': '0', 'ieee80211ax': '0', 'ieee80211be': '0', 'beacon_int': '100', 'dtim_period': '2', 'supported_rates': '02 04 0b 16 0c 12 18 24 30 48 60 6c', 'max_txpower': '20', 'bss[0]': 'wlan3', 'bssid[0]': '02:00:00:00:03:00', 'ssid[0]': 'test-he-wep', 'num_sta[0]': '1'}
PASS wep_he 0.382407 2022-09-19 00:10:25.943186
passed all 1 test case(s)
2022-09-19 00:10:25 ./run-tests.py wnm_bss_transition_mgmt_query_with_unknown_candidates
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wnm_bss_transition_mgmt_query_with_unknown_candidates 1/1
Test: WNM BSS Transition Management query with unknown candidates
Starting AP wlan3
Connect STA wlan0 to AP
PASS wnm_bss_transition_mgmt_query_with_unknown_candidates 0.251661 2022-09-19 00:10:26.605021
passed all 1 test case(s)
2022-09-19 00:10:26 ./run-tests.py wnm_sleep_mode_rsn_pmf_key_workaround
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wnm_sleep_mode_rsn_pmf_key_workaround 1/1
Test: WNM Sleep Mode - RSN with PMF and GTK/IGTK workaround
Starting AP wlan3
Connect STA wlan0 to AP
Going to WNM Sleep Mode
Waking up from WNM Sleep Mode
PASS wnm_sleep_mode_rsn_pmf_key_workaround 0.558935 2022-09-19 00:10:27.580781
passed all 1 test case(s)
2022-09-19 00:10:27 ./run-tests.py wpas_ctrl_enable_disable_network
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wpas_ctrl_enable_disable_network 1/1
Test: wpa_supplicant ctrl_iface ENABLE/DISABLE_NETWORK
Starting AP wlan3
Connect STA wlan0 to AP
PASS wpas_ctrl_enable_disable_network 0.406651 2022-09-19 00:10:28.398827
passed all 1 test case(s)
2022-09-19 00:10:28 ./run-tests.py wpas_ctrl_pno
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wpas_ctrl_pno 1/1
Test: wpa_supplicant ctrl_iface pno
PASS wpas_ctrl_pno 0.116904 2022-09-19 00:10:28.922213
passed all 1 test case(s)
2022-09-19 00:10:28 ./run-tests.py wpas_ctrl_preauth
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wpas_ctrl_preauth 1/1
Test: wpa_supplicant ctrl_iface preauth
PASS wpas_ctrl_preauth 0.140118 2022-09-19 00:10:29.469492
passed all 1 test case(s)
2022-09-19 00:10:29 ./run-tests.py wpas_ctrl_set_tdls_trigger_control
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wpas_ctrl_set_tdls_trigger_control 1/1
Test: wpa_supplicant SET tdls_trigger_control
PASS wpas_ctrl_set_tdls_trigger_control 0.11203 2022-09-19 00:10:29.990416
passed all 1 test case(s)
2022-09-19 00:10:30 ./run-tests.py wps_ext_cred_proto_auth_type_missing
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wps_ext_cred_proto_auth_type_missing 1/1
Test: WPS and Credential: Auth Type missing
Starting AP wlan3
PASS wps_ext_cred_proto_auth_type_missing 0.330193 2022-09-19 00:10:30.730663
passed all 1 test case(s)
2022-09-19 00:10:30 ./stop.sh

--2BOLdwFwC2i4cuCA
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"

---
:#! jobs/hwsim-part1.yaml:
suite: hwsim
testcase: hwsim
category: functional
need_memory: 1G
hwsim:
  test: group-03
job_origin: hwsim-part1.yaml
:#! queue options:
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-ivb-d01
tbox_group: lkp-ivb-d01
submit_id: 6326a4a6a825953634d8a1cb
job_file: "/lkp/jobs/scheduled/lkp-ivb-d01/hwsim-group-03-debian-11.1-x86_64-20220510.cgz-662cceb50ea735492ff67b5ecdbc8d9de15212bd-20220918-13876-1ksr3bk-0.yaml"
id: e847287ebe930a30321cfc02f6f02774d8b832bc
queuer_version: "/zday/lkp"
:#! hosts/lkp-ivb-d01:
model: Ivy Bridge
nr_node: 1
nr_cpu: 8
memory: 16G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL42040066800RGN-part2"
hdd_partitions: "/dev/disk/by-id/ata-WDC_WD10EACS-22D6B0_WD-WCAU45298688-part*"
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL42040066800RGN-part1"
brand: Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz
:#! include/category/functional:
kmsg:
heartbeat:
meminfo:
:#! include/hwsim:
need_kconfig:
- WLAN: y
- PACKET: y
- CFG80211: m
- CFG80211_WEXT: y
- MAC80211: m
- MAC80211_HWSIM: m
- MAC80211_LEDS: y
- MAC80211_MESH: y
- MAC80211_DEBUGFS: y
- VETH: m
- BRIDGE: m
- MACSEC: m
:#! include/queue/cyclic:
commit: 662cceb50ea735492ff67b5ecdbc8d9de15212bd
:#! include/testbox/lkp-ivb-d01:
netconsole_port: 6672
ucode: '0x21'
need_kconfig_hw:
- PTP_1588_CLOCK: y
- IGB: y
- E1000E: y
- SATA_AHCI
- DRM_I915
bisect_dmesg: true
kconfig: x86_64-rhel-8.3-func
enqueue_time: 2022-09-18 12:55:02.520266645 +08:00
_id: 6326a4a6a825953634d8a1cb
_rt: "/result/hwsim/group-03/lkp-ivb-d01/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/662cceb50ea735492ff67b5ecdbc8d9de15212bd"
:#! schedule options:
user: lkp
compiler: gcc-11
LKP_SERVER: internal-lkp-server
head_commit: 3d89333c9e54e4b60aea771ce414b6986433cfb1
base_commit: 80e78fcce86de0288793a0ef0f6acf37656ee4cf
branch: linux-devel/devel-hourly-20220916-210302
rootfs: debian-11.1-x86_64-20220510.cgz
result_root: "/result/hwsim/group-03/lkp-ivb-d01/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/662cceb50ea735492ff67b5ecdbc8d9de15212bd/0"
scheduler_version: "/lkp/lkp/.src-20220915-165923"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-11.1-x86_64-20220510.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/hwsim/group-03/lkp-ivb-d01/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/662cceb50ea735492ff67b5ecdbc8d9de15212bd/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/662cceb50ea735492ff67b5ecdbc8d9de15212bd/vmlinuz-6.0.0-rc3-00691-g662cceb50ea7
- branch=linux-devel/devel-hourly-20220916-210302
- job=/lkp/jobs/scheduled/lkp-ivb-d01/hwsim-group-03-debian-11.1-x86_64-20220510.cgz-662cceb50ea735492ff67b5ecdbc8d9de15212bd-20220918-13876-1ksr3bk-0.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-func
- commit=662cceb50ea735492ff67b5ecdbc8d9de15212bd
- max_uptime=2100
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-func/gcc-11/662cceb50ea735492ff67b5ecdbc8d9de15212bd/modules.cgz"
bm_initrd: "/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hwsim_20220523.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/hwsim-x86_64-717e5d7-1_20220525.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20220804.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn
:#! /cephfs/db/releases/20220916204556/lkp-src/include/site/inn:
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
:#! runtime status:
last_kernel: 4.20.0
schedule_notify_address:
:#! user overrides:
kernel: "/pkg/linux/x86_64-rhel-8.3-func/gcc-11/662cceb50ea735492ff67b5ecdbc8d9de15212bd/vmlinuz-6.0.0-rc3-00691-g662cceb50ea7"
dequeue_time: 2022-09-18 13:17:51.279982103 +08:00
:#! /cephfs/db/releases/20220917110950/lkp-src/include/site/inn:
job_state: finished
loadavg: 0.77 1.10 0.58 1/186 9036
start_time: '1663478322'
end_time: '1663478575'
version: "/lkp/lkp/.src-20220915-165959:c2c744bac:b38a79b27"

--2BOLdwFwC2i4cuCA
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="reproduce"

export USER=root
./build.sh
./start.sh
./run-tests.py ap_ft_ap_oom3b
./run-tests.py ap_ft_sae
./run-tests.py ap_ft_sae_over_ds_ptk_rekey0
./run-tests.py ap_ft_vlan_over_ds_many
./run-tests.py ap_hs20_eap_cert_unknown
./run-tests.py ap_hs20_eap_ttls_chap
./run-tests.py ap_hs20_fetch_osu_single_ssid2
./run-tests.py ap_hs20_interworking_oom
./run-tests.py ap_hs20_min_bandwidth_home2
./run-tests.py ap_hs20_network_preference4
./run-tests.py ap_hs20_sim_imsi_privacy
./run-tests.py ap_hs20_sim_oom
./run-tests.py ap_open_poll_sta_no_ack
./run-tests.py ap_open_tdls_vht80
./run-tests.py ap_pmf_assoc_comeback2
./run-tests.py ap_pmf_required_eap
./run-tests.py ap_tdls_chan_switch_prohibit
./run-tests.py ap_vht_csa_vht80p80
./run-tests.py ap_wds_sta_wep
./run-tests.py ap_wmm_uapsd
./run-tests.py ap_wpa2_eap_fast_mschapv2_unauth_prov
./run-tests.py ap_wpa2_eap_fast_prov
./run-tests.py ap_wpa2_eap_no_workaround
./run-tests.py ap_wpa2_eap_sim
./run-tests.py ap_wpa2_eap_sim_config
./run-tests.py ap_wpa2_eap_tls_ocsp_invalid_data
./run-tests.py ap_wpa2_eap_too_many_roundtrips
./run-tests.py ap_wpa2_eap_ttls_eap_gtc
./run-tests.py ap_wpa2_eap_ttls_pap_subject_match
./run-tests.py ap_wpa2_psk_supp_proto
./run-tests.py ap_wpa2_ptk_rekey
./run-tests.py ap_wps_authenticator_mismatch_m4
./run-tests.py ap_wps_auto_setup_with_config_file
./run-tests.py ap_wps_config_without_wps
./run-tests.py ap_wps_er_add_enrollee
./run-tests.py ap_wps_er_http_proto_no_control_url
./run-tests.py ap_wps_er_multi_add_enrollee
./run-tests.py ap_wps_m2_unknown_opcode
./run-tests.py ap_wps_pk_oom
./run-tests.py ap_wps_upnp_http_proto
./run-tests.py authsrv_testing_options
./run-tests.py autogo_join_before_found
./run-tests.py dbus_autoscan
./run-tests.py dbus_p2p_config
./run-tests.py dbus_p2p_go_neg_auth
./run-tests.py discovery_dev_type
./run-tests.py dpp_auth_req_stop_after_ack
./run-tests.py dpp_conf_file_update
./run-tests.py dpp_config_connector_error_net_access_key_mismatch
./run-tests.py dpp_config_dpp_gen_secp521r1_secp521r1
./run-tests.py dpp_config_jwk_error_invalid_x
./run-tests.py dpp_config_jwk_error_no_kid
./run-tests.py dpp_config_jws_error_prot_hdr_unexpected_kid
./run-tests.py dpp_config_save2
./run-tests.py dpp_config_signed_connector_error_no_dot_1
./run-tests.py dpp_pkex_identifier_mismatch2
./run-tests.py dpp_pkex_v2_hostapd_responder
./run-tests.py dpp_proto_after_wrapped_data_conf_req
./run-tests.py dpp_proto_auth_req_no_wrapped_data
./run-tests.py dpp_proto_conf_resp_e_nonce_mismatch
./run-tests.py dpp_qr_code_curve_brainpoolP512r1
./run-tests.py eap_proto_pax
./run-tests.py eap_proto_pwd_errors
./run-tests.py eap_proto_pwd_invalid_element
./run-tests.py eap_ttls_no_session_resumption
./run-tests.py fils_sk_pfs_25
./run-tests.py fils_sk_pfs_pmksa_caching
./run-tests.py fils_sk_pmksa_caching_and_cache_id
./run-tests.py fst_ap_initiate_session_response_with_reject
./run-tests.py fst_many_setup
./run-tests.py fst_sta_tear_down_session_bad_fsts_id
./run-tests.py gas_max_pending
./run-tests.py go_neg_peers_force_diff_freq
./run-tests.py grpform
./run-tests.py hapd_ctrl_attach_errors
./run-tests.py ieee8021x_eapol_key
./run-tests.py ieee8021x_wep40
./run-tests.py macsec_hostapd_psk
./run-tests.py mbo_anqp
./run-tests.py mesh_cnf_rcvd_event_cls_acpt
./run-tests.py mesh_secure_ccmp_256
./run-tests.py multi_ap_disabled_on_ap
./run-tests.py nfc_wps_password_token_ap
./run-tests.py obss_coex_report_handling1
./run-tests.py openssl_ecdh_curves
./run-tests.py p2p_channel_vht80p80_autogo
./run-tests.py p2p_device_grpform_timeout_go
./run-tests.py p2p_device_incorrect_command_interface2
./run-tests.py p2p_msg_empty
./run-tests.py p2p_service_discovery_external
./run-tests.py p2p_service_discovery_fragmentation
./run-tests.py p2ps_connect_p2ps_method_2
./run-tests.py p2ps_go_probe
./run-tests.py radius_failover
./run-tests.py radius_psk_invalid2
./run-tests.py rrm_beacon_req_active_no_ir
./run-tests.py rrm_beacon_req_active_single_channel
./run-tests.py rrm_lci_req_ap_oom
./run-tests.py rrm_lci_req_oom
./run-tests.py sae_commit_override
./run-tests.py sae_confirm_immediate2
./run-tests.py sae_h2e_rsnxe_mismatch_ap
./run-tests.py sae_pk_group_20_sae_group_21
./run-tests.py sigma_dut_ap_eap_osen
./run-tests.py sigma_dut_ap_owe_transition_mode_2
./run-tests.py sigma_dut_dpp_self_config
./run-tests.py sigma_dut_dpp_tcp_conf_resp
./run-tests.py sigma_dut_ocv
./run-tests.py wep_he
./run-tests.py wnm_bss_transition_mgmt_query_with_unknown_candidates
./run-tests.py wnm_sleep_mode_rsn_pmf_key_workaround
./run-tests.py wpas_ctrl_enable_disable_network
./run-tests.py wpas_ctrl_pno
./run-tests.py wpas_ctrl_preauth
./run-tests.py wpas_ctrl_set_tdls_trigger_control
./run-tests.py wps_ext_cred_proto_auth_type_missing
./stop.sh

--2BOLdwFwC2i4cuCA--
