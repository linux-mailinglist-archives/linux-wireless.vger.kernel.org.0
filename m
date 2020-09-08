Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72ABC261B86
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 21:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731489AbgIHTEQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 15:04:16 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:52822 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731745AbgIHTD7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 15:03:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 235194F9B1A;
        Tue,  8 Sep 2020 19:03:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 663mRQjQERGC; Tue,  8 Sep 2020 19:03:53 +0000 (UTC)
Received: from atlas.ibsgaard.io (c-73-223-60-234.hsd1.ca.comcast.net [73.223.60.234])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id EE4B04F9B1B;
        Tue,  8 Sep 2020 19:03:25 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v3 20/22] nl80211: include frequency offset in survey info
Date:   Tue,  8 Sep 2020 12:03:21 -0700
Message-Id: <20200908190323.15814-21-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200908190323.15814-1-thomas@adapt-ip.com>
References: <20200908190323.15814-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Recently channels gained a potential frequency offset, so
include this in the per-channel survey info.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 include/uapi/linux/nl80211.h | 2 ++
 net/wireless/nl80211.c       | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 70076492ebc9..dd5591794e48 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4085,6 +4085,7 @@ enum nl80211_user_reg_hint_type {
  *	receiving frames destined to the local BSS
  * @NL80211_SURVEY_INFO_MAX: highest survey info attribute number
  *	currently defined
+ * @NL80211_SURVEY_INFO_FREQUENCY_OFFSET: center frequency offset in KHz
  * @__NL80211_SURVEY_INFO_AFTER_LAST: internal use
  */
 enum nl80211_survey_info {
@@ -4100,6 +4101,7 @@ enum nl80211_survey_info {
 	NL80211_SURVEY_INFO_TIME_SCAN,
 	NL80211_SURVEY_INFO_PAD,
 	NL80211_SURVEY_INFO_TIME_BSS_RX,
+	NL80211_SURVEY_INFO_FREQUENCY_OFFSET,
 
 	/* keep last */
 	__NL80211_SURVEY_INFO_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 493813177df2..daf403bfa168 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -9224,6 +9224,11 @@ static int nl80211_send_survey(struct sk_buff *msg, u32 portid, u32 seq,
 			survey->channel->center_freq))
 		goto nla_put_failure;
 
+	if (survey->channel &&
+	    nla_put_u32(msg, NL80211_SURVEY_INFO_FREQUENCY_OFFSET,
+			survey->channel->freq_offset))
+		goto nla_put_failure;
+
 	if ((survey->filled & SURVEY_INFO_NOISE_DBM) &&
 	    nla_put_u8(msg, NL80211_SURVEY_INFO_NOISE, survey->noise))
 		goto nla_put_failure;
-- 
2.20.1

