Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90282580086
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Jul 2022 16:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbiGYOMW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Jul 2022 10:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiGYOMU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jul 2022 10:12:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D8FAE45
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jul 2022 07:12:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46101B80ED4
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jul 2022 14:12:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CD6C341C6;
        Mon, 25 Jul 2022 14:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658758337;
        bh=KcOUJaTeq05ZvYJ7XFjq2YKCE/UTQcJEfwvirsJZrIU=;
        h=From:To:Cc:Subject:Date:From;
        b=CKf1sA9aDLKa6SjUFvOcLWnaroPoO4l3eMRr/SmOGfQgU/UAPAi5O54+rtnDC4OiB
         TRpyFBA+pL0+Uz9sn9joBhvyNv5VgGtcmLOjE7d2uSXdJBXiaaWysPn7kD0FgmdxeE
         BVTwdy/ABlh1695rpcCiXPn9llZEXZlvI3A5uReJipF4JZzOvuyUEi5YsAvT2J/LV+
         L0NZGSCNEcGDbhaErRMhBeE0QbBp7V2g7VI+EUgDF6Zlt3Bq/QiQ8GTWJ2fL12wNbx
         fyEqJImqpV0sMD3C62nS4Pu6gnMARG3tTytl9YTyqgz0bSY9bTQj3IjXHcS0jcVabo
         zISceQ7ne6xvg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: connac: fix possible unaligned access in mt76_connac_mcu_add_nested_tlv
Date:   Mon, 25 Jul 2022 16:12:06 +0200
Message-Id: <b1eb65b1a3f384cbb8a7434e8e2d3f4dbac60f60.1658758277.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix possible unaligned pointer in mt76_connac_mcu_add_nested_tlv
routine.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 25702d9c55dc5 ("mt76: connac: rely on le16_add_cpu in mt76_connac_mcu_add_nested_tlv")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 9b17bd97ec09..13d4722e4186 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -260,8 +260,10 @@ mt76_connac_mcu_add_nested_tlv(struct sk_buff *skb, int tag, int len,
 	ntlv = le16_to_cpu(ntlv_hdr->tlv_num);
 	ntlv_hdr->tlv_num = cpu_to_le16(ntlv + 1);
 
-	if (sta_hdr)
-		le16_add_cpu(&sta_hdr->len, len);
+	if (sta_hdr) {
+		len += le16_to_cpu(sta_hdr->len);
+		sta_hdr->len = cpu_to_le16(len);
+	}
 
 	return ptlv;
 }
-- 
2.37.1

