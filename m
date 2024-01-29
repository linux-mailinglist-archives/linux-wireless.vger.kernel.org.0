Return-Path: <linux-wireless+bounces-2725-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA41841341
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294F81C241F5
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A3A5644E;
	Mon, 29 Jan 2024 19:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OwNthexf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A3F4CB28
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556149; cv=none; b=SJRXEl03gp/B4852Hp8bBdDtkfhBRn7T0XvFDNMmmCVHK6KBQre14bqToHe7KAhXPnVt4G6uwJPfXeZryDXxH4yyBCCGQvu6JFVwCs+pIMr3xhNG2GF/YWN53OdNWlMhiBGfVPjUjcXBbQ8gaHkY3JJp9Cagi9qVerQMUCAc030=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556149; c=relaxed/simple;
	bh=iyl51KOPMu5vxC3twfHTuHwunnTyidBauDRM0OI+wWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qr1kNsCDRZcqupmzd01MCkiwHnvMz9FAuv/Z7zEVDj6CthrdWBdQ8jO7+TsdRFWSF5OhC5MdzLcmak7VnXF3XkMMhRQM+tc1y460aJFjQveFslu0TDNIm+MT2kfkWy3VJ+8lHrR1hdo81e13v5QIZWqUaYGEB8dTi1N5me6mjZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OwNthexf; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706556148; x=1738092148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iyl51KOPMu5vxC3twfHTuHwunnTyidBauDRM0OI+wWU=;
  b=OwNthexfBpntdyRE3Q9qd+0EtLHYlwmpHEPK00t15In81PixTEk5lPb+
   5FLFqNgLQQW/MJK4chZjYsy/G6TU0qKc8NRESqsB/Mmv9YKXLlp3aYS6n
   GBLL/k1CMdw8T4Ir8kiWQQAhQNufakGNKgEPS1WfUlV2SgelJ6lKXAYXl
   JudrVGmpZByuJnHW7TXIbB+5H9Qw7AOOuYlhR6sfav9ivcfBrCs3JH+GK
   e4A+2lAZZC1Izel7jAIIt4WwNAcHgP8mHgeh0qhd0lVTDkbXaYtR3WPaz
   PSnij4COyeCMd5NH6hXASsECTGV30tBpYRBLn/geR4BhXET7k5lEJgSHT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="2942979"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="2942979"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:22:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="3459083"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:22:26 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Colin Ian King <colin.i.king@gmail.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/15] wifi: iwlwifi: Fix spelling mistake "SESION" -> "SESSION"
Date: Mon, 29 Jan 2024 21:21:52 +0200
Message-Id: <20240129211905.ff31e9385d29.I3a224e6a9294fdec431919fb4ec9315801e77454@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129192203.4189915-1-miriam.rachel.korenblit@intel.com>
References: <20240129192203.4189915-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Colin Ian King <colin.i.king@gmail.com>

There is a spelling mistake in a WARN message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index aceab96bcb97..703ccdd4d967 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -929,7 +929,7 @@ void iwl_mvm_rx_session_protect_notif(struct iwl_mvm *mvm,
 
 	if (WARN(ver > 2 && mvmvif->time_event_data.link_id >= 0 &&
 		 mvmvif->time_event_data.link_id != notif_link_id,
-		 "SESION_PROTECTION_NOTIF was received for link %u, while the current time event is on link %u\n",
+		 "SESSION_PROTECTION_NOTIF was received for link %u, while the current time event is on link %u\n",
 		 notif_link_id, mvmvif->time_event_data.link_id))
 		goto out_unlock;
 
-- 
2.34.1


