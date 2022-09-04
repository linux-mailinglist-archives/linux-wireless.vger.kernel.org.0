Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6923A5AC61F
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Sep 2022 21:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbiIDT3b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Sep 2022 15:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbiIDT3Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Sep 2022 15:29:25 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2902DA
        for <linux-wireless@vger.kernel.org>; Sun,  4 Sep 2022 12:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=fytnCUKCbNn7Hbwcfdt5RIzV+GHQLDDLBdh6jR3p+WI=;
        t=1662319761; x=1663529361; b=d8NRcp4HHNJcvk/wcwOuJrJC8iIrjHUl2bCtlHSvTVnVAKA
        z1AYcThLRcITkQ/Xyu8cvZnL7jO5nfPMXTzL1asbGSg8gm8MrAs2tN9N/VMqS/Y6hLC3J13NvTpuU
        yrNGKX1pjeugsiWTcMk/wP/RPBmGcEBYRN/tKKmWFC5usScyH03Zxv7as48/rMIiqxgL3F/8nbmlR
        ZmuMoQVJ5E86HmymT/GhccLMjoKiDR54crV3sMM1A291TzTuCWCdQN/dDXtVYqLp24HIlnxPNB98Z
        bsNAHYGDc/fL3Y/HzhcBLbbd10bU/3Ctt64gK+xap9mdXxnKNWNe/0Zzro9+jRcA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oUvIz-007pTZ-2o;
        Sun, 04 Sep 2022 21:29:17 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 04/12] wifi: rndis_wlan: fix array of flexible structures warning
Date:   Sun,  4 Sep 2022 21:29:04 +0200
Message-Id: <20220904212910.0e7ce5fdbcfb.I972158734def3f93b93a3858a087cbc2cca6337e@changeid>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220904212910.8169e8c9090c.I0357e80cc86be2d4ac6205d1f53568444dcf7c9b@changeid>
References: <20220904212910.8169e8c9090c.I0357e80cc86be2d4ac6205d1f53568444dcf7c9b@changeid>
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

Use "u8 bssid_data[]" with an appropriate cast. No binary
changes.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/rndis_wlan.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/rndis_wlan.c b/drivers/net/wireless/rndis_wlan.c
index 325933217b41..82a7458e01ae 100644
--- a/drivers/net/wireless/rndis_wlan.c
+++ b/drivers/net/wireless/rndis_wlan.c
@@ -251,7 +251,7 @@ struct ndis_80211_bssid_ex {
 
 struct ndis_80211_bssid_list_ex {
 	__le32 num_items;
-	struct ndis_80211_bssid_ex bssid[];
+	u8 bssid_data[];
 } __packed;
 
 struct ndis_80211_fixed_ies {
@@ -2084,7 +2084,8 @@ static int rndis_check_bssid_list(struct usbnet *usbdev, u8 *match_bssid,
 	netdev_dbg(usbdev->net, "%s(): buflen: %d\n", __func__, len);
 
 	bssid_len = 0;
-	bssid = next_bssid_list_item(bssid_list->bssid, &bssid_len, buf, len);
+	bssid = next_bssid_list_item((void *)bssid_list->bssid_data,
+				     &bssid_len, buf, len);
 
 	/* Device returns incorrect 'num_items'. Workaround by ignoring the
 	 * received 'num_items' and walking through full bssid buffer instead.
-- 
2.37.2

