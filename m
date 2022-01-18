Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C30349238F
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jan 2022 11:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbiARKNr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Jan 2022 05:13:47 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40362 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiARKNq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Jan 2022 05:13:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DED8F60C95
        for <linux-wireless@vger.kernel.org>; Tue, 18 Jan 2022 10:13:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67080C00446;
        Tue, 18 Jan 2022 10:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642500824;
        bh=RuKrv5GqSo3CGX/bGXYWQFU3mMpH8e8zMlqpuQgzbvA=;
        h=From:To:Cc:Subject:Date:From;
        b=c0utAPNLcKYlH95VfVN3kgNAg4iGGwh4LI+enApeDHIAQNOY3eKdg0JmgzC+aBTzd
         vyPkuFIBFcmzeAJvkMc4X08LkN2sxHZ8OLmcHmSaNTUAarr/spbvQHNAU7adm9tDtt
         VY3azUNC1qTJCSdxGlypHm9ODVhIJKvHGQ9wDNG6dzA6Pxi7RozK80l7KH8P301+VE
         j8BrUiIULgz95aCu5/ghBe7S9P4r8pIjvCQkG7Lj5Amt+075JFpB3nisYfP+IMKvhW
         GK9xaffkJYLk8WQWVGboXu6hVkNiuH7Z7jiwC7VyAVgXTgcydB6GqTl+951vCXMiuW
         KRdEevmUmx5pQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7921: remove duplicated code in mt7921_mac_decode_he_radiotap
Date:   Tue, 18 Jan 2022 11:13:32 +0100
Message-Id: <cc4eb2c69d3bca795b6e5d8f49f55b03eebafc70.1642500762.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove duplicated DATA4_SU_MU_SPTL_REUSE flag configuration in
mt7921_mac_decode_he_radiotap routine.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 7bb976b1b451..d17558349a17 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -308,7 +308,6 @@ mt7921_mac_decode_he_radiotap(struct sk_buff *skb, __le32 *rxv, u32 mode)
 
 		he->data3 |= HE_PREP(DATA3_BEAM_CHANGE, BEAM_CHNG, rxv[14]) |
 			     HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
-		he->data4 |= HE_PREP(DATA4_SU_MU_SPTL_REUSE, SR_MASK, rxv[11]);
 		break;
 	case MT_PHY_TYPE_HE_EXT_SU:
 		he->data1 |= HE_BITS(DATA1_FORMAT_EXT_SU) |
-- 
2.34.1

