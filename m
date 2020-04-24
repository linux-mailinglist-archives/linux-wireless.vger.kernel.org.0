Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E8A1B6A7E
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 02:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgDXAto (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Apr 2020 20:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbgDXAtn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Apr 2020 20:49:43 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F19C09B042
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2020 17:49:43 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 131so6248387lfh.11
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2020 17:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ibCU6yGuhLZYeWcolU23X1L8peHTgnL1gQpl7z0+cJU=;
        b=Hb7n9dPdcCj8dvRB3hyPNe4e/JwRDMgJIQxC9QHn7UcG+7NpMp1enYCwZ9HnWkRYuC
         1NTUrdCczB1Hvd0605aRTHBOhOYAwfvYIFosQ3zSWmJP3y0yYGUj65Sie05ueTFLYRrq
         bny6bAMwEDI7H/K+ClGp7Db4juVEf3Ku0gUqNrT5hemjnVEIL263tC8xHjM+u653d3QT
         VVN/OJoSx/aP3MFSfJWcJw5ANvom1e9rKrEdk/lvw7Ib4a1nj3Cd6D2uKAbqNSV4aIu3
         4ddVSRlRiDh+xrg4tAbplRRZu8LRTQauBqkw4YVQX2X13RY3KLOkEFIxzMproK6ghN7X
         OryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ibCU6yGuhLZYeWcolU23X1L8peHTgnL1gQpl7z0+cJU=;
        b=Q3p7QLF1gEt81hww0uTUipNqleNgCdo+fzHUAfDPAu6uqQRGNIH23QkbHS4gLBNycD
         7VtBxI7r4MVcYe8hxmG+u5J6eCn07+2+VH4UNzqPB3r2fBFAmZBQp2qeZr3o5Vu+XmrJ
         910ZoPCOCUIFNNHhaSSd4KTc68YMPaKhEfRDk07Ao1q4yn4YgaaDvVJVmK5gX0pk5s30
         CoPSSCZNNBKx6xel0KZneRiXisP9mFQJHvUrbYbsW+xixmQgydgs/kJ/0pqn0hvDYNt7
         BZtWI4pps85nK9VwwF//eTgujvLasxaB+edcgrc7QiF1U5UV/B8Xw5BCbO7g+2fq3F99
         qS4Q==
X-Gm-Message-State: AGi0Pubu9oUrbp0QOk4ZvvwlYKRi1bCR4wqGUouEmV7DHH5s3DylY1fx
        zfWpLaA1K0y9a4c8fCOUeG8WXM/E
X-Google-Smtp-Source: APiQypLxEhLGTV9+Tpy5W3eJdHYq0eBwScHTl9OFTZ098wuMsJcjcyq5cm5LN9Hh8fYzzMnOTmvDXg==
X-Received: by 2002:a05:6512:304e:: with SMTP id b14mr3963898lfb.119.1587689381690;
        Thu, 23 Apr 2020 17:49:41 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by smtp.gmail.com with ESMTPSA id r12sm1555056ljc.12.2020.04.23.17.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 17:49:41 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH 6/6] ath9k: add calibration timeout for AR9002
Date:   Fri, 24 Apr 2020 03:49:23 +0300
Message-Id: <20200424004923.17129-7-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200424004923.17129-1-ryazanov.s.a@gmail.com>
References: <20200424004923.17129-1-ryazanov.s.a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ADC & I/Q calibrations could take infinite time to comple, since they
depend on received frames. In particular the I/Q mismatch calibration
requires receiving of OFDM frames for completion. But in the 2.4GHz
band, a station could receive only CCK frames for a very long time.

And while we wait for the completion of one of the mentioned
calibrations, the NF calibration is blocked. Moreover, in some
environments, I/Q calibration is unable to complete until a correct
noise calibration will be performed due to AGC behaviour.

In order to avoid delaying NF calibration on forever, limit the maximum
duration of ADCs & I/Q calibrations. If the calibration is not completed
within the maximum time, it will be interrupted and a next calibration
will be performed. The code that selects the next calibration has been
reworked to the loop so incompleted calibration will be respinned later.

А maximum calibration time of 30 seconds was selected to give the
calibration enough time to complete and to not interfere with the long
(NF) calibration.

Run tested with AR9220.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
 drivers/net/wireless/ath/ath9k/ar9002_calib.c | 25 +++++++++++++++++--
 drivers/net/wireless/ath/ath9k/calib.c        |  1 +
 drivers/net/wireless/ath/ath9k/hw.h           |  1 +
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9002_calib.c b/drivers/net/wireless/ath/ath9k/ar9002_calib.c
index 68188f500949..fd53b5f9e9b5 100644
--- a/drivers/net/wireless/ath/ath9k/ar9002_calib.c
+++ b/drivers/net/wireless/ath/ath9k/ar9002_calib.c
@@ -19,6 +19,8 @@
 #include "ar9002_phy.h"
 
 #define AR9285_CLCAL_REDO_THRESH    1
+/* AGC & I/Q calibrations time limit, ms */
+#define AR9002_CAL_MAX_TIME		30000
 
 enum ar9002_cal_types {
 	ADC_GAIN_CAL = BIT(0),
@@ -104,6 +106,14 @@ static bool ar9002_hw_per_calibration(struct ath_hw *ah,
 			} else {
 				ar9002_hw_setup_calibration(ah, currCal);
 			}
+		} else if (time_after(jiffies, ah->cal_start_time +
+				      msecs_to_jiffies(AR9002_CAL_MAX_TIME))) {
+			REG_CLR_BIT(ah, AR_PHY_TIMING_CTRL4(0),
+				    AR_PHY_TIMING_CTRL4_DO_CAL);
+			ath_dbg(ath9k_hw_common(ah), CALIBRATE,
+				"calibration timeout\n");
+			currCal->calState = CAL_WAITING;	/* Try later */
+			iscaldone = true;
 		}
 	} else if (!(caldata->CalValid & currCal->calData->calType)) {
 		ath9k_hw_reset_calibration(ah, currCal);
@@ -679,8 +689,19 @@ static int ar9002_hw_calibrate(struct ath_hw *ah, struct ath9k_channel *chan,
 		if (!ar9002_hw_per_calibration(ah, chan, rxchainmask, currCal))
 			return 0;
 
-		ah->cal_list_curr = currCal = currCal->calNext;
-		percal_pending = currCal->calState == CAL_WAITING;
+		/* Looking for next waiting calibration if any */
+		for (currCal = currCal->calNext; currCal != ah->cal_list_curr;
+		     currCal = currCal->calNext) {
+			if (currCal->calState == CAL_WAITING)
+				break;
+		}
+		if (currCal->calState == CAL_WAITING) {
+			percal_pending = true;
+			ah->cal_list_curr = currCal;
+		} else {
+			percal_pending = false;
+			ah->cal_list_curr = ah->cal_list;
+		}
 	}
 
 	/* Do not start a next calibration if the longcal is in action */
diff --git a/drivers/net/wireless/ath/ath9k/calib.c b/drivers/net/wireless/ath/ath9k/calib.c
index 2ac3eefd3851..0422a33395b7 100644
--- a/drivers/net/wireless/ath/ath9k/calib.c
+++ b/drivers/net/wireless/ath/ath9k/calib.c
@@ -176,6 +176,7 @@ void ath9k_hw_reset_calibration(struct ath_hw *ah,
 
 	ath9k_hw_setup_calibration(ah, currCal);
 
+	ah->cal_start_time = jiffies;
 	currCal->calState = CAL_RUNNING;
 
 	for (i = 0; i < AR5416_MAX_CHAINS; i++) {
diff --git a/drivers/net/wireless/ath/ath9k/hw.h b/drivers/net/wireless/ath/ath9k/hw.h
index c99f3c77c823..023599e10dd5 100644
--- a/drivers/net/wireless/ath/ath9k/hw.h
+++ b/drivers/net/wireless/ath/ath9k/hw.h
@@ -834,6 +834,7 @@ struct ath_hw {
 
 	/* Calibration */
 	u32 supp_cals;
+	unsigned long cal_start_time;
 	struct ath9k_cal_list iq_caldata;
 	struct ath9k_cal_list adcgain_caldata;
 	struct ath9k_cal_list adcdc_caldata;
-- 
2.24.1

