Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68B7314DD15
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2020 15:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgA3Or2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jan 2020 09:47:28 -0500
Received: from nbd.name ([46.4.11.11]:57476 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727341AbgA3Or2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jan 2020 09:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=g9aUeJxHJTjHeT0DtDV0sRSitvmTT7cydU/tVfhJbTc=; b=PpuuLiduTUs4jWyi3yqCkfssNK
        Rpz95lYkoZsjAoQ5NawIrrcV/ylfBDwyWwere6uHvbaxpYL39u2dYjti07FcfdJyp0lMC5ZbgC3Mt
        QbusBpg2Yz40Xw93LkUdr2XQoOgKnza1UTOjrwukOQB2e/bTIYnhLx1JZgsJwHQzzWWk=;
Received: from [178.162.209.135] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ixB6L-0001Vn-K1; Thu, 30 Jan 2020 15:47:25 +0100
Received: by maeck.local (Postfix, from userid 501)
        id EF3BF7AE4696; Thu, 30 Jan 2020 15:47:18 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     devicetree@vger.kernel.org
Subject: [PATCH 01/15] dt-bindings: net: wireless: mt76: document bindings for MT7622
Date:   Thu, 30 Jan 2020 15:47:04 +0100
Message-Id: <20200130144718.14298-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

MT7622 is a SoC that includes a 2.4 GHz 4x4 802.11n WMAC. Its
feature set is comparable to a MT7615 chip, but limited to 2.4 GHz.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../bindings/net/wireless/mediatek,mt76.txt   | 26 ++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt
index d4d982f7ab37..3a76d8faaaed 100644
--- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt
+++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt
@@ -4,13 +4,21 @@ This node provides properties for configuring the MediaTek mt76xx wireless
 device. The node is expected to be specified as a child node of the PCI
 controller to which the wireless chip is connected.
 
-Alternatively, it can specify the wireless part of the MT7628/MT7688 SoC.
-For SoC, use the compatible string "mediatek,mt7628-wmac" and the following
-properties:
+Alternatively, it can specify the wireless part of the MT7628/MT7688 or
+MT7622 SoC. For SoC, use the following compatible strings:
+
+compatible:
+- "mediatek,mt7628-wmac" for MT7628/MT7688
+- "mediatek,mt7622-wmac" for MT7622
 
+properties:
 - reg: Address and length of the register set for the device.
 - interrupts: Main device interrupt
 
+MT7622 specific properties:
+- power-domains: phandle to the power domain that the WMAC is part of
+- mediatek,infracfg: phandle to the infrastructure bus fabric syscon node
+
 Optional properties:
 
 - ieee80211-freq-limit: See ieee80211.txt
@@ -53,3 +61,15 @@ wmac: wmac@10300000 {
 
 	mediatek,mtd-eeprom = <&factory 0x0000>;
 };
+
+MT7622 example:
+
+wmac: wmac@18000000 {
+	compatible = "mediatek,mt7622-wmac";
+	reg = <0 0x18000000 0 0x100000>;
+	interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_LOW>;
+
+	mediatek,infracfg = <&infracfg>;
+
+	power-domains = <&scpsys MT7622_POWER_DOMAIN_WB>;
+};
-- 
2.24.0

