Return-Path: <linux-wireless+bounces-3103-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C188490F7
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 23:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8E761F228FD
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 22:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD3B32C92;
	Sun,  4 Feb 2024 22:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nvM5Gj5d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921532208A
	for <linux-wireless@vger.kernel.org>; Sun,  4 Feb 2024 22:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707084396; cv=none; b=AsnQf031ZKajNzlX2Bl+o7kJEvNm36SWzyLGWF4JNhJC11p3mLyA3Yj0jkx28WDbj04JQMz5xwQK5J8ILfWRdhNdvV5MUBtT0WtswZDixnOEBDZQPOvYYUJL3wJZrv+62gzHgaU5K0aGT1em8K9Z0RqJRoIm5YeVkXLdu40XIM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707084396; c=relaxed/simple;
	bh=K2OcCDzA/7p8Jlw81Aq+XFUcY3rJShkvV5/zn3P9lbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fXUxVfXuG8+ky+TeH/T2p1wWHfX9QwXnXXIlUciz4nY7chguJBbO+WchXcSW5etlwZJSg3gktvqfYnEA/MIpjTAtoTuKR0bsxWBu+p0VwRfeyVix2CRqXupes3WidrEt779WjiBk8sbzx9fIoaurorwpUZ3D7SFRfusBsiYSeJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nvM5Gj5d; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707084395; x=1738620395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K2OcCDzA/7p8Jlw81Aq+XFUcY3rJShkvV5/zn3P9lbg=;
  b=nvM5Gj5daVr0yXmIs/2rXuuVd724Bv7KDsovsujGo66iTyoJ+IquBidY
   hz36kVNRMXDcxr66oVvFdQLzTfPF5U820755LGrry+NfW+g7iYyZ3SPv0
   ios/9bixdS6Me1Dxp11GvSOZR0G2D9mSXk+ZG3PbekQVzuRoMtpijYbr5
   ZtXP7osUVvjIDPBQvPQjAup4DH5hJv1EsPC2RcZJ1uYDMQ4nvbBcrnz8J
   vgr9OLE06FN/zLAtRQO0KmJ8E5I6yUwVVVAg9wQ5JdNEFkxvdm1UngdXU
   2zW3oRcrJqUWPlF6TjyzzM39JHXr0LIf58fl9pE1vaoZwBoqGaTExJZ6G
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="25869366"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="25869366"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 14:06:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="23815849"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 14:06:33 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 02/15] wifi: iwlwifi: add HONOR to PPAG approved list
Date: Mon,  5 Feb 2024 00:06:04 +0200
Message-Id: <20240204235836.3498abc62910.I156c34206c58ff26e73f705cbda6f1a49b88edda@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204220617.1456895-1-miriam.rachel.korenblit@intel.com>
References: <20240204220617.1456895-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Add HONOR to the list of the OEMs that are allowed to use
the PPAG feature

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 21b90278d1f2..597735a660a2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -94,6 +94,11 @@ static const struct dmi_system_id dmi_ppag_approved_list[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Razer"),
 		},
 	},
+	{ .ident = "Honor",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),
+		},
+	},
 	{}
 };
 
-- 
2.34.1


