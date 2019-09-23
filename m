Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7559BB267
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2019 12:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbfIWKrL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Sep 2019 06:47:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29944 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729775AbfIWKrL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Sep 2019 06:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569235627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nYzikjCT7dTo23BWW3L1NBBoKchfcEpE7CSmUGd35og=;
        b=Nis7W6gBdAxe9syDe1ayVpyL+Tcc2J+/yuGygsn2qQpuQezKU6j5ROTnBQWTkuJKTn6UXV
        7DTgfNRznZBYgeyx9wpIpxPNGBpkxmIZy3cKpJKXJOcM8FhgEo4XL49QXluJBwg4C194C2
        RpTYDIhtZC7MKngAxZjbwPWoz247Pz0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-Cy51vbGPNPGbk6Wyc8lkdw-1; Mon, 23 Sep 2019 06:47:05 -0400
Received: by mail-lj1-f199.google.com with SMTP id p14so2851844ljh.22
        for <linux-wireless@vger.kernel.org>; Mon, 23 Sep 2019 03:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=weKCkQvC8lSWrTDZoAsN1aWHQnDtLXu49du56bkUIrA=;
        b=uOQQqDPpLOiIR4EXTJzEQGfgu6Sq/7n6XFZP33B319yQfDNqv7YDoeOV2BUUtjmF/R
         UDkYWEK/4lRN6100yg2YuLTH1v24kso3+UPU4Thx7daCZO5yWVi9BanEfCMNQmySeFUD
         HtWnSNy/bxopyT3ybNr2B+laqMvlwWaCKfxYBuYCmxu4E5PJbAV4+B5iSMa9UwG6NNMS
         7QxTUElGMe25Fv/o92doCedzQIOToFlSfdBb9OWJCHP+y7+XN02mx11xJFI4qYox3xdB
         2Tno5Pb6cOsSED9fjYQgesergqh2Wsv/534SDzu0zC0yZQQq/drQMj8ggaGxIi/sdiU1
         cHWg==
X-Gm-Message-State: APjAAAUPOv/BiHsJXej/wr851NxLcwph1KG3B60sv7y5M4mT6bNAiFoo
        zJjUqGNMQXCltfSL5T6mLFtr6MyO+p6FSdeXUUPLqLyPPjmvSIQX2iKnPGGY7VF9e4KPoa3rzBq
        lg3wrpS4PtnYn24iymAEHjtTHglk=
X-Received: by 2002:a2e:a0c5:: with SMTP id f5mr5216382ljm.114.1569235624284;
        Mon, 23 Sep 2019 03:47:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxkhMXNCZXmBASU2BFap4isQyXk7RfEPCTwf1GAoIfoUNAa0txK6a0GN6d4x5Vqv+efqjGMVg==
X-Received: by 2002:a2e:a0c5:: with SMTP id f5mr5216357ljm.114.1569235623827;
        Mon, 23 Sep 2019 03:47:03 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id z18sm2201469ljh.17.2019.09.23.03.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 03:47:02 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AEDDC1804C8; Mon, 23 Sep 2019 12:47:01 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Yibo Zhao <yiboz@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH 2/4] mac80211: defer txqs removal from rbtree
In-Reply-To: <2935b00bf3e29ad8b2738fe98dc24a76@codeaurora.org>
References: <1568639388-27291-1-git-send-email-yiboz@codeaurora.org> <1568639388-27291-2-git-send-email-yiboz@codeaurora.org> <87pnjyiq7o.fsf@toke.dk> <c3ee7ece0986f1c50513cd5fdd2ee03f@codeaurora.org> <87sgothmpy.fsf@toke.dk> <8cdece5c030fd95817fb099021c38613@codeaurora.org> <87tv98fu6l.fsf@toke.dk> <1b4ab006d9b5c88035845aaac193ef48@codeaurora.org> <8736gre3bm.fsf@toke.dk> <198124204167325252fcfcd65e3f2733@codeaurora.org> <87ftkp7uuz.fsf@toke.dk> <4574cce4079f8dab2b2bf223431a6eae@codeaurora.org> <877e617qg2.fsf@toke.dk> <910d9bb5f9016b29fb2aaeb0b89bac38@codeaurora.org> <874l157nrt.fsf@toke.dk> <2935b00bf3e29ad8b2738fe98dc24a76@codeaurora.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 23 Sep 2019 12:47:01 +0200
Message-ID: <87lfuf5ly2.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: Cy51vbGPNPGbk6Wyc8lkdw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yibo Zhao <yiboz@codeaurora.org> writes:

> On 2019-09-21 22:00, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>=20
>>> On 2019-09-21 21:02, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>=20
>>>>> On 2019-09-21 19:27, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>>=20
>>>>>>> On 2019-09-20 17:15, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>>>>=20
>>>>>>>>> On 2019-09-19 18:37, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>>>>>>=20
>>>>>>>>>>> On 2019-09-18 19:23, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>>>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>>>>>>>>=20
>>>>>>>>>>>>> On 2019-09-18 05:10, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>>>>>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>> In a loop txqs dequeue scenario, if the first txq in the
>>>>>>>>>>>>>>> rbtree
>>>>>>>>>>>>>>> gets
>>>>>>>>>>>>>>> removed from rbtree immediately in the
>>>>>>>>>>>>>>> ieee80211_return_txq(),
>>>>>>>>>>>>>>> the
>>>>>>>>>>>>>>> loop will break soon in the ieee80211_next_txq() due to
>>>>>>>>>>>>>>> schedule_pos
>>>>>>>>>>>>>>> not leading to the second txq in the rbtree. Thus,=20
>>>>>>>>>>>>>>> defering
>>>>>>>>>>>>>>> the
>>>>>>>>>>>>>>> removal right before the end of this schedule round.
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>> Co-developed-by: Yibo Zhao <yiboz@codeaurora.org>
>>>>>>>>>>>>>>> Signed-off-by: Yibo Zhao <yiboz@codeaurora.org>
>>>>>>>>>>>>>>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.=
dk>
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> I didn't write this patch, so please don't use my sign-off.
>>>>>>>>>>>>>> I'll
>>>>>>>>>>>>>> add
>>>>>>>>>>>>>> ack or review tags as appropriate in reply; but a few
>>>>>>>>>>>>>> comments
>>>>>>>>>>>>>> first:
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>  include/net/mac80211.h     | 16 ++++++++++--
>>>>>>>>>>>>>>>  net/mac80211/ieee80211_i.h |  3 +++
>>>>>>>>>>>>>>>  net/mac80211/main.c        |  6 +++++
>>>>>>>>>>>>>>>  net/mac80211/tx.c          | 63
>>>>>>>>>>>>>>> +++++++++++++++++++++++++++++++++++++++++++---
>>>>>>>>>>>>>>>  4 files changed, 83 insertions(+), 5 deletions(-)
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>> diff --git a/include/net/mac80211.h=20
>>>>>>>>>>>>>>> b/include/net/mac80211.h
>>>>>>>>>>>>>>> index ac2ed8e..ba5a345 100644
>>>>>>>>>>>>>>> --- a/include/net/mac80211.h
>>>>>>>>>>>>>>> +++ b/include/net/mac80211.h
>>>>>>>>>>>>>>> @@ -925,6 +925,8 @@ struct ieee80211_tx_rate {
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>  #define IEEE80211_MAX_TX_RETRY=09=0931
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>> +#define IEEE80211_AIRTIME_TXQ_RM_CHK_INTV_IN_MS 100
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>  static inline void ieee80211_rate_set_vht(struct
>>>>>>>>>>>>>>> ieee80211_tx_rate
>>>>>>>>>>>>>>> *rate,
>>>>>>>>>>>>>>>  =09=09=09=09=09  u8 mcs, u8 nss)
>>>>>>>>>>>>>>>  {
>>>>>>>>>>>>>>> @@ -6232,7 +6234,8 @@ struct sk_buff
>>>>>>>>>>>>>>> *ieee80211_tx_dequeue(struct
>>>>>>>>>>>>>>> ieee80211_hw *hw,
>>>>>>>>>>>>>>>   * @ac: AC number to return packets from.
>>>>>>>>>>>>>>>   *
>>>>>>>>>>>>>>>   * Should only be called between calls to
>>>>>>>>>>>>>>> ieee80211_txq_schedule_start()
>>>>>>>>>>>>>>> - * and ieee80211_txq_schedule_end().
>>>>>>>>>>>>>>> + * and ieee80211_txq_schedule_end(). If the txq is empty,
>>>>>>>>>>>>>>> it
>>>>>>>>>>>>>>> will
>>>>>>>>>>>>>>> be
>>>>>>>>>>>>>>> added
>>>>>>>>>>>>>>> + * to a remove list and get removed later.
>>>>>>>>>>>>>>>   * Returns the next txq if successful, %NULL if no queue=
=20
>>>>>>>>>>>>>>> is
>>>>>>>>>>>>>>> eligible.
>>>>>>>>>>>>>>> If a txq
>>>>>>>>>>>>>>>   * is returned, it should be returned with
>>>>>>>>>>>>>>> ieee80211_return_txq()
>>>>>>>>>>>>>>> after the
>>>>>>>>>>>>>>>   * driver has finished scheduling it.
>>>>>>>>>>>>>>> @@ -6268,7 +6271,8 @@ void
>>>>>>>>>>>>>>> ieee80211_txq_schedule_start(struct
>>>>>>>>>>>>>>> ieee80211_hw *hw, u8 ac)
>>>>>>>>>>>>>>>   * @hw: pointer as obtained from ieee80211_alloc_hw()
>>>>>>>>>>>>>>>   * @ac: AC number to acquire locks for
>>>>>>>>>>>>>>>   *
>>>>>>>>>>>>>>> - * Release locks previously acquired by
>>>>>>>>>>>>>>> ieee80211_txq_schedule_end().
>>>>>>>>>>>>>>> + * Release locks previously acquired by
>>>>>>>>>>>>>>> ieee80211_txq_schedule_end().
>>>>>>>>>>>>>>> Check
>>>>>>>>>>>>>>> + * and remove the empty txq from rb-tree.
>>>>>>>>>>>>>>>   */
>>>>>>>>>>>>>>>  void ieee80211_txq_schedule_end(struct ieee80211_hw *hw,=
=20
>>>>>>>>>>>>>>> u8
>>>>>>>>>>>>>>> ac)
>>>>>>>>>>>>>>>  =09__releases(txq_lock);
>>>>>>>>>>>>>>> @@ -6287,6 +6291,14 @@ void ieee80211_schedule_txq(struct
>>>>>>>>>>>>>>> ieee80211_hw
>>>>>>>>>>>>>>> *hw, struct ieee80211_txq *txq)
>>>>>>>>>>>>>>>  =09__acquires(txq_lock) __releases(txq_lock);
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>  /**
>>>>>>>>>>>>>>> + * ieee80211_txqs_check - Check txqs waiting for removal
>>>>>>>>>>>>>>> + *
>>>>>>>>>>>>>>> + * @tmr: pointer as obtained from local
>>>>>>>>>>>>>>> + *
>>>>>>>>>>>>>>> + */
>>>>>>>>>>>>>>> +void ieee80211_txqs_check(struct timer_list *tmr);
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +/**
>>>>>>>>>>>>>>>   * ieee80211_txq_may_transmit - check whether TXQ is
>>>>>>>>>>>>>>> allowed
>>>>>>>>>>>>>>> to
>>>>>>>>>>>>>>> transmit
>>>>>>>>>>>>>>>   *
>>>>>>>>>>>>>>>   * This function is used to check whether given txq is
>>>>>>>>>>>>>>> allowed
>>>>>>>>>>>>>>> to
>>>>>>>>>>>>>>> transmit by
>>>>>>>>>>>>>>> diff --git a/net/mac80211/ieee80211_i.h
>>>>>>>>>>>>>>> b/net/mac80211/ieee80211_i.h
>>>>>>>>>>>>>>> index a4556f9..49aa143e 100644
>>>>>>>>>>>>>>> --- a/net/mac80211/ieee80211_i.h
>>>>>>>>>>>>>>> +++ b/net/mac80211/ieee80211_i.h
>>>>>>>>>>>>>>> @@ -847,6 +847,7 @@ struct txq_info {
>>>>>>>>>>>>>>>  =09struct codel_stats cstats;
>>>>>>>>>>>>>>>  =09struct sk_buff_head frags;
>>>>>>>>>>>>>>>  =09struct rb_node schedule_order;
>>>>>>>>>>>>>>> +=09struct list_head candidate;
>>>>>>>>>>>>>>>  =09unsigned long flags;
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>  =09/* keep last! */
>>>>>>>>>>>>>>> @@ -1145,6 +1146,8 @@ struct ieee80211_local {
>>>>>>>>>>>>>>>  =09u64 airtime_v_t[IEEE80211_NUM_ACS];
>>>>>>>>>>>>>>>  =09u64 airtime_weight_sum[IEEE80211_NUM_ACS];
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>> +=09struct list_head remove_list[IEEE80211_NUM_ACS];
>>>>>>>>>>>>>>> +=09struct timer_list remove_timer;
>>>>>>>>>>>>>>>  =09u16 airtime_flags;
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>  =09const struct ieee80211_ops *ops;
>>>>>>>>>>>>>>> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
>>>>>>>>>>>>>>> index e9ffa8e..78fe24a 100644
>>>>>>>>>>>>>>> --- a/net/mac80211/main.c
>>>>>>>>>>>>>>> +++ b/net/mac80211/main.c
>>>>>>>>>>>>>>> @@ -667,10 +667,15 @@ struct ieee80211_hw
>>>>>>>>>>>>>>> *ieee80211_alloc_hw_nm(size_t priv_data_len,
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>  =09for (i =3D 0; i < IEEE80211_NUM_ACS; i++) {
>>>>>>>>>>>>>>>  =09=09local->active_txqs[i] =3D RB_ROOT_CACHED;
>>>>>>>>>>>>>>> +=09=09INIT_LIST_HEAD(&local->remove_list[i]);
>>>>>>>>>>>>>>>  =09=09spin_lock_init(&local->active_txq_lock[i]);
>>>>>>>>>>>>>>>  =09}
>>>>>>>>>>>>>>>  =09local->airtime_flags =3D AIRTIME_USE_TX | AIRTIME_USE_R=
X;
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>> +=09timer_setup(&local->remove_timer, ieee80211_txqs_check,
>>>>>>>>>>>>>>> 0);
>>>>>>>>>>>>>>> +=09mod_timer(&local->remove_timer,
>>>>>>>>>>>>>>> +=09=09  jiffies +
>>>>>>>>>>>>>>> msecs_to_jiffies(IEEE80211_AIRTIME_TXQ_RM_CHK_INTV_IN_MS));
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>  =09INIT_LIST_HEAD(&local->chanctx_list);
>>>>>>>>>>>>>>>  =09mutex_init(&local->chanctx_mtx);
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>> @@ -1305,6 +1310,7 @@ void ieee80211_unregister_hw(struct
>>>>>>>>>>>>>>> ieee80211_hw
>>>>>>>>>>>>>>> *hw)
>>>>>>>>>>>>>>>  =09tasklet_kill(&local->tx_pending_tasklet);
>>>>>>>>>>>>>>>  =09tasklet_kill(&local->tasklet);
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>> +=09del_timer_sync(&local->remove_timer);
>>>>>>>>>>>>>>>  #ifdef CONFIG_INET
>>>>>>>>>>>>>>>  =09unregister_inetaddr_notifier(&local->ifa_notifier);
>>>>>>>>>>>>>>>  #endif
>>>>>>>>>>>>>>> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
>>>>>>>>>>>>>>> index d00baaa..42ca010 100644
>>>>>>>>>>>>>>> --- a/net/mac80211/tx.c
>>>>>>>>>>>>>>> +++ b/net/mac80211/tx.c
>>>>>>>>>>>>>>> @@ -1450,6 +1450,7 @@ void ieee80211_txq_init(struct
>>>>>>>>>>>>>>> ieee80211_sub_if_data *sdata,
>>>>>>>>>>>>>>>  =09codel_stats_init(&txqi->cstats);
>>>>>>>>>>>>>>>  =09__skb_queue_head_init(&txqi->frags);
>>>>>>>>>>>>>>>  =09RB_CLEAR_NODE(&txqi->schedule_order);
>>>>>>>>>>>>>>> +=09INIT_LIST_HEAD(&txqi->candidate);
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>  =09txqi->txq.vif =3D &sdata->vif;
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>> @@ -3724,6 +3725,9 @@ void ieee80211_schedule_txq(struct
>>>>>>>>>>>>>>> ieee80211_hw
>>>>>>>>>>>>>>> *hw,
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>  =09spin_lock_bh(&local->active_txq_lock[ac]);
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>> +=09if (!list_empty(&txqi->candidate))
>>>>>>>>>>>>>>> +=09=09list_del_init(&txqi->candidate);
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>  =09if (!RB_EMPTY_NODE(&txqi->schedule_order))
>>>>>>>>>>>>>>>  =09=09goto out;
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>> @@ -3783,6 +3787,20 @@ static void
>>>>>>>>>>>>>>> __ieee80211_unschedule_txq(struct
>>>>>>>>>>>>>>> ieee80211_hw *hw,
>>>>>>>>>>>>>>>  =09RB_CLEAR_NODE(&txqi->schedule_order);
>>>>>>>>>>>>>>>  }
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>> +void ieee80211_remove_txq(struct ieee80211_hw *hw,
>>>>>>>>>>>>>>> +=09=09=09  struct ieee80211_txq *txq)
>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>> +=09struct ieee80211_local *local =3D hw_to_local(hw);
>>>>>>>>>>>>>>> +=09struct txq_info *txqi =3D to_txq_info(txq);
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=09lockdep_assert_held(&local->active_txq_lock[txq->ac]);
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=09if (!RB_EMPTY_NODE(&txqi->schedule_order)) {
>>>>>>>>>>>>>>> +=09=09__ieee80211_unschedule_txq(hw, txq);
>>>>>>>>>>>>>>> +=09=09list_del_init(&txqi->candidate);
>>>>>>>>>>>>>>> +=09}
>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>  void ieee80211_unschedule_txq(struct ieee80211_hw *hw,
>>>>>>>>>>>>>>>  =09=09=09      struct ieee80211_txq *txq)
>>>>>>>>>>>>>>>  =09__acquires(txq_lock) __releases(txq_lock)
>>>>>>>>>>>>>>> @@ -3790,7 +3808,7 @@ void ieee80211_unschedule_txq(struct
>>>>>>>>>>>>>>> ieee80211_hw *hw,
>>>>>>>>>>>>>>>  =09struct ieee80211_local *local =3D hw_to_local(hw);
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>  =09spin_lock_bh(&local->active_txq_lock[txq->ac]);
>>>>>>>>>>>>>>> -=09__ieee80211_unschedule_txq(hw, txq);
>>>>>>>>>>>>>>> +=09ieee80211_remove_txq(hw, txq);
>>>>>>>>>>>>>>>  =09spin_unlock_bh(&local->active_txq_lock[txq->ac]);
>>>>>>>>>>>>>>>  }
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>> @@ -3803,11 +3821,48 @@ void ieee80211_return_txq(struct
>>>>>>>>>>>>>>> ieee80211_hw
>>>>>>>>>>>>>>> *hw,
>>>>>>>>>>>>>>>  =09lockdep_assert_held(&local->active_txq_lock[txq->ac]);
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>  =09if (!RB_EMPTY_NODE(&txqi->schedule_order) &&
>>>>>>>>>>>>>>> -=09    (skb_queue_empty(&txqi->frags) &&
>>>>>>>>>>>>>>> !txqi->tin.backlog_packets))
>>>>>>>>>>>>>>> -=09=09__ieee80211_unschedule_txq(hw, txq);
>>>>>>>>>>>>>>> +=09=09!txq_has_queue(&txqi->txq) &&
>>>>>>>>>>>>>>> +=09=09list_empty(&txqi->candidate))
>>>>>>>>>>>>>>> +=09=09list_add_tail(&txqi->candidate,
>>>>>>>>>>>>>>> &local->remove_list[txq->ac]);
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>  }
>>>>>>>>>>>>>>>  EXPORT_SYMBOL(ieee80211_return_txq);
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>> +void __ieee80211_check_txqs(struct ieee80211_local=20
>>>>>>>>>>>>>>> *local,
>>>>>>>>>>>>>>> int
>>>>>>>>>>>>>>> ac)
>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>> +=09struct txq_info *iter, *tmp;
>>>>>>>>>>>>>>> +=09struct sta_info *sta;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=09lockdep_assert_held(&local->active_txq_lock[ac]);
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=09list_for_each_entry_safe(iter, tmp,
>>>>>>>>>>>>>>> &local->remove_list[ac],
>>>>>>>>>>>>>>> +=09=09=09=09 candidate) {
>>>>>>>>>>>>>>> +=09=09sta =3D container_of(iter->txq.sta, struct sta_info,=
=20
>>>>>>>>>>>>>>> sta);
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=09=09if (txq_has_queue(&iter->txq))
>>>>>>>>>>>>>>> +=09=09=09list_del_init(&iter->candidate);
>>>>>>>>>>>>>>> +=09=09else
>>>>>>>>>>>>>>> +=09=09=09ieee80211_remove_txq(&local->hw, &iter->txq);
>>>>>>>>>>>>>>> +=09}
>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +void ieee80211_txqs_check(struct timer_list *t)
>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>> +=09struct ieee80211_local *local =3D from_timer(local, t,
>>>>>>>>>>>>>>> remove_timer);
>>>>>>>>>>>>>>> +=09struct txq_info *iter, *tmp;
>>>>>>>>>>>>>>> +=09struct sta_info *sta;
>>>>>>>>>>>>>>> +=09int ac;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=09for (ac =3D 0; ac < IEEE80211_NUM_ACS; ac++) {
>>>>>>>>>>>>>>> +=09=09spin_lock_bh(&local->active_txq_lock[ac]);
>>>>>>>>>>>>>>> +=09=09__ieee80211_check_txqs(local, ac);
>>>>>>>>>>>>>>> +=09=09spin_unlock_bh(&local->active_txq_lock[ac]);
>>>>>>>>>>>>>>> +=09}
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +=09mod_timer(&local->remove_timer,
>>>>>>>>>>>>>>> +=09=09  jiffies +
>>>>>>>>>>>>>>> msecs_to_jiffies(IEEE80211_AIRTIME_TXQ_RM_CHK_INTV_IN_MS));
>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> I'll ask the same as I did last time (where you told me to
>>>>>>>>>>>>>> hold
>>>>>>>>>>>>>> off
>>>>>>>>>>>>>> until this round):
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> Why do you need the timer and the periodic check? If TXQs=20
>>>>>>>>>>>>>> are
>>>>>>>>>>>>>> added
>>>>>>>>>>>>>> to
>>>>>>>>>>>>>> the remove list during the scheduling run, and
>>>>>>>>>>>>>> __ieee80211_check_txqs()
>>>>>>>>>>>>>> is run from schedule_end(), isn't that sufficient to clear
>>>>>>>>>>>>>> the
>>>>>>>>>>>>>> list?
>>>>>>>>>>>>> Is it possible that a txq is not added to the remove list=20
>>>>>>>>>>>>> but
>>>>>>>>>>>>> then
>>>>>>>>>>>>> packets in it are dropped by fq_codel algo? Like the station
>>>>>>>>>>>>> disconnects
>>>>>>>>>>>>> without any notification.
>>>>>>>>>>>>=20
>>>>>>>>>>>> Well as long as all the other cleanup paths call directly=20
>>>>>>>>>>>> into
>>>>>>>>>>>> __unschedule_txq(), that should remove stations from the
>>>>>>>>>>>> scheduler
>>>>>>>>>>>> when
>>>>>>>>>>>> they disconnect etc.
>>>>>>>>>>> Yes, the disconnect scenario is a bad example. My concern is,
>>>>>>>>>>> say,
>>>>>>>>>>> we
>>>>>>>>>>> have 10 stations and only one of them is assigned a very small
>>>>>>>>>>> weight
>>>>>>>>>>> compared with that of others. Suppose, after its chance of Tx,
>>>>>>>>>>> it
>>>>>>>>>>> is
>>>>>>>>>>> most likely to be placed in the rightmost(still has some=20
>>>>>>>>>>> packets
>>>>>>>>>>> in
>>>>>>>>>>> the
>>>>>>>>>>> txq) and no more incoming data for it. The remaining packets=20
>>>>>>>>>>> in
>>>>>>>>>>> txq
>>>>>>>>>>> will
>>>>>>>>>>> be dropped due to timeout algo in codel(correct me if I am
>>>>>>>>>>> wrong)
>>>>>>>>>>> but
>>>>>>>>>>> this empty txq will stay on the rbtree until other txqs get
>>>>>>>>>>> drained
>>>>>>>>>>> or
>>>>>>>>>>> global vt catch up with its vt. The staying time could be long
>>>>>>>>>>> if
>>>>>>>>>>> weight
>>>>>>>>>>> is extremely small. Then do we need timer to check or any=20
>>>>>>>>>>> other
>>>>>>>>>>> better
>>>>>>>>>>> solution?
>>>>>>>>>>=20
>>>>>>>>>> Ah, I see what you mean. No, I don't think this will be a
>>>>>>>>>> problem;
>>>>>>>>>> the
>>>>>>>>>> scenario you're describing would play out like this:
>>>>>>>>>>=20
>>>>>>>>>> 1. Station ends transmitting, still has a single packet queued,
>>>>>>>>>> gets
>>>>>>>>>>    moved to the end of the rbtree (and stays there for a=20
>>>>>>>>>> while).
>>>>>>>>>>=20
>>>>>>>>>> 2. When we finally get to the point where this station gets
>>>>>>>>>> another
>>>>>>>>>>    chance to transmit, the CoDel drop timer triggers and the=20
>>>>>>>>>> last
>>>>>>>>>> packet
>>>>>>>>>>    is dropped[0]. This means that the queue will just be empty
>>>>>>>>>>    (and ieee80211_tx_dequeue() will return NULL).
>>>>>>>>>>=20
>>>>>>>>>> 3. Because the queue is empty, ieee80211_return_txq() will not
>>>>>>>>>> put
>>>>>>>>>> it
>>>>>>>>>>    back on the rbtree.
>>>>>>>>>>=20
>>>>>>>>>> Crucially, in 2. the CoDel algorithm doesn't kick in until the
>>>>>>>>>> point
>>>>>>>>>> of
>>>>>>>>>> packet dequeue. But even if an empty queue stays on the rbtree
>>>>>>>>>> for
>>>>>>>>>> a
>>>>>>>>>> while, there is no harm in that: eventually it will get its=20
>>>>>>>>>> turn,
>>>>>>>>>> it
>>>>>>>>>> will turn out to be empty, and just be skipped over.
>>>>>>>>> Then that will be fine. Thanks for the explanation of the=20
>>>>>>>>> dropping
>>>>>>>>> part
>>>>>>>>> in CoDel algorithm.
>>>>>>>>=20
>>>>>>>> Yup, think so. And you're welcome :)
>>>>>>>>=20
>>>>>>>>>> The issue we need to be concerned about is the opposite: If we
>>>>>>>>>> have
>>>>>>>>>> a
>>>>>>>>>> queue that *does* have packets queued, but which is *not*
>>>>>>>>>> scheduled
>>>>>>>>>> for
>>>>>>>>>> transmission, that will stall TX.
>>>>>>>>> Is it by design since its vt is more than global vt, right? The
>>>>>>>>> lattency
>>>>>>>>> may somehow get impacted though.
>>>>>>>>=20
>>>>>>>> Well, it should still stay on the rbtree as long as it has=20
>>>>>>>> packets
>>>>>>>> queued. We don't have a check anywhere that reschedules TXQs=20
>>>>>>>> whose
>>>>>>>> v_t
>>>>>>>> drops below global v_t...
>>>>>>>>=20
>>>>>>>>>> [0] CoDel in most cases only drops a single packet at a time,=20
>>>>>>>>>> so
>>>>>>>>>> it
>>>>>>>>>> will
>>>>>>>>>> not clear out an entire queue with multiple packets in one go.
>>>>>>>>>> But
>>>>>>>>>> you
>>>>>>>>>> are right that it could conceivably drop the last packet in a
>>>>>>>>>> queue.
>>>>>>>>>>=20
>>>>>>>>>>>> We only need to defer removal inside a single "scheduling
>>>>>>>>>>>> round"
>>>>>>>>>>>> (i.e.,
>>>>>>>>>>>> between a pair of ieee80211_txq_schedule_start/end. So if we
>>>>>>>>>>>> just
>>>>>>>>>>>> walk
>>>>>>>>>>>> the remove list in schedule_end() we should be enough, no?
>>>>>>>>>>>>=20
>>>>>>>>>>>> Hmm, or maybe a simpler way to fix the original issue is just
>>>>>>>>>>>> to
>>>>>>>>>>>> have
>>>>>>>>>>>> unschedule_txq() update the schedule_pos() pointer?
>>>>>>>>>>>>=20
>>>>>>>>>>>> I.e., unschedule_txq checks if the txq being removed is
>>>>>>>>>>>> currently
>>>>>>>>>>>> being
>>>>>>>>>>>> pointed to by schedule_pos[ac], and if it is, it updates
>>>>>>>>>>>> schedule_pos
>>>>>>>>>>>> to
>>>>>>>>>>>> be the rb_next of the current value?
>>>>>>>>>>> Actually, if schedule_pos is updated to rb_next of the current
>>>>>>>>>>> value,
>>>>>>>>>>> then in the next_txq() where we are going to use rb_next again
>>>>>>>>>>> and
>>>>>>>>>>> finally pick the next node of the node we really want. Is it
>>>>>>>>>>> fine
>>>>>>>>>>> to
>>>>>>>>>>> update schedule_pos to NULL?
>>>>>>>>>>=20
>>>>>>>>>> Hmm, yeah, good point.
>>>>>>>>>>=20
>>>>>>>>>> If we do end up setting schedule_pos to NULL in the middle of a
>>>>>>>>>> scheduling round, that will make next_txq() "start over", and=20
>>>>>>>>>> do
>>>>>>>>>> another
>>>>>>>>>> loop through the whole thing. I guess we may be able hit a case
>>>>>>>>>> where
>>>>>>>>>> things can oscillate back and forth between addition and=20
>>>>>>>>>> removal
>>>>>>>>>> resulting in an infinite loop? Not sure, but at least I can't
>>>>>>>>>> seem
>>>>>>>>>> to
>>>>>>>>>> convince myself that this can't happen.
>>>>>>>>>=20
>>>>>>>>> As the loop of next_txq under lock protection as below,
>>>>>>>>>=20
>>>>>>>>> txq_schedule_start();
>>>>>>>>> while(txq=3Dnext_txq()){
>>>>>>>>> ...
>>>>>>>>> return_txq(txq);
>>>>>>>>> }
>>>>>>>>> txq_schedule_end();
>>>>>>>>>=20
>>>>>>>>> I do not see any chance of addition, no?
>>>>>>>>=20
>>>>>>>> As you noted in your other email, Felix reduced the locking. And
>>>>>>>> yeah,
>>>>>>>> we need to rebase this series to also incorporate that. I figure=
=20
>>>>>>>> I
>>>>>>>> can
>>>>>>>> send an updated version of the first patch in the series once=20
>>>>>>>> we've
>>>>>>>> worked out the remaining issues with your follow-up patches.
>>>>>>>>=20
>>>>>>> Oh, I was thinking we were discussing without locking reduced.=20
>>>>>>> Yes,
>>>>>>> I
>>>>>>> also agree there might be a case causing infinite loop. With=20
>>>>>>> locking
>>>>>>> reduced, the tree can be adjusted between next_txq() and
>>>>>>> return_txq()
>>>>>>> in
>>>>>>> the loop situation. For further discussion, let 's consider,
>>>>>>> 1) the tree starts like:
>>>>>>>         A->B->C->D->E
>>>>>>> 2) then next_txq() returns A for dequeuing
>>>>>>> 3) driver dequeues A and draines A without any active txq locked
>>>>>>> meaning
>>>>>>> the tree could be changed upon Tx compeletion.
>>>>>>> 4) then in return_txq(), the tree could be,
>>>>>>>         i   A->B->C->D->E =EF=BC=88A is empty, and maybe soon be ad=
ded=20
>>>>>>> back
>>>>>>> before the loop end=EF=BC=89
>>>>>>>         ii  B->C->A->D->E =EF=BC=88A is empty, and maybe soon be ad=
ded=20
>>>>>>> back
>>>>>>> before the loop end=EF=BC=89
>>>>>>>         iii B->C->D->E->A =EF=BC=88A is empty, and maybe soon be ad=
ded=20
>>>>>>> back
>>>>>>> before the loop end)
>>>>>>>=20
>>>>>>> with this change:
>>>>>>>   local->schedule_pos[ac] =3D rb_next(node) ?: rb_prev(node);
>>>>>>>=20
>>>>>>> for case i, local->schedule_pos[ac] is rb_next(A) which is B, and=
=20
>>>>>>> in
>>>>>>> next_txq(), rb_next(B) is what we returns which actually is C and=
=20
>>>>>>> B
>>>>>>> is
>>>>>>> skipped, no?
>>>>>>>=20
>>>>>>> Similiar for case ii, we skip B, C, D.
>>>>>>=20
>>>>>> Yup, I think you're right. But if we can fix this by making
>>>>>> ieee80211_resort_txq() aware of the schedule_pos as well, no? I.e.,
>>>>>> if
>>>>>> resort_txq() acts on the txq that's currently in schedule_pos, it
>>>>>> will
>>>>>> update schedule pos with the same rb_next(node) ?: rb_prev(node);
>>>>>> (optionally after checking that the position of the node is=20
>>>>>> actually
>>>>>> going to change).
>>>>> Sorry, please igore last email sent by mistake.
>>>>>=20
>>>>> I don't think it makes any difference with that in unschedule_txq().
>>>>> For
>>>>> case i, it finally picks C as well in next_txq(). For next_txq(),
>>>>> schedule_pos means previous candidate node whereas with your change,
>>>>> it
>>>>> looks like schedule_pos is current candidate node instead.
>>>>=20
>>>> Hmm, that was not actually what I was thinking, but yeah I think=20
>>>> you're
>>>> right that it would be easier to just change it so schedule_pos is
>>>> pointing to the next and not the current txq we want to schedule.
>>> So do you mean we can change next_txq like this,
>>>=20
>>>   struct ieee80211_txq *ieee80211_next_txq(struct ieee80211_hw *hw, u8
>>> ac)
>>>   {
>>>   =09struct ieee80211_local *local =3D hw_to_local(hw);
>>> =09struct rb_node *node =3D local->schedule_pos[ac];
>>>   =09struct txq_info *txqi =3D NULL;
>>> =09bool first =3D false;
>>>=20
>>>   =09lockdep_assert_held(&local->active_txq_lock[ac]);
>>>=20
>>> =09if (!node) {
>>> =09        node =3D rb_first_cached(&local->active_txqs[ac]);
>>> =09=09first =3D true;
>>> -=09} else
>>> -=09=09node =3D rb_next(node);
>>> +       }
>>> +
>>> =09if (!node)
>>>   =09=09return NULL;
>>=20
>> Ah, no, now I remember why this didn't work and I went with the other
>> approach: If you make this change, you also have to have this at the
>> end:
>>=20
>> local->schedule_pos[ac] =3D rb_next(node);
>>=20
>>=20
>> But this means we can no longer distinguish between having gone through
>> the whole thing (so rb_next() returns NULL), or starting out with
>> nothing.
>>=20
>> So, instead we need to keep next_txq() the way it is, and just add
>
> Right, should keep next_txq() the way it is.
>
>>=20
>> local->schedule_pos[ac] =3D rb_prev(node);
>>=20
>> whenever we remove a node (both in return_txq() and resort_txq()).
>
> Agree, and also we may need to consider case like A is removed and soon=
=20
> be added back just the same as ii),
>         B->C->A->D->E
> then B is schedule, removed and soon added back,
>         C->A->B->D->E
> A and B will have a second chance to be scheduled and this may happen to=
=20
> others as well leading to the infinite loop as you have mentioned=20
> previously, so do we need to maintain a schedule_round like we do in=20
> DRR? Like,
>      - If the node is in the same round, by pass schedule, go to=20
> rb_next(), either continue loop this round or end this round.
>      - Increase the schedule_round at the schedule_start() only when the=
=20
> schedule_pos is NULL.

Hmm, yeah, I guess we could end up with a loop like that as well.
Keeping the schedule_round would be a way to fix it, but I'm not sure we
should just skip that station; maybe we should just end the round
instead?

>>>> We'd still need a check in resort_txq() then, but it would make it=20
>>>> safe
>>>> to unschedule in return_txq()...
>>> Yes, agree with that.
>>>=20
>>>=20
>>>>=20
>>>>>>> Also I am wondering if there will be some SMP issues relating with
>>>>>>> local->schedule_pos[ac].
>>>>>>=20
>>>>>> Not sure what you mean by this?
>>>>> My bad. Please ignore this.
>>>>>=20
>>>>>=20
>>>>>>=20
>>>>>>>>> In ath10k, we will usually push packets of first txq as many as=
=20
>>>>>>>>> we
>>>>>>>>> can
>>>>>>>>> until it is drained and then move to the next one. So if a txq
>>>>>>>>> gets
>>>>>>>>> removed in the return_txq, it should always be the leftmost. And
>>>>>>>>> during this period, neither vt of any station or global vt can=20
>>>>>>>>> be
>>>>>>>>> updated due to lock protection.
>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>> But in that case, we could fix it by just conditionally=20
>>>>>>>>>> assigning
>>>>>>>>>> either
>>>>>>>>>> rb_next or rb_prev to the schedule_pos in unschedule_txq()?=20
>>>>>>>>>> I.e.,
>>>>>>>>>> something like:
>>>>>>>>>>=20
>>>>>>>>>> local->schedule_pos[ac] =3D rb_next(node) ?: rb_prev(node);
>>>>>>>>> I am not sure I am getting your point. Still in next_txq,
>>>>>>>>> schedule_pos[ac] will lead us to the next node of the one we=20
>>>>>>>>> want.
>>>>>>>>=20
>>>>>>>> The logic in next_txq is different when schedule_pos[ac] is NULL,
>>>>>>>> vs
>>>>>>>> when rb_next(schedule_pos[ac]) is NULL. The former restarts a new
>>>>>>>> scheduling round, while the latter ends the current round.
>>>>>>>>=20
>>>>>>>> -Toke
>>>>>>>=20
>>>>>>> --
>>>>>>> Yibo
>>>>>=20
>>>>> --
>>>>> Yibo
>>>=20
>>> --
>>> Yibo
>
> --=20
> Yibo

