Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0B229326E
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Oct 2020 02:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389597AbgJTAv2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Oct 2020 20:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389594AbgJTAv2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Oct 2020 20:51:28 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916C1C0613CE
        for <linux-wireless@vger.kernel.org>; Mon, 19 Oct 2020 17:51:28 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l18so1054131pgg.0
        for <linux-wireless@vger.kernel.org>; Mon, 19 Oct 2020 17:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FN81eBNlNFruprGp0OC1kMRsX4PP7l7eO1LNzVYzBVY=;
        b=bH9ODpiM2P0UpI7DcxMTKSXtnD8+H/7eGD+d+hxtx43JIXJkJ1DXly60MvRPTl/Upu
         FhkvfXC2CH7DU+04/yfdWWb0pXvxUGSRw67QEN5OLEFFs4E1VG4PlLmg9ttMKK/1RNvc
         xvJcI8nwVliy+lnyGqBIM8M7upm+Tpr9kdmd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FN81eBNlNFruprGp0OC1kMRsX4PP7l7eO1LNzVYzBVY=;
        b=PrdNpQN8xaErJe68J908WK7Uswhqz5LAsqy30/JPs0GRxtDpc/gvi1GalG2B9cZwTm
         SSEqfy8umDaXh7qidNgbNa+jJwVhnrt7UFlJKxtrzWgw4RPFJkLff+qKPT4wpMv/IjQL
         Nf2jarOTSjIulleGJRa8n8QR862abQyddfDwUGfcfv/av5abz8wgftlg2jNbwcvzulHi
         sZ0rhSTv9FjMno5zr/IH21UA4HP40KGi36gnkT0t3Y/Q/GDmYgQHhtyWUkk3D3un1+yf
         Zp3fR9EV8/jPRxmqV3mW03/jv+zhBVZnAxN5s11suJOYvTuahNlPDqQLyZn1FqszXxuX
         babQ==
X-Gm-Message-State: AOAM5336XO44uEnprOZG5SurH6EzQzZ1ItIKvnmM0vnRuEJ0vAOb5a2Y
        Y5OvRMWikbQ85BzFGbkaa1WmBQ==
X-Google-Smtp-Source: ABdhPJyQA4Jd2pPiM9AnYwf5OQHO+diZVIGPUTiNtAPZILlWMxFxS8mRsQkG/Lq2diVVkF+mYsLzBw==
X-Received: by 2002:aa7:9f88:0:b029:152:80df:4c52 with SMTP id z8-20020aa79f880000b029015280df4c52mr242447pfr.54.1603155088096;
        Mon, 19 Oct 2020 17:51:28 -0700 (PDT)
Received: from kuabhs-cdev.c.googlers.com.com (56.4.82.34.bc.googleusercontent.com. [34.82.4.56])
        by smtp.gmail.com with ESMTPSA id h20sm142904pfo.168.2020.10.19.17.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 17:51:27 -0700 (PDT)
From:   Abhishek Kumar <kuabhs@chromium.org>
To:     kvalo@codeaurora.org
Cc:     ath10k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, kuabhs@chromium.org
Subject: [PATCH] ath10k: add option for chip-id based BDF selection
Date:   Tue, 20 Oct 2020 00:51:00 +0000
Message-Id: <20201020000506.1.Ifbc28707942179f1cefc7491e995814564495270@changeid>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In some devices difference in chip-id should be enough to pick
the right BDF. Add another support for chip-id based BDF selection.
With this new option, ath10k supports 2 fallback options.

The board name with chip-id as option looks as follows
board name 'bus=snoc,qmi-board-id=ff,qmi-chip-id=320'

Signed-off-by: Abhishek Kumar <kuabhs@chromium.org>
---

 drivers/net/wireless/ath/ath10k/core.c | 45 +++++++++++++++++++-------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index a3f15cc89a10..767bb9d6a197 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -1343,7 +1343,8 @@ static int ath10k_core_search_bd(struct ath10k *ar,
 
 static int ath10k_core_fetch_board_data_api_n(struct ath10k *ar,
 					      const char *boardname,
-					      const char *fallback_boardname,
+					      const char *fallback_boardname1,
+					      const char *fallback_boardname2,
 					      const char *filename)
 {
 	size_t len, magic_len;
@@ -1392,8 +1393,11 @@ static int ath10k_core_fetch_board_data_api_n(struct ath10k *ar,
 	ret = ath10k_core_search_bd(ar, boardname, data, len);
 
 	/* if we didn't find it and have a fallback name, try that */
-	if (ret == -ENOENT && fallback_boardname)
-		ret = ath10k_core_search_bd(ar, fallback_boardname, data, len);
+	if (ret == -ENOENT && fallback_boardname1)
+		ret = ath10k_core_search_bd(ar, fallback_boardname1, data, len);
+
+	if (ret == -ENOENT && fallback_boardname2)
+		ret = ath10k_core_search_bd(ar, fallback_boardname2, data, len);
 
 	if (ret == -ENOENT) {
 		ath10k_err(ar,
@@ -1413,7 +1417,8 @@ static int ath10k_core_fetch_board_data_api_n(struct ath10k *ar,
 }
 
 static int ath10k_core_create_board_name(struct ath10k *ar, char *name,
-					 size_t name_len, bool with_variant)
+					 size_t name_len, bool with_variant,
+					 bool with_chip_id)
 {
 	/* strlen(',variant=') + strlen(ar->id.bdf_ext) */
 	char variant[9 + ATH10K_SMBIOS_BDF_EXT_STR_LENGTH] = { 0 };
@@ -1432,12 +1437,17 @@ static int ath10k_core_create_board_name(struct ath10k *ar, char *name,
 	}
 
 	if (ar->id.qmi_ids_valid) {
-		if (with_variant && ar->id.bdf_ext[0] != '\0')
+		if (with_variant && ar->id.bdf_ext[0] != '\0' && with_chip_id)
 			scnprintf(name, name_len,
 				  "bus=%s,qmi-board-id=%x,qmi-chip-id=%x%s",
 				  ath10k_bus_str(ar->hif.bus),
 				  ar->id.qmi_board_id, ar->id.qmi_chip_id,
 				  variant);
+		else if (with_chip_id)
+			scnprintf(name, name_len,
+				  "bus=%s,qmi-board-id=%x,qmi-chip-id=%x",
+				  ath10k_bus_str(ar->hif.bus),
+				  ar->id.qmi_board_id, ar->id.qmi_chip_id);
 		else
 			scnprintf(name, name_len,
 				  "bus=%s,qmi-board-id=%x",
@@ -1476,21 +1486,33 @@ static int ath10k_core_create_eboard_name(struct ath10k *ar, char *name,
 
 int ath10k_core_fetch_board_file(struct ath10k *ar, int bd_ie_type)
 {
-	char boardname[100], fallback_boardname[100];
+	char boardname[100], fallback_boardname1[100], fallback_boardname2[100];
 	int ret;
 
 	if (bd_ie_type == ATH10K_BD_IE_BOARD) {
+		/* With variant and chip id */
 		ret = ath10k_core_create_board_name(ar, boardname,
-						    sizeof(boardname), true);
+						sizeof(boardname), true, true);
 		if (ret) {
 			ath10k_err(ar, "failed to create board name: %d", ret);
 			return ret;
 		}
 
-		ret = ath10k_core_create_board_name(ar, fallback_boardname,
-						    sizeof(boardname), false);
+		/* Without variant and only chip-id */
+		ret = ath10k_core_create_board_name(ar, fallback_boardname1,
+						    sizeof(boardname), false,
+						    true);
+		if (ret) {
+			ath10k_err(ar, "failed to create 1st fallback board name: %d", ret);
+			return ret;
+		}
+
+		/* Without variant and without chip-id */
+		ret = ath10k_core_create_board_name(ar, fallback_boardname2,
+						    sizeof(boardname), false,
+						    false);
 		if (ret) {
-			ath10k_err(ar, "failed to create fallback board name: %d", ret);
+			ath10k_err(ar, "failed to create 2nd fallback board name: %d", ret);
 			return ret;
 		}
 	} else if (bd_ie_type == ATH10K_BD_IE_BOARD_EXT) {
@@ -1504,7 +1526,8 @@ int ath10k_core_fetch_board_file(struct ath10k *ar, int bd_ie_type)
 
 	ar->bd_api = 2;
 	ret = ath10k_core_fetch_board_data_api_n(ar, boardname,
-						 fallback_boardname,
+						 fallback_boardname1,
+						 fallback_boardname2,
 						 ATH10K_BOARD_API2_FILE);
 	if (!ret)
 		goto success;
-- 
2.29.0.rc1.297.gfa9743e501-goog

