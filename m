Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B508DBB3D
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2019 03:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409258AbfJRBLn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Oct 2019 21:11:43 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42240 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392283AbfJRBLn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Oct 2019 21:11:43 -0400
Received: by mail-lj1-f194.google.com with SMTP id y23so4430543lje.9
        for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2019 18:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QC1w77VZRCYH8hERen99ZGhUOT4e8Ag48k7m9duGNJo=;
        b=piwlDLGZJ2Cjg5TDHivlsZpECNNmqLdCMmpZe1A4OcvQGqGztVVdfZIoEsk2tzKBgG
         cqN1SN9tDlPEInQP+Wg+3bioBjX81z7HujES5bQqRNbJRlhpOAfYRmINYj2JZBy4BoZb
         lkB14g86Hlt2Egqoxtt6boWW2eC8CM2mM/t3dHyV2Mi4fxkKV8KZBS0qi6XN13Ao7KMQ
         NqXNHLBPSeGSfsGT1m7+lMWCnjKej/rZFZrBcR7TjHqvWhdhQIhsgssTGFlmp6E9Mms6
         9mMTeWdc8HUzKJDFeuQzaedaCXEOq8uyjevAz24XCkzhPN38yhCzDu7OCe3jGIx9GQU4
         DAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QC1w77VZRCYH8hERen99ZGhUOT4e8Ag48k7m9duGNJo=;
        b=I3jE1J5q0mHVyaEdjuap54fL35eWantJ4O3EszCzfa56VCA7uYBgU38jo640Bu/ou8
         o/r3tFF/0E1oTr/RQvp9pHCJSIPJpG3i2O4Un6ScdKIM3915gPLicbxd3LKI0e7gm7ln
         Rw646OMwWoaomtaBJ0EtyQWnuiRU9t5lM/4qjWK1cJWX8cWFxWSltL98WG+uobRNMLuW
         4gbW+NMUBczVx8z35K+fjUkBx2BH/O8IjPke7NTy2dBJvsq6FVyiRQR1acldWINjz/en
         /ZLfeub5zkKcYnDyLRr9GoQ1rDb1eOsvkKUnDinZYtn5PgR8XlEJ8HWh2qrLlo7D5cuF
         +zOQ==
X-Gm-Message-State: APjAAAXytnQ6PAKCtRUYQ64OXvvZgJByldkEbUyenmwz1+ME7LgB5sj9
        s5AzlyejwWVa3uZ3I/1hatNu1ZE+dyG9sWCpZoPKGw==
X-Google-Smtp-Source: APXvYqxckgV4ZGs3rGfnunRJYCJMzCOaIPPUPpsiIF3aa1tlLcfzaUqCsmN9gDIs18anyfHar+FxQrohUwR2xwC3gn0=
X-Received: by 2002:a05:651c:112e:: with SMTP id e14mr4200386ljo.193.1571361100416;
 Thu, 17 Oct 2019 18:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <157115993755.2500430.12214017471129215800.stgit@toke.dk>
 <157115994190.2500430.14955682016008497593.stgit@toke.dk> <CA+iem5s=xbzZ5goaBO4tZWUKVQRaXb+SnB34NPCppej9mi8sAA@mail.gmail.com>
 <87o8yfg0zo.fsf@toke.dk> <751EA059-654B-4E06-A3D6-C727FE1FCE98@gmx.de>
 <87lftjfz51.fsf@toke.dk> <18FC6F1D-084C-44BD-87E7-C9F394D6FCD1@gmx.de>
In-Reply-To: <18FC6F1D-084C-44BD-87E7-C9F394D6FCD1@gmx.de>
From:   Kan Yan <kyan@google.com>
Date:   Thu, 17 Oct 2019 18:11:29 -0700
Message-ID: <CA+iem5v-K0pA9WLfDNxBKVjufgH=2MeuGmV0aDJysLT8jdawAQ@mail.gmail.com>
Subject: Re: [Make-wifi-fast] [PATCH v2 4/4] mac80211: Use Airtime-based Queue
 Limits (AQL) on packet dequeue
To:     Sebastian Moeller <moeller0@gmx.de>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I don't think it is hard to take care of extra header size for frames
with VLAN tags, but the question is how far are we willing to go down
this rabbit hole. There are other factors like retries and aggregation
that are difficult to be taken into account. However, I doubt that
matters, a ballpark estimate of airtime is sufficient for the purpose
of implementing a queue limit.

On Thu, Oct 17, 2019 at 3:25 AM Sebastian Moeller <moeller0@gmx.de> wrote:
>
> What about VLAN tags?
>
> Best Regards
>         Sebastian
>
> > On Oct 17, 2019, at 12:24, Toke H=C3=B8iland-J=C3=B8rgensen <toke@redha=
t.com> wrote:
> >
> > Sebastian Moeller <moeller0@gmx.de> writes:
> >
> >>> On Oct 17, 2019, at 11:44, Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
> >>>
> >>> Kan Yan <kyan@google.com> writes:
> >>>
> >>>> Hi Toke,
> >>>>
> >>>> Thanks for getting this done! I will give it a try in the next few
> >>>> days.  A few comments:
> >>>>
> >>>>> The estimated airtime for each skb is stored in the tx_info, so we =
can
> >>>>> subtract the same amount from the running total when the skb is fre=
ed or
> >>>>> recycled.
> >>>>
> >>>> Looks like ath10k driver zero out the info->status before calling
> >>>> ieee80211_tx_status(...):
> >>>> int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
> >>>>                        const struct htt_tx_done *tx_done)
> >>>> {
> >>>> ...
> >>>>       info =3D IEEE80211_SKB_CB(msdu);
> >>>>       memset(&info->status, 0, sizeof(info->status));
> >>>> ...
> >>>>       ieee80211_tx_status(htt->ar->hw, msdu);
> >>>> }
> >>>
> >>> Ah, bugger; I was afraid we'd run into this. A quick grep indicates t=
hat
> >>> it's only ath10k and iwl that do this, though, so it's probably
> >>> manageable to just fix this. I think the simplest solution is just to
> >>> restore the field after clearing, no?
> >>>
> >>>> We need either restore the info->status.tx_time_est or calling
> >>>> ieee80211_sta_update_pending_airtime() in ath10k before tx_time_est
> >>>> get erased.
> >>>>
> >>>>> +       if (local->airtime_flags & AIRTIME_USE_AQL) {
> >>>>> +               airtime =3D ieee80211_calc_expected_tx_airtime(hw, =
vif, txq->sta,
> >>>>> +                                                            skb->l=
en + 38);
> >>>>
> >>>> I think it is better to put the "+  38" that takes care of the heade=
r
> >>>> overhead inside ieee80211_calc_expected_tx_airtime().
> >>>
> >>> Hmm, no strong opinion about this; but yeah, since we have a dedicate=
d
> >>> function for this use I guess there's no harm in adding it there :)
> >>>
> >>
> >> Silly question, is this Overhead guaranteed to be 38 Bytes for all
> >> eternity? Otherwise a variable or a preprocessor constant might be
> >> more future proof?
> >
> > Well, yeah, as long as we're sending Ethernet packets. Which is kinda
> > baked into the WiFi standard :)
> >
> > -Toke
>
