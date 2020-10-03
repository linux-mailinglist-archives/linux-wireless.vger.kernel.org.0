Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C728282700
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Oct 2020 00:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgJCWE1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 3 Oct 2020 18:04:27 -0400
Received: from z5.mailgun.us ([104.130.96.5]:19685 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbgJCWE1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 3 Oct 2020 18:04:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601762666; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=OBPZU7QlKpVIpTcfArTWNKBnEUoBdoVFUz3CA7QZuJM=; b=NcgmBxx0Kq/cXI8+JC2HRAK05gkKX6YNiEtDRdIJk8f5a0cnfASjj+ewA/PbtKTN8Q4kOi0n
 waMgfFZruW0PpEdOd0me4J0Zogxy/r/7UjEkXPF2C+JC0cuIilrWeBRVR68hdakx5DYVb7/P
 BhdQIZsugGQZ0Mkj6CHt9acwT80=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f78f56abfed2afaa67efb41 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 03 Oct 2020 22:04:26
 GMT
Sender: rmanohar=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2C6CFC433CB; Sat,  3 Oct 2020 22:04:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from rmanohar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 36FF3C433CA;
        Sat,  3 Oct 2020 22:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 36FF3C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rmanohar@codeaurora.org
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Rajkumar Manoharan <rmanohar@codeaurora.org>
Subject: [PATCH] mac80211: allow configured beacon tx rate to driver
Date:   Sat,  3 Oct 2020 15:04:18 -0700
Message-Id: <1601762658-15627-1-git-send-email-rmanohar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The user is allowed to change beacon tx rate (HT/VHT/HE) from hostapd.
This information needs to be passed to the driver when the rate control
is offloaded to the firmware. The driver capability of allowing beacon
rate is already validated by hostapd, so simply passing the rate
information to the driver is enough.

Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
---
 include/net/mac80211.h | 3 +++
 net/mac80211/cfg.c     | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 4747d446179a..e8e295dae744 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -628,6 +628,8 @@ struct ieee80211_fils_discovery {
  * @unsol_bcast_probe_resp_interval: Unsolicited broadcast probe response
  *	interval.
  * @s1g: BSS is S1G BSS (affects Association Request format).
+ * @beacon_tx_rate: The configured beacon transmit rate that needs to be passed
+ *	to driver when rate control is offloaded to firmware.
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
@@ -698,6 +700,7 @@ struct ieee80211_bss_conf {
 	struct ieee80211_fils_discovery fils_discovery;
 	u32 unsol_bcast_probe_resp_interval;
 	bool s1g;
+	struct cfg80211_bitrate_mask beacon_tx_rate;
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index da70f174d629..e3334afa85b0 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1153,6 +1153,9 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 		}
 	}
 
+	if (ieee80211_hw_check(&local->hw, HAS_RATE_CONTROL))
+		sdata->vif.bss_conf.beacon_tx_rate = params->beacon_rate;
+
 	err = ieee80211_assign_beacon(sdata, &params->beacon, NULL);
 	if (err < 0)
 		goto error;
-- 
2.7.4

