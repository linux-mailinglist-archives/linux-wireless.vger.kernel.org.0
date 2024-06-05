Return-Path: <linux-wireless+bounces-8529-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4C98FC989
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 12:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 326751C23D1F
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 10:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD641922F5;
	Wed,  5 Jun 2024 10:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mfDLyj3r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508A21922E7
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585053; cv=none; b=YN76Sn21eSiySiQ4VzN5AQYghAxkE2cfptbu80Ie/XAgjFgyyNJF8gHDTbx9CCo6yXVTiv5PdsgJzM0TvIaaSrwhT5mktzTaK/Kfp/mOqUw0n9FE4hIYxmp3rn2iE2VCBibya2WUNU5C5OPeTwkylWEhMfYoSo77LASNxe+Ujfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585053; c=relaxed/simple;
	bh=M3V1oqxS8zGU08v2P5RfRjI5YeDSjxbHxSD1guEftgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lVogMJvZ+kwtxHkvzfGlgnxj9q4Pp4aDMjS76ay6rVfbI02loDEpCTh83UMVKPNGe0+1g5mRu4iCdHfJ0BTLA8/TaInxNtP4cstnV59Nti3DTZI74OqqUD7M4swPGPu80mPH+PBxac9csaiXDrr7kIZLXdY6JUnP2v/wr1weV/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mfDLyj3r; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717585052; x=1749121052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M3V1oqxS8zGU08v2P5RfRjI5YeDSjxbHxSD1guEftgE=;
  b=mfDLyj3rutr3zvBWWqRK0rl/HN25qLIo2u18knkN2s6GHjag2V39D9eV
   iPwR9d9c9asM3bH/PpCxWZZy0ZJP3IRhTLEBAnnxYxot8Ffph8/r6X7Du
   r2TBfMbEMhn9i3KALCAw2yXZwZpLIN9YSnFyuj7h+mvbO3Cc+9PPpb3+m
   ZMVanrWLZGi9+Rpid6DGwVCrndfyiQX89gnHPiiX/lxgv9eFRm1JOEzp6
   zrCbdxOg1H36T3ikuG7X8bsH/GrvTiOWsxvW/X4dUQHd6GXN5Gm7vWuRd
   AJlhfIaXj6SmfSWwHIiP+ISdoPv/vPcPKcJf8Zvsy7fg88/kWbEMoo9Ez
   w==;
X-CSE-ConnectionGUID: VddI3NY2RweeOxefEH+LCA==
X-CSE-MsgGUID: bNyx3S3cSgKSut/LUzRcQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="11919947"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="11919947"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 03:57:32 -0700
X-CSE-ConnectionGUID: V37hiR9hQjahsul19JUr7g==
X-CSE-MsgGUID: ZuHmYsK7SPOMDaXkxMk1rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="37563007"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 03:57:31 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH 2/7] wifi: mac80211_hwsim: add 320 MHz to hwsim channel widths
Date: Wed,  5 Jun 2024 13:57:17 +0300
Message-Id: <20240605135233.a766c1465566.Ib859c7233511b61b8a34022cfceeb4971c739d80@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605105722.2034610-1-miriam.rachel.korenblit@intel.com>
References: <20240605105722.2034610-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

Setting a channel with 320 MHz channel width over hwsim results in an
array-index-out-of-bounds error. Fix it by adding 320 MHz to hwsim
supported channel widths.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index b5afaec61827..d0dac0db979e 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -2361,6 +2361,7 @@ static const char * const hwsim_chanwidths[] = {
 	[NL80211_CHAN_WIDTH_4] = "4MHz",
 	[NL80211_CHAN_WIDTH_8] = "8MHz",
 	[NL80211_CHAN_WIDTH_16] = "16MHz",
+	[NL80211_CHAN_WIDTH_320] = "eht320",
 };
 
 static int mac80211_hwsim_config(struct ieee80211_hw *hw, u32 changed)
-- 
2.34.1


