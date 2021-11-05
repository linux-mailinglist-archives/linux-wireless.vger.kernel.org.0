Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3282446011
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Nov 2021 08:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbhKEHUP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Nov 2021 03:20:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44490 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbhKEHUO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Nov 2021 03:20:14 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7D0DC21892;
        Fri,  5 Nov 2021 07:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1636096652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=moIlCeqCuX+BsEoLqCY+cHnNdFET5l+jgYndyJOOQNs=;
        b=ZqtOdJ9uOP5MZNPS2y14CTLZmV1VJ+b3qhzmy8M2x4tGscufH1D8wb2oY+13hB+SPZcsLC
        puCMiX3yN/JH7xdynOXsyu5yyTLbVuxlgvtf06byB1ISD5INDoa4WahEutC7UJeJKg6cBG
        ZmBqxqF5rQNPKeGqQF1WFUl0aXrWP8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1636096652;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=moIlCeqCuX+BsEoLqCY+cHnNdFET5l+jgYndyJOOQNs=;
        b=EM/hLDfSBdiMED7Mt1/Zyo5bmYSNqRQiy9CoiLr67DCnn8aJIs8a9dTt6lMqQlNSeergt9
        gR6S4GYlizmmc5Ag==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
        by relay2.suse.de (Postfix) with ESMTP id 657C72C144;
        Fri,  5 Nov 2021 07:17:32 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Larry Finger <Larry.Finger@gmail.com>
Subject: [PATCH] rtw89: Fix crash by loading compressed firmware file
Date:   Fri,  5 Nov 2021 08:17:25 +0100
Message-Id: <20211105071725.31539-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When a firmware is loaded in the compressed format or via user-mode
helper, it's mapped in read-only, and the rtw89 driver crashes at
rtw89_fw_download() when it tries to modify some data.

This patch is an attemp to avoid the crash by re-allocating the data
via vmalloc() for the data modification.

Buglink: https://bugzilla.opensuse.org/show_bug.cgi?id=1188303
Signed-off-by: Takashi Iwai <tiwai@suse.de>

---
 drivers/net/wireless/realtek/rtw89/core.h |  3 ++-
 drivers/net/wireless/realtek/rtw89/fw.c   | 15 ++++++++++-----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index c2885e4dd882..048855e05697 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2309,7 +2309,8 @@ struct rtw89_fw_suit {
 	RTW89_FW_VER_CODE((s)->major_ver, (s)->minor_ver, (s)->sub_ver, (s)->sub_idex)
 
 struct rtw89_fw_info {
-	const struct firmware *firmware;
+	const void *firmware;
+	size_t firmware_size;
 	struct rtw89_dev *rtwdev;
 	struct completion completion;
 	u8 h2c_seq;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 212aaf577d3c..b59fecaeea25 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -124,8 +124,8 @@ int rtw89_mfw_recognize(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
 			struct rtw89_fw_suit *fw_suit)
 {
 	struct rtw89_fw_info *fw_info = &rtwdev->fw;
-	const u8 *mfw = fw_info->firmware->data;
-	u32 mfw_len = fw_info->firmware->size;
+	const u8 *mfw = fw_info->firmware;
+	u32 mfw_len = fw_info->firmware_size;
 	const struct rtw89_mfw_hdr *mfw_hdr = (const struct rtw89_mfw_hdr *)mfw;
 	const struct rtw89_mfw_info *mfw_info;
 	int i;
@@ -489,7 +489,10 @@ static void rtw89_load_firmware_cb(const struct firmware *firmware, void *contex
 		return;
 	}
 
-	fw->firmware = firmware;
+	fw->firmware = vmalloc(firmware->size);
+	if (fw->firmware)
+		memcpy((void *)fw->firmware, firmware->data, firmware->size);
+	release_firmware(firmware);
 	complete_all(&fw->completion);
 }
 
@@ -518,8 +521,10 @@ void rtw89_unload_firmware(struct rtw89_dev *rtwdev)
 
 	rtw89_wait_firmware_completion(rtwdev);
 
-	if (fw->firmware)
-		release_firmware(fw->firmware);
+	if (fw->firmware) {
+		vfree(fw->firmware);
+		fw->firmware = NULL;
+	}
 }
 
 #define H2C_CAM_LEN 60
-- 
2.26.2

