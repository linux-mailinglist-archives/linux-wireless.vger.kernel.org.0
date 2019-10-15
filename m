Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4C5ED7D48
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2019 19:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730890AbfJORTJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Oct 2019 13:19:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28709 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730831AbfJORTI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Oct 2019 13:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571159946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XnkDlyOiYYUttRmAdYa5cySMniZ9t2R59IF001zI9ZE=;
        b=cbXbCWUMyOefHAheoctbYVR7x4qhI7QZWjkg3Q5XYtcVr3OcQmGI7kiFXK9Wko6KsdTJEu
        fkL9d6Ki82B7qYEbEQu6mGDLFQej/osBKJiLVZIHPh9mKLabfcoVg2aE1MrhPxSniLwikO
        Ugc8v3tE7jfy+CeXMP93TJ6BKkVvhWA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-WnnaUMP8ObORAcetdoGx8g-1; Tue, 15 Oct 2019 13:19:04 -0400
Received: by mail-lf1-f71.google.com with SMTP id y27so3912112lfg.21
        for <linux-wireless@vger.kernel.org>; Tue, 15 Oct 2019 10:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=IFzHIo7rEgOEbTBpyBUconBFu5SsXwEfs6ZewoNOLxo=;
        b=TD8mpjv6MRyq5m31l3iBDsUZgZXGSCngLcN2dwiegWU6GSJgFnpM5MD63uwEFRR5OC
         vFWmAXWvqoa8nQx7Wj8WmrNDxYqQo2RSNhYNSBcgfieTbM8CWmUHSyq2VcXVGkQe05l9
         hD/zKZrfLzRJna+76lqoKTgI2+f4OCouuUkEdQvpjR7HZ0S0ljTmHP5JWdzLgwMdPLWS
         CQPFDbSDmSG1KACNIdzNpQ5VciyDfBgKZ0BH2CmorGqDlAQQorSOg4Ird3nX62i6g2ic
         irIn+wbBslz2E3gsaho8YOH3E9FtXYazYV1zCWd1NOyRt6R+qM/Fc3wY/Q4y89wkEZsd
         8bEA==
X-Gm-Message-State: APjAAAXH1E6WXBsPBnDMu12huo9rrzQNpv5v6lZkeGoPnYX/dBzy9brj
        QRWXnttcV6JpCznD0JH5QIkPxHfTl5dwW9WqI7T1H+4DUMyGLoF/TlIICGbphe9vErPbaOibAQC
        sgewTAptsZuWsXe+trpnnOWucSko=
X-Received: by 2002:a05:651c:1069:: with SMTP id y9mr13229245ljm.171.1571159942691;
        Tue, 15 Oct 2019 10:19:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyjSYa0JNvu0wF2H3xMh8lZQ3RmGD1nKvu+kMymV3E4Jtxv0qcmmb0RHfHWg8pk9ItYXJGm6w==
X-Received: by 2002:a05:651c:1069:: with SMTP id y9mr13229214ljm.171.1571159942143;
        Tue, 15 Oct 2019 10:19:02 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id i17sm5248094lfj.35.2019.10.15.10.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 10:19:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DBFD41803A9; Tue, 15 Oct 2019 19:19:00 +0200 (CEST)
Subject: [PATCH v2 3/4] mac80211: Implement Airtime-based Queue Limit (AQL)
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Kan Yan <kyan@google.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Date:   Tue, 15 Oct 2019 19:19:00 +0200
Message-ID: <157115994083.2500430.6570557769527791276.stgit@toke.dk>
In-Reply-To: <157115993755.2500430.12214017471129215800.stgit@toke.dk>
References: <157115993755.2500430.12214017471129215800.stgit@toke.dk>
User-Agent: StGit/0.20
MIME-Version: 1.0
X-MC-Unique: WnnaUMP8ObORAcetdoGx8g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kan Yan <kyan@google.com>

In order for the Fq_CoDel integrated in mac80211 layer operates effectively
to control excessive queueing latency, the CoDel algorithm requires an
accurate measure of how long the packets stays in the queue, aka sojourn
time. The sojourn time measured at mac80211 layer doesn't include queueing
latency in lower layer (firmware/hardware) and CoDel expects lower layer to
have a short queue. However, most 802.11ac chipsets offload tasks such TX
aggregation to firmware or hardware, thus have a deep lower layer queue.
Without a mechanism to control the lower layer queue size, packets only
stays in mac80211 layer transiently before being sent to firmware queue.
As a result, the sojourn time measured by CoDel in the mac80211 layer is
almost always lower than the CoDel latency target, hence CoDel does little
to control the latency, even when the lower layer queue causes excessive
latency.

Byte Queue limits (BQL) is commonly used to address the similar issue with
wired network interface. However, this method cannot be applied directly
to the wireless network interface. Byte is not a suitable measure of queue
depth in the wireless network, as the data rate can vary dramatically from
station to station in the same network, from a few Mbps to over Gbps.

This patch implemented an Airtime-based Queue Limit (AQL) to make CoDel
works effectively with wireless drivers that utilized firmware/hardware
offloading. AQL only allows each txq to release just enough packets to the
lower layer to form 1-2 large aggregations to keep hardware fully utilized
and keep the rest of frames in mac80211 layer to be controlled by the CoDel
algorithm.

Signed-off-by: Kan Yan <kyan@google.com>
[ Toke: Get rid of the driver API to set pending airtime ]
Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
---
 include/net/cfg80211.h     |    7 ++++
 include/net/mac80211.h     |   12 +++++++
 net/mac80211/debugfs.c     |   78 ++++++++++++++++++++++++++++++++++++++++=
++++
 net/mac80211/debugfs_sta.c |   43 +++++++++++++++++++-----
 net/mac80211/ieee80211_i.h |    4 ++
 net/mac80211/main.c        |    9 +++++
 net/mac80211/sta_info.c    |   32 ++++++++++++++++++
 net/mac80211/sta_info.h    |    8 +++++
 net/mac80211/tx.c          |   46 ++++++++++++++++++++++++--
 9 files changed, 225 insertions(+), 14 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index ff45c3e1abff..8d50c0a60dbd 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2602,6 +2602,13 @@ enum wiphy_params_flags {
=20
 #define IEEE80211_DEFAULT_AIRTIME_WEIGHT=09256
=20
+/* The per TXQ device queue limit in airtime */
+#define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_L=094000
+#define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_H=098000
+
+/* The per interface airtime threshold to switch to lower queue limit */
+#define IEEE80211_AQL_THRESHOLD=09=09=0924000
+
 /**
  * struct cfg80211_pmksa - PMK Security Association
  *
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 7619eb74d612..b5727a20754c 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5575,6 +5575,18 @@ void ieee80211_send_eosp_nullfunc(struct ieee80211_s=
ta *pubsta, int tid);
 void ieee80211_sta_register_airtime(struct ieee80211_sta *pubsta, u8 tid,
 =09=09=09=09    u32 tx_airtime, u32 rx_airtime);
=20
+/**
+ * ieee80211_txq_airtime_check - check if a txq can send frame to device
+ *
+ * @hw: pointer obtained from ieee80211_alloc_hw()
+ * @txq: pointer obtained from station or virtual interface
+ *
+ * Return true if the AQL's airtime limit has not been reached and the txq=
 can
+ * continue to send more packets to the device. Otherwise return false.
+ */
+bool
+ieee80211_txq_airtime_check(struct ieee80211_hw *hw, struct ieee80211_txq =
*txq);
+
 /**
  * ieee80211_iter_keys - iterate keys programmed into the device
  * @hw: pointer obtained from ieee80211_alloc_hw()
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 568b3b276931..d77ea0e51c1d 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -148,6 +148,80 @@ static const struct file_operations aqm_ops =3D {
 =09.llseek =3D default_llseek,
 };
=20
+static ssize_t aql_txq_limit_read(struct file *file,
+=09=09=09=09  char __user *user_buf,
+=09=09=09=09  size_t count,
+=09=09=09=09  loff_t *ppos)
+{
+=09struct ieee80211_local *local =3D file->private_data;
+=09char buf[400];
+=09int len =3D 0;
+
+=09len =3D scnprintf(buf, sizeof(buf),
+=09=09=09"AC=09AQL limit low=09AQL limit high\n"
+=09=09=09"VO=09%u=09=09%u\n"
+=09=09=09"VI=09%u=09=09%u\n"
+=09=09=09"BE=09%u=09=09%u\n"
+=09=09=09"BK=09%u=09=09%u\n",
+=09=09=09local->aql_txq_limit_low[IEEE80211_AC_VO],
+=09=09=09local->aql_txq_limit_high[IEEE80211_AC_VO],
+=09=09=09local->aql_txq_limit_low[IEEE80211_AC_VI],
+=09=09=09local->aql_txq_limit_high[IEEE80211_AC_VI],
+=09=09=09local->aql_txq_limit_low[IEEE80211_AC_BE],
+=09=09=09local->aql_txq_limit_high[IEEE80211_AC_BE],
+=09=09=09local->aql_txq_limit_low[IEEE80211_AC_BK],
+=09=09=09local->aql_txq_limit_high[IEEE80211_AC_BK]);
+=09return simple_read_from_buffer(user_buf, count, ppos,
+=09=09=09=09       buf, len);
+}
+
+static ssize_t aql_txq_limit_write(struct file *file,
+=09=09=09=09   const char __user *user_buf,
+=09=09=09=09   size_t count,
+=09=09=09=09   loff_t *ppos)
+{
+=09struct ieee80211_local *local =3D file->private_data;
+=09char buf[100];
+=09size_t len;
+=09u32 ac, q_limit_low, q_limit_high;
+=09struct sta_info *sta;
+
+=09if (count > sizeof(buf))
+=09=09return -EINVAL;
+
+=09if (copy_from_user(buf, user_buf, count))
+=09=09return -EFAULT;
+
+=09buf[sizeof(buf) - 1] =3D 0;
+=09len =3D strlen(buf);
+=09if (len > 0 && buf[len - 1] =3D=3D '\n')
+=09=09buf[len - 1] =3D 0;
+
+=09if (sscanf(buf, "%u %u %u", &ac, &q_limit_low, &q_limit_high) !=3D 3)
+=09=09return -EINVAL;
+
+=09if (ac >=3D IEEE80211_NUM_ACS)
+=09=09return -EINVAL;
+
+=09local->aql_txq_limit_low[ac] =3D q_limit_low;
+=09local->aql_txq_limit_high[ac] =3D q_limit_high;
+
+=09mutex_lock(&local->sta_mtx);
+=09list_for_each_entry(sta, &local->sta_list, list) {
+=09=09sta->airtime[ac].aql_limit_low =3D q_limit_low;
+=09=09sta->airtime[ac].aql_limit_high =3D q_limit_high;
+=09}
+=09mutex_unlock(&local->sta_mtx);
+=09return count;
+}
+
+static const struct file_operations aql_txq_limit_ops =3D {
+=09.write =3D aql_txq_limit_write,
+=09.read =3D aql_txq_limit_read,
+=09.open =3D simple_open,
+=09.llseek =3D default_llseek,
+};
+
 static ssize_t force_tx_status_read(struct file *file,
 =09=09=09=09    char __user *user_buf,
 =09=09=09=09    size_t count,
@@ -441,6 +515,10 @@ void debugfs_hw_add(struct ieee80211_local *local)
 =09debugfs_create_u16("airtime_flags", 0600,
 =09=09=09   phyd, &local->airtime_flags);
=20
+=09DEBUGFS_ADD(aql_txq_limit);
+=09debugfs_create_u32("aql_threshold", 0600,
+=09=09=09   phyd, &local->aql_threshold);
+
 =09statsd =3D debugfs_create_dir("statistics", phyd);
=20
 =09/* if the dir failed, don't put all the other things into the root! */
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index c8ad20c28c43..9f9b8f5ed86a 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -197,10 +197,12 @@ static ssize_t sta_airtime_read(struct file *file, ch=
ar __user *userbuf,
 {
 =09struct sta_info *sta =3D file->private_data;
 =09struct ieee80211_local *local =3D sta->sdata->local;
-=09size_t bufsz =3D 200;
+=09size_t bufsz =3D 400;
 =09char *buf =3D kzalloc(bufsz, GFP_KERNEL), *p =3D buf;
 =09u64 rx_airtime =3D 0, tx_airtime =3D 0;
 =09s64 deficit[IEEE80211_NUM_ACS];
+=09u32 q_depth[IEEE80211_NUM_ACS];
+=09u32 q_limit_l[IEEE80211_NUM_ACS], q_limit_h[IEEE80211_NUM_ACS];
 =09ssize_t rv;
 =09int ac;
=20
@@ -212,19 +214,22 @@ static ssize_t sta_airtime_read(struct file *file, ch=
ar __user *userbuf,
 =09=09rx_airtime +=3D sta->airtime[ac].rx_airtime;
 =09=09tx_airtime +=3D sta->airtime[ac].tx_airtime;
 =09=09deficit[ac] =3D sta->airtime[ac].deficit;
+=09=09q_limit_l[ac] =3D sta->airtime[ac].aql_limit_low;
+=09=09q_limit_h[ac] =3D sta->airtime[ac].aql_limit_high;
+=09=09q_depth[ac] =3D sta->airtime[ac].aql_tx_pending;
 =09=09spin_unlock_bh(&local->active_txq_lock[ac]);
 =09}
=20
 =09p +=3D scnprintf(p, bufsz + buf - p,
 =09=09"RX: %llu us\nTX: %llu us\nWeight: %u\n"
-=09=09"Deficit: VO: %lld us VI: %lld us BE: %lld us BK: %lld us\n",
-=09=09rx_airtime,
-=09=09tx_airtime,
-=09=09sta->airtime_weight,
-=09=09deficit[0],
-=09=09deficit[1],
-=09=09deficit[2],
-=09=09deficit[3]);
+=09=09"Deficit: VO: %lld us VI: %lld us BE: %lld us BK: %lld us\n"
+=09=09"Q depth: VO: %u us VI: %u us BE: %u us BK: %u us\n"
+=09=09"Q limit[low/high]: VO: %u/%u VI: %u/%u BE: %u/%u BK: %u/%u\n",
+=09=09rx_airtime, tx_airtime, sta->airtime_weight,
+=09=09deficit[0], deficit[1], deficit[2], deficit[3],
+=09=09q_depth[0], q_depth[1], q_depth[2], q_depth[3],
+=09=09q_limit_l[0], q_limit_h[0], q_limit_l[1], q_limit_h[1],
+=09=09q_limit_l[2], q_limit_h[2], q_limit_l[3], q_limit_h[3]),
=20
 =09rv =3D simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
 =09kfree(buf);
@@ -236,7 +241,25 @@ static ssize_t sta_airtime_write(struct file *file, co=
nst char __user *userbuf,
 {
 =09struct sta_info *sta =3D file->private_data;
 =09struct ieee80211_local *local =3D sta->sdata->local;
-=09int ac;
+=09u32 ac, q_limit_l, q_limit_h;
+=09char _buf[100] =3D {}, *buf =3D _buf;
+
+=09if (count > sizeof(_buf))
+=09=09return -EINVAL;
+
+=09if (copy_from_user(buf, userbuf, count))
+=09=09return -EFAULT;
+
+=09buf[sizeof(_buf) - 1] =3D '\0';
+=09if (sscanf(buf, "queue limit %u %u %u", &ac, &q_limit_l, &q_limit_h)
+=09    !=3D 3)
+=09=09return -EINVAL;
+
+=09if (ac >=3D IEEE80211_NUM_ACS)
+=09=09return -EINVAL;
+
+=09sta->airtime[ac].aql_limit_low =3D q_limit_l;
+=09sta->airtime[ac].aql_limit_high =3D q_limit_h;
=20
 =09for (ac =3D 0; ac < IEEE80211_NUM_ACS; ac++) {
 =09=09spin_lock_bh(&local->active_txq_lock[ac]);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 225ea4e3cd76..6fa690757388 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1142,6 +1142,10 @@ struct ieee80211_local {
 =09u16 schedule_round[IEEE80211_NUM_ACS];
=20
 =09u16 airtime_flags;
+=09u32 aql_txq_limit_low[IEEE80211_NUM_ACS];
+=09u32 aql_txq_limit_high[IEEE80211_NUM_ACS];
+=09u32 aql_threshold;
+=09u32 aql_total_pending_airtime;
=20
 =09const struct ieee80211_ops *ops;
=20
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index aba094b4ccfc..0792c9b9c850 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -667,8 +667,15 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv=
_data_len,
 =09for (i =3D 0; i < IEEE80211_NUM_ACS; i++) {
 =09=09INIT_LIST_HEAD(&local->active_txqs[i]);
 =09=09spin_lock_init(&local->active_txq_lock[i]);
+=09=09local->aql_txq_limit_low[i] =3D IEEE80211_DEFAULT_AQL_TXQ_LIMIT_L;
+=09=09local->aql_txq_limit_high[i] =3D
+=09=09=09IEEE80211_DEFAULT_AQL_TXQ_LIMIT_H;
 =09}
-=09local->airtime_flags =3D AIRTIME_USE_TX | AIRTIME_USE_RX;
+
+=09local->airtime_flags =3D AIRTIME_USE_TX |
+=09=09=09       AIRTIME_USE_RX |
+=09=09=09       AIRTIME_USE_AQL;
+=09local->aql_threshold =3D IEEE80211_AQL_THRESHOLD;
=20
 =09INIT_LIST_HEAD(&local->chanctx_list);
 =09mutex_init(&local->chanctx_mtx);
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index bd11fef2139f..64bacf4f068c 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -396,6 +396,9 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_if=
_data *sdata,
 =09=09skb_queue_head_init(&sta->ps_tx_buf[i]);
 =09=09skb_queue_head_init(&sta->tx_filtered[i]);
 =09=09sta->airtime[i].deficit =3D sta->airtime_weight;
+=09=09sta->airtime[i].aql_tx_pending =3D 0;
+=09=09sta->airtime[i].aql_limit_low =3D local->aql_txq_limit_low[i];
+=09=09sta->airtime[i].aql_limit_high =3D local->aql_txq_limit_high[i];
 =09}
=20
 =09for (i =3D 0; i < IEEE80211_NUM_TIDS; i++)
@@ -1893,6 +1896,35 @@ void ieee80211_sta_register_airtime(struct ieee80211=
_sta *pubsta, u8 tid,
 }
 EXPORT_SYMBOL(ieee80211_sta_register_airtime);
=20
+void ieee80211_sta_update_pending_airtime(struct ieee80211_local *local,
+=09=09=09=09=09  struct sta_info *sta, u8 ac,
+=09=09=09=09=09  u16 tx_airtime, bool tx_completed)
+{
+=09spin_lock_bh(&local->active_txq_lock[ac]);
+=09if (tx_completed) {
+=09=09if (sta) {
+=09=09=09if (WARN_ONCE(sta->airtime[ac].aql_tx_pending < tx_airtime,
+=09=09=09=09      "TXQ pending airtime underflow: %u, %u",
+=09=09=09=09      sta->airtime[ac].aql_tx_pending, tx_airtime))
+=09=09=09=09sta->airtime[ac].aql_tx_pending =3D 0;
+=09=09=09else
+=09=09=09=09sta->airtime[ac].aql_tx_pending -=3D tx_airtime;
+=09=09}
+
+=09=09if (WARN_ONCE(local->aql_total_pending_airtime < tx_airtime,
+=09=09=09      "Device pending airtime underflow: %u, %u",
+=09=09=09      local->aql_total_pending_airtime, tx_airtime))
+=09=09=09local->aql_total_pending_airtime =3D 0;
+=09=09else
+=09=09=09local->aql_total_pending_airtime -=3D tx_airtime;
+=09} else {
+=09=09if (sta)
+=09=09=09sta->airtime[ac].aql_tx_pending +=3D tx_airtime;
+=09=09local->aql_total_pending_airtime +=3D tx_airtime;
+=09}
+=09spin_unlock_bh(&local->active_txq_lock[ac]);
+}
+
 int sta_info_move_state(struct sta_info *sta,
 =09=09=09enum ieee80211_sta_state new_state)
 {
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 369c2dddce52..4e4d76e81b0f 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -127,13 +127,21 @@ enum ieee80211_agg_stop_reason {
 /* Debugfs flags to enable/disable use of RX/TX airtime in scheduler */
 #define AIRTIME_USE_TX=09=09BIT(0)
 #define AIRTIME_USE_RX=09=09BIT(1)
+#define AIRTIME_USE_AQL=09=09BIT(2)
=20
 struct airtime_info {
 =09u64 rx_airtime;
 =09u64 tx_airtime;
 =09s64 deficit;
+=09u32 aql_tx_pending; /* Estimated airtime for frames pending in queue */
+=09u32 aql_limit_low;
+=09u32 aql_limit_high;
 };
=20
+void ieee80211_sta_update_pending_airtime(struct ieee80211_local *local,
+=09=09=09=09=09  struct sta_info *sta, u8 ac,
+=09=09=09=09=09  u16 tx_airtime, bool tx_completed);
+
 struct sta_info;
=20
 /**
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 938c10f7955b..405f622b3fe0 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3665,7 +3665,8 @@ struct ieee80211_txq *ieee80211_next_txq(struct ieee8=
0211_hw *hw, u8 ac)
 {
 =09struct ieee80211_local *local =3D hw_to_local(hw);
 =09struct ieee80211_txq *ret =3D NULL;
-=09struct txq_info *txqi =3D NULL;
+=09struct txq_info *txqi =3D NULL, *head =3D NULL;
+=09bool found_eligible_txq =3D false;
=20
 =09spin_lock_bh(&local->active_txq_lock[ac]);
=20
@@ -3676,13 +3677,26 @@ struct ieee80211_txq *ieee80211_next_txq(struct iee=
e80211_hw *hw, u8 ac)
 =09if (!txqi)
 =09=09goto out;
=20
+=09if (txqi =3D=3D head && !found_eligible_txq)
+=09=09goto out;
+
+=09if (!head)
+=09=09head =3D txqi;
+
 =09if (txqi->txq.sta) {
 =09=09struct sta_info *sta =3D container_of(txqi->txq.sta,
-=09=09=09=09=09=09struct sta_info, sta);
+=09=09=09=09=09=09    struct sta_info, sta);
+=09=09bool aql_check =3D ieee80211_txq_airtime_check(hw, &txqi->txq);
+=09=09s64 deficit =3D sta->airtime[txqi->txq.ac].deficit;
+
+=09=09if (aql_check)
+=09=09=09found_eligible_txq =3D true;
=20
-=09=09if (sta->airtime[txqi->txq.ac].deficit < 0) {
+=09=09if (deficit < 0)
 =09=09=09sta->airtime[txqi->txq.ac].deficit +=3D
 =09=09=09=09sta->airtime_weight;
+
+=09=09if (deficit < 0 || !aql_check) {
 =09=09=09list_move_tail(&txqi->schedule_order,
 =09=09=09=09       &local->active_txqs[txqi->txq.ac]);
 =09=09=09goto begin;
@@ -3736,6 +3750,32 @@ void __ieee80211_schedule_txq(struct ieee80211_hw *h=
w,
 }
 EXPORT_SYMBOL(__ieee80211_schedule_txq);
=20
+bool ieee80211_txq_airtime_check(struct ieee80211_hw *hw,
+=09=09=09=09 struct ieee80211_txq *txq)
+{
+=09struct sta_info *sta;
+=09struct ieee80211_local *local =3D hw_to_local(hw);
+
+=09if (!(local->airtime_flags & AIRTIME_USE_AQL))
+=09=09return true;
+
+=09if (!txq->sta)
+=09=09return true;
+
+=09sta =3D container_of(txq->sta, struct sta_info, sta);
+=09if (sta->airtime[txq->ac].aql_tx_pending <
+=09    sta->airtime[txq->ac].aql_limit_low)
+=09=09return true;
+
+=09if (local->aql_total_pending_airtime < local->aql_threshold &&
+=09    sta->airtime[txq->ac].aql_tx_pending <
+=09    sta->airtime[txq->ac].aql_limit_high)
+=09=09return true;
+
+=09return false;
+}
+EXPORT_SYMBOL(ieee80211_txq_airtime_check);
+
 bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
 =09=09=09=09struct ieee80211_txq *txq)
 {

