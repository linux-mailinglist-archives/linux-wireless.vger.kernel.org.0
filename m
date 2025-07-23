Return-Path: <linux-wireless+bounces-25908-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E9FB0EB15
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 08:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72CFB4E5429
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 06:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C32E251792;
	Wed, 23 Jul 2025 06:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AbSo3cCG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABEC254858;
	Wed, 23 Jul 2025 06:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753253879; cv=none; b=JSnQZNRtl+YLl/msmt0J0jrE8zHtMrQW67xBuCGIRJY9eRHnKLPBJI4pN6DWhthWo+hrBEcx6ZPA+6MK317GtYGAYyCjt7U26/YQzh9Jsjw+LkKAPdffkRq9W577xzL5XOZO09UKDNBjv0+5YE7zldsJWi9O2m25i+9PFxMCJhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753253879; c=relaxed/simple;
	bh=nDM2MDq1GeOPZXLi7Azq4cQbqW4GFXcnWwvo6fbOkls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cQFMFi0KeVLmQp3Gcn0sr3TaIMysx4Zkb72VkbUNwi1hqJsi6t8eyhh+JMhXLIOs8tdzyMmZsRZoT8gxXnRl/Jg+ymOf9Sj2bO7X+IOJNrgkaFmigFfWu3ZWjdw04tM99rI1MKiq6u+sVyQ/vdwQAEX2VXCcR9t3utsYBR1D5dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AbSo3cCG; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753253872; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=jhYdClhAP8JwILVZ0Wy3XCaYp/MbCM3I3Yu6QS8tLQo=;
	b=AbSo3cCGzXD+zbQtyoAcngHxblxmu48knl2mzE3emWL1qs2VlCFPMtb/tDcx1foRBmztAv4RVOtqRnt4tyep0v+/6EWCmpD9b/SKQ+SrDSHVRsGb34C85PXNwxejOGB5MKq8EQiX+H161Vyp5fEXJvgsPr91GIJ4xZds0StHZ+0=
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Wjb4fPq_1753253871 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 23 Jul 2025 14:57:52 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: riam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] wifi: iwlwifi: Remove duplicated include in trans.c
Date: Wed, 23 Jul 2025 14:57:50 +0800
Message-ID: <20250723065750.2187628-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header files fw/api/tx.h is included twice in gen1_2/trans.c,
so one inclusion of each can be removed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=22932
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 327366bf87de..49237ffe8c88 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -25,7 +25,6 @@
 #include "fw/dbg.h"
 #include "fw/api/tx.h"
 #include "fw/acpi.h"
-#include "fw/api/tx.h"
 #include "mei/iwl-mei.h"
 #include "internal.h"
 #include "iwl-fh.h"
-- 
2.43.5


