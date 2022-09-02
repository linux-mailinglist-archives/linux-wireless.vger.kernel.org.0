Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C80E5AB424
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236612AbiIBOv1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbiIBOvE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:51:04 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A6B40E2A
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 07:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=l0opTpHt6Rx1DUw/Kr7GdVubMvkd2iqrbkwIVu7k4/I=;
        t=1662127989; x=1663337589; b=UrCqk6MrLUcg8i8kLrwWrKD4Y5vA6F+/c4IjXKZ+CSbqqVG
        aNen9u768kVpSLcQXGtTedc7IzKhHnjXF51TyK1JbnW0O+Q8Oe9iNDM82vNBgyHoiQVITyJ1DhOkA
        dypry/z+iJiTrgD+Q3/NCcDd35UpviYTpGLakosB1xPeLH0g/+fLbqkR9LXimoZ8N8i0rBf0M0sAX
        qWPW9lYIoKVihZV/7+a3sfC2DL0zYvMJmw0AlfNjkH6Q7NT5c+HBJ33jlcCurGxIDo4J5L5IuUBd4
        EWNwKunOQ6ej05GD2cfw4KqlaPVPfbO5Lm7YPNJrlH7LTOZoyVBEA/WO1mlWaG9w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oU7Pu-006Ch3-1l;
        Fri, 02 Sep 2022 16:13:06 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 07/27] wifi: mac80211_hwsim: warn on invalid link address
Date:   Fri,  2 Sep 2022 16:12:39 +0200
Message-Id: <20220902161143.e0f195a3d28e.Ie35415a32f735d579bb26b35d43ab9206da85927@changeid>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220902141259.377789-1-johannes@sipsolutions.net>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Catch the bug fixed in mac80211 by the previous patch
and warn if an invalid address is added (or removed).

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 70a72a03398a..a75420d92816 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -1299,6 +1299,8 @@ static void mac80211_hwsim_config_mac_nl(struct ieee80211_hw *hw,
 	struct sk_buff *skb;
 	void *msg_head;
 
+	WARN_ON(!is_valid_ether_addr(addr));
+
 	if (!_portid && !hwsim_virtio_enabled)
 		return;
 
-- 
2.37.2

