Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD115B9C7C
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Sep 2022 16:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiIOOCu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Sep 2022 10:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIOOCt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Sep 2022 10:02:49 -0400
Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1429AFA9
        for <linux-wireless@vger.kernel.org>; Thu, 15 Sep 2022 07:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1663250566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VoQ0RP6/QjWkm++iuV/W7wRU8Dv+HxNoBL+vA9AkP9U=;
        b=YuYM7TYb8Af8qmxs3hx8qEaWrd/CzXWvBka1AvtMYOiuud9BAWZgVtx4+G3A3WqKgQCYYm
        +GBfzhyfa/qhBBg6v2kLJ13Q//j9Ivt6EopV0PHoDrpLKK29EK39pO3cMQ18F3ipF5BQRv
        f/yJUwvS3sC7MorGGXFPHFKYUJIQsHg=
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01lp2058.outbound.protection.outlook.com [104.47.21.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-60-ac9gz0IKOqm5Lc_deKwoLA-1; Thu, 15 Sep 2022 15:02:39 +0100
X-MC-Unique: ac9gz0IKOqm5Lc_deKwoLA-1
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:142::9)
 by LO0P123MB6014.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:280::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 14:02:36 +0000
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::1066:dd62:379f:a429]) by CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::1066:dd62:379f:a429%7]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 14:02:36 +0000
Message-ID: <41f23be7-3385-e6cc-9c76-f88b1dd5ebd2@camlingroup.com>
Date:   Thu, 15 Sep 2022 16:02:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] wifi: wfx: fix memory corruption by limiting max_rates to
 4
To:     =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>,
        linux-wireless@vger.kernel.org
CC:     =?UTF-8?Q?Pawe=c5=82_Lenkow?= <pawel.lenkow@camlingroup.com>,
        Kalle Valo <kvalo@kernel.org>,
        Peter Seiderer <ps.report@gmx.net>,
        =?UTF-8?Q?Krzysztof_Drobi=c5=84ski?= 
        <krzysztof.drobinski@camlingroup.com>,
        Johannes Berg <johannes@sipsolutions.net>
References: <20220915131445.30600-1-lech.perczak@camlingroup.com>
 <8115258.T7Z3S40VBb@pc-42>
From:   Lech Perczak <lech.perczak@camlingroup.com>
In-Reply-To: <8115258.T7Z3S40VBb@pc-42>
X-ClientProxiedBy: BE0P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::20) To CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:142::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB5267:EE_|LO0P123MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 7065a99f-6e4c-4030-8826-08da9722f155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: 1WSq77KBXloT+XxSeoJ/PmjpyBHZ4BRdZ5UU+wR7dUK+D1/n/5ZPNNAeB5HiedDXU2j+6lNav5xWyiHsrorX89+gVadvtOLR+75E6GpX3sQbC3k1+ocM+kXO+B03FUI+nVKVrpUbKcRu0ppycV5WZvD0elj3ATs67WZQjPzulMujNnURui771fi0HO08ZMcOcIbaO6NeFWXC2BrzuS8HE8oHS1CQqIcQI8Shp5+OvCDceog4H5ZskPyp5pgZb3SyACTlULIo4b32F+UreipKvDN5U3KmXKc6f6BA7oy3VcqiUJ1xAFY2/H0MEM/vs+9ZhMrAybxFU/vEzFLqOAB6THHuR6gsIyqAVC5+678Zr7fRAuomBpBzsQNpywcSyGDsCgsbNxMUY915uXBufmRDBxNahPj7YHumE9HXxlUU48f3OYM2iPTbBBApgFCHByJT928e6owYsBhjshmLsiKDtzquBilvjulk9aCUARynIVyZdtixFNDJasWUnU5RzVDmZTYL0OXy4OSFgRz/gtFhM4Nsjxk4Skp9StvIqxaITxJwbl7hZycQ2D/v4FhfYEg/6t9K0t3hchbEezBoXKv/I1F2aJ+a+VyD+2I+rf22nRXmnodiT7xSstTzsN2/nHIiNIXrrB5SgXJlpIbyrI/nUSjw9nc8lPvylKb7qOne27RCV4BtbnbTO3a8dDuL4GZv6EumVCmP7mosgcUCDkLMKPWJYSoFu3kWWR/sd1lo74j6tjkZ8ufineevs9CyZ8WnEfazAqz1A+Gt5YAP1FMuayHtGjE/x6CxToGtDCdLUgZgoP0/DK7iTh0by+bKTBF1auOGSnK99uW1Uclq7bRKSIjqCwHgmwZFT7hOxasmg3BO/4E5T3YqzlD9qZamIExtuoD+3RDrQg485w4aB8OBcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(366004)(39850400004)(396003)(451199015)(31686004)(83380400001)(36756003)(86362001)(31696002)(44832011)(66476007)(66556008)(66946007)(2906002)(8936002)(4326008)(38100700002)(8676002)(316002)(54906003)(5660300002)(6486002)(6506007)(6512007)(52116002)(2616005)(66574015)(41300700001)(966005)(478600001)(186003)(45980500001)(43740500002)(18886065003);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FZ6tX2rjzWpkhI4l62sNZ072/V+elqGpWK3/gWjkdc5bETtPj3gYPpH5b0kq?=
 =?us-ascii?Q?sgt4Plf7GP8FiGhl25xpHf2bqzo/7gZ+TPdIfT8GZgEiWMC56maJF1x/C+rQ?=
 =?us-ascii?Q?yPRBDuC9QvFmnM0ZeZZCnKDdi1PZnsdXEqT+jnPM2KbkcGbUuiLOGmrREMo6?=
 =?us-ascii?Q?MPy1Mhz0f/MV6R/QeZVNyZw2w/zvV4qpRgG3WtugVqKU3kdSPvxJTaIzM22W?=
 =?us-ascii?Q?ZOx1AbNHZwZRJLVdBniivtBBDPw/yIv9Q9Puo6Z/flWhvuhBqZbCbu6acnzQ?=
 =?us-ascii?Q?eY8IH6VyVOrQf4rw3fV9vW3uV5gfUgSdQx2zN4XrH5e2Q9O37spCXGX0fhFR?=
 =?us-ascii?Q?yuAgtrvTUE1qXyUbo1b5ogrqyAdDjo9vTuhN1T6OV2Hy3tNPaV42HTa3VdC0?=
 =?us-ascii?Q?a2kiYeZYI/F+YzCS1StZG4q8gNXiJWha1vltJ7FLBENfyAMztrePg93fesGF?=
 =?us-ascii?Q?9hT56p+26ZyazGIM1UAlnJUoIeRW/6i10nuimJFAV5Glg0QHvBZdun2OcbGf?=
 =?us-ascii?Q?8voqkEikuzonPwpk8ZkyoEYk4JIwNohZ8KA4E1r4Qx6CIYxcEH9BiGeHjCqz?=
 =?us-ascii?Q?VzvSU+lsip7XYmumkqA0wgjkP+gyIoD5s0rwW3wJP9wx02H+A79BIYV0j4Ps?=
 =?us-ascii?Q?kQ1+jg1N9AyAK2aK+kSM1I62xk7vlMnpOEsuwXYufqDx3+40FLhGIuZLzGoM?=
 =?us-ascii?Q?IFeNTnTnab924HZIpIkCBdvPNm+IWsmArmnroIPfk32OxCFfv45v7iWwTtJm?=
 =?us-ascii?Q?EvWjMXcmy451x6fF3Fo3H6wtvDk6zOc0Z5KUqeFpaUdrS7bZPNHWkyTnIu9b?=
 =?us-ascii?Q?onRZodQBh7kuz08jFeMw3WLB0IrCYYlPk9CsYdQVafxpeggNIi797Aw5OR+d?=
 =?us-ascii?Q?8cV3qM/4CXHIlNpclKDChiS6GTOYfsIHHaPngJzCXXvvSCnrbdkxEVJYIbZE?=
 =?us-ascii?Q?aVJ3KDynsrc6NOIC6JVuVNnjQrrdPfVExz2jJuFmrYykJ6cy6a20bRKWFOWc?=
 =?us-ascii?Q?EMBUdo/6M8erl2DDZ85n/xJxJAYKyBZ9AdRka+bGeW2IsJT1HoYu7yXirCWr?=
 =?us-ascii?Q?pQrdivAnQVDOyd0wS3741iaREaW510//TaR2mnYE9bmkZZoCMqXQwzq3AT7T?=
 =?us-ascii?Q?mW2o9wu6XSco8lHAVzdAYLKYrQ4HtKWSe13LnL0Ej3CyvjGNdMZFmGZTHxzR?=
 =?us-ascii?Q?/dmS3ZEyEHFMWBBhWXGO2nweGyIc5/hw/yjMmiP6PSBCF9IVr5nJqtGJ38Wx?=
 =?us-ascii?Q?oZsEOcvYhhaV6aL+NfmsqTTqlXuXMwavI5gsJH6/fYLtxTglL/E0bA+mBMzd?=
 =?us-ascii?Q?rfstaPDkpaap1S/Zqfx1sqBhGXVao0g4NRz18tNpM8qBxutx+HAQW6JYX5Hm?=
 =?us-ascii?Q?Oprr+54nOofwGZQGYP+nZyZfxCSBZcPZqATunJ3PKjuDudDHlji5eOzhXhuW?=
 =?us-ascii?Q?6SHZqt+9KEBK4YsofznwrcARhQk13B4qUEK4tjY/x2dXB+f2sSxvgOMwZ7RW?=
 =?us-ascii?Q?ivcKOnX+TbT6/FPT3L8zLTumK2biukNccnl7sJknuCItORTUvNDy8H9tslhO?=
 =?us-ascii?Q?YMCBpkAGp4tCMR8frtPvW4oFvUYgdEDisbad8SWc/iwSYsOIpwwfZCMRzq+M?=
 =?us-ascii?Q?7GDIliXtKIEmkEF9aTHSrWrs1kEuvFruMZSx3gd4gpavSmDwNr1rRjTp2no6?=
 =?us-ascii?Q?gWqZiw=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7065a99f-6e4c-4030-8826-08da9722f155
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 14:02:36.1036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kXs/+tKYp1S9F2j30scqHahh1oPSdXdvJ794GNAVBjsEbBvGuTJA+2i8K4u9vvW6D+cQJgas1+dQ7rUtiDAEFJL8APNKupFkLSp6JnEi/+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6014
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi J=C3=A9r=C3=B4me,

Answers inline.
[Add Krzysztof in Cc:]

W dniu 15.09.2022 o=C2=A015:39, J=C3=A9r=C3=B4me Pouiller pisze:
> [Add Peter in Cc:]
>
> On Thursday 15 September 2022 15:14:45 CEST Lech Perczak wrote:
> > From: Pawe=C5=82 Lenkow <pawel.lenkow@camlingroup.com>
> >
> > During our testing of WFM200 module over SDIO on i.MX6Q-based platform,
> > we discovered a memory corruption on the system, tracing back to the wf=
x
> > driver. Using kfence, it was possible to trace it back to the root
> > cause, which is hw->max_rates set to 8 in wfx_init_common,
> > while the maximum defined by IEEE80211_TX_TABLE_SIZE is 4.
> >
> > This causes array out-of-bounds writes during updates of the rate table=
,
> > as seen below:
> >
> > BUG: KFENCE: memory corruption in kfree_rcu_work+0x320/0x36c
> >
> > Corrupted memory at 0xe0a4ffe0 [ 0x03 0x03 0x03 0x03 0x01 0x00 0x00
> > 0x02 0x02 0x02 0x09 0x00 0x21 0xbb 0xbb 0xbb ] (in kfence-#81):
> > kfree_rcu_work+0x320/0x36c
> > process_one_work+0x3ec/0x920
> > worker_thread+0x60/0x7a4
> > kthread+0x174/0x1b4
> > ret_from_fork+0x14/0x2c
> > 0x0
> >
> > kfence-#81: 0xe0a4ffc0-0xe0a4ffdf, size=3D32, cache=3Dkmalloc-64
> >
> > allocated by task 297 on cpu 0 at 631.039555s:
> > minstrel_ht_update_rates+0x38/0x2b0 [mac80211]
> > rate_control_tx_status+0xb4/0x148 [mac80211]
> > ieee80211_tx_status_ext+0x364/0x1030 [mac80211]
> > ieee80211_tx_status+0xe0/0x118 [mac80211]
> > ieee80211_tasklet_handler+0xb0/0xe0 [mac80211]
> > tasklet_action_common.constprop.0+0x11c/0x148
> > __do_softirq+0x1a4/0x61c
> > irq_exit+0xcc/0x104
> > call_with_stack+0x18/0x20
> > __irq_svc+0x80/0xb0
> > wq_worker_sleeping+0x10/0x100
> > wq_worker_sleeping+0x10/0x100
> > schedule+0x50/0xe0
> > schedule_timeout+0x2e0/0x474
> > wait_for_completion+0xdc/0x1ec
> > mmc_wait_for_req_done+0xc4/0xf8
> > mmc_io_rw_extended+0x3b4/0x4ec
> > sdio_io_rw_ext_helper+0x290/0x384
> > sdio_memcpy_toio+0x30/0x38
> > wfx_sdio_copy_to_io+0x88/0x108 [wfx]
> > wfx_data_write+0x88/0x1f0 [wfx]
> > bh_work+0x1c8/0xcc0 [wfx]
> > process_one_work+0x3ec/0x920
> > worker_thread+0x60/0x7a4
> > kthread+0x174/0x1b4
> > ret_from_fork+0x14/0x2c 0x0
> >
> > Limit hw->max_rates to not exceed IEEE80211_TX_RATE_TABLE_SIZE (4).
> >
> > To bring back previous value, the global table size limit needs to be
> > increased beforehand in mac80211.h, or by limiting the iteration count
> > in minstrel_ht_update_rates against IEEE80211_TX_RATE_TABLE_SIZE as
> > well.
> >
> > Fixes: e16e7f0716a6 ("staging: wfx: instantiate mac80211 data")
>
> I think the issue has been introduced by ee0e16ab756a ("mac80211:
> minstrel_ht: fill all requested rates").
>
>
> > Cc: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
> > Cc: Kalle Valo <kvalo@kernel.org>
> > Link: https://urldefense.com/v3/__https://lore.kernel.org/all/12e5adcd-=
8aed-f0f7-70cc-4fb7b656b829@camlingroup.com/__;!!N30Cs7Jr!ReVaYMRjWoJzG95KR=
grZTGAw0bmt5lnLLpRkt574SRvIoKLD2xl53YKUiLpN4PfXpjSLIQ9KvgVy9Wi4jeJE8axP9M4O=
dgk$ <https://urldefense.com/v3/__https://lore.kernel.org/all/12e5adcd-8aed=
-f0f7-70cc-4fb7b656b829@camlingroup.com/__;!!N30Cs7Jr!ReVaYMRjWoJzG95KRgrZT=
GAw0bmt5lnLLpRkt574SRvIoKLD2xl53YKUiLpN4PfXpjSLIQ9KvgVy9Wi4jeJE8axP9M4Odgk$=
>
> >
> > Signed-off-by: Pawe=C5=82 Lenkow <pawel.lenkow@camlingroup.com>
> > Signed-off-by: Lech Perczak <lech.perczak@camlingroup.com>
> > ---
> > drivers/net/wireless/silabs/wfx/main.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/wireless/silabs/wfx/main.c b/drivers/net/wirel=
ess/silabs/wfx/main.c
> > index 84d82ddded56..7463fe4b5cae 100644
> > --- a/drivers/net/wireless/silabs/wfx/main.c
> > +++ b/drivers/net/wireless/silabs/wfx/main.c
> > @@ -273,7 +273,7 @@ struct wfx_dev *wfx_init_common(struct device *dev,=
 const struct wfx_platform_da
> > hw->vif_data_size =3D sizeof(struct wfx_vif);
> > hw->sta_data_size =3D sizeof(struct wfx_sta_priv);
> > hw->queues =3D 4;
> > - hw->max_rates =3D 8;
> > + hw->max_rates =3D 4;
> > hw->max_rate_tries =3D 8;
> > hw->extra_tx_headroom =3D sizeof(struct wfx_hif_msg) + sizeof(struct wf=
x_hif_req_tx) +
> > 4 /* alignment */ + 8 /* TKIP IV */;
>
> Do you think the fix should rather be:
>
> ------8<----------8<--------
> --- i/net/mac80211/rc80211_minstrel_ht.c
> +++ w/net/mac80211/rc80211_minstrel_ht.c
> @@ -1559,7 +1559,7 @@ minstrel_ht_update_rates(struct minstrel_priv *mp, =
struct minstrel_ht_sta *mi)
> minstrel_ht_set_rate(mp, mi, rates, i++, mi->max_tp_rate[0]);
>
> /* Fill up remaining, keep one entry for max_probe_rate */
> - for (; i < (mp->hw->max_rates - 1); i++)
> + for (; i < min(mp->hw->max_rates, IEEE80211_TX_RATE_TABLE_SIZE) - 1; i+=
+)
> minstrel_ht_set_rate(mp, mi, rates, i, mi->max_tp_rate[i]);
>
> if (i < mp->hw->max_rates)
> ------8<----------8<--------
>
We thought about this as well - or about adding assertion to the function w=
hich does the memory allocation,
but there are more 4-element arrays in mac80211, handled under different de=
fines, which can be confusing.

carl9170 driver has BUILD_BUG_ON to guard from that precisely - see:
https://elixir.bootlin.com/linux/latest/source/drivers/net/wireless/ath/car=
l9170/tx.c#L879
I think, that the second BUILD_BUG_ON could be moved to mac80211 core, so t=
hat it is checked always,
not only when CARL9170 is enabled.

I think both changes should be applied - or, alternatively, in minstrel_ht_=
set_rate, we could use:
BUG_ON(mp->hw->max_rates > IEEE80211_TX_RATE_TABLE_SIZE);
to quickly catch misbehaving drivers in future.

Since this concerns mac80211 core, let's add Johannes to the loop as well.
>
>
> --=20
> J=C3=A9r=C3=B4me Pouiller
>
>
--=20
Pozdrawiam/With kind regards,
Lech Perczak

Sr. Software Engineer
Camlin Technologies Poland Limited Sp. z o.o.
Strzegomska 54,
53-611 Wroclaw
Tel:     (+48) 71 75 000 16
Email:   lech.perczak@camlingroup.com
Website: http://www.camlingroup.com

