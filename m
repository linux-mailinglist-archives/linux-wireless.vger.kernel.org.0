Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66941386B3A
	for <lists+linux-wireless@lfdr.de>; Mon, 17 May 2021 22:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239054AbhEQUVo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 May 2021 16:21:44 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:30380 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239230AbhEQUVf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 May 2021 16:21:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621282818; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=evetBr2LoPcsAtJOO4x2/sHwtO2JekH1EHkfeEUO7ms=; b=c1KEi2PuKdLeL4VAE8ypBRYAFSKDaSN+B4f7k9rtAj+UqLAwjuA8D09PmxJLzaqFAeg912Ff
 WLX+Kk7CAGucOtAQHLDX8nWwca//Vrgbb33sGkfWRQJgwOIE9yQnDuQDplx49Sb4dRPouO8K
 XvlXYwXCZrfweeiDZeYT+XypxuI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 60a2d001063320cd131009a4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 17 May 2021 20:20:17
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4CDEFC433D3; Mon, 17 May 2021 20:20:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DA4F9C43460;
        Mon, 17 May 2021 20:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DA4F9C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath11k@lists.infradead.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH 8/9] mac80211: add transmit power envelope element and power constraint in bss_conf
Date:   Mon, 17 May 2021 16:19:31 -0400
Message-Id: <20210517201932.8860-9-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517201932.8860-1-wgong@codeaurora.org>
References: <20210517201932.8860-1-wgong@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch is to add definition of transmit power envelope element and
power constraint in struct ieee80211_bss_conf for 6GHz.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 include/net/mac80211.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 2d1d629e5d14..1e9d3650fbc4 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -631,6 +631,9 @@ struct ieee80211_fils_discovery {
  * @s1g: BSS is S1G BSS (affects Association Request format).
  * @beacon_tx_rate: The configured beacon transmit rate that needs to be passed
  *	to driver when rate control is offloaded to firmware.
+ * @tx_pwr_env: transmit power envelope array of BSS.
+ * @tx_pwr_env_num: number of @tx_pwr_env.
+ * @pwr_reduction: power constraint of BSS.
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
@@ -700,6 +703,9 @@ struct ieee80211_bss_conf {
 	u32 unsol_bcast_probe_resp_interval;
 	bool s1g;
 	struct cfg80211_bitrate_mask beacon_tx_rate;
+	struct ieee80211_tx_pwr_env tx_pwr_env[IEEE80211_TPE_MAX_IE_COUNT];
+	u8 tx_pwr_env_num;
+	u8 pwr_reduction;
 };
 
 /**
-- 
2.31.1

