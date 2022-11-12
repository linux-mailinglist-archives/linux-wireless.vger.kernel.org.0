Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8380B626A52
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Nov 2022 16:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbiKLPld (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Nov 2022 10:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbiKLPlb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Nov 2022 10:41:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3351AF30
        for <linux-wireless@vger.kernel.org>; Sat, 12 Nov 2022 07:41:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6A09B802C3
        for <linux-wireless@vger.kernel.org>; Sat, 12 Nov 2022 15:41:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A65EC433D6;
        Sat, 12 Nov 2022 15:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668267687;
        bh=/4MOeY1uVl3S/GEwimo3FU8kQw/DPZ/HgBqtfub7Ao8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AIt7IQ6G/jtc7CyadF/Ro/AQA5zmPjjgCS3GGZcC9kxKGb529kUgxJvMXR8+IGfiC
         mz+AiyEg/KBDxiD0tu33kxMQvpGziDCZzQgZDVwAOj3p484HdpEsMJFU8SxZ6qN/eh
         LGlLfHM9X1792dj/oFCXGucJn5gNCYkDBpVPIrEwoTsvvhiZ8LIYxAZVdLsBHjFfT2
         0n/l+AIAahaRUxwmFei/DhRRVp73A362W0h1BAdyUVtunqeo6LW2vHOQcYTKMG/aZf
         vzWkhQxVctH5xPwj9ehMZrsix1JkC+oHSxDByJfnjdQ7T0R1VZ3BnA350bdqiBrHKK
         4khhVq0WZkwbw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Bo.Jiao@mediatek.com, sujuan.chen@mediatek.com,
        ryder.Lee@mediatek.com, evelyn.tsai@mediatek.com
Subject: [PATCH 6/8] wifi: mt76: connac: introduce mt76_connac_mcu_sta_wed_update utility routine
Date:   Sat, 12 Nov 2022 16:40:39 +0100
Message-Id: <7a6ae7666adc89c8cf18996d15379b596a1c33a0.1668267241.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1668267241.git.lorenzo@kernel.org>
References: <cover.1668267241.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sujuan Chen <sujuan.chen@mediatek.com>

This is a preliminary patch to introduce WED RX support for mt7915.

Tested-by: Daniel Golle <daniel@makrotopia.org>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 22 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 6b2ce5fd3e4f..ded15f523855 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1218,6 +1218,16 @@ void mt76_connac_mcu_sta_ba_tlv(struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_ba_tlv);
 
+int mt76_connac_mcu_sta_wed_update(struct mt76_dev *dev, struct sk_buff *skb)
+{
+	if (!mtk_wed_device_active(&dev->mmio.wed))
+		return 0;
+
+	return mtk_wed_device_update_msg(&dev->mmio.wed, WED_WO_STA_REC,
+					 skb->data, skb->len);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_wed_update);
+
 int mt76_connac_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif *mvif,
 			   struct ieee80211_ampdu_params *params,
 			   int cmd, bool enable, bool tx)
@@ -1243,6 +1253,10 @@ int mt76_connac_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif *mvif,
 	mt76_connac_mcu_wtbl_ba_tlv(dev, skb, params, enable, tx, sta_wtbl,
 				    wtbl_hdr);
 
+	ret = mt76_connac_mcu_sta_wed_update(dev, skb);
+	if (ret)
+		return ret;
+
 	ret = mt76_mcu_skb_send_msg(dev, skb, cmd, true);
 	if (ret)
 		return ret;
@@ -1253,6 +1267,10 @@ int mt76_connac_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif *mvif,
 
 	mt76_connac_mcu_sta_ba_tlv(skb, params, enable, tx);
 
+	ret = mt76_connac_mcu_sta_wed_update(dev, skb);
+	if (ret)
+		return ret;
+
 	return mt76_mcu_skb_send_msg(dev, skb, cmd, true);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_ba);
@@ -2695,6 +2713,10 @@ int mt76_connac_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
 	if (ret)
 		return ret;
 
+	ret = mt76_connac_mcu_sta_wed_update(dev, skb);
+	if (ret)
+		return ret;
+
 	return mt76_mcu_skb_send_msg(dev, skb, mcu_cmd, true);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_add_key);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index a4893331b7c3..e36cb5ae6ea8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1834,6 +1834,7 @@ int mt76_connac_mcu_set_pm(struct mt76_dev *dev, int band, int enter);
 int mt76_connac_mcu_restart(struct mt76_dev *dev);
 int mt76_connac_mcu_rdd_cmd(struct mt76_dev *dev, int cmd, u8 index,
 			    u8 rx_sel, u8 val);
+int mt76_connac_mcu_sta_wed_update(struct mt76_dev *dev, struct sk_buff *skb);
 int mt76_connac2_load_ram(struct mt76_dev *dev, const char *fw_wm,
 			  const char *fw_wa);
 int mt76_connac2_load_patch(struct mt76_dev *dev, const char *fw_name);
-- 
2.38.1

