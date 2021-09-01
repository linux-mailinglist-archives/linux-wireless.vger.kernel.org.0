Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31C53FE2C7
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Sep 2021 21:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242455AbhIATLX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Sep 2021 15:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242439AbhIATLX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Sep 2021 15:11:23 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C43C061575
        for <linux-wireless@vger.kernel.org>; Wed,  1 Sep 2021 12:10:26 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id c6so293974pjv.1
        for <linux-wireless@vger.kernel.org>; Wed, 01 Sep 2021 12:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6O0hTb+/SiW+RCaXHAjU5CZHsijbAqGowKgKh4Z53XQ=;
        b=cmwOXdkrPRWgUFof+Q+wCfovs0yxot/hHJTwT+JUH6CS4jB2d1RjDqL5AYjkvPijZw
         tmCS2UmjxsASyEyhRflD4qRhySsRc3B6BJ+G19A0KzSKLgXT75iwFi5xwq0eoOmy8Mpg
         ha9JzLHsB6lQucoyb4VpJUJyMQkKyOYDd2+arrkK0bn9RLyDUIHPLherXAWuVY/17aSX
         s4jvsK4lmy02lMmzzBlv72LwBhkbC1tYw/p1pZFmpA6NpWUDY0t2nc0Uly5ewYB/YFMv
         dyDk0PvMxK/KrsJRlmTKEX5n2B+r6woj7PSsN/barGHm+aFSJw9bzfJyDMr2jkeOiZbG
         64bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6O0hTb+/SiW+RCaXHAjU5CZHsijbAqGowKgKh4Z53XQ=;
        b=mv3lPPbD3JxqZMPCB/+d36N56bvVPNs7ggYHirZk98dr5/4JGkKYnv070cMwqp64NH
         0QIZLWru6KJXlPp9C4yz62BE9UB5AFynU56OMqcMYxgMfPoeaFyer/sKIuxldlrZzNUE
         auTuam+fzn5KUx1Fa8gRvGpPIoUcUw8auZY1imZ+XIVR4YQP8vH0ayHlV0d5cXFQn3u0
         3kH2oZRShp7f1focd0k2fcG/MP6i/RV4ERsUgjiU5ag4Ey2kQmOMr6wS/sMUf8g+ERVF
         j8Egaew2fCVBH1WawcrQ2iZoVvaDhYySxXp01OjYqalZUiNub4zCQdVK9ep/libWKqnt
         hNuQ==
X-Gm-Message-State: AOAM5332kwh2gERHftHplZxSyu4J9tZfZohmE0pqqKdU3Q/f+F4b7Iym
        QHnd/sGIxZyvZg1yVz77NBnl99BP0LFWxg==
X-Google-Smtp-Source: ABdhPJw9uLc2SqJY4xePUTCzoj28XdlGB78JoEKOT0Qp63YbGXAuVfL275Z8YANRda31paF3Tqm1DA==
X-Received: by 2002:a17:90a:d187:: with SMTP id fu7mr956451pjb.106.1630523425237;
        Wed, 01 Sep 2021 12:10:25 -0700 (PDT)
Received: from localhost.localdomain ([50.39.173.103])
        by smtp.gmail.com with ESMTPSA id b7sm419407pgs.64.2021.09.01.12.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 12:10:24 -0700 (PDT)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] brcmfmac: fix incorrect error prints
Date:   Wed,  1 Sep 2021 12:06:41 -0700
Message-Id: <20210901190641.255624-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

An unsupported AKM would end up printing "invalid cipher group". Instead
print "invalid akm suite" with the offending AKM.

Signed-off-by: James Prestwood <prestwoj@gmail.com>
---
 .../wireless/broadcom/brcm80211/brcmfmac/cfg80211.c  | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index f4405d7861b6..34d3d2d198de 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -1783,8 +1783,8 @@ brcmf_set_key_mgmt(struct net_device *ndev, struct cfg80211_connect_params *sme)
 			val = WPA_AUTH_PSK;
 			break;
 		default:
-			bphy_err(drvr, "invalid cipher group (%d)\n",
-				 sme->crypto.cipher_group);
+			bphy_err(drvr, "invalid akm suite (%d)\n",
+				 sme->crypto.akm_suites[0]);
 			return -EINVAL;
 		}
 	} else if (val & (WPA2_AUTH_PSK | WPA2_AUTH_UNSPECIFIED)) {
@@ -1816,8 +1816,8 @@ brcmf_set_key_mgmt(struct net_device *ndev, struct cfg80211_connect_params *sme)
 			profile->is_ft = true;
 			break;
 		default:
-			bphy_err(drvr, "invalid cipher group (%d)\n",
-				 sme->crypto.cipher_group);
+			bphy_err(drvr, "invalid akm suite (%d)\n",
+				 sme->crypto.akm_suites[0]);
 			return -EINVAL;
 		}
 	} else if (val & WPA3_AUTH_SAE_PSK) {
@@ -1830,8 +1830,8 @@ brcmf_set_key_mgmt(struct net_device *ndev, struct cfg80211_connect_params *sme)
 			}
 			break;
 		default:
-			bphy_err(drvr, "invalid cipher group (%d)\n",
-				 sme->crypto.cipher_group);
+			bphy_err(drvr, "invalid akm suite (%d)\n",
+				 sme->crypto.akm_suites[0]);
 			return -EINVAL;
 		}
 	}
-- 
2.31.1

