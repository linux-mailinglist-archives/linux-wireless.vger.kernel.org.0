Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CFA1FEE5E
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2020 11:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgFRJNE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Jun 2020 05:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728995AbgFRJNC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Jun 2020 05:13:02 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B85FC06174E
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2020 02:13:02 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x6so5207552wrm.13
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2020 02:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IH8CfyxttC28VAndSUFTqHOfJWsh3TDg2r/982MjPtE=;
        b=M/SSWMvzhacEPnlAUL0J/MgFgf4bs58IQIirCpnww4e83eHkhaxmplPf1Onu6wRErV
         nbCSVasensBXBY7ZU1Som9WIIppLlVhWbNYn6pIqToUnN/+qhIngmseNnPCc8t8nhrB8
         NCtQZDdTcAbCyvBGs5cSJFVmME17KrwOBdRh3zK2z3SQK1eeFjOC8LfsAa9l85sa0bGx
         RNzZfczORrInjKQ6lvn/D5q3ZWOhxCKwEYA/fAwHMb/pdS4hJpQjRJL9sgMhFLOXwjXV
         H2DT94HTXYMllizQsx0dMApf7O6U0iY+6FnH+YetD6GLcn+fG2koQyLbLX2saRS23GDk
         K8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IH8CfyxttC28VAndSUFTqHOfJWsh3TDg2r/982MjPtE=;
        b=PM+OeWS9FlQgEWRB7GxtV6BbMfoTgD8eomg0jyxSL1/bQO5vXONR2DJ0YOg2LKXs39
         tYAA05syVFuFXcWkUZR7zVmZOBCPDGOoHvhWqdhZPQMu+NBfBnnOTQ9yyfDndlwqk7iR
         N5NZQiO8TBU6ug3BXoQwO8wZjMn+Ca1wPYldMp7dYVsIIbvBGesBGD/Hk40U106RxSuq
         LGySO+7ocLZiaQQZcCWApHXinwAA7DnAyEXc/uKn+Oub2GIsFK8s2a4X26CS2v6LA+5B
         A6XGMzBJSioYwlKG5K7wGMloULewVZaPcHdFb9gx9MYgGqVc6I1E+LA/UmUXcX1mspcb
         9LiQ==
X-Gm-Message-State: AOAM53327MEff6pHn1/5B+J+tw+8mEvGBvrWxjkLPOq0lkdKDmJd63oy
        VBD6W7VVy3nscuosiLgIs+wXCw==
X-Google-Smtp-Source: ABdhPJwomO8MDg7hHwcCQKAm7kPGeS4a3Twjgk/wSgSft0ZcZlsX58m2aaPRossL53ulWqLl59uBpg==
X-Received: by 2002:a5d:6b86:: with SMTP id n6mr3431039wrx.167.1592471581186;
        Thu, 18 Jun 2020 02:13:01 -0700 (PDT)
Received: from localhost.localdomain ([88.122.66.28])
        by smtp.gmail.com with ESMTPSA id x13sm2733702wre.83.2020.06.18.02.13.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 02:13:00 -0700 (PDT)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     kvalo@codeaurora.org, johannes@sipsolutions.net
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH 2/2] wcn36xx: Advertise beacon filtering support in bmps
Date:   Thu, 18 Jun 2020 11:17:43 +0200
Message-Id: <1592471863-31402-2-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592471863-31402-1-git-send-email-loic.poulain@linaro.org>
References: <1592471863-31402-1-git-send-email-loic.poulain@linaro.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In bmps mode, beacons are filtered, and firmware is in charge
of monitoring the beacons and report changes or loss.

mac80211 must be advertised about such change to prevent it's
internal timer based beacon monitor to report beacon loss.

Fix that by setting/clearing the IEEE80211_VIF_BEACON_FILTER
vif flag on bmps entry/exit.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/pmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/pmc.c b/drivers/net/wireless/ath/wcn36xx/pmc.c
index 1976b80..2936aaf 100644
--- a/drivers/net/wireless/ath/wcn36xx/pmc.c
+++ b/drivers/net/wireless/ath/wcn36xx/pmc.c
@@ -28,6 +28,7 @@ int wcn36xx_pmc_enter_bmps_state(struct wcn36xx *wcn,
 	if (!ret) {
 		wcn36xx_dbg(WCN36XX_DBG_PMC, "Entered BMPS\n");
 		vif_priv->pw_state = WCN36XX_BMPS;
+		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
 	} else {
 		/*
 		 * One of the reasons why HW will not enter BMPS is because
@@ -52,6 +53,7 @@ int wcn36xx_pmc_exit_bmps_state(struct wcn36xx *wcn,
 	}
 	wcn36xx_smd_exit_bmps(wcn, vif);
 	vif_priv->pw_state = WCN36XX_FULL_POWER;
+	vif->driver_flags &= ~IEEE80211_VIF_BEACON_FILTER;
 	return 0;
 }
 
-- 
2.7.4

