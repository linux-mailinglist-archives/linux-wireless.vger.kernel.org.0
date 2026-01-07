Return-Path: <linux-wireless+bounces-30438-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB007CFD93A
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 13:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 271AA304DE18
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 12:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC4A30BF6A;
	Wed,  7 Jan 2026 12:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NZ5oYAEX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD861D5160
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 12:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767787704; cv=none; b=s0Ja5Zi6c6C9tPbLuMkWc2rzHsaPOgZ7IIiOWgz4ooVxowtVVzq3nZNukSQkS+zaSlZOAVhKMatkqlmJvnlXNK1o4uldmtcGFLNpvWKBvnveMmAA7krvbK37XScgFyVPuBR9MOS4PZk+t57a6TcJ/hMOPfEo4hs9ZC/mZ4YhuT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767787704; c=relaxed/simple;
	bh=dZbc0ye3zijikw4SAKktxsWn8w4oMM74ooP5BjklD7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DwpDRmUEW+QH4cRBnOZ1GU88iW56Qzd9ZfiPwWXvimZ1LfEl6Hozn22lqThHSAkwPQjuTYbFQA60EJUrn9jwo/vjMG2BaWZjZGmZrN6d0nGbVnQDnBHk+22eCN8dsClNegz9aOTsMYSCTPuoV8USWIH/nV2nSKDb60uZfjyQ4Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NZ5oYAEX; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767787703; x=1799323703;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dZbc0ye3zijikw4SAKktxsWn8w4oMM74ooP5BjklD7Y=;
  b=NZ5oYAEXdRky073KqxErqUahRss157iHSb1tGS2fmhYEu9TU70hNurOk
   lybyHc3oFmPkiR5z8Z0XXOFmGrsYuoHUeOcni3Z0ij2LHOIRLiwt7eE43
   l4RuZoHCf4TSPddGAQBlvkATAZlcMtGT/ZaID+VVlbl3h2UExVUVwCsJc
   eh94k54/FRZWHkphyxOB9jJtaqYTWucA4AQ55m89aFA8DFpEUtVJi8MUI
   jnP1iW+D/sSl3Yso8HxHxcpIk1agh9pG7kLalikixpWWaZUg4cFhE4Xro
   BrzYVPsG8D6gcU3HcI02Cf3VqHDu/Esus5xNKOWODAcBqW9Ku0THDt2/m
   Q==;
X-CSE-ConnectionGUID: ZrwYGWHdTgGg9qRBeHVFmA==
X-CSE-MsgGUID: /UfXvl9OTJKs+1oy28H8OQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="69314582"
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="69314582"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 04:08:23 -0800
X-CSE-ConnectionGUID: pVZfUX9ARuO0Z0NvDR8Kew==
X-CSE-MsgGUID: 1KU/SZZXQTmrc6Ffwrq1kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="240388041"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 04:08:22 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: cfg80211: limit NAN func management APIs to offloaded DE
Date: Wed,  7 Jan 2026 14:08:12 +0200
Message-Id: <20260107140738.e00670b645ba.I8fbb0506377170dd7b41234f20bcba057951dd1e@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

A driver that declared that it has userspace DE should not call NAN func
related APIs such as cfg80211_nan_match and cfg80211_nan_func_terminated
Check and warn in such a case, as this indicates a driver bug.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/nl80211.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index c961cd42a832..26c1b0caf3af 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -16106,6 +16106,9 @@ void cfg80211_nan_match(struct wireless_dev *wdev,
 	struct sk_buff *msg;
 	void *hdr;
 
+	if (WARN_ON(wiphy->nan_capa.flags & WIPHY_NAN_FLAGS_USERSPACE_DE))
+		return;
+
 	if (WARN_ON(!match->inst_id || !match->peer_inst_id || !match->addr))
 		return;
 
@@ -16188,6 +16191,9 @@ void cfg80211_nan_func_terminated(struct wireless_dev *wdev,
 	struct nlattr *func_attr;
 	void *hdr;
 
+	if (WARN_ON(wiphy->nan_capa.flags & WIPHY_NAN_FLAGS_USERSPACE_DE))
+		return;
+
 	if (WARN_ON(!inst_id))
 		return;
 
-- 
2.34.1


