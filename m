Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEFCB18C96A
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2020 10:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgCTJBw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Mar 2020 05:01:52 -0400
Received: from mail-bn8nam11on2131.outbound.protection.outlook.com ([40.107.236.131]:52651
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726690AbgCTJBw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Mar 2020 05:01:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYsEGLl/+EfBCC3fkM0j+XQqVr2YM2lXP4np+mZOmfZb998b4EE6yf+ksMvFDf1aahJtLhQofq3UgGfxl9sPkTGKW/Od5kW2LnnCHOTgaIv1C1+pzQHAQI956AvKTasY1EbxlaLhqjR8yOlBcqsuhKqkUCApl8n7W7C5Rf0UsnInHvt1qpyNr4qU92YjdjRhOjwxmWNxwn8OjWRat99BnQ22tjuRC9lpDQqCjodaD6ccjdtwngTeqd1/AgKW1lU6lPd4zWVgkRBGBM+IVVZ05hsdaO09rpzPE4KAmnJxC6BTrAKKBFjOMhfH8cRN5bOXBS9Y1S2I8bcuPDvBmJPtfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2TO5lrK1bIDMR6RpmlUHKe9R33TZf1cU4+1l+aVfiA=;
 b=FuYLlh4SnifsQ/Px+swURSvx5rj8ynf+28GKGG0rYNsxTsdSnXZLuHY9IWJM/UnI/l0KtoQNfpGxZwvr5DTLB0C8gtHz03MPFO5IS4+R17UUUD7tA/ceBXABWOZ1FfC2Sj44JMeqoZ3PUeCwQvuZfjFYHGxtIr3XmY3A4OQXr7Hngn/6tZXRfdSMvuKrBRwl1toaSgQSk5xMaIx9Lbg5Z+5kIngSXg5XWRmVj7d7tGv0rHK5z/P3g6z7FeEU06rHsTMcnVqdQqO+d9yl6I+vS03B2g3t4IkHKhNSprVlAdsxvur7kRbe8KeYENzIDTX9QENnSe3ob1wpeJYH3cEgsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2TO5lrK1bIDMR6RpmlUHKe9R33TZf1cU4+1l+aVfiA=;
 b=SFgeiUI1x4uaOPw1GtPsL3429bM6DmNErVytxd5mK/526eyIQd4I6rXJRw9nBCN2uO9BPnlhGzXF6BENRd8TXP35oNJNIJKII77D/v8ut70mEyluuYCmpCrfFDFCZrOlbs4BGwEnfMKr82/6+BQmbJRJGe8LthOgdeG/t3M2IwA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Wright.Feng@cypress.com; 
Received: from DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18) by
 DM6PR06MB4300.namprd06.prod.outlook.com (2603:10b6:5:1e::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Fri, 20 Mar 2020 09:01:48 +0000
Received: from DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::299a:b6f7:1338:e451]) by DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::299a:b6f7:1338:e451%7]) with mapi id 15.20.2835.017; Fri, 20 Mar 2020
 09:01:48 +0000
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
 <241fd81b-a252-ed86-b93e-6796cf1bce23@cypress.com>
 <d220ae51-9613-5b0a-2006-e9250603fd42@broadcom.com>
From:   Wright Feng <wright.feng@cypress.com>
Message-ID: <9b1d68be-ef2c-46f9-4fb4-292f62857f1b@cypress.com>
Date:   Fri, 20 Mar 2020 17:01:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
In-Reply-To: <d220ae51-9613-5b0a-2006-e9250603fd42@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR20CA0005.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::18) To DM6PR06MB4748.namprd06.prod.outlook.com
 (2603:10b6:5:fd::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.9.112.177] (61.222.14.99) by BY5PR20CA0005.namprd20.prod.outlook.com (2603:10b6:a03:1f4::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend Transport; Fri, 20 Mar 2020 09:01:43 +0000
X-Originating-IP: [61.222.14.99]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 19b6bd25-cf65-4810-8d9f-08d7ccad50ca
X-MS-TrafficTypeDiagnostic: DM6PR06MB4300:|DM6PR06MB4300:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB43002D35B4A6A1E008B022F4FBF50@DM6PR06MB4300.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:83;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(136003)(346002)(376002)(199004)(316002)(16576012)(81156014)(8676002)(4326008)(66556008)(81166006)(66476007)(6636002)(478600001)(8936002)(31696002)(2616005)(6486002)(44832011)(5660300002)(26005)(956004)(36756003)(52116002)(66946007)(53546011)(6666004)(16526019)(2906002)(31686004)(186003)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR06MB4300;H:DM6PR06MB4748.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5hU/a5CoWKFe5PPnUBApuXbwzndT3E/4hXTBStSy1V4Ip/gOAy+uH1ltYXqzV0tfAuthjdpemCcjHLrDRj9CbqpmgIHrM0jSe6Laxq8/GpxKvxZkEF3hk00pui5kNSOKmUOmcU18t/e32NgTFqlK85ig94DpqphizzMRN+gBwa+eMRjCjD7e0JTwb07yTmsJVgBxXTzPMUKfK13FgzOW4VeSblggXETId9c23IG+V4PrTKYhFxGMNNIvH2B9OEChUId6iSmyCgp7SahuWRFcJYIPvbE9JYDEpAlb/w83vHSoVx5VmLkeqLY9cfsYzxXTb5N+ZIbRuGJywXv9KYwHJ841HwiIPT/k+VN6/TSf4TmM20UzYxNZMRwqkGbMAEgi3eX3rnLz6QeacN9T7SSA+xBGFhftwBybHo2aNgJJmUExaAbGzYu/mpA0TGIJ1nfL
X-MS-Exchange-AntiSpam-MessageData: dfIKoHmeMuA+E4YneVaYfECad1810vzmOqaHSMEBkdr4xKx0DKF3lqLNvJ5nyXTtN0p7NayhN7EjaZVxXe0X0bofGxT6QjVQ0HfZc/9Py2Z/8SjEaJegWDEvyI7FuHz+I76OgcUWURcwvUenyRIm/Q==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b6bd25-cf65-4810-8d9f-08d7ccad50ca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 09:01:48.4806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rXeck7wlUBja5ouErmdT0Fgtq8k31Xcep0En+OfYOyaNHDSSR908nhQJ674an/JV581ixbM4+Mr881wUQbJ7hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB4300
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



Arend Van Spriel 於 3/20/2020 4:18 PM 寫道:
> On 3/20/2020 9:08 AM, Wright Feng wrote:
>>
>>
>> Arend Van Spriel 於 3/19/2020 4:55 PM 寫道:
>>> + Tejun - regarding alloc_workqueue usage
>>>
>>> On 3/19/2020 8:53 AM, Wright Feng wrote:
>>>> With setting sdio_wq_highpri=1 in module parameters, tasks submitted to
>>>> SDIO workqueue will put at the head of the queue and run immediately.
>>>> This parameter is for getting higher TX/RX throughput with SDIO bus.
>>>>
>>>> Signed-off-by: Wright Feng <wright.feng@cypress.com>
>>>> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
>>>> ---
>>>>   .../wireless/broadcom/brcm80211/brcmfmac/common.c  |  5 +++++
>>>>   .../wireless/broadcom/brcm80211/brcmfmac/common.h  |  2 ++
>>>>   .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    | 22 
>>>> ++++++++++++++--------
>>>>   3 files changed, 21 insertions(+), 8 deletions(-)
>>>>
>>>
>>> [...]
>>>
>>>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c 
>>>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
>>>> index 3a08252..885e8bd 100644
>>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
>>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
>>>> @@ -4342,9 +4342,21 @@ struct brcmf_sdio *brcmf_sdio_probe(struct 
>>>> brcmf_sdio_dev *sdiodev)
>>>>       bus->txminmax = BRCMF_TXMINMAX;
>>>>       bus->tx_seq = SDPCM_SEQ_WRAP - 1;
>>>> +    /* attempt to attach to the dongle */
>>>> +    if (!(brcmf_sdio_probe_attach(bus))) {
>>>> +        brcmf_err("brcmf_sdio_probe_attach failed\n");
>>>> +        goto fail;
>>>> +    }
>>>> +
>>>>       /* single-threaded workqueue */
>>>> -    wq = alloc_ordered_workqueue("brcmf_wq/%s", WQ_MEM_RECLAIM,
>>>> -                     dev_name(&sdiodev->func1->dev));
>>>> +    if (sdiodev->settings->sdio_wq_highpri) {
>>>> +        wq = alloc_workqueue("brcmf_wq/%s",
>>>> +                     WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_UNBOUND,
>>>> +                     1, dev_name(&sdiodev->func1->dev));
>>>
>>> So two things changed, 1) WQ_HIGHPRI flag added *and* 2) use 
>>> allow_workqueue basically dropping __WQ_ORDERED. Not sure which one 
>>> contributes to the behavior described in the commit message.
>>
>> The combination of Unbound and max_active==1 implies ordered, so I 
>> suppose we don't need to set __WQ_ORDERED bit in flags.
> 
> My reason for asking was the idea to only determine flags in the 
> if-statement and have following by one alloc_wq call, ie.:
> 
> wq_flags = WQ_MEM_RECLAIM;
> if (sdio_wq_highpri)
>      wq_flags |= WQ_HIGHPRI
> wq = alloc_ordered_workqueue(..., wq_flags,...);
> 
Yes, I also want to do that so, but the comment in 
inclues/linux/workqueue.h shows that
"@flags: WQ_* flags (only WQ_FREEZABLE and WQ_MEM_RECLAIM are meaningful)"
and "__WQ_ORDERED" and "__WQ_ORDERED_EXPLICITI" are for workqueue 
internal use.

That's why I set WQ_HIGHPRI by alloc_workqueue which is also seen in 
other wireless drivers.

> Regards,
> Arend
