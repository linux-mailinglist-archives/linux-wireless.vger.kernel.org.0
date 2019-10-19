Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 519BCDD865
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Oct 2019 13:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbfJSLNG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Oct 2019 07:13:06 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31686 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725883AbfJSLNF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Oct 2019 07:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571483583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WoX9rczeRjvya0vnh4YYflEgbgCXdBdatjIIvrFPWu0=;
        b=Y8vkzNLKbQGMa2euHCJRTV4d0MXSbadNwg0QNuJEl7DXmNql7OzXa+WlER3QdYXH3EcyN3
        6x+KRPdhu0nkTlPx1wpWcKrwdYFMp8on1m4h9+GVI7VJBbjYA0uwYSWx8+tBdoMdLQJtEL
        t7o788NeGdo9DnK955vOCw8hMx/j6Z8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-gdVylvcfOxaMxhfdhI-amA-1; Sat, 19 Oct 2019 07:12:58 -0400
Received: by mail-lj1-f200.google.com with SMTP id h19so1617819ljc.5
        for <linux-wireless@vger.kernel.org>; Sat, 19 Oct 2019 04:12:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=M4GgkX+LRADBECdK3BnJ0KmXqiIAAwYR2Rj8nOCvbRc=;
        b=Pv+9bPNnCZRGFGasxd+Ic+w4zupaVRmrRwYxAjwd4njAAcgGzX4xriP59YQP+D8FF3
         LGGWQNUhOpi4jMvzaq/t06/EGJ/4iG/9UQrzpHl1yAeT02lNzImF2B/zwCE88Qn5csUU
         HRA0X9TU1pfqv4cCqRmOyOLSe9fgGfylwdnbzuFELOcT8EnyfeG5Xaslu/f8Y12W5st+
         JcULfuJ51SPp3b51IUC+yP0WSYzr0wjjq7eonx5Gtg5VsvQq7YYv2HXiB1adsccaijq1
         MvdyxNv83NMMpMvFQeFjMXjGXysegczgeBM+IIdJ6gr3UHziAoubr3r7MPoZNKy0TBAy
         VEpA==
X-Gm-Message-State: APjAAAV3hOWJYpllCXudljtTA/S7B8qPKI1NSBowFQVnNR2+FeoeBWa5
        fA0z37xc7RR/I6ZbNpg6XFK7NTZ0fvWMQBDNjgxps0kttQc5B4ziGnE6lTJPw89EnkS6DSrb6Gq
        JF3fd9QaW4bjFWCUF7NMjUx2Yu1c=
X-Received: by 2002:a2e:a0d6:: with SMTP id f22mr9186477ljm.74.1571483577551;
        Sat, 19 Oct 2019 04:12:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzlAKTSJxvndxc9u4z5wrZ6m3ed9972rGIVuaUby4/A2GFHKgjGkWh5J+VqEVLYMg27m8c8Kg==
X-Received: by 2002:a2e:a0d6:: with SMTP id f22mr9186462ljm.74.1571483577382;
        Sat, 19 Oct 2019 04:12:57 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id e19sm3391039lja.8.2019.10.19.04.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 04:12:56 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 967CE1804C8; Sat, 19 Oct 2019 13:12:55 +0200 (CEST)
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
Subject: Re: [PATCH v3 4/4] mac80211: Use Airtime-based Queue Limits (AQL) on packet dequeue
In-Reply-To: <CA+iem5sCTsPe4PW=0j20NoAratvdCvB0ss7zO3wMWLcirXsLgg@mail.gmail.com>
References: <157140962094.2866668.3383184317264069493.stgit@toke.dk> <157140962534.2866668.1182822483250825739.stgit@toke.dk> <CA+iem5sCTsPe4PW=0j20NoAratvdCvB0ss7zO3wMWLcirXsLgg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 19 Oct 2019 13:12:55 +0200
Message-ID: <87o8ydc7k8.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: gdVylvcfOxaMxhfdhI-amA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kan Yan <kyan@google.com> writes:

>> +       if (local->airtime_flags & AIRTIME_USE_AQL) {
>> +               airtime =3D ieee80211_calc_expected_tx_airtime(hw, vif, =
txq->sta,
>> +                                                            skb->len);
>> +               if (airtime) {
>> +                       /* We only have 10 bits in tx_time_est, so store=
 airtime
>> +                        * in increments of 4 us and clamp that to 2**10=
.
>> +                        */
>> +                       info->tx_time_est =3D min_t(u32, airtime >> 2, 1=
 << 10);
>> +                       ieee80211_sta_update_pending_airtime(local, tx.s=
ta, ac,
>> +                                                            airtime, fa=
lse);
>> +               }
>> +       }
>> +
>
> It should be:
>                          ieee80211_sta_update_pending_airtime(local, tx.s=
ta, ac,
>
> info->tx_time_est << 2, false);
>
> The airtime rounded to 4us (info->tx_time_est << 2), instead of the
> original airtime should be used when registering the pending airtime,
> to keep it consistent with airtime subtracted when the skb is freed.

Yes, I realised that last night as well. The rounding is also off (max
is 2**10-1, not 2**10. Will send a v4 :)

-Toke

