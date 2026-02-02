Return-Path: <linux-wireless+bounces-31472-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJEiIx/WgGmFBwMAu9opvQ
	(envelope-from <linux-wireless+bounces-31472-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 17:51:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EFECF2D3
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 17:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C7F29301C30D
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 16:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507003806B4;
	Mon,  2 Feb 2026 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngpCQtK2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39B43815C4
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051083; cv=none; b=PzkAALdLwJ1xtPNAg8yDzGco2pcUuZxRYoxwmHiP6DwbPdtscoIXdJ4OrHVdfHT+Vd4HTzwMxok9gJ6qFqtcwl7PSOybJEDHJU4rGZbRJzm7R9GJTb7qX3US5+vPkO2y5DO0J56yC9bnhzK0a+emLoZNz/BetcX2YqC/6dclqDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051083; c=relaxed/simple;
	bh=+GZw2Ccyjs1GXRaOEe4tVxx0eiLCzS5WfrugO8sPmYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pcAvQzQvxYjWB7NCgARsIWBiWUh8Mj6ZoxpvVCOdxLO3GRAHiqdHO4TrkpBH7FKZLvFqv1Gs+QsvKKeVXXMP/7tt1EE/YC0QN1+eFMzIM7I2DQxhbB2z+qyoaHf7UzINxRiLmwvHl6CLLPGAgYKLsix3+P15jZeTYzU2Lr/w8fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngpCQtK2; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-385e7cafef9so37377551fa.0
        for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 08:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770051080; x=1770655880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCxKVpaSPMMkHK5YK3mSbB1f6oAthOa/gt2SpSMaGpQ=;
        b=ngpCQtK24yeuqk853Lz+/lC99Yk7GXQ0d7lFQ6olKJjCorE4nGvT44IhxU6O2o88H+
         BalnmIm7SUuvPbiBUxyTMj/sfCERwHcuR7M/BDyAvl5gIyZ3rO7l4ar5GPU5xrbqt0vr
         9TDOcyuwUhbH7gSB+3JKGcm6dMhvIJt9rBktBOq+ya5iBw6pRDv0SFJbgwH5cNe9ONyN
         IMNPOd9M86jdwKpjctJUcQjvVWIx/se74+GMEwSttlMgpjj3fAW//RjdLvcodIT4qEbd
         87bJbiwu3LYSvVsM3cqJjX+qHWRTyBEwGe1imWiugoou33llfJUvvq/ps+3PkYzZOui/
         HBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770051080; x=1770655880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WCxKVpaSPMMkHK5YK3mSbB1f6oAthOa/gt2SpSMaGpQ=;
        b=vg0c6rRC30Kz1QJxyNa+osGc/KvAQi6PWuUYBUQOqVlq/sYKpVzmc9OtgwBIqwyhbF
         fRNM+41eKsyiw9nSWbMnX6S01OE2ItjDUHmfdPQFb1PmRnKyL4XkZYMFpsH8bx2cWfKV
         qpA9NaRM9NYA6hYUSDD3Uw3OBeeZoqcC+tJ1ugoT9FwhpKCmrKSGGIxPtH8hk46OHsZx
         FKMY/4vxIYbuvNfBYAPoKhV26wGj24y70NYkn4ELFsF3BrBsdhYkQTv+N2Q/typjLn6/
         0NOQFNSx5OtwCSSttz7N2h/gEtvR8eiMvZ8l5nBRpZMUlR/KLfsrBWSuMknQJIDzqVwX
         Sp2w==
X-Forwarded-Encrypted: i=1; AJvYcCUOF5heOhYutieGh39ymsv2hSvT5fAD4dwmw+smGba3gmOPAD7fkQyrjGQyH/NcBDxm24McJqx4uJuBFap1dA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3kt7YV0wihxBXqZr2Ib6jvFG1TTjjCGJomc3szul6BfLQYiIp
	xFWL05xK+bx4Q2kvuKyfkvD4Sql5FKnPB4HZcijG8Ms7S6VfLYaYvexg
X-Gm-Gg: AZuq6aJ2QOMva7+fktNxVKcMRZJOAAjy3Vy/Pp40/l5gvWwjY83h3NAYl+PIuWzBS/L
	x6gTlhnInF/5YNZkhOCKM1ltg8+2wrobZxfMaM58+MjL8kO6se3VLZ0kzgjhbjv8BP1jcWeXz0P
	+Z0psd3AAtmmGSzD8kywxFCZ8iG3Qy9+kMQMEKUpNQUxb/cfytNIMbKSLMyFk+gHBmfjE2sga+f
	04NU1jhEO94+ogSlEFzb8HdqROvZ/RV6e5tIXm5U1KRkgHs57u61aBmYJ8MxIRgUqS3MVTNurV/
	/ggg6n71ntyTf+5nR1QrXCL+/CTMuCHXZB1NRU8z6YNkNHLcHQdMpqoVR7WV+Sd74iVj30MGxNN
	I4uBlwhkVSd7ry5TcVmaLPQzqogAot4fCt1oAxs/vps2gaHtGAcHDirEhu6UrFQhp07dsc0+3wG
	Ncu0wbaMek/tGah7CgbQHJ3BmNrZfbqLrjtEI7ho60j0xGhBpc5GdWuQUAQOBIcljTmtO0GdXfZ
	jti1t8QryQYNnkLTNzC
X-Received: by 2002:a2e:b8cd:0:b0:383:210a:7b2c with SMTP id 38308e7fff4ca-386466fb2famr41766161fa.44.1770051079638;
        Mon, 02 Feb 2026 08:51:19 -0800 (PST)
Received: from uuba.fritz.box (2001-14ba-6e-3100-2ef5-59d5-c9b3-566.rev.dnainternet.fi. [2001:14ba:6e:3100:2ef5:59d5:c9b3:566])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38625ad8ae0sm31718571fa.0.2026.02.02.08.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 08:51:19 -0800 (PST)
From: =?UTF-8?q?Hanne-Lotta=20M=C3=A4enp=C3=A4=C3=A4?= <hannelotta@gmail.com>
To: stable@vger.kernel.org
Cc: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	=?UTF-8?q?Hanne-Lotta=20M=C3=A4enp=C3=A4=C3=A4?= <hannelotta@gmail.com>
Subject: [PATCH 5.15.y 3/3] wifi: mac80211: move TDLS work to wiphy work
Date: Mon,  2 Feb 2026 18:50:38 +0200
Message-ID: <20260202165038.215693-3-hannelotta@gmail.com>
X-Mailer: git-send-email 2.53.0.rc2.2.g2258446484
In-Reply-To: <20260202165038.215693-1-hannelotta@gmail.com>
References: <20260202165038.215693-1-hannelotta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.28 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.88)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,vger.kernel.org,intel.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31472-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[hannelotta@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 30EFECF2D3
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 777b26002b73127e81643d9286fadf3d41e0e477 ]

Again, to have the wiphy locked for it.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[ Summary of conflict resolutions:
  - In mlme.c, move only tdls_peer_del_work
    to wiphy work, and none the other works ]
Signed-off-by: Hanne-Lotta Mäenpää <hannelotta@gmail.com>
---
 net/mac80211/ieee80211_i.h |  4 ++--
 net/mac80211/mlme.c        |  7 ++++---
 net/mac80211/tdls.c        | 11 ++++++-----
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 8d6616f646e7..306359d43571 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -542,7 +542,7 @@ struct ieee80211_if_managed {
 
 	/* TDLS support */
 	u8 tdls_peer[ETH_ALEN] __aligned(2);
-	struct delayed_work tdls_peer_del_work;
+	struct wiphy_delayed_work tdls_peer_del_work;
 	struct sk_buff *orig_teardown_skb; /* The original teardown skb */
 	struct sk_buff *teardown_skb; /* A copy to send through the AP */
 	spinlock_t teardown_lock; /* To lock changing teardown_skb */
@@ -2494,7 +2494,7 @@ int ieee80211_tdls_mgmt(struct wiphy *wiphy, struct net_device *dev,
 			size_t extra_ies_len);
 int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 			const u8 *peer, enum nl80211_tdls_operation oper);
-void ieee80211_tdls_peer_del_work(struct work_struct *wk);
+void ieee80211_tdls_peer_del_work(struct wiphy *wiphy, struct wiphy_work *wk);
 int ieee80211_tdls_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 				  const u8 *addr, u8 oper_class,
 				  struct cfg80211_chan_def *chandef);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index d147760e8389..25468d5e874a 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4890,8 +4890,8 @@ void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
 	INIT_WORK(&ifmgd->csa_connection_drop_work,
 		  ieee80211_csa_connection_drop_work);
 	INIT_WORK(&ifmgd->request_smps_work, ieee80211_request_smps_mgd_work);
-	INIT_DELAYED_WORK(&ifmgd->tdls_peer_del_work,
-			  ieee80211_tdls_peer_del_work);
+	wiphy_delayed_work_init(&ifmgd->tdls_peer_del_work,
+				ieee80211_tdls_peer_del_work);
 	timer_setup(&ifmgd->timer, ieee80211_sta_timer, 0);
 	timer_setup(&ifmgd->bcn_mon_timer, ieee80211_sta_bcn_mon_timer, 0);
 	timer_setup(&ifmgd->conn_mon_timer, ieee80211_sta_conn_mon_timer, 0);
@@ -6010,7 +6010,8 @@ void ieee80211_mgd_stop(struct ieee80211_sub_if_data *sdata)
 	cancel_work_sync(&ifmgd->request_smps_work);
 	cancel_work_sync(&ifmgd->csa_connection_drop_work);
 	cancel_work_sync(&ifmgd->chswitch_work);
-	cancel_delayed_work_sync(&ifmgd->tdls_peer_del_work);
+	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
+				  &ifmgd->tdls_peer_del_work);
 
 	sdata_lock(sdata);
 	if (ifmgd->assoc_data) {
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index 137be9ec94af..c2d7479c119a 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -21,7 +21,7 @@
 /* give usermode some time for retries in setting up the TDLS session */
 #define TDLS_PEER_SETUP_TIMEOUT	(15 * HZ)
 
-void ieee80211_tdls_peer_del_work(struct work_struct *wk)
+void ieee80211_tdls_peer_del_work(struct wiphy *wiphy, struct wiphy_work *wk)
 {
 	struct ieee80211_sub_if_data *sdata;
 	struct ieee80211_local *local;
@@ -1126,9 +1126,9 @@ ieee80211_tdls_mgmt_setup(struct wiphy *wiphy, struct net_device *dev,
 		return ret;
 	}
 
-	ieee80211_queue_delayed_work(&sdata->local->hw,
-				     &sdata->u.mgd.tdls_peer_del_work,
-				     TDLS_PEER_SETUP_TIMEOUT);
+	wiphy_delayed_work_queue(sdata->local->hw.wiphy,
+				 &sdata->u.mgd.tdls_peer_del_work,
+				 TDLS_PEER_SETUP_TIMEOUT);
 	return 0;
 
 out_unlock:
@@ -1425,7 +1425,8 @@ int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	if (ret == 0 && ether_addr_equal(sdata->u.mgd.tdls_peer, peer)) {
-		cancel_delayed_work(&sdata->u.mgd.tdls_peer_del_work);
+		wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
+					  &sdata->u.mgd.tdls_peer_del_work);
 		eth_zero_addr(sdata->u.mgd.tdls_peer);
 	}
 
-- 
2.53.0.rc2.2.g2258446484


