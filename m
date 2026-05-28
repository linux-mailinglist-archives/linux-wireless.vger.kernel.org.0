Return-Path: <linux-wireless+bounces-37058-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eI8bMgweGGocdggAu9opvQ
	(envelope-from <linux-wireless+bounces-37058-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 12:50:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB695F0E54
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 12:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D1EA53005A93
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 10:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9F23CDBC3;
	Thu, 28 May 2026 10:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="JF5Y2hJQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEB73CF025
	for <linux-wireless@vger.kernel.org>; Thu, 28 May 2026 10:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779965449; cv=none; b=FiDuRdvnT+/4/35Uewj2rZHvtGmpR+zKv2Jturg09/JegvASV4rEcnGPlb0PlhBzZNoWdX5hhb/vppqnQETo5Hofmv0wKHhFF93Hn/ojbiahbvhv1MdIJcQHLN1u8+u3x09x1Dxf1sVoxTDp6Ld6hNI9O40sMIUFU9Z9dKkGvY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779965449; c=relaxed/simple;
	bh=QTpY4klwEAQf5SV9pNr/J9iVbasSD5DCAhOUHuTMxOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nXf37vn5EZnK9oPLK3LkXkCV0BEQYbptI8qLNxapd8zv+WTCspXbdKXSJ7ZIBBCe8fFIuuG6KC6MICrvjRRvH35NAETdsx+pNKp4ukWhZ1ZSlGj9dPAszjDKFwKmsNwixBxEXbN4SUOy46gpHC5rN/aKgkIPPft/1QQ/M0FXG+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=pass smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=JF5Y2hJQ; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=41UdaeUQg1sfm+qKFekVK5SEL4n1s1IcQFUxpxpthLQ=; b=JF5Y2hJQranAgWh/7ZLY1QBwCg
	hcYLueexEJ9XaVMoIbD9gks1pxRPGNcisr1AEuVp26dJ95d4NUQodoURi/PL8ILe7TTke6teO2Vyi
	OslpJTZjhyTMqaBiZ2DRcuoT/wm0FVlL5KDimqvB9Bo2PmUMGLjExFNfsejp7qdIoqCU=;
Received: from p200300cadf1ddd00000000000000085c.dip0.t-ipconnect.de ([2003:ca:df1d:dd00::85c] helo=max)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1wSYK5-00263m-1X;
	Thu, 28 May 2026 12:50:45 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH wireless] wifi: mac80211: report assoc_link_id in station info for non-MLD STAs on MLD AP
Date: Thu, 28 May 2026 10:50:42 +0000
Message-ID: <20260528105042.835284-1-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
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
	TAGGED_FROM(0.00)[bounces-37058-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nbd@nbd.name,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.903];
	DKIM_TRACE(0.00)[nbd.name:-];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6FB695F0E54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a non-MLD station associates with an MLD AP, it does so on a
specific link. However, sta_set_sinfo() never sets mlo_params_valid,
so nl80211 never emits NL80211_ATTR_MLO_LINK_ID in get_station /
dump_station responses. Userspace has no way to determine which link
a non-MLD STA is associated on.

Set mlo_params_valid to 1 and assoc_link_id to sta->deflink.link_id,
when valid_links is set.
Also set the mld_addr copy only for MLD STAs, so that non-MLD STAs
get a zeroed mld_addr as documented.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/sta_info.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 6cace7fdc571..60d0d0a43418 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -3307,7 +3307,10 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		u32 est_thr = 0;
 		int link_id;
 
-		ether_addr_copy(sinfo->mld_addr, sta->addr);
+		sinfo->mlo_params_valid = true;
+		sinfo->assoc_link_id = sta->deflink.link_id;
+		if (sta->sta.mlo)
+			ether_addr_copy(sinfo->mld_addr, sta->addr);
 
 		/* assign valid links first for iteration */
 		sinfo->valid_links = sta->sta.valid_links;
-- 
2.51.0


