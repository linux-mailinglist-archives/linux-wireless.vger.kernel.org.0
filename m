Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F66767241D
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 17:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjARQvC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 11:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjARQur (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 11:50:47 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E05258663
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 08:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674060643; x=1705596643;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VN+49ZSchXllpZUu9HvZtgUV/eTzcL39YQ7TRbcM5SA=;
  b=Bu8RuQF6e5fugqswAb90snnlF4NzBHGd4lX2yUKTKrJ+KqKG2I8u83L3
   7SCvUnvuybmjjrb4sSMcVTD0ry96CXDCykAHj+inevPx8+N2UzeM+/Bi8
   FWXeKynQUd9FTF4xiYdzeo1yJjKB6dm77KjC4sywb7Zldew8sOn0lv1l3
   GaE+124E0O8A8p0LZcp+Z1VCgPS7wl2bywgq8MWBjmObdrxT+AOD1Pacl
   /U8sqkUBBOfO8tsE3CScog9rFgF0zZP2+WhcJdWgox2axzLGA2KfYCVdC
   fRD6iGMuFr8WhL4NYe780xTnlAHVHHT2JWo8jztyjSud2m8Glj/GeaEh4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="327104118"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="327104118"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 08:49:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="728276142"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="728276142"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 18 Jan 2023 08:49:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 08:49:14 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 18 Jan 2023 08:49:14 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 18 Jan 2023 08:49:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9+iLphEumpM9WbA7x8xK+vkLmaw37jWNmg5P6Ak9Gp1fXd4fgoSyIyoaVGCuzW3wL5ET21G50IzOSQJzvv2E8ZghZA+Cou8HLMTpg2h63Uyx24Bru5Vr8DekHQuBuBUhKuEcF/JCZOR+XmQbzq8WpI2+s8gnI3AwHH8OKiPxSAd+B5PmGOmu5vTnQ7YdsnJxrhT+6tVihzHuU0I7ahGIRgLfaQ0v6bdSWYMY+SVrP+MeqZ20J9QkccMKbHxbk1eRSqTnk0Oj8RGfSFriWcMe317cafxTDMLnU5wFyT8sE0rn2YxHQlbowEgTHuePyHJO/ZZpk2+FuHf3LP8uZU4xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGGm2FxvnrLMnK5TJs/DWfsx7Ee+aoAoMPMdAPqZdUs=;
 b=S4dB5IB7KREUswW2E89GgM/klRjmpyE6tEmTO2UtkxuesVv7fLyQ0PZBFHeIAAFQ73oxFORd7SZ06fMPc/ttXAOWl7/wn1Dd0L0WuXzzyoUL0guYBFeaCzw6DroQLHXNH136gE1PNkT+dczdkeiPn/fFwtzsP2le+O6nHTJ68XqlwperRXZkSN2uhZpFpqSZjn+YPvFnD0Nfo5k1pbWYOGrEsz3md3gNGQk30SD64Wb6g6AEHV3h+G+qPgLW4F3PE4nB6ThCE2iMGSlxt2KFBlZljyQHYA7cj1U944Nof+CRYK8vm2lXP/AnYmv6sUa1VYuKAhvm9s1yEm5GK3BmJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by DS0PR11MB6517.namprd11.prod.outlook.com (2603:10b6:8:d3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Wed, 18 Jan 2023 16:49:13 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::3ff6:ca60:f9fe:6934]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::3ff6:ca60:f9fe:6934%3]) with mapi id 15.20.5986.023; Wed, 18 Jan 2023
 16:49:12 +0000
Message-ID: <b2c78f45-345b-e3ec-20b1-9d18ee0c9f98@intel.com>
Date:   Wed, 18 Jan 2023 17:49:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] bitfield: add FIELD_PREP_CONST()
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <20230118142652.53f20593504b.Iaeea0aee77a6493d70e573b4aa55c91c00e01e4b@changeid>
 <92209c00-7fcf-1592-e97c-f49e7734fdfc@intel.com>
 <3fe52061d5d9e3701f598add5c64f8b3583c31df.camel@sipsolutions.net>
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
In-Reply-To: <3fe52061d5d9e3701f598add5c64f8b3583c31df.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::7) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|DS0PR11MB6517:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e075682-874d-4783-a63b-08daf973ed23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H12xtRxsOtzMwH6RtqsWR55/hTXky3vu4t/UkwdXIlFNpEUJVkp4kNw2jWsxtoRTKmgDLbNiNrK0rZSNDwMbLiYhsnO54Ood26ATYwsKtk3vvqULfUy8ZZW3kagtENutV5Ddw+HM+cBNXYAuHZzlbw8ZAvn3zQN2SW8VNin1sriVzoxFdHNmVBRzkIRcdFFDyXznbYpFUHO6ipfBGoIvgXXw7oGgHFRy/6Sin4dvYXcZu+6IEanb/bWUDg/8vfgDTxCU1/rnvAjWdVa7ALs3+CWE9FESRdIgtod690KrhO6+UCvlj61nBNM0EEuhVhi5Dvm0nxwfO0rhxMGU0czEzrr8LOWAWb03EdXfBozuvFw2c/Vt04CJ/LOCQq/eCnnCa69AlnQvuaLLIVAK5Xbi/AkH8bxzsK/hoZQzE2b6+23/Ca708XIMGWTHhvSQCoE3MY40DYu2DYVcMIs70iR7YZOjVEp80dY9FEQiFU/q+uKPpQxTGf+E5r6mG57/02Qgbo0EN3Jiwrx6FMvkxW36QQGT4sPQDvTbY0cCfaRNu9ZIYndfYGHhxAcAg3LuWpfq2ll/mhz+3EKHrz18xXRBruTV/IrE1vE1fzB/dNuUAI3FzrHWqaBg6/VS5QQc/85TnEa++jj2kaKDj6FiNl/gInt7ZPIU7Evd6UHEs4JqyIuqvQn8urMedh3vKFXiXzR7PHWJNtPhs5/FhYs1YtbKGfHHey1Tk2d+NHbK6QewtKQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199015)(31686004)(36756003)(86362001)(2906002)(6916009)(8936002)(66556008)(31696002)(4326008)(66476007)(8676002)(66946007)(82960400001)(83380400001)(5660300002)(38100700002)(316002)(6486002)(6666004)(41300700001)(2616005)(478600001)(6512007)(6506007)(186003)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFRxLzdHWmZ4Qk5VUFRMVHZveEZLQ2wwUWhla1k0UmVDM1FTR1JxSFozYm1j?=
 =?utf-8?B?bzRvVkN0RGp1NldkU2p3V0d1S0ZCUnY1KzQyUWxGUXZMeG4yZkFsZW1DdHFP?=
 =?utf-8?B?b3RQcEFYZnhxVUY4ejhjQk9ZbnVpRURLcHEyRlRJTHhlL2p6ZWF6RGFSU0Y3?=
 =?utf-8?B?UDJkeFJic3B6NVEzdS8xRCtKQkpKYzJQN2dnZFNxNzYyZ2xDRDVGZ3k5WUZY?=
 =?utf-8?B?aUZ2OWF5Z2xRaEw4ZTV2QU9kWDg1Z0xwMkMzUHZvRzlEUFdvUlBhRnljMHBK?=
 =?utf-8?B?bXRJT0pnZGpOVHlvaThLYVpVVm9DYTlidktYSWVpRWYwQ2lvN1NtbFdnRjh2?=
 =?utf-8?B?aG9YS3laRlZMbktta2hBdzVNM05ReWJVc3N0QnhRcVBSNFFRNmpjNVJqc2NX?=
 =?utf-8?B?QjJBQkJBZU0xaE54dVRDc3VQS3QrVGMrSjV5a0xnL3ZGTFNYNFFaVFI4RU0x?=
 =?utf-8?B?SE5NOGJoeEVBN3J6Y1VZcmkydDF2TkVEQ04venQvT2JvVFBMZTRNYm96WVJM?=
 =?utf-8?B?OWtoam5Qem0yZENrdDFJOGtuSW9tZlFLWTFXRFdjcEhXaXpKZytQdENlZTdH?=
 =?utf-8?B?dTdUdXkxR0xVYkxiYzZTRm10bHFPMkZvNksxQkU1cXM3Wm12L2hSdmQ5ZU1p?=
 =?utf-8?B?cm1CUFpYZ3BETG5XQmRqcko4VS82QktpMlhTelFrNmErczdENHNaMDVteUZ5?=
 =?utf-8?B?RTFZQ1VlMmhuKzdLR0tLSmpWd3lRN0JJa1Jhdk93MGU3MHB3UTNXdFlYbWNm?=
 =?utf-8?B?dTNQRlgwYlhPbGtRenVBc28vNFRCNEhGbFk1bTFPNlMzOFhBdGZGL1VhcFpU?=
 =?utf-8?B?M215WVVKVkxqbmprQnEzNlVGYW56NzMrSGVjSDVpK1phL3NWN01qaUNYWlFo?=
 =?utf-8?B?djkzdFdRQ2xkZks5T04yUEtpOEhnNzJFQ0lOWVM0OWduYjMzeUV1MjZWSkIy?=
 =?utf-8?B?Tmt0bkF2dW9GeUNMM0NYRFpYdXNCNlVhZmh1aE4rOTNFY2pIVUkvYzVrR0xE?=
 =?utf-8?B?aDdTZTd5VUxmY05MVFFlb0taNTVJN0NEdHJsQUlEeDhDOVpUejZKK2Y2Undr?=
 =?utf-8?B?T2JSa2w4OHExTU9RcTNhelNwN25XQXZrTFlCbnl4OU5pbkE2MEVGWEhqemll?=
 =?utf-8?B?SzJld0FzUHQ0YUpwdVFyNU81aGxDU1A2blJNWDN1ekh3Y011R2tBTWRiNXZL?=
 =?utf-8?B?ZjBYYnE4d2JTRnd4ZlBBbFI3NjZ1N2dqMG9xQTRhcUtoTkJqU2RHbmU1aXEy?=
 =?utf-8?B?Z2JvS1lkQm5Kdllhc2gxTjYzTzJHdk9Jb1NxaXhYYlBEOUl6aGgzRUl6cVV4?=
 =?utf-8?B?NUZaTUw5dnF5RytyRHNpVm1ONDdIZmhLNkNvd3Y2ZC9oRUtSTEJmaFBJcEdz?=
 =?utf-8?B?M3drQ2E2K0VHQmlOUSs4WVFPWGJORDN3bW00UGJoSHlLK0hzZ3hQc1hMWDN0?=
 =?utf-8?B?LzNRaFlJODEwTVovUkNKMlMrQkdSOVF0Nk56UElQbnJ1K3l4dk1PNTg2aTZs?=
 =?utf-8?B?SUJYWEFjUDAxN3dmcTNydXdacTk2c0hOeFZaTDZoZlhxUkJzdmhzS242RXUw?=
 =?utf-8?B?OFhqNk96UmIxMHRGUGExTzQ1Z0p6bVZjelpWMndCUzRxbTU2RDNDVi9aVDlq?=
 =?utf-8?B?WGFCcmY1SFZkdVYvMFZZVEFzdDMwUnR1eFJ6b3QzVVdxT3F6MjJHbEVtREln?=
 =?utf-8?B?cDhPTm1oNGNzODZobzd3WmZBLzNaZ01uT1g4aXRNNXZRaEhjWG5PRFZNek9Y?=
 =?utf-8?B?L2pEU1RkRDh2T3loZFlCcHRKQlFTbEFTWjZ3U0RwR2E1eVhWQVowRUhuRk84?=
 =?utf-8?B?RHBWaEk3RlNvR0tVT21DdW1kN2JBQkhiSWlUUjVXOFEzUVZFM2ZBWlhSY2h3?=
 =?utf-8?B?M1JodklCNEtsSDJqbEdRUHVualFwZ2tiKy9yZURITzM2cXdCMlgrRTFkMzJT?=
 =?utf-8?B?YXFSbUxwR0RmUk1xcTJPaHNzRmpUYW53RlU1MzJBdnBUaG5IKzhHcHNXcFRs?=
 =?utf-8?B?RmlGUE1mK0JzVTFFdUJMK3hVVDMzSEFWQ0EzS2dVSjlMRHhSRTZuZ1F5azNy?=
 =?utf-8?B?RVVJMWd4MjVDV0ljY0xIWVR5dzFXQldSbmMvdE9ucGdyQnFJK2NFdWR5QWg1?=
 =?utf-8?B?cVFMd3plQ2NZMW5nbGF3Q1VvQzhJNGE1d1lIbUtQSDFidFJqUmFuNUlxdTVD?=
 =?utf-8?B?dmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e075682-874d-4783-a63b-08daf973ed23
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 16:49:12.4250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RxqqPBAvj8FrfDWO0Ga0jMh4UjfnU6I4JeMET5aERxEA5ZCuJ4fopQyFcNmiuSX6dgUUYVPf+L5VIzMJVogD1gEQ7a6ASiNQAIEvc2Ar1u8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6517
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
Date: Wed, 18 Jan 2023 17:22:30 +0100

> On Wed, 2023-01-18 at 17:10 +0100, Alexander Lobakin wrote:
>>
>> Have you tried combining it with FIELD_PREP() using
>> __builtin_choose_expr() + __builtin_is_constexpr() (or
>> __builtin_constant_p() depending on which will satisfy the compiler)?
>> I'm not saying it's 100% possible, but worth trying.
>>
> 
> I haven't tried it that way, but I tried rewriting FIELD_PREP() itself
> to be constant-compatible, and as soon as the compiler saw
> __builtin_constant_p() in the initializer it already complained that it
> was non-constant...
> 
> I didn't think of __builtin_choose_expr, but it doesn't work either
> because it only promises that the unused expression is not *evaluated*,
> not that it's not "looked at", so it still complains both ways (in the
> constant case that you can't have ({ }) braced groups, and in the non-
> constant case that the _CONST version is bad...

Aaaah right. Seems like we can't avoid introducing a separate macro for
that. I like the idea of your patch anyways!

One note re __BF_CHECK_POW2(): can't we reuse is_power_of_2() anyhow?
Foe example, by deriving the code of the latter into a macro and then
using it in both?

> 
> johannes

Thanks,
Olek
