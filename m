Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC3D11AE61
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2019 15:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbfLKOwq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Dec 2019 09:52:46 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22966 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728976AbfLKOwp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Dec 2019 09:52:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576075964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JhvPKHWABtEYoon3egFxI9Cv5ffyGS5GTVEnHsmntkU=;
        b=QrG17jp3pZex09r9gkMFMw8hA8HUHila1qrNLa2XTjxUWsyygjk4pWEAuYUqA7hNAaoqbV
        bLuvPZ+1za2/1n8S0DrpHpWmZFWkWQin589SCoeuAxQ1FpeU3+SjryUMxOv32Et7SAGVYF
        X2RTK8kKvnHxYwuI5Z/IM3LQV4CdaHk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-mRVoOrV3P6qU1BTKgI7Wzg-1; Wed, 11 Dec 2019 09:52:41 -0500
Received: by mail-lj1-f199.google.com with SMTP id l2so4441981lja.18
        for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2019 06:52:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oj0QULJQyBzjk4IdkExpY8osUlOuaBoaTXY8zUrKxwc=;
        b=tRO9zqUDpAmFEcvAu6D261ecbxCH3GUUbSDXPPpKXTUXh/yiFBNnt3p8wgjB+SXdP1
         l8ymhjs3GGaUQZN1r2wTkSq5ZWXGvZoyeEgasmBsgnHJjYPrGfD/ro+xDtepYFwM69ke
         p6Iu3bN5ZM0T1tdnnrSvR34nvU8yqw49wVUYc7mPDawOkSDyAfFK+CkUZ23SWM5uuItN
         +8yWJti9N+VMg9Kp7f2fLT+2PdLE4vC+LVmM6GFUL1Ko4SwKlPejru7BwdBLYf/38k56
         PTM0mZ/kpnYeTHL7OmWzDcUCuGqW3CAZf41I7R1nLFv0a/M4AqTz6clGz5oReaUaD/l+
         85KQ==
X-Gm-Message-State: APjAAAXXiLFBhOJ+0YUtdZM994OZMyrKCwdnBx0n2wcrHMMlDDVrnVBB
        ib8uIfJLekLPXt5Ksq6ByKKwYJuAehJJXYma/xT8kGcvCSXBxy6zAxNF2h0GFeuAe6kb7hi1qAg
        vrjM7MFBfig7gXi+72rkfP8ZWeSk=
X-Received: by 2002:ac2:43a7:: with SMTP id t7mr2266112lfl.125.1576075958971;
        Wed, 11 Dec 2019 06:52:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqxsHzxnHw0oug+/0slqS1wiQrjQgbCPAPVzHqY6AOPXiTrPOE20TbfJ2hWJPiHd83JqF3DgSQ==
X-Received: by 2002:ac2:43a7:: with SMTP id t7mr2266098lfl.125.1576075958623;
        Wed, 11 Dec 2019 06:52:38 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id k24sm1524683ljj.27.2019.12.11.06.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 06:52:37 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D76761800E9; Wed, 11 Dec 2019 15:52:35 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH 1/2] mac80211: Turn AQL into an NL80211_EXT_FEATURE
Date:   Wed, 11 Dec 2019 15:52:29 +0100
Message-Id: <20191211145230.200132-2-toke@redhat.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211145230.200132-1-toke@redhat.com>
References: <20191211145230.200132-1-toke@redhat.com>
MIME-Version: 1.0
X-MC-Unique: mRVoOrV3P6qU1BTKgI7Wzg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Instead of just having an airtime flag in debugfs, turn AQL into a proper
NL80211_EXT_FEATURE, so drivers can turn it on when they are ready, and so
we also expose the presence of the feature to userspace.

This also has the effect of flipping the default, so drivers have to opt in
to using AQL instead of getting it by default with TXQs. A follow-up patch
sets the feature for ath10k.

While we're at it, split out the debugfs interface so AQL gets its own
per-station debugfs file instead of using the 'airtime' file.

Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
---
 include/uapi/linux/nl80211.h |  1 +
 net/mac80211/debugfs_sta.c   | 76 +++++++++++++++++++++++++++---------
 net/mac80211/main.c          |  4 +-
 net/mac80211/sta_info.c      |  3 ++
 net/mac80211/sta_info.h      |  1 -
 net/mac80211/tx.c            |  4 +-
 6 files changed, 65 insertions(+), 24 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 341e0e8cae46..1e6f435c709c 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -5563,6 +5563,7 @@ enum nl80211_ext_feature_index {
 =09NL80211_EXT_FEATURE_STA_TX_PWR,
 =09NL80211_EXT_FEATURE_SAE_OFFLOAD,
 =09NL80211_EXT_FEATURE_VLAN_OFFLOAD,
+=09NL80211_EXT_FEATURE_AQL,
=20
 =09/* add new features before the definition below */
 =09NUM_NL80211_EXT_FEATURES,
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index b3c9001d1f43..c80b1e163ea4 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -201,8 +201,6 @@ static ssize_t sta_airtime_read(struct file *file, char=
 __user *userbuf,
 =09char *buf =3D kzalloc(bufsz, GFP_KERNEL), *p =3D buf;
 =09u64 rx_airtime =3D 0, tx_airtime =3D 0;
 =09s64 deficit[IEEE80211_NUM_ACS];
-=09u32 q_depth[IEEE80211_NUM_ACS];
-=09u32 q_limit_l[IEEE80211_NUM_ACS], q_limit_h[IEEE80211_NUM_ACS];
 =09ssize_t rv;
 =09int ac;
=20
@@ -214,6 +212,56 @@ static ssize_t sta_airtime_read(struct file *file, cha=
r __user *userbuf,
 =09=09rx_airtime +=3D sta->airtime[ac].rx_airtime;
 =09=09tx_airtime +=3D sta->airtime[ac].tx_airtime;
 =09=09deficit[ac] =3D sta->airtime[ac].deficit;
+=09=09spin_unlock_bh(&local->active_txq_lock[ac]);
+=09}
+
+=09p +=3D scnprintf(p, bufsz + buf - p,
+=09=09"RX: %llu us\nTX: %llu us\nWeight: %u\n"
+=09=09"Deficit: VO: %lld us VI: %lld us BE: %lld us BK: %lld us\n",
+=09=09rx_airtime, tx_airtime, sta->airtime_weight,
+=09=09deficit[0], deficit[1], deficit[2], deficit[3]);
+
+=09rv =3D simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
+=09kfree(buf);
+=09return rv;
+}
+
+static ssize_t sta_airtime_write(struct file *file, const char __user *use=
rbuf,
+=09=09=09=09 size_t count, loff_t *ppos)
+{
+=09struct sta_info *sta =3D file->private_data;
+=09struct ieee80211_local *local =3D sta->sdata->local;
+=09int ac;
+
+=09for (ac =3D 0; ac < IEEE80211_NUM_ACS; ac++) {
+=09=09spin_lock_bh(&local->active_txq_lock[ac]);
+=09=09sta->airtime[ac].rx_airtime =3D 0;
+=09=09sta->airtime[ac].tx_airtime =3D 0;
+=09=09sta->airtime[ac].deficit =3D sta->airtime_weight;
+=09=09spin_unlock_bh(&local->active_txq_lock[ac]);
+=09}
+
+=09return count;
+}
+STA_OPS_RW(airtime);
+
+static ssize_t sta_aql_read(struct file *file, char __user *userbuf,
+=09=09=09=09size_t count, loff_t *ppos)
+{
+=09struct sta_info *sta =3D file->private_data;
+=09struct ieee80211_local *local =3D sta->sdata->local;
+=09size_t bufsz =3D 400;
+=09char *buf =3D kzalloc(bufsz, GFP_KERNEL), *p =3D buf;
+=09u32 q_depth[IEEE80211_NUM_ACS];
+=09u32 q_limit_l[IEEE80211_NUM_ACS], q_limit_h[IEEE80211_NUM_ACS];
+=09ssize_t rv;
+=09int ac;
+
+=09if (!buf)
+=09=09return -ENOMEM;
+
+=09for (ac =3D 0; ac < IEEE80211_NUM_ACS; ac++) {
+=09=09spin_lock_bh(&local->active_txq_lock[ac]);
 =09=09q_limit_l[ac] =3D sta->airtime[ac].aql_limit_low;
 =09=09q_limit_h[ac] =3D sta->airtime[ac].aql_limit_high;
 =09=09spin_unlock_bh(&local->active_txq_lock[ac]);
@@ -221,12 +269,8 @@ static ssize_t sta_airtime_read(struct file *file, cha=
r __user *userbuf,
 =09}
=20
 =09p +=3D scnprintf(p, bufsz + buf - p,
-=09=09"RX: %llu us\nTX: %llu us\nWeight: %u\n"
-=09=09"Deficit: VO: %lld us VI: %lld us BE: %lld us BK: %lld us\n"
 =09=09"Q depth: VO: %u us VI: %u us BE: %u us BK: %u us\n"
 =09=09"Q limit[low/high]: VO: %u/%u VI: %u/%u BE: %u/%u BK: %u/%u\n",
-=09=09rx_airtime, tx_airtime, sta->airtime_weight,
-=09=09deficit[0], deficit[1], deficit[2], deficit[3],
 =09=09q_depth[0], q_depth[1], q_depth[2], q_depth[3],
 =09=09q_limit_l[0], q_limit_h[0], q_limit_l[1], q_limit_h[1],
 =09=09q_limit_l[2], q_limit_h[2], q_limit_l[3], q_limit_h[3]),
@@ -236,11 +280,10 @@ static ssize_t sta_airtime_read(struct file *file, ch=
ar __user *userbuf,
 =09return rv;
 }
=20
-static ssize_t sta_airtime_write(struct file *file, const char __user *use=
rbuf,
+static ssize_t sta_aql_write(struct file *file, const char __user *userbuf=
,
 =09=09=09=09 size_t count, loff_t *ppos)
 {
 =09struct sta_info *sta =3D file->private_data;
-=09struct ieee80211_local *local =3D sta->sdata->local;
 =09u32 ac, q_limit_l, q_limit_h;
 =09char _buf[100] =3D {}, *buf =3D _buf;
=20
@@ -251,7 +294,7 @@ static ssize_t sta_airtime_write(struct file *file, con=
st char __user *userbuf,
 =09=09return -EFAULT;
=20
 =09buf[sizeof(_buf) - 1] =3D '\0';
-=09if (sscanf(buf, "queue limit %u %u %u", &ac, &q_limit_l, &q_limit_h)
+=09if (sscanf(buf, "limit %u %u %u", &ac, &q_limit_l, &q_limit_h)
 =09    !=3D 3)
 =09=09return -EINVAL;
=20
@@ -261,17 +304,10 @@ static ssize_t sta_airtime_write(struct file *file, c=
onst char __user *userbuf,
 =09sta->airtime[ac].aql_limit_low =3D q_limit_l;
 =09sta->airtime[ac].aql_limit_high =3D q_limit_h;
=20
-=09for (ac =3D 0; ac < IEEE80211_NUM_ACS; ac++) {
-=09=09spin_lock_bh(&local->active_txq_lock[ac]);
-=09=09sta->airtime[ac].rx_airtime =3D 0;
-=09=09sta->airtime[ac].tx_airtime =3D 0;
-=09=09sta->airtime[ac].deficit =3D sta->airtime_weight;
-=09=09spin_unlock_bh(&local->active_txq_lock[ac]);
-=09}
-
 =09return count;
 }
-STA_OPS_RW(airtime);
+STA_OPS_RW(aql);
+
=20
 static ssize_t sta_agg_status_read(struct file *file, char __user *userbuf=
,
 =09=09=09=09=09size_t count, loff_t *ppos)
@@ -996,6 +1032,10 @@ void ieee80211_sta_debugfs_add(struct sta_info *sta)
 =09=09=09=09    NL80211_EXT_FEATURE_AIRTIME_FAIRNESS))
 =09=09DEBUGFS_ADD(airtime);
=20
+=09if (wiphy_ext_feature_isset(local->hw.wiphy,
+=09=09=09=09    NL80211_EXT_FEATURE_AQL))
+=09=09DEBUGFS_ADD(aql);
+
 =09debugfs_create_xul("driver_buffered_tids", 0400, sta->debugfs_dir,
 =09=09=09   &sta->driver_buffered_tids);
=20
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 6cca0853f183..4c2b5ba3ac09 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -672,9 +672,7 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_=
data_len,
 =09=09=09IEEE80211_DEFAULT_AQL_TXQ_LIMIT_H;
 =09}
=20
-=09local->airtime_flags =3D AIRTIME_USE_TX |
-=09=09=09       AIRTIME_USE_RX |
-=09=09=09       AIRTIME_USE_AQL;
+=09local->airtime_flags =3D AIRTIME_USE_TX | AIRTIME_USE_RX;
 =09local->aql_threshold =3D IEEE80211_AQL_THRESHOLD;
 =09atomic_set(&local->aql_total_pending_airtime, 0);
=20
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 8eafd81e97b4..0f5f40678885 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1916,6 +1916,9 @@ void ieee80211_sta_update_pending_airtime(struct ieee=
80211_local *local,
 {
 =09int tx_pending;
=20
+=09if (!wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL))
+=09=09return;
+
 =09if (!tx_completed) {
 =09=09if (sta)
 =09=09=09atomic_add(tx_airtime,
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index ad5d8a4ae56d..c00e28585f9d 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -127,7 +127,6 @@ enum ieee80211_agg_stop_reason {
 /* Debugfs flags to enable/disable use of RX/TX airtime in scheduler */
 #define AIRTIME_USE_TX=09=09BIT(0)
 #define AIRTIME_USE_RX=09=09BIT(1)
-#define AIRTIME_USE_AQL=09=09BIT(2)
=20
 struct airtime_info {
 =09u64 rx_airtime;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index b696b9136f4c..259989a81108 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3668,7 +3668,7 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211=
_hw *hw,
=20
 =09IEEE80211_SKB_CB(skb)->control.vif =3D vif;
=20
-=09if (local->airtime_flags & AIRTIME_USE_AQL) {
+=09if (wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL)) =
{
 =09=09u32 airtime;
=20
 =09=09airtime =3D ieee80211_calc_expected_tx_airtime(hw, vif, txq->sta,
@@ -3790,7 +3790,7 @@ bool ieee80211_txq_airtime_check(struct ieee80211_hw =
*hw,
 =09struct sta_info *sta;
 =09struct ieee80211_local *local =3D hw_to_local(hw);
=20
-=09if (!(local->airtime_flags & AIRTIME_USE_AQL))
+=09if (!wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL))
 =09=09return true;
=20
 =09if (!txq->sta)
--=20
2.24.0

