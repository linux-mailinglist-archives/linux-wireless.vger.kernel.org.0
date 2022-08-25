Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CBC5A17CF
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Aug 2022 19:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241393AbiHYRQb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Aug 2022 13:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239959AbiHYRQ3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Aug 2022 13:16:29 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC83169F5C
        for <linux-wireless@vger.kernel.org>; Thu, 25 Aug 2022 10:16:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VucpknED3k/ZtemwzrQFbTEXrGJBype18bOA8U8b4D+capZR4zBMXnQ+UJYLn4Ss7T3LW3NevZVEvzP/rqs4heem22JfBw/Gy4/NGiw2MpndwmntvrTR1MVsBc1Fbj9lBm2CEDXuaYi4+8uYoF2FViO4tMnCsV8s8clX44hM9zkiKYsHco3/krY3vzF2XVij3g0bNZ/BG/Vfn1/b09yjKgDCSMKKsqkEzmEAK5LBy8xsGHpzedT3feZFz8MfzZz6kXSKe+ssxtiyEHP+cfcJMX6KvmkScgqFD74WRnYFfm0sVbeAiR+yh/3GWAFeTASkkH/DvbUhRAZwKY2scpbU2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTYpXJf+ekONyF7OwzcOivCC3fbeWjERxMbDFVUXUsg=;
 b=eDbMWveEVDRcQKzX+fLIJafcWhAENnOVFM/M16qOrsLD7dL99H4hYXlNm0eZ4wcqBICkwbRhXzOhcAHSZe7Hv8ohJDlRItrkWXQe/2ueb8ZKK10WuAmeAryqzVRfdUnXxlkBO2G4Pbl6owSPDANQCTT6yQy7B9Zp4sFYzazb/lpUzazCF0G6lTtgATLKyfdYHxoS3wS3nL1YhZVi8sR8wpug/avWwv92r8LJBkc0gRJRLcRucIGTpOOqnqZGQhPbwN5x3WHCmFRsP1MJjtO2UYhct5PtvAqQ9VRsZaZrjDwyJj+SKmSVuhNKhrfauk74w/sAeKQebM/AKW+g4HjDNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTYpXJf+ekONyF7OwzcOivCC3fbeWjERxMbDFVUXUsg=;
 b=S+j0XrfThirChcxpYuIG8uf1PW0K0j5FyQtAeieYlFUkxJjt3txrrG6Stri85vQzQUhr6pIvjZNmwGlIRB1V/Q1pSPV/Cnpo9ucjkkKrhcEXr9GkakhPPG2seSNwSzIRN4SkI2MLJCpaO8Hy59TBAoKZkEf0ytc1QPrTregA1t0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BN6PR1201MB0004.namprd12.prod.outlook.com (2603:10b6:404:ac::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 17:16:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3%5]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 17:16:24 +0000
Message-ID: <7e00cc36-3a07-92e2-c60e-a3c8939b407e@amd.com>
Date:   Thu, 25 Aug 2022 12:16:22 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 0/4] ath11k: Enable low power mode when WLAN is not active
Content-Language: en-US
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
References: <20220720134959.15688-1-quic_mpubbise@quicinc.com>
 <ad99d238-dc1a-3233-fc6b-0cd49e428903@amd.com>
 <6daefd60-dcbc-06e1-8091-ea225690edf8@amd.com>
 <ecce8764-1760-4617-49aa-c111305ebd55@quicinc.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <ecce8764-1760-4617-49aa-c111305ebd55@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR16CA0014.namprd16.prod.outlook.com
 (2603:10b6:208:134::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58e89473-2706-48fa-d722-08da86bd896e
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0004:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kxrZz9Hw7yKeyaLl/P9rw2x1AeJp7PP4b1IyjN5/HnkIPOIrLnDWmXpgIox5TQxhdbUaHEhYskW1aMeC0D5BAGp3NNKdO9p+dY7eoMXBevLelQAzKrKDpPsJ/6Q0EQSpig2Uv1KUvOf82jhqL+MQv5vBZap/Ij8dZFAJxpNg0SWSnHw+o6yY+PL7uiD8/FGAF3IJlAqSWkJET3bZ/v1eG29cRs9X0G4iQGqGpyL3U2DEsWMgtW2oljnt7xQ4k2O7pNyUxkWET2c6n0J2MaeVg1tevD8UoN3tiA3LYg/44HnRwuVe2ZHqK+n9UR1jEebWTF5En47QRsRHigJt7WVZwGpSE1rYYnpk29/awxI0Ft8adb31k8OgbD482zas2rwDcfwvdGqjP/2S79oRPVKL39ZN8D8rEGlLlmLlGyYw43BH1uUqxLm4ul43ATKajvzJBestjlhBUhzmrRptSDaUNkfva52apRSWPa3uWRvuKZQ1assLReHPo39/YxLNR4RyzvaG9sZCP1jTVzZu1tzrq5Qpz2XatemzELUB6C5d2g51ILXH09ExYaW8kn8uU4TSMsvpN6MOui4x9Y7ICyqdQC1HibxdXDtZUsh8fvFdF3IU2N9ifizhQpI9lGxqwnXdn3vFNh1tx71bf5ii0xZ/p2U3IKywx3tRg8J7DOGldnkXfbR+Jfu+8UWpEZl/3Ruae0EVuEHxCJ9E84fSQFosqkEPynTcJAheUQxd7xF88UMheZsg2aQYRfb3+fOfb/LHxPBRiiQQOTwHmpsdKVparEXi3aj5ecQ2s7grSGt7FGQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(86362001)(31696002)(186003)(6512007)(4326008)(66476007)(6506007)(8676002)(53546011)(66946007)(66556008)(6486002)(41300700001)(26005)(478600001)(2616005)(38100700002)(36756003)(4001150100001)(83380400001)(8936002)(316002)(2906002)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGZFUDBaQXhwVmZiajFKeUZidVJ0ZllyQ0F5TE9WbWorZ0RyQmt2NDNxOUNE?=
 =?utf-8?B?dDdRSTZvOE4vd2pudjZGTjIyS0kvNUVlTW5kems1amlWd3BYVTVaU2Z4OHNU?=
 =?utf-8?B?eGlON0RweTZUemp3NDFaeHBkRkhVeEQzdnNxbERBNzlwUnBLUEN0NW9FSXhW?=
 =?utf-8?B?eXhCbElvbGFrSGxxRDVMY0JsMzBOLzZKZE5Ya0o1N3BYdTJJN1dSQXcwTlN2?=
 =?utf-8?B?em01NCtXd0Y3eUcxMFIwb3BTY2tIZE9WajJYemJCaEdCbzlSRHdnZER4THBR?=
 =?utf-8?B?ZlhNMDdrcjVaYWZVUzZBUGJ5Q01oS0xXbW9kd2h3alpqQ3dDK05qMDlaQmtR?=
 =?utf-8?B?enFUOWFFR0lHVjhUcnhwS1U0YWxZQ0ZGTjhIR0RPSmhWZDhNbXY3eEZSektW?=
 =?utf-8?B?SFJUY1BveElac0l6djZiV0NFZ1ZvTWRhKzllZjV5UnF6RDdJdTQ3d2o0SGMv?=
 =?utf-8?B?SlBEZE5oejNuTng3YTdIRmZ6RThtcm1mU0xXZFJsbitsUDc4eDdEUkNyTDg4?=
 =?utf-8?B?WkkzSlFHSXRVcU80eXpPL1VOdU12dDhoeWc2aitPUS9hOXVFTGZ4M3J0U2pa?=
 =?utf-8?B?L0MrNTcvTjIrZHp6VVIzNUpid0owR3dxVU8rbkVDdDQ2WkEzaFhiZmtMdXJ2?=
 =?utf-8?B?eGFvSFduM0Vyamc1QUNadHkydmZRQ1dsTFFZcDR3Y3MxZnJqRmxUYWE3TVY1?=
 =?utf-8?B?SDFpMURoSlZlT1NMcURpOUJLeU9zdk1GcUNXVk90Qy9MQ09VU2ZDT2tjTkFp?=
 =?utf-8?B?TzFabUV6dyt1TjRyakdKekx0OFRuM09UTklyZkpxem1IY1Vxd0VOUzNxVWwy?=
 =?utf-8?B?OGNYTWZWZTUwU01CWG4xNFFUeTJQVFhIZ2lGSW1janQ4U1Vjb2gwcDZ1YmdE?=
 =?utf-8?B?bmtTQ2x6V0VrNmNGZ1FzeUw4R1R2QUxjUEFmZTNUc3BKNnR6VkI0eDZPUlFZ?=
 =?utf-8?B?ZkpZbHZra1doZFhDbmptMUFFRndEZjhBOXA0T2d4V0dLYkFQS1ZxMG5IS1JO?=
 =?utf-8?B?eVhKTFBEWm1zNlh6dWloeFVYamlnWjhnVlAveGpiOEtZZWJTcFhscjhBVzZl?=
 =?utf-8?B?TzRzTGd4dVB4d1AyazkydSswRUszRmhjK21qV2RqSVc4NTNlL1hES204MzhN?=
 =?utf-8?B?SFcwRG9wRVBkRDZrcHNzZE5mZk5KOUtERXdhTTVnVk5yTzJNWGFIalJHTWFk?=
 =?utf-8?B?SHFzOWl6c0NFMmFCVHVtcUpTalJiajB3U29oeTUybWZwdHA2NkVjYVF4d2h4?=
 =?utf-8?B?NkMrWTg4S2g1N2lIVTJ1ZmdnbG40S2dYVHQrNFZNMXEvb2tpTk1LekkwR0da?=
 =?utf-8?B?cVFLZkl5QkNYTytzKzJpOW4yeU9DK3FTRWlEQU5nSWF1QTZkNmRTTVdDTzk1?=
 =?utf-8?B?aHJMM0dMalg2TW9RVlBTRnRsVmIvT0tMZ2ZYYWtSU2F4M0d4czhVYUxsZmp5?=
 =?utf-8?B?L2d3czZ2djg5ajBIVTdiVXB2aU96WXRVU0Y2dUI2RDNZUUEyOFlZMUwxSG9O?=
 =?utf-8?B?OGlWN3lPUVhjL2Y0bWlNb2NzWjhnTm4vYU9MK0svUjFjaE92aE5Od3dsRURP?=
 =?utf-8?B?bUw0SGE2YXZzbnZqUE9aMFNlMGJXcDdqUVNoNWhIT0VnTCtnaUxpSGhYNHdp?=
 =?utf-8?B?ZmZLOUMvWGJBRGFUeVRJQXNadmVBT2lROWRZc3kwTU1valBaWTdhSnNTazNv?=
 =?utf-8?B?TERrM2EzRU1qeXBnQlZCN3hFN3czb1N3a0lyZ3F4NDdRWXdOVmpwejlsZVJG?=
 =?utf-8?B?c2RHVDdYeTRWRDlGd3pQb1VFQUp2eGdIRy9hWHI0MjczMDFacnRoOEVDTXJH?=
 =?utf-8?B?YVl3d1RjSjh4OWdMYmg0NGxvZTVhZFhvNUk2UnFUQldnbTlxM0JvdDRZczVO?=
 =?utf-8?B?WlRMUkZ1dzdXVzZmaVR4OFJQMmVYdUZSZmNRUi9LSHh1UHNhMEE5WDJXVFlr?=
 =?utf-8?B?RWJMaGJraXowQ2l4WlNKQ2UvRFRURHhFZmtoSVQwZWtudFluY2ppYlJMWWdW?=
 =?utf-8?B?anQ0Q1BhNnAyak5LbkpQeEU0Sm1ncHRNQlI2U2VoRVE1Q2VQcDR4UXgwRFpQ?=
 =?utf-8?B?VnB4RFU2clo4ZlJ4VFNhdkUyamgrT0NuTS9RU1pNd1RzM0pIOVBnTm1jKzJG?=
 =?utf-8?Q?89kMnxxwXiPYO1va6As6swpIF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e89473-2706-48fa-d722-08da86bd896e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 17:16:24.0279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5XRu8C6rMN+yCOXyS1Cfk6/QYST7RQakZR7s4Ucc/woA0RkGmXRttEBDzYkFYv3yIGDgHn2PGWWVujR0xtOxKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0004
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/25/2022 06:24, Manikanta Pubbisetty wrote:
> On 7/23/2022 5:39 PM, Limonciello, Mario wrote:
>> On 7/22/2022 17:00, Limonciello, Mario wrote:
>>> On 7/20/2022 08:49, Manikanta Pubbisetty wrote:
>>>> Currently, WLAN chip is powered once during driver probe and is kept
>>>> ON (powered) always even when WLAN is not active; keeping the chip
>>>> powered ON all the time will consume extra power which is not
>>>> desirable on a battery operated device. Same is the case with non-WoW
>>>> suspend, chip will not be put into low power mode when the system is
>>>> suspended resulting in higher battery drain.
>>>>
>>>> Send QMI MODE OFF command to firmware during WiFi OFF to put device
>>>> into low power mode.
>>>>
>>>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
>>>>
>>>> Manikanta Pubbisetty (4):
>>>>    ath11k: Fix double free issue during SRNG deinit
>>>>    ath11k: Move hardware initialization logic to start()
>>>>    ath11k: Enable low power mode when WLAN is not active
>>>>    ath11k: Fix failed to parse regulatory event print
>>>>
>>>>   drivers/net/wireless/ath/ath11k/core.c | 237 
>>>> ++++++++++++++++++-------
>>>>   drivers/net/wireless/ath/ath11k/core.h |   8 +-
>>>>   drivers/net/wireless/ath/ath11k/hal.c  |   1 +
>>>>   drivers/net/wireless/ath/ath11k/mac.c  |  33 ++--
>>>>   drivers/net/wireless/ath/ath11k/reg.c  |   2 +
>>>>   5 files changed, 189 insertions(+), 92 deletions(-)
>>>>
>>>
>>> This series looked potentially promising to me for a problem that I'm 
>>> seeing on a notebook failing to sleep where WLAN_WAKE is asserted on 
>>> the WCN6855 on resume even though WoW wasn't set at all.  This is 
>>> problematic as it causes a spurious wake while SUT is reading from 
>>> the EC since two IRQs are now active and the kernel wakes from that.
>>> Removing the WCN6855 from the system it doesn't happen.
>>>
>>> I figured I'd give it a spin to see if it improved things.
>>> I applied the series on top of 5.19-rc7 and it applied cleanly but I 
>>> get timeouts on wlan card init (and of course suspend fails now too).
>>>
>>> Here's the mhi/ath11k_pci snippets:
>>>
>>> [    2.864110] ath11k_pci 0000:01:00.0: BAR 0: assigned [mem 
>>> 0xb4000000-0xb41fffff 64bit]
>>> [    2.864901] ath11k_pci 0000:01:00.0: MSI vectors: 32
>>> [    2.864912] ath11k_pci 0000:01:00.0: wcn6855 hw2.1
>>> [    3.106892] mhi mhi0: Requested to power ON
>>> [    3.107054] mhi mhi0: Power on setup success
>>> [    3.198178] mhi mhi0: Wait for device to enter SBL or Mission mode
>>> [    3.971019] ath11k_pci 0000:01:00.0: chip_id 0x2 chip_family 0xb 
>>> board_id 0xff soc_id 0x400c0210
>>> [    3.971025] ath11k_pci 0000:01:00.0: fw_version 0x11080bbb 
>>> fw_build_timestamp 2021-12-16 03:42 fw_build_id 
>>> WLAN.HSP.1.1-03003-QCAHSPSWPL_V1_V2_SILICONZ_LITE-2
>>> [    4.290328] ath11k_pci 0000:01:00.0 wlp1s0: renamed from wlan0
>>> [    4.308760] ath11k_pci 0000:01:00.0: Failed to set the requested 
>>> Country regulatory setting
>>> [    4.309028] ath11k_pci 0000:01:00.0: Failed to set the requested 
>>> Country regulatory setting
>>> [   14.386201] ath11k_pci 0000:01:00.0: qmi failed wlan ini request, 
>>> err = -110
>>> [   14.386210] ath11k_pci 0000:01:00.0: qmi failed to send wlan fw 
>>> ini:-110
>>> [   14.386214] ath11k_pci 0000:01:00.0: failed to send firmware 
>>> start: -110
>>> [   14.386243] ath11k_pci 0000:01:00.0: failed to start firmware: -110
>>> [   14.386266] ath11k_pci 0000:01:00.0: failed to setup device: -110
>>> [   14.386300] ath11k_pci 0000:01:00.0: failed to start device : -110
>>>
>>> And so - on.
>>> Is it functionally dependent on other patches in linux-next or 
>>> another tree I won't see in 5.19?
>>
>> I had a try with linux-next and your series but I reproduce the same 
>> failure I described above.
>>
>> ee3a066e4f4e (HEAD) ath11k: Fix failed to parse regulatory event print
>> 4f850f1e26dc ath11k: Enable low power mode when WLAN is not active
>> e320c8ef9841 ath11k: Move hardware initialization logic to start()
>> dbc26036c1ef ath11k: Fix double free issue during SRNG deinit
>> 18c107a1f120 (tag: next-20220722, linux-next/master) Add linux-next 
>> specific files for 20220722
>>
>>
> 
> Sorry for late reply and thanks for reporting the bug.
> After several rounds of discussions with the concerned teams on the 
> failure that you have reported, we have root caused the issue.
> 

Thanks for getting back to me and confirming that.

> The changes that I have posted will not work on other targets like 
> WCN6855 as is. It requires additional changes and therefore lots of 
> testing.

Well glad I reported it and saved you a regression!

> 
> For now, I have posted a V2 enabling the "low power mode" design only on
> WCN6750. I have started working on enabling the logic for other chipsets 
> also. Once the changes are well tested, I'll post a separate patch to 
> enable it on WCN6855. It might take a little more time.
> 

Will low power mode on WCN6855 also require F/W changes, or you expect 
that it will be able to be done entirely in the kernel driver?

I am eager to see if low power mode can fix my existing mentioned issue. 
  If it can you may CC me when they go out and I'm happy to test these 
patches too when you have them ready.

