Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B2A31389C
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Feb 2021 16:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbhBHPzD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Feb 2021 10:55:03 -0500
Received: from mail.toke.dk ([45.145.95.4]:49143 "EHLO mail.toke.dk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234217AbhBHPyi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Feb 2021 10:54:38 -0500
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1612799630; bh=cUXTygvQBSe9tf+PWQFop4Z2psD8Qa1X0wGFrUmgGKU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=P5q5p6XCF6P7GVC5+IpntTLeQRF7hPtwUIjrmVy/XaAFw2WyJIuwXTlnY1UKQnb7w
         6P6gYsgNZBw6iMHseFz+fk5trBAJUWWDY1qucN6+JNkZrUhalPGOk9XVavKaDbc/c4
         Z28te0JnDWpn/jBgLUjzZup0glTmyuemWSWWoRsaYnLgCw63LH80cX/QTlyfoLt41Z
         KYmbcnBPBC6SeKeMB4DlGSNeixfriFYHobHPWzr5Si5PR7rjyF046QnWwjtKlPx+So
         RbE9i3GK5Hsth0RavgD38gPnyIJhuPRVn8weH4A7YNtVptMO4XF2RKq6sA2SZ7Nejt
         ppTSvuZ7ROKdw==
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mac80211: only schedule TXQ when reasonable airtime
 reporting
In-Reply-To: <1612796033.13185.5.camel@mtkswgap22>
References: <c48c3555ab2261d6b6674ac7de8203359b80b127.1612529311.git.ryder.lee@mediatek.com>
 <878s82ve1c.fsf@toke.dk> <1612665675.2364.43.camel@mtkswgap22>
 <1612796033.13185.5.camel@mtkswgap22>
Date:   Mon, 08 Feb 2021 16:53:50 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <878s7ytv1t.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ryder Lee <ryder.lee@mediatek.com> writes:

> On Sun, 2021-02-07 at 10:41 +0800, Ryder Lee wrote:
>> On Fri, 2021-02-05 at 14:29 +0100, Toke H=C3=B8iland-J=C3=B8rgensen wrot=
e:
>
>> > > @@ -3770,6 +3770,10 @@ struct ieee80211_txq *ieee80211_next_txq(stru=
ct ieee80211_hw *hw, u8 ac)
>> > >  				sta->airtime_weight;
>> > >=20=20
>> > >  		if (deficit < 0 || !aql_check) {
>> > > +			if (txqi->schedule_round =3D=3D local->schedule_round[ac])
>> > > +				goto out;
>> > > +
>> > > +			txqi->schedule_round =3D local->schedule_round[ac];
>> >=20
>> > I think this change may be worth making anyway, but for a different
>> > reason: Without it, a station that fails aql_check will keep getting
>> > recycled through the list, advancing its deficit. Which could actually
>> > be the reason AQL breaks airtime fairness; did you observe any
>> > difference in fairness with this change?
>>=20
>> Our case is: mt7915 provides per-peer airtime counters. However, some of
>> them were not properly configured, so certain stations reported large
>> amount of airtime which led to deficit < 0, and as you said, ending up
>> with recycle + very longer lock hold time (0.9s in our tests) and
>> breaking fairness.

First of all, if the driver reports wrong airtime values, of course it
is going to affect fairness. The right thing in that case is to fix the
driver, or turn off reporting if it can't be fixed.

> Found a problem when we are in low traffic with this patch.This will
> increase latency (i.e ping)
>
>
> So, we have to
>
> 	if (deficit < 0 || !aql_check) {
> 		if (txqi->schedule_round =3D=3D local->schedule_round[ac])
> 			// re-schedule

You mean, signal the driver to start over? But then you're just undoing
the check you just inserted here...


...and thinking about it a bit more, I don't actually think adding this
check is the right thing to do. As you've just discovered, the deficit
scheduler relies on the "goto begin" below (and thus being able to
keep spinning and increasing the deficit) to make progress. So if you
short-circuit that, you'll get blocking, but if you keep rotating the
queues for other reasons (like AQL does) you no longer get fairness.

Ultimately this comes from using two different sources of airtime:
predicted values (in AQL) and after-the-fact reporting (in the fairness
scheduler). There's a time lag between when these two values are
applied, which leads to the fairness scheduler insisting that a station
should be the next one to transmit even though AQL is blocking it.

Hmm, I wonder what would happen if we just accounted the AQL balance in
the fairness deficit as well? Something like the patch below
(compile-tested only). I'm not sure what the effect of running the
deficit backwards like this is; we may get weird oscillating values when
we subtract the AQL value and the "real" value hasn't been accounted
yet. But it may also turn out to not be a big issue; worth testing,
maybe?

The alternative would be to switch to using only the AQL values for
fairness as well; if the AQL predictions are reasonably accurate this
would likely work well enough. Got any idea how much they are off?

-Toke

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index ec6973ee88ef..86718a6429e6 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1893,12 +1893,10 @@ void ieee80211_sta_set_buffered(struct ieee80211_st=
a *pubsta,
 }
 EXPORT_SYMBOL(ieee80211_sta_set_buffered);
=20
-void ieee80211_sta_register_airtime(struct ieee80211_sta *pubsta, u8 tid,
-                                   u32 tx_airtime, u32 rx_airtime)
+static void __ieee80211_sta_register_airtime(struct ieee80211_local *local,
+                                            struct sta_info *sta, u8 ac,
+                                            u32 tx_airtime, u32 rx_airtime)
 {
-       struct sta_info *sta =3D container_of(pubsta, struct sta_info, sta);
-       struct ieee80211_local *local =3D sta->sdata->local;
-       u8 ac =3D ieee80211_ac_from_tid(tid);
        u32 airtime =3D 0;
=20
        if (sta->local->airtime_flags & AIRTIME_USE_TX)
@@ -1912,6 +1910,16 @@ void ieee80211_sta_register_airtime(struct ieee80211=
_sta *pubsta, u8 tid,
        sta->airtime[ac].deficit -=3D airtime;
        spin_unlock_bh(&local->active_txq_lock[ac]);
 }
+
+void ieee80211_sta_register_airtime(struct ieee80211_sta *pubsta, u8 tid,
+                                   u32 tx_airtime, u32 rx_airtime)
+{
+       struct sta_info *sta =3D container_of(pubsta, struct sta_info, sta);
+       struct ieee80211_local *local =3D sta->sdata->local;
+       u8 ac =3D ieee80211_ac_from_tid(tid);
+
+       __ieee80211_sta_register_airtime(local, sta, ac, tx_airtime, rx_air=
time);
+}
 EXPORT_SYMBOL(ieee80211_sta_register_airtime);
=20
 void ieee80211_sta_update_pending_airtime(struct ieee80211_local *local,
@@ -1924,9 +1932,11 @@ void ieee80211_sta_update_pending_airtime(struct iee=
e80211_local *local,
                return;
=20
        if (!tx_completed) {
-               if (sta)
+               if (sta) {
                        atomic_add(tx_airtime,
                                   &sta->airtime[ac].aql_tx_pending);
+                       __ieee80211_sta_register_airtime(local, sta, ac, tx=
_airtime, 0);
+               }
=20
                atomic_add(tx_airtime, &local->aql_total_pending_airtime);
                return;
@@ -1938,6 +1948,7 @@ void ieee80211_sta_update_pending_airtime(struct ieee=
80211_local *local,
                if (tx_pending < 0)
                        atomic_cmpxchg(&sta->airtime[ac].aql_tx_pending,
                                       tx_pending, 0);
+               __ieee80211_sta_register_airtime(local, sta, ac, -tx_airtim=
e, 0);
        }
=20
        tx_pending =3D atomic_sub_return(tx_airtime,
