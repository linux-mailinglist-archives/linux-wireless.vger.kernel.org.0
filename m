Return-Path: <linux-wireless+bounces-33130-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHURO07ysmlaRAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33130-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:05:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBF9276561
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23C8C306D8D0
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 17:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0000B3FBED9;
	Thu, 12 Mar 2026 17:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="BKjq5jVe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A6D3FB7FF
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334867; cv=none; b=fe/KThdsW3Ik59xbmctyuq1Oy9+VYXWjsDG5zGU17JoW9vb8ihagF3jYXJQ7KZeY3oJkOzYcejL/6lGTH91v9smJAkSzYozrToicEdbrK6JurZ8lpMf+gKpuWFWfXcFbm1t8jOo95iaWkdcmDRWAOAWdeJqPc4Egm19ek/4xt0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334867; c=relaxed/simple;
	bh=7IBnd4j8AKZX7520K9fBRNpiM4oT265ej985T884Viw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ho5Oy0h6C8sLSaznMsxH6lASPwIcJ7T+FA839DpUjSImp7pfXV0elsJc5+uQYHtbVEgHmL8QWGY+rTZZLO6spFrA88GRW4NyI4zgPbyRkxFK1jEaY8YPJI7y44YoZm+5NytwIVrADIvrleUxcvOI1qy9uypqCcvkr6HoPQ0TrdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=BKjq5jVe; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 9D7FE2800BC
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:03 +0000 (UTC)
Received: from ben-dt5.candelatech.com (firewall.candelatech.com [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 2420413C2B3;
	Thu, 12 Mar 2026 10:01:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 2420413C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1773334861;
	bh=7IBnd4j8AKZX7520K9fBRNpiM4oT265ej985T884Viw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BKjq5jVe5ZA2Ba4fZarTpbFfuIbLsJqrkZsytZ7jvJdJoSM8msw1RIvWPsMtsW9eC
	 mcUBD48RwBfl98KLovmtQETACK77YFNen36YFAS2Vjhcvt7Indn4SSk+vsjwz9Ohxz
	 J6JfN3yloao8uwYKrhRpQQbUyXLuUpojBL/+kcVk=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH wireless-next v2 14/28] wifi: mac80211: Add dmesg log regarding warn-on in drv-stop.
Date: Thu, 12 Mar 2026 10:00:12 -0700
Message-ID: <20260312170026.285494-15-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260312170026.285494-1-greearb@candelatech.com>
References: <20260312170026.285494-1-greearb@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1773334864-HIGaMGxFa0Lv
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1773334864;HIGaMGxFa0Lv;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
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
	TAGGED_FROM(0.00)[bounces-33130-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[candelatech.com:dkim,candelatech.com:email,candelatech.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7FBF9276561
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ben Greear <greearb@candelatech.com>

And make it WARN_ON_ONCE.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/driver-ops.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index 59998d0af3ff..397a0281412a 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -38,8 +38,10 @@ void drv_stop(struct ieee80211_local *local, bool suspend)
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	if (WARN_ON(!local->started))
+	if (WARN_ON_ONCE(!local->started)) {
+		pr_err("mac80211: drv-stop called but local is not started.\n");
 		return;
+	}
 
 	trace_drv_stop(local, suspend);
 	local->ops->stop(&local->hw, suspend);
-- 
2.42.0


