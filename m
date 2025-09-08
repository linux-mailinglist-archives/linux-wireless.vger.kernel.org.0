Return-Path: <linux-wireless+bounces-27091-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2C5B48BD7
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 13:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23267189E382
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 11:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C7A3081A3;
	Mon,  8 Sep 2025 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iMs62Nlm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD21307AF8
	for <linux-wireless@vger.kernel.org>; Mon,  8 Sep 2025 11:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757330031; cv=none; b=uaqtCz2Y0Djsnxn5F0prJUJAMEkinXGoCNhRtcut48Jzy+QUT09Jnt2m2GfRJsaU8S9k2xVfqkpQtVLD1NLVnOX5X9KJ2xBDsqeS/nZi238sHCpUJbyy03vcCg6pcnqwyEGlwOoTTvufyVn1Sb+W4l6z/ANvXWJBq7krBHRitXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757330031; c=relaxed/simple;
	bh=wONqyTUGoH1RpP+cSn0SInpfaUAMSpR7o6A1fUUphxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pOZjcpGqPU4y58JyAEw1uhMey9GEbllQnN7iQdx6V4JjO62bLWKZYkj/NacoEAqvfjM2lDqQdW0H46GpewSiwXH/XL1gfKYiCF0/+MCSGautiSTyiZV0EfPdT2U7UB2dYKeUEi1007HJo0JfCyeiRAgXVd7EJXC/jzUcpcBa+KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iMs62Nlm; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757330029; x=1788866029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wONqyTUGoH1RpP+cSn0SInpfaUAMSpR7o6A1fUUphxA=;
  b=iMs62NlmN1cNyjeP8bE9caDv6udPLDSzs2CVALM358CX/BxPcv86Feco
   rSnx6s0kmq8O27QI9yavHKC0LYUlg9twpvr5UkFwRp05LnrF2tPsKDeeD
   y6iuBxgYBCp9Cx7CKr1AIhDO2mIyiBFBEYhPdhqTvQTZBDKOycdof+DJS
   gLRSasHR5mHHV3YJM0e8KMrZMjH3BBDPzLNDvW2TzG/zSeesFDQWgxtyQ
   Z0wlwDXaY3hZDOslRrrl/WSkU2iHYuvfKJttIgM9xr5MCiL+z+c4O0xvA
   MBFwFuL0xjOGwQLOPWqrAmkhvulMKTMLBrrRu4yUZlnvVNlqYC8zQy1Qg
   A==;
X-CSE-ConnectionGUID: +mZdvB2yQo6fwy4786rhAg==
X-CSE-MsgGUID: n74/GwMdROOKEBPPx8Zhgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="77037909"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="77037909"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 04:13:48 -0700
X-CSE-ConnectionGUID: 2eILX7ALSrSSpwU5ZpxMIQ==
X-CSE-MsgGUID: PVN8UK7PT7+MffwaqANjiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="173126595"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 04:13:48 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next 09/14] wifi: mac80211: Accept management frames on NAN interface
Date: Mon,  8 Sep 2025 14:13:03 +0300
Message-Id: <20250908140015.46528d69e881.Ifccd87fb2a49a3af05238f74f52fa6da8de28811@changeid>
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

Accept Public Action frames and Authentication frames on
NAN Device interface to support flows that require these frames:

- SDFs: For user space Discovery Engine (DE) implementation.
- NAFs: For user space NAN Data Path (NDP) establishment.
- Authentication frames: For NAN Pairing and Verification.

Accept only frames from devices that are part of the NAN
cluster.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/rx.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 4d4ff4d4917a..feb81ffa4f8c 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4502,8 +4502,16 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 		       (ieee80211_is_auth(hdr->frame_control) &&
 			ether_addr_equal(sdata->vif.addr, hdr->addr1));
 	case NL80211_IFTYPE_NAN:
-		/* Currently no frames on NAN interface are allowed */
-		return false;
+		/* Accept only frames that are addressed to the NAN cluster
+		 * (based on the Cluster ID). From these frames, accept only
+		 * action frames or authentication frames that are addressed to
+		 * the local NAN interface.
+		 */
+		return memcmp(sdata->wdev.u.nan.cluster_id,
+			      hdr->addr3, ETH_ALEN) == 0 &&
+			(ieee80211_is_public_action(hdr, skb->len) ||
+			 (ieee80211_is_auth(hdr->frame_control) &&
+			  ether_addr_equal(sdata->vif.addr, hdr->addr1)));
 	default:
 		break;
 	}
-- 
2.34.1


