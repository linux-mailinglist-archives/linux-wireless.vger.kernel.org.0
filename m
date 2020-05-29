Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538931E837C
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 18:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgE2QTf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 12:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgE2QTd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 12:19:33 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0825AC03E969
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2020 09:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=AylzNCRVoQbwIAp6arjQA9caBIZ3bOW9933qSf24gyE=; b=ErFV4aKkxTpdawqH5VUVhccEF9
        S/Y+MqMnwHWzBt9hoMmlyaoYlxVcjYz09IHgkVaaA3dDKzIAsGFG2J2u9bThIXEr3jqY8gyjfFZWy
        PF8MNGLJWz6Krf/2ExHLygtQdEvlC0NCEL0Tkr4OQE7Ck/HG2521C5TIRZoCFTKQGDfo=;
Received: from p4ff13c20.dip0.t-ipconnect.de ([79.241.60.32] helo=maeck.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jehjG-0007eI-PN; Fri, 29 May 2020 18:19:30 +0200
Received: by maeck.lan (Postfix, from userid 501)
        id BD5F98917448; Fri, 29 May 2020 18:19:29 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     devicetree@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: net: wireless: mt76: add power-limits node
Date:   Fri, 29 May 2020 18:19:27 +0200
Message-Id: <20200529161929.24751-1-nbd@nbd.name>
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

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../bindings/net/wireless/mediatek,mt76.txt   | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt
index ab7e7a00e534..9d9ace0cfbf9 100644
--- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt
+++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt
@@ -36,6 +36,7 @@ Optional nodes:
 - led: Properties for a connected LED
   Optional properties:
     - led-sources: See Documentation/devicetree/bindings/leds/common.txt
+- power-limits: contains per-regdomain/channel rate power limit subnodes
 
 &pcie {
 	pcie0 {
@@ -76,3 +77,49 @@ wmac: wmac@18000000 {
 
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
+			};
+			r2 {
+				channels = <100 181>;
+				ofdm = <14 14 14 14 14 14 14 14>;
+				mcs = <4 14 14 14 14 14 14 14 14 14 14>;
+			};
+		};
+	};
+};
-- 
2.24.0

