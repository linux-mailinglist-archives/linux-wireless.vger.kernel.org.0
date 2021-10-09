Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D936F427DA7
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Oct 2021 23:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhJIVas (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 9 Oct 2021 17:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhJIVas (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 9 Oct 2021 17:30:48 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65BFC061570
        for <linux-wireless@vger.kernel.org>; Sat,  9 Oct 2021 14:28:50 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k7so41323177wrd.13
        for <linux-wireless@vger.kernel.org>; Sat, 09 Oct 2021 14:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=756PrRdaWI7jwiGD/InwETmFFlcAg/HKouoZy4K3we4=;
        b=oi7APObKL/t2naJkjbRdXQJZo8RCE0iYPu0svjbEq5wZTMdYXkAoPsRw2GYtuPlmyv
         I4NRIgU8AlNd8BdZA9RgobE6wwi3G4U4tPmcxZBV9sgnMKT1ZM4acG2xfZ0ep+7S+jwT
         wggouDDzLWhwZMDbFvfZTvjpUApQv88YaH5OqZ1GTcGgy57RW3eMxeE9O89GnG73MEQV
         0WMHve7vChniMLTeW6EoNQrDfO0MKEWWsDn8bL5zx+CinmHwOHv59d5ikTbFyPM2y7FJ
         gsOK/QbDtaZWOtY6VOIvmWA7q8eLQHUYaYbq8k07sg4fJhTHD2GkExFFhygLlrVLNExL
         eO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=756PrRdaWI7jwiGD/InwETmFFlcAg/HKouoZy4K3we4=;
        b=BfUVZSwObvm87+kumIpx2ks62eTvkvEZALtUQlyxJ+x3CPx2yTpSpTKHGS7kSxq+Zn
         kd8aSc8Qe/gtJBAp+iZRcgUBf4kXfIJDmwHoy/VWqcn/aTBh/8fVR35CZ3D1JjoxbPrj
         dRWoG00Ax3TwaPD4mGo35C4GAp8dRyerVBSqZ95beETSACIW7CmhW8cpJPPyGS1ekeMx
         dBSi6icfgdE/wlQoAhtjqj9Tr57xVTUM8I3yBk3eQGqvE5xN2nxvQCmtQn73rnpdYnp+
         OgU0ZBA/QBkVWZyPPlJFxOeBv+YUr8DXoevp2rZDE0x2ImvAaz5GtFYi77N8+KMRp4Um
         dYIw==
X-Gm-Message-State: AOAM531gFgrlh1hO6FSgK0H55Z+lz4fQ9iJOpcq8SrRuAfzd3AYOLHDs
        2v3rTYdnWGNhV2lFw06cm/ienyu7QYY=
X-Google-Smtp-Source: ABdhPJxsGEkSDyZZ4z7KP8Qpya7Je/x2FeZ+AQnMQzg0C9ESG+bHti4KMXhwORcyof/+3CPL6BsMig==
X-Received: by 2002:adf:d1c9:: with SMTP id b9mr13833105wrd.426.1633814928923;
        Sat, 09 Oct 2021 14:28:48 -0700 (PDT)
Received: from debian64.daheim (p200300d5ff2f4800d63d7efffebde96e.dip0.t-ipconnect.de. [2003:d5:ff2f:4800:d63d:7eff:febd:e96e])
        by smtp.gmail.com with ESMTPSA id l17sm3137048wrx.24.2021.10.09.14.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 14:28:48 -0700 (PDT)
Received: from chuck by debian64.daheim with local (Exim 4.95)
        (envelope-from <chunkeey@gmail.com>)
        id 1mZJtf-007TZs-Ml;
        Sat, 09 Oct 2021 23:28:47 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
Cc:     Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH v1] ath9k: support DT ieee80211-freq-limit property to limit channels
Date:   Sat,  9 Oct 2021 23:28:47 +0200
Message-Id: <20211009212847.1781986-1-chunkeey@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The common DT property can be used to limit the available channels
but ath9k has to manually call wiphy_read_of_freq_limits().

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>

---

I would have put this into ath9k_of_init(). But it didn't work there.
The reason is that in ath9k_of_init() the channels and bands are not yet
registered in the wiphy struct. So there isn't any channel to flag as
disabled.

---
 drivers/net/wireless/ath/ath9k/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
index 1568730fc01e..0344d6f27275 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -1094,6 +1094,8 @@ int ath9k_init_device(u16 devid, struct ath_softc *sc,
 		ARRAY_SIZE(ath9k_tpt_blink));
 #endif
 
+	wiphy_read_of_freq_limits(hw->wiphy);
+
 	/* Register with mac80211 */
 	error = ieee80211_register_hw(hw);
 	if (error)
-- 
2.33.0

