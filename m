Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848AD1BE65B
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2020 20:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgD2SjI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Apr 2020 14:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2SjI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Apr 2020 14:39:08 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B09C03C1AE
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2020 11:39:06 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id r26so3159926wmh.0
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2020 11:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=2b18ysXI32I8mHEzjma7PL/yS9Aub1eqd1HMHVebyB4=;
        b=J35UU2p9u1+cHQRXZPr/wVc9wtLHvFS/uQwBXFnd6IVNAmOV73DJ7v70bUsHCXL1KU
         IyEGsAvDLYkCVLxiBFYXJ373FM0rtaMhskvdzdn4Cs8RdlOjMc3zUHo4NY/9VbMUhzWp
         y/SOE0lLpVxrBdW/Mj6Oq6x2LZ6I80kLNa9SZvDtGGXDR82SmmwBMhPntpJKUiRTgYqi
         etBJThCWQ4vsstuxFcTE+B2szQp4niRwvwwwbKaXkq729mmrFuWLBQf6GDiENaTfgR7/
         qJ2W3UnJS1O2qaAdyU52Otvjg6dcLi9d+DmKn/NPW5ZWxy+Fn9p7a+T4Yr3qyl8DojeG
         3E1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=2b18ysXI32I8mHEzjma7PL/yS9Aub1eqd1HMHVebyB4=;
        b=o9Yb7rkjwGL8jZP03oVSvO9LBq27vWxGV4ShwRNJQRp6wp1bykTsOrpj8HpqSGcCZu
         YV+QQ9WqZlXPzGxZdR5v9E2R1onT2T415C8QFxrDPRxijjGkmk3EfvlB/WsWB7faEJn9
         oUj7ysu7RLk0hENKw46Cxw1NeYn2X5rVcSE983RvZUyg0ezjhdniOStnYckJEd2aE/Jo
         C4VDBGN1RccYHFXjM5Jpz4wUaGLNUP6yt9nAKPUh/pZlsxbIegahlmakakdJKtseO3hy
         Bj81M3UZJG8OTGjoXWlAmiokoGWE1pkXv6TTbL9UdLnrnA9ZRiBPSRcXl/IJcH5Qa3v1
         2dnQ==
X-Gm-Message-State: AGi0PuZiTEL3dmY7cuqJhIue3FGBbabyX4PMfVbG4mdxF1EioKdrGVRc
        SR8vn1L4PmnRPCX+IGgtTo/hKPyC
X-Google-Smtp-Source: APiQypLEXo2qyodrHD3T4LGV0PDMnIAeChRnBgROobFW6BWed6hg92O1RPKer2m/T9QqLNPo3XnMcA==
X-Received: by 2002:a1c:a9c3:: with SMTP id s186mr4686917wme.89.1588185545469;
        Wed, 29 Apr 2020 11:39:05 -0700 (PDT)
Received: from [192.168.43.18] (188.29.164.11.threembb.co.uk. [188.29.164.11])
        by smtp.gmail.com with ESMTPSA id f23sm8632510wml.4.2020.04.29.11.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 11:39:04 -0700 (PDT)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org, Oscar Carter <oscar.carter@gmx.com>
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 1/3] staging: vt6656: vnt_set_keymode simplify key modes.
Message-ID: <0eb6f5bb-f756-ab1d-5b63-db9b0dc422da@gmail.com>
Date:   Wed, 29 Apr 2020 19:39:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Unused macros and onfly_latch are removed and others contain
to actual key_type value is or-ed with key_mode.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/key.c | 25 +++++++++----------------
 drivers/staging/vt6656/key.h | 13 +++++++------
 2 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/vt6656/key.c b/drivers/staging/vt6656/key.c
index ac3b188984d0..47338077c033 100644
--- a/drivers/staging/vt6656/key.c
+++ b/drivers/staging/vt6656/key.c
@@ -35,7 +35,7 @@ int vnt_key_init_table(struct vnt_private *priv)
 
 static int vnt_set_keymode(struct ieee80211_hw *hw, u8 *mac_addr,
 			   struct ieee80211_key_conf *key, u32 key_type,
-			   u32 mode, bool onfly_latch)
+			   u32 mode)
 {
 	struct vnt_private *priv = hw->priv;
 	u8 broadcast[6] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
@@ -68,17 +68,11 @@ static int vnt_set_keymode(struct ieee80211_hw *hw, u8 *mac_addr,
 		entry = MAX_KEY_TABLE - 1;
 		key->hw_key_idx = entry;
 		/* fall through */
-	case VNT_KEY_ALLGROUP:
-		key_mode |= VNT_KEY_ALLGROUP;
-		if (onfly_latch)
-			key_mode |= VNT_KEY_ONFLY_ALL;
-		/* fall through */
 	case VNT_KEY_GROUP_ADDRESS:
-		key_mode |= mode;
-		/* fall through */
+		key_mode = mode | (mode << 4);
+		break;
 	case VNT_KEY_GROUP:
-		key_mode |= (mode << 4);
-		key_mode |= VNT_KEY_GROUP;
+		key_mode = mode << 4;
 		break;
 	case  VNT_KEY_PAIRWISE:
 		key_mode |= mode;
@@ -88,8 +82,7 @@ static int vnt_set_keymode(struct ieee80211_hw *hw, u8 *mac_addr,
 		return -EINVAL;
 	}
 
-	if (onfly_latch)
-		key_mode |= VNT_KEY_ONFLY;
+	key_mode |= key_type;
 
 	if (mode == KEY_CTL_WEP) {
 		if (key->keylen == WLAN_KEY_LEN_WEP40)
@@ -126,7 +119,7 @@ int vnt_set_keys(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
 			vnt_mac_disable_keyentry(priv, u);
 
 		vnt_set_keymode(hw, mac_addr, key, VNT_KEY_DEFAULTKEY,
-				KEY_CTL_WEP, true);
+				KEY_CTL_WEP);
 
 		key->flags |= IEEE80211_KEY_FLAG_GENERATE_IV;
 
@@ -152,10 +145,10 @@ int vnt_set_keys(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
 
 	if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE)
 		vnt_set_keymode(hw, mac_addr, key, VNT_KEY_PAIRWISE,
-				key_dec_mode, true);
+				key_dec_mode);
 	else
-		vnt_set_keymode(hw, mac_addr, key, VNT_KEY_GROUP_ADDRESS,
-				key_dec_mode, true);
+		vnt_set_keymode(hw, mac_addr, key,
+				VNT_KEY_GROUP_ADDRESS, key_dec_mode);
 
 	return 0;
 }
diff --git a/drivers/staging/vt6656/key.h b/drivers/staging/vt6656/key.h
index 918c07cf86cd..1f3449e66143 100644
--- a/drivers/staging/vt6656/key.h
+++ b/drivers/staging/vt6656/key.h
@@ -25,13 +25,14 @@
 #define KEY_CTL_TKIP        0x02
 #define KEY_CTL_CCMP        0x03
 
-#define VNT_KEY_DEFAULTKEY	0x1
-#define VNT_KEY_GROUP_ADDRESS	0x2
-#define VNT_KEY_ALLGROUP	0x4
-#define VNT_KEY_GROUP		0x40
-#define VNT_KEY_PAIRWISE	0x00
-#define VNT_KEY_ONFLY		0x8000
 #define VNT_KEY_ONFLY_ALL	0x4000
+#define VNT_KEY_ONFLY		0x8000
+#define VNT_KEY_ALLGROUP	0x04
+#define VNT_KEY_GROUP		0x40
+#define VNT_KEY_PAIRWISE	VNT_KEY_ONFLY
+#define VNT_KEY_GROUP_ADDRESS	(VNT_KEY_ALLGROUP | VNT_KEY_GROUP)
+#define VNT_KEY_DEFAULTKEY	(VNT_KEY_GROUP_ADDRESS | VNT_KEY_ONFLY |\
+				VNT_KEY_ONFLY_ALL)
 
 int vnt_key_init_table(struct vnt_private *priv);
 
-- 
2.25.1
