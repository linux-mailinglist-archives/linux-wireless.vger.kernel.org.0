Return-Path: <linux-wireless+bounces-1387-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E8C821B87
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 13:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0A21C2111A
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 12:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EB3EED4;
	Tue,  2 Jan 2024 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c5CMMuua"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9979EECC
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jan 2024 12:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704198032; x=1735734032;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pFfq8yXlOdmse982gfIDBRvfrxB6HQ+tp32DEbA5e3s=;
  b=c5CMMuua1Av9Fgd/g72EH99UnoMom7TDAzuCBNez8gNoRospZciwcEgP
   k7crWv0IY/+4ae/T3ggH44j++mxmXmQYeClPCZU6Fc/8RUF/QRSTCDTA7
   lpIwvhOkJ2rcqZZ6aDd0kQbFQMJg/GlEAgMBSWMm57JtqxCbGDnMTYEzx
   hKKcVZZiMaDvLEiuiBEgW1fhHt60l/hShaN+faSRUssIhbB783b4xiUU4
   d/2KysAUIerogFJzmODGrqJfyT4i2oIUBug2/pBgZSRvA21BahMQcwGxU
   WLT/DxYKhiPTjet837ENLNs7+ifQmDgbrGQy2NJqFQX/UFBnBKFPq6MV0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="381832530"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="381832530"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 04:20:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="772831834"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="772831834"
Received: from lshechte-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.235.123])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 04:20:30 -0800
From: gregory.greenman@intel.com
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH] MAINTAINERS: remove myself as iwlwifi driver maintainer
Date: Tue,  2 Jan 2024 14:20:19 +0200
Message-Id: <20240102122019.1689602-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gregory Greenman <gregory.greenman@intel.com>

As I'm resigning from Intel, it's time to remove myself as a maintainer
of iwlwifi. Good luck to Miri!

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index dda78b4ce707..dbf0989da9a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10965,7 +10965,6 @@ S:	Supported
 F:	drivers/net/wireless/intel/iwlegacy/
 
 INTEL WIRELESS WIFI LINK (iwlwifi)
-M:	Gregory Greenman <gregory.greenman@intel.com>
 M:	Miri Korenblit <miriam.rachel.korenblit@intel.com>
 L:	linux-wireless@vger.kernel.org
 S:	Supported
-- 
2.38.1


