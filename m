Return-Path: <linux-wireless+bounces-31313-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4G4LLfI6e2mNCgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31313-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 11:48:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE65AF140
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 11:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CA4C31465B7
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 10:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93A0387352;
	Thu, 29 Jan 2026 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="E0oJdRA8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA5538A9BE
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 10:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682985; cv=none; b=i4HEkxvZD5zUU80gMn5guhYXyJAnzpCwjCMIizcmXWaixCWPqGacHCfg3tvN/0PFnXDyVkjhSCLVcSL0esJgT0pclHol7DP0V6sKiXLRRFMsF6m7ax+k7LWFAyYfJFmhHBvdozKSbMvpdHKALtPviTUREKYtbT9jk317DVNQ2AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682985; c=relaxed/simple;
	bh=rgD+ysgMMEMqoqUEkNiOsy7+h2UOYFdEYokKTmUdSHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k+KHEN9rYS5GLKDcWvPVa3l/BDHFF2M98BrRh+sKEfIxkrcPLktb5PTdgJeIqkMK1gsuPv5MGm/gl45ij0jBvN5a+ft5pb886JPcydb6E/AjnR3rz3bhmK5Aht5AseCopqGui1Whdqo9AUOh1akWnCxHtcVJkDyKDdAo8i1ujTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=E0oJdRA8; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=PwiC+usbvSDB1VTVJXXSolw+QqXt7GfdhjlWDz+XWWI=; t=1769682984; x=1770892584; 
	b=E0oJdRA8lQKiTUyL5wu2fSXAEdCEkIRLol8dW/KJWlANbR+wWoOIHQ3cWQPZtZoGcJNZrUEdmVw
	VyoXDYbKY05XbmufDcTxWGLmad6FRGySQy5TB+Gr7GPLhMgoF/MEdo3SbIGZ5YoV/Vbje6Lz6OJtc
	hKtfYZcy5jfXqz7JMNbat8vq9E0oyD31T6npjapb3dbKFJ1OmaXXfPIpVoVBcR+VTaw2wWVXLHK1V
	/9oPXXA7AgrdsuHQoHRu3NO8jzi+tHyCKb/DoManWj2W5qtHEvbxhr8AMSNxRalkhdG3rMhXUSk8h
	wkYPoJoxGjmpFGe82RDPLB7vbLE0SUzWXhag==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1vlPNt-00000006mzE-2J8M;
	Thu, 29 Jan 2026 11:36:21 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Ruikai Peng <ruikai@pwno.io>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211: correctly decode TTLM with default link map
Date: Thu, 29 Jan 2026 11:33:50 +0100
Message-ID: <20260129113349.d6b96f12c732.I69212a50f0f70db185edd3abefb6f04d3cb3e5ff@changeid>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-31313-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2CE65AF140
X-Rspamd-Action: no action

From: Benjamin Berg <benjamin.berg@intel.com>

TID-To-Link Mapping (TTLM) elements do not contain any link mapping
presence indicator if a default mapping is used and parsing needs to be
skipped.

Note that access points should not explicitly report an advertised TTLM
with a default mapping as that is the implied mapping if the element is
not included, this is even the case when switching back to the default
mapping. However, mac80211 would incorrectly parse the frame and would
also read one byte beyond the end of the element.

Reported-by: Ruikai Peng <ruikai@pwno.io>
Closes: https://lore.kernel.org/linux-wireless/CAFD3drMqc9YWvTCSHLyP89AOpBZsHdZ+pak6zVftYoZcUyF7gw@mail.gmail.com
Fixes: 702e80470a33 ("wifi: mac80211: support handling of advertised TID-to-link mapping")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index b72345c779c0..73f57b9e0ebf 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -8,7 +8,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2025 Intel Corporation
+ * Copyright (C) 2018 - 2026 Intel Corporation
  */
 
 #include <linux/delay.h>
@@ -6190,8 +6190,10 @@ ieee80211_parse_adv_t2l(struct ieee80211_sub_if_data *sdata,
 		return -EINVAL;
 	}
 
-	link_map_presence = *pos;
-	pos++;
+	if (!(control & IEEE80211_TTLM_CONTROL_DEF_LINK_MAP)) {
+		link_map_presence = *pos;
+		pos++;
+	}
 
 	if (control & IEEE80211_TTLM_CONTROL_SWITCH_TIME_PRESENT) {
 		ttlm_info->switch_time = get_unaligned_le16(pos);
-- 
2.52.0


