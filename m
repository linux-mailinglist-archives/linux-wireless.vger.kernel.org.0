Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FE14F0453
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Apr 2022 17:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357142AbiDBPNw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 Apr 2022 11:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357133AbiDBPNv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 Apr 2022 11:13:51 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE66166E32
        for <linux-wireless@vger.kernel.org>; Sat,  2 Apr 2022 08:11:57 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1648912315; bh=tYNKyjLw9fT1xCFwYqwWl3b2h5XHPTyfM+EUsOWNlPw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=JNraWu+/ZIHVY9L2K7KHrPuomkEebG5SmojLEbwFLvQBftu1y3Cc7RGgd8jT6dDjf
         kHTDB9QAESXiIdplzlzcLXYk/0C5nMFXXrmxvC0/MjjtLAhGhxptiyZ0VkDqx1doUf
         czjC6gFqqXBan0cgH3TOvUEi3Lmtkaa5Zg2G/uH12SOvpoMpI5+MTKMFUjIu3XHbKr
         3CFDIuvZtp6t5b4rzKz/d70DxinFd+gK8C09wTTJA19SDf6n3ekSLy32TQZCZ+U/rp
         jgJjkif//X7/p6HinbAKIH7fFe9uUprrT8L6HyQ02YJhE/wE0iYe9zAjktXcgOfbYX
         K742op7Ii74fg==
To:     Peter Seiderer <ps.report@gmx.net>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v5.18] ath9k: Properly clear TX status area before
 reporting to mac80211
In-Reply-To: <20220402163355.5ade795a@gmx.net>
References: <20220330164409.16645-1-toke@toke.dk>
 <20220401192657.16674bf7@gmx.net> <20220402163355.5ade795a@gmx.net>
Date:   Sat, 02 Apr 2022 17:11:54 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87fsmvfrk5.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Peter Seiderer <ps.report@gmx.net> writes:

> Hello Toke,
>
> On Fri, 1 Apr 2022 19:26:57 +0200, Peter Seiderer <ps.report@gmx.net> wro=
te:
>
>> Hello Toke,
>>=20
>> On Wed, 30 Mar 2022 18:44:09 +0200, Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@toke.dk> wrote:
>>=20
>> > The ath9k driver was not properly clearing the status area in the
>> > ieee80211_tx_info struct before reporting TX status to mac80211. Inste=
ad,
>> > it was manually filling in fields, which meant that fields introduced =
later
>> > were left as-is.
>> >=20
>> > Conveniently, mac80211 actually provides a helper to zero out the stat=
us
>> > area, so use that to make sure we zero everything.
>> >=20
>> > The last commit touching the driver function writing the status inform=
ation
>> > seems to have actually been fixing an issue that was also caused by the
>> > area being uninitialised; but it only added clearing of a single field
>> > instead of the whole struct. That is now redundant, though, so revert =
that
>> > commit and use it as a convenient Fixes tag.
>> >=20
>> > Fixes: cc591d77aba1 ("ath9k: Make sure to zero status.tx_time before r=
eporting TX status")
>> > Reported-by: Bagas Sanjaya <bagasdotme@gmail.com>
>> > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
>> > ---
>> >  drivers/net/wireless/ath/ath9k/xmit.c | 5 ++---
>> >  1 file changed, 2 insertions(+), 3 deletions(-)
>> >=20
>> > diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wirel=
ess/ath/ath9k/xmit.c
>> > index d0caf1de2bde..cbcf96ac303e 100644
>> > --- a/drivers/net/wireless/ath/ath9k/xmit.c
>> > +++ b/drivers/net/wireless/ath/ath9k/xmit.c
>> > @@ -2553,6 +2553,8 @@ static void ath_tx_rc_status(struct ath_softc *s=
c, struct ath_buf *bf,
>> >  	struct ath_hw *ah =3D sc->sc_ah;
>> >  	u8 i, tx_rateindex;
>> >=20=20
>> > +	ieee80211_tx_info_clear_status(tx_info);
>> > +=20=20
>>=20
>> As this also clears the status.rates[].count, see include/net/mac80211.h:
>>=20
>> 1195 static inline void
>> 1196 ieee80211_tx_info_clear_status(struct ieee80211_tx_info *info)
>> 1197 {
>> 1198         int i;
>> 1199=20=20=20=20=20=20=20=20=20
>> 1200         BUILD_BUG_ON(offsetof(struct ieee80211_tx_info, status.rate=
s) !=3D
>> 1201                      offsetof(struct ieee80211_tx_info, control.rat=
es));
>> 1202         BUILD_BUG_ON(offsetof(struct ieee80211_tx_info, status.rate=
s) !=3D
>> 1203                      offsetof(struct ieee80211_tx_info, driver_rate=
s));
>> 1204         BUILD_BUG_ON(offsetof(struct ieee80211_tx_info, status.rate=
s) !=3D 8)     ;=20=20=20=20=20=20=20
>> 1205         /* clear the rate counts */
>> 1206         for (i =3D 0; i < IEEE80211_TX_MAX_RATES; i++)
>> 1207                 info->status.rates[i].count =3D 0;
>> 1208         memset_after(&info->status, 0, rates);
>> 1209 }
>>=20
>> I would have expected some lines added to restore the count (for the
>> rates with index < tx_rateindex), e.g. as done in
>> drivers/net/wireless/ath/ath5k/base.c:
>>=20
>> 1731         ieee80211_tx_info_clear_status(info);
>> 1732=20
>> 1733         for (i =3D 0; i < ts->ts_final_idx; i++) {
>> 1734                 struct ieee80211_tx_rate *r =3D
>> 1735                         &info->status.rates[i];
>> 1736=20
>> 1737                 r->count =3D tries[i];
>> 1738         }
>>=20
>> In drivers/net/wireless/ath/ath9k/xmit.c this is only done/changed for
>> the tx_rateindex index (which is often zero in case the first suggested =
rate
>> succeeds, but in noisy environment is sometimes > 0)...
>>=20
>> >  	if (txok)
>> >  		tx_info->status.ack_signal =3D ts->ts_rssi;
>> >=20=20
>> > @@ -2595,9 +2597,6 @@ static void ath_tx_rc_status(struct ath_softc *s=
c, struct ath_buf *bf,
>> >  	}
>> >=20=20
>> >  	tx_info->status.rates[)].count =3D ts->ts_longretry + 1;
>> > -
>> > -	/* we report airtime in ath_tx_count_airtime(), don't report twice */
>> > -	tx_info->status.tx_time =3D 0;
>> >  }
>> >=20=20
>> >  static void ath_tx_processq(struct ath_softc *sc, struct ath_txq *txq=
)=20=20
>>=20
>>=20
>> And from drivers/net/wireless/ath/ath9k/xmit.c:
>>=20
>> 2592         for (i =3D tx_rateindex + 1; i < hw->max_rates; i++) {
>> 2593                 tx_info->status.rates[i].count =3D 0;
>> 2594                 tx_info->status.rates[i].idx =3D -1;
>> 2595         }
>>=20
>> Line 2593 can be deleted as status.rates[].count is already zeroed throu=
gh the
>> ieee80211_tx_info_clear_status() call...
>>=20
>> And it should be sufficient to do:
>>=20
>> 	if (tx_rateindex + 1 < hw->max_rates)
>> 		tx_info->status.rates[tx_rateindex + 1].idx =3D -1;
>>=20
>> Regards,
>> Peter
>
> And one additional problem found with your patch applied (to 5.16.18), th=
e log
> get spammed by:
>
> [  445.489139] ------------[ cut here ]------------
> [  445.489150] WARNING: CPU: 0 PID: 8630 at drivers/net/wireless/ath/ath9=
k/xmit.c:174 ath_tx_complete+0x190/0x1a0 [ath9k]
> [  445.489178] Modules linked in: ath9k ath9k_common ath9k_hw mac80211 pp=
p_async ppp_generic slhc xt_u32 xt_TCPMSS xt_tcpmss xt_MASQUERADE iptable_n=
at nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter iptabl=
e_filter ip6table_mangle ip6_tables cls_u32 sch_prio qmi_wwan cdc_wdm usbne=
t qcserial usb_wwan gpio_pca953x xt_tcpudp xt_mark iptable_mangle ip_tables=
 x_tables dummy tqmx86_wdt watchdog i2c_machxo2 gpio_tqmx86 libarc4 ath tqm=
x86 mfd_core ftdi_sio cfg80211 usbserial nct7802 regmap_i2c [last unloaded:=
 mac80211]
> [  445.489298] CPU: 0 PID: 8630 Comm: modprobe Tainted: G        W       =
  5.16.18+ #2
> [  445.489307] Hardware name: TQ-Group TQMxE38M X64/Type2 - Board Product=
 Name, BIOS TQMxE38M.5.4.48.0028.12 01/31/2017
> [  445.489311] EIP: ath_tx_complete+0x190/0x1a0 [ath9k]
> [  445.489328] Code: ff 75 e8 68 d7 a1 2c f8 89 55 ec e8 d5 4f e3 ff 8b 4=
5 f0 8b 55 ec 83 c4 10 8b 80 58 0a 00 00 e9 a8 fe ff ff 8d b6 00 00 00 00 <=
0f> 0b c7 42 68 00 00 00 00 e9 1d ff ff ff 66 90 55 89 e5 57 56 89
> [  445.489336] EAX: 00000000 EBX: c2e67900 ECX: c23cc040 EDX: c235a980
> [  445.489342] ESI: c235a888 EDI: c2359860 EBP: c1089e18 ESP: c1089dfc
> [  445.489348] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010=
297
> [  445.489355] CR0: 80050033 CR2: b7f81000 CR3: 02ec7000 CR4: 001006d0
> [  445.489362] Call Trace:
> [  445.489366]  <SOFTIRQ>
> [  445.489372]  ath_tx_complete_buf+0x100/0x130 [ath9k]
> [  445.489390]  ath_tx_process_buffer+0x187/0xb40 [ath9k]
> [  445.489407]  ? resched_curr+0x1d/0xc0
> [  445.489419]  ? check_preempt_wakeup+0x115/0x250
> [  445.489429]  ? task_fork_fair+0xc0/0x170
> [  445.489436]  ? put_prev_task_fair+0x40/0x40
> [  445.489444]  ? check_preempt_curr+0x62/0x70
> [  445.489452]  ? __local_bh_enable_ip+0x33/0x80
> [  445.489460]  ? _raw_spin_unlock_bh+0x13/0x20
> [  445.489468]  ? ath_txq_unlock_complete+0x5a/0x100 [ath9k]
> [  445.489485]  ? _raw_spin_unlock_irqrestore+0x16/0x30
> [  445.489492]  ? try_to_wake_up+0x7c/0x550
> [  445.489499]  ath_tx_tasklet+0x1de/0x2e0 [ath9k]
> [  445.489519]  ath9k_tasklet+0x22f/0x330 [ath9k]
> [  445.489535]  tasklet_action_common.constprop.0+0x89/0xb0
> [  445.489544]  tasklet_action+0x21/0x30
> [  445.489551]  __do_softirq+0xc5/0x28b
> [  445.489559]  ? __entry_text_end+0x4/0x4
> [  445.489567]  call_on_stack+0x40/0x50
> [  445.489576]  </SOFTIRQ>
> [  445.489580]  ? irq_exit_rcu+0x92/0x100
> [  445.489587]  ? common_interrupt+0x27/0x40
> [  445.489595]  ? asm_common_interrupt+0x102/0x140
> [  445.489605] ---[ end trace 5c176b666255bca1 ]---
> [  445.607206] ------------[ cut here ]------------
>
>
> Could be fixed by the following additional change:
>
> --- a/drivers/net/wireless/ath/ath9k/xmit.c
> +++ b/drivers/net/wireless/ath/ath9k/xmit.c
> @@ -2511,9 +2511,12 @@ static void ath_tx_rc_status(struct ath_softc *sc,=
 struct ath_buf *bf,
>         struct ieee80211_hw *hw =3D sc->hw;
>         struct ath_hw *ah =3D sc->sc_ah;
>         u8 i, tx_rateindex;
> +       bool is_valid_ack_signal =3D tx_info->status.is_valid_ack_signal;
>
>         ieee80211_tx_info_clear_status(tx_info);
>
> +       tx_info->status.is_valid_ack_signal =3D is_valid_ack_signal;
> +
>         if (txok)

That doesn't seem right, zeroing is_valid_ack_signal was the whole point
of the first patch... Something seems off in that backtrace; could you
try running it through ./scripts/decode_stacktrace.sh please?

-Toke
