Return-Path: <linux-wireless+bounces-16871-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC279FDF48
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 15:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF4518821D2
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 14:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E355A33062;
	Sun, 29 Dec 2024 14:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V3jZiVrL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303CE1946C7
	for <linux-wireless@vger.kernel.org>; Sun, 29 Dec 2024 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735483523; cv=none; b=c0LYRnox2CpDizsf/3kBgoh7g/Kib6UDk3D8W1JWWxBSKVZc86QFz/cb28QloPoC2YphGO0g9m7SvA0VAwgqwmnfA4Yz/b0FiNgoAiutirWvr15oJqA+Q1FX4ufEv/+vJexVEVznhJLxUl4fxUGUHltVTavTe1Jy/OmRJaFidqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735483523; c=relaxed/simple;
	bh=PSlhmhoil3Ppz0VBwfhl2ml35moev8IikXhJ7ayYrO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GxB8/py5OZdhEuFKpCjAgugXECDD0Y+DDjNcR85Faehww9eKDIz9fLF+AsRKhpuiMCeinnc7oe1lx9sPsILjTePiv2sHpOQ9ej+8jPZa4UXv3yQkHlIkLOt9Yv1vXEkZJ8UZnn3XFwhn7z9oGyZKBPdPR8Lse4UrkbBdY2LRi/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V3jZiVrL; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735483523; x=1767019523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PSlhmhoil3Ppz0VBwfhl2ml35moev8IikXhJ7ayYrO0=;
  b=V3jZiVrLQcNvcH29oeyLoFp/QVVLIPHsuH7xdd4S5ED3ungu4wnDLK49
   Afr9Vr8B0JGveQzOw/G+n+cyY13vawcSIv7Q5iN/OV/yaF6I52oJd8K9o
   ng83P5FxyAoUU9ZvfcFIQOSyTFwomPYflj5DN/E3oWQQYka5YhOEM3avV
   Zlo/8CC4oU0XFC4gFQTKOHxOBUjibgmk5q88ytJlIBfkZDoF8x/7urJ7H
   Xn/TpYLTwFpQ7KduZUr6W1pnD1gJZUQowBThc4fNG4qqdwXdlwN3ZNo/w
   YEBHOcijsXL/PqAc2HSR6huxa2zJ4GIGGoDnjrWPCKly/PLGtNKgyioGa
   g==;
X-CSE-ConnectionGUID: F4W9D440RwuVBpuKPXrW+g==
X-CSE-MsgGUID: 35sIMY5FTkWJHZU1ThVfzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="39572452"
X-IronPort-AV: E=Sophos;i="6.12,274,1728975600"; 
   d="scan'208";a="39572452"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:22 -0800
X-CSE-ConnectionGUID: jUzQjTZJR6e9KK5edieZFA==
X-CSE-MsgGUID: wMGwGpa6SfmAH0JRT0VG1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="105656960"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:20 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	"Bjoern A . Zeeb" <bz@FreeBSD.org>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH 10/17] wifi: iwlwifi: mvm: fix iwl_ssid_exist() check
Date: Sun, 29 Dec 2024 16:44:45 +0200
Message-Id: <20241229164246.4471cd3d8dba.Iab8409b22bf6f01d05571ecef1e97dd3c8b1cc75@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241229144452.3151163-1-miriam.rachel.korenblit@intel.com>
References: <20241229144452.3151163-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

iwl_ssid_exist() seems to check if a given ssid/ssid_len already
exists in a given array ssid_list.
Correctly compare the ssid to the SSID of each array element
(with a matching SSID length) to better remove duplicates.

Signed-off-by: Bjoern A. Zeeb <bz@FreeBSD.org>
Sponsored by:	The FreeBSD Foundation
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Daniel Gabay <daniel.gabay@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 0bcd1fca31bc..60bd9c7e5f03 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -462,7 +462,7 @@ static int iwl_ssid_exist(u8 *ssid, u8 ssid_len, struct iwl_ssid_ie *ssid_list)
 		if (!ssid_list[i].len)
 			break;
 		if (ssid_list[i].len == ssid_len &&
-		    !memcmp(ssid_list->ssid, ssid, ssid_len))
+		    !memcmp(ssid_list[i].ssid, ssid, ssid_len))
 			return i;
 	}
 	return -1;
-- 
2.34.1


