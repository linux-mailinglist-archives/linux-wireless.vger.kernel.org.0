Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBC9530C9E
	for <lists+linux-wireless@lfdr.de>; Mon, 23 May 2022 12:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbiEWJVs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 May 2022 05:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbiEWJVr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 May 2022 05:21:47 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C327695A3
        for <linux-wireless@vger.kernel.org>; Mon, 23 May 2022 02:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653297705; x=1684833705;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4ZGONVVucfo3cPBovjHMKu77h9dIEuVxQcvznjKuVyM=;
  b=clQ7uKvBeP8xWFN5taz7yHSHO0XoE1tPuk2+DGv+HbpB/3M9FbqZpVXA
   crT+fHMJzwuPR2GVVjnfVnl3oLmosSOyER9Kpdqwa7nHuz2oS+a/lW0Tx
   LX2znTwqjExJGPFP2NKd/3z+m+UJl4AagdFs088jeO+k4WO/GP06EgOpS
   DCnToiV8KDJh8uloxf8oc9twYOLrlpLNHZtq50weLg0r8YsjNvY7t+F35
   qHHxmVrzpsf/hURh+8bXWCkrk75QRKx0OPsCPfsumQanu34BdDOCH11P/
   CU6A3HNHWu3H6u7cDpDEsunsR4PKEPcCAYc4zvtWSVFrFeuhfBmEaeznV
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="253036858"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="253036858"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 02:21:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="608107458"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga001.jf.intel.com with ESMTP; 23 May 2022 02:21:36 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 23 May 2022 02:21:35 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 23 May 2022 02:21:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 23 May 2022 02:21:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 23 May 2022 02:20:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tmee71LXKp1YwbDApzXP7yz+nmhR8KyuOdCF8c4F4rdOIA2EkelunhfA2zgfEBqLhv/qdtgC19WEbl2/hixjFwrFRT49bfWMeS347ofZYj3rnTwyZjFM/djr++gjKUNjkyFTd2sK4yW4FHoWbEGaZOpmDYFY71/8CD1zG12D889fb5p4dQ/Na4yteSbFsD+5Y6ZG255SZnQjFAWktV180Udh2bPt7xpDAVSyxvS5a3EUrvzdn+ArBRLXMyBvYfvPnAFS+QwSKej0nqVIcDANsLY4G9hFrQNu0V+YaQIW4OqO6UjE9izfOJKYmDwrzZ0WNkg7Sf2aLcUIhqC1zBwS4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qePh2Wgyza6i17d5sHYIb2/Oh7YD3WWAUiEHoisZOGs=;
 b=dFhRK8RuxJrGPWAdeknf1uDcCyi+FBVcyu6eM6SSt8sTgWidViGwUb04aQLegTUxQ/tgA3RPYEybUaiJyccMIl0H8dl+C8x4hkvP1yselCiHktQjGSDPRptdouh/40A/7VLRZQIBa6t91m+GlhI0cKZJjxGFIa/+opMz+O+FHdOLIwpWDyQ8h2A/ONE0tfb5qFpKt3kQtZpi5og/DKPe6vaza7Wpm5hF1YiYO2xATomqLPMOXCflcD7198OhScB+45ckx3NBhQJGY09GH3+Sz55P0XsD2TZDx2bIUDugsTT6AisdVk2aSmFIIq866GgHHXrZRCVyMmg0h5HwFp98jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
 by DM5PR11MB2028.namprd11.prod.outlook.com (2603:10b6:3:d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.16; Mon, 23 May 2022 09:20:45 +0000
Received: from MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::1169:fc9:c1ef:248e]) by MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::1169:fc9:c1ef:248e%9]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 09:20:45 +0000
Message-ID: <0425c779-8b2d-12ca-0361-ac7c6b93b00d@intel.com>
Date:   Mon, 23 May 2022 17:20:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: [wireless-next:mld 6/7] drivers/net/wireless/rsi/rsi_91x_hal.c:310:2:
 warning: Value stored to 'bss' is never read
 [clang-analyzer-deadcode.DeadStores]
References: <202205230957.U8pTkdJT-lkp@intel.com>
Content-Language: en-US
To:     Johannes Berg <johannes.berg@intel.com>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202205230957.U8pTkdJT-lkp@intel.com>
X-Forwarded-Message-Id: <202205230957.U8pTkdJT-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0183.apcprd06.prod.outlook.com (2603:1096:4:1::15)
 To MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a88bafa2-984a-4f95-4038-08da3c9d83be
X-MS-TrafficTypeDiagnostic: DM5PR11MB2028:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR11MB2028D2222C46BD04C2BAECCFFBD49@DM5PR11MB2028.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZssK52erLy6Y3WhjobthO3SVohA7za2UtyK1cq65vcNhvjtnx3NikB01u4P74CgpXxXqZinSXEns1cSQaQ6j9yK0nDWGOaupWS/IwcCkoScFMqaTueGdB7QtVicXnYOY2G+Cqi+yIqaJD0M3JDBfDUn4U3uzru53LVJwXyMJ4rNh6bfq+J3kgd148DuQORp59yyW4kPH1kAIJYivCN1KbnXnPp6UxUJjp89bLKCL8IDdDhB5bT2lfHhVQXavsKfVH3pUZQiyzoGk5y3RDjinwRYehqFzei9V1lQqsCNDy7WjHCn58XXscEVjXU4YszWT92aehn6iDyJXPtqjmPT1OYLLngRP6+Yb441NMO2sTTC146VkaF/e6e97m8/r9wl0R1YnIVRfswHg724rZZpECSMJ7NqfNQszuXZlwZ49MAxcVPRhoJ0KwdYTQ9l3n6porkKB6NSiWjmUXhqrhysqdzCPWQkb3Qfv5/Lf/kWjuo26l1xNPs1OKm5TDYygoMBJqzc+W0AZqkvdqYSMqnlXZxRU2UdiFRyC1Jbo0fm+ZslSXdUQ2EZh/Sh+rl3/968jIZ3/UBxKgIhlv2f1Cxexp0AdMRQ/tRw5di9TfqkZaOA2IPnt9dd6Jmo6tkYKVfKvFsA0ogDjYT4keIpZsjIlGhPRwB/+jZmfyWjq+e6mrpmrY11eKivUzZMp4a8xHzEkgOsVcuh9T0N9PrhO1CI9pyIqPfU/bs1AusIi9pAiZcMas0O1KYuG2ES4UTQJglTPbqrbcRG3v9QgvIyqHfKA1zYV/sJqvCfU2YBZmQOzEBNFFDBvrlwr00jNz/21Qrze1MfkePmEPr1UroWsyDvneV4bmakFA9q+JGa4+bKNMBI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5933.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6486002)(966005)(6666004)(316002)(6512007)(2616005)(54906003)(37006003)(6636002)(31696002)(2906002)(6506007)(186003)(26005)(86362001)(4326008)(82960400001)(36756003)(5660300002)(8936002)(8676002)(38100700002)(31686004)(66476007)(6862004)(66946007)(66556008)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmFMRG1YYkFlY3NNektOaS9aeDhILzZscHZya25jRm0vS3VOdFYzdWJYU2VU?=
 =?utf-8?B?Q0R0TzZlenlQU3ZQM1FwWStRUU5EUHliQ3pGZmdGNSsrN1dJNFMyRlZqeElT?=
 =?utf-8?B?bjB3S3BNbTc4VFM1YmpPVjl3cFBkQ0doZnlYUGw0bUhEQnNxVnRrdGdPQ1Zm?=
 =?utf-8?B?eXRXUzcvWDVoNXVMbUFMTUdNYWxLTTMwR0p3MHBlcUZjcEF0OFhXMG5lMklt?=
 =?utf-8?B?d1BpbTVQb0pmODlwVkd6N2xRbWUzMzkzRmk5UkRuNVJ4N3VlQnAzZHkvV29x?=
 =?utf-8?B?cW1hbFZwNjRleEY1NHBsOFFRb3Qxa01aMjdmUnNzM2lHYWNaamhvc2Vxai9k?=
 =?utf-8?B?bmhpQW0yQi9CSUgxRTFlT21ZckxWbXlnVHA2Zmx0eWdlVUpERjBUNHRNeGYx?=
 =?utf-8?B?WUNKdXh5WGVuZ3R0NFZIQUQwL20wQ0E0YXZxNTkzVkozazBURTlzbDQ3ZXNy?=
 =?utf-8?B?RDQzUFRUMnROWHM3bEM0clNUOG5YTU9WL0VJTllNNmc2bllHN3RENlF1c3NJ?=
 =?utf-8?B?eWM2RnlVaDczTmVyY0pyRzl0Tlo4UjlPOXVaOHMvb3pISVJ2cE9wK3JWRzZN?=
 =?utf-8?B?OXQ4TnVYRUNRRUtuZUo5UmdrZ1BKaG5mbmZBUFhUZ2Fpc2FSVnpDSFJyZUZP?=
 =?utf-8?B?WnhEK0t4TEcvSTBIR01XZWJDNFRnWG9hYVVRUlV3OTZUZnJRK3JuMkYvTjF1?=
 =?utf-8?B?OERoNEw3bGFSaStjNkNDdUp0bmdPajNnaENMVDFjbUt2bUVVOWFUWWNEcjJr?=
 =?utf-8?B?STRkUlJydU01amJURDdnMzQzK3lMWU9ZOEhham1aRkRtVDB0SWd0V1NjRS9N?=
 =?utf-8?B?dG0zMi92NDZSSU1oNk05eHVXUnpDSlJudGFoRmR1emphVmZ1V3E5YlZNZEN6?=
 =?utf-8?B?R3JDN3BmYXQzZUZvUUxMTGtFWTM0alJKdEdOVEtmb0l5bW84TFJpZjI0d3NX?=
 =?utf-8?B?SjZ4YnQybUdXNGUxMDBSMGNheGJvVUNxUTdxQjllNWpOcDh1WFVSWHJWSEpo?=
 =?utf-8?B?NWNVYWd5QlRpSFFYaUZ2clRvYmxlK3UyQm51bU1raDZqQ20wRFFYZlBXeGNO?=
 =?utf-8?B?b3kyZHpjMlRVdGpFSU1vTHU4cWZlbXdIYnQ5b3RBRE5QQnJuQU52aDNQTWwv?=
 =?utf-8?B?b2llNnpOZFpDZ3Q4d0VmcnJzV3dzYjBCR3lQYnRLcmxTcUhuYURUSHZtU01i?=
 =?utf-8?B?QmRKM0doVnNaMlJaQ3JEelVVd09xTEsvQm9jVGFsVS9YcEZuSXc5dVRrVExt?=
 =?utf-8?B?U1IyMHI3ZDZwN2pySzdJYVBxSDk3L0J3Y3BOaGJDSDE0ejhZWTJWQzFEcDJ0?=
 =?utf-8?B?UE1FS3JuTDFOdEhUWmZyZUdnODE1RGd2QXoyT0FGdEdOVkUrNDhaNnd2ckt1?=
 =?utf-8?B?enRQK0NudzdlS2ZsalBEL1FlT1gxcmdveXhHRVlwUjNtaDdoenpKV3NtNTYr?=
 =?utf-8?B?dWF5MTNuQTEwbHRrVFluaTFkRGxmc0dOSU50cmhDQzZaV0FuZWhNb2VXWEZH?=
 =?utf-8?B?UU4yRlFkZUNTWHRrZFE4eTFuYzhsTU5CYXRnbk93MWNLaUNEZGovcExBaFFB?=
 =?utf-8?B?QUlqb3dsayt6NjZPRzZVQnVCalpHN21uZk43eXNlbnJMVU5xWmpIN2YwT09w?=
 =?utf-8?B?MkxsM3BjMnY3OTZKc2Q1YTJlbC9UNmQ2OHExeUdzcE5RN0FDekYyaHBDTzUz?=
 =?utf-8?B?Q2VJb1BsaGN3RmwreHMvWWR1REc3RUUyTkRoUTArZG51NEFPRURmdW9lajNr?=
 =?utf-8?B?TGlKUHAxKzlha0ZOdjRlUTcyVFdqSjJwRFh2RUFSKzBFeTduaXZtSzF6Uk9K?=
 =?utf-8?B?M2NYNHFuR1hYU29sdENodE5iUEdXelI4Z09icWRtQVBUOWZBUHVmVFZJcEZD?=
 =?utf-8?B?cnQ5QWZGdkJENGVkZzlJaDQ5anlsT1lMT2VaaHpBYkZOcmpYWk9ndE9za2hq?=
 =?utf-8?B?aXZKRHVPOGhmclhvZ0trUmpmZDFtZVJRVFpvT2RCNEFNSjJVVlgxVmpneU01?=
 =?utf-8?B?aTg3d0RMQ1E2SkZhOWtuZWl4SUw1RkJIc3lxNzkvUklpcndxc2h2dEoybk5E?=
 =?utf-8?B?eUFhYy9ZWmhqOTJIbmF2VlFjRXdiaUV2SDhYQng2Z1hYcGV5UnloZ3ptRFN6?=
 =?utf-8?B?L0h0d2hUcjA4NzBPTTg2V2gweE1lMSs5ZkZBR1h0VWtKUDFRVmlGa3l1d0ho?=
 =?utf-8?B?R1U3Y0pZSWQ4Y3Q5b0NiaEMxOWNuaEJiMU9IeXNsZG55cDRQWjR1V3FFNWxU?=
 =?utf-8?B?NjExM0E5UFpWYmNsTlVOYkoveWowWWVaY3NPTzhwMTU2bzcxMitIeVlvRmMz?=
 =?utf-8?B?OFBtaWFJOXU4aHpDU2VzQlNYdDc2bVA1a1Z0ZndWZEZiY3phdThMQjBVQXRh?=
 =?utf-8?Q?I1TYXfDeEGAln2zQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a88bafa2-984a-4f95-4038-08da3c9d83be
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5933.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 09:20:44.6974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZiTYXOsVQYDqJ5h3jUqXNRfE8286AUKg9UBeaPPeDDrZCrkLd9tbD3l+POL4ONeAxlmsTpNQU1yVUZri8KXmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB2028
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git mld
head:   418110601b1711438b8c80cd605d7c65afb3bf40
commit: 3c2ce764e4bc9dc0e31fc58e0483663f85727561 [6/7] mac80211: move interface config to new struct
config: x86_64-randconfig-c007 (https://download.01.org/0day-ci/archive/20220523/202205230957.U8pTkdJT-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1443dbaba6f0e57be066995db9164f89fb57b413)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/commit/?id=3c2ce764e4bc9dc0e31fc58e0483663f85727561
         git remote add wireless-next https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
         git fetch --no-tags wireless-next mld
         git checkout 3c2ce764e4bc9dc0e31fc58e0483663f85727561
         # save the config file
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 clang-analyzer

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <yujie.liu@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> drivers/net/wireless/rsi/rsi_91x_hal.c:310:2: warning: Value stored to 'bss' is never read [clang-analyzer-deadcode.DeadStores]
            bss = &vif->bss_conf;
            ^     ~~~~~~~~~~~~~~

vim +/bss +310 drivers/net/wireless/rsi/rsi_91x_hal.c

ceb2e4eab9948a drivers/net/wireless/rsi/rsi_91x_hal.c Pavani Muthyala         2017-07-06  291
ceb2e4eab9948a drivers/net/wireless/rsi/rsi_91x_hal.c Pavani Muthyala         2017-07-06  292  /* This function sends received data packet from driver to device */
ceb2e4eab9948a drivers/net/wireless/rsi/rsi_91x_hal.c Pavani Muthyala         2017-07-06  293  int rsi_send_data_pkt(struct rsi_common *common, struct sk_buff *skb)
ceb2e4eab9948a drivers/net/wireless/rsi/rsi_91x_hal.c Pavani Muthyala         2017-07-06  294  {
ceb2e4eab9948a drivers/net/wireless/rsi/rsi_91x_hal.c Pavani Muthyala         2017-07-06  295  	struct rsi_hw *adapter = common->priv;
eac4eed3224b1b drivers/net/wireless/rsi/rsi_91x_hal.c Prameela Rani Garnepudi 2017-08-30  296  	struct ieee80211_vif *vif;
ceb2e4eab9948a drivers/net/wireless/rsi/rsi_91x_hal.c Pavani Muthyala         2017-07-06  297  	struct ieee80211_tx_info *info;
ceb2e4eab9948a drivers/net/wireless/rsi/rsi_91x_hal.c Pavani Muthyala         2017-07-06 @298  	struct ieee80211_bss_conf *bss;
19844c0a9a19ab drivers/net/wireless/rsi/rsi_91x_hal.c Prameela Rani Garnepudi 2017-08-16  299  	int status = -EINVAL;
19844c0a9a19ab drivers/net/wireless/rsi/rsi_91x_hal.c Prameela Rani Garnepudi 2017-08-16  300
19844c0a9a19ab drivers/net/wireless/rsi/rsi_91x_hal.c Prameela Rani Garnepudi 2017-08-16  301  	if (!skb)
19844c0a9a19ab drivers/net/wireless/rsi/rsi_91x_hal.c Prameela Rani Garnepudi 2017-08-16  302  		return 0;
19844c0a9a19ab drivers/net/wireless/rsi/rsi_91x_hal.c Prameela Rani Garnepudi 2017-08-16  303  	if (common->iface_down)
19844c0a9a19ab drivers/net/wireless/rsi/rsi_91x_hal.c Prameela Rani Garnepudi 2017-08-16  304  		goto err;
ceb2e4eab9948a drivers/net/wireless/rsi/rsi_91x_hal.c Pavani Muthyala         2017-07-06  305
ceb2e4eab9948a drivers/net/wireless/rsi/rsi_91x_hal.c Pavani Muthyala         2017-07-06  306  	info = IEEE80211_SKB_CB(skb);
19844c0a9a19ab drivers/net/wireless/rsi/rsi_91x_hal.c Prameela Rani Garnepudi 2017-08-16  307  	if (!info->control.vif)
19844c0a9a19ab drivers/net/wireless/rsi/rsi_91x_hal.c Prameela Rani Garnepudi 2017-08-16  308  		goto err;
eac4eed3224b1b drivers/net/wireless/rsi/rsi_91x_hal.c Prameela Rani Garnepudi 2017-08-30  309  	vif = info->control.vif;
eac4eed3224b1b drivers/net/wireless/rsi/rsi_91x_hal.c Prameela Rani Garnepudi 2017-08-30 @310  	bss = &vif->bss_conf;
ceb2e4eab9948a drivers/net/wireless/rsi/rsi_91x_hal.c Pavani Muthyala         2017-07-06  311
eac4eed3224b1b drivers/net/wireless/rsi/rsi_91x_hal.c Prameela Rani Garnepudi 2017-08-30  312  	if (((vif->type == NL80211_IFTYPE_STATION) ||
eac4eed3224b1b drivers/net/wireless/rsi/rsi_91x_hal.c Prameela Rani Garnepudi 2017-08-30  313  	     (vif->type == NL80211_IFTYPE_P2P_CLIENT)) &&
3c2ce764e4bc9d drivers/net/wireless/rsi/rsi_91x_hal.c Johannes Berg           2022-05-10  314  	    (!vif->cfg.assoc))
ceb2e4eab9948a drivers/net/wireless/rsi/rsi_91x_hal.c Pavani Muthyala         2017-07-06  315  		goto err;
ceb2e4eab9948a drivers/net/wireless/rsi/rsi_91x_hal.c Pavani Muthyala         2017-07-06  316
2108df3c4b1856 drivers/net/wireless/rsi/rsi_91x_hal.c Prameela Rani Garnepudi 2018-02-27  317  	status = rsi_send_pkt_to_bus(common, skb);
dad0d04fa7ba41 drivers/net/wireless/rsi/rsi_91x_pkt.c Fariya Fatima           2014-03-16  318  	if (status)
ceb2e4eab9948a drivers/net/wireless/rsi/rsi_91x_hal.c Pavani Muthyala         2017-07-06  319  		rsi_dbg(ERR_ZONE, "%s: Failed to write pkt\n", __func__);
dad0d04fa7ba41 drivers/net/wireless/rsi/rsi_91x_pkt.c Fariya Fatima           2014-03-16  320
dad0d04fa7ba41 drivers/net/wireless/rsi/rsi_91x_pkt.c Fariya Fatima           2014-03-16  321  err:
dad0d04fa7ba41 drivers/net/wireless/rsi/rsi_91x_pkt.c Fariya Fatima           2014-03-16  322  	++common->tx_stats.total_tx_pkt_freed[skb->priority];
af193097767819 drivers/net/wireless/rsi/rsi_91x_hal.c Pavani Muthyala         2017-07-06  323  	rsi_indicate_tx_status(adapter, skb, status);
dad0d04fa7ba41 drivers/net/wireless/rsi/rsi_91x_pkt.c Fariya Fatima           2014-03-16  324  	return status;
dad0d04fa7ba41 drivers/net/wireless/rsi/rsi_91x_pkt.c Fariya Fatima           2014-03-16  325  }
dad0d04fa7ba41 drivers/net/wireless/rsi/rsi_91x_pkt.c Fariya Fatima           2014-03-16  326

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
