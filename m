Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D35D6726AA
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 19:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjARSVS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 13:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjARSVQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 13:21:16 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F22B3C2B
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 10:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674066073; x=1705602073;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f8u4pwUOhnkYaXrvMs/ShuReOhTt1cSzCBwjZhT6+kg=;
  b=gRFseJTYTbbZh5lqLDcx7qL9+G9Tw4uCy7yc5+AW1IrCGeoO7fyITekV
   P8uYwPjojuxGT3Ak/F0fLeEHVd8/d5aZuwTSd/fU2et4KJlgGNe3T4CIN
   kathGwrC8cDdtGCUZzWo0w0KGTuDIxrTObhsuwKMJSIUPRd4O/SQMQxYk
   U7a2aLWrdu+81439IWruMLUPX9UcWSI9bBd/WlrwSPVT8xRX5w2/wd51l
   iOJ5eAcZoUU/7ai/iCwrw2AGatDNJ9uS0ki0bsEbUh/0OhOU8pdkhFrtF
   FI5MG2BBnq6HIfGyvywZKXWnSiWaeRWBY78lvXo9qVLwt7Hkflc5FL5zh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="389556909"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="389556909"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 10:21:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="661820866"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="661820866"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jan 2023 10:21:11 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 10:21:11 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 18 Jan 2023 10:21:11 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 18 Jan 2023 10:21:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Diu3tDeFDJDyH6t9/AskNWgSpoCSaGQk/zP9d61/0eOZBWC47TzRomGe9by/ep3laAz3cxGhi++7iECkm5FERn73B1Wu84eMYZKlj4zy0dXd4qmbaP00nq9ltr0bAYjgcE0F+Y9Ee5cKc4L8bLD/tsjHVUMnPbsatvkc+rWR7ypr+Uw5SIgfyuOskcUT51t7CmuUrboUuYXB3fu9glBpFTyCPkYpPk2NmPA5efMmpZWss00WX+JU8RwewSnTzOrV530qufQ2Jc3gDIYsDRxfawmWkij1Y0Wdd+s7AhN1FIeJ/tHaZ9uQLQOFR6Gl+Fx3FlYnE5geSFZTOLzjCaW/SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=we6XMoGk2+65t5JN6RuhzYdAa1IXr/i/k8Hvm7gWUUs=;
 b=FPq5WZvbi2yf78QhNJlnjtvzGDXG2myxC1MyiTo2fOP0ur6KQgQ9hPFMGztQfaHmm7IfTgbTJQE9WpEsfdnsSkFspSGRY4f8GvLKpOkzJjLTLvm1BxuXqyOk/KkxPRWEBkl8zXaDfpXZztle5ETyPKwdh/um5GPVb1pzCP0uD46CnmdQ0MMZFDVH/99Ikuva7c6b1b8jKrql1eUkuz1FqgkNgm+J7+GHKVbrRhNIbnUaRTnYsvEZsHU8bQq4IJJdijk6IJkovqq4Eb0Xu6mj5mRMs+k9lFp9kM1rNEL//xuQ1jgosL5pKD05W5l/9bJtfxqd8vgtLDJjw25QvsFkZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by PH7PR11MB6523.namprd11.prod.outlook.com (2603:10b6:510:211::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 18:21:10 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::3ff6:ca60:f9fe:6934]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::3ff6:ca60:f9fe:6934%3]) with mapi id 15.20.5986.023; Wed, 18 Jan 2023
 18:21:09 +0000
Message-ID: <5ade37de-2582-9e80-b99f-01aab13d991c@intel.com>
Date:   Wed, 18 Jan 2023 19:21:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] bitfield: add FIELD_PREP_CONST()
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <20230118142652.53f20593504b.Iaeea0aee77a6493d70e573b4aa55c91c00e01e4b@changeid>
 <92209c00-7fcf-1592-e97c-f49e7734fdfc@intel.com>
 <3fe52061d5d9e3701f598add5c64f8b3583c31df.camel@sipsolutions.net>
 <b2c78f45-345b-e3ec-20b1-9d18ee0c9f98@intel.com>
 <8b955e4d859aafdf42f1a11f37ddf2a5e47c2610.camel@sipsolutions.net>
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
In-Reply-To: <8b955e4d859aafdf42f1a11f37ddf2a5e47c2610.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::7) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|PH7PR11MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b3af7c0-02ca-476d-8634-08daf980c5ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uKrL1aPZjcVtLl59zX4oAdhfVWbaegspWbgLmzK5e+0ehkPzaDNuyd0s8EfPAEx9VHiaQ47TRgeOrFFFEGcIUfchzOowexD6fWNj8pmHDJ5uPO18Hu3kJxJxR3MwpDRP5A6XRQRlJMcMBrNrU5jdjze9HeIkaZBQsPPEnz+CA3BrOAYBdpjP02Fv1d7NaHFuUgE+ozDc5irYRlAyO7A595mgl76CksgCwf9JVONlr+Mudq4vn00MYc3dQqds9p+e1KCJo41/D0lxE4+hOu3VG+nURLmigvqalONX9KkwE45/Z7TqWzQ0+29r8goxT6Qbc4UPsIyrpvdhXl+LYuD2OUJLz01xoQ08adSK0f9faxeC8Q3pc7/p07zYt4QlT9wZffRbkWcEQIrORcI+wh3EmVVsqTXX1peTVzXxMAVbQPTHa+5GjCvelfmg+e1IUtSNoeY+lJgZ9cOsUi6YyaWdX07o0bX+MH6YyF8cqs3vcVXJm9C9PklW+1Gw29e4mfFoobC4GAhAzVx+3hWcC2auuCvahGSl/AuZpDQVQkhrb5Un2Z55Ia/OyIocLSinHeur6wpusDNaSBUl577T0EMpCkkuMbCESD5nBv2y2i2vOesx8qkb587FMVDu59N9BzIQlCTDdhwRfUZ7dVz+j7B3rT6nE+iBMHovH+cJ7sZSpRFMNdd+jsf2pSliedqk618XLgq5D3/YPzUIyYku7DyauXSEZyH7w9CLUKl8bWrmbEI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199015)(38100700002)(86362001)(2906002)(5660300002)(6916009)(66946007)(66476007)(8676002)(8936002)(66556008)(31696002)(4326008)(41300700001)(2616005)(82960400001)(186003)(26005)(6486002)(6506007)(6512007)(316002)(478600001)(6666004)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWNKZERsemdZSmlwRlA3R3pvOG9PRVlMOEM4QmNuV0Q0dmk4d01xZXhJRE10?=
 =?utf-8?B?R3BGT1NMclI2M3BLNUFLZUZNYVVUTHA1UXJSTnBKc3dpdkFXNFJGeDBZcHhh?=
 =?utf-8?B?TlJLZWV6QnpUY1A5Q3VqOFhZUldtQUNTaUh4TTByT3U1eE9WKzg1a3VGd3Mv?=
 =?utf-8?B?V25LOEV1TVRYbFp0MFRJZ2pPSXc2YWlmcW5ldzliOFo5QTZtanJPU1BKVXlH?=
 =?utf-8?B?YVdRVlhESW5GWTE3ZTlJVjJyWEtPUXJUa1BGa2RNZXM1NVBpWEhzaHdab2dC?=
 =?utf-8?B?U1BhRXZEMlZqblY0WmpJaDZrbGtmUlRoNy96bitBN2VmMWNmbEE1TTBsYmF3?=
 =?utf-8?B?MzNhL0V3dUxmanhXL0EzcDdOSG1JajJxY0d6Z3Y4K3N5NGh1bHprSkxDOGg5?=
 =?utf-8?B?bTRJcjdQeHNreG1UKzFVVzZoWVk4cEVIZ0V0SHVsN2EvTm02NUJkT1ZKcFpu?=
 =?utf-8?B?ODRUSmhXLzlYUkgrdm9ldG5lY0hPWFNhSlB0ZkM5eTRrN0p0dlBYNVZhMExw?=
 =?utf-8?B?bHR5SlB4azIvcGg3MTJKTnkyNk1WYW9kaThkSnFUU3hUYzJqczR1NGk2NG1y?=
 =?utf-8?B?akNDTmpFWWFBZ2xKbjFJbmFhcWtxczNpWlNQRkl5WGdMbnBEN01ha05RWFlx?=
 =?utf-8?B?NzlxSyt5Zm02dkNnZTNVS0VOaERWeWoxMGdaeFdDSXVGKzBnRmVUVUZwZHZo?=
 =?utf-8?B?VmMvam41eWVPaEhwQS9sZW5vcFA0cUFkVG9PRkpoRVlFSlB2QkhkeEZ6L2xR?=
 =?utf-8?B?TDEydGt5MVRFU3lqM1Vydm8ybloweEN1dmhrekMzd2hGYWdmdCswTTRWZk1P?=
 =?utf-8?B?ay9QUXI5T2ZXeHU4SlZFMFJCMHplLytOU2xiUElNZ3FpWmxwSW5xNmdIMjkr?=
 =?utf-8?B?ZG1DMHVSUWdHR0JYYmZGUTUzbWVidVBFOHBaamZaVGc2TnVkQjZSZDRZbG9Q?=
 =?utf-8?B?TUFBdm5lWVBuWnNQM3RtUHVacDJLSlBCaE5Ubm15bkQ0WFRDRXN3L3JtVGFj?=
 =?utf-8?B?MGR2b3pORGkrZlYxYjBpcXZyTms0U1R6V0g1Y0RvZTN4c3BwbXd3ME96bk5B?=
 =?utf-8?B?Q0lpUGxNdTAxdlZUUGN1ZnQ5c1NraFk3YllTRk5teUdVWkVxRVJZR05XTjBu?=
 =?utf-8?B?bmhwQ2VyTy9OSElkN0llOTNHQzY3dW5qV1EvK1Z0N3VmNlU0aFl3a3NBOExD?=
 =?utf-8?B?VDhJYVVaYVFSeXNtRGg5eS9ZK0VQa1dsTVJKWFdWTkMwZS9FNXIraStYWWJt?=
 =?utf-8?B?VXRlWUNwL3hDYXZ3b1pDVG1SOElOM2lqd3Y2Nk51Wmk5ZCtlckQ4NFplakg4?=
 =?utf-8?B?eFFWbU9iRkVNNk1TakluaU9lT1MvTGhKYmQyb2UrRDRtWXlQS2x4NmlSWFpx?=
 =?utf-8?B?NGRPM1Z4RE0zc1hHK2ZSUTE2Q3FqSVRZZ1FSczJ5Y2ZJTlM1c3NJbWQxanc2?=
 =?utf-8?B?bHhEUTVndjB1Z3VsTE5mdER0VlRmcGJGeWE5TGg3QXpEeHU1UUdQZUVrWUxw?=
 =?utf-8?B?b0pEV2FwY0hZTFNnRmV4VkNmNGkyMEV5bGdIOGg3MU8yaUFmdTBHcEorenFj?=
 =?utf-8?B?RzQ0cnczRkxUKzYzUkJLS25wdkJFcitWNXB6V2lqN05LbkN2QlN3bFhFOSt1?=
 =?utf-8?B?VmVzWkNTaGNzWlo1N20weWoydFh1dkhPL1FaSjZ5SWxsSjg5NkVyWUphQ3Yx?=
 =?utf-8?B?TlZGY25VK29uSkhvU3FVRzIyY01kYWJBODhNMVBCaElrb2t2RjJLK3dEanJv?=
 =?utf-8?B?RnlyWVdKM25CbUpjNXl2ZTJ3aWJ0NDhpcXYzc0JGdUx6UzI0SjUrT29kbmJ1?=
 =?utf-8?B?M1Vhd2FEYWNoWC9TeTc2VVp2NGFIQTNsYmFoclNQZWtVRFdXektLTERreW5l?=
 =?utf-8?B?K3gvSXFRRUlZMitNR3N0VkxKZjBHdkpSVUFMU0E2T1VUbmJtSkxEamhYRUVG?=
 =?utf-8?B?eXVmcFNLcjVsSUdFQlllVHBBV1ZSaUJSVGhrSGNZaUs0MU4xOHpXRlNWblk3?=
 =?utf-8?B?R1VPYlFQdTFGc0hXb08weE5SSHNEUXpOdmloYjh2THlwL0xpWm9IdFhFRzFr?=
 =?utf-8?B?WWZDVG5LaFRpRzRQSWxGajc0b2xianZmV0U2a0JidnFYMTF4SDdNVzVHcG9v?=
 =?utf-8?B?eUJHaG04RzFSYVUxY0RlV0t3VWRCL044UHluK0hpbFh2azl2dGJkak9lT2xo?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3af7c0-02ca-476d-8634-08daf980c5ae
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 18:21:09.6681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DniE9NWLDz97A403iG7wYPeloToSwKzAf4Lirfv5F48JAa9nk/teITojic9e97pvgCNT0o8kA+OUJqcNiBk8ALvm23O06dySrXuOhT/NcSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6523
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 18 Jan 2023 19:03:24 +0100

> On Wed, 2023-01-18 at 17:49 +0100, Alexander Lobakin wrote:
>>
>> Aaaah right. Seems like we can't avoid introducing a separate macro for
>> that. I like the idea of your patch anyways!
> 
> :)
> 
>> One note re __BF_CHECK_POW2(): can't we reuse is_power_of_2() anyhow?
>> Foe example, by deriving the code of the latter into a macro and then
>> using it in both?
>>
> 
> Well, not directly - for example is_power_of_2() doesn't accept 0, while
> we want to accept 0 (mask being e.g. "0xfull<<60", we already check for
> mask != 0).
> 
> I thought about __BUILD_BUG_ON_NOT_POWER_OF_2 but it uses BUILD_BUG_ON,
> not BUILD_BUG_ON_ZERO, and BUILD_BUG_ON is nicer in most contexts ...
> 
> So you could pull out the expression "((n) & ((n) - 1)) != 0" from all
> four of these, but it doesn't feel worth it.

Aaaah I see.

__BUILD_BUG_ON_NOT_POWER_OF_2_ZERO() then? :D

(mostly joking and not sure it's worth it, up to you)

> 
> johannes

Thanks,
Olek
