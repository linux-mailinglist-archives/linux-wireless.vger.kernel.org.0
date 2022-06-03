Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C45553C7AD
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jun 2022 11:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243103AbiFCJh2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jun 2022 05:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243104AbiFCJhV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jun 2022 05:37:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2167E1261A
        for <linux-wireless@vger.kernel.org>; Fri,  3 Jun 2022 02:37:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06AB1619BF
        for <linux-wireless@vger.kernel.org>; Fri,  3 Jun 2022 09:37:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347BEC34114;
        Fri,  3 Jun 2022 09:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654249033;
        bh=L8fC+q1dDU+MU2FiUOxQ60mJBJq3EwEZjO1gCpcfGdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IDy5noGg3ehuO02KG3/j5pCddeU7kWikeFv7GWvvrroriURMMjsptgV3HGBGO7YB1
         Uv3Pnw4CXEln5onczPN8l2JRNB6n5CA5gwoBtmZoAX1CvYSJaubMOX+6r55VFlJ7Oh
         XdKv9icwjSD4xcKQXmDtkYwoIKR6vBBHx+mGHQzfOPCGa4Xa5B0gVg78a0sz3IxFqq
         lUvkXEvhM3oAf9Mww2bFNjiZJX/clN8OFhUqz+MKvHnABVqDIHRHeyhx3cPnWJetKE
         WmLx1qCv8p9LnuMhCtgWKIR1XbgIwxKDoWBhGP2Pt3B42C8DdASquFBTH8HUgNWO/t
         juPLFDBaGuCDg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH 5/5] mt76: mt7663: rely on mt76_connac2_fw_trailer
Date:   Fri,  3 Jun 2022 11:36:46 +0200
Message-Id: <0ad08a272cf6d4f5a37cbfdb72430078cb3b1716.1654248715.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1654248715.git.lorenzo@kernel.org>
References: <cover.1654248715.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove duplicated code

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c    | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 97e2a85cb728..52635fa430af 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -40,18 +40,6 @@ struct mt7615_fw_trailer {
 #define FW_START_DLYCAL                 BIT(1)
 #define FW_START_WORKING_PDA_CR4	BIT(2)
 
-struct mt7663_fw_trailer {
-	u8 chip_id;
-	u8 eco_code;
-	u8 n_region;
-	u8 format_ver;
-	u8 format_flag;
-	u8 reserv[2];
-	char fw_ver[10];
-	char build_date[15];
-	__le32 crc;
-} __packed;
-
 struct mt7663_fw_buf {
 	__le32 crc;
 	__le32 d_img_size;
@@ -1518,7 +1506,7 @@ static int mt7615_mcu_cal_cache_apply(struct mt7615_dev *dev)
 static int mt7663_load_n9(struct mt7615_dev *dev, const char *name)
 {
 	u32 offset = 0, override_addr = 0, flag = FW_START_DLYCAL;
-	const struct mt7663_fw_trailer *hdr;
+	const struct mt76_connac2_fw_trailer *hdr;
 	const struct mt7663_fw_buf *buf;
 	const struct firmware *fw;
 	const u8 *base_addr;
@@ -1534,9 +1522,7 @@ static int mt7663_load_n9(struct mt7615_dev *dev, const char *name)
 		goto out;
 	}
 
-	hdr = (const struct mt7663_fw_trailer *)(fw->data + fw->size -
-						 FW_V3_COMMON_TAILER_SIZE);
-
+	hdr = (const void *)(fw->data + fw->size - FW_V3_COMMON_TAILER_SIZE);
 	dev_info(dev->mt76.dev, "N9 Firmware Version: %.10s, Build Time: %.15s\n",
 		 hdr->fw_ver, hdr->build_date);
 	dev_info(dev->mt76.dev, "Region number: 0x%x\n", hdr->n_region);
-- 
2.35.3

