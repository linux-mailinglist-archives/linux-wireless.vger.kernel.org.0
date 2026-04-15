Return-Path: <linux-wireless+bounces-34779-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJttLbqI32kHVAAAu9opvQ
	(envelope-from <linux-wireless+bounces-34779-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:46:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7834046AA
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E91630D43B8
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 12:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4462C330B3B;
	Wed, 15 Apr 2026 12:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QK4jdy3R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8513F32C957
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257125; cv=none; b=u2bf9fdedz0VpSDdfPnKOYTdFq6dpbI3cV7wr3c+vqndTHDOzVUzmPuKpK/Sdca61VR+Izj2rpknV4Nxmb68SGdMjFnvO9Gx7fnMnYQ0Kez/zqCPgs8itR8KC69IgdKkyh9osWLYOPAnGPT8itY4UvUrpw4RkSnYAN8DmE1XGWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257125; c=relaxed/simple;
	bh=+F3mguTM9SHT4gKoJsMtR62RuiRz6UwW3fuybjYKDx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WkjhAgkzNPpJcPt9SRq+1BsSq9aPKezjZCy46UFcnfYI7N/xPhIpeWyDftMZp5HAo+9THK2Cq7RmUHKBv4SqHyUqYfsvk/GNjCr4Ftw2XMxxhsmDV5fk6pIc5hB0fxnkqxMDtj7X1YQamtZKdUujM2d00Mn9JV0BgBkJ/bnP3g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QK4jdy3R; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=c4qKcJQAcF3KOjB5gngOy8Lyj0rz4CM0fJVM9NMgZGg=;
	t=1776257123; x=1777466723; b=QK4jdy3ROHvVCQlcgT7b6AfMQsIF445IFu0jfFEXVwT8tok
	d0iG62er+8gFsJAcbfytw5mxcVzIHEtEpIylGeMjT1Fv8NKd7jrk/nq6dGu8kUx+I+xFjiRLJM5em
	sUBEor7FtdtbfSg8+1m2xFEhbVf3PgTjkx1H/raPdPUrj/SY0/Y5eSKTUypkAzPsHwtPgMlx5oB2R
	jNQVOMui1w3Mnnk2rZMECja5dPceCkK/6pzpZdvqUjEH6lFMspl7RHXBRt+aJs68Vklv5gLYkiWko
	nHZC+KU3jnFFZ6zNbfURIg8aQoHFieoe6DNlyGm+v8BXb4WyPMG9Te3SldA8ZliQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wCzcP-00000006OgW-2Yn3;
	Wed, 15 Apr 2026 14:45:21 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 07/20] wifi: nl80211: document channel opmode change channel width
Date: Wed, 15 Apr 2026 14:42:05 +0200
Message-ID: <20260415144514.87d5b1ce688f.Ia9a0769d52dcfe56f7b0dff903ed14db3ef04920@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-34779-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 6B7834046AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

The opmode change notification is entirely unused by existing
userspace except for printing out the values. As such, there's
no need to keep it perfectly accurate, and the implementation
in mac80211 doesn't report it correctly today. Add a note in
the documentation that it may not differentiate 80+80 and 160.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/uapi/linux/nl80211.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 3d55bf4be36f..072b383d7d3c 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1204,10 +1204,12 @@
  *	user space through the connect result as the user space would have
  *	initiated the connection through the connect request.
  *
- * @NL80211_CMD_STA_OPMODE_CHANGED: An event that notify station's
- *	ht opmode or vht opmode changes using any of %NL80211_ATTR_SMPS_MODE,
- *	%NL80211_ATTR_CHANNEL_WIDTH,%NL80211_ATTR_NSS attributes with its
- *	address(specified in %NL80211_ATTR_MAC).
+ * @NL80211_CMD_STA_OPMODE_CHANGED: An event that notifies that a station's
+ *	HT opmode or VHT opmode changed using any of %NL80211_ATTR_SMPS_MODE,
+ *	%NL80211_ATTR_CHANNEL_WIDTH, %NL80211_ATTR_NSS attributes with its
+ *	address (specified in %NL80211_ATTR_MAC).
+ *	Note that 80+80 and 160 MHz might not be differentiated, i.e. may
+ *	report %NL80211_CHAN_WIDTH_160 instead of %NL80211_CHAN_WIDTH_80P80.
  *
  * @NL80211_CMD_GET_FTM_RESPONDER_STATS: Retrieve FTM responder statistics, in
  *	the %NL80211_ATTR_FTM_RESPONDER_STATS attribute.
-- 
2.53.0


