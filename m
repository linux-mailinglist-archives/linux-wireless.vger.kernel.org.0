Return-Path: <linux-wireless+bounces-2726-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09963841342
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAE41288DD6
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26AA6F071;
	Mon, 29 Jan 2024 19:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V7wONPF6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F303D4CB3D
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556151; cv=none; b=IfkTqj2SKI7pU6NsMkdr7591WDT3tTe9kbFUgZ7xoLA0QzbXMzjMuxPDWI7+9iS+yBcbr3N45atUoEMAuaCFicamXG2QDrT4YIA5GJ6E9dyBtwj4Qf42tzk487lQMp+X8gtor5/76G/iGE01BFTIXE2d+2DqJeJ/KlvYiL7UELs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556151; c=relaxed/simple;
	bh=ADvjdc4lhZAHOadb/rr+hQ3aeNFfua/KeKvxV+YndwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qR/E8+KGI6QGPwCIJnyIPRZDvddDKZ02DpyzjHRo5mzbNMEYL08ajy4ATOQYpRP1DcJIcT9t3gef1NC2/Dd+X/KX+5rxYpzIm24VQ/D1uDYRLV1KFTRzpe7yscA69y4ObGvc6Y+NIfJA6tMWRKDmhVhbuYPxlXPytzpduTVOSuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V7wONPF6; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706556151; x=1738092151;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ADvjdc4lhZAHOadb/rr+hQ3aeNFfua/KeKvxV+YndwA=;
  b=V7wONPF65W+FkZ4UpoIWOMkl+a6dK+izYfeX0bErPozILmxKxC26ekLj
   O7FzkeALzyluDi1m/7AoEypAd/8lljKUc/JkaQ7zDO4ezw0FaFmEkHNCq
   AA0uuoWwejteicc6XHsw6ZiuWYR4BA/QgAr3/31iTaZf5dyE2vgoPaXKi
   UUnaZfYUeIiYTB4l0c5DPuqsonDsuVzxgwPF29j70vKgMF1FP1boPaJD2
   LqS8yFb8Gu8gDWoumqgm3jkfjmaG06cLswcxffmmpnFmoMgickdK+VjCm
   MWDNMGGsaRkQfLCT4fyQ7caKATSbrJftIVyHKaTC5OlpkRQ1o/WXNmcz0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="2942985"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="2942985"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:22:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="3459089"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:22:28 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/15] wifi: iwlwifi: mvm: don't set trigger frame padding in AP mode
Date: Mon, 29 Jan 2024 21:21:53 +0200
Message-Id: <20240129211905.f5eeb717212e.I60fa4843a8634922281580b925db2c2699e3a7bc@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129192203.4189915-1-miriam.rachel.korenblit@intel.com>
References: <20240129192203.4189915-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This field is reserved in AP mode, don't set any bits in it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index a7152d65eefa..0b2b0c320cb0 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -749,7 +749,6 @@ static const struct ieee80211_sband_iftype_data iwl_he_eht_capa[] = {
 				.mac_cap_info[0] =
 					IEEE80211_HE_MAC_CAP0_HTC_HE,
 				.mac_cap_info[1] =
-					IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_16US |
 					IEEE80211_HE_MAC_CAP1_MULTI_TID_AGG_RX_QOS_8,
 				.mac_cap_info[3] =
 					IEEE80211_HE_MAC_CAP3_OMI_CONTROL,
-- 
2.34.1


