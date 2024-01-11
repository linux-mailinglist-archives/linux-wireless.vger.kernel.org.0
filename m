Return-Path: <linux-wireless+bounces-1734-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1993782B2C7
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 17:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF431F21EBA
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 16:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AF55674E;
	Thu, 11 Jan 2024 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BUaEQRUt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135F856743
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704989928; x=1736525928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cjNzF7bzDhWU0d3QtbNgVgZFEvHazHvccyCBI+S24Mk=;
  b=BUaEQRUtuIbOPiyUpo0X8s5ZiDTES56QbCeU9dd3tFtsvUnmwMbj/krY
   fntJZxaoFr4hDApUSpwVYiBI2SLYjsOBugOJtbGPG890Tv+EZURKtHK+e
   U4DGGnscuQEloe2RvnqZD3lE9Ifmj/9u5DXZLUalVIbiL9GwP7tAIWj5g
   M4UuuXwcSDJAcbPtaQp5U7zfAI+quNO5oj/EA19l5aoSrnox/fZeVJKLW
   D2BI1AxBWuGLH3uV6UfTRE5G9kPFvmXxqUji6c1NSpXQtOf0Y7s+gDpEJ
   Rr8L7Rang+CxAY7TmHtkUAm5hb9vZ70rf34/NAymAMCFj0WbBm9Jyx10F
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="463182627"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="463182627"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 08:18:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="1029606819"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="1029606819"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 08:18:46 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 8/8] wifi: mac80211: use deflink and fix typo in link ID check
Date: Thu, 11 Jan 2024 18:17:46 +0200
Message-Id: <20240111181514.4c4b1c40eb3c.I2771621dee328c618536596b7e56232df42a79c8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111161746.3978601-1-miriam.rachel.korenblit@intel.com>
References: <20240111161746.3978601-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

This does not change anything effectively, but it is closer to what the
code is trying to achieve here. i.e. select the link data if it is an
MLD and fall back to using the deflink otherwise.

Fixes: 0f99f0878350 ("wifi: mac80211: Print local link address during authentication")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 99188bd84799..cc9a8eaffa6b 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7869,10 +7869,10 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 	if (err)
 		goto err_clear;
 
-	if (req->link_id > 0)
+	if (req->link_id >= 0)
 		link = sdata_dereference(sdata->link[req->link_id], sdata);
 	else
-		link = sdata_dereference(sdata->link[0], sdata);
+		link = &sdata->deflink;
 
 	if (WARN_ON(!link)) {
 		err = -ENOLINK;
-- 
2.34.1


