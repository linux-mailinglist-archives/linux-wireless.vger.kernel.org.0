Return-Path: <linux-wireless+bounces-37060-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SP6cK28kGGrkeAgAu9opvQ
	(envelope-from <linux-wireless+bounces-37060-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 13:18:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 473A35F12B3
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 13:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A88B2300E2BF
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 11:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4993E3E2AD8;
	Thu, 28 May 2026 11:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="WhNdhIxf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1FD3C3441
	for <linux-wireless@vger.kernel.org>; Thu, 28 May 2026 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779967084; cv=none; b=HkQvypCN9+E5HeSIAZZ0uGRkZLfs4EZm1rioWNXtmAHWgyIZgozSqJRUO66PI1j1RvrQS/fp2k7gQP+kyJxQsfrQJZP4xNUiOCJyJi4GahL8S6412HOdQIWDO9snmKG92+VFwitVhPUSbjjYCu2FE5vcaB1Zx/DPSK6tqUSzlTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779967084; c=relaxed/simple;
	bh=ASzhO9FKUcLXiM6+8+xraqrbGhIBmrmkiraPdCuWD5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2UPTvIO9JijG8RUcq3sQvHGKW+L+dbRr8RDsIzJiedZ8xIUcAPkYWI3R6eFbGcteblZ0ixvvdoGcN5CZD0sZ8Lvc18/yLehTMPYezy4Z+GImAT9GJ60NjD9+B+7Tfam1wPdOfSWDNGbHG8+X6tjdFBGj+wA3Zs8KkjJtTSUaGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=pass smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=WhNdhIxf; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=nk2idK4ScFWdAbrApGHXdwQ2VxxekjPzqX6NVQ1FJIs=; b=WhNdhIxfxcmi9tPkiCdmS7hj2I
	nbtUAWk/wGVczOwC+Xy44xYc5CvmM6l8oua6kcwiWhCrVC7W5SpocBxxf8t2zhLrQDZIUWne5KOa+
	lnZapMRYIUkhrttd7zT2/1cnMOjTU8sy4plWwKDYCA6l8sa6oJj4oQeFl9nWHlk+6Fe4=;
Received: from p200300cadf1ddd00000000000000085c.dip0.t-ipconnect.de ([2003:ca:df1d:dd00::85c] helo=max)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1wSYkR-0027n2-2Q;
	Thu, 28 May 2026 13:17:59 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH wireless v2 4/4] wifi: mac80211: add ieee80211_txq_aql_pending()
Date: Thu, 28 May 2026 11:17:56 +0000
Message-ID: <20260528111756.848243-4-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260528111756.848243-1-nbd@nbd.name>
References: <20260528111756.848243-1-nbd@nbd.name>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nbd.name : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37060-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nbd@nbd.name,linux-wireless@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.913];
	DKIM_TRACE(0.00)[nbd.name:-];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nbd.name:mid,nbd.name:email]
X-Rspamd-Queue-Id: 473A35F12B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a function to allow drivers to query the pending AQL airtime
for a given txq, for both unicast and broadcast.
This will be used for mt76 to limit buffering in AP mode for power-save
stations.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
v2: reorder txq->tid check

 include/net/mac80211.h | 11 +++++++++++
 net/mac80211/tx.c      | 18 ++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 77409e4e28e8..a97d800c2e1f 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6871,6 +6871,17 @@ void ieee80211_sta_register_airtime(struct ieee80211_sta *pubsta, u8 tid,
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
index d1c8398584af..f28419a79da6 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4225,6 +4225,24 @@ bool ieee80211_txq_airtime_check(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL(ieee80211_txq_airtime_check);
 
+u32 ieee80211_txq_aql_pending(struct ieee80211_hw *hw,
+			      struct ieee80211_txq *txq)
+{
+	struct ieee80211_local *local = hw_to_local(hw);
+	struct sta_info *sta;
+
+	if (unlikely(txq->tid == IEEE80211_NUM_TIDS))
+		return 0;
+
+	if (!txq->sta)
+		return atomic_read(&local->aql_bc_pending_airtime);
+
+	sta = container_of(txq->sta, struct sta_info, sta);
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


