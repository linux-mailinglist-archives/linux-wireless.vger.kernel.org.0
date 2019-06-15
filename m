Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76D4346F59
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jun 2019 12:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfFOKAN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 Jun 2019 06:00:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36311 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfFOKAN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 Jun 2019 06:00:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so4986879wrs.3
        for <linux-wireless@vger.kernel.org>; Sat, 15 Jun 2019 03:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bWrVGfbUekWIrM0yNEaV5DF2tIVVqd42F9zftJflI+s=;
        b=CaHCYuxdldw8UpwzRMHDhIXOL9Mgzoc8HQgdOTHDxB/cS2dbJ9gQeum7Y5vBgXdqHv
         SxAQ48TDuf8rJPMqowZSAMrypqmquK9SRHs3y7v/qbp99uo+1Rq3iQjAMfOsPVHxr2y5
         bcjUWXBEU88euQ1R2FDtIb3dE+zB21aGDYBHK7hSY8xnM1EmPcaFxwaHpB82GXso1P4T
         DoNnY2Aa1iXd6zlK9ZbAKC2Mj+8pdM0PoFyXNK6SBVhLk9hO6nLxKHMqEuhcJXS2ctLv
         PCwDaKGkh3/3g+L8mFnB/Ii9U8qA6X74s2oCXTZMfb/RQExC3kVuWZaaS4iYH5Xd1Cdr
         mmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bWrVGfbUekWIrM0yNEaV5DF2tIVVqd42F9zftJflI+s=;
        b=opUuoPoTOvy1G6mlU53LK0poHkAofnBHgcDDabYLdGiborsxyvvhD9U9UnrB94ZI8J
         MAiaA+EavNSh3oShrrZuH9vGlOhgPDvRGik3f2ORDve+PVLIdjcyJIhlfTkWNY72Dcf5
         SmyKoPgAOwxJkz/yW942E5RWG/3pn37L/AzLNdUf8Gh5nH+GMkgrjA0gxem8pBKBLC1r
         iuHcv7hQdrDgvkka56GaIpq8KZSt14vVI+QQyjfPrx7albVHWL8/87BluZwK7Q62MJzi
         xclIrDuF2oa1sXqvtYzD6+Mw+cKYlwdhSrXYtPV0gJxlgysM33LRnUrgDEjHgbKEtjyj
         E5jw==
X-Gm-Message-State: APjAAAVucwj4mT03Ss5W82GE+dtY/LpeMixkDpza49pY2I221PbRuHM+
        hkF6TWiSeFq4PH0WxvCtLWvo8/JWgm8=
X-Google-Smtp-Source: APXvYqxAZkmiGeP4weaE9a66/1OYGLyS1oSyGi2oL+EcrQ2DbNUvZX1BGjI4GRAmE5zZQ26U765vdA==
X-Received: by 2002:a5d:4ac1:: with SMTP id y1mr15396888wrs.183.1560592811140;
        Sat, 15 Jun 2019 03:00:11 -0700 (PDT)
Received: from debian64.daheim (pD9E2960F.dip0.t-ipconnect.de. [217.226.150.15])
        by smtp.gmail.com with ESMTPSA id b6sm5546603wrx.85.2019.06.15.03.00.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 15 Jun 2019 03:00:10 -0700 (PDT)
Received: from chuck by debian64.daheim with local (Exim 4.92)
        (envelope-from <chunkeey@gmail.com>)
        id 1hc5Tl-0003p7-IZ; Sat, 15 Jun 2019 12:00:09 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH] p54: remove dead branch in op_conf_tx callback
Date:   Sat, 15 Jun 2019 12:00:09 +0200
Message-Id: <20190615100009.14654-2-chunkeey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190615100009.14654-1-chunkeey@gmail.com>
References: <20190615100009.14654-1-chunkeey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch removes the error branch for (queue > dev->queues).
It is no longer needed anymore as the "queue" value is validated by
cfg80211's parse_txq_params() before the driver code gets called.

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
 drivers/net/wireless/intersil/p54/main.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intersil/p54/main.c b/drivers/net/wireless/intersil/p54/main.c
index 1c6d428515a4..4cc0ece0cd0e 100644
--- a/drivers/net/wireless/intersil/p54/main.c
+++ b/drivers/net/wireless/intersil/p54/main.c
@@ -414,12 +414,9 @@ static int p54_conf_tx(struct ieee80211_hw *dev,
 	int ret;
 
 	mutex_lock(&priv->conf_mutex);
-	if (queue < dev->queues) {
-		P54_SET_QUEUE(priv->qos_params[queue], params->aifs,
-			params->cw_min, params->cw_max, params->txop);
-		ret = p54_set_edcf(priv);
-	} else
-		ret = -EINVAL;
+	P54_SET_QUEUE(priv->qos_params[queue], params->aifs,
+		      params->cw_min, params->cw_max, params->txop);
+	ret = p54_set_edcf(priv);
 	mutex_unlock(&priv->conf_mutex);
 	return ret;
 }
-- 
2.20.1

