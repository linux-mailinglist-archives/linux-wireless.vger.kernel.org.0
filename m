Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1825BB5771
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2019 23:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfIQVYM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 17:24:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25481 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726030AbfIQVYM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 17:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568755450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b+48ay1mPqVDwtIAllu2J8td7+qP7si1SshjLTYZLWI=;
        b=JBdr0SoiaqvzSfMkWjCrZ4Mk5z1JBT0HIC6N/m/SUKOvv0VrBule07PinmN1++c9j1krNy
        dWcr0rLVvz2eGi5Okasr5he5XIRxc6g15GbZUYP3GS4YNvoO6GwGf+gLNd6eZykGDkI5eg
        7dzn+YIAZWr4uw91r+XDBKU79Xv6Ntg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-KsKXWsNQMJOllUo2zHCcxg-1; Tue, 17 Sep 2019 17:24:08 -0400
Received: by mail-ed1-f70.google.com with SMTP id 38so3005713edr.4
        for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2019 14:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Jrok+0k/p7koNFbJcq2OElkCvD+CG1bEZ3scb71tObQ=;
        b=TUZKltz6HFUNmZBm75orwVDgVnrZZK4+OMfg08YQ9Vi/scQiiHb2lwGWgDv578Mv9i
         OofJ5haSZrLgK6B/QWbZEQzwyyiEoR0D0YzNLeRDc6hiXJKdzcKdsNi5RhrOFxA6dH6I
         BSplRZzgkx2ErvRb7M6+2pSa5s9bTvsms8rbqSCD2MPLd7ZENz009oaOpqjXjYlYZQtX
         RY8vV+zuS4mRBqjmXNtoWNs1Wrld1w8fYwPp50KLGLJOwDB2rodO6KdOFiyWUlboM+Bq
         LEY3J3r35Up8oyWoieaTcqM4AytRBto0YCQZ7K0VNk0cih9hRXuRHBrE0HnM0kSeKHmZ
         IA4w==
X-Gm-Message-State: APjAAAUxNnq6Vn7eZngxlQhXPGw4N1jthoHHSXSp8kQ+2El5sVpsNqOb
        75718QfUZoZZNv6n5KISbr0P5QK3NAxfBxvikvLycSM3DCT2owZwA4LtCrvS5q6U9/R7CY2wcnI
        r7nS53kjPqGTrd4hYXORVth3XPe0=
X-Received: by 2002:a50:d090:: with SMTP id v16mr7040875edd.176.1568755446561;
        Tue, 17 Sep 2019 14:24:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyoS9BolYvd7bL6xJTfLlF4+ftyAAboQdIJXjbk/pXVZmGgYvhUlYqGbVSLDOCDdIu1G6J83g==
X-Received: by 2002:a50:d090:: with SMTP id v16mr7040865edd.176.1568755446408;
        Tue, 17 Sep 2019 14:24:06 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id nk2sm321521ejb.28.2019.09.17.14.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 14:24:05 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A659E1800B9; Tue, 17 Sep 2019 23:24:04 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Yibo Zhao <yiboz@codeaurora.org>, ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Yibo Zhao <yiboz@codeaurora.org>
Subject: Re: [PATCH 4/4] mac80211: Sync airtime weight sum with per AC synced sta airtime weight together
In-Reply-To: <1568639388-27291-4-git-send-email-yiboz@codeaurora.org>
References: <1568639388-27291-1-git-send-email-yiboz@codeaurora.org> <1568639388-27291-4-git-send-email-yiboz@codeaurora.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 17 Sep 2019 23:24:04 +0200
Message-ID: <87impqipl7.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: KsKXWsNQMJOllUo2zHCcxg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yibo Zhao <yiboz@codeaurora.org> writes:

> Global airtime weight sum is updated only when txq is added/removed
> from rbtree. If upper layer configures sta weight during high load,
> airtime weight sum will not be updated since txq is most likely on the
> tree. It could a little late for upper layer to reconfigure sta weight
> when txq is already in the rbtree. And thus, incorrect airtime weight sum
> will lead to incorrect global virtual time calculation as well as global
> airtime weight sum overflow of airtime weight sum during txq removed.
>
> Hence, need to update airtime weight sum upon receiving event for
> configuring sta weight once sta's txq is on the rbtree.
>
> Besides, if airtime weight sum of ACs and sta weight is synced under the
> same per AC lock protection, there can be a very short window causing
> incorrct airtime weight sum calculation as below:
>
>     active_txq_lock_VO                          .
>     VO weight sum is syncd=09=09=09.
>     sta airtime weight sum is synced=09=09.
>     active_txq_unlock_VO=09=09=09.
>     .=09=09=09=09=09=09.
>     active_txq_lock_VI    =09=09=09.
>     VI weight sum is syncd=09=09=09.
>     sta airtime weight sum=09=09active_txq_lock_BE
>     active_txq_unlock_VI=09      Remove txq and thus sum
>     .=09=09=09=09      is calculated with synced
>     .=09=09=09=09      sta airtime weight
>     .=09=09=09=09=09active_txq_unlock_BE
>
> So introduce a per ac synced station airtime weight synced with per
> AC synced weight sum together. And the per-AC station airtime weight
> is used to calculate weight sum.
>
> Signed-off-by: Yibo Zhao <yiboz@codeaurora.org>
> ---
>  net/mac80211/cfg.c      | 27 +++++++++++++++++++++++++--
>  net/mac80211/sta_info.c |  6 ++++--
>  net/mac80211/sta_info.h |  3 +++
>  net/mac80211/tx.c       |  4 ++--
>  4 files changed, 34 insertions(+), 6 deletions(-)
>
> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index d65aa01..4b420bb 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -1284,7 +1284,8 @@ static int sta_apply_parameters(struct ieee80211_lo=
cal *local,
>  =09int ret =3D 0;
>  =09struct ieee80211_supported_band *sband;
>  =09struct ieee80211_sub_if_data *sdata =3D sta->sdata;
> -=09u32 mask, set;
> +=09u32 mask, set, tid, ac;
> +=09struct txq_info *txqi;
> =20
>  =09sband =3D ieee80211_get_sband(sdata);
>  =09if (!sband)
> @@ -1452,8 +1453,30 @@ static int sta_apply_parameters(struct ieee80211_l=
ocal *local,
>  =09if (ieee80211_vif_is_mesh(&sdata->vif))
>  =09=09sta_apply_mesh_params(local, sta, params);
> =20
> -=09if (params->airtime_weight)
> +=09if (params->airtime_weight &&
> +=09    params->airtime_weight !=3D sta->airtime_weight) {
> +=09=09for (ac =3D 0; ac < IEEE80211_NUM_ACS; ac++) {
> +=09=09=09spin_lock_bh(&local->active_txq_lock[ac]);
> +=09=09=09for (tid =3D 0; tid < IEEE80211_NUM_TIDS + 1; tid++) {
> +=09=09=09=09if (!sta->sta.txq[tid] ||
> +=09=09=09=09    ac !=3D ieee80211_ac_from_tid(tid))
> +=09=09=09=09=09continue;
> +
> +=09=09=09=09sta->airtime_weight_synced[ac] =3D
> +=09=09=09=09=09=09=09params->airtime_weight;
> +
> +=09=09=09=09txqi =3D to_txq_info(sta->sta.txq[tid]);
> +=09=09=09=09if (RB_EMPTY_NODE(&txqi->schedule_order))
> +=09=09=09=09=09continue;
> +
> +=09=09=09=09local->airtime_weight_sum[ac] =3D local->airtime_weight_sum[=
ac] +
> +=09=09=09=09=09=09=09=09params->airtime_weight -
> +=09=09=09=09=09=09=09=09sta->airtime_weight;
> +=09=09=09}
> +=09=09=09spin_unlock_bh(&local->active_txq_lock[ac]);
> +=09=09}
>  =09=09sta->airtime_weight =3D params->airtime_weight;

With this, airtime_weight is basically only used to return to and from
userspace, right? I.e., after the above loop has run, it will match the
contents of airtime_weight_synced; so why not just turn airtime_weight
into  a per-ac array? You could just use airtime_weight[0] as the value
to return to userspace...

-Toke

