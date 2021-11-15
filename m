Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475914501FA
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Nov 2021 11:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237373AbhKOKI1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Nov 2021 05:08:27 -0500
Received: from dvalin.narfation.org ([213.160.73.56]:56266 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237552AbhKOKIR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Nov 2021 05:08:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1636970720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5gu0GMtrQKVEsk6bZlhFGtmRJTyjLTvmg6ahp1uVoUA=;
        b=a2poC0qxMXkaz4KOQonI1ifaJ4t3Ff4x+KIlGEd++vdBsEzsI90Xy2OQ/0cQh+7s+cxFKe
        5VQTYACk1gXwXS6JH+nCUBGh/DU9l3QtM1qinUPV4QqE5tiSno92o2fzrw/MmMB0VgkE0X
        BWaoOImJr+vUvl5L2yOMz6emAXppiSw=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Karthikeyan Kathirvel <kathirve@codeaurora.org>,
        Sven Eckelmann <sven@narfation.org>
Subject: [PATCH v2 1/2] ath11k: clear the keys properly via DISABLE_KEY
Date:   Mon, 15 Nov 2021 11:04:40 +0100
Message-Id: <20211115100441.33771-1-sven@narfation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Karthikeyan Kathirvel <kathirve@codeaurora.org>

DISABLE_KEY sets the key_len to 0, firmware will not delete the keys if
key_len is 0. Changing from security mode to open mode will cause mcast
to be still encrypted without vdev restart.

Set the proper key_len for DISABLE_KEY cmd to clear the keys in
firmware.

Tested-on: IPQ6018 hw1.0 AHB WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Reported-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Karthikeyan Kathirvel <kathirve@codeaurora.org>
[sven@narfation.org: split into separate patches, clean up commit message]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
* resubmit with the missing second patch

 drivers/net/wireless/ath/ath11k/mac.c | 4 +---
 drivers/net/wireless/ath/ath11k/wmi.c | 3 ++-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 1cc55602787b..cdee7545e876 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3316,9 +3316,7 @@ static int ath11k_install_key(struct ath11k_vif *arvif,
 		return 0;
 
 	if (cmd == DISABLE_KEY) {
-		/* TODO: Check if FW expects  value other than NONE for del */
-		/* arg.key_cipher = WMI_CIPHER_NONE; */
-		arg.key_len = 0;
+		arg.key_cipher = WMI_CIPHER_NONE;
 		arg.key_data = NULL;
 		goto install;
 	}
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 5ae2ef4680d6..d97be60689be 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -1689,7 +1689,8 @@ int ath11k_wmi_vdev_install_key(struct ath11k *ar,
 	tlv = (struct wmi_tlv *)(skb->data + sizeof(*cmd));
 	tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_BYTE) |
 		      FIELD_PREP(WMI_TLV_LEN, key_len_aligned);
-	memcpy(tlv->value, (u8 *)arg->key_data, key_len_aligned);
+	if (arg->key_data)
+		memcpy(tlv->value, (u8 *)arg->key_data, key_len_aligned);
 
 	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_VDEV_INSTALL_KEY_CMDID);
 	if (ret) {
-- 
2.30.2

