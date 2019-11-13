Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C339FA628
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2019 03:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfKMC1S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Nov 2019 21:27:18 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41195 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbfKMC1R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Nov 2019 21:27:17 -0500
Received: by mail-lj1-f195.google.com with SMTP id d22so702376lji.8
        for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2019 18:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iX6kwcVRctIDBuifVPnUWrMV2wH0AdxDCjJeSy1zFd0=;
        b=RtEn37OBpjHHo/pmT56hO/WDYAQ2kI8JWtZZJK2jaE+tO+m1PEktmsx8+RdZZop3Cd
         NWpuB5oLwG0p0/Z/W6/Q6MWWMbwZEUnRLjk3k8q66RjUQBo6HHRBJRZy0T0GWFm+Cdeh
         fTwGehSwjAq3G2i+bDeN91/MPOXHYMqZt1FZNV5LMMR8YXhF24ETCzL5NYVvVs2Mgx0s
         E+p7Zrt4w6grMqj03sNo2CJCRjGuA262QKmoofYB2KiUZyXx1cq+gBQFnWhj6ndfacA1
         iUVA2CqjCh2Ovkq0aLMAe86gq/cRi9ABTGGqlSTIaspsxsVfh5SaMNQMlBAy2sLuqwNL
         HLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iX6kwcVRctIDBuifVPnUWrMV2wH0AdxDCjJeSy1zFd0=;
        b=IEIPmUQjbnPADlKWkh6koxDqP+f3dGDQupA+mlyP3VKZgV4WKLByBLkndjuNUk58Ce
         5Tg+3WYl3ivNx3SEE8ZdV0+7dTtlXzxQLsSTfFy3CaI+9l6eu1G0pwECcW/gWKnnUMl+
         /Q4XNPOcYFV+SFiCPe/ICInRBm42mrfp3aDXKvF6fjyiWm3dKyzQuRlpnkbyG/5ZoFBy
         A0jWjKLGuWATw7R75js1IRce6DAaJCAsH+jchhPNh8PJx9oBzMXABig5kBxO9Zo2a8b5
         Z5V3PDkHrGzG03lDOr6L0F7uoKskm8rCvfHponjWjy7sBuv+N7WfsX+2xCJTNAD59/ZI
         ID3A==
X-Gm-Message-State: APjAAAXWARRC9wcN50Zp6XIJbFaVwRy8k6bMfGdY//0bPOS2mR+HXXDp
        lKhG+iTYa+G7hW5cqzO0enOk3Q1pBqUJbTsa216shQ==
X-Google-Smtp-Source: APXvYqwjoMcqWiuYqJnlmacs84iDAXJrhwnRvdvS3Ev/EEiI2tIM75x+wA+oBxMLc/+oU+zZttFSZWx7wj+prBw71nk=
X-Received: by 2002:a2e:9758:: with SMTP id f24mr539473ljj.105.1573612034101;
 Tue, 12 Nov 2019 18:27:14 -0800 (PST)
MIME-Version: 1.0
References: <20191112021136.42918-1-kyan@google.com> <20191112021136.42918-2-kyan@google.com>
 <871rudqpsg.fsf@toke.dk>
In-Reply-To: <871rudqpsg.fsf@toke.dk>
From:   Kan Yan <kyan@google.com>
Date:   Tue, 12 Nov 2019 18:27:02 -0800
Message-ID: <CA+iem5vrM0iF+yvS9m==UWnhp=DFV924ir-0nHcn6cwarEjZNA@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] mac80211: Implement Airtime-based Queue Limit (AQL)
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        Felix Fietkau <nbd@nbd.name>, Yibo Zhao <yiboz@codeaurora.org>,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thanks for the review. I will pick up your new patches and give it a
try tomorrow.

> Why is this setting sta and device limits to the same value?

local->aql_txq_limit_low is not the per device limit, but the default
txq_limit for all STAs. Individual stations can be configured with
non-default value via debugfs entry
"netdev:interface_name_x/stations/mac_addr_x/airtime". "aql_threshold"
is the device limit for switching between the lower and higher per
station queue limit.

> Also, are you sure we won't risk write tearing when writing 32-bit
> values without locking on some architectures?

Does mac80211 ever runs in any 16-bit architectures? Even in an
architecture that write to 32-bit value is not atomic, I don't think
there is any side-effect for queue limit get wrong transiently in rare
occasions. Besides, the practical value of those queue limits should
always fit into 16 bits.

> I don't think this is right; another thread could do atomic_inc()
> between the atomic_read() and atomic_set() here, in which case this
> would clobber the other value.
> I think to get this right the logic would need to be something like
> this:
> retry:
>   old =3D atomic_read(&sta->airtime[ac].aql_tx_pending);
>   if (warn_once(tx_airtime > old))
>      new =3D 0;
>   else
>      new =3D old - tx_airtime;
>   if (atomic_cmpxchg(&sta->airtime[ac].aql_tx_pending, old, new) !=3D old=
)
>      goto retry;
> (or use an equivalent do/while).

That's indeed not right. However, if a potential aql_tx_pending
underflow case is detected here (It should never happen), reset it to
0 maybe not the best remedy anyway. I think it is better  just
WARN_ONCE() and skip updating aql_tx_pending all together, so the
retry or loop can be avoided here. What do you think?


On Tue, Nov 12, 2019 at 3:48 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Kan Yan <kyan@google.com> writes:
>
> > In order for the Fq_CoDel algorithm integrated in mac80211 layer to ope=
rate
> > effectively to control excessive queueing latency, the CoDel algorithm
> > requires an accurate measure of how long packets stays in the queue, AK=
A
> > sojourn time. The sojourn time measured at the mac80211 layer doesn't
> > include queueing latency in the lower layer (firmware/hardware) and CoD=
el
> > expects lower layer to have a short queue. However, most 802.11ac chips=
ets
> > offload tasks such TX aggregation to firmware or hardware, thus have a =
deep
> > lower layer queue.
> >
> > Without a mechanism to control the lower layer queue size, packets only
> > stay in mac80211 layer transiently before being sent to firmware queue.
> > As a result, the sojourn time measured by CoDel in the mac80211 layer i=
s
> > almost always lower than the CoDel latency target, hence CoDel does lit=
tle
> > to control the latency, even when the lower layer queue causes excessiv=
e
> > latency.
> >
> > The Byte Queue Limits (BQL) mechanism is commonly used to address the
> > similar issue with wired network interface. However, this method cannot=
 be
> > applied directly to the wireless network interface. "Bytes" is not a
> > suitable measure of queue depth in the wireless network, as the data ra=
te
> > can vary dramatically from station to station in the same network, from=
 a
> > few Mbps to over Gbps.
> >
> > This patch implements an Airtime-based Queue Limit (AQL) to make CoDel =
work
> > effectively with wireless drivers that utilized firmware/hardware
> > offloading. AQL allows each txq to release just enough packets to the l=
ower
> > layer to form 1-2 large aggregations to keep hardware fully utilized an=
d
> > retains the rest of the frames in mac80211 layer to be controlled by th=
e
> > CoDel algorithm.
> >
> > Signed-off-by: Kan Yan <kyan@google.com>
> > [ Toke: Keep API to set pending airtime internal, fix nits in commit ms=
g ]
> > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> Thanks for the update! A few comments below. I'll also send you and
> updated version of my patch following this one, with fixes for Johannes'
> comments. You can include that in your next version...
>
> > ---
> >  include/net/cfg80211.h     |  7 ++++
> >  include/net/mac80211.h     | 12 ++++++
> >  net/mac80211/debugfs.c     | 78 ++++++++++++++++++++++++++++++++++++++
> >  net/mac80211/debugfs_sta.c | 43 ++++++++++++++++-----
> >  net/mac80211/ieee80211_i.h |  4 ++
> >  net/mac80211/main.c        | 10 ++++-
> >  net/mac80211/sta_info.c    | 40 +++++++++++++++++++
> >  net/mac80211/sta_info.h    |  8 ++++
> >  net/mac80211/tx.c          | 47 +++++++++++++++++++++--
> >  9 files changed, 235 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> > index 4ab2c49423dc..15f9f04de149 100644
> > --- a/include/net/cfg80211.h
> > +++ b/include/net/cfg80211.h
> > @@ -2602,6 +2602,13 @@ enum wiphy_params_flags {
> >
> >  #define IEEE80211_DEFAULT_AIRTIME_WEIGHT     256
> >
> > +/* The per TXQ device queue limit in airtime */
> > +#define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_L    4000
> > +#define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_H    8000
> > +
> > +/* The per interface airtime threshold to switch to lower queue limit =
*/
> > +#define IEEE80211_AQL_THRESHOLD                      24000
> > +
> >  /**
> >   * struct cfg80211_pmksa - PMK Security Association
> >   *
> > diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> > index 4319596ef472..269be699e89c 100644
> > --- a/include/net/mac80211.h
> > +++ b/include/net/mac80211.h
> > @@ -5558,6 +5558,18 @@ void ieee80211_send_eosp_nullfunc(struct ieee802=
11_sta *pubsta, int tid);
> >  void ieee80211_sta_register_airtime(struct ieee80211_sta *pubsta, u8 t=
id,
> >                                   u32 tx_airtime, u32 rx_airtime);
> >
> > +/**
> > + * ieee80211_txq_airtime_check - check if a txq can send frame to devi=
ce
> > + *
> > + * @hw: pointer obtained from ieee80211_alloc_hw()
> > + * @txq: pointer obtained from station or virtual interface
> > + *
> > + * Return true if the AQL's airtime limit has not been reached and the=
 txq can
> > + * continue to send more packets to the device. Otherwise return false=
.
> > + */
> > +bool
> > +ieee80211_txq_airtime_check(struct ieee80211_hw *hw, struct ieee80211_=
txq *txq);
> > +
> >  /**
> >   * ieee80211_iter_keys - iterate keys programmed into the device
> >   * @hw: pointer obtained from ieee80211_alloc_hw()
> > diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
> > index 568b3b276931..d77ea0e51c1d 100644
> > --- a/net/mac80211/debugfs.c
> > +++ b/net/mac80211/debugfs.c
> > @@ -148,6 +148,80 @@ static const struct file_operations aqm_ops =3D {
> >       .llseek =3D default_llseek,
> >  };
> >
> > +static ssize_t aql_txq_limit_read(struct file *file,
> > +                               char __user *user_buf,
> > +                               size_t count,
> > +                               loff_t *ppos)
> > +{
> > +     struct ieee80211_local *local =3D file->private_data;
> > +     char buf[400];
> > +     int len =3D 0;
> > +
> > +     len =3D scnprintf(buf, sizeof(buf),
> > +                     "AC     AQL limit low   AQL limit high\n"
> > +                     "VO     %u              %u\n"
> > +                     "VI     %u              %u\n"
> > +                     "BE     %u              %u\n"
> > +                     "BK     %u              %u\n",
> > +                     local->aql_txq_limit_low[IEEE80211_AC_VO],
> > +                     local->aql_txq_limit_high[IEEE80211_AC_VO],
> > +                     local->aql_txq_limit_low[IEEE80211_AC_VI],
> > +                     local->aql_txq_limit_high[IEEE80211_AC_VI],
> > +                     local->aql_txq_limit_low[IEEE80211_AC_BE],
> > +                     local->aql_txq_limit_high[IEEE80211_AC_BE],
> > +                     local->aql_txq_limit_low[IEEE80211_AC_BK],
> > +                     local->aql_txq_limit_high[IEEE80211_AC_BK]);
> > +     return simple_read_from_buffer(user_buf, count, ppos,
> > +                                    buf, len);
> > +}
> > +
> > +static ssize_t aql_txq_limit_write(struct file *file,
> > +                                const char __user *user_buf,
> > +                                size_t count,
> > +                                loff_t *ppos)
> > +{
> > +     struct ieee80211_local *local =3D file->private_data;
> > +     char buf[100];
> > +     size_t len;
> > +     u32 ac, q_limit_low, q_limit_high;
> > +     struct sta_info *sta;
> > +
> > +     if (count > sizeof(buf))
> > +             return -EINVAL;
> > +
> > +     if (copy_from_user(buf, user_buf, count))
> > +             return -EFAULT;
> > +
> > +     buf[sizeof(buf) - 1] =3D 0;
> > +     len =3D strlen(buf);
> > +     if (len > 0 && buf[len - 1] =3D=3D '\n')
> > +             buf[len - 1] =3D 0;
> > +
> > +     if (sscanf(buf, "%u %u %u", &ac, &q_limit_low, &q_limit_high) !=
=3D 3)
> > +             return -EINVAL;
> > +
> > +     if (ac >=3D IEEE80211_NUM_ACS)
> > +             return -EINVAL;
> > +
> > +     local->aql_txq_limit_low[ac] =3D q_limit_low;
> > +     local->aql_txq_limit_high[ac] =3D q_limit_high;
> > +
> > +     mutex_lock(&local->sta_mtx);
> > +     list_for_each_entry(sta, &local->sta_list, list) {
> > +             sta->airtime[ac].aql_limit_low =3D q_limit_low;
> > +             sta->airtime[ac].aql_limit_high =3D q_limit_high;
> > +     }
>
> Why is this setting sta and device limits to the same value?
>
> Also, are you sure we won't risk write tearing when writing 32-bit
> values without locking on some architectures?
>
> > +     mutex_unlock(&local->sta_mtx);
> > +     return count;
> > +}
> > +
> > +static const struct file_operations aql_txq_limit_ops =3D {
> > +     .write =3D aql_txq_limit_write,
> > +     .read =3D aql_txq_limit_read,
> > +     .open =3D simple_open,
> > +     .llseek =3D default_llseek,
> > +};
> > +
> >  static ssize_t force_tx_status_read(struct file *file,
> >                                   char __user *user_buf,
> >                                   size_t count,
> > @@ -441,6 +515,10 @@ void debugfs_hw_add(struct ieee80211_local *local)
> >       debugfs_create_u16("airtime_flags", 0600,
> >                          phyd, &local->airtime_flags);
> >
> > +     DEBUGFS_ADD(aql_txq_limit);
> > +     debugfs_create_u32("aql_threshold", 0600,
> > +                        phyd, &local->aql_threshold);
> > +
> >       statsd =3D debugfs_create_dir("statistics", phyd);
> >
> >       /* if the dir failed, don't put all the other things into the roo=
t! */
> > diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
> > index c8ad20c28c43..0185e6e5e5d1 100644
> > --- a/net/mac80211/debugfs_sta.c
> > +++ b/net/mac80211/debugfs_sta.c
> > @@ -197,10 +197,12 @@ static ssize_t sta_airtime_read(struct file *file=
, char __user *userbuf,
> >  {
> >       struct sta_info *sta =3D file->private_data;
> >       struct ieee80211_local *local =3D sta->sdata->local;
> > -     size_t bufsz =3D 200;
> > +     size_t bufsz =3D 400;
> >       char *buf =3D kzalloc(bufsz, GFP_KERNEL), *p =3D buf;
> >       u64 rx_airtime =3D 0, tx_airtime =3D 0;
> >       s64 deficit[IEEE80211_NUM_ACS];
> > +     u32 q_depth[IEEE80211_NUM_ACS];
> > +     u32 q_limit_l[IEEE80211_NUM_ACS], q_limit_h[IEEE80211_NUM_ACS];
> >       ssize_t rv;
> >       int ac;
> >
> > @@ -212,19 +214,22 @@ static ssize_t sta_airtime_read(struct file *file=
, char __user *userbuf,
> >               rx_airtime +=3D sta->airtime[ac].rx_airtime;
> >               tx_airtime +=3D sta->airtime[ac].tx_airtime;
> >               deficit[ac] =3D sta->airtime[ac].deficit;
> > +             q_limit_l[ac] =3D sta->airtime[ac].aql_limit_low;
> > +             q_limit_h[ac] =3D sta->airtime[ac].aql_limit_high;
> >               spin_unlock_bh(&local->active_txq_lock[ac]);
> > +             q_depth[ac] =3D atomic_read(&sta->airtime[ac].aql_tx_pend=
ing);
> >       }
> >
> >       p +=3D scnprintf(p, bufsz + buf - p,
> >               "RX: %llu us\nTX: %llu us\nWeight: %u\n"
> > -             "Deficit: VO: %lld us VI: %lld us BE: %lld us BK: %lld us=
\n",
> > -             rx_airtime,
> > -             tx_airtime,
> > -             sta->airtime_weight,
> > -             deficit[0],
> > -             deficit[1],
> > -             deficit[2],
> > -             deficit[3]);
> > +             "Deficit: VO: %lld us VI: %lld us BE: %lld us BK: %lld us=
\n"
> > +             "Q depth: VO: %u us VI: %u us BE: %u us BK: %u us\n"
> > +             "Q limit[low/high]: VO: %u/%u VI: %u/%u BE: %u/%u BK: %u/=
%u\n",
> > +             rx_airtime, tx_airtime, sta->airtime_weight,
> > +             deficit[0], deficit[1], deficit[2], deficit[3],
> > +             q_depth[0], q_depth[1], q_depth[2], q_depth[3],
> > +             q_limit_l[0], q_limit_h[0], q_limit_l[1], q_limit_h[1],
> > +             q_limit_l[2], q_limit_h[2], q_limit_l[3], q_limit_h[3]),
> >
> >       rv =3D simple_read_from_buffer(userbuf, count, ppos, buf, p - buf=
);
> >       kfree(buf);
> > @@ -236,7 +241,25 @@ static ssize_t sta_airtime_write(struct file *file=
, const char __user *userbuf,
> >  {
> >       struct sta_info *sta =3D file->private_data;
> >       struct ieee80211_local *local =3D sta->sdata->local;
> > -     int ac;
> > +     u32 ac, q_limit_l, q_limit_h;
> > +     char _buf[100] =3D {}, *buf =3D _buf;
> > +
> > +     if (count > sizeof(_buf))
> > +             return -EINVAL;
> > +
> > +     if (copy_from_user(buf, userbuf, count))
> > +             return -EFAULT;
> > +
> > +     buf[sizeof(_buf) - 1] =3D '\0';
> > +     if (sscanf(buf, "queue limit %u %u %u", &ac, &q_limit_l, &q_limit=
_h)
> > +         !=3D 3)
> > +             return -EINVAL;
> > +
> > +     if (ac >=3D IEEE80211_NUM_ACS)
> > +             return -EINVAL;
> > +
> > +     sta->airtime[ac].aql_limit_low =3D q_limit_l;
> > +     sta->airtime[ac].aql_limit_high =3D q_limit_h;
>
> Same concern as above re: unprotected writes.
>
> >       for (ac =3D 0; ac < IEEE80211_NUM_ACS; ac++) {
> >               spin_lock_bh(&local->active_txq_lock[ac]);
> > diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
> > index 225ea4e3cd76..ad15b3be8bb3 100644
> > --- a/net/mac80211/ieee80211_i.h
> > +++ b/net/mac80211/ieee80211_i.h
> > @@ -1142,6 +1142,10 @@ struct ieee80211_local {
> >       u16 schedule_round[IEEE80211_NUM_ACS];
> >
> >       u16 airtime_flags;
> > +     u32 aql_txq_limit_low[IEEE80211_NUM_ACS];
> > +     u32 aql_txq_limit_high[IEEE80211_NUM_ACS];
> > +     u32 aql_threshold;
> > +     atomic_t aql_total_pending_airtime;
> >
> >       const struct ieee80211_ops *ops;
> >
> > diff --git a/net/mac80211/main.c b/net/mac80211/main.c
> > index aba094b4ccfc..071ea92a3748 100644
> > --- a/net/mac80211/main.c
> > +++ b/net/mac80211/main.c
> > @@ -667,8 +667,16 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t =
priv_data_len,
> >       for (i =3D 0; i < IEEE80211_NUM_ACS; i++) {
> >               INIT_LIST_HEAD(&local->active_txqs[i]);
> >               spin_lock_init(&local->active_txq_lock[i]);
> > +             local->aql_txq_limit_low[i] =3D IEEE80211_DEFAULT_AQL_TXQ=
_LIMIT_L;
> > +             local->aql_txq_limit_high[i] =3D
> > +                     IEEE80211_DEFAULT_AQL_TXQ_LIMIT_H;
> >       }
> > -     local->airtime_flags =3D AIRTIME_USE_TX | AIRTIME_USE_RX;
> > +
> > +     local->airtime_flags =3D AIRTIME_USE_TX |
> > +                            AIRTIME_USE_RX |
> > +                            AIRTIME_USE_AQL;
> > +     local->aql_threshold =3D IEEE80211_AQL_THRESHOLD;
> > +     atomic_set(&local->aql_total_pending_airtime, 0);
> >
> >       INIT_LIST_HEAD(&local->chanctx_list);
> >       mutex_init(&local->chanctx_mtx);
> > diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
> > index bd11fef2139f..a76e935a543a 100644
> > --- a/net/mac80211/sta_info.c
> > +++ b/net/mac80211/sta_info.c
> > @@ -396,6 +396,9 @@ struct sta_info *sta_info_alloc(struct ieee80211_su=
b_if_data *sdata,
> >               skb_queue_head_init(&sta->ps_tx_buf[i]);
> >               skb_queue_head_init(&sta->tx_filtered[i]);
> >               sta->airtime[i].deficit =3D sta->airtime_weight;
> > +             atomic_set(&sta->airtime[i].aql_tx_pending, 0);
> > +             sta->airtime[i].aql_limit_low =3D local->aql_txq_limit_lo=
w[i];
> > +             sta->airtime[i].aql_limit_high =3D local->aql_txq_limit_h=
igh[i];
> >       }
> >
> >       for (i =3D 0; i < IEEE80211_NUM_TIDS; i++)
> > @@ -1893,6 +1896,43 @@ void ieee80211_sta_register_airtime(struct ieee8=
0211_sta *pubsta, u8 tid,
> >  }
> >  EXPORT_SYMBOL(ieee80211_sta_register_airtime);
> >
> > +void ieee80211_sta_update_pending_airtime(struct ieee80211_local *loca=
l,
> > +                                       struct sta_info *sta, u8 ac,
> > +                                       u16 tx_airtime, bool tx_complet=
ed)
> > +{
> > +     if (!tx_completed) {
> > +             if (sta)
> > +                     atomic_add(tx_airtime,
> > +                                &sta->airtime[ac].aql_tx_pending);
> > +
> > +             atomic_add(tx_airtime, &local->aql_total_pending_airtime)=
;
> > +             return;
> > +     }
> > +
> > +     if (sta) {
> > +             if (WARN_ONCE(atomic_read(&sta->airtime[ac].aql_tx_pendin=
g) <
> > +                           tx_airtime,
> > +                           "STA %pM AC %d txq pending airtime underflo=
w: %u, %u",
> > +                           sta->addr, ac,
> > +                           atomic_read(&sta->airtime[ac].aql_tx_pendin=
g),
> > +                           tx_airtime))
> > +                     atomic_set(&sta->airtime[ac].aql_tx_pending, 0);
>
> I don't think this is right; another thread could do atomic_inc()
> between the atomic_read() and atomic_set() here, in which case this
> would clobber the other value.
>
> I think to get this right the logic would need to be something like
> this:
>
> retry:
>   old =3D atomic_read(&sta->airtime[ac].aql_tx_pending);
>   if (warn_once(tx_airtime > old))
>      new =3D 0;
>   else
>      new =3D old - tx_airtime;
>
>   if (atomic_cmpxchg(&sta->airtime[ac].aql_tx_pending, old, new) !=3D old=
)
>      goto retry;
>
>
> (or use an equivalent do/while).
>
>
> -Toke
>
