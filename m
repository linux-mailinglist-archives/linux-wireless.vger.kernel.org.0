Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E475A57EF1D
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Jul 2022 14:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbiGWMJV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Jul 2022 08:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiGWMJU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Jul 2022 08:09:20 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7F9220CE
        for <linux-wireless@vger.kernel.org>; Sat, 23 Jul 2022 05:09:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAyn7Th7PfQBY7zZzhgV9B1lcIhJmaZ13j7T6yHuqRBpW5TUKq71m0m/aYClGbuipY6zOueKULHmA72xE4ynOGZB8BShjUbt4P2XOg8HP2uENK60iAzMkSG41k6z1jV5Z8KYBEQGRBhIc8du3FVQ4oib0zHLL+v+yKyl4L43wQLOKQDUKIaSVXN6W3FoXM4Rch4FjL9ZFD5Lmcnwop+QA5o45wkJzFD3fkKTfPmBZPc/swAYv+OgAvhYyaOlL29b6wu8CUe0001TiN/W3wVN/+0FMtqqtY8M5CFMhw35JkCvLJhLzl0twqc9pKEYinLF3t630wgPolIFRBahv90tmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2/aKuCKupK2rMTava7uLU+ZDtf3kIWCxW7Xvlfy9m0=;
 b=RldtKMvyorfLRxM7YEDzignUc40LAjjxU+obz27ctZQQfOBgrupCgX0lXOFrSFNWDBVg2VAilLzwVhQyaDOHbmJhpC/znJZaMpG7/upqXADkkU4puvh2zjGuaZIgkyFeal2psvMQHmTfvj80v4oGhAbFzN4W3B/4jgUELzgf4ddR5P3SdkBh+5vMBxSWxVEZ7M0N9d0bhUJeMNNXgIXbLV2KkjpjpnFrVEW2MlyVYejPY2Le4APttpCcY2hDxWvHYiMs/CSeQ6DIW05Zi7CW0Sgg0iP+vM4orRYr1A8EaW3YeSYAPdW1RBVb9H9c36wFPXQh1dsZ0iYNBgj9TYB5gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2/aKuCKupK2rMTava7uLU+ZDtf3kIWCxW7Xvlfy9m0=;
 b=ubde+iUBmJGxDPTQmvP+JQl7WZMwGdxS7hGwoRqwYSa4AU0K/IBKIc52GC+caBXoHNQbb5zw8ez4DOJh/XeaytsReJNiAv7lgOH8jsaKJ6ZjmUlVwR2ociQzJI/+/JWvdpGuQvYvmh06TRBdOyp2FHARCVq8rGw6NJ1o0XN5a1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH2PR12MB4922.namprd12.prod.outlook.com (2603:10b6:610:65::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Sat, 23 Jul
 2022 12:09:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%6]) with mapi id 15.20.5438.023; Sat, 23 Jul 2022
 12:09:13 +0000
Message-ID: <6daefd60-dcbc-06e1-8091-ea225690edf8@amd.com>
Date:   Sat, 23 Jul 2022 07:09:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/4] ath11k: Enable low power mode when WLAN is not active
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
References: <20220720134959.15688-1-quic_mpubbise@quicinc.com>
 <ad99d238-dc1a-3233-fc6b-0cd49e428903@amd.com>
In-Reply-To: <ad99d238-dc1a-3233-fc6b-0cd49e428903@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:610:77::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 871fbe43-56aa-4ea8-4715-08da6ca42839
X-MS-TrafficTypeDiagnostic: CH2PR12MB4922:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nPIuXGSM0LvMvsO4TJO/Oqajc5gCwhWCXxnexoIOpxWCi+OskABstbCVFL68Ak0P4z/besDoQ32ysFKkuEDem+Pggh2hUB/NZPzYDe+MiTeVHroNxkeBNN0WaBCkAbX3iRY1ztV3mevUepCciXawJqH5WshoCvL3SrDGqq72fROcIEDd3n6F+BeCQDu/AzOjo/J9XbjtYrfgszu+toZX0v77DRdY2BO0d2XOQJm+zZH7+Jv8j6MUXClcebrdKnRTQR3rKR0lbP1gISz5b3EhBCYQg/jKbXxrjufcjs59sUacU5TqvPmbeNt3xanRDUu3oFOlNzR9A6nUTcYyOebYgcwC2Y0XMScBDWQc7j5r4UaHmHZBPlKbTpsGc6fQZSysNoud7SF5aTIpnaqS497RKmBFROSsQubN7tZ9lkMBj51LEpQEdv71vH8is1H8Unz9m/vc50CAiJuRsRadX4eIsxzvnsjC3WvvEXsmnwMlbCxtkxc/rWeGvoTqlPTgeXEO5nCEQw4D3hT5eApduOnUkZiXM6qAVlB1ufGEs9fALM+ah3JZToxe8Rs4NE4q1OMxIwAnCek69tx8k0lpEnxbatIkGb9AUzql/1V3/MGTc3ispzT7Qp1Azqf9ELxUrAgmF9TC93iY9L+TE3/DFpUYJTSr6nUZ4hkPIQzG+bVgaV7qfFIS+m6TYNr820geWtr8DT7e2A8SAyx/a+pKIfkV/TmqiTmBZCMs0rtPffuUGFg07Nuca54b+ehenJPsfJssQupJ0FMYKqwJoQ9f+I0WiHjmEXLLRw+K1iNumZ5KR9YOWq/EYbVXvF038qXQ7qiy/Mlz/bnsl6kx87zEzldKgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(86362001)(31696002)(38100700002)(8936002)(6486002)(478600001)(5660300002)(316002)(66476007)(66556008)(8676002)(66946007)(4326008)(2616005)(186003)(83380400001)(6506007)(31686004)(53546011)(4001150100001)(2906002)(41300700001)(6512007)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cW9wR01aVDE4SXVycXdKT3ZsVlhWZ0ZqcTMvRmpCRm0yRGhJTUVpM0hyZnk3?=
 =?utf-8?B?eFlmVEs4d2l3dGdQVDcycFNJKzVtQ3hHcW9uOTFIelJjQndRVmVLODVQNDZs?=
 =?utf-8?B?UUozUDIzNm9GaUNhNmVKVSt6cmp4c0VTWHYvTmFEdUtIbkZxZVBqZDFkRUVq?=
 =?utf-8?B?MzU0NHJPREw1d0JCaHc5clBweDdHUm8vZ1RDME52N1RYK1ZLN1dxZ3I2UXpV?=
 =?utf-8?B?bStXbkxwYlJnL1hrLzFVSVhyb095dSt2cm1kUmFFSWliUzJVUERZQ2tlMTIv?=
 =?utf-8?B?TkhBb1BCUHBLNisxaW9JR0FTZ2RWUnE2bExvaDY2MTh0WDF1TVFmTkEzWjVY?=
 =?utf-8?B?Y1BMTDVVRzJSNStUaU5XMCtRKzFjTWNLWFF4MEVXNU1pMkdyT0lZVEMxR2Rr?=
 =?utf-8?B?K3hIb0RudVd5ckkrK25tUFZVT0RpWDdtT0M3UUl3azQ4Y3FBWlhWSk91OHdR?=
 =?utf-8?B?b2hCQmJvdFdJYndZTVFrZTQ2UGppaDB1Y3NKVkVxK04vV2phRHVsSThSMndQ?=
 =?utf-8?B?bTU4N05uMUh2VWJwaklIWXROQnFmQVZyQTVWS1U2Z0loQWJ6d0VGK1ExQUp1?=
 =?utf-8?B?MjlKQWYxK3FWbGpXTzU5V3BQVzlRUXM5bnVmOURHcm5WVlYxQnQzVTJ0SEpk?=
 =?utf-8?B?K3dBR0cvRUZ6bHcwV2tmWkVpZ2dCVVNhZ0U4aHN5ekw4MGpFSWNyT3l0QldW?=
 =?utf-8?B?M1YxKy9jS0t6UnFDaFJrSG8wSjFSZWFCVityMXJJMWYxam0rWGJMQ0xnZFpD?=
 =?utf-8?B?WE8rQnc5SytKYzJnVHhlaWVIK0cvYnpWbzhLVjRLMmdxYXZhZnlwR0F2ZGZn?=
 =?utf-8?B?aUpZVllWNkdUVDdFeVlNcWlIM2Z3QU92RmtFWWs4TGpJZ0hZdjgzUFFNQ0dC?=
 =?utf-8?B?YThORE9QZGtZSjI5ekxqOUFKWUFXbGJHa3FSSUhSK1BoMFBPMExyODRlMWNL?=
 =?utf-8?B?bzVrT0tpeGZsV3RlRENQRnAwT0cxcGwrdHV1dGl3RzNsT1FMV2pIRFdnV0Qy?=
 =?utf-8?B?RHVCN0FvcEYzWm9Cb1FXYkZ0WHZZaVNnamZpeWR1M0VBS3F2SEJlZVc0dHpj?=
 =?utf-8?B?SWFNS2hwaGMwZ1crbUo5UjNYZEI3M3FTMmtFM1NabDVSVEtoMnpUNDYzaFNt?=
 =?utf-8?B?bXpwOTRjcXozbFRXWFU0azVsdVpyaEJpVG94bStZUG9mZHJDUk9YKzFPV3R4?=
 =?utf-8?B?TFRTb3ZhV3B0cngvZ0RoZk1HWkpFaTJPVUpvMWhNNTBFLzBvQkpJRHRuSU1B?=
 =?utf-8?B?VTliM2pRQ2R1bHNoWjBITUhTZzFGMnBCKzk1akFNR1BXYVN4cWJWVUxWWDY2?=
 =?utf-8?B?Q2NqVURoTHF2b2w0cFVBS3diS1Jpa0VqbmVzYXRwcWRNbitjZzQ3YW92WUFQ?=
 =?utf-8?B?cGR3S2JEN0hBSTJrTTJzbWhGUjdFcWRwSGsrSlROUStGN0NTc2RHK0ZPWndn?=
 =?utf-8?B?Qk5NaFJJSmVjVnF3YmdibXFMRzRrVmhSZktXblpUWmVMVlJDN1FBNEVXd2dT?=
 =?utf-8?B?RUZtQk4zMGVLYTlWcktpemR3L3l0WWNrTjgrdld1VzY5QS9EM0lzRUx5VkJN?=
 =?utf-8?B?Vlg2N0FReS9pS1lLODhQSXBBNXlkWGZyNW4wWjVIMGlhUDU0VTZVRGhmMU02?=
 =?utf-8?B?RWoydlJHQS9vd1RvOUdqa0xBeHlZaUt4V1RNVTkvQ3F4bTRBUFhmVEdzeUVT?=
 =?utf-8?B?V09WTjIwaGNIZ1A1TWl0OE90ZjdOaGVpYk91UzgwUVRoak1ubVlWRWlpcDln?=
 =?utf-8?B?L1REbzJZM1l4QUZDbjVLaHN6UW5NSUROcjlhS3lMdkxxeU1uUE1BSzhUWHNw?=
 =?utf-8?B?WGVnbXJNMU0xU1NaOHJZVEZKSnN4MEYwTkU5N2poZFFJaWdYekMyaWFyeUgx?=
 =?utf-8?B?QmM0Wmw5TmY3OVRDU05yZnFHSWRyRWtKTHZnYWtISXoxampWWE1ZRWZ2M2pQ?=
 =?utf-8?B?dndqRnQ3eExQZjNXWjkxMytUckZZUnptYzlIM2ZkQ2NWRUJMZ1pkZGUxTXow?=
 =?utf-8?B?UDgyd2dxdFU5OURZbGV4T2E4eXZMOVlCMkFsOFVhditWRU1tbHcyM0lUc0RQ?=
 =?utf-8?B?dzd2MzFqOGlhZS9Qdm1MOTJPYzZHMVJnNkhHL3RUMGwySExCQWowcEdMREdE?=
 =?utf-8?B?cytNamtLOEFLWTk5NHYxYkhXNVNQeDNrZy92S0RPT1VVK1NjcmMzZXArMW5x?=
 =?utf-8?Q?creuKVVqCySgpscET8hbzZ52BBLWUPYX7SrwPKllm1Fp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 871fbe43-56aa-4ea8-4715-08da6ca42839
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2022 12:09:13.3968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UmHDJSLpMdH7+lBVkQwYN440hvJyoE5DLfcnxM5MDGniVp839XT2hu0P9La95skmDuexb6Vjnu/YsgAXRKOhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4922
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/22/2022 17:00, Limonciello, Mario wrote:
> On 7/20/2022 08:49, Manikanta Pubbisetty wrote:
>> Currently, WLAN chip is powered once during driver probe and is kept
>> ON (powered) always even when WLAN is not active; keeping the chip
>> powered ON all the time will consume extra power which is not
>> desirable on a battery operated device. Same is the case with non-WoW
>> suspend, chip will not be put into low power mode when the system is
>> suspended resulting in higher battery drain.
>>
>> Send QMI MODE OFF command to firmware during WiFi OFF to put device
>> into low power mode.
>>
>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
>>
>> Manikanta Pubbisetty (4):
>>    ath11k: Fix double free issue during SRNG deinit
>>    ath11k: Move hardware initialization logic to start()
>>    ath11k: Enable low power mode when WLAN is not active
>>    ath11k: Fix failed to parse regulatory event print
>>
>>   drivers/net/wireless/ath/ath11k/core.c | 237 ++++++++++++++++++-------
>>   drivers/net/wireless/ath/ath11k/core.h |   8 +-
>>   drivers/net/wireless/ath/ath11k/hal.c  |   1 +
>>   drivers/net/wireless/ath/ath11k/mac.c  |  33 ++--
>>   drivers/net/wireless/ath/ath11k/reg.c  |   2 +
>>   5 files changed, 189 insertions(+), 92 deletions(-)
>>
> 
> This series looked potentially promising to me for a problem that I'm 
> seeing on a notebook failing to sleep where WLAN_WAKE is asserted on the 
> WCN6855 on resume even though WoW wasn't set at all.  This is 
> problematic as it causes a spurious wake while SUT is reading from the 
> EC since two IRQs are now active and the kernel wakes from that.
> Removing the WCN6855 from the system it doesn't happen.
> 
> I figured I'd give it a spin to see if it improved things.
> I applied the series on top of 5.19-rc7 and it applied cleanly but I get 
> timeouts on wlan card init (and of course suspend fails now too).
> 
> Here's the mhi/ath11k_pci snippets:
> 
> [    2.864110] ath11k_pci 0000:01:00.0: BAR 0: assigned [mem 
> 0xb4000000-0xb41fffff 64bit]
> [    2.864901] ath11k_pci 0000:01:00.0: MSI vectors: 32
> [    2.864912] ath11k_pci 0000:01:00.0: wcn6855 hw2.1
> [    3.106892] mhi mhi0: Requested to power ON
> [    3.107054] mhi mhi0: Power on setup success
> [    3.198178] mhi mhi0: Wait for device to enter SBL or Mission mode
> [    3.971019] ath11k_pci 0000:01:00.0: chip_id 0x2 chip_family 0xb 
> board_id 0xff soc_id 0x400c0210
> [    3.971025] ath11k_pci 0000:01:00.0: fw_version 0x11080bbb 
> fw_build_timestamp 2021-12-16 03:42 fw_build_id 
> WLAN.HSP.1.1-03003-QCAHSPSWPL_V1_V2_SILICONZ_LITE-2
> [    4.290328] ath11k_pci 0000:01:00.0 wlp1s0: renamed from wlan0
> [    4.308760] ath11k_pci 0000:01:00.0: Failed to set the requested 
> Country regulatory setting
> [    4.309028] ath11k_pci 0000:01:00.0: Failed to set the requested 
> Country regulatory setting
> [   14.386201] ath11k_pci 0000:01:00.0: qmi failed wlan ini request, err 
> = -110
> [   14.386210] ath11k_pci 0000:01:00.0: qmi failed to send wlan fw ini:-110
> [   14.386214] ath11k_pci 0000:01:00.0: failed to send firmware start: -110
> [   14.386243] ath11k_pci 0000:01:00.0: failed to start firmware: -110
> [   14.386266] ath11k_pci 0000:01:00.0: failed to setup device: -110
> [   14.386300] ath11k_pci 0000:01:00.0: failed to start device : -110
> 
> And so - on.
> Is it functionally dependent on other patches in linux-next or another 
> tree I won't see in 5.19?

I had a try with linux-next and your series but I reproduce the same 
failure I described above.

ee3a066e4f4e (HEAD) ath11k: Fix failed to parse regulatory event print
4f850f1e26dc ath11k: Enable low power mode when WLAN is not active
e320c8ef9841 ath11k: Move hardware initialization logic to start()
dbc26036c1ef ath11k: Fix double free issue during SRNG deinit
18c107a1f120 (tag: next-20220722, linux-next/master) Add linux-next 
specific files for 20220722


