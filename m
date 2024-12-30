Return-Path: <linux-wireless+bounces-16887-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A5E9FE27D
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 05:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17E4161B81
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 04:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA71181B8F;
	Mon, 30 Dec 2024 04:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MrvlyN25"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EDE17CA1B
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 04:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735534576; cv=none; b=P7iY/VwtaOFyAkMtU7Wx2rVGPv40Qjslwls7T7ber7sq/7UAOEddUOIrHS6a/tn64tHecPQYlbX9QR7914a4hbRcnOCK6JTQN23tW6wHqjMfUs7jWRm43JyrQWMDX/LpL+T9utvtK7KQYhzaOGhuGwjKD6WyS6KpiD8n5nOjNl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735534576; c=relaxed/simple;
	bh=svEIVfxwLoYVMmVs55FX65H/bNtF1p/CDXdPlQIvrMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jnKwAM9o865kvyrLHg2A50VK02j0DqycEdilmhHTBNnHi6f4oHEOn603facxfqgUlqPPvY5yOP6v+Y72vtKGAeeruE9kYD+dB8xAeCA/4QSl5/RSfPAtdBOxrXfBTMdsVBgFjBZV1NHmZpioSgh6KV7wpin1VaGHzhESO+jcKR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MrvlyN25; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735534575; x=1767070575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=svEIVfxwLoYVMmVs55FX65H/bNtF1p/CDXdPlQIvrMw=;
  b=MrvlyN25wz23Z9+stimpvPuzhrXLpdWGVCw7G9guzbLU9J8TJMaVDRfL
   27Gv0wY/qkuGlkgV2NqYupYT6iARM6yIBeG6Pv4wYC2S1sCRlpT38IxGM
   Kwp+gH2vlC6Ytg8Zfjyd8T1IFcrE2ILX7aTRsTYIdolocBZlr43aGFY7C
   HDzTdvE9HVJjMe4PMQWVN3TGdDcgzvnKfMc3CNzsnyQ0OAgkEGs9BTrFY
   PBZOjVVyhBvI9Ari6zAFRH32NWLYZkBKc3UIKjX0ypSYbgDPe7Fj1pc1h
   UgKah1X5kXRX4IXM0HQpAFM5H65XE3F2SK/wAdiGCEVaV3OLrrMG4Fqip
   A==;
X-CSE-ConnectionGUID: vkNols54TwG8ZQZsfSn5bw==
X-CSE-MsgGUID: 0X148jPQRruBsuxiK4AzzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="46405008"
X-IronPort-AV: E=Sophos;i="6.12,275,1728975600"; 
   d="scan'208";a="46405008"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 20:56:14 -0800
X-CSE-ConnectionGUID: RRRIWvqNRbqc00RQl7voZQ==
X-CSE-MsgGUID: NAzsmCY3TXihvVoqRixc1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104758878"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 20:56:13 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 04/15] wifi: mac80211: reject per-band vendor elements with MLO
Date: Mon, 30 Dec 2024 06:55:43 +0200
Message-Id: <20241230065327.bb82d3aaf6ef.Ib30573d0666430a3d7a905e513dfc661edf0bf65@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

The MLME code doesn't currently handle adding vendor elements
correctly with multi-link due to element inheritance. Simply
prevent that for now completely, if someone needs it we can
fix this later.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index f13c14fa82e8..53e5aee46885 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1310,6 +1310,11 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 			    sband->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 &&
 			    !(iftd->he_cap.he_cap_elem.phy_cap_info[0] & he_40_mhz_cap))
 				return -EINVAL;
+
+			/* no support for per-band vendor elems with MLO */
+			if (WARN_ON(iftd->vendor_elems.len &&
+				    hw->wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO))
+				return -EINVAL;
 		}
 
 		/* HT, VHT, HE require QoS, thus >= 4 queues */
-- 
2.34.1


