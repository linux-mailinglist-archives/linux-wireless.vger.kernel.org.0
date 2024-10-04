Return-Path: <linux-wireless+bounces-13496-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F23B990018
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 11:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3303B241E7
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 09:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1621A15539F;
	Fri,  4 Oct 2024 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mLrzdkb8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99612155306;
	Fri,  4 Oct 2024 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728034902; cv=none; b=YjNlp0P1wMQUAwj+ZoSJqbYvZXfoFeSig/oEGJHhUAFwORQofedOlMzS4wKGN223mzsW2bF7ODzFNzpVyFphIq0iQG1HDBsFbZEAQ/b6E0O1Htx4Dpf1STOMTV06t/EAOM+2c2qCjNCbHiCrhxVmd6KZCgnM7rEDHg+6HmuXzHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728034902; c=relaxed/simple;
	bh=XcQ/SIxOgSwKmk7hExtOIzbVgRKsCxDIm/Va05iUZhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UNWHtogHzQzECEnoNUa1l8Mj2sFRHLjq0JgQLnCc2p1njMwkMUNkJAZPplMskBkvtSZ1pCkDmcJmFl0TJojrnuKmsR8SICd2qVaGzS8uEK61t81MLyK87nIqj1O6jXbRNm/Eg9UtQs/EBn9snW6t/w6q6IxLXC3aWXr2tLilVRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mLrzdkb8; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728034900; x=1759570900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XcQ/SIxOgSwKmk7hExtOIzbVgRKsCxDIm/Va05iUZhA=;
  b=mLrzdkb8cjYqXdSk+VtbNU1tVJ87Az9p4CpxApfeDpBmHoLPjXrxSCeB
   smEAPJBu4Ep++wnE87v9I/4bMNsjab9k6fyAM2k6elFZ+Nmsd0y31hCwR
   kFAIrlwywOV1JDc7OGcHUTN5zbvy5H2vv2+vWpHmRUHhp4vuvHwcv9yXn
   JLY1jwj4fKpELiYSnnE/1oDYaPCsE2D6W5T5t8k71QvjsqXSj1aNMJxvs
   OCUIUPBP1lfynBeC0NttBrhgr4vZBk81zJbmW26t0718p1CL859VA/0Fb
   UPaikh9X7zzLT3y7a6e9Wd1lPN1oeNvkHXE3QmESWqlWxgep5iZqq8r8c
   A==;
X-CSE-ConnectionGUID: 2/UEVVvaTPuNmdhA6eB9+w==
X-CSE-MsgGUID: WjEMVxfFRuGmeGZIhBGbdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="52656253"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="52656253"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:41:39 -0700
X-CSE-ConnectionGUID: xc9ZSCXmQMi38TR3s9FCaQ==
X-CSE-MsgGUID: Gd+pN6jMRg2jyahAitoY6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="74975098"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:41:38 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 0F73F120CED;
	Fri,  4 Oct 2024 12:41:34 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1sweoY-000Tcy-0A;
	Fri, 04 Oct 2024 12:41:34 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Mark Greer <mgreer@animalcreek.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 31/51] nfc: trf7970a: Switch to __pm_runtime_put_autosuspend()
Date: Fri,  4 Oct 2024 12:41:34 +0300
Message-Id: <20241004094134.113878-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
References: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_autosuspend() will soon be changed to include a call to
pm_runtime_mark_last_busy(). This patch switches the current users to
__pm_runtime_put_autosuspend() which will continue to have the
functionality of old pm_runtime_put_autosuspend().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/nfc/trf7970a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index 9e1a34e23af2..4549f1960a27 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -1093,7 +1093,7 @@ static void trf7970a_switch_rf_off(struct trf7970a *trf)
 	trf->state = TRF7970A_ST_RF_OFF;
 
 	pm_runtime_mark_last_busy(trf->dev);
-	pm_runtime_put_autosuspend(trf->dev);
+	__pm_runtime_put_autosuspend(trf->dev);
 }
 
 static int trf7970a_switch_rf_on(struct trf7970a *trf)
-- 
2.39.5


