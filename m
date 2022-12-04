Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44462641FF4
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Dec 2022 23:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiLDWBt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Dec 2022 17:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiLDWBs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Dec 2022 17:01:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F5311C0E
        for <linux-wireless@vger.kernel.org>; Sun,  4 Dec 2022 14:01:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A392B807E5
        for <linux-wireless@vger.kernel.org>; Sun,  4 Dec 2022 22:01:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B57C433C1;
        Sun,  4 Dec 2022 22:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670191305;
        bh=OL38pu6k0Cq4VDxe5tTDbLnV+aLjQjzegAImV91ToBI=;
        h=From:To:Cc:Subject:Date:From;
        b=gN2BY+jU/n9hTVgmhM+btfRF8odDTPGrQabxg09Fl3YaGRGu9TRFnRGFkQjoGgmn5
         8hn7tfNlU6s6W61GCnLcttJPj7bi56NdezhGMLeTCGcVcamobJndbi4lrvWkey+bQG
         4OgEUuXdvRTQTi8O8YJqIJ6pOQWST/1fyCsPA576cAU1wUmktasxJxqzH9t/KC+Lzg
         GX7oc5cDd/IzXMBMAfmg7bB4+HpqZJ1qP5KtSrNQn/UKvM403MplqPyw1wQT/Lu7PG
         fnd8/AltG0TThC2aUfxVSBLOC1YqQ41ItnwlVNJpa0Q7wSe4Gsww6d2NCbMtfHa+Vl
         XKpXNwmYxOrUQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt7996: fix endianness warning in mt7996_mcu_sta_he_tlv
Date:   Sun,  4 Dec 2022 23:01:37 +0100
Message-Id: <7d38e22e08067b5d21936b657c049617ef9b7798.1670191161.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
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

Fix the following sparse warnings in mt7996_mcu_sta_he_tlv routine:

warning: incorrect type in assignment (different base types)
   expected unsigned char
   got restricted __le16 [usertype]
warning: incorrect type in assignment (different base types)
   expected unsigned char
   got restricted __le16 [usertype]

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 04e1d10bbd21..79a4d314ebd7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -903,8 +903,8 @@ mt7996_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 	he = (struct sta_rec_he_v2 *)tlv;
 	for (i = 0; i < 11; i++) {
 		if (i < 6)
-			he->he_mac_cap[i] = cpu_to_le16(elem->mac_cap_info[i]);
-		he->he_phy_cap[i] = cpu_to_le16(elem->phy_cap_info[i]);
+			he->he_mac_cap[i] = elem->mac_cap_info[i];
+		he->he_phy_cap[i] = elem->phy_cap_info[i];
 	}
 
 	mcs_map = sta->deflink.he_cap.he_mcs_nss_supp;
-- 
2.38.1

