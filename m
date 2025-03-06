Return-Path: <linux-wireless+bounces-19942-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9BCA55927
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 22:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ACD77A1DA9
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 21:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AC227602E;
	Thu,  6 Mar 2025 21:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mymPakt2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BC0DDA8
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 21:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741298090; cv=none; b=O2HkL1doF7OlEDaIE1zQtTOHLfty6+gBFsfsHOnO+/5rteBRIj+TJmOyX+asPSUHxrU+bx7X0Eua82o+RKurcJA1KGxlFGLzvLqnZAVDZikr5G6tx1s9oVJYfXTBfC5nSvc33dL9T7+iOnzPdp4V6kIpkvf+DFiUjsBypgUVOMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741298090; c=relaxed/simple;
	bh=OcwMVUftHloHWahd9G3SrJRuG0ltSU0zhTYOeOJ04Ys=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j81Adq6AI5HIWqr7Pd18sLFwoppTm12TDy9RgZOdRRgWUt4lH1UGNRFqQQSWO4frmBIGu12UjoqRNlPV3f2QDOuPbsGenD8gVUZ45vklO186DTfN6VzfKYyHkzHNs8KDlNaGU+Oi9sKGgMhVTDaYiDKZukUFK+19ymaUs9EgxMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mymPakt2; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741298090; x=1772834090;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OcwMVUftHloHWahd9G3SrJRuG0ltSU0zhTYOeOJ04Ys=;
  b=mymPakt2a4cgsx6VRedZkC7U8yp5sprzM85u97BvEWuSNfAMRt+MUVrk
   EIDP6YV+jqzgSR5G36M6McSLxBLqc9IyDB5/UmQ7OUaO2zkJmAWuI4tQO
   fYtpmwGU9DPuSHW3jnpWFgUzNBIQpe1ZVPfpyMlsfNixfLHkRb58spxFm
   VIRlzODhjADfKj/uCkPNB/20Nj5wgergG9c3m3jAPphXmOe4asarw/TL+
   9J48JNG/0k2pYdI2lSpA+JFCc3E90R/qPwgZuvCqHSgnWFpy+7o+zfG2z
   aJa4zV7isgr9HaPZpqgqFY5NedzZVupDhx9ysN96SwNA8lryWXyN5hf8z
   Q==;
X-CSE-ConnectionGUID: bJPXnyugSXKHcTnphNQAZw==
X-CSE-MsgGUID: f2pLVz4NQv2rZ4PuZP7Qxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="52540902"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="52540902"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 13:54:49 -0800
X-CSE-ConnectionGUID: zD3u5PaIQw24PHK4wUiGeA==
X-CSE-MsgGUID: ASDha+k0QOCCgxea2YwNiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="156365778"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 13:54:47 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 wireless-next 15/15] wifi: mac80211: set WMM in ML reconfiguration
Date: Thu,  6 Mar 2025 23:54:35 +0200
Message-Id: <20250306235306.5c9787cdaefa.I362c3101d3f523a8db37c16cd7b5f573d76a36e6@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In the per-STA profiles for added links in multi-link reconfiguration
the WMM element should be included. Fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 1 +
 1 file changed, 1 insertion(+)
---
v2: remove nonsense from the commit message

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 94d9d9ca42fe..bfd3653a5b84 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -10435,6 +10435,7 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 			return -ENOMEM;
 
 		data->assoc_link_id = -1;
+		data->wmm = true;
 
 		uapsd_supported = true;
 		ieee80211_ml_reconf_selectors(userspace_selectors);
-- 
2.34.1


