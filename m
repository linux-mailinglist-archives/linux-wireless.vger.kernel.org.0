Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D079E13E6
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2019 10:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390050AbfJWISb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Oct 2019 04:18:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41463 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390020AbfJWISb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Oct 2019 04:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571818710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dMntyq5PwrRGYuBlSqIS68v6l8cP2AnXbgbvi15hVuk=;
        b=P3ZQmgX+oz2QuFPBKW2eHfkCOponbcbtHTJBmbcKW9XDQQ9Ammccehw0oBtDK94sVJHYNx
        pxzsbYF6KKxC9bipb8LZtv4Y5QDf4kuQLqPN5ANLIpET/5wfhU5FMMF2h8LHGUiADItPK+
        CzoDz1bJiwi9X6e/NlptWZU+u8SvquU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-KBkBOdOnNVG9nPyIY1dreQ-1; Wed, 23 Oct 2019 04:18:29 -0400
Received: by mail-lj1-f198.google.com with SMTP id p18so3479764ljn.1
        for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2019 01:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=mjD0o77t+Auvb/gyXdsPqzlJMhacg2DNPI9oug4KIck=;
        b=irQHUwLp6Nj4aClydpsn/J9POOG0NOsiuhwNsCher6ouQDjP+qvDRK77TiAXtnJ3vr
         CO8ymdwyWre+XlNHwnfrLR1u/NRzvAB9WXQ9GgHJYApNLntLVY12wmbeTZPZS69FqSAw
         wTDng3j7tbLnDmitejgT0JIHxWlrXPmMcGjRlaPHqG+xz6Y/XpXyNGZoeocUIpk7B5Tb
         l4aCd0mjQ37hT/nZ65rPIKtthiXaLF1i6IPrLzooR5Fx7S6QiCdiWc0S7LFlvrpY6+3z
         jTh+lLdNSM5nFsf+tn3m81Kw/EOaFUXYPRpuHBjLHBQrRILl1miu7Y0kUgc53O8XhHMn
         9+SA==
X-Gm-Message-State: APjAAAWGO1SXBU2baneNzBYMIxe1YXvc9x6P810MCNc5PG0sDlrvEIbI
        SUOAOGYZDVPSJw2eYGuDVbKFXiCQ9Ci8/kFkiFQqvTNA10hprfvPHme698oUa+slOXBl1qrNe/z
        KtWb4xUN4U9cOtmHMW1C22BTdbsw=
X-Received: by 2002:a05:6512:14c:: with SMTP id m12mr16498324lfo.55.1571818708098;
        Wed, 23 Oct 2019 01:18:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw12XisTXp0JsBXP+E7cCNIxoO+MzzPrZ7Xr0/1jqeHs1U4vCJ3uSTbpvcqmUMpilIGOTQtkA==
X-Received: by 2002:a05:6512:14c:: with SMTP id m12mr16498305lfo.55.1571818707910;
        Wed, 23 Oct 2019 01:18:27 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id x5sm12382584lfg.71.2019.10.23.01.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 01:18:27 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 65BE71804B1; Wed, 23 Oct 2019 10:18:26 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kan Yan <kyan@google.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        ath10k@lists.infradead.org, John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Subject: Re: [PATCH v4 4/4] mac80211: Use Airtime-based Queue Limits (AQL) on packet dequeue
In-Reply-To: <CA+iem5tZ95Jd9htLEdAJMubuFeWeUibK9MhTnTHLWNucX6_cRg@mail.gmail.com>
References: <157148503415.2989444.7391437309981941226.stgit@toke.dk> <157148503865.2989444.7118792679603045723.stgit@toke.dk> <CA+iem5sy16=xMZjJi1nKHrxP_xWHk-86G=ZLwtMMb04EOt5tQA@mail.gmail.com> <871rv5ovwr.fsf@toke.dk> <CA+iem5tZ95Jd9htLEdAJMubuFeWeUibK9MhTnTHLWNucX6_cRg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 23 Oct 2019 10:18:26 +0200
Message-ID: <87tv7znact.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: KBkBOdOnNVG9nPyIY1dreQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kan Yan <kyan@google.com> writes:

>> >> +               if (ieee80211_is_data_qos(hdr->frame_control)) {
>> >> +                       qc =3D ieee80211_get_qos_ctl(hdr);
>> >> +                       tid =3D qc[0] & 0xf;
>> >> +                       ac =3D ieee80211_ac_from_tid(tid);
>> >> +               } else {
>> >> +                       ac =3D IEEE80211_AC_BE;
>> >> +               }
>> >
>> > The tid/ac is incorrect either here or in __ieee80211_tx_status() when
>> > tested with ath10k. The ac is set to AC_BE with test done using BK
>> > class traffic, hence the pending airtime get updated for the wrong
>> > txq.
>>
>> Huh, well that won't do, obviously :)
>>
>> Any idea why it might be wrong?
>
> somehow  ieee80211_is_data_qos() returns false. Besides,  qos_control
> field doesn't seems to be set in ieee80211_build_hdr().
>
>> Hmm, I guess we could just get the ac using skb_get_queue_mapping().
>> I'll send an update with this fixed for you to try :)
> Thanks for the quick update. It is getting much better, but
> unfortunately the pending airtime accounting sometimes is still not
> correct and cause txq stuck occasionally.

OK, so that has to mean that there are packets getting dropped somewhere
without going through ieee80211_report_used_skb(). Assuming you're not
hitting the underflow warnings, just seeing the counter not get back
down to zero?

Could you see if you can find out if ath10k does that anywhere? I'll go
hunting in mac80211.

Looking for calls to kfree_skb() or kfree_skb_list() should hopefully
turn up something...

-Toke

