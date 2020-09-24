Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347B82777B7
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Sep 2020 19:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgIXRZW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Sep 2020 13:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbgIXRZU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Sep 2020 13:25:20 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D03C0613CE
        for <linux-wireless@vger.kernel.org>; Thu, 24 Sep 2020 10:25:20 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kLUzd-00AI43-JB; Thu, 24 Sep 2020 19:25:17 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/3] mac80211_hwsim: fix typo in kernel-doc
Date:   Thu, 24 Sep 2020 19:25:10 +0200
Message-Id: <20200924192511.6a344ebd8d65.Ie95a47db5887b8d2faa8ca2df474a955a376c4c4@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There's a stray _ in the kernel doc, remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index dce3bc9c9f84..d3d0fb85d667 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -99,7 +99,7 @@ MODULE_PARM_DESC(support_p2p_device, "Support P2P-Device interface type");
  * 	domain requests. The first radio will adhere to the first custom world
  * 	regulatory domain, the second one to the second custom world regulatory
  * 	domain. All other devices will world roam.
- * @HWSIM_REGTEST_STRICT_FOLLOW_: Used for testing strict regulatory domain
+ * @HWSIM_REGTEST_STRICT_FOLLOW: Used for testing strict regulatory domain
  *	settings, only the first radio will send a regulatory domain request
  *	and use strict settings. The rest of the radios are expected to follow.
  * @HWSIM_REGTEST_STRICT_ALL: Used for testing strict regulatory domain
-- 
2.26.2

