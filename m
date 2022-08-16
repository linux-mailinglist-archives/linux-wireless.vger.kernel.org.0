Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C039559596A
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Aug 2022 13:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiHPLG5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Aug 2022 07:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbiHPLGk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Aug 2022 07:06:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2AA3A491
        for <linux-wireless@vger.kernel.org>; Tue, 16 Aug 2022 03:32:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43FE2B8169C
        for <linux-wireless@vger.kernel.org>; Tue, 16 Aug 2022 10:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6E2C433D6;
        Tue, 16 Aug 2022 10:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660645936;
        bh=OxawWSQNGh146B7YeJnBuLFop3KY33124+UHtPkz/L0=;
        h=From:To:Cc:Subject:Date:From;
        b=TiuIAv7eYd2B9E+3eG8cehv3MCh4hb2L3iE49jjfSse2Ek/ghgv0VP/l35W7HsIYS
         xrvGtx2jEHi/zKws1+qZha/cffKuIy80NGe6s6NItGG79nfTXt9f0K8YI2GQZRo2pr
         PT8/axAI9NDBmLUq2ERNpM+ux5vq5azo0A31h1BUMEdC4YRwHwrdTqClTqMNPr7g2s
         jIr08crmNSz9nyEqOqSiUZPlOUmDuutsZCIh/gZZhTJHrRjsWfK+sTOMYE7DoiRct6
         /Pv5BSSYqxHD4m297GEanDD6eKd4BFtNJZmnXgwBZ6BiMWyNPaE+rKeWzeYFBd95xV
         o40flXyo6IJTg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: fix uninitialized pointer in mt79{15,21}_mac_fill_rx
Date:   Tue, 16 Aug 2022 12:32:12 +0200
Message-Id: <05aaf0520e876be5e63f3b00295759afabd735d3.1660645902.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.37.2
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

Initialize msta pointer to NULL in mt7921_mac_fill_rx() and
mt7915_mac_fill_rx() in order to not dereference a uninitialized
pointer.

Fixes: 0880d40871d1d ("mt76: connac: move mt76_connac2_reverse_frag0_hdr_trans in mt76-connac module")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index b9b74c706d2c..49aa5c056063 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -232,7 +232,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	bool unicast, insert_ccmp_hdr = false;
 	u8 remove_pad, amsdu_info;
 	u8 mode = 0, qos_ctl = 0;
-	struct mt7915_sta *msta;
+	struct mt7915_sta *msta = NULL;
 	bool hdr_trans;
 	u16 hdr_gap;
 	u16 seq_ctrl = 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 38f4ee93cbe1..fb76ca9d4e10 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -235,7 +235,7 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 	u32 rxd2 = le32_to_cpu(rxd[2]);
 	u32 rxd3 = le32_to_cpu(rxd[3]);
 	u32 rxd4 = le32_to_cpu(rxd[4]);
-	struct mt7921_sta *msta;
+	struct mt7921_sta *msta = NULL;
 	u16 seq_ctrl = 0;
 	__le16 fc = 0;
 	u8 mode = 0;
-- 
2.37.2

