Return-Path: <linux-wireless+bounces-33738-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDUaAuOtwWmUUQQAu9opvQ
	(envelope-from <linux-wireless+bounces-33738-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 22:17:23 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9524E2FDAB1
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 22:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8983B3069048
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 21:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB2E37DE93;
	Mon, 23 Mar 2026 21:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kOOHGCjt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016DF37C0FD
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 21:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774300563; cv=none; b=c/q+bgtpsYLOitdYyqEUlS2H/bW8Mj6oRXOC3AUMtJTKQSixRWhfRunYwnOEa3jNCzNuqC3It7IdtV3YQnv/PwfgyhLlvxpUEHzgq9kKMFS67DIHSHzXM9yEU2Lq+bsnywM1H3xTGlQ3iBrwA+LAAJveGHXV8Twbp971EVTOSno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774300563; c=relaxed/simple;
	bh=Te0OZmSdIyniJaVestYG6eDvoL9CtWZwIYB7QhRzNMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l6T/hDOZdi1r8joSvFQcGfviConybMqzsz6yzNj5pK9WDQPmADNMUd72bOTG4vtgdOymVmK+PGOb7ebG7dgJGIS+pqsAkW6iMdIwQjKRrWHozRswy62hQKdCGMzIrEIVkti/7x8AXo2dxAx6UgblFgPouV6ckI9P3P/E7J8Tkt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kOOHGCjt; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774300562; x=1805836562;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Te0OZmSdIyniJaVestYG6eDvoL9CtWZwIYB7QhRzNMQ=;
  b=kOOHGCjt9h8dsuqFfL4HHY1kPQm/pAteybLsvYwvqWaKIjh/cz4y/Or2
   75rRL5YsUfXxwcASGMTkFj0kQHylRJm8yH6P29W1pGOO31fbhi4IPR+8s
   2nuZlbG4oa9RSNzxRAawfpT/jwFybvsgOUfiSe/TpS5Esn43lqq6BEATc
   rJfk174/6dLJj/jt2YpC/UE3z1S4UBoNpGhIHPOpULufZe5aB+rxAI6dq
   yKwlUgKcYYJuPnuK7P4K/x5V4uvB03tQLYwW0IRwp8OIFcjTltlJJ63Jv
   B2jUzq3vtH4dH/1sky9pehU1J2q6oAKKByHLSPrpWPzF5yCT7prBTsAyq
   A==;
X-CSE-ConnectionGUID: yhakqvHwToaTFFhA772q8g==
X-CSE-MsgGUID: 8CLcIHUGSv2hXgltL8XOjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="92883567"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="92883567"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 14:16:01 -0700
X-CSE-ConnectionGUID: NhYN81jtQIy9mFEd5FFn+A==
X-CSE-MsgGUID: oHJ3O7/NQ5WA4XE/3qfOcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="228208729"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 14:15:59 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: mac80211: fix AEAD functions not handling errors
Date: Mon, 23 Mar 2026 23:15:48 +0200
Message-Id: <20260323231539.aa9f1db285a8.Icf2051ed1acac174b85b99158cc2b0757310765a@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33738-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 9524E2FDAB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This was done for CMAC but not for AEAD.
This was spotted by Coverity.

Fixes: 26717828b75d ("mac80211: aes-cmac: switch to shash CMAC driver")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/fils_aead.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/fils_aead.c b/net/mac80211/fils_aead.c
index 912c46f74d24..a24c0d0a2b2a 100644
--- a/net/mac80211/fils_aead.c
+++ b/net/mac80211/fils_aead.c
@@ -28,25 +28,35 @@ static int aes_s2v(struct crypto_shash *tfm,
 	u8 d[AES_BLOCK_SIZE], tmp[AES_BLOCK_SIZE] = {};
 	SHASH_DESC_ON_STACK(desc, tfm);
 	size_t i;
+	int err;
 
 	desc->tfm = tfm;
 
 	/* D = AES-CMAC(K, <zero>) */
-	crypto_shash_digest(desc, tmp, AES_BLOCK_SIZE, d);
+	err = crypto_shash_digest(desc, tmp, AES_BLOCK_SIZE, d);
+	if (err)
+		return err;
 
 	for (i = 0; i < num_elem - 1; i++) {
 		/* D = dbl(D) xor AES_CMAC(K, Si) */
 		gf_mulx(d); /* dbl */
-		crypto_shash_digest(desc, addr[i], len[i], tmp);
+		err = crypto_shash_digest(desc, addr[i], len[i], tmp);
+		if (err)
+			return err;
 		crypto_xor(d, tmp, AES_BLOCK_SIZE);
 	}
 
-	crypto_shash_init(desc);
+	err = crypto_shash_init(desc);
+	if (err)
+		return err;
 
 	if (len[i] >= AES_BLOCK_SIZE) {
 		/* len(Sn) >= 128 */
 		/* T = Sn xorend D */
-		crypto_shash_update(desc, addr[i], len[i] - AES_BLOCK_SIZE);
+		err = crypto_shash_update(desc, addr[i],
+					  len[i] - AES_BLOCK_SIZE);
+		if (err)
+			return err;
 		crypto_xor(d, addr[i] + len[i] - AES_BLOCK_SIZE,
 			   AES_BLOCK_SIZE);
 	} else {
@@ -57,9 +67,7 @@ static int aes_s2v(struct crypto_shash *tfm,
 		d[len[i]] ^= 0x80;
 	}
 	/* V = AES-CMAC(K, T) */
-	crypto_shash_finup(desc, d, AES_BLOCK_SIZE, v);
-
-	return 0;
+	return crypto_shash_finup(desc, d, AES_BLOCK_SIZE, v);
 }
 
 /* Note: addr[] and len[] needs to have one extra slot at the end. */
-- 
2.34.1


