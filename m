Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BAF2AD48C
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Nov 2020 12:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgKJLRu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 06:17:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:36966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgKJLRt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 06:17:49 -0500
Received: from lore-desk.redhat.com (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63FC720659;
        Tue, 10 Nov 2020 11:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605007069;
        bh=+JRHlucIhOac1nwbqpUbYX2XWg7isr84rukfn7SwVY0=;
        h=From:To:Cc:Subject:Date:From;
        b=nzL3b0o2V6B/Sc6msurdg2mE9gvEMet0vs9CL+6sz4hnF+hXoi1MGcoVufxOuIO0H
         KDSSzkzxU6T+ybiOFAsrJOtl2l1MP86c3FpbM/2F8Ck7UndLxnoYc2ZuEj8Cea90TL
         i9C63ivciEEyHufbJyQCqgckVeK/xBNYcKh/ZNn8=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7915: rely on eeprom definitions
Date:   Tue, 10 Nov 2020 12:17:37 +0100
Message-Id: <f040e0aa18f35e77df68a460c471b596f6b6d2c7.1605006779.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to make the code more readable, rely on mt7915_eeprom_field
definitions for eeprom parsing

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index cf3caa032038..35954a499b33 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -29,10 +29,10 @@ static int mt7915_eeprom_load(struct mt7915_dev *dev)
 
 static int mt7915_check_eeprom(struct mt7915_dev *dev)
 {
-	u16 val;
 	u8 *eeprom = dev->mt76.eeprom.data;
+	u16 val;
 
-	mt7915_eeprom_read(dev, 0);
+	mt7915_eeprom_read(dev, MT_EE_CHIP_ID);
 	val = get_unaligned_le16(eeprom);
 
 	switch (val) {
-- 
2.26.2

