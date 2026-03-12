Return-Path: <linux-wireless+bounces-33126-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIMFESXzsmmLRAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33126-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:08:53 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A596D27665A
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DA4730A9ABC
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 17:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DDB3FBEB6;
	Thu, 12 Mar 2026 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="KASG3oUF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A70396588
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334865; cv=none; b=tFRcQAjR4B7sMfZik82Y+D944eBys0yqcVUhV6MjgWTqzWn5ZaD5Hybq986zVXyzMsy74EYFgk6uHL03PClBG/xQtuf9KdeoqKSe3wB+bNGw8XQlIyXbpCuzPD3oKPxkStHDWgylZWoeDK1TeauV4LAuJ03JFCEeGwrOp2ehfGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334865; c=relaxed/simple;
	bh=TOt5e1Mn6oqo6w2KCnw6jXoqI7H+jLVsg9914AqdJzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h7PQuKqrmiBh315szq8uZ+Ou6RYMaxIfmETdLIG8lUwjfvJgYj9QUt8CvmDsPAq3e5quaAP4DgRQPRoKLUpsN2+ItvKlnTfrATLjgajJrnwCv0a9d4nn1mQN1LGUJ2vO/v/HX+MT9ABwSsnNjsjBfQi2fmfwL0oCmV2vutjg4Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=KASG3oUF; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D8D019C00E2
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:00 +0000 (UTC)
Received: from ben-dt5.candelatech.com (firewall.candelatech.com [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 49BB213C2B3;
	Thu, 12 Mar 2026 10:00:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 49BB213C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1773334858;
	bh=TOt5e1Mn6oqo6w2KCnw6jXoqI7H+jLVsg9914AqdJzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KASG3oUF/AdKU7NcTlJ97vPLUbSqIegWD25Gg5ADiCzLdhkfijeb0aq+6U+Gt63Yx
	 YLSH9OzQD2NUDMQzS1DigqAwreYHOhwQP4QFTLZD8ddjpX+8je7kBJU1sxaGAe2QGe
	 a2TtGvaMEAGx6Zrfg8gcHxSUguyr21EQYIFW14dQ=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH wireless-next v2 02/28] wifi: iwlwifi: mld: Add check for null vif in stats callback.
Date: Thu, 12 Mar 2026 10:00:00 -0700
Message-ID: <20260312170026.285494-3-greearb@candelatech.com>
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
X-MDID: 1773334861-Ghwz87mWosHz
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1773334861;Ghwz87mWosHz;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33126-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,candelatech.com:dkim,candelatech.com:email,candelatech.com:mid]
X-Rspamd-Queue-Id: A596D27665A
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


