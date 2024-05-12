Return-Path: <linux-wireless+bounces-7515-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888A28C3506
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 06:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B80831C20B39
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 04:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DFE12E75;
	Sun, 12 May 2024 04:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nWe/gLII"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7AEFC11
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 04:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715488292; cv=none; b=VlXXxZ6YK9TsLyf2rxoZcojfCx7mB4Yz2AOng9KmZNiya0csS6jQvDstmLotRCVHVaVugg09g9SlYqchdqEJvMxNbsWlIvQ1rnZPVnGXfSHuJ2fMSjjdYGMw7kOdTovWU81/SBQ5wVUgr/RN6IYj5+d91XipQP1gBqiJtpO2ABY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715488292; c=relaxed/simple;
	bh=dm2eP8Pi01XSaQIgtcadxmgHnGVJlPiUU+rwoJYY7mQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=elutshTSNtGl6q5kKuRMOHWbtQerxYzj+QnNcOg3RwhateKhzoTbnNF+8md9S7Y7jJnU0phKN1U8J4QeFyPupt23NLMFqFfEZ0RHYZeQ4+8HXWs79cr4tm/9TBlNL/vQ1tWxaOcb91XtoicdyI8/Ge4xeYH0XVhxBMs4Bk9o7wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nWe/gLII; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715488291; x=1747024291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dm2eP8Pi01XSaQIgtcadxmgHnGVJlPiUU+rwoJYY7mQ=;
  b=nWe/gLII/V7FT9reL3tUVikM/LcRbTMzY63Gf3xHFePrjpdARxnep+jB
   k8APAHIPmdjvsDKVWlFyXnP1MEYt8YKwE8QQZMTyxZD0iReQCHHWKymr3
   xQ3C7BOunABBlhWRWol9CrmRynQuWvFRHQo/PxdCMuv/U84yMFgBR0CRW
   HUg7+YoFwDVQWxBsBcuMJkH8jpgC5JlwsPCgovGfrKQSJunSH7oG8myoC
   zbx0XaYJIyB+mexMaAl8kmefzOz7Vb7P0VJgx+CRYYrhi2wmlc4k5wZ4L
   qRCgsMiOxvjj1Mp759kK28y6Zj0Qh/20vEgrsPsGgH2jb+YRY5mAnWpsL
   A==;
X-CSE-ConnectionGUID: 1lh3qiyfSd2IhUxIIHIRLQ==
X-CSE-MsgGUID: 73GIKjgCQKelHOhGmM44gA==
X-IronPort-AV: E=McAfee;i="6600,9927,11070"; a="11323841"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11323841"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:31:30 -0700
X-CSE-ConnectionGUID: zNDaQqU6TLaCm7RQj34Kpw==
X-CSE-MsgGUID: +2vPv0agRkC1pchtzOs7NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="34532148"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:31:29 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 04/16] wifi: iwlwifi: bump FW API to 91 for BZ/SC devices
Date: Sun, 12 May 2024 07:30:58 +0300
Message-Id: <20240512072733.27c00099e8b7.I99b4f24bba073414dd04a6e04a359c7fbba52990@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240512043110.3413383-1-miriam.rachel.korenblit@intel.com>
References: <20240512043110.3413383-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Start supporting API version 91 for new devices.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index bc98b87cf2a1..45905e57e084 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_BZ_UCODE_API_MAX	90
+#define IWL_BZ_UCODE_API_MAX	91
 
 /* Lowest firmware API version supported */
 #define IWL_BZ_UCODE_API_MIN	80
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 9b79279fd76c..653279e08927 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_SC_UCODE_API_MAX	90
+#define IWL_SC_UCODE_API_MAX	91
 
 /* Lowest firmware API version supported */
 #define IWL_SC_UCODE_API_MIN	82
-- 
2.34.1


