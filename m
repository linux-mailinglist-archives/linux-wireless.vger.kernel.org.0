Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97EFEF8EE3
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2019 12:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfKLLsH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Nov 2019 06:48:07 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50842 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725775AbfKLLsH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Nov 2019 06:48:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573559284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/JMlpsNUHpqyjK1sRcsucpTqqDIbrEKFFuarRYGn50g=;
        b=GAAnVBNgsUOkvFvcrp3Gw3JjEMJRhAHudwVTrzF/zBxDozE6lQdzTAG2yjuPiYQM/LfNHv
        g2vAGvxuhmwHhbe4wkNFHU/e/Mr9f0d1odNda6DFiXrGXmvrRPwhaQXJBoZeODzIPfP7Hh
        TqI4J8F7tOWY7W1GRk4HnBeQT22AppU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-zSSDNegIOZeLhS7fZOGmXg-1; Tue, 12 Nov 2019 06:48:03 -0500
Received: by mail-lf1-f72.google.com with SMTP id f18so1563119lfp.14
        for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2019 03:48:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Sni7fJ/XnQ2yTWXGrUDI2ue5KmqygjCF8K1q27/fl24=;
        b=G9HgCvrjrbz8qacMz6wJdpTjzjnhnhBibXVj4+r7Y7hWuDDa2CV23x7lLgndwSHmF1
         zXpzR5jMQKbxhzVYJpzivKY+1hVNaqug7XRwMUf2kb1J867Agugkk6LZACeYI6UKTut/
         puq9Zhd49+Nc/dc/UJloLorJZ4Ip91Qb5dgdSoTq5whXpFx7ZxqxgZ8d2TqmC6CnApW1
         vru8o/HVXDXNHK6SlYIKcx8zBE6G4/M/EbMDH752dCXADPDDlEiMzScgtmNpPD6g8FYX
         lxEwUBI6KapPQih+kk+JGSlIwqY5m+mzlFDbpSJC36XVymrZYJI2R3dukZJzHr7XUNeL
         1RXg==
X-Gm-Message-State: APjAAAVjyBqh2AeeyNVKfU1cw4dCcDU55U9MykFednd14a4nf+41fzc+
        dQSQhdTr++mHdret6y/IQ+Z79ZNQOHGa+DkD6qaKYmjICB8T2HdWwis0Vuj0T/5a6EFeF0nA8NN
        rcB8dcBEKHpKD+dKEAYkhsqtSMTQ=
X-Received: by 2002:a2e:81c1:: with SMTP id s1mr19786485ljg.83.1573559281796;
        Tue, 12 Nov 2019 03:48:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqwzmyPA2bFUSqPMqrbWBk/gmYZEi+eCqHy2Fa8avN1ZwPNdYvc+uM7oh1k6J5i3HsHMqYCF8g==
X-Received: by 2002:a2e:81c1:: with SMTP id s1mr19786434ljg.83.1573559281014;
        Tue, 12 Nov 2019 03:48:01 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id r19sm8200922lfi.13.2019.11.12.03.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 03:48:00 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7BF291803C7; Tue, 12 Nov 2019 12:47:59 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kan Yan <kyan@google.com>, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, nbd@nbd.name,
        yiboz@codeaurora.org, john@phrozen.org, lorenzo@kernel.org,
        rmanohar@codeaurora.org, kevinhayes@google.com,
        Kan Yan <kyan@google.com>
Subject: Re: [PATCH v7 1/2] mac80211: Implement Airtime-based Queue Limit (AQL)
In-Reply-To: <20191112021136.42918-2-kyan@google.com>
References: <20191112021136.42918-1-kyan@google.com> <20191112021136.42918-2-kyan@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 12 Nov 2019 12:47:59 +0100
Message-ID: <871rudqpsg.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: zSSDNegIOZeLhS7fZOGmXg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kan Yan <kyan@google.com> writes:

> In order for the Fq_CoDel algorithm integrated in mac80211 layer to opera=
te
> effectively to control excessive queueing latency, the CoDel algorithm
> requires an accurate measure of how long packets stays in the queue, AKA
> sojourn time. The sojourn time measured at the mac80211 layer doesn't
> include queueing latency in the lower layer (firmware/hardware) and CoDel
> expects lower layer to have a short queue. However, most 802.11ac chipset=
s
> offload tasks such TX aggregation to firmware or hardware, thus have a de=
ep
> lower layer queue.
>
> Without a mechanism to control the lower layer queue size, packets only
> stay in mac80211 layer transiently before being sent to firmware queue.
> As a result, the sojourn time measured by CoDel in the mac80211 layer is
> almost always lower than the CoDel latency target, hence CoDel does littl=
e
> to control the latency, even when the lower layer queue causes excessive
> latency.
>
> The Byte Queue Limits (BQL) mechanism is commonly used to address the
> similar issue with wired network interface. However, this method cannot b=
e
> applied directly to the wireless network interface. "Bytes" is not a
> suitable measure of queue depth in the wireless network, as the data rate
> can vary dramatically from station to station in the same network, from a
> few Mbps to over Gbps.
>
> This patch implements an Airtime-based Queue Limit (AQL) to make CoDel wo=
rk
> effectively with wireless drivers that utilized firmware/hardware
> offloading. AQL allows each txq to release just enough packets to the low=
er
> layer to form 1-2 large aggregations to keep hardware fully utilized and
> retains the rest of the frames in mac80211 layer to be controlled by the
> CoDel algorithm.
>
> Signed-off-by: Kan Yan <kyan@google.com>
> [ Toke: Keep API to set pending airtime internal, fix nits in commit msg =
]
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Thanks for the update! A few comments below. I'll also send you and
updated version of my patch following this one, with fixes for Johannes'
comments. You can include that in your next version...

> ---
>  include/net/cfg80211.h     |  7 ++++
>  include/net/mac80211.h     | 12 ++++++
>  net/mac80211/debugfs.c     | 78 ++++++++++++++++++++++++++++++++++++++
>  net/mac80211/debugfs_sta.c | 43 ++++++++++++++++-----
>  net/mac80211/ieee80211_i.h |  4 ++
>  net/mac80211/main.c        | 10 ++++-
>  net/mac80211/sta_info.c    | 40 +++++++++++++++++++
>  net/mac80211/sta_info.h    |  8 ++++
>  net/mac80211/tx.c          | 47 +++++++++++++++++++++--
>  9 files changed, 235 insertions(+), 14 deletions(-)
>
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 4ab2c49423dc..15f9f04de149 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -2602,6 +2602,13 @@ enum wiphy_params_flags {
> =20
>  #define IEEE80211_DEFAULT_AIRTIME_WEIGHT=09256
> =20
> +/* The per TXQ device queue limit in airtime */
> +#define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_L=094000
> +#define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_H=098000
> +
> +/* The per interface airtime threshold to switch to lower queue limit */
> +#define IEEE80211_AQL_THRESHOLD=09=09=0924000
> +
>  /**
>   * struct cfg80211_pmksa - PMK Security Association
>   *
> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index 4319596ef472..269be699e89c 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -5558,6 +5558,18 @@ void ieee80211_send_eosp_nullfunc(struct ieee80211=
_sta *pubsta, int tid);
>  void ieee80211_sta_register_airtime(struct ieee80211_sta *pubsta, u8 tid=
,
>  =09=09=09=09    u32 tx_airtime, u32 rx_airtime);
> =20
> +/**
> + * ieee80211_txq_airtime_check - check if a txq can send frame to device
> + *
> + * @hw: pointer obtained from ieee80211_alloc_hw()
> + * @txq: pointer obtained from station or virtual interface
> + *
> + * Return true if the AQL's airtime limit has not been reached and the t=
xq can
> + * continue to send more packets to the device. Otherwise return false.
> + */
> +bool
> +ieee80211_txq_airtime_check(struct ieee80211_hw *hw, struct ieee80211_tx=
q *txq);
> +
>  /**
>   * ieee80211_iter_keys - iterate keys programmed into the device
>   * @hw: pointer obtained from ieee80211_alloc_hw()
> diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
> index 568b3b276931..d77ea0e51c1d 100644
> --- a/net/mac80211/debugfs.c
> +++ b/net/mac80211/debugfs.c
> @@ -148,6 +148,80 @@ static const struct file_operations aqm_ops =3D {
>  =09.llseek =3D default_llseek,
>  };
> =20
> +static ssize_t aql_txq_limit_read(struct file *file,
> +=09=09=09=09  char __user *user_buf,
> +=09=09=09=09  size_t count,
> +=09=09=09=09  loff_t *ppos)
> +{
> +=09struct ieee80211_local *local =3D file->private_data;
> +=09char buf[400];
> +=09int len =3D 0;
> +
> +=09len =3D scnprintf(buf, sizeof(buf),
> +=09=09=09"AC=09AQL limit low=09AQL limit high\n"
> +=09=09=09"VO=09%u=09=09%u\n"
> +=09=09=09"VI=09%u=09=09%u\n"
> +=09=09=09"BE=09%u=09=09%u\n"
> +=09=09=09"BK=09%u=09=09%u\n",
> +=09=09=09local->aql_txq_limit_low[IEEE80211_AC_VO],
> +=09=09=09local->aql_txq_limit_high[IEEE80211_AC_VO],
> +=09=09=09local->aql_txq_limit_low[IEEE80211_AC_VI],
> +=09=09=09local->aql_txq_limit_high[IEEE80211_AC_VI],
> +=09=09=09local->aql_txq_limit_low[IEEE80211_AC_BE],
> +=09=09=09local->aql_txq_limit_high[IEEE80211_AC_BE],
> +=09=09=09local->aql_txq_limit_low[IEEE80211_AC_BK],
> +=09=09=09local->aql_txq_limit_high[IEEE80211_AC_BK]);
> +=09return simple_read_from_buffer(user_buf, count, ppos,
> +=09=09=09=09       buf, len);
> +}
> +
> +static ssize_t aql_txq_limit_write(struct file *file,
> +=09=09=09=09   const char __user *user_buf,
> +=09=09=09=09   size_t count,
> +=09=09=09=09   loff_t *ppos)
> +{
> +=09struct ieee80211_local *local =3D file->private_data;
> +=09char buf[100];
> +=09size_t len;
> +=09u32 ac, q_limit_low, q_limit_high;
> +=09struct sta_info *sta;
> +
> +=09if (count > sizeof(buf))
> +=09=09return -EINVAL;
> +
> +=09if (copy_from_user(buf, user_buf, count))
> +=09=09return -EFAULT;
> +
> +=09buf[sizeof(buf) - 1] =3D 0;
> +=09len =3D strlen(buf);
> +=09if (len > 0 && buf[len - 1] =3D=3D '\n')
> +=09=09buf[len - 1] =3D 0;
> +
> +=09if (sscanf(buf, "%u %u %u", &ac, &q_limit_low, &q_limit_high) !=3D 3)
> +=09=09return -EINVAL;
> +
> +=09if (ac >=3D IEEE80211_NUM_ACS)
> +=09=09return -EINVAL;
> +
> +=09local->aql_txq_limit_low[ac] =3D q_limit_low;
> +=09local->aql_txq_limit_high[ac] =3D q_limit_high;
> +
> +=09mutex_lock(&local->sta_mtx);
> +=09list_for_each_entry(sta, &local->sta_list, list) {
> +=09=09sta->airtime[ac].aql_limit_low =3D q_limit_low;
> +=09=09sta->airtime[ac].aql_limit_high =3D q_limit_high;
> +=09}

Why is this setting sta and device limits to the same value?

Also, are you sure we won't risk write tearing when writing 32-bit
values without locking on some architectures?

> +=09mutex_unlock(&local->sta_mtx);
> +=09return count;
> +}
> +
> +static const struct file_operations aql_txq_limit_ops =3D {
> +=09.write =3D aql_txq_limit_write,
> +=09.read =3D aql_txq_limit_read,
> +=09.open =3D simple_open,
> +=09.llseek =3D default_llseek,
> +};
> +
>  static ssize_t force_tx_status_read(struct file *file,
>  =09=09=09=09    char __user *user_buf,
>  =09=09=09=09    size_t count,
> @@ -441,6 +515,10 @@ void debugfs_hw_add(struct ieee80211_local *local)
>  =09debugfs_create_u16("airtime_flags", 0600,
>  =09=09=09   phyd, &local->airtime_flags);
> =20
> +=09DEBUGFS_ADD(aql_txq_limit);
> +=09debugfs_create_u32("aql_threshold", 0600,
> +=09=09=09   phyd, &local->aql_threshold);
> +
>  =09statsd =3D debugfs_create_dir("statistics", phyd);
> =20
>  =09/* if the dir failed, don't put all the other things into the root! *=
/
> diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
> index c8ad20c28c43..0185e6e5e5d1 100644
> --- a/net/mac80211/debugfs_sta.c
> +++ b/net/mac80211/debugfs_sta.c
> @@ -197,10 +197,12 @@ static ssize_t sta_airtime_read(struct file *file, =
char __user *userbuf,
>  {
>  =09struct sta_info *sta =3D file->private_data;
>  =09struct ieee80211_local *local =3D sta->sdata->local;
> -=09size_t bufsz =3D 200;
> +=09size_t bufsz =3D 400;
>  =09char *buf =3D kzalloc(bufsz, GFP_KERNEL), *p =3D buf;
>  =09u64 rx_airtime =3D 0, tx_airtime =3D 0;
>  =09s64 deficit[IEEE80211_NUM_ACS];
> +=09u32 q_depth[IEEE80211_NUM_ACS];
> +=09u32 q_limit_l[IEEE80211_NUM_ACS], q_limit_h[IEEE80211_NUM_ACS];
>  =09ssize_t rv;
>  =09int ac;
> =20
> @@ -212,19 +214,22 @@ static ssize_t sta_airtime_read(struct file *file, =
char __user *userbuf,
>  =09=09rx_airtime +=3D sta->airtime[ac].rx_airtime;
>  =09=09tx_airtime +=3D sta->airtime[ac].tx_airtime;
>  =09=09deficit[ac] =3D sta->airtime[ac].deficit;
> +=09=09q_limit_l[ac] =3D sta->airtime[ac].aql_limit_low;
> +=09=09q_limit_h[ac] =3D sta->airtime[ac].aql_limit_high;
>  =09=09spin_unlock_bh(&local->active_txq_lock[ac]);
> +=09=09q_depth[ac] =3D atomic_read(&sta->airtime[ac].aql_tx_pending);
>  =09}
> =20
>  =09p +=3D scnprintf(p, bufsz + buf - p,
>  =09=09"RX: %llu us\nTX: %llu us\nWeight: %u\n"
> -=09=09"Deficit: VO: %lld us VI: %lld us BE: %lld us BK: %lld us\n",
> -=09=09rx_airtime,
> -=09=09tx_airtime,
> -=09=09sta->airtime_weight,
> -=09=09deficit[0],
> -=09=09deficit[1],
> -=09=09deficit[2],
> -=09=09deficit[3]);
> +=09=09"Deficit: VO: %lld us VI: %lld us BE: %lld us BK: %lld us\n"
> +=09=09"Q depth: VO: %u us VI: %u us BE: %u us BK: %u us\n"
> +=09=09"Q limit[low/high]: VO: %u/%u VI: %u/%u BE: %u/%u BK: %u/%u\n",
> +=09=09rx_airtime, tx_airtime, sta->airtime_weight,
> +=09=09deficit[0], deficit[1], deficit[2], deficit[3],
> +=09=09q_depth[0], q_depth[1], q_depth[2], q_depth[3],
> +=09=09q_limit_l[0], q_limit_h[0], q_limit_l[1], q_limit_h[1],
> +=09=09q_limit_l[2], q_limit_h[2], q_limit_l[3], q_limit_h[3]),
> =20
>  =09rv =3D simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
>  =09kfree(buf);
> @@ -236,7 +241,25 @@ static ssize_t sta_airtime_write(struct file *file, =
const char __user *userbuf,
>  {
>  =09struct sta_info *sta =3D file->private_data;
>  =09struct ieee80211_local *local =3D sta->sdata->local;
> -=09int ac;
> +=09u32 ac, q_limit_l, q_limit_h;
> +=09char _buf[100] =3D {}, *buf =3D _buf;
> +
> +=09if (count > sizeof(_buf))
> +=09=09return -EINVAL;
> +
> +=09if (copy_from_user(buf, userbuf, count))
> +=09=09return -EFAULT;
> +
> +=09buf[sizeof(_buf) - 1] =3D '\0';
> +=09if (sscanf(buf, "queue limit %u %u %u", &ac, &q_limit_l, &q_limit_h)
> +=09    !=3D 3)
> +=09=09return -EINVAL;
> +
> +=09if (ac >=3D IEEE80211_NUM_ACS)
> +=09=09return -EINVAL;
> +
> +=09sta->airtime[ac].aql_limit_low =3D q_limit_l;
> +=09sta->airtime[ac].aql_limit_high =3D q_limit_h;

Same concern as above re: unprotected writes.

>  =09for (ac =3D 0; ac < IEEE80211_NUM_ACS; ac++) {
>  =09=09spin_lock_bh(&local->active_txq_lock[ac]);
> diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
> index 225ea4e3cd76..ad15b3be8bb3 100644
> --- a/net/mac80211/ieee80211_i.h
> +++ b/net/mac80211/ieee80211_i.h
> @@ -1142,6 +1142,10 @@ struct ieee80211_local {
>  =09u16 schedule_round[IEEE80211_NUM_ACS];
> =20
>  =09u16 airtime_flags;
> +=09u32 aql_txq_limit_low[IEEE80211_NUM_ACS];
> +=09u32 aql_txq_limit_high[IEEE80211_NUM_ACS];
> +=09u32 aql_threshold;
> +=09atomic_t aql_total_pending_airtime;
> =20
>  =09const struct ieee80211_ops *ops;
> =20
> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
> index aba094b4ccfc..071ea92a3748 100644
> --- a/net/mac80211/main.c
> +++ b/net/mac80211/main.c
> @@ -667,8 +667,16 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t pr=
iv_data_len,
>  =09for (i =3D 0; i < IEEE80211_NUM_ACS; i++) {
>  =09=09INIT_LIST_HEAD(&local->active_txqs[i]);
>  =09=09spin_lock_init(&local->active_txq_lock[i]);
> +=09=09local->aql_txq_limit_low[i] =3D IEEE80211_DEFAULT_AQL_TXQ_LIMIT_L;
> +=09=09local->aql_txq_limit_high[i] =3D
> +=09=09=09IEEE80211_DEFAULT_AQL_TXQ_LIMIT_H;
>  =09}
> -=09local->airtime_flags =3D AIRTIME_USE_TX | AIRTIME_USE_RX;
> +
> +=09local->airtime_flags =3D AIRTIME_USE_TX |
> +=09=09=09       AIRTIME_USE_RX |
> +=09=09=09       AIRTIME_USE_AQL;
> +=09local->aql_threshold =3D IEEE80211_AQL_THRESHOLD;
> +=09atomic_set(&local->aql_total_pending_airtime, 0);
> =20
>  =09INIT_LIST_HEAD(&local->chanctx_list);
>  =09mutex_init(&local->chanctx_mtx);
> diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
> index bd11fef2139f..a76e935a543a 100644
> --- a/net/mac80211/sta_info.c
> +++ b/net/mac80211/sta_info.c
> @@ -396,6 +396,9 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_=
if_data *sdata,
>  =09=09skb_queue_head_init(&sta->ps_tx_buf[i]);
>  =09=09skb_queue_head_init(&sta->tx_filtered[i]);
>  =09=09sta->airtime[i].deficit =3D sta->airtime_weight;
> +=09=09atomic_set(&sta->airtime[i].aql_tx_pending, 0);
> +=09=09sta->airtime[i].aql_limit_low =3D local->aql_txq_limit_low[i];
> +=09=09sta->airtime[i].aql_limit_high =3D local->aql_txq_limit_high[i];
>  =09}
> =20
>  =09for (i =3D 0; i < IEEE80211_NUM_TIDS; i++)
> @@ -1893,6 +1896,43 @@ void ieee80211_sta_register_airtime(struct ieee802=
11_sta *pubsta, u8 tid,
>  }
>  EXPORT_SYMBOL(ieee80211_sta_register_airtime);
> =20
> +void ieee80211_sta_update_pending_airtime(struct ieee80211_local *local,
> +=09=09=09=09=09  struct sta_info *sta, u8 ac,
> +=09=09=09=09=09  u16 tx_airtime, bool tx_completed)
> +{
> +=09if (!tx_completed) {
> +=09=09if (sta)
> +=09=09=09atomic_add(tx_airtime,
> +=09=09=09=09   &sta->airtime[ac].aql_tx_pending);
> +
> +=09=09atomic_add(tx_airtime, &local->aql_total_pending_airtime);
> +=09=09return;
> +=09}
> +
> +=09if (sta) {
> +=09=09if (WARN_ONCE(atomic_read(&sta->airtime[ac].aql_tx_pending) <
> +=09=09=09      tx_airtime,
> +=09=09=09      "STA %pM AC %d txq pending airtime underflow: %u, %u",
> +=09=09=09      sta->addr, ac,
> +=09=09=09      atomic_read(&sta->airtime[ac].aql_tx_pending),
> +=09=09=09      tx_airtime))
> +=09=09=09atomic_set(&sta->airtime[ac].aql_tx_pending, 0);

I don't think this is right; another thread could do atomic_inc()
between the atomic_read() and atomic_set() here, in which case this
would clobber the other value.

I think to get this right the logic would need to be something like
this:

retry:
  old =3D atomic_read(&sta->airtime[ac].aql_tx_pending);
  if (warn_once(tx_airtime > old))
     new =3D 0;
  else
     new =3D old - tx_airtime;

  if (atomic_cmpxchg(&sta->airtime[ac].aql_tx_pending, old, new) !=3D old)
     goto retry;


(or use an equivalent do/while).


-Toke

