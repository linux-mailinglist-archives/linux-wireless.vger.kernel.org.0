Return-Path: <linux-wireless+bounces-25196-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D570EB00958
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 18:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 804DF7ABEF8
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 16:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7512F0E49;
	Thu, 10 Jul 2025 16:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GWyWsp3t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6522F0E3D
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166523; cv=none; b=s9dR2IcfEida4XhjnwIsKfWpKTXJKcKFFV0jjGXQ+pwFI30reKm/O5JuhAbsOQ7oIHWSbe0fHjbexRLU8hqa+82rzzmMxIbYrWhFpLqfDlDqdPcpIuXme0DjJgPrYOa24HTlLyr2xmjclcs4zmL5eP8Iax0Zj5y/t9DAaCmEQfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166523; c=relaxed/simple;
	bh=LmHDryUcln1yGNqcaUDZ4rlcu9VBcZfXAjvsM5C3C00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kCFlCUKATCRBASj5nb5efgBD68mzMsN5Fr2txcKs4BRRoLVSqNIa7aRAOHZZiCtoTh5R1BjnTTGt7anImXVvmWAkJD0D526OoX6awYH2LuwdI7xzDPK+btogdKqTqIfYYrhbZXeIDxA8tyQQl6pgDT9kKGga1fdYw0TPj7eDUnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GWyWsp3t; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752166522; x=1783702522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LmHDryUcln1yGNqcaUDZ4rlcu9VBcZfXAjvsM5C3C00=;
  b=GWyWsp3tl1gXQyLpGy+g54gKjp4pFWblV4waQqRbi+EB6QrjqtEji8gN
   I1MIbuFvxFBVK/WMiQl16WetxUCBat1SkkXbCVYCBaLGCSmY6OWhU54s8
   yzT5lV11G3UxrB/t+TN+jvEmk2iSVVQDctSq4lx8m5s0jziKX2IY6c4pw
   Y4L36ayw0eRFLjBla5WUaXlJ78mCSWl68AWB70/yhzwSoth3P4weEYTC3
   qWb+A8h67WE7Tsqm1/kzP5RTbgXEsIKLWZhSS568P9JuyTqzNAtdAHavj
   Gwv4M6KygpAM3i4/Dz5PLuAmuXgRYjPEAHJy6Wd1+Ujd+jyrCrx0plshK
   w==;
X-CSE-ConnectionGUID: VVwgGwgsQsGGoFUU3ojp/Q==
X-CSE-MsgGUID: Db3Jg1OISOmCfXUJgwMrnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54610019"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="54610019"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:55:21 -0700
X-CSE-ConnectionGUID: /qQCDSvISLuhqo00A+yLMg==
X-CSE-MsgGUID: qFQhpA11T4qoBZGOJSPUsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="156277071"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:55:21 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 10/15] wifi: iwlwifi: mvm: set gtk id also in older FWs
Date: Thu, 10 Jul 2025 19:54:43 +0300
Message-Id: <20250710195219.e91e49590414.I27d2fdbed1c54aee59929fa11ec169f07e159406@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710165448.2553296-1-miriam.rachel.korenblit@intel.com>
References: <20250710165448.2553296-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

We use gtk[i].id, but it is not even set in older FW APIs
(iwl_wowlan_status_v6 and iwl_wowlan_status_v7).
Set it also in older FWs.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index d9d678fbdaab..546fda8de5de 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2210,6 +2210,7 @@ static void iwl_mvm_convert_gtk_v2(struct iwl_wowlan_status_data *status,
 
 	status->gtk[0].len = data->key_len;
 	status->gtk[0].flags = data->key_flags;
+	status->gtk[0].id = status->gtk[0].flags & IWL_WOWLAN_GTK_IDX_MASK;
 
 	memcpy(status->gtk[0].key, data->key, sizeof(data->key));
 
@@ -2532,6 +2533,7 @@ iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm, u8 sta_id)
 		 * currently used key.
 		 */
 		status->gtk[0].flags = v6->gtk.key_index | BIT(7);
+		status->gtk[0].id = v6->gtk.key_index;
 	} else if (notif_ver == 7) {
 		struct iwl_wowlan_status_v7 *v7 = (void *)cmd.resp_pkt->data;
 
-- 
2.34.1


