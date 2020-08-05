Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3435B23C7B0
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Aug 2020 10:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgHEIYZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Aug 2020 04:24:25 -0400
Received: from mail-eopbgr690109.outbound.protection.outlook.com ([40.107.69.109]:20878
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725809AbgHEIYW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Aug 2020 04:24:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGeeXov8Q5e+nSeoObn624lSqYVsJ9Cayyp3G4dYX3bl/t+EHDpk5S7gXVZVRNQPZiUuVUV45wwaQSDMSixSk/lZ75hGcc63DtbtkhIEmCfrkdGTUwO7DSeXqLS9dCkl6Ntw2er6Z+VuMjWjyDj/SUX+yBcVw7Rv7d7Z1O11pai8bhvqUg/3kBqiExl5pGvMgAlTCwsB3rvJNmTkQGNOIzFCX85H3z3NUp0ytuJRqW5f9wqOS4yXUCjtnIerbojvf7o4QJh5nSUzmH2z7uD/BLbZt0FXp/rQyQglfDfbzAbTym7ulLIykk2HzwkqvBbvGu/ZzlRJAfJSKlcuR6YqAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OUAOc0BXkK6IzShTCFvT1f3frmVGm8y+xF+U53ev+8=;
 b=JYFpCE2GgDzdhJNZN6UqTT0pXZ6EabJHyuNdgSdaCFi6O0SN6IM0/EuAOUdjq/AbnccvtW1HRrEkuznm9IxQhjKqRG2HmLC7QowikXmQCsaI78JcWzqOI3sI563tonA6wkiqf+f8EyobLfAtAs9A9I+VYjCw2vi8hUVCGKrmrgEp6u2SjskvHsUueNEytc1WHbv1JqVaSJm6lQ1aqkQdJUL5GKaSdTdjAUfCbSa6bU9i1gvzr6aqOjP5FD+3+Fzqhnc9gUQTmaGwNkRESE+8gijaQM3JXKK+UUyZFZIph1/vCYzL3jVV4NdafkBkxnZ0+oixqIAk2cW8B/Q6DGcM2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OUAOc0BXkK6IzShTCFvT1f3frmVGm8y+xF+U53ev+8=;
 b=HZxNogwq9ikdPT8/WigtbsMKfLne291vUi9lOG7SNQ2KLqoTuKql6rgKdikheEQm9aZc0SfjT+BH/9/pAkLBHUnEsKZvQV16KkIPrgx+2R3JXAO4G+3Azn8BoEzqR2Wd4UOQH+cK+hPbLRtKg2LeGwbBZAW6Y/XNo4oW0/DORFk=
Authentication-Results: cypress.com; dkim=none (message not signed)
 header.d=none;cypress.com; dmarc=none action=none header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB4550.namprd06.prod.outlook.com (2603:10b6:a03:4b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Wed, 5 Aug
 2020 08:24:17 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::51af:1a1b:a341:3dc8]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::51af:1a1b:a341:3dc8%5]) with mapi id 15.20.3239.022; Wed, 5 Aug 2020
 08:24:17 +0000
Subject: Re: [PATCH V2 3/6] brcmfmac: reserve 2 credits for host tx control
 path
To:     Kalle Valo <kvalo@codeaurora.org>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Amar Shankar <amsr@cypress.com>,
        Jia-Shyr Chuang <joseph.chuang@cypress.com>
References: <20200610152106.175257-1-chi-hsien.lin@cypress.com>
 <20200610152106.175257-4-chi-hsien.lin@cypress.com>
 <f0910f96-1d23-daf1-b517-363e59bff105@gmail.com>
 <875z9yr7lg.fsf@codeaurora.org>
 <ffcf55cc-b27d-78ec-ff4f-e7efa3087712@gmail.com>
 <87a6zapbqp.fsf@codeaurora.org>
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Message-ID: <0923f45f-03e3-a870-3d2a-35f982482e1a@cypress.com>
Date:   Wed, 5 Aug 2020 16:24:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <87a6zapbqp.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: TYCPR01CA0001.jpnprd01.prod.outlook.com (2603:1096:405::13)
 To BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.5.4] (122.116.94.118) by TYCPR01CA0001.jpnprd01.prod.outlook.com (2603:1096:405::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend Transport; Wed, 5 Aug 2020 08:24:15 +0000
X-Originating-IP: [122.116.94.118]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b9890787-1f4a-48a8-b83f-08d83918f198
X-MS-TrafficTypeDiagnostic: BYAPR06MB4550:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB455038AE83A728FBE85E4233BB4B0@BYAPR06MB4550.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ifXAejOJl6tzphGwBAfnY37LwMuKvGUMFoA7Updr+8yEnLoUIzzeWjcYlS0afEwQCq3BVHMuTb4R5ccNAxLf6c2jNfJP/vhVFfFETaSOnRMg4T/DnsWFutXyiVX7PFppNuzXc2k3X6iIOJYFmHVHAMbDusb29V82Jh46fPNOI4X4P8M3UFEhGUkz44EIDeRCR0bX6ULYIWBYk86a0kurvzmNHQEmoqTpJemRBarrPFyUunifEo4YLnTmYyFAy4r9FcyHzfOMGfIJOInKLDjELk8ShlbAfy5U/yvZHMwHG3mNn2cmHKYN8gKIK9lvflv9++4xYdqUjX+sWp4x7rshFK2NHe8o1M91W8mq1FOgPNVbF5w9UO/OiqBwyJTQS7fG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(956004)(8936002)(110136005)(54906003)(316002)(31686004)(5660300002)(8676002)(16576012)(2906002)(36756003)(66946007)(52116002)(66476007)(2616005)(53546011)(66556008)(83380400001)(186003)(16526019)(6486002)(6666004)(86362001)(26005)(31696002)(107886003)(4326008)(478600001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: fSlD8slcZ8blehwPJ4TPNNJVOIfBKgJTBDP/nB4dtiDlBK6QiO14ItS9zKQYt703xgH734y0+MJBlNeRmqauWuvfTKz7QP2A+irbFSr3Stp67jf2i164SzgcOaVMa+U2cprqxhWZiNSmK/k4RKJXxiJtkdgeE2JgnOXtB8ssFTiw9iizGeJ1SnYlW1OqwEWaB93y5Pxe7FKNXSxWJC6trSRW66KtMxTvUWIBCwnDa0UEeOUASbNvwzLsG+cVZra9cY2XZbujqifKsRWJn1rf5ayxQaYSHfRn2+0+Axha78wVjGCIKQgtIjZaP1zZbOgFax7/KUc/h3XGsWVeVoBQIOn5XGY3g3oOIoKmFo+Zueh3g9NrRiZVlGAXVHKjI89QZrNOvpM7tvAX5sJ24XVTi9u7sO8x6pCqPF+FJHq1nz/xajgQ9JFed+4ku8BRldHBCd9fLtf95RM9tP8ocwk1eIkcM9+tf7N7kQqva3DA6PdBv40VpnqVRp8IiEkWLBR8D+Cm3Q45wTSmb5lvw+ltjlaHiOPgqAY6P1+ZnSubPqtfOmZ+HCSJBBsELynTo3f852u4f6CSQChxlFQacl+Gb1TC15Qi/xDecpJzypvVZRdfT7K5FhEvVzTl+mezSo0aeDl1ynCqprNQ3DeFac0fEQ==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9890787-1f4a-48a8-b83f-08d83918f198
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB4901.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 08:24:17.1959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5vd+z9Xu/hdONBqkfaz60GYsZpwgsWUGXUOU2+OO/4B3rcSq1OW+rZSh9OERasjAQ5adjNuoleaqFdjQ1N6hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB4550
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 8/5/2020 1:22 AM, Kalle Valo wrote:
> Dmitry Osipenko <digetx@gmail.com> writes:
>
>> 04.08.2020 14:08, Kalle Valo пишет:
>>> Dmitry Osipenko <digetx@gmail.com> writes:
>>>
>>>> 10.06.2020 18:21, Chi-Hsien Lin пишет:
>>>>> From: Amar Shankar <amsr@cypress.com>
>>>>>
>>>>> It is observed that sometimes when sdiod is low in tx credits in low
>>>>> rssi scenarios, the data path consumes all sdiod rx all credits and
>>>>> there is no sdiod rx credit available for control path causing host
>>>>> and card to go out of sync resulting in link loss between host and
>>>>> card. So in order to prevent it some credits are reserved for control
>>>>> path.
>>>>>
>>>>> Note that TXCTL_CREDITS can't be larger than the firmware default
>>>>> credit update threshold 2; otherwise there will be a deadlock for both
>>>>> side waiting for each other.
>>>>>
>>>>> Signed-off-by: Amar Shankar <amsr@cypress.com>
>>>>> Signed-off-by: Jia-Shyr Chuang <joseph.chuang@cypress.com>
>>>>> Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
>>> [...]
>>>
>>>> This patch causes a severe WiFi performance regression on BCM4329.
>>>> Please fix or revert this patch, thanks in advance.
>>>>
>>>> Before this patch:
>>>> - - - - - - - - - - - - - - - - - - - - - - - - -
>>>> [ ID] Interval           Transfer     Bitrate         Retr
>>>> [  5]   0.00-10.00  sec  17.2 MBytes  14.4 Mbits/sec    0             sender
>>>> [  5]   0.00-10.04  sec  16.9 MBytes  14.1 Mbits/sec
>>>> receiver
>>>>
>>>>
>>>> After this patch:
>>>> - - - - - - - - - - - - - - - - - - - - - - - - -
>>>> [ ID] Interval           Transfer     Bitrate         Retr
>>>> [  5]   0.00-10.00  sec  1.05 MBytes   881 Kbits/sec    3             sender
>>>> [  5]   0.00-14.01  sec   959 KBytes   561 Kbits/sec
>>>> receiver
>>> Can someone please send a revert patch (with the explanation above) if a
>>> fix is not quickly found? The commit id is:
>>>
>>> commit b41c232d33666191a1db11befc0f040fcbe664e9
>>> Author:     Amar Shankar <amsr@cypress.com>
>>> AuthorDate: Wed Jun 10 10:21:03 2020 -0500
>>> Commit:     Kalle Valo <kvalo@codeaurora.org>
>>> CommitDate: Tue Jul 14 12:46:43 2020 +0300
>>>
>>>      brcmfmac: reserve 2 credits for host tx control path
>>>
>> Hello Kalle,
>>
>> I'll send the revert if nobody will stand up to address the problem in a
>> two weeks, thanks.
> Thanks. Then I should be able to get the revert to v5.9 so that the
> release won't be broken. (v5.8 is unaffected)

Dmitry/Kalle,

We'll take a look and revert/fix it in a few days.


