Return-Path: <linux-wireless+bounces-34037-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHIlIP5Pxmk2IgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34037-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:38:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C41341D2E
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BA383044645
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 09:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822AB3DBD58;
	Fri, 27 Mar 2026 09:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="SLMiO7E0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9543D6498
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 09:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604232; cv=none; b=klFAGOa11o9VHZt2kL2ehp8XMzk37ZmJstXKQ6qQmcD636yVPjaE8uVZ/d0RhzUrhkO5fW2zT+cGg9QK2PjbNY4UZtMegggwUb98C3D5PGheGoPpCqFaQm0fMa1DT+5CwkV2m1wylIly3j5W32Jv+1kITKVfk500Y2A5dZb3CM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604232; c=relaxed/simple;
	bh=tBTKpuJKBY/Taj22GoJ8OirJvLh3dGI0lQrJpx2OZho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DL3qairFCPVdmjRZonytHMHoY/rGxgGIQQGG79xXTbZ299FX0bMfh0gekLwOdotWkuDb+GybF3G1Gz7mi4vtts/gezAIuUa4Bqzr0ZE1t6ktY54+kjxY8/PymxBZii2nPijFjdoqSQorFajYJ0kDuBahFduUDv+9vgFrGOo/9Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=SLMiO7E0; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3VZrPVD2tLqD7BVw2HmmUbundMi351bxX0BgXC8BaGU=;
	t=1774604231; x=1775813831; b=SLMiO7E0lN44ML3Y95QbYze6oSYI2dVm+agaA2zGCTeO11b
	vK07paErjW7W08PgDa2Vy6CJ/SDhzGEQSwGbvheHSY8u4K5iyHe7vJuTY1taQJwxhfzuwpZTzVpma
	aewLk3KaYsqH6ZtCNCHz9bdzLi8NWnZ5tqZH7NuhPGf2QQvnc/s4NbQixbYn77YEfezGu2nzjDclm
	+wTmW6/JtWJLqR4ORMJpU5+lq9ZIYZ0ZnSZWz453K0tLiDmEf5qSsxzBj7qA51jiSYL8aBbA2LgeK
	p82LMOSrEFzzONeXiIcmw7oKeRrborRd5mxjsHp6QTydt6rSvjWI7/bYK6IiiSPg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w63cl-0000000E83L-1Ne5;
	Fri, 27 Mar 2026 10:37:03 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 02/19] wifi: mac80211: use max BW for HT channel width update
Date: Fri, 27 Mar 2026 10:31:28 +0100
Message-ID: <20260327103659.6b1b58d8149c.I9683605229ed1b75ff5a9c14e967762e88b3fc36@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327093659.711584-21-johannes@sipsolutions.net>
References: <20260327093659.711584-21-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34037-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 01C41341D2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

When an HT channel width update comes in, don't use the
capability of the station, but rather set it to max as
the capability will be taken into account anyway when
using the value.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ht.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index 27b5578601ff..d951a4302e9a 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -618,7 +618,7 @@ void ieee80211_ht_handle_chanwidth_notif(struct ieee80211_local *local,
 	if (chanwidth == IEEE80211_HT_CHANWIDTH_20MHZ)
 		max_bw = IEEE80211_STA_RX_BW_20;
 	else
-		max_bw = ieee80211_sta_cap_rx_bw(link_sta);
+		max_bw = IEEE80211_STA_RX_BW_MAX;
 
 	/* set cur_max_bandwidth and recalc sta bw */
 	link_sta->cur_max_bandwidth = max_bw;
-- 
2.53.0


