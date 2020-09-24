Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86882777B6
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Sep 2020 19:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbgIXRZW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Sep 2020 13:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbgIXRZV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Sep 2020 13:25:21 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52182C0613D4
        for <linux-wireless@vger.kernel.org>; Thu, 24 Sep 2020 10:25:20 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kLUze-00AI43-3W; Thu, 24 Sep 2020 19:25:18 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/3] wireless: radiotap: fix some kernel-doc
Date:   Thu, 24 Sep 2020 19:25:12 +0200
Message-Id: <20200924192511.2bf5cc761d3a.I9b4579ab3eebe3d7889b59eea8fa50d683611bab@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200924192511.6a344ebd8d65.Ie95a47db5887b8d2faa8ca2df474a955a376c4c4@changeid>
References: <20200924192511.6a344ebd8d65.Ie95a47db5887b8d2faa8ca2df474a955a376c4c4@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The vendor namespaces argument isn't described here, add it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/radiotap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/radiotap.c b/net/wireless/radiotap.c
index d5e28239e030..36f1b59a78bf 100644
--- a/net/wireless/radiotap.c
+++ b/net/wireless/radiotap.c
@@ -59,6 +59,7 @@ static const struct ieee80211_radiotap_namespace radiotap_ns = {
  * @iterator: radiotap_iterator to initialize
  * @radiotap_header: radiotap header to parse
  * @max_length: total length we can parse into (eg, whole packet length)
+ * @vns: vendor namespaces to parse
  *
  * Returns: 0 or a negative error code if there is a problem.
  *
-- 
2.26.2

