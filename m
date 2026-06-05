Return-Path: <linux-wireless+bounces-37418-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZcIzHOrBImondQEAu9opvQ
	(envelope-from <linux-wireless+bounces-37418-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 14:32:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 037FB6482E9
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 14:32:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=nbd.name header.s=20160729 header.b=UXL5Wknd;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37418-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37418-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=nbd.name (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D67D3023047
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2026 12:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A57B3876B0;
	Fri,  5 Jun 2026 12:31:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116601CEAC2
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jun 2026 12:31:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780662663; cv=none; b=ovmU8/QE0bQkjobPXbyRcOO6xqc8Gj2WPbA+frL31t6aHq29pT2v+T8bSdM8hrEWv7AUdlqwx0eOFnoDMQN8eN6n9mzHi5AYjkFHzAdVorRhZaJR1sMQZK/7mBbS8zOolgRQMF98wW1nv1cAGdsPpfSqyGdN6giJeg6/Xlyl+bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780662663; c=relaxed/simple;
	bh=KvORtdao10zVrBEVWBv8LaVkBQAhMqJYa6/XWRqMfbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXOSp7eft4lrmrUXwwYTzzHY1V5QRfjM51j5O0tB0t59W69UP8dx1wluMO0FKsX/oM8CrJzoD1HVB9UzkN8TaoTHrb/UjLdfX+sSQCT+GqRqENnypcgBxZ2GT+o5uszhJLiKZPOdMxaF49rsbiP0DV7HQRlT51b4KOvRpK2nWLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=pass smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=UXL5Wknd; arc=none smtp.client-ip=46.4.11.11
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=jdg6tr3ZGDfzADuFmjNsgstUtQjlO+7dbOdU86wUuis=; b=UXL5WkndeAOG/LOKfVfqeFZzZL
	/raH4G2TYZ+pyqOTB3RanLw3hIaQsreAq2q09rmgyVxp527AvYhPxO6p3qzjTEm/KzTDww0twXocH
	oipXFiUPJC3b+YKOoYzOEJwp60IauB1G3EAjEOPKxKRTLI/lyyqtzmKmepUPE3u+zmwE=;
Received: from p200300cadf03d5009ebf0dfffe00fa2d.dip0.t-ipconnect.de ([2003:ca:df03:d500:9ebf:dff:fe00:fa2d] helo=max)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1wVThO-0090er-2E;
	Fri, 05 Jun 2026 14:30:54 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH wireless-next v3 4/4] wifi: mac80211: add ieee80211_txq_aql_pending()
Date: Fri,  5 Jun 2026 12:30:49 +0000
Message-ID: <20260605123049.1128869-4-nbd@nbd.name>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605123049.1128869-1-nbd@nbd.name>
References: <20260605123049.1128869-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[nbd.name:s=20160729];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nbd.name : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37418-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:johannes@sipsolutions.net,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nbd@nbd.name,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[nbd.name:-];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nbd@nbd.name,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nbd.name:mid,nbd.name:from_mime,nbd.name:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 037FB6482E9

Add a function to allow drivers to query the pending AQL airtime
for a given txq, for both unicast and broadcast.
This will be used for mt76 to limit buffering in AP mode for power-save
stations.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
v2: reorder txq->tid check
v3: fix compile error - adjust for changes in previous patch

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
index d1c8398584af..fdfbc92ecdeb 100644
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
+		return atomic_read(&local->aql_mc_pending_airtime);
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
2.53.0


