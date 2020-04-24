Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85541B6A7B
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 02:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgDXAtl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Apr 2020 20:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbgDXAtk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Apr 2020 20:49:40 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE83CC09B042
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2020 17:49:39 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id u10so6274599lfo.8
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2020 17:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W2VxuGgPQg0BX0NNuAgyx42HRNt4gO8knSgu6spqd9A=;
        b=MaoIKNM6qLCqVN74eZUoO8dQIaXg1wRugqSkdOM+P6/NJ9HeG6KjEDuUu2rNpAYgKe
         7vtXLFhDSFebmqI1oUOQV0zkJG0kz1NXZvGZzOmT5O37G+OzzYkqbtj7apSV7QpYBCiG
         62HsbPMYBwyK31frmAjFX7u/6m+o7Fr7caoZ7BiopfGhmCFDJ8OSsyhicSZgLDaeXxnL
         HkyqaKEOmwRN8kAdX38s+HYwHQt+oUb1zDjbTWI/qWdpz+Dneh2S25ANezzjgr045k74
         1Yy6p+dkWHQu8CSBr9YZXEhM+cazLdHRyNdsw6puxgz5t/ToIaZSRVpxxBGNKb4j2N8Y
         Eweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W2VxuGgPQg0BX0NNuAgyx42HRNt4gO8knSgu6spqd9A=;
        b=pN+qWnBXWLoIoENh98qyhHPdO6jP2kTGFF7dXizS+fJL9WT+u/VqqD0rkAwbGfIlZt
         9G6SEahlC0XU43z6+WVH3YfLcNgXXHRkK9bpCf7t3ONtJOMQrMN0zYxMs4kJSiaHauwI
         Gk0G9/xPJWypOYdntPhFB1tZ3H3D/HqVjgKeoYukLnAQ7x8ZkFKvq1UYLNwmcWJ/nr7f
         izgM+4AGrgemZfkQxhbTVSuOahJ5RCJJd3GlpvQUkTnLcnH0wXID8vesQW6dAy0h47R0
         3rhFngVPQy40pgx1odr69UjGBo6zroPjSn+E4Jj5AMw5j4cT/G2LXxNBFTpsqGe7drOM
         Rr3g==
X-Gm-Message-State: AGi0PuaPZUlTzKYLtcN7W8eJ3UABdsII40SjGzsrbyKo7A2HFEvUNExU
        PF+mF/93O8qkhqJM+3BS8q32RkWu
X-Google-Smtp-Source: APiQypJW5v/1Q/Pnnlzy2KvZR94Jg9TObRBcqwOno7MSdmS817egr+/NIdI9Qj1e0/91BceROZWbKg==
X-Received: by 2002:a19:c78d:: with SMTP id x135mr4096890lff.151.1587689378419;
        Thu, 23 Apr 2020 17:49:38 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by smtp.gmail.com with ESMTPSA id r12sm1555056ljc.12.2020.04.23.17.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 17:49:37 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH 3/6] ath9k: do not miss longcal on AR9002
Date:   Fri, 24 Apr 2020 03:49:20 +0300
Message-Id: <20200424004923.17129-4-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200424004923.17129-1-ryazanov.s.a@gmail.com>
References: <20200424004923.17129-1-ryazanov.s.a@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Each of AGC & I/Q calibrations can take a long time. Long calibration
and NF calibration in particular are forbiden for parallel run with
ADC & I/Q calibrations. So, the chip could not be ready to perform the
long calibration at the time of request. And a request to perform the
long calibration may be lost.

In order to fix this, preserve the long calibration request as a
calibration state flag and restore the long calibration request each
time the calibration function is called again (i.e. on each subsequent
ivocation of the short calibration).

This feature will be twice useful after the next change, which will
make it possible to start the long calibration before all ADCs & I/Q
calibrations are completed.

Run tested with AR9220.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
 drivers/net/wireless/ath/ath9k/ar9002_calib.c | 10 +++++++++-
 drivers/net/wireless/ath/ath9k/hw.h           |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9002_calib.c b/drivers/net/wireless/ath/ath9k/ar9002_calib.c
index 0f7c5812e5c2..ad8db7720993 100644
--- a/drivers/net/wireless/ath/ath9k/ar9002_calib.c
+++ b/drivers/net/wireless/ath/ath9k/ar9002_calib.c
@@ -663,8 +663,13 @@ static int ar9002_hw_calibrate(struct ath_hw *ah, struct ath9k_channel *chan,
 	int ret;
 
 	nfcal = !!(REG_READ(ah, AR_PHY_AGC_CONTROL) & AR_PHY_AGC_CONTROL_NF);
-	if (ah->caldata)
+	if (ah->caldata) {
 		nfcal_pending = test_bit(NFCAL_PENDING, &ah->caldata->cal_flags);
+		if (longcal)		/* Remember to not miss */
+			set_bit(LONGCAL_PENDING, &ah->caldata->cal_flags);
+		else if (test_bit(LONGCAL_PENDING, &ah->caldata->cal_flags))
+			longcal = true;	/* Respin a previous one */
+	}
 
 	percal_pending = (currCal &&
 			  (currCal->calState == CAL_RUNNING ||
@@ -700,6 +705,9 @@ static int ar9002_hw_calibrate(struct ath_hw *ah, struct ath9k_channel *chan,
 		}
 
 		if (longcal) {
+			if (ah->caldata)
+				clear_bit(LONGCAL_PENDING,
+					  &ah->caldata->cal_flags);
 			ath9k_hw_start_nfcal(ah, false);
 			/* Do periodic PAOffset Cal */
 			ar9002_hw_pa_cal(ah, false);
diff --git a/drivers/net/wireless/ath/ath9k/hw.h b/drivers/net/wireless/ath/ath9k/hw.h
index 2e4489700a85..c99f3c77c823 100644
--- a/drivers/net/wireless/ath/ath9k/hw.h
+++ b/drivers/net/wireless/ath/ath9k/hw.h
@@ -427,6 +427,7 @@ enum ath9k_cal_flags {
 	TXIQCAL_DONE,
 	TXCLCAL_DONE,
 	SW_PKDET_DONE,
+	LONGCAL_PENDING,
 };
 
 struct ath9k_hw_cal_data {
-- 
2.24.1

