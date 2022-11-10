Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DE462462E
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Nov 2022 16:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiKJPmS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Nov 2022 10:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiKJPmQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Nov 2022 10:42:16 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640037669
        for <linux-wireless@vger.kernel.org>; Thu, 10 Nov 2022 07:42:15 -0800 (PST)
Received: from evilbit.green-communications.fr ([92.154.77.116]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis)
 id 1M1qbm-1oqwlO0gDw-002GtZ; Thu, 10 Nov 2022 16:42:02 +0100
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 2/4] wifi: mt76: mt7915: Fix chainmask calculation on mt7915 DBDC
Date:   Thu, 10 Nov 2022 16:39:51 +0100
Message-Id: <20221110153953.22562-3-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221110153953.22562-1-nicolas.cavallari@green-communications.fr>
References: <20221110153953.22562-1-nicolas.cavallari@green-communications.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kBXxo6Uj4nCN1xxyuMGEJ/vbCTwUbKOu4ZtSdQNtZq9qwf2+cUZ
 uMgT0HsVDRcIfYO8GNAIVe30ustQdJwN5OhBDM5XZQvESqjq0H2IYsyl/2QWMz+MWdBMdh7
 ompvnTeRm0S7gPWlTUHtc+1vin/cp7qOuWahteFN+L0ZBD8REDjnlBPEFSnwCZG5on2spNq
 QqeqAhn/HcCw/sPwptClg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I+x1uICSHfY=:4HUWDw7wdIUveJtgYHoqOs
 eJ4RmY7CckeaCEmy8B+UqvDUcmMeUzT90gczQDwvP7qQS8BqjbPCoyQAKeGVVjVoItgHX+SK9
 2/GZIpTf4yLDWJfhHJCKmAYJ04w9HU4eBGBK914b+i/2SLdVk5Q7YBlyuwfkd/9aOTgFjN8+G
 Eqlns7oWAB3lblRKu4SYJCRiuh3M50w1Nkpyba9xTFbCKXBLanjZxqPBOnnVesB54RAsIuWyK
 fa08nKUEHvf+lXE1HzctfALdY4OOMlDh+BP6fOvByMXF7cusU1oUyN+cimKzjeDNYgRT9H6Jt
 EuIqMtgZ6Xp/FMTUMHjm0EI63pCBYnsHJbvn6WnQTD8YNkeXp1731mP9Lw4u03n35CFB8hXIk
 0iBSiRSQWFT07XHwrLQ/4SEIoPT8B576WTQuRsplIfQqCraTDbWJ2bRDgnK3wVoxy4Ld3aPH6
 fPZHBoPY+dWoIAUyWRiR0HAXBoCtwT1UCcxTH8NwapNw4y/6Btm5IHcMBHfF8OjxmDAszY5Mq
 Q1xeI3AhPxFQ6UU+pXAED5pC1L9VtP1Y7ugFQLBIBmLf/tsaW/H98G0T+7pLJ6Rl0zVGzMBsi
 gXIJI9tfhAHtRIkdJx620FPWRnxL3bgP+aIr6aG4RHoPDgvz1H+YbVhrz/Caydt/z11R35tft
 BQxhgeLXZtOMW/qnpWtTi6y8lV5e3vCjWhU3ejhbLPvae+rB1ppXi+/kzGBlPfbnW07MAXQ4T
 Qo+DJ6uYtce8Z/w1Vtt4sdlGkaUruDnbZQMN+nXO2qI0/CfobjR2oXxk7cot+7k+tR2Q8C1zG
 k+ODDFYIe2InbonijLRl94XEemXPP6Np3hqZ8Cj8xxFwLbLcbw=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt7915 does not have a per-band number of chains unlike the other chips,
it only has a total number of chains.  Yet the current code would
consider the total number as a per-band number.

For example, it would report that a 2x2 + 2x2 DBDC card have 4 chains on
each band and set chainmask to 0b1111 for the first interface and
0b11110000 for the second.

Fixes: 99ad32a4ca3a ("mt76: mt7915: add support for MT7986")
Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
---
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index 83bced0c0785..8bb971018a1e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -194,6 +194,7 @@ void mt7915_eeprom_parse_hw_cap(struct mt7915_dev *dev,
 	nss = path;
 	if (dev->dbdc_support) {
 		if (is_mt7915(&dev->mt76)) {
+			path = path / 2;
 			nss = FIELD_GET(MT_EE_WIFI_CONF3_TX_PATH_B0,
 					eeprom[MT_EE_WIFI_CONF + 3]);
 			if (phy->band_idx)
-- 
2.38.1

