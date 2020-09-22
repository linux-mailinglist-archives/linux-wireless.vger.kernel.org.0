Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58E6273A44
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 07:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgIVFhn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 01:37:43 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:34140 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728928AbgIVFhm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 01:37:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 66B2A4F9E15;
        Tue, 22 Sep 2020 05:37:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pmUVVcwvI6Kj; Tue, 22 Sep 2020 05:37:40 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id E83064F9E04;
        Tue, 22 Sep 2020 05:37:20 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v4 15/17] nl80211: include frequency offset in survey info
Date:   Mon, 21 Sep 2020 19:28:16 -0700
Message-Id: <20200922022818.15855-16-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200922022818.15855-1-thomas@adapt-ip.com>
References: <20200922022818.15855-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 84b37932f80f..31f99ba6210c 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4097,6 +4097,7 @@ enum nl80211_user_reg_hint_type {
  *	receiving frames destined to the local BSS
  * @NL80211_SURVEY_INFO_MAX: highest survey info attribute number
  *	currently defined
+ * @NL80211_SURVEY_INFO_FREQUENCY_OFFSET: center frequency offset in KHz
  * @__NL80211_SURVEY_INFO_AFTER_LAST: internal use
  */
 enum nl80211_survey_info {
@@ -4112,6 +4113,7 @@ enum nl80211_survey_info {
 	NL80211_SURVEY_INFO_TIME_SCAN,
 	NL80211_SURVEY_INFO_PAD,
 	NL80211_SURVEY_INFO_TIME_BSS_RX,
+	NL80211_SURVEY_INFO_FREQUENCY_OFFSET,
 
 	/* keep last */
 	__NL80211_SURVEY_INFO_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index fe25ac23d7e9..619c763ad83d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -9319,6 +9319,11 @@ static int nl80211_send_survey(struct sk_buff *msg, u32 portid, u32 seq,
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

