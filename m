Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549454AA2B0
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 23:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245218AbiBDWDD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 17:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242141AbiBDWDC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 17:03:02 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FCEC06173E
        for <linux-wireless@vger.kernel.org>; Fri,  4 Feb 2022 14:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=vtsKOx9XNdKQUx1Dq9uJVWySVPRWa0rDd9Le+HJM1N0=;
        t=1644012182; x=1645221782; b=bvcIgQNhqQBICl5wlTPaI4dzT1AxgSPFtAh7QDfh/sboHr/
        HwFgOpz5M4f85ZQzr3N38h/6j5SB8Vq3FIrZYZyNeihVHpMj1rSbaGSLR3o3Ip0kuJVxETSj8zpQR
        KCQNAr9Y+sWKHy7BHbGMgYji4i6ByZNOmOY+Yq2gcF9RJfMPhyzJ/HM5AZWKeAOsb4msHywxnM9Dl
        ZQfRp/wRUTPxd0bAhAXVuvic7lcF+U/irUtqAVEt03N/7M9/DvTyPDFsYfJCDhsYhcsFu3JxpkJVF
        scPtZIZugh3fDz8gjT+GfWaDCEGsIunpHA0HDmKMSAEUOXTF9wjcqhbT5xMmTbig==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nG6fU-00EeJL-6P;
        Fri, 04 Feb 2022 23:03:00 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>,
        Ilan Peer <ilan.peer@intel.com>,
        Jia Ding <quic_jiad@quicinc.com>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Sriram R <quic_srirrama@quicinc.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 02/19] mac80211_hwsim: don't shadow a global variable
Date:   Fri,  4 Feb 2022 23:02:38 +0100
Message-Id: <20220204230119.cf7fa7622a89.I3e878e42bf2feecbb0a6ca38a68c236c23a8c9e6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204220255.448224-1-johannes@sipsolutions.net>
References: <20220204220255.448224-1-johannes@sipsolutions.net>
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
index 1fcc2000950b..aa839b395497 100644
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

