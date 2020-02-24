Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9648616A02E
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2020 09:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgBXIiZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Feb 2020 03:38:25 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:56738 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbgBXIiY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Feb 2020 03:38:24 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j69Fs-00659g-IK; Mon, 24 Feb 2020 09:38:20 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] nl80211: explicitly include if_vlan.h
Date:   Mon, 24 Feb 2020 09:38:15 +0100
Message-Id: <20200224093814.1b9c258fec67.I45ac150d4e11c72eb263abec9f1f0c7add9bef2b@changeid>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We use that here, and do seem to get it through some recursive
include, but better include it explicitly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d795552f97b2..6f2460478c3c 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -20,6 +20,7 @@
 #include <linux/netlink.h>
 #include <linux/nospec.h>
 #include <linux/etherdevice.h>
+#include <linux/if_vlan.h>
 #include <net/net_namespace.h>
 #include <net/genetlink.h>
 #include <net/cfg80211.h>
-- 
2.24.1

