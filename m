Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486B94B77E6
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Feb 2022 21:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241744AbiBOTDl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Feb 2022 14:03:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiBOTDk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Feb 2022 14:03:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3CDF94EF
        for <linux-wireless@vger.kernel.org>; Tue, 15 Feb 2022 11:03:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2669161730
        for <linux-wireless@vger.kernel.org>; Tue, 15 Feb 2022 19:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82EBC340EC;
        Tue, 15 Feb 2022 19:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644951808;
        bh=bU+XSNeXEw3dQu8EQ8qOKR0whVgRrhgqvUxZEqL5MTg=;
        h=From:To:Cc:Subject:Date:From;
        b=SrTBPZ40AFLhgmf3EntTHgGm+5tprZjNcZdrOxU3PLNY3McHMqhU9Py+E71L88uQ3
         OhXWOqaqOKVJA3QhiOqfJQBOqfexPWlssW02MOzggHCBdpEsXmEgjzoPlf0mwWz4CI
         QGwh+rXQHWyGW3wI+SGc5rxmuSGc+RQOitp7dqqDzviqj+G0tseDk9Q3RjMS1XHAbL
         n6NW89SuKW7uyLqZtEP+GKaVoFTMjXx+1Gtd3XsAsyOx0xNkEA8SyO1W3ej9UQd8vI
         nzTqKT01VSj8Rhcag41Rp2fmG2HcXvB586+hNFkWVrqw4nJbzBy4BX9EMiIyJRZDWM
         flc3NarpQNA6w==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7921: fix injected MPDU transmission to not use HW A-MSDU
Date:   Tue, 15 Feb 2022 20:03:19 +0100
Message-Id: <cbcbe78b42b9839662d0a51ec54877e08db63e44.1644951698.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to mt7915 driver, do not aggregate injected frames in
HW A-MSDU block.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 8e88445102ab..ab9acdf6cd74 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -916,6 +916,7 @@ mt7921_mac_write_txwi_80211(struct mt7921_dev *dev, __le32 *txwi,
 		val = MT_TXD3_SN_VALID |
 		      FIELD_PREP(MT_TXD3_SEQ, IEEE80211_SEQ_TO_SN(seqno));
 		txwi[3] |= cpu_to_le32(val);
+		txwi[7] &= ~cpu_to_le32(MT_TXD7_HW_AMSDU);
 	}
 
 	if (mt76_is_mmio(&dev->mt76)) {
-- 
2.35.1

