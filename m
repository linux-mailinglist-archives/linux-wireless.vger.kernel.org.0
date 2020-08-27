Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59CE255132
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Aug 2020 00:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgH0Wdr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 18:33:47 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:50616 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728068AbgH0Wdr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 18:33:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 522B24F8538;
        Thu, 27 Aug 2020 22:33:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XnUr2SE02OUD; Thu, 27 Aug 2020 22:33:43 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 015324F827F;
        Thu, 27 Aug 2020 22:33:13 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH 20/22] nl80211: include frequency offset in survey info
Date:   Thu, 27 Aug 2020 15:33:02 -0700
Message-Id: <20200827223304.16155-21-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827223304.16155-1-thomas@adapt-ip.com>
References: <20200827223304.16155-1-thomas@adapt-ip.com>
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
index 03f4d83da473..973b56c2226f 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4073,6 +4073,7 @@ enum nl80211_user_reg_hint_type {
  *	receiving frames destined to the local BSS
  * @NL80211_SURVEY_INFO_MAX: highest survey info attribute number
  *	currently defined
+ * @NL80211_SURVEY_INFO_FREQUENCY_OFFSET: center frequency offset in KHz
  * @__NL80211_SURVEY_INFO_AFTER_LAST: internal use
  */
 enum nl80211_survey_info {
@@ -4088,6 +4089,7 @@ enum nl80211_survey_info {
 	NL80211_SURVEY_INFO_TIME_SCAN,
 	NL80211_SURVEY_INFO_PAD,
 	NL80211_SURVEY_INFO_TIME_BSS_RX,
+	NL80211_SURVEY_INFO_FREQUENCY_OFFSET,
 
 	/* keep last */
 	__NL80211_SURVEY_INFO_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 5672abb34b86..750bef58b319 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -9119,6 +9119,11 @@ static int nl80211_send_survey(struct sk_buff *msg, u32 portid, u32 seq,
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

