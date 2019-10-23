Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFA8E1253
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2019 08:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387662AbfJWGmB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Oct 2019 02:42:01 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45226 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732574AbfJWGmA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Oct 2019 02:42:00 -0400
Received: by mail-lj1-f195.google.com with SMTP id q64so19772945ljb.12
        for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2019 23:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xLzPgNOZ8X14gfCEvYWsxDF01OFUZfoQjcWDyuoGltc=;
        b=LJWHaiQc/q6Hg9z63NPV0MjMzWfOhKO0ey++fb4OkDyjZxD45pVUtUWBaO1/A2Qw2d
         RJd7oMRFkK9acDzP60fuBo6rXfXFDBhRQNsaSsYvkYETY+Y//R9nqZUBljNNONlm2JRJ
         fA/4lfnnSbauy8m0CvVAUs+97DA1Lf3yvlh2Ek0wox9gA1zBdoGbHsm6eJ5bUAmzQbNq
         +CZzAgGbM6Pffjp8WhndhgV/FPWBbAZP77u09c6zMgkfR77ity9Rx2DfjWwUpJsmAL1g
         TDWItxlH08H4EGtDcM+O35SFI3kDJZEl/vvqCBaLjWr7MkbwhQW3690smPgjvwVTpcrg
         pThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xLzPgNOZ8X14gfCEvYWsxDF01OFUZfoQjcWDyuoGltc=;
        b=iiql63sHnL/5Fv8tP4TC4Jq4Xe4CYVeEOh1ohQntSX1fvMfFbu7DnViIfsrsdQNsCS
         hReGsCdLn8iPUCZVxaEmp3Mi0bXcQEQpJN7SRPeD8jTyzSwFRZ1hHqMB4pycxvwVSvDm
         MyrBCRylEuUNWitGipP9dqgIK2oohnE1FbKKduJVi58yUxK0RiI6fcivGMEHCjhOZCGR
         7xtDotwjKxBHqsV+Q2GsywhIChY/C/LHCHi4N6OWx1FwLEdeVaDqimcUPnlA4DjSb8Pr
         8zkNI+pphIyypHQ+5I3bOJ0lfrUCj0kaxLPY8mC21o9C9XN2aOEHnNxI/KncEA+sRWi7
         Qe9Q==
X-Gm-Message-State: APjAAAXyUs5OU2PZiiLUTGaKYhZlDiyU58g/kvxmxZiLRsMVHzQEAtpR
        cjr9pDr8NTaIqfsk/fTTiwRtb2nFOOUc8ISuE2qMGg==
X-Google-Smtp-Source: APXvYqwbYShriZrtOfH5CKHMRI9ZjT56L9KXRHcmYVKve8FvpLfX1msZDukO1Wkvr96pb24xb7V1qDQkpFKWU15F9BQ=
X-Received: by 2002:a2e:9759:: with SMTP id f25mr21512398ljj.173.1571812918369;
 Tue, 22 Oct 2019 23:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <157148503415.2989444.7391437309981941226.stgit@toke.dk>
 <157148503865.2989444.7118792679603045723.stgit@toke.dk> <CA+iem5sy16=xMZjJi1nKHrxP_xWHk-86G=ZLwtMMb04EOt5tQA@mail.gmail.com>
 <871rv5ovwr.fsf@toke.dk>
In-Reply-To: <871rv5ovwr.fsf@toke.dk>
From:   Kan Yan <kyan@google.com>
Date:   Tue, 22 Oct 2019 23:41:47 -0700
Message-ID: <CA+iem5tZ95Jd9htLEdAJMubuFeWeUibK9MhTnTHLWNucX6_cRg@mail.gmail.com>
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

> >> +               if (ieee80211_is_data_qos(hdr->frame_control)) {
> >> +                       qc =3D ieee80211_get_qos_ctl(hdr);
> >> +                       tid =3D qc[0] & 0xf;
> >> +                       ac =3D ieee80211_ac_from_tid(tid);
> >> +               } else {
> >> +                       ac =3D IEEE80211_AC_BE;
> >> +               }
> >
> > The tid/ac is incorrect either here or in __ieee80211_tx_status() when
> > tested with ath10k. The ac is set to AC_BE with test done using BK
> > class traffic, hence the pending airtime get updated for the wrong
> > txq.
>
> Huh, well that won't do, obviously :)
>
> Any idea why it might be wrong?

somehow  ieee80211_is_data_qos() returns false. Besides,  qos_control
field doesn't seems to be set in ieee80211_build_hdr().

> Hmm, I guess we could just get the ac using skb_get_queue_mapping().
> I'll send an update with this fixed for you to try :)
Thanks for the quick update. It is getting much better, but
unfortunately the pending airtime accounting sometimes is still not
correct and cause txq stuck occasionally.





On Tue, Oct 22, 2019 at 4:35 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Kan Yan <kyan@google.com> writes:
>
> >> +               if (ieee80211_is_data_qos(hdr->frame_control)) {
> >> +                       qc =3D ieee80211_get_qos_ctl(hdr);
> >> +                       tid =3D qc[0] & 0xf;
> >> +                       ac =3D ieee80211_ac_from_tid(tid);
> >> +               } else {
> >> +                       ac =3D IEEE80211_AC_BE;
> >> +               }
> >
> > The tid/ac is incorrect either here or in __ieee80211_tx_status() when
> > tested with ath10k. The ac is set to AC_BE with test done using BK
> > class traffic,  hence the pending airtime get updated for the wrong
> > txq.
>
> Hmm, I guess we could just get the ac using skb_get_queue_mapping().
> I'll send an update with this fixed for you to try :)
>
> -Toke
>
