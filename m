Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20AFF2A664F
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Nov 2020 15:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgKDOZ3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Nov 2020 09:25:29 -0500
Received: from mx4.wp.pl ([212.77.101.12]:5168 "EHLO mx4.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726706AbgKDOZ3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Nov 2020 09:25:29 -0500
Received: (wp-smtpd smtp.wp.pl 12856 invoked from network); 4 Nov 2020 15:25:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1604499924; bh=ESomCmU4PjiZspcon6LqaGqIsjFF+wDZRpQQer8BBbk=;
          h=From:To:Cc:Subject;
          b=EdBjU1spG137hg4xq9yIREM7nSv1GKsgM7a6EZ4BjCNv7VBDEpC1ZQd1lwm70AFtQ
           ziCZNn7GY/9tvw5COcfwotV7+0ofsGGcnq4ay8XDh4eJQJLLDbbj5vjjdua0FN7BFG
           jCi85OC8IJubv/N54WCUxQt6JKid4/mzjPFTt/+g=
Received: from ip4-46-39-164-203.cust.nbox.cz (HELO localhost) (stf_xl@wp.pl@[46.39.164.203])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <linux-wireless@vger.kernel.org>; 4 Nov 2020 15:25:24 +0100
From:   stf_xl@wp.pl
To:     linux-wireless@vger.kernel.org
Cc:     Markov Mikhail <markov.mikhail@itmh.ru>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH v3] rt2x00: save survey for every channel visited
Date:   Wed,  4 Nov 2020 15:25:24 +0100
Message-Id: <20201104142524.94375-1-stf_xl@wp.pl>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: f870a0b896212b782c4b0a1d1dd109c6
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [gXIW]                               
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Markov Mikhail <markov.mikhail@itmh.ru>

rt2800 only gives you survey for current channel.

Survey-based ACS algorithms are failing to perform their job when working
with rt2800.

Make rt2800 save survey for every channel visited and be able to give away
that information.

There is a bug registered https://dev.archive.openwrt.org/ticket/19081 and
this patch solves the issue.

Signed-off-by: Markov Mikhail <markov.mikhail@itmh.ru>
sgruszka: remove unused variable
Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
v2: Changes are now aggregated in rt2800lib.c.
v3: remove unused variable

 .../net/wireless/ralink/rt2x00/rt2800lib.c    | 62 ++++++++++++++-----
 drivers/net/wireless/ralink/rt2x00/rt2x00.h   | 10 +++
 2 files changed, 56 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index fed6d21cd6ce..5264b0a1f098 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -1228,6 +1228,17 @@ static int rt2800_check_hung(struct data_queue *queue)
 	return queue->wd_count > 16;
 }
 
+static void rt2800_update_survey(struct rt2x00_dev *rt2x00dev)
+{
+	struct ieee80211_channel *chan = rt2x00dev->hw->conf.chandef.chan;
+	struct rt2x00_chan_survey *chan_survey =
+		   &rt2x00dev->chan_survey[chan->hw_value];
+
+	chan_survey->time_idle += rt2800_register_read(rt2x00dev, CH_IDLE_STA);
+	chan_survey->time_busy += rt2800_register_read(rt2x00dev, CH_BUSY_STA);
+	chan_survey->time_ext_busy += rt2800_register_read(rt2x00dev, CH_BUSY_STA_SEC);
+}
+
 void rt2800_watchdog(struct rt2x00_dev *rt2x00dev)
 {
 	struct data_queue *queue;
@@ -1237,6 +1248,8 @@ void rt2800_watchdog(struct rt2x00_dev *rt2x00dev)
 	if (test_bit(DEVICE_STATE_SCANNING, &rt2x00dev->flags))
 		return;
 
+	rt2800_update_survey(rt2x00dev);
+
 	queue_for_each(rt2x00dev, queue) {
 		switch (queue->qid) {
 		case QID_AC_VO:
@@ -5553,6 +5566,12 @@ void rt2800_config(struct rt2x00_dev *rt2x00dev,
 	rt2800_config_lna_gain(rt2x00dev, libconf);
 
 	if (flags & IEEE80211_CONF_CHANGE_CHANNEL) {
+		/*
+		 * To provide correct survey data for survey-based ACS algorithm
+		 * we have to save survey data for current channel before switching.
+		 */
+		rt2800_update_survey(rt2x00dev);
+
 		rt2800_config_channel(rt2x00dev, libconf->conf,
 				      &libconf->rf, &libconf->channel);
 		rt2800_config_txpower(rt2x00dev, libconf->conf->chandef.chan,
@@ -10111,12 +10130,20 @@ static int rt2800_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 	}
 
 	/*
-	 * Create channel information array
+	 * Create channel information and survey arrays
 	 */
 	info = kcalloc(spec->num_channels, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
+	rt2x00dev->chan_survey =
+		kcalloc(spec->num_channels, sizeof(struct rt2x00_chan_survey),
+			GFP_KERNEL);
+	if (!rt2x00dev->chan_survey) {
+		kfree(info);
+		return -ENOMEM;
+	}
+
 	spec->channels_info = info;
 
 	default_power1 = rt2800_eeprom_addr(rt2x00dev, EEPROM_TXPOWER_BG1);
@@ -10503,27 +10530,30 @@ int rt2800_get_survey(struct ieee80211_hw *hw, int idx,
 		      struct survey_info *survey)
 {
 	struct rt2x00_dev *rt2x00dev = hw->priv;
-	struct ieee80211_conf *conf = &hw->conf;
-	u32 idle, busy, busy_ext;
+	struct rt2x00_chan_survey *chan_survey =
+		   &rt2x00dev->chan_survey[idx];
+	enum nl80211_band band = NL80211_BAND_2GHZ;
 
-	if (idx != 0)
+	if (idx >= rt2x00dev->bands[band].n_channels) {
+		idx -= rt2x00dev->bands[band].n_channels;
+		band = NL80211_BAND_5GHZ;
+	}
+
+	if (idx >= rt2x00dev->bands[band].n_channels)
 		return -ENOENT;
 
-	survey->channel = conf->chandef.chan;
+	if (idx == 0)
+		rt2800_update_survey(rt2x00dev);
 
-	idle = rt2800_register_read(rt2x00dev, CH_IDLE_STA);
-	busy = rt2800_register_read(rt2x00dev, CH_BUSY_STA);
-	busy_ext = rt2800_register_read(rt2x00dev, CH_BUSY_STA_SEC);
+	survey->channel = &rt2x00dev->bands[band].channels[idx];
 
-	if (idle || busy) {
-		survey->filled = SURVEY_INFO_TIME |
-				 SURVEY_INFO_TIME_BUSY |
-				 SURVEY_INFO_TIME_EXT_BUSY;
+	survey->filled = SURVEY_INFO_TIME |
+			 SURVEY_INFO_TIME_BUSY |
+			 SURVEY_INFO_TIME_EXT_BUSY;
 
-		survey->time = (idle + busy) / 1000;
-		survey->time_busy = busy / 1000;
-		survey->time_ext_busy = busy_ext / 1000;
-	}
+	survey->time = div_u64(chan_survey->time_idle + chan_survey->time_busy, 1000);
+	survey->time_busy = div_u64(chan_survey->time_busy, 1000);
+	survey->time_ext_busy = div_u64(chan_survey->time_ext_busy, 1000);
 
 	if (!(hw->conf.flags & IEEE80211_CONF_OFFCHANNEL))
 		survey->filled |= SURVEY_INFO_IN_USE;
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00.h b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
index 780be81863b6..9f6fc40649be 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
@@ -181,6 +181,15 @@ struct rf_channel {
 	u32 rf4;
 };
 
+/*
+ * Information structure for channel survey.
+ */
+struct rt2x00_chan_survey {
+	u64 time_idle;
+	u64 time_busy;
+	u64 time_ext_busy;
+};
+
 /*
  * Channel information structure
  */
@@ -752,6 +761,7 @@ struct rt2x00_dev {
 	 */
 	struct ieee80211_hw *hw;
 	struct ieee80211_supported_band bands[NUM_NL80211_BANDS];
+	struct rt2x00_chan_survey *chan_survey;
 	enum nl80211_band curr_band;
 	int curr_freq;
 
-- 
2.25.4

