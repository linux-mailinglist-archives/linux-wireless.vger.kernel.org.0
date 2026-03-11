Return-Path: <linux-wireless+bounces-33014-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJERNv31sWkeHgAAu9opvQ
	(envelope-from <linux-wireless+bounces-33014-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 00:08:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB5A26B2C1
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 00:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C18FA30F6746
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 23:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CD33A3E73;
	Wed, 11 Mar 2026 23:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="YN+rl0xh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4932C3A1688
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 23:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773270469; cv=none; b=YDytdzktJw1s+ZZq7qPL+pJeKqixHpdXjiAI5ouQIYxn5Egual1JiCbGLy2YoT0ILtY53KYlBxJ36EMskwPvSHaEe1/Lrvs8M2TViJdwIS63GEPyq3XYgJRoiyF93cmqOAorkL6Zdf0ZqGdC1XnJSQt0lWEQcVk4gg0QIQLcxCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773270469; c=relaxed/simple;
	bh=7IBnd4j8AKZX7520K9fBRNpiM4oT265ej985T884Viw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzGYJV5GXeVT5prMJDAvEyaGgq+WaJxe3UE9QI61EdH9hNJcOa5JpcH//uCk8bLco4cmXuCeIbduAanMDTKk3sQZNg9GDTz6kXP5Y3aYx6hk1tNwW8VGp+TD0F/YGtNWkSM22oT03gyI3NooLws6xD6Juk861VhCSOmwORHvNGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=YN+rl0xh; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id F3469440086
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 23:07:41 +0000 (UTC)
Received: from ben-dt5.candelatech.com (firewall.candelatech.com [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 69DE113C2B1;
	Wed, 11 Mar 2026 16:07:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 69DE113C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1773270459;
	bh=7IBnd4j8AKZX7520K9fBRNpiM4oT265ej985T884Viw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YN+rl0xhc0lUss6UfYAl8WAf61Vzd5oeJsf30PDT+xX/HgnNoxXWHr4oYHYNvuj64
	 +3T78tBrWWhKDZze3lhVo0+xr827P5gmAGxHVw7oH/xZKQ/OHPt0XrlSApGqj1Btd8
	 SRz7HoSYmQ210uY/uamx3O0359tzgTTnsNffL8xs=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH wireless-next 14/28] wifi: mac80211: Add dmesg log regarding warn-on in drv-stop.
Date: Wed, 11 Mar 2026 16:07:16 -0700
Message-ID: <20260311230730.163348-15-greearb@candelatech.com>
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
X-MDID: 1773270462-o6MM_t8JTMK4
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1773270462;o6MM_t8JTMK4;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33014-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[candelatech.com:dkim,candelatech.com:email,candelatech.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7FB5A26B2C1
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


