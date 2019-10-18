Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49441DC796
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2019 16:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634130AbfJROkc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Oct 2019 10:40:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26970 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2410018AbfJROkc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Oct 2019 10:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571409630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lqBYAyfvGqVBfvQQyb/0J8hd/48vyEbBcTT/es8g2a8=;
        b=jFSOqBdeeUyrapoZYGsbTVp11SJVvfBO8VNUYHi0z8AsGXOH6lnHRVag7veTte8IuRFhj2
        sTTkySeSGH/174pwPIGqHmAjI9HNO01V5xEZzC906uQ05lbQaR8ZooZUxZPahCTRpnDjxc
        05o3KNOMz790eJ21+KUQpHRKQrW1PCI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-FShSDlISMPm3bVlutHFqSA-1; Fri, 18 Oct 2019 10:40:28 -0400
Received: by mail-lf1-f72.google.com with SMTP id c7so1327757lfh.9
        for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2019 07:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=B/zTxrtPVbDPMk1jNIRjvApKrsIv0Uj3+z7s63i2jdw=;
        b=cWddvK9qx15r/f/3sliMVEOkgOQsP3kD6xxaakHm0hasy6B8/wAfRA3OKCwsOiOI8Y
         0mcX70btzMTZSaP2VHXZvQj8OontRbjO2LKxlI+pXb2i/fNphfm/E2XhEBIu6ktBxMVT
         zkh/L6K0SmqGrzNiL332Q7BOGNQSnEBS1GgmJJH6zs9U67WXBt6N5cjnrvldwwQxzpuo
         6/IpOjHIubXMEZnf/1ukrrelI+IRzAy25LPlJMk4mVTuE92nBuu6ap6+bwC8CukRzgQV
         1yJsEjascZt1nRM31p6WodH9rvm1NJf4X9FHx1+xc5Tyc5FYUE9h6Iah8m8XjTJnzsvf
         MkDA==
X-Gm-Message-State: APjAAAXeYDCY8mzCNeAALkUovI0eBIM7GlHEuT1CuhUJUfcQPOX6HByg
        mj0pMqLRAEVZnS4nCdMFdGqY3MF6oZLCeYNQVR8VnFgecQSDQIWU3Q3GQcSuB3uJ/xUSMhAkS3e
        IdYyB+7hk+WlW2J9xnAWQUqgWg/Y=
X-Received: by 2002:a2e:5dd5:: with SMTP id v82mr6545681lje.54.1571409627129;
        Fri, 18 Oct 2019 07:40:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxolQE2snCfRFv7NPp6VkDcPkPnM67ptbRrwbO/RDkqMvooRv8yklzlnAGDuCtp1Rd02Oj9BA==
X-Received: by 2002:a2e:5dd5:: with SMTP id v82mr6545664lje.54.1571409626863;
        Fri, 18 Oct 2019 07:40:26 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id d25sm2572501lfj.15.2019.10.18.07.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 07:40:26 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 6A8AC1804B6; Fri, 18 Oct 2019 16:40:25 +0200 (CEST)
Subject: [PATCH v3 4/4] mac80211: Use Airtime-based Queue Limits (AQL) on
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
Date:   Fri, 18 Oct 2019 16:40:25 +0200
Message-ID: <157140962534.2866668.1182822483250825739.stgit@toke.dk>
In-Reply-To: <157140962094.2866668.3383184317264069493.stgit@toke.dk>
References: <157140962094.2866668.3383184317264069493.stgit@toke.dk>
User-Agent: StGit/0.20
MIME-Version: 1.0
X-MC-Unique: FShSDlISMPm3bVlutHFqSA-1
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
packet afterwards, to avoid having to do an expensive lookup of the
station from the packet data on every packet.

This patch does *not* include any mechanism to wake a throttled TXQ again,
on the assumption that this will happen anyway as a side effect of whatever
freed the skb (most commonly a TX completion).

Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
---
 net/mac80211/status.c |   38 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/tx.c     |   19 +++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index ab8ba5835ca0..905b4afd457d 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -676,6 +676,33 @@ static void ieee80211_report_used_skb(struct ieee80211=
_local *local,
 =09if (dropped)
 =09=09acked =3D false;
=20
+=09if (info->tx_time_est) {
+=09=09struct ieee80211_sub_if_data *sdata;
+=09=09struct sta_info *sta =3D NULL;
+=09=09u8 *qc, ac;
+=09=09int tid;
+
+=09=09rcu_read_lock();
+
+=09=09sdata =3D ieee80211_sdata_from_skb(local, skb);
+=09=09if (sdata)
+=09=09=09sta =3D sta_info_get_bss(sdata, skb_mac_header(skb));
+
+=09=09if (ieee80211_is_data_qos(hdr->frame_control)) {
+=09=09=09qc =3D ieee80211_get_qos_ctl(hdr);
+=09=09=09tid =3D qc[0] & 0xf;
+=09=09=09ac =3D ieee80211_ac_from_tid(tid);
+=09=09} else {
+=09=09=09ac =3D IEEE80211_AC_BE;
+=09=09}
+
+=09=09ieee80211_sta_update_pending_airtime(local, sta, ac,
+=09=09=09=09=09=09     info->tx_time_est << 2,
+=09=09=09=09=09=09     true);
+=09=09rcu_read_unlock();
+
+=09}
+
 =09if (info->flags & IEEE80211_TX_INTFL_MLME_CONN_TX) {
 =09=09struct ieee80211_sub_if_data *sdata;
=20
@@ -930,6 +957,17 @@ static void __ieee80211_tx_status(struct ieee80211_hw =
*hw,
 =09=09=09tid =3D qc[0] & 0xf;
 =09=09}
=20
+=09=09if (info->tx_time_est) {
+=09=09=09/* Do this here to avoid the expensive lookup of the sta
+=09=09=09 * in ieee80211_report_used_skb().
+=09=09=09 */
+=09=09=09ieee80211_sta_update_pending_airtime(local, sta,
+=09=09=09=09=09=09=09     ieee80211_ac_from_tid(tid),
+=09=09=09=09=09=09=09     info->tx_time_est << 2,
+=09=09=09=09=09=09=09     true);
+=09=09=09info->tx_time_est =3D 0;
+=09=09}
+
 =09=09if (!acked && ieee80211_is_back_req(fc)) {
 =09=09=09u16 control;
=20
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 12653d873b8c..bd8284f04361 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3539,9 +3539,14 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee8021=
1_hw *hw,
 =09struct ieee80211_tx_data tx;
 =09ieee80211_tx_result r;
 =09struct ieee80211_vif *vif =3D txq->vif;
+=09u8 ac =3D txq->ac;
+=09u32 airtime;
=20
 =09WARN_ON_ONCE(softirq_count() =3D=3D 0);
=20
+=09if (!ieee80211_txq_airtime_check(hw, txq))
+=09=09return NULL;
+
 begin:
 =09spin_lock_bh(&fq->lock);
=20
@@ -3652,6 +3657,20 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee8021=
1_hw *hw,
 =09}
=20
 =09IEEE80211_SKB_CB(skb)->control.vif =3D vif;
+
+=09if (local->airtime_flags & AIRTIME_USE_AQL) {
+=09=09airtime =3D ieee80211_calc_expected_tx_airtime(hw, vif, txq->sta,
+=09=09=09=09=09=09=09     skb->len);
+=09=09if (airtime) {
+=09=09=09/* We only have 10 bits in tx_time_est, so store airtime
+=09=09=09 * in increments of 4 us and clamp that to 2**10.
+=09=09=09 */
+=09=09=09info->tx_time_est =3D min_t(u32, airtime >> 2, 1 << 10);
+=09=09=09ieee80211_sta_update_pending_airtime(local, tx.sta, ac,
+=09=09=09=09=09=09=09     airtime, false);
+=09=09}
+=09}
+
 =09return skb;
=20
 out:

