Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24C7EE0509
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2019 15:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388743AbfJVNaZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Oct 2019 09:30:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27618 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388644AbfJVNaY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Oct 2019 09:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571751023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bfi5GeAeASQB1mQGyA998jFPTSgjtLqljftKsgNmsmA=;
        b=DI7ps11Enh2W7MeCSvnmlvylZNBG4P3MjQdX95HB4mESvxizzOD/Kp4d148C3dD3zK/ajs
        ZjZjbIADucGEtEjQ14DmIlD34nK9dZ+TxqoUqvu/nlXh3xa5Dip5TIKUjT0MijMOnbHY7N
        0jkIbLbfG5WmtPmEbTh+jlj80Ec34zw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-l8xpBakmOXm6aEHrglQvPA-1; Tue, 22 Oct 2019 09:30:22 -0400
Received: by mail-wr1-f72.google.com with SMTP id f4so9159848wrj.12
        for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2019 06:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=F3IUzbWrPuZHLVvq2XMf85ecX3kHWPzPpSEeKPTtYeU=;
        b=g8dlajvMHiT/IFcKD44elrhiFQz9OUdk8rOOHrKXc1FZ02nd+XCEahTPVT2PfhNWhK
         ZUPacb/zOreoWpGHJNhnq/rgmpIb10QgD3Bc/3RIvt5Ol7ku12k2kKxMmAdrFLE23uQ+
         bEd6Fb9YJqh4/UILtrWorw8dX2xQ4ydkmJURN5WSmtebj53a/4Cat5xp0hWdyJnPPPYK
         ckkUa1btolJA4zpe3AqTiYkO4qUXKq9c7exhbX01NkZKc0mBAczR/OdcMuoqrE5l5Xxm
         uKVgy8v8VLjzXaowCdmPP4JZUOqEmw8n8sC2cNjWPc4pAbCVJkjrZGsSe9M1TDIa9g6p
         ktyw==
X-Gm-Message-State: APjAAAVvzQPKfhkZuVSwpqJ4FQkTwHN+6Jp2ePoB48KVTtAIjolVC+yI
        1Ky2sL9fPykwB2znMtR6vVN414rze2CZTv3iZJrmZiFJ1ZzncBAckbpZa1HhwSoUIJnI5wBeCFj
        R7CTpZDmALGx1U/fETsl8bO6NhN4=
X-Received: by 2002:a1c:7219:: with SMTP id n25mr2894084wmc.23.1571751021130;
        Tue, 22 Oct 2019 06:30:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqziX4ekm8/1EpyD3Im3QUBAKWW7u9wMWWw/uuSmmFI0HTkPrNzx3so3jUSjzVYxgaQs9oaw8Q==
X-Received: by 2002:a1c:7219:: with SMTP id n25mr2894066wmc.23.1571751020898;
        Tue, 22 Oct 2019 06:30:20 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id a17sm13394388wmb.8.2019.10.22.06.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 06:30:20 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9D5FF1804B6; Tue, 22 Oct 2019 15:30:19 +0200 (CEST)
Subject: [PATCH v5 4/4] mac80211: Use Airtime-based Queue Limits (AQL) on
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
Date:   Tue, 22 Oct 2019 15:30:19 +0200
Message-ID: <157175101956.104114.5352455639882457638.stgit@toke.dk>
In-Reply-To: <157175101518.104114.6722791270722911023.stgit@toke.dk>
References: <157175101518.104114.6722791270722911023.stgit@toke.dk>
User-Agent: StGit/0.20
MIME-Version: 1.0
X-MC-Unique: l8xpBakmOXm6aEHrglQvPA-1
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
 net/mac80211/status.c |   28 ++++++++++++++++++++++++++++
 net/mac80211/tx.c     |   21 +++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index ab8ba5835ca0..f125984d5beb 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -676,6 +676,23 @@ static void ieee80211_report_used_skb(struct ieee80211=
_local *local,
 =09if (dropped)
 =09=09acked =3D false;
=20
+=09if (info->tx_time_est) {
+=09=09struct ieee80211_sub_if_data *sdata;
+=09=09struct sta_info *sta =3D NULL;
+
+=09=09rcu_read_lock();
+
+=09=09sdata =3D ieee80211_sdata_from_skb(local, skb);
+=09=09if (sdata)
+=09=09=09sta =3D sta_info_get_bss(sdata, skb_mac_header(skb));
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
@@ -930,6 +947,17 @@ static void __ieee80211_tx_status(struct ieee80211_hw =
*hw,
 =09=09=09tid =3D qc[0] & 0xf;
 =09=09}
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
 =09=09if (!acked && ieee80211_is_back_req(fc)) {
 =09=09=09u16 control;
=20
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

