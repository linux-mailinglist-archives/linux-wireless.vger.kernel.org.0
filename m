Return-Path: <linux-wireless+bounces-485-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C146A806A22
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 09:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68048282707
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 08:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD87F2F85A;
	Wed,  6 Dec 2023 08:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e3P5jZTf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E968D2726
	for <linux-wireless@vger.kernel.org>; Wed,  6 Dec 2023 00:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701852610; x=1733388610;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TX2eOMg7tv3Lco96b6bsVSIYiDgi9RlLfoT6X0bF/3s=;
  b=e3P5jZTfCFq7+Ny0k4im9TnJcFbTpe6nHe9KNl8blKzvMIydKgqR+HrH
   jT19pBkV4Pq4OElYe5KC0CFwHubEogvX57cH8CZ0tF/Xq38DAjiGNA094
   UUcJV3eOm09xCdoyXU6mFM9Un+zK1dBaUi/27AuzPbAdo6ixdC+KurOfe
   xSuzFPJbXFOLYMi22ixrfgGtXfAMePsSKRv0ebLZHFq7RPaBp6eaO8vT9
   mPIKC5vAj9K9ATOiHD8GLs0amHlFeljUHubU+Ny2Qgh7oppO7AWGcnuY9
   jec9jxYz4TCawODTx+ZPjGDY0DxEo0R4LC8G4uo7DMwa/HuyeUPk3ajUu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="397916617"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="397916617"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 00:50:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="805575428"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="805575428"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 00:50:08 -0800
From: Miri@web.codeaurora.org, Korenblit@web.codeaurora.org,
	miriam.rachel.korenblit@intel.com
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 12/13] wifi: iwlwifi: avoid a NULL pointer dereference
Date: Thu,  7 Dec 2023 04:50:17 +0200
Message-Id: <20231207044813.cd0898cafd89.I0b84daae753ba9612092bf383f5c6f761446e964@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207025018.1022929-1-miriam.rachel.korenblit@intel.com>
References: <20231207025018.1022929-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spam-Level: ****

From: Avraham Stern <avraham.stern@intel.com>

It possible that while the rx rb is being handled, the transport has
been stopped and re-started. In this case the tx queue pointer is not
yet initialized, which will lead to a NULL pointer dereference.
Fix it.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index ab0c72c55b2d..0f405ded1a7a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1384,7 +1384,7 @@ static void iwl_pcie_rx_handle_rb(struct iwl_trans *trans,
 		 * if it is true then one of the handlers took the page.
 		 */
 
-		if (reclaim) {
+		if (reclaim && txq) {
 			u16 sequence = le16_to_cpu(pkt->hdr.sequence);
 			int index = SEQ_TO_INDEX(sequence);
 			int cmd_index = iwl_txq_get_cmd_index(txq, index);
-- 
2.34.1


