Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C75573359
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiGMJqY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236209AbiGMJpa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A05BC04F4
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=4EP6jGLBQKZKgdD/VOKX7mPjEE6XduW9Buc5D9UEsd4=;
        t=1657705524; x=1658915124; b=Fe5B6P17DwSupV1cdVrv5rZTrzWbAq2yjWdOXnnUq7ZqjXe
        hJjGPJoVk6zLCYbM+kKY3cpjzzhrcBdfB1ghrs4InxdoR06tFfrtqJ7vhg6qteGHlKRnNxKtIxOet
        AUSMPbWA/li3AVa6jYYecNGNUV5D4CCtARm7iJIAh2bzcT9DssE9L65014CINHYvIxdxOWvlc62Jf
        0SIctHxH46DGxjyCwsVU1BNVBsq6DzOYA9dOt9QU+PB93sGWvAgBAnGHLyC97Wh8/6rFQ8qT+i09u
        fdqd7bptsG/5DxRbmbDabP8Mbb7zxOI1r0T3PNcNA+Q7ggFniGOGuMiWfb0Oxm4w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvq-00EgvB-Dw;
        Wed, 13 Jul 2022 11:45:22 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 50/76] wifi: mac80211: remove redundant condition
Date:   Wed, 13 Jul 2022 11:44:36 +0200
Message-Id: <20220713114425.9ce50552c12a.I76913759932eba1c2c5ec770923b10450c991323@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
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

Here, ext_capa is checked and can only be non-NULL if
assoc_data->ie_len was set before, so the check here
is redundant.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index d4a54375b9d2..fd8d7545a896 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -981,7 +981,7 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 
 	/* Set MBSSID support for HE AP if needed */
 	if (ieee80211_hw_check(&local->hw, SUPPORTS_ONLY_HE_MULTI_BSSID) &&
-	    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE) && assoc_data->ie_len &&
+	    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE) &&
 	    ext_capa && ext_capa->datalen >= 3)
 		ext_capa->data[2] |= WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT;
 
-- 
2.36.1

