Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 108CAFEC1E
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2019 12:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfKPLzb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Nov 2019 06:55:31 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27844 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726794AbfKPLza (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Nov 2019 06:55:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573905329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pocr9mxteUSNieGJ3i0GrJ3OYF+/Atfr3hbsYPy6vVA=;
        b=PiKULlEtfoTQxBEn0LdANJfMA4Ck1Ue4EijpN+pgcL4g9s4AF3bNFnm1jgeizVX0HEvQPh
        OPSHfaUYDmNliAoQ1Agr1zVeFod0XM6pNiPkQarb/C5EhsQaQ2LStX7ob2xccNQce6AZ+z
        V1Uw6H1NOlhEa4g7ocSzHLS0VJ/yFd0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-3fUNWej2N8Wvjh2IfNPWsg-1; Sat, 16 Nov 2019 06:55:27 -0500
Received: by mail-lj1-f199.google.com with SMTP id p25so2119265lji.23
        for <linux-wireless@vger.kernel.org>; Sat, 16 Nov 2019 03:55:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=n6c2pnbrFvBGhTNPEdW3eLVAGMawNGwiDmS2BKDIKsc=;
        b=p0PIjhPjuZI14W6hht3sWyIkdDWcSqxmE7M+SsmuIx07ppU7YiwgVrLTRAS4myDkZt
         1hnefLjqBQ+LeiL3AepHvVU89X2l4UUMMPxTKg2OJ7uWTmMX3O6WTMxC1Mg3CEvwC8AO
         vA1OpfduiRvV9joZ+u3WtK37KCMPMwxWFN6rGWORFUVLGqC2MREOLkpRR45/UPfN5vKC
         8xOierqmhy2sLKa+AH+8Tg7xtrAqq+VJSKT3io6wgCm+y1X8BDDeP8fhhYvKggjQkX6t
         +NlvQOKIgduc8+Sjx22We/IfIaoZezwstxvHG07YDwgqgcAZUniy3PHB1Ic03Fy4brNT
         XwPA==
X-Gm-Message-State: APjAAAVO5bSB5kEkML64zkqR7gYenHEHF4rO/Z0LGJDiKQ6YZ2u6UzCZ
        u2G3id1s7+DVskocGlyNRgmjS8HheKFSW4PduMCFq+aAZkn9eceZHf/txzhUogcWUyADYCoW37O
        fkGAu9TjHUWKxamL4s1IeuHpq56M=
X-Received: by 2002:a05:6512:1c3:: with SMTP id f3mr1144142lfp.25.1573905325639;
        Sat, 16 Nov 2019 03:55:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqwX+pIGhUsS/LCHnu6CdH7G0PaQC73fttIusOds0wbKPWxC4Nz0N/SiQfaz8Xc/AGJxAet2Wg==
X-Received: by 2002:a05:6512:1c3:: with SMTP id f3mr1144130lfp.25.1573905325430;
        Sat, 16 Nov 2019 03:55:25 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id 4sm6212837lfa.95.2019.11.16.03.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2019 03:55:24 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B0E3F181910; Sat, 16 Nov 2019 12:55:23 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kan Yan <kyan@google.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        ath10k@lists.infradead.org, John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Subject: Re: [PATCH v9 4/4] mac80211: Use Airtime-based Queue Limits (AQL) on packet dequeue
In-Reply-To: <CA+iem5tF+TN-osfGxu=EU5Xt1Uq+PcKgBVaoAmZY3a3JzS5JzQ@mail.gmail.com>
References: <157382403672.580235.12525941420808058808.stgit@toke.dk> <157382404118.580235.14216392299709793599.stgit@toke.dk> <CA+iem5tF+TN-osfGxu=EU5Xt1Uq+PcKgBVaoAmZY3a3JzS5JzQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 16 Nov 2019 12:55:23 +0100
Message-ID: <87y2wgjas4.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: 3fUNWej2N8Wvjh2IfNPWsg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kan Yan <kyan@google.com> writes:

>> +static inline u16
>> +ieee80211_info_set_tx_time_est(struct ieee80211_tx_info *info, u16 tx_t=
ime_est)
>> +{
>> +       /* We only have 10 bits in tx_time_est, so store airtime
>> +        * in increments of 4us and clamp the maximum to 2**12-1
>> +        */
>> +       info->tx_time_est =3D min_t(u16, tx_time_est, 4095) >> 2;
>> +       return info->tx_time_est;
>> +}
>> +
>> +static inline u16
>> +ieee80211_info_get_tx_time_est(struct ieee80211_tx_info *info)
>> +{
>> +       return info->tx_time_est << 2;
>> +}
>> +
>
> set_tx_time_est() returns airtime in different units (4us) than
> get_tx_time_est(), this will cause the pending_airtime out of whack.

Huh, you're quite right; oops! I meant to shift that back before
returning. Will fix.

> Given the fact that AQL is only tested in very limited platforms,
> should we set the default to disabled by removing this change in the
> next update?
>
> -       local->airtime_flags =3D AIRTIME_USE_TX | AIRTIME_USE_RX;
> +
> +       local->airtime_flags =3D AIRTIME_USE_TX |
> +                              AIRTIME_USE_RX |
> +                              AIRTIME_USE_AQL;
> +       local->aql_threshold =3D IEEE80211_AQL_THRESHOLD;
> +       atomic_set(&local->aql_total_pending_airtime, 0);

Well, we have the whole -rc series to get more testing in if we merge it
as-is. It's up to the maintainers, of course, but I would be in favour
of merging as-is, then optionally backing out the default before the
final release if problems do turn up. But I would hope that the limits
are sufficiently conservative that it would not result in any problems :)

-Toke

