Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DB6261A60
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgIHSfN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731591AbgIHSc3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:32:29 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B51C06179E
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:23:57 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y15so319522wmi.0
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z7Rx0C6d6/7/5yg3uB9kdCw4d9C0cgfMEPvtmg+zlZY=;
        b=ELL5xuzqWa5q/mb3KbbeH7b1DIUvnFd4gU1GPgji4LIdQxFVLUSsIqvF77f4GSTsb0
         xRzUQauUMIParsS3SZiuTzZba7KrcARB1zKYzOpZd4xYgzxpTiOOCHrJygRLhjoewD3M
         51OgLZFBO1pd3y6HDpwVpO9PVTP75+UJtHjNv+UynvH3ArKrQyYh0SFsXfgOUGDPIsIL
         zDqekLyd5RviwKFlswZ7iPR/6MG0cjpZNryTOt4k9mV1LAgdRw8ouynY5k17kmUuwKg/
         J2m0Gbo7SkoxJd0S6ZlimPNwNgIjYPOc7AYe6qOiUvRuZe+aOni7e/0xeTZTSkt3J74f
         lkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z7Rx0C6d6/7/5yg3uB9kdCw4d9C0cgfMEPvtmg+zlZY=;
        b=EvGRZBkoXqJ/ShWRasAmPb+QkAPyD5bHTISPc8OEGCj7hP4YNatua+7qeaaIc0KBel
         V/ECf+1FKAkVsHBPqzyw27QEDLa+H85RaPFbwAmaQSeI/LP1scCr9AloDvvPy/rOamu+
         uvSGpFBlZzlpaitxvYIGwT2VJc4LBr2CiARJCB4wZpogGULFnICdNBNqGWTR2hLyXCgg
         meC8e+8DG/50UvLQTQR0+uDj0WmQejEM1lGR05liEEbJYsy0ayJLoB1YK++zCesSlKYQ
         6E+9Q3Vo6eHa/+22zhxP+z1LVVXqu+QMFgozbITEkIie0fYwBommnLnLPCQSxGJlEAuU
         u5oQ==
X-Gm-Message-State: AOAM5326BMDb4VKH3XkQw5Q/YcOBS/1HIfn8cbuagGovczEZ89jX7B8/
        7iLADap/HDTAnVm7eixiYqWI8A==
X-Google-Smtp-Source: ABdhPJzwYzDZ3CVLP/JaZNpUKGYihXcw/6dRiSaZWiTAK6EsSRvSATiLIzpoDE0HLexlTbysmqKUuQ==
X-Received: by 2002:a1c:63c1:: with SMTP id x184mr394519wmb.138.1599589436290;
        Tue, 08 Sep 2020 11:23:56 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id k8sm362516wrl.42.2020.09.08.11.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:23:55 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 6/7] wcn36xx: Add wcn36xx_smd_set_bss_vht_params()
Date:   Tue,  8 Sep 2020 19:24:36 +0100
Message-Id: <20200908182437.2870281-7-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908182437.2870281-1-bryan.odonoghue@linaro.org>
References: <20200908182437.2870281-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit adds wcn36xx_smd_set_bss_vht_params(). The job of this function
is to decide if the BSS is VHT capable and if so set the appropriate bit
in the BSS parameter structure for passing to the firmware.

VHT Channel width set is not set since we don't support 160MHz.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 14af98af42f3..fa6f5943a43d 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -146,6 +146,15 @@ static void wcn36xx_smd_set_bss_ht_params(struct ieee80211_vif *vif,
 	}
 }
 
+void
+wcn36xx_smd_set_bss_vht_params(struct ieee80211_vif *vif,
+			       struct ieee80211_sta *sta,
+			       struct wcn36xx_hal_config_bss_params_v1 *bss)
+{
+	if (sta && sta->vht_cap.vht_supported)
+		bss->vht_capable = 1;
+}
+
 static void wcn36xx_smd_set_sta_ht_params(struct ieee80211_sta *sta,
 		struct wcn36xx_hal_config_sta_params *sta_params)
 {
-- 
2.27.0

