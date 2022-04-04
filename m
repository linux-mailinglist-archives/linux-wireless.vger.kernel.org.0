Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB804F1393
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Apr 2022 13:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354910AbiDDLHB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Apr 2022 07:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349757AbiDDLHA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Apr 2022 07:07:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C424F36311
        for <linux-wireless@vger.kernel.org>; Mon,  4 Apr 2022 04:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649070295;
        bh=+JhhiGaY7TEZmll0RqCzq1A6xelWufSXJ43kugDiQII=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=TewqWx9Wd1LLnSi5gztIEvkk/Uq3F1Sxhykxqy4BJPZ0YavQvgkqeVvEaLLutPuhD
         SJXY+3b9acqbBxDMkxAkK3c38khuAXwPArLFehHYosjDy+xSzfzJ9fdtiYYDmFrHGQ
         gXvluEWMIL+G5Vhwhy1L8yo+5Hh+PeKQyMPOXztI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost ([62.216.209.4]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ml6qC-1oI8Wg3Fts-00lTWz; Mon, 04
 Apr 2022 13:04:54 +0200
Date:   Mon, 4 Apr 2022 13:04:53 +0200
From:   Peter Seiderer <ps.report@gmx.net>
To:     Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v5.18] ath9k: Properly clear TX status area before
 reporting to mac80211
Message-ID: <20220404130453.5ec6e045@gmx.net>
In-Reply-To: <20220402181910.5b35f0cb@gmx.net>
References: <20220330164409.16645-1-toke@toke.dk>
        <20220401192657.16674bf7@gmx.net>
        <20220402163355.5ade795a@gmx.net>
        <87fsmvfrk5.fsf@toke.dk>
        <20220402181910.5b35f0cb@gmx.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:U0vhyR178mlvh6kkaBQHTH5aMp+1kiT+JiLA7AdBH4/CNWpAk4O
 wvpH8OCrByxsrAUpQR4NLSmp6LaIKXqQH399iFSQiDJJnUaLp5ysvujBgxQJujzGz2iFeBF
 GJFEl+2CYmbjBhw2QrCMNHM4/YdHcSwJuW5+4hJ4yeAd8qkOeSUQ0oHqYD7MQxmwolomu9j
 WsuHgl4SMsykfaQnk8HOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OMXHPVHQUDU=:nm/QcocMwGNavZlBKniVqr
 ft+OFCL1x+7IdjUtREFatDXytGpNwHs5w4xa0j+SCU8fV+lb1iNq4Q2Smf19UkTqyNprtiKOR
 4PsEPp5KP+VpPL0ytZkmeA/b2j4tUaUV0j00VIgygRov9iulsmDF7ArqbNHlCmSXs1iQh6Yqr
 QGZzdU6VQYgjOm4cEvVg6uUHvKZ9WhbQJPOdSmfNXyaAQ36tC6awnJIHC0DGw8DI7wkRBFWOo
 gbOfDcPuEWam5lKl+73FOqmFy5mIjdP85y03xNfj87CPmUCRNY0ievksSE1vzuLrmW97h7lA/
 S2ZHf0NZqFp7c5a7iN4xVkL+VvOEIKIf9TBDrXJvj4aq/0ZQCXbeI4v+KjcnE6h0P6h2qlP6L
 lYlU1nbyW2/juYd6ZYeKl+PxMD+C08icLgA2aXOhFho9rehO7j7TCDxW6h22+77p4+TwG7xun
 YMZi5wdec+jzkP80NtljStxiMLHhBeMvXTl9oibVQNqvHmYsMEBhFhf1wsGu884/tnhD/jbOB
 TGgH0q6n2yKcvI/FScf6CAI/8hi35FEbb2DTTPGaoTM/K77ByHogn7V7bItDp4MLUOKIGHYCJ
 dppPTs+JBsxr8ridBDRA+Cc+f3OK9BVJggi8Irle5VvkUHsVnBtEfLMpFGAxNe7ozwI7J8KXr
 ybI1sHvPa1qH2VaHawVqA7LEqNS9tq5rcgC3U9qrZ7hbBFD179F7sz0kYp8EAbmrUNqwFr8Yq
 xEOcLp6SFcm2ci399GxEaejUNPZmMopnvzVfhsOaNKkRIy/PSJOvD0u6uh30/7G9q8OUeSyRS
 2vQSl/dyPRATn9IzdwvQkqcNAzXKarrQ5ustEFBcvieozA+F8PXDCz9H13OrqqNJi/rJBU0sP
 gvbMbiEj2mn7spq2LaXzW7iM6n8qKQdpiMw+XkLCh0uTxA/fJLD8t9EnOybCD9hJ625X+XU4W
 3MLzSKyd0x2Vamxx+7srd4D8glv6kPNMP23jAeXaQImO8/QHtkcv1vDMrXN/yL8xf9NDjeYuD
 b3xltPa2PXHeTkorFJwgKL9XlwzuuEyTYMSN4LXnr1LyRcD4/Z0FEbEMOnote1o3npkRnsScq
 SdBEhgJKBmYLww=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Toke,

On Sat, 2 Apr 2022 18:19:10 +0200, Peter Seiderer <ps.report@gmx.net> wrote:

> Hello Toke,
>=20
> On Sat, 02 Apr 2022 17:11:54 +0200, Toke H=C3=B8iland-J=C3=B8rgensen <tok=
e@toke.dk> wrote:
>=20
> > Peter Seiderer <ps.report@gmx.net> writes:
> >  =20
> > > Hello Toke,
> > >
> > > On Fri, 1 Apr 2022 19:26:57 +0200, Peter Seiderer <ps.report@gmx.net>=
 wrote:
> > >   =20
> > >> Hello Toke,
> > >>=20
> > >> On Wed, 30 Mar 2022 18:44:09 +0200, Toke H=C3=B8iland-J=C3=B8rgensen=
 <toke@toke.dk> wrote:
> > >>    =20
> > >> > The ath9k driver was not properly clearing the status area in the
> > >> > ieee80211_tx_info struct before reporting TX status to mac80211. I=
nstead,
> > >> > it was manually filling in fields, which meant that fields introdu=
ced later
> > >> > were left as-is.
> > >> >=20
> > >> > Conveniently, mac80211 actually provides a helper to zero out the =
status
> > >> > area, so use that to make sure we zero everything.
> > >> >=20
> > >> > The last commit touching the driver function writing the status in=
formation
> > >> > seems to have actually been fixing an issue that was also caused b=
y the
> > >> > area being uninitialised; but it only added clearing of a single f=
ield
> > >> > instead of the whole struct. That is now redundant, though, so rev=
ert that
> > >> > commit and use it as a convenient Fixes tag.
> > >> >=20
> > >> > Fixes: cc591d77aba1 ("ath9k: Make sure to zero status.tx_time befo=
re reporting TX status")
> > >> > Reported-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > >> > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
> > >> > ---
> > >> >  drivers/net/wireless/ath/ath9k/xmit.c | 5 ++---
> > >> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > >> >=20
> > >> > diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/w=
ireless/ath/ath9k/xmit.c
> > >> > index d0caf1de2bde..cbcf96ac303e 100644
> > >> > --- a/drivers/net/wireless/ath/ath9k/xmit.c
> > >> > +++ b/drivers/net/wireless/ath/ath9k/xmit.c
> > >> > @@ -2553,6 +2553,8 @@ static void ath_tx_rc_status(struct ath_soft=
c *sc, struct ath_buf *bf,
> > >> >  	struct ath_hw *ah =3D sc->sc_ah;
> > >> >  	u8 i, tx_rateindex;
> > >> > =20
> > >> > +	ieee80211_tx_info_clear_status(tx_info);
> > >> > +     =20
> > >>=20
> > >> As this also clears the status.rates[].count, see include/net/mac802=
11.h:
> > >>=20
> > >> 1195 static inline void
> > >> 1196 ieee80211_tx_info_clear_status(struct ieee80211_tx_info *info)
> > >> 1197 {
> > >> 1198         int i;
> > >> 1199        =20
> > >> 1200         BUILD_BUG_ON(offsetof(struct ieee80211_tx_info, status.=
rates) !=3D
> > >> 1201                      offsetof(struct ieee80211_tx_info, control=
.rates));
> > >> 1202         BUILD_BUG_ON(offsetof(struct ieee80211_tx_info, status.=
rates) !=3D
> > >> 1203                      offsetof(struct ieee80211_tx_info, driver_=
rates));
> > >> 1204         BUILD_BUG_ON(offsetof(struct ieee80211_tx_info, status.=
rates) !=3D 8)     ;      =20
> > >> 1205         /* clear the rate counts */
> > >> 1206         for (i =3D 0; i < IEEE80211_TX_MAX_RATES; i++)
> > >> 1207                 info->status.rates[i].count =3D 0;
> > >> 1208         memset_after(&info->status, 0, rates);
> > >> 1209 }
> > >>=20
> > >> I would have expected some lines added to restore the count (for the
> > >> rates with index < tx_rateindex), e.g. as done in
> > >> drivers/net/wireless/ath/ath5k/base.c:
> > >>=20
> > >> 1731         ieee80211_tx_info_clear_status(info);
> > >> 1732=20
> > >> 1733         for (i =3D 0; i < ts->ts_final_idx; i++) {
> > >> 1734                 struct ieee80211_tx_rate *r =3D
> > >> 1735                         &info->status.rates[i];
> > >> 1736=20
> > >> 1737                 r->count =3D tries[i];
> > >> 1738         }
> > >>=20
> > >> In drivers/net/wireless/ath/ath9k/xmit.c this is only done/changed f=
or
> > >> the tx_rateindex index (which is often zero in case the first sugges=
ted rate
> > >> succeeds, but in noisy environment is sometimes > 0)...
> > >>    =20
> > >> >  	if (txok)
> > >> >  		tx_info->status.ack_signal =3D ts->ts_rssi;
> > >> > =20
> > >> > @@ -2595,9 +2597,6 @@ static void ath_tx_rc_status(struct ath_soft=
c *sc, struct ath_buf *bf,
> > >> >  	}
> > >> > =20
> > >> >  	tx_info->status.rates[)].count =3D ts->ts_longretry + 1;
> > >> > -
> > >> > -	/* we report airtime in ath_tx_count_airtime(), don't report twi=
ce */
> > >> > -	tx_info->status.tx_time =3D 0;
> > >> >  }
> > >> > =20
> > >> >  static void ath_tx_processq(struct ath_softc *sc, struct ath_txq =
*txq)     =20
> > >>=20
> > >>=20
> > >> And from drivers/net/wireless/ath/ath9k/xmit.c:
> > >>=20
> > >> 2592         for (i =3D tx_rateindex + 1; i < hw->max_rates; i++) {
> > >> 2593                 tx_info->status.rates[i].count =3D 0;
> > >> 2594                 tx_info->status.rates[i].idx =3D -1;
> > >> 2595         }
> > >>=20
> > >> Line 2593 can be deleted as status.rates[].count is already zeroed t=
hrough the
> > >> ieee80211_tx_info_clear_status() call...
> > >>=20
> > >> And it should be sufficient to do:
> > >>=20
> > >> 	if (tx_rateindex + 1 < hw->max_rates)
> > >> 		tx_info->status.rates[tx_rateindex + 1].idx =3D -1;
> > >>=20
> > >> Regards,
> > >> Peter   =20
> > >
> > > And one additional problem found with your patch applied (to 5.16.18)=
, the log
> > > get spammed by:
> > >
> > > [  445.489139] ------------[ cut here ]------------
> > > [  445.489150] WARNING: CPU: 0 PID: 8630 at drivers/net/wireless/ath/=
ath9k/xmit.c:174 ath_tx_complete+0x190/0x1a0 [ath9k]
> > > [  445.489178] Modules linked in: ath9k ath9k_common ath9k_hw mac8021=
1 ppp_async ppp_generic slhc xt_u32 xt_TCPMSS xt_tcpmss xt_MASQUERADE iptab=
le_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter ip=
table_filter ip6table_mangle ip6_tables cls_u32 sch_prio qmi_wwan cdc_wdm u=
sbnet qcserial usb_wwan gpio_pca953x xt_tcpudp xt_mark iptable_mangle ip_ta=
bles x_tables dummy tqmx86_wdt watchdog i2c_machxo2 gpio_tqmx86 libarc4 ath=
 tqmx86 mfd_core ftdi_sio cfg80211 usbserial nct7802 regmap_i2c [last unloa=
ded: mac80211]
> > > [  445.489298] CPU: 0 PID: 8630 Comm: modprobe Tainted: G        W   =
      5.16.18+ #2
> > > [  445.489307] Hardware name: TQ-Group TQMxE38M X64/Type2 - Board Pro=
duct Name, BIOS TQMxE38M.5.4.48.0028.12 01/31/2017
> > > [  445.489311] EIP: ath_tx_complete+0x190/0x1a0 [ath9k]
> > > [  445.489328] Code: ff 75 e8 68 d7 a1 2c f8 89 55 ec e8 d5 4f e3 ff =
8b 45 f0 8b 55 ec 83 c4 10 8b 80 58 0a 00 00 e9 a8 fe ff ff 8d b6 00 00 00 =
00 <0f> 0b c7 42 68 00 00 00 00 e9 1d ff ff ff 66 90 55 89 e5 57 56 89
> > > [  445.489336] EAX: 00000000 EBX: c2e67900 ECX: c23cc040 EDX: c235a980
> > > [  445.489342] ESI: c235a888 EDI: c2359860 EBP: c1089e18 ESP: c1089dfc
> > > [  445.489348] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 0=
0010297
> > > [  445.489355] CR0: 80050033 CR2: b7f81000 CR3: 02ec7000 CR4: 001006d0
> > > [  445.489362] Call Trace:
> > > [  445.489366]  <SOFTIRQ>
> > > [  445.489372]  ath_tx_complete_buf+0x100/0x130 [ath9k]
> > > [  445.489390]  ath_tx_process_buffer+0x187/0xb40 [ath9k]
> > > [  445.489407]  ? resched_curr+0x1d/0xc0
> > > [  445.489419]  ? check_preempt_wakeup+0x115/0x250
> > > [  445.489429]  ? task_fork_fair+0xc0/0x170
> > > [  445.489436]  ? put_prev_task_fair+0x40/0x40
> > > [  445.489444]  ? check_preempt_curr+0x62/0x70
> > > [  445.489452]  ? __local_bh_enable_ip+0x33/0x80
> > > [  445.489460]  ? _raw_spin_unlock_bh+0x13/0x20
> > > [  445.489468]  ? ath_txq_unlock_complete+0x5a/0x100 [ath9k]
> > > [  445.489485]  ? _raw_spin_unlock_irqrestore+0x16/0x30
> > > [  445.489492]  ? try_to_wake_up+0x7c/0x550
> > > [  445.489499]  ath_tx_tasklet+0x1de/0x2e0 [ath9k]
> > > [  445.489519]  ath9k_tasklet+0x22f/0x330 [ath9k]
> > > [  445.489535]  tasklet_action_common.constprop.0+0x89/0xb0
> > > [  445.489544]  tasklet_action+0x21/0x30
> > > [  445.489551]  __do_softirq+0xc5/0x28b
> > > [  445.489559]  ? __entry_text_end+0x4/0x4
> > > [  445.489567]  call_on_stack+0x40/0x50
> > > [  445.489576]  </SOFTIRQ>
> > > [  445.489580]  ? irq_exit_rcu+0x92/0x100
> > > [  445.489587]  ? common_interrupt+0x27/0x40
> > > [  445.489595]  ? asm_common_interrupt+0x102/0x140
> > > [  445.489605] ---[ end trace 5c176b666255bca1 ]---
> > > [  445.607206] ------------[ cut here ]------------
> > >
> > >
> > > Could be fixed by the following additional change:
> > >
> > > --- a/drivers/net/wireless/ath/ath9k/xmit.c
> > > +++ b/drivers/net/wireless/ath/ath9k/xmit.c
> > > @@ -2511,9 +2511,12 @@ static void ath_tx_rc_status(struct ath_softc =
*sc, struct ath_buf *bf,
> > >         struct ieee80211_hw *hw =3D sc->hw;
> > >         struct ath_hw *ah =3D sc->sc_ah;
> > >         u8 i, tx_rateindex;
> > > +       bool is_valid_ack_signal =3D tx_info->status.is_valid_ack_sig=
nal;
> > >
> > >         ieee80211_tx_info_clear_status(tx_info);
> > >
> > > +       tx_info->status.is_valid_ack_signal =3D is_valid_ack_signal;
> > > +
> > >         if (txok)   =20
> >=20
> > That doesn't seem right, zeroing is_valid_ack_signal was the whole point
> > of the first patch... Something seems off in that backtrace; could you
> > try running it through ./scripts/decode_stacktrace.sh please? =20
>=20
> Will do (and re-run the test with an fresh compiled kernel as CONFIG_DEBU=
G_KERNEL
> was not set - but need to wait until next week as I need physical access =
to
> the test system for kernel update)...

Same with an fresh build (and with stacktrace run through decode_stacktrace=
.sh), but
did some more investigations, added an debug print of tx_info->status.is_va=
lid_ack_signal
in ath_tx_rc_status() and an corresponding one in ath_txq_skb_done() printi=
ng out
fi->txq, with the additional

	tx_info->status.is_valid_ack_signal =3D is_valid_ack_signal;

line added showed the following output

[  839.543175] XXX - ath_tx_rc_status() - is_valid_ack_signal: 2
[  839.543195] XXX - ath_txq_skb_done() txq: 2
[  839.617898] XXX - ath_tx_rc_status() - is_valid_ack_signal: 2
[  839.617961] XXX - ath_txq_skb_done() txq: 2
[  840.024845] XXX - ath_tx_rc_status() - is_valid_ack_signal: 2
[  840.024863] XXX - ath_txq_skb_done() txq: 2
[...]

and without the following:

[  924.614745] XXX - ath_tx_rc_status() - is_valid_ack_signal: 2
[  924.614762] XXX - ath_txq_skb_done() txq: 0
[  924.614805] ------------[ cut here ]------------
[  924.614809] WARNING: CPU: 0 PID: 0 at drivers/net/wireless/ath/ath9k/xmi=
t.c:176 ath_txq_skb_done.constprop.0+0x28/0x38 [ath9k]
[...]


Seems ieee80211_tx_info_clear_status() clears/destroys the dual use of the
struct ieee80211_tx_info.status vs. ieee80211_tx_info.rate_driver_data...

See drivers/net/wireless/ath/ath9k/xmit.c

 140 static struct ath_frame_info *get_frame_info(struct sk_buff *skb)
 141 {
 142         struct ieee80211_tx_info *tx_info =3D IEEE80211_SKB_CB(skb);
 143         BUILD_BUG_ON(sizeof(struct ath_frame_info) >
 144                      sizeof(tx_info->rate_driver_data));
 145         return (struct ath_frame_info *) &tx_info->rate_driver_data[0];
 146 }


 205 static void ath_txq_skb_done(struct ath_softc *sc, struct ath_txq *txq,
 206                              struct sk_buff *skb)
 207 {
 208         struct ath_frame_info *fi =3D get_frame_info(skb);
 209         int q =3D fi->txq;
 210=20
 211         if (q < 0)
 212                 return;
 213=20
 214         txq =3D sc->tx.txq_map[q];
 215         if (WARN_ON(--txq->pending_frames < 0))
 216                 txq->pending_frames =3D 0;
 217=20
 218 }

Seems it only worked by chance (?) before...

Regards,
Peter


>=20
> Regards,
> Peter
>=20
> >=20
> > -Toke =20
>=20

