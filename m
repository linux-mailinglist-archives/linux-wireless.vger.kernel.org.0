Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8966A75CA
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 22:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjCAVBT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 16:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCAVBS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 16:01:18 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CADF521F7
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 13:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677704470; x=1709240470;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/icMN2AWIXxsa1l83+bxXzk5qp0DiJLYalq3P9x9rto=;
  b=V5nX4305p+tSgtYE/QF5mE3KM3rGPLv68QqwM4S/jyswbfEz43nZl8Gb
   plzmYpDGl0M6UhPFncfVVt7U9/zEpU174NlYJN3ByRUTsd64k7grgMuSN
   KqZzKYNbJcMpqqNYys4IcTxXSG8X6wvyxJLguQkKDZZT1zLMul91Eg3If
   huVQMIjL5FUicyPLZTZZsTH9IhDenQqOLN3pZmo9Rc6z1YTLUZhUcXOUN
   Ao+eiaKdr7DNbJ3ak2aZV1e3kG5FZVboMcI5SXrwhrAGJ5tCuHm+9Kwcv
   oyxOwheY+iLsqNoZ9CUuY/9Ti7BiJrFeOu/yYkPd6n7SP3msVtHzlSjm3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="333244301"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="333244301"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 13:01:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="676907496"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="676907496"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 01 Mar 2023 13:01:09 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 13:01:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 1 Mar 2023 13:01:09 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Mar 2023 13:01:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftQ7WFrYYR/ME8BU4UOtUt8HVKclM6JyjHxvQ+U55nXDrG2YQEmQscmlU3N892lW3P2lMHwB2F+kwUp3mY3LlDbJjuEKbp6XxMsxOUgQEGDy+Kkl0in/IljqEc3ctmfRdcki1TwBs74HdO3Q+65h0jbzVgjbgsF2fEhLoOkEH5XWw8WW2PFH0b/NwdeGD/YKsY6/MkSWBKZN9zdCIxr7cgiXQDLYPSeAIHQJc7auN13dkpz3wBgnHDBlgi772AP0etrzdtbHctFVpVufZ2uXuLBlpeOaHwTKKMcLjL33P8hM9PYGsDcg9sQ20FVQuNHqR8OzaLsMD9UPnUYNH9BmOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffqa/yf63bDcaPUhuK1dECAB1zN8QXErR2CD9CVOv90=;
 b=FPr22Fg8shuznfpQABx7OqFU1/b7ETOF/I8i89Uj4FntIvIo9OHuL8egAio03s8QJkt1mKChQJmhrA0ahbBdWYUJYwpFg2r3YquyVcBDVQgiBMT9syvYRv4e3Ysu2jncx45PYeq9XGvvtiMgVg8dGv9Oa+fv1Zo/tv6n/I/wH7e/14FtN2NkcQumoSHcyWlEdYpapFo0pP5q5qaLcdLuYj99YGB1egOGqWIjK7JLzTYPRoeKJJ95wTEM5X8c6AO3pnrmMUg+dYWr2JChVpI8B/rpf3Wl5lc+UUsek4uxi21LZGn3n5ncArlPbkAPYfItrJTHL0c3d0gSq7Hkrz1P5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA3PR11MB7416.namprd11.prod.outlook.com (2603:10b6:806:316::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Wed, 1 Mar
 2023 21:01:02 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::a54:899:975c:5b65]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::a54:899:975c:5b65%7]) with mapi id 15.20.6156.017; Wed, 1 Mar 2023
 21:01:02 +0000
Message-ID: <2f8deec4-1bbb-aaf0-dd8d-9d31c0225811@intel.com>
Date:   Wed, 1 Mar 2023 13:01:00 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/3] wifi: ipw2x00: convert ipw_fw_error->elem to flexible
 array[]
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>,
        "Stanislav Yakovlev" <stas.yakovlev@gmail.com>
References: <20230228162827.3876606-1-jacob.e.keller@intel.com>
 <a8798dce4ae87aee64dfd56721b1668f8c969951.camel@sipsolutions.net>
 <d393ba90-ecdd-ffea-540b-d6db15571d5b@intel.com>
 <7f996d2efd23cefd17074edaeed0a6bbbd9f1a99.camel@sipsolutions.net>
 <99bc0165-814b-918f-1d62-4256836ab9a8@intel.com>
 <80ddafb7c3d04b145817bb4c909ab736d06f1e1e.camel@sipsolutions.net>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <80ddafb7c3d04b145817bb4c909ab736d06f1e1e.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0134.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::19) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA3PR11MB7416:EE_
X-MS-Office365-Filtering-Correlation-Id: 42d64da0-d0be-4665-b249-08db1a9810d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xmtbXjlgq/0ZflrcKXQdN4SFQe349ivhqSpw1LmshRTKLLcVFDofAmaB797V1XAwzqCusSzuRNjsnAFTgYiXXiGQfwMI20osIl5nJR7w76fU1p4hwYktnWzlL7eQxy+MRm/Snl4lNKKBhQE4XtvvaC2F44mSxqbQSeVNH3YGz8+ioYLRihaZPCZsSnlQ+JiIUAoQvgeknQ2IJaUm0hK0YMbwJ/fGAPK1//kNAD85SeZDKqaavruHjb2TuLdQPAWT5ULmOaOFRL0gEeqKPrpaLO/RsAPPiudcC3ODY5L23fFZk8ie3j4xyciPxaNoTFW8j7r1oflizPt7OZulMdg+2dUqw+Csii5lom2Q29LIx0PrT/T78wBXLJac12+/M23tn/fXDflPLnk3UUcodemfhnc3j3PEbCwgU/kjFi6TQo76KdZDAvqSAH7qS4YWylx+Vocn+a3YJEFbz/jzLilwi+bl936GEgRSUdUrJLhS/rB3cwf3if1dtPsuzdx4GwWCvJHFjRLj76CYEoZKL2liKEkX2Dpy0lb2FyQgMS7Y8wkw3yTliHVrLIRI4CFbVAbF6nYJTV2hKTDfs/NdyAQBCaW40N1Iw1wx1EE7zty1zma/1GvBOs04XwHmsOwUNJuFq+mlueoik/R99z1dV7ZjD23Mu1qTBFZmE8RFdEzC623qyAmbnr2QeQ7wDaIBYnhjRr2CcxShvPrWLM2F5v/GzGwgGxS6NyPmx0jFblQpU9w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199018)(4326008)(83380400001)(66946007)(66476007)(31686004)(6916009)(66556008)(41300700001)(316002)(36756003)(8676002)(54906003)(82960400001)(8936002)(38100700002)(2906002)(5660300002)(53546011)(86362001)(26005)(186003)(4744005)(478600001)(6512007)(31696002)(2616005)(6506007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmpNSkM2VXhSRTVYMDdnNENSeWlLTXNBNjhFRkxQZlZLUnF2c0NHL3hKYnhv?=
 =?utf-8?B?akUwL281WXBaOC94cytZcDZZSlFPZk9hcWt0MEs3M3AycnArQWN1S1JtQkx6?=
 =?utf-8?B?b1BxaFNDUkdtR2J4RjZieUxqRFM5RGhGbTc5VDkvZTZ0OStwTzBLVVB4M2gr?=
 =?utf-8?B?NzArYlloTGxYMTZVMUNjQUhUcnhpdEJ4MzJQR3ZQd3BncmFBSEFHeWZQNjN0?=
 =?utf-8?B?d24yRzhFZTVuSkw1bTZyVjQyTUJjWmkyMkt3cFZxZ0JjT0JiUzV3U1FUN3Rj?=
 =?utf-8?B?ejBGV0Q2N1R6aEIxR2QyN2UyZFNNTjdGM2JjeXZ6NDk4d2cvclNFdDZUM1k4?=
 =?utf-8?B?WHd3anhJV3lRNnlCc3o2aDBZY0pMa0N5TFM0UXh2YWFLWXBvb0ZQeVFDUjVr?=
 =?utf-8?B?cGhqOS91R1dCOHNWTktZUGpQSzJHUXFMSzM1MllYdEhpSC9zcnBTNUcvcVUx?=
 =?utf-8?B?WDhXcTJlVitHdW9Na1AvcEFnZGdueFhLRnc5RDh5SkNtekxpNkVNQWtWOXVr?=
 =?utf-8?B?bzlLYzhQTGFuUmxBdm0zUnhidCtnRFRKaE5CTUlPajhFUWFTeVB1WktnK2dM?=
 =?utf-8?B?UmdVZmNIQ2ttVG9FR1I0d1BtNkFVZmxnbVZRSWtkTnBtb0NCZHl4bXl3a0N0?=
 =?utf-8?B?N0RwS0pGajlGY3BqbDhZeWFNcm1UdTZEMlBXcHZPN3Zxblk4aHpEdGdEclFJ?=
 =?utf-8?B?R2duYmk5USt0Vlh4M2NsZld1R0VLN252V3JMcEgrTk9NS2pkekg1Q2RQeG1B?=
 =?utf-8?B?UHJqSTQxS3dBbFVRM1puQ3BhU2poMU5ZUk5BT1l0ajZ6aVFNOVR4OXJ0SEhn?=
 =?utf-8?B?RTI3YWYzc1Y0ZGxpSXFwTlRVOTEra1hsNTlhMVc2U3cwcHRhYmh0dFM1Y09K?=
 =?utf-8?B?aGQ0YkpMU3pzUFAyK3R6YVZCTmEzeDBYSnVjN09mRDVVdVVTdEkrUDZQNFVF?=
 =?utf-8?B?UjN5OVNxQ1lrcDZHRktUc0UydHVqNElHQVZmZlFxelBabTg4UVB5T3lET0NX?=
 =?utf-8?B?eFZLci96amlBRWllTytwNUdpT1hZNktiMG81SnFFZjU1cUpOZjBDK3VJUkp0?=
 =?utf-8?B?bW0rTFpydVNxWXV0ZUt2NXpZSkRVR0hxRk50a2w3TlVoSWFCT243NWRMbjBz?=
 =?utf-8?B?MzhwQVdFNStuR1BYbEh1QmVmaFZkM3pEQkdZZEFFV0hIQ2dubVpuNU5GdTht?=
 =?utf-8?B?VEh2MXR4RnlyQlFuSDUyVmdrbWR5QXNLZzJqZzVVczNhZURBSlRQcEFSditX?=
 =?utf-8?B?VjU4dzNIbVlyM2xlanBvR1JjYmNadEdVRW00eENIeXBpRUFoU3AySFlkcnVU?=
 =?utf-8?B?ejdiQ1JkZ0dRaVRXVGxsRVJpeU5ZMnd5OVk3V29XNFh4OEE5cmJmcDYxMUxj?=
 =?utf-8?B?TjRwWW9CcWpSZVBiaENIWTRNcHJqMGN6UzQ2Q2JDbE93RFRkVm9hMEhYbzdj?=
 =?utf-8?B?NWdCZk90d05KTkpvNndUNDhLM1lzQ0lRck1Hem4rOFo0RlI5bjhyMlMxMlJH?=
 =?utf-8?B?YUViVytLZ2VHMEJiR0FZQmRrRGZldkZmS2JacXJyVnc1eHBvWlI4c1Y3S1Bt?=
 =?utf-8?B?MmROK2pxN3VJeHlVY3VWdndBTFhDZXdZbmY0bWg4Z1E2am8xQjJjajNEbmhh?=
 =?utf-8?B?cGxFelpQTDFpeW81cjNTMEFwU0ljYnk0dUh1ZmRuK0h6NHNQajVIVkVEcnMv?=
 =?utf-8?B?anZmbWdkU0RQTWw1STBSVkhwRkRQM2hsS3gxRUoyYjVmR2dLNCt4Qm9XSEhy?=
 =?utf-8?B?WlFCL3lzRmhrUTBGcHdiWG5pcG5HZVJYUEFVcmVmZG1FNkR5eHpLSjdOb1Vp?=
 =?utf-8?B?ZUJlUjlJZmxid0ZzeHU0QTFiV1FCTk1taEx4RUxMeUwwQ20vcHhpc1lrZldC?=
 =?utf-8?B?a1VuS00wU3pkcGlhOWJ6TVNxUm1FSzNmUmRXTlA0dGo0T01HUUwybmZZdkw2?=
 =?utf-8?B?VFhDUG9mbFMwenpZa280QlFpN0dUNnZjcUtFMDViSmJMNDJMVlJSTXB0aURO?=
 =?utf-8?B?Z3VDZ3ZSN2ZsaUtrWDB1aUNCaitoUU1jeFJKdTBIQnRqQUhHSHJtWDFIZDdB?=
 =?utf-8?B?ZEd6dG82bG1ibEJqb1dEdWJWaTBVYnRSa1l6UkU3TlFWUWswZlQ5VXJ2eFky?=
 =?utf-8?B?OU1SZGlxZmxDMzdsYkJyUy9QbHdIdE9PVG5TMWtGQzVqcyt1UDZyUXRaUzZ3?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d64da0-d0be-4665-b249-08db1a9810d3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 21:01:02.6935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OhfW4ss3vgVgMcdHO+rUzjsQTqMnngWOIuhptr1HN5PXOarRvHuaZ25cUHs+8tRZBVErlknUSGyFs7NFXgxsXQTot1dUzz3eOeqytsiwWC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7416
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



On 3/1/2023 12:53 PM, Johannes Berg wrote:
> On Wed, 2023-03-01 at 12:49 -0800, Jacob Keller wrote:
>>
>> I can drop this one out of the series if you don't have an intention of
>> taking it, or I can refactor to just use size_add and array_size without
>> converting it to flexible array, which would prevent that coccinelle
>> patch from complaining and at least ensure that we can't overflow size
>> and under-allocate.
>>
>> Do you have a preference?
>>
> 
> Ah, it's up to Kalle, not me :-)
> 
> I think it's OK to do, and if it gets rid of drive-by submissions from
> the coccinelle patch later, I guess it's better to take it now. And you
> already have it anyway.
> 
> I might prefer though if you sent the drivers and cfg80211 patches
> separately, since that's usually Kalle vs. me applying it, and if it's
> in a same series we tend to end up wondering if there's a dependency or
> something, which is clearly not the case here.
> 
> johannes

Sure. I'll send them separately in v2.

Thanks,
Jake
