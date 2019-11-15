Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91C72FDECE
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 14:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfKONUw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 08:20:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55172 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727438AbfKONUv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 08:20:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573824049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ABqX/4+Qx8L4BwRHEbiGEmTlEagYaiFV0Tg8XI1FKEQ=;
        b=cnUa5vs0lJNmWVdNry3x7SRjDc1GzKMLANGjsa2FuJDy/K9JAq5blaWeFLNI+iJyq8odfX
        r0VsEaB3NBTLplb6h68rfyg6HMh0U2QHYHANsoDP2uAh55OD7/vdjTlfqhDdhI4ysDJJGR
        e5MQoPVMg5BtEMltRIKLObG7ZyqKtg4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-VJIdaLQGN5GIRBhjIEEmrQ-1; Fri, 15 Nov 2019 08:20:44 -0500
Received: by mail-lj1-f197.google.com with SMTP id r13so1534241ljk.18
        for <linux-wireless@vger.kernel.org>; Fri, 15 Nov 2019 05:20:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=9zAB64m7P+ORU3V1Fb8QxkCq1zL7OXWN/zEiD4RzsPA=;
        b=LEBKx7UqPgADdV4wBmd25rktBgP6sRVyt7wMO5E2iEKrsp4KCnVcEVH1YZH7Zr/O88
         SIYE2ZxFan+QzFVqphm4TNtSH6FOLA1QdO/zSvka63F95rDfAHQyQkcog5Us8r+F+/eh
         TTFqsg4SpCAA5YFWNwFoNwEpcIX3EgXOqd3AD9zwWWsTYdeDPi3hXObJSCm9b5Gk/EB5
         YeZypgy/AKBEnB9JHHdx0SfocWEoZd+T7Jn/ZeSdinRCWEoSiR/vKCXKx2v2s3TXP+Zv
         YrpcVRdkNI/ktTLMAmrUF1dgupPKq1ljJUEtmYvmjtQvmWiNOriYkkj0C9nMjAaq8Wja
         taAQ==
X-Gm-Message-State: APjAAAWiw8qUsmZlOU6DaQiE+LunxmLhElrXdADtL2Pq1PdO1naywUBP
        od6zfG3XdB78+aTk+YiXd7vStk9Y4CrwJDCdOTJTLCWF/zMYk5hF8xmjNsJHvqtijKfzt+m8IKu
        ol8oMMH7Ip7oBR5b40cbHM3pxpE8=
X-Received: by 2002:a2e:574d:: with SMTP id r13mr3459397ljd.10.1573824042709;
        Fri, 15 Nov 2019 05:20:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqyK+2fBonjlsQ7URP31p0E5WpJrtFs2Zs9aA/KHqKFl3v1ThH0iL5NbuiJy5ITf2dDk6TUOFg==
X-Received: by 2002:a2e:574d:: with SMTP id r13mr3459371ljd.10.1573824042287;
        Fri, 15 Nov 2019 05:20:42 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id k6sm5352254lfc.72.2019.11.15.05.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 05:20:41 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2B58F1818C7; Fri, 15 Nov 2019 14:20:40 +0100 (CET)
Subject: [PATCH v9 3/4] mac80211: Implement Airtime-based Queue Limit (AQL)
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Kan Yan <kyan@google.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Date:   Fri, 15 Nov 2019 14:20:40 +0100
Message-ID: <157382404008.580235.4182653624209779472.stgit@toke.dk>
In-Reply-To: <157382403672.580235.12525941420808058808.stgit@toke.dk>
References: <157382403672.580235.12525941420808058808.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-MC-Unique: VJIdaLQGN5GIRBhjIEEmrQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kan Yan <kyan@google.com>

In order for the Fq_CoDel algorithm integrated in mac80211 layer to operate
effectively to control excessive queueing latency, the CoDel algorithm
requires an accurate measure of how long packets stays in the queue, AKA
sojourn time. The sojourn time measured at the mac80211 layer doesn't
include queueing latency in the lower layer (firmware/hardware) and CoDel
expects lower layer to have a short queue. However, most 802.11ac chipsets
offload tasks such TX aggregation to firmware or hardware, thus have a deep
lower layer queue.

Without a mechanism to control the lower layer queue size, packets only
stay in mac80211 layer transiently before being sent to firmware queue.
As a result, the sojourn time measured by CoDel in the mac80211 layer is
almost always lower than the CoDel latency target, hence CoDel does little
to control the latency, even when the lower layer queue causes excessive
latency.

The Byte Queue Limits (BQL) mechanism is commonly used to address the
similar issue with wired network interface. However, this method cannot be
applied directly to the wireless network interface. "Bytes" is not a
suitable measure of queue depth in the wireless network, as the data rate
can vary dramatically from station to station in the same network, from a
few Mbps to over Gbps.

This patch implements an Airtime-based Queue Limit (AQL) to make CoDel work
effectively with wireless drivers that utilized firmware/hardware
offloading. AQL allows each txq to release just enough packets to the lower
layer to form 1-2 large aggregations to keep hardware fully utilized and
retains the rest of the frames in mac80211 layer to be controlled by the
CoDel algorithm.

Signed-off-by: Kan Yan <kyan@google.com>
[ Toke: Keep API to set pending airtime internal, fix nits in commit msg ]
Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
---
 include/net/cfg80211.h     |    7 ++++
 include/net/mac80211.h     |   12 ++++++
 net/mac80211/debugfs.c     |   85 ++++++++++++++++++++++++++++++++++++++++=
++++
 net/mac80211/debugfs_sta.c |   43 +++++++++++++++++-----
 net/mac80211/ieee80211_i.h |    4 ++
 net/mac80211/main.c        |   10 +++++
 net/mac80211/sta_info.c    |   38 ++++++++++++++++++++
 net/mac80211/sta_info.h    |    8 ++++
 net/mac80211/tx.c          |   47 +++++++++++++++++++++++-
 9 files changed, 240 insertions(+), 14 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index e309cc826b40..4f75dbdd406a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2606,6 +2606,13 @@ enum wiphy_params_flags {
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
index 6fc26a051ba0..ba3f33cc41ea 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5565,6 +5565,18 @@ void ieee80211_send_eosp_nullfunc(struct ieee80211_s=
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
index 568b3b276931..399d4e8b8546 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -148,6 +148,87 @@ static const struct file_operations aqm_ops =3D {
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
+=09u32 ac, q_limit_low, q_limit_high, q_limit_low_old, q_limit_high_old;
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
+=09q_limit_low_old =3D local->aql_txq_limit_low[ac];
+=09q_limit_high_old =3D local->aql_txq_limit_high[ac];
+
+=09local->aql_txq_limit_low[ac] =3D q_limit_low;
+=09local->aql_txq_limit_high[ac] =3D q_limit_high;
+
+=09mutex_lock(&local->sta_mtx);
+=09list_for_each_entry(sta, &local->sta_list, list) {
+=09=09/* If a sta has customized queue limits, keep it */
+=09=09if (sta->airtime[ac].aql_limit_low =3D=3D q_limit_low_old &&
+=09=09    sta->airtime[ac].aql_limit_high =3D=3D q_limit_high_old) {
+=09=09=09sta->airtime[ac].aql_limit_low =3D q_limit_low;
+=09=09=09sta->airtime[ac].aql_limit_high =3D q_limit_high;
+=09=09}
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
@@ -441,6 +522,10 @@ void debugfs_hw_add(struct ieee80211_local *local)
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
index c8ad20c28c43..0185e6e5e5d1 100644
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
 =09=09spin_unlock_bh(&local->active_txq_lock[ac]);
+=09=09q_depth[ac] =3D atomic_read(&sta->airtime[ac].aql_tx_pending);
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
index 225ea4e3cd76..ad15b3be8bb3 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1142,6 +1142,10 @@ struct ieee80211_local {
 =09u16 schedule_round[IEEE80211_NUM_ACS];
=20
 =09u16 airtime_flags;
+=09u32 aql_txq_limit_low[IEEE80211_NUM_ACS];
+=09u32 aql_txq_limit_high[IEEE80211_NUM_ACS];
+=09u32 aql_threshold;
+=09atomic_t aql_total_pending_airtime;
=20
 =09const struct ieee80211_ops *ops;
=20
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index aba094b4ccfc..071ea92a3748 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -667,8 +667,16 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv=
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
+=09atomic_set(&local->aql_total_pending_airtime, 0);
=20
 =09INIT_LIST_HEAD(&local->chanctx_list);
 =09mutex_init(&local->chanctx_mtx);
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 465d83b13582..1fe02022a31a 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -416,6 +416,9 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_if=
_data *sdata,
 =09=09skb_queue_head_init(&sta->ps_tx_buf[i]);
 =09=09skb_queue_head_init(&sta->tx_filtered[i]);
 =09=09sta->airtime[i].deficit =3D sta->airtime_weight;
+=09=09atomic_set(&sta->airtime[i].aql_tx_pending, 0);
+=09=09sta->airtime[i].aql_limit_low =3D local->aql_txq_limit_low[i];
+=09=09sta->airtime[i].aql_limit_high =3D local->aql_txq_limit_high[i];
 =09}
=20
 =09for (i =3D 0; i < IEEE80211_NUM_TIDS; i++)
@@ -1913,6 +1916,41 @@ void ieee80211_sta_register_airtime(struct ieee80211=
_sta *pubsta, u8 tid,
 }
 EXPORT_SYMBOL(ieee80211_sta_register_airtime);
=20
+void ieee80211_sta_update_pending_airtime(struct ieee80211_local *local,
+=09=09=09=09=09  struct sta_info *sta, u8 ac,
+=09=09=09=09=09  u16 tx_airtime, bool tx_completed)
+{
+=09int tx_pending;
+
+=09if (!tx_completed) {
+=09=09if (sta)
+=09=09=09atomic_add(tx_airtime,
+=09=09=09=09   &sta->airtime[ac].aql_tx_pending);
+
+=09=09atomic_add(tx_airtime, &local->aql_total_pending_airtime);
+=09=09return;
+=09}
+
+=09if (sta) {
+=09=09tx_pending =3D atomic_sub_return(tx_airtime,
+=09=09=09=09=09       &sta->airtime[ac].aql_tx_pending);
+=09=09if (WARN_ONCE(tx_pending < 0,
+=09=09=09      "STA %pM AC %d txq pending airtime underflow: %u, %u",
+=09=09=09      sta->addr, ac, tx_pending, tx_airtime))
+=09=09=09atomic_cmpxchg(&sta->airtime[ac].aql_tx_pending,
+=09=09=09=09       tx_pending, 0);
+=09}
+
+=09tx_pending =3D atomic_sub_return(tx_airtime,
+=09=09=09=09       &local->aql_total_pending_airtime);
+=09if (WARN_ONCE(tx_pending < 0,
+=09=09      "Device %s AC %d pending airtime underflow: %u, %u",
+=09=09      wiphy_name(local->hw.wiphy), ac, tx_pending,
+=09=09      tx_airtime))
+=09=09atomic_cmpxchg(&local->aql_total_pending_airtime,
+=09=09=09       tx_pending, 0);
+}
+
 int sta_info_move_state(struct sta_info *sta,
 =09=09=09enum ieee80211_sta_state new_state)
 {
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 80e76569144e..0608d49b3826 100644
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
+=09atomic_t aql_tx_pending; /* Estimated airtime for frames pending */
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
index db38be1b75fa..aafc67b562eb 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3674,7 +3674,8 @@ struct ieee80211_txq *ieee80211_next_txq(struct ieee8=
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
@@ -3685,13 +3686,26 @@ struct ieee80211_txq *ieee80211_next_txq(struct iee=
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
@@ -3745,6 +3759,33 @@ void __ieee80211_schedule_txq(struct ieee80211_hw *h=
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
+=09if (atomic_read(&sta->airtime[txq->ac].aql_tx_pending) <
+=09    sta->airtime[txq->ac].aql_limit_low)
+=09=09return true;
+
+=09if (atomic_read(&local->aql_total_pending_airtime) <
+=09    local->aql_threshold &&
+=09    atomic_read(&sta->airtime[txq->ac].aql_tx_pending) <
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

