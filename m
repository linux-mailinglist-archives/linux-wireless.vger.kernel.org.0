Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C28B476152
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Dec 2021 20:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344093AbhLOTIR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Dec 2021 14:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238618AbhLOTIQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Dec 2021 14:08:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4151C061574
        for <linux-wireless@vger.kernel.org>; Wed, 15 Dec 2021 11:08:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A85EC6164E
        for <linux-wireless@vger.kernel.org>; Wed, 15 Dec 2021 19:08:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25637C36AE3;
        Wed, 15 Dec 2021 19:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639595295;
        bh=h6NOyNLCsU6bYiUjUEdm0DJjcNoyrDk8RgwSfCLkc9A=;
        h=From:To:Cc:Subject:Date:From;
        b=a67GjmKUrmlT9GNaxSjIn9nUep6dRX+L9owy94h74UelRRbTFNnQmrcIthRftYr+X
         f678rvAMZojiR6Rgr1bxFs3Ynb/px7PGHszMxLmbVS239v6jbaOpQiohj5FaPisOER
         FVnn4zfjXP3Ybq9YreBrn64+QKnOuA0nk+Xd65EbAH1l9eoIa+mMwgswn2DSX26QZc
         E5oSrzlSKjFFtVJiuxTsLZa5Jp7/vU+UI89ZGQfuWAZIoTfyPSQ98v/VQNydEr1aPp
         1i0mKLMcDWHvht8TMb+rg9VkdAf3rRRyhncqaWektAu4pi4im+2ITSNcNWX1MfPk8B
         IF/XogSZ+oCFQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: connac: rely on le16_add_cpu in mt76_connac_mcu_add_nested_tlv
Date:   Wed, 15 Dec 2021 20:08:02 +0100
Message-Id: <9c22a29ecd98fd19f862f61798b2673ecb7784f5.1639595218.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on le16_add_cpu() in mt76_connac_mcu_add_nested_tlv routine.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 93480f448d85..f79e3d5084f3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -258,11 +258,8 @@ mt76_connac_mcu_add_nested_tlv(struct sk_buff *skb, int tag, int len,
 	ntlv = le16_to_cpu(ntlv_hdr->tlv_num);
 	ntlv_hdr->tlv_num = cpu_to_le16(ntlv + 1);
 
-	if (sta_hdr) {
-		u16 size = le16_to_cpu(sta_hdr->len);
-
-		sta_hdr->len = cpu_to_le16(size + len);
-	}
+	if (sta_hdr)
+		le16_add_cpu(&sta_hdr->len, len);
 
 	return ptlv;
 }
-- 
2.33.1

