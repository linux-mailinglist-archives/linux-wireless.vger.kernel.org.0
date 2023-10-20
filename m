Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC5E7D0D2B
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Oct 2023 12:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376871AbjJTKbq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Oct 2023 06:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376855AbjJTKbp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Oct 2023 06:31:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF3BD5B
        for <linux-wireless@vger.kernel.org>; Fri, 20 Oct 2023 03:31:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B88C433C9;
        Fri, 20 Oct 2023 10:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697797903;
        bh=kov4yMSQdmfTBSDB3yLwqivPB51jrQoms4p5iBEYCZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tueI1HPIHRdUV1YnpRIvUnP/LrYAoyS3hwXUGiHJgVS5TYIDjL+jn8zOl6wyBMkpr
         I2/68S53afgAbBVd5UmzZcp5JJCk/vzavkXgE2voaqBSYpSw1MSEJFrPhTP9XXjrW8
         kGHgxBGTIR2N7GphdL2L4JwVtkR5oS50eypaRSHvBTWxt0gOtOmzp9g2WUh/piZeGU
         YUdit2ey8t56qUQZcBFY1Dsv2cgLWjt/t2iTqB8IaN3uOnDmrqL9F7RW+w18/liEOx
         AjAUO/pSo+r2ePJehEq/UDai4vxAZZLSCUQGgyr+ExgDtwGzZ806zZQuSyLH1uE+pZ
         3UdhGbxMkLvVg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        shayne.chen@mediatek.com, Bo.Jiao@mediatek.com,
        sujuan.chen@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH v3 06/13] wifi: mt76: increase MT_QFLAG_WED_TYPE size
Date:   Fri, 20 Oct 2023 12:30:53 +0200
Message-ID: <8dca673261ac27abfd7f471663abfb45c442803e.1697797423.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697797422.git.lorenzo@kernel.org>
References: <cover.1697797422.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to introduce WED support for mt7996

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 8fa0440f1686..fa33ecfbf72d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -29,8 +29,8 @@
 #define MT76_TOKEN_FREE_THR	64
 
 #define MT_QFLAG_WED_RING	GENMASK(1, 0)
-#define MT_QFLAG_WED_TYPE	GENMASK(3, 2)
-#define MT_QFLAG_WED		BIT(4)
+#define MT_QFLAG_WED_TYPE	GENMASK(4, 2)
+#define MT_QFLAG_WED		BIT(5)
 
 #define __MT_WED_Q(_type, _n)	(MT_QFLAG_WED | \
 				 FIELD_PREP(MT_QFLAG_WED_TYPE, _type) | \
-- 
2.41.0

