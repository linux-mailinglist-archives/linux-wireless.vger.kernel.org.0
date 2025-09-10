Return-Path: <linux-wireless+bounces-27204-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CB2B51193
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 10:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF6B3A4BDF
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 08:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37D62BE620;
	Wed, 10 Sep 2025 08:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sDA5obzQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649A424BCE8
	for <linux-wireless@vger.kernel.org>; Wed, 10 Sep 2025 08:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493513; cv=none; b=ZYeYfgjmXPTy60ZrWA9YzMxWD2qEYr6rqONjHiib5P6CA/pC3U5Fn8kDcDE8Vf/4KrzyCob8kEuyq2AuNpJ/XwkSKqgW5pQGoPbyG3MjhYMSDWYAjqRMK7NhsnEsEDV8mUfSnFroTFT1nL6eYMtkHY4wI7dPZLRjFva5FHTL6ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493513; c=relaxed/simple;
	bh=pb3mjzoOqnMGsoW7T6XOBkHS505uhKchvYW9M2ALRNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fku7R9k3o1sx6i8wy3BcRIEjM1GMPcVKaGhpLiS14djbWrAJsDsBqwp07qrpPlGkqTvfXbTKnSBHydIrEuEGIShK+MAfuud5kftlv1sCM0sSWWcg6RVj9BkS9JpfZE/0JQq70PG9orsPxSUsQM1khVrS+op5bOCRlyi0iXg+oeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sDA5obzQ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=hnkCX/rPw0MYu1sVbgfBaWXkK3iLM1IC4s3zFxP1Wj0=; t=1757493512; x=1758703112; 
	b=sDA5obzQAVXpoN8bZmOKWLqvIezsWOnn5GDe664D+YMFWuNOn9YsOSk+WkJYwRl5tM3rNpYlTfA
	H0RKt2Gz6blDZi8u03UQ/9yNZjyvfE05ABI0AZCNsTaV4PibS2h7RQWcyDR6q3LszA7tiGjNCeP77
	tvPEVtoRrEaBUbYIXBVrZV+ewEzaluYbrBUJB17krt37FnQ/cUqOLO6LsVWRlff1R7aY/3T1mSlBf
	O12qtQFzoziirfyqxAZykfuIhouEzlhtu1E/63/0COToNB6CF7otCcXgDOgGdNZKSvWVpjifBhjA2
	LL7g5Pz7s0+e8sZMhmFGUU9mOGi/aqd4djWg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uwGLT-0000000CTRc-0NdH;
	Wed, 10 Sep 2025 10:38:27 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless] wifi: nl80211: completely disable per-link stats for now
Date: Wed, 10 Sep 2025 10:38:24 +0200
Message-ID: <20250910103824.e63765f59b2d.Ibb2f3663109922148a8f0067f56ef919039c5409@changeid>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

After commit 8cc71fc3b82b ("wifi: cfg80211: Fix "no buffer
space available" error in nl80211_get_station() for MLO"),
the per-link data is only included in station dumps, where
the size limit is somewhat less of an issue. However, it's
still an issue, depending on how many links a station has
and how much per-link data there is. Thus, for now, disable
per-link statistics entirely.

A complete fix will need to take this into account, make it
opt-in by userspace, and change the dump format to be able
to split a single station's data across multiple netlink
dump messages, which all together is too much development
for a fix.

Fixes: 82d7f841d9bd ("wifi: cfg80211: extend to embed link level statistics in NL message")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index f2f7424e930c..852573423e52 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -7575,7 +7575,7 @@ static int nl80211_dump_station(struct sk_buff *skb,
 				NETLINK_CB(cb->skb).portid,
 				cb->nlh->nlmsg_seq, NLM_F_MULTI,
 				rdev, wdev->netdev, mac_addr,
-				&sinfo, true) < 0)
+				&sinfo, false) < 0)
 			goto out;
 
 		sta_idx++;
-- 
2.51.0


