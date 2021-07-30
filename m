Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD80F3DC184
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Jul 2021 01:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbhG3XV1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Jul 2021 19:21:27 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.49]:44352 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233500AbhG3XV1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Jul 2021 19:21:27 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.119])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id DA0AA1A006A
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jul 2021 23:21:20 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id B89787C0068
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jul 2021 23:21:20 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 545AD13C2B1;
        Fri, 30 Jul 2021 16:21:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 545AD13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1627687280;
        bh=7PDWbJt6RBx1H6N7lbTr/WYGM5igrxh0CCrgMRBjjN8=;
        h=From:To:Cc:Subject:Date:From;
        b=Zy86HSRs8pUvxnom4cY1YHDWR4wwVwm9/D1pNOeWHOVBbcQw1/h1ug7Ksiu4fyo6r
         e7PZXASmmSe/48t54XLjyVMKY0uITm4MvceqtO+OX+qpwRon3aakkDylKyKS75i+oO
         rTINU7THXFy0MmYkR75lka8tq/ng2OPOPb4YIGrk=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v3] mt76: mt7915:  Fix hwmon temp sensor mem use-after-free.
Date:   Fri, 30 Jul 2021 16:21:15 -0700
Message-Id: <20210730232115.3965-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MDID: 1627687281-phNI43ff1TYh
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Without this change, garbage is seen in the hwmon name
and sensors output for mt7915 is garbled.

With the change:

mt7915-pci-1400
Adapter: PCI adapter
temp1:        +49.0°C

Fixes: d6938251bb5be8 (mt76: mt7915: add thermal sensor device support)
Signed-off-by: Ben Greear <greearb@candelatech.com>
---

v3:  Add 'fixes' tag to aid backports.

 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 192e3e190ce1..e741c4f73d19 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -132,8 +132,16 @@ static int mt7915_thermal_init(struct mt7915_phy *phy)
 	struct wiphy *wiphy = phy->mt76->hw->wiphy;
 	struct thermal_cooling_device *cdev;
 	struct device *hwmon;
+	struct mt7915_dev *dev = phy->dev;
+	bool ext_phy = phy != &dev->phy;
+	const char *my_prefix;
 
-	cdev = thermal_cooling_device_register(wiphy_name(wiphy), phy,
+	if (ext_phy)
+		my_prefix = "mt7915_ext";
+	else
+		my_prefix = "mt7915";
+
+	cdev = thermal_cooling_device_register(my_prefix, phy,
 					       &mt7915_thermal_ops);
 	if (!IS_ERR(cdev)) {
 		if (sysfs_create_link(&wiphy->dev.kobj, &cdev->device.kobj,
@@ -147,7 +155,7 @@ static int mt7915_thermal_init(struct mt7915_phy *phy)
 		return 0;
 
 	hwmon = devm_hwmon_device_register_with_groups(&wiphy->dev,
-						       wiphy_name(wiphy), phy,
+						       my_prefix, phy,
 						       mt7915_hwmon_groups);
 	if (IS_ERR(hwmon))
 		return PTR_ERR(hwmon);
-- 
2.20.1

