Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0316E3DBDD7
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jul 2021 19:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhG3RiM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Jul 2021 13:38:12 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:40358 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229773AbhG3RiL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Jul 2021 13:38:11 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.165])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 004B9A0068
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jul 2021 17:38:06 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id CF4979C006F
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jul 2021 17:38:05 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 22B0F13C2B1;
        Fri, 30 Jul 2021 10:38:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 22B0F13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1627666685;
        bh=m2rAGlQnRhPQQf7QvJeAjXR2JoU8PlhOxkNjPLqyK9Q=;
        h=From:To:Cc:Subject:Date:From;
        b=nLKqM/60M81yawgxO7wNwm5OZP3xKi+h+iUi7V/uhmTdbmYKHCZOq9iVNnaXukWrf
         9PGIDTk+V6Xy3XzR9l5ThFKfnTI2R3WQ70ej7UaGApYuu7wR8Bf/lXWRd3vgasWzQB
         0imy4qrUzuwbzwyuz+b/mnFYXmx+NZiNSltCoNm0=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v2] mt76: mt7915:  Fix hwmon temp sensor mem use-after-free.
Date:   Fri, 30 Jul 2021 10:38:03 -0700
Message-Id: <20210730173803.24358-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MDID: 1627666686-Idy_gj740ooM
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

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
v2:  Take ext-phy into account
   and do similar logic for the cooling device logic.

 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 192e3e190ce1..944b74a807a7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -132,8 +132,18 @@ static int mt7915_thermal_init(struct mt7915_phy *phy)
 	struct wiphy *wiphy = phy->mt76->hw->wiphy;
 	struct thermal_cooling_device *cdev;
 	struct device *hwmon;
-
-	cdev = thermal_cooling_device_register(wiphy_name(wiphy), phy,
+	struct mt7915_dev *dev = phy->dev;
+	bool ext_phy = phy != &dev->phy;
+	static const char *prefix_ext = "mt7915_ext";
+	static const char *prefix = "mt7915";
+	const char *my_prefix;
+
+	if (ext_phy)
+		my_prefix = prefix_ext;
+	else
+		my_prefix = prefix;
+
+	cdev = thermal_cooling_device_register(my_prefix, phy,
 					       &mt7915_thermal_ops);
 	if (!IS_ERR(cdev)) {
 		if (sysfs_create_link(&wiphy->dev.kobj, &cdev->device.kobj,
@@ -147,7 +157,7 @@ static int mt7915_thermal_init(struct mt7915_phy *phy)
 		return 0;
 
 	hwmon = devm_hwmon_device_register_with_groups(&wiphy->dev,
-						       wiphy_name(wiphy), phy,
+						       my_prefix, phy,
 						       mt7915_hwmon_groups);
 	if (IS_ERR(hwmon))
 		return PTR_ERR(hwmon);
-- 
2.20.1

