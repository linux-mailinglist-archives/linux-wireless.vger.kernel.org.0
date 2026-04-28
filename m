Return-Path: <linux-wireless+bounces-35456-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEyaDep78GkaUAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35456-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:20:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8074813DF
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54FD23174617
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA083DA7C3;
	Tue, 28 Apr 2026 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="J+0cMuAw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E482E3DA5CC
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777367365; cv=none; b=i7bpefrUry7dEu5vjJKMUHJaafuPftS+B4kcbOmbDvPZfOJu24D8zGxsWdsuE09yLAZhCYMD3WAugjLMY8khvwf2HJgn3YxVDlhdKa6hhGRGmfK9Un4nxIr1pbyU6HbcXohs5I9rSXoXRbrdFYkkc8POY1SjAE0C9yvlGruRY+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777367365; c=relaxed/simple;
	bh=89uGZdFqzEUtfj2D5QTe4ZF4R63MWC4mU5/1T+IVPqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nr8otif9WPY6tY+ojxavJqOlnFSQc84vlS5hpVAP3fufHB/ZeSXdL2BSXPux7aaqXnuXcpBmOf+Skl0jyc9onuWGbttjo3iq+zTPTykTbI/MyZzNMqxsMLvAuzyrG3Y5FimQe3lRoRLU8MOevYuQf+mvQsd52jGQRbjv6TfeFYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=J+0cMuAw; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=qKZb7Y/pq9QKWmSx07o+4jQPQRMuR9nOhIRAw+L6r9E=;
	t=1777367364; x=1778576964; b=J+0cMuAwYrXto8eUIDxoeX5LJwkro7ynmJT1kn9KjlUQHL+
	PgFQH8/Lf2auQnM1+3Wiatyrr6dMbQx6fPMWGdKB27+MbroZ++gQUfVC/jII8Cq1l5JRP6dMokXFS
	unNvFNAfVi42BbeHl8JZ74cshyAvEAF4NbA8t/dMFeupBg3gVY4oGhtEYoq6U0f1HesI06sq59TZG
	QOu1967ZKMkyAH/L/wC6MckOzU08uolAW/EBv8QT/pJ/KcCF6juGGyEHE1o8aXzPXIKZblRif2zeU
	z+cRYf1ZAh03zYchx64WnqJH9pFRS+ClbMcZY74v7f3rzsx9NMeC3FlRpHsNPNeg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wHeRU-0000000HGH2-3PyA;
	Tue, 28 Apr 2026 11:09:21 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 3/5] wifi: cfg80211: ensure UHR ML-PM flag is consistent
Date: Tue, 28 Apr 2026 11:06:58 +0200
Message-ID: <20260428110915.34158027395b.I9df13d3f2588d79294559fad64182acc9edf3f30@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428090915.54717-7-johannes@sipsolutions.net>
References: <20260428090915.54717-7-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AC8074813DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35456-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,sipsolutions.net:dkim]

From: Johannes Berg <johannes.berg@intel.com>

We check that extended MLD capabilities and operations are
consistent across APs in an AP MLD, but didn't check reserved
fields since they could be defined to differ. Check bit 8 now
since it's defined by UHR to be consistent.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/mlme.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index bd72317c4964..65a39428f508 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -360,17 +360,18 @@ cfg80211_mlme_check_mlo_compat(const struct ieee80211_multi_link_elem *mle_a,
 	 * reserved when included in a unicast Probe Response frame and may
 	 * also change when the AP adds/removes links. The BTM MLD
 	 * Recommendation For Multiple APs Support subfield is reserved when
-	 * transmitted by an AP. All other bits are currently reserved.
-	 * See IEEE P802.11be/D7.0, Table 9-417o.
+	 * transmitted by an AP.
 	 */
 	if ((ieee80211_mle_get_ext_mld_capa_op((const u8 *)mle_a) &
 	     (IEEE80211_EHT_ML_EXT_MLD_CAPA_OP_PARAM_UPDATE |
 	      IEEE80211_EHT_ML_EXT_MLD_CAPA_NSTR_UPDATE |
-	      IEEE80211_EHT_ML_EXT_MLD_CAPA_EMLSR_ENA_ON_ONE_LINK)) !=
+	      IEEE80211_EHT_ML_EXT_MLD_CAPA_EMLSR_ENA_ON_ONE_LINK |
+	      IEEE80211_UHR_ML_EXT_MLD_CAPA_ML_PM)) !=
 	    (ieee80211_mle_get_ext_mld_capa_op((const u8 *)mle_b) &
 	     (IEEE80211_EHT_ML_EXT_MLD_CAPA_OP_PARAM_UPDATE |
 	      IEEE80211_EHT_ML_EXT_MLD_CAPA_NSTR_UPDATE |
-	      IEEE80211_EHT_ML_EXT_MLD_CAPA_EMLSR_ENA_ON_ONE_LINK))) {
+	      IEEE80211_EHT_ML_EXT_MLD_CAPA_EMLSR_ENA_ON_ONE_LINK |
+	      IEEE80211_UHR_ML_EXT_MLD_CAPA_ML_PM))) {
 		NL_SET_ERR_MSG(extack,
 			       "extended link MLD capabilities/ops mismatch");
 		return -EINVAL;
-- 
2.53.0


