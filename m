Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC306B637C
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2019 14:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbfIRMnt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Sep 2019 08:43:49 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:48108 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfIRMnt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Sep 2019 08:43:49 -0400
Received: from sven-desktop.home.narfation.org (p200300C5971113F0000000000000063E.dip0.t-ipconnect.de [IPv6:2003:c5:9711:13f0::63e])
        by dvalin.narfation.org (Postfix) with ESMTPSA id 52CB51FFEB;
        Wed, 18 Sep 2019 12:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1568808860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gzPDyIMIaUGxpPf8zpfkpolm0+8RtD4quOKbPD696OM=;
        b=xlln9LWSj/r4A2KZ3YPb9tPKgVJ0lpV4Tiu4pLDZ2d+hkstoRMP7sBH+9+KVHGsd1i00dI
        KvbvIQlFrh+DYurMKzhpAS5k4BvH1tpvWNbT5BJeC675FSHr9Cg3sQwWyZ8XlsFuO/TmUm
        NX4vd2+21byi9EcPb8xNODnJUJ4wAoc=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath10k@lists.infradead.org
Cc:     vnaralas@codeaurora.org, linux-wireless@vger.kernel.org,
        Sven Eckelmann <seckelmann@datto.com>
Subject: [RFC PATCH 1/2] ath10k: report survey info as accumulated values
Date:   Wed, 18 Sep 2019 14:42:58 +0200
Message-Id: <20190918124259.17804-2-sven@narfation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190918124259.17804-1-sven@narfation.org>
References: <20190918124259.17804-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1568808860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gzPDyIMIaUGxpPf8zpfkpolm0+8RtD4quOKbPD696OM=;
        b=rUnU48TP0acwxixmbFOqk6BfHxpQ6C3ZSbZnRQ6cyDe15zjxbNh7CcodwgV3Bo/dOpf8eV
        ms3ZKDZcaMrJNKzG+9Pm+cxjyZwAv4HfX4OV7zQjJYyG/o0es9E1s9vnsnKy+U4kDIV5Y+
        8iHNlliqdy5PUFs8mYBfqfG45lf3q1c=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1568808860; a=rsa-sha256;
        cv=none;
        b=v8BNP9yj1+KWJjGUS4GtuehjRn+VCCMBvLuqNfBOKFlj4+71MeHzvV6DLPsmPh1vC0H2wu
        1fcAODjZr4rzCgYyc//Fk7Wq27FQk3v7MV3iHK7cN1nPJ8cld6fldXAXy5LOs3obvFufht
        1r5fFfIyxxYTeO9QRqr3LlMBNjo9DX8=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sven Eckelmann <seckelmann@datto.com>

The survey report is expected to contain a counter which is increasing all
the time. But ath10k reports some kind of delta. This can either be the
difference to the last get_survey or the difference to some even older
get_survey because the values are sometimes cached and sometimes
overwritten.

To make the returned values useful, they must be accumulated manually by
ath10k before send out to the upper layers. Special care must be taken when
accepting values from older firmware versions (which use
ATH10K_HW_CC_WRAP_SHIFTED_ALL) because they will not clear the cycle_busy
and cycle_total counter and will only use 31 bit of the 64 but counter.

Tested on QCA988x hw2.0 10.2.4-1.0-00043
Tested on QCA99x0 hw2.0 10.4.1.00030-1
Tested in QCA4019 hw1.0 10.4-3.5.3-00057

Signed-off-by: Sven Eckelmann <seckelmann@datto.com>
---
 drivers/net/wireless/ath/ath10k/core.h |  2 +
 drivers/net/wireless/ath/ath10k/hw.c   | 13 +++--
 drivers/net/wireless/ath/ath10k/wmi.c  | 66 ++++++++++++++++++++++----
 3 files changed, 66 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index 4d7db07db6ba..25c699f3a73b 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -1127,6 +1127,8 @@ struct ath10k {
 	u32 survey_last_rx_clear_count;
 	u32 survey_last_cycle_count;
 	struct survey_info survey[ATH10K_NUM_CHANS];
+	u64 survey_last_total_cc[ATH10K_NUM_CHANS];
+	u64 survey_last_busy_cc[ATH10K_NUM_CHANS];
 
 	/* Channel info events are expected to come in pairs without and with
 	 * COMPLETE flag set respectively for each channel visit during scan.
diff --git a/drivers/net/wireless/ath/ath10k/hw.c b/drivers/net/wireless/ath/ath10k/hw.c
index c415e971735b..68ffdb8b8eaa 100644
--- a/drivers/net/wireless/ath/ath10k/hw.c
+++ b/drivers/net/wireless/ath/ath10k/hw.c
@@ -548,9 +548,10 @@ void ath10k_hw_fill_survey_time(struct ath10k *ar, struct survey_info *survey,
 	u32 cc_fix = 0;
 	u32 rcc_fix = 0;
 	enum ath10k_hw_cc_wraparound_type wraparound_type;
+	u32 filled = 0;
 
-	survey->filled |= SURVEY_INFO_TIME |
-			  SURVEY_INFO_TIME_BUSY;
+	filled |= SURVEY_INFO_TIME |
+		  SURVEY_INFO_TIME_BUSY;
 
 	wraparound_type = ar->hw_params.cc_wraparound_type;
 
@@ -559,7 +560,7 @@ void ath10k_hw_fill_survey_time(struct ath10k *ar, struct survey_info *survey,
 		case ATH10K_HW_CC_WRAP_SHIFTED_ALL:
 			if (cc < cc_prev) {
 				cc_fix = 0x7fffffff;
-				survey->filled &= ~SURVEY_INFO_TIME_BUSY;
+				filled &= ~SURVEY_INFO_TIME_BUSY;
 			}
 			break;
 		case ATH10K_HW_CC_WRAP_SHIFTED_EACH:
@@ -577,8 +578,10 @@ void ath10k_hw_fill_survey_time(struct ath10k *ar, struct survey_info *survey,
 	cc -= cc_prev - cc_fix;
 	rcc -= rcc_prev - rcc_fix;
 
-	survey->time = CCNT_TO_MSEC(ar, cc);
-	survey->time_busy = CCNT_TO_MSEC(ar, rcc);
+	survey->filled |= filled;
+	survey->time += CCNT_TO_MSEC(ar, cc);
+	if (survey->filled & SURVEY_INFO_TIME_BUSY)
+		survey->time_busy += CCNT_TO_MSEC(ar, rcc);
 }
 
 /* The firmware does not support setting the coverage class. Instead this
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 4f707c6394bb..19667e2f22fa 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -5662,10 +5662,38 @@ static int ath10k_wmi_event_temperature(struct ath10k *ar, struct sk_buff *skb)
 	return 0;
 }
 
+static void ath10k_clean_survey(struct ath10k *ar, struct survey_info *survey,
+				int idx, u64 total, u64 busy)
+{
+	u32 total_diff;
+	u32 busy_diff;
+
+	lockdep_assert_held(&ar->data_lock);
+
+	if (ar->hw_params.cc_wraparound_type != ATH10K_HW_CC_WRAP_SHIFTED_ALL)
+		return;
+
+	if (total < ar->survey_last_total_cc[idx]) {
+		total_diff = total + 0x7fffffff - ar->survey_last_total_cc[idx];
+		busy_diff = 0;
+		survey->filled &= ~SURVEY_INFO_TIME_BUSY;
+	} else {
+		total_diff = total - ar->survey_last_total_cc[idx];
+		busy_diff = busy - ar->survey_last_busy_cc[idx];
+	}
+
+	survey->time      = CCNT_TO_MSEC(ar, total_diff);
+	survey->time_busy = CCNT_TO_MSEC(ar, busy_diff);
+
+	ar->survey_last_total_cc[idx] = total;
+	ar->survey_last_busy_cc[idx] = busy;
+}
+
 static int ath10k_wmi_event_pdev_bss_chan_info(struct ath10k *ar,
 					       struct sk_buff *skb)
 {
 	struct wmi_pdev_bss_chan_info_event *ev;
+	struct survey_info survey_tmp = {};
 	struct survey_info *survey;
 	u64 busy, total, tx, rx, rx_bss;
 	u32 freq, noise_floor;
@@ -5688,6 +5716,13 @@ static int ath10k_wmi_event_pdev_bss_chan_info(struct ath10k *ar,
 		   "wmi event pdev bss chan info:\n freq: %d noise: %d cycle: busy %llu total %llu tx %llu rx %llu rx_bss %llu\n",
 		   freq, noise_floor, busy, total, tx, rx, rx_bss);
 
+	/* everything zero means invalid data
+	 * -> drop it to avoid bogus noisefloor in survey report
+	 */
+	if (noise_floor == 0 && busy == 0 && total == 0 && tx == 0 && rx == 0 &&
+	    rx_bss == 0)
+		return -EPROTO;
+
 	spin_lock_bh(&ar->data_lock);
 	idx = freq_to_idx(ar, freq);
 	if (idx >= ARRAY_SIZE(ar->survey)) {
@@ -5696,18 +5731,29 @@ static int ath10k_wmi_event_pdev_bss_chan_info(struct ath10k *ar,
 		goto exit;
 	}
 
+	/* create delta result - might need fix of counters */
+	survey_tmp.noise     = noise_floor;
+	survey_tmp.time      = div_u64(total, cc_freq_hz);
+	survey_tmp.time_busy = div_u64(busy, cc_freq_hz);
+	survey_tmp.time_rx   = div_u64(rx_bss, cc_freq_hz);
+	survey_tmp.time_tx   = div_u64(tx, cc_freq_hz);
+	survey_tmp.filled    = (SURVEY_INFO_NOISE_DBM |
+				SURVEY_INFO_TIME |
+				SURVEY_INFO_TIME_BUSY |
+				SURVEY_INFO_TIME_RX |
+				SURVEY_INFO_TIME_TX);
+
+	ath10k_clean_survey(ar, &survey_tmp, idx, total, busy);
+
+	/* create accumulated result */
 	survey = &ar->survey[idx];
 
-	survey->noise     = noise_floor;
-	survey->time      = div_u64(total, cc_freq_hz);
-	survey->time_busy = div_u64(busy, cc_freq_hz);
-	survey->time_rx   = div_u64(rx_bss, cc_freq_hz);
-	survey->time_tx   = div_u64(tx, cc_freq_hz);
-	survey->filled   |= (SURVEY_INFO_NOISE_DBM |
-			     SURVEY_INFO_TIME |
-			     SURVEY_INFO_TIME_BUSY |
-			     SURVEY_INFO_TIME_RX |
-			     SURVEY_INFO_TIME_TX);
+	survey->noise      = survey_tmp.noise;
+	survey->time      += survey_tmp.time;
+	survey->time_busy += survey_tmp.time_busy;
+	survey->time_rx   += survey_tmp.time_rx;
+	survey->time_tx   += survey_tmp.time_tx;
+	survey->filled    |= survey_tmp.filled;
 exit:
 	spin_unlock_bh(&ar->data_lock);
 	complete(&ar->bss_survey_done);
-- 
2.20.1

