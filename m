Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BC131AECA
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Feb 2021 04:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhBNDD0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Feb 2021 22:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhBNDDU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Feb 2021 22:03:20 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C6BC061574;
        Sat, 13 Feb 2021 19:02:40 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id r77so3491214qka.12;
        Sat, 13 Feb 2021 19:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=pfkCu/2YNhQQQ4K/N1pykusMLuslfMq4zgYXmHw5i7I=;
        b=EGqEyVq6AEu7tH7SG4ChhAcc1+NQzRzSbqGEmnfRprvKidjA8W9AhMvhNehVKF4GKe
         xtMVAJAmHM0ISoZ9eOnEWEyFHKxo5Ibso7KA18gtSAMTTsn0d2QM09wQw58yqGrM104B
         nrNWmwG6LHQfDqhiSfYbfQ7uZNx3+h0PXXseM2nLxGHnNvE/e6m1ecP0lyFexs+tkTtj
         pT5Yk8fFv3ibo3vaPA+nuZo8XQq3ipO8lWQnph44jD8ya64+nGriVLQjuAGdZGVEBv4t
         wtRVaLPCq5XWpgEc1oAkyCPT74sZHZ3TILP1nL6ly3EwyjZ4hoHpKVthjZdGwypUYEWS
         9cFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=pfkCu/2YNhQQQ4K/N1pykusMLuslfMq4zgYXmHw5i7I=;
        b=tH/zIjTRGnlfzlGfvZjyF1vTZlEX3hsY7Atf5en/c/EGW9kBMlcxjLanm6QJ29m/C4
         3cI9GkLTcJZNfAyPBpAV6JXVmXtQ4JZTJonR0YhE22+jd/hP9s0aBwTU0EmIz8AeEJ8Y
         vwplye3J917BrkSAMKKqNDz3EnXW1yIRndNPYwzo7NGJG8nNIpnBEjNaSU4iZsnnSfdI
         3E6jx+R9LA8WX2XI4/MEUxe/+yFx+C/zUPT0UOvQF0ySHZUkJJ1FGPNHpY291mTGSC6U
         4UHJ+ZSc1JDZ7N/kJCcHnF5FvlQnLy42Ssg83KhjPuCfv41abwzfgSllvPy6QBP22FyH
         VyLw==
X-Gm-Message-State: AOAM532z+A5RCnwf2dI3R3mW0/k6g54s4ddeX3ewFIqVEXp2poGgWvox
        /p2hnBz8Qvtcn3t9tla+Z6Q=
X-Google-Smtp-Source: ABdhPJy6ydxy5+ZHCLyKfDKUCRjMwWodTcNqq0E7xSUolZsp+2Pasb6AtXRHS9ppq1A3hhb7WbIuPQ==
X-Received: by 2002:a05:620a:ed8:: with SMTP id x24mr9541803qkm.381.1613271759753;
        Sat, 13 Feb 2021 19:02:39 -0800 (PST)
Received: from fedora ([45.152.180.20])
        by smtp.gmail.com with ESMTPSA id f26sm9295497qkh.80.2021.02.13.19.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 19:02:39 -0800 (PST)
Date:   Sat, 13 Feb 2021 22:02:37 -0500
From:   Nigel Christian <nigel.l.christian@gmail.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7921: remove unnecessary variable
Message-ID: <YCiSzfUQi2YtC+l4@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In mt7921_pm_set() the variable "ret" is initialized to zero
and then returned. Remove it and return zero.

Signed-off-by: Nigel Christian <nigel.l.christian@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index 0dc8e25e18e4..4bc3dd99bd14 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -164,7 +164,6 @@ mt7921_pm_set(void *data, u64 val)
 {
 	struct mt7921_dev *dev = data;
 	struct mt76_phy *mphy = dev->phy.mt76;
-	int ret = 0;
 
 	mt7921_mutex_acquire(dev);
 
@@ -175,7 +174,7 @@ mt7921_pm_set(void *data, u64 val)
 					    mt7921_pm_interface_iter, mphy->priv);
 	mt7921_mutex_release(dev);
 
-	return ret;
+	return 0;
 }
 
 static int
-- 
2.29.2

