Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D54D9FF9E
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2019 12:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfH1KUp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Aug 2019 06:20:45 -0400
Received: from nbd.name ([46.4.11.11]:55800 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfH1KUp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Aug 2019 06:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sYtIHDq0hXyvHzpMqvLCoQN2O7ptY9/XB+9t+gKTmzY=; b=K8wWR1unP5L/FSHLCkDYzE5BKO
        d5mgb0vQmEWds1udQ9xPJ0bVGuomTRYq+0mR4qZeLuAp7Z0qbhQ85XwWyq01XV+aGf5wgL/QzOW7w
        8MDpZUnupVR5HsdW1RUu1XOglYcsCAlnyB9ANEm//0L0TKzbt9I052QSGXWjbOp1oEgQ=;
Received: from p5b206034.dip0.t-ipconnect.de ([91.32.96.52] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1i2v4F-00057E-2V; Wed, 28 Aug 2019 12:20:43 +0200
Received: by maeck.local (Postfix, from userid 501)
        id 86C3F64CACDB; Wed, 28 Aug 2019 12:20:42 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH v2] cfg80211: add local BSS receive time to survey information
Date:   Wed, 28 Aug 2019 12:20:42 +0200
Message-Id: <20190828102042.58016-1-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is useful for checking how much airtime is being used up by other
transmissions on the channel, e.g. by calculating (time_rx - time_bss_rx)
or (time_busy - time_bss_rx - time_tx)

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/cfg80211.h       | 4 ++++
 include/uapi/linux/nl80211.h | 3 +++
 net/wireless/nl80211.c       | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 35ec1f0a2bf9..bf97c4f805d3 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -694,6 +694,7 @@ ieee80211_chandef_max_power(struct cfg80211_chan_def *chandef)
  * @SURVEY_INFO_TIME_RX: receive time was filled in
  * @SURVEY_INFO_TIME_TX: transmit time was filled in
  * @SURVEY_INFO_TIME_SCAN: scan time was filled in
+ * @SURVEY_INFO_TIME_BSS_RX: local BSS receive time was filled in
  *
  * Used by the driver to indicate which info in &struct survey_info
  * it has filled in during the get_survey().
@@ -707,6 +708,7 @@ enum survey_info_flags {
 	SURVEY_INFO_TIME_RX		= BIT(5),
 	SURVEY_INFO_TIME_TX		= BIT(6),
 	SURVEY_INFO_TIME_SCAN		= BIT(7),
+	SURVEY_INFO_TIME_BSS_RX		= BIT(8),
 };
 
 /**
@@ -723,6 +725,7 @@ enum survey_info_flags {
  * @time_rx: amount of time the radio spent receiving data
  * @time_tx: amount of time the radio spent transmitting data
  * @time_scan: amount of time the radio spent for scanning
+ * @time_bss_rx: amount of time the radio spent receiving data on a local BSS
  *
  * Used by dump_survey() to report back per-channel survey information.
  *
@@ -737,6 +740,7 @@ struct survey_info {
 	u64 time_rx;
 	u64 time_tx;
 	u64 time_scan;
+	u64 time_bss_rx;
 	u32 filled;
 	s8 noise;
 };
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 822851d369ab..e74cf4daad02 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3843,6 +3843,8 @@ enum nl80211_user_reg_hint_type {
  * @NL80211_SURVEY_INFO_TIME_SCAN: time the radio spent for scan
  *	(on this channel or globally)
  * @NL80211_SURVEY_INFO_PAD: attribute used for padding for 64-bit alignment
+ * @NL80211_SURVEY_INFO_TIME_BSS_RX: amount of time the radio spent
+ *	receiving local BSS data
  * @NL80211_SURVEY_INFO_MAX: highest survey info attribute number
  *	currently defined
  * @__NL80211_SURVEY_INFO_AFTER_LAST: internal use
@@ -3859,6 +3861,7 @@ enum nl80211_survey_info {
 	NL80211_SURVEY_INFO_TIME_TX,
 	NL80211_SURVEY_INFO_TIME_SCAN,
 	NL80211_SURVEY_INFO_PAD,
+	NL80211_SURVEY_INFO_TIME_BSS_RX,
 
 	/* keep last */
 	__NL80211_SURVEY_INFO_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 1a107f29016b..3eea7a6f9070 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -8777,6 +8777,10 @@ static int nl80211_send_survey(struct sk_buff *msg, u32 portid, u32 seq,
 	    nla_put_u64_64bit(msg, NL80211_SURVEY_INFO_TIME_SCAN,
 			      survey->time_scan, NL80211_SURVEY_INFO_PAD))
 		goto nla_put_failure;
+	if ((survey->filled & SURVEY_INFO_TIME_BSS_RX) &&
+	    nla_put_u64_64bit(msg, NL80211_SURVEY_INFO_TIME_BSS_RX,
+			      survey->time_bss_rx, NL80211_SURVEY_INFO_PAD))
+		goto nla_put_failure;
 
 	nla_nest_end(msg, infoattr);
 
-- 
2.17.0

