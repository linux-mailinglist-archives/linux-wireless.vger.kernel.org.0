Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A421FB346
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 16:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbgFPOBv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 10:01:51 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:40291 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729273AbgFPOBs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 10:01:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592316108; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=arJpySNeKHvCpsN1ZXJu4RDqRIBZmnSJDJ+ESmTBNEo=; b=mimDhlsc000Yq70B17w/DGiOw6cYiMUDX+6GTP2r8HiHQlAqs0IPrdeSOSyQzVY4RTIcI2PO
 KppzZHwTVZrWRy50tFwQVft7JNPB7YOuzdxwADjLkKSuaT6/ApHiL5BXX2QmRpRwOSN4418S
 ns9JdZegwld3lW9oRUCoDV+3yv0=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5ee8d0ae3a8a8b20b864356c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Jun 2020 14:01:18
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 145EEC433A0; Tue, 16 Jun 2020 14:01:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BD13AC433C9;
        Tue, 16 Jun 2020 14:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BD13AC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 08/12] ath11k: change ath11k_core_fetch_board_data_api_n() to use ath11k_core_create_firmware_path()
Date:   Tue, 16 Jun 2020 17:00:51 +0300
Message-Id: <1592316055-24958-9-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592316055-24958-1-git-send-email-kvalo@codeaurora.org>
References: <1592316055-24958-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use the helper added in previous comment to create the full path, instead of doing it manually.

No functional changes. Compile tested only.

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index de5b1d20771a..84a566dffad9 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -165,11 +165,13 @@ static int ath11k_core_fetch_board_data_api_n(struct ath11k_base *ab,
 {
 	size_t len, magic_len;
 	const u8 *data;
-	char *filename = ATH11K_BOARD_API2_FILE;
+	char *filename, filepath[100];
 	size_t ie_len;
 	struct ath11k_fw_ie *hdr;
 	int ret, ie_id;
 
+	filename = ATH11K_BOARD_API2_FILE;
+
 	if (!bd->fw)
 		bd->fw = ath11k_core_firmware_request(ab, filename);
 
@@ -179,11 +181,14 @@ static int ath11k_core_fetch_board_data_api_n(struct ath11k_base *ab,
 	data = bd->fw->data;
 	len = bd->fw->size;
 
+	ath11k_core_create_firmware_path(ab, filename,
+					 filepath, sizeof(filepath));
+
 	/* magic has extra null byte padded */
 	magic_len = strlen(ATH11K_BOARD_MAGIC) + 1;
 	if (len < magic_len) {
-		ath11k_err(ab, "failed to find magic value in %s/%s, file too short: %zu\n",
-			   ab->hw_params.fw.dir, filename, len);
+		ath11k_err(ab, "failed to find magic value in %s, file too short: %zu\n",
+			   filepath, len);
 		ret = -EINVAL;
 		goto err;
 	}
@@ -197,8 +202,8 @@ static int ath11k_core_fetch_board_data_api_n(struct ath11k_base *ab,
 	/* magic is padded to 4 bytes */
 	magic_len = ALIGN(magic_len, 4);
 	if (len < magic_len) {
-		ath11k_err(ab, "failed: %s/%s too small to contain board data, len: %zu\n",
-			   ab->hw_params.fw.dir, filename, len);
+		ath11k_err(ab, "failed: %s too small to contain board data, len: %zu\n",
+			   filepath, len);
 		ret = -EINVAL;
 		goto err;
 	}
@@ -246,8 +251,8 @@ static int ath11k_core_fetch_board_data_api_n(struct ath11k_base *ab,
 out:
 	if (!bd->data || !bd->len) {
 		ath11k_err(ab,
-			   "failed to fetch board data for %s from %s/%s\n",
-			   boardname, ab->hw_params.fw.dir, filename);
+			   "failed to fetch board data for %s from %s\n",
+			   boardname, filepath);
 		ret = -ENODATA;
 		goto err;
 	}
-- 
2.7.4

