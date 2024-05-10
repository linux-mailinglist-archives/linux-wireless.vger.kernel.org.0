Return-Path: <linux-wireless+bounces-7466-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DA78C265E
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 16:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFC6AB2476A
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 14:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B953C171647;
	Fri, 10 May 2024 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VydY1lwh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2A217165F
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 14:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350025; cv=none; b=a+KQthJ3gXftnQE/ZyXZ5XW6Qusbj8+TWPdzMtwvGo8FYJdkJX/BcxzXihnQcPI+NRdZ+1GX5brgUR/xWglR93weh1sQUBPf1vLX1RE9TGpg7VQQW39okkQV4kdOMn+H5im6dqgwohBeXqxCSifmztR3eh401pT7m8cNyMgwU2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350025; c=relaxed/simple;
	bh=CQlKQPxOfp8/xPapgHY+mhPBxqVn4qT97bD/6KDVCns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bbvYemM1qHlBNywvOWNVg6gscGRv4FGk0e4mIunMbz43KhboTl1viShxE47gZVv3sl3so7I6+aeBOG1wMa8Y00uzk8k54BU1QWDOteXll8hORG+3WOrwjIW4aVt3NVYuOdpS5VvnqjNIVGzXyBXGRO2og4RnIR5og0QomsS5Res=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VydY1lwh; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715350024; x=1746886024;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CQlKQPxOfp8/xPapgHY+mhPBxqVn4qT97bD/6KDVCns=;
  b=VydY1lwhDTiIz5sXp2yjyfBczbD2NTEHmzmzEp3aRRM5wOvK7P+bZVug
   iNM+9a2KM/Nx5ngnk+oDoftfCdzOJbwqmaM+T/tdNPHD2k4dqq81yte0D
   qNzfjd6xlP9+p4VQ/s4JnGSLGEM+DoNfbgGcZ3JjgIBnpLlwWGinhI3C8
   Xe7Czr5HjS342j8hBUKcWbmH/3ho6xlS5zzCpzISTToQRItQBBO+2rEuA
   gxW6pYezl7Aeaq6z4eyslfwvHnmmcrvJ1Kir89y+3g9Tgmap4nQZhTS+n
   AFnICLfqKqXrSc1B6+/Gouw3UYAf6HQvxfZKSxETaYtBxEYE3YW4z2OfV
   A==;
X-CSE-ConnectionGUID: m5J15w/5QNOqEbSJgCXqIw==
X-CSE-MsgGUID: ASpawjAgSyyoLn67e1vYIw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15125561"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="15125561"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:07:04 -0700
X-CSE-ConnectionGUID: WY5n7HKuSS+Zl79bACDHng==
X-CSE-MsgGUID: tqk7X3pDQ7qMls0XMibFlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="67101865"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:07:02 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>, Kaufman@web.codeaurora.org,
	Liad <liad.kaufman@intel.com>, Coelho@web.codeaurora.org,
	Luciano <luciano.coelho@intel.com>
Subject: [PATCH 06/14] iwlwifi: mvm: revert gen2 TX A-MPDU size to 64
Date: Fri, 10 May 2024 17:06:33 +0300
Message-Id: <20240510170500.52f7b4cf83aa.If47e43adddf7fe250ed7f5571fbb35d8221c7c47@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510140641.1895860-1-miriam.rachel.korenblit@intel.com>
References: <20240510140641.1895860-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We don't actually support >64 even for HE devices, so revert
back to 64. This fixes an issue where the session is refused
because the queue is configured differently from the actual
session later.

Fixes: 514c30696fbc ("iwlwifi: add support for IEEE802.11ax")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Kaufman, Liad <liad.kaufman@intel.com>
Reviewed-by: Coelho, Luciano <luciano.coelho@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
index 376b23b409dc..6cd4ec4d8f34 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
@@ -122,13 +122,8 @@ enum {
 
 #define LINK_QUAL_AGG_FRAME_LIMIT_DEF	(63)
 #define LINK_QUAL_AGG_FRAME_LIMIT_MAX	(63)
-/*
- * FIXME - various places in firmware API still use u8,
- * e.g. LQ command and SCD config command.
- * This should be 256 instead.
- */
-#define LINK_QUAL_AGG_FRAME_LIMIT_GEN2_DEF	(255)
-#define LINK_QUAL_AGG_FRAME_LIMIT_GEN2_MAX	(255)
+#define LINK_QUAL_AGG_FRAME_LIMIT_GEN2_DEF	(64)
+#define LINK_QUAL_AGG_FRAME_LIMIT_GEN2_MAX	(64)
 #define LINK_QUAL_AGG_FRAME_LIMIT_MIN	(0)
 
 #define LQ_SIZE		2	/* 2 mode tables:  "Active" and "Search" */
-- 
2.34.1


