Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A1265BE45
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jan 2023 11:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbjACKg1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Jan 2023 05:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237238AbjACKgS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Jan 2023 05:36:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CAAA18D
        for <linux-wireless@vger.kernel.org>; Tue,  3 Jan 2023 02:36:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CFC961240
        for <linux-wireless@vger.kernel.org>; Tue,  3 Jan 2023 10:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4184CC433D2;
        Tue,  3 Jan 2023 10:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672742176;
        bh=C2IskYc5ws2i+sc3p5we5h2PwpfKRXY7xdvTMtjgOyM=;
        h=From:To:Cc:Subject:Date:From;
        b=dlhvUTmFSL1Z89YEOfJb4+unOiMOjsukpwB4bzHrFaYp73Gt4Us7S4qWowDc3M7a+
         XHms27ag274Mtyt9fbVXVniCWM+Hr2N6y1PsUJvOU16XPcCx/llLZB83rak9JGYyBC
         iyj1L7CK6HYVXKm/gQUKO7ULijQB7HNG2W/CDFURRikEITINV5CMuzupv/Kpcs4Lnq
         kHspngDLh9j0JNiVuTv+R+uL57grki183iRxOmQm4tOqzjxjCeJ2B17iprEu3WzSXx
         9E+1OisFv1QECsalPIidJKZ4rAzO0UwwFu/0bwdLwiCwSWa5MQO4/tX5LJmDYKne8r
         NlU+FwtEHLtvg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt7921: fix memory leak in mt7921_check_offload_capability
Date:   Tue,  3 Jan 2023 11:36:02 +0100
Message-Id: <39ebf05085dd3069412c001ca9a31aa259de5a74.1672742135.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix possible memory leak in mt7921_check_offload_capability routine
relasing fw data.

Fixes: 034ae28b56f1 ("wifi: mt76: mt7921: introduce remain_on_channel support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 542dfd425129..5ec0caa23c23 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -175,7 +175,7 @@ u8 mt7921_check_offload_capability(struct device *dev, const char *fw_wm)
 
 	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
 		dev_err(dev, "Invalid firmware\n");
-		return -EINVAL;
+		goto out;
 	}
 
 	data = fw->data;
@@ -205,7 +205,7 @@ u8 mt7921_check_offload_capability(struct device *dev, const char *fw_wm)
 
 		data += le16_to_cpu(rel_info->len) + rel_info->pad_len;
 	}
-
+out:
 	release_firmware(fw);
 
 	return features ? features->data : 0;
-- 
2.39.0

