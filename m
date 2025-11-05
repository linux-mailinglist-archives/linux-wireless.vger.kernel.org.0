Return-Path: <linux-wireless+bounces-28624-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A34B7C36417
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 16:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8E771A21989
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 15:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D619832E73E;
	Wed,  5 Nov 2025 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="bf+jByqH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D0032E6B1
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355444; cv=none; b=UG/0rS3tZUmHCnv4N2hEwP5bOG8Qbsi44XsGeOSlQgqObqSwP+raR8JHDNtMBB1JxHHeULM4FXQGLoQoVc4FwWHT/bfjyCGtwQesKnqlKAfnKzzH8J9/YWbutHLZPIpNghtoFfvS9QqtCFXgOxckN7pHpIDAIzsNYHVnHidtDjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355444; c=relaxed/simple;
	bh=qetS45QSxDi5wlfYNfF5Ed9aaNuxaSvoVfF/M+NAs7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t7zcgOixoAcrPyjUezEhxLjU7YUp+kh2b4vtvCwumBg7yN6eGYh7Rx+l09xuWgcoBVGEJSit6wYM5ZW4nO+yce1864Zj0Jd/OSkOBSkOs3Po52PJ+2ssvhvDzeXFdaTrtlTRsn4EUR3YfNOfjNpsqWmnkcpGd9S2UDSv9a/YVQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=bf+jByqH; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=P/llXa/ZkjcUsztd+FQSJRmv0Yqvdqa/LOuhiI6ziXE=; t=1762355442; x=1763565042; 
	b=bf+jByqHeF7cT9JZxdUJtJIras1m4L4bNXaoBMKoBJkdL06U0hGCZvhV+5m//KQtpwzX4vRbGTG
	qKtZpgj94YThr19HQdSJQ3NNyEkNnWpZXp6ulUgeGa4HNTzn6mToSquKZEj1PBB4i2C2/o2Pc6RBH
	apyfCROJYwpVSL6oJR1UZwrw41GfY0LfLLXID0uGafSe0DFDFcMcm4kZMuTj9MKXVJF8y+rzJPXM5
	Loeo6VzsuZOJRDiny9c/MCSg4le1Se9mY3HYJF5KLNd/r0U6QvZwIspMQ5gAp2XMQ2tAvTu8NuAsG
	IRmYjfVo/itA8bhW9+9DetAxigURPhqKb6dQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vGf9h-0000000FHGQ-27ZT;
	Wed, 05 Nov 2025 16:10:38 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: mac80211: remove unnecessary vlan NULL check
Date: Wed,  5 Nov 2025 16:10:33 +0100
Message-ID: <20251105161033.670b5a06296c.I24cb1a5338736ab0a8a24d6a492c259f894d09fb@changeid>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In a vlan iteration loop the vlan pointer cannot be NULL.
Remove the unnecessary check.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/link.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index d71eabe5abf8..49eb1bd00e27 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -23,9 +23,6 @@ static void ieee80211_update_apvlan_links(struct ieee80211_sub_if_data *sdata)
 	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list) {
 		int link_id;
 
-		if (!vlan)
-			continue;
-
 		/* No support for 4addr with MLO yet */
 		if (vlan->wdev.use_4addr)
 			return;
-- 
2.51.1


