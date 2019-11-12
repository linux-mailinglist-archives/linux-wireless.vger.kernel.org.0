Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E14A7F86C2
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2019 03:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfKLCLy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Nov 2019 21:11:54 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:52488 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfKLCLy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Nov 2019 21:11:54 -0500
Received: by mail-pg1-f202.google.com with SMTP id 32so11146942pgy.19
        for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2019 18:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=jp9mmRjzmSt3M5pfqQBklbI8/K34oEiVaxLBlUf62iU=;
        b=uHpSpIu1vpKtjUdIED6xRi5HLaACQTDweoq5l2O+S/PwKpkSeEA7KXkf4XeEf+yRe7
         ipdo0xkhiatBrzRZAXEOxa2ELmNcbFVnbBvrp4FyVg9w0OoLd78bTsjp0N7chbkJ0TpW
         /VfabtdLLE0fdzhJt9oBdujxHWBtCFuau5lrKmZ7YioZS9BssLgn7W7EbMJ94Vw5GYw1
         hGZOXRPRKsElHqtRccMKIouWXfP2aT1OR6rOCZG3wFEnHYt8TCYiW6vAiVGQeqlYcER7
         bRbIfr8O5T4awVjDxnxw3/OYk+lry8Mg1aFFLRq5ReFw/rc/D3lR+eiv1Vt6KGGyk7Js
         XvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=jp9mmRjzmSt3M5pfqQBklbI8/K34oEiVaxLBlUf62iU=;
        b=E+rGHolTlu0dol11kwYVn5IWA1g9GdJc1RaRZOcvoa4aROYRrKBUAuHlE+dS38oF7/
         iUeVpN96vFHznBx1AM7BqtX/bggkKZOmmKh+Dp+xMkUEYALCiCdhGNUWDDoWwztJQdUy
         eAHBkyEcH9Tncv6dMrJ76BTrMtCLt0jlDw5wywWazcPjRB+GNaNWCHeLlNlRyQq5gVRX
         gDOPOvU2BnABdtxGkJr77t5ba0qdIMHmvAc/g4xma6fh6cSCEOqkdnRVJIGTNdxS9/c2
         vEt4v92q2LQGfuMqvXdDZXIixliEddQkuOceW5GAYHXQ3AOo6Eu8NOCJ9FDYjxnRp/9h
         3hHA==
X-Gm-Message-State: APjAAAUCNa3ESI27Ic9VJCDhCQ7n6hVs696uQobKUi0zp1zoyGjsl74I
        7rtR07kFwRzF9UYETf3y//6Tj78U
X-Google-Smtp-Source: APXvYqzfq+qe9TXj9tPrLFR2OPmebDmH3HuCgAfxuIHF5qxX8IRPJlcodfeDRIWy9xnHSwoQfd9BGupS
X-Received: by 2002:a63:d951:: with SMTP id e17mr31588368pgj.243.1573524713415;
 Mon, 11 Nov 2019 18:11:53 -0800 (PST)
Date:   Mon, 11 Nov 2019 18:11:36 -0800
In-Reply-To: <20191112021136.42918-1-kyan@google.com>
Message-Id: <20191112021136.42918-3-kyan@google.com>
Mime-Version: 1.0
References: <20191112021136.42918-1-kyan@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v7 2/2] mac80211: Use Airtime-based Queue Limits (AQL) on
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
 net/mac80211/status.c | 33 +++++++++++++++++++++++++++++++++
 net/mac80211/tx.c     | 21 +++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index ab8ba5835ca0..ae15c8fd2421 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -676,6 +676,28 @@ static void ieee80211_report_used_skb(struct ieee80211=
_local *local,
 	if (dropped)
 		acked =3D false;
=20
+	if (info->tx_time_est) {
+		struct sta_info *sta =3D NULL, *s;
+		struct rhlist_head *tmp;
+
+		rcu_read_lock();
+
+		for_each_sta_info(local, hdr->addr1, s, tmp) {
+			/* skip wrong virtual interface */
+			if (!ether_addr_equal(hdr->addr2, s->sdata->vif.addr))
+				continue;
+
+			sta =3D s;
+			break;
+		}
+
+		ieee80211_sta_update_pending_airtime(local, sta,
+						     skb_get_queue_mapping(skb),
+						     info->tx_time_est << 2,
+						     true);
+		rcu_read_unlock();
+	}
+
 	if (info->flags & IEEE80211_TX_INTFL_MLME_CONN_TX) {
 		struct ieee80211_sub_if_data *sdata;
=20
@@ -986,6 +1008,17 @@ static void __ieee80211_tx_status(struct ieee80211_hw=
 *hw,
 			ieee80211_sta_register_airtime(&sta->sta, tid,
 						       info->status.tx_time, 0);
=20
+		if (info->tx_time_est) {
+			/* Do this here to avoid the expensive lookup of the sta
+			 * in ieee80211_report_used_skb().
+			 */
+			ieee80211_sta_update_pending_airtime(local, sta,
+							     skb_get_queue_mapping(skb),
+							     info->tx_time_est << 2,
+							     true);
+			info->tx_time_est =3D 0;
+		}
+
 		if (ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS)) {
 			if (info->flags & IEEE80211_TX_STAT_ACK) {
 				if (sta->status_stats.lost_packets)
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index f53d56ef535a..583211ca670d 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3549,6 +3549,9 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211=
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
@@ -3659,6 +3662,24 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee8021=
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
+			/* We only have 10 bits in tx_time_est, so store airtime
+			 * in increments of 4us and clamp the maximum to 2**12-1
+			 */
+			airtime =3D min_t(u32, airtime, 4095) & ~3U;
+			info->tx_time_est =3D airtime >> 2;
+			ieee80211_sta_update_pending_airtime(local, tx.sta,
+							     txq->ac, airtime,
+							     false);
+		}
+	}
+
 	return skb;
=20
 out:
--=20
2.24.0.rc1.363.gb1bccd3e3d-goog

