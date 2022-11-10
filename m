Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26B562464F
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Nov 2022 16:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbiKJPr2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Nov 2022 10:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiKJPr0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Nov 2022 10:47:26 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF19E3E097
        for <linux-wireless@vger.kernel.org>; Thu, 10 Nov 2022 07:47:25 -0800 (PST)
Received: from evilbit.green-communications.fr ([92.154.77.116]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis)
 id 1MzhWp-1pF4A43W5p-00vdVc; Thu, 10 Nov 2022 16:42:01 +0100
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 1/4] wifi: mt76: mt7915: fix antenna selection with bad eeprom.
Date:   Thu, 10 Nov 2022 16:39:50 +0100
Message-Id: <20221110153953.22562-2-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221110153953.22562-1-nicolas.cavallari@green-communications.fr>
References: <20221110153953.22562-1-nicolas.cavallari@green-communications.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:an+zU4zPZRczEKtChIwamWZftx3+8s+3rlfGTCytN669OSHlNqx
 4q7ofdhDDZTgiimYDAQ5bhQ9/QnXXMwR4XVqtsiE328sVjMXOsQ8m8N5MO0Z3tkZeD0RWQj
 iVXQWc/F9qEyYFCALMWRBI2PQPTW8OKryzkZ2UGp9zniQ8NX+aZFz+kHmRav1XlvaLvNy0z
 JgR+IoPq3Q+lyQK6rM4OQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eeYztmMBW+g=:le72UVqBGMTvKjhqMv6eSz
 wIE8taRR/UrIXYbC9Xg2n5uwPKGX6bvUR11OPcfpsn0QwJ9c/iYzvGBwp0NTcxgUopfZGCfuT
 Q6DgGjnCCzDKoh6L8ReiKdb+s25mtc1Mx14W0yrKiQuH1WIjkWOYDnyNYBkusPzX1nGgFofvm
 Dt/UYCe3HQ62BSM43sA/N1hLwmJpXhtzPjgSdj3Zosojb2YdEbtLuddyrQJx+BwzTxAGvFvmP
 wDwh0gXUJMSlyuhIAhLwGeeA4PxEzYIsw3fB7GGALGkQq/gshQ4umbqlyPTYcFyEjBFjSb1mi
 BHcRXURYp9/9pzq5TBKApXd7wYBizpyJelHYp6K7JysYkvtOvGIpni8vNO2NcC2KAkKosdq94
 PlJAzb4iin2lXtUHUs5+bjaHUA4k2tzrUFEix/NbSTGQGGCajgWmoDIChCDH3RT1CTuOgSTPW
 rYBAunml5lN0PwR57aM2cwufz/7vIPHNh9C8zv5gfRcKIQgBZ3AZn/lBm9r+SrWUs4+yUCwtZ
 1VIGc3Iu4iHXRcf5qQTVnYHiIEa+OZ4ScOtt6EegnqjKC686ZGbJGSUT3aeTKB4SDWY2rsPCb
 pSzxq15kc4B4iT77C0NOUSqurlfHOv3BW+E07Qz2cOphcKbSZGAO2BmKRtM74ztuvVzaUWV7S
 VNViQ//BH59M1VWM6GHY5Ll26L+nv10gkgmNHi0/QdcFoZAu1O+/30deFi0iin2zQd3j7PJN5
 43YnksSJTOSgC5j5qBf7uLVvhbTKlo7JWvP9+/ygAn+JLA0/b2JYXCZGIi6YycMlOFITnwAXY
 TZETdzrdVsSNHuKKQu/Lcho8/0sI7Xp02GjWOADMytCSL+9vcg=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If the nss value is zero in the eeprom, set it to the max.
This eeprom fragment from a mt7915 DBDC shows the problem:

00000190: 24 24 08 00 28 00 00 15 00 00 00 00 00 00 00 00

Fixes: 51a87540232c ("wifi: mt76: mt7915: rework eeprom tx paths and streams init")
Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
---
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index e2482c65d639..83bced0c0785 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -208,6 +208,8 @@ void mt7915_eeprom_parse_hw_cap(struct mt7915_dev *dev,
 			nss_max = 2;
 	}
 
+	if (!nss)
+		nss = nss_max;
 	nss = min_t(u8, min_t(u8, nss_max, nss), path);
 
 	mphy->chainmask = BIT(path) - 1;
-- 
2.38.1

