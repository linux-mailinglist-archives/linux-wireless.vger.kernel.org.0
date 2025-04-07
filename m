Return-Path: <linux-wireless+bounces-21192-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74892A7DA67
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 11:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FBF4188C7F9
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 09:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02B82253B2;
	Mon,  7 Apr 2025 09:56:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB873218ABD;
	Mon,  7 Apr 2025 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744019766; cv=none; b=ZKCW+oaSTuBGHcpumOoy1XTL4SLOraldjjyHqxpw97pyNapYXwwSYYt085j4/GQFdh2U9wRKiugadwpY91EttmBMaCt5DJLC10+PjNl2SfO2TdGVJkjKsVcwFxxvIkjaKegKv7K6iOT9lNOaoyR+Ecb5PdpGzdL5PWGZ/O8YWVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744019766; c=relaxed/simple;
	bh=gNhUjMpeEX7mTvcDB/ug16RwEOcyXW1AXaDwQ+wRowk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cws7nqQ0HkJ+YgvBtHV6yTWEO2uWyJi3KrhuJZXODyA4j9kZvdFaouc6Qrsz2qoj7QVvltwouLHfp3O118RBYHiI1YMbK1Ug1Tc3COp50GZMlaTUaR0kv6Ucouy1/ClJTpXeYo110EoAP3Qx1cDNcNOP99xpv2LUREmtG24p0d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201606.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202504071755536257;
        Mon, 07 Apr 2025 17:55:53 +0800
Received: from locahost.localdomain.com (10.94.5.217) by
 jtjnmail201606.home.langchao.com (10.100.2.6) with Microsoft SMTP Server id
 15.1.2507.39; Mon, 7 Apr 2025 17:55:54 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>, <ryder.lee@mediatek.com>,
	<shayne.chen@mediatek.com>, <sean.wang@mediatek.com>,
	<matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<howard-yh.hsu@mediatek.com>, <StanleyYP.Wang@mediatek.com>,
	<chui-hao.chiu@mediatek.com>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Charles Han <hanchunchao@inspur.com>
Subject: [PATCH] wifi: mt76: mt7996: Add NULL check in mt7996_thermal_init
Date: Mon, 7 Apr 2025 17:55:51 +0800
Message-ID: <20250407095551.32127-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2025407175553cfc5208c70a300baf4f5d5e9bd496b54
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

devm_kasprintf() can return a NULL pointer on failure,but this
returned value in mt7996_thermal_init() is not checked.
Add NULL check in mt7996_thermal_init(), to handle kernel NULL
pointer dereference error.

Fixes: 69d54ce7491d ("wifi: mt76: mt7996: switch to single multi-radio wiphy")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 6b660424aedc..5af52bd1f1f1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -217,6 +217,9 @@ static int mt7996_thermal_init(struct mt7996_phy *phy)
 
 	name = devm_kasprintf(&wiphy->dev, GFP_KERNEL, "mt7996_%s.%d",
 			      wiphy_name(wiphy), phy->mt76->band_idx);
+	if (!name)
+		return -ENOMEM;
+
 	snprintf(cname, sizeof(cname), "cooling_device%d", phy->mt76->band_idx);
 
 	cdev = thermal_cooling_device_register(name, phy, &mt7996_thermal_ops);
-- 
2.43.0


