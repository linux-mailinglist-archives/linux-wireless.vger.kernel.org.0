Return-Path: <linux-wireless+bounces-33146-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGyOKjfysmmLRAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33146-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:04:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F964276549
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 099BF30402BF
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 17:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5837A3FBEA0;
	Thu, 12 Mar 2026 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="nUjWEVgG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2C13FCB16
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334871; cv=none; b=JPpZu4cEi/qZ9m1kPuf1Xoy6S1KHQMCt8Opz+QGltwjf54hj2O0rS5pcZFIZA2sclNGYbCihlm/BTi4g3VT1DxPPUm+N+oMk/mJgXDLhJUtW6nJZothiNTRCqFX1wUAfrI3N3rm38bgMjX40iWFcCmFT2UloxgVCRgt8fQY6b7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334871; c=relaxed/simple;
	bh=6krdLNtKVmL86wGsQ8jAMLKOtMcRp7QzB6NxlaWJkNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqQbll4KF36lrMK6YFXeyOWUO5h643HvgO588HJQYTlSWLzsQ2jkGd13Q359XZwv47XToV118cJpgjCXNkA5LjLPfNCxseQCARKr+2f+BARb1Y3DMXIVY5t8yW/Dovs5TU3owtNL5ANDNDlX/ghnXms33BbpztKqhOpdw/Hln2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=nUjWEVgG; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 452804000AE
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:06 +0000 (UTC)
Received: from ben-dt5.candelatech.com (firewall.candelatech.com [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id E9F8513C2B1;
	Thu, 12 Mar 2026 10:01:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E9F8513C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1773334864;
	bh=6krdLNtKVmL86wGsQ8jAMLKOtMcRp7QzB6NxlaWJkNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nUjWEVgGBDYJLtRTuU02eW4VuGIZH0XI5vyIWfjiELBjHToenTYB+Iu3lEU1v3l3R
	 o4aGUwArouovrNM92fJXesr4Sk4mcRud8dSbgVJ4QkxFzzyRMX03Iq9BkzpG2oLhEC
	 xfiL6QO/XPKypH+MbbSLvhyQwx+hPXhZTpIhNOGs=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH wireless-next v2 25/28] wifi: iwlwifi: mld: Fix bad return address in tx code.
Date: Thu, 12 Mar 2026 10:00:23 -0700
Message-ID: <20260312170026.285494-26-greearb@candelatech.com>
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
X-MDID: 1773334866-CN8wbb2bpwZL
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1773334866;CN8wbb2bpwZL;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33146-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,candelatech.com:dkim,candelatech.com:email,candelatech.com:mid]
X-Rspamd-Queue-Id: 6F964276549
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ben Greear <greearb@candelatech.com>

iwl_mld_txq_from_mac80211 was returning the offset into
txq without checking if txq was NULL.  In case txq is
NULL, this would return a small, but non NULL pointer.

The safety check in calling code would then treat it
as non-null and attempt to dereference.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/tx.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.h b/drivers/net/wireless/intel/iwlwifi/mld/tx.h
index 520f15f9d33c..8b0da098c25f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.h
@@ -45,6 +45,8 @@ static inline void iwl_mld_init_txq(struct iwl_mld_txq *mld_txq)
 static inline struct iwl_mld_txq *
 iwl_mld_txq_from_mac80211(struct ieee80211_txq *txq)
 {
+	if (!txq)
+		return NULL;
 	return (void *)txq->drv_priv;
 }
 
-- 
2.42.0


