Return-Path: <linux-wireless+bounces-33703-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bo6XATUUwWn5QQQAu9opvQ
	(envelope-from <linux-wireless+bounces-33703-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 11:21:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DFD2EFEA4
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 11:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 05CC6301A785
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 10:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D667E38C2D6;
	Mon, 23 Mar 2026 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="liU8qiUF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DBE38C2CB
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774261200; cv=none; b=DvvQhuCWPZPbi6EQcRR3/sPX3RlnsyyXzHY1ftH9r/s8S788FdjoEXNgAVaZvaMh2+D9beeeHAH4l3+AUsccRuyg5F76YJBGUxtiCMiKAdfSNW3ZUv2xKMggNYQpXKKearrOzr1hqvimhzCEVIYPBbeyInoh8p0FsEen8BhL5As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774261200; c=relaxed/simple;
	bh=dbaKmG2ANXhyHY7FCI7AhyzwFpCbQlZ6m1inmrnu2lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYHu0rG5apK5WobaU8IVLpAB8RpvJraVAUdMv3BsTpRtd9V5v7jiQUgySdWqmFaLileO418Qg3fvxbmwt80Ppz969rUct2EeMuU6n47vTajIUol8IX581fpXkTnbB47VW2qPLRU9MXWi1x5uhJiD9MQKWaqxIwe2zQLw00/i+uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=pass smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=liU8qiUF; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9ywU1c6L3nI8WNK+EgdGI248n9WSTmYSnLtiG60Hx2s=; b=liU8qiUFW527eifsyqyqNd8ba4
	CxBL1zjnWCQf6Fh8NTqp/uuVyWCtNDC3ZzyIBBOb/PIwqaeE6emuf7+jMBC7ZNeLvonS1MTTmHAL7
	FxlqJ5EbyEpFr4R+p7m/CjjTsjO3vYcHP4D0fTVso21CTD7MxW/M5iT3iH1Q/2mtejOQ=;
Received: from p200300cadf30ee00000000000000085c.dip0.t-ipconnect.de ([2003:ca:df30:ee00::85c] helo=max)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1w4cO5-00ALUX-10;
	Mon, 23 Mar 2026 11:19:57 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH 4/4] wifi: mac80211: add ieee80211_txq_aql_pending()
Date: Mon, 23 Mar 2026 10:19:54 +0000
Message-ID: <20260323101954.874299-4-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260323101954.874299-1-nbd@nbd.name>
References: <20260323101954.874299-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nbd.name:s=20160729];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nbd.name : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33703-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nbd@nbd.name,linux-wireless@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.806];
	DKIM_TRACE(0.00)[nbd.name:-];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 91DFD2EFEA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a function to allow drivers to query the pending AQL airtime
for a given txq, for both unicast and broadcast.
This will be used for mt76 to limit buffering in AP mode for power-save
stations.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/mac80211.h | 11 +++++++++++
 net/mac80211/tx.c      | 18 ++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 310546d4fca6..f260017cc858 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6710,6 +6710,17 @@ void ieee80211_sta_register_airtime(struct ieee80211_sta *pubsta, u8 tid,
 bool
 ieee80211_txq_airtime_check(struct ieee80211_hw *hw, struct ieee80211_txq *txq);
 
+/**
+ * ieee80211_txq_aql_pending - get pending AQL airtime for a txq
+ *
+ * @hw: pointer obtained from ieee80211_alloc_hw()
+ * @txq: pointer obtained from station or virtual interface
+ *
+ * Return: pending airtime (in usec) for the given txq.
+ */
+u32 ieee80211_txq_aql_pending(struct ieee80211_hw *hw,
+			      struct ieee80211_txq *txq);
+
 /**
  * ieee80211_iter_keys - iterate keys programmed into the device
  * @hw: pointer obtained from ieee80211_alloc_hw()
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 04a3ea9beae5..07a65e14d637 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4185,6 +4185,24 @@ bool ieee80211_txq_airtime_check(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL(ieee80211_txq_airtime_check);
 
+u32 ieee80211_txq_aql_pending(struct ieee80211_hw *hw,
+			      struct ieee80211_txq *txq)
+{
+	struct ieee80211_local *local = hw_to_local(hw);
+	struct sta_info *sta;
+
+	if (!txq->sta)
+		return atomic_read(&local->aql_bc_pending_airtime);
+
+	sta = container_of(txq->sta, struct sta_info, sta);
+
+	if (unlikely(txq->tid == IEEE80211_NUM_TIDS))
+		return 0;
+
+	return atomic_read(&sta->airtime[txq->ac].aql_tx_pending);
+}
+EXPORT_SYMBOL(ieee80211_txq_aql_pending);
+
 static bool
 ieee80211_txq_schedule_airtime_check(struct ieee80211_local *local, u8 ac)
 {
-- 
2.51.0


