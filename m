Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6AEA1B8796
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2020 17:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgDYP7F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Apr 2020 11:59:05 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:16943 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726112AbgDYP7F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Apr 2020 11:59:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587830344; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=U+TfE8ikUk3stSImxYeyaeIGxUNayKE7vc1B0dKRpQ0=; b=k67NUWmuPd3Y7hQ7FVkgEjkuHcDq043qpmda0aOQnvwgHSerJ6kKEAk6gCjz2SdTzcstdigW
 gxbYhWteTGYuio81VoYGfkMgeLd4fsaB7G/cBYPRpnVLw01VUbzSC3Wcqk6FqoPfxc8rozk8
 jX7IrHxg9ahvU0k0faxK6myT2Lw=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea45e3f.7efd18506618-smtp-out-n02;
 Sat, 25 Apr 2020 15:58:55 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0FD1BC433CB; Sat, 25 Apr 2020 15:58:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (37-130-184-238.bb.dnainternet.fi [37.130.184.238])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D5C3FC432C2;
        Sat, 25 Apr 2020 15:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D5C3FC432C2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 5/5] mac80211_hwsim: Claim support for setting Beacon frame TX legacy rate
Date:   Sat, 25 Apr 2020 18:57:13 +0300
Message-Id: <20200425155713.25687-5-jouni@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200425155713.25687-1-jouni@codeaurora.org>
References: <20200425155713.25687-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mac80211 takes care of rate control for the Beacon frames, so all
mac80211_hwsim needs to do here is advertise support for this.

Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/mac80211_hwsim.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index bd67de740a65..8a0fd2474d5e 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3074,6 +3074,8 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_MGMT_TX_RANDOM_TA);
 	wiphy_ext_feature_set(hw->wiphy,
 			      NL80211_EXT_FEATURE_MULTICAST_REGISTRATIONS);
+	wiphy_ext_feature_set(hw->wiphy,
+			      NL80211_EXT_FEATURE_BEACON_RATE_LEGACY);
 
 	hw->wiphy->interface_modes = param->iftypes;
 
-- 
2.20.1
