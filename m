Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847086C50E5
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Mar 2023 17:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjCVQh2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Mar 2023 12:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjCVQh1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Mar 2023 12:37:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5237760D43
        for <linux-wireless@vger.kernel.org>; Wed, 22 Mar 2023 09:37:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E24D361FF9
        for <linux-wireless@vger.kernel.org>; Wed, 22 Mar 2023 16:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EFFC433D2;
        Wed, 22 Mar 2023 16:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679503045;
        bh=7peHL55yX5CWdBGMMkNm90MiW3BuG9RUGzOlbABc5wU=;
        h=From:To:Cc:Subject:Date:From;
        b=RbLvqq0RmsFMXqv3tvdKNcSKj3zWnV/GBxZk2NJmo35FDKemeTkIq3UfWNUOSotHe
         zjx1N6NKt4OLssb3dJnbPjbzTHtOQfJJMfsdAT+i4z8qwx5m8Z10UM6QuVSI9GHiBH
         H34lBNg8BylNagU+UL3RmRacw4tGBzyaJ2BydIX0bFEoNdhiFQTXR/JAzXGt6FyoVK
         sSibnA89s59pn+PU5ugPUdFJ62WOAiEO07jvMeywrgIqeDncCNbvpU3aG903WB0OYq
         PRww7K3fkLaWWCQFdSY2sgyZVgk53kcD2n6ajfm01mh28/IjApiAOIOQ3Pj//A9yDO
         dCj134ltp0m4A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Ben Greear <greearb@candelatech.com>
Subject: [PATCH v3] wireless: mt76: mt7921: Fix use-after-free in fw features query.
Date:   Wed, 22 Mar 2023 17:37:17 +0100
Message-Id: <51fd8f76494348aa9ecbf0abc471ebe47a983dfd.1679502607.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
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
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v2:
- get rid of the comments
---
 drivers/net/wireless/mediatek/mt76/mt7921/init.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 80c71acfe159..cc94531185da 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -171,12 +171,12 @@ mt7921_mac_init_band(struct mt7921_dev *dev, u8 band)
 
 u8 mt7921_check_offload_capability(struct device *dev, const char *fw_wm)
 {
-	struct mt7921_fw_features *features = NULL;
 	const struct mt76_connac2_fw_trailer *hdr;
 	struct mt7921_realease_info *rel_info;
 	const struct firmware *fw;
 	int ret, i, offset = 0;
 	const u8 *data, *end;
+	u8 offload_caps = 0;
 
 	ret = request_firmware(&fw, fw_wm, dev);
 	if (ret)
@@ -208,7 +208,10 @@ u8 mt7921_check_offload_capability(struct device *dev, const char *fw_wm)
 		data += sizeof(*rel_info);
 
 		if (rel_info->tag == MT7921_FW_TAG_FEATURE) {
+			struct mt7921_fw_features *features;
+
 			features = (struct mt7921_fw_features *)data;
+			offload_caps = features->data;
 			break;
 		}
 
@@ -218,7 +221,7 @@ u8 mt7921_check_offload_capability(struct device *dev, const char *fw_wm)
 out:
 	release_firmware(fw);
 
-	return features ? features->data : 0;
+	return offload_caps;
 }
 EXPORT_SYMBOL_GPL(mt7921_check_offload_capability);
 
-- 
2.39.2

