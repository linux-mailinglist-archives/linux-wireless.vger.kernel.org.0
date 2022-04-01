Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7C14EF8F0
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 19:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347028AbiDAR3I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 13:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346717AbiDAR3H (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 13:29:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723361DEC31
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 10:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648834019;
        bh=HqOCuC1H2I9cFtyHGGFmnXk49q2U5SFLwsN7dcIE6YY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=R8u16VBhtpq4kF6wW2fJjppmkZJIKFa0B1L6bwEiOqSMo0Pb92tbyasb161qAnBuh
         AP/6s2zULC3wADsCYy+LWLsjfwzpJranx64LoloCSUrmpGPCulHoOYaTH8FYU5Wg82
         Y9dnhW6TuBaJ4PZzeJeQRqa1k0AWGGSkrwtwqKnU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost ([62.216.209.24]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbRk3-1oBbbv3v33-00brSn; Fri, 01
 Apr 2022 19:26:59 +0200
Date:   Fri, 1 Apr 2022 19:26:57 +0200
From:   Peter Seiderer <ps.report@gmx.net>
To:     Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v5.18] ath9k: Properly clear TX status area before
 reporting to mac80211
Message-ID: <20220401192657.16674bf7@gmx.net>
In-Reply-To: <20220330164409.16645-1-toke@toke.dk>
References: <20220330164409.16645-1-toke@toke.dk>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O+NQH1r29WAU58EHYmB1r+RRyIOi2YbCYPFRg5VoMmM7Z9GbuNT
 XdbJx1cycAG39vyqAu74ViGtde7uTqJH+TQHNM2QPL3FK4k0bnPYzPSmA7CZCQJ+pfwFffE
 U1W3Q1DvoB9utVwgEY98pFMd5aALxZ8e4dFSo7od8PHxAbyYIOHgnofFC/JdxRk36Pi712J
 cOSsgHAGmJzOthPB3QlZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PPUzbdgWfrw=:2tbXkNIw9phlg7mFdRqa7F
 jyyCkfn5sK9gyYnoaKM12pwTu8yBHXC83LH5nIOVupszjrb+HRquTbjtCLZXpHlcHvUpmZ2Uw
 UyTwLpIxX8nDy0Mrug2m3NWMP+2IN9RyXQuxja5ZSsFFLI/1wYUvxmm3QNaUkeVTuf7Cd80GP
 qPt0k9UCXSmzcCqvKT8g7V4/YpxQTJZhGvQrjtlOoOx5w/BNOyVQop1R4izygodbEIPTfwjHg
 c7SQVPHf+ivtEkCectba+0DmZh/EyASNx46l1O0zBs0M5pkK01UrFEY7SgcK/cT7T31TpoJSm
 6evfODLHdFy9LeLoJYwMqv6SUzhj5jr3BhY11GqxMogKCkBO8BHIW8w+GWTeG+EH8CBoC/6fW
 2rZhVBo7gZDujoSSv2LseIDLBZP8FTOluGXxjdBNslO6RTXmMyu309LIiwBWGNuLnjoCYUTwB
 GUYPOd2ffg4OrZMT8bUa1DZVIBEsUIjWJMSCZDSC4cdpnDyVi1QXbi1KiRdoujJQAa5IcgUBD
 TaHJxEb9LBGl9Wl85pZcbyDHQ+WfEBcw8UNkcUCMq657rmu+iWcLouNSicSk3lCzto3AFDNZP
 SvmuJGnveaz0PaIau80PFFUKXTNy7H9d3koHNsuxfPsbBn8pLXW3k8KKfEiYGne3TcjhMfW9D
 UI876C3nciJc04EJ6oFRYBPpGdLLBhD/JyV82GBdOfpR6DVT9zsgg0ZiAI+ua1kkhkZYNE8oj
 S7jRgU5b1kNGbf+GAzFLiChJwX+iVA+Z7oCNcvqNqIBWHBVMch/SkUY3luwjz/f5OsTqEFzed
 QZHDMjUOSo4ctFjeAmjTDD65Lnqz6aMLvOpdIhAv8CxEa6WJ8/hzlqqDvoDihGKQCHUa7KMcW
 81LbmM3QLwqdpdpg99iolJOcL326lvCAop753YuGGSTkULaeP7wVr0gnruwBfM+2rytHFaoar
 RRDf+q7A/S6yoyVC8M69YSwgRbKrHfohhgKsb5qnQ4T8fU+RNEtdOvlWfyBOxzGo+j//WW1xT
 m5DdBKZFbGZoUUBcTag7tgjnro0zY8ptKp9JhVgul1cpMLk3sMs8KrpyhNI6jFWiBfJIUpOt5
 JE39g8TMPuvSPk=
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

On Wed, 30 Mar 2022 18:44:09 +0200, Toke H=C3=B8iland-J=C3=B8rgensen <toke@=
toke.dk> wrote:

> The ath9k driver was not properly clearing the status area in the
> ieee80211_tx_info struct before reporting TX status to mac80211. Instead,
> it was manually filling in fields, which meant that fields introduced lat=
er
> were left as-is.
>=20
> Conveniently, mac80211 actually provides a helper to zero out the status
> area, so use that to make sure we zero everything.
>=20
> The last commit touching the driver function writing the status informati=
on
> seems to have actually been fixing an issue that was also caused by the
> area being uninitialised; but it only added clearing of a single field
> instead of the whole struct. That is now redundant, though, so revert that
> commit and use it as a convenient Fixes tag.
>=20
> Fixes: cc591d77aba1 ("ath9k: Make sure to zero status.tx_time before repo=
rting TX status")
> Reported-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
> ---
>  drivers/net/wireless/ath/ath9k/xmit.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless=
/ath/ath9k/xmit.c
> index d0caf1de2bde..cbcf96ac303e 100644
> --- a/drivers/net/wireless/ath/ath9k/xmit.c
> +++ b/drivers/net/wireless/ath/ath9k/xmit.c
> @@ -2553,6 +2553,8 @@ static void ath_tx_rc_status(struct ath_softc *sc, =
struct ath_buf *bf,
>  	struct ath_hw *ah =3D sc->sc_ah;
>  	u8 i, tx_rateindex;
> =20
> +	ieee80211_tx_info_clear_status(tx_info);
> +

As this also clears the status.rates[].count, see include/net/mac80211.h:

1195 static inline void
1196 ieee80211_tx_info_clear_status(struct ieee80211_tx_info *info)
1197 {
1198         int i;
1199        =20
1200         BUILD_BUG_ON(offsetof(struct ieee80211_tx_info, status.rates) =
!=3D
1201                      offsetof(struct ieee80211_tx_info, control.rates)=
);
1202         BUILD_BUG_ON(offsetof(struct ieee80211_tx_info, status.rates) =
!=3D
1203                      offsetof(struct ieee80211_tx_info, driver_rates));
1204         BUILD_BUG_ON(offsetof(struct ieee80211_tx_info, status.rates) =
!=3D 8)     ;      =20
1205         /* clear the rate counts */
1206         for (i =3D 0; i < IEEE80211_TX_MAX_RATES; i++)
1207                 info->status.rates[i].count =3D 0;
1208         memset_after(&info->status, 0, rates);
1209 }

I would have expected some lines added to restore the count (for the
rates with index < tx_rateindex), e.g. as done in
drivers/net/wireless/ath/ath5k/base.c:

1731         ieee80211_tx_info_clear_status(info);
1732=20
1733         for (i =3D 0; i < ts->ts_final_idx; i++) {
1734                 struct ieee80211_tx_rate *r =3D
1735                         &info->status.rates[i];
1736=20
1737                 r->count =3D tries[i];
1738         }

In drivers/net/wireless/ath/ath9k/xmit.c this is only done/changed for
the tx_rateindex index (which is often zero in case the first suggested rate
succeeds, but in noisy environment is sometimes > 0)...

>  	if (txok)
>  		tx_info->status.ack_signal =3D ts->ts_rssi;
> =20
> @@ -2595,9 +2597,6 @@ static void ath_tx_rc_status(struct ath_softc *sc, =
struct ath_buf *bf,
>  	}
> =20
>  	tx_info->status.rates[)].count =3D ts->ts_longretry + 1;
> -
> -	/* we report airtime in ath_tx_count_airtime(), don't report twice */
> -	tx_info->status.tx_time =3D 0;
>  }
> =20
>  static void ath_tx_processq(struct ath_softc *sc, struct ath_txq *txq)


And from drivers/net/wireless/ath/ath9k/xmit.c:

2592         for (i =3D tx_rateindex + 1; i < hw->max_rates; i++) {
2593                 tx_info->status.rates[i].count =3D 0;
2594                 tx_info->status.rates[i].idx =3D -1;
2595         }

Line 2593 can be deleted as status.rates[].count is already zeroed through =
the
ieee80211_tx_info_clear_status() call...

And it should be sufficient to do:

	if (tx_rateindex + 1 < hw->max_rates)
		tx_info->status.rates[tx_rateindex + 1].idx =3D -1;

Regards,
Peter
