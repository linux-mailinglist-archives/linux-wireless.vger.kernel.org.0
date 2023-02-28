Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C606A5E69
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Feb 2023 18:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjB1RtA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Feb 2023 12:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjB1Rs7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Feb 2023 12:48:59 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4FB1DB91
        for <linux-wireless@vger.kernel.org>; Tue, 28 Feb 2023 09:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677606538; x=1709142538;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q12KwNfsRVFHymujUo65mAY3lDDKCHHV9hpX2a/mKoQ=;
  b=KgN/2wkxeEXs+9aDjh8gk6P5vNqOIUkrdjgO7GV88DMKE5vQ1omI7X86
   9IPTcPK+JRnUudq/ZSAAX0fyl0idIa7cFs6x/Y72d1PUcBa6Vk0xFuDY0
   /253ryh0RlKrRNVn0/VSAimgSngbpjbdE6eNFwownH4SiXTI4UZAFHEIC
   HPGrfEDWRvgiE36cRxf9NjrR6qmw0JovlBuuvrIjyDlzYTicQBtab4n0E
   OcT9KZb3ei+kfOsKLkUIqhOd9FrVfnDx8u5Ak5gEBV9bJxd8aPyeJgVIx
   iIrslGhAHT96fyGahLUUbCrpMx9zUTmMoJUH68bFk/Q98WMgdbi03kubX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="322456773"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="322456773"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 09:48:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="783953764"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="783953764"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 28 Feb 2023 09:48:55 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 28 Feb 2023 09:48:55 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 28 Feb 2023 09:48:55 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 28 Feb 2023 09:48:55 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 28 Feb 2023 09:48:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9MIUORpm+v9FZR+eS0ctPj8wXeu3qt49XPjG55fmSx6wFXN7RydFlEYYgcTkKaTQLeMdaHP7o+PZ6RytN8yb+wO93QwPC0Ynq3rj+iMDMbBvDJospG3RM2c3u27CaZdhLsNVU6MDhzkr+woEIZ2ZzyrvEhW9plB6KGD8AMdiMJWfR1V8rINMQcCq7eszVNDmb+dPWlmv/+7tLSNOvTnGOusCKhqNPlxkfcqwmtGpVPtR4XM1Hl0/6Y+2B4ffYm0iUll76f2vFAN6Wibq4i/aaF7t9u8+y9Lz9DGjLgU7eWdU8nVH1iVZTPU5pvSowgQGpO1Mp+71N8/NMOo1Lf4XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k63XzYfefgWQVroA3wMQ60qQ/BMeu7mOK3vSDUBazEo=;
 b=lseHNbA1cvDCDctxM0xkwaCzXh9/QmtdD720WWAbFpgG9224Xyck/VY7lSurIobhl9mYYP5qJGt3DvNFIeM00gJtzFJYJ7k/1EzXye6fzLotiP/8eeL3iseGRYlcxw4zs08ru/jzLlROF4OeV5HBEgBvzxxT5gU8gbgTuU9yDavUjPWWvNdCHTwcf7sB7/zQHgAj1Stakui1H/5hI/u521EWH6lPkp8cJcXcBp4zgDIgCgUKppRD6wgksDk3BaRPQjh6/J12bJNmvfPGwxgz7WpmEjHTshttJdQmDOk+nROJdh4uygHVuylMEn3uPvcjN07B+kMh88fKwAik7uFt5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS7PR11MB7859.namprd11.prod.outlook.com (2603:10b6:8:da::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 17:48:53 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::5697:a11e:691e:6acf]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::5697:a11e:691e:6acf%6]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 17:48:53 +0000
Message-ID: <43543fd7-1cd0-ee33-5a8e-d9d3c7d0e257@intel.com>
Date:   Tue, 28 Feb 2023 09:48:50 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] wifi: ipw2x00: convert ipw_fw_error->elem to flexible
 array[]
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>,
        Stanislav Yakovlev <stas.yakovlev@gmail.com>
References: <20230228162827.3876606-1-jacob.e.keller@intel.com>
 <a8798dce4ae87aee64dfd56721b1668f8c969951.camel@sipsolutions.net>
 <d393ba90-ecdd-ffea-540b-d6db15571d5b@intel.com>
 <7f996d2efd23cefd17074edaeed0a6bbbd9f1a99.camel@sipsolutions.net>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <7f996d2efd23cefd17074edaeed0a6bbbd9f1a99.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::7) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS7PR11MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e319a3-280b-42ed-7d82-08db19b40e48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hT4Lw1vHDrLMMMQcAKA7XiN8dcH/oMPyRw6OohIweY2wsE7iMAKAPgr47XYMuuH6scAjZilXi4XBN347jqwjt25UokF4X6n4kJ5nhiY9D5oHXmPUd5wU0il7X72tO4/OebA0kVFfc97FWKyipGUeKJSP/5keQqULhSYl1ObiKO4z3kKY9zuX1+YyTus8VJTJXfeeOSoQuk2ZEk5NyYRheNhpIOqJyUiUJc+Rm7jH3Vk1/KFq0rymeI1NKnuEJKF470kSKLsGu743pE1KC2QOXC0RTrlzObzGBu9v7tFNs3vSIxfzC5QqwdR2e6JBKRR9IxcJ78JXLr9G3qxg8P2MjhsDPUg8xYmB+e4EhN7qFF7DgtigR0wD7rK2uwqX6nw8k2IUn3x1vXUA6ppxJpJLXI1uA1IMmfYt4CYgHk6VFKwYwoy8N0KNukhINL6H7LAUrYYLOasi3fjgNk8zP/YCkQt0+rXufk/9az7MAfs0xCJJPL6uwnOnPJqzK2iN4B2vhhUw7Zpp4cdFxAgrX9NBit6jzdiObWh677HkCosZeCVnbCq+kG9EQYUO9NTkb48u98TtQoV2qku845S4ZBN+SLu9EK2mam1jqBvzriKdJuyRa/J+pQWuVRn9h6njQAr0FNHeFOTZwKCbqdu+qflfZd3047qHfv0HL5m9qvKApqZmebhfE88EWqr/92Mc1/ZkAI0TiiaelsOmU5iGbBjDWRqYBCm0J0qwu1zixt9refk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199018)(36756003)(4326008)(31696002)(86362001)(66476007)(66946007)(66556008)(8676002)(5660300002)(2906002)(41300700001)(8936002)(6916009)(82960400001)(38100700002)(6486002)(478600001)(316002)(31686004)(54906003)(186003)(2616005)(6512007)(26005)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUIrZzBBQXR3YW9qSDA3RmhqL2hjNERqK090MEhZZlhMWEM0RGVPbDJwZWUy?=
 =?utf-8?B?T3Y3M0RlK2o1b1ZIa3NPVTRicldRQVFpeDRuYnVxVVV6Nk5TVFhVSTBCSWF1?=
 =?utf-8?B?eVUwaG8zcWJuMzdtb3U1VVd0ZzZDWXhLMkVpNytJdHkxSFhwRlM2VUU5emEx?=
 =?utf-8?B?NU81SDRPTXNOb3pRYWFBNzllSHpvTmxnRWUrUVNUdnZXN1R4WGF0L1VXSVE0?=
 =?utf-8?B?ZjFLUFhnQ3JRWXZSem9CbzBVTUg0NTJNZ0FlWmg5NTROY0N6ODBWY3dpa3Fv?=
 =?utf-8?B?OCtEdTNVYzJ0V2dJckgwakpndENMbUxNWGo3RkVaeDNPRDd2VGN3eHhyL2xX?=
 =?utf-8?B?NDRwVE1iS2pWb1JvRUFtMzRpcktlQzNEdkZNeEhueG5KMVltYWt1aHdvMUlu?=
 =?utf-8?B?a1lXZEJPaS92b2t6czViUlZKQkpDdndrRU9CTVM4bHgwSHZJZXRIa2I5T1dL?=
 =?utf-8?B?TEwwbWU2K1E3Z1Bmb2haUjQ2K2tpS0k4YXRyZnlNeHNwa2JsWWhZNTBhdm8x?=
 =?utf-8?B?QWdtcTJ2S0ZxU0dYdUhreDlTK1Z6M2xmZ2tIc3Fvd0J0YnVVd1FGSFZ1YnFS?=
 =?utf-8?B?SE5Jbld0YVQ2SU5NZHZITDZpMUdmYWlOSEphSk1BSnZrazVMVmRueXc0Yk1O?=
 =?utf-8?B?SE1qUVViZkxBQkFES1ZjUGhoRUNoWmpVSFJ4RUxya1NyK1BQWWVEZmZESS9n?=
 =?utf-8?B?Y1ZjM3VXNFFna0gxQUdIaVNhZXNuOE0vZG10amdnZVR1ellVSGxsbXdZREtr?=
 =?utf-8?B?c2p3bkp2SytOMVc0QThmUUpYWjE3WjZrVXZIaHZBd0VoUFVsbjZsdWkwNlRB?=
 =?utf-8?B?S0xYanIyS25jdnRqLzloUUNCek93dGtObDgrWm9rSHEzZUwzWEw4VCtPUDVH?=
 =?utf-8?B?RXZDWlFuVnZnWVpYTzBNQm1ITEhtL05UUlF3eUhMSk0wdUJ5N2xmUzFaNHZt?=
 =?utf-8?B?ZkkwQ3FOQXk4NjQwOTdsVWNxa212aXZ3QXdZMWpDYzFTU2Z2Z3YzTU9uR3R4?=
 =?utf-8?B?TXAvcHJhaDNYWXlDbUMwK3hIL0l1Sk9wRGo3dDFUZXRtSU5pY3ozN0ZoZXhr?=
 =?utf-8?B?eXdROTRVV2JYQ3VMVUlWUEQxZHc2ZFRqT0JWeFlXWjMrOXN1M2JJTjVJODIw?=
 =?utf-8?B?cUdqdzg3dUJJRCs3cWROa0lJdmF3R1I4YVNaUm0zU2RRZ2FpUG1JL2Z0SUNF?=
 =?utf-8?B?TjFORkpsQVowc3V4UmhQcElTZlJOTkFLZ2tnZTdZSUw4NDJkVDVPUEpKbW1M?=
 =?utf-8?B?SE9tcmU5WFlwZ3NIaFFuVisyN2hXSWppbjllL3lha0VSMDh3dTdydXU5Ulcy?=
 =?utf-8?B?S3RSWjVjdGV2OFYxckV3Z21iaG9wc29nRmVNUndvY3RmNUU1VVB3RnJYNFc0?=
 =?utf-8?B?MHRPQTA5Q3drb3YxbU9jWlRpWmVEc3NiTGlUeE04SmlNR0t3TEJ1bnFMZjhH?=
 =?utf-8?B?T2NIK3pPb0dEUmtEdnNJTE5mL01OcHhZU3hLekJxNG5Pd0FuNXdhemgva2RF?=
 =?utf-8?B?YzRYd1JIYXZNK0lqZ3RxSXhObTR3R09ua2l4bGZ3cERENzUybUJBZGtvT2ta?=
 =?utf-8?B?dktQV25GUXVmeVI0d1BFSHJ3TityWnBFL1dGcVI1YVpFVEIrUXFTYU93TURE?=
 =?utf-8?B?RWxRQlczN1NBc2VNamZKREVCVkN2SnorWlUzWitrU3FETDZiVmZjVm9ZdXp6?=
 =?utf-8?B?R3hwZzNuNVVrZTJ3U0tjSzZmT013Nk1sc01ORzNqRUw4cmtLWTJ5Ty9RR28x?=
 =?utf-8?B?UEVtSE1lYUhyVkU1YTVTNUJCZ1B4QVFiKy8xK1BEN1pnWGxjcmxlVWxZbit1?=
 =?utf-8?B?YWpPcHNZR2ZxTkxqTUJoRlNBZy9PTGtiVndGTzlYVk9hSGROMW9DVWNLQUhI?=
 =?utf-8?B?TGM2UHZaUjZlMVFWb1cxVDJNRXBTTDc4aVFOUFRvUERwZ08vQ1pwUHJ3SWgy?=
 =?utf-8?B?L3d3RHR1Mk00RTlXRUFWS2tnZUIzcmM3NDNRYlNyTGlUUUEyK0tib1RRSGxr?=
 =?utf-8?B?Nk9mUWIrV1pqaDlrSStEQjdnZkpsaWRZb1EyUGlEWklqL0tQeEtzbUlnMTgz?=
 =?utf-8?B?TEFWZWZmWGE1aE04NkFmdTd2STdzb290ZFJMN1R2dllDQ1ZmdzdNRUFTVHd4?=
 =?utf-8?B?OWVUQit5aitkbndQZFJQeXJkZnVjSG55UlNQVFJXQ1BzRkRsREZqZ1p3MkRH?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e319a3-280b-42ed-7d82-08db19b40e48
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 17:48:53.0152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KiH3OnUX0KIep84gXDrX+HgQjadatzRAWxG1CbFKGRTf++vlwgy+k7AIDg6QPVk2OXgAV1963b5oSgRTr/fi0K9eZ3pNjiSxp4PO8fYG//8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7859
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 2/28/2023 9:46 AM, Johannes Berg wrote:
> On Tue, 2023-02-28 at 09:44 -0800, Jacob Keller wrote:
>>
>> Previous to this change, error struct has two pointers to sections of
>> memory allocated at the end of the buffer.
>>
>> The code used to be:
>>
>> -	error = kmalloc(sizeof(*error) +
>> -			sizeof(*error->elem) * elem_len +
>> -			sizeof(*error->log) * log_len, GFP_ATOMIC);
>>
>> i.e. the elem_len is multiplying sizeof(*error->elem).
>>
>> The code is essentially trying to get two flexible arrays in the same
>> allocation, and its a bit messy to do that. I don't see how elem_len
>> could be anything other than "number of elems" given this code I removed.
> 
> Yeah, you're right. I was thinking of more modern HW/FW too much I
> guess, I see now even in the driver we have an array walk here (and it
> trusts the elem_len from firmware... ahrg!)
> 

Ouch.. that makes me feel better about using struct_size/size_add here
since it would help protect against an overflow with a large element size...
