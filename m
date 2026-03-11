Return-Path: <linux-wireless+bounces-33002-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKg0F8f1sWkeHgAAu9opvQ
	(envelope-from <linux-wireless+bounces-33002-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 00:07:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B618F26B250
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 00:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6580E305E9F1
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 23:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46593A1699;
	Wed, 11 Mar 2026 23:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="ap3v3lj8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCC91E8320
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 23:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773270467; cv=none; b=sAxWhGOZgfHhFq/2epAs6h84D+fHXyqSRLbYulEe51bvd8d8EQEdSVo/Az3dR9g8zQvlUqQLU07PkpvfgZRvaE0uy15xGGi8k6As2LWFk+CT+zJtPe4tJVwm8Ox9eTXk69UAeCiwplBHKZDdb4rve1/2fSDaTuJRGblCCPLjrvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773270467; c=relaxed/simple;
	bh=TOt5e1Mn6oqo6w2KCnw6jXoqI7H+jLVsg9914AqdJzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4hyEoqo6D4ajB2veMwOLwBsOzgtX2VNwSZCeO1azKBLFxg797MclgqYgbA44Of6+CMMtySA1xiHo6KUFXLO5Mf4njAMEW2+tLY7WsHQBVfNp+0DoZ7eqj8ZTm6XP6j34hsBypOBcZyK8ZAUxXqkOJ4XkUPTF5tD4tx7KXR3eTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=ap3v3lj8; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 46A4BAC0069
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 23:07:39 +0000 (UTC)
Received: from ben-dt5.candelatech.com (firewall.candelatech.com [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id CD9C113C2B4;
	Wed, 11 Mar 2026 16:07:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com CD9C113C2B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1773270456;
	bh=TOt5e1Mn6oqo6w2KCnw6jXoqI7H+jLVsg9914AqdJzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ap3v3lj8EwnUv1ZLBcWtJa6cF5FzMAsPf2PVwKWI1rrK6K/hKfsLtl5gRog3XY2BA
	 sU3G/WyNTBjySNPH1ZlkSOgkrPDH0Ylcqo47haQqu65kNmRyBs6KGkcXDKyRgJXd3Z
	 RSssRztYhl9lnYM5qwnUL2vY4sFi4cFiucTkDBGY=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH wireless-next 03/28] wifi: iwlwifi: mld: Add check for null vif in stats callback.
Date: Wed, 11 Mar 2026 16:07:05 -0700
Message-ID: <20260311230730.163348-4-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260311230730.163348-1-greearb@candelatech.com>
References: <20260311230730.163348-1-greearb@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1773270459-FXmt0OwVgr22
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1773270459;FXmt0OwVgr22;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33002-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[candelatech.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,candelatech.com:dkim,candelatech.com:email,candelatech.com:mid]
X-Rspamd-Queue-Id: B618F26B250
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ben Greear <greearb@candelatech.com>

A crash was seen in this area, protect against null.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/stats.c b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
index 7b8709716324..8d6bd7219b94 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/stats.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
@@ -415,7 +415,7 @@ iwl_mld_process_per_link_stats(struct iwl_mld *mld,
 
 		bss_conf = wiphy_dereference(mld->wiphy,
 					     mld->fw_id_to_bss_conf[fw_id]);
-		if (!bss_conf || bss_conf->vif->type != NL80211_IFTYPE_STATION)
+		if (!bss_conf || !bss_conf->vif || bss_conf->vif->type != NL80211_IFTYPE_STATION)
 			continue;
 
 		link_stats = &per_link[fw_id];
-- 
2.42.0


