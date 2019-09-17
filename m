Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 754D3B5760
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2019 23:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfIQVKm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 17:10:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37014 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726308AbfIQVKm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 17:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568754640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yw5guvCmbDIZYS2d9dmJ48BaCS1JvUmh8f0hK52Gd58=;
        b=Lz2OScOwef1kyiDWua9sgaA9AsviemufoROmZYidW8TWKgo2DWptnfZw+jk1pBstjoC4XF
        QYc9jVLPmU1unzNJI83PyqPmh+Tm3gr6AXZFckWZJJxTPsNUHHP1OI9rNR4UQBksZDhPVp
        17N5ACQF/Ps7w77NeICuP9ffOTZ/kB8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-B6lplhG0PkSuutZvfDG_tw-1; Tue, 17 Sep 2019 17:10:38 -0400
Received: by mail-ed1-f72.google.com with SMTP id l11so2974971edv.8
        for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2019 14:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=DD2XbQDKp4hIc+vyoPDPU9fuPdb+68KPHi8jqJUDZeM=;
        b=P/l24DziOGXgsG0WZHDPG1cqSC5JHxP+WNc43jPNpgZO2YyXxsdIhXp11p6u8TAC/B
         vLCMSKlFPCdFktmgBilL/No1EW7BChoohWMV8rqo5WU4L1AMqfIWRRWgbbHjldAxZDZk
         8DC+tFCVyvvk9zTshkm+FARFVTNm5SfcDd73ArsQcdn16wahswCcsgZDJTjb69EwvkTY
         EOwcy+n+0ZGaoNFJVqWFCW7GsDal5veaxFZChq7THtsL8gKd7oomeIE7VIkmTGo8sG/s
         0WjLkbrPZDQ/db5u0PQLLCy+eCWViUWGswcfipD3O5qqbn8w+GkIS/Y3/c0ZklUwCqx/
         I1Fw==
X-Gm-Message-State: APjAAAVvgkjW0kyAuLYz49G3aa3/Vpd3jf5QTdSTAhZBFCkPQUbKPaD7
        3iJ5jyMdsFwIRFQOzIz0fnCLyNZm6IcsHQPNmQAvCRp0Ma/eGPiYhcsdE8Xm7xHP6XS/Guskm4J
        uHQDwT/AkAMVsa0IiEOEDoPj1bKo=
X-Received: by 2002:a50:f00c:: with SMTP id r12mr6943374edl.274.1568754637465;
        Tue, 17 Sep 2019 14:10:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwhsJPCAI8AWW9ZaFbkYdkRt8z0ZGBhfPh/VuLfeD7KNLwgLMdgon1H8OKWUZkCml1V1MR5Yw==
X-Received: by 2002:a50:f00c:: with SMTP id r12mr6943357edl.274.1568754637257;
        Tue, 17 Sep 2019 14:10:37 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id 4sm406942ejm.47.2019.09.17.14.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 14:10:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2A6341800B9; Tue, 17 Sep 2019 23:10:35 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Yibo Zhao <yiboz@codeaurora.org>, ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Yibo Zhao <yiboz@codeaurora.org>
Subject: Re: [PATCH 2/4] mac80211: defer txqs removal from rbtree
In-Reply-To: <1568639388-27291-2-git-send-email-yiboz@codeaurora.org>
References: <1568639388-27291-1-git-send-email-yiboz@codeaurora.org> <1568639388-27291-2-git-send-email-yiboz@codeaurora.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 17 Sep 2019 23:10:35 +0200
Message-ID: <87pnjyiq7o.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: B6lplhG0PkSuutZvfDG_tw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yibo Zhao <yiboz@codeaurora.org> writes:

> In a loop txqs dequeue scenario, if the first txq in the rbtree gets
> removed from rbtree immediately in the ieee80211_return_txq(), the
> loop will break soon in the ieee80211_next_txq() due to schedule_pos
> not leading to the second txq in the rbtree. Thus, defering the
> removal right before the end of this schedule round.
>
> Co-developed-by: Yibo Zhao <yiboz@codeaurora.org>
> Signed-off-by: Yibo Zhao <yiboz@codeaurora.org>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

I didn't write this patch, so please don't use my sign-off. I'll add
ack or review tags as appropriate in reply; but a few comments first:

> ---
>  include/net/mac80211.h     | 16 ++++++++++--
>  net/mac80211/ieee80211_i.h |  3 +++
>  net/mac80211/main.c        |  6 +++++
>  net/mac80211/tx.c          | 63 ++++++++++++++++++++++++++++++++++++++++=
+++---
>  4 files changed, 83 insertions(+), 5 deletions(-)
>
> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index ac2ed8e..ba5a345 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -925,6 +925,8 @@ struct ieee80211_tx_rate {
> =20
>  #define IEEE80211_MAX_TX_RETRY=09=0931
> =20
> +#define IEEE80211_AIRTIME_TXQ_RM_CHK_INTV_IN_MS 100
> +
>  static inline void ieee80211_rate_set_vht(struct ieee80211_tx_rate *rate=
,
>  =09=09=09=09=09  u8 mcs, u8 nss)
>  {
> @@ -6232,7 +6234,8 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee802=
11_hw *hw,
>   * @ac: AC number to return packets from.
>   *
>   * Should only be called between calls to ieee80211_txq_schedule_start()
> - * and ieee80211_txq_schedule_end().
> + * and ieee80211_txq_schedule_end(). If the txq is empty, it will be add=
ed
> + * to a remove list and get removed later.
>   * Returns the next txq if successful, %NULL if no queue is eligible. If=
 a txq
>   * is returned, it should be returned with ieee80211_return_txq() after =
the
>   * driver has finished scheduling it.
> @@ -6268,7 +6271,8 @@ void ieee80211_txq_schedule_start(struct ieee80211_=
hw *hw, u8 ac)
>   * @hw: pointer as obtained from ieee80211_alloc_hw()
>   * @ac: AC number to acquire locks for
>   *
> - * Release locks previously acquired by ieee80211_txq_schedule_end().
> + * Release locks previously acquired by ieee80211_txq_schedule_end(). Ch=
eck
> + * and remove the empty txq from rb-tree.
>   */
>  void ieee80211_txq_schedule_end(struct ieee80211_hw *hw, u8 ac)
>  =09__releases(txq_lock);
> @@ -6287,6 +6291,14 @@ void ieee80211_schedule_txq(struct ieee80211_hw *h=
w, struct ieee80211_txq *txq)
>  =09__acquires(txq_lock) __releases(txq_lock);
> =20
>  /**
> + * ieee80211_txqs_check - Check txqs waiting for removal
> + *
> + * @tmr: pointer as obtained from local
> + *
> + */
> +void ieee80211_txqs_check(struct timer_list *tmr);
> +
> +/**
>   * ieee80211_txq_may_transmit - check whether TXQ is allowed to transmit
>   *
>   * This function is used to check whether given txq is allowed to transm=
it by
> diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
> index a4556f9..49aa143e 100644
> --- a/net/mac80211/ieee80211_i.h
> +++ b/net/mac80211/ieee80211_i.h
> @@ -847,6 +847,7 @@ struct txq_info {
>  =09struct codel_stats cstats;
>  =09struct sk_buff_head frags;
>  =09struct rb_node schedule_order;
> +=09struct list_head candidate;
>  =09unsigned long flags;
> =20
>  =09/* keep last! */
> @@ -1145,6 +1146,8 @@ struct ieee80211_local {
>  =09u64 airtime_v_t[IEEE80211_NUM_ACS];
>  =09u64 airtime_weight_sum[IEEE80211_NUM_ACS];
> =20
> +=09struct list_head remove_list[IEEE80211_NUM_ACS];
> +=09struct timer_list remove_timer;
>  =09u16 airtime_flags;
> =20
>  =09const struct ieee80211_ops *ops;
> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
> index e9ffa8e..78fe24a 100644
> --- a/net/mac80211/main.c
> +++ b/net/mac80211/main.c
> @@ -667,10 +667,15 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t p=
riv_data_len,
> =20
>  =09for (i =3D 0; i < IEEE80211_NUM_ACS; i++) {
>  =09=09local->active_txqs[i] =3D RB_ROOT_CACHED;
> +=09=09INIT_LIST_HEAD(&local->remove_list[i]);
>  =09=09spin_lock_init(&local->active_txq_lock[i]);
>  =09}
>  =09local->airtime_flags =3D AIRTIME_USE_TX | AIRTIME_USE_RX;
> =20
> +=09timer_setup(&local->remove_timer, ieee80211_txqs_check, 0);
> +=09mod_timer(&local->remove_timer,
> +=09=09  jiffies + msecs_to_jiffies(IEEE80211_AIRTIME_TXQ_RM_CHK_INTV_IN_=
MS));
> +
>  =09INIT_LIST_HEAD(&local->chanctx_list);
>  =09mutex_init(&local->chanctx_mtx);
> =20
> @@ -1305,6 +1310,7 @@ void ieee80211_unregister_hw(struct ieee80211_hw *h=
w)
>  =09tasklet_kill(&local->tx_pending_tasklet);
>  =09tasklet_kill(&local->tasklet);
> =20
> +=09del_timer_sync(&local->remove_timer);
>  #ifdef CONFIG_INET
>  =09unregister_inetaddr_notifier(&local->ifa_notifier);
>  #endif
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index d00baaa..42ca010 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -1450,6 +1450,7 @@ void ieee80211_txq_init(struct ieee80211_sub_if_dat=
a *sdata,
>  =09codel_stats_init(&txqi->cstats);
>  =09__skb_queue_head_init(&txqi->frags);
>  =09RB_CLEAR_NODE(&txqi->schedule_order);
> +=09INIT_LIST_HEAD(&txqi->candidate);
> =20
>  =09txqi->txq.vif =3D &sdata->vif;
> =20
> @@ -3724,6 +3725,9 @@ void ieee80211_schedule_txq(struct ieee80211_hw *hw=
,
> =20
>  =09spin_lock_bh(&local->active_txq_lock[ac]);
> =20
> +=09if (!list_empty(&txqi->candidate))
> +=09=09list_del_init(&txqi->candidate);
> +
>  =09if (!RB_EMPTY_NODE(&txqi->schedule_order))
>  =09=09goto out;
> =20
> @@ -3783,6 +3787,20 @@ static void __ieee80211_unschedule_txq(struct ieee=
80211_hw *hw,
>  =09RB_CLEAR_NODE(&txqi->schedule_order);
>  }
> =20
> +void ieee80211_remove_txq(struct ieee80211_hw *hw,
> +=09=09=09  struct ieee80211_txq *txq)
> +{
> +=09struct ieee80211_local *local =3D hw_to_local(hw);
> +=09struct txq_info *txqi =3D to_txq_info(txq);
> +
> +=09lockdep_assert_held(&local->active_txq_lock[txq->ac]);
> +
> +=09if (!RB_EMPTY_NODE(&txqi->schedule_order)) {
> +=09=09__ieee80211_unschedule_txq(hw, txq);
> +=09=09list_del_init(&txqi->candidate);
> +=09}
> +}
> +
>  void ieee80211_unschedule_txq(struct ieee80211_hw *hw,
>  =09=09=09      struct ieee80211_txq *txq)
>  =09__acquires(txq_lock) __releases(txq_lock)
> @@ -3790,7 +3808,7 @@ void ieee80211_unschedule_txq(struct ieee80211_hw *=
hw,
>  =09struct ieee80211_local *local =3D hw_to_local(hw);
> =20
>  =09spin_lock_bh(&local->active_txq_lock[txq->ac]);
> -=09__ieee80211_unschedule_txq(hw, txq);
> +=09ieee80211_remove_txq(hw, txq);
>  =09spin_unlock_bh(&local->active_txq_lock[txq->ac]);
>  }
> =20
> @@ -3803,11 +3821,48 @@ void ieee80211_return_txq(struct ieee80211_hw *hw=
,
>  =09lockdep_assert_held(&local->active_txq_lock[txq->ac]);
> =20
>  =09if (!RB_EMPTY_NODE(&txqi->schedule_order) &&
> -=09    (skb_queue_empty(&txqi->frags) && !txqi->tin.backlog_packets))
> -=09=09__ieee80211_unschedule_txq(hw, txq);
> +=09=09!txq_has_queue(&txqi->txq) &&
> +=09=09list_empty(&txqi->candidate))
> +=09=09list_add_tail(&txqi->candidate, &local->remove_list[txq->ac]);
> +
>  }
>  EXPORT_SYMBOL(ieee80211_return_txq);
> =20
> +void __ieee80211_check_txqs(struct ieee80211_local *local, int ac)
> +{
> +=09struct txq_info *iter, *tmp;
> +=09struct sta_info *sta;
> +
> +=09lockdep_assert_held(&local->active_txq_lock[ac]);
> +
> +=09list_for_each_entry_safe(iter, tmp, &local->remove_list[ac],
> +=09=09=09=09 candidate) {
> +=09=09sta =3D container_of(iter->txq.sta, struct sta_info, sta);
> +
> +=09=09if (txq_has_queue(&iter->txq))
> +=09=09=09list_del_init(&iter->candidate);
> +=09=09else
> +=09=09=09ieee80211_remove_txq(&local->hw, &iter->txq);
> +=09}
> +}
> +
> +void ieee80211_txqs_check(struct timer_list *t)
> +{
> +=09struct ieee80211_local *local =3D from_timer(local, t, remove_timer);
> +=09struct txq_info *iter, *tmp;
> +=09struct sta_info *sta;
> +=09int ac;
> +
> +=09for (ac =3D 0; ac < IEEE80211_NUM_ACS; ac++) {
> +=09=09spin_lock_bh(&local->active_txq_lock[ac]);
> +=09=09__ieee80211_check_txqs(local, ac);
> +=09=09spin_unlock_bh(&local->active_txq_lock[ac]);
> +=09}
> +
> +=09mod_timer(&local->remove_timer,
> +=09=09  jiffies + msecs_to_jiffies(IEEE80211_AIRTIME_TXQ_RM_CHK_INTV_IN_=
MS));
> +}

I'll ask the same as I did last time (where you told me to hold off
until this round):

Why do you need the timer and the periodic check? If TXQs are added to
the remove list during the scheduling run, and __ieee80211_check_txqs()
is run from schedule_end(), isn't that sufficient to clear the list?

-Toke

