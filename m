Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97D95E172D
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2019 11:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391005AbfJWJ7M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Oct 2019 05:59:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31519 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390880AbfJWJ7L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Oct 2019 05:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571824750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GTow40ZP9yz6FXo2iHRwENO6p5Rsw+2IYHRwXehWjq0=;
        b=iky8VlnrHXcCzAssyyMbZRDuIfLzEcixJVz5rKbr69SlGJwIPKFdtYrZywFULjjNKhW9iS
        H1axzjlyI+mW6BZRyJHgweQwxUNxWDr/KS11gkcxQfJdTCiHf28s5rIayC65wbuPTTtktI
        GFUK4r2vq6JlcryxDwnsFzRxg/P3kFo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-yzVaTSESPYGyLhFzo8CDpA-1; Wed, 23 Oct 2019 05:59:08 -0400
Received: by mail-lf1-f72.google.com with SMTP id q3so4013554lfo.8
        for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2019 02:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=TN/1EpNSFW/3lqrfhiPq8uNXDI9NIMY8XSXJK7178so=;
        b=Hw8IFpgv3ZxIQeSKj9q5RiBNzt/c0+p7IRpe1o5EU/OD1QcCpy3bQFVz+bae1WjZpY
         aAgi9I4ijgGfFhXYJLAGnJmgs0IzECAvZmP1LMnBgPiSC9rmDjL4ttKPud0/sKrfx5te
         8Enr+gUOd19+KmZD7xQ9sWvk2ifRCRHLcBVGBANFp9+z3duxoa/l+0ABTip3i1HoOGNI
         BPuEqD4fDOSXuHjBaaGnhQYhnYiO1wdFCskU2ktMBvoiX/SzjV/5FT9Uka7QKmGextgP
         8hIedDGnve7mI4RE9Dvm1LoqXN11LNhBlFGYTVjHjgiOvLefVhAPutQmX69CImR+vwAc
         zQbA==
X-Gm-Message-State: APjAAAUuOovSEbE5I2Wp4lvLzzvaLC8GW5Lw2zG6x9F52Rsd9mIXJjiR
        kDIjOBQ2zoFjhy2pFbn9JPR2RHhhT3vL/IF4U3CpLOAa+ALMuYHb1nGGiPO7UZCFDgypXFGnmVC
        pfiCVLGcS7IludxMMt/be+vZjlpg=
X-Received: by 2002:a2e:8945:: with SMTP id b5mr17616954ljk.215.1571824747380;
        Wed, 23 Oct 2019 02:59:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzU+ZsbP9zZk9TC85BqMliMk8bChnVx6dBasLapL/WDjofhIKojGZXvSqiLPbiNqjPvL3/EHA==
X-Received: by 2002:a2e:8945:: with SMTP id b5mr17616936ljk.215.1571824747132;
        Wed, 23 Oct 2019 02:59:07 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id q16sm9186572lfb.74.2019.10.23.02.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 02:59:04 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1B4151804B6; Wed, 23 Oct 2019 11:59:04 +0200 (CEST)
Subject: [PATCH v6 4/4] mac80211: Use Airtime-based Queue Limits (AQL) on
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
Date:   Wed, 23 Oct 2019 11:59:04 +0200
Message-ID: <157182474399.150713.16380222749144410045.stgit@toke.dk>
In-Reply-To: <157182473951.150713.7978051149956899705.stgit@toke.dk>
References: <157182473951.150713.7978051149956899705.stgit@toke.dk>
User-Agent: StGit/0.20
MIME-Version: 1.0
X-MC-Unique: yzVaTSESPYGyLhFzo8CDpA-1
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
 net/mac80211/status.c |   33 +++++++++++++++++++++++++++++++++
 net/mac80211/tx.c     |   21 +++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index ab8ba5835ca0..ae15c8fd2421 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -676,6 +676,28 @@ static void ieee80211_report_used_skb(struct ieee80211=
_local *local,
 =09if (dropped)
 =09=09acked =3D false;
=20
+=09if (info->tx_time_est) {
+=09=09struct sta_info *sta =3D NULL, *s;
+=09=09struct rhlist_head *tmp;
+
+=09=09rcu_read_lock();
+
+=09=09for_each_sta_info(local, hdr->addr1, s, tmp) {
+=09=09=09/* skip wrong virtual interface */
+=09=09=09if (!ether_addr_equal(hdr->addr2, s->sdata->vif.addr))
+=09=09=09=09continue;
+
+=09=09=09sta =3D s;
+=09=09=09break;
+=09=09}
+
+=09=09ieee80211_sta_update_pending_airtime(local, sta,
+=09=09=09=09=09=09     skb_get_queue_mapping(skb),
+=09=09=09=09=09=09     info->tx_time_est << 2,
+=09=09=09=09=09=09     true);
+=09=09rcu_read_unlock();
+=09}
+
 =09if (info->flags & IEEE80211_TX_INTFL_MLME_CONN_TX) {
 =09=09struct ieee80211_sub_if_data *sdata;
=20
@@ -986,6 +1008,17 @@ static void __ieee80211_tx_status(struct ieee80211_hw=
 *hw,
 =09=09=09ieee80211_sta_register_airtime(&sta->sta, tid,
 =09=09=09=09=09=09       info->status.tx_time, 0);
=20
+=09=09if (info->tx_time_est) {
+=09=09=09/* Do this here to avoid the expensive lookup of the sta
+=09=09=09 * in ieee80211_report_used_skb().
+=09=09=09 */
+=09=09=09ieee80211_sta_update_pending_airtime(local, sta,
+=09=09=09=09=09=09=09     skb_get_queue_mapping(skb),
+=09=09=09=09=09=09=09     info->tx_time_est << 2,
+=09=09=09=09=09=09=09     true);
+=09=09=09info->tx_time_est =3D 0;
+=09=09}
+
 =09=09if (ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS)) {
 =09=09=09if (info->flags & IEEE80211_TX_STAT_ACK) {
 =09=09=09=09if (sta->status_stats.lost_packets)
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 12653d873b8c..1405304d8994 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3542,6 +3542,9 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211=
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
@@ -3652,6 +3655,24 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee8021=
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
+=09=09=09/* We only have 10 bits in tx_time_est, so store airtime
+=09=09=09 * in increments of 4us and clamp the maximum to 2**12-1
+=09=09=09 */
+=09=09=09airtime =3D min_t(u32, airtime, 4095) & ~3U;
+=09=09=09info->tx_time_est =3D airtime >> 2;
+=09=09=09ieee80211_sta_update_pending_airtime(local, tx.sta,
+=09=09=09=09=09=09=09     txq->ac, airtime,
+=09=09=09=09=09=09=09     false);
+=09=09}
+=09}
+
 =09return skb;
=20
 out:

