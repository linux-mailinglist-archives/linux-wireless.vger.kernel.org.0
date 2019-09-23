Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02727BB288
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2019 13:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbfIWLAu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Sep 2019 07:00:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21086 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729847AbfIWLAu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Sep 2019 07:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569236447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=waakQH4yG/db0MujkCb3FFRRuoTH6HXUpqPKpYLZu8o=;
        b=DW2+UBEQJ/gq3vurCR/x3BIKmPlE/xoII5sHKflNWPnoPtXzuy43BedkQOpZZaDnWv+ISw
        Il1QsVQiMqEazNGKSA5y85Eku8e91ohltJQyUS9BsbQmyurKYwL3swRXd9LGu3vqc9gvwq
        lfr861/oHl32yHHHe3A2S205hMyyl2o=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-ySqEEH5oMIywkSwsXHIzfg-1; Mon, 23 Sep 2019 07:00:46 -0400
Received: by mail-lj1-f199.google.com with SMTP id j10so2867167lja.21
        for <linux-wireless@vger.kernel.org>; Mon, 23 Sep 2019 04:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Q/2CfyJmKEePPgH8t4dJFqZmM1MkyzcIowYj12cLr1U=;
        b=uJ5C7//8S7w5Yt33Nt6tAIsLNY/CBunduPtljBuZzry0UPNDCAF51gq8Sr+x6meUBD
         woLRRtk5JV9Cr2cyxAWqqDxemz3tK+nutRg5iJj/nosw4NHmszj8WWjCCWetlXua1yNE
         MEcMSb1JQ+GimepW5NrIhscnpYMgnodcfPUhlKzrsrGRioVXAgrD2tHXoYLPo8OueErz
         MJoLFhVYohXgKRWiSo94qUGUdtns6sba6ZNZFEMVLrQEkI2omcAvDjYyV3JliDRXQjgV
         S3cDt5xSs1n8/TLLncKSyceknslMnkqbp7QFsrC1l1lH14Q3fRuRe1HjKx34c0KZW9Ev
         ywMg==
X-Gm-Message-State: APjAAAUQfAokshIkKIg4KEaWmYTtNsKIC9JUHhJEyydqKvbzKZT8glWl
        VUdL2E275WDpQ4Zx+rXvLoO0soPOUyo7YdBNzl9Xl+4Upc3Sov/5jE5D9wKOGDNY2w/OZuNzSRu
        iM+sHIDk+4s0Bg1GYeAxOhjVyMHw=
X-Received: by 2002:a2e:9096:: with SMTP id l22mr16997619ljg.125.1569236444571;
        Mon, 23 Sep 2019 04:00:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxnDcc3U0+xNGiec4I9ZluLk98FbV4td/u2fIji3V4t1Sd55p+XIy9R8ziFgRigxh7HlV+YUQ==
X-Received: by 2002:a2e:9096:: with SMTP id l22mr16997612ljg.125.1569236444394;
        Mon, 23 Sep 2019 04:00:44 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id e19sm2216211lja.8.2019.09.23.04.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 04:00:43 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AA7471804C8; Mon, 23 Sep 2019 13:00:42 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Yibo Zhao <yiboz@codeaurora.org>, linux-wireless@vger.kernel.org
Cc:     ath10k@lists.infradead.org, Yibo Zhao <yiboz@codeaurora.org>
Subject: Re: [PATCH V3 4/4] mac80211: Sync airtime weight sum with per AC synced sta airtime weight together
In-Reply-To: <1569223201-1490-5-git-send-email-yiboz@codeaurora.org>
References: <1569223201-1490-1-git-send-email-yiboz@codeaurora.org> <1569223201-1490-5-git-send-email-yiboz@codeaurora.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 23 Sep 2019 13:00:42 +0200
Message-ID: <87blvb5lb9.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: ySqEEH5oMIywkSwsXHIzfg-1
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
> will lead to incorrect global virtual time calculation as well as overflo=
w
> of airtime weight sum during txq removed.
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
>  net/mac80211/cfg.c         | 29 ++++++++++++++++++++++++++---
>  net/mac80211/debugfs_sta.c |  2 +-
>  net/mac80211/sta_info.c    |  9 ++++-----
>  net/mac80211/sta_info.h    |  5 +++--
>  net/mac80211/tx.c          |  4 ++--
>  5 files changed, 36 insertions(+), 13 deletions(-)
>
> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index d65aa01..c8a0683 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -1284,7 +1284,8 @@ static int sta_apply_parameters(struct ieee80211_lo=
cal *local,
>  =09int ret =3D 0;
>  =09struct ieee80211_supported_band *sband;
>  =09struct ieee80211_sub_if_data *sdata =3D sta->sdata;
> -=09u32 mask, set;
> +=09u32 mask, set, tid, ac, pre_weight;
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
> -=09=09sta->airtime_weight =3D params->airtime_weight;
> +=09if (params->airtime_weight &&
> +=09    params->airtime_weight !=3D sta->airtime_weight) {

This check doesn't work I think? You're not using the array-based
sta->airtime_weight[], and there are locking issues by just checking
like this; so maybe just keep the if() on params->airtime_weight, and do
the checking inside the loop while holding the lock?

Or could we just turn the weights into atomics to avoid the locking
entirely?

> +=09=09for (ac =3D 0; ac < IEEE80211_NUM_ACS; ac++) {
> +=09=09=09spin_lock_bh(&local->active_txq_lock[ac]);
> +=09=09=09for (tid =3D 0; tid < IEEE80211_NUM_TIDS + 1; tid++) {
> +=09=09=09=09if (!sta->sta.txq[tid] ||
> +=09=09=09=09    ac !=3D ieee80211_ac_from_tid(tid))
> +=09=09=09=09=09continue;
> +
> +=09=09=09=09pre_weight =3D sta->airtime_weight[ac];
> +=09=09=09=09sta->airtime_weight[ac] =3D
> +=09=09=09=09=09=09params->airtime_weight;
> +
> +=09=09=09=09txqi =3D to_txq_info(sta->sta.txq[tid]);
> +=09=09=09=09if (RB_EMPTY_NODE(&txqi->schedule_order))
> +=09=09=09=09=09continue;
> +
> +=09=09=09=09local->airtime_weight_sum[ac] =3D local->airtime_weight_sum[=
ac] +
> +=09=09=09=09=09=09=09=09params->airtime_weight -
> +=09=09=09=09=09=09=09=09pre_weight;
> +=09=09=09}
> +=09=09=09spin_unlock_bh(&local->active_txq_lock[ac]);
> +=09=09}
> +=09}
> =20
>  =09/* set the STA state after all sta info from usermode has been set */
>  =09if (test_sta_flag(sta, WLAN_STA_TDLS_PEER) ||
> diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
> index 80028da..43a7e6a 100644
> --- a/net/mac80211/debugfs_sta.c
> +++ b/net/mac80211/debugfs_sta.c
> @@ -223,7 +223,7 @@ static ssize_t sta_airtime_read(struct file *file, ch=
ar __user *userbuf,
>  =09=09"Virt-T: VO: %lld us VI: %lld us BE: %lld us BK: %lld us\n",
>  =09=09rx_airtime,
>  =09=09tx_airtime,
> -=09=09sta->airtime_weight,
> +=09=09sta->airtime_weight[0],
>  =09=09v_t[0],
>  =09=09v_t[1],
>  =09=09v_t[2],
> diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
> index feac975..e599cf1 100644
> --- a/net/mac80211/sta_info.c
> +++ b/net/mac80211/sta_info.c
> @@ -384,11 +384,10 @@ struct sta_info *sta_info_alloc(struct ieee80211_su=
b_if_data *sdata,
>  =09if (sta_prepare_rate_control(local, sta, gfp))
>  =09=09goto free_txq;
> =20
> -=09sta->airtime_weight =3D IEEE80211_DEFAULT_AIRTIME_WEIGHT;
> -
>  =09for (i =3D 0; i < IEEE80211_NUM_ACS; i++) {
>  =09=09skb_queue_head_init(&sta->ps_tx_buf[i]);
>  =09=09skb_queue_head_init(&sta->tx_filtered[i]);
> +=09=09sta->airtime_weight[i] =3D IEEE80211_DEFAULT_AIRTIME_WEIGHT;
>  =09}
> =20
>  =09for (i =3D 0; i < IEEE80211_NUM_TIDS; i++)
> @@ -1850,11 +1849,11 @@ void ieee80211_sta_register_airtime(struct ieee80=
211_sta *pubsta, u8 tid,
>  =09sta->airtime[ac].tx_airtime +=3D tx_airtime;
>  =09sta->airtime[ac].rx_airtime +=3D rx_airtime;
> =20
> -=09weight_sum =3D local->airtime_weight_sum[ac] ?: sta->airtime_weight;
> +=09weight_sum =3D local->airtime_weight_sum[ac] ?: sta->airtime_weight[a=
c];
> =20
>  =09/* Round the calculation of global vt */
>  =09local->airtime_v_t[ac] +=3D (airtime + (weight_sum >> 1)) / weight_su=
m;
> -=09sta->airtime[ac].v_t +=3D airtime / sta->airtime_weight;
> +=09sta->airtime[ac].v_t +=3D airtime / sta->airtime_weight[ac];
>  =09ieee80211_resort_txq(&local->hw, txq);
> =20
>  =09spin_unlock_bh(&local->active_txq_lock[ac]);
> @@ -2236,7 +2235,7 @@ void sta_set_sinfo(struct sta_info *sta, struct sta=
tion_info *sinfo,
>  =09}
> =20
>  =09if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_AIRTIME_WEIGHT))) {
> -=09=09sinfo->airtime_weight =3D sta->airtime_weight;
> +=09=09sinfo->airtime_weight =3D sta->airtime_weight[0];
>  =09=09sinfo->filled |=3D BIT_ULL(NL80211_STA_INFO_AIRTIME_WEIGHT);
>  =09}
> =20
> diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
> index 5055f94..2697343 100644
> --- a/net/mac80211/sta_info.h
> +++ b/net/mac80211/sta_info.h
> @@ -476,7 +476,8 @@ struct ieee80211_sta_rx_stats {
>   * @tid_seq: per-TID sequence numbers for sending to this STA
>   * @airtime: per-AC struct airtime_info describing airtime statistics fo=
r this
>   *=09station
> - * @airtime_weight: station weight for airtime fairness calculation purp=
oses
> + * @airtime_weight: station per-AC weight for airtime fairness calculati=
on
> + * purposes
>   * @ampdu_mlme: A-MPDU state machine state
>   * @mesh: mesh STA information
>   * @debugfs_dir: debug filesystem directory dentry
> @@ -602,7 +603,7 @@ struct sta_info {
>  =09u16 tid_seq[IEEE80211_QOS_CTL_TID_MASK + 1];
> =20
>  =09struct airtime_info airtime[IEEE80211_NUM_ACS];
> -=09u16 airtime_weight;
> +=09u16 airtime_weight[IEEE80211_NUM_ACS];
> =20
>  =09/*
>  =09 * Aggregation information, locked with lock.
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index 60cf569..286cf14 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -3735,7 +3735,7 @@ void ieee80211_schedule_txq(struct ieee80211_hw *hw=
,
>  =09=09struct sta_info *sta =3D container_of(txq->sta,
>  =09=09=09=09=09=09    struct sta_info, sta);
> =20
> -=09=09local->airtime_weight_sum[ac] +=3D sta->airtime_weight;
> +=09=09local->airtime_weight_sum[ac] +=3D sta->airtime_weight[ac];
>  =09=09if (local->airtime_v_t[ac] > AIRTIME_GRACE)
>  =09=09=09sta->airtime[ac].v_t =3D max(local->airtime_v_t[ac] - AIRTIME_G=
RACE,
>  =09=09=09=09=09=09   sta->airtime[ac].v_t);
> @@ -3779,7 +3779,7 @@ static void __ieee80211_unschedule_txq(struct ieee8=
0211_hw *hw,
>  =09=09struct sta_info *sta =3D container_of(txq->sta,
>  =09=09=09=09=09=09    struct sta_info, sta);
> =20
> -=09=09local->airtime_weight_sum[ac] -=3D sta->airtime_weight;
> +=09=09local->airtime_weight_sum[ac] -=3D sta->airtime_weight[ac];
>  =09}
> =20
>  =09rb_erase_cached(&txqi->schedule_order,
> --=20
> 1.9.1

