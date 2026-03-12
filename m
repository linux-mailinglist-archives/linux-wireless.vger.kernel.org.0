Return-Path: <linux-wireless+bounces-33144-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAKUBRzzsmmLRAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33144-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:08:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C33276653
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7E103107B4A
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 17:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91EF3FCB18;
	Thu, 12 Mar 2026 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="n/Jdidgy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E908399358
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334870; cv=none; b=KSGU/e1Xx+tZWIMKlCad1n8JUR4etV8tCg7XMyOWvCugqcc6SyLK2TajfsVYDEwb32vLHK9sDcj6crufrKfr/iO+mNYLC1FAO8k26HFjEmld9btnanINIfQnZafKOVRBwnnasHwvF4BgN9++Qsj8HAQ/VD5Ajl8Xu96VJwD+a8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334870; c=relaxed/simple;
	bh=mRQpnpMqVqBj1C++P+SgMnDw3psGcoLR1NEbkaNg2so=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XcEkMBzmd1mNHhXg8BI2iXfWKP4/mVt3BRT2MTNKuUU/N2OmrsJPtCvrLp3Zz0N3KIetsJPwFi4CNNyM7xHNJWSD5+2svtK9FEs0rn7Ry0PatpSrnl9WHe5UI4D3JusmiwobGDibeNNb/glgNDXyqXggVih6Jdu1KKMzrXZALcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=n/Jdidgy; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id CD14D400071
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:06 +0000 (UTC)
Received: from ben-dt5.candelatech.com (firewall.candelatech.com [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 7037413C2B4;
	Thu, 12 Mar 2026 10:01:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 7037413C2B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1773334864;
	bh=mRQpnpMqVqBj1C++P+SgMnDw3psGcoLR1NEbkaNg2so=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n/JdidgyKGYJ7M1hdHwMuupDDzl8H2B1JZH3OeeWaASwV2hQesyGmteQda/WAxAZG
	 oNE0N8ORnBojRQeIhSYBtGYIrzxhc+UzZHd5Mc3fWimvDMu2BaXcRvFf3/riRE3g+D
	 2Vfwio8Lra6cZIYlHWALHnxE8w/nXbLf8VhYPyyc=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH wireless-next v2 27/28] wifi: iwlwifi: mld: Convert to WARN_ONCE in link removal path.
Date: Thu, 12 Mar 2026 10:00:25 -0700
Message-ID: <20260312170026.285494-28-greearb@candelatech.com>
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
X-MDID: 1773334867-453rrcL79oDA
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1773334867;453rrcL79oDA;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
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
	TAGGED_FROM(0.00)[bounces-33144-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 79C33276653
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ben Greear <greearb@candelatech.com>

While the comment indicates this should not happen, it does at least
when firmware is being problematic.  Change to WARN_ON_ONCE to
decrease log spam.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/sta.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.h b/drivers/net/wireless/intel/iwlwifi/mld/sta.h
index 1897b121aae2..44c54e6d68e6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.h
@@ -170,7 +170,7 @@ iwl_mld_cleanup_sta(void *data, struct ieee80211_sta *sta)
 			continue;
 
 		/* Should not happen as link removal should always succeed */
-		WARN_ON(1);
+		WARN_ON_ONCE(1);
 		RCU_INIT_POINTER(mld_sta->link[link_id], NULL);
 		RCU_INIT_POINTER(mld_sta->mld->fw_id_to_link_sta[mld_link_sta->fw_id],
 				 NULL);
-- 
2.42.0


