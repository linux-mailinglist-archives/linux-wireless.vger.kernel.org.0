Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE2E6A5E5F
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Feb 2023 18:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjB1RoQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Feb 2023 12:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjB1RoO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Feb 2023 12:44:14 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56DC23C4C
        for <linux-wireless@vger.kernel.org>; Tue, 28 Feb 2023 09:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677606251; x=1709142251;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Mj/qQaRzgLHH8G+oF+TlPVGdfLETWa37+qm2dbObC5g=;
  b=WbB9+B8ckBBoOfPG6+bV112o5joaDkNZSTTzOaW9Vc/y3LP0JIIoHY3l
   TyccI2zdWV8PeExMPLt4mpYkJhfU37kooFgDTZRQ9Y18Pbk0sxgqopjks
   KpX2qo0dndaJO5w4jTAVSVRJs02NkJjQYV84lqI1Qo0ARnLP4mmg2x3SD
   aYz35f27VJF0LmW8dchsk4/cBdkHnARwjGdiFkZh17ZXmTZ1yzUbedXZ5
   VJn/ebtX/FHja4La4ZcLWghc0CKaxniE2vDO8W4uYiG817C+u14GXnEKr
   FoLjuWuGwTogyV3x3ZY3tF8eDgI6hXWssdlNIZOHAHzwqbtHFa+qytMwi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="335691860"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="335691860"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 09:44:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="919855171"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="919855171"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 28 Feb 2023 09:44:10 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 28 Feb 2023 09:44:10 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 28 Feb 2023 09:44:10 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 28 Feb 2023 09:44:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4LLoSd8rfaDCJETFG9cRo08zjMDqLkhhwpGfj1Yjii74qmDCohRp0LDxYMY9nd0Lm2ClTKZVPMm3xP2w6dnCSvSPsSHMUrhDgGyRyieMBo9eoYjC7JOsYJWdRm4ghXsskKRvdqNcxZVXS0TTvO/SytIQTZZFRfnC6paGRKU5gTa886h2ekFQw99f/Ty+19SDgNUm+XoNsP+0eWn5wVThjh+ejmgK4wdLuBbOc+bmWH8EJKFDwfwWv5YcfwGv0NFUKGggbbTJzFQr0hH6hTaS77EKe1lIC+al5wA6014jS/zRtJzLZQRB4K5NBBMiSlZGnY7eRL3w1gyXl6XKBfP8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVluOCrlywmInvYLQ2yQvXU9T4z2iPDrX7Zfb2+UzPk=;
 b=gyW/NstpOWxWS/YVIjGfAsWsmsS5MVzH0E7EUB8B+O8MHsBQ33XYgVszD9BGWF0odS6zWe8E6ibmj5QrbBPhupYMzNJl/C1aUXyz59FR2T6j1mOg01hrIwZjX5RUEpezuhFdRdR6qVV/xz+pZgr+r07xBueDbLXU95zw1zHBIQTkp6IcZ79sJ1iC1mwH0q1S4A+9LhYqABFJC/umrqYUBFKFeI+n72jHEMyKOMq8tDMFJ+geEoWIefMp8UNT3dQL0uf+QRiEKP4RWUXKVaHi/6Tztola44dyZxIup4ZwJhp6RH2PB2lHe3w5oooRohrjmWiW1HD9kruuAGsv+vdEvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA3PR11MB8076.namprd11.prod.outlook.com (2603:10b6:806:2f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Tue, 28 Feb
 2023 17:44:08 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::5697:a11e:691e:6acf]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::5697:a11e:691e:6acf%6]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 17:44:08 +0000
Message-ID: <d393ba90-ecdd-ffea-540b-d6db15571d5b@intel.com>
Date:   Tue, 28 Feb 2023 09:44:06 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] wifi: ipw2x00: convert ipw_fw_error->elem to flexible
 array[]
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>,
        "Stanislav Yakovlev" <stas.yakovlev@gmail.com>
References: <20230228162827.3876606-1-jacob.e.keller@intel.com>
 <a8798dce4ae87aee64dfd56721b1668f8c969951.camel@sipsolutions.net>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <a8798dce4ae87aee64dfd56721b1668f8c969951.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::14) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA3PR11MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc20f02-c0c5-4b7a-1470-08db19b364b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2q2/LTMEUlWbMem+O0ucnVLEo1OIBA49uhYDETmMZEsZtc7dOZkG5OlewQoSjpveUsEVKp1O7rKTkbCOqvRPgRyfieKcWxcai+Ax0xnBEIkX/QoIBE7Eqs09PhQoilI60d0Qri4lObACQ/EVWOs1moGGvnaqMp+VsUzTgEZFkxyTdZUo5SlTDlott4r8NYn0fY5lfyC/2RhDdTfCI2kyGmZrA7Bo/vxHBUMuCNlAMIXzyGCRKDgcuN5gAuwLH7/2fjxTMvDSreEufY47TvZvSh55rJuVdZaK6z2dZbLEljOq3LJ2fX+sqQIStztQ9MbnOK2upFlLiswoNR4vguKyzX0Wi9QkQU8/w8LoSIh5qkgXfp9HoNReQmON1fjGvftOne41cotw2ICnLo7h7B+JkzT1lUC8sJZsAMavU+/OkPYBcegwBUZdvr4Mx9dwPBdNvMGbOblP49zmOVVuYyhKPAJYY4m2f88T40lgjXhlOa5uCBz/MgkaFL4oecGgrNtNM+Ww55aUTRYbNSbZVU2FQ0qxXsZFJAZ2tWRu9jtwQNu8QBMGlSpfN7kLhDLlnpEXhIPwyDN0s+NXyj2r8CTY0kf9GHuKtrIDA0Eq8iF33ffK/UigeMY9+aTqTkfUcbrvggwatP/nfNXjRtHn+lXuEQSp7EojhcP6hkXQBoBWUQI5lfEtu/Y4B8V0EkScSoZqebo0waa/RhPdqv9ONGz1EA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199018)(41300700001)(31686004)(8936002)(66899018)(6512007)(2906002)(4326008)(6916009)(5660300002)(66556008)(8676002)(66476007)(66946007)(6506007)(54906003)(316002)(478600001)(6486002)(53546011)(36756003)(26005)(186003)(2616005)(966005)(82960400001)(31696002)(38100700002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWdpa2J1UitUQVNHY3Mzb1RmKzVxa0JkSlcxMEhNQ0lOemRHbERFaDBrZTc4?=
 =?utf-8?B?OFVEMm9iWjFJRHFjbWs5aVFSY1lvbzFFZ0tIUExxWWtNZzZHTGdnMkNnUER2?=
 =?utf-8?B?QndXREQyNWVseEE1VjdGQkRyek1BczNqS3YxdmlORGVnRy9BWTVrR3VybUd5?=
 =?utf-8?B?M2FVbFRkcG5BWGZLLzRmVzlpdnR2SFlSbW40TUsxRTlJOHN3M2RLQXZTRU5R?=
 =?utf-8?B?ZU02a2VUWlJycVZLSW04Yk5qMXJzT0YrTFhLYzY0Z2V6cEJjaGpISGh3ZldT?=
 =?utf-8?B?ejdhNlVSdUt4NnMvdWNQdmxGSWJHaTA1eWdaTEFITXk2RHV0emh5cFpsc3NT?=
 =?utf-8?B?RmtCMEV0TnF3RE9GcGpJSkVZZEcyYlJIUThHRXVzTTVTQ3FLZXBDVnd6QW0r?=
 =?utf-8?B?ZC9nU0pkdUY4eGxvNjVkb1A1MkJXUGVMRzBsZ1cyb25hVFliTG5EM1FIVHR5?=
 =?utf-8?B?dnoxM01jYmFCWXZ1ZklzT3Y3L0prbWNUZHgySG1JZGJIR2pFYzViRTlUaFB6?=
 =?utf-8?B?eFZFTVdnZmxWVldFNU9BY1lEVHZuT2RHbC9nV0IreCtUWCt3emt1SUxVVUhi?=
 =?utf-8?B?a0xkQ2VpUFRONXJRNktJME56c0wvcU9SUXdXR3BhVUlMMmFSNDFGOXpXa3NT?=
 =?utf-8?B?S3p2YnZLcFVndGxCMndnTjk2Nk0vVGR2ckVuVS9EZUhxaVUzeE9TWjg5bnJr?=
 =?utf-8?B?UmRtT3hOeE9SdDFLWTREUkVNbk9PdlVDN0hDTkg4N05ZeE5hRHpFQUM4Y3pq?=
 =?utf-8?B?QzNGdWd6NFNvWU1rVjhTemhQRitqbVgxMjlXMGxaamIxSUl0aWljU214dHBy?=
 =?utf-8?B?b2VrU2VUeERjSGJ3bzZpaW5uK0hRdmppQ1RSMUNTcU9IWUt3UzBYRkdqU2xl?=
 =?utf-8?B?bHpYVkZzeFQvZ3drNGR3MTN5aHBNRjRHVFRkdCtWVVBhenJOeWpUbEZ2cTZJ?=
 =?utf-8?B?WklHZEZrWE1Xd05BY0pISUZHQlRpL1cya3dTenFFYlZ3bTcvRHEySnBUSGh1?=
 =?utf-8?B?STNWS3R2RHZuYk9ZZW5NeFg1dW9FcStwaFJ1RUtsaE1nWmdpUUJ5aGoyaCt6?=
 =?utf-8?B?b3lQOVJTWnBGYmFEQ1ZhMERRVFFncExvbEE4TUV5a24yZDVIZFM3Z000UW8x?=
 =?utf-8?B?ZmdDbjcwWllnOTlYSWVrcDB4cXRRZUx5YUhBNGFwVzc3bnpHNjVWSXFwSzR1?=
 =?utf-8?B?SFVUQ0xqdzEzNmg1SytKeWxHRnl2bmx4S0duQXU2aEw2RkppMXMxbzh5dnJQ?=
 =?utf-8?B?b1lweG1YQ05OL3BPUC96OEpBL3E1LzlwTDNnUFhRZWtqOG9JMDdOZ2dqNVhI?=
 =?utf-8?B?bDJlbEU3NmF2T2NVcnphL1hRdkZ1TlQvb3Ywa2VEZWUzbWZKRWtramhsQnNT?=
 =?utf-8?B?SXNmUktSR2Q3bEh2TG8ranZZK3A3OUlTM3d0U1U1VU1oR29kOElpdndqY1kx?=
 =?utf-8?B?OEZxNkJ0ZGdMMFlOZU5hcmU0dkVZSXVDYjNsTGhWdVFWclg3c3NLMFRoczBS?=
 =?utf-8?B?djhqb2gvU3A3WEFXV1N6OGVGVE5DNGZKMVBaRmJiMjJZUXg5RjZIRnJmMGE2?=
 =?utf-8?B?aEQwSFpWUUNLUHJzb1hRNnVrL2o0cThrTnkvWFhkb0JNQmF2SmRwcHZ6dk1D?=
 =?utf-8?B?VzR6c1VsYkNGK0Rka3haaE9zWDZVOHUwTFBiMXVpb2ZQQmF3M1lOZmVEaEJS?=
 =?utf-8?B?UmR5eFhPM2Q4S0ZVNHhkbVBhQlBwMldtY2xoTERBdVk0RzE3b1JvR2wyMkcw?=
 =?utf-8?B?amlEM282L0owNkRpbjdhdmorUS9ySHg3YkhESDh4Vk9vaXR6VDZkQmgrKytn?=
 =?utf-8?B?SGZhbUFrNDlnQy9sRHY2WEhwUGRLUnlhRTduSUtFb2NNS1JKMGE5REdFUUhk?=
 =?utf-8?B?WFRZMy9TbTJCN1dFV0VwQms4aWZLUitjMkFZL1g3Z3VIbFNZYkJUeWFDS2hW?=
 =?utf-8?B?NG9SZWxzNGlqS1pTVm8wUXhhWG5jUWdXNm85S1hFeklLMEFjdXRKSklPaFFk?=
 =?utf-8?B?QmVVKzlNWlNiVHVYZ2pWd1Vpa21uaWVNa0FlQWcyeWdDaVoxZ2RMY3JlaXg0?=
 =?utf-8?B?Ly9DbkRhRnF2Y1ZibGU3YTQvalI0UjNRa3cwb0pRSXgwOW5DaTBtcG1EZGVD?=
 =?utf-8?B?NEp2dG5DUlBJczl4bEJKajdNdXBwa3JrNmxlWEF0d1BJM2oybVFUaXF6UHE3?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc20f02-c0c5-4b7a-1470-08db19b364b7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 17:44:08.4648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: btG7s/OerlsgNFW3si0zJzgauAyjA7N6VmuPgkc9/oaX7D8tKGa5fGRgJq15kswcGw2uxdzZJhVeoAuVtgKjkl3rTrrWaDtFdsawhOEkzLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8076
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



On 2/28/2023 9:16 AM, Johannes Berg wrote:
> On Tue, 2023-02-28 at 08:28 -0800, Jacob Keller wrote:
>>
>> @@ -1247,7 +1247,6 @@ static struct ipw_fw_error *ipw_alloc_error_log(struct ipw_priv *priv)
>>  	error->config = priv->config;
>>  	error->elem_len = elem_len;
>>  	error->log_len = log_len;
>> -	error->elem = (struct ipw_error_elem *)error->payload;
>>  	error->log = (struct ipw_event *)(error->elem + elem_len);
> 
> I really don't know this driver, it's ancient, but that last line looks
> wrong to me already, elem_len doesn't seem like # of elems?
> 
> But I guess this patch changes nothing here, so hey. Don't think there's
> much value in the change either, this driver isn't going to get touched
> any more, just removed eventually ;)
> 
> johannes
> 

Previous to this change, error struct has two pointers to sections of
memory allocated at the end of the buffer.

The code used to be:

-	error = kmalloc(sizeof(*error) +
-			sizeof(*error->elem) * elem_len +
-			sizeof(*error->log) * log_len, GFP_ATOMIC);

i.e. the elem_len is multiplying sizeof(*error->elem).

The code is essentially trying to get two flexible arrays in the same
allocation, and its a bit messy to do that. I don't see how elem_len
could be anything other than "number of elems" given this code I removed.

I posted these mainly because I was trying to resolve all of the hits
that were found by the coccinelle patch I made, posted at [1]. I wanted
to get it to run clean so that we had no more struct_size hits.

Dropping this would just make that patch have some hits until the driver
is removed, eventually...

Not really a big deal to me, I just didn't want to post a coccinelle
patch without also trying to fix the handful of problems it reported,
since the total number of reports was small.

Thanks,
Jake

[1]:
https://lore.kernel.org/all/20230227202428.3657443-1-jacob.e.keller@intel.com/
