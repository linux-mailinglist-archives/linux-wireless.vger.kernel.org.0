Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8058B3A04E
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Jun 2019 16:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfFHOtu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 8 Jun 2019 10:49:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34669 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfFHOtu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 8 Jun 2019 10:49:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id e16so4947732wrn.1
        for <linux-wireless@vger.kernel.org>; Sat, 08 Jun 2019 07:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ThXL73YBA73i6DHTYZ2woJ24DE7P97+p+9CQktYCZI4=;
        b=pU26wlJ+eC34N0DcWzcXXz31Yzc7AR+LTKsxJHoHswjG5E+wDATBNOWY/eVvG5KRFb
         /kAJ454jHrWUHDby/q+iBzJv2z5yEBjfmWy1cW6sNbJ2NXPYJVvfiKd33iklqJf3zdFT
         iUa7MEuouregEh1WtxeIj1mhhPjdv79Z7r+fYBAhIDMYZ4il0BL0vFjcj24hkgqszPXr
         LZ8yT0BP/v9IHqO/Kcuucgdk0pj4c6R5R8XNLxR6pfKTJxTGqVmGckdcmrLw17bdpjhF
         9pvpAosl+Hulpluq5sCp8zIT/GYNsX3Us2snwAXu6zvUtDMj07ISFTHgPYCd21oUdqG+
         Ijqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ThXL73YBA73i6DHTYZ2woJ24DE7P97+p+9CQktYCZI4=;
        b=cydL4ew0vnkx6BI1t6ReSe1kgAinRN8Blj+cmpVFrPuvolSWbw3CeW1rDP4GP36TXx
         e8cqaCuJR1oqEkMowDMBlVIX4NEuOlttgdv2dPXd/rHs+AdPk7W3tX/EYbMLQfp37TSe
         Hz53j/BIRRA1qMIU0JqoNl8ZEctzN1rKWg+LViD/RFJ3DzDOJESsTzeomlcNF96RlObp
         TjkEpTiBVh79o3qqD55V9Rcd1ViMjDNV8l/d4uGeDXcEOryDqaEJxOIGxxchT7gHHR7O
         rNTNx5sKyJvQZrq06UJ0KIevxqesagNQWp/5no80FCknZA5n5Knr0Muuq+qu40mkGVL4
         3PAQ==
X-Gm-Message-State: APjAAAXcBVLEKbjqkKYJknIFZ4fg2BJiSK5MGGsp0MWWQr2wM/NQEtyd
        eIFDQFaQH7U7dFoGfOxG1izM2DJk
X-Google-Smtp-Source: APXvYqzGKgpbtF3saWYJNBc0MS4+q7bd+6SEtECp3IKi+LQmd48CukyEu6fzRpB4fvesojFV9WEBuQ==
X-Received: by 2002:a5d:6583:: with SMTP id q3mr40813092wru.184.1560005388500;
        Sat, 08 Jun 2019 07:49:48 -0700 (PDT)
Received: from debian64.daheim (p5B0D753E.dip0.t-ipconnect.de. [91.13.117.62])
        by smtp.gmail.com with ESMTPSA id t140sm8140277wmt.0.2019.06.08.07.49.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 07:49:47 -0700 (PDT)
Received: from chuck by debian64.daheim with local (Exim 4.92)
        (envelope-from <chunkeey@gmail.com>)
        id 1hZcfD-0000Cn-Bm; Sat, 08 Jun 2019 16:49:47 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH] carl9170: fix enum compare splat
Date:   Sat,  8 Jun 2019 16:49:45 +0200
Message-Id: <20190608144947.744-1-chunkeey@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch fixes a noisy warning triggered by -Wenum-compare

|main.c:1390:31: warning: comparison between ‘enum nl80211_ac’
|	and ‘enum ar9170_txq’ [-Wenum-compare]
|  BUILD_BUG_ON(NL80211_NUM_ACS > __AR9170_NUM_TXQ);
|                               ^
| [...]

This is a little bit unfortunate, since the number of queues
(hence NL80211_NUM_ACS) is a constant based on the IEEE 802.11
(much like IEEE80211_NUM_ACS) and __AR9170_NUM_TXQ is more or
less defined by the AR9170 hardware.

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
 drivers/net/wireless/ath/carl9170/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
index eaea08581cea..acc881bd7f9f 100644
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -1387,7 +1387,7 @@ static int carl9170_op_conf_tx(struct ieee80211_hw *hw,
 	int ret;
 
 	BUILD_BUG_ON(ARRAY_SIZE(ar9170_qmap) != __AR9170_NUM_TXQ);
-	BUILD_BUG_ON(NL80211_NUM_ACS > __AR9170_NUM_TXQ);
+	BUILD_BUG_ON((size_t)NL80211_NUM_ACS > (size_t)__AR9170_NUM_TXQ);
 	mutex_lock(&ar->mutex);
 	memcpy(&ar->edcf[ar9170_qmap[queue]], param, sizeof(*param));
 	ret = carl9170_set_qos(ar);
-- 
2.20.1

