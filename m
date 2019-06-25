Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F67D52771
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 11:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbfFYJEF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 05:04:05 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:55456 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731137AbfFYJEF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 05:04:05 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hfhMv-00052B-WD; Tue, 25 Jun 2019 11:04:02 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] nl80211: fix VENDOR_CMD_RAW_DATA
Date:   Tue, 25 Jun 2019 11:03:55 +0200
Message-Id: <20190625090355.25335-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.17.2
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Since ERR_PTR() is an inline, not a macro, just open-code it
here so it's usable as an initializer, fixing the build in
brcmfmac.

Reported-by: Arend Van Spriel <arend.vanspriel@broadcom.com>
Fixes: 901bb9891855 ("nl80211: require and validate vendor command policy")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 8419195dfb99..21c3e3428c88 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4170,7 +4170,7 @@ struct sta_opmode_info {
 	u8 rx_nss;
 };
 
-#define VENDOR_CMD_RAW_DATA ((const struct nla_policy *)ERR_PTR(-ENODATA))
+#define VENDOR_CMD_RAW_DATA ((const struct nla_policy *)(long)(-ENODATA))
 
 /**
  * struct wiphy_vendor_command - vendor command definition
-- 
2.17.2

