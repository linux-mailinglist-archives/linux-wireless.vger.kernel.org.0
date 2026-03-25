Return-Path: <linux-wireless+bounces-33845-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGeeLuTrw2kAvAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33845-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 15:06:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24187326685
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 15:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABAED3216FC9
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 13:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210153CF05A;
	Wed, 25 Mar 2026 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kw7bL28x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DDA2505B2
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 13:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774446209; cv=none; b=qhlXztuC9vIVjq5jwBgXY+I8bZEe5vr1W/uJ/h7+VgDmZLXMbU6Yfknw+oFonC2eK7sgb5V7FiMpfoXKt68phG837b6a3DlWcuFQcs7lR9wd+km9ODPoXzXF8jwymcJZUBiC5iAWg1BbEmEU05ej+TLeXkCePL8mBwoBwOrq6pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774446209; c=relaxed/simple;
	bh=xFcev5SvQsqItmox/rdEMsVOR3+DrK0Z2tAh9QN81HU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LQ72cR8pbhVBgvG6uk2+EbY4m3DLhth6P+vaf+/w9T0PHi4rn9CxUjrHvrIBdU2G3qGHEc3hNKWVkFxxVRerlxtzJbuufvwG4pSapBUJIko9dfU0jlGvQtpq8YpxxlPaKX6Nd1MU/RN2CYC8fSvkLnclQ5BgYZeFl7JIMttVrtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kw7bL28x; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774446208; x=1805982208;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xFcev5SvQsqItmox/rdEMsVOR3+DrK0Z2tAh9QN81HU=;
  b=Kw7bL28xCFS/8h5KfeL4k6hps8RMztZHoBwxN8mgfytftGNViA2K+N84
   xQBQefltuA7eeIBL7dO8oR39LuVZgZcdtbgNZfv+Z60Vdy8/K2oGeSBlu
   NT62SZSTnnjn8SgY5VGKiLnfvg2i360B3FAsGkllP2IJ8MO9hNLbbaSUj
   erS+G8i+hUABOx2tQhWKSS8WmjB6b/SqqRhqiHCTBo/s1edvCtpmHWexz
   ogGW7MDfl5nUUXSktNma72tt89s0Tg8uRiV/v+4tQJVsZ2E10+tN7u8aV
   0hAJH7Y9CtC5PsPO9KgvnsQxfrpDtfXLyTlvoJ3LC6pxIOyiBVaPgOYHT
   Q==;
X-CSE-ConnectionGUID: PcC0vEebQWy2FWYJxA3zSg==
X-CSE-MsgGUID: h4ZyO/L+SkOWD7soR7zxRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="79339442"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="79339442"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 06:43:28 -0700
X-CSE-ConnectionGUID: sdhpgkEsRc+q6R3+JL4L3g==
X-CSE-MsgGUID: ZO2jEJuEStuKTCLuBzacAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="229624282"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 06:43:26 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH v3 wireless-next] wifi: mac80211: ignore reserved bits in reconfiguration status
Date: Wed, 25 Mar 2026 15:43:15 +0200
Message-Id: <20260325154226.20abd4ac4071.I9aef8f4fb6f1b06671bb6cf0e2bd4ec6e4c8bda4@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33845-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 24187326685
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Benjamin Berg <benjamin.berg@intel.com>

The Link ID Info field in the Reconfiguration Status Duple subfield of
the Reconfiguration Response frame only uses the lower four bits for the
link ID. The upper bits are reserved and should therefore be ignored.

Fixes: 36e05b0b8390 ("wifi: mac80211: Support dynamic link addition and removal")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
--
v2: added structs and macros, as required.
v3: fixed the Fixes tag

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 173a60360a45..51a259aa8568 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -10471,7 +10471,7 @@ void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
 	for (i = 0; i < mgmt->u.action.ml_reconf_resp.count; i++) {
 		u16 status = get_unaligned_le16(pos + 1);
 
-		link_id = *pos;
+		link_id = u8_get_bits(*pos, 0xf);
 
 		if (!(link_mask & BIT(link_id))) {
 			sdata_info(sdata,
-- 
2.34.1


