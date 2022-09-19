Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A1E5BD538
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Sep 2022 21:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiISTbl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Sep 2022 15:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiISTbc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Sep 2022 15:31:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1168244547
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 12:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663615879;
        bh=jLKXGnY6r2XDz83UW21cZMOh/eZtnntA2qorz5KCvsg=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=k47FGwPg4qomsJ76A5vcGOcGBxwXoNV9ipK1UR+R1WLt7kjXQNYDxpIYC6F7SfkB0
         9BzMYGYAgthACSO7axiHG8AxaQGGnEQ3BncrLfKJz7djcP4wgJdAAKCJ2fIOYfEOSy
         VZu2n/rPV9tB2WpHcE/rYGG8TcD1DdO1zpug2g7s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost ([62.216.209.45]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgNh1-1pDZai0viJ-00huTB; Mon, 19
 Sep 2022 21:31:19 +0200
Date:   Mon, 19 Sep 2022 21:31:17 +0200
From:   Peter Seiderer <ps.report@gmx.net>
To:     Lech Perczak <lech.perczak@camlingroup.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        =?UTF-8?B?UGF3ZcWC?= Lenkow <pawel.lenkow@camlingroup.com>,
        =?UTF-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>,
        Kalle Valo <kvalo@kernel.org>,
        Krzysztof =?UTF-8?B?RHJvYmnFhHNraQ==?= 
        <krzysztof.drobinski@camlingroup.com>
Subject: Re: [PATCH] mac80211: fix memory corruption in
 minstrel_ht_update_rates()
Message-ID: <20220919213117.3de74e3c@gmx.net>
In-Reply-To: <20220919150135.90785-1-lech.perczak@camlingroup.com>
References: <20220919150135.90785-1-lech.perczak@camlingroup.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iPKbTgaxu7cH18hqhION6YmQwOM6G36FVDOcHjIs9u20agZ7l08
 tgKNbZaaZhtWiQCDpaMt3FVJPCUCTngF1kpbAIr8dFMnhxSOV7XzYeZMbFI62E2klq5QhE0
 d+PQ/Q6v344cGxiaoagEDw64nAvApX/3w/MIoc3yCDA6EvdIAlSWuzq6WzXuyc9gu2JnTqi
 SM29hrcGN1tgn1+IzJjrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0MXtTcVwsAw=:0gdjtEg9/UrCxnBN5inRb6
 HCuZu0m7OPFW5SroosSyfsTCiVxpxfRRP6A6nckokZNIcaX04mOhPIb9ycO1wgcTln02cMlL2
 boXZI6qkaIkkMAVJUL2jKjDtC58YdjoCm6TtSDHBvUoLA6CQn/fwPvKEB7ZTEbVy6g3SBbP9D
 vCUMK+NPkm0shaXqOJhGgbHX8FaQrMNsxvXETAsnScGWaRkX5vcZOeuj72yuC4N7nSM1/9xp3
 sqghKO5l//3t5WtNUIiN4R2LegdZWUPLJKTb2bxvc+QiKkwr9lpVzoTEaAtQdLFCjlf9puo7C
 /oIfbJLD3qbTfgoOSzy8Nj+z2j575HCOrR72NMGPZx5XwOcBTz2T6MscHXIHEW9TDPnn1AHh6
 iWXbX3ThLWmTDQmx+eD8iDO8ZTMu8kgIH55DcCPymjf6i3KpR5CnR5U723IILsXSma6cTm+WT
 XQR/QmxNflcbiaAXk4AyhE/+85VJCS5wJ1A5gSOl6YV80aH6bWPBD30fBgm9dyemQVZMikD73
 8ntDW1+gIFu48ETNmj4Vv9/SKwUtdzAQS3R7TbSSYQWmIyOejNyDEzcr6JnHQNrqSZCKzLWyT
 WfcbqLGw8CWMdhykL9Uz0gsc833iFkhrx/Yk3CfFG3/OR80ZhHOfbtiDw3PHiBQEwy5RwT9dI
 NX+Vw1Lnv3mV6Ye82m+jiosOWXPSGEiw3BAENmb3deXud2FWqoKmInDnzamCIT2k+7yfyc6AB
 AHjDeAPyrvo9MCTV0M0Z4ko+LLWcIaFh6dsHhC/4U/ttezn1QkNYiwYu/0CU7h5qAd7axCLJH
 UWUoSli/+IUykKeGyrSstTzJ2pAcrrPHuBRQ4i2HkPd01LF/4lvsb3YdVmfUAu4P6OjTFD+fe
 5kgVCzne0GLSrXyzLa9AXt9qVjcIYb5OPZURmatIjE6AatdQaRyfEXm41X8DsFx368OM4PWcM
 v19Yp0f1I3ewZwcxYyYBLMAlO/xc4lqU7GZHBYqBuyYDm7MuA9lQ/0x3eLwP+ygeKubR0QoGK
 Cb2BiApiHjkeMGKfQrowzzOhQri8Qb8NWH22wua7t9IvAEd76CGPjDhrHiBSqs4wXTzccUre7
 gP8a29FrTGBDOUJEksdKmAwaJDfU1dxxc4Ud0ZThmrhiYi39zCPHyGm6/NjA4gX5vbOd+KAs/
 V1+htCeGu3KtfKqgpX9ZM79eW7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 19 Sep 2022 17:01:35 +0200, Lech Perczak <lech.perczak@camlingroup.=
com> wrote:

> From: Pawe=C5=82 Lenkow <pawel.lenkow@camlingroup.com>
>=20
> During our testing of WFM200 module over SDIO on i.MX6Q-based platform,
> we discovered a memory corruption on the system, tracing back to the wfx
> driver. Using kfence, it was possible to trace it back to the root
> cause, which is hw->max_rates set to 8 in wfx_init_common,
> while the maximum defined by IEEE80211_TX_TABLE_SIZE is 4.
>=20
> This causes array out-of-bounds writes during updates of the rate table,
> as seen below:
>=20
> BUG: KFENCE: memory corruption in kfree_rcu_work+0x320/0x36c
>=20
> Corrupted memory at 0xe0a4ffe0 [ 0x03 0x03 0x03 0x03 0x01 0x00 0x00
> 0x02 0x02 0x02 0x09 0x00 0x21 0xbb 0xbb 0xbb ] (in kfence-#81):
> kfree_rcu_work+0x320/0x36c
> process_one_work+0x3ec/0x920
> worker_thread+0x60/0x7a4
> kthread+0x174/0x1b4
> ret_from_fork+0x14/0x2c
> 0x0
>=20
> kfence-#81: 0xe0a4ffc0-0xe0a4ffdf, size=3D32, cache=3Dkmalloc-64
>=20
> allocated by task 297 on cpu 0 at 631.039555s:
> minstrel_ht_update_rates+0x38/0x2b0 [mac80211]
> rate_control_tx_status+0xb4/0x148 [mac80211]
> ieee80211_tx_status_ext+0x364/0x1030 [mac80211]
> ieee80211_tx_status+0xe0/0x118 [mac80211]
> ieee80211_tasklet_handler+0xb0/0xe0 [mac80211]
> tasklet_action_common.constprop.0+0x11c/0x148
> __do_softirq+0x1a4/0x61c
> irq_exit+0xcc/0x104
> call_with_stack+0x18/0x20
> __irq_svc+0x80/0xb0
> wq_worker_sleeping+0x10/0x100
> wq_worker_sleeping+0x10/0x100
> schedule+0x50/0xe0
> schedule_timeout+0x2e0/0x474
> wait_for_completion+0xdc/0x1ec
> mmc_wait_for_req_done+0xc4/0xf8
> mmc_io_rw_extended+0x3b4/0x4ec
> sdio_io_rw_ext_helper+0x290/0x384
> sdio_memcpy_toio+0x30/0x38
> wfx_sdio_copy_to_io+0x88/0x108 [wfx]
> wfx_data_write+0x88/0x1f0 [wfx]
> bh_work+0x1c8/0xcc0 [wfx]
> process_one_work+0x3ec/0x920
> worker_thread+0x60/0x7a4
> kthread+0x174/0x1b4
> ret_from_fork+0x14/0x2c 0x0
>=20
> After discussion on the wireless mailing list it was clarified
> that the issue has been introduced by:
> commit ee0e16ab756a ("mac80211: minstrel_ht: fill all requested rates")
> and fix shall be in minstrel_ht_update_rates in rc80211_minstrel_ht.c.
>=20
> Fixes: ee0e16ab756a ("mac80211: minstrel_ht: fill all requested rates")
> Link: https://lore.kernel.org/all/12e5adcd-8aed-f0f7-70cc-4fb7b656b829@ca=
mlingroup.com/
> Link: https://lore.kernel.org/linux-wireless/20220915131445.30600-1-lech.=
perczak@camlingroup.com/
> Cc: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Peter Seiderer <ps.report@gmx.net>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Krzysztof Drobi=C5=84ski <krzysztof.drobinski@camlingroup.com>,
> Signed-off-by: Pawe=C5=82 Lenkow <pawel.lenkow@camlingroup.com>
> Signed-off-by: Lech Perczak <lech.perczak@camlingroup.com>

Reviewed-by: Peter Seiderer <ps.report@gmx.net>

Needs to be applied to 5.19 and 6.0...

Regards,
Peter

> ---
>  net/mac80211/rc80211_minstrel_ht.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_mi=
nstrel_ht.c
> index 5f27e6746762..788a82f9c74d 100644
> --- a/net/mac80211/rc80211_minstrel_ht.c
> +++ b/net/mac80211/rc80211_minstrel_ht.c
> @@ -10,6 +10,7 @@
>  #include <linux/random.h>
>  #include <linux/moduleparam.h>
>  #include <linux/ieee80211.h>
> +#include <linux/minmax.h>
>  #include <net/mac80211.h>
>  #include "rate.h"
>  #include "sta_info.h"
> @@ -1550,6 +1551,7 @@ minstrel_ht_update_rates(struct minstrel_priv *mp, =
struct minstrel_ht_sta *mi)
>  {
>  	struct ieee80211_sta_rates *rates;
>  	int i =3D 0;
> +	int max_rates =3D min_t(int, mp->hw->max_rates, IEEE80211_TX_RATE_TABLE=
_SIZE);
> =20
>  	rates =3D kzalloc(sizeof(*rates), GFP_ATOMIC);
>  	if (!rates)
> @@ -1559,10 +1561,10 @@ minstrel_ht_update_rates(struct minstrel_priv *mp=
, struct minstrel_ht_sta *mi)
>  	minstrel_ht_set_rate(mp, mi, rates, i++, mi->max_tp_rate[0]);
> =20
>  	/* Fill up remaining, keep one entry for max_probe_rate */
> -	for (; i < (mp->hw->max_rates - 1); i++)
> +	for (; i < (max_rates - 1); i++)
>  		minstrel_ht_set_rate(mp, mi, rates, i, mi->max_tp_rate[i]);
> =20
> -	if (i < mp->hw->max_rates)
> +	if (i < max_rates)
>  		minstrel_ht_set_rate(mp, mi, rates, i++, mi->max_prob_rate);
> =20
>  	if (i < IEEE80211_TX_RATE_TABLE_SIZE)

