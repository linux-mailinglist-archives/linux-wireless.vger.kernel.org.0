Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E083970EDD3
	for <lists+linux-wireless@lfdr.de>; Wed, 24 May 2023 08:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbjEXG32 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 May 2023 02:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjEXG30 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 May 2023 02:29:26 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23FB11D
        for <linux-wireless@vger.kernel.org>; Tue, 23 May 2023 23:29:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZk+YLEJFr3DKgPLzh3/WWrHwII0WGQEHeSfd2FYMcmXYfb1bY2UXBG06s0hsOJL2+RIpV9J08cR1i0LwboUQGJNzrbK4be5+AuXCd1FpPOa1gQ/39f+j79LubG0UFFaoF8AqGzMow1pxWJt8JEbR0U/SHH8SNYNyKfkcKn5Ed45RM7GbsMWNd2qZAlSzwMjMx5TM2P83/Q+estDmPBPb/td0v9Y0cAPaItly7PWFGNKqVCIujKu69KSSDktLyKp7BtqkJ7gQafFhKZ8W19yPo5Rz8f9OPviOxvf8lqLghE2iDRuCD2B43t+HTbN2DzcubQGSmQoKX3ta+N+ihsqWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDy03ZEUi7x6uLta2SyJH3VG5cqZpVWg6X0EnakHVk4=;
 b=H3W1hWFYpRB1V0UIzSfbfj+ZthBjXQEvUmz5Vo5nrkNjJ/gBeuJuju8/IBMJlc87SGwuI5ZdhpyaM8GtGbS0nC1ywhXUcgsmzNzPPjCzPe0sZ1XW3ADsg5Xz2lGX8rdbl2qsx0+GLd+ma/evGslzwgqf/VSwbfytS8H1Ydc1p8fB3BJLahnmxcud6DOkNFmHb1TvcdD0t97Rev0a0K+51dNugVsEDxgG8XYuqpH/ybDj9QekSFxErJUlClK1ExgOSOSZjghb1PKjexjmLvk9SqgPEQ2PWF8ttII+1cCF40xhuc/GUu0mwpap5qda+p7IW+/mZZMjvRUOQkmf5PfRMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDy03ZEUi7x6uLta2SyJH3VG5cqZpVWg6X0EnakHVk4=;
 b=TVm1Mjyz0kt/m2ez/VIfhpJk8mlFF6Ij8dR7nXUizMPqaBUZKBPXje+WKCsddlN/qOqR9gX8VSu9Y/Qe9D94Ec8KmLTuDUkpRwMhVjHcv3qaiJ1XPFyEabqFgpOO1g/BBIAn8FAC5OXRrDMUMLNUEiUzZ6Q0yJISJ9W26P5iTkA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2843.namprd12.prod.outlook.com (2603:10b6:5:48::24) by
 BY5PR12MB4260.namprd12.prod.outlook.com (2603:10b6:a03:206::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Wed, 24 May
 2023 06:29:21 +0000
Received: from DM6PR12MB2843.namprd12.prod.outlook.com
 ([fe80::d2ef:d75e:d9b2:835f]) by DM6PR12MB2843.namprd12.prod.outlook.com
 ([fe80::d2ef:d75e:d9b2:835f%7]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 06:29:21 +0000
Message-ID: <fd8cc453-8487-5f01-ddf5-bb830ddf889f@amd.com>
Date:   Wed, 24 May 2023 16:29:12 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: Slow RTL8822CE 802.11ac PCIe Wireless Network Adapter
Content-Language: en-US
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>
Cc:     linux-wireless@vger.kernel.org
References: <75906666-df37-988a-c448-a6338b8a1cff@amd.com>
 <b7a59145-37b0-eade-3a9e-b565cc75de35@lwfinger.net>
 <4b3f4c5b-cada-bb7c-65f3-936437261b08@amd.com>
 <98f8852a-1710-2792-3196-e74fe614a03d@lwfinger.net>
 <eed0261b-6447-fe8a-ef98-073ae45ff137@amd.com>
 <b5f379e5-1917-d83b-ab3b-b651444d8f67@lwfinger.net>
From:   Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <b5f379e5-1917-d83b-ab3b-b651444d8f67@lwfinger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SYBPR01CA0126.ausprd01.prod.outlook.com
 (2603:10c6:10:5::18) To DM6PR12MB2843.namprd12.prod.outlook.com
 (2603:10b6:5:48::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2843:EE_|BY5PR12MB4260:EE_
X-MS-Office365-Filtering-Correlation-Id: e08e2ff5-df75-4274-2728-08db5c20354b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PXJoAQznLzY26Z3y6z0g0V4U9jzxmq0MIEFCVtZbLeBWYrGT0njXj3quD+h6QxJT2rrIkMWHKXQcRRqlIkYEih85hOq0WjTQnUR5RrigsogjwcNkKF9xsBI96R+wNcqspKbcEypeJjvPXjvofFNc6y5F3vq+rCdmA3M5l4/knP/W+50tIW4p0wdaZLkXTtWr/RAVZcCx/1r4iXyOaYtQtgD2+Q0ucBecEz/n0c/RYFJsJMquvQlURJ5ql+jfHFKZjduPEJImTiegKUqWrGnGd/tIvENQ/WsPcW8NqPeSTlCnHKV5TY6mPrDn18a8A9Sx56pUKwijoN0wGz1riNiRtWVn45OPUqNkLbsFdJIEgutiY8DADG1eXYpfd7SrNWrarbYoloF7lEJGFbgNO1hvPkO76B4+/spzzuAeLMZTTT4RaMGVqP5t5jfPDct6v/cwF1u2u64pdbSysq34gdC41waTTVKbbyPPgBJjEyywTFHul6UDYzYjVPMpau+QVghBL07PrGJ2hdjqoXBQm89UMLLGIQN99f0xWS5fYqXu5tTy+P5889uLQNKtRGE2qwYQ2HaomRq8IZA8L3JaAkByL8j3ezmCb3vxWyt6BeQTzKMH/CjsAEZKtYFRL9tNepfz3GPCBrXhcC8HBbBXURmS9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2843.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199021)(6506007)(6512007)(26005)(186003)(53546011)(38100700002)(2616005)(36756003)(2906002)(6486002)(41300700001)(110136005)(316002)(966005)(6666004)(478600001)(31696002)(31686004)(66476007)(66556008)(66946007)(4326008)(8676002)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWlYbFRiN050UUpuVFJRYzZYOVZyK2dOME5tVTlDd2U2Y0t6RjBudXV6bFRX?=
 =?utf-8?B?TlpqY2xWaHdZVnFkUzdWZ3BxNVVaQU5sdVB4bkE5akdMV0V2YjFUTEVjQTJ2?=
 =?utf-8?B?ZG04ZmgxNmRJa3BiRkJwbHQzZ1dnSzNIZzB1ekxaSWpZNVpDdDBpak5JMzBj?=
 =?utf-8?B?RDBacUxKbFhwcHhUTGZBTkZqb0MxSDZnUEJOUWViTGNxcFJYdXh1a3JEazNY?=
 =?utf-8?B?YXJUdkc1eWVIbmk2VzhtczEvSWQwZ01YR3dqRTZHakEyY1N2dG9oa2sxa2V3?=
 =?utf-8?B?YzUyRllwMFNBQU02NTJZdkdSQzFpSXNMM3VmcHozQTdNdzZlVEVRdVlqUm5X?=
 =?utf-8?B?c0pBWEs4Ri85aWFHVTVBdWF5UHdyOVdHNmF4alJNeUdxWTg3TzR3M2pCZ0RQ?=
 =?utf-8?B?REgva25WeExQYmVoTnBtbUFPN3Y3V3JEdjVGcUY5VEdlL0RoeXF2N1V1eWNM?=
 =?utf-8?B?UXpYYktIeWl0eURoVm04djBIV2ErKzBlY2Z0SC9WS1hKYjBrYVgxMFFTeEQx?=
 =?utf-8?B?OEZhcU9Ya3hKTEgwZGprd2ZuWGFRMDhNa3RNVXdDcng1MlYwWlB2WkpubzZh?=
 =?utf-8?B?ZXBOUGM5bi9tcEhpVDltNmZTdmxqdFdkNnNzN0M0UjM0OGl4OURHbjhsZWg1?=
 =?utf-8?B?aU1sVFlvUHF6Rm9zakFEUlFvNTgvTmxFcXdmN0ZYallKV0doc3hkeWFOVXFv?=
 =?utf-8?B?YW0rbnUwbktNc21lanB2SUNjUnltbkYvMUhmV3Q1RzdyT0pIVVJxNzg5Q1NQ?=
 =?utf-8?B?Z3JsbWZBdEd1d1BWT3JmRkQxSUJ2cnlDVVpZd1dJaVNSNkZ1QjZUbUM5dWMw?=
 =?utf-8?B?SGtWQlV1bUdEdnYrTFh4SksxaXpTTkNlU0dDT3ZJengxbm5Ed1M3dWRuakRY?=
 =?utf-8?B?T3NOQXpOb0pCakpoWFRqcFByVDAvcXZoa0Z5b0NEM01LQXFQRFRjQUVBMVV0?=
 =?utf-8?B?dFZEY3haWWJmZTRaSXV4WExkbzdzcXZmVXN3a0hWSm5YeVY0bzhPem9CVFEv?=
 =?utf-8?B?Nk0wNVNwODdSNjN5UlBHbmdTQUF4R21aTTE1MlVqaDVMMVkvVDlTcUJwSkhL?=
 =?utf-8?B?WXlxZGtTQlZOclBDcHlkQW9uVHNIdk01NktzSThhZ0lhR3JVVnMySnBhNERh?=
 =?utf-8?B?Q2RySk9hazFmNlVNbmJYdkR5c2txcW14eWZPWURWbHJCTmxXU0VlUmxLRlZm?=
 =?utf-8?B?Z1VrdGNNYnR1Tm5QaGJ1L0NMY2t5QS9ONWV3SDl6WFQ4WDczSHlWNG5WcEla?=
 =?utf-8?B?U1NrNVpjK2FmU0ttTnpJZTZOa0RaZ2dMaDNDeXZkS2psUmFFUXN1cGMyY3Vz?=
 =?utf-8?B?TXRXWXhRclZUS0lZOHFwK29wNHFwc3YrU0Z3bjBuWlZBTjU1SnhYQURrY2M4?=
 =?utf-8?B?a1dZYXFIK3poYWxvdVg5bUZ6cDlSdDlzZnk0SHUxcFQvajNUZmUyTVVMNWo2?=
 =?utf-8?B?Vnl2ZWFjR0Q0VDl0MWZ0VEl3SG1GZFUxY3IvV0xWS0hDa2ZJSWtCL1RlcWpv?=
 =?utf-8?B?TWFQRUtGZVRhMVZrZ2NmTER3NlkwVVpOQ0wwTGUwRTNnRXdKUlAwbTY3b3hB?=
 =?utf-8?B?YU9TNkRURzhaa2NrRndrNU9pMU03dlFKSkhQbmVvendadUxydzd6MjVRTHh2?=
 =?utf-8?B?bkVMeXVQaWJGdEpYaUFTUVBCc0FiaTBnK2c0elVKS3FhM21tQ1MyVmxwc1ZM?=
 =?utf-8?B?SWRVWUNvWDVOaXdiS1daTzBIQXhLZnRUY0d2MHhzRzdNZVFCbzJZeUN5ZEI2?=
 =?utf-8?B?ZlJaZmo4V0M4ZlIvQ0l4T2YxV2ZJVFNTSFJlUi9uSDNKZERZVUUzQjJ4bCti?=
 =?utf-8?B?L29tOEhkRjdQcHl5Mk9xbnAzbUNqZ0ZXVndwYjJkRTBXeHpScmYxeFkxcnZH?=
 =?utf-8?B?MmpvbkF3Y0o3cGZWNEdWeDY4ckZabm1FaGNGRis2TzJOTXdZY25IT3RtL3ow?=
 =?utf-8?B?VUNwQml0YTVhcG0rYkF6NUw2em85UkdDb0Fzdi9GQmxpTmQyMEYrOE9DbWls?=
 =?utf-8?B?Um80OTYrQWhTblMxVkU1SDY2K3phWkpndkVSU3ZwVDJIdVlTVTQ5K2dTRjJT?=
 =?utf-8?B?RmtKU2k0eEZ3VDU0SGpKYU1nWUdNU0oybnRRaUNwN2Y1MldMWjFHdDE0RTc1?=
 =?utf-8?Q?bvzYZNo94JweGF9IfYLwBWoZh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e08e2ff5-df75-4274-2728-08db5c20354b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2843.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 06:29:20.9995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hsWAWTGf9A/i42m5OeIl0zRJnkHl3qLzIkkbwEOABWnyz2OWSx+1erMgzoO7lSqNnmF5UUXGtB2rjnt6McL94g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4260
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 5/5/23 11:35, Larry Finger wrote:
> On 5/4/23 20:23, Alexey Kardashevskiy wrote:
>>
>>
>> On 5/5/23 01:04, Larry Finger wrote:
>>> On 5/3/23 22:10, Alexey Kardashevskiy wrote:
>>>> My bad, I should have mentioned that I tried this one as well, 
>>>> https://github.com/lwfinger/rtw88/commit/75e2c81 3weeks old, no 
>>>> difference there.
>>>>
>>>> And it does not look like there was any change related to my problem 
>>>> since then, is it still worth trying the very latest version? Btw 
>>>> reboot is not really required, it is Linux, not Windows, 
>>>> rmmod+modprobe should do 😉 Thanks,
>>>
>>> I added a bunch of stuff on April 24-25, so a 3-week old pull would 
>>> have missed some important stuff.
>>>
>>> The problem with rmmod+modprobe is that the rtw88_core module is not 
>>> removed, certainly not with a 'sudo modprobe -rv rtw88_8822ce, and it 
>>> is really easy to get a mixed bunch. I get tired of explaining that 
>>> to a bunch of newbies, thus I recommend a reboot. Of course, I do not 
>>> reboot.
>>
>> Turns out I had to reboot because of the module signature :-/
>>
>> Anyway it does not appear to work any better. Below are bad ping and 
>> good ping, the difference is moving laptop 2cm to the left. I believe 
>> the right driver is loaded as the modules are "rtw_" and not "rtw88_". 
>> It is quite bizarre how moving the laptop for a little bit helps and 
>> moving it back does not necessarily put it in the bad state, may be 
>> there is a microcrack in some PCB or something :-/
>>
>>
>> aik@aiemdeew ~> ping -c3 192.168.10.200 ; iw wlp1s0 link | grep signal
>> PING 192.168.10.200 (192.168.10.200) 56(84) bytes of data.
>> 64 bytes from 192.168.10.200: icmp_seq=1 ttl=64 time=7707 ms
>> 64 bytes from 192.168.10.200: icmp_seq=2 ttl=64 time=6677 ms
>> 64 bytes from 192.168.10.200: icmp_seq=3 ttl=64 time=5653 ms
>>
>> --- 192.168.10.200 ping statistics ---
>> 3 packets transmitted, 3 received, 0% packet loss, time 2054ms
>> rtt min/avg/max/mdev = 5653.382/6679.203/7706.911/838.350 ms, pipe 3
>>      signal: -56 dBm
>> aik@aiemdeew ~> ping -c3 192.168.10.200 ; iw wlp1s0 link | grep signal
>> PING 192.168.10.200 (192.168.10.200) 56(84) bytes of data.
>> 64 bytes from 192.168.10.200: icmp_seq=1 ttl=64 time=3.35 ms
>> 64 bytes from 192.168.10.200: icmp_seq=2 ttl=64 time=3.48 ms
>> 64 bytes from 192.168.10.200: icmp_seq=3 ttl=64 time=3.84 ms
>>
>> --- 192.168.10.200 ping statistics ---
>> 3 packets transmitted, 3 received, 0% packet loss, time 2003ms
>> rtt min/avg/max/mdev = 3.347/3.553/3.837/0.207 ms
>>      signal: -55 dBm
>>
>>
>> aik@aiemdeew ~> modinfo rtw_8822ce
>> filename: 
>> /lib/modules/6.2.9-100.fc36.x86_64/kernel/drivers/net/wireless/realtek/rtw88/rtw_8822ce.ko.xz
>> license:        Dual BSD/GPL
>> description:    Realtek 802.11ac wireless 8822ce driver
>> author:         Realtek Corporation
>> alias:          pci:v000010ECd0000C82Fsv*sd*bc*sc*i*
>> alias:          pci:v000010ECd0000C822sv*sd*bc*sc*i*
>> depends:        rtw_pci,rtw_8822c
>> retpoline:      Y
>> name:           rtw_8822ce
>> vermagic:       6.2.9-100.fc36.x86_64 SMP preempt mod_unload
>> sig_id:         PKCS#7
>> signer:         Custom MOK
>> sig_key:        
>> 0C:F6:31:12:B9:95:09:20:A6:62:E6:72:4F:D1:85:00:F4:A6:A9:B6
>> sig_hashalgo:   sha256
>> signature:      
>> 9F:F1:74:86:E8:B6:63:FA:F5:EC:2C:84:02:75:63:DC:66:C8:99:92:
>>          9D:A8:1E:2F:FB:5F:50:EE:DD:59:A5:EC:DE:5F:AB:8A:4C:F9:D3:8A:
>>          CC:CE:BE:3B:55:C8:E9:D9:AF:12:D0:A4:DE:B7:FB:A4:44:B2:F0:96:
>>          CD:E2:C0:69:0C:A8:EB:1C:9C:BF:A8:91:3E:D2:7F:AD:9B:7D:22:A4:
>>          3F:33:8F:86:40:DD:B3:42:B9:96:5B:94:CD:0B:E3:38:A0:8E:4E:8C:
>>          62:38:11:01:D6:16:EC:B6:E2:28:48:07:A0:C4:6C:6C:55:04:01:F6:
>>          C6:82:7E:F9:DE:EA:D0:20:63:41:4F:0A:D8:27:56:49:F6:84:E2:B9:
>>          21:DF:3E:4B:C2:A7:C6:0A:8C:B7:66:17:E5:81:13:D6:5E:CA:94:D1:
>>          E7:60:EF:B1:9D:52:E0:64:F8:4D:C5:54:CE:EF:F5:DC:2F:AA:22:5C:
>>          81:52:CE:AF:9B:FA:9B:8B:88:99:2F:2C:8E:6A:A3:44:58:3B:6B:08:
>>          78:43:B1:E9:27:C9:43:E6:49:BB:86:0E:23:10:0E:05:33:0C:23:B0:
>>          5E:47:92:EE:0B:96:EA:65:92:89:69:DC:73:50:1D:A5:96:5A:11:32:
>>          C6:2A:69:7A:B6:FE:6A:22:7F:69:61:B1:9B:F1:CF:66
>> aik@aiemdeew ~> lsmod | grep rtw
>> rtw_8822ce             16384  0
>> rtw_8822c             499712  1 rtw_8822ce
>> rtw_pci                40960  1 rtw_8822ce
>> rtw_core              319488  2 rtw_8822c,rtw_pci
>> mac80211             1486848  2 rtw_core,rtw_pci
>> cfg80211             1273856  2 rtw_core,mac80211
> 
> You do have the right modules. It would take a really strange 
> environment where moving the computer 2 cm would have a drastic effect.
> 
> I think I have gone as far as I can.


This turned out to be an hdmi cable via an usb-c->hdmi adapter, the 
cable seemed decent as it can do hdmi2.0/4K/60Hz. I was starting ping, 
making it stop by moving a laptop and then unpluging the adapter and 
ping would resume the same instance. Bizarre. I replaced with another 
dongle and cable, this time usb-c->displayport and things are great. 
Sorry for the noise.


-- 
Alexey
