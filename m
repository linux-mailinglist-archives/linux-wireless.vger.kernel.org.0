Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39DA3DD895
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Oct 2019 13:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfJSLh1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Oct 2019 07:37:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32409 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725912AbfJSLh0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Oct 2019 07:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571485045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MVaudQUuQCI+ljMWLLAsex2zEz8cPUhBc2aoUxPRkR8=;
        b=BWcOvuLNv5sd3XrirToRijYY47SKmawEq67pkT1OMXCnwQdWSd3bTeGjy62B3W5BSk4E+o
        wfPek17boDv3Z1Wo0UlGmMf3RHSucmJHliD+ujH7u6mmmWWoY3dX5uIth7amXxNmGdSA1I
        ekb94G5xkt3eIjEseeXtclveKH/GuTE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-BjThIq7eM0Gx-bXcFrpW7Q-1; Sat, 19 Oct 2019 07:37:22 -0400
Received: by mail-lj1-f198.google.com with SMTP id m81so1620377lje.4
        for <linux-wireless@vger.kernel.org>; Sat, 19 Oct 2019 04:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=KwtZFfw3+zEIBpCSK3JjIjdY2khNQMsybmZnMAvVGWM=;
        b=oxXi5RR2dKIcq19W184KbDHr5EfrPod6SK2wOBtfb+O1KySWIYtYp3zIBOAYaz5H5H
         MJvqi40q/HD37W64Vjuw8FyIx42mkZxLh0mckJJclTG2f0UWtcJsWvUqt21XxeZiVUf7
         3rdlbjUGPxENWFlK3sfHUgTGeGW+dCNL/dUikvR85XJtPmu1OsFEGZtBaj67n9LkrjL/
         dJaMpHscHVRbzZ2XoTIxz2skWTW/dyj0LAx7zrMEg46J8P5VrrHaDGykWjnPZWgXyedI
         zR2g61ixazDrHzicSz20NjOkv/MvtCuyOVe9thiJdkRJedtC8y7Imy6xl7Q6nvehy8vU
         kdzA==
X-Gm-Message-State: APjAAAWIaeCixlBoZ/GjlsB7sfSjg6dYipxsIvwPIm0lL5Cisk9U/f1t
        HCvYeA9uL2vSn2WbqPjRXIXWJIlpy6zkKj3za6cw2DBpOZFDimEQNhEHJtSJGW2Pbi2VCYu4Yl6
        UNhndvqlHaRVl/JV+WhepmdeKMGQ=
X-Received: by 2002:a19:9146:: with SMTP id y6mr645542lfj.11.1571485040858;
        Sat, 19 Oct 2019 04:37:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy6A2s0kb12rWbr+kZlB9sAojMXKwZLl1GcZkznDPvWiSSK5d9yqvGSQlvsPztMK75+Z9uVsw==
X-Received: by 2002:a19:9146:: with SMTP id y6mr645532lfj.11.1571485040619;
        Sat, 19 Oct 2019 04:37:20 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id h3sm5459652ljf.12.2019.10.19.04.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 04:37:19 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BD12A1804C8; Sat, 19 Oct 2019 13:37:18 +0200 (CEST)
Subject: [PATCH v4 4/4] mac80211: Use Airtime-based Queue Limits (AQL) on
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
Date:   Sat, 19 Oct 2019 13:37:18 +0200
Message-ID: <157148503865.2989444.7118792679603045723.stgit@toke.dk>
In-Reply-To: <157148503415.2989444.7391437309981941226.stgit@toke.dk>
References: <157148503415.2989444.7391437309981941226.stgit@toke.dk>
User-Agent: StGit/0.20
MIME-Version: 1.0
X-MC-Unique: BjThIq7eM0Gx-bXcFrpW7Q-1
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
 net/mac80211/tx.c     |   21 +++++++++++++++++++++
 2 files changed, 59 insertions(+)

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
index 12653d873b8c..b8ff56d1d661 100644
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
+=09=09=09 * in increments of 4 us and clamp the maximum to 2**12-1
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

