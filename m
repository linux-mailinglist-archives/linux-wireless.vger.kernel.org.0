Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AE3738332
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 14:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbjFUMGO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 08:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjFUMGG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 08:06:06 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EB81BEF;
        Wed, 21 Jun 2023 05:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=eXNGbaU61EwoS23wrTMtGmzgg8KS+S58oSW7W2/6C08=; t=1687349149; x=1688558749; 
        b=mXSTFVvsBY8gHoZhuUjb01jjjfQWq1uAFCydIAtNP3gy8je1oDjhfaRzEEv61EGSirffD0A7z91
        uk1F9MrkXcOuIejzhg2Np6Z2KHSF9lrEw6Z+Afh4wmqIhCbDwrhijESv3ZLbso22h6/lt2YHZ1xgh
        tMkSCBU0znSSmd2wRs7GdiRYpwozj/JXwu5pU1eVoyEaBDlTrcTeZ1NPpa+AKmOkmF8bBFlMjaiKU
        sHgXZB2EGuzdsyuM97FSFluer2xHGCUTVK7Wnz8TMAmBC+6LbhH9tnZQkEi2WeUl34kQIOxtHnCQ4
        Yo5KNrnpr1Rldq1/EKJPjYJpf7QRaNynzw3g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qBwao-00DeSb-1U;
        Wed, 21 Jun 2023 14:05:46 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Cc:     Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH net] wifi: mac80211: report all unusable beacon frames
Date:   Wed, 21 Jun 2023 14:05:44 +0200
Message-ID: <20230621120543.412920-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Benjamin Berg <benjamin.berg@intel.com>

Properly check for RX_DROP_UNUSABLE now that the new drop reason
infrastructure is used. Without this change, the comparison will always
be false as a more specific reason is given in the lower bits of result.

Fixes: baa951a1c177 ("mac80211: use the new drop reasons infrastructure")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
Another straggler for net, please, so we don't have this regression
in 6.4. If it's too late now, I'll take it through wireless for the
next version.
---
 net/mac80211/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index e579581441de..4f707d2a160f 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2110,7 +2110,7 @@ ieee80211_rx_h_decrypt(struct ieee80211_rx_data *rx)
 	/* either the frame has been decrypted or will be dropped */
 	status->flag |= RX_FLAG_DECRYPTED;
 
-	if (unlikely(ieee80211_is_beacon(fc) && result == RX_DROP_UNUSABLE &&
+	if (unlikely(ieee80211_is_beacon(fc) && (result & RX_DROP_UNUSABLE) &&
 		     rx->sdata->dev))
 		cfg80211_rx_unprot_mlme_mgmt(rx->sdata->dev,
 					     skb->data, skb->len);
-- 
2.41.0

