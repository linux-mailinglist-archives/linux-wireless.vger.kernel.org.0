Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 022F6E1FA6
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2019 17:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406841AbfJWPnQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Oct 2019 11:43:16 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39983 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404173AbfJWPnQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Oct 2019 11:43:16 -0400
Received: by mail-lj1-f195.google.com with SMTP id u22so3626818lji.7
        for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2019 08:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Wf7cqgLpHpMCfHDTso2mEEg6iVGE1A3AlSMCK0EZOvI=;
        b=MeL78PzzFc4GWTGjttUER3eajJiHAfiXzG8G1Xek8riNLS0Akb3EyaIF8kCjplCBvC
         e8PdIOrGlpPr64UiYnljhSyeNwzpyq1+SmkBqsKNqfnIjx/7/WUm7V18gqSZfq6qXpjy
         HSSFn0i5dZw0hwcdKmrjoc8j36P/bg/LP5qNws123c15xYetsbls2kJVLs9fGDiHpzTp
         NTAbYCE9/adTig9wIUFJSciEu5YjcNmNc29oi5wz79zXLWWwMOEF2YCmKSle0etLBDjV
         RPybKBRkcQRNKCdFp6+vsH/DZ/Jg6//ynFzwearQSIDF3fO2sX+/o3KRHWOwcJvzxVXH
         952A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Wf7cqgLpHpMCfHDTso2mEEg6iVGE1A3AlSMCK0EZOvI=;
        b=SJZ9GgBg/fZvB37fxzt12SQI1/+1tfSOR8mKZjWZDObanprHTKbFjqkIidfQasPXpC
         ochDJbSnaUHluHrbcOtQVmQ2pqAK60Q2eAycPHaQzvSp/dsvqnGIhb7y6Y1LyLtCMUx8
         ZTEaiZfO0o/emMRqOildf5N1bOprcwGLbHhPXLCWm8Uc/j6/efT01CBueqaUbPl/1Byi
         NjvYduJ3gKl/6vVT7YIaMXx10zzL5Sejts9LGCvDBumqME1iUg2E4FinitKzuLw0swfq
         My5KV+e5CuTFcZPkp/d8acedVvoilu7r5cE+E5FeM68MC1C4GqNqFiV6ppwQcqyAw2Yc
         E3Kg==
X-Gm-Message-State: APjAAAVMhnhc/1HTdjxoaaTHpVtdARsxN27HumHWSYhbr/LQpeAzM8SG
        zdOblfGZyoh8+cVzMBwMEJMUXnmp/8fiCv17A58cVA==
X-Google-Smtp-Source: APXvYqx3Qvv4PHdZrvwXrE+LY1lvoApw+SX5kuGkePq0Hg3y9W9edqODxW4WERwR4EtQWzHdvirS2CmRTMj3y2hm1yI=
X-Received: by 2002:a05:651c:326:: with SMTP id b6mr7678893ljp.119.1571845394424;
 Wed, 23 Oct 2019 08:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <157148503415.2989444.7391437309981941226.stgit@toke.dk>
 <157148503865.2989444.7118792679603045723.stgit@toke.dk> <CA+iem5sy16=xMZjJi1nKHrxP_xWHk-86G=ZLwtMMb04EOt5tQA@mail.gmail.com>
 <871rv5ovwr.fsf@toke.dk> <CA+iem5tZ95Jd9htLEdAJMubuFeWeUibK9MhTnTHLWNucX6_cRg@mail.gmail.com>
 <87tv7znact.fsf@toke.dk> <87lftbn60t.fsf@toke.dk>
In-Reply-To: <87lftbn60t.fsf@toke.dk>
From:   Kan Yan <kyan@google.com>
Date:   Wed, 23 Oct 2019 08:43:03 -0700
Message-ID: <CA+iem5tbSFyY0pS5Ufb8Ch=y3UGR_iuX_8ao9=2iS05-MozQwA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] mac80211: Use Airtime-based Queue Limits (AQL) on
 packet dequeue
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        ath10k@lists.infradead.org, John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Aha! Turns out I was doing the sta lookup completely wrong in
> ieee80211_report_used_skb(); so anything frames that were dropped and
> went through there would not get its airtime subtracted correctly. Will
> send a v6 with a fix :)

Awesome, thanks! That looks very promising.  The symptom I see with
previous patch is the interface's pending airtime count looks fine,
but the station's airtime get wrong, either due to airtime is credited
to the wrong station or wrong AC.

On Wed, Oct 23, 2019 at 2:52 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>
> > Kan Yan <kyan@google.com> writes:
> >
> >>> >> +               if (ieee80211_is_data_qos(hdr->frame_control)) {
> >>> >> +                       qc =3D ieee80211_get_qos_ctl(hdr);
> >>> >> +                       tid =3D qc[0] & 0xf;
> >>> >> +                       ac =3D ieee80211_ac_from_tid(tid);
> >>> >> +               } else {
> >>> >> +                       ac =3D IEEE80211_AC_BE;
> >>> >> +               }
> >>> >
> >>> > The tid/ac is incorrect either here or in __ieee80211_tx_status() w=
hen
> >>> > tested with ath10k. The ac is set to AC_BE with test done using BK
> >>> > class traffic, hence the pending airtime get updated for the wrong
> >>> > txq.
> >>>
> >>> Huh, well that won't do, obviously :)
> >>>
> >>> Any idea why it might be wrong?
> >>
> >> somehow  ieee80211_is_data_qos() returns false. Besides,  qos_control
> >> field doesn't seems to be set in ieee80211_build_hdr().
> >>
> >>> Hmm, I guess we could just get the ac using skb_get_queue_mapping().
> >>> I'll send an update with this fixed for you to try :)
> >> Thanks for the quick update. It is getting much better, but
> >> unfortunately the pending airtime accounting sometimes is still not
> >> correct and cause txq stuck occasionally.
> >
> > OK, so that has to mean that there are packets getting dropped somewher=
e
> > without going through ieee80211_report_used_skb(). Assuming you're not
> > hitting the underflow warnings, just seeing the counter not get back
> > down to zero?
> >
> > Could you see if you can find out if ath10k does that anywhere? I'll go
> > hunting in mac80211.
> >
> > Looking for calls to kfree_skb() or kfree_skb_list() should hopefully
> > turn up something...
>
> Aha! Turns out I was doing the sta lookup completely wrong in
> ieee80211_report_used_skb(); so anything frames that were dropped and
> went through there would not get its airtime subtracted correctly. Will
> send a v6 with a fix :)
>
> -Toke
>
