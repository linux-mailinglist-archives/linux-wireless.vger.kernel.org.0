Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACE94B9DF3
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Sep 2019 15:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437905AbfIUNCa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Sep 2019 09:02:30 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58265 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407608AbfIUNCa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Sep 2019 09:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569070947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1EkuGy/jfM7h0SlVZtT8YJAWc1whOmspOUu8Q96sDog=;
        b=EH96H+JnbIAoIzeFMpmFCSLQHrLPh3wCx+pRPih7uXmw+XUecIMkkpk1TNS3XjTZWND4Ob
        b19FtytENfVeqjEF3gmEk1E2CSSjA7maNR1g38iJg78+uzvozximOo2K7EWrGU7zgOof7X
        i7Msneg9l137ChC1lILkJBkD+XPpgm8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-84gE_DEiOGKW_hh39fFrOQ-1; Sat, 21 Sep 2019 09:02:25 -0400
Received: by mail-ed1-f71.google.com with SMTP id t13so6025737edr.2
        for <linux-wireless@vger.kernel.org>; Sat, 21 Sep 2019 06:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0ZwSOWPUFV0LOs4ZTLRr2CBUyrIHwJkAT3JbmyNf9dY=;
        b=hU4XBY7Kl92Ls5iAc06ULX8X7hBQjeYEV4umok5G0xjZkJ3L52j+H+PTaMO+nZBuFK
         YMrBu+8Ii3+HvRhLUU4LlH/bXBfu9kTyXcXY0VKSMTHwdl3BiDkVTtQNqX2jwWHOCMw0
         DCsrEKMCtV54c9Si6/xv5Uw3hjP0o7gFXS50rdmDSmIolYFji+R6c0XPTMIPqueiFDpn
         B039XITEUPOKhogjX5f4FEswRgvD6uttzcD/sGEoXQ/ScyMJASdHGYamwuVNUvINipbD
         zH2VvF1YeqmROa8rU0l87b3J04GOTgj4x68AmfFQ4xl32tkPbdJceaOUX1bbbPK7REvg
         pSGw==
X-Gm-Message-State: APjAAAWdtvCK2W53P2K/YQXQjdjgygOaXKKwhg8P7q6PUl81/ePbCt6z
        RCdWkNotUBX5qCTfIkhV20TPRnGtZxdG18ST4sFXndSD7Hqg6dQD6JEl426R2uC2f8ry1yKYyqq
        vcaCBOKfd+RPF/cmCWcbbDQakF2k=
X-Received: by 2002:a17:906:454c:: with SMTP id s12mr7889164ejq.69.1569070943728;
        Sat, 21 Sep 2019 06:02:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwlvkaZWM86kP5NMQyoyvj9ZcIpg5oNM8VcVlsrN/6Qc7IEfrpzdjLoB9JDkW4DqeJxF1WM6w==
X-Received: by 2002:a17:906:454c:: with SMTP id s12mr7889133ejq.69.1569070943344;
        Sat, 21 Sep 2019 06:02:23 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id a3sm233744edk.51.2019.09.21.06.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2019 06:02:22 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1B84E18063F; Sat, 21 Sep 2019 15:02:21 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Yibo Zhao <yiboz@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH 2/4] mac80211: defer txqs removal from rbtree
In-Reply-To: <4574cce4079f8dab2b2bf223431a6eae@codeaurora.org>
References: <1568639388-27291-1-git-send-email-yiboz@codeaurora.org> <1568639388-27291-2-git-send-email-yiboz@codeaurora.org> <87pnjyiq7o.fsf@toke.dk> <c3ee7ece0986f1c50513cd5fdd2ee03f@codeaurora.org> <87sgothmpy.fsf@toke.dk> <8cdece5c030fd95817fb099021c38613@codeaurora.org> <87tv98fu6l.fsf@toke.dk> <1b4ab006d9b5c88035845aaac193ef48@codeaurora.org> <8736gre3bm.fsf@toke.dk> <198124204167325252fcfcd65e3f2733@codeaurora.org> <87ftkp7uuz.fsf@toke.dk> <4574cce4079f8dab2b2bf223431a6eae@codeaurora.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 21 Sep 2019 15:02:21 +0200
Message-ID: <877e617qg2.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: 84gE_DEiOGKW_hh39fFrOQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yibo Zhao <yiboz@codeaurora.org> writes:

> On 2019-09-21 19:27, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>=20
>>> On 2019-09-20 17:15, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>=20
>>>>> On 2019-09-19 18:37, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>>=20
>>>>>>> On 2019-09-18 19:23, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>>>>=20
>>>>>>>>> On 2019-09-18 05:10, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>>>>>>=20
>>>>>>>>>>> In a loop txqs dequeue scenario, if the first txq in the=20
>>>>>>>>>>> rbtree
>>>>>>>>>>> gets
>>>>>>>>>>> removed from rbtree immediately in the ieee80211_return_txq(),
>>>>>>>>>>> the
>>>>>>>>>>> loop will break soon in the ieee80211_next_txq() due to
>>>>>>>>>>> schedule_pos
>>>>>>>>>>> not leading to the second txq in the rbtree. Thus, defering=20
>>>>>>>>>>> the
>>>>>>>>>>> removal right before the end of this schedule round.
>>>>>>>>>>>=20
>>>>>>>>>>> Co-developed-by: Yibo Zhao <yiboz@codeaurora.org>
>>>>>>>>>>> Signed-off-by: Yibo Zhao <yiboz@codeaurora.org>
>>>>>>>>>>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
>>>>>>>>>>=20
>>>>>>>>>> I didn't write this patch, so please don't use my sign-off.=20
>>>>>>>>>> I'll
>>>>>>>>>> add
>>>>>>>>>> ack or review tags as appropriate in reply; but a few comments
>>>>>>>>>> first:
>>>>>>>>>>=20
>>>>>>>>>>> ---
>>>>>>>>>>>  include/net/mac80211.h     | 16 ++++++++++--
>>>>>>>>>>>  net/mac80211/ieee80211_i.h |  3 +++
>>>>>>>>>>>  net/mac80211/main.c        |  6 +++++
>>>>>>>>>>>  net/mac80211/tx.c          | 63
>>>>>>>>>>> +++++++++++++++++++++++++++++++++++++++++++---
>>>>>>>>>>>  4 files changed, 83 insertions(+), 5 deletions(-)
>>>>>>>>>>>=20
>>>>>>>>>>> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
>>>>>>>>>>> index ac2ed8e..ba5a345 100644
>>>>>>>>>>> --- a/include/net/mac80211.h
>>>>>>>>>>> +++ b/include/net/mac80211.h
>>>>>>>>>>> @@ -925,6 +925,8 @@ struct ieee80211_tx_rate {
>>>>>>>>>>>=20
>>>>>>>>>>>  #define IEEE80211_MAX_TX_RETRY=09=0931
>>>>>>>>>>>=20
>>>>>>>>>>> +#define IEEE80211_AIRTIME_TXQ_RM_CHK_INTV_IN_MS 100
>>>>>>>>>>> +
>>>>>>>>>>>  static inline void ieee80211_rate_set_vht(struct
>>>>>>>>>>> ieee80211_tx_rate
>>>>>>>>>>> *rate,
>>>>>>>>>>>  =09=09=09=09=09  u8 mcs, u8 nss)
>>>>>>>>>>>  {
>>>>>>>>>>> @@ -6232,7 +6234,8 @@ struct sk_buff
>>>>>>>>>>> *ieee80211_tx_dequeue(struct
>>>>>>>>>>> ieee80211_hw *hw,
>>>>>>>>>>>   * @ac: AC number to return packets from.
>>>>>>>>>>>   *
>>>>>>>>>>>   * Should only be called between calls to
>>>>>>>>>>> ieee80211_txq_schedule_start()
>>>>>>>>>>> - * and ieee80211_txq_schedule_end().
>>>>>>>>>>> + * and ieee80211_txq_schedule_end(). If the txq is empty, it
>>>>>>>>>>> will
>>>>>>>>>>> be
>>>>>>>>>>> added
>>>>>>>>>>> + * to a remove list and get removed later.
>>>>>>>>>>>   * Returns the next txq if successful, %NULL if no queue is
>>>>>>>>>>> eligible.
>>>>>>>>>>> If a txq
>>>>>>>>>>>   * is returned, it should be returned with
>>>>>>>>>>> ieee80211_return_txq()
>>>>>>>>>>> after the
>>>>>>>>>>>   * driver has finished scheduling it.
>>>>>>>>>>> @@ -6268,7 +6271,8 @@ void ieee80211_txq_schedule_start(struct
>>>>>>>>>>> ieee80211_hw *hw, u8 ac)
>>>>>>>>>>>   * @hw: pointer as obtained from ieee80211_alloc_hw()
>>>>>>>>>>>   * @ac: AC number to acquire locks for
>>>>>>>>>>>   *
>>>>>>>>>>> - * Release locks previously acquired by
>>>>>>>>>>> ieee80211_txq_schedule_end().
>>>>>>>>>>> + * Release locks previously acquired by
>>>>>>>>>>> ieee80211_txq_schedule_end().
>>>>>>>>>>> Check
>>>>>>>>>>> + * and remove the empty txq from rb-tree.
>>>>>>>>>>>   */
>>>>>>>>>>>  void ieee80211_txq_schedule_end(struct ieee80211_hw *hw, u8=20
>>>>>>>>>>> ac)
>>>>>>>>>>>  =09__releases(txq_lock);
>>>>>>>>>>> @@ -6287,6 +6291,14 @@ void ieee80211_schedule_txq(struct
>>>>>>>>>>> ieee80211_hw
>>>>>>>>>>> *hw, struct ieee80211_txq *txq)
>>>>>>>>>>>  =09__acquires(txq_lock) __releases(txq_lock);
>>>>>>>>>>>=20
>>>>>>>>>>>  /**
>>>>>>>>>>> + * ieee80211_txqs_check - Check txqs waiting for removal
>>>>>>>>>>> + *
>>>>>>>>>>> + * @tmr: pointer as obtained from local
>>>>>>>>>>> + *
>>>>>>>>>>> + */
>>>>>>>>>>> +void ieee80211_txqs_check(struct timer_list *tmr);
>>>>>>>>>>> +
>>>>>>>>>>> +/**
>>>>>>>>>>>   * ieee80211_txq_may_transmit - check whether TXQ is allowed=
=20
>>>>>>>>>>> to
>>>>>>>>>>> transmit
>>>>>>>>>>>   *
>>>>>>>>>>>   * This function is used to check whether given txq is=20
>>>>>>>>>>> allowed
>>>>>>>>>>> to
>>>>>>>>>>> transmit by
>>>>>>>>>>> diff --git a/net/mac80211/ieee80211_i.h
>>>>>>>>>>> b/net/mac80211/ieee80211_i.h
>>>>>>>>>>> index a4556f9..49aa143e 100644
>>>>>>>>>>> --- a/net/mac80211/ieee80211_i.h
>>>>>>>>>>> +++ b/net/mac80211/ieee80211_i.h
>>>>>>>>>>> @@ -847,6 +847,7 @@ struct txq_info {
>>>>>>>>>>>  =09struct codel_stats cstats;
>>>>>>>>>>>  =09struct sk_buff_head frags;
>>>>>>>>>>>  =09struct rb_node schedule_order;
>>>>>>>>>>> +=09struct list_head candidate;
>>>>>>>>>>>  =09unsigned long flags;
>>>>>>>>>>>=20
>>>>>>>>>>>  =09/* keep last! */
>>>>>>>>>>> @@ -1145,6 +1146,8 @@ struct ieee80211_local {
>>>>>>>>>>>  =09u64 airtime_v_t[IEEE80211_NUM_ACS];
>>>>>>>>>>>  =09u64 airtime_weight_sum[IEEE80211_NUM_ACS];
>>>>>>>>>>>=20
>>>>>>>>>>> +=09struct list_head remove_list[IEEE80211_NUM_ACS];
>>>>>>>>>>> +=09struct timer_list remove_timer;
>>>>>>>>>>>  =09u16 airtime_flags;
>>>>>>>>>>>=20
>>>>>>>>>>>  =09const struct ieee80211_ops *ops;
>>>>>>>>>>> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
>>>>>>>>>>> index e9ffa8e..78fe24a 100644
>>>>>>>>>>> --- a/net/mac80211/main.c
>>>>>>>>>>> +++ b/net/mac80211/main.c
>>>>>>>>>>> @@ -667,10 +667,15 @@ struct ieee80211_hw
>>>>>>>>>>> *ieee80211_alloc_hw_nm(size_t priv_data_len,
>>>>>>>>>>>=20
>>>>>>>>>>>  =09for (i =3D 0; i < IEEE80211_NUM_ACS; i++) {
>>>>>>>>>>>  =09=09local->active_txqs[i] =3D RB_ROOT_CACHED;
>>>>>>>>>>> +=09=09INIT_LIST_HEAD(&local->remove_list[i]);
>>>>>>>>>>>  =09=09spin_lock_init(&local->active_txq_lock[i]);
>>>>>>>>>>>  =09}
>>>>>>>>>>>  =09local->airtime_flags =3D AIRTIME_USE_TX | AIRTIME_USE_RX;
>>>>>>>>>>>=20
>>>>>>>>>>> +=09timer_setup(&local->remove_timer, ieee80211_txqs_check, 0);
>>>>>>>>>>> +=09mod_timer(&local->remove_timer,
>>>>>>>>>>> +=09=09  jiffies +
>>>>>>>>>>> msecs_to_jiffies(IEEE80211_AIRTIME_TXQ_RM_CHK_INTV_IN_MS));
>>>>>>>>>>> +
>>>>>>>>>>>  =09INIT_LIST_HEAD(&local->chanctx_list);
>>>>>>>>>>>  =09mutex_init(&local->chanctx_mtx);
>>>>>>>>>>>=20
>>>>>>>>>>> @@ -1305,6 +1310,7 @@ void ieee80211_unregister_hw(struct
>>>>>>>>>>> ieee80211_hw
>>>>>>>>>>> *hw)
>>>>>>>>>>>  =09tasklet_kill(&local->tx_pending_tasklet);
>>>>>>>>>>>  =09tasklet_kill(&local->tasklet);
>>>>>>>>>>>=20
>>>>>>>>>>> +=09del_timer_sync(&local->remove_timer);
>>>>>>>>>>>  #ifdef CONFIG_INET
>>>>>>>>>>>  =09unregister_inetaddr_notifier(&local->ifa_notifier);
>>>>>>>>>>>  #endif
>>>>>>>>>>> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
>>>>>>>>>>> index d00baaa..42ca010 100644
>>>>>>>>>>> --- a/net/mac80211/tx.c
>>>>>>>>>>> +++ b/net/mac80211/tx.c
>>>>>>>>>>> @@ -1450,6 +1450,7 @@ void ieee80211_txq_init(struct
>>>>>>>>>>> ieee80211_sub_if_data *sdata,
>>>>>>>>>>>  =09codel_stats_init(&txqi->cstats);
>>>>>>>>>>>  =09__skb_queue_head_init(&txqi->frags);
>>>>>>>>>>>  =09RB_CLEAR_NODE(&txqi->schedule_order);
>>>>>>>>>>> +=09INIT_LIST_HEAD(&txqi->candidate);
>>>>>>>>>>>=20
>>>>>>>>>>>  =09txqi->txq.vif =3D &sdata->vif;
>>>>>>>>>>>=20
>>>>>>>>>>> @@ -3724,6 +3725,9 @@ void ieee80211_schedule_txq(struct
>>>>>>>>>>> ieee80211_hw
>>>>>>>>>>> *hw,
>>>>>>>>>>>=20
>>>>>>>>>>>  =09spin_lock_bh(&local->active_txq_lock[ac]);
>>>>>>>>>>>=20
>>>>>>>>>>> +=09if (!list_empty(&txqi->candidate))
>>>>>>>>>>> +=09=09list_del_init(&txqi->candidate);
>>>>>>>>>>> +
>>>>>>>>>>>  =09if (!RB_EMPTY_NODE(&txqi->schedule_order))
>>>>>>>>>>>  =09=09goto out;
>>>>>>>>>>>=20
>>>>>>>>>>> @@ -3783,6 +3787,20 @@ static void
>>>>>>>>>>> __ieee80211_unschedule_txq(struct
>>>>>>>>>>> ieee80211_hw *hw,
>>>>>>>>>>>  =09RB_CLEAR_NODE(&txqi->schedule_order);
>>>>>>>>>>>  }
>>>>>>>>>>>=20
>>>>>>>>>>> +void ieee80211_remove_txq(struct ieee80211_hw *hw,
>>>>>>>>>>> +=09=09=09  struct ieee80211_txq *txq)
>>>>>>>>>>> +{
>>>>>>>>>>> +=09struct ieee80211_local *local =3D hw_to_local(hw);
>>>>>>>>>>> +=09struct txq_info *txqi =3D to_txq_info(txq);
>>>>>>>>>>> +
>>>>>>>>>>> +=09lockdep_assert_held(&local->active_txq_lock[txq->ac]);
>>>>>>>>>>> +
>>>>>>>>>>> +=09if (!RB_EMPTY_NODE(&txqi->schedule_order)) {
>>>>>>>>>>> +=09=09__ieee80211_unschedule_txq(hw, txq);
>>>>>>>>>>> +=09=09list_del_init(&txqi->candidate);
>>>>>>>>>>> +=09}
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>>  void ieee80211_unschedule_txq(struct ieee80211_hw *hw,
>>>>>>>>>>>  =09=09=09      struct ieee80211_txq *txq)
>>>>>>>>>>>  =09__acquires(txq_lock) __releases(txq_lock)
>>>>>>>>>>> @@ -3790,7 +3808,7 @@ void ieee80211_unschedule_txq(struct
>>>>>>>>>>> ieee80211_hw *hw,
>>>>>>>>>>>  =09struct ieee80211_local *local =3D hw_to_local(hw);
>>>>>>>>>>>=20
>>>>>>>>>>>  =09spin_lock_bh(&local->active_txq_lock[txq->ac]);
>>>>>>>>>>> -=09__ieee80211_unschedule_txq(hw, txq);
>>>>>>>>>>> +=09ieee80211_remove_txq(hw, txq);
>>>>>>>>>>>  =09spin_unlock_bh(&local->active_txq_lock[txq->ac]);
>>>>>>>>>>>  }
>>>>>>>>>>>=20
>>>>>>>>>>> @@ -3803,11 +3821,48 @@ void ieee80211_return_txq(struct
>>>>>>>>>>> ieee80211_hw
>>>>>>>>>>> *hw,
>>>>>>>>>>>  =09lockdep_assert_held(&local->active_txq_lock[txq->ac]);
>>>>>>>>>>>=20
>>>>>>>>>>>  =09if (!RB_EMPTY_NODE(&txqi->schedule_order) &&
>>>>>>>>>>> -=09    (skb_queue_empty(&txqi->frags) &&
>>>>>>>>>>> !txqi->tin.backlog_packets))
>>>>>>>>>>> -=09=09__ieee80211_unschedule_txq(hw, txq);
>>>>>>>>>>> +=09=09!txq_has_queue(&txqi->txq) &&
>>>>>>>>>>> +=09=09list_empty(&txqi->candidate))
>>>>>>>>>>> +=09=09list_add_tail(&txqi->candidate,
>>>>>>>>>>> &local->remove_list[txq->ac]);
>>>>>>>>>>> +
>>>>>>>>>>>  }
>>>>>>>>>>>  EXPORT_SYMBOL(ieee80211_return_txq);
>>>>>>>>>>>=20
>>>>>>>>>>> +void __ieee80211_check_txqs(struct ieee80211_local *local,=20
>>>>>>>>>>> int
>>>>>>>>>>> ac)
>>>>>>>>>>> +{
>>>>>>>>>>> +=09struct txq_info *iter, *tmp;
>>>>>>>>>>> +=09struct sta_info *sta;
>>>>>>>>>>> +
>>>>>>>>>>> +=09lockdep_assert_held(&local->active_txq_lock[ac]);
>>>>>>>>>>> +
>>>>>>>>>>> +=09list_for_each_entry_safe(iter, tmp, &local->remove_list[ac]=
,
>>>>>>>>>>> +=09=09=09=09 candidate) {
>>>>>>>>>>> +=09=09sta =3D container_of(iter->txq.sta, struct sta_info, sta=
);
>>>>>>>>>>> +
>>>>>>>>>>> +=09=09if (txq_has_queue(&iter->txq))
>>>>>>>>>>> +=09=09=09list_del_init(&iter->candidate);
>>>>>>>>>>> +=09=09else
>>>>>>>>>>> +=09=09=09ieee80211_remove_txq(&local->hw, &iter->txq);
>>>>>>>>>>> +=09}
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>> +void ieee80211_txqs_check(struct timer_list *t)
>>>>>>>>>>> +{
>>>>>>>>>>> +=09struct ieee80211_local *local =3D from_timer(local, t,
>>>>>>>>>>> remove_timer);
>>>>>>>>>>> +=09struct txq_info *iter, *tmp;
>>>>>>>>>>> +=09struct sta_info *sta;
>>>>>>>>>>> +=09int ac;
>>>>>>>>>>> +
>>>>>>>>>>> +=09for (ac =3D 0; ac < IEEE80211_NUM_ACS; ac++) {
>>>>>>>>>>> +=09=09spin_lock_bh(&local->active_txq_lock[ac]);
>>>>>>>>>>> +=09=09__ieee80211_check_txqs(local, ac);
>>>>>>>>>>> +=09=09spin_unlock_bh(&local->active_txq_lock[ac]);
>>>>>>>>>>> +=09}
>>>>>>>>>>> +
>>>>>>>>>>> +=09mod_timer(&local->remove_timer,
>>>>>>>>>>> +=09=09  jiffies +
>>>>>>>>>>> msecs_to_jiffies(IEEE80211_AIRTIME_TXQ_RM_CHK_INTV_IN_MS));
>>>>>>>>>>> +}
>>>>>>>>>>=20
>>>>>>>>>> I'll ask the same as I did last time (where you told me to hold
>>>>>>>>>> off
>>>>>>>>>> until this round):
>>>>>>>>>>=20
>>>>>>>>>> Why do you need the timer and the periodic check? If TXQs are
>>>>>>>>>> added
>>>>>>>>>> to
>>>>>>>>>> the remove list during the scheduling run, and
>>>>>>>>>> __ieee80211_check_txqs()
>>>>>>>>>> is run from schedule_end(), isn't that sufficient to clear the
>>>>>>>>>> list?
>>>>>>>>> Is it possible that a txq is not added to the remove list but=20
>>>>>>>>> then
>>>>>>>>> packets in it are dropped by fq_codel algo? Like the station
>>>>>>>>> disconnects
>>>>>>>>> without any notification.
>>>>>>>>=20
>>>>>>>> Well as long as all the other cleanup paths call directly into
>>>>>>>> __unschedule_txq(), that should remove stations from the=20
>>>>>>>> scheduler
>>>>>>>> when
>>>>>>>> they disconnect etc.
>>>>>>> Yes, the disconnect scenario is a bad example. My concern is, say,
>>>>>>> we
>>>>>>> have 10 stations and only one of them is assigned a very small
>>>>>>> weight
>>>>>>> compared with that of others. Suppose, after its chance of Tx, it=
=20
>>>>>>> is
>>>>>>> most likely to be placed in the rightmost(still has some packets=20
>>>>>>> in
>>>>>>> the
>>>>>>> txq) and no more incoming data for it. The remaining packets in=20
>>>>>>> txq
>>>>>>> will
>>>>>>> be dropped due to timeout algo in codel(correct me if I am wrong)
>>>>>>> but
>>>>>>> this empty txq will stay on the rbtree until other txqs get=20
>>>>>>> drained
>>>>>>> or
>>>>>>> global vt catch up with its vt. The staying time could be long if
>>>>>>> weight
>>>>>>> is extremely small. Then do we need timer to check or any other
>>>>>>> better
>>>>>>> solution?
>>>>>>=20
>>>>>> Ah, I see what you mean. No, I don't think this will be a problem;
>>>>>> the
>>>>>> scenario you're describing would play out like this:
>>>>>>=20
>>>>>> 1. Station ends transmitting, still has a single packet queued,=20
>>>>>> gets
>>>>>>    moved to the end of the rbtree (and stays there for a while).
>>>>>>=20
>>>>>> 2. When we finally get to the point where this station gets another
>>>>>>    chance to transmit, the CoDel drop timer triggers and the last
>>>>>> packet
>>>>>>    is dropped[0]. This means that the queue will just be empty
>>>>>>    (and ieee80211_tx_dequeue() will return NULL).
>>>>>>=20
>>>>>> 3. Because the queue is empty, ieee80211_return_txq() will not put=
=20
>>>>>> it
>>>>>>    back on the rbtree.
>>>>>>=20
>>>>>> Crucially, in 2. the CoDel algorithm doesn't kick in until the=20
>>>>>> point
>>>>>> of
>>>>>> packet dequeue. But even if an empty queue stays on the rbtree for=
=20
>>>>>> a
>>>>>> while, there is no harm in that: eventually it will get its turn,=20
>>>>>> it
>>>>>> will turn out to be empty, and just be skipped over.
>>>>> Then that will be fine. Thanks for the explanation of the dropping
>>>>> part
>>>>> in CoDel algorithm.
>>>>=20
>>>> Yup, think so. And you're welcome :)
>>>>=20
>>>>>> The issue we need to be concerned about is the opposite: If we have=
=20
>>>>>> a
>>>>>> queue that *does* have packets queued, but which is *not* scheduled
>>>>>> for
>>>>>> transmission, that will stall TX.
>>>>> Is it by design since its vt is more than global vt, right? The
>>>>> lattency
>>>>> may somehow get impacted though.
>>>>=20
>>>> Well, it should still stay on the rbtree as long as it has packets
>>>> queued. We don't have a check anywhere that reschedules TXQs whose=20
>>>> v_t
>>>> drops below global v_t...
>>>>=20
>>>>>> [0] CoDel in most cases only drops a single packet at a time, so it
>>>>>> will
>>>>>> not clear out an entire queue with multiple packets in one go. But
>>>>>> you
>>>>>> are right that it could conceivably drop the last packet in a=20
>>>>>> queue.
>>>>>>=20
>>>>>>>> We only need to defer removal inside a single "scheduling round"
>>>>>>>> (i.e.,
>>>>>>>> between a pair of ieee80211_txq_schedule_start/end. So if we just
>>>>>>>> walk
>>>>>>>> the remove list in schedule_end() we should be enough, no?
>>>>>>>>=20
>>>>>>>> Hmm, or maybe a simpler way to fix the original issue is just to
>>>>>>>> have
>>>>>>>> unschedule_txq() update the schedule_pos() pointer?
>>>>>>>>=20
>>>>>>>> I.e., unschedule_txq checks if the txq being removed is currently
>>>>>>>> being
>>>>>>>> pointed to by schedule_pos[ac], and if it is, it updates
>>>>>>>> schedule_pos
>>>>>>>> to
>>>>>>>> be the rb_next of the current value?
>>>>>>> Actually, if schedule_pos is updated to rb_next of the current
>>>>>>> value,
>>>>>>> then in the next_txq() where we are going to use rb_next again and
>>>>>>> finally pick the next node of the node we really want. Is it fine=
=20
>>>>>>> to
>>>>>>> update schedule_pos to NULL?
>>>>>>=20
>>>>>> Hmm, yeah, good point.
>>>>>>=20
>>>>>> If we do end up setting schedule_pos to NULL in the middle of a
>>>>>> scheduling round, that will make next_txq() "start over", and do
>>>>>> another
>>>>>> loop through the whole thing. I guess we may be able hit a case=20
>>>>>> where
>>>>>> things can oscillate back and forth between addition and removal
>>>>>> resulting in an infinite loop? Not sure, but at least I can't seem=
=20
>>>>>> to
>>>>>> convince myself that this can't happen.
>>>>>=20
>>>>> As the loop of next_txq under lock protection as below,
>>>>>=20
>>>>> txq_schedule_start();
>>>>> while(txq=3Dnext_txq()){
>>>>> ...
>>>>> return_txq(txq);
>>>>> }
>>>>> txq_schedule_end();
>>>>>=20
>>>>> I do not see any chance of addition, no?
>>>>=20
>>>> As you noted in your other email, Felix reduced the locking. And=20
>>>> yeah,
>>>> we need to rebase this series to also incorporate that. I figure I=20
>>>> can
>>>> send an updated version of the first patch in the series once we've
>>>> worked out the remaining issues with your follow-up patches.
>>>>=20
>>> Oh, I was thinking we were discussing without locking reduced. Yes, I
>>> also agree there might be a case causing infinite loop. With locking
>>> reduced, the tree can be adjusted between next_txq() and return_txq()=
=20
>>> in
>>> the loop situation. For further discussion, let 's consider,
>>> 1) the tree starts like:
>>>         A->B->C->D->E
>>> 2) then next_txq() returns A for dequeuing
>>> 3) driver dequeues A and draines A without any active txq locked=20
>>> meaning
>>> the tree could be changed upon Tx compeletion.
>>> 4) then in return_txq(), the tree could be,
>>>         i   A->B->C->D->E =EF=BC=88A is empty, and maybe soon be added =
back
>>> before the loop end=EF=BC=89
>>>         ii  B->C->A->D->E =EF=BC=88A is empty, and maybe soon be added =
back
>>> before the loop end=EF=BC=89
>>>         iii B->C->D->E->A =EF=BC=88A is empty, and maybe soon be added =
back
>>> before the loop end)
>>>=20
>>> with this change:
>>>   local->schedule_pos[ac] =3D rb_next(node) ?: rb_prev(node);
>>>=20
>>> for case i, local->schedule_pos[ac] is rb_next(A) which is B, and in
>>> next_txq(), rb_next(B) is what we returns which actually is C and B is
>>> skipped, no?
>>>=20
>>> Similiar for case ii, we skip B, C, D.
>>=20
>> Yup, I think you're right. But if we can fix this by making
>> ieee80211_resort_txq() aware of the schedule_pos as well, no? I.e., if
>> resort_txq() acts on the txq that's currently in schedule_pos, it will
>> update schedule pos with the same rb_next(node) ?: rb_prev(node);
>> (optionally after checking that the position of the node is actually
>> going to change).
> Sorry, please igore last email sent by mistake.
>
> I don't think it makes any difference with that in unschedule_txq(). For=
=20
> case i, it finally picks C as well in next_txq(). For next_txq(),=20
> schedule_pos means previous candidate node whereas with your change, it=
=20
> looks like schedule_pos is current candidate node instead.

Hmm, that was not actually what I was thinking, but yeah I think you're
right that it would be easier to just change it so schedule_pos is
pointing to the next and not the current txq we want to schedule.

We'd still need a check in resort_txq() then, but it would make it safe
to unschedule in return_txq()...

>>> Also I am wondering if there will be some SMP issues relating with
>>> local->schedule_pos[ac].
>>=20
>> Not sure what you mean by this?
> My bad. Please ignore this.
>
>
>>=20
>>>>> In ath10k, we will usually push packets of first txq as many as we=20
>>>>> can
>>>>> until it is drained and then move to the next one. So if a txq gets
>>>>> removed in the return_txq, it should always be the leftmost. And
>>>>> during this period, neither vt of any station or global vt can be
>>>>> updated due to lock protection.
>>>>>=20
>>>>>>=20
>>>>>> But in that case, we could fix it by just conditionally assigning
>>>>>> either
>>>>>> rb_next or rb_prev to the schedule_pos in unschedule_txq()? I.e.,
>>>>>> something like:
>>>>>>=20
>>>>>> local->schedule_pos[ac] =3D rb_next(node) ?: rb_prev(node);
>>>>> I am not sure I am getting your point. Still in next_txq,
>>>>> schedule_pos[ac] will lead us to the next node of the one we want.
>>>>=20
>>>> The logic in next_txq is different when schedule_pos[ac] is NULL, vs
>>>> when rb_next(schedule_pos[ac]) is NULL. The former restarts a new
>>>> scheduling round, while the latter ends the current round.
>>>>=20
>>>> -Toke
>>>=20
>>> --
>>> Yibo
>
> --=20
> Yibo

