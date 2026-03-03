Return-Path: <linux-wireless+bounces-32393-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HOZFIvtpmlKaQAAu9opvQ
	(envelope-from <linux-wireless+bounces-32393-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 15:17:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CEC1F1466
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 15:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96B1030EF1E0
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 14:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFAF372EE7;
	Tue,  3 Mar 2026 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="cRlPkEE2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EB7372ED8
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772546918; cv=none; b=TurtNvdzqoLACg5oGzmKb+XyVQwaznxPHvVUfTNfsrTYp+j878pQVTUZrbFRQwaE/vA4w64SmjoMYR4wUeeEZGj53Ot2yJxvk9TqDrJgqLwg00GVr1ORLP3kyxKWdB25XfPjWgPoE21ld6kp58rnIhnhqCJUPq26ZEIKl0KbM8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772546918; c=relaxed/simple;
	bh=KS24dSTpVRteMORqF3OiUOORoZgCEX1WvCFtXhf9S9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fE0DHJQv/khdt9CxxS6wkXPJUwIkrbt42LGaJ0oFPv8LPJ8L2th5D9MDY4Tl53VZ/HKQqWt1ZyI5sI7a2mBFQoft2I3duCi3GuCHq8IC4suIGPRZ5rSxD9HxfJrStaPsIRj9FGU4mJnzYJDves6f0/Rjme1MRcA9FeVWZSjvipo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=cRlPkEE2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=MAZN0NcuJpHXJBtKV6gDSju9mgkI5rFCHkd5Jqd78rE=; t=1772546917; x=1773756517; 
	b=cRlPkEE24vMu93eRL0XTPCXQ2LmuwhKy4SPABpiKh3HlzVTEXU7rBz6NiK4PfgF9VAfvXUF843u
	71/E/QUp1CpjtvcrVWSAK6aJcdlIPSMd2mYcPiTI7Ve9zIdNCq0KfpekWE1rl6YKJvqh9Aa/P+kWz
	PPnXyAzK6M/pw5bDMNnVQOD6TZShiYry9NBnLsIsmEnvXKCBcqbpJJMIg6gw9TyhjXZDh09s//cb6
	E5DF3Kr9hmbeDMFL4wmS/SlETm+aN29wNCzC96gWyBcxehUHvPjsH/rm+djEd7r7SLYog1jUKrVkc
	XHRoufe094Ta8QuiYBkSh9PN/dDAWAWrj+Ew==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vxQQM-0000000794C-3MvR;
	Tue, 03 Mar 2026 15:08:35 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH wireless-next] wifi: mac80211: validate HE 6 GHz operation when EHT is used
Date: Tue,  3 Mar 2026 15:08:33 +0100
Message-ID: <20260303150832.74b934163b99.If4d1db3f39c37900cf0d0f4669cd5f8b677daaa0@changeid>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B4CEC1F1466
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32393-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

When in strict mode, validate that the HE 6 GHz operation is
valid even when EHT operation is used instead. This checks
that APs are advertising correct information for HE clients,
without testing with such clients.

Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 170330d924a3..3bf18ce9cff1 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -216,6 +216,24 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 			return IEEE80211_CONN_MODE_LEGACY;
 		}
 
+		if (eht_oper && ieee80211_hw_check(&sdata->local->hw, STRICT)) {
+			struct cfg80211_chan_def he_chandef = *chandef;
+
+			if (!ieee80211_chandef_he_6ghz_oper(sdata->local,
+							    he_oper, NULL,
+							    &he_chandef)) {
+				sdata_info(sdata,
+					   "bad HE operation in EHT AP\n");
+				return IEEE80211_CONN_MODE_LEGACY;
+			}
+
+			if (!cfg80211_chandef_compatible(chandef,
+							 &he_chandef)) {
+				sdata_info(sdata, "HE/EHT incompatible\n");
+				return IEEE80211_CONN_MODE_LEGACY;
+			}
+		}
+
 		if (mode <= IEEE80211_CONN_MODE_EHT)
 			return mode;
 		goto check_uhr;
-- 
2.53.0


