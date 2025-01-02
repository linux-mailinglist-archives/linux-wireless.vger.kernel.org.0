Return-Path: <linux-wireless+bounces-16990-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C819FFA65
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 15:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3843A2FDE
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 14:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB461B395D;
	Thu,  2 Jan 2025 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IUC3GOR9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDEF1B4233
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 14:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735827644; cv=none; b=uFLIZpOS3zJ5PJr98CivAxvuUnp93czLpjiWLHKubX5fXIcOk7UIgsRHCrevfi1HcxPdDJgi5r1wAxmxRkjpgks+G1jmfcAUDSBYT1dex8/kLytVBZzgSc4OR7p/qd/sj+5SfPXzLIhHwj9z9RQv+GWwUDYlM/WOxU1Jut7SFow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735827644; c=relaxed/simple;
	bh=5/hn7fLDrtMrWx2i3IVHthKejSkJRj+Y0RApiVgFl9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AVZzBsQTQIq6iGJkcrvjsS88YVD9dXUrW8pfv+YU/lBeg0zbpKrkBkcrn6I7XPGTbG0G2C8Tk3OgqUIp+0UdtJgYoDCXhylRjh6WVf0HRIaGLcNwly8Zj9B513d4Mv+YX9crYCXZjW0qb/Y8fUIceYihdZdTLosF9QdNZxHcIkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IUC3GOR9; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735827642; x=1767363642;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5/hn7fLDrtMrWx2i3IVHthKejSkJRj+Y0RApiVgFl9U=;
  b=IUC3GOR9lK0O3fFyMKOSAwUqjN94c10ZXbg91rJFSTtB4AvxDd8hZFN7
   8a0biZBaRDb1BaF6/lb1RNb9thhmISTTnw2UNvdi3AbvytMN2zleyl4MC
   DhPrZG7/fl0Dd2w+owW2/fzd9HaYx338oVTfyTM6pmes3lt0cJiwxPNUR
   uTdiDxEOHeL/mH8zKbfwG9JZjJQTDEYXfdVautCWlagSV9+49+V7Zf2+k
   ODXCmVutCqo9J2ns+3nk1B7QVna2cUonAFfg8XPEYNomCaJls0jGDPEzd
   lo4Dywjm7k24bLzi2/BmTpaWuUgR/TTfbo8xaVe7U48mY9QwNiaDuha5j
   A==;
X-CSE-ConnectionGUID: Cslflm/5QYemB8jgyOXcqw==
X-CSE-MsgGUID: Kt9K0ETFT/up5o9eXIyPxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="46735123"
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="46735123"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:20:42 -0800
X-CSE-ConnectionGUID: Cgi8vnnPRKGHzZlbuBY53A==
X-CSE-MsgGUID: slPXrLWVRry3QinMyGv/uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="132357424"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:20:40 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 12/17] wifi: mac80211: pass correct link ID on assoc
Date: Thu,  2 Jan 2025 16:20:04 +0200
Message-Id: <20250102161730.2b06504ecaef.Ifb94e9375b910de6cdd2e5865d8cb3ab9790b314@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250102142009.3057049-1-miriam.rachel.korenblit@intel.com>
References: <20250102142009.3057049-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The link ID passed to drv_mgd_complete_tx when handling the association
response was not set.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index b08b59961bf3..4d9e3e58f3cb 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6081,6 +6081,8 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 	if (!assoc_data)
 		return;
 
+	info.link_id = assoc_data->assoc_link_id;
+
 	parse_params.mode =
 		assoc_data->link[assoc_data->assoc_link_id].conn.mode;
 
-- 
2.34.1


