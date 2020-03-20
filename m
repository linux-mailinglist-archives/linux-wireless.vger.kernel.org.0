Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA03518C8A4
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2020 09:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgCTII6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Mar 2020 04:08:58 -0400
Received: from mail-eopbgr680106.outbound.protection.outlook.com ([40.107.68.106]:57294
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726820AbgCTII6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Mar 2020 04:08:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hr7U3wm+lTv2TEOh0/ohhWvNQZlHg1Pq0Y6dw0ASz6Rn3kUcK3OkyfFnrwZQtD5iEteuHysVP0qTOExtFr6gk8eXypjavX9eluTjOrKz94fAiYZGDj/bw6TMeqKy0sSRTeiQxlRBW7aDzVBCXjQoQwcQAdDCm/7GrEvrqKO6LTAdrXU1I+OAS2UqJWmfPFGOu76CB+wBqtfgqAeYqYpSgWu/pS03ivkUhhKOiBNzoCN3B0L5YEm/RNp++v2RwMBZRmWmOC5ALkEfn7sod9i4xOiRiTxrudo7G1+LxDJEhG5/nbgHMF0Ripu7xB2sKGK7IAJHzE8a0riVIRVkv1lc1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBDhHCKqDrnl13K0A/1jrfJ9n0W7IDynoX/CxcoVrBY=;
 b=ba8++BLCGL44iqgVtVqzaQZRMNM9oV8ybQqkIO007gGlG/gDEUVqb76KqejCuoV7OqS9jHWpiwrMJcai31DE0nFUV4Z+A9nQZ7RG8YX+KKSA3kQe9wFpGeZOG5YabcoKSLMSgqdIDQUa3Dg/OEOOP7Ki+hB/kEsYzxA/lvjsS/rwwY5G5DBHnbPBl+ezy/gCRQa4/t7DJaViV1J21HEU/lK9ZfFO/lk44M732VBGW89BMI0syo5GZV2tFEhgHELgMUkBu63nXntyjmVVhVtcsFFlo6Z9swTY8QvPX5hBsTW7Ub4HwiCkJBWb8/e/MT0EKU99TPoEjCXXRLm7uAj7Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBDhHCKqDrnl13K0A/1jrfJ9n0W7IDynoX/CxcoVrBY=;
 b=p1DRk5LoF5vrIxds4RqL2pNHu6/DuVNFfJaYk20UZ25joHXZM0KAsZM9avgDWDqIDpgJEkWYl7cFQ+MpnjM9Ek8aRzBdWyekJ1A7Id7mpmQq3GEnNtdKvY6UzJCbhWVrOR7ZMRVDKiOHpxZ5x/mM9jMKSfOjVaZkU2ioJPP3Sts=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Wright.Feng@cypress.com; 
Received: from DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18) by
 DM6PR06MB6412.namprd06.prod.outlook.com (2603:10b6:5:111::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Fri, 20 Mar 2020 08:08:54 +0000
Received: from DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::299a:b6f7:1338:e451]) by DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::299a:b6f7:1338:e451%7]) with mapi id 15.20.2835.017; Fri, 20 Mar 2020
 08:08:54 +0000
Subject: Re: [PATCH 3/3] brcmfmac: make setting SDIO workqueue WQ_HIGHPRI a
 module parameter
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        franky.lin@broadcom.com, hante.meuleman@broadcom.com,
        kvalo@codeaurora.org, chi-hsien.lin@cypress.com
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com, tj@kernel.org
References: <1584604406-15452-1-git-send-email-wright.feng@cypress.com>
 <1584604406-15452-4-git-send-email-wright.feng@cypress.com>
 <40e33702-d37f-085d-a5a7-7f09ae9e2629@broadcom.com>
From:   Wright Feng <wright.feng@cypress.com>
Message-ID: <241fd81b-a252-ed86-b93e-6796cf1bce23@cypress.com>
Date:   Fri, 20 Mar 2020 16:08:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
In-Reply-To: <40e33702-d37f-085d-a5a7-7f09ae9e2629@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0041.namprd17.prod.outlook.com
 (2603:10b6:a03:167::18) To DM6PR06MB4748.namprd06.prod.outlook.com
 (2603:10b6:5:fd::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.9.112.177] (61.222.14.99) by BY5PR17CA0041.namprd17.prod.outlook.com (2603:10b6:a03:167::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19 via Frontend Transport; Fri, 20 Mar 2020 08:08:51 +0000
X-Originating-IP: [61.222.14.99]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7a631838-6da2-4e4e-bd0f-08d7cca5ee70
X-MS-TrafficTypeDiagnostic: DM6PR06MB6412:|DM6PR06MB6412:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB641203EC872ED720AACC43A2FBF50@DM6PR06MB6412.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:57;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(366004)(39860400002)(346002)(199004)(81156014)(16576012)(8676002)(44832011)(66476007)(478600001)(6666004)(66556008)(2906002)(66946007)(81166006)(186003)(26005)(31686004)(16526019)(2616005)(956004)(8936002)(4326008)(316002)(5660300002)(6636002)(31696002)(36756003)(6486002)(53546011)(86362001)(52116002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR06MB6412;H:DM6PR06MB4748.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AJi2RJn3bUHW/oAmKiWT7DKcQ5vhGusqB7QOkwnVV9M9VuQZ1b2w2Msyj1HERh3OZdHg+oF0zfK7Kvoi8BBmaWBg85zm341RVxTeYdFB4B3XItg9y3ZICYPTuwonjNEgkzv22K9EY2QHMpgt1uTAr4jp02UFCM0DnnER8bry4OI3qE/Penxl7DqdJytaBAYFzQloLSiA4PJ5RCYGdB+tk6RhQQK+SD5buWy3SPJVI3tIss9cZ/Yu82+A4ulCmM8KVvTMxi/IWu7mls1/a0LDUgB1Cj5tujZzdbFQZHDrJcnoLeYCFuleq4bWy5Y8YjPw0JV6ogfuV3oCsXyBITKq03qk9+izstApcwouKSlsxdtj6GKMHX8aNNvSNFm9PYqgctTuTyHguXQkCj2qKLqmwNVh7D9Qb/PbFhCZV2A35gLkckMzsEC9iikHmOOMeV8H
X-MS-Exchange-AntiSpam-MessageData: W/e77989zqJAha0nwTAsXbYDbtk8ZW8FDROf7xGt60fXeNpAmOhO7OH8shgGuKTmT8oOefZgam5TkurdCjESE3frB9scS4YZzWp2AktU0NLwg1ICk9Rj9zWuJ4XpIaDu5LmPbttiqSgCAz0xeBChqg==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a631838-6da2-4e4e-bd0f-08d7cca5ee70
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 08:08:54.0049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kl+r0d40D9lZl8fJjEhTqOaJy6jVVHI2ad2zp82MVbLOT2FsXE5Ff2IiRMxtK81dmFVKFKTSbEck9AGHhONbGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB6412
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



Arend Van Spriel 於 3/19/2020 4:55 PM 寫道:
> + Tejun - regarding alloc_workqueue usage
> 
> On 3/19/2020 8:53 AM, Wright Feng wrote:
>> With setting sdio_wq_highpri=1 in module parameters, tasks submitted to
>> SDIO workqueue will put at the head of the queue and run immediately.
>> This parameter is for getting higher TX/RX throughput with SDIO bus.
>>
>> Signed-off-by: Wright Feng <wright.feng@cypress.com>
>> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
>> ---
>>   .../wireless/broadcom/brcm80211/brcmfmac/common.c  |  5 +++++
>>   .../wireless/broadcom/brcm80211/brcmfmac/common.h  |  2 ++
>>   .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    | 22 
>> ++++++++++++++--------
>>   3 files changed, 21 insertions(+), 8 deletions(-)
>>
> 
> [...]
> 
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c 
>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
>> index 3a08252..885e8bd 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
>> @@ -4342,9 +4342,21 @@ struct brcmf_sdio *brcmf_sdio_probe(struct 
>> brcmf_sdio_dev *sdiodev)
>>       bus->txminmax = BRCMF_TXMINMAX;
>>       bus->tx_seq = SDPCM_SEQ_WRAP - 1;
>> +    /* attempt to attach to the dongle */
>> +    if (!(brcmf_sdio_probe_attach(bus))) {
>> +        brcmf_err("brcmf_sdio_probe_attach failed\n");
>> +        goto fail;
>> +    }
>> +
>>       /* single-threaded workqueue */
>> -    wq = alloc_ordered_workqueue("brcmf_wq/%s", WQ_MEM_RECLAIM,
>> -                     dev_name(&sdiodev->func1->dev));
>> +    if (sdiodev->settings->sdio_wq_highpri) {
>> +        wq = alloc_workqueue("brcmf_wq/%s",
>> +                     WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_UNBOUND,
>> +                     1, dev_name(&sdiodev->func1->dev));
> 
> So two things changed, 1) WQ_HIGHPRI flag added *and* 2) use 
> allow_workqueue basically dropping __WQ_ORDERED. Not sure which one 
> contributes to the behavior described in the commit message.

The combination of Unbound and max_active==1 implies ordered, so I 
suppose we don't need to set __WQ_ORDERED bit in flags.

> Regards,
> Arend
> 
>> +    } else {
>> +        wq = alloc_ordered_workqueue("brcmf_wq/%s", WQ_MEM_RECLAIM,
>> +                         dev_name(&sdiodev->func1->dev));
>> +    }
>>       if (!wq) {
>>           brcmf_err("insufficient memory to create txworkqueue\n");
>>           goto fail;
> 
