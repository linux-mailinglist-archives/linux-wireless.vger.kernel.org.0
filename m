Return-Path: <linux-wireless+bounces-25132-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B62AFF326
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C52A84E37AA
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 20:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4818124466F;
	Wed,  9 Jul 2025 20:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ItBZ3aAs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F865241680
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 20:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752093510; cv=none; b=YATDnezD4UVsaHCJ9MqS3/byFj4uAoF4StKvySs4La2MHcRQG1SDKu4wj8CB3FpBozVzflrP6eU96ss1gAvCpvUvkqkyMip44bNAbEZ4JLf7rXL8Or5V4LwYFNzRQl1KhfTQr/aBooR1cmgRyCzBzplb+hhrXk5uaG5/zWiDa0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752093510; c=relaxed/simple;
	bh=eXzxRIWSaOOYFB49Qg0uf2hrtDrE3kDVt+QGgiexB6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ovJKy8/uhc1Wy8eemXpgCje3tqFAuxz7wOTPn0RziOD50sFe1s0/BbCGMcEJV6kH617sZmBZUSBIieThruvQ6aTcaxXVYdUgASFL6Gy0VtuF+dJqTpOBo/zhhp33Poo76eIZTT49jIm/beWNprkTQqTCMbOnMy11u+HiNe35jOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ItBZ3aAs; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752093508; x=1783629508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eXzxRIWSaOOYFB49Qg0uf2hrtDrE3kDVt+QGgiexB6M=;
  b=ItBZ3aAs50SXfirBbuIfExYkjgzOyLdKzYvWvn+jTOelt1n8x4W7E/5O
   tGqkiKAOFbleQz+auWrLG2hDF6S/gYtofk+kldItF/TUptt7awmTWax2P
   RuQstYtxReAzRBLvIQduRuVoQKwjn4ZbB7/y9pk/4oh6FluahJTzkfzS7
   xjSIU16jR6qOntnQXwdp4UjpJHUIm1s6MPTX9uIyB4QBMBKhuhC8W8GsB
   DBnUOy2J7xj2fGbR0xIG//l9CaER+bR+Uc+KuRPPPaVJXHzywuTnKVuO3
   WmIH7nHxSxZEHExN3LYddSqDySI5ufbubBp936R8wveM6AwgWNCXm/Ny5
   Q==;
X-CSE-ConnectionGUID: 3QHfF03vTsGPoV9o03Y8nA==
X-CSE-MsgGUID: vk8P5qezTDWOUlKO940tAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="56974441"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="56974441"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:38:28 -0700
X-CSE-ConnectionGUID: X0tWCl0cQ66AHoVAtonzqQ==
X-CSE-MsgGUID: SEOvXz3ZTlmv8TvP3yl2qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="161532779"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:38:27 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next 03/11] wifi: cfg80211: Fix interface type validation
Date: Wed,  9 Jul 2025 23:37:55 +0300
Message-Id: <20250709233537.7ad199ca5939.I0ac1ff74798bf59a87a57f2e18f2153c308b119b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709203803.1736809-1-miriam.rachel.korenblit@intel.com>
References: <20250709203803.1736809-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Fix a condition that verified valid values of interface types.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 6ec9a8865b8b..f67424ec1085 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -633,7 +633,7 @@ ieee80211_get_sband_iftype_data(const struct ieee80211_supported_band *sband,
 	const struct ieee80211_sband_iftype_data *data;
 	int i;
 
-	if (WARN_ON(iftype >= NL80211_IFTYPE_MAX))
+	if (WARN_ON(iftype >= NUM_NL80211_IFTYPES))
 		return NULL;
 
 	if (iftype == NL80211_IFTYPE_AP_VLAN)
-- 
2.34.1


