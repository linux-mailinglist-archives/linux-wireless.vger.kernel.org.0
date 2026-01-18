Return-Path: <linux-wireless+bounces-30936-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21752D39331
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jan 2026 08:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF85A3004863
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jan 2026 07:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994BF246797;
	Sun, 18 Jan 2026 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dmCbCKzB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DBA2459D1
	for <linux-wireless@vger.kernel.org>; Sun, 18 Jan 2026 07:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768722869; cv=none; b=RJVghyhndZnGwuZGO0ptMIC/Z75g5ZCZ5WPmOvxS6AzZe0pboPGEFRBRXd58sdEnV5umKM/irb15k2qHO1Lof7DytOfJbSngoai12tdyJWA8ZrUQMMjbVfTSoep8R7TZ6DpM+vz3e3q0MXxoFrqu6bfIIwHEPUShfRlqyXTEG3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768722869; c=relaxed/simple;
	bh=Z6CUuOJAqmLF9qeQmgNArgVX00USa1L+nf1BSJKApn4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YQ0TcVCYamkGHOy3VU8v+TKJZrDC7VM9PEYlUw0qU4/zOJGxweol1FnhoJJPcmX6mw01+gAX7jEXujnb6e4pa8udVyEO1292Yn5lObY1rGJzUL3C+YHBYfG0zBIjWn8xhdF/hxuBDjWcm7RGOmHaqGQ35Z/UbHPc4MkOBHjaH/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dmCbCKzB; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768722868; x=1800258868;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z6CUuOJAqmLF9qeQmgNArgVX00USa1L+nf1BSJKApn4=;
  b=dmCbCKzBZWS7S7NMeCZisf32FF7Pez9DO+qcqf7wGCemYbpoMlqJhjpP
   IoZgAzVN/FhLAO30R3vBlpmRIRZio7+bGDaHOGmXY8HIpTmU4E7zMJBai
   4Unklq/D4Qar98rcHGlx55tuoAF/+IOvmb0Bh6R3O2j4fbUWGwqNhle8z
   ejdzxnWL5sAFcP+wp2Zb5Vb4L0VtRv5wf0RRpg+pHyJ3T3hErXBWJHAdm
   DLLQ0cAgtbZqk4E8Mys6nUFU9R5JHyY+/WcNYJSDIyqD0mv0rIFdLUHCQ
   1qu95UABTFwBK9NeloHpXQ6tFpWrrpHUVu3qkEZKk5FZh3jFOULUSwZS7
   Q==;
X-CSE-ConnectionGUID: bFIKXoR4QHmSyxzamJspRg==
X-CSE-MsgGUID: EAgPYwosRFaFkqnROqqppA==
X-IronPort-AV: E=McAfee;i="6800,10657,11674"; a="69882356"
X-IronPort-AV: E=Sophos;i="6.21,235,1763452800"; 
   d="scan'208";a="69882356"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2026 23:54:28 -0800
X-CSE-ConnectionGUID: Rt0nQoAhTpy5SCQgsfBnTg==
X-CSE-MsgGUID: qPsV2NzjQg6XzCMMwTJAOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,235,1763452800"; 
   d="scan'208";a="243158189"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2026 23:54:25 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH iwlwifi] wifi: mac80211: ignore reserved bits in reconfiguration status
Date: Sun, 18 Jan 2026 09:54:16 +0200
Message-Id: <20260118095410.e54a0830f697.I9aef8f4fb6f1b06671bb6cf0e2bd4ec6e4c8bda4@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The Link ID Info field in the Reconfiguration Status Duple subfield of
the Reconfiguration Response frame only uses the lower four bits for the
link ID. The upper bits are reserved and should therefore be ignored.

Fixes: 529766edcdbd ("wifi: mac80211: Support dynamic link addition and removal")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index b72345c779c0..fe9283fc413e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -10243,7 +10243,7 @@ void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
 	for (i = 0; i < mgmt->u.action.u.ml_reconf_resp.count; i++) {
 		u16 status = get_unaligned_le16(pos + 1);
 
-		link_id = *pos;
+		link_id = u8_get_bits(*pos, 0xf);
 
 		if (!(link_mask & BIT(link_id))) {
 			sdata_info(sdata,
-- 
2.34.1


