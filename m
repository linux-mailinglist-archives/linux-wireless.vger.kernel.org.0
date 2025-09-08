Return-Path: <linux-wireless+bounces-27088-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4BBB48BD4
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 13:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18E07188D30D
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 11:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFA6301480;
	Mon,  8 Sep 2025 11:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LYzUaqRY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B753009F7
	for <linux-wireless@vger.kernel.org>; Mon,  8 Sep 2025 11:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757330028; cv=none; b=qocP7W9tL25VVlyt62Uxx76ivYe4oKZqEARVEjY3z7TNjiKiG0HFKPpEQPBWPs+fziDVPt4CtAhsIGtEPXuUEOEhPb0mx+LlwcR8BViGSXjvheDfE1S1mM4Yd4enyJaA/cctWt1ByWVcfwL3apqINCL3kjJUdHUoJpYa0htRdZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757330028; c=relaxed/simple;
	bh=eunlzDci36JtWFeN2/xadOaBn7LGoweEoPESb4+N+xg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MeGsaJm5mfseRrE+QaEpHFdf7HWMyiagEVbMPEDs1M9H2IXKYglqEUXrfyrM136iR7zkZjKDHkYhlmKCUUhbpkbQv3mUnHPfC3rWj8193bl4DHED1R1+4R1DV3AHbaDkxnZ2aJtekFIi8sl78L7rJW9FypQpgZPA4VxPZ6NnuC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LYzUaqRY; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757330027; x=1788866027;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eunlzDci36JtWFeN2/xadOaBn7LGoweEoPESb4+N+xg=;
  b=LYzUaqRYq+flmnUuLYCZMOkYqzY8LwVduqPVjgvhz328/9Bx6kEKa3M/
   Q7l7UB1LqnpUUNWxawkMsZI9x78YEUqYKP+FW5JUTzbOnLAjpLgX1LDZS
   ASAIt78EH7pdmVAIbBubWoxQJnhNQC4d2gaRj8HB4nl0hge2wJ/r32GMo
   CIIZukFzYDv+SGyLtuahOhRYNeHt97QImq4VKC1zvXg4AyBbD9kTuI3Yj
   upwwSPZPR5EKFvDBuSBHZ+sZ1WtPV7HKukTpa8DpnInRFlVQ+mXCay3nP
   0TNEwdYzXXEtkZWVCZGbabaX1RKfzKYskvKNv/d+vu21K2/j8KKG7R8hr
   Q==;
X-CSE-ConnectionGUID: +VhE2KK0Qc+zpn8tvwWEkA==
X-CSE-MsgGUID: NuNavCkNSKeIZ8VV8V1quw==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="77037897"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="77037897"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 04:13:45 -0700
X-CSE-ConnectionGUID: 7We6rr8KRcqUDQJXcO6pDw==
X-CSE-MsgGUID: MoJyIvZNS+K0XCPc+Hqukg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="173126574"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 04:13:44 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next 06/14] wifi: cfg80211: Support Tx/Rx of action frame for NAN
Date: Mon,  8 Sep 2025 14:13:00 +0300
Message-Id: <20250908140015.71da2b062929.I0166d51dcf14393f628cd5da366c21114f518618@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908111308.2688889-1-miriam.rachel.korenblit@intel.com>
References: <20250908111308.2688889-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Add support for sending and receiving action frames over a NAN Device
interface:

- For Synchronized NAN operation NAN Service Discovery
  Frames (SDFs) and NAN Action Frames (NAFs) transmissions
  over a NAN Device interface, a channel parameter is not
  mandatory as the frame can be transmitted based on the NAN
  Device schedule.
- For Unsynchronized NAN Discovery (USD) operation the
  SDFs and NAFs could be transmitted using NL80211_CMD_FRAME
  where a specific channel and dwell time are configured.

As Synchronized NAN Operation and USD can be done concurrently,
both modes need to be supported. Thus, allow sending NAN action
frames when user space handles the NAN Discovery Engine (DE) with
and without providing a channel as a parameter.

To support reception of NAN Action frames and Authentication
frames (used for NAN paring and verification) allow to
register for management frame reception of NAN Device interface
when user space handles the NAN DE.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/nl80211.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0e246e166f74..4d0f37962cf4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -13781,7 +13781,9 @@ static int nl80211_register_mgmt(struct sk_buff *skb, struct genl_info *info)
 		break;
 	case NL80211_IFTYPE_NAN:
 		if (!wiphy_ext_feature_isset(wdev->wiphy,
-					     NL80211_EXT_FEATURE_SECURE_NAN))
+					     NL80211_EXT_FEATURE_SECURE_NAN) &&
+		    !(wdev->wiphy->nan_capa.flags &
+		      WIPHY_NAN_FLAGS_USERSPACE_DE))
 			return -EOPNOTSUPP;
 		break;
 	default:
@@ -13842,7 +13844,9 @@ static int nl80211_tx_mgmt(struct sk_buff *skb, struct genl_info *info)
 		break;
 	case NL80211_IFTYPE_NAN:
 		if (!wiphy_ext_feature_isset(wdev->wiphy,
-					     NL80211_EXT_FEATURE_SECURE_NAN))
+					     NL80211_EXT_FEATURE_SECURE_NAN) &&
+		    !(wdev->wiphy->nan_capa.flags &
+		      WIPHY_NAN_FLAGS_USERSPACE_DE))
 			return -EOPNOTSUPP;
 		break;
 	default:
-- 
2.34.1


