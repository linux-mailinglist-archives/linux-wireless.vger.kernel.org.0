Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03D7FB793D
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2019 14:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390294AbfISMWy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Sep 2019 08:22:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60627 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390189AbfISMWy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Sep 2019 08:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568895773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ff9ylqKsll/m6vnHoApO6eRc/A7utDvshVP4ma2pnKU=;
        b=Ajs9ilOE8L6DPBCA5t/aJzUhuPLUbUDaclpZMd1F1WJEGJlP5d7Tu3KhIjCtcBLEDFNWSg
        bw9k9BuWpixME4jDx7sY1HYVuOfd6yHMS/7kUjcIFQOdTGPON/WQa1/TdueEHe2+LzXHKJ
        KqwXwiKRPf9gk+o6lsJKSk0TjEfakwA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-y7iWZFWjMVuporVpOIUXPA-1; Thu, 19 Sep 2019 08:22:52 -0400
Received: by mail-ed1-f70.google.com with SMTP id n14so1271590edt.3
        for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2019 05:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=eHyKNNOoJTEEPAtKDeF5btinM/54CahoHWM77ag+nRY=;
        b=Xry4I/oUrg4ZVDIsPHEQk7X/yU7muhgJhJZZwvytLkNerAEB7kQL6DxvpZw0lmKNpE
         WLjlsbSgV9lrGsAggiG5v8YKb8m6U8C/UKgC7DkPFErbZ81TFxtym3AIZsGBuqtHEWf1
         nd4xPYVUYteGNA/7Pu9+rr7VHJ9J5c0J+8cYZK7Wjb8HzN9g438TbH30c7qYzi0+P/vg
         tO9nhwi/ykNzYxcZy/vY64MLJjvxGFbRRullabuqv34b7DerQUpd/4XE3TwhoAHPeMNb
         sl+visD8O2m7FuKKcuOpRoBXPLJUoCOwxSbUnfWo7A2F14hZrCqrJHQcP4K/yv8sQARL
         Hezg==
X-Gm-Message-State: APjAAAUF1SpP7y+6sy+RoqeHns7o+8L7E84sQP1ZLUAIQS5GGIKvVM4I
        fLgJ9U279+twRK+SkZP+xcdzpyAhiF9SExGacyBWO5UhVl+HMjBZRjWTpO56LYHaRHNFLItpP3B
        BHXGBh6YF7s0I0X0ghfJc8nCoLJE=
X-Received: by 2002:a50:8b26:: with SMTP id l35mr15920931edl.244.1568895770508;
        Thu, 19 Sep 2019 05:22:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxpRDXS7YRcyFJE0zqCq6U/gxCU2Vj0UW0AMOYHXKIpUIVfIAAujHDKKgzl49Gu4sHOlYNaEg==
X-Received: by 2002:a50:8b26:: with SMTP id l35mr15920903edl.244.1568895770212;
        Thu, 19 Sep 2019 05:22:50 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id i63sm1614169edi.65.2019.09.19.05.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 05:22:49 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C473618063E; Thu, 19 Sep 2019 14:22:48 +0200 (CEST)
Subject: [PATCH RFC/RFT 4/4] mac80211: Apply Airtime-based Queue Limit (AQL)
 on packet dequeue
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Date:   Thu, 19 Sep 2019 14:22:48 +0200
Message-ID: <156889576869.191202.510507546538322707.stgit@alrua-x1>
In-Reply-To: <156889576422.191202.5906619710809654631.stgit@alrua-x1>
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
X-MC-Unique: y7iWZFWjMVuporVpOIUXPA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Some devices have deep buffers in firmware and/or hardware which prevents
the FQ structure in mac80211 from effectively limiting bufferbloat on the
link. For Ethernet devices we have BQL to limit the lower-level queues, but
this cannot be applied to mac80211 because transmit rates can vary wildly
between packets depending on which station we are transmitting it to.

To overcome this, we can use airtime-based queue limiting (AQL), where we
estimate the transmission time for each packet before dequeueing it, and
use that to limit the amount of data in-flight to the hardware. This idea
was originally implemented as part of the out-of-tree airtime fairness
patch to ath10k[0] in chromiumos.

This patch ports that idea over to mac80211. The basic idea is simple
enough: Whenever we dequeue a packet from the TXQs and send it to the
driver, we estimate its airtime usage, based on the last recorded TX rate
of the station that packet is destined for. We keep a running per-AC total
of airtime queued for the whole device, and when that total climbs above 8
ms' worth of data (corresponding to two maximum-sized aggregates), we
simply throttle the queues until it drops down again.

The estimated airtime for each skb is stored in the tx_info, so we can
subtract the same amount from the running total when the skb is freed or
recycled. The throttling mechanism relies on this accounting to be
accurate (i.e., that we are not freeing skbs without subtracting any
airtime they were accounted for), so we put the subtraction into
ieee80211_report_used_skb().

This patch does *not* include any mechanism to wake a throttled TXQ again,
on the assumption that this will happen anyway as a side effect of whatever
freed the skb (most commonly a TX completion).

The throttling mechanism only kicks in if the queued airtime total goes
above the limit. Since mac80211 calculates the time based on the reported
last_tx_time from the driver, the whole throttling mechanism only kicks in
for drivers that actually report this value. With the exception of
multicast, where we always calculate an estimated tx time on the assumption
that multicast is transmitted at the lowest (6 Mbps) rate.

The throttling added in this patch is in addition to any throttling already
performed by the airtime fairness mechanism, and in principle the two
mechanisms are orthogonal (and currently also uses two different sources of
airtime). In the future, we could amend this, using the airtime estimates
calculated by this mechanism as a fallback input to the airtime fairness
scheduler, to enable airtime fairness even on drivers that don't have a
hardware source of airtime usage for each station.

[0] https://chromium-review.googlesource.com/c/chromiumos/third_party/kerne=
l/+/588190/13/drivers/net/wireless-4.2/ath/ath10k/mac.c#3845

Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
---
 net/mac80211/debugfs.c     |   24 ++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h |    7 +++++++
 net/mac80211/status.c      |   22 ++++++++++++++++++++++
 net/mac80211/tx.c          |   38 +++++++++++++++++++++++++++++++++++++-
 4 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 568b3b276931..c846c6e7f3e3 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -148,6 +148,29 @@ static const struct file_operations aqm_ops =3D {
 =09.llseek =3D default_llseek,
 };
=20
+static ssize_t airtime_queued_read(struct file *file,
+=09=09=09=09   char __user *user_buf,
+=09=09=09=09   size_t count,
+=09=09=09=09   loff_t *ppos)
+{
+=09struct ieee80211_local *local =3D file->private_data;
+=09char buf[32 * IEEE80211_NUM_ACS], *p =3D buf;
+=09u8 ac;
+
+=09for (ac =3D 0; ac < IEEE80211_NUM_ACS; ac++)
+=09=09p +=3D scnprintf(p, sizeof(buf)+buf-p, "AC%u: %u\n", ac,
+=09=09=09       local->airtime_queued[ac]);
+
+=09return simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
+
+}
+
+static const struct file_operations airtime_queued_ops =3D {
+=09.read =3D airtime_queued_read,
+=09.open =3D simple_open,
+=09.llseek =3D default_llseek,
+};
+
 static ssize_t force_tx_status_read(struct file *file,
 =09=09=09=09    char __user *user_buf,
 =09=09=09=09    size_t count,
@@ -440,6 +463,7 @@ void debugfs_hw_add(struct ieee80211_local *local)
=20
 =09debugfs_create_u16("airtime_flags", 0600,
 =09=09=09   phyd, &local->airtime_flags);
+=09DEBUGFS_ADD(airtime_queued);
=20
 =09statsd =3D debugfs_create_dir("statistics", phyd);
=20
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 9de5390411ba..6bebfe80ed29 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -63,6 +63,12 @@ struct ieee80211_local;
 #define IEEE80211_RECIPROCAL_DIVISOR 0x100000000ULL
 #define IEEE80211_RECIPROCAL_SHIFT 32
=20
+/* constants used for airtime queue limit */
+#define IEEE80211_AIRTIME_QUEUE_LIMIT 8000 /* 8 ms */
+#define IEEE80211_AIRTIME_OVERHEAD 100
+#define IEEE80211_AIRTIME_OVERHEAD_IFS 16
+#define IEEE80211_AIRTIME_MINRATE_RECIPROCAL (IEEE80211_RECIPROCAL_DIVISOR=
 / 6000)
+
 /*
  * Some APs experience problems when working with U-APSD. Decreasing the
  * probability of that happening by using legacy mode for all ACs but VO i=
sn't
@@ -1144,6 +1150,7 @@ struct ieee80211_local {
 =09spinlock_t active_txq_lock[IEEE80211_NUM_ACS];
 =09struct list_head active_txqs[IEEE80211_NUM_ACS];
 =09u16 schedule_round[IEEE80211_NUM_ACS];
+=09u32 airtime_queued[IEEE80211_NUM_ACS];
=20
 =09u16 airtime_flags;
=20
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index ab8ba5835ca0..e63a70657050 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -711,6 +711,28 @@ static void ieee80211_report_used_skb(struct ieee80211=
_local *local,
 =09=09skb->wifi_acked =3D acked;
 =09}
=20
+=09if (info->control.tx_time_est) {
+=09=09u8 *qc, ac;
+=09=09int tid;
+
+=09=09if (ieee80211_is_data_qos(hdr->frame_control)) {
+=09=09=09qc =3D ieee80211_get_qos_ctl(hdr);
+=09=09=09tid =3D qc[0] & 0xf;
+=09=09=09ac =3D ieee80211_ac_from_tid(tid);
+=09=09} else {
+=09=09=09ac =3D IEEE80211_AC_BE;
+=09=09}
+
+=09=09spin_lock_bh(&local->active_txq_lock[ac]);
+=09=09/* sanity check to make sure we don't underflow */
+=09=09if (WARN_ON_ONCE(info->control.tx_time_est > local->airtime_queued[a=
c]))
+=09=09=09local->airtime_queued[ac] =3D 0;
+=09=09else
+=09=09=09local->airtime_queued[ac] -=3D info->control.tx_time_est;
+=09=09spin_unlock_bh(&local->active_txq_lock[ac]);
+
+=09}
+
 =09ieee80211_led_tx(local);
=20
 =09if (skb_has_frag_list(skb)) {
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 1fa422782905..2b8564621ecf 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3546,9 +3546,19 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee8021=
1_hw *hw,
 =09struct ieee80211_tx_data tx;
 =09ieee80211_tx_result r;
 =09struct ieee80211_vif *vif =3D txq->vif;
+=09u32 airtime =3D 0, airtime_queued;
+=09u8 ac =3D txq->ac;
+=09u32 pktlen;
=20
 =09WARN_ON_ONCE(softirq_count() =3D=3D 0);
=20
+=09spin_lock_bh(&local->active_txq_lock[ac]);
+=09airtime_queued =3D local->airtime_queued[ac];
+=09spin_unlock_bh(&local->active_txq_lock[ac]);
+
+=09if (airtime_queued > IEEE80211_AIRTIME_QUEUE_LIMIT)
+=09=09return NULL;
+
 begin:
 =09spin_lock_bh(&fq->lock);
=20
@@ -3581,8 +3591,19 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee8021=
1_hw *hw,
 =09tx.skb =3D skb;
 =09tx.sdata =3D vif_to_sdata(info->control.vif);
=20
-=09if (txq->sta)
+=09pktlen =3D skb->len + 38;
+=09if (txq->sta) {
 =09=09tx.sta =3D container_of(txq->sta, struct sta_info, sta);
+=09=09if (tx.sta->last_tx_bitrate) {
+=09=09=09airtime =3D (pktlen * 8 * 1000 *
+=09=09=09=09   tx.sta->last_tx_bitrate_reciprocal) >> IEEE80211_RECIPROCAL=
_SHIFT;
+=09=09=09airtime +=3D IEEE80211_AIRTIME_OVERHEAD;
+=09=09}
+=09} else {
+=09=09airtime =3D (pktlen * 8 * 1000 *
+=09=09=09   IEEE80211_AIRTIME_MINRATE_RECIPROCAL) >> IEEE80211_RECIPROCAL_=
SHIFT;
+=09=09airtime +=3D IEEE80211_AIRTIME_OVERHEAD;
+=09}
=20
 =09/*
 =09 * The key can be removed while the packet was queued, so need to call
@@ -3659,6 +3680,15 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee8021=
1_hw *hw,
 =09}
=20
 =09IEEE80211_SKB_CB(skb)->control.vif =3D vif;
+
+=09if (airtime) {
+=09=09info->control.tx_time_est =3D airtime;
+
+=09=09spin_lock_bh(&local->active_txq_lock[ac]);
+=09=09local->airtime_queued[ac] +=3D airtime;
+=09=09spin_unlock_bh(&local->active_txq_lock[ac]);
+=09}
+
 =09return skb;
=20
 out:
@@ -3676,6 +3706,9 @@ struct ieee80211_txq *ieee80211_next_txq(struct ieee8=
0211_hw *hw, u8 ac)
=20
 =09spin_lock_bh(&local->active_txq_lock[ac]);
=20
+=09if (local->airtime_queued[ac] > IEEE80211_AIRTIME_QUEUE_LIMIT)
+=09=09goto out;
+
  begin:
 =09txqi =3D list_first_entry_or_null(&local->active_txqs[ac],
 =09=09=09=09=09struct txq_info,
@@ -3753,6 +3786,9 @@ bool ieee80211_txq_may_transmit(struct ieee80211_hw *=
hw,
=20
 =09spin_lock_bh(&local->active_txq_lock[ac]);
=20
+=09if (local->airtime_queued[ac] > IEEE80211_AIRTIME_QUEUE_LIMIT)
+=09=09goto out;
+
 =09if (!txqi->txq.sta)
 =09=09goto out;
=20

