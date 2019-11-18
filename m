Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6868100F50
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2019 00:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfKRXNB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Nov 2019 18:13:01 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45972 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfKRXNA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Nov 2019 18:13:00 -0500
Received: by mail-lj1-f196.google.com with SMTP id n21so20951251ljg.12
        for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2019 15:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gYEmqRlMhsdZydQ0UrxrHO/6bq5syVsTMwcye14T8bk=;
        b=pmJPQOFQYSHAkYkvJ3q/Q1qq+4rQbDvl2Xpt74j9Rt+rc3Am1i+PrNcK0vpbscRjfy
         hwgrlstQj1r/4uWdqv4MT+HvifNN8JfNTTVN/brythbFqwRF5PlDse7M9ppKjmxd04d7
         ws7A71PEjv4uFeSQ/4bCNRmAfU5vvDl60yETRWnM/06+N8Tki2dgOKZhj7hdXO5Fnd/h
         sJFkPQWLp87+/BO21jEQawj2W5GEv4EyzhQjJ5xrSDZTEfbcD9kFV2+GhhytTBHcVWZJ
         YMDDoofbMh5OuUSaPf1ypMKNUKS0yJCLoxMAdLWQTa6duu7bpLt8Q7wDMU9ZnlVY1/av
         bfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gYEmqRlMhsdZydQ0UrxrHO/6bq5syVsTMwcye14T8bk=;
        b=p/S8ct5cM6gTRlMPnKn6aQHS9kvDONRwlK2v+ks2sMDBbp4jiu20sXSsifbUFlx5ru
         UhZQQE3rsiGFwsyr7hZtlAXHNl0pv7c4d/W/OU6lefpIJacBRhXv0de57uPSpt6+FH6S
         zY+YlqkUXuVTTOob0fsHgQKWeL9pOPVcJw5MYO70q9L1OUx7zzXO0jpksgf8u2VCLbXa
         nKXoF9BxlZCr8xPYOpuvdmSqOm3zQo51sHJkUQG1kPfYooJ7tf7PHq1O0JtWeO9W9eFb
         hIkTQ0rFj/cOH8ezDYnkBinlQCWATogPPRk4SX9tdzdjxufMPiiRy4drmebh477jwoE6
         DioQ==
X-Gm-Message-State: APjAAAX5lRdEEUIWcIVBVQpGh24wHEgfuq4Jm0AcDHOEwAHRyCTSb7kZ
        7FxgBWLomokNGDsNkpFbrCldo5V6SkLihbN38ZY+Bg==
X-Google-Smtp-Source: APXvYqygxNNa6nQLIy61pkK8J0m4SO1eMFMRqy1ftUXNziLjMd8Ak7xNjuW01FuSsXQDrIbzitw9+Gj2wMZ+6MPkvNM=
X-Received: by 2002:a2e:9ecf:: with SMTP id h15mr1348275ljk.173.1574118776551;
 Mon, 18 Nov 2019 15:12:56 -0800 (PST)
MIME-Version: 1.0
References: <157382403672.580235.12525941420808058808.stgit@toke.dk> <157382404008.580235.4182653624209779472.stgit@toke.dk>
In-Reply-To: <157382404008.580235.4182653624209779472.stgit@toke.dk>
From:   Kan Yan <kyan@google.com>
Date:   Mon, 18 Nov 2019 15:12:45 -0800
Message-ID: <CA+iem5vOU7KVVhC8K+0T2KeNNZMVVniHNXMTHe7ZK9QNfY7AZQ@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] mac80211: Implement Airtime-based Queue Limit (AQL)
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        ath10k@lists.infradead.org, John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> @@ -3685,13 +3686,26 @@ struct ieee80211_txq *ieee80211_next_txq(struct i=
eee80211_hw *hw, u8 ac)
>         if (!txqi)
>                 goto out;
> +       if (txqi =3D=3D head && !found_eligible_txq)
> +               goto out;
> +
> +       if (!head)
> +               head =3D txqi;
> +
>         if (txqi->txq.sta) {
>                 struct sta_info *sta =3D container_of(txqi->txq.sta,
> -                                               struct sta_info, sta);
> +                                                   struct sta_info, sta)=
;
> +               bool aql_check =3D ieee80211_txq_airtime_check(hw, &txqi-=
>txq);
> +               s64 deficit =3D sta->airtime[txqi->txq.ac].deficit;
> +
> +               if (aql_check)
> +                       found_eligible_txq =3D true;
> -               if (sta->airtime[txqi->txq.ac].deficit < 0) {
> +               if (deficit < 0)
>                         sta->airtime[txqi->txq.ac].deficit +=3D
>                                 sta->airtime_weight;
> +
> +               if (deficit < 0 || !aql_check) {
>                         list_move_tail(&txqi->schedule_order,
>                                        &local->active_txqs[txqi->txq.ac])=
;
>                         goto begin;

Recent tests detect softlockup in ieee80211_next_txq(). The problem is
when a txq is deemed eligible for transmitting by
ieee80211_txq_airtime_check() but has negative deficit, the above
block keeps iterate over the list of active_txqs to refill the deficit
until it became positive. However, there could be other tx activities
for other ACs in the meantime, which increases
aql_total_pending_airtime and causes ieee80211_txq_airtime_check()
returns false and hence the lockup condition.

found_eligible_txq need be reset after each iteration of active_txqs.
I will upload a new version to fix it soon.
> @@ -3685,13 +3686,26 @@ struct ieee80211_txq *ieee80211_next_txq(struct i=
eee80211_hw *hw, u8 ac)
>         if (!txqi)
>                 goto out;
> +       if (txqi =3D=3D head && !found_eligible_txq)
> +               goto out;
> +
> +       if (!head)
> +               head =3D txqi;
> +
>         if (txqi->txq.sta) {
>                 struct sta_info *sta =3D container_of(txqi->txq.sta,
> -                                               struct sta_info, sta);
> +                                                   struct sta_info, sta)=
;
> +               bool aql_check =3D ieee80211_txq_airtime_check(hw, &txqi-=
>txq);
> +               s64 deficit =3D sta->airtime[txqi->txq.ac].deficit;
> +
> +               if (aql_check)
> +                       found_eligible_txq =3D true;
> -               if (sta->airtime[txqi->txq.ac].deficit < 0) {
> +               if (deficit < 0)
>                         sta->airtime[txqi->txq.ac].deficit +=3D
>                                 sta->airtime_weight;
> +
> +               if (deficit < 0 || !aql_check) {
>                         list_move_tail(&txqi->schedule_order,
>                                        &local->active_txqs[txqi->txq.ac])=
;
>                         goto begin;


On Fri, Nov 15, 2019 at 5:20 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> From: Kan Yan <kyan@google.com>
>
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
> ---
>  include/net/cfg80211.h     |    7 ++++
>  include/net/mac80211.h     |   12 ++++++
>  net/mac80211/debugfs.c     |   85 ++++++++++++++++++++++++++++++++++++++=
++++++
>  net/mac80211/debugfs_sta.c |   43 +++++++++++++++++-----
>  net/mac80211/ieee80211_i.h |    4 ++
>  net/mac80211/main.c        |   10 +++++
>  net/mac80211/sta_info.c    |   38 ++++++++++++++++++++
>  net/mac80211/sta_info.h    |    8 ++++
>  net/mac80211/tx.c          |   47 +++++++++++++++++++++++-
>  9 files changed, 240 insertions(+), 14 deletions(-)
>
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index e309cc826b40..4f75dbdd406a 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -2606,6 +2606,13 @@ enum wiphy_params_flags {
>
>  #define IEEE80211_DEFAULT_AIRTIME_WEIGHT       256
>
> +/* The per TXQ device queue limit in airtime */
> +#define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_L      4000
> +#define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_H      8000
> +
> +/* The per interface airtime threshold to switch to lower queue limit */
> +#define IEEE80211_AQL_THRESHOLD                        24000
> +
>  /**
>   * struct cfg80211_pmksa - PMK Security Association
>   *
> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index 6fc26a051ba0..ba3f33cc41ea 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -5565,6 +5565,18 @@ void ieee80211_send_eosp_nullfunc(struct ieee80211=
_sta *pubsta, int tid);
>  void ieee80211_sta_register_airtime(struct ieee80211_sta *pubsta, u8 tid=
,
>                                     u32 tx_airtime, u32 rx_airtime);
>
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
> index 568b3b276931..399d4e8b8546 100644
> --- a/net/mac80211/debugfs.c
> +++ b/net/mac80211/debugfs.c
> @@ -148,6 +148,87 @@ static const struct file_operations aqm_ops =3D {
>         .llseek =3D default_llseek,
>  };
>
> +static ssize_t aql_txq_limit_read(struct file *file,
> +                                 char __user *user_buf,
> +                                 size_t count,
> +                                 loff_t *ppos)
> +{
> +       struct ieee80211_local *local =3D file->private_data;
> +       char buf[400];
> +       int len =3D 0;
> +
> +       len =3D scnprintf(buf, sizeof(buf),
> +                       "AC     AQL limit low   AQL limit high\n"
> +                       "VO     %u              %u\n"
> +                       "VI     %u              %u\n"
> +                       "BE     %u              %u\n"
> +                       "BK     %u              %u\n",
> +                       local->aql_txq_limit_low[IEEE80211_AC_VO],
> +                       local->aql_txq_limit_high[IEEE80211_AC_VO],
> +                       local->aql_txq_limit_low[IEEE80211_AC_VI],
> +                       local->aql_txq_limit_high[IEEE80211_AC_VI],
> +                       local->aql_txq_limit_low[IEEE80211_AC_BE],
> +                       local->aql_txq_limit_high[IEEE80211_AC_BE],
> +                       local->aql_txq_limit_low[IEEE80211_AC_BK],
> +                       local->aql_txq_limit_high[IEEE80211_AC_BK]);
> +       return simple_read_from_buffer(user_buf, count, ppos,
> +                                      buf, len);
> +}
> +
> +static ssize_t aql_txq_limit_write(struct file *file,
> +                                  const char __user *user_buf,
> +                                  size_t count,
> +                                  loff_t *ppos)
> +{
> +       struct ieee80211_local *local =3D file->private_data;
> +       char buf[100];
> +       size_t len;
> +       u32 ac, q_limit_low, q_limit_high, q_limit_low_old, q_limit_high_=
old;
> +       struct sta_info *sta;
> +
> +       if (count > sizeof(buf))
> +               return -EINVAL;
> +
> +       if (copy_from_user(buf, user_buf, count))
> +               return -EFAULT;
> +
> +       buf[sizeof(buf) - 1] =3D 0;
> +       len =3D strlen(buf);
> +       if (len > 0 && buf[len - 1] =3D=3D '\n')
> +               buf[len - 1] =3D 0;
> +
> +       if (sscanf(buf, "%u %u %u", &ac, &q_limit_low, &q_limit_high) !=
=3D 3)
> +               return -EINVAL;
> +
> +       if (ac >=3D IEEE80211_NUM_ACS)
> +               return -EINVAL;
> +
> +       q_limit_low_old =3D local->aql_txq_limit_low[ac];
> +       q_limit_high_old =3D local->aql_txq_limit_high[ac];
> +
> +       local->aql_txq_limit_low[ac] =3D q_limit_low;
> +       local->aql_txq_limit_high[ac] =3D q_limit_high;
> +
> +       mutex_lock(&local->sta_mtx);
> +       list_for_each_entry(sta, &local->sta_list, list) {
> +               /* If a sta has customized queue limits, keep it */
> +               if (sta->airtime[ac].aql_limit_low =3D=3D q_limit_low_old=
 &&
> +                   sta->airtime[ac].aql_limit_high =3D=3D q_limit_high_o=
ld) {
> +                       sta->airtime[ac].aql_limit_low =3D q_limit_low;
> +                       sta->airtime[ac].aql_limit_high =3D q_limit_high;
> +               }
> +       }
> +       mutex_unlock(&local->sta_mtx);
> +       return count;
> +}
> +
> +static const struct file_operations aql_txq_limit_ops =3D {
> +       .write =3D aql_txq_limit_write,
> +       .read =3D aql_txq_limit_read,
> +       .open =3D simple_open,
> +       .llseek =3D default_llseek,
> +};
> +
>  static ssize_t force_tx_status_read(struct file *file,
>                                     char __user *user_buf,
>                                     size_t count,
> @@ -441,6 +522,10 @@ void debugfs_hw_add(struct ieee80211_local *local)
>         debugfs_create_u16("airtime_flags", 0600,
>                            phyd, &local->airtime_flags);
>
> +       DEBUGFS_ADD(aql_txq_limit);
> +       debugfs_create_u32("aql_threshold", 0600,
> +                          phyd, &local->aql_threshold);
> +
>         statsd =3D debugfs_create_dir("statistics", phyd);
>
>         /* if the dir failed, don't put all the other things into the roo=
t! */
> diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
> index c8ad20c28c43..0185e6e5e5d1 100644
> --- a/net/mac80211/debugfs_sta.c
> +++ b/net/mac80211/debugfs_sta.c
> @@ -197,10 +197,12 @@ static ssize_t sta_airtime_read(struct file *file, =
char __user *userbuf,
>  {
>         struct sta_info *sta =3D file->private_data;
>         struct ieee80211_local *local =3D sta->sdata->local;
> -       size_t bufsz =3D 200;
> +       size_t bufsz =3D 400;
>         char *buf =3D kzalloc(bufsz, GFP_KERNEL), *p =3D buf;
>         u64 rx_airtime =3D 0, tx_airtime =3D 0;
>         s64 deficit[IEEE80211_NUM_ACS];
> +       u32 q_depth[IEEE80211_NUM_ACS];
> +       u32 q_limit_l[IEEE80211_NUM_ACS], q_limit_h[IEEE80211_NUM_ACS];
>         ssize_t rv;
>         int ac;
>
> @@ -212,19 +214,22 @@ static ssize_t sta_airtime_read(struct file *file, =
char __user *userbuf,
>                 rx_airtime +=3D sta->airtime[ac].rx_airtime;
>                 tx_airtime +=3D sta->airtime[ac].tx_airtime;
>                 deficit[ac] =3D sta->airtime[ac].deficit;
> +               q_limit_l[ac] =3D sta->airtime[ac].aql_limit_low;
> +               q_limit_h[ac] =3D sta->airtime[ac].aql_limit_high;
>                 spin_unlock_bh(&local->active_txq_lock[ac]);
> +               q_depth[ac] =3D atomic_read(&sta->airtime[ac].aql_tx_pend=
ing);
>         }
>
>         p +=3D scnprintf(p, bufsz + buf - p,
>                 "RX: %llu us\nTX: %llu us\nWeight: %u\n"
> -               "Deficit: VO: %lld us VI: %lld us BE: %lld us BK: %lld us=
\n",
> -               rx_airtime,
> -               tx_airtime,
> -               sta->airtime_weight,
> -               deficit[0],
> -               deficit[1],
> -               deficit[2],
> -               deficit[3]);
> +               "Deficit: VO: %lld us VI: %lld us BE: %lld us BK: %lld us=
\n"
> +               "Q depth: VO: %u us VI: %u us BE: %u us BK: %u us\n"
> +               "Q limit[low/high]: VO: %u/%u VI: %u/%u BE: %u/%u BK: %u/=
%u\n",
> +               rx_airtime, tx_airtime, sta->airtime_weight,
> +               deficit[0], deficit[1], deficit[2], deficit[3],
> +               q_depth[0], q_depth[1], q_depth[2], q_depth[3],
> +               q_limit_l[0], q_limit_h[0], q_limit_l[1], q_limit_h[1],
> +               q_limit_l[2], q_limit_h[2], q_limit_l[3], q_limit_h[3]),
>
>         rv =3D simple_read_from_buffer(userbuf, count, ppos, buf, p - buf=
);
>         kfree(buf);
> @@ -236,7 +241,25 @@ static ssize_t sta_airtime_write(struct file *file, =
const char __user *userbuf,
>  {
>         struct sta_info *sta =3D file->private_data;
>         struct ieee80211_local *local =3D sta->sdata->local;
> -       int ac;
> +       u32 ac, q_limit_l, q_limit_h;
> +       char _buf[100] =3D {}, *buf =3D _buf;
> +
> +       if (count > sizeof(_buf))
> +               return -EINVAL;
> +
> +       if (copy_from_user(buf, userbuf, count))
> +               return -EFAULT;
> +
> +       buf[sizeof(_buf) - 1] =3D '\0';
> +       if (sscanf(buf, "queue limit %u %u %u", &ac, &q_limit_l, &q_limit=
_h)
> +           !=3D 3)
> +               return -EINVAL;
> +
> +       if (ac >=3D IEEE80211_NUM_ACS)
> +               return -EINVAL;
> +
> +       sta->airtime[ac].aql_limit_low =3D q_limit_l;
> +       sta->airtime[ac].aql_limit_high =3D q_limit_h;
>
>         for (ac =3D 0; ac < IEEE80211_NUM_ACS; ac++) {
>                 spin_lock_bh(&local->active_txq_lock[ac]);
> diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
> index 225ea4e3cd76..ad15b3be8bb3 100644
> --- a/net/mac80211/ieee80211_i.h
> +++ b/net/mac80211/ieee80211_i.h
> @@ -1142,6 +1142,10 @@ struct ieee80211_local {
>         u16 schedule_round[IEEE80211_NUM_ACS];
>
>         u16 airtime_flags;
> +       u32 aql_txq_limit_low[IEEE80211_NUM_ACS];
> +       u32 aql_txq_limit_high[IEEE80211_NUM_ACS];
> +       u32 aql_threshold;
> +       atomic_t aql_total_pending_airtime;
>
>         const struct ieee80211_ops *ops;
>
> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
> index aba094b4ccfc..071ea92a3748 100644
> --- a/net/mac80211/main.c
> +++ b/net/mac80211/main.c
> @@ -667,8 +667,16 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t pr=
iv_data_len,
>         for (i =3D 0; i < IEEE80211_NUM_ACS; i++) {
>                 INIT_LIST_HEAD(&local->active_txqs[i]);
>                 spin_lock_init(&local->active_txq_lock[i]);
> +               local->aql_txq_limit_low[i] =3D IEEE80211_DEFAULT_AQL_TXQ=
_LIMIT_L;
> +               local->aql_txq_limit_high[i] =3D
> +                       IEEE80211_DEFAULT_AQL_TXQ_LIMIT_H;
>         }
> -       local->airtime_flags =3D AIRTIME_USE_TX | AIRTIME_USE_RX;
> +
> +       local->airtime_flags =3D AIRTIME_USE_TX |
> +                              AIRTIME_USE_RX |
> +                              AIRTIME_USE_AQL;
> +       local->aql_threshold =3D IEEE80211_AQL_THRESHOLD;
> +       atomic_set(&local->aql_total_pending_airtime, 0);
>
>         INIT_LIST_HEAD(&local->chanctx_list);
>         mutex_init(&local->chanctx_mtx);
> diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
> index 465d83b13582..1fe02022a31a 100644
> --- a/net/mac80211/sta_info.c
> +++ b/net/mac80211/sta_info.c
> @@ -416,6 +416,9 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_=
if_data *sdata,
>                 skb_queue_head_init(&sta->ps_tx_buf[i]);
>                 skb_queue_head_init(&sta->tx_filtered[i]);
>                 sta->airtime[i].deficit =3D sta->airtime_weight;
> +               atomic_set(&sta->airtime[i].aql_tx_pending, 0);
> +               sta->airtime[i].aql_limit_low =3D local->aql_txq_limit_lo=
w[i];
> +               sta->airtime[i].aql_limit_high =3D local->aql_txq_limit_h=
igh[i];
>         }
>
>         for (i =3D 0; i < IEEE80211_NUM_TIDS; i++)
> @@ -1913,6 +1916,41 @@ void ieee80211_sta_register_airtime(struct ieee802=
11_sta *pubsta, u8 tid,
>  }
>  EXPORT_SYMBOL(ieee80211_sta_register_airtime);
>
> +void ieee80211_sta_update_pending_airtime(struct ieee80211_local *local,
> +                                         struct sta_info *sta, u8 ac,
> +                                         u16 tx_airtime, bool tx_complet=
ed)
> +{
> +       int tx_pending;
> +
> +       if (!tx_completed) {
> +               if (sta)
> +                       atomic_add(tx_airtime,
> +                                  &sta->airtime[ac].aql_tx_pending);
> +
> +               atomic_add(tx_airtime, &local->aql_total_pending_airtime)=
;
> +               return;
> +       }
> +
> +       if (sta) {
> +               tx_pending =3D atomic_sub_return(tx_airtime,
> +                                              &sta->airtime[ac].aql_tx_p=
ending);
> +               if (WARN_ONCE(tx_pending < 0,
> +                             "STA %pM AC %d txq pending airtime underflo=
w: %u, %u",
> +                             sta->addr, ac, tx_pending, tx_airtime))
> +                       atomic_cmpxchg(&sta->airtime[ac].aql_tx_pending,
> +                                      tx_pending, 0);
> +       }
> +
> +       tx_pending =3D atomic_sub_return(tx_airtime,
> +                                      &local->aql_total_pending_airtime)=
;
> +       if (WARN_ONCE(tx_pending < 0,
> +                     "Device %s AC %d pending airtime underflow: %u, %u"=
,
> +                     wiphy_name(local->hw.wiphy), ac, tx_pending,
> +                     tx_airtime))
> +               atomic_cmpxchg(&local->aql_total_pending_airtime,
> +                              tx_pending, 0);
> +}
> +
>  int sta_info_move_state(struct sta_info *sta,
>                         enum ieee80211_sta_state new_state)
>  {
> diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
> index 80e76569144e..0608d49b3826 100644
> --- a/net/mac80211/sta_info.h
> +++ b/net/mac80211/sta_info.h
> @@ -127,13 +127,21 @@ enum ieee80211_agg_stop_reason {
>  /* Debugfs flags to enable/disable use of RX/TX airtime in scheduler */
>  #define AIRTIME_USE_TX         BIT(0)
>  #define AIRTIME_USE_RX         BIT(1)
> +#define AIRTIME_USE_AQL                BIT(2)
>
>  struct airtime_info {
>         u64 rx_airtime;
>         u64 tx_airtime;
>         s64 deficit;
> +       atomic_t aql_tx_pending; /* Estimated airtime for frames pending =
*/
> +       u32 aql_limit_low;
> +       u32 aql_limit_high;
>  };
>
> +void ieee80211_sta_update_pending_airtime(struct ieee80211_local *local,
> +                                         struct sta_info *sta, u8 ac,
> +                                         u16 tx_airtime, bool tx_complet=
ed);
> +
>  struct sta_info;
>
>  /**
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index db38be1b75fa..aafc67b562eb 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -3674,7 +3674,8 @@ struct ieee80211_txq *ieee80211_next_txq(struct iee=
e80211_hw *hw, u8 ac)
>  {
>         struct ieee80211_local *local =3D hw_to_local(hw);
>         struct ieee80211_txq *ret =3D NULL;
> -       struct txq_info *txqi =3D NULL;
> +       struct txq_info *txqi =3D NULL, *head =3D NULL;
> +       bool found_eligible_txq =3D false;
>
>         spin_lock_bh(&local->active_txq_lock[ac]);
>
> @@ -3685,13 +3686,26 @@ struct ieee80211_txq *ieee80211_next_txq(struct i=
eee80211_hw *hw, u8 ac)
>         if (!txqi)
>                 goto out;
>
> +       if (txqi =3D=3D head && !found_eligible_txq)
> +               goto out;
> +
> +       if (!head)
> +               head =3D txqi;
> +
>         if (txqi->txq.sta) {
>                 struct sta_info *sta =3D container_of(txqi->txq.sta,
> -                                               struct sta_info, sta);
> +                                                   struct sta_info, sta)=
;
> +               bool aql_check =3D ieee80211_txq_airtime_check(hw, &txqi-=
>txq);
> +               s64 deficit =3D sta->airtime[txqi->txq.ac].deficit;
> +
> +               if (aql_check)
> +                       found_eligible_txq =3D true;
>
> -               if (sta->airtime[txqi->txq.ac].deficit < 0) {
> +               if (deficit < 0)
>                         sta->airtime[txqi->txq.ac].deficit +=3D
>                                 sta->airtime_weight;
> +
> +               if (deficit < 0 || !aql_check) {
>                         list_move_tail(&txqi->schedule_order,
>                                        &local->active_txqs[txqi->txq.ac])=
;
>                         goto begin;
> @@ -3745,6 +3759,33 @@ void __ieee80211_schedule_txq(struct ieee80211_hw =
*hw,
>  }
>  EXPORT_SYMBOL(__ieee80211_schedule_txq);
>
> +bool ieee80211_txq_airtime_check(struct ieee80211_hw *hw,
> +                                struct ieee80211_txq *txq)
> +{
> +       struct sta_info *sta;
> +       struct ieee80211_local *local =3D hw_to_local(hw);
> +
> +       if (!(local->airtime_flags & AIRTIME_USE_AQL))
> +               return true;
> +
> +       if (!txq->sta)
> +               return true;
> +
> +       sta =3D container_of(txq->sta, struct sta_info, sta);
> +       if (atomic_read(&sta->airtime[txq->ac].aql_tx_pending) <
> +           sta->airtime[txq->ac].aql_limit_low)
> +               return true;
> +
> +       if (atomic_read(&local->aql_total_pending_airtime) <
> +           local->aql_threshold &&
> +           atomic_read(&sta->airtime[txq->ac].aql_tx_pending) <
> +           sta->airtime[txq->ac].aql_limit_high)
> +               return true;
> +
> +       return false;
> +}
> +EXPORT_SYMBOL(ieee80211_txq_airtime_check);
> +
>  bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
>                                 struct ieee80211_txq *txq)
>  {
>
