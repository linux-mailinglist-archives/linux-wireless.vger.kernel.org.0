Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0F93EF1BC
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Aug 2021 20:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbhHQSWh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Aug 2021 14:22:37 -0400
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:46518
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233049AbhHQSWf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Aug 2021 14:22:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mb/0lR1LhMA+XIT1zDj1ahPbK9d91rilxsmG5oOYwwmGu4mI6MTx8pYmMy6gt3Njp6pLqB8qSdoid908dqOQeH3+v0eFGxSmHzIAYk6XKe0DaQaC/drtADRKHmyMveqF4d9Vu0vr6xfaum0ozNf5CdiQeN6NTUoAC/hZqnLhwcfPlnT3+0ivSaZA4/zxzmn2meRQc4zOIXbTp88q9u6CGDgdcz9D8QAczEIOKdF28KpyZC4d4E529EIh3wUbKyckZKAZgFVgrKmws+w8Hhx3RB5V4wlx+y9umYpcLyTrllXyJ2XhcRQ4qRb59Adv1HARx5H+L7KMYsQO0HMqjZHEBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcN5u8F8h9SMUU3siVtH2rBK2JGJcPjz8t7UGktu4Gw=;
 b=jwgh8/ldF4qzzmkqb2Df+Vqx0j5VkePtu79i64BRabn/1jdXIVgxcxzSdlEwOYaNAhBfI2yF7KS8pFrieZKZtqw8iAOPTbiUIPBm/YzjtTmSzuMy4TYGy+lZC3m2+mPAVdc3yX/imxPiEJq3HoQLIoE1kTK7WX6h/wEWZVvz3diLEvFbd97NnGVDh6nvHX8vdzv47JrkrGfRjDsZVQlngIueBxt0cGppiQ0U0SS85hNZMvblVfPOkmZVl9ufNPY9CiFMy4w6D/ghmjcYlC0cs6utx+DyNFe7xHV2AKolLAQxbaUwrTfm6ONsnr7cGXTODDSo6mcDbiUC5OQ31djKZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcN5u8F8h9SMUU3siVtH2rBK2JGJcPjz8t7UGktu4Gw=;
 b=AgEUwb6qSTVU/kvvlZAgBrOBd/uSC+ETNsRC051qRbXGXlFiDxD1vZf8n6i/k98jEbCrpbOvM/zcNURMQBIxoySk2mKb7GbzKLhfzOBLQ5MhiFn3JaXlhtjlZ28Y0DFZxJ9KbAsbqhhI190Kjm0I4sxKj/adn5kF139N+QA7msE=
Authentication-Results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB8PR03MB6026.eurprd03.prod.outlook.com (2603:10a6:10:38::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Tue, 17 Aug
 2021 18:21:59 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 18:21:59 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH] brcmfmac: Set SDIO workqueue as WQ_HIGHPRI
To:     Arend van Spriel <aspriel@gmail.com>,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
Cc:     Chi-hsien Lin <chi-hsien.lin@cypress.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Tejun Heo <tj@kernel.org>, SHA-cyfmac-dev-list@infineon.com,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        brcm80211-dev-list.pdl@broadcom.com
References: <20210802170904.3116223-1-sean.anderson@seco.com>
 <e6eb89af-b81e-b96e-70a6-c9498eb681fd@seco.com>
 <17b551dc6e0.279b.9696ff82abe5fb6502268bdc3b0467d4@gmail.com>
Message-ID: <c5bba530-1002-a3fa-322a-1045bf7ee4c2@seco.com>
Date:   Tue, 17 Aug 2021 14:21:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <17b551dc6e0.279b.9696ff82abe5fb6502268bdc3b0467d4@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:208:d4::16) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by MN2PR04CA0003.namprd04.prod.outlook.com (2603:10b6:208:d4::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend Transport; Tue, 17 Aug 2021 18:21:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae61133b-7e4c-4c27-8023-08d961abe6ef
X-MS-TrafficTypeDiagnostic: DB8PR03MB6026:
X-Microsoft-Antispam-PRVS: <DB8PR03MB6026C52B578E9B73EF4B929096FE9@DB8PR03MB6026.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 95mdttVl7J4myBWnTOY9pNf36yMvLfPjoCmEeaq1ddNMS9JbomGA8d3XXL6qNQDG8I38w6DTVDXaDnsFzlP4zmg8HFF1t747q62USrnDXAug1RfHkkd3elaxz1zJsrHbRY6Msu4Agvfv6y3W3GwPW3+ml0S7uAFKql8jF63QOL5BeW1DI6O8b4m54tCBXbDorQomLDNQQZgy7q6hUu0Boy6PSYL1PJbEvXHjc8QbsrcYjWPE6qz0L+dYM+vuMOJfWq1mEm4pxkkqOz445++mzOvCve3R66LSDLwHZkmwVNa24MgaVNMPBdEITJiUIVwJZwvmlNXYjtVmoa8x7va8SOP4NCAaICEGe1glKiKPnVZcU23E8U4nZhl4P3KMp+LXTg3I9aKGP8BLLpQm3rq4u6U010F/vqgzDzUmK5Ymgzexb3j4IXmN/rmwv6QmqxTI5FrHS8/O9r8uFS95IbDjzPgEk8j5CRyrkeZLyNngdFxJSe9kCe9xafS3a4KSfFB8GuJ93TMhEbp7bJpOKcbZqzMi3ZI+qHEL0dWdiSTpFcEtynn3B68Bpae1Y/FQoE2edMeRdVJ1vUcek39Y3xZsv3pcN3hbfjiwmBP4IaGCo1xUOnrkQiECqTJmkn0f//4J0zimjx7JZ32VXe58GXGxfcGaY+FuBTsUKsE86gaWzdEt8p/r5j/tG4ySBzcFBdZqkUpR+2v9RU7Kb/Fn2O3eHO41yOtun+Urs+Z5Xu80nyaXJWf1QstT4S0ciXB3YVckBVoGwn8PMJr7yAak4j2yh3xREGD8vXNQpnSBbiKNIfOFu9QP3RNPW66fLHlWSH2WOF+o62e+LhGFRn/smK6u6oIrBqHDRVkBNjOe2RoGm8E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39840400004)(136003)(366004)(346002)(6486002)(4326008)(110136005)(6666004)(86362001)(53546011)(8676002)(186003)(7416002)(8936002)(966005)(38350700002)(66476007)(44832011)(2906002)(54906003)(38100700002)(66556008)(2616005)(956004)(26005)(5660300002)(66946007)(83380400001)(478600001)(31696002)(316002)(31686004)(52116002)(16576012)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODhKUnNjNHJIaTF0TEJNUHo0MmNUeFJDYS9yTTA0L1RUdjltU0duQStkNlBX?=
 =?utf-8?B?a2hoRks5SWFNMDJJTnFjR0FIZlJjVC9IUkN5RFd2UWZBQWJsa0VXL1dCbm9m?=
 =?utf-8?B?VHVGN2pudGdjenpKeFNqdFVicmJJQTFBLzRPenpOeE1tb2RXRGxoTWMxbEU1?=
 =?utf-8?B?ZkkxQlp1cTBIZ2VCNEZiUTUxZHErL001MnNlN2hyUzJGeFFuL3diRHF3WS9K?=
 =?utf-8?B?d01DeHNEZlI1L1NpdXB5ODFtM0dVRnZIaTdXZTZMM3N1NFlvQUtSUWpIaDZF?=
 =?utf-8?B?NmhFanRySnA0S1M5YVVaSEtjYVVlZnZjK2c3ZEI2V2pxZDJiaTJmemxxdHBp?=
 =?utf-8?B?WE1YcXpXaWx2bExVKzJXRnNuSmNPRkRLQ0NFVklDbWo2WWRDeWlIYjN0WGRO?=
 =?utf-8?B?dlJJWkdVTVV6U2xtUXBaVmYxMXpRQlh6cHFTVEE2dkxPMGtoMUpxNjlGRU9T?=
 =?utf-8?B?aDZ4cGhSRHhLL2ZhNGlLU1JMZ2JzZ3l1TWJLVDRScUNSUEtxZXlTcTdnZzFH?=
 =?utf-8?B?NVdycFlRV3RFOVV3bXJDTXFXd1FxcGltak5OZDZpUzBOODZDZ25HOStSM0Fj?=
 =?utf-8?B?WmZsaE5BajVkUnlaRlQrNDRFbWxBSEdaZUxQKzRlT2M0dmxaOFYzNjNQUW9X?=
 =?utf-8?B?UHJTWjJVZjVJL1IwZDVzeUhJRkdoWlJiT05IQmFtNGJNbkRjS1ppeFZsQi90?=
 =?utf-8?B?VzY3SUhaNERqRkJWNDZFa3VNUEs3aFBvN0Jydkh0R1gyMEU1azFrM2ozL2xR?=
 =?utf-8?B?VnJzQzFUME5Ld0JKa3NXYml5cDVLMEZhcjg4VnBYZXBpRFllQ1J2VS8yL0ZT?=
 =?utf-8?B?RFBSMVRONnZGTng5UjlBckdkd0VTbXEvUXVqSjdGQ01XM1ZmaXhZWVNYMnBN?=
 =?utf-8?B?UURMZHlwUGpsb3Yvd1QyT25XSkpEWDFUbm5SYXVSVWlNK21uRnhnT2t0UW9o?=
 =?utf-8?B?cUpuQkFkVGdPUU5LaXhiU0ZCeVJ1RHNiWnZwbVgvL3I3UzVnYmFZdHpSTmZP?=
 =?utf-8?B?UzYxYlRFZW1Rb1hnY2NkWDNueXd2cmNQcXk5emtXZXBOeDYxU2g3UHBjZzV2?=
 =?utf-8?B?Tm9Fem9ZblA5WDA3NXJiOUlmSlZSelVvWjArdCszeWNLTDRTSmk4UDIxTmdT?=
 =?utf-8?B?VEZkc1lkdnl0dFRraFNhS3hTcVE2TmJ1NXNvRUZYT0dBNTJOSmI1WUhYYTZH?=
 =?utf-8?B?aVRSYmJBNm1mREFnTTlsZmVXRmdUcm1NTnY5Qm9vS1J1aHhBa0g1WUtRTkZ1?=
 =?utf-8?B?djJaQXIxeW5EUXU1RHVHMzE4MUw3TE81SkZpaTc5TTRlOFErYmFHU2x6bytQ?=
 =?utf-8?B?QWZmZUNVOThPdUxOUXI1WnhtY3JoWHhlUXdOczgrdXdxSUE1S0o5b25rWkcx?=
 =?utf-8?B?ZXBWNWhsKzA5c0RFZFFRRkdMWHpFeXQzNit4QVB2M3VpckNEWEtxWW9UTFpk?=
 =?utf-8?B?WEZpTlhDcm5IeElCNVdtcG9qaStzZ0ZFc2NtRFFFOXFISWRCamp5cXpLby9u?=
 =?utf-8?B?M3RHSnVOYUVibUppdjFsZW5SVlYxWmR0cmhpWU43SGRnb1FvVk9kbjh1cmRa?=
 =?utf-8?B?Szc3b0NOUEora2M2anlxdms3ak1qeHhtdm1wTjBHcXFWcU8vdTZjdWJxM09W?=
 =?utf-8?B?bnR1UXlLS3hJaUU2K3AxQjMrWTVnTEhVaUJhWXh6SDdGN1hWYzV4emsvcitD?=
 =?utf-8?B?Z3NwT01UeEpiK1JMZzc4dWQzRFBmcjEyNnlZU0x5bFFSNEdSRWQ2OERjb28w?=
 =?utf-8?Q?dE0xdumYRgakz6JXfkRI+stPcoElNj2QIRsRIXU?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae61133b-7e4c-4c27-8023-08d961abe6ef
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 18:21:59.2522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnAB72hdL+blLbj4xdfkEtzs9HGVT4RTE5hOqxtU9Y42rpZLAwDNeKnhzlGGnVQgr+OTvyyPzj1uIjMU+lrBLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6026
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 8/17/21 1:17 PM, Arend van Spriel wrote:
> On August 17, 2021 6:50:50 PM Sean Anderson <sean.anderson@seco.com> wrote:
>
>> ping?
>
> Good idea to ping with a top-level post :-p

Sorry, I'm not subscribed to this list; did I mess up the list/CC for the original?

>
>>
>>
>> On 8/2/21 1:09 PM, Sean Anderson wrote:
>>> This puts tasks submitted to the SDIO workqueue at the head of the queue
>>> and runs them immediately. This gets higher RX throughput with the SDIO
>>> bus.
>>>
>>> This was originally submitted as [1]. The original author Wright Feng
>>> reports
>>>
>>>> throughput result with 43455(11ac) on 1 core 1.6 Ghz platform is
>>>> Without WQ_HIGGPRI TX/RX: 293/301 (mbps)
>>>> With    WQ_HIGHPRI TX/RX: 293/321 (mbps)
>>>
>>> I tested this with a 43364(11bgn) on a 1 core 800 MHz platform and got
>>> Without WQ_HIGHPRI TX/RX: 16/19 (Mbits/sec)
>>> With    WQ_HIGHPRI TX/RX: 24/20 (MBits/sec)
>>>
>>> [1] https://lore.kernel.org/linux-wireless/1584604406-15452-4-git-send-email-wright.feng@cypress.com/
>
> While I understand the obvious gain it seems like a wrong move to me. What if all workqueues in the kernel would start using this flag? I bet the gain above would be negated and all are equal in the eyes of .. the kernel

Is there an official policy on what counts as high-priority? Using some
very-scientific methodology [1], it seems like most high-priority
workqueues are in drivers/net and fs. Making these queues high-priority
seems to be commonplace. For example, in fe101716c7c9 ("rtw88: replace
tx tasklet with work queue"), Po-Hao Huang remarks:

> Since throughput is delay-sensitive in most cases, we allocate a
> dedicated, high priority wq for our needs.

which is effectively the same rationale as this patch. At least for my
application, network transfer speed is one of the most important
performance metrics.

The original patch got the following feedback [2] from Kalle Valo:

> Why would someone want to disable this? Like in patch 2, please avoid
> adding new module parameters as much as possible.

so for this patch I just made the workqueue high-priority
unconditionally.

--Sean

[1] git grep -l WQ_HIGHPRI | cut -f 1,2 -d / | uniq -c | sort -n
[2] https://lore.kernel.org/linux-wireless/87tv2gbgv1.fsf@kamboji.qca.qualcomm.com/
