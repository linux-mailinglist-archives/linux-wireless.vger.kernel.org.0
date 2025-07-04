Return-Path: <linux-wireless+bounces-24815-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD689AF8BAE
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 10:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE0BA1893605
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 08:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944632E92DA;
	Fri,  4 Jul 2025 07:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="et60A+wg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C0F2D542C;
	Fri,  4 Jul 2025 07:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615685; cv=none; b=Q3VDSepiYJUJSIsvC6wGafHkeJTfSaZgezaw+8PA4jJLmlZeHl94yBarbrIF3F/8Y7t8Lozmt/u8QmQrM4UsxJXYJH6q7YWURkWXycqJ0ovamHDXn63diNIEJJdQSrui2ONzkIjFzRd1JXHsfqed2w8nR8pmvaZvdH3aiUxO6kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615685; c=relaxed/simple;
	bh=logG108dBu9v+vZYmJaE48QCvdOD6icuV7EBnGifvsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NiJsKcoAUaY4XtX/XqmO6Og9fuogxCUnE//068g6qbFClog7eoaBiFQNxoPMbeMkMxOs3FGA8wl0M3RHkRZ7Q9qowFwkyEw4g/mncnc2RKfLfTs2XtX8ysTKCniS/4y4Y/l4Bo+4K2T6vtP8798XDvy7xFdk6FEmzP4hs51Ul0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=et60A+wg; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751615684; x=1783151684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=logG108dBu9v+vZYmJaE48QCvdOD6icuV7EBnGifvsg=;
  b=et60A+wgq6ISM4GjspNUpyRrKOfpEW3a00WN/zWYCu679/xm7leuYdCz
   ZaSNNbHzCcnBjoJJjl9VZhXdu6aI/nvcGzbqAqESqTejeYk+8E3YyLnK8
   I6nPvLYt0QK1JHfJVjKCBeoXj5Crodrx/Kov0WZTRxrM0eFYW4ghQ5At0
   g/YYBlvRs4mFgxIPnCETdAqK6urMIrbegiA8aweyQvkhx70zeFWP8fzKM
   tXcZVbn7V6WVS4x195LNk97PpD5VRK0nuD0fuhnqWsqIv3C5+7lXcy+/3
   jDxG/41DP2yWNka2ftv20XeHOHTK/H7JxmD4C5E//xkDGOW84P2xl6he5
   A==;
X-CSE-ConnectionGUID: xgPG8+RvQem4YvrodoyOqQ==
X-CSE-MsgGUID: ijRRG5kjQ3aeulZVRGgqLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="64194126"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="64194126"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:44 -0700
X-CSE-ConnectionGUID: rbi9tavUSMOh371v/XWsQA==
X-CSE-MsgGUID: 6ST/TLHmQKiMFn0fLWSHsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="158616594"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO svinhufvud.fi.intel.com) ([10.245.244.244])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:41 -0700
Received: from svinhufvud.lan (localhost [IPv6:::1])
	by svinhufvud.fi.intel.com (Postfix) with ESMTP id A488744424;
	Fri,  4 Jul 2025 10:54:39 +0300 (EEST)
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Mark Greer <mgreer@animalcreek.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 50/80] nfc: trf7970a: Remove redundant pm_runtime_mark_last_busy() calls
Date: Fri,  4 Jul 2025 10:54:39 +0300
Message-Id: <20250704075439.3221036-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
pm_runtime_mark_last_busy().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
The cover letter of the set can be found here
<URL:https://lore.kernel.org/linux-pm/20250704075225.3212486-1-sakari.ailus@linux.intel.com>.

In brief, this patch depends on PM runtime patches adding marking the last
busy timestamp in autosuspend related functions. The patches are here, on
rc2:

        git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
                pm-runtime-6.17-rc1

 drivers/nfc/trf7970a.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index d17c701c7888..2d0d348aa278 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -1139,7 +1139,6 @@ static void trf7970a_switch_rf_off(struct trf7970a *trf)
 	trf->aborting = false;
 	trf->state = TRF7970A_ST_RF_OFF;
 
-	pm_runtime_mark_last_busy(trf->dev);
 	pm_runtime_put_autosuspend(trf->dev);
 }
 
-- 
2.39.5


