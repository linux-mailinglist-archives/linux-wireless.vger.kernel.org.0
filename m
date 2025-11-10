Return-Path: <linux-wireless+bounces-28759-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F39C46738
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 13:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2679C3BF604
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 12:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A301C5D7D;
	Mon, 10 Nov 2025 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PuL6tvNY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB36307AC5
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 12:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776205; cv=none; b=rrQXdcZhwlXQECISj6yU3z5awE02Pn4EoHdpKwijD8cnH3TffizUTEUHm14VvaIWESHg/jkwcv0+e43y2Z6wAUUERnIuwlCFGlmbp82SW/N/HpTte3mYk1mfbTJ0L/MVGsAnXcXAd4HG/fB+2MFaxRb/zRvwxwUyAVP2WBItkzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776205; c=relaxed/simple;
	bh=xsCmInmataWc/e/yd2jqrEbAUcuSSCrngg+CNqylIpk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ujDJd3iIlxTjCouvAL1bOfv4LVaJkx4O6SIO8r/mlXPm2mHObKcubJNbwrDMiG9WbZH5GGwtYEdEEXvh1nJVXPIWEdzhsjN2ue5LN0yax2kaiYDKnOqMQ5qNn4M6sAuinHVldAaP3hZJFfYMlGdkJGaMIwxbS2ilUr0eyKYEvYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PuL6tvNY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762776203; x=1794312203;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xsCmInmataWc/e/yd2jqrEbAUcuSSCrngg+CNqylIpk=;
  b=PuL6tvNYCK1007qmi+NfFy+oCSoaJt96VLCeX4/s5+1NdLWi4q96u4d9
   hmDEq68/5s3ejx8a02Bxx6zE48G48PLFaQIV8Q2icQNRWbbu4QWKAbH9T
   MUZ8ApEGRxm7uFYKrqxrkHbNKy/RbF/ImGnsq0e0jLaI/bIVmtJasVnqZ
   yM/sUF3XSTB//H409YEapHEjp6ykdYXKJ6r+HV714QMnZI3sLxVCGgmrs
   5Fl+mX0mkhqXQJEN1uGDIf1PnIyGzg06IdQkQNixDAemTETryqYnNL5Nx
   xO3SldDmp6JJKG439cKiP6cIMy4bySWSJTcZaODeO88hBgf2uNkIPBVnC
   A==;
X-CSE-ConnectionGUID: oFb6H/u9TDuc8KqxMagkHw==
X-CSE-MsgGUID: 7PMaSeRdQD6acCV5YexYeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="64031005"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="64031005"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:03:23 -0800
X-CSE-ConnectionGUID: 7GWUuVceTmWkxdcVbGIZQw==
X-CSE-MsgGUID: jSfJQfIRT+SYZSWGLzWeew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="219311612"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:03:22 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: cfg80211: use a C99 initializer in wiphy_register
Date: Mon, 10 Nov 2025 14:03:15 +0200
Message-Id: <20251110140230.f8d4fcb1328b.I87170b1caef04356809838e684c9499f5806e624@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

struct regulatory request was not fully initialized. While this is not
really a big deal because nl80211_send_reg_change_event doesn't look at
the other fields, it still makes sense to zero all the other fields as
Coverity suggests.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---

V2: send to wireless-next and not wireless

 net/wireless/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 56c0e2e4bcb1..c3a7bff6eaf9 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1067,12 +1067,12 @@ int wiphy_register(struct wiphy *wiphy)
 	wiphy_regulatory_register(wiphy);
 
 	if (wiphy->regulatory_flags & REGULATORY_CUSTOM_REG) {
-		struct regulatory_request request;
-
-		request.wiphy_idx = get_wiphy_idx(wiphy);
-		request.initiator = NL80211_REGDOM_SET_BY_DRIVER;
-		request.alpha2[0] = '9';
-		request.alpha2[1] = '9';
+		struct regulatory_request request = {
+			.wiphy_idx = get_wiphy_idx(wiphy),
+			.initiator = NL80211_REGDOM_SET_BY_DRIVER,
+			.alpha2[0] = '9',
+			.alpha2[1] = '9',
+		};
 
 		nl80211_send_reg_change_event(&request);
 	}
-- 
2.34.1


