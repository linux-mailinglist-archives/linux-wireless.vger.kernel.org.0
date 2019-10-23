Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5B4E16A5
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2019 11:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390226AbfJWJwL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Oct 2019 05:52:11 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34672 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390079AbfJWJwK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Oct 2019 05:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571824329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/5Gd+sGRTLO/YyPTwPaFlOWjYLG6/P4AaU01cq86LiI=;
        b=YkCfPhtK65HdFTThn4pUhr48kpBIXpSp/fQw8GjnhPdYo9mBdf6WgGvC+k1PFHn9K7tHY6
        uhldKkVRNyNULWI0WIUiEqdHeLFgSSeHAi5iq2YxS0UWuBNpg/+UXb7m+qSkUneq7tGbJR
        oY+/9dsJuJyEIji/CTlBGT9BZS8P/Kc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-3N2xuw_eMzGTuH6hOdXGRw-1; Wed, 23 Oct 2019 05:52:06 -0400
Received: by mail-lf1-f69.google.com with SMTP id v204so2208778lfa.0
        for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2019 02:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=hFVDZODcV1pnEtDDIb8UrMv3iIHS2UTtEmv96KMbc7k=;
        b=UDzZjFxZRRXvtVDw3bvZQiu9n6LvMHk3XPYKS24b6j9htu7aj2/Kbg5URT+yLXEQ+U
         7GFxNXL6g9IHvbMnImJA8gdDcD9XujEA+m8QNlcknDFVCH0LSTSIA+jkYAZu16zTVD0y
         K/yWfUoFhQz9GSvAMg/2W1UKiZ56f9s9ZS6TaQ859qE8C4AU4lkkrkmyMrhLhA3GJV7l
         2IwJZhO3SusZeYwjImzVmzN+Owk0Ld/5n39KvfgiLtUYg6x8rPmXg1+nEFk83Ipm48gs
         i6E4CxAUg02EdGE65uywKLMEgzyKbLEkQJ880pVBW06zYDl5UJNJ3SmVaR51n0XVCToY
         cRGw==
X-Gm-Message-State: APjAAAUHrY2VuKbXUIXllgGbc4MsRq+ynr0P5pcVIEpcLHoOIYSIOcX8
        qexXbjlPBfcrZKQPhaIka6srqMSLREeBlnwnLD+/sMaB9MEvSiBpE1s22X9aCmkeWYb3vuwpvCm
        MHE9yGd7u4Xr84/OvwNsbSj1MMQQ=
X-Received: by 2002:a2e:9107:: with SMTP id m7mr6003963ljg.113.1571824324909;
        Wed, 23 Oct 2019 02:52:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwfTq6OyuPRjrUqdJ+q6pELeZDh85Gk4HQhTKpMvjbXzGrJtsr2TVw1Ipp+RRdcPFqc3KuU/w==
X-Received: by 2002:a2e:9107:: with SMTP id m7mr6003952ljg.113.1571824324735;
        Wed, 23 Oct 2019 02:52:04 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id u24sm5939167ljl.64.2019.10.23.02.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 02:52:03 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C05CD1804B1; Wed, 23 Oct 2019 11:52:02 +0200 (CEST)
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
In-Reply-To: <87tv7znact.fsf@toke.dk>
References: <157148503415.2989444.7391437309981941226.stgit@toke.dk> <157148503865.2989444.7118792679603045723.stgit@toke.dk> <CA+iem5sy16=xMZjJi1nKHrxP_xWHk-86G=ZLwtMMb04EOt5tQA@mail.gmail.com> <871rv5ovwr.fsf@toke.dk> <CA+iem5tZ95Jd9htLEdAJMubuFeWeUibK9MhTnTHLWNucX6_cRg@mail.gmail.com> <87tv7znact.fsf@toke.dk>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 23 Oct 2019 11:52:02 +0200
Message-ID: <87lftbn60t.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: 3N2xuw_eMzGTuH6hOdXGRw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

> Kan Yan <kyan@google.com> writes:
>
>>> >> +               if (ieee80211_is_data_qos(hdr->frame_control)) {
>>> >> +                       qc =3D ieee80211_get_qos_ctl(hdr);
>>> >> +                       tid =3D qc[0] & 0xf;
>>> >> +                       ac =3D ieee80211_ac_from_tid(tid);
>>> >> +               } else {
>>> >> +                       ac =3D IEEE80211_AC_BE;
>>> >> +               }
>>> >
>>> > The tid/ac is incorrect either here or in __ieee80211_tx_status() whe=
n
>>> > tested with ath10k. The ac is set to AC_BE with test done using BK
>>> > class traffic, hence the pending airtime get updated for the wrong
>>> > txq.
>>>
>>> Huh, well that won't do, obviously :)
>>>
>>> Any idea why it might be wrong?
>>
>> somehow  ieee80211_is_data_qos() returns false. Besides,  qos_control
>> field doesn't seems to be set in ieee80211_build_hdr().
>>
>>> Hmm, I guess we could just get the ac using skb_get_queue_mapping().
>>> I'll send an update with this fixed for you to try :)
>> Thanks for the quick update. It is getting much better, but
>> unfortunately the pending airtime accounting sometimes is still not
>> correct and cause txq stuck occasionally.
>
> OK, so that has to mean that there are packets getting dropped somewhere
> without going through ieee80211_report_used_skb(). Assuming you're not
> hitting the underflow warnings, just seeing the counter not get back
> down to zero?
>
> Could you see if you can find out if ath10k does that anywhere? I'll go
> hunting in mac80211.
>
> Looking for calls to kfree_skb() or kfree_skb_list() should hopefully
> turn up something...

Aha! Turns out I was doing the sta lookup completely wrong in
ieee80211_report_used_skb(); so anything frames that were dropped and
went through there would not get its airtime subtracted correctly. Will
send a v6 with a fix :)

-Toke

