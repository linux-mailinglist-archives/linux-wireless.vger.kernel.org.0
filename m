Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7985F1BAA
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Oct 2022 12:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiJAKBX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 1 Oct 2022 06:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJAKBV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 1 Oct 2022 06:01:21 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0175E1005D9
        for <linux-wireless@vger.kernel.org>; Sat,  1 Oct 2022 03:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=G0jR/kmi3D6E8l6BWXs/Cn9jNkpkMqJ9kFgTnPRaAD0=; b=mmpngRGw6vZqQLrUon9s5Kw2Eg
        ybDimLfQQInv+dxislq9zVI4EBmSWgL3LuM2OYGr7dUlMdJl3owOT+R3MAyDET274hwyEbkVORPGV
        VYD614qSM8XvRcTaOE38+Q2WLzATnmG4RMiTvaECmYVwJzP9mIEPVSeVR5hTTW3yBr4A=;
Received: from p200300daa7301d00cc0df67a5b51dd3e.dip0.t-ipconnect.de ([2003:da:a730:1d00:cc0d:f67a:5b51:dd3e] helo=localhost.localdomain)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1oeZJ5-009Cby-Ko; Sat, 01 Oct 2022 12:01:15 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, Howard Hsu <howard-yh.hsu@mediatek.com>
Subject: [PATCH] wifi: mac80211: fix decap offload for stations on AP_VLAN interfaces
Date:   Sat,  1 Oct 2022 12:01:13 +0200
Message-Id: <20221001100113.63559-1-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since AP_VLAN interfaces are not passed to the driver, check offload_flags
on the bss vif instead.

Reported-by: Howard Hsu <howard-yh.hsu@mediatek.com>
Fixes: 80a915ec4427 ("mac80211: add rx decapsulation offload support")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/rx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 45d7e71661e3..9b21e7725de2 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4340,6 +4340,7 @@ void ieee80211_check_fast_rx(struct sta_info *sta)
 		.vif_type = sdata->vif.type,
 		.control_port_protocol = sdata->control_port_protocol,
 	}, *old, *new = NULL;
+	u32 offload_flags;
 	bool set_offload = false;
 	bool assign = false;
 	bool offload;
@@ -4455,10 +4456,10 @@ void ieee80211_check_fast_rx(struct sta_info *sta)
 	if (assign)
 		new = kmemdup(&fastrx, sizeof(fastrx), GFP_KERNEL);
 
-	offload = assign &&
-		  (sdata->vif.offload_flags & IEEE80211_OFFLOAD_DECAP_ENABLED);
+	offload_flags = get_bss_sdata(sdata)->vif.offload_flags;
+	offload = offload_flags & IEEE80211_OFFLOAD_DECAP_ENABLED;
 
-	if (offload)
+	if (assign && offload)
 		set_offload = !test_and_set_sta_flag(sta, WLAN_STA_DECAP_OFFLOAD);
 	else
 		set_offload = test_and_clear_sta_flag(sta, WLAN_STA_DECAP_OFFLOAD);
-- 
2.36.1

