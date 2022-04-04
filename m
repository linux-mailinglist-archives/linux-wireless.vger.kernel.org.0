Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229CE4F110E
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Apr 2022 10:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiDDIhl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Apr 2022 04:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiDDIhk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Apr 2022 04:37:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7EF1F60E
        for <linux-wireless@vger.kernel.org>; Mon,  4 Apr 2022 01:35:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B64E86135F
        for <linux-wireless@vger.kernel.org>; Mon,  4 Apr 2022 08:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE13C2BBE4;
        Mon,  4 Apr 2022 08:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649061344;
        bh=hIeNlBvJXIigzzK+7oPz9bVtYRHu1fp9idLEwr1Od0s=;
        h=From:To:Cc:Subject:Date:From;
        b=hKYHR6vX50+1fGWhFyf3i2EQGRy1XGjPB+f79h1akcDsSwcugNkOnqfMlOfoCaWr1
         jAdjWprCoQjoy88umbk1SMfY19NALjW+hmwfdvcQnmP6yApHtQ+8HlE8oa37CnNtxf
         VxuzEfwP4/yq+Ymecp7qrLawIUvLNO5p/ptSdx+kWZ11cXL+5v35koQZWgP/KwuLYl
         ppF5fIcUWEZhcyoMOjGiPqstn/WpXH80CsWwljkjKUSp8AK1R5NY3CS+LlFazJTcd3
         03MGbyvHWRcCRdhjIflWAnKk6KRMct8c2jD84K96KIeiWuxxJihkPP4x0vMSegAUe8
         Azb2YcKgJhsVg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: m7915: do not pass data pointer to mt7915_mcu_muru_debug_set
Date:   Mon,  4 Apr 2022 10:35:39 +0200
Message-Id: <00be55125f91c015d9c791aa2c396877a00dcd57.1649061242.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix typo in mt7915_muru_debug_set routine and pass muru_debug value to
mt7915_mcu_muru_debug_set() instead of data pointer.

Fixes: 1966a5078f2d2 (mt76: mt7915: add mu-mimo and ofdma debugfs knobs")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 4e1ecaec8f4f..dece0a6e00b3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -95,7 +95,7 @@ mt7915_muru_debug_set(void *data, u64 val)
 	struct mt7915_dev *dev = data;
 
 	dev->muru_debug = val;
-	mt7915_mcu_muru_debug_set(dev, data);
+	mt7915_mcu_muru_debug_set(dev, dev->muru_debug);
 
 	return 0;
 }
-- 
2.35.1

