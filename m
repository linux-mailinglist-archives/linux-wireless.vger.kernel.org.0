Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2097A8BBA
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 20:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjITS1Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 14:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjITS1Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 14:27:24 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2114.outbound.protection.outlook.com [40.107.223.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC1FED
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 11:27:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPXpoKuRwtPxuSKIdqGDbL1QIjTLuz70vHtbdjCR1tuwrjxxvSzlMDRmjErA3lskOTv/QOq6heQat0/NN6o8abWOjnpNHqXKBA/IgVNYB6ILUaC/wHb8wU2ppl789EF7Va0WwSXq1teAcfkB/TPOJrqF5FKNnX8GNyxHe4YmmllSSVXYValof9DcR1ygZy6QfoSnYyZxEHrfR3z5+m9vmqHEmb+4PYUP/ICNyulWqsrQhDXT0HQeFN7+8TJyUyygbtH+/6G7GD0iwl0t5TOTygTYeY+CywN59YEZfxQsZOfHEyAXXbaL5NZzDkEopjWvljP2IZBape2towTivLGo8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKwg4oNO7rocIxrmF6x7NVv1jHCzFgtMJo9u4CAqf6s=;
 b=ldVdzC7C+7v9Z5ojvtkvrEzW7k5yLCPAJHK4HctKTuu4r0GgQIBRlCJDMPaGsmc5DLAAjuBRUvtPFGu1WFnLw58M8tIJyniiEb9TCXo2Nrv403bH5mYt/KkL4Y4UN+yuWYRtuw/RWXt28Eb5uTdKwxwGDi679yL0ichPoDngNyZP7XAjVH61qGwtk5OyUlHraDcyBLx3ljLYCIkODEMfJxCyvspNZPOq9UukWbiOp60wZfBTMrM71VenaUwb2hoZM3D/4PGvIeEC+FRRmUgaQ51l7Oh6g384sZB8WcbdRwsXxnu4lnQuDr7vp87FutkCmLlyeVlRZ2fsLCgyaIJCEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=locusrobotics.com; dmarc=pass action=none
 header.from=locusrobotics.com; dkim=pass header.d=locusrobotics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=locusrobotics.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKwg4oNO7rocIxrmF6x7NVv1jHCzFgtMJo9u4CAqf6s=;
 b=oFHRmXcpUfEQAlGJJjR99+93SFIsODNh4vonfHzPZ5VqUIwX8TYV/6PYT7PhKH7mOGcOclzXdTJievDZJAfeZsa+uuTqJ1DwAAvL7UjhHq9X8NValEniRSVPao12lHDHtI+baC3af+07XvTO+9E95U418qOWpS74X2RAese81/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=locusrobotics.com;
Received: from BL3PR10MB6163.namprd10.prod.outlook.com (2603:10b6:208:3be::9)
 by LV3PR10MB7867.namprd10.prod.outlook.com (2603:10b6:408:1b0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 18:27:07 +0000
Received: from BL3PR10MB6163.namprd10.prod.outlook.com
 ([fe80::1fb9:6bdf:cfce:7096]) by BL3PR10MB6163.namprd10.prod.outlook.com
 ([fe80::1fb9:6bdf:cfce:7096%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 18:27:06 +0000
Message-ID: <4a02dd43-c629-4c7c-83fe-256e6d444d60@locusrobotics.com>
Date:   Wed, 20 Sep 2023 11:27:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] ath10k: reduce invalid ht params rate message noise
Content-Language: en-US
To:     ath10k@lists.infradead.org
References: <cover.1612915444.git.skhan@linuxfoundation.org>
 <76a816d983e6c4d636311738396f97971b5523fb.1612915444.git.skhan@linuxfoundation.org>
 <5c31f6dadbcc3dcb19239ad2b6106773@codeaurora.org>
 <87h7mktjgi.fsf@codeaurora.org>
 <db4cd172-6121-a0b7-6c3f-f95baae1c1ed@linuxfoundation.org>
 <87wnvesv8t.fsf@codeaurora.org>
 <82e3e0a2-d95b-cffb-4fa7-2eaa4513dd48@linuxfoundation.org>
Cc:     linux-wireless@vger.kernel.org, skhan@linuxfoundation.org,
        wgong@codeaurora.org, kvalo@codeaurora.org
From:   James Prestwood <jprestwood@locusrobotics.com>
In-Reply-To: <82e3e0a2-d95b-cffb-4fa7-2eaa4513dd48@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0325.namprd03.prod.outlook.com
 (2603:10b6:610:118::31) To BL3PR10MB6163.namprd10.prod.outlook.com
 (2603:10b6:208:3be::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR10MB6163:EE_|LV3PR10MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: 91480537-1c1d-4aac-3feb-08dbba0731d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vEzA7iOLuy/gimr9AdgH8WPwC0sX8L4YErs1iuvm2qMCy/Tbi2zzwZwF8NGWFs0VdrGyEyA1gFeZLlLlGAF5a/96xl7yBvf6I8mEB19RcWgCnQzw7Np6FkHIi94ITHQGs0m6z1cwVTvvApiVy9KGiSa74ARstxJs5zIWuQTPTQin2SLtM6nYDD831cv9r5LRRxgIooxcwpER0JOY+8ksD/0/2GYVMy6FP7ANWGuQg8vQn9H3yo7qQCY/w0FVypiCjny0jJvF1Tvx7f2o87GUMrcw5catYq6CWJbh8UTA41fqC2jLouRLV6hp5z/s1FP91IKjzSzRWOFJK05X8q/6Kx02z24z8lfDbKvZmrvYBw1/Fr0D9QuS9ttFOenH90msyvgSevcpZnuh49SvY2kQ/YSdgjS1v0NK8Zx92ENk4iXfxOTW+Foqc7VjGipg/p5w+NxLXAXyzIeHZERJW2+61ft5c9KmbJT0ctO5FHZ+u+kFXRf1/cV8UKflgLRe4bs55+4XpKwoRRTz8SsYe/SFr1PPa7fcQljhFh8psizPFCCWkDJGlclM6//DzdOx0UaCYO3zwxIEmnKTu072jNTLJQAPo3Ybe/9tIhaWl+ocjOIG9KsGQHkB1HWcU0pAb4uzoZg81q+8wQ2yK4DP13GWZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR10MB6163.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39850400004)(376002)(366004)(186009)(1800799009)(451199024)(2906002)(5660300002)(15650500001)(26005)(41300700001)(6916009)(66476007)(66556008)(66946007)(316002)(966005)(478600001)(8936002)(8676002)(4326008)(31686004)(6486002)(6506007)(53546011)(6512007)(2616005)(36756003)(6666004)(86362001)(31696002)(38100700002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDhtWmlIR3VHckxUajVmcDRISXhIR3NsdWV5cmw3MlV0Y3pERDNxS0NMM1dr?=
 =?utf-8?B?TFREQnJJaVN6MjFldTRyTHg2c0trYUxWaGlnR0VnNWw4YzBaSm5iTkRWUVZ3?=
 =?utf-8?B?bkQrNzF3NGtiT1pVMkYwOEdiTEVEalhsdUlBc09pODJXQzVHcHVCY3E2T0FQ?=
 =?utf-8?B?MlZLbndFd3A4TTlGT0Vzbisyb1VjbHRuM045NVVZTGNFNkw1YStDYkdYMHNj?=
 =?utf-8?B?OW5JWG9lOTAvVFgvQ3p3UTFwQzRxMHppU3FUV2xCRXlrMTcrVWNBb0dkODRy?=
 =?utf-8?B?RkkrSzJKbEZ3VmtWOXZ5V244Z1h2Yy8zTVNYMjRkNG4va2pocElsSG0ySlVy?=
 =?utf-8?B?Y2RSSXBwdEZCZGJ6aEVwQ3FOVU8xSElwbFRYT2hmVzU1N24yS3hCVklFWjBj?=
 =?utf-8?B?aHp2TldmUzJLNGN3bUpMcHVIV0dwZmJ5RktWTklMaHp3QWdtb0VrT1N3TmRE?=
 =?utf-8?B?QVB6OGZML3ZEUWsybHFGZmtqN0lua25yYU9pSGpjbmQ0V25tWVFOaEhWbW9S?=
 =?utf-8?B?VVJTUllEcFA3RVRZRG4vQU1kUUIwOHhCcTMvYnljRjBwdU5EYTZxeExFcEpH?=
 =?utf-8?B?VlgvTmdQOWYweU9SZGFNNEg2VkpER3ZSRmNvWDBkTENZallGNjNrbnFPMDli?=
 =?utf-8?B?KzV0WmVVWDU1WklsV25Yb2NQbEU4SjFxdEVJa1g3aGJ5Umpya1B4aURZdTdh?=
 =?utf-8?B?MnltcEI4TXdpRGpxTjdDZWwxUlBaSGppUDN6bjZHaWc5TUhOaFRMZGVqdi9L?=
 =?utf-8?B?aWJuTUZERDFGdThSZk9vYXA5V0NjZnA3U2lweUhrTHFOK1dvUnR2MWIxUmFu?=
 =?utf-8?B?ekVwSGRTLzhRalpTeWMwSmJCREEvNXAwVURSZC9GekkvWlRwbzFVQnFsT3lU?=
 =?utf-8?B?Q2orWEloLzZMSlJFNWVjWnZQV25iZ1BscWtYbzAzRVVjcFdCMUJ2Q0NqN1ZY?=
 =?utf-8?B?SEdWWjJTb091SkRDQUdjejNhRWlBMTNKdlB3d2V2Z1htUlhFdmc1RkZiY2E1?=
 =?utf-8?B?bDdibnJwTjRJNlIzMyswczZDcE90VVd3Q3YwWVN2czNpUjFWQitHNlVQYS9h?=
 =?utf-8?B?em81dDhGL1RrUk9PSkZCNjE1LzFocHhEc2JNTjEwbFI4T1g3V3U3UEhCS09G?=
 =?utf-8?B?OXBxVmhiVktuK1pDSElVWGxyVEJyY1gxTXRRcHc1d1RNVklLbUM1cllyVmtK?=
 =?utf-8?B?c0Z1VGVSKy9ac1FBdEdGU2pFYlZJYm50N1ZRalpQaWNsUTBuYWk2cU9lclFi?=
 =?utf-8?B?dlRCeUo5N0k5SGkyNzdmdktVcms2NTNjdTBTeWVjdXh6Q3d4aDdvQ1lLYWJx?=
 =?utf-8?B?MTY4ZDR0T3FxRytnVHIxdzdDNEI4cnlnNDlsSE03WXptS2YvaVhiMjg4YTdR?=
 =?utf-8?B?UExpcWp4azUxeFFiMW4wVWt0SDFnRERPbVBSNDJLYU0rMXp4U2lycFNJM1Nm?=
 =?utf-8?B?RzVyc2t3UHdsYVc2QytTUnJLN0JyMEJQcWJ5cnI2eElMRUhnczRiQTBQYWtu?=
 =?utf-8?B?WklEa2RzNWM1eWpaTGVHSEZkVFo0SjlnWXNKN2hjUGh1NEwxVmNoN2xVcnVG?=
 =?utf-8?B?SGIydmlxZFlwVFJQdEIwUVVrVm8wZi9QTDhqdDhzd0haL1RwdHBFZW9NUjQ1?=
 =?utf-8?B?ZmVsTmNucnVOc0s5Z1h2OTF6TzZaY1JtRlN1MG9EQWhZa1N3c0lPZTFEbzhJ?=
 =?utf-8?B?TXYxYityL2djZzhDT2xGUk9mUStBMk0yUWVxS2daU1ppRER0WFNIWUFMdklJ?=
 =?utf-8?B?aDNVdE0wVFRkSFIvRFZBN2JKZm5YUWt2dklwbVFxTktMZkVzV3Y4T01Fd1FD?=
 =?utf-8?B?cmFkQnBIK29QaGlCYXFDaXlBM2k1MjNLaUI4V0N6T3M3M3VQSEJYaVB4alV1?=
 =?utf-8?B?TkNkT2RGVFVUTVNnbHBuQjVDd3FZSGlGRTRTYmxUd2RtZTNJMnVEQU9jbHhU?=
 =?utf-8?B?dGRLU3RSZm5oalhrN1J6MUNIUzRCN2lINWhTZ0hWamxXR1hJVUIwL2pCSHM3?=
 =?utf-8?B?c3Y0RkJqMFl3QVhJclFFMHk5YVBkZFk2RTdVTHM5eDMrQ0trRndhWlpGbU5W?=
 =?utf-8?B?aExmSFZzWWVxVGtucFhlcTlUVWJXNWl4b1lTWG05NTRCeW1QaTY5Yi9COGI5?=
 =?utf-8?B?bDdtNStMbUN1bUluOEtuZjhMVUovaDc3OXVzOHVrZmNuc3lyWXJCOGU2NGpE?=
 =?utf-8?B?L0E9PQ==?=
X-OriginatorOrg: locusrobotics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91480537-1c1d-4aac-3feb-08dbba0731d2
X-MS-Exchange-CrossTenant-AuthSource: BL3PR10MB6163.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 18:27:06.7793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 068f275f-67fa-4977-a33b-80fe854a9590
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lvN/rRM2VbLSxBK9YgqgKxPIQXTi+s1sItzJlJqOrtkbHa00V9EDTrfuMK2Eh+6Rsqj4qWWeCMANRDr6BgiqpjzVNg4gsNlUZDTlGwCA2Rk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7867
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/26/21 10:01 AM, Shuah Khan wrote:
> On 2/11/21 4:24 AM, Kalle Valo wrote:
>> Shuah Khan <skhan@linuxfoundation.org> writes:
>>
>>> On 2/10/21 1:28 AM, Kalle Valo wrote:
>>>> Wen Gong <wgong@codeaurora.org> writes:
>>>>
>>>>> On 2021-02-10 08:42, Shuah Khan wrote:
>>>>>> ath10k_mac_get_rate_flags_ht() floods dmesg with the following
>>>>>> messages,
>>>>>> when it fails to find a match for mcs=7 and rate=1440.
>>>>>>
>>>>>> supported_ht_mcs_rate_nss2:
>>>>>> {7,  {1300, 2700, 1444, 3000} }
>>>>>>
>>>>>> ath10k_pci 0000:02:00.0: invalid ht params rate 1440 100kbps nss 2
>>>>>> mcs 7
>>>>>>
>>>>>> dev_warn_ratelimited() isn't helping the noise. Use dev_warn_once()
>>>>>> instead.
>>>>>>
>>>>>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>>>>>> ---
>>>>>>    drivers/net/wireless/ath/ath10k/mac.c | 5 +++--
>>>>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/net/wireless/ath/ath10k/mac.c
>>>>>> b/drivers/net/wireless/ath/ath10k/mac.c
>>>>>> index 3545ce7dce0a..276321f0cfdd 100644
>>>>>> --- a/drivers/net/wireless/ath/ath10k/mac.c
>>>>>> +++ b/drivers/net/wireless/ath/ath10k/mac.c
>>>>>> @@ -8970,8 +8970,9 @@ static void 
>>>>>> ath10k_mac_get_rate_flags_ht(struct
>>>>>> ath10k *ar, u32 rate, u8 nss, u8
>>>>>>            *bw |= RATE_INFO_BW_40;
>>>>>>            *flags |= RATE_INFO_FLAGS_SHORT_GI;
>>>>>>        } else {
>>>>>> -        ath10k_warn(ar, "invalid ht params rate %d 100kbps nss 
>>>>>> %d mcs %d",
>>>>>> -                rate, nss, mcs);
>>>>>> +        dev_warn_once(ar->dev,
>>>>>> +                  "invalid ht params rate %d 100kbps nss %d mcs 
>>>>>> %d",
>>>>>> +                  rate, nss, mcs);
>>>>>>        }
>>>>>>    }
>>>>>
>>>>> The {7,  {1300, 2700, 1444, 3000} } is a correct value.
>>>>> The 1440 is report from firmware, its a wrong value, it has fixed in
>>>>> firmware.
>>>>
>>>> In what version?
>>>>
>>>
>>> Here is the info:
>>>
>>> ath10k_pci 0000:02:00.0: qca6174 hw3.2 target 0x05030000 chip_id
>>> 0x00340aff sub 17aa:0827
>>>
>>> ath10k_pci 0000:02:00.0: firmware ver WLAN.RM.4.4.1-00140-QCARMSWPZ-1
>>> api 6 features wowlan,ignore-otp,mfp crc32 29eb8ca1
>>>
>>> ath10k_pci 0000:02:00.0: board_file api 2 bmi_id N/A crc32 4ac0889b
>>>
>>> ath10k_pci 0000:02:00.0: htt-ver 3.60 wmi-op 4 htt-op 3 cal otp
>>> max-sta 32 raw 0 hwcrypto 1
>>>
>>>>> If change it to dev_warn_once, then it will have no chance to find 
>>>>> the
>>>>> other wrong values which report by firmware, and it indicate
>>>>> a wrong value to mac80211/cfg80211 and lead "iw wlan0 station dump"
>>>>> get a wrong bitrate.
>>>>
>>>
>>> Agreed.
>>>
>>>> I agree, we should keep this warning. If the firmware still keeps
>>>> sending invalid rates we should add a specific check to ignore the 
>>>> known
>>>> invalid values, but not all of them.
>>>>
>>>
>>> Would it be helpful to adjust the default rate limits and set the to
>>> a higher value instead. It might be difficult to account all possible
>>> invalid values?
>>>
>>> Something like, ath10k_warn_ratelimited() to adjust the
>>>
>>> DEFAULT_RATELIMIT_INTERVAL and DEFAULT_RATELIMIT_BURST using
>>> DEFINE_RATELIMIT_STATE
>>>
>>> Let me know if you like this idea. I can send a patch in to do this.
>>> I will hang on to this firmware version for a little but longer, so
>>> we have a test case. :)
>>
>> I would rather first try to fix the root cause, which is the firmware
>> sending invalid rates. Wen, you mentioned there's a fix in firmware. Do
>> you know which firmware version (and branch) has the fix?
>>
>
> Picking this back up. Wen, which firmware version has this fix? I can
> test this on my system and get rid of the noisy messages. :)
>
> thanks,
> -- Shuah

I know its been years, but reading through this Wen mentioned there is a 
fix in the firmware? I haven't tried all of the firmware binaries in 
Kalle's tree but the most recent definitely still spam the logs with 
this message. Is there a specific version I can use to get rid of these?

One thing to note is the older "firmware-4.bin" did not have this 
problem, but was met with worse problems like driver/firmware crashes.

Thanks,

James

>
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
>
