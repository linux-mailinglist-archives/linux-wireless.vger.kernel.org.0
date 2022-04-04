Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFE84F10D5
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Apr 2022 10:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240848AbiDDIZU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Apr 2022 04:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbiDDIZT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Apr 2022 04:25:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB143B3FC
        for <linux-wireless@vger.kernel.org>; Mon,  4 Apr 2022 01:23:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF273B80954
        for <linux-wireless@vger.kernel.org>; Mon,  4 Apr 2022 08:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71ABAC2BBE4;
        Mon,  4 Apr 2022 08:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649060601;
        bh=PczamsGS0GGTyyfEvhPGtt8IuV1VJUi+qlXZlWWLAD8=;
        h=From:To:Cc:Subject:Date:From;
        b=eqbVWaabbk7nfs6ds1blkdGYamCJE7OiBF7sfwYPAP4khzHMHf7QvJrJU/sig3+ko
         AsHwUV5kiEGz/TrlNFwIExpZ8WGX/bdVxD9JamILHLtK9W9TDFazmiyGSwSwUMFC61
         Qa0fxe7zPKv8PMWDNzEpSXcYzgul+r0ArLDCDq7nmAnkhcrOoWaqvg8U16XcG4JQZk
         AzU2XrC/Zui3c3Nffzbz3HldDJILuQhJ5FsdtbIa123BWEl9rsAJXT83zu/7M440dR
         6iYVHmFmQDTnJOFdS3p2EUuFhfWxrykQRB44WICqRLKRfK8xp/vj8lnH+HI91zdwu+
         UnP9aQnMqvaHA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7915: fix possible NULL pointer dereference in mt7915_mac_fill_rx_vector
Date:   Mon,  4 Apr 2022 10:23:15 +0200
Message-Id: <5018ef051a6f9bdc1869faa35f7666aafb5e36f4.1649060544.git.lorenzo@kernel.org>
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

Fix possible NULL pointer dereference in mt7915_mac_fill_rx_vector
routine if the chip does not support dbdc and the hw reports band_idx
set to 1.

Fixes: 78fc30a21cf11 ("mt76: mt7915: move testmode data from dev to phy")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index a8df65cc115f..5ccdfa89bef6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -864,8 +864,11 @@ mt7915_mac_fill_rx_vector(struct mt7915_dev *dev, struct sk_buff *skb)
 	int i;
 
 	band_idx = le32_get_bits(rxv_hdr[1], MT_RXV_HDR_BAND_IDX);
-	if (band_idx && !phy->band_idx)
+	if (band_idx && !phy->band_idx) {
 		phy = mt7915_ext_phy(dev);
+		if (!phy)
+			goto out;
+	}
 
 	rcpi = le32_to_cpu(rxv[6]);
 	ib_rssi = le32_to_cpu(rxv[7]);
@@ -890,8 +893,8 @@ mt7915_mac_fill_rx_vector(struct mt7915_dev *dev, struct sk_buff *skb)
 
 	phy->test.last_freq_offset = foe;
 	phy->test.last_snr = snr;
+out:
 #endif
-
 	dev_kfree_skb(skb);
 }
 
-- 
2.35.1

