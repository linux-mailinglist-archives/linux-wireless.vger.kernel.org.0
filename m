Return-Path: <linux-wireless+bounces-9209-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4AF90D9B9
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 18:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52FA51C210A0
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 16:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79789145B37;
	Tue, 18 Jun 2024 16:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YmmsjoBa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D61143C4D
	for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2024 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729077; cv=none; b=iTewAKH93D4JLw7wEXPKpAbG79Q2J4Nh+7SXYl+THeR6oPbVtCabgvwhBbuV2xNULrE5UraUt4sRmW3taNyZQ5HQ0mZUIcquuwFZA88UggG3CyJJOZ30Bp2P3XgcTrd40hDjjMFZd29t9kxs17O34QQTIv6wYWFyv3in++SHbOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729077; c=relaxed/simple;
	bh=OYDQe5w90xYMxLpBYWFRuCXqAxCY3UWkGc+olyn7tiE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LN3gYTbKJgJYyM9+a1SnKfvQJRIRmXtinpzJ++sbYM/ncUw38VSIvNKZeZhlTnX5sLdHh/cl5woLmueFwrMuwGVmC6E57Gu8eDbnLlH0VaEu4uythiQSeYloQF8Mbng3v76HqAj2UjlFWRtvkCngg0mnzUl0HLEN3LIdCboA+/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YmmsjoBa; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718729076; x=1750265076;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OYDQe5w90xYMxLpBYWFRuCXqAxCY3UWkGc+olyn7tiE=;
  b=YmmsjoBa5TZ+iyIZlI4qdjbGp8pX5k4i0UtFXgiZ37xP+94HagGkVGza
   ZOrI1AcELfeJWRTE9qgqtmPp01kc2Ir6TDCmkP5hKksQJogV8A6WQW19j
   wJotx2iStDWdwNxn9JtzM8YKUBLKWt0ejzL8+Tu/QrI8GiD1fAozDgcXZ
   wFg8DszbEGmF1oGGVCybJYf/txl0ML93HtB4W0pQt42nTAWv7V7nLKsWX
   sB+wrgB7J4zjG9cSTz9UkbTVFJtw49Vh2dvfbyD/SJEKafLrKOOOVoto+
   JT6DO0uI9EkrN/3UX9TzTUwYNlQoV/bIXTtB7oE9IQRD0a6aG1rPM/UGz
   g==;
X-CSE-ConnectionGUID: paclhtsgTvqqHAFK7nnutA==
X-CSE-MsgGUID: 1S6gASp5SMmAdSKOw6QFuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="26257202"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="26257202"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 09:44:35 -0700
X-CSE-ConnectionGUID: MFEBluLmSz6FK4IOIZnbvw==
X-CSE-MsgGUID: qzDC2BjARsi1CRywuPxmaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="42306535"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 09:44:34 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 08/11] wifi: iwlwifi: mvm: Fix associated initiator key setting
Date: Tue, 18 Jun 2024 19:44:10 +0300
Message-Id: <20240618194245.be2a5327554d.Ie53220b075dacb23a8d073f6008aafd339368592@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618164413.2416719-1-miriam.rachel.korenblit@intel.com>
References: <20240618164413.2416719-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

When setting the keys for secure measurement with an AP the station
is associated with, the TK should only be referenced and not copied.

In addition set the cipher only when the correct station is found.

Fixes: 626be4bf99f6 ("wifi: iwlwifi: mvm: modify iwl_mvm_ftm_set_secured_ranging() parameters")
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index 00d447e40cc6..afd90a52d4ec 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -732,10 +732,7 @@ static void iter(struct ieee80211_hw *hw,
 
 	WARN_ON(!sta->mfp);
 
-	if (WARN_ON(key->keylen > sizeof(target->tk)))
-		return;
-
-	memcpy(target->tk, key->key, key->keylen);
+	target->tk = key->key;
 	*target->cipher = iwl_mvm_cipher_to_location_cipher(key->cipher);
 	WARN_ON(*target->cipher == IWL_LOCATION_CIPHER_INVALID);
 }
@@ -774,9 +771,7 @@ iwl_mvm_ftm_set_secured_ranging(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		    !memcmp(vif->bss_conf.bssid, bssid, ETH_ALEN)) {
 			struct iwl_mvm_ftm_iter_data target;
 
-			target.cipher = cipher;
 			target.bssid = bssid;
-			target.tk = tk;
 			ieee80211_iter_keys(mvm->hw, vif, iter, &target);
 		} else {
 			memcpy(tk, entry->tk, sizeof(entry->tk));
-- 
2.34.1


