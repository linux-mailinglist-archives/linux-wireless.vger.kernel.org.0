Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFFF6AFBA8
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Mar 2023 02:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCHBAk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Mar 2023 20:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjCHBAg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Mar 2023 20:00:36 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B997A2F08
        for <linux-wireless@vger.kernel.org>; Tue,  7 Mar 2023 17:00:31 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 1ADE460002E
        for <linux-wireless@vger.kernel.org>; Wed,  8 Mar 2023 01:00:29 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id A8E7213C2B0;
        Tue,  7 Mar 2023 17:00:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com A8E7213C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1678237228;
        bh=HK2QwKbQXkjwzYUf0LqE6j1NO0vlWVMVhugUReuk5i0=;
        h=From:To:Cc:Subject:Date:From;
        b=Qv+1GTmAKsFJbVHRi+BeBpgyMhC/McWK/+Rxyf52FJEdTyMCC35jZGQIgfFmcJo3b
         xefFzU1daigXch26dWYw7BotiwBm6InxpKMdIPysiwi297GGcHv7angOZhCEYEvSbC
         rTIj0q7xJeVhTQBKbs1U6hXlhZhwBpBQaOUMGSBo=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] wireless: mt76: mt7921: Fix use-after-free in fw features query.
Date:   Tue,  7 Mar 2023 17:00:26 -0800
Message-Id: <20230308010026.2206775-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1678237229-ah6v5HmoJvZH
X-MDID-O: us5;ut7;1678237229;ah6v5HmoJvZH;<greearb@candelatech.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Stop referencing 'features' memory after release_firmware is called.

Fixes this crash:

RIP: 0010:mt7921_check_offload_capability+0x17d
mt7921_pci_probe+0xca/0x4b0
...

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/init.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 38d6563cb12f..3b6fb1a6b351 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -171,6 +171,7 @@ u8 mt7921_check_offload_capability(struct device *dev, const char *fw_wm)
 	const struct firmware *fw;
 	int ret, i, offset = 0;
 	const u8 *data, *end;
+	u8 rv = 0;
 
 	ret = request_firmware(&fw, fw_wm, dev);
 	if (ret)
@@ -197,12 +198,17 @@ u8 mt7921_check_offload_capability(struct device *dev, const char *fw_wm)
 	data += sizeof(*rel_info);
 	end = data + le16_to_cpu(rel_info->len);
 
+	/* TODO:  This needs better sanity checking I think.
+	 * Likely a corrupted firmware with bad rel_info->len, for instance,
+	 * would blow this up.
+	 */
 	while (data < end) {
 		rel_info = (struct mt7921_realease_info *)data;
 		data += sizeof(*rel_info);
 
 		if (rel_info->tag == MT7921_FW_TAG_FEATURE) {
 			features = (struct mt7921_fw_features *)data;
+			rv = features->data;
 			break;
 		}
 
@@ -211,7 +217,7 @@ u8 mt7921_check_offload_capability(struct device *dev, const char *fw_wm)
 
 	release_firmware(fw);
 
-	return features ? features->data : 0;
+	return rv;
 }
 EXPORT_SYMBOL_GPL(mt7921_check_offload_capability);
 
-- 
2.39.1

