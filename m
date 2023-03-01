Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286576A7599
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 21:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjCAUto (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 15:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCAUtm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 15:49:42 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A196E97
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 12:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677703782; x=1709239782;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DnfKjF6ySnvMNKaEyOGCEHFf7U2YGEGUGHPE6LJUqHU=;
  b=h/zNUDDpaEFPu2DI0InG5C6rGN4nCr3JOPaTNHdF2xHhbDhKa4UM6jyx
   Ae3If1jhc+7pwQYlJClzkzLjYWJKhLEkr9VOIPYSX6jVbij2pTDcBUAY8
   JGCVA93eYBp+RUnNzaeOiQ2gxIXCL70gmUajFR1EMpCiIrn1qtjRTSSpd
   SGBah7JrEQKg4E4mV4FprBibp3LSolVAqC+RRab3xa8/oe1jn//Y0d9no
   KZo4k8z+H3u/zAgZpexhV3PGPOtWzUNBqj5UaJNuJNDAauMhKtEKFaHw3
   CSo6AeKORLkYNEHC7crXHdUya06A2EgmNvc/Oun4Cnl08z0GI8H2fNnJN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="314942088"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="314942088"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 12:49:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="674705248"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="674705248"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 01 Mar 2023 12:49:34 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 12:49:34 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 12:49:33 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 1 Mar 2023 12:49:33 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Mar 2023 12:49:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbR7cIVJDQm6+qCfgl1cm9oiSFQVxfEY1US++W5g8gGtMoqo+ZhwO4PO9VQlN6jjjviHO8wr9wxcIb/yPVZZNpuah9DqIvSuA+mLHNJ/4UzXvydlmyg05YAcrb0pjnFmQxVTWFOWLT5ssWvnoQI253+xL2Zaauy4vJaErP/3jHbaFXmsbgGdNbX9athnuZjPTlJbuFBJ8OTQSEMczoQMDovNUNKX+hTSeOaIFoj3ivm3LsHBjIF1k7aj9066auZ7mHXPVEKaV7tm24Or1bcj6O94hvR7Fl1fcDVCudDPIA6hZVe0LegyhjDosVidDca6a/GPeHSH40pnbMZr0Vnc3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSngjrmw9NQM+HijsPf4iFiQG6iLBac+p4vZUqmoNCQ=;
 b=UMPxgp0cWRCkKl8S+OUcnFn8XP6wVo3sV2ItaCdFyB2DPbPQfUAY8/OWEJmMqw0TK8XuyDKPcPOT0v/rBFf+HEJ+sBFwCQeQwro14ZXoOL7M9f4u4deKbH0YQgGhswllS3bYN30vtvytm3NF8vPLxD+sQp/hB3UFLu+3SL6RbuuQN4H6ecKR0UstG+M2mCFe/snoDVItsRPkT1OT5dspz4X0Qu93NYAuADo/M0RgD43hYYVOHXo4y55FKC9RvhreDGO6AfhyAIcu4QpceIdqguR2j09KXrunFoHt1xAQWBiObA9WozZkfeNBM3EUuC62WXb2uhyURLFNw9KWn/jmbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY5PR11MB6257.namprd11.prod.outlook.com (2603:10b6:930:26::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Wed, 1 Mar
 2023 20:49:30 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::a54:899:975c:5b65]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::a54:899:975c:5b65%7]) with mapi id 15.20.6156.017; Wed, 1 Mar 2023
 20:49:30 +0000
Message-ID: <99bc0165-814b-918f-1d62-4256836ab9a8@intel.com>
Date:   Wed, 1 Mar 2023 12:49:28 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
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
X-ClientProxiedBy: BYAPR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::42) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY5PR11MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: 74822727-f792-40ff-ab94-08db1a967457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZE+e2lMhLbA++3tXb6HFUHbg/BSBYBvNALDDge0yP88o/aIVxangcUj55r/bLO3LZI3pXoy71IhXJuKgku7qHohSKQga+ip0aYCEqs8mCHRPsa66G/1egs+jkpfDksH+VpOs3mNDCwaWzKCFVFUErtS4j6pRQBawM4cbp6jHfaQC388oNZ/H4BdQveNqKaLXImHxPvb9rrs1XNK+4/KA5r2U0IQuEp39lL53f/FXv0TY88ODeiO3Fe2SBvCI1KSk9OuN5VFE1zAMEO72G+23XN05JfEpwuM5HEqRePQSk13d4nGVxil36GA/hdCer3tgORjmKGXxcoL3+EYpN0mbuSQwU0/WBitgKJFiCf/vHuYKMl0D3gXrpXSqKU4nfAmZIQDBdXZCVXJf6d5b86u8p2a7XWYD38SaiFVJ7Fh9Lj5AEe0UpoAvtMh0MFTKa6hNuP4WPVgdF/zHpGbaHSCH6vp5IpXpDjGFocq+iDVh6K9Gj5V54uqhkKxHcPFb6HMx4w1pi+tdB6A24x5JfrAj1Ormzk9BqQ1URlfOa7JXOFVXFDUu2isrXVSZaQMwH7B1DVvDjR226n8EI2I1Q/ZzP0pktUocQ8jk75Hln8nuYRRlUZNvNrENblewsX8Fgemr3rCaFMVLL9/WogAvUN3i/bnLJIQYHZ7zP6lVs4l6e6WW6C4n5pekj7boj7toYrW6ro2O/bIQ3fMOqHBHts03MZBhE5xAnfAutbqGgDUC//E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199018)(6486002)(6506007)(2616005)(86362001)(66476007)(66946007)(66556008)(316002)(8676002)(31696002)(54906003)(478600001)(36756003)(6512007)(6916009)(4326008)(41300700001)(53546011)(186003)(82960400001)(2906002)(31686004)(26005)(38100700002)(8936002)(5660300002)(66899018)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3pqMVcxYkJwU1JFa0JxcUM3MldPVzNwck93WTI1TW9DNU5Ua1djVmFaZGZS?=
 =?utf-8?B?OGdXWUdUL3V2TGtpcnpJN2tncTU3UElTQkFHR0o1UGNwd3hIdWp0UEpER2hY?=
 =?utf-8?B?L3BxMXpBWjB2NlRtQnFaQWZNVDV5dDRTbkpvZ0dNeWhNRS9sNWdXV0xxSnN1?=
 =?utf-8?B?UEtCNW5RLzBGMjFBdHBBMHJpeWhxWXRSK1lkYkZ4WGQwYzRPb0dKRFN5YTNV?=
 =?utf-8?B?N09sSTdxdXJUa0VZQVFDU1IwbStlOGhtRU92Wk03OGdIbFArU2FDeG9lTUZ0?=
 =?utf-8?B?emNHcHBsNmNQQUs4RTlTZDlYVjI5YS95UXZlN1hrNXRlZzZkSTNLTVcyamFB?=
 =?utf-8?B?d3dVeE1HL3BYZU9UQk9GR3ZXMTJkQmY5NTBzMElLVk5rK3daUlRaRWp0TzYz?=
 =?utf-8?B?STRZTDNDTnEyYU1wOEZXRksyeGFITk1zRkpQOHppK3JabzhCa3RMd2NobXFn?=
 =?utf-8?B?eU9DQ1pub1c4M2ZXUDFkbnRjSU9QbDRhNVI5a2xCc21tS0xhdmFKWkVsYmxW?=
 =?utf-8?B?NUVET0EvYnlVU3N6MjBrNVdlWDdPMzdocytTWmI1ODcyTDE1TTNrRHprZ3px?=
 =?utf-8?B?eVRPTUF1ZkUvTGRUQy9zYVRwVi91cXprSStTc0RYOGNyeFoycXg2THRWckJa?=
 =?utf-8?B?Lzdpd2JtVFZqK281SW9TakZQbVVRVURHakZJRHRHLzZVdDZKdnJjV2ozMnFs?=
 =?utf-8?B?WVVOWlVxb3dYejNrV3J6RWpuc0Q0c1kra2pOUm92a1E0b1BkRjFyY1ZPSkdR?=
 =?utf-8?B?c3d5U0ZaU0NTUWh4WXl1RHNpZk9UKzRHMEpDRUkrRGhZaUNiSDVWTlRnL2JP?=
 =?utf-8?B?UXo4T0l6Yk05N0FIZnNhMy9aakduMTlCdEhXNk81U1ByQjFEK1FBRm5ma016?=
 =?utf-8?B?QjNTNWdrZ2hGWGFDYTY4eTc4ZlA0Ky9acmhYU0V6ais0L0FqN0hTcTVVWXdl?=
 =?utf-8?B?aTZseHhCRlFLZFRBeTJtTldncVlZYTErcmpHSXBwMy84R3RGN0lZMHB2eEZq?=
 =?utf-8?B?UXkrMUdkRWtteS9RRmdmRzV2V3ByWWRDTHUvMFJVY1Jad1ZFZ0FPZmFWVWhS?=
 =?utf-8?B?Zi9FdC9OYXNCZDVzQ2ZuTDZNVWdRajJ5SmtSdm1zdmdkQ3kvejJqalhIaVg2?=
 =?utf-8?B?cEhFUlJxRmE5YTdKeS9PRURaVmhWemNoVjR0TGpBVEFVZnRGOXlFckVkNmR1?=
 =?utf-8?B?V01tclJZa29UQnBDZHRzQkVsOFUzREh2eXpXcjF1UEI3SjhRdjNpTW5VdW9T?=
 =?utf-8?B?VksyL2Z4TXgxWFhvd0JIN3U4Unk4Qm81NUNPQ1U0Zys3MEd0MmVZWHNob3Ay?=
 =?utf-8?B?OTgxVE90b1lBSEw0dGFNQUo0NmlycXZpUnMvYWVVdU9vRmJCZ0xmZFlzenRn?=
 =?utf-8?B?bHhPRW8raHFIazV1aFVLbGJTbFByWkIvOVFZTVQrUHVsa0hDRldtNmxvdG9s?=
 =?utf-8?B?QjBDdWdWM3FmdGFMdWRSODZubDgzcDRHOHpia1FDKzNlUDZ5OWZTbmVzUUc3?=
 =?utf-8?B?dVYrdG4vSHUwWXRCMDNucEwzRDV0UXBHVVhrak5FcnpIQjBTWDBzZUlKSnRa?=
 =?utf-8?B?dnVRZXRUeGo4aGFhSFVoa2NobTRzclNEc1NBK0tRZ1hkV0U4K1BsUVZkS25I?=
 =?utf-8?B?aXg4dHZMVWJRZmIzd2VQM1F4VkdTc0FDeGpYL1dpSGswam1XNHhCeWJubVE4?=
 =?utf-8?B?L21mOVdMejBGZGdqUy9JOEw2b1VXZW9HcEgvSlBtb256cFdMamtFRTJteDhv?=
 =?utf-8?B?a29zSGd4TTV2RXdPbkNmak82NzROemIzZmMwb016cWNTYXVCYXduKzhtTnVm?=
 =?utf-8?B?SW5DcHFIeWJZY2ZkVUI4b2x4MGk3cGhTd1h4VFVOcngzOWZsdjhyRk9mVkxv?=
 =?utf-8?B?T2JjcEYzWDRJa1BDcXA2T3NUZ09OVE9DRm5ESmVOcGgvSWVwZ2JHYTZaSkZt?=
 =?utf-8?B?bjkxbCs2UkdpS3pYT0k1S0MrVjlVOHM4b0RVWmlYcTFVdE9yNzhpVUxBVDND?=
 =?utf-8?B?SXpRL2RVbHFrVmdCZGlJUktLWVVMSzk0cUM0MzVKcm1NbmhUU2FFTEU2cWNx?=
 =?utf-8?B?OXEveUptZ2E4TktYZXJNYk5JZmQvR21vdXp5NzhiYVQ3RUpxVm9maVZGWm9C?=
 =?utf-8?B?SlJRb3U3R2gxVEN3K0lETlVtMEluanVvTFZIckFmdjZxSWZHaCs2RFJzVjdq?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74822727-f792-40ff-ab94-08db1a967457
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 20:49:30.5656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pzyyhtAWxLCr5QSeH2Q1XnSFOEUtuyKOOxhJLhCOQdlMuSH+A0uwtRbLcMBRYtF8uToBUjTJawx0RYDqOTvvSwkQ7VSo30zDuUKM+aFS7UI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6257
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
>> I posted these mainly because I was trying to resolve all of the hits
>> that were found by the coccinelle patch I made, posted at [1]. I wanted
>> to get it to run clean so that we had no more struct_size hits.
>>
>> Dropping this would just make that patch have some hits until the driver
>> is removed, eventually...
>>
>> Not really a big deal to me, I just didn't want to post a coccinelle
>> patch without also trying to fix the handful of problems it reported,
>> since the total number of reports was small.
>>
> 
> Makes sense. I don't think we'll drop the driver at any point soon, but
> I also don't see it being changed much :)
> 
> johannes

I can drop this one out of the series if you don't have an intention of
taking it, or I can refactor to just use size_add and array_size without
converting it to flexible array, which would prevent that coccinelle
patch from complaining and at least ensure that we can't overflow size
and under-allocate.

Do you have a preference?

Thanks,
Jake
