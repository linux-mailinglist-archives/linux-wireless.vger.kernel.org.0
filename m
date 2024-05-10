Return-Path: <linux-wireless+bounces-7467-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B2F8C265F
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 16:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233EF1F238AB
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 14:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D6C17165F;
	Fri, 10 May 2024 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LAOgZ6mD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AF5171660
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350026; cv=none; b=bRgX7MXNvMqQk0Zgsie9UcXBPFdHoqCSvY9HVc4yqoqo/yuRzdlF2RBiT6ESJBv8nwwFJh+8tUF9HqzzpONei80NG7SHHVRO+AYLN5cBwzBAceFo6RH734kiA5uoK7tGWzR5L8t6R6IYUiimE9pk9qo07gCk/eHqOgU0As81nck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350026; c=relaxed/simple;
	bh=kRd0jDwrY/AVet4fGeuDlJWbZIOPkSzf5UiSS2tYpOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q2uMMpLy0xFDKItVbSh8UGShkOQiod/RsTyP8Etz6NKzPDQulzRLRu3z/GZe/VugbPsV88Jt/QHfGlcLdId8AuBrXAUuT+7ycJhg21gtQ/ILlarf+WUFeGK5GHM9DStQb5agAtPHFoKDODAg4+v8oRxTftuXPFR+mSv1iQrOLlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LAOgZ6mD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715350025; x=1746886025;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kRd0jDwrY/AVet4fGeuDlJWbZIOPkSzf5UiSS2tYpOg=;
  b=LAOgZ6mDdbt3c9FEv+ghDcgwv3TA4P3xzWnh8EzoqLYeub3RKVkzVYZw
   Kh2ThXQZ37wkF+ExMJ1+TEIFVqcVVW0KCgk0CKivjCYKpdZL86UVou7C0
   w6c5DO80xQNCKH8hBJfZir9q4xOzY/NdKVnWI07EQPPZIJfHmKyCfo2QE
   +fVS3+SE8KRnpuWHnNh2GWxKa8CRQYH9AGS64vkrxtbBacVRBD1RDH7sZ
   Stwfx9++TYULxZKvPsgIy2RDWqdWz/+KHV1IcxBIarDtOmpeFWeefAtBv
   1YipMwmZDpfxwibLMoN5+Zl3l/nqfgdFrJYOAruqDeMmmBONKR0urRdAo
   A==;
X-CSE-ConnectionGUID: hMUMQRhBRWWqJ8lPLvpQ+Q==
X-CSE-MsgGUID: hxwyQjQcTQOltDjbuGLUNg==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15125568"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="15125568"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:07:05 -0700
X-CSE-ConnectionGUID: gRKoLEyRT7KIatrNyOUSjg==
X-CSE-MsgGUID: 2owrbChbTBeB9MrrDgrG5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="67101866"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:07:04 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 07/14] wifi: iwlwifi: mvm: define link_sta in the relevant scope
Date: Fri, 10 May 2024 17:06:34 +0300
Message-Id: <20240510170500.e0a1dd285d9a.Id5ff16fb98af0c5f533aed6b5ec3cc856401e488@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510140641.1895860-1-miriam.rachel.korenblit@intel.com>
References: <20240510140641.1895860-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

the link_sta pointer is now only used inside this if, so define it inside
its scope.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index d78af2928152..8bbef4454399 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -2032,7 +2032,6 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	u32 len;
 	u32 pkt_len = iwl_rx_packet_payload_len(pkt);
 	struct ieee80211_sta *sta = NULL;
-	struct ieee80211_link_sta *link_sta = NULL;
 	struct sk_buff *skb;
 	u8 crypt_len = 0;
 	u8 sta_id = le32_get_bits(desc->status, IWL_RX_MPDU_STATUS_STA_ID);
@@ -2185,6 +2184,8 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 
 	if (desc->status & cpu_to_le32(IWL_RX_MPDU_STATUS_SRC_STA_FOUND)) {
 		if (!WARN_ON_ONCE(sta_id >= mvm->fw->ucode_capa.num_stations)) {
+			struct ieee80211_link_sta *link_sta;
+
 			sta = rcu_dereference(mvm->fw_id_to_mac_id[sta_id]);
 			if (IS_ERR(sta))
 				sta = NULL;
-- 
2.34.1


