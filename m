Return-Path: <linux-wireless+bounces-14362-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CCA9ABF57
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 08:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E71F1C20A26
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 06:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7707B22318;
	Wed, 23 Oct 2024 06:52:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375851482E6
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 06:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729666361; cv=none; b=WDYkvfvz549D6cTNZDypglT8CngVLQvLf2UyVn8rX1u8/8yFsmUi2Y9IxSrxkbzPjj2+F51C1lHYhw6gsBuYcVJR/2HCC+EJm+wb/kXL7YEoMTok2zn9+R4WLfG6fNXiBpApD8+OFvGXGA4Fgq/4vNwha1PwvhPcMjUOao4FYIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729666361; c=relaxed/simple;
	bh=sCpiTA6TM/c3NbvwRGlAMkgJDKwdwlbBED/Bp1NsRbo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CynBoOYOzDnCChZfQbPdqYurcsStJ3d9ymLHrWkKt3RL7GEhjV27aui+9eJzXBKFoXluPyZceC3x/oIPOJ0iSLvbJ/uFn28DyRM5Ggz39MflfL/P05Mee/DP5qb3bmqlbu4PISxy4rO4sqN88B/Cc1uO0KxbsqGM+ZPyL0cdaXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XYKSC0l0jz10Nxl;
	Wed, 23 Oct 2024 14:50:35 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id D13C3140134;
	Wed, 23 Oct 2024 14:52:36 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 23 Oct 2024 14:52:36 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>, Kalle Valo
	<kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] iwlwifi: mei: fix return value check in iwl_mei_dbgfs_register()
Date: Wed, 23 Oct 2024 14:52:20 +0800
Message-ID: <20241023065220.258-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf100006.china.huawei.com (7.185.36.228)

Fix the incorrect return value check for debugfs_create_dir(), which
returns ERR_PTR(-ERROR) instead of NULL when it fails.

Fixes: 4ea7da5fad43 ("iwlwifi: mei: add debugfs hooks")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
index dce0b7cf7b265c6..17a08ecd11b3202 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -1921,8 +1921,7 @@ static const struct file_operations iwl_mei_dbgfs_req_ownership_ops = {
 static void iwl_mei_dbgfs_register(struct iwl_mei *mei)
 {
 	mei->dbgfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
-
-	if (!mei->dbgfs_dir)
+	if (IS_ERR(mei->dbgfs_dir))
 		return;
 
 	debugfs_create_ulong("status", S_IRUSR,
-- 
2.34.1


