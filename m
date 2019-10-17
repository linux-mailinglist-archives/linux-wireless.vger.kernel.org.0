Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF87DA979
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2019 11:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439549AbfJQJ6H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Oct 2019 05:58:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:44817 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393881AbfJQJ6H (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Oct 2019 05:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571306259;
        bh=r0X83n+I3P0JzGYWN7EBmaDwAvoICtNlno+n3xjeVXg=;
        h=X-UI-Sender-Class:Subject:From:In-Reply-To:Date:Cc:References:To;
        b=LgB3dpGwIrXUfgBGMNqpjZLP3uIDAeevzUNUv05Hhp4yZDEaxLbbu52nXUbccve18
         UYH9uoTEXbVdc1/Q3wF5s3MNWRyVl97WTaiWSBMd9/HMCXRpPOxqKNBpkLlUjEhPLz
         tmoiZKyX9P3gHLtlYrpw5gIvKG4inW1FtgEuNncY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.11.12.33] ([134.76.241.253]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsYux-1i2GGe2OQl-00u5E0; Thu, 17
 Oct 2019 11:57:39 +0200
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [Make-wifi-fast] [PATCH v2 4/4] mac80211: Use Airtime-based Queue
 Limits (AQL) on packet dequeue
From:   Sebastian Moeller <moeller0@gmx.de>
In-Reply-To: <87o8yfg0zo.fsf@toke.dk>
Date:   Thu, 17 Oct 2019 11:57:36 +0200
Cc:     Kan Yan <kyan@google.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>,
        make-wifi-fast@lists.bufferbloat.net,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Content-Transfer-Encoding: quoted-printable
Message-Id: <751EA059-654B-4E06-A3D6-C727FE1FCE98@gmx.de>
References: <157115993755.2500430.12214017471129215800.stgit@toke.dk>
 <157115994190.2500430.14955682016008497593.stgit@toke.dk>
 <CA+iem5s=xbzZ5goaBO4tZWUKVQRaXb+SnB34NPCppej9mi8sAA@mail.gmail.com>
 <87o8yfg0zo.fsf@toke.dk>
To:     =?utf-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Provags-ID: V03:K1:aPvGsXTJoLp79eXyZQgtYx6V2rsHlhkZQUXEDzqSfnRUsXX1voi
 4fXbxehMwFhlhEakCcT4//VKTg79SzVmZjJNVswMa5fBK7cq8AYOROHKe/YTtC+Z3tcXyxS
 L+VwaJbaC5rhQ8LNvzRu2jLOW6hkIpc+bwn7RfnzRnI0NpAjw6Q3aXYHPD/aycmLCcjmG4K
 I4yXHqC7YDNPv9/7yQcog==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qnl/WNGe1/A=:6veXLPY1zNodt9uhjHOkQV
 BTS7PlO6ZuDJ9SyKve4tWCAlNtmHgAbReCu5SlbhbvNpXwlT1Hy+ogEpPYG+0a4YNHduBPff/
 O3ycrKVeg+LtXJF2dn7414esUX0wqZksHAHa25bseOU3/nTBYuinB9PBuL0jn/WhDOPGJpPHp
 22EqFziB4XLXrsQ3Kry00ccenwN3j3VD67IoP0oqNe8bXN8krm+bMjRjdMUXgBe1RfUKUyBeq
 /BtWyb7BZaPlKwOsAztF67sLns+74lubEPfYv5/tfTd97cwZjedIg7ZtPY+SgjvA+3fKaq8UT
 tF/mlU4zZgiS+Ky9Jhz/XfPquvOhtDS0vlsvx63SlJ0IOYy14wllJ+abl+YQ8ShiM8/uzwfaw
 nYhQpftWa33CODrvc9DRPzthtDBJyksm1QL3mktQrB6OFooih2I8mkCtVBlRqyd6aKNnUMvI0
 3QGt9a/GF/5V73GhxuEDuxT6UHEFKgWRkjSGHhCBu6hELjgb3TBW3QVzM67Pms5BiO1+z7fiv
 W0b4DHsuY3il9uMsJDLonRdkbXQs/JE93ttfb+iH+R+VoUjmAu5jCol6i9SwMtqyDWEo6cm7i
 M+KE2cCgkS/64COIiBn5yBJDJnpQeJ6np1hOsq5gXY3o/EVBurqHh8ex8baR7pXDAm5VuZ2eN
 a1fv7WWDDYpmYnFn4Y5hP3zonfz4191XhI8HdT/Lwp1nodMllKaIFkyGvwgd0CMmpL7WiO9fz
 s3fgWkAJ+XRlYcR+5hIRagup71p6Brm8E1KDrjS69Hselve2KImm5nWrZXPCkXs+YLwNNa4I4
 cGssYWEVy6A1SjyKMHwQlaeFSfcoAZazh9Ihx3w0TopowNsyM/M2tCgZuo9hByEMhxdKcjjZl
 MPwkqBmyjnEPH1qx3Z5U2RAznDENtf5TwqEqWk3BzUqe3KbyDV7hj2kGQzonnfKUpsFA8oGRU
 bxPxvd0oyoJrtAhnFyVLH+HNgXW7GX8FUws7pB30eqehAt6nQaiql0klnyxrwDjpVcxzmFSW7
 RdaJi+wpm1qL4eWstIOyYG24Hx/csuKpz0/Wa0rKOyaGWU0qDApovquu2JyiCchOTEcxTpXGq
 9oKKb3DA6aZ03gEzSwrVOFc0p3ayRtTiezn1IZKBu6NAxHYYQWoGJIYCAqZ424ofgk/njwx+e
 jjMsIdHkfZVfab9LhaHZxm0Wugf9odTEokXDF2RH1sMn3UtMDj6QHzuyTJ9kzgIZx5NExL9rw
 GqlRcGcZl8zuBWoBDwPnEqiWzOZrV+dk3Lm0Ol4fHpu6ZWEfbt45DLrEfmCA=
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> On Oct 17, 2019, at 11:44, Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
>=20
> Kan Yan <kyan@google.com> writes:
>=20
>> Hi Toke,
>>=20
>> Thanks for getting this done! I will give it a try in the next few
>> days.  A few comments:
>>=20
>>> The estimated airtime for each skb is stored in the tx_info, so we =
can
>>> subtract the same amount from the running total when the skb is =
freed or
>>> recycled.
>>=20
>> Looks like ath10k driver zero out the info->status before calling
>> ieee80211_tx_status(...):
>> int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
>>                         const struct htt_tx_done *tx_done)
>> {
>> ...
>>        info =3D IEEE80211_SKB_CB(msdu);
>>        memset(&info->status, 0, sizeof(info->status));
>> ...
>>        ieee80211_tx_status(htt->ar->hw, msdu);
>> }
>=20
> Ah, bugger; I was afraid we'd run into this. A quick grep indicates =
that
> it's only ath10k and iwl that do this, though, so it's probably
> manageable to just fix this. I think the simplest solution is just to
> restore the field after clearing, no?
>=20
>> We need either restore the info->status.tx_time_est or calling
>> ieee80211_sta_update_pending_airtime() in ath10k before tx_time_est
>> get erased.
>>=20
>>> +       if (local->airtime_flags & AIRTIME_USE_AQL) {
>>> +               airtime =3D ieee80211_calc_expected_tx_airtime(hw, =
vif, txq->sta,
>>> +                                                            =
skb->len + 38);
>>=20
>> I think it is better to put the "+  38" that takes care of the header
>> overhead inside ieee80211_calc_expected_tx_airtime().
>=20
> Hmm, no strong opinion about this; but yeah, since we have a dedicated
> function for this use I guess there's no harm in adding it there :)
>=20

Silly question, is this Overhead guaranteed to be 38 Bytes for all =
eternity? Otherwise a variable or a preprocessor constant might be more =
future proof?

Best Regards
	Sebastian


> -Toke
>=20
> _______________________________________________
> Make-wifi-fast mailing list
> Make-wifi-fast@lists.bufferbloat.net
> https://lists.bufferbloat.net/listinfo/make-wifi-fast

