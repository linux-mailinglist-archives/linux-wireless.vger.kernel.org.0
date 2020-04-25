Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE37D1B8792
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2020 17:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgDYP6v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Apr 2020 11:58:51 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:52231 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726112AbgDYP6u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Apr 2020 11:58:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587830330; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=VfzSEKa8INjrgpJphp/icSRqssKV41q2bbxPx27dF3Y=; b=nMwNTu39sXt9O7UDAR6lWv0GFx9vHvK6jJr4F9+0hOXbFqIe6I6peHLC3aq2m8Bdz+SKEZux
 KBAEWLXVzGB+cHzfw/CNb3rTJbU3Xf63vS50Dqa+/9+ksibCQgDKPjhhdXqA4gbiLCwthX76
 Wu7G3Py1anUP/E5s//kivBsOG8g=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea45e39.7f7080bebb58-smtp-out-n01;
 Sat, 25 Apr 2020 15:58:49 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 88DE6C433CB; Sat, 25 Apr 2020 15:58:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (37-130-184-238.bb.dnainternet.fi [37.130.184.238])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0786FC433BA;
        Sat, 25 Apr 2020 15:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0786FC433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 2/5] mac80211_hwsim: Random MAC address for a Management frame exchange
Date:   Sat, 25 Apr 2020 18:57:10 +0300
Message-Id: <20200425155713.25687-2-jouni@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200425155713.25687-1-jouni@codeaurora.org>
References: <20200425155713.25687-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Allow a temporary random MAC address to be used for a Management frame
exchange. This can be used to test pre-association GAS/ANQP exchanges
with random addresses.

Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/mac80211_hwsim.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 05e8203aa6d9..a05e9c778f21 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -535,6 +535,7 @@ struct mac80211_hwsim_data {
 		unsigned long next_start, start, end;
 	} survey_data[ARRAY_SIZE(hwsim_channels_2ghz) +
 		      ARRAY_SIZE(hwsim_channels_5ghz)];
+	u8 mgmt_tx_rand_addr[ETH_ALEN];
 
 	struct ieee80211_channel *channel;
 	u64 beacon_int	/* beacon interval in us */;
@@ -1006,7 +1007,9 @@ static bool mac80211_hwsim_addr_match(struct mac80211_hwsim_data *data,
 		.ret = false,
 	};
 
-	if (data->scanning && memcmp(addr, data->scan_addr, ETH_ALEN) == 0)
+	if ((data->scanning && ether_addr_equal(addr, data->scan_addr)) ||
+	    (is_valid_ether_addr(data->mgmt_tx_rand_addr) &&
+	     ether_addr_equal(addr, data->mgmt_tx_rand_addr)))
 		return true;
 
 	memcpy(md.addr, addr, ETH_ALEN);
@@ -1507,6 +1510,12 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 		return;
 	}
 
+	if (txi->control.vif &&
+	    !ether_addr_equal(hdr->addr2, txi->control.vif->addr))
+		memcpy(data->mgmt_tx_rand_addr, hdr->addr2, ETH_ALEN);
+	else
+		eth_zero_addr(data->mgmt_tx_rand_addr);
+
 	if (txi->control.vif)
 		hwsim_check_magic(txi->control.vif);
 	if (control->sta)
@@ -3060,6 +3069,7 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 			       NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_BEACON_PROTECTION);
+	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_MGMT_TX_RANDOM_TA);
 
 	hw->wiphy->interface_modes = param->iftypes;
 
-- 
2.20.1
