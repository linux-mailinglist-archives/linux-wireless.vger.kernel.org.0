Return-Path: <linux-wireless+bounces-2612-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE5D83F46F
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jan 2024 07:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEA1D1F22EF5
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jan 2024 06:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744AFDDC4;
	Sun, 28 Jan 2024 06:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gfyhv87r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B18DDA5
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jan 2024 06:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706424888; cv=none; b=YM4oypswj2lv2IxOwNg7AVTMNH4BX6vi4SwNR9eI14f2+wzIy44jIdp+q0occ2vcdx8FhSpvnAvRqfVizckMmyiXYRvr+sZ9pIAvaZQSQs/nPhEMeuizzPCKVnHrca2DY4mSRrJAiVIEY7UgyWwaWWDqNzuJWzCrzkG8viLq3tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706424888; c=relaxed/simple;
	bh=yRcCuckVVOX9r1n7Oo7ERP6r6GmvoPOyK0JJ/EHB8j0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F/MVjpnp7aqGI+cldW+tB/P4CLfC7JOSoHBm4QqzP0KD9R4Tg2a0KdT0BX+RPV7DvAQWkGB5o1RCRISuuP61/Go4WsZMLr/B/a/rDNkR96UxAM9aJ9kqzv3OQ7hvKEpiTHNzjXLvYxhnaQx7z3jSPr8lBoTJY1ccyMENpev9hL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gfyhv87r; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706424887; x=1737960887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yRcCuckVVOX9r1n7Oo7ERP6r6GmvoPOyK0JJ/EHB8j0=;
  b=gfyhv87rD5oXRHdOdapwgFCsYD0a6Gp8epsucGxds1z0JdDKtbobiJ80
   eySlqt4Q215jzEKBCsDhT0F7KH5hs4aluC1Thyv4IDxEPEKy55mcPKJlm
   xfCviYM3Wo6KWql1GQzYXzg4HOaowwAZhEla+b4fehyZuD7SzMvCnQ8kJ
   zpp7vOJZRalJ7+LoOUJGuwM3hqnU6nOeOG/EdDJ8aB9tycE0S4xq21cCP
   izhqw4folv8/yXlpNyITf951iSR+v2hoG8K8X7WaFp9w/f/t0IiQedSnP
   t4RX1qAkN0Csvn+24Jc25vTQf3jOORYmdv16rrD7qKPmjgtkPNACoMtly
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="24217657"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="24217657"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 22:54:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="35833354"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 22:54:45 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/14] wifi: iwlwifi: dbg-tlv: use struct_size() for allocation
Date: Sun, 28 Jan 2024 08:53:52 +0200
Message-Id: <20240128084842.f301641eb916.I66b7b48a526377d682eecef874373bf3a01076c8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128065400.2550604-1-miriam.rachel.korenblit@intel.com>
References: <20240128065400.2550604-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This is effectively the same since we don't even have a
multiplication, but better captures what happens with
the length.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 7b145b417810..989b100ce6ab 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -71,7 +71,7 @@ static struct iwl_ucode_tlv *iwl_dbg_tlv_add(const struct iwl_ucode_tlv *tlv,
 	u32 len = le32_to_cpu(tlv->length);
 	struct iwl_dbg_tlv_node *node;
 
-	node = kzalloc(sizeof(*node) + len, GFP_KERNEL);
+	node = kzalloc(struct_size(node, tlv.data, len), GFP_KERNEL);
 	if (!node)
 		return NULL;
 
-- 
2.34.1


