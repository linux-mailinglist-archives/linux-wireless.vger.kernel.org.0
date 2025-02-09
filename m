Return-Path: <linux-wireless+bounces-18669-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CF8A2DDD4
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2025 13:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FEB17A2370
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2025 12:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92BD1DE2B7;
	Sun,  9 Feb 2025 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HoiOvW30"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C83E1DE896
	for <linux-wireless@vger.kernel.org>; Sun,  9 Feb 2025 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739104524; cv=none; b=ANwQEQbvtLwDzmfHcctSChb5rUJ1cefM9obQs5ZmDr6ALJ2RQrp/yOqcgR5ZwXtqT+/3JHkBG72BSJ95sQQ1LgdEQkvP74b+pl3SK40tdcgie8NFiPgjRf6KmCv0Jg+Q+QxzsPKnuTv8V4y5OsaWB7fgZCCJ+7eXuhCrKhkhGjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739104524; c=relaxed/simple;
	bh=kJoBTBUnx3ThJujJq2NlULkcDwcFZROW8aDrwlWtN1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZiyYUk5/490h0qkw1UReYhPbplhLe6oQWMVEEoE8RxD8aqkEPXW+MjwrppyDVzqqjWcNkrs4DupSBAmprV7u2gMYoITRlaNEiT2s6GH1NzXXz5J2310/NcCv/xX36+IFVUj85Tyvzrf/W0DGtmAifcnXbCMPTGOIaB9772A9Gjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HoiOvW30; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739104523; x=1770640523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kJoBTBUnx3ThJujJq2NlULkcDwcFZROW8aDrwlWtN1c=;
  b=HoiOvW3026xdoTAazf4Tm0B4r2CH1NEE64Lg4cwqp2uWPO6z7rWt/g7Q
   +7WMomU8AA4gp1F5l4/iFtI4zmoNJq0TU3TmULhbyWK7rbVYzB65aytc2
   ojh2axByzfbqzWZbkU6IV1InvIDthpZ2dVZZFBJKcjTSJJnFBecdvj+Xx
   zwE3TcLIsWzfElNJoRdeZ6QQYiJ1Wdm1Xok/JhmnPGqPiPIwnOqYLDGeh
   qk6Ff0rD0ixAF1rzbmLL/nb0XoINlcuayGgGCV0yITm+Be3j+xs5m98yH
   IhlqP1rz/19+mH/iMqP034+tGPcQrZyR3TLKop+ktddWAA9HGYCGUXkIn
   Q==;
X-CSE-ConnectionGUID: Hlt41em+T4CsiZzqKfj8cw==
X-CSE-MsgGUID: Npe8x9OpSFKvSCzZ0Taw4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51125988"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51125988"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 04:35:23 -0800
X-CSE-ConnectionGUID: H/SicHS8Rg+Sz5kUB5u/DQ==
X-CSE-MsgGUID: y/C6JYfaTMSAnmN10FQACQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111782466"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 04:35:21 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 8/9] wifi: iwlwifi: Free pages allocated when failing to build A-MSDU
Date: Sun,  9 Feb 2025 14:34:52 +0200
Message-Id: <20250209143303.bc27fad9b3d5.Ibf43dd18fb652b1a59061204e081f11c9fa34a3f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250209123453.2010013-1-miriam.rachel.korenblit@intel.com>
References: <20250209123453.2010013-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

When failing to prepare the data needed for A-MSDU transmission, the memory
allocated for the TSO management was not freed. Fix it.

Fixes: 7f5e3038f029 ("wifi: iwlwifi: map entire SKB when sending AMSDUs")
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 1f483f15c238..dce5096db82b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -347,6 +347,7 @@ iwl_tfh_tfd *iwl_txq_gen2_build_tx_amsdu(struct iwl_trans *trans,
 	return tfd;
 
 out_err:
+	iwl_pcie_free_tso_pages(trans, skb, out_meta);
 	iwl_txq_gen2_tfd_unmap(trans, out_meta, tfd);
 	return NULL;
 }
-- 
2.34.1


