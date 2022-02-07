Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DEA4AC7F6
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Feb 2022 18:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237064AbiBGRwO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Feb 2022 12:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238056AbiBGRn1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Feb 2022 12:43:27 -0500
X-Greylist: delayed 309 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 09:43:26 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B468C0401D9
        for <linux-wireless@vger.kernel.org>; Mon,  7 Feb 2022 09:43:25 -0800 (PST)
Received: from evilbit.green-communications.fr ([92.154.77.116]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis)
 id 1MUGmJ-1nhlfW3Y83-00RF4t; Mon, 07 Feb 2022 18:38:09 +0100
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [PATCH RFC 2/3] mt76: mt7915e: Add a hwmon attribute to get the actual throttle state.
Date:   Mon,  7 Feb 2022 18:37:46 +0100
Message-Id: <20220207173747.7997-2-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220207173747.7997-1-nicolas.cavallari@green-communications.fr>
References: <d7ce90d8-552a-2cab-6310-3a84584172a1@green-communications.fr>
 <20220207173747.7997-1-nicolas.cavallari@green-communications.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Q6vkpC87/7YHrsXFMXeubvGg0KJHh0q+imEM0/CQ/xzzqKb9JAC
 DgaWxuaM61AZSyFWvo9sd71FnfYFf8KXRxzo9chBU1GTrA0sR9iwgRJlFgOLopATvvrjcc+
 CMCXQeIQMECcNo7ztNHkJRi9v9ZayFiEUzkbvh/tkr5WdvXThmkoNQcaqe0QGNzecDBljME
 3GNt6ghGG0fYgFf7bGoPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/XRvp/klgXU=:i3I9AjEoSyB/hMCCh/wSdu
 /Foca9xRTJQdn/tMzglyLSpRyvSDP5jb2RAfhvix9e8uJ3nNYdg1RODkQ4yYzkEY1hkL/dMPE
 yk/9MWE0ugivBayiedWjlrfgxiCr4kGjgwCji5/mJZtW8ZyX/A5IYgAp/m5YO07BX7PQJDMxm
 I/2bUpGOvXBF1nkzvgM4+kZ0YvltxNcFtDeyLeOV5ftljsew32et2Twh1EUttK8/ZHNLDRghQ
 2yMPYd8DwUALQhnT0Acetc0OSWu/iLLOYxOhxoWaebvSs9MfLo213mm2FspS0v7XTOCCIwBQS
 /MC5fmJtC6BoRH4pqBYf7G0D+3QxxGJ4iA4HOGN8VdWn+t5hP0Jc5CmnjZI2JDqHfe4Y5OQRc
 SUpxHyPjlaws1NKzfnDnXIQ1hviQZUtmU8MJCo4xLlfjhOK/Uf/t96VPieyeALKyo4yKuLjn9
 axnUtplksIVCdA2q2nNv5/z3kUF6ZdJbuFKtix6wx4WFMyidr4DH9jJ/NQNTsda9oCnWH3RSS
 GJd3cySwo53Hjvv9XJlirmhOLAFjKJM/dMCEAbzNBhgaG/1Hqg9mXNrCE8O3TnKe00UQsVJfr
 EbauviHlmAxQCBggPxNXaLDJ/XEyixtn2Yhcg5ZOvKA8FOGgMpON8Bnko5EtTFY4BBFIclEa8
 wPXFbqiA7SpRrmfS2zPhDZ2emcRGexWc++FlEdLfT7HGrAGtxbXJtGgpkGNR98hZJGP02nxRO
 vesrf76gt6M4SFECCFYsrSYm/h/u2TmweGDvOA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The firmware-controlled actual throttle state was previously available
by reading the cooling_device, but this confused the thermal subsystem.
Add a hwmon attribute to get it instead.

Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  | 27 ++++++++++++-------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index d6efbf1a2724..71ca4b0641b6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -50,15 +50,22 @@ static ssize_t mt7915_thermal_temp_show(struct device *dev,
 	int i = to_sensor_dev_attr(attr)->index;
 	int temperature;
 
-	if (i)
-		return sprintf(buf, "%u\n", phy->throttle_temp[i - 1] * 1000);
-
-	temperature = mt7915_mcu_get_temperature(phy);
-	if (temperature < 0)
-		return temperature;
-
-	/* display in millidegree celcius */
-	return sprintf(buf, "%u\n", temperature * 1000);
+	switch (i) {
+	case 0:
+		temperature = mt7915_mcu_get_temperature(phy);
+		if (temperature < 0)
+			return temperature;
+		/* display in millidegree celcius */
+		return sprintf(buf, "%u\n", temperature * 1000);
+	case 1:
+	case 2:
+		return sprintf(buf, "%u\n",
+			       phy->throttle_temp[i - 1] * 1000);
+	case 3:
+		return sprintf(buf, "%hhu\n", phy->throttle_state);
+	default:
+		return -EINVAL;
+	}
 }
 
 static ssize_t mt7915_thermal_temp_store(struct device *dev,
@@ -84,11 +91,13 @@ static ssize_t mt7915_thermal_temp_store(struct device *dev,
 static SENSOR_DEVICE_ATTR_RO(temp1_input, mt7915_thermal_temp, 0);
 static SENSOR_DEVICE_ATTR_RW(temp1_crit, mt7915_thermal_temp, 1);
 static SENSOR_DEVICE_ATTR_RW(temp1_max, mt7915_thermal_temp, 2);
+static SENSOR_DEVICE_ATTR_RO(throttle1, mt7915_thermal_temp, 3);
 
 static struct attribute *mt7915_hwmon_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_crit.dev_attr.attr,
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_throttle1.dev_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(mt7915_hwmon);
-- 
2.34.1

