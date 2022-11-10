Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20ADA624631
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Nov 2022 16:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbiKJPmT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Nov 2022 10:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiKJPmR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Nov 2022 10:42:17 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F333D2F00B
        for <linux-wireless@vger.kernel.org>; Thu, 10 Nov 2022 07:42:15 -0800 (PST)
Received: from evilbit.green-communications.fr ([92.154.77.116]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis)
 id 1MaIKJ-1oVs3b1niH-00WEuG; Thu, 10 Nov 2022 16:42:02 +0100
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 3/4] wifi: mt76: mt7915: Fix VHT beamforming capabilities with DBDC
Date:   Thu, 10 Nov 2022 16:39:52 +0100
Message-Id: <20221110153953.22562-4-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221110153953.22562-1-nicolas.cavallari@green-communications.fr>
References: <20221110153953.22562-1-nicolas.cavallari@green-communications.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4piidyHkK02Q2q/kp8+PCYQ3J3R7cEp65W3vgpqcLuc1O1yhELU
 cY08CXBxJvd2crxjenTcpJLgRT7maJHFWQ9xWCIugenmeljOo0cFJbo0+LWV0UwaYIUUEkC
 o1NOwlcal6Vj7uSgEqtV9Jl9zK+08OOlnoVP13QRE7Fom6Qaoz6WyU7HgB/lqvMx83y3CaC
 O5S6iHbwgUYpB2eRFj8Bw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:akWr/lQKATs=:IqK0c3X0FYBQdAKdNAhjCS
 qCo/t/NSHjDGc/tv2NVEdH4bHLvK6YZ1MO2MXBMgToej1GBD9aW5j53LhV26y71Y5o+ISaxdQ
 cGMwYxRoSgtnVpz0grOp6j1EZxba75axA4A+dVAKgS57rwcRmVCQ8zGpDaQh17AjfxhFeDXH6
 3s2HTyLRdJXv3WJA22ElP5Lo1iRXYryeLMiG8eLAtEwPbRuqdxZTN2eOOJa53jzeF8QMxUGOg
 rSR8G334Xl+F2a/Zn4uL15tbfjbJdiXFkZFSLVMbVZ6qlB1VpqDlKuoFdn5RxCvQeO9q5ZKKA
 y6TF8Iz9AcDFb9YgBSuzm9GOO0+t2qnckOthX33PTCz1+EvlJyOoRfGTA6YAZBplg8L9+tnR5
 geQ/tA+zr1RFsI3UN5BY5WivDX6PF5i0Wr5MEN89L9nU6qIOkXZAiN7SqHONc64EzZilBrFtq
 nGyQynHVofrHgy93tRTpdinZ+sf8hA8Dp8R6e737OV0Hwncczvbj5cFn/U2QxGZApU6/0Fd94
 dpIIhj4tS1jXHUQueu7gSS661k9qjhVrvlwkPfaDF/p6GxcX4UKCxK7NY4dPqJGburmnv9eCq
 kp7Vv1avQ740ka3QSRbEbqB5PYUwsPytpzmp8WJ1KrchxODS31qwaUnSgnisFsdRlPizEq8R+
 XxKQ4smjHVd3eYSeB0kL8Pn1KZN8kEBA8BVPw4MXLX1mtscwuvhyu6HbUWG2FHqPSjkw8VQ+P
 Vk2oon8IQ029qibxiAeaIf++Go1h8ReT0C2UNuWChdMY9S/zZBSpBKKWP6E5JriiyA3rxlEi5
 86sqxI6HMltN58DD2tQF8YJTfLCHwVquDw3VX5ARR5EEs8oNersa2pe0UYSWeA9ciFJfi7vRJ
 iOF7Rzzap24shgo+DD3A5JjscCDEwCm+RlWajr/P6F4b6RwqiciN/kTaqgCv3915pAvBJQR0u
 o86tL9uuojwvQylDvPmpdgcPMtWSEd8Nu+ggO87sAzWrthkU14VkKNyc6j/RTsORhM0omRmHE
 IagdJZlFjWwzarn1vDRTGkgYJhWr8qO1KXcAhnfWNyEr3rcC43a7v6w99ofBsjR1IXOhepgzB
 oc05DJYs5FfpJNeWe/l1bwfQoVtSCmv5KVZbv1VhXODmfo5lH0Jb83Mzj3hhTIInG8SS8GvZv
 oLinO3vohOwUwSoOnS1YBdLFeO2d9UM/R/yrUURMqMuQI8vx9NyaY4r3ukOtIX2sYPLN7yX8L
 LibLr199vaeF8giPvF11gC6xrBCBCX8+imMEe6q9bYKPKILnjZ9K/xfCVBwbmEaR2ZVYZKs5n
 BlV3QsjOTWU2Jiw6AYemdkeNVvhKelllhIMqr4OemopnaV8us7c=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Do not hardcode beamformee 4 space-time streams support, because
DBDC can only support up to 2.

Fixes: 00b2e16e0063 ("mt76: mt7915: add TxBF capabilities")
Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 324db5291c85..f2707115b5f3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -711,7 +711,8 @@ void mt7915_set_stream_vht_txbf_caps(struct mt7915_phy *phy)
 
 	*cap |= IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
 		IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE |
-		(3 << IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT);
+		FIELD_PREP(IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK,
+			   sts - 1);
 
 	*cap &= ~(IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK |
 		  IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE |
-- 
2.38.1

