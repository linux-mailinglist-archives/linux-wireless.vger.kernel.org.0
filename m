Return-Path: <linux-wireless+bounces-25909-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3369FB0EB42
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 09:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B7C77AB581
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 07:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E23112FF6F;
	Wed, 23 Jul 2025 07:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Vmam1suN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BFD2AF0A;
	Wed, 23 Jul 2025 07:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753254335; cv=none; b=MRIes9mX4RMHlarR3Ph0kKFvxQ9Rfo/jFdApyDSttKjlvZhQ5KF6QnxYewsPljc0HtY1NYg7w9cy5ISKMb7zninRBdhko9BWs/SqSm0E7t6ClDIxn8hULx20YCv3ifYRb03GAfrBKwhW1zEmU7rSHm4K60dE8jgCiObUmi54+Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753254335; c=relaxed/simple;
	bh=nDM2MDq1GeOPZXLi7Azq4cQbqW4GFXcnWwvo6fbOkls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d5xyVuub7GOF3aQWce5Dr5M87mq241YkDFTUkZOnGUQGMBBZpzDMfMs3YC0ZB1pL0EuSCOyrtWh+YIMc4/GQ6wAvyPyEeZMfSZn42Q22sgD7zLVBN9bQ6MZjvdmLcmMU+M1UOuFfCGgI3NQOUS8cB/38nTMmJCyS5GF7nCY5OXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Vmam1suN; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753254325; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=jhYdClhAP8JwILVZ0Wy3XCaYp/MbCM3I3Yu6QS8tLQo=;
	b=Vmam1suNA1i6q27mfOH6Dz6tH1NgCqZwNxlUyxr0Li2pNHznHgdUdRbKkNSmGVPcgJWGHmMV5uzglRAYhduU5PiU51Yl0fvPydwlNyr5532AuTvJZuqq792eO5r4Frxzsmi1P2LXOxEXwtjTJ1FDAWcz3vRzOpCt180OB11/t+g=
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Wjb1LOK_1753254324 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 23 Jul 2025 15:05:24 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] wifi: iwlwifi: Remove duplicated include in trans.c
Date: Wed, 23 Jul 2025 15:05:22 +0800
Message-ID: <20250723070522.2195817-1-yang.lee@linux.alibaba.com>
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


