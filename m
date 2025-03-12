Return-Path: <linux-wireless+bounces-20279-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFE0A5E74B
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 23:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F02547AD7AC
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 22:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21D71F03DA;
	Wed, 12 Mar 2025 22:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZOP/TC+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D074685
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 22:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818193; cv=none; b=qoPE2EVLo5i7jUvZNXmAt12ND5R9Ke9kQqErS+LvOoA9lqYDiLshZUk5khCj98tH6/GomQI/Reje4gHHAdqwnYObUT6/aST8lLWs3b+N0cYPkIcdqvq6/eikOdsCTauKK/pD209lq5zUrFf0EGN1CPZMVC9vfdY/m79FQBXbEjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818193; c=relaxed/simple;
	bh=j99Cc8/8NDbZkAoHh9Gt/3Nl+XnHUeJwDRUGXT4vfo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XtccXxrDVKHZgpcOQQ1l6EomQWWiI+ZYQqrCLVZqlf4tKl5//bMSEQM7ljP4ZxpsizJJLIQZzIAmcNDXZG2btHskFpabCvayRjMBrU5RQqvcOieyoz5eadqQz8lEI3xYlhgV+o0EueghI2mj+gY0hx5BshzJjHA7VnjVjdFSQqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZOP/TC+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741818193; x=1773354193;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j99Cc8/8NDbZkAoHh9Gt/3Nl+XnHUeJwDRUGXT4vfo8=;
  b=JZOP/TC+dHpbwA8UJtRGVTah0WGtZFRW7q54m8GFBgj0VsfKYu/EQAKY
   EIPOTuK1CzoS4gU4yu0dLpUBVbL5rG/9zl0tcoZ+caGQezz6CnUUkZNt/
   WqdwEpig/QxQyeAG4+4gkFyHq9tcOVOsTsn3mGFqf18wC2caM488bDjal
   zW7J04EblO/WgmSpojvVPtSwiT2mt1uj45vsl0XHwjcmVJWOJItNLvl2P
   +LtSHjbFl+JfByjIv9g2qr+ucLWiToatLe3wOV+ZMEgPSGY10oeqGwUsH
   rx4AcmYwylamHf1MyDl/EmPU43uS26DYOBDZK+Bym8k8TTXSRjYEcnHBj
   A==;
X-CSE-ConnectionGUID: +3EO86dQRoKdTRzyv7ihmw==
X-CSE-MsgGUID: IqEQ0gS1RoC68yh61/mwYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42826764"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="42826764"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:23:12 -0700
X-CSE-ConnectionGUID: U7O5RPqlQ3mYZ2FZXs9+yQ==
X-CSE-MsgGUID: t6oqTcvbRiGsDO5dYtpNbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="121267417"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:23:10 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless-next 14/15] wifi: iwlwifi: mld: we support v6 of compressed_ba_notif
Date: Thu, 13 Mar 2025 00:22:37 +0200
Message-Id: <20250313002008.f3b668f41de7.Ib8d984c7158bf286adfb6d343955ff5f95b51d52@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250312222238.2585340-1-miriam.rachel.korenblit@intel.com>
References: <20250312222238.2585340-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

It just added a field that we don't use. Claim support for this new
version.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/notif.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/notif.c b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
index 06caedf9b0ba..fc18cba8aaa8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/notif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
@@ -347,7 +347,8 @@ CMD_VERSIONS(missed_beacon_notif,
 CMD_VERSIONS(tx_resp_notif,
 	     CMD_VER_ENTRY(8, iwl_tx_resp))
 CMD_VERSIONS(compressed_ba_notif,
-	     CMD_VER_ENTRY(5, iwl_compressed_ba_notif))
+	     CMD_VER_ENTRY(5, iwl_compressed_ba_notif)
+	     CMD_VER_ENTRY(6, iwl_compressed_ba_notif))
 CMD_VERSIONS(tlc_notif,
 	     CMD_VER_ENTRY(3, iwl_tlc_update_notif))
 CMD_VERSIONS(mu_mimo_grp_notif,
-- 
2.34.1


