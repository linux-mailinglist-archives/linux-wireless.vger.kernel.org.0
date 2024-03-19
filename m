Return-Path: <linux-wireless+bounces-4885-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9A387F913
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 09:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3FEBB2233C
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 08:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112A77C6C1;
	Tue, 19 Mar 2024 08:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SIh8Lu7O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6A77C0BA
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 08:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710835854; cv=none; b=n17NF8yzo7ISDUe3wn3J6NkTV24gigKMRj6NttPrKiQPdqTJDIouxNiOx49EaEsXc+djYIFAlBkpvk2PLAdv+LRQkRYQ4PnD9yA+KAocRsd+f/Gbs0WEUiNjQR2B0HhWnkLQf0OBeAO+qoQjHBQY7KMtGagSmCpTqh6ap8eulW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710835854; c=relaxed/simple;
	bh=qz2pvngmX6oK/ewug1vIgUqeObuMjoCkTr8rHSHDR3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KyCwyvh/QI1J52OIfTdOTDAQX4TOQr9gajoNTHL0vRGLOoENe6TbfuJBe1pkmT4BhulfHvF/iviBcchlnUmBjlRZwRK6koJ0cjrXh3/1Uo4PUuKcHE9vcCeNw+dZOUF7Izrj2XjeGCN7YsLTWafeQquLOaRoMr/FZRLfW6uxJpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SIh8Lu7O; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710835852; x=1742371852;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qz2pvngmX6oK/ewug1vIgUqeObuMjoCkTr8rHSHDR3M=;
  b=SIh8Lu7O65OBzzj4xAhFabzrpYhcbU50Ig9zbYRujmePqPgRS3ZnAmzu
   0KeAUpOnYfzM8983WHNyH37z3Uo4jz57+tqCTVF1mS50ep8UTlXHPz+sm
   Fk++OSM30qIqXQYIs9klZaOMA3GmJTwMuXR0ZGO/Amp5yqZzjtmA3MldK
   N54dNceZJcjwdnGeZ85h1PNO8AN1gE91u+fUERAafmsFXDY+EZnMRSaZ8
   +z76ML0UP1XW/TgyDXg+AMG/8v7VuVi5nHm4QMebw3I0/s6i7DXOr2bre
   O8Jug6tCOJnCbaSzCERYJYL1QWPERCuW+T+zLSZFsngsE6YVR47jBt6ng
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5810543"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="5810543"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 01:10:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="18447596"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 01:10:50 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH 05/15] wifi: iwlwifi: mvm: rfi: fix potential response leaks
Date: Tue, 19 Mar 2024 10:10:17 +0200
Message-Id: <20240319100755.db2fa0196aa7.I116293b132502ac68a65527330fa37799694b79c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240319081027.3853611-1-miriam.rachel.korenblit@intel.com>
References: <20240319081027.3853611-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If the rx payload length check fails, or if kmemdup() fails,
we still need to free the command response. Fix that.

Fixes: 21254908cbe9 ("iwlwifi: mvm: add RFI-M support")
Co-authored-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c b/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c
index 2ecd32bed752..045c862a8fc4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c
@@ -132,14 +132,18 @@ struct iwl_rfi_freq_table_resp_cmd *iwl_rfi_get_freq_table(struct iwl_mvm *mvm)
 	if (ret)
 		return ERR_PTR(ret);
 
-	if (WARN_ON_ONCE(iwl_rx_packet_payload_len(cmd.resp_pkt) != resp_size))
+	if (WARN_ON_ONCE(iwl_rx_packet_payload_len(cmd.resp_pkt) !=
+			 resp_size)) {
+		iwl_free_resp(&cmd);
 		return ERR_PTR(-EIO);
+	}
 
 	resp = kmemdup(cmd.resp_pkt->data, resp_size, GFP_KERNEL);
+	iwl_free_resp(&cmd);
+
 	if (!resp)
 		return ERR_PTR(-ENOMEM);
 
-	iwl_free_resp(&cmd);
 	return resp;
 }
 
-- 
2.34.1


