Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011F94B160E
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 20:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343827AbiBJTQ3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 14:16:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343826AbiBJTQ3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 14:16:29 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F400F110C
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 11:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=mggAmGFZLWmvhUdf69OytcV2qfVXAIr7jQA86Z4BZbQ=;
        t=1644520590; x=1645730190; b=nB7Cnf2ER7gsDXHLfrDtme+gt0hWfQntpZcSQUuavzRf6Wv
        pOd/RpRhGiTKwgVi8hACtbtPkEMCdzGz38NSpGlOIOjHNPi8TORHmH8NDPb5o984s13ZNKTRBi7y8
        DqNZpFx0P+cTEQvPhlZxD3k5NHPKhOk4b5+aRAfVnH/Z/llmuaGgcmyTnWvyyt5pkH6D35BRS7zPd
        bVpmTgoXDEISvWnvCRHwOWq5yW+OOsgF2PAJFktojUxj+V5fuR5xNOim8iKsT0jXs7UtO1RwX+rce
        7TCfm2OS1BXIAUfSOAGd3EQtYl5AbaBkyzYkKK86PlMs0+4Ea/Ds9UdmUMY+zvww==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nIEva-00HBut-QT;
        Thu, 10 Feb 2022 20:16:26 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/3] nl80211: accept only HE capability elements with valid size
Date:   Thu, 10 Feb 2022 20:16:23 +0100
Message-Id: <20220210201537.222c999d7585.Id57ce32f9538a40e36c620fabedbd2c73346ef56@changeid>
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

The kernel (driver code) should be able to assume that a station's
HE capabilities are not badly sized, so reject them if they are.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 578bff9c378b..19b74a5ca300 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6308,6 +6308,11 @@ int cfg80211_check_station_change(struct wiphy *wiphy,
 	    statype != CFG80211_STA_AP_CLIENT_UNASSOC)
 		return -EINVAL;
 
+	if (params->he_capa &&
+	    !ieee80211_he_capa_size_ok((const void *)params->he_capa,
+				       params->he_capa_len))
+		return -EINVAL;
+
 	/* When you run into this, adjust the code below for the new flag */
 	BUILD_BUG_ON(NL80211_STA_FLAG_MAX != 7);
 
-- 
2.34.1

