Return-Path: <linux-wireless+bounces-27132-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E81EB49FFD
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 05:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247A91B248DE
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 03:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD4A2D77EF;
	Tue,  9 Sep 2025 03:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F7pFDuNR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED99D2D24BC
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 03:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757388134; cv=none; b=Lp4XGwFs7FLwRTWxWSO0UGuKetmXZ+lL2MUDaQ99vTsNRv/bJfxfNyWYYRs+S/Z6qaoF/zJuhvVD5Lu9E57HkEVHAoHGzg/YQ45fhlY1+mLu2BNfBPYB8/HzrXYVkDsdNi/wJ+JrOu6XzHYc89At3GkWY00Qi74T9SlYlSSbzPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757388134; c=relaxed/simple;
	bh=usWEh4wTy5YkgXyDBKKneYCnA6yu1RVhRKm3DaOKDtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lm2KM4qP2UT3wd4e7TW2x9LAWbyN5svwQPHAvmppZJBsgnMQrPeSti/AyzdoFV4bRrIjqc9h1JsyaI9TKFpuqY+aDi7Z2XDc4EbvQz/IlQD5RIJbdvG/qm4mLBY5GrREnZ+gF2/Ob1zQ4723kYukYwwzKLfVqzKTTm2F1f8uCLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F7pFDuNR; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757388133; x=1788924133;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=usWEh4wTy5YkgXyDBKKneYCnA6yu1RVhRKm3DaOKDtQ=;
  b=F7pFDuNR3GUS89Y8eXYEEDgKnz1PkjvWSK8dGBibv2X+vTyAqJyuX55e
   vUgj2HhngGldREjd0y3cS6G5SoBw6Qqdro8XOjDNX1ZZ18taBz+oFyDnI
   ahifEel7uGAgLGB39yHwnO7EKSat82Ovf07GtSA4gsH3waGKajdYnZqaX
   5DuNHPzE+VidWp0FqyCKrPA0h5doUmGKQtbtyLkg0h/2fhMPBpJaY2UHG
   fvycUqqKQO1jb4Y6lPlRAMbxfPeEY7mdMJWt7Enbe/CxKqt2zuayL6DVW
   GHQmzTZKC05IhGeOBcxotZhR8RDTAKuB8kOZ9EAhEwgHWugtp/vMh14pw
   w==;
X-CSE-ConnectionGUID: 2J1gkdQ2QRe1bvvzjcQq8Q==
X-CSE-MsgGUID: qnUenVHHTuCrVffVsk9WsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="70281075"
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="70281075"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 20:22:12 -0700
X-CSE-ConnectionGUID: MKlQeiZmQKaipqqi+mODTg==
X-CSE-MsgGUID: 1/XDnMRjSLuNvnB4JBNesg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="203950402"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 20:22:12 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 iwlwifi-next 13/15] wifi: iwlwifi: mld: remove support from of sta cmd version 1
Date: Tue,  9 Sep 2025 06:21:26 +0300
Message-Id: <20250909061931.4d6689d5c4b2.I5d2bf7302eea8ac7a805f58e4e60e527d6f5b346@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909032128.3318193-1-miriam.rachel.korenblit@intel.com>
References: <20250909032128.3318193-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The last FW API that supports version 1 is 99. Since this API is no
longer supported on any device that loads iwlmld, we can remove support
of it.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/sta.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.c b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
index 8fb51209b4a6..5cdbfa29a202 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
@@ -401,11 +401,9 @@ static u32 iwl_mld_get_htc_flags(struct ieee80211_link_sta *link_sta)
 static int iwl_mld_send_sta_cmd(struct iwl_mld *mld,
 				const struct iwl_sta_cfg_cmd *cmd)
 {
-	u32 cmd_id = WIDE_ID(MAC_CONF_GROUP, STA_CONFIG_CMD);
-	int cmd_len = iwl_fw_lookup_cmd_ver(mld->fw, cmd_id, 0) > 1 ?
-		      sizeof(*cmd) :
-		      sizeof(struct iwl_sta_cfg_cmd_v1);
-	int ret = iwl_mld_send_cmd_pdu(mld, cmd_id, cmd, cmd_len);
+	int ret = iwl_mld_send_cmd_pdu(mld,
+				       WIDE_ID(MAC_CONF_GROUP, STA_CONFIG_CMD),
+				       cmd);
 	if (ret)
 		IWL_ERR(mld, "STA_CONFIG_CMD send failed, ret=0x%x\n", ret);
 	return ret;
-- 
2.34.1


