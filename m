Return-Path: <linux-wireless+bounces-23126-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3606DABB0EB
	for <lists+linux-wireless@lfdr.de>; Sun, 18 May 2025 18:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC4411731E7
	for <lists+linux-wireless@lfdr.de>; Sun, 18 May 2025 16:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410F221B9F7;
	Sun, 18 May 2025 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="REebqn4o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF0A487A5;
	Sun, 18 May 2025 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747586769; cv=none; b=AHYhTljz49C+ujL0r6aKU5RV1bbEuJC5TyOnFXxmjUJhh9cYgv1YBy2rq2ks1DOG9L6AnpVQ8qtLVfX7GThsNlVaDgDp5WbDyYlegQrbtLVkbbJ1iJCrusfhTrxN7zzQxwU05IdOBlhWapDjlhwA485LQ/xb47vlePn5eI6e5/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747586769; c=relaxed/simple;
	bh=tQ8V+DZP8yliAp1N8cuABR/Y/cm1gdGKdqgQ24IPTt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZCdgwmCMxN+ViUQRsHFz8m04clmKjN9i09iSOvZ5krMVl4Kjd5KqYYn3yjeMHQSdrP9zSNCZGVejktcUZF+TWutMVJx/Yfn8YLksFVxZZmS83+FhS2J4itr0gxnd0KCyOAPfO5QjbFArd4Jc7iAZL3IiJ/rFQhVQaAY8qmIxXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=REebqn4o; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1747586759; x=1748191559; i=spasswolf@web.de;
	bh=jLDh7t1itMQyhNXxv5HHmNQvSgBTB2wRdWHK6s0qsG4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=REebqn4oaEBzsVNnKtl3E32SZlhJgkjgiBiijdWGUdzFazL/JQcf5cyDY4H1dsW+
	 vS/hmKIn/M1Z8udKzsBl26BKmaEMiYIN+DYzL88ciD8n1aqsnWkzgST8Qh2h1acH5
	 h9YwjHEDtxrNaFIdNucvb3x0ChnXWYeMB+XPydbP2tMSy0Ahm4atRrJP/5cu6j6Gg
	 2cQAr3TdH2vyuijUlhUkUEJhATb6hjM8UJr2ngvvkjkoJoLXaEVBVvjPNAv+Rf+f3
	 d6MKe7pGJH3phxlx4WtQoKblEua6KquE9pcHnal31FBJQ8pcRYb/lyY0O7bNh51IT
	 ykr/jXXDITbPGEXDjQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([95.223.134.88]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1M604t-1uIcxg144R-00GioS; Sun, 18 May 2025 18:45:59 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: linux-wireless@vger.kernel.org
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] wifi: Check if socket flags are valid
Date: Sun, 18 May 2025 18:45:45 +0200
Message-ID: <20250518164546.4612-1-spasswolf@web.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: f109986d1c25c794f7f6a470722f1ea878d10b33.camel@web.de
References: 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m+AYt3iPuZPWwanLbzzFQBy+aFSrXim4vui7jLGr+4mgfx8BFJA
 fzrNSqwvMAQVWwr88C9/lX8Snfi20stZbil++qLwrGHE3JmPSrMkZ0CP7uKMoYzzCUHcKAq
 eFnef6ih6c9rft79E/uL1s9Rf+ML563gBOlREORBQuYUu+CiB5i7KJgRie8BNyAySLPGxEd
 rVokXm37OquruadBDbddQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zT8zDCx5T6o=;Qs+xr81IqND5jNz9NcMxhrxafW1
 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

The check, if a particular SO_* flag_bit is set, may give a wrong result
since sk_flags are part of a union and the union is used otherwise.
This happens, if a socket is not a full socket, like a request socket=20
for example.

Add a check to verify, if the union is used for sk_flags.

This solution is taken from commit
e8a64bbaaad1 ("net/sched: taprio: Check if socket flags are valid").

Fixes: 76a853f86c97 ("wifi: free SKBTX_WIFI_STATUS skb tx_flags flag")

Signed-off-by: Bert Karwatzki <spasswolf@web.de>
=2D--
 drivers/net/wireless/ath/wil6210/txrx.h     | 2 +-
 drivers/net/wireless/marvell/mwifiex/main.c | 2 +-
 net/mac80211/mesh.c                         | 2 +-
 net/mac80211/tx.c                           | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/txrx.h b/drivers/net/wireles=
s/ath/wil6210/txrx.h
index 33ccd0b248d4..91432b318ec2 100644
=2D-- a/drivers/net/wireless/ath/wil6210/txrx.h
+++ b/drivers/net/wireless/ath/wil6210/txrx.h
@@ -618,7 +618,7 @@ static inline bool wil_need_txstat(struct sk_buff *skb=
)
 	const u8 *da =3D wil_skb_get_da(skb);
=20
 	return is_unicast_ether_addr(da) && skb->sk &&
-	       sock_flag(skb->sk, SOCK_WIFI_STATUS);
+	       sk_fullsock(skb->sk) && sock_flag(skb->sk, SOCK_WIFI_STATUS);
 }
=20
 static inline void wil_consume_skb(struct sk_buff *skb, bool acked)
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wir=
eless/marvell/mwifiex/main.c
index 1485f949ad4e..973df2656238 100644
=2D-- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -913,7 +913,7 @@ mwifiex_hard_start_xmit(struct sk_buff *skb, struct ne=
t_device *dev)
=20
 	multicast =3D is_multicast_ether_addr(skb->data);
=20
-	if (unlikely(!multicast && skb->sk &&
+	if (unlikely(!multicast && skb->sk && sk_fullsock(skb->sk) &&
 		     sock_flag(skb->sk, SOCK_WIFI_STATUS) &&
 		     priv->adapter->fw_api_ver =3D=3D MWIFIEX_FW_V15))
 		skb =3D mwifiex_clone_skb_for_tx_status(priv,
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index a381b4b756ea..11b6cb639ae7 100644
=2D-- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -777,7 +777,7 @@ bool ieee80211_mesh_xmit_fast(struct ieee80211_sub_if_=
data *sdata,
 	if (ethertype < ETH_P_802_3_MIN)
 		return false;
=20
-	if (skb->sk && sock_flag(skb->sk, SOCK_WIFI_STATUS))
+	if (skb->sk && sk_fullsock(skb->sk) && sock_flag(skb->sk, SOCK_WIFI_STAT=
US))
 		return false;
=20
 	if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 3b9392a6ddb2..8b5bcddd5cc9 100644
=2D-- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2859,7 +2859,7 @@ static struct sk_buff *ieee80211_build_hdr(struct ie=
ee80211_sub_if_data *sdata,
 	}
=20
 	if (unlikely(!multicast &&
-		     ((skb->sk && sock_flag(skb->sk, SOCK_WIFI_STATUS)) ||
+		     ((skb->sk && sk_fullsock(skb->sk) && sock_flag(skb->sk, SOCK_WIFI_=
STATUS)) ||
 		      ctrl_flags & IEEE80211_TX_CTL_REQ_TX_STATUS)))
 		info_id =3D ieee80211_store_ack_skb(local, skb, &info_flags,
 						  cookie);
@@ -3756,7 +3756,7 @@ static bool ieee80211_xmit_fast(struct ieee80211_sub=
_if_data *sdata,
 		return false;
=20
 	/* don't handle TX status request here either */
-	if (skb->sk && sock_flag(skb->sk, SOCK_WIFI_STATUS))
+	if (skb->sk && sk_fullsock(skb->sk) && sock_flag(skb->sk, SOCK_WIFI_STAT=
US))
 		return false;
=20
 	if (hdr->frame_control & cpu_to_le16(IEEE80211_STYPE_QOS_DATA)) {
@@ -4648,7 +4648,7 @@ static void ieee80211_8023_xmit(struct ieee80211_sub=
_if_data *sdata,
 			memcpy(IEEE80211_SKB_CB(seg), info, sizeof(*info));
 	}
=20
-	if (unlikely(skb->sk && sock_flag(skb->sk, SOCK_WIFI_STATUS))) {
+	if (unlikely(skb->sk && sk_fullsock(skb->sk) && sock_flag(skb->sk, SOCK_=
WIFI_STATUS))) {
 		info->status_data =3D ieee80211_store_ack_skb(local, skb,
 							    &info->flags, NULL);
 		if (info->status_data)
=2D-=20
2.49.0

I've dug a little into the history of sk_flags (which have been introduced=
 in
v4.4) and found commit e8a64bbaaad1 ("net/sched: taprio: Check if socket f=
lags=20
are valid"), which seems to address the same problem we're currently facin=
g:

commit e8a64bbaaad1f6548cec5508297bc6d45e8ab69e
Author: Benedikt Spranger <b.spranger@linutronix.de>
Date:   Fri Apr 8 11:47:45 2022 +0200

    net/sched: taprio: Check if socket flags are valid
   =20
    A user may set the SO_TXTIME socket option to ensure a packet is send
    at a given time. The taprio scheduler has to confirm, that it is allow=
ed
    to send a packet at that given time, by a check against the packet tim=
e
    schedule. The scheduler drop the packet, if the gates are closed at th=
e
    given send time.
   =20
    The check, if SO_TXTIME is set, may fail since sk_flags are part of an
    union and the union is used otherwise. This happen, if a socket is not
    a full socket, like a request socket for example.
   =20
    Add a check to verify, if the union is used for sk_flags.
   =20
    Fixes: 4cfd5779bd6e ("taprio: Add support for txtime-assist mode")
    Signed-off-by: Benedikt Spranger <b.spranger@linutronix.de>
    Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
    Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 377f896bdedc..b9c71a304d39 100644
=2D-- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -417,7 +417,8 @@ static int taprio_enqueue_one(struct sk_buff *skb, str=
uct Qdisc *sch,
 {
 	struct taprio_sched *q =3D qdisc_priv(sch);
=20
-	if (skb->sk && sock_flag(skb->sk, SOCK_TXTIME)) {
+	/* sk_flags are only safe to use on full sockets. */
+	if (skb->sk && sk_fullsock(skb->sk) && sock_flag(skb->sk, SOCK_TXTIME)) =
{
 		if (!is_valid_interval(skb, sch))
 			return qdisc_drop(skb, sch, to_free);
 	} else if (TXTIME_ASSIST_IS_ENABLED(q->flags)) {

I'm not sure if all sk_fullsock() checks are necessary, or if it can
be guessed from context if the socket is valid, though.

This has been tested for ~1h so far.

Bert Karwatzki

