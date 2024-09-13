Return-Path: <linux-wireless+bounces-12819-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A760977630
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 02:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9DF1C24344
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 00:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781CF1373;
	Fri, 13 Sep 2024 00:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NZ/wcpvm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B991FA5;
	Fri, 13 Sep 2024 00:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726188292; cv=none; b=qYAm5XblrgVB+e3N/eino1ZJYygpXouHf4+yXPqjdb4Io/dF9UB/sf2lZw1vuO5Wo+Mj8GUAYrdKmIItQ3pUykdKnFmN4Oc8Q7JZOul3CTKBCdYMhHM395Lsm5lT+JQT06wwxYS1y5MtocYNLuJAILC9J09nQ8hiF8mNFV0KKQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726188292; c=relaxed/simple;
	bh=1Ch0jjyf5x6nSU2AeJM+N0zEUfNXJjTCfAW/HICyh7g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tytLMDKz6sKDG7iWTcm5E/Dl8YveuoAV9ptpkwK/Z4JwZGKXcmtKRvMJdu5J5jUHVSGtz0t0fB3PjqPQ7ljYWWeyXd3lA5G4kvRylchPFLPqq6NQTJKPP6MQ+v+KU5XydU57cNVXw89Tjige7ETPmUF6wJnXJJsPmhw3bNZVUzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NZ/wcpvm; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726188280; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=7iTqFP/J3HQR+eE9IaYc8M8SgxVo/tnTpTHFZ/Ei8pI=;
	b=NZ/wcpvmQDW66ziHWfRHH4Zf5zhSWazuiGjIg93HssbE9X/Qe/+Dr4onlJY/v7P9P8xs/cFykdpOSjGYxieincpRCkT77M4Z9m83xGWhham8ZXWeAzvsgYes2ydBQE6OdiCgvaoKFE54yhGtHUyhU1n4tRru0Z/EnTYPysYKlOs=
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0WEsaR-l_1726188279)
          by smtp.aliyun-inc.com;
          Fri, 13 Sep 2024 08:44:40 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: kvalo@kernel.org,
	miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] wifi: iwlwifi: Remove duplicated include in regulatory.h
Date: Fri, 13 Sep 2024 08:44:38 +0800
Message-Id: <20240913004438.93767-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header files img.h is included twice in regulatory.h,
so one inclusion of each can be removed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=10844
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index 81787501d4a4..11704163876b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -12,7 +12,6 @@
 #include "fw/api/phy.h"
 #include "fw/api/config.h"
 #include "fw/api/nvm-reg.h"
-#include "fw/img.h"
 #include "iwl-trans.h"
 
 #define BIOS_SAR_MAX_PROFILE_NUM	4
-- 
2.32.0.3.g01195cf9f


