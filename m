Return-Path: <linux-wireless+bounces-32742-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAf4Be5jrmlbCwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32742-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 07:08:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 652012341A6
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 07:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF6AE3044A6A
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 06:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A789C355F2B;
	Mon,  9 Mar 2026 06:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="OAZVumyf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D6D34EF0E
	for <linux-wireless@vger.kernel.org>; Mon,  9 Mar 2026 06:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773036466; cv=none; b=EnCEU5ctAJIBmLttMt6YQRbZdgxHUfaTf/fAfXUu2KvYEyPg/VLYwa56Sv7YgD0FVMC1bOxFNMK+TyqslEBXRDhtWFUISNqirORC7IjO6ny1I9m/csyP4EP96KTsg9Bwtc23JpEHEzCQCJ15DztQRR4zHLrJPOiWC53QUjkxs1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773036466; c=relaxed/simple;
	bh=HRbbPhMbca9rSize5eZ8Vt3S+OfXJRKfVUEemjwNIRE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQLAI0ifG2Hpt73V2tsUVZR498Yd6s9xvxAoO0T3v7xuOBDBg2G7bOFSHlWkbjaw94j8zW5w/FlPj/Mo0o10TAVHzOPMk+sJViZFa6xvp2TdGC4zBmhxt8hBDraObem/96mKk6XZsyiREbanWbvtEeo+jZ+SQUfbwTvMLoqPo5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=pass smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=OAZVumyf; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kQ89lZlXr0bBg4S3BZwjxHCpODnOI6f5KIWBSJgoXhU=; b=OAZVumyfIaaLJRCt9OQ0Tt6vPo
	gL66816udjz5+HJf882lDYvVXOBhwd9UyIk65i5HOrT5hFWTAsE1d1I2askvWtG/GIDbB/QJ58fnj
	WOCnEiWaeyDeO6V1oLVIEgUQ3EsVUW1RCuYv+MXGi07ynCJkevgzCNXZdJFEOmxOobXA=;
Received: from p200300cadf236500000000000000085c.dip0.t-ipconnect.de ([2003:ca:df23:6500::85c] helo=max)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1vzTmD-00GH43-1l
	for linux-wireless@vger.kernel.org;
	Mon, 09 Mar 2026 07:07:37 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH mt76 08/11] wifi: mt76: flush pending TX before channel switch
Date: Mon,  9 Mar 2026 06:07:27 +0000
Message-ID: <20260309060730.87840-8-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260309060730.87840-1-nbd@nbd.name>
References: <20260309060730.87840-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 652012341A6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nbd.name:s=20160729];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nbd.name : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32742-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nbd@nbd.name,linux-wireless@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.555];
	DKIM_TRACE(0.00)[nbd.name:-];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nbd.name:mid,nbd.name:email]
X-Rspamd-Action: no action

mt76_tx() queues frames on wcid->tx_pending for async processing by
tx_worker. In __mt76_set_channel(), the worker gets disabled before it
may have run, and the subsequent wait only checks DMA ring queues, not
the software pending list. This means frames like nullfunc PS frames
from mt76_offchannel_notify() may never be transmitted on the correct
channel.

Fix this by running mt76_txq_schedule_pending() synchronously after
disabling the tx_worker but before setting MT76_RESET, which would
otherwise cause mt76_txq_schedule_pending_wcid() to bail out.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 5 +++--
 drivers/net/wireless/mediatek/mt76/mt76.h     | 1 +
 drivers/net/wireless/mediatek/mt76/tx.c       | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index e6315d35c683..51fe696c9825 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1031,9 +1031,10 @@ int __mt76_set_channel(struct mt76_phy *phy, struct cfg80211_chan_def *chandef,
 	int timeout = HZ / 5;
 	int ret;
 
-	set_bit(MT76_RESET, &phy->state);
-
 	mt76_worker_disable(&dev->tx_worker);
+	mt76_txq_schedule_pending(phy);
+
+	set_bit(MT76_RESET, &phy->state);
 	wait_event_timeout(dev->tx_wait, !mt76_has_tx_pending(phy), timeout);
 	mt76_update_survey(phy);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index bafbc1747673..fe4f30ea71da 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1525,6 +1525,7 @@ void mt76_stop_tx_queues(struct mt76_phy *phy, struct ieee80211_sta *sta,
 void mt76_tx_check_agg_ssn(struct ieee80211_sta *sta, struct sk_buff *skb);
 void mt76_txq_schedule(struct mt76_phy *phy, enum mt76_txq_id qid);
 void mt76_txq_schedule_all(struct mt76_phy *phy);
+void mt76_txq_schedule_pending(struct mt76_phy *phy);
 void mt76_tx_worker_run(struct mt76_dev *dev);
 void mt76_tx_worker(struct mt76_worker *w);
 void mt76_release_buffered_frames(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 0753acf2eccb..ab62591b7a26 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -660,7 +660,7 @@ mt76_txq_schedule_pending_wcid(struct mt76_phy *phy, struct mt76_wcid *wcid,
 	return ret;
 }
 
-static void mt76_txq_schedule_pending(struct mt76_phy *phy)
+void mt76_txq_schedule_pending(struct mt76_phy *phy)
 {
 	LIST_HEAD(tx_list);
 	int ret = 0;
-- 
2.51.0


