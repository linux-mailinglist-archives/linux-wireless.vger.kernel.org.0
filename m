Return-Path: <linux-wireless+bounces-12221-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933A496547D
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 03:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 505E42854C6
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 01:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC3C7F6;
	Fri, 30 Aug 2024 01:10:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED177125D5
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 01:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724980251; cv=none; b=uHRpb2DAymnW7tLAam8jRPVP97Rqf4Z4UCLu9Rfj60/Mp//t4stBdoLJj/BDoj55B/NPMl1f4nXBbeCjwv6OTbNw0sDBCsqV817gy0lhWlEF3poTf/cZxF+0La4POODkq1p0hZYZS0WjRZJ2/1pBXlajiqknSYy1RZzo8xUUaHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724980251; c=relaxed/simple;
	bh=pi20ADWuwgRbMRRF4/YhbHG+lVHy3Fk05Lttep704mY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JrJJG1cPrcEqQo+5XVenswThpaR2Fw1pW+geb6uxZro8Y0s4UylO5+6+Tvnmxaum5Vce2m1t1TY0L8q5Q4zEzF2fChn/JKk4uQ/doF4zb9/t6MwIirOSZECk8ravq6enf/Jz5bHj+/JQZq1ulJOgMQ7/k3imK/qD6rjmLGNGtUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Ww0S34L36z18MwQ;
	Fri, 30 Aug 2024 09:09:55 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id DA9E718010A;
	Fri, 30 Aug 2024 09:10:45 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 30 Aug
 2024 09:10:45 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <toke@toke.dk>, <kvalo@kernel.org>
CC: <lizetao1@huawei.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH -next] ath9k: use clamp() in ar9003_aic_cal_post_process()
Date: Fri, 30 Aug 2024 09:18:58 +0800
Message-ID: <20240830011858.603514-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd500012.china.huawei.com (7.221.188.25)

When it needs to get a value within a certain interval, using clamp()
makes the code easier to understand than min(max()).

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/net/wireless/ath/ath9k/ar9003_aic.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9003_aic.c b/drivers/net/wireless/ath/ath9k/ar9003_aic.c
index d0f1e8bcc846..45a7ca660f47 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_aic.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_aic.c
@@ -409,13 +409,11 @@ static bool ar9003_aic_cal_post_process(struct ath_hw *ah)
 		sram.valid = true;
 
 		sram.rot_dir_att_db =
-			min(max(rot_dir_path_att_db,
-				(int16_t)ATH_AIC_MIN_ROT_DIR_ATT_DB),
-			    ATH_AIC_MAX_ROT_DIR_ATT_DB);
+			clamp(rot_dir_path_att_db, (int16_t)ATH_AIC_MIN_ROT_DIR_ATT_DB,
+			      ATH_AIC_MAX_ROT_DIR_ATT_DB);
 		sram.rot_quad_att_db =
-			min(max(rot_quad_path_att_db,
-				(int16_t)ATH_AIC_MIN_ROT_QUAD_ATT_DB),
-			    ATH_AIC_MAX_ROT_QUAD_ATT_DB);
+			clamp(rot_quad_path_att_db, (int16_t)ATH_AIC_MIN_ROT_QUAD_ATT_DB,
+			      ATH_AIC_MAX_ROT_QUAD_ATT_DB);
 
 		aic->aic_sram[i] = (SM(sram.vga_dir_sign,
 				       AR_PHY_AIC_SRAM_VGA_DIR_SIGN) |
-- 
2.34.1


