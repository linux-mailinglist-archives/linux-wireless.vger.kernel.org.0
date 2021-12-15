Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83EC94759FA
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Dec 2021 14:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237571AbhLONwz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Dec 2021 08:52:55 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36540 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237562AbhLONwy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Dec 2021 08:52:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9453E61880
        for <linux-wireless@vger.kernel.org>; Wed, 15 Dec 2021 13:52:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBC5C34604;
        Wed, 15 Dec 2021 13:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639576374;
        bh=NV3q2MqvYdSxXeeChUgtthh2JLk07eza3y7g2kr9zS4=;
        h=From:To:Cc:Subject:Date:From;
        b=K22GTaLzbVJxzfP2jrFot8STT3ZmR2u3QMZvrWWbCSC4MYyQzeHR0ohM4q9ZJ7C5s
         Tg/MJYKckiVtzUiWwYGnfNDVZQiUcth8a8PkwO03L71a+6Gu3SMjfgSXKVJRqIHKO7
         okCG6ekRI9//NOhR3X1VM302ufvm1b2HElMNLuuRWTWPXsFaO4zRaScmOqmc30tGce
         rhUAMnLt9ih1WIPz/aLdDzrAAYRFkLJjTfgVLEABtydYySeauF/XYS5hDTsZxOUADX
         gP3+tI6eDUcgLNOc2HlPgfwjfal11ufA50BimYjdCBUv8AH3OF3+tS82fzsG2iFGeB
         jo482PYIVzQCA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7921: remove dead definitions
Date:   Wed, 15 Dec 2021 14:52:47 +0100
Message-Id: <9ebfeafd3017719670a49fad7db7740b89a2276b.1639576316.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

to_wcid_lo and to_wcid_hi are no longer used in mt7921/mcu.c

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index c4a8fe31197d..46470183057f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -93,9 +93,6 @@ struct mt7921_fw_region {
 #define PATCH_SEC_ENC_SCRAMBLE_INFO_MASK	GENMASK(15, 0)
 #define PATCH_SEC_ENC_AES_KEY_MASK		GENMASK(7, 0)
 
-#define to_wcid_lo(id)			FIELD_GET(GENMASK(7, 0), (u16)id)
-#define to_wcid_hi(id)			FIELD_GET(GENMASK(9, 8), (u16)id)
-
 static enum mcu_cipher_type
 mt7921_mcu_get_cipher(int cipher)
 {
-- 
2.33.1

