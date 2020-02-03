Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7AD915023C
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2020 09:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbgBCIIp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Feb 2020 03:08:45 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36097 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbgBCIIo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Feb 2020 03:08:44 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so15772024wma.1;
        Mon, 03 Feb 2020 00:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7sYM8eT+kTrvZyGwiZN7bHkcGk6EIz1tRLoNiTTlspc=;
        b=gVb5orNbcPgO8uiztYf9dkqrOY5Uj+gwy/YprnUdAM3jj0VO7P/f0X5oK2PyqFIoLm
         Ui2DgFwADsMKIVOrgP6fC/tRFqduZrj0Pk1sE/nSmV3rtrRY+ZHmzhGhsltXCOChWu1K
         CSd6XJTcV4zLe8/i96rwf4c+df9qTbv7zVa7wpc9IU3MPg6FIcrhS90n1lFEinKROlAm
         S4LUkAm4febSUdtfF6gs4hSJqn9Ukti0xj3VcHZ/RG0XONPpIorhZKk9oalG1xnsV3Yn
         H2wRTMCaUbceR5qpDpsmLQonHHbIa+X3gIglGTO+9En0uWxF0oGRKPwtty0H7Ri56680
         PGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7sYM8eT+kTrvZyGwiZN7bHkcGk6EIz1tRLoNiTTlspc=;
        b=rXGql2DgQvrMI3Gsrz2rrTD4DsQa6nv4PUnFtHXNCTA6ptC93K/NVGbzv/IioSjXmZ
         Bg/zkjMhTifeHrTmDsddcmFus7MpSyM+tbnuXY7zGS0gV7WrM7ZWJWlzXsWyj66eXTk9
         6Vjz67yg3c2DRmEC2KxEuMeSef7fe0A3jc5Uw+A2ri0Agq8rt4fTZDfvqEoaMTIawaYW
         KFUwLvIUUamj7yeYT2IHWnXWHHmww11RZaPGd4iEAKs9BNZqJblz8ewNjK9GbxaedFCy
         j76IOlrLvcAhmTbw1FgXXJa0oXYUJgX9FhlsLKEhl8x7fzce9NPPE0xykv9lmQ9jDe8n
         NM1A==
X-Gm-Message-State: APjAAAXZZAtheMSvofUBBbMAbODGOmRwI7cPUgdUxPG51ODmwSomWhIY
        9qeKWexgHOuAOLjcAl0XIsCoBe58
X-Google-Smtp-Source: APXvYqzD+OR1dr/24HpXa1q62h4Zp5MSd5va7uv+zjVjRgeKNmVlatznscrxp7p/DgmuVKOcaBSx9A==
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr26069459wmi.37.1580717322440;
        Mon, 03 Feb 2020 00:08:42 -0800 (PST)
Received: from localhost.localdomain ([185.120.125.36])
        by smtp.googlemail.com with ESMTPSA id a16sm23455649wrt.37.2020.02.03.00.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 00:08:41 -0800 (PST)
From:   Zvika Yehudai <zvikayeh@gmail.com>
To:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Zvika Yehudai <zvikayeh@gmail.com>
Subject: [PATCH] mac80211: Fix minor typo.
Date:   Mon,  3 Feb 2020 10:08:23 +0200
Message-Id: <20200203080823.24949-1-zvikayeh@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove redundant 'the'.

Signed-off-by: Zvika Yehudai <zvikayeh@gmail.com>
---
 include/linux/ieee80211.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 7d3f2ced92d1..5aff704eb0f4 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2053,7 +2053,7 @@ ieee80211_he_ppe_size(u8 ppe_thres_hdr, const u8 *phy_cap_info)
 
 /*
  * ieee80211_he_oper_size - calculate 802.11ax HE Operations IE size
- * @he_oper_ie: byte data of the He Operations IE, stating from the the byte
+ * @he_oper_ie: byte data of the He Operations IE, stating from the byte
  *	after the ext ID byte. It is assumed that he_oper_ie has at least
  *	sizeof(struct ieee80211_he_operation) bytes, the caller must have
  *	validated this.
@@ -2091,7 +2091,7 @@ ieee80211_he_oper_size(const u8 *he_oper_ie)
 
 /*
  * ieee80211_he_spr_size - calculate 802.11ax HE Spatial Reuse IE size
- * @he_spr_ie: byte data of the He Spatial Reuse IE, stating from the the byte
+ * @he_spr_ie: byte data of the He Spatial Reuse IE, stating from the byte
  *	after the ext ID byte. It is assumed that he_spr_ie has at least
  *	sizeof(struct ieee80211_he_spr) bytes, the caller must have validated
  *	this
@@ -2734,7 +2734,7 @@ enum ieee80211_tdls_actioncode {
  */
 #define WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT	BIT(6)
 
-/* TDLS capabilities in the the 4th byte of @WLAN_EID_EXT_CAPABILITY */
+/* TDLS capabilities in the 4th byte of @WLAN_EID_EXT_CAPABILITY */
 #define WLAN_EXT_CAPA4_TDLS_BUFFER_STA		BIT(4)
 #define WLAN_EXT_CAPA4_TDLS_PEER_PSM		BIT(5)
 #define WLAN_EXT_CAPA4_TDLS_CHAN_SWITCH		BIT(6)
-- 
2.17.1

