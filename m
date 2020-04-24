Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4421B6A7D
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 02:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgDXAto (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Apr 2020 20:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728480AbgDXAtm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Apr 2020 20:49:42 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CDAC09B042
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2020 17:49:42 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id u10so6274631lfo.8
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2020 17:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=enNVEIEyKc8khXu44plNNu16PsTEyKATqm81c6KZKDE=;
        b=CiEOTicGRsNjS1GnPyZExyFEMCK2xzGmbDVwBzRPoBXZ+g81nfMTy0nS9Pu3GrPKpK
         HXEfnTnCrqAEWpLtTXfx2GYwZZRDQUQqs3xswmW2aOS56RAS8oZSxql+2+uhwLkGIgHy
         rY+7XXOupwPqPTVrhLb0xJoclaw3CLYN/IS64hVGUI2/pM76PIHDHmZ3D9keqEfS+bsn
         bV/TNfYO7RgnrWiwUnsEW3xXnOx77/DcP3JOtETGd2qs7+DKcW2QSSD/Nh6PUo33Qid0
         LhkBeIiMip8MQpBiWfPuwJN0dM2p0md11jxFth2QU63uNTOPy+gOtECjrYEAVlMF4GR4
         vaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=enNVEIEyKc8khXu44plNNu16PsTEyKATqm81c6KZKDE=;
        b=JHqgaYgrC/r0v7gZxdNW9EB4XNvL8vgdYEN0VifOeHkc9hOQDNuw+/cb7jiBlVO+oe
         NDAuLzItMrLk+ZVSEglXp1zPxfBnXPpcE/kQ6Knr5b7MiyU8rFiVxpijZinm1oNzu/DK
         rJrZpeQ4KeprKjrxrdXxuZyAEqqpNLUnXYVfjP9TRuwweMPpVIqbffSElQvUNqUdhLb5
         6qqfn3DrnT7mih2Hcdk88O019dhmOMZUj++RfAiiXEbHgS6fPFd+qOVMTF5RRrEmE/ql
         2vQCY9QFmx5Uh+3qyPjocKVksIGTNmodOaPuBvzeSWLcWC6NY5klbksXkvBqtiYBfwBt
         dUjw==
X-Gm-Message-State: AGi0PuYy1arsYRZ4x1Wuzz3y6Cdjti3ugTENI+Xk1BMjjQ3gz07FIXZE
        lqC5ospqWqM0m8B2MSI/kEU=
X-Google-Smtp-Source: APiQypIqPLV0zJLFr5z1nqP9RFhCm3+3lTcHomAYsnYqXkLZTna1dg93yMhYj3oKAfZG/83+9I3jwA==
X-Received: by 2002:a19:c895:: with SMTP id y143mr4007457lff.123.1587689380652;
        Thu, 23 Apr 2020 17:49:40 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by smtp.gmail.com with ESMTPSA id r12sm1555056ljc.12.2020.04.23.17.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 17:49:40 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH 5/6] ath9k: invalidate all calibrations at once
Date:   Fri, 24 Apr 2020 03:49:22 +0300
Message-Id: <20200424004923.17129-6-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200424004923.17129-1-ryazanov.s.a@gmail.com>
References: <20200424004923.17129-1-ryazanov.s.a@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Previously after the calibration validity period is over,
calibrations are invalidated in a one at time manner. So, for AR9002
family, which has three calibrations, the full recalibration interval
becomes 3 x ATH_RESTART_CALINTERVAL. And each next calibration will be
separated by the ATH_RESTART_CALINTERVAL time from a previous one.

It seems like it is better to do whole recalibration at once. Also, this
change makes the driver behaviour a little simpler. So, invalidate all
calibrations at once at the end of the calibration validity interval.

This change affects only AR9002 chips family, since the AR9003 utilize
only a single calibration.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
 drivers/net/wireless/ath/ath9k/calib.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/calib.c b/drivers/net/wireless/ath/ath9k/calib.c
index 695c779ae8cf..2ac3eefd3851 100644
--- a/drivers/net/wireless/ath/ath9k/calib.c
+++ b/drivers/net/wireless/ath/ath9k/calib.c
@@ -209,14 +209,17 @@ bool ath9k_hw_reset_calvalid(struct ath_hw *ah)
 		return true;
 	}
 
-	if (!(ah->supp_cals & currCal->calData->calType))
-		return true;
+	currCal = ah->cal_list;
+	do {
+		ath_dbg(common, CALIBRATE, "Resetting Cal %d state for channel %u\n",
+			currCal->calData->calType,
+			ah->curchan->chan->center_freq);
 
-	ath_dbg(common, CALIBRATE, "Resetting Cal %d state for channel %u\n",
-		currCal->calData->calType, ah->curchan->chan->center_freq);
+		ah->caldata->CalValid &= ~currCal->calData->calType;
+		currCal->calState = CAL_WAITING;
 
-	ah->caldata->CalValid &= ~currCal->calData->calType;
-	currCal->calState = CAL_WAITING;
+		currCal = currCal->calNext;
+	} while (currCal != ah->cal_list);
 
 	return false;
 }
-- 
2.24.1

