Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0AE93C6445
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jul 2021 21:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbhGLT4d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Jul 2021 15:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbhGLT4d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Jul 2021 15:56:33 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00705C0613DD
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jul 2021 12:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=L9yzJbOkUoG3OPTnghxBDJO1uipunb8Z7Cf8ziV+o0I=; t=1626119625; x=1627329225; 
        b=uT0Me1yf1gcKpem/4PlO3C6KKLT906Udlc8Hw1cgQqxeRC79uEXdR0UYWcG/jZfdHJWCIsFY91z
        AlffiBzngDdGOuBBjWU8EnnRcHPEybfK6SP7PSUnhxb9PzhITpn0uD5DkYavXBUiUJ9/upW/kmm24
        BJAUpGYc9Ky5LMm9zL8rYJiIw09mn5/EeUkalIkQScAgey9ioOXg5B5WMeIwMn1beZBCN1+dHRFH5
        W4JNYJhU0GkQa8pwDIZyIjwNOrUsZ72sFoMo06u92+S2gJBeZaq6Dpxikkeb/1uAL9wEzGIJd5iCD
        tuGgHQp3XKxOIYW/iqweWdrvL8ibcQZJw10g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1m31zk-001U88-JD; Mon, 12 Jul 2021 21:53:36 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] nl80211: limit band information in non-split data
Date:   Mon, 12 Jul 2021 21:53:30 +0200
Message-Id: <20210712215329.31444162a2c2.I5555312e4a074c84f8b4e7ad79dc4d1fbfc5126c@changeid>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In non-split data, we shouldn't be adding S1G and 6 GHz
data (or future bands) since we're really close to the
4k message size limit. Remove those bands, any modern
userspace that can use S1G or 6 GHz should already be
using split dumps, and if not then it needs to update.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 50eb405b0690..395a233eb612 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2351,7 +2351,10 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 			goto nla_put_failure;
 
 		for (band = state->band_start;
-		     band < NUM_NL80211_BANDS; band++) {
+		     band < state->split ?
+				NUM_NL80211_BANDS :
+				NL80211_BAND_60GHZ + 1;
+		     band++) {
 			struct ieee80211_supported_band *sband;
 
 			/* omit higher bands for ancient software */
-- 
2.31.1

