Return-Path: <linux-wireless+bounces-15325-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B78B9CDE3A
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 13:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0337D1F21920
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 12:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774B01B2195;
	Fri, 15 Nov 2024 12:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="gv1bfRIR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7850C1A3035
	for <linux-wireless@vger.kernel.org>; Fri, 15 Nov 2024 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731673607; cv=none; b=if3CIns8eYwBQSlo9W92TAX+d8dKz7Dwo0TRDwDJnxmMkgQbdM6MqdxaOq3B9fjbnu5F0I8VKrG+m8IpaqtSI3TigYIKnZSfuOyAeXBeGuWK0dCbIRzx9Uajtmtk1tQuEBqyQUbW0pe7eF5UKo0/i+z+O8plIDIrDl+8HNO3wQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731673607; c=relaxed/simple;
	bh=zK/gBPIfrVwkQqupyvcan+fwZGCtuc/pTr/BrdVlrWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fSPvKa7P/z7rPgpEuyMMOnTOZoiLhfKtvTdDm+2H8CM+Kj+ScvN6clwfQuhBj9O3xeEe6/qC/oRjh6RD64iYmKfygqGgXrz3h6AONRiITZSU9KhAgN0V5uTnBGjwZb0a7t8kTB69oTxS2Zqdpavj9rXR4IWsZFBf0YgLzFmX2/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=gv1bfRIR; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=khAASZaDv9hYkam4PTNQ47g8zgtNGqn0oXBf136erdk=; b=gv1bfRIReEGVH1sBrbuVY5cFu+
	mWh8+3KgQsQrLr/syZYj2NeRnST2zEJ/3Ll5dmO8D5YDJqLc88fYMovK75s1cpmJZoL4dYU5ooglo
	jzrKNhZEDH69Bk5ALboCzkX2vLosIeViT+vxOe7CqiPfHXMvit/1FP4O0kXeeU3t7lfc=;
Received: from p4ff1321f.dip0.t-ipconnect.de ([79.241.50.31] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tBuyR-008302-0g;
	Fri, 15 Nov 2024 12:58:51 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	syzbot+9ea265d998de25ac6a46@syzkaller.appspotmail.com
Subject: [PATCH] wifi: mac80211: fix vif addr when switching from monitor to station
Date: Fri, 15 Nov 2024 12:58:50 +0100
Message-ID: <20241115115850.37449-1-nbd@nbd.name>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since adding support for opting out of virtual monitor support, a zero vif
addr was used to indicate passive vs active monitor to the driver.
This would break the vif->addr when changing the netdev mac address before
switching the interface from monitor to sta mode.
Fix the regression by adding a separate flag to indicate whether vif->addr
is valid.

Reported-by: syzbot+9ea265d998de25ac6a46@syzkaller.appspotmail.com
Fixes: 9d40f7e32774 ("wifi: mac80211: add flag to opt out of virtual monitor support")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/mac80211.h |  3 +++
 net/mac80211/iface.c   | 11 ++++-------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 7e953720821b..2282cce7f732 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1987,6 +1987,8 @@ enum ieee80211_neg_ttlm_res {
  * @neg_ttlm: negotiated TID to link mapping info.
  *	see &struct ieee80211_neg_ttlm.
  * @addr: address of this interface
+ * @addr_valid: indicates if the address is actively used. Set to false for
+ *	passive monitor interfaces, true in all other cases.
  * @p2p: indicates whether this AP or STA interface is a p2p
  *	interface, i.e. a GO or p2p-sta respectively
  * @netdev_features: tx netdev features supported by the hardware for this
@@ -2026,6 +2028,7 @@ struct ieee80211_vif {
 	u16 valid_links, active_links, dormant_links, suspended_links;
 	struct ieee80211_neg_ttlm neg_ttlm;
 	u8 addr[ETH_ALEN] __aligned(2);
+	bool addr_valid;
 	bool p2p;
 
 	u8 cab_queue;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index a8fbedd530f4..551da6145a67 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -278,13 +278,8 @@ static int _ieee80211_change_mac(struct ieee80211_sub_if_data *sdata,
 	ret = eth_mac_addr(sdata->dev, sa);
 
 	if (ret == 0) {
-		if (check_dup) {
-			memcpy(sdata->vif.addr, sa->sa_data, ETH_ALEN);
-			ether_addr_copy(sdata->vif.bss_conf.addr, sdata->vif.addr);
-		} else {
-			memset(sdata->vif.addr, 0, ETH_ALEN);
-			memset(sdata->vif.bss_conf.addr, 0, ETH_ALEN);
-		}
+		memcpy(sdata->vif.addr, sa->sa_data, ETH_ALEN);
+		ether_addr_copy(sdata->vif.bss_conf.addr, sdata->vif.addr);
 	}
 
 	/* Regardless of eth_mac_addr() return we still want to add the
@@ -1323,6 +1318,8 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 		}
 	}
 
+	sdata->vif.addr_valid = sdata->vif.type != NL80211_IFTYPE_MONITOR ||
+				(sdata->u.mntr.flags & MONITOR_FLAG_ACTIVE);
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_AP_VLAN:
 		/* no need to tell driver, but set carrier and chanctx */
-- 
2.47.0


