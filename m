Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71EEF41610A
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Sep 2021 16:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241676AbhIWOcD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Sep 2021 10:32:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241666AbhIWOcD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Sep 2021 10:32:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 623AB611C6;
        Thu, 23 Sep 2021 14:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632407431;
        bh=FW/Kh7z2ExvVpG6oSuj8gSrBPWnNsiRHkI+9mpDG5bk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XKAV+Zdqwbn2DlpGvIN/duf3VOu/7uyohpj2zNnhynIJlcOVYHRv5vpE6gxGPSiwO
         0ZU6LaIBzIs2iSZGeKnS+sDJeWqjMg6Uv2B6lF/udjUcurCY315Ca2ZM4jvsCVQXOf
         eAzOpJwmp4v+s8t/P1aeTFdw30YtWdM12EYtYKxafzJCU6w4tkOr9WDVvL1vjh9qjM
         wJFv50t52iijeHG9VL9ioxCPeYUhP49ZgE3/BcS5C3kiXBvzOzTb6HEsfuj7/svrFi
         ZeB+lwzl1/KZkhbEoXPugXEFxx6cpBKfV5d8SZbykfflXVn/OJYXbY8aovMHqnF2Nf
         NDaV14f8CY9bA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, chui-hao.chiu@mediatek.com,
        evelyn.tsai@mediatek.com
Subject: [PATCH v5 4/5] mt76: mt7915: enable twt responder capability
Date:   Thu, 23 Sep 2021 16:29:33 +0200
Message-Id: <b5f8adbd9d36e7b2a58c8f8caa1176e155a803ff.1632406731.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632406731.git.lorenzo@kernel.org>
References: <cover.1632406731.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable TWT support in AP mode

Tested-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Tested-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index ca9d0380d42b..11bd9b4686ed 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -699,6 +699,8 @@ mt7915_init_he_caps(struct mt7915_phy *phy, enum nl80211_band band,
 
 		switch (i) {
 		case NL80211_IFTYPE_AP:
+			he_cap_elem->mac_cap_info[0] |=
+				IEEE80211_HE_MAC_CAP0_TWT_RES;
 			he_cap_elem->mac_cap_info[2] |=
 				IEEE80211_HE_MAC_CAP2_BSR;
 			he_cap_elem->mac_cap_info[4] |=
-- 
2.31.1

