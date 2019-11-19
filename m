Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51EBC101830
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2019 07:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbfKSGGb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Nov 2019 01:06:31 -0500
Received: from mail-vs1-f74.google.com ([209.85.217.74]:34666 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfKSGGa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Nov 2019 01:06:30 -0500
Received: by mail-vs1-f74.google.com with SMTP id z20so2882236vsf.1
        for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2019 22:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=dLgQiPR8RsakdmkVlj0XyEgsbL124yjipUkAngnx6xs=;
        b=hA03WsSS21RmCusi/RWcYc6luih+kZrB5n71dmsdO1/eSsmdMQoTk6i70jUvPyq9u3
         OcbBQTDpDaktF+bWhbPHvGq9ClBA4U+Ig1tpIWyPT1DenvTaqrdhUE1iAKwnCCI8f3dx
         qczxP8bpNlRavhH779DxwSZIogtYZ5/iNqvxEeuweVxXYO746KyeSEAAOyjX05NvG2TC
         jJraJ8NMOK8N72QEWTxcxFQpW3Tc4xUpWQfxKNTxjnRV4kIwt8cLbfmRqxEnMGtx5yj4
         UF4U2Y6+8hsOw1+DY//L73NwMeFZFxaeWQ4bndLw1hKxTlP/JGHpVUH5bBQXAu5d+8jw
         nD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=dLgQiPR8RsakdmkVlj0XyEgsbL124yjipUkAngnx6xs=;
        b=ec/mg/b+ZLc3VtgZBeXT/Cp8KkwF/MQv6Fl5LXw0nqA64rcUNEyfsYu7HrD4YpB/CA
         CFDAqxl8J5tPIzzSSu/b7qRlLyuEXHNKdlvYE468KnLGYd4Rg79nSyaMPDHDDtoKHPfE
         wEQjlpN+8tbgjsXEKO+qd002vDlFW3BjGzlYVDRnZag5AZb9VKNPeKjAmB0GS4XokhAZ
         52iPoXLV1sD+5kjhvnr08fKxEIyS/Tnn3yEUy+QH+eLeTC9y+Bf/x6/U1jjYc9/btdyF
         BKvBkioKvv/eF19cul/Zaf/WpI/8T/4yqgBc9px4NV1b17jGsQmzU5S/gfZZ8pjQK/mK
         M41g==
X-Gm-Message-State: APjAAAUtEZd69TuHvgRZ3K/7Z5fGyI334e+J/OzM5MsE7iqJDKQOz/5D
        /vOglWVDVhDl5BuwbagGZsrg9kgE
X-Google-Smtp-Source: APXvYqxDPhn+tNy93LMN2Fej8KdgxuzzcNgHTP3+TMEo9olRvWTss6vB9IB86oEqX8LMgW3o6FLQ3NYG
X-Received: by 2002:a1f:a74c:: with SMTP id q73mr18728743vke.78.1574143588937;
 Mon, 18 Nov 2019 22:06:28 -0800 (PST)
Date:   Mon, 18 Nov 2019 22:06:10 -0800
In-Reply-To: <20191119060610.76681-1-kyan@google.com>
Message-Id: <20191119060610.76681-5-kyan@google.com>
Mime-Version: 1.0
References: <20191119060610.76681-1-kyan@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v11 4/4] mac80211: Use Airtime-based Queue Limits (AQL) on
 packet dequeue
From:   Kan Yan <kyan@google.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, toke@redhat.com,
        nbd@nbd.name, yiboz@codeaurora.org, john@phrozen.org,
        lorenzo@kernel.org, rmanohar@codeaurora.org, kevinhayes@google.com
Content-Type: text/plain; charset="UTF-8"
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
 include/net/mac80211.h | 16 ++++++++++++++++
 net/mac80211/status.c  | 26 ++++++++++++++++++++++++++
 net/mac80211/tx.c      | 18 ++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index ba3f33cc41ea..aa145808e57a 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1060,6 +1060,22 @@ struct ieee80211_tx_info {
 	};
 };
=20
+static inline u16
+ieee80211_info_set_tx_time_est(struct ieee80211_tx_info *info, u16 tx_time=
_est)
+{
+	/* We only have 10 bits in tx_time_est, so store airtime
+	 * in increments of 4us and clamp the maximum to 2**12-1
+	 */
+	info->tx_time_est =3D min_t(u16, tx_time_est, 4095) >> 2;
+	return info->tx_time_est << 2;
+}
+
+static inline u16
+ieee80211_info_get_tx_time_est(struct ieee80211_tx_info *info)
+{
+	return info->tx_time_est << 2;
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
 				      struct sk_buff *skb, bool dropped)
 {
 	struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(skb);
+	u16 tx_time_est =3D ieee80211_info_get_tx_time_est(info);
 	struct ieee80211_hdr *hdr =3D (void *)skb->data;
 	bool acked =3D info->flags & IEEE80211_TX_STAT_ACK;
=20
 	if (dropped)
 		acked =3D false;
=20
+	if (tx_time_est) {
+		struct sta_info *sta;
+
+		rcu_read_lock();
+
+		sta =3D sta_info_get_by_addrs(local, hdr->addr1, hdr->addr2);
+		ieee80211_sta_update_pending_airtime(local, sta,
+						     skb_get_queue_mapping(skb),
+						     tx_time_est,
+						     true);
+		rcu_read_unlock();
+	}
+
 	if (info->flags & IEEE80211_TX_INTFL_MLME_CONN_TX) {
 		struct ieee80211_sub_if_data *sdata;
=20
@@ -877,6 +891,7 @@ static void __ieee80211_tx_status(struct ieee80211_hw *=
hw,
 	struct ieee80211_bar *bar;
 	int shift =3D 0;
 	int tid =3D IEEE80211_NUM_TIDS;
+	u16 tx_time_est;
=20
 	rates_idx =3D ieee80211_tx_get_rates(hw, info, &retry_count);
=20
@@ -986,6 +1001,17 @@ static void __ieee80211_tx_status(struct ieee80211_hw=
 *hw,
 			ieee80211_sta_register_airtime(&sta->sta, tid,
 						       info->status.tx_time, 0);
=20
+		if ((tx_time_est =3D ieee80211_info_get_tx_time_est(info)) > 0) {
+			/* Do this here to avoid the expensive lookup of the sta
+			 * in ieee80211_report_used_skb().
+			 */
+			ieee80211_sta_update_pending_airtime(local, sta,
+							     skb_get_queue_mapping(skb),
+							     tx_time_est,
+							     true);
+			ieee80211_info_set_tx_time_est(info, 0);
+		}
+
 		if (ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS)) {
 			if (info->flags & IEEE80211_TX_STAT_ACK) {
 				if (sta->status_stats.lost_packets)
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 59db921d1086..dfbaab92dbf2 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3551,6 +3551,9 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211=
_hw *hw,
=20
 	WARN_ON_ONCE(softirq_count() =3D=3D 0);
=20
+	if (!ieee80211_txq_airtime_check(hw, txq))
+		return NULL;
+
 begin:
 	spin_lock_bh(&fq->lock);
=20
@@ -3661,6 +3664,21 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee8021=
1_hw *hw,
 	}
=20
 	IEEE80211_SKB_CB(skb)->control.vif =3D vif;
+
+	if (local->airtime_flags & AIRTIME_USE_AQL) {
+		u32 airtime;
+
+		airtime =3D ieee80211_calc_expected_tx_airtime(hw, vif, txq->sta,
+							     skb->len);
+		if (airtime) {
+			airtime =3D ieee80211_info_set_tx_time_est(info, airtime);
+			ieee80211_sta_update_pending_airtime(local, tx.sta,
+							     txq->ac,
+							     airtime,
+							     false);
+		}
+	}
+
 	return skb;
=20
 out:
--=20
2.24.0.432.g9d3f5f5b63-goog

