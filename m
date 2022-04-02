Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E1D4F014D
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Apr 2022 14:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241573AbiDBMCl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 Apr 2022 08:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiDBMCj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 Apr 2022 08:02:39 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F6E13BAFC
        for <linux-wireless@vger.kernel.org>; Sat,  2 Apr 2022 05:00:44 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1648900842; bh=b8isrzYTCz+4FEOVXSzYrUnEDF9ukrKC11oZNQM53Lw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=T/WQKvyxAOHOC5TKieYQLTTnd2ODqJcnS+i0zECIcbzvWVX1IGbX9xO98ZX/c1RgA
         zBEfqC1x8QXr/MwBm9PvW7O4mcN3uq/urdw/WlbPH8qeL+pM7Wsp0LaqC55ypQJ27P
         TKnStZEmsHtaYvRpmgRC30D64NaDjRrh+3oich05D9z3a/O8e9qwHdhg5ZJEsdl1Ik
         cgnkPNFru8uDW6Z70/bxPOHQAisY6PeJspmxdnrree/YtWCIJpc3lh5vkFFhEMS3tC
         WsGIS+otArjV/mo2TMnWMWlPSTy9I3wlYdhvxHoj2xqkCd145u3zIVOBXZ5erHQl/U
         7NjmXn8fZOnBw==
To:     Peter Seiderer <ps.report@gmx.net>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v5.18] ath9k: Properly clear TX status area before
 reporting to mac80211
In-Reply-To: <20220401192657.16674bf7@gmx.net>
References: <20220330164409.16645-1-toke@toke.dk>
 <20220401192657.16674bf7@gmx.net>
Date:   Sat, 02 Apr 2022 14:00:41 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87r16fg0eu.fsf@toke.dk>
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
> On Wed, 30 Mar 2022 18:44:09 +0200, Toke H=C3=B8iland-J=C3=B8rgensen <tok=
e@toke.dk> wrote:
>
>> The ath9k driver was not properly clearing the status area in the
>> ieee80211_tx_info struct before reporting TX status to mac80211. Instead,
>> it was manually filling in fields, which meant that fields introduced la=
ter
>> were left as-is.
>>=20
>> Conveniently, mac80211 actually provides a helper to zero out the status
>> area, so use that to make sure we zero everything.
>>=20
>> The last commit touching the driver function writing the status informat=
ion
>> seems to have actually been fixing an issue that was also caused by the
>> area being uninitialised; but it only added clearing of a single field
>> instead of the whole struct. That is now redundant, though, so revert th=
at
>> commit and use it as a convenient Fixes tag.
>>=20
>> Fixes: cc591d77aba1 ("ath9k: Make sure to zero status.tx_time before rep=
orting TX status")
>> Reported-by: Bagas Sanjaya <bagasdotme@gmail.com>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
>> ---
>>  drivers/net/wireless/ath/ath9k/xmit.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireles=
s/ath/ath9k/xmit.c
>> index d0caf1de2bde..cbcf96ac303e 100644
>> --- a/drivers/net/wireless/ath/ath9k/xmit.c
>> +++ b/drivers/net/wireless/ath/ath9k/xmit.c
>> @@ -2553,6 +2553,8 @@ static void ath_tx_rc_status(struct ath_softc *sc,=
 struct ath_buf *bf,
>>  	struct ath_hw *ah =3D sc->sc_ah;
>>  	u8 i, tx_rateindex;
>>=20=20
>> +	ieee80211_tx_info_clear_status(tx_info);
>> +
>
> As this also clears the status.rates[].count, see include/net/mac80211.h:
>
> 1195 static inline void
> 1196 ieee80211_tx_info_clear_status(struct ieee80211_tx_info *info)
> 1197 {
> 1198         int i;
> 1199=20=20=20=20=20=20=20=20=20
> 1200         BUILD_BUG_ON(offsetof(struct ieee80211_tx_info, status.rates=
) !=3D
> 1201                      offsetof(struct ieee80211_tx_info, control.rate=
s));
> 1202         BUILD_BUG_ON(offsetof(struct ieee80211_tx_info, status.rates=
) !=3D
> 1203                      offsetof(struct ieee80211_tx_info, driver_rates=
));
> 1204         BUILD_BUG_ON(offsetof(struct ieee80211_tx_info, status.rates=
) !=3D 8)     ;=20=20=20=20=20=20=20
> 1205         /* clear the rate counts */
> 1206         for (i =3D 0; i < IEEE80211_TX_MAX_RATES; i++)
> 1207                 info->status.rates[i].count =3D 0;
> 1208         memset_after(&info->status, 0, rates);
> 1209 }
>
> I would have expected some lines added to restore the count (for the
> rates with index < tx_rateindex), e.g. as done in
> drivers/net/wireless/ath/ath5k/base.c:
>
> 1731         ieee80211_tx_info_clear_status(info);
> 1732=20
> 1733         for (i =3D 0; i < ts->ts_final_idx; i++) {
> 1734                 struct ieee80211_tx_rate *r =3D
> 1735                         &info->status.rates[i];
> 1736=20
> 1737                 r->count =3D tries[i];
> 1738         }
>
> In drivers/net/wireless/ath/ath9k/xmit.c this is only done/changed for
> the tx_rateindex index (which is often zero in case the first suggested r=
ate
> succeeds, but in noisy environment is sometimes > 0)...

Ah, you're right! I looked at that code, and somehow parsed that as "OK,
it's setting all the rate counts, we're fine". But obviously that's not
what that code is doing, so we'll lose some information now. Bugger :(

I'll send a follow-up, thanks for flagging this!

-Toke
