Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25AD124329A
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Aug 2020 05:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgHMDDR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Aug 2020 23:03:17 -0400
Received: from mail-dm6nam10on2101.outbound.protection.outlook.com ([40.107.93.101]:56288
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726557AbgHMDDR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Aug 2020 23:03:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZ1AB8O8B7NtLg+YK63UGByN7xH82ntBOpSpISYoY8obrG76D1pjzDexQvDZscml3tlBq5mMo/8LGyUV0AcmofbsogPP4MvS6lKoQdIfoQCOKr1xahytkQjdI3uncgeukBYaHCFADLDWePtrTKbF/6xqrLFd+Jwtxi8EVGThxEHO7qkkxCCpmqoStlIIshPlWMl+xJ0eggQM12ki4LIv7H0yJgeAuHfU5wb90nX958bkOfvkksoJLadAgVEd0W6wlyQRoyOjJWOVa2OwAWJS/W0bp2WZMkWl0G8HHQVt/4u617NO0l91RBX1HRt4ADIZXok2Oi7iYNOzHn+jsQb/lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyjYpqSqnHjezz3Q1cTWpKaeBwhrY50rhCYn/NQVAIg=;
 b=lvMs4UtPAp9cAEhsZm7rs6cSlR97xrkIONp8BLdfzD2eDbExCJvVNxQrprfmWhTuyt7l045ZId1iNsXReIeJrCQO101HVvMxQIqKcTf3GUcieiSkiJpa2m7lArbw8jnUcX35lCkiQaO+8NFC/y+bXT4zUhJ53I7tSrTSabuIR0TUv7eNTu15fEGFqe6Y7msnOFs9EC0LilUcfguGOMBTB9zA5DL+WHn1v2D5S9efGuiDU2ecTSsMto25g9MqRgS7qfhcQlHm3cS7LC+uSc3XWQ5s+ktHD9ubPNHNMec4WIFZtz1JvSXTBHVAMYYak2qMbU8Flz3MVOut4vQD8snyeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyjYpqSqnHjezz3Q1cTWpKaeBwhrY50rhCYn/NQVAIg=;
 b=JhOllYs9Rj6tDDIVA7fi4suVa/y7KIVvnmoY+J9QhEi56UizpX+DsKJupFcSlv9HdcpjDr0ulgg4bRA+RNk23B/jM1VSL74vE3J2Wv70/Hl2dkDZiZaw/C4nmlGuqC3zYQxCkiZMz1lhwMF9scZt0DO6hpr0F/US/OE7MnipChY=
Authentication-Results: cypress.com; dkim=none (message not signed)
 header.d=none;cypress.com; dmarc=none action=none header.from=cypress.com;
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN7PR06MB6402.namprd06.prod.outlook.com (2603:10b6:408:3c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Thu, 13 Aug
 2020 03:03:14 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::d82b:5f42:b7a8:d819]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::d82b:5f42:b7a8:d819%3]) with mapi id 15.20.3261.026; Thu, 13 Aug 2020
 03:03:14 +0000
Subject: Re: [PATCH V2 3/6] brcmfmac: reserve 2 credits for host tx control
 path
To:     Dmitry Osipenko <digetx@gmail.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Amar Shankar <amsr@cypress.com>,
        Jia-Shyr Chuang <joseph.chuang@cypress.com>
References: <20200610152106.175257-1-chi-hsien.lin@cypress.com>
 <20200610152106.175257-4-chi-hsien.lin@cypress.com>
 <f0910f96-1d23-daf1-b517-363e59bff105@gmail.com>
 <875z9yr7lg.fsf@codeaurora.org>
 <ffcf55cc-b27d-78ec-ff4f-e7efa3087712@gmail.com>
 <87a6zapbqp.fsf@codeaurora.org>
 <0923f45f-03e3-a870-3d2a-35f982482e1a@cypress.com>
 <bed18d45-6119-53da-2b9c-d98d121c8298@gmail.com>
 <a7aaf6ac-d6df-ab57-4939-474b542f007c@cypress.com>
 <112956e1-df38-0a35-c2f0-8d9e1568d3c5@gmail.com>
 <725e7a73-6cbf-227e-58ea-2457179a5063@cypress.com>
 <df1c734c-ef7c-19ae-fad0-a5db148e5220@gmail.com>
From:   Wright Feng <wright.feng@cypress.com>
Message-ID: <8edbb3bb-a28b-6dae-1318-68c4b0478ad7@cypress.com>
Date:   Thu, 13 Aug 2020 11:03:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <df1c734c-ef7c-19ae-fad0-a5db148e5220@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR20CA0023.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::36) To BN8PR06MB5889.namprd06.prod.outlook.com
 (2603:10b6:408:c2::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.5.77] (122.116.94.118) by BY5PR20CA0023.namprd20.prod.outlook.com (2603:10b6:a03:1f4::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend Transport; Thu, 13 Aug 2020 03:03:11 +0000
X-Originating-IP: [122.116.94.118]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 396cd88c-164c-4539-d3cb-08d83f356b57
X-MS-TrafficTypeDiagnostic: BN7PR06MB6402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR06MB6402A8722DED8B6F00E2453DFB430@BN7PR06MB6402.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iEMGQ45i+PHeXsIpwnspYVkHoSacrjsuZWXaBfi40JK93HNrfUravZvp9ReqWe1A9mdtN53rGXFdsro7B+IzVPSSN2NusetOyGCLw9HcfaZpAslCtb9i7TKNIZSN/gTQzu0a88BVxTVG9xO/XCfAqM4nX7hCKigobdPyJmZ6qVeyvoykqv73GExPQ3Q/6f3W0YIB76IHUjMlVeCsh/thh/viVb3LXIIuifF7D2BhqPOJ/L2h0fYtQiDhMFpnttNRAFgAolz+eePXiTLvCDxeR502KXqNrhhfpy7eRx2vvr7xDFohiYpg1jjImKKs7fwwyypCuEpgO97dQMKNIky3BjRsgCRfgik9uvQsad1TIWSjGTt1fOfvOh9SEDcwI6vI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(16526019)(66946007)(26005)(5660300002)(186003)(31696002)(8676002)(8936002)(2906002)(31686004)(66476007)(44832011)(66556008)(316002)(52116002)(4326008)(956004)(83380400001)(54906003)(6666004)(110136005)(6486002)(16576012)(107886003)(2616005)(478600001)(36756003)(86362001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: M0ujtGJ9FZpxvk2wu1mk21Ghr52g7YH8hcDN1wFesaQrV6wy9RTH/ta/GK99imaJ4tQp+KIYj2M/RfWTX6gD3B1rD4uXqdX/hf6GBnIUOhuPjUoGIvA8m4arvFV1qU4VZEB8L9dtjF6MG7wp5CgvP23sRa2NnFXoaWYI3IjFqMAW+vJlBdPGzqN8jiRYmrKDo5zabcFPjtUx32SlSKQQ/Cf3Bw2hhnZk5D5dC1TLySDfq3g9XoMuJP6g5vQQX6BYta3897eOs6Lzd00qfm62fKY3J9oo02sK6GxXFR2v5OefGL/53Bg+gLYEMIidVla1lpt8ueU6o22wZoShTAMLtv2Ae0G64Kf3esD2R1zd0FjVZ5ut+UILmHVA8E4zRhajYxLExP1KwB36bxfRWho4C03z0pK7AhHAZNsK+3/s5ABQNwFzO3s2XdbZbawuhoaXQt1uJ4h3rbFj/tkP8YBM7na1AlIaCwx43OSaTsTCQt4+shj/1aB4lKsm8TGAQ2hbuQAdN7bbyjNQUIYnrstEBbN13T4kL3HhdjkII5lYD+3FV1pIguviwq/cF8yBAX6N8oeNCS5XyNtEwYQ88Cz2vHUPoyuErN4GYhIH75SySoQ4m9yJhEcj/xF5BkwB5f3n3cSBqaHg8oi29HqODkKwGw==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 396cd88c-164c-4539-d3cb-08d83f356b57
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5889.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 03:03:14.5406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SKzLTCrXZvjPWtw1U14MiasKsE4XY7NSmXyyfnPjWct2kB1Rnra4W+4RsxHJA1FH5dpDW4FAk44Ypx75Mx0v6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR06MB6402
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



Dmitry Osipenko 於 8/12/2020 10:22 PM 寫道:
> 12.08.2020 07:03, Wright Feng пишет:
> ...
>> Hi Dmitry,
>>
>> The last time the drivers I used is v5.4 and I was not able to see low
>> throughput issue as you saw.
>> At this time, I changed the base to tag wt-2020-0727 and I am able to
>> reproduce the issue as you did.
>> TX throughput with wt-2020-07-27 FMAC is 190 Kbits/sec
>>
>>
>> The root cause should be that tx_max and tx_seq are circle positive
>> numbers, it should not use ">" to check if it still exists available TX
>> credit.
>> With the solution below, I am able to get the normal throughput.
>> TX throughput with wt-2020-07-27+patch FMAC is 40.0 Mbits/sec
>>
>> Regarding another case about 40Mbit/s, I am using 4329b0(4329/2) chip to
>> verify the throughput because we are not able to find 4329b1(4329/3)
>> which is very old product around 10 years ago.
>> The firmware I am using is the same version but the build is for 4329b0.
>> (private internal build - 4.220.48). My host platform is x86_64 with 4
>> cores on Linux kernel 4.12. I will try your NVRAM when I have time to
>> see if I can find anything.
>>
>> ---
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
>> index e8712ad..50c8107 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
>> @@ -664,9 +664,14 @@ static void pkt_align(struct sk_buff *p, int len,
>> int align)
>>   /* To check if there's window offered */
>>   static bool data_ok(struct brcmf_sdio *bus)
>>   {
>> -    /* Reserve TXCTL_CREDITS credits for txctl */
>> -    return (bus->tx_max - bus->tx_seq) > TXCTL_CREDITS &&
>> -           ((bus->tx_max - bus->tx_seq) & 0x80) == 0;
>> +    u8 tx_rsv = 0;
>> +
>> +    /* Reserve TXCTL_CREDITS credits for txctl when it is ready to send */
>> +    if (bus->ctrl_frame_stat)
>> +        tx_rsv = TXCTL_CREDITS;
>> +
>> +    return (bus->tx_max - bus->tx_seq - tx_rsv) != 0 &&
>> +           ((bus->tx_max - bus->tx_seq - tx_rsv) & 0x80) == 0;
>>   }
>>
>>   /* To check if there's window offered */
>> ---
> 
> Wright, thank you very much for the patch! It fixes the problem!
> 
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> 
> The 4329/3 is indeed an older chip, but it's also an "old" device (Acer
> A500 tablet from 2011/12) that I'm using. Upstream v5.9 kernel just got
> support for the A500. There are quite a lot of other older devices with
> 4329/3 in a wild that are still very usable if user can wipe off ancient
> Android and put a modern Linux distro on them. Today that A500 tablet is
> still rocking hard running a modern upstream kernel, opensource drivers
> and KDE Plasma 5. The 15Mbit is a good enough speed for a lot of things,
> but of course 40Mbit will be better. Would be great if you could try to
> help with improving the speed :) Please feel free to contact me at any
> time if you'll have patches to try!
> 
Dmitry,
Thanks for the verification. The patch will be submitted to upstream 
within two days.
And with regards to low THP problem on Acer A500 tablet, I will create 
another mail thread to discuss with you.


