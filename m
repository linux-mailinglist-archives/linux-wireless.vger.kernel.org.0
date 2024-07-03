Return-Path: <linux-wireless+bounces-9916-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 305AE92579F
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 12:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E9C1F26F7C
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 10:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCFC143C5D;
	Wed,  3 Jul 2024 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cf+ik32M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32541143C42
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000779; cv=none; b=kTt2VAQ9XxRpM96T/qBc2/q1EMWD8xN7CqmSTd5txWl4mobN+9GKs6hKGAcNnHxlYZRHS/WJvZujIBOCIBQ5eqVOLZAZjNPa7r169qhDJL4guS1s7dspYjn/Y5/Zzh+IwC79PtpBlmggzH84v1ArU92V3E2EFE7jWlYvF+hIHZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000779; c=relaxed/simple;
	bh=6JEg2PPX93ibgwr62EfDVBEZRiy1dYHN2k+Mg+6wQpE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kJhALfrMUhX+kksXs1YFnU1ZQbxH6uFwwAPp+w9IsjCcr+Gm082CClj9ZBGrOZqoeA+m6nLIepXnFDN8UreDRbgMoHl18/a2zr6YnsL/rib4MT6gOPPKunRH4YjA5pdaP79UyXPiMDGQ+E692UayfLwsTnweTk12Cszx+IADMps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cf+ik32M; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720000778; x=1751536778;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6JEg2PPX93ibgwr62EfDVBEZRiy1dYHN2k+Mg+6wQpE=;
  b=cf+ik32MCdtIsQKgXOvNe4kmG2VhFvjKKH8tnCIkTjta/KxlKlZ2qcUd
   N7fQzrSD8X4YFNX6dwKy1j4MKC1HF7MsMj5NFK+yvlLUamL4B4Tux9j2b
   nsWLyjDnsz/m47551eP9FnbZfsaNpuU5JwTtCHuK+HWAo+Dfgq5pkLjYs
   VDiim9iQjxaZlgBykF7kNtXtKKFgpxZHz/nsTpAHkAVqrzFwjyd9CHkzd
   jB7X23J13FN2wuLyUYP6NfqzuBxfG35w9MujKTIKjwNpGcQ6XdOrWkkkE
   PkTeCRKuDJi/Sq/vwejXJ7KsczsyUJjvoyD9e0BFbz7xfdb7/FCsoRDh4
   g==;
X-CSE-ConnectionGUID: cD3xgMyBQFq3ooYy+eSZBw==
X-CSE-MsgGUID: aJDNhs4sQB29tzosRgAaFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27837563"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="27837563"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:37 -0700
X-CSE-ConnectionGUID: khY6YscRTyCcqA/UkzPuVQ==
X-CSE-MsgGUID: 4XGpvKs3TT+NXR1ElrnUbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="45987863"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:36 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 15/18] wifi: iwlwifi: fw: api: fix missing RX descriptor kernel-doc
Date: Wed,  3 Jul 2024 12:59:03 +0300
Message-Id: <20240703125541.d7adf8b235fe.I91f75e292d1648f61e5e341e1fe58096f858853d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703095906.833028-1-miriam.rachel.korenblit@intel.com>
References: <20240703095906.833028-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The v1/v3 remaining bits are not annotated in kernel-doc,
fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index 8bd85ef90052..691c879cb90d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -710,7 +710,15 @@ struct iwl_rx_mpdu_desc {
 	__le32 reorder_data;
 
 	union {
+		/**
+		 * @v1: version 1 of the remaining RX descriptor,
+		 *	see &struct iwl_rx_mpdu_desc_v1
+		 */
 		struct iwl_rx_mpdu_desc_v1 v1;
+		/**
+		 * @v3: version 3 of the remaining RX descriptor,
+		 *	see &struct iwl_rx_mpdu_desc_v3
+		 */
 		struct iwl_rx_mpdu_desc_v3 v3;
 	};
 } __packed; /* RX_MPDU_RES_START_API_S_VER_3,
-- 
2.34.1


