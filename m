Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36414220D92
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2020 15:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbgGONBk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jul 2020 09:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgGONBk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jul 2020 09:01:40 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05162C061755
        for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2020 06:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=pivfQbDXNPRL1qq0rFiuOkRxQTRlTI7QE0TCm+MsbXk=; b=qlJkJ4upTKLxMA42NTIOoVfsZa
        GgIt7tXEJ7JTMrogl0oRMmHSoEjSssyjSI18oOuYmwu52v+OdIHpVmlhPGxiyVs7c8FRS1Lu5Xs0O
        qCRR8Ak4+h0aRV6RGkEcc42hsfHP6HLHegM24jaK1PiGBvYWD+4utKzn4Td2a9QGPVI8=;
Received: from p5b2068d4.dip0.t-ipconnect.de ([91.32.104.212] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jvh2V-0000ux-IH; Wed, 15 Jul 2020 15:01:35 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     devicetree@vger.kernel.org, evelyn.tsai@mediatek.com,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v3 1/4] dt-bindings: net: wireless: mt76: add power-limits node
Date:   Wed, 15 Jul 2020 15:01:34 +0200
Message-Id: <20200715130134.34988-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This subnode can be used to set per-rate tx power limits either per
country code / regdomain or globally.
These limits are typically provided by the device manufacturers and are
used to limit sideband emissions and stay within regulatory limits

Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
v3:
 - fix S-o-b order
v2:
 - merge 802.11ax rate changes from Shayne's patch
 - document txs-delta property

 .../bindings/net/wireless/mediatek,mt76.txt   | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt
index ab7e7a00e534..e4859c974ef4 100644
--- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt
+++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt
@@ -36,6 +36,7 @@ Optional nodes:
 - led: Properties for a connected LED
   Optional properties:
     - led-sources: See Documentation/devicetree/bindings/leds/common.txt
+- power-limits: contains per-regdomain/channel rate power limit subnodes
 
 &pcie {
 	pcie0 {
@@ -76,3 +77,61 @@ wmac: wmac@18000000 {
 
 	power-domains = <&scpsys MT7622_POWER_DOMAIN_WB>;
 };
+
+
+Subnodes of power-limits:
+
+Properties:
+- country: One or more country codes, as used by the cfg80211 regdomain code
+- regdomain: "FCC", "ETSI" or "JP"
+
+If neither country, nor regdomain is specified, the power limits node is used
+as a fallback when no other subnode matches.
+
+Subnodes txpower-2g, txpower-5g:
+
+Properties:
+- channels: pairs of first and last channel number
+- cck: 4 half-dBm per-rate power limit values
+- ofdm: 8 half-dBm per-rate power limit values
+- mcs:
+	sets of per-rate power limit values for 802.11n/802.11ac rates for
+	multiple channel bandwidth settings.
+	Each set starts with the number of channel bandwidth settings for
+	which the rate set applies, followed by either 8 (MT7603/MT7628) or
+	10 (all other chips) power limit values.
+	The order of the channel bandwidth settings is: 20, 40, 80, 160 MHz.
+- ru:
+	sets of per-rate power limit values for 802.11ax rates for multiple
+	channel bandwidth or resource unit settings.
+	Each set starts with the number of channel bandwidth or resource unit
+	settings for which the rate set applies, followed by 12 power limit
+	values. The order of the channel resource unit settings is:
+	RU26, RU52, RU106, RU242/SU20, RU484/SU40, RU996/SU80, RU2x996/SU160.
+- txs-delta: half-dBm power delta for different numbers of antennas (1, 2, ...)
+
+
+power-limit example:
+
+power-limits {
+	r0 {
+		regdomain = "FCC";
+		txpower-5g {
+			r1 {
+				channels = <36 48>;
+				ofdm = <23 23 23 23 23 23 23 23>;
+				mcs = <1 23 23 23 23 23 23 23 23 23 23>,
+					  <3 22 22 22 22 22 22 22 22 22 22>;
+				ru = <3 22 22 22 22 22 22 22 22 22 22 22 22>,
+				     <4 20 20 20 20 20 20 20 20 20 20 20 20>;
+			};
+			r2 {
+				channels = <100 181>;
+				ofdm = <14 14 14 14 14 14 14 14>;
+				mcs = <4 14 14 14 14 14 14 14 14 14 14>;
+				txs-delta = <12 9 6>;
+				ru = <7 14 14 14 14 14 14 14 14 14 14 14 14>;
+			};
+		};
+	};
+};
-- 
2.24.0

