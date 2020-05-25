Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8471E0FDE
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 15:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403931AbgEYNwB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 May 2020 09:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403897AbgEYNwB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 May 2020 09:52:01 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB42C061A0E
        for <linux-wireless@vger.kernel.org>; Mon, 25 May 2020 06:52:00 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j10so1534022wrw.8
        for <linux-wireless@vger.kernel.org>; Mon, 25 May 2020 06:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G53awEzeAcf2w2/bPKRB2yBq076amHKUw+YP4fU4bpY=;
        b=rsFIoaCMFep8ZNaymMiVsgWUzFH+B4ZK8OqSBm54FUnXHmy1xkl0SD2Mk34ehWYyX6
         Tr0Fe9OhJmyHrPDByQUh/7I2z16mMBHooZnrv4Q8p1s+St8rMuO8lOobi8Q3Boa6/PpQ
         vARHkRGIZeLuEiPHbKmXwI1AIipIgMOPi0UP7cJSEKOBOm2Xb031kZvzPy8OL1ZHCrF/
         M/EZXSTL9GuIZQuBcvCpjfQft7+YkmEFL+zL/donRKZJgxGT3GLGkmxN3bxqQkYHnU4g
         Uq6Dvpg56PU1F9im03JZQd1vfQ8VqCgqXRIth9o0cmlJ/JvU0qGIoBq+c2nAMxCAaVzO
         eDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G53awEzeAcf2w2/bPKRB2yBq076amHKUw+YP4fU4bpY=;
        b=K/Q+bCJ3rLhmzRqKLUCB1RACOo1xZxuYMV64yjQN9RpHw6MSfSC5gQ1p/F19ZLyyL4
         445QZrBuaxT5AFCIP06kXRnEr70rwtxBCNE9qfdNzfV/bloJe1/66Xdw8s1n9tSC7fwm
         ZqYiwpeXY81Is7lQ/Uh4j7Fhg1o332zJblXA1Ynuv5oiAAlKmC9tj8cYK7HEtp1EsdKf
         1T0TKiwDanceiNNaHjE+HOQkdwi3hOvWiu17CNXX/rSPGlJvCmHP5hRg+K0zlAExAvvr
         XMzklmgs4hXLgfQNVJhXKCQptvLVIWxzvIOoCLLQyikmwMRn/f8q6E2UiNIy3dhULjDB
         JkrA==
X-Gm-Message-State: AOAM530AauB4R8zecm1F5DabuloEIn4iQEMhUS/SIkD2jIipDpk3bS3b
        UN+5Dmg2rapBIyRL4rEcMA==
X-Google-Smtp-Source: ABdhPJweKCCCQy1YpI/KGqraqF7PeQJiFh/PXT7jysKS07dsir4j5My8zqanxGRzwew6dYTt+VR2/g==
X-Received: by 2002:a5d:4c4b:: with SMTP id n11mr14516457wrt.381.1590414719729;
        Mon, 25 May 2020 06:51:59 -0700 (PDT)
Received: from vedder.lan (a109-49-9-80.cpe.netcabo.pt. [109.49.9.80])
        by smtp.gmail.com with ESMTPSA id a15sm6594913wra.86.2020.05.25.06.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 06:51:59 -0700 (PDT)
From:   Rui Salvaterra <rsalvaterra@gmail.com>
To:     johannes@sipsolutions.net
Cc:     stf_xl@wp.pl, julian.calaby@gmail.com, kvalo@codeaurora.org,
        Larry.Finger@lwfinger.net, linux-wireless@vger.kernel.org,
        Rui Salvaterra <rsalvaterra@gmail.com>
Subject: [PATCH v2] rt2800: enable MFP support unconditionally
Date:   Mon, 25 May 2020 14:49:07 +0100
Message-Id: <20200525134906.1672-1-rsalvaterra@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

v2: fixed null pointer.

This gives us WPA3 support out of the box without having to manually disable
hardware crypto. The driver will fall back to software crypto if the connection
requires management frame protection.

Suggested-by: Stanislaw Gruszka <stf_xl@wp.pl>
Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 4 +---
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c | 3 ++-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index 6beac1f74e7c..a779fe771a55 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -9971,9 +9971,7 @@ static int rt2800_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 	if (!rt2x00_is_usb(rt2x00dev))
 		ieee80211_hw_set(rt2x00dev->hw, HOST_BROADCAST_PS_BUFFERING);
 
-	/* Set MFP if HW crypto is disabled. */
-	if (rt2800_hwcrypt_disabled(rt2x00dev))
-		ieee80211_hw_set(rt2x00dev->hw, MFP_CAPABLE);
+	ieee80211_hw_set(rt2x00dev->hw, MFP_CAPABLE);
 
 	SET_IEEE80211_DEV(rt2x00dev->hw, rt2x00dev->dev);
 	SET_IEEE80211_PERM_ADDR(rt2x00dev->hw,
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
index 32efbc8e9f92..2f68a31072ae 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
@@ -468,7 +468,8 @@ int rt2x00mac_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	if (!test_bit(DEVICE_STATE_PRESENT, &rt2x00dev->flags))
 		return 0;
 
-	if (!rt2x00_has_cap_hw_crypto(rt2x00dev))
+	/* The hardware can't do MFP */
+	if (!rt2x00_has_cap_hw_crypto(rt2x00dev) || (sta && sta->mfp))
 		return -EOPNOTSUPP;
 
 	/*
-- 
2.26.2

