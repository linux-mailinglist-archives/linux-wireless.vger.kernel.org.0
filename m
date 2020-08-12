Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8E9242475
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Aug 2020 06:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbgHLEDg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Aug 2020 00:03:36 -0400
Received: from mail-bn1nam07on2091.outbound.protection.outlook.com ([40.107.212.91]:54308
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725766AbgHLEDf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Aug 2020 00:03:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7puFZelZLX+SjdSAb1yNZBRyrFWcee9QASiZvcUwBPyJ9mZfxDfkbqXC0KcJoWdzv9n+JVMGPDdn+j2NBHFcbPyQwpKifQKAA5is0V7iKEs2WXCWMp7Ibvw7CtrdpsIjJDXmmeFXRB1dgOnYIMo9UkuQ5mW8eWWeUVK5j2yZquQO87iIILUxagyu4kRAAVqLcppoFukXz7TLmfjXmoOUrSgXKqzpf50KAQxqxJUVyUhgcgLAO0lSX8RbMzVUt7AEztrNXYrafQUrWP8dhDewe5cBhHsy4dGAwWTBdB0hRcCosMINnlex8zHesdRRgzVe8TZ47HyAXoWGWYWFDF2Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fp/rdj4L8hRC6H8IWch//6GILriNUZjsBdZIHbe8S5M=;
 b=TKBQRNXwf98eyyNCUD0gaeyqnwl/W4QbNhIXbzUaG1XokYi/C8Hzr3N+HLdcvf93QAGwzaa2Aoivyf7E/2F3nC4ziWlFIysWWeVa+lLc+by1DIK69Uoz6uHBMFNR9751JUn+WGw7/q6i9t+zgyHkZFFnPWutcAdZ/KdnrslUH04EnJg4uN01WdDkykvhFfrz8YR8GPCU5+n6SX7ukZ71Pl0GxokVGgqMw8IZmBaMH+UbunaH8GfERgaqELPU4zZ02/frWkQHORabWYB+6G0Y45d1dfUmBWmc9SVbrRD5jpnDJwPeYNVsFadj5uE2s7Q7egxfsMvENdLeHLD7/7Qs3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fp/rdj4L8hRC6H8IWch//6GILriNUZjsBdZIHbe8S5M=;
 b=Unq0YUGxxEZVUL4P5M0I/XGoIekIg83+IgvxA8qOBkCZXAMyX2Yb4dGZW4d+HqR4fwbUxp7SHkefFi3impsRw73a0V1VNCJ+VxAeYnzgFcL3EukT80x3OnZ9nl1uIt58Dm1QG0n9llvbHrXioyF7kIRqoVHerp1rTywB2p9GV3A=
Authentication-Results: cypress.com; dkim=none (message not signed)
 header.d=none;cypress.com; dmarc=none action=none header.from=cypress.com;
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN8PR06MB5796.namprd06.prod.outlook.com (2603:10b6:408:d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Wed, 12 Aug
 2020 04:03:31 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::d82b:5f42:b7a8:d819]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::d82b:5f42:b7a8:d819%3]) with mapi id 15.20.3261.024; Wed, 12 Aug 2020
 04:03:31 +0000
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
From:   Wright Feng <wright.feng@cypress.com>
Message-ID: <725e7a73-6cbf-227e-58ea-2457179a5063@cypress.com>
Date:   Wed, 12 Aug 2020 12:03:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <112956e1-df38-0a35-c2f0-8d9e1568d3c5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::42) To BN8PR06MB5889.namprd06.prod.outlook.com
 (2603:10b6:408:c2::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.5.77] (122.116.94.118) by BYAPR03CA0029.namprd03.prod.outlook.com (2603:10b6:a02:a8::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18 via Frontend Transport; Wed, 12 Aug 2020 04:03:27 +0000
X-Originating-IP: [122.116.94.118]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5d78e0f3-d08b-45df-abc7-08d83e74ac71
X-MS-TrafficTypeDiagnostic: BN8PR06MB5796:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR06MB57968C87D588160ECF8DE9ADFB420@BN8PR06MB5796.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o4dOF7zphgmTzw6odSRBJMTCqjnxNXuhhZ/wOoggazMKzmjz9OrGoXf8F5DUmy9KX0ZGNKaaqJMiFC5jldfDPSTlUOsZROLcHLuGIzGL4tgBsatQelSqzA+15qFM5xUgbucW+nzFIkpWnyl6t2cJDoL4X7ZEE1jSaGdMnh9bgdPQGwmQOvgusFeV3ntylalouISXk1fB6KjqfrtWYpNGu8p3k3sBx813tNtsM4IRDKTqcWd7Pp5jy8SPyDYaCaj6m+p2igCviHlecTq3KqW+06Ch/6WFGXqquA4UN1HxrkYbL6opWuE+F53xmHHYNGxHO/1m1F0dDaJB97k+9NgtzQkuQSJQIAfAS76DxOZZRICMg0UHTA9MRDSOcOvLX/+sxjYkcKC5VDsxZyCYAGY8lbdYYxJMYLAuuIKu3yL1tbK2j8rObZIPdWuRf/UQXmIp9NfrX1JA1xx/Ww46TxIssg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(316002)(54906003)(110136005)(16576012)(52116002)(107886003)(5660300002)(4326008)(6486002)(186003)(956004)(31686004)(8936002)(2906002)(36756003)(6666004)(26005)(86362001)(66556008)(66476007)(83380400001)(66946007)(8676002)(44832011)(16526019)(31696002)(966005)(478600001)(2616005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: oGAYjEgbdSVf3D8H7fDdyQyzED4etlIdAui/f8wGMWa59e63kBROQa6i9JEEZdn4dB5np/PJ3WtLb41FKkrFz9V2BR+uYRSk4NYl5jGI2aBgmQo1eqYc7Hf2v+8E3bav4SOWWkcfyVjlDtYVEVdWFstdg26vLX32q6oXJasxy1VkOkgeWOxFdn+y5Qb3kdu1xr80kY5Cb4/wmat9qQoiHVQRCRZtXFE3h0NfMxrHunHBcpgrQFtqka/pBQXxbZPAB5k0jqKwxJJSn9oie2JjxShbCLawk0N+fi8IoA75vbR+xyJkEd1U1LRRivxUQoiDPsBh8u/mS8ZN6JkmiYKtrq9D0KHlbH1zhu4uxRj7mzr7SSc1y2E4M6/J5prbVV0t/tzInZX4zvtxRNusQCszsACizat90FOE2vuJCav4oGOG9O4InlEkUmY/o8KyGg68CRkdBcdxxcN67DPTO+4mMrllQ0PPk8SLr+hJc7MdvJ1xc9Ht6jB+jPmhMXqqS/svJQZCTKFr5offjVtqy2PxtHAP8s5BViqs42co7n7cXVWa3tHL9tynvJCWTjTCKbA2OCnjadfYXaIc66saHKs0Nc9KcJE3iF2qpx9nYrxOhQiLUP7XL4rJ/kzH2kdBF01JlB2yvVAhEgGdpPFSZX3+aQ==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d78e0f3-d08b-45df-abc7-08d83e74ac71
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5889.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2020 04:03:31.6426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z7a8qmB4Y8HJ1MeUSvW4xtEzykg337QePBUUj1BhHVuzU9a4JYR/ssU9Nq1+fCTp0o2iYURETu6PL/CcwbI5rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB5796
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



Dmitry Osipenko 於 8/11/2020 10:54 PM 寫道:
> 11.08.2020 11:35, Wright Feng пишет:
> ..
>> Hi Dmitry,
>> We have a fix for this issue. But we got the different test result
>> numbers from yours, so would you help us verify the same with
>> following patch in your setup?
>> With your confirmation, I can make sure we see the same issue.
>>
>> ---
>>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
>> index e8712ad3ac45..ea07bb1bfe27 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
>> @@ -664,8 +664,13 @@ static void pkt_align(struct sk_buff *p, int len,
>> int align)
>>   /* To check if there's window offered */
>>   static bool data_ok(struct brcmf_sdio *bus)
>>   {
>> -    /* Reserve TXCTL_CREDITS credits for txctl */
>> -    return (bus->tx_max - bus->tx_seq) > TXCTL_CREDITS &&
>> +    u8 tx_rsv = 0;
>> +
>> +    /* Reserve TXCTL_CREDITS credits for txctl when it is ready to send */
>> +    if (bus->ctrl_frame_stat)
>> +        tx_rsv = TXCTL_CREDITS;
>> +
>> +    return (bus->tx_max - bus->tx_seq) > tx_rsv &&
>>              ((bus->tx_max - bus->tx_seq) & 0x80) == 0;
>>   }
> 
> Hello, Wright!
> 
> I tried this patch and it doesn't fix the problem.
> 
> Could you please tell what firmware you're using?
> 
> I'm using stock firmware that comes from the linux-firmware package and
> this NVRAM [1].
> 
> [1]
> https://github.com/grate-driver/linux-firmware/blob/master/brcm/brcmfmac4329-sdio.acer%2Cpicasso.txt
> 
>   brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac4329-sdio for chip
> BCM4329/3
>   brcmfmac: brcmf_c_process_clm_blob: no clm_blob available (err=-2),
> device may have limited channels available
>   brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4329/3 wl0: Sep  2 2011
> 14:48:19 version 4.220.48
> 
> It also interesting that you're getting 40Mbit/s. I never managed to get
> that speed on 4329 using upstream brcmfmac driver, but was getting it
> using downstream BCMDHD driver. At some point I even tried to figure out
> what's the difference which makes the upstream driver to have
> significantly lower throughput than downstream and had older BCMDHD
> ported to a recent upstream kernel, unfortunately I couldn't spot
> anything obvious. Having BCMDHD and brcmfmac back-to-back on the same
> hardware, the same kernel and using same firmware (IIRC), the BCMDHD was
> more than x2 faster. I also remember that I had to enforce HT mode on AP
> in order to get speeds over 15Mbit/s using BCMDHD, which made me to
> conclude that upstream brcmfmac driver just doesn't support that HT mode
> for 4329, but now I'm seeing yours iperf results and it makes me wonder..
> 
Hi Dmitry,

The last time the drivers I used is v5.4 and I was not able to see low 
throughput issue as you saw.
At this time, I changed the base to tag wt-2020-0727 and I am able to 
reproduce the issue as you did.
TX throughput with wt-2020-07-27 FMAC is 190 Kbits/sec


The root cause should be that tx_max and tx_seq are circle positive 
numbers, it should not use ">" to check if it still exists available TX 
credit.
With the solution below, I am able to get the normal throughput.
TX throughput with wt-2020-07-27+patch FMAC is 40.0 Mbits/sec

Regarding another case about 40Mbit/s, I am using 4329b0(4329/2) chip to 
verify the throughput because we are not able to find 4329b1(4329/3) 
which is very old product around 10 years ago.
The firmware I am using is the same version but the build is for 4329b0. 
(private internal build - 4.220.48). My host platform is x86_64 with 4 
cores on Linux kernel 4.12. I will try your NVRAM when I have time to 
see if I can find anything.

---
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c 
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index e8712ad..50c8107 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -664,9 +664,14 @@ static void pkt_align(struct sk_buff *p, int len, 
int align)
  /* To check if there's window offered */
  static bool data_ok(struct brcmf_sdio *bus)
  {
-	/* Reserve TXCTL_CREDITS credits for txctl */
-	return (bus->tx_max - bus->tx_seq) > TXCTL_CREDITS &&
-	       ((bus->tx_max - bus->tx_seq) & 0x80) == 0;
+	u8 tx_rsv = 0;
+
+	/* Reserve TXCTL_CREDITS credits for txctl when it is ready to send */
+	if (bus->ctrl_frame_stat)
+		tx_rsv = TXCTL_CREDITS;
+
+	return (bus->tx_max - bus->tx_seq - tx_rsv) != 0 &&
+	       ((bus->tx_max - bus->tx_seq - tx_rsv) & 0x80) == 0;
  }

  /* To check if there's window offered */
---
