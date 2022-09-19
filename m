Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD4F5BD0D7
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Sep 2022 17:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiISP0A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Sep 2022 11:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiISPZh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Sep 2022 11:25:37 -0400
X-Greylist: delayed 367 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 19 Sep 2022 08:25:10 PDT
Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102D210D1
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 08:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1663601108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QbBXbyo89wl9+cEf5DTzIeznN/nvWvVd2+qXfKdL9no=;
        b=QAqTQrr3fMuCtT5st3Y2wEGJQFnuoHbqSPqYq85ojCztSPZUSitlpcWOYWBgwnxXgQWN5E
        UU4YaBCixSJDD4CEtBzgRbP67JPAqo4dFMTJG1iVclgIvYHQkNyZ21hsPzutC8W5NixDmq
        Mk+EtdjCPcyjlZAMaxLsidwdGcJHqok=
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01lp2055.outbound.protection.outlook.com [104.47.21.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-209-Dxp44X7UMoiprr_Ymt17nQ-1; Mon, 19 Sep 2022 16:17:50 +0100
X-MC-Unique: Dxp44X7UMoiprr_Ymt17nQ-1
Received: from CWXP123MB4486.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:fa::9) by
 LO0P123MB7007.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:335::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.16; Mon, 19 Sep 2022 15:17:48 +0000
Received: from CWXP123MB4486.GBRP123.PROD.OUTLOOK.COM
 ([fe80::a837:10db:7103:8461]) by CWXP123MB4486.GBRP123.PROD.OUTLOOK.COM
 ([fe80::a837:10db:7103:8461%6]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 15:17:48 +0000
Message-ID: <c6957e1a-2ead-fd3c-c31b-3e6561a72787@camlingroup.com>
Date:   Mon, 19 Sep 2022 17:17:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] wifi: wfx: fix memory corruption by limiting max_rates to
 4
To:     Peter Seiderer <ps.report@gmx.net>,
        Lech Perczak <lech.perczak@camlingroup.com>
CC:     =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        =?UTF-8?Q?Krzysztof_Drobi=c5=84ski?= 
        <krzysztof.drobinski@camlingroup.com>,
        Johannes Berg <johannes@sipsolutions.net>
References: <20220915131445.30600-1-lech.perczak@camlingroup.com>
 <8115258.T7Z3S40VBb@pc-42>
 <41f23be7-3385-e6cc-9c76-f88b1dd5ebd2@camlingroup.com>
 <20220915202157.6fff5ef8@gmx.net>
From:   Pawel Lenkow <pawel.lenkow@camlingroup.com>
In-Reply-To: <20220915202157.6fff5ef8@gmx.net>
X-ClientProxiedBy: LO2P265CA0479.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::35) To CWXP123MB4486.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:fa::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB4486:EE_|LO0P123MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: 35b72117-592a-4b2c-1354-08da9a521cc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: nCyRc0IFNg4hZ1VTI00WAwFoU2lwkB3Ydey5GdSGX9eHE0gY6IL3dmA2k/BS8MFrt72FLv7ZmMKODKBPsVR1nV+SWiwaXL1UxakpR5uwic8rZ7A8kB7YJGKZ2CV9R55+sVHbackLLnNUAqMji/Q2tmLbMTf7iWlKlPmj+qtXgHrNGdLq+CUfcmn6kowg+0TxiIxrzXzFWzqcbeG1EpMKK5cpxXXww+tmht6zLH2ZVpQMWE6MDIYs/fnJ/p4BE7ntUQFsOE2K4Zu+T1dMiG/hynlkqJKVcOYHVVPiUIL90vN9kST3/O+VXCTJH0tcws7SdH4UTSJB3xu4JwqOMSNYyhXxmCyj29Fttq9+eelAk/xMNKqOJdWXVi5WKyq3GMSVi0xBivJPlPYLF8H6K2qyGRlr1wso4BRBGyAvxaJfCCIjgDoep3gj8g+ndC48pHpGj3vRAfSNvrmFFUwGwDNHd+dTHsP39MWsFCBTlmDsHODG2Qp/Fs36pWAed0VW3mfgjYLFMZg2U9oRn9b2I1UHTqdp6Pmumrh20KcNn9jPmr9BuQ4DDp5iu9ENnOTvKIl853IUa04fiFHcR53rXmeJM22GPkO0NVBXtlwe8iuCUFshqiEmI71QpvYyGTI1RvykfwzeB1j8xR5kkfkViJl8jgbIuQiM8swocHmBi8IluCS4tb2bIXD4naxcw1XFQ+Nm7+jnDT0AszXOi8soYVh9cZNVDN1pKQK9knjhDdHioQ/k7R0bOS7fjMXkYLi6CVjbJ7Y6UUlGf7bPm66tyzLQJPjCBbjO4AETSTvPpudNWQQBfXeQtWxaObKlxKsoYWforODtWOSQkUnLgesBHlXM7mLAZdsGYTzyZu869m0y5IKLAZOoPZ7TIsZP9F5iA402kqheOu8t6KIk0w8hQXZyKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP123MB4486.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(396003)(376002)(346002)(39850400004)(451199015)(6506007)(4326008)(66556008)(54906003)(31696002)(6636002)(478600001)(41300700001)(83380400001)(53546011)(966005)(2906002)(5660300002)(66946007)(38100700002)(31686004)(86362001)(110136005)(66476007)(38350700002)(66574015)(6512007)(186003)(26005)(8676002)(52116002)(44832011)(316002)(36756003)(2616005)(6486002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hvvt/bnZMBnxXa20z/QPsFF98WaC77YoUL18dbz4pgOW4BarxvhE+t8mRPQT?=
 =?us-ascii?Q?Q/YHSemEla7Yf+RtKnzMLrKU7qIuUumwoJ3GqrqAVgn0CBbTNBcMNGKB8Yo+?=
 =?us-ascii?Q?AMdpjx8rzWwR2+9AOpvCZU9/5R8igcTebyI+k9YqcSRToazMW63QS2Jg3iHn?=
 =?us-ascii?Q?drSOloGbY+SxxE7DV2GoIn2arvmvyDccf5nVQ+Mg2CIV/wg8U0bfsd9SA+WP?=
 =?us-ascii?Q?B5TyoN/uoFocOIl6gnFr0PbCUnymUFKdPBqT/FxKO0Z+sh3OoRm0eS9Ug4Uq?=
 =?us-ascii?Q?qOj9zl+JMoyIUsXzp3kUrRd2RJWvwh7RIgjoiqnDprAiOy2hXd3Yn0tvPFSV?=
 =?us-ascii?Q?nbWuOqEW7O+lwuqBmWFjiEx9A6fQAV+L3arNyYrQvPrAcc9fAIuPSaQQM7mJ?=
 =?us-ascii?Q?GHv7AMWApG5W11arm3oOx/3Sju1bymcTlxRTQbQlGyU0pVHD1eb7QvQYEd+A?=
 =?us-ascii?Q?yD6FlN0fmRWRkYePJ7K9HVigs9Zu0S2VMN4RKt/vdruEmhouSYyfWzXGOzDZ?=
 =?us-ascii?Q?dBejZlSn76L9JACVHke//kbEv/+iMd42KOjzjw24qML678qNe3oSieQFgaF/?=
 =?us-ascii?Q?PDXhchukCJQ4DfSZNGlF+7VnMyXW12XgWbMjMbVTAlpxA9M3CKjZni4NcDnT?=
 =?us-ascii?Q?8scSCZmIpBkvTHtw74vpqZiWaj9+0eZZ/NaNivBH1wATsBiXeJAQn2gEcozX?=
 =?us-ascii?Q?koPHUQe+i/NxC2fZxir+fO1PB6/bXpkGpOsQQm34XEuGcT0YxRZ0FHhCuFcG?=
 =?us-ascii?Q?/clXF52q8dQOYx3wI9H6hljqLZCVj94yru86KsW1q1HcuBrZI8RKU0CC6wmE?=
 =?us-ascii?Q?r2UrgSKrkYwd8klC5VEy5lk5m51X3dY6rBr5A31nHlR6B2pVoOkoOrZvyq1+?=
 =?us-ascii?Q?Z8GzZzDpWiSkaZieyBK2jLNdpwhCi3N5+0GfSwlQimsBFBrz0mZ3mwGaFya2?=
 =?us-ascii?Q?uEycLrgBi6tLqSfEaeG0ZzJ7HAQHEQRBW/gLtwI3+OhDWuurrmaOSWRfI2t5?=
 =?us-ascii?Q?abzh8xhYtl+ZaXOwxeQc1eeRifnc2z9lo6C6ks66P6gb6An5BRWq/89YkVF2?=
 =?us-ascii?Q?EsAv9G8baDv9MvpYkwWnQQg0r1gw41jTNyfF3iv0ezHCwNVqfPUobuslaq/1?=
 =?us-ascii?Q?5gpSx1dywyuNZhzvEMLh8kBaEhd7PPHsfAlmBu8aLdWNJK8XsgHqk85yGNy4?=
 =?us-ascii?Q?7tdeEXdCxX7AumO+m1SvG4bAAy1jWYYylktb0NBnt3A7LP/h7mPeeWzMlMc0?=
 =?us-ascii?Q?dTUcoChOX0/ESXF8mbJTMZjjIaGOPwf7jBQj8Hnnx4KSjxAqELL3i4PalwKP?=
 =?us-ascii?Q?wFD+uReu8P5ewKJGHrfbuFulrTKLvvBKCDpObC9I8Thynvx6iw1Napim97s9?=
 =?us-ascii?Q?ailrlOGj+TYzOhyyteKZb3ftCS3koly84pwgQV9qJQAkYtFGBnF24jqfDWDO?=
 =?us-ascii?Q?ykvzdEGc9kGDiPAOypRft0ErjP71a2YGjD6b6XYsjAqT5HoXmKX+lrXrldnQ?=
 =?us-ascii?Q?wAMMrRwDbTUYN+9tVJxxCvEV0GXfVT0PtBWJF2sPD+qA72sy1GgfB/MUkgcD?=
 =?us-ascii?Q?Mt59AOsn8j9IBOZn5X9ozEGDAZfvFlXRAoeh3ZjrihqOPqY50eizVKLGgLFz?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b72117-592a-4b2c-1354-08da9a521cc5
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB4486.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 15:17:48.7801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PRapAVOX53+9NQD4Ljn0IFz2i7zsoEeRYVyYxgeQQ8pSEMC0lLndid/sSPReDXtXjQKSJPi1vjINJLpvS2aBYmaCMjJVYByDDxdlkTngDTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB7007
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi!

Thank you for your suggestions and comments.=20

We have submitted new patch here:

https://patchwork.kernel.org/project/linux-wireless/patch/20220919150135.90=
785-1-lech.perczak@camlingroup.com/


On 15.09.2022 20:21, Peter Seiderer wrote:
> Hello *,
>=20
> On Thu, 15 Sep 2022 16:02:34 +0200, Lech Perczak <lech.perczak@camlingrou=
p.com> wrote:
>=20
>> Hi J=C3=A9r=C3=B4me,
>>
>> Answers inline.
>> [Add Krzysztof in Cc:]
>>
>> W dniu 15.09.2022 o 15:39, J=C3=A9r=C3=B4me Pouiller pisze:
>>> [Add Peter in Cc:]
>>>
>>> On Thursday 15 September 2022 15:14:45 CEST Lech Perczak wrote:
>>>> From: Pawe=C5=82 Lenkow <pawel.lenkow@camlingroup.com>
>>>>
>>>> During our testing of WFM200 module over SDIO on i.MX6Q-based platform=
,
>>>> we discovered a memory corruption on the system, tracing back to the w=
fx
>>>> driver. Using kfence, it was possible to trace it back to the root
>>>> cause, which is hw->max_rates set to 8 in wfx_init_common,
>>>> while the maximum defined by IEEE80211_TX_TABLE_SIZE is 4.
>>>>
>>>> This causes array out-of-bounds writes during updates of the rate tabl=
e,
>>>> as seen below:
>>>>
>>>> BUG: KFENCE: memory corruption in kfree_rcu_work+0x320/0x36c
>>>>
>>>> Corrupted memory at 0xe0a4ffe0 [ 0x03 0x03 0x03 0x03 0x01 0x00 0x00
>>>> 0x02 0x02 0x02 0x09 0x00 0x21 0xbb 0xbb 0xbb ] (in kfence-#81):
>>>> kfree_rcu_work+0x320/0x36c
>>>> process_one_work+0x3ec/0x920
>>>> worker_thread+0x60/0x7a4
>>>> kthread+0x174/0x1b4
>>>> ret_from_fork+0x14/0x2c
>>>> 0x0
>>>>
>>>> kfence-#81: 0xe0a4ffc0-0xe0a4ffdf, size=3D32, cache=3Dkmalloc-64
>>>>
>>>> allocated by task 297 on cpu 0 at 631.039555s:
>>>> minstrel_ht_update_rates+0x38/0x2b0 [mac80211]
>>>> rate_control_tx_status+0xb4/0x148 [mac80211]
>>>> ieee80211_tx_status_ext+0x364/0x1030 [mac80211]
>>>> ieee80211_tx_status+0xe0/0x118 [mac80211]
>>>> ieee80211_tasklet_handler+0xb0/0xe0 [mac80211]
>>>> tasklet_action_common.constprop.0+0x11c/0x148
>>>> __do_softirq+0x1a4/0x61c
>>>> irq_exit+0xcc/0x104
>>>> call_with_stack+0x18/0x20
>>>> __irq_svc+0x80/0xb0
>>>> wq_worker_sleeping+0x10/0x100
>>>> wq_worker_sleeping+0x10/0x100
>>>> schedule+0x50/0xe0
>>>> schedule_timeout+0x2e0/0x474
>>>> wait_for_completion+0xdc/0x1ec
>>>> mmc_wait_for_req_done+0xc4/0xf8
>>>> mmc_io_rw_extended+0x3b4/0x4ec
>>>> sdio_io_rw_ext_helper+0x290/0x384
>>>> sdio_memcpy_toio+0x30/0x38
>>>> wfx_sdio_copy_to_io+0x88/0x108 [wfx]
>>>> wfx_data_write+0x88/0x1f0 [wfx]
>>>> bh_work+0x1c8/0xcc0 [wfx]
>>>> process_one_work+0x3ec/0x920
>>>> worker_thread+0x60/0x7a4
>>>> kthread+0x174/0x1b4
>>>> ret_from_fork+0x14/0x2c 0x0
>>>>
>>>> Limit hw->max_rates to not exceed IEEE80211_TX_RATE_TABLE_SIZE (4).
>>>>
>>>> To bring back previous value, the global table size limit needs to be
>>>> increased beforehand in mac80211.h, or by limiting the iteration count
>>>> in minstrel_ht_update_rates against IEEE80211_TX_RATE_TABLE_SIZE as
>>>> well.
>>>>
>>>> Fixes: e16e7f0716a6 ("staging: wfx: instantiate mac80211 data")
>>>
>>> I think the issue has been introduced by ee0e16ab756a ("mac80211:
>>> minstrel_ht: fill all requested rates").
>=20
> Ups, sorry for creating a regression (and many thanks for investigation).=
..
>=20
>>>
>>>
>>>> Cc: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
>>>> Cc: Kalle Valo <kvalo@kernel.org>
>>>> Link: https://urldefense.com/v3/__https://lore.kernel.org/all/12e5adcd=
-8aed-f0f7-70cc-4fb7b656b829@camlingroup.com/__;!!N30Cs7Jr!ReVaYMRjWoJzG95K=
RgrZTGAw0bmt5lnLLpRkt574SRvIoKLD2xl53YKUiLpN4PfXpjSLIQ9KvgVy9Wi4jeJE8axP9M4=
Odgk$<https://urldefense.com/v3/__https://lore.kernel.org/all/12e5adcd-8aed=
-f0f7-70cc-4fb7b656b829@camlingroup.com/__;!!N30Cs7Jr!ReVaYMRjWoJzG95KRgrZT=
GAw0bmt5lnLLpRkt574SRvIoKLD2xl53YKUiLpN4PfXpjSLIQ9KvgVy9Wi4jeJE8axP9M4Odgk$=
> <https://urldefense.com/v3/__https://lore.kernel.org/all/12e5adcd-8aed-f0=
f7-70cc-4fb7b656b829@camlingroup.com/__;!!N30Cs7Jr!ReVaYMRjWoJzG95KRgrZTGAw=
0bmt5lnLLpRkt574SRvIoKLD2xl53YKUiLpN4PfXpjSLIQ9KvgVy9Wi4jeJE8axP9M4Odgk$<ht=
tps://urldefense.com/v3/__https://lore.kernel.org/all/12e5adcd-8aed-f0f7-70=
cc-4fb7b656b829@camlingroup.com/__;!!N30Cs7Jr!ReVaYMRjWoJzG95KRgrZTGAw0bmt5=
lnLLpRkt574SRvIoKLD2xl53YKUiLpN4PfXpjSLIQ9KvgVy9Wi4jeJE8axP9M4Odgk$>>
>>>>
>>>> Signed-off-by: Pawe=C5=82 Lenkow <pawel.lenkow@camlingroup.com>
>>>> Signed-off-by: Lech Perczak <lech.perczak@camlingroup.com>
>>>> ---
>>>> drivers/net/wireless/silabs/wfx/main.c | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/wireless/silabs/wfx/main.c b/drivers/net/wire=
less/silabs/wfx/main.c
>>>> index 84d82ddded56..7463fe4b5cae 100644
>>>> --- a/drivers/net/wireless/silabs/wfx/main.c
>>>> +++ b/drivers/net/wireless/silabs/wfx/main.c
>>>> @@ -273,7 +273,7 @@ struct wfx_dev *wfx_init_common(struct device *dev=
, const struct wfx_platform_da
>>>> hw->vif_data_size =3D sizeof(struct wfx_vif);
>>>> hw->sta_data_size =3D sizeof(struct wfx_sta_priv);
>>>> hw->queues =3D 4;
>>>> - hw->max_rates =3D 8;
>>>> + hw->max_rates =3D 4;
>=20
> Quick grep for max_rates did show the same for:
>=20
> drivers/net/wireless/st/cw1200/main.c: hw->max_rates =3D 8;
>=20
>>>> hw->max_rate_tries =3D 8;
>>>> hw->extra_tx_headroom =3D sizeof(struct wfx_hif_msg) + sizeof(struct w=
fx_hif_req_tx) +
>>>> 4 /* alignment */ + 8 /* TKIP IV */;
>>>
>=20
> Think the following suggested fix is the right way to go (and keep hw->ma=
x_rates
> value according to the hardware capabilities(?) of the wifi device)...
>=20
>>> Do you think the fix should rather be:
>>>
>>> ------8<----------8<--------
>>> --- i/net/mac80211/rc80211_minstrel_ht.c
>>> +++ w/net/mac80211/rc80211_minstrel_ht.c
>>> @@ -1559,7 +1559,7 @@ minstrel_ht_update_rates(struct minstrel_priv *mp=
, struct minstrel_ht_sta *mi)
>>> minstrel_ht_set_rate(mp, mi, rates, i++, mi->max_tp_rate[0]);
>>>
>>> /* Fill up remaining, keep one entry for max_probe_rate */
>>> - for (; i < (mp->hw->max_rates - 1); i++)
>>> + for (; i < min(mp->hw->max_rates, IEEE80211_TX_RATE_TABLE_SIZE) - 1; =
i++)
>>> minstrel_ht_set_rate(mp, mi, rates, i, mi->max_tp_rate[i]);
>>>
>=20
> Same change needed here:
>=20
>>> if (i < mp->hw->max_rates)
>=20
> if (i < min(mp->hw->max_rates, IEEE80211_TX_RATE_TABLE_SIZE))
>=20
>>> ------8<----------8<--------
>>>
>> We thought about this as well - or about adding assertion to the functio=
n which does the memory allocation,
>> but there are more 4-element arrays in mac80211, handled under different=
 defines, which can be confusing.
>>
>> carl9170 driver has BUILD_BUG_ON to guard from that precisely - see:
>> https://elixir.bootlin.com/linux/latest/source/drivers/net/wireless/ath/=
carl9170/tx.c#L879<https://elixir.bootlin.com/linux/latest/source/drivers/n=
et/wireless/ath/carl9170/tx.c#L879>
>> I think, that the second BUILD_BUG_ON could be moved to mac80211 core, s=
o that it is checked always,
>> not only when CARL9170 is enabled.
>>
>> I think both changes should be applied - or, alternatively, in minstrel_=
ht_set_rate, we could use:
>> BUG_ON(mp->hw->max_rates > IEEE80211_TX_RATE_TABLE_SIZE);
>> to quickly catch misbehaving drivers in future.
>=20
> Think with the suggested changes to minstrel_ht_set_rate no further asser=
tion
> is needed...
>=20
> Regards,
> Peter
>=20
>>
>> Since this concerns mac80211 core, let's add Johannes to the loop as wel=
l.
>>>
>>>
>>> --
>>> J=C3=A9r=C3=B4me Pouiller
>>>
>>>
> ___
> This email originated from outside of Camlin Group. Do not click on links=
 or open attachments unless you are confident they are secure. If in doubt,=
 please raise a security incident via the following portal: Camlin Helpdesk=
 =E2=80=93 Report an Information Security Incident/Non-Conformance <https:/=
/camlin-helpdesk.atlassian.net/servicedesk/customer/portal/2/group/34/creat=
e/62>
>=20

