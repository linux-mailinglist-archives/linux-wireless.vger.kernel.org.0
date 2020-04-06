Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 147BD19F376
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2020 12:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgDFKWI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Apr 2020 06:22:08 -0400
Received: from nbd.name ([46.4.11.11]:57840 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbgDFKWH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Apr 2020 06:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=stOOqEyUv4RRmS97Ea4UT3risNNN7iloTEIIRHO3zB8=; b=XmJk/5fGejWRehnHl336UopYCH
        b17zhp0pc/kdiNSg46hAW5Twz4KRS+9uY1nO7XOE+Mzfe9TiSXHVpx20EprstEBFmuQncFzxWEYjh
        p8mXKFfejQvNCVWW+1hVul7Eghj4NpJj88pGceTKElN0F/vb1+q85PcPDOJktG1gMFlw=;
Received: from [80.255.7.105] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jLOtJ-0001gX-Ng; Mon, 06 Apr 2020 12:22:05 +0200
Received: by maeck.local (Postfix, from userid 501)
        id 9DE0C81E8917; Mon,  6 Apr 2020 12:22:03 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     devicetree@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: net: wireless: mt76: document mediatek,eeprom-merge-otp property
Date:   Mon,  6 Apr 2020 12:22:00 +0200
Message-Id: <20200406102203.54450-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It is used to enable merging of Flash EEPROM data with OTP ROM calibration.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../devicetree/bindings/net/wireless/mediatek,mt76.txt         | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt
index 3a76d8faaaed..ab7e7a00e534 100644
--- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt
+++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt
@@ -25,6 +25,9 @@ Optional properties:
 - mediatek,mtd-eeprom: Specify a MTD partition + offset containing EEPROM data
 - big-endian: if the radio eeprom partition is written in big-endian, specify
   this property
+- mediatek,eeprom-merge-otp: Merge EEPROM data with OTP data. Can be used on
+  boards where the flash calibration data is generic and specific calibration
+  data should be pulled from the OTP ROM
 
 The MAC address can as well be set with corresponding optional properties
 defined in net/ethernet.txt.
-- 
2.24.0

