Return-Path: <linux-wireless+bounces-35904-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SB5ACfvt+WlqFQMAu9opvQ
	(envelope-from <linux-wireless+bounces-35904-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 15:17:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 286A44CE4FA
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 15:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E716300623F
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 13:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F9315E5DC;
	Tue,  5 May 2026 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oP8uH0A+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799E3426EDF
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 13:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777986771; cv=none; b=tV7A/P4+30c59x05mOvkX+ccyyrsIv0MZ+0iADMWrPukzfFQD80ZlQABy0rw11F3cZfUCiFL4Zt6jcAXJ1Pjn9MzLeBWbxpotsjqzMxRBiL3xuTKPzcsIHAqELQlrNU3YpbqEbpIb07tpVaaBjmzSLXSCgwVUikErqf53PgP62A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777986771; c=relaxed/simple;
	bh=fQoDepXunJY6zLSPfzyh0QNkVQyqt9rVMn/GzLXSPSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rQxfIvQVyF5EaR97TQcQYmKVlUjAWhhWh0d4si2Yqhrbb4P/dsUxTvVeanxPktE917pesWnpp0bjGU1Xn13a3vjQbtcz2GodH4QTJlrbrwxLIwaJK8oTNWWSEBItSQkefupqh8t8OBmZmlKOifNmune3y+tIuVGSpFy7ka+eHA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=oP8uH0A+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=qzYlRnKLecimkelaVkm4QGqRI1oNaZm6u7lc+tumsm4=; t=1777986769; x=1779196369; 
	b=oP8uH0A+UYZq5ouuU+J6gYz4pxX5bzalhgdH3u6F9kzxIlTjcX+XqFqeXLvR389gptbR95frfK+
	+wVCNEmlFKwaRuhrVNzW6iVxoqwE7VX1xGMGIYDJ5hc/8YfG88u0LPxBWhGnJxfuP2q82NsKCNvIn
	aqX1c3M8aVg36NDcLfhxLGrGRL1RKGB84bl801XDK3EvcF252Ehqgus0SxIYBMDpnXg1QOl5CrqG6
	z1GNE0k4FZ/Hu9kkgAT7eZVOZnEdYgX8iWueUUP2qG4VUAXfvP5LRLjh22nBBhPYxgDkEvIB82/nM
	roTXA16kAZlcTcdThGjhks23lpsQ8CgbtbDw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wKFZu-0000000GENC-26v5;
	Tue, 05 May 2026 15:12:46 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH wireless-next 1/2] wifi: iwlwifi: don't blindly start the responder upon BSS_CHANGED_FTM_RESPONDER
Date: Tue,  5 May 2026 15:12:15 +0200
Message-ID: <20260505151241.285da8fbf7f4.I1b6922ca8d06d592356d7a5d190e6118fec1d5b5@changeid>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 286A44CE4FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	TAGGED_FROM(0.00)[bounces-35904-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,sipsolutions.net:dkim]

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

mac80211 may just want to stop it, so check the ftm_responder boolean
before starting the responder.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c     | 4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 214e6d10081b..c256cbc6602e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2026 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -3144,7 +3144,7 @@ iwl_mvm_bss_info_changed_ap_ibss(struct iwl_mvm *mvm,
 	    iwl_mvm_mac_ctxt_beacon_changed(mvm, vif, &vif->bss_conf))
 		IWL_WARN(mvm, "Failed updating beacon data\n");
 
-	if (changes & BSS_CHANGED_FTM_RESPONDER) {
+	if ((changes & BSS_CHANGED_FTM_RESPONDER) && bss_conf->ftm_responder) {
 		int ret = iwl_mvm_ftm_start_responder(mvm, vif, &vif->bss_conf);
 
 		if (ret)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index f1dbfeae20bc..6ea9a7c8da0c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2022-2025 Intel Corporation
+ * Copyright (C) 2022-2026 Intel Corporation
  */
 #include "mvm.h"
 
@@ -729,7 +729,7 @@ iwl_mvm_mld_link_info_changed_ap_ibss(struct iwl_mvm *mvm,
 		IWL_WARN(mvm, "Failed updating beacon data\n");
 
 	/* FIXME: need to decide if we need FTM responder per link */
-	if (changes & BSS_CHANGED_FTM_RESPONDER) {
+	if (changes & BSS_CHANGED_FTM_RESPONDER && link_conf->ftm_responder) {
 		int ret = iwl_mvm_ftm_start_responder(mvm, vif, link_conf);
 
 		if (ret)
-- 
2.53.0


