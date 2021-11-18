Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705A6455C4D
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 14:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbhKRNLJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 08:11:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:55154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229687AbhKRNLJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 08:11:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1549061ABA;
        Thu, 18 Nov 2021 13:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637240888;
        bh=NlKJr+GJ6puXwjD7OwvuaaRu/3WzWAF9krTqAZL0OLk=;
        h=From:To:Cc:Subject:Date:From;
        b=uywUMOSSkbCtilHk0VxbmLgTie2PEVsJ5ETZM4OZ1b+UEfJVNDSGFDVvXFQ9XJRhX
         oitpqVtNS+aE/uxmQUoPxwe3adwHlIKIW2QtvYJhYMg6AWeYwTdKIjNEtreFFAsn5d
         o2rZrhBn+2zAqdsLQNqhbw24iARHxl9qbQZKQGTWyex1+9a7V9b1FBhOsYvnBezf40
         DxoCDnd/5fFCtDxKbfgK+2P1N7fS8pEkVOycVG0KP8Lk8F+wwUJ20Zz5JzHTEd7kSg
         JUYo5llV0gzybJA52OA3RfOwiB9kNcTySUqs+tEEdGZUYvwKBNJ/nK/wUbT0xkf86E
         I/Oj4fLxQ6Fjg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7615: remove dead code in get_omac_idx
Date:   Thu, 18 Nov 2021 14:07:59 +0100
Message-Id: <03b090a90ea07ed51406956bf0d30243f5cc9189.1637240792.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove always false if condition in get_omac_idx for sta type

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 890d9b07e156..a0e8db0b27f9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -141,9 +141,6 @@ static int get_omac_idx(enum nl80211_iftype type, u64 mask)
 		if (i)
 			return i - 1;
 
-		if (type != NL80211_IFTYPE_STATION)
-			break;
-
 		/* next, try to find a free repeater entry for the sta */
 		i = get_free_idx(mask >> REPEATER_BSSID_START, 0,
 				 REPEATER_BSSID_MAX - REPEATER_BSSID_START);
-- 
2.31.1

