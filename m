Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD834B160F
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 20:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343828AbiBJTQa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 14:16:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239426AbiBJTQ3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 14:16:29 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A2810BA
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 11:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=c5plFfXSJGJvXMuakN5YQNG7N6i55QikVaWkGFkmYFQ=;
        t=1644520590; x=1645730190; b=Ny7L5S2PgfnDM72bVxWZVw/LQlkeR1y0roOrO7ZOVgQYo5q
        TRcWFiFZ8ielGjwn8QJ92UN5dabkfkhFoCYgnTT5NVgRH4kabOscDn92sjD1jg4oD75yDq4DvAVT6
        HqLJZvt0IV7WxPt/Xq8lOFQZaaXZMeswGIMB1QULcSm3/sN9kvWngDYnC1CzioPz2Y5IeFYd9KToG
        OoK6oCOXcGK2iXUXNL33H1t6fC0qbPkAK2/InuOHqH3zFRtPtMQI83MFmay6sEJ4UUO5V7VeaBe6s
        TKZ2AzhFw6rcZAcD30qtEmhXHkqRe8MqE23DXy/40kPtIKh1FAt1LT1rt5zFwM5A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nIEva-00HBut-IP;
        Thu, 10 Feb 2022 20:16:26 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/3] mac80211: parse only HE capability elements with valid size
Date:   Thu, 10 Feb 2022 20:16:22 +0100
Message-Id: <20220210201537.852e802ffb22.I645ac1e2dc0ace223ef3e551cd5a71c88bd55e04@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220210191623.187684-1-johannes@sipsolutions.net>
References: <20220210191623.187684-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The code validates the HE capability element size later,
but slightly wrong, so use the new helper to do it right
and only accept it if it has a good size.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/util.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index abc29df6834c..1a8e18794387 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -973,8 +973,10 @@ static void ieee80211_parse_extension_element(u32 *crc,
 		}
 		break;
 	case WLAN_EID_EXT_HE_CAPABILITY:
-		elems->he_cap = data;
-		elems->he_cap_len = len;
+		if (ieee80211_he_capa_size_ok(data, len)) {
+			elems->he_cap = data;
+			elems->he_cap_len = len;
+		}
 		break;
 	case WLAN_EID_EXT_HE_OPERATION:
 		if (len >= sizeof(*elems->he_operation) &&
-- 
2.34.1

