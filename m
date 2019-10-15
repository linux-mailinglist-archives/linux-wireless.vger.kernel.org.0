Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C559D7D47
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2019 19:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbfJORTJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Oct 2019 13:19:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56694 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730579AbfJORTI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Oct 2019 13:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571159947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GyvbrDu8qEmiyON3oCp/2+bOvx6xuJkqb2dCqG+bTwY=;
        b=OLYFNKrd+y1DoVjsXyeK4O1rxkkNiGXWoDOsvDuT3zxblaGxW3dad9ECDFFryVbemCAL4N
        35B23nliB2jQUkAxcBKBnFUxu7Oq4Ys5awnyZYge1RK4VS5+12pqpGI8QOp+bnrG50maBH
        ioiPA6cZ4Sh4+ITH0E/uXbjE1nwfc4E=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-zgcfJpMMOBKvoISG6ZCRDQ-1; Tue, 15 Oct 2019 13:19:05 -0400
Received: by mail-lf1-f70.google.com with SMTP id m17so3926219lfl.11
        for <linux-wireless@vger.kernel.org>; Tue, 15 Oct 2019 10:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=mshGTrJaOuTUiekVjuspbBrpGAw6s+TpOZLBOSqMh18=;
        b=JPM9+oiTILupgolDTp4bFkGF/w7bM6/Bmsf0lkVAI6g8u7dzHM2BRxqyTyTwgkJqsD
         k1VZoX4SGrJCqjYVwcZT9yIQqkUCvirNU9PRjoOFhUJnOKNm4ggdtzwbfVtuiuiPpTXp
         kLONuDuDZi0rHHCLR9p+EJOrwKsl3vgVMyLeHi6fprlo3tvuyW687e30A3WRyBx7xr4h
         1ebrli1K5ISXiiJ7UgVgacFBxgmcAkPL7YsPIDpk6rOz3PD5S8J+rLvMWcOZTmaqzLL5
         0pswRMh0+U2O5haTi9At/JWKZV6fgFZYLtgdUl3+Tpm2pLSeVKN9hgRXIXcN4jlBvFv8
         dKww==
X-Gm-Message-State: APjAAAVzd6xiGXc0J0eIQ+uCF2fn2XxbaqApfyXbou11gZBxFZIcWgeK
        PgjrunioXy410VMpXIyHk5b8BkDO7xQj8MOztOgNC8oKSAF7HFNj5R389Sg56Y+6DFt1ndqiRho
        CXyE+0yWTQ65Ci4b7BZvl1q64Iok=
X-Received: by 2002:ac2:5df0:: with SMTP id z16mr14300264lfq.36.1571159943774;
        Tue, 15 Oct 2019 10:19:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwtmWhVJzibU3fbFh0zzmpTOwLDpwyRfz8OIjlJgF3lnE3XdYDXQ1Jt6j749UmjRgzPR7qwpg==
X-Received: by 2002:ac2:5df0:: with SMTP id z16mr14300247lfq.36.1571159943542;
        Tue, 15 Oct 2019 10:19:03 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id z18sm5130432ljh.17.2019.10.15.10.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 10:19:02 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id F1C501803A8; Tue, 15 Oct 2019 19:19:01 +0200 (CEST)
Subject: [PATCH v2 4/4] mac80211: Use Airtime-based Queue Limits (AQL) on
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
Date:   Tue, 15 Oct 2019 19:19:01 +0200
Message-ID: <157115994190.2500430.14955682016008497593.stgit@toke.dk>
In-Reply-To: <157115993755.2500430.12214017471129215800.stgit@toke.dk>
References: <157115993755.2500430.12214017471129215800.stgit@toke.dk>
User-Agent: StGit/0.20
MIME-Version: 1.0
X-MC-Unique: zgcfJpMMOBKvoISG6ZCRDQ-1
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
 net/mac80211/tx.c     |   16 ++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index ab8ba5835ca0..ce990a1e9043 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -676,6 +676,33 @@ static void ieee80211_report_used_skb(struct ieee80211=
_local *local,
 =09if (dropped)
 =09=09acked =3D false;
=20
+=09if (info->status.tx_time_est) {
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
+=09=09=09=09=09=09     info->status.tx_time_est,
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
+=09=09if (info->status.tx_time_est) {
+=09=09=09/* Do this here to avoid the expensive lookup of the sta
+=09=09=09 * in ieee80211_report_used_skb().
+=09=09=09 */
+=09=09=09ieee80211_sta_update_pending_airtime(local, sta,
+=09=09=09=09=09=09=09     ieee80211_ac_from_tid(tid),
+=09=09=09=09=09=09=09     info->status.tx_time_est,
+=09=09=09=09=09=09=09     true);
+=09=09=09info->status.tx_time_est =3D 0;
+=09=09}
+
 =09=09if (!acked && ieee80211_is_back_req(fc)) {
 =09=09=09u16 control;
=20
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 405f622b3fe0..b6b47171b340 100644
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
@@ -3652,6 +3657,17 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee8021=
1_hw *hw,
 =09}
=20
 =09IEEE80211_SKB_CB(skb)->control.vif =3D vif;
+
+=09if (local->airtime_flags & AIRTIME_USE_AQL) {
+=09=09airtime =3D ieee80211_calc_expected_tx_airtime(hw, vif, txq->sta,
+=09=09=09=09=09=09=09     skb->len + 38);
+=09=09if (airtime) {
+=09=09=09info->control.tx_time_est =3D airtime;
+=09=09=09ieee80211_sta_update_pending_airtime(local, tx.sta, ac,
+=09=09=09=09=09=09=09     airtime, false);
+=09=09}
+=09}
+
 =09return skb;
=20
 out:

