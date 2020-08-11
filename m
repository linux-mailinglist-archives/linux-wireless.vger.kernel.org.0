Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B88241853
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Aug 2020 10:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgHKIfc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Aug 2020 04:35:32 -0400
Received: from mail-eopbgr760124.outbound.protection.outlook.com ([40.107.76.124]:57984
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728253AbgHKIfb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Aug 2020 04:35:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkTp/h+C9auKv+tvWa32qi+eY+f9YhqyXxWr3zFZkQUytu3KZN5SmYB+o+s0Q1+BWxSIty1LVZLdtkiuTghHFo5UZxswMrqnagrBihEHQdW43ZSZ4gh2WjHR6WeKdYqfaxVarJTT+uuZlyAf8BP4P9+3lSZKMPn2JjSo3n7UIXi2X9ll1DAviLug+LqOhAOhWiPClt6DQvAt4ZDM89H7siYQF02+O/ZhYtryAoTamJUVyeSUGt2U5ShQmTcYvqKm7CtXPA3J05BYwR0wq0ag1cULAuVPTbYf2JilKQQUH5n6dCjOfy0m+aCnK9nQ9JDoZszWNo2a+oRUPpW+/M5qTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PK3pqEazXJ+afZtXStUKuOJZw4qTOmTmWwNTjUy57Eo=;
 b=RS3dDC/YzTitXa5b+/+XiBohDt49tv4Fnt259plr4/GwcljoqAGHElRXCAgKVailU504kww0zJmJhL56dObkEA4n6M0NRXzk+wewDOhPnaCFVM8p9XGw6yzrQBDF7S55N5K6gcqWaLJSgtDx0JUxqUX9P102yqaHcC+u7K6WI5rOF6um81ZADCpK2cV3eTYXlMtOj3kofMhWV7Btj+xhu/GL54hJSQOCdwojD2wodWjl/Fg3AyFhFYr1rVL5eONBWcBS3vc82UMrOWM8vCQfJ27btFoejfpVrX5Nztany/GWX8ji7Rj0l35/qatawld+3qTszWZzs1DIyfyYeX43Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PK3pqEazXJ+afZtXStUKuOJZw4qTOmTmWwNTjUy57Eo=;
 b=jmHUfse7lXt0x31Zx3tzB/8xFgNs075TWI9CQ8er1mEaWvDCB/UKK9uMEBQyideppPL8BMAOWKzIR1nAqRr3FuUIqiuA3BQOiNSdNl0R2tfRPq6ksOc84QeTyhCHANopjrFD9ubcqtElQ4tyl903Ya++3cQcaa4FVpVCLGqGRGQ=
Authentication-Results: cypress.com; dkim=none (message not signed)
 header.d=none;cypress.com; dmarc=none action=none header.from=cypress.com;
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN8PR06MB5618.namprd06.prod.outlook.com (2603:10b6:408:65::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Tue, 11 Aug
 2020 08:35:28 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::d82b:5f42:b7a8:d819]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::d82b:5f42:b7a8:d819%3]) with mapi id 15.20.3261.024; Tue, 11 Aug 2020
 08:35:28 +0000
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
From:   Wright Feng <wright.feng@cypress.com>
Message-ID: <a7aaf6ac-d6df-ab57-4939-474b542f007c@cypress.com>
Date:   Tue, 11 Aug 2020 16:35:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <bed18d45-6119-53da-2b9c-d98d121c8298@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0064.namprd11.prod.outlook.com
 (2603:10b6:a03:80::41) To BN8PR06MB5889.namprd06.prod.outlook.com
 (2603:10b6:408:c2::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.5.77] (122.116.94.118) by BYAPR11CA0064.namprd11.prod.outlook.com (2603:10b6:a03:80::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.17 via Frontend Transport; Tue, 11 Aug 2020 08:35:25 +0000
X-Originating-IP: [122.116.94.118]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 212be75a-2be3-4a25-d667-08d83dd18024
X-MS-TrafficTypeDiagnostic: BN8PR06MB5618:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR06MB56188780FB1A279C6B7C8F32FB450@BN8PR06MB5618.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ESs10BdqdJ88yjCpsEOL6Z6sLKgnoe7Wc4aQkuk22G/46SfA3Zfd48nlrgsnT/LLrqoIw2xTLcME1xHKULs3OtaYm/+rPyI8N0B1jSKc/xT5bQIC6MiP1zJ/kTWu5wFeQwp63TI3GX3dczzA6EtiZRPbI9lIoBDI/YEkroObY4pMXY9MKiOb9ydc8MdLEz7MBjKlWErO5PBrpTbB+t0DPoORa0kEQSpHYqdJniVIiJ1KnnKdFEfHBzbvFFh3tilqC7fXJ6PQRqX3h2kmZtuK98B0yJsQ4dYrJH1YSdWIlj+naHi9U2kSlcve1tiisPpndFyiHYqdmwlVwnpu7xVLh7EiaKzmbtJLd8rVGCNaxXT0W09oNca5CSMKoOmHh5Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(4326008)(66476007)(107886003)(66556008)(8676002)(44832011)(6666004)(31686004)(86362001)(2906002)(186003)(2616005)(956004)(83380400001)(16526019)(478600001)(5660300002)(53546011)(54906003)(36756003)(31696002)(110136005)(26005)(52116002)(8936002)(316002)(16576012)(66946007)(6486002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: On1WdSX6fX5Ruj/IKkn/ER4caW37G1UJY1Ivbcc1bxiqEjvLshuLbQfxtiUDgJ9lfs6g41zsU5X6kjoYiPxAPF/c/CA649/YqFZy6zSYbgar3yQbBVovvFeblkgU++bphQVX5X5PPg2WLQi8fl3obZp1+wMWddvAkUt8oULkSi6V6VK81k7dyT9r4w896Rz1tpo67bDP1QZDmpk+KzFSERqE+7cfbWwPxSe/KR/h4pMoXmbWs5OhyC+AQTVlXVE5mVBUFc1T5eNjItWFWiLMmAn87tzHwhIsnREaCtw57s3pu0EBsEz+5iFWVFRtwD1iIx16Vh8NMHOeCFa8RzU6dNPxLlfhVoK4zc+/854BKHFhr/BhDBX5k8PB0PnESMTechn5oN2slPZPj60vT/OyBBou9vJxzmRYgaGD+H+51KDkYjI5WOdZOphe0ocUv97Fj22xAYe3tGlbqB7sCILNVuY528shSVv1Xth3dm0tgo2p/w4vTzyj4npqCHzGItiYvRYI3/ba03syce7TL0wXS03bwC3TA7ZktHC4pOQHjht7R7uaEqHvtHlqr8mNnuVFY/bwDUqnkH36mzet7EF9PYvxUg3BR9mZGK+smlYfLOpaZqTapNSWetTa/vQ/DtHOpzKudFU4S5OHwq0c1R7Hvg==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 212be75a-2be3-4a25-d667-08d83dd18024
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5889.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 08:35:28.4060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9UgWmuUVCC+QyvmA3CeyJ0gs1CEt4ssRXfONctNijLxsyEW7hmX1NhDstyH3tR6iRd1URXVrg0iZAyO02bzJEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB5618
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



Dmitry Osipenko 於 8/5/2020 10:01 PM 寫道:
> 05.08.2020 11:24, Chi-Hsien Lin пишет:
>>
>> On 8/5/2020 1:22 AM, Kalle Valo wrote:
>>> Dmitry Osipenko <digetx@gmail.com> writes:
>>>
>>>> 04.08.2020 14:08, Kalle Valo пишет:
>>>>> Dmitry Osipenko <digetx@gmail.com> writes:
>>>>>
>>>>>> 10.06.2020 18:21, Chi-Hsien Lin пишет:
>>>>>>> From: Amar Shankar <amsr@cypress.com>
>>>>>>>
>>>>>>> It is observed that sometimes when sdiod is low in tx credits in low
>>>>>>> rssi scenarios, the data path consumes all sdiod rx all credits and
>>>>>>> there is no sdiod rx credit available for control path causing host
>>>>>>> and card to go out of sync resulting in link loss between host and
>>>>>>> card. So in order to prevent it some credits are reserved for control
>>>>>>> path.
>>>>>>>
>>>>>>> Note that TXCTL_CREDITS can't be larger than the firmware default
>>>>>>> credit update threshold 2; otherwise there will be a deadlock for
>>>>>>> both
>>>>>>> side waiting for each other.
>>>>>>>
>>>>>>> Signed-off-by: Amar Shankar <amsr@cypress.com>
>>>>>>> Signed-off-by: Jia-Shyr Chuang <joseph.chuang@cypress.com>
>>>>>>> Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
>>>>> [...]
>>>>>
>>>>>> This patch causes a severe WiFi performance regression on BCM4329.
>>>>>> Please fix or revert this patch, thanks in advance.
>>>>>>
>>>>>> Before this patch:
>>>>>> - - - - - - - - - - - - - - - - - - - - - - - - -
>>>>>> [ ID] Interval           Transfer     Bitrate         Retr
>>>>>> [  5]   0.00-10.00  sec  17.2 MBytes  14.4 Mbits/sec
>>>>>> 0             sender
>>>>>> [  5]   0.00-10.04  sec  16.9 MBytes  14.1 Mbits/sec
>>>>>> receiver
>>>>>>
>>>>>>
>>>>>> After this patch:
>>>>>> - - - - - - - - - - - - - - - - - - - - - - - - -
>>>>>> [ ID] Interval           Transfer     Bitrate         Retr
>>>>>> [  5]   0.00-10.00  sec  1.05 MBytes   881 Kbits/sec
>>>>>> 3             sender
>>>>>> [  5]   0.00-14.01  sec   959 KBytes   561 Kbits/sec
>>>>>> receiver
>>>>> Can someone please send a revert patch (with the explanation above)
>>>>> if a
>>>>> fix is not quickly found? The commit id is:
>>>>>
>>>>> commit b41c232d33666191a1db11befc0f040fcbe664e9
>>>>> Author:     Amar Shankar <amsr@cypress.com>
>>>>> AuthorDate: Wed Jun 10 10:21:03 2020 -0500
>>>>> Commit:     Kalle Valo <kvalo@codeaurora.org>
>>>>> CommitDate: Tue Jul 14 12:46:43 2020 +0300
>>>>>
>>>>>       brcmfmac: reserve 2 credits for host tx control path
>>>>>
>>>> Hello Kalle,
>>>>
>>>> I'll send the revert if nobody will stand up to address the problem in a
>>>> two weeks, thanks.
>>> Thanks. Then I should be able to get the revert to v5.9 so that the
>>> release won't be broken. (v5.8 is unaffected)
>>
>> Dmitry/Kalle,
>>
>> We'll take a look and revert/fix it in a few days.
> 
> Good to know, thank you.
> 
Hi Dmitry,
We have a fix for this issue. But we got the different test result 
numbers from yours, so would you help us verify the same with
following patch in your setup?
With your confirmation, I can make sure we see the same issue.

---
  drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 9 +++++++--
  1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c 
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index e8712ad3ac45..ea07bb1bfe27 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -664,8 +664,13 @@ static void pkt_align(struct sk_buff *p, int len, 
int align)
  /* To check if there's window offered */
  static bool data_ok(struct brcmf_sdio *bus)
  {
-	/* Reserve TXCTL_CREDITS credits for txctl */
-	return (bus->tx_max - bus->tx_seq) > TXCTL_CREDITS &&
+	u8 tx_rsv = 0;
+
+	/* Reserve TXCTL_CREDITS credits for txctl when it is ready to send */
+	if (bus->ctrl_frame_stat)
+		tx_rsv = TXCTL_CREDITS;
+
+	return (bus->tx_max - bus->tx_seq) > tx_rsv &&
  	       ((bus->tx_max - bus->tx_seq) & 0x80) == 0;
  }

-- 

Here is our 4329 TX throughput result.

Without the fix:
Interval           Transfer     Bandwidth       Retr
0.00-10.00  sec  36.4 MBytes  30.6 Mbits/sec  receiver
With the fix:
Interval           Transfer     Bandwidth       Retr
0.00-10.00  sec  47.9 MBytes  40.2 Mbits/sec  receiver
