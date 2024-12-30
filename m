Return-Path: <linux-wireless+bounces-16886-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D60D9FE27C
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 05:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2BBC161B0F
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 04:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604F717E8E2;
	Mon, 30 Dec 2024 04:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M2L+gYNl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DD317084F
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 04:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735534576; cv=none; b=r74ynI5Fnb71BUPaDXe4qy95v/MErEiSgBqP6TcsOccHKbEKUAPix5Wp3NVeL+nnYSWSM1102uqvcMAJ4u1eaHyqYsAT7Px6R2YiC8FR6Wyz7Aqr9IRiUOOrfEB+z4D4BE3l6ALo3HwdOagUiNHT0c+1pWzoLnd77Gp4p8ZhKQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735534576; c=relaxed/simple;
	bh=vLzBD5PyNygwMDIjiO166J7rSkaXo8iUuaAWJxxLTBg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H33IW3Y2I+JsruSi/DSwMeqr07FPeCsNvKNmyzPJ3LqpVdOkSKGPLmVU6Ps7QtybKSmQjmInAll+gl//H82qqsrfqPAZxbOAlWN5oFB4fvOlgNQNbbG8jw9PP0JB1ezU7XuF36JWTpjjFzsV16Qv0C0S6TiS1ve8ruTx0T98HWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M2L+gYNl; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735534574; x=1767070574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vLzBD5PyNygwMDIjiO166J7rSkaXo8iUuaAWJxxLTBg=;
  b=M2L+gYNls8K4DSJdKKPgG7y81L5GM72BINIP/mp8JhMdC+Zoh76TFzp0
   c8dJ33cBRU2QNISFTRssN1lo+JpOyxpZ7z5fIVvsPaFqQSMim9IridnRw
   jin8LJwDcWMtb8Aw91fHl8r8rk1NdWavkHAqwTUrOiskAC6ll5n+tVZdT
   0NjQWEugxa+Jjt28Q8OmPGrURz0/q36INgdcPQmTmBxlK8I0NLpLDNZxw
   sSa6+cPGX1KduMcP/op4zg48dsc3YH5t7OTYYOCiZ6vmMUzynUPusijlc
   BR+T70qTN6fxBdbqpEf1LFfSZsbsFfnKys+5QXwEdo7iR80MHUTO+eqf8
   Q==;
X-CSE-ConnectionGUID: 4VgZP0PXSA6iUF4/UXhPxg==
X-CSE-MsgGUID: F8yrqRwOTz63EoIqJNWI8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="46405006"
X-IronPort-AV: E=Sophos;i="6.12,275,1728975600"; 
   d="scan'208";a="46405006"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 20:56:13 -0800
X-CSE-ConnectionGUID: iyBSIUKvRQ+SPkNMg0BKAw==
X-CSE-MsgGUID: W3FImlFwRQKner1k9OK05Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104758873"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 20:56:11 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 03/15] wifi: mac80211: clarify key idx documententaion
Date: Mon, 30 Dec 2024 06:55:42 +0200
Message-Id: <20241230065327.4e414710fba7.Ib739c40dd5aa6ed148c3151220eb38d8a9e238de@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241230045554.3746143-1-miriam.rachel.korenblit@intel.com>
References: <20241230045554.3746143-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

ieee80211_key_conf::keyidx s in range 0-7, ano not 0-3. Make this clear
in the documentation.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 9cb88ef4b7c9..34382d014c8b 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2216,7 +2216,7 @@ enum ieee80211_key_flags {
  * @tx_pn: PN used for TX keys, may be used by the driver as well if it
  *	needs to do software PN assignment by itself (e.g. due to TSO)
  * @flags: key flags, see &enum ieee80211_key_flags.
- * @keyidx: the key index (0-3)
+ * @keyidx: the key index (0-7)
  * @keylen: key material length
  * @key: key material. For ALG_TKIP the key is encoded as a 256-bit (32 byte)
  * 	data block:
-- 
2.34.1


