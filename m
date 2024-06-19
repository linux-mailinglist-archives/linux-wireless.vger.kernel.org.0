Return-Path: <linux-wireless+bounces-9219-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D9990E1A5
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 04:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59CD2850B2
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 02:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246132E419;
	Wed, 19 Jun 2024 02:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eMMMfj//"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FC6262BD;
	Wed, 19 Jun 2024 02:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718764839; cv=none; b=JXCjSNDxyrAFIRou8/+YB4+VU3P2V9ps+msfUMoSpQs+EPiRzHfgIJCxGGsqXwQA8Kuq1KUjUJSYKL8escJsBNBLMgG3fSAWGd3f8qlZ+xbn5tiYCt6EJK0zcbbpM2tob5ti8KkB69G8LMmGhfEJxqozjiTU7d3zy4RZOLko044=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718764839; c=relaxed/simple;
	bh=ScNTUNA/gyMWCLkcfoLH3Uh5XxusWPUNZjJaVGcXNeE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G0xTiBj0ql2fnus8pO0upRNctiKgBaFG67WZV5Gbq2sJkxSbeX74ftZeiFiN1AqNCU95Ie8ja9nTnnfbANv/e7Z31oW1i0QWh7NOBLa56NAmKmlSS3YrpirFpmppVKzLu/o6ynqFdpcMuW+sIgwJPtG12KcN5WSO5IVVDn38+44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eMMMfj//; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718764833; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=wp3lyWCxytDgnatAYvDE9fze41K/wXoXo0yZ07obUdw=;
	b=eMMMfj//7wn+va8nsj6HS6hI51D3ee56au+7ILsG98TjNyUSWJC0jSyT0p1yZWdqpxXOtpA7tkkK8inRUhRQAY3JtxkXLWwuslcHOt9SCl/buWkXB11SLOzUmNCW35FrftdMJZB3VM+w+wkGpdkomvJc8JT7f3RH3mnMkmmo4dc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W8lgZiE_1718764818;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W8lgZiE_1718764818)
          by smtp.aliyun-inc.com;
          Wed, 19 Jun 2024 10:40:33 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: Jes.Sorensen@gmail.com
Cc: kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] wifi: rtl8xxxu: use swap() in rtl8xxxu_switch_ports()
Date: Wed, 19 Jun 2024 10:40:17 +0800
Message-Id: <20240619024017.53246-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use existing swap() function rather than duplicating its implementation.

./drivers/net/wireless/realtek/rtl8xxxu/core.c:6749:30-31: WARNING opportunity for swap().

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9358
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 89a841b4e8d5..e19fd31edfda 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -6679,7 +6679,6 @@ static void rtl8xxxu_switch_ports(struct rtl8xxxu_priv *priv)
 	u8 macid[ETH_ALEN], bssid[ETH_ALEN], macid_1[ETH_ALEN], bssid_1[ETH_ALEN];
 	u8 msr, bcn_ctrl, bcn_ctrl_1, atimwnd[2], atimwnd_1[2];
 	struct rtl8xxxu_vif *rtlvif;
-	struct ieee80211_vif *vif;
 	u8 tsftr[8], tsftr_1[8];
 	int i;
 
@@ -6744,10 +6743,7 @@ static void rtl8xxxu_switch_ports(struct rtl8xxxu_priv *priv)
 	/* write bcn ctl */
 	rtl8xxxu_write8(priv, REG_BEACON_CTRL, bcn_ctrl_1);
 	rtl8xxxu_write8(priv, REG_BEACON_CTRL_1, bcn_ctrl);
-
-	vif = priv->vifs[0];
-	priv->vifs[0] = priv->vifs[1];
-	priv->vifs[1] = vif;
+	swap(priv->vifs[0], priv->vifs[1]);
 
 	/* priv->vifs[0] is NULL here, based on how this function is currently
 	 * called from rtl8xxxu_add_interface().
-- 
2.20.1.7.g153144c


