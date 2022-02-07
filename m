Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245704AC7FA
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Feb 2022 18:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240280AbiBGRv6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Feb 2022 12:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239685AbiBGRng (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Feb 2022 12:43:36 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8D2C0401D9
        for <linux-wireless@vger.kernel.org>; Mon,  7 Feb 2022 09:43:35 -0800 (PST)
Received: from evilbit.green-communications.fr ([92.154.77.116]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis)
 id 1M4bA6-1nImeo1blO-001mHW; Mon, 07 Feb 2022 18:38:12 +0100
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [PATCH RFC 3/3] mt76: mt7915e: Enable thermal management by default
Date:   Mon,  7 Feb 2022 18:37:47 +0100
Message-Id: <20220207173747.7997-3-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220207173747.7997-1-nicolas.cavallari@green-communications.fr>
References: <d7ce90d8-552a-2cab-6310-3a84584172a1@green-communications.fr>
 <20220207173747.7997-1-nicolas.cavallari@green-communications.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SiOGOzsTtpXIwqwfrbLkC4RZX+gb0npsvx5wVL3eBoPbb+pYnd0
 3Ukpv7PIrzQHSXXKRKcdae/+TJvTfETyiKWMxLQ6u0GqKPsGgjtiAWMPPBUu91kzWUy/qOX
 zTeXiZzbcH1wxn6+yUdmPxoZeGmaHGZI7HmbXGJIAskEAlH6kwwbmwIclUj4BC1wYT/7A5l
 1OSRJCdedHWmX2r5cFryg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ByNk+d52gOA=:1vhyNLvbd/ujT5ut2uZ9WR
 iIKdvdT7gXSQHDo7nxRyvUVMOr+cruYDOQ28Vh5+nIYems7l9Z6tyQyjbmMoKlNh/NQ1ytMTp
 p4FSd2RG20OugLvoFBu2CdItgMhXy+Z4z9gxt/DLD8VedNbVqQBL+kepwnRrsuiEkhGy0m9Jx
 5lVTvuiZvuRqkou5qVKl3XXW3Oh9QmoOH7OIHS6RU6Oret7v5JFhBk064ilm5VxaEFMvpJPnZ
 ScF3174OTFYubQTny0IJX+JECX3im+1T51Fb3MKUe4B+Y00+sWv64iyf4G1OPzGwCSZNecXIv
 zl6WyPK02heRUtPPFi2HuoiqE3fPwTu5qrlnPQoineoAXyiZwVStfIAOujMuBuELIhdNlpWLH
 xDwXsUxda2TtvDkVVyabfHM1ACiHqmQJjLg7WJDVfI86pcwhcXCbUmENuveSe0bqTy2ULCx5c
 3o1/XhTR7185+50EVb8hj4472wfCJFag2+eaYtz72xhrdjwLG5olKpXiAiFfXBRBkHJWxUwqd
 irVaCYGfXbuTZcNZrXVzl0g6gRhbrwXKlj6U7Znhz8cC2OK59NgaGiRyfjT2DiE60g8srASTN
 dAMeyf2caUDS6AW2tuPEkqBVEdjLNJFpscTaMFOMkYGBymyWohm18P7/nxnDpxgpffN2G5pAP
 4dCD0WgpP+4a11g1glFnEj7TAe4svaD8+5yQrUhHNy2FwklzaHqOLQ0cUltuTEdP3uqOClKL9
 N2qByZGSN+PerOTF9HiPqJSNx/yPhJyw/GUcmQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

By default, mt7915e does not enable thermal management until the default
thermal zone does not reach a trip point.  If the rest of the system
have better cooling than the wireless hardware, then it is possible that
the wireless chip can overheat while the rest of the system is fine.

Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 71ca4b0641b6..4fa5da9195a2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -199,7 +199,8 @@ static int mt7915_thermal_init(struct mt7915_phy *phy)
 	phy->throttle_temp[0] = 110;
 	phy->throttle_temp[1] = 120;
 
-	return 0;
+	return mt7915_mcu_set_thermal_throttling(phy,
+						 MT7915_THERMAL_THROTTLE_MAX);
 }
 
 static void mt7915_led_set_config(struct led_classdev *led_cdev,
-- 
2.34.1

