Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50656A5D20
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Feb 2023 17:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjB1QaJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Feb 2023 11:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjB1QaI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Feb 2023 11:30:08 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48459005
        for <linux-wireless@vger.kernel.org>; Tue, 28 Feb 2023 08:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677601803; x=1709137803;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0P4LhQRYmJTPrlvhCJXhYcrLpKNTNHn6SEPO/DEwX64=;
  b=kePyrkW0+M693fvYeqyIja5767Haxsz6HAIk9a1pNpCzjgAExEZcWMRD
   KXOrgkV82unrngdCQRKHc4svBzWLpJ+t4yTLSBK8TkKSeFQz0yT2ThIhM
   Qka67hgIZQN/dLxLtgqz9JWjeta/8Ln41F2fCJnV1cAdwRGTc+7l+8K4j
   CiNNuI1rVpWpQS+SjtGlFifKV8Z03ng8iASRmR76kZxk+JqsxhQDc0XLP
   /kbBgLKzXdpGCM1WbwaTepXdIzf17y0XFJ4eRPXbmmb2zyiaL3YsNLt96
   Bo+g+dtxrHBCSpnh+ojcIU1dtPrrOwL3BqmFB98dH7a/L8UboGDwKSrhp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="335670863"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="335670863"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 08:29:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="667516532"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="667516532"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 28 Feb 2023 08:29:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 28 Feb 2023 08:29:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Feb 2023 08:29:48 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 28 Feb 2023 08:29:48 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 28 Feb 2023 08:29:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHL6nSiPBFhFliOC0zX8qL7mYDihSum3skFly/86qsCBE1t+sCQ270zhrlDMonZKOSVAOdSlCCpEgOW6gjGy2hgHqu1Cw/s8RKBb02OLfJlPo1eoPxGnfMQWLFZcc3eVPaA9IW4wvoW8ZXP51w8qUguhkLNyM3Bo4KZxZx3uzEZgEEYNV4DYFitxC3nNYxU1Kc1rCGZf3YFrctSg1MiJ+UGrGbXiRs6kRpaKj+fia1QbkYFVp0i4ED2J+DwaAX77TXRT8NG5LfazWBSz4ZBqmDUYLDNnsf0r5ENhOgoZV8MfZTb3LjM5EO/IPAa4k/mjNN0Q/9duUWV5b2u2AFXljg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DH1VdMltzUkXg3zocP2635xZObD5z7YrVz2V9Nqrtsw=;
 b=gWEqPQRc/b4w//Vd8NrgyTcqUBhDcnnfMtVu6s/eWRKoLYn7WJu/ysqBZ4u861vuXtu4qAAuoqY3xR6uBGVeU1AM7oIdmN2H27XYQ4shigZvcmbR2x8dw/Tv+rxZ8CAdrWO+k1yv5L6pzY6K5LU/qgdmwkbeFGn+uJhJkTAlP+0h9sS9fs0oF1QCk2nzs1BE62eNERgHmZDgGszNHhQuZ4VAX6qdCz9QBwEYSjhRgK3dX59bTeu2BnmiHk7pEFBM0T2C8t9zS1W16QOteLexW6Nzles4qNMwpeTn2E75UkguKXsybHwzMkqmOkBZo8uKd1vCQfeCyDdyyJKLyrC07Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA3PR11MB7979.namprd11.prod.outlook.com (2603:10b6:806:2f9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Tue, 28 Feb
 2023 16:29:15 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::5697:a11e:691e:6acf]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::5697:a11e:691e:6acf%6]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 16:29:15 +0000
Message-ID: <99a9d4a2-d032-1c9d-90c6-3a68f6b3a092@intel.com>
Date:   Tue, 28 Feb 2023 08:29:13 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 0/3] net: wireless: use struct_size where appropriate
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
References: <20230228162241.3874991-1-jacob.e.keller@intel.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230228162241.3874991-1-jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0003.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::16) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA3PR11MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b17f459-cc99-499d-9da8-08db19a8ee64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oEpeu+n790wlx9nheWiA3JQrRw5QgfrE3R85YKArYnUOpTmwXqw9zhGND3HJvnHFtRk0LrHGly25s/9cR64MN4RBimRylMgAX8i+KQekUxGt3wQ0KmVkqxB2TQPbuA8NGI5vilYyNn9TUJGU8z9876KZOXtQqbpEwvt3Gh6JKi9mZDrtlPgY8ZljMmrQj8FvdL9R/KbbjhpKPXWGqNgGClro6sPkwMLhFkQcueUxLReZuYyeaOavFVrSBpMgyte5P2SsGinOA+xHJXR/3ry8rG5+zDfTWDPtnwzKXzZs05zkqIMitGZNTdKjldqE3keOihyo7UhTWCCEbvEIaX/+WQ1QpoMVyEhc1h7nQRC+QkLbrEy5knvhMBiXgGduK2+Lyy8rgei48wtHojD/BsVVQ20wnfL7fl7/PhfmRSLFTEbSx81jViYxhixxlhvQM82x/DSglpapP2eglkhdhWt5n6QEkBe0CABvLf2n/ObN1e7LOgiW2AeHYV39h3EX/Yf4o3ZdwJjc6gU6NOY2iuZy/ymrn7ZauluVyIS/FzOTSZNoANA740CxJq1j8FF2dFlF6Zahnvb1tdYfRCxa2Sc94RzKHWSydHiAeMTCqh+Y5cFA/x5qEUNresg9VjHsyVLOo079o+XSUzuanv88tEqFNEpyWatoB+ARbL6L3WNHY8bDWGrwTJw1RG4hGh3jWt0KQeX8p7q3HcHjiNPPKSY/1XjNhj3H5MBgen40cPMCkBY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199018)(36756003)(316002)(83380400001)(6486002)(53546011)(966005)(478600001)(186003)(6506007)(26005)(2616005)(6512007)(31696002)(8936002)(41300700001)(2906002)(66556008)(66476007)(66946007)(5660300002)(86362001)(4326008)(8676002)(38100700002)(82960400001)(6916009)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHArTHdRQnFLOTdlbmhmUWY3K1pqQnpxbC9ZU1FOZHRrN1hqU0tsV0xSMGZi?=
 =?utf-8?B?Z1h6WDl2VEFGRlVYd0pQOGZUSEMzbmNhNm5BL0dYYkxYSi9hc1dpdEtsbVdm?=
 =?utf-8?B?OWs3NlMra0JOSk80SE8yOUd2U2ZQbElnWUtHTjdZSllOSldFWHM0cG0xRmJy?=
 =?utf-8?B?RnowSUEwTVpaRFlBZ0JPcU85NmlDRi95ZWRXUEpweFpoaFc3cTBxM1lvKzc3?=
 =?utf-8?B?NkZpZW5rdHpWNFJyV0VzNW8zbGhEQ3JWNXgrRlllV09RZ054UFQwRUFxZlMr?=
 =?utf-8?B?aVBWaWFYclQ1TDFLdk1OSkRsRVozdXJVK0ZYdlBqMDVlNUU1STRMaVUrcDMy?=
 =?utf-8?B?Q09PdmRtOEJvR1I2YW5CMHhKQ0NzYXYvU3o1Y3hMdE9nN2JzVXlqUkNEanNY?=
 =?utf-8?B?cHRwcmU0cjdMN1lZd0J2Mm9DL3hYQWF1SXZoR2NrZlg1eW9VT3doajNBTDhp?=
 =?utf-8?B?anFjSXFJQ09DN3Rud0pnZ05NM1lRR21Da2QzcHhFRDB1VmZnVjhtempmM0Jz?=
 =?utf-8?B?anhmTUUwZTFTclk1NERmL2thcVRqYnJ0US9sYVpnYUNlTUtkUDFMSGgxNzF6?=
 =?utf-8?B?R1d0RmRUUkFjenJ4dkU5NEhBYkJmcHNaenBVTzZDVHlDSVViSzhnMXJOS09P?=
 =?utf-8?B?YnRNeHVtQXhDV1V1V3Q0aTFwa1BNVjNlUk4rVlN1Y1RVUTdHYVAzT1lCeS9y?=
 =?utf-8?B?WE5zc1N1M1N0dFBQaE9aTXhsajc5ZnFlRmZMNXVyako0MnFuNjQ2TU5Ibjlh?=
 =?utf-8?B?WHZxVkR0dnF3NGIwV3YwajltWjN2allvNnkvRDNFVWxjdEF5ZHV5YVZFYUhQ?=
 =?utf-8?B?OS9ZRFYyS3o5Q01wT3hjdlBJUjBCTngyak9mZFZQaWlpM1BhT29OWVB5S0R0?=
 =?utf-8?B?NlhteWlxVkdCaWYzOE56TU9SNjZHR3ZrdDZ3M3g0a2FpaytUcWtweUtiQm10?=
 =?utf-8?B?S0JkK1pBeHE3cXZlZ3k2cG9WRmJ0TFZoVGhoMzBWU2xDbndaeXRtYjE3WkNS?=
 =?utf-8?B?SXpIcXluQWE4dzNVRHFLZUU0MGpOTGxZK0k1UW1jZ05SMnFHcG1VNFF4TUp5?=
 =?utf-8?B?QXp4UjNXMmtVMXkzaXNHY2pId3VCVkZrYnFYbXc1UHlGUmk4VEw4KzlGM3Nk?=
 =?utf-8?B?d25HVkIxUndEN01FcFFvNFBteGJSclFyQ2t5UVptcEVNc2UvTjJEalo3N0U3?=
 =?utf-8?B?ZEZyNFBIOThaRnM2YTFhVWxJM3lUTmZnRUM3Z3Y1aWVYVnhXdEtJYlN5Rzhr?=
 =?utf-8?B?NmVwWkZSUGFaSFVYd1FEeWVkVnJ2cWF3OFpmY0dlY3Y5bnNjREkxTm90T2l3?=
 =?utf-8?B?d1dlYnZIZGNiSnRIL2R6c2Z3QWRKK21YM2htbzJEbWRDQ0JERmhLaDI3ZnhG?=
 =?utf-8?B?TUU4ZXBFdVhWQ3ZHSVJqbHFwdWtUTi9IMDJxUW0rK3lMRFRYZjRLQ0QvblhE?=
 =?utf-8?B?Nm52c2RZT3NJcklGY3BETUxSMjhwQTU1TGNXRkh4SFhGMkdDRzFDMStNeUIw?=
 =?utf-8?B?UEpFeTZQZlpiLzJWaFhhcVNwRW5ISng3YURxVGpkdXJlNTBKanJnd3Ivb3V6?=
 =?utf-8?B?OVZDZ2w4NCtDMFJLMFhlY25HU0RaT0toUk1JaDhVajJzSjB1bFlicjNLZzN4?=
 =?utf-8?B?ZWJvTCtuelpBYzNBUnZtZ2N3WWFsTSs0S0p1QityUnVNbHh1VnlyVEw2UkN2?=
 =?utf-8?B?QUthZ3RveTNTbm1JNnd1bnVoVFk2NUxiZ2hHMTBiVlJsdkI1bHdUejloMnlr?=
 =?utf-8?B?a3ZJRWdxRHJwS0xtV1Y2TGdRYTZJY3NqSVlVYVdPTzZOQjhIVjhtUSt4czZ3?=
 =?utf-8?B?U25UMVQwVXJQM3ZNYTdvb1Z1cURHajZUeVAvUlZZZFcvUTZNbkRoU01MU2s3?=
 =?utf-8?B?VHRDRGY5VU9hdFFDdW45T2NFOGFCQmprZnNpR2dmbDh6REJaSlQ1dmVuR09q?=
 =?utf-8?B?SHpja0dOZGhpNklWNkdxQ3pXNWZSMHRhTXhqK2U1SkxlZzNoL2tSK0VNTkJT?=
 =?utf-8?B?QkRkcE5pVlowanptMVFucTNlUnViSlA2TUFxTzRNQ1NGdHBWNzhXR29CdHB4?=
 =?utf-8?B?dzFQN0tRVVNGM25SZHJqWkN3OFJ2U0RsNWI1d0hVbHFIWVdRdXRnYVRFRitR?=
 =?utf-8?B?L2FrNHY0K09scHFITkV3ck0vVGJYYlNhS0UxZUdtQURKUW43M1NFTklPZ1Rt?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b17f459-cc99-499d-9da8-08db19a8ee64
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 16:29:14.9703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJt7OS416iss8vkHiNIJa5ey3NlE7XtwLRvMwP9iQWwisA0iGwZ6spmtHa5GT2hDu3zzEXWlKU+BizIyZPZW2qkHB2tj5wPrs+UtwB+LeHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7979
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



On 2/28/2023 8:22 AM, Jacob Keller wrote:
> This series fixes a few wireless drivers to use struct_size rather than open
> coding some equivalent checks. This ensures that these size calculations
> will not overflow but instead be bounded at SIZE_MAX.
> 
> In the first case, the code is first converted to a flexible array, which
> saves a few bytes of memory in addition to the fix with struct_size.
> 
> These were caught with a coccinelle patch I recently posted at [1].
> 
> [1]: https://lore.kernel.org/all/20230227202428.3657443-1-jacob.e.keller@intel.com/
> 
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: linux-wireless@vger.kernel.org
> 
> Jacob Keller (3):
>   wifi: ipw2x00: convert ipw_fw_error->elem to flexible array[]
>   wifi: cfg80211: use struct_size and size_sub for payload length
>   wifi: nl80211: convert cfg80211_scan_request allocation to *_size
>     macros
> 
>  drivers/net/wireless/intel/ipw2x00/ipw2200.c  |  7 +++--
>  drivers/net/wireless/intel/ipw2x00/ipw2200.h  |  3 +--
>  .../net/wireless/quantenna/qtnfmac/commands.c |  7 ++---
>  net/wireless/nl80211.c                        | 26 ++++++++++---------
>  4 files changed, 22 insertions(+), 21 deletions(-)
> 

ugh sorry for the spam.. the actual patches didn't get cc'd to
linux-wireless. I've fixed that now.

Thanks,
Jake
