Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 231C810B1A1
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2019 15:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfK0OrO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Nov 2019 09:47:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:58246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbfK0OrO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Nov 2019 09:47:14 -0500
Received: from localhost.localdomain.com (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7F3E206F0;
        Wed, 27 Nov 2019 14:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574866034;
        bh=79XvYHMIKCF1v9/aXtFMTviGPAJFroW9KlznpKwAGMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OgZidrlCy9pO3B7T4VgXY3Vn5uSkS/1nn7BB1AJJCFhh7Aedk1xnH1lOYr60gSMoZ
         IQ7t0Lflbmqn9GB/e2WplWAcquJdB6wKoFBgMDhJIC4o0Jh1g6JaRdd2fW9uKcTV3l
         GAmG5vL9gsQe7Abch9JOHvf3gCQysKaWecjaDoLA=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: [PATCH v2 2/2] dt-bindings: net: wireless: mt76: introduce big-endian property
Date:   Wed, 27 Nov 2019 16:46:34 +0200
Message-Id: <1b46b03f6c60c08d29d4c3cc4e2ae0a50af5eb30.1574865558.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1574865558.git.lorenzo@kernel.org>
References: <cover.1574865558.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce big-endian property to specify mtd radio partition endianness

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../devicetree/bindings/net/wireless/mediatek,mt76.txt         | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt
index 7e675dafc256..d4d982f7ab37 100644
--- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt
+++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt
@@ -15,6 +15,8 @@ Optional properties:
 
 - ieee80211-freq-limit: See ieee80211.txt
 - mediatek,mtd-eeprom: Specify a MTD partition + offset containing EEPROM data
+- big-endian: if the radio eeprom partition is written in big-endian, specify
+  this property
 
 The MAC address can as well be set with corresponding optional properties
 defined in net/ethernet.txt.
@@ -31,6 +33,7 @@ Optional nodes:
 			reg = <0x0000 0 0 0 0>;
 			ieee80211-freq-limit = <5000000 6000000>;
 			mediatek,mtd-eeprom = <&factory 0x8000>;
+			big-endian;
 
 			led {
 				led-sources = <2>;
-- 
2.21.0

