Return-Path: <linux-wireless+bounces-33138-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMZWIQbysmlaRAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33138-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:04:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 671842764E1
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 91BF530648C0
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 17:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA823FCB20;
	Thu, 12 Mar 2026 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="Fos7F/RV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D63B3FBEA5
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334868; cv=none; b=O567mZmkp2F9YAJDH8K2p9q8uzUuwrqrmgMSlk+n1h9m9GtRG3gK68DkmTt889nFRbKdo6iz+S8Qgw7zqTg95rPaVHklpxKbRhoRxPTT33LCqNUyeCxU6c28vZu/ZjyfBtysg2bmwkkVboWJIssOQ0GgEOtpmLphT80MtBqSaLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334868; c=relaxed/simple;
	bh=2UTsqU8oDsvMdz4MSLxy8TUKLmsLG1fSGAgQilj4J6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFtJZzQi9v2rQkjUlN9PiCVwGzg8um3K4kCpgxYKb041dO2U1qbzlvivvwQOW6nmyk1LGCr7Zp+3/CKfwstMHaiEXvsZqXnc2bo0jNosA908KXqe3kMpFbLQ0Q+jQPXPltDGvHjBKuBRZkMyJaMaWYz2DlxFDM6J+Yu9oZ44UVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=Fos7F/RV; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id CF1A1C0086
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:03 +0000 (UTC)
Received: from ben-dt5.candelatech.com (firewall.candelatech.com [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 2BCE513C2B6;
	Thu, 12 Mar 2026 10:01:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 2BCE513C2B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1773334862;
	bh=2UTsqU8oDsvMdz4MSLxy8TUKLmsLG1fSGAgQilj4J6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fos7F/RVdtXTkRDoDZYz3VBR+RPkCucmUz+yldU/yL6uo7UBoeobxrTUAO1VgEFIj
	 T/2d0wiNPWB4vMFTeexbfDHfOG4gcI9/yKNpge0CSuoPSVN+52rUcpR9SrimOMdnH1
	 wXxFOgTk0NIfSy32L4Z/turXXbFeTVqhQHFAi4kg=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH wireless-next v2 18/28] wifi: iwlwifi: mld: Use warn-on-once in emlsr exit logic.
Date: Thu, 12 Mar 2026 10:00:16 -0700
Message-ID: <20260312170026.285494-19-greearb@candelatech.com>
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
X-MDID: 1773334864-YcvuVs8dOlZj
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1773334864;YcvuVs8dOlZj;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
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
	TAGGED_FROM(0.00)[bounces-33138-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 671842764E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ben Greear <greearb@candelatech.com>

Only splat warning once, and improve logging to indicate more
about why it is in the problem state.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index f842f5183223..7a37ca64a612 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -164,7 +164,10 @@ static void iwl_mld_check_emlsr_prevention(struct iwl_mld *mld,
 		 * The timeouts are chosen so that this will not happen, i.e.
 		 * IWL_MLD_EMLSR_PREVENT_LONG > IWL_MLD_PREVENT_EMLSR_TIMEOUT
 		 */
-		WARN_ON(mld_vif->emlsr.exit_repeat_count > 3);
+		if (WARN_ON_ONCE(mld_vif->emlsr.exit_repeat_count > 3)) {
+			IWL_ERR(mld, "check-emlsr-prevention exit repeats: %d > 3, blocked-reasons: 0x%x\n",
+				mld_vif->emlsr.exit_repeat_count, mld_vif->emlsr.blocked_reasons);
+		}
 	}
 
 	IWL_DEBUG_EHT(mld,
-- 
2.42.0


