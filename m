Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617AF5BA0CE
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Sep 2022 20:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiIOSWN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Sep 2022 14:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIOSWM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Sep 2022 14:22:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A82A1D0
        for <linux-wireless@vger.kernel.org>; Thu, 15 Sep 2022 11:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663266119;
        bh=zl3TeiP3uFFYxoVzJaCrmfyIU9CP2e2mUdYRtac5cM0=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=joyZn61KAQk9YmporQdKzKz6nJzBV0WEll075RRPwzj8vQbloERL+fbee0ti+JFA+
         yCkdkJL5uKxIy83JD1wMnvLhQR8HYUbS4XqKN7AFVLj4fMxElUh85PRUyWkkoWRE5j
         7hoD2FhFedBweu0qeIgYxcA73ZcYLCxRsNPEr2Fo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost ([62.216.209.163]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mq2j2-1p3GVx1gw6-00n5p6; Thu, 15
 Sep 2022 20:21:59 +0200
Date:   Thu, 15 Sep 2022 20:21:57 +0200
From:   Peter Seiderer <ps.report@gmx.net>
To:     Lech Perczak <lech.perczak@camlingroup.com>
Cc:     =?UTF-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>,
        linux-wireless@vger.kernel.org,
        =?UTF-8?B?UGF3ZcWC?= Lenkow <pawel.lenkow@camlingroup.com>,
        Kalle Valo <kvalo@kernel.org>,
        Krzysztof =?UTF-8?B?RHJvYmnFhHNraQ==?= 
        <krzysztof.drobinski@camlingroup.com>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] wifi: wfx: fix memory corruption by limiting max_rates
 to 4
Message-ID: <20220915202157.6fff5ef8@gmx.net>
In-Reply-To: <41f23be7-3385-e6cc-9c76-f88b1dd5ebd2@camlingroup.com>
References: <20220915131445.30600-1-lech.perczak@camlingroup.com>
        <8115258.T7Z3S40VBb@pc-42>
        <41f23be7-3385-e6cc-9c76-f88b1dd5ebd2@camlingroup.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AyM6/FbGPhRloSJwIDPgks5rUyTScmxKEDV02MiUaIqowsdYlJX
 uAY+JUnfKOj5GnyMEZT9l7Os2VcCycQMTQ1hr5apzLY0h9zC0AAdtxIRND4L0vs29tIOcZf
 F2SqDal2p5lQ/zhvphN1b9jDYCpZ8zqjneUc5uXgAdptSAbtlmMizqa4avvozEyjW5Fif2u
 gpmmtayU3q71no+9vuDeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ECrUaD4fzRk=:Hw+FcVla5aHeGJ4pS3rkZJ
 JbppXPpN+SHV8QeRb9kbQL6Her8ztjrjuiAcTMIKGSFOUTEMpzrOTETNNJeij5RQgEzIAXPqQ
 hliaklyiJckgYc13hG0SA37NkgpD3le1S71NwtpUpUfLr9kr8ZYt4KdJp04QsXro5a5I/KK9B
 ZtjS5jydBAHLzSwkfBfafgDP2mr5x2sOxNNhbrWD/jQg9feB8FFmPWAXG7MBpGpWqpVIw6e8p
 6TsqyvyfMBavYeUowTQ6X5AIO65+4+UpHjN6Z7bmENM4k3ye5W0ZZ9vfaC7NVqD8ZGKvQ2cx+
 LtyzPTDhcVHAy9LIXIxopAKCAFVEIuGD5JMID+x7UCoL1C+FAqbhoo+VSxa3bvwG36bEaRBKh
 UpkuFrU/eb5Ynhm0Sl0e4hTyJuPmGpUN6+1G0csidmMj1L+xGQSMOzYxyN6T6D/wNBoW7De8A
 0r+v6tPTwUT6g2DLsboe+njqylLrUU9vcT9rh3xQDzkz/CMrvs9ympw5HwSq/4Een7dPKhvgU
 yM+mGuOULpmdMp0l4fSPgx5pxrYcc/gyuMUps1rdXkBvNYYKufLzrhFFmm87T9/XE8K6M8sMv
 +/H9MlIzn5Z5npWpdWkKg70Mb/Kc5B27UuGPTolLxpr5YTLVvqK8cbro6b3ChEUg0PfeWrvX4
 7lftm2DlFlbOqJAvd29XM9RDJQp4rDHqbMVbEuj8jZBZ9ElCh6p0rsqzIPslPQrgMkr3zuGmY
 Ha638MdMYWXl2v5E11MZuEX7JI8U5esTxGHJfJyDYJwTobBi7D8VkCZMONHLNsp5NrswIOt9u
 0TtJfRVvQpVxpk+GyL5gcAJbBjWYBKFkBGs5mfi+bvboKLKcFiUVENKG9d8pkCrdeMMC1UFzk
 trLE/fRg6D05siQ/KSYiDQUwUSr2GYlnzOLbZxR2yW7g75PgsMC3Fh55nqlIrUaOog28idpuO
 6TlGO/cyhxD4LPDaHEmTVuT3GrGohW638uyVUjOSbmWFyda07Ku/X8pjNzaY14fHEEpnL/jxJ
 x5bN17wIkmDtmrD7oQ0H9CnaI5RfMDou+RATVdUviizX06oj8xL+JLVJ4EMy/HTUAFkdtHIT2
 d3EfKqljVSDfMmwGo4SnKTmEvJkyGtAzshdKqTmlxneK9xzUVUY8Cdj+I5VDwMVgu7mWiELnb
 TCeUuYK66eDUSg69zcqnckOjDn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello *,

On Thu, 15 Sep 2022 16:02:34 +0200, Lech Perczak <lech.perczak@camlingroup.=
com> wrote:

> Hi J=C3=A9r=C3=B4me,
>=20
> Answers inline.
> [Add Krzysztof in Cc:]
>=20
> W dniu 15.09.2022 o=C2=A015:39, J=C3=A9r=C3=B4me Pouiller pisze:
> > [Add Peter in Cc:]
> >
> > On Thursday 15 September 2022 15:14:45 CEST Lech Perczak wrote: =20
> > > From: Pawe=C5=82 Lenkow <pawel.lenkow@camlingroup.com>
> > >
> > > During our testing of WFM200 module over SDIO on i.MX6Q-based platfor=
m,
> > > we discovered a memory corruption on the system, tracing back to the =
wfx
> > > driver. Using kfence, it was possible to trace it back to the root
> > > cause, which is hw->max_rates set to 8 in wfx_init_common,
> > > while the maximum defined by IEEE80211_TX_TABLE_SIZE is 4.
> > >
> > > This causes array out-of-bounds writes during updates of the rate tab=
le,
> > > as seen below:
> > >
> > > BUG: KFENCE: memory corruption in kfree_rcu_work+0x320/0x36c
> > >
> > > Corrupted memory at 0xe0a4ffe0 [ 0x03 0x03 0x03 0x03 0x01 0x00 0x00
> > > 0x02 0x02 0x02 0x09 0x00 0x21 0xbb 0xbb 0xbb ] (in kfence-#81):
> > > kfree_rcu_work+0x320/0x36c
> > > process_one_work+0x3ec/0x920
> > > worker_thread+0x60/0x7a4
> > > kthread+0x174/0x1b4
> > > ret_from_fork+0x14/0x2c
> > > 0x0
> > >
> > > kfence-#81: 0xe0a4ffc0-0xe0a4ffdf, size=3D32, cache=3Dkmalloc-64
> > >
> > > allocated by task 297 on cpu 0 at 631.039555s:
> > > minstrel_ht_update_rates+0x38/0x2b0 [mac80211]
> > > rate_control_tx_status+0xb4/0x148 [mac80211]
> > > ieee80211_tx_status_ext+0x364/0x1030 [mac80211]
> > > ieee80211_tx_status+0xe0/0x118 [mac80211]
> > > ieee80211_tasklet_handler+0xb0/0xe0 [mac80211]
> > > tasklet_action_common.constprop.0+0x11c/0x148
> > > __do_softirq+0x1a4/0x61c
> > > irq_exit+0xcc/0x104
> > > call_with_stack+0x18/0x20
> > > __irq_svc+0x80/0xb0
> > > wq_worker_sleeping+0x10/0x100
> > > wq_worker_sleeping+0x10/0x100
> > > schedule+0x50/0xe0
> > > schedule_timeout+0x2e0/0x474
> > > wait_for_completion+0xdc/0x1ec
> > > mmc_wait_for_req_done+0xc4/0xf8
> > > mmc_io_rw_extended+0x3b4/0x4ec
> > > sdio_io_rw_ext_helper+0x290/0x384
> > > sdio_memcpy_toio+0x30/0x38
> > > wfx_sdio_copy_to_io+0x88/0x108 [wfx]
> > > wfx_data_write+0x88/0x1f0 [wfx]
> > > bh_work+0x1c8/0xcc0 [wfx]
> > > process_one_work+0x3ec/0x920
> > > worker_thread+0x60/0x7a4
> > > kthread+0x174/0x1b4
> > > ret_from_fork+0x14/0x2c 0x0
> > >
> > > Limit hw->max_rates to not exceed IEEE80211_TX_RATE_TABLE_SIZE (4).
> > >
> > > To bring back previous value, the global table size limit needs to be
> > > increased beforehand in mac80211.h, or by limiting the iteration count
> > > in minstrel_ht_update_rates against IEEE80211_TX_RATE_TABLE_SIZE as
> > > well.
> > >
> > > Fixes: e16e7f0716a6 ("staging: wfx: instantiate mac80211 data") =20
> >
> > I think the issue has been introduced by ee0e16ab756a ("mac80211:
> > minstrel_ht: fill all requested rates").

Ups, sorry for creating a regression (and many thanks for investigation)...

> >
> > =20
> > > Cc: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
> > > Cc: Kalle Valo <kvalo@kernel.org>
> > > Link: https://urldefense.com/v3/__https://lore.kernel.org/all/12e5adc=
d-8aed-f0f7-70cc-4fb7b656b829@camlingroup.com/__;!!N30Cs7Jr!ReVaYMRjWoJzG95=
KRgrZTGAw0bmt5lnLLpRkt574SRvIoKLD2xl53YKUiLpN4PfXpjSLIQ9KvgVy9Wi4jeJE8axP9M=
4Odgk$ <https://urldefense.com/v3/__https://lore.kernel.org/all/12e5adcd-8a=
ed-f0f7-70cc-4fb7b656b829@camlingroup.com/__;!!N30Cs7Jr!ReVaYMRjWoJzG95KRgr=
ZTGAw0bmt5lnLLpRkt574SRvIoKLD2xl53YKUiLpN4PfXpjSLIQ9KvgVy9Wi4jeJE8axP9M4Odg=
k$>
> > >
> > > Signed-off-by: Pawe=C5=82 Lenkow <pawel.lenkow@camlingroup.com>
> > > Signed-off-by: Lech Perczak <lech.perczak@camlingroup.com>
> > > ---
> > > drivers/net/wireless/silabs/wfx/main.c | 2 +-
> > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/wireless/silabs/wfx/main.c b/drivers/net/wir=
eless/silabs/wfx/main.c
> > > index 84d82ddded56..7463fe4b5cae 100644
> > > --- a/drivers/net/wireless/silabs/wfx/main.c
> > > +++ b/drivers/net/wireless/silabs/wfx/main.c
> > > @@ -273,7 +273,7 @@ struct wfx_dev *wfx_init_common(struct device *de=
v, const struct wfx_platform_da
> > > hw->vif_data_size =3D sizeof(struct wfx_vif);
> > > hw->sta_data_size =3D sizeof(struct wfx_sta_priv);
> > > hw->queues =3D 4;
> > > - hw->max_rates =3D 8;
> > > + hw->max_rates =3D 4;

Quick grep for max_rates did show the same for:

drivers/net/wireless/st/cw1200/main.c:  hw->max_rates =3D 8;

> > > hw->max_rate_tries =3D 8;
> > > hw->extra_tx_headroom =3D sizeof(struct wfx_hif_msg) + sizeof(struct =
wfx_hif_req_tx) +
> > > 4 /* alignment */ + 8 /* TKIP IV */; =20
> >

Think the following suggested fix is the right way to go (and keep hw->max_=
rates
value according to the hardware capabilities(?) of the wifi device)...

> > Do you think the fix should rather be:
> >
> > ------8<----------8<--------
> > --- i/net/mac80211/rc80211_minstrel_ht.c
> > +++ w/net/mac80211/rc80211_minstrel_ht.c
> > @@ -1559,7 +1559,7 @@ minstrel_ht_update_rates(struct minstrel_priv *mp=
, struct minstrel_ht_sta *mi)
> > minstrel_ht_set_rate(mp, mi, rates, i++, mi->max_tp_rate[0]);
> >
> > /* Fill up remaining, keep one entry for max_probe_rate */
> > - for (; i < (mp->hw->max_rates - 1); i++)
> > + for (; i < min(mp->hw->max_rates, IEEE80211_TX_RATE_TABLE_SIZE) - 1; =
i++)
> > minstrel_ht_set_rate(mp, mi, rates, i, mi->max_tp_rate[i]);
> >

Same change needed here:

> > if (i < mp->hw->max_rates)

    if (i < min(mp->hw->max_rates, IEEE80211_TX_RATE_TABLE_SIZE))

> > ------8<----------8<--------
> > =20
> We thought about this as well - or about adding assertion to the function=
 which does the memory allocation,
> but there are more 4-element arrays in mac80211, handled under different =
defines, which can be confusing.
>=20
> carl9170 driver has BUILD_BUG_ON to guard from that precisely - see:
> https://elixir.bootlin.com/linux/latest/source/drivers/net/wireless/ath/c=
arl9170/tx.c#L879
> I think, that the second BUILD_BUG_ON could be moved to mac80211 core, so=
 that it is checked always,
> not only when CARL9170 is enabled.
>=20
> I think both changes should be applied - or, alternatively, in minstrel_h=
t_set_rate, we could use:
> BUG_ON(mp->hw->max_rates > IEEE80211_TX_RATE_TABLE_SIZE);
> to quickly catch misbehaving drivers in future.

Think with the suggested changes to minstrel_ht_set_rate no further asserti=
on
is needed...

Regards,
Peter

>=20
> Since this concerns mac80211 core, let's add Johannes to the loop as well.
> >
> >
> > --=20
> > J=C3=A9r=C3=B4me Pouiller
> >
> > =20

