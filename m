Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5E92448F9
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Aug 2020 13:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgHNLky (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Aug 2020 07:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbgHNLkY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Aug 2020 07:40:24 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3962EC061345
        for <linux-wireless@vger.kernel.org>; Fri, 14 Aug 2020 04:40:22 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z18so8048217wrm.12
        for <linux-wireless@vger.kernel.org>; Fri, 14 Aug 2020 04:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XO8EPoQb4LLTq78EddIBY+0bDLZNec0c1XiicaUFJYo=;
        b=U7sxSLVW1sh8DVHNuWMgFrMIpseyetwKXM8Pfy8sOE/mGMowDRS3KKckwCDm2Cltu6
         qUeQt0IXWET7Og1vfVvhhjeN190SZNq2N9/Btm8L9444qTRkss6jUErqKC8V8q+XuFo4
         MrhlkXXslgeK2Kn/tSqPvaYxPLzs6u/Z/J5AHt3MqEbYrA+RS7AmLohpC128ndB+0vtY
         a3EJDOQgaMqNPGvthcbFSAY1MwTX6aduR+ooQYmXTFuXDKYajNYYBV1kfitOALgCKHOw
         g1eMSIdSoyt8DsPMxi+6WJf4rVqcYkATcvNKzG7IzqfMMapnpINB1c8XnupmnDXG8Sju
         pwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XO8EPoQb4LLTq78EddIBY+0bDLZNec0c1XiicaUFJYo=;
        b=cn9y8q23Elm39usZSwPLkNo9+03MD64p4N5HlfI3UBWdhijoNZFhvcFU9REgEn4Gji
         fkhqpJU4QmPkhaAc1rCT5tPUL9eVfXiwswJ1hZ40NVcTZTbZx3k8epA3aiVCb07YoAa6
         vM39KcyoA6DrgH+eKgB7VVYKfQjD+sym24ia9DFlbbRxZgKixO1hFX0MoD63guKJBL0J
         rwxnPuqi/ruodlENHFctEd14TJXOVqoT+qVQBfQ0eLBLMWsHm8GHdbC8ZYfVXS9jpAqd
         DvTSxJoVXCyFsMIInJ6ZAWkRmpHkx1btSFdXSLBN3CEm2lcjdncObz985IvNmqFJ8S3N
         /nLw==
X-Gm-Message-State: AOAM533xjJoaruBqw4iNHupupm/e4UxcTwLUH9gXAubkAtTWYiCdDQs0
        1YXhgwcbB/ybHGuDLSqs2ZR0Kw==
X-Google-Smtp-Source: ABdhPJyXRRYLrDoG3M9VfBg386tn7Y7Pbra593U8XbwJE8gHTjQ2o5hAlSZL15+Ss1XCPPuij8eTeg==
X-Received: by 2002:adf:edc3:: with SMTP id v3mr2357786wro.193.1597405220978;
        Fri, 14 Aug 2020 04:40:20 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id 32sm16409129wrh.18.2020.08.14.04.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 04:40:20 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Martin Langer <martin-langer@gmx.de>,
        Stefano Brivio <stefano.brivio@polimi.it>,
        Michael Buesch <m@bues.ch>, van Dyk <kugelfang@gentoo.org>,
        Andreas Jaggi <andreas.jaggi@waterwave.ch>,
        linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
        netdev@vger.kernel.org
Subject: [PATCH 26/30] net: wireless: broadcom: b43: phy_common: Demote non-conformant kerneldoc header
Date:   Fri, 14 Aug 2020 12:39:29 +0100
Message-Id: <20200814113933.1903438-27-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814113933.1903438-1-lee.jones@linaro.org>
References: <20200814113933.1903438-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/broadcom/b43/phy_common.c:467: warning: Function parameter or member 'work' not described in 'b43_phy_txpower_adjust_work'

Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: Martin Langer <martin-langer@gmx.de>
Cc: Stefano Brivio <stefano.brivio@polimi.it>
Cc: Michael Buesch <m@bues.ch>
Cc: van Dyk <kugelfang@gentoo.org>
Cc: Andreas Jaggi <andreas.jaggi@waterwave.ch>
Cc: linux-wireless@vger.kernel.org
Cc: b43-dev@lists.infradead.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/broadcom/b43/phy_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/b43/phy_common.c b/drivers/net/wireless/broadcom/b43/phy_common.c
index 1de4de094d61b..285490f6f0a1d 100644
--- a/drivers/net/wireless/broadcom/b43/phy_common.c
+++ b/drivers/net/wireless/broadcom/b43/phy_common.c
@@ -458,7 +458,7 @@ void b43_software_rfkill(struct b43_wldev *dev, bool blocked)
 	b43_mac_enable(dev);
 }
 
-/**
+/*
  * b43_phy_txpower_adjust_work - TX power workqueue.
  *
  * Workqueue for updating the TX power parameters in hardware.
-- 
2.25.1

