Return-Path: <linux-wireless+bounces-13256-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 154DA9880E9
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2024 10:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C632837D1
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2024 08:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8ECE18A6B1;
	Fri, 27 Sep 2024 08:55:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9EE18A6BC
	for <linux-wireless@vger.kernel.org>; Fri, 27 Sep 2024 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727427306; cv=none; b=R5h3tCQ2cz1/WNfBchb1gFA+Jm9Bo/DhcdoH7BmC/kWhwkWodJPgWWeBticTXHcVA5WW3u22IQqJYLmW9S61QVbhgXhr91XWkAvE7D/Geqjiv1hebwe7s92Rfx8sC7MjQ3K9GI5neoZrD0Ta+44HN9FBcwgi5WljnmeneZ39K3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727427306; c=relaxed/simple;
	bh=gztgcmze25q8vnPHgWieMrU4NG1DAaoB6+zVATQCOqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sg8AQxsiB0Xzrx4UTcHxH1jfmZGo6kthVtqN5FmtN42kyIIu1Qul4vtsepLWqN4DPp30TCtnaBwkfjKtDywBTqDiMB2iBqtwf2m9klH2AimhDaM0bNZTrUtyhN5HMB7/sd4/5lzxkTiAk3P9Ry7urLvMgyDhbtsxW7x5UgQKODs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr; spf=pass smtp.mailfrom=green-communications.fr; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=green-communications.fr
Received: from evilbit.green-communications.fr ([88.171.60.104]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis)
 id 1Mt6wz-1s5rbf2vSj-011B10; Fri, 27 Sep 2024 10:54:26 +0200
From: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: Rany Hany <rany_hany@riseup.net>,
	linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt7915: Fix mesh scan on MT7916 DBDC
Date: Fri, 27 Sep 2024 10:53:17 +0200
Message-ID: <20240927085350.4594-1-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WNTb3PEnhm51fGgebWlKsDbVVi2c3BiT9D7ky7SKmMtN8DRiFMC
 Xp5IhkFUSQagz0klxryY78t80y2j1B1ZJSUtPvLAD7zdwTgzy5kn1AVygmjxQQlLoiCrXIU
 Lzg/V5/W4HdrKblHk6q+8KE12w1MxUc8Hxs8rxBrCut2Td9CuhK1704duH58eICSOepnRXB
 q/7vHM003x6qiCyuAYeXw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mKI+GyfKpU4=;eKu+g4iLZtLW8YlUycwy84GBnzs
 bPHlrzKf+p+LouuY7r4bsshSI2Yb9nr9/V4dvS054bTby2cgkNyYE3QyLphhQZe74XQbHakQ/
 Ip77y44p8DztrqreD+aitSJP/zlKARZKF1V/CxjQvPKlp/3kV40J514yzIJ/x8iyQwOkugiUc
 v4IEkmqC4S/xwb1EJlYAVaqAsxwwQRuR535/tug6a49iZR6sxRVT5FCOXbNGxuUbSIixrGZum
 8M0ZbBjexuj2XpM8VkXnpn7bqI1quV/O/J5TNH0/vBQC7zAOsvesjwR3N/5gMg5AhQR8wmnNP
 VwjLXb1lO994IJvY7JSNAzss3onFpHMifp4K0UKdWy05Rjb8LQcV/BFXmINVbOCtA4yJBUgyj
 xRbWZCorAx54Rm1k1zY9CekwtgOgJef/qZUVAf+wqC/GRG/C/agXW3bwVfoEs70Of+0m7kbYo
 n/+B8q3HoM4rfSFTrhfEEdMP/LZSnaGXfD7H9cyxPOMzCNtIWqOaThZRqJHJB4T+7XgQ39C7L
 /bTi1cl9awakdhbobw2JXO77+Dif28T/mzbgiFO6r5aSD1Tdsaqu8h5jGr8o0NHZ80Kv+7v1k
 u76N/oTtbV0XZ56w2nIKhW83oYjti/++75OFKV9FbTzcRo/2i9UyXNEUKHArdvJ0f4Rd5FKbv
 ao+zHlSB8JE9B2bux5SxC/8k7nH+6cCI65XAci0uEhN1SBSF3B4AGdmoytIf0rJwWRqy/1mP5
 qI+VGRATkTtl2KFSpX+uSwyNvMI6C9xyw==

commit c4f075582304 ("wifi: mt76: mt7915: fix command timeout in AP stop
period") changes the behavior of mt7915_bss_info_changed() in mesh mode
when enable_beacon becomes false: it calls mt7915_mcu_add_bss_info(...,
false) and mt7915_mcu_add_sta(..., false) while the previous code
didn't.  These sends mcu commands that apparently confuse the firmware.

This breaks scanning while in mesh mode on AsiaRF MT7916 DBDC-based cards:
scanning works but no mesh frames get sent afterwards and the firmware
seems to be hosed.  It breaks on MT7916 DBDC but not on MT7915 DBDC.

Fixes: c4f075582304 ("wifi: mt76: mt7915: fix command timeout in AP stop period")
Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>

---
PS: I have no idea what's happening here.
---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index d75e8dea1fbd..b7884772e2f4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -619,8 +619,9 @@ static void mt7915_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_ASSOC)
 		set_bss_info = vif->cfg.assoc;
 	if (changed & BSS_CHANGED_BEACON_ENABLED &&
+	    info->enable_beacon &&
 	    vif->type != NL80211_IFTYPE_AP)
-		set_bss_info = set_sta = info->enable_beacon;
+		set_bss_info = set_sta = 1;
 
 	if (set_bss_info == 1)
 		mt7915_mcu_add_bss_info(phy, vif, true);

base-commit: 6bba05d651ef77f2c3f3c67b9ace093fee4e01e1
-- 
2.45.2


