Return-Path: <linux-wireless+bounces-18918-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE81A340B5
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 14:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C38DE7A4A39
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 13:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963FD213233;
	Thu, 13 Feb 2025 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TlsqAbci"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4481B227EAE
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 13:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739454325; cv=none; b=jj0dqJD4mZ2q1b9SGxq46X+/gbiDxBo7uGFRWC8smiKnRKx46W/Lt5b3oimkupa4k02fzRTanAlY7J3/uxI7gU2SskASQGHRtow+IU6ZrqQwaByTfLAWIwv1G/PAF+ioBpWfZtdpImOtuL+aJpw6EJTxkutxXALxGarkUWEj5BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739454325; c=relaxed/simple;
	bh=G26gZAp8vQrjQXoyEY74nTIBCXh9jZuCZI1ejdGjVYs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nPnnTbp8W4SHdlubxoWQsKbAa7OrYQyXl7ekxejDwvJdIJg6MlKl1KM2mf6NDLVpSlaMexoSJ+2KYU76uQ6YLZEEUrEY1t5l8SqAGaD4VoKDL5ckJEI6HKlPd48n3LrHorym3vSBY5+ZENg2Pxdr960JfT1opGcyMagZrPKg7u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TlsqAbci; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739454324; x=1770990324;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=G26gZAp8vQrjQXoyEY74nTIBCXh9jZuCZI1ejdGjVYs=;
  b=TlsqAbciv5l91XnDrmeGah8MXJc43WLvxJTAk38dWrDLQqxU688nOtXH
   okMRVJ+LqZSD0wsMBL00wCUa4Z4pjoq8bgGn7V+cDTZQULHrWWZuUbUAY
   R75atbJLi3OkuBqGmK29/Ha4HgcYPCUSddzFts/De3fED5gbz2z22L1wR
   wMEqBmCU7KZurHN+XxPwFy26XnyaDEsI+/zi5T/i52DBuw/eSr9fpqaNv
   SIPv0rXAIK+r0ovThwaoG5a5HhvwqveM+cThBajDJNiLxcU3SCgU92UM5
   pcfMbHJipctdb2WtjcFOT04FTqfdVjUxMNEZ2Y3ZdtSfUDdhJ+5QxSktt
   Q==;
X-CSE-ConnectionGUID: TxlCyHysSFKv39l8n64WMA==
X-CSE-MsgGUID: 5hVkyiPSQBK2RdHDrx4CEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="43805508"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="43805508"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:45:23 -0800
X-CSE-ConnectionGUID: 3uEVSvpLQkO1gclBcjhFJQ==
X-CSE-MsgGUID: RGcxz4wHSZ+AsP6pSqC2DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="118234162"
Received: from weis0041.iil.intel.com ([10.12.217.187])
  by fmviesa004.fm.intel.com with ESMTP; 13 Feb 2025 05:45:21 -0800
From: Ilan Peer <ilan.peer@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] wifi: mac80211: Fix possible integer promotion issue
Date: Fri, 14 Feb 2025 09:47:21 +0200
Message-Id: <20250214074721.1613549-1-ilan.peer@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a possible integer promotion issue in mac80211 in ieee80211_ml_epcs()

Fixes: de86c5f60839 ("wifi: mac80211: Add support for EPCS configuration")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
---
 net/mac80211/mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 4e8f0a5f6251..23d85a1abbc5 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -10704,7 +10704,7 @@ static void ieee80211_ml_epcs(struct ieee80211_sub_if_data *sdata,
 						  elems->ml_epcs_len,
 						  scratch, scratch_len,
 						  IEEE80211_MLE_SUBELEM_FRAGMENT);
-		if (len < sizeof(control))
+		if (len < (ssize_t)sizeof(control))
 			continue;
 
 		pos = scratch + sizeof(control);
-- 
2.34.1


