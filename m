Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C417C46F5A
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jun 2019 12:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfFOKAN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 Jun 2019 06:00:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35260 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfFOKAN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 Jun 2019 06:00:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id c6so4542106wml.0
        for <linux-wireless@vger.kernel.org>; Sat, 15 Jun 2019 03:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mf8bnwX+XcDVDtuj5IVbiX11VzU28F3msIAQcAlMbbg=;
        b=rq/0GR4mxNIqx3Lw7QUXkv4KXvs8t8JTZtu9DKeRl7eqFuWlvUZAHx9gIigAE1BLph
         eLcUeq9pplGUneqd06zo/jb/k+xGTS25vex9oqJeWvtPKmZAguTavm0amsh+839K2eGv
         G1hssOOgwG4pw8sCtk+tZlry8M6xbE11oDtg136cPT/yzVcJa3KV7Vait41YBrf6jZXk
         RS9EiJZO7haMqXFL7veVjFP6Rv9g1gb27JpTtVXrVU/N2iN+6L+rExpar+hgJ55obHa9
         +PDPVTJAzcPDrRDe4Qu526g1w0/qQJaVqe43Z5WcIa0VkDP9HOOPZTM49PR8eTyBC9nJ
         KUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mf8bnwX+XcDVDtuj5IVbiX11VzU28F3msIAQcAlMbbg=;
        b=Kr3hmMaGRoSktvm9KAY2TzL96AQ256aIBmXxYGpZS7pfnAWeE18gV/So0ciaIB0fVq
         eru4Wx6eDwRm8XySQJzNjvQCnSWYD5sCSU7Kj2tdI6n584eT0PacuRhvs2gFVHUMktfN
         avtCtAjPU4EcF9jZ0/SBSS5PKuKINTC0J+z1pooCInpF9ggM/9Ub8BVdOncgOxUoNdFH
         6CoIrFVYm9QxzFNFw0TSkT1tW2vPciC4Y+r8RP2kLqjKuFejfQxNB5oFisBfMrCG/0fp
         r/gIpzqYZNg1EL7f9ntCH4Lhd8+GZD0N+L32DlSTUfmaiRluntDG+tCzDrOFNfMpOgyM
         UQ/A==
X-Gm-Message-State: APjAAAUIFcdQ2x8VK5rtaD3GkTOqC2Du+V84rK+3faNYZhBDvvlQVrNm
        E/N4064v4cJs0WKvzha8hY5amj7skBg=
X-Google-Smtp-Source: APXvYqym70kUvv7Zrrpom9mcumXtVvJrll81jxhqE4A5HV2CAJBmKz6xNa9ip+mY3es8bOHArFIOag==
X-Received: by 2002:a7b:ca43:: with SMTP id m3mr11426882wml.45.1560592810838;
        Sat, 15 Jun 2019 03:00:10 -0700 (PDT)
Received: from debian64.daheim (pD9E2960F.dip0.t-ipconnect.de. [217.226.150.15])
        by smtp.gmail.com with ESMTPSA id 18sm3968649wmg.43.2019.06.15.03.00.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 15 Jun 2019 03:00:10 -0700 (PDT)
Received: from chuck by debian64.daheim with local (Exim 4.92)
        (envelope-from <chunkeey@gmail.com>)
        id 1hc5Tl-0003p4-Hv; Sat, 15 Jun 2019 12:00:09 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH] carl9170: remove dead branch in op_conf_tx callback
Date:   Sat, 15 Jun 2019 12:00:08 +0200
Message-Id: <20190615100009.14654-1-chunkeey@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch removes the error branch for (queue > ar->hw->queues).
It is no longer needed anymore as the "queue" value is validated by
cfg80211's parse_txq_params() before the driver code gets called.

Some background:
In the old days (linux 2.6 and early 3.x), the parse_txq_params()
function did not verify the "queue" value. That's why these drivers
had to do it.

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
 drivers/net/wireless/ath/carl9170/main.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
index 7f1bdea742b8..40a8054f8aa6 100644
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -1387,13 +1387,8 @@ static int carl9170_op_conf_tx(struct ieee80211_hw *hw,
 	int ret;
 
 	mutex_lock(&ar->mutex);
-	if (queue < ar->hw->queues) {
-		memcpy(&ar->edcf[ar9170_qmap[queue]], param, sizeof(*param));
-		ret = carl9170_set_qos(ar);
-	} else {
-		ret = -EINVAL;
-	}
-
+	memcpy(&ar->edcf[ar9170_qmap[queue]], param, sizeof(*param));
+	ret = carl9170_set_qos(ar);
 	mutex_unlock(&ar->mutex);
 	return ret;
 }
-- 
2.20.1

