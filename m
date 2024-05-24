Return-Path: <linux-wireless+bounces-8040-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7688CE1E2
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2024 09:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7811F227F0
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2024 07:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C1282892;
	Fri, 24 May 2024 07:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZJXtNVAI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D5B83CAE;
	Fri, 24 May 2024 07:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716537525; cv=none; b=nV8NyVvJBUm7ZUHuHFvlxbnRfqN5flK1UoYvQwCLBVmG/2XXgRPRcr11jG7ZEi/KZYwx/a86nEGvhe64p6DFc1bCfrhtOIWPLescUtAXS0MQ2wCY4UAp3mzGM0000POe2qhmsxNjnzJf/IkyghcGV7DCpEUqqFcp86IObFjCXVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716537525; c=relaxed/simple;
	bh=bqyPMRt9wz028/U8fejcJ/EaS7Tt7i+3cUm/fCpxTb4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rwmoR5CHGskT4/QOZTBF3ttj5cSGvGoeFkFRCu2ovBgjvIK4n7DjCQO5CDHdQ7cooB+5OTefi9wzcNeo3PZQAF0Qt3AYE/v7QXGpLRzp1W8db97134aORueUmbX+NqYZRMoin73rsWiNLva2X0Eh9zTWKvfQqb1moyuRV88VPkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZJXtNVAI; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716537515; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=07/n6HPUGsrYONlCxyGegVdPDEuAAjDjEBGbwCI4jeE=;
	b=ZJXtNVAIrEEXn4AWb8v3kCsGxVKYn1ezqcsNc5chOciWmdn1okKrDOLWYoeRFJnvCjTraShAMU31TFS/zL5Y0+pcPzukIavIj90TDxySm1fRxhAAGbNN4vR7cRna6OwNj3hijQPWRVgIgQcs8TtZVgJ7+FvlamRJ6HIGAfxYiSQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W75y.OR_1716537505;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W75y.OR_1716537505)
          by smtp.aliyun-inc.com;
          Fri, 24 May 2024 15:58:34 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: pkshih@realtek.com
Cc: kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] wifi: rtw89: chan: Use swap() instead of open coding it
Date: Fri, 24 May 2024 15:58:19 +0800
Message-Id: <20240524075819.2789-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Swap is a function interface that provides exchange function. To avoid
code duplication, we can use swap function.

./drivers/net/wireless/realtek/rtw89/chan.c:2336:32-33: WARNING opportunity for swap().

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9174
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 051a3cad6101..3b1997223cc5 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -2322,7 +2322,6 @@ static void rtw89_swap_sub_entity(struct rtw89_dev *rtwdev,
 				  enum rtw89_sub_entity_idx idx2)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
-	struct rtw89_sub_entity tmp;
 	struct rtw89_vif *rtwvif;
 	u8 cur;
 
@@ -2332,9 +2331,7 @@ static void rtw89_swap_sub_entity(struct rtw89_dev *rtwdev,
 	hal->sub[idx1].cfg->idx = idx2;
 	hal->sub[idx2].cfg->idx = idx1;
 
-	tmp = hal->sub[idx1];
-	hal->sub[idx1] = hal->sub[idx2];
-	hal->sub[idx2] = tmp;
+	swap(hal->sub[idx1], hal->sub[idx2]);
 
 	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
 		if (!rtwvif->chanctx_assigned)
-- 
2.20.1.7.g153144c


