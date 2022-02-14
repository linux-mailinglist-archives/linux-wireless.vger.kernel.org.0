Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108434B562A
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Feb 2022 17:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356359AbiBNQ3j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 11:29:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356356AbiBNQ3i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 11:29:38 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A5AC73
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 08:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=c5plFfXSJGJvXMuakN5YQNG7N6i55QikVaWkGFkmYFQ=;
        t=1644856170; x=1646065770; b=tJJ+GpIdwnFxIg4JLyT+3gp+UsOLasWmSG47MGRcJyt6OPL
        Ubh1/mnYskcW1clEUizwgeKkZAjnnj+YggPMGbNodthcy41XSgjQ2yEMhEhpkwQScRXYX760GJ90B
        UirzHessQYCSEq4JPTNnMNbQooVh6bLefmBQk0YQlac/aRvWNuq0YH/dkCfRffW8nZ2VpcpYKojwL
        U8GBJhMEsoG7SWw5ksPj1rilKwXANX9ma04B09+iAPdsDR87P2eAH2E4YpRSpe2udZQ+5rPDgr6Z0
        VavyqHDdca8+1sWSQt6QUgcAfsGKQz/osKOIt0SxGOxiket+xOPgigsTE0Euoelw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nJeEB-0011jK-Hw;
        Mon, 14 Feb 2022 17:29:27 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 2/3] mac80211: parse only HE capability elements with valid size
Date:   Mon, 14 Feb 2022 17:29:22 +0100
Message-Id: <20220214172920.b5b06f264a61.I645ac1e2dc0ace223ef3e551cd5a71c88bd55e04@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220214172920.750bee9eaf37.Ie18359bd38143b7dc949078f10752413e6d36854@changeid>
References: <20220214172920.750bee9eaf37.Ie18359bd38143b7dc949078f10752413e6d36854@changeid>
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

