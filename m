Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391C52BA038
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Nov 2020 03:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgKTCNF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Nov 2020 21:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgKTCNF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Nov 2020 21:13:05 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3EDC0613CF
        for <linux-wireless@vger.kernel.org>; Thu, 19 Nov 2020 18:13:04 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id l1so8443118wrb.9
        for <linux-wireless@vger.kernel.org>; Thu, 19 Nov 2020 18:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QTXtYshgBx4QZ9Jmd3XHSEpqTndirQEx843ji2frBOM=;
        b=VT/LmiGPZg6SfpY7DYUOD7vMYBoXdxmFUFH2LYt/uhtPFpQGJOg7eQbi4KuvKwiYLD
         4upHxJ6O411pvXxSBYQrHQ6ii8o03rijMpHG5dG/uHf8bXUu28AZmY2wG1su/apphQYa
         xPxF3YWLwnMUCA46KZosUIADedRe1rDEj0LWsDZbsSnEoKk+nRDEgWvXKqTE2mus/xuz
         4ZRG0BpupdYGiBUnLAOppayd5/pZgooSLw51oxHCyDgU9ZynOp5xDWI4K/cW6MxsAWVK
         JsJDqGZbhzBUlzKm+lGS0r4POgZjeiQKY4nu0qHIiUCvwAP+eyxXGl6kNK3NfqJpR1A+
         CD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QTXtYshgBx4QZ9Jmd3XHSEpqTndirQEx843ji2frBOM=;
        b=galNFZFS7/FyxfG6hl94hr+0zIoXnPxhT6nIfHOmU/Z6fM9UIWJulp9P9Sbb4MJS+8
         bfseezNDt5JWhumiPNh0ZvML+fPyC3f9jdefXD/6J5UpnQODCsDTxafBuDmemtS8dUPd
         e7UrUIu7SeYvSTy6dmTexfQp7MX+O22FjactZ9R7Hr9JZ1vBNmUHfrbkElp+4fz94O2g
         uTA8V2H9Yod1hxntz9Lfe+Iti+fpa4CiulovW9uht7OsdAKRu1Anshfn7Fon4a4vlRMb
         Ff/5PeOMmcYYddj04Lax9T68OZpCh5SOaEPdiN/36gQ0WAE9Z2Q0Q/r3K/g+hBd4iOhR
         Rssw==
X-Gm-Message-State: AOAM530B06tnolqyDK+671YVRVVsz9lr7R9Usmvs7NtA2Rp1v+rh1pjj
        RYZgdMafwYPlm0axRQ0OO9NPxQ==
X-Google-Smtp-Source: ABdhPJwlgxC+MdNtze1PJuL4IA6hBEtufWpP4Qsf9p8A8nMPOIhqSBUlUvidZh+eHIlpUrawaAYgyw==
X-Received: by 2002:a5d:44d1:: with SMTP id z17mr13893629wrr.423.1605838383568;
        Thu, 19 Nov 2020 18:13:03 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id c187sm2918261wmd.23.2020.11.19.18.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 18:13:02 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org, benl@squareup.com
Subject: [PATCH] wcn36xx: Don't run scan_init multiple times
Date:   Fri, 20 Nov 2020 02:14:02 +0000
Message-Id: <20201120021403.2646574-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Run scan_init only once. There's no need to run this command multiple times
if it has already been run once.

The software scan algorithm can end up repeatedly calling scan_init on each
loop resulting in between four and eight milliseconds of lost time on each
callout.

Subtract the overhead now.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c     | 6 ++++++
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index acf533fae46a..ec082cf3ab09 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -706,6 +706,10 @@ int wcn36xx_smd_init_scan(struct wcn36xx *wcn, enum wcn36xx_hal_sys_mode mode,
 	int ret;
 
 	mutex_lock(&wcn->hal_mutex);
+	if (wcn->scan_init) {
+		ret = 0;
+		goto out;
+	}
 	INIT_HAL_MSG(msg_body, WCN36XX_HAL_INIT_SCAN_REQ);
 
 	msg_body.mode = mode;
@@ -731,6 +735,7 @@ int wcn36xx_smd_init_scan(struct wcn36xx *wcn, enum wcn36xx_hal_sys_mode mode,
 		wcn36xx_err("hal_init_scan response failed err=%d\n", ret);
 		goto out;
 	}
+	wcn->scan_init = true;
 out:
 	mutex_unlock(&wcn->hal_mutex);
 	return ret;
@@ -761,6 +766,7 @@ int wcn36xx_smd_start_scan(struct wcn36xx *wcn, u8 scan_channel)
 		wcn36xx_err("hal_start_scan response failed err=%d\n", ret);
 		goto out;
 	}
+	wcn->scan_init = false;
 out:
 	mutex_unlock(&wcn->hal_mutex);
 	return ret;
diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
index 71fa9992b118..156df6d184c8 100644
--- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
+++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
@@ -235,6 +235,7 @@ struct wcn36xx {
 	struct ieee80211_vif	*sw_scan_vif;
 	struct mutex		scan_lock;
 	bool			scan_aborted;
+	bool			scan_init;
 
 	/* DXE channels */
 	struct wcn36xx_dxe_ch	dxe_tx_l_ch;	/* TX low */
-- 
2.28.0

