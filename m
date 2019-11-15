Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 911ADFDECC
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 14:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfKONUs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 08:20:48 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24796 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727249AbfKONUr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 08:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573824046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tdsrz9D3CpYBJ3D65WUQEqmo4OseVJ6gea3+ET3/bnE=;
        b=A6bWGuYp2MjUBGxY2/u99xN4a8WtqU4AjYhXOuCA06TfnDyXsZZWbis0casoeVQvJsdIvE
        /wYsPvy4pDejlKOGgXOeVG0wP1B0iW28JvC6dTbrJ0SXXUCWHZVSvDwssSlQlXCB3xVCD3
        e29WXLuneuwmvxZAdmx/6Z8WZfbYTgg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-RjmUtERYMQ6F6nIakTkaDw-1; Fri, 15 Nov 2019 08:20:44 -0500
Received: by mail-lf1-f69.google.com with SMTP id o140so3047374lff.18
        for <linux-wireless@vger.kernel.org>; Fri, 15 Nov 2019 05:20:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=UC+Qp/M8adlsNV+L+Mh9cE9OWCu984WKU+u9MJeIKPs=;
        b=T8UxtV4RNJCJ35KThP37e2vjrHHL1bS3Esa2eSGf+/dRxsME3mSoEmDcH+mkW9sGB9
         oeWAlDYBz+YQPL+NIh+rz6wKbvk3nxMeMVwm/0+Om3OFRuKxVtFBt1bBXgGh5wRjOqJH
         zz8mQYZRQVis9QncJbZH7Urd4IeJ5s00E7yfp0JwROgL90VXjRMcFEn8Lj+cFcmy8ueK
         H3qNvQ5x1aqNypn/AhNBkU6iotfmcsGlhdyKZLSGRQ6KBBoE5RcNICBHyHYasiFm4F9T
         s667WeX1OznVqXsaVGW+BPI9KzAeAXNrR0s939fmVbB2AvuktRztlwY+cvZWNnGTE68r
         iJ+g==
X-Gm-Message-State: APjAAAUZvZoFQshD3NMv50f+s1kKK7mu4Z6TWFxCrT91VxIRd9257P+q
        fi4FX2+PijpSpFkG+8zZa6p8Sd+aU8K43Q3k5R/1asdaI7K3XbolAhV59pQnjjln/6oxh09Ck/R
        iH40BPkPh9tFcE8/++hWdu/qlwtc=
X-Received: by 2002:a2e:91c7:: with SMTP id u7mr10160040ljg.249.1573824043580;
        Fri, 15 Nov 2019 05:20:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqwoT+N4Jpl3EBOXBrqWN5qrY7NMpS0F7gLd/X57y2lLpjiMBViOqUNkJmNSLYkmmgI/huxcFA==
X-Received: by 2002:a2e:91c7:: with SMTP id u7mr10160022ljg.249.1573824043332;
        Fri, 15 Nov 2019 05:20:43 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id c24sm4343537lfm.20.2019.11.15.05.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 05:20:42 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 49A621818C5; Fri, 15 Nov 2019 14:20:41 +0100 (CET)
Subject: [PATCH v9 4/4] mac80211: Use Airtime-based Queue Limits (AQL) on
 packet dequeue
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Kan Yan <kyan@google.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Date:   Fri, 15 Nov 2019 14:20:41 +0100
Message-ID: <157382404118.580235.14216392299709793599.stgit@toke.dk>
In-Reply-To: <157382403672.580235.12525941420808058808.stgit@toke.dk>
References: <157382403672.580235.12525941420808058808.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-MC-Unique: RjmUtERYMQ6F6nIakTkaDw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

The previous commit added the ability to throttle stations when they queue
too much airtime in the hardware. This commit enables the functionality by
calculating the expected airtime usage of each packet that is dequeued from
the TXQs in mac80211, and accounting that as pending airtime.

The estimated airtime for each skb is stored in the tx_info, so we can
subtract the same amount from the running total when the skb is freed or
recycled. The throttling mechanism relies on this accounting to be
accurate (i.e., that we are not freeing skbs without subtracting any
airtime they were accounted for), so we put the subtraction into
ieee80211_report_used_skb(). As an optimisation, we also subtract the
airtime on regular TX completion, zeroing out the value stored in the
packet afterwards, to avoid having to do an expensive lookup of the station
from the packet data on every packet.

This patch does *not* include any mechanism to wake a throttled TXQ again,
on the assumption that this will happen anyway as a side effect of whatever
freed the skb (most commonly a TX completion).

Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
---
 include/net/mac80211.h |   16 ++++++++++++++++
 net/mac80211/status.c  |   26 ++++++++++++++++++++++++++
 net/mac80211/tx.c      |   18 ++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index ba3f33cc41ea..dcb4a1f19829 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1060,6 +1060,22 @@ struct ieee80211_tx_info {
 =09};
 };
=20
+static inline u16
+ieee80211_info_set_tx_time_est(struct ieee80211_tx_info *info, u16 tx_time=
_est)
+{
+=09/* We only have 10 bits in tx_time_est, so store airtime
+=09 * in increments of 4us and clamp the maximum to 2**12-1
+=09 */
+=09info->tx_time_est =3D min_t(u16, tx_time_est, 4095) >> 2;
+=09return info->tx_time_est;
+}
+
+static inline u16
+ieee80211_info_get_tx_time_est(struct ieee80211_tx_info *info)
+{
+=09return info->tx_time_est << 2;
+}
+
 /**
  * struct ieee80211_tx_status - extended tx status info for rate control
  *
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 0e51def35b8a..39da82b35be9 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -670,12 +670,26 @@ static void ieee80211_report_used_skb(struct ieee8021=
1_local *local,
 =09=09=09=09      struct sk_buff *skb, bool dropped)
 {
 =09struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(skb);
+=09u16 tx_time_est =3D ieee80211_info_get_tx_time_est(info);
 =09struct ieee80211_hdr *hdr =3D (void *)skb->data;
 =09bool acked =3D info->flags & IEEE80211_TX_STAT_ACK;
=20
 =09if (dropped)
 =09=09acked =3D false;
=20
+=09if (tx_time_est) {
+=09=09struct sta_info *sta;
+
+=09=09rcu_read_lock();
+
+=09=09sta =3D sta_info_get_by_addrs(local, hdr->addr1, hdr->addr2);
+=09=09ieee80211_sta_update_pending_airtime(local, sta,
+=09=09=09=09=09=09     skb_get_queue_mapping(skb),
+=09=09=09=09=09=09     tx_time_est,
+=09=09=09=09=09=09     true);
+=09=09rcu_read_unlock();
+=09}
+
 =09if (info->flags & IEEE80211_TX_INTFL_MLME_CONN_TX) {
 =09=09struct ieee80211_sub_if_data *sdata;
=20
@@ -877,6 +891,7 @@ static void __ieee80211_tx_status(struct ieee80211_hw *=
hw,
 =09struct ieee80211_bar *bar;
 =09int shift =3D 0;
 =09int tid =3D IEEE80211_NUM_TIDS;
+=09u16 tx_time_est;
=20
 =09rates_idx =3D ieee80211_tx_get_rates(hw, info, &retry_count);
=20
@@ -986,6 +1001,17 @@ static void __ieee80211_tx_status(struct ieee80211_hw=
 *hw,
 =09=09=09ieee80211_sta_register_airtime(&sta->sta, tid,
 =09=09=09=09=09=09       info->status.tx_time, 0);
=20
+=09=09if ((tx_time_est =3D ieee80211_info_get_tx_time_est(info)) > 0) {
+=09=09=09/* Do this here to avoid the expensive lookup of the sta
+=09=09=09 * in ieee80211_report_used_skb().
+=09=09=09 */
+=09=09=09ieee80211_sta_update_pending_airtime(local, sta,
+=09=09=09=09=09=09=09     skb_get_queue_mapping(skb),
+=09=09=09=09=09=09=09     tx_time_est,
+=09=09=09=09=09=09=09     true);
+=09=09=09ieee80211_info_set_tx_time_est(info, 0);
+=09=09}
+
 =09=09if (ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS)) {
 =09=09=09if (info->flags & IEEE80211_TX_STAT_ACK) {
 =09=09=09=09if (sta->status_stats.lost_packets)
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index aafc67b562eb..2fb6571453e7 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3551,6 +3551,9 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211=
_hw *hw,
=20
 =09WARN_ON_ONCE(softirq_count() =3D=3D 0);
=20
+=09if (!ieee80211_txq_airtime_check(hw, txq))
+=09=09return NULL;
+
 begin:
 =09spin_lock_bh(&fq->lock);
=20
@@ -3661,6 +3664,21 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee8021=
1_hw *hw,
 =09}
=20
 =09IEEE80211_SKB_CB(skb)->control.vif =3D vif;
+
+=09if (local->airtime_flags & AIRTIME_USE_AQL) {
+=09=09u32 airtime;
+
+=09=09airtime =3D ieee80211_calc_expected_tx_airtime(hw, vif, txq->sta,
+=09=09=09=09=09=09=09     skb->len);
+=09=09if (airtime) {
+=09=09=09airtime =3D ieee80211_info_set_tx_time_est(info, airtime);
+=09=09=09ieee80211_sta_update_pending_airtime(local, tx.sta,
+=09=09=09=09=09=09=09     txq->ac,
+=09=09=09=09=09=09=09     airtime,
+=09=09=09=09=09=09=09     false);
+=09=09}
+=09}
+
 =09return skb;
=20
 out:

