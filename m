Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 010D6694D8
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jul 2019 16:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391297AbfGOO2y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Jul 2019 10:28:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:39452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391245AbfGOO2x (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Jul 2019 10:28:53 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A8DA205ED;
        Mon, 15 Jul 2019 14:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563200932;
        bh=NGn3o6+tbHpNnY8ubVR15rDwQBSUyshmddAT7zU/3HA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rlU+TGFc2DypgyFANHdfLhwk4wCkC94syZXEo33jpVanGpnrTQT3ZZvabJhWxLFbs
         LV/HJm0+8drJd7oYghyCaYaMXAcGTZo1LLyaeJeu0trEBa/DVkN0otD5zFYroaLLzY
         kW/Quiuok5nbFZ7Ahspx/n11/3dMWI1/kE0YCPLE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tim Schumacher <timschumi@gmx.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 003/105] ath9k: Check for errors when reading SREV register
Date:   Mon, 15 Jul 2019 10:26:57 -0400
Message-Id: <20190715142839.9896-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715142839.9896-1-sashal@kernel.org>
References: <20190715142839.9896-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tim Schumacher <timschumi@gmx.de>

[ Upstream commit 2f90c7e5d09437a4d8d5546feaae9f1cf48cfbe1 ]

Right now, if an error is encountered during the SREV register
read (i.e. an EIO in ath9k_regread()), that error code gets
passed all the way to __ath9k_hw_init(), where it is visible
during the "Chip rev not supported" message.

    ath9k_htc 1-1.4:1.0: ath9k_htc: HTC initialized with 33 credits
    ath: phy2: Mac Chip Rev 0x0f.3 is not supported by this driver
    ath: phy2: Unable to initialize hardware; initialization status: -95
    ath: phy2: Unable to initialize hardware; initialization status: -95
    ath9k_htc: Failed to initialize the device

Check for -EIO explicitly in ath9k_hw_read_revisions() and return
a boolean based on the success of the operation. Check for that in
__ath9k_hw_init() and abort with a more debugging-friendly message
if reading the revisions wasn't successful.

    ath9k_htc 1-1.4:1.0: ath9k_htc: HTC initialized with 33 credits
    ath: phy2: Failed to read SREV register
    ath: phy2: Could not read hardware revision
    ath: phy2: Unable to initialize hardware; initialization status: -95
    ath: phy2: Unable to initialize hardware; initialization status: -95
    ath9k_htc: Failed to initialize the device

This helps when debugging by directly showing the first point of
failure and it could prevent possible errors if a 0x0f.3 revision
is ever supported.

Signed-off-by: Tim Schumacher <timschumi@gmx.de>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/hw.c | 32 +++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/hw.c b/drivers/net/wireless/ath/ath9k/hw.c
index a7f506eb7b36..406b52f114f0 100644
--- a/drivers/net/wireless/ath/ath9k/hw.c
+++ b/drivers/net/wireless/ath/ath9k/hw.c
@@ -250,8 +250,9 @@ void ath9k_hw_get_channel_centers(struct ath_hw *ah,
 /* Chip Revisions */
 /******************/
 
-static void ath9k_hw_read_revisions(struct ath_hw *ah)
+static bool ath9k_hw_read_revisions(struct ath_hw *ah)
 {
+	u32 srev;
 	u32 val;
 
 	if (ah->get_mac_revision)
@@ -267,25 +268,33 @@ static void ath9k_hw_read_revisions(struct ath_hw *ah)
 			val = REG_READ(ah, AR_SREV);
 			ah->hw_version.macRev = MS(val, AR_SREV_REVISION2);
 		}
-		return;
+		return true;
 	case AR9300_DEVID_AR9340:
 		ah->hw_version.macVersion = AR_SREV_VERSION_9340;
-		return;
+		return true;
 	case AR9300_DEVID_QCA955X:
 		ah->hw_version.macVersion = AR_SREV_VERSION_9550;
-		return;
+		return true;
 	case AR9300_DEVID_AR953X:
 		ah->hw_version.macVersion = AR_SREV_VERSION_9531;
-		return;
+		return true;
 	case AR9300_DEVID_QCA956X:
 		ah->hw_version.macVersion = AR_SREV_VERSION_9561;
-		return;
+		return true;
 	}
 
-	val = REG_READ(ah, AR_SREV) & AR_SREV_ID;
+	srev = REG_READ(ah, AR_SREV);
+
+	if (srev == -EIO) {
+		ath_err(ath9k_hw_common(ah),
+			"Failed to read SREV register");
+		return false;
+	}
+
+	val = srev & AR_SREV_ID;
 
 	if (val == 0xFF) {
-		val = REG_READ(ah, AR_SREV);
+		val = srev;
 		ah->hw_version.macVersion =
 			(val & AR_SREV_VERSION2) >> AR_SREV_TYPE2_S;
 		ah->hw_version.macRev = MS(val, AR_SREV_REVISION2);
@@ -304,6 +313,8 @@ static void ath9k_hw_read_revisions(struct ath_hw *ah)
 		if (ah->hw_version.macVersion == AR_SREV_VERSION_5416_PCIE)
 			ah->is_pciexpress = true;
 	}
+
+	return true;
 }
 
 /************************************/
@@ -557,7 +568,10 @@ static int __ath9k_hw_init(struct ath_hw *ah)
 	struct ath_common *common = ath9k_hw_common(ah);
 	int r = 0;
 
-	ath9k_hw_read_revisions(ah);
+	if (!ath9k_hw_read_revisions(ah)) {
+		ath_err(common, "Could not read hardware revisions");
+		return -EOPNOTSUPP;
+	}
 
 	switch (ah->hw_version.macVersion) {
 	case AR_SREV_VERSION_5416_PCI:
-- 
2.20.1

