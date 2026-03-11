Return-Path: <linux-wireless+bounces-33021-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFsxDyH2sWl7HQAAu9opvQ
	(envelope-from <linux-wireless+bounces-33021-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 00:09:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 962C126B2F9
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 00:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68F6731769D7
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 23:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FBD3A1688;
	Wed, 11 Mar 2026 23:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="quMPkXHw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3583A3837
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 23:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773270471; cv=none; b=sJUywj7aRlTJr4bPzztzZHUmO3NJiOSVtlVCINonYcq0NoSLotjTJd2j2gs5v6kZydWBRdNI1A+Ue3OyK381cQ/f6De+fpijWMLZhecvjh9oTqSNBk9PHXmTwqCa8yVnIf8Iw6/hz/Xb02ZNAAcTAvt6dmqY/hpYBiTTk51gBSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773270471; c=relaxed/simple;
	bh=gNRD0rEqOB0gM9zwBE03cN1xzYsnS1g//pftpskP4kY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGXAVk0AbISxfFyWMQNmqv4r5Lzqi3A3oVjc+CTiWJ9SzRWGUbnSUHgfh6coX41PkZlq/a4FZMof/kg6yc6VPtWH1Pak7Wl9MtRiuWCbxWtVms8lShuChmR7410QK4PAYQMZZKxVvRjjqKrlEJjAoJsxUXb6oC2eQCCNWwh7hCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=quMPkXHw; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 85D9D9C005C
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 23:07:42 +0000 (UTC)
Received: from ben-dt5.candelatech.com (firewall.candelatech.com [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id E40BB13C2B4;
	Wed, 11 Mar 2026 16:07:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E40BB13C2B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1773270460;
	bh=gNRD0rEqOB0gM9zwBE03cN1xzYsnS1g//pftpskP4kY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=quMPkXHwMnBtF4gxDn4m69uOE8+S/qcNzFHw/pCJj+jwBxnnXDm3hMMr5YC7Y0H2G
	 Fle6+8LvcNgjyjQ0uRdHSFTqf9YvZpFHQvoBJ8ZOW2zp0HRL6psA5NsBnym41XN8lh
	 8A4CvZylLSvL9COrESra9lGs098GHmhqo6Ohmyk0=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH wireless-next 16/28] wifi: iwlwifi: mld: Check for null in iwl_mld_wait_sta_txqs_empty
Date: Wed, 11 Mar 2026 16:07:18 -0700
Message-ID: <20260311230730.163348-17-greearb@candelatech.com>
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
X-MDID: 1773270463-SskgUfdE88GT
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1773270463;SskgUfdE88GT;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
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
	TAGGED_FROM(0.00)[bounces-33021-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,candelatech.com:dkim,candelatech.com:email,candelatech.com:mid]
X-Rspamd-Queue-Id: 962C126B2F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ben Greear <greearb@candelatech.com>

I saw some crashes here in eMLSR torture test, looks like mld_txq
was NULL, so add check.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/sta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.c b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
index 6338ca46f68e..288fc4b7604e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
@@ -789,7 +789,7 @@ void iwl_mld_wait_sta_txqs_empty(struct iwl_mld *mld, struct ieee80211_sta *sta)
 		struct iwl_mld_txq *mld_txq =
 			iwl_mld_txq_from_mac80211(sta->txq[i]);
 
-		if (!mld_txq->status.allocated)
+		if (!mld_txq || !mld_txq->status.allocated)
 			continue;
 
 		iwl_trans_wait_txq_empty(mld->trans, mld_txq->fw_id);
-- 
2.42.0


