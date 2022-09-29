Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1175EF873
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Sep 2022 17:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbiI2PPe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Sep 2022 11:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiI2PPd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Sep 2022 11:15:33 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBCBF962E
        for <linux-wireless@vger.kernel.org>; Thu, 29 Sep 2022 08:15:31 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.179])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id DFE952006C;
        Thu, 29 Sep 2022 15:15:29 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A3BC1AC007A;
        Thu, 29 Sep 2022 15:15:29 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 0DF2413C2B0;
        Thu, 29 Sep 2022 08:15:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0DF2413C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1664464529;
        bh=a82NZpNM2XqN9NMLXMML8VSmIpuj6XiCTB9HcJ8sQKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HNIIide954zRRBplElULF/98q7vV4nP7JZbFCa+2xBgH1ojsmxyg4xyG/iQxf8h36
         TETM+lY4AJrARBPfQ6FIqPNmS5WN7aDzLXMO9aNWlbtGGHuUmqwUz80+9+GgljYeaq
         XPKKCBI6J7929w0cZ1AIsB9kxY/lJ1dAyJZ/An2o=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     nbd@nbd.name, Ben Greear <greearb@candelatech.com>
Subject: [PATCH 2/2] wifi: mt76: mt7915: add two additional errors to ack-failure mask.
Date:   Thu, 29 Sep 2022 08:15:26 -0700
Message-Id: <20220929151526.9559-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220929151526.9559-1-greearb@candelatech.com>
References: <20220929151526.9559-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1664464530-JeCLJNR05JiN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

These other two bits also indicate tx failure as far as I can tell from
reading the documents.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
index 67ce216fb564..075048ab784f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
@@ -133,10 +133,12 @@ enum {
 #define MT_TXS0_TXOP_TIMEOUT		BIT(20)
 #define MT_TXS0_BIP_ERROR		BIT(19)
 
+#define MT_TXS0_TXOP_LIMIT		BIT(20)
+#define MT_TXS0_BIP_OR_BF_ERROR		BIT(19)
 #define MT_TXS0_QUEUE_TIMEOUT		BIT(18)
 #define MT_TXS0_RTS_TIMEOUT		BIT(17)
 #define MT_TXS0_ACK_TIMEOUT		BIT(16)
-#define MT_TXS0_ACK_ERROR_MASK		GENMASK(18, 16)
+#define MT_TXS0_ACK_ERROR_MASK		GENMASK(20, 16)
 
 #define MT_TXS0_TX_STATUS_HOST		BIT(15)
 #define MT_TXS0_TX_STATUS_MCU		BIT(14)
-- 
2.20.1

