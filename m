Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44551DA9E7
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2019 12:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392702AbfJQKZ4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Oct 2019 06:25:56 -0400
Received: from mout.gmx.net ([212.227.17.22]:50793 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391295AbfJQKZ4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Oct 2019 06:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571307930;
        bh=fj0aLJL04Cljx/EpmdEme6rx3RiEH5WUSfHpYMZDfT0=;
        h=X-UI-Sender-Class:Subject:From:In-Reply-To:Date:Cc:References:To;
        b=d7Maz2zdelvOHhIMj06KtYMaH4EvMFW+64icEtphCK3eFraArN3mT5U5H4MvJR4r1
         OZ5+E9FB1XYPaZnTS6FCGBrNv4sSp22ImtGTzlEFvb97iy8N4MEyiXwzFSCYMVIdFY
         pGKwT4IpAMLc5GBAOtt0KzSoGwkb/xK6VAlktDN4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.11.12.33] ([134.76.241.253]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McpJq-1hmXQu1Q8o-00ZxFi; Thu, 17
 Oct 2019 12:25:30 +0200
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [Make-wifi-fast] [PATCH v2 4/4] mac80211: Use Airtime-based Queue
 Limits (AQL) on packet dequeue
From:   Sebastian Moeller <moeller0@gmx.de>
In-Reply-To: <87lftjfz51.fsf@toke.dk>
Date:   Thu, 17 Oct 2019 12:25:28 +0200
Cc:     Kan Yan <kyan@google.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Content-Transfer-Encoding: quoted-printable
Message-Id: <18FC6F1D-084C-44BD-87E7-C9F394D6FCD1@gmx.de>
References: <157115993755.2500430.12214017471129215800.stgit@toke.dk>
 <157115994190.2500430.14955682016008497593.stgit@toke.dk>
 <CA+iem5s=xbzZ5goaBO4tZWUKVQRaXb+SnB34NPCppej9mi8sAA@mail.gmail.com>
 <87o8yfg0zo.fsf@toke.dk> <751EA059-654B-4E06-A3D6-C727FE1FCE98@gmx.de>
 <87lftjfz51.fsf@toke.dk>
To:     =?utf-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Provags-ID: V03:K1:4B8f/OdHzKJ/N+8XhMSPAZY960RiNpZCT1OI8ogSGgfY6mN8+Si
 pSm8aCY8UQOBmIqYOoDXkzOWaYc5aOU26F8tXjHMjIDmVURn9PBJ+mGd0KN2xv3ePJX/j00
 d4b9voeXPPeFxP8NS2CwvT+7wfoTcBTa5tvaK3Y8guiCLcVQhWjU1CrUIKumAwlpDkIsDoE
 o+d/jMFpRRT2khTGPuw7w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ha0b/pNVEVg=:htOSqfPFchVJRPRpVyp0YT
 xYpuO7crTdnPvSF5+E3Jp2ZvgD96i6hXLGACBedYmM8/inXxVRkKFsFkAcUL7EFfpUUkp/QEw
 BgCo9pH7OJNpN0Xp4p9QKe2NuAfw6HC3yYNMMv1JayCrNS9omSpya6GH744KYOc5rSCXiK6aW
 4A4xxjDaG6N0n5luLp1kjZ57Oe3gPTgfOACvg/3tQjC3IEDZ11fNBv7bk8MmHnijPtVThmpqS
 FPn+PXpiRMk6YkfzNsAWxkuBRzxKh7/Qo7nHuJsq8pj43VdJLmggUXOs6Ov2Xtc6wv2rxFOaP
 smMdOFeLzOi5PIdr3bddBWW66bRAlsqOCu3Xywt6U14cLvc+TmAPZM0GeTC1hv7ewjoHVnJRj
 myxY5OMQ5erA+RxgtvVB3M1vZNUU1fy4YlNqdZR7CJlc9/94+ADy7PDOG/yabwiMGcFrcimBD
 WBjx+aZB4p165Hw2/WAO3zJmqETR9LYnxtyRsamE9zJhomWHs2djKEDqu2EQQpsikbjyy7ql0
 Gtz4Bnk9w0aVqDrZsAdjClB+jBqlCIBqQiSUGsxtlWQfh4sw0aXNQ16WQ+5cJmSwdcI9kbAj6
 tVWceuDwDMbYXrYgtikoxM7tqfp5H5Zy+0fF48/Ll3neFCLU/CIwW2cyQbWDNuCrjiE4WxUZe
 xg1/D4HE5bP0TQMLCxt9CG6vPVzYXMad2q6fCSLjVOBNGSmPO8xTfsLHNbdPN4uo0D7UHLUnP
 EDxqXEf/wOlUYyOhHsVk/iscUqKaoCUHJZLb9fxlH/s4bxcRreZbxBIaL9ZCMjG8o1wv19pKD
 WrSs9UKR4FFZQXXBB44gN3Cj9BMDbj9etqhtjh9nEzUDg2avRaRxZzqSUbm5DxMs0u3q/Wu6u
 wZF7pCB3vQIh8MwHpQQLWvFqL62duqFGLcDF9bcIw32EtY/Rkqn9daP+JNEgLtmJjsQ2LJob1
 5iyTeRhu/fOyY0mG9n6SfXMSl8CDZHMApo2PSlellWoUYxxiOHLy5h+NGH9Xuht7z6uQjaUob
 6WH9OoBF6XzyqTM7sch/+y4XYDj6B4cHS/yoRFqp8ciZI34xqzSU3IAJnqXIAUXQpsJLfgqMR
 s/1Evo6afyJsbz6LQT7JFtpPS12Uk85pB/VvgoBnpNnLKojy4NlfuV1xrmpC6OX7OJdIV6Iit
 hQYf/Teq566wX7aITCQ9Y8zV/Di+NgAVJdXrQ5jhBWZFr99tp5sfIYbFilNj14hHIMcckX0W0
 zbelhnTYOEYz4/xhikc8LGFfE7zOMgCr1c35AUlsp/LHzUnCzuBHhkOdlPR4=
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

What about VLAN tags?

Best Regards
	Sebastian

> On Oct 17, 2019, at 12:24, Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
>=20
> Sebastian Moeller <moeller0@gmx.de> writes:
>=20
>>> On Oct 17, 2019, at 11:44, Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
>>>=20
>>> Kan Yan <kyan@google.com> writes:
>>>=20
>>>> Hi Toke,
>>>>=20
>>>> Thanks for getting this done! I will give it a try in the next few
>>>> days.  A few comments:
>>>>=20
>>>>> The estimated airtime for each skb is stored in the tx_info, so we =
can
>>>>> subtract the same amount from the running total when the skb is =
freed or
>>>>> recycled.
>>>>=20
>>>> Looks like ath10k driver zero out the info->status before calling
>>>> ieee80211_tx_status(...):
>>>> int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
>>>>                        const struct htt_tx_done *tx_done)
>>>> {
>>>> ...
>>>>       info =3D IEEE80211_SKB_CB(msdu);
>>>>       memset(&info->status, 0, sizeof(info->status));
>>>> ...
>>>>       ieee80211_tx_status(htt->ar->hw, msdu);
>>>> }
>>>=20
>>> Ah, bugger; I was afraid we'd run into this. A quick grep indicates =
that
>>> it's only ath10k and iwl that do this, though, so it's probably
>>> manageable to just fix this. I think the simplest solution is just =
to
>>> restore the field after clearing, no?
>>>=20
>>>> We need either restore the info->status.tx_time_est or calling
>>>> ieee80211_sta_update_pending_airtime() in ath10k before tx_time_est
>>>> get erased.
>>>>=20
>>>>> +       if (local->airtime_flags & AIRTIME_USE_AQL) {
>>>>> +               airtime =3D ieee80211_calc_expected_tx_airtime(hw, =
vif, txq->sta,
>>>>> +                                                            =
skb->len + 38);
>>>>=20
>>>> I think it is better to put the "+  38" that takes care of the =
header
>>>> overhead inside ieee80211_calc_expected_tx_airtime().
>>>=20
>>> Hmm, no strong opinion about this; but yeah, since we have a =
dedicated
>>> function for this use I guess there's no harm in adding it there :)
>>>=20
>>=20
>> Silly question, is this Overhead guaranteed to be 38 Bytes for all
>> eternity? Otherwise a variable or a preprocessor constant might be
>> more future proof?
>=20
> Well, yeah, as long as we're sending Ethernet packets. Which is kinda
> baked into the WiFi standard :)
>=20
> -Toke

