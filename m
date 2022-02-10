Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D674B162B
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 20:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343906AbiBJTUZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 14:20:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343887AbiBJTUV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 14:20:21 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC2A115D
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 11:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=232J5opRknVgL6kR4s6AMD0FxBtYxtdEUz74hq0vMbw=;
        t=1644520820; x=1645730420; b=gUi41AVfNo3OS5KQRzsvKmtM8XG+TMEsUwD/itueY6iqkKE
        9kfCmxpozkHtvCPMZhtPSpuaLQHGVgPnAzLRNQCJBJ5NqwZWxCRXa8CTDQ4foQ9FoLm94VhELSJ7i
        ZXuAscwLaPqRzRao7Kj4KX+5YpRT/1Hhj4hHhu2vjXx/2zPrk3QHh37dDGayrH//Y4gO5T7dj5GDO
        hRjkXy2bgv+uGX5tqyI5UYDLL5lLuFSq2N02DwcegtqLgR1NMDxdxwCnzHYZZkbclyl3w4BzDxyXM
        1+IXhXojOxVKp2zUjDzgq4TbnEAnP+LJzF2Mbt2T5TF5565hvUpY1nnhyWBbGO3g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nIEzK-00HC2X-Af;
        Thu, 10 Feb 2022 20:20:18 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     quic_vikram@quicinc.com, quic_alokad@quicinc.com,
        quic_jiad@quicinc.com, quic_periyasa@quicinc.com,
        quic_msinada@quicinc.com, quic_srirrama@quicinc.com,
        ilan.peer@intel.com, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 02/19] mac80211_hwsim: don't shadow a global variable
Date:   Thu, 10 Feb 2022 20:19:51 +0100
Message-Id: <20220210201853.bb74adedb8b5.I3e878e42bf2feecbb0a6ca38a68c236c23a8c9e6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220210192008.188166-1-johannes@sipsolutions.net>
References: <20220210192008.188166-1-johannes@sipsolutions.net>
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

The argument to hwsim_init_s1g_channels() shadows a global,
change that to be clearer.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 2cf328344cb5..92e055ee0bb9 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -475,16 +475,16 @@ static const struct ieee80211_sta_s1g_cap hwsim_s1g_cap = {
 		     0 },
 };
 
-static void hwsim_init_s1g_channels(struct ieee80211_channel *channels)
+static void hwsim_init_s1g_channels(struct ieee80211_channel *chans)
 {
 	int ch, freq;
 
 	for (ch = 0; ch < NUM_S1G_CHANS_US; ch++) {
 		freq = 902000 + (ch + 1) * 500;
-		channels[ch].band = NL80211_BAND_S1GHZ;
-		channels[ch].center_freq = KHZ_TO_MHZ(freq);
-		channels[ch].freq_offset = freq % 1000;
-		channels[ch].hw_value = ch + 1;
+		chans[ch].band = NL80211_BAND_S1GHZ;
+		chans[ch].center_freq = KHZ_TO_MHZ(freq);
+		chans[ch].freq_offset = freq % 1000;
+		chans[ch].hw_value = ch + 1;
 	}
 }
 
-- 
2.34.1

