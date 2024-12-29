Return-Path: <linux-wireless+bounces-16869-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C76359FDF46
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 15:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 334AF3A1788
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 14:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E5E18BC3F;
	Sun, 29 Dec 2024 14:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N+IbUIc/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BD61946B8
	for <linux-wireless@vger.kernel.org>; Sun, 29 Dec 2024 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735483521; cv=none; b=oemzqgN7AYyt2yiOKRu44/bewEF+TX2eJP+CltsNtzI43rM8AoYpfsVNZNAWhn/6LP/o08c2HzP4pN+ZP91xH3PpoBZs5nTlyMB88uFMWRHHJRXj8FZASI0TTbnB/Y+GPq3wMKR1kqUkU9keJtPw8zbCVhbqvlO9FnHCfrYAz0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735483521; c=relaxed/simple;
	bh=AL5RkbuBLKsz1OHUV2ua09/UByFdNAkcyTvP8CnhZo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HPiDPezv69NXH5KEA+ZQsCNORP/A74rt/hdjr78ou8grgNnbrLGDVEaLM6hybwKPHd9Bt24JfjdEZi/lMyeQoBJo2PGVvbN2NZea3Vg/JGgGcjS41r8WISajcPRrT387zzuA/M0l0JdTPTsrA2Bz6OMMEuVeZ8eQ+VmnBi1DYI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N+IbUIc/; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735483520; x=1767019520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AL5RkbuBLKsz1OHUV2ua09/UByFdNAkcyTvP8CnhZo0=;
  b=N+IbUIc/FRjs/WLEFm+w7qPmjNxGkKwHDkseRh+q6lPF+Cn305XHU/4D
   woATnFJjSX8q3nDxbExINFGrbJUIjUOqxCssyYhzSlib9rFCjZ4TdnamX
   foRVFVeYZcbHUKyf4K6eBPPKDlgiTaW1EI8lJ3h7xNuqZxgZbxGC+Gx24
   xKPWgxqapkyhN+CK5JS7YbQWfhd2wuXqlfRY48gUcpo3vYXcVK0SJDBmA
   11l+N2LXohmq9b0eeMC4xXD7eV9X8rLDpmFzZs+FV7wRbXzUn8uUMUojA
   l/KwP9KUKdUDKzRjyvDdMdTnlkWjMAHF/1pOsLsnsUDnVwKH6A60wVwF2
   g==;
X-CSE-ConnectionGUID: 0VqWCnS1QDSe6FghNuZ1nQ==
X-CSE-MsgGUID: 3/M7aUDHTnqnmj5/ta0BNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="39572446"
X-IronPort-AV: E=Sophos;i="6.12,274,1728975600"; 
   d="scan'208";a="39572446"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:19 -0800
X-CSE-ConnectionGUID: 3GjLyC+uSVOlUtsQWb9i4Q==
X-CSE-MsgGUID: QYmNg75JTtaiqLyerG5hmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="105656940"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:17 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Gan Jie <ganjie182@gmail.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 08/17] wifi: iwlwifi: fw: fix typo 'adderss'
Date: Sun, 29 Dec 2024 16:44:43 +0200
Message-Id: <20241229164246.ad8978ee5673.I388e314a4be8333192b3994f43efa5dbd3ac715d@changeid>
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

From: Gan Jie <ganjie182@gmail.com>

Fix typo 'adderss' to 'address'.

Signed-off-by: Gan Jie <ganjie182@gmail.com>
Link: https://msgid.link/20241101143052.1531-1-ganjie182@gmail.com
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
index e63b08b7d336..3af275133da0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
@@ -169,7 +169,7 @@ struct iwl_fw_error_dump_info {
  * @fw_mon_wr_ptr: the position of the write pointer in the cyclic buffer
  * @fw_mon_base_ptr: base pointer of the data
  * @fw_mon_cycle_cnt: number of wraparounds
- * @fw_mon_base_high_ptr: used in AX210 devices, the base adderss is 64 bit
+ * @fw_mon_base_high_ptr: used in AX210 devices, the base address is 64 bit
  *	so fw_mon_base_ptr holds LSB 32 bits and fw_mon_base_high_ptr hold
  *	MSB 32 bits
  * @reserved: for future use
-- 
2.34.1


