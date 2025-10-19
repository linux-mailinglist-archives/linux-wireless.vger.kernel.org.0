Return-Path: <linux-wireless+bounces-28070-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095E7BEE104
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 10:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF6A63E38C2
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 08:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428C529E117;
	Sun, 19 Oct 2025 08:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bcF6wrfk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74A52BE7A3
	for <linux-wireless@vger.kernel.org>; Sun, 19 Oct 2025 08:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760863554; cv=none; b=XJjGiufQKTge79Qwasck8RK2SS9FNw/Sv9mHm8igJRPUoFK7UOlD60UrX6JuXfWPqi3MyPwf08hIiV0fEZMyfyU/nxyK6HffjZy+lSmYs5TyRpAre9KbopbxMQH23kjzUEJGdc4Js58mzMsNXAaokH2DvzoICbKUjzai8GMuTGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760863554; c=relaxed/simple;
	bh=tdRgx7C20EdtRGfpVQ7zCy5LYDozafL1BZqaUCSDk38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e7U7I0AOyCiPDzXvOu0E9nhwv/nXaV35nDp9f7+ZEa0iyxH4YMnSgGSfMEaOlLS6avzberC3shNghbMXmbQ2Y+F17jOfnUj35yhyx4QPkG/t6tAl36glDPfw7ARxOBdGGf+FlMruHpYX5RHjR8DzLcH6tZjsQWOcLxHJNyFeYlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bcF6wrfk; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760863553; x=1792399553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tdRgx7C20EdtRGfpVQ7zCy5LYDozafL1BZqaUCSDk38=;
  b=bcF6wrfkwTbdgWxzuWXecdIEJM7tuiWRmBZKP3yN3V4UYT7BOzYUEzlO
   t6vZwcZD8DcTmMvSGi1vvojJbX3e44yQtri5LRMb7FAnCUB8mcZdKd5jY
   rGdmkQ4jk6ncdcTDFEc2rtd+CAnWTPSyKFHcL1tj6VgNQopoERQB4G8aO
   Uba/6U5SOAvqC+f70saCTLwgzb5S/TWhqGCC2L1T3YzJpKKgCPhp8TCBv
   sF42TlRie/fHejCXvu/w+HrhHy1Mj9gZwF9mvwY2dP8kJfg2fo0+iEMT+
   KwHbbhbskS6L4ffnmPel/wgGNXvCeyhyctDWd/lZ67msd/PgMYo3BWiEn
   g==;
X-CSE-ConnectionGUID: V7k3kBS4SaqFd6zt5eWrKA==
X-CSE-MsgGUID: SEbvjp2ySXeSEcTaAlwtYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74363196"
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="74363196"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:45:52 -0700
X-CSE-ConnectionGUID: sbXbrC8OR96pFHyBwvkp3Q==
X-CSE-MsgGUID: 7hxAYlGKSmKzn8m91V/VAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="182279916"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:45:51 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: mld: check for NULL pointer after kmalloc
Date: Sun, 19 Oct 2025 11:45:16 +0300
Message-Id: <20251019114304.d1f958160c5a.Icc891c14c633c3b8625372680fdc67ca33c83cc7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019084516.2568208-1-miriam.rachel.korenblit@intel.com>
References: <20251019084516.2568208-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Coverity complained that we didn't add a NULL check for the link we
allocate.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/link.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index deb1e7227dd8..27ae8bd6f407 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -465,10 +465,13 @@ int iwl_mld_add_link(struct iwl_mld *mld,
 	int ret;
 
 	if (!link) {
-		if (is_deflink)
+		if (is_deflink) {
 			link = &mld_vif->deflink;
-		else
+		} else {
 			link = kzalloc(sizeof(*link), GFP_KERNEL);
+			if (!link)
+				return -ENOMEM;
+		}
 	} else {
 		WARN_ON(!mld->fw_status.in_hw_restart);
 	}
-- 
2.34.1


