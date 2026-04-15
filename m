Return-Path: <linux-wireless+bounces-34775-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sF02KqeI32nSUgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34775-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:46:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BE2404680
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC3BA30A8F1D
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 12:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC18218E91;
	Wed, 15 Apr 2026 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KfBxoaOX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A276C322B8F
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257122; cv=none; b=EYNCebVeqaoOLnBzv58qddoPXHXbLyMtYeNeWbGlUQtGUfUzqIrlwFvs56mAZ4UpIu14mch8p/JLsEETJ6rACr06QPDpPsh8vDhcdVG2JE97uOPr1LFcWI4TE1rOPNlWWUgoTvmWIiYwTHEc3NQXtj/OnLYJGEmVss7taa2TeSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257122; c=relaxed/simple;
	bh=KBGHTF0K5QDUtUOV7gzR52JgA4FuDfZCh1aOFHqY0h8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmc66oEFD3a62/YsCCH5x66ai0ib+Z6ioj9tmo/uh7V2udlQ6sWzG06q4uIsfUqtlT+vkMuf6Gg1xydeFl4oAP67gaI2fLrlkLIZpx53MhtRI5NdQz0jJJEQQlT6ob4XyylzFmvK6jqosF6KwxeDS5UYzgnaPNIRu20tYytrMqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KfBxoaOX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DrWbsfp7jdnZu3N5WWwdlM2TVbl0G0ASGPIm1anKKj4=;
	t=1776257121; x=1777466721; b=KfBxoaOX4pzMvFwmaLq4bqBLMNfyfGD8sljpaUHBCLpVcpd
	mxFucKFguxbzCPiSHFGRDtgssFNcnW/NjaCAftnkQnIArRrGZZBLSgU2HdyLVdVf6YxcXKZkhNv5C
	yhKUbWl4xKPMM1KPpbCCCL/Fi0qPErxHYFZdAKYD7dFfLhsJXlRICdHwVTFbgbqdX4DrkVvODjXkc
	lA1ysALSuSeKHzT1JhuzOR1dcw2+4tPD95wDDWopcQjlWnkFjR0DZVM7wphOG/QwPy2AjuEfzZgbz
	CWLbmxfMvZuofOFn21SGkzCT8QbaCSt1rAdAyJlWbyuqqZKQKbuVREmPSs3eqeiA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wCzcN-00000006OgW-1iAb;
	Wed, 15 Apr 2026 14:45:19 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 03/20] wifi: mac80211: use max BW for HT channel width update
Date: Wed, 15 Apr 2026 14:42:01 +0200
Message-ID: <20260415144514.bab6e4195d78.I9683605229ed1b75ff5a9c14e967762e88b3fc36@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415124514.284345-22-johannes@sipsolutions.net>
References: <20260415124514.284345-22-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-34775-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:dkim,intel.com:email]
X-Rspamd-Queue-Id: 56BE2404680
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

When an HT channel width update comes in, don't use the
capability of the station, but rather set it to max as
the capability will be taken into account anyway when
using the value.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ht.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index 8f76440e9e48..7d587f968a7f 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -631,7 +631,7 @@ void ieee80211_ht_handle_chanwidth_notif(struct ieee80211_local *local,
 	if (chanwidth == IEEE80211_HT_CHANWIDTH_20MHZ)
 		max_bw = IEEE80211_STA_RX_BW_20;
 	else
-		max_bw = ieee80211_sta_cap_rx_bw(link_sta);
+		max_bw = IEEE80211_STA_RX_BW_MAX;
 
 	/* set cur_max_bandwidth and recalc sta bw */
 	link_sta->cur_max_bandwidth = max_bw;
-- 
2.53.0


