Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0443F2EA8BA
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Jan 2021 11:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbhAEKa0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Jan 2021 05:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbhAEKa0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Jan 2021 05:30:26 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009A7C061794
        for <linux-wireless@vger.kernel.org>; Tue,  5 Jan 2021 02:29:45 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kwjaI-001w9Z-Ue; Tue, 05 Jan 2021 11:29:41 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] cfg80211: fix kernel-doc formatting in SAR struct
Date:   Tue,  5 Jan 2021 11:29:34 +0100
Message-Id: <20210105112933.89b3c8691f21.I8b9f0a9cbfe186931ef9640046f414371f216914@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

A stray @ caused the kernel-doc parser to not understand
this, fix that.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 6bdb68cef7bf ("nl80211: add common API to configure SAR power limitations")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9a4bbccddc7f..fa5b7ed17f1f 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1756,7 +1756,7 @@ struct cfg80211_sar_specs {
 
 
 /**
- * @struct cfg80211_sar_chan_ranges - sar frequency ranges
+ * struct cfg80211_sar_chan_ranges - sar frequency ranges
  * @start_freq:  start range edge frequency
  * @end_freq:    end range edge frequency
  */
-- 
2.26.2

