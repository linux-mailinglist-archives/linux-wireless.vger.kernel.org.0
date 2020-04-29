Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75ACA1BE693
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2020 20:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgD2SsS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Apr 2020 14:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2SsS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Apr 2020 14:48:18 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391BFC03C1AE
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2020 11:48:18 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x17so3814862wrt.5
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2020 11:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=CDyB54AjrNjFSRl8MhLod74ljRZRfy3XowXumg1NuYA=;
        b=RFScoR6J8meDk+PuK2qeAGbRkEVzZHhD1uzBwEJ3DQIcVuxphdWlDVf0fgX2hJIqBx
         YTz6jzAXFrAfbNp47ifFA2RHHuWlxI9AIinVzfZPApdRnXhllA5zFbpzSnfuRilh8jhG
         skmXqtlsKN1kxXtdIrVJXiLYbKYSbauT0rT0uuy3Mmx+5rdUj41bDCsHOBjB4rz+jmFQ
         Qgi6AgskeaeEHq70tSzHYCON5fAPq5ctWxmzLifGl26WCWnUatDX9Ll1iCLpjQivmWSq
         Z1hgFT8YHzZtM8kXgf77XOOYVfWf7TNswDuplPDs1/PQdSBrhjvcW//GfxvLLQMtHeRt
         J6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=CDyB54AjrNjFSRl8MhLod74ljRZRfy3XowXumg1NuYA=;
        b=fKg2SUtTholUbp5K2vEoKjXj16w2HFwFYNjdvltFcp0dZOD2YjfU041yxh/hy4j8r6
         7Y9o2DQOS5HbuBYICwhwoh38afF33FvomgX/t86LiBRkeGtVOulhsXSOyoEePlknoPIw
         buSt6EhtL1qkZAk/V+JlA9FTJ4U0yBsJgOjxRmhFvzsAng4tmCPbCBHJGroB/6kq4ajW
         JPGAbhDK7UCJotrTjK/sD/Ju/4iv96DQQ2iFtBQ4pMf94PxJiYxkFxgRG/Yuj24WOKkz
         fVthrQzLQ87x5bABGgHMLKc/2noS8dx5nRu1on6lWUys1PxJQKZ+Als+njv4zPjikxG8
         9m9A==
X-Gm-Message-State: AGi0PubOtYqVnByTFD3T1DShJ+RQzI5EZ4EBmspHKWg/qarRgI7m95sy
        Uo4zwEY31GU4zikoxTlMUMo=
X-Google-Smtp-Source: APiQypK15N3MYMdXuYh567Rs8EzSzfvFBlvE/iyAcEzmCfK8JKzNtPKARNjeW+aRpjc3w8l3d/RF+g==
X-Received: by 2002:adf:e5c8:: with SMTP id a8mr44341553wrn.56.1588186096957;
        Wed, 29 Apr 2020 11:48:16 -0700 (PDT)
Received: from [192.168.43.18] (188.29.164.11.threembb.co.uk. [188.29.164.11])
        by smtp.gmail.com with ESMTPSA id 17sm8790455wmo.2.2020.04.29.11.48.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 11:48:16 -0700 (PDT)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org, Oscar Carter <oscar.carter@gmx.com>
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 3/3] staging: vt6656: return all key calls to mac80211 stack.
Message-ID: <f1be8ba0-9513-55cb-de9d-dcd4341e5b78@gmail.com>
Date:   Wed, 29 Apr 2020 19:48:14 +0100
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

vnt_mac_set_keyentry can return USB calls so return them to
mac80211.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/key.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/vt6656/key.c b/drivers/staging/vt6656/key.c
index de54cc3ff95a..c66cb53cfc09 100644
--- a/drivers/staging/vt6656/key.c
+++ b/drivers/staging/vt6656/key.c
@@ -91,9 +91,8 @@ static int vnt_set_keymode(struct ieee80211_hw *hw, u8 *mac_addr,
 			key->key[15] |= 0x80;
 	}
 
-	vnt_mac_set_keyentry(priv, key_mode, entry, key_inx, bssid, key->key);
-
-	return 0;
+	return vnt_mac_set_keyentry(priv, key_mode, entry,
+				    key_inx, bssid, key->key);
 }
 
 int vnt_set_keys(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
@@ -102,7 +101,6 @@ int vnt_set_keys(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
 	struct vnt_private *priv = hw->priv;
 	u8 *mac_addr = NULL;
 	u8 key_dec_mode = 0;
-	int ret = 0;
 
 	if (sta)
 		mac_addr = &sta->addr[0];
@@ -115,7 +113,9 @@ int vnt_set_keys(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
 
 		key->flags |= IEEE80211_KEY_FLAG_GENERATE_IV;
 
-		return ret;
+		return vnt_set_keymode(hw, mac_addr, key, VNT_KEY_DEFAULTKEY,
+				       KEY_CTL_WEP);
+
 	case WLAN_CIPHER_SUITE_TKIP:
 		key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIC;
 		key->flags |= IEEE80211_KEY_FLAG_GENERATE_IV;
@@ -136,11 +136,9 @@ int vnt_set_keys(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
 	}
 
 	if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE)
-		vnt_set_keymode(hw, mac_addr, key, VNT_KEY_PAIRWISE,
-				key_dec_mode);
-	else
-		vnt_set_keymode(hw, mac_addr, key,
-				VNT_KEY_GROUP_ADDRESS, key_dec_mode);
+		return vnt_set_keymode(hw, mac_addr, key, VNT_KEY_PAIRWISE,
+				       key_dec_mode);
 
-	return 0;
+	return vnt_set_keymode(hw, mac_addr, key,
+				VNT_KEY_GROUP_ADDRESS, key_dec_mode);
 }
-- 
2.25.1
