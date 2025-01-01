Return-Path: <linux-wireless+bounces-16953-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918E89FF2D4
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 06:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5898C161A9C
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 05:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D29179BC;
	Wed,  1 Jan 2025 05:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eNTkBJtP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6679F12E5D
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jan 2025 05:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735707958; cv=none; b=jvSx0AdOG6fThyM8QNz9iCb55ZiZ1lYTkXJOSUizPsnSRsHD5CRfwVjNOZJX0QMm/fzNVFnnci/KoAh15vWyb0eeDhr2lCxga/VJNsLk6T6Mtt+Lxb+i3xSg6aDwnYMnZeoz5+uGxNURAJt/n6gm4Mu6X9jWGhMGB2mH4Fx3A+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735707958; c=relaxed/simple;
	bh=vLzBD5PyNygwMDIjiO166J7rSkaXo8iUuaAWJxxLTBg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tKNMKM197MFjbPBN3v87TRly5LKmLWVcDl9GKPkB2MRz2XbQ3OubBCmgvHCFz1H8vUtxNEeY2CPZiqpKKvRAE5eag8jfWNngqziaHp0s7D8zxJRaiaC0XJk3MrhtDNgcHdQhVED8k3BcCueWkdRK8ASV54T24/BgMJJpa07BV30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eNTkBJtP; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735707957; x=1767243957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vLzBD5PyNygwMDIjiO166J7rSkaXo8iUuaAWJxxLTBg=;
  b=eNTkBJtPqujsxIsd+RcxkJ4lKcgsD8Cc8Z9BQiuD0dPL/Y0Ko4DjR5pA
   it9MS1xk181QqZ5jmrFBGZSGT8EB1BCIwo1x25+P0vR7/oeFJNOIni8vG
   uy74fxD7sAMXd1yCRGiRanFy0i/EKdtS4nDI1Y5Yf5zjTv9ueZNotm76C
   s7HZXNKNE+z1bl7o1tmgimzuu8Dq3I6RMIUMw8WoMF+b45PX0bbIx3m9Z
   438kueoBqj9vX4N84Fg5cYf5sknCPP1MxBuCHxgvNro6sqDy+4yLYDFSs
   e3ghaUF5j9nykxjbQZgJgbPI55nVVYrVtL8pD/IjJtpPyOmsCMAIvnByJ
   g==;
X-CSE-ConnectionGUID: DdlqoIGmTdu0U9vvwjSa/A==
X-CSE-MsgGUID: YdoLdo0/SCKEwG1rcWfrIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="36194401"
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="36194401"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:05:57 -0800
X-CSE-ConnectionGUID: QOItK2fKRbmh/hCRHvKZ8Q==
X-CSE-MsgGUID: zAE3GvSjTbasqmYrnab4Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="101618875"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:05:56 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 03/19] wifi: mac80211: clarify key idx documententaion
Date: Wed,  1 Jan 2025 07:05:23 +0200
Message-Id: <20250101070249.4e414710fba7.Ib739c40dd5aa6ed148c3151220eb38d8a9e238de@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250101050539.1718643-1-miriam.rachel.korenblit@intel.com>
References: <20250101050539.1718643-1-miriam.rachel.korenblit@intel.com>
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


