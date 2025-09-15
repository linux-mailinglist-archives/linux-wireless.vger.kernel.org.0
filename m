Return-Path: <linux-wireless+bounces-27313-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EA8B57307
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 10:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ED661642A9
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 08:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F84E2ECD05;
	Mon, 15 Sep 2025 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="II3w4DTi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E601B4231
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 08:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925304; cv=none; b=qTs8iTe03Dp2UMlryHEkTksXY/ofj+ZwpmbCLBa2i7028xXpanydj2TXrLZJmKWzD0hNbrubXMivwXX+zaSV3CYWAhVTmY1aKlm+IE+IX6nL8G8LsanXuYgSPLwa0mWNpqokHTRGa2JsPEE2WCw4nFz96omtoyjr8NuEXNmCBdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925304; c=relaxed/simple;
	bh=rorM+IJoBTIjNKFpRa17gKrJZZJoMiCxdsTGvgm+z+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Md6+Tg5i0mkI00amdlghW8/O2x1kJ2fBQ0UHF5TLwWtA/Xuwn+a82SKn7995PuryLdgGv3ILnARUCcXRcbJYQGvC7MKCqWVZbapK5MihRmUKErkapFMJRs4KzP9y16DvVrQiae6RpmzjqPUK6TQ4Zslx4rPE4wjtga9+uIdEZqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=II3w4DTi; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757925303; x=1789461303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rorM+IJoBTIjNKFpRa17gKrJZZJoMiCxdsTGvgm+z+w=;
  b=II3w4DTihY7B7vwdk1/NeOd9KgbKkSjP5FnzTaAOWirkgbWQ4CVj9j/+
   0tBw5Gy265vAuN8pvrA2UR+e+crhFpZEUGnCu5zyx6QriCmGnAWlzOYxN
   qfccTxGbwfTJM8mvYXc2j4P1kTc06afeBjfyj5GThg+xf3eFE8HPVXl/t
   J1KKlzp4Sx2xLynKZa32mCgQTk7MjkLZ/ZzRvDt0w6NpS7TI4Ggtig+6T
   rfSpPpfy8dlOMX3kR+0MexL6uW9Ashqyec4GwSLePaE1WgLU1pQafWlmi
   Q7zWt1D9c0F6HQ+XdzxqxPwam7qnwI4QSb5P257oj6Eqk5ztRknKIuaiI
   Q==;
X-CSE-ConnectionGUID: tcpi3BJVQXGF4Bhlk0I8SA==
X-CSE-MsgGUID: BrMQUoaNS9OX+M3M+QMl3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="59213067"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="59213067"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 01:35:02 -0700
X-CSE-ConnectionGUID: Un7+wWWNSO+qX8iOhB8dYg==
X-CSE-MsgGUID: TcYxpumZSR2cuzNXJjW6kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="178569847"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 01:35:01 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 01/11] wifi: iwlwifi: align the name of iwl_alive_ntf_v6 to the convention
Date: Mon, 15 Sep 2025 11:34:22 +0300
Message-Id: <20250915113137.81240e1d4df3.I2c1264a49b9f0fc160f960cf3c5dc4cedf6ceb6d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250915083432.1048608-1-miriam.rachel.korenblit@intel.com>
References: <20250915083432.1048608-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This struct rperesent versions 6 and 7. The convention is to name an API
struct with the last version it represent, so rename to
iwl_alive_ntf_v7.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/alive.h    | 2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/commands.h | 2 +-
 drivers/net/wireless/intel/iwlwifi/mld/fw.c          | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c          | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h b/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h
index ad5b95cad0bf..ea2ba4b4cb7b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h
@@ -88,7 +88,7 @@ struct iwl_imr_alive_info {
 	__le32 enabled;
 } __packed; /* IMR_ALIVE_INFO_API_S_VER_1 */
 
-struct iwl_alive_ntf_v6 {
+struct iwl_alive_ntf_v7 {
 	__le16 status;
 	__le16 flags;
 	struct iwl_lmac_alive lmac_data[2];
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index 997b0c9ce984..8d64a271bb94 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -60,7 +60,7 @@ enum iwl_legacy_cmds {
 	 * @UCODE_ALIVE_NTFY:
 	 * Alive data from the firmware, as described in
 	 * &struct iwl_alive_ntf_v3 or &struct iwl_alive_ntf_v4 or
-	 * &struct iwl_alive_ntf_v5 or &struct iwl_alive_ntf_v6.
+	 * &struct iwl_alive_ntf_v5 or &struct iwl_alive_ntf_v7.
 	 */
 	UCODE_ALIVE_NTFY = 0x1,
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/fw.c b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
index b372173c4a79..bdb69c098fd1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
@@ -126,7 +126,7 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 	switch (version) {
 	case 6:
 	case 7:
-		expected_sz = sizeof(struct iwl_alive_ntf_v6);
+		expected_sz = sizeof(struct iwl_alive_ntf_v7);
 		break;
 	case 8:
 		expected_sz = sizeof(struct iwl_alive_ntf);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 865f973f677d..6b76ce35443d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -115,7 +115,7 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 
 
 	if (version >= 6) {
-		struct iwl_alive_ntf_v6 *palive;
+		struct iwl_alive_ntf_v7 *palive;
 
 		if (pkt_len < sizeof(*palive))
 			return false;
-- 
2.34.1


