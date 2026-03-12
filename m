Return-Path: <linux-wireless+bounces-33149-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id II6QAlbzsmmLRAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33149-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:09:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C16D276670
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D11C031157AA
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 17:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87E23FE365;
	Thu, 12 Mar 2026 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="YYJ/Hsva"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2583F3FBEC6
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334871; cv=none; b=ZQXfCkHCkX0z+VhQ9wOgLDgPcYCEzw6YypiM64+3twG88GgxFIepYWzYhFHKis1AfQQvgg2UN3I7Kd6dik0vMq7CjqIZhOXxN2ywC+r+2PNRoNzwB8vA9eIcYg35HaVIeahDO+nj4XaM/vk1M8P+w+DrFIDe5eIyB/GqE+00/cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334871; c=relaxed/simple;
	bh=VMEXyTECxWwmKFvGRgjDmP6W+k/4YAn7N1+e+XNPtVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYhfUdvLogYxErNslxNiymnFf7PiyrPHQgXbYmHZB88eGL9A7xIRRw9/wzthboMXQoOxU/w3uTaQ2jFLUOZkMN+i4jk6xlsxmZKon4G/XXQCz6PSk3ffstZClxH95JMUT6PM6bQKS8NdG5nUPcjsJOslI00WWt7ruJzdiAW+g1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=YYJ/Hsva; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id E15B880087
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:04 +0000 (UTC)
Received: from ben-dt5.candelatech.com (firewall.candelatech.com [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 6867C13C2B7;
	Thu, 12 Mar 2026 10:01:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6867C13C2B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1773334862;
	bh=VMEXyTECxWwmKFvGRgjDmP6W+k/4YAn7N1+e+XNPtVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YYJ/Hsvaf7e2H1qx/S3u7WCX3pClbeDl6hQiy99gjeWoyYrAHSP7iGImcGEuVMRHw
	 NVQ+o3WE8sEx4bGT3Wd4dMJRcYvQbejFPC/7UO6wehdtFh5wv1fsS2/H+OkWFKh5mZ
	 DxPSVnXzUipKkLfKgHO9Y5pLyOZaid8ergExxOc8=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH wireless-next v2 19/28] wifi: iwlwifi: mld: Improve error message in rx path.
Date: Thu, 12 Mar 2026 10:00:17 -0700
Message-ID: <20260312170026.285494-20-greearb@candelatech.com>
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
X-MDID: 1773334865-EF8mNt0CLZig
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1773334865;EF8mNt0CLZig;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33149-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,candelatech.com:dkim,candelatech.com:email,candelatech.com:mid]
X-Rspamd-Queue-Id: 6C16D276670
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ben Greear <greearb@candelatech.com>

Print return code that is causing the failure path.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/rx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.c b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
index 214dcfde2fb4..f5c20a3aa869 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
@@ -2204,8 +2204,8 @@ void iwl_mld_sync_rx_queues(struct iwl_mld *mld,
 	ret = wait_event_timeout(mld->rxq_sync.waitq,
 				 READ_ONCE(mld->rxq_sync.state) == 0,
 				 SYNC_RX_QUEUE_TIMEOUT);
-	WARN_ONCE(!ret, "RXQ sync failed: state=0x%lx, cookie=%d\n",
-		  mld->rxq_sync.state, mld->rxq_sync.cookie);
+	WARN_ONCE(!ret, "RXQ sync failed: state=0x%lx, cookie=%d, ret: %d\n",
+		  mld->rxq_sync.state, mld->rxq_sync.cookie, ret);
 
 out:
 	mld->rxq_sync.state = 0;
-- 
2.42.0


