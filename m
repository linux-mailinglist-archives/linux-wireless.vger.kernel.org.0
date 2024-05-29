Return-Path: <linux-wireless+bounces-8242-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDB38D2A85
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 04:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 051D62895A0
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 02:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C275315AAD6;
	Wed, 29 May 2024 02:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sW/ywED9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B3415AD99;
	Wed, 29 May 2024 02:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716948183; cv=none; b=VUoZipdTgPnzQQUlZUR8eNCTlugPf9BhqAVNiw8W/5zrhC09m1LlCpg7esd7HWa2ioSjOQTRRKyLwTzrF5EJb/ZFNiCUQ5+EqrkNtoSE0cE+dFdMlp09K7bJA4Wk2vt3GnnO05l1QPAC9p/GpziqkgyOXxyHnKrYMUkj8HQ150g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716948183; c=relaxed/simple;
	bh=O79keix28rmAHBpO1tmH+HkKuIfiwhKx1JCWllxFRxc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yc7XJOLvUOQTmU7Olr096choVx449y1mgS1yxVk3b4PAE+gDfxtd9zZlExoVuBEIXMNsnJa8QR43fN8mqUENwyvpaYSfK7tIXUmJq3KrwgKNTsMHMwzGj15r77anYuIdnxhft078sS32Upvlvuw4pXhSksm3YsRpiygmPD4i4cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sW/ywED9; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716948178; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=wlYFxgSPBB8GHLCmZnRucL7d7MzOWuLmNUc70TG55TY=;
	b=sW/ywED9AgTrF9CCg554+e14AypJHxFo9AJ2rIcMhd3M4pZbXBXS2L20qIk7xesKiwyQMlVkpnFYDuwEcIbW5a3o8oaazaPfMeOJLUZWa97Ki+0cUdu9CieF1K3MIv5Yh0NxK7W9bObD+ZqvEcg+1K35SxU56sXVKBQrxKyLGBY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W7R4YvH_1716948165;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W7R4YvH_1716948165)
          by smtp.aliyun-inc.com;
          Wed, 29 May 2024 10:02:58 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: pkshih@realtek.com
Cc: kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH v2] wifi: rtw89: chan: Use swap() in rtw89_swap_sub_entity()
Date: Wed, 29 May 2024 10:02:44 +0800
Message-Id: <20240529020244.129027-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use existing swap() function instead of keeping duplicate source code.

./drivers/net/wireless/realtek/rtw89/chan.c:2336:32-33: WARNING opportunity for swap().

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9174
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  -Amend commit message to make it more clearer.

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


