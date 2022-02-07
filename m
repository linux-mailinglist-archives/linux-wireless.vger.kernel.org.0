Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241E44AC7F7
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Feb 2022 18:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbiBGRwN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Feb 2022 12:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238203AbiBGRn1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Feb 2022 12:43:27 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C313C0401DA
        for <linux-wireless@vger.kernel.org>; Mon,  7 Feb 2022 09:43:26 -0800 (PST)
Received: from evilbit.green-communications.fr ([92.154.77.116]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis)
 id 1MKsaz-1nbg9L1Ran-00LEoH; Mon, 07 Feb 2022 18:38:06 +0100
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [PATCH RFC 1/3] mt76: mt7915e: Fix degraded performance after temporary overheat
Date:   Mon,  7 Feb 2022 18:37:45 +0100
Message-Id: <20220207173747.7997-1-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <d7ce90d8-552a-2cab-6310-3a84584172a1@green-communications.fr>
References: <d7ce90d8-552a-2cab-6310-3a84584172a1@green-communications.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Y8+taFohQYdEKpCEm8w7Bui8N7fbtuwdis6JaWIRccn3+CZ6t+O
 +U9vcEemMppB9nlNwxVB6gwVlO9mevqNU5UJagbjaWW8o7YJUMaTmYEj+5F+j4twHgDvTWu
 vUzl3UKLzCBZJVbxsK83HwJG+kJUsW6jShgpG9ob+f5Z2/kxrie3leHHNix27W8l6KdAyR6
 4cVaqanNmroTHei9tzMkA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YJShyVz0SVc=:EVh7+qJZm2R8PnBHO1gXKg
 eOFP/URom1LjUa0CKFW1pIS1ut+9txZff+93aznwOqAmUeWJCeAw6WQjYxMMhHAGDhlr2oGQv
 jpZsGPuGOqLHi7ztFFY1bXi5SdGgKvhcyI4YHkGwssKXKVEPQJVjDru7dywxmgbgKk64ZqLFJ
 ns2aTw1gn7aRfmJx/tNj6UwGs20HwNjlBcXsBfO8MaGT2FXk/Q02Ub5/ue9c2GojI5PS0ABNv
 qEiz0E/7qAc8QnY2o8PGq97lqvOR6qjv2zPH8+9s6ZQopIdrwzstXQXBKBPNKVEPFVOKOFsbo
 OFUhcMjRjTp/pcqwZDy7Jn9on6HNFugnDjl3rlMlQcDLjCT6ikH78p8oAeBw0LHBAqVZkYBPv
 gIy5kxMIoUqMBOf9HxW0Mp2jb0/+YckvEmDKty56ggASw4Pkv5rRahkVkNRHmaaJOBupsvRO0
 Qb9BmmUkbC7I/hlI9wWSuWPpyUOfE5OOlQRUHqboBft/1hr5JXElnHDaQCdbmo8IgtePdnV4Q
 gvQSV+uovk30/fz1M70tAyq5/l16thjhPk1wRlcmgNysPkWlDPmor+UDY5ivd1ADUa8KEN4TW
 1sbGf21cDq7WPGsxV81G94muvrd5Oxso8mHepIZMYSZNeRpwZVnKM9wNjRvAjVejcz6jOr/MS
 J0SMCQ4ohjNYIjUfRUX8xTXlsqEeFtruttoVolI77zsxPm4ooIN3BuCBzfM100lRsuLTbLhRe
 FurrU259q2ca6cDUduh9KDTm+XoG+376KEKMoQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt7915e registers a cooling_device with wrong semantics:

1. cooling_device expect that higher states values should cool more, but
   mt7915e did the opposite...  with the exception of state == 0, which
   should "disable thermal management", but does not seem to have any
   effect since the previous state is kept.

The result is that when the thermal zone heats up a bit and bumps the
cooling_device state from 0 to 1 to cool a bit, the performance is
destroyed, and when going back from 1 to 0, the performance stays bad.

2. Reading the cooling_device state does not always return the last
   written state, but can return the actual hardware throttle state,
   which is different.

This is a problem because the mt7915 firmware actually implement the
equivalent of a thermal zone with trip points.  Setting the cooling
device state actually changes the throttles at each trip point, so the
following could occur if the first issue is fixed:

- thermal subsystem set state to 100% power (state=0)
- mt7915e driver set trip throttles to [100%, 50%, 25%, 12%]
- hardware heats up and decides to switch to 50% power
- thermal subsystem see that power is 50% (state=50), decide to increase
  it to 60% (state=40) because the rest of the system is cool.
- mt7915e driver set trip throttle to [60%, 30%, 15%, 7%]
- hardware thus switches to 30% power
[race to the bottom continues...]

This patch corrects the semantics of the cooling_device to the one that
the thermal subsystem expect it.

Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 16 ++++++++++------
 .../net/wireless/mediatek/mt76/mt7915/mt7915.h   |  2 ++
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 2bc9097c5214..d6efbf1a2724 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -97,7 +97,7 @@ static int
 mt7915_thermal_get_max_throttle_state(struct thermal_cooling_device *cdev,
 				      unsigned long *state)
 {
-	*state = MT7915_THERMAL_THROTTLE_MAX;
+	*state = MT7915_CDEV_THROTTLE_MAX;
 
 	return 0;
 }
@@ -108,7 +108,7 @@ mt7915_thermal_get_cur_throttle_state(struct thermal_cooling_device *cdev,
 {
 	struct mt7915_phy *phy = cdev->devdata;
 
-	*state = phy->throttle_state;
+	*state = phy->cdev_state;
 
 	return 0;
 }
@@ -120,20 +120,24 @@ mt7915_thermal_set_cur_throttle_state(struct thermal_cooling_device *cdev,
 	struct mt7915_phy *phy = cdev->devdata;
 	int ret;
 
-	if (state > MT7915_THERMAL_THROTTLE_MAX)
+	if (state > MT7915_CDEV_THROTTLE_MAX)
 		return -EINVAL;
 
 	if (phy->throttle_temp[0] > phy->throttle_temp[1])
 		return 0;
 
-	if (state == phy->throttle_state)
+	if (state == phy->cdev_state)
 		return 0;
 
-	ret = mt7915_mcu_set_thermal_throttling(phy, state);
+	// cooling_device convention: 0 = no cooling, more = more cooling
+	// mcu convention: 1 = max cooling, more = less cooling
+	ret = mt7915_mcu_set_thermal_throttling(phy,
+						MT7915_THERMAL_THROTTLE_MAX
+						- state);
 	if (ret)
 		return ret;
 
-	phy->throttle_state = state;
+	phy->cdev_state = state;
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 0403912a521d..cf4c8d2dcc60 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -49,6 +49,7 @@
 #define MT7915_CFEND_RATE_11B		0x03	/* 11B LP, 11M */
 
 #define MT7915_THERMAL_THROTTLE_MAX	100
+#define MT7915_CDEV_THROTTLE_MAX	99
 
 #define MT7915_SKU_RATE_NUM		161
 
@@ -218,6 +219,7 @@ struct mt7915_phy {
 	struct ieee80211_vif *monitor_vif;
 
 	struct thermal_cooling_device *cdev;
+	u8 cdev_state;
 	u8 throttle_state;
 	u32 throttle_temp[2]; /* 0: critical high, 1: maximum */
 
-- 
2.34.1

