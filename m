Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05F14CBF97
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2019 17:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389959AbfJDPoh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Oct 2019 11:44:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46353 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389669AbfJDPog (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Oct 2019 11:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570203875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oC1ibBzx+qO9Kc2wExednsTEXKXFst12gdTEt8PjtDc=;
        b=M0f/5m9JB5bt6Matp0PATrILUP98QiE/DUOsWb5S0tF5imbwpoM9Y3YhYgNzEse7Dq6Axc
        0Axe/y4XBPQj6uo/7pWcsjT2yLFpy47duJbcExf+c3PHsCkQpyivdNvRq0yog6WHdNylym
        pW4M4auVyXhCSW+SEQzZUBMiLJ6Gy0o=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-vkbpnv8bMZ2FRSdLhWGwuA-1; Fri, 04 Oct 2019 11:44:33 -0400
Received: by mail-lj1-f199.google.com with SMTP id i18so1891071ljg.14
        for <linux-wireless@vger.kernel.org>; Fri, 04 Oct 2019 08:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=RLDs3uyA3K5CUIPKF0wPQukbcJm3PZqOntl4x//Jn8M=;
        b=groBQpJepiBkMCFqfJLIS1wOW+gz216ZOSvwzcBvV92yuWjXOGumpYzTbRhYmejUBw
         1tYk3kaNxT/S2HU6GTsrIoxHruE+FzQhNrz0Vs7GQ1PTTVeEg+Pfc30o3V2R2e25xT7y
         hZrvZ2J4OBCsfo2NzI2rC4/pIZWbIpJ6We3L+r8N3SskWKVuqUgsO8PAbU3scjwCt+4G
         cw7S49jHRKkn1HuFPVvWGYIgw/S/He/Qqp0YbBYOvO8Jcbqf0wU0APSU4Dw+31EVxnML
         ZsnJJnI/osDfNjLobbuJWOMuVMtMi0YPzNH1lcbCiySzJU6qZBtnezrHdUpCVCsje48v
         QwZw==
X-Gm-Message-State: APjAAAVITP6HIl7Yvx+CBSs6tAovmT94v9/1ttgB8rIw2Y8heC5yXcH8
        q8VC9SPdx5MU18dpYiKe8CUxWt2QCbqP1vn8y3l71tjLKNHASglbmP5JcLTfLceU5tYJDAwJOiQ
        3gdNthl2dZS5aZCXPaqLOBYc9W0I=
X-Received: by 2002:a2e:89cd:: with SMTP id c13mr9952267ljk.92.1570203872285;
        Fri, 04 Oct 2019 08:44:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzc7uGUm2DR7E6T1p8TBKc1wTXcIlxLmmcGqjD7fEF28vRQ2/xyeFaeE/3bZzKp7eCEiXHKlQ==
X-Received: by 2002:a2e:89cd:: with SMTP id c13mr9952251ljk.92.1570203871884;
        Fri, 04 Oct 2019 08:44:31 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id y8sm1314770ljh.21.2019.10.04.08.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 08:44:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5D96E18063D; Fri,  4 Oct 2019 17:44:30 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kan Yan <kyan@google.com>, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, nbd@nbd.name,
        yiboz@codeaurora.org, Kan Yan <kyan@google.com>
Subject: Re: [PATCH 1/2] mac80211: Implement Airtime-based Queue Limit (AQL)
In-Reply-To: <20191004062151.131405-2-kyan@google.com>
References: <20191004062151.131405-1-kyan@google.com> <20191004062151.131405-2-kyan@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 04 Oct 2019 17:44:30 +0200
Message-ID: <87imp4o6qp.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: vkbpnv8bMZ2FRSdLhWGwuA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kan Yan <kyan@google.com> writes:

> In order for the Fq_CoDel integrated in mac80211 layer operates
> effectively to control excessive queueing latency, the CoDel algorithm
> requires an accurate measure of how long the packets stays in the
> queue, aka sojourn time. The sojourn time measured at mac80211 layer
> doesn't include queueing latency in lower layer (firmware/hardware)
> and CoDel expects lower layer to have a short queue. However, most
> 802.11ac chipsets offload tasks such TX aggregation to firmware or
> hardware, thus have a deep lower layer queue. Without a mechanism to
> control the lower layer queue size, packets only stays in mac80211
> layer transiently before being released to firmware due to the deep
> queue in the lower layer. In this case, the sojourn time measured by
> CoDel in the mac80211 layer is always lower than the CoDel latency
> target hence it does little to control the latency, even when the lower
> layer queue causes excessive latency.
>
> Byte Queue limits (BQL) is commonly used to address the similar issue
> with wired network interface. However, this method can not be applied
> directly to the wireless network interface. Byte is not a suitable
> measure of queue depth in the wireless network, as the data rate can
> vary dramatically from station to station in the same network, from a
> few Mbps to over 1 Gbps.
>
> This patch implemented an Airtime-based Queue Limit (AQL) to make CoDel
> works effectively with wireless drivers that utilized firmware/hardware
> offloading. It only allows each txq to release just enough packets to
> form 1-2 large aggregations to keep hardware fully utilized and keep the
> rest of frames in mac80211 layer to be controlled by CoDel.
>
> Change-Id: I1427db2c4c7fcb4162b087514dcb06d5613fa5d2
> Signed-off-by: Kan Yan <kyan@google.com>
> ---
>  include/net/cfg80211.h     |  7 ++++
>  include/net/mac80211.h     | 34 ++++++++++++++++
>  net/mac80211/debugfs.c     | 79 ++++++++++++++++++++++++++++++++++++++
>  net/mac80211/debugfs_sta.c | 43 +++++++++++++++------
>  net/mac80211/ieee80211_i.h |  4 ++
>  net/mac80211/main.c        |  7 +++-
>  net/mac80211/sta_info.c    | 23 +++++++++++
>  net/mac80211/sta_info.h    |  4 ++
>  net/mac80211/tx.c          | 60 ++++++++++++++++++++++++-----
>  9 files changed, 239 insertions(+), 22 deletions(-)
>
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 26e2ad2c7027..301c11be366a 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -2499,6 +2499,13 @@ enum wiphy_params_flags {
> =20
>  #define IEEE80211_DEFAULT_AIRTIME_WEIGHT=09256
> =20
> +/* The per TXQ firmware queue limit in airtime */
> +#define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_L=094000
> +#define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_H=098000
> +
> +/* The firmware's transmit queue size limit in airtime */
> +#define IEEE80211_DEFAULT_AQL_INTERFACE_LIMIT=0924000
> +
>  /**
>   * struct cfg80211_pmksa - PMK Security Association
>   *
> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index d26da013f7c0..4d62aba3e4b2 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -5543,6 +5543,40 @@ void ieee80211_send_eosp_nullfunc(struct ieee80211=
_sta *pubsta, int tid);
>  void ieee80211_sta_register_airtime(struct ieee80211_sta *pubsta, u8 tid=
,
>  =09=09=09=09    u32 tx_airtime, u32 rx_airtime);
> =20
> +/**
> + * ieee80211_sta_register_pending_airtime - register the estimated airti=
me for
> + * the frames pending in lower layer (firmware/hardware) txq.
> + *
> + * Update the total pending airtime of the frames released to firmware. =
The
> + * pending airtime is used by AQL to control queue size in the lower lay=
er.
> + *
> + * The airtime is estimated using frame length and the last reported dat=
a
> + * rate. The pending airtime for a txq is increased by the estimated
> + * airtime when the frame is relased to the lower layer, and decreased b=
y the
> + * same amount at the tx completion event.
> + *
> + * @pubsta: the station
> + * @tid: the TID to register airtime for
> + * @tx_airtime: the estimated airtime (in usec)
> + * @tx_commpleted: true if called from the tx completion event.
> + */
> +void ieee80211_sta_register_pending_airtime(struct ieee80211_sta *pubsta=
,
> +=09=09=09=09=09    u8 tid, u32 tx_airtime,
> +=09=09=09=09=09    bool tx_completed);
> +
> +/**
> + * ieee80211_txq_aritme_check - check if the airtime limit of AQL (Airti=
me based
> + * queue limit) has been reached.
> + * @hw: pointer obtained from ieee80211_alloc_hw()
> + * @txq: pointer obtained from station or virtual interface
> + * Retrun true if the queue limit has not been reached and txq can conti=
nue to
> + * release packets to the lower layer.
> + * Return false if the queue limit has been reached and the txq should n=
ot
> + * release more frames to the lower layer.
> + */
> +bool
> +ieee80211_txq_airtime_check(struct ieee80211_hw *hw, struct ieee80211_tx=
q *txq);
> +

So I think it'll be better to pass up the last_rate and have mac80211
calculate the airtime (like I did in my patch set). But we can keep the
rest of your logic and just switch the calculation, I guess?

I'd like to use the new rate calculation code that Felix added to mt76.
Is the arsta->txrate info in ath10k suitable to be passed up to mac80211
and used in that, do you think? Because then that would probably be the
easiest way to go about it...

[...]

> @@ -3726,9 +3733,7 @@ void __ieee80211_schedule_txq(struct ieee80211_hw *=
hw,
>  =09=09 * get immediately moved to the back of the list on the next
>  =09=09 * call to ieee80211_next_txq().
>  =09=09 */
> -=09=09if (txqi->txq.sta &&
> -=09=09    wiphy_ext_feature_isset(local->hw.wiphy,
> -=09=09=09=09=09    NL80211_EXT_FEATURE_AIRTIME_FAIRNESS))
> +=09=09if (txqi->txq.sta && local->airtime_flags & AIRTIME_USE_TX)

This is wrong. The USE_TX/USE_RX flags just set which types of airtime
will be subtracted from the deficit. We should still be running the
scheduler if *either* of them is set...

>  =09=09=09list_add(&txqi->schedule_order,
>  =09=09=09=09 &local->active_txqs[txq->ac]);
>  =09=09else
> @@ -3740,6 +3745,37 @@ void __ieee80211_schedule_txq(struct ieee80211_hw =
*hw,
>  }
>  EXPORT_SYMBOL(__ieee80211_schedule_txq);
> =20
> +bool ieee80211_txq_airtime_check(struct ieee80211_hw *hw,
> +=09=09=09     struct ieee80211_txq *txq)
> +{
> +=09struct sta_info *sta;
> +=09struct ieee80211_local *local =3D hw_to_local(hw);
> +
> +
> +=09if (!(local->airtime_flags & AIRTIME_USE_TX))

Ditto.

> +=09=09return true;
> +
> +=09if (!txq->sta)
> +=09=09return true;
> +
> +=09sta =3D container_of(txq->sta, struct sta_info, sta);
> +=09if (sta->airtime[txq->ac].deficit < 0)
> +=09=09return false;
> +
> +=09if (!(local->airtime_flags & AIRTIME_USE_AQL))
> +=09=09return true;
> +
> +=09if ((sta->airtime[txq->ac].aql_tx_pending <
> +=09     sta->airtime[txq->ac].aql_limit_low) ||
> +=09    (local->aql_total_pending_airtime < local->aql_interface_limit &&
> +=09     sta->airtime[txq->ac].aql_tx_pending <
> +=09     sta->airtime[txq->ac].aql_limit_high))
> +=09=09return true;
> +=09else
> +=09=09return false;
> +}
> +EXPORT_SYMBOL(ieee80211_txq_airtime_check);
> +
>  bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
>  =09=09=09=09struct ieee80211_txq *txq)
>  {
> @@ -3748,10 +3784,13 @@ bool ieee80211_txq_may_transmit(struct ieee80211_=
hw *hw,
>  =09struct sta_info *sta;
>  =09u8 ac =3D txq->ac;
> =20
> -=09spin_lock_bh(&local->active_txq_lock[ac]);
> -
>  =09if (!txqi->txq.sta)
> -=09=09goto out;
> +=09=09return true;
> +
> +=09if (!(local->airtime_flags & AIRTIME_USE_TX))

Ditto.


-Toke

