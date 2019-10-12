Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73B88D4BCC
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Oct 2019 03:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfJLB1Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Oct 2019 21:27:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38210 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfJLB1Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Oct 2019 21:27:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id h195so7065955pfe.5
        for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2019 18:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C+RPiOySyp0KKixv/e0AjYvT1LgmjR0sE/np4+YU9pA=;
        b=GlDOfVzB+snPT49K/0DPuMKNzaD1OBzBNd8axQQBN0IGFvIRqYBFdSU7KcIKKvDXzi
         uwfDhrPOwhSRbBuIa5avI/1uQ1AgQmy3x91vxUIYHUEZ+7+1FsqPIf22L2jOnqsfSCIM
         w1U4iWAcOYqfC4EiKGsoYyN+cVgpVgqLDnlJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C+RPiOySyp0KKixv/e0AjYvT1LgmjR0sE/np4+YU9pA=;
        b=BYf1EcbkiKuDITJR0rbKdOcH261mwa4i3OSgdjjgOaiifr6NsIh35trtV+sYOp0ACh
         ye7j8bA+GFD7MNMOyCRZZdb9nIjC7LO/FrmwpLTH0kaggMcNcSq/PCTcieYUyDOGgIo+
         7jHhiy0/FRQ+WBuNq/Nn3kS5YfA2Ch3mbIs38Tys+SalPsXchKfL25pV+nB2AlMJPX9K
         3qAyWnqooCGhQjWj6rj/nJPzy2TDt1LhQCIhO9Bg6OvVJQ0kaybp55tJWa2RXyf5uWae
         ihTSiXraJYy3qdprjWkhH1DHQz8Ilmy3Sbv4v2mEoHSeLjSO7QXAF6jeVdDiRTqeQ9cn
         OXww==
X-Gm-Message-State: APjAAAUWbuAHPIirDo2D6r4awx4u4fzH4I5g5P74f+mNcGEVYhL0J/k3
        1L1NNw34ce+hIyc7idQh/xaOdWsqzXY=
X-Google-Smtp-Source: APXvYqwdSLmpjbC0Mqcc6Iss2B6Czwa1nD8+o3+xg6du6KOS/vIdsLiL9ml58x0OXM0/720SblumeQ==
X-Received: by 2002:a65:5a81:: with SMTP id c1mr7448702pgt.245.1570843644180;
        Fri, 11 Oct 2019 18:27:24 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id a16sm11510552pfa.53.2019.10.11.18.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 18:27:22 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     <linux-wireless@vger.kernel.org>
Cc:     Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] rtw88: use a for loop in rtw_power_mode_change(), not goto
Date:   Fri, 11 Oct 2019 18:27:20 -0700
Message-Id: <20191012012720.227399-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

No change in logic.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/realtek/rtw88/ps.c | 61 ++++++++++++-------------
 1 file changed, 29 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/ps.c b/drivers/net/wireless/realtek/rtw88/ps.c
index e81de3ddc8c5..820e0a3a141c 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.c
+++ b/drivers/net/wireless/realtek/rtw88/ps.c
@@ -69,24 +69,26 @@ void rtw_power_mode_change(struct rtw_dev *rtwdev, bool enter)
 	u8 polling_cnt;
 	u8 retry_cnt = 0;
 
-retry:
-	request = rtw_read8(rtwdev, rtwdev->hci.rpwm_addr);
-	confirm = rtw_read8(rtwdev, rtwdev->hci.cpwm_addr);
-
-	/* toggle to request power mode, others remain 0 */
-	request ^= request | BIT_RPWM_TOGGLE;
-	if (!enter) {
-		request |= POWER_MODE_ACK;
-	} else {
-		request |= POWER_MODE_LCLK;
-		if (rtw_fw_lps_deep_mode == LPS_DEEP_MODE_PG)
-			request |= POWER_MODE_PG;
-	}
+	for (retry_cnt = 0; retry_cnt < 3; retry_cnt++) {
+		request = rtw_read8(rtwdev, rtwdev->hci.rpwm_addr);
+		confirm = rtw_read8(rtwdev, rtwdev->hci.cpwm_addr);
+
+		/* toggle to request power mode, others remain 0 */
+		request ^= request | BIT_RPWM_TOGGLE;
+		if (!enter) {
+			request |= POWER_MODE_ACK;
+		} else {
+			request |= POWER_MODE_LCLK;
+			if (rtw_fw_lps_deep_mode == LPS_DEEP_MODE_PG)
+				request |= POWER_MODE_PG;
+		}
 
-	rtw_write8(rtwdev, rtwdev->hci.rpwm_addr, request);
+		rtw_write8(rtwdev, rtwdev->hci.rpwm_addr, request);
+
+		if (enter)
+			return;
 
-	/* check confirm power mode has left power save state */
-	if (!enter) {
+		/* check confirm power mode has left power save state */
 		for (polling_cnt = 0; polling_cnt < 3; polling_cnt++) {
 			polling = rtw_read8(rtwdev, rtwdev->hci.cpwm_addr);
 			if ((polling ^ confirm) & BIT_RPWM_TOGGLE)
@@ -94,23 +96,18 @@ void rtw_power_mode_change(struct rtw_dev *rtwdev, bool enter)
 			mdelay(20);
 		}
 
-		/* in case of fw/hw missed the request, retry 3 times */
-		if (retry_cnt < 3) {
-			rtw_warn(rtwdev, "failed to leave deep PS, retry=%d\n",
-				 retry_cnt);
-			retry_cnt++;
-			goto retry;
-		}
-
-		/* Hit here means that driver failed to change hardware
-		 * power mode to active state after retry 3 times.
-		 * If the power state is locked at Deep sleep, most of
-		 * the hardware circuits is not working, even register
-		 * read/write. It should be treated as fatal error and
-		 * requires an entire analysis about the firmware/hardware
-		 */
-		WARN(1, "Hardware power state locked\n");
+		/* in case of fw/hw missed the request, retry */
+		rtw_warn(rtwdev, "failed to leave deep PS, retry=%d\n",
+			 retry_cnt);
 	}
+
+	/* Hit here means that driver failed to change hardware power mode to
+	 * active state after retry 3 times. If the power state is locked at
+	 * Deep sleep, most of the hardware circuits is not working, even
+	 * register read/write. It should be treated as fatal error and
+	 * requires an entire analysis about the firmware/hardware
+	 */
+	WARN(1, "Hardware power state locked\n");
 }
 EXPORT_SYMBOL(rtw_power_mode_change);
 
-- 
2.23.0.700.g56cf767bdb-goog

