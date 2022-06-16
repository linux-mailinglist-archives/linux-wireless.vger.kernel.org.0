Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EC054E937
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jun 2022 20:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiFPSSQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jun 2022 14:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiFPSSP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jun 2022 14:18:15 -0400
X-Greylist: delayed 1200 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Jun 2022 11:18:13 PDT
Received: from 7.mo560.mail-out.ovh.net (7.mo560.mail-out.ovh.net [188.165.48.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C34545066
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jun 2022 11:18:13 -0700 (PDT)
Received: from player734.ha.ovh.net (unknown [10.111.208.252])
        by mo560.mail-out.ovh.net (Postfix) with ESMTP id F1E122380B
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jun 2022 17:40:03 +0000 (UTC)
Received: from galgus.net (86-127-225-235.digimobil.es [86.127.225.235])
        (Authenticated sender: jesus.manzano@galgus.net)
        by player734.ha.ovh.net (Postfix) with ESMTPSA id 3AC442B7CFCEC;
        Thu, 16 Jun 2022 17:40:00 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-102R00463922318-e613-40ed-a497-33fc058fb38a,
                    F4FD44FD571365DA550CAEAA7E09DDA2F3552634) smtp.auth=jesus.manzano@galgus.net
X-OVh-ClientIp: 86.127.225.235
From:   Jesus Fernandez Manzano <jesus.manzano@galgus.net>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, jesus.manzano@galgus.net
Subject: [PATCH] ath11k: fix number of VHT beamformee spatial streams
Date:   Thu, 16 Jun 2022 19:39:47 +0200
Message-Id: <20220616173947.21901-1-jesus.manzano@galgus.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 7706503387378414065
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddvfedguddutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfgvshhushcuhfgvrhhnrghnuggviicuofgrnhiirghnohcuoehjvghsuhhsrdhmrghniigrnhhosehgrghlghhushdrnhgvtheqnecuggftrfgrthhtvghrnhepgffhvefhieehveeludekudeuveegfedtuedukeffudeufeeuieetvdduhfdtjedunecukfhppedtrddtrddtrddtpdekiedruddvjedrvddvhedrvdefheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeefgedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehjvghsuhhsrdhmrghniigrnhhosehgrghlghhushdrnhgvthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdifihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeitd
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The number of spatial streams used when acting as a beamformee in VHT
mode are reported by the firmware as 7 (8 sts - 1) both in IPQ6018 and
IPQ8074 which respectively have 2 and 4 sts each. So the firmware should
report 1 (2 - 1) and 3 (4 - 1).

Fix this by checking that the number of VHT beamformee sts reported by
the firmware is not greater than the number of receiving antennas - 1.
The fix is based on the same approach used in this same function for
sanitizing the number of sounding dimensions reported by the firmware.

Without this change, acting as a beamformee in VHT mode is not working
properly.

Tested-on: IPQ6018 hw1.0 AHB WLAN.HK.2.5.0.1-01208-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01208-QCAHKSWPL_SILICONZ-1

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Jesus Fernandez Manzano <jesus.manzano@galgus.net>
---
 drivers/net/wireless/ath/ath11k/mac.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 42d2e8cf8125..7109ca4f166d 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4950,6 +4950,8 @@ static int ath11k_mac_set_txbf_conf(struct ath11k_vif *arvif)
 	if (vht_cap & (IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE)) {
 		nsts = vht_cap & IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK;
 		nsts >>= IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT;
+		if (nsts > (ar->num_rx_chains - 1))
+			nsts = ar->num_rx_chains - 1;
 		value |= SM(nsts, WMI_TXBF_STS_CAP_OFFSET);
 	}
 
@@ -4990,7 +4992,7 @@ static int ath11k_mac_set_txbf_conf(struct ath11k_vif *arvif)
 static void ath11k_set_vht_txbf_cap(struct ath11k *ar, u32 *vht_cap)
 {
 	bool subfer, subfee;
-	int sound_dim = 0;
+	int sound_dim = 0, nsts = 0;
 
 	subfer = !!(*vht_cap & (IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE));
 	subfee = !!(*vht_cap & (IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE));
@@ -5000,6 +5002,11 @@ static void ath11k_set_vht_txbf_cap(struct ath11k *ar, u32 *vht_cap)
 		subfer = false;
 	}
 
+	if (ar->num_rx_chains < 2) {
+		*vht_cap &= ~(IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE);
+		subfee = false;
+	}
+
 	/* If SU Beaformer is not set, then disable MU Beamformer Capability */
 	if (!subfer)
 		*vht_cap &= ~(IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE);
@@ -5012,7 +5019,9 @@ static void ath11k_set_vht_txbf_cap(struct ath11k *ar, u32 *vht_cap)
 	sound_dim >>= IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_SHIFT;
 	*vht_cap &= ~IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK;
 
-	/* TODO: Need to check invalid STS and Sound_dim values set by FW? */
+	nsts = (*vht_cap & IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK);
+	nsts >>= IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT;
+	*vht_cap &= ~IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK;
 
 	/* Enable Sounding Dimension Field only if SU BF is enabled */
 	if (subfer) {
@@ -5024,9 +5033,15 @@ static void ath11k_set_vht_txbf_cap(struct ath11k *ar, u32 *vht_cap)
 		*vht_cap |= sound_dim;
 	}
 
-	/* Use the STS advertised by FW unless SU Beamformee is not supported*/
-	if (!subfee)
-		*vht_cap &= ~(IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK);
+	/* Enable Beamformee STS Field only if SU BF is enabled */
+	if (subfee) {
+		if (nsts > (ar->num_rx_chains - 1))
+			nsts = ar->num_rx_chains - 1;
+
+		nsts <<= IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT;
+		nsts &=  IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK;
+		*vht_cap |= nsts;
+	}
 }
 
 static struct ieee80211_sta_vht_cap
-- 
2.25.1

