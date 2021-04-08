Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B22358354
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Apr 2021 14:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhDHMcn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Apr 2021 08:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhDHMcj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Apr 2021 08:32:39 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED09C061760
        for <linux-wireless@vger.kernel.org>; Thu,  8 Apr 2021 05:32:28 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lUTpi-008zyV-Bq; Thu, 08 Apr 2021 14:32:26 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH] cfg80211: Remove wrong RNR IE validation check
Date:   Thu,  8 Apr 2021 14:32:24 +0200
Message-Id: <20210408143224.c7eeaf1a5270.Iead7762982e941a1cbff93f68bf8b5139447ff0c@changeid>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

Remove a wrong length check for RNR information element as it
can have arbitrary length.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 019952d4fc7d..c3b51efff5c6 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -589,7 +589,7 @@ static int cfg80211_parse_colocated_ap(const struct cfg80211_bss_ies *ies,
 
 	elem = cfg80211_find_elem(WLAN_EID_REDUCED_NEIGHBOR_REPORT, ies->data,
 				  ies->len);
-	if (!elem || elem->datalen > IEEE80211_MAX_SSID_LEN)
+	if (!elem)
 		return 0;
 
 	pos = elem->data;
-- 
2.30.2

