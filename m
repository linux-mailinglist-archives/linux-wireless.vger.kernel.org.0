Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038C95EF874
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Sep 2022 17:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbiI2PPf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Sep 2022 11:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbiI2PPd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Sep 2022 11:15:33 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560A0F84B4
        for <linux-wireless@vger.kernel.org>; Thu, 29 Sep 2022 08:15:31 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.64.31])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 915871C0089;
        Thu, 29 Sep 2022 15:15:28 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 60EB7600087;
        Thu, 29 Sep 2022 15:15:28 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id CDA1613C2B0;
        Thu, 29 Sep 2022 08:15:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com CDA1613C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1664464527;
        bh=1glF0BrCEhCzmG8c+3ww9v+DtRNX8h30UNKqVWPAaGg=;
        h=From:To:Cc:Subject:Date:From;
        b=Ff/Jnmf9SZsk89P4wXlOA0iAdnBx6m1cTP3EOnDdcCkDywMzx70g119aG3XZEelYp
         dzWB5XdgBRo6lgqglcCtLwKACq0RcDWC7GkcmVQDlebeOsx4PO5PhfRKZoiZXNrZMM
         ojE243s/wBQLrdG55RyEoCzoeXE+1c2FNfLCwHAU=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     nbd@nbd.name, Ben Greear <greearb@candelatech.com>
Subject: [PATCH 1/2] wifi: mt76: mt7915: fix bounds checking for tx-free-done command
Date:   Thu, 29 Sep 2022 08:15:25 -0700
Message-Id: <20220929151526.9559-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1664464529-X_Ed7EJ7K0v8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

According to the tx-free-done documentation, the DW4 can be repeated,
so have to be more careful about how we test for walking off the
end of the array.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 4e70f5d050ea..bbaa77af387c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1116,14 +1116,16 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, void *data, int len)
 	total = le16_get_bits(free->ctrl, MT_TX_FREE_MSDU_CNT);
 	/* NOTE: 'v3' actually is checking for API version 4 */
 	v3 = (FIELD_GET(MT_TX_FREE_VER, txd) == 0x4);
-	if (WARN_ON_ONCE((void *)&tx_info[total >> v3] > end))
-		return;
 
 	for (cur_info = tx_info; count < total; cur_info++) {
-		u32 msdu, info = le32_to_cpu(*cur_info);
+		u32 msdu, info;
 		u8 i;
 		u32 tx_cnt, tx_status, ampdu;
 
+		if (WARN_ON_ONCE((void*)cur_info > end))
+			return;
+
+		info = le32_to_cpu(*cur_info);
 		/*
 		 * 1'b1: new wcid pair.
 		 * 1'b0: msdu_id with the same 'wcid pair' as above.
-- 
2.20.1

