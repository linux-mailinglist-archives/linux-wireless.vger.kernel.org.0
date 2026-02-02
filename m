Return-Path: <linux-wireless+bounces-31467-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEcnIFDVgGmFBwMAu9opvQ
	(envelope-from <linux-wireless+bounces-31467-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 17:48:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E446CF224
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 17:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6EBAC3012874
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 16:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EC9279DA2;
	Mon,  2 Feb 2026 16:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfjIvm86"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3DB273D77
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 16:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770050892; cv=none; b=JIUKzyKGz5jTYEQY86a3vctLMUVGIRZ1zzum0mx243ilJF43PFO9BPzYrGsNGG5kVikcuNkWHTyxNw1HVrmR77yeMjUVcAEClFMTw9Qi3eQDfZMfLLawrJGqqmkvLXhuxcs2X+15Paf/h8ADlUxHKkzpPJ8MyJ25ujMRTVfizA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770050892; c=relaxed/simple;
	bh=G43UHDq9M9vlCKWvhbq7QwcmMhxb+KXh+SKRfIfby8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k1+3NjUfpd90zJ7yZYlnDtEXSPCMwwYIzVC3MErk7wkDGCbc+7dy78uCxvdNmNaMOP+tlQjd5g4yK8OuMmTJlEYTcZ1jQeHpIdKUjPTxtHQzf2rDChKylIBKFNz3GpsCP0I/HK+Pc3mcMR3beECTiiNK7Sfo8VfNSDhTuaHUtbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfjIvm86; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59b6f04cae6so4803286e87.2
        for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 08:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770050889; x=1770655689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/lgbVfZ0ZXuhGZYHqBtenLKtCbzR+uHZHCZ0g0Qzccg=;
        b=cfjIvm86d6s8nT1c9obKAIEanD3owbx2IFko9w01Zy/qdgwmn7xPaE/uTHZDUTe4kE
         VY7RLD+sJqNz+d3PllBui/iOVDxOIs7me6QjK1T7hxEwSttLRZc5xqcJX8TpMqsiUfXB
         uq8AnhO36x+TJtxPh7PDjH8Q6CzS5tOQqy3Xfs77+tROY1RySsd7aZXcsrd2HTpB1qrj
         FAdvAi/GSA2tbdCiLMqZa3djkL8RLeSkjdCXKVnQilNXMvBYc1B9ma47CWP1WuPYJ+XR
         cOmlZBu5FnpKBILtWJtS0/7ygfU83fmGG4FHcGy8dS3caslDy+q5N4VHbop4Snppcpx4
         gUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770050889; x=1770655689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lgbVfZ0ZXuhGZYHqBtenLKtCbzR+uHZHCZ0g0Qzccg=;
        b=YzTaxWJ7lyZIe6iH5KiltXYz26xCRXLg3KGCM5L3TPlnLK4MB9eXL0lAvV73CHhqSJ
         A8eLTuEo0hgVM2Jb7o8+JopPRyHlFcHeGscJvjnKhnFlF7LD9M2XSVbTpu26i1ymqvGM
         QYlSCfH6D1yuNaXnvkvfwfAXJegpN8mNri73p5emz1NFzvkEoVMG0tZshY08cbWo7vUS
         7FhbmBH6oqqZRgjHtDTTlpL8wYlyEfhfJjfQIJmbOqWTl6nWHVw1PVVH5VNxB7R0MbA0
         OREBDJxAsHxZpZlJe9TG4j3mxqVfILIINvXdd5MfDClrwCIt54IIuP+Ef+LANYxbqY87
         uoBw==
X-Forwarded-Encrypted: i=1; AJvYcCXHvSGM38+fJDpV+DPucJlRQeHbUe5ItfdIBGhO1amYFfZoJBigPYVZvKDrBWCfYrR2yIKjBFt0qs78bxbj1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzX7POZrON/5U5s+yjVSM0re3Y3s2BlkjWJvOK9KKq5x7FC78IH
	iLhKZZZPx55ztCQGlhlHsfpub4/X4l56my/pyt0x29i9A4lLealqSb2c
X-Gm-Gg: AZuq6aJ0IigqyBD2kmMEEE4nLOXYB7HZrriNpHR3t+4YkM/ygimktdvNu9ch/52zITO
	4V6pdW2d9EaX4RmaC4FZI+I3zDCuADcbMwaIW7vvkfQnGLOEy5txD2W742yd152PSVgGZsLyoYg
	l/VYYfQR6BtNGi3qS3OTeJIv/RJPI8pAvRA0ABJVoBE/kKYEgku6i0+oRzLqTf9evyd8FtX/HkT
	FH/bd9IhN7nMRBdUCPo+SR7jl7f8v2VGtoJVlphVUI1DBNRQ9kY9yrOdzit1cCHmIsh3UUAaBOE
	Sg1yJdK4pTP6fH+ojO11uewPPuTSLCykid9oYZC0pW/Z0apiKOVVVDhP/bWIKm9cHTmuYA04QUV
	VaDxMEYeu/TrsUhiJkv7QTS7xKy2IwbkCAMmOZ8NWBEagVqSGwiMKMiXORbH/Sb/O4ODKYcjYS6
	RLdtss1RCOmfFKGs/1sHkAQ4m/ZMso1P6o1cAWmElUetBEF61XdO/sl6kG+8PGy/Mw1F3hXavxw
	RjwDj6VNg==
X-Received: by 2002:a05:6512:1251:b0:59d:f66b:9451 with SMTP id 2adb3069b0e04-59e16409f73mr4138717e87.20.1770050888698;
        Mon, 02 Feb 2026 08:48:08 -0800 (PST)
Received: from uuba.fritz.box (2001-14ba-6e-3100-2ef5-59d5-c9b3-566.rev.dnainternet.fi. [2001:14ba:6e:3100:2ef5:59d5:c9b3:566])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074819c0sm3569814e87.7.2026.02.02.08.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 08:48:08 -0800 (PST)
From: =?UTF-8?q?Hanne-Lotta=20M=C3=A4enp=C3=A4=C3=A4?= <hannelotta@gmail.com>
To: stable@vger.kernel.org
Cc: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	=?UTF-8?q?Hanne-Lotta=20M=C3=A4enp=C3=A4=C3=A4?= <hannelotta@gmail.com>
Subject: [PATCH 6.6.y] wifi: mac80211: move TDLS work to wiphy work
Date: Mon,  2 Feb 2026 18:47:45 +0200
Message-ID: <20260202164745.215560-1-hannelotta@gmail.com>
X-Mailer: git-send-email 2.53.0.rc2.2.g2258446484
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(1.00)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,vger.kernel.org,intel.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31467-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[hannelotta@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email]
X-Rspamd-Queue-Id: 0E446CF224
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 777b26002b73127e81643d9286fadf3d41e0e477 ]

Again, to have the wiphy locked for it.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
(cherry picked from commit 777b26002b73127e81643d9286fadf3d41e0e477)
Signed-off-by: Hanne-Lotta Mäenpää <hannelotta@gmail.com>
---
 net/mac80211/ieee80211_i.h |  4 ++--
 net/mac80211/mlme.c        |  7 ++++---
 net/mac80211/tdls.c        | 11 ++++++-----
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 44aad3394084..639268d70f96 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -530,7 +530,7 @@ struct ieee80211_if_managed {
 
 	/* TDLS support */
 	u8 tdls_peer[ETH_ALEN] __aligned(2);
-	struct delayed_work tdls_peer_del_work;
+	struct wiphy_delayed_work tdls_peer_del_work;
 	struct sk_buff *orig_teardown_skb; /* The original teardown skb */
 	struct sk_buff *teardown_skb; /* A copy to send through the AP */
 	spinlock_t teardown_lock; /* To lock changing teardown_skb */
@@ -2599,7 +2599,7 @@ int ieee80211_tdls_mgmt(struct wiphy *wiphy, struct net_device *dev,
 			const u8 *extra_ies, size_t extra_ies_len);
 int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 			const u8 *peer, enum nl80211_tdls_operation oper);
-void ieee80211_tdls_peer_del_work(struct work_struct *wk);
+void ieee80211_tdls_peer_del_work(struct wiphy *wiphy, struct wiphy_work *wk);
 int ieee80211_tdls_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 				  const u8 *addr, u8 oper_class,
 				  struct cfg80211_chan_def *chandef);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index aa7cee830b00..78b9206f99f4 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6866,8 +6866,8 @@ void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
 			ieee80211_beacon_connection_loss_work);
 	wiphy_work_init(&ifmgd->csa_connection_drop_work,
 			ieee80211_csa_connection_drop_work);
-	INIT_DELAYED_WORK(&ifmgd->tdls_peer_del_work,
-			  ieee80211_tdls_peer_del_work);
+	wiphy_delayed_work_init(&ifmgd->tdls_peer_del_work,
+				ieee80211_tdls_peer_del_work);
 	wiphy_delayed_work_init(&ifmgd->ml_reconf_work,
 				ieee80211_ml_reconf_work);
 	timer_setup(&ifmgd->timer, ieee80211_sta_timer, 0);
@@ -7881,7 +7881,8 @@ void ieee80211_mgd_stop(struct ieee80211_sub_if_data *sdata)
 			  &ifmgd->beacon_connection_loss_work);
 	wiphy_work_cancel(sdata->local->hw.wiphy,
 			  &ifmgd->csa_connection_drop_work);
-	cancel_delayed_work_sync(&ifmgd->tdls_peer_del_work);
+	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
+				  &ifmgd->tdls_peer_del_work);
 	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
 				  &ifmgd->ml_reconf_work);
 
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index f3cdbd2133f6..0fd353fec9fc 100644
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
@@ -1224,9 +1224,9 @@ ieee80211_tdls_mgmt_setup(struct wiphy *wiphy, struct net_device *dev,
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
@@ -1526,7 +1526,8 @@ int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	if (ret == 0 && ether_addr_equal(sdata->u.mgd.tdls_peer, peer)) {
-		cancel_delayed_work(&sdata->u.mgd.tdls_peer_del_work);
+		wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
+					  &sdata->u.mgd.tdls_peer_del_work);
 		eth_zero_addr(sdata->u.mgd.tdls_peer);
 	}
 
-- 
2.53.0.rc2.2.g2258446484


