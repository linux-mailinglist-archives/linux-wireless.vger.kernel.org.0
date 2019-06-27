Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0616257FCB
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2019 11:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfF0J6l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jun 2019 05:58:41 -0400
Received: from nbd.name ([46.4.11.11]:44908 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbfF0J6l (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jun 2019 05:58:41 -0400
Received: from pd95fd902.dip0.t-ipconnect.de ([217.95.217.2] helo=bertha.datto.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hgRAt-0002NF-5S; Thu, 27 Jun 2019 11:58:39 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>
Subject: [PATCH] nl80211: fix NL80211_HE_MAX_CAPABILITY_LEN
Date:   Thu, 27 Jun 2019 11:58:32 +0200
Message-Id: <20190627095832.19445-1-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

NL80211_HE_MAX_CAPABILITY_LEN has changed between D2.0 and D4.0. It is now
MAC (6) + PHY (11) + MCS (12) + PPE (25) = 54.

Signed-off-by: John Crispin <john@phrozen.org>
---
 include/uapi/linux/nl80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 68ee35cbd75e..ceae54ea0ddf 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2868,7 +2868,7 @@ enum nl80211_attrs {
 #define NL80211_HT_CAPABILITY_LEN		26
 #define NL80211_VHT_CAPABILITY_LEN		12
 #define NL80211_HE_MIN_CAPABILITY_LEN           16
-#define NL80211_HE_MAX_CAPABILITY_LEN           51
+#define NL80211_HE_MAX_CAPABILITY_LEN           54
 #define NL80211_MAX_NR_CIPHER_SUITES		5
 #define NL80211_MAX_NR_AKM_SUITES		2
 
-- 
2.20.1

