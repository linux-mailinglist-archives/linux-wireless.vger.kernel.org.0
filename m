Return-Path: <linux-wireless+bounces-27089-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D02FB48BE3
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 13:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE1F3C8112
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 11:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEC2301482;
	Mon,  8 Sep 2025 11:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YhJyY0eD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CA8301011
	for <linux-wireless@vger.kernel.org>; Mon,  8 Sep 2025 11:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757330029; cv=none; b=A1P+j8R4SbXp9fjk6qQn/Em9Mj52enGpbf20HQ0J2XWBDPA8FcOOeC3xlndEBjHS/9Odoa0Ka5nVVE5hlK8Q3wJdIaodAUedDVfoHaZLbmJXOUl29fCCDXtdkqLDcxlu5jmRElK/HZIYTU4OdUMoy/kt3r9NcEBSuoNxkXPjY0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757330029; c=relaxed/simple;
	bh=3LoFXeyKOtxqPSws/LblNQMhBFUQ/WzZ18lKeMZznzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bziji/6azsEM8HWhwdBfIYb6mnJzkuKm1Xco9grsqsnK2gnrEytDhgObRf/a4zcbGMjYxo4SkrM+hhpL69plyURXI2T2+nGbO4TEEgAeQB1FvO0upxaINtraSRCfaSe6go1hERrG3+C2rA0NDV1lGXaM8Uk3+JSEhWrQ+1vtOYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YhJyY0eD; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757330027; x=1788866027;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3LoFXeyKOtxqPSws/LblNQMhBFUQ/WzZ18lKeMZznzk=;
  b=YhJyY0eDfZA+MWMYI0RldH5avyU+Hm6+/7frAyK+zgTd2fYQ2ae43pFs
   qq5b7IdCl/BcGlVT9ZH+MCLhbgMHy9/bBGiCz3UO4/dv/Fh49wim8HaNy
   KKp9ubIefSlT4P/019gZdNMrewS1RCzOljvAqVpoOlucFEDhrXQwZEIHy
   GFKxqL18uwHXt1Dc3UwManq8/qx5CebGCeO3LJu7H6QlVHCBL+mqBgZ6Z
   iOzochKW+u/q1iKuG9btPr28+D6v71wcRH+89sHmv9DM32L8LsCGtRcqz
   g1zWku42L3fpJ+AsKBo7Pj4ycOj7HVzrJ/T1CBMxcbutYQ4Pvyg9ZHyFk
   g==;
X-CSE-ConnectionGUID: Zhsy5o5zRnqV5wbr5cRXAA==
X-CSE-MsgGUID: 53iRvsdgS8uHbYPKfs2Luw==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="77037900"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="77037900"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 04:13:46 -0700
X-CSE-ConnectionGUID: 0zzm96sxRsiEbq3AJtbGjw==
X-CSE-MsgGUID: 0lJgarzNTla8GmZpW98wfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="173126586"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 04:13:45 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next 07/14] wifi: cfg80211: Store the NAN cluster ID
Date: Mon,  8 Sep 2025 14:13:01 +0300
Message-Id: <20250908140015.63e9fef2a3aa.I6c858185c9e71f84bd2c5174d7ee45902b4391c3@changeid>
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

When the driver indicates that the device has joined
a cluster, store the cluster ID. This is needed for data
path operations, e.g., filtering received frames etc.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h | 3 +++
 net/wireless/nl80211.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index e30c1886c530..26fd42e189ce 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6681,6 +6681,9 @@ struct wireless_dev {
 		struct {
 			struct cfg80211_chan_def chandef;
 		} ocb;
+		struct {
+			u8 cluster_id[ETH_ALEN] __aligned(2);
+		} nan;
 	} u;
 
 	struct {
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 4d0f37962cf4..eb96d3709287 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -21864,6 +21864,8 @@ void cfg80211_nan_cluster_joined(struct wireless_dev *wdev,
 
 	trace_cfg80211_nan_cluster_joined(wdev, cluster_id, new_cluster);
 
+	memcpy(wdev->u.nan.cluster_id, cluster_id, ETH_ALEN);
+
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
 	if (!msg)
 		return;
-- 
2.34.1


