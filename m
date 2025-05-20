Return-Path: <linux-wireless+bounces-23189-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABA8ABE747
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 00:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1BA93B69E7
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 22:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F353F253B64;
	Tue, 20 May 2025 22:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="X9yxXSJk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217691FDE02;
	Tue, 20 May 2025 22:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747780487; cv=none; b=m4+FD7BAGQ0swMtmZUxDGA69IiE+0kH2u5uWDScaZJ4F4SpPLEhx8zfKhM1Xyr8cPg9LtMG+tEQgWzM3izJ0bPwpSpA1zc1pVwclZAxEQg3SX7J7Lrb7x10iLttX+A70P4JYz9FRWQmcEZTLLgHUgx+brwImDlsasnXWrXS6yYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747780487; c=relaxed/simple;
	bh=DfSmlw2ky7OFmz4+3PUKVmvruRbl4BnFb/x15VDASIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jv/DA83t3DeeqiJMJv0EBc+Wq4FIjINeKtJjHHkC7YLlvcB94VyHI78KhjaHP4DDQhCvcmTR1JIOC6SHxyPO6JvKozwW4cGx+gX5Xqd7/Nonhk8RTU1e+l8tqPVkM5vx/xyKX+HB5kiBNLtfyFXpQdwU41cBM3aM9FPBSwmoF1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=X9yxXSJk; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1747780473; x=1748385273; i=spasswolf@web.de;
	bh=vLvpg1gqk1QMzG4wp0MpOyy9qKpbJeSJVQiP69cX4Vc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=X9yxXSJkmS+FUJGE+iPGVjgH5kHoYZIEZfApQPoVTMC7hCcpVhfxSai1bcJIwedd
	 HIx+gdzkeytyc8iRrvN7IqdLIa31UwpttTIs5WRHoRQKN8kZQr2TIONRvbRRZ3fCT
	 uoWIXd4xais30CtihvTJuH65hOnTaiIVus0YhSl1fD44wgPaHfXQxcazqKOBL+gN7
	 w4y95o2J8uZgGBrj8OSuhfD8Bp1EtTt0M8wWZIlt/l8DH7AxkVj4valfaz3GKjLF0
	 ac3hKjNTVXs+nzxwol7i5hwuw2guEoRFcGakoMlnRl9sYmtYIQawvUzalwylCNRD+
	 663sYlF5CDkWc1vHmg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([95.223.134.88]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MeDQj-1uq1HS0Ckp-00aXaR; Wed, 21 May 2025 00:34:33 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: linux-wireless@vger.kernel.org
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH] wifi: add sk_requests_wifi_status()
Date: Wed, 21 May 2025 00:34:29 +0200
Message-ID: <20250520223430.6875-1-spasswolf@web.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: f6d119025a88b766ec803ef948dbbf7c97574b74.camel@sipsolutions.net
References: 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8B3KASvul8NjNhieBQsQqF9z56AhbnbcW82TkfiyNI52alVYc5Z
 Ey/KfZvSvz9yRYMARv0iFSsqwfpUFTIJPaxuWi4lAvDaJKwZ+P5jS/RltuN2ZTNrNhCBcIc
 pJHw9LcVzt8VGS+m6N9qqSsFT0BjtjO6hXyfMoGbE1rbpCSCfC289O2nPFbFNJws/Pgjgqd
 93loyV9JlK/FKre/f0ohw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wPKrg23ARa0=;zQkm+35Dq+Z7+NACxLSzy68DnS5
 +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
 Uu8qutgxovdyA=

Checking the SOCK_WIFI_STATUS flag bit in sk_flags, may give a wrong resul=
t
since sk_flags are part of a union and the union is used otherwise. Add
a sk_requests_wifi_status() which checks if sk is non-NULL, sk is a full s=
ocket
and checks the flag bit.

Fixes: 76a853f86c97 ("wifi: free SKBTX_WIFI_STATUS skb tx_flags flag")
Idea-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Bert Karwatzki <spasswolf@web.de>
=2D--
 drivers/net/wireless/ath/wil6210/txrx.h     | 3 +--
 drivers/net/wireless/marvell/mwifiex/main.c | 3 +--
 include/net/sock.h                          | 7 +++++++
 net/mac80211/mesh.c                         | 2 +-
 net/mac80211/tx.c                           | 6 +++---
 5 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/txrx.h b/drivers/net/wireles=
s/ath/wil6210/txrx.h
index 33ccd0b248d4..fff8b7f8abc5 100644
=2D-- a/drivers/net/wireless/ath/wil6210/txrx.h
+++ b/drivers/net/wireless/ath/wil6210/txrx.h
@@ -617,8 +617,7 @@ static inline bool wil_need_txstat(struct sk_buff *skb=
)
 {
 	const u8 *da =3D wil_skb_get_da(skb);
=20
-	return is_unicast_ether_addr(da) && skb->sk &&
-	       sock_flag(skb->sk, SOCK_WIFI_STATUS);
+	return is_unicast_ether_addr(da) && sk_requests_wifi_status(skb->sk);
 }
=20
 static inline void wil_consume_skb(struct sk_buff *skb, bool acked)
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wir=
eless/marvell/mwifiex/main.c
index 1485f949ad4e..7b50a88a18e5 100644
=2D-- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -913,8 +913,7 @@ mwifiex_hard_start_xmit(struct sk_buff *skb, struct ne=
t_device *dev)
=20
 	multicast =3D is_multicast_ether_addr(skb->data);
=20
-	if (unlikely(!multicast && skb->sk &&
-		     sock_flag(skb->sk, SOCK_WIFI_STATUS) &&
+	if (unlikely(!multicast && sk_requests_wifi_status(skb->sk) &&
 		     priv->adapter->fw_api_ver =3D=3D MWIFIEX_FW_V15))
 		skb =3D mwifiex_clone_skb_for_tx_status(priv,
 						      skb,
diff --git a/include/net/sock.h b/include/net/sock.h
index 3e15d7105ad2..2da289ec4c17 100644
=2D-- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2822,6 +2822,13 @@ sk_is_refcounted(struct sock *sk)
 	return !sk_fullsock(sk) || !sock_flag(sk, SOCK_RCU_FREE);
 }
=20
+static inline bool
+sk_requests_wifi_status(struct sock *sk)
+{
+	return sk && sk_fullsock(sk) && sock_flag(sk,
+SOCK_WIFI_STATUS);
+}
+
 /* Checks if this SKB belongs to an HW offloaded socket
  * and whether any SW fallbacks are required based on dev.
  * Check decrypted mark in case skb_orphan() cleared socket.
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index a381b4b756ea..5cc56d578048 100644
=2D-- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -777,7 +777,7 @@ bool ieee80211_mesh_xmit_fast(struct ieee80211_sub_if_=
data *sdata,
 	if (ethertype < ETH_P_802_3_MIN)
 		return false;
=20
-	if (skb->sk && sock_flag(skb->sk, SOCK_WIFI_STATUS))
+	if (sk_requests_wifi_status(skb->sk))
 		return false;
=20
 	if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 3b9392a6ddb2..d8d4f3d7d7f2 100644
=2D-- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2859,7 +2859,7 @@ static struct sk_buff *ieee80211_build_hdr(struct ie=
ee80211_sub_if_data *sdata,
 	}
=20
 	if (unlikely(!multicast &&
-		     ((skb->sk && sock_flag(skb->sk, SOCK_WIFI_STATUS)) ||
+		     (sk_requests_wifi_status(skb->sk) ||
 		      ctrl_flags & IEEE80211_TX_CTL_REQ_TX_STATUS)))
 		info_id =3D ieee80211_store_ack_skb(local, skb, &info_flags,
 						  cookie);
@@ -3756,7 +3756,7 @@ static bool ieee80211_xmit_fast(struct ieee80211_sub=
_if_data *sdata,
 		return false;
=20
 	/* don't handle TX status request here either */
-	if (skb->sk && sock_flag(skb->sk, SOCK_WIFI_STATUS))
+	if (sk_requests_wifi_status(skb->sk))
 		return false;
=20
 	if (hdr->frame_control & cpu_to_le16(IEEE80211_STYPE_QOS_DATA)) {
@@ -4648,7 +4648,7 @@ static void ieee80211_8023_xmit(struct ieee80211_sub=
_if_data *sdata,
 			memcpy(IEEE80211_SKB_CB(seg), info, sizeof(*info));
 	}
=20
-	if (unlikely(skb->sk && sock_flag(skb->sk, SOCK_WIFI_STATUS))) {
+	if (unlikely(sk_requests_wifi_status(skb->sk))) {
 		info->status_data =3D ieee80211_store_ack_skb(local, skb,
 							    &info->flags, NULL);
 		if (info->status_data)
=2D-=20
2.49.0

There are two calls to sock_flag(., SOCK_WIFI_STATUS) which I didn't chang=
e:
In __sock_recv_wifi_status() (in net/socket.c) which gets called by=20
sock_recv_timestamp() and in sk_getsockopt() (in net/core/sock.c). These
existed before the error occured and seem to be fine.=20

Bert Karwatzki

