Return-Path: <linux-wireless+bounces-31469-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJvVJcbWgGmFBwMAu9opvQ
	(envelope-from <linux-wireless+bounces-31469-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 17:54:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D3CCF385
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 17:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC5F8304031E
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 16:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185943803D1;
	Mon,  2 Feb 2026 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPPziV2+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022F73806B8
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770050999; cv=none; b=guK+5ijHQZa38eoPLuWNjf4RdiPzvqvKa6HmEc1xc2ZEr/1+uPRonY27PbhrLYy4D/OMlWI7R0xdKb7d0kSqxTEF9Olhc/kAdAnjh/gdH58VCDg5kV0dYY9M428nEXKZwRKqvBbOoVG2UL+5bkLdRlvOu/9EUQQA4jwno1fkh2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770050999; c=relaxed/simple;
	bh=jhN+YleJ9I8wkZB6e165Fsm08eZT4j05sZ9wxNMGoE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K3sFEa/sEXAwsG8fgxYZ3xlk1q8qjGC74jOSRr4UHcsVh1UP7D6CEyyT2xeChTUwhMHDW0zP3dsc/JXGR7hnQAYatuiJqZtBFcaEwWWktLFIwG6LlB0JY0zzKxZjWQ+TYHD5qoabcWL4DwTbknRvMCgjGR8rg/yp9udpeWcb66s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPPziV2+; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59b6f267721so4237846e87.2
        for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 08:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770050994; x=1770655794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXhgxcsuPkNcRdWC6jKl2Ki9gol6dqqET4szBsmvqSc=;
        b=lPPziV2+8KqpvVW4SSYqUvubwR55ZB7NbvQJkcT8WqbHMBodB/OqWVecJjQL2hLYvh
         vAsgNnJlpQEsFGdGdwgxb12Uz89qaK0a+Zj8wzsoCFE8s/GjyEcYUjTWVnEYDsnXgz1M
         lM5YHURR/DErrpnQXzoHF7YkmD13v4ZumEJQ3qixrJl9xBx7fU1m49LYGDJbmi+ojVEz
         EcU5PefYFBE0jnT4ND5xFQ4iNBmOAyaDcFw4PHqKp0PiTnCk5vd+iHTi4x89nFfvCJVf
         s6N6DmeBEy1ph+M1Gp2Oa9TJ7DKH4g3juujiqrWuS2ZfSCiNavx3pG5s5yEnnqXvelqi
         d7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770050994; x=1770655794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fXhgxcsuPkNcRdWC6jKl2Ki9gol6dqqET4szBsmvqSc=;
        b=eRm/DdSzXI+2o3h7VZvR5tp9F5wjaZpo8SWFpPtcnh+bB0rPCuMDZC89sgOwcAC3bL
         xtBl4FPMH10UBeLl7NcpoNkVR9/jGEyFT8MBTBKbQij7RR2Z5xSp0DWWAv/W/P+GcDDU
         ea+IbX5c3fw4Ub1ciHJCZxCvwfgvSUQsvfc0nVnIW6fqXvezihatu2D5hZIRyhJKFsSE
         uMbeCXqQ+E9RN/s1JZbmKYij3MV3hx9QKW9hQYbagSOynlZ4IARQQeL/JkUOOhvbwJGx
         8mSyK6FAxOyQc1Pqmcld67gLzIFGByH9UsqEx6YEDoqx06VIJJQsXYe0G4c8tfZXnuCh
         TlUg==
X-Forwarded-Encrypted: i=1; AJvYcCXSJ26dmu18GI0P0cOOVA67/zFD8i7wsrqoyNBKU0LfdrkFdg8VjhBA3PXeTZnFYSWUv7a7eMx2MFXUqIxbXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHAgKqgaQ1UdbGhOJIILE7zy8r8nNPfcqXc2yIj4bDNSnU+TUC
	YMoqdVMHibAgQGHp/may4h2J3po5oeNvGdGK2QPQ4gLoC4XS9Pft+r9P
X-Gm-Gg: AZuq6aIztC4vJw8BTk/GAcq9grVWoJcP1RQ1k6ubeXO3mbwGGTUaOpIjM0rL0Pisga4
	BBnPn1Bp/dUYo3EmOprfb32q1vkOKQdz5VTlu7skZ4eIySJhHlORdRyiOS2BXWC7ZPqg+Q0iAUb
	UIwSDfNLlC58jwSVALc75i1pahHVRNepX+uVkMVBiyIMItxjlq9QydgudTDEjydFPdTjzE3KLy2
	nboDYFDl5LPXMcyzA3qnthiqedCIRKWcW1MDDhSApXJFA8FdqqcqLlbjjzAatJ5+Pk8kffYXwhX
	0dhIqYijMpuP5XZkFLlrsQ3taAGRcMi++NFsTbeKepZG4fGiFOmHv8Bfxn0dR3Xy5/tXM2qBH9N
	MojP5NguSmLBhQA82ZJR0e/difZCD3jcNfvUBm70nL/kpN5I4MzvlFoK8cOuoY/StkCTyQ0pqI4
	rkXIhzcX8taI+P3azXaFu+59FUr0i9WNIZJJGeflIincKcfCoheAoF1n6jJpmIksVNd5nb8jpy0
	zZxUCvdrw==
X-Received: by 2002:ac2:4f07:0:b0:59e:2c7a:1ae0 with SMTP id 2adb3069b0e04-59e2c7a1b1dmr780344e87.13.1770050994021;
        Mon, 02 Feb 2026 08:49:54 -0800 (PST)
Received: from uuba.fritz.box (2001-14ba-6e-3100-2ef5-59d5-c9b3-566.rev.dnainternet.fi. [2001:14ba:6e:3100:2ef5:59d5:c9b3:566])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074b7092sm3598268e87.71.2026.02.02.08.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 08:49:53 -0800 (PST)
From: =?UTF-8?q?Hanne-Lotta=20M=C3=A4enp=C3=A4=C3=A4?= <hannelotta@gmail.com>
To: stable@vger.kernel.org
Cc: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	=?UTF-8?q?Hanne-Lotta=20M=C3=A4enp=C3=A4=C3=A4?= <hannelotta@gmail.com>
Subject: [PATCH 6.1.y 2/2] wifi: mac80211: move TDLS work to wiphy work
Date: Mon,  2 Feb 2026 18:49:24 +0200
Message-ID: <20260202164924.215621-2-hannelotta@gmail.com>
X-Mailer: git-send-email 2.53.0.rc2.2.g2258446484
In-Reply-To: <20260202164924.215621-1-hannelotta@gmail.com>
References: <20260202164924.215621-1-hannelotta@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,vger.kernel.org,intel.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31469-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[hannelotta@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 52D3CCF385
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
index 6cc5bba2ba52..e94a370da4c4 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -531,7 +531,7 @@ struct ieee80211_if_managed {
 
 	/* TDLS support */
 	u8 tdls_peer[ETH_ALEN] __aligned(2);
-	struct delayed_work tdls_peer_del_work;
+	struct wiphy_delayed_work tdls_peer_del_work;
 	struct sk_buff *orig_teardown_skb; /* The original teardown skb */
 	struct sk_buff *teardown_skb; /* A copy to send through the AP */
 	spinlock_t teardown_lock; /* To lock changing teardown_skb */
@@ -2525,7 +2525,7 @@ int ieee80211_tdls_mgmt(struct wiphy *wiphy, struct net_device *dev,
 			size_t extra_ies_len);
 int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 			const u8 *peer, enum nl80211_tdls_operation oper);
-void ieee80211_tdls_peer_del_work(struct work_struct *wk);
+void ieee80211_tdls_peer_del_work(struct wiphy *wiphy, struct wiphy_work *wk);
 int ieee80211_tdls_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 				  const u8 *addr, u8 oper_class,
 				  struct cfg80211_chan_def *chandef);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 8824460a2060..30db27df6b79 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6517,8 +6517,8 @@ void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
 		  ieee80211_beacon_connection_loss_work);
 	INIT_WORK(&ifmgd->csa_connection_drop_work,
 		  ieee80211_csa_connection_drop_work);
-	INIT_DELAYED_WORK(&ifmgd->tdls_peer_del_work,
-			  ieee80211_tdls_peer_del_work);
+	wiphy_delayed_work_init(&ifmgd->tdls_peer_del_work,
+				ieee80211_tdls_peer_del_work);
 	timer_setup(&ifmgd->timer, ieee80211_sta_timer, 0);
 	timer_setup(&ifmgd->bcn_mon_timer, ieee80211_sta_bcn_mon_timer, 0);
 	timer_setup(&ifmgd->conn_mon_timer, ieee80211_sta_conn_mon_timer, 0);
@@ -7524,7 +7524,8 @@ void ieee80211_mgd_stop(struct ieee80211_sub_if_data *sdata)
 	cancel_work_sync(&ifmgd->monitor_work);
 	cancel_work_sync(&ifmgd->beacon_connection_loss_work);
 	cancel_work_sync(&ifmgd->csa_connection_drop_work);
-	cancel_delayed_work_sync(&ifmgd->tdls_peer_del_work);
+	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
+				  &ifmgd->tdls_peer_del_work);
 
 	sdata_lock(sdata);
 	if (ifmgd->assoc_data)
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index 04531d18fa93..1f07b598a6a1 100644
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
@@ -1128,9 +1128,9 @@ ieee80211_tdls_mgmt_setup(struct wiphy *wiphy, struct net_device *dev,
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
@@ -1427,7 +1427,8 @@ int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	if (ret == 0 && ether_addr_equal(sdata->u.mgd.tdls_peer, peer)) {
-		cancel_delayed_work(&sdata->u.mgd.tdls_peer_del_work);
+		wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
+					  &sdata->u.mgd.tdls_peer_del_work);
 		eth_zero_addr(sdata->u.mgd.tdls_peer);
 	}
 
-- 
2.53.0.rc2.2.g2258446484


