Return-Path: <linux-wireless+bounces-25818-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62801B0D49E
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 10:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776BD1645F1
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 08:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEC52D8DAE;
	Tue, 22 Jul 2025 08:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MSDogu5e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8052D5A01
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 08:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172977; cv=none; b=etKNJfjbScOnhZ9Vrdp5DHey0toqZOtUH/CaFCfrzjef52Dllf3+5HnI35Qibc69T5rOiNNeDO2K5NGFOgBO74sv9Xzl6d4J5zoPf5v4KG4D+8g4YN8bU4wdoT4lneApPTXSoXKXzX/vKs5DaGKrh7bTyonVuwg1XUlGFAwTU5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172977; c=relaxed/simple;
	bh=RMdDiuuvHQH36u7xg86ICkL0gF5hR/CGa7ifbowG2f0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iUmYdQeDzqTOlslURMyh5qJQwn9gnwRB2WJb+KaEresIO0wwz3RhpzkWCVB0bHdPECZdokSeM/DimEkKSO11gNtKx2RF0gWqp2UkG0VdY2Co2OJPRxT5e9WYiNlwKVxVHC7XrK7Yk6ft4hJWG+BBzHf+JVqe83CadUyRDEpu20c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MSDogu5e; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753172976; x=1784708976;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=RMdDiuuvHQH36u7xg86ICkL0gF5hR/CGa7ifbowG2f0=;
  b=MSDogu5eSI/mkey0JOAgG3f3GGbrkpG48wgComfDAzAtwfivfkBRfYZS
   aLXeFT0b3BgP2oFcbX96fBM3R7Mcyy+6njVekGR5P+VTI7aowoSgQURIb
   pgGjGJep6VlwSrBwwMI55Ti2miYFQOMvqJFyKaGN/hx0mrecTWJF/PZ6N
   Mnw2sRbU5m7SBNuwcbFIWLqgaEICPhy4ZKi3xormcMRPqkA+RwS0JH/Eh
   TySDtPxwrESgWg5ENrnwODJw7Q0X9k/ae2ORexQbAXMU2LvbsMagQMiP2
   Qm3RoSfScQMaRJEl/RwrbOeiZOYq9grJXURxmlnhiHwroMNQtdVqnrStl
   A==;
X-CSE-ConnectionGUID: c+GV4OfQTKG3SX2JVnQVtA==
X-CSE-MsgGUID: qJhNcxtuQBC2UD3PUD6TPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55569831"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="55569831"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 01:29:36 -0700
X-CSE-ConnectionGUID: Uhce+5WKQ4CHlSNn9harWw==
X-CSE-MsgGUID: tHq9rht/QD2UIjoHNFC1yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="163124242"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 01:29:34 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: mld: disable RX aggregation if requested
Date: Tue, 22 Jul 2025 11:28:58 +0300
Message-Id: <20250722112718.e0555330d8e9.Ibf5877df76ea2f1eee614166b3194843fd9898cd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722082910.1206370-1-miriam.rachel.korenblit@intel.com>
References: <20250722082910.1206370-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The user can request to disable RX aggregations via the module parameter
enable_11n.
Honor this request and reject addba.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 59be9923c3b2..d929cf2e73fd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -1918,6 +1918,10 @@ iwl_mld_mac80211_ampdu_action(struct ieee80211_hw *hw,
 
 	switch (action) {
 	case IEEE80211_AMPDU_RX_START:
+		if (!iwl_enable_rx_ampdu()) {
+			ret = -EINVAL;
+			break;
+		}
 		ret = iwl_mld_ampdu_rx_start(mld, sta, tid, ssn, buf_size,
 					     timeout);
 		break;
-- 
2.34.1


