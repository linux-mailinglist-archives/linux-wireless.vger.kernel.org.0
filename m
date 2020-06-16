Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6671FBEF4
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 21:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730855AbgFPTZq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 15:25:46 -0400
Received: from p54ae948c.dip0.t-ipconnect.de ([84.174.148.140]:51980 "EHLO
        maeck.local" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729989AbgFPTZq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 15:25:46 -0400
Received: by maeck.local (Postfix, from userid 501)
        id A2D428E50DD0; Tue, 16 Jun 2020 21:25:44 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     shayne.chen@mediatek.com, evelyn.tsai@mediatek.com,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: net: wireless: mt76: add power-limits node
Date:   Tue, 16 Jun 2020 21:25:41 +0200
Message-Id: <20200616192544.97938-1-nbd@nbd.name>
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
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
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

